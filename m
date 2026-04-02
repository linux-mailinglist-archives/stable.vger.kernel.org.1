Return-Path: <stable+bounces-233058-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBFoCNSVzmkBowYAu9opvQ
	(envelope-from <stable+bounces-233058-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 18:14:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B45F738BB36
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 18:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3DC5C304905E
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 16:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A228F3F0760;
	Thu,  2 Apr 2026 16:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="RyBnpRRn"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010047.outbound.protection.outlook.com [52.101.84.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD143EE1F8;
	Thu,  2 Apr 2026 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775146409; cv=fail; b=NBFZHC9DWKYeeJiGb7ydsjZtvp7Aksce0d0hWDoTRsJ7FWG1oQlZlylKcwnzEJcXYuIPgLS26NP8JVjQpzntCe2ezUNzCHMlA9AhTI+XKMAg+hAJkIkOoT9IiH150A9FxxFph7P7x3t62o97Rxp7k2OKlm1zFLq0Mcx78mZu2mA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775146409; c=relaxed/simple;
	bh=9RDPJUb0S+jQHNEhRef7VeiFmmcUIv4Ruyzn6SnHdww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bDAslWf2LvXISCMcq0GoivhLE9ZhTAMQNyU9nQrHD5aBM/zyEdZn6p7pJMrI3JCuOMsQaEOEXkr270YSmnIjTtRXhrkfrZYo46R4P9f4Mon46zftAhdlCT5ckYypN4VnZIlRSyULcrRvInYeF5PCKCkPuzIN6Br3SPq0NefD5SU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=RyBnpRRn; arc=fail smtp.client-ip=52.101.84.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGVjIc/2gM0k9eYP3F2/SPehFBZBg9MK1NT+lgoHxmh0glbiKMnZ2nycU4Gx40R35S4RHEma1vFRGfyCYKNKNafMH8VxH5pRZ//btRj7Q1jL5x+t8mvijIKBqGjtprV82gKCOkyjKef9H7yhhp7VMzAiWxYtVOkliQ+jV3D3j9Kpe+p/bQ3lcfiG9JOEebdBJgZnW4iC2LbLEIJ7vKDcLwrum2FpOx4E7pdsy9moD4Nn5pBD9YNnbcszo6C1z0hAGVMOaIAzp6uNDST/sFJe/lgUkNccbw14UeDlh8L8u7lilW6N+LTTFIO0uFkGcLe78PTOvdcuJDuyEpCGwifx2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4xCsxJ0MBE7GBrBWV8HPVo7BkpNhA2dCnSrsm/3FkY=;
 b=razHzH66usdtFF7u115UIiUt01+O0Z8Sw/a+PpT3ugfvrWGgUTB9vlpVb89nNgmp0boanEofXeyfwOAZpQJYiEGE2bO0xZCES3BUEMHKgosVZ2NcEzsQf3l8ygB3d7YFNUs6H1/AwA2FDpgYFxiNTa0nRzr8XKO4S7Sx+mtC+J4CRRtY2edmwbIkeSEwtOz0yifr6smnWHNIXZnHtLX7Kzff1Y8zz3rs/xH1TkCyMX1D9cJE1HIaviFtL8HjW7u622tKJK/drEf/k9VEOpeClQv9hLwp1aR4XzsDNYcYD/31vJzCs5plf6tnDGNpMwHhX/7kOpm9JglLo7beMbsz2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4xCsxJ0MBE7GBrBWV8HPVo7BkpNhA2dCnSrsm/3FkY=;
 b=RyBnpRRn7JLgbhi33e23En/5z8zslGi8pFBdu4gRhUevYGRWI2aPn920xiL31zSR/ycimaEoagcL3uSTcClOmy2m+LfjhUEOqiFkQl1w5JySBgpu2qVj1VFXyDONxyPZYSnl6VG87CCZ0GvVksAfl8oCgGSry3SEtyoUlJuH9wSfX0o4vh3YT7yI7bG3DizVQUtHNv8DC7wyO7lXo1/xIk6c6hUO3C/KUKJ47dUyP/v69cT2QiaWVXf+DXGN38CuSjIqD3llZWahC48B+BMi035kpt0JQy9OPE6KpCY3zjBEV2jrcsMfjsycOGB2LGXcD8cVsVDNHEH4XmUQF0bwkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DB8P189MB0966.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:16b::8) by
 PAXP189MB1952.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:28c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.20; Thu, 2 Apr 2026 16:13:20 +0000
Received: from DB8P189MB0966.EURP189.PROD.OUTLOOK.COM
 ([fe80::48c:33b2:d870:d0ca]) by DB8P189MB0966.EURP189.PROD.OUTLOOK.COM
 ([fe80::48c:33b2:d870:d0ca%4]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 16:13:19 +0000
From: tugrul.kukul@est.tech
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: alex.williamson@redhat.com,
	kevin.tian@intel.com,
	jgg@ziepe.ca,
	lorenzo.stoakes@oracle.com,
	david@redhat.com,
	akpm@linux-foundation.org,
	mike.kravetz@oracle.com,
	linmiaohe@huawei.com,
	yi.l.liu@intel.com,
	axelrasmussen@google.com,
	leah.rumancik@gmail.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david.nystrom@est.tech
Subject: [PATCH 6.6.y 4/4] fork: defer linking file vma until vma is fully initialized
Date: Thu,  2 Apr 2026 18:13:11 +0200
Message-Id: <20260402161311.63484-5-tugrul.kukul@est.tech>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260402161311.63484-1-tugrul.kukul@est.tech>
References: <20260402161311.63484-1-tugrul.kukul@est.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0155.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::7) To DB8P189MB0966.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:16b::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8P189MB0966:EE_|PAXP189MB1952:EE_
X-MS-Office365-Filtering-Correlation-Id: 66476987-2efc-475b-df29-08de90d2c125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	I77YrM9BmaTb9CvioHQieFnzGBkb2J5AkaOlCKz56sOTftLXQQGqIvlf5f0GwdCKd1Yj1gua6kVj9epa2EukmJac355qYoNF1ejQk1tUqtChnqdNCf2c4mr06SX0dyXrRXtb2LAVutB+jCGV/smqIAUeqphXMfIbWnp/A7lHBbo5yLb15zhth3NSjTKgiMz2biEGO0N3gp4UXxgBVR6+0BBYwDuqNgNDVNPpLqW9v6gZCeJDZMXb5Nc3buMsz61Am36GyBymfzXI11YDNpEpuJbT8d26JgJLpalfihWhR7YAWy162qbuZaxFRwZqFDHqfAd1EgQAkB/RQYujRa10FCnoELzpxMHrMDtcF5Bc3m/H3gFqrTvRWYwKLZLKHMzkW/y0mXzSTbNQM/tVPSZ664tqtFqwUOtA1WJZrh9Oki5Au7p5FSMzHw7MkfAM55+GS5GSr70htxRoDyjV+N55wdIcIaeoPtoVp7VjCr+lpLUs1yGWA3cMqCeAgE4zy4ceTZr9AvfjVVsCxWat7SkeYB0pCR7ro5Ku930oLoGeutEJPZ5qkZS/X9ww5eFjXH94dvXk/dV0QCdJKrH/BUVgg0yHPcmQFkPkcJ1kh8pmZ0DdMvXVaSG0KX3P7rXOD2cGMK8/6vlM24gS/TWdZaXiPoCbePlgNWI0xXQqY6Jd3t1o4OSClvSrzoExPlLkz2DauEZqQ/IzmVivRPmcqjcbwdR9nij3dG+wI/O5U2QBwos=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8P189MB0966.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDBZdWZHQlB2OU41TjhDSzN3dnkyazU0T0Q1bjB0NHpDbVh0ZXYzYmo2VFBa?=
 =?utf-8?B?aklBWldVMFNDb0o2U0ducFhIU3dsY1N2SDZGcVdFblNlT0U1RFF3R1BYY2Jj?=
 =?utf-8?B?S2JKWGR2WTRmemw1S1JHRk5DWWRZY21jSlQxTG9sajlEbGh4djNjaWhpeXhR?=
 =?utf-8?B?bW9TOFU2eXdPSVVqNnVPMFZkQ2R2VXFiWjNWRUhNZkU4L0EwUTROOFpKajdi?=
 =?utf-8?B?Qjc0aW9oT0N3UWFQdGtpazJMOHFKNHVuMmZLTzVaQk92TWxYcXBLY05BczJq?=
 =?utf-8?B?bVZTK1VIeHI2N2dXNHFlRTlKY0llcU1aVUt5TmV1bGtWSUNJazFKVFNicWZz?=
 =?utf-8?B?L1E0THZLZWgrY0tOaDQ1OEw0YnA2UFhjL2d2eFpWNnRIYTRxODhRYXBzN0Zn?=
 =?utf-8?B?NWMxaVZlNUU3NGVvMXcvWC92Rndjc0VuRDBBRTdhc1JJQXgxZXFoMUcxeWww?=
 =?utf-8?B?MWQyQjhDVWdkQ2Z0eGwxVFlveXNUcUwzNkZ5dDQyNEd0SU9NcnNQSGN4aW5p?=
 =?utf-8?B?bnM3WnFTaXJ6bkZjZWc3ZmwyRExvWVRhVUhsL3RMT1BBZmFiL1BKS3J2eDRN?=
 =?utf-8?B?UXErUTlTdzBsNzRPMEIxVkk5c3g4QklUWU95Y1oxTnFSbHhlZGNLN25jS2VS?=
 =?utf-8?B?TjdoVTdhYW9FTEYrNDQzV2IxVnl1UzhDaHhwK2ZCY2t2cm4xUHFPcTNuTzJ4?=
 =?utf-8?B?cWhzdFJidDVnaXo5ZzNtU083dzk5M0hzVXRxazRMRFNHMEVEdlhRT1lTTk9F?=
 =?utf-8?B?YlNsNlYrWFpkeUdyOUZzd2orWlYzNlRnR1UxelI3RFBpRHIwYURxOXBwdHd0?=
 =?utf-8?B?eDdwSWI4cDdMdFMyeUhjOHZFRm1mR1NFbEZuQ2c2S0pUMFVaZzFSNmdhQmxV?=
 =?utf-8?B?OXkvUjVqVWdTb3N1K2F5eDFQZnhycEk2d0xKYmtSdGRTcW95SFdHMUJTOVR1?=
 =?utf-8?B?eGNRWG51clpGblRGN1ROWnFmQVVkMWFXblpocUtVblZFb2I5UUlzekFJUStv?=
 =?utf-8?B?cVdtanUrRURIU3dzSjc5eHc5Vk15aVRFaXB4cURxdzVmaXF2U1phcXJvZy93?=
 =?utf-8?B?Sm1jVURvTm5Jd3daU20xOXpHZjUyeWtkZ093WnQ0dHd1SVVQSnIyR01uempB?=
 =?utf-8?B?bWNFVFFOMWRXVEFnaUdFaG13Z1NyQTJrMzJoOVVYT2d5bDJrWTNCL2xMdWF6?=
 =?utf-8?B?bDNaek45RnVtRmhHTHJ2UVFBMTFhQXRiL09saklBa1U0ZWZLQWRnQ252QTk2?=
 =?utf-8?B?RWtOdTBsVnEwK2Y4OGdkZ0oyc0dpL0xvRUt5ZEJSNUVLMHcrRWNXNjgvTjhn?=
 =?utf-8?B?VDF1NHJTN05YdDVVaGJCTStIb0VJbmp5Z1FnM21ZNmhUc0VXaU01VDEvcXQy?=
 =?utf-8?B?YWNSdVhFZEhHWlF1REFUaXpDRUhwZzVJdzBRY2xZVk5HTG11b2hpb1NzUk1o?=
 =?utf-8?B?Zkl3MTRzODc2bEVOR1k1TUNMcHZGcWtteWpmUDBUQk8yckxsRGNlcVpBQ1VV?=
 =?utf-8?B?RXAwai83cGM3T3ViTVN6TDU0anRHd1dUbnY5RE9XQTdkeWEwSVppMVNVVEhh?=
 =?utf-8?B?ODFxK0E3RDM5REY5OFpYQXpQa244c3JrcE9WVEpCR2xlV2NjcjgxR3YvYkdF?=
 =?utf-8?B?Zm1TNk1UbVhpc01nYnhVZzdvcWQycVZrKzBTZW40bVpPTVpYZ1FEY1lxeXh6?=
 =?utf-8?B?Nm55Tlo0WTQxS1pJWFVhdzlwa2Vzbk4rTlo0MEdjUXRhNjJNaitkbWRLMnlI?=
 =?utf-8?B?U2NnNEJFSUVBcStNdm5jeVBnaWtnVkd4dUh2U0RBOFI0YXFvczZZQndjTUtI?=
 =?utf-8?B?L3NicXd6RHpEVmdJZlkyVXNnWG02ZmdmSkgrSlh6dWtnTitOcjBWNDRQZUh4?=
 =?utf-8?B?WnhmLzZOWGZJWFZhRFN0SDlDS0UvVXo5akR5VW9iOTZJK3E5UXlwQUYyaC9t?=
 =?utf-8?B?Y3pIOGJiMm5QU0Q0a05rRk11V04zcEk3QTZGVkJHbURQMGNWZVJubmpjMk1L?=
 =?utf-8?B?aWd2QkZFbE41Rm94MDZJT25JTzdRZW94Z3ZwMmZZZldMcWZKcTIvdDV6T3ZW?=
 =?utf-8?B?YWhSQnZTMlBVNXc0S3RJZ051Mk1RZm1aT1JaVFRqRG1mTElGK3Z0Q0lGUTNC?=
 =?utf-8?B?dm5jVFBhUy9NRERsVERHdXd0ODFaTk1uSXVnTzVnNjlDR2wyUjVvbm9ueDIx?=
 =?utf-8?B?cStkUndpeEt3QVB6TWRPYVRna3YxakdQWTcvR3VBcXhHTDZVZ2xBUm9yZkk2?=
 =?utf-8?B?b0NhWmQ5aG4vWUNzMlJQeEdydVl4eXpBTjVISXNmUnY2UVI0RTJuYXEwOVBG?=
 =?utf-8?B?a0RyS0VHUlYwVElzTlZnVzdDQUFCcGNGTXZ0NTlkZHU0amV2TTRRUT09?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 66476987-2efc-475b-df29-08de90d2c125
X-MS-Exchange-CrossTenant-AuthSource: DB8P189MB0966.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 16:13:19.2535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snTAJxq/tCpOy77LLgr+zln1AFmJJTUkcZdovl2meRGFN6RhPSaFtIPAgPoX5UIqsp3+5fYXJEu38JUJhY6R1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP189MB1952
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[est.tech];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,intel.com,ziepe.ca,oracle.com,linux-foundation.org,huawei.com,google.com,gmail.com,vger.kernel.org,est.tech];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233058-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[tugrul.kukul@est.tech,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[est.tech:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17]
X-Rspamd-Queue-Id: B45F738BB36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Miaohe Lin <linmiaohe@huawei.com>

[ Upstream commit 35e351780fa9d8240dd6f7e4f245f9ea37e96c19 ]

Thorvald reported a WARNING [1]. And the root cause is below race:

 CPU 1					CPU 2
 fork					hugetlbfs_fallocate
  dup_mmap				 hugetlbfs_punch_hole
   i_mmap_lock_write(mapping);
   vma_interval_tree_insert_after -- Child vma is visible through i_mmap tree.
   i_mmap_unlock_write(mapping);
   hugetlb_dup_vma_private -- Clear vma_lock outside i_mmap_rwsem!
					 i_mmap_lock_write(mapping);
   					 hugetlb_vmdelete_list
					  vma_interval_tree_foreach
					   hugetlb_vma_trylock_write -- Vma_lock is cleared.
   tmp->vm_ops->open -- Alloc new vma_lock outside i_mmap_rwsem!
					   hugetlb_vma_unlock_write -- Vma_lock is assigned!!!
					 i_mmap_unlock_write(mapping);

hugetlb_dup_vma_private() and hugetlb_vm_op_open() are called outside
i_mmap_rwsem lock while vma lock can be used in the same time.  Fix this
by deferring linking file vma until vma is fully initialized.  Those vmas
should be initialized first before they can be used.

[tk: Adapted to 6.6 stable where vma_iter_bulk_store() can fail
(unlike mainline which uses __mt_dup() for pre-allocation).
Preserved error handling via goto fail_nomem_vmi_store. Previous
backport (cec11fa2eb512) was reverted (dd782da470761) due to
xfstests failures.]

Link: https://lkml.kernel.org/r/20240410091441.3539905-1-linmiaohe@huawei.com
Fixes: 8d9bfb260814 ("hugetlb: add vma based lock for pmd sharing")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reported-by: Thorvald Natvig <thorvald@google.com>
Closes: https://lore.kernel.org/linux-mm/20240129161735.6gmjsswx62o4pbja@revolver/T/ [1]
Reviewed-by: Jane Chu <jane.chu@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peng Zhang <zhangpeng.00@bytedance.com>
Cc: Tycho Andersen <tandersen@netflix.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Assisted-by: Claude:claude-opus-4.6
Suggested-by: David Nyström <david.nystrom@est.tech>
Signed-off-by: Tugrul Kukul <tugrul.kukul@est.tech>
---
 kernel/fork.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index ce6f6e1e39057..5b60692b1a4ea 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -733,6 +733,21 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		} else if (anon_vma_fork(tmp, mpnt))
 			goto fail_nomem_anon_vma_fork;
 		vm_flags_clear(tmp, VM_LOCKED_MASK);
+		/*
+		 * Copy/update hugetlb private vma information.
+		 */
+		if (is_vm_hugetlb_page(tmp))
+			hugetlb_dup_vma_private(tmp);
+
+		/* Link the vma into the MT */
+		if (vma_iter_bulk_store(&vmi, tmp))
+			goto fail_nomem_vmi_store;
+
+		mm->map_count++;
+
+		if (tmp->vm_ops && tmp->vm_ops->open)
+			tmp->vm_ops->open(tmp);
+
 		file = tmp->vm_file;
 		if (file) {
 			struct address_space *mapping = file->f_mapping;
@@ -749,23 +764,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 			i_mmap_unlock_write(mapping);
 		}
 
-		/*
-		 * Copy/update hugetlb private vma information.
-		 */
-		if (is_vm_hugetlb_page(tmp))
-			hugetlb_dup_vma_private(tmp);
-
-		/* Link the vma into the MT */
-		if (vma_iter_bulk_store(&vmi, tmp))
-			goto fail_nomem_vmi_store;
-
-		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
 			retval = copy_page_range(tmp, mpnt);
 
-		if (tmp->vm_ops && tmp->vm_ops->open)
-			tmp->vm_ops->open(tmp);
-
 		if (retval)
 			goto loop_out;
 	}
-- 
2.34.1


