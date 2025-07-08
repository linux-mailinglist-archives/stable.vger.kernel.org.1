Return-Path: <stable+bounces-161326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD39AAFD5D2
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 19:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6FF43ABEE4
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 17:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754EA2E6D12;
	Tue,  8 Jul 2025 17:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="lb5QfnoH"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745611E521B
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751997548; cv=none; b=FdYgYreuGL0M8l17ae9dad3isFvFjYZ7IBOF1n7Ycmp9CdNJRD34qfK8KTyCII0X81hxdDWg3c4svEttQ8lqrOXPqW2MfKr7bhpcvaNW41B5u6MDsomyW+6kGz3577tFwte5/ub3y6jtp63rF4SspODe+1CwxfyLUoKHsconTLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751997548; c=relaxed/simple;
	bh=SXZxooNUCDQs4FzDevDq0C3weWWJVmFZQT0Bt1G5BxY=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=eeYlwqbBmQ83TdguF48dQWv1lCkjrKwWPOUp6W/YSpMwd6JsZjeYjim6PRN66++XukNWbYpcrC5zOjVrteRzbWNsUeWeK8eE+Smfz/5O63hGzRVMMHbhkJg4SsONC0y7LOEjbRR9U9STxr3r/SmF5Ik9Sn4un3jOus+EYJ/pPsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=lb5QfnoH; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-710fe491842so33134727b3.0
        for <stable@vger.kernel.org>; Tue, 08 Jul 2025 10:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1751997545; x=1752602345; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hd1+YZJ7eJJti9M+yYOHMR5doM2nXPGPtUQcdOTpHbw=;
        b=lb5QfnoHYFtXv+eri16pivv7xWfQ20m/ZgOFLfO5oa4bVgAnL0eqTNlWjXyuBEBxBK
         VnRxVTqIsdMCoEXBtWn1ZDjedUNyshkrzHtyKUGYyAwe+mWfCQq8TpEKgylEcTqEhun1
         i5fI69aW+2QC+PvB200QA0U2McoLSrYW4yPYIQOe6l9uDtaamoJX2j4eahUGITQyGHT4
         DGkslXE9exBfX9XCUKLDMW4tGZTsEOG7uO65VFgtxPoeAM7Ky2nKcClK0PupaTwZBjrw
         +/Sn5bspc8dN65KU04vgqyUBcbqUe4CNdwGsdU2pYtVdJIm387e/Njbb7148D8ncz9lE
         2qUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751997545; x=1752602345;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hd1+YZJ7eJJti9M+yYOHMR5doM2nXPGPtUQcdOTpHbw=;
        b=CF5beLi7FW7QB07PoD9GOURqDNkejHeN6p0++tBF78UzvIRdIeGzOGWVZBUrmT6nAz
         nHvHnihfouOB5eC0oAKxPYnGL4DJDkAVwDz+Pqgkp33hyrRTdNreAdO5jP+hThkpyGtn
         WeGn/F6jDCkOxIru6v/1wvdUwxD0JmHkS6/glTt8OGzJUszN0gM9wQKvinsLi/gOKlPm
         NEMwaV1TQJcodux94LLIaDgZXAM6vPl+nxUEZoMwOrazWE/Fk+8y6PjGykaKSjfsM046
         Duhu0c63te7ViRn3Sxowr0PN/p5aeflkdC1IPyB0wQ/mZrc1ZrHbTowgiUNdKyjRle6M
         6l4w==
X-Forwarded-Encrypted: i=1; AJvYcCUo/ANtmvjD0uaUaAAuLdikKB5DS/AqddjPX6H3YNkMaibhS6TuzcNJSHmVaWdJ9mt4ICZF0MM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2sSuXOxkcENY6e5CoPRhs1XoMGRW1mlTB2O+1qP+I8aGrir0D
	D244+NbubZGPBT+rFwC5xpivSa5KXfACXXLZkCk2wcDaYmsrnfrsPOJwxsjqvSxO8Ge69C1yJnH
	mrfYYqbtRfHL+6960iK0TsJxzyi169qpa1xkIm+d+0w==
X-Gm-Gg: ASbGncvMSi1l0h7R/m3q57AsSLe99ojZYw0zEcf2+gT1XXlOtue773T7vcfbxQQId83
	DmY0nMuRRyLEYAiaDLFkTZHTfARaSbpD1vzniYxuxwD0fMt+y4TYGnP+a0qvKqvk4hjZpBSZJcn
	7qP32aYmF6wQe45iljl8fyr9mMZzrKmcYwELn29lN2jQf0LKYrgBOf
X-Google-Smtp-Source: AGHT+IFSj0qrLXr0paXu0ZzKf0iRyfz1pzic8hSJjMwvnIIe4v6h6bxDzFI8QY9jZ9Sq5o+1VXH3I/k08SXrNXWGuCs=
X-Received: by 2002:a05:690c:45c9:b0:708:16b0:59c3 with SMTP id
 00721157ae682-717a046193fmr52091627b3.33.1751997545038; Tue, 08 Jul 2025
 10:59:05 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Jul 2025 10:59:03 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Jul 2025 10:59:03 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Tue, 8 Jul 2025 10:59:03 -0700
X-Gm-Features: Ac12FXwc9q_Zr-IETquAdTILKS4OO5_flvzZ7_-dveL__hYQwvtzqHUpkmlx37g
Message-ID: <CACo-S-0-BZubrVmsAHsxBD2ytsc+UhfCs44bhR5T37DeDGj56w@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-5.15.y: (build) ld.lld: error: undefined
 symbol: cpu_show_tsa in vmlinux (Makefile...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-5.15.y:

---
 ld.lld: error: undefined symbol: cpu_show_tsa in vmlinux
(Makefile:1246) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:37759c63a97e01566b3769ef90482ca5ec2daa9f
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  57a10c76a9922f216165558513b1e0f5a2eae559



Log excerpt:
=====================================================
.lds
ld.lld: error: undefined symbol: cpu_show_tsa
>>> referenced by cpu.c
>>>               base/cpu.o:(dev_attr_tsa) in archive drivers/built-in.a

=====================================================


# Builds where the incident occurred:

## defconfig+arm64-chromebook+kselftest on (arm64):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:686d490a34612746bbb51e76


#kernelci issue maestro:37759c63a97e01566b3769ef90482ca5ec2daa9f

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

