Return-Path: <stable+bounces-200889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D42CB8631
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 10:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 09967300EBD4
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 09:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856751E885A;
	Fri, 12 Dec 2025 09:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="J3necYOK"
X-Original-To: stable@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013072.outbound.protection.outlook.com [52.103.74.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869C62D47FA
	for <stable@vger.kernel.org>; Fri, 12 Dec 2025 09:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765530662; cv=fail; b=medhig2zaB6Wp/nKmOj7gsZttaOf9Jc9yfcoSPbIKl9JGFb5ltgHBua5w6jMLJ5RveEVlgahh71ptCBBFY7VcAyPe54enCL8gbuIOKKCCFoHxz9NNiyzs4qSLBvI3syyfl6nR4aIPJOXfNGddTX9jHpGIDvVdOVsaI43S3kfkuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765530662; c=relaxed/simple;
	bh=t9988uJhgEfWtwNP6SJ7fO8eRccOGJl5ElXlUtoSJpU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=u21MniHVM/iY0RZrXhYUS90NxqctvTiwMmcFXEuk/5OhnoDfuX50nud7gfisQdc3exAwDDPTTwhcE/dsaK99Ywhl6p2ugpY+2qB1Srigj5LOtldX9jQBVfuf/pXgzF8rxsAy9Els7g4f8g4/r27AXJPdd61r4ffAjiabAq2CKGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=J3necYOK; arc=fail smtp.client-ip=52.103.74.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KtAOmv/rfuBayhhZieKF06Gl46cxkPb5k9oHwBy6uTst7zhqRp0L6cCGOv6CF5S9NRBqjpbVQZJ24yUjDH1v23xiq/FBi2W8z4gLAt7QIykMxK8ZEmDvpLLTCimyqQksf4Fy5a3mhkRKRHHtsuC1QSE14MstRIK9fkFcdwG8afiQUdW4XBFH/EBJ4vYmTpfTrmpi39C5ZO4AXg3P+ICPhujw3quTObHcdEfYAlqadcJwu7PG28o0nfMkA7GTUh+RmSauTIYPT8cpHE+Gl+UFi4u6yDlMYu3UgW05orZ1CJTQ+r6NNZdRDPl4Qpv6mzEboKDuoWR07UiW9GxX3dONiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHDpBJ+OqEx9K9BnwqRHQS4Rvm++r8fbzgpbgIWGOiQ=;
 b=Bl48I8Z1nIWiM1ND0TZ/VEo3Ssq+oXqDlD6oB89OztciqFqo82WsBw0BgamuuBGhI/Js9MtVk5/S4iSphDX26pBKMwEtjP6gGLzrmfCRtbVv+sKx5Txm6Qy6ByBINOTBW6PLEb2cZnZCvf9Z+FBo+1a6DU7X8ziYxrgJfU5d+H+OSCufKIRG52Jk7E3oNS7xAyXggHwDgJVZOonH84WrejcUG8/et9N7neVb2c0qZ4sIq8cIr2TH1ypEEPaGTQwCUo41F9kk2p1MZUV0AnG+Bb0WO1TL8xLBK6Pb9jIfKD4rNarSavWz/TS/nIRZf8dbn2XJG3PoqI6BUTaj7PE47w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHDpBJ+OqEx9K9BnwqRHQS4Rvm++r8fbzgpbgIWGOiQ=;
 b=J3necYOKxlmdVgv1q8B5vMUIThMUlUj944Y8y/lHZkdllmGH/sO85plCiaGB77xq2mjx+Dk76MX5DO2HoCok6YnBiSRFALm/Xq0/+sSXsGHemUSz7IdxiSViQWrVshOXlLVznHAtA968uZeUduvuPLmwwTKHA9OTWopZbOim0qm49YN5gGgDFgtlh1WKUw924wtdZhSkuwPQLPe7jJELmOIZ0gOEdtsUSU5W4WjbdpQKmLLoQ+6JFEqt8N0SO9hgSEndMSOrjoNSQAiDo+ALzHYdXq3HhftbO/ZljY6BATLO//xQsrU7NmOUNy1ZYAdkSUgHGphVIRtIazf96AfApQ==
Received: from JH0PR01MB5514.apcprd01.prod.exchangelabs.com
 (2603:1096:990:1b::5) by SEYPR01MB5266.apcprd01.prod.exchangelabs.com
 (2603:1096:101:d4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Fri, 12 Dec
 2025 09:10:52 +0000
Received: from JH0PR01MB5514.apcprd01.prod.exchangelabs.com
 ([fe80::9db9:d597:8118:abf2]) by JH0PR01MB5514.apcprd01.prod.exchangelabs.com
 ([fe80::9db9:d597:8118:abf2%3]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 09:10:51 +0000
From: WeiKang Guo <guoweikang.kernel@outlook.com>
To: guoweikang.kernel@outlook.com
Cc: Miguel Ojeda <ojeda@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] docs: rust: rbtree: fix incorrect description for `peek_next`
Date: Fri, 12 Dec 2025 17:10:46 +0800
Message-ID:
 <JH0PR01MB5514E3DB07FC77EF0AF59C38ECAEA@JH0PR01MB5514.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0149.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::9) To JH0PR01MB5514.apcprd01.prod.exchangelabs.com
 (2603:1096:990:1b::5)
X-Microsoft-Original-Message-ID:
 <20251212091046.229962-1-guoweikang.kernel@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR01MB5514:EE_|SEYPR01MB5266:EE_
X-MS-Office365-Filtering-Correlation-Id: b53507b5-4e54-4211-2e2f-08de395e58ad
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwXZ5XHxNrJCjRnjimRBgM6SGcafJNwAl379Kxarhk1DrZYxV96kvSaJumpvzK7DF3Nljd+Z7O46f0YWPFrIapK7pl6dIGrpAD+LVBYcJq3XgffhSIusr0vv3aGXc5E20eXb9w0oLVM36XWLBAAqe4AsNEOjWO4uNjU/t7Y5Pg/8FIa5kXxm/RqPbKbBQJPG/3yJD1cFEDhnKcxxA/9bkKNbVwAzi0nPg/bZ0gAiAWp/TGSp1ajATDpFV6arX+tT6+O2HSYt4ZMelt8eBnXI8oDEH4zvja1tRwbx+DHa/m1bYflUPq1j0T+42/0ALWOrWlNm21SL/nsKAxJZOPHsWuNfcLkbFikOJj3q/XhB4Qdwm+BVdQCCApgqDs5ZxaqmdIEyvltw7f3Xr2+ea65HndJE7ynOXZh2+qyVilm1O3LtkUwfABks6KXVG+G5EsuuG0+qnEgkGr/sCEcJ2TEeY+GI86tua5QCBNf+t0rF79yrBvf2mjftbYgr6uph7/7xxwEL5taKad/eLsHG/7qNmdL7d13m17pai9jOm/NOl8x4TGDr7AJGE7ef6l300Z57ZX7jf4WORHEQAt/2+LfpkdB9V1AbbK3TrQQR7LQObmXM3BEoyrIeB6Gdy0iUZpomJLY+nNz+uOU0WPVoRCHX4c+BOwotCDG5uzEBAyaRcFISxISHWkt7OzOHOAPmclLeWB6QGdFEPUC+RUGvhEqezJI7K75Sb1hD8b6Eney/k9uY2NSEmtZyXK2ywyq7v8Ekx68=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|8060799015|15080799012|19110799012|5062599005|5072599009|461199028|9112599006|3430499032|3420499032|40105399003|53005399003|440099028|3412199025|10035399007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DQ2AlYisO2k1ZmKTbuHn1cyNEuUIhko6MYFUaBHL/FyyxN6j8ZN4CCXWeeWv?=
 =?us-ascii?Q?iONNeYSrAGmvoRFsesG1pOqIEp8uG46PofcELtJIXyoqEb9BTHdEZwiU6E/0?=
 =?us-ascii?Q?7bRjKoLLYAwr0s/VbuFUdR+vs5BtwfRdnRYDgbvHECAI1RO9pRbs0RtdYMqQ?=
 =?us-ascii?Q?VOUtiEVrUM6Yb9u1SB337TVocKGJci4/11G4qg8jtVTdGcJQt0emFaTC1awH?=
 =?us-ascii?Q?T2oozEBcLQckAkVVjaPkVFzfW5xUrF00OE+M6ftN3WKXnWehsaU7GPV2h2dg?=
 =?us-ascii?Q?eB/O3Onyp0ec8ObE4+4/CmObO3ZqEgd2nNRqFtnbS5Sazuivz9D1HeOraU2d?=
 =?us-ascii?Q?TN2E/xK7vQqh+HrfY+7AoqjML7Or//8EYCZw6cyIwdxjCPtC6S12t9Bg6jeY?=
 =?us-ascii?Q?Mp4fGrFZqj+YH3vJJCy2Aeub4yIE286NDEXtLAFn2/y/By2G1+oBs9GfJUTo?=
 =?us-ascii?Q?hPKLhcVFVWBr13rT9t1HySSeXlmfwQcpkIoYVxIkilE6AZljelr2vsUefiYD?=
 =?us-ascii?Q?8NUgTg50j4V4hrYxFSbXwA1uILPJ/e6gVyZ37oFdZIVF1faxNwewr4s9VGKh?=
 =?us-ascii?Q?yxdeNVjLa9Tvi3N4fVi1FpbZXjFnYLVQjXc34nnzIzvRuV/DdqHzf8aJH+Mr?=
 =?us-ascii?Q?msgFbWH4zKDxeLAe2+GWU3oZCFuJM+bdzLVE3AUiV6FiCbDMQa17trfKwhAI?=
 =?us-ascii?Q?wxnZs/hF3BxCr5IaNEAyFWiY7eLmk0EdsZFtqQ0SHKN+DN+Ud32ZMQJMo375?=
 =?us-ascii?Q?LDut17WriHaKzeIxAgbAGur71nZvleFriNpKFL4E5+swhf4VP2bqAplhSjdF?=
 =?us-ascii?Q?Q0Uo9y2ZnthJLh2bHkAZECGe4aNQE8zPyQjT5LOurrJMCoOivoryFgrvi6Wl?=
 =?us-ascii?Q?DsrqSvg/I2uEep+lJDrxe90z2mMJoCQQE91KHJsgs+nk1vBrx4g0e+grU16W?=
 =?us-ascii?Q?/32aao5R+4rpGH03JU474/YBpOGZ3bV0vq9yZur/CYVCXrCYKNKlb5mZkqCD?=
 =?us-ascii?Q?8zMH2SaPAaAiEMRPJbiWBIx3AeZxxfTsq80atEiXpRhegkT1ZP8cy4t5deG2?=
 =?us-ascii?Q?8H3Le/bSXx3Ge/vttCyPlI7ubtG5/+7Jt/K3gGdUgUjAx9nqcPh7xpz1Ec+P?=
 =?us-ascii?Q?S5E9cMLxXfY0hFrpvWBg/myNmSNEjkFXmtqQQ45cRFdQuCzFlrHSZad+I2rT?=
 =?us-ascii?Q?iDWXMU74nc40/xrOhqj5mrsZSxw8wAlN2xsScia+dwf0u+VEwIOnRnxud4hH?=
 =?us-ascii?Q?fi+XG6UTCXCF2A7JcPZoffQZtcjuDsTEpweLuNd+sa4rNeC1J4plBNNWUrAt?=
 =?us-ascii?Q?zAQpgx9Nw4hR8XnjjRY7Icft9RLKh1tjyedvEuuKqDESiw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O0t+a/LAvSbkcdyJjD/7piSSCIHEdnuOVnxMbp6FsLcx2C5FzKXQt2zJ03Hf?=
 =?us-ascii?Q?XnIriG56slvKWusJwqtdk8RYPSLIWNlM526Xa28zJeI5NFrO02cXonXBeMua?=
 =?us-ascii?Q?0Ca3J4HF/4b1Ooo60jqx9/nSGlrTrps0FLAGMVifqmAIPL6XW+U6K8tr5CsG?=
 =?us-ascii?Q?qOy5P5CBkLCsxRqKJ+mDhWz5me+FLDtzTgt3qrhaioUSz4kb/LmeRbivOZhN?=
 =?us-ascii?Q?7b5PqtgfHT1u/D3yQKYDGcOMs1wYC5WVUGq+6XCNRELoGXmPGOu2Xu5p4YCM?=
 =?us-ascii?Q?g1KUr1A4ziOcYUDzLJMY5rRjZTgC4FCmUfulAWHjxCHE/+8UuVO+2xV6cisz?=
 =?us-ascii?Q?h9XIl+ZMPd118mx3FyVRSzm8NESUAsa1DXt8UXShpbNgYSTECwcF2Cm1qztQ?=
 =?us-ascii?Q?kI9avs1pQrLR4gXPGLR6VOnCmvnFG5zH6lLvy+r8hZh4pSaPOOBrQ7Qd9s3n?=
 =?us-ascii?Q?jdt0XGAPnqfx31blIJaTx1dD3VXJFsp/3dtvpW71o2cAHQy2mScF5252/QPT?=
 =?us-ascii?Q?PueE5DfP2PE5vjAT8wt59cj3540nFTpIPGh/R2R8rpETYfJbMWXLyU7a5dtp?=
 =?us-ascii?Q?twpRxFjiTF4sWMaLv2TExft6uISREiKiNWC69/vqUiF3OhI9TaSlOl5h0USZ?=
 =?us-ascii?Q?nCS4SZtDLqixI/l4DD8led08unLk4lBch75ndU72oDYawHOW2mpPNXMDuzrh?=
 =?us-ascii?Q?Is1jUFWfGE050/8+UkhbYX7KkSxB5jmV0T2cs5IoOH3UI3LFeXZVrkVjpR69?=
 =?us-ascii?Q?KKgs4FeM2wwZxAXMVKp+ziS7wBu0jYia7uzc0vICruA/buVANhTsdftk/lpV?=
 =?us-ascii?Q?IGTFXD7ZohII3LngZKww/fC4A6pMEdU8EeS9FXYkf8S2w4DoWJ6MG31dfbEt?=
 =?us-ascii?Q?Rly7+jY6iYgUM5Ekl2Um7VGfUzIZjzyOkZaJUyzRtDy6JdzQ5FqLgM+1txVQ?=
 =?us-ascii?Q?QDJM7LhO2nHSiu8W3krFxcoZvRjIlh0vmn2I58Lo+rW9G9Ce26XkJ8mmyzam?=
 =?us-ascii?Q?smux5AGvMtx8IhKz3c4vMxvAVmkQa8lxC9IGmIAD/G7E2TyjxNUAw2DUjvt2?=
 =?us-ascii?Q?k8wAOoj/PBw9/E3fvUQ6x/KM3W4Y6c6trApsWhdTjrkSisWIkcxKzgR15urX?=
 =?us-ascii?Q?Yx6odzdc+PHZbzrFC6fzNUuOaGyfAAwwrvJUx5+0BjBoqbxfV0kn2XQ3r8pz?=
 =?us-ascii?Q?jQoFb17vAnlSOh3sRpVW47YODpKBil8nO2Ch1wmJx8yhF1yle7XqGRJdAh+e?=
 =?us-ascii?Q?T0qRS6apgi4b5t5sF9pk?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b53507b5-4e54-4211-2e2f-08de395e58ad
X-MS-Exchange-CrossTenant-AuthSource: JH0PR01MB5514.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 09:10:51.4586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB5266

The documentation for `Cursor::peek_next` incorrectly describes it as
"Access the previous node without moving the cursor" when it actually
accesses the next node. Update the description to correctly state
"Access the next node without moving the cursor" to match the function
name and implementation.

Reported-by: Miguel Ojeda <ojeda@kernel.org>
Closes: https://github.com/Rust-for-Linux/linux/issues/1205
Fixes: 98c14e40e07a0 ("rust: rbtree: add cursor")
Cc: stable@vger.kernel.org
Signed-off-by: WeiKang Guo <guoweikang.kernel@outlook.com>
---
 rust/kernel/rbtree.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index 4729eb56827a..cd187e2ca328 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -985,7 +985,7 @@ pub fn peek_prev(&self) -> Option<(&K, &V)> {
         self.peek(Direction::Prev)
     }
 
-    /// Access the previous node without moving the cursor.
+    /// Access the next node without moving the cursor.
     pub fn peek_next(&self) -> Option<(&K, &V)> {
         self.peek(Direction::Next)
     }
-- 
2.52.0


