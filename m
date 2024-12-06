Return-Path: <stable+bounces-99978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE1A9E777D
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 18:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04F8A16B8F7
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 17:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CB5220697;
	Fri,  6 Dec 2024 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyLhdTR9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C747B220687
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733506474; cv=none; b=PXJzh/0AYw9wTngZ4eYin/jBzrxYIK5JbI138sUjxWqMjfIVEzrgGpifLFAiMac59vQf6h9lMHsfGyMrKtF+X/DgiO+OMwse28ivGIzPnatWFfq8viG/1dSelFpGFnRlefWdWtq4texWI04syPciSI1RMLrD0HghMvV7ujZmXlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733506474; c=relaxed/simple;
	bh=8voKjp/xNA/T8RI3tFbbanTvPr1nyk6fhDvWR4d4/HU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lrE50wfUvP2JoKSE3ZXe1wOD030PlHV5WyGbe2IHUwHklMQAXbNvDYIH+WZv4KaYXfIqTSuHZTq0s4rlpVXa5wcJ2uYZGEDOlEpIwoQZDKa8OAROWAZGvR0RmdSeOLzVXxyBBiVnzoOn0mf2gS+6d7gxcMjTASnP+Xk142lAl94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyLhdTR9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25383C4CEDC;
	Fri,  6 Dec 2024 17:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733506474;
	bh=8voKjp/xNA/T8RI3tFbbanTvPr1nyk6fhDvWR4d4/HU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eyLhdTR99hNG26A9k4gxu7P2WE/qAN9ejlROtD8JwR4FFNebf6pkL4LhwP0VOxEA+
	 UnfLF7T5ZPsnlVVc13RAX2FVuRRZgIRXiCuz4I4zDLKEL/FHe/LV+3xFW9+AwDvcMv
	 hlJNgpNHMbmY7t+hlBPlCaaWKC8+WSNzrMuHuXBBtJDZTQ+K+0qVT+y5v6eGbyAGBg
	 w79D0y7T6EqgTwlQ0ocYxtwH6MLp19OSFdy5uoy3EM4rsxPuwNbioDm444YhlsM6Ty
	 cv7IwgMNg1FlCKIfnz0+At6YAIj9bz7Y3UnnLaBmNi2yQ5kHMBuDgSZqX98+4L3nPP
	 jFqYeXBS8uiRQ==
From: SeongJae Park <sj@kernel.org>
To: gregkh@linuxfoundation.org
Cc: SeongJae Park <sj@kernel.org>,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mm/damon/vaddr: fix issue in damon_va_evenly_split_region()" failed to apply to 6.6-stable tree
Date: Fri,  6 Dec 2024 09:34:26 -0800
Message-Id: <20241206173426.75223-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2024120622-postcard-cringe-b986@gregkh>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 06 Dec 2024 11:16:22 +0100 <gregkh@linuxfoundation.org> wrote:

> 
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> git checkout FETCH_HEAD
> git cherry-pick -x f3c7a1ede435e2e45177d7a490a85fb0a0ec96d1
> # <resolve conflicts, build, test, etc.>

I tried this on the latest linux-6.6.y (v6.6.63), and the cherry-pick didn't
reproduce the conflict as below.

    $ git checkout stable/linux-6.6.y
    [...]
    HEAD is now at bff3e13adb72 Linux 6.6.63
    damian@damian:~/linux$ git cherry-pick -x f3c7a1ede435e2e45177d7a490a85fb0a0ec96d1
    Auto-merging mm/damon/vaddr-test.h
    Auto-merging mm/damon/vaddr.c
    [detached HEAD 072adde8b33a] mm/damon/vaddr: fix issue in damon_va_evenly_split_region()
     Author: Zheng Yejian <zhengyejian@huaweicloud.com>
     Date: Tue Oct 22 16:39:26 2024 +0800
     2 files changed, 3 insertions(+), 2 deletions(-)

mm/damon/tests/vaddr-kunit.h was originally mm/damon/vaddr-test.h, and the path
conversion patch is not on the linux-6.6.y tree.  In my case, seems git was
able to know the path change and finish cherry-pick successfully was maybe it
didn't work on your setup for some reason?

Anyway, I'll post the successfully cherry-picked one as a reply to this soon.


Thanks,
SJ

