Return-Path: <stable+bounces-203438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8205CE01D5
	for <lists+stable@lfdr.de>; Sat, 27 Dec 2025 21:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8777E3012745
	for <lists+stable@lfdr.de>; Sat, 27 Dec 2025 20:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32991D8E10;
	Sat, 27 Dec 2025 20:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="tGVhFh11"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95843C2F
	for <stable@vger.kernel.org>; Sat, 27 Dec 2025 20:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766866556; cv=none; b=AGym2KRq61HvSQFs0lyrN2W6A/y1uPc/DAhVndfkyxx6OuA2bmTaolsZ1sknwYNQT2/msCyv3roIfYPty9eDedisElYrgDh1yRyGokqVYLDQw5FcrWjzfFf4ajVQCpf/RUDp+cWLRgI3bv62GA3cJWvrOOQnIjnaBBh4KTTmlx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766866556; c=relaxed/simple;
	bh=RZNucMZdSXEsYbydyCV3TkMyKw7vijnpC0AIEN8KyJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnO0KVqUuZY40pVfhIcCaidz7/LhLEEGGdQO/6h1Oj5ZJcYMhuzfF1npdjr367/xrh997A+33mImj02OUbGX0FYelzV4F0NuuMgwa/F09nMXsyv9VrEeetvayfoKH/NE9maSuOl3FXihrpIoXGsE44m1gywLk6Q3PqrDctYQw6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=tGVhFh11; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4eda6c385c0so61980431cf.3
        for <stable@vger.kernel.org>; Sat, 27 Dec 2025 12:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1766866553; x=1767471353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HtbUmqDAf3JMT1n/o4B6uqn9tkuL0rjFfjUGbj02xhk=;
        b=tGVhFh11dAJ1sQY4Pm677H0FeDCCU40gx3ncI0JcEPJlVx9l8LWY74GGvyq87O+hOm
         MPSa2G+6WLNpEMPJDD0eAfcfQKlqaR+sLvpb56xD0Vq4nlB1vtFijsfvnJEmIriAKVC6
         8wJhYx1ourivhm4iXH0A0zt5ejsvasoDg+7imrpfCDyUyRaX40hUjzZXvino8v9VmdQd
         hbNw6s7xhQHNZ19A+GvjvOf5b+VWlOnPho7PHG0jK93oCpZr3xIrMRUMPoRRI/uCytlS
         AJ3Vpw/DKparh8yL11MqGVxG45h0vytL6uPtQO3fkdF0EebpW0/UYBhy1BqPoCqV7MyC
         +/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766866553; x=1767471353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HtbUmqDAf3JMT1n/o4B6uqn9tkuL0rjFfjUGbj02xhk=;
        b=cS0Qu2u/Fdo98IyisriTPPqQ3siSMwljXv7gdcKjosutERwvw9KjGDsitNTJtzCSVU
         nFbdCmyrffPytrQlmcGY87AepRv6WKnOnMWBGW9ZN0Fwhp8vtiFwWWT3xpmjzwIHVm30
         VdMc9u6qVS88WGvOyE9cIjKAaW9uflNLwJMHIZ3Z5suiWrHgLO3HDNlkQbLaPlgZ+15M
         ogkUOUNZUcTnBfjVWuXjA+xZiyUKn56kVxNEskXMwhqJt38WxeIuK/5qn9x8X8a3iFZh
         5slqJJSv9azoqqqIkCVOCjhTHjDdyZapkD3hIoY2SljkfH20NuVQntGjm6Ffwcp3+RNT
         /jng==
X-Gm-Message-State: AOJu0YwEfBaXN29evT8P51SAYI1pDlMRnphJDqbfCcZvRf0QS8XepJ+H
	MS/vPDy+8nMsXCcmECQV50QDbNw1ACJS1Jo7ynHnZgnq4wBhzHNVrqEJR9D2YGyfXcsTeLwbpU5
	oyRI=
X-Gm-Gg: AY/fxX7Eaz3OEX0Pk3ooRrKBx+a1EahTtomPNayGk+16S1vjL3mMbgJMOMQSBfE9GVv
	GwlZrsj0XrG3zUAa5vCWoAMeKiVhwGqfMYLtj6Gv9ZT6/yBydW24MDIZdZFZaNaK8VvTjXIscnS
	EZBo8VLakuP9trx3yK7LB1GcTbSIJVxnyTsY8/Jomo2XgWt5bxjhi/ChrmB/zeXU7X8oEJsBTwg
	0yE8kWA88c6r/Y8RvgG6U3yUeGSh8bAPJUUpZoKqBEfTKxilpXKMJ2Jz38p01gyZXf6gLChaKl2
	KUBZNZRCSBO4+vvffEx++YLhJNRWAMUQb29hOUbsfAzlu6EI4u7Lb2o7MIUOJRS2+H4YqL/H0Qq
	2ukAjRMrD0C+pQ7VIRHw6fzFCxlrcDY7Fsl2YHSYhPOA/HVHzTY8zsWjqeaU5jB2thmgKxhXGJU
	wCN9u+PLuS02bo
X-Google-Smtp-Source: AGHT+IGw8G5NE4jvVE/c264IMLg7gJn70y3l/qXZ1ETFtyYzHxaXQ+jtsqnbB9m4mvMvkePFmS8BgA==
X-Received: by 2002:a05:622a:198b:b0:4ee:2074:4b6e with SMTP id d75a77b69052e-4f4abd8cc2amr343125311cf.45.1766866553464;
        Sat, 27 Dec 2025 12:15:53 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::16e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0975ee7d5sm2004763885a.49.2025.12.27.12.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 12:15:52 -0800 (PST)
Date: Sat, 27 Dec 2025 15:15:49 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, chenchangcheng@kylinos.cn,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Patch "usb: usb-storage: No additional quirks need to be added
 to the EL-R12 optical drive." has been added to the 6.18-stable tree
Message-ID: <0c02d5d7-259d-4e4e-a556-0d86473e636c@rowland.harvard.edu>
References: <20251227193644.48579-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227193644.48579-1-sashal@kernel.org>

On Sat, Dec 27, 2025 at 02:36:44PM -0500, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     usb: usb-storage: No additional quirks need to be added to the EL-R12 optical drive.
> 
> to the 6.18-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      usb-usb-storage-no-additional-quirks-need-to-be-adde.patch
> and it can be found in the queue-6.18 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

This commit will be modified by commit 0831269b5f71 ("usb: usb-storage: 
Maintain minimal modifications to the bcdDevice range.") in Greg's 
usb-linus branch, which has not yet been merged into the mainline 
kernel.  The two commits should be added to the -stable kernels at the 
same time, if possible, which probably means holding off on this one 
until the next round.

Alan Stern

> commit 4846de73fe267ccffe66a5bff7c7def201c34df1
> Author: Chen Changcheng <chenchangcheng@kylinos.cn>
> Date:   Fri Nov 21 14:40:20 2025 +0800
> 
>     usb: usb-storage: No additional quirks need to be added to the EL-R12 optical drive.
>     
>     [ Upstream commit 955a48a5353f4fe009704a9a4272a3adf627cd35 ]
>     
>     The optical drive of EL-R12 has the same vid and pid as INIC-3069,
>     as follows:
>     T:  Bus=02 Lev=02 Prnt=02 Port=01 Cnt=01 Dev#=  3 Spd=5000 MxCh= 0
>     D:  Ver= 3.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
>     P:  Vendor=13fd ProdID=3940 Rev= 3.10
>     S:  Manufacturer=HL-DT-ST
>     S:  Product= DVD+-RW GT80N
>     S:  SerialNumber=423349524E4E38303338323439202020
>     C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=144mA
>     I:* If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=02 Prot=50 Driver=usb-storage
>     E:  Ad=83(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
>     E:  Ad=0a(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
>     
>     This will result in the optical drive device also adding
>     the quirks of US_FL_NO_ATA_1X. When performing an erase operation,
>     it will fail, and the reason for the failure is as follows:
>     [  388.967742] sr 5:0:0:0: [sr0] tag#0 Send: scmd 0x00000000d20c33a7
>     [  388.967742] sr 5:0:0:0: [sr0] tag#0 CDB: ATA command pass through(12)/Blank a1 11 00 00 00 00 00 00 00 00 00 00
>     [  388.967773] sr 5:0:0:0: [sr0] tag#0 Done: SUCCESS Result: hostbyte=DID_TARGET_FAILURE driverbyte=DRIVER_OK cmd_age=0s
>     [  388.967773] sr 5:0:0:0: [sr0] tag#0 CDB: ATA command pass through(12)/Blank a1 11 00 00 00 00 00 00 00 00 00 00
>     [  388.967803] sr 5:0:0:0: [sr0] tag#0 Sense Key : Illegal Request [current]
>     [  388.967803] sr 5:0:0:0: [sr0] tag#0 Add. Sense: Invalid field in cdb
>     [  388.967803] sr 5:0:0:0: [sr0] tag#0 scsi host busy 1 failed 0
>     [  388.967803] sr 5:0:0:0: Notifying upper driver of completion (result 8100002)
>     [  388.967834] sr 5:0:0:0: [sr0] tag#0 0 sectors total, 0 bytes done.
>     
>     For the EL-R12 standard optical drive, all operational commands
>     and usage scenarios were tested without adding the IGNORE_RESIDUE quirks,
>     and no issues were encountered. It can be reasonably concluded
>     that removing the IGNORE_RESIDUE quirks has no impact.
>     
>     Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>
>     Link: https://patch.msgid.link/20251121064020.29332-1-chenchangcheng@kylinos.cn
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/usb/storage/unusual_uas.h b/drivers/usb/storage/unusual_uas.h
> index 1477e31d7763..b695f5ba9a40 100644
> --- a/drivers/usb/storage/unusual_uas.h
> +++ b/drivers/usb/storage/unusual_uas.h
> @@ -98,7 +98,7 @@ UNUSUAL_DEV(0x125f, 0xa94a, 0x0160, 0x0160,
>  		US_FL_NO_ATA_1X),
>  
>  /* Reported-by: Benjamin Tissoires <benjamin.tissoires@redhat.com> */
> -UNUSUAL_DEV(0x13fd, 0x3940, 0x0000, 0x9999,
> +UNUSUAL_DEV(0x13fd, 0x3940, 0x0309, 0x0309,
>  		"Initio Corporation",
>  		"INIC-3069",
>  		USB_SC_DEVICE, USB_PR_DEVICE, NULL,

