Return-Path: <stable+bounces-33921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A05893A4A
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 12:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D37D9B20D02
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 10:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B14200CD;
	Mon,  1 Apr 2024 10:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iDDwBRlD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE441F602
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 10:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711968361; cv=none; b=u2tcRSi6VkCAZOcZ8iWE/MseYLUWLLwXGadTUYJ+synl51QM9BLS0Ajcb9uFPmlPZBLi+wgzEwkYh158hS34kHoc5f3lEcQtG9K47JacCyoiFidRhfTOYhak2NqmReE/BBMlcRqnugsoCjVZhNueUsT7eH6k294toNEHiJA+zYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711968361; c=relaxed/simple;
	bh=6Qzto1faXWRdxOC52l6PKuWnbp7qp3Y9qlyjsldis3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSuH0YN7IQWDj64LR3ha1UypSRqyy/w5g+xwDFoaFoxhK0htGPnwbxgzGBPzOa3dRFSOj98lXoT7HooNx+2Ogolqj2bfu6EGy1xEj2mX24pHbSqGMwTzaxjNxJgOqYaHNzH9gWS+xscU4DnUfMw5skHheOOujzlKNtw0FMD3Yfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iDDwBRlD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00ACDC43399;
	Mon,  1 Apr 2024 10:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711968360;
	bh=6Qzto1faXWRdxOC52l6PKuWnbp7qp3Y9qlyjsldis3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iDDwBRlDNzlqYpy641PXcspJjYyxUkAUeC/m7sO0VlyJDEWal01l4QRnRMgmXFO5a
	 4L5KIqjvH22dd+o6ICjBFMeBxC+ndZ4Xlf61bYAbzxWXEl0BUtO4FqtjoeZnokbFZU
	 CGq/BUQFXNvEjRRi3jFLKOziOoM2+0VmJhftlozk=
Date: Mon, 1 Apr 2024 12:45:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, chenhuacai@loongson.cn, dyoung@redhat.com,
	jbohac@suse.cz, lihuafei1@huawei.com, mingo@kernel.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] crash: use macro to add crashk_res into
 iomem early for" failed to apply to 6.8-stable tree
Message-ID: <2024040150-cattle-fragility-b813@gregkh>
References: <2024033005-graded-dangle-3a21@gregkh>
 <Zgp0vZityCen4Ngd@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zgp0vZityCen4Ngd@MiWiFi-R3L-srv>

On Mon, Apr 01, 2024 at 04:47:57PM +0800, Baoquan He wrote:
> On 03/30/24 at 10:29am, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.8-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.8.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 32fbe5246582af4f611ccccee33fd6e559087252
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024033005-graded-dangle-3a21@gregkh' --subject-prefix 'PATCH 6.8.y' HEAD^..
> > 
> > Possible dependencies:
> > 
> > 32fbe5246582 ("crash: use macro to add crashk_res into iomem early for specific arch")
> > 85fcde402db1 ("kexec: split crashkernel reservation code out from crash_core.c")
> 
> I back ported it to 6.8 stable tree according to above steps of
> git operation as below. Please feel free to add it in.

Now queued up, thanks!

greg k-h

