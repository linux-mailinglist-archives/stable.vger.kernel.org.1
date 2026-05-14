Return-Path: <stable+bounces-247255-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UB+kBVsHBmrFdwIAu9opvQ
	(envelope-from <stable+bounces-247255-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 19:33:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 816085455A3
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 19:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80283300E3F2
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 17:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5F233F58A;
	Thu, 14 May 2026 17:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Ne7cNB7O"
X-Original-To: stable@vger.kernel.org
Received: from sonic301-38.consmr.mail.ne1.yahoo.com (sonic301-38.consmr.mail.ne1.yahoo.com [66.163.184.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5014F1D5ABA
	for <stable@vger.kernel.org>; Thu, 14 May 2026 17:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778779922; cv=none; b=OhVJ7s1gGeTiRacpZ7MgEda90U31aeXG6UWiljJeC3XSA73nMz1bRPkvuSyB8hzWzGQRtLPiC+GtANtwkxVQ89nlWTxm8z7JqDVzfNkwX8yM0+pcNzSirC5s8S8kPUJugFIr7jSRLhXTEkknN302YUQptM4ib8epel6Ddm1+BP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778779922; c=relaxed/simple;
	bh=e4j8oDUo7SMDEd23DYNwxIvhF/0Xnmro6uA3NQyoq98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=azOnjWXavgN5RFV8diQ4HRTROJdiW6x8a8E+XtexMvnV1LoUSQ10rO5hvtloT/7hl1D4cDiLSMeTZZspjW9MrLKIMGUTkZnNeGowr3kyb56nIt9HmQq6shAfuTckWVjaDCWHQbXYcI6gYVuR6rzxQFe+Dzh2T52xpOCgDomPDyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Ne7cNB7O; arc=none smtp.client-ip=66.163.184.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778779919; bh=i2vPqlj8KNEnBhS+nIteciS3u9mAPHOTQVqdtjqlIDw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Ne7cNB7O7WRis6l48cw3X29rSXSFRPLEr2feIt/dMw/eD7HSUmppI+GA2NTAIPBV2p1bVq4PwjTegpCmfaAQ7DGdZXc//PSEyOoTpYe7nOdnP2vqzIacjW5o+eJ5yk24Xu3zg5Pmut8s0YR+42PQAgMJKAjlMQawasXATMuLC7bmaP6BcbWd37aCo605I+PqMev/UtuDJo/cJMSGNwwz5TkxtRwZUAn5C07ja12Bq7QJZgbu+wobcUBOe+upuTnBKMcDBExMZgCkTSYEE6nRoVjbghKCGFvhlVufPqjSMeeUhDtoTROW8ZHdEzajPvZVEdu2QdSSUEdfAAXKHMo02w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778779919; bh=HJj5u+DvIs7DYYStJHOya6QlaN1o+6Y5HEVutCrbZm6=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=PLW+hcAkvZ7V+9IYC3bWGP/BvZhvTUmkh2CdfzXJak0dRZfpO1zdO7pbl/NUHGQ22M18Yuyht0Je/vF3bV91Z4Cc9J3b5nfDbAjAmzRCa5ggaIWdnRCZf42q0PWAoDOfDFs0r3EdIK3gvEK3CIBRC9RLf8xgehNzcwxkb2zuhz9c2AdzbL3rVcynAJ49uNOWUwg/kq2UoV5c7twqWAMPs7jlGMgAXa4RwJkvey1TKaag83z2FCL+lyDNXVz+6DnRkAvssGiPtwLelj/NoGfwEA21r2QEe7jPAwugPDLdTjHBan47OKExvwe5KsDPkWPBZmmviLTIhqbhUcgd5rWQNg==
X-YMail-OSG: ooYDRH0VM1mKc9T21LCAtyC_UUWWtrXGzBx1v5sn0QBPV8HXXO9dUEvYScTNBFz
 oKY_JbcYUBDeEBuBnpQ3YfrXiBh5neanPQazFb5v7OWhOC7JqEMtA0N.ssWfUSxazZsQ3lAJlPdE
 IHJdfvC3elw9_3up2arVvtOZyjoOOYnLiMZxPA2MnGDJuVP7uVmRmHxGowGotEiAjpHNPzgVgcod
 yiLj4AVSS.YSc.tRi8OeJUdJch4DrsSnqBhBxGOOppUws88alWWrlmTZSWr5ke67kghPQuKvCAWy
 NxnKgY_qvpVuxBS_scWXW.eQAXwYYavEeePgo0fM_GVoZEGakPSxmG1YFK7Uh5adn4IAFHKd5G1A
 PF1UQon0lpI59C2YGbSrijR4ct2uzmgFTfFJwc1mfu0_7oDdK25d.hsZW_RyOSFgF4fKliuSZEwe
 zfs6TrBitJwOKRT4a7P1HgWWHtKqO.rD6uaxK1V8iFHfy7VSXK7Xh0_YU508CggwdKrAS22Sf520
 WKNaeBAzpub9Gn6UEtJ1zyn2tNxAldXX.ic0oL7wvpxyA05bbjlWYibuA7928C5IC2vyUeE_Sdxm
 qRVeXF7ak_VM.M7QcFV8jv1cYxXK4YwApupRJtal1494xApO1dKaNEp0KG6iQ5nCei5TVPuDSf91
 .peBCUF_UdhIiqAk2xfNYiDUeTIDrf6sjkiVGhQpjUnI23kcXcEOEsGpBWFimhiZenDZ76kdMwqR
 6Dt4oLISVF0TwmluWmZWLqENSRm.m7s4J7BtxWZgNOQrDViPbrGzo9ZGT40WIAxcQpiZhWqycvmf
 m0T5tLzEX_q3UBRYedsFpbnFJiUcoomkvbZ5iBIaFh96apD_R2SajTSwCoK8PGApuAsqLh7hDYRj
 MKGpmpTUfaioSqcd0uRXgooh9LZeOBXVOORfwdiqK3rpid_V4t.IY2LtbeAmzd0uW0d7HnFLl8LW
 65C84RVGYYG82V_dmnXxE1d907XLfdcEKW6NFlzxVYK7WF5Fs5IYZvvwyEHI_GueKsSePSo0GCRG
 zYfnjlj9FYRqlPTPQE.wST6xmaILgKKqXZY2m1C3grxqHRkC3oLMSMjEuAo8xZK16dUxGxzG0TdB
 ki2Xo4c0TwPUwRsTH6_dLLsqYkqmMe6gfH79sCG8MPK4B94Z07KUtTGcEhOb7BXXsKTkC3TJ9oWr
 ObnARfphyXRrZ08JN38KbNeleFCBZ_4ZhGlxj8xEvQWR5duh_0F3OrRoAiGWLQh4wjyl9iXJ3Bke
 YQwBTt9P2_ZxuHFxjhKcv1RZszjiq0mpt6wfZsm6fBAaCWg._MCHB2hzfZjqHIm5wii7LGUk2r8F
 OAL3NXAChCBdhU1UlwJhoPVGeLPz2NaS5u_HZjD5XQPjRjkuMXPUTTEMQ46rO04OliE4lC8AlWW6
 w79ZrWJmRF3_9ceQwY3EMnjDNcxMU.S3zJ2PXi_vub41D_SG2HyWjJeYhSs47zgZQmZFevoUNgbu
 Y793zB9Q6NPeceGQQSTJOEqxtYv91iKHsLLKQ5vbwUZFKwN6AppBm.ZSjNPK4fJCCRsKzJZtpvXu
 xi_J.ScZGpx478qjcjej0ulbrJrqLX7LRF0e_06MaeCY3.JTdwUPqPW1MaQdfq1zyh4CkOnIad3K
 6ufarr9AcHf9cDcgoXVD6sxRJD15hErKiDma5vN.hi7utJTKWQi3baiXDiRaNlvs5EBo40U9HKVM
 fFB9AFdBfkEOsN4bamGo6ygkGqvIzatC1kTSmxs1tKgmaAhSZOS4Af_cUlbITO2_fh1PB7zcF_AO
 cadDvt9nxmJ_DfMabJwv8QE4tJGAXaurae.VgSGwJaRYGeUcEBSAftM_0LJZ1AWvs.zNaQkcaEl_
 aCsfdAza9l6wmAKl7xWNjGerDmXGa24C4O2PQv72znRZQAgWwdcuLVVI76j4C1lpwUnQDFBazWJ2
 u.PqAT9.ti3bOr8qcsL_0QNnZSfYp.RY87eVOOxylc8BtX8Px3F2_oH2VXRaKL2FdNYvPaz_gfc.
 GHGAfsHtDOjkEsVjkBNQPp91h6au7yoeGN33evu7WkOB9cJW1.GSACdFd3mlIgGl_cOVc9b9VmMC
 DnzzgwPLD2FyW7by0ssSFVY4w.TFLVhDnSXGuBrG5PpyeC5GFbBThSa1jiSlqJRih26eRqs0Zj0K
 rJi.AjEpObhDw.uIQjRDaoNbO.q27jnmyX225FVpy9oSQDe96msp5mCQ7o6WwxyGNa9cEi.cmDtr
 6ssgDS0WczxD7OI1buA6jo.k9kNOhtBeS6bPZf_cMNIvFWtuPWQ.mi_wnzbE3YQrRpyo.zcGZrDk
 21n8T
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: d8367289-f829-468e-8bda-437b31d418e6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Thu, 14 May 2026 17:31:59 +0000
Received: by hermes--production-gq1-7bb7df5c46-zj6qc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ee76f6b666610504e63d45a3cfbbc655;
          Thu, 14 May 2026 17:11:19 +0000 (UTC)
Message-ID: <7e165421-a688-4025-a33a-8eefbb84c4b5@schaufler-ca.com>
Date: Thu, 14 May 2026 10:11:18 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/4] netlabel: validate CALIPSO option against skb
 tail in netlbl_skbuff_getattr
To: Qi Tang <tpluszz77@gmail.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: netdev@vger.kernel.org, lyutoon@gmail.com, stable@vger.kernel.org,
 Paul Moore <paul@paul-moore.com>, Simon Horman <horms@kernel.org>,
 Huw Davies <huw@codeweavers.com>, linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20260514165139.436961-4-tpluszz77@gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20260514165139.436961-4-tpluszz77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.25725 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Queue-Id: 816085455A3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247255-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,kernel.org,redhat.com,google.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,paul-moore.com,kernel.org,codeweavers.com,schaufler-ca.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	DMARC_NA(0.00)[schaufler-ca.com: no valid DMARC record];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[yahoo.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[casey@schaufler-ca.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/14/2026 9:51 AM, Qi Tang wrote:
> netlbl_skbuff_getattr() locates the CALIPSO option in the IPv6 HBH
> header via calipso_optptr() and hands the bare pointer to
> calipso_getattr() -> calipso_opt_getattr().  The consumer re-reads
> calipso[1] (option data length) and calipso[6] (cat_len/4) and walks
> calipso + 10 for cat_len bytes via netlbl_bitmap_walk().
>
> ipv6_hop_calipso() validates these bytes only at parse time inside
> ipv6_parse_hopopts().  An nftables PRE_ROUTING payload write
> reachable from an unprivileged user namespace can rewrite both bytes
> between parse and the SELinux/Smack peer-label consume path
> (selinux_sock_rcv_skb_compat -> selinux_netlbl_sock_rcv_skb ->
> netlbl_skbuff_getattr).  The self-consistency check
> (cat_len + 8 > len) inside calipso_opt_getattr() is defeated by
> mutating both bytes consistently, allowing a ~232-byte
> slab-out-of-bounds read from calipso + 10 whose set bits become MLS
> categories driving the access decision.
>
> netlbl_skbuff_getattr() has the skb; gate the consume on the option
> fitting within skb_tail_pointer().  The IPv6 option layout is
> type(1) + length(1) + length bytes of data, so requiring
> ptr + 2 + ptr[1] <= skb_tail covers the option and its embedded
> bitmap.
>
> Runtime confirmation (Smack peer-label policy + nft HBH mutation):

I'm the Smack maintainer and do not understand what you are trying
to say. Smack does not use CALIPSO, although support is on the
wish list.

> Udp6InDatagrams increments to 1 with the mutated cat_len, showing
> selinux/smack_socket_sock_rcv_skb -> netlbl_skbuff_getattr ->
> calipso_opt_getattr -> netlbl_bitmap_walk runs end-to-end past the
> option's true bound; with this patch the consume path short-circuits
> at the bounds check and the counter stays 0.
>
> Reported-by: Qi Tang <tpluszz77@gmail.com>
> Reported-by: Tong Liu <lyutoon@gmail.com>
> Fixes: 2917f57b6bc1 ("calipso: Allow the lsm to label the skbuff directly.")
> Signed-off-by: Qi Tang <tpluszz77@gmail.com>
> ---
>  net/netlabel/netlabel_kapi.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
> index 3583fa63dd01f..4af8ab76964e0 100644
> --- a/net/netlabel/netlabel_kapi.c
> +++ b/net/netlabel/netlabel_kapi.c
> @@ -1399,11 +1399,20 @@ int netlbl_skbuff_getattr(const struct sk_buff *skb,
>  			return 0;
>  		break;
>  #if IS_ENABLED(CONFIG_IPV6)
> -	case AF_INET6:
> +	case AF_INET6: {
> +		const unsigned char *tail = skb_tail_pointer(skb);
> +		u8 opt_data_len;
> +
>  		ptr = calipso_optptr(skb);
> -		if (ptr && calipso_getattr(ptr, secattr) == 0)
> +		if (!ptr || ptr + 2 > tail)
> +			break;
> +		opt_data_len = ptr[1];	/* IPv6 option data length */
> +		if (ptr + 2 + opt_data_len > tail)
> +			break;
> +		if (calipso_getattr(ptr, secattr) == 0)
>  			return 0;
>  		break;
> +	}
>  #endif /* IPv6 */
>  	}
>  

