Return-Path: <stable+bounces-112154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A77A273F3
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 15:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A09F3A9998
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 14:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE765212B18;
	Tue,  4 Feb 2025 13:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oIw+4xYF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA6D20E002
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 13:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738677372; cv=none; b=dL1kW15CpQWNcPaw4h4L0CRBRiUZ73tBOj+gLmro1PeurjecsdkSgOKzWlrJStEYAxYT6B8axEOPgpAORKpALmXWZtgVZ7xrLdTVvqk9oStvXcSJPkTv5zLc/RITrGRpZKOlndN51ADbGeG0waeAL+tPWwSPjyC4lFLeuLw5y1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738677372; c=relaxed/simple;
	bh=fK8LLug+ADuSjXiddN9JPwyBh+631yx7nHlXX9YPU4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZNIwiwqSD2itq2GEI9LFB7BGEz936YdNotEaydwUslV8uRO+/Xnylh0/q0R2H5GxFm/8zkY+kLlG7Vy9sJK1/QCLGyXxptucyS+OwOpetyItSpEduquphFV4o0aS7uYeBu8Ib/a/umyMSm0JWoS3w3VmAwbI4TRFPA5flYSCJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oIw+4xYF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C35C4CEDF;
	Tue,  4 Feb 2025 13:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738677372;
	bh=fK8LLug+ADuSjXiddN9JPwyBh+631yx7nHlXX9YPU4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oIw+4xYF7a5aHikECX4OcXammM1MvE9lfWUUDu2oEkRjKvxNgQmoNbnvrLnzNoMHk
	 lsIz6xAriN4IB1oPmmzNpY5z/od5lc0uc11vEwc1i0puPzh65UbFiZQ4Qk06vJv2f7
	 MGMx04WpDGDkvN83b78oC71khjBjs7B9J0ZWqJ8o=
Date: Tue, 4 Feb 2025 14:56:08 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hagar Hemdan <hagarhem@amazon.com>
Cc: stable@vger.kernel.org, Puranjay Mohan <pjy@amazon.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Anuj Gupta <anuj20.g@samsung.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 6.1] nvme: fix metadata handling in nvme-passthrough
Message-ID: <2025020400-henna-diocese-80c7@gregkh>
References: <20250203082501.28771-1-hagarhem@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203082501.28771-1-hagarhem@amazon.com>

On Mon, Feb 03, 2025 at 08:24:58AM +0000, Hagar Hemdan wrote:
> From: Puranjay Mohan <pjy@amazon.com>
> 
> [ Upstream commit 7c2fd76048e95dd267055b5f5e0a48e6e7c81fd9 ]
> 
> On an NVMe namespace that does not support metadata, it is possible to
> send an IO command with metadata through io-passthru. This allows issues
> like [1] to trigger in the completion code path.
> nvme_map_user_request() doesn't check if the namespace supports metadata
> before sending it forward. It also allows admin commands with metadata to
> be processed as it ignores metadata when bdev == NULL and may report
> success.
> 
> Reject an IO command with metadata when the NVMe namespace doesn't
> support it and reject an admin command if it has metadata.
> 
> [1] https://lore.kernel.org/all/mb61pcylvnym8.fsf@amazon.com/
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> [ Minor changes to make it work on 6.1 ]
> Signed-off-by: Puranjay Mohan <pjy@amazon.com>
> Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
> ---
> Resend as all stables contain the fix except 6.1.

Good catch, thanks!

greg k-h

