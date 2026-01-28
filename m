Return-Path: <stable+bounces-212398-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJ+CDMcxemkx4gEAu9opvQ
	(envelope-from <stable+bounces-212398-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:56:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B728A4C7A
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD44630692E4
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF3C2F25EF;
	Wed, 28 Jan 2026 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h4QQ2sre"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEBB2DF138;
	Wed, 28 Jan 2026 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615384; cv=none; b=B/xUxCiuJyLsItohHa9rt6idvdYisoLwHxjBaWoXmmwjLGnfm0ZPu+zf6RtTUub1zOqWjU4EHuY041DgCIg3I5nhc0imnGQTNhoLNQrRiRsWWkEVJqhV5TCnLn0J0rYORpPopxr4g8mos/JLAAQIoBiYBb4cLzlvxb5zzAIoT0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615384; c=relaxed/simple;
	bh=jHQ8FHa0oqSpsdAdVf+MqgAsnIaqhDQvD4Cf7yrBYNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E6SJGH+6qU3jSZDt+KfnB2f3sXKo1nl29eoLpqEooFxl6OvOC2gwShznEUMfuJItBQYgp626E2zSwN1zRC3q14cYHJa3Ngl5ZicOZQo5vbG0HSsdY8mbO0XSdKnObV2HazDp+qY1KOu6v29E58SX7GJ8Wo2WY4BZigvHc9RvcR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h4QQ2sre; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37D2C4CEF1;
	Wed, 28 Jan 2026 15:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615384;
	bh=jHQ8FHa0oqSpsdAdVf+MqgAsnIaqhDQvD4Cf7yrBYNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h4QQ2sreiXTOeZEM7H1V1tkp2W0mjb9LLsrLQ285PiYd5tbnGvnfVXpSk34cy7eow
	 mHItupdKAt6qOn+wRIW9C9xsJPWc07iXEJ5LuRrr62KZ1tQjmShTRw6O1aECY+WDap
	 /zkEv7AU3reWtQfLoRHkju2U2HyYt6dSFAjL3nO4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"kernel-dev@igalia.com, Heitor Alves de Siqueira" <halves@igalia.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Will Deacon <will@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Heitor Alves de Siqueira <halves@igalia.com>
Subject: [PATCH 6.12 164/169] vsock/virtio: Move SKB allocation lower-bound check to callers
Date: Wed, 28 Jan 2026 16:24:07 +0100
Message-ID: <20260128145339.925653182@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145334.006287341@linuxfoundation.org>
References: <20260128145334.006287341@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212398-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9B728A4C7A
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will@kernel.org>

[Upstream commit fac6b82e0f3eaca33c8c67ec401681b21143ae17]

virtio_vsock_alloc_linear_skb() checks that the requested size is at
least big enough for the packet header (VIRTIO_VSOCK_SKB_HEADROOM).

Of the three callers of virtio_vsock_alloc_linear_skb(), only
vhost_vsock_alloc_skb() can potentially pass a packet smaller than the
header size and, as it already has a check against the maximum packet
size, extend its bounds checking to consider the minimum packet size
and remove the check from virtio_vsock_alloc_linear_skb().

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Will Deacon <will@kernel.org>
Message-Id: <20250717090116.11987-7-will@kernel.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Heitor Alves de Siqueira <halves@igalia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vhost/vsock.c        |    3 ++-
 include/linux/virtio_vsock.h |    3 ---
 2 files changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -345,7 +345,8 @@ vhost_vsock_alloc_skb(struct vhost_virtq
 
 	len = iov_length(vq->iov, out);
 
-	if (len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
+	if (len < VIRTIO_VSOCK_SKB_HEADROOM ||
+	    len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
 		return NULL;
 
 	/* len contains both payload and hdr */
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -57,9 +57,6 @@ virtio_vsock_alloc_linear_skb(unsigned i
 {
 	struct sk_buff *skb;
 
-	if (size < VIRTIO_VSOCK_SKB_HEADROOM)
-		return NULL;
-
 	skb = alloc_skb(size, mask);
 	if (!skb)
 		return NULL;



