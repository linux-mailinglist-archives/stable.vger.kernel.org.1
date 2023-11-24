Return-Path: <stable+bounces-1990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2FC7F8249
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75FA4284BAF
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D915E364A5;
	Fri, 24 Nov 2023 19:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZT3VH7vp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948DF2EAEA;
	Fri, 24 Nov 2023 19:06:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DC6C433C8;
	Fri, 24 Nov 2023 19:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852777;
	bh=jz5vD7HQ3va3AYqDlu/9Hb03lJVW92O2RBbfe+bumds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZT3VH7vpUhrcXbdyGck09jLmKVIbbiUBgWgLbILBLL442TQXZIdwkoqp5SpjL90k6
	 RamtZIKAQEt7QjAG9QtM4OO4nGD7XhQECa6aFBttSzLFegOQjTg1nF2wvtNskj/Eoe
	 E0fqoTjD2GZNGCHkpCsuR07IBkQTW3GfXf5oyXsc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ranjan Kumar <ranjan.kumar@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.10 094/193] scsi: mpt3sas: Fix loop logic
Date: Fri, 24 Nov 2023 17:53:41 +0000
Message-ID: <20231124171951.022786280@linuxfoundation.org>
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

From: Ranjan Kumar <ranjan.kumar@broadcom.com>

commit 3c978492c333f0c08248a8d51cecbe5eb5f617c9 upstream.

The retry loop continues to iterate until the count reaches 30, even after
receiving the correct value. Exit loop when a non-zero value is read.

Fixes: 4ca10f3e3174 ("scsi: mpt3sas: Perform additional retries if doorbell read returns 0")
Cc: stable@vger.kernel.org
Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
Link: https://lore.kernel.org/r/20231020105849.6350-1-ranjan.kumar@broadcom.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -216,8 +216,8 @@ _base_readl_ext_retry(const volatile voi
 
 	for (i = 0 ; i < 30 ; i++) {
 		ret_val = readl(addr);
-		if (ret_val == 0)
-			continue;
+		if (ret_val != 0)
+			break;
 	}
 
 	return ret_val;



