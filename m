Return-Path: <stable+bounces-28664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBA7887D8D
	for <lists+stable@lfdr.de>; Sun, 24 Mar 2024 17:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79ECA1F212DB
	for <lists+stable@lfdr.de>; Sun, 24 Mar 2024 16:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3309F18624;
	Sun, 24 Mar 2024 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="ttqxiaN3"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3539219BCA;
	Sun, 24 Mar 2024 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711297094; cv=none; b=Kop7oxH5Vzxzh430AjFXksn0G+K+bhkIzY0kXYFQHZXqAp/lNxbpH4vJwy3LgdjXuS6U2VwnLfvVLJXZJn1zaytUaYzT4RSqNTaE+8857ibay86G+QnLBoXdii1mYwOUVEOa1kmdIEnnMVaPcBc39swBOlAGcgMv54Etaz2J4CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711297094; c=relaxed/simple;
	bh=da0xwxHOEUl8MbjtnHFjZ63pq5vlQZIOS/22Z53tAPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQAudmLkg1ZPwroJiEANFbmpf9OhQMqsDlpWpF2Wz5yPpU05DlNIPa/jnZzJ6iuxr5QOe2Rzz6tSoocGjXSe7t3+I2+5t3eW+9dM/ViKV+kQa+zGea5TZB98uQCnQrve/VC4G+Ej951UmwgZdYxXczzgBSs0+mCcpcKNdIV1hNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=ttqxiaN3; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 7553D21597;
	Sun, 24 Mar 2024 17:17:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1711297079;
	bh=5zPfziSq49x7m+PLqbCGYVxMES21d9abyRHewSFqJ50=; h=From:To:Subject;
	b=ttqxiaN3wmVSj85ZgRUShYIVNdd7NKf86PCCrhsxc9UwodbnB5qKyXsK1Sc6AhP2S
	 70yxpbzfBRnlC+fMnQAA1FUx4MA+1osliLoiiqQgbvZJNSCRxD9xmWtE1OLXF6qg3W
	 5nY5pA9BU2PBp3agvj6P4Lys6M8JCDBAw1VEjXZ3jcm6noF6WnC+HJIfSEWI9ArBnl
	 XLPdU3LoA1ifNKOqcQrU0pBOGwJATjfTuLA6HYJwvVjs0IvpaX3zGaQtbritf5gHqE
	 Lz3UrAjLlWT7y9zudr2SeYPtKfjg1uqCa6askzRsxBHcN8xT8rm7NhEYO2tSaU6LgI
	 43ONjCzLty+Ow==
Date: Sun, 24 Mar 2024 17:17:55 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: mikko.rapeli@linaro.org, Avri Altman <avri.altman@wdc.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] mmc core block.c: avoid negative index with array
 access
Message-ID: <20240324161755.GA52910@francesco-nb>
References: <20240313133744.2405325-1-mikko.rapeli@linaro.org>
 <20240313133744.2405325-2-mikko.rapeli@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313133744.2405325-2-mikko.rapeli@linaro.org>

Hello Mikko and Avri,

On Wed, Mar 13, 2024 at 03:37:44PM +0200, mikko.rapeli@linaro.org wrote:
> From: Mikko Rapeli <mikko.rapeli@linaro.org>
> 
> Commit "mmc: core: Use mrq.sbc in close-ended ffu" assigns
> prev_idata = idatas[i - 1] but doesn't check that int iterator
> i is greater than zero. Add the check.
> 
> Fixes: 4d0c8d0aef63 ("mmc: core: Use mrq.sbc in close-ended ffu")
> 
> Link: https://lore.kernel.org/all/20231129092535.3278-1-avri.altman@wdc.com/
> 
> Cc: Avri Altman <avri.altman@wdc.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: linux-mmc@vger.kernel.org
> Cc: stable@vger.kernel.org
> Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>

I just had the following Oops

[   31.377291] Unable to handle kernel paging request at virtual address 0000fffffc386a14
[   31.385348] Mem abort info:
[   31.388136]   ESR = 0x0000000096000006
[   31.392338]   EC = 0x25: DABT (current EL), IL = 32 bits
[   31.397681]   SET = 0, FnV = 0
[   31.400730]   EA = 0, S1PTW = 0
[   31.405397]   FSC = 0x06: level 2 translation fault
[   31.410355] Data abort info:
[   31.413245]   ISV = 0, ISS = 0x00000006
[   31.417086]   CM = 0, WnR = 0
[   31.420049] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000084f89000
[   31.426552] [0000fffffc386a14] pgd=0800000084af2003, p4d=0800000084af2003, pud=0800000083ec0003, pmd=0000000000000000
[   31.437393] Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
[   31.443657] Modules linked in: crct10dif_ce ti_k3_r5_remoteproc virtio_rpmsg_bus rpmsg_ns rtc_ti_k3 ti_k3_m4_remoteproc ti_k3_common tidss drm_dma_helper mcrc sa2ul lontium_lt8912b tc358768 display_connector drm_kms_helper ina2xx syscopyarea sysfillrect sysimgblt fb_sys_fops spi_omap2_mcspi pwm_tiehrpwm drm lm75 drm_panel_orientation_quirks optee_rng rng_core
[   31.475530] CPU: 0 PID: 8 Comm: kworker/0:0H Not tainted 6.1.80+git.ba628d222cde #1
[   31.483179] Hardware name: Toradex Verdin AM62 on Verdin Development Board (DT)
[   31.490480] Workqueue: kblockd blk_mq_run_work_fn
[   31.495216] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   31.502172] pc : __mmc_blk_ioctl_cmd+0x12c/0x590
[   31.506795] lr : __mmc_blk_ioctl_cmd+0x2cc/0x590
[   31.511408] sp : ffff8000092a39e0
[   31.514717] x29: ffff8000092a3b50 x28: ffff8000092a3d28 x27: 0000000000000000
[   31.521853] x26: ffff80000a5a3cf0 x25: ffff000018bbb400 x24: 0000fffffc386a08
[   31.528989] x23: ffff000018a8b808 x22: 0000000000000000 x21: 00000000ffffffff
[   31.536124] x20: ffff000018a8b800 x19: ffff0000048c6680 x18: 0000000000000000
[   31.543260] x17: 0000000000000000 x16: 0000000000000000 x15: 0000146d78b52ba4
[   31.550394] x14: 0000000000000206 x13: 0000000000000001 x12: 0000000000000000
[   31.557529] x11: 0000000000000000 x10: 00000000000009b0 x9 : 0000000000000651
[   31.564664] x8 : ffff8000092a3ad8 x7 : 0000000000000000 x6 : 0000000000000000
[   31.571800] x5 : 0000000000000200 x4 : 0000000000000000 x3 : 00000000000003e8
[   31.578935] x2 : 0000000000000000 x1 : 000000000000001d x0 : 0000000000000017
[   31.586071] Call trace:
[   31.588513]  __mmc_blk_ioctl_cmd+0x12c/0x590
[   31.592782]  mmc_blk_mq_issue_rq+0x50c/0x920
[   31.597049]  mmc_mq_queue_rq+0x118/0x2ac
[   31.600970]  blk_mq_dispatch_rq_list+0x1a8/0x8b0
[   31.605588]  __blk_mq_sched_dispatch_requests+0xb8/0x164
[   31.610898]  blk_mq_sched_dispatch_requests+0x3c/0x80
[   31.615946]  __blk_mq_run_hw_queue+0x68/0xa0
[   31.620215]  blk_mq_run_work_fn+0x20/0x30
[   31.624223]  process_one_work+0x1d0/0x320
[   31.628238]  worker_thread+0x14c/0x444
[   31.631989]  kthread+0x10c/0x110
[   31.635219]  ret_from_fork+0x10/0x20
[   31.638801] Code: 12010000 2a010000 b90137e0 b4000078 (b9400f00)
[   31.644888] ---[ end trace 0000000000000000 ]---

From a quick look I assume that this is the exact same issue you are
fixing here, correct?

Francesco


