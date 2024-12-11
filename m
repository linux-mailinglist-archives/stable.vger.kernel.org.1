Return-Path: <stable+bounces-100522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EB09EC35D
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 04:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A13DC1887774
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 03:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AD6209F23;
	Wed, 11 Dec 2024 03:33:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509EC6F073
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 03:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733888013; cv=fail; b=RlfdhdEj7LtwWkEzBc1HpVfqeho2neqmMW+kIjsEEzhSLgjICvwEgjCiBSGvY+Dyg16EPxakBCGgZEn45f1XXZM0jkIp1Wohxi27Eg/359u609wspBCuHXz3TuTvO7O0ivmARoLsRddP7erdI7XbGQ6H4AAwASO/dmwAoztxBqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733888013; c=relaxed/simple;
	bh=Mls1+NoJA7xFbhNBqDxx1NftAwJQQHfUGP/CL/qDWuc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tbZjxcDX209Ur3ten0KjqpryzbNLVJVcvWOHnhBGDXDdky02Mzm9CWGt5ZcIr79Cg5X+5kNR0Pl+MQUg8uAnArJ+YFCvdmjI89uz1X7dPj5VKY/1+O8XDop5Uaamiz1xIcs+n+Xqd9c4SJcXJenF0FIPDDwKN95AHJAi4EVcr2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB2KPRa026736;
	Tue, 10 Dec 2024 18:54:33 -0800
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cwy1up7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 18:54:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GsG828YC+uBdEDwJqEG2jSt7xL7JhXnBoijh1DfrXR9k8ktMeUSpXFtsFZ/89PN7+7zLnmlio/3FO/abCBtpwpbVPSUdUFIVgNRIR8fEQlXQN8uTJMednQvmNwkItnskBgzmG717CoFYA8rpXoRoj7MTgR71Da2ZE14DgHSXfnSL+rGd+1hzyEfhkl3juZn3L9wKld4Xu/40r5ydRvZLhb9tAI/JFavebtCyJ4qx7G2wDB3BtJaTZAUIIRKW2S3b6HHJBkXVutreT3vdzsrLhZpCBhnL7nOUgJw2EllJhSdsmHIIenPppFQHblF/9/bFQFkQL4hIo5sEe19Aodce6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fh6rr+OFc+uOJIzRZdbpr1JYYmj3SPFYip7tqlFpic0=;
 b=UPBum0JS7nKNNTN0YHFYDnaHjbVu0IhQSbyrdMvlvLC8BnmnXnnETPe6dQh8BscoLavi1RWk/F4Wqgb7HbxMwFCGnC5xL8sDU6tUuH/bRV+XllLwA6RuPzlwEFxM49xH/JWJMNErSCF6NFuK/xGmHJH9YL3akJa9VWRcgmLwtCZYRzC3FMvTPtfASZ8oZSHzmoinSYbg/CDicTnDRW12oIbcNksXOl9Gl9HjCnFP9CfGmCNMiiXeEK9sqIZTPqBxkq83UGFjZWNcf4lNTiE3vbVhGurcLh9qh2QiF+wjsTUUT88Hmm8+X0e3jwhx9B8y+3VgX5o00u99XGEx2699Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN6PR11MB2671.namprd11.prod.outlook.com (2603:10b6:805:60::18)
 by MW4PR11MB6690.namprd11.prod.outlook.com (2603:10b6:303:1e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Wed, 11 Dec
 2024 02:54:28 +0000
Received: from SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326]) by SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326%4]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 02:54:28 +0000
From: guocai.he.cn@windriver.com
To: gregkh@linuxfoundation.org, luiz.von.dentz@intel.com
Cc: stable@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: Fix uaf in l2cap_connect
Date: Wed, 11 Dec 2024 10:54:07 +0800
Message-Id: <20241211025407.2948241-1-guocai.he.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0123.apcprd03.prod.outlook.com
 (2603:1096:4:91::27) To SN6PR11MB2671.namprd11.prod.outlook.com
 (2603:10b6:805:60::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB2671:EE_|MW4PR11MB6690:EE_
X-MS-Office365-Filtering-Correlation-Id: e70346ea-06ca-4b87-c673-08dd198f2110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fkeJ4vhthuONObn/ZDNw9vUgHFV5kIJAOVd4O/fuB8SlUkZWc3z8ApicLhQh?=
 =?us-ascii?Q?wwA0jPi2p9+PBmjV/pxQmGzg9IBut/xW7U0r48eRwL6IRqbr1UkPtfEC2oA5?=
 =?us-ascii?Q?lZHXZvKS5eZjXD2sOC7VVw1d2JDoLKqdjT2b+gz1GdvmNM882GGURkXDUqDE?=
 =?us-ascii?Q?zR60fcNZXipelMzojg6d+LZyFzIBA7K+ddjBMFKEIBdV/kbsU9/YfY3fRefI?=
 =?us-ascii?Q?X+j0HoQ1PrE08KxHk1Y4oblYiTmJGywPOIivJF/9onQJZ6ntZgrGlSGbivgv?=
 =?us-ascii?Q?+MjPfmwqroNTkz405EA336l2Foh8PmE3GQYhHR3kkYsH3qbFIULGMc+wme0K?=
 =?us-ascii?Q?aiyHKa81hZPrflbkswfHbqimzO4PcWzB2EGYArv5lGJ/zfFHtrduk/dFaR2W?=
 =?us-ascii?Q?j80WjxQD3t/DuN5WomLCCD7HUewe+0V8jv4wjoTkHW1Ftuxe/LDAf/tqlp4v?=
 =?us-ascii?Q?he24nnWHvdclYi4gDB1M/2FL6yXKMSBFvh/67wvoddnp7c6+LcCVjReoUsji?=
 =?us-ascii?Q?sBFlqmwUGnPOQX0rG7jdSi3bexcze/xB7wUyvvpj0O5pLHNKsPf3QELWTCas?=
 =?us-ascii?Q?Ye7jod7/P7smfcQ+f7H0mcwZkpnWPN/MEYujgYZ516D12/pbEp/WnXxq3dtL?=
 =?us-ascii?Q?P0AVd+Xv1ZILQBaGllvYmNcEm81SKlvVYfEuxy5p0WUeM/UWIrDQMN2E9cfO?=
 =?us-ascii?Q?ObjXsJYtWSY/YsoRKBeLR2qVk9FCp4Nm6k/dtU7O33phpYt3p9Yh+XjHFGTS?=
 =?us-ascii?Q?zslfRNdyaQQRBuUSUHIxRpyKoEaD0OKM6ys7FA8L9Mc8ch2nCu1uVKK6sZQD?=
 =?us-ascii?Q?tL8C3Rq+NZPujofRQR+8NMK5B11X4z9EeXgXgs+rD5lAUKGHZWmeTWyZgtjf?=
 =?us-ascii?Q?8sMH4qDZKihNf0bKPc6TV/FUIOC0tFRDZ0uBn60uFVQz/P3QgMyGb1jVir5h?=
 =?us-ascii?Q?XLvUdF0eXXXiHvTcQJFJ/KIeVdLVqaPuCHUOtTKJ8XoxlgfwwgAQumLcJtEz?=
 =?us-ascii?Q?cmf/pGALT0+EcG0351OKN5taPJj83drof8y+4Pw9OEQy3r61g4iH3PSXU3QR?=
 =?us-ascii?Q?+q4msZRF4nZb4NewoXb1t+qlbTFGnNSLHd1YUDLWfiJ/2OD1I24iLwZu3Rh8?=
 =?us-ascii?Q?xCbXGfcO/bL4PBdJ+KsREWaVwN6lO2Ur5fjUB+lr2gysEyrKG9eeeWuIiN2L?=
 =?us-ascii?Q?E0izLQ/qNVLw+9VVcmVsIlprMS3dhzwOSWkywK3HqGwCti16+/s9U/CWhRl0?=
 =?us-ascii?Q?W/zvnEF8JVtnD2CR9ijmUR1QLpa7G1tnX8xDHEAVaxR8s9IEdp+zWsdX0Ghv?=
 =?us-ascii?Q?AA2KFjj5mu97BE+ayajvda4wUluiuq6GFrLETn4knuP3t71IZiwSUoTPX2S/?=
 =?us-ascii?Q?CYIRSf4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2671.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y1C70Key8YDys1ykuvEV863086HAzFLZb3GJJF3GsGZ+bLuoVFspCVS3lxtd?=
 =?us-ascii?Q?D3hNYS9UB2GX4T2pqJgR21aZ5+jGPPwL5L1BvSn5U4oLFYlc/9bgyyVe1UUO?=
 =?us-ascii?Q?6DsmmW22mohlaJT8Ahm0pYzjxIh20nBEMKKRqnG8PaBpe4jsCok+VdtwPr5K?=
 =?us-ascii?Q?/7dTehzHmEibmq125xosOn1NORfXfl/TPmaWoHYsS6gETrIOvtWvwmorvp3x?=
 =?us-ascii?Q?7R+EJByHMs6taFa0heSkm4ZNP0l1Ydt+p9DzJgSCKUNB9a+GOM0MPgT4y/Av?=
 =?us-ascii?Q?M2w2QQBvtc1itsmY2byZAWY7AZbrCDPsgYzEeFU3DjFcCEo+lA19HKH12ZzY?=
 =?us-ascii?Q?IaOHdpSm3K7JYfT7ojv4kPVdKV83AvbzVWPg6uxIJ76pOKEZK/GpnYTMKbKo?=
 =?us-ascii?Q?fQKb/Bpf2nuNEoEJViB07HhvU0c1GnzhgAyWtyE5eQxLCt2f0EhlvD8C4puP?=
 =?us-ascii?Q?/g0HiE7pbzQuLyry0h10Ugdgmcg6or2j2KW5LR5B1usLWXZ9eSmdHXJdCdCa?=
 =?us-ascii?Q?6onktwLL4yQzk7Tv3uoXCJ2qFTcWVqVdrb6PS0s4ZSNuPJnjmOEYD21WVtDL?=
 =?us-ascii?Q?8ohbj92GG4YiXqAdG/TdWLxcSybWLvtHFPRScxgpsh1K8ZAYgPTLyLVOIZCV?=
 =?us-ascii?Q?Iri92Iu9x0h/tnL0o20gfN9ZcRy6Ki5q+Bd0kMj1sIfGoimFAJ3xyZtblhn0?=
 =?us-ascii?Q?R0PTq6sMjqwoJYiWVtAVm8xDTUZ/lDwMv705mznSD3bT/rgl0WtEjNt0QADw?=
 =?us-ascii?Q?htAdPo3bCy9ru8AYUEEO//nsLGdPvdGljwcrsNcLLYQzifYeRWzTDDqVZ5ZM?=
 =?us-ascii?Q?idaq2UNGRtZvv0J7Fn74oGXZf43DXui6v3uvFgbpWG6iHN/vyxfEBl05xcBS?=
 =?us-ascii?Q?UNxjLCPn2v6OroM8w74DjEhoVj1Tmqs1tLkLD3Vbg1tRFig5RDt/wsLkigxp?=
 =?us-ascii?Q?Ab7yBGTtBaHDS8XbkqQ4hnQR9vsR03pSQHKk6v+MNOaU+lc0Crokyn5uzd8m?=
 =?us-ascii?Q?3a6y/jxAwtg8NDrZIg+/PY6J3MniI8h9rXRNUGSr+Iq/KHpR0A7xUXs/RS0q?=
 =?us-ascii?Q?mVsy3BA3BAm627Yp4QTxN8iigZERtfDAtvbT/zfV8nIUBj2NfltUKu+1zsVv?=
 =?us-ascii?Q?SFwb5rtyA8W2JZ7QSPSO4kaTsOZi5vL9MDxx5Ge1rg297nR3RJ4eCkKCzO22?=
 =?us-ascii?Q?gYYVbSUb+WQfowDUqfk8Wplr4v79KlUvMZBGqxQjt2AhlhAZ5q8rBHNN2Rhd?=
 =?us-ascii?Q?VJInLo5PA/Gesoi84cBttNERY5+As+z/RTllX2e5l6ibZ0XBaXeJkoo+VMRW?=
 =?us-ascii?Q?XdhUtMRd/DQnVNcaSrMju89filYDxoSS7oBii8RQuMW4eAZCEU0vJ9qA/VdO?=
 =?us-ascii?Q?jbLC2X3S39cY7v3jR8muRbiWBGH3U42AJ+t0WlDRhp/LibbAKqp2kwIvkOsB?=
 =?us-ascii?Q?WTuLPOAENfUI8xWcD7tF/e6b5A1Biu2AJp2BEFY5PVb3Mq2MxlIKaB3sIly1?=
 =?us-ascii?Q?5/8XCPIy/qHdSbFuKkiB4K4rteQwCD2J68huzfu1Go3M+MMk+gbzYwscCGuX?=
 =?us-ascii?Q?oZrYgdAUuP6v34bfBp7Rc0bR7mkDRhAlYFw1xflcqF5O3U6ysIMRSNdBS5P2?=
 =?us-ascii?Q?Lw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e70346ea-06ca-4b87-c673-08dd198f2110
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2671.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 02:54:28.4033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p99jm1LtbB3OOrf2GJ/aAGZtR8F/QLF+G+6RFAvt9dz+EN8lrrfkNgGf5bblrZlNin7ROyicXVxWy2+R/U57TTB3+2lkfrkps7fPJWZngFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6690
X-Proofpoint-ORIG-GUID: K-HbPXgEjBeFYdlb1XQsLolqXT4Ouw65
X-Authority-Analysis: v=2.4 cv=eePHf6EH c=1 sm=1 tr=0 ts=6758fee8 cx=c_pps a=6DIaztarb0XTwjBPIWoXxQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10 a=bRTqI5nwn0kA:10 a=edf1wS77AAAA:8
 a=QyXUC8HyAAAA:8 a=hSkVLCK3AAAA:8 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=ag1SF4gXAAAA:8 a=g0madpK8VFEgJAoBwicA:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-GUID: K-HbPXgEjBeFYdlb1XQsLolqXT4Ouw65
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-11_02,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412110022

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

commit 333b4fd11e89b29c84c269123f871883a30be586 upstream.

[Syzbot reported]
BUG: KASAN: slab-use-after-free in l2cap_connect.constprop.0+0x10d8/0x1270 net/bluetooth/l2cap_core.c:3949
Read of size 8 at addr ffff8880241e9800 by task kworker/u9:0/54

CPU: 0 UID: 0 PID: 54 Comm: kworker/u9:0 Not tainted 6.11.0-rc6-syzkaller-00268-g788220eee30d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: hci2 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 l2cap_connect.constprop.0+0x10d8/0x1270 net/bluetooth/l2cap_core.c:3949
 l2cap_connect_req net/bluetooth/l2cap_core.c:4080 [inline]
 l2cap_bredr_sig_cmd net/bluetooth/l2cap_core.c:4772 [inline]
 l2cap_sig_channel net/bluetooth/l2cap_core.c:5543 [inline]
 l2cap_recv_frame+0xf0b/0x8eb0 net/bluetooth/l2cap_core.c:6825
 l2cap_recv_acldata+0x9b4/0xb70 net/bluetooth/l2cap_core.c:7514
 hci_acldata_packet net/bluetooth/hci_core.c:3791 [inline]
 hci_rx_work+0xaab/0x1610 net/bluetooth/hci_core.c:4028
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
...

Freed by task 5245:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2256 [inline]
 slab_free mm/slub.c:4477 [inline]
 kfree+0x12a/0x3b0 mm/slub.c:4598
 l2cap_conn_free net/bluetooth/l2cap_core.c:1810 [inline]
 kref_put include/linux/kref.h:65 [inline]
 l2cap_conn_put net/bluetooth/l2cap_core.c:1822 [inline]
 l2cap_conn_del+0x59d/0x730 net/bluetooth/l2cap_core.c:1802
 l2cap_connect_cfm+0x9e6/0xf80 net/bluetooth/l2cap_core.c:7241
 hci_connect_cfm include/net/bluetooth/hci_core.h:1960 [inline]
 hci_conn_failed+0x1c3/0x370 net/bluetooth/hci_conn.c:1265
 hci_abort_conn_sync+0x75a/0xb50 net/bluetooth/hci_sync.c:5583
 abort_conn_sync+0x197/0x360 net/bluetooth/hci_conn.c:2917
 hci_cmd_sync_work+0x1a4/0x410 net/bluetooth/hci_sync.c:328
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Reported-by: syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com
Tested-by: syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c12e2f941af1feb5632c
Fixes: 7b064edae38d ("Bluetooth: Fix authentication if acl data comes before remote feature evt")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Xiangyu: Modified to bp this commit to fix CVE-2024-49950]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Cherry-pick from b22346eec479a30bfa4a02ad2c551b54809694d0
CVE-2024-49950

Signed-off-by: Guocai He <guocai.he.cn@windriver.com>
---
This commit is backporting b22346eec479a30bfa4a02ad2c551b54809694d0 to the branch linux-5.15.y to
solve the CVE-2024-49950. Please merge this commit to linux-5.15.y.

 net/bluetooth/hci_core.c   | 2 ++
 net/bluetooth/hci_event.c  | 2 +-
 net/bluetooth/l2cap_core.c | 9 ---------
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7dff3f1a2a9e..a6039adf94b2 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4960,6 +4960,8 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 	conn = hci_conn_hash_lookup_handle(hdev, handle);
+	if (conn && hci_dev_test_flag(hdev, HCI_MGMT))
+		mgmt_device_connected(hdev, conn, NULL, 0);
 	hci_dev_unlock(hdev);
 
 	if (conn) {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 13d397493e9c..50e21f67a73d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3338,7 +3338,7 @@ static void hci_remote_features_evt(struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	if (!ev->status && !test_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags)) {
+	if (!ev->status) {
 		struct hci_cp_remote_name_req cp;
 		memset(&cp, 0, sizeof(cp));
 		bacpy(&cp.bdaddr, &conn->dst);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 4d5dd82f2614..496634c359eb 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4276,18 +4276,9 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 static int l2cap_connect_req(struct l2cap_conn *conn,
 			     struct l2cap_cmd_hdr *cmd, u16 cmd_len, u8 *data)
 {
-	struct hci_dev *hdev = conn->hcon->hdev;
-	struct hci_conn *hcon = conn->hcon;
-
 	if (cmd_len < sizeof(struct l2cap_conn_req))
 		return -EPROTO;
 
-	hci_dev_lock(hdev);
-	if (hci_dev_test_flag(hdev, HCI_MGMT) &&
-	    !test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &hcon->flags))
-		mgmt_device_connected(hdev, hcon, NULL, 0);
-	hci_dev_unlock(hdev);
-
 	l2cap_connect(conn, cmd, data, L2CAP_CONN_RSP, 0);
 	return 0;
 }
-- 
2.34.1


