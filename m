Return-Path: <stable+bounces-226446-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GB6BLz2MuWnkJwIAu9opvQ
	(envelope-from <stable+bounces-226446-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:15:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D126E2AF33B
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 02AF730D22DE
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626953F7888;
	Tue, 17 Mar 2026 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rI0Yddr+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265063F23B3;
	Tue, 17 Mar 2026 16:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766753; cv=none; b=W406siqGNs4XCzrkT6Yg41yRdpPssyIXMKzC8+ONAmucWtNKLrcLo5T+WMLBFOxx3Fq8AEhviIUejtZHp9hBqFV/NMaevIqqsn/zw6q72FoL3jd7yTKd1rHrH198zkdj9WKqDMh1Dz0L9g5Vsmo/s6KvhkTJ1LETCE1wZFKhvEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766753; c=relaxed/simple;
	bh=c41x508jCE1MbwTQljA9weX5Qq3kJGPZ7JaxT3GvbCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldU0I4ojOrTzbzYIZX+eaMWuBAROoB8ynXU4dzzXqImbSaTzvndYG2s8upI3uYCTYExxtQCEcKfWZ1M/16Kztz9hAeAl0rLRVYCPp7Mc5WzR5AkpZm7kwu/LIrH0Q4/rLnymKtjXUq4/bA9DB09PWdsR5Nsdtm/Mp3svQ5okum0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rI0Yddr+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D64C4CEF7;
	Tue, 17 Mar 2026 16:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773766752;
	bh=c41x508jCE1MbwTQljA9weX5Qq3kJGPZ7JaxT3GvbCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rI0Yddr+UcelpBYe+ow6SHOLubi/sTCNWjYqMPWgHkR8WRYLltDYb40H8ZpMFsKDd
	 AXSSkkoYNNfyCezXKygx1/yRcKYS0FvgsAOcX5FAACpvYgHNd6WCIdArtSR8tNZ16l
	 1W6q8RRfgF+THb8MKFDUdGNkF/PkEbdgEe0Sx6YQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paul Moses <p@1g4.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.19 314/378] net-shapers: dont free reply skb after genlmsg_reply()
Date: Tue, 17 Mar 2026 17:34:31 +0100
Message-ID: <20260317163018.546504247@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226446-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D126E2AF33B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Moses <p@1g4.org>

commit 57885276cc16a2e2b76282c808a4e84cbecb3aae upstream.

genlmsg_reply() hands the reply skb to netlink, and
netlink_unicast() consumes it on all return paths, whether the
skb is queued successfully or freed on an error path.

net_shaper_nl_get_doit() and net_shaper_nl_cap_get_doit()
currently jump to free_msg after genlmsg_reply() fails and call
nlmsg_free(msg), which can hit the same skb twice.

Return the genlmsg_reply() error directly and keep free_msg
only for pre-reply failures.

Fixes: 4b623f9f0f59 ("net-shapers: implement NL get operation")
Fixes: 553ea9f1efd6 ("net: shaper: implement introspection support")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Moses <p@1g4.org>
Link: https://patch.msgid.link/20260309173450.538026-2-p@1g4.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/shaper/shaper.c |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -759,11 +759,7 @@ int net_shaper_nl_get_doit(struct sk_buf
 	if (ret)
 		goto free_msg;
 
-	ret = genlmsg_reply(msg, info);
-	if (ret)
-		goto free_msg;
-
-	return 0;
+	return genlmsg_reply(msg, info);
 
 free_msg:
 	nlmsg_free(msg);
@@ -1314,10 +1310,7 @@ int net_shaper_nl_cap_get_doit(struct sk
 	if (ret)
 		goto free_msg;
 
-	ret =  genlmsg_reply(msg, info);
-	if (ret)
-		goto free_msg;
-	return 0;
+	return genlmsg_reply(msg, info);
 
 free_msg:
 	nlmsg_free(msg);



