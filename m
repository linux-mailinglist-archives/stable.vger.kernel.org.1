Return-Path: <stable+bounces-179429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EE2B5609D
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 14:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA5A189EBFF
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 12:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45336283FF0;
	Sat, 13 Sep 2025 12:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QHj6qx85"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E5D1DFCB
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 12:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757766000; cv=none; b=jAZ9E8JO+EGb1htv7/NyT+eROvf77l5v+57/nvgbmsJixCg7x/FR+S8tcwrWBSiFlpzwf310X0t+v8cqQyIpX26w17FMc8De1vIxLRSz457oqf9WeIybDny9Tbr48lcvZOz6l9CkNT7qlSCb1TISp2Ls96c4rwI508TSVQk7Cfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757766000; c=relaxed/simple;
	bh=9lpjk5tXrJr9JSux6CTY+6xUwAvP+ZsCARlIMGXFDBQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FnjaMqZZnJiA8LWyfeXxfKS58wBB4Sn+4I363DbaN+oZSasJRfTIiSNdbfdFzieR9FjP5J66Pgs2MZrvdFcUH8PaIsANyGyQvVwZdaxUKy17P1SGzK0toSYoD4JNRtQT7OUAk3pcHpHwCfIhVCvA35f+0Opp4Td0Q5rxIAksvQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QHj6qx85; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F33C4CEEB;
	Sat, 13 Sep 2025 12:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757765998;
	bh=9lpjk5tXrJr9JSux6CTY+6xUwAvP+ZsCARlIMGXFDBQ=;
	h=Subject:To:Cc:From:Date:From;
	b=QHj6qx85yhG5DuONXdH9uzsUOl5jLGEtiWsw2dkRKTaf7D5Q/hrxScAuqNjG1fm+1
	 XBrkGOnQ81a8x77tZ39Hb1liTZ6Qr+yMXNtiFZl2xmtu44zJxqXJBH/Nq6Hbn0utIJ
	 RsEMuBaT4vBT5LugKmZUm6UtVoEuVhH8MVuuTXxw=
Subject: FAILED: patch "[PATCH] netlink: specs: mptcp: fix if-idx attribute type" failed to apply to 6.6-stable tree
To: matttbe@kernel.org,geliang@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 13 Sep 2025 14:19:47 +0200
Message-ID: <2025091347-favorably-couch-3e8f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 7094b84863e5832cb1cd9c4b9d648904775b6bd9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025091347-favorably-couch-3e8f@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7094b84863e5832cb1cd9c4b9d648904775b6bd9 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 8 Sep 2025 23:27:27 +0200
Subject: [PATCH] netlink: specs: mptcp: fix if-idx attribute type

This attribute is used as a signed number in the code in pm_netlink.c:

  nla_put_s32(skb, MPTCP_ATTR_IF_IDX, ssk->sk_bound_dev_if))

The specs should then reflect that. Note that other 'if-idx' attributes
from the same .yaml file use a signed number as well.

Fixes: bc8aeb2045e2 ("Documentation: netlink: add a YAML spec for mptcp")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250908-net-mptcp-misc-fixes-6-17-rc5-v1-1-5f2168a66079@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index 02f1ddcfbf1c..d15335684ec3 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -256,7 +256,7 @@ attribute-sets:
         type: u32
       -
         name: if-idx
-        type: u32
+        type: s32
       -
         name: reset-reason
         type: u32


