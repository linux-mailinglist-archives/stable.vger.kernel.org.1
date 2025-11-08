Return-Path: <stable+bounces-192773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EECC427D4
	for <lists+stable@lfdr.de>; Sat, 08 Nov 2025 06:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEB25188F987
	for <lists+stable@lfdr.de>; Sat,  8 Nov 2025 05:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D863F270542;
	Sat,  8 Nov 2025 05:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGu/Ifjy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A6E4317D
	for <stable@vger.kernel.org>; Sat,  8 Nov 2025 05:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762580419; cv=none; b=VhAYC+g3JbQe7B/8fkJXF4IO2E7NkE2HCkWz8l9Wco508DUN/cNmD96T2zZKA4CFOJE8aQtN+Ci7+pW636SHjM/fi7A4ebU+3hvk/aTRyfQHbZ/0uRVokuihLDlyu3vTk7HCXON8Or3ffrWOwuczaa8qw6LydegCpnJZUKsJm8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762580419; c=relaxed/simple;
	bh=8n8+LxqHAgati7AeDofQcf/a3JB31BUTWqP0F3TTAHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sFleyzXGR/rak4NZB1B23gV/zFPImksEKzPZhM7G3032swonBG/dMO9KY2F6LdPvV8daEOoB2junaxE3caBCH+WPlnpNFl1mlpRLJBi8wn0kjE2cwal+nf7MdZp+UoB8kpXQZ+UhNRs9U7349052IZnAoemlNJWXC8bOohjmlBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGu/Ifjy; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b98983bae8eso854890a12.0
        for <stable@vger.kernel.org>; Fri, 07 Nov 2025 21:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762580417; x=1763185217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kzpr9FS38cfunqPmaiI0KKxAhNklXoFm1GkzWYUkMqA=;
        b=bGu/IfjypogCqpEfrYxuBYf4Ju7jw+o8Ud+zQUDwLGNWer8cFRlLfCZlQf4M1bPeM+
         OHPofwR3Jz7y076ivsxMcI73o/7Vlf6eP563JyzzTq+k6FvHSP5vyL/Zfqi2z178IB+b
         cT4AhpwX6hVEkOLYd00JyC/TdZ0V6P5jFhWA8xUgel5BD4vnCZRIIIYBxY2vsZgvWTH7
         90TZzXBXjkOANECXL9zSAEGgbRjEcWFYERjnnO0IPmWof/DEAyDaaryWyctvvzXMJCbv
         nQ2FGINMScMD/m9/7zWaQv7ftGgzTNn5vkVUWmFqISicOha2GrdCS1+6jOdZObRTO5tO
         lxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762580417; x=1763185217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzpr9FS38cfunqPmaiI0KKxAhNklXoFm1GkzWYUkMqA=;
        b=dw7At6H0CfFLbh14xzN79eQNFp2YL03kix35+3dMGjD4bQ2ODcHjIC1bY2pGlBbtYP
         dEDNWRfpT+IjAShUaEvTnVSlyIjqvU9X7IQAgjuAJtNp2zF4jFADDdZMAIZu/Xj6sSok
         1vO3CW8K6C1pGLt75uaEd1nlwIJKUvDbtKrBeJGoNHQuhwo2OZrmJVpTGxvmyrGZr9+A
         O/D4poThGXeO5NpJJrH/f0UaLzBO3uaDYaBqG3MAcydsrOMtlcqltaQItlq9KqyUSAzL
         piJGQYN6puUL5UjVZZJFPwShvNgyaOQmWmmWZegVfInoMUiugO7L7WEfxaTG6uuTq/wQ
         wfgg==
X-Forwarded-Encrypted: i=1; AJvYcCVvxApVM678hnrR5xQyQ/tT4okSTNz0qQOGdsHYKYch3Qh5wEaLeQbsy5rpOIAfLnOoepC3pRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww2WvD1lYmzMALflYKBKD0rFCsJxJUO5wwbkpoPEF2T5rbbFqC
	ymRVVmhb3q5jyIep+Yak+oXBs5QtGmfeNcKKO0RfT77tHieFitSEGT1z
X-Gm-Gg: ASbGnctY0qQdPTmt7/vpIt4qrhRLVLiOryeRVAS4LpkJXWDQis0C7oc+0d6I/TlrVWd
	T1cVQKpPj1lXKf3D/Zb4mJFA59oJj3arjlnxEidJ0bs7QDOq+UOL8RGGwQvuCSaQX5RmlQDBxWJ
	zg4lNc1Y9uu0eI15Eg6eeWwclR4TIhFoWT0YjXrkIFv+ekuEQfn+Pulz+BCb0tXtM7VfzRefCqq
	PTBGR81Yz+uJlBJxpOciBiZM5HPda5rd0jYccVD/XZVZDIPDOhJUFg3eSlI/c6JfmrEas3noQKJ
	cUE2KXP+Yw+BFVLHlamt9Vf9rFn+/KaobeO1K+Ql8XPQ/en1Wb3g98SCd8PYiOIxgKApFzYDRtl
	CJF6jBehCCfXgmrbhwm7hmrJ9gPv5G+sGCJ31lBKYk/UKJY9uGKCI1PZZnhbfDILvaA+wL7mIPo
	je61bANcbl/UtcFJB5QSBiD6nI
X-Google-Smtp-Source: AGHT+IGYgTX9sv7kEZ/sV+bmIlOIvmsyRTprbSJZXJCtl+790BMGjSY1AhJm52TRrDajQgfdJYr/9Q==
X-Received: by 2002:a17:902:e787:b0:293:623:3265 with SMTP id d9443c01a7336-297e56d9003mr17396975ad.34.1762580417377;
        Fri, 07 Nov 2025 21:40:17 -0800 (PST)
Received: from localhost.localdomain ([175.144.123.39])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5ee4dsm77925225ad.45.2025.11.07.21.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 21:40:16 -0800 (PST)
From: "Khairul A. Romli" <karom.9560@gmail.com>
To: karom.9560@gmail.com
Cc: Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
	stable@vger.kernel.org,
	Richard Gong <richard.gong@intel.com>
Subject: [PATCH 1/1] firmware: stratix10-svc: stop kernel thread once service is completed
Date: Sat,  8 Nov 2025 13:40:11 +0800
Message-ID: <eadf3b34e55bb7edcae9c149fb321115dd859cf6.1762416980.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>

This patch resolves a customer-reported issue where the Stratix10 SVC
service layer caused maximum CPU utilization. The original logic only
stopped the thread if it was running and there was one or fewer active
clients. This overly restrictive condition prevented the thread from
stopping even when the application was active, leading to unnecessary CPU
consumption.

The updated logic now stops the thread whenever it is running, regardless
of the number of active clients, ensuring better resource management and
resolving the performance issue.

Fixes: 7ca5ce896524 ("firmware: add Intel Stratix10 service layer driver")
Cc: stable@vger.kernel.org # 5.4+
Signed-off-by: Richard Gong <richard.gong@intel.com>
Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
 drivers/firmware/stratix10-svc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index e3f990d888d7..ec39522711ea 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -1040,8 +1040,8 @@ EXPORT_SYMBOL_GPL(stratix10_svc_send);
  */
 void stratix10_svc_done(struct stratix10_svc_chan *chan)
 {
-	/* stop thread when thread is running AND only one active client */
-	if (chan->ctrl->task && chan->ctrl->num_active_client <= 1) {
+	/* stop thread when thread is running */
+	if (chan->ctrl->task) {
 		pr_debug("svc_smc_hvc_shm_thread is stopped\n");
 		kthread_stop(chan->ctrl->task);
 		chan->ctrl->task = NULL;
-- 
2.43.7


