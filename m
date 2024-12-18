Return-Path: <stable+bounces-105137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A699F60EC
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 10:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B320E16D5EF
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 09:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7BE195385;
	Wed, 18 Dec 2024 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZuWKTVPt"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C50194C75
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 09:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734512734; cv=none; b=eDmWv4mtSRbIBak9Dia/w863Uv6CrINkPBSrjcFn6+pIkIdDxFcxZWL28ke8c5tGv7dke1vhopGzjz4sk6BNS64uNlHOQZ4QZKdHQk/xT24FkTA6KetXkSm4d21QGeJ5kSxGR5V1dhAvVFOsMjcvgaCn/OwrB+g4SZr3aNxc8/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734512734; c=relaxed/simple;
	bh=cHOJ/6fRxoQQzMnx7YtPy3f8RlWmV98rJKBi4N0O37Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WnufLhIRa6zZVCEtdv1XlTG+GVEabSdBMJEmFbpOjNKfDDDhTzKKwe8q7BE0QATctrIAHvpSaRd1b1Yr7YlA6EWw7XcQ4QLAWM7fDcNgDFB+q4QWqmf5FvN5cIMLwkG9y4Hog5x/to1UPx5dxc7J/uojL/GMRJAiCUSK4SQ2/Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZuWKTVPt; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=i8Lbn
	ITrlkUK92cY0k8tKLgWN0Y0AOrxlbJBc28HtvM=; b=ZuWKTVPtFZMZEhbi6hXpR
	OCELm1dUiiJJSdGH5j6F6gBN9PO0JCMP81wF3yDCxCC1mg+m1EfwjJK6Sx7mSbZB
	D8Ryeu5za1/Z0T72Q9/WLnNIrsYt7PK1NYnF1OKrEP5TV6rNJAmuF3zLydDK1hYV
	LDrFs7ljC1fhXTkgZbPzdo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wBHU4ZFkGJnCvJhBQ--.49247S2;
	Wed, 18 Dec 2024 17:05:09 +0800 (CST)
From: chenchangcheng <ccc194101@163.com>
To: jpoimboe@kernel.org,
	peterz@infradead.org
Cc: stable@vger.kernel.org,
	chenchangcheng <ccc194101@163.com>
Subject: [PATCH] objtool: add bch2_trans_unlocked_error to bcachefs noreturns.
Date: Wed, 18 Dec 2024 17:05:07 +0800
Message-Id: <20241218090507.289846-1-ccc194101@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHU4ZFkGJnCvJhBQ--.49247S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrWfXr17Cr13ZF4UAw1xuFg_yoWkKwc_XF
	1xX3WxJwsIqF47tr1DXFna9w47KFyFyrs3Jw4UCa4fWF15CF4UuFnrJrZ5Cr15KryfGF9r
	Gr4avr1xXrsrCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_4rW5UUUUU==
X-CM-SenderInfo: 5fffimiurqiqqrwthudrp/1tbiVhm53mdiiJzIaAAAsZ

fs/bcachefs/btree_trans_commit.o: warning: objtool: bch2_trans_commit_write_locked.isra.0() falls through to next function do_bch2_trans_commit.isra.0()
fs/bcachefs/btree_trans_commit.o: warning: objtool: .text: unexpected end of section
......
fs/bcachefs/btree_update.o: warning: objtool: bch2_trans_update_get_key_cache() falls through to next function flush_new_cached_update()
fs/bcachefs/btree_update.o: warning: objtool: flush_new_cached_update() falls through to next function bch2_trans_update_by_path()

Signed-off-by: chenchangcheng <ccc194101@163.com>
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
-- 
2.25.1


