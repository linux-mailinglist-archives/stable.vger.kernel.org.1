Return-Path: <stable+bounces-180803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C997BB8DB61
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 14:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FA9D17DA76
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 12:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C082C2459D1;
	Sun, 21 Sep 2025 12:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hJUORxVe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809D512F5A5
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 12:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758459334; cv=none; b=aeEEp+wCkQWXcU5LU3zaWqE0/sXyfbrwZFtiFxV7WKeG7r5OK/Rf3TqZBGLWfB3UUD/z3LLQWRfcV1P+r3L87slt34hKLXcDTf5grAeuInPeFKlrjJFmv3sjbZnbjCenp4DWuJQ46xVaZiHCte9mQKjWMBaeOO0nMjtJG80WbZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758459334; c=relaxed/simple;
	bh=jTbst1ClscmLA1moW2sVtv+IzbFHKbhDUK29fD3z8gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=No9Yhx7SqODVQOf8ePXOIc9DS60GuWdVp7UVJsoa3/+t4sJI0gLGLOLL8esQbpr3Okxg76MF1aiXi522VKKZkOMDtLs3v9YUzJM0UDgmugve2vYaWWH46OYoWJVEoGscr1ISG6JdNf/qklk0nlopmukhSY+TkMYc1k0mlEc2C6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hJUORxVe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE84C4CEE7;
	Sun, 21 Sep 2025 12:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758459334;
	bh=jTbst1ClscmLA1moW2sVtv+IzbFHKbhDUK29fD3z8gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hJUORxVeyELqzwkRIlYzL8qrFS3qHB0JKM/3V8H8sIGBFl7FEKnhOTZU27nWyIQF2
	 l53snetM371Bi/x25WwRrOjDnQQM3jJHCMB6LsEte6aljYadNaKNofLlUfYfQI6mfd
	 gPFG7SI5cj1X6Kbjc29PLhKKaSN4JrWikLMHLDqc=
Date: Sun, 21 Sep 2025 14:55:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: thaler@thaler.hu, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring: include dying ring in task_work
 "should cancel"" failed to apply to 6.12-stable tree
Message-ID: <2025092125-resupply-subduing-726b@gregkh>
References: <2025092127-synthetic-squash-4d57@gregkh>
 <bc33927c-a7ed-4518-92e6-e97fc5fde5e8@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc33927c-a7ed-4518-92e6-e97fc5fde5e8@kernel.dk>

On Sun, Sep 21, 2025 at 06:44:45AM -0600, Jens Axboe wrote:
> On 9/21/25 6:32 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.12-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 3539b1467e94336d5854ebf976d9627bfb65d6c3
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092127-synthetic-squash-4d57@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
> > 
> > Possible dependencies:
> 
> Here's this and the others marked for 6.12-stable, already prepared them
> last week as I knew I'd be traveling.

Now queued up, thanks.

greg k-h

