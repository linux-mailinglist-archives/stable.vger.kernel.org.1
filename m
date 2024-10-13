Return-Path: <stable+bounces-83620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1B599B993
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 15:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F7DE1C20BC3
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 13:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21C44086A;
	Sun, 13 Oct 2024 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9inCbJW"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA57140E30;
	Sun, 13 Oct 2024 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728825631; cv=none; b=jeiJEthTeN7Tr/7qACNL69UJC+FMpMAE2QvRFVH+PDedsH76NpEPrF73cEjXaQodNkI2I4Z3OU+376IwKtFG1hXQl7ojUsx6mDNm/lNMLk64tDq6gpnx5Bl9RXrqU2dR1YtXgwbhsK57FKoOYxOY8IUqpAkSUGa+yvRcUacPYRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728825631; c=relaxed/simple;
	bh=C0S6mqfORLoWtEDyItiveXpTLIy6WbtUFcSND0AtIsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rwEzdJx5axJsS5cnwldvJsaFlcL97XaWmtbw9u3abbWmh5PutpaHHk24xW1foOLjBlO0+7jI5YRGLJ7VHR8z9Sf566I8EICKFZG0vbG92JCcUwNUWaVXOXNjyMbChdw6XeKoDC0SGFnVm15Sy/PGdU/W1Vi+6Jiz+UDzYmjHwRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9inCbJW; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d4c1b1455so2399139f8f.3;
        Sun, 13 Oct 2024 06:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728825628; x=1729430428; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yp6pw/0C23KPENHuWOvywUiHbaiRAvFFE4mKQ3z1tKE=;
        b=P9inCbJWBbURbfZCnwpEiNKisK/nWO1GBKqwqWdiRCgftpUYQBHqS4GagU3mQuhAMv
         fNZje0+wLraUN7DhradKI5CEeW/QQQSCYSiSdRe6nNCL3RcdauFUp1iLjHVomaodqgRz
         6n7wFAE3K78nZ8/k0YC4c85+On5VCkTHBvPwWk+xEyui+aR4XBvhhIrLXTfivyII7pxu
         K3MfpqutlMjK1AU0ABojkE8vHliq7K5xbcRE5oZVuopztPmsLFlvzNYoZ7QiRxWpxQ0P
         T+TulbYvAClHwhZjiV24a6KR7VF2/3Stwy7nF1wQrOkQbGJpwo4zrJQcXMXKppfHOgXO
         Ngbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728825628; x=1729430428;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yp6pw/0C23KPENHuWOvywUiHbaiRAvFFE4mKQ3z1tKE=;
        b=Uyb0ZNHop0PnFx5qCS0dBztJXDZR5RTIJcvbDGg2PUhY9KNIvB586f9/ZAwRwIEHyk
         HZv8F5vKmr1pTugVlpxk2uTe+civwzNvNB0zLf7CbwqoI0nY3W5fGdDyzDfBjSDqXaxr
         fo/Jmv/UuhY/8Y23tvSQ9XOHa9wUfUU0Y7+EceUXpibEZHxPXE8fXxeYYQKV/2QSUzWU
         V7cpQLCUQ67TNvUV8hZxsfMPttWyESlfVW7NdXRL48GyLi/eiE4JS5A0P1anNqC8at1u
         SonRqn2OVJL/Bo6wsGUC0yYIsNv5tkhVuHCO2AFfarf0d8sDt/vz98VHgCE38lASMWXe
         8HRg==
X-Forwarded-Encrypted: i=1; AJvYcCVrs8ZSMzroerBn+efw/KSQX+TbyEt+bOJI68XNVTHnHwbtr2Ueg8wpZRLWYAIMqSpititlLEa5iCbOhGY=@vger.kernel.org, AJvYcCXxQU+CmVzb3ODeWdX7+G945qzOKrZlUDyazQjy6GSAr6+EH6oI9EqXAlTvZpiraf8C6V+tPo2U@vger.kernel.org
X-Gm-Message-State: AOJu0YwzdkKOtBmEPBUl/m2GXmC3CHpWIsMgX8BN2pYVQQVQykAoaljQ
	vvsnnLNM/u3LO8Hf05BBcsSIriKX3IHUNtOrTDKbsu7e9ITEhuwG
X-Google-Smtp-Source: AGHT+IHyxkV2Ch48vA8q5r/fE7A3H2kOejnw9ANFN69fKq7TKDidmMYePuKbSBRYvCKrpIBUaOmyAQ==
X-Received: by 2002:a5d:570d:0:b0:374:c8e5:d568 with SMTP id ffacd0b85a97d-37d551d6b43mr6355803f8f.29.1728825627943;
        Sun, 13 Oct 2024 06:20:27 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-a034-352b-6ceb-bf05.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:a034:352b:6ceb:bf05])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a8911sm8642547f8f.14.2024.10.13.06.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 06:20:27 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 13 Oct 2024 15:20:24 +0200
Subject: [PATCH v2] platform/chrome: cros_ec_typec: fix missing fwnode
 reference decrement
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241013-cross_ec_typec_fwnode_handle_put-v2-1-9182b2cd7767@gmail.com>
X-B4-Tracking: v=1; b=H4sIABfJC2cC/5WNQQqDMBREryJ/3ZTEhqpdeY8iwSQ/+kGNJNZWx
 Ls39QbdDLxheLNDxEAY4ZHtEHClSH5KkF8yMH07dcjIJoac51JwXjETfIwKjVq2OaV7T96iSlM
 7oJpfC6ucuGmprbwXDpJmDujoc148m8Q9xcWH7Xxcxa/9Q74KJpgThbZalrYoed2NLQ1X40doj
 uP4AhhjikTQAAAA
To: Prashant Malani <pmalani@chromium.org>, 
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Guenter Roeck <groeck@chromium.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728825626; l=1709;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=C0S6mqfORLoWtEDyItiveXpTLIy6WbtUFcSND0AtIsE=;
 b=vG1BHbGA8jidaNJrfj9eSQ38uVJkBe5+Gqwl2/D4PeNpr94Pw3akMfi0956Z/2JdY/WvxToo7
 zZbdK/bi27bBRqb3zxJkn+5duGHxRzpw0NwDMNZZXrLen5iVrbP6dL7
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The device_for_each_child_node() macro requires explicit calls to
fwnode_handle_put() upon early exits (return, break, goto) to decrement
the fwnode's refcount, and avoid levaing a node reference behind.

Add the missing fwnode_handle_put() after the common label for all error
paths.

Cc: stable@vger.kernel.org
Fixes: fdc6b21e2444 ("platform/chrome: Add Type C connector class driver")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
I usually switch to the scoped variant of the macro to fix such issues,
but given that the fix is relevant for stable kernels, I have provided
the "classical" approach by adding the missing fwnode_handle_put().

If switching to the scoped variant is desired, please let me know.
This driver and cross_typec_switch could be easily converted.
---
Changes in v2:
- fix typos in the commit description.
- Link to v1: https://lore.kernel.org/r/20241009-cross_ec_typec_fwnode_handle_put-v1-1-f17bdb48d780@gmail.com
---
 drivers/platform/chrome/cros_ec_typec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index c7781aea0b88..f1324466efac 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -409,6 +409,7 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 	return 0;
 
 unregister_ports:
+	fwnode_handle_put(fwnode);
 	cros_unregister_ports(typec);
 	return ret;
 }

---
base-commit: b6270c3bca987530eafc6a15f9d54ecd0033e0e3
change-id: 20241009-cross_ec_typec_fwnode_handle_put-9f13b4bd467f

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


