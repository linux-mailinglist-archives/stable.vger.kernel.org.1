Return-Path: <stable+bounces-39508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0B98A51EA
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 15:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79471285953
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 13:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FE278C7D;
	Mon, 15 Apr 2024 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPGsdcZz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0216576057
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 13:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188332; cv=none; b=AiYpnlSCT+DSkMRNYXt2nR7oGJlSmGsgeDF1gRYysIw+vIowU71KDaMt+1vfElOmuWXH3h1d9DER9GA7sLgWEt7ghwmhC9wt647/1vB9uLytMZapIG3M680kP9zRlrvMbLAP00EUoyMp/mHps6y8YUmA4KVm0AfckiX5Xfk4Cys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188332; c=relaxed/simple;
	bh=yujWmzf4njcZMzvsJ07SdDfW9WhucxWmsrV0poNbk7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eY64I9MlFVJZ1gCOZNHn8SsBVw+M7EPx5TN3PDnqXrlFhL3dNykJxDvsfVg58fqGcEST7FUvwKTOg4e5GtPuOYuygfXp2DvBiZJi6xnEi7yXIFAPbhxbZ/jeKVHjJU7x2vYfDFKUl7hDWyIPZUmwkJHvqVEnqfJM6NbpCZzHL3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPGsdcZz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A0FC2BD11;
	Mon, 15 Apr 2024 13:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713188331;
	bh=yujWmzf4njcZMzvsJ07SdDfW9WhucxWmsrV0poNbk7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PPGsdcZzBU8VuQq/yw/NrtIoVfbNg0txCqy+InF/GaKjJw83ZNV44zbYbJB6iz0WT
	 SLZ8wqRym4iZyk4d6Uuwxto1yx2zTJSSo7IJLE9Z5fy0p1bQtcfjP+dMA+P15iNpu/
	 /7nIE55saw2Wz1uRQPdKGzG/t0aURa66dQh42IOu4lCwBJr59+NonSNyXIlvF9/Eld
	 /r+f/hBmF777RSMz+60vw3EauiPyg4BELczT5K+qn3IP5dTS8M8swmOMzor5onlFn9
	 +rjBmxpaox13t2z67OloFU0fllckV8X5zpuXTExOL1vwMkMeHC+RqBCbbJ5ylWhbus
	 d0X5K+R90A7lw==
From: Sasha Levin <sashal@kernel.org>
To: kernel-lts@openela.org
Cc: Daniel Vacek <neelx@redhat.com>,
	stable@vger.kernel.org,
	Mats Kronberg <kronberg@nsc.liu.se>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14-openela 031/190] IB/hfi1: Fix sdma.h tx->num_descs off-by-one error
Date: Mon, 15 Apr 2024 06:49:21 -0400
Message-ID: <20240415105208.3137874-32-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415105208.3137874-1-sashal@kernel.org>
References: <20240415105208.3137874-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Vacek <neelx@redhat.com>

[ Upstream commit e6f57c6881916df39db7d95981a8ad2b9c3458d6 ]

Unfortunately the commit `fd8958efe877` introduced another error
causing the `descs` array to overflow. This reults in further crashes
easily reproducible by `sendmsg` system call.

[ 1080.836473] general protection fault, probably for non-canonical address 0x400300015528b00a: 0000 [#1] PREEMPT SMP PTI
[ 1080.869326] RIP: 0010:hfi1_ipoib_build_ib_tx_headers.constprop.0+0xe1/0x2b0 [hfi1]
--
[ 1080.974535] Call Trace:
[ 1080.976990]  <TASK>
[ 1081.021929]  hfi1_ipoib_send_dma_common+0x7a/0x2e0 [hfi1]
[ 1081.027364]  hfi1_ipoib_send_dma_list+0x62/0x270 [hfi1]
[ 1081.032633]  hfi1_ipoib_send+0x112/0x300 [hfi1]
[ 1081.042001]  ipoib_start_xmit+0x2a9/0x2d0 [ib_ipoib]
[ 1081.046978]  dev_hard_start_xmit+0xc4/0x210
--
[ 1081.148347]  __sys_sendmsg+0x59/0xa0

crash> ipoib_txreq 0xffff9cfeba229f00
struct ipoib_txreq {
  txreq = {
    list = {
      next = 0xffff9cfeba229f00,
      prev = 0xffff9cfeba229f00
    },
    descp = 0xffff9cfeba229f40,
    coalesce_buf = 0x0,
    wait = 0xffff9cfea4e69a48,
    complete = 0xffffffffc0fe0760 <hfi1_ipoib_sdma_complete>,
    packet_len = 0x46d,
    tlen = 0x0,
    num_desc = 0x0,
    desc_limit = 0x6,
    next_descq_idx = 0x45c,
    coalesce_idx = 0x0,
    flags = 0x0,
    descs = {{
        qw = {0x8024000120dffb00, 0x4}  # SDMA_DESC0_FIRST_DESC_FLAG (bit 63)
      }, {
        qw = {  0x3800014231b108, 0x4}
      }, {
        qw = { 0x310000e4ee0fcf0, 0x8}
      }, {
        qw = {  0x3000012e9f8000, 0x8}
      }, {
        qw = {  0x59000dfb9d0000, 0x8}
      }, {
        qw = {  0x78000e02e40000, 0x8}
      }}
  },
  sdma_hdr =  0x400300015528b000,  <<< invalid pointer in the tx request structure
  sdma_status = 0x0,                   SDMA_DESC0_LAST_DESC_FLAG (bit 62)
  complete = 0x0,
  priv = 0x0,
  txq = 0xffff9cfea4e69880,
  skb = 0xffff9d099809f400
}

If an SDMA send consists of exactly 6 descriptors and requires dword
padding (in the 7th descriptor), the sdma_txreq descriptor array is not
properly expanded and the packet will overflow into the container
structure. This results in a panic when the send completion runs. The
exact panic varies depending on what elements of the container structure
get corrupted. The fix is to use the correct expression in
_pad_sdma_tx_descs() to test the need to expand the descriptor array.

With this patch the crashes are no longer reproducible and the machine is
stable.

Fixes: fd8958efe877 ("IB/hfi1: Fix sdma.h tx->num_descs off-by-one errors")
Cc: stable@vger.kernel.org
Reported-by: Mats Kronberg <kronberg@nsc.liu.se>
Tested-by: Mats Kronberg <kronberg@nsc.liu.se>
Signed-off-by: Daniel Vacek <neelx@redhat.com>
Link: https://lore.kernel.org/r/20240201081009.1109442-1-neelx@redhat.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hfi1/sdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index aeaed09360055..4067273fdd7b1 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -3212,7 +3212,7 @@ int _pad_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx)
 {
 	int rval = 0;
 
-	if ((unlikely(tx->num_desc + 1 == tx->desc_limit))) {
+	if ((unlikely(tx->num_desc == tx->desc_limit))) {
 		rval = _extend_sdma_tx_descs(dd, tx);
 		if (rval) {
 			__sdma_txclean(dd, tx);
-- 
2.43.0


