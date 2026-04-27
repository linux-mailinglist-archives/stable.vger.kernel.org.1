Return-Path: <stable+bounces-241266-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CF9qKToc72lk6wAAu9opvQ
	(envelope-from <stable+bounces-241266-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 10:20:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 431F846EF2E
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 10:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AFE2D30078AF
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 08:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A1F39A075;
	Mon, 27 Apr 2026 08:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYDmNIJD"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78EB39B946
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 08:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777277993; cv=none; b=C36fxt7PIC47UfJ6VmTRC4VZqeCzJ5K7rqK6RvaFX3GsqRmHDhSeSCMr6RDAOhSOoSPJd7p1reR+42B/lPQliP+O6gteTzuv9Bv8Ch56G/jc9y+MSqbYYZaT/xWe6ib6aYkzs5jo3op44cbMO1WbM5K9fK1jf3Vsb+x/qbBEfFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777277993; c=relaxed/simple;
	bh=+YeUIV1+wtcPKuOvB4oPRVaxMCPwWFWxjyfdg1SSC4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KArt6aONRqHB3aU9XVisaRfzbLCMj64VtRctLDCd3YR/R5ZnWh3TQNHkjbHyBmbnsnf8qKtonEFBTnolzBJ3wajh+afmaY7QkPkQE6aykzZGzz9Tdzgit3ztFx8tXx9LLYEq10aSZ1e1t6Tk6QFwD8OCRr+8excacYroBp0dK5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYDmNIJD; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so118573135e9.0
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 01:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777277990; x=1777882790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMczc9e1ajSbK4Mrr/Qq92dYlg6aGcU3H3gAe4DnWL8=;
        b=aYDmNIJDmeG5kuWBwm+tc7QFXop2w4cElQd/tU/p3it5otFdb5Tdae2KIAKDZvSxMC
         MMxbR6B1ioDUrWc5yfB4GwPMSDdr4HZb/BqZ5suZNKOBIS7x/Hu/J905h3uXD6NA+Q7S
         a9hsrfjPzEU3qzoFHy4F7U6frGVCbF+66VAQ7y9L0Lo462j23SOAIwJLMW/TJHS/ic+q
         g68cmb09Y8gVMmmPXQ2eJ3NJkUJ2a8tutS0ryekNKvMyex+eG1+Ozv3qDwlH77sP2Fu3
         QMeX2FGoRVBuLLXHQ1Gycps6QCRJU2pJMiN1Apykw5ObmbW0zPQuggao0o+W/flMOJj2
         5kwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777277990; x=1777882790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nMczc9e1ajSbK4Mrr/Qq92dYlg6aGcU3H3gAe4DnWL8=;
        b=gfnHeDYZuQ1hWn0kvbUCJcaN3IPqQAMpIk0zjL/93gP/P5GkD4dV2aL7QtPLliNFp+
         F9QhCLqiHez6MzhaheuBiBN3vIRO4bpOBAN79tOJa3PKErkvhyXqtz9j4ejc8amP7qai
         13qLWkOOi8O9S9IYVeG5yBVu1rPqjGjfyMqxoFQPjd1cpoGLsvGTQX1pyKhqjmk7IhKs
         C4LC/zFY587wcgXSxP/Uyjt55IQfkNLKFKcgHnHwD+CM0USfEwLNIzQ4TEMHbze/JLZU
         pYXgNzK7T6TTnxu8NESn509Vtmd5Lbj71yOh1b1EZHmwtwWiSfkwhuGuEyTQ5ayxpTjx
         w/tQ==
X-Forwarded-Encrypted: i=1; AFNElJ8fAOuK6FJpMrSEPqcSgcfyzk1dI/WEkEOf94bfAUHMANcSWzhziJD3I629LGFaFAhC/5Yf/As=@vger.kernel.org
X-Gm-Message-State: AOJu0YyflA7lEwLHlnnWbCiI8xlsqP7SbxXlFRIt+h8Nrco+W3iRzfNh
	UBKX2OqNDsronvsRsduOyraSvCToOEde+dyWc+fVJuUxfyZ/j+VMjSQE
X-Gm-Gg: AeBDievwAKN+Wf9cLifLUbok+s6Ip8wRSaCtzkI84N1MjOPDv5pU/D4PXCgUjnejmYq
	ZRAQP8Iei1BqRjhoOm0z5MGoAvu7YvIdka+d/X/+IC6Dx7XcFwfX8D8oFJkf2HFUYc5/nYPQUtx
	zXLMTnKymuugxj64xB6ML+asJgk8Y1spu6MsOpZ2r9yStmH+uIZL3BWhA/g20H9wqc4HlIQwxwG
	Af1L454376LUvgkjSx6pvONgetnvYYWlbRbaRXiyO7pqLVmrCGgHOVtwBPn74vK2UXIX/PjZvLL
	c8BjZ4wJZPj+2dzbDHiOMTvX6yRe90RhX35hyTstsWD7YzJvk3+VR9ilPuvremA6cR1Ctr4SK4r
	ISimhP5FifHd1gw41sTIJTbe0Jt597/zwTRuVCGoJSROxQ8ctpfGhCFfL2M6HMVlvSACFRyB8jP
	/B8QkxVtbN+CrfaKnWXUBSda9reTNq+k8hXfK2C02kKIIGRlTraHEonLxz3sUQVmKzRHi1nZaZd
	sxa78u3ZT5rKskC/5G0kJVf7VQ5b28kgfcNAVlvqTFve674IFOE2N6uCWF7Ou+gLmGRPuU=
X-Received: by 2002:a05:600c:c090:b0:488:9e54:94c0 with SMTP id 5b1f17b1804b1-488fb74e130mr452914045e9.8.1777277989920;
        Mon, 27 Apr 2026 01:19:49 -0700 (PDT)
Received: from ahossu.localdomain ([82.78.232.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a18csm90455670f8f.20.2026.04.27.01.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 01:19:49 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: error27@gmail.com,
	luka.gejak@linux.dev,
	Alexandru Hossu <hossu.alexandru@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] staging: rtl8723bs: fix OOB read in OnAssocRsp() IE loop
Date: Mon, 27 Apr 2026 10:17:48 +0200
Message-ID: <20260427081748.3407939-3-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427081748.3407939-1-hossu.alexandru@gmail.com>
References: <20260427081748.3407939-1-hossu.alexandru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 431F846EF2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-241266-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

The IE parsing loop in OnAssocRsp() advances by (pIE->length + 2) each
iteration but only guards on i < pkt_len. When a malicious AP sends an
AssocResponse whose last IE has only one byte remaining in the frame
(the element_id byte lands at pkt_len-1), the loop reads pIE->length
from pframe[pkt_len], which is one byte past the allocated receive buffer.

Additionally, even when the header bytes are in bounds, pIE->length
itself can extend the data window beyond pkt_len, silently passing a
truncated IE to the handler functions.

Add two guards at the top of the loop body:
  1. Break if fewer than sizeof(*pIE) bytes remain (can't read header).
  2. Break if the IE's declared data extends past pkt_len.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index c646dc2a1741..68ce422305ed 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1406,7 +1406,11 @@ unsigned int OnAssocRsp(struct adapter *padapter, union recv_frame *precv_frame)
 	/* to handle HT, WMM, rate adaptive, update MAC reg */
 	/* for not to handle the synchronous IO in the tasklet */
 	for (i = (6 + WLAN_HDR_A3_LEN); i < pkt_len;) {
+		if (i + sizeof(*pIE) > pkt_len)
+			break;
 		pIE = (struct ndis_80211_var_ie *)(pframe + i);
+		if (i + sizeof(*pIE) + pIE->length > pkt_len)
+			break;
 
 		switch (pIE->element_id) {
 		case WLAN_EID_VENDOR_SPECIFIC:
-- 
2.53.0


