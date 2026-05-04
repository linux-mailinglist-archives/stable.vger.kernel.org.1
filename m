Return-Path: <stable+bounces-243043-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IO81C4Cl+GnQxQIAu9opvQ
	(envelope-from <stable+bounces-243043-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 15:56:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A61574BE244
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 15:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55EED30309B0
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 13:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920F73DEADB;
	Mon,  4 May 2026 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fu9GS9NV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83913DE45F;
	Mon,  4 May 2026 13:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777902870; cv=none; b=Sxuez+do6Z+wszu88ClhHtkye5uO9knz677PElAUZu0KvwSVOfAZmVbvS7db/PDNt2XPIzyYpo6iJhi96fvtqQ05et80HoW/i7k+ZqOPUKhi83BxvWjPJhQxMao5aG3IzBnTbv8MaTp4RIV16WlvxR/lMwSn2lprzaoHvOsMoRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777902870; c=relaxed/simple;
	bh=H7345oC4D9PeCCn4X8/gnsJthD51BcqZcgvDSnssZ9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I40L+Mkmk5Ck90SsFcjpr/3RODjV+H4e7/KHjZz611DviYQrjUwgABT6J4nLdrbEmIoYWdBQVZEXC4NlIhk2CCH1q14GQAR193llLS/Nf6D5zMHRB1PIe+HHQhrTtqf5fh+dTzeRlkgpF2mKmDjCM/gYM+If5LSJJBbEcnbXpQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fu9GS9NV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2415BC2BCC4;
	Mon,  4 May 2026 13:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777902870;
	bh=H7345oC4D9PeCCn4X8/gnsJthD51BcqZcgvDSnssZ9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fu9GS9NVEjWOVumbsLC78zuIIHJPl2uas2mSlE7S7V/gRb5KsyKwmd48r/t6qHKWk
	 lrZr/huLwEIkaIjahiGlqn5TEZMWd/svrx+OVXp/TmRUM1b2tOtuW1htBVHxWvnsTr
	 OMpJ0Th/z+NTs7U9g/7dSy6rxYt8Kic6NcCNfmLQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuhao Jiang <danisjiang@gmail.com>,
	Tyllis Xu <LivelyCarpet87@gmail.com>
Subject: [PATCH 7.0 015/307] ibmasm: fix heap over-read in ibmasm_send_i2o_message()
Date: Mon,  4 May 2026 15:48:20 +0200
Message-ID: <20260504135143.402620601@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: A61574BE244
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243043-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tyllis Xu <livelycarpet87@gmail.com>

commit 9aad71144fa3682cca3837a06c8623016790e7ec upstream.

The ibmasm_send_i2o_message() function uses get_dot_command_size() to
compute the byte count for memcpy_toio(), but this value is derived from
user-controlled fields in the dot_command_header (command_size: u8,
data_size: u16) and is never validated against the actual allocation size.
A root user can write a small buffer with inflated header fields, causing
memcpy_toio() to read up to ~65 KB past the end of the allocation into
adjacent kernel heap, which is then forwarded to the service processor
over MMIO.

Silently clamping the copy size is not sufficient: if the header fields
claim a larger size than the buffer, the SP receives a dot command whose
own header is inconsistent with the I2O message length, which can cause
the SP to desynchronize. Reject such commands outright by returning
failure.

Validate command_size before calling get_mfa_inbound() to avoid leaking
an I2O message frame: reading INBOUND_QUEUE_PORT dequeues a hardware
frame from the controller's free pool, and returning without a
corresponding set_mfa_inbound() call would permanently exhaust it.

Additionally, clamp command_size to I2O_COMMAND_SIZE before the
memcpy_toio() so the MMIO write stays within the I2O message frame,
consistent with the clamping already performed by outgoing_message_size()
for the header field.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Tyllis Xu <LivelyCarpet87@gmail.com>
Link: https://patch.msgid.link/20260314165805.548293-1-LivelyCarpet87@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/ibmasm/lowlevel.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/misc/ibmasm/lowlevel.c
+++ b/drivers/misc/ibmasm/lowlevel.c
@@ -19,17 +19,21 @@ static struct i2o_header header = I2O_HE
 int ibmasm_send_i2o_message(struct service_processor *sp)
 {
 	u32 mfa;
-	unsigned int command_size;
+	size_t command_size;
 	struct i2o_message *message;
 	struct command *command = sp->current_command;
 
+	command_size = get_dot_command_size(command->buffer);
+	if (command_size > command->buffer_size)
+		return 1;
+	if (command_size > I2O_COMMAND_SIZE)
+		command_size = I2O_COMMAND_SIZE;
+
 	mfa = get_mfa_inbound(sp->base_address);
 	if (!mfa)
 		return 1;
 
-	command_size = get_dot_command_size(command->buffer);
-	header.message_size = outgoing_message_size(command_size);
-
+	header.message_size = outgoing_message_size((unsigned int)command_size);
 	message = get_i2o_message(sp->base_address, mfa);
 
 	memcpy_toio(&message->header, &header, sizeof(struct i2o_header));



