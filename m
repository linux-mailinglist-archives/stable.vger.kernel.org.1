Return-Path: <stable+bounces-198309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BB3C9F8AB
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 16:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86A9D3005E99
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 15:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F17F3115BC;
	Wed,  3 Dec 2025 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mdI0iKnd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6BE3090C6;
	Wed,  3 Dec 2025 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764776120; cv=none; b=ICIR3DsFjDpmDqEStesR/2Y2HssypukJZeyDUI4soZ0fxLzWirCwEsLR3uIrZ9y1Q0BXVwMdxNzfdJC7Wf8xVoZu4vznPKYOpSyJ4dKdhpCv0ELW/GNy6K71KQJ9hppZs6P8aNBBtVAv0WO4CjHRNGOEEZ9F/LgV+eH+va5+ASA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764776120; c=relaxed/simple;
	bh=+Q9apZVoiILT+L4kyl66HJxlW/ZLOImi2OZXfND2ZxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/JBleL66dlOTpdfzb2w3OUtyodaxxjenNAeLsnL+gfxrLRjmWQFhcJdDvIQ6zmSvmoKsH9bpFbAxaqy0hQcWVV88QFYYeik6l5TjBBSSXzFEac2/SdlOT39I0OrfZhy8MiGSQBpCvczT92LSPNRzZFYL5E64m8eNj69PB/tfdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mdI0iKnd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860E3C4CEF5;
	Wed,  3 Dec 2025 15:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764776120;
	bh=+Q9apZVoiILT+L4kyl66HJxlW/ZLOImi2OZXfND2ZxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mdI0iKndCLMmmicOqTfg0rqFgudJGjX9+xQQvF9MsvT0m9Erx94etZxNQDbZe1XbS
	 13XK1T5qRsIhZaPXxekFnd+2us0bPckifsEuJZbvj3PveznCItlfOqlNjbTLGZV6ym
	 G7KjmEJsuPnJpEExbopod/2TU/ixOfpJlzBqhi6A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Zijun Hu <zijun.hu@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 086/300] char: misc: Does not request module for miscdevice with dynamic minor
Date: Wed,  3 Dec 2025 16:24:50 +0100
Message-ID: <20251203152403.810360777@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152400.447697997@linuxfoundation.org>
References: <20251203152400.447697997@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zijun Hu <zijun.hu@oss.qualcomm.com>

[ Upstream commit 1ba0fb42aa6a5f072b1b8c0b0520b32ad4ef4b45 ]

misc_open() may request module for miscdevice with dynamic minor, which
is meaningless since:

- The dynamic minor allocated is unknown in advance without registering
  miscdevice firstly.
- Macro MODULE_ALIAS_MISCDEV() is not applicable for dynamic minor.

Fix by only requesting module for miscdevice with fixed minor.

Acked-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20250714-rfc_miscdev-v6-6-2ed949665bde@oss.qualcomm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/misc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index f6a147427029a..cbe86a1f2244b 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -113,7 +113,8 @@ static int misc_open(struct inode *inode, struct file *file)
 		}
 	}
 
-	if (!new_fops) {
+	/* Only request module for fixed minor code */
+	if (!new_fops && minor < MISC_DYNAMIC_MINOR) {
 		mutex_unlock(&misc_mtx);
 		request_module("char-major-%d-%d", MISC_MAJOR, minor);
 		mutex_lock(&misc_mtx);
@@ -124,10 +125,11 @@ static int misc_open(struct inode *inode, struct file *file)
 				break;
 			}
 		}
-		if (!new_fops)
-			goto fail;
 	}
 
+	if (!new_fops)
+		goto fail;
+
 	/*
 	 * Place the miscdevice in the file's
 	 * private_data so it can be used by the
-- 
2.51.0




