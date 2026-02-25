Return-Path: <stable+bounces-218609-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMx3KShYnmkKUwQAu9opvQ
	(envelope-from <stable+bounces-218609-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:02:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3323D1906B3
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A22D30A846E
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0712641FC;
	Wed, 25 Feb 2026 01:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ddnVvjWH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2092726158C;
	Wed, 25 Feb 2026 01:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983455; cv=none; b=HxDMv011VbB4r2pTKFwBVwyWBRd+IqaMbyd8Y2sZ+TB3dqeh+XsP3OYDLJSA6/0qZmB8Qj/Wu3Rs/W1TLbpLGUoq+5StVRBkpFd5bKSf3oIyxET5bvoLLDPJedMw6l7hbHVDwtS9Xqka3L6gjf3OVK8uVmC1AIXzAu4qhP4V93U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983455; c=relaxed/simple;
	bh=tjPYL7bcyQJMypk2tXGhuzdsbENTgO7tCPGzwsBy8zA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p85Hz3dNmn+VA5efjLtEaLzoCsjlMYL5hYJv7vXX0TrAIBKM3hkneW8SPbv+l1nRgly6pE862eb3Rf/uXBLiMLvHIoek9Tuf3zmHDZmIxMAepJiUDk5b7d6mkOasqMZglKUKUgn0aFlulF9g2RF2dbJTatdhvrZDkSr3bTA5AkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ddnVvjWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD56CC19423;
	Wed, 25 Feb 2026 01:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983455;
	bh=tjPYL7bcyQJMypk2tXGhuzdsbENTgO7tCPGzwsBy8zA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ddnVvjWH1emMJ2DDopywOnAxYc9H/ZS8PBjlzvh7N7syJIcoXBNc/JcOt/1J7I2P5
	 ECEwdLWAw/qOck9aBVLHDVsIu7ZH2sBtqIp2L+37tBZ1kSJQUSBWe7G639pBorLkQm
	 QfrgTb7ufOB4BvTkhKqQHITDW2q9osidEkdMyb24=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rui Miguel Silva <rui.silva@linaro.org>,
	Chaitanya Mishra <chaitanyamishra.ai@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 569/781] staging: greybus: lights: avoid NULL deref
Date: Tue, 24 Feb 2026 17:21:18 -0800
Message-ID: <20260225012413.761359828@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-218609-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linaro.org,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.982];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,linaro.org:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3323D1906B3
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chaitanya Mishra <chaitanyamishra.ai@gmail.com>

[ Upstream commit efcffd9a6ad8d190651498d5eda53bfc7cf683a7 ]

gb_lights_light_config() stores channel_count before allocating the
channels array. If kcalloc() fails, gb_lights_release() iterates the
non-zero count and dereferences light->channels, which is NULL.

Allocate channels first and only then publish channels_count so the
cleanup path can't walk a NULL pointer.

Fixes: 2870b52bae4c ("greybus: lights: add lights implementation")
Link: https://lore.kernel.org/all/20260108103700.15384-1-chaitanyamishra.ai@gmail.com/
Reviewed-by: Rui Miguel Silva <rui.silva@linaro.org>
Signed-off-by: Chaitanya Mishra <chaitanyamishra.ai@gmail.com>
Link: https://patch.msgid.link/20260108151254.81553-1-chaitanyamishra.ai@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/greybus/light.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/light.c
index e509fdc715dbb..38c233a706c48 100644
--- a/drivers/staging/greybus/light.c
+++ b/drivers/staging/greybus/light.c
@@ -1008,14 +1008,18 @@ static int gb_lights_light_config(struct gb_lights *glights, u8 id)
 	if (!strlen(conf.name))
 		return -EINVAL;
 
-	light->channels_count = conf.channel_count;
 	light->name = kstrndup(conf.name, NAMES_MAX, GFP_KERNEL);
 	if (!light->name)
 		return -ENOMEM;
-	light->channels = kcalloc(light->channels_count,
+	light->channels = kcalloc(conf.channel_count,
 				  sizeof(struct gb_channel), GFP_KERNEL);
 	if (!light->channels)
 		return -ENOMEM;
+	/*
+	 * Publish channels_count only after channels allocation so cleanup
+	 * doesn't walk a NULL channels pointer on allocation failure.
+	 */
+	light->channels_count = conf.channel_count;
 
 	/* First we collect all the configurations for all channels */
 	for (i = 0; i < light->channels_count; i++) {
-- 
2.51.0




