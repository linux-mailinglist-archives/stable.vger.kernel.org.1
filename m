Return-Path: <stable+bounces-41610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA948B5361
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 10:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7722B21280
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 08:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1121773A;
	Mon, 29 Apr 2024 08:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="HpaOvqYI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qgv7Ps2B"
X-Original-To: stable@vger.kernel.org
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029321755A
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 08:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714380438; cv=none; b=C6EnVahTwUnh4FXIzcCEIo7sQfEfovU1pQGHGB8GIy+tyejc/fa9WlVY9zcgltdJO+lJMzT6uu5zJnsDiDX7w/CJtJxUt7+ddC0e+/YI3w5ZGHbxVWHaI/UhbRFSVvTI5dn3q8Kcw9tC+fTNmqbN+296YVupmw8aQXwGGpU4TTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714380438; c=relaxed/simple;
	bh=1b4Kkc0kiLEcyOQNktWwGEHOj425UHUowt2t5XFXVgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sEGlKbX9+DJT5LFHHPQmvAHiIMY51ljcVxJr51rpd4B15qJsDPRNapsAhhAiE6XznpYRJ283pZ2JUH9BV9nJUPsRZ+GE+2QPJaW48Ft41nLa3+cikTvyaVLrai2a2ZM1p+ZEdaeMgGYIeXJojNJSvzcYlxOKlFluGhQMuRFMVBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=HpaOvqYI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qgv7Ps2B; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id D96DA1C00074;
	Mon, 29 Apr 2024 04:47:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 29 Apr 2024 04:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1714380434; x=1714466834; bh=AA0D+kue/3
	xTdnBt87jovrwup14dV6tF3IPu6PUcZ7I=; b=HpaOvqYIUi0nW3i02BK1nDOhLD
	KGkF7skAJ/FeaqHuPiLYlOrKmOmvHRzCuCLZ6ot4EuUXW4pEu+5hUaCnr9PwX1h5
	cKrS78LAE6mUKsc2v4QR47Z78RLZz+b6nsfl9CeeKe3kQrhQzRApTeUfMN4XfsuS
	8IHAmCFF6v2kgtZhki2ocLcIj7PCs33pSDlxljMHzIEnSjuBJVheE1QJUECxmPpx
	abfkSsMZFrAdh0FKgS3LHGg+BUpOUPylrI4CoyuHrUr/dV3arA5OO398eU9L9Wr+
	3KPf3N2LDaw/MIZXc/6uGGHqNq0epqop8PZOiriWoxIDzxSuruDe2u7IG26g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714380434; x=1714466834; bh=AA0D+kue/3xTdnBt87jovrwup14d
	V6tF3IPu6PUcZ7I=; b=Qgv7Ps2BnurNZBL5fC0zArMg36YjWOLZ8VvPW1psFJzL
	GgIY+taa4ll9NMTZ3aWvrZTngdZS3uvN80caPb7+j05+WPNeyqDGwMRKl2sSRFqB
	2HdGi4amL+CUxhq5xVT6Ejx+Y64/2VbC03ngfsJCF324/jbKNd1I90HqlzASkqRH
	s2fdyUgFkX7CcWd7tePXYT9vmDUpxav3+jgmDRDTiIV8W70jz1ErgTl4tM7tDU5f
	DCKfvj69J+tjhdsXjCid8KS/4M09cczsbM74ymioxLJHbI1x2oer0A9qt72/MOhN
	JUC7wByCUq+NPEZC+MAg6Ckmbf+T2Rkqwiwdtf1HIQ==
X-ME-Sender: <xms:kl4vZjbvtmWRdS4fCXHPTcxdUYnmnsajQ68T7pr94XfDvUAkwZnteA>
    <xme:kl4vZiZ6jEudER2yA4xFJhc788wUqswa2n7vk44UNLrwxUJ227oV4C_ABMq5whqJa
    iAvIxEg0PzaNxx70pA>
X-ME-Received: <xmr:kl4vZl9-9uZQJSOob-cXYWbhUYEjEtN_Hd1SwTfN3tvSGqbIkd6vX5veowXtrhoqU96NxrMLV2c2R_de04xQpNUTGb_Lu6YqkMrBakM2-Zgenw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduuddgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeffvdeuleffve
    ekudfhteejudffgefhtedtgfeutdfgvdfgueefudehveehveekkeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrg
    hkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:kl4vZpqU9PIahi4zMf7SJOlJAs2N8w2iscuaLKOZ2vT-WMExM6aPsQ>
    <xmx:kl4vZupl4fXxs57KjgGL6fFZA_sVuPnWkG0q4pGXM5Yzb7omK5_NeA>
    <xmx:kl4vZvQ8J5P7j_M1hFDQCRf_L3TP7ttQXU5DUdsdNq6GSwqOozrFCw>
    <xmx:kl4vZmq9BSR7h3tgJB96U8ce6jkJWDUyQIe0pxHLy4S2l7ukbdx_4A>
    <xmx:kl4vZl2G93346UGyZFlLKgNBgcgcSt-dmngdyKfc2u_fq0_Ozb0-YKSO>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 04:47:13 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: stable@vger.kernel.org
Subject: [PATCH] firewire: ohci: fulfill timestamp for some local asynchronous transaction
Date: Mon, 29 Apr 2024 17:47:08 +0900
Message-ID: <20240429084709.707473-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1394 OHCI driver generates packet data for the response subaction to the
request subaction to some local registers. In the case, the driver should
assign timestamp to them by itself.

This commit fulfills the timestamp for the subaction.

Cc: stable@vger.kernel.org
Fixes: dcadfd7f7c74 ("firewire: core: use union for callback of transaction completion")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 38d19410a2be..b9ae0340b8a7 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -1556,6 +1556,8 @@ static int handle_at_packet(struct context *context,
 #define HEADER_GET_DATA_LENGTH(q)	(((q) >> 16) & 0xffff)
 #define HEADER_GET_EXTENDED_TCODE(q)	(((q) >> 0) & 0xffff)
 
+static u32 get_cycle_time(struct fw_ohci *ohci);
+
 static void handle_local_rom(struct fw_ohci *ohci,
 			     struct fw_packet *packet, u32 csr)
 {
@@ -1580,6 +1582,8 @@ static void handle_local_rom(struct fw_ohci *ohci,
 				 (void *) ohci->config_rom + i, length);
 	}
 
+	// Timestamping on behalf of the hardware.
+	response.timestamp = cycle_time_to_ohci_tstamp(get_cycle_time(ohci));
 	fw_core_handle_response(&ohci->card, &response);
 }
 
@@ -1628,6 +1632,8 @@ static void handle_local_lock(struct fw_ohci *ohci,
 	fw_fill_response(&response, packet->header, RCODE_BUSY, NULL, 0);
 
  out:
+	// Timestamping on behalf of the hardware.
+	response.timestamp = cycle_time_to_ohci_tstamp(get_cycle_time(ohci));
 	fw_core_handle_response(&ohci->card, &response);
 }
 
@@ -1670,8 +1676,6 @@ static void handle_local_request(struct context *ctx, struct fw_packet *packet)
 	}
 }
 
-static u32 get_cycle_time(struct fw_ohci *ohci);
-
 static void at_context_transmit(struct context *ctx, struct fw_packet *packet)
 {
 	unsigned long flags;
-- 
2.43.0


