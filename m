Return-Path: <stable+bounces-71600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A4D965F21
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 12:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91EC528B3D6
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 10:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD84183CD7;
	Fri, 30 Aug 2024 10:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ybx6YNa4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8B316CD1D
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 10:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013616; cv=none; b=kSDjcNfj8KKfq8o7IfwvqinRBNVmcnrT658iPJj96hksx+hAwwXiXMHCPvKVj27Fo06jvFZPqlZjM3MD7VUW/9pOtLQeZ+fvSsWQ7+ci3OnCa7+TWRtk9mKa5Jbe9jqk9//PRzNevpNvK2m/TFV7Gf4UHWHzK3pNRvaRXLKgJAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013616; c=relaxed/simple;
	bh=TcZdKa6zS4SOJpOkoToEYSWFheOQ2qdP9i3i9+EmmhE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PfRmz3IlmIP6uSvF+1Ajog1QBTUROZjZNUNhRVetoCMtenna5vkic64pL31KmBV36TzpecnKKbrdGfQKmVFBZgH9rBjqE5EmdS0ThKpCTgspS6nxNiMMtvg7u9UBX8Kodp/Gwvw60PCZTM4voKfCT+NtqS4+WXUOA7085AINlqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ybx6YNa4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE11C4CEC2;
	Fri, 30 Aug 2024 10:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725013616;
	bh=TcZdKa6zS4SOJpOkoToEYSWFheOQ2qdP9i3i9+EmmhE=;
	h=Subject:To:Cc:From:Date:From;
	b=Ybx6YNa4PiI4fGy13/NR6nVKR1mywfUCpzbkIDcslideejLMgcfWcW5t5R+GoypoO
	 JkRoEUrbCugfE/MWKcU94Z9Dpiq9phAvDBLJ0OXtR2HY4u+03nDKxqrx2Y0OM4oxSP
	 /wPSM2ZQRXARzbLnHdf/ZqPcS6B5sgSKzF+dCAik=
Subject: FAILED: patch "[PATCH] selftests: mptcp: join: cannot rm sf if closed" failed to apply to 6.6-stable tree
To: matttbe@kernel.org,kuba@kernel.org,martineau@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 30 Aug 2024 12:26:53 +0200
Message-ID: <2024083052-unedited-earache-8049@gregkh>
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
git cherry-pick -x e93681afcb96864ec26c3b2ce94008ce93577373
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024083052-unedited-earache-8049@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

e93681afcb96 ("selftests: mptcp: join: cannot rm sf if closed")
23a0485d1c04 ("selftests: mptcp: declare event macros in mptcp_lib")
4cc5cc7ca052 ("selftests: mptcp: userspace pm get addr tests")
38f027fca1b7 ("selftests: mptcp: dump userspace addrs list")
7092dbee2328 ("selftests: mptcp: rm subflow with v4/v4mapped addr")
b850f2c7dd85 ("selftests: mptcp: add mptcp_lib_is_v6")
bdbef0a6ff10 ("selftests: mptcp: add mptcp_lib_kill_wait")
b2e2248f365a ("selftests: mptcp: userspace pm create id 0 subflow")
757c828ce949 ("selftests: mptcp: update userspace pm test helpers")
80775412882e ("selftests: mptcp: add chk_subflows_total helper")
06848c0f341e ("selftests: mptcp: add evts_get_info helper")
9168ea02b898 ("selftests: mptcp: fix wait_rm_addr/sf parameters")
f4a75e9d1100 ("selftests: mptcp: run userspace pm tests slower")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e93681afcb96864ec26c3b2ce94008ce93577373 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 26 Aug 2024 19:11:19 +0200
Subject: [PATCH] selftests: mptcp: join: cannot rm sf if closed

Thanks to the previous commit, the MPTCP subflows are now closed on both
directions even when only the MPTCP path-manager of one peer asks for
their closure.

In the two tests modified here -- "userspace pm add & remove address"
and "userspace pm create destroy subflow" -- one peer is controlled by
the userspace PM, and the other one by the in-kernel PM. When the
userspace PM sends a RM_ADDR notification, the in-kernel PM will
automatically react by closing all subflows using this address. Now,
thanks to the previous commit, the subflows are properly closed on both
directions, the userspace PM can then no longer closes the same
subflows if they are already closed. Before, it was OK to do that,
because the subflows were still half-opened, still OK to send a RM_ADDR.

In other words, thanks to the previous commit closing the subflows, an
error will be returned to the userspace if it tries to close a subflow
that has already been closed. So no need to run this command, which mean
that the linked counters will then not be incremented.

These tests are then no longer sending both a RM_ADDR, then closing the
linked subflow just after. The test with the userspace PM on the server
side is now removing one subflow linked to one address, then sending
a RM_ADDR for another address. The test with the userspace PM on the
client side is now only removing the subflow that was previously
created.

Fixes: 4369c198e599 ("selftests: mptcp: test userspace pm out of transfer")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240826-net-mptcp-close-extra-sf-fin-v1-2-905199fe1172@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 89e553e0e0c2..264040a760c6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3429,14 +3429,12 @@ userspace_tests()
 			"signal"
 		userspace_pm_chk_get_addr "${ns1}" "10" "id 10 flags signal 10.0.2.1"
 		userspace_pm_chk_get_addr "${ns1}" "20" "id 20 flags signal 10.0.3.1"
-		userspace_pm_rm_addr $ns1 10
 		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $MPTCP_LIB_EVENT_SUB_ESTABLISHED
 		userspace_pm_chk_dump_addr "${ns1}" \
-			"id 20 flags signal 10.0.3.1" "after rm_addr 10"
+			"id 20 flags signal 10.0.3.1" "after rm_sf 10"
 		userspace_pm_rm_addr $ns1 20
-		userspace_pm_rm_sf $ns1 10.0.3.1 $MPTCP_LIB_EVENT_SUB_ESTABLISHED
 		userspace_pm_chk_dump_addr "${ns1}" "" "after rm_addr 20"
-		chk_rm_nr 2 2 invert
+		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		kill_events_pids
@@ -3460,12 +3458,11 @@ userspace_tests()
 			"id 20 flags subflow 10.0.3.2" \
 			"subflow"
 		userspace_pm_chk_get_addr "${ns2}" "20" "id 20 flags subflow 10.0.3.2"
-		userspace_pm_rm_addr $ns2 20
 		userspace_pm_rm_sf $ns2 10.0.3.2 $MPTCP_LIB_EVENT_SUB_ESTABLISHED
 		userspace_pm_chk_dump_addr "${ns2}" \
 			"" \
-			"after rm_addr 20"
-		chk_rm_nr 1 1
+			"after rm_sf 20"
+		chk_rm_nr 0 1
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		kill_events_pids


