Return-Path: <stable+bounces-163555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 411C5B0C1FE
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 12:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2AD1886273
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 10:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAF8291161;
	Mon, 21 Jul 2025 10:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IqkJSkgT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFB4290DB5
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 10:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753095381; cv=none; b=be2bxcg4pEftI04zc71svkCbL7oPH0mW2zNrWmDnrGhx0/vZB7mLthwYhpjXCshC5j144QWX0qIFackvOvnDxdDxknUQJaN8bmEe/IQ3E2tzakAB8l1GCUTibdlmmWJUhTm4ToOv8NhN1/ZfTLKS2HkUelHGm8mT7LQoXdogRbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753095381; c=relaxed/simple;
	bh=ddazhzfBpc+zdpFHLY6/r2O00N8GzR4wpRq4Qyy6LDM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=joLOZb5JIW6158Y3uRR/pnFLK8TJ43eKqJThoo758rzfpsa8oYRUYS1/iM7gBidxL75luAYsVXFV8FvuSXJM+y0aN28y9bRW8RlnWyeK7f3QhPVTeZkVX6XGkOXttEeUhRS7ma4s9Rak7Mv8OjIUK+JBhkQWLubcTgqmMJAWMs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IqkJSkgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9D4C4CEED;
	Mon, 21 Jul 2025 10:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753095380;
	bh=ddazhzfBpc+zdpFHLY6/r2O00N8GzR4wpRq4Qyy6LDM=;
	h=Subject:To:Cc:From:Date:From;
	b=IqkJSkgTeszHXG2nBssj2WieJoVMOukTA6FftrCSguAMtj32D/lVzp0MaWYrYR0rd
	 +VLYjGyNUnQqiHPfZ0TzBbPVidNVMyccJzXJb8KP9ElVy/8peXcREfewJieKNKhVDS
	 ORnYx8hh36jeTuoiC+d0fV6eFWTx71Ze5IShN7aY=
Subject: FAILED: patch "[PATCH] mptcp: reset fallback status gracefully at disconnect() time" failed to apply to 6.1-stable tree
To: pabeni@redhat.com,kuba@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Jul 2025 12:56:14 +0200
Message-ID: <2025072114-latch-paralysis-ee70@gregkh>
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
git cherry-pick -x da9b2fc7b73d147d88abe1922de5ab72d72d7756
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072114-latch-paralysis-ee70@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From da9b2fc7b73d147d88abe1922de5ab72d72d7756 Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Mon, 14 Jul 2025 18:41:46 +0200
Subject: [PATCH] mptcp: reset fallback status gracefully at disconnect() time

mptcp_disconnect() clears the fallback bit unconditionally, without
touching the associated flags.

The bit clear is safe, as no fallback operation can race with that --
all subflow are already in TCP_CLOSE status thanks to the previous
FASTCLOSE -- but we need to consistently reset all the fallback related
status.

Also acquire the relevant lock, to avoid fouling static analyzers.

Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250714-net-mptcp-fallback-races-v1-3-391aff963322@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bf92cee9b5ce..6a817a13b154 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3142,7 +3142,16 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	 * subflow
 	 */
 	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
+
+	/* The first subflow is already in TCP_CLOSE status, the following
+	 * can't overlap with a fallback anymore
+	 */
+	spin_lock_bh(&msk->fallback_lock);
+	msk->allow_subflows = true;
+	msk->allow_infinite_fallback = true;
 	WRITE_ONCE(msk->flags, 0);
+	spin_unlock_bh(&msk->fallback_lock);
+
 	msk->cb_flags = 0;
 	msk->recovery = false;
 	WRITE_ONCE(msk->can_ack, false);


