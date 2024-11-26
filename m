Return-Path: <stable+bounces-95473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D670E9D906E
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 03:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960C328B53A
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 02:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E09917543;
	Tue, 26 Nov 2024 02:39:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3682ACA64
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 02:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732588742; cv=fail; b=eS84dm99k/F6+Y/WkzJ17jfO+pM471cVZ+xq9pvE6xeNs1HZ6PbTTHbtZ3uOhMluBxz5FzuyebT9FmyMv+C4IbnA4Gi/h7gNfYKQ38sXkmDvb11xGJZWVZAABHSBtrColserzC2c9j3t0mFTkEsihHkOdkU5hOsJcYf6Y/zWDi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732588742; c=relaxed/simple;
	bh=jS/CJ6Zm47mEAQdR95T2whRSK6OQQeztmtFKWbS4DBU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TNUooZ6hUTftvVB54D8VLtBRIeBt9nh8qvwYcn/L18YP9I86YYKfNA34/+yN8CV9MuDBqewUH5/k3VlLg/kp9TOX3oN2SZRr/dHm4vsoIHn4kJ+e5zivcEsqXcl/bqk2DXL0WnIb2Uich1VaXXobgy+J/WcM744DjcpuKZOvisM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ1Hm1Q003347;
	Tue, 26 Nov 2024 02:38:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 433618aqkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 02:38:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xIWQm4v136UYxtTZDOWV6XQWrbPyX4MKgEFF/nLalmK6eu/nPBIvCzhye5FkM4eDdAFn/Trn5FmXPYmKhQEqmKkYEShUkm64usVaNIg3F/m0Z9/K/AL7NQkjVsiwdEuM5EpCRcrlDTFQLjkBL/PWRSJYpN7zQg1o6Sww5APwwK9Whuq+ElIy9wK3NdNoQ2SKxuEwT+h7XAIXXo7XeIbnUDSxGoPhaN7L8M1aW7uqgTNlzdpO3SAgtfq/da+a2TQf8DHYoobsZBxVR9rtVN3q8axfwYpvCETEQ8xlohTjb/PJ4PMOmudFWUjNH+iMCFkpnErS94IYhee1aMw9Kz3FCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YxSeVncEpL/WcMXAgQbaJKxA7tot3E6FgQDNYdkZCs=;
 b=DbIEin9h3/qSWgaezi5wGQxzypZfkJKdpAAEC5SMim46ngtpZw9QpBTbbu3ixQpwrS9PUORIQTvS5qkrRlcW19um2l4IPU18mV1fcESEUMQcb/PBr9xYT97VK7lzPzMEroj1AmEeEuMlgFnYu6Np0NTLno5pT1QPKv8vzkKNrtf1ynYAZoL4V4eaQBP+M5+/rZQYSCPY6beRaBXCM+/I9sGO9Lp2rzLMjH9V977pXPwOUOsropFgKwHqj2K+7Q96AU/Pu1Xb6ooJgO1ja8i7GKsJNY48ciHZ9Gr/pvCqf3M+B9vmHgElnXEHrwsQu4KJau81OixjkMHWKAFGVZeE+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from PH7PR11MB5820.namprd11.prod.outlook.com (2603:10b6:510:133::17)
 by SJ2PR11MB8566.namprd11.prod.outlook.com (2603:10b6:a03:56e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 02:38:53 +0000
Received: from PH7PR11MB5820.namprd11.prod.outlook.com
 ([fe80::582f:ef5b:81c2:236e]) by PH7PR11MB5820.namprd11.prod.outlook.com
 ([fe80::582f:ef5b:81c2:236e%4]) with mapi id 15.20.8182.018; Tue, 26 Nov 2024
 02:38:52 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: linux@weissschuh.net, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, xiangyu.chen@aol.com
Subject: [PATCH 6.1.y] fbdev: efifb: Register sysfs groups through driver core
Date: Tue, 26 Nov 2024 10:39:00 +0800
Message-ID: <20241126023900.357636-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0237.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::15) To PH7PR11MB5820.namprd11.prod.outlook.com
 (2603:10b6:510:133::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5820:EE_|SJ2PR11MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: 94a8cbf2-9218-4aee-ab48-08dd0dc37729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkVLNDZKeUE0OVNqb3FFMDBlWStFYktMZXNPQnFTbVBJTFdpcnM1QjVBaTJa?=
 =?utf-8?B?UFhWb2NxOGt0RmdlMEJPK3QvZW0rYytHQ2VRbUlxRmh5bWR3eEdvTEU3c0Q0?=
 =?utf-8?B?UFRyTWxST1NvZDJrWFF5bkVsZTBYc1VFMlZDeWMzNVdVTHVkc2IzamR2QXFH?=
 =?utf-8?B?U3dlWHIrQTdTM1lPSXB1WEhuVmVkdGtTL3dEWEZsMVk2N29aT0s0WWM3Tk01?=
 =?utf-8?B?cEp2RWFVL2NTYURrNElETkdpbHg3TTFrUWdDSFVvYTVRbXd6VFVVbkl5RXFs?=
 =?utf-8?B?c3d3SmdPVnJrRUlqcjErczJYS1FhRTI0aUlnT0ZtM0FiOXEvYVlXUTJqMkdr?=
 =?utf-8?B?NWJ2QUlBL1F6UmpJVEg5aCtPbGx6d080eVNXNW90aHJpQUloV3N4aWl5ZWFS?=
 =?utf-8?B?MEtQbEMrRU1aWXpaMDYvSzhHR21VUDhhWHoxRFlZWW5KVHordEI5bmwraldp?=
 =?utf-8?B?d0pJYzd0anN6UUQ2VXNPSXFzaXNXVkhBUW1nWCtEVTFaL21XM3NBNys5b2dD?=
 =?utf-8?B?SFdCcmpWVXJpTUxxd056V0ZsNnlSSWRtMGhWZHQ5TFJ4K0JFWjlYUFhnK1R5?=
 =?utf-8?B?UmdhU28vaDhHaXhlZWZRQTNWM3E4SE90M1hhYkN6VmhVS2d5RFFwYVhqRmF0?=
 =?utf-8?B?SG9lTjVRL3NncTZhVmRYNmRKelgwYnMrQXp2WW1nSU5CNG1KSTdrUzV4NmhD?=
 =?utf-8?B?czBNRlRud09LRkNhbGpyc2Y2czlRelNSM2V3OUVGUUhvOTF6RkJUTHNqRmsy?=
 =?utf-8?B?cDlESUhYdzh1WG1hVXB3L2hIYmlMRm01ek5kTmZjTUx0eUhIcWhaTGxua0ZS?=
 =?utf-8?B?RDY1ZnhLZktrSmU3aURVM0t3ZllYWmJYdmNYdVpTeWZMYU5EcmhiR1NlZjQv?=
 =?utf-8?B?djZCZ1ljak42R1FIQmNJNUp1dUQ0ekVRb0pzeG4wWXR3ejVSUHdZbGxnUUZY?=
 =?utf-8?B?MTFYZUc3YWgySjgzOWR2NE9rU3Vsb21uS3ZDUFFUMmM3MzVCVlo3SDJMVlRM?=
 =?utf-8?B?SDN4b3gwVGRhTHI2RzFnTGs3ZFliSVduemEvejVFZHlpdmZIRC9PNjIzS0w0?=
 =?utf-8?B?cW43Z0VOYUhWeTNxckFtS3pkamxsNndKdnN1aEZBdCt4Vi93aWVhVUxoOVFV?=
 =?utf-8?B?cGNaLy9XTzg1QXNKVkdZV2p1cFp4L2xQTjR6aTRwcnBrV1dJcnBzNHhxR0lD?=
 =?utf-8?B?OVVwOVNCMXM2M2RRR3VZYWhaa0FSWUpETDhxN003ejdBQTF1TWxsWWZQbWtR?=
 =?utf-8?B?SU5hNHFYcEMxb08vSWE2aTBHVGJhd0laWFpUWWtKOVFlcjR5b1YxYlk2YkhF?=
 =?utf-8?B?RllIWmE1SzZFd2ZSMXVUeFFIbkFTN0o5MW9USkpDSmdEQzZYOWhTLzVJVUpn?=
 =?utf-8?B?d1Ezb1FkMGY5S1ZEcXhheFFzcjFsRUZGWEJsUDFPTEtYOUhhK1VkM2w3clRR?=
 =?utf-8?B?THpOWDIxY0Q0TTdxVTFHTjN6NHUrdkhSVmJvNXJGOUpSU1B3U0Q3eXpzSVNC?=
 =?utf-8?B?NndsSDdFTTQvN2RPUjZlcDJFSUJkc3BOYkQ2VjlFRmRYaWNDZElzbjVDaTVs?=
 =?utf-8?B?QzBTU0V3QU54T0RmYURWamNLaVFoK0w3TTJybmRtYmxobWVqQzRtdCsyUk1F?=
 =?utf-8?B?ZzdLNjdpWm52eW1iVlk2aVdHckVUd012ODEvWnh4cUMyL2dZSnJRM3pqRUc1?=
 =?utf-8?B?U0h0KzV1N09SLzZGKzkyZ3hzQjFMTVRRMUJ0ejA0cDRvdVRmZTRPUkFTOHR1?=
 =?utf-8?B?RWdLZkpzR0IxYTloaXE1VmJNNElIRTl3dDhRSFE1cWNVWURYVSt5bmNXU3I1?=
 =?utf-8?B?Um5qQm9pMDF5ZnAyYkxOU2xCaUliK2pmbzNTak9lK0RoOTlYVGcwWmRqcHJZ?=
 =?utf-8?B?RHNKNXJVbHkvWGRSd21CeVI1M01GUEttanNKcWRmVEVsMnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0tKbUo0b096VDJzOVIzMXZJWnB0eDh6ZmVYRVloeDdJdmdxR2dGdWY0NTBK?=
 =?utf-8?B?UERmOEtseG8vTXBnMUoranJIWllwdWY0bGk4czF6MTg5cGhHWGNSYlRPZCtw?=
 =?utf-8?B?L3UvQzRVVzNzSFdhV0RveUUrQUtHanJLRXVwOUJydi9JelZXSFJiYThPSmg2?=
 =?utf-8?B?eFUyS2xNSFU5YktNWnJBTGxPVnQ0cHNuVTluSUtHTFhHVjY2dzdGZ1dIenhv?=
 =?utf-8?B?bXk5citxMDZGeXpoQjZ5VWE2ZHpmSnY0MjZvZGpmSHFUYTFvWkdmbWh6VzVq?=
 =?utf-8?B?eFFDQU1LSWpXUVlmUXVuU3d4RElVZ2F6UTFqWE14QjJIWTZ2WFpMekJmbTVW?=
 =?utf-8?B?VUxjdzBTVklPVlN2aEhHcjNyOW5jZTVPWnF5TUJQUytFbi82WVRVTFJySWdR?=
 =?utf-8?B?QmNMSktCTml4dW9oV1hwMUxrc2prcmI1RVhidTVjV2lvNVdPN1FuczBmcXVp?=
 =?utf-8?B?Q3VWYXdra20yY1FUSzEyd3ljVUF6V1llNWczQ0hCU3oranZGTlRBNUVBTUdv?=
 =?utf-8?B?WU11cEJVcDUwM2ozc0hvTElIUUR3QURPek4yMVNTb0dUOHBqV1BJR0ZsZWhR?=
 =?utf-8?B?ZGxKT0o3NFNidFRtcDVkNHZrRGlJSGN6N0dTdlBSTG53ZjhyclB2VGlTZ3V0?=
 =?utf-8?B?bUtWOXMzSzdjajRSVEg2bC9pVC9OdnN0NE1Qc3JOYTBYQk82ZjJTWmltOHI0?=
 =?utf-8?B?MnVjTkk3N1lEekNMSWZJV0xzcUxqOE9mVklKT0xvM29aNmJac0taSUFoYmx5?=
 =?utf-8?B?RUg2WjNUYUF4TXdkRDZyVm50VllqeEszSTVYN0VxY2k0QWxkUDVOanhIUXA2?=
 =?utf-8?B?Z0xZK0dpczBja0UvODVBb0gxLzFmSTc1TUdpcTcyQWlhZkRuSWtQZkRpOW5L?=
 =?utf-8?B?eCtSeEFXbGJaSmQ0YTlXTWhxZ3N5NEZYbGhhczMybVFndm5nZ3ZxRUMyR2pw?=
 =?utf-8?B?VnZtZWs2SGxZR1ZxRUN1WlJEcUo4YW1YcWNXWlhIT2ZVRmFXNGptYkQyYmk3?=
 =?utf-8?B?LzEwZEcxakJEcnpuVFFNSzJYUmdESi9tSXkxbFBEYUZ4aXBnRzkzeWFpVE5v?=
 =?utf-8?B?UGh0dXNsNzY2aVVSRWtWSmhRMWZJQldxZUw2MVNSeis5OFlzU2kvdTRkLzRJ?=
 =?utf-8?B?T29zRzVXVUdTcHNDcGc5Yko0VzRaVWlFWTJCZ1cxU2pScVB1aHlKL0RXdk5J?=
 =?utf-8?B?dE5NMnptMW1iY0M4djdpbjFyRWUwQVVZdGNseGNwcHlMTlFoQi9Fc2tNM3ln?=
 =?utf-8?B?NUVYK0FUb1F6MFNqenlxbUdnRFdsbm9hQVJMbmVkZmFQSlJqYkYwMXJUM2xO?=
 =?utf-8?B?OUt1eWkya3N6SnJUbDNFYVlxL1VvbGR2VlM5MVB1OVByK1FXWXdhZHYveGZo?=
 =?utf-8?B?WlhqWDVMdHZiY0ZaUU5XeXdXaVl2K2tnL2Y1MHZWSzMzKzM5UzlyM0MwcDVK?=
 =?utf-8?B?WldMWnRrQjNoTmcvL3l0QytLS2FrNGF4QTdoZFI3LzMzVGVwSG40OVBXZmEy?=
 =?utf-8?B?TVBRM25CeXlkeFMzNVdWaWRidWFTcHBoNG40L05aZEN0Zms4S1dJZVNyN3lI?=
 =?utf-8?B?WW5UajVJY1NPWXQ4cWYya3dlL2VsU2VPd2M2NXA2cVVBR2J1QkZDV1VjSmpu?=
 =?utf-8?B?c0pURm9PY3NkVVVBYkNVV1lqUEI4c0FTRXozb3RJcGtMaktjQ1oycmNCSHQ5?=
 =?utf-8?B?aHBkNUZRNFZnS1JGVXd3ZlhpNHc3ZjFzVWlFZERqcWlZVVhPU0tFTzNpWmZ4?=
 =?utf-8?B?VTFURndRZm81OUNaUWs4ZnpkT1hoZXJQekhpcjJ0ZzRtTEFZLzdmdUxNNlhv?=
 =?utf-8?B?RGd1TVF6QTRXS0FkVXhXNXlMUDN0Z1VPSDlDWUM0RFY0czcwNUYyd0drN09Y?=
 =?utf-8?B?dW13TER2M2l3YUJjQnBIanJyMHR4WXltWSt0bHA5N3pLd1BqT1dTVU5VaU91?=
 =?utf-8?B?MFJFay9PeSttWmpXZ3JxY3VxNDlOL040V2hNRko1MjlHMWh1SU0xR3haZWNP?=
 =?utf-8?B?a0tPdWdDbFdOakVJaVo4QkcweklqUDFvR044czlaSDJpRUFKSVdpMnZocnJj?=
 =?utf-8?B?OTRhOWI0OFJ5eVJ5cVlCR1JkRGlmQU9EcndXWTlwVlQzTzNUdkkySmF2Si9J?=
 =?utf-8?B?NmVyYnFRbEFvclJwRHExeUMvZlYrN3pTQXY1ZzZkYWlLclh5cXlRN1pFQVE4?=
 =?utf-8?B?dWc9PQ==?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a8cbf2-9218-4aee-ab48-08dd0dc37729
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 02:38:52.7592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r7t9FVgJdB53kKS3EcrVUjGIdLG1I6FcmulD5fZx2r2CorjFktBb9gJJmPSeEWda2ACEindajM8Zv3IYMdCAbpiHLkKwn1b4aFJzjtZflAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8566
X-Proofpoint-ORIG-GUID: ZTcDlkDLDIQLq5DCgvEXTFOX3cpzOE0G
X-Proofpoint-GUID: ZTcDlkDLDIQLq5DCgvEXTFOX3cpzOE0G
X-Authority-Analysis: v=2.4 cv=O65rvw9W c=1 sm=1 tr=0 ts=674534bf cx=c_pps a=G+3U1htxrnhIFlrbIuZW0A==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10
 a=VTue-mJiAAAA:8 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=g8YIBBLVxUOictkmChsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=S9YjYK_EKPFYWS37g-LV:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-26_01,2024-11-25_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1011 mlxscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411260021

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit 95cdd538e0e5677efbdf8aade04ec098ab98f457 ]

The driver core can register and cleanup sysfs groups already.
Make use of that functionality to simplify the error handling and
cleanup.

Also avoid a UAF race during unregistering where the sysctl attributes
were usable after the info struct was freed.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 drivers/video/fbdev/efifb.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 16c1aaae9afa..53944bcc990c 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -570,15 +570,10 @@ static int efifb_probe(struct platform_device *dev)
 		break;
 	}
 
-	err = sysfs_create_groups(&dev->dev.kobj, efifb_groups);
-	if (err) {
-		pr_err("efifb: cannot add sysfs attrs\n");
-		goto err_unmap;
-	}
 	err = fb_alloc_cmap(&info->cmap, 256, 0);
 	if (err < 0) {
 		pr_err("efifb: cannot allocate colormap\n");
-		goto err_groups;
+		goto err_unmap;
 	}
 
 	if (efifb_pci_dev)
@@ -597,8 +592,6 @@ static int efifb_probe(struct platform_device *dev)
 		pm_runtime_put(&efifb_pci_dev->dev);
 
 	fb_dealloc_cmap(&info->cmap);
-err_groups:
-	sysfs_remove_groups(&dev->dev.kobj, efifb_groups);
 err_unmap:
 	if (mem_flags & (EFI_MEMORY_UC | EFI_MEMORY_WC))
 		iounmap(info->screen_base);
@@ -618,7 +611,6 @@ static int efifb_remove(struct platform_device *pdev)
 
 	/* efifb_destroy takes care of info cleanup */
 	unregister_framebuffer(info);
-	sysfs_remove_groups(&pdev->dev.kobj, efifb_groups);
 
 	return 0;
 }
@@ -626,6 +618,7 @@ static int efifb_remove(struct platform_device *pdev)
 static struct platform_driver efifb_driver = {
 	.driver = {
 		.name = "efi-framebuffer",
+		.dev_groups = efifb_groups,
 	},
 	.probe = efifb_probe,
 	.remove = efifb_remove,
-- 
2.43.0


