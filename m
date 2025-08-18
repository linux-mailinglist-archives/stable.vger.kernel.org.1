Return-Path: <stable+bounces-171168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2F1B2A813
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D57095823CA
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F8D335BC4;
	Mon, 18 Aug 2025 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nlrt97P3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BE11E48A;
	Mon, 18 Aug 2025 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525039; cv=none; b=GaUddjZY1cVGU53yz3+edIf/tGZdR9ut3PmkW5ULWJo48HR2ANJjL4Hv2CXu0i0UkHqU9VRkFrFuDrpBaDUxo5lLcDkVpH3LtPn1tOXEVbzbYfs6JtyCjruMpRS2FMIg9oFn8rQtgDq6xwfr+8dZYmu/Irv6OrGt5xGN1JhLBxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525039; c=relaxed/simple;
	bh=dOQpb9hK5rSz8nSyc/SZ33bA9DeSPz0x6fcazzv1Yv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o1YhFvVIjfrFERi4WF0SNkloO+kVre09nrWETWtgqHtD0F/nHM6LB7Xnvn+Bgug8dovGdQk0XCvCesp0GAafbVGwtUsN26un25auPf3Z0QS3G4kmh2LXUPsinOU424mX492HCCIgvOkyOxpK/baH7B6qDYYvgIKyUxcdPAyxnco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nlrt97P3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4302CC4CEEB;
	Mon, 18 Aug 2025 13:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755525038;
	bh=dOQpb9hK5rSz8nSyc/SZ33bA9DeSPz0x6fcazzv1Yv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nlrt97P35EvXLAAzcmI4B+0q3WT3H+e5W0+tcZPOptb7BFy9FpRL+QTxmudgxckeF
	 3/gyM5wvDYAf4LrDU8cI8FAftNWA/J8cEXSFUhK/xmSMiuMIYMDWr/D6AmGonMaAm8
	 PJQuusrZbqmFNpFkv7QalI9nlaeU5Ms6azGqZOZM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tiffany Yang <ynaffit@google.com>,
	Carlos Llamas <cmllamas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 140/570] binder: Fix selftest page indexing
Date: Mon, 18 Aug 2025 14:42:07 +0200
Message-ID: <20250818124511.212034346@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124505.781598737@linuxfoundation.org>
References: <20250818124505.781598737@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tiffany Yang <ynaffit@google.com>

[ Upstream commit bea3e7bfa2957d986683543cbf57092715f9a91b ]

The binder allocator selftest was only checking the last page of buffers
that ended on a page boundary. Correct the page indexing to account for
buffers that are not page-aligned.

Signed-off-by: Tiffany Yang <ynaffit@google.com>
Acked-by: Carlos Llamas <cmllamas@google.com>
Link: https://lore.kernel.org/r/20250714185321.2417234-2-ynaffit@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/android/binder_alloc_selftest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder_alloc_selftest.c b/drivers/android/binder_alloc_selftest.c
index c88735c54848..486af3ec3c02 100644
--- a/drivers/android/binder_alloc_selftest.c
+++ b/drivers/android/binder_alloc_selftest.c
@@ -142,12 +142,12 @@ static void binder_selftest_free_buf(struct binder_alloc *alloc,
 	for (i = 0; i < BUFFER_NUM; i++)
 		binder_alloc_free_buf(alloc, buffers[seq[i]]);
 
-	for (i = 0; i < end / PAGE_SIZE; i++) {
 		/**
 		 * Error message on a free page can be false positive
 		 * if binder shrinker ran during binder_alloc_free_buf
 		 * calls above.
 		 */
+	for (i = 0; i <= (end - 1) / PAGE_SIZE; i++) {
 		if (list_empty(page_to_lru(alloc->pages[i]))) {
 			pr_err_size_seq(sizes, seq);
 			pr_err("expect lru but is %s at page index %d\n",
-- 
2.39.5




