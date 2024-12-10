Return-Path: <stable+bounces-100428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C71F9EB1FC
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 14:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77AC2169592
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 13:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C141A0AFA;
	Tue, 10 Dec 2024 13:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DUDXt4WL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A280823DEB6
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 13:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733837682; cv=none; b=ZWIJtXD17puqfMPgFhcncu4zlyDlII23pqAoopOZ90JeGI3geRhjfm6L3rhH3wgSEfacl05P9WmXjP6Svie3++lkUS3Tjs7znJGaMhMgRsNGxSugTUQBGAUzeNthdHEqPEC/V7wA2dJxO1oez2DMjIW5RDs3HtWuNHMz7hCy98k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733837682; c=relaxed/simple;
	bh=c0i0DY1mutXbi2TEbC91+5YgkGfWNYD7DTLfjYGAmhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RR+zbI+FFhybdIkfdh+FPb0qepUT3jne/k3pEEMo7LskJJULJjf8n3QBlm2LKi7KzTnOCNl17jESie+ClDXfO3RO0Niyv2sfw91p0+YNy9Z9VZr0Zv+Og//gmjRaNETLwA6G1BeeoWJS+e+gUddRQ2bbD4hQX67s7gg2mbbWiIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DUDXt4WL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18E2C4CED6;
	Tue, 10 Dec 2024 13:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733837682;
	bh=c0i0DY1mutXbi2TEbC91+5YgkGfWNYD7DTLfjYGAmhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DUDXt4WLdrlESnt6BDu6lIW5MqqUsz6yIld3nfaehYrvn1giSpaSBan9Aj6IIj582
	 buCdM9kb/HT1IJ5mod1gvivYlqxUqN9EvylFgYDJ4eCHj43fd1WU459gsdwsHWZHQ/
	 hpLgN85VFBpWd1t4MhBEvM6kLO2Cst71JmtQNCZQ=
Date: Tue, 10 Dec 2024 14:34:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Bilge Aydin <b.aydin@samsung.com>
Cc: stable@vger.kernel.org
Subject: Re: [APS-24624] Missing patch in K5.15 against kernel panic
Message-ID: <2024121023-unrushed-envelope-477d@gregkh>
References: <CGME20241210132338eucas1p2228b89f17ab46f90075c07806765a5aa@eucas1p2.samsung.com>
 <0bd701db4b06$b7cbdf00$27639d00$@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bd701db4b06$b7cbdf00$27639d00$@samsung.com>

On Tue, Dec 10, 2024 at 02:23:35PM +0100, Bilge Aydin wrote:
> This communication (including any attachments) contains information which may be confidential and/or privileged. It is for the exclusive use of the intended recipient(s) so, if you have received this communication in error, please do not distribute, copy or use this communication or its contents but notify the sender immediately and then destroy any copies of it. Due to the nature of the Internet, the sender is unable to ensure the integrity of this message. Any views expressed in this communication are those of the individual sender, except where the sender specifically states them to be the views of the company the sender works for.

Note, this footer is not compatible with kernel development at all, and
normally causes emails to be automatically deleted.  For some reason it
snuck through my filters, but for many others, it might not have.
Please remove it on your responses.

thanks,

greg k-h

