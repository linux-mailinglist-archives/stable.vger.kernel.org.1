Return-Path: <stable+bounces-228767-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFxLAbpWwWmBSQQAu9opvQ
	(envelope-from <stable+bounces-228767-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:05:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6647A2F5BF4
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4FB43109C57
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7CE3ACEED;
	Mon, 23 Mar 2026 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r+er2zAr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A145C33CE9A;
	Mon, 23 Mar 2026 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277068; cv=none; b=s3jM0zmPzYH98REx+2hp5pQxc+6dDnp6KgG3ScyrP+3koZTkvr28Gx0rszdvMudZnff3R/q904FUnTrYBhXPuuR4AlOp15td4UmP7nsWS9U3IZ/9WvCIGmatGG+MN3ql6Ojvj7moWCaNXeFuntAcUVx2h7R041OmTD4+XZe4ADE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277068; c=relaxed/simple;
	bh=KOWjegGwcsgPa3U8MDbF5s4W8Qr1XTHwj3PqBbLU5Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTPr04XJv0Su9TbTUP3PPz5DOLVLyulxtiMxPsNpsqYxXcX/sxnIl9zQIR/v5d4kmLf36Ceiy+rhR2vAkv82OSlKnlmVl0LpW27pnAkPg26uCBbixbbSE1q0i01NHLOE+WtUyUfehu8srnXiDb66CWLIkW1Qc5ojLqISRjLvr8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r+er2zAr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37918C4CEF7;
	Mon, 23 Mar 2026 14:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277068;
	bh=KOWjegGwcsgPa3U8MDbF5s4W8Qr1XTHwj3PqBbLU5Ak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r+er2zArZwdfxtD4SCdMfGMMtJhwZeCduB3NQ5UVFMORIKkwgs8FPHhbcSulJZEOY
	 JEf6Pth+2u4/1g7aUuqbWlDpC1ScVsZYgjgGBCTEcHcHzoFDv49gKfjNBNzhgI2rhH
	 aAU31IKLiFrh27JbdVBMYnPe7xEkSEWRxodnLF9o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiri Kosina <jkosina@suse.com>,
	Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH 6.12 309/460] HID: bpf: prevent buffer overflow in hid_hw_request
Date: Mon, 23 Mar 2026 14:45:05 +0100
Message-ID: <20260323134534.089979321@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228767-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6647A2F5BF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Tissoires <bentiss@kernel.org>

commit 2b658c1c442ec1cd9eec5ead98d68662c40fe645 upstream.

right now the returned value is considered to be always valid. However,
when playing with HID-BPF, the return value can be arbitrary big,
because it's the return value of dispatch_hid_bpf_raw_requests(), which
calls the struct_ops and we have no guarantees that the value makes
sense.

Fixes: 8bd0488b5ea5 ("HID: bpf: add HID-BPF hooks for hid_hw_raw_requests")
Cc: stable@vger.kernel.org
Acked-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/bpf/hid_bpf_dispatch.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -450,6 +450,8 @@ hid_bpf_hw_request(struct hid_bpf_ctx *c
 					      (u64)(long)ctx,
 					      true); /* prevent infinite recursions */
 
+	if (ret > size)
+		ret = size;
 	if (ret > 0)
 		memcpy(buf, dma_data, ret);
 



