Return-Path: <stable+bounces-205053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D900CF761E
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 10:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 124513017F04
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 09:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A27F30BB8E;
	Tue,  6 Jan 2026 09:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dJnxGMIA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jWRB7PS/"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766C62750ED
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 09:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767690021; cv=none; b=pRb048IHOg/ub/zizNqsvm2Xdzv0sXJ2ckvUKK1UnRDap8aza4r5x3JSYG5KCoersON/ywRTIYaQJigS/Hl/GHrUeim22RJsCZR8Q3IgHXltISkEtP1EVcMrLPBbmBP/5ELdgNIbuOmEqqRUEoGDlIxxOsjVFKtcQtrt1/jYAh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767690021; c=relaxed/simple;
	bh=w/A977JRSXpQfJbkXr/2XYvk5k4zy1OWbRcWorwj+Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V98/Ze9TgvAToOdMLi2aj+uhOpRIBOG8jlN8FzA79u/nIWXZuRsFk5alZJKcuQ8uhl86yYSvTvqHyJMmPsxkrvOy8HYPytRzX594unbHU7ZJH36Up7CGXsK7iwvQWY3/hoHmGsI87obwAcWoJgCKqkAXD1f1WVAB7rW/V+Pmn48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dJnxGMIA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jWRB7PS/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6063QA942429874
	for <stable@vger.kernel.org>; Tue, 6 Jan 2026 09:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=zUmJx583wbIqbI/LnTq2qTUX5b+XpJNoiwx
	n1/rffoo=; b=dJnxGMIAyzB4PbZ6MmAJk5BnLsOhqj3GNT0QhtWZwCRCaqKJRyo
	6gq39vnXnOoszTprusZdSQL7N/GxoWO5RS9W5SnB2Z9bxmRCpjhCoC9moTOqLTr6
	Fe2SeWLCLC4YJ02HHKQZAmM1d3akRT4yENG52WyILRPHnGuOwmnTbyiMAmNiUD7j
	ieO4CHSTVkN358A4ndSushtRNHzpfeV2LqwAvWZQB1/6ejtK+iUYwPu6UCD7CNyQ
	br1CenYNR/qi9jiaduj5bezt5X6D66XZmWNnEbWiKkciWL7JMa82Li/zAFek3qMV
	BEIbxe3e8DaH/hDao5i2C070EB0MFnYmgyQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgr73984a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 06 Jan 2026 09:00:19 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4eff973c491so17773491cf.1
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 01:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767690018; x=1768294818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zUmJx583wbIqbI/LnTq2qTUX5b+XpJNoiwxn1/rffoo=;
        b=jWRB7PS/f4YZX2eiZ+9MRHDuEa/PZYO8f0SY2NnCnntD8TJxAC+jRQD05WdIF+wjl2
         X7dX5ezu8IOTcxcD04KQO0pFH7YhwXdN+884UXCWpcTmOZ8KrokHiHfi1or+ipGeA0Fj
         CIgcgO1j9ttyM9vO46T7UWAG74IGMbNiTEQOPAou+o5fqbq3q0lqaQZcTecemY5mdKm/
         ZMaevJqOzxj2Rd9erY4//XNYFTlU5E4yTwiOLRjkRxal0bhij75+6yeLVr7sykJiRtL1
         79F48/cdfmMMyzwO1Ex/NuY6zm7wS5srdL6E0SwBHilR3+5cR/1UVhpvOfVL1iDEMJvH
         puFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767690018; x=1768294818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUmJx583wbIqbI/LnTq2qTUX5b+XpJNoiwxn1/rffoo=;
        b=mbzn/f2XhGmmJLbKz7W22RTgcYLgxiSwhHu93hOMeE1sl9wVn0vgszEmQCdcMNxDma
         /UfoePjphvJ4qt2LsMBHYSut5F1urALQf0tvJXiMsFN0jtwof3oEJ87/BgDxsa6+B+Nr
         I1v0jX5Sx9y53hkNAjbi3WNfDJUycLKWcECvVwK2EEBr15314tx8Kpsk6lYXm9ce2dmH
         TH0m6i0u+P2Dy4QhE9Yzs0G74vldbP4s3ZkP27MS8Y04LNoekVdXQjXi9ezHCozGOak+
         AbnOx5sG1pTNmhmGexk0Q/jR6JYE2m34kqMZw/crDvY2vCDffxL48P7OmlwuTZ+iVWYG
         sjYg==
X-Forwarded-Encrypted: i=1; AJvYcCX9iJfUkJ2OVUAr7+CtERbomA2OF0YAnnxnh1IbSfYncSSybWBN9QmKxUMp6ZZ0J9jd3Nh7aWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL0JdpopRC4U9eqjCda1iCoeJXoW9GFFz84faFvamrJHl5itna
	kgkn9FJy34WaBsZojTfVTCc+4x4+q4iY03k6q63X0pxvxSkthyAKTk+iO/qJeVZ8VfO5YRssWZF
	rCyxSdRMVN3tM7Qy1x1vR9AoGDY30MmxEqGaIngh1oeo/utk+KHpsOdQRciA=
X-Gm-Gg: AY/fxX7lBZqqO/trKgOcnO7JtVT5QNnGD5avHH0eP/UAB64J5UlIeEFAHjtQ10Mki1t
	IXfkpD8coPJgz2+FxKYw7KIWrKfOQAn2Ue1O7uYZGYA3ROzr00RcrUjIvq1Oo0D4kWbrKEQ6/r1
	1hqXBf/LLBiqVNEKuYPPH8jeuPeCq8g9tAj1VS1k9+wBX4lgJsja8zVpfesh1yjM9ldbCaF/GoH
	DG4zkmW8OHVISaj29d2PzJmVTKInUBxf7IgSpuDuMYimZ5pMgc3AtbReHAvZ2bSZ/Dg5jyK+Eo9
	2f5RXnF+dXLbXHWjGw5x56lkPedTiIoGcYzhU9/jNkWGcqj1twr/Irg2yyCmkKdZInFfdNxY3VU
	I6H8YS1kixkrkAZ+kdhH4SUNzjsGqfYN1LuIYY4E=
X-Received: by 2002:a05:622a:4d98:b0:4f1:b398:551f with SMTP id d75a77b69052e-4ffa77f6136mr26639881cf.68.1767690018472;
        Tue, 06 Jan 2026 01:00:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiDIRIh0uRsi01LsmTGYlRfJRiytQ0H19Dw+EIaGym4rEAY4QFPoKpFGj+0y75JD3JHMf/gg==
X-Received: by 2002:a05:622a:4d98:b0:4f1:b398:551f with SMTP id d75a77b69052e-4ffa77f6136mr26639491cf.68.1767690018029;
        Tue, 06 Jan 2026 01:00:18 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:a1e5:bc32:d004:3d67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ff319sm3196825f8f.43.2026.01.06.01.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 01:00:17 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] gpio: rockchip: mark the GPIO controller as sleeping
Date: Tue,  6 Jan 2026 10:00:11 +0100
Message-ID: <20260106090011.21603-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QrxTHFyd c=1 sm=1 tr=0 ts=695ccf23 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8
 a=EUspDBNiAAAA:8 a=-jpIsuwBRm6Qzzl2v0IA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: FfwXAwdxkZiDwzy6X1DZUDe_yD5ghvPx
X-Proofpoint-GUID: FfwXAwdxkZiDwzy6X1DZUDe_yD5ghvPx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDA3NSBTYWx0ZWRfXyDBBQJX5Jkyb
 KYPbZjMCTWa+d5Tbf3QlxWkboCueIc5ZwWGibCbhfXXfzZOdB7vet4AoM0MLrvV7N/7KDZRMtJb
 qZqotVW4i6VMl35Daxixzbz+ZM9RrVH8q+7DdL6Z+u4NWAU9XNfu/7m2qDlDsJLcKw3m4sebQ/x
 IdWYyCPkHF4BGjX8C3SR5kK3ijdTCwIEbCJ6xgyV2LJ29j9tDT8iUXXfGGMcgu+ftV8YCi+Zl6O
 l4jBgPkD2yzTQQ4qfauFlIwhDGK3SyTbrgG1tCXcI8Qbo+lDqcv4RlLkUynIMa+ZSUrO6XBYIAn
 MwR9PVpZRnSEX9dTPUJx+86PTU5OM/9Ooe60E/UUJZ5S8arjP/aQ8HkD8Rsa54vDGmVhOBHmXju
 2cmv0t+NBx6k5+UNMpDDAVWxqGrPO93dE9+5cfGRT9Pz2Q+gE/xqvw0YSJE7o0O7P+EyqFwTvY5
 Dia3SoAJw8sKMbP/XzA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060075

The GPIO controller is configured as non-sleeping but it uses generic
pinctrl helpers which use a mutex for synchronization.

This can cause the following lockdep splat with shared GPIOs enabled on
boards which have multiple devices using the same GPIO:

BUG: sleeping function called from invalid context at
kernel/locking/mutex.c:591
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 12, name:
kworker/u16:0
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
6 locks held by kworker/u16:0/12:
  #0: ffff0001f0018d48 ((wq_completion)events_unbound#2){+.+.}-{0:0},
at: process_one_work+0x18c/0x604
  #1: ffff8000842dbdf0 (deferred_probe_work){+.+.}-{0:0}, at:
process_one_work+0x1b4/0x604
  #2: ffff0001f18498f8 (&dev->mutex){....}-{4:4}, at:
__device_attach+0x38/0x1b0
  #3: ffff0001f75f1e90 (&gdev->srcu){.+.?}-{0:0}, at:
gpiod_direction_output_raw_commit+0x0/0x360
  #4: ffff0001f46e3db8 (&shared_desc->spinlock){....}-{3:3}, at:
gpio_shared_proxy_direction_output+0xd0/0x144 [gpio_shared_proxy]
  #5: ffff0001f180ee90 (&gdev->srcu){.+.?}-{0:0}, at:
gpiod_direction_output_raw_commit+0x0/0x360
irq event stamp: 81450
hardirqs last  enabled at (81449): [<ffff8000813acba4>]
_raw_spin_unlock_irqrestore+0x74/0x78
hardirqs last disabled at (81450): [<ffff8000813abfb8>]
_raw_spin_lock_irqsave+0x84/0x88
softirqs last  enabled at (79616): [<ffff8000811455fc>]
__alloc_skb+0x17c/0x1e8
softirqs last disabled at (79614): [<ffff8000811455fc>]
__alloc_skb+0x17c/0x1e8
CPU: 2 UID: 0 PID: 12 Comm: kworker/u16:0 Not tainted
6.19.0-rc4-next-20260105+ #11975 PREEMPT
Hardware name: Hardkernel ODROID-M1 (DT)
Workqueue: events_unbound deferred_probe_work_func
Call trace:
  show_stack+0x18/0x24 (C)
  dump_stack_lvl+0x90/0xd0
  dump_stack+0x18/0x24
  __might_resched+0x144/0x248
  __might_sleep+0x48/0x98
  __mutex_lock+0x5c/0x894
  mutex_lock_nested+0x24/0x30
  pinctrl_get_device_gpio_range+0x44/0x128
  pinctrl_gpio_direction+0x3c/0xe0
  pinctrl_gpio_direction_output+0x14/0x20
  rockchip_gpio_direction_output+0xb8/0x19c
  gpiochip_direction_output+0x38/0x94
  gpiod_direction_output_raw_commit+0x1d8/0x360
  gpiod_direction_output_nonotify+0x7c/0x230
  gpiod_direction_output+0x34/0xf8
  gpio_shared_proxy_direction_output+0xec/0x144 [gpio_shared_proxy]
  gpiochip_direction_output+0x38/0x94
  gpiod_direction_output_raw_commit+0x1d8/0x360
  gpiod_direction_output_nonotify+0x7c/0x230
  gpiod_configure_flags+0xbc/0x480
  gpiod_find_and_request+0x1a0/0x574
  gpiod_get_index+0x58/0x84
  devm_gpiod_get_index+0x20/0xb4
  devm_gpiod_get_optional+0x18/0x30
  rockchip_pcie_probe+0x98/0x380
  platform_probe+0x5c/0xac
  really_probe+0xbc/0x298

Fixes: 936ee2675eee ("gpio/rockchip: add driver for rockchip gpio")
Cc: stable@vger.kernel.org
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Closes: https://lore.kernel.org/all/d035fc29-3b03-4cd6-b8ec-001f93540bc6@samsung.com/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpio-rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index 47174eb3ba76..bae2061f15fc 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -593,6 +593,7 @@ static int rockchip_gpiolib_register(struct rockchip_pin_bank *bank)
 	gc->ngpio = bank->nr_pins;
 	gc->label = bank->name;
 	gc->parent = bank->dev;
+	gc->can_sleep = true;
 
 	ret = gpiochip_add_data(gc, bank);
 	if (ret) {
-- 
2.47.3


