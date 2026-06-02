Return-Path: <stable+bounces-259844-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lx4tKNr8HmqTbwAAu9opvQ
	(envelope-from <stable+bounces-259844-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 17:55:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3AE630023
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 17:55:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=D0wZVm+y;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259844-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-259844-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A112302D635
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 15:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3B83F2115;
	Tue,  2 Jun 2026 15:52:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC9D3BA244
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 15:52:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780415536; cv=none; b=dizjbV9ydaVG+yrJOd8XZjQ8vVbd3glQHCGZ27w6RXC+Xc/JULVSy4s3H6OsggKQCu4t69rdplqH7VPVC2o6qZ1wTXB/z47lAYQeK6hForm3Kruki1PZBsejrvcuvzaQ+J1ADHzQX+lRhEdxRNiLMuWTmJKtJ6SCdHeBdMMLrUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780415536; c=relaxed/simple;
	bh=RAL3ZX7gX3Qwt4a6LoAFqg4/b9gWA2A+ezozkGYu5v4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZNcmjJAySDK8xRVCDT6wdiSpxfp2dwra1pAA6xYtzpN3gdiPUs72zuBUmjXZ/U/Jgh1NGJ8OUNOXXaJPWTfkygqjszIEaUIL74kROpBYbI8QHHar8k11CGn+X18dUEFWtDt2o/+Bz2l+xKlZDSSOFjNtWlYHoxmzpdFNbnFNDPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0wZVm+y; arc=none smtp.client-ip=209.85.128.41
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490aebf33e9so11405215e9.3
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 08:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780415532; x=1781020332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fcSYq5CNRe914+kh+MhUoX6E3CbZbAlZ8MDYAoh0zI0=;
        b=D0wZVm+yPCQCUkDlqARJFBllvw1zfPTP3YXy460qUBOs+SkuKaLPX0+4G2Fhj3UIE9
         +GVh0dZmh6tY0zokqQFa8q8y06ssjwhSTJQ5Xpf2rfMB5/EDHv2MnCg3EDg3grmEj01Q
         DU37Re78vyEQLlfePfrySp0K89hJ3JIekz2yXvBdsXsMsQ5EuTsnS2Z2kZtZrpiL3aQc
         0/S4/CHuNf93ZE/uEcP/aOLM4rpmKDkgVa+ueHsihYHhX8xLEr5NY10bG9MfrJwaQb9J
         DGbgiph62Mf48FlLvlYm8OFWqF2pSzVA6FmNglM5FLcs2mFMyP9r1fHY3Gh+MTVZCa7u
         MIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780415532; x=1781020332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcSYq5CNRe914+kh+MhUoX6E3CbZbAlZ8MDYAoh0zI0=;
        b=NXBNrRQoza/WHOfT3xcPA4q5WcJmNaGiCbooyipZoak9XCjVFMqwIojYoBKzsBLkqV
         i+jdktBTVeV4v92eudNOMgo+P7qe5DqY+B56G/+xA6er8GyafgXk6iugUh5XSW/PMS5r
         k3lGgbwZAZtMtOoX/7bimIMghfT6+fu34k/HgZ6T1AqJTb8aaZRrxOY1ROtsiUWlJiyZ
         Z8xNi0e3YgPqy664w40ViRastU/eAvnRIxa+wapmBY7q2EymBeUL/aUwzBgQbYrFpiXV
         1Pv6vUZHrLZx/OCKQuSy78nlt6Swmy1eMSlSJHt92trxQmeM7ggyLlu5sfvZcvaA3EYO
         /8uA==
X-Forwarded-Encrypted: i=1; AFNElJ8Bs2uCHQva9Pd/ZR6tdj0apUKjFbaXqv+6aZU6MR+Og5ui1fBrqktlaih4qHXATybiGqxcPwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8fdGinLBPXiK1NndbLJInIM6Ke6tCmwLYN8PhdrePCVXxEZSl
	ei93nezbeiVMLtW+1ePUUbUYORFwolBjgs465T0g2H7YVqZncZLPlyPk
X-Gm-Gg: Acq92OESyy7dQznMWvl73mjOX6WSfFG6hucy6eq2B0Kc2SgaLoViN3vMF/G2Bx3raN0
	Hfinw1rXvzXOho7mUnHSIvTxGLm8v38oo2e3czTDRgHLStf8XnXzKca1GmtMYRWULAHGo8HuVby
	+xG4zhwJIFE2gcmJHpO581lNUBO6S3mtKkzQEk6SQYQTLuqDBuJUxmf1lyQBiZ3DN844Ytk6VlF
	vYRFEfe9InqVlpn0jOMIEP3iFMFPWmViDwftiXwu+3B3q2sVP2MRIBeB+ZWZobjp0ndQwrXgzMu
	2HQI7cm6gMHeLipcyJnY+Mt46ayMhLuMbd88IXldIEAeIWTRDUd65CGJ7M41iG5v0Hs1wM0TX3E
	rd7cH/4Bn/VoCWDKUkp1uIFTfGqNEusfbJPoqKOzhOszoCyIrlAiPyRBus/7Qtl4efQYgsDEHyR
	F/yULDt8SRElFZUk3h6UNijjsQwj09JlPOfX7BF766KWL5fKk9fOUixQtPE6J4wSf3mw==
X-Received: by 2002:a05:600c:8b2e:b0:490:48df:2793 with SMTP id 5b1f17b1804b1-490b50c634cmr4713175e9.26.1780415531774;
        Tue, 02 Jun 2026 08:52:11 -0700 (PDT)
Received: from localhost.localdomain ([5.165.242.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b55fda1dsm108445e9.1.2026.06.02.08.52.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 02 Jun 2026 08:52:10 -0700 (PDT)
From: LeantionX <leontyevantony@gmail.com>
X-Google-Original-From: LeantionX <leontyevanton1995@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anton Leontev <leontyevantony@gmail.com>
Subject: [PATCH net] hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf
Date: Tue,  2 Jun 2026 18:52:10 +0300
Message-ID: <20260602155210.90987-1-leontyevanton1995@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-259844-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:davem@davemloft.net,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:leontyevantony@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[leontyevantony@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,microsoft.com,kernel.org,lunn.ch,redhat.com,google.com,davemloft.net,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leontyevantony@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7C3AE630023

From: Anton Leontev <leontyevantony@gmail.com>

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

Map the fragment page on demand with kmap_local_page()/kunmap_local()
instead. Using pfn_to_page() on pb[i].pfn maps exactly the page
described by the page buffer entry. On configurations without HIGHMEM
(amd64, i386 without CONFIG_HIGHMEM) kmap_local_page() reduces to
page_address(), so this is a no-op there.

Fixes: c25aaf814a63 ("hyperv: Enable sendbuf mechanism on the send path")
Cc: stable@vger.kernel.org
Signed-off-by: Anton Leontev <leontyevantony@gmail.com>
---
 drivers/net/hyperv/netvsc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 59e95341f9b1..6984f6c97257 100644
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
@@ -965,11 +966,13 @@ static void netvsc_copy_to_send_buf(struct netvsc_device *net_device,
 	}
 
 	for (i = 0; i < page_count; i++) {
-		char *src = phys_to_virt(pb[i].pfn << HV_HYP_PAGE_SHIFT);
+		struct page *page = pfn_to_page(pb[i].pfn);
+		char *src = kmap_local_page(page);
 		u32 offset = pb[i].offset;
 		u32 len = pb[i].len;
 
 		memcpy(dest, (src + offset), len);
+		kunmap_local(src);
 		dest += len;
 	}
 
-- 
2.43.0


