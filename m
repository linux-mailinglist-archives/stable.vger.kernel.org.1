Return-Path: <stable+bounces-141946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B755AAD196
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 01:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 788744A68AC
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 23:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DE621CC61;
	Tue,  6 May 2025 23:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wp+MObzn"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0557263F
	for <stable@vger.kernel.org>; Tue,  6 May 2025 23:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746574693; cv=fail; b=brHoi00wSvn/9NA/5FgQWDtk6ADvNlVEzloixSSdKittQWgtZqCXZtu14Em/JlzYDNUSCUrWBZmODNc5fF8EmCdGC8XXtqbRNtcZVPGiSlnYtqN5FUxYJDi+WsbNA2ny+JHifLrrx6P4T6VB7s8jg7ewLCTEIG1H9RljtlQR1jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746574693; c=relaxed/simple;
	bh=CCKBBbfhu5eH1q0di1S2rNk4tEr1TED/58zMVARSKPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CMnPlQ9T7GciViUKU5l6k+sUAdRhjejhPUzRFUiktIjN07CmvrigEx+aXmwWnUcYbcQCf/yzGnha7aO9UuDhl9EAa0PKdwZvJ7JSvX9uv+l489l0aGeqY7OJcp9OiXZD78fW/cc7wz1xLk+s0ZCuMV1RbTyxaTlQEXjUut6EatM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wp+MObzn; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3qCgXDk+vvHGeNkxyvl+1l84tBbLYssD4I2BpTBkfVfB2L20eMRCfYPI2E1xgOnCD2IlTQiG4bGnaw7syIKlKzX6Soj7nBxqeLMU3JuWuVfMPNJF67EQ7/a4c2CQXYGRGli8P7SrtumJsakGniEygjxv9iydDbTRXB6H13cJ3/0Mjz+Do3DzCiuo+s7DrVC9pLHC7Fxn/QeNcH6B6rixQhKqXN5NY9GulBtxtupNq+za1z0Xk8HhsgY4zqcilbNPU6xqkF0K7cLLPRl7w6UjZ1L1eiUCY9rlDr5KfM3dao4qV8RjT1rNaqNdJYyUcAT+Geap4OdzAAlwWHnXxMeGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpD/HuLSGANcIxSUWaFuJyYkkXW1fRslVU6fS+ysrZ0=;
 b=QHyiV1dpcj7zzEI50ysTXU5lrPqfz8Lx1MiZ1qk5xPyBvNThLEeq/9c3B6SWTqJsuMNaWSEWRYFTI+9CnHIP+S9ynJ0nbaxGDUvc9loXTWphqZPz3d0TwzyYivYZyW40ufAx3SKrg1Aes9ZM8qV/hj5gjUD5RvNgismiz5xXndfq2uZuSUGkJ/OyD6wtAnVq2paf6dtoqd5M774/s78SCSQiTWiyOvWKlxbJbgklr37OyeuRFuRoCV5OIpQxDVCdGxGv0iIN6Qiw+ILIBD0DJktOFqxiCUKfpPl/TffXPI1LC41KBaAsmpfGDIxNAbUeZlTiiinvaEBmLedlx7lgmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpD/HuLSGANcIxSUWaFuJyYkkXW1fRslVU6fS+ysrZ0=;
 b=Wp+MObznLni0Wp/SVdTC1VnKI1GQF1e2IFwsc+2zPBPgNDF/6kzzY5AYscTNKjL1yGf+CrsvHvoQcWlE3nVsPIHsNmgsfVjvrivgZd30iA9DLE0lIS4LFsGPkN8gdtrXDy1zrs/mgC/uMiliIyE97KMmgO0kdKiz56Kc86NApJej6SGlmMEQXDc9wjb4TnLnBzpQIyg1yq29Ozpao/N3w5XnaA3zQdm8ITOn4xiElXaHrlz1TF8avXZqrwMpM7DxFq1Z97y1KlNz9MZRHFmPWaqlscLq3r18y35dQBi9PmmkVj7xcDyyePLHzNGxYlNFUV5KBGI/nXP+2GJGS8hB1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by SA0PR12MB4399.namprd12.prod.outlook.com (2603:10b6:806:98::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 23:38:05 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%5]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 23:38:05 +0000
From: Jared Holzman <jholzman@nvidia.com>
To: stable@vger.kernel.org
Cc: ming.lei@redhat.com,
	axboe@kernel.dk,
	ushankar@purestorage.com,
	gregkh@linuxfoundation.org,
	jholzman@nvidia.com
Subject: [PATCH v1 1/7] ublk: add helper of ublk_need_map_io()
Date: Wed,  7 May 2025 02:37:49 +0300
Message-ID: <20250506233755.4146156-2-jholzman@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506233755.4146156-1-jholzman@nvidia.com>
References: <20250506233755.4146156-1-jholzman@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0025.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::20) To SJ1PR12MB6363.namprd12.prod.outlook.com
 (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|SA0PR12MB4399:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b463f76-8573-4ddd-98da-08dd8cf70c36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kBwyhKMbfMiTVDEB+f1j6y0NKKpvQLg0Ku/Ev+PAjYUkGT/eyXe6YvWzDQWZ?=
 =?us-ascii?Q?53FIImRlSWnTqvRSu2FWFTqQAJvjkP8Y+fmOIRVtC0aodLnG5TobJzmBgfuv?=
 =?us-ascii?Q?qSwmgA382E+BEAlXkDw/slvWeE3GrhzaZhewt60myk2XqcXx96Ufxq+npTlS?=
 =?us-ascii?Q?jJw60nUPuh3/iTQS5/riKHqU+ryGxLqegDKqmmPH92EhRnNUQvFstjE6JspZ?=
 =?us-ascii?Q?x7BDJSbDbu/nAZ7L00NDyZuuS59Ulf/GQ9RbjI4YSPlaK5lFSkLmm+QjSGgc?=
 =?us-ascii?Q?pdt4hAYUYT/+CcvHGpnmlU21AEjP/14ld/+MbAjoe8+TqGKVZiTnK/ad1E7d?=
 =?us-ascii?Q?uDS1XUVklpH05hZQ3KQdTomlg9ef8Yx0/XDQGg5uYoYTgEpua9laUnFAoOq6?=
 =?us-ascii?Q?sp7FfDaTlnmz3s5X/w7rkTtCgxLW1DgLgy4LR7iU2WAVAbbrHnF2YZA3+pku?=
 =?us-ascii?Q?0WCnTdxyR3Pd1FdO9ZPYVCehTPOcL1xmHtOTuztaGHE/mLwQLZ95Zqc4U3Bq?=
 =?us-ascii?Q?P6bFoG5bCzv/dEoLp1m838P2GEjf6ltwR1zRsX06XAzjyIBqJhsUUXER04Yg?=
 =?us-ascii?Q?H/FYwePqQ0NhjdbQ5GhdYOwBlYHFyBmVy6kxj1WF93Opg27b7wDpBMQaEqyu?=
 =?us-ascii?Q?BL1XJ/o/NnULnwNYMLfMISYbbH1cAPT/IcoO6NjbxB8Ua+SDJjc5Brjyk2VR?=
 =?us-ascii?Q?XLpM1YlrTP0+Mi1BiF2Cbpno2A3zwIz9NoTGVvZBv2vZ7Rvx+ARIFdWKKr0c?=
 =?us-ascii?Q?kNWEexKw0CMw/x7h2NQ+ihaRZHMF6NHS3uD7xKJuNtRmrF/4wP/kcbIVrfGt?=
 =?us-ascii?Q?OHplpaRj30GRpvsejvklikT/1dkYpuaEJc/iofJiuwPHR7a1lP2maAqXa2DT?=
 =?us-ascii?Q?HZntOfea7Nx3CF/dm2C9OeftaEdw8ro2jyMoI5+k8i7+52090y+4R6WTNsT/?=
 =?us-ascii?Q?wHFmz/j9aNdQIMJH37p5T+SVdc5ZyngosXEQ6YORWPROGaOCWig8EgdofP3Z?=
 =?us-ascii?Q?zfnI4rwuF2V4i1oN8N6UScK5XdhoWcJyRk4niaDJu+dbmP4Fhfv0wEEmBwK9?=
 =?us-ascii?Q?Gx1MlO9LPbhCE8XSK1yOXt9zX3CLX+fMRAGrvshk3unltbNvNNfqcwvsN/9P?=
 =?us-ascii?Q?qcAN1PvHY9CdG+W5n1yObhQDn+mbrjqWD6CdJ1EOna24ktkmMJaCCVpAdeEi?=
 =?us-ascii?Q?s5vhGOdD/Z1sZLTvYGYLmYwGCW20INinKY2C1TsWSG5QswZDxMhhb4LRhml+?=
 =?us-ascii?Q?3H7ZknyZ76EueyLuhUWuu8kuzeLYdKUfIy6yXvXv13xmXT9mpPwQ3lmulHgd?=
 =?us-ascii?Q?uMVt9yQbDcyD4yNLsURhvsQDGVM9zfoug7ynOJOZ9VQApUPp65X0tNwj/3hu?=
 =?us-ascii?Q?+MX4fyNnj1DO5p9jeuPWtRcZvwFcM/V506OshEFyCtW6CDJvchsV2fU3D8ed?=
 =?us-ascii?Q?2J6leyHe0bg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ET69c9FosWCiZTfOaNS31gmeEaUcCQlVy8Lr0Hwk709Mx7omXRaYt/ibBEKh?=
 =?us-ascii?Q?qXO1npGx2G6xNkaXWUMCl30hEh1SZZZwfRYYZ+3io7f9oEQUm/1eD2NUGeD5?=
 =?us-ascii?Q?UQQk2vWM0Qjg5JWlp08HiC9Ie17CikpxJfLIrwXRzQmBPszaWVxKP+fcp/FE?=
 =?us-ascii?Q?YaZgL+Kkl72IyFeMXUg/+UbYL7iUx7o3rF7R5Y4WplrPeCC5JqtvJ9j09Qvy?=
 =?us-ascii?Q?teCXxkvn7ceSWDQXLCMpQpRX4mOn8CYiFdCt38Eg/xSVO3giSZSOQymT1LMk?=
 =?us-ascii?Q?FZYjKRO4Bps5pXIMm07jsOyH5I2i5MXsLakPsUhkCqTHoQbsBYfPNePCoXWR?=
 =?us-ascii?Q?G47sUzQZNUfrUJAV58tzet4AakbUmOfFEp4cd2KXMhTPezb73jC+BfLU7VNm?=
 =?us-ascii?Q?I2ON1TzPj70TOg1NrLq26iDOpbjmkhxT8vP80P+ewe0e+lLzysMcpnLMcWSA?=
 =?us-ascii?Q?2KWYgK6e5hUXUHVG9h/L7u92Hep71luTWATfWGDdY8/IF7SqaTBHRKR3RZeK?=
 =?us-ascii?Q?m35O7jxkCHVukRgLUwsMtXFoG+kGTsVusLtX69JaWtK42q7l825QQVaFxC+G?=
 =?us-ascii?Q?X8rTF/inuS6JJLx5z2Zg1OlRmPDzxqdpc4cBg9OLqtbNpk7tLNzXClvBfQ2T?=
 =?us-ascii?Q?EtcTjJfeTgEIrCFdHOB2WewHNRO1Fk4wr45lAYbus1IA3as4bfLyua+ZaNdU?=
 =?us-ascii?Q?3hx8uptDSE+7ywzRbsD5Mdv4vYQvA+/SAL/zpBxB4NhaSOzxqcAT9IaMzxn5?=
 =?us-ascii?Q?EOWvX5gYrL+dddWtLGzfUf7Vw/sTbEUZ/EtsIgsv1eE7EaPFoU36jc7ghoyp?=
 =?us-ascii?Q?npKj6srFVzRsYNDWJqAkdIaJbBfkemysOOvgMme3I57Jnfy6WZpOWylHoGZX?=
 =?us-ascii?Q?CIAP6Fo6lOJsHxnfaA5y7UGI7m3UfAqLzdPw9Hx4bL8Ukw/mSaE1lrzKrNuW?=
 =?us-ascii?Q?xjm6lfuyeVgZOgO0fO9b0vKHgJCY0vh/hHBiVJdByi3yECRx6bg1lcrn60VR?=
 =?us-ascii?Q?CwnJHcmuMZPVL35YYxSTCAgAwhnfsmyGkTjs2UCmODzWjzGM8UdyiYLJ+TPm?=
 =?us-ascii?Q?gCrKbJJy2fqIIcYjdqTeJcfFqdT+EZlvpY2hEFDloF6zi6ChBYkHuB5oeKza?=
 =?us-ascii?Q?SH54c86eqsNEjRtpMa2SkynqgcT+i/HwUZvr9FT9D/PK0PDrnkjdFgRcU036?=
 =?us-ascii?Q?bj2FkxDjzYhTpWej4jZd8gq1V4GvHphVJYLKyZ+lxkUgyFeiMiVDpO9lwNdz?=
 =?us-ascii?Q?tuTYulLMiHIzP3R4K1znab8MjQn5fHKpYv56sA1VkaKBne/F7L+jyfibhmzD?=
 =?us-ascii?Q?NiacnzayyONX1nCcJD13BvtlU3vkYrD/L5uGXzd/JGyJ159IU+kUX4JB7UKn?=
 =?us-ascii?Q?WEneqzc18gHc77RDsRBkv20uomu/dbqrxHfO+EyV0rnqFgAhtpesLJHJL3p6?=
 =?us-ascii?Q?L4RbyrIARG0+TQ/I1RF9dhfocWQyk4lPymbghTi4T0UwCSEenNpN+72rFIGK?=
 =?us-ascii?Q?OIk9sLzc1J5qg2mh0/ntnHUARE3XHmj59j+hI5yAHLl/CL6rJrZQW+O7UeUD?=
 =?us-ascii?Q?j/TeWjurtH3WaWBj6KKCv4RRHpomgZa90F/2kJftXSZmBs9t1RD9h51Aa/HD?=
 =?us-ascii?Q?aQT/1lF6OzlnXgVfXOIyYgAIlOCVKCr2sDmb6bKAh3jj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b463f76-8573-4ddd-98da-08dd8cf70c36
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 23:38:04.9638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iAdQHmA5moLX1C58N1WPjcWe6GMRNXpjQfupqk8YwIN7DhKtPD9Tf7HNEoP6rB2QeTzNMf2j5NRSsb4ZEzE/bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4399

From: Ming Lei <ming.lei@redhat.com>

ublk_need_map_io() is more readable.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20250327095123.179113-5-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/ublk_drv.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index ab06a7a064fb..4e81505179c6 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -594,6 +594,11 @@ static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
 	return ubq->flags & UBLK_F_USER_COPY;
 }
 
+static inline bool ublk_need_map_io(const struct ublk_queue *ubq)
+{
+	return !ublk_support_user_copy(ubq);
+}
+
 static inline bool ublk_need_req_ref(const struct ublk_queue *ubq)
 {
 	/*
@@ -921,7 +926,7 @@ static int ublk_map_io(const struct ublk_queue *ubq, const struct request *req,
 {
 	const unsigned int rq_bytes = blk_rq_bytes(req);
 
-	if (ublk_support_user_copy(ubq))
+	if (!ublk_need_map_io(ubq))
 		return rq_bytes;
 
 	/*
@@ -945,7 +950,7 @@ static int ublk_unmap_io(const struct ublk_queue *ubq,
 {
 	const unsigned int rq_bytes = blk_rq_bytes(req);
 
-	if (ublk_support_user_copy(ubq))
+	if (!ublk_need_map_io(ubq))
 		return rq_bytes;
 
 	if (ublk_need_unmap_req(req)) {
@@ -1914,7 +1919,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		if (io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)
 			goto out;
 
-		if (!ublk_support_user_copy(ubq)) {
+		if (ublk_need_map_io(ubq)) {
 			/*
 			 * FETCH_RQ has to provide IO buffer if NEED GET
 			 * DATA is not enabled
@@ -1936,7 +1941,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
 			goto out;
 
-		if (!ublk_support_user_copy(ubq)) {
+		if (ublk_need_map_io(ubq)) {
 			/*
 			 * COMMIT_AND_FETCH_REQ has to provide IO buffer if
 			 * NEED GET DATA is not enabled or it is Read IO.
-- 
2.43.0


