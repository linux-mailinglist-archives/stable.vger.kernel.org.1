Return-Path: <stable+bounces-73005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E3C96B997
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 13:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB734B23D21
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 11:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375651D0160;
	Wed,  4 Sep 2024 11:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jw37PH6v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61AA1CFECB;
	Wed,  4 Sep 2024 11:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447799; cv=none; b=kKJUajkT2KOcaEwmI2TV5Ii+R/znV4k1Y6qSFXLrmVvdgLaxwztE8k1nGj1dpFB1q8RCENdw33chzTRg5dHlUMIf5Qob79fNXIg8SfYVAIPI13AttRA+5G2UHEd3gDU7T85hTI5ApQvdnO2dMqx8d5afsyLezGUcQ7UON8X7Ge8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447799; c=relaxed/simple;
	bh=ftGq5/zhSqpqgd3h2SqOmjFU0bHUZidkAU6bL3ixTKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VHmv3OSZcLJq1P7zTrzx9ZZDPaMgqzJPHmPxaFEWrGEszmKuGxlpKj6kVggk8c7iKpYMmjcSh4J6Xf0/qD6/asSiiTZcNSm/ItaUN2QhCQcss8uZ52yzVTSSioOnakaMyJPKxm4b8pG9wS6SzC7Tv7RZJm9Lh5C8Eq5dF4Kqmlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jw37PH6v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F1EC4CEC9;
	Wed,  4 Sep 2024 11:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725447798;
	bh=ftGq5/zhSqpqgd3h2SqOmjFU0bHUZidkAU6bL3ixTKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jw37PH6v4HtCd6oW9ozXUcWsEl33ljUxc9hH25/vKt8u2zpcvVbOHlEKXZRH10jNs
	 WpkGEjAfWXcFeN3hnKd+zOXpK2zQKk3o08/1ricPv9UNzdCOsyCNchUSeQgltL+XbF
	 UvPAQcDDND8PU/TsZ6zFgK9I7PeXxD2kWr6kwWPn+e4drccdBuv1TDyMyx1md+cxhW
	 XpczxqkkqnKjiFZOGre49rrTg2aq3gFH/PnLrXqJDVYSgwOSo/tml/XLEJsD5xhn5K
	 ZrB3FAfSrB/UMhTlrVWCAo2HJTyUe2A5NfwylaCtXE0AGLhEpRPG8Z6BxlPGyL0qHo
	 Hdp6mRBIWP7Xw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.1.y 1/2] mptcp: pm: reuse ID 0 after delete and re-add
Date: Wed,  4 Sep 2024 13:03:08 +0200
Message-ID: <20240904110306.4082410-5-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240904105721.4075460-2-matttbe@kernel.org>
References: <20240904105721.4075460-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1705; i=matttbe@kernel.org; h=from:subject; bh=ftGq5/zhSqpqgd3h2SqOmjFU0bHUZidkAU6bL3ixTKI=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2D5qQBa7SeF0c4FMoAy+BIJuPIGV3k2TjaZUU xl/Us9S39aJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtg+agAKCRD2t4JPQmmg c2MdEACMWLQSbH11400BAsAY/u6VaoW7bRn95YIjU6zLO8+m8mBV26p3IIYeP3DmHDGDi2evgK/ tmK0B+b8GF6tkcq5VYdoaU407KJ4hyfD9GSQngBK25qZwLITdQhdDm+qKEPtp0Fpl8KqRjzJTcd 2VigpFtv/ojVnX2bEBT2K1e+O4iNUymGEhXWQeAiP88+cQmwI8mz4/waEC8FEntD6FSGVPi6uTx L9sXrUkuqOnBxqH3rT3Dy0xlseHC+OFHUWbib5mKqYlDZU8eRVzAyiAC+GmzfuGzQy9GrJl9JLH kxIjo+6HHS+DHSDWOKArEL9z9KExy0Q30k1y/Pj6OohWvDNLSbGvJXDIOf7r1ZrYDpbJI1MCBVw +jXTBiWcY97EjdksR40wO99+W998bn8WJ49XnI1sEMi+N/V8xi+5gE9ZIY11oYHJlsc9Mc0rskx 1aApk2EwqtqSqYm737AYTqatAL9hslzldf8mSV+q1kxK1Tq5Ikzlp7LdsmrPeNyUOYiIdrd/mse WPb7LhQzxcyY69woyZwzvHMm30JjEyc9QjtkvO8VES5wKlzTDW/w6j2dF6sO7NfEk/zWEnxH+f2 Bk236Sns+07w0iY1ByMvbqySkdHDTHR0KdPehyytTGA8YSmGE9HHgG70lTkf6OztftmW0/LfQqi 9ixCP/biPKEUc6A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 8b8ed1b429f8fa7ebd5632555e7b047bc0620075 upstream.

When the endpoint used by the initial subflow is removed and re-added
later, the PM has to force the ID 0, it is a special case imposed by the
MPTCP specs.

Note that the endpoint should then need to be re-added reusing the same
ID.

Fixes: 3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 44b036abe30f..c834de47bddc 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -600,6 +600,11 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
 		msk->pm.add_addr_signaled++;
+
+		/* Special case for ID0: set the correct ID */
+		if (local.addr.id == msk->mpc_endpoint_id)
+			local.addr.id = 0;
+
 		mptcp_pm_announce_addr(msk, &local.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
 
@@ -624,6 +629,11 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		msk->pm.local_addr_used++;
 		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
+
+		/* Special case for ID0: set the correct ID */
+		if (local.addr.id == msk->mpc_endpoint_id)
+			local.addr.id = 0;
+
 		nr = fill_remote_addresses_vec(msk, &local.addr, fullmesh, addrs);
 		if (nr == 0)
 			continue;
-- 
2.45.2


