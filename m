Return-Path: <stable+bounces-121626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E42D9A5884E
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 22:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CE4E188DA63
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 21:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C70121D591;
	Sun,  9 Mar 2025 21:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="VOZidbpM"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7819F17A2FE
	for <stable@vger.kernel.org>; Sun,  9 Mar 2025 21:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741554085; cv=none; b=JOiimqgVMKhbuxeGzBNfIfZfHO1rWDoQ2cPSJsrFEeKf454ze6vr0lOCshegBfRXqk2M9qiV1B1AhiG+PU0OOP1J3Yn95g1ZkW+EzOlcWbjy0cDh5IkI/4G9VEtomc+k40U27JPiXOMHCk5pLtLbbV88FKLCrDXAtxP2Vcq+spY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741554085; c=relaxed/simple;
	bh=Rqg6lJjhLHNh1Gx73PoQbbrakNT2FXl8F9OEd3Ik71Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m644XZPjoQm2L9QfVVdnKx1iXu/sPO1WJBiFXsH7lyHjpIMIgB5pRpGrCVml2UfyLWOQc6w0BMwD8fTIkbWgb2LYlLSn2ogVvZMlRO6T2j4b//RW/GCnCg9AhqdSThfRuND8+1ujEDOVxuKmXf6swz8B0/VhkFd2+pLKUH7fOL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=VOZidbpM; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e8f254b875so29075816d6.1
        for <stable@vger.kernel.org>; Sun, 09 Mar 2025 14:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1741554082; x=1742158882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ow2CYWxdaijZqI5Ag3kkLaPmTFpnh0nUDA8vWXyWmOU=;
        b=VOZidbpMzVPTWW2ifIvs9VymlUlKmfpPInavnHxtSTspuohMUCLlcDXLnIInCoaEjT
         mi9mIdehYnVcce9ewPeeg0N7EyK2DGBkgQYCG4XyZnGpPW4OOhTDV8jWYvKPgpfqG0Li
         jLbqQCnv+TGGrt9KXJL5cm6FLldEr0gjivnE6x7G24aC8Mph8nGEDxcHZHompWxoXMMz
         59E5D9TvFawb3JahwNjdzJKUu7DxrawPAvNd9/yVcqy78smwokjKWyb2jMs0fga5zySJ
         913Mv44uDbDNGA17jedm8XpCufCwG0uomqUk8ri6RJzIX9hWmX/2M+2Bl/CzMBZXqmlX
         ZcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741554082; x=1742158882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ow2CYWxdaijZqI5Ag3kkLaPmTFpnh0nUDA8vWXyWmOU=;
        b=pisGqddGxgwyTWxGD0gTJEceUmJ2pL2Ofml8fALw7mgIJzqQDoD6mauHdOsGjr6/WB
         D03qL3zzxPHXyHNzBXenABCuyGZiOUgm1RxehEKOS4xICUHRDahiqlcvtHa1rP/GcPop
         vsPQYrHkr+InKVcraR7Dbq7/AY6JpIEw4DBCSyN4VW82D7coLzH/ARTFyMYXRuym5G4m
         hmBgBynw/kr6ryBIPuEb6jLOMWSSj55zx3awRBlfGFC7mtKgKMexI4ON+x1u5/fZICOz
         AGa7gnduWNVXb84JYo5tFjib8p52D4cF+KfiPIPR6j7+EJK6gvLx1ldi3XEToHY6eFQk
         jM+w==
X-Forwarded-Encrypted: i=1; AJvYcCUrvPkKuVzO5UDthDGYCQPUekZA2m9sTmcYm8pwei+JxMuBKtvBnIT8KrnZsccXiC8nclm6XQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB21XJxBIZxq3RPFSnmojIGykwAtc/VdfVN7xirjmrTklT0OY3
	zjLiMHgR14CfGnoQeKZrT13AueMBC+Nurvp2jMGkSg7SDkl0CyM165FSSxvL5g==
X-Gm-Gg: ASbGncvRgG2WmRgwdi0y9e2P+6VkaOH6J3foiqhK/HYnfqEY4U/LPwjFiEcsb7/xM4c
	Mx+Tuq8jCPN1T1FN8sRzxAoE7TklD558X0jhhyLSEczLipHWJPGC1F6NAp/DwnAgLJwpD/+DL99
	wgTvzOJQQDYeYCquuzoZmQq+bRYBE6zkvBPSDEyuKyKKWgJnKbdb5KFSrazi4mUSvMpEmDJK7JZ
	qNl6Yy0VAkN4d8WXbvnudEENnwpEPcGxVL+0GxsQ61GIfoVWZC3qGC7NTwTsJ+QLvaYXvXGvxm8
	mCucXS69U/vhTZzanaMVFD+2vzVNBGIJom237xLvAheRKw==
X-Google-Smtp-Source: AGHT+IF1UP7kfbT/QaDVu1T3uB4XHx8M2u5OwwjoVQIpuZIpfHKxHSwPcgfqyROtnHoV5EBZDojurQ==
X-Received: by 2002:ad4:5cae:0:b0:6e8:f433:20a8 with SMTP id 6a1803df08f44-6e9005bc7e4mr149057166d6.9.1741554082266;
        Sun, 09 Mar 2025 14:01:22 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::7929])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f7090cb3sm45901396d6.39.2025.03.09.14.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 14:01:21 -0700 (PDT)
Date: Sun, 9 Mar 2025 17:01:18 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Colin Evans <colin.evans.parkstone@gmail.com>
Cc: eichest@gmail.com, francesco.dolcini@toradex.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, stable@vger.kernel.org,
	stefan.eichenberger@toradex.com
Subject: Re: [PATCH v1] usb: core: fix pipe creation for get_bMaxPacketSize0
Message-ID: <73963187-6dcb-480d-ae35-2cee11001834@rowland.harvard.edu>
References: <Z6HxHXrmeEuTzE-c@eichest-laptop>
 <857c8982-f09f-4788-b547-1face254946d@gmail.com>
 <1005263f-0a07-4dae-b74f-28e6ae3952bf@rowland.harvard.edu>
 <cf6c9693-49ae-4511-8f16-30168567f877@gmail.com>
 <04cb3076-6e34-432f-9400-0df84c054e5c@rowland.harvard.edu>
 <bf0fda83-d97d-4a50-94d6-a2d70607a917@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf0fda83-d97d-4a50-94d6-a2d70607a917@gmail.com>

On Sat, Mar 08, 2025 at 11:19:22PM +0000, Colin Evans wrote:
> I believe I have the information requested. The output of usbmon for the "problem" scenario is
> large, I hope it doesn't exceed any email attachment limits, but if it does I will have to work
> out another way to share it.
> 
> It may be that 30s of data is more than is needed. If that's the case I can easily run a shorter
> usbmon cycle.

It is a lot more than needed, but that's okay.

> Additional Observations
> -----------------------
> It appears that having pretty much any external device plugged into a motherboard port connected
> to the _problem_ controller is enough to suppress the stream of "usb usb2-port4: Cannot enable.
> Maybe the USB cable is bad?" dmesg errors.
> 
> For these tests the results named "working" had a USB2.0 memory stick plugged
 into one
> of the top 4 USB ports on the motherboard, while the "problem" results didn't.
> 
> For info- the older machine that exhibits this problem ("machine 1") also shows device manager
> errors if booted into Windows 10, suggesting that machine may in fact have a motherboard
> hardware fault.
> 
> However "machine 2" (which is less than 2 weeks old), shows no errors when booted into Windows.

Well, I have no idea what Windows is doing on that machine.

The usbmon trace shows that port 4 on bus 2 generates a continual
stream of link-state-change events, constantly interrupting the system
and consuming computational resources.  That's why the performance
goes way down.

I can't tell what's causing those link-state changes.  It _looks_ like
what you would get if there was an intermittent electrical connection
causing random voltage fluctuations.  Whatever the cause is, plugging
in the memory stick does seem to suppress those changes; they don't
show up at all in the "working" trace.

In theory, turning off power to port 4 might stop all the events from
being reported.  You can try this to see if it works:

	echo 1 >/sys/bus/usb/devices/2-0:1.0/usb2-port4/disable

Alan Stern

