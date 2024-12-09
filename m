Return-Path: <stable+bounces-100157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAA19E92C4
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 12:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEB6528228E
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 11:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8FB22145C;
	Mon,  9 Dec 2024 11:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fQIEc8bu"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340DF21D008
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 11:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745063; cv=none; b=G1lYL7cHvb/lo1A+XOrxm7nTxrC7tnjGWbkNn338ZTdicQ6zpWzP+FLqRXBAWJjBnD/RE2Jd4rfWL4tYQqrowbmykrv4wdCanWuwc1/pkacEEWMSMslGm6+rLqfSwLAvkdRlXPile99jYXd50u+aQ1JJC9R7eDWUFQpRIpA8ric=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745063; c=relaxed/simple;
	bh=hDXV/1bil5Sbip3JdzwU/CVIebPwMcuyT26X0OLgQOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=I45HBTHezusEqlOfhgT+74e0YQyacPWBtbIg+2LYgAuBsIb4SgoXXvPiGUjtL3HLpGPUhqIOTmyMKaT9AGB23yTMj9oyXEoAioWUxScMlxYIlmmX1Z0hjxaDun7mOVC9F0/RsFCOe0KnmVzEnQ+4pmPr+0En9GPsuRvfflM7tzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fQIEc8bu; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3f57582a2so1781850a12.1
        for <stable@vger.kernel.org>; Mon, 09 Dec 2024 03:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733745059; x=1734349859; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2UThATHBfgQMuZzXlZec1zi4mZkLBkE7/Lnp3OOskfs=;
        b=fQIEc8buKOQ8JDqnJ8j62KqSJOUFvRDl00KSs3bX5Lz7Mmh45Y/FoAtLSN4uMHwof5
         IbDXVzri46JHO49Cks5v46pQ3QxIJ8nlRckwBkpWRi5XJLiJBvd5ohJCP/ixd/YrhE0q
         q9H6qhAb+GMApoWyFiZ8oNsC0IXTWyYvMDWjRjBd3tzxZFrLVh6CLoDuNtL3V/pQ1E7M
         11YhNu9wQmf9ZWDWvpl/6JH+wqCNE0McUDgU0VJrxe2v9AflRCVqziHMpCP/AEdSnOmO
         Jfx7OkKeWXXOOYg/9XfGJPhGZ2I2sNDeFgC2g+vN4xmPCwYq7weXYvJ32bUhuBXF7ARz
         DkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733745059; x=1734349859;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2UThATHBfgQMuZzXlZec1zi4mZkLBkE7/Lnp3OOskfs=;
        b=FjYQWfL4PUl2OEQFhgFfa4AvzjbmBCDyXS7Q8DILO9SGJfz+KRs3F3HC35CVXI4xdG
         xCNVaX2om/R9y8CRLNeGMol7Kk8xuj+gM40Bk8BghfmRxeTLXC+HNPnto3PBZX3BMLkF
         +D9POCiLQpgUP5B+FHN9lU8rPOaLer/uzTJR+oelB5WlIOnswGlrHTKwaACBPZxDkgOV
         qlfcTjtrqFDDiwkVyXZrxCiS/+5BWZFukUeLklNwbwAX2m0ROgeEz3s6oJcjQeFZPCqV
         lixzxs/wtejx6hJ5P+N/c/4oEonk/VuCvnflcoj6tkSDMC42/dDGSu5jV9Rc1AbIV3yg
         jv/w==
X-Forwarded-Encrypted: i=1; AJvYcCUEIMgm1u+jJzbamSEwyEF2PxoR+60abTeHq7SlNEv0Oy4ifI3u4Yvwb8wZh94h6em5WDAbM9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL2f9qImWQPngrJr4q+GZsa9ZvIdp545XlTkYHfRYozMWMTcLs
	cznelrvKnEBUL0hbxYoKVTLUfEEBpf464wEOY8gmcnZh0x6kAmM/sMb8f5KnPJ0=
X-Gm-Gg: ASbGnctLwJWSB2bN+hhF8tEIwMvzkdyYOJMlZs/USAgSFoMuSKzTQCLGSQhU52wC8CV
	1YpJ/I63NXDomz00eoxpJizLZPJOzei+RJPgTdwxRtD9+Wxer5KmRIdX3lvLfwIpvdtCH0dMzgC
	IMdEGNVjVrlFY6Y2ZfDKTt2eRljo6I6JwT9xIsSKEwwH4ePiSeywhzlq9QWXF5a7OTM9ZaZ/TjJ
	93PcaOWgq+pDfwI5oOoc3xcKDCIHAgsMQ6ZR9Ac4Ux3MuEwMzlDW6nOAEjJ/+SQr3ogzmgUOz7A
	cXZ+dGHH9fLr2nPOZkqZxVJGuign844biA==
X-Google-Smtp-Source: AGHT+IHT9zX4Tl6UkHikg9SBri7nnosBVvDw7I1G5fIqMYEisRPhgHI6J/Nc3IpufiZgaCPRxuXJGQ==
X-Received: by 2002:a17:906:2181:b0:aa6:86d1:c3f0 with SMTP id a640c23a62f3a-aa686d1f281mr342181766b.8.1733745059541;
        Mon, 09 Dec 2024 03:50:59 -0800 (PST)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa695c3ac07sm64169866b.66.2024.12.09.03.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:50:59 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 09 Dec 2024 11:50:57 +0000
Subject: [PATCH for stable 5.4 v2] usb: dwc3: gadget: fix writing NYET
 threshold
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241209-dwc3-nyet-fix-5-4-v2-1-66a67836ae70@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKDZVmcC/x2MQQqEMAwAv1JyNqLdqNSviIeqUQNSpS3qIv59y
 x6HYeaBwF44QKse8HxKkN0l0JmCcbVuYZQpMehCU6kLg9M1ftB9OeIsN1ZIaImbeiiNMVRD6g7
 PSf2fHcy7VyHaYWNV5QT9+/4AuLmLdnMAAAA=
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
Cc: stable@vger.kernel.org # 5.4 (needs adjustment for 5.10+)
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
* has been marked as v2, to be in line with the 5.10+ patch
* for stable-5.10+, the if() test is slightly different, so a separate
  patch has been sent for it for the patch to apply.
---
 drivers/usb/dwc3/core.h   | 1 +
 drivers/usb/dwc3/gadget.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 34f3fbba391b..e9835a1a8842 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -413,6 +413,7 @@
 #define DWC3_DCTL_TRGTULST_SS_INACT	(DWC3_DCTL_TRGTULST(6))
 
 /* These apply for core versions 1.94a and later */
+#define DWC3_DCTL_NYET_THRES_MASK	(0xf << 20)
 #define DWC3_DCTL_NYET_THRES(n)		(((n) & 0xf) << 20)
 
 #define DWC3_DCTL_KEEP_CONNECT		BIT(19)
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index ecb79156351f..e40cba594ba1 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3273,8 +3273,10 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 				&& dwc->has_lpm_erratum,
 				"LPM Erratum not available on dwc3 revisions < 2.40a\n");
 
-		if (dwc->has_lpm_erratum && dwc->revision >= DWC3_REVISION_240A)
+		if (dwc->has_lpm_erratum && dwc->revision >= DWC3_REVISION_240A) {
+			reg &= ~DWC3_DCTL_NYET_THRES_MASK;
 			reg |= DWC3_DCTL_NYET_THRES(dwc->lpm_nyet_threshold);
+		}
 
 		dwc3_writel(dwc->regs, DWC3_DCTL, reg);
 	} else {

---
base-commit: cd5b619ac41b6b1a8167380ca6655df7ccf5b5eb
change-id: 20241209-dwc3-nyet-fix-5-4-a4e76b199946

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


