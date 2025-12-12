Return-Path: <stable+bounces-200899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFD1CB8D53
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 13:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39A92306DCAE
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 12:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C826C1EDA2B;
	Fri, 12 Dec 2025 12:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldwqzYpc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAA029A2;
	Fri, 12 Dec 2025 12:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765544063; cv=none; b=UXEC2iKhcXimAeajE4Zo6KEbCUlSCO2FHkvc4RMYN+pctq8NxZbBp1OlFJy12RZB3EJV9j3VJqz8Gn2cTDoPd3DcDeEoirX0E2guOq8BZHteN5DPQ5POIGVhVkXI9v1QBNx5TDiAeFGHuONInas4yXVs7Rwrc84JXJ6vM1yutkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765544063; c=relaxed/simple;
	bh=PIUUA/Tc3FIsiIbSk0OVbF+BcmAcPFlTxA7DFbQKFnM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QrCM7dOHsaoKGGtZiBYN7vzNkiB5kShCskFnqu0llLFgqYAYkILkvSDownog1GUldiPyBwG0hQrwjOnBZ+RH0TBtssUej2VDBBgxE+nWm/tOOjInu2G0LzWXQWmcOkmVVWU1g+tXe3iWQrmKYM163bz1S2FlvIIlsiz5YeYxoNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldwqzYpc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66916C4CEF1;
	Fri, 12 Dec 2025 12:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765544063;
	bh=PIUUA/Tc3FIsiIbSk0OVbF+BcmAcPFlTxA7DFbQKFnM=;
	h=From:Subject:Date:To:Cc:From;
	b=ldwqzYpcZ7UeZGA98v2UowFMuoROs06oUCxp1gGDN7UCWdm7kxo/ZSndB1+dUIaY8
	 Yf5rmB+PkhDman3mbvb1VcsqnsjkvKqm3O115UXa47im29cZLaWAN6m+zINGzfh+99
	 7++n+dDOeFsXuK+CPlSaaqzP4x0ix2doRekUsirhp7Eng1Fc+PPNg0Hw47UI7X0m3/
	 ERpBkieVFmm67/IptxUYFDIOc4AcMAUhw37Mwen4o82+vPvF6bsAXNk7AOXmswLUEe
	 WMcRKENlJ2RZ3++0OFYf1uBuPyhD36blIXvpPo6u8SmtGN53PmAx0Oo+XUnG26UmYl
	 2EfE+9GtZOGXg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/2] mptcp: fix warn on bad status
Date: Fri, 12 Dec 2025 13:54:02 +0100
Message-Id: <20251212-net-mptcp-subflow_data_ready-warn-v1-0-d1f9fd1c36c8@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGoQPGkC/x2N0QrCMAwAf2Xk2UAbUKa/IjJim2pAu5JWp4z9u
 8XHe7i7FaqYSoXTsILJW6vOuYPfDRDunG+CGjsDOdp78oRZGj5LCwXr65oe8zJFbjyZcPziwpY
 xxdHTgdwYjg56p5gk/fwfZ+g6XLbtByDNJmd4AAAA
X-Change-ID: 20251212-net-mptcp-subflow_data_ready-warn-fd8126208c90
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Dmytro Shytyi <dmytro@shytyi.net>
Cc: Evan Li <evan.li@linux.alibaba.com>, kitta <kitta@linux.alibaba.com>, 
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 syzbot+0ff6b771b4f7a5bce83b@syzkaller.appspotmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=937; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=PIUUA/Tc3FIsiIbSk0OVbF+BcmAcPFlTxA7DFbQKFnM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJtBCqaAx5rXpt4+MHJ5EnRV4Nz2NhYr+i0Jdzi0P7iG
 Xwz66RXRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwERinjEy/P4lHTLj4kYOdcuG
 zDkblYuPeSj69zO+Lt62MeR0wqJlrxgZNjjHLLwYl6CeF7tFZs+MN8rTfv7MuHSi9ctdni8qL8L
 jGQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Two somewhat related fixes addressing different issues found by
syzkaller, and producing the exact same splat: a WARNING in
subflow_data_ready().

- Patch 1: fallback earlier on simultaneous connections to avoid a
  warning. A fix for v5.19.

- Patch 2: ensure context reset on disconnect, also to avoid a similar
  warning. A fix for v6.2.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Paolo Abeni (2):
      mptcp: fallback earlier on simult connection
      mptcp: ensure context reset on disconnect()

 net/mptcp/options.c  | 10 ++++++++++
 net/mptcp/protocol.c |  8 +++++---
 net/mptcp/protocol.h |  9 ++++-----
 net/mptcp/subflow.c  |  6 ------
 4 files changed, 19 insertions(+), 14 deletions(-)
---
base-commit: 885bebac9909994050bbbeed0829c727e42bd1b7
change-id: 20251212-net-mptcp-subflow_data_ready-warn-fd8126208c90

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


