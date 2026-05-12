Return-Path: <stable+bounces-245391-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WM8PN72aAmpyuwEAu9opvQ
	(envelope-from <stable+bounces-245391-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 05:13:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0DD51931C
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 05:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50966302515A
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 03:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC1B37F742;
	Tue, 12 May 2026 03:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sucpn9Me"
X-Original-To: stable@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011062.outbound.protection.outlook.com [52.101.57.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C03C37DEA6
	for <stable@vger.kernel.org>; Tue, 12 May 2026 03:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778555579; cv=fail; b=KXCAwsNKh6C+J+flxrUavmqsLfznJzLfhcYl0cr0VdtOCkpTECeHrpHdcp3yQxBbLMK0OgMFwN7nqsa2aTdDIFLNZticPFmx6MOyq+cWwqF6FEErckwvYFcrCdOhyyoj9JyeiG5ACKmzjIiQuI94/UWrrjISBfRolWkCzJTyAXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778555579; c=relaxed/simple;
	bh=LSL79wpb7YqCCU3UEPRIv+J2EodUCIDIVrN52njIpkg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SzZL2j/cJKS2UeMDSAH80irymls80WoWDOPTKV10eVrPTtG9qDAMn1N5qg6ygeo2lfbq/dYtSmDohZB5nDFeZAz7Q/PuH0IBNiIq6sqDjE9vc4BuJxMNGgKhgp7rCl0GE2iEMwdwr8ycR+4QI4j4Xe+FJBt6GakSywesViuT5qM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sucpn9Me; arc=fail smtp.client-ip=52.101.57.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VB68hhHAJd3ecY5V2x4xLqQRBHeCu6GPp5qayDeoKJ3ChdgSqgN+3yQ+6jm8gM6XARfIApFWtAHZdJJ1urNG8mFNZ4+rrDc82149dZptdbDPbpIPJbEyQGfaTGW/3VFGcXFwRnhittO2cRtYFfbvSCf93mVeEdlwCdX+lBOWZvg5zReIIHxZLumt7ejC3KNICdm/uszsOdvYRHuEN5JiHRTTRnxIbYJQeQnlkswwlPoim4DglG+6jxN/J/FpdcH+q4Mf1NHt58BMNiLSU08C70g7G8vrwks3R02dcf61vkLfx24WgFG9Uwh20KMLtKXoltvGlnLrcI8hZ4Nsb208Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7M3+BtRygYFyhNDpS4MvFLaF3LSE9tYD/Tf/F6aHMys=;
 b=wqXEz48OJkrqgrSSfggF+ftyo6fMYFRSq55yJfNrFRsCi97kSy9gfAOGcLyRPJ5x1y5SINAmlyy0ydE4HPcZyc3kZRT+l3KBwXdSwE0WyAfTI0xht/x5gKMOePUZcUa7huvTOF9bxYcEzoXglnCdLEw4hFQvdwfJT/e1HoMyiMbxWhO5qHHrY57WK74CWYzHj9aBeotBqBl9G7NPeUpUwIIJfoZNaPpZ1Fy3dw85AhwOnRmCRddoFNcFqaX9kfjOmd8/iPcP48PK2BtuLiD5Rwo50w4v5tLPcaoPdm2my6vu5BXQlHniMQ43DHoGTQW5fm0qbtsy5bJxWpOrYQmIDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7M3+BtRygYFyhNDpS4MvFLaF3LSE9tYD/Tf/F6aHMys=;
 b=sucpn9MeOSpQf0vE8+FnJWC1aqec7Qwxokm8fAzfuBrjHaufiSHa+w5JSCyCE09pIeJ+6pkHoO1kmFx3YDVjwdMv8OaW8YxV5xoPdGVhZ8fQ9t4AuY2+O1SzwitJsXnn1o9/PWNZNU/pzsY/93gRzzHvuyx8k1m5BaX84s0uzxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by SJ0PR12MB6688.namprd12.prod.outlook.com (2603:10b6:a03:47d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 03:12:52 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 03:12:51 +0000
Message-ID: <e8a6e85b-3c1a-45d4-b53c-f55111011317@amd.com>
Date: Mon, 11 May 2026 22:12:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vpe: Force collaborate sync after TRAP
Content-Language: en-US
To: Alan Liu <haoping.liu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <lang.yu@amd.com>,
 stable@vger.kernel.org
References: <20260512024834.1945236-1-haoping.liu@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260512024834.1945236-1-haoping.liu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR12CA0033.namprd12.prod.outlook.com
 (2603:10b6:5:1c0::46) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|SJ0PR12MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ccef901-7268-4c54-84bd-08deafd45a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info:
	CkAnL8ScYVWPIQd0mJrm7m/mcx8wbRvnKq7C0+a975d1E1BF0BBPm4xlFZ4K7nAPi8G+h6Grut1jOpOdSTrlcInAFVfRWcdh+H+z96SmIhCN2u8kwI+vT1A7z+UGae1+olq21OEdPOfTIlac+QRY7ZOy1zl+05wqoOI8uWa1e4fF3zCcIHAWEV4b5TjIxsMBNLQ6O4XUvmc4POT+m8YZvdB+jPnmSHWuJpe0bQYkX322Yk+BLsjKp/+a9z0/N4q6J1cSfjWD89yiAihPzD2lz07X1hdoJeDBY2vH/a42WyYq4QBWeetYM/RziiSQ8az1WbjftyRX6cPS9dBgynzSJQOVTnV8DiRuUgEp5KBZnb6/EY0ey+ZeFn2iNG/17aBOofE8EQ7IYTQaz4Iatr+21OOmnP/WLj0I5+6L/AsPz9REVwcBM5m+GuEBfKCkXwCq53QCaiPQ2xiLiNDsBa2mdkWvCHic88MP1vABPqvKJUaE8ilvxOs8USjeeHepRWbNMq2TvlL8IwWLZb8m5h2hbb7m91MyYQ8gqjNprZUX30uN3mfYDGj7yRMzsyIdDGmV9/CLpRQEmrVN8jGXszR1Gl3gLE+Kft9jzk/5fG/TgEQMYRxISWLz2nL8rOaMrhyay0HPAqzJWTL1jJyBanQS0Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(3023799003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTVIN21UeHFKVnJzQ2xiUGc0cEJzZG85R3Q1cm5oTGR3UzZib21haWFBdnhO?=
 =?utf-8?B?UnQ3R2hYQkd6UlRVM2x3bGhtWWxjbGh4MzliQVJSbjFsdDlqaWk4MVVVVzY3?=
 =?utf-8?B?RGRaOFRMYmdBYjQ5bzlOV0gyWXhWMnVVVGUxYWNtMnJZZFkyVWpYS3NMMkNa?=
 =?utf-8?B?L3krMURqVm50QXdVL0p3MHpnVTJ3N3Q1UmJCdWtXc2FOc2YwS2lFZkxBaDNo?=
 =?utf-8?B?VXFtZ2JQdUJKSHl2QWRDNlZwaDNDc0ZhUGc2bUdjdVJQMklSUi9XODk4cEx4?=
 =?utf-8?B?RVBBR0ZOQldkZjJSQnV6bzE3QWFjOFVUZklldmtqUjltaWZGWjBtQjFSbmcy?=
 =?utf-8?B?UC9aNE5UWklRbGhGMjh3ZDhSeEJ0eVMxUU5SVzJBa2p3UTRPRFcyUVozS3ht?=
 =?utf-8?B?Q1hGaEswL01YMkFaL043RDhVakY3dy8vRjhyaWlRTjVPNzcrTnJ4c2UwRWx0?=
 =?utf-8?B?WHJITTdxb3g0eENaUDNNa01wYWhCdEhBcXJVZUlBWGZXQ2JJVDJOMVNtRmwx?=
 =?utf-8?B?RU0xdHpqaHRtWkhnZnljdTdjN3ZYZzJXOTdNeEovZTU5V3hEWkxNMEUzUGlT?=
 =?utf-8?B?VEx5OC94MHFobVlCWEJLYzVvWG5RR21GSDFqdlduV3lMMSt5MDhHdldTV2lh?=
 =?utf-8?B?WXd1R0RoblRmQ0d4V1RVaE9aZjhoYzdFSUthM21GTnZoWDY4UytmS2VMZU9i?=
 =?utf-8?B?RWxDQVpOcGh0Z242MjdJaHNLd3VNbVFoQkY5RjVNZDNudXJMY0RpS2FYR0Js?=
 =?utf-8?B?ZGsyY2xHVUNsWlJ4cVJDSFJRSHdwa0t6clpVY1V3OHNxZ1N4Tmt2WVN4ckwv?=
 =?utf-8?B?MThTR0NrN3hnSmNsN04rODdiVTFCUDNybm1LbmFvcWhlN3BabS9qUmV4Rkds?=
 =?utf-8?B?KzkzNEwyYUU2c2MxQ25mYUVwNHJCdWJGRVExQlZWZEtiRmVNWSt5cDVWdktD?=
 =?utf-8?B?OHM5aFhIdU94L3A5Y3Q1M2RMWkFOZi80NGQ2Nk9lQVZSd2xVK3dEQkZjRDFo?=
 =?utf-8?B?L0UrSGV2ZE1yT3JGaS9Mam5NQzBxN24wTHFQeXNwNlMzWG1aN29WYkZ3Mmd3?=
 =?utf-8?B?SjdyWVBrRmxIcmJaNmhsU3hYdUhUTmpqQTBCdWwrMTNONGYyY0lmMlRMOVMr?=
 =?utf-8?B?S1R2TzZ0bzJONFNpVlpsd1JyeVRXMVAybUZKaFhFK0loSlltZXg0ZEVCWllO?=
 =?utf-8?B?cGVPSEFYWG90Mk1jVjRNODVZemloSXQ4a0grT2FlckxCakE5SHBXTG5PWTRU?=
 =?utf-8?B?V2kzUTZKa0xFTTZnLzNpUmpxZUpRSUxBNFEzZDAwVk81NU01aG5hTy9ocTA0?=
 =?utf-8?B?cWU5YndBMkpUZ1hlWHgwcDU4QlJ4K2hzOGQrbnpxc0tiVDQrY2hCYjg0YUxw?=
 =?utf-8?B?Rmh2YUY0cXRYY1dJSVVYT2ZEOFlzS2w1Sm9oc2VoczFGTGxpYmd2Um5PK284?=
 =?utf-8?B?K3FsREV5bXJnZHVSQkRaNnRGbE53WStWdEZpb1VEaitSMWNFeTdrZkc2NGxB?=
 =?utf-8?B?ZjgxY3hJN0k1RkwrbjluM2VXdmVSNE9NdmxtQi9LelhyejNhOE5wRmJ2bTBB?=
 =?utf-8?B?VjVnck56NVdidW11U3hPNWVsK1l0MSs3eGNDZU5qZk11Q3BybTZXWTBVeGNJ?=
 =?utf-8?B?WTZwaFZFdkJMcG9NOEtZYitVOFFWa0tMN2Uwc0VDTnc5WnJ2dTdWTGJndVF4?=
 =?utf-8?B?T1JYTE5GSUlDajdYSUJxcVNyVTlZakFSRXVXeVlHK1pOZVV1NERBT0M4eGZM?=
 =?utf-8?B?andtRnpVbjJhMkZnTllDZzE2TjhCeFNtelkxQjlrcVJlRUtxbm1FVy9LQURW?=
 =?utf-8?B?OHU0bks4SHBMNWtHTmVKcTZHeGltR1dPMnk2aW9nN3EzUDNHWmRsendZQUVP?=
 =?utf-8?B?R0laQmNaaDFaNDBBZG9KK1ppY2pIWnA5Ly9FbENFNzhpT3RuUXB5OHpqUUE1?=
 =?utf-8?B?WVNhL1dXYzNQRk8zRmFEZnR0WDdpaW9CRnJFdElmQjNjdDZPNEpsVzlMQnNG?=
 =?utf-8?B?alp3RjA1QXFJeXhlTTVTbzV6eWp4VEpKMWVpZFArcDRuMm9tUUFha1EydW01?=
 =?utf-8?B?N0dqN1VsTjVrcDBnOW0xMGg2MmdmVG84NCt0MEZENFFLS0hCZm13QjROKzQz?=
 =?utf-8?B?dnZSSVk2Tlo2V2xILzN0eVhwb0I4dUxyYm9iMStIdjE5OC9qQkZ4Z3dJeS9I?=
 =?utf-8?B?bVMyZkZ6TXA0NTUySHpqU0ZocHRlYkdXY1pvWUsxeXR5M2taSmtlSEpWZ3RY?=
 =?utf-8?B?RlE5RTJsendEUER6Z3JqMHNRRnNrM2JVZnMyUEErdk1vSEpvejQ1VVVaYlhV?=
 =?utf-8?B?VVB6cmRjc1RYTzQ1Vk9qSjJCam96NXRNNyt4NytpY0ZWRnRjRUZwQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ccef901-7268-4c54-84bd-08deafd45a6b
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 03:12:51.9040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CnzdRD/EdCx6n0tVVL6oWYRTT2/Xc4e4RGS4V26NYTb4XbEx38qgBA0VCk1qhrHU6p2cGKmzcF1rA7QKjMiPSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6688
X-Rspamd-Queue-Id: 5D0DD51931C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245391-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mario.limonciello@amd.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.freedesktop.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action



On 5/11/26 21:48, Alan Liu wrote:
> VPE1 could possibly hang and fail to power off at the end of commands in
> collaboration mode. This workaround adds a COLLAB_SYNC after TRAP to
> force instances synchronized to avoid VPE1 fail to power off.
> 
> v2: adjust number of DW for ring allocation, and improve commit message.
> 

You can drop this v2 line when committing, this is the first public commit.

> Reviewed-by: Lang Yu <lang.yu@amd.com>
> Signed-off-by: Alan liu <haoping.liu@amd.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5171
> Cc: stable@vger.kernel.org

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> index fd881388d612..f27f917e3cdb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> @@ -562,6 +562,11 @@ static void vpe_ring_emit_fence(struct amdgpu_ring *ring, uint64_t addr,
>   		amdgpu_ring_write(ring, 0);
>   	}
>   
> +	/* WA: Force sync after TRAP to avoid VPE1 fail to power off */
> +	if (ring->adev->vpe.collaborate_mode) {
> +		amdgpu_ring_write(ring, VPE_CMD_HEADER(VPE_CMD_OPCODE_COLLAB_SYNC, 0));
> +		amdgpu_ring_write(ring, 0xabcd);
> +	}
>   }
>   
>   static void vpe_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
> @@ -968,7 +973,7 @@ static const struct amdgpu_ring_funcs vpe_ring_funcs = {
>   	.emit_frame_size =
>   		5 + /* vpe_ring_init_cond_exec */
>   		6 + /* vpe_ring_emit_pipeline_sync */
> -		10 + 10 + 10 + /* vpe_ring_emit_fence */
> +		12 + 12 + 12 + /* vpe_ring_emit_fence */
>   		/* vpe_ring_emit_vm_flush */
>   		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
>   		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 6,


