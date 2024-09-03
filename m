Return-Path: <stable+bounces-72758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E8A969153
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 04:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A612F1C2258B
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 02:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123C01CCEF6;
	Tue,  3 Sep 2024 02:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OgBbetQn"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013035.outbound.protection.outlook.com [52.101.67.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0068E19C567;
	Tue,  3 Sep 2024 02:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725329570; cv=fail; b=NmjUWVcybZFcc39qkvkgQvWPdmwP9TfC1S8KBW6Pg1oBzHtMEFtX3LcGEh3M2TuUfLC/DmNCvJLki8A/r9GFG+fzce1Cr94594f9i7ZrmNMctkUE+LZ5h16KSALxvzSqWy3vus2woYk1YDIjivK2b+RLZA0TpHF1U4oVX+xxCKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725329570; c=relaxed/simple;
	bh=Ykpf4bz+afTxkfu3nF082KDKacTXf2zOO0rZ7FHSWvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D8kaMxXb9OBKUzoujIyairUhATDBhEoz0AHxDqKaBytrglBWvZ5WxHZH7pZwOxPc0xx/6YIHS66JXTd9/LnDimfGqYYz9f8NejoPc17avWfwe2DUsF+77iwOA/jZhOaWuFCFuovFnw8b/I1sY3/WOgON4ZZdhVCTRvMJVOBq1so=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OgBbetQn; arc=fail smtp.client-ip=52.101.67.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WnEYcpWvcxECzh8DlDHWAilB4e0mxeRH0o0RH+49dHzuoa9auAoAM4msIBHMka89AQFNWuGT6rF/TimLrPQpCDxvak8jre/Ru7dKtTQF/AkrPHLnozl0QaWTTl3AuOMQICg5F90GUH0sYhsRtwol6FQ1z7rMjuoXeCrDdkKZ/JnVquYpPIHZul6vN1BWa2lad+rP2wIhiXLnfYpDdeFSkeBew/eajhduZ8rYVUfyh3UCrl9wiFMqDtedp2dD4yYUhW3z1ikmps+xSEjL/GlQ6LpVZulffCgI8AGiS0isWMzee60ApNTGyo7X+igRoTpWziA9fr0IBFPJIbbxnE+qJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4SYA+4CcApJqyK30Ammv2sfQGVw4mwW7Y7VVSrEgx4=;
 b=H5IFH3C6mysHt504Z3FQhxBZTsmf0TS9R1mKvoZVhDACE9TWQfi1hR8mYxY7qj7qDHO0KwHoFuHWMdoJ2XO+TmAQC107cZtKAP3id4AJgJQIMVFt91FyDDuTlVKvk0yXEa97VAGrCXsP7BmXpqzVQTRlpuitQoIc4vf2xZ968RCrZ8Uu8p3Aj4+7UXIOyT6kr/BNTioqHFEhHOk3fcaYZQGTWEWfn7F3GDaHEAHbS8/gj3zyNQY3WTKjShzcQle+yshjmV/4j948F817rpKZibHuIbHmgwP3dDTDyapDb9DiM3byS2twJsBCXk85TtkMsPiegdme5tRKfGY5wpHx0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4SYA+4CcApJqyK30Ammv2sfQGVw4mwW7Y7VVSrEgx4=;
 b=OgBbetQnIOG2tCLML2EDiqEvDCNXQqzluyr6tycm8ojX7m30lcgXtmw8jBf+Dv//5Q4urqEWjCKRpAuhmQF3RsRfriBLkSODtc+D45wJrHko+9sZNHgGegsnTRl1HwjfNDzaD+FXIwFx5YfV6KmvE/hePtVVtnqsxQk0OWMpREubPRdnuFKgH47dPnwsTxlu65EUtz/kVrw8QsGCplQi38+JZYF042OMoJiEKDwj7HkBGfewb6SbV+BcvKvD9jVwsImndrytBZFgHchtIqM3WlqLkIOSa6PzWux37regVqZVhv34O2nhJRsyqY8jfISpu/gaGzF9SRdD0XydsMF/cQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by VI0PR04MB10231.eurprd04.prod.outlook.com (2603:10a6:800:23f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Tue, 3 Sep
 2024 02:12:46 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 02:12:45 +0000
Date: Tue, 3 Sep 2024 10:11:35 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, peter.chen@kernel.org, sashal@kernel.org,
	stable@vger.kernel.org, hui.pu@gehealthcare.com
Subject: Re: [GIT PULL] USB chipidea patches for linux-5.15.y and linux-6.1.y
Message-ID: <20240903021135.5lzfybyv7rzty33d@hippo>
References: <20240902092711.jwuf4kxbbmqsn7xk@hippo>
 <2024090235-baggage-iciness-b469@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024090235-baggage-iciness-b469@gregkh>
X-ClientProxiedBy: SG2PR01CA0185.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::19) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|VI0PR04MB10231:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ca792d6-09e4-4107-5b12-08dccbbde662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5jk64xF5Dne8yeZE6O2B5N4Wmm73Kcnj5gRbr59Nzjr7c/mzkcQKjYAX5geD?=
 =?us-ascii?Q?1KGVzgDZVNiL4IQ1IK2qY8Uq8hPaSHsdzuaRg09oFk/WKV/jk+wMu416eKUY?=
 =?us-ascii?Q?MHhOuOUXYIfwfhDOWnAu8Che6/zf9sV10kIrOmj8bjipWo/HmDZM+/7oTwCi?=
 =?us-ascii?Q?cPgCjNdbGrCFLt0GjOm27fBscd4Z5mQY+KNwUiGQpt1dTNGGFNJLXXwszNED?=
 =?us-ascii?Q?HL5NDcbxEo0IyH1+YupDN1EpqAZnoIyZqUP5qIXkFLnd5aooKubILawDBDbC?=
 =?us-ascii?Q?jztz4KuvH0wZFh7BrMNLJvaCQ0vYPWVdug9VtAfxpDQ96FOtAo/IpcyTz0iX?=
 =?us-ascii?Q?wrqSrf106+C3TnT2x3jYIxEKtgrf4cgQ67B9UgS9lZdU2UDASYp5q4RnheU6?=
 =?us-ascii?Q?PdEMxm1G+zO0cRRaCfYvS4v1T3JgqF4FhtplNYn+oIfqQnOUy040yDddVk2H?=
 =?us-ascii?Q?/mLvc4mjYIvrTSpGDJ141sFkWoZvx5Lyus5jXt9ZGMGZvEMERmrsb2U9DNH8?=
 =?us-ascii?Q?7RBPox44rveEHJkZFX/oV/FtfJgaH7zSXft/tn19Fs/chOjDQhp/LtUC+St+?=
 =?us-ascii?Q?5kk0eicZhvCM60jbIIQdv9RRKyYe3sciS806op5MqpQLpQSARf7ridzusXib?=
 =?us-ascii?Q?9LAS939ke1v87fc/+JaJEgLLRGvLQglDdAViUhPvnoL6fVevE9ArWE5Im6cx?=
 =?us-ascii?Q?TaMuBVuCQluT9251Jt+r74uqwWT5qQRUiFqdKlFMsvG7a7vpdmDnKVd+pZH/?=
 =?us-ascii?Q?JW710cTbprAZJgdjPwj4xTL/+hct7JtAQTv+krpczaWZBpXHHJa7XSdp30Zm?=
 =?us-ascii?Q?l1pRToaq8vcWwAYDJTKvl0zpCrt7GS5Rq2iiC7158yvOTqRek391b3TV6yhA?=
 =?us-ascii?Q?PvM7w86g4zjXXpCZ8gxcsb/OdLJUT/TSf3rf16wZV3rCXtsnLf+45K4dCjmb?=
 =?us-ascii?Q?H0kOfgVYEIDXNxuPpKZepz6SWPQ0tTAd8RXS0mJThucb4Joc6qmMD/6GtTy5?=
 =?us-ascii?Q?ciFTU0STk+svrYYuIwNgUGdygINDzJwAYO4uo1D3WkywfDwLL6IcQxkwQyvb?=
 =?us-ascii?Q?aYfWFUeLl5yYpNwu8qsyr9DCaL4HPEAgHuN55FxjF9ncrUQYQoeo1j4pPGl+?=
 =?us-ascii?Q?L5Avr9fnstvqW6Kum0x6QsDVKJHFVlz7zTaoPc0VXWufjOca5gSAd5yT33ua?=
 =?us-ascii?Q?uNeACbLq407CZE09M3qO0GGat9y9Qd33uRu8mbF9hwJ7KExsozff7HEXWJqQ?=
 =?us-ascii?Q?9S7prxcvAErAoHi+zQ/YUYnGiMA/C+jrDvn11kGJf/YwetBtcTzPRtTOUobT?=
 =?us-ascii?Q?y/VfmB1xtwPdjNuJSNPW2sg2We2Em1YgGwHWFcz0gXVfu+J4IcxDvtp621h8?=
 =?us-ascii?Q?/SpqtgmTW6S56CRih214aNRcTsbDVNGr4P9Ddi0KhgVi8gQ/Nw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OcARNuQbf56CiAnnf6x6IwqTfNJbKiO4YRfgLHwPbA0+cD6juTzpA6Rz0qlg?=
 =?us-ascii?Q?v+Ar3TwNS0RO1Y6UXaqe4NTfpNWU+LjdIVZi33HnCx4b4CUbOsHFt38JvLDy?=
 =?us-ascii?Q?TejAfHpxnAZuKsVPHl6seDELTf0Vd3ANBMkFntBfneW4Olnc6ggLsYrUIVK8?=
 =?us-ascii?Q?xCRruXTbsVqJdRzhxMczCkZ7uW+umreDZU7mzfsBjcUtMV51+62kYeRfupLE?=
 =?us-ascii?Q?FHa8ARYRUynwZ017ssOdGf78ThYhvPoVzDNlSVEMWMxHoHf9oTtCCp+0LI6/?=
 =?us-ascii?Q?GK55siVMMTUx+nqsYIJobIKodoG8R+1y036/I3zCcpYNwRnIo7m+dgQ9/4kw?=
 =?us-ascii?Q?1efClBf4Yb40qj30F0T2G1l4WfvHrdH/YM+7RBA63WhePTiplSe1v2Eu8mB6?=
 =?us-ascii?Q?IW3uCYxjImQ26DT6TYyaeqRJ9XFLyYcrdmxZBI/4swl2ZIeEKjsK6SLWnA6k?=
 =?us-ascii?Q?GwGpP43TkgUcrCTsRAVwjS/soU2NDS3hdq6+6WOyy2HmMkAUr7hR3OFZrEnh?=
 =?us-ascii?Q?8eqkZc/ePvjGRU+eHk7Bi+n+V8GA3BH7TUJM+lRCTAKmKUFsnTTLarnpKTT5?=
 =?us-ascii?Q?hlkxuMoq+AAmQ7XlGMZbnNFPb9gQWzfALXc32zL9t8ZCFz9s9kmlNmEBxlA2?=
 =?us-ascii?Q?DPmOIfoqHECk6Jm5Mndp04r0acuF/prKNgVK5NIwA5I9nOAptQ9XFKrBdVhe?=
 =?us-ascii?Q?V9JmArCo7Nr9UBcMTs9TtUQzUcRrI76xaVAi1VfaNRWEIwSiBo8u+zGS0JWt?=
 =?us-ascii?Q?6rPOtJoJm4Ilxdr6g8MQlektRaOJ4pBr6V69gYYjT9pJHqmR9jd61wiofmVB?=
 =?us-ascii?Q?ZwuQ6ef87d3DOdCTkYqdnPNdFeYvQsQGOVdcOoYVTHlTEW4ww3ZSwDZARni2?=
 =?us-ascii?Q?3c0KOa24UPtCl2tjZoAQ/3fJY8+0pOCG1KM8zWLHmTzimY6JpEAaGUj4/KTe?=
 =?us-ascii?Q?5Gwb79qVrmC1uPBq5CqvRZB2L2EZGCG3eN8Ol4zEA5cLRpfDDZVCQGJaqPg+?=
 =?us-ascii?Q?JuwoarHz71jn6P9Y9d7a0wft7XuuIV/pYyHQVMH4cElvfEVt4Rk1lZZeXRMv?=
 =?us-ascii?Q?JCv4BOTOGpOiNMRG8s3jWO4XAN2Hyqrn2SDbOU2IJUZLNGy6acW0725E6rdG?=
 =?us-ascii?Q?zQdTxYgU+AQ0e4qzx1bI1UBiR3vCeR+f2Z88pROU1Iyazqdog7kiS4AKaLQR?=
 =?us-ascii?Q?XhjGn5Hkf+N36dJHrU3t/mjFc9gFDT96hFRayoR6K9ei/HxOJ5CdQghjfSnT?=
 =?us-ascii?Q?6kbos4XKf5WIzIW1ImDXD7hl6ERs6DjIodpfjNL8B1I6mLabcIZmZOZf1Az3?=
 =?us-ascii?Q?7BYSdqeEIw7XB3d+tkG365SyZsHk6snklwRrZoyJ5gc2gLaiz/Dr3CiR7glJ?=
 =?us-ascii?Q?rd9FWzzXuNhytfzeXcT0NSkn4Vy7suLQwi26EIQRQy0d9mLtL24d+8jp7Pkt?=
 =?us-ascii?Q?5z2sT0xKnndJ32rkIK3tnQomFKZNZN8sCu/AOCFT34JnPsth4fozoeIJV3Me?=
 =?us-ascii?Q?jHMn+o84M19+0WsY1I1GeFLWngGqbLpmiWMBH18Lq6u6nu8v/2XX5I5tkf4q?=
 =?us-ascii?Q?R+ODWJl2I4Hj1/Hw7Q1p9C3ph8wmI6IeJ38kLtHY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca792d6-09e4-4107-5b12-08dccbbde662
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 02:12:45.5810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9FXsqrgBTuxAU1EUe1GJ2RUIrjjMLqXs2MV37YtYtYJDW6D2Mf3JBPMuHLzZDZ/3gSxcKLdwt2M8DpHzCgRKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10231

On Mon, Sep 02, 2024 at 02:14:04PM +0200, Greg KH wrote:
> On Mon, Sep 02, 2024 at 05:27:11PM +0800, Xu Yang wrote:
> > Hi Greg,
> > 
> > The below two patches are needed on linux-5.15.y and linux-6.1.y, please
> > help to add them to the stable tree. 
> > 
> > b7a62611fab7 usb: chipidea: add USB PHY event
> > 87ed257acb09 usb: phy: mxs: disconnect line when USB charger is attached
> > 
> > They are available in the Git repository at:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git branch usb-testing
> 
> We don't do 'git pull' for stable patches, please read the file:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> 
> Just send them through email please.

Okay. I'll follow the rules.

Thanks,
Xu Yang

