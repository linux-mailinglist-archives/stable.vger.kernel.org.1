Return-Path: <stable+bounces-261532-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rI4WEDpMJWqBGQIAu9opvQ
	(envelope-from <stable+bounces-261532-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:47:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D54864FFE7
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:47:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=RJv8CcEh;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261532-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-261532-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED17F3029AED
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F3D3195FD;
	Sun,  7 Jun 2026 10:41:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14922C1595;
	Sun,  7 Jun 2026 10:41:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780828911; cv=none; b=Xrnd2zSuoiTIrz+JqeAa7Y/pY2N72IKYamQMRbxV05OjELeBrYscUDHLiPnL3Ui4+XjHA+DDyXd51EsKF3Ixqn9Nx7elv2uPCOGu+7a89v/zYhNY6pttC9KuG9sTHnEophlbIaDAtSKAyJZDCpZG0DNCErkszaORhJdHzSt5G2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780828911; c=relaxed/simple;
	bh=8G9+w2rmC7bAVH/TdYobYqqO8tsUTznAnFz9JG4e+Og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UlNO++R6aUlOjPoO7AzLzsoAB0uNSIM4YILmETrECo9UTAm0UsiAhOjwV+5e0+vTcogWBPOtJXwsE+mE4yCiSpSe4/tacGFUbalsLPZH0mhHfBZLzkLtCfE93oVLzFXy8l78ISNvS9ekocMcqYrT5dV2f+ad3eLat7Kipzfrg+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RJv8CcEh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73741F00893;
	Sun,  7 Jun 2026 10:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780828910;
	bh=DZ9NNUAwvHevjJcvigCq6neJO8kcaI/zPt4i+XNF3P0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RJv8CcEhmfUSc67PvWVCoyEhbX29MwijNk99+r6otr+rTlh0/bj2clXIIFgh5BiXq
	 Htcq+4hfagg8V1tlHK8CFRNFWGfjDuerXnqVt7nggtGrIZvWD32YgNisFKNXNUqGMd
	 9bEJVo9bH75UjUz/VHIG8P3FND8RdLOm75mc9HKw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Yilin Zhu <zylzyl2333@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 6.18 201/315] xfrm: ipcomp: Free destination pages on acomp errors
Date: Sun,  7 Jun 2026 11:59:48 +0200
Message-ID: <20260607095734.955300363@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,lzu.edu.cn,gondor.apana.org.au,secunet.com];
	TAGGED_FROM(0.00)[bounces-261532-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:zylzyl2333@gmail.com,m:herbert@gondor.apana.org.au,m:steffen.klassert@secunet.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,secunet.com:email,vger.kernel.org:from_smtp,apana.org.au:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D54864FFE7

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

commit 7dbac7680eb629b3b4dc7e98c34f943b8814c0c8 upstream.

Move the out_free_req label up by a couple of lines so that the
allocated dst SG list gets freed on error as well as success.

Fixes: eb2953d26971 ("xfrm: ipcomp: Use crypto_acomp interface")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Reported-by: Yilin Zhu <zylzyl2333@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/xfrm/xfrm_ipcomp.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/net/xfrm/xfrm_ipcomp.c
+++ b/net/xfrm/xfrm_ipcomp.c
@@ -51,11 +51,15 @@ static int ipcomp_post_acomp(struct sk_b
 	struct scatterlist *dsg;
 	int len, dlen;
 
-	if (unlikely(err))
-		goto out_free_req;
+	if (unlikely(!req))
+		return err;
 
 	extra = acomp_request_extra(req);
 	dsg = extra->sg;
+
+	if (unlikely(err))
+		goto out_free_req;
+
 	dlen = req->dlen;
 
 	pskb_trim_unique(skb, 0);
@@ -84,10 +88,10 @@ static int ipcomp_post_acomp(struct sk_b
 		skb_shinfo(skb)->nr_frags++;
 	} while ((dlen -= len));
 
-	for (; dsg; dsg = sg_next(dsg))
+out_free_req:
+	for (; dsg && sg_page(dsg); dsg = sg_next(dsg))
 		__free_page(sg_page(dsg));
 
-out_free_req:
 	acomp_request_free(req);
 	return err;
 }



