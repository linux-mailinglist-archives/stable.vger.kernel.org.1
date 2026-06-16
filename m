Return-Path: <stable+bounces-263966-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NVcSGLFrMWqciwUAu9opvQ
	(envelope-from <stable+bounces-263966-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:28:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F085691106
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:28:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=F6Hrm0no;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263966-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-263966-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8F35A309666B
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49574418F2;
	Tue, 16 Jun 2026 15:23:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E20C44104F;
	Tue, 16 Jun 2026 15:23:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623430; cv=none; b=L3+ubdnSE2uoyLxVGezfpHj1m1wywONDwy2wh+sikfMM8SyTf4wcTtuO23/eYgYJwdRh44KjogmM0myuCypooYP+RP6ZXo2iHRVNBTraxGnr0C5jI28jdnf/1RbNDw2EVESNFKT9NYhS1xSfrH3As2A7vLNAtdBTxe177J9OIdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623430; c=relaxed/simple;
	bh=buUFoTQ45nZ3db2dhSJNwrh0AXWQP2dfObJEKqi0v30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/LSCEdH91xV+MRHFbu05PEEFcEMiIaT56W9jTySr9H6mQCa+VbMwrwWMYUKhJxIHu1itHMDcwiz1jYHX+HWm9A/CW03J1hmxZ0MQG+60l7XtiWXDUPDqzQ4rX+YIfM4Oy4/DEMObAHycPV8bz+KQt3mRlNTLPsEGOYqr9M5U8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F6Hrm0no; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FEC1F000E9;
	Tue, 16 Jun 2026 15:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781623429;
	bh=iy3SV1I1DfNK0H+kyFxrJ6YAKCdx0aDZHZeCONxHtTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F6Hrm0no+cCKcYfWCb1cwvUIEgShc8D7isZ4X4c2LMhPxJPQ2UIxWffk0xbf6toSf
	 WUcmL3aouz5pDZf5Hp4bbrzc8nm7JK222CTHsS9fb/xoh/q5fOTISlRki4xCN+CNBF
	 VajSMGcigHf2foKGJAzjMEPaOmuUnGyC2Cdqb94k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sashiko <sashiko-bot@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 113/378] netdev: fix double-free in netdev_nl_bind_rx_doit()
Date: Tue, 16 Jun 2026 20:25:44 +0530
Message-ID: <20260616145116.316180952@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263966-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:sashiko-bot@kernel.org,m:bobbyeshleman@meta.com,m:daniel@iogearbox.net,m:razor@blackwall.org,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,iogearbox.net:email,blackwall.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F085691106

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit c849de7d8757a7af801fc4a4058f71d481d367f2 ]

Sashiko flags that genlmsg_reply() always consumes the skb.
The error path calls nlmsg_free(rsp) so we can't jump directly
to it. Let's not unbind, just propagate the error to the user.
This is the typical way of handling genlmsg_reply() failures.
They shouldn't happen unless user does something silly like
calling the kernel with an already-full rcvbuf.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 170aafe35cb9 ("netdev: support binding dma-buf to netdevice")
Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/netdev-genl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 470fabbeacd9bd..93ea09bd1e7bab 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -1019,8 +1019,6 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	genlmsg_end(rsp, hdr);
 
 	err = genlmsg_reply(rsp, info);
-	if (err)
-		goto err_unbind;
 
 	bitmap_free(rxq_bitmap);
 
@@ -1028,7 +1026,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 
 	mutex_unlock(&priv->lock);
 
-	return 0;
+	return err < 0 ? err : 0;
 
 err_unbind:
 	net_devmem_unbind_dmabuf(binding);
-- 
2.53.0




