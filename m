Return-Path: <stable+bounces-35574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA776894E62
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 11:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0651282C67
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 09:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCE656B89;
	Tue,  2 Apr 2024 09:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QrqTzvg4"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE17447A53
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 09:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712049163; cv=none; b=h1m67pEUIEvKTyX6rd7rgmM4cky51IJTf9nQo7dlyPOQuVAyA04tGqLYr0YdL369VK0EQ+U/bSpk+RmyqID4dXsUZ/UGLSCh5y11jMaZKPwVsvjLrN4LjDXv//AwNiSCBLr4vJJ4QVEz8VHhKizbUe3TVUEqFtho0NXNhKsRQe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712049163; c=relaxed/simple;
	bh=l0kuH/gfbmiikxbhEulmwyHjIEKOY/iskP8dru6n0As=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nK3l/niFfIdEMPaWyIxfRqBUJ+1PyYZ+1pmyPisRo21NYb5r6Vw1YxNU1d8168OSVq9JXp0KPMAiy/GQblM0K+Scub/CIhZnaLvnKnSDpdYIEs6/iph3IDU9PcjyclfqBqaoKEmcsh4CInSi7/FCJFeckGOENevAbpqgaadgG6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QrqTzvg4; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4d8804a553dso1853313e0c.1
        for <stable@vger.kernel.org>; Tue, 02 Apr 2024 02:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712049160; x=1712653960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+P752m0UXgMwu+wcLoyQGRKQoJ9RrigTqZcnP7ifrkk=;
        b=QrqTzvg4zLYLjcsm3k5LbfbQbKTrhynbXdzCVML/nShdpv20zsjVr1deZjaD/grWy0
         T7uPK04GPo27dsS5HRZ48OJlUPRONrfKncpb5ulxOYy9DNq9g65b9q/Vk4ulb1DBhVWB
         L7TrZOmcaYNDSRgXZiXKsv5PCgDssCDAdBRA8H9+TUixFimuVLovNroX549ivP3gMPD7
         1DALH59deJEQOFomoyc98F/nkiE8lPqpVm19mXBwk+QWMwNOsb6Wy3yoyikl5CVhLO3e
         UzeGjXZdG/i8mi/4h9cZBC2BshWj/ge7MOvIFEru9yKecf/ryUpl3FOtq5jeqJsaxtFU
         BtpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712049160; x=1712653960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+P752m0UXgMwu+wcLoyQGRKQoJ9RrigTqZcnP7ifrkk=;
        b=GaDarS34umk4cS6vP5q7QQjdw6bhNthBclu21S+AOHQOL42tCgT/ZkBunJq9RbKOsR
         A1YPyKTLXRRlGQCSVQgHC7Thn1wupgyJmAYZaQAEpp5SerMJqMIxPxsg2bGJSaLwqcon
         07wFcQPB8bz24uHBN4twkHfyj8BIkxsqOyj1uILbBIvU+1aPapU301+Lzu94IPp88fIR
         8jrlLe7RRz12g/qoZRYA1NfGjJ85N4PY2hZ14kaJjvkJUp+LI8fIDFDNUhLcjv8e67sS
         szx1rMi3WcIxJ1XfEY+nST2Ovd55Aic+2L+IOjv5exXusr6CJ2b7wFK4sfxmGcmK5Cpo
         FcnQ==
X-Gm-Message-State: AOJu0Yz8sv2bhef9xPZp6MGIpIVkz9Ru6L2j4h7uobHkev3mYZiCt/eC
	fvYo+QCJ60i1jziqAHgtaKodqOjqCe7vKcJEUTleuzcBb2n7W0/szoiyDacYxg5xO/EVmEgd/eB
	hJLgUyAUu5bgI3wcI3ekBR3oHxDlwh9nE69SDkA==
X-Google-Smtp-Source: AGHT+IGOwJVS4tsWfZd+Ju7r2YOHsi//JygXPETSWaASHl0frkCaqLwDK8NaKNahmunxLBxFRjKO4hlQwlv7FcfaS3o=
X-Received: by 2002:a1f:fe4c:0:b0:4d8:37eb:9562 with SMTP id
 l73-20020a1ffe4c000000b004d837eb9562mr7441662vki.0.1712049160602; Tue, 02 Apr
 2024 02:12:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401152553.125349965@linuxfoundation.org>
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 2 Apr 2024 14:42:29 +0530
Message-ID: <CA+G9fYvc8axBi9Hm_WDac5v-4DiDmiFuKxk=Ghx80obEO9Uknw@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/432] 6.7.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 1 Apr 2024 at 21:41, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Note, this will be the LAST 6.7.y kernel release.  After this one it
> will be end-of-life.  Please move to 6.8.y now.
>
> ------------------------------------------
>
> This is the start of the stable review cycle for the 6.7.12 release.
> There are 432 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.7.12-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.7.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
Regressions on arm64, arm, x86_64, and i386 with libgpiod tests.

libgpiod test regressions noticed on Linux stable-rc 6.8, 6.7 and 6.6
and Linux next and mainline master.

Anders bisected and found this first bad commit,
  gpio: cdev: sanitize the label before requesting the interrupt
  commit b34490879baa847d16fc529c8ea6e6d34f004b38 upstream.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

LKFT is running libgpiod test suite version
  v2.0.1-0-gae275c3 (and also tested v2.1)

libgpiod
  - _gpiod_edge-event_edge_event_wait_timeout
  - _gpiod_edge-event_event_copy
  - _gpiod_edge-event_null_buffer
  - _gpiod_edge-event_read_both_events
  - _gpiod_edge-event_read_both_events_blocking
  - _gpiod_edge-event_read_falling_edge_event
  - _gpiod_edge-event_read_rising_edge_event
  - _gpiod_edge-event_read_rising_edge_event_polled
  - _gpiod_edge-event_reading_more_events_than_the_queue_contains_doesnt_bl=
ock
  - _gpiod_edge-event_seqno
  - _gpiod_line-info_edge_detection_settings

Test log:
-------
ok 16 /gpiod/edge-event/edge_event_buffer_max_capacity
**
gpiod-test:ERROR:tests-edge-event.c:52:_gpiod_test_func_edge_event_wait_tim=
eout:
'_request' should not be NULL
# gpiod-test:ERROR:tests-edge-event.c:52:_gpiod_test_func_edge_event_wait_t=
imeout:
'_request' should not be NULL
not ok 17 /gpiod/edge-event/edge_event_wait_timeout
ok 18 /gpiod/edge-event/cannot_request_lines_in_output_mode_with_edge_detec=
tion
**
gpiod-test:ERROR:tests-edge-event.c:125:_gpiod_test_func_read_both_events:
'_request' should not be NULL
# gpiod-test:ERROR:tests-edge-event.c:125:_gpiod_test_func_read_both_events=
:
'_request' should not be NULL
not ok 19 /gpiod/edge-event/read_both_events

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.7.y/build/v6.=
7.11-433-gb15156435f06/testrun/23252698/suite/libgpiod/tests/

--
Linaro LKFT
https://lkft.linaro.org

