Return-Path: <stable+bounces-9257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5DA822B5F
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 11:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3958B236BA
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 10:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D93E18C07;
	Wed,  3 Jan 2024 10:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a1I+bCo6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB04819444
	for <stable@vger.kernel.org>; Wed,  3 Jan 2024 10:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D2DC433C8;
	Wed,  3 Jan 2024 10:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704277633;
	bh=U2ak+Qn/423h++xoN7IFG2I8zcB6zqnAKd73s6D/HaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a1I+bCo6O+85w0KOoeD+KkgR9IheGIzBmdmePgrNPVCi6E0IEBlTFE1bp+xzXkWRM
	 8qzAdicfYz5MPoVIpHK41Uj5uzAdBF+T+1JrgTvmQmxlFrTAVB6f19bFsl1cev8Igd
	 YUxlQ6feygPIkpJs7ARkGJvF3BhuiqvSZx2KBGDs=
Date: Wed, 3 Jan 2024 11:27:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: snitzer@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] dm-integrity: don't modify bio's
 immutable bio_vec in" failed to apply to 4.14-stable tree
Message-ID: <2024010358-refried-gnat-7122@gregkh>
References: <2023123006-koala-satirical-e348@gregkh>
 <39b21411-d7f4-5e47-9d4-5ef99bc4967f@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39b21411-d7f4-5e47-9d4-5ef99bc4967f@redhat.com>

On Tue, Jan 02, 2024 at 03:10:42PM +0100, Mikulas Patocka wrote:
> 
> 
> On Sat, 30 Dec 2023, gregkh@linuxfoundation.org wrote:
> 
> > 
> > The patch below does not apply to the 4.14-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> Hi
> 
> Here I'm sending backport of the patch
> b86f4b790c998afdbc88fe1aa55cfe89c4068726 for the stable branch 4.14.

All now queued up, thanks.

greg k-h

