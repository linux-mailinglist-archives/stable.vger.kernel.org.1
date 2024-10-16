Return-Path: <stable+bounces-86549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3543F9A15B9
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 00:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70141F22D2A
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 22:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A651D45E5;
	Wed, 16 Oct 2024 22:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DEEX4qDz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC421D4358;
	Wed, 16 Oct 2024 22:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729116997; cv=none; b=CLG20YiuMJjHUdHvlOAICiWGjT0IQ2YR/kSuzKIRaQerpybSnBmQQE/Y/wS5yVPnTD6D8ecc4Bj+FtLbFcl8ooQBSNemrP15FQM/qM4YEZ56ter19WHfksyfszEdlq1vOSUK7yuEBFW0qruyBpdW6JGZsF5m4r+AXJJqAk0bMsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729116997; c=relaxed/simple;
	bh=+dQNULmA762meA9oyQtjDYVR17GgdfXHjF5FrGTJfpU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HUIojr3ieeed74aZsp2EEk2YvfOjH/myjrIQlqxLJCW5ML52WF/2haUbQJ8BguMoB2wnyrUtl1jtBLCfsL7MuEVyL/NWQMx1dUwp97t45u7HruKgO6g4n4l4DCXoC6V+cIjVRtKlVZtNuEIarsOFISSbKhII72lcqSNPvr8kqak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DEEX4qDz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E446EC4CED1;
	Wed, 16 Oct 2024 22:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729116997;
	bh=+dQNULmA762meA9oyQtjDYVR17GgdfXHjF5FrGTJfpU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DEEX4qDz+fc+kgDAW7/JviDpIk5mPt0fAGVP7azHnNTmmjo2ZkJCS8asv7W1wJrSa
	 CZrpUDEmwtcxLKXenhRekY9I+eFJnFpbL6DuXyXzhisRzcpkhBwumlLbNmQaWhtX8J
	 schw36UVg2Hci5+e1wHOgoCOdDw0egQCLdeQeWFY=
Date: Wed, 16 Oct 2024 15:16:36 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: hughd@google.com, yuzhao@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH RESEND] mm: shmem: fix data-race in shmem_getattr()
Message-Id: <20241016151636.7e2184ca7467a0f8f90d940c@linux-foundation.org>
In-Reply-To: <CAO9qdTG9wxBSct-rrgG_DevaLZgy4AFirKu+3uu=HOPD1-PRBg@mail.gmail.com>
References: <20240922080838.15184-1-aha310510@gmail.com>
	<CAO9qdTG9wxBSct-rrgG_DevaLZgy4AFirKu+3uu=HOPD1-PRBg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Oct 2024 23:12:43 +0900 Jeongjun Park <aha310510@gmail.com> wrote:

> > Therefore, when calling generic_fillattr() from shmem_getattr(), it is
> > appropriate to protect the inode using inode_lock_shared() and
> > inode_unlock_shared() to prevent data-race.
> >
> 
> Cc: stable@vger.kernel.org
> 
> I think this patch should be applied from next rc version and also stable
> version. When calling generic_fillattr(), if you don't hold read lock,
> data-race will occur in inode member variables, which can cause unexpected
> behavior. This problem is also present in several stable versions, so I think
> it should be fixed as soon as possible.

OK, thanks, I added the cc:stable amd moved this into the mm-hotfixes
pile for a 6.12-rcX merge.


