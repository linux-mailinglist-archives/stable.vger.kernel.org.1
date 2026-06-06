Return-Path: <stable+bounces-260877-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id McH7J64TJGrm2gEAu9opvQ
	(envelope-from <stable+bounces-260877-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 14:33:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A21364D6D3
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 14:33:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=K+me53JX;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260877-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260877-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94039301C5B7
	for <lists+stable@lfdr.de>; Sat,  6 Jun 2026 12:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B5A353EF3;
	Sat,  6 Jun 2026 12:32:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4988B1B4F09
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 12:32:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780749130; cv=none; b=IIniBVRW3eL793gtTtL4Zzo58k+TQymtycJr7aWbi1VxNXsdrpg3ZG+iQNdKWCku80UmtF+gZqpxATY0xGnboQtHWPCNVHi3zMaF5cT52pVob9zwKDCwW7bF8KtP0mrR7z3h+t9PvI8lAhcKHngxGtDhB4cQyQyOx2TbrdbRaOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780749130; c=relaxed/simple;
	bh=t3u9lZ6x6bFQPkmXTU3rk18aiVPP2XsFcwTVgIhe894=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rgPFqrkGClNb29CRe/YvPKqc5fIjoil+HlcYlbGmkYLRwqK9zZGJX5WRrUft9qUOXjvvkMobGBgLW+8QGdDGRjvXEqJIWQuCDBOtdqKWexytZGM+y3zGozxtPL0vkWLvGFmoWD/Ozscf/+44ICuRNsPdT+YviKajkqmxHoPSdiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+me53JX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE7C1F00893;
	Sat,  6 Jun 2026 12:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780749128;
	bh=MrMoUG9Lsyix6vM3mL3HhWSUoiar6Z7ovItPxm6Nd6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K+me53JXQdARUf+FJu5JjMIkxwPC9Ckkig9t24/AZd/K1iZiTy0w8ihkXVELbtJBX
	 zb0eFh587AWs9HmC5NpgukoyoOpseFGLw051N7vafje1RoNE9Wxo8b0wOvauWEEjXe
	 slA2kbk3AokrwiRPYP6cOXRsp7NXTiGp/yCRpeSkwWo1up6QwrVc1vxbuvbz8BIUCF
	 BdYdsRffdFKj6RjVLEsNtuh06F0pVxEF+R1A90VWDEYi/ZVyaf/az12a/E/nIbL2ZU
	 R4OQH6ipc5gxKabz9dXoxMt+rIbe9OEb/jFx7kBE5QQKtnbH/BGXH+kXtaYrfUFFRj
	 ZaSeCY6P7sgyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] scsi: target: iscsi: Fix CRC overread and double-free in iscsit_handle_text_cmd()
Date: Sat,  6 Jun 2026 08:32:06 -0400
Message-ID: <20260606123206.2861187-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060400-transform-unfunded-ed00@gregkh>
References: <2026060400-transform-unfunded-ed00@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260877-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:michael.bommarito@gmail.com,m:john.g.garry@oracle.com,m:martin.petersen@oracle.com,m:sashal@kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A21364D6D3

From: Michael Bommarito <michael.bommarito@gmail.com>

[ Upstream commit 778c2ab142c625a8a8afa570e0f9b7873f445d99 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/iscsi/iscsi_target.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index 04d40e76772b30..0e16a29e8ef67e 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -2336,8 +2336,9 @@ iscsit_handle_text_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 
 		if (conn->conn_ops->DataDigest) {
 			iscsit_do_crypto_hash_buf(conn->conn_rx_hash,
-						  text_in, rx_size, 0, NULL,
-						  &data_crc);
+						  text_in,
+						  ALIGN(payload_length, 4),
+						  0, NULL, &data_crc);
 
 			if (checksum != data_crc) {
 				pr_err("Text data CRC32C DataDigest"
@@ -2357,6 +2358,7 @@ iscsit_handle_text_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 					" Command CmdSN: 0x%08x due to"
 					" DataCRC error.\n", hdr->cmdsn);
 					kfree(text_in);
+					cmd->text_in_ptr = NULL;
 					return 0;
 				}
 			} else {
-- 
2.53.0


