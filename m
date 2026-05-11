Return-Path: <stable+bounces-245328-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAuQLptVAmr3rQEAu9opvQ
	(envelope-from <stable+bounces-245328-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 00:18:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BBF516ABA
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 00:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC85E30209CF
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 22:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0061134751E;
	Mon, 11 May 2026 22:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DlmP9YOF"
X-Original-To: stable@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011027.outbound.protection.outlook.com [52.101.62.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583A03CB2FD;
	Mon, 11 May 2026 22:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778537815; cv=fail; b=QioJkb3bzlSo4cjOgI13cGqO7fneRwpFgLMRRe1SjrjD6AvswUUTC+Rt/WlXSebJkH4p5EKh8KmH49hDFD5GlHx77ckLZHV3WLP4ZrC2vdtQFvoMv3GdlExq/z2Ww+wcOK4lnv3FwLan8qOogC8mPSzZXh70n+tiAENPQuPnM6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778537815; c=relaxed/simple;
	bh=WT6XdtABcM6qpeW1fmJnt9m48jTOU9/WezB+CdIW23s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GryBLbdgOD0bl/mmR+kgpAwazc9TwqGv7zktz40+d9MpS3FlAV61luTmfDzzaPUmwganD4cWKm1f9AdaE1vRecs6kwzVvoBgUlto4yO1P3vQuwiQ5+z4139ivT1KneqiM71JmpiFfZjtkcchQn89Fww/k9t1kY5LhCqVO7hT1jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DlmP9YOF; arc=fail smtp.client-ip=52.101.62.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTaZKwyJB0KI0ZKeSiV/EHckErlc0ZhxlXVNObRqxeDZUR00Wlshmw59h9f7RG09T/OQbGxURjrwmqXuafJCbDXkkCJ5hjqCXjMZytadf1C96jEJvgY+3pezLc3xvPiUEdi0rC/1sC+CUfLRTA3OzZvbJ/oj5vzC2ELnNHfTrwwaMnwAEzFFyHB0V0nP0/vwyqVMSpm9sr9UdTN6XoLzm2lWTLyv0RO1rQJlUtNA5EYzOyLlFuXdqjK7XkmEI2ZYjvVeox2y2Fv3LZzo32ox/LqGqv+j6miKwnPyVqbC2bJYpxPh8x4loQvbWU/X1T6HzDMkc30/1s9Mp1PLrBlwmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPpoyFXRGcYcd8vm5fTAbnjlvB8triHJU6M5VM4itrI=;
 b=WmIU52z59xkIE00+nQxCUXLtyL+uqIpLnvQRaVA+Mjyyd1H7SoFG5KGLOp+70fBfKpBgHMM7gA7qHgAen35HnlsA7MswAQY8I4TRDUHDRpI+MOyGANOorKgzK1Qtld3lmElP3YoqizcyrafU39/97GxmkvvjUFOdlEp6vFFro4lLMZsAHwJ7duE7msNPFI0eaTAeyZ+COiMu9IVEB7q0kBz2nVcu5BgPhoqKVx5G2VSTnx+lWFE6tKQ+2z+i/O6WlkAYUwyf7hur8JkUosotiWj8VAGu6u5WjMgaBhWLE2TYgMu/XXgxx/uN3xP1AJyJOdX69x7KPhrZFIIMIbZM9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPpoyFXRGcYcd8vm5fTAbnjlvB8triHJU6M5VM4itrI=;
 b=DlmP9YOFXOMivkjw1PR6rMMuVhBlfOcVATm7dSxtCvf7Z4Lh8GvbSfkeTwRbWV02nJGD7d03dAuHR3fv5vx9h5qIh8KjCYXP+U4+2laqLe9oOeslXPY+bIXQIPFKN/VZcc6rNsMZOOxhKlEfRZOwPY6fChFgHnD8VqAA5gwOv8Kh9lHw7WL5uVxsopHSY4ojepRwPab6ANTpS7X/tLla1e4dfaeoMTclUjWugxSPiYn4h+dAm8qlDeG/lIb2Ez7L+o17srfm1rO3IdyxLKedtCwVeQZK0issKcJxr5MkqdXurZTOTWO3go+V7CGijbVGpS+WJR3ZoHWb0hlBG7zLkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by DS0PR12MB9321.namprd12.prod.outlook.com (2603:10b6:8:1b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 22:16:49 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%4]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 22:16:49 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	kvm <kvm@vger.kernel.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Yishai Hadas <yishaih@nvidia.com>,
	rananta@google.com,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] vfio/mlx5: Fix racy bitfields and tighten struct layout
Date: Mon, 11 May 2026 16:16:03 -0600
Message-ID: <20260511221609.3837652-3-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260511221609.3837652-1-alex.williamson@nvidia.com>
References: <20260511221609.3837652-1-alex.williamson@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:1ca::17) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|DS0PR12MB9321:EE_
X-MS-Office365-Filtering-Correlation-Id: fc949ab9-6188-49b0-f816-08deafaaff53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	LBK8mWrmH3RqG3AH4TOOdxCSLe7/pSXrsa4bxAfOAu69b6zaBz/60t8GphEgrZiwOALepcC1U+ArUYZ51iMQi1bw1yA16IsP0FdTRVWbFEkDHAJFJR3qFj75AL8MDpQsNkvCyhDjd5OQn06ucGNCZMspWqpvHTwaGcpSfYSpvkiTMkoEOsWT1dTunnewcPoRrwueKcnIXqNZEs+PnIgbkjiovDK7Wczr1nVZdLUtp5tNjPc8dTkqsPvOoA1llUOwHQ5RMwkNreKDTBpeuJq8xgse6M9fNTPaolLXps49vX6hX3LxOC+KYQFKxsyJfOfn6Wl5niga5mRWjF4k238zE1pNXYQKE6VIGPEO1ukX0DNYbw3W06AJfTjY3gM2NjgGGnzyYD4ayFrQgNIXCgHi7zvDdJ+3r2BWkPN8oJUemDrwjzNmbI5yg9gHBYCEPJG+hhqx3tHGZgRJrJOvKJEmFxYaEdSbbzGcD4XY6Yi+Ki+dSAACEGUPWejrs9jBHM55Zp5JU6rvTYv7Z14SZaOR4KJ4xpzNSN69tbBkLTXmxdxSjMbtFVm5yXFTa+5UPp7ELf7ty3nAJm5P2F65LMsVnb2gU0GQTbxYaZ6Y1DA3/yBdIytjh2hHfJEO3BTF1L7p3QvrqwxlZIUNNrhiTwkEcn8TZPQEgLjj+49rv7awqVh9clfrjNECQpxcUnoFozhS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(11063799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?29PDov8EdzG/cNFAqqGwRC578M+9dK1EhjfZ5hZx9YbMwhml/AB26rHRSZ69?=
 =?us-ascii?Q?5nibABQcVOQAJpqHE3zo4lRyJl9q5ktQ8rRXPbLEifPS8YLXQhj842u7ePgs?=
 =?us-ascii?Q?Gk8o3YjVpr2fxNbkKiYxJJOhBX1LEvC2eMpZ2YtYrXLleSg/5kYauuM5dFuK?=
 =?us-ascii?Q?gQwyN5kpHiCrG+wzCTS/VT56OgdhF3q0bzWw0hmPnERvzqY7gJ5LgqPKV9YX?=
 =?us-ascii?Q?ukhqxUREA2LZ+lVX12oQO/VJqqzwrI7XCAvCjhzdn5Zu8VVKJB2YB+Ve14S+?=
 =?us-ascii?Q?leMRsM76JLAfMGkMrYMgTILna7T3FxhHDkk7n4y1NlNL+DN75KwnaUG+jONa?=
 =?us-ascii?Q?euDeuSqa5W0rkXTBRbutVp1P4pjfI57egPuQ6nCk+YOs/yLaPbQ28qjfpIPl?=
 =?us-ascii?Q?oTBVHc+aomqTT7f/jIAaaH+pgU2j3h7ravHyI9wwvajXfsqTnQEP3L2ktFLE?=
 =?us-ascii?Q?PxehgzL3ORlLaEqPuHdH5Btt4TYlmLh9AE1TdIOYvZSLovRpMcK5ypxPRZwR?=
 =?us-ascii?Q?bRlzJuZoJxrBwBpF9xUIVBd2DCZMFBJlbReT0/gPQrqU5Igr5tbg6YvwXD/e?=
 =?us-ascii?Q?TftDwwFoQW/FmNwD1mEJt/jkJllSzdnPopffp46ekUkgf9W0lTpcn/Qt9YzN?=
 =?us-ascii?Q?aNQNyBRLS8Ljfq+Pzg8QfGjuIExb7GjyMThZjYMZTPQpzVi9gLt/+WSOMAC0?=
 =?us-ascii?Q?sqaE8lNzkuEIw3bZaFHKXnGQKNupEumu89rIsFaZTrhSuy2D2Bjd3q2mcRgR?=
 =?us-ascii?Q?PBdf+vttDTUk1fbRGi3snLYBX4ntKKBBb/YnDfqlDAX9HphnPjpWJFEXiJ4E?=
 =?us-ascii?Q?m57bNErDD+mLGDp3LboO4MkGNFrnQGdG2lNwCmINcsxAMXmbkq/8gMlQqs/c?=
 =?us-ascii?Q?Qx4BM03/MS9xOMVKLwsMZnMG3FcNDmbviCe3av4kzltIuEJ64qAD4U50pc2Q?=
 =?us-ascii?Q?kLHFQfBOvRBbde2W8p0NzUNDdkagYXv8+SlTUQhzLeW83FSlhWLMM/cvDOF2?=
 =?us-ascii?Q?4hWaBE2cHnHIqz48BMmhDWxLTmNQWOK9FPwTm2tVlt2FhdhUaF99BqTP4TZf?=
 =?us-ascii?Q?WrxDH2XvKCloj8Rz7COFx6GA18IhfWXZ3L4425VM3GrNUv7UP2jgpVu7KQzz?=
 =?us-ascii?Q?QXTeEbVU1iNl+dP0bUvPLpUPBLCzLg3aMucGQwZ4D9zIJScZrJqkX9S59HNJ?=
 =?us-ascii?Q?Ca3uMCIYzoOQuFy4fpBMtXMtG3Ay4B5E6zyC2AGyNO/qjQbnFQXFAiEFEAIU?=
 =?us-ascii?Q?5tM+wRQ03u46ZDM45PwjuuNSM2IqHtl2ypmL2VZy+m69bfGotCKEhVisKHwy?=
 =?us-ascii?Q?4mipSTuLE8c0fdeDsX8FUcwbHyTP7lFiNVP4SlXre1oEZfJptoIJutOfe1/R?=
 =?us-ascii?Q?SBgLealoMM3pkO5gGK33tPf8Q+nhuqarsWx+G/4zVpHgb6SC2fx/jb8irVsl?=
 =?us-ascii?Q?uLzMYRn+zVLvCbSd5kSFRrt5WzzC/Sb7KJKvfa6SOPuv+mReeCUbm7x2ugnP?=
 =?us-ascii?Q?70b6tgZZM0dNFUCRZluZw/CfDXZM7FTeLt6+3HSeqNrYy0oFblrtBULm6ORz?=
 =?us-ascii?Q?dLfWFwx3tRrAbxEnbC4sMPZ4jUrBeXjqslbe0v74hjuiUOFdbk/nfNq3sOHl?=
 =?us-ascii?Q?LxuSRYH3jPf/5A55gKZ98HscxU+TYYSdn7ofG9yZ/fSxhwTaA2P4GaL3/jUQ?=
 =?us-ascii?Q?WuVa5OwVdvKKQJroU2hQzFwZBXi6t/4G9VS/RQ0oNmTNxk2xA5yMRiUUC0pD?=
 =?us-ascii?Q?hBuqgWl4ow=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc949ab9-6188-49b0-f816-08deafaaff53
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 22:16:49.7385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fC/TMiMEtBRLVSLqydp0pTtVb7PyfQOCuQS68/7fabKb3cEdPkJTZKUdqRfXYLv64I9ZjWRnURZD0LZFlgfAgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9321
X-Rspamd-Queue-Id: 27BBF516ABA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-245328-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex.williamson@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Bitfield operations are not atomic, they use a read-modify-write
pattern, therefore we should be careful not to pack bitfields that
can be concurrently updated into the same storage unit.

The split fields (is_err and object_changed in mlx5_vhca_page_tracker,
deferred_reset in mlx5vf_pci_core_device) are mutated from contexts
that don't serialize against the other writers in the same storage
unit, so a bitfield RMW could drop an adjacent field's update.  The
remaining bitfields are either probe-only or share a single writer
context, so they stay packed.

The page tracker's status field is also relocated to fill the
alignment hole the split exposes.

Fixes: f886473071d6 ("vfio/mlx5: Add support for tracker object change event")
Fixes: 61a2f1460fd0 ("vfio/mlx5: Manage the VF attach/detach callback from the PF")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 drivers/vfio/pci/mlx5/cmd.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/mlx5/cmd.h b/drivers/vfio/pci/mlx5/cmd.h
index deed0f132f39..b782139eb8be 100644
--- a/drivers/vfio/pci/mlx5/cmd.h
+++ b/drivers/vfio/pci/mlx5/cmd.h
@@ -158,14 +158,14 @@ struct mlx5_vhca_qp {
 struct mlx5_vhca_page_tracker {
 	u32 id;
 	u32 pdn;
-	u8 is_err:1;
-	u8 object_changed:1;
+	u8 is_err;
+	u8 object_changed;
+	int status;
 	struct mlx5_uars_page *uar;
 	struct mlx5_vhca_cq cq;
 	struct mlx5_vhca_qp *host_qp;
 	struct mlx5_vhca_qp *fw_qp;
 	struct mlx5_nb nb;
-	int status;
 };
 
 struct mlx5vf_pci_core_device {
@@ -173,11 +173,11 @@ struct mlx5vf_pci_core_device {
 	int vf_id;
 	u16 vhca_id;
 	u8 migrate_cap:1;
-	u8 deferred_reset:1;
 	u8 mdev_detach:1;
 	u8 log_active:1;
 	u8 chunk_mode:1;
 	u8 mig_state_cap:1;
+	u8 deferred_reset;
 	struct completion tracker_comp;
 	/* protect migration state */
 	struct mutex state_mutex;
-- 
2.51.0


