Return-Path: <stable+bounces-266134-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8chwCBqXMWqGngUAu9opvQ
	(envelope-from <stable+bounces-266134-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:34:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A576943F6
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:34:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=C+JUCeZ1;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266134-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266134-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5315C3024A81
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF0A4418D7;
	Tue, 16 Jun 2026 18:34:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ACE34FF79;
	Tue, 16 Jun 2026 18:33:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634839; cv=none; b=LT6VlWXERLZt2weRYrJLWa46PCahuRrKav91Bpvw7l3wV8yiFi3CmQKSNu9hfnDtgwEpJy5SmpjOMaCgA+gR7WUt7HuKPSnqmW1Ak7+SaqO5VnyXojL8uAOs9YqYavJ8ma3CneDIoOqkZdghostVb1Xw+bxz+EFLMuMXUkGzIBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634839; c=relaxed/simple;
	bh=uSv8cfqKLj7Wy4U+Jv7K9TFFNsjGazMJdYOqpnIulwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uyf6MUB+2gGVcIWvL3NdGMy+wUdlSOomrbEfxEiIqyHEJSXShStluSQCksAqQa3HCcRmptg0Q+m6A5nFSQEriaJxmSBXvjVNHraDf8ohdGpKpUaABQhtwTdj7QsUbdgcuUvwiJKRvADdFB/MXav8AI4rdf7UKSdAOJvPkXSn3i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C+JUCeZ1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30EF1F000E9;
	Tue, 16 Jun 2026 18:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781634838;
	bh=wrj9chOdtPaR0kTXLFPaVj56RaEZGQk1BbeYkhSE59Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C+JUCeZ13AdqOg9cWYhKlWWL01KUSDFK1tDVdGg/JgjS6Es/fIee5WkW9JqsjUCQk
	 YrGq2RjhGaQ82WMm2fZSeTSiKSVep8+Fg+uy2aJDyExy2RsZjjbCk3OhOCF5Aoq/GT
	 +988TqPBBdgHql5fjNTpLfnjGKZGEvzDo3wEyXdw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 342/411] Bluetooth: MGMT: validate Add Extended Advertising Data length
Date: Tue, 16 Jun 2026 20:29:40 +0530
Message-ID: <20260616145119.422463874@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145100.376842714@linuxfoundation.org>
References: <20260616145100.376842714@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266134-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:michael.bommarito@gmail.com,m:luiz.von.dentz@intel.com,m:sashal@kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D4A576943F6

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Bommarito <michael.bommarito@gmail.com>

[ Upstream commit d3f7d17960ed50df3a6709c5158caff989c8c905 ]

MGMT_OP_ADD_EXT_ADV_DATA is registered as a variable-length command,
with MGMT_ADD_EXT_ADV_DATA_SIZE as the fixed header size.  The handler
then uses cp->adv_data_len and cp->scan_rsp_len to validate and copy
cp->data, but it never checks that those bytes are part of the mgmt
command payload.

A short command can therefore make add_ext_adv_data() pass an
out-of-bounds pointer into tlv_data_is_valid().  If the bytes beyond
the command buffer are addressable, they can also be copied into the
advertising instance as scan response data, where the caller can read
them back via MGMT_OP_GET_ADV_INSTANCE.  The trigger requires
CAP_NET_ADMIN in the initial user namespace; KASAN reports an 8-byte
slab-out-of-bounds read.

Reject commands whose length does not match the fixed header plus both
advertising data lengths before parsing cp->data.

Fixes: 12410572833a ("Bluetooth: Break add adv into two mgmt commands")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/mgmt.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -8084,9 +8084,15 @@ static int add_ext_adv_data(struct sock
 	struct adv_info *adv_instance;
 	int err = 0;
 	struct mgmt_pending_cmd *cmd;
+	u16 expected_len;
 
 	BT_DBG("%s", hdev->name);
 
+	expected_len = struct_size(cp, data, cp->adv_data_len + cp->scan_rsp_len);
+	if (expected_len != data_len)
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_EXT_ADV_DATA,
+				       MGMT_STATUS_INVALID_PARAMS);
+
 	hci_dev_lock(hdev);
 
 	adv_instance = hci_find_adv_instance(hdev, cp->instance);



