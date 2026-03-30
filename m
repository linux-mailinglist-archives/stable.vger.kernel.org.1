Return-Path: <stable+bounces-230989-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLWIMfHfyWn83AUAu9opvQ
	(envelope-from <stable+bounces-230989-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 04:29:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3596E354CB9
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 04:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCF0E30180A7
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 02:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A74B391E7F;
	Mon, 30 Mar 2026 02:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtH8wuXn"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C76F34CFCF
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 02:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774837679; cv=none; b=Fw3r7dgczMMbbXL6x4vfrRL9pysM/MBhnKpjBldyjx2L3sEIH81DlpaYpHJA37BEz+GkJATXJ4sFwXvoUw+q0k8eyTmkP1G4TkjNodsd3saezm3zj2snvs7EUrkKVsOssMG7ZZ6OXDNDiCX7fgf7k2C+m08ezzJLS4tiZZ2Vy6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774837679; c=relaxed/simple;
	bh=vZyq9h3vkeF5aQxGQqlBRMFtAQOkVVXTBRKDh1HO88k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=G3Ltogc5sYSUlC2ABs5wFURBnX1xLz1Ymp3WbqL7Alh8MyAyvdlhjkVzGKacKGqwVUsNpLw/5TIgHqPi4c5adrpol8m/bk+wNAGVAVyhlRVisbDQ6UGz1aKR7U1J161uYMUrd7lD4JeBbzC8VktUGHglD/j7QfsHZHRd6P1WzqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtH8wuXn; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so7886172eec.1
        for <stable@vger.kernel.org>; Sun, 29 Mar 2026 19:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774837676; x=1775442476; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ySc265PnZwbX1P9RXTWeU43Uza4/FiDlEOhs0dGdd68=;
        b=JtH8wuXni2mMdjU6drtXWKPdFHwyNXPyWbSMJvY/a5cOYX+RPOHzpaza0CLgGBGSVN
         S/eSERJmJisZEkZWrEpMWN2WOPScx95vo6OaYMDQb0XLSyBX10jKo2vsuQGdh4jP7Wal
         dSolkSPtx8UYH+9Btuw7wGwkMnYpRzC/MDLdokRH5Jv8Gi+/l6U/d++ZyxgqazkhUMJr
         TPu7TTZFERkDXjm+rokSaXIT3hZPfqb9eYvi9Vc6rI8Wx+D0dZJ+3/AR0cePqBK8cQLc
         FKBl8i9TbrA/pzSMlUPFvqW8XGFR85XWFD4IHqrlKd8hZJw+rIAGBFXY+LakH0QCQZaF
         uhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774837676; x=1775442476;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySc265PnZwbX1P9RXTWeU43Uza4/FiDlEOhs0dGdd68=;
        b=sxRIr79aRMsv1QbsqW4/IYnzMblTg5EvpPBhxklkY/Ycw6q+cyr3m6VH8zPXWEwkxT
         bSbYDfrqXDB6QeVchGs7/HX1VMzhCWOBAjtlqgr8oxSMhzf4EE2/oGAk/Da5UXVCdE/a
         9roT9TisZS9RJKFXgwsfRT//zdBxppZ/2dLVJagp7EhGlLMKYX5W2R7qZAicgop2nbkd
         Xzxdr/15QY8zAEA7vyOvTO3Lgu7D8Rwuxg1wtpcxuvtNSL17oPFRyMis3GLZhMHl8dtb
         JkK4hM+3ju2PavgF3Ac4J7D3YWSFrn15BUlB8en6SN8HkUgjnjAP0g9G2n/g1Pvp1fiP
         lUTw==
X-Forwarded-Encrypted: i=1; AJvYcCX0JXDM593Yb6wH4eBjGG1wdErgpv5SiT/BnCRR/O5nSxVms0VLCyADfTIpNNJIAhARWy4YavA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKoSULFJoT6KdaG7iGYg4Qr2UXewf32Ws6/W2nd27vrXv3Bp2y
	LUC98F/08arOFn1yDyRF2+p33SR95U/qbDqYcDyBJ62hJhtkqsaxd/iW
X-Gm-Gg: ATEYQzzRxeEPONt0EiwiUI8iyNRZtNZPcWJBcgJpblAr25/zkH/CT86zg+Zf0hzXAaw
	OTpt9MpX07x6j1eOtrH0xjDgr6sDNcyvukCGn7T4zHQpD7EwmBw/HTsftYy7mXD/c0V/44YaqI5
	XOg7CjIOLJ0k+9cAj4igOGbxfL6F5xWyItGCuB1x1J5CPd8ok+ECptxU6QvNtDFJzIuV6MWrBZc
	N3IgiIkakP4b/dENIrPd3zKf+77xPxZc2czqV7c2THalm+We2Rs0o5PEdi0dFVQBQEdsMVtoMAT
	1i86Lsofwf4byB95bQFbaM9EJaOjyU3cZvnDiFcwTXFcEiihpg6GPjcO1S7fO2CdH+DzR1LPB9y
	yPGasMaMhf5HAcY6ySKkvEoqEZ5Z4juL4+XSfmGW3gZPrizk3a9e5o/0z94yEGVRiNcwR5drCC+
	nKqMbZmIjCGtHHMLnvSBhQHZbqlDWKxjDOW4l266qXvNGzGJTZuo7Gof2vdn43j0JFYYkqZAOu5
	JVpngOMxBS/Y24=
X-Received: by 2002:a05:7301:a03:b0:2c4:4276:709f with SMTP id 5a478bee46e88-2c442767647mr2600127eec.1.1774837676295;
        Sun, 29 Mar 2026 19:27:56 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7265:773a:8e51:c62f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c7971d97sm6250673eec.30.2026.03.29.19.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 19:27:55 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 0/4] Fix handling of GPIO keys and LEDs on geode
Date: Sun, 29 Mar 2026 19:27:47 -0700
Message-Id: <20260329-property-gpio-fix-v2-0-3cca5ba136d8@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKTfyWkC/22Nyw6CMBBFf4XM2jG02PpY+R+GBbbTMonQpiVEQ
 vh3K3Hp8pzknrtCpsSU4VatkGjmzGEsIA8VmL4bPSHbwiBrqetGKIwpRErTgj5yQMdvVEJdtHH
 OWGWh7GKiovfmoy3cc55CWvaLWXztryabP7VZYI1X8zxpUo7O1t390PHraMIA7bZtH6Nd0K6yA
 AAA
X-Change-ID: 20260315-property-gpio-fix-51586cffcd5d
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, Hans de Goede <hansg@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 driver-core@lists.linux.dev, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-a6826
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230989-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,linuxfoundation.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3596E354CB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series deal with breakage on geode caused by a recent conversion of
the board to use static device properties for configuring GPIO-connected
keys and LEDs. The issue was that PROPERTY_ENTRY_GPIO() would create a
temporary structure on stack for GPIO properties which would later be
discarded.

The first change patches the behavior using existing in kernel APIs so
that the bug can easily be fixed in stable kernels, and the other 3
improve the API and add safety checks.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
Changes in v2:
- added printing offending propety name in patch #3 (Andy)
- Link to v1: https://patch.msgid.link/20260323-property-gpio-fix-v1-0-9cb46e5fe7df@gmail.com

---
Dmitry Torokhov (4):
      x86/geode: fix on-stack property data usage
      software node: allow passing reference args to PROPERTY_ENTRY_REF
      software node: verify that property data is not on stack
      x86/geode: use PROPERTY_ENTRY_REF for GPIO properties

 arch/x86/platform/geode/geode-common.c | 24 ++++++++++++++++++------
 drivers/base/swnode.c                  | 10 ++++++++++
 include/linux/property.h               |  9 ++++++++-
 3 files changed, 36 insertions(+), 7 deletions(-)
---
base-commit: 3b058d1aeeeff27a7289529c4944291613b364e9
change-id: 20260315-property-gpio-fix-51586cffcd5d

Thanks.

-- 
Dmitry


