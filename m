Return-Path: <stable+bounces-133220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91602A923FA
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 19:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322A93ABFFA
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 17:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB30925523B;
	Thu, 17 Apr 2025 17:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGX5bhS5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960A2254847;
	Thu, 17 Apr 2025 17:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744910877; cv=none; b=qik0etJjH8ziTeOCgfiszcTdeQ1F29QEBO+pH57gv126KAlEx3Dqto2Pu1bCSzk9gE1XvQXuQTxLzCf22Ih3iGvPWG5jI8AELNyraBOwYAL84V3KWD/WCPNjhnKV7u/krrqWaFTkxbDXLZRxoT3841QmYwyfngn/x1xXM0QHSfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744910877; c=relaxed/simple;
	bh=Xz9/YSYpgCvWEXSOh+Qk/wVwFLyE0nJZ5qpMC6L1maA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QocyFOS6fwpQvREmLzzQUzFYI5IxKbiTK0seVu/l8R3idbZVpKQc/bVLBPyporLWjCGiPh3KUIQ11hYzFjpAF83LHSKSK3nLltOjE0RIOPZIE8Ckx3UgkEC8GiwZQrkC7gdEhvx9dI4kQiIQjF6F08E1+t7T/bZuZjT9l+e/6sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGX5bhS5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5EFC4CEE4;
	Thu, 17 Apr 2025 17:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744910877;
	bh=Xz9/YSYpgCvWEXSOh+Qk/wVwFLyE0nJZ5qpMC6L1maA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qGX5bhS5MdSpp1Ed4oIs3qdBKrVly5mOIv44tKJOdEEVidcstbPNm3OEuk/q/xT6+
	 tQk7B9xDxnVB/njiXlx4Xm0OC9CeVzVwNpJcoIdEI34OF37mOEfh+4shXoCqp/ZcYS
	 6OpBc0qVsJfphxohNhJr3rQrTXcMO3mW5fYqO3Q50GHQPE5C20okovQuYBomTB8rao
	 dEN4bxru/+jL8DgVqvvHWk3P2/pfKDqrScxxqE1HqF+VEY7LoyFzt4701bzmNfYODa
	 PS70yQeYxWdkn9f9tdKJO+Wo6mEXfhm6iaaIphigMwajMZf1RViegHitC9H3f1RAsC
	 ED6WQDgf7/yMA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 6.6.y 0/2] mptcp: sockopt: fix getting freebind & transparent
Date: Thu, 17 Apr 2025 19:27:50 +0200
Message-ID: <20250417172749.2446163-4-matttbe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025041756-ovary-sandfish-4a21@gregkh>
References: <2025041756-ovary-sandfish-4a21@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1294; i=matttbe@kernel.org; h=from:subject; bh=Xz9/YSYpgCvWEXSOh+Qk/wVwFLyE0nJZ5qpMC6L1maA=; b=owEBbQKS/ZANAwAKAfa3gk9CaaBzAcsmYgBoAToViYuM6BmN12rXZgNmQwHTYLRgtI8VP8eNS sP1LGrMqOmJAjMEAAEKAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCaAE6FQAKCRD2t4JPQmmg c+wTD/sFEF+Qw0HDTgXXf/VqbFYk8GbQ7+pIpnWp3m9MRWemFlK7jyOv399zu6roIPCU+w/mg9n UEiFe561NePxDdLnYxfikkAbFsNR1zHNWalAuoHhWJJFf/0PKYOtczlZE1XmGmDSMgjNpQnjbTI +HaUbRrihcJ2cioMuBFuy7gOgZdOjRuSw6R5k3xLiLKJ/+xdAJbrN03c6+gn/XgFUn5atrNqZvf NZ1Y30OXKHzhvF6GPC0Q+4o4EOuVFR+HQnPYPxCmFqSyvTcEQZrWdm20hGhCbbbqxHcp3DNDgx4 KDXMK3K98K8YNj1au8Nln1nuMJCu+T7ntB6XA2qKAejuBVv0udCiUhuvDO6e86x9zUacS7771zf OC5y27r0nfJRWWv5iFN5uPwB1uTY+BY9I7f4wKbCPfEx4fGJJXqJfzDFztFpOLTaMkSxnGmp75j z5RmvF7HSlkugZF3cE89+7FKcdlW4kayulxk8bYr5eEN7xuPj5xUJXpAFaBhK1lP975uewN19sD qJ3O3DR5IDO+JFkv1WVyTJ1R4W5HJAk0xMfBb4SCdXcPFL3yZflx1n6Lpgd4EqqIdaCoHeTYd7g 5RfkqK8pULWfhexrgPZrbp9TZ1qaBQsdKVC95dCxXnmqJOKjBLsDdDkguhIbrG76jP3ypkQqI+g 0UcWaGfjslCM44Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Commit e2f4ac7bab22 ("mptcp: sockopt: fix getting freebind &
transparent") failed to apply to 6.6-stable tree. The conflict
resolution was easy, see the patch 1/2.

Patch 2/2 has been added, because this warning was visible in the
selftests without impacting results on fast enough test environments:

  # ./mptcp_join.sh: line 3083: mptcp_lib_wait_local_port_listen: command not found

It looks like the commit 5afca7e996c4 ("selftests: mptcp: join: test for 
prohibited MPC to port-based endp"), backported in this 6.6-stable tree,
was requiring this commit 9369777c2939 ("selftests: mptcp: add
mptcp_lib_wait_local_port_listen").

Geliang Tang (1):
  selftests: mptcp: add mptcp_lib_wait_local_port_listen

Matthieu Baerts (NGI0) (1):
  mptcp: sockopt: fix getting freebind & transparent

 net/mptcp/sockopt.c                           | 12 ++++++++++
 tools/testing/selftests/net/mptcp/diag.sh     | 23 +++----------------
 .../selftests/net/mptcp/mptcp_connect.sh      | 19 +--------------
 .../testing/selftests/net/mptcp/mptcp_join.sh | 20 +---------------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 18 +++++++++++++++
 .../selftests/net/mptcp/simult_flows.sh       | 19 +--------------
 6 files changed, 36 insertions(+), 75 deletions(-)

-- 
2.48.1


