Return-Path: <stable+bounces-258097-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLV2Ij4kG2rO/QgAu9opvQ
	(envelope-from <stable+bounces-258097-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:54:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B6E6109C4
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F340D301CD9E
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAD93AEB5C;
	Sat, 30 May 2026 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mp69TBpz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7B83B1EC0;
	Sat, 30 May 2026 17:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780163206; cv=none; b=VNIcrsqI2cqJiKcvOZOWlvZIVg1D3YqXnvlPLx8rml4xc1pEhCxXIVXwwvzgreb1lqizDarwrLkCF+Q12N+w0MJt8oGib2D7krmkFQz3ZyRfIv3giFasKb7QFhIMDEWssDVQ4GZLX7mTwQpgmwDSqolMmuJQEXLniAXs6UuJts8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780163206; c=relaxed/simple;
	bh=l9gIQo2h2eFCxjsZQdQE8iOeO3klFaAcSC8rUi8FenQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CcXh5QJF+CZCgBAGBMU9C9pQqtxItmgzobIYAnvapy4yotKA8q7Rm093Dn6pBHKzbkSLSPi/pQ19PN6z1kCsmkB8oCxDF0umSZbnDM0j3uURLqYIRui/qhSEqfeSpXfkP+Ej6peAkGLrA9aU3BMpIIFEav0691E7DUgJ4qQD0O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mp69TBpz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D80D1F00893;
	Sat, 30 May 2026 17:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780163205;
	bh=gsHyBu+U1LFB9EyGEdacvZBaNNBIHXdGMoijWoZgIkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mp69TBpzJYbegC+g0x5CK4EoH1MDLp1AnvriHGSBUKRFVy98AReL5gLoweHJJMhjA
	 ftWNG2Hnyxu84SG9O8HjcVXeteEUBoBuOfJpEXoGnNK6hiwi4n986a9DbiehH83hnk
	 LlL/x4+t/MQxYeSjAZwoPvsQM0FhQyxNevtgg6NA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuhao Jiang <danisjiang@gmail.com>,
	Tyllis Xu <LivelyCarpet87@gmail.com>
Subject: [PATCH 5.15 188/776] ibmasm: fix OOB reads in command_file_write due to missing size checks
Date: Sat, 30 May 2026 17:58:22 +0200
Message-ID: <20260530160245.359107578@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258097-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 41B6E6109C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tyllis Xu <livelycarpet87@gmail.com>

commit 0eb09f737428e482a32a2e31e5e223f2b35a71d3 upstream.

The command_file_write() handler allocates a kernel buffer of exactly
count bytes and copies user data into it, but does not validate the
buffer against the dot command protocol before passing it to
get_dot_command_size() and get_dot_command_timeout().

Since both the allocation size (count) and the header fields (command_size,
data_size) are independently user-controlled, an attacker can cause
get_dot_command_size() to return a value exceeding the allocation,
triggering OOB reads in get_dot_command_timeout() and an out-of-bounds
memcpy_toio() that leaks kernel heap memory to the service processor.

Fix with two guards: reject writes smaller than sizeof(struct
dot_command_header) before allocation, then after copying user data
reject commands where the buffer is smaller than the total size declared
by the header (sizeof(header) + command_size + data_size). This ensures
all subsequent header and payload field accesses stay within the buffer.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Tyllis Xu <LivelyCarpet87@gmail.com>
Link: https://patch.msgid.link/20260314165355.548119-1-LivelyCarpet87@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/ibmasm/ibmasmfs.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/misc/ibmasm/ibmasmfs.c
+++ b/drivers/misc/ibmasm/ibmasmfs.c
@@ -303,6 +303,8 @@ static ssize_t command_file_write(struct
 		return -EINVAL;
 	if (count == 0 || count > IBMASM_CMD_MAX_BUFFER_SIZE)
 		return 0;
+	if (count < sizeof(struct dot_command_header))
+		return -EINVAL;
 	if (*offset != 0)
 		return 0;
 
@@ -319,6 +321,11 @@ static ssize_t command_file_write(struct
 		return -EFAULT;
 	}
 
+	if (count < get_dot_command_size(cmd->buffer)) {
+		command_put(cmd);
+		return -EINVAL;
+	}
+
 	spin_lock_irqsave(&command_data->sp->lock, flags);
 	if (command_data->command) {
 		spin_unlock_irqrestore(&command_data->sp->lock, flags);



