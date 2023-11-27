Return-Path: <stable+bounces-2746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FB87F9F2E
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 12:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73B0B1C20B33
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 11:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663AB1BDD3;
	Mon, 27 Nov 2023 11:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E5B18E2B
	for <stable@vger.kernel.org>; Mon, 27 Nov 2023 11:59:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A39C433C7;
	Mon, 27 Nov 2023 11:59:48 +0000 (UTC)
Date: Mon, 27 Nov 2023 11:59:46 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Helge Deller <deller@gmx.de>
Cc: gregkh@linuxfoundation.org, sam@gentoo.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, Florent Revest <revest@chromium.org>,
	Kees Cook <keescook@chromium.org>
Subject: Re: FAILED: patch "[PATCH] prctl: Disable prctl(PR_SET_MDWE) on
 parisc" failed to apply to 6.5-stable tree
Message-ID: <ZWSEsrpogmi7LQa_@arm.com>
References: <2023112456-linked-nape-bf19@gregkh>
 <1aadb9ed-5118-4a6f-a273-495466f4737b@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1aadb9ed-5118-4a6f-a273-495466f4737b@gmx.de>

On Fri, Nov 24, 2023 at 04:10:25PM +0100, Helge Deller wrote:
> On 11/24/23 12:35, gregkh@linuxfoundation.org wrote:
> > The patch below does not apply to the 6.5-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 793838138c157d4c49f4fb744b170747e3dabf58
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112456-linked-nape-bf19@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..
> > 
> > Possible dependencies:
> > 
> > 793838138c15 ("prctl: Disable prctl(PR_SET_MDWE) on parisc")
> > 24e41bf8a6b4 ("mm: add a NO_INHERIT flag to the PR_SET_MDWE prctl")
> > 0da668333fb0 ("mm: make PR_MDWE_REFUSE_EXEC_GAIN an unsigned long")
> 
> Greg, I think the most clean solution is that you pull in this patch:
> 
> commit 24e41bf8a6b424c76c5902fb999e9eca61bdf83d
> Author: Florent Revest <revest@chromium.org>
> Date:   Mon Aug 28 17:08:57 2023 +0200
>     mm: add a NO_INHERIT flag to the PR_SET_MDWE prctl
> 
> as well into 6.5-stable and 6.6-stable prior to applying my patch.
> 
> Florent, Kees and Catalin, do you see any issues if this patch
> ("mm: add a NO_INHERIT flag to the PR_SET_MDWE prctl") is backported
> to 6.5 and 6.6 too?
> If yes, I'm happy to just send the trivial backport of my patch below...

TBH, given that the NO_INHERIT MDWE is a new feature and it took us a
few rounds to define its semantics, I'd rather not back-port it unless
someone has a strong need for it in 6.5 (not sure the stable rules even
allow for this). The parisc patch is simple enough to be backported on
its own.

-- 
Catalin

