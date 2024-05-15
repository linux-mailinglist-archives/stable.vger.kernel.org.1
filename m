Return-Path: <stable+bounces-45214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 849708C6C03
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 20:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4A2284A5E
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 18:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB2E158DD9;
	Wed, 15 May 2024 18:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hd7/Rcge"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09D3433BC;
	Wed, 15 May 2024 18:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715796913; cv=none; b=G83pDr2sL/Flq8eKFEUuTT/9quQHpBJHQpqv6dAZ+x4Zxwp1E9bthMV1+JMWOIazD163sDeSOSJxoTETDGLnTgvFvLrem33DTPcsbqUXNFuC2AVQWgaqnvtuicTyWfcDM8UEJtsNVRZOc9Ipn5mlUiDRju3HS4SG1V030jOVv70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715796913; c=relaxed/simple;
	bh=PGURJy5MHlm6XUXszUKhFzRvUcIs8Hj8iEYpUECP0Y0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ReGE9MTFqrfuhb7t+iAbXxhlSoKSEV8z8kbdS5brUfTT0BXE6wH9IeEMsWmf01zba5Lr5aGGpwAGLglCYb+rbX2oviC2jkBWf+IFOEKnzeCOeQY2lX4vo226sFVR2mKyz567Q7WJ5nGHCrRxrEAwJcBjNeeyjHmvWIkRS8rmQdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hd7/Rcge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8769FC116B1;
	Wed, 15 May 2024 18:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715796912;
	bh=PGURJy5MHlm6XUXszUKhFzRvUcIs8Hj8iEYpUECP0Y0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=hd7/RcgeU+BH0ZVdd5Yv4E6Gc1pYPqQbLyN/McVEe81RoVUpZKEdkQcV852AEeB4W
	 y2t19I7ndNisZyChd3JQzVOon9tqvDU1DLHo54Sndf4i9MMaHhPAlejBuNcw/8t80V
	 YuhWhFz67Dfpkm0xX9jEKc5tbXsAYJ0p/REr11DjXbMJ2ActMLoJ/Pbudc8X0IxHib
	 KnpQ3Vvnl9HdsloREjmwdClkd4kIqT6E3HcdxOyoGViToK2Pe8mlItEqKqeq6ZoJdm
	 CNfQa37pJAXNVN7m0QkOHQahTkUdxH9hnBXXvAlLQdFcMrVnBrGRJYXZESVtFqtXc/
	 ckaq6Qei0W5BA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F79C25B75;
	Wed, 15 May 2024 18:15:12 +0000 (UTC)
From: Sven Peter via B4 Relay <devnull+sven.svenpeter.dev@kernel.org>
Subject: [PATCH v2 0/3] Bluetooth: hci_bcm4377 fixes
Date: Wed, 15 May 2024 18:15:01 +0000
Message-Id: <20240515-btfix-msgid-v2-0-bb06b9ecb6d1@svenpeter.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKX7RGYC/22MQQ7CIBBFr9LM2jGAVcSV9zBdgEzbWUgbIETTc
 Hexa5fv/7y3QaLIlODWbRCpcOIlNFCHDp6zDRMh+8aghOrFWSp0eeQ3vtLEHr2+CGWs9kZqaMY
 aqZ177TE0njnlJX72eJG/9X+nSBRonXTenK5Wj/09FQorZYpHTwWGWusXkPK1faoAAAA=
To: Hector Martin <marcan@marcan.st>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sven Peter <sven@svenpeter.dev>, stable@vger.kernel.org, 
 Neal Gompa <neal@gompa.dev>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715796911; l=1561;
 i=sven@svenpeter.dev; s=20240512; h=from:subject:message-id;
 bh=PGURJy5MHlm6XUXszUKhFzRvUcIs8Hj8iEYpUECP0Y0=;
 b=rWKwkEblh6RdLBuKAhQAswaTPpV6aL8Wlnu8pLb0phkNIIfvgOLdAMCME/FjRPa1SgQyUa4Vu
 txh3IgfhG9KCoQ9FpGoeKnyAJ6Htc4DOcOoVEJvVsMLLMP30Ve5yNKd
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

To: Hector Martin <marcan@marcan.st>
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: asahi@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sven Peter <sven@svenpeter.dev>

Changes in v2:
- split the timeout commit into two
- collect Neal's tag
- Link to v1: https://lore.kernel.org/r/20240512-btfix-msgid-v1-0-ab1bd938a7f4@svenpeter.dev

---
Hector Martin (2):
      Bluetooth: hci_bcm4377: Increase boot timeout
      Bluetooth: hci_bcm4377: Fix msgid release

Sven Peter (1):
      Bluetooth: hci_bcm4377: Use correct unit for timeouts

 drivers/bluetooth/hci_bcm4377.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)
---
base-commit: cf87f46fd34d6c19283d9625a7822f20d90b64a4
change-id: 20240512-btfix-msgid-d76029a7d917

Best regards,
-- 
Sven Peter <sven@svenpeter.dev>



