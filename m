Return-Path: <stable+bounces-116607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C496A38A1A
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 17:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0BD3B0949
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 16:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCC4226160;
	Mon, 17 Feb 2025 16:53:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C2B226163;
	Mon, 17 Feb 2025 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739811232; cv=none; b=dbKY+LpkiENiGXSPEJKbvsuHX2h2EKfT3Tp4sA6pKTd4LPB+PqIXqVxeSCkE15rto4es6ZyXNbTEXdm4kX7F1xPdLCvxHRAi86UtARH1jmvVqeNEbbvs7x4fOB0BWieavO2mkhhB4S7Asst2f0v8Y5jajKfKfmCokYWj70j8JUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739811232; c=relaxed/simple;
	bh=1ToLr4OoA/zbx+qsnP+YnCjDKLy+mk728Wleqkl7e64=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ln3XleODZDyq9JcRaBsYV6tGGAW1+dNXeVgJHi/mx9Ut3zxWpn27eReZXdlvid/31q5tsopB0K3PanzulfALO3h4D6kcBq//DhA9fcv5DGbSZbx4LHcCthXEjsDJGrSuqLmpTV+AB/KhEf6N/OVr8v9Z7FeJ2iRrx3RZY7nYfEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D899C4CED1;
	Mon, 17 Feb 2025 16:53:50 +0000 (UTC)
Date: Mon, 17 Feb 2025 11:54:09 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Harshit Agarwal <harshit@nutanix.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Jon Kohler <jon@nutanix.com>, Gauri Patwardhan
 <gauri.patwardhan@nutanix.com>, Rahul Chunduru
 <rahul.chunduru@nutanix.com>, Will Ton <william.ton@nutanix.com>
Subject: Re: [PATCH v2] sched/rt: Fix race in push_rt_task
Message-ID: <20250217115409.05599bd2@gandalf.local.home>
In-Reply-To: <20250214170844.201692-1-harshit@nutanix.com>
References: <20250214170844.201692-1-harshit@nutanix.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Feb 2025 17:08:44 +0000
Harshit Agarwal <harshit@nutanix.com> wrote:

> Co-developed-by: Jon Kohler <jon@nutanix.com>
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> Co-developed-by: Gauri Patwardhan <gauri.patwardhan@nutanix.com>
> Signed-off-by: Gauri Patwardhan <gauri.patwardhan@nutanix.com>
> Co-developed-by: Rahul Chunduru <rahul.chunduru@nutanix.com>
> Signed-off-by: Rahul Chunduru <rahul.chunduru@nutanix.com>
> Signed-off-by: Harshit Agarwal <harshit@nutanix.com>
> Tested-by: Will Ton <william.ton@nutanix.com>
> ---
> Changes in v2:
> - As per Steve's suggestion, removed some checks that are done after
>   obtaining the lock that are no longer needed with the addition of new
>   check.
> - Moved up is_migration_disabled check.
> - Link to v1:
>   https://lore.kernel.org/lkml/20250211054646.23987-1-harshit@nutanix.com/
> ---
>  kernel/sched/rt.c | 54 +++++++++++++++++++++++------------------------
>  1 file changed, 26 insertions(+), 28 deletions(-)


Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Peter or Ingo,

Care to take his patch

Thanks,

-- Steve

