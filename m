Return-Path: <stable+bounces-237365-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FuZHmMm3WlpaQkAu9opvQ
	(envelope-from <stable+bounces-237365-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:22:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D15B63F146F
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5ADF30CA19E
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE833191D0;
	Mon, 13 Apr 2026 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lNPDmELY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2D8317153;
	Mon, 13 Apr 2026 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099266; cv=none; b=PHt+zu2jcjBnHiTVI5Ntdk0w3495A3BGtGA+0hmVdcEgSW702oJmNIfceWDLcdAG1rGyJWdoGquacvIBO9NWeIMnXvLuT5BPSpzoz+oWyDqHNNXJtkoh2pE6zIrLjcINpiU1XCyi0CTFdWAc9mBSK73HfxooatBfEumE/jG1vOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099266; c=relaxed/simple;
	bh=owfix4YtppS5voyG3xLmU4wuXaWYkyoR4B071hbc85k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPT/ukUonrsM0WW37m2VaAe4+hnA88PXrwTIts224paRNTpOuEINsrOMM8gfco9sEd3gw3/0R+8abKT653cEOgNgn7SyGpkC+CLq/uk79UXfk7/PE9U3ZdITfvDxNOZzT1h6UNt3d9SUlYbo2H7djbFeb22JRyiOhJ5bPeFXnMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lNPDmELY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006BEC2BCAF;
	Mon, 13 Apr 2026 16:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099266;
	bh=owfix4YtppS5voyG3xLmU4wuXaWYkyoR4B071hbc85k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lNPDmELY8ZmUpyTYrKRu3F0em0KRk1oPpc2ijYQkcr6jrT+8UtMJ663B6kihNlMLu
	 WzUPKJaDwUIQiccO6M+YK8DZQKTQC3valatLpWYRVRjCyrlipdy7hHNUgVIN1kHWrX
	 2YPjCVQfv81tD/p8sxXsi73dxM63bxK6mWIIY/jE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 247/491] xfrm: call xdo_dev_state_delete during state update
Date: Mon, 13 Apr 2026 17:58:12 +0200
Message-ID: <20260413155828.303455025@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237365-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:email]
X-Rspamd-Queue-Id: D15B63F146F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 7d2fc41f91bc69acb6e01b0fa23cd7d0109a6a23 ]

When we update an SA, we construct a new state and call
xdo_dev_state_add, but never insert it. The existing state is updated,
then we immediately destroy the new state. Since we haven't added it,
we don't go through the standard state delete code, and we're skipping
removing it from the device (but xdo_dev_state_free will get called
when we destroy the temporary state).

This is similar to commit c5d4d7d83165 ("xfrm: Fix deletion of
offloaded SAs on failure.").

Fixes: d77e38e612a0 ("xfrm: Add an IPsec hardware offloading API")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_state.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index b1243edf7f3a0..02d1d8d1fdea4 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1736,6 +1736,7 @@ int xfrm_state_update(struct xfrm_state *x)
 
 		err = 0;
 		x->km.state = XFRM_STATE_DEAD;
+		xfrm_dev_state_delete(x);
 		__xfrm_state_put(x);
 	}
 
-- 
2.51.0




