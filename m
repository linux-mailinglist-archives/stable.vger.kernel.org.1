Return-Path: <stable+bounces-192128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D9CC29C1E
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 02:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27FCD3AC313
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 01:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D9C25F98E;
	Mon,  3 Nov 2025 01:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ePe9WMQM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3559469D;
	Mon,  3 Nov 2025 01:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762131934; cv=none; b=a446Wd4EK1rfl+vAwL6qULtPf88FIyKEGkIrUJlh3MKwMnCpYdNCLAgk4at6SkicaoL51kpdsPJRWgk1J/n7dR0yFOZ/tDA1sEWNYOwzLd1ZnN2BaqaZMqnDIrtdYKwM/Fi/vrqnd/tRB7u5RJnxOvXIhT41iHFY03efsDahyf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762131934; c=relaxed/simple;
	bh=t4CMx/PQ3CV9US9oD0nskeFMR2z4iplh7kwDMnHyRTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8sr4UUlE7zcKPDoVsxaKGtGngJy8R8/yA8A4QBb8S5fubKEC08NdrWj9OUnQQD2qlXIrHgeHlCCzyz8LJHHZWbGW8KN9l5ZP0qoQQm9RLR2unbyIZ5wdST0ZQL3hNfUFcmPHgJpEv3Ktgy+Y2ryndM5rnegTm7sFaZkWcT7sGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ePe9WMQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B488C4CEF7;
	Mon,  3 Nov 2025 01:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762131933;
	bh=t4CMx/PQ3CV9US9oD0nskeFMR2z4iplh7kwDMnHyRTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ePe9WMQMuR1WpDTXlyHED+8bBel8CeeDofq/YwfE7BbHkk/3qszMJcIvDqacyii/+
	 N5oQIY6VUzNIJUqluJZR2KlutR1IVDlGejcoTYdASdXQJhQYpEZaostTMPGs69gBz9
	 NJ9sOO+TQK9N7tV8EalVRc4I65PZDeSL0aYVsA3A=
Date: Mon, 3 Nov 2025 10:05:31 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Miaoqian Lin <linmq006@gmail.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ruan Jinjie <ruanjinjie@huawei.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] misc: eeprom/idt_89hpesx: prevent bad user input in
 idt_dbgfs_csr_write()
Message-ID: <2025110351-mountain-absently-f9f1@gregkh>
References: <20251030052834.97991-1-linmq006@gmail.com>
 <0f712780-8af0-4894-b75c-44fd7390dc3e@app.fastmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f712780-8af0-4894-b75c-44fd7390dc3e@app.fastmail.com>

On Thu, Oct 30, 2025 at 09:47:22AM +0100, Arnd Bergmann wrote:
> On Thu, Oct 30, 2025, at 06:28, Miaoqian Lin wrote:
> > A malicious user could pass an arbitrarily bad value
> > to memdup_user_nul(), potentially causing kernel crash.
> 
> I think you should be more specific than 'kernel crash' here.
> As far as I can tell, the worst case would be temporarily
> consuming a MAX_ORDER_NR_PAGES allocation, leading to out-of-memory.

I think we already limit the size of writes so this shouldn't happen,
but a real trace would be good to see.

> > Fixes: 183238ffb886 ("misc: eeprom/idt_89hpesx: Switch to 
> > memdup_user_nul() helper")
> 
> I don't think that patch changed anything, the same thing
> would have happened with kmalloc()+copy_from_user().
> Am I missing something?
> 
> > +	if (count == 0 || count > PAGE_SIZE)
> > +		return -EINVAL;
> > +
> 
> How did you pick PAGE_SIZE as the maximum here?

I agree, that seems very very small.

thanks,

greg k-h

