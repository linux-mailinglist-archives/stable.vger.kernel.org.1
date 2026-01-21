Return-Path: <stable+bounces-211122-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KK/uDM8zcWlQfQAAu9opvQ
	(envelope-from <stable+bounces-211122-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:15:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BC75CF29
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46BB08701C0
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4143D2FF0;
	Wed, 21 Jan 2026 18:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q4IWMVbG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516943E95B7;
	Wed, 21 Jan 2026 18:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020512; cv=none; b=gZ10cRySf60Gg2OvfcJn3Mi2goqAGXzusDogYjA/1ebsHqCcqCgOWSj7ZqiZLYnxzl87p48JsoUkquBelf66SXpM8rRCEHvMVkguWifssqnUqAOxZOQWI9rUUhjPK1ft1q8WuOP0hZQuDGCXmMCZc3mI/MavxNn77Al0LNSfdSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020512; c=relaxed/simple;
	bh=3B8JrZ25XOkAZ+6EJ79g4cuP6zs8wO7trjfqOnMjuxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GO7V2QDXZa6MPylO+9TkB8JYwUAwjlqWGMs6EsKXkQ4TRwaLQsfFCVBpG4i68t67WkKb0lz6ZhfgTuAq7kujTIcEIPd+9DMEMzwdrjvzSvhfxqt6JvJljgnkxB2YrVSaUcPJ2reCIvFqmMP40aKU4PFl7ww0vFsIcdQKajlj3pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q4IWMVbG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFFBC4CEF1;
	Wed, 21 Jan 2026 18:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020511;
	bh=3B8JrZ25XOkAZ+6EJ79g4cuP6zs8wO7trjfqOnMjuxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q4IWMVbGtRkM9Zbp4PGBCX3OYavBUnLKSajq8epcmAX13YIzH3nq1+qZykEB/jzE1
	 Z4DSxL+wZ2PL9TOHIIDOrhXBrPMIDPRM930CkodZNir8gioe5VgOVjYOXgOxeIP1KX
	 9aCFmOj2lifwAKLHcBtN1mpziOPAf1RFiGF+cnuM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Miaoqian Lin <linmq006@gmail.com>,
	Johan Hovold <johan@kernel.org>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.18 181/198] dmaengine: ti: dma-crossbar: fix device leak on dra7x route allocation
Date: Wed, 21 Jan 2026 19:16:49 +0100
Message-ID: <20260121181425.064717316@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,ti.com,gmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211122-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,msgid.link:url,ti.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 88BC75CF29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -288,6 +288,8 @@ static void *ti_dra7_xbar_route_allocate
 
 	ti_dra7_xbar_write(xbar->iomem, map->xbar_out, map->xbar_in);
 
+	put_device(&pdev->dev);
+
 	return map;
 }
 



