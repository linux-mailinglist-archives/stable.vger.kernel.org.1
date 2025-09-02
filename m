Return-Path: <stable+bounces-176940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3722FB3F6DA
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 09:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBEC148389A
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 07:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08E82E6CD4;
	Tue,  2 Sep 2025 07:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFKWLtTT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FC5BA4A;
	Tue,  2 Sep 2025 07:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756799050; cv=none; b=GRDw+/s8ajvVMXrgYpPNFgZz/+nS231xSITjGSFsn+L1DbGS+ePI4LWX0HNRD3KQvPRtgimD9FWs1PvZhzd04H727qo7mY3x59XoVCz+k3LJnoHvnqbOK0pzTbjRd2lOE7cCXh8VnbpmasYG+UAyCauRREUi+pSTUFfrgNKwo2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756799050; c=relaxed/simple;
	bh=rGefaYqmIgAIRC+qqJ+WkMpoVJ9r8/a0zi/BXHNfY0M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CoKxkqiSs/2t67+3zFkSLOPVps/TQXFAl3EVEv3c5URjr94R3/HbzwmRGDALdBdce2hUD3kLl856AMNJsjpqzxPiUU67lpBAdgSAcb6gkYPQ/N76uTNz+91iKDhZwtNNksYKWqrkGTKV/tksskYg0GOZ9ve3evOeQ9DUZc+lzZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFKWLtTT; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32753ef4e33so3728672a91.0;
        Tue, 02 Sep 2025 00:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756799048; x=1757403848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FM7MmdamHY0R7vTb4cIphiGo5yn+8kPhrgUcTHLwJT4=;
        b=OFKWLtTTUkh9NIMKc2wsm6E8C9hcySzTu3eGC17RqqdqEMQXMco1BnZeAyHFaF9zkG
         NVXzOihwXsCbE0ASP+J33N5j3TDo3g4jBOE4I80Niy2s2adaAlYf7k5s8LLEEtpSJJF9
         iwb7uiaJ12sXnkp5ijIWYrnU6YjyZhnFBPUNlCCcDs9MhMMRsKzisA1bi1lwSjYEu6Fz
         PmFPgxNmYmI6kfr0JySCq659/NZhoWFXs4gB7ej0yOJx2YSRrxsnENjTQpaf3H1uSzS1
         8tgqts/VSNKziFbgB3jtCdFaELjzuHe28i5CJV1qxo+ct77/5pHSJrepKHO09xNZipLX
         wdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756799048; x=1757403848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FM7MmdamHY0R7vTb4cIphiGo5yn+8kPhrgUcTHLwJT4=;
        b=RmFz7dU7c7RYBKH41jivVTe+6/rkd/SiZbtnreIvTrvU/pc7X6xmKgWyYEc6k8d+qm
         16Vm8O8BJRVYyf19xPDUQ+ivth9yf70x9ZPT5VhbpydbD9gP4GqSN3dXkTaHdIwxzt7e
         4d64vu2M52WZPEfbTpp6M/eP6gi51aW5VyDYnvmfDDAgeF+LKc2apn5nR1zlzWo4aPRx
         OM8/9j2shDu6LTiJ0FUpLjnfm1fKidnCTHcjGuRAjtFlphauDox5iuyMdAZR876qf6HE
         1cwhz4ifvqvBQeVqEYxuMpYqXl/msBBZUsesPCaU81STyqNzlorni60udJxaJlYccDbe
         zE7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrvxZE/2STu5MzJZp0SIk359VyLDqE5JhGZBQhkG8F2XbdZrQJQ6kkUXbjFBIvG+E7yoYrgP0cIZ2u+to=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXL5T+8h4RR5SJApone1mAaQ230fodiVPxsqHkdjR+3tBOKEfc
	O2owwC47QDVvIHbYcNQ7r0wnxPWbdij1+7J3Rp0JOt7l50EQh0E0n9hP
X-Gm-Gg: ASbGncv7JasWQs4wJSK+ahrXfPHje6HmbmHQsPVVf/OacmtFroBRJEqBHLo4qq1PMRg
	wsSNMYRK2UCJk6P1gm9EqlOmeJxhuMOKfG8K3CjPDgDMka6eGybSBW6jJgYumC1D+gMgHl/LwKI
	KlO4H82PfADTswFh6F+NfNfelfyosX4KoSQxhdU9qNrckVRIZUzRpnXclCXw+LARtm7RpJ4xb6c
	De3/pzB8NjVxU5pb1KFS0mQCuCcdhT6E8M3VbQRipJne6pH7xwcHruzzsxXYFFyw/fEZ5geGyPh
	esDngovQcKhUw5XJR5ZR+09QoikAdiRCqXoDcc5G3VXox5ipyqnFS9IHIKQ0zj34Nqeng0mwU09
	oqDk2VpKgKAQqYd4bjL8uDJbsSPXvaV360n0tAaBtcmzmUhaxh2yI+u7EqY/cQzjAq9jruP0cgb
	H1R1rtgSLx89sHKqPJWsM8Xtt6N+v3bVHfUKkopwvKP8BJCM/5yJAU5Y8=
X-Google-Smtp-Source: AGHT+IGITksdEmvXHmmuZdLa/yQwq2NxV+cSSSlV4wRNZf68cw30YPa+bxghFOGqMqWKVmSu6m5h7g==
X-Received: by 2002:a17:90b:4e88:b0:327:e9f4:4dd8 with SMTP id 98e67ed59e1d1-3281543831dmr16440832a91.10.1756799048190;
        Tue, 02 Sep 2025 00:44:08 -0700 (PDT)
Received: from vickymqlin-1vvu545oca.codev-2.svc.cluster.local ([14.22.11.162])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-329d1927536sm1112034a91.2.2025.09.02.00.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 00:44:07 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Miaoqian Lin <linmq006@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] drivers: bus: fix device node reference leak in __cci_ace_get_port
Date: Tue,  2 Sep 2025 15:43:51 +0800
Message-Id: <20250902074353.2401060-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing of_node_put() call to release
the device node reference obtained via of_parse_phandle().

Fixes: ed69bdd8fd9b ("drivers: bus: add ARM CCI support")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/bus/arm-cci.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index b8184a903583..af180f884f1d 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -163,14 +163,18 @@ static int __cci_ace_get_port(struct device_node *dn, int type)
 	int i;
 	bool ace_match;
 	struct device_node *cci_portn;
+	int ret = -ENODEV;
 
 	cci_portn = of_parse_phandle(dn, "cci-control-port", 0);
 	for (i = 0; i < nb_cci_ports; i++) {
 		ace_match = ports[i].type == type;
-		if (ace_match && cci_portn == ports[i].dn)
-			return i;
+		if (ace_match && cci_portn == ports[i].dn) {
+			ret = i;
+			break;
+		}
 	}
-	return -ENODEV;
+	of_node_put(cci_portn);
+	return ret;
 }
 
 int cci_ace_get_port(struct device_node *dn)
-- 
2.35.1


