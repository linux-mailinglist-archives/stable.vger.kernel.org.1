Return-Path: <stable+bounces-247142-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKHbFCeHBWpOYAIAu9opvQ
	(envelope-from <stable+bounces-247142-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:26:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E944653F462
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE4033015452
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 08:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A656B3D9047;
	Thu, 14 May 2026 08:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="tcuT8auE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB043D891A
	for <stable@vger.kernel.org>; Thu, 14 May 2026 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778747119; cv=none; b=FPBsTcsAw0goBhLCk/jYopmv9hKWP/91I6ZkHarenHTWF8kUh5pzcFyUEKjMcgVpduBn1QLwkwYIfB4JcSX84v+qLhovBOSAbwoWtqGFAn3b1sa9LXiSGCdtuwizQllw2N3hJrhPUex/2vILo8FsBHJOanh2LgTe3Vawh2kDers=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778747119; c=relaxed/simple;
	bh=s7vOJa8zQULdRpt82vMyDCCkIAR3Vt7Pe6/FpWy2FrI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FMaJ72eyzy9+VDl84sU+IJIB5i17BXqVMC4u3ESF8Eg5l19ubGi7jCT5i7/TNMhrS869uD/vKFGGoSUXaVMFU9U/wV78dDx9eyE+GwcV/nj3hOugoLADuE/QzRGXgkVjGRPE1FYmCOYX3oOUtcd9S3GmGxJ3mfP+h0+eXrBiwHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=tcuT8auE; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c802803ac17so3487109a12.1
        for <stable@vger.kernel.org>; Thu, 14 May 2026 01:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747117; x=1779351917; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJh4Y1vJpYq92CQsC3/GcBHFFxqYLe8usjdVpu9K90E=;
        b=tcuT8auEbn6gOYZ72sU9YTaYv0dH8GExcpdHV4HPr82hDl83wGoqCpq43XY8XTrpQb
         3wRlqXczsJDiswRLRSVMa3vIH6EgaL/j96QJT6fWcswSUlAZc2h3M8J+fS2fnd4qhnRx
         KGm8ZcH86jrR3d1hwrW7KU5W68xrECBHMU+GkQgFDMMXBboLVa4jT45FQl7otf4IEUM4
         +bdYLwZGsNy6KUPiAkZ9SaJ3k0NpThHzLoiKoFarbFIGXb3Y9EAcTUenHT6ZVFJspBus
         7U6KkLYf5Y0LfPsTBo2ncYJMbmtctcuhbhtH3DWUcMyFyVQmZ/tGe6T9fXggBNHe8sWZ
         0EJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778747117; x=1779351917;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fJh4Y1vJpYq92CQsC3/GcBHFFxqYLe8usjdVpu9K90E=;
        b=cyafHVvgry/KUqEIOjABVZS1oj3JNJj7georyEAyMcGGJHIzbQzb9kofxz3JkuXFvt
         RpW3ycVyyl8It23FLihiCjFdvpKInhZpSKUC1bIVz+f7AEYycuhMu9F9zRe31ev3bnqW
         D8cBnXqF3jXFRq1PPAnN3shgcI+s4qaQ1FJAdfwBUWPrWKtin5EUEdu3OMW6LV48XDZp
         7UY7faRFHQff9jgpz61F1cFabiyg48/sLv5fNbh/JJsJVDB8FESNUaeV4mIuVxHG5uNs
         ZC+1IDd8WhCsnWVsDAHnFPQV7/ikpxatmd0K1W3ap4UffdbpzouyzYtALgcZ2EWa9YN0
         63vg==
X-Forwarded-Encrypted: i=1; AFNElJ8n2M+NBYSkFplFndh45OocbgBY3mOXYbl27WdHTMRjPsDvBfUiIc4zChxtMkY4LgHlqQO+VXU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw38koJrOHJ7hFiZxHTkWw2HYPstLP86k3+q7PZojJhJ2AJ+bVt
	+2Gm2V45dUIoGKZ9KX2uRVfY3Adbs3xAUGd0X1j1woaix63ZoqUzWiVbb5XufxLKRTc=
X-Gm-Gg: Acq92OGDE0tKBcvqV876Fv9WdKh0kktfkzmKkKuGMzQaq7EUhyp5pOsdfTHCvWHEaYz
	g7HOjT5IkZy2SrOvLDZsA7npj8Lq8MEVdLBljZYkDX2WevaCMkfKyC0G8iJZmZun5QDQadnwgFb
	zSBDd/OaiK7edaBYb50LVm0Zx46WEIVDSW0QGmwEtqgjpZf4i+yXH+ar/G0t90YA+BJqUDQdsrY
	obfVqVf6PJFhQR8pUtV091Do+fFYVd5SA0LGJxMF4qdUBVXgjzKViXyPCNPmQgyyXPJhpNyh+QV
	fl9kwAdqqBc4iFEU8+6CchYh1UDvyTWKGXvgcfUrCCpDwK9SeV9zNBoVmWavuYZA36Og/qGKIbP
	g8et367Gmn+ohPavA0w6tWny229UNRy2VMfG99qe7Qp72opiKXgrCQOjsyfvTCupwGnxDx3NC62
	2ElRFNBEgumnSgG/BA5hH/Hen5xw4UjCGuJHTvZiglx4dABGnDfJVft2t/ojgUOICe7FE3CGFU+
	r5mWJaPnJoazLp1p7OaeACocNiJX20LtSA839itMSjVSWGudB7gGO0=
X-Received: by 2002:a05:6a20:939e:b0:3aa:c99b:5c63 with SMTP id adf61e73a8af0-3af7f25ba7fmr7209249637.18.1778747117417;
        Thu, 14 May 2026 01:25:17 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:25:16 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:33 +0530
Subject: [PATCH 04/14] fbdev: radeon: fix potential memory leak in
 radeonfb_pci_register()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-4-b3a2474fa720@cse.iitm.ac.in>
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
X-Rspamd-Queue-Id: E944653F462
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
	TAGGED_FROM(0.00)[bounces-247142-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[cse.iitm.ac.in:mid,cse-iitm-ac-in.20251104.gappssmtp.com:dkim,iitm.ac.in:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The function radeonfb_pci_register() allocates memory for modelist
(by calling radeon_check_modes() which calls fb_add_videomode()).
The memory is appended to info->modelist, but is not freed in subsequent
error paths. Fix this by calling fb_destroy_modelist().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/aty/radeon_base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index adb03489bedf..b6b058cee751 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -2476,6 +2476,7 @@ static int radeonfb_pci_register(struct pci_dev *pdev,
 	return 0;
 err_unmap_fb:
 	iounmap(rinfo->fb_base);
+	fb_destroy_modelist(&info->modelist);
 err_unmap_rom:
 	kfree(rinfo->mon1_EDID);
 	kfree(rinfo->mon2_EDID);

-- 
2.43.0


