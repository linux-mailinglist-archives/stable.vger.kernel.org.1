Return-Path: <stable+bounces-4820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 801F0806918
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 09:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 264A51F21244
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 08:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE3718C01;
	Wed,  6 Dec 2023 08:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwUzK3/s"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9541A4;
	Wed,  6 Dec 2023 00:07:50 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c9f62447c2so6564851fa.0;
        Wed, 06 Dec 2023 00:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701850068; x=1702454868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQs1tBDeBArGiy5BcNbBISb6CjBeCeN43pkueKe8VvQ=;
        b=QwUzK3/sH669xTYLGyNDAf/G5AsfsVuoXVz/2WrjkdbaVwfiFEHQWjaOC20K/5YeMC
         Kv/f5qNXaEwB5ypH3m4s9QlRoBaYaNXyWj2GlO9a00PAwcBLgnXq/fJOtEu0mrqeCN6i
         ZdunbEA6WaFl+Dm0pQ6hHvCeyeUOgy3joufvVxPC/jTISgNbgedVHfRIcarH8QNGxSYO
         0diL8XvuZMw/xH2fqOwxUwrHBd2Yile1BePQgM6nFXH6v1aziUm1csmK2Ei0j3YN8Rs4
         aFgD384xP3TvPg0gcQ6Kv1zsu0LpOgJK1eegJXvY6L6ilg4mCwILtZMVUCciZmUyB2B5
         1t/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701850068; x=1702454868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQs1tBDeBArGiy5BcNbBISb6CjBeCeN43pkueKe8VvQ=;
        b=QQ7DUPklMzSWyHbw3HSkJPGDZ0fZ2hrUP3ajOVNh+d0eH9FU9B7HkytBVXop8kiisR
         0/z98y6FGUNu0szJtcVeRsW/I5E63A+OVbajpAD+ztD7y6GKBXXUXFR1brhXNMWUo2p9
         mVtnd0Y+09ilu9WJNPx6XKylBY88ny0nkYkPRH4M6+NW2xh+A0tTCgDRYpRKSrclpGZ4
         VSLBEEocTaweJ0EgGHWlgcN1EmqaLI2KSVQ3VFexsMb0d413r5NJGlmisTmBPmkCHdo7
         b05pBnAb4t+GEjpGYy0YfipdIM+3aFOd02E0BGXH21upO9wD21YpW1C1vb0b8n36Z17y
         AUSQ==
X-Gm-Message-State: AOJu0Yw+zbszXQVsiLv6XwvXPLCbAdArku1X2DsRdIojHEc7h4e+sioZ
	gDSKfxxYFhW9gfNiiKoDXbo=
X-Google-Smtp-Source: AGHT+IEF5WTGMSXs2XI4JQTZ5IX+RokPr4Z0YSTz15xzPMJI2yxlIT+cbg4hYKjd406Ig7jkza+qYw==
X-Received: by 2002:a2e:b0f4:0:b0:2c9:f803:7c05 with SMTP id h20-20020a2eb0f4000000b002c9f8037c05mr351513ljl.1.1701850068351;
        Wed, 06 Dec 2023 00:07:48 -0800 (PST)
Received: from PC10319.67 ([82.97.198.254])
        by smtp.googlemail.com with ESMTPSA id w3-20020a05651c118300b002ca044c17d0sm864780ljo.62.2023.12.06.00.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 00:07:48 -0800 (PST)
From: Konstantin Aladyshev <aladyshev22@gmail.com>
To: 
Cc: gregkh@linuxfoundation.org,
	benjamin.tissoires@redhat.com,
	aladyshev22@gmail.com,
	ivan.orlov0322@gmail.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	john@keeping.me.uk,
	lee@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/1] usb: gadget: f_hid: fix report descriptor allocation
Date: Wed,  6 Dec 2023 11:07:44 +0300
Message-Id: <20231206080744.253-2-aladyshev22@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231206080744.253-1-aladyshev22@gmail.com>
References: <20231206080744.253-1-aladyshev22@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 89ff3dfac604 ("usb: gadget: f_hid: fix f_hidg lifetime vs
cdev") has introduced a bug that leads to hid device corruption after
the replug operation.
Reverse device managed memory allocation for the report descriptor
to fix the issue.

Tested:
This change was tested on the AMD EthanolX CRB server with the BMC
based on the OpenBMC distribution. The BMC provides KVM functionality
via the USB gadget device:
- before: KVM page refresh results in a broken USB device,
- after: KVM page refresh works without any issues.

Fixes: 89ff3dfac604 ("usb: gadget: f_hid: fix f_hidg lifetime vs cdev")
Cc: stable@vger.kernel.org
Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
 drivers/usb/gadget/function/f_hid.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index ea85e2c701a1..3c8a9dd585c0 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -92,6 +92,7 @@ static void hidg_release(struct device *dev)
 {
 	struct f_hidg *hidg = container_of(dev, struct f_hidg, dev);
 
+	kfree(hidg->report_desc);
 	kfree(hidg->set_report_buf);
 	kfree(hidg);
 }
@@ -1287,9 +1288,9 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 	hidg->report_length = opts->report_length;
 	hidg->report_desc_length = opts->report_desc_length;
 	if (opts->report_desc) {
-		hidg->report_desc = devm_kmemdup(&hidg->dev, opts->report_desc,
-						 opts->report_desc_length,
-						 GFP_KERNEL);
+		hidg->report_desc = kmemdup(opts->report_desc,
+					    opts->report_desc_length,
+					    GFP_KERNEL);
 		if (!hidg->report_desc) {
 			ret = -ENOMEM;
 			goto err_put_device;
-- 
2.25.1


