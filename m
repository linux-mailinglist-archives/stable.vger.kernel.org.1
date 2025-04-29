Return-Path: <stable+bounces-137410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F92FAA1342
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAC85188F32D
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4924C246326;
	Tue, 29 Apr 2025 16:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pI4Rc9ay"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067B182C60;
	Tue, 29 Apr 2025 16:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945984; cv=none; b=r21J2fdMhCBbo8OaEThFaFCZ3n1QJahdjjdMFUKthyzgeie5mFXw/wlTEgdECa8+uWI+YjkoZM8BZRpmfa3OhvjTWLB1EjwRwdXKrDY0374dgXAOMgqovl4dvIfsBCUF50HBLecc1/GwndWjWXTk26ByctdRoF16TIAvgF4ymbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945984; c=relaxed/simple;
	bh=g6D/2Zjo4dfeK3a8yYy4SxAOXyKc8O2DnAz9Cb2xQOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqY03pq7xfcamOtWdVbSm0b9jZ8n04xq1b3LH1U8jbaypJl82NBNjYk+cRo0qC67NSHiAU9BEeb0Aft59bfm9SBYE9Zq0W3pUrOnO4rYMJEYTnhbeK/f8z+Nffi9AbEEXiQC1I8LbBDzScUwGak5BUynau81RC9FZyv6uHuF1z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pI4Rc9ay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2EAC4CEE3;
	Tue, 29 Apr 2025 16:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745945983;
	bh=g6D/2Zjo4dfeK3a8yYy4SxAOXyKc8O2DnAz9Cb2xQOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pI4Rc9ayJKQIZg8FMUkgB8skHdActCm/QiXE/57apyCoMUoBR0WZ3LCn6zHY8tnZI
	 wp4izt5BaXVp6iK1Z4pTs/cQ3exYomS/rGuj+LrIoCht+KicqOj4DvbmS/d+Iz2r8r
	 hI+Gxuyll3IU4qmHi2l+RBl0zvfxe9DObENWrm9Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.14 114/311] net: selftests: initialize TCP header and skb payload with zero
Date: Tue, 29 Apr 2025 18:39:11 +0200
Message-ID: <20250429161125.710630770@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161121.011111832@linuxfoundation.org>
References: <20250429161121.011111832@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oleksij Rempel <o.rempel@pengutronix.de>

commit 9e8d1013b0c38910cbc9e60de74dbe883878469d upstream.

Zero-initialize TCP header via memset() to avoid garbage values that
may affect checksum or behavior during test transmission.

Also zero-fill allocated payload and padding regions using memset()
after skb_put(), ensuring deterministic content for all outgoing
test packets.

Fixes: 3e1e58d64c3d ("net: add generic selftest support")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: stable@vger.kernel.org
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250416160125.2914724-1-o.rempel@pengutronix.de
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/selftests.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

--- a/net/core/selftests.c
+++ b/net/core/selftests.c
@@ -100,10 +100,10 @@ static struct sk_buff *net_test_get_skb(
 	ehdr->h_proto = htons(ETH_P_IP);
 
 	if (attr->tcp) {
+		memset(thdr, 0, sizeof(*thdr));
 		thdr->source = htons(attr->sport);
 		thdr->dest = htons(attr->dport);
 		thdr->doff = sizeof(struct tcphdr) / 4;
-		thdr->check = 0;
 	} else {
 		uhdr->source = htons(attr->sport);
 		uhdr->dest = htons(attr->dport);
@@ -144,10 +144,18 @@ static struct sk_buff *net_test_get_skb(
 	attr->id = net_test_next_id;
 	shdr->id = net_test_next_id++;
 
-	if (attr->size)
-		skb_put(skb, attr->size);
-	if (attr->max_size && attr->max_size > skb->len)
-		skb_put(skb, attr->max_size - skb->len);
+	if (attr->size) {
+		void *payload = skb_put(skb, attr->size);
+
+		memset(payload, 0, attr->size);
+	}
+
+	if (attr->max_size && attr->max_size > skb->len) {
+		size_t pad_len = attr->max_size - skb->len;
+		void *pad = skb_put(skb, pad_len);
+
+		memset(pad, 0, pad_len);
+	}
 
 	skb->csum = 0;
 	skb->ip_summed = CHECKSUM_PARTIAL;



