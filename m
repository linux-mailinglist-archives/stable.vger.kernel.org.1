Return-Path: <stable+bounces-264311-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nKSAFjh2MWq4jwUAu9opvQ
	(envelope-from <stable+bounces-264311-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:13:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 702E9691D3F
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:13:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=qe4ry2ed;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264311-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-264311-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 860F03063CF7
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E73644CAF9;
	Tue, 16 Jun 2026 15:54:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475D544D03B
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 15:54:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625282; cv=none; b=bSCAGoRsMtWlDBcKxn6PmuUtHB+Z+w+Q8OMANg0JuFQbdkh/r1i+QBLwbrickhPcW+5axEF32woOtw2f36akaK8QGs/Sm9NzuzvZ/5zzml1HDaIpCAOkKFaLKPanmhlvWRHbfVVOziW5KnADel+3GRUtEDIYWEfrGUtfGUBy5PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625282; c=relaxed/simple;
	bh=hpIuMnMpiq5tMTrUEaghASeDepKFJjszq7UYaJ6A/R4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hyS6LbHBOPcimU7e0PoAQ9NHjofAs/XdgdiNvbzFNHZQ39kMw4lY2m2lEr5LYqJ26BwqNyfPERnNKlLQb1lybIrR+iRq5ftKKA1IUoDsw3vIscKcrj4alVWkLrniAirM4b58tVLx3cfJQk0b0ne3t19Nvycm8asNGpSG7LvwXdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kpberry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qe4ry2ed; arc=none smtp.client-ip=209.85.210.201
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-84238e83851so3114032b3a.1
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 08:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781625281; x=1782230081; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kvA6XJN8TSfPS5TgyCUmwChp4ib90y6BOPLLVBRRYsI=;
        b=qe4ry2edFldWA4FKrIyMh3uMoE0Um0EhMUNfdEVXFIpJDvQb71A2w4XC2rx12km2y4
         b05XFVnWK+uX90w42oWzvk854fZ/JoNgT/Cd1c1VWn59LWpRHj5EdlkGx4YVtlOx7+wM
         9Jn3M57sCyc0rM6MwTNmh+ygoS13K784AvJEcvP8BVEsIpQwimMlkL2uCGNNQVKROgfl
         nsZ9AVW6NwqVMblbX5FN6/pfdv97W5836hjQlmI/7PaA1ZLprn/wOM0361ztuwWly5DH
         rOIaEH0KVG+JWAbDaRQ9ewV79v/xjwHjMMdDmJSbfDNvtPT7n+KnoBPr6C7v1390cd6R
         Tkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781625281; x=1782230081;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kvA6XJN8TSfPS5TgyCUmwChp4ib90y6BOPLLVBRRYsI=;
        b=MBnglEDuVRXiRBSMLEalIQio01thVACdnttt6d7qB8B6STIhZp39oGxhwfskvgLYYu
         3sWhJakG0TjHvm4rBvqvEMQ2iVBa8W05GGSpIlbiM1aZlTVhMSRbUosLvB8kK7xXU+3W
         KMurTXm8EY6OJL8/ck70ixz70Plcf3NuY+5ytEaZ4QRpmqeHE0tAtQTrzjIzQiyIqKCI
         HMgluF2ITmpVzp3VFD5Lnosg6dlByoW2ckIv+9x4iapWAdwq1nqY6aqWVIe0Ir7HSrM8
         mdWr09uJ60NHUbkVW70bJe5NOdv0wVrEAZHWl7/Eq3eyHYEFIOspYanLgYz+gf+Qxqtg
         B2dw==
X-Gm-Message-State: AOJu0Yz4X9f0fIkcW07PhWjcgvi1qsWc/l45pN4edwxdmx8794HE0Ucr
	tuNif5EKiScvVHqc6knzg80zlOxHzllSspF54IPsKhiSYlqIElpClj0d+OM/GVE1XS+O38FKat9
	yaGSE68cyqIJ3rfSjVbDEptYHJ2628NOqTNwlM6JcMDPmtn1VGHSIppI83UmrE+LLXox/w0o0Sl
	Q18OtC/9n7VsYkKglA7KzSJY2Ru04s/sxNAzfGqIZmZA==
X-Received: from pfnu4.prod.google.com ([2002:aa7:8484:0:b0:842:4835:f2b1])
 (user=kpberry job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1309:b0:842:6fec:1296
 with SMTP id d2e1a72fcca58-844e193a3f7mr15981659b3a.4.1781625280173; Tue, 16
 Jun 2026 08:54:40 -0700 (PDT)
Date: Tue, 16 Jun 2026 15:54:24 +0000
In-Reply-To: <20260616155432.2093908-1-kpberry@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616155432.2093908-1-kpberry@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616155432.2093908-2-kpberry@google.com>
Subject: [PATCH 6.12 1/7] Revert "net: bonding: fix use-after-free in bond_xmit_broadcast()"
From: Kevin Berry <kpberry@google.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, bestswngs@gmail.com, chenglongtang@google.com, 
	joneslee@google.com, kpberry@google.com, pabeni@redhat.com, rnj@google.com, 
	sashal@kernel.org, xmei5@asu.edu
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,gmail.com,google.com,redhat.com,kernel.org,asu.edu];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-264311-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:bestswngs@gmail.com,m:chenglongtang@google.com,m:joneslee@google.com,m:kpberry@google.com,m:pabeni@redhat.com,m:rnj@google.com,m:sashal@kernel.org,m:xmei5@asu.edu,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kpberry@google.com,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kpberry@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 702E9691D3F

This reverts commit 3453882f36c40d2339267093676585a89808a73d.

There are two versions of this use-after-free fix commit: this one,
which was written to avoid taking a dependency on ce7a381697cb3 ("net:
bonding: add broadcast_neighbor option for 802.3ad"), and the original,
simpler version 2884bf72fb8f ("net: bonding: fix use-after-free in
bond_xmit_broadcast()"), which implicitly depends on the slave counting
changes in ce7a381697cb3. In both the 6.1 and 6.6 stable branches,
commit ce7a381697cb3 was included as a stable dep of c4f050ce06c56
("bonding: 3ad: implement proper RCU rules for port->aggregator"), and
the original version of this fix was subsequently applied.

For consistency, and to be able to apply both bug fixes, we should
revert this commit, apply the series for ce7a381697cb3 ("net: bonding:
add broadcast_neighbor option for 802.3ad"), and then apply
the original version of this fix, 2884bf72fb8f ("net: bonding: fix
use-after-free in bond_xmit_broadcast()").

Signed-off-by: Kevin Berry <kpberry@google.com>
---
 drivers/net/bonding/bond_main.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index c6b114946d9a..796654b0804d 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5328,22 +5328,18 @@ static netdev_tx_t bond_xmit_broadcast(struct sk_buff *skb,
 				       struct net_device *bond_dev)
 {
 	struct bonding *bond = netdev_priv(bond_dev);
-	struct bond_up_slave *slaves;
+	struct slave *slave = NULL;
+	struct list_head *iter;
 	bool xmit_suc = false;
 	bool skb_used = false;
-	int slaves_count, i;
 
-	slaves = rcu_dereference(bond->all_slaves);
-
-	slaves_count = slaves ? READ_ONCE(slaves->count) : 0;
-	for (i = 0; i < slaves_count; i++) {
-		struct slave *slave = slaves->arr[i];
+	bond_for_each_slave_rcu(bond, slave, iter) {
 		struct sk_buff *skb2;
 
 		if (!(bond_slave_is_up(slave) && slave->link == BOND_LINK_UP))
 			continue;
 
-		if (i + 1 == slaves_count) {
+		if (bond_is_last_slave(bond, slave)) {
 			skb2 = skb;
 			skb_used = true;
 		} else {
-- 
2.54.0.1136.gdb2ca164c4-goog


