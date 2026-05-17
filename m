Return-Path: <stable+bounces-249119-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wH1SKY3tCWp6vQQAu9opvQ
	(envelope-from <stable+bounces-249119-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 18:32:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E44C562460
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 18:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A435730214C4
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 16:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26A93B960B;
	Sun, 17 May 2026 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaQFLwol"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28571328610
	for <stable@vger.kernel.org>; Sun, 17 May 2026 16:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779035488; cv=none; b=oLgG3rerZ/wWJTuAkTmxl+bWzr/ok5JTFipgkWtJTr/xVSfLwuPpXkCZYCU6i5Jp56qrI5PluR9nfmB/7Wd75RLrN0e/bSigXOtJftjv6pRgyS1T7JzruwlMsxr28+LXFCCU5hWNhfTBdVWtmtwIqz2uy/8roCc/FjHwLc8x0/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779035488; c=relaxed/simple;
	bh=szJiY6EJbu4bYlsozrvbiskziHki0cBuDtsWP1MNp+k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h8PQ5SJpqi4pYyEwaWf1wCSgZkQCbvnEjgjqY6uzc5qNglbHJTeaGHLgP5coIUiW5sjHRpJCBMxiWRZ8ZRjkG57X46B8dmSJE4gLc2y0h9nlv0/IXkIJTdmIAF4KNhVA28iAEjV6A7IUzCGeW7lt7P2uhUn787nttqcG4SrOqko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TaQFLwol; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48fe7a40e51so1467275e9.0
        for <stable@vger.kernel.org>; Sun, 17 May 2026 09:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779035485; x=1779640285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4xQUzenjZFV6yOOyNJ+dSYEulDJrlac0Nc+paPih8Tk=;
        b=TaQFLwolWi+EiI2hOJHA6sDEce2GXoV5lhaEvRMh4msYQoliiMjxtG7R3u+0wwmc4b
         hQQdNNWAR5xrt9lbN3bGrCswcQeUG0rI1fEc3ilRPQrn4hDKfchazez4JGuo1aHbPOaA
         WXRPR7Ea8xTvijbfjT7Y9TL8pW4uPaQ2R2lQVF+t3iVban0Cm2foxC/f3kTOEJuNWGDP
         TT+MrAVag3ggrA39O8pzLl4SbVKlwyorbiB/lNRp5KeLIE5rM0OrC8lJFs3zFG8kuxhy
         ac+NBbZEgPhOiQAGuknpDoIRjGn1fkpvdgNkZFsnJgsqh2NmFhqt+FYAGvGcaYG5D01p
         085w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779035485; x=1779640285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xQUzenjZFV6yOOyNJ+dSYEulDJrlac0Nc+paPih8Tk=;
        b=HFScsTzT0cPdO+uWK1SXZ6ThBdcX975u+95fv+wWfVCnRyMvpbs/VotMm5kk6Cueea
         R6xIFfWmj78IdkLMPc4dDtdwfLeUmcOPPVKV0TS4diJ/TAmtZJU3FZg4oybSmOG3H2Ha
         ifUEXEafj3/Mh4OdekdunFe44qGCd0HYtyfD+IlnRR+f0G2PMK+La0q4eFnTSW2J2ncv
         WV2Htt3pu6++uECqV2BY1wRE75Df0vg17+v5Rhjbo8v9vw7whO05TzUIVdQ9ppJRJgx8
         zIHHN47YdtDLZ/lQJtozUxe6qhq5pimRJKuTBEOuA5OWHpZ2KAy7n6jgH3LBu6jQhpzn
         i1rQ==
X-Forwarded-Encrypted: i=1; AFNElJ+jwUqPF+8qzT9+jVpCCHztM0KKgnsRoPDvG21HC579fz1XePjUYwJ9y6cvAhupKReznxA8pfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZUVVx67DJhDBTpbeZEvm90RER/4yBuHRu3Vmoe/wpYnkqbBsh
	fIv7p8HxwYnx8QvCSlLZbkMqMk+djm/xht0Huf2r8XawB5R7j+iCo5Q5
X-Gm-Gg: Acq92OFZ9sI/GyRQgj4Fsr/7dsDbxOGBQm9RiDho+3XMWTB7Gyz36uXx9Lj2YLgASle
	t0OpPCK0jXdAmzh87ckCGMCs5TJglRQNAPf8qyRY6AS59uwV2FJHxY6g3v9bDP6lHaZkANMuZ06
	FeQMg8uitW7HwpzhaktMnbDTcLpM3UBWxZeieLpOVvT2WjhQhH7ot9tnV3UOza9FGtu8XAb5yAf
	hDtAQxyFoRt6rWtSfrwi3HX8GLvQFbJJS+mG48dhY/zdTYRwAR9TK8OWQzVt7lj2Ws9ImWGN9AR
	K2aoq0HruBHsdyRU9lnNQk2IPlNCcrdDdguLs+MSy7yA5hVT/FA4g/Zz/0ZeJTGajLvQBGRlKAL
	SsDbKe8hvdYmKRXmvk91u1QSAW/7pO5lFanrjm5Nl1KK8aO3vo4Q3bIbYEojL8z8ik0USfQ6Anb
	/sZXIWwpj9ncxcs0Ncv/pdE+vcF+G9q0a9fwzG56Is4osj
X-Received: by 2002:a05:600c:4692:b0:48f:d410:6072 with SMTP id 5b1f17b1804b1-48fe6302a9fmr95205945e9.6.1779035485464;
        Sun, 17 May 2026 09:31:25 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a6449sm30401983f8f.37.2026.05.17.09.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 09:31:24 -0700 (PDT)
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
Date: Sun, 17 May 2026 21:31:11 +0500
Message-Id: <20260517163111.469-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4E44C562460
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-249119-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,baylibre.com,analog.com,kernel.org,linuxfoundation.org,yahoo.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sozdayvek@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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


