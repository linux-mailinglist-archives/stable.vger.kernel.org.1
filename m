Return-Path: <stable+bounces-241333-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKfDGo1n72kIBAEAu9opvQ
	(envelope-from <stable+bounces-241333-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:41:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FED4739CB
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0857C30015A9
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 13:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8353B6C03;
	Mon, 27 Apr 2026 13:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GGsfkhVA"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0076F3CBE6F
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 13:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297285; cv=pass; b=cvuRSHKA+4QmoySvQT1zChdisGWP1rkIeL482iKyb3omCX46I9G8YnefymqdHYAdzYk7k2TvJnXSDUP+Spm5zrJV80mA7TbdUkfjVgfavy8IuBilT7LxagFCBQGPdgkyeZ+SGx610EQoIvh7I0JHj4Qe24pCOHJ06rW9kOa/M+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297285; c=relaxed/simple;
	bh=lDwVllbQSA8X9zgfAN8DlArVU8Cq4nXmpmYJl1ES2cQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VgxX2s9vEOAVbvCb3NPO/vk3ECv6IavrprIMv43rqqT3iVbnnvffXXKSAL3+UF4WJKV6U/pZOil++hMlQPwLbv3yGKoHBtDo7imW3rbejG6c1pJWMax4AwPyAjvB8YlviN2foX3TMyjxIneFkD74W5kKxOAjIpamR+XKCq55OM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GGsfkhVA; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-679b072ed3aso4882691eaf.1
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 06:41:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777297281; cv=none;
        d=google.com; s=arc-20240605;
        b=M7zlc9Z2Vl8kOdyWf2GG7OlgQVgRZK4hGm3jvEUkyYQ6JMfgqslBudS3J7Ue7FNlMK
         73ORDRwoQSnbGXy1Rv5fCCDEPLa0bac12FoqRf955nLNmHR+ARhpBHyfZ2giSDL1geou
         +Z1jUnmPCZUVET6BI6khbk6hydFFyvZLyW4j6tWLmOcgedKnYz7kngxaBnSfJJb03ODs
         8oO/pNjntbYlPxISF3VpR/rh62uUlJJxNYjyqVvFjVz3pgzyGj3Md1uVuvUT7e21GQSB
         2GO+NFDrvzWO+o+pXcgjJAfVJ1GUhNmml7PsURqXOK5F17yfPuH04oCPeIJn2+t3joXp
         RXRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fwyr/KMD+0QPgey2JMgc1xj/yK1FRCHF8OYBDsPQa/o=;
        fh=SHclFfwPDYh9OOepTozwEY/l6tT4c4y7OuWNek5Vf5Q=;
        b=WgzuAbti+R4JHFKd4uPuV3LFUh9JfhcRVgdvVk2RAb5IlMgqMrFMK5Ec495MRNAM7c
         QhS2NW4cO9UDYACvWICbzWYv9YIORD+DXoEak2PQxddfgj9UXa/YjZ3M8Krwr25nbiM5
         +Fxy1wq8oPhOY4YoUTn70olrTL5eyzI5SIFVCEnM9aj51TpKqNHgNxhk6LlawEIRolHg
         HNtHgX+3lOKv+xbLwiRkUJv+Kpee+9LESBSAx10ghYRGMNNy+7nnBNwtRCeeBqQKWmdr
         XafAZj5aHnXqzpm6Yq1pD0YWi4tLeUbY74uiCBKwj/BE6lk7osB+u3PwFbhj1LnbQwok
         iKiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777297281; x=1777902081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fwyr/KMD+0QPgey2JMgc1xj/yK1FRCHF8OYBDsPQa/o=;
        b=GGsfkhVAhJG870PKMDg/5RZVG0Eg9qzxzkre2MdL28gdcFqUSrdijlhcvbRpXS9htT
         pRJr5ulHrvviXNlAIJtEKdFbM+KTwstnzngIjPmFinBc8GEJu/jmp8a3zRwG+vq0Mp2Y
         XbifYJJtANWD8TPjIfxb4AXyxF0r4b7ZE2Z9UMzVNFt59H4DVJbbAFfmBAJcE6BDoU/x
         n4cn6NMdWyhoScbyTGOx7l5NtrtInAdt2i/q6cij+tt0r6a/nVOukBPQN9t/QbBExh9n
         ECucIiv79VndUEpHfzOKYZezz2RTOhfKbgia2i/ogO5uAHqM8/yqbOyBSZ5NJPUmBD/P
         ao4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777297281; x=1777902081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fwyr/KMD+0QPgey2JMgc1xj/yK1FRCHF8OYBDsPQa/o=;
        b=DNFAob4OwMHPcUp7hJihN6CDiR4clDUisKigT12whBkLUE7/k5CqK03y5fAiIjadI1
         YkeVfiCwkUC7/IyqFi6ixOfIEWZp2hNViN+llQh3vC67VxZrXX4F8raJNA38um2Akdjs
         B9DSejtYRYXIsXoP+Es6QKj7xwS2z6cKGFXvQESJPLRBnEff81TczXTBzIBwBH5+dFFu
         7FkLm+XvzfvbV93zFcwiom4Dldej0fQUHi1Ucrp9A5RttQm1fXmPEtsrEsjnV2IK/lWm
         l8y7pRdJn7CKZ0JUk7eZoYz8WFSWUrJCgRYtH/G3PU6FyW6gUBF1mHipCZ633RjkXK0D
         7d9w==
X-Forwarded-Encrypted: i=1; AFNElJ/ONXMEL7tA5Mbzh/K4ycd5/OyeGaRDmPK6p/FWQSRJY4WOsgSorXAy7INBebr7zxpNNVYbKww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlvOuASK0NwNWuXLAGDHKgAPg+1HENtOLlg0PAgTz/p/mr1HUr
	h0537BdexRZgfDfosgNFaZPYRm4IFo+6KH2W+CcYnPlQ+mPEYf7iSAvY71ygFxbPgxUjtOc2USA
	jaIu0m+oXsQm8sCbpMmD/LSr+kZactkuF2lLrkAzQS7LQ1sbzxpKbY4g=
X-Gm-Gg: AeBDietrGvl6z5N9fQKm1nwgxQszEdskb8dgPx5QX0/OXik4Kx8FY+oZv+uugZrcXJv
	SC8uoj7I9scQkxTPiQBYgFLyp/LrupTtOxNgrq1gsWzxXyoqLkf65dLCKba6UFN8+rbbMeQFyKd
	xIgatmJn9aooUZTAA0U96NqPP8UScAeu2zi9Oqtw54Gs1cWZNnsebRgZwgr1OXvOSrnpkHn/pwk
	1+BHV2XFGVNB9zn+Ak1rh22oBVxY+RS44gSxlv09GgJ1tcauXMmWMjjtg2HBtOLTJgnf8I2kcGf
	emlFjRxx+AGf36z1RTGBm0w2vQ9LxCnAQWygTQppjnnrAW0i
X-Received: by 2002:a05:6820:2d04:b0:694:a02f:75ad with SMTP id
 006d021491bc7-694a02f7af1mr14774938eaf.59.1777297280605; Mon, 27 Apr 2026
 06:41:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408155203.817744-1-g.osokin@auroraos.dev> <adyxWXpcxJ3f0w6G@sumit-xelite>
In-Reply-To: <adyxWXpcxJ3f0w6G@sumit-xelite>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 27 Apr 2026 15:41:07 +0200
X-Gm-Features: AVHnY4KGDDzcbe_kY_EznatCHWqSNW-a9BNkxArEfnRPZk4daViwyL1DENi3efE
Message-ID: <CAHUa44H2hsPfBFvQwiC4DvSaZ8Lag8S0aOy_KTY5z+b=WQdTLA@mail.gmail.com>
Subject: Re: [PATCH] tee: shm: fix shm leak in register_shm_helper()
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Georgiy Osokin <g.osokin@auroraos.dev>, op-tee@lists.trustedfirmware.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, 
	s.shtylyov@auroraos.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 56FED4739CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241333-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jens.wiklander@linaro.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,auroraos.dev:email,linaro.org:dkim,linuxtesting.org:email]

Hi,

On Mon, Apr 13, 2026 at 11:03=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org>=
 wrote:
>
> On Wed, Apr 08, 2026 at 06:52:03PM +0300, Georgiy Osokin wrote:
> > register_shm_helper() allocates shm before calling
> > iov_iter_npages(). If iov_iter_npages() returns 0, the function
> > jumps to err_ctx_put and leaks shm.
> >
> > This can be triggered by TEE_IOC_SHM_REGISTER with
> > struct tee_ioctl_shm_register_data where length is 0.
> >
> > Jump to err_free_shm instead.
> >
> > Fixes: 7bdee4157591 ("tee: Use iov_iter to better support shared buffer=
 registration")
> > Cc: stable@vger.kernel.org
> > Cc: lvc-project@linuxtesting.org
> > Signed-off-by: Georgiy Osokin <g.osokin@auroraos.dev>
> > ---
> >  drivers/tee/tee_shm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Thanks for the fix, FWIW:
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Looks good. I'm picking up this.

Cheers,
Jens

