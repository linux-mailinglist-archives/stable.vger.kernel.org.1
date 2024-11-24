Return-Path: <stable+bounces-94989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDE89D7221
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 761DCB31A13
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C251EABB4;
	Sun, 24 Nov 2024 13:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDWVVV5m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10641EABA9;
	Sun, 24 Nov 2024 13:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455515; cv=none; b=SgZQcOj6i3lt3vuh27kaAQa1MfQfgi9bleIYBNWnmxMpvqC2D3Ud5SRH5dk+obmV7SwM56q8jM9jgJYmFWqH4pa2FAtb8wau8Ea5ycDYES9nuVmu47iY2bQzC9iuCom9x8Zcu8lste5MhqsIGQTNyuQVQ3rgh8ExgYUNnf3yS8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455515; c=relaxed/simple;
	bh=rhEx+TxjxSmGCzxQlQoAtH+QWYgtyLqIu09QUoh5Ges=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=efKyk0GFg28Scw+kj4df5YD4ci1DL6PfYQZur4b8d0/ir+TElN+Mey78n2jk8GtCH6z+ZnaQtoxiFUJJzcI2QXcuO277Ih6opkcr7PMgcGeOOfj06ROrkL66/4OylSxXxGiuxv4wimMsrR4ZXgpI8i+f92h9Vv+8UMCvYOmTfmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDWVVV5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B32C4CED3;
	Sun, 24 Nov 2024 13:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455515;
	bh=rhEx+TxjxSmGCzxQlQoAtH+QWYgtyLqIu09QUoh5Ges=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UDWVVV5mrJpcKBFFWYdnd+U5gzRWbqDYH+Iakc+Ua0jJYluqyvqoszZwZL5RH8oh4
	 73r1tT6K8uLPgm7fg4oKhYZwKPrK1b96XX/VMoAd8k6dCOyq6acYv/mQzG6ADIOzXe
	 xbwL93478VsABwjyr6b9w9Rf68fqsjgBlf/H7FY4QAjdEvh6JqQUo9GWN9SCRHT3W7
	 5eQ3yAtbHS/sOCaM5XUF9WPom7+XOiVhvYe0FPIFaa7aBmQG8fwMbD2CYoioyg/xzB
	 0Kz/TKsLgpD1vbX+ctnQkeizHOJdJ/CZdD2UVV556DUjsu1/cCZeyNouDWgL8009oB
	 u6c596gb1Bq+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Markus Elfring <elfring@users.sourceforge.net>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 093/107] Bluetooth: hci_conn: Reduce hci_conn_drop() calls in two functions
Date: Sun, 24 Nov 2024 08:29:53 -0500
Message-ID: <20241124133301.3341829-93-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Markus Elfring <elfring@users.sourceforge.net>

[ Upstream commit d96b543c6f3b78b6440b68b5a5bbface553eff28 ]

An hci_conn_drop() call was immediately used after a null pointer check
for an hci_conn_link() call in two function implementations.
Thus call such a function only once instead directly before the checks.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_conn.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index c4c74b82ed211..50e65b2f54ee6 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2224,13 +2224,9 @@ struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst,
 					  conn->iso_qos.bcast.big);
 	if (parent && parent != conn) {
 		link = hci_conn_link(parent, conn);
-		if (!link) {
-			hci_conn_drop(conn);
-			return ERR_PTR(-ENOLINK);
-		}
-
-		/* Link takes the refcount */
 		hci_conn_drop(conn);
+		if (!link)
+			return ERR_PTR(-ENOLINK);
 	}
 
 	return conn;
@@ -2320,15 +2316,12 @@ struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
 	}
 
 	link = hci_conn_link(le, cis);
+	hci_conn_drop(cis);
 	if (!link) {
 		hci_conn_drop(le);
-		hci_conn_drop(cis);
 		return ERR_PTR(-ENOLINK);
 	}
 
-	/* Link takes the refcount */
-	hci_conn_drop(cis);
-
 	cis->state = BT_CONNECT;
 
 	hci_le_create_cis_pending(hdev);
-- 
2.43.0


