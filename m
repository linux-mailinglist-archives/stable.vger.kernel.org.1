Return-Path: <stable+bounces-137716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3988EAA1497
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6914A1551
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E79F253331;
	Tue, 29 Apr 2025 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yMAsU3yv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2A22512F3;
	Tue, 29 Apr 2025 17:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946912; cv=none; b=f0YF3Rdyh4GJ+43tRm8QwOowPEDdlq9EQX0r2e4HWp0rp1OB3T0oXlXHpCtRuslG30n/CPWsMmhhs6QyXGxw9SiEBbCidQUKUJxvrbkQPdgICyINFjFZ1/omcbdh5UX735H8mwsyyTQRYake7pEprx0GDL1ICIjsL1tUMATfGiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946912; c=relaxed/simple;
	bh=VA9teisRkhwg+WD612r19zUIHdQkKyHAVUPYnMrIt+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMrQfYwh5lwaphGpVd14fbdhW0koT9OBRUuf3kP+KQJRoGJe3slQIgfmaM4MO43gnMGAgIjy0OdOsgB6IyGmy68q7ePkvejUvi0Btpi7faiomqcfPgk4oMYf9KmepOs9nia1oVKNxBb27qSijWuTKbRmg+YyHag5PHY8rVHubbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yMAsU3yv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE3FC4CEE3;
	Tue, 29 Apr 2025 17:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745946911;
	bh=VA9teisRkhwg+WD612r19zUIHdQkKyHAVUPYnMrIt+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yMAsU3yv089mB806jHboIJC58e3l+c+8dx+GFc1CL4rEmk9teFK21Rj/0Gy5eJ7B5
	 2fz0vZKJKL1qjVbyQK8k8osb9EmTuJgde9fObEknYzXpyfuAgSderOV+vW4cBlz7zD
	 KASfaEV9TQUdtBbnryYWv3qUCITeDjwAsnGgoBbY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 110/286] Bluetooth: hci_event: Fix sending MGMT_EV_DEVICE_FOUND for invalid address
Date: Tue, 29 Apr 2025 18:40:14 +0200
Message-ID: <20250429161112.385107869@linuxfoundation.org>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit eb73b5a9157221f405b4fe32751da84ee46b7a25 ]

This fixes sending MGMT_EV_DEVICE_FOUND for invalid address
(00:00:00:00:00:00) which is a regression introduced by
a2ec905d1e16 ("Bluetooth: fix kernel oops in store_pending_adv_report")
since in the attempt to skip storing data for extended advertisement it
actually made the code to skip the entire if statement supposed to send
MGMT_EV_DEVICE_FOUND without attempting to use the last_addr_adv which
is garanteed to be invalid for extended advertisement since we never
store anything on it.

Link: https://github.com/bluez/bluez/issues/1157
Link: https://github.com/bluez/bluez/issues/1149#issuecomment-2767215658
Fixes: a2ec905d1e16 ("Bluetooth: fix kernel oops in store_pending_adv_report")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_event.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 546795425119b..7f26c1aab9a06 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5644,11 +5644,12 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	 * event or send an immediate device found event if the data
 	 * should not be stored for later.
 	 */
-	if (!ext_adv &&	!has_pending_adv_report(hdev)) {
+	if (!has_pending_adv_report(hdev)) {
 		/* If the report will trigger a SCAN_REQ store it for
 		 * later merging.
 		 */
-		if (type == LE_ADV_IND || type == LE_ADV_SCAN_IND) {
+		if (!ext_adv && (type == LE_ADV_IND ||
+				 type == LE_ADV_SCAN_IND)) {
 			store_pending_adv_report(hdev, bdaddr, bdaddr_type,
 						 rssi, flags, data, len);
 			return;
-- 
2.39.5




