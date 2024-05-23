Return-Path: <stable+bounces-45642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 144838CCF45
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 11:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82FB28832B
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 09:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47D713D26E;
	Thu, 23 May 2024 09:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Kigr3+qM"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388D14F8BB;
	Thu, 23 May 2024 09:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716456475; cv=none; b=VHEIUXirJjsQBJFTm7pUDcYyiBfH5ybVdkQPOW95Rm4uLRofx5C1gyF0wfGUBzCi7je160KL/cbLabtkgNVIlbEkLN/l2myh+iadE5G2u6T28EbaEAkN1PnudEc1WLp/4uUIICID8Z481jBmt2IMBaUefGI5Qu5MR1QkzJTzPAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716456475; c=relaxed/simple;
	bh=dWtO02lqbwVZmnSVu5btIru4KS2lGopOAT6JAykDeXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyL9w9wfIuL6HVUqL5iAIzhZEzwJqDpra4p3tkY43GO4AuOK/sgbqgEMQ2Z1C6/uV9XCps9zkuGxPTf7shrCXHy1gjDeqyaFS8j1B8boCgs+umFCRtXJ0G11IaDQA3gjlb5Xqh8uFfwBDolQ2oJy8/V9li0Ycnzha6rko1Nxlys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Kigr3+qM; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 2E26A14C2DB;
	Thu, 23 May 2024 11:27:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1716456469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DrZlTviE644M9ThwmAq1xAzcas38uFQOXVc3W+d/Maw=;
	b=Kigr3+qMahYfNoPNTSeO+bBCgRLWiQdMuJhplL9xfcbxmtX0M5lawm8vWSKd/1tAoZkqqc
	xfvmxOzk1QmgkmAJcFpVVySLjXJhHnD3QKNZqOGwbXJL/i1SnQRtJfmYtfuJ5ULsBOOkVq
	jrOr3mv7KI+YftxrMNd5IC2TgzwRnPPzxq5byMR7hS+xCd1F0fGjnW4Bl95iZ8TGcsstev
	pn9jaFApDIvN5RG/7urttUU+EqpaVayXodTOM6DvQZar7Ic1BYTdzxdjvFA7wql6iSmYP+
	CP3DTj9rs8orbPbosV859eHJOxTv6i8hM223DIf9iRyseYiGb/OwLAGVSo3heA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 3649b515;
	Thu, 23 May 2024 09:27:43 +0000 (UTC)
Date: Thu, 23 May 2024 18:27:28 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>, Greg Kurz <groug@kaod.org>,
	Jianyong Wu <jianyong.wu@arm.com>, stable@vger.kernel.org,
	Eric Van Hensbergen <ericvh@gmail.com>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p: add missing locking around taking dentry fid list
Message-ID: <Zk8MAFAWIUPlhGFe@codewreck.org>
References: <20240521122947.1080227-1-asmadeus@codewreck.org>
 <1738699.kjPCCGL2iY@silver>
 <Zk4qcmtot6WEC1Xx@codewreck.org>
 <3116644.1xDzT5uuKM@silver>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3116644.1xDzT5uuKM@silver>

Christian Schoenebeck wrote on Thu, May 23, 2024 at 10:34:14AM +0200:
> > The comment still works -- if detry->d_fsdata is NULL then
> > hlist_for_each_entry will stop short and not iterate over anything (it
> > won't bug out), so that part is fine in my opinion.
> 
> I meant the opposite: dentry->d_fsdata not being NULL.

I also meant that in the d_fsdata not being NULL branch, if d_fsdata
turns out to be NULL when it is read under lock later.

> In this case v9fs_fid_find() takes a local copy of the list head
> pointer as `h` without taking a lock before.

It doesn't, it takes &dentry->d_fsdata so the address of d_fsdata before
the lock, but that address cannot change here (another thread cannot
change the address of the dentry) ...(continuing below)

> Then v9fs_fid_find() takes the lock to run hlist_for_each_entry(), but at this
> point `h` could already point at garbage.

... so *h (in practice, head->first in hlist_for_each_entry()) will
properly contain the first node of the list under lock: either NULL if
we just cleared it (at which point the loop won't iterate anything), or
a new list if other items have been added meanwhile.


I really think it's safe, but I do agree that it's hard to read, happy
to move the `h = &dentry->d_fsdata` inside the lock if you prefer -- it
compiles to the same code for me (x86_64/gcc 13.2.0)
-- 
Dominique Martinet | Asmadeus

