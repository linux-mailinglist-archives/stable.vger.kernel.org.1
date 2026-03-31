Return-Path: <stable+bounces-231791-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DoTO7r7y2mwNAYAu9opvQ
	(envelope-from <stable+bounces-231791-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:52:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DB836D486
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F15A73277073
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A43425CCD;
	Tue, 31 Mar 2026 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ewh2Alou"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E41421A1D;
	Tue, 31 Mar 2026 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975078; cv=none; b=TjoE7J6uCrvlo/sYYjK53th/9ns7zZO3c7rhtk/6oTH2RRZRUAEhoF89tMybT5MtzjCgB2crsm8jWiJ5n+u+awQH576/sTEbjsdCg9rlJGP/oZA7LIr2gYxYsrE2HxFwlrJPh/kUitztq4N6LsoqWsbgAzUHXMa8D0A/dJKyPGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975078; c=relaxed/simple;
	bh=W3MQPQQd+msDjCqgfo0WCWsydHgSVqHODBQWdONKWA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ss2Hb7/uvgMC3nEeCYydu6I9xkf+dhEWPLnRse1uOMyCxA4vMCrvBtScMDBRM20YXggGMFlZLakj8OoaiK1+DyHMemEFuQVvk8hV1B/wCp1Bbf3NUvPB5wEsFpQhZ9h464ENgZ563w4JhOOyXdBlD3JLEbsIAhINMOmMZr81+ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ewh2Alou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CAFC4AF09;
	Tue, 31 Mar 2026 16:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975078;
	bh=W3MQPQQd+msDjCqgfo0WCWsydHgSVqHODBQWdONKWA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ewh2AlouuRvGmknVLHurKJArKBMZPRiS5wZc7GY/wqyMbxMffQuJyWMoTW2o6mTYg
	 9TFQOrwNR9f2bShnblV84rV/hACSQRhmL3C4jSg16cWfUU7Ndt43M9Xo1NQb4yBotR
	 HOOa7SHW4mBPjEvHHMAympGwrn03/tBcFor+IeaY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 154/342] RDMA/efa: Fix possible deadlock
Date: Tue, 31 Mar 2026 18:19:47 +0200
Message-ID: <20260331161804.675931906@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231791-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 84DB836D486
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ethan Tidmore <ethantidmore06@gmail.com>

[ Upstream commit 0f2055db7b630559870afb40fc84490816ab8ec5 ]

In the error path for efa_com_alloc_comp_ctx() the semaphore assigned to
&aq->avail_cmds is not released.

Detected by Smatch:
drivers/infiniband/hw/efa/efa_com.c:662 efa_com_cmd_exec() warn:
inconsistent returns '&aq->avail_cmds'

Add release for &aq->avail_cmds in efa_com_alloc_comp_ctx() error path.

Fixes: ef3b06742c8a2 ("RDMA/efa: Fix use of completion ctx after free")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
Link: https://patch.msgid.link/20260314045730.1143862-1-ethantidmore06@gmail.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/efa/efa_com.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/efa/efa_com.c b/drivers/infiniband/hw/efa/efa_com.c
index 56caba612139f..e97b5f0d70038 100644
--- a/drivers/infiniband/hw/efa/efa_com.c
+++ b/drivers/infiniband/hw/efa/efa_com.c
@@ -629,6 +629,7 @@ int efa_com_cmd_exec(struct efa_com_admin_queue *aq,
 	comp_ctx = efa_com_alloc_comp_ctx(aq);
 	if (!comp_ctx) {
 		clear_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state);
+		up(&aq->avail_cmds);
 		return -EINVAL;
 	}
 
-- 
2.53.0




