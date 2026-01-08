Return-Path: <stable+bounces-206371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A6852D041F2
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 17:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DD40324AD2A
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30D43446BE;
	Thu,  8 Jan 2026 15:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B/yqpTqu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A3A33C19C;
	Thu,  8 Jan 2026 15:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767886125; cv=none; b=EKiqM4b2FRzCcbjInZ/t3cV4+jpf6yYqZ5mJLFT2FfDBIiV9df5gW2qQjevfkF1r6NgTT9b9yA2OUeqbAOdjBxKIr1O/A2fnD255TVbphwjreegAYmyn1jCp0iNYF6c9DbJj0dQpX/9YT4YWXgHn1nrbu2l8oK4VqKCLfQDSBYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767886125; c=relaxed/simple;
	bh=bKD2LM4fqdmVZGz39sa0/8n24G72t6+Gfktzi9MhWKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmZX9tVG1ESW3xsulgeXGVyftbVwfuXpyP4WYXDVcaGBEEgQJPgJ+FeSMH7nvqvp1m27KCQgneLzXtYBUTkT/QjpB44fRN1Rj2mZyQTGI4ByMcc/eAnrcCPtjGonJ7nPQsTLiVs4iFaqi5FbEpPhztfLGx8GDVI5xfHrTwoM9rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B/yqpTqu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9CEC116C6;
	Thu,  8 Jan 2026 15:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767886125;
	bh=bKD2LM4fqdmVZGz39sa0/8n24G72t6+Gfktzi9MhWKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B/yqpTqupv6IPneUdPfLboTtWBzumpwMg9DDYJyKX2/SkaiKLxXHwf9CkLF2HXWXj
	 p8ggED1BfYhsR/8j+JLxuaUkIoggIjIEkO9NNdyVqXd8HqwrI1e/DQhBtZTXynh2LK
	 STepRWheL97MnnGAVMJ6tbNj7VnpP54gMYy9yOaQ=
Date: Thu, 8 Jan 2026 16:28:42 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: mathias.nyman@intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: xhci: Fix memory leak in xhci_disable_slot()
Message-ID: <2026010840-rage-sprang-2662@gregkh>
References: <20260108141108.993684-1-zilin@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108141108.993684-1-zilin@seu.edu.cn>

On Thu, Jan 08, 2026 at 02:11:08PM +0000, Zilin Guan wrote:
> xhci_alloc_command() allocates a command structure and, when the
> second argument is true, also allocates a completion structure.
> Currently, the error handling path in xhci_disable_slot() only frees
> the command structure using kfree(), causing the completion structure
> to leak.
> 
> Use xhci_free_command() instead of kfree(). xhci_free_command() correctly
> frees both the command structure and the associated completion structure.
> Since the command structure is allocated with zero-initialization,
> command->in_ctx is NULL and will not be erroneously freed by
> xhci_free_command().
> 
> This bug was found using an experimental static analysis tool we are
> developing. The tool is based on the LLVM framework and is specifically
> designed to detect memory management issues. It is currently under
> active development and not yet publicly available, but we plan to
> open-source it after our research is published.
> 
> The analysis was performed on Linux kernel v6.13-rc1.

That is a very old kernel version, from December 2024, please redo this
to verify it is relevent to todays tree.

thanks,

greg k-h

