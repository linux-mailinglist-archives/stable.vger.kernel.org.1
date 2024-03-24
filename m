Return-Path: <stable+bounces-31122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC68889AC6
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 11:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E80122A488B
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 10:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2698A1E0654;
	Mon, 25 Mar 2024 02:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nz4/UpRH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7025C768E1;
	Sun, 24 Mar 2024 22:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320461; cv=none; b=lHdsgU8YIazJmh0jjDmXyVc8cj6mELlMkbbXpJNOCxWgLvRpKIMpDBLswSZ1YcvCXJLx60f+PWD9Ca7ZQKE/CNEZqXfSx3bTIkKqdhqX4DDwKtXFhz9kPHpDDhTfrSav0wbFqVCS0b0/thPKuiozI3R0HBIw3Vm3DMOfAFUsHeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320461; c=relaxed/simple;
	bh=cR0HqTUaknLkPLTFIwauFtbbMFpsVGfj/+7sGvCDCjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ppJhQZQxN8Lmk4tdaHIPg5+knEXyDQcKX6MiI1xiG+hAuZT3waLqZ0hvKB4VbOZCD+PRyaCAFsaDP58EXSyql3kRhRwAjCof/UemK4H6YKJppj3ktqNoL2Wv+AKDVEvIjy9nXggPLn02MNlnVP++w8TAEF6YQz2qalpUOwy2Tfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nz4/UpRH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11B1C433B1;
	Sun, 24 Mar 2024 22:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320461;
	bh=cR0HqTUaknLkPLTFIwauFtbbMFpsVGfj/+7sGvCDCjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nz4/UpRHpvalfwieQJBzu9reZseqWzeSIKCGnJVVniGT5CKAuKAMwcyD6hnjlKMpk
	 LETJ5sLLMEcYYihQts6zt0ADOpE1/0/idgnV5L65v+s4SETXamesT6ODKVSlb2gmPU
	 FbdkS9deF3H2h/sEuOoqVoaiCotGR8AHYCTB1c4EEYY9NpeplTXAzQxao6WiGxrlBR
	 q6kpZIg6TqVXSxeUk9Aj0mNv4ez2zzrDSdThMlOAp3ewoBus2J5WvAmFNlSIBBSy/F
	 Q3d/OwnrxeE9bWxCc6tvlDqENB+8x3cO00NsKZGOsowtHMPKTHDx84Cpn3Uc5hbhey
	 61C/4YBCdJlIw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Manuel Fombuena <fombuena@outlook.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 020/713] HID: multitouch: Add required quirk for Synaptics 0xcddc device
Date: Sun, 24 Mar 2024 18:35:46 -0400
Message-ID: <20240324224720.1345309-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Manuel Fombuena <fombuena@outlook.com>

[ Upstream commit 1741a8269e1c51fa08d4bfdf34667387a6eb10ec ]

Add support for the pointing stick (Accupoint) and 2 mouse buttons.

Present on some Toshiba/dynabook Portege X30 and X40 laptops.

It should close https://bugzilla.kernel.org/show_bug.cgi?id=205817

Signed-off-by: Manuel Fombuena <fombuena@outlook.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-multitouch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index fd5b0637dad68..3e91e4d6ba6fa 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2151,6 +2151,10 @@ static const struct hid_device_id mt_devices[] = {
 		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
 			USB_VENDOR_ID_SYNAPTICS, 0xcd7e) },
 
+	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
+		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
+			USB_VENDOR_ID_SYNAPTICS, 0xcddc) },
+
 	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
 		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
 			USB_VENDOR_ID_SYNAPTICS, 0xce08) },
-- 
2.43.0


