Return-Path: <stable+bounces-9982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759B8826C6E
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 12:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D90FEB21E36
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 11:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6361429A;
	Mon,  8 Jan 2024 11:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sairon.cz header.i=@sairon.cz header.b="DFySzoXf"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815D614294
	for <stable@vger.kernel.org>; Mon,  8 Jan 2024 11:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sairon.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sairon.cz
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a277339dcf4so168002866b.2
        for <stable@vger.kernel.org>; Mon, 08 Jan 2024 03:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sairon.cz; s=google; t=1704712708; x=1705317508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vvHvf7c2821g7elCMwADffZNIAMAL4JPAyxBNttzCkU=;
        b=DFySzoXfz3uK9SXKhm73+RdjE3XhSxU2iTvCyfnADYPAQ3q2ISkCg9CBpXRZgIPMfo
         R3bHmzy6tR4tjbQ4eXfw+d4FLfwOP7jrK7BHxBPdtu73peWpnPW90SCKwnxJ33Np0jqt
         cU6h7j1NFVikEtd9+rsAmXPl5Y3XbWbNC2N4shsxeMC3ga/4uRt9puZLjHRTkRk6v6Lt
         U4aRxguXBLDjC3vbXQVBeKNoMEC2OZVNssYBK4XZKOBUDUShcRRUXZgGxs/qfk+Sfmf0
         9eu6ZROdTUdg+PIcYAz3sHRiJdjk/wpB9k0PaTCrKGxPMK7fqN24smUpeBbHARvKKKyG
         S/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704712708; x=1705317508;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vvHvf7c2821g7elCMwADffZNIAMAL4JPAyxBNttzCkU=;
        b=Mx9teNX+uhxpViU8swudW4A890QQeA+eBSvve6kgAE0gJwBuZG6XDUu+i8fxTOWjqD
         URd4rJEesaZmkxHgbsyt8jnEROttFNrhqiiawuTaHS4mYbTuXc8xCRaCep4/ZD4F8alN
         06Beg6eVYRAoxIilSPT1eO5JiUPn1VmyPOh6pQ1GPkhTHCl4PDZOqKEL+2m3Xp5e3atV
         7KZj1SIa0TnGZFTpnjbRefbUhVHPuLBFEJTnj+bsD7kg1/1w2I/er0q/eozId+OdTpZh
         FYkc8cbl5Albk3qWVRjtKJXim1F6FeFn7wry4wv8m7eLgesxuWBfqT+TpdeMyZyJpJLY
         yd3g==
X-Gm-Message-State: AOJu0YyPT5KRSn72f3JF7EuUUnCfj0FE+0klhdG0MUNZnDwxtcv7CrG5
	3E4w0kbM+2b1a63cR1dQ90cqqbZP7B8kNg==
X-Google-Smtp-Source: AGHT+IGrpOZtNKtQZgl0zlvg91S7nqHPfwc08Q05UcG0tbmEZZ41We+pivW5aWIKtkq+TGhVcx09YQ==
X-Received: by 2002:a17:906:7252:b0:a27:eeca:c344 with SMTP id n18-20020a170906725200b00a27eecac344mr1151838ejk.65.1704712707592;
        Mon, 08 Jan 2024 03:18:27 -0800 (PST)
Received: from [192.168.127.42] (ip-89-103-66-201.bb.vodafone.cz. [89.103.66.201])
        by smtp.gmail.com with ESMTPSA id n15-20020a170906688f00b00a281f88f2ebsm3818651ejr.38.2024.01.08.03.18.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 03:18:27 -0800 (PST)
Message-ID: <7425b05a-d9a1-4c06-89a2-575504e132c3@sairon.cz>
Date: Mon, 8 Jan 2024 12:18:26 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION 6.1.70] system calls with CIFS mounts failing with
 "Resource temporarily unavailable"
Content-Language: en-US
To: Leonardo Brondani Schenkel <leonardo@schenkel.net>, stable@vger.kernel.org
Cc: regressions@lists.linux.dev, linux-cifs@vger.kernel.org,
 Paulo Alcantara <pc@manguebit.com>
References: <8ad7c20e-0645-40f3-96e6-75257b4bd31a@schenkel.net>
From: =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>
In-Reply-To: <8ad7c20e-0645-40f3-96e6-75257b4bd31a@schenkel.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I confirm Leonardo's findings about 6.1.70 introducing this regression, 
this issue manifested in Home Assistant OS [1] which was recently bumped 
to that version. I bisected the issue between 6.1.69 and 6.1.70 which 
pointed me to this bad commit:

----
commit bef4315f19ba6f434054f58b958c0cf058c7a43f (refs/bisect/bad)
Author: Paulo Alcantara <pc@manguebit.com>
Date:   Wed Dec 13 12:25:57 2023 -0300

     smb: client: fix OOB in SMB2_query_info_init()

     commit 33eae65c6f49770fec7a662935d4eb4a6406d24b upstream.

     A small CIFS buffer (448 bytes) isn't big enough to hold
     SMB2_QUERY_INFO request along with user's input data from
     CIFS_QUERY_INFO ioctl.  That is, if the user passed an input buffer >
     344 bytes, the client will memcpy() off the end of @req->Buffer in
     SMB2_query_info_init() thus causing the following KASAN splat:

(snip...)
----

Reverting this change on 6.1.y makes the error go away.

Adding linux-cifs and Paolo to CC.

Cheers,
Jan


[1] https://github.com/home-assistant/operating-system/issues/3041


On 08. 01. 24 11:44, Leonardo Brondani Schenkel wrote:
> I'm new here, first time reporting a regression, apologies in advance if 
> I'm doing something wrong of if this was already reported (I found some 
> CIFS issues but not exactly this one).
> 
> I'm using x86-64 Arch Linux and LTS kernel (6.1.71 as I write this) and 
> I noticed a regression that I could reproduce in other boxes with other 
> architectures as well (aarch64 with 6.1.70).
> 
> # mount.cifs //server/share /mnt
> # mount
> //server/share on /mnt type cifs (rw,relatime,vers=3.1.1...)
> # cd /mnt
> # df .
> df: .: Resource temporarily unavailable
> # ls -al
> ls: .: Resource temporarily unavailable
> ls: file1: Resource temporarily unavailable
> ls: file2: Resource temporarily unavailable
> [...then ls shows the listing...]
> 
> If I use strace with df, the problem is:
> statfs(".", 0x.....) = -1 EAGAIN (Resource temporarily unavailable)
> 
> And with ls:
> listxattr(".", 0x..., 152): -1 EAGAIN (Resource temporarily unavailable)
> listxattr("file1", ..., 152): -1 EAGAIN (same as above)
> ...
> 
> Initially I thought the problem was with the Samba server and/or the 
> client mount flags, but I've spent a day trying a *lot* of different 
> combinations and nothing worked. This happens with any share that I try, 
> and I've tried mounting shares from multiple Linux boxes running 
> different Samba and kernel versions.
> 
> Then I tried changing kernel versions at my client box. I booted latest 
> 6.6.9 and the problem simply disappeared. My Debian server with 6.5.11 
> also doesn't have it. I then started a VM and tried a "bisection" of 
> 6.1.x versions, leading to kernel 6.1.70 when this started to happen.
> 6.1.69 and older look fine.
> 
> I hope that this is enough information to reproduce this issue. I will 
> be glad to provide more info if necessary.
> 
> // Leonardo.
> 

