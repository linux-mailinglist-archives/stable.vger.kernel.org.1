Return-Path: <stable+bounces-190059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E01C0FABD
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 18:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 93FA734FCE9
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 17:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885A13176EE;
	Mon, 27 Oct 2025 17:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rx5mjrJz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461DD3176E3
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 17:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586353; cv=none; b=JxEoBbJEMimZlj/gl5O+i3vYltlh9TSM14hovFrOljQ7s35NBIgJ1kQVSd9JSvIwXKMzz/H5wIOy4R2pJBQ7FYbphgmwv0Zqi3lqJxmTOSZtCI0uZ9hYVBVFhmBHgx9BLLyroPAqFPbHSL3aKI9q+OJTqO0NXxGh+g7E/RjKx8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586353; c=relaxed/simple;
	bh=ThDDN49hubCs6tOgnnx2SFA3yS9UT22iylhuRKfhU6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JpVfii9aRzHcAq1bAzBk/Gc2LLqcUskou8UCokghMRN9BQDvBHaQQK2+g9H8K2z0oNbf7pNNc60jewbXnUBVuJSorCeYE0n4S5+RJfwnh3ERI4Ap66dGFb5ILO/+lbbGrOUQ18c1sYH2cH22aoVctLgHeXW+mvINFTYHI+54h58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rx5mjrJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290D5C113D0;
	Mon, 27 Oct 2025 17:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761586351;
	bh=ThDDN49hubCs6tOgnnx2SFA3yS9UT22iylhuRKfhU6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rx5mjrJzRK1KI00ti4mfBWP5dLvd9F4LxsVNq/S5Xl8XxYEvaZ1uNs2g6z5f1DprC
	 pzun2chvt15ZSPFE8JiFfVIkDdqJgfOaC7UlbtTaBFUNj8lOxo5f5AHdoZmE2CzGS/
	 DPn5xhC2S+5Kvve7OONqyubKLhUxlErvAbPwIaq0U5AsycVb4So+usZ9Hbcx7ZHmtF
	 vUL81k0tCCNx8TGGiHnTqwBZhxg8RIC15Kp7kGQZixg6Ucn8fWpd4k8GdGjAQwmzPP
	 caNJzbWS0m120Lo9WZ4dKU4xvFvwTO0fV6zOxOtxPIXq9AvX6o+qm1jhX6MQOncn+e
	 UTTj3HejVbb4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	=?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/6] xhci: dbc: Improve performance by removing delay in transfer event polling.
Date: Mon, 27 Oct 2025 13:32:24 -0400
Message-ID: <20251027173226.609057-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027173226.609057-1-sashal@kernel.org>
References: <2025102713-cucumber-persevere-aa50@gregkh>
 <20251027173226.609057-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mathias Nyman <mathias.nyman@linux.intel.com>

[ Upstream commit 03e3d9c2bd85cda941b3cf78e895c1498ac05c5f ]

Queue event polling work with 0 delay in case there are pending transfers
queued up. This is part 2 of a 3 part series that roughly triples dbc
performace when using adb push and pull over dbc.

Max/min push rate after patches is 210/118 MB/s, pull rate 171/133 MB/s,
tested with large files (300MB-9GB) by Łukasz Bartosik

First performance improvement patch was commit 31128e7492dc
("xhci: dbc: add dbgtty request to end of list once it completes")

Cc: Łukasz Bartosik <ukaszb@chromium.org>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20241227120142.1035206-2-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: f3d12ec847b9 ("xhci: dbc: fix bogus 1024 byte prefix if ttyDBC read races with stall event")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-dbgcap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index 643afd3ab0988..177382632614e 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -987,7 +987,7 @@ static void xhci_dbc_handle_events(struct work_struct *work)
 		/* set fast poll rate if there are pending data transfers */
 		if (!list_empty(&dbc->eps[BULK_OUT].list_pending) ||
 		    !list_empty(&dbc->eps[BULK_IN].list_pending))
-			poll_interval = 1;
+			poll_interval = 0;
 		break;
 	default:
 		dev_info(dbc->dev, "stop handling dbc events\n");
-- 
2.51.0


