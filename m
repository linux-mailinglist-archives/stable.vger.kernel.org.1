Return-Path: <stable+bounces-227202-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDRQJIBZu2m5iwIAu9opvQ
	(envelope-from <stable+bounces-227202-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 03:03:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 924642C4AA8
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 03:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 653D23025990
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 02:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917BF253950;
	Thu, 19 Mar 2026 02:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="fGRVYv77"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24887481DD;
	Thu, 19 Mar 2026 02:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773885796; cv=fail; b=rYiD4ou44r8rIr4bEX1dCLyqMDri8N8YczH6bdencSQL7bddHY5JCK5lcdERZkQmUY0EkefVfjpAng+E8SHh0Z/Qld0uXqq4SwTCP7HYuqouKk3bDfmyOP/wBz/ZHIAEJl5kpt+ZSpwtxfQAH+wNzwd9OjdZG1fiTNDy6LHFA18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773885796; c=relaxed/simple;
	bh=ewloqGIoNEWSjDyABR4f3uPAxxarj1bfaRCO191U+UE=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=LTb7uLFZRDSJE4X90oZMLYp3r1PWhOuOvi5dWUpHUFiXtLYYwAENZqO2zKf8kTn2ixjwEevEIZ6sbdX1GkcIGrVMMZ8BKObNdFmhAgOwlY+CKdUdUlVOxQFCZIKBckQipDCyOl/7wlW1jSyrMMDX5fvBHk88F+w+8qCTVTlGwuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=fGRVYv77; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J1mgQJ1627247;
	Wed, 18 Mar 2026 18:56:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=UOLG4ix4A
	o7OPzPFdojvCdzABGl6zm/hK9DxxHy6GlQ=; b=fGRVYv77q0hJ9E76H3pK8JZTX
	ljUKY92WGXQ3PcdTVx/d+A/HtDmFesTsD5vEaGwnpOGhh4/wF8wVQKBZYyyWP+Ud
	q13NYEvVxzYkt3uDQQ69PU97eIMMicBUAXa8XeAU44D5MCO5i1LD4YPoOUZynWXV
	e3FlsRem9Wl9UoSA+M0aVOpXnjwUxLDAfM5qNPdjwvmYYTQrNIPpJUmRo82li+wr
	I6+WkvAtA+g0dvB8+mBDFLZj4Y4IH6mH/tfBiHs895BIoKMA4HIKa+fvHYqIuH/3
	/Z08QFY2pOQDv8I5fNw1x53gDsxq0mJhDfzYCzSdWULisgVkGdxHNE9aA5HCQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012020.outbound.protection.outlook.com [40.107.200.20])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cw2y15mwp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 18:56:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ohb2zZHMQ4rb9e5dP1b9cZkoD4cpYyM458kgTCKqzcsUM9O/SWe1z/ERV4OIay9vNkNMGbf382+4uzEU5L1M6Kro6KeBVg+rFchTt9i7R8bD4+w0fhQiEBG0Srxzj926Mq6475q+njHQMJ/t0f6uRExxskKaA0/2ic3ohKIAhn8nZGtf/ZbQ0BSSM1xDkqBhRVCMI9clD7YBQkux1ReGp4Tj38ETjUUA37hoiNcmPsrTQjU5UHjNd3Kbl8o4sBPM5WmmlMZX48gAmYoqp+sNApXD0/Tu8tRX3WxmlDScsPpEBzueqKqSBrVnfGsszDhO3GOHkhLOVpDC+4ZAQLSLng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOLG4ix4Ao7OPzPFdojvCdzABGl6zm/hK9DxxHy6GlQ=;
 b=bOkfwpzSF9YdfZzVzdrSItMACF0Ia/VD+nMrl/O0ZvTFZFIMFdYEz+KgmR2a6hGi1d1oTOS/lQxHPSy8FqLvS0UJOOs98Us41+pfRMVpRlVYl0wTIRziKn2+j+kvlyn6tYQh50xzJEP5CWK9aGZfd5KkSPtBwYYPCM7CmOtRo7kO6pr6OENv5Vwl0mWekw7ocB4DSTEQEdMso/44zd10EFhEDCZIp4YR3MyHgML/Huf93bhPcMDV3ZLtVkAJl5uG9UdDNmq5dlCpHhRtt0+rM3ZS0zE53hJRWYk3C+X6CzOJ3PaMKK0Cu2UG3tEOtGnYmVoENnW+/7RvHufLbYBBQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA1PR11MB8200.namprd11.prod.outlook.com (2603:10b6:208:454::6)
 by DM6PR11MB4658.namprd11.prod.outlook.com (2603:10b6:5:28f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 01:56:47 +0000
Received: from IA1PR11MB8200.namprd11.prod.outlook.com
 ([fe80::e0e6:a2f:a53b:4414]) by IA1PR11MB8200.namprd11.prod.outlook.com
 ([fe80::e0e6:a2f:a53b:4414%4]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 01:56:46 +0000
Message-ID: <813bc5fd-0c35-46af-aea2-90798154daaa@windriver.com>
Date: Thu, 19 Mar 2026 09:56:30 +0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Haixiao Yan <haixiao.yan.cn@windriver.com>
Subject: [REGRESSION] perf build failed after 5cf6e76e4f4f ("libperf: Don't
 remove -g when EXTRA_CFLAGS are used") on riscv64 with gcc 13
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
        linux-perf-users@vger.kernel.org, pjw@kernel.org, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, alex@ghiti.fr, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SEWP216CA0043.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bd::13) To DS0PR11MB8181.namprd11.prod.outlook.com
 (2603:10b6:8:159::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB8200:EE_|DM6PR11MB4658:EE_
X-MS-Office365-Filtering-Correlation-Id: f3d44c6f-f447-43ce-1350-08de855ac67b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Po9TkFaGdffh2YKCKGUWBDFk83nQ4xYUhDHPgziW7mTBtWLGZo1pkdQjhQ9TABVfarcmHaRIdMUk6tQrci66vC2RhRwlUKb2Nu/BdZwrcayymdLS8pqyI/ujg2H2URoDzGuItTOldocz6uB5j73gAeYv1gRwWM5hQjhh8qJbKY89Z4mhTW3sRt0AFhi4IHOSOQzbSALm4ENP/z4+bar22xfAYp0kTKkzg9xVwGc07AIQHZpGepiwCOU8Lj8eqOzGVwvDEnE2ugZpqPvl+jso7DR9N8wVvkzTvtI18D8tL0Ey/Y1IU5ObLXlzWKckig0Rw54+05X5Qxcs2VMOz33vuSaoonFfXKaAf8ABzOasbdTzmyRRGFVG3bFgepucLLEwJsGMLLsRPWpq4stL+qK404bN9+UYkfvlEep6s7QZRYMVJQpce8TSR/TtNtK2WuLXZ0Dcb4o4URn0Z2rH7Qwbl1WiqH/6iVK47MKmJQsVq1sGu1c3yGBmJNGRuetV9OMM7CEow4DaxqoxDmX+yvGOt3P23p9aoQiDSfuqfmf6Pa5d+bpDBemUhb2Ey+/DEsZofVMYqSOUQ7caKDOBQiXGrfWu7sJdr6PlW3eJU4y82xv/YZMc88FM+aImRnc0n+QsZykY/PYQYQY+BjnNFICJdvlsgB6IbnCS04EjPky5fW9SDfY7DNsM+aqGxjLcIB3XBBq+IHHUCUUAaRDzEa3lFhvE6UWbP/1mkFujXmrc0sI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB8200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TElWZm5iS21BeXU5dVA0UnZIdFlCVjE4dkM1aWpQQVpCZ1JNa3NCTW9rcmtM?=
 =?utf-8?B?cytjaVZVUXF2QzJqd1ZFZFpzOWtUbTcrN1YxUzNOMGd1Zjh1aDFjalNLd09F?=
 =?utf-8?B?YjlDVjJwcjNyUWxaNE9tQVA4ZHUzNkZ6SFRRWTFOZlQ0bXhRaU90eGIzVVJo?=
 =?utf-8?B?SVltUnlUNW9nQlN1bmZrVTRTa2F6V1Nvd1I4RytWSmpjL2lYQ2o3WTRsNXM1?=
 =?utf-8?B?bi9kRVJNSTJ4ak9WOVk0cVFvSmRhNkVNTXpManIzNGJBVFgxanRPdmNzNGxL?=
 =?utf-8?B?SzFzVXEzYjFRdFg1anlSTGVuNGtySW56SmlFQ0pkTGpKQUtuc0FIemw0dFF4?=
 =?utf-8?B?dFUxWU1mWkdGNXJsYllxWWtpNlArWjl5RlBpRUNHclBJdWtZMXAxeGJ1bW05?=
 =?utf-8?B?bXh5T0pDZkhQalpsc2IvNEptV1dWc1dHdFo3ZDhGZlhRK0xLeHdrSXIxcGk5?=
 =?utf-8?B?QlMwVFBHY21IRnlDeWZ5c0JLcDdnOFVEQzhPY3VnNGMydUY0Y21oNTNyYXJv?=
 =?utf-8?B?SlIreDZiYUEzWkJKbFYrNHBPQTNaUGhtN0NHUmJXd1Q2aysydEdQTUJub1ho?=
 =?utf-8?B?R1RQNFQvdFV0OGcvVzBpV1V3T2FXL3loejBFUHVqdHlnYnZFdFc0Y0F3MExw?=
 =?utf-8?B?bFQ1eFU1NUd2QUVPRE9uSDRvdkxzSzRVNldiRHNkQXpmREV4UTU5T1Y4TitW?=
 =?utf-8?B?TkJ3cnpzVkRxV0lUZlFhMDdPaTk1R00xbDBJa1BhUGU5WDBPZjdUblB3UVUw?=
 =?utf-8?B?WTFRSXg5L3ZCYVVXMkE2MVJmTU8zQkwvN2hTcFpXTFJTYlZlcER5MkRSMjNE?=
 =?utf-8?B?dThZdmpFUmZ5M3RDOFdGSEpTdVRHb2xtUXFCNWYzQk92dEFQWllnYklLWGJu?=
 =?utf-8?B?Qmd3c0V5WnpwUGFja0Q1c25GRFA1UHc2cFhia25ERUtlZWQ3MTRJblQzbnVj?=
 =?utf-8?B?anNLSm50SW9Wc3I1YVdpNGZEQTQrMFVRVTBNdEkxK01haWVaOWpSdVcrS1E4?=
 =?utf-8?B?Um9kZlNDdHJYa1dndTYvaUM2b2hEZkk1U3RadjZoZHRHNjhTYjQ1Z1RpU0Va?=
 =?utf-8?B?V0QxdnkzeU05TjJ3dFZoRVhuckdJM1VjbDMvYktmR2FLWUt5aGxXSUhac0dw?=
 =?utf-8?B?VFFHRUZMOU83bGl0UWt6WFBmV0JlYXhiOGJLdzZ1Sy93cXB2Yi9HenRqaXhV?=
 =?utf-8?B?YmsrYlJxUWNYZENIYTdYSXlzSzNaaHNpMFo0dCtPcmMzdFZjK2lkYTBsTE9u?=
 =?utf-8?B?bHZMd0FrdGEvb2R4UG5YRGpFYldNc3dGcm1XMHFKSXRtRjd2dm14OGpzV29l?=
 =?utf-8?B?WGNwZklSMGo5N3V1a2lEZjVtVjl5ZVBBVWNuVTBNckdZckU3Q0ZJL3FTRzky?=
 =?utf-8?B?blliU1dmZmhPLzdURGU4d09LaUFlVXU0U0VhSEZLWmN5VWVDRklkSkRveWhy?=
 =?utf-8?B?NlQrUUlvaXF6ck5kMWlTdlpsa1pFYVVUTVozTTIwMFl6R3RZTXh2T05EckVH?=
 =?utf-8?B?WEl2cHNaa04vdDVQTTUyZjlMS2xmeXVtLzg3OHdOZmZ0VTBYL1piK3JuS09I?=
 =?utf-8?B?d2Y0SkdaZ3BIcWh2RlFtdXdxNk1PQ1E5aWF5TXJBZExQZkczQTFqQ2tvTnZ0?=
 =?utf-8?B?cDBuV2xBOGhjL2l2emxUMmtZREFQRkJpemNJSGhJcWtPR3pnb3BEU3RqcXJ6?=
 =?utf-8?B?OWpMcjM0TnJwUnhsbUlvVjZhZDVrbWVFaXJub1pNQUJXMSsrTklTeWhVYUFp?=
 =?utf-8?B?S0xYdjZGQUw4Y1JtakptOGF1aXoyR1FZY2FGUTZZNWJKRzg4ZEVLdFhCU0cx?=
 =?utf-8?B?djh0WHg2c2NuYWZPYlJoYnZBMHVjbUFOdXpGR3hWeXY0UDVWQ2dITTRtOTBC?=
 =?utf-8?B?TTN4M3pnQ1pHaytwTFJrL0VoSCtSdGkrVmYrMkdydDNaY1lnaEl5bm5pUDhj?=
 =?utf-8?B?TXR0bXR6SHhrN1JCdjdXUDRTOEhwb2cxU0RXeWVLaEllQWV3Zktud0J4a1Vi?=
 =?utf-8?B?cy9oM3ZNVGo0OUNIbVgxcGp2R1pMaUNSdllDWU9ZdUNMM3NXQlFnNFpzWW1v?=
 =?utf-8?B?blNiUUFCRkFlbXV4U2VNSHR2d2RRTnRNeWVBYzFtMXllYUQvZVlvZ3NqdHVJ?=
 =?utf-8?B?d1ZQN1N2RzdaenpoMlZiWDB4NFJZT0ZINlIvc1hydjdraGRieTNoWkJ2d0Rv?=
 =?utf-8?B?NDU2WWVIWGNJTkJraFJKRFM1Vm9JelREaHhDbjVqZGdSTERXdEdLa3VyZ0dV?=
 =?utf-8?B?UEF6SzY2d2Zld1JnQjlXRlhOOWpac09PS0VjSE9zU0xrbDE5Ym9pV0hoam56?=
 =?utf-8?B?WUNNUVJnZnh0VFZhaGphL0ZyZE9Ic1F6cmgrcHEzK3lJVysxWU9VM3NLTUV1?=
 =?utf-8?Q?5b+qzwLuq5H6R4Lc=3D?=
X-Exchange-RoutingPolicyChecked:
	bxitE7LvBnzs6sDYuVW+/dXdgmOyoZRcHu67My0ZqfGQg+pjFCHMj7qQWLRjzYmz5q4U6rkjEyVvVkbHTTrtbVeZknjhanld+sWrOLZfTmZXj0CQBkc8z3hLH9eSuwkiCMaBCj9OyKCpNtVxQSsfPbIB3pZrsDpEauifuAfL50k2lIhTLD2Uy7Nfo8UAdq9u4nbYBpe//0IDeVr1Q/a2C+TKRPKimz38EW7PE6xZ6m5pm/E617laJ56yjdEiiBcHRVEsiEOHNou+mFssh5v8mKGIQI8oZnBnuxraHTq5o+ihBjBGnChC9Al/qL+BxjN5s0zDHoqDl5bo8YZ37bAE3w==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d44c6f-f447-43ce-1350-08de855ac67b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8181.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 01:56:46.7202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dSYsKW4zymmrFKTL7iVgSozVlWGvMz3fqCQwLWhkfzaHjHgEALO4bVdZdFAG6zS2+ZBn2p9SSe7Gjl/13uNLGr06ovYOsHPTlEWqPO5md7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4658
X-Authority-Analysis: v=2.4 cv=CekFJbrl c=1 sm=1 tr=0 ts=69bb57e1 cx=c_pps
 a=Og0UtPbLppQH9mpfBaDriA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22
 a=VwQbUJbxAAAA:8 a=iGHA9ds3AAAA:8 a=mDV3o1hIAAAA:8 a=vpkhIxmY652di75XKZ0A:9
 a=QEXdDO2ut3YA:10 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDAxMyBTYWx0ZWRfXx1Jn13jciimF
 i3M8En6sQtRH5C8inRomfauL9z6hbHGAkRe8S58DNb05ydYcjfeYq2hoLfaVlKvBkGqDj6fHcUt
 6CUXcS7prI0va44r17so6FshONiXW7+Bqg9ojx/vexFd/Iep0Do99Euji8ANjD2Drhz15EV3oG2
 VepM314U1cQdwO4g5KUiTk/mG9dUkxgA+exhkv7nWzIuF7ecbQRViNZkGULLjGvR6a/SrosYUjr
 KQAPnEqsGdlZxffOsXKB6d6OzUToy1lbDWK9A4wY5x8XRacQMAfKhIaFqkZdFVoDbMLdwQ7ydV0
 h5zr4FClo3nfTIbok/IcyFlQp1OaHC855lh8/MpFwU8gxtGf8t3rzPMt9btKsQLzh7JhCBWphqo
 GX+9CepFGAPuf5GOH2H4cUKMcMlx57L/pro7+GXi9Z8hh4XJYqt2L96wTTEcVCxZV8kYZA3edDO
 SKbSJu/caalSFZLiCnw==
X-Proofpoint-GUID: OU2ka1KdJKdEViMV2kuh7s2d3ctNyc5y
X-Proofpoint-ORIG-GUID: OU2ka1KdJKdEViMV2kuh7s2d3ctNyc5y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_02,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 adultscore=0 impostorscore=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603190013
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[windriver.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227202-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[yoctoproject.org:url,gnu.org:url];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haixiao.yan.cn@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 924642C4AA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Commit[5cf6e76e4f4f](https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/tools/lib/perf/Makefile?h=linux-6.6.y&id=5cf6e76e4f4fee54c0056758b639cf4919cffba9)
changed the libperf Makefile to preserve external CFLAGS instead of overriding them. As a result, the -O6 optimization flags from perf's
build system are now inherited by libperf during compilation. This triggers a false positive -Walloc-size-larger-than= warning in GCC 13 on
riscv64, causing the build to fail with -Werror.

| cpumap.c: In function 'perf_cpu_map__merge':
| cpumap.c:422:20: error: argument 1 range [18446744065119617024, 18446744073709551612] exceeds maximum objec
t size 9223372036854775807 [-Werror=alloc-size-larger-than=]
|   422 |         tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
|       |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
| In file included from cpumap.c:3:
| /buildarea5/hyan-cn/project_yocto/poky/build-riscv64/tmp/work/qemuriscv64-poky-linux/perf/1.0/recipe-sysroo
t/usr/include/stdlib.h:672:14: note: in a call to allocation function 'malloc' declared here
|   672 | extern void *malloc (size_t __size) __THROW __attribute_malloc__
|       |              ^~~~~~
| rm -f /buildarea5/hyan-cn/project_yocto/poky/build-riscv64/tmp/work/qemuriscv64-poky-linux/perf/1.0/perf-1.
0/libapi/libapi.a && riscv64-poky-linux-gcc-ar rcs /buildarea5/hyan-cn/project_yocto/poky/build-riscv64/tmp/w
ork/qemuriscv64-poky-linux/perf/1.0/perf-1.0/libapi/libapi.a /buildarea5/hyan-cn/project_yocto/poky/build-ris
cv64/tmp/work/qemuriscv64-poky-linux/perf/1.0/perf-1.0/libapi/libapi-in.o
| cc1: all warnings being treated as errors


Steps to reproduce:

git clone -b scarthgap https://git.yoctoproject.org/poky
cd poky
sed -i 's/af240d7d57ebf66e87bc2dff34855e630a97ead1/5cf6e76e4f4fee54c0056758b639cf4919cffba9/' meta/recipes-kernel/linux/linux-yocto_6.6.bb

source oe-init-build-env build-riscv64

cat >> conf/local.conf << 'EOF'
MACHINE = "qemuriscv64"
'KERNEL_VERSION_SANITY_SKIP = "1"'
EOF

bitbake perf

I have confirmed that:
Known to fail: gcc 13.3.0, 13.4.0
Known to work: gcc 11.5.0, 12.5.0, 14.3.0, 15.2.0

Not sure whether this is a gcc bug.
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=124549 filed to gcc.

Thanks,
Haixiao



