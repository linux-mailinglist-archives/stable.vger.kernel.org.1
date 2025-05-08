Return-Path: <stable+bounces-142782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7E8AAF2AF
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 07:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 031B04A7EF2
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 05:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD7C2144A1;
	Thu,  8 May 2025 05:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tncbnr0Z"
X-Original-To: stable@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7692139C4;
	Thu,  8 May 2025 05:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746681332; cv=none; b=lpxeBIbkr2YRu6JsZhACki68CRV/vAjokj2UY36Jf89qdKA/d5fHJPpXKQNG53WNa/xdmBXz69AKodgaBLUMbmECRXb4I9xEgykylyHNh82hfN1fOCViHAHJ7FtVtJzEI4Xahqke2X3gzel44dVktTjBPkbF9X5rHRSy0OhN6l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746681332; c=relaxed/simple;
	bh=ISTACO0x9B1R7EsjFwT3G1ahFXPlmjZx3tK2r/IA7Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sw3GORxvDEUI5Dcs+1eUggV9X1hGGL6gnRveIF/QmJWWjn29bCj0cUZ+2JMCX5eIUFB9gKzssNJ6OHhEvOh/7uJS+Xifp/zT+qFd0XG8Ipy9HLZTsFjmTlWRWpnfKr0GATmX4qdtjDrMMBzEMggXWUJyyYrImFRFajR1eR6OuWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tncbnr0Z; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hjROd0wIshF4nMKexOdcqPc3YUZQgQDvNXYUo/8KwuY=; b=tncbnr0Z/51DQlCz6NmFJZGyGG
	aT5jujsnIXf19DNcnuMwusr8F6xwrqODAPPL9iFemFFE57h1vKdZUjODAEz3VbjoxneORcLp3Hcrf
	hcvGv1PqEWzkPHfSq93lefR+hoh01EzsNvGxsjxP+U9D3RXMVHb/48DhFfyIfmilZQf5Ag7bdXVhp
	J4iXUvDw0XBvLlGAeuEvMezQ+tsnOh76DlgmzV7DYzIAQU/mRPDr9FEexZIhHb9HyCI3oQiUa1lAE
	QRBiLXPc7diNb6EwD5Qb+UHE/+k4EJO0xXwLRsmjdnLVvb4RmWnhTYcYXmD6xRMwtLF2t8Vw4jaBl
	1yt/wrPg==;
Received: from 2a02-8389-2341-5b80-2368-be33-a304-131f.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:2368:be33:a304:131f] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCtbV-0000000HLfo-2btf;
	Thu, 08 May 2025 05:15:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/6] f2fs: fix to return correct error number in f2fs_sync_node_pages()
Date: Thu,  8 May 2025 07:14:27 +0200
Message-ID: <20250508051520.4169795-2-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250508051520.4169795-1-hch@lst.de>
References: <20250508051520.4169795-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

From: Chao Yu <chao@kernel.org>

If __write_node_folio() failed, it will return AOP_WRITEPAGE_ACTIVATE,
the incorrect return value may be passed to userspace in below path,
fix it.

- sync_filesystem
 - sync_fs
  - f2fs_issue_checkpoint
   - block_operations
    - f2fs_sync_node_pages
     - __write_node_folio
     : return AOP_WRITEPAGE_ACTIVATE

Cc: stable@vger.kernel.org
Reported-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/node.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index ec74eb9982a5..69308523c34e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2092,10 +2092,14 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 
 			ret = __write_node_folio(folio, false, &submitted,
 						wbc, do_balance, io_type, NULL);
-			if (ret)
+			if (ret) {
 				folio_unlock(folio);
-			else if (submitted)
+				folio_batch_release(&fbatch);
+				ret = -EIO;
+				goto out;
+			} else if (submitted) {
 				nwritten++;
+			}
 
 			if (--wbc->nr_to_write == 0)
 				break;
-- 
2.47.2


