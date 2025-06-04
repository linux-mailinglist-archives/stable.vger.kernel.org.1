Return-Path: <stable+bounces-151280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F00ACD51E
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 03:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03190174115
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 01:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E08428E3F;
	Wed,  4 Jun 2025 01:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I0VSVNaT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F08BE67;
	Wed,  4 Jun 2025 01:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749001876; cv=none; b=NHoPpouR1155cqo0nW5L12Yj3X8uDoK7mFeZI4R2AzrmHB7TBXzbBmaKusbWy1a4I+kpntd6vqLnjp4U4fN9cxE2W7kBzmsY/3xRynjqCo8A0UKY0duWDrK0uwhwScTEV936JhjPG3qZYaZwgYhFbfnIxKwLPNZDjXLWff3h4XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749001876; c=relaxed/simple;
	bh=F55+0BrFpp7D090E53WqDegRyhaRG3ldOxQ90R+7eA8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XOAoExCxwfkel3JivdRonA7JCZmFRmiU1K0kT3EHC7SpMM7yx9AJI8iO53APgSW8uFJRslcJaboBlGjzQydOkKQfqwjd5ykpZ/NnceqrPqfXF5XncAbfD0DsN4Sq3RwjtyA8qtVFcE+q2InjPzUgpP4zteTHXWSfeQEeri7aJPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=I0VSVNaT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DA9C4CEED;
	Wed,  4 Jun 2025 01:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1749001875;
	bh=F55+0BrFpp7D090E53WqDegRyhaRG3ldOxQ90R+7eA8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I0VSVNaTHACDuZ9raG6j5qZSpl/ZdrpRAtqAdLiCVE/BHmG9ZM6C5ZjWGYRtDkn+k
	 MkQBe2MaCqzyr9z/OIjwya5FHbbvUj3TFlNfuDKDd1JFkSycaOtMHotlNQmOLCqTtb
	 ozl00yCF0rfhX3Fe8SFCXxEifWI8dMD8Pn2nEcnM=
Date: Tue, 3 Jun 2025 18:51:14 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Pu Lehui
 <pulehui@huaweicloud.com>, mhiramat@kernel.org, oleg@redhat.com,
 peterz@infradead.org, Liam.Howlett@oracle.com, vbabka@suse.cz,
 jannh@google.com, pfalcato@suse.de, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, pulehui@huawei.com
Subject: Re: [PATCH v1 1/4] mm: Fix uprobe pte be overwritten when expanding
 vma
Message-Id: <20250603185114.35e9fa260cc314a110f8b08f@linux-foundation.org>
In-Reply-To: <6d7c2cd2-061e-4295-8e9a-832cd0185d8c@redhat.com>
References: <20250529155650.4017699-1-pulehui@huaweicloud.com>
	<20250529155650.4017699-2-pulehui@huaweicloud.com>
	<962c6be7-e37a-4990-8952-bf8b17f6467d@redhat.com>
	<009fe1d5-9d98-45f1-89f0-04e2ee8f0ade@lucifer.local>
	<6dd3af08-b3be-4a68-af3d-1fc1b79f4279@redhat.com>
	<117e92c1-d514-4661-a04b-abe663a72995@lucifer.local>
	<702d4035-281f-4045-aaa7-3d6c3f7bdb68@redhat.com>
	<86b7cfb9-65d2-4737-a84d-e151702895f1@lucifer.local>
	<6d7c2cd2-061e-4295-8e9a-832cd0185d8c@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Jun 2025 14:16:37 +0200 David Hildenbrand <david@redhat.com> wrote:

> >> We're in the corner cases now, ... so this might not be relevant. But I hope
> >> we can clean up that uprobe mmap call later ...
> > 
> > Yeah with this initial fix in we can obviously revisit as needed!
> 
> As Andrew was asking off-list:
> 
> Acked-by: David Hildenbrand <david@redhat.com>

OK, thanks.  I'll aim to send this series in to Linus during this merge
window.


