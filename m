Return-Path: <stable+bounces-260109-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ulyIME5HIGrxzwAAu9opvQ
	(envelope-from <stable+bounces-260109-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 17:25:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E399639238
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 17:25:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SPZ3ToqB;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260109-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260109-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5986327E2BE
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 15:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7633A961E;
	Wed,  3 Jun 2026 15:14:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBC73B4439;
	Wed,  3 Jun 2026 15:14:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499675; cv=none; b=MrM+DNyvGrlS4DOfLElG197Q2Im7HKvx0nwS9sk6ai2914vpGwCOotOBOuBIHlG3AxWhESTaGWX8Xcl5EYcrpXODmsBoNVVt8lF+jrEsOIBgdJbWpRrqn9+YUlAdAWvrn/PbFAn0mviEqDfmdS00V0At2Gk2KFBQ+W44uSfDaBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499675; c=relaxed/simple;
	bh=ABUHQQBtP8a2eT0meSyoQC1tKOfWe0IBUxX77BCvL38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ginm2tG/5D9PhJXoh25PAADuvNhEfaSQKnrEas8m9nQoTl1yTP9/dsGdc/yZmHGMg87qumMCbVfiglKklNefgpRe1ob8W9kqHN3JPHLdWyIWdkaYsYbcH1TBwBOIjU8WwAt+pzMBA7g6bHxQBLy4Vg7I89ge8HjiV3P6uJfMpi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPZ3ToqB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1831F00899;
	Wed,  3 Jun 2026 15:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499674;
	bh=EWOwp7Yrnu95fd6AMzKTYBWJxuxNBPzz8DT7EZJjsFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SPZ3ToqBaLNlmwrcHRInhHtj25Q9O1kVnHhi5JZJJG2nmJ0avEwFZeVOcyrCWkD8B
	 fMfvGOQxsvxc9kLnyDYeQ0ajGnu0p1wkMpEAVUhW9NX+x2LssTEDmC/kPgV65mm2la
	 PFYhRYs2cmRH4CCtfCgg8DQuJLtIqZSkG0Tmybs6MaJZsFvUytguWnm7H0eqSmY237
	 4vEn/wuZ0RLRTHRju/F19WclKJaCeLUmUElkJ5YjWxdBtF+17w2vqRsklxsevUUcld
	 nEe+iSYjQEt0cO+2JWy/MOHcPIU44pz8anJGMvZzXcUmTtBHz+SFbIsfeZDYjokinE
	 F7UKKwcj9qTBQ==
From: Sasha Levin <sashal@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	criu@lists.linux.dev,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Andrei Vagin <avagin@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/5] Revert "x86/fpu: Refine and simplify the magic number check during signal return"
Date: Wed,  3 Jun 2026 11:13:59 -0400
Message-ID: <20260603111500.item003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526205047.3339490-2-avagin@google.com>
References: <20260526205047.3339490-2-avagin@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:tglx@kernel.org,m:mingo@redhat.com,m:sashal@kernel.org,m:linux-kernel@vger.kernel.org,m:criu@lists.linux.dev,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:avagin@google.com,m:hpa@zytor.com,m:chang.seok.bae@intel.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260109-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E399639238

Queued for 7.0.y and 6.18.y, thanks.

-- 
Thanks,
Sasha

