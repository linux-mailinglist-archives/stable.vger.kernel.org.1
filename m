Return-Path: <stable+bounces-43587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A818C365B
	for <lists+stable@lfdr.de>; Sun, 12 May 2024 14:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D822816D0
	for <lists+stable@lfdr.de>; Sun, 12 May 2024 12:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D878219ED;
	Sun, 12 May 2024 12:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7Yot5SR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C58C20323;
	Sun, 12 May 2024 12:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715515938; cv=none; b=PjKBDAgsUSCt5lEmlEl0XWfnY2oQQpjoP2R4V/6QdW6pIoQ01+P7Ne5E7ZJxQIEnzV+khCVe739GtSpLcyUIt2g9BNlhvsxEvmRfHSJ1c5EovHRTHfJLZuBNq8zEtbtDcJ0GM/NyQze9yIWPLDLVQEMqAZ+62gNYACYY8RPyCIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715515938; c=relaxed/simple;
	bh=lOIv9CYGdaM8Wpum8P1i2gOjEdfKKm5DnGLmgvog6Z4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=j0dDIDyKql0tIQFC0f7S/NnZlTb0ezyFJjOI21bDxZVIVHuhiq5cmVSWjCgkRT6t7fCfbf91u4fKBY0DFRxaJgkcuNjMcJ2zUOgH0YuQjLxc9zoa6tqHlfd+BAniC4eQVQAyDip7R+OWSrC9SM2rJsfK0aVi+KHv5Nmtq7oSk4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7Yot5SR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C52D2C116B1;
	Sun, 12 May 2024 12:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715515937;
	bh=lOIv9CYGdaM8Wpum8P1i2gOjEdfKKm5DnGLmgvog6Z4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=H7Yot5SR7bM+tEik8pWRwqRAEyzVhl04jbeFEwCIQqEXeLkHpk527/AIfSY9F9QGs
	 TpTeDUeh3Us2zNuLhth8jqK7+PBM0v5fi4GtvkkRF1rfPCSRHmCJazFGgRAVwxT3yU
	 um5ty7Py1qzlgp2fubDrq8YqvSuSXP5XOo7+hCRbv1l5lo1aktw5Nq8iPSdCrZ+DT/
	 uaR1ecJOh98ZGq9lpRI0v4DOVmsf+g+z4LnT5rGWYHW6t0dxIyiCphEaV05BkzyCkd
	 zBTKtUA+PF7efPJiMQBPb0kAuPJ08dJFkCu2MfgRBeXuE1rQqhJY5ultxNqJLkEhRi
	 VGtXZj5q85e3Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA205C25B5F;
	Sun, 12 May 2024 12:12:17 +0000 (UTC)
From: Sven Peter via B4 Relay <devnull+sven.svenpeter.dev@kernel.org>
Subject: [PATCH 0/2] Bluetooth: hci_bcm4377 fixes
Date: Sun, 12 May 2024 12:12:06 +0000
Message-Id: <20240512-btfix-msgid-v1-0-ab1bd938a7f4@svenpeter.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABayQGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDU0Mj3aSStMwK3dzi9MwU3RRzMwMjy0TzFEtDcyWgjoKiVKAk2LTo2Np
 aAC/1v5RdAAAA
To: Hector Martin <marcan@marcan.st>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sven Peter <sven@svenpeter.dev>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715515936; l=990;
 i=sven@svenpeter.dev; s=20240512; h=from:subject:message-id;
 bh=lOIv9CYGdaM8Wpum8P1i2gOjEdfKKm5DnGLmgvog6Z4=;
 b=jo+i34A8NOxsam6xXuE0fOchQDV91L+Thb8dJuNz0ff62D+4IpNSyLKnSj5jHwq69S1kkNjWn
 LBUq4GIaVAvCemQrrixNxdXViAjDxtvuELGEqQxzUC16YPHvmWJTjQy
X-Developer-Key: i=sven@svenpeter.dev; a=ed25519;
 pk=jIiCK29HFM4fFOT2YTiA6N+4N7W+xZYQDGiO0E37bNU=
X-Endpoint-Received: by B4 Relay for sven@svenpeter.dev/20240512 with
 auth_id=159
X-Original-From: Sven Peter <sven@svenpeter.dev>
Reply-To: sven@svenpeter.dev

Hi,

There are just two minor fixes from Hector that we've been carrying downstream
for a while now. One increases the timeout while waiting for the firmware to
boot which is optional for the controller already supported upstream but
required for a newer 4388 board for which we'll also submit support soon.
It also fixes the units for the timeouts which is why I've already included it
here. The other one fixes a call to bitmap_release_region where we only wanted
to release a single bit but are actually releasing much more.

Best,

Sven

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
Hector Martin (2):
      Bluetooth: hci_bcm4377: Increase boot timeout
      Bluetooth: hci_bcm4377: Fix msgid release

 drivers/bluetooth/hci_bcm4377.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)
---
base-commit: cf87f46fd34d6c19283d9625a7822f20d90b64a4
change-id: 20240512-btfix-msgid-d76029a7d917

Best regards,
-- 
Sven Peter <sven@svenpeter.dev>



