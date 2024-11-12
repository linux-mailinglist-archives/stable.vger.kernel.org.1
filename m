Return-Path: <stable+bounces-92816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 318509C5DA4
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 17:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA3CD281AB8
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 16:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2129207204;
	Tue, 12 Nov 2024 16:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="sw5tfxPQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332D1207202
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731429965; cv=none; b=dVGswT7dUvmPp4UlkLQpaEnJ/7uoa3YPerEh17mW2P8/CMzJDdqc/fZt/g62DWO3e31cFxQRsRMaeASvY8Dp/FChgjdE/c2t2GZXqRMs0CQAfgS6NuZ8Td67oF5T6IOjTRkcLl4L+wTliwE2E2s1Ue/+zb9n0I5CIeH6kAWPem4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731429965; c=relaxed/simple;
	bh=WR+aOSyYwrgldXqeUgY/GrhfFKL6OmuAO/PaK1Z+ZLM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GEXl9MaVwKd2X0rUy/YPMsVA0PDjxkxoge4EpB1NBAbas58Aai7+XwkuyJvRqmuqKqAQDS8DeAzXqzIm+eFiu+/VBFvkoQWTQ/KvNfEUPJu49ESPdUAy8nxCTVspjs5eJaGCkx6nWK4Q+uOHLlQxfRg+7lV+G454bzgYhmBow1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=sw5tfxPQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B272C4CECD;
	Tue, 12 Nov 2024 16:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1731429964;
	bh=WR+aOSyYwrgldXqeUgY/GrhfFKL6OmuAO/PaK1Z+ZLM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sw5tfxPQpykxtH4qrAnt4kFGBs/rMGI0o05HWTaMivXx6/Pn/oSB1g5dDI5o7JsaJ
	 mtNhDR0dcExCRJ9S8K8d/t2G/9DHbjR77+kK4zeZOfv5XlLsXVkzWCLfWW7OiuN1Wq
	 CarqRsV4zeXbslmRRByvjyi6fJ9ksyFjzCNc/gOo=
Date: Tue, 12 Nov 2024 08:46:03 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, maple-tree@lists.infradead.org,
 stable@vger.kernel.org, Hajime Tazaki <thehajime@gmail.com>
Subject: Re: [PATCH] nommu: pass NULL argument to vma_iter_prealloc()
Message-Id: <20241112084603.1c4e351fe21c9602422bf052@linux-foundation.org>
In-Reply-To: <uyvmziiho2gq2h2f2qwxob2ji7xztrkpxadhcso5lpdrplt24q@nyuqxxiww623>
References: <20241108222834.3625217-1-thehajime@gmail.com>
	<uyvmziiho2gq2h2f2qwxob2ji7xztrkpxadhcso5lpdrplt24q@nyuqxxiww623>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Nov 2024 07:46:18 -0500 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:

> Andrew,
> 
> Just in case you didn't notice, this patch was reviewed on another list.
> 
> Thanks,
> Liam
> 
> * Hajime Tazaki <thehajime@gmail.com> [241108 17:29]:
> > When deleting a vma entry from a maple tree, it has to pass NULL to
> > vma_iter_prealloc() in order to calculate internal state of the tree,
> > but it passed a wrong argument.  As a result, nommu kernels crashed upon
> > accessing a vma iterator, such as acct_collect() reading the size of
> > vma entries after do_munmap().
> > 
> > This commit fixes this issue by passing a right argument to the
> > preallocation call.
> > 
> > Fixes: b5df09226450 ("mm: set up vma iterator for vma_iter_prealloc() calls")
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > Signed-off-by: Hajime Tazaki <thehajime@gmail.com>

Yep, thanks, 247d720b2c5d in mm-hotfixes-stable.

