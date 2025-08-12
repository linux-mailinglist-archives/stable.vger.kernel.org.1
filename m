Return-Path: <stable+bounces-168584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A60B23587
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17E58165BF5
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0352FDC55;
	Tue, 12 Aug 2025 18:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EjZJ+bCW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACBE2C21F6;
	Tue, 12 Aug 2025 18:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755024659; cv=none; b=n5CFfAQV0hfCvhj4yCnshElb/LzZbnzovbEXeHXwj1G42d2PorEw0ia2skOhlr22m/L6tMNa/0qogwSCUyYqCbIUvFsZVLocP+kr26D9gxg+pSA/GXU4sRbtu9iM2O3XfLyiG96QUNSOqIPbYaCDUF6kBQvDrjut1eM2t1sqqX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755024659; c=relaxed/simple;
	bh=Vy1HTy64W+Wgv8hOaSQqCXSOtDgWREaYq6hKQIA2hso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWb+Faa4+8xcwHLhjxXzq4LR68Tyxy0ApKmvfqLxT+TMYunAA73I8tv0TUtlqQEP1eRr+GOGsp7mvROJ819a67s4qLba6txupot58oBGjHthdv9BHciwXCB3JKX6EOi2hyRp/oyhHKu5NghUARckD4q/xU2OgZEniPGREK6gg/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EjZJ+bCW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC58C4CEF0;
	Tue, 12 Aug 2025 18:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755024659;
	bh=Vy1HTy64W+Wgv8hOaSQqCXSOtDgWREaYq6hKQIA2hso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EjZJ+bCWv+Df4ByefsPh4S/5EEy0KseGGMRQFNKamjVisKqfRC+9WYdoSK85V/C28
	 6aMC3otPqqk9wFtn0FTzdf5IDiA9r5uRS7yqr/yCRLZ7HLDPMYAn4VI2Jt9d3c4s0c
	 UTQMHPiCGDxxH8iwbqZ6JT54R3XaNu/UcPQTvgzw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jun Zhan <zhanjun@uniontech.com>,
	WangYuli <wangyuli@uniontech.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 438/627] selftests: ALSA: fix memory leak in utimer test
Date: Tue, 12 Aug 2025 19:32:13 +0200
Message-ID: <20250812173435.940168171@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

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




