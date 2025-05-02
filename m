Return-Path: <stable+bounces-139524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FB1AA7D90
	for <lists+stable@lfdr.de>; Sat,  3 May 2025 01:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24FE77B796F
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 23:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7026527056A;
	Fri,  2 May 2025 23:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHt8jwHY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245631EEA4E;
	Fri,  2 May 2025 23:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746230237; cv=none; b=Et8JxY1YLpVn9uPj/3HSoFLTLp6fIdx2cSQXuwzhYjbYcQhrhNvh5YG7LYQkdxekzKyQBMmAVeCHnBEs75gmnbMu5BN3LruiE8DsyD6h1HuKXEVQegFwizz0tovRF39zS0n8Gu7sRQxtUa4qwU7wK/oGaW34n58omJLOWuGEnTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746230237; c=relaxed/simple;
	bh=PVEABnovuqU+G2Rx4Yj6v3Jpl6rgBdbKjzl1gkywClk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Dq6ewBx1Ed/aBslPoVrcO6UBsUXlEyhjIVmVYeM+S4tdvVp3Nj+WO+4/syB1SLoy4Uv7tGyPGoa5YUAH1qGGW/c9Tni4+vZuqprpmbUsoFiG+RJmkEm2/e/WbaRCluwWqX1rgyhqr2oLeTAV9LiUVUKQOWnZwBbTn3aU5NwvfLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHt8jwHY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92B75C4CEE4;
	Fri,  2 May 2025 23:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746230235;
	bh=PVEABnovuqU+G2Rx4Yj6v3Jpl6rgBdbKjzl1gkywClk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=lHt8jwHY8o1RDFknGkE6SWn5K01bv0JvSow/6z4SJ4fQugGopK1pNXv45Z8KUFXwP
	 wNPh+81L2+MZFm/AwoPk9IJP4huQEMMRP5s4D7TdJoQm37j7FCiHSPUOXvIEgiJnP0
	 eGbu9j/pMvO1jhfU5+Rf238N4q4jUx9m9+oIKWN9GDEQiURwfKYS/a1IwHfQMzddE8
	 O3o5UBinEAD566oa2dqnSeM/q6hwuxnwRcFLXwljlwvEDnRAl7IVUQP1NkmgApB3rK
	 4v3p5UrZ5QSYDgkYwR4EeEB/VgYSkWMxmPpariOevZv8uyp2HpF8SGaJc1cSkXopJ1
	 Yj/A485RKUq/A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA2FC3ABAC;
	Fri,  2 May 2025 23:57:15 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Fri, 02 May 2025 16:57:03 -0700
Subject: [PATCH] usb: typec: tcpm/tcpci_maxim: Fix bounds check in
 process_rx()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-b4-new-fix-pd-rx-count-v1-1-e5711ed09b3d@google.com>
X-B4-Tracking: v=1; b=H4sIAM5bFWgC/x2MywqAIBAAfyX23EJKJfYr0SFrq71YrD0E6d+Tj
 gMzkyCQMAXoigRCNwfefQZVFjBto18Jec4MutJNVWuFrkZPDy4c8ZhRIk775U80VlvjxlZZZyD
 Hh1BW/nE/vO8H7HJeNWgAAAA=
X-Change-ID: 20250421-b4-new-fix-pd-rx-count-79297ba619b7
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Badhri Jagan Sridharan <badhri@google.com>
Cc: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, RD Babiera <rdbabiera@google.com>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Amit Sunil Dhamne <amitsd@google.com>, 
 Kyle Tso <kyletso@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746230235; l=1638;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=vGHl5bogQ6MXAcBZGSBqyO6WniDKbsq9TxUanfyP/D0=;
 b=MQhqKGSoGaDHNV4VW4oJMLEmFrNWzWKJNYBUplKvCqCSZqAVLDl/+35LL0ic7i9TG1NFK70jL
 E5RET5hCJp+BAT2Miq/9XIT16NDxYi/ks97Ovyj79IDKQYKRsAm9XrE
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com

From: Amit Sunil Dhamne <amitsd@google.com>

Register read of TCPC_RX_BYTE_CNT returns the total size consisting of:

  PD message (pending read) size + 1 Byte for Frame Type (SOP*)

This is validated against the max PD message (`struct pd_message`) size
without accounting for the extra byte for the frame type. Note that the
struct pd_message does not contain a field for the frame_type. This
results in false negatives when the "PD message (pending read)" is equal
to the max PD message size.

Fixes: 6f413b559f86 ("usb: typec: tcpci_maxim: Chip level TCPC driver")
Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
Reviewed-by: Kyle Tso <kyletso@google.com>
---
 drivers/usb/typec/tcpm/tcpci_maxim_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
index fd1b80593367641a6f997da2fb97a2b7238f6982..648311f5e3cf135f23b5cc0668001d2f177b9edd 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
@@ -166,7 +166,8 @@ static void process_rx(struct max_tcpci_chip *chip, u16 status)
 		return;
 	}
 
-	if (count > sizeof(struct pd_message) || count + 1 > TCPC_RECEIVE_BUFFER_LEN) {
+	if (count > sizeof(struct pd_message) + 1 ||
+	    count + 1 > TCPC_RECEIVE_BUFFER_LEN) {
 		dev_err(chip->dev, "Invalid TCPC_RX_BYTE_CNT %d\n", count);
 		return;
 	}

---
base-commit: ebd297a2affadb6f6f4d2e5d975c1eda18ac762d
change-id: 20250421-b4-new-fix-pd-rx-count-79297ba619b7

Best regards,
-- 
Amit Sunil Dhamne <amitsd@google.com>



