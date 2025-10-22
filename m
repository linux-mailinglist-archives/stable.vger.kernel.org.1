Return-Path: <stable+bounces-188860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F7ABF97AE
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 02:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB19F3B8494
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 00:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C334319DFA2;
	Wed, 22 Oct 2025 00:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpT36AN8"
X-Original-To: Stable@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61F41BDCF
	for <Stable@vger.kernel.org>; Wed, 22 Oct 2025 00:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761093275; cv=none; b=VUB+fDT821uDZ6D798tZ1GNx9NnFn7xzkJOADt+1yd0wL60v5yEV7olLLhfYxwVuCE4Po3Dm83l5liLwLTs5/nCektSMXOvHui2avyTbY1dVZEcUq8y8DsUqAQ5r0gegE0sngV/XlAxC9kWqUFpFEzgKi4wB+bCyLKdcg2LnRHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761093275; c=relaxed/simple;
	bh=qgkGS3wJ88HTmb7mmLXIGD+Kp/aUe/pZfNaGSGxqiHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVDjsiZInab/wkFQXS9n8owkl4eBbw9AVPfkq4Y3MITshkEEt7C5xW4KaiwBfpKS7/madzqzgtnp8uTtkfuQldy8wAaFS3L4SQDXryLdaaY/fqH1xY3e9mOzlaVgJQgn/OJsKuxzYNphl9FBCHpLDqwcYVKD5d9XjmOWiREdJ1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpT36AN8; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-783fa3aa122so6906597b3.0
        for <Stable@vger.kernel.org>; Tue, 21 Oct 2025 17:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761093273; x=1761698073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubx9bF9pWQ6ZKCRvlUfyA/ftKGrwDRElW72/D9hZrcI=;
        b=IpT36AN80VldLp2DmmFdenbrIVBk7BACO7QFzuPvsTwPjQJ2d8u5t8C01LdhifC6Fh
         jVAqb3QBc33PG5xkD6rpIpVFsF/zbWk886UcmIgELS/WEXqCgvjQNKSCa/PqXj8NNh/W
         dJo8CTPgtNi4tmf+8Knzoseo3vEwDH9pmGKAoEqpKrIXbjrLP8LhYyvQ8nTgGL0DXj/t
         11Bf/pqowUeg3NMn/AE6OzRsc3Im0v1S81dpsTSyjpGO9NxECITjquXQqLS2WAZ6VX4i
         8rh+GDbrOMV4lPaFkznSD6zETH/qspjPjiMKIBqzJ4CnQ4Hd7Yo8CN5KXbYACrN/xShF
         k3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761093273; x=1761698073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubx9bF9pWQ6ZKCRvlUfyA/ftKGrwDRElW72/D9hZrcI=;
        b=mpsUDAVtpArpFEn/dtFg5JeyFSmvRc0q8xiWAKs6EEoxoi8eIbXLdKlC5d+7zmj2QV
         He2irYmnrGKo4fQu6IKpj2CcJx4kHpwBPOgjVCXL6MfJqPRkzlerVF21wcww7ZcSwZZu
         miwEwQaUDTyqiTnaPwRQI+uqro+O7sjgWbMj5eW+c3tef7aN+gVoNMeIE9OfauieOI8e
         eM+1Ag4MxpE1zNa018Epc9Q8l1ny3zold+3RLC4hpdkpt2vZjkdI20KdapLGde+zOr2a
         rcdntYudlzJj9P6VUsb1jk3hmYGXfOeCEM35GCVVJghSa2pKk0uB5nqyprd/F3E6hGoS
         ReQg==
X-Gm-Message-State: AOJu0Yx4i3tFuJx4KQZvCBKG4h0R3tz5f/lpPYacK/oXpTENppMlReiU
	2om+Ij2XpocMFikRMRe+N/ZFXkyyLutGca3fXLyjhqgMDVfMklBX9iYX
X-Gm-Gg: ASbGncvJdHQP5zUz+4OOpUFOyxm6MOh8rapFoEi6yn4N6DbpQsDdL5Vg6Oenzq8fX7Q
	1x1h/9j4Edoz4hPwpTt4te7HZqs1USFvRNnwpv3oDFzjK0j7eh/TGe9G+uHSVJYe3B1KFavsdGZ
	zofZqt9FiPV+z/5RBpMkmfHQ4cY2DzhuJBW3gyPq6Ja+YiTJtfn5TXyDP/apDcGKuyviEVNx3mB
	mKdSucBfgQEJpmyhbDDjgNAy2DB8iqlXD8Pi4scUVNeQFphteeapmXXMmmB6kpmp50s2hMP8fpO
	PeBCvO+PXN0FVHmH8a3IPpRPPwlQvvSyARDYMQPrm7L7cb0jgVx9eshEv3gEj6RoKr26HeYFw/x
	eo3La38vQHLXwSvHa5pCh1vPZpQvST9+pCc7XxvdQaMmcupS1V+JXc9hEreWAXjnUuMBiwFr3Lj
	UbRSCNLqfxjNovY4SiIyfuWoNZfJ/NmuIpE24F3NLdXDbaz76GQAi+oKflmLs=
X-Google-Smtp-Source: AGHT+IEcYGt4CrcsasTS4jtyBVptZ3enHR77bQaLZwRxCWWbcTzQCWy79WyTze7wd4UIkxlcrae2iw==
X-Received: by 2002:a05:690c:2c03:b0:784:a0af:9d5d with SMTP id 00721157ae682-785bce3e931mr18515657b3.12.1761093272958;
        Tue, 21 Oct 2025 17:34:32 -0700 (PDT)
Received: from localhost (104-48-214-220.lightspeed.snantx.sbcglobal.net. [104.48.214.220])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-784673c0f89sm33090827b3.22.2025.10.21.17.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 17:34:32 -0700 (PDT)
From: Steev Klimaszewski <threeway@gmail.com>
To: srinivas.kandagatla@oss.qualcomm.com
Cc: Stable@vger.kernel.org,
	alexey.klimov@linaro.org,
	broonie@kernel.org,
	krzysztof.kozlowski@linaro.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	srini@kernel.org,
	tiwai@suse.com
Subject: Re: [PATCH v2 0/4] ASoC: qcom: sdw: fix memory leak
Date: Tue, 21 Oct 2025 19:34:29 -0500
Message-ID: <20251022003429.4445-1-threeway@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021104002.249745-2-srinivas.kandagatla@oss.qualcomm.com>
References: <20251021104002.249745-2-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Srini,

On the Thinkpad X13s, with this patchset applied, we end up seeing a NULL
pointer dereference:

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000020
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=000000010abfe000
pgd=0000000000000000, p4d=0000000000000000
 SMP
 pdr_interface(E) crc8(E) phy_qcom_qmp_pcie(E) icc_osm_l3(E) gpio_sbu_mux(E) qcom_wdt(E) typec(E) qcom_pdr_msg(E) qmi_helpers(E) smp2p(E) rpmsg_core(E) fixed(E) gpio_keys(E) qnoc_sc8280xp(E) pwm_bl(E) smem(E) efivarfs(E)
CPU: 5 UID: 111 PID: 1501 Comm: wireplumber Tainted: G            E       6.17.4 #2 PREEMPTLAZY
Tainted: [E]=UNSIGNED_MODULE
Hardware name: LENOVO 21BX0015US/21BX0015US, BIOS N3HET94W (1.66 ) 09/15/2025
pstate: 60401005 (nZCv daif +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
pc : sdw_stream_add_slave+0x4c/0x440 [soundwire_bus]
lr : sdw_stream_add_slave+0x4c/0x440 [soundwire_bus]
sp : ffff80008bc2b250
x29: ffff80008bc2b250 x28: ffff0000a56b2f88 x27: 0000000000000000
x26: 0000000000000000 x25: ffff0000a301b000 x24: 0000000000000000
x23: ffff0000e8ce0280 x22: 0000000000000000 x21: 0000000000000000
x20: ffff80008bc2b300 x19: ffff0000a305a880 x18: 0000000000000000
x17: 0000000000000000 x16: ffffb9859eb15c48 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000000 x9 : ffffb985391c0614
x8 : 0000000000000000 x7 : 0000000000000000 x6 : ffff0000a56b2fd0
x5 : ffff0000a56b2f80 x4 : 0000000000000000 x3 : 0000000000000000
x2 : ffff0000eb005000 x1 : 0000000000000000 x0 : ffff00011de2c890
Call trace:
(P)
 wcd938x_sdw_hw_params+0xa8/0x200 [snd_soc_wcd938x_sdw]
 wcd938x_codec_hw_params+0x48/0x88 [snd_soc_wcd938x]
 snd_soc_dai_hw_params+0x44/0x90 [snd_soc_core]
 __soc_pcm_hw_params+0x230/0x620 [snd_soc_core]
 dpcm_be_dai_hw_params+0x260/0x888 [snd_soc_core]
 dpcm_fe_dai_hw_params+0xc4/0x3b0 [snd_soc_core]
 snd_pcm_hw_params+0x180/0x468 [snd_pcm]
 snd_pcm_common_ioctl+0xc00/0x18b8 [snd_pcm]
 snd_pcm_ioctl+0x38/0x60 [snd_pcm]
 __arm64_sys_ioctl+0xac/0x108
 invoke_syscall.constprop.0+0x64/0xe8
 el0_svc_common.constprop.0+0xc0/0xe8
 do_el0_svc+0x24/0x38
 el0_svc+0x3c/0x170
 el0t_64_sync_handler+0xa0/0xf0
 el0t_64_sync+0x198/0x1a0
Code: f9418c00 b9006fe3 91004000 97ffe306 (f8420f43)
---[ end trace 0000000000000000 ]---

-- steev

