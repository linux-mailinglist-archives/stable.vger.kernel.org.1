Return-Path: <stable+bounces-236459-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OG2MACsa3WkJaAkAu9opvQ
	(envelope-from <stable+bounces-236459-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:30:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 557A13EF1C4
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E6F5305BF05
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24ED2302146;
	Mon, 13 Apr 2026 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wf7G0mho"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2782FFFA4;
	Mon, 13 Apr 2026 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096959; cv=none; b=PbihQ2jMqEAMWfbolNSRCcx95j2I/NeWArHcJ05iw4XPUxXIyg5oWgegFqZZm5yIdtgad5BBGSNI6Xlbg66UyIu1PV0RAkxJ6ay0hit+hvzdqfq43pT27qiItGXJSBuO7R7nnNUtURd4oVaGLwAZlQ1TP/CBa472qtdyzH5u40g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096959; c=relaxed/simple;
	bh=MIivZy3/miB2oXy1uUFd0T2ZV8ALPN/h0T7alIo72ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W97M4QTu4XtKO6fqijVdHKHHS5SUVqDpBzuyCzPkZn9kekj95NNyE/FvFlXeY9NKN0HDT34mUoH3n8g5OmUK5ldmo1hpV/9936kI/eClBiyjo1XpjEJ0o/saHGcrkw/dIU7kf/R5/6fhbyDQ1oUVZ5YGsQVI5otCcQrMymPN3Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wf7G0mho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D46C2BCAF;
	Mon, 13 Apr 2026 16:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096959;
	bh=MIivZy3/miB2oXy1uUFd0T2ZV8ALPN/h0T7alIo72ik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wf7G0mhowJ5qAFvIKptfyHdGG/dL2oqyE9+2t9zArRoEHiEAVm/gsIhztNPRF9Ai8
	 6lt5HEnjhzr7/yexxE0sU70FGYLY1wlWREv7cgUP8HhEkQRN2waLXGk/H/6oPejOIG
	 VjSn/bjf6ZJKnSdCAad7RhlG0mCOL+uQwk2+SEas=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@linux.win>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Leo Lin <leo@depthfirst.com>
Subject: [PATCH 6.6 30/50] X.509: Fix out-of-bounds access when parsing extensions
Date: Mon, 13 Apr 2026 18:00:57 +0200
Message-ID: <20260413155725.637482571@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155724.497323914@linuxfoundation.org>
References: <20260413155724.497323914@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-236459-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.win:email,apana.org.au:email,wunner.de:email,depthfirst.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 557A13EF1C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

commit d702c3408213bb12bd570bb97204d8340d141c51 upstream.

Leo reports an out-of-bounds access when parsing a certificate with
empty Basic Constraints or Key Usage extension because the first byte of
the extension is read before checking its length.  Fix it.

The bug can be triggered by an unprivileged user by submitting a
specially crafted certificate to the kernel through the keyrings(7) API.
Leo has demonstrated this with a proof-of-concept program responsibly
disclosed off-list.

Fixes: 30eae2b037af ("KEYS: X.509: Parse Basic Constraints for CA")
Fixes: 567671281a75 ("KEYS: X.509: Parse Key Usage")
Reported-by: Leo Lin <leo@depthfirst.com> # off-list
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Ignat Korchagin <ignat@linux.win>
Cc: stable@vger.kernel.org # v6.4+
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 crypto/asymmetric_keys/x509_cert_parser.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -592,10 +592,10 @@ int x509_process_extension(void *context
 		 *   0x04 is where keyCertSign lands in this bit string
 		 *   0x80 is where digitalSignature lands in this bit string
 		 */
-		if (v[0] != ASN1_BTS)
-			return -EBADMSG;
 		if (vlen < 4)
 			return -EBADMSG;
+		if (v[0] != ASN1_BTS)
+			return -EBADMSG;
 		if (v[2] >= 8)
 			return -EBADMSG;
 		if (v[3] & 0x80)
@@ -628,10 +628,10 @@ int x509_process_extension(void *context
 		 *	(Expect 0xFF if the CA is TRUE)
 		 * vlen should match the entire extension size
 		 */
-		if (v[0] != (ASN1_CONS_BIT | ASN1_SEQ))
-			return -EBADMSG;
 		if (vlen < 2)
 			return -EBADMSG;
+		if (v[0] != (ASN1_CONS_BIT | ASN1_SEQ))
+			return -EBADMSG;
 		if (v[1] != vlen - 2)
 			return -EBADMSG;
 		/* Empty SEQUENCE means CA:FALSE (default value omitted per DER) */



