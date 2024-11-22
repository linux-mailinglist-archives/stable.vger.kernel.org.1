Return-Path: <stable+bounces-94567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DDA9D594E
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 07:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7AC1F234F1
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 06:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F0B166F31;
	Fri, 22 Nov 2024 06:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fv/cDF8b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3C6376F1;
	Fri, 22 Nov 2024 06:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732256384; cv=none; b=ebZwWxm+kSlRZLHANJmAZCz/mISj/B8AuckDlPDa8q24mhchLxlDzux2OGkKXAcXE3vbH6MEOxnxMMJtjKAZwwe8O1nQwxndX5IWuRf7aIAmNcYPAL4P6P1anSZko4ZUfkGNwQo8SY4sAXmF6+27mEJx27fRLz27ZzQxNU0eJoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732256384; c=relaxed/simple;
	bh=TV1/1YnZIDQZeSYDM7Yx4q9AWg2k3f1mpbgpQnwfFhg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=vFwKQdRcLhkqERkrHl4MVPO2WCg39NxITP0w3nCP/HFPlyZ8rf/Q9ZFekXfk+YhNEnu9SLauq/QqlDZP+V9iuIm2hkKo1XBUNzUe9bCch8Vm0+sVmbPNz7YM4om+ptkA5WLWk32HK3dKAeFTJstJIwJzJgdYGryEkcELGYVx7Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fv/cDF8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85949C4CECE;
	Fri, 22 Nov 2024 06:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1732256383;
	bh=TV1/1YnZIDQZeSYDM7Yx4q9AWg2k3f1mpbgpQnwfFhg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fv/cDF8b1qk4Ooq+bjOA6rpWocxQJ/+HNWvWlE7rSou39bShaui+b2ACVhxRlcUkd
	 O9pB6osQs7vGTYZIN6x5evS+u+g3zqgylmrNcOnfuIhHxZJ5Er1ddv8ftVxwksVFwJ
	 b738Ra0bFdv6RfByzPb1+AeEaFjRFnekNY4KbI7I=
Date: Thu, 21 Nov 2024 22:19:37 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, syzbot+3511625422f7aa637f0d@syzkaller.appspotmail.com,
 stable@vger.kernel.org, Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH v1] mm/mempolicy: fix migrate_to_node() assuming there
 is at least one VMA in a MM
Message-Id: <20241121221937.c41ee2b5e8534729e94fc104@linux-foundation.org>
In-Reply-To: <lguepu5d2szipdzjid5ccf5m56tdquuo47bzy7ohrjk7fh53q5@6z73dfwdbn4n>
References: <20241120201151.9518-1-david@redhat.com>
	<lguepu5d2szipdzjid5ccf5m56tdquuo47bzy7ohrjk7fh53q5@6z73dfwdbn4n>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Nov 2024 15:27:46 -0500 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:

> I hate the extra check because syzbot can cause this as this should
> basically never happen in real life, but it seems we have to add it.

So..

--- a/mm/mempolicy.c~mm-mempolicy-fix-migrate_to_node-assuming-there-is-at-least-one-vma-in-a-mm-fix
+++ a/mm/mempolicy.c
@@ -1080,7 +1080,7 @@ static long migrate_to_node(struct mm_st
 
 	mmap_read_lock(mm);
 	vma = find_vma(mm, 0);
-	if (!vma) {
+	if (unlikely(!vma)) {
 		mmap_read_unlock(mm);
 		return 0;
 	}
_

?

