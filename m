Return-Path: <stable+bounces-197910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB00C9731D
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 13:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7F6B3A2C1F
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 12:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC33B309EFE;
	Mon,  1 Dec 2025 12:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlBmOdKN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CE22550AF;
	Mon,  1 Dec 2025 12:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764591470; cv=none; b=MqbaDLgwlig9Ue7W49hjToMjtqYH+iFGBLBFXckZIflXXavIC5sFryc5FFbSHfDZ/gkmiUSOXRI/XlulbBPSyGi6tsj+MOmwjYAySwZQuPI6RXNVZOIYAz3GTuvBhhbq9GdMo2NjWxJiBNpspu3qAQNrUr73Mdq65uVuJBM51zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764591470; c=relaxed/simple;
	bh=LLK6nmfhOCCFchOJKLMPIAQ48FJ3mHaGf+kgJzYaKL4=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:References:
	 From:Cc:In-Reply-To; b=UAghpz2c5VpkBOVkzOIFE7ijsKIpDITt9M8Synp5Tz62QELfogz+4fdJIYPfwXO1ijvrMjq2A9d9ZXoAuQPWhZlWqAK46/oqGoAN/xM03hI3hoEZKubslelC4WShVvF74at3SWlduvtlV0hK198Ip1X3iQ/rUPCGytUHqVmzDo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlBmOdKN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0D4C4CEF1;
	Mon,  1 Dec 2025 12:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764591469;
	bh=LLK6nmfhOCCFchOJKLMPIAQ48FJ3mHaGf+kgJzYaKL4=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=qlBmOdKNV0nN7+qfS2FP5pSydNZT55TD9l5cnhMkW0k6k45yG3FMRMqH/a8Z11Nii
	 7aW9JIbWMG32ZufXasTsWBILGFqDmL/JvT9TsWt8V7xrWP7injXKptKN3oJhRpGJRw
	 DuIm3Dxsb9o6yoJszsadUAthdDCIlBfI/99caspA1wpXBJOCiavhAlMQngB5qfosIe
	 NngCpzN9Sn10wZw7s0Hz2o+01TK9jhB5RiQngoLos+tRQAyS8lG3cGxWDvqfo+kLsg
	 WG+b8hJYM5jpw5+vzQ6rd96uxALzZFVhedF1EN/puwFIwd6OvFAp0/9B604B5s2x+k
	 hH+iIb8VahKCg==
Content-Type: multipart/mixed; boundary="------------RJFlk95dY753WCj3z09sJ5h0"
Message-ID: <2d2ee415-0b7c-4c1e-a682-f319e243c8ab@kernel.org>
Date: Mon, 1 Dec 2025 13:17:45 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: FAILED: patch "[PATCH] mptcp: Disallow MPTCP subflows from
 sockmap" failed to apply to 5.10-stable tree
Content-Language: en-GB, fr-BE
To: gregkh@linuxfoundation.org, jiayuan.chen@linux.dev, martin.lau@kernel.org
References: <2025112455-daughter-unsealed-699a@gregkh>
From: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>, stable@vger.kernel.org
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <2025112455-daughter-unsealed-699a@gregkh>

This is a multi-part message in MIME format.
--------------RJFlk95dY753WCj3z09sJ5h0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 24/11/2025 14:21, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Thank you for the notification!
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
> git checkout FETCH_HEAD
> git cherry-pick -x fbade4bd08ba52cbc74a71c4e86e736f059f99f7
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112455-daughter-unsealed-699a@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..
> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From fbade4bd08ba52cbc74a71c4e86e736f059f99f7 Mon Sep 17 00:00:00 2001
> From: Jiayuan Chen <jiayuan.chen@linux.dev>
> Date: Tue, 11 Nov 2025 14:02:50 +0800
> Subject: [PATCH] mptcp: Disallow MPTCP subflows from sockmap
> 
> The sockmap feature allows bpf syscall from userspace, or based on bpf
> sockops, replacing the sk_prot of sockets during protocol stack processing
> with sockmap's custom read/write interfaces.
> '''
> tcp_rcv_state_process()
>   subflow_syn_recv_sock()
>     tcp_init_transfer(BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB)
>       bpf_skops_established       <== sockops
>         bpf_sock_map_update(sk)   <== call bpf helper
>           tcp_bpf_update_proto()  <== update sk_prot
> '''
> Consider two scenarios:
> 
> 1. When the server has MPTCP enabled and the client also requests MPTCP,
>    the sk passed to the BPF program is a subflow sk. Since subflows only
>    handle partial data, replacing their sk_prot is meaningless and will
>    cause traffic disruption.
> 
> 2. When the server has MPTCP enabled but the client sends a TCP SYN
>    without MPTCP, subflow_syn_recv_sock() performs a fallback on the
>    subflow, replacing the subflow sk's sk_prot with the native sk_prot.
>    '''
>    subflow_ulp_fallback()
>     subflow_drop_ctx()
>       mptcp_subflow_ops_undo_override()
>    '''
>    Subsequently, accept::mptcp_stream_accept::mptcp_fallback_tcp_ops()
>    converts the subflow to plain TCP.
> 
> For the first case, we should prevent it from being combined with sockmap
> by setting sk_prot->psock_update_sk_prot to NULL, which will be blocked by
> sockmap's own flow.
> 
> For the second case, since subflow_syn_recv_sock() has already restored
> sk_prot to native tcp_prot/tcpv6_prot, no further action is needed.
> 
> Fixes: cec37a6e41aa ("mptcp: Handle MP_CAPABLE options for outgoing connections")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Cc: <stable@vger.kernel.org>
> Link: https://patch.msgid.link/20251111060307.194196-2-jiayuan.chen@linux.dev
> 
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index e8325890a322..af707ce0f624 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -2144,6 +2144,10 @@ void __init mptcp_subflow_init(void)
>  	tcp_prot_override = tcp_prot;
>  	tcp_prot_override.release_cb = tcp_release_cb_override;
>  	tcp_prot_override.diag_destroy = tcp_abort_override;
> +#ifdef CONFIG_BPF_SYSCALL
> +	/* Disable sockmap processing for subflows */
> +	tcp_prot_override.psock_update_sk_prot = NULL;
> +#endif
>  
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>  	/* In struct mptcp_subflow_request_sock, we assume the TCP request sock
> @@ -2180,6 +2184,10 @@ void __init mptcp_subflow_init(void)
>  	tcpv6_prot_override = tcpv6_prot;
>  	tcpv6_prot_override.release_cb = tcp_release_cb_override;
>  	tcpv6_prot_override.diag_destroy = tcp_abort_override;
> +#ifdef CONFIG_BPF_SYSCALL
> +	/* Disable sockmap processing for subflows */
> +	tcpv6_prot_override.psock_update_sk_prot = NULL;
> +#endif
>  #endif
>  
>  	mptcp_diag_subflow_init(&subflow_ulp_ops);
> 

FYI, the patch cannot be applied on v5.10 because
sk_prot->psock_update_sk_prot is not available, see commit 8a59f9d1e3d4
("sock: Introduce sk->sk_prot->psock_update_sk_prot()").

I have attached an **RFC** patch for anyone who would be ready to test
it, but please don't apply it before these tests: I don't want to break
things on TCP sockmap side. (That's why I'm attaching the patch and not
sending it the proper way.)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

--------------RJFlk95dY753WCj3z09sJ5h0
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-mptcp-Disallow-MPTCP-subflows-from-sockmap.patch"
Content-Disposition: attachment;
 filename="0001-mptcp-Disallow-MPTCP-subflows-from-sockmap.patch"
Content-Transfer-Encoding: base64

RnJvbSA0MzY3NDRmMWQwY2UyMjU3ZDlmZWEzNGE0MGQyYWRiMThkY2IzMzBiIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKaWF5dWFuIENoZW4gPGppYXl1YW4uY2hlbkBsaW51
eC5kZXY+CkRhdGU6IFR1ZSwgMTEgTm92IDIwMjUgMTQ6MDI6NTAgKzA4MDAKU3ViamVjdDog
W1BBVENIIFJGQ10gbXB0Y3A6IERpc2FsbG93IE1QVENQIHN1YmZsb3dzIGZyb20gc29ja21h
cAoKY29tbWl0IGZiYWRlNGJkMDhiYTUyY2JjNzRhNzFjNGU4NmU3MzZmMDU5Zjk5ZjcKClRo
ZSBzb2NrbWFwIGZlYXR1cmUgYWxsb3dzIGJwZiBzeXNjYWxsIGZyb20gdXNlcnNwYWNlLCBv
ciBiYXNlZCBvbiBicGYKc29ja29wcywgcmVwbGFjaW5nIHRoZSBza19wcm90IG9mIHNvY2tl
dHMgZHVyaW5nIHByb3RvY29sIHN0YWNrIHByb2Nlc3NpbmcKd2l0aCBzb2NrbWFwJ3MgY3Vz
dG9tIHJlYWQvd3JpdGUgaW50ZXJmYWNlcy4KJycnCnRjcF9yY3Zfc3RhdGVfcHJvY2Vzcygp
CiAgc3ViZmxvd19zeW5fcmVjdl9zb2NrKCkKICAgIHRjcF9pbml0X3RyYW5zZmVyKEJQRl9T
T0NLX09QU19QQVNTSVZFX0VTVEFCTElTSEVEX0NCKQogICAgICBicGZfc2tvcHNfZXN0YWJs
aXNoZWQgICAgICAgPD09IHNvY2tvcHMKICAgICAgICBicGZfc29ja19tYXBfdXBkYXRlKHNr
KSAgIDw9PSBjYWxsIGJwZiBoZWxwZXIKICAgICAgICAgIHRjcF9icGZfdXBkYXRlX3Byb3Rv
KCkgIDw9PSB1cGRhdGUgc2tfcHJvdAonJycKQ29uc2lkZXIgdHdvIHNjZW5hcmlvczoKCjEu
IFdoZW4gdGhlIHNlcnZlciBoYXMgTVBUQ1AgZW5hYmxlZCBhbmQgdGhlIGNsaWVudCBhbHNv
IHJlcXVlc3RzIE1QVENQLAogICB0aGUgc2sgcGFzc2VkIHRvIHRoZSBCUEYgcHJvZ3JhbSBp
cyBhIHN1YmZsb3cgc2suIFNpbmNlIHN1YmZsb3dzIG9ubHkKICAgaGFuZGxlIHBhcnRpYWwg
ZGF0YSwgcmVwbGFjaW5nIHRoZWlyIHNrX3Byb3QgaXMgbWVhbmluZ2xlc3MgYW5kIHdpbGwK
ICAgY2F1c2UgdHJhZmZpYyBkaXNydXB0aW9uLgoKMi4gV2hlbiB0aGUgc2VydmVyIGhhcyBN
UFRDUCBlbmFibGVkIGJ1dCB0aGUgY2xpZW50IHNlbmRzIGEgVENQIFNZTgogICB3aXRob3V0
IE1QVENQLCBzdWJmbG93X3N5bl9yZWN2X3NvY2soKSBwZXJmb3JtcyBhIGZhbGxiYWNrIG9u
IHRoZQogICBzdWJmbG93LCByZXBsYWNpbmcgdGhlIHN1YmZsb3cgc2sncyBza19wcm90IHdp
dGggdGhlIG5hdGl2ZSBza19wcm90LgogICAnJycKICAgc3ViZmxvd191bHBfZmFsbGJhY2so
KQogICAgc3ViZmxvd19kcm9wX2N0eCgpCiAgICAgIG1wdGNwX3N1YmZsb3dfb3BzX3VuZG9f
b3ZlcnJpZGUoKQogICAnJycKICAgU3Vic2VxdWVudGx5LCBhY2NlcHQ6Om1wdGNwX3N0cmVh
bV9hY2NlcHQ6Om1wdGNwX2ZhbGxiYWNrX3RjcF9vcHMoKQogICBjb252ZXJ0cyB0aGUgc3Vi
ZmxvdyB0byBwbGFpbiBUQ1AuCgpGb3IgdGhlIGZpcnN0IGNhc2UsIHdlIHNob3VsZCBwcmV2
ZW50IGl0IGZyb20gYmVpbmcgY29tYmluZWQgd2l0aCBzb2NrbWFwCmJ5IHNldHRpbmcgc2tf
cHJvdC0+cHNvY2tfdXBkYXRlX3NrX3Byb3QgdG8gTlVMTCwgd2hpY2ggd2lsbCBiZSBibG9j
a2VkIGJ5CnNvY2ttYXAncyBvd24gZmxvdy4KCkZvciB0aGUgc2Vjb25kIGNhc2UsIHNpbmNl
IHN1YmZsb3dfc3luX3JlY3Zfc29jaygpIGhhcyBhbHJlYWR5IHJlc3RvcmVkCnNrX3Byb3Qg
dG8gbmF0aXZlIHRjcF9wcm90L3RjcHY2X3Byb3QsIG5vIGZ1cnRoZXIgYWN0aW9uIGlzIG5l
ZWRlZC4KCkZpeGVzOiBjZWMzN2E2ZTQxYWEgKCJtcHRjcDogSGFuZGxlIE1QX0NBUEFCTEUg
b3B0aW9ucyBmb3Igb3V0Z29pbmcgY29ubmVjdGlvbnMiKQpTaWduZWQtb2ZmLWJ5OiBKaWF5
dWFuIENoZW4gPGppYXl1YW4uY2hlbkBsaW51eC5kZXY+ClNpZ25lZC1vZmYtYnk6IE1hcnRp
biBLYUZhaSBMYXUgPG1hcnRpbi5sYXVAa2VybmVsLm9yZz4KUmV2aWV3ZWQtYnk6IE1hdHRo
aWV1IEJhZXJ0cyAoTkdJMCkgPG1hdHR0YmVAa2VybmVsLm9yZz4KQ2M6IDxzdGFibGVAdmdl
ci5rZXJuZWwub3JnPgpMaW5rOiBodHRwczovL3BhdGNoLm1zZ2lkLmxpbmsvMjAyNTExMTEw
NjAzMDcuMTk0MTk2LTItamlheXVhbi5jaGVuQGxpbnV4LmRldgpbIEluIHRoaXMgdmVyc2lv
biwgc2tfcHJvdC0+cHNvY2tfdXBkYXRlX3NrX3Byb3QgaXMgbm90IGF2YWlsYWJsZSwgc2Vl
CiAgY29tbWl0IDhhNTlmOWQxZTNkNCAoInNvY2s6IEludHJvZHVjZSBzay0+c2tfcHJvdC0+
cHNvY2tfdXBkYXRlX3NrX3Byb3QoKSIpLgogIEluc3RlYWQgb2YgY2hlY2tpbmcgdGhlIGZh
bWlseSwgcmVzdHJpY3Qgb25seSB0byB0aGUgVENQIHByb3RvY29sLiBdClNpZ25lZC1vZmYt
Ynk6IE1hdHRoaWV1IEJhZXJ0cyAoTkdJMCkgPG1hdHR0YmVAa2VybmVsLm9yZz4KLS0tCiBu
ZXQvaXB2NC90Y3BfYnBmLmMgfCA3ICsrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2lwdjQvdGNwX2Jw
Zi5jIGIvbmV0L2lwdjQvdGNwX2JwZi5jCmluZGV4IGJjZDVmYzQ4NGY3Ny4uNDcxMzMzOTNk
NjljIDEwMDY0NAotLS0gYS9uZXQvaXB2NC90Y3BfYnBmLmMKKysrIGIvbmV0L2lwdjQvdGNw
X2JwZi5jCkBAIC0xMCw2ICsxMCw3IEBACiAKICNpbmNsdWRlIDxuZXQvaW5ldF9jb21tb24u
aD4KICNpbmNsdWRlIDxuZXQvdGxzLmg+CisjaW5jbHVkZSA8bmV0L3RyYW5zcF92Ni5oPgog
CiBpbnQgX190Y3BfYnBmX3JlY3Ztc2coc3RydWN0IHNvY2sgKnNrLCBzdHJ1Y3Qgc2tfcHNv
Y2sgKnBzb2NrLAogCQkgICAgICBzdHJ1Y3QgbXNnaGRyICptc2csIGludCBsZW4sIGludCBm
bGFncykKQEAgLTYyNywxNCArNjI4LDE2IEBAIHN0cnVjdCBwcm90byAqdGNwX2JwZl9nZXRf
cHJvdG8oc3RydWN0IHNvY2sgKnNrLCBzdHJ1Y3Qgc2tfcHNvY2sgKnBzb2NrKQogCWludCBm
YW1pbHkgPSBzay0+c2tfZmFtaWx5ID09IEFGX0lORVQ2ID8gVENQX0JQRl9JUFY2IDogVENQ
X0JQRl9JUFY0OwogCWludCBjb25maWcgPSBwc29jay0+cHJvZ3MubXNnX3BhcnNlciAgID8g
VENQX0JQRl9UWCAgIDogVENQX0JQRl9CQVNFOwogCi0JaWYgKHNrLT5za19mYW1pbHkgPT0g
QUZfSU5FVDYpIHsKKwlpZiAoc2stPnNrX3Byb3QgPT0gJnRjcHY2X3Byb3QpIHsKIAkJaWYg
KHRjcF9icGZfYXNzZXJ0X3Byb3RvX29wcyhwc29jay0+c2tfcHJvdG8pKQogCQkJcmV0dXJu
IEVSUl9QVFIoLUVJTlZBTCk7CiAKIAkJdGNwX2JwZl9jaGVja192Nl9uZWVkc19yZWJ1aWxk
KHBzb2NrLT5za19wcm90byk7CisJfSBlbHNlIGlmIChzay0+c2tfcHJvdCA9PSAmdGNwX3By
b3QpIHsKKwkJcmV0dXJuICZ0Y3BfYnBmX3Byb3RzW2ZhbWlseV1bY29uZmlnXTsKIAl9CiAK
LQlyZXR1cm4gJnRjcF9icGZfcHJvdHNbZmFtaWx5XVtjb25maWddOworCXJldHVybiBFUlJf
UFRSKC1FSU5WQUwpOwogfQogCiAvKiBJZiBhIGNoaWxkIGdvdCBjbG9uZWQgZnJvbSBhIGxp
c3RlbmluZyBzb2NrZXQgdGhhdCBoYWQgdGNwX2JwZgotLSAKMi41MS4wCgo=

--------------RJFlk95dY753WCj3z09sJ5h0--

