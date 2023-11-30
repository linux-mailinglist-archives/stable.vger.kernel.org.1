Return-Path: <stable+bounces-3261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0634E7FF32B
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 16:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54CE7B20E48
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 15:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E514E51C2A;
	Thu, 30 Nov 2023 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fMv+iZtc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B0648CF7
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 15:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2077C433C8;
	Thu, 30 Nov 2023 15:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701356726;
	bh=MdwqTtqvRUM9JDIV1bxonjqQxJvkmHoFAMNuKOS/8tA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fMv+iZtcKIDZMgAVUO0wApKgyYP3JcDzsFRKB36PEiQRu/BjyKUxWVWJKQZwAZYiu
	 4425gyVceQz0Ojq1wrSEhXNSUqTrybe0H6c3wxcNu9+FF5skeJJicFG/maYuNBxJHN
	 li3SmTVH2of4c1MVjmopFOObfsJprm3k0rqxdOL4=
Date: Thu, 30 Nov 2023 15:05:23 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: kbusch@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring: fix off-by one bvec index"
 failed to apply to 5.4-stable tree
Message-ID: <2023113016-unknowing-decoy-a13d@gregkh>
References: <2023113025-eastbound-uninstall-c2e0@gregkh>
 <bc136dd7-9b65-4d10-8b0d-105c90246543@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc136dd7-9b65-4d10-8b0d-105c90246543@kernel.dk>

On Thu, Nov 30, 2023 at 07:36:17AM -0700, Jens Axboe wrote:
> On 11/30/23 7:31 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.4-stable tree.
> 
> And the 5.4 variant attached.

Thanks, all backports now queued up.

greg k-h

