Return-Path: <stable+bounces-118933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11688A420DB
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E259D173F24
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 13:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8A224BC09;
	Mon, 24 Feb 2025 13:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tksIjIBd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7C42571DC;
	Mon, 24 Feb 2025 13:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740404050; cv=none; b=cMOYmPnCfXcIGeZkfUGfi8DZOuhGQfIYT+nr7EaOmyJr4+ePqrWF75gmqA1ltfizCr7IEf5iArQBLL9j/PtE/ewh3p7tzInv+Buw3KZBHSrTGxCaiumCgNOpXlNIROBd3m8op2ZlQc55jvtF8DGJwciE8DBkj4VFBEc1rdNDlkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740404050; c=relaxed/simple;
	bh=O1g9YpmRTKtF8ny+jy7VStaZy5dhgXTC4fa969BsXPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gC0m3tWw3bfFRWIvph+HW5fjO1qmwF+mlMw8zIBDEui3mT7ui1wKMUy8NNFjd1mdx7/HNqpJ54oA/IICSHY3LyWyHD9GvxiUvBuLjJHQhIXLVLUwS7WQA+PBdjjuGImimiWlFpbiPtvojkxzRTBksZtudVaFiYsjjWY6UyTp4/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tksIjIBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8AB5C4CED6;
	Mon, 24 Feb 2025 13:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740404049;
	bh=O1g9YpmRTKtF8ny+jy7VStaZy5dhgXTC4fa969BsXPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tksIjIBddikZxdA8rKEx999BeUKIPL4JbtHp7O2zujo/zqt3VZuG0ZT5w7t0WHzet
	 3WxJSXrBnjlco+4YUznzRqvPDDDguuXddq0Oc8Ui9szeFnZ6s6HxDVXvxUfI3raedJ
	 yIVmNrg918/drZzdRFbMFwWQqotCLTmUW3ERHfp4=
Date: Mon, 24 Feb 2025 14:34:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: John Keeping <jkeeping@inmusicbrands.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ferry Toth <ftoth@exalondelft.nl>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>,
	stable <stable@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250_dma: terminate correct DMA in tx_dma_flush()
Message-ID: <2025022433-outmost-married-d021@gregkh>
References: <20250224121831.1429323-1-jkeeping@inmusicbrands.com>
 <tencent_09E5A20410369ED253A21788@qq.com>
 <2025022434-subsiding-esquire-1de2@gregkh>
 <tencent_013690E01596D03C0362D092@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_013690E01596D03C0362D092@qq.com>

On Mon, Feb 24, 2025 at 09:13:29PM +0800, Wentao Guan wrote:
> Hello Greg,
> Sorry for my HTML format past.
> It is means that 'Fixes xxxxxx' tag point commit will auto be backport to those stable tree with
> xxxxxx commit without cc stable, correct ?

I am sorry, again, I have no context at all as to what you are asking :(

remember, some of us get 1000+ emails a day to handle.  Always quote
context properly so we know what is going on.

thanks,

greg k-h

