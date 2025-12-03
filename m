Return-Path: <stable+bounces-198320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A88D2C9F8E1
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 16:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19AAD3063160
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 15:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847F131326A;
	Wed,  3 Dec 2025 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UZTYADLj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDED31280D;
	Wed,  3 Dec 2025 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764776157; cv=none; b=SGnE+OHQbdkysV4F1JvQNPgIjOW5j6pjQgjWtqbz4750S5FkDqY61v6h90/NMdFgUx0QBPoqIBArcZz0g2FTUEA71MJX1MaX4F4XjsFrWBa5U/Fpq75iYnKLNI0ji0iWxMo7PTnEDgijrGHvAxXFezHN0EOawMRmuOztUU7Hr+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764776157; c=relaxed/simple;
	bh=Ht2rS2bHVQQycshJrRd5ifmv/dYmfEU9RDSiDojZ2EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ogHnGLnisOzR5y8twqP+nk6qHToPJsrTS9osdyKLu7W4FpW9FLZw/qr2ozxPL51MHEfzJ9HuJKB427143FlSWnEot3nMZS+HQpbaUGJGwEizT0UFjQC+J97cVGCBh31qYfuAyGN/5//g2/tgr5/qUY+OeBpD7Nqp4Hstzf5InZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UZTYADLj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66679C4CEF5;
	Wed,  3 Dec 2025 15:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764776156;
	bh=Ht2rS2bHVQQycshJrRd5ifmv/dYmfEU9RDSiDojZ2EY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UZTYADLjziZTcK3042tCwvUVFLTiIitgedQTde3Ap+OLPGAK8laIPHmTvijQ5TNg6
	 NjwdIaLctMAVHZG6n1A14Qn3naH7Pdp7+valKNfe6T6zmrGgorSVRpMy6e+NYeIONv
	 Kf9Kbz9DXYuxJRiba3iInbglWbD1VZARq4hE05kQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 065/300] mfd: stmpe-i2c: Add missing MODULE_LICENSE
Date: Wed,  3 Dec 2025 16:24:29 +0100
Message-ID: <20251203152403.030352437@linuxfoundation.org>
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

From: Alexander Stein <alexander.stein@ew.tq-group.com>

[ Upstream commit 00ea54f058cd4cb082302fe598cfe148e0aadf94 ]

This driver is licensed GPL-2.0-only, so add the corresponding module flag.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Link: https://lore.kernel.org/r/20250725071153.338912-3-alexander.stein@ew.tq-group.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/stmpe-i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/stmpe-i2c.c b/drivers/mfd/stmpe-i2c.c
index cd2f45257dc16..d52bb3ea7fb6f 100644
--- a/drivers/mfd/stmpe-i2c.c
+++ b/drivers/mfd/stmpe-i2c.c
@@ -139,3 +139,4 @@ module_exit(stmpe_exit);
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("STMPE MFD I2C Interface Driver");
 MODULE_AUTHOR("Rabin Vincent <rabin.vincent@stericsson.com>");
+MODULE_LICENSE("GPL");
-- 
2.51.0




