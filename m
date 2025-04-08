Return-Path: <stable+bounces-130375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96ECFA803E9
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CA9D1893433
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B856264FB0;
	Tue,  8 Apr 2025 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="aO6cQq2q"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309D3267F57
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744113549; cv=none; b=BQ6OQ7GYPeuRCf3ugDSxoQqyhpt43BZZk8yQobmEt2+5+xkriEhhYRU0Ub2CncO54DOhuLvFtpCLldI6sXMF8IZehiWhYttRpWs0HB0jhPr30mckhw5e8xpCc53Ppu/M8SGc96gLE2PyuR29XH/ex+QJxfbHo0prcHhV0QWD1M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744113549; c=relaxed/simple;
	bh=pJMGVnmgu3uygdF9gANPcbRGILIh/54Cg2TGIWWcP7s=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ooov/uD6dwD8fOHUEJ/GyEjXaokkA+QcPZ18wc9JZ1TXaYTQ7APsG8X+9NFd31WPNcx2ybh59u1vKD042EpZkX7jBQGGhNd1F+pIid/w76ZBddI/NyEEvPWeGllpT90U8KAOLeYtXH3D8N23zvn37m9ekLFcEDxTsuq5EHEIw7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=aO6cQq2q; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6f74b78df93so66464187b3.0
        for <stable@vger.kernel.org>; Tue, 08 Apr 2025 04:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1744113546; x=1744718346; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqqwAHnrhVDOJSx1Sba5s8DT9/kR/Tih9b1HMNwTeNo=;
        b=aO6cQq2qn4qLJFC1enbQa22hchZi/20MMeumcFc5o4Qnvzu0oFbmdOo3gBmU6xp0kf
         izhGWIMzCGlh0Ido6lNHx4a5UqWTtProZJEQcVoQQNP170yUTON59D6nvAUn19ECD8un
         q5T4a/TLIZTMADjc+qCdPGRBN8nY05W86bPYWzeI4lnGpEC4pPUplaMPiUR7mLzvQlUy
         r93xftEeUkgNAuOF/754BLFnvW1M33qXK4IP4pIP18yNzRGQmreKKdVVhhRIIjuT3hqQ
         0dk5V6Ei7dclbpusIPNVWc6y8DqDS4Ucju/WZNwiNQE+6y40VbMcK1rpS5lvohl9BanT
         dQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744113546; x=1744718346;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OqqwAHnrhVDOJSx1Sba5s8DT9/kR/Tih9b1HMNwTeNo=;
        b=RoJ2leUed77QXJ+yyG5TLIZmIblSFJ7zQ5nhjSVXdhXnkartFoN8Qbql1AKlWUrNCJ
         YYmUMmuA3iKoIZgpj7cNgXQzCdzCtwZJpIAXaFwSvapO/N9v5UWAhNssdhvxbNPYgDB9
         T8jE8D8R80hiVpYuJg13SIFo/MgGluEjieZAtX/bedVdochGfco1Hwvla7Uu14H1luMC
         RsSjXHVU/sjpCy/8HjB4Lm0ynXGEo484ktLzxcp43SJTf4XKH9wiSPRSJ8iZRRNiGPDT
         XYS38939CQdSnl7E/TN6kylfQLLrZOL440iPP72U2lyMHDpVQOjYqq1oLimTtggNONt1
         fR+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7mMh0RvmgtSJPDk8KgSSe56DC2CFEGqcruyWXEoIDEr6c852zDdzSs+bdl6uO3ek1ijyw7m4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2BTXTUgShtJL8FDVNTfEeLe0GIGi701Q6D9R5a6vqWPcjDgKm
	YflLe7wfvHyg+da2H7eMy0xXi/PGkI4oe+a9biPUKCKmH+KIlB8Ol974WXpujjo+OhVtMXhbHiP
	Rzc7obAj2atWcCyYwYG8jS/JzzijhIpIbG2uVwQ==
X-Gm-Gg: ASbGncuDIhUUPJEriGN8AJ7PLt7wsF0tLP9hMwGM1RX70AenJquEwrsL/IvHpCspT4t
	4xUyiM9jVqeMU6OwDpZfh4INts7vS0TNu9q4JFOPhRAZ07KVNtwwT9gKWwuQJdpmgpDp7n7t8AN
	TtidOIhGAqUj4yiorP56/W2s8oQ+py1w0Y/S8=
X-Google-Smtp-Source: AGHT+IFkY++O5FE5WHMaVmpBF1JHhCkrY00Ioe86LOcTFsj4SCIz6bTX13O+A8/Q9airwMrdh7jW/x22ch/1MfzrMPY=
X-Received: by 2002:a05:690c:38d:b0:703:ad10:a71b with SMTP id
 00721157ae682-703e331a46bmr281448917b3.29.1744113546088; Tue, 08 Apr 2025
 04:59:06 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Apr 2025 04:59:04 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Apr 2025 04:59:04 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Tue, 8 Apr 2025 04:59:04 -0700
X-Gm-Features: ATxdqUG0awq4Ddg0YkfT8UFqb1r6shLxG2cv-jIIY_J83lZMaHU0ZlrJ74u1Nl4
Message-ID: <CACo-S-2borpHnHzZ1NGvm_8S2+f_XL-tnuNgZd=NrqiPKty=wg@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-6.12.y: (build) in vmlinux (vmlinux.lds) [logspec:kbuild,kbuild.compiler]
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-6.12.y:

---
 in vmlinux (vmlinux.lds) [logspec:kbuild,kbuild.compiler]
---

- dashboard: https://d.kernelci.org/i/maestro:9938a6d051bfcd7063bdcf21603c29bf8822a3a5
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  8e9508dd93587658f8f8116bc709aeb272144427


Log excerpt:
=====================================================
arm-linux-gnueabihf-ld:./arch/arm/kernel/vmlinux.lds:30: syntax error

=====================================================


# Builds where the incident occurred:

## multi_v5_defconfig on (arm):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:67f50c196fa43d168f278cea


#kernelci issue maestro:9938a6d051bfcd7063bdcf21603c29bf8822a3a5

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

