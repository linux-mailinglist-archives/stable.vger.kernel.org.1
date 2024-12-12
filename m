Return-Path: <stable+bounces-103895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA18D9EF9A8
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 905BC28E8AB
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBCF223304;
	Thu, 12 Dec 2024 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KNe2ZUvw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B685215710
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025937; cv=none; b=CWeesukt3634WPVgTFgTQPLz73QY+KFR74dRG9bAQ64lhJvAtNjJsdw1fDPZFbgOmNh2uRa45mB9q2mwUi4zn/p9K6Hza6fufPmKCCmVv9DZWXxZ9SSMrX0I6RTbbU6UwliecF8u19qdZumZb1a83orRFHAfKjjMA5ADbOtroBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025937; c=relaxed/simple;
	bh=CPjLisD3y6KZv0Ijx0iGsLWzl7zHWtdc5HTBYKM+AMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHxlSDtKZU6ppYtbUhBz9taRQ759/85x0aF/UbZKBdm3auSmPciU2UwMmyXPcr/nfhGTUzASJfr2gBWVD7B84iIZjZD9fETzxsu8xwdLs5r4N8ur255S/7LKa2YGs42bGjJdDqdFQToqSV6NSVlvMETDWHyo3C1yDu1eS6qrwwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KNe2ZUvw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12858C4CECE;
	Thu, 12 Dec 2024 17:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734025937;
	bh=CPjLisD3y6KZv0Ijx0iGsLWzl7zHWtdc5HTBYKM+AMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KNe2ZUvw1z9YVfc4FoOZyLdM8DZ2Q8XNH1e9tH3ZoCjFTJYbABxmHR4ZRpJ9C52Bx
	 9YG0OcB9zYFgmrSXTZtMc2FbLNwk37kwjJyQLoD5tT/MmDsM3NE/2kffD58y3IwIN4
	 fbbgNfdZp/xMgY8rL7eZ+nKi9bv7ezHtgZ38aMJg=
Date: Thu, 12 Dec 2024 18:10:09 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: stable@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Patch "rtla/timerlat: Make timerlat_top_cpu->*_count unsigned
 long long" has been added to the 6.6-stable tree
Message-ID: <2024121247-limb-alkalize-86fb@gregkh>
References: <20241210210407.3588978-1-sashal@kernel.org>
 <CAP4=nvSewMCgCYg1jBbHoUkNOknR5Nc5T+0EZZKRG_2RVUfsDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP4=nvSewMCgCYg1jBbHoUkNOknR5Nc5T+0EZZKRG_2RVUfsDw@mail.gmail.com>

On Thu, Dec 12, 2024 at 04:32:22PM +0100, Tomas Glozar wrote:
> út 10. 12. 2024 v 22:04 odesílatel Sasha Levin <sashal@kernel.org> napsal:
> >
> > This is a note to let you know that I've just added the patch titled
> >
> >     rtla/timerlat: Make timerlat_top_cpu->*_count unsigned long long
> >
> > to the 6.6-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >
> > The filename of the patch is:
> >      rtla-timerlat-make-timerlat_top_cpu-_count-unsigned-.patch
> > and it can be found in the queue-6.6 subdirectory.
> >
> 
> Could you also add "rtla/timerlat: Make timerlat_hist_cpu->*_count
> unsigned long long", too (76b3102148135945b013797fac9b20), just like
> we already have in-queue for 6.12? It makes no sense to do one fix but
> not the other (clearly autosel AI won't take over the world yet).

It does not apply cleanly, can you provide a working, and tested,
backport for us to add?

thanks,

greg k-h

