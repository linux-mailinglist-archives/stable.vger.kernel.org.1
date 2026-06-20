Return-Path: <stable+bounces-267474-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R/DIBYZRNmp39QYAu9opvQ
	(envelope-from <stable+bounces-267474-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 10:38:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6039B6A8954
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 10:38:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b="jvkFxt9/";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267474-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267474-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEAB3302B745
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 08:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1748315D33;
	Sat, 20 Jun 2026 08:38:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D131A7264;
	Sat, 20 Jun 2026 08:38:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781944702; cv=none; b=YmbgK57uccf0uIrc9zKgUOD1z+9s7e5VN67vinnPvJ7Nf2Dkx3mBAqcP/M2RwX6esj4H5H+TZThbk8Ox8B27hvYzgV/tytdZLXJHf/+fY3+Doo6eh1Msjv+m2mTbDnF5QMPbjJ/WbN3S9XRCjduUXs9zKUfeaA0+ZvNbtdaYqEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781944702; c=relaxed/simple;
	bh=zEMukMBeMwrPcONyhw38vn1lpBqPIHdDff/YFQd2mLs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GekQP8n+kwwGKWNthfp3RFq6DqxC7TV3KuwTSiUdqP7K1HSJfWs3La5MKB7LSFDKWQS2FysPf3JwCTh1xf3JYSfNdG0MEi+LQurTEmezOxePs/W4HwYs3XIp32SjJWwABrxfIHE6MMlIy+f1V7Y4XKEAnZu3eZ13Rqlz3MT15/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jvkFxt9/; arc=none smtp.client-ip=117.135.210.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=d2
	yvxLlucterId8c/ram7jvV+2CDThmj8Ip83xZTfFI=; b=jvkFxt9/s1RFI18adK
	W49+3WBuBq8AnmUkspU54x52Cku+J5YJlumUCdVS5lFo+T4eWh7kGQ47MtyFDV+G
	e+RGHX6co5V7ythfXC3AU186GGk0p+loRyH+EAZijqck8bDynOCSRf+2Cw804Yos
	6v/ex5BrEdSJu2Bv0JspfRV14=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnra9IUTZqBIGuEg--.2619S2;
	Sat, 20 Jun 2026 16:37:30 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	felix.manlunas@cavium.com,
	ricardo.farrington@cavium.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: liquidio: fix BAR resource leak on PF number failure
Date: Sat, 20 Jun 2026 16:37:28 +0800
Message-Id: <20260620083728.2722895-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnra9IUTZqBIGuEg--.2619S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw1ftF43uF1ktFyfWF1rWFg_yoWkWrX_Wr
	129wn7Xa12k34qkw4DAr4jq340kanFqrykAayUtFZ3J3y3Xws8Zr4kArs5G3Wjg34xCF9r
	uFnrKr4fXw17GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUUjQ6PUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7QqO-Go2UUqX1wAA3S
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267474-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:felix.manlunas@cavium.com,m:ricardo.farrington@cavium.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:haoxiang_li2024@163.com,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[haoxiang_li2024@163.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haoxiang_li2024@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6039B6A8954

If cn23xx_get_pf_num() fails, the function returns without
unmapping either BAR. Unmap both BARs before returning from
the error path.

Fixes: 0c45d7fe12c7 ("liquidio: fix use of pf in pass-through mode in a virtual machine")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
index 75f22f74774c..a1548ca81ecd 100644
--- a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
+++ b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
@@ -1167,8 +1167,11 @@ int setup_cn23xx_octeon_pf_device(struct octeon_device *oct)
 		return 1;
 	}
 
-	if (cn23xx_get_pf_num(oct) != 0)
+	if (cn23xx_get_pf_num(oct) != 0) {
+		octeon_unmap_pci_barx(oct, 0);
+		octeon_unmap_pci_barx(oct, 1);
 		return 1;
+	}
 
 	if (cn23xx_sriov_config(oct)) {
 		octeon_unmap_pci_barx(oct, 0);
-- 
2.25.1


