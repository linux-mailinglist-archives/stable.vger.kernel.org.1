Return-Path: <stable+bounces-218025-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFgxE2U7nmkZUQQAu9opvQ
	(envelope-from <stable+bounces-218025-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 00:59:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED9218E371
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 00:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EB713055822
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 23:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB13364024;
	Tue, 24 Feb 2026 23:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ZX6aZVhy"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8423B34CFCB
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 23:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771977547; cv=none; b=KQLneKoxEqCGVhCvdlrMvDnZTdGG6qe4PV94whUZIErOj5DcmSIHK8MCzUDpxmV7RASFacjiUzMtUhq6tWkW4XkSzEy2hjiXdec15lPmhuDeaTFxF3M4SKwNZuMzXFOcB+YtgliWCI5yCAveIhCBem2z8cfEe7R1HYddTxjd+mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771977547; c=relaxed/simple;
	bh=00jkRZdmJBChcXQC3YccCSPFn29xZD8U+nFGfyyQVNg=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=a+iDOJB0TLjPd3vpY8GWuyjADZ0cvezahiuFX11S+2ZkiOfINYGQOkq9EPwE6uQ69cZ3wDQ/g/YO5RA9nsP/FpBkUtWt6gGrbw6KosAncgjivXymbzrtVTVm9iFf+WTKL/PnWHdhhODglkEUSyW4VCmonOxdzqzIAutYU5y5DcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=ZX6aZVhy; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so2029706eec.1
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 15:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1771977546; x=1772582346; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLm1cPuoYbQYo1AZQwqxx1MZZElk9EOvKnPuo/7IS2E=;
        b=ZX6aZVhyqup2qk+XZTcCteeUImrKkA+QPWSbqoaB0f9AbwO3QYmbhH/jkCMfmK6LPg
         WFEaxHYi2Ela20FD17VgOaT0zY2Jq9+42rdvLNu9hMGo+RO0fdiZUh+L+sjpypk1MKUA
         Xz5JbngupgAatyZt4iAP387giSdLVZx6mYX4ka+hQgi2k6ZcHQnXp6MhG6nqxzRVEmuk
         0hlMU0COBXGwuBVwo3qmrQP6WFgzrqSVcsV+7S+eEPXxb1XZu2ddLgkgAHTZI9aQZg7d
         D7EpeJtYx9t12YyB3hKxNxcX8p/pfnXwzHEbKHMRMtFEnb2Z1YsUO2MsohwGGt4s+udg
         fyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771977546; x=1772582346;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KLm1cPuoYbQYo1AZQwqxx1MZZElk9EOvKnPuo/7IS2E=;
        b=QGVzxSJXYmZh+R4iRQTiNLu5TZJQ/zVQ2O6sKUCxa3IJB2ga8DGWEqXdmasZ0eP2Ez
         JSB7HmneKZpcxP6+zpamPC5kNh++T52IjpC54pknn3lGQl+L2CkdDJloMrUBMp3Wjlkf
         ExTQBTOnTu1/LjUUjCHaNhpsJjcE3S5SIyWZdkY4q7Mr0OburAgum7f5lnLIlaVPf/3J
         Hf2JcY2YYXEDcz/vGXc8P0D9zTnFtX62ltzWVWiKTowHN0AY9oIfQ8tAPe3NqMLn6tBm
         y1TmowRh9qaZRPf8Pjib7EaYVioz4qWx32BShQzp0Uhp/SrqI0qzi2SNPx+xYdQdm8g8
         /0aw==
X-Forwarded-Encrypted: i=1; AJvYcCXbSgjlR4RrilTyrRF2LVsbDiNYjXd/aozVZO3HQ6KWEmkM9EEXJat7fdeVUCdt5vXKKrOwTS8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywag24w4SCo8fV2flCJ3Kp5QLdATPoJQLQFHHzl5t2zCntegaGi
	M71Jo18KsTPS+AMts5hJEGrQmwC/jLUbUEF3/1/sAeejs+cHhr2n9r3GqLkMMQmnP6qH/hehWHa
	bYDmHnmA=
X-Gm-Gg: ATEYQzyNDxDrYkwRtHGpQ1lELcIvKwXXJJ7EfnlasytzObNafomhnm/xEEDrwfv79bs
	Ujece1sUEWoG2REn8SnLUU1km1AqavKqwiChtkVAG8+7QrU4yzAn2LzBW91GBKtiAF0Vo2a770n
	tByVXk5280BK0ogGjjWaR8ZMIFKkT/jqGtPJqenJKwd7asL9Dxmyyu1DXSXS8DsxfsMbtzI6lsM
	tzhUNffQ2Viw05HDV90zI2QEeZa2PgAdx3g1UaVnupCzXlmtRtlU8wep3y0+i11R7L6dpLePgIy
	dtMeGGLrCBIIgWvN8ZtbtBsvRc1WhaPsrAWHBpW1K7iqHeDU6xqKnvphMQsNvZYd12q3VuDLHrL
	SohNqWJHMOiGtZEKS1PJGdmTeo9OvxLSO8t2DfT7Ubku813erZMwBvIiMK4bmF41ECKbaYn9ZUN
	w0HxRmD5nA3pGgwE3C
X-Received: by 2002:a05:7300:6417:b0:2ba:80fb:42bd with SMTP id 5a478bee46e88-2bd7baea8b4mr6220557eec.14.1771977545641;
        Tue, 24 Feb 2026 15:59:05 -0800 (PST)
Received: from d14e337afe00 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7daa37e9sm7607162eec.11.2026.02.24.15.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 15:59:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.6.y: (build) call to undeclared
 function
 'ata_port_eh_scheduled'; ISO C99 and l...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 24 Feb 2026 23:59:04 -0000
Message-ID: <177197754429.2557.14555836386939659125@d14e337afe00>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://files.kernelci.org/kbuild-clang-21-arm64-kselftest-699e2fa71f24bb69463777b7/.config];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-218025-lists,stable=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[kernelci.org:server fail,sea.lore.kernel.org:server fail,lists.linux.dev:server fail,kernelci-org.20230601.gappssmtp.com:server fail,linux.dev:server fail];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernelci.org];
	DKIM_TRACE(0.00)[kernelci-org.20230601.gappssmtp.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,lists.linux.dev:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernelci.org:url,kernelci.org:email]
X-Rspamd-Queue-Id: 9ED9218E371
X-Rspamd-Action: no action





Hello,

New build issue found on stable-rc/linux-6.6.y:

---
 call to undeclared function 'ata_port_eh_scheduled'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration] in drivers/ata/libata-scsi.o (drivers/ata/libata-scsi.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:d9d0e9abc5d9bb8e50b67659423fe75f30e4bf08
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  50f5a7e7c328ab5c25ece7f624e1f47af02020cb


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
drivers/ata/libata-scsi.c:1723:13: error: call to undeclared function 'ata_port_eh_scheduled'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
 1723 |         if (qc && !ata_port_eh_scheduled(ap)) {
      |                    ^
drivers/ata/libata-scsi.c:1723:13: note: did you mean 'ata_port_schedule_eh'?
./include/linux/libata.h:1345:13: note: 'ata_port_schedule_eh' declared here
 1345 | extern void ata_port_schedule_eh(struct ata_port *ap);
      |             ^
drivers/ata/libata-scsi.c:1768:6: error: call to undeclared function 'ata_port_eh_scheduled'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
 1768 |         if (ata_port_eh_scheduled(ap)) {
      |             ^
  CC      drivers/scsi/scsi_trace.o
2 errors generated.

=====================================================


# Builds where the incident occurred:

## defconfig+arm64-chromebook+kselftest on (arm64):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-arm64-kselftest-699e2fa71f24bb69463777b7/.config
- dashboard: https://d.kernelci.org/build/maestro:699e2fa71f24bb69463777b7

## multi_v7_defconfig on (arm):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-arm-699e2f971f24bb69463777ab/.config
- dashboard: https://d.kernelci.org/build/maestro:699e2f971f24bb69463777ab

## x86_64_defconfig on (x86_64):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-x86-699e2fac1f24bb69463777bf/.config
- dashboard: https://d.kernelci.org/build/maestro:699e2fac1f24bb69463777bf

## x86_64_defconfig+kselftest+x86-board on (x86_64):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-x86-kselftest-699e2fb61f24bb69463777c6/.config
- dashboard: https://d.kernelci.org/build/maestro:699e2fb61f24bb69463777c6


#kernelci issue maestro:d9d0e9abc5d9bb8e50b67659423fe75f30e4bf08

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

