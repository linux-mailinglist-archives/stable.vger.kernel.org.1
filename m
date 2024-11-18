Return-Path: <stable+bounces-93774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A66349D0B47
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 09:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35CF71F22D36
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 08:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EA7188014;
	Mon, 18 Nov 2024 08:56:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFAB15B0F2
	for <stable@vger.kernel.org>; Mon, 18 Nov 2024 08:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731920219; cv=fail; b=FsiJeVFBPSybPlquIX/bhEoxmrteqDrmeK94Eo5vPeNoRzhdOzUgwFgCDDIYRcu97qQF8CvvLblCbh1uBRM/DMRuvb4vDJEENfoJICyDSeh7Ih+3CJ9LWyNTF/FQ7D5tzRrU4Wr9z+hSfPrbZrpv2Nete+UHr+w9TE7sEu2vUsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731920219; c=relaxed/simple;
	bh=57n/dP9yNOy2Ytvj7Q2ECDavvWviHV80TNc/hzdNH1s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TJAHQozWBzBZi6PotAUZVTMJKvX78WJDuyI2PFJVyEjQ4Kfo+Wn6b5xbTy4COvd8+ejIbwOJ/rTi18gvlN+0H+oaxLfAXJPhVgSVxthwHgfF3kNOO+ofMY9iVr7u0j9UrLzxXvH8G4f3U2v7BV4YKUmrnNYwA9lqPALBCfF6xRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI7K2NE015153;
	Mon, 18 Nov 2024 00:56:53 -0800
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xqj7scg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 00:56:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPXaX0M2JqhN8R8OqNi1XmkW4doTceEt2hhRko//lYFBo0ozgxU6+gSCNsjVTNAhnFIWA4Srp840kJEr49d49bpmT2xGBx82Ewq5yHnfDRJDoIErAYjwNg2dvi2hIYK0v4uSwEfcnn3fJk/gEGdZU/E3syEJDPZUf+0gGL5OlT0UUH91MkcP+f/7qwe0Bq88XzB0XM3lh+Db5A+fBo/9j97eiPC4PebPMhauhFBv3Arjs0tyyDqI5bYdVDyia2lpEqpFXD8R8DgSHrp8xpBA2jo7O17jqdcIRksxFu88NI5jA6WIyM4DkMH8K09IMfD1T7RJuwozJ41vqdiQQBMxtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qWpS8zCUtYwgoeNwUMwkRZIIELG65yqiMfhItnifXY=;
 b=GsFNnZAO9hL1NRX58FHZ7qvx6q1TbGvQpC8ozDkIy7TuaAyVhCckgm+rUVabK76MP5y8K/P9UCqxgvjUAqFXNEoyCJZ3V+jDulddD40aFN0T2XdlXgYM2Dez0iwIjiSrDWOXii41A+jbcptBpaF48ZI8K+kYdMR+ClGJuOeGbK21BsnSdKuVftMPeH2i97IXtE1FwLVTQzw7kpB6NsYzt0+XIIOvXL1UhWID/Pq8LhLTUIbQE11IwrY4jO8Dy5eGY9RORsE4vDWZhd3vZdG4L7zqcDkLkzp4Zwvya1H4m2tu7DU7wPn/UPiNarCfDFyFkZyQB7fsqB1TH7lP4CdhEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by BL3PR11MB6385.namprd11.prod.outlook.com (2603:10b6:208:3b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Mon, 18 Nov
 2024 08:56:49 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 08:56:49 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: rick.p.edgecombe@intel.com, mhklinux@outlook.com
Cc: stable@vger.kernel.org, xiangyu.chen@aol.com
Subject: [PATCH 6.1.y] hv_netvsc: Don't free decrypted memory
Date: Mon, 18 Nov 2024 16:56:48 +0800
Message-ID: <20241118085648.2566126-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|BL3PR11MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: e13351c3-e107-48cb-640c-08dd07aef03f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cp8ZFXooI/3TI6Tz34leL6VRJQM86F5TH56LPuugf7UL6q+YcX3urIw7EhsO?=
 =?us-ascii?Q?RNQ616CqKeyCYoHEuVT59EbVz7lvgKiEJBjdvTZ2v/LO3UPyrXsDftiCa6Ks?=
 =?us-ascii?Q?8LX9XEhRWO47zsRvjo93Jb/SES9LMVDfuL6Hr0XSWIzpQXH0dfn8vufzjO5C?=
 =?us-ascii?Q?W/L9dWl5rM80uhNGQ89wM/uxVzKfn/YEyFQPe/ipiGQCRC6NRVP5a5AKuwFa?=
 =?us-ascii?Q?1uNdBlSXG/LVDTXRyyZcHFn2I93g/ik5vmgRsmRJlQSbKToB/iaZHLK+3sSY?=
 =?us-ascii?Q?c3wHVSzpETYBwnwWc4dNA9Yas4aXDjKfwnMLM8RDDAtn84Ofv5xyOeGp7H7E?=
 =?us-ascii?Q?nDpiLYF3OA0wnMMotmGhozYJG5I3xWN429XrCVMLBRmH14+ckT4/h13ZN69g?=
 =?us-ascii?Q?IiVdS03yNZxAJ76IogRJ0bhe6bOZsqvItAuqB8ogkpPLPVA/Pj4nafEW1iEN?=
 =?us-ascii?Q?XrTLNCAhzVxPQp1sqwiCl41pJrVOHKhYdGxngP+X2oWLn71i+mt2tM/BN+zm?=
 =?us-ascii?Q?4rVEwhQe4Z/MkaiZEMbha0+U7HjJNoZYZ2YDNoR2A83px/arsgt4mpi5vX97?=
 =?us-ascii?Q?+9CQUP9dQmnf8blH8o16YXqSTy45RrGU4UcsIdJwfbuznUN8ctddS7TGXugf?=
 =?us-ascii?Q?Sd7UWKbXBbo1GneWzAdXIaZslulVLTbbhaDH5+8lbDY/KEdPzc14j0R2aIHg?=
 =?us-ascii?Q?Gqi5P5QEpSPNfFPfk83oo7bCQH8nTJvq68oTJEnCW3F60lWlmO01Xnndxnsh?=
 =?us-ascii?Q?iAaUctcY45w/25D6NIEtdgodaLzPe3l7ednvvB/LPquMulg32rDR5DV21Xav?=
 =?us-ascii?Q?rXEf3WEud8iCHhQYnEmgsot0xVs16b4Vro69C3UqQwYxEfxUcyIhV3ezjveO?=
 =?us-ascii?Q?yKTz+HekYonU7yfOZOu1AanJFdaq5plxFB40aTip5mNZcEwNvF5tE8bE5FOB?=
 =?us-ascii?Q?NyFmNEC178F6+/tzxj/EqF/yf+1VtZe7/3h0CBY2HKO9F+Nr4IClQugF4Hvz?=
 =?us-ascii?Q?f4IptKYYbNZeR6o3EB8zrv7o5uVHuLvjFYtUyxV7Yh0NE/kRKvmrwu/FjlMp?=
 =?us-ascii?Q?zzFh1CfgIUuglCDQBWPat3T/M24vPPahKlzgihF1j4FAYX+NyxYJP46kggc+?=
 =?us-ascii?Q?g75Uj5uL8EA4BcyChAzfP8dGS1YlRsfQFulU1m2Q8yFpg7LrvAjx0B8cTZxu?=
 =?us-ascii?Q?T2o8aWC5fbiEsOzHHbKWxI6jstCqNdB7CIuQ62goXMyjsyILd973yt4l0MnK?=
 =?us-ascii?Q?seEMZM6lv0EwUiT94fXbZ8+ayajzfcHGhMv9OrKaVivTj60fkIDSA5kHifgd?=
 =?us-ascii?Q?CxhJjEMvmR4AIzTE4v4Ei66tQTKS2C3UqgPZhka7MpnZcnjv/3B0YoFcTERr?=
 =?us-ascii?Q?aHJIZDA3AqICJhYg3YBH2ZqmGmKB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CG6Bt2BliTt9Tm10EobGq6b3qMAxFEheVyK3He0YjiIJ5K3tCMOEI9x5Affz?=
 =?us-ascii?Q?3CFzCXADWd8/5ZMPb6rFqiNrDBmpGPjXH7XzAZYBU6AUx1l+J9qe6PhxviSi?=
 =?us-ascii?Q?+4p8N7/SdNo1JbURHpY8qRw1VnpC7hZMlVvei3Hx7Nva1obvUte+xCq8s1Pl?=
 =?us-ascii?Q?HHAFio35FVNIVWb1aep3kwb/gddItqDRSOQX8JlfS2YRR9wR80fBbVfZDk6h?=
 =?us-ascii?Q?gwEVlS5hrZC7q4Q140zMa5L/J98oPf+yTGF2bvSdD+EHRtTRhYAmfX20DZoP?=
 =?us-ascii?Q?IqN0j/4BgwWK070IyrAOqKs5Ad+PnJIA89TarsY8N4t+sI1fgWmBdsD8SirO?=
 =?us-ascii?Q?2YQTmZ0qypl+2t+mfLHMIPtJqXy2sWaoXvL7wR8xf0OdNp+9NZzYholoIjTa?=
 =?us-ascii?Q?b/mEWHU83QCi7EU8jeHFcjy/41pmhp6LqjN9N0WPe3TIt2Nn4o+dS73fWloZ?=
 =?us-ascii?Q?wqd/iKj6VNMZtNOO9D2lFjdyNBC6e03yz2eSbltJp7VAe0ZxzwqsYEBtNSBg?=
 =?us-ascii?Q?cguR9R21h23cAIr5yQt0cvftiRq2Jicxp8BqCAm4MknljZSpifCF78L3hsA6?=
 =?us-ascii?Q?V1lOByr225V+ZthSjbvNL0WIztFUNt8MO965RyODzm2UuSgrwrEe89V922yT?=
 =?us-ascii?Q?CwCiPNXEBB2UsOpm8e7lLKC7fEihKf4j6XRElkyex8CiK9OS973kDMMOK9cX?=
 =?us-ascii?Q?xPQdZ1CbXcv5LwROMVaMj/5Jwu8zULP4e+BtIJX2qHrAwiKe8BR6HXzA7v9P?=
 =?us-ascii?Q?ZYeakOsjjNcQQ8WMi0WNB2gwxkumVLV0r+qH3uatVEmiqRINRSusIj2ERJsw?=
 =?us-ascii?Q?3x9fqY3ByTAkca1MRxWKRKd69PaX8tm23ghB236QssOKhpIW6mxxmvSZHHzT?=
 =?us-ascii?Q?TnmwDq1eGmJkN/NmO1hBzcEDx9UmmccX022AO0UTNX5NuXXMdWEncAse7lKP?=
 =?us-ascii?Q?Ftjm/ybt65gJ821nm+2xX8qeZ35ZuDsO5yqP0QgDnn2ewDaUPqojFi6tP4Xr?=
 =?us-ascii?Q?ezPRUGTz6LbmfnQJcXflktH8Ia3BB7I134HR1STwWt7A23+9OqfF20ihbYzi?=
 =?us-ascii?Q?DS8SNi8EizmnwrDMqWoYQwaVFZ1T6IlKtvmGkccHuLFwGyGgf39si3FD7hJ1?=
 =?us-ascii?Q?FWNk8/GxONS+f/R1tGw2g1fAKFbbPbwooNzz4EMpmL6KPPAZ16SqpO7a2+IW?=
 =?us-ascii?Q?vIvr3J19GZA5j08Geayd3P6fVyc5JComMB/SVZzOJTkdeRNtdlWBESfBSa8L?=
 =?us-ascii?Q?Ss61l9A78HiNaukroEK++N9yFS9+fZv5dvlF+f06s21YEI4QwEuDEH+/psvk?=
 =?us-ascii?Q?G/b3ZHOI7WihkvwEKPuEYBXydWUKihAGnmSen7U8ibktz2TAhk+1i9PcDseK?=
 =?us-ascii?Q?qpT+c0tblVz7fS4GT5axGJX36MJnQ+hs2bR2vJbpMj3ucZCsFkOTbwVDXT/l?=
 =?us-ascii?Q?SJJBMC0Df1izIXGakcvuHfXSZbKAEaAnwOtm8k2EXCulW9jHc0NwuRR0od9H?=
 =?us-ascii?Q?gEZXBe+vrIZaHv9uOBy7CIZUeXx/awF+iX4HbN9NFnf7XMVpchBWsbe/zRvL?=
 =?us-ascii?Q?YzOtdTRdF1MLt7+NmiYZ8GmlE263qf+zZEqlAKFcP5kDX4pQm+e4/auvEBJK?=
 =?us-ascii?Q?OQ=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e13351c3-e107-48cb-640c-08dd07aef03f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 08:56:49.4902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jbwqFG2YDSEJVKsl/M1OfY5vRdAXRgfsI4qfhhGKIbRCs9a5Pxx/hiuNXEoKuotMAqLphj761ms2ZV08x5OaJw+eWEAIg2AbrfCnRwqjlss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6385
X-Proofpoint-ORIG-GUID: FiYAqjfMp9PGysdyk9Whi1JZCSN3Ptb2
X-Proofpoint-GUID: FiYAqjfMp9PGysdyk9Whi1JZCSN3Ptb2
X-Authority-Analysis: v=2.4 cv=Sb6ldeRu c=1 sm=1 tr=0 ts=673b0155 cx=c_pps a=+hq7TYb7Jqj0EztKBnUMzg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=VwQbUJbxAAAA:8
 a=UqCG9HQmAAAA:8 a=QyXUC8HyAAAA:8 a=t7CeM3EgAAAA:8 a=xyu6PZ8NKGNK2CG7n7QA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411180073

From: Rick Edgecombe <rick.p.edgecombe@intel.com>

[ Upstream commit bbf9ac34677b57506a13682b31a2a718934c0e31 ]

In CoCo VMs it is possible for the untrusted host to cause
set_memory_encrypted() or set_memory_decrypted() to fail such that an
error is returned and the resulting memory is shared. Callers need to
take care to handle these errors to avoid returning decrypted (shared)
memory to the page allocator, which could lead to functional or security
issues.

The netvsc driver could free decrypted/shared pages if
set_memory_decrypted() fails. Check the decrypted field in the gpadl
to decide whether to free the memory.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/r/20240311161558.1310-4-mhklinux@outlook.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Message-ID: <20240311161558.1310-4-mhklinux@outlook.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Xiangyu:  Bp to fix CVE: CVE-2024-36911 resolved the conflicts]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 drivers/net/hyperv/netvsc.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 3a834d4e1c84..3735bfbd9e8e 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -155,15 +155,19 @@ static void free_netvsc_device(struct rcu_head *head)
 
 	kfree(nvdev->extension);
 
-	if (nvdev->recv_original_buf)
-		vfree(nvdev->recv_original_buf);
-	else
-		vfree(nvdev->recv_buf);
+	if (!nvdev->recv_buf_gpadl_handle.decrypted) {
+		if (nvdev->recv_original_buf)
+			vfree(nvdev->recv_original_buf);
+		else
+			vfree(nvdev->recv_buf);
+	}
 
-	if (nvdev->send_original_buf)
-		vfree(nvdev->send_original_buf);
-	else
-		vfree(nvdev->send_buf);
+	if (!nvdev->send_buf_gpadl_handle.decrypted) {
+		if (nvdev->send_original_buf)
+			vfree(nvdev->send_original_buf);
+		else
+			vfree(nvdev->send_buf);
+	}
 
 	bitmap_free(nvdev->send_section_map);
 
-- 
2.43.0


