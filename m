Return-Path: <stable+bounces-95572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5251E9D9FC0
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 00:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB27F168872
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 23:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBA91DFE29;
	Tue, 26 Nov 2024 23:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oCUdUsoi"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198261DFE09
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 23:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732664675; cv=none; b=d/4LCdV1XfIwaTZgC0J1BbEq+gQs31BsxqlS2Jwudfa+qKlnSErPK0C9BxD+IZ/8rYNeeOk6v72/Gjqm9BejqhhdakOtdj1+tPePQNdjSVsyIaF7A5+kxmYY50ihVZEkVwALwC+q9jFGa6Z/UTdeBvfv/vHpdMNVScnT/MZ6F/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732664675; c=relaxed/simple;
	bh=+fhFM24qdTFklU9m2XwiT7YHYQrJaiSziSmW70rJDQQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ppNCT4nDTFwN/d147WCPlw2h8eW3dTDJ55rshMytr65sgSafpc39v4+E6GGgaIABnzLUYXMVSd9AIyUMv+YRnj0WsscNj5Kbc+7Xnu6QpTEh4o81avtygAkTTUnboLXGj4muc/8HZ7a09oIRvLkrHy0KxBHG85Fr0rjZQfI8Ih4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oCUdUsoi; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso56623495e9.0
        for <stable@vger.kernel.org>; Tue, 26 Nov 2024 15:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732664671; x=1733269471; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CJmU59J+M2fvIhoTK/DsvENc1HKmlM36AHXQwtD2KaU=;
        b=oCUdUsoiFAyrnEu0aLgsolTfbOYpbUFi5xIt9YgPd8pRMrg/3XvGJ5Qg4CacbQg+w5
         iWugoTZqjVukKvzJTPnZEbxIzTloML3Cd9zgOT4XF3CBo2LvgRunwCp7k/9D5NmHIBW6
         42zKM0ZbUVFvFu35zyJgGxuNdpd/tpRIyOvWsiwnOxKKilUZh5P/C9C3TGovykzUdFQg
         m6TzK8aUNMiZ825IKMmotSdmiaGig76ctw5AIINf77ybxqXKsxvP0DMdlqSnnMNvzQ8e
         Hi9x0YHn+knMFQou2YVx3PTL5yUPi6cFDYsP/p+qOkhmanrQ+Bz+O6LJ2XmGvGnQuqqb
         ratQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732664671; x=1733269471;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CJmU59J+M2fvIhoTK/DsvENc1HKmlM36AHXQwtD2KaU=;
        b=Q4fi2UYYtox5KL+cKYgmjQmJGg5zYEiNuakthP1NprG3or3HsWCMZcHBcSRVK5/4yc
         eEW5drIzPp3RDmvB8SN78/OxITrwTYIgPyIbfSYcAlqmYFOWsWF9B4XCywIGGoVJT54i
         cQNyhHi7qTdxf9LqBNsNIcyCuSTsNI2ntTK3HCDuIJUplFhkznxBFUgx/j9LfPlt4OTD
         0EdSzHjfB76pQmFQhmSW64wVfdal7upHlfJybB39BAa/JNpdPd+6BrkattNcvyqoyHPq
         YHS5sCg5vbFM9fM2n/K27XOjJ7SCiWmVWRWZlFMeOlp+GhxF2eJvwxqhL8BwBfgCjsYg
         4bzw==
X-Forwarded-Encrypted: i=1; AJvYcCU8agj4XMMXypWZvqsJ7wJcVtm1zafP5MfudVPP8LhzDeJOA7mKnRihjXD3ws6mW0nvkC5ma/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIxsJ3KJF9AWmx4OYHmeDg4+ocpkNaG7IgMZZfl7E9jjv7Ru3o
	oyKW6gEAtQ19HKisz9lO7btYNtYOOE7nCKS5ZJKCbTDzHkbr46wp+4sApPaODgI=
X-Gm-Gg: ASbGnct9DV5DtZtSKpRsn4it0gFE8sO1EjOYqdig955oWzJqI9r924GUaV8Q6KOG8jI
	mvDtSuSf3F+V3nvfBa5R7vRjd05v80H3KL4Dy6QIAsE0UtDxiP0zlWGLdx3If0j+8hkiG/rvmtl
	sijia4b8ShMFfouQ7yw8ppfoSKUHiNB9HANOOOB/RmxhKOZlKQFuIRezkbZHcBYQ3i5p9o5DtC2
	2frCazIxim1NCejSseCUUtxe+AgJIWOxWdb3uiQ0EG7h/Lm8Ur4s30daOM=
X-Google-Smtp-Source: AGHT+IE8eKTrNeWUzbOE7vIWSLENBWD9fjmEpqowThwTsPT8/dFfLlB5O1ysxqfYmXhLujNL/goltg==
X-Received: by 2002:a05:600c:5253:b0:434:9da3:602b with SMTP id 5b1f17b1804b1-434a9dbc410mr8471415e9.5.1732664671287;
        Tue, 26 Nov 2024 15:44:31 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fafe338sm14482899f8f.33.2024.11.26.15.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 15:44:30 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v3 0/3] clk: qcom: Add support for multiple power-domains
 for a clock controller.
Date: Tue, 26 Nov 2024 23:44:26 +0000
Message-Id: <20241126-b4-linux-next-24-11-18-clock-multiple-power-domains-v3-0-836dad33521a@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFpdRmcC/6XOwQ6CMBAE0F8hPbvGrm0AT/6H8VDoKhuxJS0gx
 vDvFk561ePMYd68RKTAFMUhe4lAI0f2LoX9JhN1Y9yVgG3KAneopJQFVApadsMEjqYeUIGUkOq
 69fUN7kPbc9cSdP5BAay/G3YRjL6UpbK10mhEWu4CXXha1dM55YZj78NzPTHKpf3PGyXsoMoNV
 rbAyuzzY5owwW99uIoFHPEDQf0bggkxmnKtlc1J6S9knuc33akzplwBAAA=
X-Change-ID: 20241118-b4-linux-next-24-11-18-clock-multiple-power-domains-a5f994dc452a
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-355e8

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
      driver: clk: qcom: Support attaching subdomain list to multiple parents

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


