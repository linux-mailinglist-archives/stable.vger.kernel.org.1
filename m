Return-Path: <stable+bounces-69313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8002A954646
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 11:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AF05B21403
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 09:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D6D16F0E1;
	Fri, 16 Aug 2024 09:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BrDamOPj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D790115B13A;
	Fri, 16 Aug 2024 09:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723802136; cv=none; b=O7WU0LgM6ey0J47l2mKPy55kvzh58TZU6Dhok265HHx4vmHn+Il0NoKv+G+31n2c7A53OvRL3NoNVwYy0VHi833bzHixLLe7GJOgQW+7zIkNMUGhM/KaviB4rwWB8l9m3OAZMxA9iOh9zOh+AacbCJjNhAWgSgu3r1wFt2RnbSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723802136; c=relaxed/simple;
	bh=cYKyIvE4QasD4N3hkDbl8Ujh2Cxx5hf/u+JrYlT6G2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVdJ+wiPO3XOe4C3gX/IoUAE+M73R3GPBGw+8AO2o8WgQvS01DJMLcMqDLY7UzD1NyHnUaOJxSe05HFYMTdHezBFnl3Xb8HRV2C3Uuu/AFcOeC1RElJ7iRfhKGWxxYZIoPewPiNtdfOxBrYEuP4In1HzhEvvtyk5bknK4Ceo79s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BrDamOPj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2364EC32782;
	Fri, 16 Aug 2024 09:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723802135;
	bh=cYKyIvE4QasD4N3hkDbl8Ujh2Cxx5hf/u+JrYlT6G2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BrDamOPj5WURob1BiB0HCQ4cdrBbMtba0SROiNf7mT4tJku795mblGbVDhTLhdrtQ
	 pFYPEVPAF8tw3ZCoXQLpbcL8EpDMM2C0Fzkj2jnwPCU2e8I6G3RIoyHg10rzFiodwX
	 8bnTzny4F+7jYr7m1YE50tbXyyx800AkJstpR88w=
Date: Fri, 16 Aug 2024 11:55:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
Cc: Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, jh0801.jung@samsung.com,
	dh10.jung@samsung.com, naushad@samsung.com, akash.m5@samsung.com,
	rc93.raju@samsung.com, taehyun.cho@samsung.com,
	hongpooh.kim@samsung.com, eomji.oh@samsung.com,
	shijie.cai@samsung.com, stable@vger.kernel.org
Subject: Re: [PATCH v3] usb: dwc3: core: Prevent USB core invalid event
 buffer address access
Message-ID: <2024081618-singing-marlin-2b05@gregkh>
References: <CGME20240815064918epcas5p1248e4f9084d33fdb11a25fa34e66cdbe@epcas5p1.samsung.com>
 <20240815064836.1491-1-selvarasu.g@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815064836.1491-1-selvarasu.g@samsung.com>

On Thu, Aug 15, 2024 at 12:18:31PM +0530, Selvarasu Ganesan wrote:
> This commit addresses an issue where the USB core could access an
> invalid event buffer address during runtime suspend, potentially causing
> SMMU faults and other memory issues in Exynos platforms. The problem
> arises from the following sequence.
>         1. In dwc3_gadget_suspend, there is a chance of a timeout when
>         moving the USB core to the halt state after clearing the
>         run/stop bit by software.
>         2. In dwc3_core_exit, the event buffer is cleared regardless of
>         the USB core's status, which may lead to an SMMU faults and
>         other memory issues. if the USB core tries to access the event
>         buffer address.
> 
> To prevent this hardware quirk on Exynos platforms, this commit ensures
> that the event buffer address is not cleared by software  when the USB
> core is active during runtime suspend by checking its status before
> clearing the buffer address.
> 
> Cc: stable@vger.kernel.org # v6.1+

Any hint as to what commit id this fixes?

thanks,

greg k-h

