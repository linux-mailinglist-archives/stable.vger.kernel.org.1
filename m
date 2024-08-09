Return-Path: <stable+bounces-66107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB1594C972
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 06:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E222855EB
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 04:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22345167D80;
	Fri,  9 Aug 2024 04:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hDjEisfj"
X-Original-To: stable@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2184.outbound.protection.outlook.com [40.92.63.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA12D24B34;
	Fri,  9 Aug 2024 04:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723179573; cv=fail; b=uDUkP5bz856SCGNEPkRm5lBxLZjfvHTlgeCpn4XmBaFto0bEE0bF7xCwOzw0FFir6jsU15euD1ZjLmkgatYhn0+jQSbw44wvGMfW5mP++Q6Wjs4tFTs48LktnJ8lfjgTWYV0P+rydRZ3oXJ37JPUyuYZrtq5Epj1tVJ6HnICWGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723179573; c=relaxed/simple;
	bh=kjYq/I+FSFn18TwOQR6g7zC+7BOpPdAQD127TM9pitI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TD6X18Eo+8wizvlpEG7+za2igdf8zsh5zvJDK0LhtG66MczGmo2AdrPZXMTPrN5qxR9NLmeh3CrcaPf++20A2x8RDOrjKBU2TvYMp1/LcxmapjeuK59/8Yt5vHTM020RmH+JW7uvyEcHoGgaFT4ETUE3DvvmcncPWlzLD4GhXkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hDjEisfj; arc=fail smtp.client-ip=40.92.63.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHeU0FegOtkouSgOi3o2vXgBE02NefawBVuKx1paYcyIIGNkghvnltGXRKzDUxfx9whZXV0P2FD7XYflLemiG26YmT3fVZwoaPMMRscUQ7r+fdtA2ScdOPevO6we2EMNBonlgudFgNNjiDranIhmQQEAxNlBAOYVNE5prko5+qTVhOYufTHOAholYcZmRsw8hJBj0fjVOyBMkS4IkaIiJYdL1svx5j7hBQwJHnCDKZShErcZtCKPo8I7Ki0IVMjHw3fxWtVGqtA1Zj+cHIGOFqRgN67UHWJoMcViHlAGmZt7Rd+m9PiOfd52vSO8gExdLhJVPvPcVsW/gG4+FLJeFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCawfo+zm0pKiSncRw6Hh/PRbLv3qOx2RVNyJD3YIC4=;
 b=B1v3I6RqVp9xyysa5dOhLmD2jMOROYZeOsgW3es7yu0gF2rzLyS7Gx+fPL3N/hKxVvXpnT2osX3MzzKt1EG644dCsn1gEJcf7wUhhQaZaJjIykT6JZXxCcATEapbSZb4glD7YBDaJ2YbE3AqK0aQd4tHqxMoY+2nriHiH3Ok0lVZA7AMr4cbykrf0D6f4QYn2X+BsxlvtaR4SGzZ5ppQ9VVDrcT0+sPf9dYg2hcxN3fnVnMFmmBl+i3s72RXfzAoDVmZT49LutbQ5y/lTkgz5Yg0XZHu3CajO8dFFXU3mYG/1UHAs0P7pMvb92LLr711L4Hn2rxfKAFweu5GbbO3og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCawfo+zm0pKiSncRw6Hh/PRbLv3qOx2RVNyJD3YIC4=;
 b=hDjEisfjbvya0OiGaKWtSTzdddgpArnE8mP/1zudtF+otV6C5Jd3uOjELkRyTuVZkNy7vXXt9jZ1wiZecFEpAgPKD/yYh3VgzmiWEZJwGEdmegvhcHLbF2gXaJxZffNUmIa0wgCoYQgzveHHDHpqU8IEgPMGL1u4VYzE/fLkdMAhTKeEXA3THN/k0xIigQKuywdoqMQvhDgXApCdNCbmh+l+UKbIdlJBxpAtwoY2iTAm3wsLINV0aP5R4uQV7pFAFc5s6w8016rZZB2lSkF0procbL9zN7ze0G0aVdi0TPZ0f0JyCeDA+/KkuiLmsS3AHb4QrlfRVvkkEffoRqgF7g==
Received: from SY8P300MB0460.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:297::10)
 by SY3PPF1A094932C.AUSP300.PROD.OUTLOOK.COM (2603:10c6:18::489) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Fri, 9 Aug
 2024 04:59:26 +0000
Received: from SY8P300MB0460.AUSP300.PROD.OUTLOOK.COM
 ([fe80::14bc:d68f:122:f4f2]) by SY8P300MB0460.AUSP300.PROD.OUTLOOK.COM
 ([fe80::14bc:d68f:122:f4f2%4]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 04:59:26 +0000
From: Gui-Dong Han <hanguidong02@outlook.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Gui-Dong Han <hanguidong02@outlook.com>,
	stable@vger.kernel.org
Subject: [PATCH] ice: Fix improper handling of refcount in ice_sriov_set_msix_vec_count()
Date: Fri,  9 Aug 2024 12:59:11 +0800
Message-ID:
 <SY8P300MB0460412FE86859FF97DE6342C0BA2@SY8P300MB0460.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [YydWAyohUpd7Vs4XppRdbmM3UEsXCS9zWoh28RycYy9tPyDU6tV8xGEvbYk1ijeL]
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To SY8P300MB0460.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:297::10)
X-Microsoft-Original-Message-ID:
 <20240809045911.5026-1-hanguidong02@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY8P300MB0460:EE_|SY3PPF1A094932C:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f27d57c-3d99-411b-0694-08dcb83009f4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|19110799003|15080799003|5072599009|3430499032|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	EBDlKXykhKK2q15PDc7VnrSnB8ijKS+v+j4zlAI4gG1ABMmIAVxoLebE5aLImsipM09JtSa2+v1QLg+XAa9zUmYpTDNjaJrn0V5bkD9GrGcJwbwDREaugE8a22+yzqSUuLMdYSTSQQMnaI/XBYxGg5jKXlTeBk/x8lhRnQY8+z8Ov9J5FfJkyMImtTpZ0GDoHU/wq3hpFJZUrqFrht9R0rXJn4LYju/bSoxRde4yBy9Fv+WsaVtDDCBHbDJXoSh5ajJDUypYOfDube9Tgx2wh2ZvL9t5EH702cQ+/PWPjw5XXYSW0/hahrYP/k8w4HCCnoQA9MkAi41SVP1UyucsM/P/lp/M4vKxkyll3SBwiQVaLAL39cIL5K+KASEb+2gUFtVqqPaCOI0a02VS1UWX2ZDgAP/ziWVqG7rpKsWKvEHAr+Bhdi8D9XSpjeJ6kf/AWklXm/THuC9EfJBOt+nnpdjEPc/qHsL+dosYFRfhT4r9uFzoaCB9mm4gTQ1QJK6WqOk6xAgqbIRrjfhOsVyp9aEqzCbd9Fkn3CF2gedbpcUIdzBY/84hNchoP2cEEurbJHRs/NMV5wZYwGBngdh9hwLOC5jJmPCcLdmDMfOVhSAMqoqK8GykYIi4vQN+mZVzCeYBsQ0sCufCD+TcIYVLCVqIttE1wi4cnkvN3vCJOrgwCZOIVfsrxn5HaEnN3ooZ+/ozmAzsQVhzvv+3bgKkQjMj0WXdc5UyQt+TUcYZdbA=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4mjHS6CHj8Lf7h1bPo4kWsu603mr1US84Qt1jJsPuC+Gow4mfSpiY3VogtEa?=
 =?us-ascii?Q?JWipax9fv5Le1QqoHbH7aR1bpRyqlToX2dJG+wpRhoWiPoJ0xeqqj4LE+HOE?=
 =?us-ascii?Q?slAWHFd0kt3aMKejr08euhEduDYjUt0ZIDq8BME2lce1ZtYPRDE92zys+dgF?=
 =?us-ascii?Q?IocUY4qmTgpPTtGKQtwMZRcH2RjqX1ZfQxuHaY+lPRQtTWuXzmA89TxIlrCG?=
 =?us-ascii?Q?WZ4+hJAKT+q+BNtP5eB/npzisTZsynF0M6SHV4hZRGy1uBO2zuUrAtw2zWTe?=
 =?us-ascii?Q?8Z+zOh6LWkK8QrZ+7i5+bA+7JncS8nU84C3NJS1AMCckx45Shzctxk8YbNZQ?=
 =?us-ascii?Q?IZ4j0FQuwY9mkR5vPXQEvsoCisANanld493em5/oBu4ElajJZgFGpy1XboW1?=
 =?us-ascii?Q?S7ITcDKKO+hN5poCP65pBKZjX0nwXA6MkaB8C3DD6fXUGzq8UXUcjY+PUMIK?=
 =?us-ascii?Q?4czfKozhe3cOeHsgtNfTEvNzoBYNZFVFufvT0WsXNNDV2uoDgYxoJqP9BNUf?=
 =?us-ascii?Q?NJ5MeY/KC3Uahc/okq+Q5wiBjReyoLB1nAO6HCRiqqLvfRRLvFC27t2j7pqp?=
 =?us-ascii?Q?eyDbjv1kMZpDzH8IPIVnpLmCc2bD9AKhDJt8JmIFNfJGGbBmBQyfBZLd48yS?=
 =?us-ascii?Q?RotbhA3qTFWV5iYpHjcmaHSwSF4VMZSMXV11R+EuR+7vqufdvOYIPerC9Eat?=
 =?us-ascii?Q?6T+aYcoJvKxJO6PK15KADK8dMYDfr1p8vK8msD6UQL+Ljg5hxl02hhDexnJn?=
 =?us-ascii?Q?uVMpQhPpNmasDVE+QBiy0Syk4wyB+8ANVCAgPO3mTf0WSrKwrhDzWBFek/d3?=
 =?us-ascii?Q?alabFJBuarCp88KirRy6w6vvwems6nyRqKa18Bhandc0nqTaDDCK28VNMppI?=
 =?us-ascii?Q?6l4iowyeA8CF01jsHOO81/bOnLTCEMJQf2+S3ANAHoNl54vMi4RuHCV0FaPK?=
 =?us-ascii?Q?xlslwhrdUkz0102jPrxdoK9jqdeUwjQZ07x4F0bjTB59pOQBw1lKcoPBj0s6?=
 =?us-ascii?Q?WZODWfYuLUGJgdme7KwsKUzKsMdT5S+MtoDMw8uOaniwLuYMHXL5FW/dkQBn?=
 =?us-ascii?Q?4/cIxRidaXuM3XGgup5+CAni3F8mMzDkRThl1GVpZJX5pLllnDBZe2KbBjeM?=
 =?us-ascii?Q?mA4JQk1IwklbmwFAVzFh+C1rzbNjI2elzEd6rK7icGSorwQMV/zJtcR7cwKc?=
 =?us-ascii?Q?/37q0yyg3QgmgyG572kVZzstolgmI9g4wHlJT9aS3J9slMJith8M+FhP3j2p?=
 =?us-ascii?Q?JB+EaKVeUCjSEJgubzEW7HvgNlD8kDpGwnh3uPx7BwfDpAX2bVqt0KZrG5sh?=
 =?us-ascii?Q?1eybuqfuMmsD+z+OftHBmgkw?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f27d57c-3d99-411b-0694-08dcb83009f4
X-MS-Exchange-CrossTenant-AuthSource: SY8P300MB0460.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 04:59:24.6531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY3PPF1A094932C

This patch addresses an issue with improper reference count handling in the
ice_sriov_set_msix_vec_count() function. Specifically, the function calls
ice_get_vf_by_id(), which increments the reference count of the vf pointer.
If the subsequent call to ice_get_vf_vsi() fails, the function currently
returns an error without decrementing the reference count of the vf
pointer, leading to a reference count leak.

The correct behavior, as implemented in this patch, is to decrement the
reference count using ice_put_vf(vf) before returning an error when vsi
is NULL.
 
This bug was identified by an experimental static analysis tool developed
by our team. The tool specializes in analyzing reference count operations
and identifying potential mismanagement of reference counts. In this case,
the tool flagged the missing decrement operation as a potential issue,
leading to this patch.

Fixes: 4035c72dc1ba ("ice: reconfig host after changing MSI-X on VF")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <hanguidong02@outlook.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 55ef33208456..eb5030aba9a5 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -1096,8 +1096,10 @@ int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
 		return -ENOENT;
 
 	vsi = ice_get_vf_vsi(vf);
-	if (!vsi)
+	if (!vsi) {
+		ice_put_vf(vf);
 		return -ENOENT;
+	}
 
 	prev_msix = vf->num_msix;
 	prev_queues = vf->num_vf_qs;
-- 
2.25.1


