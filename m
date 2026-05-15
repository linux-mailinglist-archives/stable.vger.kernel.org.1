Return-Path: <stable+bounces-248931-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKbPFUyaB2r/9wIAu9opvQ
	(envelope-from <stable+bounces-248931-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 00:12:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AA95589C1
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 00:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D2CF301D328
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 22:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8878D3F44FB;
	Fri, 15 May 2026 22:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="Fi2wnLHI"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECF13EB801
	for <stable@vger.kernel.org>; Fri, 15 May 2026 22:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778883126; cv=none; b=Xw9D7CNjZBZXgKy3JLRf1QPIY2NI7Hy0bUAAJk8vljahfwIhQUWbxSwFSzoA/QsDi3xEowiYU1erKSynBN367ODPOc49Mzl8G8dttsBkuSujmw02eSMSm2+J/TstNIDkTx8u2p3vvDqwfFQdfoHVQ74eUGXQ1zvd6VKt2ye0KjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778883126; c=relaxed/simple;
	bh=RfTbHXTtWWODsb9OziDmC4Vc8FN9qu30mpR5DxlCs9M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Cg1O+wAPqwkDUrlcqO2zyBCEGcJ0udO2G2+PghIMUApWa+2uD+aJ3dphLtkKA3NqQZiF7GpdhUJMtIL660zLyswn2f4FHTu8wzwPp0zLxpZQlyZNx1Ui9vF4zn6hjkWsXMfx8GqGbFBjoRe12ug+T1ZpxwbwSE1PjDqrwvPLzjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=Fi2wnLHI; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2f7020a928eso451332eec.1
        for <stable@vger.kernel.org>; Fri, 15 May 2026 15:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1778883124; x=1779487924; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HUkmtxx2eQM6PsxtArDmQW5eFZT58DVomuM33dLeJSM=;
        b=Fi2wnLHI8qfifSxGpibHE/ZkFwI9qtuK/+XgiIpm8/1Kctgp4M4Zu+WKEXsYCKifwI
         wVUT/Ss4v3gm75hFFGTI7jzVSwm1DmNZn6AE7uWjsnaU6eYMHWut2KTnibGnF0RxuSiN
         Tlv5UCPmOJn8cvTt90OjHhQTmLm1YGhFTP99CvjS5jmP5zGVGVQoM3Jrx+jWP5aYB1eT
         RlN4lleQBnu9dMH6aK1QLGnc7MTNTKzwmZBHKqPg8mYMbPzfdT8ANsAke/PhPnpuMLD0
         JpbmDIlBOyIkGJTn38OsDGGOGVCRtgExILGelVcKbzPEDbnn+c3+ooihlCQyfo7Y1Q1z
         g1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778883124; x=1779487924;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUkmtxx2eQM6PsxtArDmQW5eFZT58DVomuM33dLeJSM=;
        b=qNAALrw+VY8Nyfb/A7KczhfGX7DBWwznWxFtQaIwRahgVd7UUyAmQ2uTxFXt8aflGp
         0eTXycHvM1YosKDkzFmeEhdy93fLA+3RMPvbJ+gxwaApaVKIR+12fo4AWcbf5Z/cSNWl
         S8QH3EXvkJiheGww1fV9+PpyoQBFMFMK6f3xy2hK22GgR6bA3yar9RYGdJtwi35OkTMj
         tNSbzWlxoKcCPHOn4qgGsQ1lMpCO1yaZbppwyxaJz5Z81nscoMe9tJt8mP+dOzQP66NJ
         2Gg4ZRvJF2x+755MTCZ1q6H0ssNbm2bSZOFH2hMGmqmWa7mSkkLgf+0QklhqB5hdrlig
         1ExA==
X-Forwarded-Encrypted: i=1; AFNElJ8WlNGMpYRgfrTvr1760IdMvI++yRwHehTNfCBkNtVaurvvCAqnM7IAl5AgNu0+1Wz+3Gw7QzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi6EqRRC1BnbxGXGk4hdtBnK05ZPjLq2GLSLI0xd3lRXWv6S7U
	j4IuBDk2Rys8nNJmwCU7kV0++E/PcpKl3ylZgMefJ+qfWoitU0JvfNR0makezfcraaU=
X-Gm-Gg: Acq92OFaxxRlDq1O0N6kiG70JEh9/orU93o5G0v8sQf9ER+vdz94nwyM3P71qiV6wgZ
	MZnTS2MFAbpqAx6bMB3WIfvT27PG49h/HvMxrUd5nyjVMFCVYB3nXf7/HpFnYeWu9ar8Y3SaMpH
	RFEh8nvqYc0995vDsAHrWQuFSGj8w7zlnMTHbMzRyy9XRe/ZfpMlkD0qNLQtwuUtNI7+WKBO4pM
	qSkkUVHk2QkS4X3n+uLYU2IGCLPnOKPyzHbEFRViEzexnKWyY73/qr5gfSkeuOCFmpcsQRRCPgX
	yERJol8AZOuWB9ZmqjABDh2v3ljiSaQHr5635uTtubI59a1MHaarlhbFJHDUcncekyG4GZuM5/h
	WuLA6rGazUmMjNJF3gLD36GPdIZwEMPFYBzIkjX1IYQbuyP+3Jf6TGJR80UnnUwJp2sRMdCBRK6
	s1a2R/nlSegP24w1CQSAyaNltdiw==
X-Received: by 2002:a05:7300:7255:b0:2d0:239a:23c9 with SMTP id 5a478bee46e88-30398677161mr2992844eec.16.1778883123579;
        Fri, 15 May 2026 15:12:03 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2e686sm9626315eec.5.2026.05.15.15.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 15:12:02 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Subject: [PATCH 0/5] hwmon: (pmbus/adm1266) buffer-bound and timestamp
 fixes
Date: Fri, 15 May 2026 15:11:46 -0700
Message-Id: <20260515-adm1266-fixes-v1-0-1c1ea1349cfe@nexthop.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACKaB2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0MT3cSUXEMjMzPdtMyK1GJdC1NjAwPjRIO0xBQTJaCegqJUsARQS3Q
 shF9cmpSVmlwCMkSpthYA7WjsjXEAAAA=
X-Change-ID: 20260514-adm1266-fixes-853003a0fad4
To: Guenter Roeck <linux@roeck-us.net>, 
 Alexandru Tachici <alexandru.tachici@analog.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778883122; l=2272;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=RfTbHXTtWWODsb9OziDmC4Vc8FN9qu30mpR5DxlCs9M=;
 b=rP2wtJ3mDP8/nSTegyS/eUZ1nq6KajPvOzUbZkPWqE0h9Ad/1A/03vvHDf+0pBbmZPJr+BwFv
 I5eXK/G0oaTB1AnWSRSTuSYJVZFkZqarubs+9sor67ivzkDVXuJyOnw
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=
X-Rspamd-Queue-Id: D7AA95589C1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nexthop.ai,none];
	R_DKIM_ALLOW(-0.20)[nexthop.ai:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[nexthop.ai:+];
	TAGGED_FROM(0.00)[bounces-248931-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abdurrahman@nexthop.ai,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nexthop.ai:email,nexthop.ai:mid,nexthop.ai:dkim]
X-Rspamd-Action: no action

This series fixes five pre-existing bugs in adm1266.c that were
surfaced by automated review of an in-flight feature series for the
same driver [1].  None of them are introduced by that feature work --
they are all reachable on the existing driver as it sits in mainline.
Sending them standalone first, with Fixes: tags and Cc: stable, so
the feature respin (v5) can rebase on top.

Patch 1 fixes a CLOCK_MONOTONIC vs CLOCK_REALTIME confusion in
adm1266_set_rtc(): the chip's SET_RTC register is documented to hold
wall-clock seconds, but the driver currently seeds it from
ktime_get_seconds(), giving blackbox records timestamps that reset
to small values on every host reboot.

Patches 2 and 3 fix two ways the blackbox-info path can be driven
out of bounds by a misbehaving slave: a 5-byte stack buffer that
i2c_smbus_read_block_data() will memcpy() up to 32 bytes into, and
a record_count loop bound taken directly from the device with no
upper clamp against the 32-record dev_mem allocation.

Patches 4 and 5 fix the two ways adm1266_pmbus_block_xfer() can
write past the end of a buffer: an off-by-one on the helper's own
read_buf (sized for the length+payload but missing the PEC byte the
i2c_msg length already accounts for), and a caller-side bug where
adm1266_nvmem_read_blackbox() advances its destination pointer in
64-byte strides while the helper is willing to write up to 255
bytes per call.

[1] https://lore.kernel.org/r/20260512-adm1266-v3-0-a81a479b0bb0@nexthop.ai

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
Abdurrahman Hussain (5):
      hwmon: (pmbus/adm1266) seed timestamp from the real-time clock
      hwmon: (pmbus/adm1266) widen blackbox-info buffer to I2C_SMBUS_BLOCK_MAX
      hwmon: (pmbus/adm1266) reject implausible blackbox record_count
      hwmon: (pmbus/adm1266) include PEC byte in pmbus_block_xfer read buffer
      hwmon: (pmbus/adm1266) bounce blackbox records through a protocol-sized buffer

 drivers/hwmon/pmbus/adm1266.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)
---
base-commit: 1f63dd8ca0dc05a8272bb8155f643c691d29bb11
change-id: 20260514-adm1266-fixes-853003a0fad4

Best regards,
--  
Abdurrahman Hussain <abdurrahman@nexthop.ai>


