Return-Path: <stable+bounces-161978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F40EB05AC6
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829E4560D52
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9792E03FF;
	Tue, 15 Jul 2025 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DXeD33cV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13CE2561AE
	for <stable@vger.kernel.org>; Tue, 15 Jul 2025 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752584763; cv=none; b=f6FKe32vk8SWUXI9LS6j6H6treaTbc6+kN/IouzcLAcHYU05LZdvnDN1lQEzrCjjc4EhpTi93za29TVpZ+x52Apc/ULyBEHAe0tbc89CD0c2N3KeI15o6nZFp7TqtDubm1BPUVCuASRfDtGd3pg0reZUa0OSID1JkIl8VgvIMTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752584763; c=relaxed/simple;
	bh=LZv45oTFXdKCZiTFe9NKw4FIa5n8kdT7VqpAGeaBc/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugZjgaJT2A3FH1Tme/8LgWtU/aKuiCH2ai0ap0l4enEvbufb/jUDBpE6a95t0v74cL7H4Ox9W+aNKYkhRlPo/ECxtmq3dardnvOaaZTHchaa9fRL2ZlUkm5TIP+7X6A8ZjRshy6QV8JtJDHzqPj9sDRHiQJTPG6oRj1IbhTZ2SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DXeD33cV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBEEC4CEE3;
	Tue, 15 Jul 2025 13:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752584762;
	bh=LZv45oTFXdKCZiTFe9NKw4FIa5n8kdT7VqpAGeaBc/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DXeD33cVfe8fCyioPCLJ6w2V2H7DoPFxfkKWqzLv7cOhzK2GwXq16Ru5Y3BJt18i8
	 LEC9v3alOA2IJNuLzWPERnOIrKHlLBNrrM8K3C7z4ygMXgomGxdEwKwCor1EtAKsUr
	 nNK5TF3SLdL0pLBaTrht7d1u6EVQ3bOsK1Slty4k=
Date: Tue, 15 Jul 2025 15:06:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Borislav Petkov <bp@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 0/5] TSA 5.10 backport
Message-ID: <2025071547-giveaway-canyon-50bb@gregkh>
References: <20250715123749.4610-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715123749.4610-1-bp@kernel.org>

On Tue, Jul 15, 2025 at 02:37:44PM +0200, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> Hi,
> 
> this is a 5.10 backport of the AMD TSA mitigation.
> 
> It has been tested with the corresponding *upstream* qemu patches here:
> 
> https://lore.kernel.org/r/12881b2c03fa351316057ddc5f39c011074b4549.1752176771.git.babu.moger@amd.com

Looks good, all now queued up, thanks!

greg k-h

