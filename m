Return-Path: <stable+bounces-169102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EACB23834
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3981895657
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D1B29BD9D;
	Tue, 12 Aug 2025 19:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vL8VRA4E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341FE21ABD0;
	Tue, 12 Aug 2025 19:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026386; cv=none; b=Mey5LrsDXWioxZm3ma3i6NJ/pSKTXLirvKvBDSMi4Q6DL0Xyv2zpsP2kMJMMOuMavNftw2hbQvQSEw7JIvmgCeHIRE1Oaz2Sp3S8g436h/GIWdoTLt9Ps3cAhQz5rJDK21HjNDnAxGq9VG8OIdcRgW2/gXzqrsK7fFprSNjj0O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026386; c=relaxed/simple;
	bh=evoMumdN9Ra4+I7GFta1N9b/p+xpFdsB9d2Jmta08o0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qeIPpBMW7cN0+l/gs/LsNFnVaELKOtpJ3Ivy4UaiiKGAEEkZPhTva/x2ERxRXirCqh5RrOUS2j55hlC9uq2czmpiIAQlasIXd/DmvW5woUluye/zH2G9rMq6NP58dvAKFmbIqtqoJj8AuCohEqQPoDQEOkEpa5elAiG/fnelquA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vL8VRA4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497FCC4CEF0;
	Tue, 12 Aug 2025 19:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755026384;
	bh=evoMumdN9Ra4+I7GFta1N9b/p+xpFdsB9d2Jmta08o0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vL8VRA4EicaM8d4dA+j5Qn4x9mtwJV1nagfd+dGRVsAvX+k/Aqn2jBSxMB/wDGGun
	 7FKKQalfvoV2wdLwe0tw0rrejRv1j4ASECzp4a7HPnhgtN+yQdFh8/LxJSJp9H++FK
	 oqsVDPE72cKxffoQq9RYazVyziFtUKEdrX3Uizjc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jun Zhan <zhanjun@uniontech.com>,
	WangYuli <wangyuli@uniontech.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 321/480] selftests: ALSA: fix memory leak in utimer test
Date: Tue, 12 Aug 2025 19:48:49 +0200
Message-ID: <20250812174410.678619620@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: WangYuli <wangyuli@uniontech.com>

[ Upstream commit 6260da046819b7bda828bacae148fc8856fdebd7 ]

Free the malloc'd buffer in TEST_F(timer_f, utimer) to prevent
memory leak.

Fixes: 1026392d10af ("selftests: ALSA: Cover userspace-driven timers with test")
Reported-by: Jun Zhan <zhanjun@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
Link: https://patch.msgid.link/DE4D931FCF54F3DB+20250731100222.65748-1-wangyuli@uniontech.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/alsa/utimer-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/alsa/utimer-test.c b/tools/testing/selftests/alsa/utimer-test.c
index 32ee3ce57721..37964f311a33 100644
--- a/tools/testing/selftests/alsa/utimer-test.c
+++ b/tools/testing/selftests/alsa/utimer-test.c
@@ -135,6 +135,7 @@ TEST_F(timer_f, utimer) {
 	pthread_join(ticking_thread, NULL);
 	ASSERT_EQ(total_ticks, TICKS_COUNT);
 	pclose(rfp);
+	free(buf);
 }
 
 TEST(wrong_timers_test) {
-- 
2.39.5




