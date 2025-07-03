Return-Path: <stable+bounces-159698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E4CAF79F3
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E68001725D8
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4384C2ED143;
	Thu,  3 Jul 2025 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DSAJZd/o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E482E7649;
	Thu,  3 Jul 2025 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555055; cv=none; b=lm/czquih8Nb1eiz+oSQmWZkcTiv87mf1IYOxerq/Z9wkE3dbjXv7Ex91MdBj0TpfOXwidAjdMDJATtz2oUVj/iP6wrFsTZnhVw5oPAw+5FmWTWctV0RDHbKDPArrTklK2GoJAyZqVioXdQn+JGcjjMyzdZHx6kEURv5Avlt/Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555055; c=relaxed/simple;
	bh=jZwSRttJo+UOsKpu1UW3GYzLAFTZwKvHCx47CuenaHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZYf0KzCJmekHrAsTpPWxZZ0H+u4q2pakFH0xSt/24xRQa8oabDxn7XY6gnvGEG/ib+BSo9Ch72VxgOXvDk06EIaqb3eX3uM5J72X8NHXYohTz/6Fi6xNvXZcaU/JPS6CPnR6uAHqBe7r3u/OAicdxoLkDnREwnUn0LNmHynr6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DSAJZd/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762E8C4CEE3;
	Thu,  3 Jul 2025 15:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751555054;
	bh=jZwSRttJo+UOsKpu1UW3GYzLAFTZwKvHCx47CuenaHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DSAJZd/oGT9JgG16aexz7xg1G7D12dzv2kalziSac/A572iGfj3Z7FNon1Qp6JuzB
	 BWplQYd2FWoBdj09aMfJlHHky2LXyPevsEiQ5DQk4UDk+FZ8PtKPGf7GOtBHRi4q3U
	 uJfC0sa0C6w7f/+8zjiA3uOjsfTFuF3fLWsWphOY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Zeitlhofer <thomas.zeitlhofer+lkml@ze-it.at>,
	Ping Cheng <ping.cheng@wacom.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 132/263] HID: wacom: fix crash in wacom_aes_battery_handler()
Date: Thu,  3 Jul 2025 16:40:52 +0200
Message-ID: <20250703144009.658214450@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703144004.276210867@linuxfoundation.org>
References: <20250703144004.276210867@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Zeitlhofer <thomas.zeitlhofer+lkml@ze-it.at>

[ Upstream commit f3054152c12e2eed1e72704aff47b0ea58229584 ]

Commit fd2a9b29dc9c ("HID: wacom: Remove AES power_supply after extended
inactivity") introduced wacom_aes_battery_handler() which is scheduled
as a delayed work (aes_battery_work).

In wacom_remove(), aes_battery_work is not canceled. Consequently, if
the device is removed while aes_battery_work is still pending, then hard
crashes or "Oops: general protection fault..." are experienced when
wacom_aes_battery_handler() is finally called. E.g., this happens with
built-in USB devices after resume from hibernate when aes_battery_work
was still pending at the time of hibernation.

So, take care to cancel aes_battery_work in wacom_remove().

Fixes: fd2a9b29dc9c ("HID: wacom: Remove AES power_supply after extended inactivity")
Signed-off-by: Thomas Zeitlhofer <thomas.zeitlhofer+lkml@ze-it.at>
Acked-by: Ping Cheng <ping.cheng@wacom.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/wacom_sys.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index eaf099b2efdb0..e74c1a4c5b61c 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2901,6 +2901,7 @@ static void wacom_remove(struct hid_device *hdev)
 	hid_hw_stop(hdev);
 
 	cancel_delayed_work_sync(&wacom->init_work);
+	cancel_delayed_work_sync(&wacom->aes_battery_work);
 	cancel_work_sync(&wacom->wireless_work);
 	cancel_work_sync(&wacom->battery_work);
 	cancel_work_sync(&wacom->remote_work);
-- 
2.39.5




