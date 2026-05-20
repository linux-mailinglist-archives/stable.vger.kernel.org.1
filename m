Return-Path: <stable+bounces-252869-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKATJIMYDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-252869-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:24:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BA35998AD
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B0D131B5072
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DC23F9280;
	Wed, 20 May 2026 18:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o5bA2bSr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1A5368968;
	Wed, 20 May 2026 18:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301801; cv=none; b=Uk/fJoKK0YU5pFt5hDVAwDYmULE2uLF/6F3tvMqx3ICkEAi468NXI8PwVVdGfOlZykegE3KoxfeqprN4n+9UGahDQN4arvd+Q5BaJZZCjcGAHcI406zX2HliAiyyJzNgf8pWIluwlkb+v6tXL/N6qNmRwK+Vazzmfc4wHWwKKos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301801; c=relaxed/simple;
	bh=uWhR+USTu0mmjaEV3Y/mFAV6NYDtwte+9g/N+Ev+H+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MfRkQTlageWDmEeQp8Ajt3W32F3LWH7bqvh3iddR9DDH2mK3ZJ9OutFGR4KOPQrwjGeYaOkRz8uIVewfuzzGVLx4aadZqGUDzR/zv6h5Z+6ucCso5GjQ7jFdJNtMZT6j9EI9hl4240wBDZfmF9CEdsA3xATixJhXIcHBYJ0YTwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o5bA2bSr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79B61F00894;
	Wed, 20 May 2026 18:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301800;
	bh=2qCUGCi1/oPtvQabn5R64N5P7OLU0UJpD0PDyifX03U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o5bA2bSr2PRycL1MFtkVIByDnWiLuNfJ4dfKtOtf5ZXfhKmvbLBvkMWIXTF2hat8X
	 EzLGXJfWvsfbkiG0NH/0bH6OvuxC/aLNOM/jQQHgo0WTGQwyldb0vrvZtouaf7pGAj
	 H0sYRKPorBHmSEPB6Zz3wCvEswvUO52jZ+ujKeVw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vadim Fedorenko <vadfed@meta.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 025/508] bpf: Add CHECKSUM_COMPLETE to bpf test progs
Date: Wed, 20 May 2026 18:17:28 +0200
Message-ID: <20260520162059.135469645@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252869-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: A6BA35998AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vadim Fedorenko <vadfed@meta.com>

[ Upstream commit a3cfe84cca28f205761a0450016593b0d728165e ]

Add special flag to validate that TC BPF program properly updates
checksum information in skb.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20240606145851.229116-1-vadfed@meta.com
Stable-dep-of: 972787479ee7 ("bpf: test_run: Fix the null pointer dereference issue in bpf_lwt_xmit_push_encap")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/bpf.h       |  2 ++
 net/bpf/test_run.c             | 28 +++++++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h |  2 ++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 08a0494736e6e..6950169329ef1 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1344,6 +1344,8 @@ enum {
 #define BPF_F_TEST_RUN_ON_CPU	(1U << 0)
 /* If set, XDP frames will be transmitted after processing */
 #define BPF_F_TEST_XDP_LIVE_FRAMES	(1U << 1)
+/* If set, apply CHECKSUM_COMPLETE to skb and validate the checksum */
+#define BPF_F_TEST_SKB_CHECKSUM_COMPLETE	(1U << 2)
 
 /* type for BPF_ENABLE_STATS */
 enum bpf_stats_type {
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 3a1c82b797a30..774287ac17955 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -966,7 +966,8 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	void *data;
 	int ret;
 
-	if (kattr->test.flags || kattr->test.cpu || kattr->test.batch_size)
+	if ((kattr->test.flags & ~BPF_F_TEST_SKB_CHECKSUM_COMPLETE) ||
+	    kattr->test.cpu || kattr->test.batch_size)
 		return -EINVAL;
 
 	if (size < ETH_HLEN)
@@ -1017,6 +1018,7 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 
 	skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
 	__skb_put(skb, size);
+
 	if (ctx && ctx->ifindex > 1) {
 		dev = dev_get_by_index(net, ctx->ifindex);
 		if (!dev) {
@@ -1052,9 +1054,19 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 		__skb_push(skb, hh_len);
 	if (is_direct_pkt_access)
 		bpf_compute_data_pointers(skb);
+
 	ret = convert___skb_to_skb(skb, ctx);
 	if (ret)
 		goto out;
+
+	if (kattr->test.flags & BPF_F_TEST_SKB_CHECKSUM_COMPLETE) {
+		const int off = skb_network_offset(skb);
+		int len = skb->len - off;
+
+		skb->csum = skb_checksum(skb, off, len, 0);
+		skb->ip_summed = CHECKSUM_COMPLETE;
+	}
+
 	ret = bpf_test_run(prog, skb, repeat, &retval, &duration, false);
 	if (ret)
 		goto out;
@@ -1069,6 +1081,20 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 		}
 		memset(__skb_push(skb, hh_len), 0, hh_len);
 	}
+
+	if (kattr->test.flags & BPF_F_TEST_SKB_CHECKSUM_COMPLETE) {
+		const int off = skb_network_offset(skb);
+		int len = skb->len - off;
+		__wsum csum;
+
+		csum = skb_checksum(skb, off, len, 0);
+
+		if (csum_fold(skb->csum) != csum_fold(csum)) {
+			ret = -EBADMSG;
+			goto out;
+		}
+	}
+
 	convert_skb_to___skb(skb, ctx);
 
 	size = skb->len;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 2e064a1032a05..8967952de0c2e 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1344,6 +1344,8 @@ enum {
 #define BPF_F_TEST_RUN_ON_CPU	(1U << 0)
 /* If set, XDP frames will be transmitted after processing */
 #define BPF_F_TEST_XDP_LIVE_FRAMES	(1U << 1)
+/* If set, apply CHECKSUM_COMPLETE to skb and validate the checksum */
+#define BPF_F_TEST_SKB_CHECKSUM_COMPLETE	(1U << 2)
 
 /* type for BPF_ENABLE_STATS */
 enum bpf_stats_type {
-- 
2.53.0




