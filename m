Return-Path: <stable+bounces-247721-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKRRHk4QB2qbrAIAu9opvQ
	(envelope-from <stable+bounces-247721-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:23:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC27E54F69B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52C1B31BAB5D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2D947ECC8;
	Fri, 15 May 2026 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="blqFfinb"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AE147DD5B
	for <stable@vger.kernel.org>; Fri, 15 May 2026 11:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778846349; cv=none; b=ObVXSxnKqpzvwccEYiSSdm62U66U588w9D5D5zknJml0kKOulLfoyFxaryZP+wrkDBmp359kBnquSMwhhPJENyxVV1xV7+80ds7S+/Op8H5FMdH+KtHUSG51BHsIb87Khbqi5Wz36LvyR6kjdhw1b9tnAU9DoRz/xMY2RZszW+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778846349; c=relaxed/simple;
	bh=0B8ApGYivAEczXCssUckYdi4GgOP9YSdqF/0SJbosk8=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=fonAjdoJcEWE71YVvSR0+C1p8As4xjFStSjKENmbFZ1HbnVkm8gEVEplFwUmMPFURp/l/F7y3Eydclrv7wS4dzuDQogbyZ4upFbrChG6E5N4A1tfCvCrxFsxXD61ct6q0GgaIu0Ewr2pP18hVO1StiRv9262HqSsu389ULR05MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=blqFfinb; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2f7020a928eso12801314eec.1
        for <stable@vger.kernel.org>; Fri, 15 May 2026 04:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1778846347; x=1779451147; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Oh6MEifgRnI2/pHuTh9e42ZaqzXyvmbr4tjZ0GfSCA=;
        b=blqFfinb54iVtSzRV9yuSRaOVWfqfdISDSNoXQ+aIrbVVlG+srbUpXlsASLoitTsKH
         SGF1EZS7V93PGev9/a+LjKDgnuVl9njqyx1z1ARptNuie5PQAoTTfD7znVIA2+K23eIa
         4KLoHwIxV1hkNFg3STdn+YO9JIowXbLUcKbTILZDUD1PwPs17UX4EKVa3zr9ZHrLQBQ6
         VCb2jY04zhIBw4m/d3kvQ7s2eJENISgDLdJJ5TVMXTne4BfG/tsWIVG/ut5QC7JLedMc
         PrA3V9B99pGusW+L0jdEu+fiHwNOLPLBTWxbPhRmOCu+8rXtlpZKgmfKXsAUmafrGmax
         MLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778846347; x=1779451147;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Oh6MEifgRnI2/pHuTh9e42ZaqzXyvmbr4tjZ0GfSCA=;
        b=rG7huyFzclFSx35lpecV3QBqShDq8Ubcv0slm9N61nDlbfvH0PZEsP4pPbLJm0LPYS
         AvhGaK7Sc1uAqQuaRV0b6HFgtXtb+Ks4TijKCec6bvWubk+ywp7UGDA9/j+Pam05L/dg
         kz9VsEoJ+X2OnKSqg6IDWgLUF4SkDXdrHzJ/CrLRT7EMCbjKsQB9GQu8gsDE735gazoV
         Y3hwi1ZYZ74BwlFG8Wje1IN3SsTKuVbhDB73y/jK2iLCkJoKV3PuKi/qB65USflO7ZdP
         1Oq7asxjLSrUUZmd25VeA8L67w9st7ykPJBzAiY5zAOW+qW27XA9yNHlvFjpRRoE4OBG
         IZSQ==
X-Forwarded-Encrypted: i=1; AFNElJ9oDRAvzrdCh2SSQRDLHUjICyPuB0WshFzKEqIcaKoJRC7BRk1JHwRoOyFYUGcBemf36JC8xro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu4YKeU9fNzijl+Mg06MZMZIK50dNOM3QXhY86xLUhhO60GznI
	kz7HlJLVdVQnLyyy4f55MClLE4vWlm8gQOl+nqK6GSN91QtdaO1O7k30y8QkWf1DGfo=
X-Gm-Gg: Acq92OGwv92ZPmB+qFA9m+6NxLVIq/3BXqaIVMcjNAIJTs6uuaXAw1PDgKGUGg6BoSY
	BPOPaicUulE16TuAwSp8WI/5FacJeO6VpVDVzL3qKkslZ81aZ3zLzKtsPwSclq5/T5CXhwS99sP
	AD6mMmN5TiGZvt7MaIEdmt4G2ah0jjWzKI3h8xwePxZarP4ojEVaNAHwno9pRwlR3Gvg6rZxz+1
	2lqu3aA3x8osyHv9yH02/7Y3sJLxeSmK+sL8xf0X3tfqPYuuTmqI4D0kx7SndGEN905XVruDsp6
	DHlIZ8y/oxVI3kFDfUghwMmazk9gMocwkhdfsu/Nhgel9UNCmVjTZstoVdYmJkgrOGKNacHrFIu
	FLrU8ZyhhgjaTyPH1fWZWnZuUuec7aosVNQx09GHytKHP/IDeAjzcdKupK6jWVyzTeoHyVH3D3z
	Q1LmbZmk6ikLam70a+B33g/TWQIc0=
X-Received: by 2002:a05:7301:400a:b0:2f1:496c:94d4 with SMTP id 5a478bee46e88-3039818b081mr1615635eec.4.1778846347267;
        Fri, 15 May 2026 04:59:07 -0700 (PDT)
Received: from 330cfa3079ca ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302973bcc5asm6531287eec.22.2026.05.15.04.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 04:59:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC02LjE4Lnk6IChidWlsZCkgZm9y?=
 =?utf-8?b?bWF0IOKAmCVsZOKAmSBleHBlY3RzIGFyZ3VtZW50IG9mIHR5cGUg4oCYbG9uZyBp?=
 =?utf-8?b?bnTigJksIGJ1dCBhcmd1bWVudCA1IGguLi4=?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 15 May 2026 11:59:06 -0000
Message-ID: <177884634587.947.9605633365065144443@330cfa3079ca>
X-Rspamd-Queue-Id: DC27E54F69B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	URI_HIDDEN_PATH(1.00)[https://files.kernelci.org/kbuild-gcc-14-i386-6a06f8890ed99f002e8c2ef2/.config];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernelci.org,reject];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247721-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernelci.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,lists.linux.dev:replyto]
X-Rspamd-Action: no action





Hello,

New build issue found on stable-rc/linux-6.18.y:

---
 format ‘%ld’ expects argument of type ‘long int’, but argument 5 has type ‘size_t’ {aka ‘unsigned int’} [-Werror=format=] in drivers/hid/hid-core.o (drivers/hid/hid-core.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:c55fed57497d1954be35cc17f34d231894d01bd8
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  a62b7e0d3cbfc22f02ef8da41210d6921c1120cc


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
drivers/hid/hid-core.c:2049:43: error: format ‘%ld’ expects argument of type ‘long int’, but argument 5 has type ‘size_t’ {aka ‘unsigned int’} [-Werror=format=]
 2049 |                 hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %ld)\n",
      |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/dev_printk.h:110:30: note: in definition of macro ‘dev_printk_index_wrap’
  110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
      |                              ^~~
./include/linux/dev_printk.h:156:61: note: in expansion of macro ‘dev_fmt’
  156 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
      |                                                             ^~~~~~~
./include/linux/dev_printk.h:215:17: note: in expansion of macro ‘dev_warn’
  215 |                 dev_level(dev, fmt, ##__VA_ARGS__);                     \
      |                 ^~~~~~~~~
./include/linux/dev_printk.h:227:9: note: in expansion of macro ‘dev_level_ratelimited’
  227 |         dev_level_ratelimited(dev_warn, dev, fmt, ##__VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~~~~~~
./include/linux/hid.h:1302:9: note: in expansion of macro ‘dev_warn_ratelimited’
 1302 |         dev_warn_ratelimited(&(hid)->dev, fmt, ##__VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~~~~~
drivers/hid/hid-core.c:2049:17: note: in expansion of macro ‘hid_warn_ratelimited’
 2049 |                 hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %ld)\n",
      |                 ^~~~~~~~~~~~~~~~~~~~
drivers/hid/hid-core.c:2049:91: note: format string is defined here
 2049 |                 hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %ld)\n",
      |                                                                                         ~~^
      |                                                                                           |
      |                                                                                           long int
      |                                                                                         %d
drivers/hid/hid-core.c:2071:43: error: format ‘%ld’ expects argument of type ‘long int’, but argument 5 has type ‘size_t’ {aka ‘unsigned int’} [-Werror=format=]
 2071 |                 hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %ld)\n",
      |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/dev_printk.h:110:30: note: in definition of macro ‘dev_printk_index_wrap’
  110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
      |                              ^~~
./include/linux/dev_printk.h:156:61: note: in expansion of macro ‘dev_fmt’
  156 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
      |                                                             ^~~~~~~
./include/linux/dev_printk.h:215:17: note: in expansion of macro ‘dev_warn’
  215 |                 dev_level(dev, fmt, ##__VA_ARGS__);                     \
      |                 ^~~~~~~~~
./include/linux/dev_printk.h:227:9: note: in expansion of macro ‘dev_level_ratelimited’
  227 |         dev_level_ratelimited(dev_warn, dev, fmt, ##__VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~~~~~~
./include/linux/hid.h:1302:9: note: in expansion of macro ‘dev_warn_ratelimited’
 1302 |         dev_warn_ratelimited(&(hid)->dev, fmt, ##__VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~~~~~
drivers/hid/hid-core.c:2071:17: note: in expansion of macro ‘hid_warn_ratelimited’
 2071 |                 hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %ld)\n",
      |                 ^~~~~~~~~~~~~~~~~~~~
drivers/hid/hid-core.c:2071:92: note: format string is defined here
 2071 |                 hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %ld)\n",
      |                                                                                          ~~^
      |                                                                                            |
      |                                                                                            long int
      |                                                                                          %d
  CC      drivers/firmware/efi/memmap.o
  CC      drivers/mmc/core/sdio_io.o
  CC      drivers/gpu/drm/i915/gt/intel_gt_pm_irq.o
  CC      drivers/platform/x86/wmi.o
  CC      drivers/md/dm-kcopyd.o
  CC      drivers/firmware/efi/capsule.o
  CC      drivers/gpu/drm/amd/amdgpu/amdgpu_mca.o
  CC      drivers/mmc/core/sdio_irq.o
cc1: all warnings being treated as errors

=====================================================


# Builds where the incident occurred:

## defconfig+kcidebug+x86-board on (i386):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-x86-kcidebug-6a06f8c00ed99f002e8c2f1e/.config
- dashboard: https://d.kernelci.org/build/maestro:6a06f8c00ed99f002e8c2f1e

## i386_defconfig on (i386):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-i386-6a06f8890ed99f002e8c2ef2/.config
- dashboard: https://d.kernelci.org/build/maestro:6a06f8890ed99f002e8c2ef2

## i386_defconfig+kselftest on (i386):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-i386-kselftest-6a06f9530ed99f002e8c2fab/.config
- dashboard: https://d.kernelci.org/build/maestro:6a06f9530ed99f002e8c2fab


#kernelci issue maestro:c55fed57497d1954be35cc17f34d231894d01bd8

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

