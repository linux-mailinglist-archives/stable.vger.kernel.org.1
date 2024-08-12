Return-Path: <stable+bounces-66732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E3494F131
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 17:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E848B1C2208F
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 15:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B28183CD9;
	Mon, 12 Aug 2024 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahlmUOF3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DAC183CA5;
	Mon, 12 Aug 2024 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474964; cv=none; b=VxEMia5ub9CFvZNngn/xKSmQ6T2ktrJVVOD+pbKzIRnOxYIntWJep+EsR6xrGH80jDkxr6ocp9rJEbGuOPBdDiGtWk8s/MgJmhsZBlI/iuTuVN0P0yyn0TdHbtr6psZAfC/Gs005ZdT5B7MLO/0KLYQGYJAyV00yTYiL9Y2t0kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474964; c=relaxed/simple;
	bh=p1+EnTok4OfakKfLhpPcbBbrxpAHprlktECVr8QoIDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0XMC6hlkc08ds505hCRxLc2fAAfVslZ3Ekt/rMhiQ+n+Nuibkvf1A611XRkCPrUQhG9xwwu0y+JNug5tCLP8bZ20H8A9KR67Ww2J3DDOQepZFX8ID2cn4PW8v6H0SaphN0BOmbWlv6bOmye9bfG1d5P4rswtHpFOofHuF2PKuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahlmUOF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5827CC4AF09;
	Mon, 12 Aug 2024 15:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723474964;
	bh=p1+EnTok4OfakKfLhpPcbBbrxpAHprlktECVr8QoIDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ahlmUOF3NgWcmpPsrsWTMkgHbi7tAXVz6F4ngS6ecFbge0JElxgM6I2SaPLFEwQ+x
	 H5SP2n8/d3Sdld4TOR7HDUvkiQnTTaeayHAUV9dA/ssU5mnqF/10xFqxMSRjgIHznb
	 5bZ49r0uqYxnZojR4YjCxvU+rbe0aICu2jaxSdAD89tWDfLfdaCAIzkLCILD3n6xZU
	 fxBEl3KZsiJQvz2FTKTdHMOKBbpm4GWVpE1Sy6WS0OD37btJ1sUKzh2bUGu7TCa7OS
	 cm6OCn4ZRQqR/NjVuDsKytTVuB16S82vXembtpiOjkkEq1/X7d0BHzeqnz/XcZx6Lk
	 FDc5/WQ9aXKbA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.10.y 3/5] mptcp: pm: do not ignore 'subflow' if 'signal' flag is also set
Date: Mon, 12 Aug 2024 17:02:17 +0200
Message-ID: <20240812150213.489098-10-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024081244-smock-nearest-c09a@gregkh>
References: <2024081244-smock-nearest-c09a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4174; i=matttbe@kernel.org; h=from:subject; bh=p1+EnTok4OfakKfLhpPcbBbrxpAHprlktECVr8QoIDw=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmuiP1xc6m6HZ30HFivtTCU/90RHYdDmGBKBLiA oA9JhRQXbGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZroj9QAKCRD2t4JPQmmg c5u0EAC25zcimZMEK/udaeOBfVJmbLoqNCX+IXQfbfY3rEgcYRp0/c0WMBo0VIjRbAhLrkfWw61 h+V3pdu4Wx7+20801IOIcBLVrRcdsatLq2t6riN/+SjTg9YUtimV93Sp+Tr1CxQolRPSEZ4Kf5s cuZF54Vxa5r3DhRREfFV1+ugTLPzwGKIWDYArxX6OgWKUBN2GFKU561afJATnmfC6DVb3YJ4kw/ NhF8UAbifKi9fs+l31AIAR1+cApQI3QJtBTMIpR3lhtX99yhGZ+PzvEAmOq4tdz8dZ6sGHvtgH0 o5H8mW7K0/A7nNZ8pqA/0t+3tqTIawgaS7p7cRn1FN3KO83r78e3v8aungAoADYSmv9oLxQVOnw A7s5h+jptOcUe0IRohZLZ1UVBrl1jWHqWPcfCR8BnZPRKT6j1ISsAlmVo/dlRawLl7x1PhHCp0Y 9fWH2hzGGXfPHiq8UpEDQzYqMH4H+q9t6EoaquZ8iDlHw/+qW5TfY4I12ro1LWLGJVO/xGJ5kZS aLMv5hZ5NtiP1bovhYtTMOYG6cTnnI8tQanGrrfds2S527Cjvg4v80YyJtyvCArjh9zU2PU9SR8 GSEkIaP4FnDBxG3wJ1BtGpOx0OGaG796fcN5NtgVpf1RMBeQ2zoOD9l3metk4fRL7LRrZBgCAtu /twrHvK3BjY12Tw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 85df533a787bf07bf4367ce2a02b822ff1fba1a3 upstream.

Up to the 'Fixes' commit, having an endpoint with both the 'signal' and
'subflow' flags, resulted in the creation of a subflow and an address
announcement using the address linked to this endpoint. After this
commit, only the address announcement was done, ignoring the 'subflow'
flag.

That's because the same bitmap is used for the two flags. It is OK to
keep this single bitmap, the already selected local endpoint simply have
to be re-used, but not via select_local_address() not to look at the
just modified bitmap.

Note that it is unusual to set the two flags together: creating a new
subflow using a new local address will implicitly advertise it to the
other peer. So in theory, no need to advertise it explicitly as well.
Maybe there are use-cases -- the subflow might not reach the other peer
that way, we can ask the other peer to try initiating the new subflow
without delay -- or very likely the user is confused, and put both flags
"just to be sure at least the right one is set". Still, if it is
allowed, the kernel should do what has been asked: using this endpoint
to announce the address and to create a new subflow from it.

An alternative is to forbid the use of the two flags together, but
that's probably too late, there are maybe use-cases, and it was working
before. This patch will avoid people complaining subflows are not
created using the endpoint they added with the 'subflow' and 'signal'
flag.

Note that with the current patch, the subflow might not be created in
some corner cases, e.g. if the 'subflows' limit was reached when sending
the ADD_ADDR, but changed later on. It is probably not worth splitting
id_avail_bitmap per target ('signal', 'subflow'), which will add another
large field to the msk "just" to track (again) endpoints. Anyway,
currently when the limits are changed, the kernel doesn't check if new
subflows can be created or removed, because we would need to keep track
of the received ADD_ADDR, and more. It sounds OK to assume that the
limits should be properly configured before establishing new
connections.

Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
Cc: stable@vger.kernel.org
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-5-c8a9b036493b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2be7af377cda..4cae2aa7be5c 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -512,8 +512,8 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
+	struct mptcp_pm_addr_entry *local, *signal_and_subflow = NULL;
 	struct sock *sk = (struct sock *)msk;
-	struct mptcp_pm_addr_entry *local;
 	unsigned int add_addr_signal_max;
 	unsigned int local_addr_max;
 	struct pm_nl_pernet *pernet;
@@ -579,6 +579,9 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &local->addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
+
+		if (local->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
+			signal_and_subflow = local;
 	}
 
 subflow:
@@ -589,9 +592,14 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		bool fullmesh;
 		int i, nr;
 
-		local = select_local_address(pernet, msk);
-		if (!local)
-			break;
+		if (signal_and_subflow) {
+			local = signal_and_subflow;
+			signal_and_subflow = NULL;
+		} else {
+			local = select_local_address(pernet, msk);
+			if (!local)
+				break;
+		}
 
 		fullmesh = !!(local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
 
-- 
2.45.2


