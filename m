Return-Path: <stable+bounces-254637-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KA8CHHoiF2rw5AcAu9opvQ
	(envelope-from <stable+bounces-254637-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 18:57:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3BE5E8136
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 18:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB98E301EB51
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 16:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB36449EB8;
	Wed, 27 May 2026 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PbRMvVuT"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BBD3EE1F3
	for <stable@vger.kernel.org>; Wed, 27 May 2026 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779901042; cv=pass; b=M0hlljxAwhFlvwVd79U3P+g/xl8nd+ZKsVD0g6TgmQvIXZEDvW+AfKXzrZtY9TLR0L9HuU5KNgqy2BziG6Sd4DJmWCWy6X9qrODnQZvoZsFIKxz7vu3OZYN90IHsgqkvlKDeay6djrGjt5csB9sPQdu5qyWbyLzfomy6Er5V0W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779901042; c=relaxed/simple;
	bh=Z05T0zzuGgs2Dk+zc9G9OUtO21E1+MX7cDPUhUA5R4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AAZ7gtkGWcDXCQtQaIEmaTW8VmyLr9FZfVCLxIMR6r8/5vh4vmu6NcP3wxz1hcpHYcDvZRx5HOqiOB33T580yt0B9DHAWL7Fg9vvFtj3U4dkgTxB25w272F7JoLJNIyeuHha/YWULpy9CUlK3HYf/ojNuPZ5Jhk1ZaqzE//dFII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PbRMvVuT; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-134fe980658so13689011c88.1
        for <stable@vger.kernel.org>; Wed, 27 May 2026 09:57:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779901038; cv=none;
        d=google.com; s=arc-20240605;
        b=Wj3rL8tJkpC+0CQNqdbCA72TMh79/7156CPVAEDIxwLmQR9EFSHSDRn77gA9oQNKQ8
         WOBadM6XIGq9W2O6m+BpvLUoMnmT9xv5kQkfYFfZPCvE9erQX0YS1xxxpI272ytov/qi
         XF4cl4TjOppJaEEdiqiNnx8pGNKnthGPLURLnF4JoXGEzvElZBU5x71TiTcZwg9qiG+I
         bRtx4y0HGE+jHvVbdANUnOKL8tThCACE8iK2tFIXBHvXtc4a0I/787CK1dRIFcEQ2OEj
         6QaJ3QnUOBAVAHpTxGiCcMwT+7CDUBU+RcNtkOXHJGynglT3L5WIPGGWO1DO3nVo/zJN
         fW6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z05T0zzuGgs2Dk+zc9G9OUtO21E1+MX7cDPUhUA5R4E=;
        fh=BJOlw6B3IkV15la9ndtqNJLdtqpcKCmndKeGkkKPIUE=;
        b=ZFZoiOXk3Vigna+NO96kBWKNHa0auSl53DclvxsgMLx2n3hzp6CNvzVHvClkPfu+LV
         zL2n0bjX2R1V5bPdm6XrjTR4WnNl7dP1J386/JPMVvE4X9e88Pi/IgNiT9JCKG7ppGwn
         TLCoEPQUdHuxpH7/Dqq8KNp/uVebUyg5En1nEIIGejnasgvI8/fhuPnsXHLpcB/Xpgzh
         RK2RpvOorjKtXKqD+lr+abHCZbLMkMISxPIC37EQINBEE6gUj6C+fVvuDO6Gj5l5pUxZ
         ZwniNjxf4S3u7zKRf/OKRPM1T2meYYbORYHns0mLV0Ls9G80AoQoyHhK1S9fF84qNINP
         QzyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779901038; x=1780505838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z05T0zzuGgs2Dk+zc9G9OUtO21E1+MX7cDPUhUA5R4E=;
        b=PbRMvVuTNN17QWEZFtIoOqYV8hOWpyzMDV2ktnr9RMrVdU4SegvugR5yZnbss3bP4a
         +y0jtC81Merk+3t1i3tucC3k8qgWe0EELjUtlkIpihiyu+rN1GMytwYeQ0Zfl1uCbRiH
         OjaoubTTDB8sUMCcGUnDgAUeOmuabPXUltllUxSSN4w5QmpizzFY2/qp/ezbqoy1TKKL
         VFYW9WBalaSB3ar50bztsslfjeNHYmmQOgi1Y+t/0ohXfNKARCGjLjFM7DXS9X3Rufd8
         NwZRZFkK6jX4E4wmGHgDt+Y7DNwYKVzz4K0HiyohMWC2BdfmpqLc2bufp0EnaLxCEtCy
         qgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779901038; x=1780505838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z05T0zzuGgs2Dk+zc9G9OUtO21E1+MX7cDPUhUA5R4E=;
        b=oHfPMVr+0HofY9MrW8+eFGuvmpvNbGJ5Fe0KhKkzuWORPYJyIJlTQ9GzkhLdSUkYl6
         YG8tssE8XZLdmv0RKJwbVwaKd2MyEoFbQc32yYedW7VnRCPJlctGOL9Mqod7TvKdxSpJ
         g9Nkl5z5K2DJjUgAr30AI1vY7YfZ6WWgJb1YfqOk4t+Pq+1EIp66lHsInzftwMlT27sf
         Y/3cAn6DmN755IE/z2KUBkFcKtQoNoIukBkcRxeCPtz0RD6KMVG1xAfgHgSIGhUSl7BW
         0IDF7ginwndM/eaHKJc7qmmT5cWN3xUG3NjS8fmnvLUJLMjbWoK3g+MhpLDmwmD9zjVa
         HQQQ==
X-Forwarded-Encrypted: i=1; AFNElJ/IR9Bt070eaUTxDAQv0U/b5rS4RDgRVGNQIHDqWnr0TnKzo5VdUlFZr8Gg+lH3ozMwRH12+qM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlJ5yY6HZLpQy5oc/3DSkLm0iTvOwx5xH0W3lvyINDXU6jYSin
	hryqwkob6SbIfDfLXV1nylST6hn4s8nz1JBSAU54i42g8CD61tvN3RYlWDq+6K1DI4uRrIkuR0K
	PtcitYMpGkovaogY3Az8QMqh3fgLA6axsqwAnX/sN
X-Gm-Gg: Acq92OGomQdiNY3P7anbcsZj4rq0qfWMJuwQQuiQjQelrNl51CHLfjzddc2yhNFQii/
	2jkyfAlL05TKz6B0u0c3bjTbyFtO1PHKs3v1PQHpnPw94qaXl6lF0ZBn1/b+YRGLzPi8iccUm82
	Mk6muYY6tOPrnWGkBLNbABgjmpEcgUgGzf5fcsBum0a0ixrDimx2vxpM6uWjmEGHOuoqchf7vWs
	BE+1ccvWZOY8Odm8y0SYm1zA+vwgPCoYiGyO3D23U1lFTNSH2iCy7mf+urt9TsUCVqMfx6yaRK4
	Wtvp8JEYdxo82TWnnt0smKUcvh8hKJLyQalNTq2FwotJumZK+oVsc8LIESXKCme5SMdcmEVINRr
	CThwfBx86nxBua1V02etWIrSPDTG/i1WOBhXtaDJLwxukusQ//2sGjfUhMXef
X-Received: by 2002:a05:7022:f313:b0:136:9ebf:3bef with SMTP id
 a92af1059eb24-1369ebf3d04mr3012302c88.26.1779901037600; Wed, 27 May 2026
 09:57:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527070824.2677331-1-maoyixie.tju@gmail.com>
 <CAAVpQUBKHhj6h5Rke=N9NyeUOPvVB0RKJSr2=HPkUKgAqQA0Bg@mail.gmail.com> <CAHPEe=H5SFJN-=EFggXdNreN_A_LE2r_KHrpWU4UxJmq+g-bhg@mail.gmail.com>
In-Reply-To: <CAHPEe=H5SFJN-=EFggXdNreN_A_LE2r_KHrpWU4UxJmq+g-bhg@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 27 May 2026 09:57:06 -0700
X-Gm-Features: AVHnY4KXZJh3_daTaI1GRlZxzUtXao2DeA-jBJnu5zellb47mGZrRVVa7CWHdWc
Message-ID: <CAAVpQUAp8pvg=s0K3QmkN62Osat-kf+4XPosfgbBZ_avzZR04A@mail.gmail.com>
Subject: Re: [PATCH net] rtnetlink: Require CAP_NET_ADMIN in link netns for changelink.
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	David Ahern <dsahern@kernel.org>, Xiao Liang <shaw.leon@gmail.com>, 
	Nikolaos Gkarlis <nickgarlis@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254637-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,redhat.com,google.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1D3BE5E8136
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 2:43=E2=80=AFAM Maoyi Xie <maoyixie.tju@gmail.com> =
wrote:
>
> Hi Kuniyuki,
>
> Thanks for looking.
>
> > Do all other callers of ->get_link_net(), dev_get_iflink_dev()
> > and batadv_getlink_net(), require the same capability check ?
>
> No. Those are read paths.

See how netif_change_proto_down() uses dev_get_iflink_dev().


> get_link_net feeds IFLA_LINK_NETNSID, the
> iflink lookup feeds IFLA_LINK, and batadv_getlink_net resolves a hard
> interface's parent netns. None of them mutates state, so none needs a
> capability check.
>
> But your question points at a real problem in my patch. get_link_net
> is the wrong gate. For the ip tunnels and xfrmi it returns t->net, the
> netns changelink mutates, so the check is right there. For peer types
> like netkit and veth it returns the peer netns instead. netkit has a
> changelink, and its peer usually lives in another netns. My patch
> would then require CAP_NET_ADMIN in the peer netns for a plain change
> to a netkit device, which netkit does not require today.
>
> So the check belongs in the changelink path of the types that mutate
> t->net, against t->net->user_ns. That mirrors the ioctl side in
> 8b484efd5cb4. I will send a v2 along those lines.
>
> Thanks,
> Maoyi

