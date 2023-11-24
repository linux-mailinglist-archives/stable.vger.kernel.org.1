Return-Path: <stable+bounces-2499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0096C7F8472
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B031528B7CE
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD662E853;
	Fri, 24 Nov 2023 19:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bl3w2Mob"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F212A381A2;
	Fri, 24 Nov 2023 19:27:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB90C433C8;
	Fri, 24 Nov 2023 19:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700854034;
	bh=potwLIiNtZrgirAdq5BLd6ShuTnSbyb363+TjbJZGww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bl3w2Mob1yw2ZwnYwXYW2XcIRnnQK/QeDr6kp3MZ5aAiDY/KOZ5nN0U49waM6uPgj
	 6Iibc1Ci7mQfDL4Hhr5rMpGq2jPHE8tdYy8lT7dryaZG4IF6Ogc7pFXfFyQjoKZZD0
	 eCZLQGc+aIMJQBwEXlbgw2bZSuYyipFUAZh7fBj4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhang Yi <yi.zhang@huawei.com>,
	stable@kernel.org,
	Theodore Tso <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 5.4 130/159] ext4: correct the start block of counting reserved clusters
Date: Fri, 24 Nov 2023 17:55:47 +0000
Message-ID: <20231124171947.232823830@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171941.909624388@linuxfoundation.org>
References: <20231124171941.909624388@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Yi <yi.zhang@huawei.com>

commit 40ea98396a3659062267d1fe5f99af4f7e4f05e3 upstream.

When big allocate feature is enabled, we need to count and update
reserved clusters before removing a delayed only extent_status entry.
{init|count|get}_rsvd() have already done this, but the start block
number of this counting isn't correct in the following case.

  lblk            end
   |               |
   v               v
          -------------------------
          |                       | orig_es
          -------------------------
                   ^              ^
      len1 is 0    |     len2     |

If the start block of the orig_es entry founded is bigger than lblk, we
passed lblk as start block to count_rsvd(), but the length is correct,
finally, the range to be counted is offset. This patch fix this by
passing the start blocks to 'orig_es->lblk + len1'.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Cc: stable@kernel.org
Link: https://lore.kernel.org/r/20230824092619.1327976-2-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/extents_status.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -1348,8 +1348,8 @@ retry:
 			}
 		}
 		if (count_reserved)
-			count_rsvd(inode, lblk, orig_es.es_len - len1 - len2,
-				   &orig_es, &rc);
+			count_rsvd(inode, orig_es.es_lblk + len1,
+				   orig_es.es_len - len1 - len2, &orig_es, &rc);
 		goto out_get_reserved;
 	}
 



