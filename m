Return-Path: <stable+bounces-185513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 570F9BD63A0
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 22:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DECA5403B0B
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 20:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91DD30B504;
	Mon, 13 Oct 2025 20:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/ldYxoe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806FF30AD13
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 20:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760388087; cv=none; b=sdzWLRLcGiM8qB93Twe02yb/Yemf6JChIn6qz4uknq49GiX9f0HtGvPLmQtVvlAq650hA6YIh9h5eefm0vICMR9YUFGR/dhszZFPUZ3k+y/mfm5NqudZuZVKxyrcalqpOuemsbLKQgAvMNzLpDSzFrK80KZFHKtdNztgFe5apFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760388087; c=relaxed/simple;
	bh=MyZMPa3FXISo3XHLeC//9VsfOsOIHqIYjLrQElhm+TM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yu0S94pUGeBmw8eOJK5eI3Iy866I4A0rtNpdVPY6XcH+A0j06VjbMUCrRzoyWbn6qo+WoDDZzG7wWXmRZxxC7UEXusFyNNHn/asGaRmbG8rFpRFIbaZnGTEHG8RwV6JYCW+KUEBw2SB+4/AVS38cilAo72xPx3Aa7Cv9vUmywCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/ldYxoe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C80C4CEE7;
	Mon, 13 Oct 2025 20:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760388087;
	bh=MyZMPa3FXISo3XHLeC//9VsfOsOIHqIYjLrQElhm+TM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G/ldYxoeCYDX3GHMWoNdnbJlihPWPnsux5rVg1t7rwEnipGM319DON6REoA+8efgy
	 bJCn2UYTHILrvrOjAJbnUG6WzFZ4beqRoIY6fHm+SpUrHzpEjfJE0QHqzqgj69Jo+V
	 vYOotfwGBDf2884WuX9n2N2UsYtdvsifc+rX1bDeW0/RBl/AwJWQgKOfy39CQnDJOt
	 k7UCwCXwgsEbp0XOBZ1qya4OTg1QXqMeouaXmCbrmtQ7Bl0l1jvguW0Ruj+ztybJ+b
	 A5Vj8mecIn6hE+dN5m+l5mzuNonlVIMBrtImn10NoEYdAdLvbQtrSog3GM4jSUEENP
	 2VWH6I7RsYyMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gianfranco Trad <gianf.trad@gmail.com>,
	syzbot+8901c4560b7ab5c2f9df@syzkaller.appspotmail.com,
	Jan Kara <jack@suse.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] udf: fix uninit-value use in udf_get_fileshortad
Date: Mon, 13 Oct 2025 16:41:23 -0400
Message-ID: <20251013204124.3599728-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101309-prescribe-imprison-4896@gregkh>
References: <2025101309-prescribe-imprison-4896@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
Stable-dep-of: 3bd5e45c2ce3 ("fs: udf: fix OOB read in lengthAllocDescs handling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/udf/inode.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 499a27372a40b..f6dbd65b8559c 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -2190,12 +2190,15 @@ int8_t udf_current_aext(struct inode *inode, struct extent_position *epos,
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
2.51.0


