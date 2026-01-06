Return-Path: <stable+bounces-205307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE5ACF9B2E
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 18:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2FF1304C6ED
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 17:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018C435503A;
	Tue,  6 Jan 2026 17:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bsaE9R7n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C8E355040;
	Tue,  6 Jan 2026 17:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720259; cv=none; b=Q2/6Btu9Kv/XAzqmLORJWY99LTT3vR5gfkmlyuJd4ikLEQ6ofOduWeMYs0EMSEqB9PLduigk3W8toWsDpaKA4l+w4M08K4UWHKP4tHmaj+7qWFL9ZFaRXhzEd/CSSPezVndcwpfiQFRUdWujrb0GI5c6h0SAzv/PxUGDKz3noLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720259; c=relaxed/simple;
	bh=4/UmjVwAAQmO71usBuAzlT0yBEZ/YlasZzNcyRh7GUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6orbc3FOxvYUx3P0V4Nf+k9JEzHnaPZXLae8BtXcgrMLWzhYQD697jUSJUdJ5rRuL2rKTqAEfYMjvE++ktp+roLxi7fF3NK1jzKa+bdbuIxLpbIM0XlzwhT24sp3Ydp1Vt6Qtlv8w2o7qFASRllHUdLCpzZknCoJDAnm/jSsd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bsaE9R7n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2348C116C6;
	Tue,  6 Jan 2026 17:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767720259;
	bh=4/UmjVwAAQmO71usBuAzlT0yBEZ/YlasZzNcyRh7GUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bsaE9R7nnbAZxeGo0cOvXlxFHCXkVisK8u+UGSMj3YUxgIeB2rj8Y0jW0TA8jm2G1
	 dOv0axP9qJiaCE6gtkr01+BJBPFjIqjaQ6K2omC3GdCOgBOf7kz9PwSuWXu3Rvtki7
	 3sx5klSqIjfyT3WK/EaSRrx9HTbm3L9l6wVrCtFY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 6.12 183/567] usb: typec: altmodes/displayport: Drop the device reference in dp_altmode_probe()
Date: Tue,  6 Jan 2026 17:59:25 +0100
Message-ID: <20260106170458.100294053@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106170451.332875001@linuxfoundation.org>
References: <20260106170451.332875001@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

commit 128bb7fab342546352603bde8b49ff54e3af0529 upstream.

In error paths, call typec_altmode_put_plug() to drop the device reference
obtained by typec_altmode_get_plug().

Fixes: 71ba4fe56656 ("usb: typec: altmodes/displayport: add SOP' support")
Cc: stable <stable@kernel.org>
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/20251206070445.190770-1-lihaoxiang@isrc.iscas.ac.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/altmodes/displayport.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -736,12 +736,16 @@ int dp_altmode_probe(struct typec_altmod
 	if (!(DP_CAP_PIN_ASSIGN_DFP_D(port->vdo) &
 	      DP_CAP_PIN_ASSIGN_UFP_D(alt->vdo)) &&
 	    !(DP_CAP_PIN_ASSIGN_UFP_D(port->vdo) &
-	      DP_CAP_PIN_ASSIGN_DFP_D(alt->vdo)))
+	      DP_CAP_PIN_ASSIGN_DFP_D(alt->vdo))) {
+		typec_altmode_put_plug(plug);
 		return -ENODEV;
+	}
 
 	dp = devm_kzalloc(&alt->dev, sizeof(*dp), GFP_KERNEL);
-	if (!dp)
+	if (!dp) {
+		typec_altmode_put_plug(plug);
 		return -ENOMEM;
+	}
 
 	INIT_WORK(&dp->work, dp_altmode_work);
 	mutex_init(&dp->lock);



