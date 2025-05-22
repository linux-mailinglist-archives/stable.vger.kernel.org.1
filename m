Return-Path: <stable+bounces-146007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB70AC0240
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F44B7B4768
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0774D2B9B7;
	Thu, 22 May 2025 02:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fpp882hy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBD7539A
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879692; cv=none; b=HGDZPWw2SHfl1r3Ii7tpnkxNvduA8NbWCnziWHDyKdNhVlsUB6g0l3n9Og05L9s0Tu9OZcu4jFCIWeQW/O/e+YiXiGuNnftKCE6mmorGRsrbQtR391XaFf9bydCYIozdtlMKbtdB4HWkJsKG9xihT9KnsrNzxOVCy7M34c2Tmzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879692; c=relaxed/simple;
	bh=dxnlt227wQyfU7zKWdXKRPGkDF0RM6xkocI6Cjz0Jeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UdvF34KflYHRysY4LjKVyPjSj+I5xaHdpnlWrSZAQNKAJBN2z2on2xeUGbAUQ2b44QxVgs+f03q8jB06kCfq0BNvIYgtJfawLUzTKopHEPRPUxTFVNrZ0edyTGocERj5/QCwoxz1jHSKPkiXEP3iRhpDS3X/XkbQt7lN5/stejY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fpp882hy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E01C4CEE4;
	Thu, 22 May 2025 02:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879692;
	bh=dxnlt227wQyfU7zKWdXKRPGkDF0RM6xkocI6Cjz0Jeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fpp882hyqTsOUxeMeaR0qZvYAh6cyTQRjOMespWYpWPGai++KPKyOmu6RvBvTW1+h
	 9MI6cMbC96/CDgtI9Id9J+u20CDnfHo4jOhOvOWUib9qXbD1dEXaVNwGTaSIcxzL4z
	 u+/kf3vFzJba2qvbulLtI9QC5e8Ay/98BPx3+zW0GvCTrXaLpDLtYEitrf5nvx6f/C
	 ohxnFmRAdw6GI/HgK2fa3ZAalMn7qy49BLbo+ZBXw6Btjz4KgW1wylq3Cit5v3rfxM
	 n3wxsvFlAr/rdX9UXxP5HCWpkfhu2ubGffF78C5geeRUl4J+WyzJ8YFSfeKBMb7yJf
	 zgL9T8RaBvVmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	lee@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.6 23/26] af_unix: Don't access successor in unix_del_edges() during GC.
Date: Wed, 21 May 2025 22:08:08 -0400
Message-Id: <20250521183031-901e552f135806b8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521144803.2050504-24-lee@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
ℹ️ This is part 23/26 of a series
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: 1af2dface5d286dd1f2f3405a0d6fa9f2c8fb998

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Found fixes commits:
7172dc93d621 af_unix: Add dead flag to struct scm_fp_list.

Note: The patch differs from the upstream commit:
---
1:  1af2dface5d28 ! 1:  9af3ce6ae17fc af_unix: Don't access successor in unix_del_edges() during GC.
    @@ Metadata
      ## Commit message ##
         af_unix: Don't access successor in unix_del_edges() during GC.
     
    +    [ Upstream commit 1af2dface5d286dd1f2f3405a0d6fa9f2c8fb998 ]
    +
         syzbot reported use-after-free in unix_del_edges().  [0]
     
         What the repro does is basically repeat the following quickly.
    @@ Commit message
         Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
         Link: https://lore.kernel.org/r/20240419235102.31707-1-kuniyu@amazon.com
         Signed-off-by: Paolo Abeni <pabeni@redhat.com>
    +    (cherry picked from commit 1af2dface5d286dd1f2f3405a0d6fa9f2c8fb998)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## net/unix/garbage.c ##
     @@ net/unix/garbage.c: static void unix_add_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

