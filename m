Return-Path: <stable+bounces-160218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E6EAF998B
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 19:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A811C5A4941
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 17:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D9E2E3702;
	Fri,  4 Jul 2025 17:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="vUp2Nn4h"
X-Original-To: stable@vger.kernel.org
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7013415C0;
	Fri,  4 Jul 2025 17:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751649325; cv=none; b=WlHMRDSTL6fqQpqIHHusTZMQAA0C8j4pw38SSTjWp3MRtWAYg1m017moFJPWe+CX1lQ8B9e4V1kWKQvROeULT/Sq8c3kL8cnHxvHhO33A29t457s5WlMXU5zpEWkLLt1wbl9sXMbR2E7tSYQcSSGJEoF8zfWLTi+Zx9BHBnvBOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751649325; c=relaxed/simple;
	bh=XDVwC+z5XXfkRRmdkMZ/C2q+wvdnCJ46qFLNNvinBpk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukgGwjCoBnDy9R5o9v+TKG+TFN1N1BfWYxrK+1hTzLP7rrPvJmaBkEjZ1bygg0BPdmBIKTsGDpGg8ByVquAp/sOfZ0aeicJKIYN60pp8DF7oZhI7out1EOzt3oTXMCEivM0FkUbhAN59Uf5XT0rLjP2aueIYjoxRBrIBkCgZsTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=vUp2Nn4h; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Fri, 4 Jul 2025 19:07:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1751648821;
	bh=XDVwC+z5XXfkRRmdkMZ/C2q+wvdnCJ46qFLNNvinBpk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 mime-version:references:reply-to:Sender:Subject:Subject:To:To;
	b=vUp2Nn4hYlrjLeX3VFAafOvYWpEHBR9ybsmkAMYwcenS8XfTGFqdo754yZ/j/07Nj
	 1u76S8t2VzkSOA5YCmmsZuYdiGusXYmdO8VVJMVSuJ0HCRcFm0KM/SRR5bhMQPcHbR
	 TSYPNlGxScf6GAZtaBrvDmVKwTixTbPgYARG6jwtZLRcmOY3+REbDGbVAho7V3EdKl
	 8HeaNHx4ACQXVSY54ee569zNodDWY/YTjj6TKaWrbs6jmSdx8Q4+Khj53RgCf5yle9
	 uIKKxyesND6LfMhcSK2PiR17DCl/1hHylkfiUf1ubHG0z0XJaYBJkxD2qsJTqggfmi
	 mIDr7cUoBoIQw==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.15 000/263] 6.15.5-rc1 review
Message-ID: <20250704170700.GA3473@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250703144004.276210867@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703144004.276210867@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.15.5 release.
> There are 263 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 05 Jul 2025 14:39:10 +0000.
> Anything received after that time might be too late.

Hi Greg

6.15.5-rc1 compiles on x86_64 (Xeon E5-1620 v2, Slackware64-15.0),
and boots on x86_64 (AMD Ryzen 5 7520U, Slackware64-current),
no dmesg regressions observed.

However, on my machine in /etc/rc.d/rc.local there is 

echo 20 > /sys/class/backlight/amdgpu_bl0/brightness

to adapt the brightness early in the boot process to save energy.
It works for me with kernel 6.15.4
before /etc/rc.d/rc.local is invoked there is:

cat /sys/class/backlight/amdgpu_bl0/brightness
50

but with 6.15.5-rc1 there is something off.
I get a blank screen as greeting. The network works.

Right after boot (before invoking /etc/rc.d/rc.local) I see:
cat /sys/class/backlight/amdgpu_bl0/brightness
400000

A comparable level of dimming on -rc1 to kernel 6.15.4 with my tuning is with a brightness value of 100000 

I noticed there's -rc2, will test soon.


Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>


