Return-Path: <stable+bounces-95630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A2B9DAB11
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 16:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3926B21151
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 15:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE73200128;
	Wed, 27 Nov 2024 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="duLIiEhc"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA76820010F
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 15:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732722841; cv=none; b=nod5z+5E9enzoFZPaZo5cLDW+EZrK0xN0QEVz5KPnyKCWl6WmCUswiBMPe6K/6B9PDtAXkqIJnpJ1UgXlLj29VqLIjIq/Za6jD5b7NniDozr8seWfAgnWQABELovi6+c+7OqsKiBUP4pasQ98o2tC4bVxUAArQpHYlnVefJ7W+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732722841; c=relaxed/simple;
	bh=hF/YTlVocPM77faszRYKbbl9Rt5u0hVA5JF4+5rLVp0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qjs+W93F4BoH5vgORpOoCUoqV92VfjgXxzN3vciCClL3Ld6hdPyaXP6EtoxfxVhyONNkRyXBNs75ixxp4KsWfNThFnAIrzVaYemceZn1d69D6Od7qcdp8uv1DLfUPfvUWBz+mW1AG4/r8Jifl6PYFXsltgFd+POY9FvzZJAvkug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=duLIiEhc; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434a1fe2b43so25808185e9.2
        for <stable@vger.kernel.org>; Wed, 27 Nov 2024 07:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732722838; x=1733327638; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9oUdt6pCwwyslTUZpQiwFOGVATL3iwUtnEMbEHnDnqo=;
        b=duLIiEhcd03YObvWrnuYb1zUJDsqRHQkCxNjd6UVpea0WeWw24XxUPcDczHDI6yAMJ
         FeQFXkTi76Bz9sgnKFoUSsjAXmhjpi3XcV9JcedYt8/MJrvCOxvAyHyr4L0tQ982dQaK
         +FLXEKIG6twuS9nNAaHa+e+eEA9ItuS20eIP0vI/l75CsSpyb282DCy8ZC/9koSDAM9L
         BOWpRTiGNav+wiC16vIisv1Mjcy8nHB37ao20tGE95QZ+b6ffSF4+9YT7ItVJk//o/Wp
         RhIswt34tj+vrTRukDeTeGMvhFrZ0w+AYyZJ9Xj+zoJd3D4Bpl7diU327komEek6odin
         K3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732722838; x=1733327638;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9oUdt6pCwwyslTUZpQiwFOGVATL3iwUtnEMbEHnDnqo=;
        b=Q/dT7eWkiBlu5pafd0lG0fdsKnapmPt/maBR4t+o8Fj1qnI39KmXZgrFtckIpXmF0r
         0zgUKIHqsKgxeSEVh77p9MESYD/A/iCg8haPpzaNcskSChpdCBeCF37yeWKosIllcBhO
         94Ox2P1lr569yYPBTBfAXrIVPc1TCee4/sCXz39XGDPe1C7LxRQ8f5s5MfAgkC9Ixe5W
         0f+NiYKkmHTHn3MRf8lA9NW+A4UXlbdpTuKss+kUKlspv6umlPK5doRX5pAwVbAXwydu
         Ehhi6hyLf+C5unF0QKNDpsP+H3PkUBZKGJMQjclsrfdFgOR5Isn0Xavszz4rg7S5rm/x
         NZLw==
X-Forwarded-Encrypted: i=1; AJvYcCWKVwlMTKwI/T47mLCwJaVQ4DyAfc08UU3Ljn/2dI2qEbLZB/4mCdkf1eKlUBw+k40O4YbigSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3u1zC3TeUcd4MwshcBi+Qf2S7P/KShDgr1VZkt1StPj8l2XQW
	8jDMlh+5Woh+bwDAy/RUue9fAJY9FKWgrKdky9Sbp9HPNa3xsrqAvUJk78YqZARdIH8lqQ+Kr0C
	GEOA=
X-Gm-Gg: ASbGnctjsq0MauW8N6pr0PePTf3jlwUpM/5rFRO1V8lWggKhrlVCMyLAjokZ/1Ry2Nd
	niZWQy3waIjnxAU4Uaktxc+7EEfrR9b/CgkRvitxJ6wuR7bKWl/o2vQD1TsSQ5segGdxHIZIK3n
	+0JsiA+FRRy+pj9igu9N9uxBQRRwM3gtVfXx7/rWgHQDaY/wFNgxZFCZ6Op14mgFD3csshESldz
	ecz3Jb9l31XtQRhpw/MHowS8CTuWxiiPuKOBkMoa1a55SOGSlEDL+oc4Nw=
X-Google-Smtp-Source: AGHT+IG46S+9yGfMQWjsjldC2dZAKloi2rCEv/g2P2QTH9lCzksRtMp+EwSbxu06OLixkjB/yOS/HA==
X-Received: by 2002:a05:600c:350c:b0:434:a781:f5e2 with SMTP id 5b1f17b1804b1-434a9dc0c94mr34786405e9.8.1732722838211;
        Wed, 27 Nov 2024 07:53:58 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7d1a90sm24795235e9.32.2024.11.27.07.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 07:53:57 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v4 0/3] clk: qcom: Add support for multiple power-domains
 for a clock controller.
Date: Wed, 27 Nov 2024 15:53:53 +0000
Message-Id: <20241127-b4-linux-next-24-11-18-clock-multiple-power-domains-v4-0-4348d40cb635@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJFAR2cC/6XOsY7CMBAE0F9BrtkTXtskUPEfiGITL7Ai2JEdQ
 k4o/36GitN1XDlTzJuHypyEs9ouHirxKFliKMEuF6o9UzgxiC9Z4Qqt1rqGxkIn4TZB4GkAtKA
 1lLrtYnuB660bpO8Y+njnBD5eSUIGcsfNxvrWOiRVlvvER5le6v5Q8lnyENP368Son+3/vFHDC
 pqKsPE1NmSqXZmgFL9iOqknOOIbgu4zBAtCjivnrK/Yuj+IeUfWnyGmILVZe/LGONT0C5nn+Qe
 OBNAPwQEAAA==
X-Change-ID: 20241118-b4-linux-next-24-11-18-clock-multiple-power-domains-a5f994dc452a
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-355e8

v4:
- Adds Bjorn's RB to first patch - Bjorn
- Drops the 'd' in "and int" - Bjorn
- Amends commit log of patch 3 to capture a number of open questions -
  Bjorn

- Link to v3: https://lore.kernel.org/r/20241126-b4-linux-next-24-11-18-clock-multiple-power-domains-v3-0-836dad33521a@linaro.org

v3:
- Fixes commit log "per which" - Bryan 
- Link to v2: https://lore.kernel.org/r/20241125-b4-linux-next-24-11-18-clock-multiple-power-domains-v2-0-a5e7554d7e45@linaro.org

v2:
The main change in this version is Bjorn's pointing out that pm_runtime_*
inside of the gdsc_enable/gdsc_disable path would be recursive and cause a
lockdep splat. Dmitry alluded to this too.

Bjorn pointed to stuff being done lower in the gdsc_register() routine that
might be a starting point.

I iterated around that idea and came up with patch #3. When a gdsc has no
parent and the pd_list is non-NULL then attach that orphan GDSC to the
clock controller power-domain list.

Existing subdomain code in gdsc_register() will connect the parent GDSCs in
the clock-controller to the clock-controller subdomain, the new code here
does that same job for a list of power-domains the clock controller depends
on.

To Dmitry's point about MMCX and MCX dependencies for the registers inside
of the clock controller, I have switched off all references in a test dtsi
and confirmed that accessing the clock-controller regs themselves isn't
required.

On the second point I also verified my test branch with lockdep on which
was a concern with the pm_domain version of this solution but I wanted to
cover it anyway with the new approach for completeness sake.

Here's the item-by-item list of changes:

- Adds a patch to capture pm_genpd_add_subdomain() result code - Bryan
- Changes changelog of second patch to remove singleton and generally
  to make the commit log easier to understand - Bjorn
- Uses demv_pm_domain_attach_list - Vlad
- Changes error check to if (ret < 0 && ret != -EEXIST) - Vlad
- Retains passing &pd_data instead of NULL - because NULL doesn't do
  the same thing - Bryan/Vlad
- Retains standalone function qcom_cc_pds_attach() because the pd_data
  enumeration looks neater in a standalone function - Bryan/Vlad
- Drops pm_runtime in favour of gdsc_add_subdomain_list() for each
  power-domain in the pd_list.
  The pd_list will be whatever is pointed to by power-domains = <>
  in the dtsi - Bjorn
- Link to v1: https://lore.kernel.org/r/20241118-b4-linux-next-24-11-18-clock-multiple-power-domains-v1-0-b7a2bd82ba37@linaro.org

v1:
On x1e80100 and it's SKUs the Camera Clock Controller - CAMCC has
multiple power-domains which power it. Usually with a single power-domain
the core platform code will automatically switch on the singleton
power-domain for you. If you have multiple power-domains for a device, in
this case the clock controller, you need to switch those power-domains
on/off yourself.

The clock controllers can also contain Global Distributed
Switch Controllers - GDSCs which themselves can be referenced from dtsi
nodes ultimately triggering a gdsc_en() in drivers/clk/qcom/gdsc.c.

As an example:

cci0: cci@ac4a000 {
	power-domains = <&camcc TITAN_TOP_GDSC>;
};

This series adds the support to attach a power-domain list to the
clock-controllers and the GDSCs those controllers provide so that in the
case of the above example gdsc_toggle_logic() will trigger the power-domain
list with pm_runtime_resume_and_get() and pm_runtime_put_sync()
respectively.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
Bryan O'Donoghue (3):
      clk: qcom: gdsc: Capture pm_genpd_add_subdomain result code
      clk: qcom: common: Add support for power-domain attachment
      clk: qcom: Support attaching GDSCs to multiple parents

 drivers/clk/qcom/common.c | 21 +++++++++++++++++++++
 drivers/clk/qcom/gdsc.c   | 41 +++++++++++++++++++++++++++++++++++++++--
 drivers/clk/qcom/gdsc.h   |  1 +
 3 files changed, 61 insertions(+), 2 deletions(-)
---
base-commit: 744cf71b8bdfcdd77aaf58395e068b7457634b2c
change-id: 20241118-b4-linux-next-24-11-18-clock-multiple-power-domains-a5f994dc452a

Best regards,
-- 
Bryan O'Donoghue <bryan.odonoghue@linaro.org>


