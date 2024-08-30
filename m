Return-Path: <stable+bounces-71639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 281F79661E3
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 14:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9DFBB21D00
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 12:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF99619993B;
	Fri, 30 Aug 2024 12:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BF1WFVE2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE701898E5
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 12:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725021694; cv=none; b=lXEokb4yD8nCJz6ZF4qXO2/66+GuMlgpoOM43a3znDzlU+mMzshRDubwqgYi9zUzaWGQ5xFMsJ83Tikjuffdg8haCl3XUnOnDM7UIy4E9TAXYO3vm2+Cp4k/q868032OF2qoBuN9E6onnAPK0lNzUWPIJWliBBTs+cJNam/8pJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725021694; c=relaxed/simple;
	bh=G78hEdMv3xYvu6C5bKFrR+ND+mlfs1Ve65ddyx+oy2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0cBrVvu9bSEW+Y75Cbid3BpFhj4G5iJBACnNmHx2OxNJY+kxZ7+ihFDKAR3cNVoi8GF7JBnQuBSGmDcMNJn7ZKDxtP/4RifG0WsvFE3A2BcTTNIOSbdgYuPkbXsJQBpB53BHzSBTmmKyTyIakgveUKX/vKtZkpv5cf9SQej2mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BF1WFVE2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6465AC4CEC2;
	Fri, 30 Aug 2024 12:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725021694;
	bh=G78hEdMv3xYvu6C5bKFrR+ND+mlfs1Ve65ddyx+oy2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BF1WFVE285smyX9rxIz0D2B5HWVWrt91XiuwTT22eI7KN2bPZxeah/cRO0SM+icSi
	 y1pHkOLb7MeEL5b8fOxkzDGyp1wYyU4sf1zP6nDTP52oou5mdVakNrQkPVHBu1Dwxc
	 zzQtAEvsKXmKEhoxLHI3NtAUwdrjOCOWPYay22PQ=
Date: Fri, 30 Aug 2024 14:41:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zheng Yejian <zhengyejian@huaweicloud.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y] tracing: Have format file honor EVENT_FILE_FL_FREED
Message-ID: <2024083022-joining-probable-6a01@gregkh>
References: <2024081258-amusement-designing-88e9@gregkh>
 <20240828025940.683521-1-zhengyejian@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240828025940.683521-1-zhengyejian@huaweicloud.com>

On Wed, Aug 28, 2024 at 10:59:40AM +0800, Zheng Yejian wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> commit b1560408692cd0ab0370cfbe9deb03ce97ab3f6d upstream.
> 
> When eventfs was introduced, special care had to be done to coordinate the
> freeing of the file meta data with the files that are exposed to user
> space. The file meta data would have a ref count that is set when the file
> is created and would be decremented and freed after the last user that
> opened the file closed it. When the file meta data was to be freed, it
> would set a flag (EVENT_FILE_FL_FREED) to denote that the file is freed,
> and any new references made (like new opens or reads) would fail as it is
> marked freed. This allowed other meta data to be freed after this flag was
> set (under the event_mutex).
> 
> All the files that were dynamically created in the events directory had a
> pointer to the file meta data and would call event_release() when the last
> reference to the user space file was closed. This would be the time that it
> is safe to free the file meta data.
> 
> A shortcut was made for the "format" file. It's i_private would point to
> the "call" entry directly and not point to the file's meta data. This is
> because all format files are the same for the same "call", so it was
> thought there was no reason to differentiate them.  The other files
> maintain state (like the "enable", "trigger", etc). But this meant if the
> file were to disappear, the "format" file would be unaware of it.
> 
> This caused a race that could be trigger via the user_events test (that
> would create dynamic events and free them), and running a loop that would
> read the user_events format files:
> 
> In one console run:
> 
>  # cd tools/testing/selftests/user_events
>  # while true; do ./ftrace_test; done
> 
> And in another console run:
> 
>  # cd /sys/kernel/tracing/
>  # while true; do cat events/user_events/__test_event/format; done 2>/dev/null
> 
> With KASAN memory checking, it would trigger a use-after-free bug report
> (which was a real bug). This was because the format file was not checking
> the file's meta data flag "EVENT_FILE_FL_FREED", so it would access the
> event that the file meta data pointed to after the event was freed.
> 
> After inspection, there are other locations that were found to not check
> the EVENT_FILE_FL_FREED flag when accessing the trace_event_file. Add a
> new helper function: event_file_file() that will make sure that the
> event_mutex is held, and will return NULL if the trace_event_file has the
> EVENT_FILE_FL_FREED flag set. Have the first reference of the struct file
> pointer use event_file_file() and check for NULL. Later uses can still use
> the event_file_data() helper function if the event_mutex is still held and
> was not released since the event_file_file() call.
> 
> Link: https://lore.kernel.org/all/20240719204701.1605950-1-minipli@grsecurity.net/
> 
> Cc: stable@vger.kernel.org
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mathieu Desnoyers   <mathieu.desnoyers@efficios.com>
> Cc: Ajay Kaher <ajay.kaher@broadcom.com>
> Cc: Ilkka Naulap‰‰    <digirigawa@gmail.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Al   Viro <viro@zeniv.linux.org.uk>
> Cc: Dan Carpenter   <dan.carpenter@linaro.org>
> Cc: Beau Belgrave <beaub@linux.microsoft.com>
> Cc: Florian Fainelli  <florian.fainelli@broadcom.com>
> Cc: Alexey Makhalov    <alexey.makhalov@broadcom.com>
> Cc: Vasavi Sirnapalli    <vasavi.sirnapalli@broadcom.com>
> Link: https://lore.kernel.org/20240730110657.3b69d3c1@gandalf.local.home
> Fixes: b63db58e2fa5d ("eventfs/tracing: Add callback for release of an eventfs_inode")
> Reported-by: Mathias Krause <minipli@grsecurity.net>
> Tested-by: Mathias Krause <minipli@grsecurity.net>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> [Resolve conflict due to lack of commit a1f157c7a3bb ("tracing: Expand all
>  ring buffers individually") which add tracing_update_buffers() in
> event_enable_write(), that commit is more of a feature than a bugfix
> and is not related to the problem fixed by this patch]
> Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>

Now queued up, thanks.

greg k-h

