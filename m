Return-Path: <stable+bounces-114056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3474A2A520
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 10:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56143A3E49
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 09:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657EC225A4E;
	Thu,  6 Feb 2025 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="gZImi63L"
X-Original-To: stable@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818FC1FDE08;
	Thu,  6 Feb 2025 09:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738835460; cv=fail; b=bGN9NSVEx3CqQXBmu0Sufng+AaHo7rf/omNKifrimPzaT/DLXFHgSrfVoer9Q1S8w1jDVwS7ZP3hgxxY0T2pXIamcHnlEbuDIhwmgfAd6MB+jqopJ9oMuvMk1vizFLm+bvjyslhzAfC82BOurvAMHTiGmrDPr8vgLBj6inRwOnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738835460; c=relaxed/simple;
	bh=3StlK3pr9EH2UHFWj1tVz+kGMCHgzUGTGIOlooqbXyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzmdKIeaQjixld3fuLoxHigFfMSgdd38jeheuXNYTeVsjiaywLjRBLolmZcPc0vbCEa6aI2StRGR/Xr811nArRgolfPf3v00EQg/OIotjnoS/6Q/aZK31LrwimtqNYqK5ncuZaH5OxljVYEB2T9aeatwV0mAjSFq7/i+wRyGk8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=gZImi63L; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5166fFqj002788;
	Thu, 6 Feb 2025 09:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=S1; bh=8c1JGK1RlfFwuX2ZH5g+PocyEId359m
	TDL/mXqCI4sQ=; b=gZImi63L0SZaxaUL4O0t2MBDr5M3fvRLfYb+4gQBifOYp6E
	AczBeBwJXRinrd71qNjXfl0ncdKNuIny4mijI4BiaMA+4MKPm9xq8CM0+Q/O34P3
	KVxfwhBQd4YSgHMwSJsZuPhGFHCkdbt6O0kvUOptxBYWzp4BetP8FxclAEsvQIY/
	eWeZOiYXUdPS+FlHA4lp+i1M7fP5I9LAiemx5B1O2mW20g5XPmfzf+ciT/luxxcD
	KalJO6AJhm++pM5uP3A3h65U9mFPwiIglNR4OKa4rDF7LN+D0pxUe9UV5J+/YrqC
	hODQ/ATjFxkJc4H77IiR/kP+YR9E9PU4hl9uVrQ==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 44hd484gfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 09:50:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDGkBydkR7npALSmhqaKRTO/Jsy/khDUNVJU3YIlU22stAL/vyCKbB7z33eIzZiVGzPNly42LOe2e9XipNwwoIidQbYWL1vTrlzSQih0YLayWvj8vwRojmvk16GbsSYJCuZD+JBfSkLy0q1dqmd53lM8XB/WbQr4TIJpMV+G4BRNhw1w6caF4AZn3EyZ4rSMJPKN6tQDeBRrnXDnEDYgPpT4RMTblO56uuPnRpl0rI2j5C71cshw3GsHzOLodT79wg4b6FlsXAvmwPph2Qx8jN8beLI/pkJmVFzUyq2EdRlCrQVWlZYp37CDVGXCcB9P/OGPfKSC+sC6g3+n2yva4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8c1JGK1RlfFwuX2ZH5g+PocyEId359mTDL/mXqCI4sQ=;
 b=im6TgtYj7QOIhsRdH+zJ8rnWhVJ3TmK1Whd+ncmbYgUMf9wIq/7+yzGui5hXWLIDF+8M04M+npV9XoiZcO/F+HDtoxLlGBVEGCEdFZ31lDnOVk+PS01DASox4rbNg84ESbO6Tn/wLwiSukskBobEI+bHCC/ky2Bn5AsFH3rYe6gq6tOfvbvtGS3LU0/2izUGw8kZISny4b+lmH2kRIoLD3oEWMIJH4lL/5jJ5KaZTRt2P1gevyKcJide6sxxM2W/JrpUO0f0kZnRck3YIyafbf5zMFi6fgDs24TH1PULFQ8hrunh7jguiYh2a+m5rXIkew4Am/lgokQ3KidSb8xzHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.196) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none (0)
Received: from DS7PR03CA0312.namprd03.prod.outlook.com (2603:10b6:8:2b::21) by
 IA3PR13MB7078.namprd13.prod.outlook.com (2603:10b6:208:535::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 09:50:46 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:8:2b:cafe::4a) by DS7PR03CA0312.outlook.office365.com
 (2603:10b6:8:2b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Thu,
 6 Feb 2025 09:50:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.196)
 smtp.mailfrom=sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of sony.com does not
 designate 121.100.38.196 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.196;
 helo=gepdcl07.sg.gdce.sony.com.sg;
Received: from gepdcl07.sg.gdce.sony.com.sg (121.100.38.196) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 09:50:44 +0000
Received: from gepdcl02.s.gdce.sony.com.sg (SGGDCSE1NS07.sony.com.sg [146.215.123.196])
	by gepdcl07.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 5169oUxV024184
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 6 Feb 2025 17:50:42 +0800
Received: from APSISCSDT-2369 ([43.88.80.159])
	by gepdcl02.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 5169oSK1017294;
	Thu, 6 Feb 2025 17:50:29 +0800
Date: Thu, 6 Feb 2025 15:19:48 +0530
From: Krishanth Jagaduri <krishanth.jagaduri@sony.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Atsushi Ochiai <Atsushi.Ochiai@sony.com>,
        Daniel Palmer <Daniel.Palmer@sony.com>,
        Oleg Nesterov <oleg@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH] Documentation/no_hz: Remove description that states boot
 CPU cannot be nohz_full
Message-ID: <20250206-hypersonic-penguin-of-typhoon-8ef016@krishanthj>
References: <20250205-send-oss-20250129-v1-1-d404921e6d7e@sony.com>
 <2025020547-judo-precise-0b3c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025020547-judo-precise-0b3c@gregkh>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|IA3PR13MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 084c192b-ba2d-4301-d576-08dd4693ba4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SDBgKu09xJNhEoKd/uKeolEEVGu+/XxeydL9I0I54BbTnK5Ma3DOl+wTv5Zd?=
 =?us-ascii?Q?9DTOX6knNRJPRrxP6pdd4JPOf74IAh3y71+F2IQem5KW7qBJCXweR0I4XlLq?=
 =?us-ascii?Q?5p4h5H4UuXRDYNNMMhHktQ3hjFJ/p8hA6YjcLMA5e08Y+/6xUH9AaMp3ctab?=
 =?us-ascii?Q?uZi1v5+FWJULyPIwj9H936MTTuIhkRq/jP6+gPYnZ8UD8E79Dv3F8N6WpxTi?=
 =?us-ascii?Q?0a/bRblX2fhzGRG2VUyXlkW56lm0tQgR1jz9iXkpxnQoAoOIK5OON+eik7cd?=
 =?us-ascii?Q?/nnu7elKCeVdfGSYSO9Gc5Le3U1ex4CUUypWTX0ULotk3CDBT20AZUoT/DrW?=
 =?us-ascii?Q?SYklUhI10lO959AjEnqLJNZGFGv9WLiBHnCouh0K+xsjgcnVkvRv88IeUOzB?=
 =?us-ascii?Q?8zvHDI0VSgIFihwDYkCzw0PyMxlSYSi7VFHfLTBpXSvbxFWeYL27Lx/JIGEt?=
 =?us-ascii?Q?uV/itb40TOTtv549SnCdmuZTF2i6nRgky4MD64TeItzXgmfhr87E2ZZrUr8y?=
 =?us-ascii?Q?fDI0mNXiqgBIOlxwlMdQPBBBy0llQZCyuWT4J5aNb10+ebNbLP2l6mN1rl5G?=
 =?us-ascii?Q?r+BVHDRz17Aoir5/oFCI/zGYk6mFC3ZBLWFLHju0y2TzdBwXUzToiHM2SljL?=
 =?us-ascii?Q?shojo0xfmZDc3v6ryeb25WcKbm/LD0GJ7wQGJIdymMn3Cc4vVm2hLdis3Xxn?=
 =?us-ascii?Q?UTLcKeD24DaB9SpBycH7GrM8f6i4tz+tNO0bd0QvBBSBWqDg/d2EZsWC07tn?=
 =?us-ascii?Q?F3gEKU1/Bt9DHT1wXvAP42U40WFrVAESL5hBYHfhq5mbawKTj+aDexeMF48f?=
 =?us-ascii?Q?Ulvtl7qK0Swuf5bPlwGylFQV4G4cfBtUAqu/0N/AMSrygKZ850hLtcmP2KUA?=
 =?us-ascii?Q?wMcbcNC5w597CxcMIHGXV9TCDkYrP/MdQtZNS5G9cJOe+0ffEJgXYka7fqal?=
 =?us-ascii?Q?eh+MPAzLvhVRRX/QlqRlr6lmZXpl/CbGk15S5Zrt4Z0sNJaTomwi12FGQNG3?=
 =?us-ascii?Q?wj4xzNwKgBMZmYXY4RUWbR6thDRzmPo3pKgY5f0l17cUiPqQ06wZMFxf7nTE?=
 =?us-ascii?Q?x5pvwx1MReovU4YHCXAUtGV8hMeIWdwe8NdYRb8zHJTLhOdfnq9G5PtaUwAX?=
 =?us-ascii?Q?3QA7kTWnb2KlsQfjALVcEgUtODaQlmL6OGGRGUwIg2lzjexYkkQUV0rKIizk?=
 =?us-ascii?Q?FlpIMeaEm+JF8+KcRIKWBV7XUr6fUj7JODbcD7OQ9OOjgbS7GHnjJ2zESqH2?=
 =?us-ascii?Q?laMzBdWnFeGq9gLWvoIFHIUzoXcLI1NNad2UXMnbidbHaPZIAxVXpf18WrqH?=
 =?us-ascii?Q?HUzXigYL3GAVwGDbMWGn3R06Rd54izOUmoIRGrb2zPE/MEuRjiUCrapfiv1Y?=
 =?us-ascii?Q?pW1oNrCEjOLAsgQYs4al0quVzBoFXYfE372c5Uy7vfUU0CETOCm29TVlqqmg?=
 =?us-ascii?Q?f1cGDqRCUQ9t4EWbiU/ybt4NyH5jNYuB6XW/rukQYVOfh0O6COdaYA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:121.100.38.196;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl07.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yEt0WZ347VQtxaKixsHomn8bivtS+/9zEHgRz5cJlS584Jvha3LXgX3xVZtboYpwRPWuKazxjpTUF3dEaOCt74YhnimOpzrAOGES+ef/CPYv7sNsZaMEhIL3NZf/KKLh2tz0X2C+7CdrmuwIjc8TW8A8qzRMygOLlk6RdsHjcCR8pSRJZ5usqqwPbmPLyYhFGmIA8NxkCIFt+pDVaNTpUlsnkqVv8hqkZKRNo8Xeg17dLGTTM49Rf+67pMZ+VrSQiyJrZBi7HpzxYsmj/3KP+vMI9BATujy++1xchDanG+yUf0Wf1bjvwOQbzXBKeejJQIJkjGF7RaGJusNpbcs/gJyyOZ5c848kWIlAHA1eIYtfLxq5QCy7bkfRq++a8Pr6gYkSeVvr6Ei3eP/5uSF9hgAouecFmCzaYSexi9DisFC7TIQDH9DYS19xa6t00wUQUeZPhON5OmmSOyAhuj1rk9mxTIO0e11+QfzvqKKXVwCN/h7rA1OeYy3zLKALoK/5xzBasH0qo3yCT8RJML+ODLBUHzVXEfSpi888kSV/YSjt3bxlmtldY1xzk3s+4Ge992m4LIxL2r9TT9OEVGFgMFniScXlwpH+XPmSaydHv2JJ6YpYlV/iG6suF04OCVgO
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 09:50:44.8909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 084c192b-ba2d-4301-d576-08dd4693ba4f
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.196];Helo=[gepdcl07.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR13MB7078
X-Proofpoint-GUID: udZftQASvXpU3r5b4I0ntzA2xwuwW5qQ
X-Proofpoint-ORIG-GUID: udZftQASvXpU3r5b4I0ntzA2xwuwW5qQ
X-Sony-Outbound-GUID: udZftQASvXpU3r5b4I0ntzA2xwuwW5qQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_02,2025-02-05_03,2024-11-22_01

On Wed, Feb 05, 2025 at 10:18:17AM +0100, Greg KH wrote:
> On Wed, Feb 05, 2025 at 08:32:14AM +0530, Krishanth Jagaduri via B4 Relay wrote:
> > From: Oleg Nesterov <oleg@redhat.com>
> > 
> > [ Upstream commit 5097cbcb38e6e0d2627c9dde1985e91d2c9f880e ]
> 
> It's just the documentation part of that commit, not the full one.
> 

Updated in v2. Thank you.

> > Documentation/timers/no_hz.rst states that the "nohz_full=" mask must not
> > include the boot CPU, which is no longer true after:
> > 
> >   commit 08ae95f4fd3b ("nohz_full: Allow the boot CPU to be nohz_full").
> > 
> > Apply changes only to Documentation/timers/no_hz.rst in stable kernels.
> 
> You dropped the rest of the changelog text here :(
>

Updated in v2. Thank you.

> > 
> > Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> > Cc: stable@vger.kernel.org # 5.4+
> > Signed-off-by: Krishanth Jagaduri <Krishanth.Jagaduri@sony.com>
> 
> And you dropped all the other signed-off-by lines :(
>

Updated in v2. Thank you.

> > While it fixes the document description, it also fixes issue introduced
> > by another commit aae17ebb53cd ("workqueue: Avoid using isolated cpus'
> > timers on queue_delayed_work").
> > 
> > It is unlikely that it will be backported to stable kernels which does
> > not contain the commit that introduced the issue.
> > 
> > Could Documentation/timers/no_hz.rst be fixed in stable kernels 5.4+?
> 
> Does the documentation lines really matter here?
> 

When we tried LTS kernels 5.4 to 6.6, we noticed that boot CPU can be
nohz_full without any problems. But information in documentation was
misleading. We wanted to check if it would be okay to fix the information
in the document.

> At the very least, we can't take this as the signed-off-by lines are all
> gone.  Please resend with them all back, and then make a note that you
> are only including the documentation portion and why.
>
Updated in v2. Thank you.

Best regards,
Krishanth

