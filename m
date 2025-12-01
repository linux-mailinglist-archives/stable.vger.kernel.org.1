Return-Path: <stable+bounces-197909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F772C97309
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 13:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 01F2B4E14DF
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 12:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0490A3093C8;
	Mon,  1 Dec 2025 12:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brszc0J9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E882F6913;
	Mon,  1 Dec 2025 12:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764591176; cv=none; b=MnmPjGsJzQwnGpgQLV9HcvsUQP7foN2CrBt4klkOVjLstH5Wz+AOnSWJtMe4z0vf3rNy6nGQSy7ss/h1qdN8uxvLMsurbwIV74YINBWeKe7PI6zbggVAq05d0giyNA6HSPjB+CTUD02d1gKcYT6Uggx6LzuT+1UUa/OJirktZcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764591176; c=relaxed/simple;
	bh=LDnUyDr3vk4lDfXeo36tU3DSdEMmXxz/RdSEjgFCeTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LjlFZCOPMktKVr6SGu+3ysTQ5sJTzcyGyGK1khyNv/o0H0QrkksPoB18zuETgPDCybsxrWjAZ33lx1/e08YLWQ4UOycFI9gA695fMIsBKgZBkUelOcJ9lqqCtLUUqvPRTTf5/EU8pBNZ5IFGSptq2N/xg9Z0LAKllE5bm80Bhow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brszc0J9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C4DC4CEF1;
	Mon,  1 Dec 2025 12:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764591176;
	bh=LDnUyDr3vk4lDfXeo36tU3DSdEMmXxz/RdSEjgFCeTk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=brszc0J9bzVlEMVZCySg5+tttereyDsXlQKEcpc+yVktYS5rMhZGypH02lamECAjH
	 o8mLBuHp/9Hxw/Tgq0CLL/AqCOYZZxfrXC136+m5/JkQ8G8o3589Q7Ehf9xEiu4B4n
	 JBvPBYCqt2t0P/fKzHj73CRUaMwG7oagxwm28KkA38lH6Ft07D9DK5qSYtv6RFTRxC
	 uO+OhMp8e8lsT/7ThNfHjsL0A6E45u4/xhQmE2+81KA9LlxF//i9Is9IOcecSsM8Bj
	 pHwigT0iee2FgE+2KY/JLQuqhTPnRVIz4bdQgRbHPfIoG+RlXl6MRHLSxEaDBCJbrd
	 qwd60Ng1QXtAA==
Message-ID: <19056d8e-5460-4709-9a0d-71449bf0de49@kernel.org>
Date: Mon, 1 Dec 2025 13:12:52 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 5.15.y] mptcp: Fix proto fallback detection with BPF
Content-Language: en-GB, fr-BE
To: Jiayuan Chen <jiayuan.chen@linux.dev>, stable@vger.kernel.org,
 gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Jakub Sitnicki <jakub@cloudflare.com>
References: <2025112449-untaxed-cola-39b4@gregkh>
 <20251201112712.3573321-2-matttbe@kernel.org>
 <2860fe2b031575a966eb739ce8a98bc83d5392a2@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <2860fe2b031575a966eb739ce8a98bc83d5392a2@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jiayuan,

On 01/12/2025 13:08, Jiayuan Chen wrote:
> December 1, 2025 at 19:27, "Matthieu Baerts (NGI0)" <matttbe@kernel.org mailto:matttbe@kernel.org?to=%22Matthieu%20Baerts%20(NGI0)%22%20%3Cmatttbe%40kernel.org%3E > wrote:
> 
> 
>>
>> From: Jiayuan Chen <jiayuan.chen@linux.dev>
>>
>> commit c77b3b79a92e3345aa1ee296180d1af4e7031f8f upstream.
>>
>> The sockmap feature allows bpf syscall from userspace, or based
>> on bpf sockops, replacing the sk_prot of sockets during protocol stack
>> processing with sockmap's custom read/write interfaces.
>> '''
>> tcp_rcv_state_process()
>>  syn_recv_sock()/subflow_syn_recv_sock()
>>  tcp_init_transfer(BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB)
>>  bpf_skops_established <== sockops
>>  bpf_sock_map_update(sk) <== call bpf helper
>>  tcp_bpf_update_proto() <== update sk_prot
>> '''
>>
>> When the server has MPTCP enabled but the client sends a TCP SYN
>> without MPTCP, subflow_syn_recv_sock() performs a fallback on the
>> subflow, replacing the subflow sk's sk_prot with the native sk_prot.
>> '''
>> subflow_syn_recv_sock()
>>  subflow_ulp_fallback()
>>  subflow_drop_ctx()
>>  mptcp_subflow_ops_undo_override()
>> '''
>>
>> Then, this subflow can be normally used by sockmap, which replaces the
>> native sk_prot with sockmap's custom sk_prot. The issue occurs when the
>> user executes accept::mptcp_stream_accept::mptcp_fallback_tcp_ops().
>> Here, it uses sk->sk_prot to compare with the native sk_prot, but this
>> is incorrect when sockmap is used, as we may incorrectly set
>> sk->sk_socket->ops.
>>
>> This fix uses the more generic sk_family for the comparison instead.
>>
>> Additionally, this also prevents a WARNING from occurring:
>>
>> result from ./scripts/decode_stacktrace.sh:
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 337 at net/mptcp/protocol.c:68 mptcp_stream_accept \
>> (net/mptcp/protocol.c:4005)
>> Modules linked in:
>> ...
>>
>> PKRU: 55555554
>> Call Trace:
>> <TASK>
>> do_accept (net/socket.c:1989)
>> __sys_accept4 (net/socket.c:2028 net/socket.c:2057)
>> __x64_sys_accept (net/socket.c:2067)
>> x64_sys_call (arch/x86/entry/syscall_64.c:41)
>> do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
>> entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
>> RIP: 0033:0x7f87ac92b83d
>>
>> ---[ end trace 0000000000000000 ]---
>>
>> Fixes: 0b4f33def7bb ("mptcp: fix tcp fallback crash")
>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
>> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
>> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> Cc: <stable@vger.kernel.org>
>> Link: https://patch.msgid.link/20251111060307.194196-3-jiayuan.chen@linux.dev
>> [ Conflicts in protocol.c, because commit 8e2b8a9fa512 ("mptcp: don't
>>  overwrite sock_ops in mptcp_is_tcpsk()") is not in this version. It
>>  changes the logic on how and where the sock_ops is overridden in case
>>  of passive fallback. To fix this, mptcp_is_tcpsk() is modified to use
>>  the family, but first, a check of the protocol is required to continue
>>  returning 'false' in case of MPTCP socket. ]
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  net/mptcp/protocol.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index f89de0f7b3e5..98fd4ffe6f11 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -77,8 +77,13 @@ static u64 mptcp_wnd_end(const struct mptcp_sock *msk)
>>  static bool mptcp_is_tcpsk(struct sock *sk)
>>  {
>>  struct socket *sock = sk->sk_socket;
>> + unsigned short family;
>>  
>> - if (unlikely(sk->sk_prot == &tcp_prot)) {
>> + if (likely(sk->sk_protocol == IPPROTO_MPTCP))
>> + return false;
>> +
>> + family = READ_ONCE(sk->sk_family);
>> + if (unlikely(family == AF_INET)) {
>>  /* we are being invoked after mptcp_accept() has
>>  * accepted a non-mp-capable flow: sk is a tcp_sk,
>>  * not an mptcp one.
>> @@ -89,7 +94,7 @@ static bool mptcp_is_tcpsk(struct sock *sk)
>>  sock->ops = &inet_stream_ops;
>>  return true;
>>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>> - } else if (unlikely(sk->sk_prot == &tcpv6_prot)) {
>> + } else if (unlikely(family == AF_INET6)) {
>>  sock->ops = &inet6_stream_ops;
>>  return true;
>>  #endif
>> -- 
>> 2.51.0
>>
> 
> Thanks — I happened to have a 5.15 environment, and I’ve successfully tested
> the patch there. I believe 5.10 should behave the same way.
> 
> 
> Before applying the patch, the following panic occurred. After applying it,
> the panic disappeared. I think this is sufficient to confirm the fix works
> for both 5.15 and 5.10.

Thank you for having checked on v5.15 as well!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


