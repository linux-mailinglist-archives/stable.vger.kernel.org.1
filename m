Return-Path: <stable+bounces-217301-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNqsLljWlWlLVQIAu9opvQ
	(envelope-from <stable+bounces-217301-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 16:10:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5445F157503
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 16:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBBC2301A91F
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 15:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5F433F398;
	Wed, 18 Feb 2026 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfWitjns"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EC132ED55
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771427395; cv=none; b=XfrCj9Veiv4u8CIHaUmNnGk7xWKXOdSiRjNFx3wgacJwslgMyr8IiPjyB42dmoDc/pGMeyMgw+P3BzWIUY1LaxDMTtVHBSQ4bzfFNy/443umiemr2Lg9+ra6IzR3kF5unoPavvB5N3q/fXPcKsEWeoOOKAjch2oRZ1p/6Ylk5wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771427395; c=relaxed/simple;
	bh=d0C2EuuXownzQl6U6rFAHJMKSwZtCyEBVouZSQ+2XTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ObIQjkpWHzZls3hbOaIh3wghiTgzoFz9BEb8eI7pOBVFQbXwPf6GvTLDf+Qwab5bjwzaLMeqpDj3gKYWkVA6HSA2V/aXp6iigYBEthmHVseQWI4vLW6ysU2Zai4iAp4KtuzZOpF9tgIzqPrAsPZ/OOnFV1ssYPBbIdxqPhaEfLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfWitjns; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-435f177a8f7so5824843f8f.1
        for <stable@vger.kernel.org>; Wed, 18 Feb 2026 07:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771427393; x=1772032193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiGM3saLexQq7QJjFVEPfTJjnwZ/SSpdBYTl//BH56U=;
        b=bfWitjns0o6B9UUPYCzQ4EUjDwuuTCG8P369VfstxdAi1M7tkT8h2S+grY6EyERYjC
         2WiZ8CWNZgBlFI7wZbnc6yN+iPuqc9ux3qpNR2gFRrm9lNotXCfWCxu10XdCkOrJqk+8
         SV0BX+4ovK1e4c7uQf32TFcXwylLiS1+GmGLoyDSwm3guT1VdDuFsbogSzVLFe74I7Sy
         86w3ZV+xex0vTC4KCxSMliG4bHaUV0GXsw3nLRwZO9N3AMlJWEFOoLCQ527KrdGY+sse
         NW7MduVyThJW8EXOHmptr3nP0RaOLe5GezM0D7OWo6FixcTQHa8/BHiL3w64v80juBEp
         ycMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771427393; x=1772032193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DiGM3saLexQq7QJjFVEPfTJjnwZ/SSpdBYTl//BH56U=;
        b=dChStt15QQZoEsDlJgh2wuWdPU5niEqdFlmvDTrtsyu/1E9dtVqTb99RfrFdWtGQZu
         R7709mWg4e+G/UR+S6Rh4xrEwwvRsARQi8kjnbg0HKu2ofjZZoPp10z//OPX2orIKD3y
         n6q6vgbrmAV/sRyiB0pvO1F9sf9jJ/2ZxcU5x3XTHkiT5VlpfAq/EAXVaD5OAbJdV85o
         Wnc7+G864jkDhTrAsfIu0kQM45zOBmrUaev1AWqa99YzxDTzNEmKO6zrglhYIP10daqv
         +6D/C8XGUhLBVn8MJ+/LOS7g+clgPLYYMbm01ijK9Xn31KnBXpZITNydx7UO3RsYzo4X
         BbZA==
X-Forwarded-Encrypted: i=1; AJvYcCVMHnWHCq4uBKUTMQPpPxVS1KBkaTup9k1dE9kgIyPwpFyHW6o2/Wamltt+2VcQB5Yyl9HG5KU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1OfPVPfn86CwRqHQOcGT2HaLitdjVmqHhceI+OornYE8Nh01z
	Ds/b0h9YLuSCjr6rCDPFRFV1mTa9n07TQJUAqE6Y4X/QnzX16cw3y1af
X-Gm-Gg: AZuq6aLKKIESmyP8HhzI3AwHNnozTt98xnrpbulylzBGI7xRMj5czt2G3DJSkfWZK7k
	RolL3+WRbrNcTyVI8wuJStvbqerlMHZViCARItxVmGvOGpyWpCQrniBmzpsdU0hn3T5IsS2eKUC
	tlNj0BrvGOX3IZk58kQmdsg1SAiDVH/rnBVmPWusaXcQeM++DJCEJKHj+1E2vW+PRv44/KSYhca
	vKaeExRBvu+4YTHrth/k3e4hexea4MdQbpIp3Qg4C7VGgvEc7ROVRz0O+Oo2zXkC0GDTYhA8Pk6
	mpizN2jQq4O7dsrd6ieFXLOlZrPjH8/9hzx6GAOdtLrBFqP6g3CDAeVMCYqsiD860+3I+nmHYOP
	eMOEa2JN+SXdHAGNlD4F1Sggb9qlvK3sdJf1709K6YlTbIX5mwSFSjuO7CA0xYnZIrzDdgvVMI+
	xDeiYmnwBayxSHIpTeaE34pvqptDsw3bvwV1KfgIdfXeoh6jARaFTfbgP7PJlJcpbFL3oHnF3Qa
	2m/a99+HHUvXccPOLuxFCdkB4jWWNYhQ4A6
X-Received: by 2002:a5d:5f93:0:b0:435:e060:8071 with SMTP id ffacd0b85a97d-4379db61767mr23486335f8f.16.1771427392709;
        Wed, 18 Feb 2026 07:09:52 -0800 (PST)
Received: from eichest-laptop.corp.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac7d91sm44333116f8f.26.2026.02.18.07.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 07:09:52 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: o.rempel@pengutronix.de,
	kernel@pengutronix.de,
	andi.shyti@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	stefan.eichenberger@toradex.com,
	francesco.dolcini@toradex.com
Cc: linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1 1/2] i2c: imx: fix i2c issue when reading multiple messages
Date: Wed, 18 Feb 2026 16:08:49 +0100
Message-ID: <20260218150940.131354-2-eichest@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260218150940.131354-1-eichest@gmail.com>
References: <20260218150940.131354-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com,toradex.com];
	TAGGED_FROM(0.00)[bounces-217301-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eichest@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,toradex.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5445F157503
X-Rspamd-Action: no action

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

When reading multiple messages, meaning a repeated start is required,
polling the bus busy bit must be avoided. This must only be done for
the last message. Otherwise, the driver will timeout.

Here an example of such a sequence that fails with an error:
i2ctransfer -y -a 0 w1@0x00 0x02 r1 w1@0x00 0x02 r1
Error: Sending messages failed: Connection timed out

Fixes: 5f5c2d4579ca ("i2c: imx: prevent rescheduling in non dma mode")
Cc: <stable@vger.kernel.org> # v6.13+
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 drivers/i2c/busses/i2c-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 85f554044cf1e..56e2a14495a9a 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1522,7 +1522,7 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs,
 		dev_err(&i2c_imx->adapter.dev, "<%s> read timedout\n", __func__);
 		return -ETIMEDOUT;
 	}
-	if (!i2c_imx->stopped)
+	if (i2c_imx->is_lastmsg && !i2c_imx->stopped)
 		return i2c_imx_bus_busy(i2c_imx, 0, false);
 
 	return 0;
-- 
2.51.0


