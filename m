Return-Path: <stable+bounces-99084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BED999E7011
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E477282B5A
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 14:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36345146D68;
	Fri,  6 Dec 2024 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TQkNbS0F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB78713D8B5
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733495469; cv=none; b=Ah/xHXtBZ4UqOLDsd3tPpw05tuHNzjaDO6/j1Of9mghXJk/rl7RNQSCPsbST88rlo54PdEhwWFZ8K8bbxT52xraBIQf+xaxUYcbCBEy/MKvvOlKYXk3AtfkkuWEOepFlwKpUkyJJzuvSEskhU5EDFaXceA4lMYzSL1K7B2i1F28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733495469; c=relaxed/simple;
	bh=tVDlBrDTmdVQsJAaGQF6OsrpyCoNVA9K3kqX6eIpFBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeZ4WE0PtYaiW+HsTRarM5zs2yyK+OE3+h0SpcQfYeZHl1U5FTk5w38u/lKrNU8dkjF2ny1BqwFZTw2EkTk2p6scXgJdTXjd2v3cXGIHLU+tqGtNP5kKiKKS+EB/aQHgL2kk+yp9urT1wccVZQmKBZNRonDwdOqk/nQG9t/P+rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TQkNbS0F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9963AC4CED1;
	Fri,  6 Dec 2024 14:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733495469;
	bh=tVDlBrDTmdVQsJAaGQF6OsrpyCoNVA9K3kqX6eIpFBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TQkNbS0FvN6aIUaB1wJz4iDqwRXt2LtgaBJGjM9kI6sNV6o/ZDC2E79iikL1jLIGV
	 qiGnrbdfWGfVNEYpIltulGZ2Ov494joQdiqcX71qtbj8FCqA3KVSmZdKhe4KcblFtI
	 OgQd6Tqknldf6dOJ0R0xhKKcOrWba2lBP2addaew=
Date: Fri, 6 Dec 2024 15:31:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: frederic@kernel.org, anthony.mallet@laas.fr, tglx@linutronix.de,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] posix-timers: Target group sigqueue to
 current task only if" failed to apply to 6.12-stable tree
Message-ID: <2024120659-majorette-brook-b814@gregkh>
References: <2024120656-jelly-gore-aa4c@gregkh>
 <20241206130824.GA31748@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206130824.GA31748@redhat.com>

On Fri, Dec 06, 2024 at 02:08:25PM +0100, Oleg Nesterov wrote:
> Hi Greg,
> 
> On 12/06, gregkh@linuxfoundation.org wrote:
> >
> > The patch below does not apply to the 6.12-stable tree.
> 
> Please see the attached patch. For v6.12 and the previous versions.

Thanks, now queued up.

greg k-h

