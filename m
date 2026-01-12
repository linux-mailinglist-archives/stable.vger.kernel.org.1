Return-Path: <stable+bounces-208105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BE033D120DC
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 11:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6ECD4304DD93
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 10:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A7934DB5E;
	Mon, 12 Jan 2026 10:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BxOVawWv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jadfiZ+H"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEBD34DB48
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768215067; cv=none; b=GJmc2uYLixxzgyEGViGj0EK2RcRw2gED/cnEhcZhVkQ8EgqMDsXCq5cpwFtJrvUtW/AqWBwEh0Y2z7A2H1CsASuoxkeKk90wj05bYwRrHekxUa9P/xMJ2mE48+7ky8rOnoiyAb3ehiB8D3sdUW1qXVJPk/zbO31PXBK0vJ6/Lfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768215067; c=relaxed/simple;
	bh=qn81jSxXE2ZNIqVoT+2KYOidPj8r0ehhfT/v06m3aHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sPfJk8Un+b7ZVYl4k4oZPkCL0JROPO3bQ2mIcp/RClU1PvRNCeWxXQvtdUZtAg6p1qqSnY6QmHit82bDQ7AwTmPGSmVGBkgb1Mn9yV9wS3eiilIKc2R3MWAddRYPLB65rciKpCHp3BsAV94BB+4/JLcIWYNrKKvLxous7hlnJGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BxOVawWv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jadfiZ+H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60CA6lYn1381076
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 10:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=NbdJXdAlcYq
	FY5NM36KoY0ZIkXbsF1k2EitF3DDt1o4=; b=BxOVawWvf8fFhK3NrL90B/H95yu
	KSX+FWW8kr5ZO6/1T9AIyv+o6oafzVranRr9AxBnGSojHpR2wM2DFXrb4SGL5qMV
	Jfx/b9tiBfU4ULxWowkMf91aJSgk+qoU6ZovIW8CWK2lkNxw8FfpzazOy7UqTaks
	hUx5g3vosY++Khv+3tbGFQon8zZ4C34K+U/UabKwcPLgZIIp8VRFhzUHUBey3t1z
	19r516bXadRvXSkbUiMPh9aGKmmmkqT5KqLxCE850L7H7NyiHzGDlQ3jh/bxdVjd
	fNQytQK8bXxYG2KB1soL2bifmwaR1Z7R9CInYxnomUQ4PUYxcabA06Nda4Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bmxwv03kt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 10:51:03 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8bbe16e0a34so1539315685a.1
        for <stable@vger.kernel.org>; Mon, 12 Jan 2026 02:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768215063; x=1768819863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbdJXdAlcYqFY5NM36KoY0ZIkXbsF1k2EitF3DDt1o4=;
        b=jadfiZ+HokSpOrirtOe1Osp5yh2YrEzJTQ34QNFXNp5crqLkzrg2iUgj3wQFP8MQd+
         DEMvnOQP0slKJppLYEH7VOMcPiRaotDoo+dXhLWYzUajpYkyFqRiBq7rLGX0LXbpNZQl
         WOkOv+7+ripMwuBRQS3OnihAueOJJZGr09DYHlDtB3nEhGxO303XsXc5D4ff++912Bth
         uv0UbI3zFrCOAC65MKbaEsb7U46zU0WF6a//oFTNgVAe75DjbasZq19UD0Hfs0//jMUv
         0PuSWEW/mHBvD1UdXoptBLHtKZBv3ft607CoiXVNTDCdfT6N45Ly4pb0/f7H1e9MvYM9
         TLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768215063; x=1768819863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NbdJXdAlcYqFY5NM36KoY0ZIkXbsF1k2EitF3DDt1o4=;
        b=X1CQlHWJTwgEHokgr4cpLDG0lu8LolzYxa9/a+HnEvGGCfM1+yz/mQsDv4YmT4tuGY
         K38RAsECV7UhXrSpNbqHi786G3S17thVXrTJoyZRnamqfZ3eP1mVIyD6toYOjvFZqQ1t
         ysAuQch+ls0xbllQSfQdGVWXcOvgB2JHtY+eHL21Ajk8ZQGQcXOcTAa7TEU9vh9E07wu
         2XGz3tcLEQ/J7zNJ5dp/bcevwPzYYesbpwSQNrIkBsJB1AofJoelRRYczariXWVaYlm2
         wFqIsy/fqDlvRdjJnBxcbWGM8TtkvpGHnCc0EmG9S69sTvECMIsNzdrNPa24b2dsnrc1
         WZ8Q==
X-Gm-Message-State: AOJu0YwnU+I1bKSGqUmBr/SdPNSL/5yn6ExqDAKQ+GBUlYWTMWv0m8+H
	pGmxv11bb9W4xC/omgpUSB/suwFlzozF7FxyaKEknlcZJY2s2XjcXk4LWyOx5o05izy764MEp5Q
	QAfVfh9TEtp4BfgIWE5cuA3kqcpcU8MEHHLZhi2W4VrNhWAe2e68GpZtn0Gc920LUsQ4=
X-Gm-Gg: AY/fxX6EN5sRja62r4unupvzU4mLDV76GqhdM7NziiyQy87iD5d6z+ilo7ziAWLd7rL
	ILuU726OJ6Hs/+K/yPSw598kX/1S6hGgWTR1gd/Skb8PJKzNjKv7r5kILS59XIibO3eC5ZbiV5f
	DiltfSl6U4zdA1JarAwtwvZ2G+dUlyxppZDtOkD0egPCjnqOzHZo9a9U5ZYj3ZSAKXT1c+uMBXR
	BNgBX2L7YiJLoWyczf5FEt4aMz7LflukbNHUCm4+65xDKRbQrXBnSO22i9fJJGFXPLPGiuqJHKQ
	iLMECkevtlFuuy5eefPwnsUWuQonADEiUxgQg/adof1dtVM4JFGoLOy3mpbkEjLL3zIJAQsehxx
	wDa0oOO1SamZLqV7gl110eeQ5xSa8NniniJyEBRI=
X-Received: by 2002:a05:620a:3911:b0:88e:1be9:cf65 with SMTP id af79cd13be357-8c37f54ead9mr3038892685a.39.1768215063181;
        Mon, 12 Jan 2026 02:51:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDXA4ZFw4GsMRoMyh1berHhQxbCtXdI4CSyPV3mQ2K0HKjjYlMKUWL+JLMLrnIx20fVl+JJQ==
X-Received: by 2002:a05:620a:3911:b0:88e:1be9:cf65 with SMTP id af79cd13be357-8c37f54ead9mr3038890585a.39.1768215062660;
        Mon, 12 Jan 2026 02:51:02 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:eb74:bf66:83a8:4e98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ff319sm38582444f8f.43.2026.01.12.02.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 02:51:02 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Val Packett <val@packett.cool>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linusw@kernel.org>
Subject: [PATCH 6.1.y 5.15.y] pinctrl: qcom: lpass-lpi: mark the GPIO controller as sleeping
Date: Mon, 12 Jan 2026 11:50:51 +0100
Message-ID: <20260112105051.16763-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026011236-imaginary-sweep-d796@gregkh>
References: <2026011236-imaginary-sweep-d796@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: FHFvzyEpuF5JBQotG5O0K50lp1HWNmBf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA4NiBTYWx0ZWRfXwgpVIcP+GVbk
 T0wZzPM1IfrWysCPi0yqZprlYdJOC+/xuRH9X6kGAqLQdYirK8f4xsCcyd6FV0XdN/7vo58TB4q
 6XNkcl/2Xb/A/+hi+2UmciSJVuetBGTxCcBNaBwgDvv1F52MAhBCb6+vxqCumFkHvKdZw6Uli2W
 gsh4kZtLSujGZj6vl0W51WOlNayXlQqEz7opS5qnOHiNVus1YpuEEGfkh/aNNFz2045qKa4r/TR
 Dm2aAwszAjXx//Dekj2ESMTM8L2vq2L6u2wZ/2w+NZj/CFjJkAAVyX4fN0cwfH9N5PBj+5stYVv
 zE02fE7/yOlAD758MTEkoy9dalUm4OFQzM8F1O8dj5sEr2QLm7sgL2vH8mmI5qQLUVtruBIX0FC
 bKbwiioQuc7eGUhTDsBBYawcPnotyXnOL1Q46eHuaIix+q2UVVsiDn12MjQpWHPW0Pjojt29GNQ
 4qzOV7Etw4iXt3PY91A==
X-Proofpoint-ORIG-GUID: FHFvzyEpuF5JBQotG5O0K50lp1HWNmBf
X-Authority-Analysis: v=2.4 cv=C/XkCAP+ c=1 sm=1 tr=0 ts=6964d217 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=F48zptHLiEJlYAEWnQIA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601120086

The gpio_chip settings in this driver say the controller can't sleep
but it actually uses a mutex for synchronization. This triggers the
following BUG():

[    9.233659] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:281
[    9.233665] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 554, name: (udev-worker)
[    9.233669] preempt_count: 1, expected: 0
[    9.233673] RCU nest depth: 0, expected: 0
[    9.233688] Tainted: [W]=WARN
[    9.233690] Hardware name: Dell Inc. Latitude 7455/0FK7MX, BIOS 2.10.1 05/20/2025
[    9.233694] Call trace:
[    9.233696]  show_stack+0x24/0x38 (C)
[    9.233709]  dump_stack_lvl+0x40/0x88
[    9.233716]  dump_stack+0x18/0x24
[    9.233722]  __might_resched+0x148/0x160
[    9.233731]  __might_sleep+0x38/0x98
[    9.233736]  mutex_lock+0x30/0xd8
[    9.233749]  lpi_config_set+0x2e8/0x3c8 [pinctrl_lpass_lpi]
[    9.233757]  lpi_gpio_direction_output+0x58/0x90 [pinctrl_lpass_lpi]
[    9.233761]  gpiod_direction_output_raw_commit+0x110/0x428
[    9.233772]  gpiod_direction_output_nonotify+0x234/0x358
[    9.233779]  gpiod_direction_output+0x38/0xd0
[    9.233786]  gpio_shared_proxy_direction_output+0xb8/0x2a8 [gpio_shared_proxy]
[    9.233792]  gpiod_direction_output_raw_commit+0x110/0x428
[    9.233799]  gpiod_direction_output_nonotify+0x234/0x358
[    9.233806]  gpiod_configure_flags+0x2c0/0x580
[    9.233812]  gpiod_find_and_request+0x358/0x4f8
[    9.233819]  gpiod_get_index+0x7c/0x98
[    9.233826]  devm_gpiod_get+0x34/0xb0
[    9.233829]  reset_gpio_probe+0x58/0x128 [reset_gpio]
[    9.233836]  auxiliary_bus_probe+0xb0/0xf0
[    9.233845]  really_probe+0x14c/0x450
[    9.233853]  __driver_probe_device+0xb0/0x188
[    9.233858]  driver_probe_device+0x4c/0x250
[    9.233863]  __driver_attach+0xf8/0x2a0
[    9.233868]  bus_for_each_dev+0xf8/0x158
[    9.233872]  driver_attach+0x30/0x48
[    9.233876]  bus_add_driver+0x158/0x2b8
[    9.233880]  driver_register+0x74/0x118
[    9.233886]  __auxiliary_driver_register+0x94/0xe8
[    9.233893]  init_module+0x34/0xfd0 [reset_gpio]
[    9.233898]  do_one_initcall+0xec/0x300
[    9.233903]  do_init_module+0x64/0x260
[    9.233910]  load_module+0x16c4/0x1900
[    9.233915]  __arm64_sys_finit_module+0x24c/0x378
[    9.233919]  invoke_syscall+0x4c/0xe8
[    9.233925]  el0_svc_common+0x8c/0xf0
[    9.233929]  do_el0_svc+0x28/0x40
[    9.233934]  el0_svc+0x38/0x100
[    9.233938]  el0t_64_sync_handler+0x84/0x130
[    9.233943]  el0t_64_sync+0x17c/0x180

Mark the controller as sleeping.

Fixes: 6e261d1090d6 ("pinctrl: qcom: Add sm8250 lpass lpi pinctrl driver")
Cc: stable@vger.kernel.org
Reported-by: Val Packett <val@packett.cool>
Closes: https://lore.kernel.org/all/98c0f185-b0e0-49ea-896c-f3972dd011ca@packett.cool/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
index bfcc5c45b8fa..35f46ca4cf9f 100644
--- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
@@ -435,7 +435,7 @@ int lpi_pinctrl_probe(struct platform_device *pdev)
 	pctrl->chip.ngpio = data->npins;
 	pctrl->chip.label = dev_name(dev);
 	pctrl->chip.of_gpio_n_cells = 2;
-	pctrl->chip.can_sleep = false;
+	pctrl->chip.can_sleep = true;
 
 	mutex_init(&pctrl->lock);
 
-- 
2.47.3


