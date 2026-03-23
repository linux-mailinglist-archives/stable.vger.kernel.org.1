Return-Path: <stable+bounces-229753-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPMaMq9qwWnVSwQAu9opvQ
	(envelope-from <stable+bounces-229753-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:30:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E632F8347
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CBC73316312E
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15593BC67F;
	Mon, 23 Mar 2026 16:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rE98TByo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6262517AF;
	Mon, 23 Mar 2026 16:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282775; cv=none; b=E3PVPcnZIxWMl8e8nm4GDKPg4yTBJtwu3K/1+kcPkTqkK4RMlmWbYemJUMEDaM+kbwdHrmUDKEeQu4LfI/r3ckDl4EEFxaCe6z6m3E+ecQpwgCYWAQmCUPm/hX03rW9KxkQ18/uyv1C2bVpkwM+LJfFduRmr1ZYk9T+rUKmNO0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282775; c=relaxed/simple;
	bh=Rx0URNXr0RYqMT9HsZuGYJQtZOe8qXiZeermIxuxDWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJ1himtOz62qKwLAdeCz7YMr5/3LYxN0/matudlJ3/xcLi5NNb3cm0guSYhvR08HH/UD+KoDO6Q6lO1RQ7pvmfoCQTu7pxYw8mlKksID70JaK7x/iox87VgQtRywVULVJdbqHjn5vrMm3cIWhbg1h4R0rAKMLSgRfBFQ/bZ+1IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rE98TByo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16401C4CEF7;
	Mon, 23 Mar 2026 16:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282775;
	bh=Rx0URNXr0RYqMT9HsZuGYJQtZOe8qXiZeermIxuxDWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rE98TByo/E4XEoApX2tfK/nKJ/ZebfNH39X1N25UcYJsHYYDTyO1oH0HifRB+80rn
	 z79ogrwt/IYdsD5OQhtTQ44QPifd6RA9yXzEkgOwgDp1Ekpm7ot2/18DR26DH3fu3L
	 deUoAH3K9M3URiNbroROtw+p2yUX8/RcKGVEwzW8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ariel Silver <arielsilver77@gmail.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 6.1 237/481] media: dvb-net: fix OOB access in ULE extension header tables
Date: Mon, 23 Mar 2026 14:43:39 +0100
Message-ID: <20260323134530.916322645@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-229753-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 66E632F8347
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

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



