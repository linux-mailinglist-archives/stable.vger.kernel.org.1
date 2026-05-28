Return-Path: <stable+bounces-255825-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMMkJGyoGGpolwgAu9opvQ
	(envelope-from <stable+bounces-255825-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:41:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8095F951C
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BF2C30FDEE5
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C091A317163;
	Thu, 28 May 2026 20:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z6+vEEtR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7612DDC5;
	Thu, 28 May 2026 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999985; cv=none; b=KbvgDuazLmyuCV5UbSCG2AjGkPTkoC9IO/4/oWW4p8tAnkdMM7VKZtOf38B3qQ8V1rqdAstlrbTAGcboZA7k3G+0uh35A3cYI6zhVdynS0a8DpStwVvJxGNU7s1x+QpX813S+0U4yRRtXbvNOCy8JRxLXXXz8YVmrcxLk7CUI/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999985; c=relaxed/simple;
	bh=s5ZO53AkEMjh3bx5sP6227xdzBruydUm/27oMOssvec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9LMBY8Qe/T/pii6+xC3r3G37QvwvBetUJGbiBF8gjzhN+S/zsFG6JWl7H66lGmsEyyw9ZljYigLoWkVV7weWT2uaf+VjDnkNGY6u4x+uWg+rq1lnrSkJZ9KfbmnOazQCi68op0PmVsxI/0xOhjQnucNGTilu6WrcbyW4PmsSAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z6+vEEtR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDD31F000E9;
	Thu, 28 May 2026 20:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999984;
	bh=66PNjGP9sJ36OMmlKeGd62xwvpVGezP6LJSlrfH92CU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z6+vEEtRLg5tXtF1p8z5EkUnCY+pLZUtlEKVBl0MbsrpFkMISuf4vCJ1SMwLmYJ7O
	 Xzu+SjjrVXUrUlsW2Ce6okDvovubXcQi4UqEEJspT1NHSQRK57rq8F0JBXRsHCAeGg
	 8uvgfMivzKS+b7r0i1bwE50OQBxyHn6zy+nHmK/M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 260/377] net: shaper: set ret to -ENOMEM when genlmsg_new() fails in group_doit
Date: Thu, 28 May 2026 21:48:18 +0200
Message-ID: <20260528194645.898245114@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255825-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 0C8095F951C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 8054f85b83f42a37d482fc77ea7c9ff06a9407d9 ]

genlmsg_new() alloc failure path in net_shaper_nl_group_doit() forgets
to set ret before jumping to error handling.

Fixes: 5d5d4700e75d ("net-shapers: implement NL group operation")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Link: https://patch.msgid.link/20260510192904.3987113-6-kuba@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/shaper/shaper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index ae19af13c2247..ee0d1f0613430 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -1277,8 +1277,10 @@ int net_shaper_nl_group_doit(struct sk_buff *skb, struct genl_info *info)
 	 * rollback on allocation failure.
 	 */
 	msg = genlmsg_new(net_shaper_handle_size(), GFP_KERNEL);
-	if (!msg)
+	if (!msg) {
+		ret = -ENOMEM;
 		goto free_leaves;
+	}
 
 	hierarchy = net_shaper_hierarchy_setup(binding);
 	if (!hierarchy) {
-- 
2.53.0




