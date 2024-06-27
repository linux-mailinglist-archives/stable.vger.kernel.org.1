Return-Path: <stable+bounces-55935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D56CA91A275
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 11:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6074B28161D
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 09:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1232713A3FF;
	Thu, 27 Jun 2024 09:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBqngvfW"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CBA13777E
	for <stable@vger.kernel.org>; Thu, 27 Jun 2024 09:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719479659; cv=none; b=XAy8DZiVqY7em9GeJdkMBpk8C5x3ewq4RrSCwWYnxbUppKUs/q0ya6tqpGAWneZcV1cnpRMZfy5cXdOpTPSeVNpu1tvEg1MIkbDgTMb9ORmWxl/DIhoZjD3T40iNRNDZL4bR1gMa96BVCcDd7jc0OvYT1gkjeh0cyXblVnDxulo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719479659; c=relaxed/simple;
	bh=SbQk6v3FbQ5X6J+oYrspQvypwvf4yxifB3spkUDfCWU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RMErn0qBVo/Igaxp0jB1+BfyGGeDeIV/5NPVlN7PqNeDwxHJi5p6Wt41VeLLRkg/OafanWpEYfdJsFv0IOut+GV2gbqveZZDLOqcCABwoAvjg4RnVfiR84Zk5F114cu/jEHsnOH4RsS6ib3CKyF0TL95am+GnBPdDi7ZHWnJhdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jBqngvfW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719479656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ahc+MvHKwIgh7hGvCPrGUTmuhzSz+11FXAdK7RAm97s=;
	b=jBqngvfW9lNnBE5FG7X7p4w+Uv4gW1HooOnJUE62XKGtlQINoMzRvJv6P+qvG99Q4hvjkn
	C3pPZogwpc1Fcs6QhCaxFWXSsqdxBuj6gX2aOU32aH6pXz0OE1ZTELqiaqK0HNEkpxoJ7x
	C9FqBu3GPPcwS9PoNU+izF/fLnk5cQ4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-zIBJgK0vO2mlwl-TsHtE4g-1; Thu, 27 Jun 2024 05:14:14 -0400
X-MC-Unique: zIBJgK0vO2mlwl-TsHtE4g-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ee49890422so1238071fa.3
        for <stable@vger.kernel.org>; Thu, 27 Jun 2024 02:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719479653; x=1720084453;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ahc+MvHKwIgh7hGvCPrGUTmuhzSz+11FXAdK7RAm97s=;
        b=GMs+9K06y65kfJOeYMlxcE+6aMxTxtnKAKuZkj5aO0qC6JhXzIILiTFoBKiXi616nQ
         VtAhc5oD5yFRpCiYftj4a/IRV89GL0gVt2D5vR+EUIP+8H2+xP7BuiA9YDKtCoFUjJjv
         U6zqbgj347YkvUfALndD3h7U2h5u11eMzjHotJt+Vu7mPQaMCPZMdIGX27CZ7pNFpsmI
         z9zMK+zR5LGCZRzGyTMiEkyp2BkA1WFHWT6JZ8KX8KQKWuCPahyMOvtNpvWlrRavk6Re
         NC+fuJZdDL5EFm712dS6IrldPri8O+QIm6eCW/X+PI+U4FmLEsPvAZHBAb3wQrv536SW
         O3Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXyXBknqNOXwY+Kdj5qf3sT6rs9x8Q6NMhyPvubyJnaIGAP+r6ME+Rg/GBmKvml6ba7u5GDXdR+NwAZxmcUT7M337jmPQA4
X-Gm-Message-State: AOJu0Yzt/Xh1uO2AWz8Flb/uOHUK7cesh7YmOe+KxSKd9ap9tJeayTY/
	xb8SYSD60RI9RkPUzaDhYl06dcsIneaiJ2XdMV2ktw//F8wl62GCvnivxG1qWd0DqkS+euA0E6N
	Tx5N7rog5nBFiT8fE8Q9VD4wvpwTVLxDWO4n/kq4sF3tV/IT77zOcGA==
X-Received: by 2002:a05:6512:b92:b0:52c:cd07:37b6 with SMTP id 2adb3069b0e04-52cdea7ef33mr8829410e87.1.1719479652592;
        Thu, 27 Jun 2024 02:14:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRdPrpO1PiEGx3aTlo2Pl4UiClo/O9Pz6B7Cn86NahIfi69oiGDU8nuvIaIOtEk5M2jq6y0A==
X-Received: by 2002:a05:6512:b92:b0:52c:cd07:37b6 with SMTP id 2adb3069b0e04-52cdea7ef33mr8829392e87.1.1719479652062;
        Thu, 27 Jun 2024 02:14:12 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:2716:2d10:663:1c83:b66f:72fc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367436a28f7sm1188095f8f.117.2024.06.27.02.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 02:14:10 -0700 (PDT)
Message-ID: <5ce3076ba0989a062f8e46e54a073b393ad22810.camel@redhat.com>
Subject: Re: [PATCH v4] tracing/net_sched: NULL pointer dereference in
 perf_trace_qdisc_reset()
From: Paolo Abeni <pabeni@redhat.com>
To: yskelg@gmail.com
Cc: Taehee Yoo <ap420073@gmail.com>, Pedro Tammela <pctammela@mojatatu.com>,
  Austin Kim <austindh.kim@gmail.com>, MichelleJin <shjy180909@gmail.com>,
 linux-kernel@vger.kernel.org,  linux-trace-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pbuk5246@gmail.com,  stable@vger.kernel.org,
 Yeoreum Yun <yeoreum.yun@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Takashi Iwai <tiwai@suse.de>, "David S.
 Miller" <davem@davemloft.net>, Thomas =?ISO-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>,  Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Date: Thu, 27 Jun 2024 11:14:07 +0200
In-Reply-To: <20240624173320.24945-4-yskelg@gmail.com>
References: <20240624173320.24945-4-yskelg@gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-25 at 02:33 +0900, yskelg@gmail.com wrote:
> From: Yunseong Kim <yskelg@gmail.com>
>=20
> In the TRACE_EVENT(qdisc_reset) NULL dereference occurred from
>=20
>  qdisc->dev_queue->dev <NULL> ->name
>=20
> This situation simulated from bunch of veths and Bluetooth disconnection
> and reconnection.
>=20
> During qdisc initialization, qdisc was being set to noop_queue.
> In veth_init_queue, the initial tx_num was reduced back to one,
> causing the qdisc reset to be called with noop, which led to the kernel
> panic.
>=20
> I've attached the GitHub gist link that C converted syz-execprogram
> source code and 3 log of reproduced vmcore-dmesg.
>=20
>  https://gist.github.com/yskelg/cc64562873ce249cdd0d5a358b77d740
>=20
> Yeoreum and I use two fuzzing tool simultaneously.
>=20
> One process with syz-executor : https://github.com/google/syzkaller
>=20
>  $ ./syz-execprog -executor=3D./syz-executor -repeat=3D1 -sandbox=3Dsetui=
d \
>     -enable=3Dnone -collide=3Dfalse log1
>=20
> The other process with perf fuzzer:
>  https://github.com/deater/perf_event_tests/tree/master/fuzzer
>=20
>  $ perf_event_tests/fuzzer/perf_fuzzer
>=20
> I think this will happen on the kernel version.
>=20
>  Linux kernel version +v6.7.10, +v6.8, +v6.9 and it could happen in v6.10=
.
>=20
> This occurred from 51270d573a8d. I think this patch is absolutely
> necessary. Previously, It was showing not intended string value of name.
>=20
> I've reproduced 3 time from my fedora 40 Debug Kernel with any other modu=
le
> or patched.
>=20
>  version: 6.10.0-0.rc2.20240608gitdc772f8237f9.29.fc41.aarch64+debug
>=20
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
>=20
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
>=20
> After applying our patch, I didn't find any kernel panic errors.
>=20
> We've found a simple reproducer
>=20
>  # echo 1 > /sys/kernel/debug/tracing/events/qdisc/qdisc_reset/enable
>=20
>  # ip link add veth0 type veth peer name veth1
>=20
>  Error: Unknown device type.
>=20
> However, without our patch applied, I tested upstream 6.10.0-rc3 kernel
> using the qdisc_reset event and the ip command on my qemu virtual machine=
.
>=20
> This 2 commands makes always kernel panic.
>=20
> Linux version: 6.10.0-rc3
>=20
> [    0.000000] Linux version 6.10.0-rc3-00164-g44ef20baed8e-dirty
> (paran@fedora) (gcc (GCC) 14.1.1 20240522 (Red Hat 14.1.1-4), GNU ld
> version 2.41-34.fc40) #20 SMP PREEMPT Sat Jun 15 16:51:25 KST 2024
>=20
> Kernel panic message:
>=20
> [  615.236484] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> [  615.237250] Dumping ftrace buffer:
> [  615.237679]    (ftrace buffer empty)
> [  615.238097] Modules linked in: veth crct10dif_ce virtio_gpu
> virtio_dma_buf drm_shmem_helper drm_kms_helper zynqmp_fpga xilinx_can
> xilinx_spi xilinx_selectmap xilinx_core xilinx_pr_decoupler versal_fpga
> uvcvideo uvc videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videodev
> videobuf2_common mc usbnet deflate zstd ubifs ubi rcar_canfd rcar_can
> omap_mailbox ntb_msi_test ntb_hw_epf lattice_sysconfig_spi
> lattice_sysconfig ice40_spi gpio_xilinx dwmac_altr_socfpga mdio_regmap
> stmmac_platform stmmac pcs_xpcs dfl_fme_region dfl_fme_mgr dfl_fme_br
> dfl_afu dfl fpga_region fpga_bridge can can_dev br_netfilter bridge stp
> llc atl1c ath11k_pci mhi ath11k_ahb ath11k qmi_helpers ath10k_sdio
> ath10k_pci ath10k_core ath mac80211 libarc4 cfg80211 drm fuse backlight i=
pv6
> Jun 22 02:36:5[3   6k152.62-4sm98k4-0k]v  kCePUr:n e1l :P IUDn:a b4le6
> 8t oC ohmma: nidpl eN oketr nteali nptaedg i6n.g1 0re.0q-urecs3t- 0at0
> 1v6i4r-tgu4a4le fa2d0dbraeeds0se-dir tyd f#f2f08
>   615.252376] Hardware name: linux,dummy-virt (DT)
> [  615.253220] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS
> BTYPE=3D--)
> [  615.254433] pc : strnlen+0x6c/0xe0
> [  615.255096] lr : trace_event_get_offsets_qdisc_reset+0x94/0x3d0
> [  615.256088] sp : ffff800080b269a0
> [  615.256615] x29: ffff800080b269a0 x28: ffffc070f3f98500 x27:
> 0000000000000001
> [  615.257831] x26: 0000000000000010 x25: ffffc070f3f98540 x24:
> ffffc070f619cf60
> [  615.259020] x23: 0000000000000128 x22: 0000000000000138 x21:
> dfff800000000000
> [  615.260241] x20: ffffc070f631ad00 x19: 0000000000000128 x18:
> ffffc070f448b800
> [  615.261454] x17: 0000000000000000 x16: 0000000000000001 x15:
> ffffc070f4ba2a90
> [  615.262635] x14: ffff700010164d73 x13: 1ffff80e1e8d5eb3 x12:
> 1ffff00010164d72
> [  615.263877] x11: ffff700010164d72 x10: dfff800000000000 x9 :
> ffffc070e85d6184
> [  615.265047] x8 : ffffc070e4402070 x7 : 000000000000f1f1 x6 :
> 000000001504a6d3
> [  615.266336] x5 : ffff28ca21122140 x4 : ffffc070f5043ea8 x3 :
> 0000000000000000
> [  615.267528] x2 : 0000000000000025 x1 : 0000000000000000 x0 :
> 0000000000000000
> [  615.268747] Call trace:
> [  615.269180]  strnlen+0x6c/0xe0
> [  615.269767]  trace_event_get_offsets_qdisc_reset+0x94/0x3d0
> [  615.270716]  trace_event_raw_event_qdisc_reset+0xe8/0x4e8
> [  615.271667]  __traceiter_qdisc_reset+0xa0/0x140
> [  615.272499]  qdisc_reset+0x554/0x848
> [  615.273134]  netif_set_real_num_tx_queues+0x360/0x9a8
> [  615.274050]  veth_init_queues+0x110/0x220 [veth]
> [  615.275110]  veth_newlink+0x538/0xa50 [veth]
> [  615.276172]  __rtnl_newlink+0x11e4/0x1bc8
> [  615.276944]  rtnl_newlink+0xac/0x120
> [  615.277657]  rtnetlink_rcv_msg+0x4e4/0x1370
> [  615.278409]  netlink_rcv_skb+0x25c/0x4f0
> [  615.279122]  rtnetlink_rcv+0x48/0x70
> [  615.279769]  netlink_unicast+0x5a8/0x7b8
> [  615.280462]  netlink_sendmsg+0xa70/0x1190
>=20
> Yeoreum and I don't know if the patch we wrote will fix the underlying
> cause, but we think that priority is to prevent kernel panic happening.
> So, we're sending this patch.
>=20
> Fixes: 51270d573a8d ("tracing/net_sched: Fix tracepoints that save qdisc_=
dev() as a string")
> Link: https://lore.kernel.org/lkml/20240229143432.273b4871@gandalf.local.=
home/t/
> Cc: netdev@vger.kernel.org
> Cc: stable@vger.kernel.org # +v6.7.10, +v6.8
> Tested-by: Yunseong Kim <yskelg@gmail.com>
> Signed-off-by: Yunseong Kim <yskelg@gmail.com>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>

I took the liberty of dropping the stable tag when applying, because as
noted from Petro this patch will not address the issue on v6.7.10 nor
on +v6.8, as they lack the upstream commit 2c92ca849fcc
("tracing/treewide: Remove second parameter of __assign_str()") and a
we need slightly different fix on such trees, including the
TP_fast_assign() chunk.

Could you please take care of such backport?

Thanks,

Paolo


