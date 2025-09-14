Return-Path: <stable+bounces-179540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CDCB56436
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 03:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9481D2025FE
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 01:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D6422B8CB;
	Sun, 14 Sep 2025 01:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1uek+Au"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BF81F5842;
	Sun, 14 Sep 2025 01:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757814943; cv=none; b=mAZZx/hiPGy/D1BGFQxLQrVHcyFT6qNdcfbknCL3QYEcMZMTt/wO7LV4ebzo0j+W3DcQVHdmi5oGZ5UT638QSCU2y+oCEx+GKpAGrRYWMr27uaScEZ0pa2zK8EA4BQg+pEGWukTb0fD4AHnZLPixRDNkf5ERVX3X+tqalDD50pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757814943; c=relaxed/simple;
	bh=4vfgufVuTr4BGRwNV/g9keD6isG3EZFi5Y8bQKq/IzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TorzVH1uCvsCjN+JCqLpOOd159hLbMXV5GjClyoxPNbv0mdo+lKZJOBOO0M4H7PxpT2VRfwU2Ku8VT7p5ILGvdC+anUbdlq0tTJmcRHJoAWFAeRtzpOdfmPrPgZSLv3ErUxd4n/7qHKta3qwc9Ruy+vpN3cDb+W5iGw60fWQ5RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1uek+Au; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71B2C4CEEB;
	Sun, 14 Sep 2025 01:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757814943;
	bh=4vfgufVuTr4BGRwNV/g9keD6isG3EZFi5Y8bQKq/IzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K1uek+AuPFiOefLjuLedg7iDzhW5a3d95AN1ynzyzIVzvTc/tQ9ooO6UAFT/6G34N
	 AcvFxNBTs+BaNGo8Ys2aWbJKilgDW0klSxSTT+Zvbxe7Rq6AViYXCm3QLBUMzj31Pb
	 edUX2lQxuZlDaN+qTeGi5EnXeFXdnksIen+yNadWLiJffu0mfYDdyXMDwHpsWkOxwM
	 q8pwDp2u3XCLK0zcy5UtnLj+Ct0BzffuqkjLbwVfheAjXdOg0O2g4w77mYG9fqb9zL
	 N7uV5tu3vC38xFPyqFuUMst43cL/m8gWyOjZNW25nzgH02BwY4JgbLnJCMZ9UP3m8E
	 loPNnSpIrqTdA==
From: SeongJae Park <sj@kernel.org>
To: gregkh@linuxfoundation.org
Cc: SeongJae Park <sj@kernel.org>,
	ekffu200098@gmail.com,
	akpm@linux-foundation.org,
	stable@vger.kernel.org,
	damon@lists.linux.dev
Subject: Re: FAILED: patch "[PATCH] mm/damon/core: set quota->charged_from to jiffies at first" failed to apply to 5.15-stable tree
Date: Sat, 13 Sep 2025 18:55:39 -0700
Message-Id: <20250914015539.56587-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025091357-stapling-walrus-d0f7@gregkh>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

On Sat, 13 Sep 2025 14:25:57 +0200 <gregkh@linuxfoundation.org> wrote:

> 
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> git checkout FETCH_HEAD
> git cherry-pick -x ce652aac9c90a96c6536681d17518efb1f660fb8
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025091357-stapling-walrus-d0f7@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> >From ce652aac9c90a96c6536681d17518efb1f660fb8 Mon Sep 17 00:00:00 2001
> From: Sang-Heon Jeon <ekffu200098@gmail.com>
> Date: Fri, 22 Aug 2025 11:50:57 +0900
> Subject: [PATCH] mm/damon/core: set quota->charged_from to jiffies at first
>  charge window
[...]
> Link: https://lkml.kernel.org/r/20250822025057.1740854-1-ekffu200098@gmail.com
> Fixes: 2b8a248d5873 ("mm/damon/schemes: implement size quota for schemes application speed control") # 5.16

The broken commit was introduced from 5.16, so I don't think this commit need
to be cherry-picked on 5.15.y.  Please let me knwo if I'm missing something or
there is anything I can help.


Thanks,
SJ

[...]

