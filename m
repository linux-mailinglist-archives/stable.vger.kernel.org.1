Return-Path: <stable+bounces-1996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F38ED7F824F
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84D46B23C5C
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AC4364C1;
	Fri, 24 Nov 2023 19:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B99F35F04
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 19:06:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3589AC433CA;
	Fri, 24 Nov 2023 19:06:30 +0000 (UTC)
Date: Fri, 24 Nov 2023 20:06:27 +0100
From: Helge Deller <deller@gmx.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Helge Deller <deller@gmx.de>, sam@gentoo.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, Florent Revest <revest@chromium.org>,
	Kees Cook <keescook@chromium.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: FAILED: patch "[PATCH] prctl: Disable prctl(PR_SET_MDWE) on
 parisc" failed to apply to 6.5-stable tree
Message-ID: <ZWD0MyYd2ev12SIl@p100>
References: <2023112456-linked-nape-bf19@gregkh>
 <1aadb9ed-5118-4a6f-a273-495466f4737b@gmx.de>
 <2023112420-reward-relative-f84d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023112420-reward-relative-f84d@gregkh>

* Greg KH <gregkh@linuxfoundation.org>:
> On Fri, Nov 24, 2023 at 04:10:25PM +0100, Helge Deller wrote:
> > On 11/24/23 12:35, gregkh@linuxfoundation.org wrote:
> > > The patch below does not apply to the 6.5-stable tree.
> > > If someone wants it applied there, or to any other stable or longterm
> > > tree, then please email the backport, including the original git commit
> > > id to <stable@vger.kernel.org>.
> > > 
> > > To reproduce the conflict and resubmit, you may use the following commands:
> > > 
> > > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
> > > git checkout FETCH_HEAD
> > > git cherry-pick -x 793838138c157d4c49f4fb744b170747e3dabf58
> > > # <resolve conflicts, build, test, etc.>
> > > git commit -s
> > > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112456-linked-nape-bf19@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..
> > > 
> > > Possible dependencies:
> > > 
> > > 793838138c15 ("prctl: Disable prctl(PR_SET_MDWE) on parisc")
> > > 24e41bf8a6b4 ("mm: add a NO_INHERIT flag to the PR_SET_MDWE prctl")
> > > 0da668333fb0 ("mm: make PR_MDWE_REFUSE_EXEC_GAIN an unsigned long")
> > 
> > Greg, I think the most clean solution is that you pull in this patch:
> > 
> > commit 24e41bf8a6b424c76c5902fb999e9eca61bdf83d
> > Author: Florent Revest <revest@chromium.org>
> > Date:   Mon Aug 28 17:08:57 2023 +0200
> >     mm: add a NO_INHERIT flag to the PR_SET_MDWE prctl
> > 
> > as well into 6.5-stable and 6.6-stable prior to applying my patch.
> > 
> > Florent, Kees and Catalin, do you see any issues if this patch
> > ("mm: add a NO_INHERIT flag to the PR_SET_MDWE prctl") is backported
> > to 6.5 and 6.6 too?
> > If yes, I'm happy to just send the trivial backport of my patch below...
> 
> Given that we need an explicit ack for adding mm: patches to the stable
> trees, I'll wait for that to happen here before adding it.

Sure!

Just in case we get a NAK, below is the backported patch of 793838138c157d4c49f4fb744b170747e3dabf58
which applies to 6.5-stable and 6.6-stable.
Maybe you want to add it in the meantime?

Helge


From: Helge Deller <deller@gmx.de>
Date: Sat, 18 Nov 2023 19:33:35 +0100
Subject: [PATCH] prctl: Disable prctl(PR_SET_MDWE) on parisc

systemd-254 tries to use prctl(PR_SET_MDWE) for it's MemoryDenyWriteExecute
functionality, but fails on parisc which still needs executable stacks in
certain combinations of gcc/glibc/kernel.

Disable prctl(PR_SET_MDWE) by returning -EINVAL for now on parisc, until
userspace has catched up.

Signed-off-by: Helge Deller <deller@gmx.de>
Co-developed-by: Linus Torvalds <torvalds@linux-foundation.org>
Reported-by: Sam James <sam@gentoo.org>
Closes: https://github.com/systemd/systemd/issues/29775
Tested-by: Sam James <sam@gentoo.org>
Link: https://lore.kernel.org/all/875y2jro9a.fsf@gentoo.org/
Cc: <stable@vger.kernel.org> # v6.3+

diff --git a/kernel/sys.c b/kernel/sys.c
index 2410e3999ebe..2fa67cd61685 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2377,6 +2377,10 @@ static inline int prctl_set_mdwe(unsigned long bits, unsigned long arg3,
 	if (bits & ~(PR_MDWE_REFUSE_EXEC_GAIN))
 		return -EINVAL;
 
+	/* PARISC cannot allow mdwe as it needs writable stacks */
+	if (IS_ENABLED(CONFIG_PARISC))
+		return -EINVAL;
+
 	if (bits & PR_MDWE_REFUSE_EXEC_GAIN)
 		set_bit(MMF_HAS_MDWE, &current->mm->flags);
 	else if (test_bit(MMF_HAS_MDWE, &current->mm->flags))

