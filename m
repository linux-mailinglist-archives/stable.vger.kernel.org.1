Return-Path: <stable+bounces-196729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8577CC80D71
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 14:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D5874E312F
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 13:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03ADD26FDB2;
	Mon, 24 Nov 2025 13:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tqLlH2e+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F6F30B506
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 13:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763992133; cv=none; b=IJtg1U5RGKTbjBi6ufNz4dZMpbdyr/JSDpMWaOdPNIWgDWCkUEkDe+Oxox2Ou+bscbt4oklx5eXXLXwNQM7hMpdBynyXYMdtqbO+JW4ipHDNH4gD20bv9r5FmoKcV/MBOnYSY0bEKXha3MKYbBvF93uQhOMjAICbtaMnyHkLosI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763992133; c=relaxed/simple;
	bh=4WptkZ5eaYwINo6oolupPA0f9hYkWaEd91cjZQNZwNQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gL2NHsEa+mMEzFLFVpOaeD/lMGojgKrmTp1uPoTKxnDcxR8sErrA1+3DYuJMbzZNlNXuI6kKtr9RNOTjQqklHZhnb7ONLk0j4JoXvXllgmYSA7NBPTHiNf1qI8SgNe/6PY98yf6IUsPK2x0a5UdmLIpegSRDJT51D4dvVj0a6Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tqLlH2e+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42196C4CEF1;
	Mon, 24 Nov 2025 13:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763992133;
	bh=4WptkZ5eaYwINo6oolupPA0f9hYkWaEd91cjZQNZwNQ=;
	h=Subject:To:Cc:From:Date:From;
	b=tqLlH2e+3Q60lGyBDAY1K8gC89t0GsMOLtMWGwxxLSNS8LkD4CKoLEWFaWZixhfV9
	 i5IMqxGuRgCme5jKrcLcnTdm0j97/2899UX03syxC9k+r2CQ1TlSXcBHuqNRdslFg1
	 01AhIxlT/MHgtPZn68K96peBf3F533O6lrPi1kmE=
Subject: FAILED: patch "[PATCH] mptcp: fix ack generation for fallback msk" failed to apply to 5.15-stable tree
To: pabeni@redhat.com,geliang@kernel.org,kuba@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Nov 2025 14:48:48 +0100
Message-ID: <2025112448-naming-survey-424d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 5e15395f6d9ec07395866c5511f4b4ac566c0c9b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112448-naming-survey-424d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5e15395f6d9ec07395866c5511f4b4ac566c0c9b Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 18 Nov 2025 08:20:19 +0100
Subject: [PATCH] mptcp: fix ack generation for fallback msk

mptcp_cleanup_rbuf() needs to know the last most recent, mptcp-level
rcv_wnd sent, and such information is tracked into the msk->old_wspace
field, updated at ack transmission time by mptcp_write_options().

Fallback socket do not add any mptcp options, such helper is never
invoked, and msk->old_wspace value remain stale. That in turn makes
ack generation at recvmsg() time quite random.

Address the issue ensuring mptcp_write_options() is invoked even for
fallback sockets, and just update the needed info in such a case.

The issue went unnoticed for a long time, as mptcp currently overshots
the fallback socket receive buffer autotune significantly. It is going
to change in the near future.

Fixes: e3859603ba13 ("mptcp: better msk receive window updates")
Cc: stable@vger.kernel.org
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/594
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251118-net-mptcp-misc-fixes-6-18-rc6-v1-1-806d3781c95f@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 1103b3341a70..8a63bd00807d 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -838,8 +838,11 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 
 	opts->suboptions = 0;
 
+	/* Force later mptcp_write_options(), but do not use any actual
+	 * option space.
+	 */
 	if (unlikely(__mptcp_check_fallback(msk) && !mptcp_check_infinite_map(skb)))
-		return false;
+		return true;
 
 	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
 		if (mptcp_established_options_fastclose(sk, &opt_size, remaining, opts) ||
@@ -1319,6 +1322,20 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 	WRITE_ONCE(msk->old_wspace, tp->rcv_wnd);
 }
 
+static void mptcp_track_rwin(struct tcp_sock *tp)
+{
+	const struct sock *ssk = (const struct sock *)tp;
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sock *msk;
+
+	if (!ssk)
+		return;
+
+	subflow = mptcp_subflow_ctx(ssk);
+	msk = mptcp_sk(subflow->conn);
+	WRITE_ONCE(msk->old_wspace, tp->rcv_wnd);
+}
+
 __sum16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum)
 {
 	struct csum_pseudo_header header;
@@ -1611,6 +1628,10 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
 				      opts->reset_transient,
 				      opts->reset_reason);
 		return;
+	} else if (unlikely(!opts->suboptions)) {
+		/* Fallback to TCP */
+		mptcp_track_rwin(tp);
+		return;
 	}
 
 	if (OPTION_MPTCP_PRIO & opts->suboptions) {


