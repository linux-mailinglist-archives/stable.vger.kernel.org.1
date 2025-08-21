Return-Path: <stable+bounces-172230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 189DDB3072D
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 22:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C0734E697A
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 20:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6498350D52;
	Thu, 21 Aug 2025 20:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VOGQNs4A"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AE41AF0AF
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 20:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755808685; cv=none; b=DsO+Jna2tgUUUchUnf8Z08IweX7ie0b3vt9bt7HMCde/Z3U19JHZzCAnq8Ja1ZcMgAN3YlFeEqkytZMqBNLtiIp1WlpJk1x1hvZHKzORJGNjxslj//tG/nhF9jJSNEev4m9K99ZJ190G38PJQgC9hw8pStt7dQ4bOUPdDKCJOFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755808685; c=relaxed/simple;
	bh=LK0ffmxwoRRSpUy6ETRxfmp+bDaVlq/xpqFIqDqFAm8=;
	h=Date:Mime-Version:Message-ID:Subject:From:Cc:Content-Type; b=UlezftvJioD8Jyqiir+B3MMZYLztYQg6hzaFRyCM+QcOFFAkG+F8TV55TvQ5XOkGarpxR3/0PZEtFcY00OK9B57oSfYZSzucQBEFB0KAsPa+t8Gn7FEIOQoOt/+9wSDje4cf2rrv3D1rB8jcKPNCrbpPfvjxfxiE8iny+jEs5x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VOGQNs4A; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4741e1cde6so1115556a12.3
        for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755808683; x=1756413483; darn=vger.kernel.org;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A6J8iPdaSliSAg1NNjehK3dJ+H9DoeAFsFqVWkQlMvg=;
        b=VOGQNs4ABqDUuaqcQ4TmXvtFzHHs9sQSpHmYGGr40OMri48cncpSPqoxD1DPWhlZWo
         UOZYoYBSHobvt/Mey5Ll4SpozKqsCtWl8Ws+OM7uFOS98PGOEZ1HzLM6Q7oOEj8p3KqD
         Wxq0zj/IPPu1KgLzHkwTaZBuPZ56sqFEKiqtJgvxNCVpFuiVuLH8UGoKpjkuL/OqUTgQ
         NnqviiCRMG2PXzNznS/JdoA7VHNEqiZVdWVruyhgLz0f6ftBGf4z59/MKrRV3ACC65ln
         x9EQV5lLNnp725mKHcW3JpuwQPvrL+yDjPLCpsfv5Td/0Yw455AtB2Tj351JNNJIirgX
         qiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755808683; x=1756413483;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A6J8iPdaSliSAg1NNjehK3dJ+H9DoeAFsFqVWkQlMvg=;
        b=UM7DO33SIqqrvBM76BFQ14qUrhYQ3YXx53PvkZh/DcTdQtQckp4okfikPNwsS0S9hq
         kAAJ3WhfEUvtvEDhsjNsZOj9q4NplPZYbvK9HthaJ1bmC0ntBhTgJttAsZozctecv3ZU
         hBQwQmGDjgaMNg94KoA+rydm2En9IEjPF+hKTD4k4pRO6XPl8GNreJWBk84QZtoK+Wdm
         Wfm+zuKNFQrXasxby9Gmw7aObS4VD8hNV0cyAPvH6yuyMbQyiOiIypm6sO38sIP5JgFS
         gmHyj4H5Xv41KNl0Btkre6wQL/TUbrPlRS3aGXn79bzuDG9KLNIK8jLms5d2IoANibba
         QfUw==
X-Forwarded-Encrypted: i=1; AJvYcCWtzHr2AABz1HNTysRLR7mUxdVAQCk5WjU9VLTmxUbBQ8Rd8cQ9afyOyG6GFEl66f8e5fXx0TQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKnxpDrQ/QkmkWNtbNzzr4sqCym6aywX1LfhHFQR9x5aQswc4R
	4rrMD7M5V4TNxx4piPlCUyjsTpLmSVLnzs7OtugfoRdPnGQARg2EWbUVlSLx1yH3abiQNonirwH
	sPucOWfK6mtkb61YCUw==
X-Google-Smtp-Source: AGHT+IHTNg2XpUsrE+YHf5HG9pSwBMBRFWraLKsoDyvJj3fw3Vtl+2W4kClcaiFGfxlTTGUbBZuUq4sbjFR1Bu0=
X-Received: from pjj13.prod.google.com ([2002:a17:90b:554d:b0:31f:b2f:aeed])
 (user=rdbabiera job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3ca1:b0:23f:f99d:465e with SMTP id adf61e73a8af0-24340c434a3mr587468637.16.1755808683509;
 Thu, 21 Aug 2025 13:38:03 -0700 (PDT)
Date: Thu, 21 Aug 2025 20:37:57 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2145; i=rdbabiera@google.com;
 h=from:subject; bh=LK0ffmxwoRRSpUy6ETRxfmp+bDaVlq/xpqFIqDqFAm8=;
 b=owGbwMvMwCVW0bfok0KS4TbG02pJDBnLm5fPWCW6yPpk7Yd00bRfWw8tvsKwLnl22AaFJn2/C
 yLegTr9HaUsDGJcDLJiiiy6/nkGN66kbpnDWWMMM4eVCWQIAxenAEwk+Twjw9V1LKLTm8XazJwe
 iRgL2W58tI35h9M/x0kr5M5PWJjBysTIcMdyob1ltEs2r451FfNiYbPO/R5cbwNWKWm+WD755FE vTgA=
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250821203759.1720841-2-rdbabiera@google.com>
Subject: [PATCH v1] usb: typec: tcpm: properly deliver cable vdms to altmode drivers
From: RD Babiera <rdbabiera@google.com>
Cc: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, 
	badhri@google.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	RD Babiera <rdbabiera@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

tcpm_handle_vdm_request delivers messages to the partner altmode or the
cable altmode depending on the SVDM response type, which is incorrect.
The partner or cable should be chosen based on the received message type
instead.

Also add this filter to ADEV_NOTIFY_USB_AND_QUEUE_VDM, which is used when
the Enter Mode command is responded to by a NAK on SOP or SOP' and when
the Exit Mode command is responded to by an ACK on SOP.

Fixes: 7e7877c55eb1 ("usb: typec: tcpm: add alt mode enter/exit/vdm support for sop'")
Cc: stable@vger.kernel.org
Signed-off-by: RD Babiera <rdbabiera@google.com>
Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 1f6fdfaa34bf..b2a568a5bc9b 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -2426,17 +2426,21 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
 		case ADEV_NONE:
 			break;
 		case ADEV_NOTIFY_USB_AND_QUEUE_VDM:
-			WARN_ON(typec_altmode_notify(adev, TYPEC_STATE_USB, NULL));
-			typec_altmode_vdm(adev, p[0], &p[1], cnt);
+			if (rx_sop_type == TCPC_TX_SOP_PRIME) {
+				typec_cable_altmode_vdm(adev, TYPEC_PLUG_SOP_P, p[0], &p[1], cnt);
+			} else {
+				WARN_ON(typec_altmode_notify(adev, TYPEC_STATE_USB, NULL));
+				typec_altmode_vdm(adev, p[0], &p[1], cnt);
+			}
 			break;
 		case ADEV_QUEUE_VDM:
-			if (response_tx_sop_type == TCPC_TX_SOP_PRIME)
+			if (rx_sop_type == TCPC_TX_SOP_PRIME)
 				typec_cable_altmode_vdm(adev, TYPEC_PLUG_SOP_P, p[0], &p[1], cnt);
 			else
 				typec_altmode_vdm(adev, p[0], &p[1], cnt);
 			break;
 		case ADEV_QUEUE_VDM_SEND_EXIT_MODE_ON_FAIL:
-			if (response_tx_sop_type == TCPC_TX_SOP_PRIME) {
+			if (rx_sop_type == TCPC_TX_SOP_PRIME) {
 				if (typec_cable_altmode_vdm(adev, TYPEC_PLUG_SOP_P,
 							    p[0], &p[1], cnt)) {
 					int svdm_version = typec_get_cable_svdm_version(

base-commit: 956606bafb5fc6e5968aadcda86fc0037e1d7548
-- 
2.51.0.261.g7ce5a0a67e-goog


