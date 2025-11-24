Return-Path: <stable+bounces-196735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B7FC80D8F
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 14:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E6E83A5C89
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 13:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F85830B515;
	Mon, 24 Nov 2025 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JEwPyfug"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBF226FDB2
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763992237; cv=none; b=dAfdAa42r1Ty1nolDPoYg8l86u2r6nG6DOPOujWZ/1pvH2z2c2FfsvxdS6eaIGQsVynaKaanlENaa/rujkp+/b4r1G03rw+t251bXqUrexPYdEIVTmg4r3zgtYXoBCXLqFTprtPIC67ZjaNrz5Tfaixn4eebUvYX/18NKIrdE7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763992237; c=relaxed/simple;
	bh=RdLDosm1ats0FUgMD9JiBGCnwY3aFw63HChcMJadLRo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nDsqfWD+sLKCuNiaUdQJhXTG3QIRBoN06g12ojbUbw2/U+vTcXscJY8ZX/evubZhvwykYyktEnqEBpkEkeP0P+cAu2WEVPtk7Hp9hj8PDCqoPHwqk8+gSSvik/Lq6d3NF/ak19uEgcF8avx5vEtDyCzATp9J+pbRA8w7glwe+/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JEwPyfug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC2DC4CEF1;
	Mon, 24 Nov 2025 13:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763992237;
	bh=RdLDosm1ats0FUgMD9JiBGCnwY3aFw63HChcMJadLRo=;
	h=Subject:To:Cc:From:Date:From;
	b=JEwPyfugKu7/5B4B0ptNWWbV+RE7xGunDvKWmp1JQQUvMk58KVXZE3UJ7L86pLewL
	 MhxW941EGyeJvUgNIf7Nh72Khar/BL0XC4gj1lfAsU0f6d04+kfMoJSOe76ef4kz3F
	 IIWVPhErHxKiCI3u+3BvxWgkBwhKmSLBIgxJI59E=
Subject: FAILED: patch "[PATCH] mptcp: do not fallback when OoO is present" failed to apply to 5.10-stable tree
To: pabeni@redhat.com,kuba@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Nov 2025 14:50:26 +0100
Message-ID: <2025112426-backroom-negate-d125@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 1bba3f219c5e8c29e63afa3c1fc24f875ebec119
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112426-backroom-negate-d125@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1bba3f219c5e8c29e63afa3c1fc24f875ebec119 Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 18 Nov 2025 08:20:22 +0100
Subject: [PATCH] mptcp: do not fallback when OoO is present

In case of DSS corruption, the MPTCP protocol tries to avoid the subflow
reset if fallback is possible. Such corruptions happen in the receive
path; to ensure fallback is possible the stack additionally needs to
check for OoO data, otherwise the fallback will break the data stream.

Fixes: e32d262c89e2 ("mptcp: handle consistently DSS corruption")
Cc: stable@vger.kernel.org
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/598
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251118-net-mptcp-misc-fixes-6-18-rc6-v1-4-806d3781c95f@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e30e9043a694..6f0e8f670d83 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -76,6 +76,13 @@ bool __mptcp_try_fallback(struct mptcp_sock *msk, int fb_mib)
 	if (__mptcp_check_fallback(msk))
 		return true;
 
+	/* The caller possibly is not holding the msk socket lock, but
+	 * in the fallback case only the current subflow is touching
+	 * the OoO queue.
+	 */
+	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue))
+		return false;
+
 	spin_lock_bh(&msk->fallback_lock);
 	if (!msk->allow_infinite_fallback) {
 		spin_unlock_bh(&msk->fallback_lock);


