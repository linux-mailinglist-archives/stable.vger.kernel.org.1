Return-Path: <stable+bounces-255600-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOpMBrOiGGqblggAu9opvQ
	(envelope-from <stable+bounces-255600-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:16:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A1A5F8404
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 19C34304A671
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716B52F549F;
	Thu, 28 May 2026 20:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A9/qh0eW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C03E2C11F9;
	Thu, 28 May 2026 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999368; cv=none; b=Dz3qmOmMgwXwuF+2lmfzvUnHRSdBGLen7zaInhERkMOLpBes41SI48WaDn4wpfWL4p/DbcH7NW1utpzc170wuXEz0KEpfNecexssy83UKFfHf5y8PbgAVFevhBQeQvzMQSsuHWP1EElWsQw/EKNkbskawoWJl/rb1yBPk02hX1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999368; c=relaxed/simple;
	bh=vZVOTfRXKgVXAfd85SaNS6e4lCbRiIVL7/wVc4ktUQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZoBbWwsR1uuX39368RBAE+c926rhg6RfnxTPZrM83IQArjPTcVOniiKl/PGQz4HM4ZFsh+jEL5oHPqaXxFJ8gRV3hyeJXFGgH+tGh+hD7E2hv7OFHx88wuyV3ZOMT67FFcyqsbCqUMzrZOpWGoW+hzAStERRP9IwjleG9v9WoSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A9/qh0eW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507EF1F00A3A;
	Thu, 28 May 2026 20:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999366;
	bh=kb+9hVM8rDQmVralettpWG4oCoQqJZ0oRAxnZeNENoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A9/qh0eWEMirbuZ/fMn8puS6SoI6PPJZWtWG3akUrlnW7N33rXrXh5hiLJ3zrtF2a
	 JGfraWTjqhqnMiouVJRAhEKPUxFugxY42tymwVyR4RtYjOuYfN0MSt1kJ/Pxt2I+u5
	 j3LKqZePO1zligBcIvIBfMFWN4Q7/kdPcL1xKW4A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeremy Erazo <mendozayt13@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.18 034/377] smb: client: use data_len for SMB2 READ encrypted folioq copy
Date: Thu, 28 May 2026 21:44:32 +0200
Message-ID: <20260528194639.365808844@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255600-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,redhat.com,microsoft.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 37A1A5F8404
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeremy Erazo <mendozayt13@gmail.com>

commit d4d76c9ee1997cc8c977a63f6c43551c253c1066 upstream.

In handle_read_data() the encrypted/folioq branch
(buf_len <= data_offset, reached via receive_encrypted_read for
transform PDUs > CIFSMaxBufSize + MAX_HEADER_SIZE) copies the READ
payload using buffer_len rather than data_len:

	rdata->result = cifs_copy_folioq_to_iter(buffer, buffer_len,
						 cur_off,
						 &rdata->subreq.io_iter);
	...
	rdata->got_bytes = buffer_len;

buffer_len comes from the SMB3 transform header OriginalMessageSize
field (OriginalMessageSize - read_rsp_size); it represents the size
of the decrypted message after the SMB2 header.  data_len comes from
the SMB2 READ response DataLength field; it represents the actual
READ payload size and may be smaller than buffer_len when the
decrypted message contains padding or other trailing bytes after the
READ payload.  The existing check `data_len > buffer_len - pad_len`
only enforces an upper bound, so a server that emits
OriginalMessageSize larger than read_rsp_size + pad_len + data_len
passes the check and the kernel copies buffer_len bytes per response,
ignoring the server-asserted DataLength.

Two observable failures with a crafted server (DataLength=4,
buffer_len=20000):

  - the kernel returns 20000 bytes per sub-request to userspace and
    sets got_bytes = buffer_len, even though the response claimed
    only 4 bytes of payload;

  - on a partial netfs sub-request whose iterator is sized to
    data_len, the over-large copy_folio_to_iter() short-reads,
    cifs_copy_folioq_to_iter() returns -EIO via the n != len path,
    and the entire netfs read collapses to -EIO even though the
    leading sub-requests succeeded.

Use data_len for the copy length and for got_bytes so the kernel
honours the server-asserted READ payload size.  For well-formed
servers (where buffer_len == pad_len + data_len) the change is
behaviour-equivalent.

Cc: stable@vger.kernel.org
Signed-off-by: Jeremy Erazo <mendozayt13@gmail.com>
Acked-by: David Howells <dhowells@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/smb2ops.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4842,7 +4842,7 @@ handle_read_data(struct TCP_Server_Info
 		}
 
 		/* Copy the data to the output I/O iterator. */
-		rdata->result = cifs_copy_folioq_to_iter(buffer, buffer_len,
+		rdata->result = cifs_copy_folioq_to_iter(buffer, data_len,
 							 cur_off, &rdata->subreq.io_iter);
 		if (rdata->result != 0) {
 			if (is_offloaded)
@@ -4851,7 +4851,7 @@ handle_read_data(struct TCP_Server_Info
 				dequeue_mid(mid, rdata->result);
 			return 0;
 		}
-		rdata->got_bytes = buffer_len;
+		rdata->got_bytes = data_len;
 
 	} else if (buf_len >= data_offset + data_len) {
 		/* read response payload is in buf */



