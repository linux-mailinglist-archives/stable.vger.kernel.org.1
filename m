Return-Path: <stable+bounces-254634-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFxiFhEdF2rw5AcAu9opvQ
	(envelope-from <stable+bounces-254634-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 18:34:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD95A5E7D27
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 18:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C22A3095150
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 16:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3037E43CECA;
	Wed, 27 May 2026 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVHrtEB8"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A9F439001
	for <stable@vger.kernel.org>; Wed, 27 May 2026 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779899459; cv=none; b=X4wf5tPaTYtMIvj0E2eXmkJWGRx0r/CpNLeAwc9jywWTu/QNzXTzC1n9svF7d6xBmvQB502ELs/6GTiqUr/HtrXpc8A/Vsmh/kSQUXzGKU7BSIcIfKCdTN1cIujp1FKrpcMZNWRX8PAFa4ei1CVFW/9/e9DM3ug693cd+TociBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779899459; c=relaxed/simple;
	bh=JNGzOcG5QMeYd5MA7ngdXnkn9vPeKX2Kslyj9FVCsKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CceqoTTA/rbmJJSK5GajMRAmP2qJ8b6qSkxOVrHffhnpE007x2J3LIRqimkCqeOqsbPdEf4ai4o6D4brGbU3lt38afE6AfsxR3MdPMdzK11dMIRL6CeiirJj5v4Jx3VMR6KR2YBa8YcJDmd89XpqEzQTmRXumHpSlljjM01POw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVHrtEB8; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-961556c15ceso2607728241.3
        for <stable@vger.kernel.org>; Wed, 27 May 2026 09:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779899456; x=1780504256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ap86tkOp/ebDH9IC2+Z2JnCI+7L+9R6FqA6vt+enK7I=;
        b=ZVHrtEB8hxQWDMgh/YEaeaJQcicKukTxHxgxqOHWEfit2seOkYdJP6mBCGRBeomWzH
         FC5EuSGqfxR4G7ukhku6o57Nx67Yi/pLVFBKEu0sbMoLI4eSUN4t2Qz3w/FbxDXBrXnG
         QlLbHM7a6Cn625Ylv6GKVBXajhG5Q4mdJePGpcklhpv9tL5+ef5LLL1ZqF0yGGMwhTXD
         TGdPj5xBjlbznXMPVLC7VW4SDQZswrVhd5K2juFBHWJ5oaHs5WHEBWdd3jOJS+iUjLbv
         zhHeBMCzioO71YXQOYmRPBIKsLvE54AbdzLZ8Vx0K3UvIVPQLnVLgMYgFcjynJ+nJRvU
         DNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779899456; x=1780504256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ap86tkOp/ebDH9IC2+Z2JnCI+7L+9R6FqA6vt+enK7I=;
        b=A1KByn3Q9k2MqlVgrodpEZGJmpshVho5097exkdVFquFv9E2VEpT+5BGR4XlVH0asy
         B0C6fy0NS55ghzSJuIhiZYuDGqgx4AWqnAsZGoNcRjWd+LkzWnYkYGs7C5sT2opLTYBQ
         ym1ZvsgoY8Fiz1DG2EA9KOP+dMtVeMPrk72au6rAdXbs8DM9reXuJ/VS5d4TI2kKy6vW
         gHtnihXqb6Kt4h2yY20VHxmajGzDWeeNvfFu+nghWdY8ANnGUuWRjW2YFwfIYohRcZDf
         Wfa90OLmLP6ipT1dBG4ARnC3k9NamIWcKfcDzjUMX5QklsvMYuaS0yNfhvAewlpAqKb/
         xA7Q==
X-Forwarded-Encrypted: i=1; AFNElJ86zewB8a7UevZX4AKtme/sgS+zxX0sgYYWTWL0GwLzanGcBAi69hYV5EguALzEfVcrpeAi2LQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIUb4dlPLCB34jFw8zCISEmbVulLwpdKbdLbVtfHJIc1vyVPmw
	RO21jTzbYqR7LER0rLFQZcV0MzzTWzCeoS7pFPsRMU0A8lmiHjM99twjub17+uom
X-Gm-Gg: Acq92OHSj3ha4eL4lenJN6nysjY/mE6v6rYhNwv6T6JdTXsWuUZ1yCG+ZoHyEllNUJj
	j1LIiDIUpWy+7XMdk9Ro3xLiXyCjTqr457cnpLnirDL9r/S6z3GahwRvol9eX83Kz7wC+X1bDc9
	0IBBOC9GJQKIL8kMO/r9rhKaVagre8BldtND6BI+lhpiq8hvqBpLzuIy2sHreFtFeR54bAR8wqL
	0DtpeYzQH1Ji3jHNoUC684dmc0jL5DpFHiLN3nM8Z+F8aXIUZ7p0vyj979ITVB+Jx2PE6/0Yuxz
	68aiL/yjuRPsz/kxczkq3njrDGidQvVCde414pkheuEHpD2OjegXJxrzii+Brtz3RBH1AU1tp4p
	0d2M5nzunSaf34d1s9PF0LfxQf9uMSpD6lABBwqwyqay4pgkeVQ+M7QoVdLKxfdTL0F8qek1bOr
	KyYIRhh3MR0Mgecu6Ot3EEq2EWcoJG/r/uE2Yl+JHWYuzWsh2EJPN0qYRvOYGlcQtmwNTkVKHBD
	q+ITfjgt9O4X18+JiYtV1z5kFQRveiVk0X/NGfAH7+pJjEmKRNIeA==
X-Received: by 2002:a05:6102:3f08:b0:631:4d87:ba5f with SMTP id ada2fe7eead31-67c7490af39mr11660094137.3.1779899455976;
        Wed, 27 May 2026 09:30:55 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc812e0413sm188819356d6.31.2026.05.27.09.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 09:30:55 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Tom Haynes <Thomas.Haynes@primarydata.com>,
	Peng Tao <tao.peng@primarydata.com>,
	Kees Cook <kees@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] NFSv4/flexfile,filelayout: bound multipath DS count in GETDEVICEINFO
Date: Wed, 27 May 2026 12:30:36 -0400
Message-ID: <20260527163036.1524927-3-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527163036.1524927-1-michael.bommarito@gmail.com>
References: <20260527163036.1524927-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-254634-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CD95A5E7D27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Both the flexfile and the (legacy) file pNFS layout drivers decode a
multipath-DS count from a server-supplied GETDEVICEINFO body and then
iterate it via nfs4_decode_mp_ds_addr() without any upper bound. The
filelayout driver already caps the outer ds_num against
NFS4_PNFS_MAX_MULTI_CNT (== 256) but applies no equivalent cap to the
inner mp_count; the flexfile driver applies no cap on either.

In addition, both inner loops ignore a NULL return from
nfs4_decode_mp_ds_addr(), so once the on-wire data no longer matches
a valid netaddr4 encoding the loop is free to consume the trailing
bytes of the device_addr opaque as garbage netid + uaddr pairs. A
malicious or compromised pNFS metadata server can therefore drive
the inner loop indefinitely (up to 2^32 - 1 iterations) against a
fixed-size 56-byte body, with each iteration triggering an
allocation / kmemdup_nul cycle inside the decoder.

Promote NFS4_PNFS_MAX_MULTI_CNT from the filelayout private header to
include/linux/nfs4.h so both drivers (and any future pNFS layout
driver that decodes a multipath address list) bound the wire-level
field consistently. Apply the cap to the inner mp_count in both
drivers, matching the existing ds_num check, and bail on the first
NULL return so a server that lies about mp_count cannot quietly
extend the loop into the trailing layout-body bytes. This is
defense-in-depth on top of the companion patch which closes the
NULL-deref in nfs4_decode_mp_ds_addr(); either patch alone closes
the kernel-panic shape, both together close the latent
unbounded-decode class.

Cc: stable@vger.kernel.org
Fixes: 35124a0994fc ("Cleanup XDR parsing for LAYOUTGET, GETDEVICEINFO")
Fixes: d67ae825a59d ("pnfs/flexfiles: Add the FlexFile Layout Driver")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Changes in v2:
- Carry the stripe_index provenance comment from filelayout.h to the
  new NFS4_PNFS_MAX_MULTI_CNT location in include/linux/nfs4.h, as
  Anna requested.

With this patch alone the crafted GETDEVICEINFO at multipath_count >= 3
is rejected at the bound check; malformed netaddr in the inner loop
bails on the first NULL return.  Either this patch or the companion
1/2 closes the panic; both together close the unbounded-decode class.

Baseline multipath_count = 1 mount + read completes normally.

 fs/nfs/filelayout/filelayout.h            |  2 +-
 fs/nfs/filelayout/filelayoutdev.c         |  7 +++++--
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 10 ++++++++--
 include/linux/nfs4.h                      |  5 +++++
 4 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/filelayout/filelayout.h b/fs/nfs/filelayout/filelayout.h
index c7bb5da93307d..03298f2e7cd69 100644
--- a/fs/nfs/filelayout/filelayout.h
+++ b/fs/nfs/filelayout/filelayout.h
@@ -39,7 +39,7 @@
  * RFC 5661 multipath_list4 structures.
  */
 #define NFS4_PNFS_MAX_STRIPE_CNT 4096
-#define NFS4_PNFS_MAX_MULTI_CNT  256 /* 256 fit into a u8 stripe_index */
+/* NFS4_PNFS_MAX_MULTI_CNT now in <linux/nfs4.h>; shared with flexfile. */
 
 enum stripetype4 {
 	STRIPE_SPARSE = 1,
diff --git a/fs/nfs/filelayout/filelayoutdev.c b/fs/nfs/filelayout/filelayoutdev.c
index 7226989ee4d53..c58c786dcf011 100644
--- a/fs/nfs/filelayout/filelayoutdev.c
+++ b/fs/nfs/filelayout/filelayoutdev.c
@@ -159,10 +159,13 @@ nfs4_fl_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 			goto out_err_free_deviceid;
 
 		mp_count = be32_to_cpup(p); /* multipath count */
+		if (mp_count > NFS4_PNFS_MAX_MULTI_CNT)
+			goto out_err_free_deviceid;
 		for (j = 0; j < mp_count; j++) {
 			da = nfs4_decode_mp_ds_addr(net, &stream, gfp_flags);
-			if (da)
-				list_add_tail(&da->da_node, &dsaddrs);
+			if (!da)
+				break;
+			list_add_tail(&da->da_node, &dsaddrs);
 		}
 		if (list_empty(&dsaddrs)) {
 			dprintk("%s: no suitable DS addresses found\n",
diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index c40395ae08142..faed05cbe9f1c 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -78,12 +78,18 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 		goto out_err_drain_dsaddrs;
 	mp_count = be32_to_cpup(p);
 	dprintk("%s: multipath ds count %d\n", __func__, mp_count);
+	if (mp_count > NFS4_PNFS_MAX_MULTI_CNT) {
+		dprintk("%s: multipath count %u greater than supported maximum %d\n",
+			__func__, mp_count, NFS4_PNFS_MAX_MULTI_CNT);
+		goto out_err_drain_dsaddrs;
+	}
 
 	for (i = 0; i < mp_count; i++) {
 		/* multipath ds */
 		da = nfs4_decode_mp_ds_addr(net, &stream, gfp_flags);
-		if (da)
-			list_add_tail(&da->da_node, &dsaddrs);
+		if (!da)
+			break;
+		list_add_tail(&da->da_node, &dsaddrs);
 	}
 	if (list_empty(&dsaddrs)) {
 		dprintk("%s: no suitable DS addresses found\n",
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index d87be1f25273a..79f4168cb6ab7 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -767,6 +767,11 @@ enum pnfs_block_extent_state {
 	PNFS_BLOCK_NONE_DATA		= 3,
 };
 
+/* Maximum NFSv4.1 pNFS multipath data-server address count;
+ * 256 fits in the u8 stripe_index used by the filelayout driver.
+ */
+#define NFS4_PNFS_MAX_MULTI_CNT		256
+
 /* on the wire size of a block layout extent */
 #define PNFS_BLOCK_EXTENT_SIZE \
 	(7 * sizeof(__be32) + NFS4_DEVICEID4_SIZE)
-- 
2.53.0


