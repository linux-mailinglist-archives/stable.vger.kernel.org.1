Return-Path: <stable+bounces-18760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4759848A20
	for <lists+stable@lfdr.de>; Sun,  4 Feb 2024 02:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6FE11C2290D
	for <lists+stable@lfdr.de>; Sun,  4 Feb 2024 01:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EECDA32;
	Sun,  4 Feb 2024 01:25:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624CA10F7;
	Sun,  4 Feb 2024 01:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707009906; cv=none; b=qZcCcSRKWMI5f/eXQssvH3Q4elRZBl2ZPwwg927QbUZN3K8pZhvy2aQlIvItOY+zXuLpbOMvVK+0zpRguf0NxI3UwFFxdZaYqQOqAERHMbCY1dNZzpONeFaqiLjvbeR6Qy+hrpr6H6+CYVatUpPqXtqi5mB11OUlNipVINW4YIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707009906; c=relaxed/simple;
	bh=XIm9DN4ctz7XXWE6x9NfH110tJP8Bt6G0T6aQI1oX1o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ou0vdRR4gwTlELQKvFvD7dhadbbq4zE0y9+Ub4y3DorNwQiUcsRcx08RYHCiGoMnJHnE6NRm6dPJT3L2mB1786Gs+EIWwrIhJcIIhxeHGw1PtSygSdQN2hbErm4XmOJAI6Hu7rbF7dca1o5NRmotu4cB8KFbqMRw/ItmLrkFbJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6272EC433C7;
	Sun,  4 Feb 2024 01:25:05 +0000 (UTC)
Date: Sat, 3 Feb 2024 20:25:03 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [v6.7][PATCH 00/23] eventfs: Linus's updates for 6.7
Message-ID: <20240203202503.0e37a22f@rorschach.local.home>
In-Reply-To: <20240204011615.703023949@goodmis.org>
References: <20240204011615.703023949@goodmis.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 03 Feb 2024 20:16:15 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> This is the update for 6.7. It includes Linus's updates as well as all the
> patches leading up to them.

Hmm, I just realized I didn't include the sha of the upstream commit. I
simply ran the following command against v6.7.3:

git log --reverse --no-merges --pretty=oneline v6.7..origin/master fs/tracefs/ | cut -d' ' -f1 | while read a; do if ! git cherry-pick $a; then break; fi ; done

And I believe I removed one unrelated patch.

I know that cherry-pick has a '-x' option that adds a: "(cherry picked from commit ...)"
I can re-run it and make sure it still matches this branch if it makes
it easier for you.

-- Steve

