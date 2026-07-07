Return-Path: <stable+bounces-272368-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eklWGbuzTGqjoQEAu9opvQ
	(envelope-from <stable+bounces-272368-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 10:07:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7FF718E53
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 10:07:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=NF81gmrE;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272368-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272368-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66AA73070D2A
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 07:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B1B2EA47C;
	Tue,  7 Jul 2026 07:49:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD8E231827
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 07:49:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783410557; cv=none; b=cFO61FuBlOwMS7sMIc246XZA76kUNtgWin4+C/7MbXRK2602IOnLu/gSIQBmFsKS63KT8V/CO20BqvdrEkeR9na40uzvsimJ09v99IkmeOUlm7K1o7I0fqnaKidj3sHTv9N5j5nfiekkmQEnzcEh3JWmKH4BPXmqL6kvI0G2Jqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783410557; c=relaxed/simple;
	bh=Ll69jwTycTVdStJZVNDDkPg2Y7noF1LtSQhw0u/t8tY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eK2WA52zTHOnTUxsnlDBl2DJShexmNoARk8st8Map4FOPqP8dt8YBZJdymuIQtAOXB9oSLv8nThMp2Icajzv0wBeS9pOOJvyJTW6s0lUqV5xO2k7m3yOVVXZYORxkX3nB072zqU/6K36lCTjwsJDGTqvv73/ssodM10WVvngOFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NF81gmrE; arc=none smtp.client-ip=209.85.216.43
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-37cab825ec9so3894970a91.1
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 00:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783410555; x=1784015355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=47qH9DhdGsXSvcnn2TMzn7MFl2kXpbMH9aBDXUUfcBo=;
        b=NF81gmrExriPwHcYQxKufEChkycKDwPfgnoPb4kOq76khlCZIbGRS750MmLLj+B15N
         1hxEEU7pN0gVLk5fIJ1xBTY1I1bqDgjKKX/vO79nHrVaE0nVhYJ7HfUYUOM6pQKseMmf
         0lXUIIEFZ7QKU5e7hvDW/wvBGGzMA2S/lHK/9EK8z9+7+WJQoVJL7RFhPmLM2vGw1P1Q
         14ErFbrZiBg3N+COpbjduLz20wtLX19w+hUSKGZll4kMYcObwyYezgtXeR4RpCydcS0Y
         sMBWEqR0qL5gbsI53NoODoXBGo4cQah0osjGYVCHqRaBW6ZraRJ81x1oeTDLse6Rr2wr
         +9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783410555; x=1784015355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=47qH9DhdGsXSvcnn2TMzn7MFl2kXpbMH9aBDXUUfcBo=;
        b=KkvtciMVBE6uadDdX0d04R3YPm8SbQIrE5ovPwvPsuItIpf/4Yt5F06GChxH2TK3JG
         PIBYQmHFjVKzUDvgQMbPxStH3mRyNK9c++AyippGc43nKiTY0uAkZ0CN08ermE9KKkrR
         z/Zg7Ek485AEUWMtJu45k54QdfRKnUaUMNAzA8Oa9vIEEWjqq+44RCvmIwjSZfrBKx0l
         3ECn6JVMSfOq9rT2O5aX4d73Ols4fIWgkXKg4lzyxn71VU0Nr14f+Q74k0YvHlCx5b1c
         JWzInZ9rXFTAhlmjI0S3x/feMK44JKlgaB4kLcPswpyjMZD/USpvYt0HrqPNnI3tfvh1
         DBxA==
X-Forwarded-Encrypted: i=1; AHgh+Rou5tlcHP+g1MdJeisMvpolzM7b/tzpU/rbmH5UgttoKWdexBik6u27CUkuUt/FRzPq5LOPgfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyywSnyQ1M/VxKc1gXrAVPA4YMcg5wu3k89QpXJ/k7N8MDf3KeG
	4F1cXdB/OdOP5pOl4hADHUsFrEPyGz9nrq7a23OlgCFfynRosbwoOoBF
X-Gm-Gg: AfdE7ck4kvZ4/oLQpcSW6zhUXjdoPPnblY8dd0Us7V4OmSGls2NmFPQGBVix6zwJtmk
	UIkeMA0wND1uCpCVvzhpWpjt25AD+8CnTmtpoOY738sgmCvbJAETcH4lCSQO5OJo75dJEQciMgX
	HQFHdFYFH0pcjralhcrY0SzVNtlXSkmnmisYA7AZ9s6cuROe54mI/W6qRGckeKJdiMjj4CV6L26
	DadrEb2q0CLTF8nsgMbmDOdBQQpNtddo/88L+YdJWEOR+08mx50SnDKQN4gE9Uc/lco/XO72E52
	Grq9uar6xtx+YrO4PoU9V6yhxpzADDu+aBktVF31TOeKmFpJqp5kdEH834olbyUJeD3RCTlupnx
	ftYj6u1DoNzzgorih0w3qwPpR7zfRCMbyXwLHuG0rmTDshBk7fbt4FRZ6yV3xLjy9dWacryfAwL
	p/MUYVs5plqje14HVR/wGLMiO59DpdINLkCjRXI6A52qIi
X-Received: by 2002:a17:90a:da86:b0:381:28e0:624d with SMTP id 98e67ed59e1d1-387597e83dcmr4179386a91.28.1783410555332;
        Tue, 07 Jul 2026 00:49:15 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d20a361asm626710a91.15.2026.07.07.00.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 00:49:14 -0700 (PDT)
From: Akari Tsuyukusa <akkun11.open@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	stable@vger.kernel.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	Miles Chen <miles.chen@mediatek.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>
Subject: [PATCH v2 0/6] clk: mediatek: fix memory leak on module removal
Date: Tue,  7 Jul 2026 16:48:29 +0900
Message-ID: <20260707074839.240676-1-akkun11.open@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-272368-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux-clk@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:stable@vger.kernel.org,m:wenst@chromium.org,m:miles.chen@mediatek.com,m:akkun11.open@gmail.com,m:matthiasbgg@gmail.com,m:akkun11open@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,redhat.com,gmail.com,collabora.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[akkun11open@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,chromium.org,mediatek.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akkun11open@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF7FF718E53

Some MediaTek clock drivers do not call platform_set_drvdata()
during probe,
but their remove callback calls platform_get_drvdata().
This results in platform_get_drvdata() returning NULL,
which leads to calling kfree(NULL) in mtk_free_clk_data(NULL).
This leaves clk_data unreleased, causing a memory leak.

Fix this by calling platform_set_drvdata() during probe.

Changes in v2:
- Add a newline between platform_set_drvdata() and return
  (suggested by Brian Masney)
- Split the patch per SoC, (also suggested by Brian Masney)
- Add "Cc: stable@vger.kernel.org"

Link to v1: https://lore.kernel.org/linux-mediatek/20260629142348.273766-1-akkun11.open@gmail.com/T/#u

Akari Tsuyukusa (6):
  clk: mediatek: mt2712: fix memory leak on module removal
  clk: mediatek: mt6795: fix memory leak on module removal
  clk: mediatek: mt7622: fix memory leak on module removal
  clk: mediatek: mt8135: fix memory leak on module removal
  clk: mediatek: mt8173: fix memory leak on module removal
  clk: mediatek: mt8192: fix memory leak on module removal

 drivers/clk/mediatek/clk-mt2712-apmixedsys.c | 2 ++
 drivers/clk/mediatek/clk-mt6795-apmixedsys.c | 2 ++
 drivers/clk/mediatek/clk-mt6795-infracfg.c   | 2 ++
 drivers/clk/mediatek/clk-mt6795-pericfg.c    | 2 ++
 drivers/clk/mediatek/clk-mt7622-apmixedsys.c | 2 ++
 drivers/clk/mediatek/clk-mt7622-infracfg.c   | 2 ++
 drivers/clk/mediatek/clk-mt8135-apmixedsys.c | 2 ++
 drivers/clk/mediatek/clk-mt8173-apmixedsys.c | 2 ++
 drivers/clk/mediatek/clk-mt8173-infracfg.c   | 2 ++
 drivers/clk/mediatek/clk-mt8192-apmixedsys.c | 2 ++
 10 files changed, 20 insertions(+)

-- 
2.54.0


