Return-Path: <stable+bounces-243559-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KM/hMJSs+GnHxgIAu9opvQ
	(envelope-from <stable+bounces-243559-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:26:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A354BF67D
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A702D30A1B98
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3814D3DE456;
	Mon,  4 May 2026 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dals6PTt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED47F3DE45C;
	Mon,  4 May 2026 14:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904196; cv=none; b=vFbMo+oU/ZwRKhZCoMvR39XBIIaxaVLi8pYNr5YccXQT/fTUoXuY0g3yXCo2sdvcrEEN8YL7P4xkmJqnXT+9y7yODCSKgTlw2Rh7Vu1bAVU7xFwwhmTfe3Gh57rj8re3AouQ1cVGIp+mh4tIhtd0Qo8iqmEHrtDnw3bIlVBYvPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904196; c=relaxed/simple;
	bh=5zkwftGacq1wsJJ9lSiqP0zg1VlBujx0MSp5Z91rz2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LopvHPk/r2+Us54Pq43dtsSNRUVOKI4cyL6MeJQhtrYAhmoY8gm9dflgfZe6eauXQH5d6XL0yjHVaTo/dKc6Vmz25fqWRtQD2ZlJx39My1Ki6fOt72YThXhDnoITsHAd4JSMxW/HG5MWJuKZM76yFroSu4yJq6C5RcRXTRCPaxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dals6PTt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2FDC2BCC4;
	Mon,  4 May 2026 14:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904195;
	bh=5zkwftGacq1wsJJ9lSiqP0zg1VlBujx0MSp5Z91rz2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dals6PTtoLaFKFUzK/9mWpLzfb72Xwsd/87livYa7VrtYAq2bvljl/VloKY5sHXvD
	 /CUbCdHk2IsVY1ivC2Yug/VyMufmxDffhF0F3tDnIvAWE1ynXgSuxg81s3jl8SVtNP
	 7OmHosDk522HfJLXodD4FNC8AeCOPAVDXPjcWRoI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 6.18 220/275] crypto: acomp - fix wrong pointer stored by acomp_save_req()
Date: Mon,  4 May 2026 15:52:40 +0200
Message-ID: <20260504135151.244474970@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 25A354BF67D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243559-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,apana.org.au:email]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

commit d7e20b9bd6c990773cf0c09e2642250b8a70263d upstream.

acomp_save_req() stores &req->chain in req->base.data. When
acomp_reqchain_done() is invoked on asynchronous completion, it receives
&req->chain as the data argument but casts it directly to struct
acomp_req. Since data points to the chain member, all subsequent field
accesses are at a wrong offset, resulting in memory corruption.

The issue occurs when an asynchronous hardware implementation, such as
the QAT driver, completes a request that uses the DMA virtual address
interface (e.g. acomp_request_set_src_dma()). This combination causes
crypto_acomp_compress() to enter the acomp_do_req_chain() path, which
sets acomp_reqchain_done() as the completion callback via
acomp_save_req().

With KASAN enabled, this manifests as a general protection fault in
acomp_reqchain_done():

  general protection fault, probably for non-canonical address 0xe000040000000000
  KASAN: probably user-memory-access in range [0x0000400000000000-0x0000400000000007]
  RIP: 0010:acomp_reqchain_done+0x15b/0x4e0
  Call Trace:
   <IRQ>
   qat_comp_alg_callback+0x5d/0xa0 [intel_qat]
   adf_ring_response_handler+0x376/0x8b0 [intel_qat]
   adf_response_handler+0x60/0x170 [intel_qat]
   tasklet_action_common+0x223/0x820
   handle_softirqs+0x1ab/0x640
   </IRQ>

Fix this by storing the request itself in req->base.data instead of
&req->chain, so that acomp_reqchain_done() receives the correct pointer.
Simplify acomp_restore_req() accordingly to access req->chain directly.

Fixes: 64929fe8c0a4 ("crypto: acomp - Remove request chaining")
Cc: stable@vger.kernel.org
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 crypto/acompress.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/crypto/acompress.c
+++ b/crypto/acompress.c
@@ -171,15 +171,13 @@ static void acomp_save_req(struct acomp_
 	state->compl = req->base.complete;
 	state->data = req->base.data;
 	req->base.complete = cplt;
-	req->base.data = state;
+	req->base.data = req;
 }
 
 static void acomp_restore_req(struct acomp_req *req)
 {
-	struct acomp_req_chain *state = req->base.data;
-
-	req->base.complete = state->compl;
-	req->base.data = state->data;
+	req->base.complete = req->chain.compl;
+	req->base.data = req->chain.data;
 }
 
 static void acomp_reqchain_virt(struct acomp_req *req)



