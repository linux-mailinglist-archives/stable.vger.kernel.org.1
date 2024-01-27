Return-Path: <stable+bounces-16057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F1283E8EE
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 02:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9C7DB24C5A
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 01:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39462907;
	Sat, 27 Jan 2024 01:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a7aifvPt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65539443D
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 01:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706318407; cv=none; b=Z+Es7Jva26qXacwcviY6y2+ke8vQGzwu5DcdhcEIHWQVCQ+jt6wbcXD+/gFsmrQLSkhk3ZxDLjxfPtEjmEltjpKJ8T7ITU5hSpi13aXnsctsAI3h4kDrI4kaKq3nLrBAvHdzpH7kcr9kwr8diH6SnYhS/LOcgwo+inpz8kYjQvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706318407; c=relaxed/simple;
	bh=0ji/mtk22gc4Gz1zjAA9t/PdILLWYwSUFJ/QULRgsnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIfH/ljHN1xHE5ugduQ8xIKLNfTIFbyRl5/onY0tu61d0EAr8A4QDrX07xWFYESTD65hvB++Y0tkO1uElSVehE2OO+YfaQlaAJmSLpoPmZTf4pI5BDBXzIgfW/Qq8KNpJ1i80j0e0uBmZT478KWdEdCGs0lpjPlOzxXRn+8mutQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a7aifvPt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D124CC433F1;
	Sat, 27 Jan 2024 01:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706318406;
	bh=0ji/mtk22gc4Gz1zjAA9t/PdILLWYwSUFJ/QULRgsnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a7aifvPt6NmjljwRKKHFFENyQ/ksxaT/NRGCQsjKBL1p0x7+uBygMCtuvchZPduG3
	 9FsPiQFEUNzfvwPS4ZH2xEkcHbuNEQp+N68raY24n7yLbxqIDljWrXVzOp8O5767PF
	 fyeSQuvAZE1OiTEDpyMsZiPTizi/QyZ2Y+l/6U08=
Date: Fri, 26 Jan 2024 17:20:06 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Shiraz Saleem <shiraz.saleem@intel.com>
Cc: stable@vger.kernel.org, Mike Marciniszyn <mike.marciniszyn@intel.com>
Subject: Re: [PATCH 5.15.x] RDMA/irdma: Fix support for 64k pages
Message-ID: <2024012656-saloon-obnoxious-081d@gregkh>
References: <20240126202144.323-1-shiraz.saleem@intel.com>
 <20240126202144.323-2-shiraz.saleem@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126202144.323-2-shiraz.saleem@intel.com>

On Fri, Jan 26, 2024 at 02:21:44PM -0600, Shiraz Saleem wrote:
> From: Mike Marciniszyn <mike.marciniszyn@intel.com>
> 
> [ Upstream commit 03769f72d66edab82484449ed594cb6b00ae0223 ]
> 

All now queued up, thanks

greg k-h

