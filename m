Return-Path: <stable+bounces-141952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEC8AAD19C
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 01:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F532982834
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 23:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF1B217F46;
	Tue,  6 May 2025 23:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k0fPtyyA"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92C71FBC92
	for <stable@vger.kernel.org>; Tue,  6 May 2025 23:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746574721; cv=fail; b=cjPA+ZNJeeIOGUI1zaPzyFXsP/ZbiWjO8R93siAajPhTXy4ptYxuZD5p1Latk1BVE62S4WwWlnecEUhuyzCwPL1Q8kTHU1BANR53wZR3HdTZGeF/ibiQCyrW8lIKMi263d3KvNXIk5HkJLXQlq5C2N4NaHg2Nj9/INO6JBYacgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746574721; c=relaxed/simple;
	bh=y1SX3g2DcJuaeSNX4kkJ6C3l1KRqVuu+6nzwR6AXleU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NkXDKjQpx/BcKWjGff1ckiGPOgjfhvDdOw3y459ZbWgWQNTgURkfMAWkcrZMcEwrd8AozwtMpdzM5wFT7ZV0T6t2XcSW8JuWaVclqPvj9/ZKYkNDfiHMzNjsquVtpHINaooQgDMVVbIfWYfXsAmQONzYCj+90Jlpd2PSPDQ2xy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k0fPtyyA; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GW2PTyFUVxClfmOQx5LP92y1kQ/Bm6R+WiWUL3HjbYA1MbhPsIBaTdbC+UNVfV7QwdDg0AN8dqANJTV+5se28pZrHqusPwBgwPpfnF2YSyYg3NuKL6fod3Qkj61s2r+Ou/usW6e7RJhi9DV7C+4oR5KjMoOV/qV9NupbbJ3AFuSAzKfc0V2AiG8m2HIZwbm4sSfTLkG0VcHKw2TVI23eSZayU6uG3NjM7vU+c5BEXb2DfyWGaRJ7gJUAFdeoK5cK189HxR65GmHXEnmxkhA7muTsgAJIALUhKK3tvBLtsSlgZbzxIy8Vs1JePAWM4LGEHZkr+33NhHM2yqUHX+zU3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4H5WeE0h/QpFP5bXUl38cnlXJ5owPrGFWcBYY+J1gM=;
 b=ibur587xZMJMZyr7MDaHKLmfuEMjh0qplmHka5pkP72lQ5e5qcHG8MBV9w4HgdZm/JVl5YE6yI/MWDHZ4/YvXhGN9GDfcRB5gSnwMy/lDq1098Ux2CyYLC2FO37fgybT2HQQeQFXBV5r93o6oIi3R6N5zC3YA3EvVuIK7fO1ZVEuh3qdU0pgzbPPS6bfpqmT2V/DhwbAhFnQX9x6VRAc/xtGzedTZ9mRBb0LswrWmLrd8u0Gz0j8weynYtFscypdh04HweLQSK2xBVouNyYrU4vzW8eWS+aT1hFi34aKFmKZMVcf9MlKVep8c7pRBJbQbUxW4W6mpco+irj580GIug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4H5WeE0h/QpFP5bXUl38cnlXJ5owPrGFWcBYY+J1gM=;
 b=k0fPtyyAra/fhLdjd6E5oeOmfeJRn3xKP7d8ha2ty//2DG3LuhjGwOsWDXu7l+5KyMuD65GJ73vMAx7er1sLFHVCuAYM807yMskbeSaNtKaA8cblzrNb3T+2TVAyjS3Za0taEJBUVW3SO9EDqsCpfsxbkbVD8EruTyiv1FF9K1V/GCN0Y42Q3JDLKLmqqKFzPV/pPGcIzrklx5dE1xvLUMqvul8Bb6j172ZvNgRKJYgadzEGnWZZcAQJwJrSHx75WtD+h7nr5XlUxQhCP95kOHC86VeGkc6owXnZoq+22M3WBSrztqnOwsFkt6A3Ojan66yUf/Fi1q7IKjTAOvtLCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by SA0PR12MB4399.namprd12.prod.outlook.com (2603:10b6:806:98::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 23:38:33 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%5]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 23:38:33 +0000
From: Jared Holzman <jholzman@nvidia.com>
To: stable@vger.kernel.org
Cc: ming.lei@redhat.com,
	axboe@kernel.dk,
	ushankar@purestorage.com,
	gregkh@linuxfoundation.org,
	jholzman@nvidia.com
Subject: [PATCH v1 7/7] ublk: fix race between io_uring_cmd_complete_in_task and ublk_cancel_cmd
Date: Wed,  7 May 2025 02:37:55 +0300
Message-ID: <20250506233755.4146156-8-jholzman@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506233755.4146156-1-jholzman@nvidia.com>
References: <20250506233755.4146156-1-jholzman@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0030.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::16) To SJ1PR12MB6363.namprd12.prod.outlook.com
 (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|SA0PR12MB4399:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b1cda7f-cbbd-4a55-cb9b-08dd8cf71d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8jM4YuBDQ16PjNCeDRPLhXYiUZgQrLS5Us+N4jmUb1OsEGAs3NOKXMl2b6sa?=
 =?us-ascii?Q?1LSn8EGxc0dtEIHkM+D3iJ2BJuTqSfwQ4E8loLO5gvYSL7JVFC7T/jKPQpo0?=
 =?us-ascii?Q?Y52YyAMhBm8sKpgjkXNACuPyrMoLOROBkn5RH2lIE9juQSkRO9yeyoDWuhce?=
 =?us-ascii?Q?nfMfWPK3JiEzpqbyHRZ/AIimE/exMCEjd4bsrIWvXzWlVUTBfWCMWSd+vs0S?=
 =?us-ascii?Q?j0o48ELsGripO5Ly/cc7fSHxdclyoF37u66qrTRe8ek1C9dKiOa8TIXmWaE7?=
 =?us-ascii?Q?kAAjueqFXemxO2hBXkT3bmelo/hmbIo9vfh+sSXEkEI1PIf+PtvAF+0dI2Hy?=
 =?us-ascii?Q?xFgMz14O1GomhgHgkFQDN5fqec3wwhHFwTPS226D09aDWaN34EuYkFaR2qwE?=
 =?us-ascii?Q?OFSNvqI/bnuF9TcfjJeixXvN1Klsx9a0ng/BlZgN1mSJjBoD5dv4GnlH7yBv?=
 =?us-ascii?Q?v94gv+s2EnzC2aCTXusSv7chw1WumPquZVh40hqDcRD/u8kvPOrQ8zAkIBha?=
 =?us-ascii?Q?su3wuBoOSBXOZ0IOIUCq2gJEoufbQHYLO5dnuJLtXy4V+oWKrxVKGWkOtGvS?=
 =?us-ascii?Q?DxOh1Lf4CF30q9eqz6xU/u3y7yH60z6V2wRWSVWht8w4vwcUifumyA+9ltz6?=
 =?us-ascii?Q?hhJhHmWTjIEFuGb+5MFTBrdwpPn3xIj9wDTZ0+2A6GMYBJvAzJX3DTLBdhWy?=
 =?us-ascii?Q?InP4IC+gWUdLaQ0mUxMg8vga3v0FilBjD3eq8IHLCJ/3Kf5vKiHzZaiHFmBF?=
 =?us-ascii?Q?JhXuQw/YVvRZrzstO3PKVukDzu5EFIIt8HpmNbQIiCOU0shfIA9biNxcGsEw?=
 =?us-ascii?Q?f0I8lGeIgVKUgwM6iEPqZ7WjVRkO5HofCYZzWa/a4Ct2uxtOKqNOMFyEYE1x?=
 =?us-ascii?Q?71n/ICD3N0OyBP/1TfLyMklR5f1g+Nitce9pbZszRIJVpzFUe8KfwNAWf5//?=
 =?us-ascii?Q?aiZst6jerwaVyhE7yYKjUuPZGdLskXO/9cUIN1EObLUwVILubF7aUMZA30gh?=
 =?us-ascii?Q?iXubjH0XcyBZmsa0bemTpgVjpBYYgmv2vC11aZ10oaCs+c6tbpRPwuofaQWv?=
 =?us-ascii?Q?UNaoGveelHlq/DC1bx9IwI1h151fdSry5QvByC9rxSVPDw4ggIP5dN3IzghY?=
 =?us-ascii?Q?flKmPBifcgKv7yS56jVLGPVl0/Se1uJIT42+r2TY5JmdjuoZZUS3XCrtJWZh?=
 =?us-ascii?Q?nIRWe80q1zSEzzM9JIEQkR/ZX6DRsvIX1lXwZeKcnw1IPSfGe0q2ZBseNUlC?=
 =?us-ascii?Q?VL1GoJ4n7s+XEDtQ1XUSdbW5IeROFWiJO1xQeCTSvAGHE4GfOursoSdN6+hK?=
 =?us-ascii?Q?JAZN/30ZsZeB+FPxv1zqajb9hoD8BQ94S7/weI/pJpK1JOdxM29Eekc8Py3q?=
 =?us-ascii?Q?1Xm+hFsM3+jzU7Pk2WKWu6b/hsbYWzhLEk8G0/JwU80ok68MKMj1ZrX+P/il?=
 =?us-ascii?Q?WkD5wDI8Nkw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?75tPPjrJzlwOGzf3PMuvlOKwdbDdwELbQ0oAo+VJ2n6gWeUCh5jOfV+anx82?=
 =?us-ascii?Q?De5vWmC3P3BKx1yh6DIhKz6gqT7yp8KIM29RYg1lmKlI4vO+Bo/VU/ldLFpC?=
 =?us-ascii?Q?PNpSAJsjw/soCFoKQoimvk6bUDXCd24UM7Vnd8WmgrIfdAR/PQlCqGT9IXDK?=
 =?us-ascii?Q?Pqet7QUxJBSHFQpI8SRvkKybLbtECXy/z+8RsdRWTnX9UjPVVUc7Sq8zKg4v?=
 =?us-ascii?Q?UMI3/jNkQ69qig7A/XuatWrLUr7987cgl2uFKZ/2vlGK6dhEbvlso4WhVYtd?=
 =?us-ascii?Q?pLJP1bWPURKw/ok7sTsuFdOhiAgRt0AjEz4Lxy2ox/HMbsckERfK2ttBGWLI?=
 =?us-ascii?Q?23Rw+tPi5CgMPNF+xT+dRPVKShpcdYLcLthXTKLvGWWNKAEHPBFQpzbI1JiS?=
 =?us-ascii?Q?Qf5K9EhHG3NfD7YCKD5w+dipdRpwiJJm4KSjAdBAviJ6xVuNuoe9Nvo8PW8c?=
 =?us-ascii?Q?Mu9Uz3zuCDjD77jf+xt8CbMz0Y75IPRdsGIdSLCB+GfEdCEW9sRpLlXPZJGl?=
 =?us-ascii?Q?Q2ugsbW5HdMldpLFv0JYPS1o4AJLtrv+sHk+eFpSTItKy2AUu5S0f+Xz68Aj?=
 =?us-ascii?Q?c3SlQ73tURD3ddqH3d249/3QRps/Fn7mR0OyI79f5yzq2R1cayixg9aAew91?=
 =?us-ascii?Q?b2Hlx+B+VXaX6Ce9EpVJNqpw8e02QxI5cer7wZ+89F33sCMtpiv+yv6xE0wT?=
 =?us-ascii?Q?cM+zEZZhi7Yt7vhArJXHVNSFa6vn3CI5aPP3ywUTjYdIfHhvr2Jr0wLMH6bf?=
 =?us-ascii?Q?3TktE0bK8FdCCrwrvhD0JdZIOmNUGGK1BiAJVBHmPFkaJ7A8dYj3Xxf0tUcC?=
 =?us-ascii?Q?WcDMA4YO8uqAdmlOiwdl/BQxi+Zpn9Y83iKYfyfe9EfZXT7T6izfTQZPBnja?=
 =?us-ascii?Q?K+lSbG1JKD6dT6Cn+9q1jH4eYMXAJx9ZvobOPGS5K8Vd+KWspin2+YdQrmq8?=
 =?us-ascii?Q?7aZboprd/OPLeNF6w4Kizni/GXhrnaAjwGnzfbbfw1N1pjeF9i9PHN4NOXpr?=
 =?us-ascii?Q?u5NwB0sGYc+b9WTw8u43livRKOzz8AxJZdNZ4RSx0/Fq4zTqT+9xh5mqfTTT?=
 =?us-ascii?Q?KuQQjWY6aO84xrD3xTw6jBW2NQ+WIPX48FMPAcyFYzOXe5zuzOoqi943pr1P?=
 =?us-ascii?Q?syPHvsYcSbK76aIbZLM+vlUDm5125a9/d5tqiy5VeRKuK5j2q2z86Jkd63wb?=
 =?us-ascii?Q?68w2ZZlNsK2u6rtSnld8OOMd70bXop2P+bmxJI+HXxbYtQzGZmU12koePEMN?=
 =?us-ascii?Q?WBkiSZ516N0rQgL0YbxrtExyTP5APoLdm1msH/0upfNYyDgy4bjXNDgqttSu?=
 =?us-ascii?Q?2Yw6RsUnZE9dTrKmwA9qsRkffpAD/aZdlvegIcaMu+rCZl/mNHo5CUsFZnTZ?=
 =?us-ascii?Q?NSYuHVj8W2jcUX8oMBjMzsh5MZImngMiyzr3ImE58t2FILthcnAHYtMq74nd?=
 =?us-ascii?Q?YdbPaOFufKOBcQwJq41xzSbsZH7z36YyJEYhS/8AtOusxUWpPWvldVw/yBdU?=
 =?us-ascii?Q?doqsmmnRXHtiiLJznpxAnVURhlR3zBlM1XGy23kMWpDGLkfsbQI8M2AZmYXA?=
 =?us-ascii?Q?0r/OISXgEoKXf131/QkWm0AuAf+8SPozUZqByG1cDFjMNX1OxiLS/LMAkMuJ?=
 =?us-ascii?Q?EQSjTfT5mlxkwEobjUORLN3qGzFn2VOiQ2EZWaDMlac7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1cda7f-cbbd-4a55-cb9b-08dd8cf71d1e
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 23:38:33.3682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yI/GGmGobdJLkUSItza/f0jDlBYtOIohxj1bD3DX4YFgzOYMgnyUyG+aCOr9HFUqTRal1b/T//krv6vMrWbuLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4399

From: Ming Lei <ming.lei@redhat.com>

ublk_cancel_cmd() calls io_uring_cmd_done() to complete uring_cmd, but
we may have scheduled task work via io_uring_cmd_complete_in_task() for
dispatching request, then kernel crash can be triggered.

Fix it by not trying to canceling the command if ublk block request is
started.

Fixes: 216c8f5ef0f2 ("ublk: replace monitor with cancelable uring_cmd")
Reported-by: Jared Holzman <jholzman@nvidia.com>
Tested-by: Jared Holzman <jholzman@nvidia.com>
Closes: https://lore.kernel.org/linux-block/d2179120-171b-47ba-b664-23242981ef19@nvidia.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20250425013742.1079549-3-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/ublk_drv.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 6000147ac2a5..348c4feb7a2d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1655,14 +1655,31 @@ static void ublk_start_cancel(struct ublk_queue *ubq)
 	ublk_put_disk(disk);
 }
 
-static void ublk_cancel_cmd(struct ublk_queue *ubq, struct ublk_io *io,
+static void ublk_cancel_cmd(struct ublk_queue *ubq, unsigned tag,
 		unsigned int issue_flags)
 {
+	struct ublk_io *io = &ubq->ios[tag];
+	struct ublk_device *ub = ubq->dev;
+	struct request *req;
 	bool done;
 
 	if (!(io->flags & UBLK_IO_FLAG_ACTIVE))
 		return;
 
+	/*
+	 * Don't try to cancel this command if the request is started for
+	 * avoiding race between io_uring_cmd_done() and
+	 * io_uring_cmd_complete_in_task().
+	 *
+	 * Either the started request will be aborted via __ublk_abort_rq(),
+	 * then this uring_cmd is canceled next time, or it will be done in
+	 * task work function ublk_dispatch_req() because io_uring guarantees
+	 * that ublk_dispatch_req() is always called
+	 */
+	req = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], tag);
+	if (req && blk_mq_request_started(req))
+		return;
+
 	spin_lock(&ubq->cancel_lock);
 	done = !!(io->flags & UBLK_IO_FLAG_CANCELED);
 	if (!done)
@@ -1694,7 +1711,6 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 	struct ublk_queue *ubq = pdu->ubq;
 	struct task_struct *task;
-	struct ublk_io *io;
 
 	if (WARN_ON_ONCE(!ubq))
 		return;
@@ -1709,9 +1725,8 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 	if (!ubq->canceling)
 		ublk_start_cancel(ubq);
 
-	io = &ubq->ios[pdu->tag];
-	WARN_ON_ONCE(io->cmd != cmd);
-	ublk_cancel_cmd(ubq, io, issue_flags);
+	WARN_ON_ONCE(ubq->ios[pdu->tag].cmd != cmd);
+	ublk_cancel_cmd(ubq, pdu->tag, issue_flags);
 }
 
 static inline bool ublk_queue_ready(struct ublk_queue *ubq)
@@ -1724,7 +1739,7 @@ static void ublk_cancel_queue(struct ublk_queue *ubq)
 	int i;
 
 	for (i = 0; i < ubq->q_depth; i++)
-		ublk_cancel_cmd(ubq, &ubq->ios[i], IO_URING_F_UNLOCKED);
+		ublk_cancel_cmd(ubq, i, IO_URING_F_UNLOCKED);
 }
 
 /* Cancel all pending commands, must be called after del_gendisk() returns */
-- 
2.43.0


