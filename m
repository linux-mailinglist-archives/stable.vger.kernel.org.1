Return-Path: <stable+bounces-240066-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sN3JB/Ao52kf4wEAu9opvQ
	(envelope-from <stable+bounces-240066-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:36:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FF9437AB2
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 940933015D21
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 07:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682A43876C7;
	Tue, 21 Apr 2026 07:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="g2dhcZma"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D1F384249;
	Tue, 21 Apr 2026 07:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756932; cv=fail; b=B/UhwNiKRHl92O+uu1DS54iZGPbnUBQWTbtm91OquDAEJcU3Nn8uHgVnw01Z4u+ZVTnNP5jIxMSdcBRzGnnlKVxW1u0X7DCG0YhCso7VPOmtKrWV8fk1y9WrpyS7XQ9gZ91hnNUdtB7K58YABC188CTLXYzhSVEZzuvxNGUWQwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756932; c=relaxed/simple;
	bh=14j5MkEEdGi9xr4aONDZBk/UC0J5S/t3Htu71+/CY6g=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AkRbQJe8GCJMXIYlhF6TBCxsEtj27vzak3vlmikC/yVyP+s7Ut0xXFIFRqiguSrHSP99Ko8eiO79bnsrMFD48LY9Lkbq1TniJMc9yvKxJiss1ievgAy3ENHLImAYeQIaXwAGDg6R3cExIkWf57B7ZyRDmWfkMu5cs8s0lXBeDEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=g2dhcZma; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63L4GbHU308180;
	Tue, 21 Apr 2026 07:34:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=/N6uNJdDc
	t1RMfUecUb4kMPLzRQl+NGfzHUlAxxjlYw=; b=g2dhcZmavfxz2NDHR2OSsOeje
	jGobRR00H5XL+Dvq6i6DKEX130nWl55vd1J9v4wXb49W/QHb2RZ50GxWxp8CTmUi
	ce3tmC037MteaYCJu3WyN05uGx/PO6KZxkOKrrV7qK8ECmBHFihg8BZjUHdMaueS
	7FK0JxcQMXZpp3FgWCfajk0qqPKy/AvofxQDirQ2eiVw5VbF82I06Sdfw8NhaIOM
	HKL7hfovcibkHOAY+cy/pWn44JyHcnyoqU/S86TEouNTmV5zCG2Zn4mlBCpRLzsk
	CxHu4e6Ebu7VMQlSa5TqndumoU0sNDyUTTC40vRJHuWt09NGnxk/8wTcNVyZQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011046.outbound.protection.outlook.com [52.101.52.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dky5yb2vv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 07:34:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9i9znPIyF3Z6Wjb5tBwt/28n9r4OikXI95aHKXrUJ5zKpWLKYnmCF+Eod/pW5OFSm0yxdSTVdq2DHjbCLfWFkSkDGzBto6TWkoaaIVDnVj8gjVeJOx5/fAxfBop2HB95AeEYv9YV9ps7nKsQ7X1da0zSbMdnPvV9nDMxiazadFin+qrUtgU/4vL3LdgYoEJ6hYGjxMCnIZs9mBGMkaajv3P6BuD8S5epy5jCjv7KGOXrwwMl/F503vy/YLeCwIiY4kX6DB+jptW7yjYVuFAIfapSFvquKEZm50TNLMWp1vGBtLdk/r4n6GECOQMTvwKh/n6hy02TLiibyLSWuHzkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/N6uNJdDct1RMfUecUb4kMPLzRQl+NGfzHUlAxxjlYw=;
 b=EtZy0n7Y/Yc5RNdZhHYdzA0hajaGndq2Kuru2aAiql6Yd9ZIQ0MpfGBXVlUVk8T+hYDOOcqOqf0/nrG688HqKhtZQ1CMMlSZGOIrQi7hinRWPhP7KZHtJ3r6jtv7HJ4FKopcQceHs8PU7ljoPj1XefVaV4cB+MSxD1jyhZvf+PI8eFvzdRAxGBO21uzPa2Ni/CZKHsQlbAVpgwD1TdWw6Lm7blSBruWw5wPOd+7ImE72eMxIE1OviLS3kdUJfdzaOtVG7BWcp/P0Sh+Q12Qb37s8htRomtToItFh0JkB8gdsoXG0MrlpyoXS8e50WXxNCJZSamiBnI4E8gpTIoSX0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by SA1PR11MB6782.namprd11.prod.outlook.com (2603:10b6:806:25e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 07:34:43 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 07:34:43 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: helgaas@kernel.org, sebott@linux.ibm.com, schnelle@linux.ibm.com,
        bblock@linux.ibm.com, linux@roeck-us.net, lukas@wunner.de,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-xe@lists.freedesktop.org, matthew.brost@intel.com,
        michal.wajdeczko@intel.com, piotr.piorkowski@intel.com,
        dtatulea@nvidia.com, mani@kernel.org, kbusch@kernel.org,
        lkml@mageta.org, alifm@linux.ibm.com, julianr@linux.ibm.com,
        ionut_n2001@yahoo.com, sunlightlinux@gmail.com
Subject: [PATCH v13 0/2] PCI/IOV: Fix SR-IOV locking races and AB-BA deadlock
Date: Tue, 21 Apr 2026 10:34:19 +0300
Message-ID: <cover.1776756380.git.ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0202CA0012.eurprd02.prod.outlook.com
 (2603:10a6:803:14::25) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|SA1PR11MB6782:EE_
X-MS-Office365-Filtering-Correlation-Id: fa57b2e2-c3b1-43d4-86e0-08de9f78742e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|52116014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	jif2mTkbdnXQVbNUo4N2nkVWGMKFzCRXNX3fKFiEdIK3Gp3QYuMxk12omqq+aoab0r7VpZya+aObxPi/WeYCJGyIqhtUtQUV6cwCXI8uOcChHndzCPOjqPvlzSduhVtG8oFqK55ECFi+6v9ArNq9qm/RadLqSZ3foFnweg1xlOi1cL4RVCOH2yVLCOQa8Att4tddqsjRiTYL4xw2a5IILxaCeFi2LFQlwkNhCYs+uqvouGSVZESzvq1isuWnK0MiE4+pHNnW8PTLowdEkLp4KxotgY4pDTtj+2RIGQ4gtYgpyxHAp7n01pYaWxXjnxx2hsiqI7TGTh8+jcOx8h/mhDn9LzSOC5G4XX3sXHCiZ7vqMN5mH/ChNie75CYGH8PmttUe+6iqOut1UDrIY0CXIZFTatc+LyuZwBj3/Szs4WS6XhGphLoNhfZnZUNW3KefFxAOb/psBB+m/DG3EwmckOzasrnVfKRAQs4nQxa4VCQ3+0DFEcFz84jfN/7VtGdMCxyoag+e2ltrnvFIca+VZd0wqglQYW3OABUGCeSP0k7qMLbPUfLgwFvbz7zvaszFiC4Ya3hUisc6t4mQhbbknOn8X+tJSFyAwpB051q8IL7mRGfbYaVsjjh+TbDNZdMRkyKY1MPCiCdDrw9uKp3J5Mw904/6J5iYkdoU+OT/7SLULoBRk+8ZMjGg2irM1VI+SCsJKqpJz+4RCOQ/vQ2PxcNwEQPX1SEJnWCyDSHeawJIB8kEuef4NHuKpwOv4OOe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(52116014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gD3Zw5Y+eNbustfAcuhVSdc1/CLzjCPEI0SnFlwJga2nOKGchoGX/3ot/UCE?=
 =?us-ascii?Q?sTRMLQMkkTdK3HonctTQRZlhEb/tXYLWGdiX8cJGf1I37JdqOwFug7Wwf8NE?=
 =?us-ascii?Q?R+JLJLD6Qigy9Sxn+Nl5Hp2SmJz+7cmXhBgzi1cfN7ersS55FU+oqSchwTJK?=
 =?us-ascii?Q?QFTx629GScPtTgBR4yRnHLk02BuDZCyqq4maxWrJbDUxynK7H1gHypknVCqn?=
 =?us-ascii?Q?r5VZMy6Pjpb6TkCDqV+0Wt1iygAwvKGBbZT+RfUGP6UTwsMHypnlK2ffzIKO?=
 =?us-ascii?Q?ktD9+Slg5fLirUUzPW+s71ZigCZ0xNkUWDUVOiK0UlKiU7oeWkgTJ/UgOfFT?=
 =?us-ascii?Q?fLS94mO5lOmn2UBVkHWpyqzu0OgvlIJk2WaIAW0rhdq8//cg1GoplWkYeXPh?=
 =?us-ascii?Q?uboCvSbIJLs2r3BhGYYj+DDerW8RsW8s4JPMxxOgen7twFSHi6DCQEGYgKyz?=
 =?us-ascii?Q?Mc0s57bd4A3gA14PR3iyp6SRxhhLUFs9cFbtdG92r6a8bf/WqcdnErbWwbe8?=
 =?us-ascii?Q?dJ9/9+Nv9vD9ZqotHk2ilvOntB64jQZYznqNhQKAwej92in+UC9NT5R8EbQu?=
 =?us-ascii?Q?k+yPxeeT3iK8SMs5spEEVAHuE1zi5BsyoiVu4HfaCaaRGZjG4ls0c/UFiUD8?=
 =?us-ascii?Q?yinES2dNKh8n+Mz3cS6VEBaCtXtD8hye+KfnQue6dlhRQvGEhYQa0biX3Vl3?=
 =?us-ascii?Q?ZI0MCUIoEwc86X7AUqu8biFsa340JBs5ukMBmFJAWMkbvURtssfkw6yRej7I?=
 =?us-ascii?Q?SL8m7owdZ9ILBjChQ5lHfV5F9daRSHXN34LD7dcjtErGsKUjFiMwOBm8QMdj?=
 =?us-ascii?Q?j/AkT9Ok0XVSRf0UAcGEeb0AwV6UMmlGepWYZgRFh4m1stZ+SjhaYrs04pUC?=
 =?us-ascii?Q?yrErM8SVEOCqrLXZSojvYNF6auKn7RbFXNnAnJtAvO1bdEba6pFukiF1Xftu?=
 =?us-ascii?Q?Atjk9rUufZ/oXsQ/cTvScqlJ6rqL6p21eGbRsJMgNCCLVGxx3rxuI8gTmxIe?=
 =?us-ascii?Q?HmCerxf8nyaNYYtxb285/PMDTlTomGDxqWwfdF66LNwJ18J3JzXRTn4dqmZb?=
 =?us-ascii?Q?Umvj+qrGc+rg3DZGyTQtuJpE98R9DLP6yXYTSYiJO4SuWSo3O0gj9WPRG0gy?=
 =?us-ascii?Q?WiaUNGI8Yui5vLmIV1zG6PY8ElM3nJW7xq3Le2MBg9ClnWrmPig9xOTIw9V3?=
 =?us-ascii?Q?qmisA50/j9vJ10uC5PEbL4mRKwwySSXDR6SglTYXfEKu61Mzh9t4gXzm0wMa?=
 =?us-ascii?Q?/ZQXPnAUOjMBCmxUnWb0kpJdYd9H4GVsXf/lznUf0FjnYbvh1HeV9liRE7qg?=
 =?us-ascii?Q?gG6ZAsm1CuY99yTMCIxCW8H++Qhu9elyWHsvsTpG/ZXSX/t0f7IAaUDLIvDo?=
 =?us-ascii?Q?q3CROGg+lfY5NM95kQ3WJ3SVOxDwPzs1uGDu/E4VdE/9js5JNw+h9Cm4MQ/g?=
 =?us-ascii?Q?nNBd4WLoQXgvXYuzKScS33EUIQmiwZJum6RK2OyNfLMn1/5TOgDHfaIGFvJg?=
 =?us-ascii?Q?qkvyA92cC92R8I/vCGlIqoVdWiSSB4WhODtlaVFSRma2DkHkruvX3+KbKrya?=
 =?us-ascii?Q?B6nY0GK1vqTMO/sP/zyRNITHUtSl5q2S4XhlckaozBAg58LHOdKiiUoyT5SE?=
 =?us-ascii?Q?Qho+ZOudg4HaQfwzAhPb9veAlYZdBZuqs1Wim2ivilOrXOawRTXCr9yZSSjy?=
 =?us-ascii?Q?JEYECE9XqPFYpShGHSjGpWVt7zuGl51S7g6cYXMnlNIf93GC1AfwUTp108Bh?=
 =?us-ascii?Q?WxDlDuFvEEMPX9L1Y2h/wYRLIUb95RGTXVYjvOxP/d5UxyX59phwUBsIUWTG?=
X-MS-Exchange-AntiSpam-MessageData-1: k87g58B+yK8F7WDGQQz6f97dFj85/AHRjlE=
X-Exchange-RoutingPolicyChecked:
	DIIqrqls/c6H2CWZ+1uYjL1zorD2KxCG6842/+FIanpvMEbz1C1arENqP82hGTL5ICP5KEXC5LyzlasclzkUqCs9Etyh/pGBVkNEadG2oXWM97UkstdJANP9fZoVIntZISG1aSE1lglAvpxMXxpsOUXFOOs14efLFiA47dfgP/8LsRq4DbNe0ngpxsXk61OSdUl7+HMvigxSzOD18vhcAmTm9nGkw1QVXY2nazPqjrO1RwFIm0wFGLDv372U050FQc7Zpyoxqe0s314EYcxyGEqydud31j5kpJ12B0DrN1YdaiGWCJEOC0HuXzKn4I0Ly0j/I87g1dfl1tIjXLdUVg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa57b2e2-c3b1-43d4-86e0-08de9f78742e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 07:34:42.9025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: knZl6zr4FFAQD/yFS2hb0DS5OMAYjGBCld1bjEKgLYD7AYoDhdGRHN1LDzfPmZ8CrjKofjn781rR7eoY14Le8PPKuI36H630LrU9USyoEaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6782
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDA3MiBTYWx0ZWRfX0sUKTkqufCQP
 MOeHziRBbPxKy360PvY0BFLwVhcHb1S8RdyNzAS9I6+egP4odkKYUqc8TXkt+rZTrI9uhCbhPK1
 FK8NSfa49if8bovq+MbrnHQWTCK4CR3lg81YmAoIzwn+P8zcdz17isdV88yBoFoKGuHR3XUjyoY
 crUir9gP2dn/GPF8SNp1mplIPD2J7dr7IwcOOxTsz2zHYmMSnEG7zZOwfck6Mf1I4tBrOYl+Ty1
 W8+QAPL+Jry48dBY2QTd58eeQScPDQYgZ1Fj+m8wzjfJhht3tCvPQr3MLHSPnADZdaADkqwMfkK
 S6wjfvyFjO+7F59NzmSSZUmYdse38UnU9+JHrEYRQBaMxhM4HBHHknF6azXa4QoO1NC+0ECHkjc
 0qr5CFlTZt7TUNDpnwqgX2OAymJxCLVVNxzAitilW0QCagJij2F/HYGCn/46vAFXLVfs5H6AOwn
 /7fCP2qz8VAfz7qA8eQ==
X-Proofpoint-GUID: 8PeNgKDK82ffCMuETaqnc3-7-sCG5vdF
X-Proofpoint-ORIG-GUID: 8PeNgKDK82ffCMuETaqnc3-7-sCG5vdF
X-Authority-Analysis: v=2.4 cv=Bp+tB4X5 c=1 sm=1 tr=0 ts=69e72898 cx=c_pps
 a=bbY6CEmM+CWjO+hqT4zsvA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=t7CeM3EgAAAA:8 a=3fcuMNHXLARaAz_BQGYA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_01,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 phishscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210072
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240066-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,roeck-us.net,wunner.de,vger.kernel.org,lists.freedesktop.org,intel.com,nvidia.com,mageta.org,yahoo.com,gmail.com];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[22];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:email,windriver.com:dkim,windriver.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B3FF9437AB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ionut Nechita <ionut.nechita@windriver.com>

Hi Bjorn,

This is v13 of the fix for the SR-IOV race between driver .remove()
and concurrent hotplug events.

Changes since v12 (Apr 21):
  - Patch 1/2: replace mutex_get_owner() with explicit owner tracking
    (struct task_struct * + depth counter).  mutex_get_owner() is not
    exported outside the scheduler core and caused link failures in
    some build configurations:

      ld: vmlinux.o: in function `pci_lock_rescan_remove':
      drivers/pci/probe.c: undefined reference to `mutex_get_owner'

    The new implementation records the owner on first acquisition and
    clears it on final release, with a WARN_ON() catching mismatched
    unlock calls.  Semantics are unchanged.
  - Patch 1/2: dropped Reviewed-by/Tested-by since the locking
    primitive changed; please re-review.
  - Patch 2/2: unchanged from v12 (keeps R-b from Niklas Schnelle and
    R-b/T-b from Benjamin Block).

Changes since v11 (Mar 26):
  - Patch 2/2 picked up R-b Niklas Schnelle and R-b/T-b Benjamin Block
  - Rebased on linux-next (next-20260420)

Changes since v10 (Mar 18):
  - Patch 2/2: added kill_device() before device_release_driver() to
    prevent a new driver from binding between unbind and removal,
    closing the TOCTOU race window identified by Benjamin Block
  - Patch 1/2 unchanged from v10

Changes since v9 (Mar 10):
  - NEW patch 2/2: fix AB-BA deadlock in remove_store() by calling
    device_release_driver() before pci_stop_and_remove_bus_device_locked(),
    as suggested by Benjamin Block (addresses Guenter Roeck's report)
  - Patch 1/2 unchanged from v9

Changes since v8 (Mar 9):
  - Added Reviewed-by from Niklas Schnelle (IBM) and Tested-by (s390)
  - Added Fixes tags for the three related commits
  - Removed rescan/remove locking from sriov_numvfs_store() since
    locking is now handled in sriov_add_vfs() and sriov_del_vfs()
  - Rebased on linux-next (20260309)

The AB-BA deadlock:

  CPU0 (remove_store)               CPU1 (unbind_store)
  --------------------              --------------------
  pci_lock_rescan_remove()
                                    device_lock()
                                    driver .remove()
                                      sriov_del_vfs()
                                        pci_lock_rescan_remove()  <-- WAITS
  pci_stop_bus_device()
    device_release_driver()
      device_lock()                                               <-- WAITS

Patch 2/2 fixes this by:
  1. Marking the device as dead via kill_device() so no new driver
     can bind (prevents TOCTOU race between unbind and removal)
  2. Calling device_release_driver() before
     pci_stop_and_remove_bus_device_locked(), so both paths take
     locks in the same order: device_lock first, then
     pci_rescan_remove_lock

Note: the concurrent unbind_store + hotplug-event case (where the
hotplug handler takes pci_rescan_remove_lock before device_lock)
remains a known limitation.  This is a pre-existing issue that
Benjamin Block is addressing separately in:
  https://lore.kernel.org/linux-pci/354b9e4a54ced67f3c89df198041df19434fe4c8.1773235561.git.bblock@linux.ibm.com/

This race has been independently observed by multiple organizations:
  - IBM (s390 platform-generated hot-unplug events racing with
    sriov_del_vfs during PF driver unload)
  - NVIDIA (tested by Dragos Tatulea in earlier versions)
  - Intel (xe driver hitting lockdep warnings and deadlocks when
    calling pci_disable_sriov from .remove)
  - Wind River (original reporter and patch author)

Test environment:
  - Tested on s390 by Benjamin Block and Niklas Schnelle (IBM)
  - Tested on x86_64 with Intel and NVIDIA SR-IOV devices (earlier
    versions)

Based on linux-next (next-20260420).

Link: https://lore.kernel.org/linux-pci/20260214193235.262219-3-ionut.nechita@windriver.com/ [v1]
Link: https://lore.kernel.org/linux-pci/20260219212648.82606-1-ionut.nechita@windriver.com/ [v2]
Link: https://lore.kernel.org/lkml/20260225202434.18737-1-ionut.nechita@windriver.com/ [v3]
Link: https://lore.kernel.org/linux-pci/20260228120138.51197-2-ionut.nechita@windriver.com/ [v4]
Link: https://lore.kernel.org/linux-pci/20260303080903.28693-1-ionut.nechita@windriver.com/ [v5]
Link: https://lore.kernel.org/linux-pci/20260306082108.17322-1-ionut.nechita@windriver.com/ [v6]
Link: https://lore.kernel.org/linux-pci/20260308135352.80346-1-ionut.nechita@windriver.com/ [v7]
Link: https://lore.kernel.org/linux-pci/20260309194920.16459-1-ionut.nechita@windriver.com/ [v8]
Link: https://lore.kernel.org/linux-pci/20260310074303.17480-1-ionut.nechita@windriver.com/ [v9]
Link: https://lore.kernel.org/linux-pci/20260318210316.61975-1-ionut.nechita@windriver.com/ [v10]
Link: https://lore.kernel.org/linux-pci/20260326083534.23602-1-ionut.nechita@windriver.com/ [v11]
Link: https://lore.kernel.org/linux-pci/cover.1776755661.git.ionut.nechita@windriver.com/ [v12]

Ionut Nechita (Wind River) (2):
  PCI/IOV: Make pci_lock_rescan_remove() reentrant and protect
    sriov_add_vfs/sriov_del_vfs
  PCI: Fix AB-BA deadlock between device_lock and pci_rescan_remove_lock
    in remove_store

 drivers/pci/iov.c       |  9 +++++----
 drivers/pci/pci-sysfs.c | 30 +++++++++++++++++++++++++++++-
 drivers/pci/probe.c     | 18 ++++++++++++++++--
 3 files changed, 50 insertions(+), 7 deletions(-)

-- 
2.53.0


