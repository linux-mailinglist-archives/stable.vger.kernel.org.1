Return-Path: <stable+bounces-109782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA98A183E5
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 19:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ABCB16C6DE
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 18:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202371F758A;
	Tue, 21 Jan 2025 18:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ASqjq8XW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D249B1F7578;
	Tue, 21 Jan 2025 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482422; cv=none; b=tS6vD+Thywl4n0MEjvYzZBygkSZfqK1VLfE0DZY24xgodHRco3Usg8JUASQQu2xJm16HlK0s+tqtHNnZI1MFZQCKZH5kmw8ugK/uBbQcXV2g0b+SjyzfgKvLSiJ6D4F86F5rVulzGmALSFy8l9F9ExEDNtWHVFtlH6HrI0h8fjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482422; c=relaxed/simple;
	bh=Ms4RItJX9PSzj+kueInDdW2Z8mKlpmqsWaFeNZm78vE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDRqYjvofsK/PnGM4VaHv5ibfwQD67B57Kca/83YL9GtuQPmq0xecHSg2+CiyVt154ywGgzhe90Zz33YF0eQuK17MxfydvRB/bo90D3cxa40PjZ6nliS84XYZsN3QjOdnpbqhJIb0tOENl7US6YcPDQNhDydpNMzJAw3ANmi6uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ASqjq8XW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5997AC4CEDF;
	Tue, 21 Jan 2025 18:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737482422;
	bh=Ms4RItJX9PSzj+kueInDdW2Z8mKlpmqsWaFeNZm78vE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ASqjq8XWg7jshhb2cX/UinUsxxm1M+CMbR8Fd3bZsuFX6eyaAaojQ36c7GQ5fcAzX
	 g1jvZRxh3X85cUTa6u6Nz1fpmmzmJsFzap77AeVGy7XDmViejgsrDb4iuMurD1tr4n
	 6Tf48GWdXqc67OSk5XXi//O9Kr0mfShYqCMn91Ms=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marco Nelissen <marco.nelissen@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 064/122] iomap: avoid avoid truncating 64-bit offset to 32 bits
Date: Tue, 21 Jan 2025 18:51:52 +0100
Message-ID: <20250121174535.460878175@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250121174532.991109301@linuxfoundation.org>
References: <20250121174532.991109301@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marco Nelissen <marco.nelissen@gmail.com>

[ Upstream commit c13094b894de289514d84b8db56d1f2931a0bade ]

on 32-bit kernels, iomap_write_delalloc_scan() was inadvertently using a
32-bit position due to folio_next_index() returning an unsigned long.
This could lead to an infinite loop when writing to an xfs filesystem.

Signed-off-by: Marco Nelissen <marco.nelissen@gmail.com>
Link: https://lore.kernel.org/r/20250109041253.2494374-1-marco.nelissen@gmail.com
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap/buffered-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 25d1ede6bb0eb..1bad460275ebe 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1138,7 +1138,7 @@ static void iomap_write_delalloc_scan(struct inode *inode,
 				start_byte, end_byte, iomap, punch);
 
 		/* move offset to start of next folio in range */
-		start_byte = folio_next_index(folio) << PAGE_SHIFT;
+		start_byte = folio_pos(folio) + folio_size(folio);
 		folio_unlock(folio);
 		folio_put(folio);
 	}
-- 
2.39.5




