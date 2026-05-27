Return-Path: <stable+bounces-254559-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AXEAmPbFmrVtwcAu9opvQ
	(envelope-from <stable+bounces-254559-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 13:54:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E06A5E3B0B
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 13:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35452304705F
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 11:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E363FF889;
	Wed, 27 May 2026 11:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="kEKyjb5k"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0347400E1A;
	Wed, 27 May 2026 11:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882532; cv=none; b=GR3ZzCKacQTNPaWSVAJ+8zXk4Wb8iEOKX3dmr/IABgaV/am81ILi3j244Df39yLxODcHas2EU6YAue2NYlq73BTwUahfmVvAISh3WBNuXXzDUc5HS4BhZ84UbYkVN4Hkr/qPDUDyGHXDvHrR1Z6fiGZThwlQj0d/8y5OMav0vZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882532; c=relaxed/simple;
	bh=ebG19CGD8i38el6n6iJfCqzhkMyZzhHECSzFbqUlvD4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=UHZZ++y3tmEFamiJxbXuU7Yb+ySGUEgOfOMBcctbqnqzO51H+cdM6HX9oNvPv5Rfkha0tjI78vMG7t3fv/LM9D0eHon/QG38MFk6idHp0WbWDrr+ix330TO3x5RdgSYQOe58pzXxI3sP4ZSdBO5/tgKV3y6sglOxRqOsGe2VkAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=kEKyjb5k; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779882529;
	bh=jqSwK01aO8TmHZ7e+144rbX8qp9l8LQ+R9htw/wEdxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kEKyjb5k8TDrX34YNXfV1L8h1WqWoRadK1J4SMKmtKFM3x4vTIUwoV3zJa617xJMy
	 pBmtabpMShX5JD3Bj11cidPzLzzwrOX/NSLOLvpho/hwSRaJ1AIkl18J13wyQKCOj8
	 wPDh3/G0oFAiNkkjlOOomafHPULOKmKinFxWua/c=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id C15A3CA3; Wed, 27 May 2026 19:48:21 +0800
X-QQ-mid: xmsmtpt1779882526tklv72pld
Message-ID: <tencent_6688A8957B7286948B48BBF5DD4A71DA8D06@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9X0aVGPG4vgGPYLrmd2Ptq6+vwk0dYzpu3njS3kGE+qdxmmTmD1Q
	 WwlNHdY8yd/FFjkuJj+WXpk80mChNdVwOMn11OBMwFNPoLEQVZHZJx8hU57u5EiPItQ2Idxaftb5
	 zLe9sXiRWyBjzd/xjI+tOuv72J9vODB3op3REY06p2IksINLPVXnzlxf5H53MsM/AH9qFEPZtM/1
	 3Gm98Q63eye5/5aVwmy/2I2rreNUOTszCvSivO+LlTlytE4TX3ZbMLKSsPHX7T6s+qzv1ZVwVTaI
	 MiygXbFCcZ0V6eYx74YcpJc1CIuqjLbXIUeprILLBJ3mTQiJF9p5ffHl+vOZDmj2iJ4VOUIDsTpA
	 fvEPfqVCy+3uxWHWRF7F+58KU/UNMChZlkfYNPmgMnmw0hkfo3Dr/X/AbSp7gvLC+sTblJ/wu23N
	 GWWG3NucSkp9RqCeGA/1ou+pePURtWSBnH3oGTcANwlEUZhaW7FPI+88wXGayDfXW4PtS49lwRR+
	 Kfq1SNn4XnaiS9KOfW7zrbAEoranwvyGz9OB6/lxErNCu+CeOvXrEn/593aFm+JgwUBqDcVREkv4
	 kzGiKOZcpi3VCWQiswGQYivmvapW8eB7E2lVhcPgaG0Gw+WpmMQVjM+pfiJvR0oL+uYGmZ1DMBCo
	 teP1oM9uUZWMgLcpjMWBb10/m9o0pqHt+nGyT0azZYRLW6bBwYtOgqroDj693OAmZMMZMovwmUb9
	 k/ZW7g0WLdOMaFFGH5IYqAWAjIbjXoWC35DLA5zAsAZXvW9xtA6ezKSOYDxXqI2iyebWd7y9uGSe
	 yu5TQaohei+EaHqKcQ2MDT1J0OHLwCqW+PLH+fr9m4RD0KlTGoMpAWEJ+2iJ8PVQHwv40zc8lrPM
	 3MczpwPCGNxc0wU1fK/pAfre3bCbzMonA2xRuBwRXn7x6BNT3JZHi1eIeOCxBd/De4XxM1XDGr72
	 mPAPSVYbQILEVWF9XoC0ngcwL4HkPrWAJzGjydRAyTWfLK5zCRX+d1LutP9dKROt7GfwfBRrxW7G
	 ckd0SJFBWraIUa1MR8uCAHVakyemZxUgvy7BaIh61JnlBg0y2k7pTuNpRsUgR2AzYQWWrxYsAQmi
	 2+ml4m2OARDjWmHy8z+ZznElRT9A==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Zhao Dongdong <winter91@foxmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	Zhao Dongdong <zhaodongdong@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2 6/6] ALSA: aoa: check snd_ctl_new1() return value
Date: Wed, 27 May 2026 19:48:19 +0800
X-OQ-MSGID: <20260527114819.498119-7-winter91@foxmail.com>
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
	TAGGED_FROM(0.00)[bounces-254559-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[winter91@foxmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[foxmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5E06A5E3B0B
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


