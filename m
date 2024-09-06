Return-Path: <stable+bounces-73732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0F696EE1B
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 10:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563AF1C23DD6
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 08:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C1114B945;
	Fri,  6 Sep 2024 08:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IscO0Gnv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD39345BE3;
	Fri,  6 Sep 2024 08:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611462; cv=none; b=H0YQonmTaz8Kk5MtqpBok9Sw8C3loAH0DJUSc8jWgAHgnELTz5kVFTtsWi0RBb/gwb6v+HVGmttnERIHByCRTWIWac+iJv3mZMfRSsDWDzGfq5KAwSBTE+pcOgGOMInyc5CvNul4ZW9+6zLGcBMp4uPDiAmbLBqGQPCJvEEgEw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611462; c=relaxed/simple;
	bh=vXIUxzRMJ9Z7boIYDh+xivmH8nAWtFpVm/ABHyMYblA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jgNMBKsGXO8dM7Q2o5U9gb49Nr1N4YGvTTiPn7nj9gwfKHbZjUuIgH9dnNBN0+vjblZ7ptsZLStPwX/eZYjVb2WTkDqWmDkmeHju611A2gvBHxdk1fTPr1oz9tM2VfeUVwjVAQnh6M5nytJhH2/slQY4glymTE/MhZM+EO8ahXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IscO0Gnv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10F6C4CEC4;
	Fri,  6 Sep 2024 08:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725611462;
	bh=vXIUxzRMJ9Z7boIYDh+xivmH8nAWtFpVm/ABHyMYblA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IscO0GnvGDCmcdOa460/Zyn4vfYNfQMDS1QMokzKLbs35YXis5UlpHrPD1QG3NUnG
	 6gvJZOC7SDDlQDuWXJOjB7kw/hjt0YQ8qxS7bpi2OmCN9VVJBRxEFt1jSNm+GWEq7G
	 nlPrOpNgLONGIp9ObzRhUeuKUz1DMmxZ2YUhabIKfY8gT6SO8nwb5UIxqU0m8jQ5KZ
	 3KTZNayokzYVtxQrESrREPM+ABNb3NaG/sDBepn9vabwdBkRGxLYYlz+I47PF6UBYq
	 9ikIbd5e/yKN2v1qF/inn4C9KeOYNRrTzmFT2+aAhRSPu6b5sPj/RR1nTWjMWpNL9F
	 8+2m53iFhMXOA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y] mptcp: pm: check add_addr_accept_max before accepting new ADD_ADDR
Date: Fri,  6 Sep 2024 10:30:44 +0200
Message-ID: <20240906083043.1767111-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024082608-cornmeal-stoop-7021@gregkh>
References: <2024082608-cornmeal-stoop-7021@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1600; i=matttbe@kernel.org; h=from:subject; bh=vXIUxzRMJ9Z7boIYDh+xivmH8nAWtFpVm/ABHyMYblA=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2r2zwT19Zhfj0uYv3FEsrINhtm50d6ubka6sr 5o+PhSwgEWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtq9swAKCRD2t4JPQmmg c0DWD/9h/SHTdA4sPymXvnwANe1JjgqUt8Olw4XvUYdK6uOJ0asemR84U7IJl1Fm0VY2LjaYAS9 pUE7oHv3k3OOOzAXIsGiB+zLOpHYobDE9UzejPpachXDSloE5Jxo5qhksbKWm86CQwhH9ZrHaPm a7qQoDdwWiGt/z+Vt5uIT2l5r8FK/X6dkV0jqedQOaYUH2Kg0eaqNotTcGHSqHwZbn62v7mI9Cn UOihdZnzLG4Cb08Dk6UwW3jFSu7O0WGNpE43I0paiPHPnqXbf8pUsexjo4iQ+GhvJyc4Lm3V2F8 KycFEdwHhJNfaKM+kMwjzkq17lVp2Ic40QM/z8xOONq4koM/DOrLT1RZ7Cj6cu97W4T+HWM4XTa LsqO06jZeQxCY3xUSMJOnoMEEK7E/XPmpWsQ4WqgMRsnYk2PniVHf9qslkC6eRRjKIYVITf+4sX FwotXM+EIMyOtcZtJDLtdl1CKXH9j5Vpkz7TZcSfahmCNsxWTtI/pbeez+aC7HdL+n2M88MfEpA khG1mUGSVS3sS1ct8zt2GIsP8QDweqqbx80YkYqqipyhwj7F5P0kzlYA/MwPdUa4mFhwKkWUSxw vNHMAcVHWg2XwLgdmZf65w98o2h0JmPvwexwW1DFNaicl5AFOAHR7wUETBxFTwKsJF0MyfpDEnT hiZi73uqo55fWrw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 0137a3c7c2ea3f9df8ebfc65d78b4ba712a187bb upstream.

The limits might have changed in between, it is best to check them
before accepting new ADD_ADDR.

Fixes: d0876b2284cf ("mptcp: add the incoming RM_ADDR support")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240819-net-mptcp-pm-reusing-id-v1-10-38035d40de5b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in pm_netlink.c, because the context is different, but the
  same lines can still be modified to fix the issue. This is due to
  commit 322ea3778965 ("mptcp: pm: only mark 'subflow' endp as
  available") not being backported to this version. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index eeda20ec161c..ceeb5fbe8d35 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -772,8 +772,8 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			/* Note: if the subflow has been closed before, this
 			 * add_addr_accepted counter will not be decremented.
 			 */
-			msk->pm.add_addr_accepted--;
-			WRITE_ONCE(msk->pm.accept_addr, true);
+			if (--msk->pm.add_addr_accepted < mptcp_pm_get_add_addr_accept_max(msk))
+				WRITE_ONCE(msk->pm.accept_addr, true);
 		} else if (rm_type == MPTCP_MIB_RMSUBFLOW) {
 			msk->pm.local_addr_used--;
 		}
-- 
2.45.2


