Return-Path: <stable+bounces-100545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8389EC6A4
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 09:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30221885878
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 08:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3696B1CC8AE;
	Wed, 11 Dec 2024 08:11:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B43678F40
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 08:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904662; cv=fail; b=a+WS0O6J03UECb4MhqHhjCkfJmg+GOBlELB3YnYVCJy8Ty5GwewkBdtDmWY030aT08osi4kMFQ4w2Ox0y8qs+wdkiA7x4mR5MdlGffbzQol9KlDCLxKHarMFhax1qaxpW0vxLh4lu33pLsAs/hdIEDO5vT9YzKzuzLhV56/vXJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904662; c=relaxed/simple;
	bh=+ZT/Lt9uV/Klte7KoFQRwdrvi7QScE00RpvA5PlZjPM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bPcDIImUZyfJHaytYExWdN1ZgPKy5wlqvgG1MkuGtRewbmcNy2TlPWW5z2GC4C1/FdRiz6oGoyhJ0ObGG4JQuH2FofRLHf6d5q4fsivwOHAcwh0/Sv+N6BmzmFP/ffi6FwuPNDHvQW+N3zNBw6FNPMgOXoBRm7ZZQ2QZDJw2AVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB623vq021502;
	Wed, 11 Dec 2024 08:10:47 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cwy3kx0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 08:10:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+8LdiXKjY4oSFum4Q8CWKfJuKs6UBANaVkZnZ1U0OKRT70AqSHuRQQwXk5NdMzDUuN35d3Js7ajYz7kTSXOY02ew0OSnzsR5bqat5z3Wzx+Va6LGHBZeyx8kSyoyavtWYIXpHd9WBVelyL2AJnqoGUDpLfiM1cRbacTN+PHsD/u7fVWPEKFHwBboLlHQx1v0qPuy37MQW80DNe9sk3+d4dnVeL0kdyyPcmqyzlRZSo4N84ky6n6IQB4fwK6yGmEN2U6FTPgd69W4RhO02jr5a/FvDVtu9KuLXHSPguDU3EqbGrAE16gPNZiZa36Wj7vOUu3r5C2mZdZI9BHpV/GEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VSml0vamU1omDFVajXyvhW+umLoJks69nSGreLhIVs=;
 b=m8K448YMQjbzssCHsPUOANjTR+9sR2vupSBZJUkjTyCw5oJtouzRWEC/CDZAR8zog/I2qGfMnC0pwYmkUfB6p2qKl2tKq/8DjJCZF8tmV+0/gntLoejt+M5JR14G8L8ORevWRkmvhquvzqgnq63+hdbxs18SvxcdXgreUFRpvr07PP5eqol4Kb7WVsbzbr0wHTw9tqV480VLSHxHl3GHUYYxg1t3pTb120wwXCBA3+dpG27ZQEsoS5RB0STa/IRFfhrThNMTp3kcDtxhsGsenngCgwPoIkEJTDONtfSNM0hJYfqufsfnaHileCsSy3MqreZn2JlhCZvUVDfl+bLdyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN6PR11MB2671.namprd11.prod.outlook.com (2603:10b6:805:60::18)
 by MN2PR11MB4535.namprd11.prod.outlook.com (2603:10b6:208:24e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Wed, 11 Dec
 2024 08:10:44 +0000
Received: from SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326]) by SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326%4]) with mapi id 15.20.8251.015; Wed, 11 Dec 2024
 08:10:44 +0000
From: guocai.he.cn@windriver.com
To: gregkh@linuxfoundation.org, juntong.deng@outlook.com
Cc: agruenba@redhat.com, majortomtosourcecontrol@gmail.com,
        stable@vger.kernel.org
Subject: [PATCH V2][5.15.y] gfs2: Fix slab-use-after-free in gfs2_qd_dealloc
Date: Wed, 11 Dec 2024 16:10:23 +0800
Message-Id: <20241211081023.3365559-1-guocai.he.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::28) To SN6PR11MB2671.namprd11.prod.outlook.com
 (2603:10b6:805:60::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB2671:EE_|MN2PR11MB4535:EE_
X-MS-Office365-Filtering-Correlation-Id: 54d5b301-a45e-458e-f954-08dd19bb4f87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?er0sDu7m7ajnXI0/h7uy8RWAEI7KfA+hitMfUBVBVwjDuBxQjsTYK2b8Vgi4?=
 =?us-ascii?Q?sMVe/2jF2WgRZZvyDPUZeZ8tDvej81QPAPQH6E5+fqGrxxq2YRjmB43exgr6?=
 =?us-ascii?Q?717A2fa53oPLP7GQ8j7Cs93tT8CqshYibXmE0MkFRPujUk/vQk6suSACi22y?=
 =?us-ascii?Q?MV68td8vnebv4AKTMlLso529vxWVLpwBhVgNIlanYEG+DKMNNpnKBCEbYBuB?=
 =?us-ascii?Q?6d27DoNUg9ncA9+B9NycmTVQiYHzF5AnaDdKPItLXXpXzYqpbesqCBPR/cqE?=
 =?us-ascii?Q?t2jzERLRP/TeafkKhUsRN1WBhcSc4Sy0atyFwYaCvTdJua4ocolOkam6tNCQ?=
 =?us-ascii?Q?pWaAaUCZqUIjxWA9al/fuTm102cLx+Cxu6D2Ag9qs4dBiSTgwOCOgcfACaNG?=
 =?us-ascii?Q?5/yc08hGDFcNaAn1wy89mQ1WFFmdh7Pij5gIWbTt/4xbepwgNh1hALDs7HB4?=
 =?us-ascii?Q?JKW83lG1V8TvS2BKl9AUy5EzHN6TBtaKRqq8vTtxv2WrlkTslZUcpKqq8J/f?=
 =?us-ascii?Q?FDCbvjJ0QewpyYS0yHMtxD+hOVSQA4zJs9nsu8yWbfxJteyCDD5Eqw4apbZk?=
 =?us-ascii?Q?vuEBcKAxWBAQT2jLGNe6x+zNx+OyKO89M3ennATqwUtDfHIbdGMK8JGdYTQ0?=
 =?us-ascii?Q?yuJINKGAJU52RVLNYayxAxGhg8Rz0p6gfLoSsq67jHuuGj19svgtcz3UVK3L?=
 =?us-ascii?Q?fzGsrkiPwpLKq9+S/31NFWRyuT5bjFn33eK212KiAdHq0hdi+TdqJTwpSpfC?=
 =?us-ascii?Q?oLjaW+c+1M2/WsBwpb4AE6srxmg/ItVGS56z5DfsT0xoJ5MwqGRPtaSAvfm8?=
 =?us-ascii?Q?o4KWJNh9ucuiaV7OksEXEO6dLlWPPjNaaffLJwLUFpreiJghtlw4+PNXfxEZ?=
 =?us-ascii?Q?VqWgada6KxhPNo3M7FNqEk/a6rxEiMlXPcUAFTgQviXz+m6wDzq5ZRQRCQtr?=
 =?us-ascii?Q?las/mAXu46VynAMGGSqe2aDN9f8FJS715lUTV+k7W/qme+KvQB4zGksLQ4kb?=
 =?us-ascii?Q?IYPRefbV6VurmJua2IYQqJlS4WO/ZpB2pzUvIdBrfi9I1P+PLhbA46i4FM82?=
 =?us-ascii?Q?Fd6PdBSIZ3AGoWtNWhX6hBmbplZyrAloIj14qbB61rQy8si96ewfSDLaB6yw?=
 =?us-ascii?Q?tgg6uM7foXZQmntkcuTl+NuLLX8FJ9pEaXyWHT9Mf704yNXgrUMFZherrMG6?=
 =?us-ascii?Q?I5EXB6djLwUlPYNv4SQoWn1TOWtmuRodnlGvy560KMOQLZVrEZ04pvlPPt3E?=
 =?us-ascii?Q?ystO40jSsS3lQubbzACgbat/UqrsKzE5OnUeecg8NpjqEkJmVYgC3RWFCMzZ?=
 =?us-ascii?Q?u3Lr/YfPbvCO+wMQ2auQpaZpbMtDbKVP5/4DVJ1MJuL5JwKTRERrpQadEoYY?=
 =?us-ascii?Q?FIEZrm0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2671.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I1+ELlVZeC37iUcw2xuGulq4lS0klDS3zlbWyCdSUdUk9/sn3+poa4JAIgtw?=
 =?us-ascii?Q?+Hw87ewhxUc/yFrRcuTEwqoDHP7duBswMlOFqVj9CUlyz9P9nXbAI+oS1q5f?=
 =?us-ascii?Q?62Hfhaz2akjQfuzZ760wymG4+uoEcn3E3XTvwsE34hpzxst71j+eMs1CbXGG?=
 =?us-ascii?Q?t/X2sRpfnugQyA+hr/aXWPAzZ2QqfQa7G+TpySOi/GfvsoIz7pXjtrTyXx4D?=
 =?us-ascii?Q?MRBgIGDMZo1XuYpFZDUwjDgqttzX5FhMMDbtXGMOegywCOwqt/J/rKJ61sbE?=
 =?us-ascii?Q?1nCxC3WxjOD5ADIbdUUcishm2bCACsqsQ/coWmuLoFhV1ABItDKQf34Pls4B?=
 =?us-ascii?Q?NXGOhHU4JWXo7wljT6kPecpKxDXg0eMzeXuuxPFbpS37DQd7CODSkaMtWSmy?=
 =?us-ascii?Q?ehaxkBba0Qc3Qaaemi288MpUUjXhYTfDNUjmn7wjYhxO2qAS5Xk6LcnWc3zy?=
 =?us-ascii?Q?OA0mEuM3smEovips8UiveQDfLvdiYIZB1dZYmR3Wq+hzeebyxNBoYz9gkQKq?=
 =?us-ascii?Q?Q3ZCjNq4RKOE+cvd5VGbiRbT5GJdpCKrIWrhiAQ4/jJ/rjFqaG72l4hfXtGe?=
 =?us-ascii?Q?900sCqO+UfX6KozxjPFjCFWjIyv9AcqIYsnMOY8bMBgu3xSJpoUm+yh2nZc6?=
 =?us-ascii?Q?Hd2Jr/tdTMOdedXEVKBzs0roliQNSr8NTtpCHFIAGLWiLjc3yTINwT2HPhej?=
 =?us-ascii?Q?S8rzKXhQ8acDNC5xQzjAdyvw0uLjVbX6e8GlyJChvnNWGQZoaaca9z/DYTYP?=
 =?us-ascii?Q?gcdDh6fNAkZeNj9CMa5/K8QgN2oXxtTshticNpFJB9kxNHKndzYnbfqAOWil?=
 =?us-ascii?Q?JUfZc/aO+4fZLRLsAbd0K6nG5IXRdLk5eqsRVBcKPEDv1J1mitQKUson9kcg?=
 =?us-ascii?Q?D2YvMirbYkIjXgwyxEZT7Hdmq55fOqS3E4NxTqB6rDT4JdUkl8kmZm7YJqS6?=
 =?us-ascii?Q?IhKhTCEsO3vzcuMUMC5nTVvQYHG7/yIc/N/jljWsPtTghQJCECeINKwLlSXv?=
 =?us-ascii?Q?eW/iJcDn1nxAf8spssrb1rF7eC+UPVjR/ncz5zyeCWtv3aJmYES6xxPvr/N9?=
 =?us-ascii?Q?D5EzqVktFykVIKclUAykNPbJBhc/xmS/IHb9T8BmHG0GJ+K8ftLohH5IGo/h?=
 =?us-ascii?Q?8KTt/FYaFBdy/OARZvQl/NxQupgkpk/g5VCn+afDG4kk8ovcjDWIGLRSxWP+?=
 =?us-ascii?Q?rGXbyOiEJNma3tCamOOD2H2yV0xM1pFwaWqHMxqcq4YzC3Sx66maLYhj/L/j?=
 =?us-ascii?Q?RPdUoLJ22mPTSO1kndy++F89dUs2oggaHQL+EpQNOZmILvksk1RPDAe4uKWi?=
 =?us-ascii?Q?1CcWn5ScMOHJKGt+EMO66QjNbGMFnelkwYBHLz+HutjXUTNo8toJqWpbEjit?=
 =?us-ascii?Q?dq520YIovy2WL1lvrLliimw9k5/dkhNf9SVykTv2XOpCTHEsNVeFYEbJraCH?=
 =?us-ascii?Q?4CmP1mG/auxaq2MdByCKlkGsVQ7dFymT33vqJNEwnZFCN5o0Ao7TSoiM8VGt?=
 =?us-ascii?Q?9EW7TTtWd+NYt3BMPZolZrlwrIVQI5A0t4QSF0f3rDynlcBbK+dmIjJGczhW?=
 =?us-ascii?Q?Dcqrv6tBNwGbo6Q5TrcfPjKhGx4Bit1TOZ++Dcz8lshkifb+oQ2ye8rGzx8H?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d5b301-a45e-458e-f954-08dd19bb4f87
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2671.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 08:10:44.2035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pv1KvVnTlzm5W7UX8JGn8pbXeTNv53Dl1bdNtr22Y6ZTn4mOZHxRGOz+fS6m3KjRZUJUDFIA1vV5khS52J/CFPP3kYQFaS9MzUU4LsRT6fg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4535
X-Proofpoint-GUID: WD8W_yNylGcSwwl7aK6j0qw1ftL7aoww
X-Proofpoint-ORIG-GUID: WD8W_yNylGcSwwl7aK6j0qw1ftL7aoww
X-Authority-Analysis: v=2.4 cv=D7O9KuRj c=1 sm=1 tr=0 ts=67594907 cx=c_pps a=hSS9g3ca6WprpwKybkK64g==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10 a=bRTqI5nwn0kA:10 a=edf1wS77AAAA:8
 a=UqCG9HQmAAAA:8 a=hSkVLCK3AAAA:8 a=20KFwNOVAAAA:8 a=ag1SF4gXAAAA:8 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=kJy0AXKTCvhfZgbxjNgA:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-11_07,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=744 spamscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 mlxscore=0 impostorscore=0 phishscore=0
 clxscore=1011 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412110061

From: Juntong Deng <juntong.deng@outlook.com>

commit 7ad4e0a4f61c57c3ca291ee010a9d677d0199fba upstream.

In gfs2_put_super(), whether withdrawn or not, the quota should
be cleaned up by gfs2_quota_cleanup().

Otherwise, struct gfs2_sbd will be freed before gfs2_qd_dealloc (rcu
callback) has run for all gfs2_quota_data objects, resulting in
use-after-free.

Also, gfs2_destroy_threads() and gfs2_quota_cleanup() is already called
by gfs2_make_fs_ro(), so in gfs2_put_super(), after calling
gfs2_make_fs_ro(), there is no need to call them again.

Reported-by: syzbot+29c47e9e51895928698c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=29c47e9e51895928698c
Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Signed-off-by: Guocai He <guocai.he.cn@windriver.com>
---
This commit is backporting 7ad4e0a4f61c7ad4e0a4f61c57c3ca291ee010a9d677d0199fba to the branch linux-5.15.y to
solve the CVE-2024-52760. Please merge this commit to linux-5.15.y.

 fs/gfs2/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 268651ac9fc8..98158559893f 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -590,6 +590,8 @@ static void gfs2_put_super(struct super_block *sb)
 
 	if (!sb_rdonly(sb)) {
 		gfs2_make_fs_ro(sdp);
+	} else {
+		gfs2_quota_cleanup(sdp);
 	}
 	WARN_ON(gfs2_withdrawing(sdp));
 
-- 
2.34.1


