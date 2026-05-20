Return-Path: <stable+bounces-250912-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHqUC3jqDWrM4gUAu9opvQ
	(envelope-from <stable+bounces-250912-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:08:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D6B592F6C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11052307750A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D9A28DC4;
	Wed, 20 May 2026 17:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M/e80+wH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5254D61FFE;
	Wed, 20 May 2026 17:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296631; cv=none; b=TmodpxL3G3t3lVU8RiCNDRTUPntfdxQiog2XrCUGbOVyf9rGTPjoG42oZolDt32EcNHP0N8jzmZrgTq+MdGTUbZch05TnfEx3OHzGdilbTm09jhD1uZOi/wJ2HwFYUTnv1UFTWFq8cVQxSCGJ8lvBRbhjDfTfGCZaUyYYIspmUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296631; c=relaxed/simple;
	bh=EXtHMObZJq+XpifWR7Vlsg5cozde5yAdNMXd2+5Fd68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8oNbVpsWA26uR+Og5ANElA8IPI4qf7+TdZMO5LAKfueMEUkYIhafZwLDrg3g7LDXqjKsYaeD+RHVZqvXy1TJNhnoVF3s1p/iPFydRrH+HVXeAn0b10vxmYqPms1vl2wIiT22JFgHElmczzA9vnTtcVLlH+gw3Qvu24xWcvqxCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M/e80+wH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE211F000E9;
	Wed, 20 May 2026 17:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296630;
	bh=mTl4n3O/cDFQxJefUyTJtOVBriVgdQ0CJJyWtxac4SU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M/e80+wH9xMLrwOSczxl8WaAxFRbn5PbNUSS/yXs6pDrWv3prfslFGTscQh9Hx9Sa
	 ozlrKkob8x6ckXPdmd8YbsyWY1cWi0ZVomFBIG+puRmxRQz+4+9JKgrRCEP7UZUB5b
	 tsIPeLF+Scyrn67YLgqYUuVtBMPW8r324IFIywLI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kohei Enju <kohei@enjuk.jp>,
	Simon Horman <horms@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0830/1146] net: validate skb->napi_id in RX tracepoints
Date: Wed, 20 May 2026 18:18:00 +0200
Message-ID: <20260520162207.015068275@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250912-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,linux.dev:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,enjuk.jp:email]
X-Rspamd-Queue-Id: A8D6B592F6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kohei Enju <kohei@enjuk.jp>

[ Upstream commit 3bfcf396081ace536733b454ff128d53116581e5 ]

Since commit 2bd82484bb4c ("xps: fix xps for stacked devices"),
skb->napi_id shares storage with sender_cpu. RX tracepoints using
net_dev_rx_verbose_template read skb->napi_id directly and can therefore
report sender_cpu values as if they were NAPI IDs.

For example, on the loopback path this can report 1 as napi_id, where 1
comes from raw_smp_processor_id() + 1 in the XPS path:

  # bpftrace -e 'tracepoint:net:netif_rx_entry{ print(args->napi_id); }'
  # taskset -c 0 ping -c 1 ::1

Report only valid NAPI IDs in these tracepoints and use 0 otherwise.

Fixes: 2bd82484bb4c ("xps: fix xps for stacked devices")
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Link: https://patch.msgid.link/20260420105427.162816-1-kohei@enjuk.jp
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/events/net.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/net.h b/include/trace/events/net.h
index fdd9ad474ce3a..dbc2c5598e35a 100644
--- a/include/trace/events/net.h
+++ b/include/trace/events/net.h
@@ -10,6 +10,7 @@
 #include <linux/if_vlan.h>
 #include <linux/ip.h>
 #include <linux/tracepoint.h>
+#include <net/busy_poll.h>
 
 TRACE_EVENT(net_dev_start_xmit,
 
@@ -208,7 +209,8 @@ DECLARE_EVENT_CLASS(net_dev_rx_verbose_template,
 	TP_fast_assign(
 		__assign_str(name);
 #ifdef CONFIG_NET_RX_BUSY_POLL
-		__entry->napi_id = skb->napi_id;
+		__entry->napi_id = napi_id_valid(skb->napi_id) ?
+				   skb->napi_id : 0;
 #else
 		__entry->napi_id = 0;
 #endif
-- 
2.53.0




