Return-Path: <stable+bounces-257436-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHZJB/EbG2pk/QgAu9opvQ
	(envelope-from <stable+bounces-257436-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:18:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 925B260F5C0
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EB223012C6D
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BBE34165B;
	Sat, 30 May 2026 17:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KqbrJsfb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B263148DA;
	Sat, 30 May 2026 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160990; cv=none; b=ZKfQB4Yc99jpisVf1GzhgOPdxM9lgBriYlVF/nmAO6Srlyyi5rrmVnp8VPt7G0THqguLvcoiJC6vKUdeoSJ6NPLQSE7jKFDn6lUXIvuxzFIU4WiTX6WMIZdmGcfi7kBAimjgbLu9khjibldSkGJlIIUGXti8U/9VKfNFqhGTXnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160990; c=relaxed/simple;
	bh=Nv7l32NXuXpCZEd3H78D7ogcGYkv9DGgnc9ylgRg1kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G3g0s7+GS2XIsiPOOrsTM6smvZoz2gyVD7afwx+SgHL0qM1p9o5knMspcwgA/gH83fxQdM/sr8yC63uiEFZgOKbJ4D8diJxiKddlr2BxyK/kcLWOkZrq2azx8pduW1n8a1mq4QSOY6bvfGMRw1QA1kQ+b6AMVMnateJ7v5PBkjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KqbrJsfb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1291F00893;
	Sat, 30 May 2026 17:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780160989;
	bh=UOA+hDUY9ePQKqzzfW20QnZ3DtXTQzYJbS7V4c8zQd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KqbrJsfbJXodVKfggnkt8vHbHGdKPXTQ2MMn/1qq2VicUpmPr1qOx/OSfHaSr2TZE
	 7tlt5Ktn/h0xDOwf9bP6JDYX0b2do/M+HXJh01GUOv6iuJxla5j1qZJGh9ytQSYxJU
	 deWAJoj9sc9mLrqDZ5FXF+kAUajrSd6ucMcGwgnA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sander Vanheule <sander@svanheule.net>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 493/969] ASoC: sti: Return errors from regmap_field_alloc()
Date: Sat, 30 May 2026 18:00:17 +0200
Message-ID: <20260530160313.931764219@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257436-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 925B260F5C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sander Vanheule <sander@svanheule.net>

[ Upstream commit 272aabef50bc3fe58edd26de000f4cdd41bdbe60 ]

When regmap_field_alloc() fails, it can return an error. Specifically,
it will return PTR_ERR(-ENOMEM) when the allocation returns a NULL
pointer. The code then uses these allocations with a simple NULL check:

    if (player->clk_sel) {
        // May dereference invalid pointer (-ENOMEM)
        err = regmap_field_write(player->clk_sel, ...);
    }

Ensure initialization fails by forwarding the errors from
regmap_field_alloc(), thus avoiding the use of the invalid pointers.

Fixes: 76c2145ded6b ("ASoC: sti: Add CPU DAI driver for playback")
Signed-off-by: Sander Vanheule <sander@svanheule.net>
Link: https://patch.msgid.link/20260220152634.480766-2-sander@svanheule.net
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sti/uniperif_player.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index dd9013c476649..e5c4e5245b255 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -1029,7 +1029,12 @@ static int uni_player_parse_dt_audio_glue(struct platform_device *pdev,
 	}
 
 	player->clk_sel = regmap_field_alloc(regmap, regfield[0]);
+	if (IS_ERR(player->clk_sel))
+		return PTR_ERR(player->clk_sel);
+
 	player->valid_sel = regmap_field_alloc(regmap, regfield[1]);
+	if (IS_ERR(player->valid_sel))
+		return PTR_ERR(player->valid_sel);
 
 	return 0;
 }
-- 
2.53.0




