Return-Path: <stable+bounces-139689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A443DAA9480
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 15:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE3713B360A
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 13:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EB01E5218;
	Mon,  5 May 2025 13:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q0DzZ5H5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB72016F8E5
	for <stable@vger.kernel.org>; Mon,  5 May 2025 13:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746451705; cv=none; b=SG805Zp4iFXsKe7vuLmfGpzda7+Jy18POvnu28Bx+nH2D0BCnOUm4eWFCJvWdGmg8cIhOJ0cFVLYwajChJqOYtyfdS8ChbPP6MWUj2Qa61hnq+W6h1DE8ogmJKV/9R3jTlxQk0KENQXNk774ODwOpNHAP2iG4Dmc1rw5Rhvfjsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746451705; c=relaxed/simple;
	bh=cIb6zVBR7upYuSya7nb6v7uPdB2lk1GL7++IrxZublA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahcZEGrWjnCMUwWQXBkTLPv9ETuvPe5HjVVuCW2v7xDxoLLS7OEjmkwzN0vWoxdeOrGt2A20W2vvZ/LTEEWDl+iLPVAulYUliVRHK+Z8fjFus5mLt8+YP5SydGGs8jMSTClWG3vLj5Inh8GurQr9eLufkjfvB+3VvI0TTAAVF7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q0DzZ5H5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2CAC4CEE4;
	Mon,  5 May 2025 13:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746451705;
	bh=cIb6zVBR7upYuSya7nb6v7uPdB2lk1GL7++IrxZublA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q0DzZ5H5IPxDSrllDrQi9huW48jTsD55XPCNPhJb7IA5KKSUgcGvzuNbZqKT5DAsH
	 XEX4X4K8RbviqKFB/rNMbPOvCbKQFsKC38kZ1VVoTZC3GKSAsU7KNOA9hZ/raDbep8
	 cu9ZHl2dRP3Pcc3kZmU9dBzCvXeee/J71h0wqg/4=
Date: Mon, 5 May 2025 15:28:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jack Wang <jinpu.wang@ionos.com>
Cc: Wang Yugui <wangyugui@e16-tech.com>, stable@vger.kernel.org,
	wagi@kernel.org
Subject: Re: [6.12.y] WARNING: CPU: 0 PID: 681 at block/blk-mq-cpumap.c:90
 blk_mq_map_hw_queues+0xcf/0xe0
Message-ID: <2025050554-reply-surging-929d@gregkh>
References: <2025050500-unchain-tricking-a90e@gregkh>
 <6818a2d5.170a0220.c6e7d.da1c@mx.google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6818a2d5.170a0220.c6e7d.da1c@mx.google.com>

On Mon, May 05, 2025 at 01:36:52PM +0200, Jack Wang wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> In linux-6.12.y, commit 5e8438fd7f11 ("scsi: replace blk_mq_pci_map_queues with blk_mq_map_hw_queues")
> was pulled in as depandency, the fix a9ae6fe1c319 ("blk-mq: create correct map for fallback case")
> should have just used 1452e9b470c9 ("blk-mq: introduce blk_mq_map_hw_queues")
> as Fixes, not the other conversion IMO.

What "other conversion"?  Sorry, I do not understand, did we take a
patch we shouldn't have, or did we miss a patch we should have applied?

confused,

greg k-h

