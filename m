Return-Path: <stable+bounces-233502-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HCcHoWn1GmkwAcAu9opvQ
	(envelope-from <stable+bounces-233502-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 08:43:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E911B3AA63B
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 08:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAEFA3055430
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 06:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF70388E70;
	Tue,  7 Apr 2026 06:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+Ma0meQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9869323C4F3
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 06:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775544036; cv=none; b=STXgyCRPlLcVpTN1JRHWpu3KW6Jpuzq4ydSFXBsw+F1tHG9TFzOwIqDo8S+MX7/7DxLukjnXbEwXQpTbvPois4cAdLm1J2FJVh4QDZRin/uXsA65D4+aZEPG7Cu6WERZhSw8whuQXe+umL3P4DXQnY0fwAsouKSE6JSnZLMma3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775544036; c=relaxed/simple;
	bh=PXH0Ixexzq4lbu1fRyzM+naW8Di7HO4c4pNCbFLJpSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ERpRM/lpY9wIp9gRc6RI4vZ+pss+d+R3uxdYUokrN8M2M4sI8IdQZjO9OtJ5patGYdyqUNTdhLtfI/Yakswm4uQ3OnTqlVFnWFayzXJw61S/gCRkISShaHm4VvFCbWlSOTxbQS8YCYdTjnsYNFDNERcjLq28V9WQXA+eN93VNQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+Ma0meQ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c76af79f029so1858278a12.3
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 23:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775544035; x=1776148835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wy9jQVOnIYjxy7FWem5JONQKIoJoRbyZ+S+kpmjt+7Q=;
        b=B+Ma0meQAYta8Py4pKX8zi8JHd5JY0A3rpW3/FO5X0QrLMwFiHHUd5slvkKYPkl7uj
         TVlGxNnBnCfGn61xGHVRYhyb9D/ldNf3KRJm2mXhcIWt3sJP/d9NDhnOe48L7ApTDFiM
         krPEfGQJf3qZejZJ7hQC2IqnmJ3CE+icNEg6LM9Nafk6JlB1BVmW9dclgguwXVH/mRVC
         apM8l30czuWVD6xwokc/iDtzP/3X0CwzO5lHWMzpuU9aVj7wprv9h7SCQS4GJ7/jXFQ7
         8ocCDJWE8ljUhRp7K/+ZMR2I5on8RuSOsxKUo/MDZeJXYdlB8Fo52wy6/xe6xkFZlihk
         Kkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775544035; x=1776148835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wy9jQVOnIYjxy7FWem5JONQKIoJoRbyZ+S+kpmjt+7Q=;
        b=DeguQZecoErlrRZrMs9tb9X5qzv0PU2gVEoH/u1K2WqZ72aHIxiBkTiNbgs9iYBDC7
         P5zRWNsJKbr223JlY91L2qtQ4NOK87dmgNuUYwiHTqGd8aztMq3qk580BoRSNO4/82JA
         jJiYRfd7x8bnanJUDSwaCjBPt469OQ0zKNEITJe1nmHpKR9VkCYXBEe+B0GeO8A3y1on
         lPvABV/wCHU0xMmrf0gHycp0stli6m+pUtFHxlsRJ72RDn7hdi24z0GjKWQ+W3+KPr/2
         7apW8AbQF1K6XZGzFvsOVjwBIE8k+hskushFC/6KPmFDtZ3+IKN16s7JxFy3xT+0MLDs
         nDmA==
X-Forwarded-Encrypted: i=1; AJvYcCXDqWJddX4sKMCMrfrhVWTqw3QfNT3sr0XoPFmKqmRGCzPCZnf8+OhSCAwiFn3rF/9qoOo6cqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzOPZEhJiQvKzrzPejYUiSNDAJCLEF04zn6c5DP3jeMvUlz5qQ
	FqRC3M1MGQVbxlxD37XY7Tg27/Q8wNhhLCjqleK0Xa6UhIVQKgPyR6gp
X-Gm-Gg: AeBDieuL1xSWSxKbMaikToKZ+1jKAWiYSD/L8MI4SvLaxpDfwo7h06CWa4BB7YwVl6K
	GQOnTcqZPQHRYN3YpLHiq4PLoGQiVlMMIJp4icLa0jmSt3Uoszxr7V1Qtc2pZ/T5z3hDN2tjWLD
	Q422y7MoxZPUiXSiSTrdrqVg6bA/NrAfUV80dUHZwEshI9YzZkmeDJPRcHiiGIEFmsDyU+cb9wr
	+vag5dgVICZ/6xoYQ8JcG/xRTIAx3c7VB/QgSKSIjP9IM9ynG+9DcQCysmIAbu8n3Mw2SzK87pZ
	IDmWlmdMuDq/8gplPWQZIWjoNpK8BurdNFwZcAa7KWC3hvOGVM37osQiwVASlseP6iMyujOfoxP
	8KBd+GNOvkuRmOBo2ktizPTi1W9vh47XB/1iN+8TWFCrD+5+rCD0BhBTSl+Fb70Y9D11mNW3Afl
	2fcRfOSHXpxLnF8V8JYlDqw7wN/Jw/k4oDYufMcI7i3tY5zUVklEJyjthPkJ1Jo7BQzWQkbrg9e
	Zk2plqum1wX7oSC
X-Received: by 2002:a05:6a21:9983:b0:39b:fbb2:5e31 with SMTP id adf61e73a8af0-39f2f09eec8mr15328230637.43.1775544034900;
        Mon, 06 Apr 2026 23:40:34 -0700 (PDT)
Received: from localhost.localdomain ([45.248.78.44])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c65995a9sm13954320a12.27.2026.04.06.23.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 23:40:34 -0700 (PDT)
From: Nathan Rebello <nathan.c.rebello@gmail.com>
To: gregkh@linuxfoundation.org,
	heikki.krogerus@linux.intel.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tiwai@suse.de,
	stable@vger.kernel.org,
	Nathan Rebello <nathan.c.rebello@gmail.com>
Subject: [PATCH] usb: typec: ucsi: skip connector validation before init
Date: Tue,  7 Apr 2026 02:39:58 -0400
Message-ID: <20260407063958.863-1-nathan.c.rebello@gmail.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-233502-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.de,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathancrebello@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.975];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E911B3AA63B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Notifications can arrive before ucsi_init() has populated
ucsi->cap.num_connectors via GET_CAPABILITY. At that point
num_connectors is still 0, causing all valid connector numbers to be
incorrectly rejected as bogus.

Skip the bounds check when num_connectors is 0 (not yet initialized).
Pre-init notifications are already handled safely by the early-event
guard in ucsi_connector_change().

Reported-by: Takashi Iwai <tiwai@suse.de>
Fixes: d2d8c17ac01a ("usb: typec: ucsi: validate connector number in ucsi_notify_common()")
Cc: stable@vger.kernel.org
Signed-off-by: Nathan Rebello <nathan.c.rebello@gmail.com>
---
 drivers/usb/typec/ucsi/ucsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index b77910152399..7df3a7b94a40 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -43,7 +43,8 @@ void ucsi_notify_common(struct ucsi *ucsi, u32 cci)
 		return;
 
 	if (UCSI_CCI_CONNECTOR(cci)) {
-		if (UCSI_CCI_CONNECTOR(cci) <= ucsi->cap.num_connectors)
+		if (!ucsi->cap.num_connectors ||
+		    UCSI_CCI_CONNECTOR(cci) <= ucsi->cap.num_connectors)
 			ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
 		else
 			dev_err(ucsi->dev, "bogus connector number in CCI: %lu\n",
-- 
2.43.0.windows.1


