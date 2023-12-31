Return-Path: <stable+bounces-9139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF595820BDD
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 16:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB8971C21329
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 15:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C2F6132;
	Sun, 31 Dec 2023 15:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzNF5lfE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D90E63A7;
	Sun, 31 Dec 2023 15:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788B0C433C8;
	Sun, 31 Dec 2023 15:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704037373;
	bh=ugUHGXN1wnY8yOHwqohHOciRnTZQxc/VpJob2I72q7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mzNF5lfEDU3TkEGX8nvB8tCdzgGCe+FUmaUEx0jnxhRYMkZRM0K7jo+0vvs8pT8iz
	 +tHo1UMQxuieOkOuLvLBW6JSNopKXYNaSpBhGNNxXSV/iAE2O1ifNRs06uK2b5dh8R
	 bG/xyMlcZsR/serBw+uPbFOYz6/YNEkxLK/SCih+GuP7t7s6F4jlMEV0Nw1sR6WuLJ
	 0yrw/wVEcIp3VHwJorAAibsPz1Zv1E/fxZmZg4kPWDrHJR3++5VFgktVoGYIbWlCTV
	 Qy1OaXcZDPvB0d/6Dscxbal+HcRSO5qPyQXVfoCDi0ijYsPuDMyF0Lrwcb0bSU0Rcp
	 gkb0qcpiLB0rg==
Date: Sun, 31 Dec 2023 10:42:52 -0500
From: Sasha Levin <sashal@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: stable-commits@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	stable <stable@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Patch "ring-buffer: Force absolute timestamp on discard of
 event" has been added to the 6.1-stable tree
Message-ID: <ZZGL_COQ_bo-dnEy@sashalap>
References: <20231210194035.164923-1-sashal@kernel.org>
 <20231230112246.72c8b2cd@gandalf.local.home>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231230112246.72c8b2cd@gandalf.local.home>

Hey Steve,

On Sat, Dec 30, 2023 at 11:22:46AM -0500, Steven Rostedt wrote:
>
>Sasha,
>
>Was this automated or did you do this manually?

This is mostly automated.

>I'm asking because I was walking through my INBOX to see what FAILED
>backports I could clean up, and I started on this one:
>
>  https://lore.kernel.org/all/2023120938-unclamped-fleshy-688e@gregkh/
>
>I did the cherry pick, fixed up the conflict, but when I tried to commit
>it, it failed because there was nothing to commit.
>
>This confused me for a bit, and then when I did a git blame, I saw that you
>had done the fix already.
>
>When you fix a FAILED patch, can you do a reply to the FAILED message that
>Greg sends out, so that I don't waste my time on trying to fix something
>that was already fixed?

The process I have is that I go over the stable tagged commits with a
week or two delay, and attempt to apply the commits that aren't in the
tree yet using the dependency bot.

I can look into how to tie this into Greg's FAILED emails; I used to do
the above manually and reply to those mails, but now the process is
slightly different and there's no direct connection between the two.

-- 
Thanks,
Sasha

