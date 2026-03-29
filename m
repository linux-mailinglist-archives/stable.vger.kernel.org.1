Return-Path: <stable+bounces-230977-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YieNJByQyWl3zQUAu9opvQ
	(envelope-from <stable+bounces-230977-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 22:48:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A6C3540ED
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 22:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8223B300353E
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 20:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6807029B766;
	Sun, 29 Mar 2026 20:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cPzOBOFA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808242BAF7
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 20:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774817305; cv=none; b=GaCoDtzkiVUj3J364+jo/w7pNERGPva4t6ZRw6G2sfgezJyYxZnrKeMBZDELlrDplQRwmgxE/IXi2kcEV2P/07+bGra5pCpNRVMWLbaj1hiKY35Kpge160vAHjxpbjHZjlGbpA76cljWCHbQapr9nNnnzi321bYFFdOlnOLch2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774817305; c=relaxed/simple;
	bh=rGpi4bEZ9S+3wm989nG1OFcyD7k3Y34M5MmQzP2DEeo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jhnMioSzrCiBipetcrVchiuBJ3RfUYuvPAvQTTdhE4VShc7seFzGJcRvbYSRuJxv/BoLbbF1L4vw3mn1eoGmnLAL/qDF55Y4Tzin+hmbZWb/aUES9O2zUZyf2L4udNuq5Jtk33rKHf3VjygsolBdNhz1fKm/aGbA/zHR+8Ntmsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zsm.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cPzOBOFA; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zsm.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82ca8323edbso2485649b3a.1
        for <stable@vger.kernel.org>; Sun, 29 Mar 2026 13:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774817303; x=1775422103; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cfjBoYNSLOamx/UW91atzNiaxMJtbW4Jkc7q3T2fN2k=;
        b=cPzOBOFAxR0Psl27FfO1NNSI2QgU0bFNR6iK3U+2Ug3TDzObb6lObjjj+DP8gPIR3W
         OM5lbVAoez632bOWDc6Lk6XfyDxIqG8vnsgWmRgKtrS6oqqpDH0oAAYPj8i1r2T+2960
         Uiqk6xu9ug9vf0YViOmaL21zk4fpYe3hp459D+oSRxJ5XZVOCkSZSt33rbxjGEHzGHXQ
         1KrvVBkpGb1SG38jdpx4YLsA0vXdR0Ee2unZPSpErOF27m9zPP6xaKrF0gAZFf700KoC
         ckEVsoQcpdmqDImamPz8E5JXXc3Urvz7qEBLUU60VCRDapDy34ujJJIEnlwnZ/F0gc7g
         VI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774817303; x=1775422103;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cfjBoYNSLOamx/UW91atzNiaxMJtbW4Jkc7q3T2fN2k=;
        b=GSnqugSnA2XUjaMciG/silePksBkoN/3jFeeVy8KGD9ONhxTfRl+7F70Y/RCGZM9iY
         m+BlEEMnhZqc2RpE8mCnZ434jm3f+FArRpIDqdIKm3Alw9pzLZR1GZFnvC/KBmGMiIvI
         Uy8XER0jZV5DeEDjaQ9jTOl25Z40aXOQA9u6JbiyOCGzT09VCcemAn7hZe/q9luwXIb6
         +ssu1pa3hfeNBwIvFbhmIwTZAvLd+cF1pHFQLI4OW51Zuz00IqR6sTGMZwcdW5tAebMD
         tvrjgjeARMImdvA+xPs5aMYYS49YMek4WfNeSYiLKV2cIdvz51mWMidwPdDdIXJ5eHNn
         IFFw==
X-Gm-Message-State: AOJu0YwmOBXUEdSF+oFdgetYqJ8XzAo7bGBFEfCcyTf2AI2Fha9zht72
	XpCn7xoXvaRTc6NgPdCeerkXOa8MlEDs4Xw0rsBIEMpWjSJIj+W5P0vaYDsy4rDw/mHkyCMtHro
	A3NOR/X7YxfuwZMbFX88T3k4XhPAMrdLpNYZMcRYqjtx0ba033s+UTK8oh5V+RC/sqXPofvu6bk
	2NP7AS5fd79IHEtlHULlED
X-Received: from pfbhw2.prod.google.com ([2002:a05:6a00:8902:b0:829:9a65:4170])
 (user=zsm job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:909e:b0:829:86a5:d30a
 with SMTP id d2e1a72fcca58-82c95d3979fmr9018452b3a.16.1774817302486; Sun, 29
 Mar 2026 13:48:22 -0700 (PDT)
Date: Sun, 29 Mar 2026 20:47:22 +0000
In-Reply-To: <2026032948-available-paternity-6929@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026032948-available-paternity-6929@gregkh>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260329204722.141570-1-zsm@google.com>
Subject: [PATCH 6.12.y] virt: tdx-guest: Fix handling of host controlled
 'quote' buffer length
From: Zubin Mithra <zsm@google.com>
To: stable@vger.kernel.org
Cc: Zubin Mithra <zsm@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230977-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zsm@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 03A6C3540ED
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
index c4f25c173383..d7ec140fe90c 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -61,6 +61,8 @@ static u64 tdx_hcall_get_quote_wrapper(u8 *buf, size_t size)
 #define GET_QUOTE_SUCCESS		0
 #define GET_QUOTE_IN_FLIGHT		0xffffffffffffffff
 
+#define TDX_QUOTE_MAX_LEN              (GET_QUOTE_BUF_SIZE - sizeof(struct tdx_quote_buf))
+
 /* struct tdx_quote_buf: Format of Quote request buffer.
  * @version: Quote format version, filled by TD.
  * @status: Status code of Quote request, filled by VMM.
@@ -192,6 +194,7 @@ VISIBLE_IF_KUNIT int tdx_report_new(struct tsm_report *report, void *data)
 	u8 *buf, *reportdata = NULL, *tdreport = NULL;
 	struct tdx_quote_buf *quote_buf = quote_data;
 	struct tsm_desc *desc = &report->desc;
+	u32 out_len;
 	int ret;
 	u64 err;
 
@@ -256,14 +259,21 @@ VISIBLE_IF_KUNIT int tdx_report_new(struct tsm_report *report, void *data)
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


