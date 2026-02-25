Return-Path: <stable+bounces-219634-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IydMioIn2neYgQAu9opvQ
	(envelope-from <stable+bounces-219634-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 15:33:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 451C3198C99
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 15:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31F4E3027D81
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FF3285CBC;
	Wed, 25 Feb 2026 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLsdOyho"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F2B2857C1
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772029991; cv=none; b=T5zlJ+Q6ZCMhuIg+Ubn1brJo1CGSEXKdA3WXOuE6NkY2N7Il+sYlOMOdbDqAMUtKH2E8ET9NR5S9tPTsInkLcZT245jfhnRSAvFct7vSfKpfzWzLKM4ynz79kjGtbqhs8PyycYqwgNxtf4Fx7LkUqEpBaiofRanLWLbzHcufks8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772029991; c=relaxed/simple;
	bh=2aXCrFYspRcSeYWrZNTOtdpdN6lMraZG09Zjxc6D+6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0W9xPyOTSMfzR68pLQ3MQTY8/da0FPUfFw8+71n71kwP3vIhW2ul0rG9WgxKD4l/hhvdVPUy1NAgZ+He2KjKRbkuWrXDeE8ribOCKYvkD9VEQWHl4A52belDgd69DbcYdDyHDRZ5XR0ouxPeCGma0XX3jllgpnN16cQXbbWVG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLsdOyho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972BFC116D0;
	Wed, 25 Feb 2026 14:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772029991;
	bh=2aXCrFYspRcSeYWrZNTOtdpdN6lMraZG09Zjxc6D+6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fLsdOyho8G+puREopycCAW3IOGiMHsipEbmBbk6pEP7Aemg2uQWWouG5U5hbwNv/H
	 ESYmRVJB9IRfCUeNlpMWcwQpiDPV8Rdl+rB0N4jfk/CM6izcwrLyIoYCCZ5QWD6Z7i
	 dnCXdIgaN7FeMiwqzDEF0AvVOsARo7qM9jjs6LkspBiIOt8GgEgGPkodRKjeYNa92R
	 3VhH2dbOil4yfnhxEhB/4ydFMitmlbPwxNw1B9CU4OdoC+wbyHsDaSeBpHUUZU5sTP
	 k48R45i2Ogun0bn5+R0OdHSbSnh0WcscFyZeDxj7agpmnlXJs2+KfNQRZ90mHapjiP
	 rqthAGMtrQjfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Baokun Li <libaokun1@huawei.com>,
	stable@kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ext4: drop extent cache when splitting extent fails
Date: Wed, 25 Feb 2026 09:33:08 -0500
Message-ID: <20260225143308.469233-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026022430-craftsman-challenge-a264@gregkh>
References: <2026022430-craftsman-challenge-a264@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219634-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huaweicloud.com:email]
X-Rspamd-Queue-Id: 451C3198C99
X-Rspamd-Action: no action

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit 79b592e8f1b435796cbc2722190368e3e8ffd7a1 ]

When the split extent fails, we might leave some extents still being
processed and return an error directly, which will result in stale
extent entries remaining in the extent status tree. So drop all of the
remaining potentially stale extents if the splitting fails.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Cc: stable@kernel.org
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Message-ID: <20251129103247.686136-8-yi.zhang@huaweicloud.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[ bring error handling pattern closer to upstream ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 12da59c03c7cf..5572d2404eb3b 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3228,7 +3228,9 @@ static int ext4_split_extent_at(handle_t *handle,
 		ext4_ext_mark_unwritten(ex2);
 
 	err = ext4_ext_insert_extent(handle, inode, ppath, &newex, flags);
-	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
+	if (err && err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
+		goto out_err;
+	if (!err)
 		goto out;
 
 	/*
@@ -3244,7 +3246,8 @@ static int ext4_split_extent_at(handle_t *handle,
 	if (IS_ERR(path)) {
 		EXT4_ERROR_INODE(inode, "Failed split extent on %u, err %ld",
 				 split, PTR_ERR(path));
-		return PTR_ERR(path);
+		err = PTR_ERR(path);
+		goto out_err;
 	}
 	depth = ext_depth(inode);
 	ex = path[depth].p_ext;
@@ -3300,6 +3303,9 @@ static int ext4_split_extent_at(handle_t *handle,
 	 */
 	ext4_ext_dirty(handle, inode, path + path->p_depth);
 	return err;
+out_err:
+	/* Remove all remaining potentially stale extents. */
+	ext4_es_remove_extent(inode, ee_block, ee_len);
 out:
 	ext4_ext_show_leaf(inode, *ppath);
 	return err;
-- 
2.51.0


