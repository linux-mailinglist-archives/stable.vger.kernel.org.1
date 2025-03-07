Return-Path: <stable+bounces-121357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 064FEA56460
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 10:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 039527A9245
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 09:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DF820C484;
	Fri,  7 Mar 2025 09:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AePwnvq+"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4FC207A10;
	Fri,  7 Mar 2025 09:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741341037; cv=none; b=SIKUDtX/KSEwbOEQagn+CJr9P6mrAc8me5ysE4w8/IwJ9X7cxKaXM2vYrI9CqkHBL7ffcg1yH73Gs8Wzz5CavQiSLtbyGWa0ojUpuV7yqQ9+8yc/ZgN9D+nsoFhwzmeA3a/okrFZUfvAsjvRK099N0QUYosUET15pWOlyymZ5EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741341037; c=relaxed/simple;
	bh=Pp6d5BKF+pheNNOvupojLHj4T//vHMr36YBOcZFJl2k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nqtvvfTc5YcJiFp4InnjzBMm3ERp2Pd1cinFBDng6XPZFo/nNeYexTAYCHxtr2vYlNLcU/TXcyIZdqQxMQ13Ef9H9n29G4FLdS59vciJ5Z9MWzX+C0UPs2jcHovtHRyPuZkJjN2SnW2ikR5OnLzkeBccEXi3LT4Ki/66H9mg+S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AePwnvq+; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=uoqTP
	MhXIqedMWASNYsYxuw9FI9yzczKTakxe0eccvg=; b=AePwnvq+2t/H/qNoazB+f
	dw2HgS+1tpm6AO/NBY0PBvn0wMdYXMfvtjqqXRZdvLmqOeM3HbbQS15bkPsWdGI4
	NHlkmosM39DcNt7HxhHvTuHh01ctrM4AF2vvvBnjXNxY402UJAmyDVGlzJGFI4v3
	zEuoJMvM0leL29aw/yVv+I=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDnb_xBwcpncjlNCA--.49226S4;
	Fri, 07 Mar 2025 17:49:55 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: shshaikh@marvell.com,
	manishc@marvell.com,
	GR-Linux-NIC-Dev@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sucheta.chakraborty@qlogic.com,
	rajesh.borundia@qlogic.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3] qlcnic: fix memory leak issues in qlcnic_sriov_common.c
Date: Fri,  7 Mar 2025 17:49:52 +0800
Message-Id: <20250307094952.14874-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDnb_xBwcpncjlNCA--.49226S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw4kAF45ury5Ww43tr15CFg_yoW8tF4rpF
	43Za45Wr95JF1jkws5Zw10kr90k3yqy34DWF9xW393u34jyr4fGw1UAwnIgFWjyrZ5WFy8
	trn8Z3W5XFn8A3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pimhF7UUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/1tbiqAkJbmfKu+WTIwAAsF

Add qlcnic_sriov_free_vlans() in qlcnic_sriov_alloc_vlans() if
any sriov_vlans fails to be allocated.
Add qlcnic_sriov_free_vlans() to free the memory allocated by
qlcnic_sriov_alloc_vlans() if "sriov->allowed_vlans" fails to
be allocated.

Fixes: 91b7282b613d ("qlcnic: Support VLAN id config.")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
Changes in v3:
- Handle allocation errors in qlcnic_sriov_alloc_vlans()
- Modify the patch title and description.
There's one more thing I'm confused about: I'm not sure if the fixes-tag
is correct, because I noticed that the two modifications correspond to
different commits. Should I split them into two separate patch submissions? Thanks, Paolo!
Changes in v2:
- Add qlcnic_sriov_free_vlans() if qlcnic_sriov_alloc_vlans() fails.
- Modify the patch description.
vf_info was allocated by kcalloc, no need to do more checks cause
kfree(NULL) is safe. Thanks, Paolo! 
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
index f9dd50152b1e..28d24d59efb8 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
@@ -454,8 +454,10 @@ static int qlcnic_sriov_set_guest_vlan_mode(struct qlcnic_adapter *adapter,
 
 	num_vlans = sriov->num_allowed_vlans;
 	sriov->allowed_vlans = kcalloc(num_vlans, sizeof(u16), GFP_KERNEL);
-	if (!sriov->allowed_vlans)
+	if (!sriov->allowed_vlans) {
+		qlcnic_sriov_free_vlans(adapter);
 		return -ENOMEM;
+	}
 
 	vlans = (u16 *)&cmd->rsp.arg[3];
 	for (i = 0; i < num_vlans; i++)
@@ -2167,8 +2169,10 @@ int qlcnic_sriov_alloc_vlans(struct qlcnic_adapter *adapter)
 		vf = &sriov->vf_info[i];
 		vf->sriov_vlans = kcalloc(sriov->num_allowed_vlans,
 					  sizeof(*vf->sriov_vlans), GFP_KERNEL);
-		if (!vf->sriov_vlans)
+		if (!vf->sriov_vlans) {
+			qlcnic_sriov_free_vlans(adapter);
 			return -ENOMEM;
+		}
 	}
 
 	return 0;
-- 
2.25.1


