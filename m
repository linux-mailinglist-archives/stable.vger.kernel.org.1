Return-Path: <stable+bounces-125994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D207A6EB2A
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 09:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF1D318936E5
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 08:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D29253B68;
	Tue, 25 Mar 2025 08:11:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0488E1D7E37
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 08:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742890290; cv=fail; b=hZFkAl/BTIW/f9SW/rClZCW5hIhwPhqeiVoAIlA+iCj7pTcYgNsWbPWvdWOz4OaDyDN+LBZ7+4az9e3p5rNJPXKxF4NjLYb01omxbqSdrnc7G1BH2cg6/tn2LssK9qhmR7nnT6iVR0iE1615bAkjwB7vNPfa0rFhN4HvLLFFr0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742890290; c=relaxed/simple;
	bh=cGTAlAzTnRPT38LyRmm/bIgrm9p3IpMGRLke9gKKGHk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=eGikErDPUINqXhcsEaU/buiNUyM1/+DF39aSPoXW8flG+LkBQvmhy1BHHUeqqDGxpYtWJC+q0Zje8Wf/ZHqAOVFNIqxlwLWS0OCHp7dZreR91aDFtM1ZNB5CIcgSw/VIBScpIK5eYsgdLYRvONaw1oHbtJSUvUJa5e9llsMk9bU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52P7ascR002953;
	Tue, 25 Mar 2025 08:11:03 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45hm68k07h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 08:11:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eb6NMwBBHrzQajLXdf+HKLf0XHDMvF7cdz5Lz+2p9T0V71kdu2ovHrhmfUQXuLJxkGU6xwyOyahgV/Od25FJ3XeyW+jOgbMJSlIqncvVGY8gWyTwAa1noTcR9Glg3E1H4UfoX/LoY8m/qRvjU0rU7mUp+eCyNX9nLh0CI0yWcBUwKNmMPmsNhXAQZ2Qz1H+sPAiBG7bt7yJdLmlGYDYUtAw/MEqr+jD19HaUMhyCzvs+1kVr8clPFNFfNVtUgWayM+Sz9ZRvT3HXuftdllWWmQo/q+GFD8oxSowdZyPY3lPvvnlAklFQn3YkU1JehjmrEujv2SEskjz0hAkhdHEG7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZT4+OnfNg8xhkqfh1neHwzJE5B2NXFL4CmNEtQkBuvg=;
 b=TqHcQzt2X8xh9vYn4nVJRLTml2zatMaj/bmrInU9qQ4yihCn67qE8IoKwRyvj/uf/VTGOVvQnMcBXgUsDgUTlMxUVatxGXOBuTnKNr9EFRGerhw8sMjIvCMIrNpFO7tEyj9DggH2/ssc494dFptwZCoFmezv3/PMo0GtXOPsY2BiWQm4eIscZYccAuvltY1choHMCSQB0ovg3THvNkRDp4SNZLa+9xMdP/toJVK1KBQUywIg+/eZutauESXyK0jYPiAwPt5iZ7TWU+BEI6sBv6pvn7skrEIwBkPKH34AiJbI24egPk3cuYyUmuwaPBsckvGuZKE1YwHkNgM5kZv+Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by SA1PR11MB6568.namprd11.prod.outlook.com (2603:10b6:806:253::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 08:11:01 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%2]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 08:11:01 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: mhal@rbox.co, bin.lan.cn@windriver.com, daniel@iogearbox.net,
        john.fastabend@gmail.com
Subject: [PATCH 5.10.y] bpf, sockmap: Fix race between element replace and close()
Date: Tue, 25 Mar 2025 16:10:45 +0800
Message-Id: <20250325081045.2210079-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0062.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::7) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|SA1PR11MB6568:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c0eba27-da7e-40c8-c6e3-08dd6b749480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r+Pt7eOrVGyzcWcyPqWFt5FOfEjQKKxo9rgiQowjuZZbPoqqByGf4Ja2TRo7?=
 =?us-ascii?Q?TjOdrzubvY18+7mtJXB9eVm9i3yiyGuJbNSfDRrX2NY1tnypXNyybhZ8oP4Z?=
 =?us-ascii?Q?i8UTNK3RSO12KKfa676DW+bUctTwbbM3msQfQEn0zlHg1W6R6Zhe4CFW0/Vx?=
 =?us-ascii?Q?qCyP8NiKw6hn322D0OpeuyEE0eUNolMrktoEsKiFHH3pZwoAQ8WBu/WkMstJ?=
 =?us-ascii?Q?fFyFQ8lOxJs5N2OnTc+6y/jF6yp60IrAlNiY7lVv6iMb3vn9Pt53cSuRRYUl?=
 =?us-ascii?Q?hHS8WVnqEzlkSbMuZL+3fok63d5I3GzTlNAzo0pK5vmojljZqQDoXG8O/6N2?=
 =?us-ascii?Q?wr6SJJ/FPt6Ug83iKLnk5OigSUSU7KLkfv9Vi6kwmP5utfjiT0+2BHcHu0P+?=
 =?us-ascii?Q?sHV7wkYPhDAQVcJflT1fQXfeNyhdog+WCvkG7F1AYNbjtW8BUxv5rpQT/PLf?=
 =?us-ascii?Q?8LpKysjwDymWwrDIRRH4WLu59j4ycd203bxqUJkqnOpC3gSED/OJCg0EqYif?=
 =?us-ascii?Q?sCIr5LlEusvtWV2c2p6iV1PV2jcWT8DJNjSioA/FJGY9oXbgyUGfnA2PCbG1?=
 =?us-ascii?Q?QSHtHc9/zmNT728W5WOfx+edK+Sx9msTFNAb1cdmmcBx8gmtFTAbvp5No7A5?=
 =?us-ascii?Q?OWM4jCp2PmtSx1OjCrcCxbFKmtTtdSBy/VFZfPBrt5SWEJhGO4O9QDaQBgCX?=
 =?us-ascii?Q?NLqklL5hBvpHEOrYTP3ec9Ny1doFcST/afbH7xPpqtwSillp++XF4kydfXOI?=
 =?us-ascii?Q?kO5Xyu/nSV2N9pTm4HknlOApTB3jy7awDMTLEK6W+iHkbCvD5ZtiD1xl2kNh?=
 =?us-ascii?Q?KQnwsQ5Vg4dtnFsak8LTzGlxGsTSmgtgBqxBnR08Y8T8wYO+5WeH0XIYufTH?=
 =?us-ascii?Q?4lxSYMqcV3xb30zqjlZHxGUBTdTwkvW3+wxs+nM+0QLvYJvsx8XDwhdJHJoy?=
 =?us-ascii?Q?tpl1KaN7qDRl3TCsCfW3Nc0kXhZuLTpKJs7hbczj1gsYC3TG8Kj/GGmvtQDG?=
 =?us-ascii?Q?PeZ4nZKgzQA88os4oHfGgm+UDK0Vnjl1NkYGGw9OPheXruc3FpTxk1faUylx?=
 =?us-ascii?Q?0MG2kQRPCd0POXSMreMmGb2OJnTrrHvVAGDH+J4UzF1mei4Sg98sKOxPd6yJ?=
 =?us-ascii?Q?/padcK7blD96/WfHAF4tfiJkzpLBy8ml2p1drQbS+qB6Fyn9GyINNgRUkHAs?=
 =?us-ascii?Q?WNKAc2ZjdsGR8i+cfciubb2WiIftV5FEdC+HfG1+SOQmu/MddUcgKJsCFJ4X?=
 =?us-ascii?Q?lpWyKrTcRJdeqr7TIoyQ+/LJ5RNlOmDOt5V5b3WUxmCPcmok6A4nHk2+fmwD?=
 =?us-ascii?Q?9mGbctLUxvv4H025bUgEtNm0rkur8BAcwKBOILUXUZRTrAuHSFIK9rX8n0sl?=
 =?us-ascii?Q?TQDUhRZ2pTC/lIB086SgR62vQyVBZEsvBUpH+7K8NQFl1jEyIYDAurGp2Lfm?=
 =?us-ascii?Q?In0wXPvYjiKjShRpoxyDjv3igkKmlOaB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5NrtViKAjBVNGlepi3Di1yH78oI3s7Dx3s5AjKzd09xylnIMhEidg3jqa3j9?=
 =?us-ascii?Q?Xm/Ai+/F7a3x9YLdgKtpyLSxZWlp+u/VIFVyX2tzNhCvSdZfNKI7Vk7lCNNd?=
 =?us-ascii?Q?BVCVBunZ96g3/f1s/x0YeE8D4O+pDiEbpco2twFf3ICv0tyk3VMoEtwTInrY?=
 =?us-ascii?Q?QpsUyLLR9Ir9Aw0ifzD3Ne6a3QoM6aNT5ONvFE5jS76PjM1P6Qgj7rhkj67z?=
 =?us-ascii?Q?8DslX9x31yuSbkuaFqMGmJ7uuMBLfID1ZTorAyos/1AEVc/J0mxDnsyxCWaO?=
 =?us-ascii?Q?8Cly7gXrPG84fKRtzwGXxGtpKmulFBA9aP7jH2ERhVBR5N/5OWzngWSydsDt?=
 =?us-ascii?Q?M/LMo+jfYhndzwt+rtT0Pbh4YpiVZz2dHfLJ8cJ1uXHj+xH+zvtacCvVonOy?=
 =?us-ascii?Q?+Z5cUTxaKUPKKfGBu0Lw+jYcwrOkSuI7xxf0dj3rRReg1DAXipgH4uFWzD7G?=
 =?us-ascii?Q?1ZCA/cVkmL9IQSGog+YwKwIZiY29EXBgo8sFTD/Y/jBajP+EhJFIkn0OMj8J?=
 =?us-ascii?Q?yIHzzQZPzJjDG9XuwA9asrrLGYgchlr4fU1BaegG6NaOt2O9KXhVn3KIw4DR?=
 =?us-ascii?Q?KIsRiC6YR7XeUSn5wH6onB+GKrjx4WDX6dR1MxzCxys1P9bRp/4jWQlECozK?=
 =?us-ascii?Q?XmXM0nTo9PCLeaUCrRymnPiGUKyRh3Skdj9bpyqYK6COZnPfY9CYduk+Vs9e?=
 =?us-ascii?Q?+f8b3gAEtey8RgSlQGz3XHwfXV0m4xPFog3PE9X74OXSHNslXUKsSV9G1gV+?=
 =?us-ascii?Q?XKLwC1H/I9FIajHkuYHG+9vV5izajNix4/FdJN0br3GMcvzHS1pOG+duM9Xd?=
 =?us-ascii?Q?S7xOM65xy7ShttuvXPuv/53GXWunwopXaejTHYjPKla2CQU4HryCQ1+jY3L6?=
 =?us-ascii?Q?DDPt6gS3oj13jVMWtvDC+FaYLTAEm4djXcaaLAeuCA+mzp1g6Ip6cU6T8Bz6?=
 =?us-ascii?Q?hLzlzfZ/h82uzS/KZZ1C51kHXVlrcsC/NVHftD0FgCMNhflWRCWws3TWumhG?=
 =?us-ascii?Q?irGswHH6o4mPM9b5dYGHg2S2qUKjMMwC4y5HctfIYgZnYr/A76kDlKlbF8h+?=
 =?us-ascii?Q?T/EJwZXmsn/Kw+bUC4K7ZPwWM3v6zF75LDI4pqpycxMfnDKixvyXCg4QBJYW?=
 =?us-ascii?Q?2msnwpyjZ5/nqsKlZPN/rpO6BPtDYQjbBCikMid32r02DzyM/liAJrzSdYjw?=
 =?us-ascii?Q?Xoafk1kJ2ZNEaZO6eYgrpx50yK2qCsGsbiWRPq6x00xj/Q7PjiPXTevzIXf9?=
 =?us-ascii?Q?VoK+q7PC3rR2Dl02wozclFO/9a+YIn841MWqZzDtxtKP9Js1t01Qxq3HjRZo?=
 =?us-ascii?Q?ESu6wLAN/p4YnD5Io4T3HgcDWB+ra3665u3Sn2t+QRdqK0Cwux4JYt0OF42M?=
 =?us-ascii?Q?iHSmWI7EWHCvYPyzz2si2nKE5t7S8txGUNRyTuAIes3Jpe4RbkuBELk78RwB?=
 =?us-ascii?Q?Ch3EaSvQ4o3modKTLP/xfWKYWTurTVRjtWl3uQPPzGqlF4TaWlOi5xsnJCDn?=
 =?us-ascii?Q?g63Zd4I6Dp1LvR4PIu9Ahjs0gYmEJKCloDm3aVUgs+6++HF+lAc1ntTXmfd+?=
 =?us-ascii?Q?CjQv3p3CcRmhzKELS/F08DFirTJGYyqV4CfhOkvEO0/5PDbMXeapuajKQ9/N?=
 =?us-ascii?Q?yA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0eba27-da7e-40c8-c6e3-08dd6b749480
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 08:11:01.1272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPCSI+1lZbGBVLLcaFQpvWgwHIHuVCx22bLPYYpt5Kcj70F/4pjF2a7/0saI3IC9NnZ12DbrtYtTvtIycfkGA7bTfo1C/vR/cQQQcCINfZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6568
X-Proofpoint-ORIG-GUID: oErJyofIx9ZyoDcNEEChc3YHFG5NUJsB
X-Authority-Analysis: v=2.4 cv=etjfzppX c=1 sm=1 tr=0 ts=67e26517 cx=c_pps a=coA4Samo6CBVwaisclppwQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=H5OGdu5hBBwA:10 a=VwQbUJbxAAAA:8 a=hWMQpYRtAAAA:8 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=jWF0KBuXk48DT8NqCIAA:9 a=KCsI-UfzjElwHeZNREa_:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: oErJyofIx9ZyoDcNEEChc3YHFG5NUJsB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=600 priorityscore=1501 spamscore=0
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503250056

From: Michal Luczaj <mhal@rbox.co>

[ Upstream commit ed1fc5d76b81a4d681211333c026202cad4d5649 ]

Element replace (with a socket different from the one stored) may race
with socket's close() link popping & unlinking. __sock_map_delete()
unconditionally unrefs the (wrong) element:

// set map[0] = s0
map_update_elem(map, 0, s0)

// drop fd of s0
close(s0)
  sock_map_close()
    lock_sock(sk)               (s0!)
    sock_map_remove_links(sk)
      link = sk_psock_link_pop()
      sock_map_unlink(sk, link)
        sock_map_delete_from_link
                                        // replace map[0] with s1
                                        map_update_elem(map, 0, s1)
                                          sock_map_update_elem
                                (s1!)       lock_sock(sk)
                                            sock_map_update_common
                                              psock = sk_psock(sk)
                                              spin_lock(&stab->lock)
                                              osk = stab->sks[idx]
                                              sock_map_add_link(..., &stab->sks[idx])
                                              sock_map_unref(osk, &stab->sks[idx])
                                                psock = sk_psock(osk)
                                                sk_psock_put(sk, psock)
                                                  if (refcount_dec_and_test(&psock))
                                                    sk_psock_drop(sk, psock)
                                              spin_unlock(&stab->lock)
                                            unlock_sock(sk)
          __sock_map_delete
            spin_lock(&stab->lock)
            sk = *psk                        // s1 replaced s0; sk == s1
            if (!sk_test || sk_test == sk)   // sk_test (s0) != sk (s1); no branch
              sk = xchg(psk, NULL)
            if (sk)
              sock_map_unref(sk, psk)        // unref s1; sks[idx] will dangle
                psock = sk_psock(sk)
                sk_psock_put(sk, psock)
                  if (refcount_dec_and_test())
                    sk_psock_drop(sk, psock)
            spin_unlock(&stab->lock)
    release_sock(sk)

Then close(map) enqueues bpf_map_free_deferred, which finally calls
sock_map_free(). This results in some refcount_t warnings along with
a KASAN splat [1].

Fix __sock_map_delete(), do not allow sock_map_unref() on elements that
may have been replaced.

[1]:
BUG: KASAN: slab-use-after-free in sock_map_free+0x10e/0x330
Write of size 4 at addr ffff88811f5b9100 by task kworker/u64:12/1063

CPU: 14 UID: 0 PID: 1063 Comm: kworker/u64:12 Not tainted 6.12.0+ #125
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
Workqueue: events_unbound bpf_map_free_deferred
Call Trace:
 <TASK>
 dump_stack_lvl+0x68/0x90
 print_report+0x174/0x4f6
 kasan_report+0xb9/0x190
 kasan_check_range+0x10f/0x1e0
 sock_map_free+0x10e/0x330
 bpf_map_free_deferred+0x173/0x320
 process_one_work+0x846/0x1420
 worker_thread+0x5b3/0xf80
 kthread+0x29e/0x360
 ret_from_fork+0x2d/0x70
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Allocated by task 1202:
 kasan_save_stack+0x1e/0x40
 kasan_save_track+0x10/0x30
 __kasan_slab_alloc+0x85/0x90
 kmem_cache_alloc_noprof+0x131/0x450
 sk_prot_alloc+0x5b/0x220
 sk_alloc+0x2c/0x870
 unix_create1+0x88/0x8a0
 unix_create+0xc5/0x180
 __sock_create+0x241/0x650
 __sys_socketpair+0x1ce/0x420
 __x64_sys_socketpair+0x92/0x100
 do_syscall_64+0x93/0x180
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Freed by task 46:
 kasan_save_stack+0x1e/0x40
 kasan_save_track+0x10/0x30
 kasan_save_free_info+0x37/0x60
 __kasan_slab_free+0x4b/0x70
 kmem_cache_free+0x1a1/0x590
 __sk_destruct+0x388/0x5a0
 sk_psock_destroy+0x73e/0xa50
 process_one_work+0x846/0x1420
 worker_thread+0x5b3/0xf80
 kthread+0x29e/0x360
 ret_from_fork+0x2d/0x70
 ret_from_fork_asm+0x1a/0x30

The buggy address belongs to the object at ffff88811f5b9080
 which belongs to the cache UNIX-STREAM of size 1984
The buggy address is located 128 bytes inside of
 freed 1984-byte region [ffff88811f5b9080, ffff88811f5b9840)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11f5b8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888127d49401
flags: 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
page_type: f5(slab)
raw: 0017ffffc0000040 ffff8881042e4500 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800f000f 00000001f5000000 ffff888127d49401
head: 0017ffffc0000040 ffff8881042e4500 dead000000000122 0000000000000000
head: 0000000000000000 00000000800f000f 00000001f5000000 ffff888127d49401
head: 0017ffffc0000003 ffffea00047d6e01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88811f5b9000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88811f5b9080: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88811f5b9180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88811f5b9200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
Disabling lock debugging due to kernel taint

refcount_t: addition on 0; use-after-free.
WARNING: CPU: 14 PID: 1063 at lib/refcount.c:25 refcount_warn_saturate+0xce/0x150
CPU: 14 UID: 0 PID: 1063 Comm: kworker/u64:12 Tainted: G    B              6.12.0+ #125
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
Workqueue: events_unbound bpf_map_free_deferred
RIP: 0010:refcount_warn_saturate+0xce/0x150
Code: 34 73 eb 03 01 e8 82 53 ad fe 0f 0b eb b1 80 3d 27 73 eb 03 00 75 a8 48 c7 c7 80 bd 95 84 c6 05 17 73 eb 03 01 e8 62 53 ad fe <0f> 0b eb 91 80 3d 06 73 eb 03 00 75 88 48 c7 c7 e0 bd 95 84 c6 05
RSP: 0018:ffff88815c49fc70 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88811f5b9100 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
RBP: 0000000000000002 R08: 0000000000000001 R09: ffffed10bcde6349
R10: ffff8885e6f31a4b R11: 0000000000000000 R12: ffff88813be0b000
R13: ffff88811f5b9100 R14: ffff88811f5b9080 R15: ffff88813be0b024
FS:  0000000000000000(0000) GS:ffff8885e6f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055dda99b0250 CR3: 000000015dbac000 CR4: 0000000000752ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __warn.cold+0x5f/0x1ff
 ? refcount_warn_saturate+0xce/0x150
 ? report_bug+0x1ec/0x390
 ? handle_bug+0x58/0x90
 ? exc_invalid_op+0x13/0x40
 ? asm_exc_invalid_op+0x16/0x20
 ? refcount_warn_saturate+0xce/0x150
 sock_map_free+0x2e5/0x330
 bpf_map_free_deferred+0x173/0x320
 process_one_work+0x846/0x1420
 worker_thread+0x5b3/0xf80
 kthread+0x29e/0x360
 ret_from_fork+0x2d/0x70
 ret_from_fork_asm+0x1a/0x30
 </TASK>
irq event stamp: 10741
hardirqs last  enabled at (10741): [<ffffffff84400ec6>] asm_sysvec_apic_timer_interrupt+0x16/0x20
hardirqs last disabled at (10740): [<ffffffff811e532d>] handle_softirqs+0x60d/0x770
softirqs last  enabled at (10506): [<ffffffff811e55a9>] __irq_exit_rcu+0x109/0x210
softirqs last disabled at (10301): [<ffffffff811e55a9>] __irq_exit_rcu+0x109/0x210

refcount_t: underflow; use-after-free.
WARNING: CPU: 14 PID: 1063 at lib/refcount.c:28 refcount_warn_saturate+0xee/0x150
CPU: 14 UID: 0 PID: 1063 Comm: kworker/u64:12 Tainted: G    B   W          6.12.0+ #125
Tainted: [B]=BAD_PAGE, [W]=WARN
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
Workqueue: events_unbound bpf_map_free_deferred
RIP: 0010:refcount_warn_saturate+0xee/0x150
Code: 17 73 eb 03 01 e8 62 53 ad fe 0f 0b eb 91 80 3d 06 73 eb 03 00 75 88 48 c7 c7 e0 bd 95 84 c6 05 f6 72 eb 03 01 e8 42 53 ad fe <0f> 0b e9 6e ff ff ff 80 3d e6 72 eb 03 00 0f 85 61 ff ff ff 48 c7
RSP: 0018:ffff88815c49fc70 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88811f5b9100 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
RBP: 0000000000000003 R08: 0000000000000001 R09: ffffed10bcde6349
R10: ffff8885e6f31a4b R11: 0000000000000000 R12: ffff88813be0b000
R13: ffff88811f5b9100 R14: ffff88811f5b9080 R15: ffff88813be0b024
FS:  0000000000000000(0000) GS:ffff8885e6f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055dda99b0250 CR3: 000000015dbac000 CR4: 0000000000752ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __warn.cold+0x5f/0x1ff
 ? refcount_warn_saturate+0xee/0x150
 ? report_bug+0x1ec/0x390
 ? handle_bug+0x58/0x90
 ? exc_invalid_op+0x13/0x40
 ? asm_exc_invalid_op+0x16/0x20
 ? refcount_warn_saturate+0xee/0x150
 sock_map_free+0x2d3/0x330
 bpf_map_free_deferred+0x173/0x320
 process_one_work+0x846/0x1420
 worker_thread+0x5b3/0xf80
 kthread+0x29e/0x360
 ret_from_fork+0x2d/0x70
 ret_from_fork_asm+0x1a/0x30
 </TASK>
irq event stamp: 10741
hardirqs last  enabled at (10741): [<ffffffff84400ec6>] asm_sysvec_apic_timer_interrupt+0x16/0x20
hardirqs last disabled at (10740): [<ffffffff811e532d>] handle_softirqs+0x60d/0x770
softirqs last  enabled at (10506): [<ffffffff811e55a9>] __irq_exit_rcu+0x109/0x210
softirqs last disabled at (10301): [<ffffffff811e55a9>] __irq_exit_rcu+0x109/0x210

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/bpf/20241202-sockmap-replace-v1-3-1e88579e7bd5@rbox.co
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 net/core/sock_map.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index fd4c16391552..d334a2ccd523 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -420,15 +420,14 @@ static void *sock_map_lookup_sys(struct bpf_map *map, void *key)
 static int __sock_map_delete(struct bpf_stab *stab, struct sock *sk_test,
 			     struct sock **psk)
 {
-	struct sock *sk;
+	struct sock *sk = NULL;
 	int err = 0;
 
 	if (irqs_disabled())
 		return -EOPNOTSUPP; /* locks here are hardirq-unsafe */
 
 	raw_spin_lock_bh(&stab->lock);
-	sk = *psk;
-	if (!sk_test || sk_test == sk)
+	if (!sk_test || sk_test == *psk)
 		sk = xchg(psk, NULL);
 
 	if (likely(sk))
-- 
2.34.1


