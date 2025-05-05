Return-Path: <stable+bounces-141247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66412AAB1D5
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB081BC579B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7921941B77D;
	Tue,  6 May 2025 00:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJQu5zxo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3D52D3FB5;
	Mon,  5 May 2025 22:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485615; cv=none; b=LnjxGzAE7jiGWtBlZcgtWLir86umUIXWPdUG6MnuEwk/FcJfbX6OMkkmC/9caOBH+4SXtRxkTrnAGWs+/38yCHPo3VMqlDd2Iz1EB3AiNg+Ah9+yiySpp6manXmD7SvEzW71vs20XCcxHBOSzZ5PkTzEM/7U+dK34+gUdOTg/jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485615; c=relaxed/simple;
	bh=c8+osNcdzV45Vqv+DHKw0rTM5fF7cGsq75lFGRG4MfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QVgWnG13FdVwV7CY/jJIL5nXLJW5V1+Wx2ja2w9wZCDSvJ5PgIowLHGB8u59QsybZEzYEJiqdl5vbw2SxTzFMLxToY+oadW3KjzsjZ2kl4gXjq9DkL2KcPgOGT7HKoTc2X6HIdWdZRt+SLnIgWWYZuIubqWtiMA0qTSLQDa9qw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJQu5zxo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97BAC4CEEE;
	Mon,  5 May 2025 22:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485614;
	bh=c8+osNcdzV45Vqv+DHKw0rTM5fF7cGsq75lFGRG4MfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CJQu5zxoBVoVmaJNMfBSD48VoIxUu7pm/6fAej74FeHoqPTU9eGIMG+pUvGAmf7Qb
	 RnOuRNNKg/yLakzMYG4MDCvfRA/Pk2SoUmPzIirmpHkXp7YLVXYf3BebA7DjEvYmZr
	 Opsvwr9qVdf/1TAE8/7qxpc3xbs4yzaQQlosydUgjESe8jZHLaRuwp72v9NlIS4v64
	 zr5HMpELNuV8DuqHKObKfh1Q43gll1Sh/WqCpaQ951JYdcOaU5E5W1r/TIDq2vLqQ6
	 4nRcoBmYpb983svKcnacjtOxmMeACjNTIcWRG5Tcow3in8+N9k95oxmvA5iKJCV7zS
	 ZIE5aHA806OTQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	martineau@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH AUTOSEL 6.12 387/486] mptcp: pm: userspace: flags: clearer msg if no remote addr
Date: Mon,  5 May 2025 18:37:43 -0400
Message-Id: <20250505223922.2682012-387-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

[ Upstream commit 58b21309f97b08b6b9814d1ee1419249eba9ef08 ]

Since its introduction in commit 892f396c8e68 ("mptcp: netlink: issue
MP_PRIO signals from userspace PMs"), it was mandatory to specify the
remote address, because of the 'if (rem->addr.family == AF_UNSPEC)'
check done later one.

In theory, this attribute can be optional, but it sounds better to be
precise to avoid sending the MP_PRIO on the wrong subflow, e.g. if there
are multiple subflows attached to the same local ID. This can be relaxed
later on if there is a need to act on multiple subflows with one
command.

For the moment, the check to see if attr_rem is NULL can be removed,
because mptcp_pm_parse_entry() will do this check as well, no need to do
that differently here.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_userspace.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index e35178f5205fa..bb76295d04c56 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -589,11 +589,9 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		goto set_flags_err;
 
-	if (attr_rem) {
-		ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
-		if (ret < 0)
-			goto set_flags_err;
-	}
+	ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
+	if (ret < 0)
+		goto set_flags_err;
 
 	if (loc.addr.family == AF_UNSPEC ||
 	    rem.addr.family == AF_UNSPEC) {
-- 
2.39.5


