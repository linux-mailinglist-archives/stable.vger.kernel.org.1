Return-Path: <stable+bounces-121326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F410A55900
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 22:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82EA83B2DE8
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 21:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B63276052;
	Thu,  6 Mar 2025 21:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="Njr0imto"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97957275601
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 21:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741297398; cv=none; b=XHocpnGh/tKDAJJXSzR4AYXoJm59Dt/ueWe12Uug2stiaMs8CwGw1P1/bJK4/7zrd6BT2rCOJT8Haqiq1kb96L43ajZoqKHnp+6V8HeLLAfqGhWbPPwUkUHHrr0AUYAcpdXy5ZHALsdELHPAKnGdlIxdfNgUJwXMyx8Pq47vkuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741297398; c=relaxed/simple;
	bh=SNFuNCfIgcF5/PptKRJ7JhAvv9sk7R7PiUdz8a1KQGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVNI1zZUUgTgwg3i9e4+lkTrB7d6LhOVMFnsTyDfDqvadGDrSIJPqWFTz0UTZHBsYPBC4kvhQvdEoahkBd/JFP/Dy2aL8+2e+662/P6vcYFk+Q84XL/RADzxjyMS98e61UEvUPCBl4Nw9iivg0dq6Q9w3Gdpbk79Rzz4DFQ0wEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=Njr0imto; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4750ca77d47so9449091cf.0
        for <stable@vger.kernel.org>; Thu, 06 Mar 2025 13:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1741297395; x=1741902195; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Oyv98J/VYPy+XUbKLqkeEBWOqmDRWz3461BxBi5DFCU=;
        b=Njr0imtoJOUjnvbUL0e1CSQDd6qGyevwMpHbE4eVRW6i6Z/NM/O0654wyHiGdtv2O/
         8sjQFDVG2TfSY5THuNaM5NnO0DoTjzWWC+wHuTRGkeYYQw3F/Tc0YXoCVgqJzVALtmrF
         PyG2c75sLcULwaBZyeM46TAY6Ffdm5yoY1Q3rk4D0TBw8Xv5fBpRWGeMai0bH7qzdFQ/
         4JzX5ZcmqtqTgNIlzugtnQ+b4khj1T82lrbZM9DlD1eVFWV7wNRrsKQC3W8943438m8B
         IJ4dZjUoe5/6rI2dUjyDupDdf3o6ObvgRWaFSHy6z/k9HiRDSgcb73dFG0Q5DcTa9bjw
         kGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741297395; x=1741902195;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oyv98J/VYPy+XUbKLqkeEBWOqmDRWz3461BxBi5DFCU=;
        b=Pa0YlCe5i1JfHfZp+zQft6TOSqbPEWR0X4UOUBi83hPAUrwJHMeiO7tBdbAkt5ByAD
         6//Q9L5hndXRniNjpYWkLXG42KpOWjMNXpj6liZWJFwLF182xy2irGV0wL6M+XyWAszv
         JIRQbviCAzjdQW63VHlhXVzGqz51B7yvMxDOsZhvl7/wr9zjcZSlMyICc9G4dtxBgTCX
         MIj0p7aAWKIhDELSJrlNahHaaAOXR8u73ULUp4l0NF8jP2uSlcuPjrYjaj+eOfj5IsrF
         Ilk0hER8IPvtomTaJJ+uHmi1RmlCsa3kMPKBn7HouHA0wAFqJ6ICzEs6aSC4A96g+f/y
         L9hw==
X-Forwarded-Encrypted: i=1; AJvYcCVDeJYGEX+9ZfGPi2Vc9SfEATrQXlUps/YWlqRZYCsAahZqcv9gcwdpPyMtdAyhJNooRI5S05A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV84E9Sxi53RabNfuzM+1g65ksZMNetlwTatHV6SdZluk8gDzm
	nYF0QR/fd5sgwaIZ9U4ePr8pcycDN2UZOh+hEHgob6c9m3v/p45QChXberCWtA==
X-Gm-Gg: ASbGnctMQu2MRxTS5HAlLxNXhAIOfM+oJmQqfUWQM3lyLTbhkOWAGfMvwvihv9gjA2v
	FmuQCjaHydaS20/P3bGog7p+DifzpHRIVYW2YMVyvllQw/UmBLYU44/B48uvpk1D66ZWCjSsoWh
	czui90oqG33XC/niIrhifW9UAwovorCDQZ2Ccv+na77xaYGabTjcHLOGXby+qbiefA7RXGMGSCZ
	8KiZzrU7a/IKzrQPy0XxNoxA7DMGB0rkNSgJbwVoENNzHOJXvk2jAg6yUQhL0ZtJF1BvfGYJfk0
	YI7KqkqMBKi2ql2m1pPtquVVWL257E+5VTMGHCMA21+Z3Q==
X-Google-Smtp-Source: AGHT+IFnAgDNioiavSEVVuQAtbRWHZD2jSHEVT25d3GoKqWLqtEkZCF1Iwjtf2+iqzJNvvEeQHrmnw==
X-Received: by 2002:ac8:5852:0:b0:475:819:27ec with SMTP id d75a77b69052e-47618b38b3dmr11877871cf.50.1741297395363;
        Thu, 06 Mar 2025 13:43:15 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::3ca7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4751d9ad29asm12223241cf.46.2025.03.06.13.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 13:43:14 -0800 (PST)
Date: Thu, 6 Mar 2025 16:43:12 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Colin Evans <colin.evans.parkstone@gmail.com>
Cc: eichest@gmail.com, francesco.dolcini@toradex.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, stable@vger.kernel.org,
	stefan.eichenberger@toradex.com
Subject: Re: [PATCH v1] usb: core: fix pipe creation for get_bMaxPacketSize0
Message-ID: <04cb3076-6e34-432f-9400-0df84c054e5c@rowland.harvard.edu>
References: <Z6HxHXrmeEuTzE-c@eichest-laptop>
 <857c8982-f09f-4788-b547-1face254946d@gmail.com>
 <1005263f-0a07-4dae-b74f-28e6ae3952bf@rowland.harvard.edu>
 <cf6c9693-49ae-4511-8f16-30168567f877@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf6c9693-49ae-4511-8f16-30168567f877@gmail.com>

On Thu, Mar 06, 2025 at 09:06:23PM +0000, Colin Evans wrote:
> > Please try collecting a usbmon trace for bus 2 showing the problem.
> > Ideally the trace should show what happens from system boot-up, but
> > there's no way to do that.  Instead, you can do this (the first command
> > below disables the bus, the second starts the usbmon trace, and the
> > third re-enables the bus):
> > 
> > 	echo 0 >/sys/bus/usb/devices/usb2/bConfigurationValue
> > 	cat /sys/kernel/debug/usb/usbmon/2u >usbmon.txt &
> > 	echo 1 >/sys/bus/usb/devices/usb2/bConfigurationValue
> > 
> > Then after enough time has passed for the errors to show up, kill the
> > "cat" process and post the resulting trace file.  (Note: If your
> > keyboard is attached to bus 2, you won't be able to use it to issue the
> > second and third commands.  You could use a network login, or put the
> > commands into a shell file and run them that way.)
> > 
> > In fact, you should do this twice: The second time, run it on machine 2
> > with the powered hub plugged in to suppress the errors.
> > 
> > Alan Stern
> 
> Happy to try this, but as it stands there is no such file, or file-like
> thing, on my machine-
> 
> # ls /sys/kernel/debug/usb/usbmon/2u
> ls: cannot access '/sys/kernel/debug/usb/usbmon/2u': No such file or
> directory
> 
> # find /sys/kernel/debug/usb -name "2u"
> #
> 
> # ls /sys/kernel/debug/usb
> devices  ehci  ohci  uhci  uvcvideo  xhci
> 
> 
> It seems something is missing?

Ah -- you have to load the usbmon module first:

	modprobe usbmon

Some distributions do this for you automatically.

Alan Stern

