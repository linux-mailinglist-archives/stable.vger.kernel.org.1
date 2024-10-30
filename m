Return-Path: <stable+bounces-89348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F62B9B6AB7
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 18:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5397F282A51
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 17:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A1821A4DB;
	Wed, 30 Oct 2024 17:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdzDLsPT"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15B9215026;
	Wed, 30 Oct 2024 17:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308260; cv=none; b=bt6LT2J8FGysGfV/leTon6eYfzg7WrZoUUlcmqrXCKqoVfKI6qy+bpjL/wotRQYGZHSEC0OsfOUwM514JBEezEfFhcoy8uwesvVDYTMKFIzsV8ASPD/CHpC8VRF09hRjXlp5f3qI+aK264mD4WVvEi8mh2ZlnA5XMGZxoMcFxs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308260; c=relaxed/simple;
	bh=NYhBGuYUoPm3w1jTLdPF3eAlajcyC21JWzVKEKWhCoE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oTXIM0mcH0xhUIIHyxu8lqxJN1uB7Xc8uU7yY5pJgPRFi8tGMyM1/QbrFFIWpiYAJhrr/LqqRTHBGFrg11StiRI3A7V0Q6tJNY9PAYY/KHlEdpXVluJSJVNdAxZS5yCIQxViMC2DALJD4jTG4Wx21nEJZMo20gsnlSgAcldFQAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdzDLsPT; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539e5c15fd3so38517e87.3;
        Wed, 30 Oct 2024 10:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730308257; x=1730913057; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f3ZT+G22WW6GHAmyRtnqdTwfgxmlP9Lmjrjq2GeXgKA=;
        b=RdzDLsPTtfWLQh9iKZzX/3qRpBUxvDobs/ERZr8erJVk88uKuryQYEvKFCSQO5/ocl
         xUKAVrJILFvQEpUIKpvy4nvxnkb+WcU+NlnClec6q0BWPF978MN66OzbJb+jMsoFs6+T
         pLDigChA/PotzXM5Uw53o1JUp8sEgtgZw9yFnvdkshtsR/cb/YVgm29aJfVj4d0IedJb
         Uh7tx8db5h1GAnDgYKJ9ilaHmrDL19w9yOGRezx6S+sAN+UuCGJu0a76ANKJP5QCBUf6
         IW855w1EilbvyYi3E+pQmMKixO7KfsJhSKO3Mc9dfJsF9YDkR91sUM8zEb8i9D47SOn/
         4pyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730308257; x=1730913057;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f3ZT+G22WW6GHAmyRtnqdTwfgxmlP9Lmjrjq2GeXgKA=;
        b=FWo1hF+oSbi347HN44IIiUWLHm0k5g0+NsAXL+49fEucGqfJr9JWOdhwphvppRjH2Y
         B3Wkml3jYTyxl306WA4MJQSC+ySTuEkF5Kn7CnqT1+FiuHhQCzoV+VTMVaiAcsxuRjkV
         ZgIsFp2/kVSsOClOmWzY4gJOh5AeBIqFa5I8LCjYAO9mpjYLATzs4Xmxn4A1SnswQ7xo
         fXEQe/SO5gKYQ5HLIByOCmzH/ZboZenBkCZyWt3dugMcAij+zk0Nf7J6pHPJYCq+DS2q
         nWGIBNo88e/ZCHXFo4i9qcanUXy/PgFc58h+U5pMjG4RuuWpj4bJnz/cQuYMFZTKxLIq
         nTPA==
X-Forwarded-Encrypted: i=1; AJvYcCVZRxGIYTSfzMJXmvKSZOacBzmRZvAIZRlibrTu2dEqv4qHFNvx2QGMz+ooaFEyFvPpW6VU/IIHc1vp52I=@vger.kernel.org, AJvYcCWduSfNhMiX/HT/ErRyNtWxblf0eG9Zt5034+rJdpS+jnDHKY6rwFVYkJKCSPPMgL9q0JQgkDaD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1KxDX+1gwZ0z0QJ3qn5ra6vMmPtT5gmSepG/yrx5jUggNGaXb
	Dp+z21HKf7iVQJYSGRkWpqPEKIQgfXNv9DeYBCcpAOrQ+rxphADR
X-Google-Smtp-Source: AGHT+IEBwca9NENqe5RXTTBqItfYfpFgHgz7BTyrZlZkrUyXpQSrJXpFftutaPkNLTOWN6V3bzfNZQ==
X-Received: by 2002:a05:6512:318d:b0:539:f65b:401 with SMTP id 2adb3069b0e04-53b34c463d9mr7254555e87.57.1730308256453;
        Wed, 30 Oct 2024 10:10:56 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-fbf3-0656-23c1-5ba1.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:fbf3:656:23c1:5ba1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9a9faesm26828985e9.35.2024.10.30.10.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 10:10:56 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/2] drivers: soc: atmel: fix device_node release in
 atmel_soc_device_init()
Date: Wed, 30 Oct 2024 18:10:43 +0100
Message-Id: <20241030-soc-atmel-soc-cleanup-v1-0-32b9e0773b14@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJNoImcC/x2MQQqAIBAAvxJ7TlDrYH0lOpittWAqWhGEf0+6z
 RxmXsiYCDOMzQsJb8oUfBXRNmB27TdktFYHyWUveMdZDobp80D3k3Go/RWZssZ2XA7LIhXUNia
 09PzfaS7lA6q7IWxnAAAA
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730308255; l=1086;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=NYhBGuYUoPm3w1jTLdPF3eAlajcyC21JWzVKEKWhCoE=;
 b=Z6hc0wQhA88bBphN4kmf7W8aIwsZ2dRwGrDeGbzmKPnez9O5nTH6KUCVDrObo9G3JnxKNGcG7
 Tl376np6Fx4AJtAjD4G+h5bgDtU73hZthKWkhvL2Llp1Ck+diLpSXVt
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series releases the np device_node when it is no longer required by
adding the missing calls to of_node_put() to make the fix compatible
with all affected stable kernels. Then, the more robust approach via
cleanup attribute is used to simplify the handling and prevent issues if
the loop gets new execution paths.

These issues were found while analyzing the code, and the patches have
been successfully compiled, but not tested on real hardware as I don't
have access to it. Any volunteering for testing is always more than
welcome.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (2):
      drivers: soc: atmel: fix device_node release in atmel_soc_device_init()
      drivers: soc: atmel: use automatic cleanup for device_node in atmel_soc_device_init()

 drivers/soc/atmel/soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
base-commit: 86e3904dcdc7e70e3257fc1de294a1b75f3d8d04
change-id: 20241030-soc-atmel-soc-cleanup-8fcf3029bb28

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


