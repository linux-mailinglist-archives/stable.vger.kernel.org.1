Return-Path: <stable+bounces-137434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6587AA134D
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D34E4A550E
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDEE2459C9;
	Tue, 29 Apr 2025 17:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UHQXzI1W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102F521A43D;
	Tue, 29 Apr 2025 17:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946055; cv=none; b=lByxHySniWwS6VFCFQNCnh855zWOijfWjRKsHNO4sZyD2Jy5NUm21p28n8efJ484jKuqRBx1OG3GMb7BYT1QPlwxfo1loiRcI0i0xyWAN5+9xyQGwNkhYvoSALUI7OR+mrCIUVzT13Uw/5lRzaTSu7AVurRufPPH65K1wxb0w+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946055; c=relaxed/simple;
	bh=d/4DJxQSmQvK/teFunDOMt3QG5Oh8BPBkzmiS/Pc/dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZj1MVz/2mh2t0eTvvL9ykDLDhB7h/tgs4BLv8FUS4tPJZD/uqaAwYpHOrbZqyxD8hWmb8YiDp/xB3OSUTYcAAfbwar3lwgt8O4O3kAGk+Sv9pantP9bL+/1wmvQ/1dvrVBxccjnH7Aw/n1CjMrUFAh4RZUDVkfAkrKwDgjCfqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UHQXzI1W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966EDC4CEE3;
	Tue, 29 Apr 2025 17:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745946054;
	bh=d/4DJxQSmQvK/teFunDOMt3QG5Oh8BPBkzmiS/Pc/dw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UHQXzI1W0eZxR5VzYrpJPtXDKw3i61DE8Geb6BHWaEDQh/53H7a1yEP3GnNZy7uz4
	 4iIqnZugIQFUAKFQyc90Ni2NxTxEtNq+Q7tVBxfHvUnBp6mOxFVeb77V+A7vsgKu2x
	 O6Ka66j7knKqBsCIrEZDrVpPKCDAdzjzUylEkkq8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Igor Pylypiv <ipylypiv@google.com>
Subject: [PATCH 6.14 139/311] ata: libata-scsi: Fix ata_mselect_control_ata_feature() return type
Date: Tue, 29 Apr 2025 18:39:36 +0200
Message-ID: <20250429161126.729147667@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161121.011111832@linuxfoundation.org>
References: <20250429161121.011111832@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <dlemoal@kernel.org>

commit db91586b1e8f36122a9e5b8fbced11741488dd22 upstream.

The function ata_mselect_control_ata_feature() has a return type defined
as unsigned int but this function may return negative error codes, which
are correctly propagated up the call chain as integers.

Fix ata_mselect_control_ata_feature() to have the correct int return
type.

While at it, also fix a typo in this function description comment.

Fixes: df60f9c64576 ("scsi: ata: libata: Add ATA feature control sub-page translation")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Igor Pylypiv <ipylypiv@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/libata-scsi.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3886,12 +3886,11 @@ static int ata_mselect_control_spg0(stru
 }
 
 /*
- * Translate MODE SELECT control mode page, sub-pages f2h (ATA feature mode
+ * Translate MODE SELECT control mode page, sub-page f2h (ATA feature mode
  * page) into a SET FEATURES command.
  */
-static unsigned int ata_mselect_control_ata_feature(struct ata_queued_cmd *qc,
-						    const u8 *buf, int len,
-						    u16 *fp)
+static int ata_mselect_control_ata_feature(struct ata_queued_cmd *qc,
+					   const u8 *buf, int len, u16 *fp)
 {
 	struct ata_device *dev = qc->dev;
 	struct ata_taskfile *tf = &qc->tf;



