Return-Path: <stable+bounces-123215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B850CA5C2F8
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 14:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D3C3AB7B7
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 13:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF461A841F;
	Tue, 11 Mar 2025 13:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="2Q6n5T3o"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FECE1C695
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 13:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741700832; cv=none; b=rftoEhIAt5zcgG+BN9pgjF5LCSNDimVkwpBdB/5EU+tpk/bIV6VYrikUhZYQ4TEcMlTbd+8v4zRjdsH4GZdgNwa0l87J0l9S7yWUqohbNfonLw2rdrojTY21oNPLQsb0AM7S1wUSRGLptliXCv52eE4X+LiA0gf+jt1+T6QQsVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741700832; c=relaxed/simple;
	bh=/uudrGWGaPN/n2xs6Miptt0zc6rATz/KcV0WnDpVrX0=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=Z/Zy1wXp9O7gwzOneDCfSgr3nAQ8enQedbi06rsZcLQ8sOwWxtvqT9t6DemwolTPI98FNopcvFRWs7N/tXqZbUPvMZ/rQy7EFjjl9xOpRKMctZfr8Lzdm3EPfcD07oH6A2tZdJrLnDFNP8nPNQiYV1k6ChVCIOWiiep0scsK2ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=2Q6n5T3o; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6fee50bfea5so22497697b3.1
        for <stable@vger.kernel.org>; Tue, 11 Mar 2025 06:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1741700829; x=1742305629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XO2ybzFgWX+w45tby+tU47c4Q9jbDC98Z0JXMVZgPG0=;
        b=2Q6n5T3o3c2xnRJ8C+nvWz9pMETCD9a7CPssIy+mIg7vxlWKz1F1mp65taICTCQxp/
         VxNuxlt8PK78X6Jtd+ov5sEO6jHIbcAchQuVtWLa0ws6TeO/um92NCOJ6eAAGIUPRvox
         7tyaP2OA2PH5GFIOzTWeMja3Q1gLp8E6o/uFwEj32UtnWIv+kyZtGALhG0b+hADoueg8
         ngNpJZHs2kNUz6u8J3OuSPdN06JZdjGynXtG6WL5dFG5j8xtZkg8Z3qhOOoamR4NcvmW
         QwzqMw+qGjKaewFFmt2YHM9AwKUZsd9TLJD6BApIl/1o4DJmaPoE4KL6cK8yf23RE6ie
         Anxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741700829; x=1742305629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XO2ybzFgWX+w45tby+tU47c4Q9jbDC98Z0JXMVZgPG0=;
        b=Vw6QNFj67tVhWmtunSz+CFqclmyN5ngXgolmIj4Hyq5KeFO6pioLaAPysa91bEqCzI
         Q657CEsDDSMlkzuuwSGMqbBpjGW77s7KOtat9v/Adlbcdwx+Ny2yR7OPJ5tX43B0vYzi
         yQxK9vybPRePn5kdPWEBKPklD6SCT7MV354Uwb+XyYkEbuksjMM6uarhuJrk8ySY/2Ot
         OaFNNBJRcyp3y6jTWNbTe9m9AC8HuE4mSwX1lC3kg4SccbbqA13bxxyhznFzED8RObEd
         ohv6H5wVghKUCsIytzKBt/dwm/Dx8jd/JRoXpPd7EkKXcWVvz/UyeoltjPgHqiXSaJLq
         lr1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3FuLk9/JKKWcsSoMbRWe6lmX1HmsOukt5MKrepjIIOGAV3bVthiZ99yU34vCBZD+t/yHyu/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSGJgUaQfWLnC9iSV+L0KFt9Xf0O5NYLA2k3H40FuMJ4+eX0CW
	sgJacV/IsR6YzW+9ixKXyXqRKBORN22cqvvkKDuzkjvWRvFY/br4GwZ6CwlHxfOMqH4YjvZmBOD
	IdRoBFQZ7IOoUFhBq2BXR7qaQz/kwgkdvVBSW5w==
X-Gm-Gg: ASbGncvuf71OXN2y/OxBEmsYFE+y0riprOath4i+fOeQHZSgqlTzvfxBXskrWHdvBfb
	JvM6a5n9d4TxPyWZGdHPQB4A8up+WegFR3bLNweVRfN0o0CJ74l3NJxMpDbDNoWbCp99tzWWvXq
	jeQvckPtujKatVKKYxhB3RHf6MVJzFU3Vi7tUNcbn8kZ2SKM+MXhB5q8T8y98=
X-Google-Smtp-Source: AGHT+IHDN3QjEyPFaI+q+tBg6ITEkL1KlJmFcL0VU+25Lp0H0AdiTi+BHPathj5+erzv9qHHn0N/tSSUoXvplVO7pyg=
X-Received: by 2002:a05:690c:6813:b0:6f9:af1f:53a4 with SMTP id
 00721157ae682-6febf3ae047mr256271357b3.32.1741700829313; Tue, 11 Mar 2025
 06:47:09 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 Mar 2025 13:47:06 +0000
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 Mar 2025 13:47:06 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Tue, 11 Mar 2025 13:47:06 +0000
X-Gm-Features: AQ5f1Jpg2xFoTQk-3cindz2T69_7jR3bgyi5fDmcCGq_ao1rQmMw6Indk9AnvQY
Message-ID: <CACo-S-0BKPQcA2Qh-7jmuU-YuX9E_wWcHEgr8pDhgwkzt0K5cQ@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build) in vmlinux
 (Makefile:1212) [logspec:kbuild,kbuild.other]
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

New build issue found on stable-rc/linux-5.10.y:

---
 in vmlinux (Makefile:1212) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/issue/maestro:d5c2be698989c7de46471109a=
ae8df0339b713c1
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
- commit HEAD:  a0e8dfa03993fda7b4d4b696c50f69726522abba


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
.lds
In file included from ./include/linux/kernel.h:15,
net/ipv6/udp.c: In function =E2=80=98udp_v6_send_skb=E2=80=99:
./include/linux/minmax.h:20:35: warning: comparison of distinct
pointer types lacks a cast
./include/linux/minmax.h:26:18: note: in expansion of macro =E2=80=98__type=
check=E2=80=99
./include/linux/minmax.h:36:31: note: in expansion of macro =E2=80=98__safe=
_cmp=E2=80=99
./include/linux/minmax.h:45:25: note: in expansion of macro =E2=80=98__care=
ful_cmp=E2=80=99
net/ipv6/udp.c:1213:28: note: in expansion of macro =E2=80=98min=E2=80=99
In file included from ./include/linux/uaccess.h:7,
net/ipv4/udp.c: In function =E2=80=98udp_send_skb=E2=80=99:
./include/linux/minmax.h:20:35: warning: comparison of distinct
pointer types lacks a cast
./include/linux/minmax.h:26:18: note: in expansion of macro =E2=80=98__type=
check=E2=80=99
./include/linux/minmax.h:36:31: note: in expansion of macro =E2=80=98__safe=
_cmp=E2=80=99
./include/linux/minmax.h:45:25: note: in expansion of macro =E2=80=98__care=
ful_cmp=E2=80=99
net/ipv4/udp.c:926:28: note: in expansion of macro =E2=80=98min=E2=80=99
FAILED unresolved symbol filp_close

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## cros://chromeos-5.10/x86_64/chromeos-amd-stoneyridge.flavour.config+lab-=
setup+x86-board+CONFIG_MODULE_COMPRESS=3Dn+CONFIG_MODULE_COMPRESS_NONE=3Dy
on (x86_64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:67ceffea18018371957ebdc0


#kernelci issue maestro:d5c2be698989c7de46471109aae8df0339b713c1

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

