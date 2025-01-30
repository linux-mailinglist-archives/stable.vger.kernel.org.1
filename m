Return-Path: <stable+bounces-111700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 289C2A2308A
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 15:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9774F1885178
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1979A1E98E8;
	Thu, 30 Jan 2025 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Axjf/r29"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA891BB6BC
	for <stable@vger.kernel.org>; Thu, 30 Jan 2025 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738248110; cv=none; b=r37kYjr50HpdanxMCLhgv3IsIcfO7CSIWDT2eD5DgAJj4RHnTGmufm11MsdBSpmOU72RjD4AxtTpvoeyThu7HkeGmw5r8BELtvs+mZib0MukWn9juj1TXAQd3roQ0zIhe0c6t2PvaSjeKW672KyDqgxVG5WnblpGH1q8rILREQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738248110; c=relaxed/simple;
	bh=OydinaXWZD7rjFgsp7fCjrR/U5SLsjhDWHRTsmYvfR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuG50p6FEm9of8t+hdZ78x2k6CNGi6oeuL5vStf8KSbyvFfzeJQt4XlYNqWe8U2l6+9dn9Nq5/pZiNbGBkYQNRb5++8oqxVrHaa0Ff/uU4kY7eeLIj+8om/SFrWcebV028sGXCsd1EJaCIn+d2/cQEJTF3Xg6ZZEFgFY7OSyn9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Axjf/r29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B6DC4CED2;
	Thu, 30 Jan 2025 14:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738248110;
	bh=OydinaXWZD7rjFgsp7fCjrR/U5SLsjhDWHRTsmYvfR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Axjf/r29Uq7jNJSlIoxSe6allZtxpiXK7fSrb4tNaFEYZ0rT2kkYKNdGUW7ne9RN8
	 aMYjDyz0EHbIk50+/ru3dyHRz9D2gB1o4aCDO6P8ZFoPA1q17ar/tawxuHyKZOF6/n
	 oYVnbLeqpqqE9lRc6ViiZuYnFszK9EvNnVPdMvl8=
Date: Thu, 30 Jan 2025 15:41:47 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: jannh@google.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/rsrc: require cloned buffers to
 share accounting" failed to apply to 6.12-stable tree
Message-ID: <2025013040-earthen-unbraided-02a2@gregkh>
References: <2025013011-scenic-crazed-e3c8@gregkh>
 <84e2f49c-47d4-402c-977d-654b4cdd3cbd@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84e2f49c-47d4-402c-977d-654b4cdd3cbd@kernel.dk>

On Thu, Jan 30, 2025 at 07:20:46AM -0700, Jens Axboe wrote:
> On 1/30/25 4:38 AM, gregkh@linuxfoundation.org wrote:
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
> > git cherry-pick -x 19d340a2988d4f3e673cded9dde405d727d7e248
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025013011-scenic-crazed-e3c8@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
> 
> Here's a 6.12-stable version of this patch.

Now queued up, thanks!

greg k-h

