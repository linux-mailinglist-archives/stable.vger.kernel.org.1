Return-Path: <stable+bounces-121707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DDBA594F2
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 13:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D8C188E809
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 12:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712ED22A4D1;
	Mon, 10 Mar 2025 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="xN/JXz6L"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8719022A7E5
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 12:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741610546; cv=none; b=AvJscYLOnQrbau+ZkaLQaBLq43dMJ9yR1oqDvg2bnIxmwCCfbZv/bhDsd9hZAg+Z4QUg62Cv1K41GDZB9/X95Eq5UbhMWvBng/np7EqKtH+MCQQiX6w55N9ew6QF2iyci2DqgrtdMDvCtXpWsOcBMNPmn1+lTPVF8vKD/9a5VEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741610546; c=relaxed/simple;
	bh=pct82yTIUBt9ZAWhbJCDpX472+r/jZ79B/zoTHEsiWc=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=AG9P+Tly/GSgCPAeDa5x8ToWJDqIIgrtxkdk9N6Wjw2VoTS3wxW9dZX+INza1LmhD67slDlOfGrpbVlLPF7gZh/Mkni0/E5ezOiO6M6RxZLV7i4h2l9ahJ2gtOhX3PS+fppB7HUNnI5WgSExQil4xQCzmx5MBMOskk8ApSva74k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=xN/JXz6L; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6fead317874so35800267b3.0
        for <stable@vger.kernel.org>; Mon, 10 Mar 2025 05:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1741610543; x=1742215343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fjb1kXBVf/mo5U2F6tst5/27OJxtb+K+B6ynokPxn/o=;
        b=xN/JXz6LW2tSxradtcZajXkx2Fhpz4XS7FCN45/ArHbacsQnPC0f4IallrXCn0/0xM
         2OYCOuH9iPcxswXqfoAfdR+XO1CbeDJERWCh46qd8xstJsf0g85/0eCWufl3tyPClwhd
         Z8vXChe9JzlVnoqogN8Z3ZGsHhEFawz1du/RXnamHIeeMFXQIGMxjbVgIsLQyNt2fcVP
         YZJcGFKqonyhmE+3XOd/1kMzqa23itl9Tm7z4VMhogSBAL3ga0nGNGxERGxi7K3KKvkF
         ju6GbayUyZ8azPMYjkbi1R1FQ+p8Mj9+9hOg3ZuQ990S8zC8E1rjboOM2PQcESVJh76e
         iuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741610543; x=1742215343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjb1kXBVf/mo5U2F6tst5/27OJxtb+K+B6ynokPxn/o=;
        b=Epvj5CVVhuVQxc85xzz8emuBYjN7QWhh/i3C982jQ64KVP5zI8abRtH6K9TfLgYuKJ
         1fNyiMvHyBDU7yOWeihz9uV+fpcezTzJZyC267Zf5i+tZbeEGvdUZN7rQbXkkuGs2oQe
         UxnTRCUq618yXZ6gfXSCibrb8ylWg4zMRwmRBRj+hMmi8TmeyH5JIrPgORoXQsJ9FVOx
         oqZMy2aMWkf08hIQdf/AsBGHog7FqWIY3Hwwkqz49ciDUGCnaTFrDLrEq3VvJlT1oLkZ
         EoEN0d4KUFjRw0bCswCy9DQ/AwIkcgQr6TW2LBumfTInYWoqrxPJg5EnyNpga53xiRAI
         vOXw==
X-Forwarded-Encrypted: i=1; AJvYcCVADWu7QUD22BnbrOFYH/fIg6/PdQ/Y6M2R63YXOOKki7VrfdaCzzrEDa176kiivKU9YnokmHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoG0hR3eE6A1b2LiayrNvL/SUK8MnLsNbumjlAwfL0f5PXkYq5
	X/+Cg+pvJniFLhE7MF2mUnpVChBRVZPBiGuzKNe7/LMUI6esa6lVz/YpZeZBmmk8Jhny2a9BK3l
	HUYEqslqRIZ6XrJlQJ5Q1CeIE6H8VxSMDgOtoBryxX5VIvqQeqwc=
X-Gm-Gg: ASbGnct5tLnZtw58FvPRl+wi9N+Ln3o6f/IBOgWCZWjzbI7pu3+h0tQX28sfjkxfeOx
	MeKq9bqb1oSnLFTpI+xSAcvkskoSEMYVjwuftaaSbQVK4gSQzMm9kIOoJHST1TJdXzzPat/wxRs
	QRhgS3LRBZWXwh7wZYxU9Wmxnd1jbHEwuGGyra2s7cbXtBmQRD+poynGlbFgw=
X-Google-Smtp-Source: AGHT+IGMKaq/bb8TxdrCDQtUi4OSqlTbgpXlG9LbNBJ1veeFBd/l/Ib8VO07aqCZkcMt8EDc2oKNLu+PBHrgR8RwKaE=
X-Received: by 2002:a05:690c:998e:b0:6f9:ac35:4483 with SMTP id
 00721157ae682-6febf3a9308mr174583677b3.25.1741610543363; Mon, 10 Mar 2025
 05:42:23 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Mar 2025 08:42:22 -0400
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Mar 2025 08:42:22 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Mon, 10 Mar 2025 08:42:22 -0400
X-Gm-Features: AQ5f1JoiD6KfudvIwSHFur9MzVRgzIPcdPk6urgC9-tF9kPDg4MIIeedgTl0bQo
Message-ID: <CACo-S-2VYwvZt1-CmDN4HmdD1rS0QQQm7MGFUR10gqp39pcy1w@mail.gmail.com>
Subject: =?UTF-8?B?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC01LjQueTogKGJ1aWxkKSBpbXBsaWNpdA==?=
	=?UTF-8?B?IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmGFjcGlfZ2V0X2NhY2hlX2luZm/igJk7IGRpZCB5b3Ug?=
	=?UTF-8?B?bWUuLi4=?=
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

New build issue found on stable-rc/linux-5.4.y:

---
 implicit declaration of function =E2=80=98acpi_get_cache_info=E2=80=99; di=
d you mean
=E2=80=98acpi_get_system_info=E2=80=99? [-Werror=3Dimplicit-function-declar=
ation] in
arch/riscv/kernel/cacheinfo.o (arch/riscv/kernel/cacheinfo.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/issue/maestro:0f2670909ac3275cc312c3c60=
4f3ed03443feecc
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
- commit HEAD:  2f9225fb6ea4ba2ad94f50f0e24bad9c353b8649


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
arch/riscv/kernel/cacheinfo.c:118:23: error: implicit declaration of
function =E2=80=98acpi_get_cache_info=E2=80=99; did you mean =E2=80=98acpi_=
get_system_info=E2=80=99?
[-Werror=3Dimplicit-function-declaration]
  118 |                 ret =3D acpi_get_cache_info(cpu, &fw_levels,
&split_levels);
      |                       ^~~~~~~~~~~~~~~~~~~
      |                       acpi_get_system_info
arch/riscv/kernel/cacheinfo.c:140:13: error: implicit declaration of
function =E2=80=98of_property_present=E2=80=99; did you mean
=E2=80=98fwnode_property_present=E2=80=99? [-Werror=3Dimplicit-function-dec=
laration]
  140 |         if (of_property_present(np, "cache-size"))
      |             ^~~~~~~~~~~~~~~~~~~
      |             fwnode_property_present
  CC      arch/riscv/kernel/module-sections.o
  CC      arch/riscv/kernel/perf_regs.o
cc1: some warnings being treated as errors

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## defconfig on (riscv):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:67ced63718018371957df9ae


#kernelci issue maestro:0f2670909ac3275cc312c3c604f3ed03443feecc

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

