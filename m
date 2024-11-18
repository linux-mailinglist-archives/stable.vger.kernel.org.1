Return-Path: <stable+bounces-93773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6689D0B2B
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 09:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25110B21A2E
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 08:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01BC13C9B8;
	Mon, 18 Nov 2024 08:45:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F195323A9
	for <stable@vger.kernel.org>; Mon, 18 Nov 2024 08:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731919545; cv=fail; b=iljcXm48HwKMwln98lehccRNtMC9PSX0Bdcji8nVZakpvyv05BxO30QeC0IG3tuWjlxUnD2kZUGZ3WSnrQ/AIE4YdAsFcfNHxQwo36ChFS+7ITjaS7JoCmaT/2+kevMTV8CmeHfXrUghw+ntEdw4Jpn5ZB8OsgbIpt1WUwsfKFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731919545; c=relaxed/simple;
	bh=sfvj4EVTQfbVH6NDYHS1KhA/VYeo8ZgqV1QzGAlPAFs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PeDWVKc/jU1cJPYKUZlRR8E9cvQVod2znVfnkYAJlPB2cIRDYf+YuUp+y5GTWyvPK+ffE5d3xfMdfOeDgXRZ847qGU+7TWXOygWbNVmvklJWaDTibWXJ5/u2q5I8ESVo0hDdTpThZcGESekfz1uRujmMvhEeMhXwUPXDy05wfOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI7qepV032025;
	Mon, 18 Nov 2024 00:45:38 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xqj7sc89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 00:45:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7bG9LrjXPJkoP6sqJEpIP4b6rCMfwH4zpJCsvcWFTohXA1hklVE2A6x84PmoAGJWkPv6Max3zA8TkBCldiahCzFNExuoTsUf8LyajuQTyU7CTZ/aECGlDkopzZXfjU3EpO5YR59cRiYgURXYhXgs05Z4SDf4cOt9px+4u4rERr6yYZGM+wYlLK6kfGyKOuJkRkBORCdWbJZG1u0+ejKBi052M00BO7lGQGv1ntfxPVnYG3B9ad55a95T1cj6cdEnxiDKxWlij+OuO3EqfWW7NN6+xdDPxyuRK1Oby0wyIf623N/nsAdexeyLMjhZqrVmoIAPeH9D6mftLU6T2wReQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItULU6eotRGK0RzqIDNZ4rsJqEYBg7fToAJWiz0OC90=;
 b=AHJpcd55LP28l7+2kk6Mnlm3wKIa/rcvpR0wYj5qZLCSR+fRv1KNnSFd1etLTGpgFtIv7QKe9URACAwCE39OWz5oAamFfJFGDtLPuokk7EyNuZagLHsx2wswCLH0NbRf7vq0wj7zpp+OEtorliHILozUrWKIVb5maI7p7IS5IYlgp2f+DoKm1eQOvG5UAS0qk+ZNxMMxSDTqzXCZE9xj2tUQiZilGsTD9aNkd1PLIW59hjDTUgVkOZOeh3Odmdb6icPK9XR1evNX8/2bL4c6TeRXbtHgQXQ6NkQOeqcSOggQ4m8Rv6H1dsSFNyljEaFaJ+dFNcKqfJaOjR/WNcq/gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by SJ0PR11MB4784.namprd11.prod.outlook.com (2603:10b6:a03:2da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 08:45:23 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 08:45:22 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: quic_zhonhan@quicinc.com, bartosz.golaszewski@linaro.org
Cc: stable@vger.kernel.org, xiangyu.chen@aol.com
Subject: [PATCH 6.1] gpiolib: cdev: Fix use after free in lineinfo_changed_notify
Date: Mon, 18 Nov 2024 16:45:23 +0800
Message-ID: <20241118084523.2544274-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0035.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::8) To PH7PR11MB5820.namprd11.prod.outlook.com
 (2603:10b6:510:133::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|SJ0PR11MB4784:EE_
X-MS-Office365-Filtering-Correlation-Id: 552a917e-c14d-4989-5e2f-08dd07ad5678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NdtHSgiyxQ9c9R0NABTYPac11fiFEj/5Rz1mIp5qU2j0Q7swNbEH7WFMTzbS?=
 =?us-ascii?Q?aPbrQhX+Qbk/JzdRjySCzXvUJOFU/NJidDT8TzZTDDDl0+jyp5PJddtMurgl?=
 =?us-ascii?Q?yMUYeKL0Umza5Rj+cm3r+3kAZK5VXjvllIy25FJowrokRSuY3WtvMqCWwMGy?=
 =?us-ascii?Q?xMjys6DYvrJ/wYIH4Pyp/Wlz/E8mUSxD6lIHFosLtOVeGM36pwOEe8IiTzpl?=
 =?us-ascii?Q?OnqCj7AYsi1LZWo5tOsj0YylTLqp38QTV+8lbwPXT/5tvDeQ4iqVRGrkQuPw?=
 =?us-ascii?Q?FXzGatX+4CHxW6bJYir10CeFRirL4trFLhn56EDwlVpElWu1oFm3RrufE3t2?=
 =?us-ascii?Q?9nkDnd8e5/dsbkzZ+2FHOxgBiZXZmaZ3l5MoNfwbo9n/9+gMxanqu+yC6zQx?=
 =?us-ascii?Q?Cd1AHlWfAsSScI//YPPMGN45aoaeSeljvzKqrzWCOutm4U6AlsJ21g4kXHeC?=
 =?us-ascii?Q?I5u6dWuGrG1gBMdbivtQKMoJheRvbAoADxSb0t5uU7ftNc/gDg7O2au3FdbP?=
 =?us-ascii?Q?VYfTX83w6qrNhGl0oCGEMPSAFdG9ltC1RIRidJk+QVAbIOq3lUV+C6lm4aTB?=
 =?us-ascii?Q?6EAj0HMUdNXFhhWc26vRvdGyxb+BRC7AWEhbLf92l+50qcPGJ+qWDLEIZzJJ?=
 =?us-ascii?Q?KP0mgK9ZrT9FDfl0UuabtaljCdBWNIeIDZJv0w0Os3ALhgXMaoQvRiWUSGj9?=
 =?us-ascii?Q?GfSOK6TLpMAb6NRGHlpuY4plekDzsSgRu+za+aPtC9AzApm6kTmr6rZS8SbS?=
 =?us-ascii?Q?i3dkwvmTtjra+89sA+j06z4+XZiLb9msR7P5Cfau4D6z0uiWMAOGtizi5g3s?=
 =?us-ascii?Q?1c+J2ROWiMrZhPE5e96SUbZFZuZCxALNI0IksDbUUjz1Y8FfNjtSCr6KpuAs?=
 =?us-ascii?Q?Bx3WOV8iVJLRGlr/Ly49sX//caZvAe191lWMI55oEhrCPCI3tO4QdaJya4Sz?=
 =?us-ascii?Q?X4IdFFd2NtTVzgFDcdKxdKfvgsmmzbo1vsPQz/swV5fFVNDVkDDk4KboiK5M?=
 =?us-ascii?Q?ALYw3oZJm7x6n0iDxqRt/ehF4fqUNeFfoZ1m7v1aYU+uWYRIJ/85r/p0Z2TF?=
 =?us-ascii?Q?PYJDQ5ox03ESVgxiD6hUWEhkaXixrL2XJCcL9UTfl8jBN05SZsJVZjd7+j2V?=
 =?us-ascii?Q?IFg4Hm43NFoGksFZbjKxdmQ8xMP4WRILA4F3yzifMniPet3vXqfXGZYE9KDs?=
 =?us-ascii?Q?JtfB9ZaYgccxdpJP9vm5fmh3CViV5HJX/xvLQe+ZpHhIAJNJHbiFnlvzz3LD?=
 =?us-ascii?Q?SaGbqK3yQAgQ/CAG5XB8hX15SYYGczfVV71FAQi75bB5oltfpeCct2YHgyje?=
 =?us-ascii?Q?1SvWmK2tf/RJaQjBGGLzOg1voLCjd5FFjaX0OycXL+2YfJZgNU1KqbP1eL63?=
 =?us-ascii?Q?T/kq5eQnXygcy31Nu0LW6NyITLeY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ErCrFhbFy59tO46ZhUYGAzUt6psYO9Qc/yjrW0De0sQCW78lDz5OeQK/exuW?=
 =?us-ascii?Q?iH2n29LdkDrFEmvxHnRbipWi6p9Wn0xYO6lbwdJczZXV/YD2iK/Nk+UlZjqt?=
 =?us-ascii?Q?dB18eG9iDSXUoAn/KgY8A4Oozt4pb9tIZTBkSQB/e4anKrAOG7c17SJi1J3U?=
 =?us-ascii?Q?EOemk40M0NIEr+nCwDo3AiHcLagqQp1E/gqR2eBI6T6DGd+l6FIFeORpKbS6?=
 =?us-ascii?Q?S1Qdl4Ah1X/7hwV+4Rw/BYjipkGiyCNQ43OuRN39x+UT+fx33zAUubwHPZZ+?=
 =?us-ascii?Q?hWgUkeQnVwHqYVf7hfHx+uFTPwidY1UsLT2rj4U9MwXOps0//frXiRwNVp5Q?=
 =?us-ascii?Q?BZVxAVczl6b9XLTRn4vtkaYD95+ApTfIKcVxGEGzCMdvXm7KNCFCPzdUcz1n?=
 =?us-ascii?Q?KI/glS+QskXTCIARs6zRuSbRFWRGg2dpABBPytlMWf+K8w9ocCLvxHwgH879?=
 =?us-ascii?Q?J8C8mlDlSryAXPJZQBmrEAvltTy4In2+KOKsYJR1fUpVWgN7OE5VNb4Bl2d+?=
 =?us-ascii?Q?3S7HTVst+h8XKt1v4JzFWTi/RjQXkZOR5vQG0MiC+7JTkZdcUby19QngRq/T?=
 =?us-ascii?Q?fW7dEvVPSPKPwAtyF+INrXWimjBBQMfADMVFlS9uo/8/cA+QyGl5SDgwupYO?=
 =?us-ascii?Q?1sFeW0mjAIPQlW6545DU/G/DqRM5XhCVztWw7ChFE3sdb9S2juvGyMILviS0?=
 =?us-ascii?Q?/nzQ8mjyyrx/RazAYeavxQBslD7/8iEbGLUWLy7PfLI4Ns3Px1SRnriut+6h?=
 =?us-ascii?Q?KO/feRhwI6s7g1g6SsGkOUksk/Lz1x2qSDrQfcm764dNlGra4xtcJ7EnCvxn?=
 =?us-ascii?Q?qEbrO/whrumxX63WVNcSJMJm0xOJsniB+84ySjo5gZCTnQA73fMetGW0x+Jn?=
 =?us-ascii?Q?7m2oUI8tbvWvwXOpZMr/HVaVO4Nv7eb021CBj97fW4LW3RDT2rnjg7qjXoPm?=
 =?us-ascii?Q?fHdnfIC2iXJIDmcX37S+CXpggwEFnflXEC/1IjH0TSv8AEuJYYLiurRs1VOa?=
 =?us-ascii?Q?flxP1ztPKu1fIYxzVBKj6jxT04Un7rYJgyorHVj3Wj9wBeAGygYYFMSIIdGQ?=
 =?us-ascii?Q?gCHRWMJeEySiYW/dRbVnpkA3/R2HTJpkLeAKHsG/zUsD5FT/EIsLbnrRB7PT?=
 =?us-ascii?Q?6DfXoBVFqyr7SmdsnhIzF+MaAdbemSK0TR6qXZfLrs8u4T9Z+mM3CMtEWnsN?=
 =?us-ascii?Q?h6XmHl/a1uNn71B3FBwgfHjQAqEB0FHkl6HvNuHOmWlFSbOAWB9FjNPdeDQW?=
 =?us-ascii?Q?Ym53UH8ppCWnqD+HQszgNu8jySbMtZo6uCfvf/BbXEzRxWAi7Guhjy0+/alE?=
 =?us-ascii?Q?ETEXZiGaRk6CbsLbkF2aqvq7HX2FRP3yzwtfMchwLTz2EJuMSNqXIC+u6CXd?=
 =?us-ascii?Q?YhuSqgF7PmdPPOCjr2mBRd1H51H3pw80OXJGXMug1+MOmkc+X/ktbUFPcIKM?=
 =?us-ascii?Q?po8qjmZMjpwV4Os8pAUFkrvYOf2jhkamzyYhDErU2hTFrU6Uvx1LhXKjAOCN?=
 =?us-ascii?Q?rAKjukLuF1pwUmQuszIGSNxP95xAjAHJ+1UC4QmP//HUrWrxtSdutVK+pR3J?=
 =?us-ascii?Q?sgMw5yMtzJhPyrLEvfviRrxjy4p0ukH8+pPprlX5IJT3YbzyK6XEa8tcy6Ng?=
 =?us-ascii?Q?ag=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 552a917e-c14d-4989-5e2f-08dd07ad5678
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 08:45:22.8699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTW1ZRGb5HtZFUiPHGaDDIzapjzVpFCG2GisZiOiESUqQmNj+tlYc8nRgGv0SLi3FLCGIJfgNZHVFhilkY43YltZ6SDGqaAKzrpWqKoU11U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4784
X-Proofpoint-ORIG-GUID: KW0CBUlw5L17YcXHprH9XskGXj2yp0v6
X-Proofpoint-GUID: KW0CBUlw5L17YcXHprH9XskGXj2yp0v6
X-Authority-Analysis: v=2.4 cv=Sb6ldeRu c=1 sm=1 tr=0 ts=673afeb2 cx=c_pps a=sGbpJkUcFVeWJOR+0qTsNQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8 a=t7CeM3EgAAAA:8 a=tDXtxTbg40t39s9UlDQA:9 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411180072

From: Zhongqiu Han <quic_zhonhan@quicinc.com>

[ Upstream commit 02f6b0e1ec7e0e7d059dddc893645816552039da ]

The use-after-free issue occurs as follows: when the GPIO chip device file
is being closed by invoking gpio_chrdev_release(), watched_lines is freed
by bitmap_free(), but the unregistration of lineinfo_changed_nb notifier
chain failed due to waiting write rwsem. Additionally, one of the GPIO
chip's lines is also in the release process and holds the notifier chain's
read rwsem. Consequently, a race condition leads to the use-after-free of
watched_lines.

Here is the typical stack when issue happened:

[free]
gpio_chrdev_release()
  --> bitmap_free(cdev->watched_lines)                  <-- freed
  --> blocking_notifier_chain_unregister()
    --> down_write(&nh->rwsem)                          <-- waiting rwsem
          --> __down_write_common()
            --> rwsem_down_write_slowpath()
                  --> schedule_preempt_disabled()
                    --> schedule()

[use]
st54spi_gpio_dev_release()
  --> gpio_free()
    --> gpiod_free()
      --> gpiod_free_commit()
        --> gpiod_line_state_notify()
          --> blocking_notifier_call_chain()
            --> down_read(&nh->rwsem);                  <-- held rwsem
            --> notifier_call_chain()
              --> lineinfo_changed_notify()
                --> test_bit(xxxx, cdev->watched_lines) <-- use after free

The side effect of the use-after-free issue is that a GPIO line event is
being generated for userspace where it shouldn't. However, since the chrdev
is being closed, userspace won't have the chance to read that event anyway.

To fix the issue, call the bitmap_free() function after the unregistration
of lineinfo_changed_nb notifier chain.

Fixes: 51c1064e82e7 ("gpiolib: add new ioctl() for monitoring changes in line info")
Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
Link: https://lore.kernel.org/r/20240505141156.2944912-1-quic_zhonhan@quicinc.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 drivers/gpio/gpiolib-cdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 55f640ef3fee..897d20996a8c 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2860,9 +2860,9 @@ static int gpio_chrdev_release(struct inode *inode, struct file *file)
 	struct gpio_chardev_data *cdev = file->private_data;
 	struct gpio_device *gdev = cdev->gdev;
 
-	bitmap_free(cdev->watched_lines);
 	blocking_notifier_chain_unregister(&gdev->notifier,
 					   &cdev->lineinfo_changed_nb);
+	bitmap_free(cdev->watched_lines);
 	put_device(&gdev->dev);
 	kfree(cdev);
 
-- 
2.43.0


