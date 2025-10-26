Return-Path: <stable+bounces-189802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC06AC0AA41
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 15:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F66D4EA14A
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 14:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C45125A0;
	Sun, 26 Oct 2025 14:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0E1nwVvh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018E81DF265
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 14:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761489218; cv=none; b=P2CTgjn1SoIOo9JnpXZx/9uR0nXVkp7fXJcq6VDjWSmARoUA5vYWmNB4eTFv04txQAzCRXknG4d90S1MhIctW1M7tPyiMh1ZNhEZR7IBg1EInr6JIuYVdWlvOD2se5fKkSp0gyLem61BuwmidxNjitzip/Lb9YUw87ctZ4m+6g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761489218; c=relaxed/simple;
	bh=JSOfaY9upHzhGmPOMxufzURtnL7LJPU2gGn++L846O0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=f2OBpnvS4ZZD5REfpfcYXhx+puR5dWnCM7Go9NwRnS8fPIGdkOqdGN8rsFZIcQAgm7TNg2BV7orHxH8yTcaOBYIc1MUWvMrChIPTo3S9CjezPbOs92hs+rdJi0neh9ro058cWHcIgiI8bld69b4SjjZL71Og4zHdZa4ctbBXja8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0E1nwVvh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E26C4CEE7;
	Sun, 26 Oct 2025 14:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761489217;
	bh=JSOfaY9upHzhGmPOMxufzURtnL7LJPU2gGn++L846O0=;
	h=Subject:To:Cc:From:Date:From;
	b=0E1nwVvh+4xnDJS+/+7s+v1a9z6hTPx8D4V3zTntBpzVg4HcSS8de9tKsRS/i1zUc
	 U1vRuQxv3EN5S6BD1hXOdGvGDKgB/IKX+iXsdaWCGkHcr8sjJl5R7+TsMA2nomy9ff
	 GP7XogN42TebV76R7DWeUDfkL7bs21VVoiJuwbuU=
Subject: FAILED: patch "[PATCH] mptcp: pm: in-kernel: C-flag: handle late ADD_ADDR" failed to apply to 6.12-stable tree
To: matttbe@kernel.org,geliang@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 26 Oct 2025 15:33:35 +0100
Message-ID: <2025102634-cache-seventeen-becb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x e84cb860ac3ce67ec6ecc364433fd5b412c448bc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102634-cache-seventeen-becb@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e84cb860ac3ce67ec6ecc364433fd5b412c448bc Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 20 Oct 2025 22:53:26 +0200
Subject: [PATCH] mptcp: pm: in-kernel: C-flag: handle late ADD_ADDR

The special C-flag case expects the ADD_ADDR to be received when
switching to 'fully-established'. But for various reasons, the ADD_ADDR
could be sent after the "4th ACK", and the special case doesn't work.

On NIPA, the new test validating this special case for the C-flag failed
a few times, e.g.

  102 default limits, server deny join id 0
        syn rx                 [FAIL] got 0 JOIN[s] syn rx expected 2

  Server ns stats
  (...)
  MPTcpExtAddAddrTx  1
  MPTcpExtEchoAdd    1

  Client ns stats
  (...)
  MPTcpExtAddAddr    1
  MPTcpExtEchoAddTx  1

        synack rx              [FAIL] got 0 JOIN[s] synack rx expected 2
        ack rx                 [FAIL] got 0 JOIN[s] ack rx expected 2
        join Rx                [FAIL] see above
        syn tx                 [FAIL] got 0 JOIN[s] syn tx expected 2
        join Tx                [FAIL] see above

I had a suspicion about what the issue could be: the ADD_ADDR might have
been received after the switch to the 'fully-established' state. The
issue was not easy to reproduce. The packet capture shown that the
ADD_ADDR can indeed be sent with a delay, and the client would not try
to establish subflows to it as expected.

A simple fix is not to mark the endpoints as 'used' in the C-flag case,
when looking at creating subflows to the remote initial IP address and
port. In this case, there is no need to try.

Note: newly added fullmesh endpoints will still continue to be used as
expected, thanks to the conditions behind mptcp_pm_add_addr_c_flag_case.

Fixes: 4b1ff850e0c1 ("mptcp: pm: in-kernel: usable client side with C-flag")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251020-net-mptcp-c-flag-late-add-addr-v1-1-8207030cb0e8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index e0f44dc232aa..2ae95476dba3 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -370,6 +370,10 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 	}
 
 subflow:
+	/* No need to try establishing subflows to remote id0 if not allowed */
+	if (mptcp_pm_add_addr_c_flag_case(msk))
+		goto exit;
+
 	/* check if should create a new subflow */
 	while (msk->pm.local_addr_used < endp_subflow_max &&
 	       msk->pm.extra_subflows < limit_extra_subflows) {
@@ -401,6 +405,8 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			__mptcp_subflow_connect(sk, &local, &addrs[i]);
 		spin_lock_bh(&msk->pm.lock);
 	}
+
+exit:
 	mptcp_pm_nl_check_work_pending(msk);
 }
 


