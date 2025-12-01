Return-Path: <stable+bounces-197907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA7DC972E8
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 13:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 970EA3A35E2
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 12:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A17D3093D7;
	Mon,  1 Dec 2025 12:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vrjkX21I"
X-Original-To: stable@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A4C308F16
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 12:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764590954; cv=none; b=Op3eYFHaOaBP1ErNtlIANZJLXJWkVvNmWcWaVPWDpgwc+wdV3XfO8Qch07euqHQTJWmV1X2m30m88n1D2xF7GF9GXhcHnQgJwCETHDa4MonP8t3YMu4ZfmDe6U09TDiP554ymjwnd4WM7ElzEB/L84FTEHQ/568P08A34KFe7Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764590954; c=relaxed/simple;
	bh=ibTgSbG8TGqtAzZKu1uLxU29a9QbmAXspDCwsI6X+Kg=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=hbKrk167xuf78+xlOtRiUOpjzxGKm0h3qNtBiW6I7j4GdsAt9NIGkQQ3oG4ONFwYERApgzuA8+do6r4+pm5MCoWmZFaVwS3jlrXmAeXhnKEhC0ENBDs4P3PMedH0qyBYub1//98f15wupUriu1eaFaOq5a5dsLffN4ukthDmk1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vrjkX21I; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764590939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OJtRUuBwABSVGz5r9EtayhOLYHEzpUxmaDcPPsAZ6ac=;
	b=vrjkX21Ip/yyoNbgveFc8eb+7LG+bzfpbmLCMEiPrnmHZCFuODUx5N5NieyAz6J0Q8DTlw
	m0j0ohMRar8UeJ/YUShxhP/UsliQkIHzNRBwruzDhSdTWIVtWkpETBl2zTc1pXo+UFhGAv
	zX7mfMEo18c3KOVroz5r6g4hjuwykNw=
Date: Mon, 01 Dec 2025 12:08:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <2860fe2b031575a966eb739ce8a98bc83d5392a2@linux.dev>
TLS-Required: No
Subject: Re: [PATCH 5.15.y] mptcp: Fix proto fallback detection with BPF
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org,
 gregkh@linuxfoundation.org
Cc: "MPTCP Upstream" <mptcp@lists.linux.dev>, "Martin KaFai Lau"
 <martin.lau@kernel.org>, "Jakub Sitnicki" <jakub@cloudflare.com>,
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
In-Reply-To: <20251201112712.3573321-2-matttbe@kernel.org>
References: <2025112449-untaxed-cola-39b4@gregkh>
 <20251201112712.3573321-2-matttbe@kernel.org>
X-Migadu-Flow: FLOW_OUT

December 1, 2025 at 19:27, "Matthieu Baerts (NGI0)" <matttbe@kernel.org m=
ailto:matttbe@kernel.org?to=3D%22Matthieu%20Baerts%20(NGI0)%22%20%3Cmattt=
be%40kernel.org%3E > wrote:


>=20
>=20From: Jiayuan Chen <jiayuan.chen@linux.dev>
>=20
>=20commit c77b3b79a92e3345aa1ee296180d1af4e7031f8f upstream.
>=20
>=20The sockmap feature allows bpf syscall from userspace, or based
> on bpf sockops, replacing the sk_prot of sockets during protocol stack
> processing with sockmap's custom read/write interfaces.
> '''
> tcp_rcv_state_process()
>  syn_recv_sock()/subflow_syn_recv_sock()
>  tcp_init_transfer(BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB)
>  bpf_skops_established <=3D=3D sockops
>  bpf_sock_map_update(sk) <=3D=3D call bpf helper
>  tcp_bpf_update_proto() <=3D=3D update sk_prot
> '''
>=20
>=20When the server has MPTCP enabled but the client sends a TCP SYN
> without MPTCP, subflow_syn_recv_sock() performs a fallback on the
> subflow, replacing the subflow sk's sk_prot with the native sk_prot.
> '''
> subflow_syn_recv_sock()
>  subflow_ulp_fallback()
>  subflow_drop_ctx()
>  mptcp_subflow_ops_undo_override()
> '''
>=20
>=20Then, this subflow can be normally used by sockmap, which replaces th=
e
> native sk_prot with sockmap's custom sk_prot. The issue occurs when the
> user executes accept::mptcp_stream_accept::mptcp_fallback_tcp_ops().
> Here, it uses sk->sk_prot to compare with the native sk_prot, but this
> is incorrect when sockmap is used, as we may incorrectly set
> sk->sk_socket->ops.
>=20
>=20This fix uses the more generic sk_family for the comparison instead.
>=20
>=20Additionally, this also prevents a WARNING from occurring:
>=20
>=20result from ./scripts/decode_stacktrace.sh:
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 337 at net/mptcp/protocol.c:68 mptcp_stream_accept=
 \
> (net/mptcp/protocol.c:4005)
> Modules linked in:
> ...
>=20
>=20PKRU: 55555554
> Call Trace:
> <TASK>
> do_accept (net/socket.c:1989)
> __sys_accept4 (net/socket.c:2028 net/socket.c:2057)
> __x64_sys_accept (net/socket.c:2067)
> x64_sys_call (arch/x86/entry/syscall_64.c:41)
> do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64=
.c:94)
> entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> RIP: 0033:0x7f87ac92b83d
>=20
>=20---[ end trace 0000000000000000 ]---
>=20
>=20Fixes: 0b4f33def7bb ("mptcp: fix tcp fallback crash")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Cc: <stable@vger.kernel.org>
> Link: https://patch.msgid.link/20251111060307.194196-3-jiayuan.chen@lin=
ux.dev
> [ Conflicts in protocol.c, because commit 8e2b8a9fa512 ("mptcp: don't
>  overwrite sock_ops in mptcp_is_tcpsk()") is not in this version. It
>  changes the logic on how and where the sock_ops is overridden in case
>  of passive fallback. To fix this, mptcp_is_tcpsk() is modified to use
>  the family, but first, a check of the protocol is required to continue
>  returning 'false' in case of MPTCP socket. ]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/protocol.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
>=20diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f89de0f7b3e5..98fd4ffe6f11 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -77,8 +77,13 @@ static u64 mptcp_wnd_end(const struct mptcp_sock *ms=
k)
>  static bool mptcp_is_tcpsk(struct sock *sk)
>  {
>  struct socket *sock =3D sk->sk_socket;
> + unsigned short family;
>=20=20
>=20- if (unlikely(sk->sk_prot =3D=3D &tcp_prot)) {
> + if (likely(sk->sk_protocol =3D=3D IPPROTO_MPTCP))
> + return false;
> +
> + family =3D READ_ONCE(sk->sk_family);
> + if (unlikely(family =3D=3D AF_INET)) {
>  /* we are being invoked after mptcp_accept() has
>  * accepted a non-mp-capable flow: sk is a tcp_sk,
>  * not an mptcp one.
> @@ -89,7 +94,7 @@ static bool mptcp_is_tcpsk(struct sock *sk)
>  sock->ops =3D &inet_stream_ops;
>  return true;
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> - } else if (unlikely(sk->sk_prot =3D=3D &tcpv6_prot)) {
> + } else if (unlikely(family =3D=3D AF_INET6)) {
>  sock->ops =3D &inet6_stream_ops;
>  return true;
>  #endif
> --=20
>=202.51.0
>

Thanks =E2=80=94 I happened to have a 5.15 environment, and I=E2=80=99ve =
successfully tested
the patch there. I believe 5.10 should behave the same way.


Before applying the patch, the following panic occurred. After applying i=
t,
the panic disappeared. I think this is sufficient to confirm the fix work=
s
for both 5.15 and 5.10.

BUG: unable to handle page fault for address: 0000000dd85a1764
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] SMP PTI
CPU: 0 PID: 373 Comm: test_progs Not tainted 5.15.189+ #11
RIP: 0010:mptcp_stream_accept+0x118/0x3c0
RSP: 0018:ffffc90000907ad8 EFLAGS: 00010246
RAX: 0000000dd85a129c RBX: ffff88800c52c000 RCX: 0000000000000000
RDX: 00030d4000030d40 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90000907b30 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880050ada00
R13: ffff888005099d40 R14: ffff888007368670 R15: ffff888007368000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000dd85a1764 CR3: 0000000006e20004 CR4: 0000000000770ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 ? apparmor_socket_accept+0x1e/0x30
 do_accept+0x12a/0x1b0
 __sys_accept4_file+0x55/0xb0
 __sys_accept4+0x62/0xc0
 __x64_sys_accept+0x1b/0x30
 x64_sys_call+0x1a57/0x2190

