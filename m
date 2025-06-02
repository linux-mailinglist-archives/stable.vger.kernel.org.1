Return-Path: <stable+bounces-150568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 903A5ACB8E7
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FD791942362
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC15A22CBE9;
	Mon,  2 Jun 2025 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZxfIePFf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957E522C32D;
	Mon,  2 Jun 2025 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748877534; cv=none; b=sh0HvtSgYxRlg5GODt+L9ZJ63dNovUj96YQ8N3PMmo2e0u6Sy3K3j/596qA7DspgyzMKZByRDdka959oEVY1erMQcc57gs+JGWo1FLYoHG026iE3riTFBqFg+g2yOw2RoRxzIe0GKPkVdIv4kyZGDxTmjORQSjskCfTqxvCcca4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748877534; c=relaxed/simple;
	bh=de0ABO8qU0MkIQYJQZtYKRaUOxDhyM/Tuj68PUVkNOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4uUYh6DaC6+6kwKNr0b6aNv6Y37CMhv1aP0UC0jRC9KTta/dL/38BWvb7WHmK7AzDeMVaZiDBSXyC1qWcDcKiDXM3byP9Yb+w5lbeZlEwOqNY5H9Ti0WV27EppJ6uVssQqDJO8+cMZ/l1Afb3PHQU0ewowOE5pM13TiywAkcrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZxfIePFf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFBFC4CEEB;
	Mon,  2 Jun 2025 15:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748877534;
	bh=de0ABO8qU0MkIQYJQZtYKRaUOxDhyM/Tuj68PUVkNOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZxfIePFffTjlHaXWPUnB/SAzFF0tzFvIcoWle0r03cD/SRhuvR8wbfXdRECwTocud
	 v2ebDIjR4nUD4+4he8suvdFZWvGnauUDwrV9SfRgtyDOiQPjRv06OoNkGR+1cIQOdp
	 IRmVuLEDIinXVMk7b9vz7mVDu12ziLV310MedOgk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.1 278/325] octeontx2-pf: Fix page pool frag allocation warning
Date: Mon,  2 Jun 2025 15:49:14 +0200
Message-ID: <20250602134331.058626242@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134319.723650984@linuxfoundation.org>
References: <20250602134319.723650984@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ratheesh Kannoth <rkannoth@marvell.com>

commit 50e492143374c17ad89c865a1a44837b3f5c8226 upstream.

Since page pool param's "order" is set to 0, will result
in below warn message if interface is configured with higher
rx buffer size.

Steps to reproduce the issue.
1. devlink dev param set pci/0002:04:00.0 name receive_buffer_size \
   value 8196 cmode runtime
2. ifconfig eth0 up

[   19.901356] ------------[ cut here ]------------
[   19.901361] WARNING: CPU: 11 PID: 12331 at net/core/page_pool.c:567 page_pool_alloc_frag+0x3c/0x230
[   19.901449] pstate: 82401009 (Nzcv daif +PAN -UAO +TCO -DIT +SSBS BTYPE=--)
[   19.901451] pc : page_pool_alloc_frag+0x3c/0x230
[   19.901453] lr : __otx2_alloc_rbuf+0x60/0xbc [rvu_nicpf]
[   19.901460] sp : ffff80000f66b970
[   19.901461] x29: ffff80000f66b970 x28: 0000000000000000 x27: 0000000000000000
[   19.901464] x26: ffff800000d15b68 x25: ffff000195b5c080 x24: ffff0002a5a32dc0
[   19.901467] x23: ffff0001063c0878 x22: 0000000000000100 x21: 0000000000000000
[   19.901469] x20: 0000000000000000 x19: ffff00016f781000 x18: 0000000000000000
[   19.901472] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[   19.901474] x14: 0000000000000000 x13: ffff0005ffdc9c80 x12: 0000000000000000
[   19.901477] x11: ffff800009119a38 x10: 4c6ef2e3ba300519 x9 : ffff800000d13844
[   19.901479] x8 : ffff0002a5a33cc8 x7 : 0000000000000030 x6 : 0000000000000030
[   19.901482] x5 : 0000000000000005 x4 : 0000000000000000 x3 : 0000000000000a20
[   19.901484] x2 : 0000000000001080 x1 : ffff80000f66b9d4 x0 : 0000000000001000
[   19.901487] Call trace:
[   19.901488]  page_pool_alloc_frag+0x3c/0x230
[   19.901490]  __otx2_alloc_rbuf+0x60/0xbc [rvu_nicpf]
[   19.901494]  otx2_rq_aura_pool_init+0x1c4/0x240 [rvu_nicpf]
[   19.901498]  otx2_open+0x228/0xa70 [rvu_nicpf]
[   19.901501]  otx2vf_open+0x20/0xd0 [rvu_nicvf]
[   19.901504]  __dev_open+0x114/0x1d0
[   19.901507]  __dev_change_flags+0x194/0x210
[   19.901510]  dev_change_flags+0x2c/0x70
[   19.901512]  devinet_ioctl+0x3a4/0x6c4
[   19.901515]  inet_ioctl+0x228/0x240
[   19.901518]  sock_ioctl+0x2ac/0x480
[   19.901522]  __arm64_sys_ioctl+0x564/0xe50
[   19.901525]  invoke_syscall.constprop.0+0x58/0xf0
[   19.901529]  do_el0_svc+0x58/0x150
[   19.901531]  el0_svc+0x30/0x140
[   19.901533]  el0t_64_sync_handler+0xe8/0x114
[   19.901535]  el0t_64_sync+0x1a0/0x1a4
[   19.901537] ---[ end trace 678c0bf660ad8116 ]---

Fixes: b2e3406a38f0 ("octeontx2-pf: Add support for page pool")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
Link: https://lore.kernel.org/r/20231010034842.3807816-1-rkannoth@marvell.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1402,6 +1402,7 @@ int otx2_pool_init(struct otx2_nic *pfvf
 		return 0;
 	}
 
+	pp_params.order = get_order(buf_size);
 	pp_params.flags = PP_FLAG_PAGE_FRAG | PP_FLAG_DMA_MAP;
 	pp_params.pool_size = min(OTX2_PAGE_POOL_SZ, numptrs);
 	pp_params.nid = NUMA_NO_NODE;



