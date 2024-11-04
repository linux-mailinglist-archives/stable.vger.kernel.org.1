Return-Path: <stable+bounces-89698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F54A9BB4B4
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 13:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE172B23D51
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 12:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3201B85E2;
	Mon,  4 Nov 2024 12:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGVtaJOm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475BC469D;
	Mon,  4 Nov 2024 12:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730723522; cv=none; b=H/D+70PVohk1XlMOpAprBaI9nc1MYivX/RXvhQN36ueWDzNXcYhT0N3zJ3gs0CLMUagi7WmAm4oQOGY5o6Y+nuBThtFat4H8v1kRs/DFFuaTCxTo1tOJyWTyvvVhFf1R748EpYcqyNlPvs7EqTLDJf2fjR0XVVPSEgFFn1lCVwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730723522; c=relaxed/simple;
	bh=qb1Yw/hyudvrD5WUSCNH/6LxaTrdh4HS5CPv8u0Lw4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cu1Zz8pXwdHHOY4Ubb+fD2l05ifbrNFh4GbD7FUvNIBHSGBqSpC9Eq/1AelK3t1q9P/IFvjnC0NkGXEHqWtuonjmB+UMtmIqkzlb3Ighk5ZK4eNZ/C4Jg3CUyTjtZInmMV0y+OXkTMM2x8vWkJV64yL4+J6wO1wmiQt7h36yvVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGVtaJOm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B596C4CED1;
	Mon,  4 Nov 2024 12:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730723521;
	bh=qb1Yw/hyudvrD5WUSCNH/6LxaTrdh4HS5CPv8u0Lw4s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uGVtaJOmXxmCmnpA41QRtU6rnMcAx7N4PLueMqNj6jQ3q6dIkmwpr27jjHq02opQW
	 VgGlrXbwPKbBEBy1a5pR9PUyaDd4MD3zrF9psBLJGg4cdu8W5drRX0KSCRnpQvZkBk
	 CKrxHJru/Ij6eqj2me7geYo20jNM3a9SNRZTRb1v7b8A9sFF59Bx6+Q22+Vsh4p6ND
	 cUr/HgRYjgVqlSn4bmUvkusI3WIMA+Ptg7mkpB3WtSxslhVGVP5S/4JbLWAJ/7eE4w
	 Szkd5dFUMch8W3APKYJL1D+s6rp0JF0UbnrwKc+asPoUXHQq+s0vKEtXb6Xjglf4KH
	 05ArRyUCSkt7Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 04 Nov 2024 13:31:41 +0100
Subject: [PATCH net 1/2] mptcp: no admin perm to list endpoints
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-net-mptcp-misc-6-12-v1-1-c13f2ff1656f@kernel.org>
References: <20241104-net-mptcp-misc-6-12-v1-0-c13f2ff1656f@kernel.org>
In-Reply-To: <20241104-net-mptcp-misc-6-12-v1-0-c13f2ff1656f@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Davide Caratti <dcaratti@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2082; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=qb1Yw/hyudvrD5WUSCNH/6LxaTrdh4HS5CPv8u0Lw4s=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnKL67UQ+EOaWNU6EM+HxAIWVAJHOU9fiNVp17t
 Bsu49Pz+EaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZyi+uwAKCRD2t4JPQmmg
 c8RbD/9uPo1eyKCzBkiwNCN3sMyhlCdxVJaQ9CM/iDw6PiNlndWgw1E0DLHv7mGWBbVHIgvAUtY
 t+c0E/EPF1YFZn7FURbe+6zEVZr8vMsbxDtlM/sHQ0DB+4u5SpM0XYQ2wBPQKyiJUGkJo6K7WJi
 ndBSfvrftPYLWjqHTof/pVbm8x4nudWM8whVdOHkrm1veZQCScRXhtfPJ48mkhbmlKY7No7RJ5o
 wkShEElozOCBPLi8dlJPz7azWpLGYxC6KItMY/G4VLpknTPPOIIRB69t70HaHllhEtkSHugOReU
 HoKM2rx9RS3KTgJm0gLDOyGtZdrKVQOF60qrxwCLgrzJRiTBXpLNIjLy+n5C2fTRma+VzFg1GV5
 3PNEXkukQ/WiE65FIklj6j1ZIwAikUjK608J/wWtoYhlxeOU1IVCfpilGKZyLn591Q+xNm4oilb
 VOzYazUXAkuE1XVE8sp2l8kPrE0510Ll1JvRl6WMsFxtUWoYUXgQTFB1XjTSNEctVFnLEDBSVAb
 R4hNSgGNao2SCe54jVqq4zICKKDnuMxfZvRjUrwv3uzWBFwYlRFkaeDvvAujq7iM6Bg2wCAnS+S
 rOc1NZpMUjCKywflkY3rXSW4K3fMe3QNUcyFBYxQ8fg7E3MO5mHRwCW15g6yz5/rX7IKNM3a+EB
 VsizY5rudFGSlBQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

During the switch to YNL, the command to list all endpoints has been
accidentally restricted to users with admin permissions.

It looks like there are no reasons to have this restriction which makes
it harder for a user to quickly check if the endpoint list has been
correctly populated by an automated tool. Best to go back to the
previous behaviour then.

mptcp_pm_gen.c has been modified using ynl-gen-c.py:

   $ ./tools/net/ynl/ynl-gen-c.py --mode kernel \
     --spec Documentation/netlink/specs/mptcp_pm.yaml --source \
     -o net/mptcp/mptcp_pm_gen.c

The header file doesn't need to be regenerated.

Fixes: 1d0507f46843 ("net: mptcp: convert netlink from small_ops to ops")
Cc: stable@vger.kernel.org
Reviewed-by: Davide Caratti <dcaratti@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/netlink/specs/mptcp_pm.yaml | 1 -
 net/mptcp/mptcp_pm_gen.c                  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index 30d8342cacc8704c42b84c9e03f96c906e81733e..dc190bf838fec6add28b61e5e2cac8dee601b012 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -293,7 +293,6 @@ operations:
       doc: Get endpoint information
       attribute-set: attr
       dont-validate: [ strict ]
-      flags: [ uns-admin-perm ]
       do: &get-addr-attrs
         request:
           attributes:
diff --git a/net/mptcp/mptcp_pm_gen.c b/net/mptcp/mptcp_pm_gen.c
index c30a2a90a19252dd41a74109d5762a091129269d..bfb37c5a88c4ef90740699dfda345b52e206966b 100644
--- a/net/mptcp/mptcp_pm_gen.c
+++ b/net/mptcp/mptcp_pm_gen.c
@@ -112,7 +112,6 @@ const struct genl_ops mptcp_pm_nl_ops[11] = {
 		.dumpit		= mptcp_pm_nl_get_addr_dumpit,
 		.policy		= mptcp_pm_get_addr_nl_policy,
 		.maxattr	= MPTCP_PM_ATTR_TOKEN,
-		.flags		= GENL_UNS_ADMIN_PERM,
 	},
 	{
 		.cmd		= MPTCP_PM_CMD_FLUSH_ADDRS,

-- 
2.45.2


