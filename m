Return-Path: <stable+bounces-208010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 798AED0F138
	for <lists+stable@lfdr.de>; Sun, 11 Jan 2026 15:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A8173008754
	for <lists+stable@lfdr.de>; Sun, 11 Jan 2026 14:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A11F342529;
	Sun, 11 Jan 2026 14:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KYnNa4fq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C734134166A;
	Sun, 11 Jan 2026 14:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768140899; cv=none; b=FHt4wgaYlL7IXf24eXEDZxFS/HLU4GwPcDuX5622axWJ6b6G7RTxd1ibDWn084ovd5YGNDehEdlW/PvBQgurRRutVqG8P6cRDDfUZv/tTLWfnWJ+0Erp/JMgSwPw2w9qZ6jcPXY0+PKkovPLnby9BcIweLo8/ET8IOvBcEadrFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768140899; c=relaxed/simple;
	bh=CAExFAd+aXH2ZkxImDXx0EDCppwYhc5m/85E3QJQPiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJqRgPJe3yj6u6mibU2ezyyX6dwzocR+bObNXTFPf1YEdLphB8hDQroqfC0JnFdaWHpUynGGMB0kaUO9tU7QGpDUluLSiwaUYpADIGcMtixyZKafzR5vyitedmFRvP1IjsNbw5jqZCz7w/sRiP53E66rfTRBwb7qsFuTKx4Zteg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KYnNa4fq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DD0C4CEF7;
	Sun, 11 Jan 2026 14:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768140899;
	bh=CAExFAd+aXH2ZkxImDXx0EDCppwYhc5m/85E3QJQPiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KYnNa4fqUAuDClzKtSYvJzO7tErnAqtVNRecSfY5I/9adiyCX2hC6nJMf/gCcXtZQ
	 Qz2NyX2AOdg9bjpyl7kfGpz/MBgjtoIcdBuaoFb8rH0lFrAvx/MbcxyVUG3rq0tfeI
	 dM2X6D7JG6m1TBdfuxzUaL85IVYE2FIRXhga9YIM=
Date: Sun, 11 Jan 2026 15:14:56 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Marnix Rijnart <marnix.rijnart@iwell.eu>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] serial: 8250_pci: Fix broken RS485 for F81504/508/512
Message-ID: <2026011131--a837@gregkh>
References: <20260111135933.31316-1-marnix.rijnart@iwell.eu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111135933.31316-1-marnix.rijnart@iwell.eu>

On Sun, Jan 11, 2026 at 02:59:17PM +0100, Marnix Rijnart wrote:
> v1: https://patch.msgid.link/20250923221756.26770-1-marnix.rijnart@iwell.eu
> Changes: 
>  * Added fixes tags
>  * Cc stable

This needs to go below the --- line, so that it doesn't show up in the
changelog.  The in-kernel documentation should explain this.

thanks,

greg k-h

