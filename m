Return-Path: <stable+bounces-192498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB37C3584B
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 12:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D1B4568004
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 11:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E75930FC3A;
	Wed,  5 Nov 2025 11:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cg86LLZm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49912303C86;
	Wed,  5 Nov 2025 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762343253; cv=none; b=lPTaKXkJ6iU+aj1OiT+tLXOcLFOr4jhvwwTIHtrTNwZHkBqutZsbFnt24YTvaRgY8c7G98XB/84Uubyp/wtHAMHma/sECsLt8AH/1X+O6/V6LAHC8sX/z3t9oa7QSckJhGcm2vO6gmDqtjVX0OgMX9fg5L8sCqIGv6yVvhYWLUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762343253; c=relaxed/simple;
	bh=rByHzTDi8GNI4VjgdYw6keFPO0iICIg6fPIKaXxnABc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBv7OAqipFCw/wMBSjsS6RMIZiI09VFU82CecTiUmRf/Tp74MmYrjuCL7y1MxcCfSwWUXJfbojgvYdYyYct4/B5atC494NTEt9xzsu2PoqaV9vCu+uamjVw5vvgiyiEIb/kiKwdFsR7X4qJ3xNaWMg3heKZBTmNMAJshTGhGdz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cg86LLZm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B72C4CEF8;
	Wed,  5 Nov 2025 11:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762343252;
	bh=rByHzTDi8GNI4VjgdYw6keFPO0iICIg6fPIKaXxnABc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cg86LLZmZvaS640pryi2nqiIXgCYl+2loDa4wCmigGCPFYqxEfdcimuJQegQBKLAn
	 JGstJyrE36Z4DWcgmjabR46+0HuqdLlqRni49TyrctQC1j4h4vpBFUJBR0FSZ0rVKA
	 5Po69MmtyqZ9aLUudcv3EHLqYOUrGuf78Pu8h/wbMd2JJWDv/kOB9q5e04GWVidQrz
	 VCQ8+Dg68EWSX772eUT2G/9LNmmGMPkFkh+2DCdQKikNpQFI6fr1N1PrhCeSCun97l
	 Ro396elp4sC7nvfAmLsaTQJSPyWgw9SXl/kXx6Vy5MNioKQ2GtoXeosAXztX/pe9y7
	 2PpLayzOKdcbA==
Date: Wed, 5 Nov 2025 11:47:29 +0000
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, 'Andrew Lunn' <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	'Eric Dumazet' <edumazet@google.com>,
	'Jakub Kicinski' <kuba@kernel.org>,
	'Paolo Abeni' <pabeni@redhat.com>,
	'Mengyuan Lou' <mengyuanlou@net-swift.com>, stable@vger.kernel.org
Subject: Re: [PATCH net] net: libwx: fix device bus LAN ID
Message-ID: <aQs5UeY214tiuL3f@horms.kernel.org>
References: <B60A670C1F52CB8E+20251104062321.40059-1-jiawenwu@trustnetic.com>
 <aQsf2tTu3_FAeRic@horms.kernel.org>
 <093901dc4e3b$b753c630$25fb5290$@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <093901dc4e3b$b753c630$25fb5290$@trustnetic.com>

On Wed, Nov 05, 2025 at 06:05:29PM +0800, Jiawen Wu wrote:
> On Wed, Nov 5, 2025 5:59 PM, Simon Horman wrote:
> > On Tue, Nov 04, 2025 at 02:23:21PM +0800, Jiawen Wu wrote:
> > > The device bus LAN ID was obtained from PCI_FUNC(), but when a PF
> > > port is passthrough to a virtual machine, the function number may not
> > > match the actual port index on the device. This could cause the driver
> > > to perform operations such as LAN reset on the wrong port.
> > >
> > > Fix this by reading the LAN ID from port status register.
> > >
> > > Fixes: a34b3e6ed8fb ("net: txgbe: Store PCI info")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > 
> > Hi Jiawen Wu,
> > 
> > I am wondering if these devises also support port swapping (maybe LAN
> > Function Select bit of FACTPS). And if so, does it need to be taken into
> > account here?
> 
> Does not support yet, thanks. :)

Thanks, in that case this patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


