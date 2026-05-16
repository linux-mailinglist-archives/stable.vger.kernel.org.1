Return-Path: <stable+bounces-249053-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPp4LLb7CGppDgQAu9opvQ
	(envelope-from <stable+bounces-249053-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 01:20:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5586255E418
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 01:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 644FA302FA97
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 23:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545173A6B79;
	Sat, 16 May 2026 23:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="XGRWecXk"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9DF39DBC2
	for <stable@vger.kernel.org>; Sat, 16 May 2026 23:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778973541; cv=none; b=Gjr7R+imP2HBkEJuEnxA29xAtA3CHTW1dyxEwtQTSbip2F3EfVWJer9pos1wUi84gvzOg1fTICpfL+cXWWhpKf0H9NFk8dfeU69MVtnykiwZ4bmqeniQ/aym0Rao1bjpriSOZrrXoD2ZbD48fKY1ZTgtg4vFqbsd1mkhtuwifK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778973541; c=relaxed/simple;
	bh=yxjAXeOD8vgYHpYNi2nRb2U8lGvMYDcyt4MCoMgxNz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uKfp3sDoXDZX0c8VE5zAuDIdhiKa0RUnBOzDKp6oVhbe12191HFOx5ik8jkyjl17ggCu7X3orDTm95h2cxRzfOvLT+KdGZzuG4h4hT60/ChGWPGvboLpRPK/ftY3CRIgnNalBz5gFrg//3t/YRvcELXFI952aw6oX9Bi6cE9d9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=XGRWecXk; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12c1a170a50so1172000c88.0
        for <stable@vger.kernel.org>; Sat, 16 May 2026 16:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1778973538; x=1779578338; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jUnfFsool58oW+sRC5tpMK9MOqrwqv2manCcCe6X7bw=;
        b=XGRWecXkhtobTKZQlG46zaZAm34o3C9AA9gVr2yB0uDviFi4xxbnHQtsTFstT6xMi6
         YSnH2wTfJBT7cwFQaggRfl9RFopXStbHXByPoNN3A6pedzqzHfdKAryxcnCJZewe4A+X
         FtcVCQNVPXdYeIAWLM0MqKWaPGziopTZjIn1qaiU/gJrGr1iQrXOrd2luXzZ2PKs7UhE
         Lbcs2Y2FAF4VX3RVSHU5/0WQ2a+8nI+QDMs+kPRRWfaRCaQ9OPH8HD17iZamCP4Ft/Lu
         KHNgSzUC2fHSt53LNwqjNEsWXxbm+ySEzW7+imWPTTUdHjrQdUN5Ozl0b1M06DIEcAQR
         MV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778973538; x=1779578338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jUnfFsool58oW+sRC5tpMK9MOqrwqv2manCcCe6X7bw=;
        b=l2uRov60CtmJK4NJPpNH2//lEnDwY06B1C0iVZRilSlkXw/cEndxLUdHpWH5Frd7nz
         NKcb8Jzy3pvaAOX2i5JmWCAETYwdMRsOtux7eEe7XfjhqIHHj8gLYWi19lHpeeJTNf0f
         x9tnk17alcP1FwtwkwugslxZVXCJ8Fr04k+98Zpv22sHWaEnVeQgBM/iSGSP3nBZSc9t
         rhdKJu0VPUGJJ4lWCIuNE/cugeRdSROqzPdY1zMLanPAj84d6j8jFDENGlOdo1rBxQXP
         PLies1V6tqfJGque09bPMosJ88VpocqTv+6HzeGvHKGwPTcUGPn+zmKGvt8FVRkmqJEk
         YcnA==
X-Forwarded-Encrypted: i=1; AFNElJ8pZuLOFP8o8jB3JDSNfmo+Fcyi1OBlWYpFsOFBHbCNxtFyBbWx8/3m52Mw1ghkNbqxG6BomRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvbfK/59YTnRNYafs5I5v3rL1Ao9WHjQPapiFcIrxx/dmsvJik
	+wUaGFjJfUC9W3ZsDZhussnX2434dGJe5zqhLAkEeaWjIwRCzLlalzuVKKjiPgiRW2A=
X-Gm-Gg: Acq92OGevm/QaXepS3yJXXvipw05dlHzh5bW+/AT5RMxewvSNxETeq7sSILXZFNmCdg
	MCF/AgvkEqX0O3Y6lbzFyorR/l/koyBsBhO6IWCdgGQ/PKbCd1aMesS4swGAKFl3ScVIpx/A6Nd
	jQhTF5p5z/hW6/+pFDIoVeM69XNsZobzt0S9sw9ckIS+j9ux40RwWvivFNjhTf72PkZCIbcaqe7
	daqk8bUnRMHrLJV0LtZSmZyGmI4v7NiqsJwTbrdSUVWfV5Hpxd7je/CMdjm+srmgyCs5ps3P02J
	OSzYu4+uPdH1YsxqzY1u69AMP1EqzYLL0ulNbEaAnTPwGHfyVArWLLzeTEc6MDZnHfw4A9Nqe/m
	n77qrYvOFNkGRytLw7+8eEDbxRMp/eESKhKNu4wYboI8aQOQm5OpWCLdSBrNNs/IiWN9F3SezKc
	c62oDs22ipB8FxB/CfP2NYLrj2TzqMw7g6r+fP
X-Received: by 2002:a05:7022:6621:b0:134:a710:d908 with SMTP id a92af1059eb24-1350451887emr3707639c88.13.1778973538361;
        Sat, 16 May 2026 16:18:58 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb9ef5sm14722254c88.2.2026.05.16.16.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 16:18:58 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Sat, 16 May 2026 16:18:50 -0700
Subject: [PATCH v2 4/5] hwmon: (pmbus/adm1266) register the gpio_chip after
 pmbus_do_probe()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-adm1266-gpio-fixes-v2-4-801f13debcb2@nexthop.ai>
References: <20260516-adm1266-gpio-fixes-v2-0-801f13debcb2@nexthop.ai>
In-Reply-To: <20260516-adm1266-gpio-fixes-v2-0-801f13debcb2@nexthop.ai>
To: Guenter Roeck <linux@roeck-us.net>, 
 Alexandru Tachici <alexandru.tachici@analog.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778973534; l=1739;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=yxjAXeOD8vgYHpYNi2nRb2U8lGvMYDcyt4MCoMgxNz8=;
 b=WTiOWdWghEIO6M71PDijdRA0E0SWlC77JtKTutsFSXf2+p8yo3CIbVwylMBta2u5GORRt7VpR
 WfxCxYPFXsSAF4CAqveVJLuBo0aBnPgglLTy0Y4rYcbslUwj/KD/i+d
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=
X-Rspamd-Queue-Id: 5586255E418
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nexthop.ai,none];
	R_DKIM_ALLOW(-0.20)[nexthop.ai:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nexthop.ai:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249053-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abdurrahman@nexthop.ai,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nexthop.ai:email,nexthop.ai:mid,nexthop.ai:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

adm1266_probe() calls adm1266_config_gpio() -- which goes on to
devm_gpiochip_add_data() and exposes the gpio_chip callbacks to
gpiolib -- before pmbus_do_probe() has initialised the per-client
PMBus state (notably the pmbus_lock mutex the core hands out via
pmbus_get_data()).

That ordering is already a latent hazard: any GPIO access that lands
between adm1266_config_gpio() and the end of pmbus_do_probe() (for
example a sysfs read from a user space agent that opens the gpiochip
the instant gpiolib advertises it) races pmbus_do_probe()'s own
device accesses with no serialisation.

Move adm1266_config_gpio() down past pmbus_do_probe() so the chip
isn't reachable from userspace until the PMBus state it depends on
is fully initialised.

Fixes: d98dfad35c38 ("hwmon: (pmbus/adm1266) Add support for GPIOs")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/hwmon/pmbus/adm1266.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index 57cb7d302cdd..b91dcf067fa6 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -467,10 +467,6 @@ static int adm1266_probe(struct i2c_client *client)
 	crc8_populate_msb(pmbus_crc_table, 0x7);
 	mutex_init(&data->buf_mutex);
 
-	ret = adm1266_config_gpio(data);
-	if (ret < 0)
-		return ret;
-
 	ret = adm1266_set_rtc(data);
 	if (ret < 0)
 		return ret;
@@ -483,6 +479,10 @@ static int adm1266_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	ret = adm1266_config_gpio(data);
+	if (ret < 0)
+		return ret;
+
 	adm1266_init_debugfs(data);
 
 	return 0;

-- 
2.53.0


