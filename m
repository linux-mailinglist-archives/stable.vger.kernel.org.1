Return-Path: <stable+bounces-111364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B61F4A22ED0
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 15:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C13C1888BA5
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A811BD4F7;
	Thu, 30 Jan 2025 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="luwh5m5Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFE11E8823;
	Thu, 30 Jan 2025 14:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738246523; cv=none; b=j/5XgE5QBMbKiBF+G3/WJZLIu99iQYVK7gNvj1rP1R+rpsUDZMh63XxUIhvFx8+kv2lLlWmkEH1TpZHZa26d2OO1QP9TjX4mwiOGTIceFO5mXJaNNcz7yj6/4HEa+PbUHM/Axw/lE69tAGYyG07PYwdiF5/QEU7cvY00ESwnoVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738246523; c=relaxed/simple;
	bh=pJH7pwcOY8c2WR8LwZMzxzBhEZ7gruMVk4IEQ2So+W4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqHxbutCpkjaJ9NeHK2mSkOvKl/a7Hb/1X1j0ael93G5nxOSN4stixP3i+Sst6ayCkZgFh4/dLGspzbwtzsVDoRSLsbhV4MUCypfaJ+JPYJGfG7h1S81NiYNEX+7s9ITndRSGGzIn+Rak683+2sAdyQN1UKUEHFDuBj6Sy1qR3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=luwh5m5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681FAC4CED2;
	Thu, 30 Jan 2025 14:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738246522;
	bh=pJH7pwcOY8c2WR8LwZMzxzBhEZ7gruMVk4IEQ2So+W4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=luwh5m5ZaGB3WjQCpJCDr8A8ZwjvMt22D7RqMXe62R5hlvvieAmRnPzEZjBhz6O9m
	 5iwQu7RXvqxuTTgt71orNvXvSHQMes1GGjCcz8JHq5WgupaAnSAB6gemxohPxE/ZHR
	 NJwQKTQ6Do4EPwk2dpKJ52e63S8jT8QOlLwjOvD0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Russell Harmon <russ@har.mn>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 08/43] hwmon: (drivetemp) Set scsi command timeout to 10s
Date: Thu, 30 Jan 2025 14:59:15 +0100
Message-ID: <20250130133459.235375156@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130133458.903274626@linuxfoundation.org>
References: <20250130133458.903274626@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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




