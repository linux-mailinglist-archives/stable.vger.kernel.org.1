Return-Path: <stable+bounces-2595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0D57F8C26
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 16:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8781C20BE9
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 15:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8485128E39;
	Sat, 25 Nov 2023 15:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aK0l1Yn4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4510224218;
	Sat, 25 Nov 2023 15:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E37C433C8;
	Sat, 25 Nov 2023 15:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700927198;
	bh=EcZGgQJpJcf+gJ1kXbUQtBfF/3RSWYJfJeXeM5hrUjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aK0l1Yn4fQ6ssigGRDoTmfKopSkLOHBM9xO36rqArtdyYBPtKFbLmfO28A/iWwXwe
	 g9/FheL/2In/l8K1aPJQQ4gxlSDTEBp58jjeLbi3Yd+FVZHGSDyFaxX7tgOnjdKxbv
	 6gK+u2f6l71WTZeWFfvK5amkegDwtPeP+R3fgUts=
Date: Sat, 25 Nov 2023 15:46:35 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 5.4 102/159] parisc/power: Fix power soft-off when
 running on qemu
Message-ID: <2023112529-shading-reveal-744a@gregkh>
References: <20231124171941.909624388@linuxfoundation.org>
 <20231124171946.135466035@linuxfoundation.org>
 <ea2ad6bb-22a5-4100-937f-eff9d9bc5f4d@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea2ad6bb-22a5-4100-937f-eff9d9bc5f4d@gmx.de>

On Fri, Nov 24, 2023 at 08:48:17PM +0100, Helge Deller wrote:
> On 11/24/23 18:55, Greg Kroah-Hartman wrote:
> > 5.4-stable review patch.  If anyone has any objections, please let me know.
> 
> Please drop this patch from all stable kernels < 6.0.
> It depends on code which was added in 5.19...

Now dropped, thanks.

greg k-h

