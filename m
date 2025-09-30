Return-Path: <stable+bounces-182638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D039DBADB70
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 606E21944AE8
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB5E27B328;
	Tue, 30 Sep 2025 15:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="axdOxoiQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66297173;
	Tue, 30 Sep 2025 15:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759245599; cv=none; b=aoTEqLdM59dsrRHj8g7oIqoETd9JVXZnck4Kk6SaFNGGlScjYe2JyAmINT6fD4miZ8JCjluaR23XP5298YVOwzzc/PoYAsW2MkuhGpHrM6xqytNuyNQ3LMtLSl1LTVT0B0efWWWa/HtLcGyR0tBEs46NNoj9qzkRpOohzgFK1mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759245599; c=relaxed/simple;
	bh=QZOm/Y6xOoKp2Qx1q2gB+DOnDPfF/1Pn4shkXYkxeMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MAWAg/qxry7ON6enSUhuzBvdWmGv2f6Ku25FNWFAAMq0mFC9eu1kUysTYc8hBSoOruidt0OCU2lCaQcfW6cJOmEyr/iezWmtLMjwsK94SBhRIqxoQTy3QJ/BHY0eOZo4O/q2bilDMsIcFBob4akrD/1TcRKwkgcHiP8k0Aaf/uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=axdOxoiQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18EDC4CEF0;
	Tue, 30 Sep 2025 15:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759245599;
	bh=QZOm/Y6xOoKp2Qx1q2gB+DOnDPfF/1Pn4shkXYkxeMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=axdOxoiQAjL34EWPe4++C52nqovOwYZE3OqVn7XoPh7dB/DS1gXbIn04E4SeuPVpr
	 Z671e9kjHnPVW+z7FHJMb4q0VNiIT8oYyf9sorAqMc+DLKsfn9jEdbhFNZqqquKKvH
	 E5Il3X/XaovX404xGgQJ1oB4AHdMengngRg1IQA4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 35/73] Bluetooth: hci_sync: Fix hci_resume_advertising_sync
Date: Tue, 30 Sep 2025 16:47:39 +0200
Message-ID: <20250930143822.051292999@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143820.537407601@linuxfoundation.org>
References: <20250930143820.537407601@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 1488af7b8b5f9896ea88ee35aa3301713f72737c ]

hci_resume_advertising_sync is suppose to resume all instance paused by
hci_pause_advertising_sync, this logic is used for procedures are only
allowed when not advertising, but instance 0x00 was not being
re-enabled.

Fixes: ad383c2c65a5 ("Bluetooth: hci_sync: Enable advertising when LL privacy is enabled")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_sync.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a2c3b58db54c2..4c1b2468989a8 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2595,6 +2595,13 @@ static int hci_resume_advertising_sync(struct hci_dev *hdev)
 			hci_remove_ext_adv_instance_sync(hdev, adv->instance,
 							 NULL);
 		}
+
+		/* If current advertising instance is set to instance 0x00
+		 * then we need to re-enable it.
+		 */
+		if (!hdev->cur_adv_instance)
+			err = hci_enable_ext_advertising_sync(hdev,
+							      hdev->cur_adv_instance);
 	} else {
 		/* Schedule for most recent instance to be restarted and begin
 		 * the software rotation loop
-- 
2.51.0




