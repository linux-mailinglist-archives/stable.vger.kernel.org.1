Return-Path: <stable+bounces-1236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4431E7F7EAE
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 736981C21322
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B27A33CFD;
	Fri, 24 Nov 2023 18:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OZNNUFfB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EAD28DA1;
	Fri, 24 Nov 2023 18:34:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE42C433C7;
	Fri, 24 Nov 2023 18:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850897;
	bh=6P2OJOfYotpUSJsS2Rr8EPpF7SQcwk5snr0LyXK/uw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OZNNUFfBv7oKAH8ftVjJ1QktWObKmgd1IVnGgNAC4UAzQy1lMh9nYcv45cZB79XGn
	 GMlNRU2AotEdcTxBvmR7ck/X4Xpk9xjbN6JkJ7o78ZRHN1J/b/7NWkJQzI+AY6R6XQ
	 LW08GDFmHzLFH0ohNoOOP5Cmy0Q+dIH5DUb3J02U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ranjan Kumar <ranjan.kumar@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.5 233/491] scsi: mpt3sas: Fix loop logic
Date: Fri, 24 Nov 2023 17:47:49 +0000
Message-ID: <20231124172031.560811701@linuxfoundation.org>
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
@@ -223,8 +223,8 @@ _base_readl_ext_retry(const volatile voi
 
 	for (i = 0 ; i < 30 ; i++) {
 		ret_val = readl(addr);
-		if (ret_val == 0)
-			continue;
+		if (ret_val != 0)
+			break;
 	}
 
 	return ret_val;



