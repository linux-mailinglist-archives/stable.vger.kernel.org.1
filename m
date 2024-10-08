Return-Path: <stable+bounces-81567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A34B994616
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE65286B1B
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 11:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BD01DC046;
	Tue,  8 Oct 2024 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJoPfCkV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4311D90A9;
	Tue,  8 Oct 2024 11:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728385519; cv=none; b=q/Mi5p9qsiC89B2IwzI7MWFo14RF5HB/SVbphHqKUi0S2XWYDWXH+NmOupbUivZsiy0BwGJXmG82HhTEfIBlM4m5EG+BCRgF4iDDZIRY2cRr8zosBvvm2F5ifiVVsph1qUdlE/4NMapAuIGy5nZplsUSonsQ7TJOiHUMzuRq7Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728385519; c=relaxed/simple;
	bh=JR4C0ipf9JSJAjHclXg1GYm/oAEar7V7rPx20X0B3bs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SpIkBsMSZFN0Acr+Lyx7x76IWEApsbbyBRcrLG80w+inlVMNbw8Ses0j/b8FDr++c3U5wUrhp10dYrtiZjok/Fu88NqJAsMSKf3fMFAXAH6UnzGxHtjk5WzXGjgT2SxTR8ZlDVy/AqAmagndpYY33JL+8jVCu2f12KFRzWv81rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJoPfCkV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB88C4CED3;
	Tue,  8 Oct 2024 11:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728385518;
	bh=JR4C0ipf9JSJAjHclXg1GYm/oAEar7V7rPx20X0B3bs=;
	h=From:Subject:Date:To:Cc:From;
	b=jJoPfCkVoDqIdVQYF7Zf/XUEnLhmXX5/s0swBcDvUCwzCXWWCLhfVUp7S9RBBlWAh
	 znvld4Jtobfu10ejH69DYVyYtZEtV4VJwUD0oFr6H0jcc/lQXQr/PKoiNPncPeIlcw
	 vwzKwinPwD3uz4dnrVK05tiP3D/htTeTC45X1w6KioIr4Es0+1n4ybusipohcWmSyI
	 Mmfsl1F1dDykd2MMLhNoFD7w3bKCZJkam1CWHBqNaS/V9io8nVguW8EUUfbNAb3Qz0
	 hgHg2xKbOzgWUKN9O/6m+jkl/L4YlNAtsPMnWjMP/PBdsgmwe6xMxQbqMl9RZVzYHN
	 wvmOwe7vZZTkg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/4] mptcp: misc. fixes involving fallback to TCP
Date: Tue, 08 Oct 2024 13:04:51 +0200
Message-Id: <20241008-net-mptcp-fallback-fixes-v1-0-c6fb8e93e551@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANMRBWcC/x3LQQrCMBBG4auUWTuQRCmtVxEX0/hHh9YYkiKF0
 rs7uHw8vp0aqqLRtdup4qtNP9nCnzqKL8lPsD6sKbhw8c4NnLHyu6yxcJJlmSTOnHRDY9/LKAk
 I5wFkvFT8h+kbmaL7cfwAAtozUW8AAAA=
X-Change-ID: 20241008-net-mptcp-fallback-fixes-16a9afee238e
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 syzbot+d1bff73460e33101f0e7@syzkaller.appspotmail.com, 
 Christoph Paasch <cpaasch@apple.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1337; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=JR4C0ipf9JSJAjHclXg1GYm/oAEar7V7rPx20X0B3bs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnBRHriU3giTqf9k/3SOx0xIoMimftFyzaJPYqR
 r2OR1uj+R+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZwUR6wAKCRD2t4JPQmmg
 czy6D/4qNupnsBTYb0ACgeuaoh4h9f5xAIL0Gvx3LD4YpwLi+y5f1D7ua9jRMGdTDyA3EWsGaM9
 +EEoEH3EHLBLVzDPLHIKWRhRNSSMg+iiZ9VF/up6Mlcbj2Cmk8/ejn3qmvJLVl40oJSR6ZphCVA
 +v6XsAiT8QqRPkWROsYdml9SBPwedtfuS/ET/at1cKRFwdD8jzjjmpedhSDIDUKWyVcy3cO/R9H
 p7pIoqWB+ebQalzfnEQGKiTXkdIITW9vd8MGIWzWrJ1WwBVcP9LGeA1zVfyV9qkAaRgXPVHwX/+
 fzMFeg2F71LgfH5C9VNrGsUvuUQzWmljQIXi8P1G6FzyuqyfMhIDf1OcWIT2BBrOgejJL/3v6Wx
 XDyEvm6ES5mnNIHDfh0qqzNAPpAzjrkWRlSySUTeID5uZezgJfrzi9n0oAm262by9cbaT7jC4ni
 IZ7tpclHeurBifWbQqZBRKY7a65c/yJWRusXsD0EMKoFQMtPSUzgPfUWtnHMkCgfsB5Sv/KXojQ
 HFn0ZX6ikFizxl4vv4NqvRmJOWHrnJVOi/XgVpxmqWAq3yQQij3jalGQNQHLPWL9S2cokMqeC49
 3p3rB4XoCkGWZBjactAu033a9U4rwuedy6FogDMrbqgTvYgFseIY3j0d3e/5bMOOqzuL0Vew/pz
 aCTXhwKZn7JYXBA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

- Patch 1: better handle DSS corruptions from a bugged peer: reducing
  warnings, doing a fallback or a reset depending on the subflow state.
  For >= v5.7.

- Patch 2: fix DSS corruption due to large pmtu xmit, where MPTCP was
  not taken into account. For >= v5.6.

- Patch 3: fallback when MPTCP opts are dropped after the first data
  packet, instead of resetting the connection. For >= v5.6.

- Patch 4: restrict the removal of a subflow to other closing states, a
  better fix, for a recent one. For >= v5.10.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (2):
      mptcp: fallback when MPTCP opts are dropped after 1st data
      mptcp: pm: do not remove closing subflows

Paolo Abeni (2):
      mptcp: handle consistently DSS corruption
      tcp: fix mptcp DSS corruption due to large pmtu xmit

 net/ipv4/tcp_output.c  |  5 +----
 net/mptcp/mib.c        |  2 ++
 net/mptcp/mib.h        |  2 ++
 net/mptcp/pm_netlink.c |  3 ++-
 net/mptcp/protocol.c   | 24 +++++++++++++++++++++---
 net/mptcp/subflow.c    |  6 ++++--
 6 files changed, 32 insertions(+), 10 deletions(-)
---
base-commit: f15b8d6eb63874230e36a45dd24239050a6f6250
change-id: 20241008-net-mptcp-fallback-fixes-16a9afee238e

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


