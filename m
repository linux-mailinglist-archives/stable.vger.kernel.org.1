Return-Path: <stable+bounces-231225-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBp1DKuEymkW9gUAu9opvQ
	(envelope-from <stable+bounces-231225-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 16:11:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E77B35C9CE
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 16:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB3FE306726F
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 13:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB69F3A4F34;
	Mon, 30 Mar 2026 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xljrdhth"
X-Original-To: stable@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012059.outbound.protection.outlook.com [40.107.209.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF333A3802;
	Mon, 30 Mar 2026 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774878971; cv=fail; b=JfhaEynt+oUemLWDGtqF7/n4VX68sZBI+AafM53iwwIE2TdieCGt+sFBQdOP6aksBeA9oZksWiPN23/D0zkGOGz0MR9TqvBCDYNp242qiX/as6tWw7XU+zk4NkyL23/XqBvqkJgc/bkdE47lXsfjO824pYlPkX9dNb51cDvC1zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774878971; c=relaxed/simple;
	bh=5mkwGJ1iTwp8W0pn9smSiLyyFQZ0T5jHMf7Hpu4Id08=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iAijIPMjLBsQfGcwptd806Ma16Goi9wXi21TaZ9qFZWKgIixT572O+/PIeKBk3IYnqgqS0oY1ffaEN9aP8EGCofryGvz1ui3AOx2A0NFAOOXCQ/9WoaGwrEDNBG9OdCD408yoP5+W7CU5CsDGgRqGIbSuV2YfNtobdLWQydi014=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xljrdhth; arc=fail smtp.client-ip=40.107.209.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eBAR37slqcEigHjkAQ/0t50XIGUg6NS7toJPy0NvEUb/RXw7XCnBzHx6HNC37TGhGXlBN07H2TKl7papOzCqmkzY0wLTnG3I8ZmHJis/77hHCfKt/0OtAmCJI3ZepSgxcSVPuHxQsJ9mGSUD26CB+jWW2Ql+7WKUdQcXs0QHyAvjlglyhEA/96tzODoTk+ynD0GRy0ZyO/ySJKXICzt5UhgeiaWlIxruap5AH1m9HLtJ67L+sivfd+GnYK+hKrvnrn9gzhidw8bw2EqJtpEUXVlyogbPgfXn2M5VrghfkqmvuQBbQxcc9hx3Wj7VR1zoAY7Qj2OWnFjqWyp9k5yh6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcrbhPP0B8T2ayc50MaAtvGloR3swwGCaCZc1y3k7cY=;
 b=zH9t4q7M0N41I/Pq5dcdqvSvHEBOS0Ef8b63xPebS5uXvQbLehqTXm+uiALI4X9OKVb4/Vbroeh+MHI/bItw99eW+m7adxPMgIP7jiM//Ncv9iPO3zpHp42qKIGT27n2/tSFxWYQnjOWqIQVWlj/pAJlDRH7Gpx662qHfTlzWatNo7fD6JJuTc+TxISAl/WlqJypswqogNGEFJyU9ddUSDGHujiMgz4SpByx8Lpx1HVHs4hczut3ysE6qGDWbl2IP5UxUPVCOa7+bcdFry8IRW/mcODX3J+IRUyxT5Qfg28tuxuRPWpxAksI3jVoEtVapnKz31F5Mp7V9rXVoLlB8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcrbhPP0B8T2ayc50MaAtvGloR3swwGCaCZc1y3k7cY=;
 b=xljrdhthDbSyTaG409K6k25+9/aqVVlXdCJGAW4I3jSYMNYrHfif1y1VASj8blUdkHWLzZeVt8VAPakSTBRZcvfiMMKttvQwZdDvd0XUd7OCKfSvzIcxyvcBI6symgKe2yXYCD4fsPGdoDcAet7lN1Mlx8bCV2OJquNRxYBlnhY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB5781.namprd12.prod.outlook.com (2603:10b6:510:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 13:56:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 13:56:03 +0000
Message-ID: <6b15401c-1fdf-4d3b-84aa-dfc47f430895@amd.com>
Date: Mon, 30 Mar 2026 15:55:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 6.12 3/9] drm/amd/display: Disable fastboot on DCE 6
 too
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 stable@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, "Pan, Xinhui"
 <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Bin Lan <bin.lan.cn@windriver.com>,
 He Zhe <zhe.he@windriver.com>, Vitaly Prosyak <vitaly.prosyak@amd.com>,
 Alex Hung <alex.hung@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>, Ray Wu <ray.wu@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Roman Li <Roman.Li@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 Mauro Rossi <issor.oruam@gmail.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260326234716.16723-1-rosenp@gmail.com>
 <20260326234716.16723-4-rosenp@gmail.com> <2312151.9o76ZdvQCi@timur-hyperion>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <2312151.9o76ZdvQCi@timur-hyperion>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: 3afc57f3-8aa1-4d67-1b00-08de8e6414d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	B+iKvcUIKVfB0zyjCv6uSCnrSFQloFDSTb21oZ/j4WNFbfpCrM8hJhM8l5MT73CCZK5hcQgnRo9g9V/5QvVT59lo1zpDj5kwbAcNzW7HVift+WcoWX1e/N2lPcvAKP/1b7sgNa10KsaKZ3h9i2/i+74/pL0GQ1jnoK1rrq5xe4LvAsarF0zDTNbsHu1b8d4r9uic8L9LNsuLhq/0hJ1K6NuET7mBSCyXv1w0HpYg0HJyHAAkY4a2Ez82SJI3CNyzeZqyeXJM8BfBKTXsNU9gjOnK/jXZ01BeUrfVkBDAp/FQqpFX9+29RGyOriJ3nyxHsYR47DyTdHa3tRqyqjyeEsvNzS6OV5gL5fSIcN0dDA+iZNmrZogZpt9ROTWyW3dSsGUm+wMhKPVNlB9DThUXG/ewJ9LmDphouIYp2KHdoV+uboQzVCuYUJpw7PKOrNyPC2uuSf55qv3MBjheks/pQEypMzLZAZ4dVB970klyYwmNPM6noUKsbC51K/xVGnnANXGmfhzykZFozmnsECNhq1kJJAMnJLgivuIyUJUp/YOVtY2uVeojGK0afZkaXudw11jnrehDlS8F7Rrqqzj2bYelReIdsR9jEOfG0+MyR3jx3NHHufYWPfRdPkelrzIu2nS8n8WimIaT8Gi9Nd2aAmR803LP1sZwBTTaVIc3zWtw41qzG0UEXfgGveerp5BgIXRRAbiBxi8rSOWgRgI8cf/nWg8azAkgTw0FSkzlfs4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXB6SEhEdzRoVkp0VkNOd1ZGRFRYcHpJcThHZnFXMXpGeXZTM2VvM0lVM2Jq?=
 =?utf-8?B?YU00eEtTM0tzM1c1SGdOV20xRDgvQ3ZRc2g2QUVlSmZOZitxNmhJVGNNTXpk?=
 =?utf-8?B?UWR3NHRIckFheWxPbFZHa2MveVlST1NSVXpvYUs0dXNFRHpiVUtZVjhoT0VQ?=
 =?utf-8?B?NFRERy92SzJTZFExYk05Q21uZmFuSmxLU3hocmlOdDhEeHYxditiSTJIUUdl?=
 =?utf-8?B?dWVWSEl4MXpIU1Z1RUR4YVF6K1BqR29SdTBVRlBCLzFocEZCK29OMTNvanQ2?=
 =?utf-8?B?bS9nQUZRTDgvRmhGUnhySWd1L2tobTJzbTJwcWdYSC9aTk1ZcnB4V3Y1MGtH?=
 =?utf-8?B?d2ZpVXpoWE9FcktRZEEwT2x1cmJzanJPcnRma2F3UHN1Tk1zbVNkbVJOOHo5?=
 =?utf-8?B?N0V5ZWM3bGhYSlV0U0ZHN2ZmbFBzVDhybGt0NUFPYW9zSWFvaU1vT2ZFdWVI?=
 =?utf-8?B?eFVOdTR5TmJOUE42aEZrYUpnVi9SaXpkWmo2ZWhkM1l2UmlaTWZWQlRuNXIx?=
 =?utf-8?B?TnF4VVF2c1lkdWV4WG1Kd09xVTNXNnhlN3JXSlZPeFM4a1FWZVN1ZWtHTXY2?=
 =?utf-8?B?SXNPdElqaW9xT2MzT2lQRnR3c1FVaGFrVU5aVDcybGRqV0dvMjQybVZvV3lP?=
 =?utf-8?B?QTdaWFVlTG9raS95emtEa1MrRm1sbWlOTmMvNXBONklRRFNyZS9jSG1ZRTZB?=
 =?utf-8?B?c0toMnh2NkVuYXhzZStmNWhmY3hhd2lHQW9VMFFlUjlOSDZkZnV2V1pvMmFy?=
 =?utf-8?B?a3ZxVlhxUEdaaG5sc2pRaHdYVDdXVXZwdkVRWFlZOU91cFV3ZUdrS2cyeE5M?=
 =?utf-8?B?c1YwMFJCWUVGVVVpS1AvSlBCV1V6bUl3VTdRZGJZUUtuaTZjZTlMdGFOL1J0?=
 =?utf-8?B?NlZkaE9YTi9kY0JjTmthOFFGMHNIMEpYR2pINVJLeXkvYmVLRjdFbkU2R1Vo?=
 =?utf-8?B?N3NQQ2EyQlhsNG5uT2p0T25oRGZzQW5PY3RxVEpINFo3WjJrL2pwMmJPMnkw?=
 =?utf-8?B?aFp2S2RtZ0I3TmpiVUNvMTF4MGdvdG1mRmQrT3dOR2xhOGFrOHZOaFRkRnpR?=
 =?utf-8?B?MzI1RUd3aC9QMy9DM3hnam1TYzBkMElrTDcwZndpUS9jRnk5ZmFKb0ltR3d2?=
 =?utf-8?B?M2twSFJlMDBUZCtycC9sOTZvNlJtOXNrSGNDTWNqMGIzbzlmUlNKZnE4Wmg4?=
 =?utf-8?B?c1ZoK1RvQWtJUXdyOTU4TGhqSVVzYnYzaDh1cE5DZ1NRSzNEamJIZlhTZGRQ?=
 =?utf-8?B?ODY5RHErelZJRmtCd3c4TmVBL2Z5TkYxOENqckdKa24rczRwWmV1Y3pZTnVN?=
 =?utf-8?B?VmJUSy9DbkVnd2dscXIyV1lVR2NValdtbXNjUEdVMkRIUzU0RFBVbVVsVjZl?=
 =?utf-8?B?RVN1c2ljdGFodlBQa2lEMWZvQXZkeUFpc21lSW9tWFB0ekROMnZMM00vQnF1?=
 =?utf-8?B?cVRVQ2VVeDBBNUl2T1ljaUJOQTlLZXF1VjUzclBtc1N3WjhZNy9BMzJ4T2xO?=
 =?utf-8?B?NWJ2VzNPNkdLNkZvWUE3ODV2TEdrRncyd1V0cTRrSklPYW1QQmJqYjlWVW9P?=
 =?utf-8?B?aXVSWDkxYUNwZ2hPeUVYNlF0SG54aysxTFdLcXJsbVdDZXlZcEsvRFo0ZlJV?=
 =?utf-8?B?blNrOHl3WnpGWkl2RHVRamQyaXgwc0o3Q3ZQT0Rya0hsdndBT2NNNEJRTWxa?=
 =?utf-8?B?Y2h3ZXhpLytYSjNQaUtHQld3T05aNXA4MXcwS0J3WGJBN2RFQ3c1UHFhaG13?=
 =?utf-8?B?eXBZNHZNc1FrNm44eEcxcVI5QnpocGRFVlZxVnVNVWF6bGNKSVM0cXFTRnpW?=
 =?utf-8?B?NjJPeTVOS0paYU1BS25RQnNwaFVLOGRkQUp4VDNjUWw1Znk1UGJWOFZzWms3?=
 =?utf-8?B?SGtSMmtSajJLcXFHNTRXRWlpMDlIUHNwMGFvMjhDTnArY2l5MzZsN0pjMTl6?=
 =?utf-8?B?NkVZSmJ4azFaSGdiMlVBZkFDNGtHYmFrNnFLakhDYStsQmwxTUxTU0lHY2JS?=
 =?utf-8?B?MXZxemZCNUdMMVhzM3IrVlVDbjhEUGFtOHhNOC9EOEVYU0oxYlhQdUZpL2Za?=
 =?utf-8?B?UXpjZFVPMGZnUUxmYzNjSXlRSDhRSmhYS1ZGb3VSVFpST3FCVW9VbloxRGZK?=
 =?utf-8?B?Y1FLRUdPWUlRd05LK1oxM0lvMU5DeVcydzQ3Zld3UHdpQzFmV0hCNGx5WUcz?=
 =?utf-8?B?c2E3ZXdEdEtpcnl2cHA2N0pybUxiNVdLTW9JTFFlSU9xTkpMZktDdWdvOWZK?=
 =?utf-8?B?enZpRmhyaHVLRlh2QkRsOHlvTWtHeE5FdWFhcXhndmVGMWpLZ0hwZWk5cC8w?=
 =?utf-8?Q?3DYj4v+NhR4HZplb/T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3afc57f3-8aa1-4d67-1b00-08de8e6414d9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 13:56:03.3506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBcfhODATSzH8taxqtJbSca5yaPf5DkOzRvnlWPaaMcSmu8vA2obvy/5iSXKy9mH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5781
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231225-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[amd.com,linux.ie,ffwll.ch,linuxfoundation.org,windriver.com,igalia.com,gmail.com,lists.freedesktop.org,vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E77B35C9CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/30/26 15:16, Timur Kristóf wrote:
> On Friday, March 27, 2026 12:47:10 AM Central European Summer Time Rosen Penev 
> wrote:
>> From: Timur Kristóf <timur.kristof@gmail.com>
>>
>> [ Upstream commit 7495962cbceb967e095233a5673ea71f3bcdee7e ]
>>
>> It already didn't work on DCE 8,
>> so there is no reason to assume it would on DCE 6.
>>
>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>> Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>> Reviewed-by: Alex Hung <alex.hung@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> 
> This patch is incorrect and should not be backported.
> 
> (Note that the error is already fixed upstream. For stable kernels IMO it's 
> best to drop this one.)

Is there some alternative which needs to be backported or should the old kernel just work out of the box because we never enabled some feature there?

Apart from that the patch set looks good to me.

Regards,
Christian.

> 
>> ---
>>  drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
>> b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c index
>> df69e0cebf78..7dc99c85b8ea 100644
>> --- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
>> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
>> @@ -1910,10 +1910,8 @@ void dce110_enable_accelerated_mode(struct dc *dc,
>> struct dc_state *context)
>>
>>  	get_edp_streams(context, edp_streams, &edp_stream_num);
>>
>> -	// Check fastboot support, disable on DCE8 because of blank 
> screens
>> -	if (edp_num && edp_stream_num && dc->ctx->dce_version != 
> DCE_VERSION_8_0
>> && -		    dc->ctx->dce_version != DCE_VERSION_8_1 &&
>> -		    dc->ctx->dce_version != DCE_VERSION_8_3) {
>> +	/* Check fastboot support, disable on DCE 6-8 because of blank 
> screens */
>> +	if (edp_num && edp_stream_num && dc->ctx->dce_version < 
> DCE_VERSION_10_0)
>> { for (i = 0; i < edp_num; i++) {
>>  			edp_link = edp_links[i];
>>  			if (edp_link != edp_streams[0]->link)
> 
> 
> 
> 


