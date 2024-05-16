Return-Path: <stable+bounces-45332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DDD8C7CB6
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 20:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6FC61F2185F
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 18:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00275156F42;
	Thu, 16 May 2024 18:55:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F85156F3B;
	Thu, 16 May 2024 18:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715885735; cv=none; b=HFq4yTWIrYQSevxHh1ll7P7PPnvPqjYjNzyWyncSoNvSE/nGZHevC7rHXBHLmbpxCYihd111Ft9+8OgdW1unl7uG1P7rSZSv2w7R48d13kGoxTmQ7VyuCyMYdBN7WUhSOgOxzUPf+rVan9qx/RVj2C9WHD3CSoDTPkixahvdLHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715885735; c=relaxed/simple;
	bh=ZB9VgcF+oEFwkIJAF7UPLaqnoJsxrtGt9a2ZPXtX8hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EGWavwHKXScQbi2BY3PDaIb5YSaYbmIP+2WK5DTnjL+876skCTLsdgBf1n09rracrpaOv4xeK7dlgpOLwLpcYktsL4JZpIaTspRr92MWF5x6/FKG3dwOAnc1oLI4ESWAzz5Xrd7wk43JzjYecd+nLHUpSv4Q+6G0o+IrHzjr+Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E4BC32782;
	Thu, 16 May 2024 18:55:34 +0000 (UTC)
Date: Thu, 16 May 2024 14:55:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 6.8 000/340] 6.8.10-rc2 review
Message-ID: <20240516145532.268d5259@rorschach.local.home>
In-Reply-To: <CA+G9fYuexPg8yh61Bx58QN_y836rb-cfP4DS3ceesTmgohV-5Q@mail.gmail.com>
References: <20240515082517.910544858@linuxfoundation.org>
	<CA+G9fYsZ7iTr8UGyaN-FB1R8=zLWnciB_10mzk8QCRhUMLSfFQ@mail.gmail.com>
	<CA+G9fYuexPg8yh61Bx58QN_y836rb-cfP4DS3ceesTmgohV-5Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 May 2024 14:02:42 +0200
Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> > As Mark Brown reported and bisected.
> > LKFT also noticed this test regression on 6.8 and 6.6 branches.
> >
> > kselftest-ftrace test case,
> > ftrace_ftracetest-ktap_Test_file_and_directory_owership_changes_for_eventfs
> > failed on all the boards.
> >
> > Looks we need to add this patch,
> >   d57cf30c4c07837799edec949102b0adf58bae79
> >   eventfs: Have "events" directory get permissions from its parent
> >
> > Let me try this patch and get back to you.  
> 
> The cherry-pick failed.

That's because it depends on:

c3137ab6318d5 ("eventfs: Create eventfs_root_inode to store dentry")

-- Steve

