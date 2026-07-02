Return-Path: <stable+bounces-270384-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7InkK/c/RmopMwsAu9opvQ
	(envelope-from <stable+bounces-270384-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 12:39:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5936F60AE
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 12:39:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=bJuk5bHy;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270384-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270384-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B902A31447C3
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 09:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECD347AF71;
	Thu,  2 Jul 2026 09:25:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6326F40D590
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 09:25:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782984344; cv=none; b=QuW4XZPgnmAdq33WqbMsco3FH+cK+lJ8h/P/4Bc5gUq+uZLotREfs4GA74ErVdMc6mfkgo2REmyG5lYSkGwFCYJabBh9+oH4wAPjQHnBOEH7lun67YZIHybKJD7H3tRsjjdICKfk64+TvC4e33nmKHZR9xGhl4gZYByM6WmNCB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782984344; c=relaxed/simple;
	bh=bxHfofVftas0nDT0dCU01gYtETbVotYMlAQeU6wjcUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oZaVNqwTvbof+Y6lEEHhX9JgRlSxokkOc7g6bX4NbQZ9BoIkFMTj0pc5pryGbXgFFidlk5y+crt2GODxSYdqvHbkhZfd4y/LHrSacgdOdYJzmSKET0yzskqtYHr/Nv6cUuatYyc+g5Pcdu7aORREXSA5mTrCJ/lCExCymBge9iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJuk5bHy; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493ae59eca6so10822185e9.1
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 02:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782984342; x=1783589142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IAf0SbLKbze84BZy2kaqNnSUiZel7JKCETRGPOgpKO4=;
        b=bJuk5bHyE5LBKEJ5Ipm2l3dm/5blYLy1+GuT7HWgE2YcKUxIHjHItK2qjvjhuLpxnt
         jgnEGlQLuRINv6OjoKVHkDlCILn6xFkFKu53FKIkCFJeHmjijogbCA2iUeVQxvDlMHMT
         hjCSGNGI1PBiH9drt3QPbCpkkMLgfPL24aVmpuAMNxiz1tUmI22CnB4qnFhAK55xjuTJ
         0cAMDet9SsSwJ6oWTNpFenVrmxDWTnWJGv20ew0RGH6ZQe/yklEqw2/HfGSTg2uljOpt
         ygL5HjW/Eh89BWWnN2zYufZG+xnwEkfKi2dAFq0SW4NQ2EZNbfnrspFyxNLtjX4ahTJx
         oa8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782984342; x=1783589142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAf0SbLKbze84BZy2kaqNnSUiZel7JKCETRGPOgpKO4=;
        b=rD7OGV3FT/xrvGJaBfh7NNGxCbv2XXO1YMFm6CkRFYDz6g1YvYaAlRj4xNB80K62c6
         tACGwL+luo5Vw3EYjoiypsTmkUK5WS++RhEpc88mg+BJszS1625DgZ8GrE41pIET+Xmk
         JrkS59G/R9xchu3lPTGpMB5kA4tKoPsVE1FB2fYp14zCJUs8+AauIKChoassDQy1WXhw
         lVEIIzjSsoSpvkBpyLelc0Mf/9h0BNnPIdnkr9LMks2PIu5pVtsMy239VPkvldsyHV3l
         aFdhFcngIfWTx5Lqlfgue+7wCC95vkJCpkLySERfUvmYKjBXIxStNTUTLF6/47lQsPm2
         9vHA==
X-Forwarded-Encrypted: i=1; AFNElJ8Niv8ZrzaPxda7I9VG6B5/vCrk5U1Qwbon55j4aCc74YV+MX92Q+5DGSdTc3dswb2vboTeT1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsgCPVqdT7m8X9M5UnXkHqUcL+eyCPtPGHFuaaAI+9z2CdmvVo
	BBXDJgD7gVRumXrcW7x0ANlsakjMFzq1eMulwUlDSfixRfg09TQ78PGk
X-Gm-Gg: AfdE7cmyGmhlzZrq7ONT0tYFWUpR00rfC5JwT57RASSroT1PNDjVTXSIwIR0dKHAq1a
	vHra/0E0A4RMXcDZ6pLzyXltmcT/5Zgstr6Ua12NZlLxBmwT2LgAa56btulnB3QqNzgnBf3TN65
	IhSQ0OApUTPKCtq34V4vVw4MmqcC1VcKD/iWYERNWFK9TgPjtz4NwQS0jo+TtIu8vaf/P6ABIFw
	eLCJP9cBG89TtJljP8RNiOGaXyUp+0rJMP6Uk/mRcdLD+jrar4bRumB8YJqAEVOUuLo13GXSsPT
	G8R7ch22rHNW10yKAHzwqxH7PBMM3pKZLyLwb8P54aEekkyE8o1RXYrGon7bAVvRx6RD2meOYtg
	qwvSbyyN7fo1xPg85zbQ+NuAF1rXJLS43UGa8WI9ohxl+P+TnwOQG1SbcjfAYi2dcp2E52Nw8+5
	1Xjbrmne6lO6MWBkz6q3ykvXOpypW66MWf92b6phnft4dO8AgxfmbhWEk/HNuiPfyGILHWZVTGg
	5QJk+8at+k=
X-Received: by 2002:a05:600c:154f:b0:493:bd4f:510 with SMTP id 5b1f17b1804b1-493c3cf45d2mr58466845e9.19.1782984341599;
        Thu, 02 Jul 2026 02:25:41 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c6381e4fsm38312815e9.8.2026.07.02.02.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 02:25:41 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: linux-media@vger.kernel.org
Cc: jacopo.mondi@ideasonboard.com,
	dan.scally@ideasonboard.com,
	mauro.chehab@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH v2] media: mali-c55: Fix clock leak on reset deassert failure
Date: Thu,  2 Jul 2026 10:25:38 +0100
Message-ID: <20260702092538.335036-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[ideasonboard.com,kernel.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270384-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-media@vger.kernel.org,m:jacopo.mondi@ideasonboard.com,m:dan.scally@ideasonboard.com,m:mauro.chehab@kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:devnexen@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,ideasonboard.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB5936F60AE

__mali_c55_power_on() enables the clocks before deasserting the resets,
but bails out on a deassert failure without disabling them again. Both
callers treat a failed power-on as already cleaned up, so the clocks are
left enabled.

Disable them on the error path.

Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
---
 drivers/media/platform/arm/mali-c55/mali-c55-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-core.c b/drivers/media/platform/arm/mali-c55/mali-c55-core.c
index ee4a42674..fb81141d1 100644
--- a/drivers/media/platform/arm/mali-c55/mali-c55-core.c
+++ b/drivers/media/platform/arm/mali-c55/mali-c55-core.c
@@ -699,6 +699,8 @@ static int __mali_c55_power_on(struct mali_c55 *mali_c55)
 					  mali_c55->resets);
 	if (ret) {
 		dev_err(mali_c55->dev, "failed to deassert resets\n");
+		clk_bulk_disable_unprepare(ARRAY_SIZE(mali_c55->clks),
+					   mali_c55->clks);
 		return ret;
 	}
 
-- 
2.53.0


