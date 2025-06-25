Return-Path: <stable+bounces-158477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 669AAAE74E1
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 04:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74A147ABA4D
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 02:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489D11BD9D0;
	Wed, 25 Jun 2025 02:40:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A2F1A23A4;
	Wed, 25 Jun 2025 02:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750819255; cv=none; b=b8YPuDiJcuE/5wVP6NNsLXA1NqpavDENoLuUXwxkcyFfQnOpSjJv9ZyStrYKWsP0DAyNNBc4QNAnr+erZVYAcvEMGSTqe6h/2BtO86EHGFM2nnxUxt4nAUmuylY8Ya+RYhIr7lB/KgrLjyEY1XEUORPP+dxBBF2h1O1J46XfRBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750819255; c=relaxed/simple;
	bh=1ot4fcUh9htHque5KOKH0SX0B3xlo5rcLrCvjre98+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N3b6/RJiM2lxEVrucqE8wJHOlEoFodDVd+JiP1YMIwCbMuCDYKsShlODf7K9o8KflztW3N+cgg8ZCtVnOuiSwSKHoByMPKxQdAlg0x1p5aqpwsjxuactsv212ogNw878Hl+ZkHkDKn1ln/Onyc7TazSZzq2SmvVfwAXKg8DhaZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz5t1750819175tc0cf436c
X-QQ-Originating-IP: G1HoGL4WxqlxynV8bTIV7pexICZnDU0OjCE2/bZgzjE=
Received: from w-MS-7E16.trustnetic.com ( [60.186.80.242])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 25 Jun 2025 10:39:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8086606251044154138
EX-QQ-RecipientCnt: 11
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: libwx: fix the creation of page_pool
Date: Wed, 25 Jun 2025 10:39:24 +0800
Message-ID: <434C72BFB40E350A+20250625023924.21821-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N7bzzhFwp0G2Rr32myLeYclLHUtF34dJ5ixxLWGuZ1X38PhNki4c7YYA
	lswJdJUP2d5Vf3h//6IBXPzF2fLihh51GBWPPf+NNghF4IReW9k7DS1JA/iuop5ymsBaw74
	2nKCgzSPrNDEcqnHUem72PoSJxAEW5hVrXvUASX1/YZYa28mQY1NhfI5dW8449QS8KYYywV
	Q8X0cJhUIMNW80JeGfA3m07HSlt0EasM/SfgETRHdfF9BU0puCNvyQb7iNYSTjWWsGZnKrH
	0p9fxDdlX+BYlEK9DBiZ9uHSSNQB2LOb2sjH1B313ljfAYiEKot+W6FBejqRZQiyfefM++Q
	1YCSn4S9nRlhX7i7MADzTom4DQo5IIkXJy7XNMdMoVmGH6XH5cj1SkvQOEi3kj5EV9mjCFo
	S/blMoO/DucMYfyMgtvLwI7I5ox2fTpDQqHIa7PZ4oExsxjLOXpPNHk1U2nJT7Si9GyMqtY
	anpsuuuclgBzwHeHpU6OT2eARoiPHwZASG9ffiF4F9WuqTJuNqTM/dv2j+fNSl0GCKaxAEr
	btHF4TO8fymemNbOww64yTXsn2aCMGCjSonU8+GgV1NUccdRZ3jQtcpNBbbBckswmTc+mzH
	ri/YfrMRvfwjpm4Mo++/RYhOWJ3a//tLvJUIiMNo5iGI8ExT/Gk5ICGzwO/jFMFSbtt+IBf
	GZtX8RJQpA6QEf/ws6ZhMPy4jREfhrh5iUohrXE+dnwkEPROKcrhD51JAzb0aZ5tGlRVXCg
	WzQg6bmFvTe6UIeOTt0Z5P+h3dEgCvzQ8dgM3Q36OUcV2MKTqw7/IYznNsMzeJH3pinQKyX
	5GdpnYhpsQdwxtbASQYAdLySW6BOJr9/9q74ojgNCQsYa6VxoB3FkQRrz0K8c+S2qGbq3sb
	5ElHM9PK06lgtLUBBkIlFzUJaBVTgglH6qiWgxm/TSvyTtfU+K9hwmJjZOlgah1mC0IKsSm
	LAQK2S9314FxrPtQ6TwviNNVxEHkChIpSSeyBem3qU0E5WbS1Pd0ozfuNbRHC6h2krOV+Kf
	Sz1dF5xzfoeAZ5Kf6jluEi0tEoYwU=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

'rx_ring->size' means the count of ring descriptors multiplied by the
size of one descriptor. When increasing the count of ring descriptors,
it may exceed the limit of pool size.

[ 864.209610] page_pool_create_percpu() gave up with errno -7
[ 864.209613] txgbe 0000:11:00.0: Page pool creation failed: -7

Fix to set the pool_size to the count of ring descriptors.

Fixes: 850b971110b2 ("net: libwx: Allocate Rx and Tx resources")
Cc: stable@vger.kernel.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 7f2e6cddfeb1..c57cc4f27249 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -2623,7 +2623,7 @@ static int wx_alloc_page_pool(struct wx_ring *rx_ring)
 	struct page_pool_params pp_params = {
 		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
 		.order = 0,
-		.pool_size = rx_ring->size,
+		.pool_size = rx_ring->count,
 		.nid = dev_to_node(rx_ring->dev),
 		.dev = rx_ring->dev,
 		.dma_dir = DMA_FROM_DEVICE,
-- 
2.48.1


