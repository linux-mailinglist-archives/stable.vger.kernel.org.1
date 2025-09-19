Return-Path: <stable+bounces-180718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0656DB8BA10
	for <lists+stable@lfdr.de>; Sat, 20 Sep 2025 01:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C03BD5687D2
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 23:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196A826F2B8;
	Fri, 19 Sep 2025 23:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSv8vYv8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AAE3A8F7;
	Fri, 19 Sep 2025 23:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758323879; cv=none; b=sh10Mt7oFY55BM84PW+Ei5axDLEg5t4zE7zhYB+u5nBouLcIv7pV6hDqvr8aEE7eb5FfHA2OjnH+GN2nrEfKe/786McUMIyTqeu5CzydBHhU6jSGCQFcnFtptGROXy9aKAMoB5DkAtxLHe2CJV2qY/NPqi3meIKlGPd9QaH4DmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758323879; c=relaxed/simple;
	bh=yqWv3CNDL08xp4p+kdg/TKGrfq3BXsP5TSxnrZN25Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jhzSwio5BV1LqhneeWR4clcnquD3rJsYjFukQGDw3UfNhcih/Js6D+tyRVJo7N41ltaSRmnc24lk7aiZmunYAviPt7QGKD4s65LA2uO9R2mJIYWQROJ5lz9cas+lkurBfDjSRt7scN5qRXZOEOUkdKocPQIbMY3N+yx4SkmJB20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSv8vYv8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8C4C4CEF0;
	Fri, 19 Sep 2025 23:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758323879;
	bh=yqWv3CNDL08xp4p+kdg/TKGrfq3BXsP5TSxnrZN25Kw=;
	h=From:To:Cc:Subject:Date:From;
	b=WSv8vYv8he/KQqhiWCkFITHOhLWnVnXgalKT3SlrXWabZ8nBIumNXRcsZh9lZSNl2
	 +8juidt3M8QoHAJsUUpmP5zuW/s1DIYUzi4sBIRNbQlOhFPX8hT9zIAoa11n9ZcQ3/
	 Apz3dw9a66JRd1Dhvh09fz/ETAyTS/59ITUhl9bkz+3FgHRxa+HMBT2zVwEcKvbpdo
	 ddnMvnLxuOLbhx78MWNCWZ+t9dgzbLNuJz/W/cvhnemUMugTsjVOUtYRwQhBfaZBlI
	 re6aEQIwRjNdRErRXIyrXuIsecrERzbcPpseFfWkFGrt71QpPKzIOEMbFY3KYz89z6
	 FjulSqamCyOJw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y] mptcp: set remote_deny_join_id0 on SYN recv
Date: Sat, 20 Sep 2025 01:17:44 +0200
Message-ID: <20250919231743.3957803-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1824; i=matttbe@kernel.org; h=from:subject; bh=yqWv3CNDL08xp4p+kdg/TKGrfq3BXsP5TSxnrZN25Kw=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLOPpmxYdPH7uu8U854BEX1n+f8wvJSb+o557kfIiO0X X1+qNrf6yhlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjIJT6GfyqLvP24v+TOcloQ +Iz9YtKGprf8nC8DwjJeTTLkMpi+7wQjQ4tm9tZ+ifWOllemKHD3B27WtFZYo1vIztJeOWm90jZ mBgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 96939cec994070aa5df852c10fad5fc303a97ea3 upstream.

When a SYN containing the 'C' flag (deny join id0) was received, this
piece of information was not propagated to the path-manager.

Even if this flag is mainly set on the server side, a client can also
tell the server it cannot try to establish new subflows to the client's
initial IP address and port. The server's PM should then record such
info when received, and before sending events about the new connection.

Fixes: df377be38725 ("mptcp: add deny_join_id0 in mptcp_options_received")
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250912-net-mptcp-pm-uspace-deny_join_id0-v1-1-40171884ade8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in subflow.c, because of differences in the context, e.g.
  introduced by commit 3a236aef280e ("mptcp: refactor passive socket
  initialization"), which is not in this version. The same lines --
  using 'mptcp_sk(new_msk)' instead of 'owner' -- can still be added
  approximately at the same place, before calling
  mptcp_pm_new_connection(). ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6bc36132d490..f67d8c98d58a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -758,6 +758,9 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			 */
 			WRITE_ONCE(mptcp_sk(new_msk)->first, child);
 
+			if (mp_opt.deny_join_id0)
+				WRITE_ONCE(mptcp_sk(new_msk)->pm.remote_deny_join_id0, true);
+
 			/* new mpc subflow takes ownership of the newly
 			 * created mptcp socket
 			 */
-- 
2.51.0


