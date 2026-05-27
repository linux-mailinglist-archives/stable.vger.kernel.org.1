Return-Path: <stable+bounces-254561-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGQfO4HbFmrVtwcAu9opvQ
	(envelope-from <stable+bounces-254561-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 13:54:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 707305E3B3D
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 13:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A21C3036421
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 11:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88504400DE4;
	Wed, 27 May 2026 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="HKbmzbLY"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30483EF0C8;
	Wed, 27 May 2026 11:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882601; cv=none; b=CcC7W7s4oJ5GkASNsw/Imws9sBe+HRRZq5bOc3nCBbSOe/8nmguGlgds6xdKrFiKJTUo6bltMmZz3x8BtrMQ08m9h8OYbJvVs6OVaudbhW0bPzQvyXis4sChrRq29O4jsIRnlJWuhxE2DcPL+mzltru8S58WAPIsUp6Q6gRohFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882601; c=relaxed/simple;
	bh=DsyrqwH9z1wPy+iyN1XvW8sHgzFQ0mb94h3X51fopYM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=iczBRSkRQPvhgwtCmo+nIt5FH9Qh+1wSyB3+2S6I0eQ8Xs4Agw0LM+mJ4By3Fwj2DMlz2jucVqdgNVlfxf9b/A5UH+Ew5NeEqRhazLbsBGbGfO9cdJO+jdBBpWtCfgQQKvOwlno4D2O3rDdBqAd8VpBF+UJ+jmd3UumjvqD9r/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=HKbmzbLY; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779882594;
	bh=SdQzQQXDOvVTvDu89953WL14dsKKHE8EvVQ4hgHnk0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HKbmzbLYPFhTWb/UkBQAV5Bij6e+ePZ7VQZ+6mmPq/YLZnhb4XLZnkNZSGpAiUa/y
	 oxA+gKGY8C7QgVQkV3GDu+vlMESlcc+KlUt34cSgKThceBWIiiQvE8g8mxJYIZ6Wix
	 EsvcdXGsPwaSGw2jxAbomNQj4UBLcmbcR1dgDjVo=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id C15A3CA3; Wed, 27 May 2026 19:48:21 +0800
X-QQ-mid: xmsmtpt1779882524taeejxwjp
Message-ID: <tencent_4FBDF78EA178E3865654D0BD2783CCE5A505@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJjGGZmIh/VgRvjLlFBgr4YNQnSS362VtZ9BsyzTUD84R/Dmv1ax
	 OUCCVHhpJ2AMdplqmCLb5r8X1MnIxLDkSHqO+WxOu+vtpuHGfQp2jvHOxPgoUWKlyCdcAaouTFHL
	 od6kcimeTfzOIVwB0Bn95seGA9CsWuUbOq/YdrlBCYJlrM88MDtYlgvDczXGAUFlDozn7OJ7+y1O
	 fPBi0HlLrQej5tB7McJEo+ukYqo8Fhuhg9Nog+C5s/YfssbS7C/AMGbRoRmnWB8HEcSaWLVugN7f
	 TyOK5n6GyKWem8kVvSAaBH2qZHd3/4J6cciEOA75NRN/P3z/3S47RI26jMBrz7tmdcAsYlk4IlHw
	 ffXBqheRxpBVk6Su583yQwQ5C/8eOXxkY22rTXN6jM5h4nZuDmkDqoP+QL+gpzj9k1rfmC1u3qQ0
	 +mMUtWpMDzBknXepm4ZnFMaKTKiKbIORGktScdN6uif2FSD3h4IBbWmHa2dzKlpTeezbSz7S23ao
	 BTuZZcLGKeZx4r4xF31rOlrSgEPAzzokjSsPFlMTVgfK4L5e4Lcb8m3K81gMdRaPLoASaRV72LS0
	 oBRmjM1b9rRTgUkkkQ2mSL0/oht9wsxUhx6twLQpKectr2Jt9n3u9N0yPRp8nUEBFlGdaRYqLxcE
	 FpkDj/B9VqksSvEw/Q7VvJwV71SdBPuP6yYipgUdvqSPwYv5az+h/XOqGGA+9h84w1pl2shcXi6/
	 ykNEEpKUpZ7qQO3kgs8MP3bNCpAVYpmfj1OigKp+xP5YoF/Koh0ZsI964y9A075LFm+xMaY1cliu
	 2wXgKAtTo+JF5PlQkJnBvvotb8SVOBTKfyIwLSW1pSWRaGRNBc5qq00Ex/sRs8Gu4W+VIN3ez7Vl
	 c/mO55Zd8649GztnWvpFIIbxafkv4qcVibjaWPLYwdDIWX24Aws39Bb/bhIcHVwKcgqUmeaeBgsj
	 4KxFT5/lErI360v3yrQap7QXdo+9gQICZhV7JKexR0rx3xRsAq+KajNnEGfcr+eAl5RG9Hyv1s7J
	 Dvhl4Hn5LOjU0K4QnjFYJSDPxTBHcC4jTL3u7xa06roPYk8rkxVSwTZHGWJ1lxGMCBaFPvM6ou9N
	 6yvzcdTq50gbvX3gl2lMF22FWjWg==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Zhao Dongdong <winter91@foxmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	Zhao Dongdong <zhaodongdong@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2 5/6] ALSA: cmipci: check snd_ctl_new1() return value
Date: Wed, 27 May 2026 19:48:18 +0800
X-OQ-MSGID: <20260527114819.498119-6-winter91@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260527114819.498119-1-winter91@foxmail.com>
References: <20260527114819.498119-1-winter91@foxmail.com>
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
	TAGGED_FROM(0.00)[bounces-254561-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[winter91@foxmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[foxmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 707305E3B3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zhao Dongdong <zhaodongdong@kylinos.cn>

snd_ctl_new1() can return NULL when memory allocation fails.
snd_cmipci_spdif_controls() does not check the return value before
dereferencing kctl->id.device, which can lead to a NULL pointer
dereference.

Add NULL checks after snd_ctl_new1() calls and return -ENOMEM if any
fails.

Assisted-by: Opencode:DeepSeek-V4-Flash
Cc: stable@vger.kernel.org
Fixes: f2f312ad88c6 ("ALSA: cmipci: Fix kctl->id initialization")
Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>
---
 sound/pci/cmipci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/cmipci.c b/sound/pci/cmipci.c
index cd73b6833639..ff4bfbf94b81 100644
--- a/sound/pci/cmipci.c
+++ b/sound/pci/cmipci.c
@@ -2637,16 +2637,22 @@ static int snd_cmipci_mixer_new(struct cmipci *cm, int pcm_spdif_device)
 		}
 		if (cm->can_ac3_hw) {
 			kctl = snd_ctl_new1(&snd_cmipci_spdif_default, cm);
+			if (!kctl)
+				return -ENOMEM;
 			kctl->id.device = pcm_spdif_device;
 			err = snd_ctl_add(card, kctl);
 			if (err < 0)
 				return err;
 			kctl = snd_ctl_new1(&snd_cmipci_spdif_mask, cm);
+			if (!kctl)
+				return -ENOMEM;
 			kctl->id.device = pcm_spdif_device;
 			err = snd_ctl_add(card, kctl);
 			if (err < 0)
 				return err;
 			kctl = snd_ctl_new1(&snd_cmipci_spdif_stream, cm);
+			if (!kctl)
+				return -ENOMEM;
 			kctl->id.device = pcm_spdif_device;
 			err = snd_ctl_add(card, kctl);
 			if (err < 0)
-- 
2.25.1


