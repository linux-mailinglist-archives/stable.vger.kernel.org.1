Return-Path: <stable+bounces-135148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4340AA971C5
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 17:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1759A189F99E
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 15:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3283F19ABB6;
	Tue, 22 Apr 2025 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Czr3ZNj1"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F565290085
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745337549; cv=none; b=E578LHCpwkqol6yjTmrrjmGvcCJsQTSrgDYrOlw0WsIQaHQAD9kmvJo+PIG7I73coJFZxbD1vBECzRaFw8646Hj2uOY00hpwDGSFkuGY8hWcWP9W3oXyL8HWqGVoQurGANzZlQs9Ce0THvd4wKE19NWVYHdqotCIxTOlEcgKerk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745337549; c=relaxed/simple;
	bh=6g6P+lncrSfMbatvZ/nkKuTeMTkOrIf7RWB5lq1UYvQ=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=Y6dwlco1dv0asGfBKi/Px8oHGWBH9wAnqkcKc/6A7VW91m2XxGbY9oR4b96L4YvV1QviQ5yYauSWuNc9Y0wpUhR4nbfyZtyAbxVf7zv6qnbhybZ4dfrcSx6V4A2qkJddMcV0wJCNkkX33zyEx7OjGaU3PXUCGQio1GDH/i7Urts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=Czr3ZNj1; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6fead015247so47787707b3.2
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 08:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1745337544; x=1745942344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eTFqmwg1HHfrNWJwnHnBLGY5ZzBHrygQsPawXG0UQys=;
        b=Czr3ZNj1+1Z8ZyF3WUe55gM3UU9yAXGZBtJx2I/HVM2mkTsVHoNDYjxJ8y5RI5Va/R
         OGtSX8kGPp+AXzmrUSlhfCusTZB16dhemoKImWA5K5lDA1r4xDKNIvD9yEL1qkf+SSb1
         ExHDu8g/qabo+wIH3rp+ENNNRzeIQPSQPrm8GGWIZWxHrmlHc1pKfEXyS8lRnDbrP1al
         ZtRBHxS6BmnSgM7J7wcvSodYV3S/W4dKS/wqZPNYoJyCv9weiZdG455qwo2n/6ERotVZ
         0bb4YDhuz1dWOwTosvKmd/7c6nKXxD1QDIT+A9CR5Bi4l/mT1KwAFG51P6X//WkJ3mWt
         jAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745337544; x=1745942344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTFqmwg1HHfrNWJwnHnBLGY5ZzBHrygQsPawXG0UQys=;
        b=glAbRbHRshtv1WoL3eP4mLCY1rG5NopgigL7umO3RE5j4J7bqVOGa5QT+bBdJkapbF
         c8b2WqAgJmHBIaW8zRzPdQSdofMtqjxTHelLDcZBNDRSY02p8NXe85uh5Tab5cpJDuQ7
         tXB7RYUnhkq9cWmkK/lcvk2WGdt6hjQSRQF3eF3B+J/I8y4Ml8XwSVBYBOx7OjrJaDvp
         dT5iaWCoIKTi7LcrJ0jW2vTpexfGJ0N2Pt7Dg5pC2EkWRNLYnlGuSXGMdf9vEipVsyGf
         LfFDmrfnq7VefBXjcpZME0Az22rRsCh8A0e7D5mjatXHeUjA3OaohRyymLHxJlouWlEB
         r+cw==
X-Forwarded-Encrypted: i=1; AJvYcCVvZlzLYyE5Pn0ajRccO6Hg/gEX93a8nyg6bMpHBWpSD0nkhmAZgSKjIMVMZiqTIG+oIr/aJtI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy931fzY4BbeXE5tZWpoAOGUPX0ASn4Ohx7kfrS2TlfHycWenLH
	XCB2BYWoZhwqOG4iglnskks+dM5jpDbOSrsjV1bl6OuX7p2IW8EB259tMCeO70cQJz7igSKWIgw
	o4FXMVp85kKJxq+uyecB7EHa9/2LmHW3JZuWEEQ==
X-Gm-Gg: ASbGnctypnW8XAr+a33iiK/Dye4qgzkHGgvtzYzMPAPavJIvDM96f+oIRcf0rG08upD
	ykRyZGqCEeq0KLSQKJFQw/rw8zsEW9YZKJNGZ/BkCxYMlmg4B8Jn+Sa3S6gIrt3sm+ETepKOyPO
	Sl35VW9WfTS3iTdUDbqvyL
X-Google-Smtp-Source: AGHT+IF3rRQ2xnXX8TsW336hN/VBZL91Rfe2nR3dmM30ZJUazInNvYpJpI5RC1RS9MQzX99m5trT14Zs+QKVDNWEkQI=
X-Received: by 2002:a05:690c:48c1:b0:703:b8f4:5b07 with SMTP id
 00721157ae682-706ccde6248mr231134397b3.26.1745337544157; Tue, 22 Apr 2025
 08:59:04 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Apr 2025 08:59:03 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Apr 2025 08:59:03 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Tue, 22 Apr 2025 08:59:03 -0700
X-Gm-Features: ATxdqUF7M-7ZEvFNQ_WzmrX6LzsALlQmgI3HOlDJJhZz4Kx88j21etEY-3h6014
Message-ID: <CACo-S-0nw023h8STeS_OOEkAognnAoeD3hDJ=FrWpH014dB1Xw@mail.gmail.com>
Subject: =?UTF-8?B?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC02LjEyLnk6IChidWlsZCkgLi9pbmNsdQ==?=
	=?UTF-8?B?ZGUvbGludXgvYmxrZGV2Lmg6MTY2ODoyNDogZXJyb3I6IGZpZWxkIOKAmHJlcV9saXN04oCZIGhhcyBp?=
	=?UTF-8?B?bmNvLi4u?=
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

New build issue found on stable-rc/linux-6.12.y:

---
 ./include/linux/blkdev.h:1668:24: error: field =E2=80=98req_list=E2=80=99 =
has
incomplete type in init/main.o (init/main.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:cd168bc9c0a1dd7790c10e1a2ad1b=
0bac8ae366a
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
- commit HEAD:  98d0e5b8e62e87e5cdc3c131d5c8660e17e487a1


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
In file included from init/main.c:85:
./include/linux/blkdev.h:1668:24: error: field =E2=80=98req_list=E2=80=99 h=
as incomplete type
 1668 |         struct rq_list req_list;
      |                        ^~~~~~~~
  AR      drivers/clk/imx/built-in.a
  AR      drivers/clk/ingenic/built-in.a

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## tinyconfig on (i386):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:6807b01843948caad94dd153

## tinyconfig+kselftest on (x86_64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:6807b04243948caad94dd172


#kernelci issue maestro:cd168bc9c0a1dd7790c10e1a2ad1b0bac8ae366a

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

