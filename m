Return-Path: <stable+bounces-254593-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAQrO3v4FmrUywcAu9opvQ
	(envelope-from <stable+bounces-254593-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 15:58:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9624A5E56FC
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 15:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 00D7D300A318
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 13:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EBE3DD86B;
	Wed, 27 May 2026 13:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I03T5x/q"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3549D262FC1
	for <stable@vger.kernel.org>; Wed, 27 May 2026 13:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890297; cv=none; b=oDK/9sxptE7l5+PwUz4PCEOTRKNdRQnoYAO50jUsFzMYgqxAwx09BOUqmhoKTOwCmHygWNTk6qJlzzN0f2pKUPooOz6tJEGU9/nBBAD9kcWmZyVnge8poR2Dc/jPrpcEw6C9qU6wejxTv1a0xZNBKPrkRAo4/j2dFQUZr+2BwPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890297; c=relaxed/simple;
	bh=6N+ANPMgefHybKMAFexpaMVcK8mi6ROi1nROc0wifqk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tox1iZrsoKwZCiO4V9mFyfcySlCqwb3GNct9WAB6Lr62ZwejCj5Z73/cetk9NjPoek+WBWLXTQKj1T5Q6I3zMf/n9z/qv/p5aEzoiGrcMdpy2rhe759McjJxmccBTOdm3f27thsDw4VhxWDt+LEuS+ZOgeghrq3fz7n10IufM7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I03T5x/q; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1334825de43so10313108c88.0
        for <stable@vger.kernel.org>; Wed, 27 May 2026 06:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779890295; x=1780495095; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WE1uFjLQahicP6Pul0+3gr6Dj3sANOaIDcF9iPOsssE=;
        b=I03T5x/qHdT06VxucSMBG5C1l2OImKeo32HsXz5RghuOLoK8jspR8NGvXylqfgGklB
         JgZIKzpz3+hdsNug+aSWCzNozlhPflgFkIT3+GWkx+Mfly8OOKiy/ZaWa4/FfNb7Vqsy
         B+HWPBABiIFGVo79wVw/dVOQiXCZZlu+uyj6yRJgjLgDF5u2/WkdY1ZLqyEACm78aW1U
         oa+nLXLyfwRWn8GgNzYziqRnBKHuxNgYCz9hWmz2xQz+15iASKhs9QZvCJ14vJE2WXSN
         fCyKEDgq2hhulNZxXrXFQm2JbBbYRfUPHu+3iSH7/5yaBeCm/xKQxb+qXGfhsibghdcj
         RXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779890295; x=1780495095;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WE1uFjLQahicP6Pul0+3gr6Dj3sANOaIDcF9iPOsssE=;
        b=UCkWh5bmAn7LqHUaxLoIZmkc/6YL5z6yWh8gkbJ7KFPtPzNtv4eecD5TUuwLHw19Q3
         hw3fKZsY5wCeX6X2Vb16KrsIFkqYIlPkxye+4IOfRGa/iUo2vbfZVSja/tMo0kyKBBzJ
         QaL3YPdzqNz0c2ODDj4+FVS5tvY6jr6MuFMXEiDTJCmjYXuXgMqNOR/fiZmiiB00GNGG
         CEF681GwktNzrCb5fC2RbNn3GlKGY5dWBUgsHHSwcJlDz6Z7899C64GSVq6e1L9Awm/a
         Ix5WEi472z9BOehhuXDoLqdYbogQ0UidISI0lUbm7YMoL0i1ZfnKfq/KqunzPWDqngka
         lvpw==
X-Forwarded-Encrypted: i=1; AFNElJ/P9/EVLxHQAn2UERLdyO+KP28i8OKZ66h1TGN6mNtwp5BAI10UPYiOfUjY7nh+hwFxZ1+Zgmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqhQGyuMPjOjiScnZl2I2mdwl36tf1D/FUKemdXn5wRlISlYBp
	NEJ3pGhM76En7LtNhgsekZeNLCcNWktk4Y+dg96SB34Geff5rQtVYohE
X-Gm-Gg: Acq92OHnSNqrp5AXTotAJNdlk5/sd9/GySEm9BcCX3ORE1iPIKFijmQdfVoWBw6GAqD
	jgQmZRHT30/6/NclAMbKINWMuq78MWjsMetHDOltW+Mu1cxygogywJf5iRQuEmwiZW1QRKVcgB9
	xMxF9BXGcdvuN8Ow73H+CAYr25iPUdyR+hEoePpZE/mT5UTFPoke8vLV66Y/zoA0PeOmHitX4jk
	PMAKCNvX/NKDcruV9iX6yrQ+oKHgOAA0wP/ibATPLzRiK3yo55U9wIq4t6Kv12FFGOkM38QvHUK
	LgUojihNeKaTlnSzKMMIDfNKMGiVASq5aKnHiENQ6i/KwUPYJ72reaPmwZMva3bGDWAiYPAwjHM
	0UDgFFuMnWgkqJw727XPJPGHL8tqjC7DFrDw1LVm0xXqVXO8XmVnRc14wo4rOq5zf2iGEl27S4K
	fyMTKF3f+qa8qTH9LdscMiuUS7WrgAyKrmQVKen2GsYpjZAsB0yquc41rpYPMzrQrseBw4UdMuh
	CbRyqj5Bpzb
X-Received: by 2002:a05:7022:20f:b0:137:546:9e9d with SMTP id a92af1059eb24-1370546a30dmr3647362c88.23.1779890295149;
        Wed, 27 May 2026 06:58:15 -0700 (PDT)
Received: from [192.168.1.18] (177-4-162-74.user3p.v-tal.net.br. [177.4.162.74])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366aba2b9asm13013788c88.15.2026.05.27.06.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 06:58:14 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Subject: [PATCH 0/2] ASoC: mediatek: mt8192 probe cleanup
Date: Wed, 27 May 2026 10:55:45 -0300
Message-Id: <20260527-asoc-mt8192-probe-cleanup-v1-0-1bb834d05b72@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ6CMBBA4auQWTsJTMOPXsWwKGWKY7RtOmBMC
 He36vJbvLeDchZWuFQ7ZH6JSgwFzakCd7NhYZS5GKimrm6pQ6vR4XMdmjNhynFidA+2YUto2Pf
 kzcBmbqH0KbOX9+99Hf/WbbqzW79DOI4Pzadfxn0AAAA=
X-Change-ID: 20260526-asoc-mt8192-probe-cleanup-3ef72f38e3d5
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chen-Yu Tsai <wenst@chromium.org>, Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 notify@kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=988;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=6N+ANPMgefHybKMAFexpaMVcK8mi6ROi1nROc0wifqk=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDFliP4q4WNfnRvVybPEVCw8X7y6/cUaq+uTreaterYh6p
 6a/5mhJRykLgxgXg6yYIsvqpEWWe7oeXK2PW+EBM4eVCWQIAxenAEzk7WaG/ykizCedV/beSnb3
 Pr8iTL/pXimr0hT9p+eyjzK2chScPsDIcDEr+pIXS5BX9/a5PybZy4tPNFgQbPfKsvfgxMYa9WQ
 LVgA=
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254593-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,suse.com,perex.cz,collabora.com,chromium.org,mediatek.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9624A5E56FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix two MT8192 AFE probe cleanup issues that mirror the recently fixed
MT8189 and MT8196 paths.

The first patch registers a devm cleanup action for a successful
reserved-memory assignment so later probe failures and driver unbind
release it.

The second patch checks the temporary runtime resume used while
reinitializing the regmap cache and makes the regcache failure path drop
the PM reference and clear pm_runtime_bypass_reg_ctl.

Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
Cássio Gabriel (2):
      ASoC: mediatek: mt8192: Release reserved memory on cleanup
      ASoC: mediatek: mt8192: Check runtime resume during probe

 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)
---
base-commit: 93f1bbc69dbcbb29544769c4d6f3456749ad9013
change-id: 20260526-asoc-mt8192-probe-cleanup-3ef72f38e3d5

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>


