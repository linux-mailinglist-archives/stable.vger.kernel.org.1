Return-Path: <stable+bounces-238662-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOERJqZD5WkvgQEAu9opvQ
	(envelope-from <stable+bounces-238662-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 23:05:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43854425837
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 23:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AE42301D05C
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 21:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3612E03EA;
	Sun, 19 Apr 2026 21:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrIG/H/G"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FC82638BC
	for <stable@vger.kernel.org>; Sun, 19 Apr 2026 21:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776632735; cv=none; b=eZVOLve+z2mBt7ldyrV0yjX0naXERE+pR0xdL4qx/X09n696M7PoYIqmsj3+haOb3vnHmsQ6kXVLXva72WAIFp861NaK/moNEd6zsxxtqlX9ZQGv9deLyZhujBsfEnJJDUgmQSp96H5TUyjQUiaSuafrdhwwPNuprf7+2JgA8Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776632735; c=relaxed/simple;
	bh=wpXCRNBaCxqKlOaaC0MIsoVehwLDCC4R+YLVI5RpqWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sJxmkkVHWZ5nqNQSlDf7MbBdhhT4z4kyCVfgOUaSPZ9lQGZcp3gaE1dtAuHO/KnuUuWXYum3GWKcDUVcYGNF2wZfEoIXAkTemhnj8UxmSyeTvKugKkNOEhnj5qSh1R2/STh+PZXLF+SLdWdNiKkRHecIksWB0IOSdIrjc7ZZMc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrIG/H/G; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cb3bae8d3eso210540485a.1
        for <stable@vger.kernel.org>; Sun, 19 Apr 2026 14:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776632732; x=1777237532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JRbHwsbH2iz6+exYEiBRKjwyQU+quSGYfC3YY6YHYIU=;
        b=DrIG/H/Gf9exwcKC/67qtwxLm5CDGBdI86gmZcHSpSasWFttuODzuLN9+ydzg8LMwT
         z1uCA3MVHPs4EMEeFTAaUyMYkzXUhEtJU7aL/CfUk7Gn3AZZ+L8GIwvaPWoWmDPq26q5
         P4tpizM8KuHGfJiWyh0XzW6c+7df1xOHtd92slBKdWFLgoz256sdbyUdqnmN2j6WSeAx
         xczxM1C8FoVljurYQCn6XLGRRfCSsSfVDQj14BlX5iQDxpbdjS0xYkHsZUAaSy1d2sPt
         PHx8MTmAE4DrJCDHM8M3cbvCwHOfXfodVOsA9+0hkYD/uDeI4oxx02WyXRNTAK0rt4yp
         vjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776632732; x=1777237532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRbHwsbH2iz6+exYEiBRKjwyQU+quSGYfC3YY6YHYIU=;
        b=Gh70VsyCkEFrjVJ1jApcY9KavvkeNGtLMwwPsSqXKOikRMq0tpEgVuo7tLhEiSo1p2
         xrRBL5UoGx72p+a3kmBMqnp+fmpVYCwLUpdS7XFBlzaPVvMC6nxTtPiNzZDaZmhomOrO
         coh9HO9xGVBiemSs5nG7Qu6w90X/7bQ+w4fhHfBkTFTtjhV1XPUsY8s/ca5CAGGwxKZV
         U5NrOkXdB/On3SV64XOK91x10mKoXjiU6F8dbgQ8/UTFSjVbhlD767esJnN5Z6gXiPSW
         Pt1BS6qWiyJ22xndrafbCQz4acr71NUZzmnfuBs+ckYlhU8KQnKEyRp+vH6NCcaYanEB
         n6Cg==
X-Forwarded-Encrypted: i=1; AFNElJ8q9FrwXvSyC7FL8lPiuMlLC2cLB/bKYiS/7rXq0QmJJYYSFHdKdMn2sslRjedJMV/ryjQC/Lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxAiOhx7+Cir5PyDKs1LivN/SfGol9eDeS037Xa1k4YdTdiqSQ
	6Sky/aamF/0ErUfPOhiPskus10+TdGwa10l4ChDQeZVe5jA1Ej8lm6xsGB3YeCVG
X-Gm-Gg: AeBDietMLUWgZ47+dNB7WDxTkYmjGkV8ZnK2OhmLJ9ZHZUkFsBXfD2l9u/rhlkldI+B
	3neheJFf3ysKUBI1//SYF6/IZ/l+CVIxZpCsYa0Fpt6ydJoqBC2ngMqv+sJltGeJ94O3HBMLnzM
	gGu/c1b6YN2Rt169LPUz6koEmkfrMzdjXx1gnoYbSOSunzGe2AmMUx3B94RjnzI1BtcI7LeTPYZ
	mL3enoM/0IE9Y2zHfYYwly0tdPfOv5sjLB9OrkYL2c+j/R9YVWhRxO670EkZ7lykWdNg7bjkTRn
	1TLHikDGd3Ii5gv/txXVHJG1cQPhQxiZkOlkjkuLzwKo9fbzsi7kd4nh8Ow+2RjGsOfnEb5yfip
	r0pn8mU7BVm+amjPS9eZUy+QM1bPeBCqsQywWY8ljV3N8RcO6opstJEExK2M70jtKJ82c5WcrCY
	+q0+PUXAQc/jzA03Ez9cgNt66QNtvBzXoiJV94k0+o6NZwls0QlOtzoONsbBHwg4vHpj/MXJNIY
	F3A//HzhRYLyxzowMv9GJQQR4bLBmk=
X-Received: by 2002:a05:620a:7102:b0:8c6:a2f2:d874 with SMTP id af79cd13be357-8e791b9339cmr1542906585a.39.1776632732250;
        Sun, 19 Apr 2026 14:05:32 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8eb9becc72dsm7372385a.34.2026.04.19.14.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 14:05:31 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] scsi: isci: fix use-after-free in device removal path
Date: Sun, 19 Apr 2026 17:04:20 -0400
Message-ID: <20260419210420.2134639-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238662-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 43854425837
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ISCI completion tasklet is initialized in isci_host_alloc()
(drivers/scsi/isci/init.c:496) and scheduled from both MSI-X and
legacy interrupt handlers (drivers/scsi/isci/host.c:223,613).

isci_host_deinit() stops the controller and waits for stop
completion, but it never kills completion_tasklet before teardown
continues. A top-of-function tasklet_kill() is not sufficient here:
interrupts are only disabled when isci_host_stop_complete() runs, so
until wait_for_stop() returns the IRQ handlers can still requeue the
tasklet. The tasklet callback also re-enables interrupts after
draining completions, so killing the tasklet before the source is
quiesced leaves the same race open.

Once wait_for_stop() returns, no further IRQ-driven scheduling can
occur. Kill completion_tasklet there so teardown cannot race a queued
tasklet running on a dead ihost. On remove or unload, the stale
callback can otherwise dereference ihost and touch ihost->smu_registers
after the host lifetime ends.

A UML + KASAN analogue reproduced the failure class both with no
tasklet_kill() and with tasklet_kill() placed before source quiesce,
and stayed clean once the kill happened after quiescing the scheduling
source.

This mirrors commit f6ab594672d4 ("scsi: aic94xx: fix use-after-free
in device removal path"), but ISCI needs the kill after
wait_for_stop().

Fixes: 6f231dda6808 ("isci: Intel(R) C600 Series Chipset Storage Control Unit Driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/scsi/isci/host.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/isci/host.c b/drivers/scsi/isci/host.c
index 6d2f4c831df7..ff199bab5d1a 100644
--- a/drivers/scsi/isci/host.c
+++ b/drivers/scsi/isci/host.c
@@ -1252,6 +1252,9 @@ void isci_host_deinit(struct isci_host *ihost)
 
 	wait_for_stop(ihost);
 
+	/* No further IRQ-driven scheduling can happen past wait_for_stop(). */
+	tasklet_kill(&ihost->completion_tasklet);
+
 	/* phy stop is after controller stop to allow port and device to
 	 * go idle before shutting down the phys, but the expectation is
 	 * that i/o has been shut off well before we reach this
-- 
2.53.0

