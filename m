Return-Path: <stable+bounces-190068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE8BC0FF0C
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD64119C45F7
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 18:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0018730217A;
	Mon, 27 Oct 2025 18:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZFWKFDHS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78E6218EB1;
	Mon, 27 Oct 2025 18:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761590352; cv=none; b=KYhLp+jRVgetgY4u12hDsII3FypEqhMIImtCWumJPIprdjq0PI3YqUqx5/kLmjU62lqZ3SiHMGB6sGmnNIYql4sZR2f2gm2GIPoy10CNRvRN/A9EuoyMQe+qDKnNpGm6CpwRFhYXxJ5ue1YiZSjTeRnd/vMw09cpSd6C0cJYQN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761590352; c=relaxed/simple;
	bh=7GJdxqCXbV/H8WoYKMC9HN/24c1IYFQ/5BhiK90x+ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POZRDbqFW5LvFZlEn92+LcENgEmkCQvLfQ//Ofn82Ys/Fxl51wYr9o1bVzMPKGYjN1rvK9L/f/FH4D87ikobWvBJ/8TeYid/FV+/7bMijwUHgUbihFpmUjdSknR8Yls+RL7wSDn29LjyKfhY4v07Z864NxY41AMviY4GwwP/PHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZFWKFDHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB65DC4CEF1;
	Mon, 27 Oct 2025 18:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761590351;
	bh=7GJdxqCXbV/H8WoYKMC9HN/24c1IYFQ/5BhiK90x+ZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZFWKFDHS2D3QiuF9QFUtiqNlzFth7aWU4bl+4CdFsWK82DummMgVElhqDV0fe67Xf
	 +XvaLV+0skCLnDiiaMyt2zj7EOCDIOQblau8t0mK+nQj4AQH6iFZlROr6tuhpLrBHN
	 5DpgbtpP/4M2OqVVHy8FI2TThVUUZFBuCF4OtXBM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 013/224] dm-integrity: limit MAX_TAG_SIZE to 255
Date: Mon, 27 Oct 2025 19:32:39 +0100
Message-ID: <20251027183509.344182097@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027183508.963233542@linuxfoundation.org>
References: <20251027183508.963233542@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit 77b8e6fbf9848d651f5cb7508f18ad0971f3ffdb ]

MAX_TAG_SIZE was 0x1a8 and it may be truncated in the "bi->metadata_size
= ic->tag_size" assignment. We need to limit it to 255.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-integrity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 15580ba773e72..38791b7e59ba3 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -116,7 +116,7 @@ struct journal_sector {
 	commit_id_t commit_id;
 };
 
-#define MAX_TAG_SIZE			(JOURNAL_SECTOR_DATA - JOURNAL_MAC_PER_SECTOR - offsetof(struct journal_entry, last_bytes[MAX_SECTORS_PER_BLOCK]))
+#define MAX_TAG_SIZE			255
 
 #define METADATA_PADDING_SECTORS	8
 
-- 
2.51.0




