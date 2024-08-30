Return-Path: <stable+bounces-71631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19635966014
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 13:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 859081F279D6
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 11:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636851A2876;
	Fri, 30 Aug 2024 11:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GJj8pqBi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207CD19ABB3
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 11:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725016071; cv=none; b=jbHjfdOCAzSxmuAHEl9FK8HcgxkdYzQXHZgv7sd2PySgyW0jbhnWWVtl1HBro9u49V/GKgsBJ3yEwYImbwup+lFSRui+70XuwIUWHFkvgS7akcvlnSu7iLZezfCLYlQTlph1fZwTnSxA09Ml4sEwHgX+RVyL+QA72pjBidDWc7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725016071; c=relaxed/simple;
	bh=qhCCIamzLBpl03eCiY9K/4UJJxvJsw7U41tne+JR0wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qg7haAj6FMKRE986cOdo1W/A9sTuy80wcyvurCbKysJpiJbESnsP50v+6xYAZgp6l1so6M/XuZjkI0HD4yHHa6797/i/waXIx8WZQFpYRG4r2yhbAMP5XGAXDWOqMIfiQEUHE1T9+12dSmgnKkCEGNE0uaosxfcIQCpfaOCMcDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GJj8pqBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F06C4CEC4;
	Fri, 30 Aug 2024 11:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725016070;
	bh=qhCCIamzLBpl03eCiY9K/4UJJxvJsw7U41tne+JR0wg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GJj8pqBi1O3+ItikpaIokydnJrHQ+8EkvdUsIiaL8CbTINSqTnBzl3kDtUEdnIARQ
	 QHnsIgC3uxBNUDTTinpM2sjvA71Vf7z8vfbcVn6IXT8GqYDuCNajnH8lSiGRvskksb
	 nFAGNre8ZobEEg8W3sTfk+R6GPxqqFYUb5Wp0NQQ=
Date: Fri, 30 Aug 2024 13:07:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] dm suspend: return -ERESTARTSYS instead
 of -EINTR" failed to apply to 4.19-stable tree
Message-ID: <2024083039-roster-unreached-b17a@gregkh>
References: <2024081927-smoky-refrain-8af1@gregkh>
 <e7ae27a1-14c7-baf7-d44b-7f73b6eb571f@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7ae27a1-14c7-baf7-d44b-7f73b6eb571f@redhat.com>

On Mon, Aug 19, 2024 at 12:28:52PM +0200, Mikulas Patocka wrote:
> 
> 
> On Mon, 19 Aug 2024, gregkh@linuxfoundation.org wrote:
> 
> > 
> > The patch below does not apply to the 4.19-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 1e1fd567d32fcf7544c6e09e0e5bc6c650da6e23
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081927-smoky-refrain-8af1@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..
> > 
> > Possible dependencies:
> > 
> > 1e1fd567d32f ("dm suspend: return -ERESTARTSYS instead of -EINTR")
> > 85067747cf98 ("dm: do not use waitqueue for request-based DM")
> > 087615bf3acd ("dm mpath: pass IO start time to path selector")
> > 5de719e3d01b ("dm mpath: fix missing call of path selector type->end_io")
> > 645efa84f6c7 ("dm: add memory barrier before waitqueue_active")
> > 3c94d83cb352 ("blk-mq: change blk_mq_queue_busy() to blk_mq_queue_inflight()")
> > c4576aed8d85 ("dm: fix request-based dm's use of dm_wait_for_completion")
> > b7934ba4147a ("dm: fix inflight IO check")
> > 6f75723190d8 ("dm: remove the pending IO accounting")
> > dbd3bbd291a0 ("dm rq: leverage blk_mq_queue_busy() to check for outstanding IO")
> > 80a787ba3809 ("dm: dont rewrite dm_disk(md)->part0.in_flight")
> > ae8799125d56 ("blk-mq: provide a helper to check if a queue is busy")
> > 6a23e05c2fe3 ("dm: remove legacy request-based IO path")
> > 
> > thanks,
> > 
> > greg k-h
> > 
> > ------------------ original commit in Linus's tree ------------------
> > 
> > >From 1e1fd567d32fcf7544c6e09e0e5bc6c650da6e23 Mon Sep 17 00:00:00 2001
> > From: Mikulas Patocka <mpatocka@redhat.com>
> > Date: Tue, 13 Aug 2024 12:38:51 +0200
> > Subject: [PATCH] dm suspend: return -ERESTARTSYS instead of -EINTR
> > 
> > This commit changes device mapper, so that it returns -ERESTARTSYS
> > instead of -EINTR when it is interrupted by a signal (so that the ioctl
> > can be restarted).
> > 
> > The manpage signal(7) says that the ioctl function should be restarted if
> > the signal was handled with SA_RESTART.
> > 
> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > Cc: stable@vger.kernel.org
> > 
> > diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > index 97fab2087df8..87bb90303435 100644
> > --- a/drivers/md/dm.c
> > +++ b/drivers/md/dm.c
> > @@ -2737,7 +2737,7 @@ static int dm_wait_for_bios_completion(struct mapped_device *md, unsigned int ta
> >  			break;
> >  
> >  		if (signal_pending_state(task_state, current)) {
> > -			r = -EINTR;
> > +			r = -ERESTARTSYS;
> >  			break;
> >  		}
> >  
> > @@ -2762,7 +2762,7 @@ static int dm_wait_for_completion(struct mapped_device *md, unsigned int task_st
> >  			break;
> >  
> >  		if (signal_pending_state(task_state, current)) {
> > -			r = -EINTR;
> > +			r = -ERESTARTSYS;
> >  			break;
> >  		}
> >  
> > 
> 
> Hi
> 
> Here I'm sending the updated patch for 4.19 and 5.4.

Now queued up, thanks

greg k-h

