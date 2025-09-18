Return-Path: <stable+bounces-173728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17161B35E7F
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 672BC1BA770E
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88D9299957;
	Tue, 26 Aug 2025 11:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oJamOj7L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A511D200112;
	Tue, 26 Aug 2025 11:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756209002; cv=none; b=WLbRy72TLeiu4GKJQLU88qtGoCpLHMt8t6KZwCcOnNZm38qaobg8/PfwcgP7MzLfARZmrxS6OKmhMVUp8JhSGuZreM1GE80V5GACZ5G3f0Tyy6d7HzVPkB7LvNIymdIDENAEpSk9r00xZ+s6BwxEyPtKi3gYZc8/vH1Zh3hygjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756209002; c=relaxed/simple;
	bh=8ZP0Xl4jQ5bW9r10lCPtUin0fWJ7eVAvpHt/anAiwJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZyX1mHUxja37BOb2fXo6lFQKur/jwPZQITYHWGNVfm+UwuIRtIaQFAUyWceuv8yzkFRo8BnVX5gDLqC8/ofr9YV+bZWT1adZ9Wgg2xFKRf9GkwXhIR59l9sgf+NGHZ/4C5SB7rn4ZleqApVWiTJdA0wrY4+jPQXJ2UoDgDcejxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oJamOj7L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3432BC4CEF1;
	Tue, 26 Aug 2025 11:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756209002;
	bh=8ZP0Xl4jQ5bW9r10lCPtUin0fWJ7eVAvpHt/anAiwJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oJamOj7LrfkTKwvvLHc/4tV2EoTNepGkMt4iaKKW2rhP+hPa5uqSKpX+IsEHsDjYj
	 bd8tvmDs6Xo/2Fi4ndOfno4oq6LwG27ZlpcgBSx4mO+bNzNoLjy65v+GtLm9VTRy+V
	 Hjx/EHMicQZB0gMyV35D6QYGSvybGmN3rxp/YdpY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Jurgens <danielj@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 313/322] net/mlx5: Base ECVF devlink port attrs from 0
Date: Tue, 26 Aug 2025 13:12:08 +0200
Message-ID: <20250826110923.620793760@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
References: <20250826110915.169062587@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Jurgens <danielj@nvidia.com>

[ Upstream commit bc17455bc843b2f4b206e0bb8139013eb3d3c08b ]

Adjust the vport number by the base ECVF vport number so the port
attributes start at 0. Previously the port attributes would start 1
after the maximum number of host VFs.

Fixes: dc13180824b7 ("net/mlx5: Enable devlink port for embedded cpu VF vports")
Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Link: https://patch.msgid.link/20250820133209.389065-2-mbloch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index f8869c9b6802..b0c97648ffc7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -47,10 +47,12 @@ static void mlx5_esw_offloads_pf_vf_devlink_port_attrs_set(struct mlx5_eswitch *
 		devlink_port_attrs_pci_vf_set(dl_port, controller_num, pfnum,
 					      vport_num - 1, external);
 	}  else if (mlx5_core_is_ec_vf_vport(esw->dev, vport_num)) {
+		u16 base_vport = mlx5_core_ec_vf_vport_base(dev);
+
 		memcpy(dl_port->attrs.switch_id.id, ppid.id, ppid.id_len);
 		dl_port->attrs.switch_id.id_len = ppid.id_len;
 		devlink_port_attrs_pci_vf_set(dl_port, 0, pfnum,
-					      vport_num - 1, false);
+					      vport_num - base_vport, false);
 	}
 }
 
-- 
2.50.1




