Return-Path: <stable+bounces-234993-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHxABHyp1mlKHAgAu9opvQ
	(envelope-from <stable+bounces-234993-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:16:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABEB3C2A8C
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A503E3003EC7
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C248355F30;
	Wed,  8 Apr 2026 18:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sENC9HXI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42E725A321;
	Wed,  8 Apr 2026 18:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674294; cv=none; b=mpKmiBhNwGYxp9AUPxRt3Nd6IeSz+Lz3mozNoyX7Vm7aG1WlPcmwmNYyyETJxyMn43YmJhEROWDQIiy0yejabmHI0ZwBDu9lRKgPvHF2PhRzp02EfF5qB0coXr8IN0TOved72cJOXs7BEcdzQUHdNKotGa/65Iadw/GbXwoCcYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674294; c=relaxed/simple;
	bh=r7jNuEOrDmlOxJ77sMUC7nJR9KzVNiZz5eOWKi/lX/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJ3svNE5HflYzEQsIAV8pxL1vxQzLLAB07MuTRDn32xNQctcb2WzvKTJylnSmXg/26AmEhmSzP8+jhHG9KHw2ffCpsM5Ma7PaPG24ycvngRdvtDT2sIYF4Sk/HVf/OK0+uWckuytF+O/k6PHyEna/MA5ETG4SaHhwCNeBl+MhiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sENC9HXI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA48C19425;
	Wed,  8 Apr 2026 18:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674293;
	bh=r7jNuEOrDmlOxJ77sMUC7nJR9KzVNiZz5eOWKi/lX/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sENC9HXIZQdINp1aHI+e+LXd4FGraxFYxNRgd+5EG5fcZv070XV0EjgcbGHM5esGK
	 /RJWk3aE+5NM5V7pt6t+oMgJZAcqdoIfeWTOz59+gGy7j+86fitFrJEDLZbp22UCG7
	 GSq72/TGaduHuYWe1QH9Aq1Nn/xMnDF1xEVQamYo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qingfang Deng <dqfext@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 042/311] netdevsim: fix build if SKB_EXTENSIONS=n
Date: Wed,  8 Apr 2026 20:00:42 +0200
Message-ID: <20260408175940.985657407@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-234993-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 5ABEB3C2A8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qingfang Deng <dqfext@gmail.com>

[ Upstream commit 57a04a13aac1f247d171c3f3aef93efc69e6979e ]

__skb_ext_put() is not declared if SKB_EXTENSIONS is not enabled, which
causes a build error:

drivers/net/netdevsim/netdev.c: In function 'nsim_forward_skb':
drivers/net/netdevsim/netdev.c:114:25: error: implicit declaration of function '__skb_ext_put'; did you mean 'skb_ext_put'? [-Werror=implicit-function-declaration]
  114 |                         __skb_ext_put(psp_ext);
      |                         ^~~~~~~~~~~~~
      |                         skb_ext_put
cc1: some warnings being treated as errors

Add a stub to fix the build.

Fixes: 7d9351435ebb ("netdevsim: drop PSP ext ref on forward failure")
Signed-off-by: Qingfang Deng <dqfext@gmail.com>
Link: https://patch.msgid.link/20260324140857.783-1-dqfext@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/skbuff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 112e48970338f..13c6eca3bbc69 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -5093,6 +5093,7 @@ static inline bool skb_has_extensions(struct sk_buff *skb)
 	return unlikely(skb->active_extensions);
 }
 #else
+static inline void __skb_ext_put(struct skb_ext *ext) {}
 static inline void skb_ext_put(struct sk_buff *skb) {}
 static inline void skb_ext_reset(struct sk_buff *skb) {}
 static inline void skb_ext_del(struct sk_buff *skb, int unused) {}
-- 
2.53.0




