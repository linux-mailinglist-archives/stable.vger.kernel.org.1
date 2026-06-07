Return-Path: <stable+bounces-261136-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IiGGGwRFJWoQFgIAu9opvQ
	(envelope-from <stable+bounces-261136-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:16:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0468964F760
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:16:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=IA6+dWgJ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261136-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-261136-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B28A3003344
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E0D23392F;
	Sun,  7 Jun 2026 10:16:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09224071DA;
	Sun,  7 Jun 2026 10:16:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827383; cv=none; b=Z9AWvTD24qwDP4Mf5R8oam294APXBHS8B+tovqTnuxyXgKG3/vyWFjdVt4TMoodLLDxONiN78GdAQvFrA6mv/2XiHsvpBlypsxLV1fHgbky1BARg9MjlXKIvWCyKS3skHaqT60dhx/Ud2jT2PKcpuXhwujfA1ybJJOeQjqZ2QoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827383; c=relaxed/simple;
	bh=fhRIfYWgfBWjKMa/fs5+t/iMX/u/a5+PuGt2DYJje7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udetMaBhC2JBq/ipOe36mwWQEM8HTXxR8FbqN0JE4KvPD1XHorEDXm1RFx2nAg/QConNtryP3GN0GnsKEpWWWuinfILn6EHlIpXbQYWb0Kiwu9Q6RwyZmE9mq5FTSx4vK/Y6KUxrQs0z6Btq6YyWwYk+QzcGSK7sci0K3iFx0Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IA6+dWgJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C609E1F00893;
	Sun,  7 Jun 2026 10:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827382;
	bh=vqNZ+lXCRWd/21wKoLternjWv0QdrrItPtmMqqT2Wfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IA6+dWgJDujYCchVaWam7hpJVHKyqQh2qp0UlWDLuru6/MNKGb/KtSoL6q2I2U4u4
	 0kc1fFs20Of69fF6RBOsJuNd4XLw64V4iBYsMw3XCNC4dKSz6iwAT9NQV4RWShoPRY
	 vRN7okNsochJOAcuIQIu6DZflhCqu3x6eU87YldQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@kernel.org>,
	Alistair Francis <alistair.francis@wdc.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 088/332] nvme-tcp: store negative errno in queue->tls_err
Date: Sun,  7 Jun 2026 11:57:37 +0200
Message-ID: <20260607095731.378914817@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261136-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:chuck.lever@oracle.com,m:hare@kernel.org,m:alistair.francis@wdc.com,m:pabeni@redhat.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0468964F760

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 9015985b5eb1a90eb86caf5bce1dfcf1aa38f8ad ]

nvme_tcp_tls_done() assigns queue->tls_err in three branches.  The
ENOKEY lookup failure and the EOPNOTSUPP initializer both store
negative errnos.  The third branch, reached when the handshake
layer reports a non-zero status, stores -status.

The handshake layer delivers status to the consumer callback as a
negative errno; the other in-tree consumers --
xs_tls_handshake_done() and the nvmet target callback -- treat
their status argument that way.  The extra negation in
nvme_tcp_tls_done() flips the sign, leaving tls_err as a positive
value (for instance, +EIO), which nvme_tcp_start_tls() then
returns to its caller.

Drop the extra negation so queue->tls_err uniformly carries a
negative errno on failure.

Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Link: https://patch.msgid.link/20260525-handshake-file-pin-v3-2-66c616906ead@oracle.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 243dab830dc84f..29f9ba0bdd3f1e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1688,7 +1688,7 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
 		qid, pskid, status);
 
 	if (status) {
-		queue->tls_err = -status;
+		queue->tls_err = status;
 		goto out_complete;
 	}
 
-- 
2.53.0




