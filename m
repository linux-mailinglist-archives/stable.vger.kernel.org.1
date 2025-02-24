Return-Path: <stable+bounces-119404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C78A42B1B
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 19:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77BA0189236C
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 18:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F39B264FA6;
	Mon, 24 Feb 2025 18:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwkbPPry"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B142C24394F;
	Mon, 24 Feb 2025 18:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740421161; cv=none; b=WpU1C6PYaNdZocj1LB1gODrd/OKxKk8BxsIsZPQIMhI2BMKvZb118zOEMqemdMPFaQysqCiPzs+NVbkhOhGlsSNxG5kbYrrciZ9JdpBK1GcGBsNJr3psgT4FJjdmWHjniw0gjw8PKQCmP011wFIAE1mVSO7qMm6LEfCZcedMUE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740421161; c=relaxed/simple;
	bh=uwyoOtIyHLqC9nZ97BA9itdUvfRcvpHiv3XhxZ/ILuE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FJr8D258Y18iGOwiGegEewOs002WbBuJIbUaLNGMfxmxcEZvBP+b+trMI0d93JbAJ+5wJ+4EuCOyU6uhcuf/94XaCylLXT5t9j2VfWejXmUZmbrQwOjPosAlLDuB5HsrvcEVxxP6cqRGL8yD5aHzBhYIREwjq2jIyGkF49xYmdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwkbPPry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF33C4CED6;
	Mon, 24 Feb 2025 18:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740421161;
	bh=uwyoOtIyHLqC9nZ97BA9itdUvfRcvpHiv3XhxZ/ILuE=;
	h=From:Subject:Date:To:Cc:From;
	b=uwkbPPryHUMDqO+hc+E4Fusjct9SUtD4RluVMaGMy6omU7WWpmxk9a0DzT5Wq6xgI
	 SZ/idgHZo8u9AjCsIgjGDdTv8Hh9GhLqiQlWQalyNfMSW8TesrHZYqlEgbGnJ2vkSG
	 QULe7bVc3zDt3Rbm/p7PByJVlgRYP59zKQWxcQ1+2mTGmJ1eNLWgUYbH7mkyzQdoC8
	 C6YGQpOSNfrNkDXPrjDbWOpy9GkM2TJ9vrJHr/vScNqtKchPHc9MI6/vl85iHMsjlg
	 /l+4h5LtsMHqKxtO6mt1/fzHb7ryyexS+E2rCvFCaQH7/9dXbsiB/TWjd45owW+CDy
	 pF2zX3ZGSWGqw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/3] mptcp: misc. fixes
Date: Mon, 24 Feb 2025 19:11:49 +0100
Message-Id: <20250224-net-mptcp-misc-fixes-v1-0-f550f636b435@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGW2vGcC/x3LSwqAMAwA0atI1gZq8YdXERdSU82itTQiQvHuB
 pfD8AoIZSaBqSqQ6WbhM2o0dQXuWONOyJs2WGM7Y22LkS4M6XIJA4tDzw8Jjqsfh741mycPSlO
 mf6icQQUs7/sBGPPiHGsAAAA=
X-Change-ID: 20250224-net-mptcp-misc-fixes-8af87640dfef
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 syzbot+cd3ce3d03a3393ae9700@syzkaller.appspotmail.com, 
 "Chester A. Unal" <chester.a.unal@xpedite-tech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1036; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uwyoOtIyHLqC9nZ97BA9itdUvfRcvpHiv3XhxZ/ILuE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnvLbE/Sc41iqtpNEO42OrCzrDoc6CwtVMpsVom
 V2EeuGwq+WJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ7y2xAAKCRD2t4JPQmmg
 c2ifD/9eV4Mq4huRH7bhLHLHZmYz25C/ayWVEGmV+T3aYi1PviW3XMbUXwRGPUzYSRldUPPgpRk
 Q4haHwrGxYQYN1UTFr0t9a0pbVn9yo0Pm2fzNNfHhlsTVvnE1kJOKxnM5+K1kIr8xwNUFgxx3J0
 2nI3ZZzOe5eJRxOklVBBV3G4Gx8KoS6pSRgI0WQePW0rhGwa1mN+hvCVaGzjJMnKwXnH0SZkiCp
 8dT1wL8RfxiR8PJc3oMQKaaonCHE40Bhf5bzg5deA7eEDOZDt7C7r2Dasskkz0Sx2zsLOt8DqGV
 FMIoN7lI13p+bEBYt/T4z6frDwVOjnNUBGnUNc6oQo5iTvTd2wUbrdnyQROywvfXS/Wy+kS6ybr
 t7X/gMnSljSo3E84ycpskSqTzUaMh1GGAWRofGCqKi7dqcbK3gkruaRNNv+21uvWys5tsYbSsMX
 rTg0qKgEtdcun6yHJTAGS+dDx1JFiCF8Sp3fCQdxUMCd2w5wBlMWU2b6XceP5o9/uQoRltrTw0P
 7mKmBU1Fkv1VpQk9FD1Jbp0A5qx30ZFlqGtJ2dWZr9Z18Jm/FEh3yOgves0LFMTRdVbHPF+vxDo
 fqqrST11wbT2R/PF6WtoF1KePl2lnK+wR1DTY8QlPUCuCe9uXXuDvWbqPsDg0Rq5CDl6+hCjAw9
 SYRaijJWjcekdMA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are two unrelated fixes, plus an extra patch:

- Patch 1: prevent a warning by removing an unneeded and incorrect small
  optimisation in the path-manager. A fix for v5.10.

- Patch 2: reset a subflow when MPTCP opts have been dropped after
  having correctly added a new path. A fix for v5.19.

- Patch 3: add a safety check to prevent issues like the one fixed by
  the second patch.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (2):
      mptcp: reset when MPTCP opts are dropped after join
      mptcp: safety check before fallback

Paolo Abeni (1):
      mptcp: always handle address removal under msk socket lock

 net/mptcp/pm_netlink.c |  5 -----
 net/mptcp/protocol.h   |  2 ++
 net/mptcp/subflow.c    | 15 +--------------
 3 files changed, 3 insertions(+), 19 deletions(-)
---
base-commit: f15176b8b6e72ac30e14fd273282d2b72562d26b
change-id: 20250224-net-mptcp-misc-fixes-8af87640dfef

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


