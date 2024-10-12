Return-Path: <stable+bounces-83525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9FA99B384
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE56D1C21BB1
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042A419C546;
	Sat, 12 Oct 2024 11:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1kAF0bQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DF4199932;
	Sat, 12 Oct 2024 11:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732402; cv=none; b=iYwhJVFJV7JBtBavE55LwdlBwf2I9M6D7xoUdE074L1wJRRo4ipEiSuewgXdp26p+5DKIAiEh55uSq/NAa4QfV0WWom2GsQla8baZua+QBQ+EumEdZp/v3/oH+VAh52kGf8lM6DYl7wmBO3jNSbsz/N3Vw1ZVQ2S2bqXleA+SSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732402; c=relaxed/simple;
	bh=g4cE+tFMQG/sZb5EKZTJYc8GtFYKciBynxsCPz88vcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EU3pgiQdAw/IP6kxF4sf9l/EEtd8XBK3JtvHqVGlqWaf4NjCWELJSDY5xeIyy0wzroMVY/D7LmWd7ShbhszkibGubyM5M9M6bhBwzbzrEOnxeerySJyXnxEx78f4SxFLVcInnOqgbCjjN1mYqK+uahrdumZiS8I6kzfbYxEGAD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1kAF0bQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12FBC4CEC7;
	Sat, 12 Oct 2024 11:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732402;
	bh=g4cE+tFMQG/sZb5EKZTJYc8GtFYKciBynxsCPz88vcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i1kAF0bQLGxnbSR3E3GfNUOyr9QW0FGgrMa8J5cR/3S4wiHC3VpEssYngFKLPf9qc
	 IWNbTK/1z1dH2+I0iIdUyO9FS8kVE9ecJSWc/Zl5n8Fgz1txXJPqSehUcm5tAj2psv
	 TT9Ul/NTCu3V9rQRQmGDKV9QGSERNIdHCWFalG44vON4VVWSuYq4H40QYaG2iHiVFn
	 rUqm/GBc8B4/10poCtsiaGYSaBqcbKh/ifYwrHEj3Wuu6fmxLAI3OvOmxxI1fUuLZ7
	 bInGEpWETvChdprNC7UawIE4n1Hm4MZrKS6FlB2bz2j0N+Jq1WFwKHIA3Wmz3M4zIQ
	 MOwlSpPccAEhg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gianfranco Trad <gianf.trad@gmail.com>,
	syzbot+8901c4560b7ab5c2f9df@syzkaller.appspotmail.com,
	Jan Kara <jack@suse.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.11 11/16] udf: fix uninit-value use in udf_get_fileshortad
Date: Sat, 12 Oct 2024 07:26:07 -0400
Message-ID: <20241012112619.1762860-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112619.1762860-1-sashal@kernel.org>
References: <20241012112619.1762860-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.3
Content-Transfer-Encoding: 8bit

From: Gianfranco Trad <gianf.trad@gmail.com>

[ Upstream commit 264db9d666ad9a35075cc9ed9ec09d021580fbb1 ]

Check for overflow when computing alen in udf_current_aext to mitigate
later uninit-value use in udf_get_fileshortad KMSAN bug[1].
After applying the patch reproducer did not trigger any issue[2].

[1] https://syzkaller.appspot.com/bug?extid=8901c4560b7ab5c2f9df
[2] https://syzkaller.appspot.com/x/log.txt?x=10242227980000

Reported-by: syzbot+8901c4560b7ab5c2f9df@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8901c4560b7ab5c2f9df
Tested-by: syzbot+8901c4560b7ab5c2f9df@syzkaller.appspotmail.com
Suggested-by: Jan Kara <jack@suse.com>
Signed-off-by: Gianfranco Trad <gianf.trad@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20240925074613.8475-3-gianf.trad@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/udf/inode.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 80dae442ecd72..53511c726d575 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -2257,12 +2257,15 @@ int udf_current_aext(struct inode *inode, struct extent_position *epos,
 		alen = udf_file_entry_alloc_offset(inode) +
 							iinfo->i_lenAlloc;
 	} else {
+		struct allocExtDesc *header =
+			(struct allocExtDesc *)epos->bh->b_data;
+
 		if (!epos->offset)
 			epos->offset = sizeof(struct allocExtDesc);
 		ptr = epos->bh->b_data + epos->offset;
-		alen = sizeof(struct allocExtDesc) +
-			le32_to_cpu(((struct allocExtDesc *)epos->bh->b_data)->
-							lengthAllocDescs);
+		if (check_add_overflow(sizeof(struct allocExtDesc),
+				le32_to_cpu(header->lengthAllocDescs), &alen))
+			return -1;
 	}
 
 	switch (iinfo->i_alloc_type) {
-- 
2.43.0


