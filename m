Return-Path: <stable+bounces-254769-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMIqO+/4F2qTXwgAu9opvQ
	(envelope-from <stable+bounces-254769-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 10:12:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 573565EE572
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 10:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4E053019826
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 08:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6995368D4D;
	Thu, 28 May 2026 08:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ookPXggQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EA6367B61
	for <stable@vger.kernel.org>; Thu, 28 May 2026 08:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779955503; cv=pass; b=tEGh7EpIRkbVXRz9MRPDShNzy3s/x6YZ4bGFDIKk++bBVpklEhlcp4lEIAHbkoOy3NZNjJQPDk1V1TWnOUEApbzfEOE1QKZcGJkNHhFlpaykx/sWXmeHHhe3VYJK08l82DdWKf9PhQN0ceapPXb/dgv7rRhmbVfYzutx82nmSZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779955503; c=relaxed/simple;
	bh=KRbyLL93HFOeDXI8HX7+1a0qnJ60ZrvrzlZlIINQotI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGK62g43OM6Z2QSmDgNCDrUOeSYkam6SgAwfCn6OJgzZ2tCyQ4zhoaSXN7dNsSmO8MJyir62LjkXSKO+dCqNCnFPYrPPRhKn5vZ5xcTn4CqrqvktytLeMvVubnACL+OKthk7PXlqI0iLsdG8gY37bWX8Dm2iwxcSkHKxkFKp8nU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ookPXggQ; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-136b46c3540so5272039c88.1
        for <stable@vger.kernel.org>; Thu, 28 May 2026 01:05:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779955501; cv=none;
        d=google.com; s=arc-20240605;
        b=j5KM+rbeRE3Jqn9BjYgZkPDCX4KmGgcuoIhWDgeysDpi1h3CTwKGOKxP/iZcHgZ1zN
         X3qHevbhHlxnqsz8twSs8a0uS30RLo4hF+Ke+hF/BgFKse7ZBTHvU/IrrvKLUr2/zt0m
         VV+bRENCD48exR2FTc+i7A+0wrbcLqkC6Th3KADUoVJ+au9gwxkfZ+25ni50rrBzciKD
         6/RYyS3/LxJ2GvVdB2iPF/PE7qtjuYaKpbxxe0qdfF4eGLInK5vJS5WQNA7neuL0wI5t
         mN4NqLSxUAFE+m2Xqf70yzq/iut7nEtHrrwc35lQC28qZipk4fk5bQDV4uOAtBEF/Cq3
         NbRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HJfOIh4KRJb9Fi/Phv9TqmuKbBE21gJDkIwmd5iAe+c=;
        fh=kM2QD+JpwRkOZmCvT5j2VjYtSn5Qf9Rinc8TaxXEzVQ=;
        b=TueJo/8yHjZi0E7p8mrxvOkKrTS3kas7Qvui5q/tbq7u0Q9o/oTk2dK2TehDPlb2w2
         tw3m+PgVLEu8gKGLDinw4wz1xDnlhijnowgKYJ8XgQu9EcSp8FA1/RkRb+F2Jh50kyYB
         U2ulZF/rOv6FZmJOFZZIk+MoeTsW/PU1KOsZxy3zHCfgn/elhIU4F2CDbYUI+VpU7zB2
         nJCkaFVKGXewIL50dNU+RCPHiz+GXC9hHa9d67r3G0RD7w2/05XEnflMD6869ipSGN5G
         1c4LnNcM6iioOP8M6omKZWe9UHRDMGeXubaMk7ZktioDKfX+CScNnDAc6p2deW3QTgeo
         7BZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779955501; x=1780560301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJfOIh4KRJb9Fi/Phv9TqmuKbBE21gJDkIwmd5iAe+c=;
        b=ookPXggQgSdkZaYnpSsgzxy2tAdSNmD1DUl9MmmZVKj747lak7Dt7kT7n2BsuZ5q2h
         fU/U4XQ1+oJW+CMNLRNdQhKlRPzpIfWHuWzn/zYgfVkKso7jK1aT0qZ/jKITW/DCRa15
         Q0i4NWbkkJg/nW8RaAHXE1E7vFdxCE0wABKbnDRBWsfAQM7wApbn+2vDvDw3Q8vttvj1
         n0Ew+B4FYI4AS7eL+7YF2v2XynBtuNBFfOgc6itODDa6rvgMEjhm3PEcXNLUhIhGuOTN
         VN00Q4f1OaCFe8dBBJIuvL+NvHxhOIfCPGsCW5X45inGcbLI8dbarSm5UtSAPFCFgRRk
         XniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779955501; x=1780560301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HJfOIh4KRJb9Fi/Phv9TqmuKbBE21gJDkIwmd5iAe+c=;
        b=jTQwmb9lTeN8oC7kes5jvsGuY/tnFk+kPmeXI4JfgwqJ4W71zqJbFQOY49h1KajO+r
         IaL6lF4YY+ZzU/d+SOqTnaDUl/emcQOwpkdDIH+SeUSengeJzXnJgLVarX7KakU68rvO
         3xb96rprZ7a0ByGLt88qt8m+EaPm47QymxtaePUlK3aEuDJ5tbQmhqfVhS9pNYHeYoUo
         /559/ds9j44SXY0Lwy22k7OfqXiqUnQMXuYtNZhGFoQpVAlgAeOgCS//0qlI/ypYKbrP
         BCXynN625diEesuOtu5K10eSWpUuanE2GS9U5q/swauL2jBIKoZUOG2q1mJizoU1SGX6
         5jCw==
X-Forwarded-Encrypted: i=1; AFNElJ92otG5e8FjgvfvOQz4vCGO8RavwYK7/urW/fbE8Nl7/2hXDqwPEPK8qhMnifr4HCbR94LY/RE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIwQ67P+OV66Vup7Y6hTNifpfh8rssIBCo6hz/W2Z07RTtm4yq
	awmhgYOiCmHVoGOQjxeXolD1QL7oOQwP2iVT3TSx1A1proqpSF/hm04sZLu3QbT0n/9Xo/Ag1oC
	gcuffWYDTsO94zn/abPsz1HTKfFIBQSOto3ql+Un9
X-Gm-Gg: Acq92OFKp+0+AWDkbG5IhNcVhtO+YMdykPRtmMVdeF2RN8iQGMe9kjSSI7ZtZXCj5f/
	9hruJ3jwofrz/u4xR9YeAIXZOjf0i1qhe3Cld2R+xrqXCVFw8z4NNYRj5KwSkiOK5tuOq7P+dAD
	8ObozFauiOQquBaXEKL6qe7SaxNAzTSQPJu2Gtn5x2FXir3lxZ9t7zJWIqKsmce2mjDDtO/aEAf
	8ledcEfIKYYfT1X4esUggHvz/wKmD7Imn/svivOprTny0Yh4AOld5DdScc5m5DcM08A8VdYGYdM
	PWGcBUgfeafxoGx4FMHloA+KH4k2Hufv+ntgkVgPEgrMhk4OrNo2Mq15ciNrp1OLfum003eMXHa
	xoYwpDY0LLl9f7I54qvJU/dq2rgPBBF+6am/U193uhzumFUVJ4FduNeZiuq8P
X-Received: by 2002:a05:7022:48:b0:136:c77a:64f3 with SMTP id
 a92af1059eb24-136c77a6b4fmr6992851c88.5.1779955500587; Thu, 28 May 2026
 01:05:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528073614.1169858-1-vulab@iscas.ac.cn>
In-Reply-To: <20260528073614.1169858-1-vulab@iscas.ac.cn>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 28 May 2026 01:04:49 -0700
X-Gm-Features: AVHnY4IcFEPUl3BCCt8xH4egeGxTpseLue9B6WUPH05zlrzruz2LwLDKXI_Xr2A
Message-ID: <CAAVpQUDMK=uY16vwCDjC0hN-BCVAD++WGpJgJrmmNKtqQFJU9w@mail.gmail.com>
Subject: Re: [PATCH] netlink: fix skb refcount leak when dump start fails
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kees Cook <kees@kernel.org>, Feng Yang <yangfeng@kylinos.cn>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254769-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,iscas.ac.cn:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 573565EE572
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 12:36=E2=80=AFAM Wentao Liang <vulab@iscas.ac.cn> w=
rote:
>
> __netlink_dump_start() takes an extra reference on the received skb
> via refcount_inc(&skb->users) before storing it in cb->skb for the
> dump callback to consume. If the subsequent netlink_dump() call fails
> (line 2440), the dump was never started so the completion callback
> that would normally release cb->skb will never be invoked.
>
> In this case, the function returns the error directly without calling
> kfree_skb(skb) to release the extra reference taken at entry.
>
> Add kfree_skb(skb) before returning when netlink_dump() fails, so the
> skb reference is properly released.

Isn't consume_skb() in netlink_unicast_kernel() the one to free skb ?


>
> Fixes: b44d211e166b ("netlink: handle errors from netlink_dump()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  net/netlink/af_netlink.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index 2aeb0680807d..d904c1aad35d 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -2441,8 +2441,10 @@ int __netlink_dump_start(struct sock *ssk, struct =
sk_buff *skb,
>
>         sock_put(sk);
>
> -       if (ret)
> +       if (ret) {
> +               kfree_skb(skb);
>                 return ret;
> +       }
>
>         /* We successfully started a dump, by returning -EINTR we
>          * signal not to send ACK even if it was requested.
> --
> 2.34.1
>

