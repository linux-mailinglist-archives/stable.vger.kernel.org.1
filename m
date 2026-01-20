Return-Path: <stable+bounces-210549-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNceO3Gib2mWDgAAu9opvQ
	(envelope-from <stable+bounces-210549-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 16:42:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A16746702
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 16:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C90D5E3EC6
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 13:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F94436375;
	Tue, 20 Jan 2026 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="TnXml3zX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77906436345
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768916026; cv=none; b=o09qAKxGXQwECoNi9wIRIWBwBNQ+mDFu1ISspFt1+Oxf8ig8IJO9mT2+puQ9fW0mnoGuRlMIuZrbu3lbOXlhE0Haf02/I0hEMmjBXhsfuT6QD91wkFrtMvh+eyi3ZjT0qnkoAw2H2CfEn+HXV6ZA+JJddB4ZmbtnBJcxk0Ge1aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768916026; c=relaxed/simple;
	bh=Fmghef1Fww0dPCiuwecGEhxAwkx9U8pFSKi7M4eGW50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2vbKciH7mqOUjNXdSyYOdOw2DsLu/yWl0h/fkDP1GYFg1//imuIJgZ38TIZFlgOTBa6Suq+R08LkoJv+WTlul89XF5jq3r77JD6G7zG966SYaSBI4ToqaN4Zpi2W1vJxH6aLdvMvBb3JqJxkN+c1ZKvZVsljm4sA/7SC6tEyXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=TnXml3zX; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4359249bbacso277732f8f.0
        for <stable@vger.kernel.org>; Tue, 20 Jan 2026 05:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768916023; x=1769520823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Avajm5y4036daHiMDTtwCw98gx6dBRxK0z6ouokSi1g=;
        b=TnXml3zXzsfj8ZbBW7Or2o8WzUlAIN3JOgoYfajkXdNUVgVsVe8B8aiCF/unq3ffqV
         IdIR0RAxg2Dx7nNzj+QLam1Woy+AiZYG6TtpzRf645NUjwen17sLklAXwt5gMSUUhsGw
         tbXhxgcDh+0iwp+6mjTfyYWQLY+TLGEDQgh0Er44v32Oc0K476+wGfKfL1iYfqpFwo+2
         YoOq1fWnce/2e0mAdiKStxX/Gu89o3uMsglh0cHneno1TjpDJYHP82IaI6Bsi62zt/t+
         b/seE7sMXjPelb4bFNgATpui8Nc44wNoXQ74D/tEsCYRgmTkA4w5gpAoYEJa2SLeA9B9
         FelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768916023; x=1769520823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Avajm5y4036daHiMDTtwCw98gx6dBRxK0z6ouokSi1g=;
        b=pANLwieTDpsfTmx75CUVSe2z8lCKipxbN/aID6j3DqfNUQpQZA87ktH/pcqz0eJFnI
         tQDD7u9g5RuWQ7GAwoxogrvwyjlMsQXfVCgNTqmdB1jTdxM1d1dwwjXQRrVzs/qD5Q+p
         xwvJJM4sb0avlWbq5AoJuw2rOD/bvsLAOo6R3hhBbO3BJcnWTyhLwpATnueyAoAMT6Uy
         2fns/rCb++Bn0Fzy390+G6QIcBkim1gyHa9TnBIAe4WX/bOGT1MP/79st2nDKFIaKS2v
         zPKqIqg+baTE+W3foqBnnPXiXD73GwmbL2BDKkUhUxVhHdvcwrhH6s5XH4dvE7+c9km/
         xcXw==
X-Forwarded-Encrypted: i=1; AJvYcCXKiHKVZkaxgk3v33hP0R+P90CpQhKM+pRvP7+Kkfn6JIew2uRTlgykMTqUX65tDMezxovM3+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0v5kGXHhhUu/KAWkrBRNN3CcodesY8zSPb1+YGskrPJloaPrD
	leOZGF6DWY/HKE6TpYO3z9vRMiVMzweNHoMn9Lu1RO9sbAWRUDDfrdBAVhDxX5yuEeg=
X-Gm-Gg: AZuq6aLlx+L3J7Ek6cTA1mQ3GNsnFh/KIiDNopS5bOAUSFMx4bSXGj0vT4Qgix4ExCr
	+ucivLnpdfgB6pE8ufgCy92b9+P3bFthH63so4VRgckzwPJFpgoHxGb52cbrJ3r0cWqHpCCNxmb
	WrWAaMqCmM6XAvC/UvO3bcj53dqfLfpbe+N1NBejnH+r4q9NYcFyQLOOWzYeOuf+W7+smE2/uwl
	0n127dynuX/3/8GXHvywoIHBcvWPt4P767KHcFx9PMWxkZvSZO5Fjl2djpatNJXXyJQzl29Buc9
	odAQ0mA6BiZaZRe5t0A/4wMejBPDZvnSEzsQZ0T06X+7JfPl6BkZHxApMIdzDsOXH/b7Vv8Df1R
	DSsKg8W0kslDi4rm5kPn411gO0ebyh/aeSfqoqrWKlN9BsREbKR+Oj2DcPU2kCn/fzzQXoYC1YR
	0DR7lorjd1gDKbzPJLY6sDeEwAKEVnDDrw6B7+r5Y=
X-Received: by 2002:a05:6000:1817:b0:435:9144:13fe with SMTP id ffacd0b85a97d-435914414e8mr1903692f8f.26.1768916022893;
        Tue, 20 Jan 2026 05:33:42 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996dad0sm29331439f8f.27.2026.01.20.05.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 05:33:42 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	geert+renesas@glider.be,
	biju.das.jz@bp.renesas.com,
	fabrizio.castro.jz@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v8 2/8] dmaengine: sh: rz-dmac: Move CHCTRL updates under spinlock
Date: Tue, 20 Jan 2026 15:33:24 +0200
Message-ID: <20260120133330.3738850-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120133330.3738850-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260120133330.3738850-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210549-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,stable@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,tuxon.dev:dkim]
X-Rspamd-Queue-Id: 3A16746702
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Both rz_dmac_disable_hw() and rz_dmac_irq_handle_channel() update the
CHCTRL register. To avoid concurrency issues when configuring
functionalities exposed by this registers, take the virtual channel lock.
All other CHCTRL updates were already protected by the same lock.

Previously, rz_dmac_disable_hw() disabled and re-enabled local IRQs, before
accessing CHCTRL registers but this does not ensure race-free access.
Remove the local IRQ disable/enable code as well.

Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
Cc: stable@vger.kernel.org
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v8:
- none

Changes in v7:
- collected tags

Changes in v6:
- update patch title and description
- in rz_dmac_irq_handle_channel() lock only around the
  updates for the error path and continued using the vc lock
  as this is the error path and the channel will anyway be
  stopped; this avoids updating the code with another lock
  as it was suggested in the review process of v5 and the code
  remain simpler for a fix, w/o any impact on performance

Changes in v5:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 36f5fc80a17a..c0f1e77996bd 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -304,13 +304,10 @@ static void rz_dmac_disable_hw(struct rz_dmac_chan *channel)
 {
 	struct dma_chan *chan = &channel->vc.chan;
 	struct rz_dmac *dmac = to_rz_dmac(chan->device);
-	unsigned long flags;
 
 	dev_dbg(dmac->dev, "%s channel %d\n", __func__, channel->index);
 
-	local_irq_save(flags);
 	rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
-	local_irq_restore(flags);
 }
 
 static void rz_dmac_set_dmars_register(struct rz_dmac *dmac, int nr, u32 dmars)
@@ -574,8 +571,8 @@ static int rz_dmac_terminate_all(struct dma_chan *chan)
 	unsigned int i;
 	LIST_HEAD(head);
 
-	rz_dmac_disable_hw(channel);
 	spin_lock_irqsave(&channel->vc.lock, flags);
+	rz_dmac_disable_hw(channel);
 	for (i = 0; i < DMAC_NR_LMDESC; i++)
 		lmdesc[i].header = 0;
 
@@ -706,7 +703,9 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
 	if (chstat & CHSTAT_ER) {
 		dev_err(dmac->dev, "DMAC err CHSTAT_%d = %08X\n",
 			channel->index, chstat);
-		rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
+
+		scoped_guard(spinlock_irqsave, &channel->vc.lock)
+			rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
 		goto done;
 	}
 
-- 
2.43.0


