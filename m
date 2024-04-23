Return-Path: <stable+bounces-40741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E908AF4DD
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 19:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ED701F23AA8
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 17:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409F413DB8A;
	Tue, 23 Apr 2024 17:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fQP9CHVg"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2051.outbound.protection.outlook.com [40.107.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E4413D8BB;
	Tue, 23 Apr 2024 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891825; cv=fail; b=oZAfwMk1Vq3ibtcG9gVAHhS6hbGpmzheefnZ5LvXR1yr1UlyWYCIIm2ifgufGlNODFB8WbiM/3EShFx4Brt+Bz3cA5hqnkPx/qyQSLdB5xRxRQf9tGWtXrw8WPYqwj5KVIYibjOnuR2KDpTba2J/0WeyycLD37bDkMNqONrwZNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891825; c=relaxed/simple;
	bh=azw7WBKJ4cxFQRKozbvlWVGVinV59GcXPqOSXTiRb8k=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=dmeln8VMBDI+CUJWdUbUBFNipMl3S1BVI/yOPxE7A21xl7MnZAgKv3PjPki9ClS1cKtfYo32nQGUETC7UlW/zEDiNCqBZeffFbSpI/Ca7oS8x2zQDqyHYPuUAeY9NfrMP201sS5rT8N+SWb+tE0Yrihk9JhuB21BBVGlnpY/y/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fQP9CHVg; arc=fail smtp.client-ip=40.107.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDsRh7z306E9xqIwlC+kmx5afFnBZntPl0FRSqYIJPTPadSJUCkGM5HCEPGjZ+fixZlEVneYwkBHCRuaYaCqAk7a4qm33mGp28hpFUAbOihGDVRzhciBV55fMImvTmzAPoNoc3/2egySSg96zqvc7qRwh8E8W8i4LT9UNRAgEfgMzBzbJUldh+eemnPKc3UvyggtLIjVzkM7GjXYXBtRxAWgsYmOwhEhQJOX++yc0lxYLI/Se6R0LEpJh9Fm4a3I0h2aSj24mRlZSvlistvxb1iwLj0C2L2DaqzTohIecHAr920ZbzQsVB9FjZVJNhRGQZTLO/MyEFbL8C4X9ik8Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUbhobUhbcUDqzqXCd+5Ybxqc0h8o3a7E7u0zW0prW8=;
 b=fH0aoPpBwAYtavjPr+tASEGV92kyU4Q6wtcs+2SbFpiRG5oyb6slUXLE1ALBrGS2VJ3M5eIcn8wAFEkZJcyZhZK1v+RMYrlcCJMj08eLw7bV2XdbAuWlmIeYRRqHvQRj7F6D/gPawPpRDSj5kWpsfXd7QhCpHQt5OEl03qYAY05STr0NdH1polncqv3cQ2YCHvr+i2DT6cfAv21mazOy1WhYpOHSVmdOc1aAa/lm+n8/dlvOzjEKIjeifKWh9er6a5E8MYV2O4kLbx5zzVIP5QJWqyc+j5rpJBh0lBDyIzDrc+YrZigeHIzHVau88Hn9Y8zBRd0L1SHQhkJ9tqAIcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUbhobUhbcUDqzqXCd+5Ybxqc0h8o3a7E7u0zW0prW8=;
 b=fQP9CHVg43daDxcbxI0q855+5ZalsaOXqtxKjg8EJswCsBoEvmmnxRBoDALTYI+QTh981OJLVpfYBp63tpSrKMfCzjPK8kFcxsHt5L61SwSBgkuXiLNhJH4LxP/gMe0+f6COOCXMgWn9S7TU34LE82gBnEhW6iioohh4RaL06ADCJzHed6GxfprSEB3qM7KOVecmqDRKD4ZMcs7D4Lh3br4GT8qNpnykPuQ0L7PbS+ITxrGl9CutC3WFcJHFKzDPB71rFqLGT+UW+yrV8nJHK4kwlld7WWJQjP3Uuo5E9f2MUPyUno2A0UhtkaXNp8uORRimXczWn1kApG3lVi72Ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by PH7PR12MB6858.namprd12.prod.outlook.com (2603:10b6:510:1b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 17:03:37 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 17:03:37 +0000
References: <20240419213033.400467-1-rrameshbabu@nvidia.com>
 <20240419213033.400467-3-rrameshbabu@nvidia.com> <Zie84KZ--UBnBydc@hog>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Gal Pressman
 <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Yossi Kuperman
 <yossiku@nvidia.com>, Benjamin Poirier <bpoirier@nvidia.com>, Cosmin Ratiu
 <cratiu@nvidia.com>
Subject: Re: [PATCH net v2 2/4] ethernet: Add helper for assigning packet
 type when dest address does not match device address
Date: Tue, 23 Apr 2024 10:03:02 -0700
In-reply-to: <Zie84KZ--UBnBydc@hog>
Message-ID: <87zftkau53.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0179.namprd03.prod.outlook.com
 (2603:10b6:a03:338::34) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|PH7PR12MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: affea4b9-06b0-4ef9-1a2e-08dc63b750f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eaxY6meBKLrEaoWvsWtG2JHH2EEQIsgZMJmFb5PHKYH1M1WwlVNo5Q0GpA4F?=
 =?us-ascii?Q?iW0NeyBuEXjErEpSWj8cMYPCBBUN46ZK8Ai73Od3PpS8DVI9XPKVhqGbyka3?=
 =?us-ascii?Q?j4pVfZhfQmBK/7lw4NqTyq4edJ3NX8duG9KEdjJfeH+mmtWKgAwwBrDqUHfE?=
 =?us-ascii?Q?TXW2DCoLO4YqNFg3pCOIUNMMRCrRpWZ8pG8xU/aHpp3uUtyE37Oc40w65oeO?=
 =?us-ascii?Q?sbT6/SABQSLLL7uYxUKq3luLCkDkGgfQFsxGS3wYZDYXl7iTCvYHN8dRWOIC?=
 =?us-ascii?Q?Y0N58DnJrCTIkdnqgWPhN8z2/smtlNd6nQOGMrCB5q+B2w5HKDF5VZTM4iO2?=
 =?us-ascii?Q?uKgsGt5kgQ4HXd204p0Fs3xj1+8dfQxNc1jU25r8gNHzUm2NN39zLfaEohzE?=
 =?us-ascii?Q?1cXPx8QJa9KTDqxIhM3g8O4BTLDCG+6Pl5AMLjzPF8MCGsNMgKtK+1zd70ux?=
 =?us-ascii?Q?3GuLYs3NjiNvVTLiDT00zBwEDjXbsnKRMttoIrGB7mzREgfNNE0jKubXrrba?=
 =?us-ascii?Q?o0Lqi9NIdYVbO/AL/2KjRjHTEoP9bATDLkH+TrwLfGD6LDMS0tK0W07cGbNx?=
 =?us-ascii?Q?oZzZ9mp6ZmlkcVmevo0Z9zNiBDjcqe62cZXC62SYnU3h64J++/HsxorLmOge?=
 =?us-ascii?Q?gwWWcwMAyPSqmHId40pwNPcEQnfRi2E2GjSv6hM2zxxXZqHHK+KLFdIYCUGi?=
 =?us-ascii?Q?d7cOyrtl6y4lFSqsUctqiJbyvzDArwkodOd4BcUk56BiCGbPEkcD1gK1Gl4X?=
 =?us-ascii?Q?QTTRPkEXkTYQdVpXIYbRBr1eMoOFSVWdEVITDCW2gkVPqVqk2/AawCeEbhL8?=
 =?us-ascii?Q?IhNhLsBXHBBpWXQPgl8yS3yOGnFcSvxWxZEOL5UZPs2Gext+wOmXbv/jdGTc?=
 =?us-ascii?Q?eoZP7EmCaUtTGjHcIVPGzVqVofuUsNO3DFx1xf87od5PgoXfgli/pPbXpow8?=
 =?us-ascii?Q?9BFgJeG0Ekb3OC3tjAGX2rmk0SWdmfjDLEiqUN+LMftG9zyJ4kAYqgYBbvRy?=
 =?us-ascii?Q?1GY8z+Btlli1Rp6GDheo6/pfTmuXU8AnNHBt0iMfGeuM5H6E4OzkxhtLG1aX?=
 =?us-ascii?Q?jMPP9196eZEjvctaYo3FncX2Mm/UA/OuISrYZa/Grk3wbaWqC/GRGbL8d9sS?=
 =?us-ascii?Q?q2vKJ+hPAhp0GJRf32CerLCtSS9nc1wAed3sekYon6O1hFjIjWyKVq0z41Mh?=
 =?us-ascii?Q?/n+zQq2Z8Cu+0hZTeeMpVtikH2ZL0+kfEAuwRuQEyE6ap8ryenkwu+4FCPos?=
 =?us-ascii?Q?hbJ/fEHbw2CSAlYde883i59eXJ8Z8DBRlvZNN4tgSQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f3wFbviNe0I/yDWj6h27UZJEotf5/upVy2hmTfXqgcOXkKgj+pMtNNx8ETNp?=
 =?us-ascii?Q?J9mJKze4GSULa00fHI6Ao/3Z3sGX3MmdmsCXg4WW0UinZGKFsHoYKnGtB3Tg?=
 =?us-ascii?Q?hRDwytMLGSV7doMvRuHkV53rwC7bzlb4qIrS1vhQkc2CylPShPKipuDMXH9p?=
 =?us-ascii?Q?uLRJ1m/uYOyxf3QILazeZjMhZYcGqmyh2+2B/AzjoFn+qJyOnREmR1Mo8k6E?=
 =?us-ascii?Q?sBtzuz0ILlLAaSYBDsvd/3ez9f6BxRvud793SKT28JsXUBpQ+PvnxRGB5xmJ?=
 =?us-ascii?Q?TbE22bRN2yrUoY2vc/la4h6Tj+XLvrVrbKiU4V9YtGXjuy9iR/k6S5U9sh8V?=
 =?us-ascii?Q?Og/con5RK4A+VfbDGcyV5iTYzdhFt/YerULqvmPOOK0qyH9+4eVgACXYzzCD?=
 =?us-ascii?Q?TVsxrcRY7Zl9XHkZBfM1l7sLJO1jCXu7Jzk6bU4z00nKp+pmI82297ubWJSC?=
 =?us-ascii?Q?2Uss2U67W89tllG8oSYj3jSyYOP58B1xOSwhQ7+6Zi3BI+JSn9niyL/cWOhP?=
 =?us-ascii?Q?OhvoxB346t8RM3xhc7V6r2Ks3qi5YQu3pOBNm/5nz6+eEjhBnDx8yuJ6/zAU?=
 =?us-ascii?Q?69aAQpJA7MIUPUtXYwunUkwBvDgGIL8iqoaG1kZ88R/GTLCDHitFkgDXpvAx?=
 =?us-ascii?Q?cUmkfVjqtFgegOTRJqMYwYX/ihzU3cjmFFEPEsqoT3sYIXPKpT7Rr5qe/bk5?=
 =?us-ascii?Q?75NQYJ/7TfdgXG+Zv8cfbT/GDFDRdI8O3/ZMsF53IrGXpDtye2ou7T71t/+v?=
 =?us-ascii?Q?q4WEoNPNN5sNBapYTZL5JwqfkpLyOcHKToGE/K8gSCNxUWunz4iqJaDzv3Zm?=
 =?us-ascii?Q?U2fARmHsATjxUI72JWziHuVDUtF7Zcz2eSInd7evy2otB3Fb15iYktQKbp/3?=
 =?us-ascii?Q?tukO/95/RjcssaOpwZNsWs2s6nuAF6h8Z4ls1tZrjnDhrdVMIdIH9cnGbwYv?=
 =?us-ascii?Q?YeP669hRRIBkauLn2DV9qqr8pyD48gwIftXIK4Y9i4+UQitb+kiVlP2R7XV1?=
 =?us-ascii?Q?m4c9PTEeUszG21dedg46iC7YWL1P6tKYhTKnyzkx4ZTUbO95hf48Izmw5Ds1?=
 =?us-ascii?Q?0sjsXU2FYMFj1ymNknknzpDWeOSHIJMwLSjgfxVNhYdoPm979SaVcbYwTFmD?=
 =?us-ascii?Q?wsCpV0c9p1y9VHu2XH3GnWgy8RTf3bpURlpdxVola55XJWQ0gu6Xsc5aUN6k?=
 =?us-ascii?Q?VhKh8GgOl84lU1MaNTdBgmziPA0lc89t0hjMROW4aN/mKdgmc07UGdmImsOV?=
 =?us-ascii?Q?uzQR6r3Lhrp1kIrgrQkD5fWK37PqHRr9fxGyoz2dO3hU/rEtzB7J6abrObjq?=
 =?us-ascii?Q?vEMGp8thJRo3KAO2j4f1MQehEcHll85277SFykMeB/SFuPZspvv2ixA6nBbf?=
 =?us-ascii?Q?W10dBkcNnYaiqzpYXX1TlUxbC7trgNyLuR1C9HT24v0qOA9m7CqdvTBBmYIF?=
 =?us-ascii?Q?4dZ/2tqmvFHWQ+UgzeQ9ZwF7+mb6yhtZyBV5n3KFfcBhLxxXCpTQf7eqmHbB?=
 =?us-ascii?Q?DhS+PXQgdIRVw+T6h4t19wiElpvlerxFb0hM8D82RdjrR3QckyBFDlPqz9Xz?=
 =?us-ascii?Q?BAH6gpJh2KsyPDHJOagoNBeJSJXNs3qtUHIlbig5JH11iSWhm4FsWGYK6mDW?=
 =?us-ascii?Q?HQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: affea4b9-06b0-4ef9-1a2e-08dc63b750f2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 17:03:36.9338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cuOU3Q7n1DmE17K5CF4vQS9gqY2EnuJdI9bcUzusu1lO/CkZm971Gt7sU3AEGk0KMNBQTCcNSssFGFfwsKsqKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6858


On Tue, 23 Apr, 2024 15:51:28 +0200 Sabrina Dubroca <sd@queasysnail.net> wrote:
> 2024-04-19, 14:30:17 -0700, Rahul Rameshbabu wrote:
>> Enable reuse of logic in eth_type_trans for determining packet type.
>> 
>> Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
>> ---
>>  include/linux/etherdevice.h | 24 ++++++++++++++++++++++++
>>  net/ethernet/eth.c          | 12 +-----------
>>  2 files changed, 25 insertions(+), 11 deletions(-)
>> 
>> diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
>> index 224645f17c33..f5868ac69dec 100644
>> --- a/include/linux/etherdevice.h
>> +++ b/include/linux/etherdevice.h
>> @@ -607,6 +607,30 @@ static inline void eth_hw_addr_gen(struct net_device *dev, const u8 *base_addr,
>>  	eth_hw_addr_set(dev, addr);
>>  }
>>  
>> +/**
>> + * eth_skb_pkt_type - Assign packet type if destination address does not match
>> + * @skb: Assigned a packet type if address does not match @dev address
>> + * @dev: Network device used to compare packet address against
>> + *
>> + * If the destination MAC address of the packet does not match the network
>> + * device address, assign an appropriate packet type.
>> + */
>> +static inline void eth_skb_pkt_type(struct sk_buff *skb, struct net_device *dev)
>
> Could you make dev const? Otherwise the series looks good to me.

Good catch. Will do.

--
Thanks,

Rahul Rameshbabu

