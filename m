Return-Path: <stable+bounces-16097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8E883F034
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 22:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 816F81C216D3
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 21:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7131A723;
	Sat, 27 Jan 2024 21:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pX3cv7R/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EE11D521
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 21:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706390688; cv=none; b=TeEus3tkwLS4ZXFfmYD0Tp6legGCTnM2Bv+70yofEa61tSp8QgL2s9WQ0A9M8TWeSouy2gpOny9H33Bg/kxQNNv5PfOINMMaOUHgY+3afgGHOLlT16mh5fpu5HT1eiK7PgIQTcU6tT3unM2ctNz2nNGBhCSjbd9gIB2tIWdwFNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706390688; c=relaxed/simple;
	bh=mVP8QW22/uyKvR8gVhn95Q5bTLXRmFNwJfPQK2Uh0os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOU/s2VIKwYhrsCjwGdehhotRHqYrY/gjxUE7ietbZFNR1DiO+JliWBcUWzupFjv1GkaQSXV5QSrjEfBv3+M8NBOXpKE7EI5ngPhuBFQzo5QVmuuvd9ZBzVid2X9Hub4/JQ2XurzTFR8/7D+Zw56lSjRZneblXYOHxHoOjSs4C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pX3cv7R/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF68C433C7;
	Sat, 27 Jan 2024 21:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706390687;
	bh=mVP8QW22/uyKvR8gVhn95Q5bTLXRmFNwJfPQK2Uh0os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pX3cv7R/yxZQa5uncUblYqT9pvR8hXRz6cQ0kgDHkMqa3RQKMszz0EDA8pmbPmwZp
	 eZqo4JbnaR7bYmky0GBMbaAgCbMQws7qPCO4aRCYPdbkh+k5v5AIx5euSxk0cTfzgW
	 aZxVjdukEWJTm3kpibeoF4/YmCZjP64wpOR1QbOw=
Date: Sat, 27 Jan 2024 13:24:47 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: edumazet@google.com, horms@kernel.org, josef@toxicpanda.com,
	syzkaller@googlegroups.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] nbd: always initialize struct msghdr
 completely" failed to apply to 6.1-stable tree
Message-ID: <2024012737-slurp-geiger-97ac@gregkh>
References: <2024012655-dwelled-unlinked-8b2c@gregkh>
 <4902c3e8-2376-44c1-9649-244041b8f259@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4902c3e8-2376-44c1-9649-244041b8f259@kernel.dk>

On Fri, Jan 26, 2024 at 09:01:26PM -0700, Jens Axboe wrote:
> On 1/26/24 3:14 PM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.1-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 78fbb92af27d0982634116c7a31065f24d092826
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012655-dwelled-unlinked-8b2c@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> 
> Here's the patch for 6.1-stable.

Now queued up, thanks!

greg k-h

