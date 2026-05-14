Return-Path: <stable+bounces-247151-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKDWOfKHBWr5XwIAu9opvQ
	(envelope-from <stable+bounces-247151-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:29:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4318853F57F
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 437F4307BCD8
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 08:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD913D9DC8;
	Thu, 14 May 2026 08:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="h76T2dX6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8EB3DA5BB
	for <stable@vger.kernel.org>; Thu, 14 May 2026 08:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778747194; cv=none; b=Crwb40fZwSgE73KO4PFS11vbRr1era5rPCcOJKifzBhj7eVAxXyHdPlS5yjidoY1V9Q6DcoK39gLuFsNlLKHBBDBHQQ5mUh5H5ubmscIIpPpRZm/C4aIa/E6zuVXVEMXwOOJAQxsZwNt4TNX7DPvMGwU7PfrbYMLA5JYaspSr6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778747194; c=relaxed/simple;
	bh=zPOhLPdshjE8pq0yGg4SKIgXmW4mTNuSf+gp1KyIA98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E3kV7rC+9J1e6Se6fTIbKLEA7MdkcbwKd+WMMyYER//SC+XFZ2hmU81RpMqXQkB03u2FxmPhypnA+HLMksixswUVHYOWg6R677nwy2n81q8Px1E7Q2M2DfO+nckUJCg+WU1QvJvRkV/oIweZlbJ9Gs2u8ADTAJExRFMgnT5p+wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=h76T2dX6; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c796163fac5so5663112a12.1
        for <stable@vger.kernel.org>; Thu, 14 May 2026 01:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747187; x=1779351987; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=okp+cmZfIVDgj/1rQL2V5ef2DxZfT0YRw0dNkTRuA+Y=;
        b=h76T2dX6rzwGflgANlozqXzsxg4uiWSuBqieZVRcYKqyXWeEfu4JkBFZxfQV/+x4CA
         rIHcN4UoGHUtxBdD18N30WdNfC66AVGrFck+/6qGgMNYReuGT8DYIQw2eE6trGJw+IR1
         WxuRO4/ueeJIDYHZFPaHjlT8btsJMIl2Fjty1YyIL25KHKOW0qDJWyfRlehZCy7Qbc8p
         QxZnx/kYyLFbDygLhJoCF99KocQzjRZR3uNGPAGVLikMmNw6lJL2WAyaQ33hPTQbO1fL
         0ZoFaBkgji4g2oZrM6nflQIYUW6doM6KGgvVK903AMg3p1XCj98CPCU8AYRb28wfok5+
         tSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778747187; x=1779351987;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=okp+cmZfIVDgj/1rQL2V5ef2DxZfT0YRw0dNkTRuA+Y=;
        b=nzns2y445c+NwQwpqW/elxCjONSngTFgjpBDkWh8A6MrVBSYkniiScfVqtBKm8y90d
         xfamluOk/5aBPYATvJLuTPDkpn3XTsZBsHoJ6sNIgMk7O19vwmvaRlfvd0r31OGXKKjW
         AxggUbU0a1+v46zlQE+HnO/rXOdH6cQrL5CNvftYGB1xva0wV1fmitTrVfjD6lvhzScN
         BBmNys+VCx+Z82Et5KAjxYAgBWy7ZdbNZRGS26sAKc2xwufeIFbhTFJZTdvwIMNSqwkp
         K4y3QauCYAkRdtx/MKJUpEeD1SWHA6QcJA10cA+6ejcfOFK/myuMNZ1qJBpoItO6z7bw
         GrkQ==
X-Forwarded-Encrypted: i=1; AFNElJ/rSjkiJhW0S52Mlaeb2q4nxTAtFQG/nwb4q2PljlpKMRDBEFP2AZ9S9zf7qVul53FcJUgqq38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3dAbuTCIjA+RSYaf4AFE0b9Pyw5Wb0KQYDJ3DA72QTRIK8Bg1
	CCUBcCuJniHg/8yIoGlplMJ9uJQXdM/E8mI9ljA32O29pUHdodlfcfRBwDZMSilsnW4=
X-Gm-Gg: Acq92OExQMDgmFKAJA4jLjdNP32cb9U+0A/a6eYJ23FlwRofdqXBiozR/oxtNURmfpd
	TpSWkG6EBjEukp9eNoXMsXQxnhfeQ/nsQzby4f6zQaJvrgD4egOwyyqD26PG1oINRxkdNlWdRWx
	BmepUK1f+1Qlx/GaL4vQO7ar0ivHC1G0Yogj5Kysyg6K8zAV8vtdVY0OE3/AHWaMtQVyidFTxuv
	Nvw+HqDpseA6Lq4taCN8ne2OdJq8Yj6Hc9EIzwF66WQLvWdzP+/o5ZDyDMV1QeYUiFmaY3A56nX
	MvbiWQMTxbH8kDgtZdioenYsCoF2x/kMp+e09RDR/I11A3gS/3x+eAMT7wnSn1Xorv66A7eQHQA
	uxXc4JCXJZMnvMIa2uSZnM760NquwYP901BTGWznaK2mEmetWKK3KBQ6vKnlnNldg0xeBL8id1q
	CfvYUKtq/fL/YkLRlMulaK3sMZSDmZ7Z3R/xmBD/HUd2v99/lhotbvSizfbekju1B65KO9OOETF
	0sfG8myT737eDMWHLLIQWWPb2zXQSKt4XyT591axAvm
X-Received: by 2002:a05:6a20:12ce:b0:366:19e9:f43 with SMTP id adf61e73a8af0-3af80079e2bmr8359899637.6.1778747186893;
        Thu, 14 May 2026 01:26:26 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:26:26 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:42 +0530
Subject: [PATCH 13/14] fbdev: vesafb: fix memory leak in vesafb_probe()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-13-b3a2474fa720@cse.iitm.ac.in>
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
X-Rspamd-Queue-Id: 4318853F57F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247151-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iitm.ac.in:email,cse.iitm.ac.in:mid,cse-iitm-ac-in.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

Since commit 73ce73c30ba9 ("fbdev: Transfer video= option strings to
caller; clarify ownership") the string returned from fb_get_options()
is expected to be freed by the caller. But the string is not freed in
vesafb_probe(). Fix that by freeing the option string after setup.

Fixes: 73ce73c30ba9 ("fbdev: Transfer video= option strings to caller; clarify ownership")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/vesafb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
index f84f4db244bf..f1902056bd73 100644
--- a/drivers/video/fbdev/vesafb.c
+++ b/drivers/video/fbdev/vesafb.c
@@ -269,6 +269,7 @@ static int vesafb_probe(struct platform_device *dev)
 	/* ignore error return of fb_get_options */
 	fb_get_options("vesafb", &option);
 	vesafb_setup(option);
+	kfree(option);
 
 	if (si->orig_video_isVGA != VIDEO_TYPE_VLFB)
 		return -ENODEV;

-- 
2.43.0


