Return-Path: <stable+bounces-243092-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAj1GqCm+GkExgIAu9opvQ
	(envelope-from <stable+bounces-243092-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:01:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCF64BE549
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 650BC3037BC8
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 13:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824173DB642;
	Mon,  4 May 2026 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NHT05pfp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A373DA7D7;
	Mon,  4 May 2026 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777902997; cv=none; b=pqcDN3F83rfIcMN1aX1MnPNY5s7VBYjxCT1HxlIV7YKrY9LE7EcN86aeMKM6OpdodsKehxFgvkiNkk+WBysw/ejl/PYNtSrdAP12Z4wAQMg4gRZUKi0nLGKxeY68kTIYzSNmIF9RKWr2XQBY+ozwgh9UILDZfANXiu+3Kb3uJoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777902997; c=relaxed/simple;
	bh=SSGKDtHte0qc3l00Pes7+tzdtQDdz05UO1auhbaYsyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rTdZRjTtdWhW3CUd9/Rgie6jnw/LcW/4LLSqKXSJAcMRlsXzH3WIn3M/JxtLQd9tJdYQCMhUw1qoPBFvj8xKGY5ubveuDYJv8Q+MPZdbO+HCDp0z4XiJa2m/i+TK8jqkmWkZZbh43iwavd6AjbqHgG9Yzjym6t8An05fhK0hhfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NHT05pfp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF644C2BCB8;
	Mon,  4 May 2026 13:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777902997;
	bh=SSGKDtHte0qc3l00Pes7+tzdtQDdz05UO1auhbaYsyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NHT05pfpe96p2ewpHVzXfYOzI8fhTGTdcLa5fTuOGATPssCIAtGo29CojirjXPDgz
	 RUKhx2YlfUcAvPM+/Kgc+UdkAFkk4GoHeOUH69S7ArgL+MUVJMZuHKEOo9lnBacVPZ
	 KvbIwF7n8UHMg2wJiHy0eLv4tiRoWhtB3nXrfeC4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 7.0 031/307] Input: edt-ft5x06 - fix use-after-free in debugfs teardown
Date: Mon,  4 May 2026 15:48:36 +0200
Message-ID: <20260504135144.002343325@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 9BCF64BE549
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com];
	TAGGED_FROM(0.00)[bounces-243092-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit f5f9e07060519e2287e99019a6de1eb3ebb65c37 upstream.

The commit 68743c500c6e ("Input: edt-ft5x06 - use per-client debugfs
directory") removed the manual debugfs teardown, relying on the I2C core
to handle it. However, this creates a window where debugfs files are
still accessible after edt_ft5x06_ts_teardown_debugfs() frees
tsdata->raw_buffer.

To prevent a use-after-free, protect the freeing of raw_buffer with the
device mutex and set raw_buffer to NULL. The debugfs read function
already checks if raw_buffer is NULL under the same mutex, so this
safely avoids the use-after-free.

Fixes: 68743c500c6e ("Input: edt-ft5x06 - use per-client debugfs directory")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/adnJicDh-bTUaWXP@google.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/touchscreen/edt-ft5x06.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -829,7 +829,10 @@ static void edt_ft5x06_ts_prepare_debugf
 
 static void edt_ft5x06_ts_teardown_debugfs(struct edt_ft5x06_ts_data *tsdata)
 {
+	guard(mutex)(&tsdata->mutex);
+
 	kfree(tsdata->raw_buffer);
+	tsdata->raw_buffer = NULL;
 }
 
 #else



