Return-Path: <stable+bounces-123338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B20FA5C50D
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742FA3B6245
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748C625DCE3;
	Tue, 11 Mar 2025 15:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FxuUDaf/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329AE25DD06;
	Tue, 11 Mar 2025 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705665; cv=none; b=Y/2FA7Nj/mgBLYljj5Bg7gvA3bblNLBbR1Cjeb/z+fvys2jq5FzYvWuNO/U+MtBtXpmYmfvIEUHi9pFPM97ZKetW/BzZKV6kPcza7V4gOTWPwOt/L6OAVBSNMC7mFgO/+7zAAT1zQz5xeu+pJsvRnmdEVJIExkObDMitoVYUWGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705665; c=relaxed/simple;
	bh=2sjc5M+uBlSQIfueDxnBlOyZgotbLbrlvAl1cuAwVaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JREwYp4phMQubACUTEQFdvF0LgGmLF99uKwG6HnCF7aWOwo8GwPfPg5gYrpMarsELDg7yDyc0dRV2oqHknQQ+NjEC5g+Yo7VAdrRNv8sBD9qsqV/SJ8dlk6XGTCT+cB2GH/ZQAe94c4Pn6nvQnBOItbKtjgisegxRdd+66yYNfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FxuUDaf/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BF7C4CEE9;
	Tue, 11 Mar 2025 15:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741705663;
	bh=2sjc5M+uBlSQIfueDxnBlOyZgotbLbrlvAl1cuAwVaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FxuUDaf/6bAl/WJA66/DZ7WjDYlHAeiJhKbI44zth5kOZ8iSo/tlnm1aNx4bkaO3+
	 fyot8KT43TvUt3MyleIA8JTugCB3WudCC56G0JIo61FihyHQl9L+mWIh4kwR/eWop/
	 xUXqwa2Tr6Fsiq5gQRZTXxR1o2B8bRaL3gF3DdDQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yan Zhai <yan@cloudflare.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 113/328] udp: gso: do not drop small packets when PMTU reduces
Date: Tue, 11 Mar 2025 15:58:03 +0100
Message-ID: <20250311145719.388943422@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311145714.865727435@linuxfoundation.org>
References: <20250311145714.865727435@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yan Zhai <yan@cloudflare.com>

[ Upstream commit 235174b2bed88501fda689c113c55737f99332d8 ]

Commit 4094871db1d6 ("udp: only do GSO if # of segs > 1") avoided GSO
for small packets. But the kernel currently dismisses GSO requests only
after checking MTU/PMTU on gso_size. This means any packets, regardless
of their payload sizes, could be dropped when PMTU becomes smaller than
requested gso_size. We encountered this issue in production and it
caused a reliability problem that new QUIC connection cannot be
established before PMTU cache expired, while non GSO sockets still
worked fine at the same time.

Ideally, do not check any GSO related constraints when payload size is
smaller than requested gso_size, and return EMSGSIZE instead of EINVAL
on MTU/PMTU check failure to be more specific on the error cause.

Fixes: 4094871db1d6 ("udp: only do GSO if # of segs > 1")
Signed-off-by: Yan Zhai <yan@cloudflare.com>
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/udp.c                       |  4 ++--
 net/ipv6/udp.c                       |  4 ++--
 tools/testing/selftests/net/udpgso.c | 26 ++++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 1ccdb6a9ab892..f85c48858341d 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -849,9 +849,9 @@ static int udp_send_skb(struct sk_buff *skb, struct flowi4 *fl4,
 		const int hlen = skb_network_header_len(skb) +
 				 sizeof(struct udphdr);
 
-		if (hlen + cork->gso_size > cork->fragsize) {
+		if (hlen + min(datalen, cork->gso_size) > cork->fragsize) {
 			kfree_skb(skb);
-			return -EINVAL;
+			return -EMSGSIZE;
 		}
 		if (datalen > cork->gso_size * UDP_MAX_SEGMENTS) {
 			kfree_skb(skb);
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index e6fdb842e89df..58793dd7ac2c4 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1141,9 +1141,9 @@ static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
 		const int hlen = skb_network_header_len(skb) +
 				 sizeof(struct udphdr);
 
-		if (hlen + cork->gso_size > cork->fragsize) {
+		if (hlen + min(datalen, cork->gso_size) > cork->fragsize) {
 			kfree_skb(skb);
-			return -EINVAL;
+			return -EMSGSIZE;
 		}
 		if (datalen > cork->gso_size * UDP_MAX_SEGMENTS) {
 			kfree_skb(skb);
diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selftests/net/udpgso.c
index 7badaf215de28..0e137182a4f40 100644
--- a/tools/testing/selftests/net/udpgso.c
+++ b/tools/testing/selftests/net/udpgso.c
@@ -94,6 +94,19 @@ struct testcase testcases_v4[] = {
 		.gso_len = CONST_MSS_V4,
 		.r_num_mss = 1,
 	},
+	{
+		/* datalen <= MSS < gso_len: will fall back to no GSO */
+		.tlen = CONST_MSS_V4,
+		.gso_len = CONST_MSS_V4 + 1,
+		.r_num_mss = 0,
+		.r_len_last = CONST_MSS_V4,
+	},
+	{
+		/* MSS < datalen < gso_len: fail */
+		.tlen = CONST_MSS_V4 + 1,
+		.gso_len = CONST_MSS_V4 + 2,
+		.tfail = true,
+	},
 	{
 		/* send a single MSS + 1B */
 		.tlen = CONST_MSS_V4 + 1,
@@ -197,6 +210,19 @@ struct testcase testcases_v6[] = {
 		.gso_len = CONST_MSS_V6,
 		.r_num_mss = 1,
 	},
+	{
+		/* datalen <= MSS < gso_len: will fall back to no GSO */
+		.tlen = CONST_MSS_V6,
+		.gso_len = CONST_MSS_V6 + 1,
+		.r_num_mss = 0,
+		.r_len_last = CONST_MSS_V6,
+	},
+	{
+		/* MSS < datalen < gso_len: fail */
+		.tlen = CONST_MSS_V6 + 1,
+		.gso_len = CONST_MSS_V6 + 2,
+		.tfail = true
+	},
 	{
 		/* send a single MSS + 1B */
 		.tlen = CONST_MSS_V6 + 1,
-- 
2.39.5




