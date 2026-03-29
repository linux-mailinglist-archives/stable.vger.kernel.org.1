Return-Path: <stable+bounces-230979-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEb0IWWTyWkUzgUAu9opvQ
	(envelope-from <stable+bounces-230979-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 23:02:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE75354192
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 23:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BAA5300B04F
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 21:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9827926FA5A;
	Sun, 29 Mar 2026 21:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I9O6bENj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B5D288B1
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 21:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774818146; cv=none; b=SW6o6hqerMag3t07LoxJR5eedzkG0VFLfsRZ8Lit+p6lqng0NdkJ2RcT9lGbYc9jZysxdXxtp3AsgWHf1wk6h2cWLxNm0jdHViG0Hu9ka88ll1d8H8y+zQ6yyOl7kj3nDd95TWfqlIRK+vANIWZnmk9vFCsfpF5MBcDLg0omiCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774818146; c=relaxed/simple;
	bh=RnfKMTulXnDaJejM3PCyOXZ0EkY3dLy5kNm8nvZ82H0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CK/CRl4AFswyzR18KkX0nBVA56e8+jGGkC2hSZXzCIRDX/WcCTfy7+2dgksc+IyVe43uGnAnL5rXpeqwQ4Op5w8HvopMRVIJWVkBoI6F0GscI4puYjTgZogR2p7qMVmxDgSy27N4V/3QSw1czILWg5yfQC2jHmCsMYGPAza8uko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zsm.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I9O6bENj; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zsm.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c769e2b1bd0so191193a12.2
        for <stable@vger.kernel.org>; Sun, 29 Mar 2026 14:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774818144; x=1775422944; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FdWfTpsc5rmx5jWPbheMzBbhUbJNcmURCLYIiURnBQ0=;
        b=I9O6bENjtD2AXmGIc6AU1PtdDkw1lyta3QFMSdZ3cyjxY2vRoVpwiDRtTV7kSd55Dy
         Twh6FceLLzf65Lq2EHY/qVk7KaSIYY58OqZ7o92mbKl3uUt+2cxTWf8IYFnUMy4EZjD7
         tsv1OiYLdpm4XCgWYgemtVoAILH6G+sdeg4VmYNZO0HIV/oSySpcnDUIhmSmHNjfE1rm
         3P+4HJixWwUgaYFdKI/QFijAkZM6NdDdfpIiAjheDSucBg+/K6tWozy1sQV4poSZ4ZKp
         rPBUVbfgMtaG70BZolraKtNkkLKahx/BBNFnlawV4pafXVN7c9cT+FMhpr0OnrMZ0+Rg
         ohbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774818144; x=1775422944;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FdWfTpsc5rmx5jWPbheMzBbhUbJNcmURCLYIiURnBQ0=;
        b=Rimvx2uqEiCpnXyNmHnyvyWATR5qkTXrXynu6YoH8XuayJjgBoJrwQWXZ5osGgKxzN
         8aiwJh7LQohAQ9Mrz71LiNN5K5ZyLcQKUa1C7xShvaxvBJSG7BwwJJgnPC+qppHB/iJv
         SueMAwy3ctb1sTb5waGstN8wCXoSWxQa47y/YUlFA7rkjMoDcA3RSfZAmeH0gkUbPg4T
         85ouMuuQ083QX4zYro7HwAIX54wKL2rq1LJagMg5dbYCFF3ojL5I4YE/S3EH2vOCNDFr
         5siPN5IHul7zrP32o8/OrhFriXnvNWYOYKvbC//wt1rlUzFNDoVfM6iT+HsKvwFQzMtx
         LoCg==
X-Gm-Message-State: AOJu0YwbVbEs9AhxqS1VIzk422W3J7vqLOL8eZooeeeT5rAqdSL1cRcE
	Sl0uxw876tC8TKLS8zxVyeZ9OK5/haP4CGKebXpuiD7K9+0l8XS0gaNg61cXwnHtF6esUKcYWqL
	ARqOy039FU4gIsZ6qWVgVbMgam65TpCwOEK7r7ki8XW3kg+OEczNiY/bs/JNshwj3GM/3wNAYbt
	GZ7N/yvvg/PD/9CO1yQkxB
X-Received: from pfbfb11.prod.google.com ([2002:a05:6a00:2d8b:b0:82a:5ddb:b051])
 (user=zsm job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8018:b0:81f:3eda:9d69
 with SMTP id d2e1a72fcca58-82c95e59c17mr9269650b3a.22.1774818143956; Sun, 29
 Mar 2026 14:02:23 -0700 (PDT)
Date: Sun, 29 Mar 2026 21:02:20 +0000
In-Reply-To: <2026032948-available-paternity-6929@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026032948-available-paternity-6929@gregkh>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260329210220.152814-1-zsm@google.com>
Subject: [PATCH 6.12.y v2] virt: tdx-guest: Fix handling of host controlled
 'quote' buffer length
From: Zubin Mithra <zsm@google.com>
To: stable@vger.kernel.org
Cc: Zubin Mithra <zsm@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230979-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	URIBL_MULTI_FAIL(0.00)[intel.com:server fail,sea.lore.kernel.org:server fail];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zsm@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DCE75354192
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit c3fd16c3b98ed726294feab2f94f876290bf7b61 upstream.

Validate host controlled value `quote_buf->out_len` that determines how
many bytes of the quote are copied out to guest userspace. In TDX
environments with remote attestation, quotes are not considered private,
and can be forwarded to an attestation server.

Catch scenarios where the host specifies a response length larger than
the guest's allocation, or otherwise races modifying the response while
the guest consumes it.

This prevents contents beyond the pages allocated for `quote_buf`
(up to TSM_REPORT_OUTBLOB_MAX) from being read out to guest userspace,
and possibly forwarded in attestation requests.

Recall that some deployments want per-container configs-tsm-report
interfaces, so the leak may cross container protection boundaries, not
just local root.

Fixes: f4738f56d1dc ("virt: tdx-guest: Add Quote generation support using TSM_REPORTS")
Cc: stable@vger.kernel.org
Signed-off-by: Zubin Mithra <zsm@google.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Zubin Mithra <zsm@google.com>
---
 drivers/virt/coco/tdx-guest/tdx-guest.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index 224e7dde9cde..dc45e4c76a20 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -35,6 +35,8 @@
 #define GET_QUOTE_SUCCESS		0
 #define GET_QUOTE_IN_FLIGHT		0xffffffffffffffff
 
+#define TDX_QUOTE_MAX_LEN              (GET_QUOTE_BUF_SIZE - sizeof(struct tdx_quote_buf))
+
 /* struct tdx_quote_buf: Format of Quote request buffer.
  * @version: Quote format version, filled by TD.
  * @status: Status code of Quote request, filled by VMM.
@@ -162,6 +164,7 @@ static int tdx_report_new(struct tsm_report *report, void *data)
 	u8 *buf, *reportdata = NULL, *tdreport = NULL;
 	struct tdx_quote_buf *quote_buf = quote_data;
 	struct tsm_desc *desc = &report->desc;
+	u32 out_len;
 	int ret;
 	u64 err;
 
@@ -226,14 +229,21 @@ static int tdx_report_new(struct tsm_report *report, void *data)
 		goto done;
 	}
 
-	buf = kvmemdup(quote_buf->data, quote_buf->out_len, GFP_KERNEL);
+	out_len = READ_ONCE(quote_buf->out_len);
+
+	if (out_len > TDX_QUOTE_MAX_LEN) {
+		ret = -EFBIG;
+		goto done;
+	}
+
+	buf = kvmemdup(quote_buf->data, out_len, GFP_KERNEL);
 	if (!buf) {
 		ret = -ENOMEM;
 		goto done;
 	}
 
 	report->outblob = buf;
-	report->outblob_len = quote_buf->out_len;
+	report->outblob_len = out_len;
 
 	/*
 	 * TODO: parse the PEM-formatted cert chain out of the quote buffer when
-- 
2.53.0.1018.g2bb0e51243-goog


