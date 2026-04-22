Return-Path: <stable+bounces-240261-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNdzD3Mf6GnqFQIAu9opvQ
	(envelope-from <stable+bounces-240261-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 03:08:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FCF441043
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 03:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E416302AE0C
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 01:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E601243387;
	Wed, 22 Apr 2026 01:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECrmDrMS"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B7D235BE2
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 01:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776820078; cv=none; b=EQPsjKfecbv99Mg/1DDSTVZ56qPlFZux0Epl+XXYrJ2J1MRkbgnATSJnP1DwvGPGFHKMSXGXjeJlOLirXjnrfjb222BWDmBkkPRN4FqW1r6thHP4UCuYEGWb0Gqtos03Ob5Ku9udPDFzrYwsoggZGPNHhi2Hmr9+pr/I5R34sKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776820078; c=relaxed/simple;
	bh=DmvQdbnSVkU390Uki7nhoRgUGLW/SfBTGzh+vLC9FdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=C7aqSBw958XabVSTMxNjAniYJkVzzfv1/PN36enHoVE6nng3tj8zMeLTcbA3BcUqMOvAHSvPfsGyTj6Anng9o554jkMxr0VFjCWLJHWzUsN+C6GF2kLymbYKmD+jg4XFNlBkiVKA+QN38LwQkGsqmm3T5FwqzsiNfPW9YSWUMzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECrmDrMS; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2c156c4a9efso6515697eec.1
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 18:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776820075; x=1777424875; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UAr7c0jVgzuAHNJ5czeyIB1hhcntc/AZfRD30ixgZSs=;
        b=ECrmDrMSyjgggLD1EG7dgg7XKM8x51S4Ct46jhfFB4zWlwF0skale0ssqnKvs/5dGs
         pgpEz2X+gP7ub8DqT9xUfLurepXeTnldvekth5E3zDjvlaqZN/Gb0hf/Klse003Gaiq5
         6Zg4QPGJs9AZSrHAX1myMO4YJv5nxj5YNSyU8u/58IzEBQyw7eQyYyLfPzzODLQe+sFC
         ctB0uW2AK83DvRfeF3caF7KCF+T/RUKJnfjOqFlGm+j7iBkO+8g+03M6F9T4Zv6BF4HY
         Wdefd4CbTG83Z8c7unYu+94aIJA8HL3cpK4vY8LxMAeNWjfYIXzjaEszK83Q0opk7wWh
         pHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776820075; x=1777424875;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAr7c0jVgzuAHNJ5czeyIB1hhcntc/AZfRD30ixgZSs=;
        b=g79saas/AbtvPltQ09VWg6/vnYf/K51Sh59a4AUk5uas5rH/j8DA29TwsdC8yUPHao
         ufHdaHeZITlf2wGOTTXzgRFaq2Wnjz+nnAWNtCymzL92jUAXs4fLF2XNKA5PPLA5Gy6C
         FDYJhT5xEF5hwxLfUjecBHb6l0LI0XsuGMbnkccebQzmshGHNuoZZoZJSjl/frizaoL2
         qvIXi2e633IOC6EyXGMlOT7tyLg6LytXltTT/JyZDQPXTUO6RPDs4eW2VKYYOGONVq3G
         4wzqaUqoBm17OHlRxX9i3lGHFPpo1ORU3fMVYNjGaRKJLNvYsfyAZHVcY8hhHcYKKEAs
         v6fg==
X-Forwarded-Encrypted: i=1; AFNElJ8/r4wAGwkyhxRoz/1FAzMpk2dNwLcz1GUVd39LS78juTVRm/dBAVTrkhsLo26bCxQao14Rmxw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4aeFGxYrEcsg9bh7fjFaO+dGCtaqdeAt9ld+xl1OIHwGqgtUa
	rIljFHNszwuvC1P8YBGR+M9/NYXJdJ8cCj4Vj/UqUcCt06xNpXjxCLghxerasPec
X-Gm-Gg: AeBDievvkCnPzat9NL7Qto944MjFbuXg8kY5SgOg1hPtwqztgpflLBGCjhpW5lGOTSl
	wgXMC0YJCvhWc6axSj4xsEI3yyt1gepjKn5oetRJVZUdWr/CxJc13wvijvVor+5+TLG/cYtCl/p
	yr8zvSa84e+sBaOUUtJW/UtH6V0CTfAMonBt8Qldv7RYPa5uIm+bE7BKgfS34i5qVbpVjJaH7Nj
	a4mRYFJoaj11c0lfONwKzAN0LgwCvGcWWztUdCPXcgPd4DvAtNMGG05tDZ1GO2BRT9zxzmiLdeq
	QZanqfWpiAbINwJpVn8BNQ5aAFXeuySpCgVEWu2yzD+8GCXLmMHDs9DcMlZ/YkZMdi+e5IBCJ0I
	PGakSElYGpF33HeNw41cXhtFiy47E52UZTUkyYxZPCziAYFCaI2MVoggUO6dAMdAGcoOmnuLYSp
	g7v5jQRUxtexSXw3kYjxgQMD9x4t28llYZ2fUF43O7SHA4J+DGKoe0zB7gvyhB/9CVecaM422VV
	z+UW34qVITfkyaOlfVSklA=
X-Received: by 2002:a05:7022:ef09:b0:12a:6b99:1ad4 with SMTP id a92af1059eb24-12c73f6c3c6mr11619846c88.11.1776820075248;
        Tue, 21 Apr 2026 18:07:55 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c919266f6sm12358283c88.1.2026.04.21.18.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 18:07:54 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Tue, 21 Apr 2026 22:07:41 -0300
Subject: [PATCH] ALSA: usb-audio: Fix Audio Advantage Micro II SPDIF switch
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260421-microii-spdif-switch-fix-v1-1-5c50dc28b88f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMUQqDMBCE4avIPnfBpGq1VxEfarLWKVQlq60g3
 r2pPn4D82+kEiBK92SjIB8oxiHCXBJy/WN4CsNHk01tkWbmxm+4MAKsk0fH+sXseu6wcuXLtrC
 muuZlTvE+BYnzka6b07q0L3Hzv0f7/gPWlx8VfAAAAA==
X-Change-ID: 20260417-microii-spdif-switch-fix-9d8b62193585
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1283;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=DmvQdbnSVkU390Uki7nhoRgUGLW/SfBTGzh+vLC9FdE=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJkv5NPPu15ZNsl05XWBA/VxjtMLQvf9OmkVoSFyesu2p
 aVduz7YdZSyMIhxMciKKbKsTlpkuafrwdX6uBUeMHNYmUCGMHBxCsBE/hcxMnQcSvWctF4ibx5/
 omDc6vsTitc+ufDR75jYF46cLI4Nh64w/JVqvLuHUXFtUsH7JYKLrzufmCcdpBGyoynj456fE7Z
 XbeEFAA==
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-240261-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C8FCF441043
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

snd_microii_spdif_switch_put() returns 0 when the requested
vendor register value differs from the cached one.

This comparison was inverted by the resume-support conversion,
so real SPDIF switch toggles are ignored while no-op writes still
issue SET_CUR and report success.

Return early only when the requested value matches the cached one.

Fixes: 288673beae6c ("ALSA: usb-audio: Add resume support for MicroII SPDIF ctls")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/usb/mixer_quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index a01510a855c2..6cd50cfc563b 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -2025,7 +2025,7 @@ static int snd_microii_spdif_switch_put(struct snd_kcontrol *kcontrol,
 	int err;
 
 	reg = ucontrol->value.integer.value[0] ? 0x28 : 0x2a;
-	if (reg != list->kctl->private_value)
+	if (reg == list->kctl->private_value)
 		return 0;
 
 	kcontrol->private_value = reg;

---
base-commit: 46b0e9075ce97e82726d45ce9b048840d0b4eec7
change-id: 20260417-microii-spdif-switch-fix-9d8b62193585

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>


