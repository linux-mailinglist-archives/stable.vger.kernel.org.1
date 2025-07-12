Return-Path: <stable+bounces-161704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7E2B02B08
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 15:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31F834A6B2A
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 13:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A089273D7F;
	Sat, 12 Jul 2025 13:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EPcgZFTY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318B0AD2D;
	Sat, 12 Jul 2025 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752327963; cv=none; b=gjFg8sB4e3lAUdGmsgFsJe7NQRQb4WTHPjqm5iCKrddPXLiJcV4HLZjO2E0hu2/Qnmm/XdIkt3xruK++4bHeeX8iy0FQMgCqkdsuai3aNBpszc+tjAe14FEbqckEJni5xxNmWYFq3edL8cHL+2jzoo/dXFQHRjE97vmyF87gG4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752327963; c=relaxed/simple;
	bh=+PHUAdBy2iBvjv7VPGFKGBpHvoF5uDaGK2uUoG/c9TY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJLMZtEpLmh9J8IhWH8syN1xomFby1X7CDJDOW/SorKE0XWrRbApQvP3BqWjowAVHRNqox6X/3gVoxswNZnJKhmv4Q213qisb10Sg38k4W+oX+PuI15qv9IvbSON+UDWmOW5mbYreJg4PjMti3tJd873LKltzy87MGt2Ja5Gp0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EPcgZFTY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2A3C4CEEF;
	Sat, 12 Jul 2025 13:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752327962;
	bh=+PHUAdBy2iBvjv7VPGFKGBpHvoF5uDaGK2uUoG/c9TY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EPcgZFTYP65MqcekfKKeUJ+GhZmYP8JSORlZJ61Im2TH7UZyo3sv5OYgj1jsUAzQe
	 4Zy9kczq+p9aQq/yucdsAsmIdymVloeDWD19fuVQLqgb9b0OtVdk2zIrtDBDHd5qVO
	 ub7YloUP2Xn9iHV6RqMkXs3HhaFGGqGCvFuHvZVc=
Date: Sat, 12 Jul 2025 15:46:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
	mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
	pvmohammedanees2003@gmail.com, akpm@linux-foundation.org,
	sashal@kernel.org, skhan@linuxfoundation.org,
	stable@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	syzbot+e0055ea09f1f5e6fabdd@syzkaller.appspotmail.com,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Changwei Ge <gechangwei@live.cn>, Gang He <ghe@suse.com>,
	Jun Piao <piaojun@huawei.com>
Subject: Re: [PATCH 5.15.y] ocfs2: fix deadlock in ocfs2_get_system_file_inode
Message-ID: <2025071245-snowsuit-pension-061d@gregkh>
References: <20250630083542.10121-1-pranav.tyagi03@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630083542.10121-1-pranav.tyagi03@gmail.com>

On Mon, Jun 30, 2025 at 02:05:42PM +0530, Pranav Tyagi wrote:
> From: Mohammed Anees <pvmohammedanees2003@gmail.com>
> 
> [ Upstream commit 7bf1823e010e8db2fb649c790bd1b449a75f52d8 ]
> 
> syzbot has found a possible deadlock in ocfs2_get_system_file_inode [1].
> 
> The scenario is depicted here,
> 
> 	CPU0					CPU1
> lock(&ocfs2_file_ip_alloc_sem_key);
>                                lock(&osb->system_file_mutex);
>                                lock(&ocfs2_file_ip_alloc_sem_key);
> lock(&osb->system_file_mutex);
> 
> The function calls which could lead to this are:
> 
> CPU0
> ocfs2_mknod - lock(&ocfs2_file_ip_alloc_sem_key);
> .
> .
> .
> ocfs2_get_system_file_inode - lock(&osb->system_file_mutex);
> 
> CPU1 -
> ocfs2_fill_super - lock(&osb->system_file_mutex);
> .
> .
> .
> ocfs2_read_virt_blocks - lock(&ocfs2_file_ip_alloc_sem_key);
> 
> This issue can be resolved by making the down_read -> down_read_try
> in the ocfs2_read_virt_blocks.
> 
> [1] https://syzkaller.appspot.com/bug?extid=e0055ea09f1f5e6fabdd
> 
> [ Backport to 5.15: context cleanly applied with no semantic changes.
> Build-tested. ]

We can't take a 5.15.y version, without it being in 6.1.y first, sorry
:(


