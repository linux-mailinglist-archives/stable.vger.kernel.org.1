Return-Path: <stable+bounces-141843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9EAAAC9C0
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 17:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D06E13B1DEF
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 15:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E0F284662;
	Tue,  6 May 2025 15:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lm37oZMx"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90184283FF3
	for <stable@vger.kernel.org>; Tue,  6 May 2025 15:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746546111; cv=fail; b=O1/pBLMlcUJgVOuDQzJ19LRqa5E6iKqfIYaQt8XeQYVb5ScWZTNsn/gAuqNHQ4jhYtzqP9EXHd/v+tv9hwRPvmSwNc/srtPHiiqhkktni7MEcmnliMhAqF64uKticC36jwkwPdIsdTIYNLWAfaq48fxmLbNEVKKOyOVW60ZBV3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746546111; c=relaxed/simple;
	bh=V6u9DMQ7ItCfaRNJ+CHD2LbE3qKBxCx0ghsjzQ7fbkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=edJUOqLiLshmQs75IO7D4WFI3xjlJxAX2LIYH7Gy/+mxq5iIGYW9sFDIGWPHpwdckWAUGOTHB4DPqGO6THOU5p9XX2Y0Cd+zXFj7ML+Th4eVHzpvMz6LSn2zaTCMIAT+4CISvb37xTHb2tkDn/xnMSydW5Ad1boyRgcwxyc7Yc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lm37oZMx; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6j1+cLKumuNuylyk+kDay5WRqDUPBdEwD6kktY8dir3VqavkvfI9F9FlaVqQ9+FeTs/E+nV1tFqg5fw0B5UQRDYORd9v8e91185yt3I/o7z69dLNXxNILcduQksLiWPPQ7xlIIhdx3zVdN706l16JTpyFHo3YVRrru6adJdE3aVZdeiAdtgsWKLPT72gjbRtSGfxWNSqNRSEqBrNVGJfRzNekk6gm8+jOB5jvguP/EwgLbI53g8azY41KOuO5Qynt2s5mkTBubuAq373SPdL56v/w4+WXA3AMpwuG0lWnzqn6uREC17H6G7RcGwOjg/jBTh8ceYe+7Zi5b8NHklaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAil9ctgXV55VeBNVqCzVGE1hAqDxoxRxEc2kBa580k=;
 b=DSdC3ha88b2/jnjUn+OZS/zKv/2yQO/2YQdIw6oxgqLoQbAhFIohcN6gOVLuUmPV8OqARuPm0fkJYiBKNM3AET/XlOUdPjvYfvSEc+o9dSYledYCWaN7sIxY0ktSsSJA7peMbKeaQdjeBCjRVuasZd1p6ZmdyyccEqL20vSQo6QAAF8Mu+ZvbYYYxB2HAmAgi1Sf8MWsqAAKEYysZSnwttuS7pjHQWdsxZLk2hcbuggb4qYFBfudS8OvnmVujn/vxXnEv/kY8fuLobt1nDObd69cVYMzJ4UyKTRuCFbkvj18EI2M1IGBrTqfnRyDt2DO2pXdkww5MxFZXwRk2AcLLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAil9ctgXV55VeBNVqCzVGE1hAqDxoxRxEc2kBa580k=;
 b=lm37oZMxeeOktD1HH/zzg17idwVj3OhtpBZAkfNjDnDOSsWtzEeeGdxcVeJrqWdRw8jtH7bxqtubYdx7VJQp2TISHo/al5w3Zi/gc0tpT017OMy9Mr2p8kAFQ+NSX8/tinWiXoZnyosCCVzya52LXTRstSTLid8ijGkzZFMtgVk=
Received: from SA9PR03CA0022.namprd03.prod.outlook.com (2603:10b6:806:20::27)
 by MW6PR12MB8958.namprd12.prod.outlook.com (2603:10b6:303:240::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Tue, 6 May
 2025 15:41:44 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:20:cafe::cc) by SA9PR03CA0022.outlook.office365.com
 (2603:10b6:806:20::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Tue,
 6 May 2025 15:41:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 15:41:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 10:41:43 -0500
Received: from [172.19.71.207] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 6 May 2025 10:41:43 -0500
Message-ID: <abf77771-ca6a-3b29-f5e7-fbb11c53844a@amd.com>
Date: Tue, 6 May 2025 08:41:42 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] accel/ivpu: Use firmware names from upstream repo
Content-Language: en-US
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	<dri-devel@lists.freedesktop.org>
CC: <jeff.hugo@oss.qualcomm.com>, <stable@vger.kernel.org>
References: <20250506092030.280276-1-jacek.lawrynowicz@linux.intel.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20250506092030.280276-1-jacek.lawrynowicz@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB03.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|MW6PR12MB8958:EE_
X-MS-Office365-Filtering-Correlation-Id: e9252e40-1bc1-4f27-4f66-08dd8cb480e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3k0UFkvUHhxa1JuOUxuelVKcm9MUlROT3Z5c3NvODJWdmxwUWFUZ3pybTY0?=
 =?utf-8?B?OEZ4VUcyR2kwUi83QXUxaUF5TS9PUWlMdmFNTzhwWXkzUkl4MG1nUzJWWEtK?=
 =?utf-8?B?clZwY2wwZzFMS0E1d0R2UHAxOHhNUTRMTjJRV1hqTEFhSkZFQ3RpeS9rL2hK?=
 =?utf-8?B?VklRZGJLdTBkNXZQOEZieXFqZUlrcEhWL3hPclJOWUFvYkUvbVo5ZVFLRk9y?=
 =?utf-8?B?ZE1mRVcwT3ljRUZQSDRnNGl6UVAyYytwSEtjNXpxbkZXRHZDVjVkZjFBUHRh?=
 =?utf-8?B?bXp2bW5QN0p2OWZHaEhWd2t2djFjRFBpUmNCWXp2bkVPL1dTZE12dng4OVhL?=
 =?utf-8?B?cGlwTjVsM2xkYXYwODZGb2lJb2pxZk1rMnhpdzF3bkRMZTRMdENsMmc3ZndB?=
 =?utf-8?B?Rlh4LzEzQXJXQXpTUFYyOTB0SEZESHl5V0liOStQUzZDaUJnakg1YVZ3YW4r?=
 =?utf-8?B?QmJieTdXTllxalc1cWlTYk4xcDJKN1pBZDkxZzZHMjAvdmdXUFVzYUpDa3Rk?=
 =?utf-8?B?YlBNcnViSERqWUZNT1o4eXl2aGlKbitBSjh2Vm02M1RIUlRQUTVmV3IxbTJo?=
 =?utf-8?B?Tm5NOFBBc2orWGtMcmRJcFF6WXdBa3B5VXhMZjk2aENqekRBaVowMlVhQ0V2?=
 =?utf-8?B?VW0vUmZ0T3FPR1VienJJKzd2SElESVc3OWU1QytBSS9aeHJSL1RERXhIVGdH?=
 =?utf-8?B?STduVDR6Y0V5TlZqRlp1SmpGRjZUNkNaTG5hZmdjNGpzeG9ZSEhWWFV6bHRQ?=
 =?utf-8?B?eHFjWlRkbGlweUozTGF1RUp6M3JIVk8zMDR6bVVLRFVCWitLeHhFVHBHQzRt?=
 =?utf-8?B?YjBiWm5WUW42WlJ0WFlMQ0JpclMrNkNRSll2eFYyeTVaczE4eEdwZTZ0MXNw?=
 =?utf-8?B?b2t0N3ErYlg3aFJIelRWa2pLd1hocHNIdWhVZ0UwcElQSWFYQ2pVMmpiaERv?=
 =?utf-8?B?RVBIS29Qc2pzYyt0ajhFWThqM09GYjBGQ2NSOUh0QmhkYWFJaFU2L3V6cHZ6?=
 =?utf-8?B?ZEtSK3pHRFNKWFA5dDRrZVV3THphblRZYmErUUZ5TEhUVDNFVlVjcGg1UVov?=
 =?utf-8?B?SjlmOUh5ME9xU043Vjl5VytjUERZQm1sL2ZwQW1zdGFUWExLaEJpMUhtWXlh?=
 =?utf-8?B?WGhZK2oyQk5jck1DQytpVU8zWW5BdWhxV29rd2Q2bDJzWGpzdmpSK1BRYk1i?=
 =?utf-8?B?VDMwd3pJRjNGaEVkODhWeGlWNkFZbFFTTzdqNjR0MjhGOEdzWWhhcWV6RTIw?=
 =?utf-8?B?Z2NiaHl6ZjNQbmFHeGNqZ2FwbkNsTTVyT1B4UFFOTHZDbDZwejBqN3JiMk9p?=
 =?utf-8?B?MkxtQUZoKzM1MU9SOWx6V3NCWFNFczJsQmpwYVRqYUEwSkJOWS9kaTlLTGFw?=
 =?utf-8?B?RWkwaFlEMysxWm9ockIya3ova29VbDVzZU13eHgydDNCdWVHYjJXcDBCQ0VP?=
 =?utf-8?B?SVFQdnRqWlRvaHR3RlFzNytNanhnYXpidndZaHRXS1Uvb1pnZjNIaHlwSzMv?=
 =?utf-8?B?WVIvY0NzcnpYcVhBbmQrWU8rcGRRdzJLOXZSWmJETE9sNjVJR25JWEhQY1Mv?=
 =?utf-8?B?M3RFTzN5bnl6Sk1wUFcxem9aZE0weTJSUExLdDVPSE9zVmZpL29GS3MxSU5N?=
 =?utf-8?B?WlE1Z2J0Y3owaGFDeE5SbnlJWFh1UkxkYXlWSHZUZGVaUHRyU1FIS0hod210?=
 =?utf-8?B?U2REWXJHOTBnbFhkZzdxRng0dTYvdzdaYzZqTkxiRm5xVEZZQ0ZBa2Y1VVNl?=
 =?utf-8?B?bm5abDhXLzR0aUk0aEtNRVF1S0ZlOFpxaU5yZFJZL1A3MlBDT1ZpUXV5ak5w?=
 =?utf-8?B?b2JxcEsyZ0djcDh2dXNSSVFvaXJmZFhON2RLSk9ia0J0WUVwdHNFOXRtcDNk?=
 =?utf-8?B?eDlDNkxBaHF2WmdBV1ZPaEkvTVZWUnZqaGo1b21IejZiTC92d2FRZ2hxUTFX?=
 =?utf-8?B?WTE0U1VONnhjdy8vWE56YjZrVUdXb3MzR3lueFlLQnhKSGgzZnd4ZGM1M3Y3?=
 =?utf-8?B?enJvUTFyMXRqdXhJekt2eGkvYWJrVFBseGE1QlVYcmVLOGkrT0tRQ2s5clN0?=
 =?utf-8?Q?+uSTwH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 15:41:44.0332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9252e40-1bc1-4f27-4f66-08dd8cb480e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8958


On 5/6/25 02:20, Jacek Lawrynowicz wrote:
> Use FW names from linux-firmware repo instead of deprecated ones.
>
> Fixes: c140244f0cfb ("accel/ivpu: Add initial Panther Lake support")
> Cc: <stable@vger.kernel.org> # v6.13+
> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> ---
>   drivers/accel/ivpu/ivpu_fw.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
> index ccaaf6c100c02..9db741695401e 100644
> --- a/drivers/accel/ivpu/ivpu_fw.c
> +++ b/drivers/accel/ivpu/ivpu_fw.c
> @@ -55,18 +55,18 @@ static struct {
>   	int gen;
>   	const char *name;
>   } fw_names[] = {
> -	{ IVPU_HW_IP_37XX, "vpu_37xx.bin" },
> +	{ IVPU_HW_IP_37XX, "intel/vpu/vpu_37xx_v1.bin" },

What if old only vpu_37xx.bin is installed but not intel/vpu/vpu_37xx_v1?

Maybe just put *_v1 line in front without removing { ..., "vpu_37xx.bin"} ?


Thanks,

Lizhi

>   	{ IVPU_HW_IP_37XX, "intel/vpu/vpu_37xx_v0.0.bin" },
> -	{ IVPU_HW_IP_40XX, "vpu_40xx.bin" },
> +	{ IVPU_HW_IP_40XX, "intel/vpu/vpu_40xx_v1.bin" },
>   	{ IVPU_HW_IP_40XX, "intel/vpu/vpu_40xx_v0.0.bin" },
> -	{ IVPU_HW_IP_50XX, "vpu_50xx.bin" },
> +	{ IVPU_HW_IP_50XX, "intel/vpu/vpu_50xx_v1.bin" },
>   	{ IVPU_HW_IP_50XX, "intel/vpu/vpu_50xx_v0.0.bin" },
>   };
>   
>   /* Production fw_names from the table above */
> -MODULE_FIRMWARE("intel/vpu/vpu_37xx_v0.0.bin");
> -MODULE_FIRMWARE("intel/vpu/vpu_40xx_v0.0.bin");
> -MODULE_FIRMWARE("intel/vpu/vpu_50xx_v0.0.bin");
> +MODULE_FIRMWARE("intel/vpu/vpu_37xx_v1.bin");
> +MODULE_FIRMWARE("intel/vpu/vpu_40xx_v1.bin");
> +MODULE_FIRMWARE("intel/vpu/vpu_50xx_v1.bin");
>   
>   static int ivpu_fw_request(struct ivpu_device *vdev)
>   {

