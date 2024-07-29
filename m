Return-Path: <stable+bounces-62594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E74DC93FC91
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 19:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 252501C215BB
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 17:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE48824AD;
	Mon, 29 Jul 2024 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j1Xw1oqT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EAA17107D
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722275075; cv=none; b=JgJsdj3wQSEpHKkHru00MfeEHRya0XQ7OJnXE0nNWRE68CuhBLMjGLxwaygZMOAplZJOxTzmdOjBADMx5xU2x7Ydh7zOLSdapF1QLbl9baf0L9jHt3XySvy/ubnWI/yFxjlBqhjgLCX3KVTW0TqHl9Ijjiz4cqMF9QHVRwzD0jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722275075; c=relaxed/simple;
	bh=Vs9FvNx4XQyfiRD6eUiNuoFxYMhG9MedE1nHvkZiB1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xs8AAWAUP/tKc+KWnYBv5GA8JsaxiBRB1JkDdPAVKI0tDXu4DyFec/nIxvgAUlY4Gmr1Ngz4U2YCuCd174g+ySb7uYY045VufOgX5yOrqh5a9jRU35tOhwff5Dg6EjOE1LLL6NapdmdFJQs0sgCjuWxc8yqrU4clDGY9kY0OTs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j1Xw1oqT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A0BC32786;
	Mon, 29 Jul 2024 17:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722275075;
	bh=Vs9FvNx4XQyfiRD6eUiNuoFxYMhG9MedE1nHvkZiB1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j1Xw1oqTAuKSWCx1re62ZLZLVB9ZcU27DPvoRVBxk/EBzSAhFXuInYk+O1JOtHgKd
	 DmQuL4udRuGFAvqTXI7w9Dybs9Ifo8oKNVsH90cwaHp/pGcRX05rPCpnYLUQa5jFKn
	 PAFSE6TuW/UMEIRMRLNPTxeYo/qOVSEW5LHhN39k=
Date: Mon, 29 Jul 2024 19:44:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: asml.silence@gmail.com, leitao@debian.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring: fix lost getsockopt
 completions" failed to apply to 6.6-stable tree
Message-ID: <2024072926-had-flanking-8fb3@gregkh>
References: <2024072931-sarcastic-coagulant-6821@gregkh>
 <90dbc129-922e-41fd-b813-5d547a34bc1b@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90dbc129-922e-41fd-b813-5d547a34bc1b@kernel.dk>

On Mon, Jul 29, 2024 at 11:38:06AM -0600, Jens Axboe wrote:
> On 7/29/24 4:13 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.6-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 24dce1c538a7ceac43f2f97aae8dfd4bb93ea9b9
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072931-sarcastic-coagulant-6821@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
> 
> Not needed for 6.6-stable as it turns out, this one can get dropped.

Will do, thanks!

