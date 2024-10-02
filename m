Return-Path: <stable+bounces-80551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1B398DE29
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 17:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3FD91C2318C
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C7D155346;
	Wed,  2 Oct 2024 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSmBAS0p"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F067489
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881221; cv=none; b=lZNB/TPI8B9UgJ+Z4gDJRo+h+j0n0v55mW17XcVSXoelVJHyOxUOXf09rVfD7ko7HGyA+cqNk2hj2EMNP7kQPDPmm2SSTCyY59MiUjavbxDupKNd1ebNBe6c4vNQZpKVYLGqDUxCqabA5uJRTcHQPFGzNm3NcU9+vtNBczs5hOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881221; c=relaxed/simple;
	bh=+AJkmTFdksUy0oAao+z6NP1TJ2wJ5ZtSc3ktA87gHPY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bnOf1blTHyrv9gZnetKKPtEOLPkj5XU4PJdBTMcUv6raAM3QKoPSVNAfBP9+g4bfEwZsHi8cVhiDsganrqojNzdjouB+zwjJkULKz8b48BgDAfpglrvsl825mXpIvV3YpcjCtA2akp+TQHvCFjR6t3127CNTvjVMU4SvVB76xHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YSmBAS0p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727881217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NoyJhybhiBGXeteZUIUN27Tgv0sQeZpS4X+sfVBeVQM=;
	b=YSmBAS0pniXS9BgRtIAK1x9Z98th6aD/o+2cVZqYeMAy7PxFRBDOWwqe6hsE13edwCrgso
	ewkLxRY4cVIwV5hHn09zze0LZzus55tjXsG4COW7OEKGCOR0QiMnMFcSCqtgfPLAcynDdn
	Nnd+wOLdVY+Dnu5JYUcFjCFF5BpAsTw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-Zm8NP9iGMLmncAKZLmR9HQ-1; Wed,
 02 Oct 2024 11:00:14 -0400
X-MC-Unique: Zm8NP9iGMLmncAKZLmR9HQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F56F19560A3;
	Wed,  2 Oct 2024 15:00:13 +0000 (UTC)
Received: from [10.45.225.58] (unknown [10.45.225.58])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD51D300019B;
	Wed,  2 Oct 2024 15:00:10 +0000 (UTC)
Date: Wed, 2 Oct 2024 17:00:03 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
cc: dfirblog@gmail.com, stable@vger.kernel.org, 
    Sami Tolvanen <samitolvanen@google.com>, Will Drewry <wad@chromium.org>
Subject: Re: FAILED: patch "[PATCH] dm-verity: restart or panic on an I/O
 error" failed to apply to 6.1-stable tree
In-Reply-To: <2024100204-mammogram-clumsily-4e70@gregkh>
Message-ID: <7192501b-2b7a-7b3f-85a5-50ebff3694d1@redhat.com>
References: <2024100247-friction-answering-6c42@gregkh> <93f37f10-e291-5c88-f633-9a61833a7103@redhat.com> <2024100204-mammogram-clumsily-4e70@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4



On Wed, 2 Oct 2024, Greg KH wrote:

> On Wed, Oct 02, 2024 at 12:25:11PM +0200, Mikulas Patocka wrote:
> > Hi Greg
> > 
> > I would like to as you to drop this patch (drop it also from from 6.6, 
> > 6.11 and others, if you already apllied it there).
> > 
> > Google engineeres said that they do not want to change the default 
> > behavior.
> 
> Is it reverted somewhere?  I'd prefer to take the revert otherwise our
> scripts will continue to want to apply this over time.
> 
> If there is no revert, well, we are just mirroring what is in Linus's
> tree :)
> 
> thanks,
> 
> greg k-h

I've just sent a revert pull request to Linus - see 
https://marc.info/?l=dm-devel&m=172788030731700&w=2

The revert's commit ID is 462763212dd71c41f092b48eaa352bc1f5ed5d66.

I've seen that you already applied the commit 
e6a3531dd542cb127c8de32ab1e54a48ae19962b ("dm-verity: restart or panic on 
an I/O error") to 6.6, 6.10 and 6.11.

So, please apply the revert to 6.6, 6.10 and 6.11 as well, before you 
release them.

Mikulas


