Return-Path: <stable+bounces-100893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3349EE50B
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 12:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92DED18870B4
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 11:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874981F37CB;
	Thu, 12 Dec 2024 11:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IyDoTrHs"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0761E9B3E
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 11:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734003077; cv=none; b=RQtCZcxbjjG3PNLWuJ00iAPXpIGmrCg8QKhCCu0pgtOGlO2jpLjIvRy9s2lsHWzAGnE2e526gVGQnTvUQtO8Mg0nn9sepMonXHZwvyEu+tTC9E57dGzXC7G5BLeEMqlyr+4QNmhPnrKE4iLJidn7xva1qCYsM2qVCmSyhCbpyM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734003077; c=relaxed/simple;
	bh=MmgDZLSQtID9mT3Je11M6/sbF7asAJmRXqbPI1UO6rI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PWkOXwhta6O+fT0mv7+9BTGEse8JLMD/jU62s2Hszos8w/c1IeASjhjDQwNxBGeeU77Nhv/dXVUAwrlf68aMJGHfyDd8TXya303fvz48DHtwmGSNjUVkPR/WiGUBG+7iaQmw4K6wcdAAUSV2BHMqv/+o7fkSnxYl9+9YYYUbf6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IyDoTrHs; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385db79aafbso35112f8f.1
        for <stable@vger.kernel.org>; Thu, 12 Dec 2024 03:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734003073; x=1734607873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tzuw/zLX0WQJcc9n8LmQ2bz/aCPLkYLRBmSSAzg1cgo=;
        b=IyDoTrHsrf0h6HtfhprSDp4Zrlvt/vqqohyTXtw9ZdGTM0CZQmBY1GWLbL4mWkDyVc
         gJ+g6AeZuek27S9njxtQjm8NAs3/xCQyHnnukJcvkR1myzngGcQnPN5C0cwtTN1dk2T8
         LgfPvllkbixTxfsx/LOFepOl3qRMKwbVSXGsK9AjyXWb5ngP88awL5+tHBawg8d01JlG
         kgBm0yu0toryuBZZ3D69ReDE7XiZzwQFbzRrTHBIv5PEXk2HD0tT/Ked/QUs3W2cDdGo
         A8Aqp/09qjcrPV5nh90jn/H7QQKqAshC2FTDeXtmQjEvyU10/mqBKEOLz8fhFnWfbQeZ
         XkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734003073; x=1734607873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tzuw/zLX0WQJcc9n8LmQ2bz/aCPLkYLRBmSSAzg1cgo=;
        b=odoDOiXiIFUKH/BvsVCv5A+DpC71q9EvyMApnQg6hYaulGLdSOXhGgUCP+0BMre0SU
         eNMlO92jtJUBNsQ8PQ+hJgfVFe4yhhmkLXX0N8QT0XLvs8jM2IhdW5U1G4Epo0cdi8jH
         nYa3rSXgS3Os4ZbD5UxG1oAWF31WXQlaqKrKbaFlukFt4L8GloF+6I/tNBk9AZs2YK4M
         YEpojo81Q99m7LS9443N9S6umiWIjGghVWmKCxN4cJ91fxtwMQPS+1fkCAin+ZbxyECe
         a2VyCIM9AbT1wois7f8nfSJraT0hecNgXh2SS5+VbRqriwvghfgo3njuayReFSIPCpQx
         wFmA==
X-Forwarded-Encrypted: i=1; AJvYcCXsQKcliBOxSHXZKc/cY7BO5algncK9mMrbkJl3mpnf6fvwdQ9HP4AZBp5aTiqsEBopg4lIs8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSNcMI29nKN/vZubff1tv+TCOV1hYkI7pYebIdrRMAlnEUTlmg
	7esGw4X3ydAMjk/hY/QS6fMKBAPFTY6Vk6gft9HQ4wI2CgXKSjxV6NGNL5jd5TFgp7+XkLoM/e9
	p9No=
X-Gm-Gg: ASbGnctyq0yPupxa4mbha2hwjlhU4IzZWEqOHFIfnyYf1+vJIvM+g0+xUmLAdQNW5BV
	bqdbMGCjJprh7C/0/IVDxK1cs0eJgf2nESSwKzx6kTUNYmo3eOEu9oqcEP93Rg78YRja2suPMYH
	GQ4GKcFGXXFRRkhXjeRCFF5uOayF99vjEK+LS4t2saRjXypC8bfTLRnNeEk6Qls59Y/TnmTSnW6
	C4u/PnwYZE/tYGPCVL7D2mfO+/nr9nmuejgMKaZGgH5Y6CI+07OX4xkQzFzv1SVoxdQvwQ=
X-Google-Smtp-Source: AGHT+IGoamWVqwFBCte9IxOpQQ7DCMDYWPusRfzNwN0cUBdx1fxw1ns2IcyqhToSEVrLz61EtuVfdw==
X-Received: by 2002:a05:6000:1864:b0:385:ee59:44f3 with SMTP id ffacd0b85a97d-3864ce4afaemr2263141f8f.3.1734003073551;
        Thu, 12 Dec 2024 03:31:13 -0800 (PST)
Received: from localhost.localdomain ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725f9ff3909sm6285107b3a.77.2024.12.12.03.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 03:31:12 -0800 (PST)
From: Heming Zhao <heming.zhao@suse.com>
To: joseph.qi@linux.alibaba.com,
	gregkh@linuxfoundation.org
Cc: Heming Zhao <heming.zhao@suse.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	ocfs2-devel@lists.linux.dev
Subject: [PATCH] ocfs2: Revert "ocfs2: fix the la space leak when unmounting an ocfs2 volume"
Date: Thu, 12 Dec 2024 19:31:05 +0800
Message-ID: <20241212113107.9792-1-heming.zhao@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit dfe6c5692fb5 ("ocfs2: fix the la space leak when
unmounting an ocfs2 volume").

In commit dfe6c5692fb5, the commit log "This bug has existed since the
initial OCFS2 code." is wrong. The correct introduction commit is
30dd3478c3cd ("ocfs2: correctly use ocfs2_find_next_zero_bit()").

The influence of commit dfe6c5692fb5 is that it provides a correct
fix for the latest kernel. however, it shouldn't be pushed to stable
branches. Let's use this commit to revert all branches that include
dfe6c5692fb5 and use a new fix method to fix commit 30dd3478c3cd.

Fixes: dfe6c5692fb5 ("ocfs2: fix the la space leak when unmounting an ocfs2 volume")
Signed-off-by: Heming Zhao <heming.zhao@suse.com>
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


