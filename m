Return-Path: <stable+bounces-248677-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA46HSVRB2rBxgIAu9opvQ
	(envelope-from <stable+bounces-248677-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:00:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E11505544F5
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4FAD315D2A6
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68CC3F928C;
	Fri, 15 May 2026 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="fZrOtLrL"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C4F3F9285
	for <stable@vger.kernel.org>; Fri, 15 May 2026 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862345; cv=none; b=cv/8rVJRtYm+pv+MWSzocqtWBdigX4oc2CvhBpqxPjJ5NOCXel07DQ9CsiyVj8CY9AeNFKFHZkiEEnO6k4Yi93WBtUdbkibdjBJui4YjHxJsetECAnaJmNLtdPGB1a/kyM3aEGyVzL611mh8sTbcfS5/Pu4K2TaNp2RVs/ZASms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862345; c=relaxed/simple;
	bh=dPAlCQ7CamKJWpH3yYFUpq/IoYtHj+j7eQfz/0JyHZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXw+n6NHnDOHCF+LknE5npH0c5qt3bN+bcIFMPLlHZsnWP/PXyFlRLOvWw5e7JNkC7xIEbP1CSz9i7CcRR0U+sbqrHjDzC7qhKkVpfqivykNiwKfknLmD+0rPcBgXHTtz4Ob/SeThcKl2LnJW7NvboGm0WF5pbBvl6dFRKTpZmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=fZrOtLrL; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4824b15c19eso5985449b6e.2
        for <stable@vger.kernel.org>; Fri, 15 May 2026 09:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1778862343; x=1779467143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXVodw1E6K24BZjEFIdMFaaX39L55IwMJxB4Jx+bt2c=;
        b=fZrOtLrL/9IhZ6NPeyoGlJvNBgEnRFOKCsDVlsPJYx/FB+uJMg+0M+Rg71XpoLzi4A
         voMastX3N57h315MADyviLhjuu6b20QngJUp/i39vJ6SG+sHi/QU5bwbOV1y3NryLfSZ
         efPB3th40erWrfv2Q6CyyFGBfjccdZsB48gHb+wOhFlxFf2k7cx7kKOLQPCMO52PsPje
         J5NvMkxoM9zwj/1uH9tuvkA7yRADgbLE5PkqZjSes8TISnChoF093y58NkRjiarNNEAw
         JPW4GcmdoXgrmvm/b7I/WYV2S7ieN9fll4gE1Ekvne7H8wjiGcjOHzV+5M1nV6w2Ynd2
         vPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778862343; x=1779467143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gXVodw1E6K24BZjEFIdMFaaX39L55IwMJxB4Jx+bt2c=;
        b=kN/k3NpCHP7loFr7G0SbRSPC1rjvV5gQR6xOKBvI5Ab/dgiU1cvCoSaDvMmWDIUNEe
         lZxO7dlb6PKWx7RxP9Ga7Y79hXw6CP1Gvc0BqosQCi3zo6vNrb4Ck6GXysTSjJdqcPTI
         T7KbtNoCdniNxBiubS4WKfcygF/HH6TrUTaA4VCFrz+1SV3Wc/JfwQn56MhtPcyu8rBk
         K85RcWMaTJPLOLBJpr8AfFk2B4QPQ9L3sBkl8Lp4tyborettLDiwaElh2XyTCas4E+8U
         zTMNjSWMKmx4sg4BKNxd6R4XwoqvYql8ld5P2IYsDUaIxKQEOr+VLI/13Mzoqala926r
         g2eQ==
X-Gm-Message-State: AOJu0YxCowwlidgAoPppzDl57vZx0Vhl4/U4n0DVey0ZgQfdn/D0iwVe
	xeV9mAIIYjnyL9jiCUnCfW0qb/uEaYjo2m9SgJ3b0UZtyIQ7IqWBUuKenCpvRx/O1YafpGEwU1h
	sz+4z
X-Gm-Gg: Acq92OEUN8PwjuZsfgPXkuvCtaXNj3S7a9nAD8e9RT+/m6dEyhdjhGZbfdX8eMiMhqR
	i8dsntajN1pK6fBlsT5oHC59KEufPUHXmQ6tADFa0DtEzlcZcUKkq6IfieU2rHIlSZQFN6Lzz5b
	KqMyaVuUTM+wozDXV8vO2O/z9SjuI43xFU9JtiHL+AX+7RV/1CjaycTUcfxBrzq/rgvgJKeUkUV
	d0ZNSExLEWEyDhVaifPV7rzKWltKa4/GuknrDyfSU1kkLjQsCdLWXFUgFKKJsMuLPDzdiv7uATp
	5W4yUVjt1SkpvmeciYqgLglPB7FWptM5f/v4aBHS0L8I+fUVPabdeysZlHm+V6as+5uSLlE59Uq
	4V7pUy5Ypff/cyKiaxzuxIGBBytubr8DKcqVyPqlz+SYo0hEsSnR+D/zsZ7Y6ja/GI61Lea8fnQ
	1a1HMbptmHlXY/CoUz0U9HnXWpf1FParu9tPpeHn4xy4SSronwZwYeJZ1Xn9tPRsdWKEu0o+tkF
	Qe83PRuO1Tr5KM=
X-Received: by 2002:a05:6820:150b:b0:694:9861:ec4d with SMTP id 006d021491bc7-69c94369755mr2846790eaf.29.1778862343457;
        Fri, 15 May 2026 09:25:43 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:5de0:f9c5:a427:bb0])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-439fc5c0af6sm4660687fac.17.2026.05.15.09.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 09:25:43 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: stable@vger.kernel.org
Cc: Corey Minyard <corey@minyard.net>
Subject: [PATCH 5.10.y 2/2] ipmi:ssif: NULL thread on error
Date: Fri, 15 May 2026 11:25:36 -0500
Message-ID: <20260515162536.2222586-2-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515162536.2222586-1-corey@minyard.net>
References: <2026051541-privatize-sweat-2418@gregkh>
 <20260515162536.2222586-1-corey@minyard.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E11505544F5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248677-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[minyard.net:email,minyard.net:mid,minyard.net:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Cleanup code was checking the thread for NULL, but it was possibly
a PTR_ERR() in one spot.

Spotted with static analysis.

Link: https://sourceforge.net/p/openipmi/mailman/message/59324676/
Fixes: 75c486cb1bca ("ipmi:ssif: Clean up kthread on errors")
Cc: <stable@vger.kernel.org> # 91eb7ec72612: ipmi:ssif: Remove unnecessary indention
Cc: stable@vger.kernel.org
Signed-off-by: Corey Minyard <corey@minyard.net>
(cherry picked from commit a8aebe93a4938c0ca1941eeaae821738f869be3d)
---
 drivers/char/ipmi/ipmi_ssif.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 266a5f223739..71622a95517a 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1880,6 +1880,7 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
 					"kssif%4.4x", thread_num);
 	if (IS_ERR(ssif_info->thread)) {
 		rv = PTR_ERR(ssif_info->thread);
+		ssif_info->thread = NULL;
 		dev_notice(&ssif_info->client->dev,
 			   "Could not start kernel thread: error %d\n",
 			   rv);
-- 
2.43.0


