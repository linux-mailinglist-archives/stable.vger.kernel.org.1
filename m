Return-Path: <stable+bounces-100533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD439EC456
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 06:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3204188B22F
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 05:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CE06136;
	Wed, 11 Dec 2024 05:30:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D255672
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 05:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733895038; cv=fail; b=S0PGXy/Y+70Nj5/wyDfig1Y0VC3Ta6N2dkZ5Q7Vzowpj8T0wnqvNnejxYyr70LETRIAb7/WU8KGPM36x+Ys5S9jWnuf+SbHviJwSK2rh3/pd1RhbiPwZXULQR7YhxPM/b9INI9cG7fS4WSICtk3VNBMRyPr5GPavPToSbZfw9rQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733895038; c=relaxed/simple;
	bh=26qhsQRJ1oMK2GRXAHOQ8w0X7SJPZ0eV7I93G0qXqSM=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kK69qGo5PLdN0zu075hK/B45OxuVqO/P0NlXuy0uHtj2WTwJh/NMl53EoSrpntL7v8q8Xg+VpCzc5+v5S8wIiusEyv5QqiKVKk4bsKzZ1zSyweTiFi/BPDHHuV856o1U9I8wruuE34AnHJbOU/gbJHN421z8K36gTkWX/OKnA8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB59VNT008090
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 05:30:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cwy3ksm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 05:30:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tD9/gg++rp06wOgcyyrkUDcEkrYWGMdnB8aOgsxMyCt6oyYDAnQOfyl+fone+deQKLAi1c/h6A9PZ7zd5+9bdPVjEb+CCwpHNK4CgbZ68owW9Udc7xs+xQ5iROn+K7TL7JVczO0edqAP8LN7p/wstjQ5FZftAw0Ez6XvQ+OCC4FIbjqGEH371yn4CW9j0Nrg4msxUAs6gj2DBmohPZgxU5FOZT/wKBhVDPrLkwoPqKBE+4pc8/C+oBbRS7qXt0IbASXhRAPqjs9Lw1JhFh6nLRKdHv4z8luAdBLhhxZGX7ADSz9Y2DM/nlSyj5r6X20fhilydHRVDdXWO0bfQzxXzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTn37iAvEn7fcKzCTDSgkM7iS6BogedQWHqeaIT0Knw=;
 b=j4HVyLSNaaluZwwg4kexKlZS0El18YWx7VELGRpKpxL4L1fvU/sd8im0VmVf/3S/hvJvaItSHtKB8e1O0WLGU9vteDCKgDZIIlajf1zXJoY6wYilOZPYqaEbUDi0COMxbpHbpHIrL2pZM3uL0USwBRPloH77w0XMkCGxD088u6NYGNoXBhrHqKO8/1Szh5XTiuQml0bMrnsb0IYq1rfnrcC4vG81Gsjpa2IshF7niXhHwdkmUqWPRbGd6idLkfOS257GGsDEi+g/TqRAvUPuZKPxJv21tD6hK8mRAuBO1JOyxS0Pesy5plW7XvRjVGOHuNsFktdC4pZSZrBps7+aUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from BN9PR11MB5354.namprd11.prod.outlook.com (2603:10b6:408:11b::7)
 by BN9PR11MB5323.namprd11.prod.outlook.com (2603:10b6:408:118::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 05:30:29 +0000
Received: from BN9PR11MB5354.namprd11.prod.outlook.com
 ([fe80::5e9:ab74:5c12:ee2d]) by BN9PR11MB5354.namprd11.prod.outlook.com
 ([fe80::5e9:ab74:5c12:ee2d%4]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 05:30:29 +0000
From: libo.chen.cn@eng.windriver.com
To: stable@vger.kernel.org
Subject: [PATCH 5.15] crypto: hisilicon/qm - inject error before stopping queue
Date: Wed, 11 Dec 2024 13:29:59 +0800
Message-Id: <20241211052959.4171186-1-libo.chen.cn@eng.windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0173.apcprd04.prod.outlook.com (2603:1096:4::35)
 To BN9PR11MB5354.namprd11.prod.outlook.com (2603:10b6:408:11b::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5354:EE_|BN9PR11MB5323:EE_
X-MS-Office365-Filtering-Correlation-Id: 013a791e-b5db-4ac9-a75c-08dd19a4ec81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MNe7sg2lXaBeP1MSrf7DLxJvAwxeLyXGD2+NGROKUG9wH82/rUETD4BozYbl?=
 =?us-ascii?Q?vSIEIZ/ma/EQeR1ViTgfNGO0zHlXUmNVyOHiLeAzg6qtRbiDtrbb0WIE+pxo?=
 =?us-ascii?Q?eYEkSmts4+Lfzks4mMqeRiR9T/tWjRexbC4kKyndTVj27VhYpsdUrtxClij3?=
 =?us-ascii?Q?gNFxnmLp7BDM+lVgliE++CtA2HTPlLDcibwQFOJ+H53kPwFz/YCgj1Bc1Wre?=
 =?us-ascii?Q?l++6Mmda+5h0oIKYKbdOiJUuGPvf5Az8/6QzCqIXWrhj8E4CcIfcMVXfGHyh?=
 =?us-ascii?Q?2rJIF70fSHL+0mN1JLPMzpBcE6SRLKvSvuO9diRAdW7dTlLkP5yx5nk2Bp3z?=
 =?us-ascii?Q?BWxl+7801QlfQ6teI00BSS7/dP8y4AObp7BjgsM5Rxl2QCs0CZCUHPJlHyzz?=
 =?us-ascii?Q?z6Y0TYWmuu2+527cnVzjSgvncBRTO1iY5J79SmjIoL3XblgE9Kyo9m0lXO0D?=
 =?us-ascii?Q?frzY4O7MBic0vE14KcXtb3BWoqbSxp2U+i4Wcq/N3LZEhSuMvbhOFrRHmmjl?=
 =?us-ascii?Q?uSVubenEMqxmO1EpHPRyFguUeuWDmSrAAjbwkd428kpwqgFI1AL1YfFMhNTl?=
 =?us-ascii?Q?ohodUdxj1Ck+P8B6evotxVRwgstUhTQkzyCdBNIGBC5x6gogqANvfiopY2BT?=
 =?us-ascii?Q?l5efT1VAxqV+urFjZzScP9qhVhyKcvSmz15uKChQ0tq4QYavZtXaM5T0MFG0?=
 =?us-ascii?Q?hoK7o2pyvr1YMAmb5DUoE96jJe4pMi6mHbzYs3vU1RFgD1Ba9NjwkioQsBQm?=
 =?us-ascii?Q?WhSqxx4Oui4Ur4FMECPI558Ab6XSQl5txXFT8uxvKlHgwM7Vi2oXECsYip3R?=
 =?us-ascii?Q?vQpquzg4g/0ybf1hdAhkYkzFwAPdV3cRxs4cFlA8+IpMhblhl2Pgf9Hnt43J?=
 =?us-ascii?Q?xuVetfploWKHh2Xj6oeAjG7uN4kUxsLOLv7F8q4/TTyEXnLfV5yHLjA3GYSu?=
 =?us-ascii?Q?g9HrVYVENENRu9jvQgm4wQkHyd5RNnhJHSqvlZWtFfSdKFAJsfkBpRetJ25/?=
 =?us-ascii?Q?ch5Kc3l76dLSjTGNBE1DiPszHsbyBonyMi8OCriyBFns+u+ywYvPI5nVTorH?=
 =?us-ascii?Q?4tiCsFv/J01qpK+V77wvCEnsE+f9a5L5Qv5621HFDNuDckw7CO9bmaov40sA?=
 =?us-ascii?Q?QlYCIW3iTmUPrzSoCobx2pEYg4qndR+Vun+G8C4eRfDDQkfBNFJFr8VNjaLt?=
 =?us-ascii?Q?7ageW9osfiiJ2fymsIRXjrA7+7rVTuCjv8FM70LkCUVQdusUEH+1TD6SWED3?=
 =?us-ascii?Q?t2U0a3y35Ni8jGYyJ/tAik9b/wJnHkXKzAtR8DdLYNbW/QKA6C1hbJjqN1l6?=
 =?us-ascii?Q?vuXWNw69VDMBHOZMQZRCqEMZ1I82Fu8i5H5eoP0kQVLOliXDy6allVExW+pF?=
 =?us-ascii?Q?j6+r7GqYWkooZB1uLshtAuZQLLGAcQXTlQ2odvvIkGs0e6qhIA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5354.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HK4aJnGF7c5XtI2No6gtMWEuRfGxsngR7if5aUgggM+/BLSrpQ0qOU990VDP?=
 =?us-ascii?Q?gfxXpq/T+O87dbon/tj+9cUrXOeT21Lg7xOqb4xmd9i5woNAj3cwMUGKlXpq?=
 =?us-ascii?Q?/WbxUkgQjsE6GCMI3LGkf8+UH16wA7yO7CZvKtOsQk6/wBBgKGaElvcyrSd7?=
 =?us-ascii?Q?85HIGOKlHjEnufW4IWXmDLkNs6fiDfPRFPc5YXqbxso7dKadYHpkoqai2Dl0?=
 =?us-ascii?Q?z16iRppkEmlTcAyvuf4BHeP//9Rx0wsAHp+FqU4akPN1ISwQwEfbDoqULZTE?=
 =?us-ascii?Q?mTiJzc3d1jU3DNl8QT92EZMmDV26APSgiD5ffHVYYER2w9HYiXJqTr5cum8N?=
 =?us-ascii?Q?l3ylhlpwfcpJK4NdNNMQrh9zDeUQNdosiXNAB769tfKmC6YrF1Ukssnw6ifT?=
 =?us-ascii?Q?ChSqGLp1gcilck5Ts9Jadcf9cUR+XxpQLOD0uNh9jTnumObPT9Y3QX9P4giP?=
 =?us-ascii?Q?sp6/vKhvpTbP0Ve0fINFP6UjW5rRdJ9Url7L3bRBr2d4Ir29gH6TMSgMylXd?=
 =?us-ascii?Q?Jfsc7vG2u0/FayT7G17dPKWoOxUjrAMH3JY6LMf9cPTlq6MwjCstnUrrU6BK?=
 =?us-ascii?Q?+Scq2ZWjZWSho7T3gzeXHgwc2fc4uYlYgj4asmPLlpYGFQtfhZlt46VNDEUN?=
 =?us-ascii?Q?PvYbVpWpXK55+2PngtaHCtTA+sYXNIQ0TP62wg4f7D3/+Dc0VR8OndMkrSFe?=
 =?us-ascii?Q?bKE/LWR0dUaRaxy+4egUHx8hOFi3OYeirOzWCfsvFhvhO/H4y65kzOq6H3W4?=
 =?us-ascii?Q?rq9XxbCblQKfBspM4M5lXcQPn7SEYwvPxSTsfgP4w5w/9W45fr8PLi8UWbaC?=
 =?us-ascii?Q?c8n1M1kWuFi0ZTfxKdmiF717c+w4dYtPrFEPQGVTjzDpt26jBnn0xureuJVx?=
 =?us-ascii?Q?Tq9Se2EqM7Zz09OuRYlXjQiofB/O7ttpyaIKsDqrJDlHd20yR2HXoWnCee5C?=
 =?us-ascii?Q?zxQdXT47oz5dy8fobDxSO5jjQWBj70d4VBVgnUaKoZbnsRyuuayHJztiBm1A?=
 =?us-ascii?Q?fQKuRj8bkaVan8dIwgXgXgY9vlcNuz0pb4oORQFgyXOXLuTr+b3pTMmfnf+/?=
 =?us-ascii?Q?G83HihW2CcSM8UwrvzH/NzI2O6jIzhemDrJ8abzP+L4gg3DD9egDOhAXGmat?=
 =?us-ascii?Q?S7GgHhDCkuF58IhFKJQ4zcndYDTHw8QHcw7dzbOeSYZYgJJ7uV83/trCKGib?=
 =?us-ascii?Q?Pl7jqTx0lBR+u0XydrouX96YIbHPH4t3iWcCyz6KgG0rrHvG6y3rLhWqaEng?=
 =?us-ascii?Q?QNsIm/8ffrbjPpSVe9Iu8b+rdQGR1WDL3qwgA7Dar2HSA/XJphyy69vD9R7e?=
 =?us-ascii?Q?lrxdqt4TF/eOJmZC4g6ZQl9+uf8ra8GaqqAu26gNvhpjnbX4wOc4ya4vHPb8?=
 =?us-ascii?Q?zM4gOYe2NFZjXB4Qcx7iGrrzwVlhl7uzqbqj2Lm2ctOV2sTS1kSRSpGEPEZ3?=
 =?us-ascii?Q?LcrYXTFAK7968TdBZYYhiGcZU/MqK5EoR4CZQ1UKcWgML1Oq5vaL6BtehZUG?=
 =?us-ascii?Q?9CJOho7OuNqIrTKXrsALm6NEYvEr5c22bNjJ+p3KvxsdXvlIYhlBDFOB5kLJ?=
 =?us-ascii?Q?Keg86mmDrnKNG7oAFjz6S6qdSHLNFGR32EYcc6RJgcVeakk0vGu6s4RbiAXN?=
 =?us-ascii?Q?Kg=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 013a791e-b5db-4ac9-a75c-08dd19a4ec81
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5354.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 05:30:29.1782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZkeRN64Y9X9Jw1HIVSkCSxCmUjad2KNWETQk41E0D2kOKDgD1e1x9bkGfhc4dDF4FJlEviXhTYCB+eJk5ph7tRbIt90YY6GOR/CKMp5GlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5323
X-Proofpoint-GUID: 4MWCvuoHERCUXnUMTb6dSZYCAqIzfOaq
X-Proofpoint-ORIG-GUID: 4MWCvuoHERCUXnUMTb6dSZYCAqIzfOaq
X-Authority-Analysis: v=2.4 cv=D7O9KuRj c=1 sm=1 tr=0 ts=6759237a cx=c_pps a=t4e0UQJdoJrPmzgCWb9hsw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10 a=_Eqp4RXO4fwA:10 a=i0EeH86SAAAA:8
 a=FNyBlpCuAAAA:8 a=t7CeM3EgAAAA:8 a=mzVGTZs34JFsiwU4K9gA:9 a=RlW-AWeGUCXs_Nkyno-6:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-11_04,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 mlxscore=0 impostorscore=0 phishscore=0
 clxscore=1011 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412110040

From: Weili Qian <qianweili@huawei.com>

[ Upstream commit b04f06fc0243600665b3b50253869533b7938468 ]

The master ooo cannot be completely closed when the
accelerator core reports memory error. Therefore, the driver
needs to inject the qm error to close the master ooo. Currently,
the qm error is injected after stopping queue, memory may be
released immediately after stopping queue, causing the device to
access the released memory. Therefore, error is injected to close master
ooo before stopping queue to ensure that the device does not access
the released memory.

Fixes: 6c6dd5802c2d ("crypto: hisilicon/qm - add controller reset interface")
Signed-off-by: Weili Qian <qianweili@huawei.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Libo Chen <libo.chen.cn@windriver.com>
---
 drivers/crypto/hisilicon/qm.c | 51 +++++++++++++++++------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index fd89918abd19..58e995db3783 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -4638,6 +4638,28 @@ static int qm_set_vf_mse(struct hisi_qm *qm, bool set)
 	return -ETIMEDOUT;
 }
 
+static void qm_dev_ecc_mbit_handle(struct hisi_qm *qm)
+{
+	u32 nfe_enb = 0;
+
+	/* Kunpeng930 hardware automatically close master ooo when NFE occurs */
+	if (qm->ver >= QM_HW_V3)
+		return;
+
+	if (!qm->err_status.is_dev_ecc_mbit &&
+	    qm->err_status.is_qm_ecc_mbit &&
+	    qm->err_ini->close_axi_master_ooo) {
+		qm->err_ini->close_axi_master_ooo(qm);
+	} else if (qm->err_status.is_dev_ecc_mbit &&
+		   !qm->err_status.is_qm_ecc_mbit &&
+		   !qm->err_ini->close_axi_master_ooo) {
+		nfe_enb = readl(qm->io_base + QM_RAS_NFE_ENABLE);
+		writel(nfe_enb & QM_RAS_NFE_MBIT_DISABLE,
+		       qm->io_base + QM_RAS_NFE_ENABLE);
+		writel(QM_ECC_MBIT, qm->io_base + QM_ABNORMAL_INT_SET);
+	}
+}
+
 static int qm_vf_reset_prepare(struct hisi_qm *qm,
 			       enum qm_stop_reason stop_reason)
 {
@@ -4742,6 +4764,8 @@ static int qm_controller_reset_prepare(struct hisi_qm *qm)
 		return ret;
 	}
 
+	qm_dev_ecc_mbit_handle(qm);
+
 	/* PF obtains the information of VF by querying the register. */
 	qm_cmd_uninit(qm);
 
@@ -4766,31 +4790,6 @@ static int qm_controller_reset_prepare(struct hisi_qm *qm)
 	return 0;
 }
 
-static void qm_dev_ecc_mbit_handle(struct hisi_qm *qm)
-{
-	u32 nfe_enb = 0;
-
-	/* Kunpeng930 hardware automatically close master ooo when NFE occurs */
-	if (qm->ver >= QM_HW_V3)
-		return;
-
-	if (!qm->err_status.is_dev_ecc_mbit &&
-	    qm->err_status.is_qm_ecc_mbit &&
-	    qm->err_ini->close_axi_master_ooo) {
-
-		qm->err_ini->close_axi_master_ooo(qm);
-
-	} else if (qm->err_status.is_dev_ecc_mbit &&
-		   !qm->err_status.is_qm_ecc_mbit &&
-		   !qm->err_ini->close_axi_master_ooo) {
-
-		nfe_enb = readl(qm->io_base + QM_RAS_NFE_ENABLE);
-		writel(nfe_enb & QM_RAS_NFE_MBIT_DISABLE,
-		       qm->io_base + QM_RAS_NFE_ENABLE);
-		writel(QM_ECC_MBIT, qm->io_base + QM_ABNORMAL_INT_SET);
-	}
-}
-
 static int qm_soft_reset(struct hisi_qm *qm)
 {
 	struct pci_dev *pdev = qm->pdev;
@@ -4816,8 +4815,6 @@ static int qm_soft_reset(struct hisi_qm *qm)
 		return ret;
 	}
 
-	qm_dev_ecc_mbit_handle(qm);
-
 	/* OOO register set and check */
 	writel(ACC_MASTER_GLOBAL_CTRL_SHUTDOWN,
 	       qm->io_base + ACC_MASTER_GLOBAL_CTRL);
-- 
2.25.1


