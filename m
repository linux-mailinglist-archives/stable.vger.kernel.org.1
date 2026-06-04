Return-Path: <stable+bounces-260458-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YuBHOr1eIWreFAEAu9opvQ
	(envelope-from <stable+bounces-260458-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 13:17:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D0663F591
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 13:17:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=bcUgNkqE;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260458-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260458-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CA6E0300B9EB
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 11:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7493940913A;
	Thu,  4 Jun 2026 11:06:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013045.outbound.protection.outlook.com [40.107.159.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1584014A9;
	Thu,  4 Jun 2026 11:06:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780571190; cv=fail; b=kfVV4HceoEKksVyzeuddQPFETCvR2c+H92JkQWjvYX1L7YrXI+EWV2JeC/FWwOBFuOmlr0g91giD1R6KOtZyh7cEuTDsKk+wTA04+wZ5djYmZx11hrHKsdTsSraYooAyqfBAQzZXjV8YBiGZDScJlPfHpmjcCi/ygzS2NDJqd3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780571190; c=relaxed/simple;
	bh=STJf7+wUvcB5Nsk0zhqV5hmxx8zLqIsu9tV7q9XGTRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bjejrjW1fg23CCA1K3QszYPl4rj1SZ1iKxbe+BeiUZA7xaxVgklEc6mB4WTpbDpGIL8wbhfV0j/PIrWZGgGzt/pSJ0M4SwKXLV4o7lYDeL/3VaxLr5TAVsaaspEV40JYGE+3RMpvXBsaK1tBAsq6H9HE7w2dQWAOlXGYOAfNl50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bcUgNkqE; arc=fail smtp.client-ip=40.107.159.45
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AcgrVCz02pi0sE34MwrLJApPZ6BqqHxb3yR5s9U68GtZocU+eH7LwdfZV3EE9KxHpq+giy6kp0bFcQ2eofrFGf+u2WI3BTGU6wjyCuwevNx/mrRal6hoC7Q7vcxAfxhyi4qYz5B8iPpNOQ9yZELXIzVCNlivVNsV035UQ5VHCc8BNWXW8++4PkRaOpdRDUjRWdiYPKeyaHTjgb70nosGBanNRfRKRI7roZXw9sS+/vnU7ssj7DAkkr8WUpFVznnCenSbDOTBZod+71YdQAzih37eEuCOnqk7sKSP7xuq8nSZFOEI6ylWDDfvmVTX9o8imEtqoetlmzQTEZqVUmUtfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ukrUdqrrihFq0H0i5bCcoFAXIDTTrh25kD5dL5cEx0=;
 b=aN81o7jBsSUoCZeSEJYqrt51F54gjToJVobxYqTw6KI9yKxwik6Q/vUodV23/lhXEJFNe2BQ3e26hs30EpUSulr86YqF+nj2fnu9FWmrOf/L0ic47gigZsw0kllEFf9dV58yYLnnT/aJC6CbvWX2TxYMpjlf7dVmpuG+9GEwsrF+ByoQGu+cCHYZMKKboLOiD/uA3SGg/SUg2fnTfthKzyaJfdNAq2nmYyJyQKA7Zbi9tfQYymIGkMSyVDJeeagrE9lKw/GTvyI51dLS/U9A0yizBSzoev0pLG7zhXLTUeme/jGSFrU4Aio3U4qwg3u1flQCJe4ShvjnKqi8FQu2Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ukrUdqrrihFq0H0i5bCcoFAXIDTTrh25kD5dL5cEx0=;
 b=bcUgNkqEmzH7YMaxHU3b2hInUCRD1TLXUD290Y555jq9ORqmWGM+OmrCfEnw52Oe8TFvGAuDya8zfqhhFkngqI5C+w114NPiMpb1vEF6CZbDVtOZ0SweTMnlQqkkSbOb6XCz2Uy9MPDipuf4myhAvf82Pbi3ygirOs6wUswfEYx009Kdd1c0uAuUsDsHchGYg0OQoA9V8K5YxutBoYH/1FvaDJv9rcQM8brAxklpzxuhzMXtCeE6BAkmpnkTqKiOUzMAZ9UfbfLGwxusMzHM5qCv2be2YS/7sF13JLRj9SMZ95UkSd3cDW3cLYbc0XJu4fg8c9+3CvLLsgjETG9BKg==
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
 by DB9PR04MB9724.eurprd04.prod.outlook.com (2603:10a6:10:4c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 11:06:25 +0000
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d]) by PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 11:06:25 +0000
Date: Thu, 4 Jun 2026 19:05:23 +0800
From: Xu Yang <xu.yang_2@oss.nxp.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Xu Yang <xu.yang_2@nxp.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] device property: fix infinite loop in
 fwnode_for_each_child_node()
Message-ID: <x5liep46c3yzqh3wfsfa2euku6j6yka32clpiwf2zkqdm6czds@b2rll3k67yhd>
References: <20260603-fixes_fwnode_iteration-v2-0-0ae381f8b7b9@nxp.com>
 <20260603-fixes_fwnode_iteration-v2-2-0ae381f8b7b9@nxp.com>
 <ah_5NgZPc2U0_FPO@ashevche-desk.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ah_5NgZPc2U0_FPO@ashevche-desk.local>
X-ClientProxiedBy: FR4P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::9) To PAXPR04MB9422.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9422:EE_|DB9PR04MB9724:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ece4ef4-0846-4138-db26-08dec22951b6
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|376014|22082099003|18002099003|56012099006|3023799007|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
 UbYk7YhBVnrCQJxXbjhZ37RwFWA95CaJaTKcLNJsK8F364INXeuTZX42B77NJRG4fL0Q+MYlmSx1kehg0BM/Wte+27RV5KZFTbxNX3iJL5R0e2N/c9Qv+4O+sNwZ9+j/A8KCXuG2Ga7Iqg4MHE6HiNed5reanc5kt6KKtQS7kCKCzaiIeQ8uzEIDbhj9ELASPk3TaECkx3uY+f7fsU2akNc2P21iH1aRfnxvpcapyN/zIJXbW8fJA3nSuMR41H0E7VmvStgKcCg5X/ORvO9+B1F4KalOtFm1kY4flcKU7Wwqms83cu6QBvpeuRsjfEY9MVxBUp9gnK09juctDVzBqbkW1o4y66MeP6IUtxraVSsRwcpTkO1kC9I7Z+W8Okn2KtoRiZsF0OKH9ZC/0DAK+b17OhjSUFQinRZRMpPmtib7p1myKm0itgTqrKqs0ye73eAe3ckUwHGqrwUWz78SiarF4xiBTMgd+qTPQTt+taPslibhgrEyWRBGsWTnEKt03saS3Nfw7fTtD/unI/8PWwbnHc8UMLcMGOBi5lfSofwFgfr3ZaKb+VUm95lNPabRf/BLTIUapcoL6yuJyAK9DMqOXntCJyfvWRhP+99JPXiNbE3Wl2uKwKruj7KmyOASD4r311psfULNdC7NRVJeugsrtw9gwQsC4v0wcJqeiJYFZE+7JnGopyltbFeGovCv
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9422.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099006)(3023799007)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RFVKd0IwU3pVT3BQK0NEc1BIazVET1hXZThBV05VR0o5YWorV1F3WDR5cUIr?=
 =?utf-8?B?Rmk1MGJKbEJpK2t4U1dJMjN3cVk4dG9YRnNXdHRUNGVPbkZCVVJXYUN2YVg0?=
 =?utf-8?B?Q0JIWUpvY3pISWlJb01HZkVWdU1WSlNZWFRWNUp2RmtWZjNrRzZ3eUUxcFJh?=
 =?utf-8?B?b0pmVGFaQW1QMkd1bnNvMlRudmpSVDkyRFJNb0d6ckpPK0F1MFl5cTRwN0Z5?=
 =?utf-8?B?N0hJbHk2Qk1xeUZKL0p6YkpXN3pMcUN5S0o5T3ZlbXJ4MHhpQUJISkc3Q0di?=
 =?utf-8?B?RzRFczBvdERDemdseG10am8rMHdPTFFPVFlGTjh4diszQkFaY2EwdXg1V3Jy?=
 =?utf-8?B?eGNDOW4vVDhyVHpPZ1FzeCt5SHkySStWakNhWHRTWEltN3liaXFoSW93K0ZF?=
 =?utf-8?B?bzM5WFU2ZTRzUjlhTHB5aDlIMHl4WEdrd2lwVklTVy8rWnRNd1dvTEpVYitr?=
 =?utf-8?B?aVhnQURpZG9GSm5PSy8wNlZKTTBWSE1TMEk1VFdTOTkwT0I2QlpyMFVxVzQ1?=
 =?utf-8?B?d243dzEzZ3pubmhtZExrTEYxdHRKaS9STFB6NDdsYUhxcVRiN1hIaEs5ajVk?=
 =?utf-8?B?ekY2TUx3c3hyaEh0YU9sRDRQekNqY0xyU1RBOGhmWkFiWjg1dTJXTFptSk9m?=
 =?utf-8?B?Y3RTSjhxTzlpRHRIeUdaU25KZXRJa0w3SGxWbGJBM1NSU2FRcll5M0hLNzI5?=
 =?utf-8?B?cUIyQkdQWXZGMmtIMEh4b05JS2xha3F1OUZpOGxCZW1GNnlXZEsxSFlSN2Er?=
 =?utf-8?B?MndkbmtSWG5haVo1bzJSSk9KaTkyakxCaFpuNVpWVDBYSFlxcUtIQ1Q0Z1hU?=
 =?utf-8?B?YnFFYzlaOW80VDMrN2Zxd0RaQ0dnekdzWTczbmtGOEQ3R1JJM0NHQk55THVD?=
 =?utf-8?B?RGg5QThUTElMT2NzdjV3bVh4Sk1uazBRTWF3cHlzR3RtckZrU3AvK0dpbXpy?=
 =?utf-8?B?aTJId242M0dvUGR0dUF1UktQWUE5MFpocUsyaG5nL0pRVXRIQWdObkJhenRm?=
 =?utf-8?B?UWVXTmxJckZDZ0NCR1Y2M1diMlloMnF3K045Ly9FblRQT0xDblJzZjN4STVT?=
 =?utf-8?B?Z3BTOUIxM1ZSR1h5YXBQK3NsYnJ1VUNmREd2UXFBZm1oTkY0TTJYSWZJMUE0?=
 =?utf-8?B?b1dGeXBPOFdiU3lYY2loZW5GQkt6MFVEWUsydWx0dXZMU0E2MVdrTHFVclhy?=
 =?utf-8?B?NWpXZDY2RVNyeWdqTTc3SFFlc2VhbUlsdFdKUnd1ZjlkTVJIRjN2M0orQ2Nx?=
 =?utf-8?B?M0ZYS3ZHcm51OHdveGFDaHNqaFpMNGhpOGh2TWNrWjNqY2VZcy9Gc3FIU08x?=
 =?utf-8?B?Y2txTnhCN21QVnBDbHNHNWt5TGx4aXNvOTU3MVlMdFdZME9JbDZvbnYxMVRK?=
 =?utf-8?B?TlpRRFAxWlNCd04vWVVvMU9aaE5SSjZvejRORmFlU1dKU0ZiUVJTWldpaG1v?=
 =?utf-8?B?MjZXL1BwekdqYUNjTUtpU3ZaYm5hU3cvajVpL3c0ZGVWVXZ2am1qSEUyRjhp?=
 =?utf-8?B?Wk8zSkpVcFNEbWR2YlREYldrTXhjbGFSdUl2eDJsK0VXWFVSQ2czK2FHSnpJ?=
 =?utf-8?B?c0l0eGp5ckt3ODMvYVBmNEVYSWVHOTYyQVBHYjhJMzZXMjlRZDFwS2QyTXcr?=
 =?utf-8?B?OGoyYUdSQkx2bm5yYzdFS1RjRDBSbkU1cCswdmUxb3I4S29mbjc0eEp1V1dV?=
 =?utf-8?B?R3FCV2ZvOVpIbnJ6RHlxUzZuQnp2czlGWFI5ZzBRK1Q3MXcrOE5HOG1OZWI5?=
 =?utf-8?B?Tk5lQzNPZmFIRnowbEVQL1lsOXlJMGxINHdPNDdWNXgzQlI3Rlg3dEdpRkds?=
 =?utf-8?B?djBaRC94eDhHeHZKT3dFTTlyRkN3MjIxSUxwb1d3UTJpSlJnVklmSWJ5Y1ZY?=
 =?utf-8?B?L0EvQjJSTW5OSWpiZURWcXBGNFlkL2pGbkNjVldWQzZYaDdmRFhFZCtsZ3U5?=
 =?utf-8?B?djBSYzNydDNFdmF6V1ZnR1I3aEhJaDBSbWwvM3dCSDVlQitqQlJYQ3k4RUht?=
 =?utf-8?B?aWd0UGdUMWJUcStsVmhSaGNBYVQwY2hwaCtFenNxZnE2NHRBeFF2ektqOG8r?=
 =?utf-8?B?dFIwajBNcENqbG9kOEhlQzZvYjN2SkpaNFo2MDB6Y1NNL1dxZXBmRnNUT0dR?=
 =?utf-8?B?Tk8vblc4K0tveUxFUlFVWFpVSFlzNmhjYkhYSHBkZlo0alB4dlhDQ254U2JZ?=
 =?utf-8?B?VkRaaXNhYjVpTHN5R3k4Q0l6R0JPMWNDclI1dFVCNkQ2cWhyZzh2a0QwUTU0?=
 =?utf-8?B?aHlxbTdzM0NBeStlMnJPNnVPdUNNd2dRUWhtM2RSeDZQU2hLZElSdXN5VTNz?=
 =?utf-8?B?dGxRSlR5Rjd3anRUaEVITklPc3huUXA5QmVNMnl6Yytlc2hLazZrZHlOU0Z3?=
 =?utf-8?Q?CIhfbxEpnQpWD1bcyuQcLiobm27/F3VaFlLRS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ece4ef4-0846-4138-db26-08dec22951b6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9422.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 11:06:25.4964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n7HnBnV37XDciRCF8rBIS5BA4ALvZhpzAeW1Z8X35s3Wzdk5cAHFsynvnU7AX7DId4ak7TXWyctmkscpXd0JSQufBEf2VZui32qhqtIzFTe2FzC7/66zt81RlqVxTLgE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9724
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260458-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andriy.shevchenko@linux.intel.com,m:brgl@kernel.org,m:djrscally@gmail.com,m:heikki.krogerus@linux.intel.com,m:sakari.ailus@linux.intel.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:mchehab+huawei@kernel.org,m:laurent.pinchart@ideasonboard.com,m:linux-acpi@vger.kernel.org,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:xu.yang_2@nxp.com,m:stable@vger.kernel.org,m:mchehab@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xu.yang_2@oss.nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xu.yang_2@oss.nxp.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux.intel.com,linuxfoundation.org,ideasonboard.com,vger.kernel.org,lists.linux.dev,nxp.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable,huawei];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oss.nxp.com:from_mime,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E3D0663F591

On Wed, Jun 03, 2026 at 12:51:50PM +0300, Andy Shevchenko wrote:
> On Wed, Jun 03, 2026 at 04:44:32PM +0800, Xu Yang wrote:
> 
> > When iterate over children of a fwnode that has a secondary fwnode,
> > fwnode_get_next_child_node() can enter an infinite loop if the secondary
> > fwnode has more than one child.
> > 
> >                        Parent        Child
> >       (Primary fwnode)   FWa:   {FWa1, FWa2, FWa3}
> >     (Secondary fwnode)   FWb:   {FWb1, FWb2}
> > 
> > In this case:
> > 
> >  ┌─> fwnode_get_next_child_node(FWa, FWa1)
> >  │    - fwnode_call_ptr_op(FWa, get_next_child_node, FWa1) returns FWa2
> >  │
> >  │   ...
> >  │
> >  │   fwnode_get_next_child_node(FWa, FWa3)
> >  │    - fwnode_call_ptr_op(FWa, get_next_child_node, FWa3) returns NULL
> >  │    - fwnode_call_ptr_op(FWb, get_next_child_node, FWa3) returns FWb1
> >  │
> >  │   fwnode_get_next_child_node(FWa, FWb1)
> >  │    - fwnode_call_ptr_op(FWa, get_next_child_node, FWb1) returns FWa1
> >  └────┘
> > 
> > This cause fwnode_for_each_child_node() to loop indefinitely, reapeatedly
> > output {FWa1, FWa2, FWa3, FWb1, FWa1, ...}.
> > 
> > The root cause is that when the current child (FWb1) belongs to the
> > secondary fwnode, calling get_next_child_node() on the parimary fwnode
> > incorrectly returns the first child (FWa1) again instead of NULL.
> > 
> > Fix this by dynamically checking the parent fwnode of the current child
> > before calling get_next_child_node(). This approach follows the pattern
> > established in commit b5b41ab6b0c1 ("device property: Check
> > fwnode->secondary in fwnode_graph_get_next_endpoint()").
> 
> ...
> 
> TBH, this code becomes twisted and complicated. Can we add some test cases to
> show the problem? Also we need to add other possible combinations (somewhat
> about ~5-6) of the different types of fwnode in a relationship.

I agree that adding test cases would be helpful. But It's not straightforward to
get swnode refcount as swnode is an internal structure. Any suggestions on this?

Thanks,
Xu Yang

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

