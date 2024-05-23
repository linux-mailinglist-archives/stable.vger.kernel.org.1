Return-Path: <stable+bounces-45644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F15F48CCFED
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 12:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D1C71C2083A
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 10:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A605413D517;
	Thu, 23 May 2024 10:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="o8PXcoLF"
X-Original-To: stable@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F58654FA9;
	Thu, 23 May 2024 10:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716458767; cv=none; b=lREXmyNzv/CJa378ZnBy3C1KPx414oy8V5BoG3oV9fX4dkWFiiWjCN46T2XP/rlFhkkivF7L5+qrOrQUD+cqlRbyKF3S3qxlaAw4GaApq4chLHC+Hn2rvF1WVOQUeD5VlvslFqGFEz3BqkhXxQNOC8Z4K0DjrnE6TjH2WP/Q7RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716458767; c=relaxed/simple;
	bh=6hZfU/vZlrz4/bVBw0R53ZF51GPkuNffAAaPgUYgJMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dett5vARAR1lZPlSHBh8o9e60PRY+b2CKJr8DNhuk9/sUhwSgmlTfMf/j8D0HvaHK5avA0IGskPclNQlcIdP3a0IVove6yImYBb9qeP8ZPkStiBf/r2FiFHbxVikTrDBUAl9HMAIBRgNaEq5dqwcLsWMR5X74G1+exQFffwfJ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=o8PXcoLF; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=f8jC17nCt232w/3lqbKjfEROHlbH51l5S8kUPNZoSNw=; b=o8PXcoLFtZFkuMCBmDWq+qpc+k
	Z1muJ0pfMgOzZJ6+41nkyh0+fyRmX27rfctbCLX4Pe2SH7oVYsR6RUifgKykHr3prBkVOD8cVKWae
	jOsAbsLdpKwjbHD/LCCk9eoVOF9avnwEk/9FyPaRfIVZEj+q1qjimPCJio7KYuCt4GcKCw0DIjOk5
	Gf7sKHCppxAE+qQJ3ETeBcr4m+9v+klRmLiSOiNswLvzVjISMCnW+GDLRJATaHLp4QEB9KxLnkVGy
	MLMgq+2YzSsBMMNJ7ipirr+zYb/5haXrY5XUO08JWTH40ldZJTsDrZU9JvbF1wjrynDQWNnrHQsvY
	2gXfa7Z+xV6INwNd8bjats2GjC+ZCXKMBN4TWir1r9fkgEgfeaODFRmPe4wsjDdVR5/Kcw39zwjLn
	ytAUyuVRlmJZsEi36i8/kNm1Po9NQHo8yqGu4I6BSRSdau9eYkQh5Z6dPxkanT8bf1XhFO16yW+WA
	Q1FcCWKz9WL8p7DJm+sQeKHCjlT6dkw3B76soDP8JbrKP9o5xTBthhEIm2EtbCLBaxSf3O3YwDcPt
	foSkcm9qYyOWwpeR+NAVjBfeMaTlD3n2SeUCQRLLKjdFxnhA0Fz8tHYq3OzVEvaEMjnExWGjwzPhz
	u2+lq7c0KNPraDlCrd8qwBZw68g/RqLL6AeKfI+qs=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>, Greg Kurz <groug@kaod.org>,
 Jianyong Wu <jianyong.wu@arm.com>, stable@vger.kernel.org,
 Eric Van Hensbergen <ericvh@gmail.com>, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p: add missing locking around taking dentry fid list
Date: Thu, 23 May 2024 12:05:44 +0200
Message-ID: <2675095.dNBKFZOyUv@silver>
In-Reply-To: <Zk8MAFAWIUPlhGFe@codewreck.org>
References:
 <20240521122947.1080227-1-asmadeus@codewreck.org> <3116644.1xDzT5uuKM@silver>
 <Zk8MAFAWIUPlhGFe@codewreck.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, May 23, 2024 11:27:28 AM CEST Dominique Martinet wrote:
> Christian Schoenebeck wrote on Thu, May 23, 2024 at 10:34:14AM +0200:
> > > The comment still works -- if detry->d_fsdata is NULL then
> > > hlist_for_each_entry will stop short and not iterate over anything (it
> > > won't bug out), so that part is fine in my opinion.
> > 
> > I meant the opposite: dentry->d_fsdata not being NULL.
> 
> I also meant that in the d_fsdata not being NULL branch, if d_fsdata
> turns out to be NULL when it is read under lock later.
> 
> > In this case v9fs_fid_find() takes a local copy of the list head
> > pointer as `h` without taking a lock before.
> 
> It doesn't, it takes &dentry->d_fsdata so the address of d_fsdata before
> the lock, but that address cannot change here (another thread cannot
> change the address of the dentry) ...(continuing below)

Aaah right, I was missing the `&`, my bad!

> > Then v9fs_fid_find() takes the lock to run hlist_for_each_entry(), but at this
> > point `h` could already point at garbage.
> 
> ... so *h (in practice, head->first in hlist_for_each_entry()) will
> properly contain the first node of the list under lock: either NULL if
> we just cleared it (at which point the loop won't iterate anything), or
> a new list if other items have been added meanwhile.

Yeah, looks fine to me.

> I really think it's safe, but I do agree that it's hard to read, happy
> to move the `h = &dentry->d_fsdata` inside the lock if you prefer -- it
> compiles to the same code for me (x86_64/gcc 13.2.0)

No need, you can add my RB. Thanks for the clarification!

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>




