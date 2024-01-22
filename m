Return-Path: <stable+bounces-12769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55E88372E0
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10233B2A98D
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 19:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6548F3F8D4;
	Mon, 22 Jan 2024 19:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wqyYbrtQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234C93E49E
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 19:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705952215; cv=none; b=ANGiFMq8gFyC604Hzl/qLe780hyL46Yw1dIZPhS/qj9/xbMRVGlHVMBUmy0GwLVY8XmKbDj7oPgUVXvAvXnrYi8CYOww07GS/eIZCOGXUoSgFh84lJREgcKslvIxtKD0+T6mHFGDDOjcA/mkI03AGO8Q/0GeSqQ8gkcUKIHCorg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705952215; c=relaxed/simple;
	bh=4Bxaet9Xsqz0cMK7c9bsrgD+aWduBxjuEicF/JFr5YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQHKX5ynoUBpUrSb7e4gMmJmvAJS/tCeOcsVpuV2MOQxF/S/L3tvHktMksAQAkxGOkEYMqOSxPtCVCLvOjRuSoV4IwZ9RiRTQC56PUXROlHaafhERDTEpRFyRLyCR+peLDh4dqAK5eNgRrSofzu/wBImPheGdOZMN/1ywOb1kVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wqyYbrtQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E2AC43390;
	Mon, 22 Jan 2024 19:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705952214;
	bh=4Bxaet9Xsqz0cMK7c9bsrgD+aWduBxjuEicF/JFr5YY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wqyYbrtQ6pRYO0GmJIxk9woEoSicio6zxOpq6PHkgUuZFUJ0/sjGnUJ8AsdLra+1/
	 DqpNu/iawDCeSqc9JP/vKvPPmO9Rz0innpnQxHPAYp1Iu4FiFdCkstVamACCQ8V7uv
	 X6YcUgpFoSWSMnqUA5c/bK2B+ppdOkjJfKaizx90=
Date: Mon, 22 Jan 2024 11:36:52 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: xrivendell7@gmail.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/rw: ensure io->bytes_done is
 always initialized" failed to apply to 5.15-stable tree
Message-ID: <2024012243-suitor-shorts-255d@gregkh>
References: <2024012216-depth-bartender-bc38@gregkh>
 <9326c0e9-fa64-4082-a577-c9c5b6f01917@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9326c0e9-fa64-4082-a577-c9c5b6f01917@kernel.dk>

On Mon, Jan 22, 2024 at 12:32:06PM -0700, Jens Axboe wrote:
> On 1/22/24 12:27 PM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.15-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> This one applies to 5.10 and 5.15 stable, it should go into both.
> It's the same patch, just in the older bigger unified file.

Now queued up, thanks.

greg k-h

