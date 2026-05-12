Return-Path: <stable+bounces-246367-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DoxNlNwA2qI5wEAu9opvQ
	(envelope-from <stable+bounces-246367-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:24:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4902F52782E
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A29AC309649D
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D1A3EDE67;
	Tue, 12 May 2026 18:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jmQy+wR+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66B93EDE55;
	Tue, 12 May 2026 18:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609043; cv=none; b=VLoq+1dZEvFGgFBfoBkVZORDMCyc63hix8xWlq7bxzUAZ+SbtaozM75agPgDkL8KjcjfwFPqE0j/87oQ+wMM1Yyk2TsMm61aA7oBg67aMRMWTKGug/oKu1wxZRbwVfZfySi+bgC8jMXNQFPkdC+AyEuq4QwmEM/V347qYcrs6Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609043; c=relaxed/simple;
	bh=bv1A5udFxk/IzUBe9oV/PzWZakYkCqZV9WTpT+GZx04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yyz9Tt0ron+TUsTgdxo0Mmk/ewqS2kWmWRkJVc15VsPe0Aeoqq9b+DPyThjeUXKIaaCKbZrt+zPSoq1BCEjwuspPwvxKkFdOnqDuzs+sLBoVqTAfWH9JTLOTa3FWlDVPZ/huRQ27kTjbRlX3PAHCZG+AMc21JpaUf0RUhkFzkyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jmQy+wR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D02DC2BCB0;
	Tue, 12 May 2026 18:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609043;
	bh=bv1A5udFxk/IzUBe9oV/PzWZakYkCqZV9WTpT+GZx04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jmQy+wR+akwCuOyTup4ifCu3o3Yd9tQggrc4yRZqHqOrlVXWBZFSWJMJcKMycJn7a
	 ScLbrQGNhQ0ZHgBrxrkW40/hziiHWkhJW2Q09d8FH80a2nhWZrLb9Pxa9IMXElScuS
	 +3CVwTIotoy47ggy8Tq5+x0E6qMxlmLloJ9o7Oaw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Felix Gu <ustc.gu@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 7.0 043/307] usb: ulpi: fix memory leak on ulpi_register() error paths
Date: Tue, 12 May 2026 19:37:18 +0200
Message-ID: <20260512173941.033676320@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 4902F52782E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-246367-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,linux.intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Gu <ustc.gu@gmail.com>

commit 0b9fcab1b8608d429e5f239afb197de928d4de7d upstream.

Commit 01af542392b5 ("usb: ulpi: fix double free in
ulpi_register_interface() error path") removed kfree(ulpi) from
ulpi_register_interface() to fix a double-free when device_register()
fails.

But when ulpi_of_register() or ulpi_read_id() fail before
device_register() is called, the ulpi allocation is leaked.

Add kfree(ulpi) on both error paths to properly clean up the allocation.

Fixes: 01af542392b5 ("usb: ulpi: fix double free in ulpi_register_interface() error path")
Cc: stable <stable@kernel.org>
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/20260407-ulpi-v1-1-f3fafe53f7b2@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/common/ulpi.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/usb/common/ulpi.c
+++ b/drivers/usb/common/ulpi.c
@@ -286,12 +286,15 @@ static int ulpi_register(struct device *
 	ACPI_COMPANION_SET(&ulpi->dev, ACPI_COMPANION(dev));
 
 	ret = ulpi_of_register(ulpi);
-	if (ret)
+	if (ret) {
+		kfree(ulpi);
 		return ret;
+	}
 
 	ret = ulpi_read_id(ulpi);
 	if (ret) {
 		of_node_put(ulpi->dev.of_node);
+		kfree(ulpi);
 		return ret;
 	}
 



