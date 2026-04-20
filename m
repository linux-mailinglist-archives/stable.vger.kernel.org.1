Return-Path: <stable+bounces-239423-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAtiOkxk5mkuvwEAu9opvQ
	(envelope-from <stable+bounces-239423-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:37:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A794319D4
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3367631721D6
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E02A32E696;
	Mon, 20 Apr 2026 15:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ApIIffSb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212912D77E5;
	Mon, 20 Apr 2026 15:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700215; cv=none; b=EnH6IN03SJQYAfGuJMMrD7qnVVvhrHlajN4WdS6wsMh9no2fo3rXKtG5eZqOXkKjdcPDvZHdEdh0Qw/WijSZMpTK0xWBtPa+3YqLcquAJqohsBJBp57WBo1EMMTD4GseruoAEnph/NysHMxRUiIEFFht0VEHiKQz6OUpMe95u+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700215; c=relaxed/simple;
	bh=Va19E4axzrKAiaYD1Elbi6redGQUpmC3Gfv+vMN3gg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U4qzubU0zooAzL2g30UP7CPNkyVCpkXTTk8jYm/zucAopKSQ2hNuIMNVNWTU5aklTU8Br477/wuJhBMSMN4VfQm0zabTu+kLnZO26WsykySVPzxgxGbxGsYfqqgwQHhCDPMhdKyY/u6be+OXLY8GagBD5HE/H+YHmNidlsFXbes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ApIIffSb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA887C2BCB6;
	Mon, 20 Apr 2026 15:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700215;
	bh=Va19E4axzrKAiaYD1Elbi6redGQUpmC3Gfv+vMN3gg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ApIIffSbCfkIaJ2YIXt1YlQZjElekhMLotKkaRGIdOX99IhAij6KKcDfwXNdb0MkY
	 s0S0xxL6yGeRiHeaKXHu6VIOq2i6rHBhT9U/y0N2EeeUOmCq7KWvfw1Qe+GRCdNWO6
	 a6gr0ebYDJkMlkKrL7TCsKsokDcUU3/P60F2TpRM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yiqi Sun <sunyiqixm@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 086/220] ipv4: icmp: fix null-ptr-deref in icmp_build_probe()
Date: Mon, 20 Apr 2026 17:40:27 +0200
Message-ID: <20260420153937.133762105@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-239423-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 63A794319D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yiqi Sun <sunyiqixm@gmail.com>

[ Upstream commit fde29fd9349327acc50d19a0b5f3d5a6c964dfd8 ]

ipv6_stub->ipv6_dev_find() may return ERR_PTR(-EAFNOSUPPORT) when the
IPv6 stack is not active (CONFIG_IPV6=m and not loaded), and passing
this error pointer to dev_hold() will cause a kernel crash with
null-ptr-deref.

Instead, silently discard the request. RFC 8335 does not appear to
define a specific response for the case where an IPv6 interface
identifier is syntactically valid but the implementation cannot perform
the lookup at runtime, and silently dropping the request may safer than
misreporting "No Such Interface".

Fixes: d329ea5bd884 ("icmp: add response to RFC 8335 PROBE messages")
Signed-off-by: Yiqi Sun <sunyiqixm@gmail.com>
Link: https://patch.msgid.link/20260402070419.2291578-1-sunyiqixm@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/icmp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index e619b73f5063e..11bda6c9eaa44 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -1333,6 +1333,13 @@ bool icmp_build_probe(struct sk_buff *skb, struct icmphdr *icmphdr)
 			if (iio->ident.addr.ctype3_hdr.addrlen != sizeof(struct in6_addr))
 				goto send_mal_query;
 			dev = ipv6_stub->ipv6_dev_find(net, &iio->ident.addr.ip_addr.ipv6_addr, dev);
+			/*
+			 * If IPv6 identifier lookup is unavailable, silently
+			 * discard the request instead of misreporting NO_IF.
+			 */
+			if (IS_ERR(dev))
+				return false;
+
 			dev_hold(dev);
 			break;
 #endif
-- 
2.53.0




