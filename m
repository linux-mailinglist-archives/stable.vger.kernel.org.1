Return-Path: <stable+bounces-245285-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xNqqMt8FAmpZnQEAu9opvQ
	(envelope-from <stable+bounces-245285-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 18:37:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FD4512553
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 18:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 46FDA30FD94B
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909383FE359;
	Mon, 11 May 2026 16:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUUClHkX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E2B43C046
	for <stable@vger.kernel.org>; Mon, 11 May 2026 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516684; cv=none; b=hQNdjHgEGmVVPGUB/GT4hiQdmZWzYE2sn8JB4EmcUmWlxRLv/eUHAsFyo+zcpkDyaPNJyQCDETMK1WNKq2ZP9mgzaD2/a+plCHruJhYzTYzR3hrLl8zSwX0QOQDihoCwV6x3+bclWW9GVtTbDev34e0mHpFvpZXyASpf85gELRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516684; c=relaxed/simple;
	bh=O3cbV/iUFmylglpcxzYkWYBDaTdNysxK0JHVVNoNK74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1J/FFGGAA4aiG1jwSO4gO6Itcn0cDCMeum6cHdtwfwWxqD7WZ3E45OH3Gh2LP8PIVAICeGqjz9aE78QIpZ1pF6QgnPBY3FAHbiliRAGnI1tUQG1hWQT4N7r27uRpdZMdDP8YY67sgUY+/p3e1zBQDtUNJetxYivRbNhGfWp46Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUUClHkX; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so32362825e9.0
        for <stable@vger.kernel.org>; Mon, 11 May 2026 09:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778516680; x=1779121480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oUER1d89SV2xLWwJRwfCmOhRWvRppwL2AvioVHdgHTI=;
        b=PUUClHkXfc0XHpbaYknGszLFPYKLq7NzpaXHPCMY0Cy0uQigoGJLAYvoBTxe/mmfT0
         8evJEs5CllROxM/KwdjWxnisqclW1/7BTsao4hLHG2E2W0V65+X7M6OnIXkTAsUzjhG6
         XwT0lGjHTxo7D+5M2o/l/nfZHmjsEiYbKx7RpsCN2kp5EeRFhVJwWGGK1zbTsTbfFFvb
         72tC+a5wYp8e9p/Yv0/jwtNME8BPLDpaeJ89TS7PqRv5G7liqWKzbefLs4AWnPEDrws3
         hMKHD96ExwnrO6vNfaQpEpKbESxnJMpuypvzCmmEZcxMsdBRwaMju+tjJX0Ca7ZyNipz
         a6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778516680; x=1779121480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUER1d89SV2xLWwJRwfCmOhRWvRppwL2AvioVHdgHTI=;
        b=jC3AkOUZeh1z3xKhcCcGRnqZbqPlaH2+iaguG+R3yhYWSqNslpbIQ+chS9zPhEcs3b
         VobcIIavj7H+3vOY+vLFhKyQ96P0wE2BhxwUQMfhsGVM6Tm7m7ty6S9pYePoj37K2Ero
         OUu71W4isNnbYlx9Eq7wJ8XvDwmEqIbltVsK1Dn4YoPpi6ma39KgWpLPaiJg97UyjlY7
         RlaGAh9YsjJxD2GKqfMFplRjfpeVwFD+x7jKRaX2dNY7ovDArRNhyYLbgpZxUxkvm9sG
         IGSRrA+b/Da4TShaafW8ecdFIE4nomZjW7a0DIsQSI/jHCFsenq7tL5DoX/IpWLAtpr8
         qwvg==
X-Gm-Message-State: AOJu0YwZmc90338Iz/jCFt2M6T3ZM4zwVAK7lUOZMO3Qx208NFS8kF/H
	+zcFyBB9Hgs+C1vu7OhDaIXrYTubNe7tXl6DGwQSdHYXW/ZQQHv5Snim1zi43UBp
X-Gm-Gg: Acq92OE48zNPf9a8tH67kIAxvet+fAQIe2TgCZL6WB4nqSdKqILR4B3KOWXmFXMgBhj
	zhjzeF7NZVoVlRnvuAvXA9XOU5ooxfFqAjbIb0KWfCLEG/Jasz9g9MfgyJ8sc2Xj6Mj7fkEq7w8
	94geHM/n4udRW8cVBXmFZcTBbiIPtIS6/4fLi+rg9dgnDccWpxNntBpbjD0VwKKovRxSCGOu6WU
	OzQnrGpVHuCyazE55QIu9cDPyq0TYrRFW7kFEXXmvB9kEBs0lZZ/ChbgcLzc+gzTOpDE2a03mF5
	TzSyL1rbC21yh0ja+HErRpJUzGd5SQY7T7POOCRDaA9XeDs8J9BakO4UMLW+3eNdlOnJutrD5A7
	ONs4l6N/2gneD0HDxuczpBShPf8be4J1sZcxnJGC69IC0OnKWU0/lUHS9mJnhGukve3snuKgm5K
	JXhOscY4B2AQLcIKH+Mj8paHL7ZHA6uywmLy00Pvb+NyTRAY8NCjjc6M1JVo8vlpRgraqMl/nw3
	tyssKBTNQx6kV33Fvy2mOsPioxxfCo4wJVvFYLGOF9xjKPhEBatwFQFW8hVAwFlnUWjP+R69OLF
	jgsAPdAWhGUSJ664z4ST2n93nNTCFqi12IkF670OnOY=
X-Received: by 2002:a05:600c:b99:b0:489:1d7a:4537 with SMTP id 5b1f17b1804b1-48e8e1e6dc1mr3505935e9.3.1778516680288;
        Mon, 11 May 2026 09:24:40 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00f76596008310132d.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:f765:9600:8310:132d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e70410310sm206991965e9.12.2026.05.11.09.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:24:39 -0700 (PDT)
Date: Mon, 11 May 2026 18:24:37 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Tao Lyu <tao.lyu@epfl.ch>,
	Levi Zim <rsworktech@outlook.com>
Subject: [PATCH 6.6.y 07/10] bpf: track aligned STACK_ZERO cases as imprecise
 spilled registers
Message-ID: <03c5df85105cf450e5b526d0e5a924b59b085788.1778516196.git.paul.chaignon@gmail.com>
References: <cover.1778516196.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1778516196.git.paul.chaignon@gmail.com>
X-Rspamd-Queue-Id: C4FD4512553
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,suse.com,iogearbox.net,kernel.org,gmail.com,epfl.ch,outlook.com];
	TAGGED_FROM(0.00)[bounces-245285-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iogearbox.net:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Action: no action

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 18a433b62061e3d787bfc3e670fa711fecbd7cb4 ]

Now that precision backtracing is supporting register spill/fill to/from
stack, there is another oportunity to be exploited here: minimizing
precise STACK_ZERO cases. With a simple code change we can rely on
initially imprecise register spill tracking for cases when register
spilled to stack was a known zero.

This is a very common case for initializing on the stack variables,
including rather large structures. Often times zero has no special
meaning for the subsequent BPF program logic and is often overwritten
with non-zero values soon afterwards. But due to STACK_ZERO vs
STACK_MISC tracking, such initial zero initialization actually causes
duplication of verifier states as STACK_ZERO is clearly different than
STACK_MISC or spilled SCALAR_VALUE register.

The effect of this (now) trivial change is huge, as can be seen below.
These are differences between BPF selftests, Cilium, and Meta-internal
BPF object files relative to previous patch in this series. You can see
improvements ranging from single-digit percentage improvement for
instructions and states, all the way to 50-60% reduction for some of
Meta-internal host agent programs, and even some Cilium programs.

For Meta-internal ones I left only the differences for largest BPF
object files by states/instructions, as there were too many differences
in the overall output. All the differences were improvements, reducting
number of states and thus instructions validated.

Note, Meta-internal BPF object file names are not printed below.
Many copies of balancer_ingress are actually many different
configurations of Katran, so they are different BPF programs, which
explains state reduction going from -16% all the way to 31%, depending
on BPF program logic complexity.

I also tooked a closer look at a few small-ish BPF programs to validate
the behavior. Let's take bpf_iter_netrlink.bpf.o (first row below).
While it's just 8 vs 5 states, verifier log is still pretty long to
include it here. But the reduction in states is due to the following
piece of C code:

        unsigned long ino;

	...

        sk = s->sk_socket;
        if (!sk) {
                ino = 0;
        } else {
                inode = SOCK_INODE(sk);
                bpf_probe_read_kernel(&ino, sizeof(ino), &inode->i_ino);
        }
        BPF_SEQ_PRINTF(seq, "%-8u %-8lu\n", s->sk_drops.counter, ino);
	return 0;

You can see that in some situations `ino` is zero-initialized, while in
others it's unknown value filled out by bpf_probe_read_kernel(). Before
this change code after if/else branches have to be validated twice. Once
with (precise) ino == 0, due to eager STACK_ZERO logic, and then again
for when ino is just STACK_MISC. But BPF_SEQ_PRINTF() doesn't care about
precise value of ino, so with the change in this patch verifier is able
to prune states from after one of the branches, reducing number of total
states (and instructions) required for successful validation.

Similar principle applies to bigger real-world applications, just at
a much larger scale.

SELFTESTS
=========
File                                     Program                  Insns (A)  Insns (B)  Insns    (DIFF)  States (A)  States (B)  States (DIFF)
---------------------------------------  -----------------------  ---------  ---------  ---------------  ----------  ----------  -------------
bpf_iter_netlink.bpf.linked3.o           dump_netlink                   148        104    -44 (-29.73%)           8           5   -3 (-37.50%)
bpf_iter_unix.bpf.linked3.o              dump_unix                     8474       8404     -70 (-0.83%)         151         147    -4 (-2.65%)
bpf_loop.bpf.linked3.o                   stack_check                    560        324   -236 (-42.14%)          42          24  -18 (-42.86%)
local_storage_bench.bpf.linked3.o        get_local                      120         77    -43 (-35.83%)           9           6   -3 (-33.33%)
loop6.bpf.linked3.o                      trace_virtqueue_add_sgs      10167       9868    -299 (-2.94%)         226         206   -20 (-8.85%)
pyperf600_bpf_loop.bpf.linked3.o         on_event                      4872       3423  -1449 (-29.74%)         322         229  -93 (-28.88%)
strobemeta.bpf.linked3.o                 on_event                    180697     176036   -4661 (-2.58%)        4780        4734   -46 (-0.96%)
test_cls_redirect.bpf.linked3.o          cls_redirect                 65594      65401    -193 (-0.29%)        4230        4212   -18 (-0.43%)
test_global_func_args.bpf.linked3.o      test_cls                       145        136      -9 (-6.21%)          10           9   -1 (-10.00%)
test_l4lb.bpf.linked3.o                  balancer_ingress              4760       2612  -2148 (-45.13%)         113         102   -11 (-9.73%)
test_l4lb_noinline.bpf.linked3.o         balancer_ingress              4845       4877     +32 (+0.66%)         219         221    +2 (+0.91%)
test_l4lb_noinline_dynptr.bpf.linked3.o  balancer_ingress              2072       2087     +15 (+0.72%)          97          98    +1 (+1.03%)
test_seg6_loop.bpf.linked3.o             __add_egr_x                  12440       9975  -2465 (-19.82%)         364         353   -11 (-3.02%)
test_tcp_hdr_options.bpf.linked3.o       estab                         2558       2572     +14 (+0.55%)         179         180    +1 (+0.56%)
test_xdp_dynptr.bpf.linked3.o            _xdp_tx_iptunnel               645        596     -49 (-7.60%)          26          24    -2 (-7.69%)
test_xdp_noinline.bpf.linked3.o          balancer_ingress_v6           3520       3516      -4 (-0.11%)         216         216    +0 (+0.00%)
xdp_synproxy_kern.bpf.linked3.o          syncookie_tc                 82661      81241   -1420 (-1.72%)        5073        5155   +82 (+1.62%)
xdp_synproxy_kern.bpf.linked3.o          syncookie_xdp                84964      82297   -2667 (-3.14%)        5130        5157   +27 (+0.53%)

META-INTERNAL
=============
Program                                 Insns (A)  Insns (B)  Insns      (DIFF)  States (A)  States (B)  States   (DIFF)
--------------------------------------  ---------  ---------  -----------------  ----------  ----------  ---------------
balancer_ingress                            27925      23608    -4317 (-15.46%)        1488        1482      -6 (-0.40%)
balancer_ingress                            31824      27546    -4278 (-13.44%)        1658        1652      -6 (-0.36%)
balancer_ingress                            32213      27935    -4278 (-13.28%)        1689        1683      -6 (-0.36%)
balancer_ingress                            32213      27935    -4278 (-13.28%)        1689        1683      -6 (-0.36%)
balancer_ingress                            31824      27546    -4278 (-13.44%)        1658        1652      -6 (-0.36%)
balancer_ingress                            38647      29562    -9085 (-23.51%)        2069        1835   -234 (-11.31%)
balancer_ingress                            38647      29562    -9085 (-23.51%)        2069        1835   -234 (-11.31%)
balancer_ingress                            40339      30792    -9547 (-23.67%)        2193        1934   -259 (-11.81%)
balancer_ingress                            37321      29055    -8266 (-22.15%)        1972        1795    -177 (-8.98%)
balancer_ingress                            38176      29753    -8423 (-22.06%)        2008        1831    -177 (-8.81%)
balancer_ingress                            29193      20910    -8283 (-28.37%)        1599        1422   -177 (-11.07%)
balancer_ingress                            30013      21452    -8561 (-28.52%)        1645        1447   -198 (-12.04%)
balancer_ingress                            28691      24290    -4401 (-15.34%)        1545        1531     -14 (-0.91%)
balancer_ingress                            34223      28965    -5258 (-15.36%)        1984        1875    -109 (-5.49%)
balancer_ingress                            35481      26158    -9323 (-26.28%)        2095        1806   -289 (-13.79%)
balancer_ingress                            35481      26158    -9323 (-26.28%)        2095        1806   -289 (-13.79%)
balancer_ingress                            35868      26455    -9413 (-26.24%)        2140        1827   -313 (-14.63%)
balancer_ingress                            35868      26455    -9413 (-26.24%)        2140        1827   -313 (-14.63%)
balancer_ingress                            35481      26158    -9323 (-26.28%)        2095        1806   -289 (-13.79%)
balancer_ingress                            35481      26158    -9323 (-26.28%)        2095        1806   -289 (-13.79%)
balancer_ingress                            34844      29485    -5359 (-15.38%)        2036        1918    -118 (-5.80%)
fbflow_egress                                3256       2652     -604 (-18.55%)         218         192    -26 (-11.93%)
fbflow_ingress                               1026        944       -82 (-7.99%)          70          63     -7 (-10.00%)
sslwall_tc_egress                            8424       7360    -1064 (-12.63%)         498         458     -40 (-8.03%)
syar_accept_protect                         15040       9539    -5501 (-36.58%)         364         220   -144 (-39.56%)
syar_connect_tcp_v6                         15036       9535    -5501 (-36.59%)         360         216   -144 (-40.00%)
syar_connect_udp_v4                         15039       9538    -5501 (-36.58%)         361         217   -144 (-39.89%)
syar_connect_connect4_protect4              24805      15833    -8972 (-36.17%)         756         480   -276 (-36.51%)
syar_lsm_file_open                         167772     151813    -15959 (-9.51%)        1836        1667    -169 (-9.20%)
syar_namespace_create_new                   14805       9304    -5501 (-37.16%)         353         209   -144 (-40.79%)
syar_python3_detect                         17531      12030    -5501 (-31.38%)         391         247   -144 (-36.83%)
syar_ssh_post_fork                          16412      10911    -5501 (-33.52%)         405         261   -144 (-35.56%)
syar_enter_execve                           14728       9227    -5501 (-37.35%)         345         201   -144 (-41.74%)
syar_enter_execveat                         14728       9227    -5501 (-37.35%)         345         201   -144 (-41.74%)
syar_exit_execve                            16622      11121    -5501 (-33.09%)         376         232   -144 (-38.30%)
syar_exit_execveat                          16622      11121    -5501 (-33.09%)         376         232   -144 (-38.30%)
syar_syscalls_kill                          15288       9787    -5501 (-35.98%)         398         254   -144 (-36.18%)
syar_task_enter_pivot_root                  14898       9397    -5501 (-36.92%)         357         213   -144 (-40.34%)
syar_syscalls_setreuid                      16678      11177    -5501 (-32.98%)         429         285   -144 (-33.57%)
syar_syscalls_setuid                        16678      11177    -5501 (-32.98%)         429         285   -144 (-33.57%)
syar_syscalls_process_vm_readv              14959       9458    -5501 (-36.77%)         364         220   -144 (-39.56%)
syar_syscalls_process_vm_writev             15757      10256    -5501 (-34.91%)         390         246   -144 (-36.92%)
do_uprobe                                   15519      10018    -5501 (-35.45%)         373         229   -144 (-38.61%)
edgewall                                   179715      55783  -123932 (-68.96%)       12607        3999  -8608 (-68.28%)
bictcp_state                                 7570       4131    -3439 (-45.43%)         496         269   -227 (-45.77%)
cubictcp_state                               7570       4131    -3439 (-45.43%)         496         269   -227 (-45.77%)
tcp_rate_skb_delivered                        447        272     -175 (-39.15%)          29          18    -11 (-37.93%)
kprobe__bbr_set_state                        4566       2615    -1951 (-42.73%)         209         124    -85 (-40.67%)
kprobe__bictcp_state                         4566       2615    -1951 (-42.73%)         209         124    -85 (-40.67%)
inet_sock_set_state                          1501       1337     -164 (-10.93%)          93          85      -8 (-8.60%)
tcp_retransmit_skb                           1145        981     -164 (-14.32%)          67          59     -8 (-11.94%)
tcp_retransmit_synack                        1183        951     -232 (-19.61%)          67          55    -12 (-17.91%)
bpf_tcptuner                                 1459       1187     -272 (-18.64%)          99          80    -19 (-19.19%)
tw_egress                                     801        776       -25 (-3.12%)          69          66      -3 (-4.35%)
tw_ingress                                    795        770       -25 (-3.14%)          69          66      -3 (-4.35%)
ttls_tc_ingress                             19025      19383      +358 (+1.88%)         470         465      -5 (-1.06%)
ttls_nat_egress                               490        299     -191 (-38.98%)          33          20    -13 (-39.39%)
ttls_nat_ingress                              448        285     -163 (-36.38%)          32          21    -11 (-34.38%)
tw_twfw_egress                             511127     212071  -299056 (-58.51%)       16733        8504  -8229 (-49.18%)
tw_twfw_ingress                            500095     212069  -288026 (-57.59%)       16223        8504  -7719 (-47.58%)
tw_twfw_tc_eg                              511113     212064  -299049 (-58.51%)       16732        8504  -8228 (-49.18%)
tw_twfw_tc_in                              500095     212069  -288026 (-57.59%)       16223        8504  -7719 (-47.58%)
tw_twfw_egress                              12632      12435      -197 (-1.56%)         276         260     -16 (-5.80%)
tw_twfw_ingress                             12631      12454      -177 (-1.40%)         278         261     -17 (-6.12%)
tw_twfw_tc_eg                               12595      12435      -160 (-1.27%)         274         259     -15 (-5.47%)
tw_twfw_tc_in                               12631      12454      -177 (-1.40%)         278         261     -17 (-6.12%)
tw_xdp_dump                                   266        209      -57 (-21.43%)           9           8     -1 (-11.11%)

CILIUM
=========
File           Program                           Insns (A)  Insns (B)  Insns     (DIFF)  States (A)  States (B)  States  (DIFF)
-------------  --------------------------------  ---------  ---------  ----------------  ----------  ----------  --------------
bpf_host.o     cil_to_netdev                          6047       4578   -1469 (-24.29%)         362         249  -113 (-31.22%)
bpf_host.o     handle_lxc_traffic                     2227       1585    -642 (-28.83%)         156         103   -53 (-33.97%)
bpf_host.o     tail_handle_ipv4_from_netdev           2244       1458    -786 (-35.03%)         163         106   -57 (-34.97%)
bpf_host.o     tail_handle_nat_fwd_ipv4              21022      10479  -10543 (-50.15%)        1289         670  -619 (-48.02%)
bpf_host.o     tail_handle_nat_fwd_ipv6              15433      11375   -4058 (-26.29%)         905         643  -262 (-28.95%)
bpf_host.o     tail_ipv4_host_policy_ingress          2219       1367    -852 (-38.40%)         161          96   -65 (-40.37%)
bpf_host.o     tail_nodeport_nat_egress_ipv4         22460      19862   -2598 (-11.57%)        1469        1293  -176 (-11.98%)
bpf_host.o     tail_nodeport_nat_ingress_ipv4         5526       3534   -1992 (-36.05%)         366         243  -123 (-33.61%)
bpf_host.o     tail_nodeport_nat_ingress_ipv6         5132       4256    -876 (-17.07%)         241         219    -22 (-9.13%)
bpf_host.o     tail_nodeport_nat_ipv6_egress          3702       3542     -160 (-4.32%)         215         205    -10 (-4.65%)
bpf_lxc.o      tail_handle_nat_fwd_ipv4              21022      10479  -10543 (-50.15%)        1289         670  -619 (-48.02%)
bpf_lxc.o      tail_handle_nat_fwd_ipv6              15433      11375   -4058 (-26.29%)         905         643  -262 (-28.95%)
bpf_lxc.o      tail_ipv4_ct_egress                    5073       3374   -1699 (-33.49%)         262         172   -90 (-34.35%)
bpf_lxc.o      tail_ipv4_ct_ingress                   5093       3385   -1708 (-33.54%)         262         172   -90 (-34.35%)
bpf_lxc.o      tail_ipv4_ct_ingress_policy_only       5093       3385   -1708 (-33.54%)         262         172   -90 (-34.35%)
bpf_lxc.o      tail_ipv6_ct_egress                    4593       3878    -715 (-15.57%)         194         151   -43 (-22.16%)
bpf_lxc.o      tail_ipv6_ct_ingress                   4606       3891    -715 (-15.52%)         194         151   -43 (-22.16%)
bpf_lxc.o      tail_ipv6_ct_ingress_policy_only       4606       3891    -715 (-15.52%)         194         151   -43 (-22.16%)
bpf_lxc.o      tail_nodeport_nat_ingress_ipv4         5526       3534   -1992 (-36.05%)         366         243  -123 (-33.61%)
bpf_lxc.o      tail_nodeport_nat_ingress_ipv6         5132       4256    -876 (-17.07%)         241         219    -22 (-9.13%)
bpf_overlay.o  tail_handle_nat_fwd_ipv4              20524      10114  -10410 (-50.72%)        1271         638  -633 (-49.80%)
bpf_overlay.o  tail_nodeport_nat_egress_ipv4         22718      19490   -3228 (-14.21%)        1475        1275  -200 (-13.56%)
bpf_overlay.o  tail_nodeport_nat_ingress_ipv4         5526       3534   -1992 (-36.05%)         366         243  -123 (-33.61%)
bpf_overlay.o  tail_nodeport_nat_ingress_ipv6         5132       4256    -876 (-17.07%)         241         219    -22 (-9.13%)
bpf_overlay.o  tail_nodeport_nat_ipv6_egress          3638       3548      -90 (-2.47%)         209         203     -6 (-2.87%)
bpf_overlay.o  tail_rev_nodeport_lb4                  4368       3820    -548 (-12.55%)         248         215   -33 (-13.31%)
bpf_overlay.o  tail_rev_nodeport_lb6                  2867       2428    -439 (-15.31%)         167         140   -27 (-16.17%)
bpf_sock.o     cil_sock6_connect                      1718       1703      -15 (-0.87%)         100          99     -1 (-1.00%)
bpf_xdp.o      tail_handle_nat_fwd_ipv4              12917      12443     -474 (-3.67%)         875         849    -26 (-2.97%)
bpf_xdp.o      tail_handle_nat_fwd_ipv6              13515      13264     -251 (-1.86%)         715         702    -13 (-1.82%)
bpf_xdp.o      tail_lb_ipv4                          39492      36367    -3125 (-7.91%)        2430        2251   -179 (-7.37%)
bpf_xdp.o      tail_lb_ipv6                          80441      78058    -2383 (-2.96%)        3647        3523   -124 (-3.40%)
bpf_xdp.o      tail_nodeport_ipv6_dsr                 1038        901    -137 (-13.20%)          61          55     -6 (-9.84%)
bpf_xdp.o      tail_nodeport_nat_egress_ipv4         13027      12096     -931 (-7.15%)         868         809    -59 (-6.80%)
bpf_xdp.o      tail_nodeport_nat_ingress_ipv4         7617       5900   -1717 (-22.54%)         522         413  -109 (-20.88%)
bpf_xdp.o      tail_nodeport_nat_ingress_ipv6         7575       7395     -180 (-2.38%)         383         374     -9 (-2.35%)
bpf_xdp.o      tail_rev_nodeport_lb4                  6808       6739      -69 (-1.01%)         403         396     -7 (-1.74%)
bpf_xdp.o      tail_rev_nodeport_lb6                 16173      15847     -326 (-2.02%)        1010         990    -20 (-1.98%)

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20231205184248.1502704-9-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/verifier.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index eaeb996ff56a..705582bdda68 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4666,8 +4666,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 		return err;
 
 	mark_stack_slot_scratched(env, spi);
-	if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) &&
-	    !register_is_null(reg) && env->bpf_capable) {
+	if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) && env->bpf_capable) {
 		save_register_state(env, state, spi, reg, size);
 		/* Break the relation on a narrowing spill. */
 		if (fls64(reg->umax_value) > BITS_PER_BYTE * size)
@@ -4716,7 +4715,12 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 		/* when we zero initialize stack slots mark them as such */
 		if ((reg && register_is_null(reg)) ||
 		    (!reg && is_bpf_st_mem(insn) && insn->imm == 0)) {
-			/* backtracking doesn't work for STACK_ZERO yet. */
+			/* STACK_ZERO case happened because register spill
+			 * wasn't properly aligned at the stack slot boundary,
+			 * so it's not a register spill anymore; force
+			 * originating register to be precise to make
+			 * STACK_ZERO correct for subsequent states
+			 */
 			err = mark_chain_precision(env, value_regno);
 			if (err)
 				return err;
-- 
2.43.0


