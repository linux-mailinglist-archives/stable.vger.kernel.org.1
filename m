Return-Path: <stable+bounces-137834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE180AA152D
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D45D717C9F5
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D4424C098;
	Tue, 29 Apr 2025 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="prCdr05+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537A62459EC;
	Tue, 29 Apr 2025 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947273; cv=none; b=GOq7QS2AdhtIFgl8fpWfT+EYsCscUQcY/Jb6igyMolGmu+RBeUuoQlk+QC9DLe4EM/HrIFneZ15AJtYagc1ojO3UHvcnsC2o1iaJT4LOE77M7fhM1pLgGyY7Y6Bet6I70FYS/qaBk5bYmCAfcl4uw4u/snYqEKlMkhtyxSnB+ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947273; c=relaxed/simple;
	bh=wzOUyNSQZGnrWOHo7ZWXmY/JsLZtbyCXCsFbOvbTmTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVGjIJAcT0OM69XBZgFQ5O+pckrospIRrpPqlv2ONEelkIum6odQqg/wifhPspp5z+fgHtuKSjstzJ4TlH+xkwlaBlGid1TZ7JbMzTysWC5LlG/lLWHLpBukPOI67Wom/faWAUQ1uzkeKw9PgYMiTMo/071PexujD1MJg8v+Ffk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=prCdr05+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AA7C4CEE3;
	Tue, 29 Apr 2025 17:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745947272;
	bh=wzOUyNSQZGnrWOHo7ZWXmY/JsLZtbyCXCsFbOvbTmTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=prCdr05+nu0QrbNyziBKUaFPT2/AqcKzOE1lYhQyFO1zdEFcFsTWjoa4rs/FX/XDg
	 P82kLhPiGv6ZnPIrKGVl1gKmOVYTeoNQAuQGbTWT0Lqf9dCgFU8OzoMaimfxei2n+o
	 v30XGrYc+ti0YZznlvy8L9jOpM+sD07UkVT+MCwE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 198/286] media: streamzap: no need for usb pid/vid in device name
Date: Tue, 29 Apr 2025 18:41:42 +0200
Message-ID: <20250429161116.106152256@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161107.848008295@linuxfoundation.org>
References: <20250429161107.848008295@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Young <sean@mess.org>

[ Upstream commit 7a25e6849ad73de5aa01d62da43071bc02b8530c ]

The usb pid/vid can be found elsewhere, the idVendor/idProduct usb sysfs
files for example.

Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: f656cfbc7a29 ("media: streamzap: fix race between device disconnection and urb callback")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/streamzap.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/media/rc/streamzap.c b/drivers/media/rc/streamzap.c
index cd4bb605a7614..b6391ad383143 100644
--- a/drivers/media/rc/streamzap.c
+++ b/drivers/media/rc/streamzap.c
@@ -88,7 +88,6 @@ struct streamzap_ir {
 	ktime_t			signal_start;
 	bool			timeout_enabled;
 
-	char			name[128];
 	char			phys[64];
 };
 
@@ -287,13 +286,10 @@ static struct rc_dev *streamzap_init_rc_dev(struct streamzap_ir *sz)
 		goto out;
 	}
 
-	snprintf(sz->name, sizeof(sz->name), "Streamzap PC Remote Infrared Receiver (%04x:%04x)",
-		 le16_to_cpu(sz->usbdev->descriptor.idVendor),
-		 le16_to_cpu(sz->usbdev->descriptor.idProduct));
 	usb_make_path(sz->usbdev, sz->phys, sizeof(sz->phys));
 	strlcat(sz->phys, "/input0", sizeof(sz->phys));
 
-	rdev->device_name = sz->name;
+	rdev->device_name = "Streamzap PC Remote Infrared Receiver";
 	rdev->input_phys = sz->phys;
 	usb_to_input_id(sz->usbdev, &rdev->input_id);
 	rdev->dev.parent = dev;
-- 
2.39.5




