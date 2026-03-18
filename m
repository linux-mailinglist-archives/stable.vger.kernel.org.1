Return-Path: <stable+bounces-227163-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aClHInkTu2k3ewIAu9opvQ
	(envelope-from <stable+bounces-227163-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 22:04:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2893B2C2D07
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 22:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFD5D30EBD6C
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 21:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E566D36C0C1;
	Wed, 18 Mar 2026 21:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="p0jUOr+L"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFECC372EF7;
	Wed, 18 Mar 2026 21:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773867864; cv=fail; b=Ev8WeY9GkCEISGGX1l4bAB49FPND/Ywig2Iqwh30d+CVnPhFyUEUPN92z/DZhcz23gFpYx/8Qs97u5EiljhwgRBJi1xi4mH8BNdSkVtpaQCVRF+XzR2Tz+UaTzcTXQ8TBo/vcAmrut4BvHBlZEHnK9YNItus1UFXzhPFnHb2yTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773867864; c=relaxed/simple;
	bh=97fBUIzEsvZkQ6CLc+TF1Ne81FVmnVysqzuVWLHRm4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pBuEqbuq/WP4YqACjQ0eUJkxLT7lkfF0sH4dVYgx9VOkjN+OaRhwqaLiE4SVtdr5/pvWfcJA+nqM+2gfvtOPWr0n1StxYCfZPgQR3+1sk/eaCo9c8gBZzLhBBermn87c/7w0nRSsMIwjbtzyUiP6V4s1wlsaE0K4uNTPHV8s38o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=p0jUOr+L; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62IJjF1L275481;
	Wed, 18 Mar 2026 21:03:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=73FnOXzCC640u96IzTPhmbrc3TlWLjfMz4AS60ZZvoQ=; b=
	p0jUOr+LQ7boo3rpljRQYeXWc4ljELMoFicCk9QpLw2f7EN3EUs979yGJoKiYJiF
	HBw2oxUBA8tvCwUG1jWsdDvY+ZT/DiFCAp7kj9ZfswXci+dNhSkTJU9rGprzb5uN
	M1fQgIXEihE5+APmV4X7MxZ5zN2rB27lqQSLKYz2+byijLJyHSlr5C9Pm9CkCHwO
	LqMie334co/vpPw1QAsTq/HE0z4kc/27PBRymAOcvaahnXhnOjfXJM6erJfIda2o
	ey7pyCJnMA0LUS9gqUIpL1K1AayxUzF4ExQnLHKUrWPX8mDBHXqlRHvNdSccjnDB
	55wLXp0Y8UqV8+/uqh+IyA==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010019.outbound.protection.outlook.com [52.101.201.19])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cy9ansyxk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 21:03:40 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YSP1jbLFqB4YTayTu4MnbAL3bWjp8LiK82o4tFIjfOkhb7mbE1C6zWVWzoDFrfEt3huQRaYfhzNFn2TY5KGdtlDkpiEzW9KLwe7qBoRlhhgYwpMHwh8JmjBa5xFOTE8EyWszneUxQxh4mM2pPh9BrfYTkVBdq5LicLscB39t+Al+llZ/oUv6Xpg4bKxucbB7CgJxVRGan02c/SQ3Vt1XpUC8Ou9VFnxUiJ59DnlciLCoXM3l7RZGeCBI6YsGY9GniNmjjH/4mtzBRmktYjx4IwXFgXaufzVvaOHFZdrFQol0evgC1PmeSM7GVr8bzwbSQIhN4CDBty88xcMiVHL3iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73FnOXzCC640u96IzTPhmbrc3TlWLjfMz4AS60ZZvoQ=;
 b=MfEo+P7yZ8WxtPoD4yEiAM5mujSOWirRd1rxyrem6zQTeCflHnu0IBWEwo/mNZAmHSWzl6GIh3c4hN+H/nDAe0bar5Suy/9j6c+Z5uHc4KJjaROPzbsiP7gRhg5BsuNO26Rs40ocA1Mt0k47PyQGVQn2//LjdKyZ9eYs3I43dR6YfCz6R4rA02pmeB2Ovf3XLcu+DErJhQJ4izDZwWmZMcyB4iy+SwLIIEt5WWBZYo/IRL7n1D1C9u/cPE7dl29jlGZRULbxuD3A4enIeWlNoQ75vyshjq9CNu71bNqAWJmZ+Oj2jAlucpwwYQ9gkEzZqaI20ga6KedyM6QvJ1WD0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by IA3PR11MB8893.namprd11.prod.outlook.com (2603:10b6:208:577::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 21:03:38 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 21:03:38 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: helgaas@kernel.org, sebott@linux.ibm.com, schnelle@linux.ibm.com,
        bblock@linux.ibm.com, lkml@mageta.org, alifm@linux.ibm.com,
        julianr@linux.ibm.com, dtatulea@nvidia.com, mani@kernel.org,
        lukas@wunner.de, kbusch@kernel.org, linux@roeck-us.net,
        ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        intel-xe@lists.freedesktop.org, matthew.brost@intel.com,
        michal.wajdeczko@intel.com, piotr.piorkowski@intel.com,
        "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Subject: [PATCH v10 1/2] PCI/IOV: Make pci_lock_rescan_remove() reentrant and protect sriov_add_vfs/sriov_del_vfs
Date: Wed, 18 Mar 2026 23:03:15 +0200
Message-ID: <20260318210316.61975-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318210316.61975-1-ionut.nechita@windriver.com>
References: <20260318210316.61975-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0250.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::17) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|IA3PR11MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 0de549af-7918-441d-c95c-08de8531d350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|10070799003|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	d0dVU6A1tMsGTG3H+f4fxh+4aNlSHE99Y1JgE6RXIkVrLr1LZhYZVI6jP0rv2x6SG/Dh+sk645RJdafJizCw1KvH04Ca5Q2u0ZciOSgXoGBttkBuZw2k+L2M15YnhLSjRXNSUAF+cAufsxgR3pxT7vRTZk35bHUFX2AnZ85PGYHolNSuB88TgJKvss9vbdkyVus+G4KZ8DuNCGkEqUBssfQeh9YYdJCZbApFLRWjXHMk04bTMMlw8K8datG6lAG247mWfze3f0tzIPn8EEHwl35snK68SPy0iiX1wtOQoN1AzmekniZ9cel5uG1Zr/l0PULSUpl9paf0SeUZCJCHCVCQWrs+s6owNMPjPeP61XXfdYMW+oQqMdTCZYbAlBQJa4oM3rKN1jtWvYReYhkYvGq0E4sfIHc8zAHI9IMfk1CxPa2GP7K6fopwQs/0ZVwCDXbKyMB2BzWjTDWWXYX3+zQm2LDW6xMDC7Pg5N96PO1dous7iTe7w/xNYC9moO9kWIu13LmsJMFV7lLREoIg1jGsZaoO1xxMZlyL+8DZMLeyf63PlzSGEErP1WuP6jEq1sl/bdbQFyJ1cxRc9vTsM5oZ9roZ6Z6fgCL0gypS8+6J2F1E9T8Ws/3RC09dssTqwj7NdYuL2tkOI2MKJ1bnM+BJdpHae53V3NaorhFDkIdngjPcdVdZs/cTh3Kur3zij2d39TGpByRj+iJSibWhLDUavLQWrTq6tXakfAaSW6U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(10070799003)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nZlgs4kZdVSTtNAyTHqXfWqbzhMYNNI8EO7oO9q7POkeNdUPwLeho+xvRoF3?=
 =?us-ascii?Q?bxwcfy5SlxTds1Z8dHzbAr+1/3nvnchfGlO9QGSj7ctqy31fMhK2ZDdrguII?=
 =?us-ascii?Q?ourBaZRtRJqmSTq/oKpM8SoRjnYhs7nvUBNEx0AHC2+z5cIb9iISRe4N9MHg?=
 =?us-ascii?Q?F7wRaVPa1hh3RSOpZp0OiGykS3hRqDBXFD9D+GmTb9ggEPU2+H3bhjmsau4/?=
 =?us-ascii?Q?HrZiYac6Ld4ULvCcFbGqgNgxo/w9cFY8WlKwzQGWZXU7J4jt5TQDXrD6xlLW?=
 =?us-ascii?Q?K/0rNjBZJsJS0fm09QdGdltQJtRgs80IM4Q2xxFx2oInqa/gHHnIeJZokZrP?=
 =?us-ascii?Q?x0q+gZCq0VoJF+Ye13eiZPht2vHwWaVbrWoiRVRqhFSyjwrlWamucL756xnk?=
 =?us-ascii?Q?G5COQMWMqeMS5bO+lqAQ6ZYipN8NVjJjiD+Ya8btw6viSFViZNJGl5DUMXvb?=
 =?us-ascii?Q?zpnVGom3GkanK5UzMg/W3IuiuzhlqMdy89GaQ2/wpj2gF8afD+1kIYaUHgqI?=
 =?us-ascii?Q?UJzgzLY7rNsFzAUi8F4ukVWD8N0Qp7CVWuDyO0D60psJp5NwgdY83asUtsxj?=
 =?us-ascii?Q?qBWtfF5iB3O5LSz7zlkkdvoSfNvdbCxIYNCxEJSMzMt64rRFDmlvrhqAmDnF?=
 =?us-ascii?Q?+IDTxzSPG/Vc1PneBv6q+rUVcinjM9e6Dbd5VbobQnjyMPue7PeuSkL4gTCo?=
 =?us-ascii?Q?hxp5ij0/eaC6AW9IeeI4HSF0zfp795WJd4o2B8dP1x7pjIfDrhPapbhBeVj5?=
 =?us-ascii?Q?4W71OgPn6RWGfIvQOnJ2pIq+lTvZutZVxKar6c7sK1HwGkuUBnVSgN+tc70h?=
 =?us-ascii?Q?d5z1BDhWJflidj0KpPAAbVH+GSNaZfWDzxE/BhIUo8GR7pqImrxaT02xQqPX?=
 =?us-ascii?Q?tvyBYV3lilfoSCO1AYedoU8B0IjyHX0qF1/9gNjIYRCoDcJEmVUxRvVK/0CZ?=
 =?us-ascii?Q?KVIlar8tP+9MbozE1Rhry+FUitISd8EgVBlVdrLv1UzhzwpLoav+76upMzvY?=
 =?us-ascii?Q?p3HtG6d2A4E1m0aWPd3d3SGQO24r4O8GBk6QPMzTt8i34Uwu0OPOPQGaHPbs?=
 =?us-ascii?Q?xm95E6qJhAtSXfxNSTP6tjOisBgL7Cprwlddki//c0XdQ3K/jNN1VHEbWu6Y?=
 =?us-ascii?Q?V041g/AdwGEu2cjKxF0LavEGsP5JNrzGKMCy8hTDvYu+Plbkn/usY2ZCUXcR?=
 =?us-ascii?Q?fbzdp+ZKqThmIVUyarMFxrzWth/CNyS8j5WzV53axiHK1SAwpmSzHv2I+BcW?=
 =?us-ascii?Q?nDqLDCZmh+7V8LgG3CeqTDMvwzmtsXdJTAv9MGLZzwhB4KmKVRjUo9eFF1WY?=
 =?us-ascii?Q?jxl7KR8fVyy4ck5DydYWEb1kdzWy6lZFOLh0ZNy9H8HwDgWM8JLI1wQkolGL?=
 =?us-ascii?Q?Zc3ZcNBGM0JhcEFBRlwCK0QNbbcqYGPoU4uzaFzFdafNn9BkF1EndXFH4F16?=
 =?us-ascii?Q?Ug1ER/8uGrlpjrHLaT+ywMEvkHXjBYHUCqmJhNkZi3fVPWPl9fguCCE19ymI?=
 =?us-ascii?Q?OhavqDRg0goXOJpWF72/YXY0KYtl1chFspjv/X7sqWjJ39UwB27bBWnlUNna?=
 =?us-ascii?Q?UF2LfI5dFXVVoKo0CxwbwUCeDepTwHVEs4YlkBBlKRq6ZZDfdZot7DYnd2kw?=
 =?us-ascii?Q?4/xZaDyWwC7mReYeYH3m3lqGzS+aDq5Ohp6D4xZ8oGh7wZdm2P+mL7x4VLtr?=
 =?us-ascii?Q?12eeMRdWjwOXpNzJzzLBxmRsW2rMXKQDgZ0prVmFgs4RBBqrSox7MlHr7i8b?=
 =?us-ascii?Q?zG8WfE96Lyp/6APIaph1hX1bYKsd5ipk9Y3Icd4wZ4U1lJeBzYnxeHy5gsz9?=
X-MS-Exchange-AntiSpam-MessageData-1: 8Bo/exbnzXqpN8Bb2YRzb570ylA3RG13f78=
X-Exchange-RoutingPolicyChecked:
	kihcXn0ETjA69+OSi87H/rHkJZqHt52ypot2iVBi/lFTzaWL0evq6tjSBBk4HiRhupTCE4i20MBGkIReEVE9ncp/avAHgR50cfj290svR24Y3LNz4I+f6rR5pAF6uGksYWKuhjKTjb3y214coNvV3CLUStwjNV2xzLM6kh0r4d5vAj+JKbIOTijFGymMiQklLo95rUCl2XC58s807gSzipxk9eh9VCanl1Ns6+ZXvAMSfcQAtG7FhcIZ9y0wx1WNCMYZi2qZd1MpZ0wV7AZUkfUPhhl+WmolMhaUFgRqc0L66rEOQiLuk2snkNR3PFY0iT9w6JHJWxag+NVsAcLfVQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de549af-7918-441d-c95c-08de8531d350
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 21:03:38.1033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gXpNBqBKZUfYtbZbmHYnPA2ct7tLrjgxEsXEdC0n4uEFxOrQD/VJtBoQtgfvisK0zgcbyrgSeL8Otaw+IF3BYpTMsFT56ybenug6kswrwWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8893
X-Authority-Analysis: v=2.4 cv=IrMTsb/g c=1 sm=1 tr=0 ts=69bb132c cx=c_pps
 a=NuF0lfjhaYRYFIRzorixyA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=t7CeM3EgAAAA:8 a=hh5_vNSPTWDFZ6TSUYYA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 5EqQTAw0ZpfCqRfguVFZw0c0x6MPPuvO
X-Proofpoint-GUID: 5EqQTAw0ZpfCqRfguVFZw0c0x6MPPuvO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDE4MSBTYWx0ZWRfX5zaF95IiSyAC
 TgZIywyFOVbS+P0McQb9LVKEFQZmIgkXbEjb1iOMQEmJdhEGRnrUo7zI4cwIDwzOeDRUn7fmyKF
 j3R/c2UKrISJZObA+ECBEIB/zEs1Ve/e/vJ4fkU2sDlmkFuABYdtewKaULsgWvZagxFZqXySbrH
 LyVWc4/FaQJD96Efl/xOluH5vyelfPVnfFvSjS0FUfCgTPwIO+E+Lf8uloqnrAPSlmywcNwS44q
 o4riYPhRvwN+skzv1X2d4AEMl4xd37IZUk/7q5gM2UllRQZVSc7+4LScA9ARK3Jyhl+kAAamSEv
 w5tKypDUxFoLA4ipE5dJbOxCpeOtATb/aDdIx/w7qMzmmy0tlCxD/KW72qPeIwOaRSSQOyzHhgF
 iYyHi3X5BKpTr6IavpfHzxTEym5UgWVC1uRjTxDVaXtppSmS6med4UXcAb1RMoYqrivdXq4Pgxx
 g0+oMZ3h9z6/FIVOJBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 clxscore=1011 bulkscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180181
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,mageta.org,nvidia.com,wunner.de,roeck-us.net,yahoo.com,gmail.com,vger.kernel.org,lists.freedesktop.org,intel.com,windriver.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227163-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:dkim,windriver.com:email,windriver.com:mid];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.989];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2893B2C2D07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index bccc7a4bdd79..ce4d351b5aa2 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3509,16 +3509,23 @@ EXPORT_SYMBOL_GPL(pci_rescan_bus);
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


