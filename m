Return-Path: <stable+bounces-235714-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLD1Hvgz2mlqzAgAu9opvQ
	(envelope-from <stable+bounces-235714-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 13:43:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0106A3DF8A8
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 13:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33A3C3036E98
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 11:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D4B345753;
	Sat, 11 Apr 2026 11:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="j7fp2xD1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF6B343208
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 11:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775907794; cv=none; b=JbB5B658dR+L+NNgbGn+gCY37En+Lev9anccL/4Q1/HpSkCOFA6WYuHtyUx5YpdILtTOVvfpeNBOrp4lYUPTKJRH6jUyuFBWLlXSF9FK0yiK5k+SJVi5RvbTvKXQLgPbJKJ8+ioitpLRijp4fcmTMFIoQDgtbEOOJrLFixiwU1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775907794; c=relaxed/simple;
	bh=QGre1JnMJ7EtNooAlP++jw+4gePWfV/O1V/jrTmI22o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Td0Y+zobn+ZYFcVFPkytnY6mGKyYqK3zKyko+bybTA8oAYeo76Cv/pEjfa2roWcxvUJZUySOkB4L8QW8nFwRvtQ8SoCCPQIqcPC9DwCEwhR8Ql9hoJytPdQ6S3MCilkLgEx2GZkKKgArDpI4ay96rgCfMsKVHb9ep21jLjtclcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=j7fp2xD1; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43cfd1f9fd1so1848461f8f.3
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 04:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775907791; x=1776512591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7WML25G5xFq4y3e3IxD4yNlbeDhj8/OemWvzra0+LM=;
        b=j7fp2xD1T53W9ogUMGE9CsyEh2Wvxa5BEDuORsSFSZdijZ4g9e3Y6tM9UpNwqdRhXc
         wb8pUBCjZ+W1hRnsc5iPYBifIdr4uQd5oI5e2qsE48QDHcbBF9ppmv9P77RBPogGpCtC
         ePqFmRpxHR1Om+dU0XS90aBGf0MU17PQ4V1FuGoNtYud1FiVDaPt2A368+OnEvkILUe6
         WhTQrRV5zSNNq6N0QWIe3ulOttp3miqRRsSodLqvQn2O5Wbzt0qPJDq55Qf2bnOZhz1E
         D/kaeS4bcssqYB/l1lpJFlhY+iI3+ca+EPPfY2XLgukpciKYKTmHfigIZXSRFu6qBY/9
         7FAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775907791; x=1776512591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R7WML25G5xFq4y3e3IxD4yNlbeDhj8/OemWvzra0+LM=;
        b=mbu9HD75arjh6ZI/hcgCMsNYyUL+WlvlkfYmk1Rm1adT3184AZMdvnlXHZaJkAv89i
         4J/r2UQzzhh3BwSvymoGes0BOO0HsLQ/qkXQzNewsl883aN4VDZMiqExBqjwZR0YFZjS
         3I2KYda0sr+TKn0mNQzcWvcsyiuCmv7j660a++9zvZ7hrrSqRB5onIAvrlPkVOL/Fh3h
         ebWfyDYytmr8k+r3lqTyNjqnRdaCvJSBQ5hO97deNIjM16GWj8b2qobT/htANPYm8xzS
         CQjDuuuiOFT/JoWDOHXMJtwYfMcXqWjMsFuiyHwAkM9iFWEuewSa5bCWkzDDKBzeLFM8
         0N6A==
X-Forwarded-Encrypted: i=1; AJvYcCX4IG4i8GQ6iTWsui08ohTZFcd/cSMWGGsdfrE9MFd7+GeQdKo7TJ4nqhO1CJ4nwNNmNnNGHBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDy+bH+aycjymUJVB4uSpBvQUIFayixX3a1A/4pmjmHvfo8A7d
	C8tEIK5vS5Ug7fXgLGwIXbacTAaFCiybE5cazdWAdSEZK1E9nmcmxzFpLlF8ubgY7Nk=
X-Gm-Gg: AeBDietBlCUw9KViBJ2SldCCvYlLANE+uI/3hZHnXvAAxQAtoSyY+JvgCNp5JVY/KWl
	vT0R0HbRMhsMnYYCneSy6P07cW6pBNu6vY6oiNjJxGeqVSiRM3AFcpdV0H9/Gt2LRewgp/e9yOo
	/P+y5kSUvmcFra0CfIh4PbHK1Qz1Gnj6suAaXcGidtaUEFZfU6/89MG3NBobYHkFKOFeiFzja/I
	0056QBxz95kXFMuLtntFim2EJnptjRA5q8WFl7e9pOzHxkHIEJYhfeinzGVJ4HkcrnEYrjDbpR2
	JSrM/SzpWtZPeF9iQqQAf6RbtWBAH2WJDEaG9JjRa0CHiNTpxADPntwuZpZIVCOfmBGF85FoBmH
	CwRLpsHneJeF52+9Y846QgJubfmv3HUcEWCX6cCOPJwIeyh/WjYcQFiMNVwwkQnCdi1AoDp+LVm
	PESCKRBLMymxodjpKieuNFtLXyElfGph+3WeomhSNX6HmP+dFB1WMw
X-Received: by 2002:a05:6000:2886:b0:43b:4982:fc73 with SMTP id ffacd0b85a97d-43d642c77cemr9629206f8f.25.1775907791508;
        Sat, 11 Apr 2026 04:43:11 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c981sm15776447f8f.33.2026.04.11.04.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 04:43:11 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	Frank.Li@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	fabrizio.castro.jz@renesas.com,
	long.luu.ur@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 02/17] dmaengine: sh: rz-dmac: Fix incorrect NULL check on list_first_entry()
Date: Sat, 11 Apr 2026 14:42:48 +0300
Message-ID: <20260411114303.2814115-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260411114303.2814115-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260411114303.2814115-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235714-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bp.renesas.com:mid]
X-Rspamd-Queue-Id: 0106A3DF8A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The list passed as argument to list_first_entry() is expected to be not
empty. Use list_first_entry_or_null() to avoid dereferencing invalid
memory.

Fixes: 21323b118c16 ("dmaengine: sh: rz-dmac: Add device_tx_status() callback")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 9f206a33dcc6..6d80cb668957 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -723,8 +723,8 @@ static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan *channel,
 	u32 crla, crtb, i;
 
 	/* Get current processing virtual descriptor */
-	current_desc = list_first_entry(&channel->ld_active,
-					struct rz_dmac_desc, node);
+	current_desc = list_first_entry_or_null(&channel->ld_active,
+						struct rz_dmac_desc, node);
 	if (!current_desc)
 		return 0;
 
-- 
2.43.0


