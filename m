Return-Path: <stable+bounces-180604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FA7B881A6
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 09:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2D2B1C81E3D
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 07:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0235A29D29B;
	Fri, 19 Sep 2025 07:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Ngxa6HHG"
X-Original-To: stable@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBF0283FD0;
	Fri, 19 Sep 2025 07:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758265663; cv=fail; b=oV0pWBRirLzacY8Izkhj2GBDunA5p6ayJeb/H6qizHAAVPOQB19+7Sj4RjVS4vjoIhZuEFpbOxA2ha07u6PSHwp2FmtgPRVhFhqa0Oq567Y+GvpIhhDowzPkVtxxng83U0cZjx45Fggbgov31s5GhhJTqqI88fnlWl+aB/5Ii1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758265663; c=relaxed/simple;
	bh=/7wJS+mQvipeJFLOmAdGBBcRqL2EEBSFgFQkQZQIrdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=csBxzDLmgjX4AlTRM21r8m2npWrwx4QyDBA3AohQCKBFZxxOP3WXv3e4RNYNxBfglhK/ibxIpNn7ThpS4P+p8IhKXtZjwnl4UKkpCxRFQFPY6YkofMId/pUDRrISvfNEcJqOQmnMt6PhRxtjPFUgDMtDNX0cC87AFhqAQiYZma8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Ngxa6HHG; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58J5LmqJ018786;
	Fri, 19 Sep 2025 09:07:30 +0200
Received: from as8pr04cu009.outbound.protection.outlook.com (mail-westeuropeazon11011057.outbound.protection.outlook.com [52.101.70.57])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 497fxhuwhf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 09:07:30 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHaQJWm1F6ZekxImC1ZIbelXrx13o3CsxOh8jxnEYpI3oy+yKTRrpcC2PLjXuoz/dmgqdo4Gg9GmA/oxuImxP7OfOvoQ3V9Ojwwh4ROGr/5nEocNdEiTqWEaUtfHqvRy6wWPL5uCZy7o+g5zBgDDOBE4Y/1jwsTtrpM2oVZrkTzAigD5FNLx7qtF+gl803zxiDALCIRHsMUpFjfqHKEeNlXcYO/jkMqXjOjIepmnqbNU+YyQ5fDvtYEOixwcveneDYGgeSwFHF/qlXvdnYHNbih2MXN3CdXR1RJQjvCJIuYMrn/dW8WB69UEKH8iHO2oBsWi6Ssvh7BNAxKrpJsj+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=toM+gCUgcqUJ5hgJsi7pFc8Q+OvJsYy6dpBnMib2IdU=;
 b=DzKZqsgEm9fxcSzNZ98O7Z5s8lR/QW+Jfy8H916wXKxE7mEnwxdOTNqEv6OjYIwXwWZ2Jy3yOYh4G11qaa134nxBxnPCN0yLAYAEOdrcwF4UDm0PbJsNmMHSXORnP3vDCgU88DOoy3RHD2AI9WgncDudIkPwapcZTVfdDqyl/fy5R0a2whJcEKxebgzDj/pTa8SQY/k/Nx0P6mfr0+bK087iYHMkCr5cEaDhrKDud5ti5KPaHsCUqv1vQZDS87uu8RrPcUqgvN11R4r+WRHSZsMgO++6NZCL/MqDo2cTbj+frwYk0UcaI/B6VCVmaWGlftArdJijnBzFt+jka72ujw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toM+gCUgcqUJ5hgJsi7pFc8Q+OvJsYy6dpBnMib2IdU=;
 b=Ngxa6HHGDVQlUwahB8a2Wozjw9YxJvfXHMWVvoe+VbOoVGhumfP8EjPO5dxVV+uCK6ZRlYMvBV3FJYHzIRAsPbvsnToF+oc0ji8vzvk+oRgoF4ml8DIZg0wQzD0KrzwOsy7DtXI+q3EKyovMBHuJpytntIzoItwZ5D9XEvnPQzq51TARxPh0IiBKMQZ4bbMnj6QBRga/Z5N6ptjkljWABf0zFmFj2f7wpAh2mcGfng0eU3yN/ipq0/ReKzzceEX1mUEx8TLf0p+GBRbLPM2+VBkOEX6V53R+3YtSced50cLhDB0oY49dMOPnHvVLq03f2lxjjbupUpriyMM+SCQ+0g==
Received: from AM8P191CA0020.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::25)
 by FRWPR10MB9496.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:1af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 07:07:28 +0000
Received: from AM4PEPF00027A5F.eurprd04.prod.outlook.com
 (2603:10a6:20b:21a:cafe::1a) by AM8P191CA0020.outlook.office365.com
 (2603:10a6:20b:21a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.16 via Frontend Transport; Fri,
 19 Sep 2025 07:07:28 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 AM4PEPF00027A5F.mail.protection.outlook.com (10.167.16.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025 07:07:28 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 19 Sep
 2025 09:05:02 +0200
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 19 Sep
 2025 09:07:27 +0200
Message-ID: <257e006b-daab-4eed-9e1e-189d1b7a3167@foss.st.com>
Date: Fri, 19 Sep 2025 09:07:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: dts: st: Add memory-region-names property for
 stm32mp257f-ev1
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20250811-upstream_fix_dts_omm-v3-1-c4186b7667cb@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250811-upstream_fix_dts_omm-v3-1-c4186b7667cb@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A5F:EE_|FRWPR10MB9496:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c05c45-01f9-4a97-3e26-08ddf74b3190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWJnN29uZXRSQ0hUVm5hcWRwN0pOcnlNYkQrNkduWGdPbE16NFFiSmJhL1M3?=
 =?utf-8?B?QzhqTS80ZGlBd2RINEtHN28vOTZiRHlhRUhza3dQZ256VW1Hc0o1SkZLODV6?=
 =?utf-8?B?ZjFEclZ1R3ZLUGlyNDduRE9RNS8zOXFzc0syQUdNaXBod01WZTFoMURpVnlw?=
 =?utf-8?B?T1NOM0JmS2U2TXp4K0dZcEJ5SEJ4S3pZRnNpY2lWblRPcEw4aG5ER0pRZmw0?=
 =?utf-8?B?MHh4OVJWalR0K0lWY21zakhXOGo3d05nemdRK1FsNDR6dFYrY1ZuSHhwQVBk?=
 =?utf-8?B?ak5leFZlT2s0Yldrb1JPUkc5QXNlSk1PeDVjOEtiRFZONjVWdENmTmV3VzZG?=
 =?utf-8?B?elVhdVZzWmhaKzkrQ2lXR2w3cWVEYnVwWUIrMEx2eitTTHJiVTRDNUhKSVZR?=
 =?utf-8?B?OUg4ZGlGWUdmWnBQeVRxZFpDVjVSQ2xkMEtsU3pObG1oWFNKTVJWK2F2ZWND?=
 =?utf-8?B?ZElyMmNpbUNuYy9kamxGb2ZiK291Vks2WGJWS1YxWE9wM1ZaZGphWUM3QlZF?=
 =?utf-8?B?Z3pPeHN1ZVY3dFIwQXFhMXBxYXVxR1hmQVZRcHA2USthMEExOTNnNzBXYmRi?=
 =?utf-8?B?Nk9qZGYxNHBwN09PM1I2QjNCak0xNzUwaEovZ3VLdEw2VGZPK2k4Tm5iR0lF?=
 =?utf-8?B?ZVRCMXBacjNhUUlpYWlzNUlGYkhFanpkOUlJem1Ub3lrSWJIa2dTbUV2Tlhm?=
 =?utf-8?B?bXRUUzdIVG9URUtwUndGQWtyMitiT2JBSU5sajhYU2Z1dEpEQmhPeVQ1SUFJ?=
 =?utf-8?B?VmNseG9LbnJSb2l2TFhOc3pJclRjZ0FLT0hiY3pRMmlFaVR3ZVZadWJuVVRs?=
 =?utf-8?B?MklDZE4zSlZMekgzM1VxeGE3WDMwd0toUzZUSnpKdlpWNmRuL1prVnZLY2Nx?=
 =?utf-8?B?UDNqRE5Tcm5oTUQwL081Z3c4UTl0MzBydlBJUW55L2lsVGdMS0w2d1BOZUlD?=
 =?utf-8?B?NXl1TmRQNEVWdmRuV2tOR0lCV2p0dGFUYjFLdno4TXVNWmhmYVBqK3hkRlUw?=
 =?utf-8?B?b1V1Uk1Dci9YTXN4VXp6UThWR2F1VmZXUzZFTWNPb2l3elJ5TVZ5aXNpU1BU?=
 =?utf-8?B?RkRvOUVHNnZDUU1pQzFscmM5T3pLWGk0MU01MEJRRXBYdktSdXdPdHkvZ2l0?=
 =?utf-8?B?bkRocktoV2M1VkpGT1c2bk05bGlOc1pHRjJQdEZUUk1raXF2eXE4N3JwdEh3?=
 =?utf-8?B?RTRIbjBJdmVFOUlYNExBRHYyZCtnajk2Y0gvdUVOUEg4VFAxRk8zaHV1RTIr?=
 =?utf-8?B?Wnh1T0xFNGpNdEdobFBBZGljS2FoTUo2YThBUWUyTzJMRXlXY01VM3g4U05R?=
 =?utf-8?B?Ni80ODl5Y0o2WXpTMlg1VW1vS3FVS0RkUDhkaEI5ZW9vVFNwM0xmbHpEM2Vs?=
 =?utf-8?B?WGl1SUcvcFpTWXRzeXgxWXdPN0IzQmJ3NWo0VkZybkhlSDhFZk5vTDFzeWxP?=
 =?utf-8?B?RXNyd01mb1BGLzZTQmlkSXB6UGJCRUNFdThtQ1d2eSt1WitVUXd6a0JLa04r?=
 =?utf-8?B?Z1NWUC9GTk8xNVlpUVFlTmxoVERSS1JyQkVYOFRuV3lpeUZxUzVyTGh5WjRT?=
 =?utf-8?B?NGpkNFJwR1FWa2ZxQU9XalJZbCtqRUtNbXhaNFZseFM1cWx6d1pxVTFEYm45?=
 =?utf-8?B?UUptN1BjZVJDZXZtOU1jZWJHNDZRQ1U3YkxsS2hWdkxQbDF3R2RHM003VmZ4?=
 =?utf-8?B?TWxzdi9xbk9PY0h5WHpnQVJRL2hrQVVqYUJ0dnk3VlRXNHZtVWlNak5uSi9L?=
 =?utf-8?B?VVZyZmFlR0ROZEFXeW5Xb0hJNU5VMnB3aFlTeTNPblducVNBbWN6VWs3dk9s?=
 =?utf-8?B?Y3VPUHlhZThOQmlKaFQvKzJSR3NRTERXZXYxQTc0UEdHbGVTZkx4dy9CRjVR?=
 =?utf-8?B?bjdXMlVpdXhGYW5NZFRUTUFTSFhKdTBXc2hVblRJa3lLR2psTitWN2VDTXha?=
 =?utf-8?B?YVN4bkk3Z1FOZFhhR1hoRjRJakZPMjZiT2QrL2YvM295UDJ6QVFqZnYvQThP?=
 =?utf-8?B?NXpDNGo1NExxd2RiYnlHMktUcHhjTE9LbHZvTVEvVzlFcCtLcUJvN1M5K2tj?=
 =?utf-8?B?eTN6ek8ya0UraG5vRkY2dXFEdVNOZWRNbkZMUT09?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.43;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 07:07:28.1451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c05c45-01f9-4a97-3e26-08ddf74b3190
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.43];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR10MB9496
X-Authority-Analysis: v=2.4 cv=K9MiHzWI c=1 sm=1 tr=0 ts=68cd0132 cx=c_pps a=TGtHJSg9jqUEU2jNioFT0w==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=SAHXIHsbQyQA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=VwQbUJbxAAAA:8 a=8b9GpE9nAAAA:8 a=i9Drqpc0j13i6tykvIIA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXyIltgLBlDYaz 4d5pWYH19Afiyh1ZfPkP+UqlEk45wzd67oqYWCnU/65qSeM8v65TSUe7vMlp0Mxc4VlD0kkeKm0 6PMcptJLJlTnfJtVueuQ4YxT7NWdAsbTauGEc/8GefhIr9Ut8/o4pptKVTw/yWe5hzbw8kPZ1Md
 pbM+I9+r1IbbMz65wvxRGoT84WfNruGYfL1WMhshv9EN3gaYbQ8zjaZAFH+J32cmlJSuHPK0bV2 77PV/sycxthY1rEszUqn3HVO8991dodA1hddtcWiTf8ncjsYsB65vzRBX25J5Wm2PSoNIM14Hbw uzzDDi9SzgPdFZfLHygZRSWi7rCYkp6HxOzRNuewVEECWmipA9p3ZfgNyei3aQLeCMmiguYH/S1 2tWaiDcD
X-Proofpoint-ORIG-GUID: 6ZqLLRW_LXiEexrSYcElZROYasS85DDj
X-Proofpoint-GUID: 6ZqLLRW_LXiEexrSYcElZROYasS85DDj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 clxscore=1011 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202


On 8/11/25 15:28, Patrice Chotard wrote:
> In order to set the AMCR register, which configures the
> memory-region split between ospi1 and ospi2, we need to
> identify the ospi instance.
> 
> By using memory-region-names, it allows to identify the
> ospi instance this memory-region belongs to.
> 
> Fixes: cad2492de91c ("arm64: dts: st: Add SPI NOR flash support on stm32mp257f-ev1 board")
> Cc: stable@vger.kernel.org
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
> Changes in v3:
> - Set again "Cc: <stable@vger.kernel.org>"
> - Link to v2: https://lore.kernel.org/r/20250811-upstream_fix_dts_omm-v2-1-00ff55076bd5@foss.st.com
> 
> Changes in v2:
> - Update commit message.
> - Use correct memory-region-names value.
> - Remove "Cc: <stable@vger.kernel.org>" tag as the fixed patch is not part of a LTS.
> - Link to v1: https://lore.kernel.org/r/20250806-upstream_fix_dts_omm-v1-1-e68c15ed422d@foss.st.com
> ---
>  arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
> index 2f561ad4066544445e93db78557bc4be1c27095a..7bd8433c1b4344bb5d58193a5e6314f9ae89e0a4 100644
> --- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
> +++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
> @@ -197,6 +197,7 @@ &i2c8 {
>  
>  &ommanager {
>  	memory-region = <&mm_ospi1>;
> +	memory-region-names = "ospi1";
>  	pinctrl-0 = <&ospi_port1_clk_pins_a
>  		     &ospi_port1_io03_pins_a
>  		     &ospi_port1_cs0_pins_a>;
> 
> ---
> base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
> change-id: 20250806-upstream_fix_dts_omm-c006b69042f1
> 
> Best regards,

Hi Krzysztof 

Do you have any additional remarks on this patch ?
I would like this patch to be part of next kernel v6.18.

Thanks
Patrice




