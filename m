Return-Path: <stable+bounces-145040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8600CABD29E
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 11:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74D8D7A3626
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 08:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE37221CFFD;
	Tue, 20 May 2025 09:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YQXL+0wP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC40D1D7985
	for <stable@vger.kernel.org>; Tue, 20 May 2025 09:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747731655; cv=none; b=p4lmf97E/4XSXftAzEQI1oE62EZOWKREkJB5k4cf0XnQ1FM5N1xI7lvs5uS0KJEEeCPsIt/RvWz2OuRqqWkOwx2wzWu+vbSxVdPVY872mgm6kTEnZW9iHCzFQ0mqR2CtAqlDjHarB9WC7vWtFwD9tNOZuzYZ4fLdHh6LJlfyz7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747731655; c=relaxed/simple;
	bh=SCbyQOoWAC2z3ewKFgiqqxVqMAXKkyiSMdzVxcBa/KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7YDmgl1VUGX46YlYDuCL2dTgtAnwRGpbzP1K17yKGX/+6oJEbqN/YFmGf8rNeea/ReMIpQA8iPiLlmGXn/dmHpa3OxfNnSOdfznszNZgJ55gM+T3Amweh0GRUG7BMF21JPGriUNCiVhNGd+kRcDnaKqPIwVgXm1B0jb3jiIVZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YQXL+0wP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6EE4C4CEE9;
	Tue, 20 May 2025 09:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747731654;
	bh=SCbyQOoWAC2z3ewKFgiqqxVqMAXKkyiSMdzVxcBa/KY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YQXL+0wPDcs/IFLF0FrXgomUOVaoxTLgEOSRwmItXs8luGm/bgdI0DxcoDKPf7WSk
	 InHQkvVnlbyNSi33E0FFYPkn8N+BX+42QQ/s427qHZdXvdcSzSs69YnNYh9oRAcVCh
	 87GoO4zwj67eCpdsQgs7Rh9R/8vOS3GI13h7J+oE=
Date: Tue, 20 May 2025 11:00:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Cc: stable@vger.kernel.org
Subject: Re: Request for backporting accel/ivpu MMU IRQ patches to 6.14
Message-ID: <2025052043-yiddish-mutable-d827@gregkh>
References: <d995a12d-f30b-4627-b5f2-a50d5e3a408d@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d995a12d-f30b-4627-b5f2-a50d5e3a408d@linux.intel.com>

On Tue, May 13, 2025 at 06:33:26PM +0200, Jacek Lawrynowicz wrote:
> Hi,
> 
> Please cherry-pick following 6 patches to 6.14:
> bc3e5f48b7ee021371dc37297678f7089be6ce28 accel/ivpu: Use workqueue for IRQ handling
> 0240fa18d247c99a1967f2fed025296a89a1c5f5 accel/ivpu: Dump only first MMU fault from single context
> 4480912f3f8b8a1fbb5ae12c5c547fd094ec4197 accel/ivpu: Move parts of MMU event IRQ handling to thread handler
> 353b8f48390d36b39276ff6af61464ec64cd4d5c accel/ivpu: Fix missing MMU events from reserved SSID
> 2f5bbea1807a064a1e4c1b385c8cea4f37bb4b17 accel/ivpu: Fix missing MMU events if file_priv is unbound
> 683e9fa1c885a0cffbc10b459a7eee9df92af1c1 accel/ivpu: Flush pending jobs of device's workqueues
> 
> These are fixing an issue where host can be overloaded with MMU faults from NPU causing other IRQs to be missed and host to be slowed down significantly.
> They should apply without conflicts.

All now queued up, thanks.

greg k-h

