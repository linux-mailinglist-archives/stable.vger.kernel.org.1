Return-Path: <stable+bounces-47517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D4A8D1047
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 00:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9D0F1F2210F
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 22:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E0A167D97;
	Mon, 27 May 2024 22:31:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BB815FD10;
	Mon, 27 May 2024 22:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716849103; cv=none; b=Cg3cCsy62s6G7g1zwvqmpzEFqFHQS0fwPpPhzrSHDRpxG+7X6WfEPo7dsyhD3N8KPN5NIvKCwI90F7OEgZ6mRqQjamAPfj3t2TPrAxHoWBJjz5w11P4FZwFkroRg/bjP7Vf0USZHkSgyArlg3294MYsnXQYNapCEB5JLoe0UCF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716849103; c=relaxed/simple;
	bh=wkWViZB7Ah651duBPihx5UnuKf/7BzqehDIFlTgrTnI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c2lX6KbTJHrD6n8fG18e+4wy5tYXYEFOls1ZLyj1d1gRQ0WlOjjsSW8OVNoADfiaRQu5kmvWSO03BHGozep9OqjAP7qgW1ZrYpAHj+UkLSEe1qQVDNHUJsDTIQNKmJUGTTpV1aluHn4KfWdujdq4n0jRjaKm6aHZ/S00bM0n43E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42C4C2BBFC;
	Mon, 27 May 2024 22:31:41 +0000 (UTC)
Date: Mon, 27 May 2024 18:31:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, Ilkka
 =?UTF-8?B?TmF1bGFww6TDpA==?= <digirigawa@gmail.com>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: Bug in Kernel 6.8.x, 6.9.x Causing Trace/Panic During
 Shutdown/Reboot
Message-ID: <20240527183139.42b6123c@rorschach.local.home>
In-Reply-To: <5b79732b-087c-411f-a477-9b837566673e@leemhuis.info>
References: <CAE4VaREzY+a2PvQJYJbfh8DwB4OP7kucZG-e28H22xyWob1w_A@mail.gmail.com>
	<5b79732b-087c-411f-a477-9b837566673e@leemhuis.info>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

You state "Before kernel version 6.8.10, the bug caused ...". Does that
mean that a bug was happening before v6.8.10? But did not cause a panic?

I just noticed your second screen shot from your report, and it has:

 "cache_from_obj: Wrong slab cache, tracefs_inode_cache but object is from inode_cache"

So somehow an tracefs_inode was allocated from the inode_cache and is
now being freed by the tracefs_inode logic? Did this happen before
6.8.10? If so, this code could just be triggering an issue from an
unrelated bug.

Thanks,

-- Steve

