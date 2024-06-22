Return-Path: <stable+bounces-54857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8732D913225
	for <lists+stable@lfdr.de>; Sat, 22 Jun 2024 07:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9CC1285B28
	for <lists+stable@lfdr.de>; Sat, 22 Jun 2024 05:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCA614A4F7;
	Sat, 22 Jun 2024 05:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MY51C1cI"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F9D14A4E5;
	Sat, 22 Jun 2024 05:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719035474; cv=none; b=mq3kkk6CavRc2TGvredB8GA2xD1cjdJzgpj9WEzSsXcIH+5pTKHRGXfCXPT8vDKHCaeOwyNqEqBlIpInypK1QOqDvSEp+A4rmtvtuC7RgTTfq51jpT+bLt2bpUNe2EfdVhgJ5qG+dvMHldoNkKk6F+iRGoBYNAXEXqzOupDK8Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719035474; c=relaxed/simple;
	bh=txK0NIhXM7LSS54OD1GFWWmNySpMGkTs29hs+qjhb9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=geOQ8eMqP7ZoJTp5yKtffbuyIz2EfitMtULGhl02b7lfx8tURBvGpEZezdlMK6iH5LLzu5jDudvhAI/CavriwkMegwf1nHZLiaw6IUmADx1Er4U5WYifr2H+UMzSjy/96gIPs/vvKn0kqOGT4A56BvrcsQU5/tdUgJLSVMFfHPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MY51C1cI; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57d20d89748so2639886a12.0;
        Fri, 21 Jun 2024 22:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719035471; x=1719640271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryusqYSpSGW9sq7JLKzd6WpZJMJY1fxSatXDMr7PV9w=;
        b=MY51C1cIg7PKvopkm6tYNwE4w1zxsrHr4csnD2NBXpwB7mbuTQ0Zqb5nTgBtQQMmpC
         gvfi4BpFT9XMLitf/DR9mGBeWGCT1Y8RkWGBPK55vUhleksOfFyiEOSgIQv55zpT97wg
         5Sg81UvrHw6wALugMJlbRgh39h0I5oYNP06/NhU195IpbkOKtfPp69xSxl4S7F592i5f
         ly8rHXJy1Jfl+hrNuI/lCLJw17H/1h7P/UWumwvY4mYhg0dnOHwnQ4Pz9IEy5YhmqzaS
         ZfH9RGxptSq6CAim/RYMoiUyJue29t4g/RLRyK96c3Je6AxCxNCF3u2gl7yVkGEd+R0t
         lpvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719035471; x=1719640271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ryusqYSpSGW9sq7JLKzd6WpZJMJY1fxSatXDMr7PV9w=;
        b=Nfr2LDSsf0yNIKgPgbj1nkgbt0lmpAkEqLRI/+YAnwlF4H4I3gxdxmZmnEa8wtMKSt
         oPP/tNlYdDO4WVATDoFeyIvUc5ZClUhvzgY/WlTplRSt5n6zgRKNv4jhyJBLdhqekcF6
         sGnbuhGi0JBMhYkCoXbCLzH/vuMTieJKGF/D86itaCSNeWpvRkcfKeZjEztXQJ+VGZJf
         eGdz0wKm6p2Ze+zVUQzJ/OzHzRRIFjjGZV/FoeNQJzm6tdd29yEYmw7FARXqDSfatZSr
         veDIpHrAvgubjEA5vwhSelJW5XY8cFP2hnO/hhX+QkPEg9+ZRSfxzv6NvLA0wqyUxJR0
         cW5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPcRkos2/62knf030FMUv9hLYB+yPnFqvvE3o47Yj4UWlXQhT/AZRCWkAYV/cDeN8HGwnR/DaAVhNtaBxmEl+LeXrB+i6oazHNxBs207CENw31gQQ5XE0FyjNPZGakDHb78GHwoMzb/y+HL5P1LcgYJwTKHEoVsGnkYGHzY21+Bu9yatp6ha31Pl2f6p47xsxQ46H1MFaEyMUpqDfRrC78
X-Gm-Message-State: AOJu0YycQSn4eo54nyiAFtuRIxqORosGP4K3wO8/O8qiwX88HZ8IoJAK
	8NF2CBrKo8O78clWDjXuHgsopEBokpelItLrZMTrHOAlAta6BSzgUv+PgVWRaQd6slWwrPNmxuE
	EMlPFFvYNu91BdIlHfIGVi1ODiA4=
X-Google-Smtp-Source: AGHT+IFGYqz2bTKT0vnG2woMVKXBSRWp/C8lrmVOu6xXsivjQVnIxLuprTOjKWPJZk+wubcQWSMAgd88fLL13Q6/E5g=
X-Received: by 2002:a50:9b54:0:b0:57d:692:33ee with SMTP id
 4fb4d7f45d1cf-57d07edd67emr5540548a12.36.1719035470761; Fri, 21 Jun 2024
 22:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240622045701.8152-2-yskelg@gmail.com>
In-Reply-To: <20240622045701.8152-2-yskelg@gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Sat, 22 Jun 2024 14:50:59 +0900
Message-ID: <CAMArcTVgpAq8dC_u8eFE=asMWriWjNfYsmo6KVFi=tpHebdmCA@mail.gmail.com>
Subject: Re: [PATCH v3] tracing/net_sched: NULL pointer dereference in perf_trace_qdisc_reset()
To: yskelg@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>, Pedro Tammela <pctammela@mojatatu.com>, netdev@vger.kernel.org, 
	stable@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Takashi Iwai <tiwai@suse.de>, "David S. Miller" <davem@davemloft.net>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Austin Kim <austindh.kim@gmail.com>, shjy180909@gmail.com, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, ppbuk5246@gmail.com, 
	Yeoreum Yun <yeoreum.yun@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 22, 2024 at 1:58=E2=80=AFPM <yskelg@gmail.com> wrote:
>
> From: Yunseong Kim <yskelg@gmail.com>
>

Hi Yunseong,
Thanks a lot for this work!

> In the TRACE_EVENT(qdisc_reset) NULL dereference occurred from
>
>  qdisc->dev_queue->dev <NULL> ->name
>
> This situation simulated from bunch of veths and Bluetooth dis/reconnecti=
on.
>
> During qdisc initialization, qdisc was being set to noop_queue.
> In veth_init_queue, the initial tx_num was reduced back to one,
> causing the qdisc reset to be called with noop, which led to the kernel p=
anic.
>
> I've attached the GitHub gist link that C converted syz-execprogram
> source code and 3 log of reproduced vmcore-dmesg.
>
>  https://gist.github.com/yskelg/cc64562873ce249cdd0d5a358b77d740
>
> Yeoreum and I use two fuzzing tool simultaneously.
>
> One process with syz-executor : https://github.com/google/syzkaller
>
>  $ ./syz-execprog -executor=3D./syz-executor -repeat=3D1 -sandbox=3Dsetui=
d \
>     -enable=3Dnone -collide=3Dfalse log1
>
> The other process with perf fuzzer:
>  https://github.com/deater/perf_event_tests/tree/master/fuzzer
>
>  $ perf_event_tests/fuzzer/perf_fuzzer
>
> I think this will happen on the kernel version.
>
>  Linux kernel version +v6.7.10, +v6.8, +v6.9 and it could happen in v6.10=
.
>
> This occurred from 51270d573a8d. I think this patch is absolutely
> necessary. Previously, It was showing not intended string value of name.
>
> I've reproduced 3 time from my fedora 40 Debug Kernel with any other modu=
le
> or patched.
>
>  version: 6.10.0-0.rc2.20240608gitdc772f8237f9.29.fc41.aarch64+debug
>
> [ 5287.164555] veth0_vlan: left promiscuous mode
> [ 5287.164929] veth1_macvtap: left promiscuous mode
> [ 5287.164950] veth0_macvtap: left promiscuous mode
> [ 5287.164983] veth1_vlan: left promiscuous mode
> [ 5287.165008] veth0_vlan: left promiscuous mode
> [ 5287.165450] veth1_macvtap: left promiscuous mode
> [ 5287.165472] veth0_macvtap: left promiscuous mode
> [ 5287.165502] veth1_vlan: left promiscuous mode
> =E2=80=A6
> [ 5297.598240] bridge0: port 2(bridge_slave_1) entered blocking state
> [ 5297.598262] bridge0: port 2(bridge_slave_1) entered forwarding state
> [ 5297.598296] bridge0: port 1(bridge_slave_0) entered blocking state
> [ 5297.598313] bridge0: port 1(bridge_slave_0) entered forwarding state
> [ 5297.616090] 8021q: adding VLAN 0 to HW filter on device bond0
> [ 5297.620405] bridge0: port 1(bridge_slave_0) entered disabled state
> [ 5297.620730] bridge0: port 2(bridge_slave_1) entered disabled state
> [ 5297.627247] 8021q: adding VLAN 0 to HW filter on device team0
> [ 5297.629636] bridge0: port 1(bridge_slave_0) entered blocking state
> =E2=80=A6
> [ 5298.002798] bridge_slave_0: left promiscuous mode
> [ 5298.002869] bridge0: port 1(bridge_slave_0) entered disabled state
> [ 5298.309444] bond0 (unregistering): (slave bond_slave_0): Releasing bac=
kup interface
> [ 5298.315206] bond0 (unregistering): (slave bond_slave_1): Releasing bac=
kup interface
> [ 5298.320207] bond0 (unregistering): Released all slaves
> [ 5298.354296] hsr_slave_0: left promiscuous mode
> [ 5298.360750] hsr_slave_1: left promiscuous mode
> [ 5298.374889] veth1_macvtap: left promiscuous mode
> [ 5298.374931] veth0_macvtap: left promiscuous mode
> [ 5298.374988] veth1_vlan: left promiscuous mode
> [ 5298.375024] veth0_vlan: left promiscuous mode
> [ 5299.109741] team0 (unregistering): Port device team_slave_1 removed
> [ 5299.185870] team0 (unregistering): Port device team_slave_0 removed
> =E2=80=A6
> [ 5300.155443] Bluetooth: hci3: unexpected cc 0x0c03 length: 249 > 1
> [ 5300.155724] Bluetooth: hci3: unexpected cc 0x1003 length: 249 > 9
> [ 5300.155988] Bluetooth: hci3: unexpected cc 0x1001 length: 249 > 9
> =E2=80=A6.
> [ 5301.075531] team0: Port device team_slave_1 added
> [ 5301.085515] bridge0: port 1(bridge_slave_0) entered blocking state
> [ 5301.085531] bridge0: port 1(bridge_slave_0) entered disabled state
> [ 5301.085588] bridge_slave_0: entered allmulticast mode
> [ 5301.085800] bridge_slave_0: entered promiscuous mode
> [ 5301.095617] bridge0: port 1(bridge_slave_0) entered blocking state
> [ 5301.095633] bridge0: port 1(bridge_slave_0) entered disabled state
> =E2=80=A6
> [ 5301.149734] bond0: (slave bond_slave_0): Enslaving as an active interf=
ace with an up link
> [ 5301.173234] bond0: (slave bond_slave_0): Enslaving as an active interf=
ace with an up link
> [ 5301.180517] bond0: (slave bond_slave_1): Enslaving as an active interf=
ace with an up link
> [ 5301.193481] hsr_slave_0: entered promiscuous mode
> [ 5301.204425] hsr_slave_1: entered promiscuous mode
> [ 5301.210172] debugfs: Directory 'hsr0' with parent 'hsr' already presen=
t!
> [ 5301.210185] Cannot create hsr debugfs directory
> [ 5301.224061] bond0: (slave bond_slave_1): Enslaving as an active interf=
ace with an up link
> [ 5301.246901] bond0: (slave bond_slave_0): Enslaving as an active interf=
ace with an up link
> [ 5301.255934] team0: Port device team_slave_0 added
> [ 5301.256480] team0: Port device team_slave_1 added
> [ 5301.256948] team0: Port device team_slave_0 added
> =E2=80=A6
> [ 5301.435928] hsr_slave_0: entered promiscuous mode
> [ 5301.446029] hsr_slave_1: entered promiscuous mode
> [ 5301.455872] debugfs: Directory 'hsr0' with parent 'hsr' already presen=
t!
> [ 5301.455884] Cannot create hsr debugfs directory
> [ 5301.502664] hsr_slave_0: entered promiscuous mode
> [ 5301.513675] hsr_slave_1: entered promiscuous mode
> [ 5301.526155] debugfs: Directory 'hsr0' with parent 'hsr' already presen=
t!
> [ 5301.526164] Cannot create hsr debugfs directory
> [ 5301.563662] hsr_slave_0: entered promiscuous mode
> [ 5301.576129] hsr_slave_1: entered promiscuous mode
> [ 5301.580259] debugfs: Directory 'hsr0' with parent 'hsr' already presen=
t!
> [ 5301.580270] Cannot create hsr debugfs directory
> [ 5301.590269] 8021q: adding VLAN 0 to HW filter on device bond0
>
> [ 5301.595872] KASAN: null-ptr-deref in range [0x0000000000000130-0x00000=
00000000137]
> [ 5301.595877] Mem abort info:
> [ 5301.595881]   ESR =3D 0x0000000096000006
> [ 5301.595885]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [ 5301.595889]   SET =3D 0, FnV =3D 0
> [ 5301.595893]   EA =3D 0, S1PTW =3D 0
> [ 5301.595896]   FSC =3D 0x06: level 2 translation fault
> [ 5301.595900] Data abort info:
> [ 5301.595903]   ISV =3D 0, ISS =3D 0x00000006, ISS2 =3D 0x00000000
> [ 5301.595907]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> [ 5301.595911]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> [ 5301.595915] [dfff800000000026] address between user and kernel address=
 ranges
> [ 5301.595971] Internal error: Oops: 0000000096000006 [#1] SMP
> =E2=80=A6
> [ 5301.596076] CPU: 2 PID: 102769 Comm:
> syz-executor.3 Kdump: loaded Tainted:
>  G        W         -------  ---  6.10.0-0.rc2.20240608gitdc772f8237f9.29=
.fc41.aarch64+debug #1
> [ 5301.596080] Hardware name: VMware, Inc. VMware20,1/VBSA,
>  BIOS VMW201.00V.21805430.BA64.2305221830 05/22/2023
> [ 5301.596082] pstate: 01400005 (nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYP=
E=3D--)
> [ 5301.596085] pc : strnlen+0x40/0x88
> [ 5301.596114] lr : trace_event_get_offsets_qdisc_reset+0x6c/0x2b0
> [ 5301.596124] sp : ffff8000beef6b40
> [ 5301.596126] x29: ffff8000beef6b40 x28: dfff800000000000 x27: 000000000=
0000001
> [ 5301.596131] x26: 6de1800082c62bd0 x25: 1ffff000110aa9e0 x24: ffff80008=
8554f00
> [ 5301.596136] x23: ffff800088554ec0 x22: 0000000000000130 x21: 000000000=
0000140
> [ 5301.596140] x20: dfff800000000000 x19: ffff8000beef6c60 x18: ffff70001=
15106d8
> [ 5301.596143] x17: ffff800121bad000 x16: ffff800080020000 x15: 000000000=
0000006
> [ 5301.596147] x14: 0000000000000002 x13: ffff0001f3ed8d14 x12: ffff70001=
7ddeda5
> [ 5301.596151] x11: 1ffff00017ddeda4 x10: ffff700017ddeda4 x9 : ffff80008=
2cc5eec
> [ 5301.596155] x8 : 0000000000000004 x7 : 00000000f1f1f1f1 x6 : 00000000f=
2f2f200
> [ 5301.596158] x5 : 00000000f3f3f3f3 x4 : ffff700017dded80 x3 : 00000000f=
204f1f1
> [ 5301.596162] x2 : 0000000000000026 x1 : 0000000000000000 x0 : 000000000=
0000130
> [ 5301.596166] Call trace:
> [ 5301.596175]  strnlen+0x40/0x88
> [ 5301.596179]  trace_event_get_offsets_qdisc_reset+0x6c/0x2b0
> [ 5301.596182]  perf_trace_qdisc_reset+0xb0/0x538
> [ 5301.596184]  __traceiter_qdisc_reset+0x68/0xc0
> [ 5301.596188]  qdisc_reset+0x43c/0x5e8
> [ 5301.596190]  netif_set_real_num_tx_queues+0x288/0x770
> [ 5301.596194]  veth_init_queues+0xfc/0x130 [veth]
> [ 5301.596198]  veth_newlink+0x45c/0x850 [veth]
> [ 5301.596202]  rtnl_newlink_create+0x2c8/0x798
> [ 5301.596205]  __rtnl_newlink+0x92c/0xb60
> [ 5301.596208]  rtnl_newlink+0xd8/0x130
> [ 5301.596211]  rtnetlink_rcv_msg+0x2e0/0x890
> [ 5301.596214]  netlink_rcv_skb+0x1c4/0x380
> [ 5301.596225]  rtnetlink_rcv+0x20/0x38
> [ 5301.596227]  netlink_unicast+0x3c8/0x640
> [ 5301.596231]  netlink_sendmsg+0x658/0xa60
> [ 5301.596234]  __sock_sendmsg+0xd0/0x180
> [ 5301.596243]  __sys_sendto+0x1c0/0x280
> [ 5301.596246]  __arm64_sys_sendto+0xc8/0x150
> [ 5301.596249]  invoke_syscall+0xdc/0x268
> [ 5301.596256]  el0_svc_common.constprop.0+0x16c/0x240
> [ 5301.596259]  do_el0_svc+0x48/0x68
> [ 5301.596261]  el0_svc+0x50/0x188
> [ 5301.596265]  el0t_64_sync_handler+0x120/0x130
> [ 5301.596268]  el0t_64_sync+0x194/0x198
> [ 5301.596272] Code: eb15001f 54000120 d343fc02 12000801 (38f46842)
> [ 5301.596285] SMP: stopping secondary CPUs
> [ 5301.597053] Starting crashdump kernel...
> [ 5301.597057] Bye!
>
> Yeoreum and I don't know if the patch we wrote will fix the underlying ca=
use,
> but we think that priority is to prevent kernel panic happening.
> So, we're sending this patch.
>
> Link: https://lore.kernel.org/lkml/20240229143432.273b4871@gandalf.local.=
home/t/
> Fixes: 51270d573a8d ("tracing/net_sched: Fix tracepoints that save qdisc_=
dev() as a string")
> Cc: netdev@vger.kernel.org
> Cc: stable@vger.kernel.org # +v6.7.10, +v6.8
> Signed-off-by: Yunseong Kim <yskelg@gmail.com>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  include/trace/events/qdisc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/trace/events/qdisc.h b/include/trace/events/qdisc.h
> index f1b5e816e7e5..170b51fbe47a 100644
> --- a/include/trace/events/qdisc.h
> +++ b/include/trace/events/qdisc.h
> @@ -81,7 +81,7 @@ TRACE_EVENT(qdisc_reset,
>         TP_ARGS(q),
>
>         TP_STRUCT__entry(
> -               __string(       dev,            qdisc_dev(q)->name      )
> +               __string(dev, qdisc_dev(q) ? qdisc_dev(q)->name : "noop_q=
ueue")
>                 __string(       kind,           q->ops->id              )
>                 __field(        u32,            parent                  )
>                 __field(        u32,            handle                  )
> --
> 2.45.2
>

I found a simple reproducer, please use the below command to test this patc=
h.

echo 1 > /sys/kernel/debug/tracing/events/enable
ip link add veth0 type veth peer name veth1

In my machine, the splat looks like:

BUG: kernel NULL pointer dereference, address: 0000000000000130
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 1 PID: 1207 Comm: ip Not tainted 6.10.0-rc4+ #25
362ec22a686962a9936425abea9a73f03b445c0c
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/20=
21
RIP: 0010:strlen+0x0/0x20
Code: f7 75 ec 31 c0 c3 cc cc cc cc 48 89 f8 c3 cc cc cc cc 0f 1f 84
00 00 00 00 00 90 90 90 90 9c
RSP: 0018:ffffbed8435c7630 EFLAGS: 00010206
RAX: ffffffff92d629c0 RBX: ffffa14100185c60 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff92d62840 RDI: 0000000000000130
RBP: ffffffff92dc4600 R08: 0000000000000fd0 R09: 0000000000000010
R10: ffffffff92c66c98 R11: 0000000000000001 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000130 R15: ffffffff92d62840
FS: 00007f6a94e50b80(0000) GS:ffffa1485f680000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000130 CR3: 0000000103414000 CR4: 00000000007506f0
PKRU: 55555554
Call Trace:
<TASK>
? __die+0x20/0x70
? page_fault_oops+0x15a/0x460
? trace_event_raw_event_x86_exceptions+0x5f/0xa0
? exc_page_fault+0x6e/0x180
? asm_exc_page_fault+0x22/0x30
? __pfx_strlen+0x10/0x10
trace_event_raw_event_qdisc_reset+0x4d/0x180
? synchronize_rcu_expedited+0x215/0x240
? __pfx_autoremove_wake_function+0x10/0x10
qdisc_reset+0x130/0x150
netif_set_real_num_tx_queues+0xe3/0x1e0
veth_init_queues+0x44/0x70 [veth 24a9dd1cd1b1b279e1b467ad46d47a753799b428]
veth_newlink+0x22b/0x440 [veth 24a9dd1cd1b1b279e1b467ad46d47a753799b428]
__rtnl_newlink+0x718/0x990
rtnl_newlink+0x44/0x70
rtnetlink_rcv_msg+0x159/0x410
? kmalloc_reserve+0x90/0xf0
? trace_event_raw_event_kmem_cache_alloc+0x87/0xe0
? __pfx_rtnetlink_rcv_msg+0x10/0x10
netlink_rcv_skb+0x54/0x100
netlink_unicast+0x243/0x370
netlink_sendmsg+0x1bb/0x3e0
____sys_sendmsg+0x2bb/0x320
? copy_msghdr_from_user+0x6d/0xa0
___sys_sendmsg+0x88/0xd0

Thanks a lot!
Taehee Yoo

