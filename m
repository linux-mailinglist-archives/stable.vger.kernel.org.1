Return-Path: <stable+bounces-254666-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLyBKMNKF2r0/wcAu9opvQ
	(envelope-from <stable+bounces-254666-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:49:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4735E9A63
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D2A230512F4
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 19:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFC8311973;
	Wed, 27 May 2026 19:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YprWyi+g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4203B19A5;
	Wed, 27 May 2026 19:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911360; cv=none; b=YiA//j5+frlx+PkBpRHfiUmOUJ5N4qBLu6For+1aMGj1K+i5TSZcvPwBguW4A0Gi/nshXQ804Zj8pkItWp9bupfxi6d1CH9CRCvJL+ZGLjmxYtdwDl9x022tl26ejr2eDzNJv+GKrOEAnyvX20y+a4W+RLGAyRq+te5OBF0GGkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911360; c=relaxed/simple;
	bh=dEfUBCnhpcGcpegy5jGGPYMMti3b3I7lOSAnZZhcrt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oS6B8tOx3LChxt01WmXznnDMooeONkeQRAEtuElyYCKFhCmyLxPQONYEQyr+p67pNW0oITcFJ6ehPK9YwUYSznxaK/BLhup3WruqRPE7+q5ILfCBypvnuiLayIcIzfphoeDjS2sLQ48cfYAagrwPQZPTEm1RLZiE3Wf5axSs7tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YprWyi+g; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8811F00ACA;
	Wed, 27 May 2026 19:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779911359;
	bh=dEfUBCnhpcGcpegy5jGGPYMMti3b3I7lOSAnZZhcrt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YprWyi+g6TSJZ8QMDgOFMPfvUDUVNKMiarMBf13KTtLtmBY05nUqS99e21pt8rI6R
	 dFSFF3qRFZJUt0Kkcy+9rV5votVBrI7Xdd/WCAxVTIIKdqj6+y4xZ8qNjTbnsv9K+j
	 hr52HEQDpm4vh5K1tpQhstGUBJhuK3dibNFhv4zd3JNZX2pRZODVS7DOrGKWgDDDe6
	 TA0nM3AMJk9WLgSfG1TWop/iTZAvpt4fjl5QEopEWvLrZ61jR1dc+pH/tWXCTYvq4V
	 G0CJ09n0zvBs/FpQ968Nbfnm2wDB8Kon52COnifbqWe4NuFM+vXgcbz+YJo8TaLhHh
	 kDSp1DGYryPCQ==
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
Date: Wed, 27 May 2026 15:48:58 -0400
Message-ID: <20260527-agent5-item004-x86fpu@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526205047.3339490-2-avagin@google.com>
References: <20260526205047.3339490-1-avagin@google.com> <20260526205047.3339490-2-avagin@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254666-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3C4735E9A63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> This reverts commit dc8aa31a7ac2 ("x86/fpu: Refine and simplify the
> magic number check during signal return").
>
> The reverted commit broke applications that construct signal frames in
> userspace (such as CRIU and gVisor) if the frame's xstate size is
> smaller than the kernel's fpstate->user_size.

Holding this off on the stable side until the revert (and the rest of
the series) lands in mainline. Once it's upstream, please ping with the
mainline SHAs and the list of trees you want it on, and I'll queue it.

--
Thanks,
Sasha

