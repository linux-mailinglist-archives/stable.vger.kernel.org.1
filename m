Return-Path: <stable+bounces-222393-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCk6FGGwo2lZKAUAu9opvQ
	(envelope-from <stable+bounces-222393-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:20:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7DF1CE666
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97C54303C039
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 02:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021C530BB89;
	Sun,  1 Mar 2026 02:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="A9HV77cO"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BE9303A18
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 02:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772332583; cv=fail; b=fuxsI2BdXBJ+EqpYsv6axFJJLzP0x2XGYDc1vVW7567dZ7hvCwoPZiE/vSQjqKZa1s61kzmgOYbaLmZGkT1RT4JF4ILc71CsPBre8X01GPSIPE9d477xJeMm6Md5doy+zbCXHVARPPCSWUtPyN58qT667w4Tx957hXSJyJdOIoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772332583; c=relaxed/simple;
	bh=uSe7xRdeOkqYyZV9tDAO8Zyeg0tgEE/Xc73uObjJv0o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Uhr0TX8Hfo0WtlC36CfT/0hBb9KJ0ACpyNgNfznLZa2eRiEYO9vZ8O1n33R1thetkk72M5AVCG4NPPGElYY2pmDlMAbtfym/P0ZN/fWcdM7u5bZ3mPJF11iM8QzQxVtTPJrvuGL3CXLaZspyx4pJaHFndO0rQyiIbYByICbuz/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=A9HV77cO; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6211DS7U486374;
	Sun, 1 Mar 2026 02:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=BYAOpMQb4
	2jlrMQrnd6CjokVsZVROa6DkbBiFbsq4bI=; b=A9HV77cOK1Z9EVmQsz1DCAcLD
	6/HJuiUtHenjvxAui8ilKufDQytUGfynwnQ3VivxYhEhzDs6SrrOsf234oPK5ydj
	axVg5yvRXh3txxyeSuFzLA4TkZBCzw9kPkh2ug2NSHBTgiu9hiCASuezgxdwAP4I
	5jbkRyxSPYG/dAZQdkTJ4pFUCQAl4SHqurCk2ViOBjOT1kx+mPMS9FsCCrQxKG2Q
	C5C3yZJEQGjLUcC0n25GvOcYLTOVPupdj4g1c5HU+5jqtdSQODa5E0/eJGnDw4iE
	Tr58B9I9tRJ/3Ex3AeqH9BEX+UYH0boKas9CC2DxgyO0wMVeMfYZ2fhc6JVCw==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012038.outbound.protection.outlook.com [52.101.53.38])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ckqb4h3b1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 01 Mar 2026 02:35:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OdcCRdsCnl63b0k2gQEKH9RSbvMlgAnbKjYc8a3L5vBHLJqmlpLuUcmL/WljDfXqjJMHXgS+tcao0VIvipWH9VMZnFuc3voRw5Nq4sh6pMYc1XpTqjIK0A7UkScyKVBW+AYH9DqPHCou81NgLryQBU7p6lUWhOZOSOebqoltm7xE+bxQ8dmXRTR7RNv2W4j28goSogFWHb/wRebBlZZeFqPpzOlcILxQXX5qTXxUNps+7M/sF+CVqSWQBmgqnXw6/Kgk+8kznqrzYtcCIUF/uE3Ddr9Ly0JA1atAHtu+gndMRsogmuVsxJ60v7cX8whbKrBFDQY6dNB5l/DpoNAZuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYAOpMQb42jlrMQrnd6CjokVsZVROa6DkbBiFbsq4bI=;
 b=kfhysC1QV4v1MPWx/4LFS75cMI6nDXhkJ/PXjInnrL1bnhgam02b5HFeQL/sS8DBdGux3lbSwFhjGBYiWFzD8xqqpe5BwxLNs2L78WQ0jIU0H0oiaerh6V6D9yQOEwreg9N47OwkYi1u8b44hoskTw3xcAafQxoeVVwPNWDOlNcXrUUMLQfFpDTBnz7CfQcfUfFN+OXdxgoc7T3vb5nDopj3RyEroQiK18VcBKIvxp+fsFcKbAzy8kUgg/Dx6PGPB7v34jbkuIVQ3PX6sCpTS0Jq2UUCB7mYjPGV1sBb8MVB6WXr9a3zHkyLGwm3mI+pX1p5a7DfS3L3MvhqYJozsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS4PPFD667CEBB6.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::53) by SN7PR11MB6874.namprd11.prod.outlook.com
 (2603:10b6:806:2a5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Sun, 1 Mar
 2026 02:35:51 +0000
Received: from DS4PPFD667CEBB6.namprd11.prod.outlook.com
 ([fe80::5f46:caa4:60d4:f669]) by DS4PPFD667CEBB6.namprd11.prod.outlook.com
 ([fe80::5f46:caa4:60d4:f669%2]) with mapi id 15.20.9654.014; Sun, 1 Mar 2026
 02:35:51 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: sashal@kernel.org, stable@vger.kernel.org
Cc: sakari.ailus@linux.intel.com, hverkuil+cisco@kernel.org,
        Xiaolei.Wang@windriver.com
Subject: [PATCH linux-6.12.y] media: i2c: ov5647: use our own mutex for the ctrl lock
Date: Sun,  1 Mar 2026 10:35:32 +0800
Message-ID: <20260301023535.2438766-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0038.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b5::6) To DS4PPFD667CEBB6.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::53)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFD667CEBB6:EE_|SN7PR11MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: c1c0d584-2816-44d9-7b28-08de773b4119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	oqYN6XntS6Xp0SJHbXi7s/sbp2YpSs9mtcKHLLO2C6fXWxfffX8PlPFLjnAdAk+lE/FckfuTmF+A1x8RD+oWDL6U5GVQ5CShS/9ThrENrraiVo07L3zFHrETwxCVSdKSrBhXdT8WUNPpNnPRmqn3QYRahEFMaX7dIJ0Idn+YzDV9E0ro5d1IRU218AlOzzK14lWK+1DNf+uVJ+D62jp/zTqrW39/YlurjhRGI9N1m8WCUCiuc4JtFmtGjiwLue5Jj3cmSuN7sqhpR8bf5KyIxOrlVx6a4XCHKeTL1eyfdAuvL+5u2gQbAysaQGQ0e/yeDuN/risQcS0wFG0VMqC/j4cYG9XMUAu3sogDA3Xoc2+Tpp78rCkV3ZhPPgNmV1GZG8XoBqQ3Vta7t4ckqLgMMcYAHrN1OFDcUPB+F8JhHXa2XkxAbuNY3ffFclFJJmLaciWNBkIiJZk2pcEt7BSlBbEpLpdBvqNltuMGKHJcW2YhepVLE/ZvJXlRnMQxNDE8RlWfXKyMsu6TGWAH/HVHaux8pgYi/0OBasjyXNkNDTv/7AD0D3zHXWMp+z1lktd6215zjh2Czw3Q9q9fa9N5EPiNp+z12yoivt9cWLAw0xb2U5vwPNWd2lV41w1K3YjV0LUjJTUZZNS/8Y4zW25gl5f83CoyMZDbgPMONMp1SQGpMO2HDZoOFPP2jn1WPd94xROyO29N8lpV3deMajCGhfWVlK3LpeJHTtp+PuwORr0CeQmu7U0ENg3tVqLATIRhPJ64oNdixQjiKb4WHzKiAWzvX5wEUuuW13Um96muCZw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFD667CEBB6.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SQgZbkcjHX0VGnxkAzrEhgEkd0YAwBAya2hQLGjZhHLZcSd8t1b8vFFGfFoL?=
 =?us-ascii?Q?v6i0TXJHl9qfW3XVG/40fLcqMqz/VvmG4lRGRUD1Bz0JZYVnhhfAuQcbjuF9?=
 =?us-ascii?Q?N2BsaDfRMeJ+tV+FM05vggDfZXB4zX2/kJ3JvtBhjLDPRQF63rrqPJBIbDxD?=
 =?us-ascii?Q?/uc4v9g4BVoAwVFwkhpE+xPW+dHRhVT3vSLAAP3Kjb4X3e1QQ2RLMLX5L9lW?=
 =?us-ascii?Q?RgA0XFL0hlL7djKIVTo95vgOocFCTQRzHMo8K9HfUaF6Pjc3eK8kR5dCRtZe?=
 =?us-ascii?Q?K1atDM+PUbVs+irGaQbINKfYtuxdtbZH4xMxqTopf3mH1ViK8mdvaHnlizWQ?=
 =?us-ascii?Q?CQZKGs46wsp4yTWWyyXu9UBWvgsHD+qUDGC5SdxQzTnOwcSH3eYR9liXv3K3?=
 =?us-ascii?Q?y0qOcnrglnrmvOvptk4I4CJym34suKgiY/C4NEUl2ebdQBtbVcKugqJDizkt?=
 =?us-ascii?Q?WsdjAovERIUJFAO5qMeGNwRs87DtwEF67g3NiV7xkJZUI+na+IhQikQ/qufi?=
 =?us-ascii?Q?mvxCxjHdiU1LnesDnBzVJivdkTpr0TQO/TInuQbk4VizWtQCTl9AMdYutYcr?=
 =?us-ascii?Q?u6pMyyY1MYFCbDmppyYB9g+E0Rqs2/kNoouMy1ntT+BcpjSgIiezeVO5rjSi?=
 =?us-ascii?Q?qvjdOOgBw1LaoKaIasUytOplcBTWbvGt2V83gdNzJ3rHQd2gTTGlA+HpmVzS?=
 =?us-ascii?Q?yzjJ8jf9JtSWxBeGp7pTpiQwPZtQ3GyXwyvPEE+IEuER2fq9qBfqtl3dsd/V?=
 =?us-ascii?Q?MqCJkgub1o4f0SAnXiOeVp7bTKLsKUYHsfCQ6uW+Fq8UYjiHPBmWaImb6I0h?=
 =?us-ascii?Q?IPVqIuyyELzipdNWgnOoCICkXGp5qrUQD8+RiwD/rLA0N5IVExudgFlXR8w5?=
 =?us-ascii?Q?4ga6BO+/NkvjRnw8Y8klpVrJBmQaOQ1LKFheJBIEVeJM2JxvavmwfyWCroOU?=
 =?us-ascii?Q?qhnuaVQ/80NN8Hb3CPwQL89KEiz+dtSpPGMHX5wJBgdqqJa7NWZA8/gvUZWn?=
 =?us-ascii?Q?cS/1M+3SFuOKGC9TPVqCJOju3oEMLD2MIzm7GZiwtr7/d9YVwVnv92lq0VIz?=
 =?us-ascii?Q?3JjKkQA3RNEDtYNDTOBRchGzYT0m3RBJtMWbmgYRW1du4bOWOQnB2ROOX6rR?=
 =?us-ascii?Q?y5RZXqhScFy5y/f3erEvRlCr2SuTVPF1Z1xIofxds1yX+vpp3ZA2A+eaBZj9?=
 =?us-ascii?Q?LapmcnplWi5P6cr7rF0VWnEwzKFNeq9Pbpz80Hd2Dq74lL15wfPYEi+5xOLI?=
 =?us-ascii?Q?fElBS7xRszkiiMrWEUwQK2AmumLTj7Jw827vzWYe2sO/jnGEApj4f1JdARm1?=
 =?us-ascii?Q?6HcV8SiAHcOKwJEKPU1R9oj2nk0KFKg6xr3MxJfWMF4r4Plw65Wbf17K4wwG?=
 =?us-ascii?Q?E9Xt92/r9DOajVKpzqr6pcF0oE9px+fOFw3ULP1oJdP0NypeGCaLTgyEPfjf?=
 =?us-ascii?Q?tRcSFDu+JpURPSBTX6r6N4SYBru5IZKvve43W97hpD8JGLb8ho5gaqs0z486?=
 =?us-ascii?Q?ZrVPpskUx64wZow9rkS31LT22sT7owEm23dEqXY03x+hl61Z/Rv1qsy8hKWL?=
 =?us-ascii?Q?BfbZ4YEOEDoh/wofNqZzDeGzADxFkX+JSis9pYIIXjhURUCB4UlHqLVb5kry?=
 =?us-ascii?Q?gUyuZtjjPDnQVP+ynZVAQK4uF5z3veu0af6qVE09ongGhCHBH7e5AOLXwCrk?=
 =?us-ascii?Q?pR3mj+dZU7REax6FnG1HCbzJST+fzL4AgYAC4NQqdu+HuLgCfAVSm1Fsa+kk?=
 =?us-ascii?Q?GZYHK52jnu48i2gNA4CWSoXb8S+nptA=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c0d584-2816-44d9-7b28-08de773b4119
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFD667CEBB6.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2026 02:35:51.6629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WGJ+gJwudkFO+kSFzIWlPI+zR1QcXe9tiCSWTgTu2C4jh6FaXAf7WHFVmlc+CutMpwG/kHJUQKsKLJ2hL8R5NcC9gUegeyAAT80YRgr3T58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6874
X-Authority-Analysis: v=2.4 cv=LqWfC3dc c=1 sm=1 tr=0 ts=69a3a60a cx=c_pps
 a=EbvyHBp0GqBzY/XWR/wUiw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=QyXUC8HyAAAA:8 a=wk0Ph_KwOMu3z5TwrfMA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: Q8G5Yt0WdSsmVKihafur-MjOkOEZblR1
X-Proofpoint-ORIG-GUID: Q8G5Yt0WdSsmVKihafur-MjOkOEZblR1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAxMDAyMCBTYWx0ZWRfX5qjf4OLADUKo
 1Q/9jfpYWC9OoIcxS/ZrLXdwZxQIgNQsquv2B5KYMuvi7WLQyIQ8niIGYs+DYR6vS/kImM9iAcU
 76lUSK1KghW10ieZRdY2T/GssW9Ms5ZU4nCrPR154lUkpd+Bicxkp3orZqvola9qpFEBPR6FVuy
 ibj8PoENGlgbdj4LV0sFd243RF8UczBq0W9Yaahe52X2UUxitlpL/a+TADL9Y0Yf7ji/oq8By47
 0HwjNFUisJIR9NtO4WAZbyLp42TeTNMo1oxdVFMjbfx+r2ZCHMR/3YwXx00wD8k9SSrO0wjvAYg
 D/+6saEHh7ERQs3yWtcnyP0E1lar41UPg+ga7VaYzsqFma1JXYh7snutTwD0vuQFrhTIaQjlyCR
 P8eGIwxIgS/FifNwv9zTa7WCAGj33U30kHOkWQ97YsVajU0j/ys3hNgeDrjjB4fDwgBqamaUWcS
 fGK43DnG0ZUlqde4pcw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-01_01,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1011 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603010020
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-222393-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiaolei.wang@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,windriver.com:mid,windriver.com:dkim,windriver.com:email];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DB7DF1CE666
X-Rspamd-Action: no action

[ Upstream commit 973e42fd5d2b397bff34f0c249014902dbf65912 ]

__v4l2_ctrl_handler_setup() and __v4l2_ctrl_modify_range() contains an
assertion to verify that the v4l2_ctrl_handler::lock is held, as it should
only be called when the lock has already been acquired. Therefore use our
own mutex for the ctrl lock, otherwise a warning will be reported.

Fixes: 4974c2f19fd8 ("media: ov5647: Support gain, exposure and AWB controls")
Cc: stable@vger.kernel.org
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
[Sakari Ailus: Fix a minor conflict.]
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 drivers/media/i2c/ov5647.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
index a727beb9d57e..548fde4276fc 100644
--- a/drivers/media/i2c/ov5647.c
+++ b/drivers/media/i2c/ov5647.c
@@ -1291,6 +1291,8 @@ static int ov5647_init_controls(struct ov5647 *sensor)
 
 	v4l2_ctrl_handler_init(&sensor->ctrls, 9);
 
+	sensor->ctrls.lock = &sensor->lock;
+
 	v4l2_ctrl_new_std(&sensor->ctrls, &ov5647_ctrl_ops,
 			  V4L2_CID_AUTOGAIN, 0, 1, 1, 0);
 
-- 
2.49.0


