Return-Path: <stable+bounces-237495-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGciMEQi3WndaAkAu9opvQ
	(envelope-from <stable+bounces-237495-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:05:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5503F3F0AD5
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 26723307FE89
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D29330B3A;
	Mon, 13 Apr 2026 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ivxNczE7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC4514F9FB;
	Mon, 13 Apr 2026 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099602; cv=none; b=eHOvwSL2UPQvU+euzXiMgOMgyCfNYUQEjLVxwcsJuFZ6hiAEZ/DBtsp5byf2eZ3c39xc764PXyHesQhqktF+FXxNg5DiCRGyEHrN/EHFYTfA0J7H9DTzB7r1dU1PlI/eX/b1bZi3TAXvSYZ9y8wKcrQoQk6XgZrXLwB5D5J+cOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099602; c=relaxed/simple;
	bh=In+pjPq36xU3hNtdcRjChLki03VPjcCU6jtY6wSbIr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QP1lmav+KUhAERF3RRSaX6FJz7t6QdK+Bz6wkgqWbQXXDV5PO3ZmJxiHDQsryfsy9ONCLvLLDgRmlRFZyGRfkX9GpyrAR5KdKwxuo0kftB33q4Mc4OUs9r33NUfb9KUtbdqx1Osb6baOlfnfneK95CnZMQo39DHXViTQCf6swxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ivxNczE7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FFEC2BCAF;
	Mon, 13 Apr 2026 17:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099602;
	bh=In+pjPq36xU3hNtdcRjChLki03VPjcCU6jtY6wSbIr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ivxNczE7iidyy35vmb0+/AqSrFXxmMzNmT55ydXoKayMpX0cuUreBNxnzlEizCMsA
	 vk9dGfYIjPL+C7wepG5aPzyj/6IslJ7Umxk/LWSM+A8qtqx2WQXoP36QCwV1gH5Zk1
	 +DUcU0UJnSykSpRWahL5Jp77Ub96WcG7KZznp5SM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Ao Zhou <n05ec@lzu.edu.cn>,
	Yuan Tan <tanyuan98@outlook.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10 403/491] vxlan: validate ND option lengths in vxlan_na_create
Date: Mon, 13 Apr 2026 18:00:48 +0200
Message-ID: <20260413155834.119482110@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,lzu.edu.cn,outlook.com,nvidia.com,blackwall.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-237495-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,outlook.com:email,blackwall.org:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,lzu.edu.cn:email,nvidia.com:email]
X-Rspamd-Queue-Id: 5503F3F0AD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yang Yang <n05ec@lzu.edu.cn>

commit afa9a05e6c4971bd5586f1b304e14d61fb3d9385 upstream.

vxlan_na_create() walks ND options according to option-provided
lengths. A malformed option can make the parser advance beyond the
computed option span or use a too-short source LLADDR option payload.

Validate option lengths against the remaining NS option area before
advancing, and only read source LLADDR when the option is large enough
for an Ethernet address.

Fixes: 4b29dba9c085 ("vxlan: fix nonfunctional neigh_reduce()")
Cc: stable@vger.kernel.org
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Tested-by: Ao Zhou <n05ec@lzu.edu.cn>
Co-developed-by: Yuan Tan <tanyuan98@outlook.com>
Signed-off-by: Yuan Tan <tanyuan98@outlook.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Yang Yang <n05ec@lzu.edu.cn>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://patch.msgid.link/20260326034441.2037420-4-n05ec@lzu.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/vxlan/vxlan_core.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2098,12 +2098,14 @@ static struct sk_buff *vxlan_na_create(s
 	ns_olen = request->len - skb_network_offset(request) -
 		sizeof(struct ipv6hdr) - sizeof(*ns);
 	for (i = 0; i < ns_olen-1; i += (ns->opt[i+1]<<3)) {
-		if (!ns->opt[i + 1]) {
+		if (!ns->opt[i + 1] || i + (ns->opt[i + 1] << 3) > ns_olen) {
 			kfree_skb(reply);
 			return NULL;
 		}
 		if (ns->opt[i] == ND_OPT_SOURCE_LL_ADDR) {
-			daddr = ns->opt + i + sizeof(struct nd_opt_hdr);
+			if ((ns->opt[i + 1] << 3) >=
+			    sizeof(struct nd_opt_hdr) + ETH_ALEN)
+				daddr = ns->opt + i + sizeof(struct nd_opt_hdr);
 			break;
 		}
 	}



