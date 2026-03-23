Return-Path: <stable+bounces-228207-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFj7Mq9LwWlbSAQAu9opvQ
	(envelope-from <stable+bounces-228207-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:18:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9842F421E
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAE703121920
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D064E3B47F6;
	Mon, 23 Mar 2026 14:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bdq2Pkjg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DE43AF65B;
	Mon, 23 Mar 2026 14:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274449; cv=none; b=kulqTAboXXdWU9obKLfWpeGUhUmC7NUVv8KXIO24CM/MlMoAwKpS/X8Dwj7qc+jWtoPAjqB/GEBTRKvWOays9s6zNxCCYanqVDHLgsN9fTd0soeMRCQvYVa3kDiYcDPzgVoWTeH8dMR9Ozg+Cu7ru4EFUC48ZUk0/TobVT0TfiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274449; c=relaxed/simple;
	bh=7Tr5grAWwS3BoOeK24tYnVv1tz/zPedDcdZMZs8Z6/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b65IaD+2D9b5ZR3QMKroIrDCRUHsE7ErE1Iqcd+7ePErBL0i9F4RvPKs4QQXUAulwqBqV+Ax0v5Z449dHkzKoeSXM/KDn+5ZwcYAMJct54vvSyiwpQaIL2fGJcZCpiU8+nyh4tzFS5pCZJ4akwOmE6XZTX6PBIf9myhVJMMrMM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bdq2Pkjg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40FBC4CEF7;
	Mon, 23 Mar 2026 14:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274449;
	bh=7Tr5grAWwS3BoOeK24tYnVv1tz/zPedDcdZMZs8Z6/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bdq2PkjgumfTdL/4nYWMgn2MA06ClrYuK2k27B9ypBEJfrbLKh1v5uqVkwpnDkzA2
	 PLKEVkfbSKDZn7JEWkG3KgOy6QgmFtLwTCP7ezNrKbCprVst5hvGiQSScfKhHGyiNw
	 +WWMXV0dBIDC+Ux8HPi/m82iFzjfDe/2J/3G+UV8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Minhong He <heminhong@kylinos.cn>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 167/220] ipv6: add NULL checks for idev in SRv6 paths
Date: Mon, 23 Mar 2026 14:45:44 +0100
Message-ID: <20260323134509.827458756@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
References: <20260323134504.575022936@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228207-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1B9842F421E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Minhong He <heminhong@kylinos.cn>

[ Upstream commit 06413793526251870e20402c39930804f14d59c0 ]

__in6_dev_get() can return NULL when the device has no IPv6 configuration
(e.g. MTU < IPV6_MIN_MTU or after NETDEV_UNREGISTER).

Add NULL checks for idev returned by __in6_dev_get() in both
seg6_hmac_validate_skb() and ipv6_srh_rcv() to prevent potential NULL
pointer dereferences.

Fixes: 1ababeba4a21 ("ipv6: implement dataplane support for rthdr type 4 (Segment Routing Header)")
Fixes: bf355b8d2c30 ("ipv6: sr: add core files for SR HMAC support")
Signed-off-by: Minhong He <heminhong@kylinos.cn>
Reviewed-by: Andrea Mayer <andrea.mayer@uniroma2.it>
Link: https://patch.msgid.link/20260316073301.106643-1-heminhong@kylinos.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/exthdrs.c   | 4 ++++
 net/ipv6/seg6_hmac.c | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 310836a0cf17b..1d509b6d16bbd 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -379,6 +379,10 @@ static int ipv6_srh_rcv(struct sk_buff *skb)
 	hdr = (struct ipv6_sr_hdr *)skb_transport_header(skb);
 
 	idev = __in6_dev_get(skb->dev);
+	if (!idev) {
+		kfree_skb(skb);
+		return -1;
+	}
 
 	accept_seg6 = min(READ_ONCE(net->ipv6.devconf_all->seg6_enabled),
 			  READ_ONCE(idev->cnf.seg6_enabled));
diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
index ee6bac0160ace..e6964c6b0d381 100644
--- a/net/ipv6/seg6_hmac.c
+++ b/net/ipv6/seg6_hmac.c
@@ -184,6 +184,8 @@ bool seg6_hmac_validate_skb(struct sk_buff *skb)
 	int require_hmac;
 
 	idev = __in6_dev_get(skb->dev);
+	if (!idev)
+		return false;
 
 	srh = (struct ipv6_sr_hdr *)skb_transport_header(skb);
 
-- 
2.51.0




