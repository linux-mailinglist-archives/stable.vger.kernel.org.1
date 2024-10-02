Return-Path: <stable+bounces-79653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 893E598D98D
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A719B1C22A40
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B52D1D1731;
	Wed,  2 Oct 2024 14:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uysQvB3K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DDA1D172E;
	Wed,  2 Oct 2024 14:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878071; cv=none; b=dU8G9XuTuMALzgLMcVKLqfqFeXAizimqntwl9aVCDU4evaRUG2A2RIw8OmnXZ1uH0zkOwt1kWosvzXxDCqCgE4vCXriIeNVldsdQOPz62QBo5VmrdhDRfGaPrGh8g1jWrFFkGdTKXzRtkJVLXpge5kU6Zt3i3F1WHwRRMn4n7As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878071; c=relaxed/simple;
	bh=u6yiu6geDmZKonabiO+bkefgCwWGWmxt/fVmcko69gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hngl1FkD36rEmfna0AhvGNm2VxReFSa4dWmRIxyzKj3oFeiAQJ02za8/e6ivrvvgFuuBFndVArlBzEcjIlqSybLwdh/ZVtsvdim2y4MR8vrXbvTB6lQpohRPMavy25585R0J8PIV1/y7TJ1SfI8yeeB2+Msaxhnd1T2UKfdEvc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uysQvB3K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59FBBC4CEC5;
	Wed,  2 Oct 2024 14:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727878070;
	bh=u6yiu6geDmZKonabiO+bkefgCwWGWmxt/fVmcko69gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uysQvB3KF1w3faysAFMnuvbMCkrJt4gpVYWC0J77lJ5k1mgBSX2/tJsBYUX0UrWlZ
	 qUuLpQyjWbwAi1X0S8SrCids5cuNfCFl4lLozh2Ky6a+bSst4+sDucJshtqfiGtCuV
	 veuqkN9g+gE/RyQUinEQe+GKBOGHFf6uVDcLbXQo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 291/634] bpf: Zero former ARG_PTR_TO_{LONG,INT} args in case of error
Date: Wed,  2 Oct 2024 14:56:31 +0200
Message-ID: <20241002125822.597611521@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 4b3786a6c5397dc220b1483d8e2f4867743e966f ]

For all non-tracing helpers which formerly had ARG_PTR_TO_{LONG,INT} as input
arguments, zero the value for the case of an error as otherwise it could leak
memory. For tracing, it is not needed given CAP_PERFMON can already read all
kernel memory anyway hence bpf_get_func_arg() and bpf_get_func_ret() is skipped
in here.

Also, the MTU helpers mtu_len pointer value is being written but also read.
Technically, the MEM_UNINIT should not be there in order to always force init.
Removing MEM_UNINIT needs more verifier rework though: MEM_UNINIT right now
implies two things actually: i) write into memory, ii) memory does not have
to be initialized. If we lift MEM_UNINIT, it then becomes: i) read into memory,
ii) memory must be initialized. This means that for bpf_*_check_mtu() we're
readding the issue we're trying to fix, that is, it would then be able to
write back into things like .rodata BPF maps. Follow-up work will rework the
MEM_UNINIT semantics such that the intent can be better expressed. For now
just clear the *mtu_len on error path which can be lifted later again.

Fixes: 8a67f2de9b1d ("bpf: expose bpf_strtol and bpf_strtoul to all program types")
Fixes: d7a4cb9b6705 ("bpf: Introduce bpf_strtol and bpf_strtoul helpers")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/e5edd241-59e7-5e39-0ee5-a51e31b6840a@iogearbox.net
Link: https://lore.kernel.org/r/20240913191754.13290-5-daniel@iogearbox.net
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/helpers.c |  2 ++
 kernel/bpf/syscall.c |  1 +
 net/core/filter.c    | 44 +++++++++++++++++++++++---------------------
 3 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 3155ea611c94d..a9ae8f8e61807 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -522,6 +522,7 @@ BPF_CALL_4(bpf_strtol, const char *, buf, size_t, buf_len, u64, flags,
 	long long _res;
 	int err;
 
+	*res = 0;
 	err = __bpf_strtoll(buf, buf_len, flags, &_res);
 	if (err < 0)
 		return err;
@@ -549,6 +550,7 @@ BPF_CALL_4(bpf_strtoul, const char *, buf, size_t, buf_len, u64, flags,
 	bool is_negative;
 	int err;
 
+	*res = 0;
 	err = __bpf_strtoull(buf, buf_len, flags, &_res, &is_negative);
 	if (err < 0)
 		return err;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d813abc86d12e..f6b6d297fad6e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5910,6 +5910,7 @@ static const struct bpf_func_proto bpf_sys_close_proto = {
 
 BPF_CALL_4(bpf_kallsyms_lookup_name, const char *, name, int, name_sz, int, flags, u64 *, res)
 {
+	*res = 0;
 	if (flags)
 		return -EINVAL;
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 45a6b61f759fa..61da5512cd4d2 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6258,20 +6258,25 @@ BPF_CALL_5(bpf_skb_check_mtu, struct sk_buff *, skb,
 	int ret = BPF_MTU_CHK_RET_FRAG_NEEDED;
 	struct net_device *dev = skb->dev;
 	int skb_len, dev_len;
-	int mtu;
+	int mtu = 0;
 
-	if (unlikely(flags & ~(BPF_MTU_CHK_SEGS)))
-		return -EINVAL;
+	if (unlikely(flags & ~(BPF_MTU_CHK_SEGS))) {
+		ret = -EINVAL;
+		goto out;
+	}
 
-	if (unlikely(flags & BPF_MTU_CHK_SEGS && (len_diff || *mtu_len)))
-		return -EINVAL;
+	if (unlikely(flags & BPF_MTU_CHK_SEGS && (len_diff || *mtu_len))) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	dev = __dev_via_ifindex(dev, ifindex);
-	if (unlikely(!dev))
-		return -ENODEV;
+	if (unlikely(!dev)) {
+		ret = -ENODEV;
+		goto out;
+	}
 
 	mtu = READ_ONCE(dev->mtu);
-
 	dev_len = mtu + dev->hard_header_len;
 
 	/* If set use *mtu_len as input, L3 as iph->tot_len (like fib_lookup) */
@@ -6289,15 +6294,12 @@ BPF_CALL_5(bpf_skb_check_mtu, struct sk_buff *, skb,
 	 */
 	if (skb_is_gso(skb)) {
 		ret = BPF_MTU_CHK_RET_SUCCESS;
-
 		if (flags & BPF_MTU_CHK_SEGS &&
 		    !skb_gso_validate_network_len(skb, mtu))
 			ret = BPF_MTU_CHK_RET_SEGS_TOOBIG;
 	}
 out:
-	/* BPF verifier guarantees valid pointer */
 	*mtu_len = mtu;
-
 	return ret;
 }
 
@@ -6307,19 +6309,21 @@ BPF_CALL_5(bpf_xdp_check_mtu, struct xdp_buff *, xdp,
 	struct net_device *dev = xdp->rxq->dev;
 	int xdp_len = xdp->data_end - xdp->data;
 	int ret = BPF_MTU_CHK_RET_SUCCESS;
-	int mtu, dev_len;
+	int mtu = 0, dev_len;
 
 	/* XDP variant doesn't support multi-buffer segment check (yet) */
-	if (unlikely(flags))
-		return -EINVAL;
+	if (unlikely(flags)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	dev = __dev_via_ifindex(dev, ifindex);
-	if (unlikely(!dev))
-		return -ENODEV;
+	if (unlikely(!dev)) {
+		ret = -ENODEV;
+		goto out;
+	}
 
 	mtu = READ_ONCE(dev->mtu);
-
-	/* Add L2-header as dev MTU is L3 size */
 	dev_len = mtu + dev->hard_header_len;
 
 	/* Use *mtu_len as input, L3 as iph->tot_len (like fib_lookup) */
@@ -6329,10 +6333,8 @@ BPF_CALL_5(bpf_xdp_check_mtu, struct xdp_buff *, xdp,
 	xdp_len += len_diff; /* minus result pass check */
 	if (xdp_len > dev_len)
 		ret = BPF_MTU_CHK_RET_FRAG_NEEDED;
-
-	/* BPF verifier guarantees valid pointer */
+out:
 	*mtu_len = mtu;
-
 	return ret;
 }
 
-- 
2.43.0




