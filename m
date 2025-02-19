Return-Path: <stable+bounces-118292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 146B7A3C2C9
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 15:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA8EA177E55
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 14:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5551F4620;
	Wed, 19 Feb 2025 14:53:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3CD1F3B85;
	Wed, 19 Feb 2025 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976789; cv=none; b=TmRJoDR0bEcLVa/hqB89+MBMSdSbtokopYhu0RdFEVez/qYlvOFSGrvVQW0QDLs3Vfhfc9LOdDn1OEVTQMhoENleI/Pd+fdEQxDFICWkhLJbmWmB8WPVaACy3F3NPaqDhCEmOMYdac7tbXvzi+xNUBKVX1mV0+lv2Zi6kt5IqGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976789; c=relaxed/simple;
	bh=uJumg9HfANwLa2GuanMHiIVQzENU/QGDz5hxvLMZtCE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OoLIQ2DtrZo4oUOePIWTOSL6A1q1JKxk/NjLlOdrJdCnaPz7dqgwcJJehgrPzWXzidGvsBlfpnM95WO9+1IQNMMhVzgTnsXBPAv/V/r/VI/bHOD2Drc8bRNY4NaQ6sSRi+vkmKUz0WH6RYwr1sPXhPfG0ZsGigN41cPZxeNXTIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CADC4CEED;
	Wed, 19 Feb 2025 14:53:07 +0000 (UTC)
Date: Wed, 19 Feb 2025 09:53:30 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Sven
 Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH 4/5] fprobe: Always unregister fgraph function from ops
Message-ID: <20250219095330.2e9f171c@gandalf.local.home>
In-Reply-To: <20250219095715.26c7b7811b05d3952c7bfa56@kernel.org>
References: <20250218193033.338823920@goodmis.org>
	<20250218193126.785837383@goodmis.org>
	<20250219095715.26c7b7811b05d3952c7bfa56@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 09:57:15 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Good catch! I forgot to remove the filter in this case.
> Is there anyway to be sure the filter is empty or clear it if
> fprobe_graph_active == 0?

You can call ftrace_free_filter(), but you need to make sure that the ops
is not active. Hmm, I should add a warning and exit if the ops is active
when that function is called.

-- Steve

