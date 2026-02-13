Return-Path: <stable+bounces-216110-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNuQA1Asj2kPKwEAu9opvQ
	(envelope-from <stable+bounces-216110-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:51:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A89C61368A6
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 12420300833F
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 13:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460D335FF62;
	Fri, 13 Feb 2026 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wy4Ea8rD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0891534F24E;
	Fri, 13 Feb 2026 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770990668; cv=none; b=GRnq1t8TlWu2ogUC3oE1eBHepHLgUexYkptRusOWguTfRzrJW6KS5B18u9eAs3LTV6bxryDuQgIt41BdufQf/PwItSegErqOD5KeSLCRE029dyDUH7aXw6cLyMZbtGSkJ7UPDaL2R9z2oOgj+UDyLv4oioRaLl/6xvSI/M3nPw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770990668; c=relaxed/simple;
	bh=Wsvao3NGvNeZiMrg+FR+/mopr2seKTXgOpxkx0KMD0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YhzU7EWuxxOVAJlSL0hFQQBi6PzGny0Ifw2zqX70K1M4JYSJw4gzxqqmNL0AU6PzffRyQwKFWRcif2IwwMOKYzcT6UplolEgvVBZmsaIffMP0IIEz0BJtEQVhqKhORZGjZLKcJ66biLgNfRxMPyDI1XM45zFL1d57e0VjmiWd/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wy4Ea8rD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D61C116C6;
	Fri, 13 Feb 2026 13:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770990667;
	bh=Wsvao3NGvNeZiMrg+FR+/mopr2seKTXgOpxkx0KMD0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wy4Ea8rDVMTAKFg7BuAotfcvD4M1f0O63YBCEjYp8mqGCm3TaUzgOmnsmiDD0kv1u
	 AnFg81xIMp7rbBQosH9ft35NBjn2D7E5GArT3LSY9xK97CQQn7BP4x6e+ZF/9oX+tQ
	 hLQvJRB5Tbx+c5ph8R+5ZnOoPcpEGZpxqTZpqpLs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shreyas Deodhar <sdeodhar@marvell.com>,
	Nilesh Javali <njavali@marvell.com>,
	Himanshu Madhani <hmadhani2024@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.19 39/49] scsi: qla2xxx: Allow recovery for tape devices
Date: Fri, 13 Feb 2026 14:47:58 +0100
Message-ID: <20260213134710.151422093@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213134708.713126210@linuxfoundation.org>
References: <20260213134708.713126210@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216110-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,marvell.com,gmail.com,oracle.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,marvell.com:email]
X-Rspamd-Queue-Id: A89C61368A6
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shreyas Deodhar <sdeodhar@marvell.com>

commit b0335ee4fb94832a4ef68774ca7e7b33b473c7a6 upstream.

Tape device doesn't show up after RSCNs.  To fix this, remove tape
device specific checks which allows recovery of tape devices.

Fixes: 44c57f205876 ("scsi: qla2xxx: Changes to support FCP2 Target")
Cc: stable@vger.kernel.org
Signed-off-by: Shreyas Deodhar <sdeodhar@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Reviewed-by: Himanshu Madhani <hmadhani2024@gmail.com>
Link: https://patch.msgid.link/20251210101604.431868-7-njavali@marvell.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_gs.c   |    3 ---
 drivers/scsi/qla2xxx/qla_init.c |    9 ---------
 2 files changed, 12 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -3266,9 +3266,6 @@ login_logout:
 			    atomic_read(&fcport->state) == FCS_ONLINE) ||
 				do_delete) {
 				if (fcport->loop_id != FC_NO_LOOP_ID) {
-					if (fcport->flags & FCF_FCP2_DEVICE)
-						continue;
-
 					ql_log(ql_log_warn, vha, 0x20f0,
 					       "%s %d %8phC post del sess\n",
 					       __func__, __LINE__,
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1859,15 +1859,6 @@ void qla2x00_handle_rscn(scsi_qla_host_t
 	case RSCN_PORT_ADDR:
 		fcport = qla2x00_find_fcport_by_nportid(vha, &ea->id, 1);
 		if (fcport) {
-			if (ql2xfc2target &&
-			    fcport->flags & FCF_FCP2_DEVICE &&
-			    atomic_read(&fcport->state) == FCS_ONLINE) {
-				ql_dbg(ql_dbg_disc, vha, 0x2115,
-				       "Delaying session delete for FCP2 portid=%06x %8phC ",
-					fcport->d_id.b24, fcport->port_name);
-				return;
-			}
-
 			if (vha->hw->flags.edif_enabled && DBELL_ACTIVE(vha)) {
 				/*
 				 * On ipsec start by remote port, Target port



