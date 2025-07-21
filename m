Return-Path: <stable+bounces-163563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D59B0C2C3
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 13:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5DE43A6E23
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 11:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254D228FFDF;
	Mon, 21 Jul 2025 11:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BvnLArVy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D764A1EA7EB
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 11:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097008; cv=none; b=IBAScvPZK9U1EiB/3tv4i57AOIQ+IiXO9nWOJgfNG1KvQa03Lz81HblKt7SEX5ts2DI4w08H3ZUX6wAwQjtzwNGPk6yTFIdNKP5tzbkhBa+kk313zEimp1P+4qeKJGK9oq/DzYXRkph+QPc8JCtF9txSldn8OJVVK162p9XwMAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097008; c=relaxed/simple;
	bh=KBAScWu04Ll0ScDQI7IPEsOol0wqyJkwRCzz8GVYS+g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mVilQJEkMXiZUCzyi8nzZnN5ohfTZunBhvY3XV+r2NIdBYpjR82vcfFDkhGmKPD06itTb8bucKOt7KzJDvonZvR1ZcZJyHa/G4cqvsP8ESGdqhjdrBt24uLDZdYhtVyWToPquMx1iZ1Pc6Qy2dfhPoqmkF89y01wjg2ayvJcrOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BvnLArVy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4030C4CEED;
	Mon, 21 Jul 2025 11:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753097008;
	bh=KBAScWu04Ll0ScDQI7IPEsOol0wqyJkwRCzz8GVYS+g=;
	h=Subject:To:Cc:From:Date:From;
	b=BvnLArVy8ak6cJRlLNmxmkNQ5WNsMVMGoRnSFE1KkL+oEmoFRSqT9UhEyl9DDVcBo
	 3wt2Mv9HVlXZjrD2MXxsgYCsin2UgKdUgwPVXEtGZ+Sq5aTzQJPRl2iNKlk/KvZo5R
	 YQGom9AqBV7MOpw7ce832jG1ZdbStSz/1v9s+KrU=
Subject: FAILED: patch "[PATCH] mptcp: reset fallback status gracefully at disconnect() time" failed to apply to 6.6-stable tree
To: pabeni@redhat.com,kuba@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Jul 2025 13:23:24 +0200
Message-ID: <2025072124-runny-sublevel-69e9@gregkh>
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
git cherry-pick -x da9b2fc7b73d147d88abe1922de5ab72d72d7756
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072124-runny-sublevel-69e9@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


