Return-Path: <stable+bounces-72801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4D89699E9
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 12:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A3F1283831
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 10:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C72319F430;
	Tue,  3 Sep 2024 10:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlgAJ1e3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDA72904;
	Tue,  3 Sep 2024 10:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358683; cv=none; b=IBpljqYMXmHSs00K1CgKFxJt8JO0Dru42TAOwk1X6qQN4GZRt/hgVwVX4YKUaCTKxd9pi6BlOFlZaeoFAROBly0Z2AkYj3d6CVPEIehyLKDnf9hvF7s5AFarqcXHG7jX8xIOg+NJejz1EC9t9+zZB2b0zb01lBLrYc+EdGvZ9X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358683; c=relaxed/simple;
	bh=/NiMOcEwEirDGhkQiJg+esLtNVzlbZxQb/wpX4p23LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TbBTHHK5+OIU4PKyXv6HmOo/pLqMVTD9ioetcDqoAXlud7+c9vVcLIuX9ihvseUpy7a2MfFkRfdFWRvgjTyQPQufKs+APUgjy77tsgKLKzmTh1vn0AOIqWRGi7xBJlJ+E3PUAOLttwAuQKlsxm3b+xvK7Tw/cMxkUUGLgZiWioc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlgAJ1e3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B424FC4CEC5;
	Tue,  3 Sep 2024 10:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725358682;
	bh=/NiMOcEwEirDGhkQiJg+esLtNVzlbZxQb/wpX4p23LQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mlgAJ1e3rKCA3/eRcMHbxqXiJ218et6opg7xcXpzcTKY57F7qdfpnCHAJKzeM1hvV
	 nvrfTvypjuvuOyyeVsZ9sXHutDs7JHAg6BuFQsj8IaXRLzDe6Ap+mkRk5cEjJzHctL
	 FMAUljQm64DA9aZNz0hIRsN+cXf0BTBzVm7SFoz1XZg/gUVYH6zxK9AD/rW/5MHqHW
	 4Bo5ZVO3nbyH4hYBwPUz5/KNaMxeurmrkjW+/dzMUml3dwHg9xNKlVe4xTxqr1E2he
	 ntPb2+7BBp/4+2xkQuyvqtzKFYBx5mmK2tBsHMEmkOuAXgAmUlc/HvxycgDBs67P1A
	 3yF1G4yWkbkow==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.6.y] mptcp: avoid duplicated SUB_CLOSED events
Date: Tue,  3 Sep 2024 12:17:48 +0200
Message-ID: <20240903101747.3377518-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024083026-snooper-unbundle-373f@gregkh>
References: <2024083026-snooper-unbundle-373f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3242; i=matttbe@kernel.org; h=from:subject; bh=/NiMOcEwEirDGhkQiJg+esLtNVzlbZxQb/wpX4p23LQ=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1uJLIHAjcXjAI+AerY/+50gan49ZCX/hywhoi OvnRNCCbZmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtbiSwAKCRD2t4JPQmmg c+4uD/sGVcrEIix1LTLOWAsZre+VSxm5qhAPChmuzBYm/vyxY+TRO2bMAeORhRQrX4DYcary+/N e8Y4VnA75kA3cdcatPQ7Om5rXqfIVsDE8v+BC+thZlo5qFXvC86n3cTRLsrN4f+I/oT3kEVmgD0 JDnP8QTZzq8XkUbAeTlCaKmNK+9J48oYzYiVPP115x8Ama7tmG5ie0XXMFDLLDj0DTcXnStXoBT paYf3/ch4DvUZjAYBqa/MFMLvwqc2yko86ymJWnAZh0An4j1IDlgoLxbJ9bMIrIfD3ZYheoz6DP Sb21cu9ZlgzUlkoBsJ1Gm5sWd4AJHqtf7qd2Coo1L0Sb74umzw1SmvwljmU3x79YSuEkRYcg5sd eqBQmv5faOmN8UrPjm6zCqhx5Xpvyx9kQ8KrqAR0R+K6Wmp/UCmTTjw+Vr16OFFXiZkQm7X9Fy8 eWeUNqM/waQIe4v7TTmMbKSi02q/BHRml+kxmldbTI1tFDlOFkjHZdg80WebYnaOxRhw2s0UO+h 5O7Cbc+ikXEbqNcy8F0iZtFBtaWAMDmxHBP742UkkEuj+4kos4WcIDZVHfJ/0LEdCLzCL9+8Lt2 CbIt5yavzX+ih/7nOJ+MY7ykQMjY8tiZQDTaWEGoAaYJ+VmbWycDavQs2/C7dFAIbxfeHkqRgIq LxNFgJ/rZn07Vxw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit d82809b6c5f2676b382f77a5cbeb1a5d91ed2235 upstream.

The initial subflow might have already been closed, but still in the
connection list. When the worker is instructed to close the subflows
that have been marked as closed, it might then try to close the initial
subflow again.

 A consequence of that is that the SUB_CLOSED event can be seen twice:

  # ip mptcp endpoint
  1.1.1.1 id 1 subflow dev eth0
  2.2.2.2 id 2 subflow dev eth1

  # ip mptcp monitor &
  [         CREATED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
  [     ESTABLISHED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
  [  SF_ESTABLISHED] remid=0 locid=2 saddr4=2.2.2.2 daddr4=9.9.9.9

  # ip mptcp endpoint delete id 1
  [       SF_CLOSED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
  [       SF_CLOSED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9

The first one is coming from mptcp_pm_nl_rm_subflow_received(), and the
second one from __mptcp_close_subflow().

To avoid doing the post-closed processing twice, the subflow is now
marked as closed the first time.

Note that it is not enough to check if we are dealing with the first
subflow and check its sk_state: the subflow might have been reset or
closed before calling mptcp_close_ssk().

Fixes: b911c97c7dc7 ("mptcp: add netlink event support")
Cc: stable@vger.kernel.org
Tested-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflict in protocol.h due to commit f1f26512a9bf ("mptcp: use plain
  bool instead of custom binary enum") and more that are not in this
  version, because they modify the context and the size of __unused. The
  conflict is easy to resolve, by not modifying data_avail type. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 6 ++++++
 net/mptcp/protocol.h | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e4d446f32761..ba6248372aee 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2471,6 +2471,12 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow)
 {
+	/* The first subflow can already be closed and still in the list */
+	if (subflow->close_event_done)
+		return;
+
+	subflow->close_event_done = true;
+
 	if (sk->sk_state == TCP_ESTABLISHED)
 		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ecbea95970f6..b9a4f6364b78 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -500,7 +500,8 @@ struct mptcp_subflow_context {
 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
 		valid_csum_seen : 1,        /* at least one csum validated */
 		is_mptfo : 1,	    /* subflow is doing TFO */
-		__unused : 10;
+		close_event_done : 1,       /* has done the post-closed part */
+		__unused : 9;
 	enum mptcp_data_avail data_avail;
 	bool	scheduled;
 	u32	remote_nonce;
-- 
2.45.2


