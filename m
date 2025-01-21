Return-Path: <stable+bounces-109938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F2DA18481
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 19:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0673A4FE9
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 18:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBCD1F7060;
	Tue, 21 Jan 2025 18:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IfFpuzGh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2551F3FFE;
	Tue, 21 Jan 2025 18:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482872; cv=none; b=EOD79kqNaqZRrc/ecrWNTeQmbjQ6GQ8P8/PusTYuqAVTlwVgJwzRB9cMokWyIKZAjPVFFtwh78KU4RO+Y0DCIrc6rnmatc/dKsNBzvbxAvKfTTFALdwXf7cSbwB5JyX9VL0UPGvyj1Zwnwgyl4bvTmCRPhQ5iK+AkHEkz8zSuXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482872; c=relaxed/simple;
	bh=ryUJMSpHDhfVOiEwMrYCeKDFhkdtbE3/o7HINqPgAog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6FYLV+f2hDWO6S9YzCPB3QbMyv7AJmotPbQvD//k8nO9YbAm8PL+U6Gl/H6H7NSYlN6dJhIAsH9hE//4QklldelIQSR2/ssAMp4+M2iz4LSrdB5y04Q3j2ZwSXOZTdKt4AlRACyW+wxD2/smzZtsunx4RRFc1h6ZyxP7wT2zO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IfFpuzGh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8909C4CEDF;
	Tue, 21 Jan 2025 18:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737482872;
	bh=ryUJMSpHDhfVOiEwMrYCeKDFhkdtbE3/o7HINqPgAog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IfFpuzGhpRL+U9BMaBeweQfY1m7fIvVUCJOJwLPDxvf9EnHXXKWFRqGrX+XOLF7Uq
	 /5wpGVYq6WkHM0Aalop1UfUB+KNE5G/2sAqObK+90TeaKibLbQUoBG9bfBOBNt1U9j
	 Ga1p82KU2iX02T1UdXEosZ6D9xdXbWX9yAsvrGgc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com,
	Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 007/127] exfat: fix the infinite loop in __exfat_free_cluster()
Date: Tue, 21 Jan 2025 18:51:19 +0100
Message-ID: <20250121174529.958173617@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250121174529.674452028@linuxfoundation.org>
References: <20250121174529.674452028@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuezhang Mo <Yuezhang.Mo@sony.com>

[ Upstream commit a5324b3a488d883aa2d42f72260054e87d0940a0 ]

In __exfat_free_cluster(), the cluster chain is traversed until the
EOF cluster. If the cluster chain includes a loop due to file system
corruption, the EOF cluster cannot be traversed, resulting in an
infinite loop.

This commit uses the total number of clusters to prevent this infinite
loop.

Reported-by: syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1de5a37cb85a2d536330
Tested-by: syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com
Fixes: 31023864e67a ("exfat: add fat entry operations")
Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exfat/fatent.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index 421c27353104..8f07504e5345 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -215,6 +215,16 @@ static int __exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain
 
 			if (err)
 				goto dec_used_clus;
+
+			if (num_clusters >= sbi->num_clusters - EXFAT_FIRST_CLUSTER) {
+				/*
+				 * The cluster chain includes a loop, scan the
+				 * bitmap to get the number of used clusters.
+				 */
+				exfat_count_used_clusters(sb, &sbi->used_clusters);
+
+				return 0;
+			}
 		} while (clu != EXFAT_EOF_CLUSTER);
 	}
 
-- 
2.39.5




