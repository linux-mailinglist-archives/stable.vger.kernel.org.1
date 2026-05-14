Return-Path: <stable+bounces-247143-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ID+HHkiHBWr5XwIAu9opvQ
	(envelope-from <stable+bounces-247143-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:26:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD4E53F4AE
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 434C93046522
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 08:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C5A3D891A;
	Thu, 14 May 2026 08:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="Om9xZZjh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8C83D75A4
	for <stable@vger.kernel.org>; Thu, 14 May 2026 08:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778747127; cv=none; b=Ne6X5pwxFpOzK6cIBFD+7vfCVeGGd1oRv/AwP/8CeBOuuakKt97/+gntqPLgpe9DirqdBEiq/1GR4s+qvZv223D0ElMiTZTIP2Ach/ctOPaKI/EvRPi96GqYRFFqdojl8DiCmEzHq+CXUT2ks8/FsUVh0p427y1dUwKKYgri31g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778747127; c=relaxed/simple;
	bh=7dxxrzbqdG+D1liscZGC4J7GXbPSfqu94rWrjh7Aoes=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FKHonjundBd/qnr7r6jUQ4mrxhnKnbgch1EcBckOgwksR51W/POeWTsD+wZZOsjAzlsvhE+JQw/cyJtce/RQwCOBf+JUKswItHC97/PfIpyZQxEHf9Q2SwjRoONkLY3BdFDYGZwgwvOhAR+jvsN4epBEFGFwXlCdy+GEekYieTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=Om9xZZjh; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3660daea6a5so4257724a91.1
        for <stable@vger.kernel.org>; Thu, 14 May 2026 01:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747125; x=1779351925; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cj4tsYfpJn1h72OjlKL8YrS/bESA9WMb/nnrThUnbQ0=;
        b=Om9xZZjh2bxdxmVNCiYljIo6TEXd0J4seAO8DMoA8QqiHAAoS5TJmjXsFgeTQSAKTV
         YY0Fbnwc6Adxo5JCmEUU23QUdl27ML8rnMntB5Tr2n4iiuc1czbhLqiLGE8i1csg7oGK
         c/dzGAOP4uEGt9eW/rJggM17RmUPWqPwEqCEyMCru0ZnazRwJInWSLBebCuSdLFuTTSd
         a9A6EL5rDoDWL9gPS+AzElv/NnFkkOnnicS3jApYybmvX4XNDxgCpNM6uWnQq0+Ddb4b
         ukXf9upoU8AYTKIa+L09XXOAUoPgypiklhfMJ+1P5vdYZ7g21byhK0vLuumwEyHKn5Oz
         /Xlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778747125; x=1779351925;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cj4tsYfpJn1h72OjlKL8YrS/bESA9WMb/nnrThUnbQ0=;
        b=tBV8moVoMgIdMcaYGK0ORA0ps1ikuTGtWbdOkb7w2hLgL/YQH9RGb/9on0tRkVRsgS
         MopuvXtoQ9+OetRKiRdYx0kzvBqtEGYjno9HPJPGwVMOBhrGw6LOcaUYd00mkNq6/iNI
         IWo3GptMnz3CNzCRzZIm4So34gU4m3BCUaHoCCcTJq/kpPOcZ5C6xZoTNSoPZ1STadPe
         VoMgG3nuI3CdX3HvgV9Bo4oIB6yXueQFaX+nDsJrOlFe6ncZTI/2n4lsLRyc84j9CYPL
         AErsS8ify1T+GGhEcVol7uFzhVlOEyFWSwzT+5iqP/fPWy1oxG+fFYGzEf8cN15uESkW
         CqrA==
X-Forwarded-Encrypted: i=1; AFNElJ+n4W0EjC30qi+CS57cOTkuJRTjFO9PpWi9QzZGWCA7FTBdmoVd+EADDDbPIWqVd3D307MVz88=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR93zfN9U9EC/QfWpizvEo3r0IAdzjmsnFsjRqwMSe7heeiFJA
	bX2kaNBlkDMifE4ZoZQuFa7SpWWqpjiTJ3oxd7YUIB+Kw1M8n+TRp3aCvOL9jcBjIuU=
X-Gm-Gg: Acq92OGqOgvty3EHwrjxHfD29MOMmG7cJwkQoBFqQ7PLjSZs05RiEDHUCBUPY9IbdEd
	sV5qcEUQCIj0sJcqzmtQ0kcRghzf9U517gK0ZaSrYpDZIsJbKZNOfeXUEhrYahp/MUdPG3eFtCf
	Cp4Nxce4KAWPnOlTWj9ciZyvzzCt4QOc0MQdgbB67uOhBRcItkQkF19BOU3kx58y4xxn/M6JXm5
	b4RQpFXDXPxTFOwMKgLS1/MQPvpGZ8mJSLATxkCKzccgWsPRNW8NL3H2BfYf6aBOnWWsHifWu3j
	EcWTk1Wf1HqLcXyXuO+awlqJhqv1huOi8CyvorlvbwsIpBtA4gCKf5434pT9lwTwdln4oCb6ID3
	yoTKZgFibTaXhdLvUFZcShgihIYioWoqfR2R/iSzMit0wvmYgrCQ2Dq8Y3xZMLROD2ge1SN2d8u
	PEWOivFJ5D6xn/NhnW37ReRez01fqL0oq5pxzivUsXPIWJOjIBA2xNxNs/TvVQ2rhvHUihauR0K
	05iin8kcjHLAWwm8osDnyJcGKT9iTv3lG8BwUpQxQPl
X-Received: by 2002:a17:90b:2e4f:b0:368:30bf:e51a with SMTP id 98e67ed59e1d1-368f782f1c3mr6794705a91.12.1778747125031;
        Thu, 14 May 2026 01:25:25 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:25:24 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:34 +0530
Subject: [PATCH 05/14] fbdev: carminefb: fix potential memory leak in
 alloc_carmine_fb()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-5-b3a2474fa720@cse.iitm.ac.in>
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
X-Rspamd-Queue-Id: 1BD4E53F4AE
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
	TAGGED_FROM(0.00)[bounces-247143-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[iitm.ac.in:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cse.iitm.ac.in:mid,cse-iitm-ac-in.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

The memory allocated for modelist in fb_videomode_to_modelist() is not
freed in the subsequent error path.
Fix that by calling fb_destroy_modelist()

Fixes: 2ece5f43b041 ("fbdev: add the carmine FB driver")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/carminefb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/carminefb.c b/drivers/video/fbdev/carminefb.c
index 5f13f1cc79d3..fca50b7961eb 100644
--- a/drivers/video/fbdev/carminefb.c
+++ b/drivers/video/fbdev/carminefb.c
@@ -589,6 +589,7 @@ static int alloc_carmine_fb(void __iomem *regs, void __iomem *smem_base,
 	return 0;
 
 err_dealloc_cmap:
+	fb_destroy_modelist(&info->modelist);
 	fb_dealloc_cmap(&info->cmap);
 err_free_fb:
 	framebuffer_release(info);

-- 
2.43.0


