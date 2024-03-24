Return-Path: <stable+bounces-30882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF28888E44
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 06:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DF31B219BA
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 04:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F362F7875;
	Mon, 25 Mar 2024 01:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+eWXUE9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318D722619F;
	Sun, 24 Mar 2024 23:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324071; cv=none; b=aA/2OEhb057G/eBgo7SvsxCdvrg+dCnMkAMuZMyztaIf2syUcaEDNEwoKC4gTkIzzzSEpT2Y364JegWAsBywHJYSaHUgi5oVx/Iak+I2ogth95AxE56WnFyhBoWb2/ZfRy9iNv3C/XHsvU2onCwry5mnDxUOTpvi5zza7nMVZEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324071; c=relaxed/simple;
	bh=jXWQSR7sS6JQLyO8fhhXQBOPL95R16ONYnIldPqpWz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCLfau17qxZvZ2d9UhOogQN9npQ1f6rQ4RkzF1ff9jtb2awzqhvJh+DZT0Bim07ZoKzi5IyS7gPtvqqEHQ7vOkqs7X3v8jloJqz0SIJ29i0BafnheQLnZVQ2r3t754D/qPIz+kEmXYhbF6xYenV8Km5RV0UjlDkKRzxMa+nDyLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+eWXUE9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7C0C43394;
	Sun, 24 Mar 2024 23:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324069;
	bh=jXWQSR7sS6JQLyO8fhhXQBOPL95R16ONYnIldPqpWz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H+eWXUE9UfgKkDdPhxzIlIr/9jgKv/FQoTJuGAqGUxKkNIPS60bnGSKjvrsUDVXY7
	 Dy5tTtJdr8706SQ2pUIlqb++4peLyuSnMkAdG9D+bfHSCbma0f9Ofkzm5l4iotIDeA
	 iB/sSETBYTHBjT7sGfe0g/kZ42Wh1teMzfd79GPDMgfYZ8PvTxRWCQ956u3hGCAOus
	 3Is6erSnAv0mpsFXWeFiEKSat7eAkKQAwMzMFAnHfBvt3jlD/cz0OdKbehWT53xX+k
	 MR+RlZSYHtLxrWqUFPehp0B7l3JMXnrKBvWz7LL2KTBzdLY1HcPdX8KQtD0ehhPeFA
	 ca/y+JR9u5EGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 070/183] Bluetooth: hci_core: Fix possible buffer overflow
Date: Sun, 24 Mar 2024 19:44:43 -0400
Message-ID: <20240324234638.1355609-71-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index 289fb28529f8c..c60204b639ab7 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2129,7 +2129,7 @@ int hci_get_dev_info(void __user *arg)
 	else
 		flags = hdev->flags;
 
-	strcpy(di.name, hdev->name);
+	strscpy(di.name, hdev->name, sizeof(di.name));
 	di.bdaddr   = hdev->bdaddr;
 	di.type     = (hdev->bus & 0x0f) | ((hdev->dev_type & 0x03) << 4);
 	di.flags    = flags;
-- 
2.43.0


