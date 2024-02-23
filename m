Return-Path: <stable+bounces-23502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CCF8616FF
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 17:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E717287BF1
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 16:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189FD84A39;
	Fri, 23 Feb 2024 16:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JtG6bX3n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA6684A34
	for <stable@vger.kernel.org>; Fri, 23 Feb 2024 16:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704350; cv=none; b=T+OR/EdRpkf9dytYY85MQ96JM2WIdzgIg1h0jTVl27ZONrcjSiXoM5oka6i5EMo2+4DBURIFb/pcx3PI5rm45PgCPSF+hfJ5B4gO06nEpXVhx2fj3CuAI+2W874/xdrUxpYw52fvp95gG4cdsZtHVmJmXLxCOGVJ0SXkgA65hX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704350; c=relaxed/simple;
	bh=3HAXtG22J9qyCh84AbirmoUzk51w3UtY5TOdVIBDcVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fy9So2ZmUglF/kaMXjhstZpqDZwibQX+cqvivLXsC++SssQcMLAo/BG+RgHA8mJHOkZJ8lJBmScpJNJkUaTk3PTp2rKTV8D7lWNbl40ieSbeL6dXxDMXdbugZOC/qR45Gs88/YGeSFSW5CIGVZt7z2+tmvoHQuaGhRSqh8pyDu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JtG6bX3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4BCC43390;
	Fri, 23 Feb 2024 16:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708704350;
	bh=3HAXtG22J9qyCh84AbirmoUzk51w3UtY5TOdVIBDcVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JtG6bX3nnJLF8RGXOirEPw/NeIDe+LmvCM+VYP5RqUfPCS/QpIZsfedIhqLafpDGq
	 RS9gWMPFevU1IvhlIcbwHdh3mX3qVa7P4yp7WgR6Dn1SeKKMlB231mTKOnGyb4u/Vc
	 jHFrlNFrmsfrJoZ1ms9sCN1C73rt2AcQic8BtcQ4=
Date: Fri, 23 Feb 2024 17:05:47 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: stable@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 6.1.y] riscv/efistub: Ensure GP-relative addressing is
 not used
Message-ID: <2024022339-grafted-cough-bb8d@gregkh>
References: <3b0b6bb9-f346-46dd-8ce6-fdf5f916ddf6@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b0b6bb9-f346-46dd-8ce6-fdf5f916ddf6@siemens.com>

On Wed, Feb 21, 2024 at 11:21:24PM +0100, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> commit afb2a4fb84555ef9e61061f6ea63ed7087b295d5 upstream.
> 
> The cflags for the RISC-V efistub were missing -mno-relax, thus were
> under the risk that the compiler could use GP-relative addressing. That
> happened for _edata with binutils-2.41 and kernel 6.1, causing the
> relocation to fail due to an invalid kernel_size in handle_kernel_image.
> It was not yet observed with newer versions, but that may just be luck.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/firmware/efi/libstub/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Both now queued up, thanks.

greg k-h

