Return-Path: <stable+bounces-240057-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGJwDeIn52kf4wEAu9opvQ
	(envelope-from <stable+bounces-240057-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:31:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E384379D1
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6FC4A304868C
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 07:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2749390CB3;
	Tue, 21 Apr 2026 07:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="RgLfgfxO"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B98D3876AF;
	Tue, 21 Apr 2026 07:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756061; cv=fail; b=N8jk2WWVKcFZb17Po9Eam7fFgYJp71wWY+i2gBaxB8dXkcnZ3O/tHRgixjf6GrVf0WW83KCO1286FmgKIx2zS4F9aauie/Cj9zoGWobSzwIDSGCoe2ukzEJceM9xyAE3ipd7tbjyy1uAJtpvUv1/VMvvz25bEB+qBeI3dy71bVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756061; c=relaxed/simple;
	bh=UzHaIcUE3PflFfuBtmUfuNIH5aozBT1kA8m0yJjFFNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F0Ube+q32au2Awcl/e5nwt8Y1/E0V2rxoVzEgLYzXhTg7K8LoejyW7dWA24pYLmirOjyqVSx6XlmnenjHOTxKKa6zga56mRK9fGNngNnF1Bxpwf9PCut2BYJ7rM9A6E0astulU6ZO1ku0j0S4D9eI5OFPTfAP5mFPNEtDI/UQQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=RgLfgfxO; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63L4loJ5830856;
	Tue, 21 Apr 2026 00:20:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=MEbKbes+QfIr46SRFYWl/XvGFmtln2tEt8AomejqZFc=; b=
	RgLfgfxOFHAF/Ta6CPojLFfrRkJWCHeMjrWpb/G7CfLna9Ru0vqlbBq0oudmNTBn
	90QDAnjaijU1lTsCIZGPwLiTmD5Ppgeur8FSrXOx8gLla8riospy/Ek+0s6IwDUf
	zEUiZsVDVbJ72BFy3cpLt3XpYOLxYB5Oth+V9iW8wG4wscSHLyRtvg/r4gw/rWWC
	9+OHvCO40ANQqlgYAnLpCN3qPKfONune7pB6OzC42xqpBfxYelcOf7+lSa/9xNtE
	M02FLtg8/g2CMMWI/ePRUcNh644hOeRftO1i/0ss2/wUaftKvTR61QzY/e6gMipg
	yoWZswsRP4QNJGmDVira/Q==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010059.outbound.protection.outlook.com [52.101.56.59])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dm9fctsc2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 00:20:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWaAb/TFvSu72urDhtTW8QXbgYPrqYShDw39dHvX8TNo+Ejd1cGNgAsTp1Pebs/1to3Z0wZwZzmHma5hNrC19QobUGhdN0OJeNKYRR0+MwOTQqHlIAC83yZxdjqvSu2okq03roaLfd4XhiblfpfDzYF8zxOhBdlTvd8FPlwFnOva1OhFEDjryH0REakHA+Z4HLEea6nZGcPKUC8SMw6HcLCEmd1c0kKI/L8JXEqET79hxONNeclfR4t1W+XLdpSvWf2dw9/YmZQnvL1/O5PE/U5njvJGAOx23EE9EKKLtO+TeOXg92p76ETUHg+tFA9tlCYsy2I8S+OobOIN4ti0XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEbKbes+QfIr46SRFYWl/XvGFmtln2tEt8AomejqZFc=;
 b=YiC7dkRofpMNT/2xSaDPr9cjOc4m6HFOjQ6TSFES0R7rtEY1nMxX8rEHPdZTKdSMRwnfGfi+gJk7wAoiZ09tY6Ub/ESaL2byr5WdzTRwMQLsmXkyHdeXgZh7pJKDvmjYLwp0k/B1Qx21u6S86Ftb+/nCHcbov4ncqx/YMR6/4bfhFZoLTIbG2+ROUYQJ0r1r3dGvMBUc0uaP+ItAigv3JkDUWpj2NJV6+L35vAueal33Pmeu77/HscLD2VZUoeEMs1PuvvJ4Gt8G1kDaeMkG52nWvajtG+d8rxNPj4DSpqXtj/VQoMSS3Kw+egfSn2SluCHZGtUdY3sqk9R7Q7ODEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by MN2PR11MB4695.namprd11.prod.outlook.com (2603:10b6:208:260::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 07:20:12 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 07:20:12 +0000
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
Subject: [PATCH v12 1/2] PCI/IOV: Make pci_lock_rescan_remove() reentrant and protect sriov_add_vfs/sriov_del_vfs
Date: Tue, 21 Apr 2026 10:19:31 +0300
Message-ID: <dd7e59d18ac031af42a65dc0207dc6d9f5780e09.1776755661.git.ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1776755661.git.ionut.nechita@windriver.com>
References: <cover.1776755661.git.ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIXP296CA0001.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a9::16) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|MN2PR11MB4695:EE_
X-MS-Office365-Filtering-Correlation-Id: 2578b0dd-92bd-4baa-2c4b-08de9f766d70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|10070799003|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HLOxPJevo/QRXAkOBj9RKj9+xGH0rlH5GJln3wRA6SZWA3DleLtDZ3hR+6I7+0q+dRHaVWr6UicYzb61R9oqY0RQzn6kPUuXtOteOAMQJ6dTzCj8UHeytE7Ysf2FQ5hZCK1wOxSzGk33N6Umiv6bQ2OmVDjH5rZO9Ks3ctddER0KEtt/+efiJrGHllMo9/BlvkJNbwIWETK17/Z0/gNUhfYqhY1Zs1xRysPqlb02LIaGSlnI4b42wqeOyO7fwKNDXL16NKdPdBzlz8DiSQRr4hMgBHrvabaCmou0SLv7YuR5sIuPZj2BQsl0GK3ukaotdxwfLsUIphtQFLM9nZQcEvP46/JJ/qDFwUNi1PGcA7GtKMXzJPVQMGvA92FjNDsPe6OaRY5hZDrGR3k4YfE7OU0ykoKg0/HrIZ1GFXbYkwcE+vOxcd9U+RSTgB1oko90CX9AjIRLvaIr8fchujXYrRWP/6wbpVuMPXkgvPntzz5bc2WwZR68fu81DfzXV9vr52ypYcCb9I9KKxGK+NYEUnaXr1icubHMSFRNkqwEw9HE3m4oMztDxk9N9a2gRnrXxcW6iZu7m8Uyu3NoCPDDOwsmP4J/7BqdXB+X6Pjfl7vltfos+pX+1AtEDN+BsdGqwW/EluOUldFmMW54TSYCw1lJ2qyDvgKxPgj6gU1jy6tIXArF5HVU0DGj/dOd1ncyG/o8iSN3Ddws+VSaucMiLB0X2hG0TSC3dfla3twmlok=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(10070799003)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oZqv5ouaMiWMFd6Zisq7ZTym7sorB7RXiOPy5rtO3TTo6a5duMm34/CnUDKg?=
 =?us-ascii?Q?24mCOt9n6cWJw7ae+OJToN1R9b0KamPqM5RTmpsyLoDCO2toYJ12df6kbFdQ?=
 =?us-ascii?Q?LK7GJEwwZ7f+dfYeqJIyeTXU9vLeUkJe2w4mF1g+reGUClIrL+Yptz1fsGAR?=
 =?us-ascii?Q?e2/3a1M7jvXwA2rGW5/M2orQvod+wS0imBc16UU49vaBazPQv0qYxqHlWpoG?=
 =?us-ascii?Q?ZH955GkKAd7CLCAzUTc2c4d+lhubKPxf8XKc1uOevRdjbkGAAQRzO93Vtly2?=
 =?us-ascii?Q?CYGGdx/8Ru7DOgZw90m8JOuul/LNmhh0HuMXbmrHe4bpwjjjUgRjoRPSY4Ov?=
 =?us-ascii?Q?nB1BYNlVpGB3l+JQSVaGQcEqenWIKPosfh3TdHLXSMFwfhD8/ZL6KIWrJGlZ?=
 =?us-ascii?Q?2f+giSHxD4yqXGRnK1VShIaIBZpI97aiZ9QxTPAJ5cdERlvpxy29P9t6buOr?=
 =?us-ascii?Q?AXov7xZuQ34ESk0zNoZYD90JIqHASnorkLAvBPW0lVQaW6EP4KyGx5fXf/a2?=
 =?us-ascii?Q?+8jT2bJTGox3mD+dhYJC44tQUQVxWgbhaCO0k7ScBx5jr5a1xSUmUMZ0adca?=
 =?us-ascii?Q?UDR7D0Aa1A7VcT3n/WEY1Yzl0WitihUtcgwWwi3zoXcK7wYFrPDRpY4OpxwX?=
 =?us-ascii?Q?aUuhxhFLIcbTZ+Tt1/46b1H0PkAQK87YrQH+AcM4+TObxV1gfnRFQ2xlQM09?=
 =?us-ascii?Q?WTbnuMbeTW5ENcgQ62/aV0beZ7NI38vLEPgiyGd7OUaZPhIcOJB0ID2VE84P?=
 =?us-ascii?Q?xfdz6b8NlhUDr21EVpr00SkqFj/t4/hdxPucU0k9hfJKjVhc3tIXPPBQmAJQ?=
 =?us-ascii?Q?zsyX6dRn0r6QN3FXudILV3ps2a6qdDsn9WjXttOyffBbhACdt+xH5AogbqUI?=
 =?us-ascii?Q?wNAcuiUu3LVdFNkl59OKdDdM0WvAWOhv9OPbcBFUwyifKBVCbLrTxd8CX7jx?=
 =?us-ascii?Q?17I+BSIyPxfcgoJlaPpAf+sq+YBzvgub9sg6+fr4ioVu2KrxjSzjIbNNX3gv?=
 =?us-ascii?Q?LiM7kxLFkWQ/+HIdOCb/HE3lgeJSKHlVapZqqK/yc77whxckI9oYWyAdpi9h?=
 =?us-ascii?Q?QChMLEjixndLHonBf5DHNW4z38QqttOJeca55ztbbqBySFXWiFz6JS96u4BM?=
 =?us-ascii?Q?WgPNKXvdXatECt9JRLEYe9t6oDtkmMWB0cvbL/zcFkX2jrQnbDoveyinsqMG?=
 =?us-ascii?Q?8+qO6xbgx4OikP/GQ5QElTeMguDaBDPh49/YROFH4+w89O9iXUHZVoZQ9Sgt?=
 =?us-ascii?Q?SXqmTQQGuBmTsOBFj9U81DGzNNkDZ7eXgxafSBPAtOGv4J0M9QgirC9RZFRw?=
 =?us-ascii?Q?kStz9q7V/CbhNsK/aHiWxvLpIXuE8tgon6jEHxJwB4wiUgf9Zrpyf7CO6fia?=
 =?us-ascii?Q?hQVMbAWUpmPtJmYIStbirRCw1pS03RhhuIXl0s3+wnTHba0O61QcVUgc3hEX?=
 =?us-ascii?Q?eMfc2ZH5/VhKdCfJoLgaKwC+rEZbzg+nXQDJBnM4FUBfv0A1gN/UYjTrVGMX?=
 =?us-ascii?Q?gJ5stKf7AjtGX6M2JNi+tgzvjbVjrBb+QynvKzY2stFC36A2fBdQmtSya2Cy?=
 =?us-ascii?Q?sSL9aIzs7wwwWQOJJv1RZ5cQ6Ax/Rk1weUlzwBQWX2BQU8yYy/LRLykoR7YM?=
 =?us-ascii?Q?gFS9WGJQEC1oce1/3+ASTq4+hM6egV+E0/2XKLEM6oyPFDOpYWvjFc/iykW8?=
 =?us-ascii?Q?GYToA3kpGEsngB2mgrURhwQd6bJCJetK+1R3ucRxtukmqopWqC85akY4bvSZ?=
 =?us-ascii?Q?IJvZ4YmBsFRcLilt39fTkFT0Z7Rr3lF8qygHz/XWN00eNH9gRKhJgE1LM7Er?=
X-MS-Exchange-AntiSpam-MessageData-1: wJfrPBQHv38dtnnHRivu+4MFdsQhVIVcKYw=
X-Exchange-RoutingPolicyChecked:
	r+pBcInzIcaLn3WTrDfimRiRW8mfahRjnReR+vf8fKbzPLrZiolO9v95wQdoiXtmMnQpOLzfPrXV19mU2L4LMc82ZaZmC8DJu89QZ7AoT/alxzAHsltnNvVpJX7Dw7ZmlqaLO+1Pm9BCE79i7C2OkgUYTbCBbC0JJXSwC7wVhvYbG66QwwNxZCLzNnR5l7KiYoJzvDn5MiyFOI8pfLYdSYqHRuulvmS4KnKFbfr798NmX/fnjMEX7AoPNZhk6Gv3qrasbB6XGSh9Pi5wf1/+JfFn+nHDwDfg3vfWfliViKsJguH4gtt6A43LSkRIrhZKCO0RlZCMneiaU5ljlj+FuQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2578b0dd-92bd-4baa-2c4b-08de9f766d70
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 07:20:12.6715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ibhXX3ng4LizQxc+A3RmjUwOkI4klfSX/cWBixECOZFt6F4/ACqeO03Dv4E6PI1rnILYcPk+KApIOoOfYu8DGFLgsDSSiUJ6ur6ub1+79Do=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4695
X-Proofpoint-ORIG-GUID: lJbeOlWLzqKYpJCPrRdtMDYayVQvs8TQ
X-Proofpoint-GUID: lJbeOlWLzqKYpJCPrRdtMDYayVQvs8TQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDA3MCBTYWx0ZWRfX/jdj2wp1iDEN
 CqB7pyuYr77ECF9G5ELbkmXXiWqdUH5LM9/WLCJ8ViHKvhjfZQBBVC0A05P2Hc/0FFe65B/FXxc
 S9ctyFcTyWrdYtXvh491tk+C5FGd5QnShgCjAiricMjyUKQLhPrYePaRylLFQ40QPAna4dp/RsU
 r53BRhQ8J9Bc99df8/cMK0YTXP4aLbOCwK693E8K9nwObLWOiC5k69s3KS/tOBVQMZIr0t5RGyG
 G56JZUmN8t8yXakREApA18XcXmFN8+m6o/YABGzmudzoS23Ip14CAvAQ2QoDHyGhWv2TP9UD/hN
 TLu4IiA3HsQNb472Tte07N15Soh//4mZvVygJZxZTTdL6t4cmcMWmHa2eLAGZg96Bj0gac6DhW/
 IvV5KbMM5trPIW/ZYlKqkPg9ZKo/SdF2Z3puRY+dSwMlS4w3i9ORtTfaTrAIT3b3QPdZY1fU3mR
 BywAHgR+EpD+4W6fp0Q==
X-Authority-Analysis: v=2.4 cv=WKZPmHsR c=1 sm=1 tr=0 ts=69e7252e cx=c_pps
 a=V2btASzwI3AgjbPAPCrjFw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=hh5_vNSPTWDFZ6TSUYYA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_01,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 spamscore=0 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210070
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240057-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,roeck-us.net,wunner.de,vger.kernel.org,lists.freedesktop.org,intel.com,nvidia.com,mageta.org,yahoo.com,gmail.com];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[22];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:email,windriver.com:dkim,windriver.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,wunner.de:email];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 31E384379D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ionut Nechita <ionut.nechita@windriver.com>

After reverting commit 05703271c3cd ("PCI/IOV: Add PCI rescan-remove
locking when enabling/disabling SR-IOV") and moving the lock to
sriov_numvfs_store(), the path through driver .remove() (e.g. rmmod,
or manual unbind) that calls pci_disable_sriov() directly remains
unprotected against concurrent hotplug events. This affects any SR-IOV
capable driver that calls pci_disable_sriov() from its .remove()
callback (i40e, ice, mlx5, bnxt, etc.).

On s390, platform-generated hot-unplug events for VFs can race with
sriov_del_vfs() when a PF driver is being unloaded. The platform event
handler takes pci_rescan_remove_lock, but sriov_del_vfs() does not,
leading to double removal and list corruption.

We cannot use a plain mutex_lock() here because sriov_del_vfs() may also
be called from paths that already hold pci_rescan_remove_lock (e.g.
remove_store -> pci_stop_and_remove_bus_device_locked, or
sriov_numvfs_store with the lock taken by the previous patch). Using
mutex_lock() in those cases would deadlock.

Make pci_lock_rescan_remove() itself reentrant using mutex_get_owner()
and a reentrant depth counter, as suggested by Lukas Wunner and
Benjamin Block, since these recursive locking scenarios exist elsewhere
in the PCI subsystem:
 - If the lock is already held by the current task (checked via
   mutex_get_owner()): increments the reentrant counter and returns
   without re-acquiring, avoiding deadlock.
 - If the lock is held by another task: blocks until the lock is
   released, providing complete serialization.
 - If the lock is not held: acquires the mutex normally.

pci_unlock_rescan_remove() decrements the reentrant counter if it is
non-zero, otherwise releases the mutex.

This approach keeps the API unchanged: callers simply pair lock/unlock
calls without needing to track any return value or use separate
reentrant variants.

Add pci_lock_rescan_remove()/pci_unlock_rescan_remove() calls to
sriov_add_vfs() and sriov_del_vfs() to protect VF addition and
removal against concurrent hotplug events.

Remove the rescan/remove locking from sriov_numvfs_store() that was
introduced by commit a5338e365c45 ("PCI/IOV: Fix race between SR-IOV
enable/disable and hotplug"), since the locking is now handled directly
in sriov_add_vfs() and sriov_del_vfs() where it is actually needed,
reducing the lock scope.

Fixes: 18f9e9d150fc ("PCI/IOV: Factor out sriov_add_vfs()")
Fixes: 05703271c3cd ("PCI/IOV: Add PCI rescan-remove locking when enabling/disabling SR-IOV")
Fixes: a5338e365c45 ("PCI/IOV: Fix race between SR-IOV enable/disable and hotplug")
Cc: stable@vger.kernel.org
Suggested-by: Lukas Wunner <lukas@wunner.de>
Suggested-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Tested-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com> # s390
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 drivers/pci/iov.c   |  9 +++++----
 drivers/pci/probe.c | 11 +++++++++--
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 91ac4e37ecb9..7ed902539051 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -495,9 +495,7 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 
 	if (num_vfs == 0) {
 		/* disable VFs */
-		pci_lock_rescan_remove();
 		ret = pdev->driver->sriov_configure(pdev, 0);
-		pci_unlock_rescan_remove();
 		goto exit;
 	}
 
@@ -509,9 +507,7 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 		goto exit;
 	}
 
-	pci_lock_rescan_remove();
 	ret = pdev->driver->sriov_configure(pdev, num_vfs);
-	pci_unlock_rescan_remove();
 	if (ret < 0)
 		goto exit;
 
@@ -633,15 +629,18 @@ static int sriov_add_vfs(struct pci_dev *dev, u16 num_vfs)
 	if (dev->no_vf_scan)
 		return 0;
 
+	pci_lock_rescan_remove();
 	for (i = 0; i < num_vfs; i++) {
 		rc = pci_iov_add_virtfn(dev, i);
 		if (rc)
 			goto failed;
 	}
+	pci_unlock_rescan_remove();
 	return 0;
 failed:
 	while (i--)
 		pci_iov_remove_virtfn(dev, i);
+	pci_unlock_rescan_remove();
 
 	return rc;
 }
@@ -766,8 +765,10 @@ static void sriov_del_vfs(struct pci_dev *dev)
 	struct pci_sriov *iov = dev->sriov;
 	int i;
 
+	pci_lock_rescan_remove();
 	for (i = 0; i < iov->num_VFs; i++)
 		pci_iov_remove_virtfn(dev, i);
+	pci_unlock_rescan_remove();
 }
 
 static void sriov_disable(struct pci_dev *dev)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b63cd0c310bc..ec45783230dc 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3513,16 +3513,23 @@ EXPORT_SYMBOL_GPL(pci_rescan_bus);
  * routines should always be executed under this mutex.
  */
 DEFINE_MUTEX(pci_rescan_remove_lock);
+static size_t pci_rescan_remove_reentrant_count;
 
 void pci_lock_rescan_remove(void)
 {
-	mutex_lock(&pci_rescan_remove_lock);
+	if (mutex_get_owner(&pci_rescan_remove_lock) == (unsigned long)current)
+		pci_rescan_remove_reentrant_count++;
+	else
+		mutex_lock(&pci_rescan_remove_lock);
 }
 EXPORT_SYMBOL_GPL(pci_lock_rescan_remove);
 
 void pci_unlock_rescan_remove(void)
 {
-	mutex_unlock(&pci_rescan_remove_lock);
+	if (pci_rescan_remove_reentrant_count > 0)
+		pci_rescan_remove_reentrant_count--;
+	else
+		mutex_unlock(&pci_rescan_remove_lock);
 }
 EXPORT_SYMBOL_GPL(pci_unlock_rescan_remove);
 
-- 
2.53.0


