Return-Path: <stable+bounces-144162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F979AB54C6
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 14:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B46B2465EA8
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 12:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A05222301;
	Tue, 13 May 2025 12:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyRTPFse"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2660B7483
	for <stable@vger.kernel.org>; Tue, 13 May 2025 12:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747139519; cv=none; b=Z51TiJam2xdau9dgyLeXZBZNJwnox0KsexL6Sfmo9nyNMEbd/WqANuYiTZnhsPcmOk0sp+XBnoqqNS2g5EbjuvpkW65jBfk1cXZX/TJIhqqr7VpH9idkdiR3s6wezX8hzKK5wJsrHCFbImOeqv553KtTnC0dnYVDM1LO25VFQU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747139519; c=relaxed/simple;
	bh=6XXYG/Ftc1pWUlNeO0jgG6PmF/Bg38MDHWb4XlaTxbA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=STobmxmAK5KI72RX91sYEt7Cs5WZxhpnQEa8wmxYMRPUrEBYmlxempTRdCQFE3YKvFx++tBT2MKl0RePrwEDARJKapk0uec45Wwkn2+5RXdIhlIIO9rpP9O3sNLyIhpnm2QYHmbPGshOcge/yDAxnLa7jRzatcXmJej93f3lzUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyRTPFse; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5f4d0da2d2cso10584486a12.3
        for <stable@vger.kernel.org>; Tue, 13 May 2025 05:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747139516; x=1747744316; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6XXYG/Ftc1pWUlNeO0jgG6PmF/Bg38MDHWb4XlaTxbA=;
        b=GyRTPFsetc4S99Y3rUGEx2nyNvRLm/59Zbs/qHdmwkf6U83tjy07/6+xN61yO5Z7hL
         eIi0WzEss1ZzxIPHPIrtZHPXhMAefV3CfavEGaiDA8lY3x4Jh6GQ8ypU1KwjTzZ/brwh
         kJIlPOZUO6/+voi6HVMltNByEDI+OVmmfBq0LsS5rgwp79ABrZktZ5urUufRbn7Fj7P7
         FEHPdUsduXMEQuMd0M3vzoYdpCskzSjT90Ixutx2I+g/e3iFKyT6fbjJye9Q4CVCTziS
         heR6FaTVPVbI46TtbDGfLV5hUqFXS1FhipOzgi4LPZwiZrLt14Xzn9kE+CwL/51Xn0+1
         nfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747139516; x=1747744316;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6XXYG/Ftc1pWUlNeO0jgG6PmF/Bg38MDHWb4XlaTxbA=;
        b=SAkhmIhKfMakfjY8OUO6Wfe2sY1LDdE26Ib8WeBFN/uzzVmsUkMaWzAKtrOAbRjyuH
         4NRce2ek6EPSUqZDMzs+8Xurnrw88jWNQzN+AKb2u/tDJ89XaQSH2QJo6wWy7Mx4jLJ7
         5U4l+yhpC++XtEhNMj9/3SXR0pIzdAe3N13rK6MntXROfN3UI/NBYcxUTuUbUetjHa6G
         wRm6to6nSMqqzTzDkah4Ocn5hQdQ86XuqjiQ2426olroBq+cVfKWKvfx0cDjBX30w8lw
         N9WFz6ybnGIS15oZMcLqnHKU0JHxRPtISqquA5otaNmEIviXH2LBv/H+5rTvuvt80eTd
         jFMg==
X-Gm-Message-State: AOJu0YxBd/PkNA1RTJkVmAU4HqfX9H1c75TWbFLa4DtvjEA2DuOQ65ct
	lEIueGkNxl3KLUOWw0L5hZVs1aBvrb2vybotoVblciID1qw9RKmglrPWX3ADyePvmEXgQ8B9cgf
	jOucCbykB6utd7PiyBLaYw1k2e++Dc7mnKHM=
X-Gm-Gg: ASbGncvxp+xePvj2l4qDUl9udXhL4PUEaomPOQbH0DiTYLwD7xzlkSjJAT9bzf2/K89
	FDU7xNyOtlms5HV2ymcNmZBPvEayjzAx+51XQQ0higZ5qXwjMZNR2oU3n73CHqM9aNC42xmoYmZ
	idbu3b3bdk0aMJAspJAKgQpvgSQmcrM4Rpwp+o/ZYG
X-Google-Smtp-Source: AGHT+IFN1DNEg07kYBsJruW4dDRndVwAYRV6XRquMQsdN4b81Da60tvCCePLKxjj/xBOC4iK9FwTlSF5RKykcb3QMBE=
X-Received: by 2002:a05:6402:1ed5:b0:5e7:8501:8c86 with SMTP id
 4fb4d7f45d1cf-5fca07eb370mr14954372a12.22.1747139515593; Tue, 13 May 2025
 05:31:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?0KHRgtCw0YEg0J3QuNGH0LjQv9C+0YDQvtCy0LjRhw==?= <stasn77@gmail.com>
Date: Tue, 13 May 2025 15:31:37 +0300
X-Gm-Features: AX0GCFsEwCK50RRlRBylstNHUZQABJ8BRC_w8MIYX-AMsHM7YgKHy-ZeOyEtgto
Message-ID: <CAH37n13FdWm9ZOFoaKs8LhfVRpqhnGskpy8MdbGEVJR8JbPyMg@mail.gmail.com>
Subject: Re: [PATCH 6.14 000/197] 6.14.7-rc1 review
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

With an unset CONFIG_CPU_MITIGATIONS, or more precisely with
CONFIG_MITIGATION_ITS,
I get a compilation error:

ld: arch/x86/net/bpf_jit_comp.o: in function `emit_indirect_jump':
bpf_jit_comp.c:(.text+0x8cb): undefined reference to
`__x86_indirect_its_thunk_array'
make[2]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
make[1]: *** [/usr/src/linux/Makefile:1182: vmlinux] Error 2
make: *** [Makefile:224: __sub-make] Error 2

