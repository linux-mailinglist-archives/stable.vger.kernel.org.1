Return-Path: <stable+bounces-105278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3C29F745F
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 06:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A172188407E
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 05:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4F01F9A8E;
	Thu, 19 Dec 2024 05:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="i/YCQhw2"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4629F216E19
	for <stable@vger.kernel.org>; Thu, 19 Dec 2024 05:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734587557; cv=none; b=ZB2uGDaPGlxin3Fr6FFI21/3QZfVNjrKuJlERr0sl5rXEYpCaw/nZ89shrqJuaK4b41aByEFch2oRmn1Tzj74++rmB5gMJ2mF9n0bBYbiTDsGY4uu6fne2L4a2koJ3S3KTtxJmCr2r7IuSLKlhnDt2PGP1IpYWcwbXTc3Deh5Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734587557; c=relaxed/simple;
	bh=PcsHpbw2iRl7hzJbYfxa4xh9iaKZ2UqxD46/DdqS1Y0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BSVUmiQg+a94glgHvLmmy5RYM07R+AqogdwCCRLtO/Od2RxFn/Y8RKiKJ50pBhlm+KoLEUbdINSFSuZdOTgi9Xi4UBFWtC5Ifxny8VJ7i6a+JpqELBm4IqnVc+mqAUAzFVSkzWV+o8XhTQzBwesL6lIgkksoq0URep4WEPZk7q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=i/YCQhw2; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=3fYHU
	JK/X9zmh7/ofn/DAWwjn0T5Lt8H3ahexSyFGxg=; b=i/YCQhw2zIcSBy0A1veOm
	HDG2+fPo7vpae9gtvHdv1z5nM6KUXC+AdVW6BiV0vBMm45BtX2sF0To0yBPD4Kcd
	RxSg/qm1koc7N8D6wyqWX0p//4r9Ve1fTjjEUuLZaaWTbAECg6id+H6qnGzsJRYm
	HVDmP/O1T69hoi+PfJ3E4o=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDnf4V_tGNnnOLAAA--.23132S2;
	Thu, 19 Dec 2024 13:51:59 +0800 (CST)
From: ccc194101@163.com
To: jpoimboe@kernel.org
Cc: peterz@infradead.org,
	stable@vger.kernel.org,
	chenchangcheng <ccc194101@163.com>,
	chenchangcheng <chenchangcheng@kylinos.cn>
Subject: [PATCH] objtool: add bch2_trans_unlocked_error to bcachefs noreturns.
Date: Thu, 19 Dec 2024 13:51:57 +0800
Message-Id: <20241219055157.2754232-1-ccc194101@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241218212707.zjli7be5qtamdfkx@jpoimboe>
References: <20241218212707.zjli7be5qtamdfkx@jpoimboe>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnf4V_tGNnnOLAAA--.23132S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF4rXr1DZF15urWxCw1UGFg_yoW8Xw48p3
	47CrZFkr1kW34xAw1DtrWa9ay8Aa13Xw109F1kWFn8urZrX3WxJrWayw1rKFWDXw45ur43
	Ar1jva98CryFvaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pErgAUUUUUU=
X-CM-SenderInfo: 5fffimiurqiqqrwthudrp/1tbiVgu63mdjrmWRiQAAsu

From: chenchangcheng <ccc194101@163.com>

fix the following objtool warning during build time:
    fs/bcachefs/btree_trans_commit.o: warning: objtool: bch2_trans_commit_write_locked.isra.0() falls through to next function do_bch2_trans_commit.isra.0()
    fs/bcachefs/btree_trans_commit.o: warning: objtool: .text: unexpected end of section
......
    fs/bcachefs/btree_update.o: warning: objtool: bch2_trans_update_get_key_cache() falls through to next function flush_new_cached_update()
    fs/bcachefs/btree_update.o: warning: objtool: flush_new_cached_update() falls through to next function bch2_trans_update_by_path()

Fixes: fd104e2967b7 ("bcachefs: bch2_trans_verify_not_unlocked()")
Signed-off-by: chenchangcheng <chenchangcheng@kylinos.cn>
---
 tools/objtool/noreturns.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
index f37614cc2c1b..b2174894f9f7 100644
--- a/tools/objtool/noreturns.h
+++ b/tools/objtool/noreturns.h
@@ -19,6 +19,7 @@ NORETURN(__x64_sys_exit_group)
 NORETURN(arch_cpu_idle_dead)
 NORETURN(bch2_trans_in_restart_error)
 NORETURN(bch2_trans_restart_error)
+NORETURN(bch2_trans_unlocked_error)
 NORETURN(cpu_bringup_and_idle)
 NORETURN(cpu_startup_entry)
 NORETURN(do_exit)

base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
-- 
2.25.1

hello,

You can use this new version to add fixes and modify the signed email address.

--
Changcheng Chen



