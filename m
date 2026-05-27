Return-Path: <stable+bounces-254570-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OI2GDvjgFmo9uQcAu9opvQ
	(envelope-from <stable+bounces-254570-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:18:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3A25E4066
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE48B30315DA
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 12:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B9C38C43F;
	Wed, 27 May 2026 12:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="LWN11FBT"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606D92F2917;
	Wed, 27 May 2026 12:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883774; cv=none; b=bSVTeWIlCmWMac7FvPziXrF9GECTnl7uOp5wXXy7sX3TXywriYblhqD1pMcmXulL0iiNGO6q/gQJKRSn3/RkObVVUkdeLjJYCeu+KiIEKQ2rCbOL+iqN2b4lLCmV5Va1x97boN+dPBjqW118gcs+xZHi6XBFqIfi1N7SvTkFm8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883774; c=relaxed/simple;
	bh=ebG19CGD8i38el6n6iJfCqzhkMyZzhHECSzFbqUlvD4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Bio7Z711CsemHz6SKruBaYjsv5VVx4rK6WeLt+qAcjhxJIO8M0J/AyGiAF9A8wZuh9z2PxKXd6DprRowsXmCKDIPjeTM2nLVcpSd2onHKIOaurikweQFBIb11oXQr1eeuJgfB1QrlylncBmgJLcuZ+h0Vz5hL/fi68zjJGMVBF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=LWN11FBT; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779883770;
	bh=jqSwK01aO8TmHZ7e+144rbX8qp9l8LQ+R9htw/wEdxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LWN11FBT7COvGSxKLCIxJIABdTxFjaJvtYa8YfsFruFuxGxLA2jYQA+OOzt8zGmdb
	 8G4hqaERN32pQHwo8QziNVdI1iSVqp4By9lCLuTUdrTJY1fjMZFxVC+6DA6nldLHYD
	 vkBKOKeYsB/fVsSZfuLS36Do1RxQqapKtDlwFjUc=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 2518B808; Wed, 27 May 2026 20:09:17 +0800
X-QQ-mid: xmsmtpt1779883767tb5qlimvy
Message-ID: <tencent_35F3A25FEEBF190A2E15ED787754C57E3708@qq.com>
X-QQ-XMAILINFO: ON4JYNczNu10e5b4ii9zp2DbIVdCVzMZDRUFme10Up2T4k3uMUmi/pLHeFyUgY
	 0rU8lldkPVBQ2vtNd55D2dh3KbgqXYvYuNthzTZv1u7zdZvh1NoEmrdzvERE1qb8w12NQmOZk9nK
	 Qs6d09R4WmmhTHPCWQNtUvhlgTptQcJ4eLyqVprxe/7D0ilITJdEIb9Wj/rl0eI/kEHHxuSwd40G
	 ZuafnybHmvd3aYdsvFdC0lB+d5rtHodrn+eIEqRczhUVTXwhbESgxWp0RPOGXX0vLQ0fHS3ZwuVP
	 6CkZu2ZH1qOiMqEU1t1WKDFymMnGWWt1uXThtMtwW+OHxFpVpwkXoEtakGy7zKrN6g78CnQK0poK
	 r/b+AAaTXwiWhM+1/f9wwfomx3K0ffc0lGbwcJti/2y0mnjDZHdJr6UEV7a94hJezskJRHDZ/MrR
	 WHUe2GLKvFZc7VzKg9iQg0n4SRmd1bsTLg/MKLl2k7GZfnZi0NMaVUwmvWMrHxZg3BgrK9mqWGTd
	 2rtNoVwse2Rn0uiS/4OwpHbiJVgVOAjw9QPKwIaNzrSS3oJglWEO0LXQ6JkPDH6Qhtbi5IKOqGxE
	 DPdOvLjLX0M7WPU09Hk9mD4bboN7AHUToMkJAnU2JIlrmVeuldWEVdbDnpOyW+70/Oc6xbGJd63T
	 +XoMulTAoYVp7ntyETu54CPfStIl3k128hG1azhVBMsR/3lGMAJopZGNH7Tr1TTTgXeWGekiVTiG
	 NOtdKbLMHmnofaK1tjuvIPWmUVOz8OWfcCkNj6u7PR/328+bVp1TLia9Airrn8vKAWJmHffkCT4E
	 YQwBrNtEFgI5qIoKFQ/SG5L6JxZoPh75yOK7I1wBtDBFvp3G2/VQ5tKgyU24diDOqvnSWpRzQqg1
	 8aoGPuOsAAm6OZvNHu/UHnmVxBNOT2YP3P4C804EgdM8nHOfTX4sEAbwgTU4PMcD62L0XJdVDEzS
	 xf1QY6oChUTaFPHMECjcXwfG2IgU4rnP4h33Q0tRWu2i0GTjRQu4fmVRLWVQJP4uqh/qGqpXerw7
	 Kh44wzs0921BXP5aBlohjyFSHI277SXREUBMcJkiL7j+lP2PCVoZMW+s4+sOvfddzSeB18An0KM8
	 32HxeliNO77XLym0H7EZLp9EoR1OjNlgAMpi/X
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Zhao Dongdong <winter91@foxmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	Zhao Dongdong <zhaodongdong@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3 6/6] ALSA: aoa: check snd_ctl_new1() return value
Date: Wed, 27 May 2026 20:09:14 +0800
X-OQ-MSGID: <20260527120914.515037-7-winter91@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260527120914.515037-1-winter91@foxmail.com>
References: <20260527120914.515037-1-winter91@foxmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[foxmail.com];
	TAGGED_FROM(0.00)[bounces-254570-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[winter91@foxmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[foxmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8A3A25E4066
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zhao Dongdong <zhaodongdong@kylinos.cn>

snd_ctl_new1() can return NULL when memory allocation fails. In
layout.c, the function does not check the return value before
dereferencing ctl->id.name or passing to aoa_snd_ctl_add(), which can
lead to a NULL pointer dereference.

Add NULL checks after snd_ctl_new1() calls and return early if any
fails.

Assisted-by: Opencode:DeepSeek-V4-Flash
Cc: stable@vger.kernel.org
Fixes: f3d9478b2ce4 ("[ALSA] snd-aoa: add snd-aoa")
Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>
---
 sound/aoa/fabrics/layout.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/aoa/fabrics/layout.c b/sound/aoa/fabrics/layout.c
index c3ebb6de4789..7bb541577a26 100644
--- a/sound/aoa/fabrics/layout.c
+++ b/sound/aoa/fabrics/layout.c
@@ -948,6 +948,8 @@ static void layout_attached_codec(struct aoa_codec *codec)
 			if (lineout == 1)
 				ldev->gpio.methods->set_lineout(codec->gpio, 1);
 			ctl = snd_ctl_new1(&lineout_ctl, codec->gpio);
+			if (!ctl)
+				return;
 			if (cc->connected & CC_LINEOUT_LABELLED_HEADPHONE)
 				strscpy(ctl->id.name, "Headphone Switch");
 			ldev->lineout_ctrl = ctl;
@@ -961,12 +963,16 @@ static void layout_attached_codec(struct aoa_codec *codec)
 			if (ldev->have_lineout_detect) {
 				ctl = snd_ctl_new1(&lineout_detect_choice,
 						   ldev);
+				if (!ctl)
+					return;
 				if (cc->connected & CC_LINEOUT_LABELLED_HEADPHONE)
 					strscpy(ctl->id.name,
 						"Headphone Detect Autoswitch");
 				aoa_snd_ctl_add(ctl);
 				ctl = snd_ctl_new1(&lineout_detected,
 						   ldev);
+				if (!ctl)
+					return;
 				if (cc->connected & CC_LINEOUT_LABELLED_HEADPHONE)
 					strscpy(ctl->id.name,
 						"Headphone Detected");
-- 
2.25.1


