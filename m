Return-Path: <stable+bounces-207854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EC780D0A1B0
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 13:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4CB91302951C
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 12:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0AA35B14E;
	Fri,  9 Jan 2026 12:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="I3mjoDDT"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F4435B12B
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767963549; cv=none; b=N1eeAOuKd1vi8uYZVDyxVjfrIefGWFQoztlvJwvaSCAVM/nR4htEubmVSvJ3uDUfgTyk+VqeqORoJIgC+197T0CivverWvDCIVK6er0kDCE5hjJDckdANijJiDMbEcU1KnCn5DpMUE/PGd2VepApgXyy8q+NSI5A0kCKL00rb20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767963549; c=relaxed/simple;
	bh=CHm0TspS7vT2csC3+LY77lroXDQwzl4TCYOYo/JP5lM=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=dUNMEMpd8TUzUD58MlW/LGLM1/oNeqrR/zqeIgeh5tD2bcJCXZ5CC7gOXkbEjMiBCmxnO/RN5UYqaty9WJeh2IT+POMKYh+1kRuJk6NmLjOms1ZftHS6GQDkrN3RBUPlKiYaGAmm18G23mHErtbXwA1Dgg+lYWRORsRGBMqCggw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=I3mjoDDT; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-11f36012fb2so5248446c88.1
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 04:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1767963547; x=1768568347; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3tB//z5OTYgzFfI8JIq4G8PuLc/mV/hvIVq5dak6FM=;
        b=I3mjoDDTn8SM1Ce+eb2uJlohYxu7hTHzapYGP8maA1GR9l+JXTyouo5yDhK9P575qG
         +9Jgba1sotSSsauleQx61uP3KxpVwqUelxc+SxtErCDZZUIchu0dGjmdBh6lbDNAMNsQ
         sf8zX6HYwEypWAPuYT08HHkS4NcSNMNUXGDt9MLGU5ZdYWpvtlEQTnRgjLIf8OKS1/f2
         kSVFSusmpYUEBV0/8dpV5l1X5r3yqTPdUgMp+pT5/rKG6KSoHccBl29fkTBGHUA8SMAW
         hk3ZZn8sJm8utpK5LskWLX8dUROniR3sn6XMUIsreIjDLBeoJvnNPH8dlA7JN+HpnNap
         vzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767963547; x=1768568347;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q3tB//z5OTYgzFfI8JIq4G8PuLc/mV/hvIVq5dak6FM=;
        b=SYviGQ4CpNC7gp8qX5XSyPdLc+Cjixkx0yGBuA6JvnoU3+aU3ynyQjdQE5Tmd9RfnA
         Q9OIkChfjXLqB+pnaeDBLbHiKqurecAX/xxbGsXeR72OFCeDYNRv4qofmHXfv5svtHNk
         LumT4Ux3uO+wqRvXBEIjV1xNdxTMpFjtGT+uNITVTrot4wO+llsj/l566w7hOod8bUi1
         bjjV/NuGDVCWNnYfdiF+P0LRPt/fZeRfnsu+M+bFeeOVwDG7S3GegKyyuU+38Y//6cFK
         SLXVuW71rbKEUxgakIVx0seEtrrDgr49J6r1HZNGh3Ima69UsWZCdNG5Jap1ta17yoQn
         x7UA==
X-Forwarded-Encrypted: i=1; AJvYcCVrCuK4B/TQ2RXvNy4OtlZ/OqWmc2aR9iCXBMGrWUFM9J200eObqV6udcwgU/efNXkgrl2PFLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2g9npbLTL2n17iH+ypRVJfVdRO6z/KjV9PHFw/dT+lQKwMRwO
	JUhpvSm8mDvkoPYBgAdfV6mzyE4K57ZRVR27YVxWZOFrp2XEN62ABe20f32tpqwkMavk0cbopxp
	Fa9ega4Q=
X-Gm-Gg: AY/fxX6iCOCN6BIm17LyHeHDK39ERlXILSoQytbDsU+mNlG6eE3dYNyCX1hrdtNX7WG
	4tiVFUciVQo8EWP02C8QfZd/linXFGv35p/Av6TfL0qfsmAgcBotm31zu68MMsQVNTbaX+WLSh9
	NPhn91sMZMJtPeggrEIhVyR7nZKgOHvdMLyt9hKccgJ35hFfj7iQahJxeAzG46SZfQCqa6RbRWh
	VCYsIxXv6YJpLXff5u2fHCZ6e9+WNoqG9JrRov7Hruza9LMPwKUNI1hLpdRrjmmYC5rIz6ubvD/
	UR+zvLoUabK079EVAullnx7Fbb81d53xesNkpyT2zTsGH6Fie9uFiAJRbLrKrBEHeIThdtLdngk
	H8yIfwir3CWjU/c9dHxKKAxACTnhU+JXX1c/Cbii2GKCb58TFrYHPSWWmtsPRd2AW3YmZL411qJ
	i121gk
X-Google-Smtp-Source: AGHT+IHvjF6joylTacAbmq/e2+d+9mDs2swlma5Pqg01Bcgxl6zS6g0LqwI+jEMqMFKemyqBUV3+Tw==
X-Received: by 2002:a05:7022:248f:b0:11b:a514:b63e with SMTP id a92af1059eb24-121f8adce39mr8418634c88.14.1767963546915;
        Fri, 09 Jan 2026 04:59:06 -0800 (PST)
Received: from 1c5061884604 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f243f743sm13563379c88.8.2026.01.09.04.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 04:59:06 -0800 (PST)
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
 '__free_device_node'; did you mean '_...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 09 Jan 2026 12:59:06 -0000
Message-ID: <176796354572.952.11109816492206296711@1c5061884604>





Hello,

New build issue found on stable-rc/linux-5.10.y:

---
 use of undeclared identifier '__free_device_node'; did you mean '__free_device_del'? in drivers/soc/imx/gpc.o (drivers/soc/imx/gpc.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:998dfbb422b4d80c9d4f6176e9c36655d3481e74
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  c4fc4bf97778e67ad01a3ca95dd8fbb05f226590


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
drivers/soc/imx/gpc.c:408:31: error: use of undeclared identifier '__free_device_node'; did you mean '__free_device_del'?
  408 |         struct device_node *pgc_node __free(device_node)
      |                                      ^~~~~~~~~~~~~~~~~~~
./include/linux/cleanup.h:40:33: note: expanded from macro '__free'
   40 | #define __free(_name)   __cleanup(__free_##_name)
      |                                   ^~~~~~~~~~~~~~
<scratch space>:216:1: note: expanded from here
  216 | __free_device_node
      | ^~~~~~~~~~~~~~~~~~
./include/linux/device.h:834:1: note: '__free_device_del' declared here
  834 | DEFINE_FREE(device_del, struct device *, if (_T) device_del(_T))
      | ^
./include/linux/cleanup.h:38:21: note: expanded from macro 'DEFINE_FREE'
   38 |         static inline void __free_##_name(void *p) { _type _T = *(_type *)p; _free; }
      |                            ^
<scratch space>:165:1: note: expanded from here
  165 | __free_device_del
      | ^
1 error generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-arm-allmodconfig-6960eee4cbfd84c3cde53db8/.config
- dashboard: https://d.kernelci.org/build/maestro:6960eee4cbfd84c3cde53db8

## multi_v7_defconfig on (arm):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-arm-6960eee4cbfd84c3cde53db5/.config
- dashboard: https://d.kernelci.org/build/maestro:6960eee4cbfd84c3cde53db5


#kernelci issue maestro:998dfbb422b4d80c9d4f6176e9c36655d3481e74

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

