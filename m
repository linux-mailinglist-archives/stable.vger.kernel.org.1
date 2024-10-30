Return-Path: <stable+bounces-89349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FDD9B6AB9
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 18:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633B61F2449E
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 17:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C38D21A6F6;
	Wed, 30 Oct 2024 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8xYpAh4"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A1B219C8B;
	Wed, 30 Oct 2024 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308262; cv=none; b=tu5Usf0aTaPb6SCl6d33gTcZugwlZvB25J9XeWmgUcqYJbDBDe91DBTUZK0NHXYIRWPm9Jf1qQDlrzhjPaoxmZdwF32fIxVgsmIxpzz2h8J1voyfHUSyDl2FsQT4s5eznhwVNb9AzmWjB0nHQ9z3Oy8eYB84R8SKiUBuXHCNSiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308262; c=relaxed/simple;
	bh=BGokR1rnVjyNDYabJSSa0k7Pn2ZZ9/4XWpf7LL38U1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FL/ZNVqqmPOq47lOQb7iYBHylwgsK4NKn2mGEfqGOrRYOOIW+iw5G4m4rwz5B6vlepIGlxGLy4mket/Z1SZmraflDanccaIXbbZK1IVVZQC3vxONpzTCuHu9UPQqosGLy2ZAi83GpI/2knGaCdUK1mJ1QI4DPdVNyRkg1ujDnWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8xYpAh4; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539e6c754bdso50179e87.2;
        Wed, 30 Oct 2024 10:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730308258; x=1730913058; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QTtvVILI8bASQzgU7LKCLSZFap6LNc4ft0tXHklb7n4=;
        b=K8xYpAh42zCPT785NmxE4p/qeoWnyMoh/Utcggki31hLCia3W3XT7hsQ93/euP7fwy
         GgZirnu5TAgDNEElj3cVKMH1rwcPDmBSqnE81DBLYyAZpB479CdFrxpc2OFxo6759pZX
         rs8QaOmvJYykf1REHMBOkUYIoOtZ19XuWr6uTd1h51ZFiYwST9k6TLewKLteQP78z0+4
         1eyRoFdA4l0kon86l39qYJ2AhvDCJLtj/uDkvdG9ZzP2qehWYm9B4vc1n4oo3hxXf/RU
         l88Zov7/uTaW/x8aIN7gUEWAg+Rc7ypAD5+QvSS9Z2T4wzSfm4UNv84om2rtY9andVPe
         4dvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730308258; x=1730913058;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTtvVILI8bASQzgU7LKCLSZFap6LNc4ft0tXHklb7n4=;
        b=P+B3svGUd92HaYOr40xxakESynLs2AtQ83OXd4TAGFJmVsZbnfnU/B/ukXK/iHJxo8
         XYhJDrprPbyQE1vmKMLAch/7HoSb9WKx5RftZ3RsSgy8z/aYfC5SwpAAHrpsLrJGdtS4
         1k+TujsZNy2lSiQS1awsmXFglvmlcHLMtZ9J1eUudU2ZtBaARRy+SJgltYos4nUkU89d
         QQTRt9nhgTS2mGcdPUqFjX7xQUvbzRtunnlUWdl1O+Fc0ni4FzGoTi+d6jcxUoDoO12W
         3eAMALFHrgmIKg8voxlupvv1cilPhBAlH62w8+zn7LJvsOFRXSp8Pd1eMUZ42oBuXCQi
         uMhA==
X-Forwarded-Encrypted: i=1; AJvYcCWEl9IgaobWB+25yL0WwjlZEpi142lkAxFjBIxHNW4YvWKnTYrE5KV5gaW2almxUkDUu9VuD6djDeqHe40=@vger.kernel.org, AJvYcCX9GmxERJzAr+7uVn3qlMkISuhd9NWrtE70dGPX4inoh3R8O5pYqEfNZalyjgq+A/lOvzVp2/K3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2mz9uJ54EJH4BMoxqU9xju/w0VOdU8FpV9N5DrwzN0JIpXpUN
	qKHq/wq+DpViSuDZ63zIjtZkfQDA+r5OVj6t6mNjyI5i2qWcq2RqoRp3Hg==
X-Google-Smtp-Source: AGHT+IHss8st7QKvUSU+438ejEUHcCZ6cpwlHDkhixbeOiuY4PcEzYL4njnCgW9R4LX95uzpYmxAJQ==
X-Received: by 2002:a05:6512:3a8a:b0:53b:4bc0:72aa with SMTP id 2adb3069b0e04-53c79e4d45emr165051e87.34.1730308257852;
        Wed, 30 Oct 2024 10:10:57 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-fbf3-0656-23c1-5ba1.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:fbf3:656:23c1:5ba1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9a9faesm26828985e9.35.2024.10.30.10.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 10:10:57 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 30 Oct 2024 18:10:44 +0100
Subject: [PATCH 1/2] drivers: soc: atmel: fix device_node release in
 atmel_soc_device_init()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-soc-atmel-soc-cleanup-v1-1-32b9e0773b14@gmail.com>
References: <20241030-soc-atmel-soc-cleanup-v1-0-32b9e0773b14@gmail.com>
In-Reply-To: <20241030-soc-atmel-soc-cleanup-v1-0-32b9e0773b14@gmail.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730308255; l=1020;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=BGokR1rnVjyNDYabJSSa0k7Pn2ZZ9/4XWpf7LL38U1g=;
 b=EyUghQAPETz3hATWK388QYKXcL1vA578B0y0ZOrciW04D+dY7KkZeGs5utmBaPhjeySTFpXTv
 iBPlKCkpzAoBKbZ14G0RsDeSg5fKNv+gQVX98IvSej4UHKjivmxnCDE
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

A device_node acquired via of_find_node_by_path() requires explicit
calls to of_node_put() when it is no longer needed to avoid leaking the
resource.

Add the missing of_node_put() in the different execution paths.

Cc: stable@vger.kernel.org
Fixes: 960ddf70cc11 ("drivers: soc: atmel: Avoid calling at91_soc_init on non AT91 SoCs")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/soc/atmel/soc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
index 2a42b28931c9..64b1ad063073 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -401,10 +401,13 @@ static int __init atmel_soc_device_init(void)
 {
 	struct device_node *np = of_find_node_by_path("/");
 
-	if (!of_match_node(at91_soc_allowed_list, np))
+	if (!of_match_node(at91_soc_allowed_list, np)) {
+		of_node_put(np);
 		return 0;
+	}
 
 	at91_soc_init(socs);
+	of_node_put(np);
 
 	return 0;
 }

-- 
2.43.0


