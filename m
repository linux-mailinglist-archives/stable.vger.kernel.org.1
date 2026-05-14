Return-Path: <stable+bounces-247145-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4H+yKWKHBWpOYAIAu9opvQ
	(envelope-from <stable+bounces-247145-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:27:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F66353F4D5
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0D4E306BEA7
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 08:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5C53D902E;
	Thu, 14 May 2026 08:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="uMfigl6P"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEDC3D75AB
	for <stable@vger.kernel.org>; Thu, 14 May 2026 08:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778747143; cv=none; b=TnqWzT+xFPoD4eBPPujMmMD5U8xbQ8HsZDzP/SdrHgPOY9Lr6h94FYnw4MXhA9cabk+R5oRfxHVxpg8vy84/2SwEqCvvoUqHh/aTi8ddqvNwlEF+7C0ONPgqgSuKrQbvrVYOL5Y7F5cWNPOq/V0ZKXxc0FWSPH1DtfrAgTI1CCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778747143; c=relaxed/simple;
	bh=UAStXm3OSu9RI1NNHAXC/tKQ3QUcpDehqql4Ja1eUUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f9a+j8vP7NraXuCEbBjNMa3wW7vLVFKhAgZg4jcmkOxhXQWSwOBVTWsq0vOnrdb5c5T34pcJT01layygaV8awbAQbQ42FTxREVKvgHhenAMQeOTHA4qVNUAO2+ffBs2e302yTRL6az5rHYGclVCCvpKTrqFWYX0DvXY+WdUgKF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=uMfigl6P; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c8095d7d75bso3261160a12.1
        for <stable@vger.kernel.org>; Thu, 14 May 2026 01:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747141; x=1779351941; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XqQpLk2INDxanrU5EbiD7pVjr54bhFQM7xaG69RB0RA=;
        b=uMfigl6Pt73NSZmj0+Pz4EcgcXP2WXDNJHMPSGy3ceT/co1nGyAEN5723UIeBehawk
         moiC/5qdGTNM/TFBRMtR3YwWH8126Rkqv8AEnWMPEenONu0q+MfBJKUcHcWwT53Yjxmq
         j886aQMsY3N55sV5xIeM+nft4qMYUFtQYbSaTu4CKUKKoQOsEkfCd7yUZBCU9f507bVl
         YYM4OnsIC0vS42/AjzFvTlgyzP/XypjQEziYopmglIbO1bKTWqbefWsE0/8trDyDznZu
         qYngcuRkA/HrhBcaIKlSWUPLfTxOfgskTm4hWav0LdXJrnOh8GgrUXRcdpqcFXBPmGP5
         Kk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778747141; x=1779351941;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XqQpLk2INDxanrU5EbiD7pVjr54bhFQM7xaG69RB0RA=;
        b=hYOtnShb52nOrCk9nOGVCFnlHYYDJ910MhBZjysyLEm4QnzG858Sws52V5fce2O+MT
         QKvmoj0079IBTyg0NF5larumR+FnRkMEj91v3/2/VNClEPeLXO5tDYCkNUJCrqUZmAhm
         gsrXE0g7xFQsCDTAO0LInFVUicDcMkcW6zm2kAo/LSBTgKiKHd26eEgQq2k5WEP+DG4M
         cGP+cZueDLSXVwAljVsRphhf4INfpB0AECCqUkSogfl0jkzwCZ/vVhRsTT7xk0L6Er1Q
         YyibmHgoTO3AzbM0oMTEfzUrdp3kPxBJuleSuBqiDh+3tyWFdPvDShDtDn41JC3j71SJ
         7MmQ==
X-Forwarded-Encrypted: i=1; AFNElJ/flN/XcKrpq5mfxQ9wbG8fRASzVifej7/SeLBm6zlGD05Qtpg3Hoit20uKohgNeS98RXF/RSY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5DtCpW82/kJuAftEJFHTDjhklSUOKE+xUmq1eA5EayICaPAdc
	sWdvfYGHdMzM3Jwb0kFViYpRF/ZsI05ZaWp9JWRDp8aGc6iRUleJPiUVRpCPP5WJmt71z+Xwffs
	MISUnSdM=
X-Gm-Gg: Acq92OEJnzpckelX/rF3H2ngJAFc+IyKKLibt+Nj6Ow4wy/m51UQRPFBDIMZNtY/Imk
	hnXWLui9Qmd01SpBjX/H7N++4SusyMQo5m4z0kKfBiPCIE05Rzj0A1kFJV8c75Qloab8iOkCC+J
	+R800IB1vaiBS3aoV18cTRPo3t40RkACunMAf/Ih9dCzuhVQsNwzriPLMG/4I4m/Hh4DQ4zUBnU
	5Fgujh8nqZms2yWMgFO83JKzbYv5MgQ+3KBsinK/SUNPEnYU+3RxXzs4bloFYUaQnZzw6coA5kj
	sdFrfa1ge81+8WuQzQgWOCSc5/G7F7RccVlLgJjphC7Oh28+5XaDDwPMyXLhq/6zIiDVg9Ih101
	7DjN/Pp5lzs88iweaPyOSITrjC5VZzjvkDbQC2aGbWqI0S7lhstl3ehtVOcXVqgMq6wKQ149FjE
	3FtV9XZmu+YXvuVtYpmX8sVmJhRZz6/7lDirfAgdCRza2rqJRwmqnDQfC6z/mAf9M/zUCj0va9M
	yEcNAYaJSi1hA1bTnq+UdWDjsubGQ3Ykos+25tU56Wn
X-Received: by 2002:a05:6a20:431c:b0:398:7eea:50a0 with SMTP id adf61e73a8af0-3af7f86f95amr7286510637.18.1778747140737;
        Thu, 14 May 2026 01:25:40 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:25:39 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:36 +0530
Subject: [PATCH 07/14] fbdev: nvidia: fix potential memory leak in
 nvidiafb_probe()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-7-b3a2474fa720@cse.iitm.ac.in>
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
X-Rspamd-Queue-Id: 1F66353F4D5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247145-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iitm.ac.in:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cse.iitm.ac.in:mid,cse-iitm-ac-in.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

In nvidiafb_probe(), the memory allocated for modelist in
nvidia_set_fbinfo() is not freed in the subsequent error paths.
Fix that by calling fb_destroy_modelist().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/nvidia/nvidia.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
index da2d486022e8..7d20c4087aeb 100644
--- a/drivers/video/fbdev/nvidia/nvidia.c
+++ b/drivers/video/fbdev/nvidia/nvidia.c
@@ -1424,6 +1424,7 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 
 err_out_iounmap_fb:
 	iounmap(info->screen_base);
+	fb_destroy_modelist(&info->modelist);
 err_out_free_base1:
 	fb_destroy_modedb(info->monspecs.modedb);
 	nvidia_delete_i2c_busses(par);

-- 
2.43.0


