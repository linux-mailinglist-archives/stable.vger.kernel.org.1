Return-Path: <stable+bounces-225379-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDoqB2NitGmhmwAAu9opvQ
	(envelope-from <stable+bounces-225379-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 20:15:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8181E2892AC
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 20:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D56313015B73
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 19:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B697316199;
	Fri, 13 Mar 2026 19:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ajGc8ptl"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012028.outbound.protection.outlook.com [52.101.66.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3269C1E1A3B;
	Fri, 13 Mar 2026 19:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773429343; cv=fail; b=nDLH08O1AsUbT8aHsBX+m5wriV97Xs5obJ4OUCfg1pwtGOYVivk1H66LPv/TnfFjEFIvYsw1ndf+87AfC68suwM23YbD8KvDM0bcxqDNGIZRQwOZzTt52FArrNt73ZTU4350amC2mot47hixiFLCegTs4G40WquqJlqQbgVLOmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773429343; c=relaxed/simple;
	bh=L4OeqVQpMBX26P//v/qYIu64ZRDaO0K/e1NHyEWVf6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gzwAjQV+90r5g7twATclgDUYcYtATL0N4RduNS9RlgZ3Me6wH7VJWzn3/FGzl3YnqPKXSHO44RfzNOls8+8jyZ992EIDYNrOMlhrKZ4hqLF+ekNhk+L58Pc5MqzG3GBLmTOh+cVjQZgWVKUoJjwZFCroXgeLhhIUAehJKSJjTaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ajGc8ptl; arc=fail smtp.client-ip=52.101.66.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QVdl2HKsGZm37mlnWvCZnMWfQc66TyzdwUdYmQFCo8iM4pvM4mwLNz+hApVBzogGAkuXT3XJ+w1QoHtP0cAPMIvkSWVvXmAV9sAKC03ulZeV4QyIBv3gDsM/Rdc6GjBzzGJa3Wuuk2At4uaez5tZQCn3uixqU1G2t+NuXK5sZyb/lxLHkuGAAYsVb+khZNoNA+zExMwq9hs07juSVigEVKO4/y4JaimT+tqxJdQYrJvsI2YZP0Vv/YqOEAYLyihEGx93+lS+MShT49aObGHtWK8xwefjVel1Vly9x2Ng0dp09Nw2EVqjrk6O19GQtlUxDn23623jrVLMDLIk3REVYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62oBump2hLSd5lCNp9Vecu034CeS+sWSsJ00+M24orw=;
 b=C2HuRHOVUQ8Ih0NSKZAg3olmH8wzOs1X79Y4hQv0BgjwEzbVLJKIgiC2jQF+7k8aqVJgX7xafUOFz51X29BBdGozUebylSMJENByJyamNVMiaA88++LAYD5NAr74QVV4O3s5uLC0Gg5zQLn6xxIGB1xTu6vjGEuj5zXnC90OTwQEoX2iLpmjVDkhiwbfnpXpH2aTTXGRNQby4uXUaeZr9EBvxnj7PRbzk7FKT27fmUYlqZNx9+2535M+Gh6LTJrCHCB830fJw1sDG8cvT+EKFDv/J8BtXLyyfXguwwjdQprUS4ykdJNrgB4y86Y06C99bM3ARJTKUFDQh1oOwJwrUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62oBump2hLSd5lCNp9Vecu034CeS+sWSsJ00+M24orw=;
 b=ajGc8ptlCJmF2DV0nnQdjEnpezmQlskYclQxVzVgoWvL/etNxQwI9cuCHzU3R/sIHx2k/q+EbgDaPnpHcziZBpml9xeeH1I0xyHIWl1jffb8lpK67NZ9Ik35bcFOMTiJ9zqtflahBD+HDUGefgYRA3PreX7RXVoITlniaGfdh6IJdKVwJio96mesyO2zY3hISqewiVlVpPPGqINo+swxvhXZ1HCR8fP1adf3yZPqo8aeYks/HiDbf1jSj6bEt3y9IlG3SzP75I9Nj+7tSBtmQZ+qkC22hkTyBPUCUeTsiTFCjTLpOtTk7Vvl60Dhba54jfuMb1fu2jRU3rDF4m/1mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DUZPR04MB9821.eurprd04.prod.outlook.com (2603:10a6:10:4b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.17; Fri, 13 Mar
 2026 19:15:37 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 19:15:35 +0000
Date: Fri, 13 Mar 2026 15:15:32 -0400
From: Frank Li <Frank.li@nxp.com>
To: Josua Mayer <josua@solid-run.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Carlos Song <carlos.song@nxp.com>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Rabeeh Khoury <rabeeh@solid-run.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 01/10] arm64: dts: lx2160a-cex7/lx2162a-sr-som: fix
 usd-cd & gpio pinmux
Message-ID: <abRiVBgaYg72avcX@lizhi-Precision-Tower-5810>
References: <20260313-lx2160-sd-cd-v4-0-aabcf230fbff@solid-run.com>
 <20260313-lx2160-sd-cd-v4-1-aabcf230fbff@solid-run.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313-lx2160-sd-cd-v4-1-aabcf230fbff@solid-run.com>
X-ClientProxiedBy: SA0PR11CA0128.namprd11.prod.outlook.com
 (2603:10b6:806:131::13) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DUZPR04MB9821:EE_
X-MS-Office365-Filtering-Correlation-Id: ddb978bb-9628-4299-7438-08de8134e773
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|52116014|376014|7416014|19092799006|1800799024|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 t0sX67aX6C80pUIpSuRPRNnXUbZCm7s3OrBBjLjgKXW9zgj1U4/lVnqezh5p1JOh3g+Z0OgCai4dJLZaIQgJQRHldKbTcC+WfaEh9CtoG3v/Ds4twIm9jjQOkQJOBLZ+dtB6HBnWkc4XVtGENeDJA9amRh7DlC5/rla+xEg3SEf62ISjbcRqMotoiS236Ia3KSHpYUBoQ9nUR1iYWMgU1WwP2XOfkHGmHV9H2cn+ifLh7XPGFiWkCO30rYCfA2pHqseJQaINbUZCuBSWEnGq9BZbGE/ca3hnn8nbmqwK6oFb3R+aDEM8K3xTa/agxJlzls00vdo7fNQdPnXbgJVb30XK6wQY0xoCsOvpJvDHYgC1YFj43nwOLcZ4VxWVKXp5Sss6doY3xLRhoJg7cDE3/JPO3orRJFYF24Cgr+yj2sEvNH+Jq68+7KsqcwA/9Wdp6av+VmFFl/a21lmd9zq752EijC0lJpzirl4dVBHDqxxPvtZ8GDFMEugSeY0dC7yVR7/cNIz2r/UapE6FgZMR7ZrPaUKn+PpRkmPq0yjer8GmBFP6PEPfIaWxcNGzWRi6i4inMIMFTd/nxlrYOP0tiKGzxqYSiT3g8r6aAks6zfsdG7lEBX5t7+SrH5UsGtCB7re3hTJCbJFpTDRk/kNqhPFQm+/2bAUZIk0eptZ0KA4r9aU+8SWaGHXlUNPKprLJnp45jD/0lIRiof84CSsV8aB3MDZ9hbLki+zl1o0WD24+3U9BZqumdgX+mNNkLK0SlBvCvLJjLbTBexPf4wZRLHGOvZckcU3OFgdqUHk9qGY=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(19092799006)(1800799024)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?qFDLr8mghAqRUDgZD2krzlqGTpK8h0U3Yu8Ejpy7Y+PzpAgmen6u1JUG8xHJ?=
 =?us-ascii?Q?DbIJ3zvjPMSBgBf7AI44Ce1ID3GSciqCj5pq9T7v1vva/1k67R3C/V5Xlf41?=
 =?us-ascii?Q?XXug6SX5+i1ywp2fw++hecMhX5NjaZPe5EB+ppdfWhEQslvbbOQ/CISy2Hrq?=
 =?us-ascii?Q?aTjs8harDJ/yj+3+p5ITZGDX8BD6JjbXjpCcYVRFtp7dm4jhos0oCsRZnvrr?=
 =?us-ascii?Q?n976AbNqHeC6RQnrCzkvliNSmCW97nDabdzEM/p6qD0MuYZTP4GcwM7JeBwZ?=
 =?us-ascii?Q?tK0Sdn00Cf6mYaHEaDIrFwgE6sB4eGTkjWT1uP+Ztyzd1Nc/Iy5/6Rx95QbI?=
 =?us-ascii?Q?xA+iF7cEoEVN8ItquVDom1uq/JKdEt6bTkK0Mza44b8C5KxlRqU+E5rm+G0t?=
 =?us-ascii?Q?vpFONDaGjDuPXNV11vRReQ0egEItR/k9wGfrpzJIZLl+vypKCAt6ABXsT6fX?=
 =?us-ascii?Q?1v+dKxkFWkY1i+WysOn18ZvZzxMIzovy7C9hrj4ofAxVGX3cClRH8w0+wEPN?=
 =?us-ascii?Q?6VWYui0V1fzhD/+X4jW9jlWgwooKb93+HbkPMG3BAY84QpINxLrwH5a8kYrE?=
 =?us-ascii?Q?M/Bg4/55OuPsirfMBWVdkdxx/Gyr46a6bkv5Nd7RX0FxLWX88034mjH/y0sC?=
 =?us-ascii?Q?hYOprBUMesH6VppQzAXv0CRT4/6MUMLoSxZh3gOix9zHcOpQbj0P8V4QTHzT?=
 =?us-ascii?Q?DP/ElEMCcm4IMUDCBdUCOkJVeJBJB2Ue9rGap95XeA3Pn7lO0bTglBT6b8GW?=
 =?us-ascii?Q?b2lbxES0fUGUt9GNqdWrORsbUrMCM0o8ELoh6FumwNCCPMS+pZ/n6DVg2ehV?=
 =?us-ascii?Q?6hQNAkS8CTrw3tDEPY8r8ZGU/gkhKsGgBjkPUaJpSC+CvYjjv8vb66ATc6/c?=
 =?us-ascii?Q?tLzrH4U+xcEkjwYcjiLZYzCoYgt6DxIRxFiPQ3kriFWH+aw/CTpE184FGiQ6?=
 =?us-ascii?Q?HQvgRukhRs4mdFRFB0JMxfRwaH05qT81dWx7efFfAOEVanuTBMK+uxGwsXsk?=
 =?us-ascii?Q?ndhDGlM0iFkS94eJOsFBHbovLSMs/UCpq/1AGFchlw65k8hPPsSfpQCCil7Q?=
 =?us-ascii?Q?/u0rbuY/0MQvw3BqgGgpBMWEh6R6gkkAJxfCQFyhOHaya5EfcNxgw8LHBKSf?=
 =?us-ascii?Q?NQT2+EYOeyzP98DO3PCNnGW92j7j4ccL/8HzaWKMKcKdFSfDWTKOlEBulBED?=
 =?us-ascii?Q?UravUDOdzrxEUFK+wXRhGAA/hu0ngd66ZvC39K8GoTAh7fw1HDKZVgLBhwOE?=
 =?us-ascii?Q?25TjOz5pXyFBgdXFTCoz3t9l1bZoIgHk22tDudsXSVKjpWZRQQubid0b+Vom?=
 =?us-ascii?Q?CNqH+I6gFmN5TvSMW8ClDYfz31EMkuohWOYLSSY8kAFGC+vIzM2gaX+BzlVn?=
 =?us-ascii?Q?TB8d3truLNwufzJPFmovTnVIypIiq05Y5/64kyI+HmFexdibNpUDAjYqdCHi?=
 =?us-ascii?Q?GW0kkZstlUvJz3Sb8hpwJC6SQIrp2aOmbRbLAPrrbboxPghpG31fF/iHxnKr?=
 =?us-ascii?Q?OAlN48Hld2reuGOJRjWFw8wcEI2pfOSm7HDJob56iJFE0xUTR1Kgaq0bb4I5?=
 =?us-ascii?Q?sS+2oELMvadEX4osaNACJZTfm+aJQ7zG9xJKOqkXF+W3bDlXJB0JPs/Jp/4o?=
 =?us-ascii?Q?+OKf/LeYvMwOj87SSS7ihgj9Jxgryy2Xs93e8yuaoeiZcE4JlEbG5Xe4HgiA?=
 =?us-ascii?Q?xQ3/NFKFNq1WlgXy5EQgUGlzrXbqaHLpcMQtYR+A6kKsveX6vCEUQB29qDQN?=
 =?us-ascii?Q?yrbrrFw99Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb978bb-9628-4299-7438-08de8134e773
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 19:15:35.6896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zG8I4/9EdCzInJVF+OmO871SiEDivDrV0uLKe4Ntja29bWAGsDOZLMM0SZI79Suh3JpAxqDp0dPVS7hYxo4fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9821
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225379-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	DBL_PROHIBIT(0.00)[0.0.0.15:email,0.0.0.51:email];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,nxp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8181E2892AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 03:20:42PM +0100, Josua Mayer wrote:
> Commit 8a1365c7bbc1 ("arm64: dts: lx2160a: add pinmux and i2c gpio to
> support bus recovery") introduced pinmux nodes for lx2160 i2c
> interfaces, allowing runtime change between i2c and gpio functions
> implementing bus recovery.
>
> This has caused unintended side-effects on SolidRun boards where the
> first application of a pinmux node cleared all bits in a 32-bit word,
> corrupting the configuration previously set by bootloader.
>
> The LX2160 SoC is configured at power-on from RCW (Reset
> Configuration Word) typically located in the first 4k of boot media.
> This blob configures various clock rates and pin functions.
> The pinmux for i2c specifically is part of configuration words RCWSR12,
> RCWSR13 and RCWSR14 size 32 bit each.
> These values are accessible at read-only addresses 0x01e0012c following.
>
> For runtime (re-)configuration the SoC has a dynamic configuration area
> where alternative settings can be applied. The counterparts of
> RCWSR[12-14] can be overridden at 0x70010012c following.
>
> The commit in question used this area to switch i2c pins between i2c and
> gpio function at runtime using the pinctrl-single driver - which reads a
> 32-bit value, makes particular changes by bitmask and writes back the
> new value.
>
> SolidRun have observed that if the dynamic configuration is read first
> (before a write), it reads as zero regardless the initial values set by
> RCW. After the first write consecutive reads reflect the written value.
>
> Because multiple pins are configured from a single 32-bit value, this
> causes unintentional change of all bits (except those for i2c) being set
> to zero when the pinctrl driver applies the first configuration.
>
> See below a short list of which functions RCWSR12 alone controls:
>
> LX2162-CF RCWSR12: 0b0000100000000000 0000000000000110
> IIC2_PMUX              |||   |||   || |   |||   |||XXX : I2C/GPIO/CD-WP
> IIC3_PMUX              |||   |||   || |   |||   XXX    : I2C/GPIO/CAN/EVT
> IIC4_PMUX              |||   |||   || |   |||XXX|||    : I2C/GPIO/CAN/EVT
> IIC5_PMUX              |||   |||   || |   XXX   |||    : I2C/GPIO/SDHC-CLK
> IIC6_PMUX              |||   |||   || |XXX|||   |||    : I2C/GPIO/SDHC-CLK
> XSPI1_A_DATA74_PMUX    |||   |||   XX X   |||   |||    : XSPI/GPIO
> XSPI1_A_DATA30_PMUX    |||   |||XXX|| |   |||   |||    : XSPI/GPIO
> XSPI1_A_BASE_PMUX      |||   XXX   || |   |||   |||    : XSPI/GPIO
> SDHC1_BASE_PMUX        |||XXX|||   || |   |||   |||    : SDHC/GPIO/SPI
> SDHC1_DIR_PMUX         XXX   |||   || |   |||   |||    : SDHC/GPIO/SPI
> RESERVED             XX|||   |||   || |   |||   |||    :

List two IIC2_PMUX and SDHC1_DIR_PMUX should be enough.

>
> On LX2162A Clearfog the initial (and intended) value is 0x08000006 -
> enabling card-detect on IIC2_PMUX and control GPIOs on SDHC1_DIR_PMUX.
> Everything else is intentional zero (enabling I2C & XSPI).
>
> By reading zero from dynamic configuration area, the commit in question
> changes IIC2_PMUX to value 0 (I2C function), and SDHC1_DIR_PMUX to 0
> (SDHC data direction function) - breaking card-detect and led gpios.
>
> This issue should affect any board based on LX2160 SoC that is using the
> same or earlier versions of NXP bootloader as SolidRun have tested, in
> particular: LSDK-21.08 and LS-5.15.71-2.2.0.
>
> Whether NXP added some extra initialisation in the bootloader on later
> releases was not investigated. However bootloader upgrade should not be
> necessary to run a newer Linux kernel.
>
> To work around this issue it is possible to explicitly define ALL pins
> controlled by any 32-bit value so that gradually after processing all
> pinctrl nodes the correct value is reached on all bits.
>
> This is a large task that should be done carefully on a per-board basis
> and not globally through the SoC dtsi.
> Therefore reverting the commit in question altogether was considered,
> but received pushback in review with the argument that bus recovery was
> important.
>
> Instead add pinmux nodes for all fields of rcwsr12 as used by affected
> SolidRun LX2160A Clearfog-CX & Honeycomb, and LX2162A Clearfog boards.

Thanks you very much. This way is the good. But commit message to too long

Basically the default value of overwrite MUX is 0, which have not reflact
hardware real status, which set by RCW. so update some field of mux impact
other peripherial.

Frank

>
> Fixes: 8a1365c7bbc1 ("arm64: dts: lx2160a: add pinmux and i2c gpio to support bus recovery")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
>  .../arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi |  7 +++++++
>  .../dts/freescale/fsl-lx2160a-clearfog-itx.dtsi    |  2 ++
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     | 24 ++++++++++++++++++++++
>  .../boot/dts/freescale/fsl-lx2162a-clearfog.dts    |  2 ++
>  .../boot/dts/freescale/fsl-lx2162a-sr-som.dtsi     |  7 +++++++
>  5 files changed, 42 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi
> index eec2cd6c6d32a..7f6e39e27ce5c 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi
> @@ -162,6 +162,8 @@ rtc@51 {
>  };
>
>  &fspi {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&fspi_data74_pins>, <&fspi_data30_pins>, <&fspi_dqs_sck_cs10_pins>;
>  	status = "okay";
>
>  	flash@0 {
> @@ -177,6 +179,11 @@ flash@0 {
>  	};
>  };
>
> +&pinmux_i2crv {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gpio0_14_12_pins>;
> +};
> +
>  &usb0 {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-itx.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-itx.dtsi
> index af6258b2fe826..580ee9b3026e3 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-itx.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-itx.dtsi
> @@ -89,6 +89,8 @@ &emdio2 {
>  };
>
>  &esdhc0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&esdhc0_cd_wp_pins>, <&esdhc0_cmd_data30_clk_vsel_pins>;
>  	sd-uhs-sdr104;
>  	sd-uhs-sdr50;
>  	sd-uhs-sdr25;
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index 853b01452813a..af74e77efabc5 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -1721,6 +1721,10 @@ i2c1_scl_gpio: i2c1-scl-gpio-pins {
>  				pinctrl-single,bits = <0x0 0x1 0x7>;
>  			};
>
> +			esdhc0_cd_wp_pins: iic2-sdhc-pins {
> +				pinctrl-single,bits = <0x0 0x6 0x7>;
> +			};
> +
>  			i2c2_scl: i2c2-scl-pins {
>  				pinctrl-single,bits = <0x0 0 (0x7 << 3)>;
>  			};
> @@ -1753,6 +1757,26 @@ i2c5_scl_gpio: i2c5-scl-gpio-pins {
>  				pinctrl-single,bits = <0x0 (0x1 << 12) (0x7 << 12)>;
>  			};
>
> +			fspi_data74_pins: xspi1-data74-pins {
> +				pinctrl-single,bits = <0x0 0x0 (0x7 << 15)>;
> +			};
> +
> +			fspi_data30_pins: xspi1-data30-pins {
> +				pinctrl-single,bits = <0x0 0x0 (0x7 << 18)>;
> +			};
> +
> +			fspi_dqs_sck_cs10_pins: xspi1-base-pins {
> +				pinctrl-single,bits = <0x0 0x0 (0x7 << 21)>;
> +			};
> +
> +			esdhc0_cmd_data30_clk_vsel_pins: sdhc1-base-sdhc-vsel-pins {
> +				pinctrl-single,bits = <0x0 0x0 (0x7 << 24)>;
> +			};
> +
> +			gpio0_14_12_pins: sdhc1-dir-gpio-pins {
> +				pinctrl-single,bits = <0x0 (0x1 << 27) (0x7 << 27)>;
> +			};
> +
>  			i2c6_scl: i2c6-scl-pins {
>  				pinctrl-single,bits = <0x4 0x2 0x7>;
>  			};
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts b/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
> index eafef8718a0fe..8920326a06735 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
> @@ -223,6 +223,8 @@ ethernet_phy8: ethernet-phy@15 {
>  };
>
>  &esdhc0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&esdhc0_cd_wp_pins>, <&esdhc0_cmd_data30_clk_vsel_pins>;
>  	sd-uhs-sdr104;
>  	sd-uhs-sdr50;
>  	sd-uhs-sdr25;
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi
> index e914291e63a1a..e1344942eaaee 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi
> @@ -30,6 +30,8 @@ &esdhc1 {
>  };
>
>  &fspi {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&fspi_data74_pins>, <&fspi_data30_pins>, <&fspi_dqs_sck_cs10_pins>;
>  	status = "okay";
>
>  	flash@0 {
> @@ -80,3 +82,8 @@ rtc@6f {
>  		reg = <0x6f>;
>  	};
>  };
> +
> +&pinmux_i2crv {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gpio0_14_12_pins>;
> +};
>
> --
> 2.51.0
>

