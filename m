Return-Path: <stable+bounces-272503-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XuvnLfVfTWo2zAEAu9opvQ
	(envelope-from <stable+bounces-272503-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 22:22:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 112DF71F823
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 22:22:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="Tih0d/4v";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272503-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272503-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2ED13012D10
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 20:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5877130595B;
	Tue,  7 Jul 2026 20:21:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BD231F9B4
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 20:21:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783455710; cv=none; b=DtJ++4B7A3GmMKxGQZ/0uWYkehq7TZtyCtFL13yvfdh/gGw4fijavJ0Y0H5drTv3IFQ80J7JTFv/FCS7TwTe7q5U3ISyHno7Z2J5+BR5lItlkD0cm8HF7UgFbiJYKVBp+UKexJB44gZtXN9Or4DewwLZCHyn9AXF4MszKjjfXfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783455710; c=relaxed/simple;
	bh=dKwM/3n0efJG7ZRg/nY3abzZr+UYyaTJWkieSpTZlc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a3I+HTKpTXFqKCDGLUKTdrTez32q424JdTsGJRc48c7AeRmbAPpoYqDJn4lFhLNZG5c17sGgNfpkvVdQf3BdjgNTUotzUAk9lTzaiz22QBjzi6yncPcxdOCnkIp/VxZuKF/32VoLxPZlczw1LgmnyI0bcMXWkDOWuE02uwm9Gyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tih0d/4v; arc=none smtp.client-ip=209.85.208.45
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-693c51a8a19so7093797a12.3
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 13:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783455707; x=1784060507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mm3elO8712GK4l4hbfVHYSLDXC8IRHmSwT+OSMs7O8Y=;
        b=Tih0d/4vPPDSe3o0OXqKuyWStjsL1pzbuoXwmJEgXMQNOLJ94V6TJM00naqPDsDp+H
         khsq3fEhkY/86aEOyegHaG1YhQTxeOS5WD5KYJpRcKXzwPV9Vq6rSUJnf8WeSkkMqpF1
         R8FYlibvmqTJbw8H45t9ZltmY1RhwkqiU+PqkhMa4Tk1L5BWBnacmT9/UWfUXIi7j3cS
         6BcejqZPgcavLAVfsLXIt00KMOLpY0jrKe45OMb48XQpZ6ccx651QSUC8RPIRwV/BLHi
         I0JcWaHvffLsfwwNXFTJX5MDg5KkRcZS1dUDXCT7T44n/lRHzT5vIDFpqAMQJBxvuIQ2
         0TTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783455707; x=1784060507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mm3elO8712GK4l4hbfVHYSLDXC8IRHmSwT+OSMs7O8Y=;
        b=gCnkylAQEa9vCq9oCIuQTgJMT3vd3pL3BQOG5MSlfpFxk4gxXLJ4dYb/XFqDpNfd8L
         9qyW3sSyCp5NoZqdgONN7cBN3DOwK19V3w50ynp6kAKYZd4u4HqHbUwGdqdcBvxNy4UM
         Eyf+s0+Q2MV1rrJyMElG7dx3L/ACVYjIWkT/TKVwBX513Lo/hkDc0ySKhYk6rC83B7IG
         d38Ut/G0FcHmiycT1HEz0ikGJ+oxZmHEwBPWWHVULzkG6BpV3vjziiaJXIDRZCOozxkG
         ZAYysGE2/Ok9hImP9bfCUH41XAB2FZssAmN4VaBNONDg/rPAvLPiaD23wjhACuiou/5L
         /p8g==
X-Forwarded-Encrypted: i=1; AHgh+RqyNv+ngba5aBW309hKgljxpOVeGMJpAH9ltJPLSon3N1hqHDm5nTRRqZY+2xFybua918xWK6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyah2QnTcL7cBLma7F7wAGpEceD5y8LCWPZh7Ptb+yWieqJXSd2
	3oLomAsvgZiDfHn6AwvBkl93FPqDdcO+vVhILs578YFSrwwj2Mm9cY4H
X-Gm-Gg: AfdE7cn5NPdWNRG15I7i5MncBI4cwFPQRtg1IW0zuUCu0PoXDnqIChh2UoE9dM3saY1
	IVvQSX5mqDPDYJBe1/zF5X2uEYwmZhBTMQpXiFSbHH8J3tysWSi4zNTbFmY+OdCfGTpjEJYadga
	midaQmcYwoYFetaf3qg7DDzoXuCz0JE/TRNfu7JaJYgfinEmXrIcpro2oL6FJFzDlRMLoIG73gY
	d0lZxfb9lntvqwG0mSj4hYyM3LZBb6yAlf+37VNt3yrPyXUZZhQUph9kImYPrn/XG+8EtnJHR8R
	dAc21Eyr/EUSduh1jDvFC2X4lTheNqf3yDe/g03O+Y8RHNTr8QSWS1imDmiMNJhXWmdHI5kgtqx
	T1XJnDsxB7h+UHFGKBGHLJuZIxt25HtOip5VXAbwoSNOYNzjmjaWRtLbKDsXxQLqUg1dILb3e8b
	3rgxRxOmeJmM1+4Z1vldgh8j/Np8IO2k1lQsdIfrWTTz4KgCWW7v1zSCzg3+mXO1M=
X-Received: by 2002:a17:906:138d:b0:c12:86a5:3ada with SMTP id a640c23a62f3a-c15a67bc915mr265068366b.36.1783455706820;
        Tue, 07 Jul 2026 13:21:46 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69aa6dba523sm637930a12.0.2026.07.07.13.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 13:21:46 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	jorge.lopez2@hp.com,
	Thomas.Weissschuh@linutronix.de,
	superm1@kernel.org,
	W_Armin@gmx.de,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v3 0/4] platform/x86: hp-bioscfg: fix ACPI package handling on HP EliteBook 840 G2
Date: Wed,  8 Jul 2026 01:21:07 +0500
Message-ID: <20260707202111.35414-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.intel.com,redhat.com,hp.com,linutronix.de,kernel.org,gmx.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272503-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:platform-driver-x86@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ilpo.jarvinen@linux.intel.com,m:hdegoede@redhat.com,m:jorge.lopez2@hp.com,m:Thomas.Weissschuh@linutronix.de,m:superm1@kernel.org,m:W_Armin@gmx.de,m:stable@vger.kernel.org,m:meatuni001@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[meatuni001@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 112DF71F823

This series fixes attribute enumeration failures on the HP EliteBook 840
G2 (BIOS M71 Ver. 01.31), whose BIOS returns shorter ACPI WMI packages
than hp_init_bios_package_attribute() currently accepts, plus occasional
type-mismatched elements after a failed WMI query.

Patches 1 and 2 are prerequisites: they make each per-type parser bound
itself on the real, validated package count instead of an incorrect value
derived from the NAME string's length. Both are no-ops today, since
every package the driver currently handles already meets the old
minimum size. They matter because patch 3 depends on them: once the
minimum size check is relaxed, the elements array can genuinely be
smaller than a parser's fixed per-type count, and without patches 1 and
2 this would result in an out-of-bounds heap read.

Patch 3 relaxes that minimum size check to accept packages missing
optional type-specific fields, as long as the common fields (NAME
through SECURITY_LEVEL) are present.

Patch 4 changes a type mismatch on one element from aborting the whole
attribute to warning and skipping the offending element, matching the
existing handling of unsupported element types.

Patches 1 through 3 are intended to be applied together, as patch 3
depends on the preparatory fixes in patches 1 and 2.

Changes since v2:
- Split the single "pass validated count and bound ordered list
  parsing" patch into two: patch 1 fixes the count value passed to
  each wrapper, patch 2 adds the missing elem < count bound to the
  ordered list parser. (Ilpo)
- Rewrote patch 1's commit message to lead with the bug instead of
  quoting code, and to state up front that a later patch depends on
  it. (Ilpo)
- Reworded "thread the count down" and "guess at it" phrasing. (Ilpo)

Muhammad Bilal (4):
  platform/x86: hp-bioscfg: pass validated element count to package
    parsers
  platform/x86: hp-bioscfg: bound ordered-list parsing by the package
    count
  platform/x86: hp-bioscfg: accept reduced ACPI packages from older HP
    BIOS
  platform/x86: hp-bioscfg: warn on element type mismatch instead of
    failing

 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c     | 16 +++++++++++++---
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h     |  8 ++++++++
 .../platform/x86/hp/hp-bioscfg/enum-attributes.c | 10 ++++++----
 .../platform/x86/hp/hp-bioscfg/int-attributes.c  |  3 ++-
 .../x86/hp/hp-bioscfg/order-list-attributes.c    |  7 ++++---
 .../x86/hp/hp-bioscfg/passwdobj-attributes.c     |  5 +++--
 .../x86/hp/hp-bioscfg/string-attributes.c        |  3 ++-
 7 files changed, 38 insertions(+), 14 deletions(-)

-- 
2.55.0


