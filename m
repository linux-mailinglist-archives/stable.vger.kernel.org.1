Return-Path: <stable+bounces-269612-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5a1EFzvbQWqPvAkAu9opvQ
	(envelope-from <stable+bounces-269612-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 04:40:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB0C6D58B4
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 04:40:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=aKN7a8QK;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269612-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269612-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CACE13033D3E
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 02:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F077379EC4;
	Mon, 29 Jun 2026 02:39:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F059379982
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 02:39:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782700766; cv=none; b=tdUIlK1q0NBX8tI0SSdgw+dzulKWLr8Me72+K/Yzlt/V7Zg6ZGW6D4c5mfWJzMN5S1Wd93bSHuuS64447P8+q7KD8Lypa1ihTyzSNWy/AVxzrmPsfPm3YZLEuZmgp6mjPkY0oh0iN8WezgBXkhIvhxCMLlaCkxDl0O6fDZ8jFnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782700766; c=relaxed/simple;
	bh=3yf/BQq8y+lBmy/U8Na/4Wdy8IPK1JZVpOtqu+QvhLs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MijY5D5zlITdpn6w/Nf97frYe+r6KXcWiiF9GLfSnQxzTdj/PgiOYw52IdCpALhv672MDA3gL6Y3zlDw7SD+0p+H3U36T+4zqzE9VT1foBsWruRs4e3svA2MJKpM9Vhwb544Cyl0nNHZx3/paSQG4y6RmaAcXTl6NEAY55/o6s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKN7a8QK; arc=none smtp.client-ip=209.85.215.179
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c85d4b4245aso1672462a12.1
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 19:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782700764; x=1783305564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pjYx+8tIMWDajKptnVsnfbgFJjxKrPWEBY6WEuIFPcI=;
        b=aKN7a8QKQ4Ho/XkIWEqscBKMNUxMMxQEra4nYjbhtTt6246gZO+1SM9MmBcXSkwuE6
         EmxOx+N157uKaaCcZXsw49iS0rJvIHnoGfG8gUGhSt4shpm+hVKmGzB32uqygtGMr6xI
         GKBA0J5QWx71dwLUMckmPhR9W8K2E0M04uzJ1lBLw8ah7gB6PTKek6ikVQJhrufWjPxH
         qs2EzVHcTw+WOAPGJv2b+2RxHIDlk9iH/lrcEkWA2DWgbKFM0YdTSPJ94otdUdmt4ZLy
         xNNZQPgnWvgMzeRvSJ11KrxTrgcunl/78eU5W8+0HiOwlu0bv1METBTuIHHJmu4Jgswd
         rn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782700764; x=1783305564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pjYx+8tIMWDajKptnVsnfbgFJjxKrPWEBY6WEuIFPcI=;
        b=f6vHsPU0vU62fDQw+fBkpwqzw4Abots0QZGH6smvBiRCdQLw3klxUPry5U8MqKRdMs
         /vXcLzeHj/NHreS0PJt6ApM9j6mhA+RAiakfAU0mJzMaY1QrpfkLPSRq5q+aYbxT3p51
         r5R+cko19YVlt/osUEZ/ekAVRVOintodDpY4ztrJrRSoVKBWTTYmQ04jewF6BjITaHSa
         irwo5SKi0FNOm1OjBhlvHrgNrzXrYzjY2ws3PdF7vQvZIFVZnS1vxEf476pXZ1QUjlaf
         tQVas3qn3IGLWSdejFGAd/55hVtE6ixhRWucmmQX5KWgN4gJknZymfpZxZIEiHCkHC5a
         144g==
X-Forwarded-Encrypted: i=1; AFNElJ/FWzJQYZnt8P0n8li2WbKBQ80/nCZQdX2joEIajlDdjufmzpbT9a3JMHl8/S8UhDrk4TybVH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YygE8QV+dRVtKWhmyGaavn6ph5vXYOToZuQ+K//E2biU8r0cE/W
	S92sQjMH47QNW/VObfNUi1d+CwlHRTqS5R7q0xg/zRUL9PrHFd10usTq
X-Gm-Gg: AfdE7clFv/vXdz3xHKUcZpsZUL39LH2O8JTKap/up2u+NNuTPDg9g0bMDfjUDrY/6Kl
	WtG19kBz7QA33k9Jl2QUP2qaBB/xdMjYqVg2UfUC5I/lmUSOMS8UdIUOvaT2e+0Om9vd3pjuVie
	Qjvlc5UYGyDVy3SzZxBpg8u2+U1uRiBnHLIflPyyMuFVlcdND9sT2nl1f3KymkSdz+YAqgjbc2j
	pBD7H53j5bRa4sUTTEksOSuRJcPTET3akE/lYIpQzGczlAIxDv/Dj+p2VsXpph1SaW5a1m1oIV/
	ey+f960d/c1qmpvHD10kpYIdVhC38jz6KxjAY63omXwmE7qi3t7VkRWMCHUzTfH1kKfTP0h11Dr
	CuGUSHUH85WoS/nA5vdeJBIkrcxS0OT/CuoyBCQ1jeGlGwXRgPXgL3vMg801YprCLJpQZnMyx3o
	BqAeB6nvBgUAhcWOSS7L823g==
X-Received: by 2002:a05:6a20:a10e:b0:3bf:6c08:fb8d with SMTP id adf61e73a8af0-3bf6c091306mr7342972637.47.1782700763765;
        Sun, 28 Jun 2026 19:39:23 -0700 (PDT)
Received: from archermind.. ([182.150.55.91])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92b9dc216csm6914869a12.9.2026.06.28.19.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 19:39:23 -0700 (PDT)
From: Liem <liem16213@gmail.com>
To: carlos.song@oss.nxp.com
Cc: andi.shyti@kernel.org,
	biwen.li@nxp.com,
	festevam@gmail.com,
	frank.li@nxp.com,
	frank.li@oss.nxp.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	liem16213@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de,
	s.hauer@pengutronix.de,
	stable@vger.kernel.org,
	wsa@kernel.org,
	Carlos Song <carlos.song@nxp.com>
Subject: [PATCH v4 2/2] i2c: imx: Cancel hrtimer before clearing slave pointer
Date: Mon, 29 Jun 2026 10:38:29 +0800
Message-Id: <20260629023829.152651-3-liem16213@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629023829.152651-1-liem16213@gmail.com>
References: <AM0PR04MB6802B863CD9B9AE1609C1785E8EB2@AM0PR04MB6802.eurprd04.prod.outlook.com>
 <20260629023829.152651-1-liem16213@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,gmail.com,oss.nxp.com,lists.linux.dev,pengutronix.de,lists.infradead.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-269612-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:carlos.song@oss.nxp.com,m:andi.shyti@kernel.org,m:biwen.li@nxp.com,m:festevam@gmail.com,m:frank.li@nxp.com,m:frank.li@oss.nxp.com,m:imx@lists.linux.dev,m:kernel@pengutronix.de,m:liem16213@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-i2c@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:o.rempel@pengutronix.de,m:s.hauer@pengutronix.de,m:stable@vger.kernel.org,m:wsa@kernel.org,m:carlos.song@nxp.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[liem16213@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liem16213@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BEB0C6D58B4

In i2c_imx_unreg_slave(), the slave pointer is set to NULL after
disabling interrupts.  However, a pending interrupt might already
have started the hrtimer (i2c_imx_slave_timeout) before the pointer
was cleared.  If the hrtimer fires after i2c_imx->slave is set to
NULL, the timer callback i2c_imx_slave_finish_op() will call
i2c_imx_slave_event() with a NULL slave pointer, which results in a
use-after-free / NULL pointer dereference.

Fix by canceling the hrtimer and waiting for it to complete after
disabling interrupts, before clearing the slave pointer.

Fixes: f7414cd6923f ("i2c: imx: support slave mode for imx I2C driver")
Cc: stable@vger.kernel.org
Acked-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Liem <liem16213@gmail.com>
---
v3 -> v4: No changes, added Acked-by from Carlos Song.
---
 drivers/i2c/busses/i2c-imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 2398c406e913..b1c6581db774 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -960,6 +960,7 @@ static int i2c_imx_unreg_slave(struct i2c_client *client)
 
 	i2c_imx_reset_regs(i2c_imx);
 
+	hrtimer_cancel(&i2c_imx->slave_timer);
 	i2c_imx->slave = NULL;
 
 	/* Suspend */
-- 
2.34.1


