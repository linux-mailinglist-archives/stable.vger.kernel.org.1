Return-Path: <stable+bounces-133471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2908A925E3
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34B261B615EF
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955691CAA7D;
	Thu, 17 Apr 2025 18:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tme27oJR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503D62571AE;
	Thu, 17 Apr 2025 18:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913178; cv=none; b=EjAtkWkn6mFlEo0LEHTDruK/ck5gwX/nqHTUZX3J296CpX3ZI8JDUqXW5tKgheLZkshUbTuQfsoa0oO6CKtqLCjr2JrbF//ig1IU7b+PfmK6QPIBoeho/Ant4CwoRT8/sM6RJSYx4vUMYot8NWeFv6Ipn/umkJps2sJzuuLHvxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913178; c=relaxed/simple;
	bh=CxZantm5pZkFULvg+aJ1OcTay9XEi1nu/Ralc19JQiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aKEDdp0drTsX5Be7RYrxXX5b+sv6FeXORcb5qYJtqg7V0j6flEnVkT695mcUXSrgU7fDnal2IzeZyigMZnnEPyubksN8FeR4G6BIfqgfdhWouaXIpTeVvX+ByETz2EcCBcnOYLWlbJoItJCf8nWvrlx7ASMpxySmHbhwAlSV+Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tme27oJR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB4FC4CEE4;
	Thu, 17 Apr 2025 18:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744913178;
	bh=CxZantm5pZkFULvg+aJ1OcTay9XEi1nu/Ralc19JQiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tme27oJRvjFB4Yqf9P6TnxePfzUWjP6NI/lzf2W21v+lu/aVLpcU/Dk8GMLyw9Sdx
	 w7Y+SvQtOw7Qqehu/ihWTQg8fssMxbOthrX00giV5Z0d7Uw4LhpREWjnemyOV+TdcA
	 YH4H0JY9ST18trTrrNFInlYzq492wuTzF4k2oarE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.14 252/449] media: i2c: ccs: Set the devices runtime PM status correctly in remove
Date: Thu, 17 Apr 2025 19:49:00 +0200
Message-ID: <20250417175128.139587525@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175117.964400335@linuxfoundation.org>
References: <20250417175117.964400335@linuxfoundation.org>
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

From: Sakari Ailus <sakari.ailus@linux.intel.com>

commit e04604583095faf455b3490b004254a225fd60d4 upstream.

Set the device's runtime PM status to suspended in device removal only if
it wasn't suspended already.

Fixes: 9447082ae666 ("[media] smiapp: Implement power-on and power-off sequences without runtime PM")
Cc: stable@vger.kernel.org # for >= v5.15
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/ccs/ccs-core.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/media/i2c/ccs/ccs-core.c
+++ b/drivers/media/i2c/ccs/ccs-core.c
@@ -3595,9 +3595,10 @@ static void ccs_remove(struct i2c_client
 	v4l2_async_unregister_subdev(subdev);
 
 	pm_runtime_disable(&client->dev);
-	if (!pm_runtime_status_suspended(&client->dev))
+	if (!pm_runtime_status_suspended(&client->dev)) {
 		ccs_power_off(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
+		pm_runtime_set_suspended(&client->dev);
+	}
 
 	for (i = 0; i < sensor->ssds_used; i++)
 		v4l2_device_unregister_subdev(&sensor->ssds[i].sd);



