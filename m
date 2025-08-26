Return-Path: <stable+bounces-173149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BF9B35BF1
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14021883234
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B222BE03C;
	Tue, 26 Aug 2025 11:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kGq6mLIF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4C1239573;
	Tue, 26 Aug 2025 11:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207499; cv=none; b=Vxp53XQnjyVEWOSNM5HpSGxt4cAMKNBthjMovDJQfZ5xNjlXRFlex2UvchgCBO1xUuqnheATr70xedh4NnWnw7lCUZQ/NoiVudcCU9KVw07ZSsl8yDQS3uv0+s3UsvI85khOKqg6ZOGfqRi9Xp1c7/vfe4yVkqDoBXQyh5OPOD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207499; c=relaxed/simple;
	bh=xj61u2AEqs6UKFrPXvq1/FNiTB3k5nxJ2cTsvjSzvd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dMRyco9O6D561fX433lvzfmtpDJs3u7zC8gAiZXEdkVBo16YoTmNxAk7Gey65D8wRARUNUVPFYTZuyDbeAqDNHCnBf2yU78eRhlhiuEv4gx2mj1TKDKU2F1+b1U93omOwPgj+nePZl1pTTToSr0gSHyEIw1Nv/hgrYAzHJnVFdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kGq6mLIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E03C4CEF1;
	Tue, 26 Aug 2025 11:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756207499;
	bh=xj61u2AEqs6UKFrPXvq1/FNiTB3k5nxJ2cTsvjSzvd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kGq6mLIFYswExEvJUvghFK/O7smS41aueOyGCAH7ON9y67dFDAK4PTrAEFyR7bYvn
	 jRk+Jv0XAp2N6z+U4uA2QH6hGFGzF/tJH5yPES2VbTvK42tKodJ/mJUvjlfj/4F25t
	 p38mjGfwd2NmHd1DzkbnoCBtQ35fr7ZnqxV3TAh8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Dreibholz <dreibh@simula.no>,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.16 205/457] mptcp: pm: kernel: flush: do not reset ADD_ADDR limit
Date: Tue, 26 Aug 2025 13:08:09 +0200
Message-ID: <20250826110942.431681397@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
References: <20250826110937.289866482@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthieu Baerts (NGI0) <matttbe@kernel.org>

commit 68fc0f4b0d25692940cdc85c68e366cae63e1757 upstream.

A flush of the MPTCP endpoints should not affect the MPTCP limits. In
other words, 'ip mptcp endpoint flush' should not change 'ip mptcp
limits'.

But it was the case: the MPTCP_PM_ATTR_RCV_ADD_ADDRS (add_addr_accepted)
limit was reset by accident. Removing the reset of this counter during a
flush fixes this issue.

Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Cc: stable@vger.kernel.org
Reported-by: Thomas Dreibholz <dreibh@simula.no>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/579
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250815-net-mptcp-misc-fixes-6-17-rc2-v1-2-521fe9957892@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_kernel.c |    1 -
 1 file changed, 1 deletion(-)

--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1085,7 +1085,6 @@ static void __flush_addrs(struct list_he
 static void __reset_counters(struct pm_nl_pernet *pernet)
 {
 	WRITE_ONCE(pernet->add_addr_signal_max, 0);
-	WRITE_ONCE(pernet->add_addr_accept_max, 0);
 	WRITE_ONCE(pernet->local_addr_max, 0);
 	pernet->addrs = 0;
 }



