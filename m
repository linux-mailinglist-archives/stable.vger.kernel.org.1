Return-Path: <stable+bounces-239671-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qII3KiZn5mmlvwEAu9opvQ
	(envelope-from <stable+bounces-239671-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:49:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3FC432235
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 619B732C0B18
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AF633F8DC;
	Mon, 20 Apr 2026 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d3erhsxT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB7E33F5BC;
	Mon, 20 Apr 2026 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700921; cv=none; b=vEuP2BiX7abXoYfd6oissqW6bx43Vu+7u2l/MFsNq9VPHLwqLV+u733latMRg6Mma3OjXT+8JPHspp8gq63ol9bu/HbnvR22MI/uyGLGfmW8jUrXCCFHV/XS9gP174u9/o9EFwOEgUhUKT0Lwa/JPiJCdqzotAMKujNFzfX8m1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700921; c=relaxed/simple;
	bh=slaXQf7S/oqhzY5I+2Q/0pxspxxF5RDl1O83f1F4eu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1Ha0OA7OYxciCP25qc/8OV286yHjyS+uvqTAjG6e0/hrREk6PWyYXLWBkaE8o56MiQxLUrkq0swYfo992Y6IFjTq2uwmUUSDEiiGLqjBPQB+yWrDfkitCVDEvs6EoccMYDwFP+SV8BDRWEMZJB4TX68jrewv6NjBolvXgXzecE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d3erhsxT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C03C2BCB4;
	Mon, 20 Apr 2026 16:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700921;
	bh=slaXQf7S/oqhzY5I+2Q/0pxspxxF5RDl1O83f1F4eu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d3erhsxTmeBlBC3ddysatc0CEbUcWa/9Qt4zhYbQ5lP0OYCAEr3vMP+V3fsKOhHrm
	 NwusoxFrqeUDZL6Mfa9p0M7rLRHwo3rIksn63mN3iQXEmkiICQCOdIe7Hl23TygM+C
	 YjAJ/OLQD9atP8bquB3bNcEjsMRFQt+UzjzRHvVU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chris J Arges <carges@cloudflare.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 079/198] net: increase IP_TUNNEL_RECURSION_LIMIT to 5
Date: Mon, 20 Apr 2026 17:40:58 +0200
Message-ID: <20260420153938.453482819@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153935.605963767@linuxfoundation.org>
References: <20260420153935.605963767@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239671-lists,stable=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[msgid.link:server fail,sea.lore.kernel.org:server fail,cloudflare.com:server fail,linuxfoundation.org:server fail];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 0E3FC432235
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris J Arges <carges@cloudflare.com>

[ Upstream commit 77facb35227c421467cdb49268de433168c2dcef ]

In configurations with multiple tunnel layers and MPLS lwtunnel routing, a
single tunnel hop can increment the counter beyond this limit. This causes
packets to be dropped with the "Dead loop on virtual device" message even
when a routing loop doesn't exist.

Increase IP_TUNNEL_RECURSION_LIMIT from 4 to 5 to handle this use-case.

Fixes: 6f1a9140ecda ("net: add xmit recursion limit to tunnel xmit functions")
Link: https://lore.kernel.org/netdev/88deb91b-ef1b-403c-8eeb-0f971f27e34f@redhat.com/
Signed-off-by: Chris J Arges <carges@cloudflare.com>
Link: https://patch.msgid.link/20260402222401.3408368-1-carges@cloudflare.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/ip_tunnels.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 80662f8120803..253ed3930f6ef 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -32,7 +32,7 @@
  * recursion involves route lookups and full IP output, consuming much
  * more stack per level, so a lower limit is needed.
  */
-#define IP_TUNNEL_RECURSION_LIMIT	4
+#define IP_TUNNEL_RECURSION_LIMIT	5
 
 /* Keep error state on tunnel for 30 sec */
 #define IPTUNNEL_ERR_TIMEO	(30*HZ)
-- 
2.53.0




