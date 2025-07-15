Return-Path: <stable+bounces-162694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE67B05F9B
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 16:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A51F21C45AA8
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1472E3AE5;
	Tue, 15 Jul 2025 13:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2o0/woaI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DEA2E498D;
	Tue, 15 Jul 2025 13:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587229; cv=none; b=O6xRQDo07Ptq4qDJoxjwjKAdSs5NLCamEZTJAOdHqymORUxOrQKx7BZnWFjDS6F69rGGHWvBrRAbDfPICt6s67YiEWXClkGoZy6r7jM1JuhIicFqHbiB0zNgEezOSExKebO6iCaGGpfi4RHLkYQx1IIaqh7qT0bKmcSGJ2OUbtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587229; c=relaxed/simple;
	bh=VHQBAqAfiYbRUTjmTbQjjQl/GFaijqNiqKw3znw1FXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HtvUbUWTaw70OrI6J474/izGz5yRAi6kzRv/IZtMIJC2jGzzYJJVzzaF4gZJMPrlEnE6Tc54yIrB+6Obt9T/lSiX/BL7M6HYf1rZ/LM65ih2kGYAnyW9d0GGg6OfFhDqjeT5rIBhjZNhrJiXed8SVfDG8TcSWGHeve04c4HjZhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2o0/woaI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B85C4CEE3;
	Tue, 15 Jul 2025 13:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752587229;
	bh=VHQBAqAfiYbRUTjmTbQjjQl/GFaijqNiqKw3znw1FXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2o0/woaIhZzPx3KtAxQ4ZixinQNPfWPKP7ApmWd97J+UsjmcBEq2RB8JN3hvMCSx7
	 1BkqHIfs9B32D/JRRkKURFncTcvm9ck1el7arMsmL9XgrKrDFDcg4c2L7S5n9Ttwwc
	 X4HxTffCitX/YB6nSWxRSohvJ/AtThRsYIwRBdC8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 05/88] Bluetooth: hci_sync: Fix not disabling advertising instance
Date: Tue, 15 Jul 2025 15:13:41 +0200
Message-ID: <20250715130754.721155236@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130754.497128560@linuxfoundation.org>
References: <20250715130754.497128560@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit ef9675b0ef030d135413e8638989f3a7d1f3217a ]

As the code comments on hci_setup_ext_adv_instance_sync suggests the
advertising instance needs to be disabled in order to update its
parameters, but it was wrongly checking that !adv->pending.

Fixes: cba6b758711c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 2")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index c1e018eaa6f4c..7d22b2b02745a 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1204,7 +1204,7 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 	 * Command Disallowed error, so we must first disable the
 	 * instance if it is active.
 	 */
-	if (adv && !adv->pending) {
+	if (adv) {
 		err = hci_disable_ext_adv_instance_sync(hdev, instance);
 		if (err)
 			return err;
-- 
2.39.5




