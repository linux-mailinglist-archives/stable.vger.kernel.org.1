Return-Path: <stable+bounces-220344-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJFZOAAzo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220344-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:25:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA841C5C3F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CB3E431A4A74
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7618F39B953;
	Sat, 28 Feb 2026 17:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igZzlX/3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3879839B949;
	Sat, 28 Feb 2026 17:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300243; cv=none; b=Vk3xK8isTtne374pkg/sD/u/D2CG9iOMnhwUwvLXpj7yPWLMU7SCiMbuRRm0EXQGADuNkdLibS93qOfn3LyGa8j/tz9w9a/KV9W+sWAvxbNjlxggVCoOUU4TKmeXh7joAb/w5QycyGJsZfLaBYcZVzimpu+ziFFDan1/NTmkDs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300243; c=relaxed/simple;
	bh=1eJRIi7rZxnG0yH3rK9b/31SZFamPACMOK8xQRNA2Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCrbFCujg9oNy1lkSyU7cKEkkfSCyIk/vxH/y6GBUo1Y9o9dszHjRVzZZXi4wSqYYgFqxhQcevqrITtmcikgRO1t7DKVgeSCgEEKkjwSNYBvnPhUoPkpQ3nBLf9tuw9K/fF2ypKISqFbbZECP3/yiuAZkSMAO37PwM/oS3P3hUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igZzlX/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776F0C19423;
	Sat, 28 Feb 2026 17:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300243;
	bh=1eJRIi7rZxnG0yH3rK9b/31SZFamPACMOK8xQRNA2Kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=igZzlX/3e8YEEW5RBFXzViJKsxIuZ+/8QgbnxSg9TcDFpcljDKqPjQBwrRcTKcwO8
	 SplpjvZvZXvzJoKKqT6LJPZBawC/5sMk8Ar6zc89thoZf439wAXhauanPjqhD+MBBi
	 zexuL2+hEbv748Rm/XekBekyjCqWJ9KssfAVuKDkYJ/LQr8/4vwIqfWqExMvibS3Tq
	 UJbBkKKVj02HXlDtOwtqNrPwBCA4oSyVgjnV6H0J0FA0BZU1AoLOdOyog40KGAjW09
	 W7mU3h6Mu/de0Sc2Kt3sMMKXFaQs3dWHL5EEIKkJR8VrmbhVt+gksLM/4nRVZ+hw6K
	 ee70c/mmZKi6Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Slark Xiao <slark_xiao@163.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 266/844] net: wwan: mhi: Add network support for Foxconn T99W760
Date: Sat, 28 Feb 2026 12:22:59 -0500
Message-ID: <20260228173244.1509663-267-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[163.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220344-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 8CA841C5C3F
X-Rspamd-Action: no action

From: Slark Xiao <slark_xiao@163.com>

[ Upstream commit 915a5f60ad947e8dd515d2cc77a96a14dffb3f15 ]

T99W760 is designed based on Qualcomm SDX35 chip. It use similar
architecture with SDX72/SDX75 chip. So we need to assign initial
link id for this device to make sure network available.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
Link: https://patch.msgid.link/20260105022646.10630-1-slark_xiao@163.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wwan/mhi_wwan_mbim.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
index f8bc9a39bfa30..1d7e3ad900c12 100644
--- a/drivers/net/wwan/mhi_wwan_mbim.c
+++ b/drivers/net/wwan/mhi_wwan_mbim.c
@@ -98,7 +98,8 @@ static struct mhi_mbim_link *mhi_mbim_get_link_rcu(struct mhi_mbim_context *mbim
 static int mhi_mbim_get_link_mux_id(struct mhi_controller *cntrl)
 {
 	if (strcmp(cntrl->name, "foxconn-dw5934e") == 0 ||
-	    strcmp(cntrl->name, "foxconn-t99w640") == 0)
+	    strcmp(cntrl->name, "foxconn-t99w640") == 0 ||
+	    strcmp(cntrl->name, "foxconn-t99w760") == 0)
 		return WDS_BIND_MUX_DATA_PORT_MUX_ID;
 
 	return 0;
-- 
2.51.0


