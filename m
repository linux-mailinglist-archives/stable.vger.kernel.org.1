Return-Path: <stable+bounces-241064-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLNuL6Xq62nhSwAAu9opvQ
	(envelope-from <stable+bounces-241064-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 00:11:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CA657463BC6
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 00:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ECE183009824
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 22:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF68388E62;
	Fri, 24 Apr 2026 22:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddsQsxOI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ADE349B1C
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 22:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777068702; cv=none; b=YK60FrqoA7EqGgDZT750sA+ya5uyTzblHfD5C5dxWgyH76P5sWKo+x+Tylae/8WyqtttyD3ZAdL3mtf2WeK73LuWhRitDeVohPutQVgaYVtaZ3MMFWSbwhaUmcoOmY9VjjBqlhEot/eZ6jZBEcTa2lohezB8OBqryAlj1PwRGBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777068702; c=relaxed/simple;
	bh=spRVtmAYiefRKYjZgKaSJagyZkUSAPPDVPs4Nv0bgp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4H/2wC23s5NZTu+FUW6vqY89YVPnYcrGA0t89KE+GghxjVcMjzrMn7acucCzUK0UgUWKBkTJLKPrftuTsVhr46ty+N5Hm1Y91l2WGfdXgaWtS9Y+XrXK33h7tKB2xg+3reRpX6DwZNoJFQ9dWCmh2ZHZA7MC6GMG6U1HYZwSMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddsQsxOI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso53890355e9.1
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 15:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777068699; x=1777673499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4MGhHC+NydhWG8P1j8ird1HDHK/LUJ2nl+eW8auQlY=;
        b=ddsQsxOI/H+tQcFPSP277Qi+5nEWUjzsgAEq+QiLozZAD4i0gc+IHyjkzZeyJ47yK1
         CK8eAPqsRxw6OJHGAclWbZD/LZkfWArHtdJxHkz0KvCV2Loof9gNmKiE25myrxel5TPl
         QlohlaVahMSzVJtxKd66HHwsnOTKLTANxFkdYONYRbXIVvAvEieUyRklOeIJy5u2pvnP
         v1HD4cqv6hU3PF2YLPprW48nWn97r2gGbaUJ7g9+yPMKtbs094eN5r2EdqNshcg7vXOR
         TSgYunBBiJy3F49RQcgFlIvF9skiEUCvB63W21aTinrHhZfwyAeG5IHmtxSrZNXtaamx
         roRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777068699; x=1777673499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f4MGhHC+NydhWG8P1j8ird1HDHK/LUJ2nl+eW8auQlY=;
        b=JIN2CDjKouq+Ab3ZBuXrH0RPtuDvtdfKSdNZSzFE7ESxH/xZg0fAcsFWOc7UYQ4LX9
         R7e7xcdrf0wSvTIMU9KxgYGG8FouHSiZwsJXBEnZFQomPR7Off1bfNxEC+T1nFQ6i1hY
         /6YGmzxfazAUZwDra6V00ZR4ebF0cVdQxr7xxTT97X7f5C6ATSAim3ln8o5mu2cOYWSW
         Q4i6PsEsnVyQ9LNv+KBGbVqFU1IU+geIEPd330ExPf8nFcKMKNxYi6LiZFYajnsABTzR
         HtE649PXKKmYySeiybbmsE84Q9vR0FU01EtHMayPNNyt+89jyab8dD9Oh6ZHa+yBqsLm
         P8Gg==
X-Gm-Message-State: AOJu0YzsV6R5aVpi43uACbdkMEx3UKxGDEIQPgpZFCDk38d7T+I9CmgT
	mbwXV8UdvdGSGN3fZkvImL88QRS7/oTS+PS5G9ArvXsZ2TQCv3mRvzc6CC+xD1y5
X-Gm-Gg: AeBDies6M3vT1zKznjDNXWkzD7MCNqeTAehl2L51szDYToESkWsu1uVy6BlteCeNMBr
	3NUktBqvgIIqyS+9KyvQ7hNJ/GjU5zZQQyEA0r04WP1cNnfEgZ+di/75lUEQtBo1Vb2c4Q+/Rv7
	mrvt5pl/3hF7D9fPRXZdFurf98ck21E39g0PTDwOJFxwH4RlMbcSLrx3UnIHB+RafvNJPp7Mpk8
	ulRJFurHqeqBi8sjOTvS9i0tlAdhMtLo5Pv6dKmMdSkXsDfUP/YHVslIpnlMTWJb33ai+BG2CLq
	ix4GsyCRPQVgFlPsVOQ+yH71OKTO8tanz1GRd//r8Eo++OawH1eFQ2nEFfTthjjHIwcbznMryJ3
	zXUNdkpyyNhDE35ynz+RBDDOd4wZyu1RPHQDnaHaR8f55onRglX8xRrTUWWsHM9geTaUfw0kXps
	Y1IehuQyZoYhhvw1Q9whrJBfqiEZYzAogHyoG7jf5w
X-Received: by 2002:a05:600c:a31a:b0:488:b239:77ec with SMTP id 5b1f17b1804b1-488fb778db4mr371652795e9.17.1777068699319;
        Fri, 24 Apr 2026 15:11:39 -0700 (PDT)
Received: from fedora ([156.207.128.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb75a913sm188157105e9.12.2026.04.24.15.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 15:11:38 -0700 (PDT)
From: Ahmed Elaidy <elaidya225@gmail.com>
To: stable@vger.kernel.org
Cc: avagin@gmail.com,
	lorenzo.stoakes@oracle.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	Ahmed Elaidy <elaidya225@gmail.com>
Subject: [PATCH v2] mm: fix VM_SOFTDIRTY propagation on VMA merge
Date: Sat, 25 Apr 2026 01:11:26 +0300
Message-ID: <20260424221126.1238744-1-elaidya225@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CANaxB-y=SD7V7dcBXuAqq8=p2R46SAr1uKZtMACynvk1=Cftqg@mail.gmail.com>
References: <CANaxB-y=SD7V7dcBXuAqq8=p2R46SAr1uKZtMACynvk1=Cftqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CA657463BC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,kvack.org,linux-foundation.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-241064-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elaidya225@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]

During VMA merging, such as through mprotect(), VM_SOFTDIRTY flags could be
lost. This breaks tools relying on soft-dirty tracking, such as CRIU
incremental dump/restore.

Upstream resolved this using a broader VM_STICKY infrastructure (commit
bf14d4a05387 "mm: propagate VM_SOFTDIRTY on merge"). To minimize churn and
risk in the stable 6.18.y tree, this patch skips backporting the entire
VM_STICKY series (9 patches). Instead, it introduces a minimal standalone fix.

VM_SOFTDIRTY is intentionally excluded from normal flag comparison to allow
merging in mprotect. This patch ensures the resulting merged VMA retains
the VM_SOFTDIRTY flag if either of the original VMAs had it.

Suggested-by: Andrei Vagin <avagin@gmail.com>
Cc: stable@vger.kernel.org
Cc: lorenzo.stoakes@oracle.com
Signed-off-by: Ahmed Khalid Elaidy <elaidya225@gmail.com>
---
 mm/vma.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/vma.c b/mm/vma.c
index 5815ae9e5770..03728d855684 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -978,6 +978,14 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 	if (err || commit_merge(vmg))
 		goto abort;
 
+	/*
+	 * VM_SOFTDIRTY is excluded from normal flag comparison to allow
+	 * merging in mprotect, but we have to ensure the result is correctly
+	 * marked with it if either side had it.
+	 */
+	if ((vmg->target->vm_flags ^ vmg->vm_flags) & VM_SOFTDIRTY)
+		vm_flags_set(vmg->target, VM_SOFTDIRTY);
+
 	khugepaged_enter_vma(vmg->target, vmg->vm_flags);
 	vmg->state = VMA_MERGE_SUCCESS;
 	return vmg->target;
-- 
2.53.0


