Return-Path: <stable+bounces-246414-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LPICJpvA2qI5wEAu9opvQ
	(envelope-from <stable+bounces-246414-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:21:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4047E527620
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EB5B930A0BDD
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CA8343D9D;
	Tue, 12 May 2026 18:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TrUJ6yS6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66F03EDE61;
	Tue, 12 May 2026 18:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609164; cv=none; b=hzK/Yq7yciYVqBvnDqSYdXTVpq8szXLQ65HazeZmFJzzWYdXHt8walZOQsgVF65gVNuP5SPGMcNQRFClLg6w7CGcH04wwg3EtcR2o+iljnMParwFwCLMULJ3mpUQ0OQi2ELC8x5r5je4tYqZ+ivOZeGCeNj1SperzjvsqGuK2f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609164; c=relaxed/simple;
	bh=1iAQoajF7xrksM1E45jAnQpzcRpQ9qUrXAD0hC5rX10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9JmuLeDqHQPzaHJKGOOO2Wuu4WbMo+EFd5lA8bNJf+SA7gNQI0Ns2Oypvx5mi8b+85Q/92O5pj+2nGklyrCvg2alpfvK1TqATd81Uo082ni5x9fUFApjCrIXG1pGerGM0LWpgnurb3V3zAlldXQnsdWIdRtDHRiJxqcybzmOA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TrUJ6yS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3440EC2BCB0;
	Tue, 12 May 2026 18:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609164;
	bh=1iAQoajF7xrksM1E45jAnQpzcRpQ9qUrXAD0hC5rX10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TrUJ6yS6fv+QXmNfsGkRH+mOxgi6VPJCaOPAukaoFolSPE57G/wk+7WBkB5ly3SW0
	 oEZ2tpzvpLpv6homtLCJZeumxrZYsnkKnnAA+h49I8wHQxIxP7YArB2eV20Vfsqcbq
	 QzY0xdJrkVNlHXRC7iRj3+qxdZsIcgVqZPFp6Drw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Shyam Sunder Reddy Padira <shyamsunderreddypadira@gmail.com>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH 7.0 090/307] staging: rtl8723bs: os_dep: avoid NULL pointer dereference in rtw_cbuf_alloc
Date: Tue, 12 May 2026 19:38:05 +0200
Message-ID: <20260512173942.028508216@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 4047E527620
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246414-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shyam Sunder Reddy Padira <shyamsunderreddypadira@gmail.com>

commit bc851db06045a40c18233dd76ef0562d7f8bb6db upstream.

The return value of kzalloc_flex() is used without
ensuring that the allocation succeeded, and the
pointer is dereferenced unconditionally.

Guard the access to the allocated structure to
avoid a potential NULL pointer dereference if the
allocation fails.

Fixes: 980cd426a257 ("staging: rtl8723bs: replace rtw_zmalloc() with kzalloc()")
Cc: stable <stable@kernel.org>
Signed-off-by: Shyam Sunder Reddy Padira <shyamsunderreddypadira@gmail.com>
Reviewed-by: Dan Carpenter <error27@gmail.com>
Link: https://patch.msgid.link/20260414071308.4781-2-shyamsunderreddypadira@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/rtl8723bs/os_dep/osdep_service.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/staging/rtl8723bs/os_dep/osdep_service.c
+++ b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
@@ -194,7 +194,8 @@ struct rtw_cbuf *rtw_cbuf_alloc(u32 size
 	struct rtw_cbuf *cbuf;
 
 	cbuf = kzalloc_flex(*cbuf, bufs, size);
-	cbuf->size = size;
+	if (cbuf)
+		cbuf->size = size;
 
 	return cbuf;
 }



