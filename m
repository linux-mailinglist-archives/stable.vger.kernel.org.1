Return-Path: <stable+bounces-87062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C52A39A62DF
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 12:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4EF71C20B3C
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7ED1E47AB;
	Mon, 21 Oct 2024 10:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fPfNGzXw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C351E32D7;
	Mon, 21 Oct 2024 10:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506480; cv=none; b=e9cQt0MoQsjbQ7NWeZ5mjF2BhxfqIyCJc9y+D7kIPoqlGwqtlFCnTqesWXoxmUNt2NCl7Ql4JxkzR06ZvD5GklG5CYz05vcr9/bjK7+wkAaHulM9doECtez48OPgpEHErFOca21Y5JgWAKM0D/ZvAPWmEvzKEjbXvRqSgos+4KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506480; c=relaxed/simple;
	bh=Q383C3ry5No6zGIEEXOWVtNgg2s0DQKYzieYZeYAz4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a+3ZLEgnk8OCOdrfToahpQmGtNx3lBXkMwfSlnyUy7gYnLj/pCk5KJJUzXVi80tcc0NJxt5Z8w4i033xhMW5iCFDYoTyV13taAIykC58cUI3JXX6zmldU+JXWBID5AxCEN29Gd8GjgVSNcJKV6LjzbscYJwg/WuazcDOqYQ1RK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fPfNGzXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3F2C4CEC3;
	Mon, 21 Oct 2024 10:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729506479;
	bh=Q383C3ry5No6zGIEEXOWVtNgg2s0DQKYzieYZeYAz4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fPfNGzXwOv66DfBVOfV9SRaDB18WWsAamfVIqZAyGCXsBLZNf0VcVf2READWOTSY2
	 glZuxo5lE/k1Nf622SxPVxPT5I0JOD3oBkCjzcqN0AukUFX2D7e76r940MCV04hAQU
	 zccvfGPPjw4EeLVpTDgiuGSUWrCJ/GhPet7TsM4w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Jens=20Emil=20Schulz=20=C3=98stergaard?= <jensemil.schulzostergaard@microchip.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.11 019/135] net: microchip: vcap api: Fix memory leaks in vcap_api_encode_rule_test()
Date: Mon, 21 Oct 2024 12:22:55 +0200
Message-ID: <20241021102300.092377617@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021102259.324175287@linuxfoundation.org>
References: <20241021102259.324175287@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jinjie Ruan <ruanjinjie@huawei.com>

commit 217a3d98d1e9891a8b1438a27dfbc64ddf01f691 upstream.

Commit a3c1e45156ad ("net: microchip: vcap: Fix use-after-free error in
kunit test") fixed the use-after-free error, but introduced below
memory leaks by removing necessary vcap_free_rule(), add it to fix it.

	unreferenced object 0xffffff80ca58b700 (size 192):
	  comm "kunit_try_catch", pid 1215, jiffies 4294898264
	  hex dump (first 32 bytes):
	    00 12 7a 00 05 00 00 00 0a 00 00 00 64 00 00 00  ..z.........d...
	    00 00 00 00 00 00 00 00 00 04 0b cc 80 ff ff ff  ................
	  backtrace (crc 9c09c3fe):
	    [<0000000052a0be73>] kmemleak_alloc+0x34/0x40
	    [<0000000043605459>] __kmalloc_cache_noprof+0x26c/0x2f4
	    [<0000000040a01b8d>] vcap_alloc_rule+0x3cc/0x9c4
	    [<000000003fe86110>] vcap_api_encode_rule_test+0x1ac/0x16b0
	    [<00000000b3595fc4>] kunit_try_run_case+0x13c/0x3ac
	    [<0000000010f5d2bf>] kunit_generic_run_threadfn_adapter+0x80/0xec
	    [<00000000c5d82c9a>] kthread+0x2e8/0x374
	    [<00000000f4287308>] ret_from_fork+0x10/0x20
	unreferenced object 0xffffff80cc0b0400 (size 64):
	  comm "kunit_try_catch", pid 1215, jiffies 4294898265
	  hex dump (first 32 bytes):
	    80 04 0b cc 80 ff ff ff 18 b7 58 ca 80 ff ff ff  ..........X.....
	    39 00 00 00 02 00 00 00 06 05 04 03 02 01 ff ff  9...............
	  backtrace (crc daf014e9):
	    [<0000000052a0be73>] kmemleak_alloc+0x34/0x40
	    [<0000000043605459>] __kmalloc_cache_noprof+0x26c/0x2f4
	    [<000000000ff63fd4>] vcap_rule_add_key+0x2cc/0x528
	    [<00000000dfdb1e81>] vcap_api_encode_rule_test+0x224/0x16b0
	    [<00000000b3595fc4>] kunit_try_run_case+0x13c/0x3ac
	    [<0000000010f5d2bf>] kunit_generic_run_threadfn_adapter+0x80/0xec
	    [<00000000c5d82c9a>] kthread+0x2e8/0x374
	    [<00000000f4287308>] ret_from_fork+0x10/0x20
	unreferenced object 0xffffff80cc0b0700 (size 64):
	  comm "kunit_try_catch", pid 1215, jiffies 4294898265
	  hex dump (first 32 bytes):
	    80 07 0b cc 80 ff ff ff 28 b7 58 ca 80 ff ff ff  ........(.X.....
	    3c 00 00 00 00 00 00 00 01 2f 03 b3 ec ff ff ff  <......../......
	  backtrace (crc 8d877792):
	    [<0000000052a0be73>] kmemleak_alloc+0x34/0x40
	    [<0000000043605459>] __kmalloc_cache_noprof+0x26c/0x2f4
	    [<000000006eadfab7>] vcap_rule_add_action+0x2d0/0x52c
	    [<00000000323475d1>] vcap_api_encode_rule_test+0x4d4/0x16b0
	    [<00000000b3595fc4>] kunit_try_run_case+0x13c/0x3ac
	    [<0000000010f5d2bf>] kunit_generic_run_threadfn_adapter+0x80/0xec
	    [<00000000c5d82c9a>] kthread+0x2e8/0x374
	    [<00000000f4287308>] ret_from_fork+0x10/0x20
	unreferenced object 0xffffff80cc0b0900 (size 64):
	  comm "kunit_try_catch", pid 1215, jiffies 4294898266
	  hex dump (first 32 bytes):
	    80 09 0b cc 80 ff ff ff 80 06 0b cc 80 ff ff ff  ................
	    7d 00 00 00 01 00 00 00 00 00 00 00 ff 00 00 00  }...............
	  backtrace (crc 34181e56):
	    [<0000000052a0be73>] kmemleak_alloc+0x34/0x40
	    [<0000000043605459>] __kmalloc_cache_noprof+0x26c/0x2f4
	    [<000000000ff63fd4>] vcap_rule_add_key+0x2cc/0x528
	    [<00000000991e3564>] vcap_val_rule+0xcf0/0x13e8
	    [<00000000fc9868e5>] vcap_api_encode_rule_test+0x678/0x16b0
	    [<00000000b3595fc4>] kunit_try_run_case+0x13c/0x3ac
	    [<0000000010f5d2bf>] kunit_generic_run_threadfn_adapter+0x80/0xec
	    [<00000000c5d82c9a>] kthread+0x2e8/0x374
	    [<00000000f4287308>] ret_from_fork+0x10/0x20
	unreferenced object 0xffffff80cc0b0980 (size 64):
	  comm "kunit_try_catch", pid 1215, jiffies 4294898266
	  hex dump (first 32 bytes):
	    18 b7 58 ca 80 ff ff ff 00 09 0b cc 80 ff ff ff  ..X.............
	    67 00 00 00 00 00 00 00 01 01 74 88 c0 ff ff ff  g.........t.....
	  backtrace (crc 275fd9be):
	    [<0000000052a0be73>] kmemleak_alloc+0x34/0x40
	    [<0000000043605459>] __kmalloc_cache_noprof+0x26c/0x2f4
	    [<000000000ff63fd4>] vcap_rule_add_key+0x2cc/0x528
	    [<000000001396a1a2>] test_add_def_fields+0xb0/0x100
	    [<000000006e7621f0>] vcap_val_rule+0xa98/0x13e8
	    [<00000000fc9868e5>] vcap_api_encode_rule_test+0x678/0x16b0
	    [<00000000b3595fc4>] kunit_try_run_case+0x13c/0x3ac
	    [<0000000010f5d2bf>] kunit_generic_run_threadfn_adapter+0x80/0xec
	    [<00000000c5d82c9a>] kthread+0x2e8/0x374
	    [<00000000f4287308>] ret_from_fork+0x10/0x20
	......

Cc: stable@vger.kernel.org
Fixes: a3c1e45156ad ("net: microchip: vcap: Fix use-after-free error in kunit test")
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Link: https://patch.msgid.link/20241014121922.1280583-1-ruanjinjie@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
@@ -1444,6 +1444,8 @@ static void vcap_api_encode_rule_test(st
 
 	ret = vcap_del_rule(&test_vctrl, &test_netdev, id);
 	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	vcap_free_rule(rule);
 }
 
 static void vcap_api_set_rule_counter_test(struct kunit *test)



