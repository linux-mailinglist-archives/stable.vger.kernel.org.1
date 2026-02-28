Return-Path: <stable+bounces-220291-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KIYEBwwo2nb+AQAu9opvQ
	(envelope-from <stable+bounces-220291-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:12:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA5F1C587B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70B7932911F0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C4947DF9D;
	Sat, 28 Feb 2026 17:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udm5+xxE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84647386560;
	Sat, 28 Feb 2026 17:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300195; cv=none; b=gSCZ77qwhvRHQvrYrpQdjtMNUkIoMm/56iiLk1DwSAcx4psFvCgKYLVHE7FWsyQBFj+QCPndv0oNC9JskRpoOWES4V9UvKY1N13ZXRjSw316ZX8oSIDJJt/aEey85E4M4OSXEOvE3mXLgFNIPlt24x9DCmXbbY1zzPyDBIqDgVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300195; c=relaxed/simple;
	bh=jITFQ1PQ11OQ6l1VM/aZkKEbbySKJs4wjKHSH7MykMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OSBmgrYGzWKQLfF+yWAPAjEgsqKUYPbHynsWkyNzKCt49BPLsu+FkWWwqBSC1bpDpEZ6BbpYiHXdpUEhZEcly8GvN9uOhEhKmPlSvmkvUg7shp28jIyp6cor8Qf6itADTI9rfs+cX5B4sPNCEOyZXQYp8dl7fqPbsidc7p0eh3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udm5+xxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4969C19425;
	Sat, 28 Feb 2026 17:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300195;
	bh=jITFQ1PQ11OQ6l1VM/aZkKEbbySKJs4wjKHSH7MykMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=udm5+xxEzxAUNgGx5JnX3An93+AEqEV4qRrW22jhrFdqBg/ypsGbftjMYvk/vaLff
	 W1LLs0YZU1bQbXM0i4vAvADixO8jNpFi7jMqCDcDjy2bTL/vFcvBGZhvDfmhH0+Rk2
	 A/tvmeEzQYfaxT3MBqbjwh3YSQV7gqTL6CgE8IWUhifRunfKgs7bcskTl2yPQDnfXW
	 GO/fDqZ5bOXJpQWBp5GiqZWIUwLgGJcgfFgQ/xsPCfGuUWnNW/Po9iv5aVHec/XFEr
	 TDU+xpAc6/7TZOVkjEEzxFqnlrGwvleRABq+2e7XWB7M7gVRI03sVbDacIabLLmf31
	 wmtlaz8Y7yLSg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Lili Orosz <lily@floofy.city>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 213/844] media: uvcvideo: Create an ID namespace for streaming output terminals
Date: Sat, 28 Feb 2026 12:22:06 -0500
Message-ID: <20260228173244.1509663-214-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220291-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,chromium.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,floofy.city:email,ideasonboard.com:email,uvc_entity.id:url]
X-Rspamd-Queue-Id: 9CA5F1C587B
X-Rspamd-Action: no action

From: Ricardo Ribalda <ribalda@chromium.org>

[ Upstream commit 3d9f32e02c2ed85338be627de672e2b81b88a836 ]

Some devices, such as the Grandstream GUV3100 and the LSK Meeting Eye
for Business & Home, exhibit entity ID collisions between units and
streaming output terminals.

The UVC specification requires unit and terminal IDs to be unique, and
uses the ID to reference entities:

- In control requests, to identify the target entity
- In the UVC units and terminals descriptors' bSourceID field, to
  identify source entities
- In the UVC input header descriptor's bTerminalLink, to identify the
  terminal associated with a streaming interface

Entity ID collisions break accessing controls and make the graph
description in the UVC descriptors ambiguous. However, collisions where
one of the entities is a streaming output terminal and the other entity
is not a streaming terminal are less severe. Streaming output terminals
have no controls, and, as they are the final entity in pipelines, they
are never referenced in descriptors as source entities. They are
referenced by ID only from innput header descriptors, which by
definition only reference streaming terminals.

For these reasons, we can work around the collision by giving streaming
output terminals their own ID namespace. Do so by setting bit
UVC_TERM_OUTPUT (15) in the uvc_entity.id field, which is normally never
set as the ID is a 8-bit value.

This ID change doesn't affect the entity name in the media controller
graph as the name isn't constructed from the ID, so there should not be
any impact on the uAPI.

Although this change handles some ID collisions automagically, keep
printing an error in uvc_alloc_new_entity() when a camera has invalid
descriptors. Hopefully this message will help vendors fix their invalid
descriptors.

This new method of handling ID collisions includes a revert of commit
758dbc756aad ("media: uvcvideo: Use heuristic to find stream entity")
that attempted to fix the problem urgently due to regression reports.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Lili Orosz <lily@floofy.city>
Co-developed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://patch.msgid.link/20251113210400.28618-1-laurent.pinchart@ideasonboard.com
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 54 ++++++++++++++++++------------
 drivers/media/usb/uvc/uvcvideo.h   |  3 +-
 2 files changed, 35 insertions(+), 22 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index ee4f54d683496..aa3e8d295e0f5 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -165,28 +165,17 @@ static struct uvc_entity *uvc_entity_by_reference(struct uvc_device *dev,
 	return NULL;
 }
 
-static struct uvc_streaming *uvc_stream_by_id(struct uvc_device *dev, int id)
+static struct uvc_streaming *uvc_stream_for_terminal(struct uvc_device *dev,
+						     struct uvc_entity *term)
 {
-	struct uvc_streaming *stream, *last_stream;
-	unsigned int count = 0;
+	u16 id = UVC_HARDWARE_ENTITY_ID(term->id);
+	struct uvc_streaming *stream;
 
 	list_for_each_entry(stream, &dev->streams, list) {
-		count += 1;
-		last_stream = stream;
 		if (stream->header.bTerminalLink == id)
 			return stream;
 	}
 
-	/*
-	 * If the streaming entity is referenced by an invalid ID, notify the
-	 * user and use heuristics to guess the correct entity.
-	 */
-	if (count == 1 && id == UVC_INVALID_ENTITY_ID) {
-		dev_warn(&dev->intf->dev,
-			 "UVC non compliance: Invalid USB header. The streaming entity has an invalid ID, guessing the correct one.");
-		return last_stream;
-	}
-
 	return NULL;
 }
 
@@ -823,10 +812,12 @@ static struct uvc_entity *uvc_alloc_new_entity(struct uvc_device *dev, u16 type,
 	}
 
 	/* Per UVC 1.1+ spec 3.7.2, the ID is unique. */
-	if (uvc_entity_by_id(dev, id)) {
-		dev_err(&dev->intf->dev, "Found multiple Units with ID %u\n", id);
+	if (uvc_entity_by_id(dev, UVC_HARDWARE_ENTITY_ID(id)))
+		dev_err(&dev->intf->dev, "Found multiple Units with ID %u\n",
+			UVC_HARDWARE_ENTITY_ID(id));
+
+	if (uvc_entity_by_id(dev, id))
 		id = UVC_INVALID_ENTITY_ID;
-	}
 
 	extra_size = roundup(extra_size, sizeof(*entity->pads));
 	if (num_pads)
@@ -982,6 +973,7 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
 	struct usb_host_interface *alts = dev->intf->cur_altsetting;
 	unsigned int i, n, p, len;
 	const char *type_name;
+	unsigned int id;
 	u16 type;
 
 	switch (buffer[2]) {
@@ -1120,8 +1112,28 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
 			return 0;
 		}
 
+		id = buffer[3];
+
+		/*
+		 * Some devices, such as the Grandstream GUV3100, exhibit entity
+		 * ID collisions between units and streaming output terminals.
+		 * Move streaming output terminals to their own ID namespace by
+		 * setting bit UVC_TERM_OUTPUT (15), above the ID's 8-bit value.
+		 * The bit is ignored in uvc_stream_for_terminal() when looking
+		 * up the streaming interface for the terminal.
+		 *
+		 * This hack is safe to enable unconditionally, as the ID is not
+		 * used for any other purpose (streaming output terminals have
+		 * no controls and are never referenced as sources in UVC
+		 * descriptors). Other types output terminals can have controls,
+		 * so limit usage of this separate namespace to streaming output
+		 * terminals.
+		 */
+		if (type & UVC_TT_STREAMING)
+			id |= UVC_TERM_OUTPUT;
+
 		term = uvc_alloc_new_entity(dev, type | UVC_TERM_OUTPUT,
-					    buffer[3], 1, 0);
+					    id, 1, 0);
 		if (IS_ERR(term))
 			return PTR_ERR(term);
 
@@ -2118,8 +2130,8 @@ static int uvc_register_terms(struct uvc_device *dev,
 		if (UVC_ENTITY_TYPE(term) != UVC_TT_STREAMING)
 			continue;
 
-		stream = uvc_stream_by_id(dev, term->id);
-		if (stream == NULL) {
+		stream = uvc_stream_for_terminal(dev, term);
+		if (!stream) {
 			dev_info(&dev->intf->dev,
 				 "No streaming interface found for terminal %u.",
 				 term->id);
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index ed7bad31f75ca..3f2e832025e71 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -41,7 +41,8 @@
 #define UVC_EXT_GPIO_UNIT		0x7ffe
 #define UVC_EXT_GPIO_UNIT_ID		0x100
 
-#define UVC_INVALID_ENTITY_ID          0xffff
+#define UVC_HARDWARE_ENTITY_ID(id)	((id) & 0xff)
+#define UVC_INVALID_ENTITY_ID		0xffff
 
 /* ------------------------------------------------------------------------
  * Driver specific constants.
-- 
2.51.0


