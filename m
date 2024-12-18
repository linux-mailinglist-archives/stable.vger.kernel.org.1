Return-Path: <stable+bounces-105136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2269F60AB
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 10:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18C841638A4
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 09:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1064194AFB;
	Wed, 18 Dec 2024 09:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KOe9tYV/"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63E4194A64
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 09:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734512639; cv=none; b=N+baly2WzcQI1SqgAVqV1qKZ+Iit0sen5g1XlwgnmyoPgK1cWsnQvXA5ScszXojrwb9y1PyIGfahhgwNuQQL5tu/ZAOAURQtP7pPQTm4F9xi7YhhcAxy/CGRClR5NowzjEQU188XGtJ8sjlHmQQLnx9ktsPCIWxZgq5KBwoaE4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734512639; c=relaxed/simple;
	bh=Rl4QdMpOjgNSJ31zK02r8oy3nxl9qBSUjgatMc8k+/k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ElqExLKcpzyBr0lskhXwQcF60gR0bunkiz4dCJErXeCq2hsMqEiJ1yVkJ1iCRZ5B21+1zIWRx05FCsuH1oSaLllKICNQ4pQJ4lx4fYSvnKp9PGjdrFSEiSc4GUtLvVHEI82nDE2bpfBGsTYT7TGqBDf64QcxCWjacxnw9sFZAVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KOe9tYV/; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=amYQm
	jEexAm3BmwH2uhgUEFmsgH7M88zgBV/47MgQ4g=; b=KOe9tYV/BkX6wfTsi0PrG
	pPCAG1qycPu+8a5yR6qyzOS+CORrPV2YGJ3bnEcPu/TaiBxf3kJ9IHa2LiRhyHmU
	Tp9AxGWXelhkAa8TVt27pqKsPX+MoiIX1Ip3/+zP/UPJRLuxBGmqKqQFt6FFOIPu
	gfqP8XPVSOM7iifEqM9pus=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3H6bUj2JnekSVBQ--.9682S2;
	Wed, 18 Dec 2024 17:03:17 +0800 (CST)
From: chenchangcheng <ccc194101@163.com>
To: jpoimboe@kernel.org,
	peterz@infradead.org
Cc: stable@vger.kernel.org,
	chenchangcheng <ccc194101@163.com>
Subject: [PATCH] objtool: add bch2_trans_unlocked_error to bcachefs noreturns.
Date: Wed, 18 Dec 2024 17:03:09 +0800
Message-Id: <20241218090309.274023-1-ccc194101@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H6bUj2JnekSVBQ--.9682S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrWfXr17Cr13ZF4UAw1xuFg_yoWkGFXEq3
	WxXF1xXwsaqFsFqr1UXF9a9r42kF1avrsxXw4UA34fW3Z0kF4DGFnrJrs5CFn0gryfGF9r
	Gr9Ivrna9rnxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_a0P3UUUUU==
X-CM-SenderInfo: 5fffimiurqiqqrwthudrp/1tbiVha53mdiiJy5fwAAsw

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
index f37614cc2c1b..88a0fa8807be 100644
--- a/tools/objtool/noreturns.h
+++ b/tools/objtool/noreturns.h
@@ -49,3 +49,4 @@ NORETURN(x86_64_start_kernel)
 NORETURN(x86_64_start_reservations)
 NORETURN(xen_cpu_bringup_again)
 NORETURN(xen_start_kernel)
+NORETURN(bch2_trans_unlocked_error)
-- 
2.25.1


