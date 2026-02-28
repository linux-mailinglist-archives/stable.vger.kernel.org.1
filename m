Return-Path: <stable+bounces-220112-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JkAMZ8oo2k++AQAu9opvQ
	(envelope-from <stable+bounces-220112-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:40:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6020F1C5043
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DBE9330BB43E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37D847DFB7;
	Sat, 28 Feb 2026 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qoiJQxLt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DB747DFBA;
	Sat, 28 Feb 2026 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300023; cv=none; b=sDt1kHtA/TDwO4usZjU2zpEysjryXM3a37v8M+uYSVBgr/iikhiSSqbcjoHuklk2JhwV+sClVb1fomY0VxM6AnaE9F7AUEfnAbEnGDKwrkOr6vgHuTYyCkkwt7TTpyVYzn+sFEBebX9AUWLEkQdjymt+mR2XKWGkCuQiCrNaT4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300023; c=relaxed/simple;
	bh=jm33/dDTMaejT8REIMFgGYTEkQhfYT6Fqs3geYv2D4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=irr7/fq4IcEP0EDamajGxkjB2XCeMRMFjBD1LUZF3pKQt7F2edeGd6z47D7bHRbIQhTQMjIXJZEiGGe8CEw/PB2RXuGsRv1ffh3/5aTvA4VU6mNgwncIkHr0qWjSFtqQruH/5sakl1Rxf1Y3ue2y+8HNTbGgluS5atjDtBsAcHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qoiJQxLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D35C19425;
	Sat, 28 Feb 2026 17:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300023;
	bh=jm33/dDTMaejT8REIMFgGYTEkQhfYT6Fqs3geYv2D4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qoiJQxLtJ4U3IeRjUoDxAmq99jaBThWRxiZhA20kYyGozzMNccqPSQyPa2yfj26CK
	 IyuafeeSH5bFfP8McN3DegCyeFrybxddgmiE739CcTxEVCyscZuuV+OlGMPYyAD8K/
	 KGNO3aq23Rc6/3OgZna41kyOWVI/hjpZ5UzYR9E2WVE+JpHu3TnSpu6yT3Xx3WISYz
	 503gnpYO0cFNno5AqcdlywgLVYnpVerJK49W97OX7uSZ82MTateSdnka4ctO281AfO
	 BfQu5VJL2tkkPkzDM9rL5Pid67tMmF2FREb2GNXbvKHZRwXfiQjK09oy/kWl1xu2RC
	 D8IO7tBsh2/Wg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bhavik Sachdev <b.sachdev1904@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 034/844] statmount: permission check should return EPERM
Date: Sat, 28 Feb 2026 12:19:07 -0500
Message-ID: <20260228173244.1509663-35-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,szeredi.hu,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220112-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,szeredi.hu:email]
X-Rspamd-Queue-Id: 6020F1C5043
X-Rspamd-Action: no action

From: Bhavik Sachdev <b.sachdev1904@gmail.com>

[ Upstream commit fccbe38a5d06dbe44bcd89196fe1d2c2272a1f4a ]

Currently, statmount() returns ENOENT when caller is not CAP_SYS_ADMIN
in the user namespace owner of target mount namespace. This should be
EPERM instead.

Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Bhavik Sachdev <b.sachdev1904@gmail.com>
Link: https://patch.msgid.link/20251129091455.757724-2-b.sachdev1904@gmail.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index c58674a20cad5..f6879f282daec 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5780,7 +5780,7 @@ SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
 
 	if (kreq.mnt_ns_id && (ns != current->nsproxy->mnt_ns) &&
 	    !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
-		return -ENOENT;
+		return -EPERM;
 
 	ks = kmalloc(sizeof(*ks), GFP_KERNEL_ACCOUNT);
 	if (!ks)
-- 
2.51.0


