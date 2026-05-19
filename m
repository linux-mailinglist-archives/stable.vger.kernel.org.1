Return-Path: <stable+bounces-249672-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OhVMuK0DGrClAUAu9opvQ
	(envelope-from <stable+bounces-249672-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 21:07:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CA358402E
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 21:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D365D3007B24
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 19:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903D93DCDB0;
	Tue, 19 May 2026 19:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJa+iHYc"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3E139B48E
	for <stable@vger.kernel.org>; Tue, 19 May 2026 19:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779217599; cv=none; b=pqab3unpOkZzOSBWXQtEtfvMZo/mSGP1llBx2MX4Vm3KEvRBeicXaIPMZj5vp3+WPgdzaKBq+0hXFF0H4zA5odFXXKi3E7UZxG2W6RRzfGkfNMyCkV8MkzisUCy1DjYD+GN/sz3Ud9Y1N124vHtqy8V5DVyMSiawqis0X9nc3I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779217599; c=relaxed/simple;
	bh=+R+LjFInjA7vyxj+p9DyJ35DmVdXYIIr2T3gPmEFlxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FhxRlgBAfup24oY+KwZ37M4PS57sQiRFCPEzFLl+hUpbzGJyiBRh+rJ6Slf/5UvXWjEvirrm9ahiD1csI5BcRAYOCSNwIGJjOFUzkRILXmMiPecW069P1jupACcGxAlMkdAh3dpWyOV5kbe1MFNz6EvaoyrQR5VQ1/olLB5Gr2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJa+iHYc; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50e5dbd8e0eso46955991cf.1
        for <stable@vger.kernel.org>; Tue, 19 May 2026 12:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779217597; x=1779822397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frUuugDajwbIOykQjzhC84jXkkFKRlA58W38jq3zHQc=;
        b=LJa+iHYcOuO7UmgxhESdF1A3p/p9GLOxYoRWs70GT11DKUigMrojexeIzrt1xlCKu5
         gV/im335br1SxY83lJuHxkB3GG9kwJYm3QWxubm7V6RIfW5PisdFwIF/W1vhp+Ifwtfx
         qcft3npId1yqCxQU+/Poi1BikkS3oANz224LlSlRKm7uFQmtbZmwV0zkpo0hutSSBRtU
         vjSgVtorwKBMpW4vT0zNRkfpL4qIIH28RAOTs7pYE66o3j7neW1ADZOA1iuhwCoXXJb4
         fO5b3tGG1YiiyAFMpxB2L+oEESWw9irNUoHdnaYRb2ZQHzpK3qQ7ybKhXBqORtY5kIzs
         zRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779217597; x=1779822397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=frUuugDajwbIOykQjzhC84jXkkFKRlA58W38jq3zHQc=;
        b=TKSYH4CLDAOyW1JjKNWPJn0bvKG55fknutBWMmkJyLv1WmHSu1iDDVzQL0MZqk1viC
         3adwCPwwbC9qYiUf5eGbNAsGD2sgWbatRS1JdS3K3pjAX9oyaaA9PszzTIVkIVel5F2d
         TcGHHiuPR3UMzcKsBK5YN7XJVj94onqUvbWPOTgtO/Vs5E6fbKuP4O/K4n0k0WYUe35W
         9QfxBZaC/rXz86ynLLuWQoX7wDC7tUEC1CKm3KLjqbXVoR9vr1jnTajIct+ji7na0ZZN
         knZtVTh3gY0jdpxr2uTF/c9WuP5yYpTApfvbDHv9p5Bf1nFoII6vervFydjF3PhSCOlp
         lfag==
X-Forwarded-Encrypted: i=1; AFNElJ+bxNqxhVnx5O5y4PDsK0O8NeRX8Zs0uCWM0EbXWiQn0eL7wBadjzz2O5YyucH6UONhCu3X9ys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8pt62+bNolTakidJHb07W2BSS4+RB6U/pnF7VN2pjCKpXkAxI
	qpdW1bUjY2Ieur7fBpqYjPv5fwNsFaUVOyY+xWVDDTe1HDPVdGq+0SAMOwO+PaIp
X-Gm-Gg: Acq92OGoJ/ziftnZyG0SC+AJKquCXpeHB8iYx+QeiqMufpx5YqlZCAKcdF+6Tr0LUDh
	/96j11P5U9VGPFXh4bnNIx1n6L32A7k1GaIw3c8gNyLBoru/ZdBXnFRvQ7RdwXLFZww+EUcKaYB
	VR3xZFynS8Tfu59xeh/BasJu8NFSa9axr8zKkr7pZMFgikEmZlIkN5sLkP55Qj8/DmRGfZ98mQL
	f2huuE5phHV3mMcbiuS5Fnts1Sn0hw3onGojZ7f4D+/8KLip2N4+AZhC9e7xxYJTzvVW9RNfVKn
	/7CexYQepxjNtSy/0p+8cPe/Q1b1JyDQLvHKtNdLb9nhdqNiOH3O+mNc0GBUpGIN/AEhfwRf1VV
	qTH+GUlV7PIygNBduAkt3L58ckzSi9DWVbE7Az5zNO8/kQPvJF50r3BmUiLUEdALxzIeY63LSrT
	XEqwQQL6M8j00S9LPXiURbmRd/uKhGwjNfAI7XZ7pKUNGWXxbIEhsX4hxp3g3p7oUzSxAVRnwH9
	1t9Ijpzv4WhZGbIOUy+
X-Received: by 2002:a05:622a:2445:b0:4f1:ab79:fb18 with SMTP id d75a77b69052e-5165a03e931mr269170821cf.25.1779217596596;
        Tue, 19 May 2026 12:06:36 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5164585fa0asm187088571cf.31.2026.05.19.12.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 12:06:36 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Nilesh Javali <njavali@marvell.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	Shyam Sundar <ssundar@marvell.com>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	Bryan Gurney <bgurney@redhat.com>,
	Justin Tee <justin.tee@broadcom.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] scsi: scsi_transport_fc: widen FPIN pname walker counter to u32
Date: Tue, 19 May 2026 15:06:15 -0400
Message-ID: <20260519190615.2761667-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518143706.2808177-1-michael.bommarito@gmail.com>
References: <20260518143706.2808177-1-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249672-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F1CA358402E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

An adjacent Fibre Channel fabric actor that can deliver an FPIN ELS
frame to an lpfc or qla2xxx Linux initiator can trigger a non-return
in the generic FC transport. This is not a local userspace or IP
network path; the attacker must be able to inject fabric traffic, for
example as a compromised switch or fabric controller, or as a same-zone
N_Port on a fabric that permits source spoofing.

The Link-Integrity and Peer-Congestion FPIN walkers used a u8 loop
counter against the 32-bit on-wire pname_count field, and did not bound
pname_count by the descriptor body already validated by the TLV walker.
A pname_count of 256 therefore wraps the counter and keeps the loop
condition true indefinitely.

Factor the shared pname_list[] walk into one helper, widen the counter
to u32, and clamp pname_count against the entries that fit in the
descriptor body before iterating.

Fixes: 3dcfe0de5a97 ("scsi: fc: Parse FPIN packets and update statistics")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Changes in v3:
- State the fabric-adjacent threat model explicitly in the commit
  message and clarify that this is not local userspace or IP-network
  reachable.
- Use min_t(u32, ...) for the pname_count clamp, as Christoph suggested.
- Use FC_TLV_DESC_LENGTH_FROM_SZ() instead of open-coding the descriptor
  body length calculation.
- Factor the duplicate LI and peer-congestion pname walker into a common
  helper while preserving the LI-only host-stat update.

Changes in v2:
- Drop the redundant cover letter shipped with v1.  A single-patch send
  does not need one, and the v1 cover carried stale draft markers.

 drivers/scsi/scsi_transport_fc.c | 77 +++++++++++++++++---------------
 1 file changed, 41 insertions(+), 36 deletions(-)

diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
index dce95e361daf0..0684d8c69c3c6 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -737,6 +737,37 @@ fc_cn_stats_update(u16 event_type, struct fc_fpin_stats *stats)
 	}
 }
 
+static void
+fc_fpin_pname_stats_update(struct Scsi_Host *shost,
+			   struct fc_rport *attach_rport, u16 event_type,
+			   u32 desc_len, u32 fixed_len, u32 pname_count,
+			   __be64 *pname_list,
+			   void (*stats_update)(u16 event_type,
+						struct fc_fpin_stats *stats))
+{
+	u32 i, max_count;
+	struct fc_rport *rport;
+	u64 wwpn;
+
+	if (desc_len < fixed_len)
+		max_count = 0;
+	else
+		max_count = (desc_len - fixed_len) / sizeof(pname_list[0]);
+	pname_count = min_t(u32, pname_count, max_count);
+
+	for (i = 0; i < pname_count; i++) {
+		wwpn = be64_to_cpu(pname_list[i]);
+		rport = fc_find_rport_by_wwpn(shost, wwpn);
+		if (rport &&
+		    (rport->roles & FC_PORT_ROLE_FCP_TARGET ||
+		     rport->roles & FC_PORT_ROLE_NVME_TARGET)) {
+			if (rport == attach_rport)
+				continue;
+			stats_update(event_type, &rport->fpin_stats);
+		}
+	}
+}
+
 /*
  * fc_fpin_li_stats_update - routine to update Link Integrity
  * event statistics.
@@ -747,13 +778,11 @@ fc_cn_stats_update(u16 event_type, struct fc_fpin_stats *stats)
 static void
 fc_fpin_li_stats_update(struct Scsi_Host *shost, struct fc_tlv_desc *tlv)
 {
-	u8 i;
 	struct fc_rport *rport = NULL;
 	struct fc_rport *attach_rport = NULL;
 	struct fc_host_attrs *fc_host = shost_to_fc_host(shost);
 	struct fc_fn_li_desc *li_desc = (struct fc_fn_li_desc *)tlv;
 	u16 event_type = be16_to_cpu(li_desc->event_type);
-	u64 wwpn;
 
 	rport = fc_find_rport_by_wwpn(shost,
 				      be64_to_cpu(li_desc->attached_wwpn));
@@ -764,22 +793,11 @@ fc_fpin_li_stats_update(struct Scsi_Host *shost, struct fc_tlv_desc *tlv)
 		fc_li_stats_update(event_type, &attach_rport->fpin_stats);
 	}
 
-	if (be32_to_cpu(li_desc->pname_count) > 0) {
-		for (i = 0;
-		    i < be32_to_cpu(li_desc->pname_count);
-		    i++) {
-			wwpn = be64_to_cpu(li_desc->pname_list[i]);
-			rport = fc_find_rport_by_wwpn(shost, wwpn);
-			if (rport &&
-			    (rport->roles & FC_PORT_ROLE_FCP_TARGET ||
-			    rport->roles & FC_PORT_ROLE_NVME_TARGET)) {
-				if (rport == attach_rport)
-					continue;
-				fc_li_stats_update(event_type,
-						   &rport->fpin_stats);
-			}
-		}
-	}
+	fc_fpin_pname_stats_update(shost, attach_rport, event_type,
+				   be32_to_cpu(li_desc->desc_len),
+				   FC_TLV_DESC_LENGTH_FROM_SZ(*li_desc),
+				   be32_to_cpu(li_desc->pname_count),
+				   li_desc->pname_list, fc_li_stats_update);
 
 	if (fc_host->port_name == be64_to_cpu(li_desc->attached_wwpn))
 		fc_li_stats_update(event_type, &fc_host->fpin_stats);
@@ -827,13 +845,11 @@ static void
 fc_fpin_peer_congn_stats_update(struct Scsi_Host *shost,
 				struct fc_tlv_desc *tlv)
 {
-	u8 i;
 	struct fc_rport *rport = NULL;
 	struct fc_rport *attach_rport = NULL;
 	struct fc_fn_peer_congn_desc *pc_desc =
 	    (struct fc_fn_peer_congn_desc *)tlv;
 	u16 event_type = be16_to_cpu(pc_desc->event_type);
-	u64 wwpn;
 
 	rport = fc_find_rport_by_wwpn(shost,
 				      be64_to_cpu(pc_desc->attached_wwpn));
@@ -844,22 +860,11 @@ fc_fpin_peer_congn_stats_update(struct Scsi_Host *shost,
 		fc_cn_stats_update(event_type, &attach_rport->fpin_stats);
 	}
 
-	if (be32_to_cpu(pc_desc->pname_count) > 0) {
-		for (i = 0;
-		    i < be32_to_cpu(pc_desc->pname_count);
-		    i++) {
-			wwpn = be64_to_cpu(pc_desc->pname_list[i]);
-			rport = fc_find_rport_by_wwpn(shost, wwpn);
-			if (rport &&
-			    (rport->roles & FC_PORT_ROLE_FCP_TARGET ||
-			     rport->roles & FC_PORT_ROLE_NVME_TARGET)) {
-				if (rport == attach_rport)
-					continue;
-				fc_cn_stats_update(event_type,
-						   &rport->fpin_stats);
-			}
-		}
-	}
+	fc_fpin_pname_stats_update(shost, attach_rport, event_type,
+				   be32_to_cpu(pc_desc->desc_len),
+				   FC_TLV_DESC_LENGTH_FROM_SZ(*pc_desc),
+				   be32_to_cpu(pc_desc->pname_count),
+				   pc_desc->pname_list, fc_cn_stats_update);
 }
 
 /*
-- 
2.53.0

