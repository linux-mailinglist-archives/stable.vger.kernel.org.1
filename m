Return-Path: <stable+bounces-210953-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCw9BLQqcWniewAAu9opvQ
	(envelope-from <stable+bounces-210953-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:36:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AD05C4BF
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20E8B62F987
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4960A397AD8;
	Wed, 21 Jan 2026 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qfi20CIK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C915636655D;
	Wed, 21 Jan 2026 18:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019940; cv=none; b=RCxFM9VuTrt6D5wXl7SqH+trNaUak2jkq+mTMHjj8QwqGxdxwpiFJhdFVGzmgC56RhOVrq6cOPsoP/nnclaCJBDAOlUpQeaRxhZkHsKcGwYI4iAzohnHzQbuSEgFShF1EgnQdsTpxHc5QZ5LjL8Y3jhAcXKldBxvesV2KHuGg68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019940; c=relaxed/simple;
	bh=ybdyyTlbSyUOcuopTcW3CxkWsMT4YUcezz59gCRAHbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JA7cQQiKeqQOJPf3g9Mupqam0eGHGhpmriiDxh7TvmvqT6ywLDU6n22VZGauZwK1C/OZQUdd7/3+7Wu1sN3l0nZDUFBbMx1klFAHGR3M6vPHtRa9dKH39gLhQuZJ6jSlUL5dL4yUSqDBRj7dt/yoIsiLKU+La83ippzJW8eJ3VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qfi20CIK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E22C4CEF1;
	Wed, 21 Jan 2026 18:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019940;
	bh=ybdyyTlbSyUOcuopTcW3CxkWsMT4YUcezz59gCRAHbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qfi20CIKmxtCuIdxiGNiaQcmfShfVxuRduOGgOYK2JF+yM2bP6eskPloEGZ5adFCC
	 dQKXiscRYmn31gdYgOaC9ZRzAZuNRLJ5j4F6j1J1WLYYjyfMDq8pkbZR3k0efFtHXj
	 Q8QFbe/xV90ih/xDMMSyUJJr71fxhrsJWURxdL/0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Antony Antony <antony.antony@secunet.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 013/198] xfrm: set ipv4 no_pmtu_disc flag only on output sa when direction is set
Date: Wed, 21 Jan 2026 19:14:01 +0100
Message-ID: <20260121181419.025386439@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	TAGGED_FROM(0.00)[bounces-210953-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,secunet.com:email]
X-Rspamd-Queue-Id: 87AD05C4BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antony Antony <antony.antony@secunet.com>

[ Upstream commit c196def07bbc6e8306d7a274433913444b0db20a ]

The XFRM_STATE_NOPMTUDISC flag is only meaningful for output SAs, but
it was being applied regardless of the SA direction when the sysctl
ip_no_pmtu_disc is enabled. This can unintentionally affect input SAs.

Limit setting XFRM_STATE_NOPMTUDISC to output SAs when the SA direction
is configured.

Closes: https://github.com/strongswan/strongswan/issues/2946
Fixes: a4a87fa4e96c ("xfrm: Add Direction to the SA in or out")
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_state.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 9e14e453b55cc..98b362d518363 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -3151,6 +3151,7 @@ int __xfrm_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack)
 	int err;
 
 	if (family == AF_INET &&
+	    (!x->dir || x->dir == XFRM_SA_DIR_OUT) &&
 	    READ_ONCE(xs_net(x)->ipv4.sysctl_ip_no_pmtu_disc))
 		x->props.flags |= XFRM_STATE_NOPMTUDISC;
 
-- 
2.51.0




