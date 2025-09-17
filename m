Return-Path: <stable+bounces-180025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8695B7E654
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F1B3B227D
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5922B302CDE;
	Wed, 17 Sep 2025 12:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vQpGpSKT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159832F7ABF;
	Wed, 17 Sep 2025 12:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113140; cv=none; b=rpRA3fwPd6tMPUnonTJU2CLcu2uE/nPYVU3Nfzn2Wj3drTRcAwmXoSjV+x0qILo4h6aZj3ETD5JvZK9Z3j2a1BpbsVdhjbJyuckzg03DcfustFJczvi4D33jeKksXh6S0gVEPQHSxx7BIn9fCV0ZRDTZOrJlo+pB1r/6DWrDYJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113140; c=relaxed/simple;
	bh=hs/k+72bLtmksldb3RMNX2CNcccByoWMTCPpBb1THx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4mM44rsSXDJ56m0Ta3Uh9wuP2FjVy10jU0OgUZJkDgzIPn0cGEqOOuJPaTSLqbmGpF9ge51nkn2nt9jVTsa8mS5b4naIYNFKRXEOXXrwTA1yCrVGyP7hY0Jh5mNfTcr4Qj/M7Wl0OaBbCfj+SIiJr/Zl/7jEgogsD3kh7WdeQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vQpGpSKT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A46EC4CEF0;
	Wed, 17 Sep 2025 12:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758113140;
	bh=hs/k+72bLtmksldb3RMNX2CNcccByoWMTCPpBb1THx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vQpGpSKTjiriEEG+XxQEBung9HgUN3Lb5V8v0bAt1ILh9PaTjCj/091/aUeBMJLZK
	 yvz1hMIjdrK2rr1O5EUdtPSdNQ+o3T78Qz9M+ycvOKAlHe8X4XEfIZI0faBdtmqcnf
	 ZoDY0WSUx7LPBEjoVVS9D98BSK50gGKynIYLxmc8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.16 183/189] usb: gadget: midi2: Fix MIDI2 IN EP max packet size
Date: Wed, 17 Sep 2025 14:34:53 +0200
Message-ID: <20250917123356.358763733@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123351.839989757@linuxfoundation.org>
References: <20250917123351.839989757@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 116e79c679a1530cf833d0ff3007061d7a716bd9 upstream.

The EP-IN of MIDI2 (altset 1) wasn't initialized in
f_midi2_create_usb_configs() as it's an INT EP unlike others BULK
EPs.  But this leaves rather the max packet size unchanged no matter
which speed is used, resulting in the very slow access.
And the wMaxPacketSize values set there look legit for INT EPs, so
let's initialize the MIDI2 EP-IN there for achieving the equivalent
speed as well.

Fixes: 8b645922b223 ("usb: gadget: Add support for USB MIDI 2.0 function driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20250905133240.20966-1-tiwai@suse.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/f_midi2.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/usb/gadget/function/f_midi2.c
+++ b/drivers/usb/gadget/function/f_midi2.c
@@ -1737,9 +1737,12 @@ static int f_midi2_create_usb_configs(st
 	case USB_SPEED_HIGH:
 		midi2_midi1_ep_out_desc.wMaxPacketSize = cpu_to_le16(512);
 		midi2_midi1_ep_in_desc.wMaxPacketSize = cpu_to_le16(512);
-		for (i = 0; i < midi2->num_eps; i++)
+		for (i = 0; i < midi2->num_eps; i++) {
 			midi2_midi2_ep_out_desc[i].wMaxPacketSize =
 				cpu_to_le16(512);
+			midi2_midi2_ep_in_desc[i].wMaxPacketSize =
+				cpu_to_le16(512);
+		}
 		fallthrough;
 	case USB_SPEED_FULL:
 		midi1_in_eps = midi2_midi1_ep_in_descs;
@@ -1748,9 +1751,12 @@ static int f_midi2_create_usb_configs(st
 	case USB_SPEED_SUPER:
 		midi2_midi1_ep_out_desc.wMaxPacketSize = cpu_to_le16(1024);
 		midi2_midi1_ep_in_desc.wMaxPacketSize = cpu_to_le16(1024);
-		for (i = 0; i < midi2->num_eps; i++)
+		for (i = 0; i < midi2->num_eps; i++) {
 			midi2_midi2_ep_out_desc[i].wMaxPacketSize =
 				cpu_to_le16(1024);
+			midi2_midi2_ep_in_desc[i].wMaxPacketSize =
+				cpu_to_le16(1024);
+		}
 		midi1_in_eps = midi2_midi1_ep_in_ss_descs;
 		midi1_out_eps = midi2_midi1_ep_out_ss_descs;
 		break;



