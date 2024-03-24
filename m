Return-Path: <stable+bounces-31935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF948899EA
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 11:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F8BBB3855B
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 10:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038FB2822AD;
	Mon, 25 Mar 2024 03:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+7kqFEB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E0417AF96;
	Sun, 24 Mar 2024 23:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323714; cv=none; b=fvVYG5IKWO1laSnpbikj6DRzX7/9/DVQbfW2NNyqntQc1O3p+jgu6NkbBPKrlNm7kHeLD2cdUPvyhdS3uT4x1LNsNOF5YgyDr1ONYgyjBOu+71xx1tCiGZunKIOvVbsJRiVHBC6+VPRbw3/Z6E/u1yMpOqWCNr4RvDz4PG6RGQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323714; c=relaxed/simple;
	bh=zIHIDGYrNQow1bY9+uueUFMQRpndkPOjwaPDjx2YMEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ky+Oqx44g80sHWZygT7QHLHdFXnwFwvy+5QkjBGWqZFbph/VoqgdH/2mkXuSyTWUf9DSsGrmXeLG4Qbl1zybTb4L8KD5mTT6lFGA0v6rqIYlhHiRF94KRaUGi2IM1x11H4Zwg0HrP/JTRd2lfN2o7fIj2X8MTySSihzOjOiJ0EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+7kqFEB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7967EC433F1;
	Sun, 24 Mar 2024 23:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323714;
	bh=zIHIDGYrNQow1bY9+uueUFMQRpndkPOjwaPDjx2YMEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a+7kqFEBdAp67vwgqEq1Akidu/W0XrmgOvrVL6R6vfjEDS88rGjqu4zxti15fNYRB
	 8a7K+D0ak3h3+vH4SUX/ZR4OUhyX6Jwd6QtiA6RSN+FwKFB+g1EGa7UMgdAWKA5Mzd
	 NBS6+UyMCxrQKKWE/HO6AHpEoWJQ+4T0P6tzAId49MBDgF5RLrIGJy9FhzrQoJxIcB
	 RYf+0FmTpsWrdzjLmdjtMHquP3kgAjLT8h1hfFHDgkTaDtpl+Wn4Wl81mHgqFbXr9P
	 OBl9iOAobosBw6qDUjFQ0D9nkgNT2y31WqeazzSa5R+6He98TdzYvYa9ErJ1Rn9FRv
	 J2wYh3QKuCB8g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 087/238] Bluetooth: hci_core: Fix possible buffer overflow
Date: Sun, 24 Mar 2024 19:37:55 -0400
Message-ID: <20240324234027.1354210-88-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 81137162bfaa7278785b24c1fd2e9e74f082e8e4 ]

struct hci_dev_info has a fixed size name[8] field so in the event that
hdev->name is bigger than that strcpy would attempt to write past its
size, so this fixes this problem by switching to use strscpy.

Fixes: dcda165706b9 ("Bluetooth: hci_core: Fix build warnings")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5f1fbf86e0ceb..b9cf5bc9364c1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2175,7 +2175,7 @@ int hci_get_dev_info(void __user *arg)
 	else
 		flags = hdev->flags;
 
-	strcpy(di.name, hdev->name);
+	strscpy(di.name, hdev->name, sizeof(di.name));
 	di.bdaddr   = hdev->bdaddr;
 	di.type     = (hdev->bus & 0x0f) | ((hdev->dev_type & 0x03) << 4);
 	di.flags    = flags;
-- 
2.43.0


