Return-Path: <stable+bounces-9256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE03822B3E
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 11:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B00CB22EEF
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 10:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABCD18B00;
	Wed,  3 Jan 2024 10:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kujzUyew"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665D918C17
	for <stable@vger.kernel.org>; Wed,  3 Jan 2024 10:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55928C433C7;
	Wed,  3 Jan 2024 10:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704277562;
	bh=gsSqaFEpjLn7EmKDYchK1z4vmtORrrg4hYPW2oLgNSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kujzUyewG3Ck8ovYg0qTJD8/aobnUSJwUhJnXsmvEPPSmsq+7U07tPzMFpXmxNT29
	 P71wZw5C/++F8CzzmnxUeocRMHT7yaW3tSU9NF4m7uHuvXP5x+1qo+7xdvncmxuH6P
	 SMCPepCgn3KZTJn1DwVG727PmDH6pyAS0m0ANBtY=
Date: Wed, 3 Jan 2024 11:25:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org, torvalds@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] ring-buffer: Fix slowpath of interrupted
 event" failed to apply to 6.1-stable tree
Message-ID: <2024010350-spinout-upheaval-abf6@gregkh>
References: <2023123047-tuesday-whooping-6ae3@gregkh>
 <20231230165156.4fd2eef6@gandalf.local.home>
 <20231230172019.261b6059@gandalf.local.home>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231230172019.261b6059@gandalf.local.home>

On Sat, Dec 30, 2023 at 05:20:19PM -0500, Steven Rostedt wrote:
> On Sat, 30 Dec 2023 16:51:56 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Below is the patch for 6.1 of this change, and it depends on:
> > 
> > 20231230164736.3b8c86c4@gandalf.local.home
> 
> And this is for 5.15.

Both now queued up, thanks.

greg k-h

