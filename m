Return-Path: <stable+bounces-225848-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGgNMLw9uWkowQEAu9opvQ
	(envelope-from <stable+bounces-225848-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:40:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D00D2A9136
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9D3630D7064
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E13F3ACA70;
	Tue, 17 Mar 2026 11:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="nmpAYn6p";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="e2a8Q4Kp"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E10145355;
	Tue, 17 Mar 2026 11:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773747442; cv=fail; b=ADjwEHP6PAl8uqBAczGxh2DHGqMclDG74RpKyKTvthRMP6WOQhwvA1084443R0KJLxC3aZ4K8z+2/qpJqs6lyh3KuFZCho5EMBdo3KwqRVYF13a3Gmfyz8XL989XiiUmBBtlO45PIpIM6HnpVmKPKhIxqeYAxTJnOZCxH53XBEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773747442; c=relaxed/simple;
	bh=Y1ADQVpBc2msktS8L/EIgpm7MfJQo3rDpQxcaxTWFIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fic73wjDCNbRwXKsvX0n7/TYn259Qmun9dDSBz17Av0sf8fInrv12500JffbwTqYj7aWmmUePR0/YBvW/UC+OUtSRZMO62Ia4NRUcJzG4z98jCkwfE4K4gvqis9iHRQ85BFp10OHaK5AWiwPvuvSm0MNcNnIL8/WBbpZR1v998U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=nmpAYn6p; dkim=fail (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=e2a8Q4Kp reason="signature verification failed"; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GMR8aL180856;
	Tue, 17 Mar 2026 06:36:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=70AxM27yLv7DIW7scXNpgCr8FGLZ9WyL8YqResIQvQ0=; b=
	nmpAYn6pv5c8zlF1GOHt4/geMFeD53ebzl+EZh5cX6Wf8o7CASnAUdvxErhiDFxz
	GN/FnV+6qbRCzqflNTTVD08RgDAAfN9KrwMzlxguMrL+NdIZzEzK4j8ZcyjMq853
	EPkCMC2jivDbauAIHewsIboqyrDsAhjs23TwNU7JaUpgwGPShzu/+pxDcJCO4qMD
	Zry/Guz8YlmHY/8ibU8IWArBOEMa697zQrFxhm/YgFV00jYpnbd3EBKFFJX5twBj
	Ix2wkzCugZ2JzzsD+H4FHqPS9gBZ9XfiABtn1sWpdZ/ErxLH9IP2PxOjdQv5BeDj
	a2QrnC9SAFTkNBE5D6+73Q==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020110.outbound.protection.outlook.com [52.101.46.110])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4cw43f3efb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 06:36:58 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d5CWrTC+GqMeij4q0kcry7HMO14fpXFVR+hqRJ7RyiF563+H+DzfZj8jYfWWouV0JGpXnagDzDO4mUIJSbR1hAQ+CUD2eIhSZcXfX1AUF+JWxGasCGXbYybWcT8o5YXIs+ojq8l61JdiFLr4YFEblkAK1fTrcdW9vjB+8Ur6KfNvEng0IZ19pykP8Aws1hMfxq0blikatV9eGEKqh1ocQAHIkO9cYZnVz/W/7Bkw3o+n12A4RfajQXfR9NnQdVaNVjcABMN/FPMY0kXCPWbcg+NlPHMDvAtiEceWN+zatzoguMSArdY2PK9s/99n607bHuev9U+lPphF9NNBNTRp3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hjrh/zmhO19sJRLRx5gOFv4+daOlQbKacnrAI5WLSM=;
 b=d9mYnTuLM1ZL022axPu/7xQJoWxJUMERLLOdAgK8ParnlZ4zGI4oXp7iL6DX1HGc3GH/p2L72++IF2y7YhAbzdUR4S79WisCgj3XMzMi2CI1BAePl1BOSKZaE6jg9jNp6df+GVT9mah16OpM5XxzApBel4J2KdJW/dW20SO8YXYpG3Q04hc3Lnnawr76lDR2gg0dTwJmqme/jwtlT7lEYYttoz8MD/57NT+yAM972QIV94WzZZ9BxyrrHOtD14zVXByBPqPZV5rJSmDEkgW3zldHpsnO/TFxKb07+aNHpzjNpK8lwxKcuimJPBb0M7fG8isGr3kL8z0JmHtLMmYzWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hjrh/zmhO19sJRLRx5gOFv4+daOlQbKacnrAI5WLSM=;
 b=e2a8Q4KpVKeRg4bwEiI0arR3lkVBYHGQkivNGH9TcqG8Roz/ckFquzZZobUB1eGIe7HK8okcdKayfTkj7DaUcr/T6prPyYzXxloNrYDFk7WeJdbvjpJ3BBC/ZaGGPPIRGkCJxCDhQLKzGztGGXa0ialUYjR9l5boo7ypRnaKi0I=
Received: from SJ0PR03CA0132.namprd03.prod.outlook.com (2603:10b6:a03:33c::17)
 by SN7PR19MB6993.namprd19.prod.outlook.com (2603:10b6:806:2a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 11:36:54 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:a03:33c:cafe::35) by SJ0PR03CA0132.outlook.office365.com
 (2603:10b6:a03:33c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Tue,
 17 Mar 2026 11:36:54 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.0
 via Frontend Transport; Tue, 17 Mar 2026 11:36:52 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 65CEF406540;
	Tue, 17 Mar 2026 11:36:51 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 5112D820247;
	Tue, 17 Mar 2026 11:36:51 +0000 (UTC)
Date: Tue, 17 Mar 2026 11:36:50 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, david.rhodes@cirrus.com,
        rf@opensource.cirrus.com, linux-sound@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: cs42l43-jack: Remove manual pm_runtime get/put
 from tip_sense_work
Message-ID: <abk80goNqPi/zVxY@opensource.cirrus.com>
References: <20260316124924.31047-1-peter.ujfalusi@linux.intel.com>
 <abgTWxI1Q9M1o+ka@opensource.cirrus.com>
 <d5353ee4-1a3f-43a6-93ed-5127d666ad0b@linux.intel.com>
 <abgyboHV1jaWDUul@opensource.cirrus.com>
 <f461ba8a-4208-4dfa-aa70-e2c85ec2050a@linux.intel.com>
 <52c48bf9-7fee-4c87-bf06-a9a7ebc8536f@linux.intel.com>
 <aeb25088-6ed0-4011-9804-40d9b285dff9@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aeb25088-6ed0-4011-9804-40d9b285dff9@linux.intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|SN7PR19MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: 844d81a2-d666-436d-07d5-08de84197c96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|36860700016|376014|16102099003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	3b8LQ8w8SygeZzRTktpi1T7eG+bmr9YmLjMN/Hyjlmo31urJHyRaRw5snsrkogVecaZxpCs/P7EcCOa+9inNBxkMpcMiI2XztgvdqkT5TGx0rgkMNuXVFSdlzEZcoCr79N1X0XZhYzqEru/XRqucofNIXRT/2os5n5zsRV5PXK3iZvwdWWQAYxJNlSUf28zDl+tFw8bFoxBbrrMWcA8laL0BGglIzTh68/z2c6+l7H3WKLDkJ36OLSScury54P/wEGNqv6h2sAxRUFMyZcU8BNanruiaN4ISoVuI0852cdVA7UE0Z8E/ka1ZuMA7S4RDn6jczE1eJxE14ZSRCCikckOAftMXf05/RfrOiEbXCB9oBffz8QrLr2PVkPjMEfWqEOI+tF5HfrA5XUoX/Bohndkk1lpNbNPJwWs4sNqmXIHMFv1Yizkzyjvsq2nxTUcMRoFVtjLwRWwLsNvHm+HxwXRFnj/Twg3Qyyre6p7nLviUV8GjjMD9Z6TbOIhFKkmxwtMjdnlMgGEVrmhbcTW3wNHz7kNUpR34wJBQ7nZuwgokqHroJ+zYRylB6yAkR1PMSpYKvHiEhd2Z/+mQVMpEcbWi9ox3y/BLXA5swzONGcoZKkSFvtXoU2GiCAkBVhchsw1YtnYqKcSXVRwONkfp7CUZPtCWhEx3MgaRZFjCy4sTN+LfmTIWt7fY6Yn3eDr2Y5BQtRCtcdgpI1KUlwdgwn4TwIwm5oxI50Pd+RTfqnqHmsY0hiV2h06+0Rc3TBvhLY+bdJoUL++nr3uUHnHJMw==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(36860700016)(376014)(16102099003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3L7vfH3jq/vui7YR7+M8XFVWhqf9NCUZwuq/lxE7e8cfSl9JmRb4AGNUi568dpMq+iG/+Zs9q4ydfA4XFWH5SSrvlpbbR+6dOuit7oGL2Wm6LsoEQAS48LhTtHTCAFmRGFk6lSeicgR97TwLOqxgy9kVq2ocm3GeS2dcvzOoYu4DvYEUBB8zeEni8i2UT9Ws3LjbeizMcV+ktsbnYCamNFrqDHxKCX8jUPI7ae4/Q91cCBBfKXqYW8j4WQmz0RBgt3Htq+Cw/XFKit49bXayen6O2cnac90SqVi9zFLp8j0VDpytcJL1BWt0L1D7ow8a31AAzsiidENsqPyjo+EJ7NN6xCtlsTqJBQxl05wPh84Chn+qjvYPpicv1Mm/a6v4b4xOF3oyEoNv7hfLFEQNdYjpKL+AYN+mo5+tPogCztQSdBQYnen+p8a7thKv2nec
X-Exchange-RoutingPolicyChecked:
	Qk8f+SWbZAbzMzKQ09MrxqSNhGLiLXIKYRqt/DRxjQFNlkQL0Gn8Bkqd19GEPiWlBo1o2hreC37Dj8M3AGUk2bsA/yxCNWaYh5nnRLzGg84Tv264E+qRUhGlXk2rPPIkpfeRfaXmo9PUqd8oFH69hP3WbxxTHzQcA/PiXXCrU4VB5TaTPCEiL0xgcgpmTLm+BnpJT1miXcddpKW6HRBvo0F53EuhWcSaRf2surLdEuK9CdjmMgREm7T6/HBcFwwxJYwB84YywD34J1e41CW1dhDrgyjlHMbc3GS7zj9oidly5OmgHQzp8+WjYcQAF4oomJF0nYPON1KV5kn9aurzZg==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 11:36:52.9043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 844d81a2-d666-436d-07d5-08de84197c96
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB6993
X-Authority-Analysis: v=2.4 cv=YqQChoYX c=1 sm=1 tr=0 ts=69b93cda cx=c_pps
 a=GpMrALTSj0NtuSyXwlNXWg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=VPE3gVeM2qeaeJ4bcwMA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEwMyBTYWx0ZWRfX4j0B5hgW2M8M
 sL6K7FmJOXtupfwk2pCghvpXl20/XT4wc2hr0fsYxTP7qakR+GwWyVpHtKQlzW8PbgQdpsidQ2s
 a/8cIoCtG3Hz7p/G2/qKrcLpBfZPHBee5EJAvwVBc6cJnscLekfuDA2DtjYoDba1KElpo7HmxAQ
 bkXOaqB6AVsHFDxQWEG2lAt8VSDWoIV5Lns+9+GbdHLvLd7LAKMX3/AeiCDtIjJJOlY+XQOtnmE
 ooz2qrNb9QeKq1RB2p3Q+6V049jxQCVYyDpvtv887UPfh/Z7tZtu5va/hGw3lGxQpiZljWJMxyL
 mjIFCXJ/2GcRwP1CmAki+/FojhsVHMi/XfHW3/1factJB53Y1LFSL12Xss1iU9Bgu1PLenZ917S
 aSom1DLubrB4nx1zeNN2GW4igI95TRSMMnVpgsQP6D4+eAAVquQl8KMsaOY+62HPHSw7e8I5d3h
 OBzXgIz8PQHI3LaPykw==
X-Proofpoint-ORIG-GUID: gTb5rjGZPvYLwqUn1fPJqkFc-LfW--6U
X-Proofpoint-GUID: gTb5rjGZPvYLwqUn1fPJqkFc-LfW--6U
X-Proofpoint-Spam-Reason: safe
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[cirrus.com:s=PODMain02222019];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,cirrus.com,opensource.cirrus.com,vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[cirrus.com,reject];
	R_DKIM_REJECT(0.00)[cirrus4.onmicrosoft.com:s=selector2-cirrus4-onmicrosoft-com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,opensource.cirrus.com:mid];
	TAGGED_FROM(0.00)[bounces-225848-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_MIXED(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cirrus.com:+,cirrus4.onmicrosoft.com:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[ckeepax@opensource.cirrus.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 1D00D2A9136
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 11:36:10AM +0200, Péter Ujfalusi wrote:
> On 17/03/2026 11:11, Péter Ujfalusi wrote:
> > On 17/03/2026 08:21, Péter Ujfalusi wrote:
> >>> Fundamentally reseting a device right before checking what state
> >>> it was in is always going to be hard, so would be awesome if you
> >>> could have a look at how much of a problem removing that bus
> >>> reset would be.
> >>
> >> I'm still not sure if I get the whole picture, but by the hints it looks
> >> like that on systems with cs42l43 we cannot suspend the DSP since the
> >> codec cannot be suspended?

At least currently yeah, the problem is better phrased from the
codec side you can't reset the codec whilst some IRQs are
pending and then expect those IRQs to report correctly. The
device has no problem with the clock stop, its the reset that
causes issues.

> >> What is the difference between detecting the jack insert compared to
> >> detecting the jack removal and/or the HS button detection?
> >> Under the hood it is the same soundwire wake event then do what needs to
> >> be done to read the cause of the event, right?
> >> So, why it is OK to suspend the DSP when the jack is not inserted and it
> >> is not OK if it is inserted?

There are differences here, firstly between buttons and the jack
insert/removal, jack presence is a much more static event. This
means whilst all the state is lost on the reset, the codec can
easily rebuild that state. Buttons are more ephemeral, if it takes
too long to rebuild state the button will no longer be pressed.

Regarding differences between insert/remove, this mostly comes
down to the device issuing a jack removal IRQ on boot. As you see
below:

> > when the codec and DSP suspends when audio is idle:
> > snd_soc_cs42l43:cs42l43_stop_button_detect: cs42l43-codec cs42l43-codec:
> > Stop button detect
> > ...
> > snd_soc_cs42l43:cs42l43_start_button_detect: cs42l43-codec
> > cs42l43-codec: Start button detect
> > ...
> > snd_soc_cs42l43:cs42l43_button_press: cs42l43-codec cs42l43-codec:
> > Button ignored due to bias sense
> > ...
> > snd_soc_cs42l43:cs42l43_button_release: cs42l43-codec cs42l43-codec:
> > Button release IRQ
> 
> Event: time 1773739475.147018, type 5 (EV_SW), code 2 (SW_HEADPHONE_INSERT), value 0
> Event: time 1773739475.147018, type 5 (EV_SW), code 4 (SW_MICROPHONE_INSERT), value 0
> Event: time 1773739475.147018, type 5 (EV_SW), code 7 (SW_JACK_PHYSICAL_INSERT), value 0
> Event: time 1773739475.147018, -------------- SYN_REPORT ------------
> Event: time 1773739476.220776, type 5 (EV_SW), code 2 (SW_HEADPHONE_INSERT), value 1
> Event: time 1773739476.220776, type 5 (EV_SW), code 4 (SW_MICROPHONE_INSERT), value 1
> Event: time 1773739476.220776, type 5 (EV_SW), code 7 (SW_JACK_PHYSICAL_INSERT), value 1
> Event: time 1773739476.220776, -------------- SYN_REPORT ------------

This tends to means the reset will cause a full redetect of the
jack. Which is also quite undesirable, and will almost certainly
take too long to see the button. Not to mention doing the detect
whilst buttons are pressed is far from ideal, as it changes the
impedances seen.

I think I was occasionally seeing the jack detection get stuck as
well, although I would imagine that is just a driver issue
related to us not having fully thought through this flow
including the reset.

> > and the first button press is ignored  - which wakes the DSP, soundwire
> > and codec up
> > 
> > So yes, there seams to be an issue with the headset button handling here.
> 
> To note: on another MTL laptop with codec from different vendor I see the same thing.
> On LNL laptop (different codec) this works correctly.

I would not be surprised to see other vendors have some issues
here, I think it mostly comes down to what the device does with a
SoundWire bus reset, if the device treats it as a full reset,
which is heavily implied it should be by the spec, then problems
are very likely without special consideration.

Our newer devices are more friendly in handling this, but alas
cs42l43 is not. I will keep poking/thinking a bit, but I suspect
at least getting the first button detect out of a clock stop to
work reliably might not be feasible if we keep the bus reset.

Thanks,
Charles

