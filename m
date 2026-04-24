Return-Path: <stable+bounces-241027-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPbVLY3E62liRAAAu9opvQ
	(envelope-from <stable+bounces-241027-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 21:29:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD7B462EB7
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 21:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A069A303EC36
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 19:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC5C368975;
	Fri, 24 Apr 2026 19:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b="PTECPSPr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com [209.85.210.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491C43EF647
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 19:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777058776; cv=none; b=k8HCMDEn3r7ZcXPHm2vdp1/Ge1GegNDks9776D8lcipwCZcUBn0dEnnHKUxpGdZsX9fDP3f2tImQUMKcV7PW8mVXqAMjTsybNYaZLuPVABWiMGv94JS7ZBwgr18uFOCxnsFT2eQxl46EoVg9GqtwPuBNGR7N7xO2KiUGyofOMCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777058776; c=relaxed/simple;
	bh=f8F+G7T8R4oS3yvKvZ5xEurtwNv5Rd9FkWBah5DjZWM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YE8p4aZ2COE2Q8UK1qeipPXiIossNAQpj5VFGk0Q/UIVc+ulnLD2EfeX5qm10BGsaLWcBG+XdF9ozErRobyxqUve1M8wrQAcK9C2H9R4YhuoKpmczafvr1TyLHLnJQagJxBjWOrphe16P01dOltLd4gOzLw2nVYRXF+KDYTA2og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=embeddedTS.com; spf=pass smtp.mailfrom=embeddedts.com; dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b=PTECPSPr; arc=none smtp.client-ip=209.85.210.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=embeddedTS.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedts.com
Received: by mail-ot1-f100.google.com with SMTP id 46e09a7af769-7dbe437b072so4703623a34.2
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 12:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedts.com; s=google; t=1777058772; x=1777663572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aqoq5cnoiQ0y9ErqwI6rgFHvZuVVz/D839q+d+059Nk=;
        b=PTECPSPrduHgPOfOmV6TGiKB2r7+lRAhMX58OEjdQf52KslXHZWgKmlykxETWnia1E
         fHRMFtINjVyyJXHib+1OktGLN4EBDkYcqLumhXQpxCAGGdskb4yBU7YIuhA73OLEpQSR
         z6jTU42c/HfUlZS2sVWgvdBQoxFwzGbQKWJRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777058772; x=1777663572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqoq5cnoiQ0y9ErqwI6rgFHvZuVVz/D839q+d+059Nk=;
        b=d64OFPeQfjKU2attH3zA44Ejetc4MWebxlbzxOxQAJvKBscERiQtlM83eQXknuMYX/
         WPaIcsMz3EmweNXaC0Do93mZcZf/R+CmAJrLpvB+Ng6AuR5KgwPTVfBHjOiNLc5XG+9P
         ulk+Mlht6IEWnByEfONsB0YHlRbdg/52haj1KJKlkr2sTo9BQ+o1Xwzbg/ercDQWixeH
         fIb3EMJJ4H3lJXpvv+iKtzzscdgC76tc4/T2eR6UfpVUGh5RKffdRCB034EDtqAfbUCt
         ytkTkblIlnqCVtNtMhou0aGQJ7XnVoDToxKOWelD6pWlABP42JBD6vmCM/YsWbrApi1F
         ROTQ==
X-Forwarded-Encrypted: i=1; AFNElJ+CWYJRBBIxBOexrbwJiyp/vjymyEp26IVBd+T9GL33UIjyT1PTbBdaPNhq5m7qJzJjvHOb+y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YztB9E6rh8oQzDTe7I8SkhMwGl7+lehrUoCuO4UnqqiN545khho
	6jcYtqYgC1jjlHEWFcHMesc5ozxi3DvZKUsU4cdJiWQtuaA3zE/tAZBbk4PpvErJM0Sf5pYt4Fg
	6JS3gokrH5fNAz7L26LwGB6RHLRXa+JeWEjUm
X-Gm-Gg: AeBDieuNeNsvDbs9+Ywj/5A9YCnOqN2L4K7DozRDkkAZ3g2BP7ZbYtGqYXEKyMU3f0f
	nDmMn4FHovjGL+YL5cWuVB3XZ/b58X5kJjCeiJvC9yAKCPk6vCK44P1XYng9BGmNr1k7NmjRtNG
	mCKyN9OFPPMqYSWEvsDPXDxDD0qy8hP1rdvfEhB8++X3n9EFDJk+0E77J3eMgCqZi2kiqb0y0hA
	+/iGeaDUHmmDy9iqjO3XZiPtd3rCDRosVdWp2Atkb7AMLh9XFgmrb0FWx4udi41ClrtYABRLHIN
	FW7WEo3f5MOglsso8waNBRQ9PKM4/Pmb3G+oiVpYR5obXgePS7IKtdlj2lgHcU0FFaDdjK+72R2
	6r3XXJRxAghLINKCZgVDEvpMoXiJwHOofM91qGIFQU7eq4OpJqxeCM7aQ0fs=
X-Received: by 2002:a05:6820:8c3:b0:67e:447e:d1a with SMTP id 006d021491bc7-69462e21352mr18123352eaf.6.1777058771728;
        Fri, 24 Apr 2026 12:26:11 -0700 (PDT)
Received: from tornado.. (wsip-70-191-90-18.ph.ph.cox.net. [70.191.90.18])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-69464e60aa5sm1275226eaf.7.2026.04.24.12.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 12:26:11 -0700 (PDT)
X-Relaying-Domain: embeddedts.com
From: Kris Bahnsen <kris@embeddedTS.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Marek Vasut <marex@denx.de>
Cc: Kris Bahnsen <kris@embeddedTS.com>,
	stable@vger.kernel.org,
	Mark Featherston <mark@embeddedTS.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: ads7846 - don't use scratch for tx_buf when clearing register
Date: Fri, 24 Apr 2026 19:25:34 +0000
Message-Id: <20260424192534.3504976-1-kris@embeddedTS.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5CD7B462EB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[embeddedts.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[embeddedts.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,denx.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241027-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[embeddedts.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kris@embeddedTS.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]

The workaround for XPT2046 clears the command register, giving the
touchscreen controller a NOP. The change incorrectly re-uses the
req->scratch variable which is used as rx_buf for xfer[5], so by
the time xfer[6] occurs, the contents of req->scratch may not be
0. It was found that the touchscreen controller can end up in
a completely unresponsive state due to it being given a command
the driver does not expect.

Instead, rely on the spi_transfer behavior of tx_buf being NULL to
transmit all 0 bits, moving the 3 bytes to a single message.

This change was tested on real TSC2046 and ADS7843 controllers,
but not the XPT2046 the workaround was originally created for.
Confirming that the original modification to clear the command
register does not impact either real controller.

Fixes: 781a07da9bb94 ("Input: ads7846 - add dummy command register clearing cycle")
Cc: stable@vger.kernel.org
Co-developed-by: Mark Featherston <mark@embeddedTS.com>
Signed-off-by: Mark Featherston <mark@embeddedTS.com>
Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
---
 drivers/input/touchscreen/ads7846.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 4b39f7212d35c..599793d27129e 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -327,7 +327,7 @@ struct ser_req {
 	u8			ref_off;
 	u16			scratch;
 	struct spi_message	msg;
-	struct spi_transfer	xfer[8];
+	struct spi_transfer	xfer[7];
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
@@ -403,16 +403,11 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
 	spi_message_add_tail(&req->xfer[5], &req->msg);
 
 	/* clear the command register */
-	req->scratch = 0;
-	req->xfer[6].tx_buf = &req->scratch;
-	req->xfer[6].len = 1;
+	req->xfer[6].rx_buf = &req->scratch;
+	req->xfer[6].len = 3;
+	CS_CHANGE(req->xfer[6]);
 	spi_message_add_tail(&req->xfer[6], &req->msg);
 
-	req->xfer[7].rx_buf = &req->scratch;
-	req->xfer[7].len = 2;
-	CS_CHANGE(req->xfer[7]);
-	spi_message_add_tail(&req->xfer[7], &req->msg);
-
 	scoped_guard(mutex, &ts->lock) {
 		ads7846_stop(ts);
 		status = spi_sync(spi, &req->msg);

base-commit: dd6c438c3e64a5ff0b5d7e78f7f9be547803ef1b
-- 
2.34.1


