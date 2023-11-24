Return-Path: <stable+bounces-1237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B19797F7EAF
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C52E61C213AC
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D7328DA1;
	Fri, 24 Nov 2023 18:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L33jn2Pq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52832D626;
	Fri, 24 Nov 2023 18:35:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EC5C433C7;
	Fri, 24 Nov 2023 18:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850901;
	bh=2c9vLcy9XZLD7IlUggQh70YEJ5KAi+OuYfLeFu2arsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L33jn2Pq5d+WW9R63moXjuOmOi9pDMwcSrlF+5ATDaKnIObx5KsVJ+r6babcp582Y
	 aOua74hMlNqkXK3ZaL0ArfS5qXRKQZS72566tIO4DhsyzNAmf4rmz3bJtnNODEqNRO
	 ftpTowTi+9Jozegu+HLNeuhoovG6S/4R6PIkNZ8c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chandrakanth patil <chandrakanth.patil@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.5 234/491] scsi: megaraid_sas: Increase register read retry rount from 3 to 30 for selected registers
Date: Fri, 24 Nov 2023 17:47:50 +0000
Message-ID: <20231124172031.589660113@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chandrakanth patil <chandrakanth.patil@broadcom.com>

commit 8e3ed9e786511ad800c33605ed904b9de49323cf upstream.

In BMC environments with concurrent access to multiple registers, certain
registers occasionally yield a value of 0 even after 3 retries due to
hardware errata. As a fix, we have extended the retry count from 3 to 30.

The same errata applies to the mpt3sas driver, and a similar patch has
been accepted. Please find more details in the mpt3sas patch reference
link.

Link: https://lore.kernel.org/r/20230829090020.5417-2-ranjan.kumar@broadcom.com
Fixes: 272652fcbf1a ("scsi: megaraid_sas: add retry logic in megasas_readl")
Cc: stable@vger.kernel.org
Signed-off-by: Chandrakanth patil <chandrakanth.patil@broadcom.com>
Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Link: https://lore.kernel.org/r/20231003110021.168862-2-chandrakanth.patil@broadcom.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/megaraid/megaraid_sas_base.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -263,13 +263,13 @@ u32 megasas_readl(struct megasas_instanc
 	 * Fusion registers could intermittently return all zeroes.
 	 * This behavior is transient in nature and subsequent reads will
 	 * return valid value. As a workaround in driver, retry readl for
-	 * upto three times until a non-zero value is read.
+	 * up to thirty times until a non-zero value is read.
 	 */
 	if (instance->adapter_type == AERO_SERIES) {
 		do {
 			ret_val = readl(addr);
 			i++;
-		} while (ret_val == 0 && i < 3);
+		} while (ret_val == 0 && i < 30);
 		return ret_val;
 	} else {
 		return readl(addr);



