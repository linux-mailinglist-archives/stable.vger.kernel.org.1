Return-Path: <stable+bounces-260156-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zcQ9EWNaIGoz1wAAu9opvQ
	(envelope-from <stable+bounces-260156-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 18:46:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB360639E45
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 18:46:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=R1ob+GOF;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260156-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260156-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4785C3012CA3
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 16:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736F73E9C1A;
	Wed,  3 Jun 2026 16:38:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D192F3E63BE
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 16:38:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780504736; cv=none; b=Ydz+8I/GDEPkzeAzY6exxmzpv/fx2gdSLLTQ+1LzELleMdOtjOoA8Pulp4q2sfnjyyr0/oGuItrgY19QzXS2HqAjwG6cLnNH0/Ak/EmqZncXeweuEt4tWWdagNmJQfh2/2UtNbNWn2Wybc6+cVdzBTj4clWyRqRdsvTUNLBip2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780504736; c=relaxed/simple;
	bh=K/YVSy3Jio3EDLqXiV7+CBIoj59O3grDjIPmiQ+k2Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yq/fc8sbqScmR8/DhqjrLdT4jjLl0xJfPK/mPAaU6IEK/jWxOB7CoyxeMNCLkmON/Vz69AX0Qd8PMYTcIZLzxovJ1ohyk670iyezahUaJytpViLKnlz9bT+CW1hSHMXRsirZh8RzLEmodcbRNSdxnV+QBEaVyF247ctQz6cHOvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1ob+GOF; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490aaeabdb4so23300885e9.1
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 09:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780504733; x=1781109533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=259LrnAOdGfiedRDzKiXBqB7ciLo61uHaIr6D3LBW08=;
        b=R1ob+GOFGbA8grfK3rS3WPnissX1XhOAzMRICSepyUSuJdAunS4UUXyFfJwrxaMdxo
         q7x8Rz62nl3ubmIJPrSesQ4BobY0rjmj/JpJriPh5kvAyl9VPt7Xam0dN0SlIwhKApUM
         0/hBuRyfoAL1vWEcEJTvIALrWSOd0ERA+V47GQs+abXl8jkuoOfr0pezZXy2mw79Qi/A
         h0FigVtwIJ4630Bm55J/TWp9YsDEH/cbP9Tm3YPXEQQ7Kr36uceOEc+NK8Vs2BZ/83AV
         /hFPt3RtoMRLvmG2tKn8GwlE/bLACN/5v9OOe74+I/LMjtYQfazKTJXGI3GttcPX7fGf
         qxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780504733; x=1781109533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=259LrnAOdGfiedRDzKiXBqB7ciLo61uHaIr6D3LBW08=;
        b=sNSmvsCi+SNAwIiRyID9e71vMZQjAKSXR04HD161ggAHrpEO2Sa9uw52RHkHqXSx5I
         x79S1P5m3dxXBvNwR0SFPevfs8D+xgbppUV1mohu2yN/Lx4bhQI9o5awZmwKkus0qfjA
         iQIZucF3h3gxclLpRGWZ3ABhp6Y4qdxA+yRrVIlBITfeMPKBp2shY6WrSoGblLhTS30E
         sVlyc276HblKw5Mcg1YfxeUIOyidwHm0ZQYqrYBNfJ9W02xCPZWF/rbs8xoWeqfvUcgL
         N0RJSh7v8YL4DS9fOI5TUP8NwwD+eWxyFAJyPdSZSjwFM5EQQrnDwA5O2pjqhzBxoAXV
         JbBA==
X-Forwarded-Encrypted: i=1; AFNElJ+/Clcj0QmHn7p0Y75c4Q6gg+t+6cTBsorQCVCWKiEs4r6ZEnHb+tCiRrEJpcO8E/YwD2eI8mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ymUZd1jIvmMd5xHjOeAa4frfN6KsOA+Lk/7DD5n9wwtMlwmv
	NRgVsvSCFLEVU+h+tpG6PbGD5jzG7KLc2G1cJP9tJZD2aCgJb6/oBuy4
X-Gm-Gg: Acq92OE92OOCFto7eU+p1r/czWhyB0O3S+7fWKEjePH/gKSdl2XbcfQKszsYSrjZ9hh
	ZDkoNDCeVqhGvLHwLgX6/OzqmDicZwiP7+fQaJjn9i1Z4Wr8U3PX/SCHpHiMLz9BIF2O0sfK7mQ
	C+FDSlG5WpNcMFhyRqZrGqUTr2O/8gS3gxTkAwKRaHhhAiW5/rTnsvQ7yfLBuXIhPWpHbY1Y7Mm
	pV4Tr5GohWBs9mNAb6kuyXgvXkOACx200CXhSdxlUAzX0O8fe0dGkuCl0F2brcPYoiK+91Cr2ae
	uoEvrcIi6HFLBjVr5QUQKc/oo81AzKJIOGQsVKD/lFTwvXj/gd95wZ/HkZz6gxi4SPsVJXHTSjP
	30lIhW1hrXA7mgZYV7LSwQkCY1Uay2y4Y07v3F+jdbbimZ9bYyKP7rJ0Xe4KB9sFx1BjdDBIXVU
	AN/rTCsCbsz4MatAJXUcrEYT1hzdYB0TLBat6kq9U9gvZ1TU0E5/2+3qW+5OBVo3j1E5ViEkWP6
	vOH7A==
X-Received: by 2002:a05:600c:1c1e:b0:490:b00c:8e6a with SMTP id 5b1f17b1804b1-490b5fe65a6mr69071435e9.28.1780504731298;
        Wed, 03 Jun 2026 09:38:51 -0700 (PDT)
Received: from localhost.localdomain ([5.165.242.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3a8632sm7261405e9.8.2026.06.03.09.38.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Jun 2026 09:38:50 -0700 (PDT)
From: Anton Leontev <leontyevantony@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anton Leontev <leontyevantony@gmail.com>
Subject: [PATCH net v2] hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf
Date: Wed,  3 Jun 2026 19:38:51 +0300
Message-ID: <20260603163851.18058-1-leontyevantony@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602155210.90987-1-leontyevanton1995@gmail.com>
References: <20260602155210.90987-1-leontyevanton1995@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,microsoft.com,kernel.org,redhat.com,google.com,davemloft.net,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-260156-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:haiyangz@microsoft.com,m:kys@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:davem@davemloft.net,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:leontyevantony@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[leontyevantony@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leontyevantony@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB360639E45

netvsc_copy_to_send_buf() copies skb fragment pages into the shared
VMBus send buffer using phys_to_virt() on the fragment PFN. On 32-bit
x86 with CONFIG_HIGHMEM=y, phys_to_virt() (i.e. __va()) is only valid
for LOWMEM addresses below 896 MiB. For a HIGHMEM page it returns an
address that has no kernel page table entry and lies outside the
kernel direct map, so the subsequent memcpy() faults. As this happens
on the transmit softirq path, the fault is fatal.

A HIGHMEM fragment reaches this path whenever the page backing an skb
fragment lives above the LOWMEM boundary, which is common on a 32-bit
guest with several GiB of RAM (for example when the in-kernel NFS
server splices page cache pages directly into the reply skb).

pb[i].pfn is a Hyper-V PFN at HV_HYP_PAGE_SIZE (4K) granularity. The
physical address is reconstructed first and phys_to_page() is used to
obtain the native struct page, with offset_in_page() added so the
in-page offset stays correct where PAGE_SIZE > HV_HYP_PAGE_SIZE (e.g.
arm64 with 64K pages). The page is then mapped on demand with
kmap_local_page()/kunmap_local(). On !CONFIG_HIGHMEM configs
kmap_local_page() reduces to page_address(), so this is a no-op there.

Fixes: c25aaf814a63 ("hyperv: Enable sendbuf mechanism on the send path")
Cc: stable@vger.kernel.org
Signed-off-by: Anton Leontev <leontyevantony@gmail.com>
---
v2:
 - Reconstruct the physical address from the Hyper-V PFN and use
   phys_to_page() + offset_in_page() instead of pfn_to_page() on the
   raw PFN, correct where PAGE_SIZE > 4K (e.g. arm64 64K pages).
   Reported by Haiyang Zhang.
 - Built for i386 (CONFIG_HIGHMEM) and arm64 (64K pages).
 drivers/net/hyperv/netvsc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 59e95341f9b1..2038d9f5c9f9 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -12,6 +12,7 @@
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <linux/mm.h>
+#include <linux/highmem.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/slab.h>
@@ -965,11 +966,14 @@ static void netvsc_copy_to_send_buf(struct netvsc_device *net_device,
 	}
 
 	for (i = 0; i < page_count; i++) {
-		char *src = phys_to_virt(pb[i].pfn << HV_HYP_PAGE_SHIFT);
-		u32 offset = pb[i].offset;
+		phys_addr_t paddr = pb[i].pfn << HV_HYP_PAGE_SHIFT;
+		struct page *page = phys_to_page(paddr);
+		u32 offset = offset_in_page(paddr) + pb[i].offset;
 		u32 len = pb[i].len;
+		char *src = kmap_local_page(page);
 
 		memcpy(dest, (src + offset), len);
+		kunmap_local(src);
 		dest += len;
 	}
 
-- 
2.43.0


