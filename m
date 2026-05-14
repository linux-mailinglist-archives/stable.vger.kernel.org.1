Return-Path: <stable+bounces-247139-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHkcCdqGBWpOYAIAu9opvQ
	(envelope-from <stable+bounces-247139-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:24:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB61153F3C4
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD963301745A
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 08:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8343D8120;
	Thu, 14 May 2026 08:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="TyxvKzJw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2BB3D75A4
	for <stable@vger.kernel.org>; Thu, 14 May 2026 08:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778747096; cv=none; b=W8AB+Oa0F5r8EaAk0v6N6pOeWaui+7JPPztf+uzom1/Wtcj3Lan509YxV24TYGR4QUI2GGCZEY/+/Yik+iOyyq5T6A/3qHpsdYo4MbUrekmNqzr/Qh84rCtVvRODliOlWU9/FGN5+8Ly442rTq4qPE3Rf4w7tTzlBp1Iz2NUizw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778747096; c=relaxed/simple;
	bh=WWJm/xpIv5plkf8LM1Nw9aJODKA1eKtQKr6e1aIxW0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ee9H8ooa0Wm+5VdKyFky+Ex3WJEqp8RE6Q25VovlZXlNUez/T/ChZMY8oc9lGIxHBVt5HgSJcyr//QAt0/BTm4bEJ+GtBgWYFF1HOmt81BGjPnHH4SHQGLCw5ZnYCr/KLjRUicKeCJkB9cxWdMik2omGFovEFlfzelXFOgnaBMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=TyxvKzJw; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-367c26471f5so4000607a91.1
        for <stable@vger.kernel.org>; Thu, 14 May 2026 01:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747094; x=1779351894; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XFQkelQQRKhZpfEoPGAVYNK0Hwvv38SrBtzyzwAZhUY=;
        b=TyxvKzJwznLCqIX4SPN3uT5eAaPuDct5GAvbEtYAREL7n+a8AKy12pfQA2nB9wrAKR
         7ywQ1HnUcvmQ36Jn+igoNQtb2tk50CUT7LCI2A9/CL+hkR9Okzjt/fIDhDMAeG12iP9r
         vp9S3FFrPoAx9VFZiF0b5pV1gR/oYFD0fL8Ptua1cUhebkarmuTwlIc27gsaPQjeLGIJ
         vVNbDmbzXhhAxwcNUp0YZdmQwOnj5IOBZVqZ4wQoh/ZkMKhhjKyI4T62wbaUryRjJ+5C
         oD2NCTm2TN1X6fXNxoZJZFgy5xuteeCg4J/FkY3Y2j2fW4ouF9Lz2mKD2Nm+bl4FAK/C
         FPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778747094; x=1779351894;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XFQkelQQRKhZpfEoPGAVYNK0Hwvv38SrBtzyzwAZhUY=;
        b=mxERRuRD2RGpapVXp2qAAUxiRqb9XvwblSagKbTfC1Pm2j/Ez2PNvSrJ7AX2cgoF7W
         sI5vsk3pBs57XSsjS2lJc8Gwn9CJK83ximHYHzez34aMPwj35SO9V2QoZ/Ohy/D3Bnge
         1ZKGOndpwiCG9j6c8jxgHP1nmxwYjU+V4JCKWBWu7QM60lEv0h2fQc/jvo5Q7XtaMZBo
         8OPf0q8MUDPGMCUoJqUhH+Nu+yrEKLlmKa/XzvDaVg1lwkJgFtkOwBtbJzGBbcmbe6/p
         4SEX7r6ydlevHQYKG7WV004gW/p+QYDOG8hnzqrjhUWGlgJnLFfka9bQWijooLaDU00U
         nMhw==
X-Forwarded-Encrypted: i=1; AFNElJ+h34z6qEL3nLIfO98AB7ecpx5hJrxa4vliiTIMfpTFu943HWlf9Pzvr2PMwz7x9lss+CcURSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm7d/OKQYXD9y9q4pYSuVlXuEOoKg3zUgO/nOsplRQfl+m7kbS
	ROvZT/yOv58mTei3wbZ9lSnFNLvufO1Sp9vxN/D7PJHm1mXjkFISEhUP+FbzDLk/1hIXwdPk+NA
	QR6zwG+E=
X-Gm-Gg: Acq92OG+4dPchauobyx1n6GgMfa86mz3lBh29B0wJuHX8l99TSGjanYWIA2zpkh/GRR
	cR2u/UvZ96PUXGzYplX3AnZwL5PNRBvTVxVjZlCwNkoeI62x2YfYpfvOVvVRTg34VgYre/WzCth
	2NgddS0vuNCzZs/FbxlYQhKN5LTyxdic9E43Iv/oqTONwgT2h0dVdLJ5PxAF4KQyexoHYj+S4jc
	oR2xwGSx9ChWZGE0fg9FqCRtRT1elXq2Pmx2mR6v7AapeXNYKqV9nF5jTk5bYvrd9amT2hXe/oz
	7r5ML6de/79wYNlLWgHekZgPJCDh8Xh48nzGSL7l3ezzgMkSBEiW3IQPmU4L1zefWG5GZwdVIC1
	lyYJ4Mys+IqhxH11U5X2/9ddj7xPti7PFWjSNBQGVET/HA6MzETB3tdT9dk9rSmuo0y1sOL9Bzy
	wHE458dZHuN094Y1j7EZoAWfU6JgfnHapKvy3YB/5AhjdaGeuqZYo11uj9mIlzqieyjon0HniBH
	LyLMguokD0z44IQ8bhNDvF6yrOaL3N+0HIdEr+7f2Da
X-Received: by 2002:a17:90a:ec90:b0:367:b8ad:f0e9 with SMTP id 98e67ed59e1d1-368f7990c58mr6047925a91.16.1778747093565;
        Thu, 14 May 2026 01:24:53 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:24:53 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:30 +0530
Subject: [PATCH 01/14] fbdev: hecubafb: fix potential memory leak in
 hecubafb_probe()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-1-b3a2474fa720@cse.iitm.ac.in>
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
X-Rspamd-Queue-Id: EB61153F3C4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247139-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cse.iitm.ac.in:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,iitm.ac.in:email]
X-Rspamd-Action: no action

The memory allocated for pagerefs in fb_deferred_io_init() is not freed
on the error path. Fix it by calling fb_deferred_io_cleanup().

Fixes: 56c134f7f1b5 ("fbdev: Track deferred-I/O pages in pageref struct")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/hecubafb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/hecubafb.c b/drivers/video/fbdev/hecubafb.c
index 3547d58a29cf..dd2af980f3d8 100644
--- a/drivers/video/fbdev/hecubafb.c
+++ b/drivers/video/fbdev/hecubafb.c
@@ -192,7 +192,9 @@ static int hecubafb_probe(struct platform_device *dev)
 	info->flags = FBINFO_VIRTFB;
 
 	info->fbdefio = &hecubafb_defio;
-	fb_deferred_io_init(info);
+	retval = fb_deferred_io_init(info);
+	if (retval)
+		goto err_fbdefio;
 
 	retval = register_framebuffer(info);
 	if (retval < 0)
@@ -209,6 +211,8 @@ static int hecubafb_probe(struct platform_device *dev)
 
 	return 0;
 err_fbreg:
+	fb_deferred_io_cleanup(info);
+err_fbdefio:
 	framebuffer_release(info);
 err_fballoc:
 	vfree(videomemory);

-- 
2.43.0


