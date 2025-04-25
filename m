Return-Path: <stable+bounces-136697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4781A9C67C
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 13:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26F999C2F35
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 10:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DD123F40C;
	Fri, 25 Apr 2025 10:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0JEEKwbT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E28E85931;
	Fri, 25 Apr 2025 10:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745578721; cv=none; b=B1ti6syEyodF2Z+OXRFQsuTSDPSW5g6krLb8b0eFNDhUaM+3royJpRA5DTQNZ6m3m8XSWb4lkEoj6CiKTs6N5G4XMamClC41ai6jpzRX/Qze2R1YozbXO5QWKnQfHaLocPY2TsANOyErrmIXNVFjrbCmY2arn86Oy7GCo/v11Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745578721; c=relaxed/simple;
	bh=8q8hE+ELcPhY1RWnxG5pYLa+0zmwdkNuXb+sElcP87g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojIZfvaMVVBd5Xw3xhG6LTe8MOsYeBixEi/rUv0Cx93yPIrs5J4oiPfWzxfjAxzJWyKQKypE1axn4Im8zTTFTQdFyfAvtdW3HQpeoYmvm9/8+YMSoFFYgWScAyKmC5ArXmwgFTumcqoFVpitam5mzUVZCCO65lkxybdKVvwfqQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0JEEKwbT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E60CC4CEE4;
	Fri, 25 Apr 2025 10:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745578720;
	bh=8q8hE+ELcPhY1RWnxG5pYLa+0zmwdkNuXb+sElcP87g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0JEEKwbT9wDuXpT2GaRwfamKGKS4mukJpTIDrzWfmzCv8JfEQ7TPEAa/w9sTdgZS8
	 z8rpn+BoLLTqXxhf9MN6Pir1c9GpZmLQ4uHlLW85r+nll2Uu7yBuWvH861zDMigpRN
	 DOyExA3Nt3Kv3zgV6LuIK+b4SafLYCZFUbouH8eE=
Date: Fri, 25 Apr 2025 12:58:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kuen-Han Tsai <khtsai@google.com>
Cc: Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: dwc3: Abort suspend on soft disconnect failure
Message-ID: <2025042513-crunching-sandworm-75c5@gregkh>
References: <20250324031758.865242-1-khtsai@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324031758.865242-1-khtsai@google.com>

On Mon, Mar 24, 2025 at 11:17:55AM +0800, Kuen-Han Tsai wrote:
> When dwc3_gadget_soft_disconnect() fails, dwc3_suspend_common() keeps
> going with the suspend, resulting in a period where the power domain is
> off, but the gadget driver remains connected.  Within this time frame,
> invoking vbus_event_work() will cause an error as it attempts to access
> DWC3 registers for endpoint disabling after the power domain has been
> completely shut down.
> 
> Abort the suspend sequence when dwc3_gadget_suspend() cannot halt the
> controller and proceeds with a soft connect.
> 
> Fixes: c8540870af4c ("usb: dwc3: gadget: Improve dwc3_gadget_suspend()
> and dwc3_gadget_resume()")

Please do not line-wrap this type of thing.

thanks,

greg k-h

