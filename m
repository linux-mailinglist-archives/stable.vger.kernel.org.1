Return-Path: <stable+bounces-141747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B77AAB8CB
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 08:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE471167513
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4792BD01C;
	Tue,  6 May 2025 03:57:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5B728D82D
	for <stable@vger.kernel.org>; Tue,  6 May 2025 01:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746494387; cv=none; b=Bfc46WKiQ9hySfYLMtkNuHdzxVde/Klu5ykHgJ9Y7860qS/N58bv9opu0QUJ4duTjyCM/QvC7fp80CIvaEdMBfqdWu6Ehq9g0QpY0eaERdA5mW7ZKLV7ySDI4sMOFwkklFIwhIpGOlCd5+h41auiJthc2zrNokMMr1enpLssh1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746494387; c=relaxed/simple;
	bh=nqwxfFvgqHLfsvql7jPXs8YVN6cteKnyq1nBTYDvWFU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TvlJS6sowrRm6Lwc8M8LqQ4ylZgwDseBEDId9Emdlfez0ys3EUdyDMg9Fby0wG3ETg5HBga5Th7T1PDJZjMqhuYZ7WUVDDki6Vk2x9Gz4t5Aje9/12Je1FMEkt5yvF90DkbBjI63FsqFyGG2aaY2j4x25aBYPT5/mOCwfbJyvqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zs0st5TgGz4f3jMB
	for <stable@vger.kernel.org>; Tue,  6 May 2025 09:19:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B1C261A07BD
	for <stable@vger.kernel.org>; Tue,  6 May 2025 09:19:40 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgC3Gl+pYxlonTM_Lg--.27609S3;
	Tue, 06 May 2025 09:19:38 +0800 (CST)
Subject: Re: [regression 6.1.y] discard/TRIM through RAID10 blocking
To: Yu Kuai <yukuai1@huaweicloud.com>,
 Salvatore Bonaccorso <carnil@debian.org>,
 Melvin Vermeeren <vermeeren@vermwa.re>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: 1104460@bugs.debian.org, Coly Li <colyli@kernel.org>,
 Sasha Levin <sashal@kernel.org>, stable <stable@vger.kernel.org>,
 regressions@lists.linux.dev, "yukuai (C)" <yukuai3@huawei.com>
References: <174602441004.174814.6400502946223473449.reportbug@talos.vermwa.re>
 <aBJH6Nsh-7Zj55nN@eldamar.lan>
 <8f57717a-1af1-468f-6229-71e1bf8fc871@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <3e9a9337-a276-a4b2-f25b-cec38047227a@huaweicloud.com>
Date: Tue, 6 May 2025 09:19:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8f57717a-1af1-468f-6229-71e1bf8fc871@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3Gl+pYxlonTM_Lg--.27609S3
X-Coremail-Antispam: 1UD129KBjvAXoWfJFWkWw1rtw13Zr4kXF13Jwb_yoW8Zry7Co
	WUGw13Ja1rWr1UGr1UGw1Utr15Jr1UXFnrAr1UKr13GF18Jr1Ut3s5JryUJ3yUJr18GF18
	Gr1UJr1UJa4UJrs7n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYW7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
	Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUFg4SDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/05/06 9:11, Yu Kuai 写道:
> Hi,
> 
> 在 2025/04/30 23:55, Salvatore Bonaccorso 写道:
>> Hi
>>
>> We got a regression report in Debian after the update from 6.1.133 to
>> 6.1.135. Melvin is reporting that discard/trimm trhough a RAID10 array
>> stalls idefintively. The full report is inlined below and originates
>> from https://bugs.debian.org/1104460 .
>>
>> On Wed, Apr 30, 2025 at 04:46:50PM +0200, Melvin Vermeeren wrote:
>>> Package: src:linux
>>> Version: 6.1.135-1
>>> Severity: important
>>> Tags: upstream
>>> X-Debbugs-Cc: vermeeren@vermwa.re
>>>
>>> Dear Maintainer,
>>>
>>> Upgrading from linux-image-6.1.0-33-powerpc64le (6.1.133-1) to
>>> linux-image-6.1.0-34-powerpc64le (6.1.135-1) it appears there is a
>>> serious regression bug related to discard/TRIM through a RAID10 array.
>>> This only affects RAID10, RAID1 array on the same SSD device is not
>>> affected. Array in question is a fairly standard RAID10 in 2far layout.
>>>
>>> md127 : active raid10 dm-1[2] dm-0[0]
>>>        1872188416 blocks super 1.2 512K chunks 2 far-copies [2/2] [UU]
>>>        bitmap: 1/1 pages [64KB], 65536KB chunk
>>>
>>> Any discard operation will result in quite a long kernel error. The
>>> calling process will either segfault (swapon) or, more likely, be stuck
>>> forever (Qemu, fstrim) in the D state per htop. The iostat utility
>>> reports a %util of 100% for any device on top of (directly or
>>> indirectly) of the RAID10 device, despite there being no read or write
>>> requests to the devices or any other acitivty.
>>>
>>> Stuck processes cannot be terminated or killed. Attempting to reboot
>>> normally will result in a stuck machine on shutdown, so only a
>>> REISUB-style reboot will work via procfs sysrq.
>>>
>>> I have briefly diffed and inspected commits between the two kernel
>>> versions and I suspect the commit below may be at fault. Do keep in mind
>>> I have not verified this in any way, so I may be wrong.
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=4a05f7ae33716d996c5ce56478a36a3ede1d76f2 
>>>
>>>
> 
> Thanks for the report, the commit relied on another commit
> 820455238366 ("md/raid10: switch to use md_account_bio() for io
> accounting"), and it's wrong for v6.1. I'll send a revert soon.

Take a look at the report stack, looks like the relied patch is actually
https://lore.kernel.org/all/20230621165110.1498313-2-yukuai1@huaweicloud.com/

Thanks,
Kuai

> 
> Thanks,
> Kuai
> 
>>> Considering this is shipped as part of a stable security update I
>>> consider it quite a serious bug. Affected hosts will not boot up
>>> cleanly, may not have swap, processes will freeze upon discard and clean
>>> reboot it also not possible.
>>>
>>> More logs available upon request.
>>>
>>> Many thanks,
>>>
>>> Melvin Vermeeren.
>>>
>>> -- Package-specific info:
>>> ** Version:
>>> Linux version 6.1.0-34-powerpc64le (debian-kernel@lists.debian.org) 
>>> (gcc-12 (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 
>>> 2.40) #1 SMP Debian 6.1.135-1 (2025-04-25)
>>>
>>> ** Command line:
>>> root=/dev/mapper/...-root ro quiet
>>>
>>> ** Not tainted
>>>
>>> ** Kernel log:
>>> # /etc/fstab entry
>>> /dev/.../swap none swap sw,discard=once 0 0
>>>
>>> ~# swapon -va
>>> swapon: /dev/mapper/...-swap: found signature [pagesize=65536, 
>>> signature=swap]
>>> swapon: /dev/mapper/...-swap: pagesize=65536, swapsize=17179869184, 
>>> devsize=17179869184
>>> swapon /dev/mapper/...-swap
>>> Segmentation fault
>>>
>>> ~# dmesg
>>> ...
>>> [  223.017257] kernel tried to execute user page (0) - exploit 
>>> attempt? (uid: 0)
>>> [  223.017287] BUG: Unable to handle kernel instruction fetch (NULL 
>>> pointer?)
>>> [  223.017301] Faulting instruction address: 0x00000000
>>> [  223.017326] Oops: Kernel access of bad area, sig: 11 [#1]
>>> [  223.017338] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA PowerNV
>>> [  223.017365] Modules linked in: bridge stp llc binfmt_misc 
>>> nft_connlimit nf_conncount ast drm_vram_helper drm_ttm_helper ofpart 
>>> ipmi_powernv ttm ipmi_devintf powernv_flash at24 mtd ipmi_msghandler 
>>> opal_prd regmap_i2c drm_kms_helper syscopyarea sysfillrect sysimgblt 
>>> fb_sys_fops i2c_algo_bit sg nft_reject_inet nf_reject_ipv4 
>>> nf_reject_ipv6 nft_reject nft_ct nf_conntrack nf_defrag_ipv6 
>>> nf_defrag_ipv4 nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib 
>>> nf_tables nfnetlink drm loop fuse drm_panel_orientation_quirks 
>>> configfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 dm_crypt 
>>> dm_integrity dm_bufio dm_mod macvlan raid10 raid456 async_raid6_recov 
>>> async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c 
>>> crc32c_generic raid1 raid0 multipath linear md_mod sd_mod t10_pi 
>>> crc64_rocksoft_generic crc64_rocksoft crc_t10dif crct10dif_generic 
>>> crc64 crct10dif_common xhci_pci xts ecb xhci_hcd ctr vmx_crypto 
>>> gf128mul crc32c_vpmsum tg3 mpt3sas usbcore raid_class libphy 
>>> scsi_transport_sas usb_common
>>> [  223.017812] CPU: 8 PID: 10609 Comm: swapon Not tainted 
>>> 6.1.0-34-powerpc64le #1  Debian 6.1.135-1
>>> [  223.017844] Hardware name: T2P9D01 REV 1.01 POWER9 0x4e1202 
>>> opal:skiboot-bc106a0 PowerNV
>>> [  223.017879] NIP:  0000000000000000 LR: c0000000003efe70 CTR: 
>>> 0000000000000000
>>> [  223.017926] REGS: c0000000276cf200 TRAP: 0400   Not tainted  
>>> (6.1.0-34-powerpc64le Debian 6.1.135-1)
>>> [  223.017979] MSR:  900000004280b033 
>>> <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 24004480  XER: 00000004
>>> [  223.018060] CFAR: c0000000003efe6c IRQMASK: 0
>>>                 GPR00: c0000000003efec4 c0000000276cf4a0 
>>> c000000001148100 0000000000092800
>>>                 GPR04: 0000000000000000 0000000000000003 
>>> 0000000000000c00 c00000000296e700
>>>                 GPR08: c00000000c0e9700 00000c0000090800 
>>> 0000000000000000 0000000000002000
>>>                 GPR12: 0000000000000000 c000001ffffd9800 
>>> c0000000446b8c00 0000000000000000
>>>                 GPR16: 0000000000000400 0000000000000000 
>>> 0000000000000001 000000000000c812
>>>                 GPR20: 000000000000c911 c0000000170c5700 
>>> c00000000296e718 c00000000296e3f0
>>>                 GPR24: 0000000000000000 00000000000003ff 
>>> 0000000000000000 0000000000000c00
>>>                 GPR28: c000200009e2dd00 c00000000296e718 
>>> 00000c0000092800 0000000000092c00
>>> [  223.018372] NIP [0000000000000000] 0x0
>>> [  223.018397] LR [c0000000003efe70] mempool_alloc+0xa0/0x210
>>> [  223.018435] Call Trace:
>>> [  223.018453] [c0000000276cf4a0] [c0000000003efec4] 
>>> mempool_alloc+0xf4/0x210 (unreliable)
>>> [  223.018507] [c0000000276cf520] [c000000000743bf8] 
>>> bio_alloc_bioset+0x368/0x510
>>> [  223.018552] [c0000000276cf5a0] [c000000000743e74] 
>>> bio_alloc_clone+0x44/0xa0
>>> [  223.018601] [c0000000276cf5e0] [c008000015793adc] 
>>> md_account_bio+0x54/0xb0 [md_mod]
>>> [  223.018655] [c0000000276cf610] [c00800001567778c] 
>>> raid10_make_request+0xc54/0x1040 [raid10]
>>> [  223.018687] [c0000000276cf770] [c00800001579a290] 
>>> md_handle_request+0x198/0x380 [md_mod]
>>> [  223.018735] [c0000000276cf800] [c00000000074c32c] 
>>> __submit_bio+0x9c/0x250
>>> [  223.018773] [c0000000276cf840] [c00000000074ca88] 
>>> submit_bio_noacct_nocheck+0x178/0x3f0
>>> [  223.018825] [c0000000276cf8b0] [c000000000743e08] 
>>> blk_next_bio+0x68/0x90
>>> [  223.018863] [c0000000276cf8e0] [c000000000758c60] 
>>> __blkdev_issue_discard+0x180/0x280
>>> [  223.018898] [c0000000276cf980] [c000000000758de8] 
>>> blkdev_issue_discard+0x88/0x120
>>> [  223.018927] [c0000000276cfa00] [c0000000004a9e8c] 
>>> sys_swapon+0x11dc/0x18a0
>>> [  223.018971] [c0000000276cfb50] [c00000000002b038] 
>>> system_call_exception+0x138/0x260
>>> [  223.019015] [c0000000276cfe10] [c00000000000c0f0] 
>>> system_call_vectored_common+0xf0/0x280
>>> [  223.019058] --- interrupt: 3000 at 0x7fff95146770
>>> [  223.019095] NIP:  00007fff95146770 LR: 00007fff95146770 CTR: 
>>> 0000000000000000
>>> [  223.019132] REGS: c0000000276cfe80 TRAP: 3000   Not tainted  
>>> (6.1.0-34-powerpc64le Debian 6.1.135-1)
>>> [  223.019182] MSR:  900000000280f033 
>>> <SF,HV,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 48002481  XER: 00000000
>>> [  223.019267] IRQMASK: 0
>>>                 GPR00: 0000000000000057 00007fffdca2ace0 
>>> 00007fff95256f00 00000001220a1c20
>>>                 GPR04: 0000000000030000 000000000000001e 
>>> 000000000000000a 000000000000000a
>>>                 GPR08: 0000000000000000 0000000000000000 
>>> 0000000000000000 0000000000000000
>>>                 GPR12: 0000000000000000 00007fff955dcbc0 
>>> 0000000000000000 0000000000000000
>>>                 GPR16: 0000000000000000 00000001104066b0 
>>> 00007fffdca2afc8 000000011040cbd0
>>>                 GPR20: 000000011040cbd8 0000000000000000 
>>> 0000000000010000 00007fffdca2aff0
>>>                 GPR24: 00007fffdca2afd0 0000000000000003 
>>> 0000000000030000 0000000400000000
>>>                 GPR28: 00000001220a1c20 000000000000fff6 
>>> 00000001220a30a0 0000000000100000
>>> [  223.019542] NIP [00007fff95146770] 0x7fff95146770
>>> [  223.019568] LR [00007fff95146770] 0x7fff95146770
>>> [  223.019595] --- interrupt: 3000
>>> [  223.019604] Instruction dump:
>>> [  223.019626] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
>>> XXXXXXXX XXXXXXXX
>>> [  223.019665] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
>>> XXXXXXXX XXXXXXXX
>>> [  223.019712] ---[ end trace 0000000000000000 ]---
>>>
>>> [  224.623456] note: swapon[10609] exited with irqs disabled
>>> [  224.623483] ------------[ cut here ]------------
>>> [  224.623502] WARNING: CPU: 8 PID: 10609 at kernel/exit.c:816 
>>> do_exit+0x94/0xbc0
>>> [  224.623516] Modules linked in: bridge stp llc binfmt_misc 
>>> nft_connlimit nf_conncount ast drm_vram_helper drm_ttm_helper ofpart 
>>> ipmi_powernv ttm ipmi_devintf powernv_flash at24 mtd ipmi_msghandler 
>>> opal_prd regmap_i2c drm_kms_helper syscopyarea sysfillrect sysimgblt 
>>> fb_sys_fops i2c_algo_bit sg nft_reject_inet nf_reject_ipv4 
>>> nf_reject_ipv6 nft_reject nft_ct nf_conntrack nf_defrag_ipv6 
>>> nf_defrag_ipv4 nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib 
>>> nf_tables nfnetlink drm loop fuse drm_panel_orientation_quirks 
>>> configfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 dm_crypt 
>>> dm_integrity dm_bufio dm_mod macvlan raid10 raid456 async_raid6_recov 
>>> async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c 
>>> crc32c_generic raid1 raid0 multipath linear md_mod sd_mod t10_pi 
>>> crc64_rocksoft_generic crc64_rocksoft crc_t10dif crct10dif_generic 
>>> crc64 crct10dif_common xhci_pci xts ecb xhci_hcd ctr vmx_crypto 
>>> gf128mul crc32c_vpmsum tg3 mpt3sas usbcore raid_class libphy 
>>> scsi_transport_sas usb_common
>>> [  224.623825] CPU: 8 PID: 10609 Comm: swapon Tainted: G      
>>> D            6.1.0-34-powerpc64le #1  Debian 6.1.135-1
>>> [  224.623860] Hardware name: T2P9D01 REV 1.01 POWER9 0x4e1202 
>>> opal:skiboot-bc106a0 PowerNV
>>> [  224.623892] NIP:  c000000000140fa4 LR: c000000000140fa0 CTR: 
>>> 0000000000000000
>>> [  224.623935] REGS: c0000000276cecb0 TRAP: 0700   Tainted: G      
>>> D             (6.1.0-34-powerpc64le Debian 6.1.135-1)
>>> [  224.623969] MSR:  9000000002029033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE>  
>>> CR: 24004222  XER: 00000004
>>> [  224.624012] CFAR: c00000000013ea68 IRQMASK: 0
>>>                 GPR00: c000000000140fa0 c0000000276cef50 
>>> c000000001148100 0000000000000000
>>>                 GPR04: 0000000000000000 c0000000276cee20 
>>> c0000000276cee18 0000001ffb000000
>>>                 GPR08: 0000000000000027 c0000000276cf9b0 
>>> 0000000000000000 0000000000004000
>>>                 GPR12: 0000000031c40000 c000001ffffd9800 
>>> c0000000446b8c00 0000000000000000
>>>                 GPR16: 0000000000000400 0000000000000000 
>>> 0000000000000001 000000000000c812
>>>                 GPR20: 000000000000c911 c0000000170c5700 
>>> c00000000296e718 c00000000296e3f0
>>>                 GPR24: 0000000000000000 00000000000003ff 
>>> 0000000000000000 0000000000000c00
>>>                 GPR28: 000000000000000b c00000001ce25d80 
>>> c000000078409c00 c000000026529d80
>>> [  224.624208] NIP [c000000000140fa4] do_exit+0x94/0xbc0
>>> [  224.624239] LR [c000000000140fa0] do_exit+0x90/0xbc0
>>> [  224.624269] Call Trace:
>>> [  224.624274] [c0000000276cef50] [c000000000140fa0] 
>>> do_exit+0x90/0xbc0 (unreliable)
>>> [  224.624308] [c0000000276cf020] [c000000000141b80] 
>>> make_task_dead+0xb0/0x1f0
>>> [  224.624320] [c0000000276cf0a0] [c000000000025718] 
>>> oops_end+0x188/0x1c0
>>> [  224.624341] [c0000000276cf120] [c00000000007f72c] 
>>> __bad_page_fault+0x18c/0x1b0
>>> [  224.624375] [c0000000276cf190] [c000000000008cd4] 
>>> instruction_access_common_virt+0x194/0x1a0
>>> [  224.624421] --- interrupt: 400 at 0x0
>>> [  224.624438] NIP:  0000000000000000 LR: c0000000003efe70 CTR: 
>>> 0000000000000000
>>> [  224.624471] REGS: c0000000276cf200 TRAP: 0400   Tainted: G      
>>> D             (6.1.0-34-powerpc64le Debian 6.1.135-1)
>>> [  224.624507] MSR:  900000004280b033 
>>> <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 24004480  XER: 00000004
>>> [  224.624544] CFAR: c0000000003efe6c IRQMASK: 0
>>>                 GPR00: c0000000003efec4 c0000000276cf4a0 
>>> c000000001148100 0000000000092800
>>>                 GPR04: 0000000000000000 0000000000000003 
>>> 0000000000000c00 c00000000296e700
>>>                 GPR08: c00000000c0e9700 00000c0000090800 
>>> 0000000000000000 0000000000002000
>>>                 GPR12: 0000000000000000 c000001ffffd9800 
>>> c0000000446b8c00 0000000000000000
>>>                 GPR16: 0000000000000400 0000000000000000 
>>> 0000000000000001 000000000000c812
>>>                 GPR20: 000000000000c911 c0000000170c5700 
>>> c00000000296e718 c00000000296e3f0
>>>                 GPR24: 0000000000000000 00000000000003ff 
>>> 0000000000000000 0000000000000c00
>>>                 GPR28: c000200009e2dd00 c00000000296e718 
>>> 00000c0000092800 0000000000092c00
>>> [  224.624732] NIP [0000000000000000] 0x0
>>> [  224.624749] LR [c0000000003efe70] mempool_alloc+0xa0/0x210
>>> [  224.624771] --- interrupt: 400
>>> [  224.624789] [c0000000276cf4a0] [c0000000003efec4] 
>>> mempool_alloc+0xf4/0x210 (unreliable)
>>> [  224.624823] [c0000000276cf520] [c000000000743bf8] 
>>> bio_alloc_bioset+0x368/0x510
>>> [  224.624859] [c0000000276cf5a0] [c000000000743e74] 
>>> bio_alloc_clone+0x44/0xa0
>>> [  224.624892] [c0000000276cf5e0] [c008000015793adc] 
>>> md_account_bio+0x54/0xb0 [md_mod]
>>> [  224.624930] [c0000000276cf610] [c00800001567778c] 
>>> raid10_make_request+0xc54/0x1040 [raid10]
>>> [  224.624964] [c0000000276cf770] [c00800001579a290] 
>>> md_handle_request+0x198/0x380 [md_mod]
>>> [  224.624997] [c0000000276cf800] [c00000000074c32c] 
>>> __submit_bio+0x9c/0x250
>>> [  224.625018] [c0000000276cf840] [c00000000074ca88] 
>>> submit_bio_noacct_nocheck+0x178/0x3f0
>>> [  224.625043] [c0000000276cf8b0] [c000000000743e08] 
>>> blk_next_bio+0x68/0x90
>>> [  224.625066] [c0000000276cf8e0] [c000000000758c60] 
>>> __blkdev_issue_discard+0x180/0x280
>>> [  224.625091] [c0000000276cf980] [c000000000758de8] 
>>> blkdev_issue_discard+0x88/0x120
>>> [  224.625115] [c0000000276cfa00] [c0000000004a9e8c] 
>>> sys_swapon+0x11dc/0x18a0
>>> [  224.625139] [c0000000276cfb50] [c00000000002b038] 
>>> system_call_exception+0x138/0x260
>>> [  224.625164] [c0000000276cfe10] [c00000000000c0f0] 
>>> system_call_vectored_common+0xf0/0x280
>>> [  224.625201] --- interrupt: 3000 at 0x7fff95146770
>>> [  224.625270] NIP:  00007fff95146770 LR: 00007fff95146770 CTR: 
>>> 0000000000000000
>>> [  224.625367] REGS: c0000000276cfe80 TRAP: 3000   Tainted: G      
>>> D             (6.1.0-34-powerpc64le Debian 6.1.135-1)
>>> [  224.625458] MSR:  900000000000f033 
>>> <SF,HV,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 48002481  XER: 00000000
>>> [  224.625570] IRQMASK: 0
>>>                 GPR00: 0000000000000057 00007fffdca2ace0 
>>> 00007fff95256f00 00000001220a1c20
>>>                 GPR04: 0000000000030000 000000000000001e 
>>> 000000000000000a 000000000000000a
>>>                 GPR08: 0000000000000000 0000000000000000 
>>> 0000000000000000 0000000000000000
>>>                 GPR12: 0000000000000000 00007fff955dcbc0 
>>> 0000000000000000 0000000000000000
>>>                 GPR16: 0000000000000000 00000001104066b0 
>>> 00007fffdca2afc8 000000011040cbd0
>>>                 GPR20: 000000011040cbd8 0000000000000000 
>>> 0000000000010000 00007fffdca2aff0
>>>                 GPR24: 00007fffdca2afd0 0000000000000003 
>>> 0000000000030000 0000000400000000
>>>                 GPR28: 00000001220a1c20 000000000000fff6 
>>> 00000001220a30a0 0000000000100000
>>> [  224.626325] NIP [00007fff95146770] 0x7fff95146770
>>> [  224.626388] LR [00007fff95146770] 0x7fff95146770
>>> [  224.626522] --- interrupt: 3000
>>> [  224.626568] Instruction dump:
>>> [  224.626587] 60000000 813f000c 3929ffff 2c090000 913f000c 40820010 
>>> 813f0074 71290004
>>> [  224.626680] 4182074c 7fa3eb78 4bffda7d e93e0b10 <0b090000> 
>>> e87e0a48 48c7dd0d 60000000
>>> [  224.626786] ---[ end trace 0000000000000000 ]---
>>
>> Does this ring a bell?
>>
>> Melvin, the same change went as well in other stable series, 6.6.88,
>> 6.12.25, 6.14.4, can you test e.g. 6.12.25-1 in Debian as well from
>> unstable to see if the regression is there as well?
>>
>> Might you be able to bisect the upstream stable series between 6.1.133
>> to 6.1.135 to really confirm the mentioned commit is the one breaking?
>>
>> Regards,
>> Salvatore
>>
>> .
>>


