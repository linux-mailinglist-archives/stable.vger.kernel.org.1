Return-Path: <stable+bounces-111313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FD4A22E6A
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 15:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AD771688FA
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270531E3DF8;
	Thu, 30 Jan 2025 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QglLPuJ3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D766D1E3775;
	Thu, 30 Jan 2025 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738245647; cv=none; b=i+aroD3zmdkpz9ezrBlQ8LV0oBIbXtqltZIbI3R04CiYsHwK1GqIHkxJsp1bskbs9TPH8skTJnDt7g8N2b5nshz14SF1OEnT4siFKTwNmpGiooUZ16KMnYX0P9UPgnYsxgzMPC6ZuVpr6MQWj/Qe2bjqZFBVXjHeqjRElZBanZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738245647; c=relaxed/simple;
	bh=zW7mPTSc0wXYZXreDAnpxrgrmSR8P0R+XEH4gtc+Vso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5f8kCnkupiNne+4P/UFBjFLtchgC1LRm0degr60zLWT+k6RUmsoPEW/dOeFGcPadiE/hN1z6HlR4AU5yM4bch61OQnXVvwXx9JTBAfiPdqDYh5JPx4WrxC/ckXyOtNRgHQa22MruRimbG5kHe4S7dGuwT0RYwlMZY2l0tAU7mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QglLPuJ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605D2C4CED2;
	Thu, 30 Jan 2025 14:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738245647;
	bh=zW7mPTSc0wXYZXreDAnpxrgrmSR8P0R+XEH4gtc+Vso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QglLPuJ3HrsRL3zVu3JukqkjDVpaXFw8zZIItWyJBl8k/xUfuPKENAJyVKwaCRaJd
	 0+PoVF9gWGfQRXOfE3TlzZc5MnsODEZy9i9gKOi9x6NJwnvVe0whelpSkwvew0T4Wv
	 /HbkrRFDdDXuLSrdLMrNpb7VA6yJPEWyHcWXEppc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Russell Harmon <russ@har.mn>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 13/40] hwmon: (drivetemp) Set scsi command timeout to 10s
Date: Thu, 30 Jan 2025 14:59:13 +0100
Message-ID: <20250130133500.241310238@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130133459.700273275@linuxfoundation.org>
References: <20250130133459.700273275@linuxfoundation.org>
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

From: Russell Harmon <russ@har.mn>

[ Upstream commit b46ba47d7bb461a0969317be1f2e165c0571d6c5 ]

There's at least one drive (MaxDigitalData OOS14000G) such that if it
receives a large amount of I/O while entering an idle power state will
first exit idle before responding, including causing SMART temperature
requests to be delayed.

This causes the drivetemp request to exceed its timeout of 1 second.

Signed-off-by: Russell Harmon <russ@har.mn>
Link: https://lore.kernel.org/r/20250115131340.3178988-1-russ@har.mn
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/drivetemp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/drivetemp.c b/drivers/hwmon/drivetemp.c
index 2a4ec55ddb47e..291d91f686467 100644
--- a/drivers/hwmon/drivetemp.c
+++ b/drivers/hwmon/drivetemp.c
@@ -194,7 +194,7 @@ static int drivetemp_scsi_command(struct drivetemp_data *st,
 	scsi_cmd[14] = ata_command;
 
 	err = scsi_execute_cmd(st->sdev, scsi_cmd, op, st->smartdata,
-			       ATA_SECT_SIZE, HZ, 5, NULL);
+			       ATA_SECT_SIZE, 10 * HZ, 5, NULL);
 	if (err > 0)
 		err = -EIO;
 	return err;
-- 
2.39.5




