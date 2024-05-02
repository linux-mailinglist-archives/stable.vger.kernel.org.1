Return-Path: <stable+bounces-42987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C178B9D65
	for <lists+stable@lfdr.de>; Thu,  2 May 2024 17:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5A67B21E27
	for <lists+stable@lfdr.de>; Thu,  2 May 2024 15:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AC515CD52;
	Thu,  2 May 2024 15:29:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C8115AACC;
	Thu,  2 May 2024 15:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714663758; cv=none; b=czBQKJRYigD42xOruHnu1A/wEBeWCMbxJF1VPa96JvnyEU0cXH/cRRVufQlnhUuF9uxgPWcKDuiKkvNhieG8ajuw4fJLAKIPUJbJvC7zvPgaq93ujOdYZZ1J+wwFqOcNWuipJqMRBqUtCHffyfgNUUnr6izX+F1n5EglevMeDns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714663758; c=relaxed/simple;
	bh=NbmtV0Lpae5Kt6tHaBmqxRRz2KjCUuAoY8gQ9gznMjE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXbb5gz+iTbPoTeM0dEjrrJLpm24QtXndLhAZwCTNSEOsAoN6jUgmJkZkSuRMqDF8iMyDmeW/lAF9U2kD55iFrdZn6o4/D/zvDt4SiuPGdEulcBDYZq9hdri1nhsYjo4Bd5Pq1q1bQ03CQC91j/T8KpjC7CkNma75xDFHtefCTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242F2C113CC;
	Thu,  2 May 2024 15:29:17 +0000 (UTC)
Date: Thu, 2 May 2024 11:30:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/5] tracefs: Reset permissions on remount if
 permissions are options
Message-ID: <20240502113003.73c0fe38@gandalf.local.home>
In-Reply-To: <20240502151620.400578783@goodmis.org>
References: <20240502151547.973653253@goodmis.org>
	<20240502151620.400578783@goodmis.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 02 May 2024 11:15:48 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> +/*
> + * On a remount of tracefs, if UID or GID options are set, then
> + * the mount point inode permissions should be used.
> + * Reset the saved permission flags appropriately.
> + */
> +void eventfs_remount(struct tracefs_inode *ti, bool update_uid, bool update_gid)
> +{
> +	struct eventfs_inode *ei = ti->private;

And I just realized there's a race here too :-p

I need to set ti->private = NULL before freeing the ei, and probably free
the ei via RCU.

-- Steve


> +
> +	if (!ei)
> +		return;
> +
> +	if (update_uid)
> +		ei->attr.mode &= ~EVENTFS_SAVE_UID;
> +
> +	if (update_gid)
> +		ei->attr.mode &= ~EVENTFS_SAVE_GID;
> +
> +	if (!ei->entry_attrs)
> +		return;
> +
> +	for (int i = 0; i < ei->nr_entries; i++) {
> +		if (update_uid)
> +			ei->entry_attrs[i].mode &= ~EVENTFS_SAVE_UID;
> +		if (update_gid)
> +			ei->entry_attrs[i].mode &= ~EVENTFS_SAVE_GID;
> +	}
> +}
> +

