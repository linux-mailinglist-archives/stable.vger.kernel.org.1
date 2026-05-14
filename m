Return-Path: <stable+bounces-247149-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLq6NqqHBWr5XwIAu9opvQ
	(envelope-from <stable+bounces-247149-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:28:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B4653F53B
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A100E3056634
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 08:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E22D3D9DD9;
	Thu, 14 May 2026 08:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="k91Y4giH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DEA3D902E
	for <stable@vger.kernel.org>; Thu, 14 May 2026 08:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778747177; cv=none; b=oOmAksSLkYP4fWqrnwO9Rc1LGtK53TZPcQ/rvGdZGXsI4qavClj/PXn69q0s5hqS8DqTxBCwFW8mMyddZX6N25TqPO/RseNGP59+HmlsnVSF//HHwN93wVZveLQzQas3G4QUcGs0ske8yAsVjhO0wflPIVQe3HIQFlefMXhxDqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778747177; c=relaxed/simple;
	bh=Clp/7+dps7CMjUewVBlwf75eLhdxMdYd3dH4NKEEqKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KCLxqIO2csOcm1GaPq3jDlKnxbL3SKHFUtJnqv0xA1LI/oDYNZXd9x24TSyDR6Dr+69n2USBaaXvOF2rmS2fuCQpF95eo3l/cuMV7WAP7j/axw5m46ZnUY6LDS8cD3Uo/Gtkc2sDLvOTD1BPxuAJc7w1Ixjkv0PXE4oVCe1q6X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=k91Y4giH; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c70c112cb61so5967025a12.0
        for <stable@vger.kernel.org>; Thu, 14 May 2026 01:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747172; x=1779351972; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GheaXfm6WhMIcKtl8e6E9+wMuBUvLISEtMm7ivNoGig=;
        b=k91Y4giHff01yxWojuLia/M9fAL4RljVppDZPb60vAs3vI6vvXcysEMJ4dM+ZdJPRo
         rtJuyF9e0tOv+mefyYhoCtda8ZaXIoexCsB4eNz5j0k+9K3Mn8BRb6qBX2WdJLt3TIdY
         MMa/8DMmkrqKDq+XL0tX5VARTK1ndH3c25lmdhhLwCdBXBOk7e0MHxg6Cdjgqk+6WbmU
         yRmjb3iZPgkJU1SK4I5tWOlhkAQmhiiaZlqD7dtI27z3Bpi0At628qbrFY9zY7ImF7BT
         HgnZrsjVZT+3qpC/MUteJT/Jts/unfTCx8NcMF7rud8jEeF7LFVHMDnJt3rj7F2kutJD
         EAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778747172; x=1779351972;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GheaXfm6WhMIcKtl8e6E9+wMuBUvLISEtMm7ivNoGig=;
        b=YIlUtsAkcre5iW7WMS+/XJDa/aWttvsS5jpCCkF9coSvdR9lk03uMzmhBlTZvWNI6h
         ikKyJwpHbNJSslLPDfSvxY+zUb93kaLOV6ezk8YFgs8w7KVuGPBD92xdQaYOAibUXIQ3
         7S6W0+bVpFl03cvhHlNfO9TKLjxmyfGUBxaz4MxHPSgxVMtsW4D20KWG1BoR0IB35nnc
         q4w7teEHYRX/TUIfG1XyNWJxbObxvWkRNtdqy0ZGY0M3z7ypUmLoFWrvt7SGOPbkECQ+
         8ggUqJ9TPI5EZ2eAk2T5vWr2Olw4/HNHKUg/9fq+vwWjcHVHsadFuMKYBHgpiZbkzPpj
         RWKw==
X-Forwarded-Encrypted: i=1; AFNElJ/IJm0oPQfaSe2m0r7VgWGxOefhS9etRegXHztzDOqkuTcx1P/FgQkhCZZuAyHwiPgWZmVIxkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+vmw/LSQjFPjJuzDb1s9GAX5tJ+InNd8yT7n+giw2tuk/YLqq
	ddrkw7EoloLvzECsQBdj0k6eE596NjJBAqVRYj5iyFT7n4zk1Ue2u2gSzfuOunSBXIM=
X-Gm-Gg: Acq92OGZU7i6sKlsyzr8ETH4w/dcvzWg99rVLtlhexn8HAjGBcTQgZPCNfjFnJvXCU9
	FTL0syJI0ExJ3RdieqI9PNj4rgMB+7mawzBewJTKTueOwX1uF++rrKLCtND6zq8Cw//Fm3cwpq4
	qVBPuPxmNEgMfcLwsQHU8gxIDJG6rv9dGtCRl6nDAo2DjbMx6T/hLYtyLbWs4mNzsTln714foVi
	JPdl3t5LZftuBLusLtXoCZCeGwluVtDVkHcLEAGV9oGKdGIv01eifC/dO8GpCfHS1Zmy5W9FYbZ
	qDIkKbxjypu1wMv6qMozt98pWHtbLIu7z8KrrSuaDSwJYlUKU4FDu8TvlMVBkWobP3S99mG+fSm
	VuICsdldrLIh9SiwL0wPlj6ILBDDpQuGVsgwvklJm8B++G5cCiL+RUCMxxWm4wM9pScR9uusMEo
	PWtIzrbJaUajQcfk71iDKTj3wMXGV6YEJ3KGBwzIIYdmAvVsvb5YgP6zdKvwITrBou25VdINL6Y
	+SIDCb/GYuk37ITXCBcj+UC6a1XO3coiVzeE2f/jWtM
X-Received: by 2002:a05:6a20:7f8e:b0:398:8002:8033 with SMTP id adf61e73a8af0-3afb0524b0fmr7156205637.49.1778747171713;
        Thu, 14 May 2026 01:26:11 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:26:11 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:40 +0530
Subject: [PATCH 11/14] fbdev: uvesafb: fix potential memory leak in
 uvesafb_probe()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-11-b3a2474fa720@cse.iitm.ac.in>
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
X-Rspamd-Queue-Id: 39B4653F53B
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
	TAGGED_FROM(0.00)[bounces-247149-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[iitm.ac.in:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cse.iitm.ac.in:mid,cse-iitm-ac-in.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

Due to an incorrect goto label, memory allocated for modedb and modelist
in uvesafb_vbe_init() is not freed in some error paths. Fix this by
updating the goto label.

Fixes: 8bdb3a2d7df4 ("uvesafb: the driver core")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/uvesafb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 88667fccc27b..9d82326c744f 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -1694,14 +1694,14 @@ static int uvesafb_probe(struct platform_device *dev)
 	i = uvesafb_vbe_init_mode(info);
 	if (i < 0) {
 		err = -EINVAL;
-		goto out;
+		goto out_mode;
 	} else {
 		mode = &par->vbe_modes[i];
 	}
 
 	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
 		err = -ENXIO;
-		goto out;
+		goto out_mode;
 	}
 
 	uvesafb_init_info(info, mode);

-- 
2.43.0


