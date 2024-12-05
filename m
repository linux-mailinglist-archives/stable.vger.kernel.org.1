Return-Path: <stable+bounces-98780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B164C9E52E8
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 11:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF69167594
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 10:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCC71DB92E;
	Thu,  5 Dec 2024 10:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GZ+HBnpa"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A274F1D8A10
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 10:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395729; cv=none; b=THWj68vx2bK4cYIo+5kOgocHwV9NcPuztIELf6w1d6p3EyQajReMeI+9KXEl+gSmv/YAJ7LbG9esT5KX+I5Ti27bzaHdMh0mAvgAxFtbpXKPHPFRDATjNk96HNAGfuMVoW7RWCSe9oLdhyF3I15SlZ4ASvrt9bKlgIydkhSfkmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395729; c=relaxed/simple;
	bh=MmgDZLSQtID9mT3Je11M6/sbF7asAJmRXqbPI1UO6rI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a8z7siDSRM/cbW2pInS5YyFHQ8Hbiy6Ys9X6UXEdokl0ex1EdIRFDnFsZ6M9xotHozbALsnXha4edW7q1oJEPQ6kkSHdTZbM7bc+vAzbIsaFLqMi1xgmofQm3srpNc0jE0mQMBQ96mdEP8rqPWvr8kN6yvjUG1tMzBJha8IKWW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GZ+HBnpa; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385dc85496dso90187f8f.3
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 02:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733395724; x=1734000524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tzuw/zLX0WQJcc9n8LmQ2bz/aCPLkYLRBmSSAzg1cgo=;
        b=GZ+HBnpa4jJwfCeADhVf9huYax/jNmb80AIsTEwVDkdMLnWXpDQZwXET+vDrSvU8oq
         5C6KVzEDgWhPqj4LKey6a26A5UPwwGhrKGuFaJKoMlNWFZ7QH4X5jzU1lES2crpftJuE
         8NQv5VdT+Pv61RgIkNwyc89OOhin9ltZGaOsVb8ee8U/G7Z8uSTO2SgatJqvnNZbPAlA
         M8B3qjnezDi9sUOrx/K2ugfkBeh4FD0u5w/wFplKL0GIBsaHudg9LnaCQUbERhzn2P29
         vDlWE8Ha5IvWr6taG1V1SlAnSNRQDqK2V1LE1BJOFzGEMarZCKSSc6WAA4ZxKVA2Wkh5
         VKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733395724; x=1734000524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tzuw/zLX0WQJcc9n8LmQ2bz/aCPLkYLRBmSSAzg1cgo=;
        b=MVROvbFE/+KD0KBSAOCU8C7/njCUAaZuVlzykrbfn/7oegZDC0f2u2OjVu/jKuvG5p
         Aqt57B/fLpUxAhgC3U8+E9qoj4SkD8YjBLqLlqNzZ2n865QbzC7I4xiupOBKy0qqR9FE
         fEDZVZDqlVAFQBJ7c5ekmOCeoL8IPhP0KMYO6DjpDwGCiMwg+IPTGCrcCW+c8C3WpJqU
         1KLEqKd/qyZ2i3m+wtJR1dsfIdDTBCOyvlmGEEShMVJBkNH4uFoE13SUPUlxcn7FNV7A
         7BavZ3Hz6KnRXxE/t86UVwrgz2e92dz6yMG+1QuI3J/2q964MPm1o3UrtA7GGowHd9vg
         eA5g==
X-Forwarded-Encrypted: i=1; AJvYcCUSxSzw/87eDR3ZZKxyTFOJoGGn279Xnv7VMMD7tpbdmH6q2N00i/AtTxtYFzk1ZbB4Pd9u3W8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM6Fko5fi37fzB1nYjRukgDXXwVwXrBKnZUfnMQd7nm9GA7t6D
	eWpiE1Qe56l1kSs3ICk+Ld81ag6eTzNmFk76MqSV4uOTMVWwb9re1s/6ipd0hAA=
X-Gm-Gg: ASbGnctfEn+jxx7gqp9g+t7UFPTQu6F2R0XAWHkgh/OfG27v60o+nvRqHUaXvO9I/Yc
	K8LU1BGEzZtlIZCXEVP1QksEkcPsgR/oNyabm2oBmBHuXDjOvsJZ2dGpsdZmpexfS8NDH83ft6/
	urCplnkDBnQrrQctBj2c8MjtQ45/KmYrUPPfo8yicGsmxKk1HXDR31miMLz0Um0wV8hYwQMP5bn
	Vjhdlo5a2CYspDk+hsYqYTPy9UQ27mXpbkfHde4dZ4op3I/aIcura59iCGVpofy
X-Google-Smtp-Source: AGHT+IGOivLgwrbcfAxI55SOIo7GYAysOTEQKhOrkf3R1BczYe6WFuJe7SnaKy0jMJc7mQC4v9gOSA==
X-Received: by 2002:a5d:5988:0:b0:385:e30a:e0ee with SMTP id ffacd0b85a97d-385fd3f26c2mr3542670f8f.8.1733395723996;
        Thu, 05 Dec 2024 02:48:43 -0800 (PST)
Received: from localhost.localdomain ([114.254.73.201])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef4600d14fsm1081629a91.45.2024.12.05.02.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 02:48:43 -0800 (PST)
From: Heming Zhao <heming.zhao@suse.com>
To: joseph.qi@linux.alibaba.com,
	ocfs2-devel@lists.linux.dev
Cc: Heming Zhao <heming.zhao@suse.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] ocfs2: Revert "ocfs2: fix the la space leak when unmounting an ocfs2 volume"
Date: Thu,  5 Dec 2024 18:48:32 +0800
Message-ID: <20241205104835.18223-2-heming.zhao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241205104835.18223-1-heming.zhao@suse.com>
References: <20241205104835.18223-1-heming.zhao@suse.com>
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


