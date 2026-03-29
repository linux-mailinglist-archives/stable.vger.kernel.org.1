Return-Path: <stable+bounces-230883-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id a1MZH9cdyWlKuwUAu9opvQ
	(envelope-from <stable+bounces-230883-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 14:40:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCCF351F62
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 14:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DA98300C925
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 12:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B6631E85D;
	Sun, 29 Mar 2026 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EfPlaOgx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0312DF14C
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 12:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774788052; cv=none; b=pxDz6oE53MO0xz4LO+rqDvVtbxnyo2O3Hxks+yaXMXEfNYYwXtK7Svm71DstI7t5RpeZc2TgMVaJcbDbD5YTppAdnSVSG7JrgwT7yzwzY1CZKSYVEuJV9HIda8rlYMTsvuS6XV/tdq8BgFHqkkPP6zo7fi4UsFdOeoIfPorF0L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774788052; c=relaxed/simple;
	bh=GifcCGWmYOIONGrLVt2ZU9F9bQj3al0KatqWDpwCrNQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Xik/+QW9QtDeZWyjNcj6u7JvYYGdBBvIfTZUjN8DRMLr96l9TDBBsU0SEq20dJhhkbwbu78J9SLelc/KGBU9AYuL1T1KU5Es3htFhf9M/Wt6KSFHP4qZk8vX/ECC0JoJrfrPEhpiPBNcdQXHKzFw/u70LCK8vmgGEyQYrkffmXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EfPlaOgx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D91C116C6;
	Sun, 29 Mar 2026 12:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774788051;
	bh=GifcCGWmYOIONGrLVt2ZU9F9bQj3al0KatqWDpwCrNQ=;
	h=Subject:To:Cc:From:Date:From;
	b=EfPlaOgxPJlovPs3A6xFVyZy9OkZNLPguqoDUOBIxHxb739vRGVncQdGijik0UYR4
	 3D4OWqZft6zPrUsjPKSOfmH/kmuVtXauEKcqEHbfbjzy5OxuB0qrb+Vq64SrKFaP0L
	 LdI/6OJsb92Wxfz9oQvindk7uH8RqiK4NbTHEEnA=
Subject: FAILED: patch "[PATCH] virt: tdx-guest: Fix handling of host controlled 'quote'" failed to apply to 6.12-stable tree
To: zsm@google.com,dan.j.williams@intel.com,kas@kernel.org,sathyanarayanan.kuppuswamy@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Mar 2026 14:40:48 +0200
Message-ID: <2026032948-available-paternity-6929@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230883-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: CBCCF351F62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x c3fd16c3b98ed726294feab2f94f876290bf7b61
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026032948-available-paternity-6929@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c3fd16c3b98ed726294feab2f94f876290bf7b61 Mon Sep 17 00:00:00 2001
From: Zubin Mithra <zsm@google.com>
Date: Wed, 18 Mar 2026 13:40:13 +0000
Subject: [PATCH] virt: tdx-guest: Fix handling of host controlled 'quote'
 buffer length

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

diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index 4252b147593a..7cee97559ba2 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -171,6 +171,8 @@ static void tdx_mr_deinit(const struct attribute_group *mr_grp)
 #define GET_QUOTE_SUCCESS		0
 #define GET_QUOTE_IN_FLIGHT		0xffffffffffffffff
 
+#define TDX_QUOTE_MAX_LEN		(GET_QUOTE_BUF_SIZE - sizeof(struct tdx_quote_buf))
+
 /* struct tdx_quote_buf: Format of Quote request buffer.
  * @version: Quote format version, filled by TD.
  * @status: Status code of Quote request, filled by VMM.
@@ -269,6 +271,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
 	u8 *buf;
 	struct tdx_quote_buf *quote_buf = quote_data;
 	struct tsm_report_desc *desc = &report->desc;
+	u32 out_len;
 	int ret;
 	u64 err;
 
@@ -306,12 +309,17 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
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


