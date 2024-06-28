Return-Path: <stable+bounces-56063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF7C91BD92
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 13:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B7CCB2240D
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 11:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D58715747C;
	Fri, 28 Jun 2024 11:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uGXZQM/G"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EA71459EF
	for <stable@vger.kernel.org>; Fri, 28 Jun 2024 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719574633; cv=none; b=om8ApfgswGipYN2yYvk6IeqWLTzTuozzHkttoksWWfic3R/QLL7wXPfqVaXYjHyD4YXhLJFa03szGzBVjXzKt9Tazkb3ZE1NaVRcv2r85/e8GPC8XvMv5nys9pQFekVrdjrlLnJqrV9mpj0+D/Q+72+XgW9ktDYTgAySJzTRL+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719574633; c=relaxed/simple;
	bh=uvNcnB9Ff5fU7B8IHkw9VTflTK0qbmhPT0ocf1uno4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FZjOnqXbJXi+e/giXFfyjxAXEgg8awBARVLm7viVeCuEEP2X8nzkTYSnKtzIxWQydUzvZJ1Ded4QLojYPGyx4VL/tNyyRbgXu9HJ/v7zTehc8ZN2M+JvJYRSc2PNzqkQZNhSQ2EgDKjbo0XRS5ppfxrvPDOLzDvJaiFvumSfW9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uGXZQM/G; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-366de090da9so291707f8f.1
        for <stable@vger.kernel.org>; Fri, 28 Jun 2024 04:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719574629; x=1720179429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWlN3/sFgEOPWB0LU/uquV7p1t4WmyyxNaTnRP7KUZk=;
        b=uGXZQM/GNMpB0QNCXupzlcoEpXeBFV+KjoB/K1BQH1VZf1dy7v0mBDfXHOYFQZ3N5+
         MIt5NK0jHlVS5etJm9bKHacOHSj1U7mM0WZ02BrCh11MGjMU/5S2SO+JdLrXDYMQuKeG
         hTZxpQAxD6cJttAWZv7Z9MHjZQjngJN4VNhJ8me/nTAYG5bb5kScmxLFXpmb35rbQdrn
         KLXsKjyIYsf/69qGCi/O5ADgydI0sbcNQjwroYlYPtMdcBhe6EDi4D5tJMpUJPq11H0f
         vKu6a607ivC2hkv7WkcnJxqQO8fCVun7Dvh5ROwWHeMTgrvqRXiFUO8VHkfxk7+4sWsI
         weMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719574629; x=1720179429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWlN3/sFgEOPWB0LU/uquV7p1t4WmyyxNaTnRP7KUZk=;
        b=DjCiU18svojgNCxvDgjGeh0QbF+Zwb35tG7ZeEM0HVOa3JfLW21pjJRtonEtqvFLr/
         MGbpmRCAdeuTlPV1WgY8Q06odx0SGNiQWJR8dZX6pj85TLyzJITGbWTxZ+LytMTpW+Ra
         VqnR00XeV994kncY77zfFexOLWDPKgoBoibnm9YLw0I7rCpTnoRBql3iek4HC2BW8VHV
         V7XLM/WX7mDSwzh3tZ6BUQ7975hNT2FGJcs7rFB6LS7ofWQMXF4qoX+CttPPArY38dmF
         s9rQCIK1MVwqd0F4zyynPA6x4++X9eEMuJdn94KYYvXhey8rTdjEUdqgQb2+vxkC3o46
         B1Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXWaOyRodSWWCT81wTtzmPbQl2Tn97I/7mFlJQU9LBWAe/8wXFZKNmVPSsoiHWS750pT6HN3Ckfu6i87lUoHQ8c8QOvTxHr
X-Gm-Message-State: AOJu0YwQv7QyWuuUtq/fvHB98kudKl5JQ+54tnmJBXkUvULKWxdVip23
	MWW9Q0WJRt635O8mEq6ZynyMOkwYVptgyCB1BT7Fl356h7ARzsvr6IARAEIkMM8qZoycZ0GwCeJ
	Y1kE=
X-Google-Smtp-Source: AGHT+IGbATUTf1CtcHvGJ7zBXcjjbG4tWLMniVEGLtMqHk8/pkxS70uyMYSeCOTwFKQbfklLYPgaDw==
X-Received: by 2002:a5d:5f90:0:b0:35f:fb4:fc7d with SMTP id ffacd0b85a97d-366fb8dd6e1mr11284914f8f.31.1719574629347;
        Fri, 28 Jun 2024 04:37:09 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fba5asm2048937f8f.71.2024.06.28.04.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 04:37:08 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Joy Chakraborty <joychakr@google.com>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/4] nvmem: rmem: Fix return value of rmem_read()
Date: Fri, 28 Jun 2024 12:37:01 +0100
Message-Id: <20240628113704.13742-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240628113704.13742-1-srinivas.kandagatla@linaro.org>
References: <20240628113704.13742-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1327; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=MOaOKfQhsx5kjf33gADJlKQaVbEXqSwm5ga7NXsrcWs=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmfqBTzBgjUHYeEwlbWQDFMaAtBSjcDX/w00E9j 12gnIvUht6JATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZn6gUwAKCRB6of1ZxzRV N/gYB/46iK1hmFmIdZgewv89dONRCWZR4eRMehgOKAJlPj57exgk/E4yc9cvrTG6jDCJkIOHuwz hfEOrDUORB9Nmmpnwz4/HIp39cRobD+XhsBB3c0uhNyySz3tsxeQgGNuWsideaHK8ZrqDR5Yqcx +9JrenzXH5okKcaR3WPCi5o7b+aZ34qC9st4r6goEcts6k6d/U5g/RMMdRvHKLPTzDNeqIsXshG 00ryA7qvviVS+aUj/0LmOf0VxbATBzXx6nWFTsbABKaLH3X9W+gns0BXGVxXYyJeBYes2NvlIX5 Y3zQ2sylHnztZ25Ooy1LMunh0DL9BQ7+IrdI16GgrQCcCZQ1
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Joy Chakraborty <joychakr@google.com>

reg_read() callback registered with nvmem core expects 0 on success and
a negative value on error but rmem_read() returns the number of bytes
read which is treated as an error at the nvmem core.

This does not break when rmem is accessed using sysfs via
bin_attr_nvmem_read()/write() but causes an error when accessed from
places like nvmem_access_with_keepouts(), etc.

Change to return 0 on success and error in case
memory_read_from_buffer() returns an error or -EIO if bytes read do not
match what was requested.

Fixes: 5a3fa75a4d9c ("nvmem: Add driver to expose reserved memory as nvmem")
Cc: stable@vger.kernel.org
Signed-off-by: Joy Chakraborty <joychakr@google.com>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/rmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/rmem.c b/drivers/nvmem/rmem.c
index 752d0bf4445e..7f907c5a445e 100644
--- a/drivers/nvmem/rmem.c
+++ b/drivers/nvmem/rmem.c
@@ -46,7 +46,10 @@ static int rmem_read(void *context, unsigned int offset,
 
 	memunmap(addr);
 
-	return count;
+	if (count < 0)
+		return count;
+
+	return count == bytes ? 0 : -EIO;
 }
 
 static int rmem_probe(struct platform_device *pdev)
-- 
2.25.1


