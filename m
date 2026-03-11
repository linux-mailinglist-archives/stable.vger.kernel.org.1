Return-Path: <stable+bounces-224768-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFDCMFDhsWm2GgAAu9opvQ
	(envelope-from <stable+bounces-224768-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 22:40:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB5A26A845
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 22:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1619D3043D5D
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 21:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D354233D6EE;
	Wed, 11 Mar 2026 21:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sch.bme.hu header.i=@sch.bme.hu header.b="qcRfQfyW"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020128.outbound.protection.outlook.com [52.101.84.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4474B175A73;
	Wed, 11 Mar 2026 21:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773265227; cv=fail; b=CtvvQAlBeBdSMtznaZekshm+FdXsnun+rdLEjKDlw+v9BJIPvwusuudAcrygCxS0WB+1rD/nsg/SMJq2hEaOt2vuXIXFsBf9RIidg7e36wH0PqX3qD+recvmhwHpgwAIt0EPirtm4GMcvL2NFp6H+r78ty285ZqE21yeVWqjY+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773265227; c=relaxed/simple;
	bh=VnKYisqBM76if/82Vym9wtRSrDHy0JIjiCH7GTorVzA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nHCRHSBh0mmuzukYhwXRmCrsBVcK+za5LJ3HiQ0PoTryyQJu8KNXSrI0R/3oxXG2T6SnRE5myjm6B4MCwCNKdKN9jBlf52+9ic0jx7x0dt/vhS6WUzSfeG3ZbZs/8jP8/q6ei/ocAcsReTmgxapTdJif3f3SOL9QoZKCq7t8grw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sch.bme.hu; spf=pass smtp.mailfrom=sch.bme.hu; dkim=pass (1024-bit key) header.d=sch.bme.hu header.i=@sch.bme.hu header.b=qcRfQfyW; arc=fail smtp.client-ip=52.101.84.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sch.bme.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sch.bme.hu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HvK3RQaL4KON/Jj9WjMurlqEm+U6rS2kj8ccPoJLzUWOP59oVignVCJ4B1TgrLPH6EPo3rR8T0wNBV3OfCQf28ZMP+x3Bws6wjAfpWGhGUJav4UBE7BrtkzFj01WTpUgkbWaYbFwUcScvipQv9mXupvgsDk2wPEQLGgWyBQDdTeJMk/d0NmUGfap5zz7PH4oYokWdrAih2xSv1aAeVjkf9LTD6cueewWuajdIPDf9ANLSq5YgPlcJfMSy5NwFIyk/TO7t37Gn7LuAzUSm39LTQZ/2y4Uu0SicuSQqIT5dGYizRpy/DAKohYyozGDsWm/dRSjSJbwnHbVf8b6s/gW9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0g8zkHqqCzdQkUmC85QMQxEOz7dBw4UTWWeqdNq2cM=;
 b=KPz9L3uQEw+baPiZitOJWSUfA29n5ct4POv3GuhTBHvpja7j6PqiA/CGBw/Ju4eArBFpZJgVmkhm23/byKkxYzpXqXu9BwxY9HoQEUgcbnnEEmKgUE6qC//McbCHwIiBy2YRQ+vdcUR0HU0Zl0h9o66tven76cb4g3rx5LSvrQD2+rjDBN3C4kEnolpKYswYhW0U/GJLFEycfdEMJDyRg45Phsk6xdlzozgtVoKNAxXUzITT+gXgoV4OzrvwijTba+ffO7H4CnuzQfN1KYkCCk5/3Kce7aNa1hwCpsETjc9X5bfru/EPj3gbNCeHbIjT5/6wGWwkj9tdkby245qzbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sch.bme.hu; dmarc=pass action=none header.from=sch.bme.hu;
 dkim=pass header.d=sch.bme.hu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sch.bme.hu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0g8zkHqqCzdQkUmC85QMQxEOz7dBw4UTWWeqdNq2cM=;
 b=qcRfQfyWWIweuf8BIQFECXp0QhmRyRMJJV8iklqABV7DwgfCQ6qkh49JHzJ6D6KEbqjxjZlDazN36xqAeZj8cOHQuDegnTQXAmIhC3nTUHH2qQc5VO7I5zS94n66OrsZMvm36mTx/8XAExx0cBwMFL+kbklxK3EUzeR/OY4/nTk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sch.bme.hu;
Received: from PR3PR04MB7260.eurprd04.prod.outlook.com (2603:10a6:102:8c::15)
 by PA1PR04MB10913.eurprd04.prod.outlook.com (2603:10a6:102:484::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 21:40:21 +0000
Received: from PR3PR04MB7260.eurprd04.prod.outlook.com
 ([fe80::bc60:c1f6:2fb5:8cf8]) by PR3PR04MB7260.eurprd04.prod.outlook.com
 ([fe80::bc60:c1f6:2fb5:8cf8%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 21:40:19 +0000
Message-ID: <32f6793c-d728-451d-9e32-35d864fe0035@sch.bme.hu>
Date: Wed, 11 Mar 2026 22:40:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: cp2615: fix serial string NULL-deref at probe
To: Johan Hovold <johan@kernel.org>, linux-i2c@vger.kernel.org
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260309075016.25612-1-johan@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?QmVuY2UgQ3PDs2vDoXM=?= <bence98@sch.bme.hu>
In-Reply-To: <20260309075016.25612-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P191CA0038.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:7f::15) To PR3PR04MB7260.eurprd04.prod.outlook.com
 (2603:10a6:102:8c::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3PR04MB7260:EE_|PA1PR04MB10913:EE_
X-MS-Office365-Filtering-Correlation-Id: 59a1944c-6767-4a96-6d9d-08de7fb6caa6
X-LD-Processed: 79f0ae63-ef51-49f5-9f51-78a3346e1507,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|41320700013|366016|786006|19092799006|10070799003|1800799024|56012099003|7053199007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dsUiVhoqBS3gqNCFjijCHIMzLWHRryhzOg7QrPeSlWGtyhNtIBp3gwZ4P+iDe8LPWTWCHsGLLwz2LrxSAgzlOHqXszRotc3mSLPsmvaYOQdJ0dM697FATuuFxfBKf3a+AW0R6ezHr2VHwwXi73kosKVHAbB/nOOJsEE8011iM0/YSOPPpzTKdTUQLqgvVa3sbNH3VqIN8MPqRr/XD8cdz6wZXx5hMukWCwJAaz4YUX/TkR/OrKZGAJGBu8JKwPZ7n/aCMvZa4EoWRi4WkNg6R8K2t9svWK1yqG4k61+1CqVrBK/4zYKmWo7p1KO/QRxRKpaodBE2DWRR6Ek3VWcc8au+lUyQoxAYCRpqtebkBcCGOxTPZsMeHv28j8aWR1vRkxu/2QhoeHHv187yAbbhQeCc8XVTQAKK6kTwSSq2yocKwXc0rBc/HneDG6SsWLxEr/q6jQqKc6svnrdShMc+2ujyHnUWgVNbzizyC63mBXR+ABhgP+ZRBdqYIF9Z/L2DMV3gNkORjl45hl/Ts6nx62FaY6Nj9B3AVNWO621+fGJfQ1GoAysGT1JzGwFDf2Dzx2tE3FKEm6XSQwDXOvJ7UMS9RvaRN/vLeTXrcRypIiYvpoqxyiXZupQuwqQGMp5Ra8hOmHtPa9vqxWGgl3DSGmlTCcOMvEZJpD1J4Ei6m1seSNUTkkMpcIowmdoiqyuEClI/5kv8iB6jLWoWn4Btz/BOch0aEietpdLEPcndTAQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR04MB7260.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(41320700013)(366016)(786006)(19092799006)(10070799003)(1800799024)(56012099003)(7053199007)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFZ0VXNDYkE1NU43dUVWZ3c4a1Zvb254V0RTbTMxUFNFSE1oY3B6RFR0MGJh?=
 =?utf-8?B?MFFSb2ZtaGplaW91T0lWSExLRFpOQm1FS0VIWnVvVjE3TVo2eFE4TkY2YVhH?=
 =?utf-8?B?UENoUkk1cnlOMmszM3l1enJjWUczT0xCQ2VNVU5iQi9abXlPUWlzd29WVnNE?=
 =?utf-8?B?S3BHL2ovVHdnQ1JPN2RKL0FtbE9laW5YeWxXRXJ5QlZidis2QlIzclJiS0k2?=
 =?utf-8?B?VDBRRlVFMjZYd2V6RVNCOXlkYU55Rm56ZzBYL3pxNWl0VjM2L0oxQ1JvKzBt?=
 =?utf-8?B?YmlWNTBCbFJaVU9HUzFXendZZ0Z3cElBRjlPTmlpWjFlRTdtRnFRK2ErTW9R?=
 =?utf-8?B?UTlsRVd6Ykp0RnJuS0Y5RjVzZ0toNG9RcVJIdDBNUjJibU9BY1dqNldMeWVs?=
 =?utf-8?B?andKNlZoUU9LVXJoOHk2eU8ySUhWOVFGdDZINUFtKzZMUUNHbFdCU1hNWUlU?=
 =?utf-8?B?Uy9zcEl4VnpLQTc1dERQWTcvTGlKNXdzdEZRNkZYQ1ZQU2o3ZFZIaDZPR01x?=
 =?utf-8?B?b0kyeXZvSzRVUFpOdGtzNDNBdGhHczFzR1Q5QmxvN1NEcE8xZXhYRkh3YzFI?=
 =?utf-8?B?TmswaDR5eGJLbnVnL1kxWWx1U2pxamtGdFJEYjBEQ3NxYzI0UzVpUkNOb2Zx?=
 =?utf-8?B?WW1DSkF3NXlXNVcvNlZnWmtFY0NCcjF1bXdTaDJHQ1U1VGdNYlJTY2Y0QTFl?=
 =?utf-8?B?TWdyZUxDYTVnbjFkNVMzOThuOE56VzhQZTVDaEtmVXdSUmtzQytJUDB4ZzRG?=
 =?utf-8?B?TXR6T1FnTk96VndCVFVyUmFIbURoUElBWFZRU2lSOGlnaHBrRDQzUTBDUXFw?=
 =?utf-8?B?dlZkR2kwYTIvL1BIZTZrdmUweFh2b1lpbFpyQmdlQ1Q1RmNramRLQmo4VFB1?=
 =?utf-8?B?Q3FsWkhEWXVkZERsWEdPZFdiZGVZNEZiMkUvbkQrUWx1ZnZJYVpQaWxDWmhn?=
 =?utf-8?B?MzJLczQrUWp6cTNwcCtMenJ1c0xHbWcxdExHcjFXbE1PWUJBNWxzWGkwOSs1?=
 =?utf-8?B?ajNlR0EvSzV4emR6M1oyRHZnd1d3YUl4bkZvSE9wQXJKZE1XTmx3SWNCUnUr?=
 =?utf-8?B?ckNwRGVYSEVNQXBKL0pic3hFUFN0TzJ4MGRscWd4b1NXM01MSXRQRU1RcTRz?=
 =?utf-8?B?QTNUT1BMZmpzQ0NpWUtwOXYydkg3dnQ3ZGRVbS9KbVBRa1UwbEtNOExKamt6?=
 =?utf-8?B?TXJDUXpnMURkTjlpZ25yRC95V2JvWm1kUjBheUhhTUpIbThMZUVZRkJIOXBx?=
 =?utf-8?B?QW4zeERkSFZvczNPSnVSczB1eWhYUGwwdXo4Sy8yRUlrV1FBcE5ueElrUVhI?=
 =?utf-8?B?UURIWE5weDh6Q2E3eDQzTU0zWm9ZQk1VVFFtQlFlQ2Y4T2hrT1RWR2hPNHd0?=
 =?utf-8?B?b1pocHdsUzFRcHg5enVRVzV2eElDQ0ZYRW15UVZlUHdlQWIvK3NjcTFFZGhk?=
 =?utf-8?B?Z2hLZlhFdVdvN2U4T3lFNnVkQlZ3VnprZUdZaTduRkpOWDdyK0ZlejZwZjJk?=
 =?utf-8?B?dkpqNTRuMWhlOUFRTUxIcE1oSFV3enFhM2ZJdERueUlDcGV1dFIybU9saWZP?=
 =?utf-8?B?WWhrSzl6Y2dBUkpvSkI4YkxhaExEMGxDQ1h3NGpReWxPa2JLSms3OXdSMW15?=
 =?utf-8?B?bFlxSjVCa09lUC9RNHBaclNEd21DdWc0UlpXV0RjNWFyNnRlZHJMOWFsTnJY?=
 =?utf-8?B?MHliWUFjWVJLTFdJRzhtWHJ3UnJjRDR0WURWVnpoMUhmSVZvcWpUZmlMWGJO?=
 =?utf-8?B?T0lxVy9kZnkzNDd6ZFptVzV0eXZRK3JHK2NqaEk0RHlwY2RuQWI0ZGxBSHkx?=
 =?utf-8?B?NWh3YVE2b0xjdkY2WS9YNHpOTTloQXduSFp0Umo1U3hQMHdFdE5WYVVtcm9o?=
 =?utf-8?B?NG45Lyt2U0RGZG1KdStXT1J6cjYwZkZRdkNMcnJnTzlqUVlPaFF6WVIyNVpD?=
 =?utf-8?B?dDJtM1JLUGJKV0FzMGx4WEVwSndMdEJ6ajNKZE1yUS9TQmd5L0pMbEdvYU8v?=
 =?utf-8?B?b0JCMDdUcHBRTER5MmlCcUMzNDlYempXV1U5WEFuUzJqaVZFS0ZDdTR6Vlc0?=
 =?utf-8?B?eXBNTVkvUG52eGRURWtrckRwRys5ZjFWUkU1UjVTaUVDdmhrbkp3eWRlZDQx?=
 =?utf-8?B?enBjUTNVSUdWNis5ZUM3SUttb2RoL1dPeSt2UzBsd0J6ZGFmeGQ2TjlGUmFl?=
 =?utf-8?B?UkF6T3dFenoxTWdOYlJUUVphQUt4a0ZVd1RiQ2xhcUZpMUxLV2JhOGtUV1Vx?=
 =?utf-8?B?c08zS2k0SjBXdXVOcUtQZ2k0NVg0NHgvRUdET3lqVU5XaHJyS1pxbk43SkNk?=
 =?utf-8?B?eFlPQkpKcE5XVU90SERFL2s3RHRZYnY5bmVvcHgvdlVLWXdsRzJUZVVETmV6?=
 =?utf-8?Q?hJL2RhD/CdSAZ320ycs1m9xXhsZiVoJjOqqYrBsEyMgG4?=
X-MS-Exchange-AntiSpam-MessageData-1: H6UpsNBeRrBy6Q==
X-OriginatorOrg: sch.bme.hu
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a1944c-6767-4a96-6d9d-08de7fb6caa6
X-MS-Exchange-CrossTenant-AuthSource: PR3PR04MB7260.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 21:40:19.5287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 79f0ae63-ef51-49f5-9f51-78a3346e1507
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hgkxFoHb6hYBUjoKj+6jqg6vzlaUGtKgST4Hc06EPwmuSlVLzm6gfTtBe2zXKGArJuDyAVsnSC9m3abv7virEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10913
X-Spamd-Result: default: False [0.55 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MIXED_CHARSET(0.71)[subject];
	DMARC_POLICY_ALLOW(-0.50)[bme.hu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sch.bme.hu:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224768-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[sch.bme.hu:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[bence98@sch.bme.hu,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sch.bme.hu:dkim,sch.bme.hu:mid]
X-Rspamd-Queue-Id: 1EB5A26A845
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reviewed-by: Bence Csókás <bence98@sch.bme.hu>

On 3/9/26 08:50, Johan Hovold wrote:
> The cp2615 driver uses the USB device serial string as the i2c adapter
> name but does not make sure that the string exists.
> 
> Verify that the device has a serial number before accessing it to avoid
> triggering a NULL-pointer dereference (e.g. with malicious devices).
> 
> Fixes: 4a7695429ead ("i2c: cp2615: add i2c driver for Silicon Labs' CP2615 Digital Audio Bridge")
> Cc: stable@vger.kernel.org	# 5.13
> Cc: Bence Csókás <bence98@sch.bme.hu>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>   drivers/i2c/busses/i2c-cp2615.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-cp2615.c b/drivers/i2c/busses/i2c-cp2615.c
> index c1dbf7961a02..951de6249834 100644
> --- a/drivers/i2c/busses/i2c-cp2615.c
> +++ b/drivers/i2c/busses/i2c-cp2615.c
> @@ -297,6 +297,9 @@ cp2615_i2c_probe(struct usb_interface *usbif, const struct usb_device_id *id)
>   	if (!adap)
>   		return -ENOMEM;
>   
> +	if (!usbdev->serial)
> +		return -EINVAL;
> +
>   	strscpy(adap->name, usbdev->serial, sizeof(adap->name));
>   	adap->owner = THIS_MODULE;
>   	adap->dev.parent = &usbif->dev;

I didn't realize at the time I wrote this that `serial` can be NULL, I 
was under the impression that the USB core would pass me an empty string 
if there's no iSerial string descriptor (alas, it does not).
AFAIK real CP2615s will always have a serial, so returning error should 
not be a major problem. However, we could just as easily skip 
`strscpy()` and go on with the probe with an empty name. But I'm fine 
with either solution.

Bence

