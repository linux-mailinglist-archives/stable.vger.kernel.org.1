Return-Path: <stable+bounces-177001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 129B6B3FEB4
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9499F188BB17
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 11:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405B42F8BC0;
	Tue,  2 Sep 2025 11:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gxn6mb9R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41B326F298
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 11:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813731; cv=none; b=Co+461hDKzlD7d6HU2SWZxwT67R23df4hsowLqYVfByZ+9KH0yJOTlRjkKp1CpnXVvHCni5OWskVhRFuGJqpJxIWMYzZWt12pweTCpQ8QIRwRtGELWh7KKA6m1Dt/DNu7hMhhg2eM1HjE7ti5RuiyfXgAgjXcjC+k3DvZHk25oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813731; c=relaxed/simple;
	bh=fd7bigQK/zJNmnQC3H644zUmb0+9BR4TMtuxmK5snpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifSbdsJKpN1x6pa4hPLoAtSEc4EJcO7rbO8ZNA6Alq8QF8rQ4hD/ln0nJG5zL5afySZ48h4T8/hiyWsfMsyrahQyghuFhCq46v4vtMh3ZVRW5YIgWAbZMvF1EfaTQsQGEGHq18urJWxUa9x4sv8PHmdMdwmrB0oscTxqw4vQgfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gxn6mb9R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD57C4CEED;
	Tue,  2 Sep 2025 11:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756813730;
	bh=fd7bigQK/zJNmnQC3H644zUmb0+9BR4TMtuxmK5snpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gxn6mb9RAFG5HhNLUvXtR6sqozymxnhj5Nxl7aBakU1ZDLWVBLKdAttr5rpOI/RNu
	 V0FuEXhBc3AG2RbAvanmBfzYiA2NkLKI+tI9ui6Vg9fBF//oc2gyn5rDifEnv4vO7Q
	 aoBrCz7BQwBtJ/wojcgvmtjZoe6AqDM0yH0eJM4HGY0FhUyyYSfoRkFfQZCXaUT8gN
	 1f3tZ4u8lQiGGP/uNHXW/Yz/enchq6z7GqtnvSnp9T4UIvfhOwdlGIDwzZ1nh1rlZp
	 udE6bbQtu1MU/Q/EiP8MGS0eChQol7OhPaSQJw2GNG3GnGfh03pio+c4oTkdq2Vcak
	 otNh1Xdsa2TcQ==
Date: Tue, 2 Sep 2025 07:48:49 -0400
From: Sasha Levin <sashal@kernel.org>
To: Norbert Manthey <nmanthey@amazon.de>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y 0/1] Backporting patches with git-llm-pick
Message-ID: <aLbZoQrlED0PN0pc@laps>
References: <2025011112-racing-handbrake-a317@gregkh>
 <20250901153559.14799-1-nmanthey@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250901153559.14799-1-nmanthey@amazon.de>

On Mon, Sep 01, 2025 at 03:35:58PM +0000, Norbert Manthey wrote:
>Dear all,
>
>we looked into improving commit backporting workflows. This specific commit in
>this series caught our attention, as it states that backporting will not be
>trivial. The commit message has this part:
>
>Backport hint: this patch will have a trivial conflict applying to
>v6.6.y, and other trivial conflicts applying to stable kernels < v6.6.
>
>We want to automate backporting commits with a similar property. Therefore, we
>build a tool git-llm-pick that simplifies the backporting commit. After
>cherry-picking, we try to automatically detect dependency-commits. In case of
>failure, we then try to use the patch tool. If this process fails, we then take
>the rejected patch files, and feed their content with other context and a task
>description to backport to an LLM. The resulting code modification is then
>applied. In case validation is passed, a commit is created. The commit message
>is always extended by a description of the adapted code change, and with which
>technique a commit was applied.

Very nice!

I have a similar workflow, but it does a slightly different thing. My main
issue with having LLM just fix up conflicts and commit them is that it becomes
really hard to understand what the LLM actually did.

If you look at the generated commit text in your example message, it states
"Removed the warning message as per the patch" which is really confusing: does
this refer to something that the LLM changed? Is this different from what the
original commit was trying to do? Why is this explicitly called out?

The way I do it on my end, is that I create a "merge triangle" which contains:

  - The original commit, as is
  - The fixup
  - An explanation to the fixup

So using this commit as an example, it would generate:

$ git log --oneline --graph -5
*   5d59fa7c4b981 (HEAD) Explanation
|\  
| * 46beb491ffff2 fs/notify: fix merge conflict in fdinfo.c
| * b5031eb894d34 fs: relax assertions on failure to encode file handles
|/  
* f89b6e15694c1 (tag: v6.1.149, stable/linux-6.1.y) Linux 6.1.149
* 46643021596a6 alloc_fdtable(): change calling conventions.

Which gives me "atomic" git units to work with, but still allowing for easy review.

The original patch will be committed with the merge conflict:

diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index 55081ae3a6ec0..22adbf533855b 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -50,11 +50,15 @@ static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
         f.handle.handle_bytes = sizeof(f.pad);
         size = f.handle.handle_bytes >> 2;
  
+<<<<<<< HEAD
         ret = exportfs_encode_inode_fh(inode, (struct fid *)f.handle.f_handle, &size, NULL);
         if ((ret == FILEID_INVALID) || (ret < 0)) {
                 WARN_ONCE(1, "Can't encode file handler for inotify: %d\n", ret);
+=======
+       ret = exportfs_encode_fid(inode, (struct fid *)f->f_handle, &size);
+       if ((ret == FILEID_INVALID) || (ret < 0))
+>>>>>>> 974e3fe0ac61d (fs: relax assertions on failure to encode file handles)
                 return;
-       }
  
         f.handle.handle_type = ret;
         f.handle.handle_bytes = size * sizeof(u32);

And then the following commit will address that:

diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index 22adbf533855b..dd5bc6ffae858 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -50,14 +50,8 @@ static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
         f.handle.handle_bytes = sizeof(f.pad);
         size = f.handle.handle_bytes >> 2;
  
-<<<<<<< HEAD
         ret = exportfs_encode_inode_fh(inode, (struct fid *)f.handle.f_handle, &size, NULL);
-       if ((ret == FILEID_INVALID) || (ret < 0)) {
-               WARN_ONCE(1, "Can't encode file handler for inotify: %d\n", ret);
-=======
-       ret = exportfs_encode_fid(inode, (struct fid *)f->f_handle, &size);
         if ((ret == FILEID_INVALID) || (ret < 0))
->>>>>>> 974e3fe0ac61d (fs: relax assertions on failure to encode file handles)
                 return;
  
         f.handle.handle_type = ret;

In this way, it's easy for me to see what exactly the LLM changed, making for
way easier review of "fuzzy" backports.

And finally, the merge commit will contain a longer LLM generated explanation
that I can also validate. This way, I validate two things: the actual code
change, and the LLM's reasoning. If both are sane, then it helps be build trust
in the backport. Here's the explanation for this commit:

commit 5d59fa7c4b981ec18ac730b4d8629ec33619de6f (HEAD)
Merge: f89b6e15694c1 46beb491ffff2
Author: Sasha Levin <sashal@kernel.org>
Date:   Tue Sep 2 07:28:10 2025 -0400

     Explanation
     
     The Problem
     
     The HEAD commit (b5031eb894d3) contained an improperly resolved merge conflict
     in fs/notify/fdinfo.c.
     
     The conflict markers showed:
     
     - HEAD version: Used exportfs_encode_inode_fh() with a WARN_ONCE() assertion
     - Incoming change: Incorrectly used exportfs_encode_fid() (non-existent
       function) with wrong syntax
     
     The Resolution
     
     I fixed it by:
     
     1. Keeping the correct function: exportfs_encode_inode_fh() (not the
     non-existent exportfs_encode_fid())
     2. Removing the WARN_ONCE assertion: As intended by the original commit to
     "relax assertions"
     3. Preserving correct syntax: Using f.handle.f_handle (not f->f_handle)
     
     Why This is Correct
     
     The original commit's purpose was to relax assertions when file handle encoding
     fails, because these assertions were incorrect and could trigger in valid
     scenarios.
     
     The fix:
     
     - Removes the problematic WARN_ONCE() that could trigger incorrectly
     - Keeps the proper API function that actually exists in the kernel
     - Maintains clean error handling without warnings for legitimate failures
     
     The code now silently returns on encoding failures instead of triggering
     warnings, which aligns with the commit's stated goal of relaxing assertions for
     file handle encoding failures

At this point in my workflow, I can just squash the fix into the original
commit and decorate the new resulting commit as needed for -stable.

>We made the tool available on github: https://github.com/awslabs/Git_llm_pick/
>We currently use LLMs via the AWS Bedrock service, and default to the Nova Pro
>model. The patch in this series uses the vanilla version of the tool's current
>output when running git-llm-pick in its virtual test environment:

One note about the tool: in my experience, unless the tool can also act as an
agent and investigate the relevant git repo (and attempt builds and run tests)
on it's own, the results used to be very lackluster.

Without agentic access to more context/tooling, the LLM was guessing way too
much :)

-- 
Thanks,
Sasha

