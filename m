Return-Path: <stable+bounces-238202-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vKpdG8Hn32nyaAAAu9opvQ
	(envelope-from <stable+bounces-238202-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 21:32:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF379407631
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 21:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3932304C4CA
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 19:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C943329C60;
	Wed, 15 Apr 2026 19:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuK5ONyf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F1023A9BD
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 19:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776281508; cv=none; b=WKLhaSw9iCkn+524SNVxegrZ/5Ny86pJ2M/VD1v8XAzu35WBZc+s7H8/UdC8LR3Bc7EFjYwgVir7dcHamOfc99Ngm2R63Rs1/YVkHnq8+aPFHbbB3ui5DjP7JI3t3n3XTZG6GdF379zaTcTdhQqxBoMkRQnvAHqyWTuNdLBiHiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776281508; c=relaxed/simple;
	bh=asgX9bZgN871VW8IBcMTNA0C06TYpe28e4YJgMp0wvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uY78FYP3DDGXI6eiTcOiDXQTqgADZ4MnTce7x5d87E+jdxYwsMhYuhjE87MHhx0N0+X8HfNNJ6+a0yoIOWqs7pbgKwr+kcArksb1doCZmhCqEj1lLvG+2cdfN3NEU1gjsXvNJNWnNfOxJu/nr9tIgrss+575nrUacv6MMeBYqOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuK5ONyf; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35d94f4ee36so4260457a91.3
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 12:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776281506; x=1776886306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UNbHuV79KfOM82xdjXOagbN4R3U9h/0lIOtBKfl6MnA=;
        b=kuK5ONyfVKfdLvuCOS3jLGf9pz6359Tj4/VcxLeqfmupDRoce+dcYVuJkTINVQQI/R
         y4fDgrIJOgan/AN7nqTwC1MeOhVSeGH5gR1uGu+L2E6izF1tFuoSu5K4E+Y6gf37b9nR
         d4Hj+Okdqf6SzTpZZv72pM/52BRKuWGoivYmvqmiWiSC//WqG95oGHp+1j+T3IXwyeoD
         xQNZr5y/foGy09SnxQQ+I1/PQ6Q5Jg4uGfjTVI7D39Lpo6u3WhPEvzOlf7cv45t+CHGH
         BGhtEeqPuRIle8YKG9nYhUSQ+7QRBohy1GyV9X9Q5WBKd43NM5yb86Pa9g7WwK8WPABA
         eYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776281506; x=1776886306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNbHuV79KfOM82xdjXOagbN4R3U9h/0lIOtBKfl6MnA=;
        b=nxcp936WRBvvtJaxkn/z5dem7PVYDGEZ2Ecd0uKiSb5A+KL1uvEe2TUA3HPsXmFJT6
         89yfWAMNs6sbeZQqAR5MAFjpgGxTXHxjVzAwcootKkcR3fqMARM5lpimiQXSLsdXvYsJ
         k4H/FjsemY/il+/tuYhh3rwo4cQOV9yLR2+EzZlfQ0O4vRBaKQmlA3kyR4zhgxJSsK2s
         rRanEzsLGao0ESNndSlgN0MWb3kxf/IM7OcFeFMDrndP4KNa6lQbgMCyfDAk78GW3f/N
         3wQdfEnigDFkfPsD/LS0SfsrjV71X4A7eatVpoTy4Z2PmA5N3hF1v5v7uupb5V4+85L2
         UvlQ==
X-Forwarded-Encrypted: i=1; AFNElJ/7mZ+gKr25x/eTN/286MK/9BJDH0OgtlzI7xzwhESJv9AWLRi66obsvI44stjYB5XSGOQRIws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3GWrwjVHFxJkzRGwMCCi/x0YnlhLCgOttnWIolV//yAse/UOs
	cSK7y8AlNF6rlk8KD/YAkarcGjRNDz7fcrAsyR8lJGWnz5xxdWsorjaL
X-Gm-Gg: AeBDievn4CLReEmOUrx9xwUuRjSUnRwKkdkUYvLc9dasxzTmjc+dqJ7zaVRrGNb7W2E
	SHCiKOjTaSZCoQuXzaZ1w2nO3QKKyD817CDNSLiYMuIznDYtpduePYYaVm1ENg5mgdFuhgpvH2y
	9zLrljpEq6jrPHUM4DFuMmiO6TWC/68xaLgqonU6i1DpOSudV/jnZjrLqcG0/bMYILm2IDbTJPA
	NKMKcO5ftLPEKtPUDEvGZ3k4RvW8HJT9v3nRePEO+9i55wBkuuL+vgpKax4fmHH+8XL+WjLzqAE
	kdhGWnQLUpsLYcd8tgNOqtqosAECnPGzz4lwX/Wi9d3fsTYJP5bzFemMKw0HhEw8wd3eMG0xdtL
	h57rQIW7i6GQG3QLDma1hQPrH9XXgz7cBfp7ULIUj1an4HHs/XzZ5kEvZEf8cxmxESLuRjEoHmJ
	OmU9OqkvKQ1l9qD4yJOLxx9zTf2+pyGvvZwoejLUrtG2caPw==
X-Received: by 2002:a17:90b:3950:b0:35c:1695:24a3 with SMTP id 98e67ed59e1d1-35e4281374emr22489139a91.23.1776281506503;
        Wed, 15 Apr 2026 12:31:46 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:93ee:194:b07d:a9b2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fce7d792csm1711666a91.1.2026.04.15.12.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 12:31:46 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Ivan Orlov <ivan.orlov0322@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: pcmtest: fix reference leak on failed device registration
Date: Thu, 16 Apr 2026 03:31:38 +0800
Message-ID: <20260415193138.3861297-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,perex.cz,suse.com,vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238202-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.987];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF379407631
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When platform_device_register() fails in mod_init(), the embedded struct
device in pcmtst_pdev has already been initialized by
device_initialize(), but the failure path returns the error without
dropping the device reference for the current platform device:

  mod_init()
    -> platform_device_register(&pcmtst_pdev)
       -> device_initialize(&pcmtst_pdev.dev)
       -> setup_pdev_dma_masks(&pcmtst_pdev)
       -> platform_device_add(&pcmtst_pdev)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() before returning the error.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: 315a3d57c64c5 ("ALSA: Implement the new Virtual PCM Test Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 sound/drivers/pcmtest.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/drivers/pcmtest.c b/sound/drivers/pcmtest.c
index 768bb698adfb..20ceb9082fa9 100644
--- a/sound/drivers/pcmtest.c
+++ b/sound/drivers/pcmtest.c
@@ -756,8 +756,10 @@ static int __init mod_init(void)
 	if (err)
 		return err;
 	err = platform_device_register(&pcmtst_pdev);
-	if (err)
+	if (err) {
+		platform_device_put(&pcmtst_pdev);
 		return err;
+	}
 	err = platform_driver_register(&pcmtst_pdrv);
 	if (err)
 		platform_device_unregister(&pcmtst_pdev);
-- 
2.43.0


