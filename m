Return-Path: <stable+bounces-229497-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJ0nCItlwWkzSwQAu9opvQ
	(envelope-from <stable+bounces-229497-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:08:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A73B12F79C8
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3DB030FDA97
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C957C23E33D;
	Mon, 23 Mar 2026 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VJhQMqlF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAFF282F0C;
	Mon, 23 Mar 2026 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279422; cv=none; b=WRaygsMfDK9bOPUbqptnmFG8PbBt4vNhwbVAUu60L0z+VYGNGMh4xpq/aAa75Ot9tsPBCopfkMv5UkdjDWydlPV+RyYPKBx5W3njG48OFtD0tNyzN6mR3bHgbdg/UUUaaXOuVGpaE2JUL155korxzbGVLgxtE8qaYhXwCf7Btcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279422; c=relaxed/simple;
	bh=g+qaHRv33vDCaaQW9543UYcYJzkuBfl9STzXXReYuzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pdzDMtaBvCUX1q8gHsSU08TWvbN2zPxmhQvrtJ1loDlVVEFttjkIAG5GdaGI3EVgNeeOkRK6k9UMt/Su5I9Bm/etVyn+UPcEDcZ6kyP7ShnSOgdGCkkcAnZYgq20DLX77USM9FtvQoSL3TOz1WPzX1QxZKwyDuQm8KrXZLv/R2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VJhQMqlF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12300C4CEF7;
	Mon, 23 Mar 2026 15:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774279422;
	bh=g+qaHRv33vDCaaQW9543UYcYJzkuBfl9STzXXReYuzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VJhQMqlFyULNzuwhgEf/8knjZp58OHbCTzEPvEIg/cl1Psdk7E9jHc8y2D2HXGS5F
	 uemxqsQeGyJrUndOpEJtgs/jcvNCAdGhECyG0auxp7oblamK+iFYa7MHdz4jJAc5Z3
	 yZdyQlDk6ngvzuoMGXC1aR0OaCcgEham1Umt7AhQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 024/481] resource: Add resource set range and size helpers
Date: Mon, 23 Mar 2026 14:40:06 +0100
Message-ID: <20260323134525.832905181@linuxfoundation.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-229497-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,huawei.com:email]
X-Rspamd-Queue-Id: A73B12F79C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 9fb6fef0fb49124291837af1da5028f79d53f98e ]

Setting the end address for a resource with a given size lacks a helper and
is therefore coded manually unlike the getter side which has a helper for
resource size calculation. Also, almost all callsites that calculate the
end address for a resource also set the start address right before it like
this:

  res->start = start_addr;
  res->end = res->start + size - 1;

Add resource_set_range(res, start_addr, size) that sets the start address
and calculates the end address to simplify this often repeated fragment.

Also add resource_set_size() for the cases where setting the start address
of the resource is not necessary but mention in its kerneldoc that
resource_set_range() is preferred when setting both addresses.

Link: https://lore.kernel.org/r/20240614100606.15830-2-ilpo.jarvinen@linux.intel.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: 11721c45a826 ("PCI: Use resource_set_range() that correctly sets ->end")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/ioport.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 4ae3c541ea6f4..a81579821b673 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -216,6 +216,38 @@ struct resource *lookup_resource(struct resource *root, resource_size_t start);
 int adjust_resource(struct resource *res, resource_size_t start,
 		    resource_size_t size);
 resource_size_t resource_alignment(struct resource *res);
+
+/**
+ * resource_set_size - Calculate resource end address from size and start
+ * @res: Resource descriptor
+ * @size: Size of the resource
+ *
+ * Calculate the end address for @res based on @size.
+ *
+ * Note: The start address of @res must be set when calling this function.
+ * Prefer resource_set_range() if setting both the start address and @size.
+ */
+static inline void resource_set_size(struct resource *res, resource_size_t size)
+{
+	res->end = res->start + size - 1;
+}
+
+/**
+ * resource_set_range - Set resource start and end addresses
+ * @res: Resource descriptor
+ * @start: Start address for the resource
+ * @size: Size of the resource
+ *
+ * Set @res start address and calculate the end address based on @size.
+ */
+static inline void resource_set_range(struct resource *res,
+				      resource_size_t start,
+				      resource_size_t size)
+{
+	res->start = start;
+	resource_set_size(res, size);
+}
+
 static inline resource_size_t resource_size(const struct resource *res)
 {
 	return res->end - res->start + 1;
-- 
2.51.0




