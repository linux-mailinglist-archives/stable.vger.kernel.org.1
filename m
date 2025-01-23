Return-Path: <stable+bounces-110317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC44A1A95E
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 19:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7FC8188B1B7
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 18:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B431552E4;
	Thu, 23 Jan 2025 18:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEvVc3Kd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D078113AD03;
	Thu, 23 Jan 2025 18:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737655646; cv=none; b=Uk7V2bITPR6nNWSYOBtdj0lAN+y5Wfa/nBxSD74uxiK5MNzRs0RuO4wY26u7vSkCDUFh8U4Qz+ww1eGy31GydUNHPZ6/6xUgqPA9KeUD20lJ9bh9YuQhtIOP8isJxxeGLjD+M558nRKUAY8n++us1nfM1N+4Lm0Zfts4Ay/opso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737655646; c=relaxed/simple;
	bh=U0AT/fNbksLg7k8vGYbqOc12SgcUitUxaUC9w9DZcFI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VtQIktWCNYJTuGBSBpk8SH9RuZMSyTfXlYXyAABuXu1bM3SAUPwZMq6psxK/Z7NUZyMvilTsFdE8XFp9yfll/5pw0jFjHA+PUIwt9rZcjIi0HxvqyAQ7hEeYwCw8zgiF4354SbQJRoXg+eL3xar01TpocogjRKEVuQEqabMA9Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEvVc3Kd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DD5C4CEE0;
	Thu, 23 Jan 2025 18:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737655646;
	bh=U0AT/fNbksLg7k8vGYbqOc12SgcUitUxaUC9w9DZcFI=;
	h=From:Subject:Date:To:Cc:From;
	b=dEvVc3KdA7E0hWlyVUjLpxPQ1aRKz3fmfSA3sQB+1hYZNii+d6MpeMjeGchBjjeOx
	 om1HrCWiwsIPiIt+01cau62llu1jVg6+DiwxKGnGmPyWrEm213yH6Bba1pWNbVgOL2
	 lKo+8ttihbF0GmKh2+e7UJl4ICJ5dfZHcU4+k/Ts/IcQ5Sg67so70n+sLOO5NWGnk4
	 bGN/LbWwopOw+LS3nB88DCgPOYmpA1Lxapo0IHJi7JGAFOd1aU4R+CLRr1+/EohbHS
	 laSQvto4LYRNsCbcxqttQkaQX7bDbwweFTMgUradheIPuFvzZUBCJGtWumz9q7q0Uc
	 flEP1SpM8glcQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/3] mptcp: fixes addressing syzbot reports
Date: Thu, 23 Jan 2025 19:05:53 +0100
Message-Id: <20250123-net-mptcp-syzbot-issues-v1-0-af73258a726f@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAGFkmcC/x3MMQ6DMAxA0asgz7UEqRDQq1QdMHHAAyGKA4Ii7
 k7E+If3T1COwgqf4oTIm6gsPkf1KmCYej8yis0NpjR1WZk3ek44hzQE1ONPS0JRXVnROUtEHbW
 1bSDrENnJ/py/kBH8rusGoSd8J24AAAA=
X-Change-ID: 20250123-net-mptcp-syzbot-issues-ffdbbb9b85d7
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 syzbot+23728c2df58b3bd175ad@syzkaller.appspotmail.com, 
 syzbot+cd16e79c1e45f3fe0377@syzkaller.appspotmail.com, 
 syzbot+ebc0b8ae5d3590b2c074@syzkaller.appspotmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1078; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=U0AT/fNbksLg7k8vGYbqOc12SgcUitUxaUC9w9DZcFI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnkoVbw3q4Zi7orpFj0hcZgcrEE1nanGfdQjIup
 iYYnzJJvNeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ5KFWwAKCRD2t4JPQmmg
 c4BGEADA4S3AL7PZ0NWrYDFViAxevZenO1qcjxKcK6iER7cW+KG6L1KjQWLVTbCzZyr3BYQZc2N
 WfF2YKWV5bP5GlqsP/KVMcvEo5GfwAC/gbYomJ7OAaziYMzMdSIH6fMxyz2FNaMOSDQEZi5Mt/7
 1E83o3Xpe2w31D+UOyErD/1/PkNjaVhlq4OUSmgTXAsie6BV7MF/Z1HnYu9L6KtsuY3kY2nruUN
 lfjWa7s3mJbkxVTlsvflhZkArXey1INfrgNY4Sajgm7cdCYRQMIhObfGX0Czb8tC7EL8PwCdr9k
 SbZ/PvU6ZS5TTj9lxBk8ikI+5gayCFYE3aeQTsLVOq6c9xHBywk7M1JiQvmhA5Wrd/jGcItOUIP
 GVmi5fXKWuzdJgpkFnScHw9l6gbOxQbBxSNhu5NYYpm0JOcyowBxnE9pTw0sOY5iasqHK7ABdG3
 K9UL+jwPQ5odrGF+YWruTU+9upcEDC+vqg2ImCx43OtOAvEGJ6fPm34rjEAeZ4NaFlp0X3CrulA
 cxIa/7PqslON5H3s4iHTAPdVCBBh3uIDYuhr64j5WBElxp4tlYCmCfIy4x5+5A0Z2KFJgD6QIc+
 EtlBShIscjmq9c8b9lJVRhW3Aw7r2OO1frzBHpRm3/pjEGVKcT+SM2R77QiK/nmpyIwKtHE7yDA
 +osgSXmjzE22NxQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Recently, a few issues linked to MPTCP have been reported by syzbot. All
the remaining ones are addressed in this series.

- Patch 1: Address "KMSAN: uninit-value in mptcp_incoming_options (2)".
  A fix for v5.11.

- Patch 2: Address "WARNING in mptcp_pm_nl_set_flags (2)". A fix for
  v5.18.

- Patch 3: Address "WARNING in __mptcp_clean_una (2)". A fix for v6.4,
  backported up to v6.1.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (1):
      mptcp: pm: only set fullmesh for subflow endp

Paolo Abeni (2):
      mptcp: consolidate suboption status
      mptcp: handle fastopen disconnect correctly

 net/mptcp/options.c    | 13 +++++--------
 net/mptcp/pm_netlink.c |  3 ++-
 net/mptcp/protocol.c   |  4 +++-
 net/mptcp/protocol.h   | 30 ++++++++++++++++--------------
 4 files changed, 26 insertions(+), 24 deletions(-)
---
base-commit: 15a901361ec3fb1c393f91880e1cbf24ec0a88bd
change-id: 20250123-net-mptcp-syzbot-issues-ffdbbb9b85d7

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


