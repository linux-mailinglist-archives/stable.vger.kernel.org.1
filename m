Return-Path: <stable+bounces-200308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D575BCABD8E
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 03:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1BD2300307D
	for <lists+stable@lfdr.de>; Mon,  8 Dec 2025 02:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C940C2727EE;
	Mon,  8 Dec 2025 02:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="g6SW5mdS"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D031B273D7B
	for <stable@vger.kernel.org>; Mon,  8 Dec 2025 02:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765161023; cv=none; b=VT64trBNjQ9lKZInv/gOJwkiU7HDzxb1RKdQiw0ZRUjjH7ofr0KjWkgEon2yr4swS+aTTngF16A99nRLBVuGiV3gNINUVQ80HiOEEYkhpqSPw8MdNVatHlK8Fal6VhEL8PkvYInCP/iM9cnLE9rj34EX9rbUE6kRE/dKUf/M2j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765161023; c=relaxed/simple;
	bh=6CqgjwC4bPr9JUvEaAE3p9CnoWXL5XqgDGyb/fddABo=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=R8C1ndjUAuXdl/JmBV8GtmS7jOBlSThAS7rZ57AD7UgCzyaoieLz53LYpDLYMvWsgCcsFzaod85nN08ucP3smmXmoUJD2xAQyzxhwX3Z95lzCXSE9Ac6Jv16ZZlNA5xj06VVw3c6k0A4a4t9kEYLYZz04LBFUlOStIddCI46QCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=g6SW5mdS; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-11beb0a7bd6so5634711c88.1
        for <stable@vger.kernel.org>; Sun, 07 Dec 2025 18:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1765161021; x=1765765821; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9kn1ZlCMSo4p8ZGFQUA34lx/TS0Brfm3ztrgNWCsYI=;
        b=g6SW5mdSveSD0EvJB9I0blK8xNo5SKQIvtJWL09vM88KS8S6657XABzr/aLl+YFjVv
         Vo4KXOufkHXMIet3OYavotT2PeuUVezpFQEEAuqmTo9uocY4XUV1+At3Bp8D+UlrL5GG
         ezzEkni/o9Iu1+e5AU0Jk5p0xmliSJ29M4s4rFMQGgfz+V1u8ZdHbckecfBseLexeXTP
         WV/r5NTjz6GdgBqaBW45fp6FmYF2Mve4qk9ptc8SQHWFQr06p86wpprvt51BasV/HB8/
         YPZG9GBrwjefofaACzclyfjgcbV39lgq+d15ERWmbLt+YYx8/1upALHYRgMQFV32p8C8
         jLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765161021; x=1765765821;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v9kn1ZlCMSo4p8ZGFQUA34lx/TS0Brfm3ztrgNWCsYI=;
        b=cMBvPrhQwpGbmQbAcnXoou06f0lDb8MrXZ4soajnGwJj8asHSQgQzf6187B3HToQS/
         PMJFTbhgQGuVH2FrhOhJQzotJqbhp++JYUBs7Pr2R3ugz7iWznN9QwtWWOTN+J7AMGX4
         HXWOp0NYQx4ErEJ5ZYH78b/q0jD0CESEZnlar3R30sELkSFUDxVCwlZvoydiqeWvhinw
         ApHSZZrF+Q1WicnVCd8ppAZAkTDzYcWr2It+QembNGCOCQmUOt+kBF35EVJ1mQQfoLTX
         KGQChQJ7XDf09xGodvFhmny5L77H4M/jOYCTNtvrqZxCVcnqaoBAoLRV53fqD0SW75G4
         E2Ig==
X-Gm-Message-State: AOJu0YzPOxrAe8yLhvZ5bBurgVYCGhfF12wAbuhE9ahwE0qWO6ke2cWt
	4n40VuZq3TTbrneqeaZLp8nuhFDouN4ORL8iwDN7TuCtPK7qhahs3p3U8UJuKw8NrpE=
X-Gm-Gg: ASbGnctfUJhRoMUbzphdtriKNBOiA36gc6GEimurcJidHiKQG26qhOQLZep7pQIxxGA
	vyEDfPfidKp1HQp5ehR5VIpukxycvcJXd+5F1OWEnCUL242uhQPSP51zFAqMAKxi9KLz+DcegYL
	BJoT5CvUbtqCy5QhbRzvERTJx5Xs16WcU48lxa5izjIDMOYHzSFNtlL7eCJDG0eP5zR8L9MDiBG
	QrHSe3jNGYg2gjIDbxm9Q1cvLdYNthPGVtxADLAsI9w8JuAwlp1bEulr3JEcBHl0vtZgffGTNYH
	4TWO65/r1GT2+8rzDagxMJx+I30J77hHUc/u6BQGTh8CcmDJe3Jp7hMXVd98/eCenDJ78CQrodP
	LeaYsuwMMV4+0FOXQ0039llXQVFItpTZooTyhaREApCkVHXMHC+qnOwDNRYi/qfaw/+0HTZaRmq
	hRWrqg
X-Google-Smtp-Source: AGHT+IGx4sbIx/l1jRZpzVeYRsNKyLJ8OF3NLS5PAZTrtMCSWQEomF+cSWr1zBxn/8gNoN37WcT03Q==
X-Received: by 2002:a05:7022:252b:b0:11e:3e9:3e93 with SMTP id a92af1059eb24-11e03e94492mr4260684c88.24.1765161020704;
        Sun, 07 Dec 2025 18:30:20 -0800 (PST)
Received: from 1ece3ece63ba ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2f3csm45817151c88.5.2025.12.07.18.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 18:30:20 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-5.15.y -
 68efe5a6c16a05391e3d96025b41e9bf573f968c
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 08 Dec 2025 02:30:20 -0000
Message-ID: <176516101970.6076.18148124085309524122@1ece3ece63ba>





Hello,

Status summary for stable/linux-5.15.y

Dashboard:
https://d.kernelci.org/c/stable/linux-5.15.y/68efe5a6c16a05391e3d96025b41e9bf573f968c/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-5.15.y
commit hash: 68efe5a6c16a05391e3d96025b41e9bf573f968c
origin: maestro
test start time: 2025-12-06 22:05:23.274000+00:00

Builds:	   34 ✅    4 ❌    0 ⚠️
Boots: 	   45 ✅    0 ❌    0 ⚠️
Tests: 	  855 ✅  252 ❌  887 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS
    
Hardware: beaglebone-black
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - ltp
      last run: https://d.kernelci.org/test/maestro:6934ae5d1ca5bf9d0fd6352c
      history:  > ❌  > ❌  > ❌  > ✅  > ✅  
            


### UNSTABLE TESTS

  No unstable tests observed.



This branch has 4 pre-existing build issues. See details in the dashboard.

Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

