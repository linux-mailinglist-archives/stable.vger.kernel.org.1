Return-Path: <stable+bounces-224538-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IV1DrxdsGloigIAu9opvQ
	(envelope-from <stable+bounces-224538-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 19:06:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A6C25623D
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 19:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3F9D30C3FB3
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 18:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B843D812A;
	Tue, 10 Mar 2026 18:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="niZfI7zs"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E59A3D647E
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 18:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773165677; cv=pass; b=OJ+aFQ+yO0BZgiKmtjNp+zVazDox3jZYCGKNlWH4tBuPiw0dmQLd/xTZ3TToFUr961e592QNhbBX0WJcijb13hne4ggVmBXX1CM5SvDj5HXgvLO8tMu1lgM/ZzkKwHhouXk+CqgAx7wS2RnU1o9rsv2zYoYkMAf9dRTacYMESfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773165677; c=relaxed/simple;
	bh=rYXsZMUuHk9Vij+MAdMAYvIwyWdemTN31YCkA/kn6go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qeTUc0s+H8sW3UJ8BagexYqEo8BCrTbfQvWZJOnlZuyvkvcw6pEKeNvCqKnxX0Dm+Y+4ydppOAtKk5x0aoedKVThKAAKDU4WxNBJr1xTIPISvb4zxkJKUW2vys5NIhBibNvGAZiwc8Q9K/qbYEPQeLvuwFV9hzJCqUTreMxEW5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=niZfI7zs; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-506a7bbe9d0so95689041cf.0
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 11:01:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773165675; cv=none;
        d=google.com; s=arc-20240605;
        b=KD9qPV+nBxGgyuQC217SnFf4l8jttKebPgrcxOBYx3u4Ec1jMp5C1pxSpqR5TzEi1A
         jZm2vtCIcWOAcHLwge1Gpv028LFYac0vqIf9AekCefpYgodn251Qr4/MNADNti1lQyl7
         SMMVHyQRlzOShaKf4rhZKhsXLS6sIc6Sj33bHeTfnLr1ZHAj+BT2fCsxxSqoPKkoVdQf
         w8KiA01ItrO42i+hSP5AAqeDknl7tgAXDidCO7d7pEwvv8eIxFlnnGVxA8kYMD/tUgWR
         7fRmHMpoEXDWNMMzTeM13ePSKl1ArqXcPaP7hjEJqULwA1x63owu21+SPdDRZVDmxh5j
         41ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z+UoqdE9EPEbZRoP0GTS9fi3D4aWH7UVd0od7k2xBoQ=;
        fh=RFNQteNje+AIY0aVY/hutHWKZRRsBfTkVaKMJmqH8Qs=;
        b=JXgvFFg/woSR24FJJNTSuFNmcODvDK5RIOMMWUOfIo/e9Yb5YaFnfNOHO53uwK3FJU
         03RhWMUOos+rWMdU8TQDdxHqF2UZUrgLwVpztPF6o3v43RfG4CSUZWU3vUUkLEDTar5C
         lUKBXHOFi/206OS20idkUsnfoB9jTfXOkhqPsmRuBq5rilofWgI05+lOOrJql1ZP/nth
         9qHryYmRHygF3XcypwmDazoWKDvCnq6CFZzF1fFYDTSK+fte201VQ+rGCivELlD7tVuC
         3tNxBeu9ZKibDEFkj8lxoT+j3wFYAADq3Dua6Z/fVPz938HL6shPhYEz9qQJt/c66Cys
         f7Ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773165675; x=1773770475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+UoqdE9EPEbZRoP0GTS9fi3D4aWH7UVd0od7k2xBoQ=;
        b=niZfI7zsg/Gf11FO83u/owPttxkNiDN0g8lBMJvYfX9zGE1ZT4lyeOWuQpd+O7heVW
         +EUeYM+TpxMEM4gKhvdte0rlYGKc+bvKnFAF8/nu/6z73H/O5bJ5Kduqnxqib5KnyNNB
         6NvU5phtZl/Lw6dkLkDVNLJqbfSTOMGWIdg9g3pK4P37zodrz1z9T01qhgCYqfx2kqzA
         XW8Fk7RTVnQzx/a73XKWo6K4HqjN1eqKFw6tcr4Zfxp3nwc0aZdktSeCizjJqwt6r1li
         1lNaeHPvVkIH/zTEQM4YN3qKUuA2tcrIPCgBy7/9iPP7MLAwP3gv66vZnpFoQz8gSodO
         a5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773165675; x=1773770475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z+UoqdE9EPEbZRoP0GTS9fi3D4aWH7UVd0od7k2xBoQ=;
        b=NfNFJWeaTQohMK/5rASoDLvq7UCydsfpBkKqmPl8UqvmkEMUGkEcbFq1d9h2ZvWVJV
         zdjma6u7EdS6gCeHZsyD5FntTBg6Gnqwirc5YjsnteafxksK3Gl6iSimho/1DoujOa1/
         CPf1hc94rAuYMwkYarZaZAy3aTi7PgFepQquR7eYtggdVqABYx2WHyTPk1Ri1jH9QxGO
         kC85qjpcGnqtrKUpd++bmgzplCahu8qlCM38svsEanY/9pliBpWl9OYe5lDkUY8MftC1
         pwzwYkHaW/hDCAgCfojex+HZQNYSZ+vinmwLw+pBmagds+2BoVkHnC9phBXqf/xJQPif
         LIAg==
X-Forwarded-Encrypted: i=1; AJvYcCUehADjr5/1depcvwBJ7o4sKR6qutGJTHhudu0QrtQCzIH7V5eb8PV6Jcmf209w0VkKW4kai1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhjTfNma8XbLZF97MSOudX2Jm1lBvWCBxcoFsPEQsC3eTsJkmv
	/soO1tSD3rcb+FGk99FTmClfiLHVkX/iWlP2ZtJu2Py+XtHO1RkrpQ5UpXVW2J/P7LotflatInY
	em9aBLAuA9L7rRWJMLJ9WtnKXVPBKf5X4SF+F+hSM
X-Gm-Gg: ATEYQzxGln5J3Uf3QP2lrj29zXI+HGeRbmtrTA3lgG3IUHLr51FVWC6YQ5NKI3z01Fd
	1wkkF/I4uKoRc/u4is95oWbfYlUs1EGx2TWGNr8YiOnoB+nMHa1vJo5tSHgQJLCgU8NCA2weOCw
	clKxKjflx64Hl8h/AJwsqKi2SlCxqd29fP7aOq5aYh4oychsykNCQksH2A4PO/ZcBzFHu6f2BV2
	IZ9ZTdsapgOQn8PP5qCUfRH4CP3iK5zDmQIfMZabPubmmNaGyuvygCh/Yqg4Ir5nzF2g5FeWuqW
	pP47qPM=
X-Received: by 2002:a05:622a:30c:b0:509:1987:7626 with SMTP id
 d75a77b69052e-50919878112mr105695521cf.68.1773165674535; Tue, 10 Mar 2026
 11:01:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310175426.110496-1-mehulrao@gmail.com>
In-Reply-To: <20260310175426.110496-1-mehulrao@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Mar 2026 19:01:02 +0100
X-Gm-Features: AaiRm53UGgNPm-VVL4bP7cqGr__1xchAYQsFlh3zLlZ1JMWlgUtST28CgXly02c
Message-ID: <CANn89iJxDq06TeNKANFw8E_FKsEq6v_st=1iLR-=HnZ_X=ofXQ@mail.gmail.com>
Subject: Re: [PATCH net] net/smc: fix NULL pointer dereference in smc_tcp_syn_recv_sock
To: Mehul Rao <mehulrao@gmail.com>
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	sidraya@linux.ibm.com, wenjia@linux.ibm.com, mjambigi@linux.ibm.com, 
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B7A6C25623D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224538-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 6:54=E2=80=AFPM Mehul Rao <mehulrao@gmail.com> wrot=
e:
>
> smc_clcsock_user_data() can return NULL when the listening SMC socket is
> being torn down concurrently. During close, smc_close_active() sets
> sk_user_data to NULL on the underlying CLC socket before shutting it
> down. If a TCP SYN completion arrives in this window,
> smc_tcp_syn_recv_sock() is called from softirq and dereferences the NULL
> pointer when accessing smc->queued_smc_hs.
>
> The sibling function smc_hs_congested() already handles this case by
> checking for NULL and returning early. Add the same NULL check to
> smc_tcp_syn_recv_sock().
>
>  BUG: KASAN: null-ptr-deref in smc_tcp_syn_recv_sock (arch/x86/include/as=
m/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux=
/atomic/atomic-instrumented.h:33 net/smc/af_smc.c:136)
>  Read of size 4 at addr 00000000000006b0 by task poc-F362/154
>
>  CPU: 2 UID: 0 PID: 154 Comm: poc-F362 Not tainted 7.0.0-rc3 #1 PREEMPT(l=
azy)
>  Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
>  Call Trace:
>   <IRQ>
>   dump_stack_lvl (lib/dump_stack.c:122)
>   kasan_report (mm/kasan/report.c:597)
>   ? smc_tcp_syn_recv_sock (arch/x86/include/asm/atomic.h:23 include/linux=
/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented=
.h:33 net/smc/af_smc.c:136)
>   ? smc_tcp_syn_recv_sock (arch/x86/include/asm/atomic.h:23 include/linux=
/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented=
.h:33 net/smc/af_smc.c:136)
>   kasan_check_range (mm/kasan/generic.c:186 (discriminator 1) mm/kasan/ge=
neric.c:200 (discriminator 1))
>   smc_tcp_syn_recv_sock (arch/x86/include/asm/atomic.h:23 include/linux/a=
tomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h=
:33 net/smc/af_smc.c:136)
>   tcp_check_req (net/ipv4/tcp_minisocks.c:927)
>   tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2245)
>   ip_protocol_deliver_rcu (net/ipv4/ip_input.c:209)
>   ip_local_deliver_finish (include/linux/rcupdate.h:883 net/ipv4/ip_input=
.c:242)
>   ip_local_deliver (net/ipv4/ip_input.c:259)
>   ip_rcv (net/ipv4/ip_input.c:573)
>   __netif_receive_skb_one_core (net/core/dev.c:6164)
>
> Fixes: 8270d9c21041 ("net/smc: Limit backlog connections")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mehul Rao <mehulrao@gmail.com>
> ---
>  net/smc/af_smc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index d0119afcc6a1..bb8966eeb332 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -132,6 +132,8 @@ static struct sock *smc_tcp_syn_recv_sock(const struc=
t sock *sk,
>         struct sock *child;
>
>         smc =3D smc_clcsock_user_data(sk);
> +       if (!smc)
> +               goto drop;
>
>         if (READ_ONCE(sk->sk_ack_backlog) + atomic_read(&smc->queued_smc_=
hs) >
>                                 sk->sk_max_ack_backlog)

This is racy. Please look at  Jiayuan Chen patches.

