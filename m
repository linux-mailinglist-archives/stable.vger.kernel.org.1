Return-Path: <stable+bounces-268713-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y8/EOPrqPWqJ8QgAu9opvQ
	(envelope-from <stable+bounces-268713-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 04:59:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E80896C9E14
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 04:59:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=XwLo9oBx;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268713-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268713-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 08A31300D79F
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 02:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B460E39DBC0;
	Fri, 26 Jun 2026 02:58:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7C739DBDB
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 02:58:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782442739; cv=none; b=bQYsyJ3KSM/ng0p/jfnColxPvnCRZl3fFilvhjVLtdVM4q06hYIIinzYIHVyve13bB84kN7nKgGcES3zJf5aSPrf4fiftOBmGqzMGh0HmuxuRM09D1r+LpDW0yXQ0u0VQWzIqRWlU5YvuoYKZgl4g9HNZaSscYMxZGNxz5tSYRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782442739; c=relaxed/simple;
	bh=aG0d86+VStYCLhrRw4TkiqCfZ90Xd/Y/zoM5y23rOFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SVMO5tA4Rf1b/+jvqd6WM6TpH9dBoHieZjGLE3h8k2LQ3LmtTmeJmCI0+wqT8LXX7BgsOzzv6YgN4iPMoGHZWU2Z/s96SpdlhcUC57SQAr3oSgBx2vD2h0ZDJrYsBp1YY50pRMWPP4AzHAC5n7HWTnWHunp6gjqHlzJ93nWnHvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwLo9oBx; arc=none smtp.client-ip=209.85.214.180
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c6be9cd89bso2182945ad.2
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 19:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782442738; x=1783047538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVsjU9yKl2cJB/WfxCzz06jvF+n5PC9ZLu0AFLXamVs=;
        b=XwLo9oBxqluE6pY0EON2hm6P7RuqqkUhGaRoqB+qQT5sCROnn/EKsDa0JezXNCdsIO
         XBZsR5PrTVIvqw36QBbjIDYv80YGL/OAVa1t/PB7i7LLjtMkeEY+Osb2wmAwfULyYYej
         lazycJAdzx399o7Av+7nBvX/EYAgp07eEqPAPVAjYlXPXkVmW7Gwbr7Io4ilQoae401p
         sAs46jPo/Xsf7dvq39oDzJeepzFRHlfki7jtbyOaPkaxT/Uo0ChGoaRTDdQkJqjT4/vR
         L6Fc/O+JlBKluZHSrI/9Levry6nCa3UjRe31VPjj9ZSq2koRAgmXJAB/lZs2f9TV63E9
         fksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782442738; x=1783047538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vVsjU9yKl2cJB/WfxCzz06jvF+n5PC9ZLu0AFLXamVs=;
        b=V42YhvouuvyzuuO9npBSls5NdweYKDbwU2dwqbkfUwuj8gRA0CPxuvl2uXP4ErLSLh
         /M6eye0kOBJ1XoHyLnQUtPbE6puMXz7+7puTa/jKtiWC72npjWHaTmqhvZcc3hXJ1VbR
         wBkmI+nN8r0hf5/DLGTzQZdl4sPSIlPo7Bws/5ciFEYo8Lz/X6dZp8SrDD0gMX4KCvpz
         5uJ8jLqriEqVy+Pl/G9Pf8mCkXfKz5oJJw6FN4iftMBXOmH1FU0gcHtUpwRPaoFG3E6o
         G5eWhQFkZf2/inUUBdlNjBccajk+ug+hQSnbGW9/pl2D2OnNKiSKWN8Vx5tnKKkplcaO
         9jjA==
X-Forwarded-Encrypted: i=1; AHgh+RrJ4q9ucGiL27pANFLCeCV/ghvjAyboJ/wxwNdovvSJTqlxzXg6e/IAVIQQ3lC5K/k5JcORn+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv+RneAbL8BcyKkUICyatNpbRSZc6GMACGfsRdvjXYEUkaL0ea
	FXez1Dp5PzC85l8YULsXccvMuYOCONmp/m3LcuoA3nX2UGCuLLabuIcV
X-Gm-Gg: AfdE7cl1Tgf1xkdWTAQ3KCLIxcQsEzOLTZQjPbLJ2CJXU633h3GT2JHe6rFHxrrvCB7
	Oc9vc/M3QQqefGmGLjStkTg6yVpuMUBL0SF2vq97YAqoNtTfN7qVAO1qmd5dfMbnoNDtW9eI/Ej
	skz55zYRXLOMVrMNFuaR8dQx60Su8q9MejjqMS1vsNjFMC16P4QgE7+elxtHIJig/NMbr0e50+w
	hsz1Pifkzvx9+oA72+uOLMXtAWca6CuK6Mw0O3qcoeCv7ZUFD5/IB32Pm7o73xJV172R6GzWzpn
	S57pp/RS456xOjZIAuJZqcGOIxvSOeFhYEZNq3BCqa0nfZyEMhZ8dXWmZbHtRE+EwzqTK0PpFzI
	fUQhY6WC7FI+rIig5HRKd8gdWllAlabuGI0NWvE35+j1rzST6hLDNXsZaSeTrfpUuGotMGrzl80
	ZNs+vrqt7qSHU=
X-Received: by 2002:a17:903:46c8:b0:2c7:d071:3ef1 with SMTP id d9443c01a7336-2c7fca19129mr53387105ad.19.1782442737717;
        Thu, 25 Jun 2026 19:58:57 -0700 (PDT)
Received: from archermind.. ([182.150.55.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5afb1e0sm31252535ad.29.2026.06.25.19.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 19:58:57 -0700 (PDT)
From: Liem <liem16213@gmail.com>
To: frank.li@oss.nxp.com
Cc: Frank.Li@nxp.com,
	andi.shyti@kernel.org,
	biwen.li@nxp.com,
	festevam@gmail.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	liem16213@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de,
	s.hauer@pengutronix.de,
	stable@vger.kernel.org,
	wsa@kernel.org
Subject: [PATCH v3 0/2] Fix slave mode corner issues
Date: Fri, 26 Jun 2026 10:58:44 +0800
Message-Id: <20260626025846.106157-1-liem16213@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aj1UR5ddawsdMbZC@SMW015318>
References: <aj1UR5ddawsdMbZC@SMW015318>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:frank.li@oss.nxp.com,m:Frank.Li@nxp.com,m:andi.shyti@kernel.org,m:biwen.li@nxp.com,m:festevam@gmail.com,m:imx@lists.linux.dev,m:kernel@pengutronix.de,m:liem16213@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-i2c@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:o.rempel@pengutronix.de,m:s.hauer@pengutronix.de,m:stable@vger.kernel.org,m:wsa@kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[nxp.com,kernel.org,gmail.com,lists.linux.dev,pengutronix.de,lists.infradead.org,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-268713-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[liem16213@gmail.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liem16213@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E80896C9E14

This series fixes two issues in the i2c-imx slave mode.

Patch 1 clears the slave pointer on registration failure to allow
subsequent re-registration.

Patch 2 cancels the hrtimer before clearing the slave pointer during
unregistration, preventing a potential use-after-free / NULL pointer
dereference.

Changes in v3:
- Split the original patch into two separate patches as suggested by
  Frank Li.
- v2: https://lore.kernel.org/imx/
  20260625160219.55116-1-liem16213@gmail.com/

Liem (2):
  i2c: imx: Clear slave pointer on registration error
  i2c: imx: Cancel hrtimer before clearing slave pointer

 drivers/i2c/busses/i2c-imx.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.34.1


