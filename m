Return-Path: <stable+bounces-2596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8969B7F8C27
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 16:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB10B1C20BE3
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 15:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED1A28E35;
	Sat, 25 Nov 2023 15:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="peXjXLGP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDC9C126;
	Sat, 25 Nov 2023 15:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88257C433C8;
	Sat, 25 Nov 2023 15:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700927248;
	bh=VwQ3e1SD03HXVnj9Fm8sAK0m9IQi5fsO0X0L/M6/0fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=peXjXLGPSLyD7qJaD6NJBesLtime5vaqDPpmH+ic57P0kX3KY901kPA20qeQCd2mh
	 DscqDr4BiNkbPQIwLIhpY71EHFjLI2Ztkk9xVbIWrFvWIfi1vU+4zin7xNw4dfrZUq
	 wb7BAAJy/p6ImgIGPjgQENxqTWAYL3gXTIy9zsAA=
Date: Sat, 25 Nov 2023 15:47:26 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 5.4 084/159] parisc/power: Add power soft-off when
 running on qemu
Message-ID: <2023112520-flame-chief-4aba@gregkh>
References: <20231124171941.909624388@linuxfoundation.org>
 <20231124171945.420849740@linuxfoundation.org>
 <ed27b9c1-024c-4839-85cc-91fa88a2271a@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed27b9c1-024c-4839-85cc-91fa88a2271a@gmx.de>

On Fri, Nov 24, 2023 at 08:47:38PM +0100, Helge Deller wrote:
> On 11/24/23 18:55, Greg Kroah-Hartman wrote:
> > 5.4-stable review patch.  If anyone has any objections, please let me know.
> 
> Please drop this patch from all stable kernels < 6.0.
> It depends on code which was added in 5.19...

Now dropped, thanks.

greg k-h

