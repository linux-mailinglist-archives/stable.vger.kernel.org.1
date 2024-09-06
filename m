Return-Path: <stable+bounces-73738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A7596EE2E
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 10:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2BD1F213AE
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 08:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D6714B945;
	Fri,  6 Sep 2024 08:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqS8gYgG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A89B45BE3;
	Fri,  6 Sep 2024 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611624; cv=none; b=Sre0X6eA79fuuCSj0QwnfDZRifpjjLFMbIYgDRlByR8KYJTBClBydIc0k66NTej+n4G5j6rjUSfiOs9JfJjAa3Ri7dgbQxT1e9ziOxzFu78yDw/47roDd/DoUa18H2Whtf50C/uxeBm4JQJ4qMOY97XqnI7xpcXNxI1csg0wy+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611624; c=relaxed/simple;
	bh=+43lC+IotDcCQ/HqmooJFtOF8zqmp8xIJqZt3Zrhw60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=moGMVRXzvJdyOLFl3E5wzAFxMxgTKxE58PQZwan2v53vnM//GD2vahGW4fgnRhCcEShEF+qfTxgVhfFtn5JrejEXVuaF0layee6npY9wPDUIJekSJiDUvsLrbKoibwGx8aIV56TMnH8XLcxsvjAhyeW8aesNkzCYFlXnbLj1PTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqS8gYgG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F48BC4CEC4;
	Fri,  6 Sep 2024 08:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725611623;
	bh=+43lC+IotDcCQ/HqmooJFtOF8zqmp8xIJqZt3Zrhw60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NqS8gYgGKJ9cIz+QCA4hQX6TTUaCdeTlU/Ks7vgK8VI01oi0W5teeURgFEon3isL2
	 NZodLyiNuOAz1WoAcVJTCkCrtplVNFHyRDkA7OfR+qRY218iKmYu1aVAIDQ6HJVy6w
	 wAmgraVdVz0qvluVHyUs65KLliBwkSyXtvf30BKTS3ppRBoah1hcOc/9qvzQFJcXMh
	 Iu/MEc5lpyoae9aMNDbKTLy8ccuSwl+m4Fe+tnIEIZw++nPHFIXfWzRuZsb94H95kU
	 UM+ESPH/97xjUif4lt6UiL/qAHorFMhVAuKCKUcKgc+aLJz3boQfkJjuQiRPX4bdV+
	 ZI3/EkAdm0Beg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.15.y] mptcp: pm: send ACK on an active subflow
Date: Fri,  6 Sep 2024 10:33:35 +0200
Message-ID: <20240906083334.1770934-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024083031-diffuser-strongbox-b85f@gregkh>
References: <2024083031-diffuser-strongbox-b85f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1999; i=matttbe@kernel.org; h=from:subject; bh=+43lC+IotDcCQ/HqmooJFtOF8zqmp8xIJqZt3Zrhw60=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2r5eD1+BUUb/TyU04WugnF98L/ZT1jR09fIkE eO5sUWdQiqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtq+XgAKCRD2t4JPQmmg cwJQEADZa9zQwtXSCKLZLGGzdzNMZsyxYjUt2hcHiXwiZu2VsWRAjPIKPaPx5eiRV4svq1yOlNR GD3D4D+BJPgPw5C87PpINgcN/v0Vf+8jv4M9zBG3y8OJpfi0UC3KGSEaXMqiS0sQJ+MoKCXDFXV s6YUkT3vmHLj/AySHfI8co2sCrvgrG+GNlzw30qSPyCsQCDMqZCjUCLE7bsgNQQLnwm304CJ1+s dRFh8Lisjgs57ayLTxd/WMxdw7gFs1B/SgmGXWjkzbIoLrsrVN5sZoNn5u7CDwHhYrIVDAimOdT Z9/vqUrN3uC5G5ec7nRlJeBRNP1ZJk2CifBPsejjuL0MN9Q7tXPLtRUEZbRWoap32i7ExjPfxXG KaLKSCgvPqFjVprRcfYKyot9JVr5Sef7/ONwpTNmwXAH1gjiVjqFAsYiGPlyJgrpDt+ggE4Vf8S XiwjJDGQAsvrJ4fBLppB1RkEhBK8Vk1eoJN+AFRR/IJFKMt1xRCpRRA/PnGw4MPnmR7sHAvRFAi h9gMP5AxkPOybGhpGOdXJMlu/MrLuj1BnP5r94sl/dqC7Tzj1zsooQ/Tb598b5Oe5IP/ldJ8nVX /RTY9kCELkXOozujFM4kV92q0PtRNwjV8DiaDe0x8okDNdjBgpQH4M7z7ZOJyyxj7Hp+mqRgmc8 pF8uw71+xYI4wFQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit c07cc3ed895f9bfe0c53b5ed6be710c133b4271c upstream.

Taking the first one on the list doesn't work in some cases, e.g. if the
initial subflow is being removed. Pick another one instead of not
sending anything.

Fixes: 84dfe3677a6f ("mptcp: send out dedicated ADD_ADDR packet")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflicts in pm_netlink.c, because the code has been refactored in
  commit f5360e9b314c ("mptcp: introduce and use mptcp_pm_send_ack()")
  which is difficult to backport in this version. The same adaptations
  have been applied: iterating over all subflows, and send the ACK on
  the first active subflow. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 5622dd05087c..c77e596c477c 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -684,16 +684,18 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
 		return;
 
 	__mptcp_flush_join_list(msk);
-	subflow = list_first_entry_or_null(&msk->conn_list, typeof(*subflow), node);
-	if (subflow) {
-		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+	mptcp_for_each_subflow(msk, subflow) {
+		if (__mptcp_subflow_active(subflow)) {
+			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
-		spin_unlock_bh(&msk->pm.lock);
-		pr_debug("send ack for %s\n",
-			 mptcp_pm_should_add_signal(msk) ? "add_addr" : "rm_addr");
+			spin_unlock_bh(&msk->pm.lock);
+			pr_debug("send ack for %s\n",
+				 mptcp_pm_should_add_signal(msk) ? "add_addr" : "rm_addr");
 
-		mptcp_subflow_send_ack(ssk);
-		spin_lock_bh(&msk->pm.lock);
+			mptcp_subflow_send_ack(ssk);
+			spin_lock_bh(&msk->pm.lock);
+			break;
+		}
 	}
 }
 
-- 
2.45.2


