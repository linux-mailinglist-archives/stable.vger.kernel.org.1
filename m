Return-Path: <stable+bounces-125989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 583B2A6E89F
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 04:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69BDE3AF799
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 03:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8725A1A2396;
	Tue, 25 Mar 2025 03:16:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDC0187FFA;
	Tue, 25 Mar 2025 03:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742872618; cv=fail; b=EYOn9980i/NM2Bkwiiyp4TSYDISGhM5oPBawku7DqTnsx/G69S1vAaFbe277DbOg9raxAU+TigNdiF7/X0jaDzu7eaC6x22eFpaQ3KKkrvICPsFKJK9YVR10RD/3itBmj8lsq3g5sVXsBNnzvtW6bSLidfyzm3uA7VrzR1vF58s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742872618; c=relaxed/simple;
	bh=FX5gP4qFjIkL7VMY8j4GEOUkjNjqSK5R8N5HSCOLLQo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gEKKFkMvF69X0pGGi0T+TXuvvGIH6jUtK1g2ubC+iNIL9iFyHY/IVeBIzIbIZmjr+ntnHYUvjsfLIGBFaE0TmBR4tX1mM5wMkcpZeEXBXZ3ReCGSlHp956NTCTVG8SlFhTuQE9XCMTvLRur1prIixIh2AC2m2WfGe7m5EjFhTEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52P2g04L030879;
	Mon, 24 Mar 2025 20:16:44 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45hrg42n6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 20:16:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAbwQsTaCdvTcdOovejqSrWNEN3NhwljzCvsq+KgeUpwlDL/7Lr/vQDPX7V1UBTBdRjbqQv+nXIhTD3LvjQRoNeFRvBjovOnSsTtmSD9CKeTkNTaExIhlaBH+52W3VQ4eplvegMxaknvDfFN/HRgKimQU8foKbHo5uEmlJjBRhHpgAFmVwKOJUqrrr1kNFmhioHVI5M3Au0PgV63SUONounwV4SeplfZcCyiaav3pIZmGnvr+9SZjjr6D6n5dS3nNOvV1tEc2oxPGA7GIaHCzW3gFnNzG3V2uGksl8wqEOsyssF+6ysJxrhkWGQomg/EhaShBNLqRD/p38H/jLvoyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FX5gP4qFjIkL7VMY8j4GEOUkjNjqSK5R8N5HSCOLLQo=;
 b=Jg9JQYQq/qzhQl2KGq6ysGKS+x73/3cRO0dlgRvmCA+fZOO+6tcf2TfB1UwAN1p99Mvdb+A5k+vuq3zVTDkTec46IQvWOfIhVAM+SlFOweDnoyKUXHpFeFrDQ79J+FXhwN9CBOT9vIrwRj8AnSGSlToPVXeDkaLbBBsgQMB6YHhUTt5WwMs7B4cYPvUwiQYKFOOc8u0875KO9xLge8g/NZUUclEpUlg6OiIJtPD8YTzCSe7/tv3EwnZZ2niVpd4RmmNt5ZTmtoNSDO8m526LqEBrHE4XA1WDsh1HKr0k93CFa6aZzwaTdvfyIk/+j/nX7EVkh0tlm3/tNZP9BYbS/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA1PR11MB6170.namprd11.prod.outlook.com (2603:10b6:208:3ea::11)
 by BL3PR11MB6412.namprd11.prod.outlook.com (2603:10b6:208:3bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 03:16:41 +0000
Received: from IA1PR11MB6170.namprd11.prod.outlook.com
 ([fe80::f850:53da:e11b:1653]) by IA1PR11MB6170.namprd11.prod.outlook.com
 ([fe80::f850:53da:e11b:1653%3]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 03:16:41 +0000
From: "Ren, Jianqi (Jacky) (CN)" <Jianqi.Ren.CN@windriver.com>
To: "Ren, Jianqi (Jacky) (CN)" <Jianqi.Ren.CN@windriver.com>,
        "kovalev@altlinux.org" <kovalev@altlinux.org>
CC: "edumazet@google.com" <edumazet@google.com>,
        "i.maximets@ovn.org"
	<i.maximets@ovn.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "kuniyu@amazon.com" <kuniyu@amazon.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 5.15] net: defer final 'struct net' free in netns
 dismantle
Thread-Topic: [PATCH 5.15] net: defer final 'struct net' free in netns
 dismantle
Thread-Index: AQHbnTNct0ic9WHbKUSERw/tXGKWebODLa6g
Date: Tue, 25 Mar 2025 03:16:41 +0000
Message-ID:
 <IA1PR11MB6170CD38BCB85D9FD1CD9A71BBA72@IA1PR11MB6170.namprd11.prod.outlook.com>
References: <20250115091642.335047-1-kovalev@altlinux.org>
 <20250325030946.1111059-1-jianqi.ren.cn@windriver.com>
In-Reply-To: <20250325030946.1111059-1-jianqi.ren.cn@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6170:EE_|BL3PR11MB6412:EE_
x-ms-office365-filtering-correlation-id: a34dd07b-6570-4b68-fb10-08dd6b4b767c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?MKe7NcuIrPrFteKVmJFWyraw3I4BGZFFD78P1iampDsjLhPIHzc0iSUCa9U5?=
 =?us-ascii?Q?IuAHqf7yCi6MnSSe106Gi/BFhdIayO0hwZgnQwPIqYZsExTv8RT+5vcuIe2K?=
 =?us-ascii?Q?9IMEKO1C0qpgDXa5WeF7le27gZ0M97lvz4noJLuU88YFxCedAewNiugUY+n0?=
 =?us-ascii?Q?/kH6/Mz7iipBXmfdW+Ky1K7u4kjO548sWmk8SD563Tc6xxnHGI95m/OkDfrb?=
 =?us-ascii?Q?6qmPOhbZMOAQfTFHaZVblxwoIVAlEyH6H0zvZoSGwMxLnwVdmJzU8875bw3A?=
 =?us-ascii?Q?OnTDwWYkrdfZuqYFOvqJgf3bJjm9ZyucJwiwPnEcVZ+Sy1Lx31ewpVcLicMM?=
 =?us-ascii?Q?CEnKdTr6Ku2A+nWVq+E9jAeXey5/hctoKrPTPyAf3o6OZ6hJnh9KCYe1RLkn?=
 =?us-ascii?Q?FCmG5luKeWBWdd69aaTQE85wbKSwVvVpKmPkHxMm/GjAoI7OJsPrxFJFdTKe?=
 =?us-ascii?Q?eBT//FkNoE5kAwOfX3HVIKWyGYTIAZsPQTymS6SzNC7LIZr/lI5ajMCkD+3f?=
 =?us-ascii?Q?PS4h4C6knzmJ3/XVXIhlbpvTknmvBys89HCVhj1ewqMo3YcxxCnRPnL65c6e?=
 =?us-ascii?Q?pgXJfkCGzyIpJQqOkxUfpN+pwyp0VpRkL0Lkwqv786czPeiXwm1yg6z9Q8FS?=
 =?us-ascii?Q?HzfIpVCQZOLc6TTkLXZCK4xB2jyi1W2hjX8dn81XhOt297bjpm5hqIQHk0l7?=
 =?us-ascii?Q?ACtr1fpqPUFPmoYpre+mH7SiFLr/CTSV/fl5k5pUqocAIce5Q71rlqAOQWG9?=
 =?us-ascii?Q?yO7WmBraOAEHpXzTYg83AqHVT+hVmAHrjR5uIZPB80vjwT1CK0f/bd3kkYZs?=
 =?us-ascii?Q?aR11KNw9AqnwX6viqUyJIWKqR4W0VIUsBWKXXOoZGZRwY8zvLjtU/M+r6zi7?=
 =?us-ascii?Q?PASytqP1IxekG6wgtW1WGX6NlFLI/pIhywlbQ3Xk60keGj0DKFR4CCaKslmb?=
 =?us-ascii?Q?yOgvWhPdM071wMui9c+lZH07sALBR9k8XPVO2yc4qFtjg3r7XHu3/qMk85oH?=
 =?us-ascii?Q?0J4pcilROvF7YxnER06kAN9bd84fddRFqydrqSYsTjrgDgfINFw+2/fW9dH5?=
 =?us-ascii?Q?RcmLL/DXD59bK0je970o13Gf1/STKxDfu4yq4I6rMM7wSj5rWIIoKIhnIQqj?=
 =?us-ascii?Q?X/TF7TIW3CRL/KputHWEKtvWM5IcdmqShqp2HraJfosM+DoBi7vraHeuYS90?=
 =?us-ascii?Q?Y1vQ85qDptGDTnyt+Jk/1jML9NP/gRmQENDS0qMb/iSG0wBcyxYFivDH582f?=
 =?us-ascii?Q?ivNRqUy/7TI739TWIjuFRgDkodGFuF4FaxEq0ajLTWTeTZcwPHfPZFAECtWn?=
 =?us-ascii?Q?uDVE6s8OYvbOAj0qrnNe+x7Brg+c+QIfKQ4aYLAkuHLik9zmYPW1pkGLRcLp?=
 =?us-ascii?Q?zoPUaH7KqSU2Nwxao0zj4Zcr1AJJ9zCP//bqE1GwQiFtOA0VGlgOGeyiPZeY?=
 =?us-ascii?Q?yMimHFNwc4X4jmDGykPYPPow1cMlMWSj?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6170.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WFr/D2hiEG07lXJhBNIXHQVL3ds9+viCZnOnEDEE6fClZ1MQza6bVsR5GFlp?=
 =?us-ascii?Q?TDgWXGrJDVkho9miASqujMNFSOkehoODrLqNQVi3atno0da5Iy9c279hSzyC?=
 =?us-ascii?Q?cn12NWZchiKLHEcnNxJEd3ZZSU9a0QUVoXBO/FzixIAb1isPxlQ+ygc0r9iP?=
 =?us-ascii?Q?4bCAAAu5mmZ0vxhBxbf+coeBhZUQUZAzygnvG0Wg+czkXX5S+Gejns4OTyrb?=
 =?us-ascii?Q?LxdwIPiDhMPXKVtpsJen4xFDqp44bhqtTE9bLK5UMeJeEzMCWP1qBjbZ8cgB?=
 =?us-ascii?Q?GmdFCO2IhBzgknzp/0e7EkPkWgJ4dziiJHECJwt9bs1ZpGGWjGwF1SDln0hj?=
 =?us-ascii?Q?tO89vao6aJi+d6wijFn5M7F2a+l0PD2E21xoQUBhL3ESEftIZgBfX7JS/3IM?=
 =?us-ascii?Q?6+IVFd2P/UCx2vX7fCQFy1S+8LpUzo1riWw6CqHCi8jAfzqm/mvWOrSFYGUY?=
 =?us-ascii?Q?tlhK+rg7mtlS2QTVuVJ3x1zUAV/NzAOIxybmd6Iv8k1wh2hWqQ9ZvbTwgWgm?=
 =?us-ascii?Q?WHgfj2LCIe9PHgjN7tasOluCNLG8OOlEZvMspzHGb7Ls5VpimR3QKIb9MepR?=
 =?us-ascii?Q?1XkEVASUFmtm14y33dXZDsmao/KoXjdfT5UR0l53jkUW2gT5IgRPh+IO6V4r?=
 =?us-ascii?Q?UEX7mMKeQaHEG/EJQ0zi3u+oGT1k2UfGopQ03XYodrxTGdslPP1+LV41zRll?=
 =?us-ascii?Q?odw1rX2ff64pzONlXqRY4InRfuVPGYya8hF7x7K2AGlV7BCic9lPxobEq1Mu?=
 =?us-ascii?Q?LO6ezao+Tfa/dIeaNkU89SHIzOhQiH6H2SK5OK8pyHbEDUFS8ojNyBXpCw3V?=
 =?us-ascii?Q?+5Gl/tHmHmZE4qr4lEmr4dtPrIL5zl0QA7aPZZXgrcv+10AqqBYTOgeP0UKw?=
 =?us-ascii?Q?k0LoDjoAAqCQF9hkVtLiPniwiaxT09RmU9A8uGoRduJhgQyyR4WWm1qye/h0?=
 =?us-ascii?Q?q+D3n2Gq2Ly4RfG6VBu6EXEO7V25QdkRs7pcxlnQXgPEje+sV3IBsliYpAl2?=
 =?us-ascii?Q?WAbQ2nhMspxcG0Nf7HJC5qzRiMSrdZC97yrqzQ77n7th7DhaOaAQYZCRkgto?=
 =?us-ascii?Q?duROJnnthuU9pfoxA+z6T6gpXKFG/jdCtcqCyJpNziGzob0Iv5UYz9365PtE?=
 =?us-ascii?Q?i0HIAPxHUIh8YIC1NGTw9ZhblOlI/BY6S4IeDq900aH8liZK5fgeCUOcND1x?=
 =?us-ascii?Q?VyBtGWzjFEr58s+0gTnmdW6IGePgRpytG9cb/6uvDmsSq6ttlGmURjq7M5lZ?=
 =?us-ascii?Q?PEPuqYGKtNGnMiNsZe85HmSCeRYT8xRKE6f4IJKHTAmW0rgxleLbj1H+dQoH?=
 =?us-ascii?Q?JTl3DVN8wPMnE1/04UAnc55rG3JuM9GN0B4c+aR1q1Vu+3d5DyVznlEHFO/5?=
 =?us-ascii?Q?jxjk3Wie0Z2erz1f+dGgHw+T8tyowLqQuGb4eAaMaIRTbDdKLHpc8MK3QwW6?=
 =?us-ascii?Q?8skYPhGWhBbud3O3Kw+xKY6CXdFJcC6bvraJjwRBhv5MmpYvtaQwy/lfL4j/?=
 =?us-ascii?Q?5TqV80R9TDqRJwY+w+NyNfWYDUPk3LTHi3cRVU3lTMzXyaAZ5AwiGREdgGRJ?=
 =?us-ascii?Q?0wJNh01MqFtCKZdE0aZ6I1WXQPAFl1Im7rmyJB87?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6170.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a34dd07b-6570-4b68-fb10-08dd6b4b767c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 03:16:41.0804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MvfLdVOjB+fpimqzRf3dt3dnHkAwyU5+PKPaHRXAGNUmTu5oM1ewXHnrT5yjcxCuMJwoAnjuPB4UoBeEZbVSTk/6j7Vn873OfsIoo7ZX6ig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6412
X-Authority-Analysis: v=2.4 cv=HZwUTjE8 c=1 sm=1 tr=0 ts=67e2201b cx=c_pps a=5b96o3JgDboJA9an2DnXiA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=t7CeM3EgAAAA:8 a=bH78PYQqAAAA:8 a=1XWaLZrsAAAA:8 a=P8mRVJMrAAAA:8 a=VwQbUJbxAAAA:8 a=vggBfdFIAAAA:8 a=20KFwNOVAAAA:8 a=PPwAqyY7E_KhcWHKtxMA:9 a=CjuIK1q_8ugA:10 a=FdTzh2GWekK77mhwV6Dw:22 a=TrXR8j8ql9YpJ1_1srv2:22
 a=Vc1QvrjMcIoGonisw6Ob:22
X-Proofpoint-GUID: 8BtSfcuHZC1MNuFgOU6_KnR5cySthGoC
X-Proofpoint-ORIG-GUID: 8BtSfcuHZC1MNuFgOU6_KnR5cySthGoC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_01,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0 adultscore=0
 clxscore=1011 impostorscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=705 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503250021

For 5.10 correct the version number to 5.10-stable tree.

-----Original Message-----
From: jianqi.ren.cn@windriver.com <jianqi.ren.cn@windriver.com>=20
Sent: Tuesday, March 25, 2025 11:10
To: kovalev@altlinux.org
Cc: edumazet@google.com; i.maximets@ovn.org; kuba@kernel.org; kuniyu@amazon=
.com; netdev@vger.kernel.org; pabeni@redhat.com; stable@vger.kernel.org; Re=
n, Jianqi (Jacky) (CN) <Jianqi.Ren.CN@windriver.com>
Subject: [PATCH 5.15] net: defer final 'struct net' free in netns dismantle

We also need this patch for both 5.15 and 5.10. For 5.15 it seems this patc=
h has not been accepted yet. Any reason for that? For 5.10 I saw the patch =
41467d2ff4df("net: net_namespace: Optimize the code") as a prerequisite for=
 0f6ede9fbc74 ("net: defer final 'struct net' free in netns dismantle") is =
already in the 5.10-stable tree. Would the original patch be accepted in ne=
xt release?

