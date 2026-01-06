Return-Path: <stable+bounces-205107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EEDCF90DD
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 16:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DABE30194DA
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 15:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7B6315D48;
	Tue,  6 Jan 2026 15:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="S+dCEyqI";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="tM5KF5uW"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991E81D7E42
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 15:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767712599; cv=fail; b=bbZ4/Zgrr+KFp0B5PNSttQpp/eWH0O+AsSW2ZyhUoiyojIMBFo2sNwvHKHUIvee2BWiAmyBmC4A6dWGkaMmLeRL12mcDB1mbB6jPqN0nqWG9zj8vG/Nm0MuruYBcLd28hU0ZcGKkickvZ0cRNowF2K6AoI87Vz5FRswLl0/0+h8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767712599; c=relaxed/simple;
	bh=ZbixKK6VyhBDx0GVQYjvGmk1iia2H5VbHH+Gk8aatN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOtdJBHOXxmjOLN/KpXn21v4Y7JuqQ0hwhW5CiP2Sw5xVQAkR2fuPAwkN/cpKiiehCBniLJDyamddHqJCMNWc59xMAoDgdOBAvieIM1qJ8ZfcJN6KUXxNomeVMxGf0GR9Id5zrzwzHweHOD0m5h8QNptcMA8OrahkSAaPfvIwLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=S+dCEyqI; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=tM5KF5uW; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6066h3Lc467585;
	Tue, 6 Jan 2026 09:16:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=46bDzcIq/JP5Eqwex1
	wi9lXz0mzv4xXQ9xfUfwXOFVE=; b=S+dCEyqIUJvOdptTVJN+mW7uS3TAMCmMYZ
	4xy7Jstp2DLTtsAQP/PeyX6XH6JWm4NcNS8Seu2PS6gDwN97S+0GwpGH+fLgdQiR
	aBIY4japPxLj9VgLK0OZoSHNOWRzANBCJAAK1wYeYNCXFO0UR4G3Eec6Bqq+kje9
	cw0SpjayDgAtYDxXZf4gk61cjt/eVlGNy//XVYkNw9JKodCc/2of0fRuXb0fVWcy
	14qhZyr69cXshLq91YlJSJIAQnIMAMZaHZkHVMFa9gQ2dAMGh3ul2P/+e+Fgd+Ek
	ph1y8RkjFU5eT5iJyR7t8deDn0qO7y6jo4FXc+2WGcnNqrgvAYDQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11023105.outbound.protection.outlook.com [40.93.201.105])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4bf0dnu467-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Jan 2026 09:16:33 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWzoYTxYrLom39ZNTc3/keYyX+K1Hx8YzMqPgoUTsiAlSF19CdELCEeI4LpokLe99XpgSe6eOc7euDl5TsZovYhPLNBgJ5bv+sJxDYr7YDqtKlAybxBfBaQE40Is7LGTagGdM2ILT2vNNmffZxy4zlEWaMqIK7tol8j/jUgxlxd+pPFEjlFEgcDOdk29hv22oFX5uUpjhnH7E2/mQ8uOxP7FwI7IYSeBKHmYaTEQLqKQEBF2lRmfIcPtXTnHIIyP7DxS5S7dYEI9TkGLWuF9WyNx/OWROfO85oQaHtuiuPS2edUSZhMlXhsKOD/I3TgzHDUywjck4LnqmvPheBHgRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46bDzcIq/JP5Eqwex1wi9lXz0mzv4xXQ9xfUfwXOFVE=;
 b=XJ0PEl0WBOvYzsz/1dejxRfeXeq2lSIowSb9AAIfbOXzUBdJNWCTqpeLQaKBSfXADBd0CdFO4QmuYaHqY1krOHuRNTTi/Zts7rIqCGtRrzmwDGaT7Y1XDT6cpSnYBEoyE9nP87Nourl2clBIRcgVSJf7uOBG6v/km7v8K7nNpItHeafRIXLuBgxiUwXtb63a6tbm5WlD8pir/K0atz/lMPt98yvBC98936hxCUHWMGuGJH1fskjOEME1n3Q0ULd2yTGYQRzU3sxJbVZ9t/vM9sgDY9s1X/3IogHyrgXk/ucTEqFQxKlIW7KB6sSylIaaiRyN+mBIjqP7hYOpJxNqsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46bDzcIq/JP5Eqwex1wi9lXz0mzv4xXQ9xfUfwXOFVE=;
 b=tM5KF5uWNSOy1Sn537OQ2VT++5/Ncoo0fNctKdjBdIQKHX7uhMIag+SyUz8SX4gqp6Pi9w2GvJ7RlNsOemW6ebfvk25eTxF8d0wPGDBx0em20djgx0UXmoJp6nfH/LhpFZCuVvR8I7ZgJcVlpG8wJ8AC/JIVIDzvsWr9hh3I2xk=
Received: from SN1PR12CA0107.namprd12.prod.outlook.com (2603:10b6:802:21::42)
 by DM4PR19MB6025.namprd19.prod.outlook.com (2603:10b6:8:6c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Tue, 6 Jan
 2026 15:16:29 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:802:21:cafe::ff) by SN1PR12CA0107.outlook.office365.com
 (2603:10b6:802:21::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Tue, 6
 Jan 2026 15:16:28 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1
 via Frontend Transport; Tue, 6 Jan 2026 15:16:27 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 26C7F40654A;
	Tue,  6 Jan 2026 15:16:26 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 175BC820249;
	Tue,  6 Jan 2026 15:16:26 +0000 (UTC)
Date: Tue, 6 Jan 2026 15:16:25 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
        patches@opensource.cirrus.com
Subject: Re: [PATCH RESEND] Revert "gpio: swnode: don't use the swnode's name
 as the key for GPIO lookup"
Message-ID: <aV0nSXu7kKGZTSsP@opensource.cirrus.com>
References: <20260106111838.1360888-1-ckeepax@opensource.cirrus.com>
 <2026010637-slightly-regulator-76d9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026010637-slightly-regulator-76d9@gregkh>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|DM4PR19MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: 801222f6-9a8f-4215-de8d-08de4d369021
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|61400799027|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qRem01U4QFYk5gdOWTqKKnGyBUbUl1gueGyrIrrzVGUljbpO6duCj5f2Sl0h?=
 =?us-ascii?Q?UOdIvY128gFTR0lOZC9akzoWG6ym0vaQExaC2GTVxf/WnsBL+B8wdqvGPV0K?=
 =?us-ascii?Q?qGOgO6SfV4fEMaS4cX978PQJvLIbt955djj5doEe5fexPuNZVMS9sdhavK4b?=
 =?us-ascii?Q?ITfLwxCLlQL3XTVpBIgqVOlcZ21ynV1iSize6UnLaTSDBsglqFb8yddkYusJ?=
 =?us-ascii?Q?T4/4AEQT87ImS2yYmXePyCxwR63RwpA/lQFXJSxnRh1yA4feTCtzPQ9OKmue?=
 =?us-ascii?Q?dUL2J5zgMvtzk6K8w5lpLgvrZ2c8OXzSp+RXSLkGHINMicySrK42jtcEUr20?=
 =?us-ascii?Q?gQctYwlXS0b3DTLyVVrVmWzPnWx0+MyNCni4gADL++5bbhpluuCn7eZ9LoF3?=
 =?us-ascii?Q?fWuilCQ3eobaYArYj4hw0lPC4t0F1DAgUPKiGQH1C1Yv2T32H1nGeSmn+xP4?=
 =?us-ascii?Q?jzsgHD1IC6ib5knZvoxmzoJDIW1ISB1xMMchIgLfYQGUVp2C1wNdQy2zktBu?=
 =?us-ascii?Q?060fLZ4boG8RTkPawH5bwj46X2rLGnYnY+Dz3QFFbGTZiV0lNEO2dxnFOsiv?=
 =?us-ascii?Q?pM2BDAedGdsqiNVgga+xgduu/DWNxKwg53F3vNIvg3P6iya+bzKmIzMZzTBC?=
 =?us-ascii?Q?mcR86BS1iWJ1h6x6Q3jeaXSDPs2eTcGgjh24vxHFDsgiz0j87oT17SlvGvxA?=
 =?us-ascii?Q?n5DSSo/+vZpRzARgh1D1ZwTMg0lDG6XXm/2oF1LpZZ+19cGpM80B8Dpr90WF?=
 =?us-ascii?Q?FLp34yYgre2r2wMklmBzeqJaabxK6edj6XgbwH6ngvEayedX5y626CZDJEMW?=
 =?us-ascii?Q?MO7f7MmBRkemk+lC5WdqQ0KTJZ4ExwwJcMYuUjdmoR9uTDzwUXwmsN9u2liE?=
 =?us-ascii?Q?QwWBZ3eSK3llg3Q0Ojd08GvJFJWPo1ByS7Y+oj3ALSVUU+ZOjbPgLsi74bN1?=
 =?us-ascii?Q?YM0nU7/S7IMV+rzIZXY2GvxnY8ThOnn+vby5YVKkiOEv93UYXKxyfnW7BL+B?=
 =?us-ascii?Q?kKpIsOBUgiXdID/a1dhkV66JMtUurGqz1Ic5Srn8GI2uHsdSu/g0gFj8Nxt8?=
 =?us-ascii?Q?c+9QUIbWGyoLPeMeM3SnZjBaQLnHw6wwvU7k+7TT9lRJwJa241LV0PQtMWoN?=
 =?us-ascii?Q?/y7RKI88VbLO6MTzLq2I7OyvsrsriNrjucA+l6hASSwWJBG51qVHqYKtrQHc?=
 =?us-ascii?Q?42U1zr3nK5tqffHPA7M/2hhcgttwnk05Y0hlHet+s8BAgOy/GdlYLSK92SRT?=
 =?us-ascii?Q?zsQZGiPaBaSwUR9+iCWbhl8HzGsrVHNPOSiCvEQcseuCPbM6QbLEF/l+J0Xb?=
 =?us-ascii?Q?J2itxxLgWFrfdB6oJ6OVIx+iDlhXgoXosXKIB+zw1dfRripVRv/S/SttoqQd?=
 =?us-ascii?Q?DkRF9m44KLqxJqSeq5WtRDu74tO/mjpPSEImZgHnDNXf9rO4YHisqXXMI2Bh?=
 =?us-ascii?Q?+8PH8BzA6zf8QoMrJ8EEqEi+zQSnsYdlxTmTNE1sKNYljaAUoWS9wHl31iQQ?=
 =?us-ascii?Q?ZkRR2mBa88eLsIz3LdXz9X2Qt2q830tp4SwE5vBeZc8uOSHrTk+oNqztrDh8?=
 =?us-ascii?Q?Ki3JwVDqsJrMPOsHLLo=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(61400799027)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 15:16:27.2184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 801222f6-9a8f-4215-de8d-08de4d369021
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB6025
X-Proofpoint-GUID: 398XNKbLVZLwnPWfkj0o0Qe_XSuUGfax
X-Proofpoint-ORIG-GUID: 398XNKbLVZLwnPWfkj0o0Qe_XSuUGfax
X-Authority-Analysis: v=2.4 cv=FscIPmrq c=1 sm=1 tr=0 ts=695d2751 cx=c_pps
 a=hloNlEDlI3+XEZKeHTbqpA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=O_mYIUxG9PxvoMOS:21 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=s63m1ICgrNkA:10
 a=RWc_ulEos4gA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=NEAV23lmAAAA:8 a=w1d2syhTAAAA:8 a=g20hN0BGJh0_pkZbEd0A:9 a=CjuIK1q_8ugA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEzMyBTYWx0ZWRfXwDC2tDpjfiCp
 GOOrI4hGX9YK7F1VmcisRhCLxPqhiBfVLuK2ZsaWjr89DMazJgcAqXpJm3sIuDCvbXP8MTTw8My
 LhEdG8NfMh5wEYh+YTvSiEB+Mn1tgQcq6nP1GIyqBuUfQJqIvfeTebXpIvCmIJy3aaPyHrVyBhg
 Ei7Qv3Yhz0BKOnprFVMOt7S3vgCjWP+VfmcEfYfrPzlzjuZiVFbDI8lLVEi8P6RNNxuJGjxH2Iq
 0TsAI78HK9K8JPpvmeO4cdrGdpFtWIogv/kmmovYGm2VrSxC21hr1PiA38jLU0BRXpStbPxmFs1
 UNVGuYz4xkHl2Nu9gvu6Q1S5qrRxmfGe4fBLv2+kNfHQcsPEAauCXstbIx1Y3eKy+1C3wf5MXx6
 pxTDRAuFIoYas15SY5KTxHd8mXVlK4hazh5oliPkRuHIKyBQgWQ0oJ5KSt/0ft7jRq8QinaiDbr
 OaTZLnhxybrEwRatGGQ==
X-Proofpoint-Spam-Reason: safe

On Tue, Jan 06, 2026 at 03:42:13PM +0100, Greg KH wrote:
> On Tue, Jan 06, 2026 at 11:18:38AM +0000, Charles Keepax wrote:
> > This reverts commit 25decf0469d4c91d90aa2e28d996aed276bfc622.
> 
> For 6.18?  There is no such commit in that branch :(
> 
> Shouldn't it be e5d527be7e6984882306b49c067f1fec18920735?
> 
> > 
> > This software node change doesn't actually fix any current issues
> > with the kernel, it is an improvement to the lookup process rather
> > than fixing a live bug. It also causes a couple of regressions with
> > shipping laptops, which relied on the label based lookup.
> > 
> > There is a fix for the regressions in mainline, the first 5 patches
> > of [1]. However, those patches are fairly substantial changes and
> > given the patch causing the regression doesn't actually fix a bug
> > it seems better to just revert it in stable.
> > 
> > CC: stable@vger.kernel.org # 6.18
> > Link: https://lore.kernel.org/linux-sound/20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org/ [1]
> > Closes: https://github.com/thesofproject/linux/issues/5599
> > Closes: https://github.com/thesofproject/linux/issues/5603
> > Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > ---
> > 
> > This fix for the software node lookups is also required on 6.18 stable,
> > see the discussion for 6.12/6.17 in [2] for why we are doing a revert
> > rather than backporting the other fixes. The "full" fixes are merged in
> > 6.19 so this should be the last kernel we need to push this revert onto.
> 
> Can you resend with the proper commit id in it?
> 

Apologies I will fix that up and do a v2.

Thanks,
Charles

