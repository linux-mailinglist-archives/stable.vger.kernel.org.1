Return-Path: <stable+bounces-189808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD3BC0AA4D
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 15:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E15933B0C52
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 14:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5517A240604;
	Sun, 26 Oct 2025 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AuRHSh9Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD61221255B
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 14:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761489281; cv=none; b=uQOt25fejRF/pl1rlBwGmXAdBE0+MIgfooNXIft2VowZ4MU2Klr9EReHhDbnbyiCO4y5gGZF6zii6QNCWrCW1F4FhG+Yx3h/FDr/YWtMM5uU84tO51TLKYJ8JS7ywG8b/v4kZISc1OXie3Onisjn8CceRrKDG65tUiM2eRuGsNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761489281; c=relaxed/simple;
	bh=2CetilWZVcJUsaCYw1EhJ296bX9l8uidrk2t2Tu4/qY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=s+gNRY0/Xl/TIq18nk5bUVoSCIg8axcdDvynLtg5X7uq8MY5XONSEb6Yyfh29bJN6nr104/BBbi2jKiPHYpyI93l966tUM5uwlYnNNsF7m593uePj9JRUiJX1CqGEZf/f68LUqLF16+C6A8sNll/PdHzhIwqxIapH4+bbaIGD2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AuRHSh9Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E80C4CEE7;
	Sun, 26 Oct 2025 14:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761489281;
	bh=2CetilWZVcJUsaCYw1EhJ296bX9l8uidrk2t2Tu4/qY=;
	h=Subject:To:Cc:From:Date:From;
	b=AuRHSh9YHWh2gvWVcuCU+ZsgAYF4c+oDi/v0VrB2p9F77oLNwUmQqbdIKUAGLqRLW
	 auKiPuzyX6Myvbgju20OI0JGS3NwcGSbfjz/M59hcdCMmCp0OKPECtrkxEDvH/J4AS
	 +3iONb2NyIRGTmjFregjKhSNAIySMSkmAUs8f+Vo=
Subject: FAILED: patch "[PATCH] selftests: mptcp: join: mark 'delete re-add signal' as" failed to apply to 6.1-stable tree
To: matttbe@kernel.org,geliang@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 26 Oct 2025 15:34:28 +0100
Message-ID: <2025102628-overrun-runny-87fb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c3496c052ac36ea98ec4f8e95ae6285a425a2457
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102628-overrun-runny-87fb@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c3496c052ac36ea98ec4f8e95ae6285a425a2457 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 20 Oct 2025 22:53:29 +0200
Subject: [PATCH] selftests: mptcp: join: mark 'delete re-add signal' as
 skipped if not supported

The call to 'continue_if' was missing: it properly marks a subtest as
'skipped' if the attached condition is not valid.

Without that, the test is wrongly marked as passed on older kernels.

Fixes: b5e2fb832f48 ("selftests: mptcp: add explicit test case for remove/readd")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251020-net-mptcp-c-flag-late-add-addr-v1-4-8207030cb0e8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index d98f8f8905b9..b2a8c51a3969 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4040,7 +4040,7 @@ endpoint_tests()
 
 	# remove and re-add
 	if reset_with_events "delete re-add signal" &&
-	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=0
 		pm_nl_set_limits $ns1 0 3
 		pm_nl_set_limits $ns2 3 3


