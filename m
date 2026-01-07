Return-Path: <stable+bounces-206104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D52CFC9CD
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 09:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1437430123D5
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 08:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688F3299950;
	Wed,  7 Jan 2026 08:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YAf3ePHD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CAKaAJCu"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B29F2868A7
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 08:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767774695; cv=none; b=hnwhRnG9X1TT7ru1iPiNZ7pqavtZViOMiO23EkW7tq3lq9D+7CmAfRmNsO98QqNSY0q1Caz+h6g+uTJOZxGGJEVU74LNpyT5sk096kY48fBWKA7PIJMCcaWFeAyjPhMWJUfnBGV18NZ6b7BqB2TppYBowBrqfQBISXVWwQ+POZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767774695; c=relaxed/simple;
	bh=sfSs/NP+7b+3Ri0ciErmRI77kOLv1weBiE9gw+qCLR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=coLI9seiXuRuaPjfwALLbgsYx6gFKjcJAlx102fQGpWY8OeAJ2t/CWCc2mRUWtZfbH0oLUVamlKTuCVHR14a4F3Xw4xczaZnPcZyFrTJnuWRoXb3Y8UzjBW8PG+i5hIhLJC3Wh5oIh0PrAI1wIUTBNir2UwFLlBg2iqYlq+Ngxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YAf3ePHD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CAKaAJCu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6073mJun4090711
	for <stable@vger.kernel.org>; Wed, 7 Jan 2026 08:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sO93H+QFa37P7vkvoHhZpkzVYY5lod2ZRIVKd4EtCKM=; b=YAf3ePHDs3CaRRWl
	db3WyP0IRzXYAKProK7DkpioG0z/c1Ec3mPHK3x0oIpzV3ugmxYMq46Op6nciCp1
	FgvXVcV87pUwboJc+pseSupjohRijHuJedKtmp/aPxEBw5/9SBSHeW6NBgxk7qxY
	CPe1MfwMN+ZHfxi3xR2VSvN5WP/QYod1slvq6/GM0CCvxBU+s36zLnjcimzfuqX6
	zKOrj/9/wtaMxXBoEt+j6ZRA/qc9ablPUG5GoSZKnud6heFuyor9gvra/PVlmeak
	Ja6o6C+XBt40qpMTHdccdW4Mxk6EndKBM8Xc04kIirgoHUe8OVnfKPEtcX94Pu5o
	cnNQQQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgyunbq2p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 07 Jan 2026 08:31:32 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4f4d60d1fbdso2088831cf.3
        for <stable@vger.kernel.org>; Wed, 07 Jan 2026 00:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767774692; x=1768379492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sO93H+QFa37P7vkvoHhZpkzVYY5lod2ZRIVKd4EtCKM=;
        b=CAKaAJCuavkVN5T1tdiPv0AZRDyIGt08Yn0A0WlQ7zC6dlwyZ0sBsfDPYHSjL260kr
         vaqSazEUuYqpbzDOYVdK7/g7ywD0UAO041UUb3MAyMYNBlBzTVOULdXx2JA/qlsXb21S
         C/3fADNcvj2TY3mTlbTM4JenGCwjClyBdpfipFAW/XDQ4dAGk8LMvSZa3WeGxUq7Ci3T
         b2lcKEoeyc+HI84TGGTHOwU4U+K3wOLEItCJvxolu9Ly4gMn/H1hjxih192Z59ECPuf5
         E1nq8nxiieDgJI0DTI2u8b5BpsoSxadLPt8LXKzPYR7CcJ9XfeE4ArR69RsUxAWQTLfC
         MTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767774692; x=1768379492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sO93H+QFa37P7vkvoHhZpkzVYY5lod2ZRIVKd4EtCKM=;
        b=uezPMpWA2dztnxxjsjlCcKgR5FGtJpLqHh14hzoG/pXchFbW1e/h0pJqz/SRsUmJy0
         hKn8uaN6K5O/EzYS8Isl/Ix4aFhjqfz7ZZwwzow4dNM2NF7cSO9FytBf/As4bkHUVeX2
         GxXNsE8AFADCLnHbo05USfnj32dWZqY5hsB6mxst7umXvyH8NF7s39CF0Wy5Bdd5UPuF
         vNdRKopm4mNCNIgn5vjr9q9+8lTOjykQsB0w1VTouclWLmXCLpOznRzJAFiqmqZZeTl8
         5fUE5VR7sL4ghg4u/MDTtoybbVns3cB6mi5iODJ5TG6cTT37KcCHym5x77ydRAtNT4DS
         cejw==
X-Forwarded-Encrypted: i=1; AJvYcCUj/MsTRrsT6yh1t4gNVnjTBzfUlp7XTaAouzQBfYWpmt2eAHdP8GSYhQYajCK/GvaxYm4NImg=@vger.kernel.org
X-Gm-Message-State: AOJu0YycLqYB6iQGsVeXokzkeKkJJvJ62oLCPiN1FwRE/KuYg6gSACYI
	VyO6peWMia3UTJ1+0nd/tNAh7CRjgWjxxKWsIwgLQ/opMWZZLtGiP49cSL/TcRFBZ6Wysf3q6Z2
	IRfOa9jfQc02JsFp1bUoa+y0WSjjw3+bJwPlloBne45GgxhjwZ6t4wZF0kTI=
X-Gm-Gg: AY/fxX5C7re44NuAaLvjR8Xl5XNzzDyxP1AtuC/NhT//Y5mUpHZ8KFEzhUY/5Bg+nA9
	Y76cy6fNiCirGyEyjrFPk9bqgGgT8HHOA9By38Knz+nkqB8KwuLvDGk8IAFbqIl8/9yKBX5VMWR
	EXjnPA/tyJYw5fr1fKxwZQpHEgRFNnPCL49zf1T4xTgDsueBwDJZZmVR42EUYkkLEVnaDdX+qL8
	SWp4LHGN9U83UsQODQbVll+yEvKjXTlaz759C7fGpz9QVrw4lY0ABr//MZjvbWBoybGq5thiLSi
	yRSU1vMqLomnh6bhiAwG9xAyX6COTGy3n4p+d2KoIwsT7EskOhH75OSTWqfBg8Qt04BO/MVqlRz
	fIlf6JfK1042eASo9fFE3yd2YZ9XAswX8jC39pg==
X-Received: by 2002:a05:622a:5c8e:b0:4ee:26bd:13f3 with SMTP id d75a77b69052e-4ffb484a739mr17380021cf.8.1767774691656;
        Wed, 07 Jan 2026 00:31:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6IltAcpMqDUqZxq1/vVtnQVTIeTGNYCG+LcMYOkprAjPOhqleDalrgIZfMVCirRonr53pXQ==
X-Received: by 2002:a05:622a:5c8e:b0:4ee:26bd:13f3 with SMTP id d75a77b69052e-4ffb484a739mr17379801cf.8.1767774691272;
        Wed, 07 Jan 2026 00:31:31 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:b90b:ec1:e402:4249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f703a8csm84793845e9.13.2026.01.07.00.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 00:31:30 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] gpio: rockchip: mark the GPIO controller as sleeping
Date: Wed,  7 Jan 2026 09:31:26 +0100
Message-ID: <176777468354.15022.5475399715540988905.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106090011.21603-1-bartosz.golaszewski@oss.qualcomm.com>
References: <20260106090011.21603-1-bartosz.golaszewski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA2NyBTYWx0ZWRfX4wl1ktxEREZa
 9slrXwqrgdCXRiatoKe9Qu6pU1SiYunnJsYUotFyrWKwYveuXyBk4Dom5ePK5rzwvHoxHBThQ1e
 G8MHirPgSvEmhuC381CY6350FGZitAnay87O89pRbFDZyfaYZ2QI2zUNejBtcj/GKvzyI265cd1
 dmLRcFfInkWjx4ehkRbJagwCXmWLcqcm/6pFrzC4BokYIOe6NL1RzBWbO3AROb3tXFNwKbNZlOp
 tFQNSBuTP3js9KL4Q4q55nv7i9DXyaBU79jzwRrQaUrVOTxpJMpexzk8mVaBW5RLQL7eeGotgJ7
 zQaSDhu5SnodFks+s1wbs9VOmmuN1WjRlHWJk/Nt/mup4n36uZ+yiagj2WQIJ1P6/L4fkoAswik
 GsPh27Ye2UnOG0wQxiTlOH5Hw96/lkhf3rNfHNTBOx0qhJO7OI4BUMrqrbAICaYuuTheJf8Mg2g
 UcLvmtJaIMn5nnLJDRg==
X-Authority-Analysis: v=2.4 cv=YqIChoYX c=1 sm=1 tr=0 ts=695e19e4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=R-3ehz3GvOBFeWroKLcA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 4cqoDHfwLHa5gNrV0-5mjwo1I9IxEavW
X-Proofpoint-ORIG-GUID: 4cqoDHfwLHa5gNrV0-5mjwo1I9IxEavW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601070067


On Tue, 06 Jan 2026 10:00:11 +0100, Bartosz Golaszewski wrote:
> The GPIO controller is configured as non-sleeping but it uses generic
> pinctrl helpers which use a mutex for synchronization.
> 
> This can cause the following lockdep splat with shared GPIOs enabled on
> boards which have multiple devices using the same GPIO:
> 
> BUG: sleeping function called from invalid context at
> kernel/locking/mutex.c:591
> in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 12, name:
> kworker/u16:0
> preempt_count: 1, expected: 0
> RCU nest depth: 0, expected: 0
> 6 locks held by kworker/u16:0/12:
>   #0: ffff0001f0018d48 ((wq_completion)events_unbound#2){+.+.}-{0:0},
> at: process_one_work+0x18c/0x604
>   #1: ffff8000842dbdf0 (deferred_probe_work){+.+.}-{0:0}, at:
> process_one_work+0x1b4/0x604
>   #2: ffff0001f18498f8 (&dev->mutex){....}-{4:4}, at:
> __device_attach+0x38/0x1b0
>   #3: ffff0001f75f1e90 (&gdev->srcu){.+.?}-{0:0}, at:
> gpiod_direction_output_raw_commit+0x0/0x360
>   #4: ffff0001f46e3db8 (&shared_desc->spinlock){....}-{3:3}, at:
> gpio_shared_proxy_direction_output+0xd0/0x144 [gpio_shared_proxy]
>   #5: ffff0001f180ee90 (&gdev->srcu){.+.?}-{0:0}, at:
> gpiod_direction_output_raw_commit+0x0/0x360
> irq event stamp: 81450
> hardirqs last  enabled at (81449): [<ffff8000813acba4>]
> _raw_spin_unlock_irqrestore+0x74/0x78
> hardirqs last disabled at (81450): [<ffff8000813abfb8>]
> _raw_spin_lock_irqsave+0x84/0x88
> softirqs last  enabled at (79616): [<ffff8000811455fc>]
> __alloc_skb+0x17c/0x1e8
> softirqs last disabled at (79614): [<ffff8000811455fc>]
> __alloc_skb+0x17c/0x1e8
> CPU: 2 UID: 0 PID: 12 Comm: kworker/u16:0 Not tainted
> 6.19.0-rc4-next-20260105+ #11975 PREEMPT
> Hardware name: Hardkernel ODROID-M1 (DT)
> Workqueue: events_unbound deferred_probe_work_func
> Call trace:
>   show_stack+0x18/0x24 (C)
>   dump_stack_lvl+0x90/0xd0
>   dump_stack+0x18/0x24
>   __might_resched+0x144/0x248
>   __might_sleep+0x48/0x98
>   __mutex_lock+0x5c/0x894
>   mutex_lock_nested+0x24/0x30
>   pinctrl_get_device_gpio_range+0x44/0x128
>   pinctrl_gpio_direction+0x3c/0xe0
>   pinctrl_gpio_direction_output+0x14/0x20
>   rockchip_gpio_direction_output+0xb8/0x19c
>   gpiochip_direction_output+0x38/0x94
>   gpiod_direction_output_raw_commit+0x1d8/0x360
>   gpiod_direction_output_nonotify+0x7c/0x230
>   gpiod_direction_output+0x34/0xf8
>   gpio_shared_proxy_direction_output+0xec/0x144 [gpio_shared_proxy]
>   gpiochip_direction_output+0x38/0x94
>   gpiod_direction_output_raw_commit+0x1d8/0x360
>   gpiod_direction_output_nonotify+0x7c/0x230
>   gpiod_configure_flags+0xbc/0x480
>   gpiod_find_and_request+0x1a0/0x574
>   gpiod_get_index+0x58/0x84
>   devm_gpiod_get_index+0x20/0xb4
>   devm_gpiod_get_optional+0x18/0x30
>   rockchip_pcie_probe+0x98/0x380
>   platform_probe+0x5c/0xac
>   really_probe+0xbc/0x298
> 
> [...]

Applied, thanks!

[1/1] gpio: rockchip: mark the GPIO controller as sleeping
      commit: 20cf2aed89ac6d78a0122e31c875228e15247194

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

