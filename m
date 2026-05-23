Return-Path: <stable+bounces-253870-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CieKc0FEWp+ggYAu9opvQ
	(envelope-from <stable+bounces-253870-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 03:41:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AA00B5BC5FB
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 03:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F1CE3011F67
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 01:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A2728850D;
	Sat, 23 May 2026 01:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCqx65r6"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F08225B0BA
	for <stable@vger.kernel.org>; Sat, 23 May 2026 01:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779500444; cv=none; b=ltD4ESoxiibvLCXG665Gz6BGA5UKif/o/YhRHlgpwUrQyACkFsaWsS0c3WzFT8bYDDq6vCL8P2UorXdVjRxm0B75E9uvUVmK3c7hHDqXxhLNEFPluxunT6a07EugHc+Q+DshJFnv0G2ijA8pJtmZQvI04Ycn7M9Rtjh68vODJIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779500444; c=relaxed/simple;
	bh=hnduPY82/gGMnSQk7PIZuYmtQRqZ9KgbG5y9Zo+wlAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJc26mrKcuMlJUcVFTv33QqlC5UX2rV4FPOXB+l/yDhsGdar7E8SVjyxMfevpmca0n3PGkYm+NzItr+WEaXSxJL85rIl7rxoH6jYs+5Mn+WSgbaBdDO4udbNhyikAvJ+d5Zo8vUql5Yqw/2AN2gu5v6Z56dkw42TII4IOAinJS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCqx65r6; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-516cbde40f2so24813481cf.3
        for <stable@vger.kernel.org>; Fri, 22 May 2026 18:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779500441; x=1780105241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6cmfWT4Yx0qceSMPkSgJjcCJUqUmrReUf7axDysEWM=;
        b=DCqx65r6vGsgdHDLDLDCz99TB0Y0m4QQfonN4pMO1+OVVQY8CZY4Vd2Ts86lyNJ7yo
         8RDm4FI2vnFEWM1mKf0cZMV8PNNtwxwRa647pOQ7uISsEEEsokDcjXlsxFpGvY+KVmqJ
         Q0BpC/0YVM5hzkCOEzBdPaH0neGnYW2QeaekwDrSqOWxLXzXhp6tWFbyaFTvMzxlUK1F
         zuY8DUSj4PWtTs9H2xKSYsjCKfuOo/bkkeN9C+Z/DHlTrdJ4h14fMGJMH151/ck/oamZ
         rHSsMzgskxJrRgoav0vNmIcv5tq64Q/fcx9qN8wHqUQsptTEbdwvtJckT4Lseqhhgv1U
         6N8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779500441; x=1780105241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/6cmfWT4Yx0qceSMPkSgJjcCJUqUmrReUf7axDysEWM=;
        b=R4AbnjyQuQA+uOBldAz/oNRrGMsG9GTVtQzpQKF77CloFrOdzzf84RTXqFD/gaYgGZ
         x8s3AWqXgwJO5F3bQ/Wk4Y0tNLmz+c3I5zWI2DLAeN5H0xTQ6hcMQdFVWOice4jNIoa6
         QxIxYeMSgt8pRSfQK0JiyXB0TFlPh9Cjo0m8TMWcz2HbipIYqeCYfmGgtsQA16X26LH0
         BQyGRXwb1a47ecjXcrBPlIRnbJQxyxZwyeDgeJjPwP6SN3YvrnHcIGb8zSYnQsFvbBJq
         M4Lo58i8HrRD22XrKD3QwLcTEkSdog1qvAvGz1KeRAxC3p8A3Sfb6w8/vNBXKKFEZYIg
         uBuw==
X-Forwarded-Encrypted: i=1; AFNElJ8bMcSavkSFNNBxkTeDld82hbnc5yYNQg+yY1wY7PFGbNS85XjFN/qUcEtwFIB0hBGmK2xdOn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx56e5INhjMOg0/xW5CXk0XNJviz/QIklr5h9mJjViRPGi35S50
	IBiJHs0V+Cw2fe6gjutmjcMN8UboJLpGyqAtoeyQI9nv9OtCPK1MD4xn
X-Gm-Gg: Acq92OGabEcHdMpvvEv3Yfqecbx2vECc1/anXsIOl4/3Go4dxRrOIg0x9R88eKecdGg
	yAkyJXmj3hNHbzE15TARseWpAjUYgxDiKkkh+SOGkYmk1Q2dUHhMQ0BHlFP7UO2rQaMfpPHmjn2
	gTyPSZFT7I+k5hQ8GJhbTdJXuWLqoqkISELafI8QgxvbL0j42TppfBRWar5nM/3U+4T+8Fy1kkM
	0MD7ChY3X/CUDAWnoDxBE1KRMFOBTm56CctDZR9aqDvl2gyCCDlZLNZjbjardE58HqazkLN2btk
	HR1zyG5lyE3OE5RTIH2a9i4QVBsIlgxJUA0mSHGd2C2mCMCYTidaLuo5JbN+p7s6BkUfu1w8yAp
	+wF19CHYs45w86oeTiPM8vnoJTOrthyML6dXBs8UhDrXaji1p+Uw0AzaxsXBVvU34QuPYWj1zhn
	mbB1KTxtbKQo4z5FqMAoUqLgk0R5t7lhTPqlP/rkqKcCO+st9tpPWej8eNPTAiqdO1H1nQL/a4E
	LblFF7jI22tBqpQEfVjFA9PoDz3Snw=
X-Received: by 2002:a05:622a:94:b0:50f:be4f:465b with SMTP id d75a77b69052e-516d46455b3mr84987961cf.33.1779500441203;
        Fri, 22 May 2026 18:40:41 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8b247c4sm28559031cf.7.2026.05.22.18.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 18:40:40 -0700 (PDT)
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
Subject: [PATCH 2/2] NFSv4/flexfile,filelayout: bound multipath DS count in GETDEVICEINFO
Date: Fri, 22 May 2026 21:40:33 -0400
Message-ID: <20260523014033.2459677-3-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523014033.2459677-1-michael.bommarito@gmail.com>
References: <20260523014033.2459677-1-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-253870-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AA00B5BC5FB
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
 fs/nfs/filelayout/filelayout.h            |  2 +-
 fs/nfs/filelayout/filelayoutdev.c         |  7 +++++--
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 10 ++++++++--
 include/linux/nfs4.h                      |  3 +++
 4 files changed, 17 insertions(+), 5 deletions(-)

With this patch alone the crafted GETDEVICEINFO at multipath_count >= 3
is rejected at the bound check; malformed netaddr in the inner loop
bails on the first NULL return.  Either this patch or the companion
1/2 closes the panic; both together close the unbounded-decode class.

Baseline multipath_count = 1 mount + read completes normally.


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
index d87be1f25273a..bfc30baa8159a 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -767,6 +767,9 @@ enum pnfs_block_extent_state {
 	PNFS_BLOCK_NONE_DATA		= 3,
 };
 
+/* Maximum NFSv4.1 pNFS multipath data-server address count */
+#define NFS4_PNFS_MAX_MULTI_CNT		256
+
 /* on the wire size of a block layout extent */
 #define PNFS_BLOCK_EXTENT_SIZE \
 	(7 * sizeof(__be32) + NFS4_DEVICEID4_SIZE)
-- 
2.53.0


