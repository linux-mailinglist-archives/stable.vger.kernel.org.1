Return-Path: <stable+bounces-12821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA258377B5
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B18FF1F24FF7
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 23:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EF94D111;
	Mon, 22 Jan 2024 23:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mv/PxXTX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22E54CDEA
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 23:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705965807; cv=none; b=EVsMfyqpoUaM5k4RbO/jNi5K43Ajib2cvJI2kQtkU3VVggEtrZp7shz0Guybst6+1S0f55gx5HiJmgT0dZo+8Pqzy8SVZYyTiHzytvQ59Qa5Smql5wnJcuN6gs1b7RGqjhIvA7QFOBNYx5lXJOvoNeRuCiQZD1jlr2HK+m1zmv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705965807; c=relaxed/simple;
	bh=QSb4hptdikLBiZ5yHlhzewx/WKlODNFoEHBJ6Eo8xtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNVVdma58Qho9MSB4hb0ZfyHqCbBJPDo1c/9uY7fzxW5RbZ/AZ8O8CaPPvvvZTQk+T6+yrOJE4h7gtv4rXqDsgLwPcHigbxGyRxwNxYbP4dlQNmnzMOdNkVfu+oIZTs6qz767uK0uX5GGqitYS9nbLkdUtGtMFjopXR5BkYS63w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mv/PxXTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51478C433C7;
	Mon, 22 Jan 2024 23:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705965806;
	bh=QSb4hptdikLBiZ5yHlhzewx/WKlODNFoEHBJ6Eo8xtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mv/PxXTXn6Kxu6iB6wLrMpVv6hD592fYY0+5Xp4p6CCGywZtehcOZInSVjfA+JEV9
	 2plrDZT3XJPCjhx7g25UgBIls5xFw5ong2JY2vTkhACuI5KGQ4tvGYey648jvGwwLI
	 S+fZ1rfPMu0XXQ9QeT/OkbAPFz5XFyG9oTYrNy6w=
Date: Mon, 22 Jan 2024 15:23:23 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@osdl.org, axboe@kernel.dk, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] block: Remove special-casing of compound
 pages" failed to apply to 6.1-stable tree
Message-ID: <2024012214-switch-caddie-5195@gregkh>
References: <2024012215-drainable-immortal-a01a@gregkh>
 <Za7rqt0I5VaLT6FU@casper.infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za7rqt0I5VaLT6FU@casper.infradead.org>

On Mon, Jan 22, 2024 at 10:26:50PM +0000, Matthew Wilcox wrote:
> On Mon, Jan 22, 2024 at 11:31:15AM -0800, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.1-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> Thanks.  Here's the fix (compile tested only)

Both now queued up, thanks!

greg k-h

