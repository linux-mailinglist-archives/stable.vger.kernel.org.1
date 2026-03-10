Return-Path: <stable+bounces-224309-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iA1ANO8BsGnOeQIAu9opvQ
	(envelope-from <stable+bounces-224309-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:35:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFA724B064
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A5AF30BD579
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E245338B7A6;
	Tue, 10 Mar 2026 11:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkTrlTHU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A602E38A710;
	Tue, 10 Mar 2026 11:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142004; cv=none; b=jJf8XalaA9rMD9WNgwDFE5CQ/ewe1xHfuUdh//sqXYd29KSW59uWBZhFeQRSwUGf2rAOkghfaLC4hHH1JHeAhnfd6r19Ydk/IemAwtC6baEJ//N62T2edD4LnNoifI97Ow0KAA6umKbHXGqRBTXUPD7o8ofl8WJlAjdc66eZGy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142004; c=relaxed/simple;
	bh=G5UVq+1QseGD+La/+F61V1kJGVC+6+aia55c/QpvpSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXArvCyL6RLOqEOPTTxszWgXV8g42nwBs/FbsIFVGy1maF4OsbBhQfasb1M5xgq1Ib6bubXTftndZF38QVD6IDcSSq0FJPOwyMdKl08pLZRObGBapSwa9nteGuSXgRfIUEn8Ii6bzW1ryqCFy9aUXYTG7CGmWjh0EVluVuXqHlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkTrlTHU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDEDC2BC86;
	Tue, 10 Mar 2026 11:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142004;
	bh=G5UVq+1QseGD+La/+F61V1kJGVC+6+aia55c/QpvpSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RkTrlTHUXJca0yrpt5gNYUeXAg+OwWZi5uhZLb8Wg05b/3mnBqXpyCJmc5cgRfc0U
	 cTC54uQd5H47KY4UfmSfyE+lC5wZHF8lCG1D9GHfwT9DxjFCMSPmFQyV8Bi/TodCTD
	 KeoTEzQ9NdJcGt3nj3MWHWr0k1lWtE06rJGfEm2eWVp4QtVlYnaihUlVSDJJ9zFid0
	 z4wQlPPV1rW13Qi5LmH2zeATp6gYPslaaPFsIZF196qNDJFvZcKt29thCAOLF+vv7D
	 X4HQfyQfdQxbB8MfFxkD0aakG3iNVVxzoLcPdWDbMNtadzEDWills2Hh4bI/y1hQyB
	 YkaGbdArqNFwg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.18 130/314] eventpoll: Fix integer overflow in ep_loop_check_proc()
Date: Tue, 10 Mar 2026 07:16:29 -0400
Message-ID: <db785e40145858f5eab8b3bec496737454408cde.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6EFA724B064
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224309-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,roeck-us.net:email]
X-Rspamd-Action: no action

From: Jann Horn <jannh@google.com>

commit fdcfce93073d990ed4b71752e31ad1c1d6e9d58b upstream.

If a recursive call to ep_loop_check_proc() hits the `result = INT_MAX`,
an integer overflow will occur in the calling ep_loop_check_proc() at
`result = max(result, ep_loop_check_proc(ep_tovisit, depth + 1) + 1)`,
breaking the recursion depth check.

Fix it by using a different placeholder value that can't lead to an
overflow.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: f2e467a48287 ("eventpoll: Fix semi-unbounded recursion")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
Link: https://patch.msgid.link/20260223-epoll-int-overflow-v1-1-452f35132224@google.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/eventpoll.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index ee7c4b683ec3d..bcc7dcbefc419 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2061,7 +2061,8 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
  * @ep: the &struct eventpoll to be currently checked.
  * @depth: Current depth of the path being checked.
  *
- * Return: depth of the subtree, or INT_MAX if we found a loop or went too deep.
+ * Return: depth of the subtree, or a value bigger than EP_MAX_NESTS if we found
+ * a loop or went too deep.
  */
 static int ep_loop_check_proc(struct eventpoll *ep, int depth)
 {
@@ -2080,7 +2081,7 @@ static int ep_loop_check_proc(struct eventpoll *ep, int depth)
 			struct eventpoll *ep_tovisit;
 			ep_tovisit = epi->ffd.file->private_data;
 			if (ep_tovisit == inserting_into || depth > EP_MAX_NESTS)
-				result = INT_MAX;
+				result = EP_MAX_NESTS+1;
 			else
 				result = max(result, ep_loop_check_proc(ep_tovisit, depth + 1) + 1);
 			if (result > EP_MAX_NESTS)
-- 
2.51.0


