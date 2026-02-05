Return-Path: <stable+bounces-214486-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APgWLfGvhGk14QMAu9opvQ
	(envelope-from <stable+bounces-214486-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 15:57:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8DCF453B
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 15:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABAEE301A724
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 14:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58E2421883;
	Thu,  5 Feb 2026 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIzYL+tj"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBA741322E
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770303467; cv=none; b=Jo2ny88ruARMuMIVqPq/mYOeNDo+sIc/4OYQHaj8O+g09DtKsUdlD+C3vYQ4iSjDpnYD7WByMIi0YU4sF7T/rsjtX3W49O2Ugj92//RxcXiIGn5kzRye84Zc95Yb/94SiWFp7uUW/NpOnMJG8Cdw7pfkHUADEylHH/R0TCjds/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770303467; c=relaxed/simple;
	bh=mqJ1ieL1d6aAkCqbf5Vu4cEJZ6fZhddRL14J3DjLzok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qSh1f8LsLzELuJMby7A9ibAX9OOsWwhPjFDDHodFHaz9q0veWYHlSZKI4ASOBbhn+lYJVtOkga99ylZS4dsh+C5Ed8BXi2z7W0uYCVy5yYIqQckXtM0L6OKtjkeWosdc2CYHfLTOaUln3kgRxx4c97U8nBCQ+8vlPazXAH1o7ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIzYL+tj; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so11321665e9.2
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 06:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770303465; x=1770908265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+/l1D3HoF3zgIcHFCwzxTOQvuCZS2NTOWIlmojy1gME=;
        b=MIzYL+tjwhunIoNI0tKy3dUupMIzDCQZ505kZiUaajuVjPGivULTSikKfBhjNqYfNv
         0rvxyqOsU2LrfxcNn9a5Mp9H54nDOM5HNibYTOuRwbS3sIYggBQx1Kl4FRINPJ8F5gQo
         eY4aBNxb0mNq3FOBKkbRBXr76yD8Sj5ATK0toZ7s9uVzVruAQWCmdIZAthirlKTwKdpJ
         nsflDt+Fwdbj7uvdYZg4ZXTBkPMt4XpC8a5GHpTJizMz0xGMSHaY75MYIxtlv9XJdCt+
         B2e9En2JlzShcyhM1vIXaFR8kjqWyFy0AySc9U5w2I+PgrzFVpUDxf9tVFCe+h4sVfM6
         P0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770303465; x=1770908265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/l1D3HoF3zgIcHFCwzxTOQvuCZS2NTOWIlmojy1gME=;
        b=CRtM0Z/2fwjZFiqQupW5MFo5IPVR3FFmsOTleqAMTu/Cu7AExdzdMp886PVczHXFrC
         4o4HsMiY+67eIWJx94ojw1Cn4iFdQtYc4Ys9hjz1i62rjK8xlK+MI5Dzattq/gQ/o1oc
         p1YHYJuT3v9CCX7vsckcxlKqKPel0DXWXG4xwR2ExEZtwGmojG9CBfVUEnEoYgnIOop0
         A/tamNqMnSFgni42vz8iRD3QzEKcGFXXWwY9kxpB2aL3mhPAdXSYnhuHRCnPW8gXKfSa
         1D20tyf2hA3qFebact7qvoFXUFxf0SQ3nn+fxF4aHBG58obvsla4aGJZSPlsDW5f4b5j
         JxhA==
X-Forwarded-Encrypted: i=1; AJvYcCUdkVPkE3MQqP664xmzP8TADhR/np1Vk9AsUfNwlCyl5BYq0+0DhOo8cqnRtRiv9cOaZ+SJQLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuJ6VXDtt+gget3soHTi30US6iofdBk6CQqoNrynywt6N/G6Fr
	0TVlQOWkrLdoMI+/RfyCUdTBdFFmdLMO2x3CCvmVSpCBxAySRTfTtuQj
X-Gm-Gg: AZuq6aIaTqp3Frle3jc7rbfHqGTNJaT2EK1KU6nwyorBmtFQxq/AX43abkA7LMXKKcy
	MzeqFdJ4DgqFZp14ZNtToEstdoLflsnE0qodIcz3jDiWzwuuWfHJD+F9w4SA3RrbCDQeWzMznTi
	o2xlB1XbQXvG+Z6RXnVWaB8mXVSmTcY5oSzsm71Ygnw5IFsXPsJS7vH6pcKici2bvVSbMd5zHL9
	fm2JIWbwbdWA12XLfFZS18KhN1EGBseaBo48jkOd+sS+DYqrqxQpQvbtflHS9UNJb71Yg3S+Ps0
	ne3PGpsHlZe3Mv6egcVDpEYNCp22RN7nN9loeE9p3iTkzpYMLY5qbh9VXGTesQiG6sBfSPMPKgS
	L3Mk/p6nf9s+mElEKtSYUYUPN41S/lnwx1MNf7e8En3FPoQkgCGPoW40iwtPewyfJL6Uc4lx2uX
	J6+PvgtYr2ctSPgTzeEpz3BLWgXIIweCx0Sue0dOdfigmWxQ68ulcXfiYa8wDh
X-Received: by 2002:a05:600c:800f:b0:477:af8d:203a with SMTP id 5b1f17b1804b1-4830e9709b4mr91969535e9.27.1770303465056;
        Thu, 05 Feb 2026 06:57:45 -0800 (PST)
Received: from chris-laptop.home.arpa ([2a0e:1d47:c905:1800:63e9:a31e:f6fe:74f8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43618058473sm14464223f8f.22.2026.02.05.06.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 06:57:44 -0800 (PST)
From: Chris Spencer <spencercw@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vassilisamir@gmail.com,
	Chris Spencer <spencercw@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] iio: chemical: bme680: Fix measurement wait duration calculation
Date: Thu,  5 Feb 2026 14:55:45 +0000
Message-ID: <20260205145703.198609-1-spencercw@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-214486-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[spencercw@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0E8DCF453B
X-Rspamd-Action: no action

This function refers to the Bosch BME680 API as the source of the
calculation, but one of the constants does not match the Bosch
implementation. This appears to be a simple transposition of two digits,
resulting in a wait time that is too short. This can cause the following
'device measurement cycle incomplete' check to occasionally fail, returning
EBUSY to user space.

Adjust the constant to match the Bosch implementation and resolve the EBUSY
errors.

Fixes: 4241665e6ea0 ("iio: chemical: bme680: Fix sensor data read operation")
Link: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L521
Signed-off-by: Chris Spencer <spencercw@gmail.com>
Acked-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: stable@vger.kernel.org
---
v2: add Acked-by: Vasileios
v3: revise commit message; add Cc: stable
---
 drivers/iio/chemical/bme680_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 70f81c4a96ba..24e0b59e2fdf 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -613,7 +613,7 @@ static int bme680_wait_for_eoc(struct bme680_data *data)
 	 * + heater duration
 	 */
 	int wait_eoc_us = ((data->oversampling_temp + data->oversampling_press +
-			   data->oversampling_humid) * 1936) + (477 * 4) +
+			   data->oversampling_humid) * 1963) + (477 * 4) +
 			   (477 * 5) + 1000 + (data->heater_dur * 1000);
 
 	fsleep(wait_eoc_us);
-- 
2.43.0


