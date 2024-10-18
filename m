Return-Path: <stable+bounces-86830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 241809A4085
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 15:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2BA4288D19
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 13:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9651DED5B;
	Fri, 18 Oct 2024 13:55:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CD41D967B
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 13:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729259701; cv=fail; b=ZbDU/TctY8/S2aDKSyOJyrXSlVNSKZhvya6KyEMjlaaZ5gQK7VQs1vCnCfhiIlNzAYuwxawVBt2QBmRWU0Cp468IrpiTnts8igTO/uqNIjQIpO5GOJ9gVoKArr1BIqY9MwHOGaaPLXsN/GthEDNzlzJ2BIkoCfneDcthINQk0Mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729259701; c=relaxed/simple;
	bh=uK8WhUyzH9PEnnnr8H16LUdbD7MpamTJJ/cuUUlYm+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oNagwZJfV6hH4DvmRvoSmnzeOvPO7RyKqr5/fWx9sa44Kj5SOvsRwIdpxjCXRA6e0h2j5XHmL8isj0TjL4Fs462l9WcMku0ngYVNsb5htFTzpWuOwMJN91SqUnMz808D9a4JWgL+fm4mql/uVbBnaXy13qUzlL7ANMcTjOl2xUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49I6bOuh015585;
	Fri, 18 Oct 2024 13:54:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42a3eska7y-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 13:54:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RYNdcfmdzdaGziHBlP/UGWTYN20GEaxfN5GRdG+AgBz1V5yrSeZmIjNxSP6GEXx64sTdi7/nXSndT8Dz9+705eHSIKRolQTlGw2Iw8A6XESzAAahditUppct+dMdj5bByOIO1zdVezofPo6cR3jxRhGW8RU/kJJ/vNAJs9jP3RzxzR74g6MwDvROKnAZF5tTO3KhArS4NDRpXt/XMGpZ/72G3ihm5tlbVuF97+1XXZvp/PLMC4NJC5DpLcBdx7HQWtnxbuUWd1nnP6rfJakrG7W43o9ZgR7hmZtvH3ErJh1XhiAo0oYB07yT28sv3yflaL2VxVsOi5yt4TKxYQGtTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XBjBjpJpphnWEFwpvQ/Tds+nIcBPElRrlLuTu9GBto=;
 b=GFGbNScGhGTvJTB2jW8NLsEvcjxOgul8y6eq6GPAPUnsfGfxRvp5eVdwkEqA+4Xg8/yrAkR7NO5G6MCAMYjofpQEM/l8ajTPFcyJtjMqwveb8U1g9XMbBNOgnSDLKOjfEogleXn4Vy5w7oKMqkJ+Av+VWo5McnvIxcuszzUXv8sI+Ew9kgMuy/B3oMjx+yUWOaT6yy6eG1m40LjZlCbjPKW8duRlLCv8a8ljdpwXAjprBN0yzRdJk0f5FTwNe07wBUN6floMWsTb5JcicbpwSSfxeHHtJKpBPPfkdpiXAfZv/4oioOXQtf7LhByQsDF7jacK0BibsxJYNsEAg9Bk3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20)
 by SA0PR11MB4558.namprd11.prod.outlook.com (2603:10b6:806:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Fri, 18 Oct
 2024 13:54:49 +0000
Received: from SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538]) by SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538%4]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 13:54:49 +0000
From: He Zhe <zhe.he@windriver.com>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: [PATCH 5.10] ftrace: Fix possible use-after-free issue in ftrace_location()
Date: Fri, 18 Oct 2024 21:54:26 +0800
Message-Id: <20241018135428.1422904-3-zhe.he@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241018135428.1422904-1-zhe.he@windriver.com>
References: <20241018135428.1422904-1-zhe.he@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::9)
 To SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB7527:EE_|SA0PR11MB4558:EE_
X-MS-Office365-Filtering-Correlation-Id: de88256e-9292-474e-e1d9-08dcef7c6ec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vx60+5OYIteu3rrJcm4eyuP6NyY/rA1KnNaFPZ3sOj2EUHnLfeGZY5pu3QKe?=
 =?us-ascii?Q?GE9wkvudjeu/2pu8eGijmBboFng9sDrcQ+Be2DgiyYeeoBEJ3D922/NZ/xDo?=
 =?us-ascii?Q?txD0GhiDXQJRxSoh/P4DbLUtTdT71ilknzbWXePfAq1HvPmODUs9BeeYD4Ic?=
 =?us-ascii?Q?O1j4T/BADF0KlapB4BvAPkd6dv735NJ04zC3HCUFNqwt11gdChEQlhbx/OwI?=
 =?us-ascii?Q?Ozr1uXrHlamnCWjvpD0+NnaARbo1UzaYX9jikzJn72PXUmLpng35Fo1VNiKy?=
 =?us-ascii?Q?3miuFGnP3L0FTIZpEvNwaf799cDqH3w47DMFuDDkMBmyBLiQSqzfm1oIy5FP?=
 =?us-ascii?Q?EjqBul0911chXHWqrM5UrHOoTcerZIy7O0BC3LI4smF+ZPRnQcHbLB6PrwJV?=
 =?us-ascii?Q?cNm3ExK3orB6F3tjASf0Q7mIEvt79ulm1VWKAYZhNY1YJh0vvFHsxr3AqHb3?=
 =?us-ascii?Q?3MEW2CY1145MQ2FUZO4mcAgvUNoqV/P9nwDD6VHp3cM4Sw+jTX0ACYKtBwmn?=
 =?us-ascii?Q?p0EVXrinCmLkXhODOjjcutOcmrAGq9Pcdf3m685/OBxdjtAvwLrETenIaFPB?=
 =?us-ascii?Q?6SiDqsHH/G1Eqwb0MYBcMMvgN4OB0COl46TapRRRWKK7G5jdfQu2xIGYjoX8?=
 =?us-ascii?Q?aWN6JHO87x8er9gCmKFUTdhiRgQQjMks46Fl3pNjbdpZIqGI5WPKZV5HCcTd?=
 =?us-ascii?Q?v0h16SmQupmv0xXfpyYaJS1KZhsQvw9BcC8wJvHX8pyQVwOA3wk94kGrMeQc?=
 =?us-ascii?Q?+8xRJ+pVrAMxHWOxmWrLYgVw9v+/b9JdwQTt7yMF5e0O0yCm6U2/h8BrTnBS?=
 =?us-ascii?Q?cNktATxk1a4dljKPaWtiFb9iTJw+WbZFa/VlZ2Xhzf404cGv0yr3T0yKXKn8?=
 =?us-ascii?Q?5h786i5Uf7zCA6FZ5fb590e7KHCx1AFx5d/BphorUNpeR6h6zMBMf9p6yJay?=
 =?us-ascii?Q?YNZ+IFHVyUl74L1WgIMqrtcE9/8PliXdyeiBJHeonI1uT6zDwcZ6e1FAZcsL?=
 =?us-ascii?Q?MSLYMEW26fPvPz4YjlmRnGYJHS11kN3+3IKCXtcCTnpBH3O43/6cTvItaIrl?=
 =?us-ascii?Q?LgdLU4SLfQ0irzinqAak8rwMAUerzkn9Cm1MAfO/Z3F/RfxbyMsUP+l50EXN?=
 =?us-ascii?Q?3jHUe23PkAYcSvgQn4Qm8WjD/VSBv19JmrWU7tQt+YpqSCr+VozwAdKCuwlZ?=
 =?us-ascii?Q?3URRi3PNNtZa0vwXeyQKuQclwhWy9TCk1FY9/L/cm2QeVKy/z9/K4jkKP99U?=
 =?us-ascii?Q?gwFfOz3/+gOy8BfTN2+UbGxrbZirfL9OH/zhZke7M4f3+jeVZ0e7QX014SGa?=
 =?us-ascii?Q?PXnMAs3m7KsUQn0PVibbkdc01hsDbsCsh/URoiAChLJf57+sD3m3YNjHoLCM?=
 =?us-ascii?Q?gapuk3eg7RZedk6dv2mLTEiLGR9F?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7527.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7eAo80jfFXsXFaokNkN4IpTOvBcGS3SKDmHDxffXjcLHJU3WPvc3CD50DtwC?=
 =?us-ascii?Q?mykupOvHK6ADkvZ2nQcllWTPElRp/P6Si5ahXh7pkEtK8xg9Y57x8dvmKiEl?=
 =?us-ascii?Q?IIdLB6FZe8WJhIwBeWw7HFnqPqep+8MlZdj4E33DUS2TVn6ZyMbYCTJcsJ/B?=
 =?us-ascii?Q?vj2TNtkPrH/cwFXAB3oFJa1oD4yU6sOScOy/Ze571oEtRJS30HbhLfA81F9q?=
 =?us-ascii?Q?8fJmRhzAB7qROtnMFKF0P+lrCWJio1grfajAseFnIm4az3a+LcPrrPwWLSeV?=
 =?us-ascii?Q?6c/iGqr96E5sVFd6teD7vzOf9dJHqGcjs5TOlDZRLWdLP3owG8E760LwWDoE?=
 =?us-ascii?Q?YBcF1uZpPNL+mH9KBXE2WVTG800MFMZRG3yInJ+5NnWI/+KgKBLslap4mKBW?=
 =?us-ascii?Q?H0ozwdcc13Ns3YOAUNbXv4ewJKUrNXBXMQK0sidhdc3jma+PXw0GRPShgRuD?=
 =?us-ascii?Q?624gnMOjDhJVOdizdTaIEmk4Qw72iGciypLEaLOx/IEYIX0Kpe9sm6cvAi1/?=
 =?us-ascii?Q?bpASVDDdb2Vwmkp2MvBzUfaJfBsmvjWJqEGQRVEwkRxSaMGNDeaI4w0RHyZ8?=
 =?us-ascii?Q?9IPS+nBiOOOnMifYw+QiHOOqLCW6EVP2rYrwPvjE2MtiEbhqdRCNlvKBjlj/?=
 =?us-ascii?Q?xKbzGxiay13EepMCP3UCkOv4r6ZZOOLh/m7Q86cBG/MujVXkIF19WVKeXZry?=
 =?us-ascii?Q?9VQWP2eyLRXGBOK6JpFb0cEccZMngmA665CMfVyT+QQITpv3UfaH6WcV++kQ?=
 =?us-ascii?Q?A24rGk/vUuFGq8zOOD2mLkpy4DI7akAsN+q9q0CIBjHEBhntHgeAbYWGMQC2?=
 =?us-ascii?Q?Yv9icVId5khoOP0OrCGk/52b6i8vSXAm8SVGgpGiJc1wX9NjxcoyB/sAfZ0t?=
 =?us-ascii?Q?GwKYgYGarjffMufUsaXZQrCb66NVA7s2UCFfEDlgPZvsieC0U7+HHkpWyL97?=
 =?us-ascii?Q?2tD02bUSmA/rDr+OquO8NqTWKIlK8zXPGX5A8xfoZJrQU/VP5eq+qN8uyhGB?=
 =?us-ascii?Q?klIwH/ACDNnrAiA6RcSTPhwMHBx0dd+SR6EBLITNaJrxACidUX5WidxnUHFJ?=
 =?us-ascii?Q?G6LBYTWIIK+gj1K4B7s5Obp51JzhFPsbHA6RMZ0sApZ6/neJGwFECeKc353O?=
 =?us-ascii?Q?igNPAh+0vI3h+xtcAmw6Rm+EJfj2pBRy6EyaAXDly39VPhFBIINAex6KV2ll?=
 =?us-ascii?Q?hJZTibPpIW2ax+jBVhuiYMCp+1o8FVmJjYwMoVTbbZFbuRkdSPa7m+sGthhP?=
 =?us-ascii?Q?R+aoP3Y+odH61aqF1jRrVWPoVFiAYVa97wBqSmC3IAZ3WlimFU9QYULbYu4m?=
 =?us-ascii?Q?X/jCx+1Vf8xp+25EwzQn9MKf3SgcUVvYI/IPf+tNBz4cWRWU+m0Cb9qjcuvu?=
 =?us-ascii?Q?hAIglyHdtQ0zU437eZAcoqvF5HaUYlQRh7oJ7P1Bcbhr5CT6cLXnprWps+es?=
 =?us-ascii?Q?jJCKnDz3HO7wi55U29eevn12xdV8qYI8/O8740A+DsYMiTlm80cqwIQrzcGH?=
 =?us-ascii?Q?Kuzq6o9EC5SozKsbql4gSSFAR1bW0uiiSwK9q11P35K/0Ib9bAWqxjw1eaYv?=
 =?us-ascii?Q?MCweMk86r2yFmKYZv2cmmxdwoSy4DcNuqgm8AAjF?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de88256e-9292-474e-e1d9-08dcef7c6ec7
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 13:54:49.4866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q528yFB16MowtmNBLfH822W+2dne2BlNIpuydJ/AxsKwweDOp3nATdlX9Fo6FzoZkUj3v7TuDNmo9TQzul7dQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4558
X-Proofpoint-GUID: a_sKJliVtNwQF3lBVbZ9kQfAl_WLcnvu
X-Proofpoint-ORIG-GUID: a_sKJliVtNwQF3lBVbZ9kQfAl_WLcnvu
X-Authority-Analysis: v=2.4 cv=cPWysUeN c=1 sm=1 tr=0 ts=671268aa cx=c_pps a=GoGv2RwMe+/7w9MjyR+VRg==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=DAUX931o1VcA:10 a=bRTqI5nwn0kA:10 a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=7d_E57ReAAAA:8 a=meVymXHHAAAA:8 a=t7CeM3EgAAAA:8 a=64JCP_G7tFV7NDT-GxMA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=jhqOcbufqs7Y1TYCrUUU:22 a=2JgSa4NbpEOStq-L5dxp:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_09,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2410180088

From: Zheng Yejian <zhengyejian1@huawei.com>

commit e60b613df8b6253def41215402f72986fee3fc8d upstream.

KASAN reports a bug:

  BUG: KASAN: use-after-free in ftrace_location+0x90/0x120
  Read of size 8 at addr ffff888141d40010 by task insmod/424
  CPU: 8 PID: 424 Comm: insmod Tainted: G        W          6.9.0-rc2+
  [...]
  Call Trace:
   <TASK>
   dump_stack_lvl+0x68/0xa0
   print_report+0xcf/0x610
   kasan_report+0xb5/0xe0
   ftrace_location+0x90/0x120
   register_kprobe+0x14b/0xa40
   kprobe_init+0x2d/0xff0 [kprobe_example]
   do_one_initcall+0x8f/0x2d0
   do_init_module+0x13a/0x3c0
   load_module+0x3082/0x33d0
   init_module_from_file+0xd2/0x130
   __x64_sys_finit_module+0x306/0x440
   do_syscall_64+0x68/0x140
   entry_SYSCALL_64_after_hwframe+0x71/0x79

The root cause is that, in lookup_rec(), ftrace record of some address
is being searched in ftrace pages of some module, but those ftrace pages
at the same time is being freed in ftrace_release_mod() as the
corresponding module is being deleted:

           CPU1                       |      CPU2
  register_kprobes() {                | delete_module() {
    check_kprobe_address_safe() {     |
      arch_check_ftrace_location() {  |
        ftrace_location() {           |
          lookup_rec() // USE!        |   ftrace_release_mod() // Free!

To fix this issue:
  1. Hold rcu lock as accessing ftrace pages in ftrace_location_range();
  2. Use ftrace_location_range() instead of lookup_rec() in
     ftrace_location();
  3. Call synchronize_rcu() before freeing any ftrace pages both in
     ftrace_process_locs()/ftrace_release_mod()/ftrace_free_mem().

Link: https://lore.kernel.org/linux-trace-kernel/20240509192859.1273558-1-zhengyejian1@huawei.com

Cc: stable@vger.kernel.org
Cc: <mhiramat@kernel.org>
Cc: <mark.rutland@arm.com>
Cc: <mathieu.desnoyers@efficios.com>
Fixes: ae6aa16fdc16 ("kprobes: introduce ftrace based optimization")
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

CVE: CVE-2024-38588

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 kernel/trace/ftrace.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 31fec924b7c4..8dcac51b492b 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1566,12 +1566,15 @@ static struct dyn_ftrace *lookup_rec(unsigned long start, unsigned long end)
 unsigned long ftrace_location_range(unsigned long start, unsigned long end)
 {
 	struct dyn_ftrace *rec;
+	unsigned long ip = 0;
 
+	rcu_read_lock();
 	rec = lookup_rec(start, end);
 	if (rec)
-		return rec->ip;
+		ip = rec->ip;
+	rcu_read_unlock();
 
-	return 0;
+	return ip;
 }
 
 /**
@@ -6299,6 +6302,8 @@ static int ftrace_process_locs(struct module *mod,
 	/* We should have used all pages unless we skipped some */
 	if (pg_unuse) {
 		WARN_ON(!skipped);
+		/* Need to synchronize with ftrace_location_range() */
+		synchronize_rcu();
 		ftrace_free_pages(pg_unuse);
 	}
 	return ret;
@@ -6481,6 +6486,9 @@ void ftrace_release_mod(struct module *mod)
  out_unlock:
 	mutex_unlock(&ftrace_lock);
 
+	/* Need to synchronize with ftrace_location_range() */
+	if (tmp_page)
+		synchronize_rcu();
 	for (pg = tmp_page; pg; pg = tmp_page) {
 
 		/* Needs to be called outside of ftrace_lock */
@@ -6803,6 +6811,7 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 	unsigned long start = (unsigned long)(start_ptr);
 	unsigned long end = (unsigned long)(end_ptr);
 	struct ftrace_page **last_pg = &ftrace_pages_start;
+	struct ftrace_page *tmp_page = NULL;
 	struct ftrace_page *pg;
 	struct dyn_ftrace *rec;
 	struct dyn_ftrace key;
@@ -6846,12 +6855,8 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 		ftrace_update_tot_cnt--;
 		if (!pg->index) {
 			*last_pg = pg->next;
-			if (pg->records) {
-				free_pages((unsigned long)pg->records, pg->order);
-				ftrace_number_of_pages -= 1 << pg->order;
-			}
-			ftrace_number_of_groups--;
-			kfree(pg);
+			pg->next = tmp_page;
+			tmp_page = pg;
 			pg = container_of(last_pg, struct ftrace_page, next);
 			if (!(*last_pg))
 				ftrace_pages = pg;
@@ -6868,6 +6873,11 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 		clear_func_from_hashes(func);
 		kfree(func);
 	}
+	/* Need to synchronize with ftrace_location_range() */
+	if (tmp_page) {
+		synchronize_rcu();
+		ftrace_free_pages(tmp_page);
+	}
 }
 
 void __init ftrace_free_init_mem(void)
-- 
2.25.1


