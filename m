Return-Path: <stable+bounces-238416-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGyNMZPQ4WnQyQAAu9opvQ
	(envelope-from <stable+bounces-238416-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:17:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5043741754E
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F1D83220DE2
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 06:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F9D36B042;
	Fri, 17 Apr 2026 06:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QN/F/ans"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA1D35B654
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 06:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776406329; cv=none; b=OZw/j81xcTm9NBu5gwt3gGYSrl0fhsQHT3JC1x7eyRnihvwqbUp9E0rRMzfgxiou31g5NdbL7ZSw/I9qb27I02SEdbKlz9rxoppD6vtCnqBnCE1yP37x5XLT5cL7Ah5vdWW8m9IqBDCRPlEOoAqXrXK6V2bErbcDO1LLJWXEp24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776406329; c=relaxed/simple;
	bh=enX3UX6zWol/qG1cKHurOsAFJF/7bCld3RxJCzgeQks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n18EIwEXZA+o14tHxYQyFCkuUKJVixA3Usr7Htbi8geyhzQCbP3BnPI3l1ULjb0QXSq0RyVsL8zKd8tkHuxvtsJWOvyoF+mQUf02dfMC7qpYknP1Zg8l5+JtGWOSPUX3r31h6JPByjaZj6a606Nmui366Ohkmvv7urpeUsnPLvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QN/F/ans; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-95697b46831so176995241.0
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 23:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776406327; x=1777011127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bRYLA9ER3MjltMtOUVebb6AW16pTPY2JdB3R8WgouyY=;
        b=QN/F/ansvoEe06RjNJuvdZB6s4/ltkeDFbIoxzY5cWbn/2jWpcmfR9yBG+7drJNunr
         0pplVcX1QzB2oPm7kmnN5BhNxH3BoIRhL9+dRsXw8cwjIl4hX2Ykf9G9y5qeUKq9/Stf
         /fyv9qwhG7C7HwSJz/m2kMxy2UYvBf1fQz4GpSDeKwJelwsYGkPvQMKZidlR84MCQzSx
         hHfGH9v3LBczp8hxTZ/1L5tsD2qc/NyPEPizsuwz3S+ItNZvoR7GpRBC4WBcDQdvBrrA
         0AEWVUsXTOT4nfTJ0tl8LFyJvRaNPn7AB7f6ur9BvD3t1k5UTt7VmcgSimwRQv67ppcU
         wIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776406327; x=1777011127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRYLA9ER3MjltMtOUVebb6AW16pTPY2JdB3R8WgouyY=;
        b=RSzHfNRcNk2y55FQPBFI+47OIIyfXrPDHlhZQ3fHi+WEll/zdcM3EgPiYRCQmiUQvC
         6BAwgpuUHj6edyxcnbSbfO3BuiA4NnVSzPt+EHh7eZBs563kbnYnwKy0EfE6VXcGjDma
         562pSmGdGy+D9NY6uE9DBs6L25TB6p4W/wLBwhXxblPEw//3BROKHH0/MmVFEx9hU0q6
         UTNMU0IXYguvjsp9/m+Z1h1/wo9ngYihQt8M+KEHLHUA+lPP9YAGCELdzcJ81vzPXajt
         wH++9+KS75c/ZiT4pp0ACmG4/cJlRFtcFt9dUzoWXA+ssAZvcJ1efcX3f9P1RZVC1MNa
         earA==
X-Forwarded-Encrypted: i=1; AFNElJ/Ito59AA4msFltmEVdXOMcaQW8cf+G6yXHEN7TP+YK9vgGMrsyTY3YD1tKp+4GlCtYf8eHfE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJdpqWeZvfQhU5YYjydmue+MRjPozrFAGCnQLIoUsdWrSKgGGb
	bDWZo2MtQyNt4K/GFO7Pp56F9IOyed2i45zsRZWBaXHgcMB64Fkz0GU8
X-Gm-Gg: AeBDievlhGdluU11QSVBkNIutx/Zoz2YrjlLtfJunefC5bhIK6YIrKq/6X6I3fJ6el9
	b2nQEHRvv5zn9CbhTr6lDmcG+xTiHAzPPimyK9ZAeN/9ug3mfPl4cc9N01P0nc92UVQrutfEIH8
	odFeJ6G0vrdigkySmI5qaVBaz6N6F8QGfShd87CR+Or12lNGOhWV1TCIH3v+RjajcpNS1FyzBtw
	c0KcfNGQlcy4YV5Gv63fR+IUPNA+hs5QQoctCE8MT1jRyGZMy5ygW7Ri1pp1RA9f66oN86zHx6o
	WDZSGvNbasDC3TeZOvQKW5v8SbouDRX0I0QZXC+Xgme+qNS0uU0C6Y1awPn6xEI7i2Hdz9qV3wk
	SZn+tweA4R0t3I54bbdkkT1xgqul88XyARox3EHQHysekh8y+lSlQ6lkS4dbc4Rbb3lOI9z+38g
	8p87IkO1Ry19AcONZBaquK8hecr17bjbbIKRSmgpI17X1yMWQJK086
X-Received: by 2002:a05:6102:f11:b0:5fd:f2ad:c653 with SMTP id ada2fe7eead31-616f67c7a25mr577174137.16.1776406327249;
        Thu, 16 Apr 2026 23:12:07 -0700 (PDT)
Received: from localhost.localdomain ([102.244.98.124])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9589093a8bbsm297947241.3.2026.04.16.23.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 23:12:06 -0700 (PDT)
From: Delene Tchio Romuald <delenetchior1@gmail.com>
To: gregkh@linuxfoundation.org
Cc: error27@gmail.com,
	luka.gejak@linux.dev,
	hansg@kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Delene Tchio Romuald <delenetchior1@gmail.com>
Subject: [PATCH v6 0/5] staging: rtl8723bs: fix multiple security vulnerabilities
Date: Fri, 17 Apr 2026 07:10:43 +0100
Message-ID: <20260417061048.62484-1-delenetchior1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238416-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[delenetchior1@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5043741754E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes five remotely-triggerable memory safety issues in
the rtl8723bs driver. All of them are reachable from the air by an
attacker within WiFi radio range, without authentication, via
crafted management or data frames:

  1. Heap buffer overflow in recvframe_defrag() when reassembling
     fragmented frames whose total payload exceeds the receive
     buffer capacity.
  2. Integer underflow in TKIP MIC verification when a frame is
     shorter than the sum of header, IV, ICV and MIC sizes.
  3. Out-of-bounds read in portctrl() when a non-EAPOL frame is
     shorter than the 802.11 header + IV + LLC + ether_type.
  4. Out-of-bounds reads in three IE walkers (rtw_get_wapi_ie(),
     rtw_get_sec_ie(), rtw_get_wps_ie()) due to missing validation
     of the TLV length byte and of the byte ranges touched by the
     subsequent memcmp() calls.
  5. Integer underflow in rtw_wep_decrypt() when a WEP frame is
     shorter than the header + IV + ICV.

Each patch was found by code review and is not tested on hardware.

Changes since v5:
 - Patch 1/5: restore the "/* memcpy */" comment that v5 had
   removed as drive-by cleanup (Dan Carpenter).
 - Patch 3/5: drop the unrelated cleanups (ptr = ptr + X -> ptr +=
   X, inversion of the ether_type == eapol_type branch into
   direct return NULL); the patch now only adds the short-frame
   length check before dereferencing the LLC header (Dan
   Carpenter).
 - Patches 2/5, 4/5 and 5/5 are unchanged.

Changes since v4:
 - Patch 1/5: collapse the identical cleanup sites in
   recvframe_defrag() into a single out_err label (Dan Carpenter).
 - Patch 4/5: in addition to the outer TLV length check, add an
   inner bound check before each memcmp() so that the OUI read at
   offset 6 (WAPI) or offset 2 (WPA/WPS) stays inside the declared
   element (Dan Carpenter).
 - Patch 5/5: tighten the length check to also cover the 4-byte
   ICV, so that the subsequent crc32_le(payload, length - 4) call
   cannot underflow length - 4.

Changes since v3:
 - All patches: add Fixes: tag pointing at the driver import and
   add Cc: stable per Dan Carpenter.

Changes since v2:
 - Sent as numbered series with cover letter.

Changes since v1:
 - Rebased on staging-next.

Delene Tchio Romuald (5):
  staging: rtl8723bs: fix heap buffer overflow in recvframe_defrag()
  staging: rtl8723bs: fix integer underflow in TKIP MIC verification
  staging: rtl8723bs: fix out-of-bounds read in portctrl()
  staging: rtl8723bs: fix out-of-bounds reads in IE parsing functions
  staging: rtl8723bs: fix negative length in WEP decryption

 .../staging/rtl8723bs/core/rtw_ieee80211.c    | 70 +++++++++++++------
 drivers/staging/rtl8723bs/core/rtw_recv.c     | 51 +++++++++-----
 drivers/staging/rtl8723bs/core/rtw_security.c |  6 ++
 3 files changed, 87 insertions(+), 40 deletions(-)


base-commit: bf9c95f3eeefb7fc4b4a6380cc23f1dca744e379
--
2.43.0


