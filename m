Return-Path: <stable+bounces-235879-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEE+BVxc3GmWPwkAu9opvQ
	(envelope-from <stable+bounces-235879-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 05:00:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B06D13E6DD3
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 05:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D2C753003D3B
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 03:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416381E834B;
	Mon, 13 Apr 2026 03:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TXolUCFD"
X-Original-To: stable@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012044.outbound.protection.outlook.com [40.107.209.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A5D19F121;
	Mon, 13 Apr 2026 03:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776049239; cv=fail; b=VZTjXRHUSrcLkfDf5vAuhp97j/BIqS6azH7ApWc/b6yVA0+IBv1R6oNgdEpp98hG910PXTKezhPURIv6sBkp0O9iPpQicN32esX99cAHjzxnrwQtGRtW16mPnBbFbNS2oSGCkZzl7OY5zOhAp0+bRpm7aDZIIPZVrglhVlKzNyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776049239; c=relaxed/simple;
	bh=VD4eMLJytHEcA+ffRq13wSUQmEvp1auTrhjFuJgxj90=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oP5K+HplSa6AUl8XLmeupbDLAB4nyul4kOIHEASDBwIiqjZDatVHl+p6pNGGUUJ/gxA/F677NroS2GvBeEqk/Fp6eskZ5F3tI8lvnaEANQDnqBvLrYeV8LaFrSt/TDFiv7pvIEm+jBzhpN1H1SWunTxnBn1e6OZWo3q9Cjz7ukc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TXolUCFD; arc=fail smtp.client-ip=40.107.209.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgW9xlCPb9bm5ybwmw6ws57phWs6tcLdyWJh0LncUdtsKDFt9eajOtadObUXsxPCEJdgRkNv6XEj8YSDCx4GzuktVrAnV9vRekYSBPFHUBlP8aIThgLEuijJqibaBijyzTIDvbZ+/qAsToMTFTWXO1DjK7zIq2Lfd2t5BCdUZJowbc0bX6WtZ7/fgCzlQzZVteBiNAHG+ZhnIhZG1TITZzRSP6NklxHrXLawOrq9nBO4vlhY0PZx5Li/QTg75k4kHaQ7RdfVvjXUe+hRnZ28g807dz2Mr9cvsmZZSbjMiiWEam7NRt/Upz6MHQqaUU1A6F6QHcEz+E5+l09y+Lp2oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ac+R7GboflbVb2aCvX4oq+1d6Z+bcsu3gXRaKv9gOt8=;
 b=f9wLKI9deIjGtalqUl1KMjVQGYs0IUum1GxslBxraq3s9QlE0EOiXfQsT1XU4fC121ZV1Yf9xCPI7mQ9rbQZt8VBbjuHHU2CGdSZzoNbqem76VLnWQzGR4NsKG9I+je7jRCa9kL+/T8YWdCdqC7QXpYTSurx+QJF7tzzZ7QDcVEU8jVWVHRZy3NaEUPAXpB0Ehxsp30jscAqFpZXvMT+YsDNI3LhWW6Xx5NvImRpaNQ5cz4bsZmN2hWfPUja26VWhQ7WXONozGzFEwtqdBAdHvuqyfUEgrmSGaby69okqG9NPJnUTUUSQftYalE0emQXMPDJkKWppr32vUt4A8mJMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ac+R7GboflbVb2aCvX4oq+1d6Z+bcsu3gXRaKv9gOt8=;
 b=TXolUCFDZgOmbCcpFma6hVU+YhgUKxvK8lbgSfl+Nk3ThrerWvuIcbHHA8yIpD9Ftl2vH1INqNW/Cf/4ZKSv9X8Jq9uib96QWcLFYxnYeq/o59kUVAofDFuY3O7xaFswtys4zmKthYU1fCTmcemVr0BnrGDqMOpLT39/Ub+VbYK4jh56wjsRBKNC5L62+nyCDhpKho50WQ4P5we7TTDNh7YqS+iX+LYkOUp8sL+MWFcHeljPIoaigqKOOEUDdODAkAmIRfyZCDEmTYw7KBl6lqHpAsJvW8fu5SI5jeFehYg7wRspmJtJaf0XFdVYU6+zcnmc+rVDmjonGmB2NmjYvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by CY8PR12MB7540.namprd12.prod.outlook.com (2603:10b6:930:97::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 03:00:33 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::2920:e6d9:4461:e2b4]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::2920:e6d9:4461:e2b4%5]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 03:00:33 +0000
Message-ID: <d530ffd7-ebfa-46e1-afd3-2599a3ffaa55@nvidia.com>
Date: Mon, 13 Apr 2026 13:00:28 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] taskstats: retain dead thread stats in TGID
 queries
To: Yiyang Chen <cyyzero16@gmail.com>, Yang Yang <yang.yang29@zte.com.cn>,
 Wang Yaxin <wang.yaxin@zte.com.cn>
Cc: linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
 "Dr . Thomas Orgis" <thomas.orgis@uni-hamburg.de>,
 Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org
References: <cover.1776020234.git.cyyzero16@gmail.com>
 <99c79e8529eb2c125ffd1eaa9f5d6b479fec227c.1776020234.git.cyyzero16@gmail.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <99c79e8529eb2c125ffd1eaa9f5d6b479fec227c.1776020234.git.cyyzero16@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::40) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|CY8PR12MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ab6eec1-d54c-43df-e4f7-08de9908d3fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	J9GT541inn2WOxlf0Kpi+7ciB625Q7xpvepo/z/LcUhbetAR/RsNRkHZiIPPCK6eqd1E+1dR0R3dqrxT0laAu0XdANr94qJ15n7gfmYN/Ln7sdWktD7akvJ27Q6bQoOmvqcSThHiyxqtkTyBaXcAkyjAL4VCLTFBFeWpqCcUt03RwS2nUkDpTZzlKNbmfVj+N0XULd5BN6KJsabIhp1Z5Fd7PTzQIVqFZ0Vu512EUPmd9QdWmW+YQLfcxF+o7Rj0lpS2fhn2gsUlniDjpEZMJii+EebCe8FWsUIQmmqL+n9ZDlPLJ37dPzM9ke3cPyBcxTdlzydx3BM2js/rSQh624S5F35UJw6B/hel6P5W7gOQtKrBgR7A8ilkAwU2E1A6XyPQYxMQFCbXefI1gxXjc9khQNCBk0RW/JDJbOKr3qSoO92FlC96qPjC1MmwK4zxythwivr7mchceWc5/uqkYfUM1FG1IGwE1giZtROf7d5GI/SGr0N32QuHrRXaS0SbHRV5Y6b0qwqgzBbXeON2PjeGL7mlaO3BHgbx0bpzBIX195X5U33rMV3s4JWP0RUtXZAfo5AElTfpyr280xReiZg6LbJTfpCpsBQlB5QHp/ICgKeYA5Y5eGrTph5z89I4uT/dxrh9prRlFGWn/d2JtLnf9/VVocYPwi/JQTt9TFjLi5jgvl0vAzUObb7r9hl1ICrovOtdJ9KMMgMbjxpvRZKH0uxYnb+SVnlDizgEYW0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0cva084Z3BpenZHb3hlZDBhbG42WCtGVXI3akRXWVFTN3h0c0lsRThiWFc1?=
 =?utf-8?B?b1kvalRidGlGWEdsbFJML21mRTh3SXREdWFkczhuOE0rNHUvdWJaSCtveWZO?=
 =?utf-8?B?Z2dtQkZjRGtpWmQyaFAxc3RsSDZvamZlLzFzRzJJMnpYWFRrL1YvelR2Sldi?=
 =?utf-8?B?L0hraHdlVXUzMEZjeEthWGRJZVhlMldqZUdJVDFhWHg0enFpL1JHakVCdUlr?=
 =?utf-8?B?YXZvMUZvQVFhaE8wUmlXTS8rUkxteDZUWThzSFdZZlBxTk83Wnl3aC9LSkpa?=
 =?utf-8?B?cUxBaXdXWHFRTzhTOGhvaE5wbDRmRThmdGErR0ZTMXNoeE5qVDRkM213Z1Fk?=
 =?utf-8?B?Vnl2RHo2SWRneXRnQXVzc1hJd2ZWa1pzcjI4Z1ZmMTI1dUFrWkxMdGpvZFVa?=
 =?utf-8?B?bDZyT2FMK0lzTnZjSWQwRnVsNVVnSmhEVWxhajRXTXVacFVEQlgzU0FJbHFi?=
 =?utf-8?B?dzhDY3UwQ1lxamloY2RvTFNvRi96UXU4YWFRS3RFQUhvd0dnMmMreFlsZy9i?=
 =?utf-8?B?T0tnVDNPTnNzaG10YzBta3l6dGhscTRENXFVVmpDbmNRL2VuYndYSVNuYkRp?=
 =?utf-8?B?SXBiNjJpY01RY3cvTlRYMFRKYys3SCs3c0ZrYSs3WjhtWTRqc3hzK1hqaEF5?=
 =?utf-8?B?VjFISjUvT24zZ0E1SHZqSXdQb3N2RktKdjhoQnA3NXBIOXRTQ2xVUkg1ZDVi?=
 =?utf-8?B?WkJmRDl1Qytpc0tnNEhMZTdEdmtVeXkxa1NORW5mMHpzenRRMWNyd1o4SE5E?=
 =?utf-8?B?K1VVa0NORnl3YTRTWVFIQnJSazNtdG5MRC9mQUhzS1dFRFUzQjJSdStZMFZn?=
 =?utf-8?B?dWdsdGwwTDNndmZRejR6VVBOeHlYWmJ5bGd1N0E4TlpwOGVjTWVZa2ZLSTQ5?=
 =?utf-8?B?RXcyQUZ4UXBoMEpoSlJpL2Q3K00xckRZRUV1M2NDcFNqVGdqaWRMQlZvK09R?=
 =?utf-8?B?VWo4QytsdWhRK2huWlZmaDdQNjhsd2thU2hhWk80c0x6ZG1rSGpJMmMybDRH?=
 =?utf-8?B?NmRDSnFwd2xWV2RmM2VrVWFEQm5XRHZwZmZWdFdMRm1WemhxK2Yxa1VFZDcy?=
 =?utf-8?B?L3pOR2ZGTFgxQkpaREpCbmwxSC9TV015OC82cUkyeDFCV0NDWkhKSk1CSXFr?=
 =?utf-8?B?UUFXUWZzMzg5VVU0cXh6ZnFETCs4M3dNT2hUN3pqdEM1aHcvR2dYQ1NDMG1D?=
 =?utf-8?B?Qi9GUU4yMHRRSXVRdVgzOERZTzgyTERvK1N4a3pHSlR5NkgzNllhVk1NNXNO?=
 =?utf-8?B?empjK25Db2RKVS9UaE1haFo4b1M0KzA3a01RVlFyS2E2RU1pYnZ0ZTMycklX?=
 =?utf-8?B?bUpCeXZCbkkwYndQajVOTURUZFlzMEtQeHB5YnlscmwvTVl5T0JtVHp5NzA4?=
 =?utf-8?B?SjNLdU5lUUxlU1JlRUdZM3RkbG5lMm1tazlWSjJlZ1lEYnNONzBWM21GTSs4?=
 =?utf-8?B?dm1VRzhwZThxTkFGQ1AwYmVKL2hSVEZCTTdyTEI1SU5lVzRBd1FpemY3QlZB?=
 =?utf-8?B?Mm4yZy93dDAxOEg1V0UyVldkdzc5Zld3ZUlKdFR4NkM4TDBuekNWSXdEenJm?=
 =?utf-8?B?c0Q1R1RibzZjMFNzRHluZ0RsS2pYRDFYcUx3cENkMzZBMDlFOVdzaWJ5dlJZ?=
 =?utf-8?B?NjJlcE9Mc1BxVEdpMTVvamtZd2RFTjFSU0JYTlVkZ24yYkQwUHdvNnB4YUti?=
 =?utf-8?B?bStZVEIzQUc0T2NXQU13U1d4WGF4QzMwT3RXc3pyYldPQUordFlyc1hGNHRZ?=
 =?utf-8?B?bmNuTmpKUERYYXU0SFc3NkRZbDN2Z3hmdnRmZWNVbHZVK2FGdTZGZ2pnWExj?=
 =?utf-8?B?UkQ2bmVWbEFRMUVDQnpLQzlzQk9ITnZQVlk2SXBQdU9LSVJHdXVhN0RVR2wv?=
 =?utf-8?B?WGJ5WVJmZUlvSnVVUnpQaFM4WWJDUGNKUXBkaE9ENXNtV2todFkrMEFwcU9E?=
 =?utf-8?B?NzkrcGlyWjlQeHJsTGk3ampqbW1vRXpSYUJIT1d2R2tYTlQyOWVGNHNSbnIw?=
 =?utf-8?B?SHVXbXJiU0Z1RWZSeUsra1ZBWHk1V3luUElncHJaYTc3dmd4YzkyVVJyMEEz?=
 =?utf-8?B?aXhaMkxGK1kwSlAwSTkyK2VpSUpRa2FHTng4TkJTMmZoRktHY2lybi9qVmRR?=
 =?utf-8?B?QTZ3SURMa0JSdXdoaUxmcFBOWWNwUXNPckJ5WEwxSEZTTmJCOXBscnVsaUpa?=
 =?utf-8?B?TkRzM21TR2JmaHZvVVVUQTFnOTFYa1hGVUg1d3VCeDh5SHhJTU1DZHlZbVB3?=
 =?utf-8?B?STUxYXQ4dXVvY1hOdTJ3RzkyVWxhUzczVkNhTjRsdWJBdjBOQnJHTVU3b1RH?=
 =?utf-8?B?elZoUUxrYnoxQWdhMFJRcHFtL1pWK0xpR0VvTEZWYVdiaGI4SzNwQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab6eec1-d54c-43df-e4f7-08de9908d3fc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 03:00:33.0186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LyZbSs2CdLYhvvXwZ1vWFZ5K+uFNV9qJlcrrXavnkpbfSKV53kawM7IbpL1t6N/JcuWqjTqPfbt/TxogqzH53g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7540
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235879-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,zte.com.cn];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[balbirs@nvidia.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B06D13E6DD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 05:18, Yiyang Chen wrote:
> fill_stats_for_tgid() builds TGID stats from two sources: the cached
> aggregate in signal->stats and a scan of the live threads in the group.
> 
> However, fill_tgid_exit() only accumulates delay accounting into
> signal->stats. This means that once a thread exits, TGID queries lose
> the fields that fill_stats_for_tgid() adds for live threads.
> 
> This gap was introduced incrementally by two earlier changes that
> extended fill_stats_for_tgid() but did not make the corresponding
> update to fill_tgid_exit():
> 
> - commit 8c733420bdd5 ("taskstats: add e/u/stime for TGID command")
>   added ac_etime, ac_utime, and ac_stime to the TGID query path.
> - commit b663a79c1915 ("taskstats: add context-switch counters")
>   added nvcsw and nivcsw to the TGID query path.
> 
> As a result, those fields were accounted for live threads in TGID
> queries, but were dropped from the cached TGID aggregate after thread
> exit. The final TGID exit notification emitted when group_dead is true
> also copies that cached aggregate, so it loses the same fields.
> 
> Factor the per-task TGID accumulation into tgid_stats_add_task() and
> use it in both fill_stats_for_tgid() and fill_tgid_exit(). This keeps
> the cached aggregate used for dead threads aligned with the live-thread
> accumulation used by TGID queries.
> 
> Fixes: 8c733420bdd5 ("taskstats: add e/u/stime for TGID command")
> Fixes: b663a79c1915 ("taskstats: add context-switch counters")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yiyang Chen <cyyzero16@gmail.com>
> 
> diff --git a/kernel/taskstats.c b/kernel/taskstats.c
> index 0cd680ccc7e5..a80be5d9f52b 100644
> --- a/kernel/taskstats.c
> +++ b/kernel/taskstats.c
> @@ -210,13 +210,39 @@ static int fill_stats_for_pid(pid_t pid, struct taskstats *stats)
>  	return 0;
>  }
>  
> +static void tgid_stats_add_task(struct taskstats *stats,
> +				struct task_struct *tsk, u64 now_ns)
> +{
> +	u64 delta, utime, stime;
> +
> +	/*
> +	 * Each accounting subsystem calls its functions here to
> +	 * accumulate its per-task stats for tsk, into the per-tgid structure
> +	 *
> +	 *	per-task-foo(tsk->signal->stats, tsk);
> +	 */

The comment should read per-task-foo(stats, tsk);

> +	delayacct_add_tsk(stats, tsk);
> +
> +	/* calculate task elapsed time in nsec */
> +	delta = now_ns - tsk->start_time;
> +	/* Convert to micro seconds */
> +	do_div(delta, NSEC_PER_USEC);
> +	stats->ac_etime += delta;
> +
> +	task_cputime(tsk, &utime, &stime);
> +	stats->ac_utime += div_u64(utime, NSEC_PER_USEC);
> +	stats->ac_stime += div_u64(stime, NSEC_PER_USEC);
> +
> +	stats->nvcsw += tsk->nvcsw;
> +	stats->nivcsw += tsk->nivcsw;
> +}
> +
>  static int fill_stats_for_tgid(pid_t tgid, struct taskstats *stats)
>  {
>  	struct task_struct *tsk, *first;
>  	unsigned long flags;
>  	int rc = -ESRCH;
> -	u64 delta, utime, stime;
> -	u64 start_time;
> +	u64 now_ns;
>  
>  	/*
>  	 * Add additional stats from live tasks except zombie thread group
> @@ -233,30 +259,12 @@ static int fill_stats_for_tgid(pid_t tgid, struct taskstats *stats)
>  	else
>  		memset(stats, 0, sizeof(*stats));
>  
> -	start_time = ktime_get_ns();
> +	now_ns = ktime_get_ns();
>  	for_each_thread(first, tsk) {
>  		if (tsk->exit_state)
>  			continue;
> -		/*
> -		 * Accounting subsystem can call its functions here to
> -		 * fill in relevant parts of struct taskstsats as follows
> -		 *
> -		 *	per-task-foo(stats, tsk);
> -		 */
> -		delayacct_add_tsk(stats, tsk);
> -
> -		/* calculate task elapsed time in nsec */
> -		delta = start_time - tsk->start_time;
> -		/* Convert to micro seconds */
> -		do_div(delta, NSEC_PER_USEC);
> -		stats->ac_etime += delta;
>  
> -		task_cputime(tsk, &utime, &stime);
> -		stats->ac_utime += div_u64(utime, NSEC_PER_USEC);
> -		stats->ac_stime += div_u64(stime, NSEC_PER_USEC);
> -
> -		stats->nvcsw += tsk->nvcsw;
> -		stats->nivcsw += tsk->nivcsw;
> +		tgid_stats_add_task(stats, tsk, now_ns);
>  	}
>  
>  	unlock_task_sighand(first, &flags);
> @@ -275,18 +283,14 @@ static int fill_stats_for_tgid(pid_t tgid, struct taskstats *stats)
>  static void fill_tgid_exit(struct task_struct *tsk)
>  {
>  	unsigned long flags;
> +	u64 now_ns;
>  
>  	spin_lock_irqsave(&tsk->sighand->siglock, flags);
>  	if (!tsk->signal->stats)
>  		goto ret;
>  
> -	/*
> -	 * Each accounting subsystem calls its functions here to
> -	 * accumalate its per-task stats for tsk, into the per-tgid structure
> -	 *
> -	 *	per-task-foo(tsk->signal->stats, tsk);
> -	 */
> -	delayacct_add_tsk(tsk->signal->stats, tsk);
> +	now_ns = ktime_get_ns();
> +	tgid_stats_add_task(tsk->signal->stats, tsk, now_ns);
>  ret:
>  	spin_unlock_irqrestore(&tsk->sighand->siglock, flags);
>  	return;

Acked-by: Balbir Singh <balbirs@nvidia.com>


