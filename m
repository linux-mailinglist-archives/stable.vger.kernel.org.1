Return-Path: <stable+bounces-135290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13812A98C94
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 16:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B23E443177
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B83149E17;
	Wed, 23 Apr 2025 14:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DIq02xRl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341212798E7
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 14:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745417757; cv=none; b=IFc2dPn35tsHA6HOiYDBmRYviJSk6BxwxQYcdD+dYeAlKDTCknqip3P0v9B4Utqz2ebufrP0x3rpm667qDBeRha8PskluLMCzQfU+QWmavRmlglj+kX5cSowl1PWoJiw6Zz+SusAtbNkW7cWRWlCunuKMeWgrmMFOxWgDF3bdEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745417757; c=relaxed/simple;
	bh=iqt13ezLn+6/7Ino/EtjZ60jhtnT4Vaa0AqCKBSYw9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+DQOvP+9MFiBzJ4M6Ut0U2PShUVTxcJ2+l0njSlZd4s9Vl2mu7aS1wxgAcaoRMRYDcDiOd+yKLS7LyFEX2jLLX5iw4pYsPP1LJhJ52X9SlAcu5puSZXIBMqMijmN8J/DuwyGt9/a7qWAQBkP4RKkyw8Wbrpb/pANeCb4ztZ7o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DIq02xRl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5432BC4CEE2;
	Wed, 23 Apr 2025 14:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745417756;
	bh=iqt13ezLn+6/7Ino/EtjZ60jhtnT4Vaa0AqCKBSYw9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DIq02xRlmxOKg3MQCyfBQRQMipyYPEgzfg6FpE8hHFDcYqRaM24mvl0lbx0PEjslF
	 S/Rh7zT9hEU/CPYqsRkbJ829+vi1b/gUP7sz3Q3AXykZxB6+buQBILbt7a8Hx0TVKb
	 hFBZnQgD8uz8aw2JXpsGFUkHcB+a6UUDXiU3rdqA=
Date: Wed, 23 Apr 2025 16:15:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Cc: peterz@infradead.org, elver@google.com, stable@vger.kernel.org,
	zhe.he@windriver.com
Subject: Re: [PATCH 5.10.y] perf: Fix perf_pending_task() UaF
Message-ID: <2025042351-glade-swimmable-97e2@gregkh>
References: <20250408061044.3786102-1-xiangyu.chen@eng.windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408061044.3786102-1-xiangyu.chen@eng.windriver.com>

On Tue, Apr 08, 2025 at 02:10:44PM +0800, Xiangyu Chen wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> [ Upstream commit 517e6a301f34613bff24a8e35b5455884f2d83d8 ]
> 
> Per syzbot it is possible for perf_pending_task() to run after the
> event is free()'d. There are two related but distinct cases:
> 
>  - the task_work was already queued before destroying the event;
>  - destroying the event itself queues the task_work.
> 
> The first cannot be solved using task_work_cancel() since
> perf_release() itself might be called from a task_work (____fput),
> which means the current->task_works list is already empty and
> task_work_cancel() won't be able to find the perf_pending_task()
> entry.
> 
> The simplest alternative is extending the perf_event lifetime to cover
> the task_work.
> 
> The second is just silly, queueing a task_work while you know the
> event is going away makes no sense and is easily avoided by
> re-arranging how the event is marked STATE_DEAD and ensuring it goes
> through STATE_OFF on the way down.
> 
> Reported-by: syzbot+9228d6098455bb209ec8@syzkaller.appspotmail.com
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Marco Elver <elver@google.com>
> [ Discard the changes in event_sched_out() due to 5.10 don't have the
> commit: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
> and commit: ca6c21327c6a ("perf: Fix missing SIGTRAPs") ]
> Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
> Verified the build test.

You missed all of the fix-up patches for this commit that happened after
it, fixing memory leaks and the like.  So if we applied this, we would
have more bugs added to the tree than fixed :(

ALWAYS check for follow-on fixes.

I'll go drop this.

greg k-h

