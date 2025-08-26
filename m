Return-Path: <stable+bounces-173511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C17CB35DB9
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4877D1886682
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C4929C339;
	Tue, 26 Aug 2025 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tlkUJN/K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA422F9982;
	Tue, 26 Aug 2025 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208438; cv=none; b=kjG0R6NMDeXFioQyFrDLb+ntKRWGEG9Qx5cSsM2j9ABUuAbRieQrwgdHwXZDH0AMk9pNLSuXoSnLQoKGst/ixxysSRewm1SbbR5nbMYDZSnXyC+OS5ESIAmGbeUUxmd+yLxbyMkgVv6vqtEKNPqq8K0ORZMWyJ+U0u2i5OuH2HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208438; c=relaxed/simple;
	bh=M28o8MYz40RcCO0e/AIDN6piDlUezDurCPI18pJe5Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J841+HermFL7b7njMoxAfB9/SACs09AZJUhJhbmXHyk41d8kQYGMUgo1ymkxXUGd7Dwcs6mGRcy6IMzB/urMI7Tn3QyLxzteBhnHT6xX2lsYlgBgw6Zdp4sz5idiTxg+GjUBB8aTFyjZmuQHZBZPV+RrvFeMiYyyku3b2m3ueEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tlkUJN/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA082C4CEF1;
	Tue, 26 Aug 2025 11:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756208438;
	bh=M28o8MYz40RcCO0e/AIDN6piDlUezDurCPI18pJe5Ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tlkUJN/K8i5tNeIqRPWrKfLiRiLB/iwc0ChEl/o8Qd9005bWQxwprFk6tr3Rcnc3v
	 7jpNSbJfDGbkWhOWR1Wtzd3lrF722D5q4XXXOoXGa1EshygQ5OQEO32r2nzwTFZiQj
	 BRfKWZov9CkCL68fWqoBchpl0gtqUfeA5rfDTBVM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gabor Juhos <j4g8y7@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 6.12 070/322] mtd: spinand: propagate spinand_wait() errors from spinand_write_page()
Date: Tue, 26 Aug 2025 13:08:05 +0200
Message-ID: <20250826110917.311231198@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
References: <20250826110915.169062587@linuxfoundation.org>
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

From: Gabor Juhos <j4g8y7@gmail.com>

commit 091d9e35b85b0f8f7e1c73535299f91364a5c73a upstream.

Since commit 3d1f08b032dc ("mtd: spinand: Use the external ECC engine
logic") the spinand_write_page() function ignores the errors returned
by spinand_wait(). Change the code to propagate those up to the stack
as it was done before the offending change.

Cc: stable@vger.kernel.org
Fixes: 3d1f08b032dc ("mtd: spinand: Use the external ECC engine logic")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/spi/core.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -659,7 +659,10 @@ static int spinand_write_page(struct spi
 			   SPINAND_WRITE_INITIAL_DELAY_US,
 			   SPINAND_WRITE_POLL_DELAY_US,
 			   &status);
-	if (!ret && (status & STATUS_PROG_FAILED))
+	if (ret)
+		return ret;
+
+	if (status & STATUS_PROG_FAILED)
 		return -EIO;
 
 	return nand_ecc_finish_io_req(nand, (struct nand_page_io_req *)req);



