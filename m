Return-Path: <stable+bounces-235750-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCKkHUCE2mnI3QgAu9opvQ
	(envelope-from <stable+bounces-235750-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 19:26:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3B63E105E
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 19:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3A4D304A6EF
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 17:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222273559F5;
	Sat, 11 Apr 2026 17:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jqnq1WcY"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED2B38423C
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775928337; cv=none; b=Pm/Ukc3KttajIXJ+lgy6bFsBRBTJtIiSRD+ui7YQ1sEQ0s1Z6rOh5OmaIkzFcEzVVMoVStZPzf4/bzh/vP13nVWAohhHC+gIYHRazgw8mRl8ZFyMjnIVXGc/Tm5LbgfWlBQpwbxdXEwMRT2DK8wJhBvIzEu8761JraeilCeSdlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775928337; c=relaxed/simple;
	bh=nQZyAGrMxVThNUGnAdcbRva1SIwPO+IhwA8eyGR0Qw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hooYUdpadHDzrejqRx5ugafQhYLLbnOtnRsJ6fh+dekc4uYTusw4JKoub4hG8BM+DeoXL6zoax/xNbaa0cTiP3R8P9z875WRnH+rrX17uTrTui1umZEQoe4ES6FAyvU0jxdg4Dz/In3S7SokfwYw0n1+0v0+tT6aDgU3M5xttoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jqnq1WcY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4888375f735so28976805e9.3
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 10:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775928335; x=1776533135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOXSXCh84iBUSngCLJ4DDSW72dWCmCTu3pC9npTzVhk=;
        b=Jqnq1WcYwHL1msA43zhQ5+8LVj9hSaL+6kKU39zicIXzCeiZwMZYok2vqJicQ6oG9L
         zugYKow10Cc6ssL9iFbrQCy+P4oY+vXJTavHqmUwjuWi7C6+zlwdaDAgxY4ERNIzPIJe
         /Tb15811yP7GZLRlhwdw0UQtQl5FQj124+EWRk3UKMFP0NMIG9T51qWq7ty/0QUW7iaj
         j9Rcj9AiCqQ85ft74roLpL0EwEKeyX0vKWxrlW1Yb9uFwGsz86mtNch1l8zNy1OWk3qw
         Upw5nFNQjBOhs+z8GyGfhJ3OiWknIs6lGPmsI28rCO3UYL3SG+gyQK36mRMxMqxosGct
         AIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775928335; x=1776533135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tOXSXCh84iBUSngCLJ4DDSW72dWCmCTu3pC9npTzVhk=;
        b=Ta262Js2sdHqU2inMmCwhcZAM74qx2+Pd8hzpa+Fq2/tuLQc8C7CxkorEj/tPTu98v
         /0fAV3e8pvNr5+fQpMFs0d0Z/Bo3cY8YnkT+6jZePPeFFsYxh9Vh2SpVDnG6GeWsk/CF
         V41sbQQlWcL55K3sOkYSZMu3VxLO3cslx1mXL1ltcGOdLbBMdObnqhq/RLrYmvkkVubd
         7Xi7L5F5jrF9pyDg13lWLxIrKjlCeSihFoGGGP+EV8/NsACe1pYwWD6PTD187ibSbwzs
         NX0bA8GDpPeMzgstnztChcFohnbneTIg17ublEAY8PEEJjI5z6M/y+xsUR/YM7KBdwry
         oi9A==
X-Gm-Message-State: AOJu0YxeqNjl/HZUE1DTjmt1bPLsAziGUnuQ1pCACu+RJSxYm4T2s8eh
	VUlhBEcVtadqIJQ+5EtWjIZso9OkAoMws/kpTnmSQarBIqRQMck7iZ/w
X-Gm-Gg: AeBDiev6iPdKbVuJWKEALuTw5QU0nIj2+K5QlaE+fjETOXylw6BdV9qg50lSQvRx2Pc
	hsie7ZleFtT0/+b86nQ/rMFLY39jqhp5skMIu2+ItdZC2bXaib+/hlPZakhgXKbmQ2twkm3uk7q
	hpy5vy/mYAc89yKXUdIsD0LtMV23qi5xva5AHMWgalBT8whZhlyKITDhRArV2tgdAxJ4DYfq3DF
	SpavE5982EEsCuPoW4eM5pETgHVyT3pckEBS8z2KnoyLjlXWUXvj/se8BTEEp+HUzanDLbZQpE0
	oHi1R4M7Kk21Zy/oVOuPnyvj+kQBPOcAVKi/6/oj4yZJ4iEsBVUyzTuuZYJv9HzEPS+CHc2jid6
	QrchH21GMZ4MIyhnpFdfCzCqW1JpSerhmQIYK8yvRidPRvNBllgHM8JMI5FR4Wi/q98fROF3r47
	O1L1uG85REV9pRmSl1UlRxopv8t8yRj36SUGlgrmA=
X-Received: by 2002:a05:600c:a416:b0:485:41c4:e2e4 with SMTP id 5b1f17b1804b1-488d6860571mr66964945e9.23.1775928334847;
        Sat, 11 Apr 2026 10:25:34 -0700 (PDT)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67b4903sm64176515e9.5.2026.04.11.10.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 10:25:34 -0700 (PDT)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 1/6] gpib: Add enums for INES 72130 based cards
Date: Sat, 11 Apr 2026 19:25:06 +0200
Message-ID: <20260411172511.26546-2-dpenkler@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411172511.26546-1-dpenkler@gmail.com>
References: <20260411172511.26546-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235750-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dpenkler@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE3B63E105E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add Chip type enum
Add offset for 72130 bus status register
Add bit masks for line state in 72130 bus status register

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/gpib/ines/ines.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpib/ines/ines.h b/drivers/gpib/ines/ines.h
index 6ad57e9a1216..22af59682870 100644
--- a/drivers/gpib/ines/ines.h
+++ b/drivers/gpib/ines/ines.h
@@ -21,6 +21,7 @@ enum ines_pci_chip {
 	PCI_CHIP_AMCC5920,
 	PCI_CHIP_QUANCOM,
 	PCI_CHIP_QUICKLOGIC5030,
+	PCI_CHIP_INES_72130,
 };
 
 struct ines_priv {
@@ -162,4 +163,19 @@ enum ines_auxd_bits {
 	INES_T6_50us = 0x10,
 };
 
+enum ines72130_regs {
+	BUS_STATUS_REG = 0xc,
+};
+
+enum ines_72130_bus_status_bits  {
+	BSR_NRFD_BIT = 0x1,
+	BSR_NDAC_BIT = 0x2,
+	BSR_DAV_BIT = 0x4,
+	BSR_EOI_BIT = 0x8,
+	BSR_SRQ_BIT = 0x10,
+	BSR_ATN_BIT = 0x20,
+	BSR_REN_BIT = 0x40,
+	BSR_IFC_BIT = 0x80,
+};
+
 #endif	// _INES_GPIB_H
-- 
2.53.0


