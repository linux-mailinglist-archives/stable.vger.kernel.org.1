Return-Path: <stable+bounces-185475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE4EBD56C5
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 19:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E313423D15
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386542C08BA;
	Mon, 13 Oct 2025 17:05:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739B329D266;
	Mon, 13 Oct 2025 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375140; cv=none; b=GMxnBKrc1kodAFkhi8WwHTKj+Jodi9y/yM6LV5Ydcm+BXQCxlKftJyqnRgAZZ5WJ5UXyv8NSp0Hlo2Lnj++vznJVl3BDOVivc9gE1ZrAOG4kHEKTMxk6uUnl7fQ9gILWJlBuD2aCfV4v7cIXTNasUTrypqEf0NP1pTNS63bwoNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375140; c=relaxed/simple;
	bh=1IDkhMBB0vdewzcwQhgukQjRKQ6yxjxHSi4kRM2rs4A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lXiMUqPwPolH2Wqm2bhDxVE0by+hAXKhrKRGIN6cMC5xvHiYyAuiaVxDWPeUn+ZYVkB6sC3myjMxBcRBGCFYC7QLJN4DAkSHC0B/QoeAp2U0S7cMQk24oT+UVY4QhwtBn39IVk7i9QwHZdNZKrhlZNHMqh27td1x8NjvFn3e8tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 5227B59788;
	Mon, 13 Oct 2025 17:05:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 284C420028;
	Mon, 13 Oct 2025 17:05:33 +0000 (UTC)
Date: Mon, 13 Oct 2025 13:05:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, stable@vger.kernel.org,
 syzbot+9a2ede1643175f350105@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/2] tracing: Stop fortify-string from warning in
 tracing_mark_raw_write()
Message-ID: <20251013130536.591e4253@gandalf.local.home>
In-Reply-To: <20251012123408.b50aad1b5abb8a63565067f5@kernel.org>
References: <20251011035141.552201166@kernel.org>
	<20251011035243.552866788@kernel.org>
	<20251012123408.b50aad1b5abb8a63565067f5@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 284C420028
X-Stat-Signature: o7ngzxatj15iejz4zw6obg54dcysj84w
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/3z8/eBLofNPlynlSXsnhIzdDJeBwXPOc=
X-HE-Tag: 1760375133-937170
X-HE-Meta: U2FsdGVkX1/qcwKQN6aCNqHhJ9709h2ZZ9j88fWjg3PCteuy8tmhOE8AeVjPunwKmUA4T7tmxMrUBtJwoJAU1sEGYu2GLvFPWRiCpzpu/Gz6KN/lVI5JJ6c2ycrotUYSt6PKqDYO++2BEuEtpK22SGE5eZye9NvOwsC7dZs3get83XSv7m/XE9wFEPn5IQHHUMdq3zOb0FJMvqSklAsLX/UmrJB2+tE2xNp3EVRQQyNqOKR4aVrBuTF0f4UITcffzhoz8kRnh++8fVSdAfPrYDxThWPpF3ItpsLNvIwA9LFlwlmgV4sMgZb3r9Skk0WL9BeqmF9xlNiRbdAQJrdmpYiNufWfQACamzyI2bs9uESX0jD6Hnd2g4tSS9/Q2hwerM9MhcR3H8AKIZ6UXCKztiDpkqD57bSqwm8FyerMggG8O4PfMwVGC3et23VjSR9zxDZfRYUwUJJqVuD8pWf5qXce4YaXPpg+h004Q0TZ+DI=

On Sun, 12 Oct 2025 12:34:08 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > Use a void pointer and get the offset via offsetof() to keep fortify
> > string from warning about this copy.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 64cf7d058a00 ("tracing: Have trace_marker use per-cpu data to read user space")
> > Reported-by: syzbot+9a2ede1643175f350105@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/68e973f5.050a0220.1186a4.0010.GAE@google.com/
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>  
> 
> Ah, fixed already.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Actually this was the wrong fix. Before submitting a pull request, I looked
to see if there was a better way to handle this and discovered "unsafe_memcpy()"
which is the proper solution:

  https://lore.kernel.org/all/20251011112032.77be18e4@gandalf.local.home/

-- Steve

