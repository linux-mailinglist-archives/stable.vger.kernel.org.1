Return-Path: <stable+bounces-249095-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPIkH3bICWropQQAu9opvQ
	(envelope-from <stable+bounces-249095-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 15:53:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 038B1561510
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 15:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED1A3302DF74
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 13:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A399D271A9A;
	Sun, 17 May 2026 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MG9i7Dgs"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AEE26A0DD
	for <stable@vger.kernel.org>; Sun, 17 May 2026 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779025948; cv=none; b=GLgJaju39ixl0BMLqbaSKuzSr+8EU7JWSnTTfWH9x0GrtW2vdQNn2ZOetioHBzXtR1avFfUodLiFvbERxasYYScRsKgt4QBTI46llLW1m0D9eyu2Ac3pDNCuffNDFVW/JGwaJXR4h22WHqGGZLmIbv9qCmu8xOh0OXZZmTdyeng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779025948; c=relaxed/simple;
	bh=DQk88FRBKoFkhbRSS0uCRp3L/0NcM92hszhkFvzYeoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVR/o/wfmNWI6lpW415qoH0Bhz8brv4Sefl0QN0qFOtPdgjCULwRiqYjJFfCJiGTxqP5LvtFcrAretNFtL3aBRt5B8JacyMtyaW1Pt2UOep0lX+lmpzjOK5yt4q2wWHXnp3uhZVWhJ9Kvh69ovG0ELdULLwN7rssCzxVtEyT8eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MG9i7Dgs; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bc7b311e77so4922505ad.0
        for <stable@vger.kernel.org>; Sun, 17 May 2026 06:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779025945; x=1779630745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQuWt3uDzlCPMeJpucga5L6Dcu7cKi0WPlFjpk2QwOw=;
        b=MG9i7DgsjP2oE94PnkUEjycigaWcHjxeCDWeQpYQ//Tdj3/8/jYFJ6dqoJOjqHyrt1
         Bh26IQKK2QoXteIKFB1b5TB3g856r2EojoHA/Z0XsfDKCQrXn5L2rQ9EHFPVBHHdO1BB
         QeMHK0Y/6KBqSzCtO7dTRM9j5SXnhvpwoDeD600TfkjWo72DiXWNSoICgHSgM+CmdWuw
         mAPGHq65INjYtwPNbT2XsD7CQ9ZYIDJRPFs8QuC8fYfxj7cYi/zD1vcGTKCYxcqXUSoA
         umrldlLZGh0Zu54q5XAZjFkJNwT9faqrXtVazL/eZRzzSTa/X1SvkKBLsDovnqdehEss
         KpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779025945; x=1779630745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VQuWt3uDzlCPMeJpucga5L6Dcu7cKi0WPlFjpk2QwOw=;
        b=SEPEh9tZ/uYkb2N3iDE44dwgq1q+OiTdsIaPh7TyHvNZ0kQJBFrhkOcE3RA1Za8k1w
         mntHdwiUO/k/+q9PF2n/4mabo00hJ/ZgG7woFGT/1aR0EkIc0cJu4dEObo7iQnBFbEs3
         ATSQfWhFQWLJZ9/auiLFL27nArlgkWJcgCPYxyFxqVj2FVerVQM87rTrY8ZVHOoG9jz8
         XyZDH63gwXlm/YDWupWkA6bpM2q7ywrUnqOi1YO/eTefBco4Tke3tuixvQn5TdXww9K2
         czA3/+RgGPsJQQoj7kYoeF0TCr0HVgZf0UltJe1K2sxE/L2roU0HOBkcG0H+FsZxP7zg
         K6wg==
X-Forwarded-Encrypted: i=1; AFNElJ/RexdrofB8At/hin6hct+hKmD0MBpQA6kXHzaMd2OYSQE5xe+NdzB3hIKQ1irx+1n7aICnZcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYRj18LVdzlN+43HPwIkO7IsOn+gH6r2yKcGwUX/+e/qjR4y85
	yyUP75Y6jd3bv9PPWTEZcKQ9mQr+9fjymK5TNOpF86hkSuCukENC9ugv
X-Gm-Gg: Acq92OH1vI1vAa3HQydYrtemZuxFwcFelNgoRn1ytSfHn41p6MZPGdVexcQNufjpJVK
	1bB9worOxt2kct+4k3I0ECS0UMGX7XZ11Rf9u45Bx+q+ZXPhKC9uFKlDfjkTXFqF/WHbZH/gkfn
	K4xy06rgVsShoqX2FiqcmRJ0m19RxrgqTGIybaeCH0/65IMnaKTOK0exV3/Tzo8+GooC3KCsl6r
	I7yopjs94n0ZLq1Q/srgsQNDaEh4pKohoJqttQ4AatCFXkPXV2HNJlp4pbSkg+O0QOGmU8fcYB7
	AcT+Ua+8QUaTyNt2/6/BAeYGPTFFNVg74TpquIwQPn9mxUe9s+hLITIgBBl6n5vqP6X3qn8HdBj
	27MipqY3/QE0CyQ+EST01ecxaki/2fSrRk9uQ4jCpfyjKiHWAzggr4hwGE2rTWBhrDAEh6b3/rg
	FoLVjTxiEWlbl5BaGDHbhGS4B5BR+N9AljseBHsa+3blYnRQw+
X-Received: by 2002:a17:903:2281:b0:2ba:7617:a755 with SMTP id d9443c01a7336-2bd5283b74cmr140145355ad.25.1779025944534;
        Sun, 17 May 2026 06:52:24 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fc47sm113873385ad.10.2026.05.17.06.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 06:52:24 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>
Subject: [PATCH 3/4] HID: wacom: validate report length for DTUS handler
Date: Sun, 17 May 2026 22:52:14 +0900
Message-ID: <20260517135215.2220117-4-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260517135215.2220117-1-jinmo44.yang@gmail.com>
References: <20260517135215.2220117-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 038B1561510
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249095-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jinmo44yang@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

wacom_dtus_irq() accesses fixed offsets up to data[6] in the raw HID
report buffer without validating the buffer length. This sub-function
is called from wacom_wac_irq() which receives the length parameter but
does not pass it to the handler.

A malicious USB device can declare a small HID report in its descriptor
and send a matching short report that passes the HID core size check
(csize >= rsize), but the driver assumes a full-size hardware report
layout, leading to slab-out-of-bounds reads.

Add a minimum length check in wacom_wac_irq() before dispatching to
wacom_dtus_irq().

Fixes: 497ab1f290a2 ("Input: wacom - add support for DTU-1031")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
---
 drivers/hid/wacom_wac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 873d58a6d..269e8318f 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3479,6 +3479,8 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 
 	case DTUS:
 	case DTUSX:
+		if (len < 7)
+			return;
 		sync = wacom_dtus_irq(wacom_wac);
 		break;
 
-- 
2.53.0


