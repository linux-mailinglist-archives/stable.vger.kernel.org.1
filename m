Return-Path: <stable+bounces-177041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FA5B402DD
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 15:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BECA4E4C92
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CB030507B;
	Tue,  2 Sep 2025 13:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XF8sugDk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9F93043BD;
	Tue,  2 Sep 2025 13:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819378; cv=none; b=ZdGSmRO6vdXLJBvI5aI2Af7H+dUi0+DeKQL0Cxaev5Nm22cM1J7Vol78UQex1uw0L6Gby3TeYwLmmGd7Y2emjDZ3+MVX5nln0Hq9LWBUPyCcRQ3hQHeclPWNao6/8UQkyT4f5iJBf6kPf/K9p6awdfld553CkMe47UeBwXVKPII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819378; c=relaxed/simple;
	bh=Uvow1/4593h13EfEeWGS5xsny0vKtRUwM3yEg7EFZ7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AJWjd6x/dKjWR8V1Bj9crtC2vDkiwUVRfR6E6lvGYo+0Zpurrn0RJ7hZEv9aQE2LGhFPM5JeHp7SiIK09PpXLpLD45mPcG3BFwpCswH7eQuWxJLU9Z7wI4XPkMMdRR7RHP6pgdIr/09P4EoHz6hmDeNRoI7CN12Q0A+v03uA0AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XF8sugDk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E92C4CEED;
	Tue,  2 Sep 2025 13:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756819378;
	bh=Uvow1/4593h13EfEeWGS5xsny0vKtRUwM3yEg7EFZ7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XF8sugDkm74bK7CDITMwiZpPEXMjJkjzd7dirW2y/87XPTzEnOpiOSpkzfek8FBT1
	 tP/TgHkwm15RLVAAoUDEtVgFYXvVvrp/O89a45kxwKXNgwNV21Slw+OjKXdS8hraLG
	 KU1oQY4HW1olCCq1KPx9ofjn7F63Rki+wAdJjE2k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Damien Le Moal <dlemoal@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	Johannes Thumshin <johannes.thumshirn@wdc.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 017/142] scsi: core: sysfs: Correct sysfs attributes access rights
Date: Tue,  2 Sep 2025 15:18:39 +0200
Message-ID: <20250902131948.811662246@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131948.154194162@linuxfoundation.org>
References: <20250902131948.154194162@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <dlemoal@kernel.org>

[ Upstream commit a2f54ff15c3bdc0132e20aae041607e2320dbd73 ]

The SCSI sysfs attributes "supported_mode" and "active_mode" do not
define a store method and thus cannot be modified.  Correct the
DEVICE_ATTR() call for these two attributes to not include S_IWUSR to
allow write access as they are read-only.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Link: https://lore.kernel.org/r/20250728041700.76660-1-dlemoal@kernel.org
Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Johannes Thumshin <johannes.thumshirn@wdc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index d772258e29ad2..e6464b9989609 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -265,7 +265,7 @@ show_shost_supported_mode(struct device *dev, struct device_attribute *attr,
 	return show_shost_mode(supported_mode, buf);
 }
 
-static DEVICE_ATTR(supported_mode, S_IRUGO | S_IWUSR, show_shost_supported_mode, NULL);
+static DEVICE_ATTR(supported_mode, S_IRUGO, show_shost_supported_mode, NULL);
 
 static ssize_t
 show_shost_active_mode(struct device *dev,
@@ -279,7 +279,7 @@ show_shost_active_mode(struct device *dev,
 		return show_shost_mode(shost->active_mode, buf);
 }
 
-static DEVICE_ATTR(active_mode, S_IRUGO | S_IWUSR, show_shost_active_mode, NULL);
+static DEVICE_ATTR(active_mode, S_IRUGO, show_shost_active_mode, NULL);
 
 static int check_reset_type(const char *str)
 {
-- 
2.50.1




