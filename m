Return-Path: <stable+bounces-269398-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WqOfJN77P2rwawkAu9opvQ
	(envelope-from <stable+bounces-269398-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 18:35:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C006D248E
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 18:35:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CReMyhSD;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269398-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269398-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45D02300CC3E
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 16:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECFC3115AE;
	Sat, 27 Jun 2026 16:35:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F06D2701DC;
	Sat, 27 Jun 2026 16:35:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782578137; cv=none; b=ExbgBXC0Eq6lltmBL+i3E9bdXkVtBFQ9mtYo8SFRz8sE4XVwP2r/oTcm/WUMCL3eaAlHRo9A2kz91ItvXiJp8G1xRtkFHxoRDUCAmUB2nJc/MDdVV27gwTqaW6jgBiAfm0/SndCHc1XJK012c9pOhWLtdlIRJb9Cvz3eYSQ4yaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782578137; c=relaxed/simple;
	bh=JDqATDG7YNAzCMf+80Z1zGlzNEfShKBx7VoZq8JM1wU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i42g5xZFCvNyGja5/3z9FKqusRTXxjBVXLZFzboWTdALvmftAVuIIuDNG4J38PSvDELQxt7HgYeQWMBaB+VDxvz1bFw3tXTp6Wz80Z4dQUu5DvrVjznLO3z12Wd/ye+nuVQELXDMblAd8ZLHton3ykZ9PtMeILZxQghTR9Gepdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CReMyhSD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6018E1F000E9;
	Sat, 27 Jun 2026 16:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782578136;
	bh=6dAN2gFUrWYuJCTysU1oLdEdPytBC2n2+gDMLWQW3sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CReMyhSDSoH6iThdRcSXpCGszEQsISpAQQWNTbEYBJtgf0imxEx8aiAyFdRJM6XpQ
	 Frb8x9R/w2ZUDSAIk/88/xbb0BdnhwsMjptxVCKb6WYqwkkXrSkKkZY312aNvNGK1V
	 hWGChOIE6nKv1hju910+nLppJevizNKiBhu5L8SfFMDa5L/kcxJM4CuFd0H6EoRWQJ
	 cRvw2GH3CE+155BmNZtQ110U5aHczuEr+oz2SAm0c6/ByY+CfeVGPfPYdS4QoA4jS0
	 9Nx7vJ36J8VWWjv2JdBBctjyF24/HKFrz0N9My24kViONgN5JY4ZTCzYEvoT2eOvUp
	 UcqkV18HrQicA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	tristan@talencesecurity.com,
	pav@iki.fi,
	luiz.von.dentz@intel.com,
	linux-bluetooth@vger.kernel.org,
	Siva Balasubramanian <sivakumar.bs@gmail.com>
Subject: Re: [PATCH 0/2] Bluetooth: btmtk: WMT event length validation (CVE-2026-46140) - 6.6.y backport
Date: Sat, 27 Jun 2026 12:35:24 -0400
Message-ID: <stable-reply-item008-btmtk-66-20260627162226@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626104604.3465124-1-sivakumar.bs@gmail.com>
References: <20260626104604.3465124-1-sivakumar.bs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-269398-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,talencesecurity.com,iki.fi,intel.com,vger.kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:tristan@talencesecurity.com,m:pav@iki.fi,m:luiz.von.dentz@intel.com,m:linux-bluetooth@vger.kernel.org,m:sivakumar.bs@gmail.com,m:sivakumarbs@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17C006D248E

On Fri, 26 Jun 2026 16:16 +0530, Siva Balasubramanian <sivakumar.bs@gmail.com> wrote:
> [PATCH 0/2] Bluetooth: btmtk: WMT event length validation (CVE-2026-46140) - 6.6.y backport
> Please consider the following two upstream commits for 6.6.y.

Both patches queued for 6.6.

-- 
Thanks,
Sasha

