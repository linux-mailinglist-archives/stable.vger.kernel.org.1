Return-Path: <stable+bounces-116564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A853A380F5
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 11:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2BD33B54CF
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 10:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F89F218ACC;
	Mon, 17 Feb 2025 10:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkMMbn59"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4011721859A;
	Mon, 17 Feb 2025 10:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739789789; cv=none; b=dC1Axv9GZWKd3O4e2EYutfE+6Vg90x+/385a6mxd2BG0e3aSJFC0MZLNEShTOqg2Perq2nvcJhXiviMjUzVCbBLqyRdTj4i1sPoudtcTBshzA5kLSzdHm6ctf1WSnpjgSAQqEfYy6PTSW1MoiCEjPas6oks0QFQuW9PRmRnmbVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739789789; c=relaxed/simple;
	bh=dRiBU8bLHN+PKEp+BzJxh4xI8Uvh7i6S8PS8NsvM9so=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXI0FiKz9dL83m4c4fe8lvXGA/Pr03olS4p3nEMIN2wBtY6jA2zILTVoXAuq7p69XPHRhKC68jUjN05sNCu7scro61l71WfnBzMhKWx9tnlDKAywbdpyZxJXNi5AjuRw1Fuwq46CsQqRfIjR/rSrnOJu2ie571h3Av99JsHqnFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkMMbn59; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30737db1ab1so38405821fa.1;
        Mon, 17 Feb 2025 02:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739789785; x=1740394585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPmQbo/PCv0pK4oZriNkiOu24KqYFPM+bg/Ekpuf9vA=;
        b=ZkMMbn59wc5qMdK1X0wOv8UQASb0cP4R1XEmf0o6jNvuVh7ypGZQTf0kg65MbRO10Q
         Q5vfPTR1PiR2+Q2lhREXFy9FDHJk0Yf5atk/Y6KYcCLQ4uZ906KtqZQuoGTW66Z2LvPY
         mosXON17PwFQXW4w8XaHBud4hMJykpFPR5ZSuQ+uHtUGZfPGtWYj1rAK5q6gFW42Oy8a
         jynVHWRwP+bY7zWur8gD+2ue1m/4nL/YRlFYbnAAkT7jLuuVuhUzT8lysvFF819nhZpD
         sc1r6sw5sZPnZq4ZnA+GzOksGtw3WpxuHIlK+cSF0DRyrvditPAdDgpLwH0F5jRcwJKc
         lq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739789785; x=1740394585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPmQbo/PCv0pK4oZriNkiOu24KqYFPM+bg/Ekpuf9vA=;
        b=hHHOIsy9vqKf+ba9foRFpdLpnnHqgWZ764DO+HvUMP7rl3qteaPytAbjFsf65pCVnD
         nZZoW24VIN6E6urqnThTRSEB0QUw25PqX+0R5/yrbBLLZxckEj5TAs/v9qYUpJqTuaNt
         Bzgn3jyLSJm8gryVu20+LhlmX58TkGAlO3j3ZLBYyLRikptiDID0BqO8hIki5yyeG9ai
         7v2Bxks7JzbMwvq6YnNqW31EQ43LGQxkqq2TVjyOPDdWl2aOsaozgvGvgCDeABSLueP0
         Y7VbKU2qL2ED2u9cs9bub2NumD0LnCkeljhzuZq15Co4hCOfQ6u2TICtgQrJMzJ13/Vb
         2E2A==
X-Forwarded-Encrypted: i=1; AJvYcCUdjAloeTsWx/qfsYAG6cGIaw+SSnBDluQehazOP09Yqurrn5jhnCZFC108jnkqKKHgvFWtOvxjklLM@vger.kernel.org, AJvYcCWGnlub0oDG+1PxWlbaZ6YZkn38am6yPhaqhng3t6Brs+XBez8wZfVTIxFbWUaeJyheMuZVoK0EwS8PurU=@vger.kernel.org, AJvYcCXuME5JR9cakGTSE8Ap7matBhxXc0Sc4r6vMhVLLkuM+sCECSkjx3fJ2e+amH9v+x7czit1Ldyq@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7tKUjUh5WVat1EofoWjVpyun8WsdjbQFKS9oPIYpWpk43Farl
	7Nq6OeqUocPC4/Zz3QvT+TV75dyajOVd1vQHRG40rRVmR5H0CZvY
X-Gm-Gg: ASbGncveLHkxTZovEOyLZowz7YMXGRc9M17NVvIMrpNAsorbR3gB33As5HwT82r5BNF
	xZBvBjDWE/jCfe1+l+wWh2NIs+2kQl/wm7ctOPF7ulPNXzl0/AQbot5VCXPbstYcTGHfEgteK+9
	DQTMee5t3PoA6HMfVHY/vozSmN2YbRif/NEYW3l8Jerl6o08u97h6pPm1rPrcoxLV9h+KZ7vLMz
	3AtCnRP14yBpUupmd1sLaG1dCmwXMRKfLh0EAypoSZ5qKptickSpsNNjU/5JQZnsW6/pzckkXrH
	beYFnQmMzcEjmYh/mre8YA5e7VGp7btDfn+DU6XmpA==
X-Google-Smtp-Source: AGHT+IGCLD07lgk2Kg1aAIH+wi2GPpBO2RQDWyZh6vRvrBRHJbeM9LlJ/S5M4qlz79h4I9QIIJOKrQ==
X-Received: by 2002:a05:6512:ea1:b0:545:ae6:d73d with SMTP id 2adb3069b0e04-5452fe767f3mr2775645e87.45.1739789785193;
        Mon, 17 Feb 2025 02:56:25 -0800 (PST)
Received: from fedora.intra.ispras.ru (morra.ispras.ru. [83.149.199.253])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452b496aafsm1157086e87.29.2025.02.17.02.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:56:24 -0800 (PST)
From: Fedor Pchelkin <boddah8794@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Fedor Pchelkin <boddah8794@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Saranya Gopal <saranya.gopal@intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mark Pearson <mpearson@squebb.ca>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] usb: typec: ucsi: increase timeout for PPM reset operations
Date: Mon, 17 Feb 2025 13:54:40 +0300
Message-ID: <20250217105442.113486-3-boddah8794@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217105442.113486-1-boddah8794@gmail.com>
References: <20250217105442.113486-1-boddah8794@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is observed that on some systems an initial PPM reset during the boot
phase can trigger a timeout:

[    6.482546] ucsi_acpi USBC000:00: failed to reset PPM!
[    6.482551] ucsi_acpi USBC000:00: error -ETIMEDOUT: PPM init failed

Still, increasing the timeout value, albeit being the most straightforward
solution, eliminates the problem: the initial PPM reset may take up to
~8000-10000ms on some Lenovo laptops. When it is reset after the above
period of time (or even if ucsi_reset_ppm() is not called overall), UCSI
works as expected.

Moreover, if the ucsi_acpi module is loaded/unloaded manually after the
system has booted, reading the CCI values and resetting the PPM works
perfectly, without any timeout. Thus it's only a boot-time issue.

The reason for this behavior is not clear but it may be the consequence
of some tricks that the firmware performs or be an actual firmware bug.
As a workaround, increase the timeout to avoid failing the UCSI
initialization prematurely.

Fixes: b1b59e16075f ("usb: typec: ucsi: Increase command completion timeout value")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <boddah8794@gmail.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Add Heikki's Reviewed-by tag.

 drivers/usb/typec/ucsi/ucsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 0fe1476f4c29..7a56d3f840d7 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -25,7 +25,7 @@
  * difficult to estimate the time it takes for the system to process the command
  * before it is actually passed to the PPM.
  */
-#define UCSI_TIMEOUT_MS		5000
+#define UCSI_TIMEOUT_MS		10000
 
 /*
  * UCSI_SWAP_TIMEOUT_MS - Timeout for role swap requests
-- 
2.48.1


