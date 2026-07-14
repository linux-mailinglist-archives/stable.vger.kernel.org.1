Return-Path: <stable+bounces-274069-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d8tqOBSQVWqFqAAAu9opvQ
	(envelope-from <stable+bounces-274069-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 03:25:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B92EF750115
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 03:25:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b="rjD/iI1o";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274069-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-274069-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1D3AE300AB0B
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 01:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4CC362130;
	Tue, 14 Jul 2026 01:25:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A64B36215B;
	Tue, 14 Jul 2026 01:25:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783992328; cv=none; b=ftfdtPTTEvBl2xqNH70rupHRtsptPpuhWIfjwKPVd0z0CgyMGeFO02e8FTHM68KjmMeyEpKIYeN2k17hN73XrJ4v+4iDavnJUmAMwFRv5UOGKl9Hd9PwmkbC6ilN7r2p9mS5d8yVB+iM6PzbBrfcKwSSaawALNSsomGjPEbKuv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783992328; c=relaxed/simple;
	bh=thgGsFpJEZQojVex3sBQq7LLJdoik3l8v00+ChYRRjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IB4NPFrFNs8/p3nRWvF7qIeOcFm9CR8DnfM5wYq8L0yIpBRDN4z399DztrzMTZK9VirY1+R3S+bPVMwfweU+tIz+gN9f/0Z2fYmdCqOv2J344velL/fnOAoPdKgbA2OrB3LL6ZxYA4L8ntjPcsSheIF3at9Av1vXY6s23jJE/z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rjD/iI1o; arc=none smtp.client-ip=95.215.58.178
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783992324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IMXNbjv8LV7f1/2ff6ajMoMAxHEeuUYiqvJmQGLb+gU=;
	b=rjD/iI1ooqZOg1o//Lw/7BtZTLOfW6rA6yLdkT+KnVjEa+5X8zRkaSYx3nzsdrSAyDAVaL
	WdbCamj5ODKGmFetIJ44H7l33zPyrdDMegxbJrupuhNARgpl7qhq96MI2GdgwcL9PSDyGQ
	4hNVg9vEC0euq72FmIwfSbV9BIJHHUw=
From: Tao Cui <cui.tao@linux.dev>
To: zhaotianrui@loongson.cn,
	maobibo@loongson.cn,
	chenhuacai@kernel.org
Cc: kernel@xen0n.name,
	lixianglai@loongson.cn,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 2/2] LoongArch: KVM: EIOINTC: factor IP-number decode into a helper
Date: Tue, 14 Jul 2026 09:24:52 +0800
Message-ID: <20260714012452.1021833-3-cui.tao@linux.dev>
In-Reply-To: <20260714012452.1021833-1-cui.tao@linux.dev>
References: <20260714012452.1021833-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274069-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cui.tao@linux.dev,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhaotianrui@loongson.cn,m:maobibo@loongson.cn,m:chenhuacai@kernel.org,m:kernel@xen0n.name,m:lixianglai@loongson.cn,m:kvm@vger.kernel.org,m:loongarch@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:cuitao@kylinos.cn,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,vger.kernel.org:from_smtp,kylinos.cn:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B92EF750115

From: Tao Cui <cuitao@kylinos.cn>

The ipmap IP-number decode is duplicated in eiointc_set_sw_coreisr() and
eiointc_update_irq(). Factor it into eiointc_get_ipnum().

No functional change.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 arch/loongarch/kvm/intc/eiointc.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/intc/eiointc.c
index 0c34d7ab264d..c1e0cd8dca16 100644
--- a/arch/loongarch/kvm/intc/eiointc.c
+++ b/arch/loongarch/kvm/intc/eiointc.c
@@ -7,19 +7,27 @@
 #include <asm/kvm_vcpu.h>
 #include <linux/count_zeros.h>
 
+static int eiointc_get_ipnum(struct loongarch_eiointc *s, int irq)
+{
+	int ipnum = (s->ipmap >> (irq / 32 * 8)) & 0xff;
+
+	if (!(s->status & BIT(EIOINTC_ENABLE_INT_ENCODE))) {
+		ipnum = count_trailing_zeros(ipnum);
+		ipnum = ipnum < 4 ? ipnum : 0;
+	} else {
+		ipnum = (ipnum < LOONGSON_IP_NUM) ? ipnum : 0;
+	}
+
+	return ipnum;
+}
+
 static void eiointc_set_sw_coreisr(struct loongarch_eiointc *s)
 {
 	int ipnum, cpu, cpuid, irq;
 	struct kvm_vcpu *vcpu;
 
 	for (irq = 0; irq < EIOINTC_IRQS; irq++) {
-		ipnum = (s->ipmap >> (irq / 32 * 8)) & 0xff;
-		if (!(s->status & BIT(EIOINTC_ENABLE_INT_ENCODE))) {
-			ipnum = count_trailing_zeros(ipnum);
-			ipnum = ipnum < 4 ? ipnum : 0;
-		} else {
-			ipnum = (ipnum < LOONGSON_IP_NUM) ? ipnum : 0;
-		}
+		ipnum = eiointc_get_ipnum(s, irq);
 
 		cpuid = ((u8 *)s->coremap)[irq];
 		vcpu = kvm_get_vcpu_by_cpuid(s->kvm, cpuid);
@@ -40,13 +48,7 @@ static void eiointc_update_irq(struct loongarch_eiointc *s, int irq, int level)
 	struct kvm_vcpu *vcpu;
 	struct kvm_interrupt vcpu_irq;
 
-	ipnum = (s->ipmap >> (irq / 32 * 8)) & 0xff;
-	if (!(s->status & BIT(EIOINTC_ENABLE_INT_ENCODE))) {
-		ipnum = count_trailing_zeros(ipnum);
-		ipnum = ipnum < 4 ? ipnum : 0;
-	} else {
-		ipnum = (ipnum < LOONGSON_IP_NUM) ? ipnum : 0;
-	}
+	ipnum = eiointc_get_ipnum(s, irq);
 
 	cpu = s->sw_coremap[irq];
 	vcpu = kvm_get_vcpu_by_id(s->kvm, cpu);
-- 
2.43.0


