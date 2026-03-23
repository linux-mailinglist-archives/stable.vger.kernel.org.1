Return-Path: <stable+bounces-228608-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLwVGlBSwWkPSQQAu9opvQ
	(envelope-from <stable+bounces-228608-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:46:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 098522F52B9
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA7D2328DECE
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD4F365A0A;
	Mon, 23 Mar 2026 14:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0l1rboKH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37AC823DD;
	Mon, 23 Mar 2026 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275590; cv=none; b=kN43m+SzkgXDbmiXNmZ/BOrTqfT2+gwOMLfRgxG5U7RnlXXIN+y/SXJlzx1rF39U9nIj95TRr+vHar+od/WA11bAsjApslTc9KjucKFY+jxJuYFiJg3NY/C2PuqEd7JzWyZ1kKZP2BZusHJ60Yd//+9s1f1D2SwVX3qCv+oyF0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275590; c=relaxed/simple;
	bh=hyms3pw32nuP2MayusLOerTfXZ+aDxM4pHy/LJfyBvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ge2MmPGri28YGVUJY9A0ymS3oLKDJR7LXpr+C69WtieghqeKYhXUQ4Q4SvIF3bfXcxNzlLe/fWSOWEZAjCWpHbJBlGZva3ifQTZb1uRZN1S64SIVHjhoKQWvH9Zdzl61wMy8gyAALEGa+uryqsmNZKFutLqCmaR9KUlCFjBYOyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0l1rboKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57EA2C4CEF7;
	Mon, 23 Mar 2026 14:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275590;
	bh=hyms3pw32nuP2MayusLOerTfXZ+aDxM4pHy/LJfyBvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0l1rboKHReK/74hoEy8cOqCbCSd6zhoqCt1bCMavAmmQUQ8wBGKxk+d0yJGBoEjQh
	 Ztx8142X8VarCr6WaWjm8WnFxd284ckaLd6WG3isPOcCboLPA18hrJ6BTso0fzxlI4
	 3610dxatmn0lG/ExKlBIJx8DuQwFUj84NGMRwRLs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ariel Silver <arielsilver77@gmail.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 6.12 154/460] media: dvb-net: fix OOB access in ULE extension header tables
Date: Mon, 23 Mar 2026 14:42:30 +0100
Message-ID: <20260323134530.355645464@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228608-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,huawei];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 098522F52B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ariel Silver <arielsilver77@gmail.com>

commit 24d87712727a5017ad142d63940589a36cd25647 upstream.

The ule_mandatory_ext_handlers[] and ule_optional_ext_handlers[] tables
in handle_one_ule_extension() are declared with 255 elements (valid
indices 0-254), but the index htype is derived from network-controlled
data as (ule_sndu_type & 0x00FF), giving a range of 0-255. When
htype equals 255, an out-of-bounds read occurs on the function pointer
table, and the OOB value may be called as a function pointer.

Add a bounds check on htype against the array size before either table
is accessed. Out-of-range values now cause the SNDU to be discarded.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Ariel Silver <arielsilver77@gmail.com>
Signed-off-by: Ariel Silver <arielsilver77@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/dvb-core/dvb_net.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/media/dvb-core/dvb_net.c
+++ b/drivers/media/dvb-core/dvb_net.c
@@ -228,6 +228,9 @@ static int handle_one_ule_extension( str
 	unsigned char hlen = (p->ule_sndu_type & 0x0700) >> 8;
 	unsigned char htype = p->ule_sndu_type & 0x00FF;
 
+	if (htype >= ARRAY_SIZE(ule_mandatory_ext_handlers))
+		return -1;
+
 	/* Discriminate mandatory and optional extension headers. */
 	if (hlen == 0) {
 		/* Mandatory extension header */



