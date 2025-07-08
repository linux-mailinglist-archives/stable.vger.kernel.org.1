Return-Path: <stable+bounces-161344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2577AFD6C7
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 20:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007EB4810BC
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF7E2D9EFB;
	Tue,  8 Jul 2025 18:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="1M6Qna0R"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE14921CC74
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 18:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752001148; cv=none; b=ng4adFOqTJ9hqVxobGUMdUBAkAKzhDmH0U6ldJA2dKwgOTyDp/HIqXVDjTWcvvjw7JUWqKH7MT/UbdZWYQyGhvbuex+UoWXsVncuJdriWx2JRm7gxMWj1cuWc6/eituH5PoS/rjqUV9jpZgiXBazHXulHH06vNyTsHZwnV0QtI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752001148; c=relaxed/simple;
	bh=nnl93hOMhM+gfSSotZEzkzmWfQtCKJkWdcvQQTiSohE=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=t98oqcWu9VUd3GwIqEjZiAiNcrB+4KbUkPZSAHepR+gtDEU1z7RQjX7HfkuE3YpFO1N9ZeEeRXALhyEsGZL83H3Dw+U1kyv0USyPbdfn+9IMlizao7rVbJLy3BPY1X5xvLbev6sfpguG90kY/6URzFfcZAaxO56m3gZH+nRkQTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=1M6Qna0R; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-70e64b430daso50189897b3.3
        for <stable@vger.kernel.org>; Tue, 08 Jul 2025 11:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1752001146; x=1752605946; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xy8GhAs4J0+JbpUEhsvEKEWLh3LS+ybEpTBNx40zZnM=;
        b=1M6Qna0RWVZpXRCL2a6yxzu6v+onE/gvNsNufmGL61efsjq1net/bIJpbZZ4jSnSo9
         18PhrJ29TGoR4gB6Px145CQnPY1zaEqkstYxvSVcJ4iuKEuE7aHF0smrjxo6P8oE28bs
         oR32Ucp4hW1hJ3VV+9DAUNacQ4+4IHtpUPMFcvJH4rFIi1jnE/o+vBIi6ZJGKjSxMRtO
         vLAKO6aNTgMi2DduTPy7GD3jTFodfL2qff+slNZ/HRN13tg38HWfFnTQza7DeZ4qDwWB
         p57kBE7nc228kDWeye/v4YCc6CfHvieV4KAWqnQ/ao9jGnojuJOgTYx92sclgEmkH6Ao
         rhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752001146; x=1752605946;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xy8GhAs4J0+JbpUEhsvEKEWLh3LS+ybEpTBNx40zZnM=;
        b=FZxPJdK84ROCOvSx3DfnmSwYpaHqWXQTUGV5f40gnAe+9nrCUglhKahJIIWWsJnCBh
         P7Bt1bqSCe+LqkBW/yqCnnSBp4fW3ETqyyWCtgyzRoK7+DZsX/YtyivY+4GSG8eDJ8cs
         QfKOSP8lFx3SDNSs0OXhEhU8rEHcaXygIw44dvSS9GdXKl+mq/2zdXVkF5QYoKCUlXfX
         d1KcAnRivXSgdRnwQS/ab8CtrYHQyBAVrYNLh34lhrThUSfyLMEa+tBrjCXorEQ+AsZT
         6R0iAabwo7eiH0x9isk5gU1i1xV2eCJdZh3KzwqHx61LbOmCfTaHjnEP5HUXEuB5dgf2
         6EVg==
X-Forwarded-Encrypted: i=1; AJvYcCXUnYMmb4SR+sPnwnlXIBP/Q5vmEVfWLpM5fDAlDCkTi+ZELGibvmAywMBsomfHBD29NWGokOs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2d6jOE4Lmf8BDr8kLsPqQZzTkw6R9gLXKvnjHzFjVmYTHShGZ
	LoRJLTuB0hA9VQEzgRGjKy0Xuv0W+ZWhOb4BIMZS5k3RALKVaut8Z9PJ3imeqICWAncbXHwAtb6
	YxeyR8SpsavB1M7WsbhP4LgX1qL1F7suutNwx4FBOZ+OxHbOzihMa/zxh2g==
X-Gm-Gg: ASbGncuRvMbOvYx4I76vRXmNLywnn2aCpYogW7n/fgJQvu71kuEQdG0aX8LKcJHHYz6
	dyw9RcZcC1ToGwekrk8+GMYfnraRe/6nvwE+u+NwEFV3IK+VELfY1TNP57ULWczbP0IdSLqed+j
	dEWo/aKbyidXeL70bz0NZiFHjFowu4LAIGQsw4Op+veA==
X-Google-Smtp-Source: AGHT+IFAyYIMdgI4dEbz58tfzdtxWlwTl8+KpWcgaTWJKi/kPkAdUBQgxMNTNN5zq5qysm15P6NN8hxYaP0hsuPwzag=
X-Received: by 2002:a05:690c:690e:b0:70e:18c0:daba with SMTP id
 00721157ae682-7166b7e8151mr232445377b3.25.1752001145775; Tue, 08 Jul 2025
 11:59:05 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Jul 2025 11:59:03 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Jul 2025 11:59:03 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Tue, 8 Jul 2025 11:59:03 -0700
X-Gm-Features: Ac12FXxohgxT3RligQ5nTPsHI3QqvvKqmz2H9bsqM7oe9dOSgGQoXRr9YiJqrso
Message-ID: <CACo-S-15+=Ty=4jdpiptsi+-d_8z65LTCZCrir8zaGeG-CTT2A@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-5.15.y: (build) undefined reference to
 `cpu_show_tsa' in drivers/base/cpu (drivers...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-5.15.y:

---
 undefined reference to `cpu_show_tsa' in drivers/base/cpu
(drivers/base/cpu.c) [logspec:kbuild,kbuild.compiler.linker_error]
---

- dashboard: https://d.kernelci.org/i/maestro:64dffa8d7ec37a4cc39ef1929ca500d06c7d1ab1
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  57a10c76a9922f216165558513b1e0f5a2eae559



Log excerpt:
=====================================================
arm-linux-gnueabihf-ld: drivers/base/cpu.o: in function `.LANCHOR2':
cpu.c:(.data+0xbc): undefined reference to `cpu_show_tsa'

=====================================================


# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:686d492434612746bbb51ead


#kernelci issue maestro:64dffa8d7ec37a4cc39ef1929ca500d06c7d1ab1

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

