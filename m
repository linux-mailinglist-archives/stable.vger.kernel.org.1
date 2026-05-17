Return-Path: <stable+bounces-249094-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHDNHSXICWropQQAu9opvQ
	(envelope-from <stable+bounces-249094-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 15:52:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 146ED5614E1
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 15:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 043FC300C9B1
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 13:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1581B27FB37;
	Sun, 17 May 2026 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3JaCQUP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FD427A462
	for <stable@vger.kernel.org>; Sun, 17 May 2026 13:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779025944; cv=none; b=cYwflegoVevvEsft+sW4cemS5YYI4J84B7ERX5LOKs+EpE22RpmJ6f0nLBmbf5F4UDlBhpXzV0FToHgLHmPezv8uqiT57+D3UkiwMQYq8XbNjQAG08pb/kysZS1BghEVOo8+xecTKGyPyWg4clzlE1lSpUbMMh5AWIsMQLDHGl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779025944; c=relaxed/simple;
	bh=9OSQaBLb6900xltJAuoF9h1NtHtsGHcKQhKm5xgD8FY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+za2cSjIPh5pNFRCSoQ7zHblkS66IedfGmtvnf499LIhi+RaWqGC78p173Zi7ZGjtRtQBddOWPxWUz3MPXLh54ONLMn9+OmGx5SP8dqlTzlpxmk6EmatP9lAJSfNvJmGcQXmuhqlwB+c15z73ABx7vTeQhtM+mXdPlCNAZZBSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3JaCQUP; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2adff872068so5596005ad.1
        for <stable@vger.kernel.org>; Sun, 17 May 2026 06:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779025943; x=1779630743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+H1HXfC+KayiHQioTXzdTqJjQu2X0tkOK+rOlXJhQQ=;
        b=g3JaCQUP+OuMOAGhWJkaEqZXsNt+VXIFiJfEvETUfhLWJca8C0FCmeyaxF/C3krAHu
         jiOY30k+Gz4wSvK3DqaHi5uAh7/8yJ4KZm1r0d3j6mJszwILtP36/sd+qr3+bBmf3Cdf
         QGaZCCFUQxOR5HrWsGDG6CjN51QdCWUthg3rU8sbhDlYcla2Fx2gaFY9+PVfAO+Ry4nJ
         R96yLzkvJ+GAbW1LOzUv6exOaXsaUoVFwKcBqt81ELlMmNeXlNz0GbZ+SMeGXyLrk5IH
         OcUDZZkZI6rov30hacpjb2sAzTM/nRiONWVgn2Lixbk+WXnCxNtCD2BxafA7ylA/IY+M
         Li+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779025943; x=1779630743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j+H1HXfC+KayiHQioTXzdTqJjQu2X0tkOK+rOlXJhQQ=;
        b=rzTv5b2JR3EGbKjZ/4cfXXXR0mwOsBbv+7As+D+dMU+79Uiv5KMv0UTe94BA2U7foj
         X6gmfsVZTUb3MA6/C1gGh1quS9L6g6Wd2iAGn9P6jaXN//6o6K0PbPg/eFMTRiJ5kEtI
         8vIRjOmo3EJQXdPI+6EAy/Np03+crO2dTGBLQ0ZLS6zqCy5Cg/6KyN43TFXOO0GtkPXF
         yQlxgeqTbVPEISef970LobdIQiyjfa1sxDfsNGW9NoPSu6BLUwm4tzRt2zas+CzMW3D1
         OGupnzl2l9YG9RCjeG/czLXqaUEBVy4HwrA2WtToVcLQH4He7tZENAKZhmWg8r4jddpm
         b0ng==
X-Forwarded-Encrypted: i=1; AFNElJ94MnplcxU4fxXPhUTqZR417T1R1OiHKX95ldPsEoqw/dJe4QA8jQ1/DN2lXAQ9ZSy9Y3hkhEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeLyHMI8LFh4rMDL0dw8K+XhAvp/hJklcutuNxXDUkJ9cBsNIV
	f8msG6ctOozE42VMkn8wE/Bz1qMLTz6UzfJxueY1WHXG5kQyp7kUuWCo
X-Gm-Gg: Acq92OETreaaIlsPt7Mp+ejd8oF4ELer/KV83T1jg7psAIrw+ilqHcYdE5ACFOnmY8E
	LRqATwl2RbIxSDaGxNaYkCE6+4B0BpCw/fhIglrwQ42HIJ3lrGUz7vrDrhhPsmR+arn4eom2VDb
	TfIf/PldQphVHGAz/+A+s9AJt8Ug3QIYIszq9OOqladWkVMvFU3jKEWTdjCZFzZWTCPysFwBjSN
	h8BZESey0KIhocqy5V69MXW13CBtv9oyYi7dGGel6P/v2hrE5sU2DZJ2iqj0JMMjTSjber7OuFB
	JtpB5Ex94W8DkreiDkIWsvziOMToJfCGYZZ21Yu3vhsnG87laqpC83Mew2Uwp9LvRTRqxxtDzou
	pNOSE8wt9vljKrvMel0DWzV4E9J3Fb6F75NhtrqVdsPCFk4fNSQPYfddob9+hJgqFcxOpEgG+yX
	fglCLcf/pobPQqq8H6g00vWJw04XhKJpQFfTOzI64DjCAneYGZ
X-Received: by 2002:a17:903:3c6b:b0:2ae:825b:49a5 with SMTP id d9443c01a7336-2bd7e415675mr118577905ad.0.1779025942850;
        Sun, 17 May 2026 06:52:22 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fc47sm113873385ad.10.2026.05.17.06.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 06:52:22 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>
Subject: [PATCH 2/4] HID: wacom: validate report length for DTU handler
Date: Sun, 17 May 2026 22:52:13 +0900
Message-ID: <20260517135215.2220117-3-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260517135215.2220117-1-jinmo44.yang@gmail.com>
References: <20260517135215.2220117-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 146ED5614E1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249094-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jinmo44yang@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

wacom_dtu_irq() accesses fixed offsets up to data[7] in the raw HID
report buffer without validating the buffer length. This sub-function
is called from wacom_wac_irq() which receives the length parameter but
does not pass it to the handler.

A malicious USB device can declare a small HID report in its descriptor
and send a matching short report that passes the HID core size check
(csize >= rsize), but the driver assumes a full-size hardware report
layout, leading to slab-out-of-bounds reads.

Add a minimum length check in wacom_wac_irq() before dispatching to
wacom_dtu_irq().

Fixes: c8f2edc56acf ("Input: wacom - add support for DTU2231 and DTU1631")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
---
 drivers/hid/wacom_wac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 6d06842b6..873d58a6d 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3472,6 +3472,8 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 		break;
 
 	case DTU:
+		if (len < 8)
+			return;
 		sync = wacom_dtu_irq(wacom_wac);
 		break;
 
-- 
2.53.0


