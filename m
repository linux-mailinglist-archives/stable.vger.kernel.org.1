Return-Path: <stable+bounces-33156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D611891840
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 13:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D6A01C21C25
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 12:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEFB7E111;
	Fri, 29 Mar 2024 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yRDP3P7E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4976A02A
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711713597; cv=none; b=QdoIKqG9rkV9AhFS7rdZUuVfLxc650STkXakMCFpiYJH1fuzF53H0bptVEwOs2CPK6leTSEU2mQpQ3OMemlV3Axac0Bu020FuUNqKXUQoo4D3Q4GdveMxjUyU6QIA6/cLTpVPb8Gg1a/Ztmz/Q+MtvLqTj9jVhtjzMjUNY0vdVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711713597; c=relaxed/simple;
	bh=RSz981FzmqDRw9x4P9agLW4GAoPtVPagtjCNMXcZ2UI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRRelUVDnFXHCtfIdFlPFtgBhwt9q/hgz5gFOpwWvUPTs7WfqNMgFPz5gx3iPUvIpxdqcFb3ibzsoSyo7Maeviib9+U6j48urgiHs9dJr4k2W8mvLX5vXUepL3s1qy53Sdw49LRt5f3JWAia57fRdrPje+0UK+9hOHSP793ZNEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yRDP3P7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E680BC433F1;
	Fri, 29 Mar 2024 11:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711713597;
	bh=RSz981FzmqDRw9x4P9agLW4GAoPtVPagtjCNMXcZ2UI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yRDP3P7EatQV7ZHOPnNVtydzNN1ZxNLCr2f6OfiYhNReJe54DlIsWNstz8XXP6PWT
	 vSjzaE0uGita2RoPg5N8UwiNMt12XgcZ2c6/hoCzVchqg/LdozGYvQouW1bI4q/k0Z
	 41bUfxmzdkIDVowFYvVXnRtXBIQIJbzHWn4bc6aU=
Date: Fri, 29 Mar 2024 12:59:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Li Lingfeng <lilingfeng@huaweicloud.com>
Cc: stable@vger.kernel.org, jsperbeck@google.com, beanhuo@micron.com,
	hch@lst.de, axboe@kernel.dk, sashal@kernel.org,
	yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com,
	yangerkun@huawei.com, lilingfeng3@huawei.com
Subject: Re: [PATCH 5.10] nvme: use nvme_cid to generate command_id in trace
 event
Message-ID: <2024032924-cadet-purely-06a9@gregkh>
References: <20240306112506.1699133-1-lilingfeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306112506.1699133-1-lilingfeng@huaweicloud.com>

On Wed, Mar 06, 2024 at 07:25:06PM +0800, Li Lingfeng wrote:
> From: Li Lingfeng <lilingfeng3@huawei.com>
> 
> A null-ptr-deref problem may occur since commit 706960d328f5 ("nvme: use
> command_id instead of req->tag in trace_nvme_complete_rq()") tries to get
> command_id by nvme_req(req)->cmd while nvme_req(req)->cmd is NULL.
> The problem has been sloved since the patch has been reverted by commit
> 929ba86476b3. However, cmd->common.command_id is set to req->tag again
> which should be ((genctl & 0xf)< 12 | req->tag).
> Generating command_id by nvme_cid() in trace event instead of
> nvme_req(req)->cmd->common.command_id to set it to
> ((genctl & 0xf)< 12 | req->tag) without trigging the null-ptr-deref
> problem.
> 
> Fixes: commit 706960d328f5 ("nvme: use command_id instead of req->tag in trace_nvme_complete_rq()")

This committ is reverted in the 5.10.208 release, so is this change
still needed?

thanks,

greg k-h

