Return-Path: <stable+bounces-139613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19270AA8D81
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 09:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14EE51893C1C
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 07:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897F11DED49;
	Mon,  5 May 2025 07:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rbbDuDPi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343411D5CD1;
	Mon,  5 May 2025 07:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746431652; cv=none; b=WfMdhvUzUzUMRFiRrubNPS4YB05oG5hBJ8Rny8sHc54sTOwqGnS4fDF8oxhPUEUYdw97tOuP/gLQir5ZSpzsbKR5hmBDBD2UrPHLjdQFUl8CQNTV1DIC8WnNUqnoxI+v5tAf0hl9Dy6TNbRa1lbOb8EEXt7MdTBby3MiscT9Cj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746431652; c=relaxed/simple;
	bh=NCF+uIgi02R3qHnuPawdoFmoqZ/yt942FoVFPnxHS+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPbfaovXk/VpEfpv5w/S6FsJ7JebBM3LxfAJSpZbbq+FGKI8Qj/1bjO5O5OTcgfUECRJBynebg1pm+IIUxHuP3z0Fmj5pv8ThPNjl1PNjiiK9EDVjA1EBje46YCblMjlVaOctmsV52+yBl1d7tms5nAVlVVIvbI91UTpBqt9pFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rbbDuDPi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979EFC4CEE4;
	Mon,  5 May 2025 07:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746431651;
	bh=NCF+uIgi02R3qHnuPawdoFmoqZ/yt942FoVFPnxHS+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rbbDuDPitEZgYgeXAKpMY3VfKgtNIpp0MV/iLq8FlpPbQwLZ9rikqXGUdxynFQeUw
	 2Jj4DLI48+6l8lZP5txTZZEZg8uDHN88iWWkq6SplxIBIjUGdPjwpR5oaTmeg+8cUQ
	 iU1Iwy4ibi/5LR02olttMzmgTimZYd51Bhkpo1bA=
Date: Mon, 5 May 2025 09:54:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jared Holzman <jholzman@nvidia.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.14 092/311] ublk: call ublk_dispatch_req() for handling
 UBLK_U_IO_NEED_GET_DATA
Message-ID: <2025050537-flaring-wolverine-c3fd@gregkh>
References: <20250429161121.011111832@linuxfoundation.org>
 <20250429161124.815951989@linuxfoundation.org>
 <830759ad-243a-4fd5-9fa1-a106e6e6bb0d@nvidia.com>
 <2025050455-reconvene-denial-e291@gregkh>
 <744b4d9b-24f3-487c-805f-5aa02eaa093b@nvidia.com>
 <2025050509-impending-uranium-ccba@gregkh>
 <c5022682-52e7-4340-995c-7d3d84bb77aa@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5022682-52e7-4340-995c-7d3d84bb77aa@nvidia.com>

On Mon, May 05, 2025 at 10:47:03AM +0300, Jared Holzman wrote:
> On 05/05/2025 8:51, Greg Kroah-Hartman wrote:
> > On Sun, May 04, 2025 at 04:47:20PM +0300, Jared Holzman wrote:
> >> On 04/05/2025 15:39, Greg Kroah-Hartman wrote:
> >>> On Sun, May 04, 2025 at 02:55:00PM +0300, Jared Holzman wrote:
> >>>> On 29/04/2025 19:38, Greg Kroah-Hartman wrote:
> >>>>> 6.14-stable review patch.  If anyone has any objections, please let me know.
> >>>>>
> >>>>> ------------------
> >>>>>
> >>>>> From: Ming Lei <ming.lei@redhat.com>
> >>>>>
> >>>>> [ Upstream commit d6aa0c178bf81f30ae4a780b2bca653daa2eb633 ]
> >>>>>
> >>>>> We call io_uring_cmd_complete_in_task() to schedule task_work for handling
> >>>>> UBLK_U_IO_NEED_GET_DATA.
> >>>>>
> >>>>> This way is really not necessary because the current context is exactly
> >>>>> the ublk queue context, so call ublk_dispatch_req() directly for handling
> >>>>> UBLK_U_IO_NEED_GET_DATA.
> >>>>>
> >>>>> Fixes: 216c8f5ef0f2 ("ublk: replace monitor with cancelable uring_cmd")
> >>>>> Tested-by: Jared Holzman <jholzman@nvidia.com>
> >>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >>>>> Link: https://lore.kernel.org/r/20250425013742.1079549-2-ming.lei@redhat.com
> >>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >>>>> Signed-off-by: Sasha Levin <sashal@kernel.org>
> >>>>> ---
> >>>>>  drivers/block/ublk_drv.c | 14 +++-----------
> >>>>>  1 file changed, 3 insertions(+), 11 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> >>>>> index 437297022dcfa..c7761a5cfeec0 100644
> >>>>> --- a/drivers/block/ublk_drv.c
> >>>>> +++ b/drivers/block/ublk_drv.c
> >>>>> @@ -1812,15 +1812,6 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
> >>>>>  	mutex_unlock(&ub->mutex);
> >>>>>  }
> >>>>>  
> >>>>> -static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
> >>>>> -		int tag)
> >>>>> -{
> >>>>> -	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
> >>>>> -	struct request *req = blk_mq_tag_to_rq(ub->tag_set.tags[q_id], tag);
> >>>>> -
> >>>>> -	ublk_queue_cmd(ubq, req);
> >>>>> -}
> >>>>> -
> >>>>>  static inline int ublk_check_cmd_op(u32 cmd_op)
> >>>>>  {
> >>>>>  	u32 ioc_type = _IOC_TYPE(cmd_op);
> >>>>> @@ -1967,8 +1958,9 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
> >>>>>  		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
> >>>>>  			goto out;
> >>>>>  		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
> >>>>> -		ublk_handle_need_get_data(ub, ub_cmd->q_id, ub_cmd->tag);
> >>>>> -		break;
> >>>>> +		req = blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], tag);
> >>>>> +		ublk_dispatch_req(ubq, req, issue_flags);
> >>>>> +		return -EIOCBQUEUED;
> >>>>>  	default:
> >>>>>  		goto out;
> >>>>>  	}
> >>>>
> >>>> Hi Greg,
> >>>>
> >>>> Will you also be backporting "ublk: fix race between io_uring_cmd_complete_in_task and ublk_cancel_cmd" to 6.14-stable?
> >>>
> >>> What is the git commit id you are referring to?  And was it asked to be
> >>> included in a stable release?
> >>>
> >>> thanks,
> >>>
> >>> greg k-h
> >>
> >> Hi Greg,
> >>
> >> The commit is: f40139fde527
> >>
> >> It is Part 2 of the same patch series.
> > 
> > It does not apply to the stable tree at all, so no, we will not be
> > adding it unless someone provides a working version of it.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Hi Greg,
> 
> Happy to provide a version that will apply. I just need to know where to get your working branch to base it on.

The latest stable release tree.

thanks,

greg k-h

