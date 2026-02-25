Return-Path: <stable+bounces-218257-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCsUBe9RnmmmUgQAu9opvQ
	(envelope-from <stable+bounces-218257-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:35:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2F118F132
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F06A9303D0CB
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30F91F03DE;
	Wed, 25 Feb 2026 01:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dfX5PqnK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8688A25228D;
	Wed, 25 Feb 2026 01:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983055; cv=none; b=BYYd8Kf2cVDiXNifFKxnr5sPAVvHKXfTNDbssJHZMpxuhoTCJqEyT2BDJDxGlTgd065c6DgCexsQJ+w7qN2WbtnyDojFCBmGfKtEmHyUzXNgCrFjMKJwvfP/FTxHhOevMi8aIA3OAep7LbHjfCswfyX59DMSpn3VMf2T6Xgta18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983055; c=relaxed/simple;
	bh=Av7LvkKFpoAFqChOJvcDasxL+Rc69uxIFWAz7HdkaI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=neDL6T/yZxJhpUB9tNGjyrrwcKF3c/gsDEq6M3TUbV3QKRgSrrssNSKbBhpMYgTP8lAwYc7xjFcTF2BH/R7mdhx/7Ze5dqxijWu88NW3mtKyGMSz8BUodapKf7chDtR/XQvGUKf9NT4TrwbyL11oE8EfnTqXRpTcYWKa5YhcG7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dfX5PqnK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B850C116D0;
	Wed, 25 Feb 2026 01:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983055;
	bh=Av7LvkKFpoAFqChOJvcDasxL+Rc69uxIFWAz7HdkaI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dfX5PqnKrzy0wcPoSji23jdo5pSbcTXguQRQiAz9BkRtM57IdjWyN4ewInCZRGN6R
	 3tpZO3RTq3JpJk8iILy/M6G33E6iQ9y4zsjy+ss1TW1xmxrNAeTMwqPqfmhF95ByJ8
	 zkTL2hfk40N4ZJPYVmrxAwUHHlqnPTvj+kGAn9Yk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 220/781] ALSA: vmaster: Relax __free() variable declarations
Date: Tue, 24 Feb 2026 17:15:29 -0800
Message-ID: <20260225012405.109648294@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218257-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.de:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 6E2F118F132
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 3b7c7bda39e1e48f926fb3d280a5f5d20a939857 ]

We used to have a variable declaration with __free() initialized with
NULL.  This was to keep the old coding style rule, but recently it's
relaxed and rather recommends to follow the new rule to declare in
place of use for __free() -- which avoids potential deadlocks or UAFs
with nested cleanups.

Although the current code has no bug, per se, let's follow the new
standard and move the declaration to the place of assignment (or
directly assign the allocated result) instead of NULL initializations.

Fixes: fb9e197f3f27 ("ALSA: vmaster: Use automatic cleanup of kfree()")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20251216140634.171890-9-tiwai@suse.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/vmaster.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/core/vmaster.c b/sound/core/vmaster.c
index c657659b236c4..76cc64245f5df 100644
--- a/sound/core/vmaster.c
+++ b/sound/core/vmaster.c
@@ -56,10 +56,10 @@ struct link_follower {
 
 static int follower_update(struct link_follower *follower)
 {
-	struct snd_ctl_elem_value *uctl __free(kfree) = NULL;
 	int err, ch;
+	struct snd_ctl_elem_value *uctl __free(kfree) =
+		kzalloc(sizeof(*uctl), GFP_KERNEL);
 
-	uctl = kzalloc(sizeof(*uctl), GFP_KERNEL);
 	if (!uctl)
 		return -ENOMEM;
 	uctl->id = follower->follower.id;
@@ -74,7 +74,6 @@ static int follower_update(struct link_follower *follower)
 /* get the follower ctl info and save the initial values */
 static int follower_init(struct link_follower *follower)
 {
-	struct snd_ctl_elem_info *uinfo __free(kfree) = NULL;
 	int err;
 
 	if (follower->info.count) {
@@ -84,7 +83,8 @@ static int follower_init(struct link_follower *follower)
 		return 0;
 	}
 
-	uinfo = kmalloc(sizeof(*uinfo), GFP_KERNEL);
+	struct snd_ctl_elem_info *uinfo __free(kfree) =
+		kmalloc(sizeof(*uinfo), GFP_KERNEL);
 	if (!uinfo)
 		return -ENOMEM;
 	uinfo->id = follower->follower.id;
@@ -341,9 +341,9 @@ static int master_get(struct snd_kcontrol *kcontrol,
 static int sync_followers(struct link_master *master, int old_val, int new_val)
 {
 	struct link_follower *follower;
-	struct snd_ctl_elem_value *uval __free(kfree) = NULL;
+	struct snd_ctl_elem_value *uval __free(kfree) =
+		kmalloc(sizeof(*uval), GFP_KERNEL);
 
-	uval = kmalloc(sizeof(*uval), GFP_KERNEL);
 	if (!uval)
 		return -ENOMEM;
 	list_for_each_entry(follower, &master->followers, list) {
-- 
2.51.0




