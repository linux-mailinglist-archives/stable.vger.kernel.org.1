Return-Path: <stable+bounces-252092-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2G2dCLj5DWrO5AUAu9opvQ
	(envelope-from <stable+bounces-252092-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:13:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EB0595956
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 64D8930FE3BF
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB383A3E60;
	Wed, 20 May 2026 17:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SeQZdT4L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE77329B8D0;
	Wed, 20 May 2026 17:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299725; cv=none; b=MIZohEo6ZhN8Z6jw5ONdsk3cm5BPLFkT6T7DksAli6dy9I0C6BhcSqd/9TggSm8Kp+uiXNLo0yVonpulEUZutjIPIdLpgbH+w4tWkZIVxIRm/jFhgWZFWCyNjM852FAtBcsmXRDUYq0F/wsnJwCXIfgiGVY8tJoeWYCcyFoIFrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299725; c=relaxed/simple;
	bh=TRfhDIlK+LoKEe/fdvypiIkezBEFsQaIjEemcHZz0E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RCNF36q6KTCYpCmlGpxRmA0pKpBcZWOSrXa37Bv2797PeJDscyXOArGF6Hpz6OetZnYOvvz/url4Kgp+QUoR9M34d+lACimknRZ28w1duWehb1tcqS8XGQ3UFYz/DpblNs9nma+flwP25+h3rfJ/XxY8IX8EfT3eVthsXheELLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SeQZdT4L; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC3F1F000E9;
	Wed, 20 May 2026 17:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299724;
	bh=t46jlYE4HU8U0yUGT9e9YR68IoQAPEl3VIACj58hqao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SeQZdT4LPagzUwExpLYvHDtasod1lcd5BZ2/GqpYOslQwrzKT4LGPXA8gJfsGmg/B
	 5SiE9AHHswNhCASWySfJ2i/Aq5NLfafmLocDrp83Pb3j6lvGXCjgkjYHFhK3JgWfYc
	 axwMKzbsRUNUFjQR/aDUT05crE+cVnbNR1ZPQhBc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yiming Qian <yimingqian591@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 6.18 879/957] crypto: af_alg - Cap AEAD AD length to 0x80000000
Date: Wed, 20 May 2026 18:22:42 +0200
Message-ID: <20260520162153.627654939@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252092-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,gondor.apana.org.au];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,apana.org.au:email]
X-Rspamd-Queue-Id: B4EB0595956
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

commit e4c06479d7059888adf2f22bc1ebcf053bf691a2 upstream.

In order to prevent arithmetic overflows when checking the TX
buffer size, cap the associated data length to 0x80000000.

Reported-by: Yiming Qian <yimingqian591@gmail.com>
Fixes: 400c40cf78da ("crypto: algif - add AEAD support")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 crypto/af_alg.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -586,6 +586,8 @@ static int af_alg_cmsg_send(struct msghd
 			if (cmsg->cmsg_len < CMSG_LEN(sizeof(u32)))
 				return -EINVAL;
 			con->aead_assoclen = *(u32 *)CMSG_DATA(cmsg);
+			if (con->aead_assoclen >= 0x80000000u)
+				return -EINVAL;
 			break;
 
 		default:



