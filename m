Return-Path: <stable+bounces-72831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F052969CFB
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 14:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF311F25674
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 12:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97C41C984C;
	Tue,  3 Sep 2024 12:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="af7CVuVi"
X-Original-To: stable@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2041.outbound.protection.outlook.com [40.92.62.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA18D1B9859;
	Tue,  3 Sep 2024 12:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725365295; cv=fail; b=k7p4P06lelvh7WCZaM6bSB6w8Ejwrtg4EYVq1f0HLkpD7+jPtqH8BHIXdj8mdBFEd+pEBzuQtesrdGJkcXnDv4rh+pvAmyDAHrOHkGA9qI2k7MkPiaEjZJetIRVPmaikC8IMchsbZHUAGyN4fs3yu0yZwlqhQnkpg0PU/wr9P68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725365295; c=relaxed/simple;
	bh=IvPTRavmb5ZE+LTDfwgV1vngL9K5YCVJqRgNKF97Sps=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=O8v7mlJASK5N6022ZVdHkzl/YCKoK4JgI7x9Ze5aScv0wAYpFRQXAA3rw/VIRXiX09CUZ7DLGi5x8L4nic9BgOLV+ptMoMkHWv2zw8D6ZgzM3fGD+SFAvgu4Vda6GcQSapbr/GFEyVUciTpkyHrj1zX451pJ1S2ioFtopEoDoJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=af7CVuVi; arc=fail smtp.client-ip=40.92.62.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6jLgNJ4iWM6VAkZ17TsYhcaHZeTCD68mSGjhV0xWBq+DY10RHjIdMkYn53aCFwxFgvi46+N2qc4ZbtaIcNoKs82S36Lul6cvsuitOfoQDKOzUFHtAJRsfthUd+WXpIcNvfIvgj3836/qClnjokORq7Vz0ZotngK/PCYJb7v0a1MXG+/N0VoJ8dg5y3iQ2KbAUFui9LBhXCMWrVei9jHF1siHCqr4Bdm0fcR8ynJyBbgmhcq5V64nf6UwDl1fWiICKddGkwD4iX8F6iVkwAKNRWstAfAHIKxWcxYsF14zUYO2LrWy4t7sFs0ITUYWSwvOdhR+cwzZzNef/hCbY0kpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzPmrfnypnTcXSOUzQP80L8x6QBskS0bYOPokj0QcqA=;
 b=d2CNLUMnnCu+FoQSIk9gmoTGzqzFBUlAxLa6aaBmtjpPRhT5lYVRV8g1HNXPGlc41zZqNISqFYAU+8Bs+5NtX1j3dSLPt+seg+PT/fQ74hw1Wnu8m8UlNvoYEgr3po3h90g3NCjXzeduNfnyL8SVhb25wbSFYUPEwR+2XBiqrIIPuVPCMYCI6uvzcV7mSAR4zPEK0Htut0DUmn69Zcxkvhj4UC5UyuaDQNFn91BCxTFZafWr3Khgn5xh+KjP/roCrmsgwI7lYWABh8sfy1OXxHH6LfFQGvxJ+oL+Cnxdxxdp0B5koNL8MB5vd8O4XS73/H8t2mu+OcPNllE9CeE2Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzPmrfnypnTcXSOUzQP80L8x6QBskS0bYOPokj0QcqA=;
 b=af7CVuViHBVqd2mfj+NtWxICtHJDd/40wV+LmNJHrxhNUVYTYqytr6OMEAjQcQOC7CQC2g28GeIECessouzsmGiLmAEFiqHsONbCFQgwONpzQS8ZkNXe/cG7CIGngtfnSN2lM7MBu60S2B6s+YVtFgITGwEUYHxHD0zBVnbUu4tvQu4WsmoTcHI2cRkqD4hzkZRs7wDeHeeFkPOVZOqfWFS2PszknkTYSTH+YyxrVmO+PqjI+HSgX5tzrEzpewsc7sSG7casgJXaWNGF6kB+q4MlVmiLDLMF8DFkOzcEAcTChL1x4Xy61p4LiCRa/6ypmzu070SfkCWg414bVjjeNQ==
Received: from SY8P300MB0460.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:297::10)
 by ME0P300MB0716.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 3 Sep
 2024 12:08:06 +0000
Received: from SY8P300MB0460.AUSP300.PROD.OUTLOOK.COM
 ([fe80::14bc:d68f:122:f4f2]) by SY8P300MB0460.AUSP300.PROD.OUTLOOK.COM
 ([fe80::14bc:d68f:122:f4f2%4]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 12:08:06 +0000
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
Subject: [PATCH v2] ice: Fix improper handling of refcount in ice_sriov_set_msix_vec_count()
Date: Tue,  3 Sep 2024 11:59:43 +0000
Message-ID:
 <SY8P300MB0460D0263B2105307C444520C0932@SY8P300MB0460.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [/Or3ZIGSRQMGYPg027de5+660G9Qy58PF6tDioTmqRs=]
X-ClientProxiedBy: SG2PR06CA0203.apcprd06.prod.outlook.com (2603:1096:4:1::35)
 To SY8P300MB0460.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:297::10)
X-Microsoft-Original-Message-ID:
 <20240903115943.8422-1-hanguidong02@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY8P300MB0460:EE_|ME0P300MB0716:EE_
X-MS-Office365-Filtering-Correlation-Id: 46464ae1-4501-4a36-4cef-08dccc111172
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|5072599009|461199028|8060799006|15080799006|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	IXMScY3PZE1T2+UpKP3SetFbyDG7kA+TflI3OLqMHLcmYDB47AInJo8IthheYfltCDrquj7+dD03xY7faqpltut4zA1G4yjq27Wb18Euf2KZTPAGGLgaLjCb3v5r/UpmjmDAHHxfzbhhXaA5/k5twRZVt8iuEns5hyPhUqEcPXZ5OGth4PH5EYsEGtdNxxqIpnqMrn+2jfbfhbp83w0+K8BZswXAtmLZn9Pt/Vn/kRrpyuph+KxidaSOvp1+1YqzDBUGNxHTg7dmd2ghPekZ74hVYv0KVZ8kB+xkABFZUaxyslVsf8D2fLBMrSa4kEBdAGeN4DI9HzooRbv+QRx6siDRVqW7IRM+bhGet2nOhwEZIC6jKNj/yFbgU5KYkgDWIx/sEH/2vifwmpmh7GgTHZivI+4UR9DQufnXsrjAu9zdL1DfK4oP6Ux2cDLlDDV2Jm3NsBnXs4rZ8bl37lcxcpe+MZiSZC/Mnoek6W6N2tT7h7AtFdG3BnSgc26uq8R/GT8+cptZWg4pj0YC3pGtYV0iLC8Uh4p0xW7dOuN6i3JzXiXNmERYpeHXh765ExO4WWuUv2O9CG1fgyxgEq6nqGWtZ6Vb3vivJrfcf4pYdBEHWN3OF1/grC3TITVydreeKwLwoRz5+AvaEOTtPRUE4av8P7hgfhAs3btxkfLUPM9bUvv5lRHFjnPSv6YMk3NcvkSwAoSvcyfeiAjmzZFvx3lvLV8UIbjZqqTgoUTptL8=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9WWwcWEsahlxARVjlTOGXA6uDPE6GlRfRy6OoRz15mhc37ms1hvH+ZdRDR+u?=
 =?us-ascii?Q?cRC+8FweK45auvaSdJH2GgZPOLd6Kxsx15fDljwIs42swnOZcrNve/iSKe3a?=
 =?us-ascii?Q?FKHb16ZJVZZpy/TxGKW1SZgpI8UIK01Jt/wA7jXVxgQUdLB2buiCEnpejF4d?=
 =?us-ascii?Q?4VpbJeRZiV78HQm8FeuQ1s46DKytZwabydxptfR9yOHVgWC/6tMcv/WYpJRS?=
 =?us-ascii?Q?BzDrHgZeEhA/eJq1GJc5nELDl3Qw5bDb90WPoGe5q4JFZmMMdbVKVTdfJU92?=
 =?us-ascii?Q?rdHSolNkaXuuKHzNTJiefViUJOz85S395jpYzrGu6y+AhGAShjlEdYe+wBXl?=
 =?us-ascii?Q?iVSj0LhplQc6mWGxRUbzJhe7ZAmwlwPHvRPQ+eXYw8e4Q9VsUU5DI2swHzdE?=
 =?us-ascii?Q?DXXGpSvAjm98u1hS2PJXA9zNrwIgNYEbXZChePXNk2WzpoYxLFXAqOzHmxnJ?=
 =?us-ascii?Q?sce/7bKtCzt79NL6vO7HPMd5GxqDLjZT2KF/B3tnwaQIVEBxgXXVys5O3OOQ?=
 =?us-ascii?Q?n/tI2QrbwJn/EhUVZgsVzvJ9ndZjEsT1U3QKegzDur9B+izBAX1ccMV0PEtv?=
 =?us-ascii?Q?2oZSGi2BYbV+2ghm7XHj7hKGrAeB3mT/PAR14wMmlakkMnyERYFCnhGRgOug?=
 =?us-ascii?Q?y8a/0TpXbrh055+9Q1wwb3iUu77q8FYKrjwiJw49GthHuIuT1gv81VnFdJrm?=
 =?us-ascii?Q?K0F5F+3ecFxZZ18Ovxf5wAet3q1C7olhSFrFRmrZ6RWJox1fTffnlHBFlGsf?=
 =?us-ascii?Q?afFszeZI/Ecq46F9zFIpTqs3jn1AafOPzPrkCV5lHBjUR5bunpzdMyki9/GZ?=
 =?us-ascii?Q?gz34vfaZ0ri8wYIqmg6TO48kmkXY4bPiprrahaPyiXW1qapNqy2nlyv0bqO4?=
 =?us-ascii?Q?X4BlkqnbL+JO8srS45T9hKOUCG8lODoxQacYngY8cVdq/lofVwb0+/CKyz8p?=
 =?us-ascii?Q?vjZa0Qx3Co+wPcIeGfyzgvEfIFCOjQRKOVBjzd747bbJh1HCcdqi8cGstJuO?=
 =?us-ascii?Q?jj9KsVEqwiYOjKFquZeVWLdaIwIIZtfEeqxvCYzGkRjY6VOzRe/1PRUxRGGx?=
 =?us-ascii?Q?MTb6C83pPyr25hZQe8N9zdRXxgBfdtBRgS1VBbIPrRzIrnZDQIoL+My8LY1X?=
 =?us-ascii?Q?WB91soKdJ/eQo4KcJbksppB58bIQHajc2Z8qMSZWwRIQSeQCdMDbYzfZkyrr?=
 =?us-ascii?Q?WmrueBBPLcd2+bVLjaARC8u/KKOqceQcSDYRap+fSHfp9rj4i1jjgjf28d/O?=
 =?us-ascii?Q?QbE704EEsfhymYIPzclR?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46464ae1-4501-4a36-4cef-08dccc111172
X-MS-Exchange-CrossTenant-AuthSource: SY8P300MB0460.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 12:08:06.0582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB0716

This patch addresses an issue with improper reference count handling in the
ice_sriov_set_msix_vec_count() function.

First, the function calls ice_get_vf_by_id(), which increments the
reference count of the vf pointer. If the subsequent call to
ice_get_vf_vsi() fails, the function currently returns an error without
decrementing the reference count of the vf pointer, leading to a reference
count leak. The correct behavior, as implemented in this patch, is to
decrement the reference count using ice_put_vf(vf) before returning an
error when vsi is NULL.

Second, the function calls ice_sriov_get_irqs(), which sets
vf->first_vector_idx. If this call returns a negative value, indicating an
error, the function returns an error without decrementing the reference
count of the vf pointer, resulting in another reference count leak. The
patch addresses this by adding a call to ice_put_vf(vf) before returning
an error when vf->first_vector_idx < 0. 

This bug was identified by an experimental static analysis tool developed
by our team. The tool specializes in analyzing reference count operations
and identifying potential mismanagement of reference counts. In this case,
the tool flagged the missing decrement operation as a potential issue,
leading to this patch.

Fixes: 4035c72dc1ba ("ice: reconfig host after changing MSI-X on VF")
Fixes: 4d38cb44bd32 ("ice: manage VFs MSI-X using resource tracking")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <hanguidong02@outlook.com>
---
v2:
* In this patch v2, an additional resource leak was addressed when
vf->first_vector_idx < 0. The issue is now fixed by adding ice_put_vf(vf)
before returning an error.
  Thanks to Simon Horman for identifying this additional leak scenario.
---
 drivers/net/ethernet/intel/ice/ice_sriov.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 55ef33208456..fbf18ac97875 100644
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
@@ -1142,8 +1144,10 @@ int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
 	vf->num_msix = prev_msix;
 	vf->num_vf_qs = prev_queues;
 	vf->first_vector_idx = ice_sriov_get_irqs(pf, vf->num_msix);
-	if (vf->first_vector_idx < 0)
+	if (vf->first_vector_idx < 0) {
+		ice_put_vf(vf);
 		return -EINVAL;
+	}
 
 	if (needs_rebuild) {
 		ice_vf_reconfig_vsi(vf);
-- 
2.25.1


