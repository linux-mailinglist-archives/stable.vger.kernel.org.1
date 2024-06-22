Return-Path: <stable+bounces-54868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA6B9133A5
	for <lists+stable@lfdr.de>; Sat, 22 Jun 2024 14:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E7891F228B4
	for <lists+stable@lfdr.de>; Sat, 22 Jun 2024 12:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17567155741;
	Sat, 22 Jun 2024 12:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAePYSVP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0A9155353;
	Sat, 22 Jun 2024 12:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719057725; cv=none; b=ctm11n3MBU4z+3vGEPM4930HhbXY5IBI0Mc48jc/HU2H7ZZoh855mOrMoQR2+my1QpMwY6mmPWOqkoJvEd3qVoh5ZqqHYxxfoNsi8OyUriQetrKEbTSMdfmwhtEiK56NYRFOErVhUpNjdNOs8AW8csyudWMDDlQiOYju3n8X5Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719057725; c=relaxed/simple;
	bh=pKm7aBnB4eQyN2yxIeRksOuD82htf6dmCnmcX+fqIbs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NHT/2R6VQDMA2D5MjxR8T6IbBxsNPAIfk1E7kfaGF3URL8thG4PkaQY1imORGyvsfo39GjY2DknrOdistaGyMT1QLpNHk9ZjWarsCM6A6N/gF9NxTBN8UdwTLHLsOmZSCJhisECOmD8dC8Li1qFTziXGpqIWr4x2W1LSyfy6ggg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAePYSVP; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f4c7b022f8so25017715ad.1;
        Sat, 22 Jun 2024 05:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719057723; x=1719662523; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7BUAtZoN7iWs7Su2BECN/OwNZupudGage3ZVXNwoGn0=;
        b=BAePYSVP3ecJ3uJcvfrSWgXCG+csDh1tBb3RhPEG7r9jWZxygk5m0FKBDGWUcUS4f8
         592DJku1UYle3tnhtpAPaCneXAsmKaCfpSRL3GjylWScLGRvtwxFZsDm1HRbYJDkI6QE
         tmosQk/7ezGqCb9QftWjNMeQ1WTbaXUPvrNxWwQ+H7+EYU/U0o46R/8xgayhp8TiPz6C
         4Rb4tsfUnxeYPnJKOiHBCkdRy4PA/oRYB59iZqNnlZBYCoiRZ+8gzNJjiA3XHtN4kcwH
         CHaVI34g843ffe7vuPvajZ8QdTZ7YOQKO1RUNSTFJk4PmkPuLHt1VLSmiqzmT9VMZV07
         PPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719057723; x=1719662523;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7BUAtZoN7iWs7Su2BECN/OwNZupudGage3ZVXNwoGn0=;
        b=QJzAgwWd5SiKrH36CU/yBQdfXDNgPBfxav7F86VCJ9dIFhh3YLLUvlA2ejObdwEXck
         neeqHznPudzXL4qe2w40C09Fh07opEEthrdGEfsKsoNE1mxLGTgSIsV4Ngbh5hMf37vg
         BJ8Rs5AEMwLtNOcPCGzIbK5QQ4+qQ20ftjWUUYmryUKUtWIlk5tb6pEygcMHlV47ssLQ
         /bCEtbGn3zzhFkE6b2RbDUxUULqjQ2Z7QZUmhz76+oL4kYEq3YQ6WX1BuKBn2JbcfKt+
         fQtmwV2rIBOM2oH5AQHP8O9bn43lG5bxRgE4uzj+ODMIcQgvq4WDtSTldofP7naoA3/W
         YZXA==
X-Forwarded-Encrypted: i=1; AJvYcCUJNj9Wf0+jHW0KiAy+caT29Thi3YAK0fATNNdxkCgIPLbhQZhcbA8efUaRhJP24tlh+kdgIHnwdCijRmVr8EBhZmogLyf8+lwmIsRBmmWNxewfAUCKUQLY7CriLpnxu0LF6uP/hSUSSlCRqo0Mnr7+mgo4Bu+8OyWIJQupxAM0HYi9ITowkBN+dg+3wQPEkLEJ6GjbxnIWA+SV0IxpCDPP
X-Gm-Message-State: AOJu0YzSnHAbvM32MKRUxRlAPBZVXdJHJggEqpmJM5Np5KWGaNNznexH
	djQPZv2NOa2XdPgAaiffHbmW7o1VJNc49EZsRjcI/mg3JOMHWuyZ
X-Google-Smtp-Source: AGHT+IFHL0Zt01i2MdAdOvx3XYxPHff1JpAd7jFwiKPOD/dtP5oKNpEh0R8HvXZcSw645QE3uh0qdg==
X-Received: by 2002:a17:902:e742:b0:1f9:fca9:742d with SMTP id d9443c01a7336-1f9fca977e3mr36663935ad.37.1719057722908;
        Sat, 22 Jun 2024 05:02:02 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb2f0374sm29596165ad.22.2024.06.22.05.01.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jun 2024 05:02:02 -0700 (PDT)
Message-ID: <e2f9da4e-919d-4a98-919d-167726ef6bc7@gmail.com>
Date: Sat, 22 Jun 2024 21:01:55 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tracing/net_sched: NULL pointer dereference in
 perf_trace_qdisc_reset()
From: Yunseong Kim <yskelg@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Pedro Tammela <pctammela@mojatatu.com>,
 netdev@vger.kernel.org, stable@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Takashi Iwai <tiwai@suse.de>, "David S. Miller" <davem@davemloft.net>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Austin Kim <austindh.kim@gmail.com>,
 shjy180909@gmail.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, ppbuk5246@gmail.com,
 Yeoreum Yun <yeoreum.yun@arm.com>, virtualization@lists.linux.dev
References: <20240622045701.8152-2-yskelg@gmail.com>
 <CAMArcTVgpAq8dC_u8eFE=asMWriWjNfYsmo6KVFi=tpHebdmCA@mail.gmail.com>
 <80f28cfb-f287-419b-a448-b5967bc778ae@gmail.com>
Content-Language: en-US
In-Reply-To: <80f28cfb-f287-419b-a448-b5967bc778ae@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 6/22/24 3:12 오후, Yunseong Kim wrote:
> Hi Taehee,
> 
> On 6/22/24 2:50 오후, Taehee Yoo wrote:
>> On Sat, Jun 22, 2024 at 1:58 PM <yskelg@gmail.com> wrote:
>>>
>>> From: Yunseong Kim <yskelg@gmail.com>
>>>
>>
>> Hi Yunseong,
>> Thanks a lot for this work!
> 
> Thank you Taehee for reviewing our patch. It's greatly appreciated.
> 
>>> During qdisc initialization, qdisc was being set to noop_queue.
>>> In veth_init_queue, the initial tx_num was reduced back to one,
>>> causing the qdisc reset to be called with noop, which led to the kernel panic.
>>>
>>> I've attached the GitHub gist link that C converted syz-execprogram
>>> source code and 3 log of reproduced vmcore-dmesg.
>>>
>>>  https://gist.github.com/yskelg/cc64562873ce249cdd0d5a358b77d740
>>>
>>> Yeoreum and I use two fuzzing tool simultaneously.
>>>
>>> One process with syz-executor : https://github.com/google/syzkaller
>>>
>>>  $ ./syz-execprog -executor=./syz-executor -repeat=1 -sandbox=setuid \
>>>     -enable=none -collide=false log1
>>>
>>> The other process with perf fuzzer:
>>>  https://github.com/deater/perf_event_tests/tree/master/fuzzer
>>>
>>>  $ perf_event_tests/fuzzer/perf_fuzzer
>>>
>>> I think this will happen on the kernel version.
>>>
>>>  Linux kernel version +v6.7.10, +v6.8, +v6.9 and it could happen in v6.10.
>>>
>>> This occurred from 51270d573a8d. I think this patch is absolutely
>>> necessary. Previously, It was showing not intended string value of name.
> 
> 
>> I found a simple reproducer, please use the below command to test this patch.
>>
>> echo 1 > /sys/kernel/debug/tracing/events/enable
>> ip link add veth0 type veth peer name veth1

After applying our patch, I didn't find any message or kernel panic errors.

 # echo 1 > /sys/kernel/debug/tracing/events/qdisc/qdisc_reset/enable
 # ip link add veth0 type veth peer name veth1
 Error: Unknown device type.

However, without our patch applied, I tested Tahee's command line on the
upstream 6.10.0-rc3 kernel using the qdisc_reset event and the ip command.

 $ echo 1 > /sys/kernel/debug/tracing/events/qdisc/qdisc_reset/enable

 $ ip link add veth0 type veth peer name veth1

This make always kernel panic.

Linux version: 6.10.0-rc3

[    0.000000] Linux version 6.10.0-rc3-00164-g44ef20baed8e-dirty
(paran@fedora) (gcc (GCC) 14.1.1 20240522 (Red Hat 14.1.1-4), GNU ld
version 2.41-34.fc40) #20 SMP PREEMPT Sat Jun 15 16:51:25 KST 2024

Kernel panic message:

[  615.236484] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
[  615.237250] Dumping ftrace buffer:
[  615.237679]    (ftrace buffer empty)
[  615.238097] Modules linked in: veth crct10dif_ce virtio_gpu
virtio_dma_buf drm_shmem_helper drm_kms_helper zynqmp_fpga xilinx_can
xilinx_spi xilinx_selectmap xilinx_core xilinx_pr_decoupler versal_fpga
uvcvideo uvc videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videodev
videobuf2_common mc usbnet deflate zstd ubifs ubi rcar_canfd rcar_can
omap_mailbox ntb_msi_test ntb_hw_epf lattice_sysconfig_spi
lattice_sysconfig ice40_spi gpio_xilinx dwmac_altr_socfpga mdio_regmap
stmmac_platform stmmac pcs_xpcs dfl_fme_region dfl_fme_mgr dfl_fme_br
dfl_afu dfl fpga_region fpga_bridge can can_dev br_netfilter bridge stp
llc atl1c ath11k_pci mhi ath11k_ahb ath11k qmi_helpers ath10k_sdio
ath10k_pci ath10k_core ath mac80211 libarc4 cfg80211 drm fuse backlight ipv6
Jun 22 02:36:5[3   6k152.62-4sm98k4-0k]v  kCePUr:n e1l :P IUDn:a b4le6
8t oC ohmma: nidpl eN oketr nteali nptaedg i6n.g1 0re.0q-urecs3t- 0at0
1v6i4r-tgu4a4le fa2d0dbraeeds0se-dir tyd f#f2f08
  615.252376] Hardware name: linux,dummy-virt (DT)
[  615.253220] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS
BTYPE=--)
[  615.254433] pc : strnlen+0x6c/0xe0
[  615.255096] lr : trace_event_get_offsets_qdisc_reset+0x94/0x3d0
[  615.256088] sp : ffff800080b269a0
[  615.256615] x29: ffff800080b269a0 x28: ffffc070f3f98500 x27:
0000000000000001
[  615.257831] x26: 0000000000000010 x25: ffffc070f3f98540 x24:
ffffc070f619cf60
[  615.259020] x23: 0000000000000128 x22: 0000000000000138 x21:
dfff800000000000
[  615.260241] x20: ffffc070f631ad00 x19: 0000000000000128 x18:
ffffc070f448b800
[  615.261454] x17: 0000000000000000 x16: 0000000000000001 x15:
ffffc070f4ba2a90
[  615.262635] x14: ffff700010164d73 x13: 1ffff80e1e8d5eb3 x12:
1ffff00010164d72
[  615.263877] x11: ffff700010164d72 x10: dfff800000000000 x9 :
ffffc070e85d6184
[  615.265047] x8 : ffffc070e4402070 x7 : 000000000000f1f1 x6 :
000000001504a6d3
[  615.266336] x5 : ffff28ca21122140 x4 : ffffc070f5043ea8 x3 :
0000000000000000
[  615.267528] x2 : 0000000000000025 x1 : 0000000000000000 x0 :
0000000000000000
[  615.268747] Call trace:
[  615.269180]  strnlen+0x6c/0xe0
[  615.269767]  trace_event_get_offsets_qdisc_reset+0x94/0x3d0
[  615.270716]  trace_event_raw_event_qdisc_reset+0xe8/0x4e8
[  615.271667]  __traceiter_qdisc_reset+0xa0/0x140
[  615.272499]  qdisc_reset+0x554/0x848
[  615.273134]  netif_set_real_num_tx_queues+0x360/0x9a8
[  615.274050]  veth_init_queues+0x110/0x220 [veth]
[  615.275110]  veth_newlink+0x538/0xa50 [veth]
[  615.276172]  __rtnl_newlink+0x11e4/0x1bc8
[  615.276944]  rtnl_newlink+0xac/0x120
[  615.277657]  rtnetlink_rcv_msg+0x4e4/0x1370
[  615.278409]  netlink_rcv_skb+0x25c/0x4f0
[  615.279122]  rtnetlink_rcv+0x48/0x70
[  615.279769]  netlink_unicast+0x5a8/0x7b8
[  615.280462]  netlink_sendmsg+0xa70/0x1190

> The perf event is activated by perf_fuzzer, and it's indeed a similar
> environment with veth.
> 
>> In my machine, the splat looks like:
>>
>> BUG: kernel NULL pointer dereference, address: 0000000000000130
>> #PF: supervisor read access in kernel mode

>> Thanks a lot!
>> Taehee Yoo
> 
> I think this bug might cause inconvenience for developers working on net
> devices driver in a virtual machine when they use tracing.
> 
> I'm appreciate your effort in reproducing it.
> 
> Warm Regards,
> Yunseong Kim
I believe our patch can prevent panics in all stable kernels released
after +v6.7.10.

Warm Regards,
Yunseong Kim

