Return-Path: <stable+bounces-213292-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLCGM1A1gmmVQgMAu9opvQ
	(envelope-from <stable+bounces-213292-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 18:50:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 681D7DD198
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 18:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCDA430C2CA1
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 17:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A7A357738;
	Tue,  3 Feb 2026 17:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jxd3bWfL"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D138831A065
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 17:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770140569; cv=none; b=DjKajaIle8ObctSLmpMy7OXsvKzYaOxTxAGPXA2GDJhjME3/NdVQNattZXLFrUkYFctmrbjtOnRcC7GEzFqVItq23PGChuKdBMuy7A/ud2PgdsO0avXr/a2ml+hGMWQzQxX98guiFIp4vnc0dUzP4ztTAfDjlYByXIqffFawwj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770140569; c=relaxed/simple;
	bh=XsYfAuikLlaOfTmt/l8n20FoLsRWn3fKrE6HabUSTLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H9/TSEF/qkZVfqoIKugC1gp346IyST20hl9mcTR4XJZQR0Csf6PqLs3xjPHvhz5/YuY7fJai2ElqS9ZlNsDV4iJvAHPn0tLC7jQZ5+C4Ge/RwTTZvaBTGQNPegeb/cWRFkfu+BuWEOjP0Ngud6fC1WDxHq3Pr6wDEvXrLjGRXs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jxd3bWfL; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-65832edee96so584711a12.1
        for <stable@vger.kernel.org>; Tue, 03 Feb 2026 09:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770140566; x=1770745366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iJlB42/KFIlk7GeivHJ/GHOk3Bxvmmpk4HJ11cBcz4Q=;
        b=Jxd3bWfL0aaMhuL9v5xFUYg0a/wwRdauhiRvU3o96AJQT691nxBstIjKHfxzOgwExV
         cDH8WhKPg4RpABk3HnkwtOisD1bfOVDyYomqw8IKEIvC7QtuMSdaovMTmbcP8FQ7zSEq
         bqeGH57kpAAZlmvuT2P++t2dV+81Q5Rr00vFzBVqFqEXM1OFInLMSCZnjdBqC48n+N7P
         z0k987lQZK3JgdFP+KAKvTQJkCLrNfDfUwrJ0x7vXvhd1doP6wsdT9ePtIrxVYaZEWUU
         ydtYzxFp2Ora3XewaF4c5JDDdQy5rXhMtmde6jKP29xFucQqM/4Pyz4GnzP9sGVI9JGW
         un6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770140566; x=1770745366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJlB42/KFIlk7GeivHJ/GHOk3Bxvmmpk4HJ11cBcz4Q=;
        b=NDlpmB3LM6wvDdJWWA8THfrrtIPrFczAG08JmvYgu0EF16OXJXetwLa+3cKJW4US4E
         tJmNWl+sefWF87GR0t0cTGmGyXx2zXH3Pj5xyGQ3ZJ9B0AlofiFuRDIHq2TZhZzAsnlN
         SDVBnYSuw3YpDXcPe5Uu1ziJ2AnZQaVRJtTscE9poelFmzcT5EFFno8xuH6GamS05dEB
         u7XUqThv+LR7oXS5g6KbHDn9+fYV2QtKpTDR+9k8tvetjF96dZsfs3l4w6blgHeNWH2m
         9EfEah9fXRl0h3e5kUFKsgsjYab3oZ6T7fbIrqwhiOcsN05C1LCSiXMLtkrGGWmIVCL7
         6tzw==
X-Forwarded-Encrypted: i=1; AJvYcCUW5ugGjSvWgebcnZ1CARAP91q8nX3GSt4FTtBmywhydUYeo0hB1/Mm9bUAQ3qLEf+v/lTIIZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbeAuVAIKZrf5zabJxqQs+lWNdGyjsGeaNeldAFl63nipyEjB1
	JeqETDXj+kIjydgYXRavL/uVYfMaOJXkr8vy3FFUMUZmThNpPLIU649s
X-Gm-Gg: AZuq6aIUd6bEPuND32e1gac/DYUoGOiBgTZptd5tOLV/0rPvXdtJRyXBZSpfyPq1oau
	b8lBNvEFt6orX9p5fxQUExYPfrYRMLSP3rOPEAreoPloGdVO6VAXTfwlbSuW4OCeG5hYz2netCL
	TLXT/N7cMrXw4QrOVSDwnU3gducH2eLVBfcxfSYtU55gQtjnn7lUFNyQCbziHL/UVTXYx3hSqQs
	oUiZT5P2l20xz1xu6ufueaSzwA/lQ/wDGvofoWdP4OL69aD+EsOchFV2p7ZZfMbCr5r6p6Q9Ne+
	eAnm/Uz/daCBJS0AtwOeeRijz3Q14mgyOXYHW1NttqHzDnidalKUVyp98nN1YQd3L3dFwLTH8na
	79FdmFIHC/eVYRYnx7pfOZ8Uxiq9J/TM9sUrty5d5qbgFTWJmlmd5VeAmD/F3NgZ8c6k9DOqX2j
	S9UBfQJbbJMTqDdgs190W70kgrbMMoiwtyJ6DIg1JHL98SoEQQIxXw/Hpa/Np4l5qi
X-Received: by 2002:a05:6402:13ce:b0:659:3f9d:757b with SMTP id 4fb4d7f45d1cf-659499b8e05mr174881a12.2.1770140565884;
        Tue, 03 Feb 2026 09:42:45 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6594a2168b3sm163968a12.20.2026.02.03.09.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 09:42:45 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	sashal@kernel.org
Cc: oleg@makarenk.ooo,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	tomasz.pakula.oficjalny@gmail.com
Subject: [PATCH] HID: pidff: Fix condition effect bit clearing
Date: Tue,  3 Feb 2026 18:42:41 +0100
Message-ID: <20260203174241.2863219-1-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[makarenk.ooo,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213292-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tomaszpakulaoficjalny@gmail.com,stable@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 681D7DD198
X-Rspamd-Action: no action

As reported by MPDarkGuy on discord, NULL pointer dereferences were
happening because not all the conditional effects bits were cleared.

Properly clear all conditional effect bits from ffbit

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---

Urgent for 6.19 rc period and backports for 6.18

 drivers/hid/usbhid/hid-pidff.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index a4e700b40ba9..56d6af39ba81 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -1452,10 +1452,13 @@ static int pidff_init_fields(struct pidff_device *pidff, struct input_dev *dev)
 		hid_warn(pidff->hid, "unknown ramp effect layout\n");
 
 	if (PIDFF_FIND_FIELDS(set_condition, PID_SET_CONDITION, 1)) {
-		if (test_and_clear_bit(FF_SPRING, dev->ffbit)   ||
-		    test_and_clear_bit(FF_DAMPER, dev->ffbit)   ||
-		    test_and_clear_bit(FF_FRICTION, dev->ffbit) ||
-		    test_and_clear_bit(FF_INERTIA, dev->ffbit))
+		bool test = false;
+
+		test |= test_and_clear_bit(FF_SPRING, dev->ffbit);
+		test |= test_and_clear_bit(FF_DAMPER, dev->ffbit);
+		test |= test_and_clear_bit(FF_FRICTION, dev->ffbit);
+		test |= test_and_clear_bit(FF_INERTIA, dev->ffbit);
+		if (test)
 			hid_warn(pidff->hid, "unknown condition effect layout\n");
 	}
 
-- 
2.52.0


