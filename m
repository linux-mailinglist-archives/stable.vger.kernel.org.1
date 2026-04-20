Return-Path: <stable+bounces-239516-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YM8GH4BY5mmbvAEAu9opvQ
	(envelope-from <stable+bounces-239516-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:46:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1165742FFF5
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E449930A11D1
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A0433A9C4;
	Mon, 20 Apr 2026 15:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yn5R2u5+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AF92FD1B3;
	Mon, 20 Apr 2026 15:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700453; cv=none; b=QUorFfH3CuZKAesJejDGfSUH8rynHfTFp7pZvdre4lHHJ5rswMiPojOy62Hh1sk7ohXbZhB7ruDX895FbZciK5N1gilHQoi/EDdsaWWfMuTRlAnaDnwViyMjfC+5sZALllm4fB28kx/yZuangyAF/YIXEdHblFHoPWapBQ3DCuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700453; c=relaxed/simple;
	bh=8ay/uxEsXBzSMxh121j7ohxUV4wVvZPUEmgXhSPB6mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9Roj6RCP6n6DJkHbWJmOlWM5PObtUx7100VmqgMwxUesIjK9327eSHgM/RfUj5YyhX7StbvTmrwLfJFkQdwdfvGKTNf2HLthBz2/Tt8CJK6I0DHL/lEGSMPSoIiEWRkdjxpSddzUu/lm/PRTCtm3deK/E6jDFyvkZEhKSRw9js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yn5R2u5+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0037AC2BCB4;
	Mon, 20 Apr 2026 15:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700453;
	bh=8ay/uxEsXBzSMxh121j7ohxUV4wVvZPUEmgXhSPB6mo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yn5R2u5+6n4dqmz/oUdN0i6iZaeoHAYRGvpBws1tuLbWx5i+7V2N7DTf8J4wPAY+U
	 tFAKdkAKgQzMkX2VC19saEKNotEo8IPlEpOJ6XxvGXeb3IcKVStjSSQ2GL96oPZEN+
	 NdWGVw9VoLkQNLv9YaKSset8TyuM8y/0N224mUzo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thierry Escande <thierry.escande@linux.intel.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	stable <stable@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.19 147/220] NFC: digital: Bounds check NFC-A cascade depth in SDD response handler
Date: Mon, 20 Apr 2026 17:41:28 +0200
Message-ID: <20260420153939.318986797@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239516-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,intel.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 1165742FFF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 46ce8be2ced389bccd84bcc04a12cf2f4d0c22d1 upstream.

The NFC-A anti-collision cascade in digital_in_recv_sdd_res() appends 3
or 4 bytes to target->nfcid1 on each round, but the number of cascade
rounds is controlled entirely by the peer device.  The peer sets the
cascade tag in the SDD_RES (deciding 3 vs 4 bytes) and the
cascade-incomplete bit in the SEL_RES (deciding whether another round
follows).

ISO 14443-3 limits NFC-A to three cascade levels and target->nfcid1 is
sized accordingly (NFC_NFCID1_MAXSIZE = 10), but nothing in the driver
actually enforces this.  This means a malicious peer can keep the
cascade running, writing past the heap-allocated nfc_target with each
round.

Fix this by rejecting the response when the accumulated UID would exceed
the buffer.

Commit e329e71013c9 ("NFC: nci: Bounds check struct nfc_target arrays")
fixed similar missing checks against the same field on the NCI path.

Cc: Simon Horman <horms@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Thierry Escande <thierry.escande@linux.intel.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Fixes: 2c66daecc409 ("NFC Digital: Add NFC-A technology support")
Cc: stable <stable@kernel.org>
Assisted-by: gregkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/2026040913-figure-seducing-bd3f@gregkh
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/nfc/digital_technology.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/net/nfc/digital_technology.c
+++ b/net/nfc/digital_technology.c
@@ -424,6 +424,12 @@ static void digital_in_recv_sdd_res(stru
 		size = 4;
 	}
 
+	if (target->nfcid1_len + size > NFC_NFCID1_MAXSIZE) {
+		PROTOCOL_ERR("4.7.2.1");
+		rc = -EPROTO;
+		goto exit;
+	}
+
 	memcpy(target->nfcid1 + target->nfcid1_len, sdd_res->nfcid1 + offset,
 	       size);
 	target->nfcid1_len += size;



