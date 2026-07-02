Return-Path: <stable+bounces-270887-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bxy0HCiVRmprZAsAu9opvQ
	(envelope-from <stable+bounces-270887-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:43:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A986FA709
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:43:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=bo8oq9uW;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270887-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270887-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE842307F6CC
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC393469E7;
	Thu,  2 Jul 2026 16:35:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBE8208D0;
	Thu,  2 Jul 2026 16:35:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010110; cv=none; b=QyerYVWU7zYrSiwfbK4v7/JJnWPqfLcYWrfbitXTYO3iIjS+P8j7vU9NLvXQ1giQL2qoocCUwy72GpHJvqcR4AFtSxwXTyjLpca6bXTkGIpUVSV/frGLKEXm9qKMAWwdMUShM3YKC0tOT1HtuV1BNWGBHXoxG8dgHoN6xYw3MKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010110; c=relaxed/simple;
	bh=KyMesS+zvVHn8Os56w6itG4DO2Uxg7C9lrKyRxyDLlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pIxSP4NrLDaopfU77FmK6qBf/ySgvAFX/dXyUA+6YN+THBzoQh/jnh/cjtCjg3Mtjz/CpyFIfZf7GGnpSbidgdbwuGjVsr6bpStDdJ9bwYRcgSgFlR48ruyjkR8qpCFlDuUZT9jcHn8oLkbLBVs01AVgNf0sLI2+0bN6TaeibMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bo8oq9uW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84B01F000E9;
	Thu,  2 Jul 2026 16:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010109;
	bh=qtGr0BXHqVaBZ2iPUq3ycdZvK7/fGp+cNRN/f90w3hU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bo8oq9uWjN7onYLU4WXcrzcnX0EnuqgDC7E3C7ejMVxI8dlGiAVEe4Xvu/JOxbkiT
	 dAkMxQJgk9L9vUCHffOpBvsZi1M7Ht57Eo9JW2sx+z78cBpYHJicR2VpXNfYs1WqVd
	 UEEfCATu7L+/J4odWpMp4zQuGQV+ioDSH1JzidqI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Abel Vesa <abel.vesa@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 115/129] misc: fastrpc: Add dma_mask to fastrpc_channel_ctx
Date: Thu,  2 Jul 2026 18:20:34 +0200
Message-ID: <20260702155114.524870075@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155112.163984240@linuxfoundation.org>
References: <20260702155112.163984240@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270887-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:abel.vesa@linaro.org,m:srinivas.kandagatla@linaro.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linaro.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 30A986FA709

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Abel Vesa <abel.vesa@linaro.org>

[ Upstream commit 9bde43a0e2f469961e18d0a3496a9a74379c22bf ]

dma_set_mask_and_coherent only updates the mask to which the device
dma_mask pointer points to. Add a dma_mask to the channel ctx and set
the device dma_mask to point to that, otherwise the dma_set_mask will
return an error and the dma_set_coherent_mask will be skipped too.

Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20221125071405.148786-11-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 5401fb4fe10f ("misc: fastrpc: Fix NULL pointer dereference in rpmsg callback")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/fastrpc.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -262,6 +262,7 @@ struct fastrpc_channel_ctx {
 	struct fastrpc_device *fdevice;
 	bool secure;
 	bool unsigned_support;
+	u64 dma_mask;
 };
 
 struct fastrpc_device {
@@ -2175,6 +2176,7 @@ static int fastrpc_rpmsg_probe(struct rp
 	kref_init(&data->refcount);
 
 	dev_set_drvdata(&rpdev->dev, data);
+	rdev->dma_mask = &data->dma_mask;
 	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
 	INIT_LIST_HEAD(&data->users);
 	spin_lock_init(&data->lock);



