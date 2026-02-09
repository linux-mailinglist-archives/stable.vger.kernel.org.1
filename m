Return-Path: <stable+bounces-214889-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHZSH8uXiWlj/AQAu9opvQ
	(envelope-from <stable+bounces-214889-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 09:16:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D330410CD3E
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 09:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BFEE3006B08
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 08:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FEF279908;
	Mon,  9 Feb 2026 08:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="Iis0xWQw"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013037.outbound.protection.outlook.com [52.101.72.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361C1126C03;
	Mon,  9 Feb 2026 08:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770624967; cv=fail; b=FbTHIaDf17c2wSOFbLLtXMam9s3XwJ8qdSJqfUyp7cr/ZsfLqFsRg2t7Ud88p0oNlVXNdfWr8RLoGt5qHaYBk/gHDbQFK3syC6ObRmlkSVUX6X52cp9HjOpG29LyelA2RMUg00lTs1PFvzd7U4DSYcYIJdliYQkGpXmQ9WDJ844=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770624967; c=relaxed/simple;
	bh=GP5u8n78KGMk/OmAFtQpaX2yrVZUZEYoGDcYxbeLH0s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=c4adTiGluaMsOzHyQThqglIg6k/HjI9NxUx5sDikEEkv9lXvoDzTmzxns2IfA5ThJUVQolTStcAJ1DixqkEx4fe2BjExO0PnwMptdBpfLku+kfU30maH9EHhcTOrHyZU1VfNi4HQQ0u8yJAhm5/2EQBKR6mlZ3qOYiWdF5K2HJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=Iis0xWQw; arc=fail smtp.client-ip=52.101.72.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EENHBNRWFLXFqGB8nM7fXGoBkG0UZuwdZomur/1NwD06fwgOqTtZjweqK+ht99mkVXwv30IEDCPB1sm5qbbFvM0Nb7PIIZigZRV4BwAUAbj+OmCYmFEG1RrDDUfUN6lKA3/2HPIyqNaGHkMWlbjjhV6kCD+IM46ggikMugPBbBeXfSSwyDU53G5axKgBrTMrRYeCSsPRAzXw2hvuppQdn0r0jfG4ufq9kGw/kHr5kFHCOad0GBbmrbSRxwLRzY6oBGkKX299l6DGoFNncQpBm7DT5p4JrPGb79RZwhA8jCl3gT2mfIMamn8DcL7c610xeWfMeZiFsn6eSCrLROt4BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kS09glv68ECFMW1g6mENOolNmP+WZVCtQyzZX8eAxg=;
 b=HLq2TW70GA6N2ocCGPsjDOcqpMOGwuRGXuJBPTJNj4qBl8y43v9sirOrPsIl/5E78X6KHppMoqvrD5dMpaxFjFRP53xy/n//mKOsJFFSMapPw/51uSNfkzvDrW8yH5IsRu0Qm9kHgPEze1/iLXpy+A7+yiM4ik0qOohwAAPjLKu/C08j7K2ZpskT+5/b/gjjZChVJ6My/Nsmhx9/pRXcrofvwDWFjbJLIR9YpYpYOBRPIYMVOfARIW0vJtP6OzWS2S0SE62KrIGfRwR4L8FqrGrVkCgiCh4ttQTOVGbZj1F2lepCP/qXib8Bs+NQSqFgv565xIkGCrzUJZWrYCdDOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kS09glv68ECFMW1g6mENOolNmP+WZVCtQyzZX8eAxg=;
 b=Iis0xWQwC0gsqHhbeENZHFsThGyssdQMjxrNOF/1rc3H2QDESI/klm4TJ5Xiora/wF/eY20xR1ROeqbw7SEsVFbsxoNQeSrHUM1ihWzcKlWMj3skSEIz/TeiwAFVaaK9aqWJE7/ckSA8ho0y48i0RpX5PLIk7R8avimRVw5u+Jd20kEm4dsvn3IFWowiggFfZTaSlhp5vhy1dQPySeIETXRz2EoTG4wjibz1tzNVB96w8Y06CQBXn9bmegoElr+eQTPoDk9qrSVnxtSUWOx8a8tOTt1HGl+KDfNiuYKnw8yOw40nBCnKzjBQLq/fwuIQh/NAAMCjkOr6qE2wEyWAoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM (2603:10a6:b10:f3::19)
 by AM4P189MB3524.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:6e9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 08:16:04 +0000
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::49f:4bc1:672f:45c8]) by BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::49f:4bc1:672f:45c8%4]) with mapi id 15.20.9587.013; Mon, 9 Feb 2026
 08:16:04 +0000
Date: Mon, 9 Feb 2026 09:16:01 +0100 (CET)
From: =?ISO-8859-15?Q?David_Nystr=F6m?= <david.nystrom@est.tech>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: =?ISO-8859-15?Q?David_Nystr=F6m?= <david.nystrom@est.tech>, 
    stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>, 
    netdev@vger.kernel.org
Subject: Re: [PATCH 5.10] net: mdio: fix unbalanced fwnode reference count
 in mdio_device_release()
In-Reply-To: <2026020318-affected-irritate-cda7@gregkh>
Message-ID: <6e7347df-f1cf-e058-cc94-3112bf110b70@est.tech>
References: <20260116-backport_cb37617687f2_20260115100804-v1-1-9796615d93ab@est.tech> <2026020318-affected-irritate-cda7@gregkh>
Content-Type: multipart/mixed; boundary=832332919211423711770624961339234
X-ClientProxiedBy: GV2PEPF00007575.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3ee) To BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:b10:f3::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP189MB3241:EE_|AM4P189MB3524:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cbd5cc8-3bb1-48e5-ba5f-08de67b377b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bCs1Yit3QmllUklWTnlHbTNOU1NJOEpIQ21XNmoyNGtkWWF3WG5UOHVpaDRx?=
 =?utf-8?B?bE80ZUt0d0dmTklQUXVXNEZVeXFKcGFMdllDOUxjUzRoNXB5ejNyNEx3MW9D?=
 =?utf-8?B?SitmOGUyeE41SVBNOGl4bjZ0azN1Zk1VR1FXT3JqbjJSaHlha1BtejUxSG1T?=
 =?utf-8?B?a1JxV3dCZ0RSRDZTcm8yZzdpdUJIV2dNSWNLb1Nic2QzUks0ZzhYWkhnOEEy?=
 =?utf-8?B?RVA4KzJuNkxVOExZaHJrNFJnOWVKK2REbFM4NkRsNmxiQ0tTWTllOGhFcG4w?=
 =?utf-8?B?M01TS3dPSXlSN3dWUE12dHFvSlljV0RYZnQrNCtweTB1MktLWEFESFFxd0Jx?=
 =?utf-8?B?VmFXZys2V3dIRGZZeVRocnNVMjV6OGFueXVqU0pCc2ZnNWl0UEpFcjRqS3lF?=
 =?utf-8?B?QlM0aDBKL2pPVFgrckM5cjd3Y0VMV0padjEzVDFKUDdtODFUUW5OYzNyTHFm?=
 =?utf-8?B?Z0VUSkUraDY2Tzg4b3FYUDFWWVpuMXduRGdhR0Q1d2ppZVJFL2hxc2Q3QUFI?=
 =?utf-8?B?NWtXL01Kc2JsdVVpWjh5UDhOQTdIY1MwUzR3czQ3TCs4RlNzckM2dkVUdjNx?=
 =?utf-8?B?S0hTRTdNdDc3S1p0TkZWUGR4dFdSQUZLZzljR0dXb3h0aDNYQVNNZXZVUWRB?=
 =?utf-8?B?djZFb1VScG96SVdZTW9CRUlZNlE0MDh4RDVMTk1YR0laR0pPVExPN2t1bC9n?=
 =?utf-8?B?aDd6VEdJY2tzMGlsNXkzRVZhUnVTeG5RamlqL0dQS01OOVl1V0gyNDFuYk93?=
 =?utf-8?B?UnJ6UzltSkRWQVh0SC8vZFNGaUpwOEowUTQyOW5IYkxlaVVkeHlJb21GYzhy?=
 =?utf-8?B?MlpzNkJIbGI0bUVmYmNDeS95MmdXdmNSMXVzc0ZuSzVPcG5iZE9zQnJnQUI0?=
 =?utf-8?B?dStxT1VSNktnZGtMeEY5MGVlcnNjUGhmSnhobWN6V3VoS2JxZ1ZtTTlvOWkz?=
 =?utf-8?B?TkVua1RDdm1UWWlWTjJhemVZWjZjMnh6V2JXaVFvQUZYUHdwQWIyMmR3dkY0?=
 =?utf-8?B?SFJobDgxcS95eDNueGM0STJLdThVQ2tOdFFHMldpMzhReHR1OUhoZktzUUlQ?=
 =?utf-8?B?dnMxc0JPV05aeE9MMktoWjIxZDBMTnJVNUZ6OVY2Z08zZ1FWWnoxQnJaL1BI?=
 =?utf-8?B?bjFCSjVRYVlmSWozTEVvSFlZdnA2aDltaVkvQ0FJakt3cTJXNVp1bmIwT0Rw?=
 =?utf-8?B?NE9TUmFYaFg3Ly9DZFZBd0xxaEVnTEtrUWFEVElJVVpmK0RoYTBNSVFnVFRS?=
 =?utf-8?B?WE9yM1RnekMrejY2L2pJS0FISzNXYkpvRTc5MGpBdnYrSWpKanhpSGdpdW9v?=
 =?utf-8?B?UHRhcThqTTY2djhSNjZVUDloeDA4cWxhSitic05kTHZLb0txVGFuK282SDJR?=
 =?utf-8?B?djZ2bnhSN0Z5T2tHSFpodUxvVzgxUktBK2FqUThLbzlobG9ORFF6a1lJWDBC?=
 =?utf-8?B?eCt6V3lQQWdOL2gzT2Y2ZEhIMU5qcHRDa2Zsa1VOcTNhTnZyZENDMmFCdFht?=
 =?utf-8?B?SkxYWUlBeGN3K0dPeUlYelEzYzRNcDNCSkVUbjF6Z21TYWswQjBqd0pteG8x?=
 =?utf-8?B?YWY0NlBRQUpBWXNhUWFZTm1uZ2MwaDBlOWtRUnluNkRnQTZUem1EYTdHK25o?=
 =?utf-8?B?K3BoT3RPMVE3azlNNFBBR0ZLQ2Jma2VuVjlpbGVVRWpsYTRhRzRzMnRCV21L?=
 =?utf-8?B?R1B1RHQ1YWFRMVRNVGZXMmtmMzZMY1ZPd0RBNXdzZnAzRHpXRU5XZDdGYkk0?=
 =?utf-8?B?YTZkOGdSRjhxMW1qZXdQaWIrcUY4bk12Q3lrcWNLZS93cXBuaGh4d2pxTm5R?=
 =?utf-8?B?YTJXL3o5dmZlaHovSTljSWt5OWFOYUU3SWFod1Nyd1B4R0p3QUcrZjRweGxS?=
 =?utf-8?B?cXVIZzNXdUxuSFl2d2h5N0VhWFZqUEVXaVBYY0J2N2JWZzk1b1pNL0pNVTMv?=
 =?utf-8?B?cTFkTEdjWTV1RWhqcnNqUTZSV0s4aThiUDk0YVJoMm5reG1PamFnWlFuRkg5?=
 =?utf-8?B?anZta09YUkVNMktzcFNTQStvTW1LbDZmbWRZSDd6Q3pOTGlQNHBZTElZNkV3?=
 =?utf-8?B?ZkJVaC8xOGpPeGVWY3FyMThIb0IzdXk0K0Q1QkRnUFJrU2dmanhpUkcwYXk3?=
 =?utf-8?Q?RVVk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESP189MB3241.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUZaTzJmNXJ6bHN5emxYS0hWYUtjSUdpWVV3SWh1ZzZiVDRaRU9JQWFwQUdU?=
 =?utf-8?B?MFZpL1ZuSmdDeGxyOVp4RzUrT25UOE5KZHdReGVyTW5ELzQ0ZlkxdG9sSDY3?=
 =?utf-8?B?OFlnN3BBYjZQUzJUSmVmU2J6OEVadWJQOGNOZWdLcmI4WEtueWNvWWQ1bEph?=
 =?utf-8?B?KzR3Sm54dGRXdk0vQTVGRDNDeWNBM2ZyTXdsQ25FbmlqSjArcTh5cC9hUk4y?=
 =?utf-8?B?bjduaGlTRlZDNk5laWRUNDc2cUwwN2lLeVFqNGd2Mm92My9PUHpZUlA4T1Zt?=
 =?utf-8?B?V2V2OE11U1E1UVl2V2I3SlJqRlZORkFJL1RxaUVtckZBeWVVTVozTjNMQzg4?=
 =?utf-8?B?YUM2Zkwrby8rK2xrUnFYSjd5V3RHNnVTOFUzYWtQNHAyYXZySWhrblZIdzhV?=
 =?utf-8?B?TStUWlhBQmtHeWxVNnVSSWxEUng2S3FVWFB5bm83eTRENVRSTUFSb3p0dlNV?=
 =?utf-8?B?NXhTdUN6Wkw0MzdtQWpSd0J1dHR6d0hWbU1zVTQvRVFPMGdiM3oyTXFpZTFZ?=
 =?utf-8?B?MVVyQ1ZUR211a2ZhaFNaOFFEcWF6VlFiNUFEU0tOTklHcU5YdDE0WXpYbnll?=
 =?utf-8?B?RC8zeW5EZGVyYmpxcnp3a3d6bmhHY3pWMjFqczNqSnVWWVpXK3B6cUZZcWJX?=
 =?utf-8?B?akNzMFBlZVJpOFRncHJuRVUrOXcvU2h5NXc5c0JLV1haRXAxVm51RFIwS3Nh?=
 =?utf-8?B?QWdnNGVHZUhtVEpwT09MMGVFbjE5NEtVenNEZVJENTNvS3JHUUN3L05xYzhI?=
 =?utf-8?B?SUxGcmkxbC9oOEZ6dVBJV0ZPS0c2aWN0NzVOb3EzVDF4NjJWOC9NOVoxUEhO?=
 =?utf-8?B?N05Qd0I5Ykp3L2hLTGpyZTJGQUlkeXFhM0JVNkR2UUlUamIvc3NxRk8zZitU?=
 =?utf-8?B?NnVCckxPRzZuMGVGRU9qeGl4dFlnQlNxcWhFZ3VKR1RqcHQreHFPRm5mRThM?=
 =?utf-8?B?R0xINHh6Y3pDclRzZkE4ZGdja3FnL2R2clRLZGFZWitoV1haVlI1OENVeDZW?=
 =?utf-8?B?OGIycHEvYVlKeE9sTldySHU3S2dPNHJrb1B2bk0xTkY0alBuaGFRNkxzRnJ2?=
 =?utf-8?B?alN2UFlIa0dUbGVnR25aVURqZTZCZXRUamltLzg3K1NRMnk2dmI4aWNZZEtQ?=
 =?utf-8?B?cUhaRHBqODllV0N2ZlVxSHJ2dEtiNzdRMUFwOUllUm15TExvTUovTDhyRWd5?=
 =?utf-8?B?QXNEQ2JTU2FBSGVHWGw1MHdWWm5JMVZYWCswbXhYWk5aYkV2Tk5NbTh3NTJG?=
 =?utf-8?B?ZmRCUHJKNjYxWG16KzZHVXFHTHdiT21kMzNSRWx6cmJoWFFLazNDR2p3SXNL?=
 =?utf-8?B?WkFFUVpLcnRWOUkwYnRRRUN6cDVWOTZJbVhvb3VPVUlvaUZxM3BHcGd3U1Qx?=
 =?utf-8?B?MUxrbndQSWUyMWtaZVFFMTZWNkk3b243R2JGd09QZDNsTVAwQmdXT2tPcHpx?=
 =?utf-8?B?dDhxMlpCZVFkaDlqQXlEcE4raktBSVRsOE9IVUwyVktzM2U5Vy9ZYmIxTVlW?=
 =?utf-8?B?VmEvc1RPNURJdHJTV2xPdU85Y1RoMlBkN0pRMUE4UVAyRTZ6c1JUQldSemtU?=
 =?utf-8?B?MTA2blRmWEJNVDNsZjJrc0pzSk1jTGJTTU9vUTQ5VmpBOG5zdWJpWEFRa24r?=
 =?utf-8?B?L0g5cThIZ3RHbTJHLzdaTTR5N2JuOGpMTm0vZVozWDdzZG1rNCswMkVsb3B1?=
 =?utf-8?B?dXV6bFRaOHZpOE02eHNTR1YzWldPaHBWZW5FaE1FVDNoNGhZRE9lSXQ0NnE3?=
 =?utf-8?B?YnBWV2VpRFN6T3FsUUJ2ektsVDJ5VEhZdkc1b2ZOVXhCdGRyaml1ZE9NSVhy?=
 =?utf-8?B?V3V6M1JCTC95MjlpNzJaRTVORHgvcEsxTWd3dXlpQ2lnMGdtNzVLWWFwNm42?=
 =?utf-8?B?NW1vdW5iZzA2ZWkzMUF6amEvbUFTKzJGS2JpR2k1dUdtS3oyVVlYZVdoUjNX?=
 =?utf-8?B?RHcwRlZod2dJWldTOHJlYkoyVHhBbVB1ZlllR3FBcTE3ZEpwWkVKanVYMnRN?=
 =?utf-8?B?SkZhZ0JJa08rWGlMRVhHSWp2c0tPQXVtUG55dWk5bTVQTWpSaUg4dnYyNEtE?=
 =?utf-8?B?N09lT1ZYVFJCNExvTzkvWXdvcGtmemJZT2VXZThaZWNCcVE1Qjc5SjVsRGRv?=
 =?utf-8?B?NXA1SVNjUi9kcE03dk5ZMXBpMEMrTUJkSTFpQ1BZWjIrSU82VGphUVpOOGd4?=
 =?utf-8?B?NzIxbkdraVc4dU1IZG9CVjhkb0s3Z3piWkZmSWVFekVOYnBSQ0VyMVFsL0FM?=
 =?utf-8?B?Q2RhMklJTUs5SGR0SUZBVDBNdDQ1d255OG90K3plNUhDRTlQd0JYQVIwUWpM?=
 =?utf-8?B?clNvYTJCRzVEdTEyalVWTW5vdmJoN0lvREdSMWN0Qms4ZGFXd2xmUT09?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbd5cc8-3bb1-48e5-ba5f-08de67b377b4
X-MS-Exchange-CrossTenant-AuthSource: BESP189MB3241.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 08:16:03.9369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WHlnrEmB2YF6059GfRgttndY09rHJRHvWQmhcuJDji5D/kntXse7Zd8Mro8NgxS9BUHdbdUOYSBdd+BivS9oEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4P189MB3524
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	CTYPE_MIXED_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-214889-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[est.tech];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[est.tech:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david.nystrom@est.tech,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,0.0.0.4:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,710700c0:email,huawei.com:email,est.tech:email,est.tech:dkim,est.tech:mid]
X-Rspamd-Queue-Id: D330410CD3E
X-Rspamd-Action: no action

--832332919211423711770624961339234
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Tue, 3 Feb 2026, Greg Kroah-Hartman wrote:

> On Fri, Jan 16, 2026 at 11:14:45AM +0100, David Nystr=C3=B6m wrote:
>> [ Upstream commit cb37617687f2bfa5b675df7779f869147c9002bd ]
>>
>> There is warning report about of_node refcount leak
>> while probing mdio device:
>>
>> OF: ERROR: memory leak, expected refcount 1 instead of 2,
>> of_node_get()/of_node_put() unbalanced - destroy cset entry:
>> attach overlay node /spi/soc@0/mdio@710700c0/ethernet@4
>>
>> In of_mdiobus_register_device(), we increase fwnode refcount
>> by fwnode_handle_get() before associating the of_node with
>> mdio device, but it has never been decreased in normal path.
>> Since that, in mdio_device_release(), it needs to call
>> fwnode_handle_put() in addition instead of calling kfree()
>> directly.
>>
>> After above, just calling mdio_device_free() in the error handle
>> path of of_mdiobus_register_device() is enough to keep the
>> refcount balanced.
>>
>> (cherry picked from commit cb37617687f2bfa5b675df7779f869147c9002bd)
>>
>> Fixes: a9049e0c513c ("mdio: Add support for mdio drivers.")
>> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
>> Reviewed-by: Yang Yingliang <yangyingliang@huawei.com>
>> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>> Link: https://lore.kernel.org/r/20221203073441.3885317-1-zengheng4@huawe=
i.com
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> Signed-off-by: David Nystr=C3=B6m <david.nystrom@est.tech>
>> ---
>> This series backports 1 commit(s) to the 5.10 stable tree.
>> ---
>>  drivers/net/mdio/of_mdio.c    | 3 ++-
>>  drivers/net/phy/mdio_device.c | 2 ++
>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/mdio/of_mdio.c b/drivers/net/mdio/of_mdio.c
>> index b254127cea50..355c3ee21cd7 100644
>> --- a/drivers/net/mdio/of_mdio.c
>> +++ b/drivers/net/mdio/of_mdio.c
>> @@ -168,8 +168,9 @@ static int of_mdiobus_register_device(struct mii_bus=
 *mdio,
>>  	/* All data is now stored in the mdiodev struct; register it. */
>>  	rc =3D mdio_device_register(mdiodev);
>>  	if (rc) {
>> +		device_set_node(&mdiodev->dev, NULL);
>> +		fwnode_handle_put(fwnode);
>>  		mdio_device_free(mdiodev);
>> -		of_node_put(child);
>>  		return rc;
>>  	}
>>
>> diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device=
.c
>> index 797c41f5590e..f72d18ee2792 100644
>> --- a/drivers/net/phy/mdio_device.c
>> +++ b/drivers/net/phy/mdio_device.c
>> @@ -21,6 +21,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/string.h>
>>  #include <linux/unistd.h>
>> +#include <linux/property.h>
>>
>>  void mdio_device_free(struct mdio_device *mdiodev)
>>  {
>> @@ -30,6 +31,7 @@ EXPORT_SYMBOL(mdio_device_free);
>>
>>  static void mdio_device_release(struct device *dev)
>>  {
>> +	fwnode_handle_put(dev->fwnode);
>>  	kfree(to_mdio_device(dev));
>>  }
>>
>>
>> ---
>> base-commit: f964b940099f9982d723d4c77988d4b0dda9c165
>> change-id: 20260115-backport_cb37617687f2_20260115100804-bb6cefe39d44
>>
>> Best regards,
>> --
>> David Nystr=C3=B6m <david.nystrom@est.tech>
>>
>
> Breaks the build, how did you test this:
> drivers/net/mdio/of_mdio.c: In function =E2=80=98of_mdiobus_register_devi=
ce=E2=80=99:
> drivers/net/mdio/of_mdio.c:172:35: error: =E2=80=98fwnode=E2=80=99 undecl=
ared (first use in this function); did you mean =E2=80=98inode=E2=80=99?
>  172 |                 fwnode_handle_put(fwnode);
>      |                                   ^~~~~~
>      |                                   inode
>

Oops,
This patch was work-in-progress and should not have been sent your way.
Wont happen again.

Br,
David=

--832332919211423711770624961339234--

