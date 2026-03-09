Return-Path: <stable+bounces-223730-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMzsOFBBr2mYSwIAu9opvQ
	(envelope-from <stable+bounces-223730-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 22:53:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F27241EB1
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 22:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FD49303075C
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 21:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7C336C0DD;
	Mon,  9 Mar 2026 21:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="gVSPzatj"
X-Original-To: stable@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19013083.outbound.protection.outlook.com [52.103.14.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E6636B07F;
	Mon,  9 Mar 2026 21:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773093194; cv=fail; b=N0sDV+UrlfuaI5fpge70XYuTitiSOwc4oQM+hA/lJ82Su105P+aXi4A/YKRCTEKeQ7WDPsAnzHIS1Um/ojJtivWWAHNLIqrp1f+6in5VRzenX4lkceH/fkKAyrc0XGapcPRJOIeX6r30wkygDcyB4Bv19pVF4gHM64Yq+loUoeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773093194; c=relaxed/simple;
	bh=alNpIT67Of6OPt66wwWX/HA30aIfDdZDM6f2pvSg1cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uFlxlFxxM3Nwsw9MaoXa1NVTgRqxXXYO6jjj2ktzDHTAb2euqRkQPPsJMPs0hnKNcFUJANBl9KPZsPX85Pb6HW8szQGd27Sg8UNfqj50TBB6C1tDIp3IEeECFRrKLWHGl4/vw0moctIzA4TI2kFW58VSgCYVfkjuoAAQTIQHEXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=gVSPzatj; arc=fail smtp.client-ip=52.103.14.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVgXJ30XzW2AfIzww8b0QcaWcTrhboAUNLyIRUIGwycjiRb78YlQAJdLxr5tsEKAwl1GDk0e4L0oMBKjsdRyBOqfcruLuzVPKozQOCOZcCs+ipTKFNwIPLYFYQKb5G+YmXWgLvD2MWy4lGGxWfudydyFWDD7AguYBpxnAM7mGD57Qi1QGjk3O4YwhCC2V1/MPvd0LXyfMg/ehj/OY1407VcYuuYiu6PfMch7stXnHF7KWbGaJBE4ZSyhhEw6cYmWraExUir6XhKx6iuEzoh1E8ou5IsE5QSpGahKIYAxsYgqhqzJ8kg3NNNpfxM0Bo9QC3OUTBPc3dt2RldLMP/HYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIaVZ3BSa7DfxsW99gp5aU1+rEd1wh+h6L0JZIaqESY=;
 b=gi9gHRL72qXuWe1h/8sT9HXa+7P6WrRReY5mi/ndNvRN6pXsa1GySMQ9EknSIwrl2ft4J/Rwz8jO3AMCqDSdk+6Fj9OUmYU4wJKXIJ0Oy73kr3s2Muf563en4ly3Ik0erznz/ynZP/a5pQOX5dHKuazn+1JkXrq7cwVnG1+h/vWoWje1p2CNYaDadL74uH91hSX8ntDi4X9iALoNEYBk/MG4e31XktMe1XwwaZslwsW7+8Jzo2678zgAksflKj4XylRoHJFgDaljIiIjkifda39uk0r8MOeVHF0FMCUtuBmnBQ7VFKjCRWusg0cM8wGkQvpiM2CWbCcMLMH6cQiy5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIaVZ3BSa7DfxsW99gp5aU1+rEd1wh+h6L0JZIaqESY=;
 b=gVSPzatj+JwOHew/hsV7cu7f9Eex8+k6xGSVt2vPJDf0XRLm0INt3THVvrrYs22feQVuKkH42cPFfoDMwFb6hJYf0KFXZa6ry9q9s3Bzp/otw+oejxSZ/R/4UENLhQf5Q/NevXQVfbmNYFLMJCjqxjLECyFAlhXEIkpWXhM8Yo/Vmste0YkENjtOjF+v98VJSlkshBcPS7sjvqeJ6uV1iRLw7co3Iu1m02Bq8xF8albj3DrjIRZT9EH99uKv5fVGotR8vLRC8Lm0vmndLWhU1m5Tt2vjsfi5vjl7LGca/LM5koDhRHf1OyJ3aPDmlaZLOqTuffLA9w4tZGh+ku6iRA==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by SA0PR19MB4302.namprd19.prod.outlook.com
 (2603:10b6:806:8e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.24; Mon, 9 Mar
 2026 21:53:10 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%7]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 21:53:10 +0000
Date: Mon, 9 Mar 2026 16:53:08 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-pm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 00/11] Add support for the TI BQ25792 battery charger
Message-ID:
 <PH0PR19MB99733879529AC585B813F76106A579A@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260306-bq25792-v2-0-6595249d6e6f@flipper.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306-bq25792-v2-0-6595249d6e6f@flipper.net>
X-ClientProxiedBy: SA0PR11CA0074.namprd11.prod.outlook.com
 (2603:10b6:806:d2::19) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <aa9BROw7XkuoCMDr@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|SA0PR19MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: 444a1915-69d1-4474-a647-08de7e264179
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|15080799012|23021999003|461199028|5072599009|8060799015|37011999003|25031999004|6090799003|10035399007|4302099013|3412199025|440099028|1602099012|53005399003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EvAY66urUnnGHXTHoAcHVsq2OTkIumWUxrsRz+oeRcnEmn9iEoh/vrCWW2rl?=
 =?us-ascii?Q?yZLRk6qkcIFtU4bKkw0TGypaFg9rmBSwq98zSBDqdXc1SWsH/epox+9ICNsH?=
 =?us-ascii?Q?tBoJhfrg3dKu0GPXchCosNQC3m8l3G767j8UlWR8tupfnKA6ht3Wall2pPXM?=
 =?us-ascii?Q?xtNql8HVpPYULrFy2CzLUQTQ3wTEijWu8VLr7E3DymL9/OwmzYavbn/SPjXA?=
 =?us-ascii?Q?SlUR7Y/1VRFIJVNcIvZi/YZuQOrcRDt/bO+rsDN38guIEnuYa0rqSSKSVW0a?=
 =?us-ascii?Q?FezCsIIR9XCd+n3HzkExmH6/ZMc5JXoZKwdaG26Rw0xwRrwme97GNaAsu7ge?=
 =?us-ascii?Q?butb3OU4Gh8n0E++E83/3iVMhTKLxUWlipnWvS8UYoDrw5WpFu/wbtJ/But1?=
 =?us-ascii?Q?8DDOfYaur7lIyqHmj6C049kTO3guy9hbM45tr61aQB/fNz3KdvpRjbvjXNJ0?=
 =?us-ascii?Q?cyeQGN9u+hkYuJnYBxtLW0Zc7oEYTiFhR2DunjFagxXCHbXmF3Gk4FZ96S/l?=
 =?us-ascii?Q?TUnOeu+usqVCjmfVXb3OW5dCOHeXmfcJCA0raQW6WlMOKOIXK7peclWdn/T1?=
 =?us-ascii?Q?E1hc++7Fgbq+X72d7FPlbZ79HE+5kp3iSBrX8ewLxpzO8N88BXdZ+OBvWix9?=
 =?us-ascii?Q?UvtBgP//8ipa+3vmOdeR75LR94Zoc6S+i+XhHJKanIvMv0fGgheqm2Eil30u?=
 =?us-ascii?Q?MTo/jv7b7OVw3UTNbGkm/h7+w3WK0FpmMX85bOvJWFSfLpM70DGYqsY6jCVm?=
 =?us-ascii?Q?VaRYNHAgx2LRmUUzwQc0fDS4GC4zzxrUXRVId0QUX816tWYYEKUmNKWktSQg?=
 =?us-ascii?Q?QSXqDLPEOZxgKVINunsWW+FLKrG3Lmh5Vi2LjohsRI+PZUDddL8IeYl0ogkN?=
 =?us-ascii?Q?AZq1d4qoDdWgk+OV4oLicsM8iha04cWCN0tgpiA5anCz9A0oQKdNFJl+X7uB?=
 =?us-ascii?Q?8uDoYHia+wGfna8MUiUeQODkBoiGh7LFpscNMbhPQ1ZHbaQKWKvqW+VszBH4?=
 =?us-ascii?Q?jTgkabK8ebNt19yID5dflPaeIQb82T6kkXKgf5JITVYRf+A0ADPOsptvdkz7?=
 =?us-ascii?Q?64wlQ0+2Hg1h5rgfrGQTZgSjX2+KMajIr7kae2LziqL65y1lei5dWaf2bkb2?=
 =?us-ascii?Q?9RSdyJWPTgjh?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?osF0I7T/kHdJZnG4j2EK0dV1TZ9q0eKYbgRBtVcP0IqSZQHh71iDCdRT3thD?=
 =?us-ascii?Q?+6mbceEfK0/Mf2wKptwA6naHDp6Ds/4rNMWT9Eljl8KfR+ulkJQp4vPNp3bI?=
 =?us-ascii?Q?xS6yQR6T9r6/Gz4hX3IKlZHU4rocRu6HE2PDOi1fDZnmCE1BPMbCwlIt5ikC?=
 =?us-ascii?Q?6BkvrzSKpq6HyM5t/AMcf3gEpTT0foiMSnhZEBbleRlo9UXqZpkA38DvShnJ?=
 =?us-ascii?Q?hHhcXdbwOirZ84U7pBO6C7CKHd8GFUAJVICnVYuvUMlkdD4NPf8Mnxk8g8j5?=
 =?us-ascii?Q?KApR5S8rLG/RNcsFlsV71a+BETZFVul+S6+qNgn4ogUze+MKWUlmAztclfbp?=
 =?us-ascii?Q?+tbRMerYDRvKuEiosclgF5NEzl0sB4w9QJ6VKKgwnWFyPXr3qPx7YSh+ZYkb?=
 =?us-ascii?Q?Na988Q4ddBMisQYKVvPzshua5dA89PG7j/DGjxXgFbQzrdF7r/Z6FGZqRyDL?=
 =?us-ascii?Q?aMCeyL80GFaSm48VWzq7+K3jP2N091HndVMc1DH0P2epIHAxuGGD7tvkPxJS?=
 =?us-ascii?Q?rskX6WcaF7GjmvGl/iIX4wYNRzfenQLYyxn0ToJFMhguIzxcuj7Gi+wNeDu9?=
 =?us-ascii?Q?sSW8lw2dII8qv2BnMOj//MzPlu1qqSFstv3TN21ICd82YMK8LPqrs9STw5DD?=
 =?us-ascii?Q?A9XF6PiDBiwHy1djRC+4mXgzaNcpdWUSoFWf3JSKMj7JTSKN8LjzRjROIRYR?=
 =?us-ascii?Q?UdgjCsf/pIAjaziHNFbrjmgHZjZ1YQ2duf4p02hoDb/CMA8sEjZ7/0tFNrKo?=
 =?us-ascii?Q?fOIXtiMYeIJJtsmK9jkbidqHO09ZgjSpeYzf56Q/kI58m55sCNVZtGohuFC5?=
 =?us-ascii?Q?wqq8hrCaMO5XhjJVSrD+Flo76byQXpqHheth4/MMHHlre0qZBYqFAFAENKMI?=
 =?us-ascii?Q?Gm5H6OrdEymSrFfngVHrRBumz4VUhB0OaS5qoIUYUBEIVKJC+i7Qcz/sPltv?=
 =?us-ascii?Q?IxNG5l2hdf/n7JLfoDNI+QBdwzeQSystCMBEudyidW1htrcXZLhPPJN5j+t1?=
 =?us-ascii?Q?uAoz5oVtK/CjtEQwfOdKRp9lnD02TZ5Rbo2Wx5Er792t0kUG07UQMfltGtT4?=
 =?us-ascii?Q?qcYWdab1da8HxkzFOKBdolbXrc0US9RMFLZINpCPOgpPramzSDFqKNQt2551?=
 =?us-ascii?Q?Mn88Zwq31Wket/YFqsozZex2fvR75Ai48FJpoj/6Ws9J9FVKy1BWfTAD2BZD?=
 =?us-ascii?Q?Y+Xvh0ksIc7IRzz0mG8pmKAS2Va0NqA7E8GYtjfWsTgShMUDhhJv0N4awvcY?=
 =?us-ascii?Q?PfpaBzDxL5YAMMJY0WfOz552fm+iuj1ftQUuEQV7XORWHdfVjS/yRbDkU5vH?=
 =?us-ascii?Q?yFbZ8z/yaOfAywiWIfnOIvHvqJ8DsK+xveW1d86ExJ6V66R46KHsnCjmavUB?=
 =?us-ascii?Q?N7F3EC87bOdIguccTEE71ousBMHR+hLjgVINZaypsmLLXR0LNA=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 444a1915-69d1-4474-a647-08de7e264179
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 21:53:10.9421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4302
X-Rspamd-Queue-Id: A4F27241EB1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hotmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[hotmail.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-223730-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[hotmail.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,collabora.com];
	DKIM_TRACE(0.00)[hotmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[macromorgan@hotmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,flipper.net:email]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 06:33:00PM +0400, Alexey Charkov wrote:
> This adds support for the TI BQ25792 battery charger, which is similar in
> overall logic to the BQ25703A, but has a different register layout and
> slightly different lower-level programming logic.
> 
> The series is organized as follows:
> - Patch 1 adds the new variant to the existing DT binding, including the
>   changes in electrical characteristics
> - Patches 2-4 are minor cleanups to the existing BQ25703A OTG regulator
>   driver, slimming down the code and making it more reusable for the new
>   BQ25792 variant
> - Patch 5 is a logical fix to the BQ25703A clamping logic for VSYSMIN
>   (this is a standalone fix which can be applied independently and may be
>   backported to stable)
> - Patches 6-8 are slight refactoring of the existing BQ25703A charger
>   driver to make it more reusable for the new BQ25792 variant
> - Patch 9 adds platform data to distinguish between the two variants in
>   the parent MFD driver, and binds it to the new compatible string
> - Patches 10-11 add variant-specific code to support the new BQ25792
>   variant in the regulator part and the charger part respectively,
>   selected by the platform data added in patch 9
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
> Changes in v2:
> - Fix an error in DT schema (thanks Rob's bot)
> - Ensure the broadest constraints for all variants remain in the common
>   part of the schema, per writing-schema doc (thanks Krzysztof)
> - Link to v1: https://lore.kernel.org/r/20260303-bq25792-v1-0-e6e5e0033458@flipper.net
> 
> ---
> Alexey Charkov (11):
>       dt-bindings: mfd: ti,bq25703a: Expand to include BQ25792
>       regulator: bq257xx: Remove reference to the parent MFD's dev
>       regulator: bq257xx: Drop the regulator_dev from the driver data
>       regulator: bq257xx: Make OTG enable GPIO really optional
>       power: supply: bq257xx: Fix VSYSMIN clamping logic
>       power: supply: bq257xx: Make the default current limit a per-chip attribute
>       power: supply: bq257xx: Consistently use indirect get/set helpers
>       power: supply: bq257xx: Add fields for 'charging' and 'overvoltage' states
>       mfd: bq257xx: Add BQ25792 support
>       regulator: bq257xx: Add support for BQ25792
>       power: supply: bq257xx: Add support for BQ25792
> 
>  .../devicetree/bindings/mfd/ti,bq25703a.yaml       |  73 ++-
>  drivers/mfd/bq257xx.c                              |  60 ++-
>  drivers/power/supply/bq257xx_charger.c             | 534 ++++++++++++++++++++-
>  drivers/regulator/bq257xx-regulator.c              | 123 ++++-
>  include/linux/mfd/bq257xx.h                        | 415 ++++++++++++++++
>  5 files changed, 1164 insertions(+), 41 deletions(-)
> ---
> base-commit: d517cb8cea012f43b069617fc8179b45404f8018
> change-id: 20260303-bq25792-0132ac86846d
> 
> Best regards,
> -- 
> Alexey Charkov <alchark@flipper.net>
> 

I did some regression testing with my existing BQ25703 device
(a Gameforce Ace) and did not see any regressions in my testing.

Tested-by: Chris Morgan <macromorgan@hotmail.com>

