Return-Path: <stable+bounces-236116-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJ/7GtL/3Gk3YwkAu9opvQ
	(envelope-from <stable+bounces-236116-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:38:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D55B23ED5FA
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90D4F3025A42
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1683DF010;
	Mon, 13 Apr 2026 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pkA26Dz2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F753C1981
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 14:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776091018; cv=none; b=oO4RlMRAjPkOWVmJU15+h3VpXaUPCrmA1F/udiv+zXLRpgVkkI7MHE1I/DJ80EZnyFHVn/b6QpGbqZ93dyePAMAmAuBYwqo+5u6H0M11fbplIC2+WWZHBzXY4EBsmPoT3DAMr1a3GsZo+u0lJ1NAw5Q6K5u6iKYNdq36iVd0JMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776091018; c=relaxed/simple;
	bh=CQiPZwiXn4m65gWkVZkLBq+sWyMmqdp49enY7UbBcTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=raKyp+3WNiUE2dBmRqj4DCI/iwikTLHAtVjjdarO9OVTtz1CwanU4fjOJLeqAa188sjrCoTxbikryVqL6ug+dyCbp5rB5C57ILYOxjckf29nBilv0846IuC4BNk3KVBk8cTPCkMsgil2fbQK6g6FBBqUAtb2Q7leoyzIeYb9lJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pkA26Dz2; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso2420276a91.0
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 07:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776091015; x=1776695815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HZuCdLfTzqLBe0povKqAJGPUREmpR9XWI6MvS95wZIM=;
        b=pkA26Dz2LkVUJUFhNcw6QvzUml0nmMYLe93yOINZbfo4ah8f8fJzZqLONoPmONP3Ql
         oC5mXPTUm6idBGU4Xp+moUK0RJRn39zc7Ww0ANa6Bx4DocuNejXWawV1lAJXbvlRzABN
         TQ8WAR5ygL6J72L1K7y+dzI11/EyOJ8VPkT1p6D/yQ4/HmSIrGEmD63O+C8KqXUrbKpu
         NWTK/jcjXes9alHK4c1w6j3BbW9egysCYgMjR8cRsb2EfbqxbLhjGq5y7uWkJ/+v5Evf
         ToUUKfEHIz1bzDw8NZELT2EZszN39p8Sp+9oOyhayeyHR9vmqOTa6Xxtsfmxy67duvzL
         hHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776091015; x=1776695815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZuCdLfTzqLBe0povKqAJGPUREmpR9XWI6MvS95wZIM=;
        b=c5fsuCsdA4lDXT2aLoEv8URe9X0CwSotQNzOr+m2CfyHdjTOoxQhhCPY+PgdYXhPEX
         FeyEbcLZJ1HBXkQietCvv3p+0U24IDV8qEXegZxkia4jryzjiwb7YMN6DVzKbkCWTF0Z
         PEPXVaO+rrKY8Q6nSJvf0kTOcmfnF2TEUrit4mQMOv5hy4vxDmwepWywzfESKGDHzJHZ
         WCn3hCiZvrtjacGJVUUxxnnuSwcGKimtflirfK1i93OhnOnUCOhWGcnxNkEDHDnFK68S
         zBRKbj6gJfYPvCjZBA8StKayegXJawpg0YzzRyyS75HQvxP4loCZgKLvwIUWWtJDUbfs
         jLNw==
X-Forwarded-Encrypted: i=1; AFNElJ8HiVqEL6sQeCwgHFmXBp5uWFPzFEFw+WxlXgqxEDYciKyy3ZJsbPPoAfssXSNqkZCeV0H4HJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTgXZRnLP0tF5aeb1xsPk3eb/ZR9yYTl3/EPiUTTiGT8QueGR9
	r3XEKnRPXAlNDrcas4b3be7FjSlh+zBqAZjmzqN2zoXVpYX0ieekHS2g
X-Gm-Gg: AeBDievHNeTmcPMKmxxEH1eNZeBFZcydnmW7DrlQihIjMmv2K7ql4SpiysZE7a6d8iU
	y0YbCcNEI24pEx5DyuOvNCtZjELPaVveIPbAyZo3TnFqwB3LE8EZbpcy5N1L5yAYSiyiosOhu8F
	kKFHvbqiZ45PBg0HRVnKik8qT0dzT/5e4MEE7GKUhHUbd7t1UzWggh6qKnjAvKCT9bjFhrKmE6X
	yRT6G2CYfKu17f+sG97yvM0CyzVBWMEprzHtfpX/8MK7gBvtXJ0iIl7B7iTlymhnv0PsHp70Z5m
	eefL15jLlron0KKtW0xDyON47GwLUcWYMH0PQv3KcXlsS8AOoMwS8CDWGcPGEp7/cdSItGtcvAz
	m4rYAUPswF2uTY1px7B68EDSmPAB1spL/RaQHKkul3xjuetwoyduI6rA6XMjTzXsJc8TNFf/WfX
	GnwNqPwWG9ciSGwUZX/0imRkMS5UEyWJQ=
X-Received: by 2002:a17:90b:3c85:b0:35d:a4c0:a0ac with SMTP id 98e67ed59e1d1-35e4278b922mr13246756a91.3.1776091015423;
        Mon, 13 Apr 2026 07:36:55 -0700 (PDT)
Received: from lgs.. ([2409:893d:1188:142d:6c67:74e8:5200:1f39])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e3512f41bsm15826120a91.9.2026.04.13.07.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 07:36:54 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Emil Renner Berthing <kernel@esmil.dk>,
	Hal Feng <hal.feng@starfivetech.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] clk: starfive: jh7110: fix memory leak in jh7110_reset_controller_register() error path
Date: Mon, 13 Apr 2026 22:36:43 +0800
Message-ID: <20260413143643.3002454-1-lgs201920130244@gmail.com>
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
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-236116-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D55B23ED5FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

jh7110_reset_controller_register() allocates a jh71x0_reset_adev with
kzalloc() and sets jh7110_reset_adev_release() as the release callback
for its embedded auxiliary_device before calling auxiliary_device_init().

If auxiliary_device_init() fails, the function returns immediately
without freeing the allocated rdev. The release callback is not
available for this path, because it is only reached after a successful
auxiliary_device_init(), for example when auxiliary_device_add() fails
and auxiliary_device_uninit() is called.

The issue was identified by a static analysis tool I developed and
confirmed by manual review. Free rdev explicitly when
auxiliary_device_init() returns an error.

Fixes: edab7204afe5 ("clk: starfive: Add StarFive JH7110 system clock driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v3:
  - clarify the changelog to describe the exact failure path
  - note that the issue was identified by a static analysis tool
    developed by me and confirmed by manual review
  - apologize for sending the initial public posting as v2 by mistake

v2:
  - initial public posting; v1 was mistakenly skipped

 drivers/clk/starfive/clk-starfive-jh7110-sys.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
index 52833d4241c5..55cd0ccbdb84 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
@@ -360,8 +360,10 @@ int jh7110_reset_controller_register(struct jh71x0_clk_priv *priv,
 	adev->id = adev_id;
 
 	ret = auxiliary_device_init(adev);
-	if (ret)
+	if (ret) {
+		kfree(rdev);
 		return ret;
+	}
 
 	ret = auxiliary_device_add(adev);
 	if (ret) {
-- 
2.43.0


