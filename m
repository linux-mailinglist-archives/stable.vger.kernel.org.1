Return-Path: <stable+bounces-195357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A743BC755FD
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 61B8A2FADA
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 16:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDD0364EAB;
	Thu, 20 Nov 2025 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZK6lN8FE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0E33659EA
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656209; cv=none; b=QxGRqxaHyNW0nVVg/88WerrKNRSPfKrnKdnlaPPlDQteYqkH/+CLtPzu++FMRmkrDIrsoAAeXxYU3n49QxLlWlSEQix+rKzdjeVss4K2z96mF3qDpk2dgsjtO3BwzgxbYYcblA5ilgGdAcquXAYQ6NTJbe1IyPn7x3JPdvdBOSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656209; c=relaxed/simple;
	bh=fk6oh/j4yfIxpMkn3cVMuOcNr350HWSg+MZO43PpQhs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=f52uEHbfKQl+B5G/3kBhAWnOocTSdomf7iyDHrUz8VeFqNgfDbPqt0ZjmkKgA+imV4HZ4sdCIsAfUG5a53OHIJ29WnOSwOuLGzBHidDZxbAwyFB9IGpVJN3GDYhvfcfNr/rtxkAqqX+pRoSq0q+crk7kBnHOHOwX350ciIbAQWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZK6lN8FE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E41C4CEF1;
	Thu, 20 Nov 2025 16:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763656208;
	bh=fk6oh/j4yfIxpMkn3cVMuOcNr350HWSg+MZO43PpQhs=;
	h=Subject:To:Cc:From:Date:From;
	b=ZK6lN8FERls0f1tj5DAk/x0AJwbs9QfwYnyp7v6JH/enXsDsXJTNOX7lv8XxA1e4+
	 bWgnlsV61paKWryDWyhEc4HA3lOZzmcUOC1I24Qw2HabXa/H369bdO33Yp7TNp8iOk
	 n+QEItLCtoru57SfGsiye7VNy7qjOSSKCXslYa5U=
Subject: FAILED: patch "[PATCH] selftests: mptcp: connect: fix fallback note due to OoO" failed to apply to 5.15-stable tree
To: matttbe@kernel.org,geliang@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Nov 2025 17:29:58 +0100
Message-ID: <2025112058-distinct-glisten-21aa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 63c643aa7b7287fdbb0167063785f89ece3f000f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112058-distinct-glisten-21aa@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 63c643aa7b7287fdbb0167063785f89ece3f000f Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 10 Nov 2025 19:23:40 +0100
Subject: [PATCH] selftests: mptcp: connect: fix fallback note due to OoO

The "fallback due to TCP OoO" was never printed because the stat_ooo_now
variable was checked twice: once in the parent if-statement, and one in
the child one. The second condition was then always true then, and the
'else' branch was never taken.

The idea is that when there are more ACK + MP_CAPABLE than expected, the
test either fails if there was no out of order packets, or a notice is
printed.

Fixes: 69ca3d29a755 ("mptcp: update selftest for fallback due to OoO")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251110-net-mptcp-sft-join-unstable-v1-1-a4332c714e10@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 47ecb5b3836e..9b7b93f8eb0c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -492,7 +492,7 @@ do_transfer()
 				  "than expected (${expect_synrx})"
 		retc=1
 	fi
-	if [ ${stat_ackrx_now_l} -lt ${expect_ackrx} ] && [ ${stat_ooo_now} -eq 0 ]; then
+	if [ ${stat_ackrx_now_l} -lt ${expect_ackrx} ]; then
 		if [ ${stat_ooo_now} -eq 0 ]; then
 			mptcp_lib_pr_fail "lower MPC ACK rx (${stat_ackrx_now_l})" \
 					  "than expected (${expect_ackrx})"


