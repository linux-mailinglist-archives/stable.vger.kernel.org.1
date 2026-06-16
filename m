Return-Path: <stable+bounces-265133-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AekIJ6qDMWpklQUAu9opvQ
	(envelope-from <stable+bounces-265133-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:11:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E74F692D3C
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:11:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=K6HKwPsz;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265133-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265133-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 744E5307B59F
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260DA47CC94;
	Tue, 16 Jun 2026 17:07:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F5547B41C;
	Tue, 16 Jun 2026 17:07:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629637; cv=none; b=eRDJ+sW3YH552fKsubWXelXtiRRYlBgK3bzQ5+SvKMNcLHY0jCS0XbIfCVGrvwm7jZw3sXCW3efF6A7wSYcky/ktGyBM4VBDROdQcjWEjA+IvGI0P4bboNGNPL7tsUfeG2zoNRfL9mDQ95WnpTYkkuGSK3uNlMx11brZkv/mbRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629637; c=relaxed/simple;
	bh=w/U7n2fm9rvwR/Ti92IZAYu6pqFg6AxJp9GLm80Gsdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrmeEu4GdO67JnGZRS06dJYcsU9cALhCfGbbaJ/aFQxoIaJsSgr8C8W4JVtVRyb0sBHlR7/RrvZQjmxZn/SmaFbC1rPtJ9VxBV1o0HhqNjMjkHdAbbBZmsNVQxSjXC+pX/+uA6+HkseJIc9BvLrvmyYCb7f4trc17Y9iC0sJ9PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K6HKwPsz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA3D1F000E9;
	Tue, 16 Jun 2026 17:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781629636;
	bh=ikILd5nwif8GtJfXWRsuS1TjIwQrMxntEsI3WhwOavI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K6HKwPszRTmx0GlNl7Zwhnb2S8EUlT0snUEyMXXJUtzXrfSeIzIoLZMBUs3DOmCLo
	 npcOBFOgVmX/IBg//+Y3n+0lGI/xxRrBMQ0NLQsaYrXVDqpOEBUtyEBUERxv0QM5Mg
	 2Kqg4AkGascNOcGk0IEx0A2EEU6tVjxVoSKYAkkM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 6.6 323/452] IB/isert: Reject login PDUs shorter than ISER_HEADERS_LEN
Date: Tue, 16 Jun 2026 20:29:10 +0530
Message-ID: <20260616145134.400163691@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265133-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:michael.bommarito@gmail.com,m:jgg@nvidia.com,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,nvidia.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E74F692D3C

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Bommarito <michael.bommarito@gmail.com>

commit 29e7b925ae6df64894e82ab6419994dc25580a8a upstream.

In drivers/infiniband/ulp/isert/ib_isert.c, isert_login_recv_done()
computes the login request payload length as wc->byte_len minus
ISER_HEADERS_LEN with no lower bound, and login_req_len is a signed int.
A remote iSER initiator can post a login Send work request carrying
fewer than ISER_HEADERS_LEN (76) bytes, so the subtraction underflows
and login_req_len becomes negative.

isert_rx_login_req() then reads that negative length back into a signed
int, takes size = min(rx_buflen, MAX_KEY_VALUE_PAIRS), and because the
min() is signed it keeps the negative value; the value is then passed as
the memcpy() length and sign-extended to a multi-gigabyte size_t. The
copy into the 8192-byte login->req_buf runs far out of bounds and
faults, crashing the target node. The login phase precedes iSCSI
authentication, so no credentials are required to reach this path.

Reject any login PDU shorter than ISER_HEADERS_LEN before the
subtraction, mirroring the existing early return on a failed work
completion, so login_req_len can never go negative. The upper bound was
already safe: a posted login buffer cannot deliver more than
ISER_RX_PAYLOAD_SIZE, so the difference stays at or below
MAX_KEY_VALUE_PAIRS and the existing min() clamps it; only the missing
lower bound needs to be added.

Fixes: b8d26b3be8b3 ("iser-target: Add iSCSI Extensions for RDMA (iSER) target driver")
Link: https://patch.msgid.link/r/20260602194642.2273217-1-michael.bommarito@gmail.com
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/ulp/isert/ib_isert.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -1388,6 +1388,12 @@ isert_login_recv_done(struct ib_cq *cq,
 	ib_dma_sync_single_for_cpu(ib_dev, isert_conn->login_desc->dma_addr,
 			ISER_RX_SIZE, DMA_FROM_DEVICE);
 
+	if (unlikely(wc->byte_len < ISER_HEADERS_LEN)) {
+		isert_dbg("login request length %u is too short\n",
+			  wc->byte_len);
+		return;
+	}
+
 	isert_conn->login_req_len = wc->byte_len - ISER_HEADERS_LEN;
 
 	if (isert_conn->conn) {



