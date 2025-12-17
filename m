Return-Path: <stable+bounces-202931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D7ACCA78B
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 07:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 79B2C3012456
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 06:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E451E32570B;
	Thu, 18 Dec 2025 06:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="BfS3VOhN"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010032.outbound.protection.outlook.com [52.101.69.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392AD2857FA
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 06:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766039456; cv=fail; b=PZmblQMwVPGOuTaq9jKN8XHK37y7T3+6N+2U5w3mSgc/YHyM6DzHNvH6zFXkYs0ncEhrVy/RMu/zBqVUsfv8z+KKe+olSLJjIFMrr8aAYkBZXP9Pdx+iOHWb7R3VeBNB0V/+Dunfuf0IoaBLujria5xIdQYBdiCi3ZfRTe7Ay8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766039456; c=relaxed/simple;
	bh=dMULo/C4TEpG5xM1KQNctxQrBT6344sbWtnXtKasnMw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oEkd4Wbj6Zt79tX+QJ5dS80RvPaBA28vhJEN2Pq35cGmaNnOo4m3Q9Gv+eDCvDJPNuYBvHa34vatYJg3BKUMn7/otiK2nPJdxfsASQoV42b75cF+knsqYm90es2PUdQpmRwp/B17t0J996XtOz8nxvO1EnLe/Xe2GsYmTXrETWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=BfS3VOhN; arc=fail smtp.client-ip=52.101.69.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Received: from GVXP189MB3428.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:2ac::14)
 by GV1P189MB2059.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:53::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 20:58:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=byC6PksBecmWhbAH8Z1OwnJLcc8jDmACkVaOvOiLfOJi2frUTt4yy0c/C8P9c+BzcLHwc6npCVG0uMdI09QrXZHoqXVfgs9NVBuFuUNpUBmeBwvGXrY1tRbfS8tzEXzxt57kAT1oxUH+oOBhojHUJ6WCGQWIk9beTLI0keMHkCnvl5FzUT9KRZV13Z8ee4Ep91EBKe1Sp5cUXvKjBDb89/yJfeYSFH+Wsxt4u5HJ706TpEcKB251e4wI3YZXWWla7tYqcYsCI3E6Vy9GURiKRPGBDx/AeftDwHuh7qiqsKuqf8Mcy2TTVWpMXbIb0lNy1Du9+KfMx9BDRQzrcugzrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7pvP74O1h5MaqCch+dRlAIRFTFFvlFJNfysJCLlWmI=;
 b=Z0ahc+qj9CGB6YJ6KBWARVPRhR09MnDB7tLf289BevUNFGHRQnQpdXokkzP8lFUIQI30SzarZiZMlsXwoR+BoUrDEKK0KBAvUvUPxAsqSPPqfkx65orFT8Mwiemhv3a7sy7KE+Ic+G9ZLe6nHHOrZz2YecwtlJYEvsBkylz/Kax5l6E23c7g0YfBHrwoKbFgHLcilu9gXr4HyWdNyGGNkeNFeLS6yL+sc9cHYOcr5Nd2y2isDwJ80O0+CqTgFpGR2WP7tArHJ8UETQRagTdZ3P0Lobhv14AOx8KJs+6BnR1eIEbUSbs9sOKbyyZojAA8zv6iFE7dwOiNQrWzarcwbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7pvP74O1h5MaqCch+dRlAIRFTFFvlFJNfysJCLlWmI=;
 b=BfS3VOhNr+3z+Ft527IMWCeL9o6oj2RXyZTXtA1iiToSrIgXTPMkor1Ppd/ZnJ3GOjHiSbaN8zSgE/qLqDOOZshqYTlrk6xOryp836pCNRF7G3osA0DXXlWSt5RIiiiLZi9p0SR3cgTMVQ3HX7mlpF3Exljplt7+CxNDeDIuj5jldKq4q6ooAbVGMbOrR4rpTtVA9rUtlhrp7Nm7Ux/xB6XVdyExeDPG9suIilD2wRE+GyNoIB4mY+sPdsprmLg2almREWqUsSAIh/LeKDGC5G3EbKUx2Ie6S37NNyAmI2Niz8uNNHYHdHqsB514fsGZs8HMe6DJPnKWTbDeY65BJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM (2603:10a6:b10:f3::19)
 by GVXP189MB3428.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:2ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 09:56:25 +0000
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::bc3e:2aee:25eb:1a0b]) by BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::bc3e:2aee:25eb:1a0b%3]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 09:56:25 +0000
From: =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>
Date: Wed, 17 Dec 2025 10:55:58 +0100
Subject: [PATCH 5.10.y v2 2/2] ext4: fix out-of-bound read in
 ext4_xattr_inode_dec_ref_all()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251217-ext4_splat-v2-2-3c84bb2c1cd0@est.tech>
References: <20251217-ext4_splat-v2-0-3c84bb2c1cd0@est.tech>
In-Reply-To: <20251217-ext4_splat-v2-0-3c84bb2c1cd0@est.tech>
To: stable@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Ye Bin <yebin10@huawei.com>, 
 Sasha Levin <sashal@kernel.org>, 
 =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>, 
 Jan Kara <jack@suse.cz>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765965371; l=7464;
 i=david.nystrom@est.tech; s=20251215; h=from:subject:message-id;
 bh=xO+38IRvRj0jTFV18MDLd7C7ySeXfktG/lzDkdGeuwA=;
 b=YvclqSGg4kN0Yrvm8yIDEFmNHIXd3VtotQeLDPMI721VfOLQBZNuEM2tvtK1FAkXFAKki1MHC
 hWGS/yN5D2oCyAp2U5rKtloZQb0NvylTM5YHLuQsY9tkK3Ti1faN276
X-Developer-Key: i=david.nystrom@est.tech; a=ed25519;
 pk=4E3iRjA+3w+a4ykfCHDoL5z4ONs9OcY4IN3pTwIG7Bs=
X-ClientProxiedBy: LO2P265CA0235.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::31) To BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:b10:f3::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	BESP189MB3241:EE_|GVXP189MB3428:EE_|GV1P189MB2059:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e4bf621-5628-40d2-b53b-08de3d528a8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SGFmYlJrTzdWUlFRbU1MTGM4T0JjaHNiSDlNWThMdVRFOCtMZjZ6V0pVeDA0?=
 =?utf-8?B?dzltZHhYUWdJWDlmVm9Hdi9hbnBFWVorVW1qREk4VkJrcWdWaXAvNXpuSysr?=
 =?utf-8?B?UUluR0lVUm1zNkljYkVyZytVLzhOY3B4NTdjQk9GYWpWL1UvR2o5T1loS1FJ?=
 =?utf-8?B?MVRUN2FDRmxBN3gxYnBvb2NYajNlOEpuTVl4VmkzMC8wUEluN3llYlMwZnZo?=
 =?utf-8?B?Z3dFSjJicWxYVTJxV0puRG05VURjS3NzRHkxTUZVTWhlZzMvT3AvRC9VRGNq?=
 =?utf-8?B?WXhrZnNTQVYzem5naGFheU82K2VCWkg4RWVBb0EvU0M2M0oyQjNJa0N6SjJF?=
 =?utf-8?B?cmVqWFk5cXdPREdJcUpjT0lhV1ZDenBvWHE2eWVkaUNyY0FOSHVvN2gvYzFr?=
 =?utf-8?B?TFErTm9zN2xmbDFMWkZLbTJtNXBMV281VEdqSWtZaEkySzFqLzEwd2tMVWg2?=
 =?utf-8?B?NG5pekl0TXI1TGgwTGNjT2lZTFRxVG83TmRodWVXUWRqcjVjQkZhWVNUZ21k?=
 =?utf-8?B?d2VFZlJBRGhBSFdOV3Vqcm92OWx5MkQxT2VNZ1dSMlhJa2JLNTRhc0lzUUJo?=
 =?utf-8?B?dGE4SkFibGR3dEhlWnJHdkxWbFdEVnJwRXRDVktZR09zbnBTSWVHYjhLMUFo?=
 =?utf-8?B?TWFZaUZ0Wi9DZ0tRbml5WGt6VGZ4cW1JekRvMEtwKy9nWWxYNVFRb2Z1ZHVs?=
 =?utf-8?B?RHRORTdHT0RJWXQ5WVlucEdkMmg2R3dGTm5SVEt0TGtaY0loVGEvblJCRGZu?=
 =?utf-8?B?cG5WUG5ZWXV5cHJkZks0L3ZzUHdaY1dwcDBvRUJnRWJwNkNSRjdyMXFiWVk1?=
 =?utf-8?B?Nis1SHVMV3hvWE1oM2pXT1R3eThSN0psMUhtY2NueEN2Q1d2cmJMMTVVRTVV?=
 =?utf-8?B?UzNMdmsrQ0Yzd2Jla0xpT2RNdG1GREdtVGhDZkRKYTVSOGtUMGwzMDY4emtt?=
 =?utf-8?B?dDVJSURxOHBCUGtiZUNobG5XYVdiZHRZcFBsYTZBUXNyUGFmS0gxQWt5QlEy?=
 =?utf-8?B?QmtmUDl0MGQyYVJuTnoxWGlNdnRlRmVXRjlmSi9wS1NCRjc4VEZhRFZtd1ZO?=
 =?utf-8?B?LzhPMW04TkkvVzFJZm9RMHhxUzQvQ0VwY1VnUWhPOTJKaGRUQ2lvTHU4WGd2?=
 =?utf-8?B?R2dNZ0twcURzS0dSdEtzQ2VqcG1jVEFWbGlDSU8vQ2JaaTZ0UzlKOFJ6QU5o?=
 =?utf-8?B?S3dWUXhla1l4b3VWN0FYdVZIbjBnQ1VDSVUrNUZ6M096NTRPU09YK1dTY2h0?=
 =?utf-8?B?S1Y5bzRzTTdJalkybUpSVmxzSW8zSi9JOE5rdGhLVXB1UFl1andRdDVPOWh2?=
 =?utf-8?B?UVQxaG9zVmtYQW1JYjlDd1FtemFoSWVYaWdNbXA3RmdoZ3dLVFN2ZXo5eW1W?=
 =?utf-8?B?Ty9Ya2ovVlJpRm9lbExkT2lCdFdHdXVQRkJVaVhORUQ5bzFkL0gxeTNvNjRV?=
 =?utf-8?B?alFEUnNvRGhLbmQ4cGJjWkxFUGUxSkMyT1lOaStnVnEvQ2dPZStEWFVoMXQ2?=
 =?utf-8?B?YUhSeWJTUVY0eTZMZWFZcWpPY2pISDZNcVF0YjYwNTdNWU5YNWhhbmVDUkRM?=
 =?utf-8?B?S3lQb3dDQTY5MHcyR0hiSXRReWdCZndhSmFyL2k2d3phYUlCcUZncmJDcUN2?=
 =?utf-8?B?aUh5amEzZy9MMXJjVFIyNDE0eTZHa1RlOG8rbTZRMngwQ3A3YXFoOGhLV0pt?=
 =?utf-8?B?SExyZDhCSHkwdlZ5Z0tBM1BYK3hGUk5RU2dJK2NlZEUvaXNKSk1ES1ZzK0NC?=
 =?utf-8?B?cjdTTTJ4eXFSbU1wRW0vbmJrNUpsS2w0ZVpHWk94N3VVRURSSVdzSHQ5em9q?=
 =?utf-8?B?WGI2dmRXZWlVYmJNK3VIMnREWXc1WFA0TDJhdzRkTXJYbW9jSWJKWE1MUlg1?=
 =?utf-8?B?Y3FZOUV4ZnVsNjVudCt2VURMZkxMbmVrK3BXbSsreEErRkE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESP189MB3241.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZDdIN1d6WGk5angrODVqaGdtS1ZEMkhWb0ZGRnVQOThpYlduNFFCdk5zeHNx?=
 =?utf-8?B?WCt2aFZrZzI0Wk5MTFRsMHYzbzM5eFZyUktESmVkQzVicEpTNi9XWkg4L0s3?=
 =?utf-8?B?TjZtOXloTkUxRWFSVWF3NE9IcVBVUTViYVdJYlkva3U2Q1FBV2lHWFV6MTg5?=
 =?utf-8?B?T1VocGl0Z1NhQksrdkVOOFlUeTVjL0RJSk84blNoOVF4QlNyYlZpTkxIamtH?=
 =?utf-8?B?TEFzbnlHdjhTUk5ON3JSSkZoaFBOMmtzS25GZlJpaFI1VWN0YXVVaUJCdFVl?=
 =?utf-8?B?WEh0dUYzSURDS2tSTEplS2lpNERST25PQjIyR3FSQS8zekt0QUxSVmVmQ0tZ?=
 =?utf-8?B?VjRMU0FVTHV3MjRDcFRPc1lNNWw4d3JzQ3hKZ0wzTTJzT0YxcGRtMGx5VUtr?=
 =?utf-8?B?QlFZREZueDdLcWFleWVYamw4ZklYVC9OT0d4YXRXSTBWTWFEdmZPSG1qTUVt?=
 =?utf-8?B?clQreWtOOGN1TGhJS2RKVm1GSTdHOG1jYkRmWXJqL1l2SHQ1NVJ2QlIyK3Vy?=
 =?utf-8?B?WWNCbE5XOEIwcngxU2Z4OS9wQVY5UkU0eEwyQ3VuTVl6S0xoSU5kbExGS1FF?=
 =?utf-8?B?QkdIc1RiZXdtUWdGUStRd3JZS0ozY2hCMVc0R0V3d0NoUW9sRlR6cDNIUVEv?=
 =?utf-8?B?MkM3U243NnJKbmNseTRxbjFEME9qSW55V3RhcU1HRkMzZExHYzczL1NPZllv?=
 =?utf-8?B?WFVTcG50VWxFUlFicXdRK0F5cDQvaUJNVkI0aEh4aWhuVlRVVTJqaDBmSHl0?=
 =?utf-8?B?WmRjMUVKOWQ5NGZMWVdXMXZYZi8zT21EeFZ1YVlVcTlBbk95RUNsSXV1K1F4?=
 =?utf-8?B?ZVVUaHlmZFFmVTlRblR5ektxMkRwNkZoMmhTaXlSU0ljdFVvVkpQRkZZdldD?=
 =?utf-8?B?MGFLRTlYR0JjTWZzU3R4SVhxN1IvL3gyanJCeHBKWXlIclZ2NmVjempXcE9F?=
 =?utf-8?B?NjlqK1gxU3RLS2tCN1g0OTFtTkZueURsaGFucHFqVWZPQWRKbzYxNXhZL1Vy?=
 =?utf-8?B?WDdtYTRsN3A4dUJ3NGc0NzM4cW9kL01EYkJ6TURvL2F0aXI0V1JhUndsdFNx?=
 =?utf-8?B?alZlM1Z6RjJkdkhCQWMrWHJPSXJVUmh3VkdkaWVpZHlscG1NSFRFNDY3MUNW?=
 =?utf-8?B?RDcwbU0zNnFKamVwYjBjbXZ1ZTZtL3ZHaUpMblpUMDBHVUlDUUh2T2pkRXJO?=
 =?utf-8?B?bEV6NVVwa3U1ZEtxV3U4VFpJTE9iZ3JEK29ra2UvaEUvaFpvV2VzMk91SENt?=
 =?utf-8?B?UmN3RjJ3Nkp3NnhDczVPbUMrdXFhR0tUS0ZITCtrTVFLMUgyMmg1OVM5UCs2?=
 =?utf-8?B?U083eVAyNVhwTFRTdU0xU0c5akdxSmJWRklrbFIralFSb3VYTUZVTTlDSWZw?=
 =?utf-8?B?WUlFUVFwMmxPZXgxNDVqTXVhRzMzb1hxZ3BhbVF0cU94ek0wb2RZRkR0NXRC?=
 =?utf-8?B?cUc0TER1NmNFMXVzS1JncXUrV2FFSnErcmhoY3Y1Z0U4UGtjSHE2TUFtR0po?=
 =?utf-8?B?WnFXcmpjZEp4bWI5K3g5ZFVWT2NiMkxyWCs4RmxoQ1pqRTd2b051NUxyUU5E?=
 =?utf-8?B?eDB4WEFqZXdjcGIzQ2RlSndMWDh4YUZEdUhaTm1LRHQweE9sckxsSERaUUZl?=
 =?utf-8?B?Z1h0dEtVSHNMTXBFbllneXhHS0l3UmcvMHV2ckxnMEJVS3BCT3lQNDVVd1dH?=
 =?utf-8?B?azB6UXZJOWgrK1dqZGZXbkJlYTVpZEdhcTNVWVNyMWZBakwwd04rdXFscFRs?=
 =?utf-8?B?OTdtSG42RFpYdUkwMldWZ3Q4WWpXT3ByTExsMzByMzREZ3JYS1pIRDFLV2ZX?=
 =?utf-8?B?UjY2bks5Rm00cFY2anBQelRua1dKaWh4MEt3aDBZWSswek90c2VyUXQ5VDg5?=
 =?utf-8?B?d2xnb3hiek9JcFQyN242M2YwdHFNRmxUZ3FENGtYcWM0akZlT29mbDdTekRD?=
 =?utf-8?B?RnRMU1ZWOWhsT3YvbFVNVkFJSFpnTGZHUVByelh2TU1BUzU1RmZ4cFBjUzdS?=
 =?utf-8?B?RWdjY0I4NnFmVWV4RmtUT0hOV2YwRHRPUFZ4c0hPRVFOTlJQWUVKUDV1Wndk?=
 =?utf-8?B?RzZGQUlvdVFDMG1oZGFrU25DM0d2Q2tLWjloWXRFMUhPdmU1czBoWFFQYXlm?=
 =?utf-8?B?OGJvZlU1Z0pWQlRMczc4dHdDTW4rYW01UzhjWTV4NVAzb3hudERFRGdDeWkx?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4bf621-5628-40d2-b53b-08de3d528a8b
X-MS-Exchange-CrossTenant-AuthSource: BESP189MB3241.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 09:56:25.4959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tV5avDqdhJDXBtxN1X14esHcJ47CtjvXSHu0HdspL+lkBWmeJldUT2xEUmDG0Kv7RjNj3v8gaxGZQRvEiaSD8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP189MB3428
X-OriginatorOrg: est.tech

From: Ye Bin <yebin10@huawei.com>

[ Upstream commit 5701875f9609b000d91351eaa6bfd97fe2f157f4 ]

There's issue as follows:
BUG: KASAN: use-after-free in ext4_xattr_inode_dec_ref_all+0x6ff/0x790
Read of size 4 at addr ffff88807b003000 by task syz-executor.0/15172

CPU: 3 PID: 15172 Comm: syz-executor.0
Call Trace:
 __dump_stack lib/dump_stack.c:82 [inline]
 dump_stack+0xbe/0xfd lib/dump_stack.c:123
 print_address_description.constprop.0+0x1e/0x280 mm/kasan/report.c:400
 __kasan_report.cold+0x6c/0x84 mm/kasan/report.c:560
 kasan_report+0x3a/0x50 mm/kasan/report.c:585
 ext4_xattr_inode_dec_ref_all+0x6ff/0x790 fs/ext4/xattr.c:1137
 ext4_xattr_delete_inode+0x4c7/0xda0 fs/ext4/xattr.c:2896
 ext4_evict_inode+0xb3b/0x1670 fs/ext4/inode.c:323
 evict+0x39f/0x880 fs/inode.c:622
 iput_final fs/inode.c:1746 [inline]
 iput fs/inode.c:1772 [inline]
 iput+0x525/0x6c0 fs/inode.c:1758
 ext4_orphan_cleanup fs/ext4/super.c:3298 [inline]
 ext4_fill_super+0x8c57/0xba40 fs/ext4/super.c:5300
 mount_bdev+0x355/0x410 fs/super.c:1446
 legacy_get_tree+0xfe/0x220 fs/fs_context.c:611
 vfs_get_tree+0x8d/0x2f0 fs/super.c:1576
 do_new_mount fs/namespace.c:2983 [inline]
 path_mount+0x119a/0x1ad0 fs/namespace.c:3316
 do_mount+0xfc/0x110 fs/namespace.c:3329
 __do_sys_mount fs/namespace.c:3540 [inline]
 __se_sys_mount+0x219/0x2e0 fs/namespace.c:3514
 do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x67/0xd1

Memory state around the buggy address:
 ffff88807b002f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88807b002f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88807b003000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff88807b003080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88807b003100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

Above issue happens as ext4_xattr_delete_inode() isn't check xattr
is valid if xattr is in inode.
To solve above issue call xattr_check_inode() check if xattr if valid
in inode. In fact, we can directly verify in ext4_iget_extra_inode(),
so that there is no divergent verification.

Fixes: e50e5129f384 ("ext4: xattr-in-inode support")
Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20250208063141.1539283-3-yebin@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: David Nyström <david.nystrom@est.tech>
---
 fs/ext4/inode.c |  5 +++++
 fs/ext4/xattr.c | 26 +-------------------------
 fs/ext4/xattr.h |  7 +++++++
 3 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 97f7cac0d349..719d9a2bc5a7 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4650,6 +4650,11 @@ static inline int ext4_iget_extra_inode(struct inode *inode,
 	    *magic == cpu_to_le32(EXT4_XATTR_MAGIC)) {
 		int err;
 
+		err = xattr_check_inode(inode, IHDR(inode, raw_inode),
+					ITAIL(inode, raw_inode));
+		if (err)
+			return err;
+
 		ext4_set_inode_state(inode, EXT4_STATE_XATTR);
 		err = ext4_find_inline_data_nolock(inode);
 		if (!err && ext4_has_inline_data(inode))
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 73a9b2934865..16b9c87fd3d8 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -263,7 +263,7 @@ __ext4_xattr_check_block(struct inode *inode, struct buffer_head *bh,
 	__ext4_xattr_check_block((inode), (bh),  __func__, __LINE__)
 
 
-static int
+int
 __xattr_check_inode(struct inode *inode, struct ext4_xattr_ibody_header *header,
 			 void *end, const char *function, unsigned int line)
 {
@@ -280,9 +280,6 @@ __xattr_check_inode(struct inode *inode, struct ext4_xattr_ibody_header *header,
 	return error;
 }
 
-#define xattr_check_inode(inode, header, end) \
-	__xattr_check_inode((inode), (header), (end), __func__, __LINE__)
-
 static int
 xattr_find_entry(struct inode *inode, struct ext4_xattr_entry **pentry,
 		 void *end, int name_index, const char *name, int sorted)
@@ -600,9 +597,6 @@ ext4_xattr_ibody_get(struct inode *inode, int name_index, const char *name,
 	raw_inode = ext4_raw_inode(&iloc);
 	header = IHDR(inode, raw_inode);
 	end = ITAIL(inode, raw_inode);
-	error = xattr_check_inode(inode, header, end);
-	if (error)
-		goto cleanup;
 	entry = IFIRST(header);
 	error = xattr_find_entry(inode, &entry, end, name_index, name, 0);
 	if (error)
@@ -734,7 +728,6 @@ ext4_xattr_ibody_list(struct dentry *dentry, char *buffer, size_t buffer_size)
 	struct ext4_xattr_ibody_header *header;
 	struct ext4_inode *raw_inode;
 	struct ext4_iloc iloc;
-	void *end;
 	int error;
 
 	if (!ext4_test_inode_state(inode, EXT4_STATE_XATTR))
@@ -744,14 +737,9 @@ ext4_xattr_ibody_list(struct dentry *dentry, char *buffer, size_t buffer_size)
 		return error;
 	raw_inode = ext4_raw_inode(&iloc);
 	header = IHDR(inode, raw_inode);
-	end = ITAIL(inode, raw_inode);
-	error = xattr_check_inode(inode, header, end);
-	if (error)
-		goto cleanup;
 	error = ext4_xattr_list_entries(dentry, IFIRST(header),
 					buffer, buffer_size);
 
-cleanup:
 	brelse(iloc.bh);
 	return error;
 }
@@ -815,7 +803,6 @@ int ext4_get_inode_usage(struct inode *inode, qsize_t *usage)
 	struct ext4_xattr_ibody_header *header;
 	struct ext4_xattr_entry *entry;
 	qsize_t ea_inode_refs = 0;
-	void *end;
 	int ret;
 
 	lockdep_assert_held_read(&EXT4_I(inode)->xattr_sem);
@@ -826,10 +813,6 @@ int ext4_get_inode_usage(struct inode *inode, qsize_t *usage)
 			goto out;
 		raw_inode = ext4_raw_inode(&iloc);
 		header = IHDR(inode, raw_inode);
-		end = ITAIL(inode, raw_inode);
-		ret = xattr_check_inode(inode, header, end);
-		if (ret)
-			goto out;
 
 		for (entry = IFIRST(header); !IS_LAST_ENTRY(entry);
 		     entry = EXT4_XATTR_NEXT(entry))
@@ -2217,9 +2200,6 @@ int ext4_xattr_ibody_find(struct inode *inode, struct ext4_xattr_info *i,
 	is->s.here = is->s.first;
 	is->s.end = ITAIL(inode, raw_inode);
 	if (ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
-		error = xattr_check_inode(inode, header, is->s.end);
-		if (error)
-			return error;
 		/* Find the named attribute. */
 		error = xattr_find_entry(inode, &is->s.here, is->s.end,
 					 i->name_index, i->name, 0);
@@ -2743,10 +2723,6 @@ int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
 	min_offs = end - base;
 	total_ino = sizeof(struct ext4_xattr_ibody_header) + sizeof(u32);
 
-	error = xattr_check_inode(inode, header, end);
-	if (error)
-		goto cleanup;
-
 	ifree = ext4_xattr_free_space(base, &min_offs, base, &total_ino);
 	if (ifree >= isize_diff)
 		goto shift;
diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
index 9a596e19c2b1..cbf235422aec 100644
--- a/fs/ext4/xattr.h
+++ b/fs/ext4/xattr.h
@@ -210,6 +210,13 @@ extern int ext4_xattr_ibody_set(handle_t *handle, struct inode *inode,
 extern struct mb_cache *ext4_xattr_create_cache(void);
 extern void ext4_xattr_destroy_cache(struct mb_cache *);
 
+extern int
+__xattr_check_inode(struct inode *inode, struct ext4_xattr_ibody_header *header,
+		    void *end, const char *function, unsigned int line);
+
+#define xattr_check_inode(inode, header, end) \
+	__xattr_check_inode((inode), (header), (end), __func__, __LINE__)
+
 #ifdef CONFIG_EXT4_FS_SECURITY
 extern int ext4_init_security(handle_t *handle, struct inode *inode,
 			      struct inode *dir, const struct qstr *qstr);

-- 
2.48.1


