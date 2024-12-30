Return-Path: <stable+bounces-106283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 226EC9FE677
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 14:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004A73A2222
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 13:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C4D1A840E;
	Mon, 30 Dec 2024 13:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H/06P6aP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97B918EB0
	for <stable@vger.kernel.org>; Mon, 30 Dec 2024 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735565435; cv=none; b=cyQJDioWFwdnR9gsTFWI3+kFFFgBOfV++NGysRIFTDtE+9nrlmp36DNd2xS4DPb0ZC1DzuGVAVFryBdX+2ROWuK3tCW4UTLMQfplX4gyac4E0aEd6nUNloqaPgObn/oa+a9EmHMa2ANgrv2OV91DQODT7lIX9gRCYAIwGQIT0mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735565435; c=relaxed/simple;
	bh=hTxYE4ZKAFH1aRDR8sJ5Nb399xU6yuWM2PXt4q5N0Qc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZZn/68cL4gj7sdOzTxULLxuVaa1puuCkvwnajj43PGvXwiqvXi097sYsdzSPliKPb63mnODl9+G41n9vVJgRufYOkL3kf5D+F9fSyDisFGhtYo+30Kn+C8EJHVbs52SUwIPZcJZBRCH5jdHHFmoQYL+ixLH8TJlGYC0YbYnZORE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H/06P6aP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361c705434so66730565e9.3
        for <stable@vger.kernel.org>; Mon, 30 Dec 2024 05:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735565430; x=1736170230; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vTrM0yyDJXD9bFtEtBPUoCeH8j7YG6AaFMdrnGgLcok=;
        b=H/06P6aPmG6MBZABZ5zR9h5oUJAUuZSeR8FT60yK4ePvy7L0vSPMLRqL3UYm9h5Y4F
         QNGm+CfKfUBvanSfH39a6DnEqaBJK8QSU13OoLQ+Rk6K8+hu7Pja/IOtalMtYcONSlnS
         kntgxur46+Kc292/N3obmycccDXVOy4xm8HCWwZM3TAaOxANUiKaIFR5DxbsfVtuSP6w
         duA8FpPD4XncsULA0aa/+WXP/qB5wQ92jTy/juu8XYLtNA60X4BAg1pCEiB+OqTAMGYx
         1/VNjzyDuniLQR4RWNj3Hf/V5vk4b8xK4zjdOwau92A5TRqetzTtWIsCAt8tum67b3pE
         EKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735565430; x=1736170230;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTrM0yyDJXD9bFtEtBPUoCeH8j7YG6AaFMdrnGgLcok=;
        b=ZEGCX0GxPAV2GAQWNHKy9ISLP7x/KnizgTYcY5L8DlTEQ0J2Z1o/Xy1KfCyVBFZ8Q6
         HwTOnAALJiajg7IUnrqCAdGydtnlXUdvKwntT59M+wQYuRsiflpj1MAKz/GcmShLvBeU
         tw7AAIQ82xf0KWfUmk+TG81flI+QHiYMVBtCYY1tfc7SJtco4SzKqYNZo/IQdMenXdLK
         OtClpHWIzOWN30yqFBoe8JfVFqe4JnfXcJZdR6Hxnx6Jp6QI8JqSp/P7fNRFDRjWuHX1
         xJipFna7y1Io6lN4NuRq//X4unnMAB/alZp3G2uDAlL3xuxJG+TppFlfQxurTH7WX/LE
         VaPw==
X-Forwarded-Encrypted: i=1; AJvYcCVnWuiBT8RgQydvhXSg0sxpUh4wUXGnDqqq7BAWzNaCV3NpBL/N+IwPO8arykWMVHaBILic400=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDA5pt1Pxk0VK96J9HmuGi3WDGqfFAouH2n+vC+RjvHbQpMaB2
	2bgV37PjGROk56hVIGiIyOjcRFAOYwqYPPFJJxRDsh91JcFSefaMar/LEpM7ek8=
X-Gm-Gg: ASbGncv/1RgnJ/wX70CoIRvQdHlAj/H5gawbOxT1eXlFMhds/l7Fq701KN8YWPy+ORb
	Ykw6NK2Y5h3p/2bRnflTL+bcWNa9XDC9s7MkU/pFQuPu+4jzjcikjUqdpEFM4PyZq4W4d8BbJAD
	Eri6Nn+ga6fM1H7z2FVZeE0/Awl4MZ3o/VDo8aFqDHrJs/gqIHp6m8pEsp+oyxuYUBBc64WOc0U
	hsyKABjvLNg+sOVTvm5DaRSA/8bHtmrqY82/x+b47VZrMz/wwgcvftKfBiKF40UHg==
X-Google-Smtp-Source: AGHT+IHJ9du+ewY/Bdye9mAK+cfBMiFQ5y7C32fk0dJ22m8Y8FLixLbLTHjqYrU9c2M4dMtGjd4GKw==
X-Received: by 2002:a05:600c:1d03:b0:434:a529:3b87 with SMTP id 5b1f17b1804b1-4366864313dmr372503735e9.10.1735565430054;
        Mon, 30 Dec 2024 05:30:30 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c828d39sm31079082f8f.9.2024.12.30.05.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 05:30:28 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v9 0/4] clk: qcom: Add support for multiple power-domains
 for a clock controller.
Date: Mon, 30 Dec 2024 13:30:17 +0000
Message-Id: <20241230-b4-linux-next-24-11-18-clock-multiple-power-domains-v9-0-f15fb405efa5@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGmgcmcC/63RTW7DIBAF4KtErEsFw/DjrnqPqgsMOEF1jIUTN
 1WUu3eSTV1553b5ZvE+ZriyKdWcJvayu7Ka5jzlMlBonnYsHPywTzxHygwEoJTS8RZ5n4fzhQ/
 pcuKAXEpO49CX8MGP5/6Uxz7xsXymymM5+jxM3OuuaTAG1OAZNY81dfnyUN/eKR/ydCr16/GIW
 d6nf/NmyQVvrYc2Omi9sq9U4Wt5LnXP7uAMCwT0NgQI8TpZrTHahHqFqCVitiGKEKdM9FEpDdK
 vEFwidhuChKBCF1GE1qj1JnqJbPwTTUjw4MAENE7iCjFLpNmGGEIA0RlvhGudWSH2BwEq3IRYQ
 mxSArooGnRuhbh/QBwhOjYqpK6Rwv8+1+12+wbZxoNrugMAAA==
X-Change-ID: 20241118-b4-linux-next-24-11-18-clock-multiple-power-domains-a5f994dc452a
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-1b0d6

Changes in v9:
- Added patch to unwind pm subdomains in reverse order.
  It would also be possible to squash this patch into patch#2 but,
  my own preference is for more granular patches like this instead of
  "slipping in" functional changes in larger patches like #2. - bod
- Unwinding pm subdomain on error in patch #2.
  To facilitate this change patch #1 was created - Vlad
- Drops Bjorn's RB on patch #2. There is a small churn in this patch
  but enough that a reviewer might reasonably expect RB to be given again.
- Amends commit log for patch #3 further.
  v8 added a lot to the commit log to provide further information but, it
  is clear from the comments I received on the commit log that the added
  verbiage was occlusive not elucidative.
  Reduce down the commit log of patch #3 - especially Q&A item #1.
  Sometimes less is more.
- Link to v8: https://lore.kernel.org/r/20241211-b4-linux-next-24-11-18-clock-multiple-power-domains-v8-0-5d93cef910a4@linaro.org

Changes in v8:
- Picks up change I agreed with Vlad but failed to cherry-pick into my b4
  tree - Vlad/Bod
- Rewords the commit log for patch #3. As I read it I decided I might
  translate bits of it from thought-stream into English - Bod
- Link to v7: https://lore.kernel.org/r/20241211-b4-linux-next-24-11-18-clock-multiple-power-domains-v7-0-7e302fd09488@linaro.org

Changes in v7:
- Expand commit log in patch #3
  I've discussed with Bjorn on IRC and video what to put into the log here
  and captured most of what we discussed.

  Mostly the point here is voting for voltages in the power-domain list
  is up to the drivers to do with performance states/opp-tables not for the
  GDSC code. - Bjorn/Bryan
- Link to v6: https://lore.kernel.org/r/20241129-b4-linux-next-24-11-18-clock-multiple-power-domains-v6-0-24486a608b86@linaro.org

Changes in v6:
- Passes NULL to second parameter of devm_pm_domain_attach_list - Vlad
- Link to v5: https://lore.kernel.org/r/20241128-b4-linux-next-24-11-18-clock-multiple-power-domains-v5-0-ca2826c46814@linaro.org

Changes in v5:
- In-lines devm_pm_domain_attach_list() in probe() directly - Vlad
- Link to v4: https://lore.kernel.org/r/20241127-b4-linux-next-24-11-18-clock-multiple-power-domains-v4-0-4348d40cb635@linaro.org

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
Bryan O'Donoghue (4):
      clk: qcom: gdsc: Release pm subdomains in reverse add order
      clk: qcom: gdsc: Capture pm_genpd_add_subdomain result code
      clk: qcom: common: Add support for power-domain attachment
      clk: qcom: Support attaching GDSCs to multiple parents

 drivers/clk/qcom/common.c |  6 ++++
 drivers/clk/qcom/gdsc.c   | 75 +++++++++++++++++++++++++++++++++++++++--------
 drivers/clk/qcom/gdsc.h   |  1 +
 3 files changed, 69 insertions(+), 13 deletions(-)
---
base-commit: 8155b4ef3466f0e289e8fcc9e6e62f3f4dceeac2
change-id: 20241118-b4-linux-next-24-11-18-clock-multiple-power-domains-a5f994dc452a

Best regards,
-- 
Bryan O'Donoghue <bryan.odonoghue@linaro.org>


