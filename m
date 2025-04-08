Return-Path: <stable+bounces-128814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C116AA7F3CA
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 06:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C39718989BC
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 04:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518DC1CAA89;
	Tue,  8 Apr 2025 04:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="bTTh1Jly";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="I6I5vT9K"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2A223AD;
	Tue,  8 Apr 2025 04:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744087863; cv=fail; b=Tg+hoxU1fTBxzImesb6zsviiAETPBwYh8YBp5h/nS3NCKqc+5OFynIBePQG1IYbFb+PCPtiIYaQviHYwytW/V1PyDDBGuml30RviC1voArZyurwAyALwEtk5J0vZyOAKq59aYt1LIPWaif8J+eFzmeaNEmHPsLRVCeGX1kyiMoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744087863; c=relaxed/simple;
	bh=EIXFOcOsd6+gTK/ALrMJtaK3ExkmG+1FaONoNsbBetI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SiaOMUfqNTsAXHp1WzSAwqe97Nyqquv9xs3+g1Pfaj2bchKuU/pW/N4j5qTnVWPTqd+vBbJu2rEi6pvr6JOiCM+OT9qv5Wp59b5rvmP4y/DVXNnZ3dyVPssy3TvwbQyYE1knO3/Vb3N1Z0jg4A2D8CjAzfB4xNxUxCk4/3CHGWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=bTTh1Jly; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=I6I5vT9K; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 537JgX30024906;
	Mon, 7 Apr 2025 21:50:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=RRSeDfMcmNeDs
	OSIu9IZ7EhDYUSy0agMbhIKY/JnNQI=; b=bTTh1JlyBXvBZt9STOzA8Ra64mioE
	moYLC3uqCAp1cRzMJJYREdwXWUnRrUNa+yfFFQNwmvL0o+e5auRYeOJHUDZSqw/d
	9J6ZuemH8e420kNs4NJKcZ7KzOmO63QFbBnIUVKnNskGhFwCxmKJ/CdCa2fVJvNA
	4d/AuSXLqSxKZenz1IMuB8ZrgFFnnqp2QhoGXKdaGSEGf+/DQd2mVKQuFqisSWDO
	/R8ZQgZERksy/Rh64WMZDBx36C3pLLUAKAGMSY+/cArZEuQKfRprckkUqUX0s8Z4
	ZRMoUe2wJrBweNBCx7VaTdJLXj5/HEaKLutwjCNk34RIHcox2K7ce6+hQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012053.outbound.protection.outlook.com [40.93.20.53])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 45u3kkn6sn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Apr 2025 21:50:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJmHEmLgNlQH2hc7ICJ9ZtTiVATAwPgsCZm44WlXCCljzWshhWdAWVnCerOAyvSEUdISorv/WVR7P6pO7MxSFpCc09gud5dpO1HuWBfTZahOlMD/mM3JFMmPJbZPDegeJV8oWPmOXJTLk/2qGeSKo6lHaZeUbzw9eawTFOE10ZP7hW09Blgp4ffYKbBoMmZEbPxk1iN1lm0gmcVIc9rJR477bNfrJC6fkumoMhNCsU0jcuMJ2flxOIZSuWh8dJmUHKJ+n4CWobJ96lh4EyCCHSF4qRThAzXngx2i/DdtpM17YdV/xfRYHQC4wGoRUI+998Ro0zqnHgqXk/jhF847Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRSeDfMcmNeDsOSIu9IZ7EhDYUSy0agMbhIKY/JnNQI=;
 b=Cy1kjjiQs5nuP/xZT0ztJe5MwNYMosSGryth3xbsxhr7RCBCh91MIN5AVAVrCcd9vnq0vcZZDcNRsov3mzgl0inTUeySsb3V6Z8vv6LY6PPyMZHPW8b3pxJWFjvzuUT49TKB0ECKFS+VxixFY5GTJMjYt618Gw7VSYb2FGiIzRbiL3Q7h8Z3Rpp5QHgKaUSijGXO81Mmh387k31LcDIwazQMxGqFhYCnLuy1fOlC9fT2JORY5tr8TwPT1Dclu7s+de2EMXPFreADE5eomlPCkY83AlNJVUi0plAEt6l4b093Sy95Hq9/uVmh+4fBOLVIq5EMD2pw8BLj2DKFwN13iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRSeDfMcmNeDsOSIu9IZ7EhDYUSy0agMbhIKY/JnNQI=;
 b=I6I5vT9KDb0m7gak7Cmd+t2l99UVYSB9MzMhIStTYUeqXXfYKTHaY/McuggqgOyj8Baf6WN0jK2Smk0RMAmxLI6EmMo+duEIowW+bINclPdeN8/nB2a6gVB9jLipwmOlD200ovKBg64o5ZjBTwNlsaGVZezt3liUE8Zi/CmKMuecZvjBqLf7aM87Su54YnkIbDFh9/KhzBXm1PHIhV0G66/nq75wxoZTTqm/uhrvlfT8sSvGIOtRHlvZRfO3DV/Nic17iDgzfzl5WLgQ0GDEGI2MWBk6aJez7m4mP9f+odv0d0zm4DvyAKWXzZPcPdDtsOk2CQG3zAY4Kw8kV/48lA==
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com (2603:10b6:a03:3f4::5)
 by BL3PR02MB8252.namprd02.prod.outlook.com (2603:10b6:208:343::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Tue, 8 Apr
 2025 04:50:36 +0000
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42]) by SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42%3]) with mapi id 15.20.8534.043; Tue, 8 Apr 2025
 04:50:35 +0000
From: Harshit Agarwal <harshit@nutanix.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Cc: Harshit Agarwal <harshit@nutanix.com>, stable@vger.kernel.org
Subject: [PATCH v3] sched/deadline: Fix race in push_dl_task
Date: Tue,  8 Apr 2025 04:50:21 +0000
Message-ID: <20250408045021.3283624-1-harshit@nutanix.com>
X-Mailer: git-send-email 2.49.0.111.g5b97a56fa0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::28) To SJ0PR02MB8861.namprd02.prod.outlook.com
 (2603:10b6:a03:3f4::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR02MB8861:EE_|BL3PR02MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: db8b46a6-b40d-4c70-df0c-08dd7658e649
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f4wi+HB870Cz3k1sF52W3L2dyMHJbGtDnu1/Hf62gcrCTJWpk0JMIliXfmAv?=
 =?us-ascii?Q?mxlA3wACVJTiN0RzQjf6oy3GoCmiYzdIWIbDXxwdvSvjkrqO7HEHmiSaMY8V?=
 =?us-ascii?Q?sis6bWYofHb4anPWxzYeIviuUeoT9zk/qMkJciR2HnaOvdiFMVn57BqWCrJg?=
 =?us-ascii?Q?JxCW23K6sS2vvKDPxT5XGcr0NqGwpUyX0RL9QVgozF3rDkML6BtjdJpKYWfu?=
 =?us-ascii?Q?loo0FUTGmtfk/hqTnZJwivbKgIKTzYYIiFEOCBkdwrtOgayVup4hfF6GoqaY?=
 =?us-ascii?Q?UAdjZTSK70eTkkKQLgVHpG7DG+NDUIqZxG4R8QeXTTz44e86WcU09PMzQBVQ?=
 =?us-ascii?Q?dx/C2stKpQmdBVBhknsayWtkWcgDk4VjQcTgzqbox9ZnhYARDwi44wNKBtfi?=
 =?us-ascii?Q?YPN7JrnU+ba7kebeg7zI0UH6+onVUtEwCP1iLd4heFt5zNhj9kjlIQ2uoKxY?=
 =?us-ascii?Q?hsQoCwv5PjWMv+n33+RpYubn+5Lx/CnNJIkxGNyTfVKC7TYATpoqZghgkeJZ?=
 =?us-ascii?Q?1W4U77NbBeBx6DE2ydYF1WTSatu987YIiaj40HEp9jIeJfGw/C8wZtdpsFTk?=
 =?us-ascii?Q?smB2z47phVCgADW16axmox9I1FhfUuJVR3CXRVkL9IreTqS33plR5Qxcbc9m?=
 =?us-ascii?Q?ZS0Px482FhEcv87NSq+18zfSFUXEb3k4OePns7FbgmCCdgeVsGQ22OeNlJC8?=
 =?us-ascii?Q?T5gtKdruDaoBdBRv8z2D4tSl/cfvO6eXK2INliKLR1BnBo6ryXZRkTdaKUau?=
 =?us-ascii?Q?47DetgSNGk+me1yr6xVcVAwHyM5kKb4FDrhN7Ma8+V3rVcMJGvC+7+0Sw40f?=
 =?us-ascii?Q?3brHNNV6umioBku0EbEVrx9HL90e5NKAdMo9c2bArXitdopRRBorQt0951zH?=
 =?us-ascii?Q?MwNIKmdsPUp1EDqWEcckxFl+POdcVjwzKLeRp1kD9oKo9pfG8kdaItOrqDPo?=
 =?us-ascii?Q?WNoQ5XpiNfgMX8M8UXsxWYopjedmcVIFFOQgGhbJc761zDZlq5ySoUHjuuIz?=
 =?us-ascii?Q?kGDPwx0g4ZNVyHljPUIzabkM8o8BnSJ6NpjrPN+rD0jtlyW+KKjmwO/p7+VB?=
 =?us-ascii?Q?R1yn132e3TzKuyo3+yTqNlIORab3iWEKB9klYmPGsUgJOQKrtp7YQB8HVyYj?=
 =?us-ascii?Q?Jp1CbZ8XgMgtLwkU/gwOT39DrlYLQmnJalmMBcO/va1C34Ub0Ql+X9/SZxX7?=
 =?us-ascii?Q?+gFQPkOjr855JzMB4qaLcxcswwOwPDFCMsIlhRJBT13j1b/l6Ciej3t2W5oM?=
 =?us-ascii?Q?dxkXCWps6yzPI9PaELCiaw13TlfAph0b79ZhAkgaoab16vRngoR3keT3olRv?=
 =?us-ascii?Q?bG2jk6Cb3i8HeOOyhSeAvrkORlhDtm7Rtvt1a4sv7hQv1mlV5wT/GIDjdWlc?=
 =?us-ascii?Q?l0IadVaTPV/arM6fO3O5M3W7Jwyw6qxAGUpnFIilh44XRR+ahxNV2xrMBJZH?=
 =?us-ascii?Q?+P/0P2Md9Q7qjq/FL3ECM6Ch72dt1gwjPckdhKT47RwbuCWDPYzEhg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8861.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i301HUMt1irsSeXlct1GaLNgrGGgx9Vso1CT9RZhe++7YDJ0WtDybvb7rz/Y?=
 =?us-ascii?Q?xcE3Wqyr7DkO1xuaWpUNIzwlYYCgasuV6fCiCjJTBovkP1BKwt7eOs2c+fSl?=
 =?us-ascii?Q?GdCuqoOVrZrwPNLsEzhi5aKaK0qLthggzU2HjHO/UAZg7b8Y/7r+0x1tKEXC?=
 =?us-ascii?Q?kFSp6fM59ykwSndfHFSJQbell6onGEGRElsuPCXMtP0SJBCgfZcexvtFTWAa?=
 =?us-ascii?Q?g7MXJLpbG3aT+hyQw3oszP2LE4S5g+OJk+MGZeUsBLvWywxKGenRMUz8g92R?=
 =?us-ascii?Q?df0G3YcgDTmDoo/UrfDFDI71keIXfsJMDSfQXAluDXibdTdl8m5kXDZsnUi/?=
 =?us-ascii?Q?Mn8VAHzsIVBKSui1oFfvIc4eS8UY23qyFXowjdXwumn6fNprKMSKR0y1hheL?=
 =?us-ascii?Q?/z5BIERDfWwr8EYJB71mbiEzfVuaIa8KnSaxLXWl0ttYZGBreOQKn+1GsWWb?=
 =?us-ascii?Q?WhI8wD9u3JJFyrGE/xSxVrCr5lMe5CAgT5DeIlh2TMsXRw6WAygXqGLQLZpy?=
 =?us-ascii?Q?x1UEZ/WUdCiuO5/3NMMSchXA68gr2s5FkTQnDCXcXNC0k4PjHf1SEyyjfKd/?=
 =?us-ascii?Q?T8BI4HKYrBUn4KjDBtaB+SpC/tNzv+cubFB9aqwZJPdluOxx6ghvahreJ6YH?=
 =?us-ascii?Q?Yj8LNMll65J8F6fCECXWhuh/HeAbiAGq8UhStGLF6ZwE9oM68caEMW9Jfr6M?=
 =?us-ascii?Q?uDMjyPVTzDMikWniTtEi3H4PU4VD/T9JyCoMVuI2P1RM79dWFruRiQuFdXf+?=
 =?us-ascii?Q?REY/Z+AGIfo5GuU1QUsKPFSdZ2TDdFarkF4G7CScuq54j3MhoyBZk2b+tFnI?=
 =?us-ascii?Q?/eP8zO2Gt+VYgkRfzg3w3MweokySNXFIa6JAClLFPd3j+hcGewGthLZFTwk7?=
 =?us-ascii?Q?Kuf+P7ApMfS6eQ3PEIvnxU+b6b/TNC7QTIFYoanRq7qXAimX8rXYM1eB8ycO?=
 =?us-ascii?Q?mrPBdvJ0FU1A3er6rqLhivpWfylbzcsxAY58oAVRsoYHPDxJ3plTSZ3urzJB?=
 =?us-ascii?Q?EVpkJc0t6LZxFqh58sHZU52rjlYp4YzeZ9CBAKYflkA6PJDosIqYITOj08qD?=
 =?us-ascii?Q?C/hBF7vLdK1OD9V7lcwVPFUj7FHVsaYlkeA5O08bL1QM/BsOM8yvtagWRYr2?=
 =?us-ascii?Q?YzcAWkAfhs+DZG4fn4Ig/Na6Sn6WNl24R6RVpDVZMKYG0PRdzwjzWIphvjr8?=
 =?us-ascii?Q?lJS0UW4FoKr2gsmWTH/ehEDWyA3ruUSLTYVH/TpOdHtTvJ/9P3eAzxYN3JJu?=
 =?us-ascii?Q?P7TRNlpntTPabMXzDRgnMkqlvckB5F+qUFkD6QZAEy5U1eBL80AWWxBsiWqt?=
 =?us-ascii?Q?xTh/s2ypiZ4cFO6LCRitncFx52yDCma4hnsMDqesYiaoRRsmoqxH9zFlzq2Z?=
 =?us-ascii?Q?ebxfiobZPPYntDfxQQ8P0aUzqGfW9lDZu5QGYosomCIIlQiJDiZ16ZWQrfrb?=
 =?us-ascii?Q?JZpddrBgIR0TdHLr5Z1nKTKEoERd5zBR7Sp6a7aDVZ9MrlzQ5jfn0XhUDI6j?=
 =?us-ascii?Q?JLNfa0pXSxRSxKs8QoceUIWgRGviwh4v5Bt/uzpI5svZGF+OVuXxSgISWow9?=
 =?us-ascii?Q?qu8/1WZUslMuIpFmbvkFtZHV/2QdC3yOz7v2I+qRbgExsf6jeExYgTafX0if?=
 =?us-ascii?Q?aQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db8b46a6-b40d-4c70-df0c-08dd7658e649
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8861.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 04:50:35.1394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4/bVIMkIIun6krQ+66ckwAtEFatc0GX0FKXLxORfh7Wcc2SQeSFXl/Pg+DidPNWBNknqINTnYxlbPykOn3vp5XbqqeJILdsFepZ5e/+YOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8252
X-Proofpoint-ORIG-GUID: StZ3lzs43_iegcCxyNjrmnVxC-lnX174
X-Authority-Analysis: v=2.4 cv=d+b1yQjE c=1 sm=1 tr=0 ts=67f4ab1e cx=c_pps a=sf1zYAMyThzbrKU8SMWnlQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=gVQ24MhJHzRK1_1-vqcA:9
X-Proofpoint-GUID: StZ3lzs43_iegcCxyNjrmnVxC-lnX174
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_01,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe

When a CPU chooses to call push_dl_task and picks a task to push to
another CPU's runqueue then it will call find_lock_later_rq method
which would take a double lock on both CPUs' runqueues. If one of the
locks aren't readily available, it may lead to dropping the current
runqueue lock and reacquiring both the locks at once. During this window
it is possible that the task is already migrated and is running on some
other CPU. These cases are already handled. However, if the task is
migrated and has already been executed and another CPU is now trying to
wake it up (ttwu) such that it is queued again on the runqeue
(on_rq is 1) and also if the task was run by the same CPU, then the
current checks will pass even though the task was migrated out and is no
longer in the pushable tasks list.
Please go through the original rt change for more details on the issue.

To fix this, after the lock is obtained inside the find_lock_later_rq,
it ensures that the task is still at the head of pushable tasks list.
Also removed some checks that are no longer needed with the addition of
this new check.
However, the new check of pushable tasks list only applies when
find_lock_later_rq is called by push_dl_task. For the other caller i.e.
dl_task_offline_migration, existing checks are used.

Signed-off-by: Harshit Agarwal <harshit@nutanix.com>
Cc: stable@vger.kernel.org
---
Changes in v3:
- Incorporated review comments from Juri around the commit message as
  well as around the comment regarding checks in find_lock_later_rq.
- Link to v2:
  https://lore.kernel.org/stable/20250317022325.52791-1-harshit@nutanix.com/

Changes in v2:
- As per Juri's suggestion, moved the check inside find_lock_later_rq
  similar to rt change. Here we distinguish among the push_dl_task
  caller vs dl_task_offline_migration by checking if the task is
  throttled or not.
- Fixed the commit message to refer to the rt change by title.
- Link to v1:
  https://lore.kernel.org/lkml/20250307204255.60640-1-harshit@nutanix.com/
---
 kernel/sched/deadline.c | 73 +++++++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 38e4537790af..e0c95f33e1ed 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2621,6 +2621,25 @@ static int find_later_rq(struct task_struct *task)
 	return -1;
 }
 
+static struct task_struct *pick_next_pushable_dl_task(struct rq *rq)
+{
+	struct task_struct *p;
+
+	if (!has_pushable_dl_tasks(rq))
+		return NULL;
+
+	p = __node_2_pdl(rb_first_cached(&rq->dl.pushable_dl_tasks_root));
+
+	WARN_ON_ONCE(rq->cpu != task_cpu(p));
+	WARN_ON_ONCE(task_current(rq, p));
+	WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
+
+	WARN_ON_ONCE(!task_on_rq_queued(p));
+	WARN_ON_ONCE(!dl_task(p));
+
+	return p;
+}
+
 /* Locks the rq it finds */
 static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 {
@@ -2648,12 +2667,37 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 
 		/* Retry if something changed. */
 		if (double_lock_balance(rq, later_rq)) {
-			if (unlikely(task_rq(task) != rq ||
+			/*
+			 * double_lock_balance had to release rq->lock, in the
+			 * meantime, task may no longer be fit to be migrated.
+			 * Check the following to ensure that the task is
+			 * still suitable for migration:
+			 * 1. It is possible the task was scheduled,
+			 *    migrate_disabled was set and then got preempted,
+			 *    so we must check the task migration disable
+			 *    flag.
+			 * 2. The CPU picked is in the task's affinity.
+			 * 3. For throttled task (dl_task_offline_migration),
+			 *    check the following:
+			 *    - the task is not on the rq anymore (it was
+			 *      migrated)
+			 *    - the task is not on CPU anymore
+			 *    - the task is still a dl task
+			 *    - the task is not queued on the rq anymore
+			 * 4. For the non-throttled task (push_dl_task), the
+			 *    check to ensure that this task is still at the
+			 *    head of the pushable tasks list is enough.
+			 */
+			if (unlikely(is_migration_disabled(task) ||
 				     !cpumask_test_cpu(later_rq->cpu, &task->cpus_mask) ||
-				     task_on_cpu(rq, task) ||
-				     !dl_task(task) ||
-				     is_migration_disabled(task) ||
-				     !task_on_rq_queued(task))) {
+				     (task->dl.dl_throttled &&
+				      (task_rq(task) != rq ||
+				       task_on_cpu(rq, task) ||
+				       !dl_task(task) ||
+				       !task_on_rq_queued(task))) ||
+				     (!task->dl.dl_throttled &&
+				      task != pick_next_pushable_dl_task(rq)))) {
+
 				double_unlock_balance(rq, later_rq);
 				later_rq = NULL;
 				break;
@@ -2676,25 +2720,6 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 	return later_rq;
 }
 
-static struct task_struct *pick_next_pushable_dl_task(struct rq *rq)
-{
-	struct task_struct *p;
-
-	if (!has_pushable_dl_tasks(rq))
-		return NULL;
-
-	p = __node_2_pdl(rb_first_cached(&rq->dl.pushable_dl_tasks_root));
-
-	WARN_ON_ONCE(rq->cpu != task_cpu(p));
-	WARN_ON_ONCE(task_current(rq, p));
-	WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
-
-	WARN_ON_ONCE(!task_on_rq_queued(p));
-	WARN_ON_ONCE(!dl_task(p));
-
-	return p;
-}
-
 /*
  * See if the non running -deadline tasks on this rq
  * can be sent to some other CPU where they can preempt
-- 
2.49.0.111.g5b97a56fa0


