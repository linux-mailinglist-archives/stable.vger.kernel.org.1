Return-Path: <stable+bounces-98220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A599E3223
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 04:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 614C2161762
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 03:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF41156F3A;
	Wed,  4 Dec 2024 03:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HrdDNHTD"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEAF1531C1
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 03:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733283180; cv=none; b=HOGyWL1asWzgT5dg7GgDmsqeKjP22YDwRKjNNUmUfGUvT1u2p61ushYKr9A7VB6LMOYArj3JfHbUBgIvybk+ectM8ov3CajwbZy5cck7iWEBaTNluHVcko89cf7p3kkOMi3Rjl8wb8cV4yYJH4bOOkBsSHQG+dOhidZfDcOtfR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733283180; c=relaxed/simple;
	bh=HETMPyYFonTIlUEtDkB4W+NGpx0pChnBvtqpUMwbz5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZbbIqEfQXrqGpgK2rlV2gldkoYj+9ZV9ai9f9AjqgFWffTnJ9xdYtLYIcNsPJRLfl76nACQlKbMxcEVnRy6dSfAwurgXl89tzVBDsYJ+ng4n+QOv0lxbT0s0TrhXVqIv6VmNswjRXP6C9PWRtanaufuMcu8vKafCZUuPnxtQQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HrdDNHTD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4349fe119a8so7379795e9.3
        for <stable@vger.kernel.org>; Tue, 03 Dec 2024 19:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733283175; x=1733887975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyQZbBp455IiiS0cimMqLKVcykFWRydlh8NnN31mrV4=;
        b=HrdDNHTD9DwHwb7xvHvSwiMY3SSdcxaT0xZewai1RP+/nETanu6wWDUD8Y3WAvw+5z
         +F6TGbIdPfQP+wR0rFLdn8DjHkhBbl2W6bZge9gfLp2h9oPOiuigEsD2YDgEOZg3s4H7
         5ucvKFvoXV4dsC/I4lqzUU40avdJrgfeXvGNDof2SfY3QeMZhVVY7tBTo43huu53cKZq
         RTL34c49Z8guY++MOwSHcXbTtXI0kATRCLvwNIpXMSmDyBidM/ae2OXgAesJWeZQWYMn
         SU9TG0xfbyvC7R6wThyC7JRWVFLXpkaUH2Z9kNnrNcXAj4feWFc+V3xutDR5SwACYzuB
         53ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733283175; x=1733887975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IyQZbBp455IiiS0cimMqLKVcykFWRydlh8NnN31mrV4=;
        b=X1erqH90vj9PaqCTyAJd95A4BFW4XwkHbReTSLVv8UPyb6iD6ZzPkgPYT9OO+R1Tug
         4VIjE2XL3YC7nEGaKAoup4kO60+0TO3wnLnNnX7/przM3S2k18u9o++AzoSnukadMcf/
         EB9bkspnaQkzbroAdLQsv1V53fHU4XOYGb6dFVdP9wabuE9ZcEHk8GFtlsqLXPdYkqp3
         30gJm5q00868W3NtfqSw+zjoTRx+2msL5q/2KbkqCH9/tpmGTUDRGFydn8JiC8osxgiy
         jc45gG+w1nUqKYpuIn7yjHlsRzth/UlhtIqFl+WsiViN160JXT6gnWQE6hLIrrr1/e/N
         dVWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDdSOD+HLDZqx8PZlT24sqC1aZ+KwrLS8nHtTXOetByBh+iA2taCjKgOIEniXcbfiiPQghaX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU2lAYkaF4w+sgobLN3N1wM9EQbZ9c90cqsjh34+7SbxuCSWiR
	DsHHlJ+PnH7bD2DaEYeDZ9q1QwJt37iOmMMjgGc3Lit+0GhHxktu6VY6mZP8DF8=
X-Gm-Gg: ASbGncuLZi7aJrrHagd5woC0eX/fImWO0ZI8EJH8N9v8/9T78MijIZFaiH8yfvkNCxe
	NVY9qntKNmWO5W7ahyShxi3jIMxknAZ4LBcMcOHAsPj5LCNNp8rJN2w2FszbyPzj5U/KTBO2PTL
	B6uctFxEGGQADYoOZebNv3whBUst/eIs3bwE0Q7Uwzrj7Rm/fl7OBEg9j2WSrHk6Gnj41p9J6eF
	qDivjUWSaOAFAKvSYZySTvj4eFbO1d2C/PwIeVBr7kKpFp2XBzc1554ubOB4g==
X-Google-Smtp-Source: AGHT+IE/jHB53rXLi5u7lvRJEF+CPq4Zu3rqIEuQoyRi8fGpj8biZzILxPOqXkFg+fFvWqVlPTnhJQ==
X-Received: by 2002:a5d:6dae:0:b0:385:e10a:4d98 with SMTP id ffacd0b85a97d-385fd3cfcb3mr1524139f8f.8.1733283175560;
        Tue, 03 Dec 2024 19:32:55 -0800 (PST)
Received: from localhost.localdomain ([114.254.72.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215a04dc249sm37476025ad.203.2024.12.03.19.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 19:32:54 -0800 (PST)
From: Heming Zhao <heming.zhao@suse.com>
To: joseph.qi@linux.alibaba.com,
	ocfs2-devel@lists.linux.dev
Cc: Heming Zhao <heming.zhao@suse.com>,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	gregkh@linuxfoundation.org,
	Heming Zhao <heing.zhao@suse.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] ocfs2: Revert "ocfs2: fix the la space leak when unmounting an ocfs2 volume"
Date: Wed,  4 Dec 2024 11:32:39 +0800
Message-ID: <20241204033243.8273-2-heming.zhao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204033243.8273-1-heming.zhao@suse.com>
References: <20241204033243.8273-1-heming.zhao@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit dfe6c5692fb5 ("ocfs2: fix the la space leak when
unmounting an ocfs2 volume").

In commit dfe6c5692fb5, the commit log stating "This bug has existed
since the initial OCFS2 code." is incorrect. The correct introduction
commit is 30dd3478c3cd ("ocfs2: correctly use ocfs2_find_next_zero_bit()").

Fixes: dfe6c5692fb5 ("ocfs2: fix the la space leak when unmounting an ocfs2 volume")
Signed-off-by: Heming Zhao <heing.zhao@suse.com>
Cc: <stable@vger.kernel.org>
---
 fs/ocfs2/localalloc.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/fs/ocfs2/localalloc.c b/fs/ocfs2/localalloc.c
index 8ac42ea81a17..5df34561c551 100644
--- a/fs/ocfs2/localalloc.c
+++ b/fs/ocfs2/localalloc.c
@@ -1002,25 +1002,6 @@ static int ocfs2_sync_local_to_main(struct ocfs2_super *osb,
 		start = bit_off + 1;
 	}
 
-	/* clear the contiguous bits until the end boundary */
-	if (count) {
-		blkno = la_start_blk +
-			ocfs2_clusters_to_blocks(osb->sb,
-					start - count);
-
-		trace_ocfs2_sync_local_to_main_free(
-				count, start - count,
-				(unsigned long long)la_start_blk,
-				(unsigned long long)blkno);
-
-		status = ocfs2_release_clusters(handle,
-				main_bm_inode,
-				main_bm_bh, blkno,
-				count);
-		if (status < 0)
-			mlog_errno(status);
-	}
-
 bail:
 	if (status)
 		mlog_errno(status);
-- 
2.43.0


