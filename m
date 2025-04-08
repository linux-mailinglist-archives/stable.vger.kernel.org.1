Return-Path: <stable+bounces-128840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DADDA7F603
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 09:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8E5189B0B0
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 07:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708552620CA;
	Tue,  8 Apr 2025 07:20:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542FA4CE08;
	Tue,  8 Apr 2025 07:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744096853; cv=fail; b=bEegrg2jTeypmEA4v3tXjB6pB8j5LNpaVXpgbTWN6Cag+c4XNGU0e1xL6QbF32q2T2MQJBnvRclXKQ4FCmWOb8ga8390JrFt/+16HqsCyPXKkciPqcVlY+L9UPpZmIYHsQTIbaswKYm9nUiPq/agrXDYyNavTccDfimRd3PsKG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744096853; c=relaxed/simple;
	bh=LtkeNGjAEUSAwO1oF2K16zTjJO18XA9RjlrrEXG0PTw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ew4ufREiC8QFctuT+rpbiV2C2QuGTbH8lFnnneXbpGXJTemxvMhteQX4jzzPEpXuq2IC26aZDYb3Rf+f9pUocSsWDTl2DBxST6FmueFf3rGxAwIR7tsw8n/HzfXEdDSKtpomPkQIKPfNM82RbyySr9AsBrTPvdVsi4zSiP+RXCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5382e2Ek026859;
	Tue, 8 Apr 2025 00:18:24 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45tyt4b74a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 00:18:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBmxdrFBqNBO8qrsj0LLfBxQQ2PkUC7c15r1Imz7txS6xbxnYBwnQBhuL0hcxx9+8MNrPZoR0igi3UkBsqacd6nhZP201z3EgkQccv8LNDoQRQZTW0vbuCxBavLeHF7W8KKokgYqKi73jvdqd519lZoH6wpX1Qoomopg/XlxbIwyDsb2gqrFBrRXEHGW/31Vpv0HBEy0uP1ny8o1z5lJ+AGVimrkt3F0Xtmk53QyTXJk6WFoW4aXrBwSM216gNrn+aR3NFZ5OazQoz2dkF7DrFv6zAaORoxdIXTg+ENdOYk7A3RDQ1xperOmAFcZne9kJc14srM6ib1/9oWXhTMwRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPCm6IVxHW2OegHNlY4buw+lYgqoJGsh55tCFxRtPq4=;
 b=TGEzWcN2h8BYdeZ3X7UtYy+75kXnaaZZD7YBXTB88cgWquwnBNxLy3ShZxe+P9atP50t+TCfKZMqi1xMiA7vlAfRaXeHCHOZHw9V4FUfvaHdcAaDAuSt3KN5VzkE5pG9hJ7CSxbizdZmjqbJN/BmAV6OnqW+dGesE6U6bVS6ZdSrAOE8TkaN9mLh1Kq8yRVh+b7gJMseA4Bh2sr+UjljC8jXmxyBZ6q+u3I78AEC2Tq3FE4hdT1EQpfFKUAUYzzfvjA/Jh6hKP0pDDIx567EPk7W0onYTpIydRzRiRhIHSadTzWFjoW+KKeIzpBj+hoXznunCG9AVacOJ9ozTtFGug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CY8PR11MB7012.namprd11.prod.outlook.com (2603:10b6:930:54::6)
 by SA1PR11MB8489.namprd11.prod.outlook.com (2603:10b6:806:3a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 8 Apr
 2025 07:18:21 +0000
Received: from CY8PR11MB7012.namprd11.prod.outlook.com
 ([fe80::83d5:946f:3692:8c0d]) by CY8PR11MB7012.namprd11.prod.outlook.com
 ([fe80::83d5:946f:3692:8c0d%4]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 07:18:21 +0000
From: Cliff Liu <donghua.liu@windriver.com>
To: stable@vger.kernel.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhe.He@windriver.com, donghua.liu@windriver.com
Subject: [PATCH 5.10.y] nvme: avoid double free special payload
Date: Tue,  8 Apr 2025 15:18:07 +0800
Message-Id: <20250408071807.1002129-1-donghua.liu@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0130.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::18) To CY8PR11MB7012.namprd11.prod.outlook.com
 (2603:10b6:930:54::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7012:EE_|SA1PR11MB8489:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b29802-fee7-4d82-dcaf-08dd766d8aa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TLOjqD5+tppPpaHFurgjyvPmUVjmJR9yMhJ02VinQr2cfuvt/st/7xaYxoQS?=
 =?us-ascii?Q?UDU7mZb90wYPfxG3JEBUf1Lk/B5HaKjxmMqWmpbF3Gj0B9hgJVLS/c+ysM17?=
 =?us-ascii?Q?DNPwAWituouhMShWl0XcOqrQ8UW1O4aCdWb2c6LAASHT3FOEBjVJeUMmoAby?=
 =?us-ascii?Q?mKM1uNqHDt+vvpvg5+0hf95TKuqn8gkMursUoYReATOaWQ1ce7+MnEVt7Inn?=
 =?us-ascii?Q?jGn3Q4IIm6U5e7zN2do1Xf2/UqKPKY3WwJc3aqO3O5Shj5q4sS0lRK1QCWF4?=
 =?us-ascii?Q?rb2/HANfPwCObNq0VgDktR53EzLIMkQsobwW3GFQlPtGFXbkvVrV/ZWsmr21?=
 =?us-ascii?Q?DBVHQD8BsFgnPEOx2f65+9hconWEAKfKv419MrhdIF36geAUf6woABXCVDEq?=
 =?us-ascii?Q?W6fV6UksyK0l4wgofeWkKMzRG3Z+W54DrAHT5c0ABnxQcHrXDUCLMRSsptxR?=
 =?us-ascii?Q?AkzlQ28DqJ8npk9u3NvkqHZOxMVuNWpOAhi206Fv6cuQmBLGIred8bh1ZUO2?=
 =?us-ascii?Q?y5Ev88x0lUWwP+DT/DAweYd5nNAW7kdSo5mYw8V0867xYT/AsDTxzObGTyqd?=
 =?us-ascii?Q?Klc+7XJ6zB446xbUKJKo4pk+cX/5K+TXbGCviiGEKlASNtmS7wAHMVwqNoq7?=
 =?us-ascii?Q?ooDZ+QRqyikXRKMZzcccgCG4F+rl9FG+2hGjxkSOHL+eAV4cy/Xu+WA92Oey?=
 =?us-ascii?Q?IT3k5iIRj5iq02JoMEJDNEC35TGszj54X9Xapip6N+Hy7D1Xl+XszUMRdkf1?=
 =?us-ascii?Q?NIs8LhbyRZDUF5PfTFHi99XxDIDp0lNP6g5NFDFu2uumi4kSzEbEXUZkd+z/?=
 =?us-ascii?Q?gK1x6+Jgnt5pkXE8oZTlvbs8fvz048rsJuE20g6uoc5HvzaSRxfWm/kNc+Ld?=
 =?us-ascii?Q?c3KQQKbK3yV07llNyB0rrUk0qha0agl32f456Aaxb+xRD4CNvicWC+ScETKF?=
 =?us-ascii?Q?oFs6XBLvZLHq/q2QucZxp6E0htryoHFMJujDkYa2fzyxk7ReWW1IGln3KsPM?=
 =?us-ascii?Q?rJQFuowgsF+zQqeXul1waxIG8JHlCSvTW7pcWFa0PBrU9mYiCTGIWF3FMEGQ?=
 =?us-ascii?Q?w8w013wyU4WBJyTUTt1PkYBsmJUoP1qXqEA1tlbOi7AAyyVdZRXd8bAGOwFt?=
 =?us-ascii?Q?fOd2cGoAEgM8Gmi5dGj/zrdgXwa8xrgW/XBF/BDRmiziWKyk+zsTfTNkY7vW?=
 =?us-ascii?Q?uEZdC9r8uDVf+2gU9l58iQ2VrH1PhoaIbJPifbj+Cb5NtXC66wd7wDfReN/r?=
 =?us-ascii?Q?4gmIhqCHLfkaGCJqZv7HYd3GQqcuZtAdDzNOjJUBoKUWNT8pLHz7h4jgLv8w?=
 =?us-ascii?Q?E+qjoQKTi28LSIxEtKrtQjm7mjEK+bUoExE29nNUH40geN7z5zh983fjRLEs?=
 =?us-ascii?Q?17C+zGoMpy9ImicKSWUrTykOYyHi+osoJo9L4C+4Ekx+VHW+b6aWhqZmDBhr?=
 =?us-ascii?Q?ZgEwgFDwV9TrJOObAMrmaVtpViZ1sFkH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7012.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0fZXsNUQhlIBoAZAgBWiASorCKxkg+6CbnMjY0jtt3xaQNTzNB6DgsDu6UJo?=
 =?us-ascii?Q?RwmnOv8FN0+xqKDSyvPYVjNi6kN7AEm0ux0cYFEvIK4+jQ9XSg0vZQsJ8WGP?=
 =?us-ascii?Q?fXLhxQZXFeFp5mtoydXWMQMKeME0DuGW8V2kkJWffSVmOTlHziCFWBe2CEOa?=
 =?us-ascii?Q?ADJUiZLQBFy/moybbGYiLZ/7XfTCODwwkpU5oDPaOgnZTkwCbvdInVVzSneY?=
 =?us-ascii?Q?xW+FOPqZhnHbh5q/UMVcqeHvPvKkqptkFuAWGzVUPLpugYXCwIQmG4I2+1+5?=
 =?us-ascii?Q?tCBxB4aoj9Eb7bd7hgOQ5SZV4Y/WtRG2QOBrxdrj3WJzQd4fq1/WfkS4l67v?=
 =?us-ascii?Q?tCK8cxe++N52zcqIGS7T7TOwFQrMxjwwPZxm9Ua3afZej+006ceGWO2ek25H?=
 =?us-ascii?Q?DOrUTH2aNZ1k53dHswKkY06KvWLZKXzYrzF7UWevD6ENausG1rCGbTFUVsr4?=
 =?us-ascii?Q?cKKkbCtfawlXb3RTJLWgd5j29HiCJpM6C+1CyjhPJnKk75UqGRlGN0zQNvqO?=
 =?us-ascii?Q?bYI88V+wTkXGxmU/vzwfXxeORFjmHtg0ihRWDyXk2DKsYiCGP5tsmG8t13dF?=
 =?us-ascii?Q?PT8CwG9mfzzVxlcvLAXeX5cqYczhjnXrENvWjHCD/itF2WkjU8Hlk0VAZ9/z?=
 =?us-ascii?Q?NwBTzRcNM7JS83Gz6LLxkhOypTvWhiNifGGyWASprdowoehMGpCEQPEQ3Wrm?=
 =?us-ascii?Q?JrQWBbHXWQZZ4dLL3nKH4FAPLzhyxfEK/e5SnPARB/uQlYNWJTQw13IU/os0?=
 =?us-ascii?Q?G0flB9XHHW+d+fz9NzjnffGZABRTnYcWUyUNkpYNAPzHXmhlR6nhZ5CKu/5b?=
 =?us-ascii?Q?i+zWcXppvGZ9e7lAPoJ2JDnqn6kFJN5bU3u2aYv73ik987XWsm20L090Y2a1?=
 =?us-ascii?Q?cjemK8qrg5xfw5EDDq0VCYerwRc+qYFCTUyGvmoHrct/K1yfOwxBkChyqiJc?=
 =?us-ascii?Q?fKevjDngOe8j65fvnEprRD7lmgQyPLb6tk716KZyWj9Uq5K1F5sSp4B8D/eM?=
 =?us-ascii?Q?gcNEIgw9mceyVtroc8xQ5QIc7AGVzsVYm8CQ9bBW7eh2SpZUBsdE6dGUrPbi?=
 =?us-ascii?Q?5dRoioGfg5+OMBbkkPmjXiE4omDSv4TPHhh4rTg0TeluM/a3Br3uLMbOOnfW?=
 =?us-ascii?Q?TfFFHo7mutCf/XgUvqrmqJrbsfjzGY422J9A4dxb1LGBqmIjI/e00ujIrSnh?=
 =?us-ascii?Q?39Pz/p+UDwZyeHNcYtnpdd9YgL2baqOZP/fU1aeTKzTpEsUITlRAK4wDXxoE?=
 =?us-ascii?Q?o7m/wAgcfDIhuOoVQEzzocC+6HhmtgG9wPgmSS6HDaDI2/Sg905covdueeLO?=
 =?us-ascii?Q?G6HR926DysbgXbygXGXcmTdggBMH/mnEJSZYCxB74oh9merH0fkRoe7oC609?=
 =?us-ascii?Q?ipzJLP61Gn/c6823kNsf6kp8nrklEsSSLUXOrphV06KhXMfNuL9B3YgWTPwa?=
 =?us-ascii?Q?UrFRuzdU+cIBMTMQOIsDeTAjF2N7cwU+zHb5/PrEyTLDbbNgRgWanCPZilO+?=
 =?us-ascii?Q?V+PKiNMpnK4rc40vbc02jV6YU+vYFMIx+USm7f9Gud7rRmwC3McqyFE+EJum?=
 =?us-ascii?Q?ChGuJ9GV7eGZ2tYNICSN/dXDX+0kCUFsdZT8QMCgJyMWET3wu0yegSnSNDn3?=
 =?us-ascii?Q?xg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b29802-fee7-4d82-dcaf-08dd766d8aa9
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7012.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 07:18:20.9682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/Wj7bN28rk7ivUkePru2I+R5TulvQaiTGYFR1iR7kg7+WKrxp3VSI+AxXQJUgXzXTtQUEjnJtiL6IkOBnXf1LDLPNBlxKxwvvH25CExFEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8489
X-Proofpoint-ORIG-GUID: eHXQt8har3-0quZSJgQUfeA0bIK-ZI3N
X-Authority-Analysis: v=2.4 cv=RMSzH5i+ c=1 sm=1 tr=0 ts=67f4cdc0 cx=c_pps a=CSNy8/ODUcREoDexjutt+g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=J2gJbEVsAAAA:8 a=Ikd4Dj_1AAAA:8 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=Q9PlyC63RlXhMTSiPO0A:9 a=Bt_igOxda4ASFyQEjNxY:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: eHXQt8har3-0quZSJgQUfeA0bIK-ZI3N
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_02,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1011
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504080051

From: Chunguang Xu <chunguang.xu@shopee.com>

[ Upstream commit e5d574ab37f5f2e7937405613d9b1a724811e5ad ]

If a discard request needs to be retried, and that retry may fail before
a new special payload is added, a double free will result. Clear the
RQF_SPECIAL_LOAD when the request is cleaned.

Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[Minor context change fixed]
Signed-off-by: Cliff Liu <donghua.liu@windriver.com>
Signed-off-by: He Zhe <Zhe.He@windriver.com>
---
Verified the build test.
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 019a6dbdcbc2..7d6aab68446e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -852,6 +852,7 @@ void nvme_cleanup_cmd(struct request *req)
 			clear_bit_unlock(0, &ns->ctrl->discard_page_busy);
 		else
 			kfree(page_address(page) + req->special_vec.bv_offset);
+		req->rq_flags &= ~RQF_SPECIAL_PAYLOAD;
 	}
 }
 EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);
-- 
2.34.1


