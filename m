Return-Path: <stable+bounces-89342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 601809B683E
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 16:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F4A284857
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 15:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A99D213EED;
	Wed, 30 Oct 2024 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkUdtFHF"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236A7213ED7;
	Wed, 30 Oct 2024 15:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730303197; cv=none; b=PeHRKyl0EnSQhszswPRtRwDpNLcuRIBvyKF+YQSpj88D+lE3b9pek0fx0rU2TMgQWMWGQWI+BSV62MYPej2+xe/2IHkNzLLxpyMXtrX5ExK1KPaY4BYBvsRYu7dzD/+bRHD+mxAfMeXqIG1tNylEwDxOUb8w07J0t31M5QHb1R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730303197; c=relaxed/simple;
	bh=PxZaXlZPwKRA5e61Vj+0usK4Gt0aR78nnQEtTA0aqM0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BZmg5CDLM7REaFU3BIey2YadKWxnbjYYSDOfaBl92ZHubmswhG6WWYe25auOyzb5mGezGSwHX22akCY1mqrweRG0pYYzxXcb8dECGPFaXJfwAEII3Gy46wz9k8LDeBQW5qhTNonyqyP271DzzCKK5B+JXI8W1GrqVrewrWm4kvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkUdtFHF; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a850270e2so1068566566b.0;
        Wed, 30 Oct 2024 08:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730303193; x=1730907993; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xPwLyn/QOZVCnYymc+6Djy80iI7/Pkatxz9yt9aXeZg=;
        b=QkUdtFHFotfP9uOTtK9ldMVZyAf+Jh+JkLHh2eTci9fD78uIhI6evHbBmWEmHcu7CA
         CArZoFHxwMs9IZUyT3XPkJP4YJ6P0OnayRcWEr4ZDbIa+88g2oAwm2g8bkj5p4CzSaUR
         CWH6DthGOpKKpmyjAjiG7oJ1x7oRCR5d/c351cz+jim5n/55W2jlMaGmmtIcKwRw44MU
         DnVA/CO5idZPtVqH+e4ofVWvm5QJMNbQl+mmH9/yoWNKR8ek4EOctUlzIlAyE28ZuduA
         GMRz3jjJCWpRU+3CBzVfssw6zXZVLSuXbdiFfvIozquks4mWlkIUuK3+BuNMYr2CAkq5
         pcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730303193; x=1730907993;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xPwLyn/QOZVCnYymc+6Djy80iI7/Pkatxz9yt9aXeZg=;
        b=gbcnvzFBDuX4xGt8XNtMLAAvybg0QWshIrGbRoTwC/j+MTwOQCTGR1E13d1A0wJJWJ
         bTl/i3EbqxekLI5iXBjOg/TLKOPIxEm9zxrMixOOmVYOtl9t/fwAlAxuhT7IqojOaMvV
         j04SgrTVPTdDnr1GQ8QpsXi+9iWgovRR5pML1EufS11TI4BowORP/La1Lo6O4DeDnk4G
         bXrGEv07j8bLcHCStIGsTVXTQkkee7K11+TANo6Ednsf0WTJETf2XSddOKTkgw2kf/7Z
         LeVv9K7YmIwn8wjG+/4Yk5/xO8+9v5dc257vVvc46LScTbFI+Bv5N3rC6R6kWZFbyU2W
         EHXA==
X-Forwarded-Encrypted: i=1; AJvYcCULTccLX4rOxMWWsUxya9qhuNVNEcIkDkUylxQB4abAjy4mBznFbrIyYAjlSTUfCrv5DW7ri6NHlS+ABcA=@vger.kernel.org, AJvYcCUi/Ew2YMl570jpd03YS5PAARQ7W2j60Hde+yiT83LhXtDSfFE+W1cbCmbq+eByHwa1pbdfC2zT@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvvk9QtUX6qUTkUyqUu3UIffkXangt5sDn+6JfcMKaF2I8eOms
	TL1Zyku1NuqhpT2W2A5U4PXHRff3VvGMhrePBtW3Xd/aBzlgsrw6mSRB1Q==
X-Google-Smtp-Source: AGHT+IHdu3s0jAO+hU0PuuydlDdMlPNAlqjyv61/cbV+nJhSh6VqTlDm0lc1CY4t/dBfSgEfedI+Mw==
X-Received: by 2002:a17:907:9726:b0:a9a:4a1f:c97d with SMTP id a640c23a62f3a-a9de5c9db6cmr1632987566b.7.1730303192734;
        Wed, 30 Oct 2024 08:46:32 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b3a086de0sm580414766b.218.2024.10.30.08.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 08:46:32 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/2] Bluetooth: btbcm: fix missing of_node_put() in
 btbcm_get_board_name()
Date: Wed, 30 Oct 2024 16:46:20 +0100
Message-Id: <20241030-bluetooth-btbcm-node-cleanup-v1-0-fdc4b9df9fe3@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMxUImcC/x3MSQqEMBAAwK9In23IIih+RTxk6RkbNJEsMiD+f
 YLHutQNmRJThrm7IdHFmWNokH0HbjPhS8i+GZRQgxRaoN0rlRjLhrZYd2CIntDtZEI9UWmvpBn
 1NAoHrTgTffj39sv6PH88uIFcbgAAAA==
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730303189; l=723;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=PxZaXlZPwKRA5e61Vj+0usK4Gt0aR78nnQEtTA0aqM0=;
 b=tE+SiGIRdShAK/rkvk1j/hrX9SEr9yojQrYMR8ru5Cd+0qZTcofJoym996kPKQivU87OlACNs
 Ao+3XwKjjqAB86pIuhUQOx96gxWgkgbyhQNsEeI5nS1Ay0LQ/MJf+kl
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series fixes a missing call to of_node_put() in two steps: first
adding the call (compatible with all affected kernels), and then moving
to a more robust approach once the issue is fixed.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (2):
      Bluetooth: btbcm: fix missing of_node_put() in btbcm_get_board_name()
      Bluetooth: btbcm: automate node cleanup in btbcm_get_board_name()

 drivers/bluetooth/btbcm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)
---
base-commit: 6fb2fa9805c501d9ade047fc511961f3273cdcb5
change-id: 20241030-bluetooth-btbcm-node-cleanup-23d21a73870c

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


