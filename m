Return-Path: <stable+bounces-204523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E40BCEFA06
	for <lists+stable@lfdr.de>; Sat, 03 Jan 2026 02:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10ED53017844
	for <lists+stable@lfdr.de>; Sat,  3 Jan 2026 01:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D9318C933;
	Sat,  3 Jan 2026 01:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9W8Aquu"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316253A1E89
	for <stable@vger.kernel.org>; Sat,  3 Jan 2026 01:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767403941; cv=none; b=t8JMjQW5UuXd6DwtENMJ/HrPhqCtJalg+qFJJf/Au+zpDjWNmqvXvJVhUJ+ClOKMr0GjDclDG7Gjm/T1yoE2NK3at5d3ELdoCsQr2PwPCrUM/JGhVubYYdtQvIQGxXi5k0FilVK6lD24zeoQqTgbl2vaggeO7V2sS4nb12RnMOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767403941; c=relaxed/simple;
	bh=JV8XFdHWMBRmFefTCov3/mUZHAM6NVwKsiL6hjJKEjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPptiSN1vEiNGeqDVJLatdgQVNnJcJrcTt3QO1VUkaDywrF4GTLY0p7w2FmOpY9guXVrBWlagPt0qpAZ2xkUoSaDAFw5T/j7JekB81WbXejNPTQx/ODmfjabnOhkNENb/JPt1Nr3sXRwtH00mHEnqli8d8UnSyiXKO62jsYVNRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9W8Aquu; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64b61f82b5fso16790808a12.0
        for <stable@vger.kernel.org>; Fri, 02 Jan 2026 17:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767403938; x=1768008738; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cwsZSYzyNbZUR5BkMc+fuk8/uVN1U0fMZDUnscAqpM=;
        b=F9W8Aquug6Ym4C+3zL3HKeNN6Fe7cqQ+yoRPpshtPbo52csCs8cBSwjhgFDkMhNM29
         vDXp5wjVriN/wL8FxUjrVzj4hu3/Lb5+MEuhJV05iODrjwWloPZgozEhG7mCJMTBTIpc
         hQnRDmXu/c8V/IXTQ4XQTWcn7H1RtsRcqEFq1R5aWFtlZEcMCpa0gbrjL8chtHmGaRPT
         GVQOcOBBnLLjrX+z+3jiy6ttR7fZzerqDZnLCJxgHji5lfMchcXAQvIB020o491mhNOF
         Cx2R27rUrWjju+AEtbZJ2SYrTthQWS19p8rZnB8XqfUdBTlzyy8vmqR5IGJma9d9sThG
         1/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767403938; x=1768008738;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7cwsZSYzyNbZUR5BkMc+fuk8/uVN1U0fMZDUnscAqpM=;
        b=W9W9eTY4Jx6g++Ll7kp57wyUEGloT6ON1BS1UvewYxg/SZ+ZOf2jwAEneSYh0XhFXj
         zR7DT1ANlW7FAAppGM96J2rWDP07n6m64NzyW9rbiliAYcXqYvPddUAZbuarjHRqbaQr
         0xbD2geVapkLfiJbQyMOIBObLW6XPHTLkyBe0sZsydSYeVylBF+Tlf8a3JftjxKxT+fO
         J8BgOXo/2pOrgX3vg9beEPQS82nox9I6fppmEVcGHCcswmggXbv2YbxpTNnuWL8MyHNF
         kHGQ1pH1FwtZxWNiKiDX9Nu3IZxPoHWXnQH8Ls0F8L2AlxvFkO56k+wN85spACAS8GJV
         W4Zg==
X-Forwarded-Encrypted: i=1; AJvYcCUM9tWLQDQLrhHkfyxVIIv2R+qJCmZXsV3nprrMZ39bT/0idP91U+f8rMGILmxTat8/+LYEGnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ZMum630C0gy8vBaYC/ToPLOaLTqkFYfAdW+0ZOgpFGNA5LNJ
	PUm0P0okGJzefIBd+gVY3p7IXv2GFTMP6K86DAhr3IMMynCdyZfCLxXe
X-Gm-Gg: AY/fxX7xRoYoYkyNivopFcobRUMeAiUH/HtTSBF9s1wDy8CY9ZsORq+3GCwdV5jItNc
	PkRjgNSZpppHs3zOHcW90FbcwiEdQyJe2NRJP7cMtUD1VWF5TpJwLuCFAcLVcEeIgVMkOliT85Q
	BOUMTwoU6CzM3LEGSwEwvE8cVJMba6LGUfzmU+OYui9FbjLJ/Je0S+sBYqceCndsyOXCI7KyBux
	sfhAkREsSV9jHAzh7cJLBtVBmGQKPtzqfzm6ZB6vzoGdZhlJB5aPgaIZERdt0yVu9sRrTaFOM1I
	M0oDilWI1aA+3LM4P1OrcBTMMPeyAZcjZyhANUDBhgrW1hg2q5DHU4LY7FL6IMVO4ECiMyX9R42
	v0jOOasDzQsRlICrpo52UvLO+QhuNG4mnMKFf4PoDta05azLN+tfUnhpSze9zR/aifkGuJfuK5x
	dz9AxwL4UvA6QOHwYca46L
X-Google-Smtp-Source: AGHT+IGMPMdHm63OpAQKdxUJw0KLoAJ18E0uNPr2mWj5GMVPEjOKwmsfSxAmwoQ+kqvkHqWcyJv2iQ==
X-Received: by 2002:a05:6402:3586:b0:64d:88c:c2ca with SMTP id 4fb4d7f45d1cf-64d088ccb1emr37247290a12.28.1767403938141;
        Fri, 02 Jan 2026 17:32:18 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b916b82e7sm48262376a12.35.2026.01.02.17.32.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Jan 2026 17:32:16 -0800 (PST)
Date: Sat, 3 Jan 2026 01:32:15 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	baohua@kernel.org, baolin.wang@linux.alibaba.com, david@kernel.org,
	dev.jain@arm.com, lance.yang@linux.dev, liam.howlett@oracle.com,
	lorenzo.stoakes@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
	stable@vger.kernel.org, ziy@nvidia.com
Subject: Re: FAILED: patch "[PATCH] mm/huge_memory: merge
 uniform_split_supported() and" failed to apply to 6.18-stable tree
Message-ID: <20260103013215.lvkskim32cvtm2b6@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <2025122925-victory-numeral-2346@gregkh>
 <20251230031135.efpejaosso23ekke@master>
 <2026010206-footprint-impure-82b8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026010206-footprint-impure-82b8@gregkh>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Jan 02, 2026 at 01:24:28PM +0100, Greg KH wrote:
>On Tue, Dec 30, 2025 at 03:11:35AM +0000, Wei Yang wrote:
>> On Mon, Dec 29, 2025 at 01:33:25PM +0100, gregkh@linuxfoundation.org wrote:
>> >
>> >The patch below does not apply to the 6.18-stable tree.
>> >If someone wants it applied there, or to any other stable or longterm
>> >tree, then please email the backport, including the original git commit
>> >id to <stable@vger.kernel.org>.
>> >
>> >To reproduce the conflict and resubmit, you may use the following commands:
>> >
>> >git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
>> >git checkout FETCH_HEAD
>> >git cherry-pick -x 8a0e4bdddd1c998b894d879a1d22f1e745606215
>> ># <resolve conflicts, build, test, etc.>
>> >git commit -s
>> >git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122925-victory-numeral-2346@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..
>> >
>> >Possible dependencies:
>> >
>> >
>> 
>> Hi, Greg
>> 
>> This one is not a fix to some bug.
>> 
>> We found a real bug during the mail discussion, which is 
>> 
>>     commit cff47b9e39a6abf03dde5f4f156f841b0c54bba0
>>     Author: Wei Yang <richard.weiyang@gmail.com>
>>     Date:   Wed Nov 19 23:53:02 2025 +0000
>>     
>>         mm/huge_memory: fix NULL pointer deference when splitting folio
>> 
>> It looks has been back ported to 6.18.y and 6.12.y.
>
>I do not understand, should this not be applied?  Or should it be
>applied?

Upstream commit

    cff47b9e39a6 2025-11-24 mm/huge_memory: fix NULL pointer deference when splitting folio

should be applied and already applied to 6.18.y and 6.12.y.

Upstream commit

    8a0e4bdddd1c 2025-11-24 mm/huge_memory: merge uniform_split_supported() and non_uniform_split_supported()

is not necessary to be back ported.

>
>confused,
>
>greg k-h

-- 
Wei Yang
Help you, Help me

