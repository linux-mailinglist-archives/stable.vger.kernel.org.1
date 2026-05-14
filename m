Return-Path: <stable+bounces-247152-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEpMFBOIBWr5XwIAu9opvQ
	(envelope-from <stable+bounces-247152-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:30:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5782553F595
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6294C3082A2F
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 08:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA953DA7E2;
	Thu, 14 May 2026 08:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="hvGHDXkj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F23D3DA5BB
	for <stable@vger.kernel.org>; Thu, 14 May 2026 08:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778747199; cv=none; b=qqiveZW275GtxU5V2fU+KtXqrTvTeZC/5OWY9olJcZCDKm5+Jig3OWWbMOJOIcd8MrmV31BiTIzzBWQ7lTEW5fTxAvoD1l/HDu0WWGT4dbINk5ZT/oIVwFMF66hA4CMouFPmOtndcF9pbrH8X+Wm8aWKskIK0Ho2a4Wc19yYvaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778747199; c=relaxed/simple;
	bh=q9srtjbJ1sl6JcRmZJxPPbCeBahKD3KQiyJ6bLfY+1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OFOT4PFzJimojn4oKcuZnrPaEJBLjtuhTU34wBO8XCTTDb0nlQP5eCW+spl7i1cR9kb42k57JBMyXtJaSgdfADJNn4sf3sSh8GRZUW6owIN7Sc6Cu/FNm4xzeWiq8kjGneqrlN96/NLvPnX+tHahpvskPWe2F4N3HBmKhIBSNuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=hvGHDXkj; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c8173b2af32so5658745a12.0
        for <stable@vger.kernel.org>; Thu, 14 May 2026 01:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747194; x=1779351994; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t5YZ5/RDTjOVXbQmmL0DlnfYt163pcXn6d4m+SJiGG8=;
        b=hvGHDXkjIELYCviN+Dh/i0sb1VCRO4LwW3LYrdsWb+hpuUt17mCpevOp2jy3HeR9La
         8+SPx/sw70ZIWNTLy3LQmVFMBMkPh6CFXW1IjHlu8dnEbU3gxKeqLW96x6G2JiHXZcdW
         IdddwPuhLi2XDGuEumXYxN1Jg1L554pO54TiNvqg604WhC8IgMUkZMtnWdoZJEM2qve8
         3RQnh4DCLcSQOo6D184mG909f3Fd5j6lU6SmQ9a9EaM8kmpfuqfpUcjG9vlaO15RJRBw
         w06LvlQ+ubil2N3GunYnMpxOlfgJfyWZLuxgKhEYb6o9xt4cRnMuuBnRKpJtTUigcvgS
         jxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778747194; x=1779351994;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t5YZ5/RDTjOVXbQmmL0DlnfYt163pcXn6d4m+SJiGG8=;
        b=hlad4WTn0aHSyqsU66uYPBQcOZz5Ie6Fns7Py2Jxwjn57gvwCuHtstlYGceN5p1iNy
         WqGAhAEKlEmxB5FOmh//TByrazX8/TCOcggrYSc36xq+FM5g+84aZoSPyQ+p2lTxRp7j
         z3lOVQ/ovvEqw/zXZbl8+FvQJ2ir/l9HTfBa46LoxDwbfnEN5PDH9f4ZabEE25QypUyY
         Hu56W98Ru8o6MnEfT6um1i023z5lL4kkzCTJVKPMo4TlHnkSQNcQSSa2isCBelN2qh4m
         +YiWJK11J6r7Y0sZHsLqnDfimNIAzpAGoeaYvmhUHB9EuDp/OZIeDXLlkIkCxvBWnSSK
         FNFA==
X-Forwarded-Encrypted: i=1; AFNElJ8PheQoIsG2D2gQ6ohr7mXdP1660woK0yEcRI84PMGcWp4uNF7BTZFDj2nWDpL0c9P2jRDgL6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzF0YbK+N9N5oyvyo8ogb+hcy8aJN+3PozuL1lD+ZwRxvpdC6I
	IVtP3vg4HAzctzXVYYq8fdRNPas9yFdzFd7BAjO2CKS4iSI4qSevG6RLYio5VpVgwFU=
X-Gm-Gg: Acq92OEW0whsoBxfWLnYxPVXHgG7KMuGC9pD2k07eDVDJnrd+RM7YHqNjs7KYE9CxqB
	zOoH5BDM7FCT1L6WLgUrZ/hq7jFicWsOafXuH2FAeM9xCsat5C1iCtoVFvdkUsGSw/0A7w8bSsB
	vgdZ9YQbXgByC7Q/AmDUeq5oC3m1+LVgPwE5TjoYOquJ+sl0BHT6fEAl0Ws6Zpq4tqK0+XrOO9L
	Ui6Tu1ji45y66fBYzFz3RUoDhyMUtd9tnxnhaoSHC0yQRX5+ci7hgc/1ZqwPtDqhQhkzBSKuTdq
	JqC+ss3ZdZuI1fgxBZhh6yiDDE1VVOvngScqrFXpfmogduVlUjkNWKK/74sFq291nStIT+bRfnr
	NVWIyIgW3lQdk8B7v+CEmH5r/n9u5aUyCQ3VHgNRlDM+EsKLqthcOyu6DEuIPmKchwKuCCIj5Rq
	OGmqmfm4cQTH85xEwjBTkJtpfbPpHiDZAYhOjGpX16SQ4C/kIEzN9v9aTVaKT/1sdp3LpFTH5TE
	A0LVVjEAAV+M0GpsxOBMqLCyiA9bYrnI88Yoaq8rpeC
X-Received: by 2002:a05:6a20:4306:b0:39b:e6af:2d8 with SMTP id adf61e73a8af0-3af8016e0f6mr7940447637.4.1778747194198;
        Thu, 14 May 2026 01:26:34 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:26:33 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:43 +0530
Subject: [PATCH 14/14] fbdev: sm501fb: fix potential memory leak in
 sm501fb_probe()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-14-b3a2474fa720@cse.iitm.ac.in>
References: <20260514-fbdev-v1-0-b3a2474fa720@cse.iitm.ac.in>
In-Reply-To: <20260514-fbdev-v1-0-b3a2474fa720@cse.iitm.ac.in>
To: Helge Deller <deller@gmx.de>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Sebastian Siewior <bigeasy@linutronix.de>, 
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, 
 Ondrej Zary <linux@rainbow-software.org>, 
 Antonino Daplas <adaplas@gmail.com>, Paul Mundt <lethal@linux-sh.org>, 
 Krzysztof Helt <krzysztof.h1@wp.pl>, Tomi Valkeinen <tomi.valkeinen@ti.com>, 
 Michal Januszewski <spock@gentoo.org>, Heiko Schocher <hs@denx.de>, 
 Peter Jones <pjones@redhat.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Abdun Nihaal <nihaal@cse.iitm.ac.in>
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: 5782553F595
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247152-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmx.de,redhat.com,suse.de,kernel.crashing.org,linux-foundation.org,linutronix.de,rainbow-software.org,gmail.com,linux-sh.org,wp.pl,ti.com,gentoo.org,denx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cse-iitm-ac-in.20251104.gappssmtp.com:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nihaal@cse.iitm.ac.in,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iitm.ac.in:email,cse.iitm.ac.in:mid,cse-iitm-ac-in.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

The memory allocated for info->edid_data in sm501fb_probe() when
CONFIG_OF is defined is not freed in the subsequent error paths.
Fix that by freeing it in the error path if CONFIG_OF is defined.

Fixes: 4295f9bf74a8 ("video, sm501: add OF binding to support SM501")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/sm501fb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index fee4b9f84592..1ee7842517b8 100644
--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -2048,6 +2048,9 @@ static int sm501fb_probe(struct platform_device *pdev)
 	framebuffer_release(info->fb[HEAD_CRT]);
 
 err_alloc:
+#if defined(CONFIG_OF)
+	kfree(info->edid_data);
+#endif
 	kfree(info);
 
 	return ret;

-- 
2.43.0


