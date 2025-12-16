Return-Path: <stable+bounces-201954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5A3CC2A14
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 174C23036D93
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E978347FFE;
	Tue, 16 Dec 2025 11:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="UI6YCzSx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C11348453
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 11:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765886347; cv=none; b=fg8zDS7NYioYeEIz7pjy7VwuWnii44qc43udKdp2yr7o7gQHVZa9X6uzcRHsGIclUGQe/2dY76EweKMj64lC32Cha4xr6HwvfzzIlt8isW8WwOgesEtOwBzDhiTZU5eBCWwlpDiTAfif7MnjdigUTSXgmjD2iARXUkSGKtirTkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765886347; c=relaxed/simple;
	bh=OmFsuG5EZc+WAiM5mlRENq3YM6IxL07TY1yyNrRoFQ4=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=LIFO4Q0xVUeaLjBhMkoThUwebyvwj5S5+SHXwZSiV6MAo/YvSdA8qX5OWdO2vjkw6yi/UFTLqVn7DzWcrHvbWqNr7+n/CcYeYpYuOPAVz0VqB710G7GiiywwkhJuStvhx+9LtN/TXXxCoeMNJoMVPdmT8zt+Y5cXJJXAaL7pyS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=UI6YCzSx; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34c213f7690so2987846a91.2
        for <stable@vger.kernel.org>; Tue, 16 Dec 2025 03:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1765886344; x=1766491144; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+AUxcYib27MVho2wRLJWDSDfTr+2uDYN4RJpdNJBF4=;
        b=UI6YCzSx3Qj54g67a32Lzcoe1jIh9+MSs2605KL5OTpd88ji8IF1Tr4K8R1xPPeTrE
         jpnbBD8lJOS3kRRj80QIsAaXUOabpnFWkuA3iu/9AFbRNu5w92ZYdZ/xff31iCiuMl4g
         wvL8Id45KUKs30A9Cr81NA9/RBVnRSLz/upP7+iuN/3cC/bkvV0GyjdSnKtfHb49X6N/
         9dzuqxuX5urDE/G0l25g0KvWj2EICsvaRWcyXroe3Y9D1Gsc8WADvtXlueSZv3I0qkbd
         gfdlvq89v+XrZaxivx+soCvOiG1t2mMA5G8PGZbN6/RzCHyxqC3GVvlYrsIQesPCGdNx
         16tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765886344; x=1766491144;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1+AUxcYib27MVho2wRLJWDSDfTr+2uDYN4RJpdNJBF4=;
        b=sKOCZeW1nwfgG5uk3LQvoYfoWQaOHDlpXgDH4x20gGt9E2BpkF7XnH3cFZe3NjoKIw
         Zzm6AR2LIkVNYY1dA9nbrCvbVlSgNAgKLvKlOK3Sji6F35yc29uD+xTNGcDxCdRDRiv4
         eODOw7qbh/XIRO/bGShuImR/g/qpkkNTydPumEps49/qbEANIV+/+Amzz+RHj1PtT/Py
         8FebUMJ7JhQ05gH6fOKsLuxOx9o55Rs3csycY1QlVz4KPAQAZfANO8MF6ra/XaalOabP
         bD/j9+j4YJ0xEhS8MIvztc6RQVIo9koCVeF9/WoL54V+30S4VnZ9grf2gWLJNQRPJ1mZ
         fz5g==
X-Forwarded-Encrypted: i=1; AJvYcCV799m/fF887lIy0WT+uGYgxLP59MxiBRUBIuE2d/i4mZ1uH8J/ezLWI64/Un8XBklej4hhQd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmWCXUcLDBf6ZOt112PNyGNW6y7rwTe8sL514WWWv2AJQSVJ7n
	Gc9pbzIB/EuR8lROiAntCqnWbOVWDe09zlGFZ2s4jJNNH9UyvErIBAA3+bYqtybwQyA=
X-Gm-Gg: AY/fxX5HfbTRw9puPTagr9g47DwXMqjVeu2XaCZoKrq+1foHDv6+xx36aC2jtA/nvzD
	Qz1p81QvNToS6COy3B08pTYBWO8DM3FcljYuSRDeazQL4PpZaHBznsrr/p32c3l41SlSAkg3k6q
	fBW62nzF26k1AbH7dgF1rTN5nO2uGUvjjQvGcMgrO9v7c6SsuvvWKANmZJhjPl344aELDu3u5sC
	MlW9/DooyP2JTA4NOirtpLQ77kUtKshz3t/rp3YIVchBAX6wpdsss4KL2lQOfCOvjKSXpagP3WJ
	7vVTywIscLQndyGrPCmKJ/F5IHERPgi98lsPdzCUp4OwL+IfJ+C1PMACh8d+GygEW6SGcgB/Cs0
	gRnh3ZRa9s82bcHUsEnVuiaVH6y1R08BdjinY8wn8IWSvtww4ZJaPq+hBeXQKp3STQO2OAQY0mb
	m0DKws0mR9RqF2LlQ=
X-Google-Smtp-Source: AGHT+IGyhC2eU7QAsHBvl5wqsFI8CVoUG+oKzhIBcxoERjrbOj9+KsbbmLi2QTEmCu+xYahOfvWSsg==
X-Received: by 2002:a05:701a:ca0d:b0:119:e55a:9bff with SMTP id a92af1059eb24-11f34c4ef22mr9297787c88.27.1765886344254;
        Tue, 16 Dec 2025 03:59:04 -0800 (PST)
Received: from 77bfb67944a2 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f461a0ad4sm12384127c88.14.2025.12.16.03.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 03:59:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.15.y: (build) variable 'i2cdev' is
 uninitialized when used here [-Werror,-Wunini...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 16 Dec 2025 11:59:03 -0000
Message-ID: <176588634296.2781.1556197207400738021@77bfb67944a2>





Hello,

New build issue found on stable-rc/linux-5.15.y:

---
 variable 'i2cdev' is uninitialized when used here [-Werror,-Wuninitialized] in drivers/i3c/master.o (drivers/i3c/master.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:ba3cb0af22421f02d74e182e1c04c219bca8a4a2
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  477ebb8a056314097ad9b5b4d340f980062d905e


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
drivers/i3c/master.c:2326:3: error: variable 'i2cdev' is uninitialized when used here [-Werror,-Wuninitialized]
 2326 |                 i2cdev->dev = i2c_new_client_device(adap, &i2cboardinfo->base);
      |                 ^~~~~~
drivers/i3c/master.c:2304:29: note: initialize the variable 'i2cdev' to silence this warning
 2304 |         struct i2c_dev_desc *i2cdev;
      |                                    ^
      |                                     = NULL
1 error generated.

=====================================================


# Builds where the incident occurred:

## i386_defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (i386):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-i386-allmodconfig-69413afacbfd84c3cdbb92dc/.config
- dashboard: https://d.kernelci.org/build/maestro:69413afacbfd84c3cdbb92dc


#kernelci issue maestro:ba3cb0af22421f02d74e182e1c04c219bca8a4a2

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

