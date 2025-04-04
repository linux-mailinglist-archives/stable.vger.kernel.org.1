Return-Path: <stable+bounces-128282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A095BA7B879
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 09:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BB627A8292
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 07:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178B418FDD5;
	Fri,  4 Apr 2025 07:59:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A0D847B
	for <stable@vger.kernel.org>; Fri,  4 Apr 2025 07:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743753546; cv=fail; b=hggapZnPF2KY6s5OXG3ICUPgnOPOaxKGFeC2lU6HtzudH8UC6tTvglDBs0i5IeRqIapMYtNGP0+6+SpqTChAyUm9L6OHZKd4ifnAmDAr2ggAlrhJR5l51YBDA88VSYtHGXwvyeg7OL2+khOTBkh7DWpazSz9EeQrj2z+Fj0xk2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743753546; c=relaxed/simple;
	bh=WjPMSaU+MJcI7xoKAi6X2jKnFeWzMNIaLxS/jyHC3Vo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H+z7eNRyxdu7fBLqIZB7aI0w/9VWtN/bIUn9XvsD9j0uGdO4IFHZ2iGjX7AY9Kzz9VpKp/zVewjLDLRLz0BRhRZLaKNP/O6UzW0GC/Q539uEAi64tr0H7hXRhcVixdVlLW6qf1YYw5neEA9xOOQ9EwN8jgpNFhvBD9zfxnB7J8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53479JZm022664;
	Fri, 4 Apr 2025 00:58:46 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45sg1u9yf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Apr 2025 00:58:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nrAB4rYWS5sq1xM1mJ0YGsTS0D/OE5wwyQhLu8eFxwzNO9moy9IvSpAItc0tMJduj0BXUs5iQc3XKRLpL96zA+wXPb5w1M9istniX0l9H5+649u6VcmiRioWR14tntlMqbP61VL2F7FHNc8hTpmUVuH4u2wZIRDO7Ycx5sdtxWxEjLehMMXsa71kOOtCTag9K00Ka/yTHr6mvnsnauJr7odVRFmRgCucTYBOgW6J+dtC1L/e5Xyq6dU6zH19g5UjgcJMDYxbyLzoEnPcdEBYFH2xBQLOig4gGOQgDJst6XafWs/AK/D6SGYkZx9HKhlKJXeZhTIFg49Ra/aMSd8nMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KFQBzbG6y6AEI+ss6foxm1hVkobGsP0vEjkR8G3Vu4=;
 b=RtMxa/mmhDraE7GR3ciUIjCE/XNmU9NfbnZw+gEAHooGZHMyV25Y47XEKewk5KdFmUXzuTWDaoEK+AO4lCsnYOfKzScI+EJchOM5SWqadcZT/A3SV/aGIq+MAnpvHY35dNMFMiRMI/zsQpNJ26xKAXRICOfTrGDFaCftM/zBnvLsJXniNeD2ih1FRm4C6B8qAXFA1tF4A7V/1IB49yuw2xaruy7Ymlbl33HLQeT1BhKy/WGL54WSVIYLXSE8dKybGL6y9ZbGdxkeZW8eYq8ddIPMMM/tRv5LYdb+JGRYr9AerwjkD4/VkOYIFr2q5oi3ittwCYJBPH9LxZEj5dCbAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6325.namprd11.prod.outlook.com (2603:10b6:8:cf::11) by
 DM6PR11MB4659.namprd11.prod.outlook.com (2603:10b6:5:2a5::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8583.42; Fri, 4 Apr 2025 07:58:43 +0000
Received: from DS0PR11MB6325.namprd11.prod.outlook.com
 ([fe80::d074:3eea:6500:c94a]) by DS0PR11MB6325.namprd11.prod.outlook.com
 ([fe80::d074:3eea:6500:c94a%7]) with mapi id 15.20.8583.041; Fri, 4 Apr 2025
 07:58:43 +0000
Message-ID: <17b170ac-aa20-4c36-a045-25d2f82e66d0@windriver.com>
Date: Fri, 4 Apr 2025 15:58:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y 0/6] Backported patches to fix selftest tpdir2
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        ebiederm@xmission.com, keescook@chromium.org,
        akpm@linux-foundation.org, wenlin.kang@windriver.com
References: <20250402082656.4177277-1-wenlin.kang@windriver.com>
 <2025040344-coma-strict-4e8f@gregkh>
Content-Language: en-US
From: Kang Wenlin <wenlin.kang@windriver.com>
In-Reply-To: <2025040344-coma-strict-4e8f@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0140.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::32) To DS0PR11MB6325.namprd11.prod.outlook.com
 (2603:10b6:8:cf::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6325:EE_|DM6PR11MB4659:EE_
X-MS-Office365-Filtering-Correlation-Id: 592a3b76-796b-4297-0dbe-08dd734e84b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFpYazlaZWlaWXVodWpmbHBLVklMbDRuZTUxcFA2dUw3WGRsZkRiVzBacXZN?=
 =?utf-8?B?TEVxTjIyZUNuMnBoVVVuQTY3MUlhS0lCR09Fb2NOblUweUp1am1tLzFWdEFI?=
 =?utf-8?B?YlJsMmlNZWpuQnlmMDJjRGg4V1R4bGNjOWZWY0lYS3R4TWowWEFVei9lbEdF?=
 =?utf-8?B?UzZ6aFVNNzFlNzF0akZOcTRxd05xdnZTUWFWUWlhakJDTjBkSjcyNmdpMUxN?=
 =?utf-8?B?N0s2OXdaREx5MHN3dU43RFVuNEt2a2ZoQ0JVRlY1d1R3TDFtRU5tTkJhMjZq?=
 =?utf-8?B?QWpvNDFrVHVkMDkxclNYR1ErdS91bVM0TzlYbGdTWXpoSVo4TUZ1VXdvY2k5?=
 =?utf-8?B?ZEJqTStwbjdNRlNCZ01aRFQrc0VKVnFmQTVPcDRMdHNZSlZyelBDZU5pNi9P?=
 =?utf-8?B?U3lWdFg3MGhMSFBoWXRydUhrN2FuNk1yVVdGc0ttRnlVOFFiRXQyUzRIVGg0?=
 =?utf-8?B?YTJrcTM4a2N0V3V3NEdOVkVRd2JZWVArTGx1WVg5N3dNVzN4KytoZWI3Mkht?=
 =?utf-8?B?SUVvNVpsTHlsNTZIWk5yTHFxMy9HRVpBOFE0ZnA5Tm5ac0ZlR00rbTFobko2?=
 =?utf-8?B?ZmRVQWhTaUdjMFJBcnJmOTByZ1V5bEN6eFRwbG5XcXE1ZjE0b3VwdTB3cjJz?=
 =?utf-8?B?bEtnNU55Y0FDNnJGMHd5ZlBMOHQ1MUJIdHFoZjdKSitDNjVDSGVPeFBPazMx?=
 =?utf-8?B?UXdlaUFFMENZUCtxL1NXcklZcHBHdHlpYnNVMVh6a0FRRDdjS2lZMThvR200?=
 =?utf-8?B?QjdOMTE4QWI0Zi9HdUk0YTM4ZnphREVnS1R1R3ZZVHFmTTNzYng5UHExN25x?=
 =?utf-8?B?bzBNUmgrSk04T0g5N241Q3dLUGxEMnQydENoZUxhVDRoTGU5cG9YLzBXUVFo?=
 =?utf-8?B?VmRlbVcrTFVuTjZlNytGeXVSdWpkdHZLL0ZEcW9Wem5VaGNKdHA0QnFsVExu?=
 =?utf-8?B?TnBLbVdHaHdkZWRxeGVhc1pCNFkwaTFmVjZ4Y1YyYSttVDVOTG05RmhhR3RS?=
 =?utf-8?B?WlBtZUNRZGxacW5WbkdTOWN1UjNkdk9DdEtwYmNTeDBPbmwzZzdobHRSNmdT?=
 =?utf-8?B?WTFvODhEMXJkdExNZ0ZNMk5HWDBSUG5ORzhkYnkzZnMxSElKN2k4a3VQRFVa?=
 =?utf-8?B?c2ZwMWpPemR6Q0x3NGNyZDgvbHhmUmFFUkJiMHNqdjN0N0xiVXB3bzllbFUy?=
 =?utf-8?B?Uy9VNERGbXFQY2x5YUk2akJwalkzYzJpT0I2K3o3QXp6YUN1bVpKaU5mM3k4?=
 =?utf-8?B?K3hJcWF2aFVKcW1FOUZia3FaMldXV2UrYnpyRUJyc1g0eC9tVXVLVnNvMWhn?=
 =?utf-8?B?NzZqU2NrcFF5a2xLczl1MzNNWWhWZWQ0M3BzaHEvUmRRT0puYVRDTXRMTldU?=
 =?utf-8?B?ZVArSmlFUmxib0RXcS9lOTNLYU14YTZEQUR2dHE2bWNwa2JxdVlJL3puUnVv?=
 =?utf-8?B?ZGQ5Q2xDcFA1TTI5T3pDWE5aaDRzQklEakFXNDVIeWRYMUdHZkN6MTNmRnU1?=
 =?utf-8?B?SGlXay9HZS9FclRZSDk1VWRaUVNwQXc0THg0NG0wc1BhUk1IN2t6cCtHZjlt?=
 =?utf-8?B?bk5EeU5ZblMrQTN4UGh5S2Q2RzFFM21Ic2lWL0ZrMWs1QmtaWTJWZVIydmhm?=
 =?utf-8?B?ZXlwcFFkczY1SSs1WGc2TVFNUlVUak02dDl5YTdDR0kydDFTM2pEekdWOG1y?=
 =?utf-8?B?YzFFbUZoaG5YWVp2L29vQWxhTkhDdVJmcitJWXJjQVFTUTliYlpHbDVySlRm?=
 =?utf-8?B?bGpFcWpuci9LSG5jSG9ML3B2K21nV0RLRWdvalVObXBGNkloVS9ySHFGVkFT?=
 =?utf-8?B?b0JWM2h6bkVIUVpxNkdSUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6325.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGY2K3EweVFqeTZvMGVRTFlWN3RGVkFQNUZKZU9WMXcrM3hmTkxqbTdONjN5?=
 =?utf-8?B?T1A1enIzVkJVTUNOTjl5Q2RaS1FzT1krSFhYUEJoRGZzVWRTcjRkOUpkZk56?=
 =?utf-8?B?bm9ORWtrRWxrTXlqMHJoOGxuRi8yeFIxM1ZseGlvcSs5R2U3YjhRa3k4WXo2?=
 =?utf-8?B?Nm5JUElsczlIaCtVUGlqWFFXVytqMTk5eWlhRERWRlU3UmE5dXJMZzRYSmY5?=
 =?utf-8?B?dXR6WjNuUW9OSEZYSERMYy9vRTcxVmtGdGRZUzJQYUJHYmZVQlRXVWlEa3RR?=
 =?utf-8?B?TlE2OVdkV1F2ZlFjYzZ1YTQrZ3BuSDlhUnViZHNSZ0ptNnNJbVN4eG5sVFRw?=
 =?utf-8?B?SG9YeUVoRHRmOUkrcGFEWTlQbGpsTVByR2FLNS9ieU0rRHJ0TWsvdFhkQzk0?=
 =?utf-8?B?TGd3YVZQMy9nTjZZYlZwdDRIYzdTRWRMUTFwOVNRNmdhV2ZwL284ODRBZisx?=
 =?utf-8?B?RnFJZzM2N1hQdzZaOVY3WUhHSWhhanFPcm12dzhKWHdsb2ZzUFVCcFVxMUd0?=
 =?utf-8?B?M2lZM0s2TFFIQVBzOHlsVjR1bHJ4Q0V1bzhzV2RFV05xN0FhNE5IeXM1WVFQ?=
 =?utf-8?B?NnNhdi9IcGxLcGJxVXgrVjl0SlVvMGxSeVpYUWdRWXYvZ0ovRWkyWDJsU2lV?=
 =?utf-8?B?YnlOWkNGUkw4YWRLTjg2ZXRIQTE3d3FqWUFOd0RtKzg0dExZOWJUWkRSVDBG?=
 =?utf-8?B?d25qNlFBVUFVOHU1YXpZSmJWcXN6WGZHbUVzMklNSFA2dVdScTJldkRsdE9U?=
 =?utf-8?B?ZFhxN1NuUm5lbTY5MXpMdVFFaVFxZVV4eFNyZlB0cno3YmFoM1RFTG5HTmln?=
 =?utf-8?B?RDQyc01vbVBvdENrc2ttb3B4cnRrK3lGS0V0R1U1ZlhJRHlsSytiaDA3NzdV?=
 =?utf-8?B?RVNIT2lvd1JSRjdDVEN5UlZoM1QzVVQyczNBTEdhcHdOaVpjNlBwYzEvS3Fu?=
 =?utf-8?B?UjRrYk5MczFwdmFFNnZuR3dneTdSRWxuUWwyVjB0eiswZWJpZmhjZ3dtR1hU?=
 =?utf-8?B?aEpDY0JnRS9RVUljNlhjUXh1TVJyTW52RFFsVTd2SC9EM09qYVNaNkgxY295?=
 =?utf-8?B?dlNKb1hQdUdZdG5mbjRPb3IxNkxNU2IxRFdzelhtbjBIUUM0Mjk1YktMLzk0?=
 =?utf-8?B?Uzc4QVZyNWZoeC96TzI3cVpNZEZlYWxrZnZNQUppK1gzaEtiblFPRTdaaFk2?=
 =?utf-8?B?MVNScXprMGs1UkMybEFpY2VKNlZ6ZmhML3VMMjlRN2FITHgwOURidkFmZkRV?=
 =?utf-8?B?ZG0ranRMRnU0UlZWZzM1RUJ0ZEYySm5OcDNXelc5TDU2Ny9Eb3Z3bWU3TFRx?=
 =?utf-8?B?bXQxWmV0cEgrTWd2d2NJay9HaVNlSCtXN0J6eUlpUWZpY1gwT3hnUU5zVytT?=
 =?utf-8?B?VUVDOHhaYWhLS2F3YyszU2pFbnhNQ2pqNHJud1g2Z1RSa2ZoN0l2WjdTNEZm?=
 =?utf-8?B?N2Y0RElEYnZRaGtUUUc1SUx5WTM4bzdVNTJNN3NrRXZqQ3laTlErSCt3elRB?=
 =?utf-8?B?VlJ5WHpJSGMwUEpGOERiRVpUUWxJUE1xL1RmQUhoTENaTkNZNDNZbUNHbFBC?=
 =?utf-8?B?Ukg2c3NHTTlVQUxibkdwQ0pWNXhrWU9vM1hLUnB0ZEFSb0xhcWhuNWxvWndl?=
 =?utf-8?B?MDVlbUFYdG5hUUJFSnV0ODRocjd3ZGd0MWM4czVVd2UxUnlGMGF0VVAyMWJs?=
 =?utf-8?B?MHA4YXZkLyt6NkNpbm1FWkdOZjlQZTBJTTNWK3VSZ21aMFRoVjhCQURqOFFL?=
 =?utf-8?B?azlFTXYzcytaOFRZN3EvZVpRSVdjdXlrZktEaE5jWXEyUGUwaGN2MmZQR2g1?=
 =?utf-8?B?ekUrWll3Wlhad1JEZVJTbkV3d01hUHQrbzNUVVEwUmJzRktIZENHV0Vta0xn?=
 =?utf-8?B?Yk96SklNa29VeEIzLzJiNEdrMGZzUXFCclkvcEk1dmhSa3VNRzRYSXRFSUVP?=
 =?utf-8?B?dnhuVHFZNTdERXhnV2N3a3I4akpuTUxBV0RBT1Fjb3dSQ21NZ0FCK2VYOTlI?=
 =?utf-8?B?SU5taFFSaDdxTk53R2J2MEo4MlQzaGZ5TzBYenYwWHNWWUNEeVJXTXl3N2FQ?=
 =?utf-8?B?QTF4YVBTdTZMdTl4aENQbDlwTFFzeUlGVkRIano2VW9zM2JTTGlnc0JGWHNP?=
 =?utf-8?B?eTJtbHNKYnlNNGQ5TUtwZEJGNWQ0WmJBYkRjVDdvMkh5aUhjdnVBZDMrbkhT?=
 =?utf-8?B?a1E9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 592a3b76-796b-4297-0dbe-08dd734e84b5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6325.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 07:58:43.0360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T7KpKYQ7+xKgcHD01h4hb3lXk4FCQdVe9m5HjFbr+g4djYBOJhdnkCYu1flRLX86dDbL3JCxZCCbcHZWo/FHPH+J6cRpYQ0xTM3s5f66z3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4659
X-Proofpoint-ORIG-GUID: V3k7OuVh9RM5yiTH1KnX_i19inwqcTf2
X-Authority-Analysis: v=2.4 cv=Aqnu3P9P c=1 sm=1 tr=0 ts=67ef9135 cx=c_pps a=SXeWyiAXBtEG6vW+ku2Kqw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=ZOmzTlq12acIsgeWG-oA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: V3k7OuVh9RM5yiTH1KnX_i19inwqcTf2
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_03,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 mlxlogscore=763 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504040053

Hi Greg

Thanks for your response.


On 4/3/2025 22:52, Greg KH wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Wed, Apr 02, 2025 at 04:26:50PM +0800, Kang Wenlin wrote:
>> From: Wenlin Kang <wenlin.kang@windriver.com>
>>
>> The selftest tpdir2 terminated with a 'Segmentation fault' during loading.
>>
>> root@localhost:~# cd linux-kenel/tools/testing/selftests/arm64/abi && make
>> root@localhost:~/linux-kernel/tools/testing/selftests/arm64/abi# ./tpidr2
>> Segmentation fault
>>
>> The cause of this is the __arch_clear_user() failure.
>>
>> load_elf_binary() [fs/binfmt_elf.c]
>>    -> if (likely(elf_bss != elf_brk) && unlikely(padzero(elf_bes)))
>>      -> padzero()
>>        -> clear_user() [arch/arm64/include/asm/uaccess.h]
>>          -> __arch_clear_user() [arch/arm64/lib/clear_user.S]
>>
>> For more details, please see:
>> https://lore.kernel.org/lkml/1d0342f3-0474-482b-b6db-81ca7820a462@t-8ch.de/T/
> This is just a userspace issue (i.e. don't do that, and if you do want
> to do that, use a new kernel!)
>
> Why do these changes need to be backported, do you have real users that
> are crashing in this way to require these changes?


This issue was identified during our internal testing, and I found
similar cases discussed in the link above. Upon reviewing the kernel
code, I noticed that a patch series already accepted into mainline
addresses this problem. Since these patches are already upstream
and effectively resolve the issue, I decided to backport them.
We believe this provides a more robust and maintainable solution
compared to relying on users to avoid the triggering behavior.


>
> thanks,
>
> greg k-h

-- 
--
Thanks
Wenlin Kang


