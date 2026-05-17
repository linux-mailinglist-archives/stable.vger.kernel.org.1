Return-Path: <stable+bounces-249117-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DZtLLrrCWoDvQQAu9opvQ
	(envelope-from <stable+bounces-249117-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 18:24:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F7556240D
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 18:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6607301AA47
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 16:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F79F3C0617;
	Sun, 17 May 2026 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZOgsJOw"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C525F29D291
	for <stable@vger.kernel.org>; Sun, 17 May 2026 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779035048; cv=none; b=juNXpmW2E0mfEwzV2mK3ZCuVs6+jXa7NtqaPpbXvj4CW11msizBiW64cjn1N93qnyd/Zz68UHyFZgQlowqE6jAU/2u6V72GbeqOmcsKKV7k6OQTF5pzfvID5zoI5kLsQmABdh7wVt3fycwj84xgfs5gAm267HQXQJK2RuJQ/6vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779035048; c=relaxed/simple;
	bh=szJiY6EJbu4bYlsozrvbiskziHki0cBuDtsWP1MNp+k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kwl6ImsOUbm3S0Im/aZpZ//BaEOC3Yw2x33rv0q819VbbXvpNg7z+s2i6UXpx9GtyqYB+guyvgIDzwd9AmytXsyH5ICtdtqcdHax5a/XpB9QsdJ4VDvHNUqFnw/f6XK5BG3It4VvaI4oot3zr6LmGjnYuqdvWkmtmnI41J5ORl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZOgsJOw; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-44c44af71f8so204885f8f.1
        for <stable@vger.kernel.org>; Sun, 17 May 2026 09:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779035044; x=1779639844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4xQUzenjZFV6yOOyNJ+dSYEulDJrlac0Nc+paPih8Tk=;
        b=kZOgsJOwmXvQPSNYWHmCr34oTy9ILavNhr5IZDPv5N+W+3rxCys5y5p8EWMeS2uMPJ
         QkgKy8pAhpSkio3CmNAVaBDqX7E0k9GpIfstIvimgYenRB+Cxn+H5yPJ+G1hBdjuMTMP
         iwQLAO2W819MdvjbZIwoJ1CvVbh2HpZWWICXeXi/1rItMcaV1HPjymR3Dpuf1Zer1QpN
         9AIWDpsQDOrWLwKyL+rcwtsAgPSCBVDo7QY5F2bTeqpLr+0E+ODQV2qfttY5Xt5zPb0E
         jMlYUtaZD1/PvhzwaBXswowJyFDFf0PVNtooCoV5IGfyavvQ5SWI5AXPDvN0aZmTVQC4
         kxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779035044; x=1779639844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xQUzenjZFV6yOOyNJ+dSYEulDJrlac0Nc+paPih8Tk=;
        b=XaINqGuXoyl3pd3xkwQP8xA1ZdklxolkqlR2YXFTYoM7vTiWBQpSFbQUQZuEOOaUhH
         CQgoivyjiAN+6aXIFTmvcEeC0INXu7bm5s4tyKBpKIn9/1z7vRhpYm+/1o52l/dAdqkg
         HiNwy4th4JpNc9tY9lAvBnloYtC4pNCooCSILUmDfLHnQvBEAzDKZlY2isxIeG3nPHfY
         dolpgHscE3VGplvRf/GaDee+ndb10HVgyJwAMwzJO5XXbX9XgMdF+/i3COZUDi1mws3I
         UDPBGTeYn5ie5lZetYan6/ER/9UuaOBJCfJe54HQJykcC9oY3rkVuHLIyeLpfSchqLuD
         y6SA==
X-Forwarded-Encrypted: i=1; AFNElJ8tUJtcSLXknwYp2tj7qHCBpJ6tuDSYWw3i+Y0B1poVlJgrq20RIrwAWhBjTcKyeIm3zCvLSj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUfrBFp8MoY7sfkGjDDFAirN/eFiPw++s9wEAOugfEYPKcs3Jg
	+fJtquYeOVuWHyCZdmbMveK6wQvTFDf64DyyzqMse0Ke46Hrf7YDGO1R
X-Gm-Gg: Acq92OHlsO3taRscBsQF2zMnxNkcvXv8o0guLk9hrVO0BQgc9sc8b9ja62xcfzuxnv2
	L+xysaoAvN7wgI2veKJPgXMYdpxQ5OMZ4C69MqOwr1Lkp7YTr+NcPcPMsMTfxPAvXMQRwep0hES
	C3lsHRQbjwrJSZjaT9UL2vlhtu/ZP7gtq3Z07YZkJ4DOWMwj906QHv1L/2YIMjhkhfEP3tHrn0T
	nHbP0VY/HwnSq9D5AVp/b0vR0wgSDpU1wtpaiK/TFQWDxqruS8ItcjuWDLP0T5ix8vdehPL2OgS
	1tfQAu/zK3VZUdKBhBN2PeQKIXS465UjZBYYvKFl3ppyDx/yrSZYMVvN00E8xYsfQrVrXRpepP9
	UqyxlIyV+jbLksV9fR2HEzQfzXqZn6WC2H1jgQLklVUAinUqk0EDZR9gEfSzXbRC2Of3Q07wcnl
	ASMSrfrhTfI6DXF2G0etRjwMgBCyZYOsGlwBWGM2kN1JVv
X-Received: by 2002:a05:6000:1ac7:b0:43e:a978:c25e with SMTP id ffacd0b85a97d-45e5c37d119mr8648504f8f.1.1779035043883;
        Sun, 17 May 2026 09:24:03 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a19c2dsm31481840f8f.21.2026.05.17.09.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 09:24:03 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: daniel.lezcano@linaro.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	gregkh@linuxfoundation.org,
	hcazarim@yahoo.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH] iio: adc: nxp-sar-adc: notify trigger on channel read error in buffer ISR
Date: Sun, 17 May 2026 21:23:46 +0500
Message-Id: <20260517162346.189-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 52F7556240D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-249117-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,baylibre.com,analog.com,kernel.org,linuxfoundation.org,yahoo.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sozdayvek@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

nxp_sar_adc_isr_buffer() bails on the first channel-read failure
without calling iio_trigger_notify_done(), so a single I/O error
leaves the trigger's use_count stuck and the buffer flow wedged
until rebind.

Route the error exit through a 'done:' label that always calls
iio_trigger_notify_done().

Fixes: 4434072a893e ("iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms")
Cc: stable@vger.kernel.org
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/iio/adc/nxp-sar-adc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
index 9d9f2c76b..ed004812c 100644
--- a/drivers/iio/adc/nxp-sar-adc.c
+++ b/drivers/iio/adc/nxp-sar-adc.c
@@ -341,7 +341,7 @@ static void nxp_sar_adc_isr_buffer(struct iio_dev *indio_dev)
 		ret = nxp_sar_adc_read_data(info, info->buffered_chan[i]);
 		if (ret < 0) {
 			nxp_sar_adc_read_notify(info);
-			return;
+			goto done;
 		}
 
 		info->buffer[i] = ret;
@@ -352,6 +352,7 @@ static void nxp_sar_adc_isr_buffer(struct iio_dev *indio_dev)
 	iio_push_to_buffers_with_ts(indio_dev, info->buffer, sizeof(info->buffer),
 				    iio_get_time_ns(indio_dev));
 
+done:
 	iio_trigger_notify_done(indio_dev->trig);
 }
 
-- 
2.43.0


