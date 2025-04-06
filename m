Return-Path: <stable+bounces-128426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D02DCA7D0EC
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 00:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0903A62D6
	for <lists+stable@lfdr.de>; Sun,  6 Apr 2025 22:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A2D221717;
	Sun,  6 Apr 2025 22:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8CGobum"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9849B2206B5;
	Sun,  6 Apr 2025 22:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743977704; cv=none; b=AFd3geGxjwXxHUB0vdpjVGmEsVNDtBepDHJI3JsaIbBWnAcnfuQJANMmpb4CjqIkBDWYP8qtwMzemp4FLVoos7GmlPrJkBR63Wv7VbdwHK68qKJVcjF0pQOXdLXpaAm4i5X1NEeCcrDo+HMBdk1p6dgTTEmwYaMLvpelrFV8LtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743977704; c=relaxed/simple;
	bh=N43iJ8uAfLkUfdoT0DoDo+1pyWvAHJsldz/CgAIRBGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c4IWJL2bOcFIDjkcsFzAZNG3tiJ9fFz859cyd9Igxx2d8sjUKZhQatkitE8tsiZT0BVuCur37ZVy4egKjsNAQXMd3f9mc/URHQLVgBj9sNJu13ML+wVCKFoi4ebpRyrnR2Eji585CCRU0TV1Q9Ms5bVLu0G7PAmvTp6sLHbnh1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8CGobum; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so31146485e9.1;
        Sun, 06 Apr 2025 15:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743977701; x=1744582501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbjlynKWg/4l7XREwNXFX/8RA/bU/RRJTqy0Jin3hBE=;
        b=Z8CGobumrQDIJ42dnVLWMZ5G4qHDhEeK59IlzKRqTmsw68MfJJT8zJ2IbxkWKNio/4
         gIYk+mPLgJET1KOcXpf35EZDCjA+WX3wBuduxWA9rczrWF5kr9VxoJPQm1orpi61uSjO
         40a+SNOKO+LjA+ttj4KBOh0fA2ThjFeMCMegGQN5niCye7VV535IX1ImQsAbr1+L3yVl
         DfD01eoaH3LjIDHz6e4Fg5j8wc+A/mx5ZRsaw/JKPaEhvITeL/UfxxxKrtSDw2i2iu8U
         GKqnrY35/DM1QxT7li3QLBxpjY2ZW26QKxvCKNh/419UCKfMQWJFYEbSQ77ItFPuOfyZ
         z2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743977701; x=1744582501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fbjlynKWg/4l7XREwNXFX/8RA/bU/RRJTqy0Jin3hBE=;
        b=TRf7ZS9Gb5LmLoSlOQEapaOPYM62q5kUEwzvSBHKLV+YObwpxYJizUJWI16tMWczWl
         gS/gVVp2/hpdaYWXVEcT+C2Db080HeI31hig3VRHm2RIv3N6LKf/Mlz2aNyvuXAuZBEo
         DEhiyQOC9WSQOFWPnRwxtzrdZptv0Bwm/Iy6x6vfXvR/EVyse5/0hWMmUDhWeZtscaYw
         Z4f8XtHKmvVBleWqUTBPtCvKmXaOYh1pP6enSt9UA2ZpWYpRqRUlrMmaG3zatVe9yhyn
         4qR2PVGnDdoJXvysIM0IocuolSY6D2SmNVVwnMvuvbf0+LUk8geF4J0YK7Wx/Fe+r/+f
         WXog==
X-Forwarded-Encrypted: i=1; AJvYcCUgDzR1UR2ns+w82m/fbkbTEzuQkUttK9mWmM/s5FgwGESWYvY+hn0R/L33EqFYryk42GgEes5O+lj0@vger.kernel.org, AJvYcCW6vYP6Sg8Psgx2FEYWtYPY7MZoduvJGPoK0aEq4LqWTbLCsjAfbX3MnOKJ1UcpP6+2byTQr0fPic4SpRfk@vger.kernel.org, AJvYcCWh2w4L4Y06Vf0xR+MvF4c2gLuGCTrpwaHqnb/Fp+6Wjy9GHI6scJ013fBbAamUxcnCEybC9zR1@vger.kernel.org
X-Gm-Message-State: AOJu0YxOI0Sqcj4HQ3mo4sXtEhS2yo6k6h/ALvf8i6dB3OG53tmegu8R
	zjwwcfQQoc7bqvtAMg5buSCiSuxWOgnIC0k4nDgZUec1kRPy1lqD3fAVVg==
X-Gm-Gg: ASbGncsTM0um2BjiyWPTJxSClvPDQpGNfVf4zdJZ62iWrcKcTLu8oB9xSt3Msu73N0N
	2irMk0GxJAFALWy6WknRnqv11aG+rwK5nzkjifAzZw4YKkoTPytQPdC51YUjBuHpoA0s1huL43/
	BgjwCNI4+F9h4Ds7XdsosMl5k7dQigHXOVV6puk25G9ha54r+IOXSbxDKCfqL/38Fvio9f3yrft
	lTebsF/0IxKlVFRpBjclbUtOm964WdwRCrP1hNyPwEd4ZGosXgm2Cd10JjY3FMCsIZKFlM9HwyQ
	V5Gg5Hy8S5kxyxyTrWI1F3hp75b9/pFwW0+8DPYFkLS8sqX9JC78MfhwQjOygCXohzgGrlma4xd
	SVQ2mzZcaPiU0pQ==
X-Google-Smtp-Source: AGHT+IEdcsmazJ3h4gV5FB1N2QFgWw4lBR8V7yh2Q970uDPmQsNJz+c+C9tAeyVOD9FOQdxcIx726Q==
X-Received: by 2002:a05:600c:190b:b0:43d:fa5f:7d04 with SMTP id 5b1f17b1804b1-43ebf017220mr153587975e9.16.1743977700662;
        Sun, 06 Apr 2025 15:15:00 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43ec366aa29sm111517055e9.39.2025.04.06.15.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 15:15:00 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	"Lei Wei (QUIC)" <quic_leiwei@quicinc.com>
Cc: stable@vger.kernel.org
Subject: [RFC PATCH net-next v2 01/11] net: phylink: fix possible circular locking dep with config in-band
Date: Mon,  7 Apr 2025 00:13:54 +0200
Message-ID: <20250406221423.9723-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250406221423.9723-1-ansuelsmth@gmail.com>
References: <20250406221423.9723-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Debug lock detection revealed a possible circular locking dependency between
phylink_major_config() and phylink_bringup_phy().

This was introduced by the addition of phy_config_inband(), which acquires
the phydev lock. This made the locking order in phylink_bringup_phy()
inconsistent, as it acquires the phydev lock before phylink's state_mutex.

A deadlock can occur when phylink_major_config() is called from
phylink_resolve(), where the state_mutex is taken first and then the phydev
lock. This is the reverse of the order used in phylink_bringup_phy().

To avoid this circular dependency, change the locking order in
phylink_bringup_phy() to match the pattern used in phylink_resolve(): take
state_mutex first, then the phydev lock.

A sample lockdep warning is included below for reference:

[  147.749178]
[  147.750682] ======================================================
[  147.756850] WARNING: possible circular locking dependency detected
[  147.763019] 6.14.0-next-20250404+ #0 Tainted: G           O
[  147.769189] ------------------------------------------------------
[  147.775356] kworker/u16:0/12 is trying to acquire lock:
[  147.780571] ffffff80ce9bcf08 (&dev->lock#2){+.+.}-{4:4}, at: phy_config_inband+0x44/0x90
[  147.788672]
[  147.788672] but task is already holding lock:
[  147.794492] ffffff80c0dfbda0 (&pl->state_mutex){+.+.}-{4:4}, at: phylink_resolve+0x2c/0x6a8
[  147.802840]
[  147.802840] which lock already depends on the new lock.
[  147.802840]
[  147.811002]
[  147.811002] the existing dependency chain (in reverse order) is:
[  147.818472]
[  147.818472] -> #1 (&pl->state_mutex){+.+.}-{4:4}:
[  147.824647]        __mutex_lock+0x90/0x924
[  147.828738]        mutex_lock_nested+0x20/0x28
[  147.833173]        phylink_bringup_phy+0x210/0x700
[  147.837954]        phylink_fwnode_phy_connect+0xe0/0x124
[  147.843256]        phylink_of_phy_connect+0x18/0x20
[  147.848124]        dsa_user_create+0x210/0x414
[  147.852561]        dsa_port_setup+0xd4/0x14c
[  147.856823]        dsa_register_switch+0xbb0/0xe40
[  147.861605]        mt7988_probe+0xf8/0x140
[  147.865694]        platform_probe+0x64/0xbc
[  147.869869]        really_probe+0xbc/0x388
[  147.873955]        __driver_probe_device+0x78/0x154
[  147.878823]        driver_probe_device+0x3c/0xd4
[  147.883430]        __device_attach_driver+0xb0/0x144
[  147.888383]        bus_for_each_drv+0x6c/0xb0
[  147.892732]        __device_attach+0x9c/0x19c
[  147.897078]        device_initial_probe+0x10/0x18
[  147.901771]        bus_probe_device+0xa8/0xac
[  147.906118]        deferred_probe_work_func+0xb8/0x118
[  147.911245]        process_one_work+0x224/0x610
[  147.915769]        worker_thread+0x1b8/0x35c
[  147.920029]        kthread+0x11c/0x1e8
[  147.923769]        ret_from_fork+0x10/0x20
[  147.927857]
[  147.927857] -> #0 (&dev->lock#2){+.+.}-{4:4}:
[  147.933686]        __lock_acquire+0x12b8/0x1ff0
[  147.938209]        lock_acquire+0xf4/0x2d8
[  147.942295]        __mutex_lock+0x90/0x924
[  147.946383]        mutex_lock_nested+0x20/0x28
[  147.950817]        phy_config_inband+0x44/0x90
[  147.955252]        phylink_major_config+0x684/0xa64
[  147.960120]        phylink_resolve+0x24c/0x6a8
[  147.964554]        process_one_work+0x224/0x610
[  147.969075]        worker_thread+0x1b8/0x35c
[  147.973335]        kthread+0x11c/0x1e8
[  147.977075]        ret_from_fork+0x10/0x20
[  147.981162]
[  147.981162] other info that might help us debug this:
[  147.981162]
[  147.989150]  Possible unsafe locking scenario:
[  147.989150]
[  147.995056]        CPU0                    CPU1
[  147.999575]        ----                    ----
[  148.004094]   lock(&pl->state_mutex);
[  148.007748]                                lock(&dev->lock#2);
[  148.013572]                                lock(&pl->state_mutex);
[  148.019742]   lock(&dev->lock#2);
[  148.023051]
[  148.023051]  *** DEADLOCK ***
[  148.023051]
[  148.028958] 3 locks held by kworker/u16:0/12:
[  148.033304]  #0: ffffff80c0011d48 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work+0x1a8/0x610
[  148.044082]  #1: ffffffc081ca3dd8 ((work_completion)(&pl->resolve)){+.+.}-{0:0}, at: process_one_work+0x1d0/0x610
[  148.054338]  #2: ffffff80c0dfbda0 (&pl->state_mutex){+.+.}-{4:4}, at: phylink_resolve+0x2c/0x6a8
[  148.063119]
[  148.063119] stack backtrace:
[  148.067465] CPU: 3 UID: 0 PID: 12 Comm: kworker/u16:0 Tainted: G           O        6.14.0-next-20250404+ #0 NONE
[  148.067472] Tainted: [O]=OOT_MODULE
[  148.067474] Hardware name: Bananapi BPI-R4 2.5GE PoE (DT)
[  148.067476] Workqueue: events_power_efficient phylink_resolve
[  148.067482] Call trace:
[  148.067484]  show_stack+0x14/0x1c (C)
[  148.067492]  dump_stack_lvl+0x84/0xc0
[  148.067497]  dump_stack+0x14/0x1c
[  148.067500]  print_circular_bug+0x330/0x43c
[  148.067505]  check_noncircular+0x124/0x134
[  148.067508]  __lock_acquire+0x12b8/0x1ff0
[  148.067512]  lock_acquire+0xf4/0x2d8
[  148.067516]  __mutex_lock+0x90/0x924
[  148.067521]  mutex_lock_nested+0x20/0x28
[  148.067527]  phy_config_inband+0x44/0x90
[  148.067531]  phylink_major_config+0x684/0xa64
[  148.067535]  phylink_resolve+0x24c/0x6a8
[  148.067539]  process_one_work+0x224/0x610
[  148.067544]  worker_thread+0x1b8/0x35c
[  148.067548]  kthread+0x11c/0x1e8
[  148.067552]  ret_from_fork+0x10/0x20

Cc: stable@vger.kernel.org
Fixes: 5fd0f1a02e75 ("net: phylink: add negotiation of in-band capabilities")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phylink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 69ca765485db..4a1edf19dfad 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2072,8 +2072,8 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 		     dev_name(&phy->mdio.dev), phy->drv->name, irq_str);
 	kfree(irq_str);
 
-	mutex_lock(&phy->lock);
 	mutex_lock(&pl->state_mutex);
+	mutex_lock(&phy->lock);
 	pl->phydev = phy;
 	pl->phy_state.interface = interface;
 	pl->phy_state.pause = MLO_PAUSE_NONE;
@@ -2115,8 +2115,8 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 		phy_disable_eee(phy);
 	}
 
-	mutex_unlock(&pl->state_mutex);
 	mutex_unlock(&phy->lock);
+	mutex_unlock(&pl->state_mutex);
 
 	phylink_dbg(pl,
 		    "phy: %s setting supported %*pb advertising %*pb\n",
-- 
2.48.1


