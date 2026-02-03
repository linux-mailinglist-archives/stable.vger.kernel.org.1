Return-Path: <stable+bounces-213296-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCxXJao3gmmVQgMAu9opvQ
	(envelope-from <stable+bounces-213296-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 19:00:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FF1DD3BB
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 19:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7AE2930C1BE9
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 17:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8DA3B8D50;
	Tue,  3 Feb 2026 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="s05iVkkB"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516563ACF05
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770141546; cv=none; b=hw+IA/hf8mzqyZK2ux/2MqyEOJjSKDhRQ7ySZwplP6UZqwr6IhnMD0smaASpSCZw4MdKDYy4i9Gzjh+2MENlkKTVRoBVTDzk1CymU1AIBQ9jZpOlFGqiixqoSxBFK1e4OTHCDZbdURkx1I7JuS/7omsAiO1T5FsATyYTJq3byr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770141546; c=relaxed/simple;
	bh=XyWZczExm45ykrDNsIZJQY1HHlgOxOuAa0/evf4GJCo=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=fI4I/BwIjZsBpjX7a4puHUoLeLGOzElVw0xqB8dEjw5SRCSj92lB16CuP8OAD38YRgAOxVk6UwqJ1vx6ooJObgeDvc6vX4j7/L2AlrOZWPnutxbsE1rwdyUBtgLQZnw1q6jAafcxCDEibmAXiNEU7RtLXSPxkVwSZ2HjYss7N6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=s05iVkkB; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2b7070acfdcso6481082eec.0
        for <stable@vger.kernel.org>; Tue, 03 Feb 2026 09:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1770141544; x=1770746344; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8a2bkMJxQyEDYKpv6oEfCaHQ73f+UNmaq0QY6Na+Ms=;
        b=s05iVkkBIR3MSyvF9T1Uz85p52MnlsjoGQPwUmvwTf0D5chharLYydj7IgtBa9bkok
         dMdmRPiXlXwm8y2DwWbPsXGnfCz5CnSLZDfeoEr/ervtLusH7BoR/V+quPrQOBvqZtNr
         drSZtYIwkhUmf4WvEznqKNludl/asOeMe4l2ydxUvFguY84LashGNSZ84XmRBgfu7O9/
         o/Rsg2FiVFnzjpYuxGYGEvZrKgauOrES5gwOqChY6nUdUUy5bsb/meMmEIiTU/lxFb0F
         7l31kurCv1fPxce3Oz0b+Ekb5QiEmHP0NtGPyp86DgHVNrZ/sIuCPcJs4KUWo3s2iIeZ
         MXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770141544; x=1770746344;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t8a2bkMJxQyEDYKpv6oEfCaHQ73f+UNmaq0QY6Na+Ms=;
        b=UoGp2hwKQ4lVk3Bz7P4Rmmm5RggoUPJK7RrsuHEiGFFRcKoxT+lh4SSXAHhHpv8E8W
         J2waPD50BgU5ZBwXIf/a++IwowXEtw4457wuxo4wu6Y3wlvhNHMK1ucZddhLR5WBvCZX
         D7j5tT0vyvchR7CESUxTHG+RNra/TyaRng/1ta0KaDBisLYsGrwIcvhdxJR0Its5O6jU
         O2S8YecW2ib6AMHL6KB2iWAchhx/5UmYQVRiXBCI6oS9Ur6tneF6j0D1hO5moAeiRIdJ
         Z2mabMte+C54kiUXRg9tQ0QJEff6tTHzPmEF8RYofisADpBt15cBCfy4UcNdG/WnxsXA
         9mnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmGj8y0EvtYsDa8q3bHrQhuPDWfAF+rBCpUi6o2jDZn/d97wkmknQqtnZQyCoeXVrnrnoUZGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHNn+Nkj8dEws8TeO2jUzV9dkxka2M2AEe6uTILkAilMnSdMvd
	7hGA1VKProKH+CHH+rVZ3/e4tB9M5mc+lWy8DGzIR5VopcfE338imzwoPsQZw24rdKo=
X-Gm-Gg: AZuq6aKJbfQPY1eyvhtkybuZ4vJBjQqBgwBzVKeSKTXNzCJiKwSmy7SbXy7mZnDKdNE
	91WteUYAEjKfwBEcIRmEEF9++Au+d+hP+g4k1THy+8Bj98HFS11dgCe+ivVxM8pCVMB2/edEA5j
	A3wucyqtGMw3LsmfYuM7mBV+74g2eZJOg5fN6gOgRkz1a43tMZ0EER+j7vt+8TnCOCOQaF/Ze8v
	6/r6QwkbZblmrpZQqnzbNZ2WSeLjlqwYLyoSzSVGsiklDwjldFydFqpAKCDZhtimkfFIcXdFQM6
	17xwX0YIRfcByRBcJUqVo8P3PRnt0yeH9VHPlPZsrMpOUDSxPirYJvilU7tQKN7/K5BwQLF+9LD
	4MiRihyPY7FiWX6Viht/CAgWTyUrxwJnX7Re7bACJl9hsRRFnVjzeLnZiIZII8o0BzqBPcQe4f3
	lp6vvx
X-Received: by 2002:a05:7301:1296:b0:2b6:af85:dd2d with SMTP id 5a478bee46e88-2b8329826fcmr135588eec.32.1770141544275;
        Tue, 03 Feb 2026 09:59:04 -0800 (PST)
Received: from 22d5995788c3 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832e12893sm155408eec.7.2026.02.03.09.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 09:59:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build) use of undeclared
 identifier
 'atslave' in drivers/dma/at_hdmac.o (...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 03 Feb 2026 17:59:02 -0000
Message-ID: <177014154246.6516.17535917950939771335@22d5995788c3>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://files.kernelci.org/kbuild-clang-21-arm-69822ef7a1ae387ffbbb4653/.config];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213296-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernelci.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernelci-org.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 01FF1DD3BB
X-Rspamd-Action: no action





Hello,

New build issue found on stable-rc/linux-5.10.y:

---
 use of undeclared identifier 'atslave' in drivers/dma/at_hdmac.o (drivers/dma/at_hdmac.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:7783e800918bc9eb672f98d44d530380f7a7dd6c
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  0933d10990a439172d82dc5edc4cde22cca590a1


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
drivers/dma/at_hdmac.c:1583:2: error: use of undeclared identifier 'atslave'
 1583 |         atslave = chan->private;
      |         ^~~~~~~
drivers/dma/at_hdmac.c:1584:6: error: use of undeclared identifier 'atslave'
 1584 |         if (atslave) {
      |             ^~~~~~~
drivers/dma/at_hdmac.c:1585:14: error: use of undeclared identifier 'atslave'
 1585 |                 put_device(atslave->dma_dev);
      |                            ^~~~~~~
  CC      drivers/soc/bcm/brcmstb/biuctrl.o
drivers/dma/at_hdmac.c:1586:9: error: use of undeclared identifier 'atslave'
 1586 |                 kfree(atslave);
      |                       ^~~~~~~
1 warning and 4 errors generated.

=====================================================


# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-arm-69822ef7a1ae387ffbbb4653/.config
- dashboard: https://d.kernelci.org/build/maestro:69822ef7a1ae387ffbbb4653


#kernelci issue maestro:7783e800918bc9eb672f98d44d530380f7a7dd6c

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

