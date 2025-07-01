Return-Path: <stable+bounces-159127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F77EAEF39A
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 11:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88C481BC7386
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 09:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DBD2459D7;
	Tue,  1 Jul 2025 09:43:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023109.outbound.protection.outlook.com [52.101.127.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AD813AA53
	for <stable@vger.kernel.org>; Tue,  1 Jul 2025 09:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751362999; cv=fail; b=l69TEjkMDPBmYjmUhYt5lznYj7PpfY68dZHkbFL6JdjPs8TZ5g6Uf4LFWUjfDmcjFzVbR8RDO1+vVJFsr4wBBachCf3gtD6ay2xd8Yb8S9vi71t2aHBkuQqX4qq9rwYQ+uSuAkjfkV4s4nhNL20rpaVbMgsFKZ+e9hiSUz0PZBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751362999; c=relaxed/simple;
	bh=dd9p4r6sjUkas59WDmATdEUTH0U/AfciEv7Lze2foRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXFOnk29eLvxyR+8O6Qk5lHZzGCbye8PjinZCOgqNSaycbeXa3C9Jtbfa1tecgWI010h5Cv0qSpyIRJhT2QjKbPMXxFgogra+2VoealF+KuyzaC9AkxWlmZCDJ/etjM12/09IRZ3gbri+sRfC95kaoFFXEXLs7FCqrmN8O0SWD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rt3eNSdS52ENifeCYibam5nMFa0yzVXx4BkBsqSU5iBH0IQMou3AXs1PvXdEnc0euJLdVEpmbqW5yQiDMLixwT6pWPsgmiFKYnDKHXWxDvCQ58Wz7ESG5VbnDxqF71xTTtGbSasPOfJWJHmPC5xAOOJxX6dCm5nDWlr8JEk/A7N6F422nT9YLCM7Mqqmg4EzDgmBTsssvtNgN71IEx4lKZww32cr0orotODMzB1lV+d4Gl5wFwfryHCDB9zsUTgNgQ9IJzcDvaX1xKrCFeGiC+7U7rhTh2NyOJxdwOcSwjMpMlMEPAvJgpTRfSKPobD2z9KndsjekQSIfsHKUHqHFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gp6T6cpALLd/FyUMGR/FC69nn56YNp9LK770q9kEq1o=;
 b=f59pMJx3eGhyRE+KR/w8O3am9DEhf0hjW2UZ1eFh2qRgq1ovC9kIUppAvT8PGobJ986Ch0ANglYl9LFTXPX4EnHhBXojulOc3wUrCxaEnxGiZViyitTDrUSoH8XU81qTh/3gza6pVieZLeBEp/68GmkI+JJoIqf1muIepSeRg8Y1hXcjvReGq4zG1O/iwgJJ/NHNl+ab/yyy2tvpxHdub6uhq8Qib3nP5rt377yOJyko27nuEUTxJiqeJyvI2CdolPu7QpKmiQfBYlAsnsjvigucSD+kSOkZg8bbwAxbD9Qvomvpnm+R05WsfLJ7GRTe+Y7yYehah7risJJsA2eUOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6) by
 TYZPR06MB6936.apcprd06.prod.outlook.com (2603:1096:405:42::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.29; Tue, 1 Jul 2025 09:43:11 +0000
Received: from SG2PEPF000B66CC.apcprd03.prod.outlook.com
 (2603:1096:4:190:cafe::6d) by SI2P153CA0023.outlook.office365.com
 (2603:1096:4:190::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.6 via Frontend Transport; Tue, 1
 Jul 2025 09:43:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CC.mail.protection.outlook.com (10.167.240.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 09:43:11 +0000
Received: from nchen-desktop (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id B1B0744C3CA1;
	Tue,  1 Jul 2025 17:43:10 +0800 (CST)
Date: Tue, 1 Jul 2025 17:43:05 +0800
From: Peter Chen <peter.chen@cixtech.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: fugang.duan@cixtech.com, cix-kernel-upstream@cixtech.com,
	stable@vger.kernel.org, Hongliang Yang <hongliang.yang@cixtech.com>
Subject: Re: [PATCH 1/1] usb: cdnsp: do not disable slot for disabled slot
Message-ID: <aGOtqYXkxxcnHAl-@nchen-desktop>
References: <20250618095321.34213-1-peter.chen@cixtech.com>
 <2025070123-macaroni-gag-6dd0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025070123-macaroni-gag-6dd0@gregkh>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CC:EE_|TYZPR06MB6936:EE_
X-MS-Office365-Filtering-Correlation-Id: 55f09db7-bddf-4f74-3256-08ddb883b17e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TYWpEODMJ+qk3/fp4L6bkRJYnLefbZZ9I7NbDXTo0WTCIZDO0njDJPOGguDx?=
 =?us-ascii?Q?B7UDxTBCC3zmHtGjukebSRjMauOpNrBPLp6owWCVGHhSm3B7OzXc4DSGFHFb?=
 =?us-ascii?Q?/Jl5szkh5GybMqqnr3XtWjMzG3b2//ksBe+mU33uBmxQ7rH2rR7/exWrUdvU?=
 =?us-ascii?Q?H98LRokAsSi0e9lptDJRRg9mALov83uHlmoj3DWfnVGkXBbSetaXy74rxoy+?=
 =?us-ascii?Q?LIprcHnHdab3dkD66N0KTzMcJP+4cl1x/ZjJcYoEGD5VDN/T00tuPfVgy2ct?=
 =?us-ascii?Q?pi3x7EasBak2X4UUoUpVzrombApPvw+E87sbyxkqwxJlarAXxOkT96JviAIj?=
 =?us-ascii?Q?cdhoFi3qqTBwMeczaXHtFyYp1zJ8bE0Tif3FwtG2xC51U8arnkEbvtT7kgrr?=
 =?us-ascii?Q?XcAfZgk7wGdTR3JeF+CVGnqHuZ3M3r43Nz6i+adnb7zn90xnYY2piVA3OT3a?=
 =?us-ascii?Q?zVI8PEVBcyWoHdpL/E0KrL+0R4xF2Rodwva6otoZoidBK6IarZvYJ0fGpdBb?=
 =?us-ascii?Q?XeVWU69ZzvNUvj9zhnuBMsmc/y9sWQ3dP96t8b5H7w8Z+0Om/Kek6/HYfppq?=
 =?us-ascii?Q?SSX559exVkXE+ld5kJfoH4NXkwlivAh13iHlB4gNQSPBIrxgWnq1csynIQ3R?=
 =?us-ascii?Q?f6Zb7Z4FUmpdzilP8gNCFJueTrU809AgszA6aRXPpt4ngPJsvIOrQXxyTp8H?=
 =?us-ascii?Q?XpsnXmeVtb3edSB6puLEJNKhAwGkb1UYeWBS0iO6zjO2U8poihPeHNoPfWhR?=
 =?us-ascii?Q?Gws9dQWVe7OBejkOzAdc7YKijAzCCZdxawVb+4w28C1VK8O3OJw/1HcpZljX?=
 =?us-ascii?Q?TMRTTixVodx5Vp8zwRi62eVWPQWdXr7AUpTpBfKgrEYUmbyTmRL3AwJJBWUM?=
 =?us-ascii?Q?e5hkj5pG1o31qIulTi+so6DL2A2PpLVrih0b1jD+21Jj1PBI/dKfJITl4cii?=
 =?us-ascii?Q?fhfTVQ6PUHYLuo04PfNxzuzYx6kNa81swt1F9auBKWI7jkrAUPk02eDXWpdV?=
 =?us-ascii?Q?dzHyS6jNev10gEZ91HFGqi7DrPVhrqZ1ElikPrLDGXkvo5SMfgPtHXaDm0Q7?=
 =?us-ascii?Q?xJctedWh1u02cBc1w3K6Lxe0OwsukPD5Urc0RJEhxubNVMpGn6EduX/k836T?=
 =?us-ascii?Q?wz7/Rn5ty457yIIBnARvSf1esggop5V0X9lt5EAOwP/efcLCMpchhy37bFow?=
 =?us-ascii?Q?SmcS0fL5Kw9ITGHYF+y/4z+tJcfFrTGxgCNms6Q5A7dFK6EJi100Frc/L2bR?=
 =?us-ascii?Q?je1KY+uBdnr9ijFHo1kVR50gRD+k7t9FPHaRBB+WqZNrrOhpqWMm27HbrUs5?=
 =?us-ascii?Q?a31AtzjimEsBXWhDD/Xgps1NiisHo7pPWLNLyz3pPxAzozI5MjQ8o4XxgX3Y?=
 =?us-ascii?Q?IEZxdBnrJpcADgaFgc8yFUEa272eNTzDw/ryrop2xdunEs2ayzTB3hXd+JHg?=
 =?us-ascii?Q?NsFR1CCMZpW4wDensY3FN3ItlKBlEvL6sDQNQASw5c4uWD1jbQ0FpDmxSWdR?=
 =?us-ascii?Q?7BAJHr7GA0x+2Pxi/B7zefsS4LTfmlAEdNky?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 09:43:11.2888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f09db7-bddf-4f74-3256-08ddb883b17e
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CC.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6936

On 25-07-01 11:34:46, Greg KH wrote:
> [Some people who received this message don't often get email from gregkh@linuxfoundation.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> EXTERNAL EMAIL
> 
> On Wed, Jun 18, 2025 at 05:53:21PM +0800, Peter Chen wrote:
> > It doesn't need to do it, and the related command event returns
> > 'Slot Not Enabled Error' status.
> >
> > Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
> > cc: stable@vger.kernel.org
> > Suggested-by: Hongliang Yang <hongliang.yang@cixtech.com>
> > Signed-off-by: Peter Chen <peter.chen@cixtech.com>
> > ---
> >  drivers/usb/cdns3/cdnsp-ring.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Any reason this wasn't cc:ed the proper mailing lists?
> 
> Or is this a stable-kernel-only patch?
> 
> confused,

Sorry, Greg. This is internal review patch for upstream, I forgot to
omit cc list when sending review. Please ignore it.

The formal upstream patch has already sent out to linux-usb mail list.

-- 

Best regards,
Peter

