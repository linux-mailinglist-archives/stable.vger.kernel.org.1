Return-Path: <stable+bounces-229152-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJezHUNZwWnbSQQAu9opvQ
	(envelope-from <stable+bounces-229152-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:16:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 241952F613F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17A0F3045840
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C572566D3;
	Mon, 23 Mar 2026 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aXGr+RHy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825B0248883;
	Mon, 23 Mar 2026 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278225; cv=none; b=jRSjCpjrZbDBj7ins1QiRsISVBn3eztlRIat6YWvqqzTbPYfTkDlStQIHcpOKDEsuNQZotG6VYizYHqf19kEVTNzWH9DiLY7zlsrOEPY2sHToGP+waHXPiY0wr2C+yCodIuYK6P3X7BDFZhX5BTz3UFKFrJlfruNnuhWQOI4WkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278225; c=relaxed/simple;
	bh=iJRZb26qwjjTw53ukgy3YzDf8yR0taQ6EGDWdatcgKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=drhhYj3srUSmHYIrqM9P8VUtLC8nDAEpFw+wWU9bPoVaVuWxIbKUbbNvkX6rDgGJbxBsJc2+9vMcA1C/wjT7P4dKmPUduJdspzhOjKi1kIRIxfxp/w6DMz49jDanKtbORp6mpaep53ECBtUTKKSCVDqTtlgQL7COq6sbwgb+5xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aXGr+RHy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C954BC2BCB3;
	Mon, 23 Mar 2026 15:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278225;
	bh=iJRZb26qwjjTw53ukgy3YzDf8yR0taQ6EGDWdatcgKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aXGr+RHyTeQB0muYxM0dWR0kTqb9y6ce+k5ST8szMhSL6vA4HmG8KalnI/XqSNYfQ
	 S0E9jH+KIPD9jS2ShvF0Py8LxB0IYDlsR0dxHHRm4U+BijP9pQWloT3ukUKZ51ShxC
	 gdEOrnGFtJLfmUp8Xe371qa6u5uyz6YLskOmvLQw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Dull <monderasdor@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 241/567] netfilter: x_tables: guard option walkers against 1-byte tail reads
Date: Mon, 23 Mar 2026 14:42:41 +0100
Message-ID: <20260323134539.796238717@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-229152-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,strlen.de,kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
X-Rspamd-Queue-Id: 241952F613F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index e8991130a3de0..f76cf18f1a244 100644
--- a/net/netfilter/xt_tcpudp.c
+++ b/net/netfilter/xt_tcpudp.c
@@ -59,8 +59,10 @@ tcp_find_option(u_int8_t option,
 
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




