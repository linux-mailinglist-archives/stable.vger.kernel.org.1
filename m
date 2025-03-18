Return-Path: <stable+bounces-124848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4401A67B3D
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 18:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F82817D3E0
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 17:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8186A211A04;
	Tue, 18 Mar 2025 17:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="XnhPqaW+"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B17C211711
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 17:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742319871; cv=none; b=fLFXQKlyH4H9HCz2FUFRkxlnUNlAPD/0OXhFLbrqA0q1Oc0cDVf+M+mrjsNw8GiNEeP35CLimveaTN7d99Hl/VvR6aHdwEeLJGoTHfKxd0VscdGq/GGXguydRFQ72Hp+PqAlaDxWcU8nSfnxddl+9a+4vL4aKxTppSKmwbptmd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742319871; c=relaxed/simple;
	bh=cY8zJalzlYDRu4TCSrTTeFntZqu4qHy6eKeTT5/JURk=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=IWrj/XaVJrGIlxxkSLcp30Cs8MYJFnE7OV+UPWB3J3fqcnDvgpWFRzScd4r9uKcJk9lb3EdZNbjpL63Iq4EFNonyX2Ep9duGyj6f97KvTGcLeyx5KUFG+1fuF8FgIjibv1WSMjnS0AKIG/5rkopUy/dL5ZIbvm7VOfesPNCK5CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=XnhPqaW+; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e63c3a53a4cso4927704276.2
        for <stable@vger.kernel.org>; Tue, 18 Mar 2025 10:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1742319865; x=1742924665; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lr9VlUSuwj2cvREtuodkvAWZfzyLV8sJeXtl00sfed0=;
        b=XnhPqaW+Tqrni2ty1w1xxINfT5m3inp7V0fgGeobXDJSm8BQLnDQLrfJ5v6csxgyA0
         JIgoFuhKKr6f5JYlwz9XLM8OWf07LejGgojVZsamyAs2fWbXfbEnfuyz+fiqg/fIGY1A
         3R2Pkbl3vCiHFSgRhYvqzn6M1DZr3kiRdXa2fLGaiXJPla3mECQ/fOaT3pUwoeh2rcg4
         hjxvpMnX7RbB4+hB4v27B2EOdBfsa6rBEuSC2vDALYJ8/BJjLxxsQtIBzTwhYKGYxcxI
         FQdVIJ7IqzkcGVbLB91ZxdPiuiVY+3uT9/Dgwzely98n581sGsmnJ7Tb2hcpXUsk/gKa
         Q3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742319865; x=1742924665;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lr9VlUSuwj2cvREtuodkvAWZfzyLV8sJeXtl00sfed0=;
        b=hyknHyd8h6oQYCcUkJio1R54lknDLrAIzo0bL8w69db1HMBcq652DfGQdt3lGpY/Ni
         DWPqlCaHLtY6sKAFKKWqF5rOUJ3bEYrbAcsDeAc1iEb2JHksMyUTeY7UeyfuB9GMWRMs
         xtojhdCrZTXnq1FYDmg+1LG3gjuSVOG+03yS+LSRtrWMAJr1K8OLNZgnCJWUzgVwSRcx
         GfF5+ReUzV2DCDKr5jxsuusZxrTl89PyxmUJDzLBmZ9fPB3VjWHHcBdR7CUrFJbyXNVp
         qlkbtM3pxzN7JupquW1ijCTtK2FDBI3UjWANZ3W5YhBhZrgP6T4XBtxo9HlzXJZP14is
         fH5A==
X-Forwarded-Encrypted: i=1; AJvYcCUwcVwzqdrPnM74jVGeEqeSmaBXvJECX9KZutBIdfQglIUYDOiBmt5LOr7Xe64bJe9gcOA3Y7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZsdyY/9V+p9KtEmEfUv9yckJ66eoSJpKM4nY8flX5W13SuL6k
	46ucegCw3cwIHhInxehwOuldftTMAip8BAz3qYD+rgpPADn+FHEpQSri4SF6YZN4nxp1e13cjPm
	njBcLeOF20gnFxaMLDY7Ed6TT51XdWvi9Mu5NkA==
X-Gm-Gg: ASbGncsVjgJv0xiN7lDigZvviNTQWZ2CHpCfSOheZwgBnSdCm978batlbNiFQnTINIg
	UXU1BvYUq4ZHaPeEX0x1f/OcHD7rVCBy5NzsBT7lx/bwe4XFYCLrUtpXccGPcRAfuEUPhYps4L4
	74SgBzBpxOrWVPdI349dZx3iY6LSitBhT7n5sa+tnC7D5m/yHPVVPod9mKFKU=
X-Google-Smtp-Source: AGHT+IEvgI5q4mJDtc/eUPHSF7uMi6Um2uU5qC30DHPKPBgENDhBtttaRBhr8lqjUdzXm024vgrdk3ZRGqDbcpDKjRU=
X-Received: by 2002:a05:6902:1206:b0:e20:25bb:7893 with SMTP id
 3f1490d57ef6-e63f65c49f8mr19109809276.46.1742319865093; Tue, 18 Mar 2025
 10:44:25 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Mar 2025 10:44:23 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Mar 2025 10:44:23 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Tue, 18 Mar 2025 10:44:23 -0700
X-Gm-Features: AQ5f1Jq_T6E0h2DhxQD30UkNPY6X1zrKdSSyYP8k0La7cZ2x_xjfbGqQjio-q3E
Message-ID: <CACo-S-3rYspysz1TZOmPx0KSeObsJtnN-NU4nZJz_ttH8f1thQ@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-6.13.y: (build) format specifies type
 'unsigned long' but the argument has type 's...
To: kernelci-results@groups.io
Cc: tales.aparecida@redhat.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-6.13.y:

---
 format specifies type 'unsigned long' but the argument has type
'size_t' (aka 'unsigned int') [-Werror,-Wformat] in
drivers/gpu/drm/xe/xe_guc_ct.o (drivers/gpu/drm/xe/xe_guc_ct.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:654a7499ce48b09c6748b92c5ad90055057a67a1
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  c025445840beab62deab3af5afa8429f63e8f186


Log excerpt:
=====================================================
drivers/gpu/drm/xe/xe_guc_ct.c:1703:43: error: format specifies type
'unsigned long' but the argument has type 'size_t' (aka 'unsigned
int') [-Werror,-Wformat]
 1703 |                         drm_printf(p, "[CTB].length: 0x%lx\n",
snapshot->ctb_size);
      |                                                        ~~~
^~~~~~~~~~~~~~~~~~
      |                                                        %zx
1 error generated.

=====================================================


# Builds where the incident occurred:

## i386_defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (i386):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:67d98d1028b1441c081c5d19


#kernelci issue maestro:654a7499ce48b09c6748b92c5ad90055057a67a1

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

