Return-Path: <stable+bounces-217592-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOvrMpe5mGkdLgMAu9opvQ
	(envelope-from <stable+bounces-217592-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 20:44:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B64216A698
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 20:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED0F4301AB9B
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 19:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A50366DC4;
	Fri, 20 Feb 2026 19:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jxy5J+rF"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD1436680D
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 19:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771616656; cv=none; b=Djptqfi3EdAPaHZDMl1axtajabaN2oxuvOoEF6a3r/ShOs1L+g295Kf7OfKcNdB2T7+95H2w0NqEaSCjYTQwKtB3kw1KtWxeWp4WYt0DWZ5cx1MLB72JaX+CY9praZVvvejOM2Ns8G3Y9YqQ/WVbDLMl1KAg7fQLaQbrb6l8/ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771616656; c=relaxed/simple;
	bh=HZw/m+iZYxEGcuIZeLOrzXaThPDTnv+UpkVRVzMpSOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JDk/+D2+cj2topjrLYhwrSF9ByAOY4kxI5JlzyhLO9j0DYTWwW2G+JtIaif/jouETqguU03kSAVQILXWF91KQofwQxYrZ2Cq6EaK3FhIZr3ViQMSetKY1av1VYr0DiZaeEUHwTohx8SZDk9yTphBAjdSsxbAsNE79QJCE/ttpgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=jxy5J+rF; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48329eb96a7so14628665e9.3
        for <stable@vger.kernel.org>; Fri, 20 Feb 2026 11:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1771616654; x=1772221454; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=exW6wJ5MettYqKMw45/sBx+PnMDuRihL33c51S/rlCU=;
        b=jxy5J+rFq7uBZmpuei0xJfpmLSegTmO1bDaZ++JM6GEBESlZihdvT6BZgks2xciM60
         FVtpbi7fwg+Ncw9hSP3sqmFyiQ3U5R1/P3tiaEqyuXnS/WmbftX9CS5Kxi9ECE3F0da7
         +6pL0MKsFSGLtNEZ1fNT3TK989sGwlH5tle853DDmadGIiKXqzLLyUGjD6kyODFPNwJA
         i26vh91rTYushN79utjUruy8//KQ0TSDVXRJDUoH10eAvw4jYvDwzSIXyDpcKL6+dEh9
         x5LhpL2mOzyOmVyyxnLOoSCmw97qRAblayTGvLDMI7afSmX9kOtAAglFUIaVBlL9YRQd
         Ww0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771616654; x=1772221454;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=exW6wJ5MettYqKMw45/sBx+PnMDuRihL33c51S/rlCU=;
        b=ZXw0kIFlTG7mJ8niIQpqtmBfH7rqJhPd5QjE511OAcSK1RDAUkFt9JaTPqZ/NHs7Ob
         q93uk2Xy1cpcsXlCo/yZ1HPPqhippg3duV5oTHPIJftPZCT9+HfQvZ1FdjIvjdYITfAf
         NhXrWCgajYF/WWHFnId4cwkj5pcrrzqgvldsouO+FMbAn7mLvQEy7raigUYhUCteWDbQ
         wn3mtMv36A0wOp1oIrI1AK+D8mFkvhVFrASUdhOhq8stjJeKInChmBU0HhZHNLnwCoWS
         xfkuyYcApVViPLoKPNbX9fToenlhwu4XjWHxtkhhoI+XYIM5SeUW/VDMBmZGbVWr+9rM
         b1TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgqHnVtyCCRuoZaR1SToLtuBAxNQb7mIZuXhrtgt7edZUChwo5ogaSiEe+HQbi/5CCMdrjTkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YycZE5uKdbRjg9wu8GNneYnmkHlrtApZpLM3z6I5jp7P9JismTC
	MAnHBQnmQMkrlMZ90DKdLOgVv0EGElShvWAnR/L2ZqpWVRUvtKB5jotz2mwAlW4JTlg=
X-Gm-Gg: AZuq6aJKOPD5m+lrq+hm/agVMiBcs1lZ+oBQWNsdX8fjvvrv5C2LnPGGT+wo9MRJ2Ns
	Gq6fYMEdelSmOQA+z9gn1y3IPVdjGUVh3LNwckJjKxbR8Mzsudbit8F9Gd+vJk07TJGHWN7zXy9
	wSEoSTLdlE0tdMjQ+z1/VemragDB+gVfpXAR+jkEGVyeFpRXUTbBVxeBy/vJLwJQxMX9jH7tR6v
	KK7JnoDAj077k/kY6dtLiv3XEyh7AkFZ3nWCObvIfIzTmxfT94nXUggQIXKYa5m9pnjjkZWXctj
	+haQ9uoSk1wJN8bXduoWrL6nCWvperS01k2IDOiN1Gl5+vme05gDG5dT6wbTHY2VPz1Fe1p63Et
	JTXlrCBd2YiIDLAZ6de26JTJu2ErYx36waDCqDhsN7n7A9vwkzVXfJBdZWPtzZQMifsC+UCk8Ja
	kOScv53TC8h6ycwYnYPfrSAC8IMBYkzzg=
X-Received: by 2002:a05:600c:46c9:b0:483:6f37:1b51 with SMTP id 5b1f17b1804b1-483a95ea9c9mr9114085e9.23.1771616653836;
        Fri, 20 Feb 2026 11:44:13 -0800 (PST)
Received: from [127.0.1.1] ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a3e1b7ccsm24460755e9.11.2026.02.20.11.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 11:44:13 -0800 (PST)
From: Max Hsu <max.hsu@sifive.com>
Date: Sat, 21 Feb 2026 03:43:54 +0800
Subject: [PATCH 2/5] dmaengine: sf-pdma: fix race between done and error
 interrupts
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260221-pdma-v1-2-838d929c2326@sifive.com>
References: <20260221-pdma-v1-0-838d929c2326@sifive.com>
In-Reply-To: <20260221-pdma-v1-0-838d929c2326@sifive.com>
To: Paul Walmsley <pjw@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, Green Wan <green.wan@sifive.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Palmer Debbelt <palmer@sifive.com>, 
 Conor Dooley <conor@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
 devicetree@vger.kernel.org, Max Hsu <max.hsu@sifive.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2398; i=max.hsu@sifive.com;
 h=from:subject:message-id; bh=HZw/m+iZYxEGcuIZeLOrzXaThPDTnv+UpkVRVzMpSOI=;
 b=owEB7QES/pANAwAKAdID/Z0HeUC9AcsmYgBpmLl71dxWi5B+zksLXjlly23frduiErFqlc8fz
 Z/otqlEM4iJAbMEAAEKAB0WIQTqXmcbOhS2KZE9X2jSA/2dB3lAvQUCaZi5ewAKCRDSA/2dB3lA
 vcuoDACgaeWfX7TSgRc1yNCZNUpKCUjEzSewb3vD7LvYIUVNGUfInacZIz+DBH6FaLxFB9wtTAQ
 J7hyWDGbq5fOphtYG/+4mE1K4SYEXr7LLG3QI5plJqhkgVzy+NA+JNUKWt7z5Nc/70t5KXh8KlC
 cjjhkknMwzd+BtXvy30eiEvVSqmaeyy/8UIDqAT/4/pwDmCkAaV1EcWgzyK4LdRlHHE99mNiKo+
 n015Nh6m2BWRuSkkm1MYESTug3DX3WC6/ByMs28nGKB/DxyKtrAtMT6Mk+tQWuvPIPvxHnpo3K7
 avJD/L46htLvCT+z8SyM6kU1J+V2zChbhqoEA/K3aJ6uMaI2AcAYuTFj5kkPJtoepUMvRQusLap
 RAJJT6K8glfyHNIGLIfhWibLjyIkXfOxNEM0a2xoRjY2Ko/Ri9BxAbGjt/4kz0IA8h5UKMXZ0xu
 +nDU6BCnE4e7YBBie6Zj/Bpg57kOAiQ/3C9GLsC7Uj4B0Ennz3k7dOUaZugVOuQEE/n3s=
X-Developer-Key: i=max.hsu@sifive.com; a=openpgp;
 fpr=EA5E671B3A14B629913D5F68D203FD9D077940BD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sifive.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sifive.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217592-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[sifive.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[max.hsu@sifive.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sifive.com:mid,sifive.com:dkim,sifive.com:url,sifive.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B64216A698
X-Rspamd-Action: no action

According to the FU540-C000 v1p5 [1] and FU740-C000 v1p7 [2] specs,
when a DMA transaction error occurs, the hardware sets both the
DONE and ERROR interrupt bits simultaneously.
On SMP systems, this can cause the done_isr and err_isr to execute
concurrently on different CPUs, leading to race conditions and
NULL pointer dereferences.

Fix by:
- In done_isr: abort if ERROR bit is set or DONE bit was already cleared
- In err_isr: clear both DONE and ERROR bits to prevent done_isr from
  processing the same transaction

Link: https://www.sifive.com/document-file/freedom-u540-c000-manual [1]
Link: https://www.sifive.com/document-file/freedom-u740-c000-manual [2]
Fixes: 6973886ad58e ("dmaengine: sf-pdma: add platform DMA support for HiFive Unleashed A00")
Cc: stable@vger.kernel.org
Signed-off-by: Max Hsu <max.hsu@sifive.com>
---
 drivers/dma/sf-pdma/sf-pdma.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index 7ad3c29be146..ac7d3b127a24 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -346,9 +346,25 @@ static irqreturn_t sf_pdma_done_isr(int irq, void *dev_id)
 	struct sf_pdma_chan *chan = dev_id;
 	struct pdma_regs *regs = &chan->regs;
 	u64 residue;
+	u32 control_reg;
 
 	spin_lock(&chan->vchan.lock);
-	writel((readl(regs->ctrl)) & ~PDMA_DONE_STATUS_MASK, regs->ctrl);
+	control_reg = readl(regs->ctrl);
+	if (control_reg & PDMA_ERR_STATUS_MASK) {
+		spin_unlock(&chan->vchan.lock);
+		return IRQ_HANDLED;
+	}
+
+	/*
+	 * Check if DONE bit is still set. If not, the error ISR on another
+	 * CPU has already cleared it, so abort to avoid double-processing.
+	 */
+	if (!(control_reg & PDMA_DONE_STATUS_MASK)) {
+		spin_unlock(&chan->vchan.lock);
+		return IRQ_HANDLED;
+	}
+
+	writel((control_reg & ~PDMA_DONE_STATUS_MASK), regs->ctrl);
 	residue = readq(regs->residue);
 
 	if (!residue) {
@@ -375,7 +391,7 @@ static irqreturn_t sf_pdma_err_isr(int irq, void *dev_id)
 	struct pdma_regs *regs = &chan->regs;
 
 	spin_lock(&chan->lock);
-	writel((readl(regs->ctrl)) & ~PDMA_ERR_STATUS_MASK, regs->ctrl);
+	writel((readl(regs->ctrl)) & ~(PDMA_DONE_STATUS_MASK | PDMA_ERR_STATUS_MASK), regs->ctrl);
 	spin_unlock(&chan->lock);
 
 	tasklet_schedule(&chan->err_tasklet);

-- 
2.43.0


