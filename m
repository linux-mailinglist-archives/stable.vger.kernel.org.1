Return-Path: <stable+bounces-264970-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Rj/bBkqDMWoxlQUAu9opvQ
	(envelope-from <stable+bounces-264970-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:09:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1EA692CA1
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:09:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=P4ng96tC;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264970-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-264970-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C379E301E1BF
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F243435DA6A;
	Tue, 16 Jun 2026 16:54:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB26F4502F;
	Tue, 16 Jun 2026 16:54:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628850; cv=none; b=KGHjfjVOIIixmlkk0+7WWVdl1XrjketF7wzQmpD6AhJqwmBXfHkAlZr4AZWATp8zkIorhDCLctFkDWoRvPebwJbtm9RDMXgZkfHhDsK7FkXVfgE28ea6XicuA0yDgARE+iFc4ea9vwH0E0nxDW3PrZCoDfCdbXJpKTzWCcd3IRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628850; c=relaxed/simple;
	bh=VmiuldhHAgDXlpAqRYdiTEDaxTPJ+cOkz1HdRS+AA4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGtkWtQleyyKuasV4xo/wY7BNRZAjc+X5V8tM5vodJ48L/pwN8nWK4dH7+nEALqcKUv01e+pRS1XLmSZJCsuo5qbshDdFMuKkyLvgQlxbPlJ9rwR0240duOV/71N8/U44sJ+Ag/gyi/OY8QXNKFllM6KQyB0xH1cFjx7yzNP2ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P4ng96tC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF29B1F000E9;
	Tue, 16 Jun 2026 16:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781628849;
	bh=JIo2NFd0cSUYgEyXZ15/CpHe/0zrYQ8r0NHC3SaEjho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P4ng96tCToKXNmLBQwDna9bGNdJzCf/j78vpGsFeSLDWXjgQ1zgXgPOtXrhie8zS7
	 76AHon9TiFoiOsjmBCfIKQ1yt8pIQZ1Ew2DxEc6M+PKXj3kGOXjVJhFVQnV9RXJliE
	 HBUzMB4m7KWBx50VcYWZYs2T2UlHHsaWy9L2a0O8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.6 173/452] scsi: scsi_transport_fc: Widen FPIN pname walker counter to u32
Date: Tue, 16 Jun 2026 20:26:40 +0530
Message-ID: <20260616145126.977819302@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,lst.de,oracle.com];
	TAGGED_FROM(0.00)[bounces-264970-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:michael.bommarito@gmail.com,m:hch@lst.de,m:john.g.garry@oracle.com,m:martin.petersen@oracle.com,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oracle.com:email,lst.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D1EA692CA1

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Bommarito <michael.bommarito@gmail.com>

commit a9a39233ec1fc9f97ea1340a4d09bb7ec2be5153 upstream.

An adjacent Fibre Channel fabric actor that can deliver an FPIN ELS
frame to an lpfc or qla2xxx Linux initiator can trigger a non-return in
the generic FC transport. This is not a local userspace or IP network
path; the attacker must be able to inject fabric traffic, for example as
a compromised switch or fabric controller, or as a same-zone N_Port on a
fabric that permits source spoofing.

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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Link: https://patch.msgid.link/20260520133015.1018937-1-michael.bommarito@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/scsi_transport_fc.c |   77 ++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 36 deletions(-)

--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -747,6 +747,37 @@ fc_cn_stats_update(u16 event_type, struc
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
+	u32 i;
+	struct fc_rport *rport;
+	u64 wwpn;
+
+	if (desc_len < fixed_len)
+		pname_count = 0;
+	else
+		pname_count = min(pname_count, (desc_len - fixed_len) /
+				   sizeof(pname_list[0]));
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
@@ -757,13 +788,11 @@ fc_cn_stats_update(u16 event_type, struc
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
@@ -774,22 +803,11 @@ fc_fpin_li_stats_update(struct Scsi_Host
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
@@ -837,13 +855,11 @@ static void
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
@@ -854,22 +870,11 @@ fc_fpin_peer_congn_stats_update(struct S
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



