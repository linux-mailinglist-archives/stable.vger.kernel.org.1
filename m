Return-Path: <stable+bounces-114928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A62A3A30EFE
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 16:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9DE21882D50
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 15:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85851EDA28;
	Tue, 11 Feb 2025 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="DZOmzf76"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6071DFE11
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 15:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739286080; cv=none; b=ncWyZ7YeOaatRnwz9cLqV3fmYbQq2GFuHSPXatOlt0LBJ8Gv+HalBe5nulDfPYAbCAMRl9U9XHtQIvdWzK/KA2az9iH2EnROuPRk4/ClSQHiTKeuT/QeYGXJz0+P0KxOnlNa9DMnKR7TaoqMZ0HnB4Cgd7Z2MbMdWtbUBusrIuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739286080; c=relaxed/simple;
	bh=Ne+9yC0HOznRz8p7lTsKhBcNJgAJ20piItJceKLJz2k=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=X40XM0fStMwVUWYoCuW54E44Fm1hBG2nHmkfTWmm+u0hWd2bawLGf7jKdtxi9ojnLi+owJKxl0Zqm7dNPqkDY08iZS65MaV8g7CNsGCOVCyZ0uM5OWfvwG9xB4fHm8F4GafDiEet/NnMOPrNUpkDMbC5R0Nl9l6HblOzhS+6c80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=DZOmzf76; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab7e80c4b55so109061466b.0
        for <stable@vger.kernel.org>; Tue, 11 Feb 2025 07:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1739286077; x=1739890877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e7SVrnRYXWq8YlC1nAk6TknCge+mlT3ZmKPNftk8oWs=;
        b=DZOmzf76eOnro96PNLoHhNI8nJgwXG5tdRJhlK8Oo5nb+9DePvjeWOvNZ7wP4sjufg
         OxPwQ6u9ecli6cZe8H/ZsI+3yKVBpBE5cloNQyxMGhg8aGB1ozOfuF6xCBsUHInTfiaL
         WcEFU2M0uTCkYxX2moasulU0NelnpennXcUeXG/ftOUMXUIYS32g6703TdjzeNHXJiZu
         0u4YOsOS7haUCPLr0WAvZK8PZMqLttGiRB9D2+VK2sZc1StiuRAq5R55abw+8cKPhif6
         e46l1ARHyYvSEtqfSnxenZrqlbaBa0a3eUBN62NBjrqfo3YZK+W0gzwGGCozocXCtxsf
         zdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739286077; x=1739890877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e7SVrnRYXWq8YlC1nAk6TknCge+mlT3ZmKPNftk8oWs=;
        b=oSg42IRdfBwiuhjQBtrhFSfOs1n56MqLJXvKVQzHxAk2op8DWno1nedIndkU81zZ9b
         rs2Z9yDLxu/UvweUBahsDmO7b+eSCwhBI3yCnkBvmo6FGU1JhHuUdKsTU2v920XbeROw
         fqSaSt0yTYKi66cO7F3lmsDFBKmlbq7g/YwnqH3H4kcfFhFNGcRXNK3apZ2a1NZ+Dech
         CAsPzMlHxCUDm0ytnb68uM7XY4mfSRTBMwTWKG8lYMesHgo50hT1ZgjQjJw3qUgJLWg0
         /ROUHwvyYQQaX+5ARS2kjg/M1fi1Ykw2ReXQudStkCSP+4xnOe6ZxKny3kHUz1gFaUmX
         ZTeg==
X-Gm-Message-State: AOJu0YzZpKnes+2hlCyaNKd1FNIZPimip0Flof9kmggx8PRpgQBU+njk
	gMNChGNxijiICvdeH2+qDT9Dpu2hy2/ebojC4wbtd+wJKEI2Lxco5t3tqzuYsxv/PiE+eOKuc1q
	oqIkNPui4I9WlXnPKo5RhNhb6naOhCBIZwsQNNg==
X-Gm-Gg: ASbGncuu58hrVCJPxBUYAB/Ue4R/nEI3Vpiu5fP9abw4QZ7fRByuAR1ls6/cmOgPQcH
	2e0QxibWVJpWf1Hpt3A+EfJMJvAofExP+2WF6fOh+ar1T5AiCs2IJe3FP6mwvr8wmUZkWYIZ2EH
	7wfglt/znDo7UDoylNgHJR7C6LW4XbeQ==
X-Google-Smtp-Source: AGHT+IF6MvXsgI4UqbTQqt+kC5NrZjKZHUzL7oV9ore4R3f8cMl/tumJHVaTYC+uXDuUbUQmZfyUHVuJP+PwF0ZoPfI=
X-Received: by 2002:a17:907:72cd:b0:ab7:a679:4b00 with SMTP id
 a640c23a62f3a-ab7a6795bcamr1350104166b.40.1739286075386; Tue, 11 Feb 2025
 07:01:15 -0800 (PST)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 Feb 2025 15:01:12 +0000
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 Feb 2025 15:01:12 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Date: Tue, 11 Feb 2025 15:01:12 +0000
X-Gm-Features: AWEUYZm9qvwxVv3riUtiJhozhthsKxqC7JFedaZHzOR9XUTL8ditNAnb82tP2Fk
Message-ID: <CACo-S-1Oh=ak5U4zZoFPM_TWZq7MGvpRBrA1XgjnGx=hZpzyZQ@mail.gmail.com>
Subject: =?UTF-8?B?c3RhYmxlLXJjL2xpbnV4LTYuMS55OiBuZXcgYnVpbGQgcmVncmVzc2lvbjog4oCYc3RydQ==?=
	=?UTF-8?B?Y3QgZHJtX2Nvbm5lY3RvcuKAmSBoYXMgbm8gbWVtYmVyIG5hbWVkIOKAmGVsZF9tdXRleOKAmSBpLi4u?=
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org, gus@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

New build issue found on stable-rc/linux-6.1.y:

---
 =E2=80=98struct drm_connector=E2=80=99 has no member named =E2=80=98eld_mu=
tex=E2=80=99 in
drivers/gpu/drm/sti/sti_hdmi.o (drivers/gpu/drm/sti/sti_hdmi.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://dashboard.kernelci.org/issue/maestro:7fe27892aa3e055cf=
7cbc7660b69219ecce56688
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
- commit HEAD:  5beb9a3ea62e7725d8cd88410dbd269ebf683ce0


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
drivers/gpu/drm/sti/sti_hdmi.c:1223:30: error: =E2=80=98struct drm_connecto=
r=E2=80=99
has no member named =E2=80=98eld_mutex=E2=80=99
 1223 |         mutex_lock(&connector->eld_mutex);
      |                              ^~
drivers/gpu/drm/sti/sti_hdmi.c:1225:32: error: =E2=80=98struct drm_connecto=
r=E2=80=99
has no member named =E2=80=98eld_mutex=E2=80=99
 1225 |         mutex_unlock(&connector->eld_mutex);
      |                                ^~

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: gcc-12
- dashboard: https://dashboard.kernelci.org/build/maestro:67ab310db27a1f56c=
c37e118


#kernelci issue maestro:7fe27892aa3e055cf7cbc7660b69219ecce56688

Reported-by: kernelci.org bot <bot@kernelci.org>


--
This is an experimental report format. Please send feedback in!
Talk to us at kerneci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

