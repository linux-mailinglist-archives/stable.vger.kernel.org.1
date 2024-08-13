Return-Path: <stable+bounces-67438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D43B3950133
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 11:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5B91F21FE9
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 09:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645AC17B43F;
	Tue, 13 Aug 2024 09:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhVPLQjR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2450F174EEB;
	Tue, 13 Aug 2024 09:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541312; cv=none; b=FMMI+tSqhs6x/vgjx+pcemW9w5YzQoHQo5htD5Xk6rDxxvCBxZnE7+PbApaYoqc3/FWGkFhEVxiVmsBEUFy61VdIIDGUPwrXp/vEP4+NuL5Dzhvtoc+BmkbcSFCBOZPFl5vNu0wv+7Dn8JCslYlPMbmisjgsw6qfnZoMCLheypo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541312; c=relaxed/simple;
	bh=yjsbbHhtcFEWDAWtwm0nUaQofDZjvjZwEONa1shWqAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EsXzV3tz6usHPSuzmudUK7PeAXYVbsc7KnnW70rxD8+soWrXXI/+NGnLkve2w6qOrO4pbtXMzk6FzkiQ0LELK+HIyt67ZlSxG4mPGRpYHdl8q5vK68JVIthX/pBR2HVrOzYYWc9Ke7SWiEo+Q0DwEQtOg2dyWGqx99IkyqJtArY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhVPLQjR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128A7C4AF09;
	Tue, 13 Aug 2024 09:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723541311;
	bh=yjsbbHhtcFEWDAWtwm0nUaQofDZjvjZwEONa1shWqAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dhVPLQjR7sZxPwIbf2eVcpFh1ronpMpNaYsStONlQOV/F6At/k7e9cmCSCP/uwhXS
	 vgMdlfq7rAUAhT2qNlqv+ZGiukEiDze6irBhHLctRAFnd6lq8d7BjXLjPQasv4RJHQ
	 YsaJKVQM/sAnoS3K0woLobNv6G04kp9w0q1dsg+nLx4cuA8u1zI8Mj+p/BFFboDHrh
	 wTGjqFNgNcarMOeYvSLs2ZgLUxXZKVomfJlI/N+CkdmoxDzmlH1jWYKsfewJh4FddL
	 /HPeoaAa90x0LOQaN08u/pgltcX+Laq+3gEJmMet5Tt42Z4CRU8bqcJKeTF6n6gtfO
	 7CN2ci40v2hwg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y 2/5] mptcp: pm: reduce indentation blocks
Date: Tue, 13 Aug 2024 11:28:18 +0200
Message-ID: <20240813092815.966749-9-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024081245-deem-refinance-8605@gregkh>
References: <2024081245-deem-refinance-8605@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1799; i=matttbe@kernel.org; h=from:subject; bh=yjsbbHhtcFEWDAWtwm0nUaQofDZjvjZwEONa1shWqAc=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmuycvnlv9BnggkC6JgMWKKzjjm/96txQvWw/Lf d132kJMQ8+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrsnLwAKCRD2t4JPQmmg cwFdD/9Zo6RHnLB5dw56H65E8sMwErjvi+ONGqcos9dLmOkdiq1SmXeoQmh38+FR3/rp3K90UWD bqabqSZ7TDjB8nGbVinSWqaD7KP5272zq6n5x8eoKzWuzclmhXqtzV9NQecwU5UCOQ/zVky2svK utOIeSJ9trirdBemvPqd+kVD8Rg8UT3PtQf20tSgvtnwusznHA9A/ZnCYbVuSmnUjbdv5pB6kOk 59Ma2W2oJ3w7/0ZlTu7HmcpPchuqaiC9N6s+m4ChbjOLopuLxkJvD76ESwsRpFxRWSTWTcyIF7X B5xBv1eVXNsZ+vw14wJFqS+0bwsoxa0Q6SIozDxmi5MfIeEFaEPst9QdAMqctonusy//vk6efEf 4o3zlo0AXYaZ60Nl1bNSY04MsDqlXvo+5jJnAmjr0zcqd/WrFi/5h87AvB5uTs+JoxBcaesjRD3 xZ2S/xSkWuCR+LNirxchE0fby/HVwh/Q57WPhFVVfOejRAmvJdia11L04ZrYOga0g0hc7+Jpx2H 97zBOSnyswXKmZQix1KJ/kqDgDncitbfiHelwQ8M7ffcm/yjAwyRjLgMIM+iiUifCakDr3tTTqd qa1mNkQV3LmzVZFGyPg3hwgL1Gr+ZlZ2cVr4TnSOz+TwIc06PN3nA5zOeDzaKPjsdk+pyYlloDk Ih2NiQ90GZkqjuQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit c95eb32ced823a00be62202b43966b07b2f20b7f upstream.

That will simplify the following commits.

No functional changes intended.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-3-c8a9b036493b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: cd7c957f936f ("mptcp: pm: don't try to create sf if alloc failed")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 7891e1a50872..bf1059a9f125 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -579,16 +579,19 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		if (msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL))
 			return;
 
-		if (local) {
-			if (mptcp_pm_alloc_anno_list(msk, &local->addr)) {
-				__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
-				msk->pm.add_addr_signaled++;
-				mptcp_pm_announce_addr(msk, &local->addr, false);
-				mptcp_pm_nl_addr_send_ack(msk);
-			}
-		}
+		if (!local)
+			goto subflow;
+
+		if (!mptcp_pm_alloc_anno_list(msk, &local->addr))
+			goto subflow;
+
+		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
+		msk->pm.add_addr_signaled++;
+		mptcp_pm_announce_addr(msk, &local->addr, false);
+		mptcp_pm_nl_addr_send_ack(msk);
 	}
 
+subflow:
 	/* check if should create a new subflow */
 	while (msk->pm.local_addr_used < local_addr_max &&
 	       msk->pm.subflows < subflows_max) {
-- 
2.45.2


