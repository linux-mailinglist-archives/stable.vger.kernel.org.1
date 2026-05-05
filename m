Return-Path: <stable+bounces-243962-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDXqLsZ5+Wnz8wIAu9opvQ
	(envelope-from <stable+bounces-243962-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:01:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3134C6A28
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 120B030436AB
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 05:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2F43C3459;
	Tue,  5 May 2026 05:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYA47lWI"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0B43C2796
	for <stable@vger.kernel.org>; Tue,  5 May 2026 05:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957206; cv=none; b=HZ74u/UuG6zgZdgbjNzRbD5q/PcYXhx6pGqHo9zXidZJ4dZdAIbaWHu+ZpsVNwAHxz2DsGeRQvsX+PpxB6Ia0/iEeU+0Isp9gyfxYyLRFKdSN3kyQb+7wiSduqgCNUvZr2PSE/nEDIxAaDypS4QFwkYmc9V+PH7owjPk4Dc+wbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957206; c=relaxed/simple;
	bh=TEvCiEbQhzE4Pn5a92hAxEUB6/ep5l6pVtFMl8q6X+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNJnkKLTOHL6BEv4RzE/z/SpYO1UDcn/AuxB2KHFmRRNU/fxGK3DvagnvbYYnE9LvMglTZ4dVb2ulk/8XYBIXQRJ8M+CL9vWhGyvQeExEFFcHxcOIn117CoUq6HgJPzAw11HC+EN9bHoiwHzBUmeLtZfeCgVXP033HU9uT5omDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYA47lWI; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12dbd0f7ecaso10802649c88.0
        for <stable@vger.kernel.org>; Mon, 04 May 2026 22:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777957204; x=1778562004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYBlozxzCL/KPqU6onSXZMaSuqAKVSHz3cyPWSVaa6M=;
        b=hYA47lWIWimqmlEsOKM93i+Sabxh2xCpfkxphpCcI2aeIGNnVNg0PtymoVTnSinmtA
         oOjxNNDkA8JOvWdebMJvlgcu/hWVuymZV+dKuUOcabE1JswwiZzIAa5JU64DOQ/QGn7L
         TSzmt36o6KWS3YdQQhsemquqvFQO1ayAya+NEQhxLffUMdP1y20+X4B8PJgkkpiXnHDk
         Y3Nwdr1G/mxTR5/HNraZd2/LyXocFiRmMeIaFBjW6JqWfr8bR4cl1Q89AWSy2F+XTRRH
         FGUtWZN1woWVFRqzkYvKDqZIXkpjFQV7HBUzheZaoatDhruHaR+1Se1KJdPeW6epxc6I
         Rqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777957204; x=1778562004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RYBlozxzCL/KPqU6onSXZMaSuqAKVSHz3cyPWSVaa6M=;
        b=S8JvZ49q9WYWHpslgCeusL15hfrvBt/fHvWUTzClt9ZaxCBf5/gMPtD2txm1pYVKL9
         kt4JRr0pzpdnjiLghv++KglmOp9KKLqrIcNtZ97NRyxDvIS/vtpQNWxEJ4+CjmBuZGfq
         igg4jj0ABSscDqY5abWc5FUbfv3hSA15Po2uFI57iyIhZgBpi3Frya49nil+GjSGDKdd
         uBouTAOIDwK9kSZ0dxQPVWsFRN1LwA2RoftnHbKxhId43wFX9Z00FhuQrnJK5tKt9fsA
         bBBgNWLs+UPgrfmnwhPDFx+HMEdGu+IJZzlX/WceIX+UrbUSM62GsMgHAtNfN5sQTDNo
         ACXw==
X-Forwarded-Encrypted: i=1; AFNElJ8U5w0Ycp7MWhy6FN3+UYASXnVQTeUWmQTECWw/gILvALcYh1FBPRWK1VVjQjf7wYynIgVbph0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRVlTwqnUQpjNVJBTM7pHeVHRZKSGpYQSkrqk43+btcpJlef/a
	wsdiHtefDETY0DxnU6rkJp9NZMU0iGMSiNzz76c6AnnKJB/FmjjnIvBJ
X-Gm-Gg: AeBDiesF+Ej9Ovj5ADWbVsdHHTC6/jAfPeDrbh5CouRv5kDx+A4LFYkLWNwLipqxrqq
	w4drlO5HKFUVBKiesTIU3cXqBejJVwZQCbOa9oEikuF/Kc2Ogw6jqSObpGhCcoDV5bE/EQzjZpH
	MDN4OMfvoi7i66H2Mt6hkgKZM0zIldwGXQKITv6Yqa0jiPBbb6ymwYHFpIx2unY7z6HAkunGGUV
	OD0svya4yCSn1PdYi65yvXdtmDBCtkjbIAmsUrG7chQwU6KLNJpJOC8K6V5fGlUiCPTQwtrpv0s
	hqUV7bHinbM1B7UypwPrsebG8f90rNn/S+othwUHSIhczSGvmU0M6sU56vAeVYRyr257G8GwyRh
	73UkHYPf19ickK04KQ+AMlPRtpmsq7Sa7SUBYbJwkRJA2KMD23Z3wW9nOV2U2j/stXVyEGqeXpL
	sxnT4ZDxhn+YNk3TsOYlI4u4twde1K2bAC0HmlMiwlejo3/ZX+SgSzug6fhcOFrsFN5pJLXkPpt
	Pnad0uF/14hb0//RPbHwlfISQ==
X-Received: by 2002:a05:7022:61a:b0:12b:ec67:3529 with SMTP id a92af1059eb24-12dfd7fc727mr5726975c88.14.1777957204506;
        Mon, 04 May 2026 22:00:04 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:94ef:a6f3:2c96:2d58])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df827a73fsm16897502c88.1.2026.05.04.22.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 22:00:03 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Marge Yang <Marge.Yang@tw.synaptics.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 05/20] Input: rmi4 - fix memory leak in rmi_set_attn_data()
Date: Mon,  4 May 2026 21:59:35 -0700
Message-ID: <20260505045952.1570713-5-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260505045952.1570713-1-dmitry.torokhov@gmail.com>
References: <20260505045952.1570713-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4F3134C6A28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243962-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

kfifo_put() returns 0 if the FIFO is full. In this case, we must
free the memory allocated for the attention data to avoid a leak.

Fixes: b908d3cd812a ("Input: synaptics-rmi4 - allow to add attention data")
Cc: stable@vger.kernel.org
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_driver.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 75949fb1a922..d873c7f08e42 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -183,7 +183,11 @@ void rmi_set_attn_data(struct rmi_device *rmi_dev, unsigned long irq_status,
 	attn_data.size = size;
 	attn_data.data = fifo_data;
 
-	kfifo_put(&drvdata->attn_fifo, attn_data);
+	if (!kfifo_put(&drvdata->attn_fifo, attn_data)) {
+		dev_warn_ratelimited(&rmi_dev->dev,
+				     "Failed to enqueue attention data, FIFO full\n");
+		kfree(fifo_data);
+	}
 }
 EXPORT_SYMBOL_GPL(rmi_set_attn_data);
 
-- 
2.54.0.545.g6539524ca2-goog


