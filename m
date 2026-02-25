Return-Path: <stable+bounces-219192-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCrMKcCPnmnTWAQAu9opvQ
	(envelope-from <stable+bounces-219192-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:59:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1542C192347
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB74E3056D9D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 05:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D9A2EB5BA;
	Wed, 25 Feb 2026 05:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="TngYTDV5"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242C12E62A9
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 05:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771999146; cv=none; b=XgR7mlmfgeDXO9Ig4Cq6HUUAGVfSQNei1pvVYOmZtGdPFulBjUpYoiVk4qiDxdSkT0fxmwnhkwh6g6ymPXFYU7ProZkiiB1cG0hQDMWHEXtz6PvIjhDhWdsAz/fi80QMerbF+fiC/VSYaXrPFaqREsNm+zYe4MGtWdooz6PvZbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771999146; c=relaxed/simple;
	bh=4JQx4w2n+4OI7Vl1wqxjMHQQVICYA7ZWx07ppG/b2NA=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=QhMx0mdsRfVTbtDvvEEip/A6+DpzpCHYd/nv/FNAaUm/YigO9rWDFn6/ekxmlwOis+JL9HHLRkr6HsyqU5wnvKdh/Rd2Cz7iRDHJfH69b3IJQeCns1jPGr23o3rXwvxK3rVoJGSUqyAylqqn/CJSjkp/+Fgr7KDGZFo4/+HiaSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=TngYTDV5; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2bdc47747e2so177682eec.0
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 21:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1771999144; x=1772603944; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vudnFxz4M33osWlkGv6xeomBcqA9clEod+3kA1w5Vow=;
        b=TngYTDV5Ig34eJxeWMU5sNadct/zABlFPiZQMsLs974CH/g5AqWIYIzcmhLYaWpTFK
         LD0jgWiRz2uciZLHOWSNbB4ssYjEQtmh9q9eZqj0uwF6jGevUVBMgY6cmIiQLMUaIVyO
         TBn+5JcevYHCFurmJeqrjkENSSkREtH+MzhHLWHdNCTnAtyc6POuP7/1LHBMENyQXxPq
         2IEzpf1aXQ6fCQg1AAQ04LpAXDxO1utrvk6ZqrVAtAOedi/LqnZsKrBqr3ioAm/Yrd+F
         /OMiFbrNYPHYtv65fFkB1S0P5CqKcs6VZaZgos+juMAcsFAUwrbTouq52NOo8r9hfe7g
         TjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771999144; x=1772603944;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vudnFxz4M33osWlkGv6xeomBcqA9clEod+3kA1w5Vow=;
        b=SU/sPl+g0lGTmiBAPKcqHy6L402h2JT4YjiK7n7vPd75gT1GOofo8Iq/JB+nn9EYVP
         APJMOlmbKRSlurSE1f0zVdaRPgkZBQc/3QvoJchI6C+pHwreJ5B5Rt7r9Fwwy0915hby
         8JQWKo5buq+Vs9EGQaXsadXaG4sMO1hSfIXLpBM+Dwfj0s7vJ2z8NJ6uWhFV/wELNTow
         f7aUoU2+xGSOFjIXPc6o3CAj5tOZdykhNGY9I0SUw9yeSDHbbxh+EcjK1oCWWTCFgLOD
         P5pDQboR/fCVYqihiBjkk3Y9Dai6u90b8zXqnMbmyDIRzA6Wjy2GnMQXVaHeM3I9aN6y
         jH+g==
X-Forwarded-Encrypted: i=1; AJvYcCUQNyNaujeeUaLXjvrkXOCIYCvuRBtlfVqaUZpgncuqMt4GJZVh855uYCb2W53cwAfQ7IFHgsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoqthBsoAslIA5ClOaVz6eZH1V0oocM31EFBKB2RSveLHoWeYL
	WwiL7gM2pF+mJL8MF1WuacvL5KM0BxdfzgmgOaTWKialNAUvaW1elA69cTfhwLpDp3E=
X-Gm-Gg: ATEYQzyx41Oes51tokHD4yQSiFOtQe2zrXiT2kkJ6XMmbv2OwI2YQHCDv1IezddtUMp
	xbNwkPJ91W81U7X6zXbaVEezLdCNf1vpw/rH9UqIck0lfJdWcSXQpopskFF10LNPz3HeyVILfwM
	0CC/5cggWsEj5ICafbMXpgio/aX5sKrz8qqW72oKJUjq/3kk3ExxdAoYoPcOlhEV5rOC0e8vBGC
	+pAUPZ2ehzKzDosQ2b7z+w9TpzGlhw/BqcPcktJJN8/0sBBFrzkaVomc7q+awCDqYoOmwv1Gl+O
	GBWCS3nDA/zkhf9etRTZNmQL4z7a+oXQDey6K5wGhGMD/0gxLeEpNwhInKdN6qflfqElFdDz13P
	zkT41bsg19kqSbhkpsWQ2GB6znbznpsS7qwJxy59gtl9fnhXR2GypMqsEghQUqsA/xWPL733yww
	kIpR5QS6SZACSOzxVB
X-Received: by 2002:a05:7300:4312:b0:2ba:8018:cc57 with SMTP id 5a478bee46e88-2bdc31a90acmr475579eec.11.1771999144012;
        Tue, 24 Feb 2026 21:59:04 -0800 (PST)
Received: from d14e337afe00 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7da47778sm8410708eec.6.2026.02.24.21.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 21:59:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.1.y: (build) stack frame size (2488)
 exceeds
 limit (2048) in 'dml314_ModeSuppor...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 25 Feb 2026 05:59:02 -0000
Message-ID: <177199914258.2674.12265888871428194706@d14e337afe00>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://files.kernelci.org/kbuild-clang-21-x86-kselftest-699e5a951f24bb694637d7a6/.config];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219192-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,kernelci-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 1542C192347
X-Rspamd-Action: no action





Hello,

New build issue found on stable-rc/linux-6.1.y:

---
 stack frame size (2488) exceeds limit (2048) in 'dml314_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than] in drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_mode_vba_314.o (drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_mode_vba_314.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:f1b4be4a26884315065156efb6465cdba2bf6b87
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  7bfcb06c4f145be45a942297b9dfbd9bd2771b48


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_mode_vba_314.c:3890:6: error: stack frame size (2488) exceeds limit (2048) in 'dml314_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
 3890 | void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
      |      ^
1 error generated.

=====================================================


# Builds where the incident occurred:

## x86_64_defconfig+kselftest+x86-board on (x86_64):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-x86-kselftest-699e5a951f24bb694637d7a6/.config
- dashboard: https://d.kernelci.org/build/maestro:699e5a951f24bb694637d7a6


#kernelci issue maestro:f1b4be4a26884315065156efb6465cdba2bf6b87

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

