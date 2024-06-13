Return-Path: <stable+bounces-52038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F31139072E1
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98A80B20FD3
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2182566;
	Thu, 13 Jun 2024 12:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RVkZlsfm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC096A59;
	Thu, 13 Jun 2024 12:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718283052; cv=none; b=px1odFaALmhKRXOCh6RAIam63TfEdZVRH+TsRtITxI/lMV18ie6siQyT0fME1l7+kaHG4cT/fLatd66padYXl4eGe9EQ9y5FbRXE0XoXmM+kG+udzxjI95YN0nUbD0fQl0gcC/kp9VqbfOqdQIUBfmlEjvTgxwyipTM1RqQBHKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718283052; c=relaxed/simple;
	bh=TMCTxcLRmb9vhKT8KP57swlb6wHpSwQaKrKbaiTv2xU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LtTI2WZ5m2qurTd172ay5uiuzlYlexMQa+fJJ7xV/W2a6FWtZ4QBkMuIk97LmlRclhp/oMHVZFCKOXwuZ0Hhe+pbEnlp/jz6jKPqhc2TS5icxZdZUaf9o2RbGpyry8hFfGxBz3BAxKdfD0KZ9c3rk068+5Yx1xoeSHJV50xuh8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RVkZlsfm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73381C2BBFC;
	Thu, 13 Jun 2024 12:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718283051;
	bh=TMCTxcLRmb9vhKT8KP57swlb6wHpSwQaKrKbaiTv2xU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RVkZlsfmN/40VAYywjN3xz6XRJumFmzQi6wwKPuiJ0/QgdTCYtDd/MBwoZ3brY71n
	 Q9wOF6PLooYMDt/u4Y5R5Ie3MUes+Df8kimWHafe00bfls/eLXn4k1esjEH/hcz1Zg
	 mc9jFunkOpILPTlW78B69resstc/86QgqkwAHlzw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Schneider <pschneider1968@googlemail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.1 55/85] scsi: core: Handle devices which return an unusually large VPD page count
Date: Thu, 13 Jun 2024 13:35:53 +0200
Message-ID: <20240613113216.262781939@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113214.134806994@linuxfoundation.org>
References: <20240613113214.134806994@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin K. Petersen <martin.petersen@oracle.com>

commit d09c05aa35909adb7d29f92f0cd79fdcd1338ef0 upstream.

Peter Schneider reported that a system would no longer boot after
updating to 6.8.4.  Peter bisected the issue and identified commit
b5fc07a5fb56 ("scsi: core: Consult supported VPD page list prior to
fetching page") as being the culprit.

Turns out the enclosure device in Peter's system reports a byteswapped
page length for VPD page 0. It reports "02 00" as page length instead
of "00 02". This causes us to attempt to access 516 bytes (page length
+ header) of information despite only 2 pages being present.

Limit the page search scope to the size of our VPD buffer to guard
against devices returning a larger page count than requested.

Link: https://lore.kernel.org/r/20240521023040.2703884-1-martin.petersen@oracle.com
Fixes: b5fc07a5fb56 ("scsi: core: Consult supported VPD page list prior to fetching page")
Cc: stable@vger.kernel.org
Reported-by: Peter Schneider <pschneider1968@googlemail.com>
Closes: https://lore.kernel.org/all/eec6ebbf-061b-4a7b-96dc-ea748aa4d035@googlemail.com/
Tested-by: Peter Schneider <pschneider1968@googlemail.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/scsi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 3e0c0381277a..f0464db3f9de 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -350,6 +350,13 @@ static int scsi_get_vpd_size(struct scsi_device *sdev, u8 page)
 		if (result < SCSI_VPD_HEADER_SIZE)
 			return 0;
 
+		if (result > sizeof(vpd)) {
+			dev_warn_once(&sdev->sdev_gendev,
+				      "%s: long VPD page 0 length: %d bytes\n",
+				      __func__, result);
+			result = sizeof(vpd);
+		}
+
 		result -= SCSI_VPD_HEADER_SIZE;
 		if (!memchr(&vpd[SCSI_VPD_HEADER_SIZE], page, result))
 			return 0;
-- 
2.45.2




