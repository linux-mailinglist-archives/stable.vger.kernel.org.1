Return-Path: <stable+bounces-225618-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMhaOssyuGmvaAEAu9opvQ
	(envelope-from <stable+bounces-225618-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 17:41:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD5629D8E1
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 17:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65C67301D33B
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FC23B9D8C;
	Mon, 16 Mar 2026 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="RFHUrgNa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="J0Fs3JkX"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7242332EC5;
	Mon, 16 Mar 2026 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773679227; cv=fail; b=Rej/431nwqRvRRAO8bBTwJu+eStZpmILdq5ST1Y9dIIJh08F9Fu68RbSeIWY6CWxZDLjJfqgHwntM3pAqSx//ZGXRMUoPsXYVexDgzAhrAfm7atHHbtxcc1+njG3xrf1XWKGwq1YyhfRRhhv2+k0Rp5BM0JuJtBVeCDyRYILe/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773679227; c=relaxed/simple;
	bh=2scJUWMvECytdaoV0oxLXc+kqzEyR/ZUJYY9x8Jkjhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfHLOFHFNN90GhgVSelZT5K7hrTG2U/3MiWUReoXiKa/RPJJlk1jpvYKLi/gHbnfNcDG45REvVDgRHz0hnYyEkKJ6Mx8MDL5xBJhztaPG0CcsxGcvKlBFWSvz4xlIF+NeWZ3T3cK8/3640xbnrs/8113q14nbKauFEneEgukGL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=RFHUrgNa; dkim=fail (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=J0Fs3JkX reason="signature verification failed"; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GDf43x3504543;
	Mon, 16 Mar 2026 11:40:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=at1lwnZuChq2Tgf9E1u9uoU6eChouGDeXEOCKfv+3Xk=; b=
	RFHUrgNalk6e0wnhINZYK/SH5wrno0jLG5IIT3UfOI9XoVsb3kviDcQtN3RWBbbe
	QVzcaUtmlG7PgUp6mS67Q+FYZSR43ypQSgF7fwMLwJB27WEJ3rWvQt8T1Go5Mah+
	XEcZ2pFJjKRFx0FHwSg0BW2qG/dq1L2/ApsUd409mrUBWhW111EtsZxId5+u2Cvr
	JCxyDoqrOCVGQF7dtWnd732IkEqmjAwKerlQ0NoyHGP/Vu2qw5QkghpfmWgnQJoi
	0JXF4EVzVdx9pfL4QkGMRgRHO3rK4uqpMEZ/it2fzoxrPHNIPTQDr900yB2QQ0Md
	veQ+y6CKfUfYt582jIXhpw==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11021136.outbound.protection.outlook.com [52.101.52.136])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4cw43f2ar0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 11:40:21 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oUHD4vP9jeN1BkA3EgSmGQ7KjxzCXOaX5+d+2xt+7kbwpF4RA1Zx7E8gmD1F6bjHUhot/7e/u9FzPXQKmI31+zpfNBKqPI9QLP342F22Zl8RO/qCraPAaTVxyYQ77xM+D1gTVQXshZXSgpIQ+Tz09ou227EiB4WhowMhaZMmkVQHXxZuMugJt65wqD4MU6Tnz9nZ/48p/IBSYwnlSGR8Y08lIYy+1lRAgSwFQCbnrkgX8qCepwkLhImKN7p/imaeiqVqv6IhfmsEWpSKhHnFFs6VGCmG1c12F73Zk2MxamHRlQ5cG4I/nokl3zQC5zSEnB/WgvJBWb0TV1rq1/9inQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsBrd++RS/RxvEHX6wAWiy5R4XlRREmYIa3F4pea+ds=;
 b=KSAgiSkws7EiSpHyokK0EtR/A2mS0ev+UnyziOUoAjca24wZs18E9aHEbKKGhWN8JpAas4sJNPRDiG4SfhfMCJtCI/2dgiuZ0OvnRywkZBlcvzpESzYlLftmWWlDsranHVux1TLJGHfYCrAK6d5qIi9v5zDo1qag27KGYFVnxO+ArEguoq0TfaZKwivrTwxnHyB/itEHsWD45QH+DrcHiuV3N4xTXE4ydkwyNytHENhtACfWstqx1R3qqZwF26EWtIONKKexzCaVJZZ2z++8yqB81SuL94Ib4VlO0Q7l8JpLaeAQnqgyDctn5yJ5xxT2m5cNIorQdjYCmWJKg4qFow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsBrd++RS/RxvEHX6wAWiy5R4XlRREmYIa3F4pea+ds=;
 b=J0Fs3JkXgk7DN7VjGrPB/AWHSoaJNRbi/yoE9d1UEXfc8YmpvUlsogkdVQBPi1tKDOWEpHGZfMQSKSCYuIWZi6nsbrwum/7mgo8zqUcYGzq6oHgxLbok7dboNFr4hS4ggM8DdB0oQKOg1vj2uTrURI33xP2G39tIB26LpTHmduU=
Received: from BYAPR04CA0023.namprd04.prod.outlook.com (2603:10b6:a03:40::36)
 by DS2PR19MB9650.namprd19.prod.outlook.com (2603:10b6:8:2d4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Mon, 16 Mar
 2026 16:40:18 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:40:cafe::38) by BYAPR04CA0023.outlook.office365.com
 (2603:10b6:a03:40::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Mon,
 16 Mar 2026 16:40:19 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17
 via Frontend Transport; Mon, 16 Mar 2026 16:40:17 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id EAAD8406540;
	Mon, 16 Mar 2026 16:40:15 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id D6770820247;
	Mon, 16 Mar 2026 16:40:15 +0000 (UTC)
Date: Mon, 16 Mar 2026 16:40:14 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, david.rhodes@cirrus.com,
        rf@opensource.cirrus.com, linux-sound@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: cs42l43-jack: Remove manual pm_runtime get/put
 from tip_sense_work
Message-ID: <abgyboHV1jaWDUul@opensource.cirrus.com>
References: <20260316124924.31047-1-peter.ujfalusi@linux.intel.com>
 <abgTWxI1Q9M1o+ka@opensource.cirrus.com>
 <d5353ee4-1a3f-43a6-93ed-5127d666ad0b@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d5353ee4-1a3f-43a6-93ed-5127d666ad0b@linux.intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|DS2PR19MB9650:EE_
X-MS-Office365-Filtering-Correlation-Id: d086e5ef-4abe-4c61-fc5d-08de837ab4e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|61400799027|36860700016|376014|16102099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	43RNOyqVr0aQz25kWSSGE9z07IUufUPOOuPgpr6Z7VW2NuMGqnNIK/ebbVMwigtk2Bj7dZ0tct19TTQAe/4fQH2a1Cjfgss+UnbdmHuSDb0kVnE8ipVb1Ie/9uXx4NgoZy6tiJ7cRhGHL3xcc3wOKk1gRN/fewbfi1sR6IXp+u9fH+7BFGFgU7u99HcE0g+RAdTnUZT0sIePd6qS4wKeDFHDK0eghsB0QVx67H2qucjTz7/Kdy+uiOK77r2rE2ff+89cZjdcJY+LwiZJxbdTY+HTvih3nA6XCngTB6anSO+ne1u2fmFG4+QTzTtEnM14jVlF7gwl9ZayesNVzVh5zJd3QQp7AacLSz7xPq5ntGCYD2hCbfOHeSk7E3i7lyUG17BZ/oqIj+TkrQnGK9/wytQIEfNjzaRva2nq64OR6CTZL4SsKpdzQgUpUE/GV63GUUa2k4VKjP637pLqluOSixqoeIgqdLC52MT6frjjIqEyRePDEyCyKae1PLTTZbXgD0RaaB5GglXZadfGhNiX7SXFTczWbA2yUyhrgS2xGiGFPgCleUay558o7f4Qr/XBdba9h+TrMDhjc37k8ZzRXBlRDwh9Rl7eNeA5geq3QeUyNKaFflD+YEjecPuENwa1mLhmsDWwBe02ZYmQmBlIRztKa36Squ95/+sOuT6igfx7ZvIF0HDSiFVvCjnAJHAioSOzF1kMlHJw2iYSyZ7NbZBqnPLhBDMS+NAexBWgYOF8VcOqJrOy/jwWjBrlkUfxpBOl8NXUZmbtNenIyU53fw==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(61400799027)(36860700016)(376014)(16102099003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ggKkTySzoE21dTfF16Bhv1LBBIbtMhY1ry07gtkj5u2zzPVLrYg90zIrYNI22g+DmK2MUCNp2jEKiwaQ6OZouXNr+L96U6WOpLtPa5DLV00oOMpfWWUlC4x6Acai9uhFDrk1kin4iQwvIvUKfwrQBBuWTPcmil7gz3GfrBFgByeD5BXhxptjwfm9k17QM8NMHHOCOale8v8EX9ihyeYWnDxErGiaNsVStwzTtnlBtvXgP95i5JrWzzsSroBYdOTf2KAT/tKDGyCBg6zW31BS/qSMcb3XhfBjyIB8ntfDMdUKNUMRBHKh3bKHZxUDuyaiR9XB/mInGduLLh325AHjVpVSGj+O3vHMap7t7s20FaTjpAI0dVW4nk7/gITnfxtE2SH7fSGFr4SfVVK4jFPBIjEMcifpkwDCVWudOYZ/3ZAXd8y28gNAb15zHcd96aUl
X-Exchange-RoutingPolicyChecked:
	r5/sY/g9EFk5q7sW6oiNRSMEoVa7YEfdHKLaceyp7hSlQnYKeJxoZto/MRtpJgV0CHJWgC+8XHix+s/OPJXfS66SPFmLgo9rWtU5j8e+/VN40YLvmTbMREMg5IQTv8Df7Tgw5F13BajIyh6YNAVNcJQKcqpgUSv1SZxhdh02dPWjzxteZzHjCGpCz/bDlIbChd2VLFOeLrNTnwABsWaFm/xcyPltOohJl7392Q+EZNSuY6DRNK0XOPlgjzthzm0gf9Vjhb3WVvu3gUx0gP88OgwHNdLaDXHzy29uGpUkp/4L5HwMhpyJEpYzbwLsnGvIysSLjZVKM7Tjy7jmDSUizw==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 16:40:17.3849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d086e5ef-4abe-4c61-fc5d-08de837ab4e1
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR19MB9650
X-Authority-Analysis: v=2.4 cv=YqQChoYX c=1 sm=1 tr=0 ts=69b83275 cx=c_pps
 a=IN/ktsHfyviFoRwGlsjPrQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=-yha0pfgBuFMqiPLLLUA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEyOCBTYWx0ZWRfX5ofzorXQtVgj
 uM2FjleUPwKpCAR5cpCnBqJkD2hVgMKGfMB0mhYb3rRkHEfdxJTLCGf7c0mXMl5ao4f5dSUIcqD
 eWBi2kik+FbyOzZVQ9DN+yHwghuEyodlqgvax6u5a2Rc1Pxu4lmekrKjrBKb1KuTu5CMyZoRQ7U
 DTHO8uEG/6JWwlkFOPqYFrKbVqijCA416CwAU4DCoQUNkh0IWTO8PUMzU5viZB4Nzsn3Yl1CHdw
 7r2FshI1lDwwn40oSactUT7bnc/wf7kLcEvPR8YDNgUgxz+2Zn4kfHDDcZUOdQkqJ8UENgiUQq4
 yqKlWoRmMaJRJ8hjFRQr59giPfmwr/R4BgdT1wb/CbcybSbwx3/Xs82etCV01/8JktDdpDcWBQS
 Ve4lqiVJ7gUY7VBipETqz7LvtxbYzeWBE3OZ2eXrwDrrsxslND2HqYggJD2ZdCvVgysCQTFrwQ2
 6hOBmY2mGYogYZMYlsA==
X-Proofpoint-ORIG-GUID: ZulbnB5wlY1hOL7NwzOCD7hrkdqSEkwg
X-Proofpoint-GUID: ZulbnB5wlY1hOL7NwzOCD7hrkdqSEkwg
X-Proofpoint-Spam-Reason: safe
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[cirrus.com:s=PODMain02222019];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,cirrus.com,opensource.cirrus.com,vger.kernel.org];
	DKIM_MIXED(0.00)[];
	R_DKIM_REJECT(0.00)[cirrus4.onmicrosoft.com:s=selector2-cirrus4-onmicrosoft-com];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[cirrus.com,reject];
	TAGGED_FROM(0.00)[bounces-225618-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cirrus.com:+,cirrus4.onmicrosoft.com:-];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ckeepax@opensource.cirrus.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 6BD5629D8E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 04:37:28PM +0200, Péter Ujfalusi wrote:
> On 16/03/2026 16:27, Charles Keepax wrote:
> > On Mon, Mar 16, 2026 at 02:49:24PM +0200, Peter Ujfalusi wrote:
> > Hmm... yes, I have this feeling this was in here for a reason I
> > should probably have left a comment here. I somewhat agree it
> > looks a bit mad with fresh eyes. The variable is also only used
> > for tracking this pm_runtime_get so you can drop the jack_present
> > variable from the struct as well, if we take the patch forward.
> 
> That was my thinking as well, but then when the headset buttons did
> worked after the patch on an idle system (ARL laptop) then I thought
> that this might no longer be needed?

Hmm... are you sure that was working? Tried removing it (on
MTL here) and I see quite a few issues.

> Fwiw, I have been banging my head on why the DSP is not suspending ever
> on the laptop and the system is not hitting lower C state because of
> this when I had some spare time and studied the code and then removed
> the jack and boom, the DSP suspended right away :o

Apologies for that :-)

> Sure, but draining battery when the jack is connected is not a great
> added feature of a codec driver.
> The type-Cs are on the other side of the laptop, so taping the jack and
> power together is not a workable solution - to disconnect jack if power
> is removed ;)

I am not sure there are many other solutions. I will burn a few
cycles investigating here, but I suspect its going to come down
to a choice of two solutions:

 1) The one already in the code.
 2) Stop the host from reseting the codec.

Fundamentally reseting a device right before checking what state
it was in is always going to be hard, so would be awesome if you
could have a look at how much of a problem removing that bus
reset would be.

> Even then there is the issue of unbalance in runtime get on module
> removal when the jack is connected...

Yeah that is a good spot, if we stick with the current code I
will get that fixed up.

Thanks,
Charles

