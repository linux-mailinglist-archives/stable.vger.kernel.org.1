Return-Path: <stable+bounces-213000-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKaKApCEf2mxsgIAu9opvQ
	(envelope-from <stable+bounces-213000-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 17:51:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50030C68D7
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 17:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AB643005D2C
	for <lists+stable@lfdr.de>; Sun,  1 Feb 2026 16:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BEE21CFFD;
	Sun,  1 Feb 2026 16:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eARsv1aI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B62234984
	for <stable@vger.kernel.org>; Sun,  1 Feb 2026 16:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769964684; cv=none; b=TRNuo8Q+q0NJ1jNkJnf0WJgtCj2iuZgrxVLyZlZy89xO3O0ZNwmLuIeMFST/HH0MWNgTKTqKOGjEVrPdF4yEAINduq2VQeOuCI4lwIi9tzCGRKhjAf2OTLRTpIPS/O3nTOoGlLXwffboZRXdNkbL/UhXXVh2tkmTNlVhl+mwpv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769964684; c=relaxed/simple;
	bh=OdAaEFSJaukpevDaQonyqArjBFZiudEKmBCRz2iW6Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FhwOw+dxKq18rYa1vPOTDNkvGWcJAxyBc9tg6OFAPeCGQ98tyRScYLtyjCsQY/GlD/gAsq+3iwa2IMoOz+GF/AN5eCDUd91Wjy6+YJkcbX4mErF+LhmcMXmny298V1UzYcnxHmBGq/5JiRX+ajgke9cQZPb/MeF8PdCAZ+pM5ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eARsv1aI; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-81f39438187so2006247b3a.2
        for <stable@vger.kernel.org>; Sun, 01 Feb 2026 08:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769964682; x=1770569482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBfv8eejZu+05bJxMtDkYGwkiaLBdKZ0g8Il/kPgKWI=;
        b=eARsv1aID6cTkRtKF+TeYRgNKx+/RA1JshTlhDN2x/hT+RupgSDWkJ1Hp6NmDPrE+2
         xk910o6bG+GZHnNvuWLg4ulpg8X6O6Takq4IopfuBInNyStrAscg6MpyLzlacilF74mv
         U9UcXxbbZmWa3F7+0nyYKzDJ3H4XZ5cT1oOAMR5Z3n7tsDnbUwBow2zwB3HI09UZXFwU
         +JXLPUgzOW7cQfuv6ff4SGXGjtTzyQkYxIykLWAZ1rKmkIHMAyhjyMgGlp/Mlfv0V+ci
         EiNBSGigE8PQlfBhvjpu8sKdzjADjZXjSkMDa/yybwg+6rt2kIljxh6W6ULvFXvJU3eZ
         Yb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769964682; x=1770569482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yBfv8eejZu+05bJxMtDkYGwkiaLBdKZ0g8Il/kPgKWI=;
        b=EvNpoPv3PSxudiyInlvpki3jLtuujQDqI8/3J/GgmapXrTVr8eL65QoWiKerA5qqhV
         cT/P++kjrRVL8FVCUld8wi10saWfS4NicBL7HMMlbxv0MhkdCKns0ITAedpIvCaHkpA1
         icSF+ZNoUNVxEQU9IThy0F3oThHYKN8Y7VwUy+60kUvv5pBohrwyR89q7u+wVa9Mp0Ar
         RCxQzMPLbeEXFi2wlC9DtjvfSbxgNhkZSb+y2VynT0Q8kzPQTBtNtViCNQ8smi23Bs94
         WAzABrT/Ss2NfDX0YQVvGrABfal/WQD0WMtGuarjdZ00ENFv/+0od/GuGf3G9HQE3GeT
         lmAQ==
X-Gm-Message-State: AOJu0YzXLZCcEkIBiA1SDf0FKd+Jb/B7Tc+cxrMvfi78zn2xHwb0M7zP
	hrNeNy63jBgWxGQo56IaD7zRaZggHhvPSWFopXxnYi+5FSTyOTIAkSu8W8oz9w==
X-Gm-Gg: AZuq6aK3mazRbUBpx/w8U+2naRWDht3lPXdDWb93Y05VKhoWkXgd+YNls69Oao6Uhtf
	B9MIbz+x0VvFkAqBGvL+ppFnTewkgn7w2R1mz8/QuSVi0zE81Z6TjtSFq4HCgF0fK0BirGrqd72
	1+lGW6JtA35Z1Ya9Te6MVcP7d2VAZ2IYIBRmP7PfPtQ/bvOYsPq/o04nTtxO3rtloNyv+fABfGD
	aq+KSpwWa9IAT3kp9//Vh2FCDyQQ/usS//xAq0pUN8zG8irAXm0N5U7fbT+mrSbSGe0ej9tIz1u
	/dUoiP544cRWivs6AY0LKCh4C96PxwV3HT/8EpIli74ktosIfBIl0oF06lfQ7ZiSpNw80DfpX+X
	bf0ii0ePiJidHiqDZnGniTMpEzBDrWsTUvOLNvwStmVNXv/9c5VxfgyGq2T6Y9lQOYEMcgomJ6X
	ZM6I2/2cEYqyD4nsKuPtu++09z
X-Received: by 2002:a05:6a00:3686:b0:81f:38ee:3901 with SMTP id d2e1a72fcca58-823ab772b63mr7540159b3a.67.1769964682163;
        Sun, 01 Feb 2026 08:51:22 -0800 (PST)
Received: from 4aee0dccb4bc ([115.245.213.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfd797sm13309326b3a.43.2026.02.01.08.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 08:51:21 -0800 (PST)
From: Sanjaikumar V S <sanjaikumarvs@gmail.com>
X-Google-Original-From: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>
To: sanjaikumar.vs@dicortech.com
Cc: stable@vger.kernel.org
Subject: [PATCH 1/2] mtd: spi-nor: sst: Fix write enable before AAI sequence
Date: Sun,  1 Feb 2026 16:51:05 +0000
Message-ID: <20260201165106.30-2-sanjaikumar.vs@dicortech.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260201165106.30-1-sanjaikumar.vs@dicortech.com>
References: <20260201165106.30-1-sanjaikumar.vs@dicortech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_TO(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213000-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanjaikumarvs@gmail.com,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dicortech.com:mid,dicortech.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 50030C68D7
X-Rspamd-Action: no action

When writing to SST flash starting at an odd address, a single byte is
first programmed using the byte program (BP) command. After this
operation completes, the flash hardware automatically clears the Write
Enable Latch (WEL) bit.

If an AAI (Auto Address Increment) word program sequence follows, it
requires WEL to be set. Without re-enabling writes, the AAI sequence
fails.

Add spi_nor_write_enable() after the odd-address byte program, but only
when an AAI sequence will follow (len > 2 bytes remaining).

Cc: stable@vger.kernel.org
Signed-off-by: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>
---
 drivers/mtd/spi-nor/sst.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
index 175211fe6a5e..fe714e6d0914 100644
--- a/drivers/mtd/spi-nor/sst.c
+++ b/drivers/mtd/spi-nor/sst.c
@@ -210,6 +210,13 @@ static int sst_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 		to++;
 		actual++;
+
+		/* BP clears WEL, re-enable if AAI sequence follows */
+		if (actual < len - 1) {
+			ret = spi_nor_write_enable(nor);
+			if (ret)
+				goto out;
+		}
 	}
 
 	/* Write out most of the data here. */
-- 
2.43.0


