Return-Path: <stable+bounces-218027-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAnYFmw7nmkZUQQAu9opvQ
	(envelope-from <stable+bounces-218027-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 00:59:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B16FF18E380
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 00:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B02FD3058E26
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 23:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFC71D9A66;
	Tue, 24 Feb 2026 23:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Te/l8P/Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE34134CFCB
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 23:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771977550; cv=none; b=MwmVVFb0bO7sVZ3Gsu+K6YQKP3CFvW6x4Hs/Gq3N1Re4jhQJQ90DVdh5jUFGUJJwOa2Ud7PRqrZZxu4KByZzASOPCdNLAynauzffEMruh8LzSt5xFJ+5JsDO1PBSK0Ajr7F2Y1ghbrvmM+MUS1anfh5oXCKhZz21bV+8c4NYlP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771977550; c=relaxed/simple;
	bh=ylzkf5MJU84yyWFaK6nXYUkkVbJhhg0VsRz4jjwraqA=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=QRx86ReO9oZgYNW3rauNvCjC7EM4j0pFTT8x+91EI5/GFKhV9HATtp54FbUxpNhEArRO0T0r3rkQdwEFVqMBfwO7vVOyHvraHB3/W/iBIEwYwNWriBhkw/wt0GMSdicquAG9VlnibkvccvEejMvXRiMEuDzfXSmB3ZpvdkUmVZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=Te/l8P/Q; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2b4520f6b32so7490068eec.0
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 15:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1771977548; x=1772582348; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XC/myOTIM7J6ddPZ53C1dlbf1GfyySf04BMeXJI40g=;
        b=Te/l8P/QXPMt5qMvGSwCIIq5nJvEkYA33rp/jx6Sn/h4grENEjhvUct8G4bAiBlre5
         K2+vKKtCBo82b0A/jt4T/+NdcHiPzYglc9kTP/kdO5I1HomxEQIPW7yhll9f29FiK2PO
         PQLdfOE0Owwr/nIHiUE3UUNPiL/VEt+Jw26hqCI7eV/TGGU/JiJncm+jfnTztxrotxwb
         Db9eoLboXRGcSs0Xr75MGbBmp9PWw92v0k9Zys7sHTkur3JQkazrnFWfF46dtZBTM82a
         EYaHyZ0SvIyhu1nxvJSjEK9eCXRPxoAVWIi1GYEfLm95AfDw9qGct+GJnRV0jnoMPpvb
         5WOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771977548; x=1772582348;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5XC/myOTIM7J6ddPZ53C1dlbf1GfyySf04BMeXJI40g=;
        b=Q/Tt4vHPXu3rLuymUY4PKID9sEDJ8Epv3FgYowHjVVclAEesuwkHjzfm6Jl8KlCiIX
         U7zTAw/VUX7V9RZeWmVA4VVKsArSf/FWLLDvOfIb/jlLctQSvkiRnseUETCYQldTdYTg
         PRBm3jGRfrPh2crrRVDGelEkUX3de1QN6HT/JkQnbmsdcRtXbdj/lNYdQrqQBiNWTeUT
         AyJwiCW1an+l9v+AWAc4L/RKWFgeLEIPbTZdf5bheCB2CcMUChT8mEW2ewW9DB/dloaD
         excengSF3JzwcVCUnHxS4RolD0pITEduAZCcmLD8lXF2xx8/g1cKt+N7SW3u9KcCF/v+
         Pk/g==
X-Forwarded-Encrypted: i=1; AJvYcCXCsRz52NJN3wmT8LdWkCKGHUThs0H1s5S+4/ISKOgWt4omqzk8fQlnjV9t/OuYcYHPoQQrsNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOKW1kaJByvUOZaqkpSv+77YKu4OWS8uZU0YJi0t60I4kNhle8
	P2HBRx1Wpwr4eFNqUawqFI7rmgcFyXNNL81Ko2d0xcPS1vFbFwWiKC/q6h9Ud7DF0gI=
X-Gm-Gg: ATEYQzzjveg+CsoNI+Lq56KO4mdunbTVtIcRdbKwQmg6gOd6fI0sDoPPmGY0UMdj/43
	GZzq/+VQf7pb55/KsoXIXQb89bn2J/E1Uj6JVL1jmqK33KD6exYEbdY9e2UHaL+lfpL93AhV7bO
	VDxJCBMHuHDXuEmQo9SLXyDorpYlpweRF5MCj3E/nwdKReBz5OTB6ZG5jDImRLfuvL93jtrKHDw
	MZlAI0alM3vY/qRUKn8sTU23dBhnhsFRVbzwZH1yE9ofrnwRtgWWYWvLG59Y1kWzBqcxwg2CJkP
	CcNYjke4weYYmiTzrXcMVKG8o5t84A6MzV7XLxuOdRS2zpXIWUZJ8PSHEFHvdvtY7DazL0khjbC
	53lSvL9Tqh78HYLe5qCtfvDmUb6/KtFngD8ZkS2yXnXgIy0JQBTxRWyxkYyvH+j21hFwpoTIEFe
	mF2+Q8bTqoBCbXzld1
X-Received: by 2002:a05:7022:511:b0:119:e55a:9c03 with SMTP id a92af1059eb24-1276ad1d2c2mr5371371c88.31.1771977548244;
        Tue, 24 Feb 2026 15:59:08 -0800 (PST)
Received: from d14e337afe00 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af204acsm12276204c88.4.2026.02.24.15.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 15:59:07 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC02LjYueTogKGJ1aWxkKSBpbXBs?=
 =?utf-8?b?aWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhhdGFfcG9ydF9laF9zY2hl?=
 =?utf-8?b?ZHVsZWTigJk7IGRpZCB5b3UgLi4u?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 24 Feb 2026 23:59:07 -0000
Message-ID: <177197754693.2557.11968571278134867631@d14e337afe00>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://files.kernelci.org/kbuild-gcc-14-i386-kselftest-699e30131f24bb6946377813/.config];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-218027-lists,stable=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,kernelci-org.20230601.gappssmtp.com:server fail,lists.linux.dev:server fail,linux.dev:server fail,kernelci.org:server fail];
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
X-Rspamd-Queue-Id: B16FF18E380
X-Rspamd-Action: no action





Hello,

New build issue found on stable-rc/linux-6.6.y:

---
 implicit declaration of function ‘ata_port_eh_scheduled’; did you mean ‘ata_port_schedule_eh’? [-Wimplicit-function-declaration] in drivers/ata/libata-scsi.o (drivers/ata/libata-scsi.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:d895933295b5cf9768124b6c06ce93ef41b9da58
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  50f5a7e7c328ab5c25ece7f624e1f47af02020cb


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
drivers/ata/libata-scsi.c:1723:20: error: implicit declaration of function ‘ata_port_eh_scheduled’; did you mean ‘ata_port_schedule_eh’? [-Wimplicit-function-declaration]
 1723 |         if (qc && !ata_port_eh_scheduled(ap)) {
      |                    ^~~~~~~~~~~~~~~~~~~~~
      |                    ata_port_schedule_eh

=====================================================


# Builds where the incident occurred:

## cros://chromeos-6.6/x86_64/chromeos-intel-pineview.flavour.config+lab-setup+x86-board+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y on (x86_64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-x86-chromeos-intel-699e30581f24bb6946377866/.config
- dashboard: https://d.kernelci.org/build/maestro:699e30581f24bb6946377866

## defconfig on (riscv):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-riscv-699e301e1f24bb694637781a/.config
- dashboard: https://d.kernelci.org/build/maestro:699e301e1f24bb694637781a

## defconfig+arm64-chromebook+kcidebug+lab-setup on (arm64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm64-chromebook-kcidebug-699e2fef1f24bb69463777f5/.config
- dashboard: https://d.kernelci.org/build/maestro:699e2fef1f24bb69463777f5

## defconfig+lab-setup+kselftest on (arm64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm64-699e2fe01f24bb69463777e6/.config
- dashboard: https://d.kernelci.org/build/maestro:699e2fe01f24bb69463777e6

## i386_defconfig+kselftest on (i386):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-i386-kselftest-699e30131f24bb6946377813/.config
- dashboard: https://d.kernelci.org/build/maestro:699e30131f24bb6946377813

## multi_v7_defconfig on (arm):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm-699e2fc01f24bb69463777cc/.config
- dashboard: https://d.kernelci.org/build/maestro:699e2fc01f24bb69463777cc

## vexpress_defconfig on (arm):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm-vexpress_defconfig-699e2fda1f24bb69463777e1/.config
- dashboard: https://d.kernelci.org/build/maestro:699e2fda1f24bb69463777e1

## x86_64_defconfig+kselftest+x86-board on (x86_64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-x86-kselftest-699e30381f24bb6946377837/.config
- dashboard: https://d.kernelci.org/build/maestro:699e30381f24bb6946377837

## x86_64_defconfig+lab-setup+x86-board+kselftest on (x86_64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-x86-699e30281f24bb6946377826/.config
- dashboard: https://d.kernelci.org/build/maestro:699e30281f24bb6946377826


#kernelci issue maestro:d895933295b5cf9768124b6c06ce93ef41b9da58

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

