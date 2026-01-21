Return-Path: <stable+bounces-210915-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2M7uHucicWl8eQAAu9opvQ
	(envelope-from <stable+bounces-210915-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:03:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EA68C5BC12
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CEC9B86F528
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F52A3559EE;
	Wed, 21 Jan 2026 18:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wgAx83Xx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE768330657;
	Wed, 21 Jan 2026 18:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019815; cv=none; b=tpjPZxpoZMdYESF9aAchUF19UtK0Xo+JU8qEoa//nkyxhlVZJdhBQuhP4zzj/Z/UuxaMZ7qoO9j0wnyZnLZ5J7I8q60Ujb9MnD/29MegUt+uIkTBOLa6dzjEaLSef7jtq8DhK2UDmofZwxPe5Z/tXwsSkqAlcMFI9Un3JjKYnTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019815; c=relaxed/simple;
	bh=hgsvrMsZFgDQ04WbiBEGlogcWZyDBPCH6vG5fJkkLvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSgoTHirl+iS5tlacdOmrdofs8AyJFXPz5xWt4GXMlDjitcWgB+C4DqITzIv/pKyXbuWYP39fc7N6scQ8HjDNChUyE7yj/WKXpPTQ/482/OJsFEsQJsfJZUNdbWE+tqHbP7QYNj7ZlME+eDOCBgZmYTaZLtH+mCtO8tnG7lueqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wgAx83Xx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A32C4CEF1;
	Wed, 21 Jan 2026 18:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019814;
	bh=hgsvrMsZFgDQ04WbiBEGlogcWZyDBPCH6vG5fJkkLvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wgAx83XxRkiAqEHMrrVQY8lXIylXjsrcxPscq/4tsFQQpI2DZU5l9tLUlWh8X4OcI
	 WF/fPlSyRQkqv55IPmGwAwJWBVQJ4l+0Mx5oR5RKOfgZM5RFJq/8HLxAAGPcA0o1eA
	 N1JmXj5a898Wzy4+RVyPNLVpWcfe7AAtq0BK1Hns=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miaoqian Lin <linmq006@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.12 115/139] dmaengine: qcom: gpi: Fix memory leak in gpi_peripheral_config()
Date: Wed, 21 Jan 2026 19:16:03 +0100
Message-ID: <20260121181415.590695129@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181411.452263583@linuxfoundation.org>
References: <20260121181411.452263583@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-210915-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: EA68C5BC12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miaoqian Lin <linmq006@gmail.com>

commit 3f747004bbd641131d9396d87b5d2d3d1e182728 upstream.

Fix a memory leak in gpi_peripheral_config() where the original memory
pointed to by gchan->config could be lost if krealloc() fails.

The issue occurs when:
1. gchan->config points to previously allocated memory
2. krealloc() fails and returns NULL
3. The function directly assigns NULL to gchan->config, losing the
   reference to the original memory
4. The original memory becomes unreachable and cannot be freed

Fix this by using a temporary variable to hold the krealloc() result
and only updating gchan->config when the allocation succeeds.

Found via static analysis and code review.

Fixes: 5d0c3533a19f ("dmaengine: qcom: Add GPI dma driver")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Link: https://patch.msgid.link/20251029123421.91973-1-linmq006@gmail.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/qcom/gpi.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -1614,14 +1614,16 @@ static int
 gpi_peripheral_config(struct dma_chan *chan, struct dma_slave_config *config)
 {
 	struct gchan *gchan = to_gchan(chan);
+	void *new_config;
 
 	if (!config->peripheral_config)
 		return -EINVAL;
 
-	gchan->config = krealloc(gchan->config, config->peripheral_size, GFP_NOWAIT);
-	if (!gchan->config)
+	new_config = krealloc(gchan->config, config->peripheral_size, GFP_NOWAIT);
+	if (!new_config)
 		return -ENOMEM;
 
+	gchan->config = new_config;
 	memcpy(gchan->config, config->peripheral_config, config->peripheral_size);
 
 	return 0;



