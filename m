Return-Path: <stable+bounces-260439-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vPIlO5hYIWo2EgEAu9opvQ
	(envelope-from <stable+bounces-260439-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 12:51:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD0F63F344
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 12:51:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=I3tF+r0q;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260439-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-260439-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D9E39300F5D2
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 10:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70F2403EBA;
	Thu,  4 Jun 2026 10:51:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E76E405C42
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 10:51:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570262; cv=none; b=XGn6NPjlc2IiSAAveW60up0Xgqm3slPcE6eh5dmpQVtoe/SN/XRDsHHBIl74rak6lf3Tw/Wx+IOvS8R3nPjsiqLzelrnHGhHCFDx8GUhF75MH66jzGy5nANTuB0yF2vG/wHkF1T+oDl4MqyL3mh88VVSdziEmfORvVDeFuhxXh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570262; c=relaxed/simple;
	bh=XlPGCh9VvMbHrblmnsyTTIvaa9g9K/whlIaxgbl0EaI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OxkX9TIn9Qr4heXaDbf7XYy1QPL5tIgLUXPc0gccHzEQAtiWNnF8Jvem0wnnAzDVKo7Pv4G2CeTXXJ61suFbeQKh54p2QNh2b9b/qRppijBKy+vFJTns6rfhBDPHn5a6h/GEk48GhE/4wBr0XKIk961/8lf8XiyWOs318XsF63o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I3tF+r0q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCED51F00893;
	Thu,  4 Jun 2026 10:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780570261;
	bh=5Q7M9QJD9QFnmLcq6MUMP0izcDL39ae36KXmi4jw3AY=;
	h=Subject:To:Cc:From:Date;
	b=I3tF+r0qrH3uC5YhI0hejG98RfsquFqz9VSfNH6DK59Q5qqmEBaWa/UQtm+qj/0sJ
	 x7LckAl/cmL3RfWHl9JHtel8sC8FoZ9877V1Bcl84DR9niVs7Mwrcq9dvG/qR7NoCv
	 u8Y2nEpWfK+uTioXpiW4U+VOnoqLRLauvQ7OFQxk=
Subject: FAILED: patch "[PATCH] scsi: target: iscsi: Fix CRC overread and double-free in" failed to apply to 5.10-stable tree
To: michael.bommarito@gmail.com,john.g.garry@oracle.com,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 12:49:55 +0200
Message-ID: <2026060455-reseller-handwoven-ef39@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260439-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:john.g.garry@oracle.com,m:martin.petersen@oracle.com,m:stable@vger.kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8DD0F63F344


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 778c2ab142c625a8a8afa570e0f9b7873f445d99
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060455-reseller-handwoven-ef39@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 778c2ab142c625a8a8afa570e0f9b7873f445d99 Mon Sep 17 00:00:00 2001
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Sat, 18 Apr 2026 11:49:27 -0400
Subject: [PATCH] scsi: target: iscsi: Fix CRC overread and double-free in
 iscsit_handle_text_cmd()

Two latent bugs in the Text-phase handler, both present since the
original LIO integration in commit e48354ce078c ("iscsi-target: Add
iSCSI fabric support for target v4.1"):

1) DataDigest CRC buffer overread (4 bytes past text_in).

   text_in is kzalloc()'d at ALIGN(payload_length, 4).  rx_size is then
   incremented by ISCSI_CRC_LEN to make room for the received DataDigest
   in the iovec, but the same (now-bumped) rx_size is passed as the
   buffer length to iscsit_crc_buf():

       if (conn->conn_ops->DataDigest) {
               ...
               rx_size += ISCSI_CRC_LEN;
       }
       ...
       if (conn->conn_ops->DataDigest) {
               data_crc = iscsit_crc_buf(text_in, rx_size, 0, NULL);

   iscsit_crc_buf() walks rx_size bytes of text_in with crc32c(), so
   when DataDigest is negotiated it reads 4 bytes past the end of the
   text_in allocation.  KASAN reproduces this directly on the unpatched
   mainline tree as slab-out-of-bounds in crc32c() called from the Text
   PDU path.  The OOB bytes feed crc32c() and are then compared against
   the initiator-supplied checksum, so the value does not flow back to
   the attacker, but the kernel does read past the buffer on every Text
   PDU with DataDigest=CRC32C.

   Fix by passing the actual padded payload length
   (ALIGN(payload_length, 4)) that was used for the kzalloc().

2) Stale cmd->text_in_ptr re-free (double-free) on ERL>0 bad DataDigest
   drop.

   On DataDigest mismatch with ErrorRecoveryLevel > 0 the handler
   silently drops the PDU and lets the initiator plug the CmdSN gap:

               kfree(text_in);
               return 0;

   cmd->text_in_ptr still points at the freed buffer.  The next Text
   Request on the same ITT re-enters iscsit_setup_text_cmd(), which
   unconditionally does

       kfree(cmd->text_in_ptr);
       cmd->text_in_ptr = NULL;

   freeing the same pointer a second time.  Session teardown via
   iscsit_release_cmd() has the same shape and hits the same double-free
   if the connection is dropped before a second Text Request arrives.

   On an unmodified mainline tree the bug-1 CRC overread fires first on
   the initial valid Text Request and perturbs the subsequent state, so
   #4 was isolated by building a kernel with only the bug-1 hunk of this
   patch applied plus temporary printk() observability around the three
   relevant kfree() sites.  The observability prints are not part of
   this patch.  On that build, a three-PDU Text Request sequence after
   login produces two back-to-back splats:

       BUG: KASAN: double-free in iscsit_setup_text_cmd+0x??
       BUG: KASAN: double-free in iscsit_release_cmd+0x??

   showing the same pointer freed in the ERL>0 drop path and again in
   iscsit_setup_text_cmd() (next Text Request on the same ITT) and once
   more in iscsit_release_cmd() (session teardown).  On distro kernels
   with CONFIG_SLAB_FREELIST_HARDENED=y (default) the double-free
   becomes a remote kernel BUG(); on non-hardened kernels it corrupts
   the slab freelist.

   Fix by clearing cmd->text_in_ptr after the kfree() in the ERL>0 drop
   path.  With both hunks applied #4 is directly observable on the stock
   tree without observability printks; fixing bug-1 alone would mask #4
   less, not more, so the hunks are submitted together.

Both fixes are one-liners.  The Text PDU state machine is unchanged and
the wire protocol is unaffected.

Fixes: e48354ce078c ("iscsi-target: Add iSCSI fabric support for target v4.1")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Tested-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index cb832fd523af..62ada3a52210 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -2295,7 +2295,9 @@ iscsit_handle_text_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 			goto reject;
 
 		if (conn->conn_ops->DataDigest) {
-			data_crc = iscsit_crc_buf(text_in, rx_size, 0, NULL);
+			data_crc = iscsit_crc_buf(text_in,
+						  ALIGN(payload_length, 4),
+						  0, NULL);
 			if (checksum != data_crc) {
 				pr_err("Text data CRC32C DataDigest"
 					" 0x%08x does not match computed"
@@ -2314,6 +2316,7 @@ iscsit_handle_text_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 					" Command CmdSN: 0x%08x due to"
 					" DataCRC error.\n", hdr->cmdsn);
 					kfree(text_in);
+					cmd->text_in_ptr = NULL;
 					return 0;
 				}
 			} else {


