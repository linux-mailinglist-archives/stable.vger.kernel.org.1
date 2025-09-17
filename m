Return-Path: <stable+bounces-180277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 063F5B7EDF6
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 15:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C424A7B6E52
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 13:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D482332E755;
	Wed, 17 Sep 2025 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="CbpBsi6L"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED80232E737
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 12:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113947; cv=none; b=GLGDI9scD4WNLgwspNznEEG8/sR1hipsuVkIU4R1D/RkTLXSEEiGc6zLVlIgVpjMMSqMaw/0hCPiRHGo9SAdwpbQ41NdGgz88Gb9SRvur+4U9Np15bq1JjNinXyB0DVGnCCJqc2zA2MZ+GZN006X+EXSqmkH9oP8FPkLN7/dZdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113947; c=relaxed/simple;
	bh=Air/bp0B/kMxFdT5bSdyNaTpY9QsI75z3whDOdBy2iU=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=Kn0EFEgrFqfGfnW0Xrfy2CGR8D9uI6wvtYLQ2EgGmcvcduSg5Za3DVUTSII3wIx6uB0RoydEdd1d+ft/rujDAsC79RM0NZ3d31lK8HzhM5g3PQqmA8AD/kZqstboNgJogjcM3RNbpqi1A0e0qleckhwDVUXhKyuwWeAAv5eTkz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=CbpBsi6L; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-26060bcc5c8so44323755ad.1
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 05:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1758113945; x=1758718745; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJlDguzYhQST0flrPd7Kckb+lS7WHHs1Zm4hNS3XuIE=;
        b=CbpBsi6LezYPkSFKE/LeDFiIbDUyrXunS68hm4blMm8kHcxaUBLZ885UU79clHLg8E
         Ykkxh2rZLl+XJb8wC6g93ZKfOLs4+MxNTPS4KT/UHqTzwDX5GG6D51HF5c+Qjw/fTplM
         WJJ+gjqCxydrUOsR4kurnxpnYIeeXeBZxjU+/pQqwPE6VSKwocmoM9Cq8yzA+t2tq6gh
         W3AJBxP56OahrAS+jzRVWdnnJG5zD44f9ZglqdCwnCoOlvqMHah5gnuU9BTSgMAOJtOf
         HyFVlBKaW/67Tabmzxl9WP+cdnVyohfrH9EVswGb4y1ofsomLv+If1zW9pT+lIJSAlNe
         SrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758113945; x=1758718745;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zJlDguzYhQST0flrPd7Kckb+lS7WHHs1Zm4hNS3XuIE=;
        b=rrnSipIB/rDcDYUWdc9IwHXNRnOusH8s5D9gn5veXxji5kDiyMyf4QJx/QDIkzcqGt
         PsO0jMA987DPkZvDIFRiA4+pgKsWM0Mzc9iQLwren1q/l9hAwQd48Q0TrOZMOXUgyALo
         XltNAddaIHfOLxHLQBURj3qDj0E1FPgzJ/Eg/6kND1eGmE9yBZsSBnXTUZ81bQA9LQwZ
         2zplRw+6hA75jMYG2LR0xL1kmRI2/Nu6iJU9zdPGMxnmILiW67VpF83bU1G/XBLcI7wt
         j0+Y6XMWU7ynSYLGWR4odaUkygs4KdWmp7WekiQWG0doLDb5p3OT0w+2ZdgJQAFsYLP6
         Rn0g==
X-Forwarded-Encrypted: i=1; AJvYcCXiGwoy46EEXYwuJfT0vTwDq7Hzupjzbj4AfmJwqSVC5r6g9aRruLHP6G3uMPj20zYszkpCeQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5e2rAoMVmfHIz5NdXIZnV3SDYTHM5dmRLOt0Kz8+7LRJbOlXD
	Lmm4jZK19ARg5AoBPubHfVmN71EYhyjk9LZy9brF45YqnDvbh6S66lM05b2rm+AVEKLYY78A1WI
	IMtyc
X-Gm-Gg: ASbGnctznzJm0zV5GoXXFrhf/joxgcwA6eD+Axp1KzOhvvSAeL+Egv6NHiA6lxT9hWu
	LHxJpyQUVLa/9LWcVJ9inDT3Ka//+MaBIqP6YZ08E15KDQjwRuJzV3vj3VWg6WqeChYZSvMHDcu
	6dx4RLp9+uMMIwClTImWo6FCdrw/v4geINMP9gwB9m7/4CBDQzgh/INnTFojwelTdwZ8iRwjwh8
	/RJr/OLd1NPmML4GWf9u3DHabFf6mjaL9hQa5i8STFQ/D8mkWv+fyjX7TlrGtiYmsxLV/k235L2
	CCaVp+MrZCJzBMn8BxQ0jutTgDZUrT/2aqb4CVR/iQSALXcGZ5yh10iF03XosJ/5pAFPplsJsLM
	O+DM36Dj0cdAQC3EFyakzBru5e9k=
X-Google-Smtp-Source: AGHT+IFg9nl7CiAJEMuq0+SPK+NvNpcjg7lN4TC4sw3/v6kQ7WCj8GUHdKtFFwzvBCtMcYLqvwu6lg==
X-Received: by 2002:a17:903:183:b0:24d:64bc:1494 with SMTP id d9443c01a7336-26812169a13mr30543235ad.18.1758113945094;
        Wed, 17 Sep 2025 05:59:05 -0700 (PDT)
Received: from 325ff4dc0e06 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2623fd4d163sm123998765ad.80.2025.09.17.05.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 05:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.12.y: (build) stack frame size (2336)
 exceeds
 limit (2048) in 'curve25519_generi...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 17 Sep 2025 12:59:04 -0000
Message-ID: <175811394383.195.538224235436151216@325ff4dc0e06>





Hello,

New build issue found on stable-rc/linux-6.12.y:

---
 stack frame size (2336) exceeds limit (2048) in 'curve25519_generic' [-Werror,-Wframe-larger-than] in lib/crypto/curve25519-hacl64.o (lib/crypto/curve25519-hacl64.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:5256d3cef2bb7857d77cf7592fbc192694c82574
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  ad180b51566ec6fdcff4394cfe479231ace38992



Log excerpt:
=====================================================
lib/crypto/curve25519-hacl64.c:757:6: error: stack frame size (2336) exceeds limit (2048) in 'curve25519_generic' [-Werror,-Wframe-larger-than]
  757 | void curve25519_generic(u8 mypublic[CURVE25519_KEY_SIZE],
      |      ^
1 error generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig on (arm64):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:68ca878075b320799d28fdce


#kernelci issue maestro:5256d3cef2bb7857d77cf7592fbc192694c82574

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

