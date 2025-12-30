Return-Path: <stable+bounces-204230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E081CEA035
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 16:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F3F5307DBC0
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 15:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948AD320A23;
	Tue, 30 Dec 2025 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPubCYNG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B2E31ED95
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767106465; cv=none; b=LivV0HKKrEbLyyRcJ7J6oQu15kh7+OM8rLfuC6fife/XDJxpD+oHmlo02YxZwEfaDPZgkozqkf8hYyTnCOeo/VM0LiBlmQhpQqdpQ1m37C+eXkePsSViNtnGdlu4quXdK/HA7Qbj6n0qU7aRLa84wE2jkJM/yTbZ5pu8InTRVDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767106465; c=relaxed/simple;
	bh=H9TcChkGMtncXRM8dtVdz1/mCleKYJvc5lmjT3kTvbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZzHOo5Sq2ZsONc7JiB3smRmTI/N1dkppqwcggsOJHdm051cb7mo35AEbbeErijpHqqWG8SEHG8UQv24XV6CVZaf0CaveCeuopJXmtJAQiHUw3wyyhKnw3EWc5pLHlDD5hlOUbo0U94bVUQerbXE2O/n5gbWWkR5XfzxtTE7xgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPubCYNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B24C4CEFB;
	Tue, 30 Dec 2025 14:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767106464;
	bh=H9TcChkGMtncXRM8dtVdz1/mCleKYJvc5lmjT3kTvbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JPubCYNGb4KjCgG4VArFQ4SoRdUcwQqMaZS70+1QfeLgIngfQbTDT5db1tOFnuQJJ
	 1qFFGTsf6Mj3SRiCJoO//WNNcdUok5jKymtJCsyd/GeQtTUZdLZYTsOmO6WhmN/cQ7
	 yx01kOxiA+uy6qWXuSnHs2eyCo3i1tdT+nH6FznkibHLiQ/2D/IxKtbjNns9cyaiAq
	 SL/3FfWL9USbKUgqs2lC02WE/ScyfXqTB2vXOovnGUXB2nXzuNxzgi/E8HVc4Vj5tz
	 CafPA1cYzaWA95WH0DFDdXd8gNwy4Piaz/abLII+xmsM+LULB/oQnb+21Myycm6/Su
	 1Ru6gscoHq6vg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Udipto Goswami <udipto.goswami@oss.qualcomm.com>,
	stable <stable@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] usb: dwc3: keep susphy enabled during exit to avoid controller faults
Date: Tue, 30 Dec 2025 09:54:19 -0500
Message-ID: <20251230145419.2259989-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122911-secrecy-pedometer-eaa0@gregkh>
References: <2025122911-secrecy-pedometer-eaa0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Udipto Goswami <udipto.goswami@oss.qualcomm.com>

[ Upstream commit e1003aa7ec9eccdde4c926bd64ef42816ad55f25 ]

On some platforms, switching USB roles from host to device can trigger
controller faults due to premature PHY power-down. This occurs when the
PHY is disabled too early during teardown, causing synchronization
issues between the PHY and controller.

Keep susphy enabled during dwc3_host_exit() and dwc3_gadget_exit()
ensures the PHY remains in a low-power state capable of handling
required commands during role switch.

Cc: stable <stable@kernel.org>
Fixes: 6d735722063a ("usb: dwc3: core: Prevent phy suspend during init")
Suggested-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Udipto Goswami <udipto.goswami@oss.qualcomm.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://patch.msgid.link/20251126054221.120638-1-udipto.goswami@oss.qualcomm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/gadget.c | 2 +-
 drivers/usb/dwc3/host.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 4ccda324966e..42dca9a70f7d 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4646,7 +4646,7 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 	if (!dwc->gadget)
 		return;
 
-	dwc3_enable_susphy(dwc, false);
+	dwc3_enable_susphy(dwc, true);
 	usb_del_gadget(dwc->gadget);
 	dwc3_gadget_free_endpoints(dwc);
 	usb_put_gadget(dwc->gadget);
diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index c0dba453f1b8..5a5e51f6148b 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -162,7 +162,7 @@ int dwc3_host_init(struct dwc3 *dwc)
 
 void dwc3_host_exit(struct dwc3 *dwc)
 {
-	dwc3_enable_susphy(dwc, false);
+	dwc3_enable_susphy(dwc, true);
 	platform_device_unregister(dwc->xhci);
 	dwc->xhci = NULL;
 }
-- 
2.51.0


