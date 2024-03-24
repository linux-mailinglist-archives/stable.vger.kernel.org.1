Return-Path: <stable+bounces-28718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B69B7887EB4
	for <lists+stable@lfdr.de>; Sun, 24 Mar 2024 20:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D23BA1C2088F
	for <lists+stable@lfdr.de>; Sun, 24 Mar 2024 19:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDF4DDBC;
	Sun, 24 Mar 2024 19:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="0b/Ora4k"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5B18BFB;
	Sun, 24 Mar 2024 19:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711308258; cv=none; b=J6EgIHYkSyHQNlMtNj0yjpoeHcA+Ofu57939sA3nmNAA4yiHOYyKjHoI13/lpaQpLkAtUy/GIv/5SAGatUJFRtwj/m1EyzcSCR2OX76S4XhpBY1uBI37psGcVQQbJnnqIfX3K+CCqPJtYwX/mL/sU9vs9SkLy6Lms1qOZjXaDMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711308258; c=relaxed/simple;
	bh=mU9BZXNWlcauzhrp/dae5ySO94zTq0kEsd+cLciYMBE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=gD+e8YTj45Nlval0qsMsv45ebAgw1Lcp6Uc6YE+1el/xpNgdAZKpA0uLNFiTfPpl7nbE7RV+1161W6oku/GEJcvzE2/wnu0Pwhsqr1fsI9KMDlbzZsy3b229EovP+qeZc07udCvcOJVwkGp5l8wh+xIiRcepbhuxhRhHX0RWFyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=0b/Ora4k; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from [127.0.0.1] (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 5B96C1F83F;
	Sun, 24 Mar 2024 20:24:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1711308251;
	bh=AFQijQdlTfdbMgqb1u10qB+S9Xj/Z5XrLhbK3f+k9XE=; h=From:To:Subject;
	b=0b/Ora4kPMUhJk2Bm2HfGq1BenwxrYtyJGLniG7Kv5MdAUeL/YSUDFID53QHHhE+C
	 4lLhIEeR3g+itREyCSIVjHXbhmmkqYwYVA25IdzeCdzPUD0fKiIssyhZf6/ONPtnk+
	 CykcdquhityyOyD/tZD/6eGyMWD0Ok7yLKkfGBlTtzNVTjHFgQax1j9HdH1RvW+LEd
	 A7l+fd+va2hPAukYe/nMogjLlS/aHZuypiMFpaz9IpY0OHKXsdgCMfqCiC3YVhl6Ee
	 CZznpeAuee7GW+Zzk++cPcXTcw1H2seQYyU10cgyBK6d0+KFeMUrOvvbN2hJrJgqHV
	 d5Xl3qELbRVQw==
Date: Sun, 24 Mar 2024 20:24:10 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Avri Altman <Avri.Altman@wdc.com>,
 "mikko.rapeli@linaro.org" <mikko.rapeli@linaro.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: =?US-ASCII?Q?RE=3A_=5BPATCH_2/2=5D_mmc_core_block=2Ec=3A_av?=
 =?US-ASCII?Q?oid_negative_index_with_array_access?=
User-Agent: K-9 Mail for Android
In-Reply-To: <DM6PR04MB657584F970178D5F392E3B02FC372@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240313133744.2405325-1-mikko.rapeli@linaro.org> <20240313133744.2405325-2-mikko.rapeli@linaro.org> <20240324161755.GA52910@francesco-nb> <DM6PR04MB657584F970178D5F392E3B02FC372@DM6PR04MB6575.namprd04.prod.outlook.com>
Message-ID: <270EB68E-F796-49DF-A50B-E3D7893F97E7@dolcini.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



Il 24 marzo 2024 19:51:19 CET, Avri Altman <Avri=2EAltman@wdc=2Ecom> ha sc=
ritto:
>>=20
>> Hello Mikko and Avri,
>>=20
>> On Wed, Mar 13, 2024 at 03:37:44PM +0200, mikko=2Erapeli@linaro=2Eorg w=
rote:
>> > From: Mikko Rapeli <mikko=2Erapeli@linaro=2Eorg>
>> >
>> > Commit "mmc: core: Use mrq=2Esbc in close-ended ffu" assigns prev_ida=
ta
>> > =3D idatas[i - 1] but doesn't check that int iterator i is greater th=
an
>> > zero=2E Add the check=2E
>> >
>> > Fixes: 4d0c8d0aef63 ("mmc: core: Use mrq=2Esbc in close-ended ffu")
>> >
>> > Link:
>> > https://lore=2Ekernel=2Eorg/all/20231129092535=2E3278-1-avri=2Ealtman=
@wdc=2Ecom/
>> >
>> > Cc: Avri Altman <avri=2Ealtman@wdc=2Ecom>
>> > Cc: Ulf Hansson <ulf=2Ehansson@linaro=2Eorg>
>> > Cc: Adrian Hunter <adrian=2Ehunter@intel=2Ecom>
>> > Cc: linux-mmc@vger=2Ekernel=2Eorg
>> > Cc: stable@vger=2Ekernel=2Eorg
>> > Signed-off-by: Mikko Rapeli <mikko=2Erapeli@linaro=2Eorg>
>>=20
>> I just had the following Oops
>>=20
>> [   31=2E377291] Unable to handle kernel paging request at virtual addr=
ess
>> 0000fffffc386a14
>> [   31=2E385348] Mem abort info:
>> [   31=2E388136]   ESR =3D 0x0000000096000006
>> [   31=2E392338]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>> [   31=2E397681]   SET =3D 0, FnV =3D 0
>> [   31=2E400730]   EA =3D 0, S1PTW =3D 0
>> [   31=2E405397]   FSC =3D 0x06: level 2 translation fault
>> [   31=2E410355] Data abort info:
>> [   31=2E413245]   ISV =3D 0, ISS =3D 0x00000006
>> [   31=2E417086]   CM =3D 0, WnR =3D 0
>> [   31=2E420049] user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000084f=
89000
>> [   31=2E426552] [0000fffffc386a14] pgd=3D0800000084af2003,
>> p4d=3D0800000084af2003, pud=3D0800000083ec0003, pmd=3D0000000000000000
>> [   31=2E437393] Internal error: Oops: 0000000096000006 [#1] PREEMPT SM=
P
>> [   31=2E443657] Modules linked in: crct10dif_ce ti_k3_r5_remoteproc
>> virtio_rpmsg_bus rpmsg_ns rtc_ti_k3 ti_k3_m4_remoteproc ti_k3_common
>> tidss drm_dma_helper mcrc sa2ul lontium_lt8912b tc358768 display_connec=
tor
>> drm_kms_helper ina2xx syscopyarea sysfillrect sysimgblt fb_sys_fops
>> spi_omap2_mcspi pwm_tiehrpwm drm lm75 drm_panel_orientation_quirks
>> optee_rng rng_core
>> [   31=2E475530] CPU: 0 PID: 8 Comm: kworker/0:0H Not tainted
>> 6=2E1=2E80+git=2Eba628d222cde #1
>> [   31=2E483179] Hardware name: Toradex Verdin AM62 on Verdin Developme=
nt
>> Board (DT)
>> [   31=2E490480] Workqueue: kblockd blk_mq_run_work_fn
>> [   31=2E495216] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS =
BTYPE=3D--
>> )
>> [   31=2E502172] pc : __mmc_blk_ioctl_cmd+0x12c/0x590
>> [   31=2E506795] lr : __mmc_blk_ioctl_cmd+0x2cc/0x590
>> [   31=2E511408] sp : ffff8000092a39e0
>> [   31=2E514717] x29: ffff8000092a3b50 x28: ffff8000092a3d28 x27:
>> 0000000000000000
>> [   31=2E521853] x26: ffff80000a5a3cf0 x25: ffff000018bbb400 x24:
>> 0000fffffc386a08
>> [   31=2E528989] x23: ffff000018a8b808 x22: 0000000000000000 x21:
>> 00000000ffffffff
>> [   31=2E536124] x20: ffff000018a8b800 x19: ffff0000048c6680 x18:
>> 0000000000000000
>> [   31=2E543260] x17: 0000000000000000 x16: 0000000000000000 x15:
>> 0000146d78b52ba4
>> [   31=2E550394] x14: 0000000000000206 x13: 0000000000000001 x12:
>> 0000000000000000
>> [   31=2E557529] x11: 0000000000000000 x10: 00000000000009b0 x9 :
>> 0000000000000651
>> [   31=2E564664] x8 : ffff8000092a3ad8 x7 : 0000000000000000 x6 :
>> 0000000000000000
>> [   31=2E571800] x5 : 0000000000000200 x4 : 0000000000000000 x3 :
>> 00000000000003e8
>> [   31=2E578935] x2 : 0000000000000000 x1 : 000000000000001d x0 :
>> 0000000000000017
>> [   31=2E586071] Call trace:
>> [   31=2E588513]  __mmc_blk_ioctl_cmd+0x12c/0x590
>> [   31=2E592782]  mmc_blk_mq_issue_rq+0x50c/0x920
>> [   31=2E597049]  mmc_mq_queue_rq+0x118/0x2ac
>> [   31=2E600970]  blk_mq_dispatch_rq_list+0x1a8/0x8b0
>> [   31=2E605588]  __blk_mq_sched_dispatch_requests+0xb8/0x164
>> [   31=2E610898]  blk_mq_sched_dispatch_requests+0x3c/0x80
>> [   31=2E615946]  __blk_mq_run_hw_queue+0x68/0xa0
>> [   31=2E620215]  blk_mq_run_work_fn+0x20/0x30
>> [   31=2E624223]  process_one_work+0x1d0/0x320
>> [   31=2E628238]  worker_thread+0x14c/0x444
>> [   31=2E631989]  kthread+0x10c/0x110
>> [   31=2E635219]  ret_from_fork+0x10/0x20
>> [   31=2E638801] Code: 12010000 2a010000 b90137e0 b4000078 (b9400f00)
>> [   31=2E644888] ---[ end trace 0000000000000000 ]---
>>=20
>> From a quick look I assume that this is the exact same issue you are fi=
xing here,
>> correct?
>Probably=2E  Did you applied the patch and the issue persists?

It's not systematic, probably it depends on what is in the memory at this =
negative indexed array=2E

I would try to confirm is the exact same issue tomorrow=2E Worth mentionin=
g that on our system this leads to some pretty bad failures (data corruptio=
n)=2E

Considering that the buggy commit was back ported to LTS kernel (6=2E1, in=
 my case), we should have this into mainline as soon as possible, so that t=
he fix can also be backported=2E

Francesco=20


