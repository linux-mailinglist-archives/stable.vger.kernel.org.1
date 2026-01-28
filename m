Return-Path: <stable+bounces-212402-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SON7Evc4emku4wEAu9opvQ
	(envelope-from <stable+bounces-212402-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:27:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 702BCA5A5C
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D73DB3232A3D
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E612EA172;
	Wed, 28 Jan 2026 15:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HzMOLDWp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E1C2DF138;
	Wed, 28 Jan 2026 15:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615397; cv=none; b=BarBlKLQC4oXdBHC4MQ0MLI4Pt1XuDrMsFRvzsVq1ZSvado14Grc8iy4+qp9fwkvH20BiC07k8UKB8PI/ypM3HG7dkOrDb+G/bAG6P9QwEnm6vguyU6bFxMz229LSBhz3BYmBBRn3cNZDWT0lAnz4xPadRqgRHC6dYA5vNNfpZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615397; c=relaxed/simple;
	bh=tFGlRD6WbcddGBWcrbA9QufwiuxnE+YBunthxwIDuyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxum2srIMiKbfQI4xSMoiheo2I5+pLCBBX+Cb+rjToxOyfx0FaOBqwOTlh/RvYqfyHxABdE3STKqEFWUZYnHS4wHd0esXNYR46Nc5jWQcIorTpRFfD66TxfIEYJ+sr3o0XYEv2r+VOX5s3yzhmEBnLo22BNYg5+Rq111F6+ce4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HzMOLDWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CBEC4CEF1;
	Wed, 28 Jan 2026 15:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615397;
	bh=tFGlRD6WbcddGBWcrbA9QufwiuxnE+YBunthxwIDuyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HzMOLDWpt8KD1pLlsyVJRSjHDzT8Jkt2+hKE1sOqFpqrZU9ZnmEr9ndU3hRdKzENV
	 S2gp3DRkN5sio7WcH3bHLD1kRC3GMOkwwXw+fuUU117XlmVLMVqzNd8TJy2V3FOXWk
	 oQ6wOaOpMCWfCMNeJNYCxor1OTPeSucZqUqb+yKY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Will Deacon <will@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Heitor Alves de Siqueira <halves@igalia.com>
Subject: [PATCH 6.12 168/169] net: Introduce skb_copy_datagram_from_iter_full()
Date: Wed, 28 Jan 2026 16:24:11 +0100
Message-ID: <20260128145340.074993193@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212402-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,igalia.com:email]
X-Rspamd-Queue-Id: 702BCA5A5C
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will@kernel.org>

[Upstream commit b08a784a5d1495c42ff9b0c70887d49211cddfe0]

In a similar manner to copy_from_iter()/copy_from_iter_full(), introduce
skb_copy_datagram_from_iter_full() which reverts the iterator to its
initial state when returning an error.

A subsequent fix for a vsock regression will make use of this new
function.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Will Deacon <will@kernel.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Link: https://patch.msgid.link/20250818180355.29275-2-will@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Heitor Alves de Siqueira <halves@igalia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/skbuff.h |    2 ++
 net/core/datagram.c    |   14 ++++++++++++++
 2 files changed, 16 insertions(+)

--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4117,6 +4117,8 @@ int skb_copy_and_hash_datagram_iter(cons
 			   struct ahash_request *hash);
 int skb_copy_datagram_from_iter(struct sk_buff *skb, int offset,
 				 struct iov_iter *from, int len);
+int skb_copy_datagram_from_iter_full(struct sk_buff *skb, int offset,
+				     struct iov_iter *from, int len);
 int zerocopy_sg_from_iter(struct sk_buff *skb, struct iov_iter *frm);
 void skb_free_datagram(struct sock *sk, struct sk_buff *skb);
 int skb_kill_datagram(struct sock *sk, struct sk_buff *skb, unsigned int flags);
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -621,6 +621,20 @@ fault:
 }
 EXPORT_SYMBOL(skb_copy_datagram_from_iter);
 
+int skb_copy_datagram_from_iter_full(struct sk_buff *skb, int offset,
+				     struct iov_iter *from, int len)
+{
+	struct iov_iter_state state;
+	int ret;
+
+	iov_iter_save_state(from, &state);
+	ret = skb_copy_datagram_from_iter(skb, offset, from, len);
+	if (ret)
+		iov_iter_restore(from, &state);
+	return ret;
+}
+EXPORT_SYMBOL(skb_copy_datagram_from_iter_full);
+
 int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
 				struct iov_iter *from, size_t length)
 {



