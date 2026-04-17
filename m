Return-Path: <stable+bounces-238400-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCCFEI2q4WkywgAAu9opvQ
	(envelope-from <stable+bounces-238400-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 05:35:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF10416A1F
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 05:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A229C30062F3
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 03:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1C927AC45;
	Fri, 17 Apr 2026 03:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZteUC/6"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB9D481B1
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 03:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776396919; cv=none; b=Tbg1EOKwscBTZdNYkSDFSXCa4SSeRgi5i8xmjbCPpl7znd3tJzQHIXS+h45tC7Pe4tqb6kAXgW8AAX8ZYUKeh9btVHnOH2toIFOw23ZuKPr6ujLVKykor59nPoi+YiigigAOBWeHCKvRWhO0iz9/ZxezmivUoQNsNN3SyGCTxdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776396919; c=relaxed/simple;
	bh=lJ39vyWPNeqNbdYkdhNMpLAMUTs7yWr4uOXQLIWgqio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L4vj98crCMJSRcDnPdyXk9QZJIp9BLqmsJ4NcK+KPyErC8TgjT90//RwcgbjBtg72TLDHGWgg1kKoyf5rW1p1JPtL37eXr/Vw4aVuWXVeZohPHmtvbKafeJm4as/f5l2OVI0e8tkWW3h7c4POYmf0ffYlFVdmFwatkfJbfovN5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZteUC/6; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12c1a170a50so318831c88.0
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 20:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776396918; x=1777001718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hvouVp4w0YbHvQbdpa7mn27k6mvB2sHRdWB4T5BpS3c=;
        b=MZteUC/65bbJMuf+REtQAik6V8vKqKT5JaQVQ2LBsDtfdfUHw2YyVEjNHBrntV/Ikk
         fNt0AyTcHv6DefIO3AhxdQJ5gUHaZ+ivmSNVYcyrfdKybCIoKPspSpRHjS82yzufZIe1
         CB0l/QphuJYzuXXSbTO1TX1qynDJkcxuMi27JrjRvFbDZbzk7g89C1poZo44lxQWLVuw
         2XibRiUzkPcMuEXcOtHellRH7njwU62xr9trquqWrxfd/idkM50zBy3V1tewlSk/QjBj
         V9DodItT5jvajf1UOMzX3oePKDDzE3Z3oS/sajuIgsp2d10PDrdjAP6fVSp/gWp0yuIL
         m5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776396918; x=1777001718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvouVp4w0YbHvQbdpa7mn27k6mvB2sHRdWB4T5BpS3c=;
        b=LkgnKdqjSr5i5PnkdayqTTR9pmWUr5gFt88jWZGbSHrmzegJUiPE88O7PX9e+A67FZ
         6yap1JRpaPVbF5yTHl997ykxhsZ4NPleSZVX5qTBfv/YidQTH/7FmZnuvmiq7l0KjCLO
         FynpYh/5HRR9mt1Yg57UL/6BvlisiKap7woD8gtOLBUFao819LpawJQZhNLwNo5JCNr5
         IEajSGUdnN0Mt6DbHbegtpvcLdT8jKGrGewYwvAiNo0jMP3eLRkyfLuEulyezgup1lQA
         JsXTCqNWfJbCybYgdkexY0eXpCeXBPFxX521KgWX2L0M0AAlOjgbGwX3Zh+nBKFfp/K4
         ODIA==
X-Forwarded-Encrypted: i=1; AFNElJ+Cl5IzS5fPmX9BujghTU1EOQ+NboSgb7nxwhFOcNwT338bnMFsmgbru988NxcsMrlqVQWcqgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTkxYcZOIpZmcJjdo7Vdah4Z+N7hVX7B37Yn2JYH1cn4X08qyl
	2x7r4ahVKCvO1Vda92BkueQgpjQxPNW2RnPKhW1fR4sxlsuh4fSwqophL8hH7YJ+DNs=
X-Gm-Gg: AeBDievCQWRKcf6tGKTXJvG+dbSwX+ZRBbukfZY1zCBmCdpGlBfs1c+s9Hj5DH2Ft53
	T2liagr38Mqve61IWdYQ0Mn04gQSxfgejBvDXLV/7hE9A+Ycji4nb7cpef3bShipPvNKcEcCBr4
	KMx4ta870M4tFxHKgtXLzpT5uREfcAxRoNadgWHgvGS3LuMWY3Js41qExnKEOBj7AwprmLKCC+J
	mVBZmjEkXhXx2FS9w7s9o+Ikre/q1bV1/J1+Dp71KhRWUQiU5vJRPmgeK/XAzRgidwMIPmFwj8J
	yfJgLp06yD6EVIIRVaUv0IHDiWgxiCpperSnvM3/kMCAxtVNqABBBKjZGbB+WwKLzOIpZOvQYy7
	bh1RvOZx5jgVtP9/fDSaor+dDklsaQOaTVhLqUO0MHKJkq/St9onRzPW/Qkygbv+NjvpIrQdTTR
	+wF4Jy+q+RT0nId3qcdEA/R/ZcefWfwglYYiw=
X-Received: by 2002:a05:7022:220f:b0:127:5cd6:fa45 with SMTP id a92af1059eb24-12c73f72632mr449412c88.14.1776396917545;
        Thu, 16 Apr 2026 20:35:17 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:ba4:7419:7bc9:9c2a:7cc2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c749c46c8sm511978c88.1.2026.04.16.20.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 20:35:15 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Matt Vollrath <tactii@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH iwl-net] igbvf: Fix leak in TX DMA error cleanup
Date: Thu, 16 Apr 2026 23:34:52 -0400
Message-ID: <20260417033452.640551-1-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-238400-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tactii@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: ABF10416A1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If an error is encountered while mapping TX buffers, the driver should
unmap any buffers already mapped for that skb.

Because count is incremented before each frag mapping, it will always
match the correct number of unmappings needed when dma_error is reached.
Decrementing count before the while loop in dma_error causes an
off-by-one error. If any mapping was successful before an unsuccessful
mapping, exactly one DMA mapping (the head) would leak.

This bug was introduced by a 2010 fix for an endless loop in dma_error.
All other affected drivers have already been fixed.

Fixes: c1fa347f20f1 ("e1000/e1000e/igb/igbvf/ixgb/ixgbe: Fix tests of unsigned in *_tx_map()")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-4-7-opus
Signed-off-by: Matt Vollrath <tactii@gmail.com>
---
 drivers/net/ethernet/intel/igbvf/netdev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index ac57212ab02bd..19b2228e80bae 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -2190,8 +2190,6 @@ static inline int igbvf_tx_map_adv(struct igbvf_adapter *adapter,
 	buffer_info->time_stamp = 0;
 	buffer_info->length = 0;
 	buffer_info->mapped_as_page = false;
-	if (count)
-		count--;
 
 	/* clear timestamp and dma mappings for remaining portion of packet */
 	while (count--) {
-- 
2.43.0


