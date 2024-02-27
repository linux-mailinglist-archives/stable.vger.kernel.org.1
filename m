Return-Path: <stable+bounces-23862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7170E868B9A
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 10:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4E13B23334
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 09:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F3E1332A9;
	Tue, 27 Feb 2024 09:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gMn9d00d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C704355E78
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 09:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024710; cv=none; b=IXWzjEQItEMry9MYUlcU4jUls21jnn3u+5XWm/ZoyY4Y0/yMxzxsBn1CfGkmWrlRWVj8SdZUSqNwRxW6SoXANm8Ms+0CfqkUd/M8opWYPRIIFfEXlDEHY941mQF0c1l6JBdwHYToVD1TsFTFw9xvEZ2vb4LedZBo/tAeXvY8OCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024710; c=relaxed/simple;
	bh=rQGsBLmKYhIYkBwH7i+nm2rTpBD9YyolmBBcVn11R1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xa/ygBGszINlIp3XgF3xgqLgJKaP8FTECRyaJ/KmaQPtvVMCaKK2Nc63iO+1yzEqx8lWREmkNAHAX/IQx3svwHB/t1+obwv9LlrDjtknyJN147bQzAEQWy3oQaJOnqulH8RYXa9To560DS8DYcESEDacH6GoWfJS+sNO4XABLoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gMn9d00d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F77C433F1;
	Tue, 27 Feb 2024 09:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709024710;
	bh=rQGsBLmKYhIYkBwH7i+nm2rTpBD9YyolmBBcVn11R1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gMn9d00dHOw6Mho8MOr1tvWEuOsWwBfmV89WaCRKei3qNq+KOrHZ8CdXfRoqrIKfq
	 aDlTtVw2ekgU21PwhbG4obyb64WjBObXQtuHOR14ax7KwJb14iTAUTFkZcv1pfyJ7b
	 boADZcMjS2w5MjOaeHAowS/BXDcQfZIN6iywaeE4=
Date: Tue, 27 Feb 2024 10:05:07 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: stable@vger.kernel.org, maz@kernel.org
Subject: Re: [PATCH 4.19.y 0/2] KVM: arm64: VGIC ITS fix backports
Message-ID: <2024022757-thud-perpetual-198f@gregkh>
References: <20240226213822.1228736-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226213822.1228736-1-oliver.upton@linux.dev>

On Mon, Feb 26, 2024 at 09:38:20PM +0000, Oliver Upton wrote:
> Oliver Upton (2):
>   KVM: arm64: vgic-its: Test for valid IRQ in
>     its_sync_lpi_pending_table()
>   KVM: arm64: vgic-its: Test for valid IRQ in MOVALL handler
> 
>  virt/kvm/arm/vgic/vgic-its.c | 5 +++++
>  1 file changed, 5 insertions(+)

All now queued up, thanks!

greg k-h

