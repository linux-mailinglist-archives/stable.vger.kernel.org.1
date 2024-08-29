Return-Path: <stable+bounces-71483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AFF9643F0
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 14:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76A461F24BF9
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 12:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1124918FC80;
	Thu, 29 Aug 2024 12:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLHxgkwS"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C0A16D300
	for <stable@vger.kernel.org>; Thu, 29 Aug 2024 12:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724933322; cv=none; b=q3r1UBFXJ05I0NC9XZf7rLzYJjv5/2XPa2sPGfQ9Df0sx8PAAXNeIsPBFSCzn5vNkiIqBfs5o0rtI1C4vzXG32nqJmxEpHH0OR2lw+USGaTvWF4Ysp5IO2Xqs6UwwPk4a+XoDEm/0TLpCuJ1fH8xB9OIYLg6tdDsZtaqoyq9J9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724933322; c=relaxed/simple;
	bh=KtYpPUXw+zEnbjLpy8nw2gc8bTe4ABd85XtQXUrHDw4=;
	h=Message-ID:Date:MIME-Version:Subject:References:To:Cc:From:
	 In-Reply-To:Content-Type; b=kOmnYyWWENODovdJd+P8ubx7lK/YDn1lakMUz3uN2mSRNK0oY6VZKzB5TO0yhc3xy6n5uSQWagLqkWiUvUcLLTXB0oltzItdje28hx+/sTWH8XkMddoP1uMr5InlV9nfTimd2cJNpOZIVhTaSG/NBJx98sl0vhpAZUDoaTKvzkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLHxgkwS; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f3fea6a0a9so5415011fa.0
        for <stable@vger.kernel.org>; Thu, 29 Aug 2024 05:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724933319; x=1725538119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:to:content-language
         :references:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zhm0ZYuyloZkq+EYQ560MJVmdDqagRw+L7k478p9DZ8=;
        b=HLHxgkwSgYTCefbOrhZv74OreTrf/RKOC0/DL+XsLYeCV02vt/PBsy6l9n59R9m18c
         gw7dn4RBGwAqhusvFmDb42PtCvuJWa1gvlMDRdEUi5O86nnev1k2h1cFU8xqreeCAVW4
         +vhWommHTdGv2gvBri8lhheFgw5gf9AJIEeUc8jsz5A+mXtw9lVA/yB/qrCvjrRdYItq
         kw35OSlZwhGqHFTuOW0yLvEqHFT02yDLDP17an/TMpEMTjG0oWZewL1IxohzeNn0KAok
         Txr3bWmyY9y6SLfXwGRjSNzGaH6sq3A7zBnBjWL6V1Hlqcb/cEGKICXquApGxqPpLOgT
         Eiaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724933319; x=1725538119;
        h=content-transfer-encoding:in-reply-to:from:cc:to:content-language
         :references:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zhm0ZYuyloZkq+EYQ560MJVmdDqagRw+L7k478p9DZ8=;
        b=rxN9Ix2iLD45HN+tQhl8U4iQml0gTqh4WPZB0gLzgEEttqUHzSv8OE24tcTSUhZwMh
         PwXOn/MRrkkUCVKoOAUlMXFHkNNix6JaduJeupVB4e50MCYbe0PYqrmSo8pn+e3S+Wol
         3Hhc1jes0/fiW0OZbIPZy5v7x5tMvAoeI1k3Hd31ecG1UbIUbMIZ0iYVP8HskxFmrR7k
         3jWH4YS8H9jeQprruP1nugFpOzPAyL8AZ5yjtNZ6nH9uJfaZmbQtvpPGW7nHw5H6bXOJ
         YD0MNmHvDIy5Nxzd4RWJOswqtSLr9da8KmmXMlklGZnn7ZUJN5crl1ehZe1LZxwj/maa
         UCZQ==
X-Gm-Message-State: AOJu0YxiSy9tFsNIYLuPHMBKQFiprpOZVi+bUthnKhxjokf0ApKqdYqh
	WjkpYlHPJxAbGwseilcjCe2p9wFHZtQ8Ronun+ybU6ptkxGpn7zB6egMcgpL
X-Google-Smtp-Source: AGHT+IHmZ8lgRx+m4mvwhvX0IT6JBNEj2X72kFDeILgDTzl6kRXsKo8zG1ZGrOpMgvCN+WWTMiUGqg==
X-Received: by 2002:a2e:f01:0:b0:2f5:29f:43d5 with SMTP id 38308e7fff4ca-2f6168b008fmr4686071fa.24.1724933318582;
        Thu, 29 Aug 2024 05:08:38 -0700 (PDT)
Received: from [130.235.83.196] (nieman.control.lth.se. [130.235.83.196])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f614f38748sm1523901fa.61.2024.08.29.05.08.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 05:08:38 -0700 (PDT)
Message-ID: <25fab507-bf7f-446f-9ea1-cec08e9ebf1d@gmail.com>
Date: Thu, 29 Aug 2024 14:08:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Fwd: [PATCH 3/9] xfs: xfs_finobt_count_blocks() walks the wrong btree
References: <172437083802.56860.3620518618047728107.stgit@frogsfrogsfrogs>
Content-Language: en-US
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
 Dave Chinner <dchinner@redhat.com>
From: Anders Blomdell <anders.blomdell@gmail.com>
In-Reply-To: <172437083802.56860.3620518618047728107.stgit@frogsfrogsfrogs>
X-Forwarded-Message-Id: <172437083802.56860.3620518618047728107.stgit@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dave forgot to mark the original patch for stable, so after consulting with Dave, here it comes

@Greg: you might want to add the patch to all versions that received 14dd46cf31f4  ("xfs: split xfs_inobt_init_cursor")
(which I think is v6.9 and v6.10)

/Anders



-------- Forwarded Message --------
Subject: [PATCH 3/9] xfs: xfs_finobt_count_blocks() walks the wrong btree
Date: Thu, 22 Aug 2024 16:59:33 -0700
From: Darrick J. Wong <djwong@kernel.org>
To: djwong@kernel.org
CC: Anders Blomdell <anders.blomdell@gmail.com>, Dave Chinner <dchinner@redhat.com>, Christoph Hellwig <hch@lst.de>, hch@lst.de, linux-xfs@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

As a result of the factoring in commit 14dd46cf31f4 ("xfs: split
xfs_inobt_init_cursor"), mount started taking a long time on a
user's filesystem.  For Anders, this made mount times regress from
under a second to over 15 minutes for a filesystem with only 30
million inodes in it.

Anders bisected it down to the above commit, but even then the bug
was not obvious. In this commit, over 20 calls to
xfs_inobt_init_cursor() were modified, and some we modified to call
a new function named xfs_finobt_init_cursor().

If that takes you a moment to reread those function names to see
what the rename was, then you have realised why this bug wasn't
spotted during review. And it wasn't spotted on inspection even
after the bisect pointed at this commit - a single missing "f" isn't
the easiest thing for a human eye to notice....

The result is that xfs_finobt_count_blocks() now incorrectly calls
xfs_inobt_init_cursor() so it is now walking the inobt instead of
the finobt. Hence when there are lots of allocated inodes in a
filesystem, mount takes a -long- time run because it now walks a
massive allocated inode btrees instead of the small, nearly empty
free inode btrees. It also means all the finobt space reservations
are wrong, so mount could potentially given ENOSPC on kernel
upgrade.

In hindsight, commit 14dd46cf31f4 should have been two commits - the
first to convert the finobt callers to the new API, the second to
modify the xfs_inobt_init_cursor() API for the inobt callers. That
would have made the bug very obvious during review.

Fixes: 14dd46cf31f4 ("xfs: split xfs_inobt_init_cursor")
Reported-by: Anders Blomdell <anders.blomdell@gmail.com>
Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
  fs/xfs/libxfs/xfs_ialloc_btree.c |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/fs/xfs/libxfs/xfs_ialloc_btree.c b/fs/xfs/libxfs/xfs_ialloc_btree.c
index 496e2f72a85b9..797d5b5f7b725 100644
--- a/fs/xfs/libxfs/xfs_ialloc_btree.c
+++ b/fs/xfs/libxfs/xfs_ialloc_btree.c
@@ -749,7 +749,7 @@ xfs_finobt_count_blocks(
  	if (error)
  		return error;
  
-	cur = xfs_inobt_init_cursor(pag, tp, agbp);
+	cur = xfs_finobt_init_cursor(pag, tp, agbp);
  	error = xfs_btree_count_blocks(cur, tree_blocks);
  	xfs_btree_del_cursor(cur, error);
  	xfs_trans_brelse(tp, agbp);


