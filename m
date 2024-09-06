Return-Path: <stable+bounces-73739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EA796EE36
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 10:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07825283D58
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 08:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E59C1586F6;
	Fri,  6 Sep 2024 08:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRzzHZKv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3AF158205;
	Fri,  6 Sep 2024 08:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611648; cv=none; b=ibTePDeIMmzzLRmNboRqeyNuNUa8fgiHvKWTas2fmOrbMB9t6ZOuUz1epH5KiVjaW0gjMHPFznChfyUDPfl0nS36yBJI17UyjGcrt1a8AlTcoK8QTB2gklgxGJ1Ow4MDWfzRkYq9Qrk7ERvMv7ib0uL9AEQiPl40f210E4NHY5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611648; c=relaxed/simple;
	bh=msOhCLHQAnviP4qqZ5mldMA/Ycr6OiWnu7FI+li/UnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qhqkh4qghsSDa+8qWNhX1lq7nloBD4VjyP3QBMOI9YhTXiF29LGFgGvu5RfxM/cfmwXNGrclQV3x5FdJ9Y7f9r4gwEiCHtISJn11h31+MUAPHIzsLUXycWjC2PIji7vL3JZzmpDPj3pLwW54LmU6oVGFHLcz9e0R0pgd30hoa80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRzzHZKv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036FAC4CEC5;
	Fri,  6 Sep 2024 08:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725611648;
	bh=msOhCLHQAnviP4qqZ5mldMA/Ycr6OiWnu7FI+li/UnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JRzzHZKvdKe6I1giGLMt3oPc7q+ocHUages4IFPB0RewXOq0XHGBDIpeNYEoE0HfX
	 LHxnQ8ztuNLseKV2OQjPbrj0qJsU29rR8aUEPfBDqa1vSfutUyQvJoXeLmO/qOTIuz
	 DZz74VFiyLPufAsqzu23x7kC2YG5Nhq09JoU18abOJ+VBzYYkUGLDJO3Rc50FAVcbg
	 xM80JXcHc3ULZq5X9D+bCwXTIFE0N9cbVWogLF8oNHM9DisUKHmRQOsabyRc7nXla3
	 dTlZ/fFyYI1XP2Ofpm1ASQykWqPdSauPbGfHB1DpLp8zxjvvQ/HbKLSFhlh6cRDkys
	 V2oZ1Uv8JEwuQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.15.y] mptcp: pm: do not remove already closed subflows
Date: Fri,  6 Sep 2024 10:34:02 +0200
Message-ID: <20240906083401.1771515-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024083057-italics-abrasion-ab81@gregkh>
References: <2024083057-italics-abrasion-ab81@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1391; i=matttbe@kernel.org; h=from:subject; bh=msOhCLHQAnviP4qqZ5mldMA/Ycr6OiWnu7FI+li/UnA=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2r55dhBez+TTaQhH6AGCMXC0FfxsFxciWbS3f ki+MQOVpiqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtq+eQAKCRD2t4JPQmmg czmvEADhPPiyKc+ULXoeF8YgnRzc8I8kXyPZP4jOlyDi4waWfntXdIcWxR0CpSxI656/EUi3dKM grTgKJGfdn/TXujme1bQ7karoKSeV82dkvzRD4d+vo0466SUiwRyAi37yzC3ktrN4mzzYCxZ0cw kGoVHjaMNYSzj833WM2OZCSmLaO2hdDq5xySudRurK62tetyrreUY7PDs7rhdT1KjnsegFqSKrc ack6Irwy8rZPg8gQd/ATB7aanBBGGrFXXdNCLiKD6J5QH5usgl8eeNa8xyHYo44Lauis1JM0wju kJOT3TtSP30rE1ozP/aotNvJs8X6sy79VAqWN5kvlYBhsNMKjnmqEAjA9rr19oKE0PwM6rQUMzW g858iB8d/HDCqjUGf2urwRI7jR1aer7ppkh9nC4N67znEEQdbgCkLssVVK4YDOq0/GdFuOYERiM dR/KUKMUtQ194VmSoNIXSma4H5zy5IP7+guzZOMyt49BJw53SHUWtXCZlta8+5TuRcwyr+V7gHp skRWFJKt3v2o6Ztf+spw0ArgzvTdNHfEegpSRN/fI+igL8+rUSTFYO+YXdK8mhzCPO9aSRbtW9L PhmCLXF0kWrOS0o20f3xQIf+Vywf7vduyOTqtVPeqs0eSRX3E7tsRBURua6YsUeL3h20ZULuEHZ RCPWDJhQMpPF3zw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 58e1b66b4e4b8a602d3f2843e8eba00a969ecce2 upstream.

It is possible to have in the list already closed subflows, e.g. the
initial subflow has been already closed, but still in the list. No need
to try to close it again, and increments the related counters again.

Fixes: 0ee4261a3681 ("mptcp: implement mptcp_pm_remove_subflow")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflicts in pm_netlink.c, due to commit 3ad14f54bd74 ("mptcp: more
  accurate MPC endpoint tracking") which is not in this version, and
  changes the context. The same fix can be applied here by adding the
  new check at the same place. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c77e596c477c..6df7d62f6b44 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -763,6 +763,9 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
 			u8 id = subflow->local_id;
 
+			if (inet_sk_state_load(ssk) == TCP_CLOSE)
+				continue;
+
 			if (rm_type == MPTCP_MIB_RMADDR)
 				id = subflow->remote_id;
 
-- 
2.45.2


