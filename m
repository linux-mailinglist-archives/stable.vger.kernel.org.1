Return-Path: <stable+bounces-121708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BA8A594F9
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 13:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE4023AF9CC
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 12:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D376722A7E5;
	Mon, 10 Mar 2025 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="BShcHsEC"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141E0227EB2
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 12:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741610553; cv=none; b=sHVW6W4RKabxhBSmc4AdqPz1jMA0VzyQei3IlmV6fcPJkR9ikBp5EmjtvCRdgBrgxjCmNg0ormEZ0Aty7z2b6Rt8dhGwYWd1W5Mc1c58UYwYKf3vb3mQLR+ACF828VG/ePmneUaF8/D5OUKTomEbzC8szoenhpaMBikCULSOKaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741610553; c=relaxed/simple;
	bh=F5Y3TJCFvogHFL1RdUDCuxulwadqr9cQodbJimssnwE=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=rJgECVmJOAwYUYfkw48rowF++9EpuMjSlbIepXnOGl2Gi8ApsiI/7A9sZZUxXTSI7+IxT2Qfi0uy1kY0ZOYQMRRQCT0AOr1i0o0BFqbhcP0z+2w2WAD/8WwopEMuAV7RCxVJLdG/zLaCZ1AgVwpV8LW8cHAXbB86Z8WzFx2hP7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=BShcHsEC; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6fef1d35589so8111567b3.0
        for <stable@vger.kernel.org>; Mon, 10 Mar 2025 05:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1741610551; x=1742215351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gx4K9UhLW08N8dVLenqqjH2AIylMl5Barvs/GXMgyeM=;
        b=BShcHsECdI/HRzkvXx8FM8P+eaGbtvwncHHLXHHK1rtjqcWm1lV6LgyBxeSBZI8B8L
         +mVNrfTBjjzRS8W49Q/eUZd3pYGdspb114WbcV5m3E810+PQlcNtx4V0vGoCEE7tzhQb
         sC05SabbcdO4I3FqshcRv9e7c6DayC8cFVRJYzlozcr6yPcsIkLceyHQOHH1eT127K0e
         uPY4vFQVeti0rPYSDz1soJ06wv4kowguCuF0S8HJYJqsAm3Ham6FUSS5ZjQNDBj1Ckgu
         rUDbS+d9NrGnuEmjzvKDZ8rlO4pcTK8OuolqsHCf5PpQBuwVv06NB6Nkf1JsynWgFRUU
         q+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741610551; x=1742215351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gx4K9UhLW08N8dVLenqqjH2AIylMl5Barvs/GXMgyeM=;
        b=mNJKbx+Daw/HdMJ2Vuq/ohrkqrVs/DwbYUyzOPzu+fgWCqxgWbSpC0L8SvQ/L9N/jH
         WYS2RhNRi17MhoaBOKLWbYADe3DTnGS4A4pRMYUXVCiZBybs9f90YhbSv0LZYyDk58wR
         bHpKPJ7f4z6y8TqiZbjOSkPRdEHiMgGevsfAiZmcM88IpuPsvqapnqRLpkK0bjkilBlc
         kyT+JX+JiEo5kHDA8yYe26EB9u7Xwg6QxGUN2BQxLcrLIeGaAx3FO45wqkX9Wlt0ZBME
         hW7YPaggSyglgeUJ5/PJ8jQxwFF47zAqulSJGuwHEhlHBIfjnTe5KRITtR328mPVCUb4
         rw+A==
X-Forwarded-Encrypted: i=1; AJvYcCV5CAxBpf9lnZt9LvUE9+KEBLd33P0gT1zaDP3Zu3EYYl+5VPhrGf4u4H9BlDCqb9kyoWgz4zE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXbP5sQCi4ohb8jrFnh50TLXj6PNK4U3S4Zq4MZ6nE1ft4ue6I
	oQo5NQUHNTNaik3C5ZjRTVQxhjaam9V5VTfg8r+wA1GvRhQy5l1KT9klEyV6O3ROt50jadDRWOd
	2bi1AzVUWKXpxy1A4IWqR5ClaVj3JW39Beg/8WBVf0YG0YKNxHS8=
X-Gm-Gg: ASbGncu514TBnZJRovzitTUrmK7iiIOPrB1a7UgBcHunHfrPK/xX7aw0qflYfE8s2v0
	g0X8gGvxD84tjTua/odxp8aVoB0RJxX5E6LWheWvGK6o7ThRDoXDagdp3LMnvy9ZNI2UMo7LEcO
	1stf4d/YXnQYAWuW4YJs1BkpKtkeHkSOOA1xgAH83MZQyp3xc+gXryZcYpfl+U5XmAoRzRQg==
X-Google-Smtp-Source: AGHT+IF1H9a9c324h623BbWX4MkV2NfLC83ES+TWwy8/pN2MAzIqGnjD4dRkAFI5kIiREYGXJXtHLNrDzGnkffL+MVw=
X-Received: by 2002:a05:690c:3802:b0:6ef:9e74:c0b8 with SMTP id
 00721157ae682-6febf2fc7b9mr191831467b3.17.1741610550918; Mon, 10 Mar 2025
 05:42:30 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Mar 2025 05:42:29 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Mar 2025 05:42:29 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Mon, 10 Mar 2025 05:42:29 -0700
X-Gm-Features: AQ5f1Jq84g0r_2i6GmLe0CpOufWeD2Rh2unkM2GCf66wSfUIWs8KVAnOk0Wwpmk
Message-ID: <CACo-S-2HY43+WQPb6PjO76oktpdN_ODtjKypF-GOwPqZJO7nZQ@mail.gmail.com>
Subject: =?UTF-8?B?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC01LjE1Lnk6IChidWlsZCkgaW1wbGljaQ==?=
	=?UTF-8?B?dCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhhY3BpX2dldF9jYWNoZV9pbmZv4oCZOyBkaWQgeW91?=
	=?UTF-8?B?IG1lLi4u?=
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

New build issue found on stable-rc/linux-5.15.y:

---
 implicit declaration of function =E2=80=98acpi_get_cache_info=E2=80=99; di=
d you mean
=E2=80=98acpi_get_system_info=E2=80=99? [-Werror=3Dimplicit-function-declar=
ation] in
arch/riscv/kernel/cacheinfo.o (arch/riscv/kernel/cacheinfo.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/issue/maestro:c4d70565f303a7d7450fbf5ad=
d7ca4cc80a96112
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
- commit HEAD:  2ae395ef666caf57984ff9d2ad7bca6be851f719


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
arch/riscv/kernel/cacheinfo.c:127:23: error: implicit declaration of
function =E2=80=98acpi_get_cache_info=E2=80=99; did you mean =E2=80=98acpi_=
get_system_info=E2=80=99?
[-Werror=3Dimplicit-function-declaration]
  127 |                 ret =3D acpi_get_cache_info(cpu, &fw_levels,
&split_levels);
      |                       ^~~~~~~~~~~~~~~~~~~
      |                       acpi_get_system_info
cc1: some warnings being treated as errors
  CC      arch/riscv/kernel/patch.o
  CC      fs/proc/generic.o

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## defconfig on (riscv):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:67ced73618018371957dfa8e

## nommu_k210_defconfig on (riscv):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:67ced73a18018371957dfa91


#kernelci issue maestro:c4d70565f303a7d7450fbf5add7ca4cc80a96112

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

