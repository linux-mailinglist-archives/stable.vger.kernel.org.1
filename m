Return-Path: <stable+bounces-256393-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UB1pAXGtGGpolwgAu9opvQ
	(envelope-from <stable+bounces-256393-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:02:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0715FA213
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B62C3298CF2
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEC0358378;
	Thu, 28 May 2026 20:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpyaJpuo"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBC12BE621
	for <stable@vger.kernel.org>; Thu, 28 May 2026 20:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001572; cv=none; b=DBWvnH3PMw26xvBxxXtUY/ffbu2Z/z8fKYHQvxhTKTZPUqohhRa6MC5RGuB4jBtiY9AOIFZN4hZaEej5OoefPRKI35Dy8U+589n96FH2kj1UXg9m5aY8S3IyZSd6h8I8Nfn5fUuavxbUUOyuF70vv4JNPZhOntLmfRRVUAV/KN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001572; c=relaxed/simple;
	bh=5lXklgMxShwBwdT+Aj+Qb2oCq32nbmorVYaWfS1Wg+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bx+8vGybtvWZOlH1/SoZRNXdZZKyDHSIUDHf4XMMk/12LYSSVW+tPxPFyDZVCGxIiwGnqF8/jM4YrbCGp8kBQLcRBv6i8YWAECbbH7z9+i7Sjpm0CR/AHBxBMC9BmWCXKhO+tMkigxONxCwu/HridU6YsDOaqzzCovCtKK4qJvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpyaJpuo; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-441209fb77eso8182077f8f.1
        for <stable@vger.kernel.org>; Thu, 28 May 2026 13:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780001569; x=1780606369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XojjIRDhIyxrDp1Lf41UPx11rtEM/hZDetN38j+qBos=;
        b=BpyaJpuoEQV46HKKD2INzzbc1N463T6OJlkeTiwDtxcyxvbG/PEzliVim5oY7YgLux
         dnSmSrd3MwKOlbLjCMXnJ0j7xrqp4KlLBfBinRHsg/NFJrg03GQ7+uNZPAM4X5zXMri0
         u8dCvC4aVhIhmF/mVN2juI80SXrkkLz4XsDNC98loVrCSjhxoiXuSCTq57fivWEbU4ey
         g3LeOxGjOcvmchFt+KDPv8ZkxAOcptJXh54VZkJGV9sBocwvoljriMLr8+LLdHC297Bc
         aiWPBNLiDTGXfjiDcLXH0+IkrzSJwysB5T/xn9Mh4SMQu6B8YhWBSQwkEu3P5xe1R0hZ
         f8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780001569; x=1780606369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XojjIRDhIyxrDp1Lf41UPx11rtEM/hZDetN38j+qBos=;
        b=ovzY3z6OipGgPh3y54V/S+KAWkf/XRZcJS0dAMVNT+FV33ZIFPQpsmD1VFziD5DCUq
         T7tjWWrsHxLYrpWUvZ/ze+MOxQV+gUne6bZUI+5qh21GJFwhqhkeVVAl3FE0M1PCJk7l
         gTsQtWVZ6mwU4kR3/a97C6tPlCQ+JDUMrowHkav8+RJdQvW7n9HfLbs6Bfw5vnm842ih
         0pIkZ7062Fy6GNhtZ4wOfBKcVh7f2j1Dia23opdu7bn4PPSPOtzOmhGAsvI/diORMgDp
         JFW1FCW5w1f2yqrI4lJngE85ctaWmoTWhkAhk7yuVNLUq4R1gsnG10zHbeXjdaChGBCe
         EcuQ==
X-Forwarded-Encrypted: i=1; AFNElJ8FPdgJmBUe1PSO5wupGB4S5GNUEe3gZ4V2ChiLMkEAnmINSjASSo9a3l+CzKzD9jXz73ylPpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDXrS5GZw62Z+Z17h1OdEkqupoDF42+XH1s9+so732PhAYLy97
	N2yEVJj88olRs4rHe2jkcxhWxvBiTH2bqtaGXGJUld1rK9/hJBL5hqFa
X-Gm-Gg: Acq92OH1x0fe0k5R+CZQFXTBY7OOlNybLEWmQk9w1YxOUUX0TJ7aqtuaCDZExk/Gvx8
	FWrNNbomaE4JJ7vCvG7zpEqHCyiemvTuf7G7wFqpRfgJfxWoIj/h+E3OCT0z1bVDVDJSCB3Vv+f
	qsCkqvrQw/5iqoVyijBxKgpTJQ+wOD8khljdh6iXkSxaKzD8VFx8n640RAvqILsodAb5U/i+nCg
	oi070PV/Ac6yvROFximo5x2ewzelQvXCHpIsWQZko265vsn4bZRBsWlZj6HF2rYNOksiyo8GVgo
	HYuz5cZgu6ClX/hR2YDasUBzZyo7aHkbmnKh33PLsm5h/khtrG1iYVCkFDFrMf6QeI1r2L3x+WV
	l7NAmPPfJoaeZy2m6bQn+SevnHcSSi/9csEEUV2VvHYGkv/GCIGT8Vd4pKAucj7GicoxRoaV7n9
	WHtfDkQ+2WzylkEltZ16piZiglLkvcN0T65RKZ
X-Received: by 2002:a05:6000:200f:b0:45e:89e9:348b with SMTP id ffacd0b85a97d-45ef1339797mr104379f8f.7.1780001568888;
        Thu, 28 May 2026 13:52:48 -0700 (PDT)
Received: from builder ([2001:9e8:f104:6516:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ee5a84e92sm7104028f8f.35.2026.05.28.13.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 13:52:48 -0700 (PDT)
From: Jonas Jelonek <jelonek.jonas@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Simon Horman <horms@kernel.org>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net-next v9 1/3] net: sfp: initialize i2c_block_size at adapter configure time
Date: Thu, 28 May 2026 20:52:40 +0000
Message-ID: <20260528205242.971410-2-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260528205242.971410-1-jelonek.jonas@gmail.com>
References: <20260528205242.971410-1-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-256393-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mork.no,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[jelonekjonas@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8F0715FA213
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sfp->i2c_block_size is only assigned in sfp_sm_mod_probe(), which runs
from the state machine timer after SFP_F_PRESENT has been set. Between
those two points, sfp_module_eeprom() (the ethtool -m callback) gates
only on SFP_F_PRESENT and can be entered with i2c_block_size still at
its kzalloc'd value of 0.

On a pure-I2C adapter, sfp_i2c_read() then issues an i2c_transfer()
with msgs[1].len = 0 inside a loop that subtracts this_len from len
each iteration; on adapters that succeed a zero-length read the loop
never advances, spinning while holding rtnl_lock.

This was previously addressed by initializing i2c_block_size in
sfp_alloc() (commit 813c2dd78618), but the initialization was dropped
when i2c_block_size was split from i2c_max_block_size.

Initialize sfp->i2c_block_size from sfp->i2c_max_block_size in
sfp_i2c_configure(), so the field is valid as soon as the adapter is
known. sfp_sm_mod_probe() still reassigns it on each module insertion
to recover from a per-module clamp to 1 (sfp_id_needs_byte_io).

Fixes: 7662abf4db94 ("net: phy: sfp: Add support for SMBus module access")
Cc: stable@vger.kernel.org
Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
---
 drivers/net/phy/sfp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 7a865f69a6bd..376f7232f9ee 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -824,6 +824,7 @@ static int sfp_i2c_configure(struct sfp *sfp, struct i2c_adapter *i2c)
 		return -EINVAL;
 	}
 
+	sfp->i2c_block_size = sfp->i2c_max_block_size;
 	return 0;
 }
 
-- 
2.51.0


