Return-Path: <stable+bounces-66751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3B294F1C2
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 17:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75D0E1F24E61
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 15:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C7913E022;
	Mon, 12 Aug 2024 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9u1l22Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A51183CC8;
	Mon, 12 Aug 2024 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723476659; cv=none; b=aVxtQh15E7VuzqXUdSAh0eoezLD9by+Ahbh9uKvDN2ZKVKUXGbItn1eDEsc5hr9Ec3X0KHsrvvJ3cQAHcv1kK1GhE5hOFQvhSy4RbmZYqOMoiZmlfebQZzpYCk63ijWxM3AZt+mjQ48E36657uOF+Qz26XlniYhA8UGUZiHtJ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723476659; c=relaxed/simple;
	bh=XvA9ShsfLleKgnLa33PJ/t/Ptnw3c9Xyojg4JBrkKcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AydAMtgrcIuHpZzU7v3z4rg50AwI+wMEQBLvNE7wupiZcOImn+mZ2VmUwgKkgBfE+RsToUarRVDywPJPCmF09POd6Di1HKN82499bI1nL0j+t1QuAs2r4MJNrbQ7wXW+tfoz6OlJ4ZLx+bufogJtY4ZnB4yLV//L9eaRbzj434I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9u1l22Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989A6C4AF10;
	Mon, 12 Aug 2024 15:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723476659;
	bh=XvA9ShsfLleKgnLa33PJ/t/Ptnw3c9Xyojg4JBrkKcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b9u1l22QTzQ9oujNZ9kZwdbdsZFjZYK079CvlqKRE6w12AbxunrNlK/+1UfiFWdlF
	 rsYZkHD8Gd+Fl/8zrVuIKjvbGhLcPC4hxOnlkXkt2w1PEIUYUZgA5I4fZS039nTz/D
	 fYNmowulFYghIisyx7LbAH9pSnjBLgBigcqEWm1jR1GbM2Au6kgmkC/ELvcYlOV1t7
	 gXHR99betBgWcBWwG4pIzyzv1rU5T3gGXP0gFmrtvk1sU5G0XgK/XFXZfEmkx2Drwi
	 2oUckzQGD8qmfPGmJDtYWehN+ukft+BVpHDRdcn74kZCy+mAuI5X/JAbX/bGjVCo0O
	 Ez1Wn0VTSEfwA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 1/5] mptcp: pm: reduce indentation blocks
Date: Mon, 12 Aug 2024 17:30:52 +0200
Message-ID: <20240812153050.573404-8-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024081244-uncertain-snarl-e4f6@gregkh>
References: <2024081244-uncertain-snarl-e4f6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1799; i=matttbe@kernel.org; h=from:subject; bh=XvA9ShsfLleKgnLa33PJ/t/Ptnw3c9Xyojg4JBrkKcM=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmuiqrpfMfXXbaYbWdLaKUT7IT8enOtTdvlTVos 62iFyP0+4WJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZroqqwAKCRD2t4JPQmmg cw4MEACV5PStnCPiD9CVW7RWOHSiRVSrFZfIK8acimCu1DZoezLaDoJ3rgBGoqd9nhscwuWpCIm FIrhoXH6jjpwY7aYO35iaH5btUvuvGNdf8eVL6FflAv2sVAYHAGD7DxTR4SR8/Af2+U9xIN7xb/ gyFrcP2znUVLFMOS8524oaw8k7QnXm6mnOMNb8/iMea72oOsaIt92Ry+b19FSa55YWdM9gGDrzf VLULjozJseDMvoyYmVobOHqHli4yCxCT1FMqhZwM6O4SNBleLJt7Y7VLAH0Z2VMNl0SdTCA34m/ 6s+OEMUwkX7+0djhS5tj93jvKQer2485jzLMfCVK+aeUkMsdGn6Ii0c9Y8go044FqKKLsA8IQxK 5131fJh9b3wlrsFIpPxzNUTM/VrrzU2U9jeh/dkGV24o74dShs8HW7awoRY1aN3w1JwmkUVAjvH XxSIevp/2HAS9NOxPn2N1FK58P21Q4ZF9OoU939KW0Dd2Ve9x9hzMDXX1WHcTsNtWkNAs4fRb3v tSUb6LDL2R9VYjZ29TyyWsB/1Hsdjm5MA7lpvfvto2f+y0kREt7eRSs3Nsdysk08E7oZPKnH9Yx S+fJKIwK1eCOAly0tuezB+Leav76qGWkssu/8Pz/1+JTlvVMGdbTPKg/2Ojh3Jx99qhUU58F76t AfOmG3ojeBfQ6zA==
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
index be4be3bcefc7..6d5c75a40bc6 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -575,16 +575,19 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
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


