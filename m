Return-Path: <stable+bounces-100156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D82D79E92BE
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 12:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADC461885160
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 11:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE6D2206A1;
	Mon,  9 Dec 2024 11:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mOs4K6WK"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7993721D008
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 11:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745036; cv=none; b=nMi/1IlgtBOZPL1aAmQedF+njVnzay+O/nURHapZ4Kj3gP1/rYszvQQ/XHCHQsfIUSk1z3CYZbOqWow66E7Af13+59VZ3Tgys8R4wWyO2X/rob7lZ+ohpUX7iZCPDpRX8oxwWsqGz2YHKd4Wo6eAh55e4hJgz7h8t0kj8ssf17A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745036; c=relaxed/simple;
	bh=tRg2JG4yWbf9I5B7TpSxC1gfaa7C/jgTm+c+epd0rvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=n1pgTgeR7r3TOL+CmWqMNQan1ajGflvcMn5g5ObziAzl2UFkaAQ8WA863Fd0JxmVMVV4fSIYPlkVmuHjAdDoqpE1L7CzkxPfa30QHfdmbE1+/KnhImBGQpV+0pzVBoGkyoeWFVVeG9eUrAoO5Tn+IIIbOsEdie/bpMo9ydkrd5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mOs4K6WK; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa69077b93fso69013566b.0
        for <stable@vger.kernel.org>; Mon, 09 Dec 2024 03:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733745033; x=1734349833; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ATPIw4OMF8nAB/PeB65ti7ZSBIJFQfds55Da014vBnU=;
        b=mOs4K6WKK77THOpTqSZkDQl/Lz7kzvtwMEefQqMLcsjL0jIS51b/9EvcepX6bRhNlB
         eC6StCJY+QPzu4LQ0kydcf4uWs927Cj5R0ZELooduYc5wrcB83OVgD2tXxPnJ9aQUw2i
         bYYz5aakyduHFT9CaWN9QM7YQs8V0hzjAkMGrp6EwHkYHMJ0nKHJq6h/fFKJCuFOPf8y
         uB+/hEHSnzzZd7ZRbiz2SCZOEryyI5iSLIJyB4Jq2SWCUfjXhncIgoWFBD2Bgiu3inj/
         XvMgPkDCcTZDLiheGa3TbIO2sj6bGmQBjHTIT3GOz08vfHiGIeSbIEvBC6XNwa+UpA9s
         m92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733745033; x=1734349833;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ATPIw4OMF8nAB/PeB65ti7ZSBIJFQfds55Da014vBnU=;
        b=WXzsqlo7LzinrauTHF7sk8ekrg0F3zhpi8u5Q8aw2VS7NNtuNU/eoNFfUEV7P4RVGQ
         O0T4Z7O0asxxj9j6xePzq2bcI67KzvWxtZL+zPSI3RSgds/yRA9EMnUDS85mSlmmpQLf
         lM6jfio9diW2SIuWOIIxmohJ69hKm0r1B4CEFbuCvFXZEDymsxPXaaDDFq8rhi1aT4am
         aJ6WgjWfycmPp7Efda5ymNpJyDiFAnaXSrBFDtJnYIeXHoGmDl5pihPQ4aJA03kp7VII
         WudhtIgZPo2AdbgjKSTzFgMn1AgO64F/AhVdy45IlxJs4T3mGGbeiWMAvA1G9GXJG2t+
         2+Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUvdhsqfs+I42azfDv7k1PGSOduOCi0YreHNy32W7HXuocOPxMAvTdnpXuz+iyGwJ7kSDX+UeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdKvjk8S5+b+XoPh3u2tCQ4WV1jLABQ/AYEfk/X5HiiwlpqP/8
	+nyDa8FkLGvRFpeO3rTaUYaF8qUoVHXuONcFv2dPGTIHrKW5MZwlSbEq7toY/uE=
X-Gm-Gg: ASbGncvl2UzlG+hUgeSq+tkf7EMVNz74WfxY0APdlJBgEnh9lsf9e45xnM2xYQRYL2l
	d3szcqRIUcZsVZNJsBXelx2S0bxVzfZXnQIfPRJ/ZjXpWvny1vJGuH/ayYZdDQtYnpzQfGNBG1D
	9n3AWw81JzBryOLAFglG5P0atNvzW5MelyZztZNDHSxcIUjaJCT47a0KJj4KBAnR95ddOlPAGvU
	48ot4fTzxgdg0cYpj45WQAksghfkbH7I8UyftHAOsGJ/a+YUgsQTC3A3n1SyekBIt57opCBn5we
	rBu4fGMxC26B5i+hUH6050nchsHb6eB3Bg==
X-Google-Smtp-Source: AGHT+IFO2lGH9JL+bzO4sp55jHNpx9YcfkNNqxmiJ5WgXHLLHG24iRvDXE2YESPMaen0HctcojXtcg==
X-Received: by 2002:a17:906:3cb1:b0:aa6:7df0:b17a with SMTP id a640c23a62f3a-aa67df0b300mr315812866b.34.1733745032872;
        Mon, 09 Dec 2024 03:50:32 -0800 (PST)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa66d479963sm301854966b.106.2024.12.09.03.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:50:32 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 09 Dec 2024 11:49:53 +0000
Subject: [PATCH v2] usb: dwc3: gadget: fix writing NYET threshold
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241209-dwc3-nyet-fix-v2-1-02755683345b@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGDZVmcC/3WMSw7CIBQAr9K8tc8ARVBX3sN0Ufm0LzFgoEGbh
 ruL3bucSWY2yC6Ry3DtNkiuUKYYGohDB2Yew+SQbGMQTEgumEL7Nj2G1S3o6YOanU9eWc0tk9C
 aV3JN77/70HimvMS07vvCf/bfqXDkKC79w2jplZT+9qQwpniMaYKh1voFKFSnUasAAAA=
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

Before writing a new value to the register, the old value needs to be
masked out for the new value to be programmed as intended, because at
least in some cases the reset value of that field is 0xf (max value).

At the moment, the dwc3 core initialises the threshold to the maximum
value (0xf), with the option to override it via a DT. No upstream DTs
seem to override it, therefore this commit doesn't change behaviour for
any upstream platform. Nevertheless, the code should be fixed to have
the desired outcome.

Do so.

Fixes: 80caf7d21adc ("usb: dwc3: add lpm erratum support")
Cc: stable@vger.kernel.org # 5.10+ (needs adjustment for 5.4)
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Changes in v2:
- change mask definitions to be consistent with other masks (Thinh)
- udpate commit message to clarify that in some cases the reset value
  is != 0
- Link to v1: https://lore.kernel.org/r/20241206-dwc3-nyet-fix-v1-1-293bc74f644f@linaro.org
---
For stable-5.4, the if() test is slightly different, so a separate
patch will be sent for it for the patch to apply.
---
 drivers/usb/dwc3/core.h   | 1 +
 drivers/usb/dwc3/gadget.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index ee73789326bc..f11570c8ffd0 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -464,6 +464,7 @@
 #define DWC3_DCTL_TRGTULST_SS_INACT	(DWC3_DCTL_TRGTULST(6))
 
 /* These apply for core versions 1.94a and later */
+#define DWC3_DCTL_NYET_THRES_MASK	(0xf << 20)
 #define DWC3_DCTL_NYET_THRES(n)		(((n) & 0xf) << 20)
 
 #define DWC3_DCTL_KEEP_CONNECT		BIT(19)
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 83dc7304d701..31a654c6f15b 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4195,8 +4195,10 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 		WARN_ONCE(DWC3_VER_IS_PRIOR(DWC3, 240A) && dwc->has_lpm_erratum,
 				"LPM Erratum not available on dwc3 revisions < 2.40a\n");
 
-		if (dwc->has_lpm_erratum && !DWC3_VER_IS_PRIOR(DWC3, 240A))
+		if (dwc->has_lpm_erratum && !DWC3_VER_IS_PRIOR(DWC3, 240A)) {
+			reg &= ~DWC3_DCTL_NYET_THRES_MASK;
 			reg |= DWC3_DCTL_NYET_THRES(dwc->lpm_nyet_threshold);
+		}
 
 		dwc3_gadget_dctl_write_safe(dwc, reg);
 	} else {

---
base-commit: c245a7a79602ccbee780c004c1e4abcda66aec32
change-id: 20241206-dwc3-nyet-fix-7085f6d71d04

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


