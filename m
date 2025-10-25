Return-Path: <stable+bounces-189745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 995A0C09F34
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 21:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73DB31A683A8
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 19:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834FE305963;
	Sat, 25 Oct 2025 19:25:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0EB2F7AB0;
	Sat, 25 Oct 2025 19:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761420358; cv=none; b=lYjTVX29Yt91PUvApWGgrAbdC745TloXGCx3XyJYUjPJ/aCzNDA3XT8w+j0MrsfCWCyBz+a9LM6zkkDKEIO6776pf1+WN/4tnXi8SmfjFPMqbzxStUiVku5SNg3FaWniOfkTqUKApfSDd6F+3S1x5ae6x4Hfmqa3spo505VYZeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761420358; c=relaxed/simple;
	bh=XMqi7Bh1BNLZKfN+KZrTPFp8zjrMA4E+wj7kNBhSdh8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C0qiTV40rHTQl7u4sSxzx9s0OMzQbO8MwQi2f85irQP+1XdYYMM3hsvJtVsTt5WPQe1aEZEqTVW8ledrVtOg/rkEZJRUoXf/aS29P8+LfofWxVi6yuZmcDEFKk0NhAQsGw3OOLmCAS7asSqn2hgbsnk4/9CO+bRgtwWEYSMmhhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id ACD0B129347;
	Sat, 25 Oct 2025 19:25:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 7F4FC2000D;
	Sat, 25 Oct 2025 19:25:46 +0000 (UTC)
Date: Sat, 25 Oct 2025 15:25:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org, Vladimir Riabchun
 <ferr.lambarginio@gmail.com>, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.17-6.1] ftrace: Fix softlockup in
 ftrace_module_enable
Message-ID: <20251025152545.534cb450@batman.local.home>
In-Reply-To: <20251025160905.3857885-385-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
	<20251025160905.3857885-385-sashal@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 7F4FC2000D
X-Stat-Signature: 6yzqks5de9frsbsiwds9bwsbas7hfgd9
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Xb9xl1QfjMzJ0FPDKue1X1sp4w9TAnjA=
X-HE-Tag: 1761420346-248664
X-HE-Meta: U2FsdGVkX18ELnPSb5L3NDlysnvw/R0s3/WOQlBy9kZTIosIrZ+9IV6rFjTPeDLJMTGvk5Y5PtiMLyuk1RFcckxgwX9jPYHWZ2Ybi13GKOwUpkQRYGORVb/WWVh4W0I7veCeBx188jIZqTU8qmUhWKRk0qPWi/TcHx6YtRfIcyOmMcYAAx5ELsUjxdM/QOnet7d+jdDa6Mh7+Fe09PXtSU4+yUa+peHpMQ8mlY0heTarLu4bX5IA71KcRe6z9yCRpEC4v8WYX4/rJJ0+w0/Kr5qTC8BFK4hpAoctCKWVtg4nwVRJ8eXWoocFK+elYX1wdpzFg0jWhQDwIbaPPLa+BLDsGdZHWFW8

On Sat, 25 Oct 2025 12:00:16 -0400
Sasha Levin <sashal@kernel.org> wrote:

> - The change inserts `cond_resched()` inside the inner iteration over
>   every ftrace record (`kernel/trace/ftrace.c:7538`). That loop holds
>   the ftrace mutex and, for each record, invokes heavy helpers like
>   `test_for_valid_rec()` which in turn calls `kallsyms_lookup()`
>   (`kernel/trace/ftrace.c:4289`). On huge modules (e.g. amdgpu) this can
>   run for tens of milliseconds with preemption disabled, triggering the

It got the "preemption disabled" wrong. Well maybe when running
PREEMPT_NONE it is, but the description doesn't imply that.

-- Steve


>   documented soft lockup/panic during module load.
> - `ftrace_module_enable()` runs only in process context via
>   `prepare_coming_module()` (`kernel/module/main.c:3279`), so adding a
>   voluntary reschedule point is safe; the same pattern already exists in
>   other long-running ftrace loops (see commits d0b24b4e91fc and
>   42ea22e754ba), so this brings consistency without changing control
>   flow or semantics.
> - No data structures or interfaces change, and the code still executes
>   under the same locking (`ftrace_lock`, `text_mutex` when the arch
>   overrides `ftrace_arch_code_modify_prepare()`), so the risk of
>   regression is minimal: the new call simply yields CPU if needed while
>   keeping the locks held, preventing watchdog-induced crashes but
>   otherwise behaving identically.


