Return-Path: <stable+bounces-239271-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEUODX1d5mmtvAEAu9opvQ
	(envelope-from <stable+bounces-239271-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:08:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4354309A2
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF0D135F2625
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7EB3368B2;
	Mon, 20 Apr 2026 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cDpDgoLe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F288E3368AE;
	Mon, 20 Apr 2026 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776699822; cv=none; b=XQlIZUXFSSsJPURgdIfaR8Lq5SqI8fTxRNXEOyxQkksQQ2aE/iVUS/YYQ/3wt110NgVH/j+NlgmwxoWbZEotu7BY1kuCxd2tYMNvvhFmO46UPu5cJH39DFvOS9twoyQTRCrc0YoQU+QHDAFuztR6HakhKiwWwX22cMUvmlce8CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776699822; c=relaxed/simple;
	bh=A8CIbig6OpoJgF81nlcDGMydIdku2f9hw9vJct0fpTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rg43U+L4j3YPCtgBI2vpH3pqji9SZwTYavo1JlxLjFhGNNLGNEF/GEmfcv0yG2YbeF65Jg9iuPpv35+aNL81n7myE2eMgA5EzJtgKgcDSKo1z5Y2xBzMYomeId5ajEtojSYiPUoPG/FP4sWoVY6j9o4wNCpYkoe6C188IgF8RtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cDpDgoLe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4192EC2BCB4;
	Mon, 20 Apr 2026 15:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776699821;
	bh=A8CIbig6OpoJgF81nlcDGMydIdku2f9hw9vJct0fpTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cDpDgoLe+dDxcg3QsCWmdu9Mc5vx/lmOkAplRla5EunbAr8tdANovFEsh2OWiEloj
	 fukKLukV6KiZC3FH2eqgrH2eTwvQqxOAUBrw4MIXcjmHpiZyPyneo4lfPusnxkW5vU
	 uYxkPXj6j7jiuHCOIiHalP2YLxewpRHpK+2orhz8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	stable <stable@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 7.0 11/76] bnge: return after auxiliary_device_uninit() in error path
Date: Mon, 20 Apr 2026 17:41:22 +0200
Message-ID: <20260420153911.231245432@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153910.810034134@linuxfoundation.org>
References: <20260420153910.810034134@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-239271-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,lunn.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: 8A4354309A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 8b0c25528cb64f71a73b5c0d49cbbcb68540a4ce upstream.

When auxiliary_device_add() fails, the error block calls
auxiliary_device_uninit() but does not return.  The uninit drops the
last reference and synchronously runs bnge_aux_dev_release(), which sets
bd->auxr_dev = NULL and frees the underlying object.  The subsequent
bd->auxr_dev->net = bd->netdev then dereferences NULL, which is not a
good thing to have happen when trying to clean up from an error.

Add the missing return, as the auxiliary bus documentation states is a
requirement (seems that LLM tools read documentation better than humans
do...)

Cc: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Fixes: 8ac050ec3b1c ("bng_en: Add RoCE aux device support")
Cc: stable <stable@kernel.org>
Assisted-by: gregkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/2026041124-banshee-molecular-0f70@gregkh
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnge/bnge_auxr.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
@@ -194,6 +194,7 @@ void bnge_rdma_aux_device_add(struct bng
 		dev_warn(bd->dev, "Failed to add auxiliary device for ROCE\n");
 		auxiliary_device_uninit(aux_dev);
 		bd->flags &= ~BNGE_EN_ROCE;
+		return;
 	}
 
 	bd->auxr_dev->net = bd->netdev;



