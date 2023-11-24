Return-Path: <stable+bounces-1494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A427F7FFA
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9304B21441
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B04364C1;
	Fri, 24 Nov 2023 18:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c5u2Sj4V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DEC2EAEA;
	Fri, 24 Nov 2023 18:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CE6C433C8;
	Fri, 24 Nov 2023 18:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851541;
	bh=L5uWjfumcrquwQi56EVASmleKDbGF2qx7wndCyn6yRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c5u2Sj4VYyz1+MuTrdTmQoopJruHZoXWrgV3LSeuXdNPOvsqiQXXJqNIQVZT9QZid
	 RqVxDodyL+gNSo2KYV0DjOJiCtR4theZaUXG5prFwHWb9Y/8ek5wAamsPiEZxYQu3l
	 NUhcTZPridl4NaO4jkfdXdh+eHqDjxLsPWhtBO2o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhang Yi <yi.zhang@huawei.com>,
	stable@kernel.org,
	Theodore Tso <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 6.5 464/491] ext4: correct the start block of counting reserved clusters
Date: Fri, 24 Nov 2023 17:51:40 +0000
Message-ID: <20231124172038.567253426@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1431,8 +1431,8 @@ static int __es_remove_extent(struct ino
 			}
 		}
 		if (count_reserved)
-			count_rsvd(inode, lblk, orig_es.es_len - len1 - len2,
-				   &orig_es, &rc);
+			count_rsvd(inode, orig_es.es_lblk + len1,
+				   orig_es.es_len - len1 - len2, &orig_es, &rc);
 		goto out_get_reserved;
 	}
 



