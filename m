Return-Path: <stable+bounces-71514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C359649C1
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 17:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57362B22759
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 15:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998D61B1D41;
	Thu, 29 Aug 2024 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="cSy+bddE"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2135.outbound.protection.outlook.com [40.107.20.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C721B151A
	for <stable@vger.kernel.org>; Thu, 29 Aug 2024 15:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944683; cv=fail; b=ID1ppaniq4YBbmDl6tO5CNDPCrYzpix41abXkbgyY29/OuEBFLvZ2DeC0K1aseHsDmhdBoJN+Em5ozwMN5zJi0aRuecTWp9DwYajtepNZtSGryCZLzscpxOy80MQB+50cBGQqKZIa4I/CZRJIZfejPXzygMzt47M4PlVJZ0+hmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944683; c=relaxed/simple;
	bh=5a3Gbxc4fPSSeE0FruzoAa+wPcznDFDIwFSiol+27gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YlhDXWGFxNVHMhwXS+YdmmcnqO/Z/qrkwtxxK12zkHCWReVvIA6skTWTvRXJzIpayawCoQHimInI2B9lT5jr7Q2ZeXCOfEJL617GCsW65bVt3N5nz/cU7V26l+JqQVUunrJQHlP2/SdWKzQ3c56L0a79+Cx9du68oZ36LgauaTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=cSy+bddE; arc=fail smtp.client-ip=40.107.20.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RYwhQE+VOfMcZ13P/8a7360ionuznliyHq6V4mfPuijKhjarfenfX2WxCO5neDaP1E0AlPaGwHGgcTYNjUB9wUXWnC+Um2zxd1bsGFVlmHctsvtDi71DxyNK77VgdNJKyiUK9/39F3aA0ECD1vtRtH6aE3sZA97ngR5ctH7RYjx5PONzA3oSz9ZvsxG85nvuOzPu4zchjUOxS9wMCZREk8zhRxldzIUebEsX58QKIlMvGsBe8BSJL5gvfXooEE5ei109Nlp5QfP/aitV0HUJVf4iDM+Oxt8WC9IxYTyPF6USf4okWbbqx9GVDrIJPZ+xScYE7L+kjN+w1Sx4gjpe8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MXFzUjNUuPvgG5kHbMADS7/SVI8GUE77VbEzMp9hCo=;
 b=Av/3cjuFOXTty0GMhqOQwu1+cb8MuCWYDUV0/Re5Uk9DKZxefHXfh8T9oDtvDTg3zFmgJatPMeg2FJzNRLkOQepXIPnvhuzMN6Zmvk1/YIWh0yZ5tJNgnLj/LguxtpSpCIMihtYgYCGct5oZcc3w7K68ohZFJoG1AtB8lHQFslSftuqg033X/4liUS7TKDgUjU5zvxjmiQ9b+sdLACVQd627EipYjuUamYNl0HFFVx5bbv3ER0uBdsTnzFLNb2z4A1FV/WD/M4TespHApktXvJMR1DV3FIsfYbAu4JK/FkJjf8RaZFXRWwGn7BqMkcvIICLWdoDYtC5B1aPQlmUAYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MXFzUjNUuPvgG5kHbMADS7/SVI8GUE77VbEzMp9hCo=;
 b=cSy+bddEu0Gm4FVpx6tZ45h+s5vk9fyXnRVvq0RikdM0m7RrMdH51wR2JchizPTfKKCox/piVR0CSdmN1KxJcCDFZUNmFUdOqgxalb1Yp1VlgRDgpbZT9N2eix5SbPm/C4gPtpObB0zvQRerbN352i4XdaQkWSkHCuGX9auo4JiLhiOjUQDbMFFFKUX7xVDgChNlVcQv0bmc2vnQhJ3jTMIlFwxwzh/yCkeTpdDrOTOMh2hfjORV5hb4ai1f+y3SjGYqfAF8C0XgabkWfVbY+ObOfQbiTwKGLWUqdCFwwHMKBznRuCDZX9btVP0oDZXyg1emTmzSeNjS39HzBKEf0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by AS2P192MB2266.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:64c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 15:17:53 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.7918.019; Thu, 29 Aug 2024
 15:17:52 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@redhat.com>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH 4.19 4/6] ovl: do not fail because of O_NOATIME
Date: Thu, 29 Aug 2024 17:17:03 +0200
Message-ID: <20240829151732.14930-4-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240829151732.14930-1-hsimeliere.opensource@witekio.com>
References: <20240829151732.14930-1-hsimeliere.opensource@witekio.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0076.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:349::15) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|AS2P192MB2266:EE_
X-MS-Office365-Filtering-Correlation-Id: 7769a4ed-8dc7-4a3b-b91b-08dcc83dc08a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+5OQqXUN5xz/JqmIcgOkyAwNxTPqIC2bFj5MKMQBAWLahSqdCt/d3Q2LSBDs?=
 =?us-ascii?Q?3Ykiny8HW0zk3gRg0aq6AEDghXXJjmsHXJL9KmNacwZy8H9Qlyw8oTzjMf7m?=
 =?us-ascii?Q?h8WA3G0tlbofcJ3Us1ZKR5t4vFTOrgZ5ndjRWr2AcxmckfkEd6rTyJN6DFuU?=
 =?us-ascii?Q?1GxWsEQlc7UEwd1MYSIjimeryPY76CpHzN3xYqfzxGrMcP33bxGhQuB34jWp?=
 =?us-ascii?Q?IjQqzgJRkJP2Hfb8bF89JaDegWscAEQEqnW4SPURHKwL3V2l3ybOuCtyqV4o?=
 =?us-ascii?Q?G8h0vav83CCQJ9Zle+inu6q9DUq+QIfWwNEM3yiqVVrwHemUWngUq4TnIHwU?=
 =?us-ascii?Q?VM8vp6723RDGkddihbogGHejEut8qBP2C6T9aMSL+eZx51u+Qadt+7pfopud?=
 =?us-ascii?Q?MF1ICb5t+3VYYtiBJ/yJX1JCrpg8DC7xYZx6nFMk4XYW2WYLgo2cdTZKXzmJ?=
 =?us-ascii?Q?MW6epRuhUMw6BVm1PX+1ipUAYZ5nVEJuC52Ipr2JElK1rDcAbRBtn5eza6tl?=
 =?us-ascii?Q?GeTA0AEDUsadvvkWoCnmH9Tk9n1W5imwpvHvF9XZX/h2m/HrSq8EG/RKtnY/?=
 =?us-ascii?Q?LlgNAmlQum2xmKABfKpuJS0xgwKp6QqYCSukJemxR5/+ZS7rro3JBtzaiERs?=
 =?us-ascii?Q?yI/pYXgXxl4PbrSzHj99bGrHF4rl8iWNwcnQuR35q3zu/Zpe4uKt5EKWsNhe?=
 =?us-ascii?Q?2SQNmj3AKkxBm+njjfZf0AErzju2TCWYiq9JLHBLgi5WHEMemfKP/4VkMiTz?=
 =?us-ascii?Q?pBeHXS965O7WUOZHw0EWBUCwcCzQBmmKUkhUuHkJvXPfX9Jjf1N2RinR6Laa?=
 =?us-ascii?Q?oF4uqZ5T3CrDBg2stQ+poH8gLF6SRSD8P1v4d3g25RQqq0E58N+ZyGCvQ/M/?=
 =?us-ascii?Q?eQmyV7w1FQZN4MkNAIYBcQS6BuOzrfXBUgfy/RBjtMRfr5r9lH5G7Ubg5rjk?=
 =?us-ascii?Q?F+1VTaAFGvs0QeIz+UYhkTOYRpZHImFCKl1ojVH0NA25AU680QdeBs74qgju?=
 =?us-ascii?Q?QhWHE0qwV+e3+NDjCkaE1uPnCYHtU4A4Tgobsx5sCDCsEmkLS/4RiKM+W0v7?=
 =?us-ascii?Q?mGL2qXyiXh9+UcgewQaH5cV4w761P9akoILIwF4vMYMt8R2zSIChGELCLTZQ?=
 =?us-ascii?Q?BPFoPNbuBMkWTDo/nfNqn8xlAEgEug1NWNpohBJV7vfyFBWtJA7Uj2BUt3LL?=
 =?us-ascii?Q?3SKCPYSQhuK3Gd9IXz+4k0XuScDegyk4fZ/MDWWPHkOGke9nAMOxaKz390yM?=
 =?us-ascii?Q?qzctpucmIRatUQ5UjwO2hddf3lWuSC66oQ90MeMvcZyF0TbGqTKGPGgoBPkV?=
 =?us-ascii?Q?03f3eK7/p1fN7YO5jYpPVywo8ngAMDvDV2vleJv+F/zOfvOJ6UnmF7sA3+7U?=
 =?us-ascii?Q?6EfS7oCfDKpTWXUxieaI+X5PaoLO1uF1v5eYLVM0yRq948YdDg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eCqJL0rUJ+MvIO3oPWt3LUcoMJhR2iskyiKSDWyv/ATbfPvPmn4VbFbDyGDF?=
 =?us-ascii?Q?7EiB8kQFw2kYUjdBgQ4cpUrCQdjrRTBT4B5H3jWku/Pso/4ssPtGvkNYJhn2?=
 =?us-ascii?Q?jt6JfWrfjafuZPzWUGtdx6f9xheQP19xwHmcPAY+efjbSOOHz5UBF/t4k+RI?=
 =?us-ascii?Q?7N7GVkm8SX1Wf0Y19qziB/nfUF/vetTyzQjOe1DdXtNM+6msVf1yapNx1OVm?=
 =?us-ascii?Q?KBIAdQRMFxiSE7LSpo5mp7q626dU7VIFeO5AvvB27YIbCrRtBX5rdc0i292g?=
 =?us-ascii?Q?wTJs3xYMuuVWR7X/yHlS/Sj5NGooPvN3bOSd5V5MGAJySonbZ7k81iM81LJH?=
 =?us-ascii?Q?+LutBLZhGzWZdfuNOOZT+lE2LXUtB7BIsaIaj7ycQuji5GPz5ZPia3qKbtUH?=
 =?us-ascii?Q?ovzVqb6zIttc9lZuwmtbs2ZNEM5J8pgZBXH6kblsZW+OWvgzsslBp63Q8jc1?=
 =?us-ascii?Q?bjTX4Nq6wAPQY2YcuLqhHSm/eDhXBxQ/ELfqQZOA9Fu/GrLZrZOqHUFomwSO?=
 =?us-ascii?Q?hvgmmp/XvkWnRbGi/ZuTeATBKqUtL5Pbdnw6i6FAZeqe1gswrZJfJRRQJblC?=
 =?us-ascii?Q?iv2i6e2y8YSvDSmVJhmVzTAV0DHq3VyS+OBL98XY/Zk86dP35B/+PkLCeZVq?=
 =?us-ascii?Q?5UZcfX08KIv0Uh/dMdoeJZ9aESP8XCOa9tfLu45LToZYhLNuQqS+YEG/ivEQ?=
 =?us-ascii?Q?INhGXHJfx9XTYfYc0ehUQOpi4O8rZG4s0uZe7dsmxdgFLvAgHU0lRdkk2xlT?=
 =?us-ascii?Q?TlHBlri8Yr2TBnR8gX1WFVk6puF0QCTnLjWc/RmYfoc652BCFw2U5EMCbCjn?=
 =?us-ascii?Q?LgQ5c/zPVih9zCpNZdAPjdtyUXyRzlNQulFiIns0LcvUpwj8l6key9nUqZBJ?=
 =?us-ascii?Q?q05R2HC+HuhCGF+PI6H8OyY7tLMGPKXPvxv8dggl85uVhLtbbEcfY5oUht5H?=
 =?us-ascii?Q?a95nABgYTrwAOExX2b7qQriUjYWyFGZF0LsndwJlJR0MBQPythNYPhWg/Akz?=
 =?us-ascii?Q?gzM7Pt8ouVhIoadoPV+l/Yzxm7ROqYrpcmdCrtf35zSO4tz8MDi+ZYpNQM/d?=
 =?us-ascii?Q?hmuyGFaMLJz1F0TA1Vz1Mx6zDRHEdf4yyCmAPj8S5ie5n7yljnEnooSF0ypi?=
 =?us-ascii?Q?TS2ngdTmqz0YRtzaUiOsbmjwUFv0OCoqGM6c9cCttj7oZAfT55tzdDV1b/Eg?=
 =?us-ascii?Q?nAT6jBOjCkZtJxLSU6Zxa6kxzjZAnk9mNyzayvz2HT24h5RtUOewa3mnrB9T?=
 =?us-ascii?Q?d7/YlKUZbldNdaBmwVfKDQh2psXpVFoP81oL+UNiElIILGxN5AOKG50/Vu5r?=
 =?us-ascii?Q?aXQYEs3h04NcTYrts0ucB0q/TtWwV+wmD2J7MR8IzLi7U9D+gpsM6pa8o4SS?=
 =?us-ascii?Q?YX+OQeD8FWXN50K/9DJuYrL3kYy/vXE19EcjES1k+VcjnKahATUEp1QPNDTu?=
 =?us-ascii?Q?EyO8UzjI5GHl40NLZ4jUuAW+qU0JszgGwMbPADxdyCz3KZBNi8cIW4lUfjKk?=
 =?us-ascii?Q?sX/Sl+xOkomuT9xavUh7qUEeVUvVEPxPE3rFLbt4atl+TJHaxvbZQczV53p+?=
 =?us-ascii?Q?xi54m0bnTSUk13jX2ESO6mt2NsEJDsd51aLcWIt62X/K7zMrSOyUoo6L7b0u?=
 =?us-ascii?Q?xw=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7769a4ed-8dc7-4a3b-b91b-08dcc83dc08a
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 15:17:52.9491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k7meLR51hfyvGGyHyY8+6lT8IDoNWh1FscvQZQ76tPGvhVAO+P3ItzBSXNZ0Rsr+EM7gWXyNhAeE7+JPIGTpEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P192MB2266

From: Miklos Szeredi <mszeredi@redhat.com>

commit b6650dab404c701d7fe08a108b746542a934da84 upstream.

In case the file cannot be opened with O_NOATIME because of lack of
capabilities, then clear O_NOATIME instead of failing.

Remove WARN_ON(), since it would now trigger if O_NOATIME was cleared.
Noticed by Amir Goldstein.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 fs/overlayfs/file.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 24a83ed9829a..65a7c600f228 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -44,9 +44,10 @@ static struct file *ovl_open_realfile(const struct file *file,
 	err = inode_permission(realinode, MAY_OPEN | acc_mode);
 	if (err) {
 		realfile = ERR_PTR(err);
-	} else if (!inode_owner_or_capable(realinode)) {
-		realfile = ERR_PTR(-EPERM);
 	} else {
+		if (!inode_owner_or_capable(realinode))
+			flags &= ~O_NOATIME;
+
 		realfile = open_with_fake_path(&file->f_path, flags, realinode,
 					       current_cred());
 	}
@@ -66,12 +67,6 @@ static int ovl_change_flags(struct file *file, unsigned int flags)
 	struct inode *inode = file_inode(file);
 	int err;
 
-	flags |= OVL_OPEN_FLAGS;
-
-	/* If some flag changed that cannot be changed then something's amiss */
-	if (WARN_ON((file->f_flags ^ flags) & ~OVL_SETFL_MASK))
-		return -EIO;
-
 	flags &= OVL_SETFL_MASK;
 
 	if (((flags ^ file->f_flags) & O_APPEND) && IS_APPEND(inode))
-- 
2.43.0


