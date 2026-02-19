Return-Path: <stable+bounces-217463-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JqMFF9Bl2lXwAIAu9opvQ
	(envelope-from <stable+bounces-217463-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 17:59:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B29160DCD
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 17:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32F593028364
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 16:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA02F34CFB9;
	Thu, 19 Feb 2026 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="1hQYIBZ4"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4D8F507
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771520347; cv=none; b=dy7Xd9c6MQM0fW053jeJp9JjqQq/ETaekvrN1yDX/D3XAYEbtxBW99BWGvclmXOfVcNx11rk3SAPP0CbbGs9m7YdwXFG0XNar4I2t26XUVH+wW0mHiDsUGBW3Q5zsAo1HTl0ugH/FpfeQ7Ne0WKThLfSLwqRpx+ea55k8AiElGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771520347; c=relaxed/simple;
	bh=uc6//qM7RSyua4jVbI4TS+aO1l5SshYzUrKKYL/ihb4=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=EbargajHjp9UMGEPV1U7JKQnLSdC4/j45JgG+3wG8HkgPl14RvXNGtAVL+zkuP9IQTgF+HZwOE6JGmN8BnbQoC9UqnJzP/O4tI+ah0z4XUhxvbjXV2wf0I3ktUJsfFnF7g4rOXzOT/tg+WtP+4pBmTgMLGi1coTdf2RYbUyAweE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=1hQYIBZ4; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-127423bea4bso95162c88.0
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 08:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1771520345; x=1772125145; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TazV2Mfx4AWxoMb7Ln2DbhJ2thA70KIsj1RNl3kuPfs=;
        b=1hQYIBZ4FsujkZXVFvmsa8/VxjGq3xWdknVXHoPCMr1RQFrEsmGGoImHZ0nJg2IUu/
         pSbEyZ1or42S/zCm9HgFd+c15wI0Gba8tgG7L74YebaaXedIe/W6fn+TAQTslGrpt175
         fZieRjfazEDO28tuf5yYWJoSq7KZ8Zzv4HQXm/+8m9W1CwQ8K/sM1OOxqVCEVVgAyCdX
         VqeyIZE2OXpQMd85Mkb+ytDdpXEr38HyxUnbfelGq35SQpU1v+m2IFs3otX1F/VB0ipC
         sEgnYCA45uwkyh9xlBHmcm7Xibh2I6+rBLXXoGUBjKCmt+cB2kGSc8FuQaMR21yzrvv/
         bj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771520345; x=1772125145;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TazV2Mfx4AWxoMb7Ln2DbhJ2thA70KIsj1RNl3kuPfs=;
        b=gUkldtEtePoef7t4vBWGx6vSnHLki5qrCJnFPg68hHOBbQs3giAAU2WTymeaxtLXB+
         qnTG5ZqiQXNvhR4U1YVBdbwV4VwrdpLSECg8DYEqUfynLkkSBDrEYfeOpr9wqmUhjmSa
         JQPyTuLll29ZYfmySoG9IgFVTdNOYdniNBRN9ycEYvgaknfUVWhES+szq3L6/DhM0QNG
         fIYCCB6zcCoNF82qZRphqRk3yWFcARoCw6GCM4fTho68gEMHmMwZO0oQ/fpP5M3Khr83
         yP3EdDZOUhW9hLbrWs3kE3chK5MQbcDDLh52BgFeCGLIMe+dsVzrmSonKJyfQZM6hOHL
         oBPA==
X-Forwarded-Encrypted: i=1; AJvYcCXmdW2TNI/XP72mR/doi2EcQ+oj/cdZC2cFn3Rk291puxRErUW0Dnb9py2cMFchQXSc9VZ33Q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMB4aSxrbXi03BPQsOIwXR2xolEiAHce/fvwffEshGMxGcwp6U
	AoRbkx/aROVQHYrrtPrv+vFDw8MyoDXH4KKp4GTJKuD7SQ6q24FgD9KfF4jG6maoAlUPVTUhrRc
	1fpCvm2g=
X-Gm-Gg: AZuq6aIxMGxsQ6bpQeGGzXp4FYFrGC//QDMiMeINbjLUA00xU4hTkAIFvq97fsqQfac
	jt0Hcwi40isISaAFnxwXvOTQF25PRF46sUN/sNRNg1+9XQ85C1FJi8l7nuIbvlj841jHUZq9gvA
	tttLn1jEfmdcMa+g46ydtQinxmK+TjwQPqVE6M9pyGpJyA51Ud/GzM0qsTkgw5KzHgAS2uF32jn
	prMTYO7JvuD7IPWpnsS8+EtxNEwxjLlfl6KMdt8pZ5oroHZz7gsK0RwBeG4QPLwm23zBEea3HgC
	XLGcLS4RFmVqEWuP05VP99ggHavSHcCGLuf9KOyHD08bCziLUaUyQ89CZ5S7jVLbMbsZqcT0aQi
	VuaaXMAOlSz0dJ01Rtbc7rHIp4agycgsj9iZp1fOAjxHh/FSdehVYLG3FX34EGWjfxd4mzqK4PC
	Qx7SjgkA/V1WRZ62Iy
X-Received: by 2002:a05:7022:4584:b0:11b:9386:8262 with SMTP id a92af1059eb24-1273ae8d7dbmr8460631c88.47.1771520345087;
        Thu, 19 Feb 2026 08:59:05 -0800 (PST)
Received: from d14e337afe00 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742cc9376sm25612344c88.16.2026.02.19.08.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 08:59:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.1.y: (build) stack frame size (2456)
 exceeds
 limit (2048) in 'dml31_ModeSupport...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 19 Feb 2026 16:59:04 -0000
Message-ID: <177152034349.119.6431923116518979346@d14e337afe00>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://files.kernelci.org/kbuild-clang-21-x86-kselftest-69973d5a7b34c3305539ab72/.config];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217463-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,lists.linux.dev:replyto]
X-Rspamd-Queue-Id: 92B29160DCD
X-Rspamd-Action: no action





Hello,

New build issue found on stable-rc/linux-6.1.y:

---
 stack frame size (2456) exceeds limit (2048) in 'dml31_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than] in drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.o (drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:8142d3efa880b8ebb062bcaa4e5b10da200f4575
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  779f9571ac3e3b2c969690d09e5353f56b7ed4ef
- tags: v6.1.164

Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c:3795:6: error: stack frame size (2456) exceeds limit (2048) in 'dml31_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
 3795 | void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
      |      ^
  CC      drivers/i2c/busses/i2c-i801.o
1 error generated.

=====================================================


# Builds where the incident occurred:

## x86_64_defconfig+kselftest+x86-board on (x86_64):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-x86-kselftest-69973d5a7b34c3305539ab72/.config
- dashboard: https://d.kernelci.org/build/maestro:69973d5a7b34c3305539ab72


#kernelci issue maestro:8142d3efa880b8ebb062bcaa4e5b10da200f4575

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

