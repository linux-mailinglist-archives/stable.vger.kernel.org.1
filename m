Return-Path: <stable+bounces-110930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E93A20409
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 06:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC9B3A7008
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 05:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4126D176AC5;
	Tue, 28 Jan 2025 05:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eIfbLdV+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB7913F43A
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 05:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738042495; cv=none; b=izExfed30tcJNKVLhudu8u3XXC9veQFqKewmqQ8PCBkzteFx0lNWwF8DqS+EHouIVdCNvGgMnqV875yt/s/RKSXg6fxT4zCItY2UjfMS1bzIqEKl/xiZlfoErpnLPt2GuGjoc4otC1+uG6bTDozcd3j0lDMQsHh5+l7TCc+yxns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738042495; c=relaxed/simple;
	bh=J5RRyJCp3L0bnLshvUkOEgTkJwxflc0e9eED1UPhXQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7vsLkHGcAsbkp8nnvKiRmLZ1tgk6h1ZWaeR2ku0gF/ZscQiuRvR/Qv8wmxIRUj70cVPaKjvjnds/RoMNjRBDzblZdO0i2Ni5WrXAzckX+u+NFpdmVHdZzXdsJkVMovpsx77hcJ3dft3DhaYh3b0dJDs101EsUNDrU8BnD1Uy4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eIfbLdV+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F88C4CED3;
	Tue, 28 Jan 2025 05:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738042494;
	bh=J5RRyJCp3L0bnLshvUkOEgTkJwxflc0e9eED1UPhXQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eIfbLdV+UQDi65XF9ZI5yvU+yysrBgR+8TkNTqXAjYbhv4WMTPRGaB4OscXeBnZ1c
	 3Y8isHgnF5BM4lpaoL3pTNiFqBX7gRCwj9IVoXp0zGpeqy+N1R5urjSZ3W9z+EiU8n
	 EBUcG48Wdc6M5kCh8hmURk5fB4pIocVdEAiEywZY=
Date: Tue, 28 Jan 2025 06:34:51 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: stable@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 6.6.y] scsi: storvsc: Ratelimit warning logs to prevent
 VM denial of service
Message-ID: <2025012827-ripcord-dismantle-4091@gregkh>
References: <20250127182908.66971-1-eahariha@linux.microsoft.com>
 <2d31d777-6732-4075-aedc-a832c9713bdb@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d31d777-6732-4075-aedc-a832c9713bdb@linux.microsoft.com>

On Mon, Jan 27, 2025 at 11:25:17AM -0800, Easwar Hariharan wrote:
> On 1/27/2025 10:29 AM, Easwar Hariharan wrote:
> > commit d2138eab8cde61e0e6f62d0713e45202e8457d6d upstream
> > 
> > If there's a persistent error in the hypervisor, the SCSI warning for
> > failed I/O can flood the kernel log and max out CPU utilization,
> > preventing troubleshooting from the VM side. Ratelimit the warning so
> > it doesn't DoS the VM.
> > 
> > Closes: https://github.com/microsoft/WSL/issues/9173
> > Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> > Link: https://lore.kernel.org/r/20250107-eahariha-ratelimit-storvsc-v1-1-7fc193d1f2b0@linux.microsoft.com
> > Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> > Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> > Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> > ---
> >  drivers/scsi/storvsc_drv.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> 
> I just remembered that we should wait for Linus to tag the rc before
> sending backports, so apologies for sending this (and its 6.1 and 6.12
> friends) out before rc1 was tagged.

Why was this not tagged for stable in the first place?

thanks,

greg k-h

