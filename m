Return-Path: <stable+bounces-212191-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMKpKBsuemnd3gEAu9opvQ
	(envelope-from <stable+bounces-212191-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:41:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 022DCA4311
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 769B6303D34F
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899432D6E63;
	Wed, 28 Jan 2026 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jyd4WrxH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270742D9494;
	Wed, 28 Jan 2026 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614693; cv=none; b=NjDR9iz9a0bu+5ltGqzJ8c3ZGFlAEXG/BfBJyky/B2xQUYx7HY87waECHNeui/5sd/W4iN7CH63pAbEbWRtg93n6oNSfl0X3Jzi3MvnwCCmIF1a3YKtbggUDe8Jjets7+eD1jSpvfq4lKWzoXMR+2wNr7IffYrQq2qbBvvan1X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614693; c=relaxed/simple;
	bh=hH6a+ta1dM3/8AJrH4sXXtoIMPYaNKn2yCVursoiL88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OexEe6+VxOZ2VFoi9KBx6NB2WFFBriTPa9Jq05eLxiOglI0hp4Qx0NW4hSUpKkvcmm5GjkdoYkhxmgQKS2cpA2ft7TLfzgRBjBBefNmANahzBc164ObmFNayI+PTTcjKk9tmxO6a/nBFK6GOa7KkO0SeEdlNavlBUYXDMxafJ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jyd4WrxH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4B4C4CEF1;
	Wed, 28 Jan 2026 15:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614693;
	bh=hH6a+ta1dM3/8AJrH4sXXtoIMPYaNKn2yCVursoiL88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jyd4WrxH81vBgukSQ611fC9Od/G4mBsbuiL/2cyF6R1pausKQVIEW8AqoOmL3hTSr
	 ewXvotuS0cf3SL+nQXhZ+BihUfSwi7X0Ykh4mn90ZgbIsFBFt15YIzEaiNeGaxkRFo
	 UVbXyq47EisnDEiPaB2L+xD4ufkViWGB/bVIsINI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 180/254] vsock/test: fix seqpacket message bounds test
Date: Wed, 28 Jan 2026 16:22:36 +0100
Message-ID: <20260128145351.281190185@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
References: <20260128145344.698118637@linuxfoundation.org>
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212191-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 022DCA4311
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefano Garzarella <sgarzare@redhat.com>

[ Upstream commit 0a98de80136968bab7db37b16282b37f044694d3 ]

The test requires the sender (client) to send all messages before waking
up the receiver (server).
Since virtio-vsock had a bug and did not respect the size of the TX
buffer, this test worked, but now that we are going to fix the bug, the
test hangs because the sender would fill the TX buffer before waking up
the receiver.

Set the buffer size in the sender (client) as well, as we already do for
the receiver (server).

Fixes: 5c338112e48a ("test/vsock: rework message bounds test")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Link: https://patch.msgid.link/20260121093628.9941-3-sgarzare@redhat.com
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/vsock/vsock_test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 5dc7767039f6f..793d688cd4da6 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -396,6 +396,7 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
 
 static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
 {
+	unsigned long long sock_buf_size;
 	unsigned long curr_hash;
 	size_t max_msg_size;
 	int page_size;
@@ -408,6 +409,16 @@ static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
 		exit(EXIT_FAILURE);
 	}
 
+	sock_buf_size = SOCK_BUF_SIZE;
+
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
+			     sock_buf_size,
+			     "setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
+
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
+			     sock_buf_size,
+			     "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
+
 	/* Wait, until receiver sets buffer size. */
 	control_expectln("SRVREADY");
 
-- 
2.51.0




