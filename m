Return-Path: <stable+bounces-157975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 535F5AE566A
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41EA189CE9F
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3A116D9BF;
	Mon, 23 Jun 2025 22:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oGPo8o8r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BE119F120;
	Mon, 23 Jun 2025 22:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717178; cv=none; b=nMFo/Eoai8+1fKyRI5O5whWvNSEIeRf3/D5gmdGxGMYJenql6ha9i7PiTHOE6KmbfnOZPlSyjwQZoM9f1DAFAP0/k2dpD5y24S4smQLKFcG37k6KX67Awef0hXZu0x7W5dBMgv6CwnAvnVOBJW0FASQoOyalIXW5yx38Q08b4CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717178; c=relaxed/simple;
	bh=uVwhkhsaX5eFnWuYTMapDzOjRGlWDX9oFK78SDeso88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCavexSh5sG0PlodQVGVMgb59bpB2b+DAHsCGF8LNImzK94DyHXTRPN4NaRUv5Bm/HVeP1AEmwQo1tfCPUm+FuF8WoLhxr29k6ywfM745mC/y9WA58I2nqxhZTR8whF1XADHz0FzMdrQKmW8cZ6qzJJMzbOPszx0PnBu8Hi1b24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oGPo8o8r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CD3C4CEEA;
	Mon, 23 Jun 2025 22:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750717177;
	bh=uVwhkhsaX5eFnWuYTMapDzOjRGlWDX9oFK78SDeso88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oGPo8o8r0p5PJ/RfBEqjogQSwJN1pvd6Non0KYyPp8w6jSbxYlELcMkz2qCe4tYZY
	 QQlyN5wlTc18sjWf52t12WBw8z2L3GG8ILgYmMzGavQ5NU45AZrnFd/jXF3V9UVF+N
	 YKLP0WXq8ZBa8aJZ16QOt9Ui6+ITl1Hgpy2MWIr0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>,
	Daniel Wagner <dwagner@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 411/411] scsi: elx: efct: Fix memory leak in efct_hw_parse_filter()
Date: Mon, 23 Jun 2025 15:09:15 +0200
Message-ID: <20250623130644.033046103@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130632.993849527@linuxfoundation.org>
References: <20250623130632.993849527@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>

[ Upstream commit 2a8a5a5dd06eef580f9818567773fd75057cb875 ]

strsep() modifies the address of the pointer passed to it so that it no
longer points to the original address. This means kfree() gets the wrong
pointer.

Fix this by passing unmodified pointer returned from kstrdup() to
kfree().

Found by Linux Verification Center (linuxtesting.org) with Svace.

Fixes: 4df84e846624 ("scsi: elx: efct: Driver initialization routines")
Signed-off-by: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
Link: https://lore.kernel.org/r/20250612163616.24298-1-v.shevtsov@mt-integration.ru
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/elx/efct/efct_hw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/elx/efct/efct_hw.c b/drivers/scsi/elx/efct/efct_hw.c
index ba8256b4c7824..6385c6c730fea 100644
--- a/drivers/scsi/elx/efct/efct_hw.c
+++ b/drivers/scsi/elx/efct/efct_hw.c
@@ -1120,7 +1120,7 @@ int
 efct_hw_parse_filter(struct efct_hw *hw, void *value)
 {
 	int rc = 0;
-	char *p = NULL;
+	char *p = NULL, *pp = NULL;
 	char *token;
 	u32 idx = 0;
 
@@ -1132,6 +1132,7 @@ efct_hw_parse_filter(struct efct_hw *hw, void *value)
 		efc_log_err(hw->os, "p is NULL\n");
 		return -ENOMEM;
 	}
+	pp = p;
 
 	idx = 0;
 	while ((token = strsep(&p, ",")) && *token) {
@@ -1144,7 +1145,7 @@ efct_hw_parse_filter(struct efct_hw *hw, void *value)
 		if (idx == ARRAY_SIZE(hw->config.filter_def))
 			break;
 	}
-	kfree(p);
+	kfree(pp);
 
 	return rc;
 }
-- 
2.39.5




