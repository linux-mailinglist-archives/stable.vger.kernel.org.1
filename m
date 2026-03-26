Return-Path: <stable+bounces-230458-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOMgEZYoxWkU7QQAu9opvQ
	(envelope-from <stable+bounces-230458-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 13:37:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2B43354E2
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 13:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 17220300B2A2
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 12:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1EB2D1303;
	Thu, 26 Mar 2026 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Tt9kYY5k"
X-Original-To: stable@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013057.outbound.protection.outlook.com [40.107.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0015B31714B
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 12:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528611; cv=fail; b=D8IFIOR9Kd15hoqCAggdpUs5eq/PJvKousFRw38i4SQUB+nLyOS17qkRxAJxngd8hG24TfaJmCFeQFfDy+i0jcYCNkbC7k55sukik1fYlNqKtouACxtjRg+vIzovc5cWMuAsX9TdA7W4KGrjjmMWS/7KKM1UKld3WyW+5GVWWlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528611; c=relaxed/simple;
	bh=hWdGgO9WpeXf853FV3eXrenkruZGDXjVWnge3NzlmJU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OGcyEL8rHz2KCiC2h3SVmqU5qqwtre7qSttfhYqIl/0DsPPv3Lab9FKNP/T/IR/aj/PeNXTjm3oBigNshquKbA4aJUTmE2Ai7tHOmK2DySvIrp81K2vM8s8rWD9V5TC1Xbb9EFw7kSjsjGPpq1ajhu+8n8wHB0BZ5rxeJ2u6TDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Tt9kYY5k; arc=fail smtp.client-ip=40.107.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QoH/HVudo38jwc1lJLkRuYbiscTgbllTOnSQ6qAKaDDt3lToSR5hdIbvmVWRr0sr7NkqGGb535aAaD+6GHt9yG8TmMsLCwBwPXI/fGYFW7JWjtWo4xSsx9xy9seOmAqpKu3+XKWM7olilr1jn8y1R8N27/HxHvIPv7KFJuttLKgZnVrqJXWBoQGQiMObAni0NTmgmA5MpgeMqBLpAAG8vj79JbjqVLmPABJrkcU70EPKqa9dOmYS6M70Oq/E9bVGkliWybagAr28n31gEzs3DcILlZOyDHX7meQkxclQeWPRis/E4/omUHZbacqFoYd4Pfce6H3ehremSGPr82Hzqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQQWuf0D5McuHh6t3mw3Vo7HxUgu/GndnDMZ/pYCfig=;
 b=NuGm1gvze6NMOz3PFYofgFrAzydTR0zhSeSw/FK4hF4WP1V4sKoqusuw1BBjREOoQPVv7ShnHcfsMa9SNxxl3Y9rS6nPqygT27Rcog+IqTQWk7YtbrggVuRW+17aOGIWG8gjky3Es4+yqaERTpKeD+bNLBnJClfqVdPye7J8MCtZ4wpNa446xhYGzw3BzSOUg/Qj7Kq0Vc989GvwEvY6Gr2Fwzq8lc79RleAiUxEJhNgAu5emAe4boQx+UViNkxtf1Pj/BZAq51o81X8h/rT4pZBVCNmJyxtrl7/y1WGAFCE9ibG5mXsvls7mFBfTdClxPa+/xsg4HxF66ZYn01UFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQQWuf0D5McuHh6t3mw3Vo7HxUgu/GndnDMZ/pYCfig=;
 b=Tt9kYY5kKJqeCHtYtB3/zCRMWeXjfIeNlBCPSyL/9XY49/ethciPF+aT3B3GJsc4sw71UchzNd5C49zoyVP74n1eo4ruYkqbaBNfkIlCisLRzwyx3LyW6U6ROBeDXbNxB6bdrxdH5zqttwMS7rPgyYrNgmOrib2nldEwmQascs4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6589.namprd12.prod.outlook.com (2603:10b6:8:b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 12:36:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.006; Thu, 26 Mar 2026
 12:36:44 +0000
Message-ID: <9c9c73e1-abe4-4307-9d44-37544fbd1596@amd.com>
Date: Thu, 26 Mar 2026 13:36:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] drm/amdgpu: Change AMDGPU_VA_RESERVED_TRAP_SIZE to
 64KB
To: Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, stable@vger.kernel.org
References: <cover.1774521183.git.donettom@linux.ibm.com>
 <2e3d4c1dafc6d2780ca502c9d78e8ac250122d96.1774521183.git.donettom@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <2e3d4c1dafc6d2780ca502c9d78e8ac250122d96.1774521183.git.donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0370.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::16) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6589:EE_
X-MS-Office365-Filtering-Correlation-Id: ddc6a6f2-eb5d-4453-51d7-08de8b3455dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4D1Udd0+F4JnPNDToYdG2S8cvDjBH1nKS/N69c55XTUyKBCydasv+PPSz55hlXza7i/+xtTq/vVx42ByeL+ZJv1ETs+8YkzgUKqqNKhf3s95ABY6uiv46u/XpXVF6P/789714xqhKmS7HHKGGAiauQ+KInL3veWeW6IuexXKYoLORTh2FOOSq34YXrHJCj4DwZiJY62aNqGamSuvDyPdxQRRKf9LM1G30tnr+9BPM8CT3CpHfLyy24WGZu+xkBQGg+8gOSZ/KEx47bp+g+3APAQl3RIOmLCQ9lYhWhu8yUXvGw6kIaKp5shcvHlqheB9zQVP5jYV/XIDzZ9zz1kNw+R5672gTqDO8BkAY8IxL2OJvuhxYuJML9OkFMylEkYmz+StdEGRc5O3DewdBtnjqyzmwWQ/QONzkR32PzWm9YUmL9KXMe5ET0Dq0cEDOMl02W4MR8UMVCKkAKx0U0bQoWQOtwOD+glGPYpss6J18O0Du1eZXd909tScau0bYSoQcpD5D72Fsrntqk802FyP2DfHntVrovfSvH+0M7BQa2ysgvqBxcnlqbXAf9Wod8S/JotDZVomz8Us/axWSixS+4lfJCYjQXyYlEC3ePM8QW7CgQOtG9VeWomXgVlMef+Apd7teTMQYzwHID73INc3BDgx7YmHL7ictomMtyMogTRVKBV198rY4rThOwat13I67boIyh8pbCnJe8zH/ymX6hnBfSpF/onXzxTC9KRQhUQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajJkODRFNnBwWUQwcmVjZ2hub2dMODdHT3EyZktCNWxrN0JNeDdTREpoQ0pT?=
 =?utf-8?B?WjMwSXU2OTBNUjZmTW1GZ0R2YWYvdVBYK0RnQ1VYRWxQdVM3OW1NRkFaaUhG?=
 =?utf-8?B?azR0a2luRWxoTkRIQkZtVzZ5a2VYcnRZbmZ0ekFmL0ZTYmdWc2hnR1cvd3B4?=
 =?utf-8?B?Z2tLMTMwbEpuVGQwTUxDdyswa0xTQkRVckt0V2VwU0V6ZEZ4YjdDMFlvSWNS?=
 =?utf-8?B?ZVRmNkF1RFhBbGp4ejQ1bmw1czhSajdTb1YzSUtyYkd5dnZTNEE1dUFlbkZN?=
 =?utf-8?B?dnpDMnJuK0Nla3F5aURzMmZGMjZCOVo2Y0ZpcEhCeDAyQlNrSHpxZlVGYzBh?=
 =?utf-8?B?ZkdOT3RtNDdHbTJJS3lFbGU1QTAwV3VVUnk4UCtMOVNlMkpLbmtIRjVCMFB5?=
 =?utf-8?B?OENldWFmRnlBSkFMWnZ0UXN6cUhTQWtaSjAraHlFSk0rNmNITUMzaktOU2FQ?=
 =?utf-8?B?MlllRngzMUpZY3dmWnM5STViMUNqVFNnNis5ZGI1cW5lSmRGK3I4U1NqOG80?=
 =?utf-8?B?dTdRZEFzdWhWeHQvQ2dmY1dsWWZhMmNOVm1vblRpTDl0Z2RNdXA4bnpXTjVM?=
 =?utf-8?B?emN1VFBYeDczOU16VFB3VXJBZy96SlAxRStWS3JSeFUxWnJZSEZoZ25icy8r?=
 =?utf-8?B?Wm9oYTU2elJCMnBlM1lQZDN3aVhKN3BIamtVOGZhUDM1TzM0SDBUaDdGMUw4?=
 =?utf-8?B?S1RjcHBLcklDSHBaODBuTUFndEdZUHNqUzdzRkJ3ckhzK1BKckVxcm11WUhr?=
 =?utf-8?B?N0k2S2FreFZNQTZsWlZUeDJraWhNYXJUeGhjbW9ac2NVd3FOTEU5OXlGZ3hz?=
 =?utf-8?B?bGhGWDhBcmVFd3M1ZVRPNzdwVmtLVVJkb01IbGUxK25KSEJZem1IZk04bG0v?=
 =?utf-8?B?Q0hjbjRxdGVSOVl2Tys1elRZcTBSQnFBbk5pOU1tKzBXTGMrWUlqZmNIYVpD?=
 =?utf-8?B?TnkxVWhGcTkyaEdFNmdYcHRXRnplNUhROTYrYWVXZG1CZ2ZEcy9jNWdSc0tU?=
 =?utf-8?B?RUZWUm1iam1vZ3l5NEh3eG5UNk1KM0dlOFQ3MUY5NzlSSTJwMHM0aGo3NWF1?=
 =?utf-8?B?OUxHVzRZT1k4Y01qcHk4UDcveVVwbWlyU0tPN3BteDMvRWxac3V5NzU1WWRy?=
 =?utf-8?B?MmZXb2M0a1JRaHNENEdFRm52Vkd1NmdYK0kzVzVocSs4NFZPTDl1Nm9Xc01K?=
 =?utf-8?B?bzl3cDljcnQyR1JtdDVNMHZCaG9KYUxuV0dhRDdiOVFiNGFvL1BPcVdLSEQ4?=
 =?utf-8?B?MVNGeDlsbS81L3ZMYktPaFUwSldGVm1ZeUFINW1RZkRHK0E2NW1hSVp6RHgr?=
 =?utf-8?B?emozcDRaYm9IbmNCTW9kUnNqNUc5Q3MrM3VQM1lIcGk0bFVQTXp6ZWZzV3dX?=
 =?utf-8?B?ZXZLT3hFbDQ5UFVYZ1JRaUtLQ3Z1Z2hiaHpqTk40bUN0V3gvMmllYnFLdDVy?=
 =?utf-8?B?dTlYb2lUNEdoNTZ5TXNVRVFteGNHd0FtcVdkTUxQY0NRL05raGNDMncwUkp0?=
 =?utf-8?B?SStmZnUxY2FnaXF3dGJHbFZZcXFQWWdja0I5UFROa2tzS2hMZHlRcDlTQS9V?=
 =?utf-8?B?cVRidHJyMmZPUUp3QytpNk9PRVNJN0h5a04rV1pGa2QwYUZteW9YUlQ1dnR6?=
 =?utf-8?B?WHl2Q0VZaW93U0paWXlTRUo2UmdZUWYyd0Z6ZWVKV2VlNVI0WXpWM045WGtG?=
 =?utf-8?B?dDdEdE5YVys2MCtLcUF2eG9BbXoyQ3p3Mm9LaEJTZWNRaEVBeTRnM3lVSjA1?=
 =?utf-8?B?K2hkS1R2VFlIR1U2dmEvMnZjNytUNTZZK25KLzRqUUJiRk14UlF5Tll1Zm14?=
 =?utf-8?B?bGk3VkNTV3N5V3oyVjBaUWQ0WjZlajhlNkVaUDV5N2RPbWNnYnM2ZjBuYTRk?=
 =?utf-8?B?ZHd4dmdTdnZMeE9QN2F5dG5WaHNYT2NHTXZKdzE0Rm5VWjNIdlZwcVpIWm54?=
 =?utf-8?B?RHQ5OEZkUE1kU0NvSVVYajUwQURnNnhPWG1vVWVtOEFKSW9GREIxVzBxZGgv?=
 =?utf-8?B?UXlldWxBeVhWNXhxdUF2amZXVGRWM0lXWS9xV1c1RWJCVFZ6TlVwbk4yS0t4?=
 =?utf-8?B?RWNicXUvVjlGZThlRDBxV0VUM0U4YnpKZnFBR2UreWcrSkZJalRVWHpTclpR?=
 =?utf-8?B?cEQrVnZTaithOUI1YVdhY09FbHE5QW1SbkpCSks1YStJM3RZSFlIZDBqUS9T?=
 =?utf-8?B?a1ZOOEJmT0hKZU9tQ2RLZjNmNEdnYkh4MTI0aXMyOXF5MkR4bno0OTNISHMy?=
 =?utf-8?B?andUTS8xQWhKMDlEWk10NXdqZVJ1dzZOSkV1Z001NEpEZE1Zb1ZVMmtnTG1W?=
 =?utf-8?Q?Ds+EE+ei1PyEDCN7Sz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc6a6f2-eb5d-4453-51d7-08de8b3455dd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 12:36:43.4400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PuErnvOHfgxSo7RE8qYRWJKcPJ+F9zxpZAofn27z1ZsWi9r9qJfkyPpsi4pVSHrQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6589
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux.ibm.com,lists.freedesktop.org,amd.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-230458-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,linux.ibm.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B2B43354E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/26/26 13:21, Donet Tom wrote:
> Currently, AMDGPU_VA_RESERVED_TRAP_SIZE is hardcoded to 8KB, while
> KFD_CWSR_TBA_TMA_SIZE is defined as 2 * PAGE_SIZE. On systems with
> 4K pages, both values match (8KB), so allocation and reserved space
> are consistent.
> 
> However, on 64K page-size systems, KFD_CWSR_TBA_TMA_SIZE becomes 128KB,
> while the reserved trap area remains 8KB. This mismatch causes the
> kernel to crash when running rocminfo or rccl unit tests.
> 
> Kernel attempted to read user page (2) - exploit attempt? (uid: 1001)
> BUG: Kernel NULL pointer dereference on read at 0x00000002
> Faulting instruction address: 0xc0000000002c8a64
> Oops: Kernel access of bad area, sig: 11 [#1]
> LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
> CPU: 34 UID: 1001 PID: 9379 Comm: rocminfo Tainted: G E
> 6.19.0-rc4-amdgpu-00320-gf23176405700 #56 VOLUNTARY
> Tainted: [E]=UNSIGNED_MODULE
> Hardware name: IBM,9105-42A POWER10 (architected) 0x800200 0xf000006
> of:IBM,FW1060.30 (ML1060_896) hv:phyp pSeries
> NIP:  c0000000002c8a64 LR: c00000000125dbc8 CTR: c00000000125e730
> REGS: c0000001e0957580 TRAP: 0300 Tainted: G E
> MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE> CR: 24008268
> XER: 00000036
> CFAR: c00000000125dbc4 DAR: 0000000000000002 DSISR: 40000000
> IRQMASK: 1
> GPR00: c00000000125d908 c0000001e0957820 c0000000016e8100
> c00000013d814540
> GPR04: 0000000000000002 c00000013d814550 0000000000000045
> 0000000000000000
> GPR08: c00000013444d000 c00000013d814538 c00000013d814538
> 0000000084002268
> GPR12: c00000000125e730 c000007e2ffd5f00 ffffffffffffffff
> 0000000000020000
> GPR16: 0000000000000000 0000000000000002 c00000015f653000
> 0000000000000000
> GPR20: c000000138662400 c00000013d814540 0000000000000000
> c00000013d814500
> GPR24: 0000000000000000 0000000000000002 c0000001e0957888
> c0000001e0957878
> GPR28: c00000013d814548 0000000000000000 c00000013d814540
> c0000001e0957888
> NIP [c0000000002c8a64] __mutex_add_waiter+0x24/0xc0
> LR [c00000000125dbc8] __mutex_lock.constprop.0+0x318/0xd00
> Call Trace:
> 0xc0000001e0957890 (unreliable)
> __mutex_lock.constprop.0+0x58/0xd00
> amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x6fc/0xb60 [amdgpu]
> kfd_process_alloc_gpuvm+0x54/0x1f0 [amdgpu]
> kfd_process_device_init_cwsr_dgpu+0xa4/0x1a0 [amdgpu]
> kfd_process_device_init_vm+0xd8/0x2e0 [amdgpu]
> kfd_ioctl_acquire_vm+0xd0/0x130 [amdgpu]
> kfd_ioctl+0x514/0x670 [amdgpu]
> sys_ioctl+0x134/0x180
> system_call_exception+0x114/0x300
> system_call_vectored_common+0x15c/0x2ec
> 
> This patch changes AMDGPU_VA_RESERVED_TRAP_SIZE to 64 KB and
> KFD_CWSR_TBA_TMA_SIZE to the AMD GPU page size. This means we reserve
> 64 KB for the trap in the address space, but only allocate 8 KB within
> it. With this approach, the allocation size never exceeds the reserved
> area.
> 
> cc: stable@vger.kernel.org
> Fixes: 34a1de0f7935 ("drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole")
> Suggested-by: Felix Kuehling <felix.kuehling@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h  | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index bb276c0ad06d..d5b7061556ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -173,7 +173,7 @@ struct amdgpu_bo_vm;
>  #define AMDGPU_VA_RESERVED_SEQ64_SIZE		(2ULL << 20)
>  #define AMDGPU_VA_RESERVED_SEQ64_START(adev)	(AMDGPU_VA_RESERVED_CSA_START(adev) \
>  						 - AMDGPU_VA_RESERVED_SEQ64_SIZE)
> -#define AMDGPU_VA_RESERVED_TRAP_SIZE		(2ULL << 12)
> +#define AMDGPU_VA_RESERVED_TRAP_SIZE		(1ULL << 16)
>  #define AMDGPU_VA_RESERVED_TRAP_START(adev)	(AMDGPU_VA_RESERVED_SEQ64_START(adev) \
>  						 - AMDGPU_VA_RESERVED_TRAP_SIZE)
>  #define AMDGPU_VA_RESERVED_BOTTOM		(1ULL << 16)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index e5b56412931b..035687a17d89 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -102,8 +102,8 @@
>   * The first chunk is the TBA used for the CWSR ISA code. The second
>   * chunk is used as TMA for user-mode trap handler setup in daisy-chain mode.
>   */
> -#define KFD_CWSR_TBA_TMA_SIZE (PAGE_SIZE * 2)
> -#define KFD_CWSR_TMA_OFFSET (PAGE_SIZE + 2048)
> +#define KFD_CWSR_TBA_TMA_SIZE (AMDGPU_GPU_PAGE_SIZE * 2)
> +#define KFD_CWSR_TMA_OFFSET (AMDGPU_GPU_PAGE_SIZE + 2048)
>  
>  #define KFD_MAX_NUM_OF_QUEUES_PER_DEVICE		\
>  	(KFD_MAX_NUM_OF_PROCESSES *			\


