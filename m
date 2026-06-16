Return-Path: <stable+bounces-264382-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 26xyGVh3MWowkAUAu9opvQ
	(envelope-from <stable+bounces-264382-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:18:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DF8691EB2
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:18:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=lInZGqXF;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264382-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-264382-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5335D30D8D45
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476D646AEF0;
	Tue, 16 Jun 2026 15:59:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A35B4657CF;
	Tue, 16 Jun 2026 15:59:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625592; cv=none; b=g/4Vvw5YCLj+1NOWrzYeu7g9y79GCUSsHMjh5A6Zb6h1UHBoNL1piXtRk5NVxo/Tyj4JPIE/BPvZZd468oPX9azrehdztgvKtcCuOck3UzZN+DkEvPstRxcm1ezNjUbdsf9odRfkQokr8U0eijnIr0c1u62IfjOcml6MP9R8RvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625592; c=relaxed/simple;
	bh=7JWvoYyCEuERgLdFhzpSUHYtkHj2wTuDXYS2tPXOMJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJTuw0VJIChVoJyf3nDkbEh31Cqc193PcCkx5cCpjWfqVBGN3OdEqC+A4WbITAGG6MAPbKmvfTnRIxzq0CHddukRKmZ//kXr0OR8AQzqBp0tmllkidEE9LsUft/XkyEy88XcLjcJoT9CdUs51IKC/DXH7IensuOddN9LOjEBf6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lInZGqXF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9B61F000E9;
	Tue, 16 Jun 2026 15:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781625590;
	bh=ubBVsrjTsTzQaAd/YJmQo9qGvMiFXZsRF35kYbCWf/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lInZGqXFbTR7CgIexQFI7K/W1K8bt4APDlqyhEmVl8NaBT4rmqROutEni8sme+aod
	 ruOqxv5jgNYX2JH+hhn8yy1P6ujU7y4kAc764TsXkXySojnWkYJa4iwwQv6mMrfP1g
	 RZxnLEG3UdU1d09kOXBkhctNxanEHbrHhwOq4nBA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
	Karol Wachowski <karol.wachowski@linux.intel.com>
Subject: [PATCH 6.18 155/325] accel/ivpu: Add buffer overflow check in MS get_info_ioctl
Date: Tue, 16 Jun 2026 20:29:11 +0530
Message-ID: <20260616145105.453240343@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264382-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:andrzej.kacprowski@linux.intel.com,m:karol.wachowski@linux.intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,vger.kernel.org:from_smtp,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 85DF8691EB2

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>

commit fb176425837693f50c5c9fc8db6fbb04af22bd0a upstream.

Add validation that the info size returned from the metric stream info
query is not exceeded when checked against the allocated buffer size.
If the firmware returns a size larger than the buffer, reject the
operation with -EOVERFLOW instead of proceeding with an incorrect
buffer copy.

Fixes: cdfad4db7756 ("accel/ivpu: Add NPU profiling support")
Cc: stable@vger.kernel.org # v6.18+
Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Link: https://patch.msgid.link/20260529120841.135852-1-andrzej.kacprowski@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/accel/ivpu/ivpu_ms.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/accel/ivpu/ivpu_ms.c
+++ b/drivers/accel/ivpu/ivpu_ms.c
@@ -282,6 +282,13 @@ int ivpu_ms_get_info_ioctl(struct drm_de
 	if (ret)
 		goto unlock;
 
+	if (info_size > ivpu_bo_size(bo)) {
+		ivpu_warn_ratelimited(vdev, "MS info overflow: %#llx > %#zx\n",
+				      info_size, ivpu_bo_size(bo));
+		ret = -EOVERFLOW;
+		goto unlock;
+	}
+
 	if (args->buffer_size < info_size) {
 		ret = -ENOSPC;
 		goto unlock;



