Return-Path: <stable+bounces-273886-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EdYWAooZVWrIjwAAu9opvQ
	(envelope-from <stable+bounces-273886-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 18:59:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 527E774DCFD
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 18:59:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=pvE4LXcw;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273886-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273886-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA04A3095589
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 16:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B1843F8A2;
	Mon, 13 Jul 2026 16:58:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5987443E9D8
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 16:58:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961917; cv=none; b=QkLwKB2K/+n3XuADrypmE3LcRjEqLnsXwhPU4dtUr5Mr3h15yiTZlKed64jODD5gRRUP/xe/VbocuOF+UN00mCJncdBvnw7RttN0G7C/aDmFsrja8UDcWnFoJXQlT9Bccwl4mG/TgPeBqpgj6It1lk2Z7AH/dec/SdtGb4xQrm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961917; c=relaxed/simple;
	bh=DxrdQK+FMY6knsZvirHX0KtVEweLXXULOEIRIUL/31w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YdUEV9d5rP0C9oJA4Lprr5eJqUQpr7MuMffqaEIcYARDmIshxw553+5F+RasLvkUNonLiv3PCjTDqLE/0Ur79aQY369tTGQJbhYksb/YxDxy44tHGXoD3iq2V4ML0aq1CjyMxgLDliw4ya72Cn2zSo2iO9i/4mRPQl10yrm/5gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pvE4LXcw; arc=none smtp.client-ip=209.85.210.54
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7eb9b427da2so70299a34.0
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 09:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783961915; x=1784566715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vQ/MbrAy6RyE5QbP12v4EtWdPmh429k6lznRwDdghJs=;
        b=pvE4LXcw2Le9beMo1vPphqp4gw/H0YdIzy1r2b6DxmzqaLkRqUPkEpUt+MJjuHxBsW
         2oYI9Vk7XiI66rfljttbuVDWEuXtsFWLCv1xS3kIR2SuW1GRYJ7JU/2kdNs0jLYROhfY
         SeOpu7mXTA/s4YKaCstPNKX9JUzANe24Tal1WzHKSLDADBuMasZibSZ4yyvaLxNrd1DV
         l5NVveV2vzcMP0KjPdqDtSwZ9l6gqwNwlAHZjz/0laTBTsGeB45c+Xb2As0X1vjT0nbg
         ruOb/+BHSE6CPIGf+/0UWt0FMtwhE2FbNXGj9vQY2JMZERP2rJRyOJ9w3ZPj3pcfv5ZG
         EBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783961915; x=1784566715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vQ/MbrAy6RyE5QbP12v4EtWdPmh429k6lznRwDdghJs=;
        b=tTfvMmNEPM+SLR1nyQiLcxgd6TLAqdwmJfvaEWM/RfFYbbLM7MIcGTnA35GHqUb/SQ
         bryDncA0qcHghMFrYmCo/M20Jp6o8YHPQEd0MLF4KyYER9tZSEtJZWRIe0R85YXLC6k+
         X5vPhdQxo2YN3s0ytAA7etdRwheYOq22s50/C6G5wl/5A6dePvtvBPSmFa91jgfAEIp8
         yuCDt7qGKHCK0VE235vVbh2d56Ra1RwSP4654ojvmuc/fmWRIR9aQlu3avycw7zpfpP3
         uAxTeHnnO4K6t1tDbRSQsCLoSHjmR1IiU/p5FIBl57aNwlwmukoLIskHBYhh6sub+dtz
         bTFg==
X-Gm-Message-State: AOJu0YwL1/QgPoM7lrwv82Ojrv+PZHMZhKfFosN2jtlmXT44Q9rjvgJf
	wyacnkc8dMqeBKOjvpVORnfxbRo4VgeOhkPmPpyqCx8Ba0iQiyIt3no7jgYkOuT2
X-Gm-Gg: AfdE7clGbrWB9HyND2cv0Agctue909sEJOjiNNh7L5Ae2jx0xVl8uejAPdMOpxBmQsM
	H3jZ2f9WPDCs0fVut6BMf7UYqXIRmt1Nun1xCMoYkEyct43TftJDSvR6YN71/La/jbAK6VrDRNG
	7ZNe1jYiNRw1NjT+3lmGa2YeyydDFFxsLY2wuGsVuZ5dJUTDLEHYdhNuOp4DH/9htvRmVI2gYSt
	hqQljwdV+n75Gb+HrjzVbAC/Ab2SK7qbehf98MWsTzF5CD9wk4DDBamJd4QdLWTGYt5sUvPieJi
	ffBOoubbp+UCAGLJZ0TZYlePCzn4rSTcv+tE56/AxCgCPyroQ0JoMO+r26dOl/anCxLQsN99sBb
	5Zy1bR8nF+f3d7HW2zYHTi2Cpg+CaCpg2hgvS1zKTCfokO5lKagGPH4pwx03vAD4IXMZYaq5aoK
	wW3xP8lF0fLdsY7yrIyscVJkVEC92hB1sgTwtZ8ppkvrDOSco=
X-Received: by 2002:a05:6820:987:b0:69e:b97c:2f16 with SMTP id 006d021491bc7-6a39be9a7c8mr4742886eaf.27.1783961915286;
        Mon, 13 Jul 2026 09:58:35 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a38aab2761sm7411487eaf.1.2026.07.13.09.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 09:58:34 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: stable@vger.kernel.org
Cc: Sangyun Kim <sangyun.kim@snu.ac.kr>,
	Kyungwook Boo <bookyungwook@gmail.com>,
	Jaeyoung Chung <jjy600901@snu.ac.kr>,
	Vladimir Zapolskiy <vz@kernel.org>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 5.10.y] iio: adc: spear: Initialize completion before requesting IRQ
Date: Mon, 13 Jul 2026 11:58:33 -0500
Message-ID: <20260713165833.500024-1-m32285159@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026071347-duplex-theatrics-64bf@gregkh>
References: <2026071347-duplex-theatrics-64bf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[snu.ac.kr,gmail.com,kernel.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273886-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sangyun.kim@snu.ac.kr,m:bookyungwook@gmail.com,m:jjy600901@snu.ac.kr,m:vz@kernel.org,m:Stable@vger.kernel.org,m:jic23@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[m32285159@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m32285159@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,snu.ac.kr:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 527E774DCFD

In the report from Jaeyoung Chung:

"spear_adc_probe() in drivers/iio/adc/spear_adc.c registers its
interrupt handler with devm_request_irq() before it initializes
st->completion with init_completion(). If an interrupt arrives after
devm_request_irq() and before init_completion(), the handler calls
complete() on an uninitialized completion, causing a kernel panic.

The probe path, in spear_adc_probe():

    iodev = devm_iio_device_alloc(&pdev->dev, sizeof(*st)); /* st kzalloc-zeroed */
    ...
    retval = devm_request_irq(&pdev->dev, irq, spear_adc_isr, 0,
                              LPC32XXAD_NAME, st);           /* register handler */
    ...
    init_completion(&st->completion);                       /* initialize completion */

spear_adc_isr() calls complete():

    complete(&st->completion);

If the device raises an interrupt before init_completion() runs,
complete() acquires the uninitialized wait.lock and walks the zeroed
task_list in swake_up_locked(). The zeroed task_list makes list_empty()
return false, so swake_up_locked() dereferences a NULL list entry,
triggering a KASAN wild-memory-access."

Fix the chance of a spurious IRQ causing an uninitialized pointer
dereference by moving init_completion() above devm_request_irq().

Fixes: b586e5d9eee0 ("staging:iio:adc:spear rename device specific state structure to _state")
Reported-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
Reported-by: Kyungwook Boo <bookyungwook@gmail.com>
Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>
Closes: https://lore.kernel.org/linux-iio/20260610115700.774689-1-jjy600901@snu.ac.kr/
Signed-off-by: Maxwell Doose <m32285159@gmail.com>
Reviewed-by: Vladimir Zapolskiy <vz@kernel.org>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
(cherry picked from commit 3ee2128b6f0eb0be7b6cb8f6e0f1f113a65201a0)
Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 drivers/iio/adc/spear_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
index 4d4aff88aa6c..12e0811a47b7 100644
--- a/drivers/iio/adc/spear_adc.c
+++ b/drivers/iio/adc/spear_adc.c
@@ -274,6 +274,8 @@ static int spear_adc_probe(struct platform_device *pdev)
 	st = iio_priv(indio_dev);
 	st->np = np;
 
+	init_completion(&st->completion);
+
 	/*
 	 * SPEAr600 has a different register layout than other SPEAr SoC's
 	 * (e.g. SPEAr3xx). Let's provide two register base addresses
@@ -334,8 +336,6 @@ static int spear_adc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, indio_dev);
 
-	init_completion(&st->completion);
-
 	indio_dev->name = SPEAR_ADC_MOD_NAME;
 	indio_dev->info = &spear_adc_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
2.55.0


