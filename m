Return-Path: <stable+bounces-229651-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMQ6CPNwwWnmTAQAu9opvQ
	(envelope-from <stable+bounces-229651-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:57:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A586C2F92D7
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99A373237C05
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C33828751B;
	Mon, 23 Mar 2026 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TLomew6h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDC127E049;
	Mon, 23 Mar 2026 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282499; cv=none; b=YZsst8EFgMiqO4QeyfTAQZjgmbBEuSZHVjqD79Jvmd0oFHGJJqYh2L8CF7c5symxmzN/gOGVHAQxkf2/WABb9HrVZoTYpOMWL+ivGxLXGGDOxSzX7IkK0jyuFgvzoh0sMHlXwET20L8zGK1TERKySo0LxRm86w77jd8XBrWlqi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282499; c=relaxed/simple;
	bh=lrZdm6V6f+TXrN8KvqSF0cicG0WQ8xEu8wuZYyUC3fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKEAllRPW6zq5Q3SbA8Nzsbj/SU6s5hKzopMpIzOqZWu7jEEETxzH9pB7o/PYJSMsIFbbabSSrz4ERAp5UEdJxTnkT4BNEbSpxBt9lDX289CWPCfd0phNJwAxr7GDwPSWKd70QHrRzi1nmvqb05frBFTow+Cxp3HUR3D0/hHp7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TLomew6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04F4C4CEF7;
	Mon, 23 Mar 2026 16:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282499;
	bh=lrZdm6V6f+TXrN8KvqSF0cicG0WQ8xEu8wuZYyUC3fM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TLomew6hbxZKNGEtR8EViUwbBFVHQ6SJHIsBl3Q9UbCp8ndH1P7kDFHZey8+Q0oRe
	 zGM5AbwAaqecHqVYtCdAU6hIIMXr/8faA9Nv5An6YC/bESFAVitIDnP84eQn6XwBKP
	 0osvAd6vUWziM7Qb33FQPVii51PsUv26Tl4XHq5s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Dull <monderasdor@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 177/481] netfilter: x_tables: guard option walkers against 1-byte tail reads
Date: Mon, 23 Mar 2026 14:42:39 +0100
Message-ID: <20260323134529.528252794@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-229651-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,strlen.de,kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A586C2F92D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Dull <monderasdor@gmail.com>

[ Upstream commit cfe770220ac2dbd3e104c6b45094037455da81d4 ]

When the last byte of options is a non-single-byte option kind, walkers
that advance with i += op[i + 1] ? : 1 can read op[i + 1] past the end
of the option area.

Add an explicit i == optlen - 1 check before dereferencing op[i + 1]
in xt_tcpudp and xt_dccp option walkers.

Fixes: 2e4e6a17af35 ("[NETFILTER] x_tables: Abstraction layer for {ip,ip6,arp}_tables")
Signed-off-by: David Dull <monderasdor@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/xt_dccp.c   | 4 ++--
 net/netfilter/xt_tcpudp.c | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/xt_dccp.c b/net/netfilter/xt_dccp.c
index e5a13ecbe67a0..037ab93e25d0a 100644
--- a/net/netfilter/xt_dccp.c
+++ b/net/netfilter/xt_dccp.c
@@ -62,10 +62,10 @@ dccp_find_option(u_int8_t option,
 			return true;
 		}
 
-		if (op[i] < 2)
+		if (op[i] < 2 || i == optlen - 1)
 			i++;
 		else
-			i += op[i+1]?:1;
+			i += op[i + 1] ? : 1;
 	}
 
 	spin_unlock_bh(&dccp_buflock);
diff --git a/net/netfilter/xt_tcpudp.c b/net/netfilter/xt_tcpudp.c
index 11ec2abf0c727..73f50dc01b19f 100644
--- a/net/netfilter/xt_tcpudp.c
+++ b/net/netfilter/xt_tcpudp.c
@@ -56,8 +56,10 @@ tcp_find_option(u_int8_t option,
 
 	for (i = 0; i < optlen; ) {
 		if (op[i] == option) return !invert;
-		if (op[i] < 2) i++;
-		else i += op[i+1]?:1;
+		if (op[i] < 2 || i == optlen - 1)
+			i++;
+		else
+			i += op[i + 1] ? : 1;
 	}
 
 	return invert;
-- 
2.51.0




