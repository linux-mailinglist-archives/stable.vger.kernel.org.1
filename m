Return-Path: <stable+bounces-235345-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AI9gLhZe12kCNAgAu9opvQ
	(envelope-from <stable+bounces-235345-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 10:06:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B15013C7779
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 10:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 469843016B0C
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 08:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15F538D00B;
	Thu,  9 Apr 2026 08:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Zfav8y9m"
X-Original-To: stable@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011029.outbound.protection.outlook.com [40.107.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531F638C2DE;
	Thu,  9 Apr 2026 08:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775721963; cv=fail; b=SlhWoxzpNWIsykE2tXaG3DJR/x4qKu35DLDfV+4n34yvKqkqJ01WhXwfa1aZuAdNj42nKu4iC82d9i4lrunMdkbCDGE2Kqq9xAcqV87NQ62O/c3YI4WgeMry3PlF+AoCPzL90H2aZ05A3WCGxRqHDPHuTv1DlcGCQMKOrgRpVUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775721963; c=relaxed/simple;
	bh=gSVXUOk8Gb8AI+Wd9eE7cfKMjcG3LwNYw+ZWHZePPqA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=sgsmR887LcyRDNgQ7LvWefOOnajmEMZRYKlMrIaLiy2WdaHGYpOK6YhMaBwzrwPLBBmw68nW9zCn/X/Ax3M4UNSi2c5L6L/k7lSO7au4ytmZqxdO+qMSrdKrMF189lh7JDr9c6O+y+GFXPbLrz0Hq5DI1UmptskuJ5NpzLElt0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Zfav8y9m; arc=fail smtp.client-ip=40.107.130.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIquRdUQAW6aI4SaZ16zATdotfUZ+6P3pOiAyq/LpauSkgO9IInii9VXwkayYlQTbTTrSmtOR9KqT2DBEJX1vQ1wETWECvilavrmoA1NdBC19k1rVcDogFEf7vs/xPdga7i5P/EE/5Wk8WZHHGyXd31CnMADCboFh8aqlfsU2QBxFZLqtuSPSn+h+I/0FByaJskkwvUxb0rnCAEItyaR+MxNZwJ0BuPYdTJTA3MNGYqZg31QXpkbbGyxSQ6HNMJ+qhtNT+SOl0FINhhmjH2VCElth/1j4doQ3ykuj075EFNpjbp370lRb/yQT597YAond2ulxAfEIRP8mbVbXmyyaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lkzKJHQBvncJ6BOTDxqCwnvDX5bLq3psLJVMaQo6RY=;
 b=DlN/KRTUoCx0VKPYTLokveKXIPJ3x4XuIWV8hbyum8zQ2gs62CuJTFds+APxO6d+jdyLfR//of6ZU/O4h4I6RKN7ODr7PHdN2O37wlDzOtvW/eFldlzNtaHcPnL1p3UFXcr0GkHAJI2gihh/EWAEkqZsaF5/U7xFeT6jLJ8Jhr+fxCMFzT3SNgHfqVnucXSHy/4ciQJGXeQGns2gx4YUOgTh6P88z8sxQlUPMnS9E97WYLTR79BityM7/SgyRHLpvftlKCQ3lc8MXBS4uHLb0JOfNI9AlJX3jgy/DpaCsedOEGUihzWqdN2aNmtjQbihAe448Mzfbf8W9SWuZSDPsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lkzKJHQBvncJ6BOTDxqCwnvDX5bLq3psLJVMaQo6RY=;
 b=Zfav8y9ms+upE2cgZVniSV8Sdo2iRdyv6p25zGGTKjVEHAzI99ik2ZsJvKtEUFGUi1p47MfEDrkDi3CBkfar/IITy47MHD5Db/VDDSXp/I4GfO26K9LtEmG8m0OmPpe7G18eNjFo14sLD3XJ5vQBsfzQbRa3NMdnAmPS6CwBOup/j2J7MnjV7d4rKb8ol3tOoVa+SrPMQkxGfHj7mzscEBAYR35F963suTYJYrRenRPR92etvQW87zLUZkwWnUkXV7scQVzhvMtfRJgk3CvYPpu/S/efyMT3K9gbRzogTVxE63eY6VOT0vDU2kUwlnPZ4PDlTIpJwEQl3xLWJfPX8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB12452.eurprd04.prod.outlook.com (2603:10a6:10:609::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 08:05:57 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Thu, 9 Apr 2026
 08:05:57 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 09 Apr 2026 16:07:18 +0800
Subject: [PATCH v3 2/2] pmdomain: imx: Fix i.MX8MP VC8000E power up
 sequence
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-imx8mp-vc8000e-pm-v3-2-3e023eaa245b@nxp.com>
References: <20260409-imx8mp-vc8000e-pm-v3-0-3e023eaa245b@nxp.com>
In-Reply-To: <20260409-imx8mp-vc8000e-pm-v3-0-3e023eaa245b@nxp.com>
To: Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Daniel Baluta <daniel.baluta@nxp.com>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-ClientProxiedBy: MA5P287CA0245.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ae::7) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB12452:EE_
X-MS-Office365-Filtering-Correlation-Id: a017cf71-5d77-4290-c324-08de960ed46b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|52116014|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	2Nbr1SpIA9+IEPe7z/8mc6MSgcmpQQeXXAg3GwIFToQV6Wym++9fgDBZfkd+YlcfAJZQ3w7UvVBnHotfth7jNLQ9WSkqnFCYy76mrumdCJhz/7x2GQ7S+Su6KSoq0gcCeMaYQ6bWuTzOL4MlzizDtM+LTC/skoGSvqo++9mPT5pjmXRkTBC1o2cZdO1JWjwR2SF1aPcHu8Gbo3ipPPkDeuEBXNFVAGteProvu6HqX6H4qUdiJEHmmK0CSzB0v5jbTL9q5EWKKTDlPWq8hsEHh+Qto76oL6AN0WaWvb86CPWKvOAyiyPMBq8rlKSqfbFnxA7u6ruL0LXoptkL4zMZJyxpmSBCGuJmqebn9bTILYXK8SQTE3v4+CN6bpsGsRC1vJummVzYuXkhQuLs6U/iX5ISKTO8AcHZMG7jw3pZSTqYg2eL7FIYr7L03IWDbEun7Ly35FJxnabyffYWl4QysfItAf/nz6L0OAPF7TPZeGBB7xJKHKODrxsvmC4EjsauvH3nkR8nTwrmW/HByy3d2OqfaQV7uinl8xXVI/2PjRPmjrXUQGW5b6JpCTVRlABPT6XMy7XTXcK4YvyaTGlVjIp/nbf1vmtaCCTSh3DdDaNbNoqnMCEPmFVGBufAfrPZuAuqllWfy48jTaFeJ9W82DCLApc7pt4XtnzQSy2cztqHXU5FWIWKx56evAoRKeeGeSJiQYv5iRSeGyf5t29+uOX4j2B0EnI+S8QG/yYIcwVMEH0eIsZqVw8rjkRmf+ASAuc+LA+hoSEbChcrUM3cBpATh0f+0ESS1D/UaX0GE4g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(52116014)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEJuYTFFYU1VeHhTclg3VWlwRUNoUUVRK0Z1RnQvVWtwd2hORUZ4TFF1bVF1?=
 =?utf-8?B?UHJJWGo4d0hrVVlkUWNoVURpZXJ3Y09ZanlJcU5CVWN0K1JpZS9CRG1HWXZ0?=
 =?utf-8?B?U2IzU2N4SkhsMHNtS2ZtWW9XT1BpK1pPc0JaTWYxcEdmRDRGRjA5elV5MEdT?=
 =?utf-8?B?TFNpN0JaWnVKMDNGdEJZck9NRW9EeTlaUGZBZDRPS1o4eVpMZWt0TFh0YmxQ?=
 =?utf-8?B?MVhEUUZ4SzR6enM0ZzJmc1VPR3pNY2cvNWp1S3lSYW55dDMyNTlPNGgzeDNT?=
 =?utf-8?B?UHRNQ04yZ2U5NEpqNjk5VXVkcGsyYU8wRTlhOFRjaUljVjEwdFdlazVyUWVX?=
 =?utf-8?B?VWxKbG1TNzh1bjZraHZmQVJZaWJPc2JzRHpVS3NUbUVvRnB6dUpoZHRqQk5i?=
 =?utf-8?B?bmRSSTVoalAvQXhiSTlOVnIya2hVTm9xRUFBemlEaFY2dWE4RjBKWVhJcUFi?=
 =?utf-8?B?TE05aFFXV3VKMkxkcGZMRHdZbVp4bUxTYnBMT1NpbWl0VVgvV0JQRjVJWmE5?=
 =?utf-8?B?NDE4ODZNdTJyYzB1dFhhdUY5UjdxK3N1amhlZ05oNkxKZXhsWlBHckV0UUdi?=
 =?utf-8?B?Ymh1SkZ4dzNRUFZQQ0ozYmpLZFdZWTg0SjdOS2RMWVhvS2MydzZmM2w2Z0px?=
 =?utf-8?B?Snk0Mzg3Q1J4VmVvVHFlemZZZk04VDFuMXRPOXIzTFZRenFIOTZnT1RJQk9t?=
 =?utf-8?B?Q2xhL1ZYN2doVlBFTGxJdFdpTkRjRk5HNDh5Y091RE9TMG52TVdlZXBFSm5y?=
 =?utf-8?B?Z3RmQ3JUMDlKd1BaMzZEY3FTM01aRDZ1aW1YelFWTGhwdGx5SncyZ2xCMll2?=
 =?utf-8?B?WVZZaGtDbTZSOVRKWmNRL1g0ZUllWExxclhQTlhmL25SY1NYNTAvVGJpK0Vh?=
 =?utf-8?B?K1d4ZlZwN2lleHN5NWtqYlNISC9maEVUUGRhdFFoNHBtd0o4SXFaajFkZVNy?=
 =?utf-8?B?eVgvS1pENGhMRWVGeEJkWjJsUFFvc2hodk15N2hHeUhwMEhKZER5TUdoVlFk?=
 =?utf-8?B?M0xFdU1aaVFybDhxbWNwajVZYUxld2ZzV1FoMHMzREdEeTlOMHRvTWtheE4x?=
 =?utf-8?B?bjZSM0RBaUZYY2pDVmJ5UGh6eTZHbnI3YnJWSXNvT3Q3R2hLV1R5bUg4UU4x?=
 =?utf-8?B?MkUrUXJDMHZYdjYwR0hxU0JVSDk0SG5WbWtUVURrSWNhU3YwSER2Mk5sSEZr?=
 =?utf-8?B?OXhvREVwUzRRM1FzK0RueGs5NDVTZFBLZGI0Y0xnZlhKaWphazNxb1VXbmZ5?=
 =?utf-8?B?YUhkYWZ1Y0lZb2RqcHhmcXhsejVvVEJYbkdGREhwcnA5aG5IL29PRU9HYkM1?=
 =?utf-8?B?dG4ydWdXdnNHNmx4UkNlR2pGVXlycDB3MENhV0VIUXpPNTJqK1ZZbWljNkcw?=
 =?utf-8?B?akhBYXc5ZEtHQnJQQWowWG83bUQ1QTU0blFKQ3J0OUhGbm5EZ0lwelNUNVRi?=
 =?utf-8?B?VDUwcXNwcytGZitidDNMd25rNEtmNVkwRVdCak44ZXdqV1I1aENuRU1RZFVV?=
 =?utf-8?B?TkVzTFRqdlVEendOSW5RSVQyR3VhbDQzampMZVdWd1lVU3BMYU5Qc3ZwN2Nr?=
 =?utf-8?B?SkhUbERUZ1lmc2tiMUM4VVVUcm1ESUdKSTdvaXNSSERhd1IyVkJFMytEMWlB?=
 =?utf-8?B?ZW9pbkxCaHE2Q1duM0Vna0dod2Z1YVBGbWU2Nk0yZXNJdll2WDg5QzNnVkFW?=
 =?utf-8?B?Y050NmVLWENHUVhGTFVCdC94WXBRWHA3WktrMjBOSVEvdDdJNFF5NmVRcyt2?=
 =?utf-8?B?ejQ2bVpxVkVUQit5ci9ZYTdyRy9yK2RnR3FRZmVUNy9PTjNYcVlkcExVbThh?=
 =?utf-8?B?Z253dUQxdWRLdHVvaUJXM3VwRzVTdjJsTmFKeVRuay9oc05CTDJXWHo0bDdp?=
 =?utf-8?B?OGNURURmaFhUcGVGZ1l2Sys2L0dGMVZ4a2RqOElvNkVDajlnZ2NjeUVuVGty?=
 =?utf-8?B?ZlZEcXB4VjQxU29GUWtOTjBXVlJ6aXJ6d2VvNmhlK0EzT1Z2a1dzWUFlZDZ3?=
 =?utf-8?B?VnYxMjdDbUlZTU1DeUFLYktsQkxQV3NVb2NIOHBKd3F6dXNIdC9aRFliWUlF?=
 =?utf-8?B?VXY4eTNLZUdzMC8raHZiNWN3R2poZXhkQ04zQnJWdUliMzJLbytzckhxTkpO?=
 =?utf-8?B?T05xeVhONEFZNXkxdnpiRlRUMlZudEpCaE1TaWtpclBqWHVzSWdpd21CckxX?=
 =?utf-8?B?U3o2b1FHdUhpSkRVQ1daSmZtd3lCS3ppbDRnQktYN2JNT0xhakhvemRWK3VW?=
 =?utf-8?B?dzdESTk4VWhGQk9EVStaN2FEbVFLMGc4VSs2UVJZZ2VNUnNqcjZ3d0djL2I4?=
 =?utf-8?B?UjRoTld6SDYvS3lDVDhuZ1phakdXNXVoNzZUZWp5bzZYUTlidHlydz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a017cf71-5d77-4290-c324-08de960ed46b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 08:05:57.1903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7NglUoqhRQ39bQrTUMBD/kJ0lvxTbz7tuchqG4bwNbkQ3mrasT5B6qCiZEdY8euGL/yLbGI5EXs6Bse2SWmRLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB12452
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235345-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peng.fan@oss.nxp.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: B15013C7779
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Peng Fan <peng.fan@nxp.com>

Per errata[1]:
ERR050531: VPU_NOC power down handshake may hang during VC8000E/VPUMIX
power up/down cycling.
Description: VC8000E reset de-assertion edge and AXI clock may have a
timing issue.
Workaround: Set bit2 (vc8000e_clk_en) of BLK_CLK_EN_CSR to 0 to gate off
both AXI clock and VC8000E clock sent to VC8000E and AXI clock sent to
VPU_NOC m_v_2 interface during VC8000E power up(VC8000E reset is
de-asserted by HW)

Add a bool variable is_errata_err050531 in
'struct imx8m_blk_ctrl_domain_data' to represent whether the workaround
is needed. If is_errata_err050531 is true, first clear the clk before
powering up gpc, then enable the clk after powering up gpc.

[1] https://www.nxp.com/webapp/Download?colCode=IMX8MP_1P33A

Fixes: a1a5f15f7f6cb ("soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl")
Cc: stable@vger.kernel.org
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pmdomain/imx/imx8m-blk-ctrl.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
index e13a47eeed75d7189aa15370a7bee4cceb05a1d6..1cd0a22ce3e533358dd7449da9989162b36c5fe6 100644
--- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
@@ -54,6 +54,15 @@ struct imx8m_blk_ctrl_domain_data {
 	 * register.
 	 */
 	u32 mipi_phy_rst_mask;
+
+	/*
+	 * VC8000E reset de-assertion edge and AXI clock may have a timing issue.
+	 * Workaround: Set bit2 (vc8000e_clk_en) of BLK_CLK_EN_CSR to 0 to gate off
+	 * both AXI clock and VC8000E clock sent to VC8000E and AXI clock sent to
+	 * VPU_NOC m_v_2 interface during VC8000E power up(VC8000E reset is
+	 * de-asserted by HW)
+	 */
+	bool is_errata_err050531;
 };
 
 #define DOMAIN_MAX_CLKS 4
@@ -108,7 +117,11 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 		dev_err(bc->dev, "failed to enable clocks\n");
 		goto bus_put;
 	}
-	regmap_set_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
+
+	if (data->is_errata_err050531)
+		regmap_clear_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
+	else
+		regmap_set_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
 
 	/* power up upstream GPC domain */
 	ret = pm_runtime_get_sync(domain->power_dev);
@@ -117,6 +130,9 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 		goto clk_disable;
 	}
 
+	if (data->is_errata_err050531)
+		regmap_set_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
+
 	/* wait for reset to propagate */
 	udelay(5);
 

-- 
2.37.1


