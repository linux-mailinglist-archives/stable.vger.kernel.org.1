Return-Path: <stable+bounces-3467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9BB7FF5C8
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 17:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65621281845
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 16:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD89354FB5;
	Thu, 30 Nov 2023 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yJ4/UEk/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7312A54F9C;
	Thu, 30 Nov 2023 16:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35E3C433C8;
	Thu, 30 Nov 2023 16:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701361908;
	bh=D2FBmdqzKLwJA67Fyv6msNKZ8gjftjkA7h7e2vbxCSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yJ4/UEk/jfvBhvy0rWFccCf0xdp3VWzPATD1krDJvR3KL0JLOw/jmP9CQc7q2d0bt
	 KK/R6ASI1BMngUz5f68EoFZC5xA//0p1Q3wj+IRFv2SMsHP08mCbYNkT/6IthcMkLI
	 y2EIXWT3JdTvCNjx71OsTGp09MjDjIxoNO0VY9xQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 11/69] HID: core: store the unique system identifier in hid_device
Date: Thu, 30 Nov 2023 16:22:08 +0000
Message-ID: <20231130162133.448814354@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130162133.035359406@linuxfoundation.org>
References: <20231130162133.035359406@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

[ Upstream commit 1e839143d674603b0bbbc4c513bca35404967dbc ]

This unique identifier is currently used only for ensuring uniqueness in
sysfs. However, this could be handful for userspace to refer to a specific
hid_device by this id.

2 use cases are in my mind: LEDs (and their naming convention), and
HID-BPF.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Link: https://lore.kernel.org/r/20220902132938.2409206-9-benjamin.tissoires@redhat.com
Stable-dep-of: fc43e9c857b7 ("HID: fix HID device resource race between HID core and debugging support")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-core.c | 4 +++-
 include/linux/hid.h    | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index d941023c56289..35046adf1294e 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2442,10 +2442,12 @@ int hid_add_device(struct hid_device *hdev)
 			hid_warn(hdev, "bad device descriptor (%d)\n", ret);
 	}
 
+	hdev->id = atomic_inc_return(&id);
+
 	/* XXX hack, any other cleaner solution after the driver core
 	 * is converted to allow more than 20 bytes as the device name? */
 	dev_set_name(&hdev->dev, "%04X:%04X:%04X.%04X", hdev->bus,
-		     hdev->vendor, hdev->product, atomic_inc_return(&id));
+		     hdev->vendor, hdev->product, hdev->id);
 
 	hid_debug_register(hdev, dev_name(&hdev->dev));
 	ret = device_add(&hdev->dev);
diff --git a/include/linux/hid.h b/include/linux/hid.h
index c3478e396829e..4fa40d2e821f2 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -630,6 +630,8 @@ struct hid_device {							/* device report descriptor */
 	struct list_head debug_list;
 	spinlock_t  debug_list_lock;
 	wait_queue_head_t debug_wait;
+
+	unsigned int id;						/* system unique id */
 };
 
 #define to_hid_device(pdev) \
-- 
2.42.0




