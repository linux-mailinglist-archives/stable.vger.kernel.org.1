Return-Path: <stable+bounces-231876-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DBPCtn7y2mcNAYAu9opvQ
	(envelope-from <stable+bounces-231876-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:52:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9708636D4DD
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E5A773053F3D
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402444266A0;
	Tue, 31 Mar 2026 16:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RwziQXQN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012AE4266A3;
	Tue, 31 Mar 2026 16:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975296; cv=none; b=liuIUXHdG2aCc3dXZI4ux5qmArrSwmtb5PEw6NpKUNAEw29KhameLg5P7HEPXDPfzSI+nsEmr8fe6WMN8quMY4mXfrLdSyKxGut2Ilhea8jcTlC+yzdMEkJtpMkQD3hyN9Y/9vg+OH4gGdtZxoyWcgMm9+rCMfBXLokyr1j75PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975296; c=relaxed/simple;
	bh=kJ0XO87WHYVlOTW9moxSuXdfGHh0De656HAZf1GFtFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KSCsrSgADm3fIMdG0vkrLYs8jS/XmP3RPCbj923OnHQ3R7ACFO+cVMWlioTVvaw0eNyfKyibfm2Pdu0EzcVbH4oQ6/nSdUBgEQrwTc6dU9Ed1c+TbiVcq46IOk1z3aURdxK+POdR3NjUt9eoqWd0EamYwoOtbyEH+/SD/HG9A9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RwziQXQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0C6C19423;
	Tue, 31 Mar 2026 16:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975295;
	bh=kJ0XO87WHYVlOTW9moxSuXdfGHh0De656HAZf1GFtFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RwziQXQNRu2mHsM3FVTkgMMZ5Im27gT6QOO6StkmzgP7nrsNc7MDPKsTbjhVWw3tE
	 /pNQFgYbkethjxhjp3goE/sGPiQdlj35Rf+9qpWxITPmvSTjA1sunCAqzQmGbLfOzO
	 tOFldrA6k6u7BqfwhuD9HAtbar8LqI4qroqCBvZA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zubin Mithra <zsm@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH 6.19 232/342] virt: tdx-guest: Fix handling of host controlled quote buffer length
Date: Tue, 31 Mar 2026 18:21:05 +0200
Message-ID: <20260331161807.505365800@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231876-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 9708636D4DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zubin Mithra <zsm@google.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/virt/coco/tdx-guest/tdx-guest.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -169,6 +169,8 @@ static void tdx_mr_deinit(const struct a
 #define GET_QUOTE_SUCCESS		0
 #define GET_QUOTE_IN_FLIGHT		0xffffffffffffffff
 
+#define TDX_QUOTE_MAX_LEN		(GET_QUOTE_BUF_SIZE - sizeof(struct tdx_quote_buf))
+
 /* struct tdx_quote_buf: Format of Quote request buffer.
  * @version: Quote format version, filled by TD.
  * @status: Status code of Quote request, filled by VMM.
@@ -267,6 +269,7 @@ static int tdx_report_new_locked(struct
 	u8 *buf;
 	struct tdx_quote_buf *quote_buf = quote_data;
 	struct tsm_report_desc *desc = &report->desc;
+	u32 out_len;
 	int ret;
 	u64 err;
 
@@ -304,12 +307,17 @@ static int tdx_report_new_locked(struct
 		return ret;
 	}
 
-	buf = kvmemdup(quote_buf->data, quote_buf->out_len, GFP_KERNEL);
+	out_len = READ_ONCE(quote_buf->out_len);
+
+	if (out_len > TDX_QUOTE_MAX_LEN)
+		return -EFBIG;
+
+	buf = kvmemdup(quote_buf->data, out_len, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
 	report->outblob = buf;
-	report->outblob_len = quote_buf->out_len;
+	report->outblob_len = out_len;
 
 	/*
 	 * TODO: parse the PEM-formatted cert chain out of the quote buffer when



