Return-Path: <stable+bounces-213419-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OArC6Fbg2mYlwMAu9opvQ
	(envelope-from <stable+bounces-213419-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:45:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C2AE752D
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6A293010170
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F57410D10;
	Wed,  4 Feb 2026 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GyJ9FF4j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49458280A3B;
	Wed,  4 Feb 2026 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216274; cv=none; b=TBfPR/ImqpwD/XQfkRqn+zfEofYt6F49Wb/DN3K474ZroWg0/1xR1o3bNkM4ATX559aLzi+5lWS2ril16YWwYTJT8mZMIMFvFzJYFqiZ8xTL9rhCdXgRPDwoqO33JWS8X5xnvKD9WgxiWa2vVvztrPD7Sw2Uh+F6EF6LCndjqN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216274; c=relaxed/simple;
	bh=dWX8Po6kHgUmMzWuVYS7RPoEi2zdfuiapwGamTqV3B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNnQDwT9KMiwMO697S7A13b1g0wIvagUm0jcxb7T0kSVj4RpB9mLE3NJC1to0NPz88k6/U3GsA+8EYQrXM04hxGTZFf/F/57ckUMLOrUan8BbWKOJYlL6vRSQ1DHNCf/z3g8qSIerjPH1fddb+RmfTKEF7NXduiODZOfBWacoyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GyJ9FF4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B269C4CEF7;
	Wed,  4 Feb 2026 14:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770216273;
	bh=dWX8Po6kHgUmMzWuVYS7RPoEi2zdfuiapwGamTqV3B8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GyJ9FF4j154a7zlrsVVxclOHfaHbvJb77P4GH39BVyji6e51eUNWOjjI0xvvd7s1t
	 X/cXRFnA+fn1wWY64aYOJd4N/ZMGr3Zk1fyIXtdiC4bDWAM2D0Q4OfwEnl6xmt72MI
	 bOp18JlO6iDRwBxw8yFs8EWk04KnkRpOROs2BSSk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Miaoqian Lin <linmq006@gmail.com>,
	Johan Hovold <johan@kernel.org>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 5.10 040/161] dmaengine: ti: dma-crossbar: fix device leak on dra7x route allocation
Date: Wed,  4 Feb 2026 15:38:23 +0100
Message-ID: <20260204143853.206054775@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.755002596@linuxfoundation.org>
References: <20260204143851.755002596@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,ti.com,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-213419-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 26C2AE752D
X-Rspamd-Action: no action

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit dc7e44db01fc2498644e3106db3e62a9883a93d5 upstream.

Make sure to drop the reference taken when looking up the crossbar
platform device during dra7x route allocation.

Note that commit 615a4bfc426e ("dmaengine: ti: Add missing put_device in
ti_dra7_xbar_route_allocate") fixed the leak in the error paths but the
reference is still leaking on successful allocation.

Fixes: a074ae38f859 ("dmaengine: Add driver for TI DMA crossbar on DRA7x")
Fixes: 615a4bfc426e ("dmaengine: ti: Add missing put_device in ti_dra7_xbar_route_allocate")
Cc: stable@vger.kernel.org	# 4.2: 615a4bfc426e
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Miaoqian Lin <linmq006@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20251117161258.10679-14-johan@kernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/ti/dma-crossbar.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/dma/ti/dma-crossbar.c
+++ b/drivers/dma/ti/dma-crossbar.c
@@ -287,6 +287,8 @@ static void *ti_dra7_xbar_route_allocate
 
 	ti_dra7_xbar_write(xbar->iomem, map->xbar_out, map->xbar_in);
 
+	put_device(&pdev->dev);
+
 	return map;
 }
 



