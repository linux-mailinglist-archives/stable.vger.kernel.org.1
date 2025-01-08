Return-Path: <stable+bounces-108017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D59CA06103
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 17:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B3DC1887B1F
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 16:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB6B1FC7C2;
	Wed,  8 Jan 2025 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I++6xX9b"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA21717E900
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 16:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736352142; cv=none; b=slfjf7TrnH8Rj5s1KWZuuX/wHWKD52l/FqLkq7qs+xJ/9OlKUCEYuLZSeKAigdVRKk/Umm7EZkz6WDx9tiwRz6L+c/b0R+n+piSrtRV4Red/VgyHPN9/LzqZ1TysVkCJn0VW/rUZONjFN+kuQ6w4b7AxDgZN1EZrh2ij6SN07EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736352142; c=relaxed/simple;
	bh=q2pod2nUbwMJD0bdVvi2G9EzGICOQ3Pcv9WM6ocnZY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgiIlwJr6bppqp1puF3BEiUrzbixwuri4A2lSPfvy3QoGJi1PQ/5oJI9WSuCh65Gz0aQ2NxpNfgrddRiEBcJuQ30pm3tWO7UBJ+mWkCds4GV6WPu+rp/1sld87SMPMLWjajMpREl7K+cRhLOTu5B/1hkCjk/Gli+FspMJvaD/eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I++6xX9b; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21644aca3a0so81667365ad.3
        for <stable@vger.kernel.org>; Wed, 08 Jan 2025 08:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736352140; x=1736956940; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gDnmmr+BPzeGSONCgPZRDtmO65LxOmvvSiVUiu5r1WI=;
        b=I++6xX9b8Y6I8yvtjQp3yw5PiNR/inwXfxk/igpwBv0lZpW3sgfdr5NDe5ZFwMMlA9
         CDxsIKTVla18Xsfb5Q2Cq6Axo8ixdNeYtQparZ5W09B48NsRXjvNfkadu8iIeO23O9FD
         A4oy9fsOF3KPSuU/C03WGqMOtBAKDosx2G0E6LE5MrUWxgV3iEcU8gOFcyQ6Q7XgJInm
         73Gbd+JIyQCWPGqstZ58nv8dh7MHrGidBZd0Cig5xlnPvQ9RSOBOuU5BRQFgy1Yo3Up5
         IXiqJvSce7sV967fdT0cBHOiyb86EOq5zmuZyOmvSYOA16dpBfycCyiqe/b3RkvCHtbn
         roFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736352140; x=1736956940;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gDnmmr+BPzeGSONCgPZRDtmO65LxOmvvSiVUiu5r1WI=;
        b=VhzDnGjDJRtz4HQXDcLtmkklK8Y7dHaHdhQxL4QN4LglT3FkPGWs44uyENP5aNX/cM
         51JDTlUBPu40hr9mplRyJRGJ9/KYUBr1Aq2u8a8nJRQiLxjgRhNHymiGJZp+13+d9y88
         MmMgXD+5C07JjY/FeWkRuMWlNvaEzGvb1WjWKF/RHbYjehK4uCm9dkn+9sYx300DfLCE
         VCds/I/b8CtYLtDWEZ7aTJQ27tYTOYUMtOPbIY3Zd44Bns8SP0u7GmtbwVAcTtHVyDK3
         4gUaXFFAREX31LE/U48OXm9ybbYv4zrVitEIqSiex27wltl8aVeDvYk3rz1uwpZzTHbE
         W9PA==
X-Forwarded-Encrypted: i=1; AJvYcCWrqyYIv4N94+dnJITrgq7c5zQ9vKpyU713KeuNghqn96n3sjDMlyDIOFYspV459YNHUSX5K60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw85Lt1sm+JHjZy9ziSb1GiSxHCciYateZIOs/0uUb4lK4o+MIE
	ZUSqBlPw1sW92YthsIratspPHzkVPkn+nwqo7nBHf2AqsiCWt1i78AYHihgE5vzIP5NggDZqiuc
	=
X-Gm-Gg: ASbGncuaU55Y7r42WvflLrBKDzP0P7FhnX+ag0b4U7SBx05genZZ5ZZm6Ox9iSLihlG
	kRtL7uP0etH6HI1G0bHAPhOqFJ3ilJedUzPXgvs3bBUDaVyV/GLVga6uQRxGtBNMAx37vHyaxBK
	aCVUVHuoTksg8LLkZ+VFiSPFSSwpPuYifL3CZsyjeu1/NK0Kap6WvOeyR4wDm5Ma7GZ7nAUb+pQ
	LinB32cdxjWL6Z2Fsq2NveWP4ZestTJBvz2bNkjVfAovQMyq8gL1aVV+RJfGfJFYmvg
X-Google-Smtp-Source: AGHT+IGnIOJxVu4wkWjov5XG3BAJjb4T++JDP8RJTAnpDKLkqISVD6wPeoA7et1loROcLPRxCQ2RcA==
X-Received: by 2002:a17:902:c941:b0:215:7fad:49ab with SMTP id d9443c01a7336-21a83f46a12mr51005925ad.10.1736352138709;
        Wed, 08 Jan 2025 08:02:18 -0800 (PST)
Received: from thinkpad ([117.213.97.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc970cbbsm329441405ad.103.2025.01.08.08.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 08:02:18 -0800 (PST)
Date: Wed, 8 Jan 2025 21:32:11 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Loic Poulain <loic.poulain@linaro.org>
Cc: mhi@lists.linux.dev, Johan Hovold <johan@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] bus: mhi: host: pci_generic: Recover the device
 synchronously from mhi_pci_runtime_resume()
Message-ID: <20250108160211.6dok3zcn2qaoj3lp@thinkpad>
References: <20250108-mhi_recovery_fix-v1-0-a0a00a17da46@linaro.org>
 <20250108-mhi_recovery_fix-v1-2-a0a00a17da46@linaro.org>
 <CAMZdPi9KiLczjETLwJG_9krn_z=Og0uZhYuajPeZYoBHanxMiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMZdPi9KiLczjETLwJG_9krn_z=Og0uZhYuajPeZYoBHanxMiw@mail.gmail.com>

On Wed, Jan 08, 2025 at 04:19:06PM +0100, Loic Poulain wrote:
> On Wed, 8 Jan 2025 at 14:39, Manivannan Sadhasivam via B4 Relay
> <devnull+manivannan.sadhasivam.linaro.org@kernel.org> wrote:
> >
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >
> > Currently, in mhi_pci_runtime_resume(), if the resume fails, recovery_work
> > is started asynchronously and success is returned. But this doesn't align
> > with what PM core expects as documented in
> > Documentation/power/runtime_pm.rst:
> >
> > "Once the subsystem-level resume callback (or the driver resume callback,
> > if invoked directly) has completed successfully, the PM core regards the
> > device as fully operational, which means that the device _must_ be able to
> > complete I/O operations as needed.  The runtime PM status of the device is
> > then 'active'."
> >
> > So the PM core ends up marking the runtime PM status of the device as
> > 'active', even though the device is not able to handle the I/O operations.
> > This same condition more or less applies to system resume as well.
> >
> > So to avoid this ambiguity, try to recover the device synchronously from
> > mhi_pci_runtime_resume() and return the actual error code in the case of
> > recovery failure.
> >
> > For doing so, move the recovery code to __mhi_pci_recovery_work() helper
> > and call that from both mhi_pci_recovery_work() and
> > mhi_pci_runtime_resume(). Former still ignores the return value, while the
> > latter passes it to PM core.
> >
> > Cc: stable@vger.kernel.org # 5.13
> > Reported-by: Johan Hovold <johan@kernel.org>
> > Closes: https://lore.kernel.org/mhi/Z2PbEPYpqFfrLSJi@hovoldconsulting.com
> > Fixes: d3800c1dce24 ("bus: mhi: pci_generic: Add support for runtime PM")
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Note that it will noticeably impact the user experience on system-wide
> resume (mhi_pci_resume), because MHI devices usually take a while (a
> few seconds) to cold boot and reach a ready state (or time out in the
> worst case). So we may have people complaining about delayed resume
> regression on their laptop even if they are not using the MHI
> device/modem function. Are we ok with that?
> 

Are you saying that the modem will enter D3Cold all the time during system
suspend? I think you are referring to x86 host machines here.

If that is the case, we should not be using mhi_pci_runtime_*() calls in
mhi_pci_suspend/resume(). Rather the MHI stack should be powered down during
suspend and powered ON during resume.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

