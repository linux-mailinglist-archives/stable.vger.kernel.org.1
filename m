Return-Path: <stable+bounces-268577-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1eAhDjJAPWrv0AgAu9opvQ
	(envelope-from <stable+bounces-268577-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 16:50:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8239F6C6D19
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 16:50:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=drDESDEZ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268577-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268577-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1318B30182A6
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 14:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2196F3E5A30;
	Thu, 25 Jun 2026 14:50:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D8036D503
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 14:50:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782399015; cv=pass; b=icKnjeEwz4iyIqvxiwWQkiipgGQ1gRxEWMXYPqJlMa2SYfC87Qdkp+JTWt78jOozoa7qZs/EDia5P6nWZC0uy9SCPYzMTrhecnI4zrh9MqPObHDVuWPN6Ce/+tZ9UoJCUfZ6Wd6JYpBtCtYx0v+FeBd14GvI/klJDTP9tX73lJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782399015; c=relaxed/simple;
	bh=GI5tVeQv87M6l+52amLkQdtG+5A4bT1WM7+cRRv8Tow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cCxOtyJgpSU+6NLI/AgVMEMGgobopJHPQSOibo7RN7PTj3LDaNb9uRjtU1ECndT6ngi4JJIab9BOlQx+/eoJL4+u/mzdv2MB2UyGWznza1hxLp6Dkdp+L8HSdRyBWSKd1aIf8/ba/4lfxmBWgKhddxxzt8a+mdo+LsUmt5pAVc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drDESDEZ; arc=pass smtp.client-ip=209.85.218.46
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c1217010b15so62946366b.1
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 07:50:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782399013; cv=none;
        d=google.com; s=arc-20260327;
        b=OBq34sUS2jwsiY0URA+bZryctxReNNe/np2zAiyqzJnoAtzrZ9mPdzDvmm1MvkgX8z
         BE6S9G6fEHdxZAutr+0/v3IUoVwMozdpu6ZLMfpWWiKbYiX7UPDcSgp8RW8q+Poucr9B
         /Se0gkmj0KP1ADbwLGI5UyFJYiz6akPb8ElLLjcC9dO+DktXTOKO3dBDbUDvFcXCL6E6
         p4yHpn25WucwIgnN2vIXRw5YZNQx665EPkmSbvPKASD93U4Rklv5d/scCU8nxSe2MMZ0
         nqVV8zua/0WNb/zxAa7lB9MIjHcaa7ACFYPxVNuX1gaZoWyWhdGjWVMx/+UhbUn4NtRx
         8o4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GI5tVeQv87M6l+52amLkQdtG+5A4bT1WM7+cRRv8Tow=;
        fh=MNx8v6NgwvlueTMLRJM983Y6u26q2AgcSxJY/lh7qTM=;
        b=ooTN5Vg4lUFa9g2lCUWGHI2Z++lHYrm/MN+jypCRqpI6p6ZI8sBDUp0/4v58dGBzTG
         SvGmjJtaZsezplcXhMFdjJqGeq6UaoAUTew61VwtBskGnemiJCkFplbyxkWUYa+KTyMn
         YQ67ur1xctUTANlSqe1gUEXMArNS3hq+Hu/0ywVKfgRDS4GSBFZ2Jj6+KA+QMj+CYfJQ
         2VCzpgrtqTwzOz7JkW+cljqmkm9jTUhe1Kk7p3qaR6P31WELi3pG0+duHlRpFtDr+sF4
         tgDBhHyZ98u2DiPBIrEUhH4QXF8YfnhM/0eoFZBQRoK7QDXsSMd67iDuK7N2Hf5TNrx8
         urEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782399013; x=1783003813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GI5tVeQv87M6l+52amLkQdtG+5A4bT1WM7+cRRv8Tow=;
        b=drDESDEZDGVECP69GsOf/aVzERtoJmC7Tgz+HZodsdcOLiLLIUOr2C81KDvVEXCg2e
         07k8cVx9aCR0ZrZsl6Zky4Tm1zANQxx4OB2jrptqkb+LJxMS5naBrJ4dDaASKAyWnq/S
         NTrsNWFHEntqm1Xlqnb4ea7pkhAOs4/PMklJ1cFWJiKjBGqar4BfoaYgHRg1I/9OtRmB
         D1wtz2+LvGGhg7+iS+cC1CcwHb+ocPVysR4HYG6lEy5MuMYD9AWHFwP8GZyLPnLu2sxK
         rfl/ye4MuxMvLZ6dKhkThQf4ad9ArxqtillOVDtjvPW1FaxlPyYhtQcmhuGZjiL/uTKF
         tXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782399013; x=1783003813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GI5tVeQv87M6l+52amLkQdtG+5A4bT1WM7+cRRv8Tow=;
        b=Xb1NayK9G5tKqBLNgIx0/QQCyEn5jicM6pcFwqI40lPlaa8PjGNtklsJX/02slfCmP
         E+CePPVlhWicd1FrU0a+ac2kPiH8r3EJFwLwxRUxDhf3G9lCJhptszrrZWmsaegb/ame
         3eHfURRstZG3UvN0WOa/TEH148NVeNxMnYbsWYOmyt6FneYzg1AUhiKl31seqssEoVtk
         Y7w/EBR8FubA6C4iryhmmopyEMoUaor/i3Y7YlCsuj8ZWAf4l6q6y3V6awkXUcFQ5JAR
         GgRRFenyqJpoKhebo2xS5sn/WCPPUpqNv1wO67qU8DTWOcJzD/SPinAJpIvaeODC8cNP
         JAyw==
X-Forwarded-Encrypted: i=1; AHgh+RpoX8QJ+t5LW9GhwQJA+1e4N8/y6LI/fLAGAOUWQhu0eUStMseHoSXAX9R3EbCvNXgFd2bybyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMkp6h6iKuUrZq1wDogHEXeobJMWdbGWPjNPBdnvXMF7mrO7aB
	tPhBJ3JZPlJ9f7lWcs/LRH389xi7QQanftYaVtU+XiSdLjxW8emP3XjURmHK7PvtaFmW4CZ/AHt
	BtB1+ppEa7W9bQEOiX4+Ev0zIJfouyt8=
X-Gm-Gg: AfdE7cnZMtqpC3sWUU8vMkDwWneraENR/n04pm4KUUyPcRXmOlcdd9NoelWzAkzXhiA
	iQQ+vfAhk5wruNLy3W/0nvtxsNdTmxS3JaYpw6ETUteBN2KWp8Yj98Y7XcznONuSxYM90tYtDnv
	dDdh5cg3z1zHjBwZEAyWWdNg0yH6tDqL9MJXLYGflEUumM22jn393LH01PULgDiyYT8uiFk/dyF
	5E6YLzaj7xtjz7s2ZxkI4RWRmChSjzG/vWfvpfWq5B1NQ5Ulz5YFjbM2pqMaf3zFgO3YYw=
X-Received: by 2002:a17:907:8b95:b0:c12:8a:7d7b with SMTP id
 a640c23a62f3a-c12008a8cc1mr211733066b.1.1782399012826; Thu, 25 Jun 2026
 07:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE2MWknz4X_gcNo6jkR87Lg8F0zfubkOc4Ujr57CS3aBMWrjEA@mail.gmail.com>
 <20260625054005.0016.bridge-mcast@kernel.org>
In-Reply-To: <20260625054005.0016.bridge-mcast@kernel.org>
From: Ujjal Roy <royujjal@gmail.com>
Date: Thu, 25 Jun 2026 20:20:00 +0530
X-Gm-Features: AVVi8CcTT3l_BpCVPjAw-OuIdN6h756FNAzVYw4MZY-iVizeSs0vzY6v--L1Ouo
Message-ID: <CAE2MWkn=azz3gUKGBYc1jjvVnLxDHuHk9M7wAJHdAW8v=dP5GA@mail.gmail.com>
Subject: Re: Please backport bridge multicast exponential field encoding fix
 series to stable kernels
To: Sasha Levin <sashal@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>, 
	Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>, stable@vger.kernel.org, 
	Greg KH <greg@kroah.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev, Kernel <netdev@vger.kernel.org>, 
	Kernel <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:razor@blackwall.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:shuah@kernel.org,m:aroulin@nvidia.com,m:yongwang@nvidia.com,m:petrm@nvidia.com,m:stable@vger.kernel.org,m:greg@kroah.com,m:gregkh@linuxfoundation.org,m:ujjal@alumnux.com,m:bridge@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268577-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[royujjal@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[royujjal@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8239F6C6D19

On Thu, Jun 25, 2026 at 4:12=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> > Please backport the 5-patch bridge multicast exponential field
> > encoding series (726fa7da2d8c, 12cfb4ecc471, 95bfd196f0dc,
> > e51560f4220a, 529dbe762de0) to the stable kernels.
>
> I tried, but it doesn't apply to 7.1. Could you provide a backport please=
?
>
> --
> Thanks,
> Sasha

I will create patches on top of 7.1. But tell me what about all other
stable releases? I have to create patches to all stables and how to
share the patches to you? Via this email or any other process? I am a
fresh on backporting my changes to all stables.

