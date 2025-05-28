Return-Path: <stable+bounces-147909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B7CAC61D0
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 08:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60CA54A31BE
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 06:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4444821171D;
	Wed, 28 May 2025 06:19:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38045288DB
	for <stable@vger.kernel.org>; Wed, 28 May 2025 06:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748413146; cv=fail; b=Mf2qsZiOjLop6YbH8QW7hegZazUZLwxzGOffeHk5k32TKa6ipFgoVoSMTXuE1EvE5FAZxOV6fmTpoXbzFVU4XZeabOVnFbmPkbUj9X4wNLmUOj2BQ1VR4DYlqLGH2GHlGJwNNgoBMoT/Jsf3MiDPwi6Dryz+mg6a1ZQxuI/N4As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748413146; c=relaxed/simple;
	bh=3CiZANDyJOg/E/VWhaEwccJ1WycTm5PZ7RGgecBXOYM=;
	h=From:Date:Subject:Message-Id:To:Cc:MIME-Version:Content-Type; b=VCqMqUV9K8Ee5YPZqp7yKtM63bGjj/SBzbZVSITllmlmz+PN+3jNAKJbOZEfJPhIxIFJhC535wnIIwZJLHeO2XdJY/cV6nsmI3rooaHAsyA3jfSWl7oRqHQ/nrLqUuO0ejRYoBBeIRWhC8ylZ50lbJg1RWHzOAsscPPNZXzx4dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S2mVrV007496;
	Wed, 28 May 2025 06:18:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46u5393p65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 06:18:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flH63BPSxw4z9rrpB+g1sjHO4Hsza5qid1FiT/rUjEYv9ToTOvPIui4dUCQYS/CEn0/leigPXeF8vKuiFzeabfq8ZtaSCuSNHUWPNMwXLLDXNrkQMjAFsHKd9HadJV6jJ9WBBcnJwyUi7/XiItgGfAwZ54VjE2uEt89hnN/6yw6EGL4E19bLa6gmY2lPC7CcAoAaoL9z0dWb/23xLl87zrgwm4FGRAQHbtz+TMrLliOOOojqObN2Q41rqH4ZxFC5yaeiBC9uvgPSe70+JXTILY3h0TmD2KY8PMGUMgSmmrO3pQs1w0PxBVldyzWvzjcSqtfNregBTRG0TkeUwcsrzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CiZANDyJOg/E/VWhaEwccJ1WycTm5PZ7RGgecBXOYM=;
 b=TSz7irT1YJaGPk4kxq8DIkkg4XukC2dAtBUWdI8BecKDuKeriRnMWII6JUTgp5xSO+V/y5iAu0dZeUXPYDfGfDjzIY0FAWPUDwU0TQoV4aXb3zhD+0GTRsPJ/bzT7U4lgDvKGwRchU3eoBzBfyYnLWlaUujO8gbCNn78Juz9lwD4TpSby3Wi+j79oYtnq929761qVozcC4P4h1WbNS7poOxbn2sXzyujeLEspbuHMiLp96VDTCIOJpERGxlYGPGk4QggLJ7uUWPVO1+dnuuh9YYsxN8PkbFJ2rHEU+N73u6ES9wKln7GutXo7YSZs2XUlhgykzKvbvBaIp5AHD59gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from substrate-int.office.com (2603:10b6:510:1ac::9) by
 PH7PR11MB6698.namprd11.prod.outlook.com with HTTP via
 SA9P221CA0017.NAMP221.PROD.OUTLOOK.COM; Wed, 28 May 2025 06:18:44 +0000
From: "Wang, Guangming" <Guangming.Wang@windriver.com>
Date: Wed, 28 May 2025 06:18:44 +0000
Subject: Recall: [PATCH] selftests/vm: fix split huge page tests
Message-Id: <MFS3H2YW9QU4.KY2C6ZBZFZIT1@mn0pr11mb5961>
To: Guangming.Wang@windriver.com
Cc: xjgwwseu@126.com, xjgwwseu@gmail.com, stable@vger.kernel.org,
        ziy@nvidia.com, zokeefe@google.com, david@redhat.com,
        akpm@linux-foundation.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-MS-PublicTrafficType: Email
client-request-id: 6a62fe42-d49b-8def-a194-02164cd8e6fa
request-id: 6a62fe42-d49b-8def-a194-02164cd8e6fa
X-MS-TrafficTypeDiagnostic: PH7PR11MB6698:EE_MessageRecallEmail
X-MS-Exchange-RecallReportGenerated: true
X-MS-Exchange-RecallReportCfmGenerated: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWpqM0NhRGc5ZlVweHFoaElrZUh1WUI5RHZ2dGNvQWdPTkFWUnFjdnpQbTRN?=
 =?utf-8?B?RDlFbGhBSC9TdmRhR09OTnppUGk2Vy9nSWVURGplR212TWpxN0hMMTJQUG5F?=
 =?utf-8?B?ZjliS2JURW9hM3p0azFPdmJvL284YThxQnZ1SEJwQ3NTbUVPREJDdStDTUdB?=
 =?utf-8?B?YStpZVdxQmdGeGo0K1N3aGErWG11L3BOdnBUY20zYTN6Ykd3eW9jWlBtelpT?=
 =?utf-8?B?NjN0UDVqbXA2US93cERlT3JPQWRhV2ZweThMVW0zNVk2eVp5NDNnb1lreWZN?=
 =?utf-8?B?cy9HWk50TUhnOW5yNXRaeWw0U1ZWTkcxSzNKL3NseE5VOXJqRGNGUXFYTTgv?=
 =?utf-8?B?VStMV1B6c25jd1E1VVZrODJGZ0pZcXp3TzI4RGdtSkwzYnBkSExSQkJBeE9B?=
 =?utf-8?B?eUJuM25ud1ZrQmV4MlBWTE9DTmI2alc1U3NsUTdqcjZFYllsK2ZaTE00SWI2?=
 =?utf-8?B?VzBySUFqNFNRNGNEOHpnb3ViVVdvZklLcmZIZm5URGVPb0JSZzZ5VjRYTTNx?=
 =?utf-8?B?WVZXdUNCS3hxdkRqWlN5aVV2U0VkMmlmSEw1eXR2RzlLdXhpVkpDWi8vclg3?=
 =?utf-8?B?UXR0Syt3NGhndzk5STRLSUVoVFNJNzE5MldTbDl0VHdxMkNqZnYrT2VKL0NL?=
 =?utf-8?B?RmpvTzFrMk5OVkFSb09qbnZ6K1hwMHN5blJiTm1IZU0yR3ZwM1RMaERtY3BO?=
 =?utf-8?B?VGxkaXpLZ2ZMS29XN24yMTNqa1RiaWhOeTd3NnNkbDlzeGdocnZrRVRmWVI4?=
 =?utf-8?B?bHZqbG9lZnd5MWdWQVY3ZDNBMUt3QjE5QUFKOGJjQmZPRTFBYnd4UTJlcmg0?=
 =?utf-8?B?WThTVUVUTVpOTGNoN0ErcjNHODlSc0R0NURqSWtsT1gxTkJRMmc0WE5KUCtq?=
 =?utf-8?B?MUtwejZRbDZYTG1Qc3ZpbzZrVjFvYU8zQmQ0dU5vSFlFY0NiRUEvMlY5anNS?=
 =?utf-8?B?elJ3bW5zUE1rYlJBMDkwOHkycVRQRXNVQktUTTN5K2dYcXZ1Zy9weVV6K1pm?=
 =?utf-8?B?Zm5pc01Dcjd6alByUVcxL2dVcGRBa2V5eUtuNmM5SFRVRktXWU5mZTZCaGxi?=
 =?utf-8?B?aXRPaDlZczk4cGtYZlhKRDB3MmNZWjZZKzN2d0IybDNGaU91WnRMMDVmWlUw?=
 =?utf-8?B?WE5rNDkwdTJFNlViSVdOTmNNWEhRSTVjamZWb1dST25oREFlVDZXNG04ME5m?=
 =?utf-8?B?S283dWpsM1FYcWtJUWdiWHJ5UGtjbmdTSzhUenQxN2lIM0E4VTJoVEg5SVU3?=
 =?utf-8?B?MlJ2MTROTWZYNlFROXZQOERpMFpyMVBiQnJETGpJb0Exc2VrWXIvaDlSdnZy?=
 =?utf-8?B?Zk9IcEx1Zlh4ajdiaU8zZjE4OGFFcXdaL2NKOGtlZkFNQUZNbFNLenpLMzZj?=
 =?utf-8?B?OXd4c0dLQUpvMEoxUlZrTmtET3E1cFRJeU5mTHRtZWZqcGxSWEJGZnJINVEr?=
 =?utf-8?B?UURrb2dhVzdsRThuSlFGSjljMGNhRUIyeXJDVFBwemxxZTBqY3I3d1NEUnNq?=
 =?utf-8?B?eDdvTC9oNlFGTUsxVVRoeERrOFBHVkp0cVlOYkgxNWNhNGwrREYvTW9QaGtl?=
 =?utf-8?B?ZTZHSmFMS0JmZGdralc4RXVuY243OGsvQkRTL2Y5YUFTeEtETnpsYVpVSHpS?=
 =?utf-8?B?YlJEdXgvY01vVUR1QUFUT0VwOTRrWGh4emJ6b0c4ck5EWGEzWGpKTXdvUzRl?=
 =?utf-8?B?S2p3UkJOSG9OSUFsL1o3bkRPOENSbUtLWVpCd1VKcWtsMG05WUtyckkzVTJl?=
 =?utf-8?B?YUpUU1RSc20xRUdjcnVQdThmQzFyc0dDQlBoQnBmaGlYTHppNWsxVnhSK1Y1?=
 =?utf-8?B?T2tuSGtYTkpXcnZQZUJGaFV4RERRTTR0d05Eb1VwQUU4aFVucWJkUGgzbG1v?=
 =?utf-8?B?WnkvcktyQzlrbFF1aFpPYkNnZk5TMzd5L1B5VjlLM2lrWDFzdkxNV0VkL1RH?=
 =?utf-8?Q?9dXt0jVwsWw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JGPu8O9Klv84mTKOJ0JmCTP815KBZwnR2BOM6IbUWvxWTQCVtDWdbUsDej1T05aPrgQWvwPhDpUgoYdx7AZxebQ1NX4Aao6tAf6PDlL3cznxB/XmdbT6/WLfYeJwea6k49/t+XPUWcRKn0FiO+cVGZQPCSWeXY7CiQ6/R+5XA/PzcFSLAH0WSCD1n6IlBwarxdWouIcC1ezXuG5Fq4kg6yO2T6chOLl1bIkvniAHtihD3GzDlZjQ0/yNw5Ot4h3/Jfo5nwov2tEVYtRIgtJtvwUXhl4TfhLXZfI/NIUYsJqb4+W3lGbC9jsgC70jhFDVHC5NkNw+0kny9l0OQv1y+sbKipn8I6BT4Zm5YdxkLJKku7udlnIvQxKa6cTFql8qDb7mfJ9P9pSCC7G9GFACcFKkNyqEBfBZ7pze4f21T+w=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HttpSubmission-PH7PR11MB6698
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 06:18:44.7068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id:
	c799f473-0ff3-4cc5-3909-08dd9daf8007
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6698
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA1NCBTYWx0ZWRfX+gfXQPcqGEoK 9iDrKYbS1XpM7rDompbOz319NMHYn8Y/hmv0jJaYUuY2kGp02+uA1CbXpEO9mBW9F2aK2Cc7F2A +jcmB/J89IvoOS6Ij4jlwbwWHL9rr/o7Pc5qN36wQejEBDxxiQdn6GVmFvAr2bOTiVxtj0qZ9gi
 6s5fVkbQGXQzJTzGzhQb5XXcFVOD6dzwmWxWuDXPEv76na7OGGPj6+p/2F0BKo/dn4V/CqUZHRQ 3eOPtO+ki5wVG0EDYnwLuyt8XtNfAk8mrkQzAmpxDxvmJcfwgwPYSZ/TszqySkYndF+1F39Byi3 k6QXOC2oOMAmDoHLtvBEMz5uimDYw796ureiFClhJH/w/WGawP5nZDNPacmxvpYX4kFyLnLjw89
 /eB/5YDm8deK33iVSljDueGwo1GBBS97CuZfltkJ5o3XoHl2Zorp9vAnJlQHiu4KdclijD2s
X-Authority-Analysis: v=2.4 cv=NsDRc9dJ c=1 sm=1 tr=0 ts=6836aac7 cx=c_pps a=Hxg71G30CNBv6xsSWT+A2w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=t7CeM3EgAAAA:8 a=ge7kpvZ1htP4POTDIc0A:9 a=QEXdDO2ut3YA:10 a=tXJ-eHhA33EA:10 a=3mRVP2YHa6yGyhpHLZ4n:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: vMXdD2Cx1WQx_a2HlHOyQrAD9FvDOVIy
X-Proofpoint-GUID: vMXdD2Cx1WQx_a2HlHOyQrAD9FvDOVIy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_03,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=739
 impostorscore=0 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505160000
 definitions=main-2505280054

Guangming.Wang@windriver.com would like to recall the message, "[PATCH] selftests/vm: fix split huge page tests".

