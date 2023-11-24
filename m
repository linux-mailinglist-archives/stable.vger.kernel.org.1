Return-Path: <stable+bounces-1966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 536357F822F
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FDFC280F2E
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E4D34189;
	Fri, 24 Nov 2023 19:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y2OoK++e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F9C3173F;
	Fri, 24 Nov 2023 19:05:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050FCC433C7;
	Fri, 24 Nov 2023 19:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852716;
	bh=fJXc4QazTWeH4viOjyVpM9hPST+VXrCHKBXJlpHhJPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y2OoK++e1gkXTF3zdwD9NWUF7zJRhB1MbYwwXGo8+F1e67qPTvgZXhuh55JEVXjmz
	 5EAS0d4XCMcAMkiJNdRItU2Bacn2ZNOe/KPG42cbsgnfcnGftlbCEdX3J0dEaiXpYA
	 cechyvPFUc5oxmT7IT1uT69mEK+n3Uit4ti9oBp4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chandrakanth patil <chandrakanth.patil@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.10 095/193] scsi: megaraid_sas: Increase register read retry rount from 3 to 30 for selected registers
Date: Fri, 24 Nov 2023 17:53:42 +0000
Message-ID: <20231124171951.068676565@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171947.127438872@linuxfoundation.org>
References: <20231124171947.127438872@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
@@ -248,13 +248,13 @@ u32 megasas_readl(struct megasas_instanc
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



