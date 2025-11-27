Return-Path: <stable+bounces-197518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E126C8F924
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 17:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8B38434B56E
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 16:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C6D32C95B;
	Thu, 27 Nov 2025 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="NoF+Jnij"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AC0333728
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764262747; cv=none; b=Y0303rojiT1TZlNRpaDbSFxrHmPKB3nZiNOENZCPQE+/2sduPS4VMbZPw+qzsN5NT+M4ZlZmYLZoqD2yiw5c47uo/5N5h/Jycz3PliQwLktd3o8s3BsdycxA6+psXhkT6KMb8H5wzaH4GX6u6SqfXWTHwNhSxvJmJzJAVFdMq80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764262747; c=relaxed/simple;
	bh=7x0rCE6CsbSUnZK4IGsEDtoIMiShzXvPLHdzcNAwlug=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=emsMJ3HlJhZBkQEVpblyLI8dtCcZBy5st4keTNgqUfCezUIX/rtrjbb8q27Wb4tEfCqDlVExyLchYCt05VMsp+GsWpubLQMbZoMvuQcn/vFrLZ2JOSJEzBaWm0MBTGYuglWUcWdxFIrM5aN5JrRxrwP+6rt5gi+Qn5l0cLi2RAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=NoF+Jnij; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso1180522b3a.2
        for <stable@vger.kernel.org>; Thu, 27 Nov 2025 08:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1764262745; x=1764867545; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbGfxDWtk0iySg7hh72Near9J0I2j+7sduoVCsI4HyY=;
        b=NoF+Jniju+RnfOlzbg6yaR7fqCrkU+2yy4cBwl9unhm/6VaaFDyvBXa/NlHH1hgWA9
         7xKVxt/Q8lNiQjJUHrFJmbMrlTRIK4N2dd0NBqzk0Mf6TPYuS1uodOMAkE85io0r7um4
         2OmHy43z7UNlJgaC845Fz4ojLePr8m3nqM7GqLP1/QbsxtG1kOiU6z8p1EFTI6dBel14
         426fKlgFHAZbEAWOqTbv5NcYgdSAnCNIZe1ElJvHK7dOIFUdNl8E+2nLHrTmk8CtVqna
         GumN7JxtW4zmQOFVmw2rPbU/nRjdLc7JOzBfPqnsrxRPJMAeMWYBJpTgmLc1AhSTefh0
         Mz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764262745; x=1764867545;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IbGfxDWtk0iySg7hh72Near9J0I2j+7sduoVCsI4HyY=;
        b=L6eOaWjWsFYL32qRR/kmb9UbAwQWi0pp6CLoejuxXd7Rpd5GDgjDVgUV4Cd+8ds+rW
         1gC6FGbk8BuK1EBIZRGs0x21Shr8YaMm+62/Hg4W3oUV3yFyJV8WRjiyG9RWkrk7N7Fd
         ZbrnoK1AA+hfyy5l+EFsxdGYtvBq1LDL1LGV8u0R4KJtoUC66sPkTg+ducKUHWL6reeL
         Sv+cjLtt1fY4g1B52FqYsN3mrmRSBb7leuhBKp9Lj8n0eVonZ1oXGG3iVBSUC5mp4oYv
         +bGq907L0M58UDozC9vqmEDn4Ys8wf/vkktM3N5Cnj8TsXPutAfsH15XxkcM5KAb+tzR
         2wUg==
X-Forwarded-Encrypted: i=1; AJvYcCUZM+tp8n2mlvlDZhAMZqK0Pp2XTzqTkyBorssSFkhi8AHgCCW/va0V8uOrZYSXan9vflfiaJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypby4Xx7eWN8PwsB/Cul1oFYnJAi9NRihIrB9EjcQbbfViIh2o
	Po5ledp5HTMq7P5MIn5Aim6gi02mE3MEKHtuxtyNHM6vh4vSwm7p8sMUIFimE7askriESil/egR
	RWFRY
X-Gm-Gg: ASbGnctT6TdHnWVi7AQQEmzni53QnGcRRf6Ecue0hsEFd4jWo/w0poGhgiXxQ49VHHs
	+8qNmbIiwm9cbMQPE49jx9jFJEVmjz8ssmnyXSX5K7xo+GfhPWa73MPJsIYoaCEOxonXOLApcVF
	1fI0sBbhgaouxgX732DIsJoD3zQ2+Xb6LMgVeDdhrQHnQk3j5FfEHN7TjQb2RAMolJVq1cg2wbN
	bWKIBuG5DkZpplwT9DroS61LWIxFfAlzdWOoaRY8qyZrUnqlevrAlqER8R2+Kx9RhuRH9vkTLEa
	rWbYUDgrixiuyT2r2fLfojyTUxeUBWifWyK3dfdq3C7aWnw6a7rirsQlo7JrVBhuEuYXQcm5kvT
	0a5Xh/1OC2I8WT/frD17nDwu1Y5aW/kVIGEZCd0H3tgu6lkn9eMGECdRX1dUfJegRVICWwEcQps
	F71fCq
X-Google-Smtp-Source: AGHT+IFk4ztgZ9xKwyiTFHbRqtp3HQ52As7T03asLITGnHZJrx2lirS6ueQ+gdvQe7pOk74gGi9f/g==
X-Received: by 2002:a05:7022:ebc2:b0:11a:f5e0:dc8 with SMTP id a92af1059eb24-11c9d850570mr14366161c88.28.1764262744650;
        Thu, 27 Nov 2025 08:59:04 -0800 (PST)
Received: from 1ece3ece63ba ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a965b1ceeesm7471698eec.5.2025.11.27.08.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 08:59:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.1.y: (build) variable 'clidr' is
 uninitialized
 when passed as a const pointer a...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 27 Nov 2025 16:59:03 -0000
Message-ID: <176426274343.952.4208720244700812680@1ece3ece63ba>





Hello,

New build issue found on stable-rc/linux-6.1.y:

---
 variable 'clidr' is uninitialized when passed as a const pointer argument here [-Werror,-Wuninitialized-const-pointer] in arch/arm64/kvm/sys_regs.o (arch/arm64/kvm/sys_regs.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:20aa3d9f2fb39bcb7ec7ca6a54be07b6b2668acb
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  87757e18cdafe3f3dd4fc9b9e920e6416e6d00eb


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
arch/arm64/kvm/sys_regs.c:3002:23: error: variable 'clidr' is uninitialized when passed as a const pointer argument here [-Werror,-Wuninitialized-const-pointer]
 3002 |         get_clidr_el1(NULL, &clidr); /* Ugly... */
      |                              ^~~~~
  CC      block/partitions/aix.o
1 error generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig on (arm64):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-arm64-allmodconfig-69286db7f5b8743b1f65f467/.config
- dashboard: https://d.kernelci.org/build/maestro:69286db7f5b8743b1f65f467


#kernelci issue maestro:20aa3d9f2fb39bcb7ec7ca6a54be07b6b2668acb

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

