Return-Path: <stable+bounces-88035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D709AE435
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 13:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B50F1F23246
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 11:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF251CFEA9;
	Thu, 24 Oct 2024 11:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H9KLlYyA"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C02E1CBA12;
	Thu, 24 Oct 2024 11:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729771000; cv=fail; b=D7VEt71Fb9vKg5ede6B5W4FXtGUCVUFr3q1B1PVum7jpNIz7Vd2jHOh9huSbMsZf51+DoiWpi5npTlhMR4uTrdJ9dhKTULI7fRMPdpc6i2dqS2RfgdXDYmyy7Vw2uxlqHRTLR2YUO0OpewKLP/cwpDufgcemnDZAete5t4l7xn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729771000; c=relaxed/simple;
	bh=OsWYy+I0mrGoc580TZjkX8J7jTy+YYq5UPD0FfNDBGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hvREqa9vSU7+jykznLJmAMv+pajU8lc+YWJ/0r7nMFYjOY/93M6Lbq32AE+OKV2H9iIHCgRwQbhrM2bunDgfwUOMIMyrs3/jTTmT6JKAPhzuCjTkSDvbpVgCLL9WO5LxVImKzBKnIT32nK8DvraCfefPw3LVNKg/KjyteKMmGJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H9KLlYyA; arc=fail smtp.client-ip=40.107.223.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmZbnt5VzDsZZGg4ETRd6ub8uq6b6dd5M/P7BNwAHyndCoj7AVP+ozBHsURe5EO6VB9Da67Q2xpfbkqyZtH95M2YygwHSLS0WuCQd17WJvhqu9MXtRmAJEnM+WzraDLKxgh+eoXKmOa+SmXCSJS/UsyODtoUcdM2edOueF66MF9UZ+Iq6LUBMTKuW1BftddS57rGDICI+0dQ+Bf9TOQadDUOT0m6qVkxZNJFKD9s04KjnEMG1r3pQd8X+wMWW3KUKNoWn0aZwZpUwo/BYJIhfPnXVZtca5+6jXRCHHK1IldJNlENjBa1VBe7WYC5Ia3nPYyZrm08n8FK+ZJU0z+XEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twnHNk3qguz0wGNcNaT0Cj+Id16B5aBBxg4oMCk9CnY=;
 b=neWLPUVIgRelBkEujZWaRgx9XrwE3MQFYjsF7V+zrKCcaLa5Du8m3NdJUZMxiqmGIXp5/DUneB8UZ7KpcAmwKYE089e3Bc4CDW/qlp0CCqrLuqf3HBMs/TJsRbrS1AEuCDJnuFzd+WDLGsvw4eZ3hmlqkbrLgdkFY6LelVl8tIcMjNkjb9J5isU1BX3i/4tgcmt97gCuxJZUSAQdCfPNBtZS32/6vrl13iZ50+oxD+fkJxHjQ8hBPzgQ9vanv+z28fg2Q/adKdmwSey13hF9DvNR58Da5GZq5psvY6QbYYwrWLeNMG4Xyf2CNPt/D0POezw41beXO8YmbD5R4soZ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twnHNk3qguz0wGNcNaT0Cj+Id16B5aBBxg4oMCk9CnY=;
 b=H9KLlYyAjUN5YTm7EDoilQTrtsqiiWJPA6apeAdXMX6HhO4PSyIoPwTgTzd0P7IT/MuxOELQz2ErbFfKbcrMJ/shADAlLmjB2FvGaAMv7bN43kaUgKjZrQcU6/7Ew98+xyWDw4gNYZVV1BSQnyThNwoZB76hNai06HhsBCTYHxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by MW4PR12MB6952.namprd12.prod.outlook.com (2603:10b6:303:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Thu, 24 Oct
 2024 11:56:35 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%6]) with mapi id 15.20.8048.018; Thu, 24 Oct 2024
 11:56:35 +0000
Date: Thu, 24 Oct 2024 13:56:28 +0200
From: Robert Richter <rrichter@amd.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: ira.weiny@intel.com, Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Gregory Price <gourry@gourry.net>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 0/6] cxl: Initialization and shutdown fixes
Message-ID: <Zxo17JriBZ-cPPMl@rric.localdomain>
References: <172964779333.81806.8852577918216421011.stgit@dwillia2-xfh.jf.intel.com>
 <Zxj2J6h8v788Vhxh@rric.localdomain>
 <67195ddc7888d_4bc22941c@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67195ddc7888d_4bc22941c@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: FR4P281CA0372.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::18) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|MW4PR12MB6952:EE_
X-MS-Office365-Filtering-Correlation-Id: 12566a10-e220-4df3-127f-08dcf422e8c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?74jAU+AWgTaMi49Llhg/J4HRDGeUuoRUuqIBeVyBtseCudI2Ntc9gMKWnRAu?=
 =?us-ascii?Q?OBSeWKNt/qCdNYouNToP+CGr7715F18I0+opovT9ibP/QySVZ8aPKSX/W8on?=
 =?us-ascii?Q?r92/20VSdaqv73VTIRD3lDC9IKDFTAglWMzhekToz/uy+5LyJGi+kjgq2riy?=
 =?us-ascii?Q?xUa41OR0mC5cJct+eyHu4xjAA8xIAmX4+9qLF1pN7iu/7Imrl+mkzymru4IV?=
 =?us-ascii?Q?DPxjDwtnd+ly6vYo2rxoYf8dPUZCuc+IomYhMkK7TSmu1dXijkFDitzIiQ6J?=
 =?us-ascii?Q?CTbTrDwkbfAZLEfBrpD1AtXVvoC85BkjL+YpyGxE4YAMIlK61fYP6aL6PKMx?=
 =?us-ascii?Q?3XjKXRKaRuAR74Oltn82zV7/dR+/Mu+uTZnOft3sJ2Ii2v1dNlymoW+6Jl4l?=
 =?us-ascii?Q?yYgPY7aN7MnrTmZ63ugSbFkSWLUr+dE1VjvGyjoCGJZI+E5hx0qibOhY2RiX?=
 =?us-ascii?Q?DMSVLUSEWqJD3J+nbuPr422qYv8abawkTGYYedn84HVNv6MLHvbuHgXOvkMR?=
 =?us-ascii?Q?4yNAMmzlRgJW8YIT+T6l7THvX/ZItqkZBQk4SvBmnPcYZkWCeRXll80yvYAS?=
 =?us-ascii?Q?kQ2AVzuf6VRRgWXEIgv49eGvzkfjoOlEFYYIrFKB1Y5YnuclUd9BCE4vu9jY?=
 =?us-ascii?Q?YBDNKB9OcOQEb13djytB4+jNEpJnjh+xY24xhewuX+QmN6VR2jwjLOY2e4Pw?=
 =?us-ascii?Q?jIk7+PXChlYFYmEEBLqdWHwOfzl2iPCCHAELuT+8cKasQJR9wnY/vVhDKcYn?=
 =?us-ascii?Q?PXiRp1V23gGrvuYN8oNmEP/EUyDwS3UmBGJnxN32/j1sYFug+ZUyUtmzAX3R?=
 =?us-ascii?Q?TiYIroMLRtJ/0dNj5FTs44SYYGYDo+3DWz+WecS+odebMmiesoP/hJGSrn8q?=
 =?us-ascii?Q?pdq32CzFNNGUVddVOrzicX9L+XC/8oy9h1nb1nF4ck6Cq06UvfrL/Sc81rul?=
 =?us-ascii?Q?w/Zi2R1JTGFh/bTikHQAhVaE9C+YGdaXYoa7yq/AwsFoOW9V8eGoVdErm0FN?=
 =?us-ascii?Q?vTI3ADnzfD5JS8kdaxor5arSIQgX14AhvIJapr4zzYHtDO/WPzNMRNycLZ66?=
 =?us-ascii?Q?+l2geep3ULF2JJuW7ACgbD+hw8SmzsuTce26xm+KyKvXHOYI0z0bXihOFY+M?=
 =?us-ascii?Q?RSPlLUZUzJY3DaevG04az9CUmfHz9hz5jUrPVlTmyAHblh4u+DhS8kdLMF9I?=
 =?us-ascii?Q?7TbsgvF280tF5z8hUIxfKj4f/WARQ4MqGzK1LSakc4X3Z1s5iYM/dhhsFd3A?=
 =?us-ascii?Q?/8jZyd2q98fvhOg2iCBujHdOswAkmepmfZKXMR/OOk8xiJzSlpD1brW2Ztzx?=
 =?us-ascii?Q?RH264dwlbhvF7AysY1C0tHzi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?meivFbg/6Bb/uqyi7PT+XOviLPeO9RqcPAENTpDP0+EdrmxDT3Rx+d0Ej93Y?=
 =?us-ascii?Q?BkSZikL9b8Ldc6KsBN0wfCMDy5eM7Yf+mDSXqyaCj1+niqL+GW7NXgdACL7J?=
 =?us-ascii?Q?B29As/EYlxKMI9f1FiwGEze+5HmxAOvQsL2n7V9GoirQkKPdBFnXqz6sBOoc?=
 =?us-ascii?Q?0gwvSQVe47Yjx+QVuvpUwWEKLqD0YrnP9OXd+Tyh16fMNAMx7yH/B09emO0Q?=
 =?us-ascii?Q?5yJTRMEoYiBr1skzkoyxGj4W4CV06ETaP+MRDpCmn7Chw+V9nqSLwjW8tluy?=
 =?us-ascii?Q?X+QN3qCmAOp0AIng5XsyExMokbdgorjiX7jkvtCbX6srtfp0O76w0naADeg9?=
 =?us-ascii?Q?0ZKxEPL2Hqr39/jlIT1SAyMqV9Z1hirafMc0+oQfHLsXmlGSuXOpbIZv/N3Q?=
 =?us-ascii?Q?EHzyTG8P71IQXSrBxLzfmEud9CGuQ8FtQmRCiI9JyL/T5HW0DLDHrKUaxmY/?=
 =?us-ascii?Q?VxAffn8HMxH1nLLysMk3gKDwGAhqt6uJN4KiVrjUmDbuur1RcrzmtoIXogh3?=
 =?us-ascii?Q?9fELRv9z0VY8Few1z6npnO4npgwvucKcog+pWNPAwGxCdBIvELi/unKvju/M?=
 =?us-ascii?Q?k7p8FUkGzxzrpxpxr1DO2SYC2JaeYGFf6OabDTK2W92IZHX4gPVNerynIYHX?=
 =?us-ascii?Q?iBZxGPfigXNqNn/4g2TkuOnwMsthwQI1vAag+CAXTVQ/za8PSVhqDYVcfBju?=
 =?us-ascii?Q?vm+wqTulEmK68iqTgqhwp6IgrKp3o3YvGX9q5obVLw6rRr+ZmjdQiSMerwlD?=
 =?us-ascii?Q?K/jn0d471UIiGqXyGhF8LUzV2LefTgs0iM0sc/RzVx5q3NbRtlMYIOQdxBUU?=
 =?us-ascii?Q?wd64PaWHnIBpQUcTkTP9319ZkOn6EhJGnD66iNkdSlJVkqHIqzxCN2t78mYm?=
 =?us-ascii?Q?AI3wkL/y/RZAhTw6T8IrUJNTsNt/Lt7R/f/DbA7Mx5WFWkzvqTHIv+tg5GQv?=
 =?us-ascii?Q?E2PE7LHGMitRqB9oa7JIC+o8r1cfDpnTAoqXByCdxS7vLif8gxOazbqUGn27?=
 =?us-ascii?Q?mPhgANS0a0xn96Jw8KCtzNgOJ+TdkZFvwH91HubkeCVbWUggc10I2OetKhGG?=
 =?us-ascii?Q?ErggLxTx+Lw8Fi/E/YBxok3IrlniHFyvQ1fJXLlvg1dEMJ4yQ8oyagaNwm6t?=
 =?us-ascii?Q?2S2/5iB56RzoGjkjPuGfQXgoAKzOn3YQ8/PrmAbBWm/aemkLsgZtd44PsT8v?=
 =?us-ascii?Q?VGxn8k21N25iwEopMIflCjuntVGfyN/hVV+1x2Ymxv7moy3Kxlh8f+8K7lCs?=
 =?us-ascii?Q?cA1z8Vau7RPV2UkTshZn1HfzvY7Tfz6bueW/0zifjYNzVR6vvg+FtmUgV6Mk?=
 =?us-ascii?Q?nzMskXw8QGA7VPdZ+CKhnYdbTp+IXKb8D0JkdcTzcDecDX/wDOwDbbzkpyoV?=
 =?us-ascii?Q?vCNla3Nd4dresB18dzqZXCQCxTHdzOOq2GEuqzAhHsx1ItnidDM6fTSRJUtC?=
 =?us-ascii?Q?OugNXl4f1RhBmcJxEyyVWIOdhvL5lZM/yOKCb2fvmCsTr3WdNSBfmXBkVOIZ?=
 =?us-ascii?Q?KUaUPzczm6AEwNGZgidnkn/RMsoBXTqPkuz9eWtINFCEMUX82IJOIzcRYVHm?=
 =?us-ascii?Q?XMVtIq6kuTS38dcJ6xw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12566a10-e220-4df3-127f-08dcf422e8c5
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 11:56:35.2603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZGVwOpt2y8V2VZD1VI+9j17Cl/ufVy1/wNEPvTyAn03dpfMM10FHZG2QpYK96X3Pl/pQPR4UJgH64iNRyP8DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6952

On 23.10.24 13:34:36, Dan Williams wrote:
> Robert Richter wrote:

> >  	if (p->state < CXL_CONFIG_COMMIT) {
> > -		dev_dbg(&cxlr->dev, "config state: %d\n", p->state);
> > -		rc = -ENXIO;
> > +		rc = dev_err_probe(&cxlr->dev, -EPROBE_DEFER,
> > +				"region config state: %d\n", p->state);
> 
> I would argue EPROBE_DEFER is not appropriate because there is no
> guarantee that the other members of the region show up, and if they do
> they will re-trigger probe. So "probe must be repeated until all
> endpoints were enumerated" is the case either way. I.e. either more
> endpoint arrival triggers re-probe or EPROBE_DEFER triggers extra
> redundant probing *and* still results in a probe attempts as endpoints
> arrive.
> 
> So a dev_dbg() plus -ENXIO return on uncommited region state is
> expected.

So, the region device keeps failing a probe until all endpoints are
collected. This triggered by cxl_add_to_region() after the region went
into CXL_CONFIG_COMMIT state. Looks reasonable.

The setup I was using showed various probe failures so I 'fixed' this
issue without noticing the region device was reprobed later
successfully. Thanks for explaining.

-Robert

