Return-Path: <stable+bounces-218024-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGMnA2I7nmkZUQQAu9opvQ
	(envelope-from <stable+bounces-218024-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 00:59:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD1218E36A
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 00:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65F9E3053745
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 23:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B98363C61;
	Tue, 24 Feb 2026 23:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="LhNIEySS"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFEF1D9A66
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 23:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771977546; cv=none; b=NqaAHV5j5dI6yfO9kDF3y+nzf2jEh7UT/XFCT6Mqgt5149W6b3mYdyyKdqr7bvD3rxtH1Y/rmj/6ruWn8Ecu8jK1yZad8T4B6mI5plaoI5EaLtRL5UpUXlOCKsj+mmwDe1VqGjwqcc8gcXNkhf3DRdV7dhFsAC1tm7SfyYwM6wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771977546; c=relaxed/simple;
	bh=daIX2VAUeRvn1OxzAySUTWbnWrbb6Tut/j724/LejkI=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=MkPIdLSjCXpDwT1GwZc6o0XlPoBh05gkWtl2sPTQ7hzummZom8cRVicM7F1DBBOGbAHNjFD92kezp0JWsk+C0bxas03+Fn99l9v/HE25TC+aM0wv9uwzOZlGXnQHVsbYsAODg42jp0vwmh0MXk+VFrdZdsZJwiaiEvq3dIUUHC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=LhNIEySS; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-126ea4e9694so1568401c88.1
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 15:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1771977544; x=1772582344; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORsz5ou42GbZNiLRo0CYmLp/TuavSZ04yxwmVatFsS4=;
        b=LhNIEySSyxniBOT34E+y/4JbpUJWW3pdRNepHVAVp7ktKrJMMLMUf2uhXGRIAcFmxO
         I14dSbfyNVy5siJXEPsCX+L633XHhnNb3zaUuiYmBcSw0sZougqBR/ulSNrsE0K6kcLT
         Rbb7LCEacf1Di+jYOIQsyO2D2/7Ks0xdkPCH1Q6EQlDoYU6shC6lUL4qLZxycwNz4UbX
         hh1aK2tb2GcQb0jE+vDmcPUozSpsibkqr04mQttygZHayHyyV6l4eGtXtEvo1ob/MtPH
         4jhLLfbqI2Axb/5DT2rrVoKVfpoKM4Pgv+fzcD/Xo8p1QLszyBpFbgT2U+KJVbBXfYz0
         spSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771977544; x=1772582344;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ORsz5ou42GbZNiLRo0CYmLp/TuavSZ04yxwmVatFsS4=;
        b=AQvb5ACokXdkh7tXLHktPbtHvl3RgS3GvO6IdI/+ckhYB/hGkrLQGaQunBsnJmfGSk
         8klFcNC+0MI65m2IISz7p02FcCBdjydx++ykuFazW2CuQQBbaBNQKZW8YGTyKsf/qT4k
         V2X+XNSDJyBerkJf/2pW1TTgMtEs6ObbVWuHpKDEdHJcjTJAucO8xXmIKxEzhzhAxiKC
         K6tLVrAg3ddLCfgJwXzSu9iPPg7bzjW6zxK6yLbf78ARggBdURZc51szENmb6JiymMEP
         bsJP/BsItHjhdL5TXM0Xjo27xKY+M9pqManioIVyqdSN7gWlQsLVn4a4JgA2ig/txkJr
         mzBg==
X-Forwarded-Encrypted: i=1; AJvYcCX5VkhEU7iSBPv9AaNDJFFZwdwcXOKZCkp5T29LGPYnrMmtayPMBUdaSqet+UlXSyXPOcOQFW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQSkiHMkRatrZYnbp4SkQUUZSG1V727OVqWTJssEiy0tUZmCEy
	F/7jv2kgzXo6em+7ioEEMtmExjjFOEH5uye2FTdicKImJJyzESqKG78j6kB9SrOEn1U=
X-Gm-Gg: ATEYQzzbTeFJ7Oz6NhJqQMUFLN4UT1JyfcupIHIh3mBMvF/3OC7as+dTaMH3T2zNAOp
	AYQ8J61jlc3sb94lcyzom6Jy6ZRAgQLLKajMSHfKqWe/H4K9+C2dsU6s125lal70UpjqtzTZlik
	Bqqj9m7woqmcCo+u7/ccF2kxqdn9S62BI7QLhoEAMyRYDxo+3GmJf3oznQipvAYeV8jtM7aw4UD
	lSbDGfV7zeK4//S3/Of70qfnGH8lnBi77s+MXfEeILPaxN2/+/gELRPBoqhCfpI4X+gg1msr/Y6
	FoFz0vJLKFPfRRAwRMU4w5QcyTSUWuLQ0tCGAsrLOGOnXa49s0/i0vWPVq+DD+H8Fy83J5dhiRD
	m7mRdTFpiPOl81x2w3UTBBX/qBJKgY1i8i1szQt/4kITpu5rxxMh48OY3u2wpN8XKqKFTCuyoy2
	zfL0hkICo5Q7VYucgZ
X-Received: by 2002:a05:7022:310:b0:119:e56b:957d with SMTP id a92af1059eb24-1276acb20ffmr4932821c88.2.1771977544071;
        Tue, 24 Feb 2026 15:59:04 -0800 (PST)
Received: from d14e337afe00 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7da3eefasm7689666eec.5.2026.02.24.15.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 15:59:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.12.y: (build) call to undeclared
 function
 'ata_port_eh_scheduled'; ISO C99 and l...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 24 Feb 2026 23:59:03 -0000
Message-ID: <177197754281.2557.16813344451558204900@d14e337afe00>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://files.kernelci.org/kbuild-clang-21-arm64-kselftest-699e306d1f24bb694637788c/.config];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-218024-lists,stable=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[lists.linux.dev:server fail,kernelci-org.20230601.gappssmtp.com:server fail,sea.lore.kernel.org:server fail,kernelci.org:server fail,linux.dev:server fail];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernelci.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernelci-org.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernelci.org:url,kernelci.org:email,linux.dev:email,lists.linux.dev:replyto]
X-Rspamd-Queue-Id: 5AD1218E36A
X-Rspamd-Action: no action





Hello,

New build issue found on stable-rc/linux-6.12.y:

---
 call to undeclared function 'ata_port_eh_scheduled'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration] in drivers/ata/libata-scsi.o (drivers/ata/libata-scsi.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:fede1461e236b5d7cdde3654090df9779fdff018
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  10fde7454a72064486a5b75cbb1635da42004473


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
drivers/ata/libata-scsi.c:1689:13: error: call to undeclared function 'ata_port_eh_scheduled'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
 1689 |         if (qc && !ata_port_eh_scheduled(ap)) {
      |                    ^
drivers/ata/libata-scsi.c:1689:13: note: did you mean 'ata_port_schedule_eh'?
./include/linux/libata.h:1407:13: note: 'ata_port_schedule_eh' declared here
 1407 | extern void ata_port_schedule_eh(struct ata_port *ap);
      |             ^
drivers/ata/libata-scsi.c:1734:6: error: call to undeclared function 'ata_port_eh_scheduled'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
 1734 |         if (ata_port_eh_scheduled(ap)) {
      |             ^
2 errors generated.

=====================================================


# Builds where the incident occurred:

## defconfig+arm64-chromebook+kselftest on (arm64):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-arm64-kselftest-699e306d1f24bb694637788c/.config
- dashboard: https://d.kernelci.org/build/maestro:699e306d1f24bb694637788c

## multi_v7_defconfig on (arm):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-arm-699e305e1f24bb6946377877/.config
- dashboard: https://d.kernelci.org/build/maestro:699e305e1f24bb6946377877


#kernelci issue maestro:fede1461e236b5d7cdde3654090df9779fdff018

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

