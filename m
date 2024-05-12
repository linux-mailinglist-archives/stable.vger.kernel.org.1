Return-Path: <stable+bounces-43586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B628C365A
	for <lists+stable@lfdr.de>; Sun, 12 May 2024 14:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6FAC2816B2
	for <lists+stable@lfdr.de>; Sun, 12 May 2024 12:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAA021360;
	Sun, 12 May 2024 12:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1kxCrPb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5501E894;
	Sun, 12 May 2024 12:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715515938; cv=none; b=lEiRlen9REFhzXdipxtOR4HH5Px/uY7O7TXr1D3dJOtrdYzUsVTSOy13mgfkAj0DB3axCJ2zuetlKCdyuYQpSvvDxRW7FhEUqq6xgDZJn42x8+z66C88k8wxOx+fa0oNxKhge8HtiskqPylGMu9sOScWjT8j9ND8QpIEMhiOEgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715515938; c=relaxed/simple;
	bh=RIszvsmJIXjPFOCmrGRuen1Lj7EN27J+tC33ksTn8fA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qNJSUf5L3bLTGLMOVyI6lv/xM+mdjbMgSkx2jyDmgZa4VuQX7Ri+tsWaPHw0xdupAZvKyaOpEwS5pwam1nB15l0VY0hfIrBbAEM9ysGQysQOUd+tl1g01gQtB74/1ffTHMkAocN2s2J0zEhOEtbusfJTzoCwosGHGKUKb6vfuRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1kxCrPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9747C2BD11;
	Sun, 12 May 2024 12:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715515937;
	bh=RIszvsmJIXjPFOCmrGRuen1Lj7EN27J+tC33ksTn8fA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=m1kxCrPbWk4pD1M10r4K82HllO3xF7FYIruQbCYniV5cIFiXGnZVbBF5twYg30pFe
	 CKRKuc7d9QRUi9NDbo9Ir6DFzEH5GWGn63dGSZrbYq+DWUL6crjsmr2frCk82ESgyK
	 9pya8EH7OxRu9eQjpTfpvWRQRSVp8RwY3HOez+XvDF75i3VmomXDBhD+tbVuZbH1EE
	 l1ydIduXuqVLHHV4QATNBG8JzshIxJIckSOP+haDJKWFKGue60NH5qJ7Qrf+KQIgl5
	 rODZkgsKHMC+MOcLLhfWpA/epCafQvIgH3VExiDl/0hSeCMfqiffkWowlZk2oZ26bh
	 O+VgaI84/VBlA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21FFC25B77;
	Sun, 12 May 2024 12:12:17 +0000 (UTC)
From: Sven Peter via B4 Relay <devnull+sven.svenpeter.dev@kernel.org>
Date: Sun, 12 May 2024 12:12:08 +0000
Subject: [PATCH 2/2] Bluetooth: hci_bcm4377: Fix msgid release
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240512-btfix-msgid-v1-2-ab1bd938a7f4@svenpeter.dev>
References: <20240512-btfix-msgid-v1-0-ab1bd938a7f4@svenpeter.dev>
In-Reply-To: <20240512-btfix-msgid-v1-0-ab1bd938a7f4@svenpeter.dev>
To: Hector Martin <marcan@marcan.st>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sven Peter <sven@svenpeter.dev>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715515936; l=963;
 i=sven@svenpeter.dev; s=20240512; h=from:subject:message-id;
 bh=jmwV6wL7bQ7AC4V+W+yysWv9DtBZLTuAd0ES/PoP/v8=;
 b=7ui0qeOF+oHKDon5u5ak3Eh73AiQcV5LdfOLkQQVlohhDLtZ3KrwJxR+9srljp9ec98oAlQhL
 u3GwBfq3Cr0CPEfC86uW9tBlIhCnUzivu8IAebQ4U/BKta51vjqQsbj
X-Developer-Key: i=sven@svenpeter.dev; a=ed25519;
 pk=jIiCK29HFM4fFOT2YTiA6N+4N7W+xZYQDGiO0E37bNU=
X-Endpoint-Received: by B4 Relay for sven@svenpeter.dev/20240512 with
 auth_id=159
X-Original-From: Sven Peter <sven@svenpeter.dev>
Reply-To: sven@svenpeter.dev

From: Hector Martin <marcan@marcan.st>

We are releasing a single msgid, so the order argument to
bitmap_release_region must be zero.

Fixes: 8a06127602de ("Bluetooth: hci_bcm4377: Add new driver for BCM4377 PCIe boards")
Cc: stable@vger.kernel.org
Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Sven Peter <sven@svenpeter.dev>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/bluetooth/hci_bcm4377.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
index 5b818a0e33d6..92d734f02e00 100644
--- a/drivers/bluetooth/hci_bcm4377.c
+++ b/drivers/bluetooth/hci_bcm4377.c
@@ -717,7 +717,7 @@ static void bcm4377_handle_ack(struct bcm4377_data *bcm4377,
 		ring->events[msgid] = NULL;
 	}
 
-	bitmap_release_region(ring->msgids, msgid, ring->n_entries);
+	bitmap_release_region(ring->msgids, msgid, 0);
 
 unlock:
 	spin_unlock_irqrestore(&ring->lock, flags);

-- 
2.34.1



