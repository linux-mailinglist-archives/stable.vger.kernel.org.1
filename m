Return-Path: <stable+bounces-87465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C96C9A6512
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 12:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E0E92822D7
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A3C1F4FC8;
	Mon, 21 Oct 2024 10:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kuba3Igh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C361F473E;
	Mon, 21 Oct 2024 10:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507685; cv=none; b=IsVSnl0MLmrOXYwaiXKnNKnoWgUYMqU2fE2xW1az9zq5fqmaAHYM13dylv2D/5MfV9FSAJSLBDrKX+jVmCYHnIwa3gr9iJFsbxWsVy/77K+yz8YCdi/ZHec0eZLoCAL3SvmUzLcobaM4Zr6tRMCvKRRbXI6HA6Wc7JHH87QJg+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507685; c=relaxed/simple;
	bh=O5HSqKJ7ug/LWZUW99a/CwR3bH19OqcIOo1Nu8+2V8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c6glSxJg2k4qg7nrjytrftsVaSwfbFubQRo1T+3bJjdK1G+/bXh3o3gyVHzw02ADE8dyx1VY2FNIJJv2k2Ka5o0IBI3qGLPlgrSavkn5swAB41Fk5pkq5QQdnPNbGNZnh88E79ih4TTe2oLxT3x+VXuHwRlIouJsnECHAziemn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kuba3Igh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B14C4CEC3;
	Mon, 21 Oct 2024 10:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729507684;
	bh=O5HSqKJ7ug/LWZUW99a/CwR3bH19OqcIOo1Nu8+2V8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kuba3IghP7JK9rfisDSFkf6OvCayrs2KyUU81Ye8ug+DvPruxAK4VT1GcfKKf7yRB
	 r2ng5gv43ys9ezDdEkDjh34prSqwQNwl94FuxE/yFeTSLINq3gqj+JbhcF4a1mAcXj
	 xL8T1jAietgLpaC2JBS5DsYLwq3dc5Rig0auUabQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.15 67/82] parport: Proper fix for array out-of-bounds access
Date: Mon, 21 Oct 2024 12:25:48 +0200
Message-ID: <20241021102249.872677973@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021102247.209765070@linuxfoundation.org>
References: <20241021102247.209765070@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 02ac3a9ef3a18b58d8f3ea2b6e46de657bf6c4f9 upstream.

The recent fix for array out-of-bounds accesses replaced sprintf()
calls blindly with snprintf().  However, since snprintf() returns the
would-be-printed size, not the actually output size, the length
calculation can still go over the given limit.

Use scnprintf() instead of snprintf(), which returns the actually
output letters, for addressing the potential out-of-bounds access
properly.

Fixes: ab11dac93d2d ("dev/parport: fix the array out-of-bounds risk")
Cc: stable@vger.kernel.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20240920103318.19271-1-tiwai@suse.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/parport/procfs.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -51,12 +51,12 @@ static int do_active_device(struct ctl_t
 	
 	for (dev = port->devices; dev ; dev = dev->next) {
 		if(dev == port->cad) {
-			len += snprintf(buffer, sizeof(buffer), "%s\n", dev->name);
+			len += scnprintf(buffer, sizeof(buffer), "%s\n", dev->name);
 		}
 	}
 
 	if(!len) {
-		len += snprintf(buffer, sizeof(buffer), "%s\n", "none");
+		len += scnprintf(buffer, sizeof(buffer), "%s\n", "none");
 	}
 
 	if (len > *lenp)
@@ -87,19 +87,19 @@ static int do_autoprobe(struct ctl_table
 	}
 	
 	if ((str = info->class_name) != NULL)
-		len += snprintf (buffer + len, sizeof(buffer) - len, "CLASS:%s;\n", str);
+		len += scnprintf (buffer + len, sizeof(buffer) - len, "CLASS:%s;\n", str);
 
 	if ((str = info->model) != NULL)
-		len += snprintf (buffer + len, sizeof(buffer) - len, "MODEL:%s;\n", str);
+		len += scnprintf (buffer + len, sizeof(buffer) - len, "MODEL:%s;\n", str);
 
 	if ((str = info->mfr) != NULL)
-		len += snprintf (buffer + len, sizeof(buffer) - len, "MANUFACTURER:%s;\n", str);
+		len += scnprintf (buffer + len, sizeof(buffer) - len, "MANUFACTURER:%s;\n", str);
 
 	if ((str = info->description) != NULL)
-		len += snprintf (buffer + len, sizeof(buffer) - len, "DESCRIPTION:%s;\n", str);
+		len += scnprintf (buffer + len, sizeof(buffer) - len, "DESCRIPTION:%s;\n", str);
 
 	if ((str = info->cmdset) != NULL)
-		len += snprintf (buffer + len, sizeof(buffer) - len, "COMMAND SET:%s;\n", str);
+		len += scnprintf (buffer + len, sizeof(buffer) - len, "COMMAND SET:%s;\n", str);
 
 	if (len > *lenp)
 		len = *lenp;
@@ -128,7 +128,7 @@ static int do_hardware_base_addr(struct
 	if (write) /* permissions prevent this anyway */
 		return -EACCES;
 
-	len += snprintf (buffer, sizeof(buffer), "%lu\t%lu\n", port->base, port->base_hi);
+	len += scnprintf (buffer, sizeof(buffer), "%lu\t%lu\n", port->base, port->base_hi);
 
 	if (len > *lenp)
 		len = *lenp;
@@ -155,7 +155,7 @@ static int do_hardware_irq(struct ctl_ta
 	if (write) /* permissions prevent this anyway */
 		return -EACCES;
 
-	len += snprintf (buffer, sizeof(buffer), "%d\n", port->irq);
+	len += scnprintf (buffer, sizeof(buffer), "%d\n", port->irq);
 
 	if (len > *lenp)
 		len = *lenp;
@@ -182,7 +182,7 @@ static int do_hardware_dma(struct ctl_ta
 	if (write) /* permissions prevent this anyway */
 		return -EACCES;
 
-	len += snprintf (buffer, sizeof(buffer), "%d\n", port->dma);
+	len += scnprintf (buffer, sizeof(buffer), "%d\n", port->dma);
 
 	if (len > *lenp)
 		len = *lenp;
@@ -213,7 +213,7 @@ static int do_hardware_modes(struct ctl_
 #define printmode(x)							\
 do {									\
 	if (port->modes & PARPORT_MODE_##x)				\
-		len += snprintf(buffer + len, sizeof(buffer) - len, "%s%s", f++ ? "," : "", #x); \
+		len += scnprintf(buffer + len, sizeof(buffer) - len, "%s%s", f++ ? "," : "", #x); \
 } while (0)
 		int f = 0;
 		printmode(PCSPP);



