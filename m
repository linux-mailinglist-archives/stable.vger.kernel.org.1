Return-Path: <stable+bounces-127529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54532A7A48C
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 16:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75AA6177AFC
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 14:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B590124EA95;
	Thu,  3 Apr 2025 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HJLdDmTa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7268624BC09
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743688850; cv=none; b=Y2ByR2omaTR02oT4c1mL1XlFijU7cpr55/4nO9LQx8bUahnOma8bFK1IiIucQ0r0aJB2rWHq49Djo6/8BZ9da00/x1NDRKCIwSC4P4zADa7Sfq/6TWtnYrqRejA1Kpdmr5KXGIEvZ8qrZGgvTxkBAZkSioj1PbQyj/c5xYnAgAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743688850; c=relaxed/simple;
	bh=Pql5oGKBm2bxIT3axWM906N0fCcHsNpzg3g302o9eqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjHJGhDWt1aPcdSy5KiwrrR7LApnI2dYVmJWWl5EfXyve1PYl56qAquUicp1CLmnYPgworyD96cxN1lVIjmidJDx1vyaq1pgr0EZACCJFa76Ar/lsYwThoNTZ/ECvlOPAIZba/V8IFbDbzv6Y81lYWhW+XbaKVQ7/pIawHc3htA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HJLdDmTa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981A7C4CEE3;
	Thu,  3 Apr 2025 14:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743688849;
	bh=Pql5oGKBm2bxIT3axWM906N0fCcHsNpzg3g302o9eqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HJLdDmTa+ReiWKnTlzRPM2lOxZDF9IcbxkK3TfrP4xk3DYmai4yGzLtc1FTm/TPlV
	 CYmsPtH4MXkyRRczgQNOp6bGyC3PIHX2Tzag4E8n4ItwwPhm75Yw4I/kn5FtuKJPgj
	 LKp0AL84MEmvV5+FH9/MY7zwLFH7LE+gvz6/yMxs=
Date: Thu, 3 Apr 2025 14:59:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hardik Gohil <hgohil@mvista.com>
Cc: stable@vger.kernel.org
Subject: Re: Request to back-port this patch to v5.4 stable tree
Message-ID: <2025040350-rink-overcoat-4696@gregkh>
References: <CAH+zgeGNArHoJw4rfd+Q-WQhv_rk+5wke7kYz_LaXNjXNocQew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH+zgeGNArHoJw4rfd+Q-WQhv_rk+5wke7kYz_LaXNjXNocQew@mail.gmail.com>

On Thu, Apr 03, 2025 at 03:36:05PM +0530, Hardik Gohil wrote:
> Hello Greg,
> 
> This patch applies cleanly to the v5.4 kernel.
> 
> dmaengine: ti: edma: Add some null pointer checks to the edma_probe
> 
> [upstream commit 6e2276203ac9ff10fc76917ec9813c660f627369]
> 

You obviously did not test-build this change :(

Please always do so when asking for patches to be backported, otherwise
we get grumpy as it breaks our workflow...

thanks,

greg k-h

