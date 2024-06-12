Return-Path: <stable+bounces-50243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D29A3905298
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 724FF281A38
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 12:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA0F16FF55;
	Wed, 12 Jun 2024 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E2UXFs6x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCC616F0D0
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718195812; cv=none; b=C3tQrYxgdjmwtrxkkcomwtrVuPW1XL0J0XRQV4Ltv+sOZfs4XTdQRP8aBJ6G7tB4BttCe+zb50ntoO3R6OXybP1dtTN9L4OYkvTE+pRRzb3UEYL1nSc1JzL9k9TGmNKvCN0xwKDGj8DiCE0PynKf6mR0j9/V4XcWmp2nI/pZxkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718195812; c=relaxed/simple;
	bh=YdzTO4U6EvW+INiCcJH940sLWDBXNFFV/gMBjdmXI0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pp54h47OOAxuodgdsU0UWE+WOqAsaDW6FlCpytPBmr02f5oJvTycHr4XxtoGxrE4L9Kqr4fNYFu5zmFTxssDb997C8NPoAabBDge48ccasCRwNRy5TEsN4mQKYqKWP3XSiKGfeGeOtYqFMoH4JtyEVqRmiNeIo5zsUzrDqpDhj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E2UXFs6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E48C3277B;
	Wed, 12 Jun 2024 12:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718195812;
	bh=YdzTO4U6EvW+INiCcJH940sLWDBXNFFV/gMBjdmXI0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E2UXFs6x0761+XJI1gEbVJMPabcRIdpljTr7qLEZCmPDYutR/S7SGC1zR4xlGCb81
	 fgWLUpr6A45ncCFUmosLb0e61t5CAl2Q8vjdsvRqWCxPTYAjcCzoAYuYnOthR4fsq/
	 dk4+m3tvtWY/VUzeFzCj4QxPcziQkXJHYsFDkCdY=
Date: Wed, 12 Jun 2024 14:36:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Conor Dooley <conor@kernel.org>
Cc: stable@vger.kernel.org, shuhang.tan@microchip.com
Subject: Re: Backport request for ce4f78f1b53d ("riscv: signal: handle
 syscall restart before get_signal")
Message-ID: <2024061227-stature-ipad-fb37@gregkh>
References: <20240530-disparity-deafening-dcbb9e2f1647@spud>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530-disparity-deafening-dcbb9e2f1647@spud>

On Thu, May 30, 2024 at 05:25:24PM +0100, Conor Dooley wrote:
> 
> Hey Greg,
> 
> Could you please backport commit ce4f78f1b53d3327fbd32764aa333bf05fb68818
> "riscv: signal: handle syscall restart before get_signal" to at least
> 6.6? Apparently it fixes CRIU and ptrace, but was unfortunately not
> given a fixes tag so I do not know how far back it is actually required.
> It cherry-picks to 6.1 and builds there, but I have not tested it.

Now queued up, thanks.

greg k-h

