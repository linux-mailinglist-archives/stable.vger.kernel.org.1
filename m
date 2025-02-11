Return-Path: <stable+bounces-114927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F955A30EFD
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 16:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1443188398F
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 15:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B301F1908;
	Tue, 11 Feb 2025 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="d1jS3OiU"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075703D69
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739286069; cv=none; b=lGzbj1zBwgG9XUn074IRFE5/75D557fsWmJVLfqKxmn+ZnXftweddHeMc1VnZVHbDkVT2Tbm5wgI7WvWKQ1NW77tw69KxI+sD6cMtlunAct5dsnCQZ+c81fy4VX1uNQmVhJdjUX08/nDK7o38OQpQEMtFVPSzkphvdeDjSg8J9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739286069; c=relaxed/simple;
	bh=Ofa5dbIJCu+eVTjOissChnoO2iIcMxHa67pbWTdFTE8=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=R5mEiLLSxxZtJwB4lfxKv1K9H4v3KGEu5GyJi0UMsc6Wa+2NAyn1XNfKsjiw/iXui9itp1pgsP+aGNa85A9v2eh50/MX5x4B3z79tXIJ9SfgETmM7ykEKnk2jZBUrbsP2Z/yd4T5XB6Us7W3w/dA0ijzFpY+eq6YR5lI10L2zDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=d1jS3OiU; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5de727f7f05so4089208a12.1
        for <stable@vger.kernel.org>; Tue, 11 Feb 2025 07:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1739286065; x=1739890865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T/pm50ZRzdw2JfPDCT7+uPkJhcS1ZAC7CzSLPTgGKBc=;
        b=d1jS3OiUzhl7PhE2cy6psTWdSY8mQU6BxuibJaTZiNUwqc1ZHRqp3r6n+GqJFY7/Sj
         BcPKxxCtyC0VMvHfYRk6XEVaxdqfRN88l4J5+oMprixWtGtqyIdpH1ZmWt1ud8mtzxde
         t7JYaOnK5ky7xRexHdsMvjYQXYE534EBCWHqvc8sfpatHdgM5pWi0Bn8O3fB32df62qj
         miEowypG+ZQGFUjAyaQO1hedyMx6ojDv6w65uh5mK+WYFqTBCLGVjlGbtI9nb1REJLfs
         qlBzTUk60IpZNEpQd5C1mi4TXeOFVvosZ2k9P0yBlUfXpiYVpWBmKTIdOIKezJOsQsOr
         cjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739286065; x=1739890865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T/pm50ZRzdw2JfPDCT7+uPkJhcS1ZAC7CzSLPTgGKBc=;
        b=ppUZReK5rt4r04SfBbwnOOKfFV7dXvBL0veKr5zGmiQ20M72eyseQMeNAXfWu4Yr6g
         9GRQBQ1MhoWGD5N4zCJGlp5RSgKGroiJUU3kOiT84rRVKKGhgrIHHhswObYdYZvjOkL3
         m3OImInTO4w1A8DXqFXwx6A/MjfWLY665wlWFV8F9+0PX8w3hL/KB+M2r/XiMkkT+x1P
         tolyGQY6/xDJn7YigX8KP6Mm6OKEbOEdWknZsQDan2MpZlSDScYBn0gUMTZpx3mGYrHz
         yEFYJnMQANdg9E5bpOdpH47UGHzpWmygw8FtLXkhErWoI3rtolbUYhMC5zFBufXbejrI
         Ehxw==
X-Gm-Message-State: AOJu0YzP716ANYEZ3Jq07eJT40alvfSyH8c0p8V2C6hTJJXqUThLR3om
	B1/1C6zFbT1hDpmMVygYsRh0pB8JdFaEvUg70SDA5Csj0QXbG5LBHbAIH3+iCRM4Jq4oRu5YG16
	Ej5zBimPM88OWN2ArM0ghc7MyFU/bEZQfv6Gs5anSrM4TpSgSlWg=
X-Gm-Gg: ASbGnct27bZKD5LiIUmy4I9t1yb5+3Gdi8+qhTxoXZi5/k230ruIZA8zyEdiCnG1smh
	NnuT5Y8vy6rqo2ZvF++ZX1L+dcpaZEqwITAnDwCLkRU46i+vHVjIT2iOk4dF8fojPKX3iDhQq8w
	U8Pn9UPBHFEill5C4H3Sax3dkrmLMigA==
X-Google-Smtp-Source: AGHT+IEB/MFleqFDKJ/smFprr/HUvEtKLkQYuN9V7ZbaWSG2/U5GFIFUEw259P7exZglK6XpC03Xmwim4X+4BlhiSsQ=
X-Received: by 2002:a05:6402:2086:b0:5d0:bcdd:ff8f with SMTP id
 4fb4d7f45d1cf-5de44feaa42mr16314877a12.4.1739286063741; Tue, 11 Feb 2025
 07:01:03 -0800 (PST)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 Feb 2025 07:01:02 -0800
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 Feb 2025 07:01:02 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Date: Tue, 11 Feb 2025 07:01:02 -0800
X-Gm-Features: AWEUYZnV7cP7uXRjL0IrMpWPPja6DQ_GxauiPfDvNovF4cKnJ5sLHvic4C75LdA
Message-ID: <CACo-S-0xbf-iwB+im4SRNywx+ovf0Lv-CzFb++jizY_nCSKBfQ@mail.gmail.com>
Subject: =?UTF-8?B?c3RhYmxlLXJjL2xpbnV4LTUuNC55OiBuZXcgYnVpbGQgcmVncmVzc2lvbjog4oCYc3RydQ==?=
	=?UTF-8?B?Y3QgZHJtX2Nvbm5lY3RvcuKAmSBoYXMgbm8gbWVtYmVyIG5hbWVkIOKAmGVsZF9tdXRleOKAmSBpLi4u?=
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org, gus@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

New build issue found on stable-rc/linux-5.4.y:

---
 =E2=80=98struct drm_connector=E2=80=99 has no member named =E2=80=98eld_mu=
tex=E2=80=99 in
drivers/gpu/drm/sti/sti_hdmi.o (drivers/gpu/drm/sti/sti_hdmi.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://dashboard.kernelci.org/issue/maestro:5e925d96a3540cf43=
ab1b679d0e9b4356b623237
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
- commit HEAD:  16f808b001a697126972a39c8a2600c33a616ebf


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
drivers/gpu/drm/sti/sti_hdmi.c:1217:30: error: =E2=80=98struct drm_connecto=
r=E2=80=99
has no member named =E2=80=98eld_mutex=E2=80=99
 1217 |         mutex_lock(&connector->eld_mutex);
      |                              ^~
drivers/gpu/drm/sti/sti_hdmi.c:1219:32: error: =E2=80=98struct drm_connecto=
r=E2=80=99
has no member named =E2=80=98eld_mutex=E2=80=99
 1219 |         mutex_unlock(&connector->eld_mutex);
      |                                ^~

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: gcc-12
- dashboard: https://dashboard.kernelci.org/build/maestro:67ab2fc1b27a1f56c=
c37dfff


#kernelci issue maestro:5e925d96a3540cf43ab1b679d0e9b4356b623237

Reported-by: kernelci.org bot <bot@kernelci.org>


--
This is an experimental report format. Please send feedback in!
Talk to us at kerneci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

