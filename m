Return-Path: <stable+bounces-91482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F609BEE31
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9AE21C245D9
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E805E1DEFC0;
	Wed,  6 Nov 2024 13:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X5FsetXO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AE01E1C37;
	Wed,  6 Nov 2024 13:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898860; cv=none; b=sRxo0EaXiZY0m/AJC579NJe8D9GkI8zKymWYQSMTWEOo7VeyOq904kxyr9pvCKyrcrnPWPSESuJICIdmYldyRgkq2YqiLIS4jGf5DhWcsfePcg7V4PYczo5yNEgflH/S2ixmThnz976SyVYaqNuTRTtqzU9UOW1p6hc19N2JL5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898860; c=relaxed/simple;
	bh=R2rh0z7VcOJZqgsVXFQf8oy+j67omBUnBU2+4AaS+W8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tLd6UBiMs5xtSUObvesWxvvU2+Cpt83ar9Tlf4WEFyeHW5j+K8/sqzh+43xgyatGFlD8jQjI6b71CUpszfDYodH0aO3sJnwBiA9GEIWg9+zt+sfaORu4Sf1QABCTt5XUHOUDNoaUrBdksNIrH6CqaqN2dUHVijcatDv1Gihx7Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X5FsetXO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFF1C4CECD;
	Wed,  6 Nov 2024 13:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730898860;
	bh=R2rh0z7VcOJZqgsVXFQf8oy+j67omBUnBU2+4AaS+W8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X5FsetXOTpudDeaa/mZKXUdx9/N6zjeuPMd988YrJFBG7Z48hRFiPb3nT+xEL4jgu
	 nq8gQB5lOpjnIJwHnhTilOcEQXoEWjLpSEF5iPiiN/JKVHz10d6uAWFsDIYYYE4C97
	 7gJbbvUlz2DkOKE6Ce6ttPh+4/d/mu8ApXPs/tQQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 379/462] parport: Proper fix for array out-of-bounds access
Date: Wed,  6 Nov 2024 13:04:32 +0100
Message-ID: <20241106120340.886059189@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -156,7 +156,7 @@ static int do_hardware_irq(struct ctl_ta
 	if (write) /* permissions prevent this anyway */
 		return -EACCES;
 
-	len += snprintf (buffer, sizeof(buffer), "%d\n", port->irq);
+	len += scnprintf (buffer, sizeof(buffer), "%d\n", port->irq);
 
 	if (len > *lenp)
 		len = *lenp;
@@ -184,7 +184,7 @@ static int do_hardware_dma(struct ctl_ta
 	if (write) /* permissions prevent this anyway */
 		return -EACCES;
 
-	len += snprintf (buffer, sizeof(buffer), "%d\n", port->dma);
+	len += scnprintf (buffer, sizeof(buffer), "%d\n", port->dma);
 
 	if (len > *lenp)
 		len = *lenp;
@@ -216,7 +216,7 @@ static int do_hardware_modes(struct ctl_
 #define printmode(x)							\
 do {									\
 	if (port->modes & PARPORT_MODE_##x)				\
-		len += snprintf(buffer + len, sizeof(buffer) - len, "%s%s", f++ ? "," : "", #x); \
+		len += scnprintf(buffer + len, sizeof(buffer) - len, "%s%s", f++ ? "," : "", #x); \
 } while (0)
 		int f = 0;
 		printmode(PCSPP);



