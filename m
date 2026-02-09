Return-Path: <stable+bounces-215255-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKaBHcD1iWl7FAAAu9opvQ
	(envelope-from <stable+bounces-215255-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:57:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B3F111427
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E0A1307D7C5
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E023793BF;
	Mon,  9 Feb 2026 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MN809VXi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784142222B2;
	Mon,  9 Feb 2026 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648193; cv=none; b=jSftOrFfQ8p0R0enQxwNf7VtJ81rlOeduqKMqCXN/C7otPTabNiyghesD5BeOuj6feQvFhUBzW6yND3kX8p7oZJQFf+96BjcPZAhrFbBWWMaJnhjwu0Y5KfT+lE+4nN5oTZaAlo7OD0fKlAcem4QtU8mH/XSwWOG4kYv6ERnNL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648193; c=relaxed/simple;
	bh=gWwnDCJD0G3AiyIL14qGxz9QsemLY8/TJvieeNmZiHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQvn2g3vqStc4TD8QWDzXMk4Jwt4BC81rPRRcFO899a8bY1L2+iae2mRGD4NMtogfD+ar9hmQRCbmu49TIrORjdRk2LZ8hC+3ovC1xYMXrKw4F9VnAKpw05dyB8MKro/o2hDkjLLh2Ouduhzhn5JMhRBa+U+iKLCdQtcHC2w/Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MN809VXi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9B7C116C6;
	Mon,  9 Feb 2026 14:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648193;
	bh=gWwnDCJD0G3AiyIL14qGxz9QsemLY8/TJvieeNmZiHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MN809VXiAk8znNQ+l/treuqIk1qHB89iyCB4sI+dc59AdXg55a2kvSaDVxfpx/gx1
	 7y+KU5imlI7y4m49kaj7yE9cdKzY/Aaq8ARVwsZAVHVaP/4cD8RL+0ujqxInhj+KBh
	 enpyUI3CqEvCwRHL8kl5/zfhzeGP/7UtXROVgdZQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kwok Kin Ming <kenkinming2002@gmail.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 33/69] HID: i2c-hid: fix potential buffer overflow in i2c_hid_get_report()
Date: Mon,  9 Feb 2026 15:24:01 +0100
Message-ID: <20260209142303.118287904@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142301.913348974@linuxfoundation.org>
References: <20260209142301.913348974@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-215255-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03B3F111427
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kwok Kin Ming <kenkinming2002@gmail.com>

[ Upstream commit 2497ff38c530b1af0df5130ca9f5ab22c5e92f29 ]

`i2c_hid_xfer` is used to read `recv_len + sizeof(__le16)` bytes of data
into `ihid->rawbuf`.

The former can come from the userspace in the hidraw driver and is only
bounded by HID_MAX_BUFFER_SIZE(16384) by default (unless we also set
`max_buffer_size` field of `struct hid_ll_driver` which we do not).

The latter has size determined at runtime by the maximum size of
different report types you could receive on any particular device and
can be a much smaller value.

Fix this by truncating `recv_len` to `ihid->bufsize - sizeof(__le16)`.

The impact is low since access to hidraw devices requires root.

Signed-off-by: Kwok Kin Ming <kenkinming2002@gmail.com>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 8a7ac016b1abe..624d542df3a7d 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -257,6 +257,7 @@ static int i2c_hid_get_report(struct i2c_hid *ihid,
 	 * In addition to report data device will supply data length
 	 * in the first 2 bytes of the response, so adjust .
 	 */
+	recv_len = min(recv_len, ihid->bufsize - sizeof(__le16));
 	error = i2c_hid_xfer(ihid, ihid->cmdbuf, length,
 			     ihid->rawbuf, recv_len + sizeof(__le16));
 	if (error) {
-- 
2.51.0




