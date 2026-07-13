Return-Path: <stable+bounces-273703-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hCwCNFHjVGoUggAAu9opvQ
	(envelope-from <stable+bounces-273703-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 15:08:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FB574B50D
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 15:08:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tuxon.dev header.s=google header.b=EM5whsZz;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273703-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-273703-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 50158304C84B
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 13:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CE14189CE;
	Mon, 13 Jul 2026 13:06:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0604189B4
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:05:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783947961; cv=none; b=Wo3/wpzSUBPrFjBPEpHwvVXOLatibuaYDvCBGK4VeDoy45zDAna1o4u6ZgEFDUAqAb7PT51PFEIk4iXqrWoqpWpgo84NDmwqYxBN3I+M+EWsOgK7kvdLcD7Qb8955K7ulEBLhlBGHloQeiIVlenjACiM7XBI7qDkGUHikEp20yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783947961; c=relaxed/simple;
	bh=P6aF/BzzUSeDLiv0rHRqB287uvz592GL/Gcl7iDIHpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HFx8/J/OsltAK5SKZKH3tW4gdpoueGeLqjocpL4IBKFbJTkrEan8NBHl8rXE9YBGfoRxJWLTFi0MbfwA7ZLvw2Xp6K6muuY85jzlDf44XmQpEYDxAsJMFXFHBVCKISOKAJPpFqTHpgYw3iYtEcJ08qTneV3TLbtiBwpnOEAIeeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=EM5whsZz; arc=none smtp.client-ip=209.85.221.54
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-474560436c3so2393847f8f.0
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 06:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1783947958; x=1784552758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OAq3iUlWeKBxi9BzVp2LKHNg5+ivMc/cKZSPqbSeCas=;
        b=EM5whsZz3dG6kBBlgx903lUYLl7DcMbcZFFI39sBBEfqx+ZfK3WxpRhDaxcxF50CfZ
         aOTDATVfViHvCMQOv50h2B3f7hIJjFqlpm5jtl1XJMgYtAN1RH+dPALmsCStkTvdGnAq
         g1GnIXahKJNQwx4h9iukgzcJB9DLpKqs76UKg5PNr9ssQl+1PZwwy6Mo2Hc7414r+jtN
         UFiPZzku2zIJX1A35ka51OUPVNN0uY/yCdpg6ybdk6Nk1PvxlMPY86X4doK8PbGb9z5r
         IgoOSgxt1GAYw8pyJ6aLUbBoI/dZgkx0Gu/2HtvCsfNEGE6HSc/6b7Kahri5CurKs0tK
         AOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783947958; x=1784552758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OAq3iUlWeKBxi9BzVp2LKHNg5+ivMc/cKZSPqbSeCas=;
        b=aAlL19gArG9a9uZkrJ1kdLhJWztz3Iel1fvamMJLRsGhFJKGNc+yJK3WZ9hMMs6u+U
         XPovmbcKK0lZtZ5hBmUWOinADo5vJ3CTd4xLq+rOkl7xO86kNcpVnXRQgSYGc3ruDKaB
         XMrOjqueyuJu0g3kOCO9GS8nnSo6KiewkM3vMy0Dvu8ekQNbXEx8iS9cUsXbZdx0tPZ+
         T4BdRRal+8YKD7FszQ2eyIb7DFDeDOPutRL2GaZl51oCoTGIbHT6b3Ft6rlzFRYsnVKM
         TLD6Xm4GLHmF3NZIOPD2kDsFPRDqaq1w0qeXe36yjV0nPJRHLG3JdXdSHDF73SjWersB
         6YHA==
X-Forwarded-Encrypted: i=1; AHgh+RpwSKJ7cTMD95M5cDhCCQLlCsBsSa5d3XlpFHfZjAC1DqU2ecevat/bs6wyEHSBczFoGrM1ZV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxlV8RqChjL10UC9aGY3GIelkT9M7Db+1rfFTc58fBCXTDYrNL
	mQjQEbyaFaoqJ1/aeoCRTmS/x5vbGEUBvxotox4CJqstgfuAsmZs7Sbz+NV1tOpzAsQ=
X-Gm-Gg: AfdE7cm2xs/ab9/xPrXEavIefSYDabv/KY/C3umjSFWskRkXA1kdvGxqXuyxgvf7sI3
	NXH0V3j4MZCjWxFwj1pVQVjS7DBYn8LJChFEdwWhgK/rpyxWiKQUQEtjhe8oj5hHrWVGQh1qTjG
	45pMk6D7Wb2+HcTp8u79bn9tDjbSUOndkCL+Y2imE20mi6NgLBM4AgkOQ5jgMB95g6qyAdM/LdQ
	dSXq6e0QM8BLrQtOFAb1Bk9YFXp7rjNf9HZ25i60yW2JjB8ijn3pu/LDWhhNR/I1t3oljThLY2F
	R6QtoDimZ6rXmSA70k6jlYZiNO6E1VlpmNBv+JhEVohHjghr5dA4lO3MTa7F/4wPK03gvfEU4lr
	XZoQubhoGqNmndkJ3fVa+SLkxESi2gy4yHefEZYO34+fmXrG3vWBuQulosPWQx0JdQM0kbD2ild
	YxF329QPauciHfxPgn2SMoedgeOKUdOol/8ijtoheh/D70oCfx2VUHoDbe+1hkh0zVNz5QXNb7h
	ai/KekF7Q==
X-Received: by 2002:a05:6000:2510:b0:473:1ccc:15c9 with SMTP id ffacd0b85a97d-47f2dd04861mr10170497f8f.40.1783947958166;
        Mon, 13 Jul 2026 06:05:58 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6402:500:e91e:fe5e:857b:d0c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f273195d9sm25321609f8f.3.2026.07.13.06.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:05:57 -0700 (PDT)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
To: wsa+renesas@sang-engineering.com,
	tommaso.merciai.xr@bp.renesas.com,
	alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 05/17] i3c: renesas: Reset the controller on resume
Date: Mon, 13 Jul 2026 16:05:33 +0300
Message-ID: <20260713130545.568657-6-claudiu.beznea+renesas@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713130545.568657-1-claudiu.beznea+renesas@tuxon.dev>
References: <20260713130545.568657-1-claudiu.beznea+renesas@tuxon.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-273703-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:wsa+renesas@sang-engineering.com,m:tommaso.merciai.xr@bp.renesas.com,m:alexandre.belloni@bootlin.com,m:Frank.Li@nxp.com,m:p.zabel@pengutronix.de,m:claudiu.beznea@tuxon.dev,m:linux-i3c@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-renesas-soc@vger.kernel.org,m:claudiu.beznea.uj@bp.renesas.com,m:stable@vger.kernel.org,m:wsa@sang-engineering.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[claudiu.beznea@tuxon.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[tuxon.dev];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,stable@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tuxon.dev:from_mime,tuxon.dev:dkim,tuxon.dev:mid,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A1FB574B50D

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reset the controller on resume after enabling the clocks to follow the
same sequence as in probe and avoid potential ordering related failures.

With it, renesas_i3c_reset() was updated to use read_poll_timeout_atomic(),
as the driver's resume callback is executed during the noirq phase of
resume, where interrupts are disabled.

Fixes: e7218986319b ("i3c: renesas: Add suspend/resume support")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- none

Changes in v4:
- none

Changes in v3:
- collected tags

Changes in v2:
- replaced the read_poll_timeout() in renesas_i3c_reset() with
  read_poll_timeout_atomic() as the renesas_i3c_reset() is called
  in noirq phase of the suspend/resume; updated the patch description
  to reflect that
- collected Frank's tag. Frank, please let me know if this should be
  dropped. Thanks!

 drivers/i3c/master/renesas-i3c.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-i3c.c
index 517ac2df9bd4..6590da962592 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -495,8 +495,8 @@ static int renesas_i3c_reset(struct renesas_i3c *i3c)
 	renesas_writel(i3c->regs, BCTL, 0);
 	renesas_set_bit(i3c->regs, RSTCTL, RSTCTL_RI3CRST);
 
-	return read_poll_timeout(renesas_readl, val, !(val & RSTCTL_RI3CRST),
-				 0, 1000, false, i3c->regs, RSTCTL);
+	return read_poll_timeout_atomic(renesas_readl, val, !(val & RSTCTL_RI3CRST),
+					0, 1000, false, i3c->regs, RSTCTL);
 }
 
 static void renesas_i3c_hw_init(struct renesas_i3c *i3c)
@@ -1483,6 +1483,10 @@ static int renesas_i3c_resume_noirq(struct device *dev)
 	if (ret)
 		goto err_presetn;
 
+	ret = renesas_i3c_reset(i3c);
+	if (ret)
+		goto err_clks_disable;
+
 	/* Re-store I3C registers value. */
 	renesas_writel(i3c->regs, STDBR, i3c->i3c_STDBR);
 	renesas_writel(i3c->regs, EXTBR, i3c->extbr);
@@ -1502,6 +1506,8 @@ static int renesas_i3c_resume_noirq(struct device *dev)
 
 	return 0;
 
+err_clks_disable:
+	clk_bulk_disable(i3c->num_clks, i3c->clks);
 err_presetn:
 	reset_control_assert(i3c->presetn);
 err_tresetn:
-- 
2.43.0


