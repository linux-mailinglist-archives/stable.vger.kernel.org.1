Return-Path: <stable+bounces-95079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD739D7310
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5C816590D
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE2721312B;
	Sun, 24 Nov 2024 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFPxuUzu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5941D8E12;
	Sun, 24 Nov 2024 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455913; cv=none; b=chqX6+gATSmyhcsPU4111+WoQrYD7g+q9I/U7Svst7iOyRQKnL+EDel+xcV2w+eEF0Tjpmd2bdd/2K7TQxTd06Bf05nItgHCBJUkQtU5c9McecLaoI2s9ETWiMhHmEEMKXK9ynUqHsuNIKor48jCjFT9luPsIBcpwYvTyA0qEAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455913; c=relaxed/simple;
	bh=XNDL/XpgqQ/eI4dayADRymq+F3ds19yyAENYLBIJSe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QvUht2jctnRKjlfaEVE9aqCeoKt0j5v8AJ5rj7NHXqCBNUS88H5Dhy2UUxPP0zxJz+3ZIm0JUbAqFK1H+hoff/DiYCyAr/sCjMOQDzvoHhmw3tnWin5l1sNQW6WKIxh5n6qnkmBzbhUQXxvVlV/lnJOPooGActPItJIjNKAiI84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFPxuUzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052F5C4CECC;
	Sun, 24 Nov 2024 13:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455913;
	bh=XNDL/XpgqQ/eI4dayADRymq+F3ds19yyAENYLBIJSe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VFPxuUzui6PQk9Szelde8fd2BhLFfvuEUFwPEmdugqXU06UamDvAALSptnnjEXik3
	 tZcjRomZRXOVgmk7Y0WyATLvzhnPFpBBC/W3XyoGMIA3OqdOsSWrpdpWceq1i9og74
	 Kx6uYkw1lXwNl4DCZTxzjUtpbg9d1RXwggf9xxckeYQ+ZqjpzgHpj6SxtgC8dALlzZ
	 C78KnWbHWjgYU5S2wMFHkMr6/+BC63dZ9ZtNzFP1YV6NwJ3EJHlmkbdAPgjshrBLG2
	 PkpJUNfBjlKNbO5nM9J9KCB+zNf4uQakO3WPQ27QDxnATBwb/ERin9Yhgb801NS44U
	 eSFf7fsIMHjLA==
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
Subject: [PATCH AUTOSEL 6.11 76/87] Bluetooth: hci_conn: Reduce hci_conn_drop() calls in two functions
Date: Sun, 24 Nov 2024 08:38:54 -0500
Message-ID: <20241124134102.3344326-76-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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
index a7ffce4851235..49e3d4fb49a0e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2225,13 +2225,9 @@ struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst,
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
@@ -2321,15 +2317,12 @@ struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
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


