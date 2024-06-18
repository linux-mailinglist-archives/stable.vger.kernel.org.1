Return-Path: <stable+bounces-52670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1EF90CBA3
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 14:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78C1C1F2390B
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 12:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA3A12DD92;
	Tue, 18 Jun 2024 12:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiBTeCBW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A549D46557;
	Tue, 18 Jun 2024 12:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718713520; cv=none; b=l8chQo4hnnytDVL4O70VyrSH1BeJk/wgNg0y4/d51zzpTZyJVFZqxxK/08GG6XDTT5aB/cTlWCnhkv/AnOc9/OZ2PBIcszLW/MftmRhbR45fi+sOotNbzDqwDlOK9GhTV6gCu3wSVyO2l0iQFgnEZapAoXadbd+WAXsIgaVP1ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718713520; c=relaxed/simple;
	bh=vvjt/xrgkUknL/l5ukycu67BACL4HqpMDjRbtvqYVqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h7qw9pR+WrAD/TDqGKX4WJ4nvX5thm9e83o58IMYw3/27DH1I1J4X5UcOJtX3uH70nopKy0x6kC7OiZoePFUaPIdaKw2hmbZ4pNb17i5qskJvdJazCzDOIiD84sXCEQFJq4hMmylY+25jRUWArYiqcGrq5THF8pWd6krXRub/Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiBTeCBW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65CEC3277B;
	Tue, 18 Jun 2024 12:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718713520;
	bh=vvjt/xrgkUknL/l5ukycu67BACL4HqpMDjRbtvqYVqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YiBTeCBWt3IkBCpO0Jhl206T++X+qlVaXc5f45NBpzb4i96s+eYKIPBEzfbU5JzE0
	 JgYld/snfz8vFww3lfUEp5YJU4mRyvuLT+EGnLeHPLZmZ8KyoibbYWnwrbyp3rIqIR
	 7dHYHUezVSFNjIz3eELhFUuzXQj4KqyBzM9Su0N565XZ/4PO3ORNB1wl87fRBaac9/
	 W4y5MGHIS8NxpwdEhfjdf9QEqqRbfiUFU5K7S97DOj1mxLJjRMDPWmg7SfStQUSeyK
	 uHxl+2k0mylQHVvLP0NZ4nOco3vhED4KZo3OIfvQDOWvnXI5Qf+Kp2c1+fAVxcxj39
	 Gye9atMaWGm6Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	YonglongLi <liyonglong@chinatelecom.cn>,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10.y] mptcp: pm: inc RmAddr MIB counter once per RM_ADDR ID
Date: Tue, 18 Jun 2024 14:25:12 +0200
Message-ID: <20240618122511.640963-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024061738-bright-knelt-4f2a@gregkh>
References: <2024061738-bright-knelt-4f2a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2502; i=matttbe@kernel.org; h=from:subject; bh=GwqGFxfs8D45Bw8qyQMy8onc6jEfFvu11qO4ZJuAEdg=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmcXynZyRT8Gh2IPexLpvdVuf23Sl6uHRtc4N88 o8uLL/dLx+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZnF8pwAKCRD2t4JPQmmg cykjEADYmcMzlsfm42VFnxvYcLvzoAG/Tp5znyhXhfEzr3ZfslFzM2WrEbMSUQSW8ICMQZ25xLS F+WxOpCHR71DcY6AJgCfivzfKWfgu9r1pOYpek0biH4Z01N2/sOS1tk7uBVHUTEvyffvN40QJ+4 QmxEpNKSJxti0R61B+ry1fi5kOXi9VhR5egKl4oHr0R4MUwdIXCs2uCK1CQZs9SMqjPyLuJvp36 7x8HJP/0Lgkz0e9dLlkd1BHr2M1HWHsfEoG9bdi6ZPNYZCLkr4nHBU01HA7KKtVCZj7N/x9SM4F GNF+QHMNNYRr5zKRQV3RozZ6oyAmkmbGLVC/unNUEIgRX72VmAuMRUUvP7p1avuRhQk/yhIvyXE mjfouNa/QEwblnURhS3DNEdprNctaXZ4p0Bq2Oqn4O4KcY0j6zcQxiDHw+YZFECklDPreTJDBDs RA7xe6g+r5jKtrBLNKUQhbjFPaasqqGx19BYAuIqsTjMzqJP4r5jPuqhOoVrMQO5JqdT2vNmkYE qTSYJu7T/hoxAycibVC1XMe4AAGWHiHvpOlnT5hkOeqEaIWzgz1XcqsGlfQfCt6TX56FndVEytZ Qux7eEsRK1M45ui7/7mkNPQXgeSFFjSF0oW7NYgaIxS1GJ8Q3b5kDUZuJrObiv71cFNDX7+2+hr BYn2hfuVDjGxT4A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: YonglongLi <liyonglong@chinatelecom.cn>

commit 6a09788c1a66e3d8b04b3b3e7618cc817bb60ae9 upstream.

The RmAddr MIB counter is supposed to be incremented once when a valid
RM_ADDR has been received. Before this patch, it could have been
incremented as many times as the number of subflows connected to the
linked address ID, so it could have been 0, 1 or more than 1.

The "RmSubflow" is incremented after a local operation. In this case,
it is normal to tied it with the number of subflows that have been
actually removed.

The "remove invalid addresses" MP Join subtest has been modified to
validate this case. A broadcast IP address is now used instead: the
client will not be able to create a subflow to this address. The
consequence is that when receiving the RM_ADDR with the ID attached to
this broadcast IP address, no subflow linked to this ID will be found.

Fixes: 7a7e52e38a40 ("mptcp: add RM_ADDR related mibs")
Cc: stable@vger.kernel.org
Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: YonglongLi <liyonglong@chinatelecom.cn>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240607-upstream-net-20240607-misc-fixes-v1-2-1ab9ddfa3d00@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in pm_netlink.c because the commit 9f12e97bf16c ("mptcp:
  unify RM_ADDR and RM_SUBFLOW receiving"), and commit d0b698ca9a27
  ("mptcp: remove multi addresses in PM") are not in this version. To
  fix the issue, the incrementation should be done outside the loop: the
  same resolution has been applied here.
  The selftest modification has been dropped, because the modified test
  is not in this version. That's fine, we can test with selftests from a
  newer version. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 0d6f3d912891..7472473605e3 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -427,10 +427,10 @@ void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
 		msk->pm.subflows--;
 		WRITE_ONCE(msk->pm.accept_addr, true);
 
-		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMADDR);
-
 		break;
 	}
+
+	__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMADDR);
 }
 
 void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk, u8 rm_id)
-- 
2.43.0


