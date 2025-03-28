Return-Path: <stable+bounces-126948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C09A74DC1
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 16:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6839F17B10F
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 15:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D041E4AE;
	Fri, 28 Mar 2025 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0FPd7nRc"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12hn2225.outbound.protection.outlook.com [52.100.167.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB92CDF58
	for <stable@vger.kernel.org>; Fri, 28 Mar 2025 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.100.167.225
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743175890; cv=fail; b=nz5rgUwwgd0bmUq+FrbhUFUHQJgP/NqhCdmA1mBnBHDrVTO9gLewu+Hm2/UoB6F4zCeMTMIyCArLZnTZwc0no5Zismz395jM5SMeA+D2bHFcKonrSJ8tmovnfTwrjwfkKEcgpoKsW/UMDYD9MiUxOWVwl+wnVDqcfnnFjXJL2sI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743175890; c=relaxed/simple;
	bh=iPztcy/7CXQ980PP2Rhr7PPAa3f/oa9q5IQ4jHIbQYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pBeVk7rQ+BeL15h+C3o3p4O2ymyl9z09Pk0vy12VXL8yOghT0fwA1rSkLpGqniahoBh1mbvf8jlGlubfUqIQVA7rdpdgi8kaIY6LOaREKyJ6HV45GTKJxckOVmRG/s68bhx6CFy+7vgJtzuP8N3cq4ABosyXZGYxkan7KvcP+2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0FPd7nRc; arc=fail smtp.client-ip=52.100.167.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJ15l39bLaYNo06ZWUEbx+rWyIRL7yXqGkAfUJIL1DoPsORW3XTN/HjC/PbsBA2gATzTNvIu9ERPmzN2uDvDCuvvLviqwdZ2KnLIROETrxCqIV8EVtwzfmdv2CFwX9QheIoG8uecKIkpQt0kbN7zdFewYtgyvdXY2lh0CX0uevqKuln+z9V6QylTJh+LmneSqIkRvutX8eE+FgQ2+NnR+5qihgC1fRoXrad1nGl2cOR98UGt20lC2djx0gmQ6QvlG9eqy+mvMBxhinjzSR6CPuf1DEpj1mRfo7ee/CD+oLlgO+GONf9Wgibi+ucO7lDDlK0WEGcVCna3dObyKijKog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRt4osZxJdVJk49EDeNXvkIj2IxvRifKQZHOpGk90Rw=;
 b=auy8DSzAmghB6OZGsjwf88IsftRcF3pzbcwOm3/59Mqwdq19aV7UXBzJCEfxqJZnYIJd8PzzZzoXbs6bo2DaN1QSvM0YZ5wh0n81LobMAf6vE8eGFfT2HS1B2yPmrtY4Pm9w2l/cuXBqxg72H3zyoHzXTOjyQWLg3vptaFkqOL9xXRrd2f26Z2rBrs3tzypV5XA8RKhtVLjdttc7pj0YB/LvhjZLpBEJqtCmDoZ+33rud3t5f3yiwaMMegeBgiQj74wQLZTDgZoFWuDoy44goR8AbzZubvFA4PnHFjesL9cM7nVjTE04wX6Qegn2dejkFRmp0+2pMGOCU6g80CNpAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRt4osZxJdVJk49EDeNXvkIj2IxvRifKQZHOpGk90Rw=;
 b=0FPd7nRcNgauca8ydLeNw/p4RDDPL9PQPhpAvDZnVrXezrKuARLiQamjkx9qSoarbQJmDtxP+SzPemqsXlkuATFrQTe65zZOOjexXX1GWpHof50eG/KV9jqwP9RM3gN4VKoGaCNo/CO+tsQMBrze8KItwlhlVNPmWErUqPE2UBw=
Received: from PH7PR02CA0011.namprd02.prod.outlook.com (2603:10b6:510:33d::8)
 by BL1PR12MB5779.namprd12.prod.outlook.com (2603:10b6:208:392::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 15:31:20 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:510:33d:cafe::73) by PH7PR02CA0011.outlook.office365.com
 (2603:10b6:510:33d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Fri,
 28 Mar 2025 15:31:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 28 Mar 2025 15:31:19 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Mar
 2025 10:31:17 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Mar
 2025 10:31:17 -0500
Received: from [172.19.71.207] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 28 Mar 2025 10:31:16 -0500
Message-ID: <4af21d58-67d9-c2c5-3ea9-238f65c6c1b7@amd.com>
Date: Fri, 28 Mar 2025 08:31:16 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] accel/ivpu: Fix PM related deadlocks in MS IOCTLs
Content-Language: en-US
To: Maciej Falkowski <maciej.falkowski@linux.intel.com>,
	<dri-devel@lists.freedesktop.org>
CC: <oded.gabbay@gmail.com>, <quic_jhugo@quicinc.com>,
	<jacek.lawrynowicz@linux.intel.com>, <stable@vger.kernel.org>
References: <20250325114306.3740022-1-maciej.falkowski@linux.intel.com>
 <20250325114306.3740022-3-maciej.falkowski@linux.intel.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20250325114306.3740022-3-maciej.falkowski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|BL1PR12MB5779:EE_
X-MS-Office365-Filtering-Correlation-Id: f99154e8-dede-41a8-203e-08dd6e0d964e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|34020700016|7053199007|12100799063;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUVvMVBjd0VWRU9qNkR3R0I5SXEwT3V3Qk1jb1dVMlVXK01oWVdMaUoxQnBW?=
 =?utf-8?B?OWJwN3R2bWpBZXIwZGl4RWVERXFPd1JNeHFOelVsUHo2SDdHRHM4QWJlVldv?=
 =?utf-8?B?RHdrV2JLb3RFM0duQnk5OTRqK0ZZUnFiOFZOdWdGckU1TzNSd3g2NlFSOWhm?=
 =?utf-8?B?Z1l2MlRnTEdqNUhsT0FyMGVyOXc4emFZc05WV3Q4R2tZTm9WVmtkTWduYU1z?=
 =?utf-8?B?dVFLNXp1WlcxYmloTlV3cThZZW8xVlVIaGloZkhLYngwZFR4STBLQ2RBYWFo?=
 =?utf-8?B?eFRucjdGTDF3WnU0Yy8wbFVpZHo1TktuYzdHaUQxM3Mwa1d1MFQ1SDJwT1Zj?=
 =?utf-8?B?djBucDl0cktzdmpCMFNYNmdMRnZOeklqOEVXKzZETkdyUXozVER6NmdEdFB1?=
 =?utf-8?B?Skh0U1lTUjRabG5BVVlib2d0UW03ZlNsb1laZk43cFVyMHM2cEl3QW50NEVW?=
 =?utf-8?B?azdseFhic2piZXFsRlk1Wm1OdWRkZHFDL1NhWkVZazc5OTdjeXMzRGh6SzlI?=
 =?utf-8?B?SzVNMWpxUFRHTklqSjF3OHc5ZDF0N1BTdlVzUWZ0a3M0czgxTW5GUXFnQlFw?=
 =?utf-8?B?dnVCdTJpUWpnaGNSNTZicVlYa3lXSEpLVmdxSnlDcGdKdVlvYXZGVkxKa0wr?=
 =?utf-8?B?R1owTzRLRUpvV0pMcHZYOUo4eFJlZWhSTFg4Q01iM1h6UmliWlhaWEgwOWg4?=
 =?utf-8?B?eGw5UHg0VEpzcUROUGdKVFBHUGF0SCsyNSt2cGJMOUZ1Y3V2UUNOQ2M5UWJJ?=
 =?utf-8?B?cmJsQWFwWHptVFROdnUxcU4yTVdxUUppWlVCblgvekhvZTNlN2dHekpKN1lD?=
 =?utf-8?B?MU4vdUJ3eGJzcWl1ck1jZXJqdTk4c3RmZkpOVU1Bc3dJOUVGT1RBS0pWcFpy?=
 =?utf-8?B?NFRKYm9zcmxYOUJXNTlXKzV4V2Q1Zzdtc2FDbjRaeGl5TFhNZVloMWx2TDZp?=
 =?utf-8?B?Ky9Yd241MGJ5Y0RKbEREdzFXYUpabDExcUtxNTQwUGkwUXRWdFowTnNvbldo?=
 =?utf-8?B?bjBRYnUyZ2xZQ0duVWdXQ2hMaTFUZzQzUnJ5S0V0OUpiNHpjaExpOHJzSEp6?=
 =?utf-8?B?UlhFNmtUQXcvdmRINFFrOHcvR2NSRTRhUjVQZTV3ZUp0eXp5RVpJVDlEYlcy?=
 =?utf-8?B?M2o0clpDNDZ6ZVY5OXVpM2dDbmM5OEVmS0JXM3Baa2c2Y1AyaWVlcEkyeWUz?=
 =?utf-8?B?ZWVKbjJaT3NmSktBQUxMQW9TTmZ0V0duZDhack03K0lzUDZzR2F4VUQwanJi?=
 =?utf-8?B?NEd3ejFhVDhta1o3dlAxZWlrLzhLaXNha2oxcmk0RU9qb3pac01MQzN1TWV4?=
 =?utf-8?B?c3l3RVBob3Ftd2U5NmJVd2t4NlJjdVUvWHpZdit5a1N0NWFrdnpHSWlVVm5p?=
 =?utf-8?B?RVRQRDIwMzFUOWkxNlJMeFk5cENzRXJOMHN0b2cyWVYweHMveU1KdXM4TndQ?=
 =?utf-8?B?L1E4dUdOaTgxSklicjlFZ0VPbHJUdnVoRzNZQzNYa01vM1dPbmx4dTU4Zzhx?=
 =?utf-8?B?QTlKVHRBdVMvbTlwbHliVEZyck5XNjUwcGNlb2h4a1JmeStVNTlXdGZLdVFU?=
 =?utf-8?B?eHpqSmp5enp0VjhSSWxPaytFRmdVbkFYeDNGNGp6aGtSSFozdmNnZ2dWUHZK?=
 =?utf-8?B?MHlYU2pORWxOdmNKaVNhTFZhdTN5eThkVHVCVjcveHRKZGE2Y0h0MlZvK24w?=
 =?utf-8?B?dEZ1R1ExYytpd3VZTDV2aWRXSUpIbU8yTXJNZElJZ2VCaWJzMWU0NXpXQWhy?=
 =?utf-8?B?Q1JQYTBIM09VdE1IL2NHUWo3eGtQUkl1WEhQcHROWW5mOEJkZ1doT3JuaXh0?=
 =?utf-8?B?SUh4QU0rbHRnbVpETzhlb2RTWWlEQnpUL1VjWENvNkovakd5WVJlTVFZWFdo?=
 =?utf-8?B?ZER6djhyUFBwL1M5cjMrM2hLQ0J6L2JZeUIyUk5YZjU1RmJKV0NDbGU5amNi?=
 =?utf-8?B?clJMSjhFd3RmMG1tUG5IVzlFeUI5RTRORDlIbXRkM3FPWTd4K0FmYkVYUVFU?=
 =?utf-8?Q?/WSVkYHhK8GL1YUfoGUmaMl3+PxSus=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(34020700016)(7053199007)(12100799063);DIR:OUT;SFP:1501;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 15:31:19.0248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f99154e8-dede-41a8-203e-08dd6e0d964e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5779


On 3/25/25 04:43, Maciej Falkowski wrote:
> From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
>
> Prevent runtime resume/suspend while MS IOCTLs are in progress.
> Failed suspend will call ivpu_ms_cleanup() that would try to acquire
> file_priv->ms_lock, which is already held by the IOCTLs.
>
> Fixes: cdfad4db7756 ("accel/ivpu: Add NPU profiling support")
> Cc: <stable@vger.kernel.org> # v6.11+
> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> Signed-off-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
> ---
>   drivers/accel/ivpu/ivpu_debugfs.c |  4 ++--
>   drivers/accel/ivpu/ivpu_ms.c      | 18 ++++++++++++++++++
>   2 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/accel/ivpu/ivpu_debugfs.c b/drivers/accel/ivpu/ivpu_debugfs.c
> index 0825851656a2..f0dad0c9ce33 100644
> --- a/drivers/accel/ivpu/ivpu_debugfs.c
> +++ b/drivers/accel/ivpu/ivpu_debugfs.c
> @@ -332,7 +332,7 @@ ivpu_force_recovery_fn(struct file *file, const char __user *user_buf, size_t si
>   		return -EINVAL;
>   
>   	ret = ivpu_rpm_get(vdev);
> -	if (ret)
> +	if (ret < 0)
>   		return ret;
>   
>   	ivpu_pm_trigger_recovery(vdev, "debugfs");
> @@ -383,7 +383,7 @@ static int dct_active_set(void *data, u64 active_percent)
>   		return -EINVAL;
>   
>   	ret = ivpu_rpm_get(vdev);
> -	if (ret)
> +	if (ret < 0)
>   		return ret;
>   
>   	if (active_percent)
> diff --git a/drivers/accel/ivpu/ivpu_ms.c b/drivers/accel/ivpu/ivpu_ms.c
> index eb485cf15ad6..2a043baf10ca 100644
> --- a/drivers/accel/ivpu/ivpu_ms.c
> +++ b/drivers/accel/ivpu/ivpu_ms.c
> @@ -45,6 +45,10 @@ int ivpu_ms_start_ioctl(struct drm_device *dev, void *data, struct drm_file *fil
>   	    args->sampling_period_ns < MS_MIN_SAMPLE_PERIOD_NS)
>   		return -EINVAL;
>   
> +	ret = ivpu_rpm_get(vdev);
> +	if (ret < 0)
> +		return ret;
> +
>   	mutex_lock(&file_priv->ms_lock);
>   
>   	if (get_instance_by_mask(file_priv, args->metric_group_mask)) {
> @@ -97,6 +101,8 @@ int ivpu_ms_start_ioctl(struct drm_device *dev, void *data, struct drm_file *fil
>   	kfree(ms);
>   unlock:
>   	mutex_unlock(&file_priv->ms_lock);
> +
> +	ivpu_rpm_put(vdev);
>   	return ret;
>   }
>   
> @@ -161,6 +167,10 @@ int ivpu_ms_get_data_ioctl(struct drm_device *dev, void *data, struct drm_file *
>   	if (!args->metric_group_mask)
>   		return -EINVAL;
>   
> +	ret = ivpu_rpm_get(vdev);
> +	if (ret < 0)
> +		return ret;
> +
>   	mutex_lock(&file_priv->ms_lock);
>   
>   	ms = get_instance_by_mask(file_priv, args->metric_group_mask);
> @@ -188,6 +198,7 @@ int ivpu_ms_get_data_ioctl(struct drm_device *dev, void *data, struct drm_file *
>   unlock:
>   	mutex_unlock(&file_priv->ms_lock);
>   
> +	ivpu_rpm_put(vdev);
>   	return ret;
>   }
>   
> @@ -205,11 +216,17 @@ int ivpu_ms_stop_ioctl(struct drm_device *dev, void *data, struct drm_file *file
>   {
>   	struct ivpu_file_priv *file_priv = file->driver_priv;
>   	struct drm_ivpu_metric_streamer_stop *args = data;
> +	struct ivpu_device *vdev = file_priv->vdev;
>   	struct ivpu_ms_instance *ms;
> +	int ret;
>   
>   	if (!args->metric_group_mask)
>   		return -EINVAL;
>   
> +	ret = ivpu_rpm_get(vdev);
> +	if (ret < 0)
> +		return ret;
> +
>   	mutex_lock(&file_priv->ms_lock);
>   
>   	ms = get_instance_by_mask(file_priv, args->metric_group_mask);
> @@ -218,6 +235,7 @@ int ivpu_ms_stop_ioctl(struct drm_device *dev, void *data, struct drm_file *file
>   
>   	mutex_unlock(&file_priv->ms_lock);
>   
> +	ivpu_rpm_put(vdev);
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>   	return ms ? 0 : -EINVAL;
>   }
>   

