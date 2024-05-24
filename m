Return-Path: <stable+bounces-46090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BDC8CE92C
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 19:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED4D71F216C8
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 17:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC15312F376;
	Fri, 24 May 2024 17:19:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874C912C460;
	Fri, 24 May 2024 17:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716571162; cv=none; b=VzKe6//uP2MCTM4MEYpQK/d34iKSHbliN/R9Ynr4UC11w9SIBC6KEEZODHHv68a5SRHbGjvP1W2OYpuJpMf1m14ul+VQF8EMetQ9261wi0aUL2GhL6HNV3LcN3l6K8JITxPs3rlE7+PPoD+YnU7nhfT6QEmG2eSfQ9MPCiqIkGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716571162; c=relaxed/simple;
	bh=IZ2zzLaazPjUEgY1Kiy4qXvXPdNG/1tZB3yjNXOZ1dE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eLkRALSdU0ozrXQK4KbOaHSvaPb/pXQQb/O6UAn3/BzzFWHaaJXASzOvnmqHwnxhvCWwbqv6IjCIpB+sOoV48+aY7/aM9blcmcmibsuBS9Z0P2oXWVDC0Ua0bESvlzQ9OBdjuRvEpiDnPdNVrkO5k4LoZuqPV9B2PQhgZOLzIIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565ABC32782;
	Fri, 24 May 2024 17:19:21 +0000 (UTC)
Date: Fri, 24 May 2024 13:20:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, Ilkka
 =?UTF-8?B?TmF1bGFww6TDpA==?= <digirigawa@gmail.com>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: Bug in Kernel 6.8.x, 6.9.x Causing Trace/Panic During
 Shutdown/Reboot
Message-ID: <20240524132008.6b6f69f6@gandalf.local.home>
In-Reply-To: <5b79732b-087c-411f-a477-9b837566673e@leemhuis.info>
References: <CAE4VaREzY+a2PvQJYJbfh8DwB4OP7kucZG-e28H22xyWob1w_A@mail.gmail.com>
	<5b79732b-087c-411f-a477-9b837566673e@leemhuis.info>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 May 2024 12:50:08 +0200
"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info> wrote:

> > - Affected Versions: Before kernel version 6.8.10, the bug caused a
> > quick display of a kernel trace dump before the shutdown/reboot
> > completed. Starting from version 6.8.10 and continuing into version
> > 6.9.0 and 6.9.1, this issue has escalated to a kernel panic,
> > preventing the shutdown or reboot from completing and leaving the
> > machine stuck.

Ah, I bet it was this commit: baa23a8d4360d ("tracefs: Reset permissions on
remount if permissions are options"), which added a "iput" callback to the
dentry without calling iput, leaving stale inodes around.

This is fixed with:

  0bcfd9aa4dafa ("tracefs: Clear EVENT_INODE flag in tracefs_drop_inode()")

Try adding just that patch. It will at least make it go back to what was
happening before 6.8.10 (I hope!).

-- Steve

