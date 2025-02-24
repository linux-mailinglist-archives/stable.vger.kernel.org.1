Return-Path: <stable+bounces-118923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE18A41FB2
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 13:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0592E1659D3
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E275323BD04;
	Mon, 24 Feb 2025 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wd2mJdCh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923CF23BD00;
	Mon, 24 Feb 2025 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740401323; cv=none; b=UShhU38ArOmjL9s3hid4KJPm4C8BwIdIq9hlBWMzHY3mc/bqWXf6ggblyZepXGNPjgwpYF3nv7rirMyMyu8FxDKlajdHGbQIH1TXmtAcBsicvPdwdOY3GKk7RoTIeo87yhR7Q9fTQ3mUEx2BhuMOBT9dU03hvaJQnNUMxr4PL4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740401323; c=relaxed/simple;
	bh=t2oFCbePl5zWYdAkJbTnFTKukSqDIBGCcwzqRSvEdMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNWE8/4B8167XwCRIgKy0aF2Ejn6ukQwEkb3GB3i26AreTooPo54n5JgWfTMh5+xn4yjjXOUYQTd+d7W9abvWmyMPj5zG8kaVINmtkqwP/+IALODLzB0glttGir/7lKaAK7fxrYpaKM/YNpStokoiOknbFqAjjybk9C1JaHv5ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wd2mJdCh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B75C4CED6;
	Mon, 24 Feb 2025 12:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740401322;
	bh=t2oFCbePl5zWYdAkJbTnFTKukSqDIBGCcwzqRSvEdMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wd2mJdChu3Erc3GCpcEaPPO9X+PJglImNOREvEdhM6EbwWZ3LfAkWGtPATUhmz/s8
	 gn195YsYUoPQIIZAc9I95G4vVdPPk63O4GS96Lr6ap/ZQfw9rnDF1kXDBdXbAPyslV
	 ZlzXTPXfnpwGXwBe88PYqcfib7PizS/P8z8DpwbI=
Date: Mon, 24 Feb 2025 13:48:38 +0100
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
Message-ID: <2025022434-subsiding-esquire-1de2@gregkh>
References: <20250224121831.1429323-1-jkeeping@inmusicbrands.com>
 <tencent_09E5A20410369ED253A21788@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_09E5A20410369ED253A21788@qq.com>

On Mon, Feb 24, 2025 at 08:36:20PM +0800, Wentao Guan wrote:
> Hello,
> Thanks for reply.
> + Cc: stable@vger.kernel.org
> 
> BRs
> Wentao Guan

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

