Return-Path: <stable+bounces-229770-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJBMD8x0wWkQTQQAu9opvQ
	(envelope-from <stable+bounces-229770-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:13:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 573012F99B9
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07E76319EDAE
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C33E3BBA08;
	Mon, 23 Mar 2026 16:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z/RFbYEr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2EF283FC8;
	Mon, 23 Mar 2026 16:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282821; cv=none; b=QR3cXiz/oeiwzMkcSf/lqDRobsQBzTsq/+NVgdrWmnRp6yff2uqzJLCN8RbPsG7YG1dh21HHZAFADXd/gK3j23vlDDo3CyP++DoAtAbIqAbTmE2Cif9MN7eLDgHS2+I2qR/aqfK1nZ1+pWZ5E9fQLBtn8wLRn6cMhumoavuqP1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282821; c=relaxed/simple;
	bh=WJOpoVvluYZu3s5VovzxCNV38zcRbLnIdvQGX8Spc7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MRJSs+JtExG0yJM/qubuJQ2T4xLLf6DgF+jMVBCo1u0/M5aTU3GYlpWcqtdkVQ/WMT+qGknWf4X9A0ugv7Xz/J6q+VlVOP3axaRHzGYqyS+P2ZT4PECBWvGqWbtQaraaGNvjoyltCGwo/OTKJlZomNi8WpEadlK21kk7hazweI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z/RFbYEr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44D7C4CEF7;
	Mon, 23 Mar 2026 16:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282821;
	bh=WJOpoVvluYZu3s5VovzxCNV38zcRbLnIdvQGX8Spc7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=z/RFbYEr84Wr7wTQJACM6SnTSIysMEemlhXSdQy9UGNz4Py+cd+sOYDkatqWwUuEr
	 I4MulYTMWlMVvLfRESFcFxxWHPuoST+PlHLYaHj/3vHp04ZwsdTkTibOy/sbW6GHLn
	 JaJNzNMBTaeLbv8Tg9e+X9W5K6nyYOp7VXJuIEA0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joerg.roedel@amd.com>
Subject: [PATCH 6.1 298/481] iommu/vt-d: Fix intel iommu iotlb sync hardlockup and retry
Date: Mon, 23 Mar 2026 14:44:40 +0100
Message-ID: <20260323134532.376675434@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229770-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 573012F99B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guanghui Feng <guanghuifeng@linux.alibaba.com>

commit fe89277c9ceb0d6af0aa665bcf24a41d8b1b79cd upstream.

During the qi_check_fault process after an IOMMU ITE event, requests at
odd-numbered positions in the queue are set to QI_ABORT, only satisfying
single-request submissions. However, qi_submit_sync now supports multiple
simultaneous submissions, and can't guarantee that the wait_desc will be
at an odd-numbered position. Therefore, if an item times out, IOMMU can't
re-initiate the request, resulting in an infinite polling wait.

This modifies the process by setting the status of all requests already
fetched by IOMMU and recorded as QI_IN_USE status (including wait_desc
requests) to QI_ABORT, thus enabling multiple requests to be resubmitted.

Fixes: 8a1d82462540 ("iommu/vt-d: Multiple descriptors per qi_submit_sync()")
Cc: stable@vger.kernel.org
Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Link: https://lore.kernel.org/r/20260306101516.3885775-1-guanghuifeng@linux.alibaba.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Fixes: 8a1d82462540 ("iommu/vt-d: Multiple descriptors per  qi_submit_sync()")
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/intel/dmar.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1282,7 +1282,6 @@ static int qi_check_fault(struct intel_i
 	if (fault & DMA_FSTS_ITE) {
 		head = readl(iommu->reg + DMAR_IQH_REG);
 		head = ((head >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
-		head |= 1;
 		tail = readl(iommu->reg + DMAR_IQT_REG);
 		tail = ((tail >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
 
@@ -1292,7 +1291,7 @@ static int qi_check_fault(struct intel_i
 		do {
 			if (qi->desc_status[head] == QI_IN_USE)
 				qi->desc_status[head] = QI_ABORT;
-			head = (head - 2 + QI_LENGTH) % QI_LENGTH;
+			head = (head - 1 + QI_LENGTH) % QI_LENGTH;
 		} while (head != tail);
 
 		if (qi->desc_status[wait_index] == QI_ABORT)



