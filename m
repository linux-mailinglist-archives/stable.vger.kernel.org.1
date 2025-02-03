Return-Path: <stable+bounces-112047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0463A261C6
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 18:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43973165D17
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 17:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E886220CCC5;
	Mon,  3 Feb 2025 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="iOKn1vFm"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF3620C472
	for <stable@vger.kernel.org>; Mon,  3 Feb 2025 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738605331; cv=none; b=UooNZLlfWaQJTKLQ6anPYR9iVAps4JxwkZ8Fg10205huawUZxZuiAyKso3cx+C7ETRBnM6abmJILSV01PDSgHVbbCPBzCoBKtUgiZR7olbKiiZe6jZKMm4rKTKqolbc/o2s5JnjeiZdiBCf8dAAcjKTHlJ2WYIWZ7VcO5+CeIuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738605331; c=relaxed/simple;
	bh=gnotMF2SpzmsZYETbwi0AsYz9YG4hl0Pw8Go0qSIJLc=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=mUiFVlRNa/q8YAz/x27oklDAbbnr4PmwKKqGeF0/HzVYeWStGW4a8XIIDI3otykazz2WHutE/HPhw2a9VxYlcuF7OwSFBgnO3+3hT5vlQNojFTfdip+oNR8lCpuisQhTCtCjDXzm6/OuyUeBdJCksXNND8Hb09xy3YHdqw2INac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=iOKn1vFm; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-e53a5ff2233so4883287276.3
        for <stable@vger.kernel.org>; Mon, 03 Feb 2025 09:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1738605328; x=1739210128; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lej/HjnRoGIiHgGyLejhy9XNlZOqOHJpylIZ8d4evSY=;
        b=iOKn1vFmtG1qim3DyQPXrA4qHmTzagc3M14dtbAguBoJkbKQUY6JUBvBvimYG82Ov7
         eHGsPGa9cvwjS9m3RZ7urI89wOT+dkSc0W6ZVtBeTjL77sGcNuNZDpZ0AeYbIzWOL+El
         ZULcNRKQm/WoVxwp2fu21sXlckwn/vxhDtwVwdFBXnJOwaKGnj5/I9bEy84+pfge2/Rk
         iDswt3lD4qnhG1DYcIxl30cJPjkoaVb8GJlOq79AbgNDOA4jJSCj/K7mA9yugK1cnnv2
         oe3WyDHeiTlyg6QcWT76TMU5Mk8iGk9dHOTrqyw59PekZusC1o1v6ZEhv01h5Cpv5cfd
         bBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738605328; x=1739210128;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lej/HjnRoGIiHgGyLejhy9XNlZOqOHJpylIZ8d4evSY=;
        b=vxuehcZW6JkMcJ3SsMvRNay/UsRXirXZFdHRv0FV3bPdvaBomFnZMRiZP/Fic7C513
         2N0inBF3ipmi1HBd1+NVpARoP/3lp5Tk2PpOSRRyCJmDPMVzfezOP27WlGHtQ+31NgXX
         Za3yIwsDuWIQd3sGQzuuLQ4XwVTXoEJv4MuVUbT+JsU7BHj3sralVlycETyBQwgCzVG3
         AwXo/g99ku7qaqntfRk2/3jkP6RZv6dj5sP47yiLr9c1x01nhSLMLy0gsuAnDh9VmXbq
         bs1MBDJFfRrbOCxQ/U85R67v6OXO3GlIBRgra+SfVfsVSJCGG87mgpUfvKzUYIewBXZ/
         MS7w==
X-Forwarded-Encrypted: i=1; AJvYcCXqsrl5lQvTuoZJ5w3Qo113+JaY2CulgmatalrphsG87yD0kupQ/L5jx2pUoo32KuRXQGBT1a4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8GaIYrHkKRVp+XS8nAw5vlF3RQX5SCblgIL3HnI9nuC+8FDxU
	k/ApgzZl34F6sYE1MzFReA3Dh0w/bjQM4lF3aj1KG096hfsdhPTQiqORYe3vbjecZAzHW5EI1mj
	9DVHgwxh/OuPZf7+Z+cGexGJWRSzZCIgEAVMZAQ==
X-Gm-Gg: ASbGncvCUp+6U4djNbA3ty1fYMOvMTUSkErCTdDfeaQWPCfLjh3syMuZOahxiEZVUvV
	tWcRMpKDroUOWInRCBSTS0Qcgzgd+FCTLhgcMXdBbi9U8EWMT3lTMPbUH+pztTRFPkOC5vSkhTB
	9/yGfYXnwUOrO+EbYnNFYRo6ELylTLEQ==
X-Google-Smtp-Source: AGHT+IFn2rDWVryLxBS9cPZKfPHcC5cHN/DsbioActnxO0XAGsRzt8U7fOaetI1I/VSC20sv5CGcxZc3ITTc/xVzH/c=
X-Received: by 2002:a05:690c:6d07:b0:6ef:4a1f:36b7 with SMTP id
 00721157ae682-6f7a84246a8mr177591927b3.25.1738605328578; Mon, 03 Feb 2025
 09:55:28 -0800 (PST)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Feb 2025 09:55:27 -0800
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Feb 2025 09:55:27 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Date: Mon, 3 Feb 2025 09:55:27 -0800
X-Gm-Features: AWEUYZly_aGAiwPXWtNkVzky8FF79JfpTHOSFjCzWR4ySuCU8vg1xL5m3eedcHk
Message-ID: <CACo-S-3ne3ECDg5fTacS8ZfcpJ=WnhDF-gHTo6hUUgN4AeP6hg@mail.gmail.com>
Subject: stable/linux-6.13.y: new boot regression: WARNING at
 lib/refcount.c:25 refcount_warn_saturate+0xc8...
To: kernelci-results@groups.io
Cc: gus@padovan.org, linux-mediatek@lists.infradead.org, 
	angelogioacchino.delregno@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New boot regression found on stable/linux-6.13.y:

 WARNING at lib/refcount.c:25 refcount_warn_saturate+0xc8/0x148
[logspec:generic_linux_boot,linux.kernel.warning]

- Dashboard: https://staging.dashboard.kernelci.org:9000/issue/maestro:9027cb3b2181d813ac566c16982a6748748d7ae7
- Grafana: https://grafana.kernelci.org/d/issue/issue?var-id=maestro:9027cb3b2181d813ac566c16982a6748748d7ae7


Log excerpt:
[    4.653252] refcount_t: addition on 0; use-after-free.
[    4.653261] WARNING: CPU: 5 PID: 187 at lib/refcount.c:25
refcount_warn_saturate+0xc8/0x148
[    4.653271] Modules linked in: v4l2_mem2mem pcie_mediatek_gen3(+)
mt6359_auxadc mtk_rpmsg joydev videobuf2_dma_contig rpmsg_core
elan_i2c lvts_thermal(+) mt6577_auxadc snd_soc_mt8195_afe(+) mtk_svs
mtk_scp_ipi snd_sof_utils mtk_wdt btusb btintel btbcm btmtk btrtl
uvcvideo videobuf2_vmalloc uvc videobuf2_v4l2 mt8195_mt6359 bluetooth
ecdh_generic videobuf2_memops ecc videobuf2_common
[    4.653293] CPU: 5 UID: 0 PID: 187 Comm: (udev-worker) Not tainted
6.13.0 #1 c0bd9fe43a50105c5d4fe2d8da4d493a3771f650
[    4.653296] Hardware name: Acer Tomato (rev2) board (DT)
[    4.653297] pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    4.653298] pc : refcount_warn_saturate+0xc8/0x148
[    4.653301] lr : refcount_warn_saturate+0xc8/0x148
[    4.653303] sp : ffff800080c23620
[    4.653304] x29: ffff800080c23620 x28: ffffda629c274b18 x27: 0000000000000001
[    4.653306] x26: ffff800080c23930 x25: ffffda62d3588f10 x24: ffff07808558e7f8
[    4.653308] x23: 0000000000000000 x22: ffff078081075478 x21: ffff800080c236a8
[    4.653309] x20: 0000000000000000 x19: ffff078081074078 x18: 00000000ffffffff
[    4.653311] x17: 00000000ffffb060 x16: ffffda62d111f5f8 x15: 612d35393138746d
[    4.653313] x14: ffffda62d37fd750 x13: 0a2e656572662d72 x12: ffffda62d3551950
[    4.653315] x11: 0000000000000001 x10: 0000000000000001 x9 : ffffda62d0943280
[    4.653316] x8 : c0000000ffffdfff x7 : ffffda62d34a18b0 x6 : 00000000000affa8
[    4.653318] x5 : ffffda62d35518f8 x4 : 0000000000000000 x3 : 00000000ffffffff
[    4.653320] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff078088140000
[    4.653322] Call trace:
[    4.653323]  refcount_warn_saturate+0xc8/0x148 (P)
[    4.653326]  klist_next+0x180/0x1a8
[    4.653329]  bus_for_each_dev+0x6c/0xe8
[    4.653334]  driver_attach+0x2c/0x40
[    4.653336]  bus_add_driver+0xec/0x218
[    4.653337]  driver_register+0x68/0x138
[    4.653339]  __platform_driver_register+0x2c/0x40
[    4.653341]  mt8195_afe_pcm_driver_init+0x28/0xff8
[snd_soc_mt8195_afe 41f903257dcc6a1560bfbd0ddb4cf7a5b6deb9f1]
[    4.653350]  do_one_initcall+0x60/0x320
[    4.653354]  do_init_module+0x68/0x258
[    4.653357]  load_module+0x1cf8/0x1de8
[    4.653359]  init_module_from_file+0x8c/0xd8
[    4.653361]  __arm64_sys_finit_module+0x150/0x338
[    4.653363]  invoke_syscall+0x70/0x100
[    4.653367]  el0_svc_common.constprop.0+0x48/0xf0
[    4.653370]  do_el0_svc+0x24/0x38
[    4.653372]  el0_svc+0x34/0xf0
[    4.653375]  el0t_64_sync_handler+0x10c/0x138
[    4.653377]  el0t_64_sync+0x1b0/0x1b8



# Hardware platforms affected:

## mt8195-cherry-tomato-r2
- Compatibles: google,tomato-rev2 | google,tomato | mediatek,mt8195
- Dashboard: https://staging.dashboard.kernelci.org:9000/test/maestro:67a0b86a661a7bc874890490

#kernelci issue maestro:9027cb3b2181d813ac566c16982a6748748d7ae7


--
This is an experimental report format. Please send feedback in!
Talk to us at kerneci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

