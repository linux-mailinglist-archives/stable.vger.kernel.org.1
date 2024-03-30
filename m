Return-Path: <stable+bounces-33789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB39892996
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 07:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96B1B1C20FCA
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 06:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4781C0DEA;
	Sat, 30 Mar 2024 06:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tp+Hask8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ED21C2E
	for <stable@vger.kernel.org>; Sat, 30 Mar 2024 06:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711781884; cv=none; b=dEUd13b4sO7oA4W0SFbtIRO+SG6gJB69QI2sU3kkV0psoHC166x/GTD/9C3G8nChHlp4Il7bkWcVObLC9xSwzF2/cJ55MRUwnko3nem8JXZaZabq0TwIm2BwVx2LYBf6QHBZDXmcdmkWRtvQOkCrXvEMy4eXoYUH4iQ/fdzXQx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711781884; c=relaxed/simple;
	bh=UmTyocMkHx2aBLr8Rs2cXkil3OPLbSCTWsp4VbjY50Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCe1s7ZSBTZJyYhsbsfu+2IkAYsQNmAZtrulY4Jd0pkcsZbiUeXfPguB29q4fDUlmG9wrcLM0nRtM75EDEv3kc8JotpFEC96JLwCXt4rHBbUdNvxH4xBou3y4ZHsyqCq/4fPM1jdnPWcfIm1dDkvS4KNJzHzjiorVeuBTl7b4BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tp+Hask8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4108DC433C7;
	Sat, 30 Mar 2024 06:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711781883;
	bh=UmTyocMkHx2aBLr8Rs2cXkil3OPLbSCTWsp4VbjY50Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tp+Hask8yMnN+5aWmA726X4jrfNVhodUg/cIfX9iG8nJXkJEF0cdfWxsBKR+/Wlu0
	 rV5ndL0YE4A8kmYA5L3whJGYaLrH8VzzDWcL6SBcG6rHptY/4HRZndxi3yF/4qgRTs
	 L9ixiuqBCiQlYBJBpD1cuVgBFs6DgmqIQsGFk5Uc=
Date: Sat, 30 Mar 2024 07:58:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Li Lingfeng <lilingfeng3@huawei.com>
Cc: Li Lingfeng <lilingfeng@huaweicloud.com>, stable@vger.kernel.org,
	jsperbeck@google.com, beanhuo@micron.com, hch@lst.de,
	axboe@kernel.dk, sashal@kernel.org, yukuai1@huaweicloud.com,
	houtao1@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 5.10] nvme: use nvme_cid to generate command_id in trace
 event
Message-ID: <2024033017-trapdoor-attendant-389f@gregkh>
References: <20240306112506.1699133-1-lilingfeng@huaweicloud.com>
 <2024032924-cadet-purely-06a9@gregkh>
 <8b1a93be-0d1f-f67d-0a28-9f4eb7d9e9fe@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b1a93be-0d1f-f67d-0a28-9f4eb7d9e9fe@huawei.com>

On Sat, Mar 30, 2024 at 09:30:57AM +0800, Li Lingfeng wrote:
> 
> 在 2024/3/29 19:59, Greg KH 写道:
> > On Wed, Mar 06, 2024 at 07:25:06PM +0800, Li Lingfeng wrote:
> > > From: Li Lingfeng <lilingfeng3@huawei.com>
> > > 
> > > A null-ptr-deref problem may occur since commit 706960d328f5 ("nvme: use
> > > command_id instead of req->tag in trace_nvme_complete_rq()") tries to get
> > > command_id by nvme_req(req)->cmd while nvme_req(req)->cmd is NULL.
> > > The problem has been sloved since the patch has been reverted by commit
> > > 929ba86476b3. However, cmd->common.command_id is set to req->tag again
> > > which should be ((genctl & 0xf)< 12 | req->tag).
> > > Generating command_id by nvme_cid() in trace event instead of
> > > nvme_req(req)->cmd->common.command_id to set it to
> > > ((genctl & 0xf)< 12 | req->tag) without trigging the null-ptr-deref
> > > problem.
> > > 
> > > Fixes: commit 706960d328f5 ("nvme: use command_id instead of req->tag in trace_nvme_complete_rq()")
> > This committ is reverted in the 5.10.208 release, so is this change
> > still needed?
> > 
> > thanks,
> > 
> > greg k-h
> As described by commit 706960d328f5 ("nvme: use command_id instead of
> req->tag in trace_nvme_complete_rq()"), we should use command_id instead of
> req->tag in trace_nvme_complete_rq(). So I don't think it's appropriate to
> just revert it.

It's been reverted, and is in a release, so if you want something
changed here, it needs to be sent as a new change.

thanks,

greg k-h

