Return-Path: <stable+bounces-172468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFB1B32099
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 18:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55FD77B489F
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1A6304BBF;
	Fri, 22 Aug 2025 16:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhliOF1J"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198462853F8;
	Fri, 22 Aug 2025 16:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755880541; cv=none; b=dS3WSvXJpPL0D++yn7pw2ZqFz3UstxlTz1fUOyPnh+usvJ2ByiP8cGBdmRh/vrPL1uEvpG8jNxUSTHTx0cZEMi88hAiTA8BXiPi1AumzxTQfC3xyMw31m6+aMp/X0N4Stutzmgv9Mr1kW9U4EOwDNG81TQmln3lQRI4Rc3B0IZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755880541; c=relaxed/simple;
	bh=wmzL8WhEl7OoUCt6gCCzTFu2FcX/5HDAySlZEShwT4I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=icbhpjfFLQL9I0hA2V6ta5y1RrG6yctoFEFpBC8ZA+XUgOT4aovWjLDtR8yVPka1qDD5Km8c4L7VArBWl3/HVXaTfhZfAhNTUOngsxWnKDjhMooscBVmh161i6jGVEhmAqClluRYdjep0rTB9En9vICAMf/1cqP3GqDBpsiEai0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhliOF1J; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-770305d333aso948112b3a.0;
        Fri, 22 Aug 2025 09:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755880534; x=1756485334; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wmzL8WhEl7OoUCt6gCCzTFu2FcX/5HDAySlZEShwT4I=;
        b=KhliOF1JmcrYP+aZ8uVltTnrvGwDEE/g4I3mlGrhSISOkyimL+Qccc9eibnrEZouVs
         zdXVDSL+gv3b1CAIJWLqKbJt/qrxpOVnw0SpTdoAl96dc8OsmWnaSlBTp2SKksZZXn+P
         r1ejrzsDEUZ7Ly5wuDfix4KzNHWiJ/Z1aPZmGQwVwqffzSRJEOnldLRuug1BrSLXXGEa
         9TriaMV/ij/8d/nq3bkMGkLbFfh+bEKU8kS+0fOR1y4jY0EbTcvoabpLkve7jmRDheli
         1z+HTi1ClCMRXKH3TA7S6/ZHvxmEd6LqBWh5u/42+iRJjifGbrNrG4QNHiLkokv3puaq
         9mIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755880534; x=1756485334;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wmzL8WhEl7OoUCt6gCCzTFu2FcX/5HDAySlZEShwT4I=;
        b=pzHM4ecuMlLrWfmBEYPcZ30cbKwdn9xZjoJoE0oyGMlMcSdN6997jq+ZipOIaoAHi0
         ojRVXyFSl5Dgs9magYDoHB5yKfAnvuI21pfWHpi9rnizX6r+hkDu00JM4mzUFo2JJ5fm
         rVnUZ2NGqwxgIGhnZis0HPYQdQy8KFAujXCfhOBz5KWWGaRpLytk0mt4wKA0E0b3ohBG
         nsgWGtwVF/d0A0wsreKX4ei4OObZqqGAYtuvHsa9NCWplEoOpNAdRYlFt/fBJBrwa0Un
         1gtmzt2n9YWxTn68oE3tgBUsuETMobmS0j+UG7pW/jkFk7d/mVN3GZiKMYwOWXI02Edo
         z5zg==
X-Forwarded-Encrypted: i=1; AJvYcCUclZ4QS1N92x7Px8h2EyjLC3w2uoHx0HQUGDOLOgpaXcs6TmGNHiRNGzYSdj6x5LDv1r7qjKAw@vger.kernel.org, AJvYcCVZ19Rc4ehJeW1l7KsL8pe3UBrB73e3bIyw+CpI5BIbPzE0MrUeaeNFuBj4jU87/sh7Bi3F07Gzgttj/GQ=@vger.kernel.org, AJvYcCXIhWbpP1h40GmSBDwzZ15DRLr+a0S9dIT18OZucEi0fvXCXR28iSlh17OKSX27NS2zruBWvCTm@vger.kernel.org
X-Gm-Message-State: AOJu0YxlBdA35SoTDETNiQ2Gbdh96P+JlUvwCf+HSVIsp0wx9LXQSY8n
	OiOxQsU9b6kl7AF7+AE2Hem+8k4IO6f+42+NKzZgYhdzWR0Ht0MjPLxIASO+55G2ewYodnVjUlf
	xMh2A9VTACoktnEt2syWbLGLJAVvYNw==
X-Gm-Gg: ASbGncsv4iBOocShPXfN1USPK1kmHovMxysk2mh3RppNyAZyh4VXJQBxt60SF0DmVN3
	GLdN2N2hf6F7LVvZDB8Nj8tauMcqXx/YryN3JjaWDaaFup/sM/ZfGMkKDf6mXdRty4FbYCRdAAC
	NNKVKUByk9ZJDeCOX5J8Oe/pNcLCqDxyAW81rVZiyuNzQNd8GhhH1yZvyh39HfPFYZvoM0y3Wo2
	AEPK+fC0aIR3z08h6cL8eFty/pmfPn/J0Jw721UZHs3cmIman34gdOQphcTAODKEUaRq6fnXLgA
	zM1xCoJBYV/vTfHrcZt2
X-Google-Smtp-Source: AGHT+IHTDq1oeNBYpM1bw8gGhdGoQ7e0NTteeJjpTzVATWPWK+u5h4kRpsn/uFF5bNXy7VxhaDie626knu1nQQws00E=
X-Received: by 2002:a05:6a20:3d06:b0:240:1c36:79a2 with SMTP id
 adf61e73a8af0-24340b01a3emr5979726637.10.1755880534264; Fri, 22 Aug 2025
 09:35:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rui Salvaterra <rsalvaterra@gmail.com>
Date: Fri, 22 Aug 2025 17:35:22 +0100
X-Gm-Features: Ac12FXxOAJwfk6e6i3lw8xuT8N1nK7SDe6oUIjfCp20HUbSIh_3_NqPV8J5QaGY
Message-ID: <CALjTZvZkDr8N18ocZ8jNND_4DwKqr-PV4BBXB60+=WXPF3vn=Q@mail.gmail.com>
Subject: [REGRESSION, BISECTED] IPv6 RA is broken with Linux 6.12.42+
To: wangzijie1@honor.com, gregkh@linuxfoundation.org
Cc: adobriyan@gmail.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	openwrt-devel@lists.openwrt.org
Content-Type: text/plain; charset="UTF-8"

Hi, everyone,


We noticed a regression in OpenWrt, with IPv6, which causes a router's
client devices to stop receiving the IPv6 default route. I have
bisected it down to (rather surprisingly)
fc1072d934f687e1221d685cf1a49a5068318f34 ("proc: use the same
treatment to check proc_lseek as ones for proc_read_iter et.al").
Reverting the aforementioned commit fixes the issue, of course.

Git bisect log follows:

git bisect start
# status: waiting for both good and bad commits
# bad: [880e4ff5d6c8dc6b660f163a0e9b68b898cc6310] Linux 6.12.42
git bisect bad 880e4ff5d6c8dc6b660f163a0e9b68b898cc6310
# status: waiting for good commit(s), bad commit known
# good: [8f5ff9784f3262e6e85c68d86f8b7931827f2983] Linux 6.12.41
git bisect good 8f5ff9784f3262e6e85c68d86f8b7931827f2983
# good: [dab173bae3303f074f063750a8dead2550d8c782] RDMA/hns: Fix
double destruction of rsv_qp
git bisect good dab173bae3303f074f063750a8dead2550d8c782
# bad: [11fa01706a4f60e759fbee7c53095ff22eaf1595] PCI: pnv_php: Work
around switches with broken presence detection
git bisect bad 11fa01706a4f60e759fbee7c53095ff22eaf1595
# bad: [966460bace9e1dd8609c9d44cf4509844daea8bb] perf record: Cache
build-ID of hit DSOs only
git bisect bad 966460bace9e1dd8609c9d44cf4509844daea8bb
# bad: [f63bd615e58f43dbe4b2e4c3f3ffa0bfb7766007] hwrng: mtk - handle
devm_pm_runtime_enable errors
git bisect bad f63bd615e58f43dbe4b2e4c3f3ffa0bfb7766007
# bad: [9ea3f6b9a67be3476e331ce51cac316c2614a564] pinmux: fix race
causing mux_owner NULL with active mux_usecount
git bisect bad 9ea3f6b9a67be3476e331ce51cac316c2614a564
# good: [1209e33fe3afb6d9e543f963d41b30cfc04538ff] RDMA/hns: Get
message length of ack_req from FW
git bisect good 1209e33fe3afb6d9e543f963d41b30cfc04538ff
# good: [5f3c0301540bc27e74abbfbe31571e017957251b] RDMA/hns: Fix
-Wframe-larger-than issue
git bisect good 5f3c0301540bc27e74abbfbe31571e017957251b
# bad: [fc1072d934f687e1221d685cf1a49a5068318f34] proc: use the same
treatment to check proc_lseek as ones for proc_read_iter et.al
git bisect bad fc1072d934f687e1221d685cf1a49a5068318f34
# good: [ec437d0159681bbdb1cf1f26759d12e9650bffca] kernel: trace:
preemptirq_delay_test: use offstack cpu mask
git bisect good ec437d0159681bbdb1cf1f26759d12e9650bffca
# first bad commit: [fc1072d934f687e1221d685cf1a49a5068318f34] proc:
use the same treatment to check proc_lseek as ones for proc_read_iter
et.al

Please let me know if you need any additional information.


Kind regards,

Rui Salvaterra

