Return-Path: <stable+bounces-52413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7097F90AF6D
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 15:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FF761C24024
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 13:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65331AC423;
	Mon, 17 Jun 2024 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qc4fURfF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616E01AC234;
	Mon, 17 Jun 2024 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630511; cv=none; b=iv9hKM/uyq4d21DOmRxkH5dUoV2s2RHPkZxF7rKUD+dC/2g5LOu9DEhesQXuGD37OkHdobnLI3pCx4wHkhhuRzBoFxrwKX9pJSGIP6xunKQOJgYgI//taq0jRSGyPEdt5dzli/Dc+OmAwpqn64cuxIYMk3/Nne632D29FpWIzFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630511; c=relaxed/simple;
	bh=qO1jR9fw2QLVSsRBqloYLaKnhU/7rxY1avhNaHxskmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TFsPZHa5S1kSrU9YIV0ICIJDUol5dat1mZnWWr9Kbu8s6WKnYbZgTxVcwSRf1GdTBbTQXxg8WM42vrICS0Xp6Ui/tfaquywdquB+Eqj14lV/4K0A0+k7EVtPNLg66VNDNvx067yyXB6sZzCy/Vov7urKGKIu4wprx1DSS7JK1Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qc4fURfF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76ADC4AF1D;
	Mon, 17 Jun 2024 13:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630510;
	bh=qO1jR9fw2QLVSsRBqloYLaKnhU/7rxY1avhNaHxskmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qc4fURfFWr2DBKsSY15W+wGoR1CZi040dwVTsqYo3SMZVqAhnGRy6YbUtkFqT0VTV
	 clNu8RDU+9J9N5scULd8iWu17g0ycBXwyDY9zWygpK1uSnOO+g8VOuNloWb3qu3+aH
	 2q0RyQN3p/eMaL/mmrrEl2aUYdO+hbfcThZ83KQrknGYQkQ4jWEGGZrhTpYWqtojhj
	 IeWtOUvn1afLl0A7uqoXHfZmD3XPUK9boN80P1qA9C97Wa7lfKa2Je3K1aoUxqhGmC
	 dQ3vUc8xkIPgR6328AKaVLtRs0FiM2Bg78YyFWdr87JbqzY6lseMEut9mqRbpAoB1H
	 CkxTaJcm3b8RQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	maciej.wieczor-retman@intel.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 26/44] selftests/openat2: Fix build warnings on ppc64
Date: Mon, 17 Jun 2024 09:19:39 -0400
Message-ID: <20240617132046.2587008-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132046.2587008-1-sashal@kernel.org>
References: <20240617132046.2587008-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.5
Content-Transfer-Encoding: 8bit

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 84b6df4c49a1cc2854a16937acd5fd3e6315d083 ]

Fix warnings like:

  openat2_test.c: In function ‘test_openat2_flags’:
  openat2_test.c:303:73: warning: format ‘%llX’ expects argument of type
  ‘long long unsigned int’, but argument 5 has type ‘__u64’ {aka ‘long
  unsigned int’} [-Wformat=]

By switching to unsigned long long for u64 for ppc64 builds.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/openat2/openat2_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index 9024754530b23..5790ab446527f 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -5,6 +5,7 @@
  */
 
 #define _GNU_SOURCE
+#define __SANE_USERSPACE_TYPES__ // Use ll64
 #include <fcntl.h>
 #include <sched.h>
 #include <sys/stat.h>
-- 
2.43.0


