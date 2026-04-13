Return-Path: <stable+bounces-236004-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yH8jOrbZ3GmcWQkAu9opvQ
	(envelope-from <stable+bounces-236004-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:55:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA743EB9B8
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA81B3019148
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081193C13F5;
	Mon, 13 Apr 2026 11:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzlIKv1J"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943F437F8D1
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 11:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776081270; cv=none; b=RoTKKd27QAEPnFpLTx50aBitSog26zwdLsblx7LOlHj9vkXUjcFHDA/ZSLizLsSUmcTN1t+8X0fmPrlcj3vMA7VYGlVqgoPGGZ1U6+0fSftvF71BuPOik2oN6sQB0MYRmF9fh3hF5b9kl/jsFn4xCCSbtSRIzwe5ic5VhvARup4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776081270; c=relaxed/simple;
	bh=DpIntkKN3iEhgCt9UIkBGF4XZ4jGPxiV3R2ublbIpVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mRh9CoXjjDQl4bjGPA5dK53kJ+b7p78vzt+sKKh596vU+0L/sFDSGSvY29ZRr+BYIIDTmpa7e3XJeVDumL9mmCgdw5rqkOQcAnSM19MSRvxyQtRsNBnZWM6FPUrthpF1iT/1WhY6ri5yGRcAvM7V3qatvtNHuaZOTPmuATXvRA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzlIKv1J; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so1657677a12.0
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 04:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776081269; x=1776686069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kbf6f/mBggx7CBkqLB4oD03Dp2SeRdAQ/IF7C0fyt8o=;
        b=HzlIKv1JoAOpWUuWPf+XLcFzylORAsmEMu/fnvpQ641CWo3f7NM7UK9cY9i/xe/V1T
         VbGcCq5tvok6A1AeiES6Z6KI2lcJBxEOuB6fdObr3ZA8vKB16Gh7Nxl1Q2qxbIRloISL
         qx1eM3aVRbIzgPgAL9To/D8SoqLl6ULpwGELV4LUh2MeNtLKRcTVhXKqIcLNUSck8g8V
         Z4XDT3nxVNeW7hJkYjttCldKvtn7wPn09N8qPslJCWtr4Dv30ZmXU+kvYcv6BuWyeMwy
         pfkXDojDCy/J+CHN8ndnDBqc4Dk/qUwq5nQKoLGcmzTDcJv9NiikwPUU2BV1XMiDf7Nc
         NKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776081269; x=1776686069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kbf6f/mBggx7CBkqLB4oD03Dp2SeRdAQ/IF7C0fyt8o=;
        b=lalTBG5Qyy7pZAFMNnS+B8n+beyL6NAGdWB4EHM8Sn/VMQtaaVCU4Rr9vOSjCt5tN6
         V8nphWLPXCDZkA9v655Wp2ZEMU8s4hclkCBwMOiTdXWsIhRHRMAHkW0EO5nIM5zWSwiP
         zA4hUS8zkswnwkNNIn6lohqnL9dex3BTsxldMupEv6gKXCGtvpFWyhJ8NqwyRS+4z+la
         FBk3WwUwEB8hBBsjoV+U3y4wH0YNq079JCDWNRTbwMt4Gap1xvB96LDCzsCm2oEJeAnX
         M4fJqyEaxSl8AosNNtvE0GV6gcaiqrbOCCpTH5ayy9DcZidUNMc021fUIqj9anPiaUTs
         3fmg==
X-Gm-Message-State: AOJu0YxbrmPjOzYJ6USPOERg/xpAJTNdFYgpohrckHXVxxdzInVTdT6k
	YamA/lDK4uTEMwM0h+HOe/DWTvayTCabsJCbx95FZyWtRBBPwKFpleoImrPTIi5Y7BE=
X-Gm-Gg: AeBDiettUNZjPqAOZ+/7gze+diTL8t0Psad/9nV63EK9TqN59SsC648PUFfqBaYqJei
	pe4IjznfwsZ2SIh42Ah2YW7IH/0Hv9MGnzqYbgmpvRNvt1P3cuZKcicsMMM3UfvgWSXQ3iO2Vz/
	a4+Xx1XKtqQeGfhwbjmhzPDDYBS8VKJewy2yB3MLQTg6qF2KICM4rEV8ahhECpTOS/6SmZe92IS
	rPxqc+3P2twVe1PVfhcHjUDNOB9rNCl7JCpWse0+z6TfCR7fC7JyZwA8xz7rw6UFeXfJu/RN0lJ
	VBS34l4T+IlBTpa3jfRI1r3W46A+65oofA9zUkcMkuRWPTxSMwAJ++f2f9FY85rkyHeAkeP787b
	i0KME9zhrJtqYk5sXJgE7a6Hs/zQbewhaIEZDhyz2rgy/4ed3m/zxPFH4tqpE7OQm9s+UaR9RjZ
	JTFEu9LvC4XKHb2hDLea7AIowVLftnWhGOcQu395n3jw==
X-Received: by 2002:a17:90b:1a8f:b0:359:83d3:27d3 with SMTP id 98e67ed59e1d1-35e4274e363mr10973143a91.2.1776081268925;
        Mon, 13 Apr 2026 04:54:28 -0700 (PDT)
Received: from lgs.. ([2409:893d:1188:142d:db27:7a46:955d:48f7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e34fdc4bcsm15474300a91.7.2026.04.13.04.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 04:54:28 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Adrian McMenamin <adrian@newgolddream.dyndns.info>,
	Paul Mundt <lethal@linux-sh.org>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] maple: Fix refcount leak in maple_attach_driver() error path
Date: Mon, 13 Apr 2026 19:54:18 +0800
Message-ID: <20260413115418.2780881-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-236004-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[users.sourceforge.jp,libc.org,physik.fu-berlin.de,gmail.com,newgolddream.dyndns.info,linux-sh.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6AA743EB9B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As device_register() calls device_initialize() before device_add(), the
failure path in maple_attach_driver() is reached after the embedded
struct device has already been initialized and its lifetime is expected
to be managed through the device core reference counting. However, that
path frees mdev and its associated resources directly via
maple_free_dev(), rather than releasing them through put_device() and
the normal release path. This may leave the reference count of the
embedded struct device unbalanced, resulting in a refcount leak and
potentially leading to a use-after-free.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

A possible fix would be to use put_device() in the error path and let
maple_release_device() handle the final cleanup.

Fixes: b3c69e248176 ("maple: more robust device detection.")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - note that the issue was identified by my static analysis tool
  - and confirmed by manual review

 drivers/sh/maple/maple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
index 6dc0549f7900..20b7c2cd852b 100644
--- a/drivers/sh/maple/maple.c
+++ b/drivers/sh/maple/maple.c
@@ -393,7 +393,7 @@ static void maple_attach_driver(struct maple_device *mdev)
 		dev_warn(&mdev->dev, "could not register device at"
 			" (%d, %d), with error 0x%X\n", mdev->unit,
 			mdev->port, error);
-		maple_free_dev(mdev);
+		put_device(&mdev->dev);
 		mdev = NULL;
 		return;
 	}
-- 
2.43.0


