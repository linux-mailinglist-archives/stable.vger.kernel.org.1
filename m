Return-Path: <stable+bounces-71525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF566964B42
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 18:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40C01C21D60
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 16:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1011B4C33;
	Thu, 29 Aug 2024 16:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="vq1EtXIs"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2120.outbound.protection.outlook.com [40.107.241.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5A81B3B1D
	for <stable@vger.kernel.org>; Thu, 29 Aug 2024 16:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948084; cv=fail; b=V52ZfxneGB8Cxz0EdsEPq0QKrQ7/si/lNmXPt25K9TokzRtUgtQrJEmU2kKzQGV2sX0pAziTbrFRx5WvFoMfC1n2xLUkGAy3mYudRsESE7YWT7PI73Y3tabh7GueOAuCm/YhUaS2RuvxY5wksG3f3vTdfA92e2/zRsK2fy//H9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948084; c=relaxed/simple;
	bh=VxgKnOgC/fRfpR6IRReRdOttGSVvTX97mSPaiLjpbmc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Hkp/pYsmZQSlGsNpnnSN5Y1PZmNjNBaKJ1IbLM8qOm1G0zEyD7Sa5Y2zFpOAU4SrartUgMyINDBihFqdNgRQhDPeVZDLRof6UHNlr7fCyOUl2yuVqwpjWMPEV4MCZPs/g0nou8i5F0IBf3EnPiOBXj2WJoJzK/MD3/6mpwNKwmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=vq1EtXIs; arc=fail smtp.client-ip=40.107.241.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JzYPDfg2enW8tMZLKDA4qM1vOqXnA617i85DlFJHXrB95l6cPgOcQ9oDwRRqywr1i2YlgSSTuNpGWdzSvq3pMAk/fTfDphttg9oGr/cmPHWpSA35mGAemv3j5JOWWRdwmMuV/qNO1fST9qM1Ou7IxRPEuYDflCBa8LXYINt000jy3hSyc6f2iMZNlnnFDtjX9dTMFwu1Oy4OmCguZRjbY7ojhExnAdoS6B9U1/xEjsq0Ct2j6kEIkhrowOO+ulobeZAP50F4cufOur3ch4hvUR9/EwZXV+sCTKiASOcMDA9Q5L3iYq04YNy4R2ihN1nL1s6W9owJGk38w34OcVvnsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxgKnOgC/fRfpR6IRReRdOttGSVvTX97mSPaiLjpbmc=;
 b=aP3MrLBm7dCEC5WYfXlxrsHGy57HI1MsLhVdSj82AzjveHHYnTiGFXubvK/+4GeqewJCvCmjwpqypAfJ5S+FoKKIxu0zcpNngkNaqftShXgcEtHc10SBjm6NsvqUmwIWgRjAwbBvV/JfkLDdbFqdqJD1n15f53u7Bbv5tdkgEIuel1B6vDzen/k90uJSwurHKNsW7Byh6oFItKNucvrUlFBRI8FsyPNqBSP8k/RqSVJMqGEDmflrCFmxqNo8rJzLI5W1yIrzBiWzPFbpxSY8x08zH0enmtCJKWXdLlRsmdSyrUWFjidU1Zsgr3IRzd1J+cOsaEF+YwNaTDIvTkZPZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxgKnOgC/fRfpR6IRReRdOttGSVvTX97mSPaiLjpbmc=;
 b=vq1EtXIsz3su/j6bLzHmURWltqh2/bSdXO0w7Q3RvRsm5rDzQII2ahPoVRWzj+a6D/OSQDaowMn521cO980cDVKU9Nv6Dh9xDmcNUlHIYTrc7l/oIri/uj5zgl1KV0caJFP3UrGIK2TyiNtmiAv5mKEgVWveOtjB9hxo4m5YqJ0mB9LszBg1pj+kA8zI+6JK4hldweH3SWCGRTaeDguvFTqvt2Sq5WlLW92L6rYwLmmHlWfbW3phW4RypxYjqV/lSM62FcSCAanqmC+N8+eCcrHbl8ZiE1AhIhBhsCpNXXQJDCUxMhsyG+D/gjqjMjh9l6SYJ14AnYn1C8oL2wgaJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by AS2P192MB2094.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 16:14:37 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.7918.019; Thu, 29 Aug 2024
 16:14:37 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Subject: [PATCH 4.19 0/2] Fix CVE-2021-33655
Date: Thu, 29 Aug 2024 18:14:02 +0200
Message-ID: <20240829161419.17800-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR2P264CA0027.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::15) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|AS2P192MB2094:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fe9a6de-7b54-4160-2beb-08dcc845adca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zzqaWW88taxvgSgBy5d4yfb9VYgdJQxJrsN9fcFvommH4mi7eoNRiwx5ThMJ?=
 =?us-ascii?Q?PSFxZicQ8IpjmYfEkRwxoSWf0GS6RlQH6VSaHGD2M92jH5Q2SIO3F6bTFpme?=
 =?us-ascii?Q?kJugy8WFiZK8whZlVdy3WIHEwL0Hve1x0jOQeUwicN82ubiOMRrXrpKj8SqO?=
 =?us-ascii?Q?lgvOn2DM/Ywp2taCh4TAKpjXe8ht9RIvZK4jKY++IS+WxN49LQmME45XNTai?=
 =?us-ascii?Q?27VSLTGCtk9aT/Hz3jLVcQr57F+yYfoV1xVR8zVBzqnBr1M4WeO8Myk1v97M?=
 =?us-ascii?Q?Ozalj3Yk+ahGryyHprj4xTkrcAG3b+EyVyt06Ygq/Kt67xss8QPgHh9jDTU+?=
 =?us-ascii?Q?tdX428BB3Et6mzQ4PdsiYpSqJYbN1jgFZ2VN05LTrcPlwEpFYqCbusqE0F8J?=
 =?us-ascii?Q?YJBYuGrk7n/z5RZiv0sXhO0Peaf6flnCyOz6DUG1Gyr/GoOuQqVWCsciwZiA?=
 =?us-ascii?Q?9vGfpRheVo96NqP4Kk+XA5pquYy5+U3mntr7ZO3GYKtQA0soTVsIHnr/EyqW?=
 =?us-ascii?Q?uEF0aUXVuI2iSJf0fONud0C2vxjmkcz60NbS1s+LTa66VvF2ZfghvMfC9d6U?=
 =?us-ascii?Q?EImI9IEQzgR6vvefSxOvcC0zRFeOrZrh/R4l1bXCims9zLeghQC1mnkamYPt?=
 =?us-ascii?Q?RR+fYRP4zPGUTNp3oTuMby0D4wBA1es22W/FnVg/M8RiW6PeKTcgjrxWsU+3?=
 =?us-ascii?Q?2OzchlUU+p6vLRR7F8A4p5R74rqtdYy5qPpD3quX+SjSADz+8bRNg4G8ljH0?=
 =?us-ascii?Q?JykzNjmeVm6lVyUWklHm3BuT/cn8PMkod0IMuTW+QdpqVv7fQc5Q2wM1/prO?=
 =?us-ascii?Q?nkX024YTugyVHSvpxwyo/aW5+y9rFO6/TjrTz2oqyQTO8EHxutMwXGDRnBOc?=
 =?us-ascii?Q?4tfY5wprJfdu4XiFQNr1eFR2YDyKpTsiAFy2de9oic58BjtNjfHlN2B3E28t?=
 =?us-ascii?Q?i92/PQVpDqn7UTMsGbca+DfqXrLURpyUkCxD5hkDaGWdRQszRmdo/X85KPY7?=
 =?us-ascii?Q?dVq2H7zk8fg4Tp63OnrAP6Gf98mOUUcT11ts+0Hy8MGi11QhX85kBH0kBFzB?=
 =?us-ascii?Q?hr7cN5iUyDZiYgdgjX91+BMlQjX08nL/6mifr845E02KCuSVZpKAx8Tfz98M?=
 =?us-ascii?Q?w5ZXTgLC7IKL2oKxYf4WrAA9dMBEvzLvHQc7rRUX7wum04zZ4TgF9aibN/cy?=
 =?us-ascii?Q?Pt9zVDVFTJrUu+vMaqx0OZLYOnkCV23SIjCHVPsAUQ77HRJsonJVbtiGgrYe?=
 =?us-ascii?Q?/ICdugvNjStbSI+DgRotyTOsZOvXdDfA83ndnBs/XA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n1NTPO/gsORDHZcGWEnLardMGOvCBHzPVre1oyfVP8ttcYjkhSQAQ1Hj9aWp?=
 =?us-ascii?Q?LqSfUd4MIclHYf8Lisaf4gKiyIYHjzqdr/R2QnUBO4iJq2XUx0OcwrWNg7vk?=
 =?us-ascii?Q?mkO21DO997UCmVX6AqevQgz7gldKDEiF6RS5sgJvMhHiqBtuVQRRCNouYdBX?=
 =?us-ascii?Q?Fixw9ZU3W1EgdVBJUfmG+oL8zYAdg+HYcCCseP4Jzfr5SoFVfW6U8Qn5ZnEt?=
 =?us-ascii?Q?NCuHQHi0M9YXqKQg+HeQJshDZPqS9xMk7w2sISWoCQit4wTgy2RDSXCAK+2/?=
 =?us-ascii?Q?A7NI0Xr2B05ztiA5mmMbUnAN+X7Af6/x+kr7Q2in6y3bweret/pxwzP+md1G?=
 =?us-ascii?Q?A5MGzA2OH3LLBF2HlsKJUWKqfjQjahQE1sQUstwsEIU3qnhInO7PKNTJ9zqd?=
 =?us-ascii?Q?o0JyLybISPzp/yJM2MqQXXtBGZgq1ASblsYYpRsPAFFpo1LbfXWtJ0Wkka45?=
 =?us-ascii?Q?hs5r6b1q4b4VoUNPQZoPHvkXC+Xxznzd8/kF18eoXfu2V27CQ3dJ9ZL4Q79/?=
 =?us-ascii?Q?4IMx20Jmkh19doBKa7OXyJrmRZVEfkMCl0rphbq4pzGEP0CIgqeqdiIaXAbP?=
 =?us-ascii?Q?1BGfsvpV6g3+vSGC6ZZy7Yq8Z0jFS6lMVk9mcCXm3cKzo6/YllO7bwAm8fsC?=
 =?us-ascii?Q?JJI8cAdMYP9YhsKfs8HPk68727NIi7pDOiDC4OC6sSPSnzQYcaASFlM0imKs?=
 =?us-ascii?Q?KKqJA7txG2lJpKwAUA6wvT6BgujC4PmNgatvUXFxyZLC3JsQvU/FA9U+ySc+?=
 =?us-ascii?Q?+FqY8oiyXwb1+cq3oCIYpZsXwHpt+3c4eweZDO+unCDUkD8EGlXDNCBIdz50?=
 =?us-ascii?Q?xDuRN32r0YN5ChrRFwHIyqr3Picfjfu8HlWTte8SBl7pvbmmuBxR/icoQp5G?=
 =?us-ascii?Q?ULna0j76u+4PzAtIRODWTv9LX5kRCTHqofbNKB8xctuXekXfV1FSIykFFT8I?=
 =?us-ascii?Q?qC+2n5kicfaP3VcfpgNFUvKtT9pGHPVU0VRVf7+vBeYpzKzqfHyR+DNciFEa?=
 =?us-ascii?Q?HPGYHhXX4NHnNeF9oin4uHiL0Ce2NHyLpxExCVJduSj2JAWTjCSeULtYmaKs?=
 =?us-ascii?Q?6A9WgbiXuwQpVcCDECqG1nqamArF2vFnai4BgR1RYaZNNTdkdfRbgXGiNNBf?=
 =?us-ascii?Q?X9mPmycu9FfNdAZDq4MX1Robr1cnWhRA65GJMzGcBzn7oxZ4iBEHDk++1i0A?=
 =?us-ascii?Q?iNbwG1Cqe58RIhl7DMTMBMDZsTnAUBinxDSsRGAqtxVIqt9G/i0ckP2yfnSX?=
 =?us-ascii?Q?Tv09rgpgqLkWl5+kh4pKJaU3t8e76NPb3OnheUA2NqBZbPi1zxTh1ka5XUqT?=
 =?us-ascii?Q?8zu6MbXK+MVaYP/pP2VvdeMYy7I9L+lNqMI/EBTnbf+n/gYQFSWpMjfcY5k/?=
 =?us-ascii?Q?TLqysPRRMoomruzeljoloL4jsP1Z8BM8ypg8A6nfMOPgWUzpOq0+rUnJbvy1?=
 =?us-ascii?Q?mwvqVoSa7p99f1DGJke1jEXtgbcVIVeNUVUKy0cHfDKY/nHtHlz/3XNukbk/?=
 =?us-ascii?Q?+8K13t/t0O9iA+GvJTeUucn1N6iwpbHVedzK+x0u6FCtLHJLkZvpHCAJQ7s0?=
 =?us-ascii?Q?R8PR0CiHg+I/E50n+f0rZnylgzZu6bJ2DQaoOzx21BI4QfVd5OtYYTxWQbvR?=
 =?us-ascii?Q?yg=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe9a6de-7b54-4160-2beb-08dcc845adca
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 16:14:37.4810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0R0Ry8cDYyn4rNNQUP8Vlu4IUBJd3CXqMtBs4eJ2wU0/lDqWH6/0u+priAdIE3afMhk4lBU7IzVC1Sab1+jH1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P192MB2094


https://nvd.nist.gov/vuln/detail/CVE-2021-33655

