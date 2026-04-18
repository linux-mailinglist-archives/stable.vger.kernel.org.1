Return-Path: <stable+bounces-238591-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJOMORqR42mvIgEAu9opvQ
	(envelope-from <stable+bounces-238591-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 16:11:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 508034214A2
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 16:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49AF73025E79
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 14:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77BE386C1B;
	Sat, 18 Apr 2026 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZyEL/1F"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356AC386C06
	for <stable@vger.kernel.org>; Sat, 18 Apr 2026 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776521484; cv=none; b=jQfH2pkYHsCNMEOFafGDn9JihtN3i780JvjN3jnV3WeorH9zi75exoCjhIQTe3Kmw74uAEKenQz42+xklWDYUN8M4rLyPcTLZFyCo9OxH0FSQR5FNxJOkvlBIjLOdaz3zB7YXHlaWvmxMO51xkmU/236eGMdQjFJSZhh2nivQYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776521484; c=relaxed/simple;
	bh=I0az/gxWNWRojxzwlp4c7cgSeHVy/+2ZpNHP43t2+TU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfzcDA/ZxgZ27J8IEYquhR6aaHKLaX56FJO/UXKUBZ58h/bCXv0Qju1dabatY+SDkgEwFvbdmXseECSpuxkTxi+a+Vuoyal6L6EFUBP6T2+hP63WtCeRoB76t5SKAnuf0LdRHRk87Q74XkwqE8WtCrszJC8r5iiumCjRzp7YBTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZyEL/1F; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8c9f6b78ca4so203425685a.0
        for <stable@vger.kernel.org>; Sat, 18 Apr 2026 07:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776521482; x=1777126282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6smO5yl2bUfwH7kRsW449RY4L+N7gHn/VFYMUm3A7uY=;
        b=eZyEL/1FWlG2DyxEAhqoFgPh5NAQBvm2HH0bBHYA4uCXok3dz/VqXuUnDqMfGoMzeP
         THgHQ0YzKe7ADXAsk7/J70qP5tomDHlEkGMWW9pHqp49/2gwH1c3OssYEgL3gHLG/RhZ
         Zcup9X0pNa5AczOpr11wGTl/6fK7pPpt35/7abdobvuUiob+uF2xOM8AvnFNzexeTNf2
         0xzEOwjjHNIyM2X2nmbLpQYFI0chuklcI5qHwaEbJYVMm/QOPlFXQynSHxOvdX6CyGsg
         yQDROhNBERyb3W/KkkIHIvsIb6jiTTJenRiROrVSy2DfMgq+X2vS+i1hun72plbh3Ppe
         c5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776521482; x=1777126282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6smO5yl2bUfwH7kRsW449RY4L+N7gHn/VFYMUm3A7uY=;
        b=edYsBAhGrwkkI+m5TVf64HqAbDg9SYPkQoNOlGSdL1OGG59rVA3zwE4iTQNrL+p+RX
         uSYtD0RfhWwWG3hnNYx9Lfbp6y+kE5kqbV6J7HMx0GVYLB+aNMis0mkTLbvU0WZAk1Gs
         qK3SgwL7qC9EGYZ0O4N4AHFkV1511QrRuljPBX973IhxGhYYLrKr0jlcprFb6bh1afuQ
         kNkm7yN0ptKDRkZVDNWHW2RPrMprK5kV7jTCgyFttXfzhbRHCBANlX7/gBr5MZheqHk2
         rfe37WZvhnNuZNI7Ua9kvv6VqeHJUnZkE6z9/k8ORQToMKRyeTlMfcZyHO4uyS/JQhqs
         sg6w==
X-Forwarded-Encrypted: i=1; AFNElJ82sU7Odj0YWMl8xMRRnKS+T9esw3R2AbafiKfWOFHdeTO6md2wF3zff5q2Rj3A2d9LMV95rb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSy8KOBE/vDI2yjICBzWosd5Fnc7z+jfUf1Nygw6MQ0vEZqq6V
	/PqKg8S7mga849BWIRgYhZ3x+5H84sEiZ7SK5vIh9etc4iXJ/iiWKmuS
X-Gm-Gg: AeBDieuSqx4T4xqyDPCoUPz5IiyyB11INzQcCgghyxwNKg41IP6M9WUa8D3cmBWX+WG
	SOk/jL/Xm8/xnNd4ShHWb2PapgNFWTQ4ftnkOEbvpmd6f7MswAFhOMem0nKO3H2Mc8/1QaA3JOP
	cid4z34GoCJ9vaSYz0OKrjVaoxKsorT3HcEKuUrqACOBtC+UxGIB1vIipdC8FhO8Nt+o6BtPFwc
	9UIUMwhgEkr987Oba5d3dakW7mFgA0M51lQb0EmUNq9a/DKWh/eKm3wNya5KeWAoV8bGuYsmnOA
	mzZ5suw7qiSclRpHVdf2X5aBnH8ETwHMTpwRsuwNIu3QmiCqSRmrdl9cW2xYNK3NQQfeAvE+MIE
	oLiWRtCBE5YE4HxV5K3CpWmYaYkPzUccA9zBr0F3r+HZofuFvwPjCfOjcwXhQJIsBVl0JjTxsR4
	DnBs3tl+IRFAjTkvBZo6X/4eQPA122FVIWMTWVnHmzAA+fyNwlzF+Qbgq9CtlKE6iRI4pO+Sgtu
	Spp/ug26VRxd7PBpcxKST7p2FOP/f0=
X-Received: by 2002:a05:620a:469e:b0:8d4:5ae1:633a with SMTP id af79cd13be357-8e791d8710dmr959218385a.42.1776521482156;
        Sat, 18 Apr 2026 07:11:22 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d94d2efcsm350046485a.38.2026.04.18.07.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 07:11:21 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Allison Henderson <achender@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Sharath Srinivasan <sharath.srinivasan@oracle.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] net/rds: zero per-item info buffer before handing it to visitors
Date: Sat, 18 Apr 2026 10:10:47 -0400
Message-ID: <20260418141047.3398203-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417141916.494761-1-michael.bommarito@gmail.com>
References: <20260417141916.494761-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238591-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 508034214A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rds_for_each_conn_info() and rds_walk_conn_path_info() both hand a
caller-allocated on-stack u64 buffer to a per-connection visitor and
then copy the full item_len bytes back to user space via
rds_info_copy() regardless of how much of the buffer the visitor
actually wrote.

rds_ib_conn_info_visitor() and rds6_ib_conn_info_visitor() only
write a subset of their output struct when the underlying
rds_connection is not in state RDS_CONN_UP (src/dst addr, tos, sl
and the two GIDs via explicit memsets). Several u32 fields
(max_send_wr, max_recv_wr, max_send_sge, rdma_mr_max, rdma_mr_size,
cache_allocs) and the 2-byte alignment hole between sl and
cache_allocs remain as whatever stack contents preceded the visitor
call and are then memcpy_to_user()'d out to user space.

struct rds_info_rdma_connection and struct rds6_info_rdma_connection
are the only rds_info_* structs in include/uapi/linux/rds.h that are
not marked __attribute__((packed)), so they have a real alignment
hole. The other info visitors (rds_conn_info_visitor,
rds6_conn_info_visitor, rds_tcp_tc_info, ...) write all fields of
their packed output struct today and are not known to be vulnerable,
but a future visitor that adds a conditional write-path would have
the same bug.

Reproduction on a kernel built without CONFIG_INIT_STACK_ALL_ZERO=y:
a local unprivileged user opens AF_RDS, sets SO_RDS_TRANSPORT=IB,
binds to a local address on an RDMA-capable netdev (rxe soft-RoCE on
any netdev is sufficient), sendto()'s any peer on the same subnet
(fails cleanly but installs an rds_connection in the global hash in
RDS_CONN_CONNECTING), then calls getsockopt(SOL_RDS,
RDS_INFO_IB_CONNECTIONS). The returned 68-byte item contains 26
bytes of stack garbage including kernel text/data pointers:

    0..7   0a 63 00 01 0a 63 00 02     src=10.99.0.1 dst=10.99.0.2
    8..39  00 ...                      gids (memset-zeroed)
    40..47 e0 92 a3 81 ff ff ff ff     kernel pointer (max_send_wr)
    48..55 7f 37 b5 81 ff ff ff ff     kernel pointer (rdma_mr_max)
    56..59 01 00 08 00                 rdma_mr_size (garbage)
    60..61 00 00                       tos, sl
    62..63 00 00                       alignment padding
    64..67 18 00 00 00                 cache_allocs (garbage)

Fix by zeroing the per-item buffer in both rds_for_each_conn_info()
and rds_walk_conn_path_info() before invoking the visitor. This
covers the IPv4/IPv6 IB visitors and hardens all current and future
visitors against the same class of bug.

No functional change for visitors that fully populate their output.

Changes in v2:
- retarget at the net tree (subject prefix "[PATCH net v2]",
  net/rds: prefix in the title)
- add Cc: stable@vger.kernel.org
- pick up Reviewed-by tags from Sharath Srinivasan and
  Allison Henderson

Fixes: ec16227e1414 ("RDS/IB: Infiniband transport")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Reviewed-by: Sharath Srinivasan <sharath.srinivasan@oracle.com>
Reviewed-by: Allison Henderson <achender@kernel.org>
Assisted-by: Claude:claude-opus-4-7
---
 net/rds/connection.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index 412441aaa298..c10b7ed06c49 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -701,6 +701,13 @@ void rds_for_each_conn_info(struct socket *sock, unsigned int len,
 	     i++, head++) {
 		hlist_for_each_entry_rcu(conn, head, c_hash_node) {
 
+			/* Zero the per-item buffer before handing it to the
+			 * visitor so any field the visitor does not write -
+			 * including implicit alignment padding - cannot leak
+			 * stack contents to user space via rds_info_copy().
+			 */
+			memset(buffer, 0, item_len);
+
 			/* XXX no c_lock usage.. */
 			if (!visitor(conn, buffer))
 				continue;
@@ -750,6 +757,13 @@ static void rds_walk_conn_path_info(struct socket *sock, unsigned int len,
 			 */
 			cp = conn->c_path;
 
+			/* Zero the per-item buffer for the same reason as
+			 * rds_for_each_conn_info(): any byte the visitor
+			 * does not write (including alignment padding) must
+			 * not leak stack contents via rds_info_copy().
+			 */
+			memset(buffer, 0, item_len);
+
 			/* XXX no cp_lock usage.. */
 			if (!visitor(cp, buffer))
 				continue;
-- 
2.53.0


