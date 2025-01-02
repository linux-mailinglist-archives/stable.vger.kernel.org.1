Return-Path: <stable+bounces-106667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB5BA00113
	for <lists+stable@lfdr.de>; Thu,  2 Jan 2025 23:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 069C1162F08
	for <lists+stable@lfdr.de>; Thu,  2 Jan 2025 22:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FDA1B85C5;
	Thu,  2 Jan 2025 22:08:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2F41487E1;
	Thu,  2 Jan 2025 22:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735855731; cv=none; b=Er2Hnol2DpSmmU6zg/xC2V8T9UxmRtwriogKw2jr5KlSyE8i+r8ZIkE2e3J72yVKsKDA4pu1nYnGK/O8JktuT2r/55yADiPY9AoInwXSSR4C3NhAfUNIxupAQVKmwDuABU7nOsHri4B0oZk9jhvYNkb9PD7Uhfw2VvVVwTmJwjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735855731; c=relaxed/simple;
	bh=LZCJlQr1BIlEMLtNZIjTfpKs1sPx8Klfp1O5HdYWRGE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JiOpBb91rf98n5ClH19c5oNp3XgKlbHjRHi5JaKU47DSq+uchWP/dxCCM72br7Ndcxc4QnHeYjZnCgHHwfp9zEOnaXwXfumK4BkTtztXnW0s6pvArSrkc1VpHHchlGF7GngpUPAHZk4gkICM+9AjmyD9R2a873zTbp8z6Qdv4jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6EF0C4CED0;
	Thu,  2 Jan 2025 22:08:50 +0000 (UTC)
Date: Thu, 2 Jan 2025 17:10:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: kernel test robot <lkp@intel.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [for-linus][PATCH 1/2] fgraph: Add READ_ONCE() when accessing
 fgraph_array[]
Message-ID: <20250102171007.1c41355a@gandalf.local.home>
In-Reply-To: <Z3cNawJpV5b4Ob8_@997da2bbb901>
References: <20250102220309.941099662@goodmis.org>
	<Z3cNawJpV5b4Ob8_@997da2bbb901>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 Jan 2025 06:04:27 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi,
> 
> Thanks for your patch.
> 
> FYI: kernel test robot notices the stable kernel rule is not satisfied.
> 
> The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1
> 
> Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
> Subject: [for-linus][PATCH 1/2] fgraph: Add READ_ONCE() when accessing fgraph_array[]
> Link: https://lore.kernel.org/stable/20250102220309.941099662%40goodmis.org
> 

I noticed that it has "Cc:stable@vger.kernel.org". I guess it needs a space
before "stable"?

-- Steve

