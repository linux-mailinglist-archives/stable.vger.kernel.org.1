Return-Path: <stable+bounces-225243-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GbzAkeNs2klYAAAu9opvQ
	(envelope-from <stable+bounces-225243-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 05:06:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE9D27D3B9
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 05:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F8643081BFF
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 04:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F802417D9;
	Fri, 13 Mar 2026 04:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hldKoajK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603BE126F3B
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 04:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773374786; cv=none; b=ERUA07Gml5nwh5abSgP3LFdEzn422o9MUhTBu7rfwc9WtQU8m/NCp416iOcPQf5kVzMDvOWKs6fEIcRAsLzbZah9GEdSTPiLns4HY5kowrJfgcicWB0Di79HXBj9W1Yza6wXeAa2sbKc7N3Lal4U+gBaQjgMYodYTW5daegOz7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773374786; c=relaxed/simple;
	bh=Ccb7/rrFkWTefSKTgc4VB5t8QmMBzWsjuDWfEug+R5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WB+le/CnrtMZoRlXsUp3wTPrQnnUhlYhMOxp6pei6bcTJ4GVtQMe42xwZoiktR7yv97CjVE9Y5CvYQhd/GXpEF0SYWBMbSaNdhXs6H7KPl2zKI4bip4BMiSj5GI/lle429nYpmHqyID271CK956xNqkRhMX3MXGalLl/qB9cpJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hldKoajK; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-823c56765fdso1002388b3a.1
        for <stable@vger.kernel.org>; Thu, 12 Mar 2026 21:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773374785; x=1773979585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MZbSvC8sAuSPUZNbLT6g7eFzZMKiQ1pz/Tp17o9W3DA=;
        b=hldKoajKAFz4kdwRadE2N05T34zqqC+fbwO0fZf0UjP1eXPJTSEpyFzFzJ+hOkD1S7
         ucHwOLG6Tt+Cy6Hp+iMRhyhj/tNiTi6kaQFPMh2hUIMd/5T4dA2XR/HikyuUOil2cjUH
         c5FzenoPLOPIjK9gB7hu2UBCDSBJZtu5LaxA6YFPfFcGt2hJCsPc/Zyg9GwArG2+Ygla
         GxrIpkDcXBcOQgRlQl3XMDlTKGjscvUu4OxcUTWnoi2gRdHNOP+5zFRBsryNTb+Q041z
         Q3LEEDKpePFOd/0AcJNDHhi1c2oaQpye71i/PF/FowAQrtUvaoGJbW/p8XVlrO7z0ZX6
         ICjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773374785; x=1773979585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZbSvC8sAuSPUZNbLT6g7eFzZMKiQ1pz/Tp17o9W3DA=;
        b=EAjaOdjk8hXEr3VUa06qqJUL/6tL91FqeD1KcnLAe1Z4c8eCHpoxr7rnPSc5rLB/FA
         zCqkM60+dSz9gZ1vi2xtiZpX8l34eiw6L8bWsUwpVEyYl05ueASHZ9DXlnGTBBp2jJrk
         vmIkz189RB0x4q88frBXBQpx/H3l3niC1tRJ9t2574zVCrOuhgW53oIQ0O/KVrTMKLr+
         Pyit9x4uXWuj08p6/6wWIwyK9XG90gDLGS4LupGLmhHpnnaHc57BoL2hj1/Yxz2T7xyB
         jygOeUohkLbAuxNJDBDSMAEZHq7yIxsh0L2u7s1PXOEpnM422m8Gk9fhhXuh6NrRhtLH
         Y+Kg==
X-Forwarded-Encrypted: i=1; AJvYcCXduaZxwZxc00WaCXSwo7FMrZtxwGZLcy0Cn9yEswA0z4Tvc/kvazPItkPuCnRnSsMukJO/nDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi0jotzlte6mXEQa3S2nnr4x9NRONLT6cBomX6ZjbTd99DDI/9
	sjGeAPK4oxMmdCz8yfbkbpW1kjViKC9pCYzxCcJdckZ5sbbuUbtsx+Jk
X-Gm-Gg: ATEYQzx0rHK+EnKfqE4mqJ8xyCRBBdyrQzKPBG1wmvmYKvr7eOZ69Do5wMJNBYTnSMT
	n5jI8IM3ZP3ibEuMgvNgs3Y1Zi7r2ILYxwpnauh1J6XZHQtxp6/7DcxRpzL5B/0YD2lTe9cSGTk
	hgy1T3GWUrcaCZf13BxizStHQkMlTGQwZpHIRkkXZPmknaix4AhN0SiHt9fBCIvxG026ZQbtZB9
	fFwb2H8hMD9bzoTjicUb3kpNgRTfF/iKWOMLUe92gbxwWmnQxotlq/BkUOUhcvPtPSGAAIviIVQ
	TqL3HuAC67fv1+WpqaGQUsNfsFQr+O95/6L1DhZLNIvalrKToLtxIjMIcZp5RkmvL2RLTMTEqqe
	+c+EFEAQ3Xcl9jTIqKw0D8f9eW9T4kwV9gpXGQ8tGNOczkgbNqH57MWLimfoXlwxxUHlklVCRhE
	t5RffSpx7XnHTfoB2OPMqm
X-Received: by 2002:a05:6a00:7084:b0:824:a7bb:e8fc with SMTP id d2e1a72fcca58-82a1983fc2dmr1224093b3a.24.1773374784697;
        Thu, 12 Mar 2026 21:06:24 -0700 (PDT)
Received: from lgs.. ([223.80.110.53])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07384b27sm4523373b3a.53.2026.03.12.21.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 21:06:24 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Kiseok Jo <kiseok.jo@irondevice.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Chenyuan Yang <chenyuan0y@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] ASoC: sma1307: fix double free of devm_kzalloc() memory
Date: Fri, 13 Mar 2026 12:06:11 +0800
Message-ID: <20260313040611.391479-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225243-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[irondevice.com,gmail.com,kernel.org,perex.cz,suse.com,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7AE9D27D3B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A previous change added NULL checks and cleanup for allocation
failures in sma1307_setting_loaded().

However, the cleanup for mode_set entries is wrong. Those entries are
allocated with devm_kzalloc(), so they are device-managed resources and
must not be freed with kfree(). Manually freeing them in the error path
can lead to a double free when devres later releases the same memory.

Drop the manual kfree() loop and let devres handle the cleanup.

Fixes: 0ec6bd16705fe ("ASoC: sma1307: Add NULL check in sma1307_setting_loaded()")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Replace kfree() with devm_kfree() for mode_set[] error cleanup.
  - Clear released mode_set[] pointers after devm_kfree().

 sound/soc/codecs/sma1307.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/sma1307.c b/sound/soc/codecs/sma1307.c
index 4bb59e5c0891..5850bf6e71ca 100644
--- a/sound/soc/codecs/sma1307.c
+++ b/sound/soc/codecs/sma1307.c
@@ -1759,8 +1759,10 @@ static void sma1307_setting_loaded(struct sma1307_priv *sma1307, const char *fil
 				   sma1307->set.mode_size * 2 * sizeof(int),
 				   GFP_KERNEL);
 		if (!sma1307->set.mode_set[i]) {
-			for (int j = 0; j < i; j++)
-				kfree(sma1307->set.mode_set[j]);
+			for (int j = 0; j < i; j++) {
+				devm_kfree(sma1307->dev, sma1307->set.mode_set[j]);
+				sma1307->set.mode_set[j] = NULL;
+			}
 			sma1307->set.status = false;
 			return;
 		}
-- 
2.43.0


