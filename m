Return-Path: <stable+bounces-247147-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKrANWSHBWr5XwIAu9opvQ
	(envelope-from <stable+bounces-247147-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:27:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D817753F4DC
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CACAB303573E
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 08:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87E33D7A14;
	Thu, 14 May 2026 08:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="aJ7i7gWs"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECBC3D8120
	for <stable@vger.kernel.org>; Thu, 14 May 2026 08:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778747157; cv=none; b=bjp2z9ZHf0dWcZJOffTKyFYh8I3Lw5rnzzkYQhM/HupAta5RKtSBoUfeKT3m6nV4CyBZhbtNBa3Ncn/lttheUw7sNt99I1N/T0GXxQOqp1zjX7QcBDdK5mAC1wncnKObHuaV8VEAF3qKy7gh4NHPTnHIYAX1FEJeM5b+BzYNQe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778747157; c=relaxed/simple;
	bh=+w65POPz1dgy2ppm++LcLkrxW0u0Q5eXVTqgxh2Ur5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nV4M8RpoFgeEcD4flkgHLgUr/7qnyIsF17q+IQergmmSCT5SQ8ZU+b7/yDHhjwjbqLebZ0CxEO99oMtJQeTVNgqueGWlwHhy3GaZPdSuZwOxpYzt4Q3iB3w/oNKGs8DXhhzsvQs3bJVJ2vEJ5DIyy+sNFoYbf2MuKjOB48Drxu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=aJ7i7gWs; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c798fc1a28cso3654235a12.3
        for <stable@vger.kernel.org>; Thu, 14 May 2026 01:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747155; x=1779351955; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hMKbbNZvfD8+3yGZ0ruUDTcJofyUq6ZI9yURAX9o3WY=;
        b=aJ7i7gWs6k4dm+61wyPZwvwPLt1IPnRNPV55J3MEdeOdQzQETnosnYenYT94rhdRZw
         sYDRt0SXkPT8DJKm8dRgQQHIFvjH3MuAV7k5+HZjUuhL7gfiDACakvRxLkl8Nnz4WOoO
         Jgi/v1eOr7J+VY7nI6mT64Wb84/y3lFHIHqH27Oq5vhxXpe69vAXcJZlB/6EvkrmTQpN
         s3eGK09+7Yor1WvXUZVydNvyDNvf/D4dlT+pZtD6fJOIACoPImVWKaURXB5UTtNBR6rm
         WuLDIADzMGwltL9MDsEDTHrGbxMY2cp2DQ4HJNXhXbEvbxzKVCIAMQpp5wJmfCNslmqH
         T3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778747155; x=1779351955;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hMKbbNZvfD8+3yGZ0ruUDTcJofyUq6ZI9yURAX9o3WY=;
        b=CJ0HnLMbe7MknC06AXnUCMTfw1Mv58nFKzKodNfZg+5RRkW8CRH4hrRkkhLNW/jIgs
         jO6s9GMA2p3GHRuGP0GODCWmbxaA4eFXNovoCKSLIVcIp0hKVAQUoC2D8Lf4uXHDF9Zh
         k0nFpfSuzB0/jfrL0zbObe8uLRsc2m1P3BPHsp2eRWNhmySn/DKjp2ptQAQNbArAYHHj
         zp4wwPTbDzP75bcihuvP1yhUxUJf7Gxk1XLUAewsdAZtVfn4DbPNOB5I5sFOCkybUG0s
         OUmwfP/rEK2mfOabp/zzcZ+TRhMWJEBSOsELRIdgZZK4N6FnymwIOb19TpVRaDMKK39L
         aeVA==
X-Forwarded-Encrypted: i=1; AFNElJ8lkkD8bM+zZ4K1gK2AOMUNxf0oigS1qioEktVkLupYTQJlsjJW4qNiNVkwK3sS0yi6L7Nzmt0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ThbDFyMrgoKqk5X5BciYhPwEiglouQ8Pv8rs6XmNwDHLQ3cs
	J/JDe+okKVyncVG+DU3ZCFYst1/PXtSlLAPC/uNE/+IUWfkv0nLmak++UE3Nso6lSgM=
X-Gm-Gg: Acq92OG5HgfGUqBbvJMVPv89y9BOWAbtdeldIwP39k4GkY1z90C6u6aoHIVDtgTSuCP
	qxIao9/8eC/PEnadw0yT+vv+mZ171sxR5ZLkO4W4UYgK5YosBW+NdXDN5z7jWGACSc7934qZpn3
	VeY4KiH0q9fhAM064CWrLpZkDi0Od0Tn4sbOIGqUOQiqBlpNQBM0aAGbTUaHett7Xi1AdgVrvlc
	EqRSwAeNJLX1l9Uxd5SpkDab2SeFgCo6f0J0WJX8prKIi95G5Kp6+fvlQhRmJ/C0AJpuMtYyrcj
	ju3VQWNpfSfzPcUdk3Gkg7Vt2I3k2d7ukMBbDdN8aLitCqmmsdwz53NIyti2JzfkPg337rHp0MB
	Sng7fX6YQu7MJ+7nIpwgtam4so3dZRyJlrAUzvUYJU5fiXHykRoNVQTcBeDsyXTgl73b4ofbYUL
	y4gjKzPxjXXGRChv4zTNH+A9DOUMN4ARAozWCuhx4tToj1LNfglhDTuExDfX0KArD6apByxdkV5
	7TRxyyqh2iGHuBcr4vAR/A45iOXvIr0UNMs1iNBw6it
X-Received: by 2002:a05:6a20:7fa4:b0:39f:2b9e:e472 with SMTP id adf61e73a8af0-3af7e835015mr8274496637.3.1778747155351;
        Thu, 14 May 2026 01:25:55 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:25:54 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:38 +0530
Subject: [PATCH 09/14] fbdev: tdfxfb: fix potential memory leak in
 tdfxfb_probe()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-9-b3a2474fa720@cse.iitm.ac.in>
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
X-Rspamd-Queue-Id: D817753F4DC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247147-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iitm.ac.in:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cse-iitm-ac-in.20251104.gappssmtp.com:dkim,cse.iitm.ac.in:mid]
X-Rspamd-Action: no action

In tdfxfb_probe(), the memory allocated for modelist using
fb_videomode_to_modelist() when CONFIG_FB_3DFX_I2C is defined, is not
freed in the subsequent error paths.
Fix that by calling fb_destroy_modelist().

Fixes: 215059d2421f ("tdfxfb: make use of DDC information about connected monitor")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/tdfxfb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index a6b63c09b48f..cc6a074f3165 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -1552,6 +1552,7 @@ static int tdfxfb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 out_err_iobase:
 #ifdef CONFIG_FB_3DFX_I2C
+	fb_destroy_modelist(&info->modelist);
 	tdfxfb_delete_i2c_busses(default_par);
 #endif
 	arch_phys_wc_del(default_par->wc_cookie);

-- 
2.43.0


