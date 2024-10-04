Return-Path: <stable+bounces-80832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A0F990B98
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0720283659
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483311E1C29;
	Fri,  4 Oct 2024 18:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4EYjACw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B271E1C20;
	Fri,  4 Oct 2024 18:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066010; cv=none; b=LOZFWkxcABaxTDsRZSJ7sqLOuRf3XJJgts0/gslyP6MxG7Pilv0sWCpk5bomsliZ86tz8rwqM8tOKG3bQTFHRrGHXKREi3QWc83czOS6vMX6qa8t/lWaeIzWnpm8aZ6bmeEkPo6zgmQwLFbKJg8BCqCUa+QBxZTNxqM8VpVc35k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066010; c=relaxed/simple;
	bh=SHf+bK/2ObzYGK3breeU0r/zaC2KGvNfsghL/Yktxz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDU6KCSlWfkemb4q6QLY+2Cw6UYU127x5d13/+ddjfqQyLiSCgfWiWB31FHIUlTwcxRkD33k5T9/SnNdPs//0g/y1haEzN29goex8JS1W9nN29BUy9kQwauf8gTFn/nYC6V4iwxBybNsNBo4yVvDgMZRG86YM/pnYTs6diE92Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4EYjACw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78218C4CECC;
	Fri,  4 Oct 2024 18:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066009;
	bh=SHf+bK/2ObzYGK3breeU0r/zaC2KGvNfsghL/Yktxz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h4EYjACwSxr15+ku0Nn46jzivsK6bc+k318tcJlOQ9WmLZeQ+OsM+nnhGxOMUJ/dY
	 xFs0S3HZROYlQF/OnvryfjZwjkbXOu7iyzONg/9o+32XbuOzMAj80DsFRjX0Gznt4C
	 2+morXlGod/NivwH/atE8dgK8rk9k83TV9FVZB6gpGtqPZhZI4H6DHnHkfaNQxbTY7
	 yZz7TBSFCDLNT9Rgt2LoMqhdj+vEgeFcFa4ViToMRsxV1sUNMV6psJDrvEoxXkgZ2Q
	 8BRmuv593/wxnVGSjBB1RIEoYw6we1hdIuUO7Rk0jbVrV51/eooslFd59BIAx5jbL7
	 K3Ii8EfUGTl8A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	dmitry.baryshkov@linaro.org,
	lk@c--e.de,
	bleung@chromium.org,
	jthies@google.com,
	diogo.ivo@tecnico.ulisboa.pt,
	pooja.katiyar@intel.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 52/76] usb: typec: ucsi: Don't truncate the reads
Date: Fri,  4 Oct 2024 14:17:09 -0400
Message-ID: <20241004181828.3669209-52-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
Content-Transfer-Encoding: 8bit

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

[ Upstream commit 1d05c382ddb4e43ce251a50f308df5e42a2f6088 ]

That may silently corrupt the data. Instead, failing attempts
to read more than the interface can handle.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Link: https://lore.kernel.org/r/20240816135859.3499351-3-heikki.krogerus@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 8 ++------
 drivers/usb/typec/ucsi/ucsi.h | 2 ++
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 17155ed17fdf8..a8aeda77b1b6b 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -99,12 +99,8 @@ static int ucsi_run_command(struct ucsi *ucsi, u64 command, u32 *cci,
 
 	*cci = 0;
 
-	/*
-	 * Below UCSI 2.0, MESSAGE_IN was limited to 16 bytes. Truncate the
-	 * reads here.
-	 */
-	if (ucsi->version <= UCSI_VERSION_1_2)
-		size = clamp(size, 0, 16);
+	if (size > UCSI_MAX_DATA_LENGTH(ucsi))
+		return -EINVAL;
 
 	ret = ucsi->ops->sync_control(ucsi, command);
 	if (ret)
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 5a3481d36d7ab..db90b513f78a8 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -435,6 +435,8 @@ struct ucsi {
 #define UCSI_DELAY_DEVICE_PDOS	BIT(1)	/* Reading PDOs fails until the parter is in PD mode */
 };
 
+#define UCSI_MAX_DATA_LENGTH(u) (((u)->version < UCSI_VERSION_2_0) ? 0x10 : 0xff)
+
 #define UCSI_MAX_SVID		5
 #define UCSI_MAX_ALTMODES	(UCSI_MAX_SVID * 6)
 
-- 
2.43.0


