Return-Path: <stable+bounces-189232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCC7C0665A
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 15:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA7E04E1DDC
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 13:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5538B3195F1;
	Fri, 24 Oct 2025 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="brPkRdB1"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011026.outbound.protection.outlook.com [52.101.70.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781EC30F530;
	Fri, 24 Oct 2025 13:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761311273; cv=fail; b=U9pHxI4gAxxj8595G1XLuulDuP0zTMpSYgKsGoDW0IrNR/2zU9rxTu48SiXdEmJ70f14nv+/M4fj7Jz12zWfLd4ybTOJK/2cSdDh8nZNVz17b5SXi3El5LhuG/bE9dYQwWa2h5blNG2N07mX9NAUZyUdPoLN072swLoTi0+BRgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761311273; c=relaxed/simple;
	bh=W3xYJ77sYUGw2QrAR/n7wHgeOyYqQv5kbxM8uZLGIu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ina7PodfzPo8w7HeZRqCaik20r4fMRoXZ1hMsK+ZZ49bTgPiVI1qLGbG8a6+xu6pWg2BqVD16nMxNgmqN+mOCqQBNPLFZZu6vEj2R9zm3g4ERy09v4AiPUPH7Gviwcx3tP83Lzt8412V0gqpoZIy+Rzu/gV8anUwuLji5UYWtKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=brPkRdB1; arc=fail smtp.client-ip=52.101.70.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iwSprKU/UXcIKhwonuDXUs6Pi/pMYA5navuYQE9DvZGmrUvByXeWkf5xR4dnZ81rqsX2mmb1suuMGkEYKiVJOaSjge5dM4O/5gIFmF2jfUKs7UcIs7fuJ5rZQ39eiuMnC57EWaWHWkoFflogaDFu1+y5Mw1TjNL5AEvV67205BkJxp2VxHY/YxImDK0m1GdRw2LtFCYQ8/k6F4qU9+eEsuhj19y28y8JjdzSKTNbwhOHpkBYz2Y9Oik+Kr/ESoa+G9MHojeWumQ7x6DYlxdPlv5ttQqSPMTdBrwkGXt1MFtR5oFO45yo6IaF9nkYNKQ1zYy1jLYC/MJbq8b7BsLQpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8Q875ef2HBXuBAztErsbrhW3L2dCskvvAOYpXinSto=;
 b=ZU4edTqkFSTabg7rUbR5QUEQejWaYLyyq5Hof98trfY61iGqJLT0eUlxgMGQTM/Ze+3AT9x5Jxg7p5PovAOkY18Ehp6y3DoiczBp3HXMba5bBzuPW65VVzQHC7GocVUimj78dMaUSkvPeEmKUjW6hF3qt7K/bp6/yjz5gVHKJ5zXJrieszj2IvtBmeUuBbj+k4GLrseTKdNA/2948FodpOAcmjrvS2cnneYLCK9DYy5wMb44HOYfn+WltEHpZWHTyKP9yts9vE+1LBXIGnXwrBLgprRvfsS5fyhMldBqEYvDr4vk60xfxAg+P7EfzT6f/EHxxOoPa4wqb/ngJBahHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8Q875ef2HBXuBAztErsbrhW3L2dCskvvAOYpXinSto=;
 b=brPkRdB1dnpPtx8sYBg9NbvsIgQyQJuxQnliiBnaV4fMu/sHJ6ekj7V+MJc7whgRUkmhtXJjEHg/wFAOvaqN/t68vT95bgQtsCuhwvIi4nAuDKHiFgNJfdiYlolJIUG2px0Dhodv+bs4Cg76ULqYhe8FGVINV5s0Q5QWPbnsjgDrE5AuNwY2OX4OvRbo8RFCcc06tzghZK5nRkM9lZSPfFlvDNYSQW5WEejCoW7YNa7jHQGP7Gh8heXQ91saNwV9oI4pzaI87v+54xl5eybv/ga1TB/ygbdvv0bvD8pMnp6fkA9IPboloZcWR80F2vBdiHB3L1zB9N9Ct4aiIXUgnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com (2603:10a6:20b:42f::6)
 by OSKPR04MB11413.eurprd04.prod.outlook.com (2603:10a6:e10:95::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 13:07:46 +0000
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b7fe:6ce2:5e14:27dc]) by AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b7fe:6ce2:5e14:27dc%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 13:07:46 +0000
Date: Fri, 24 Oct 2025 16:07:43 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] bus: fsl-mc: fix device reference leak in
 fsl_mc_device_lookup()
Message-ID: <ywza55o3baosjwncxicrhaxiyu45wyrosqlxbxqkzl77schchw@sxfqkmr44mz6>
References: <20251023150558.890-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023150558.890-1-vulab@iscas.ac.cn>
X-ClientProxiedBy: AS4P195CA0045.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::18) To AS8PR04MB8868.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8868:EE_|OSKPR04MB11413:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a92a9b1-4975-4557-592b-08de12fe532a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|19092799006|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6cX5RhzIi0zVYuO/TZkjx14fG5d8mdmiOC1PDE+G0V7eCp31NhXLisM0UCKT?=
 =?us-ascii?Q?LsGL2WEcYTetPwdBVLtq80uEE5GO70PuvarKRM7L7IBfpLrNJ7n/2fW0pvAc?=
 =?us-ascii?Q?+bvhXQM5aSt0x3t6TdjNl8qh9dVsMYbNuMw7idohvyEV8zVpKlIVcKfYLLis?=
 =?us-ascii?Q?zhzma9OzN1/fNsSgwZ87ojIwlq4PpwMJ1T4y0GBPpbRi930IsTzwhkbXE2Qn?=
 =?us-ascii?Q?bguWMrCpkLdeYGRMiNWKtxEAm2VNxV7zGSLZebWLamzWG1GwgnUS5323Rm5+?=
 =?us-ascii?Q?82IF0RlvLA40iHYHtvj4OcnWxJksxkBKMju1WQv3hkafOhlJSqZddCXR2TzV?=
 =?us-ascii?Q?c/0YNIOiXgQXJRNxwJYPmsPRad01AsFvjsvAv1fpjNUH5I2o24sj+lF/AK83?=
 =?us-ascii?Q?MaAODGLgGvRI1/X/1doIXKWzA1/CM9/AVVDbf7MbrOrOl5nxPby7WpA9Smhq?=
 =?us-ascii?Q?RiJxXRi+jUxqTgR7vE6lMLxh3QoyjSQ0ChrHAgvwdg1GWOsF8KGSft1vzz9J?=
 =?us-ascii?Q?wpTszkx0FSv4q2EQioy0LVGkWMq/WW6nUfaySvV1qPdHOQ1geqFkMIPnJVkb?=
 =?us-ascii?Q?HxmPfq8q0uvOGDjuEgKse7N/9A2LuZ2dWpDza/LUVwZdNWMILhN4HvJiSZYV?=
 =?us-ascii?Q?BAmE01uuo3s/mfJqsA/7TkIp/NpMk5iv0pYAzl5nBQ6kTus8sHLuS4bap+Qv?=
 =?us-ascii?Q?ZH/cJf7KowuptkQ1qex18oVTwMBcIXsAdetmsVUO+fHIkF0UquWMhwFDKrjj?=
 =?us-ascii?Q?9835GRw5nbp1Hhk6Z3lB6CvoLyEB8SfhuZxIROnnVagIENwrlPr6F0FDopsR?=
 =?us-ascii?Q?5a+KEwAPTFuT+qhEE2ET6mEYEZfVmgdcTv1jxj16HdWYk5hlKsDxNwUP4oZW?=
 =?us-ascii?Q?AYY48gNgXZfoKBmW3NbBHQZiehvg0HFnlAWnZ+fZUAx666N17mAFC7F3LB7+?=
 =?us-ascii?Q?wxpx2f+JTB0CJkUBYjOqyGzxHRLGZO/92ZenQQWTU8LolU3jB2HPvj30BlJa?=
 =?us-ascii?Q?sRXj4JUA5JdU7HfQ4dJjX+kTpHxHhgJzVpIxdQuTypsZmsxJ5ctAoI9hg04X?=
 =?us-ascii?Q?RHeGTKUe51lKE4DXqjJgKRONdx2q7UFQWZnN8LrWeyHBKeGe3SNhMq0rObpQ?=
 =?us-ascii?Q?OVGu0lYLxdiZgI8r0XS9bce3XK9IvbbdEmgaAQzzDR9EDMxyKLzbF1xg8Nd/?=
 =?us-ascii?Q?y5DyRr8lwYFo+hEO1RNiAknhulPsyOarZ1KmBdmCbSWt5bW7Nz9g6Zc54y3q?=
 =?us-ascii?Q?uVNqKQCEWJJL9iYj41YezZXDHqRpAZDt+BRJy8CKfDeCBQ1BpBF/LmZ3/qzl?=
 =?us-ascii?Q?D+vmR+K6WQrY4d1MXrNd+v8rtqHysxV0foVsCAk9/s6QXt7tpcyNbatnNnRw?=
 =?us-ascii?Q?7jt5iyrLdfqICSYORnaA7UcQWp8ULD03LXlxPIkTm+Yzu2glRhCCRRol0iQM?=
 =?us-ascii?Q?NZU2dfztm2M0BR12eC7nbCSBqkX6f8HI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8868.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+GiLm53krV84OaucSH4RmeY4wiGnrsvlyvCrSUxh89fDL7Oy2OOT1aTHP9cd?=
 =?us-ascii?Q?cN1OP5142v4sMUlPJxMXRghdhg3wz7Q3YIIX8E9p94dY4jfzXBxJONUjCqjN?=
 =?us-ascii?Q?odrFnYNLjkqaQDesJld1pyc92iVMu6kW/P/CFSzIdbH7rZzKIthYF3d4Rmqr?=
 =?us-ascii?Q?ibHCNKIJkXDx11i2wt6nt+evZ2hQ6S6ZMYybKC+P7s9kmWEH2wBLgu86TTPw?=
 =?us-ascii?Q?tyL4FW+d73Cjdbme6G7H4c1Y4a1PrlXhsru7XPwaKzKCzUXufYbm1KEcytAc?=
 =?us-ascii?Q?RJvOS10bmB4rvMH2P1W5366A/oDykB7bS+V6WOzswOU05lu+SB+Rj9l/ksPl?=
 =?us-ascii?Q?II1723Pj3vvGj0WkO5xOcbWWePFk3PMKkuSUp6HEPiM5INDYtTKorTPMhyv4?=
 =?us-ascii?Q?G0P3eTl4VXKkBmNW+neALvbYEMPn3GiY8IJgjuUUeXFzLeTKuR+EsbiffKIO?=
 =?us-ascii?Q?EifYoRqgACnQCUJU5zcTGVIfA0zRyAdguRrkvxeS5vItXJ9WljqemDit7xa9?=
 =?us-ascii?Q?X8QsUE/FLRMhxH2svqFpoFc0TWy/FAnemRWboiG9eXPDuQEDrZye04j5/c9s?=
 =?us-ascii?Q?KvOASOu/XlT2mRFPvRUP+UdjdoEQ1kyXiH4YNcs03hju2G627M4BEoczvOTJ?=
 =?us-ascii?Q?2heyoar1SvVvLlr/QHCYSuK0LwB/f/6yHsjnx9gN1P4+SYf+2cyflQK03em2?=
 =?us-ascii?Q?JMY4q9zAZ52iMNPKhj/XbigIdMD8H3VFForJstBFGDO6f9B/Km47R/hEj9wW?=
 =?us-ascii?Q?qm0yk8j5Uxt8pFFh4PTAMt1N9Lk5ezuaM3WigwEyAxglmsRHN9vox+fIUvwq?=
 =?us-ascii?Q?ETYGvOxPi26JyKLSF31bxR4p254t7RkuW63cNp7Hs+Rj9iARCgQxBkbxYJaV?=
 =?us-ascii?Q?/3L1EcvNGpSP8/U0vmaaV/NGu8fB0Sg5Kvi6mgx6Yruh7LWQcVJ5pTMgc5ej?=
 =?us-ascii?Q?NLFtAglVTuiWUlfRg3pZT5X4hLfkl0/+63JVz+X6IqmyJuDFe79FnfIurI+v?=
 =?us-ascii?Q?+2X2AR03Ub7kqXZLA1hX5+/XsjjbQCjY1TpiEM8yR9a9NmXKp93+sZfWg5RG?=
 =?us-ascii?Q?B373FSf6GGMr3mdvaVQsuUQi8rp4UyyaO2es18n7czFsO6lN4ECOH0xnqlNK?=
 =?us-ascii?Q?NUJ5NzCrgcYLrjVxAUtWquDjsLYYIm0L+mRAXpCc5TBppfZLrohshrtz+8P3?=
 =?us-ascii?Q?NPfGd99TEe1ZxzG08y7jJD9Pp19QqVVutyBUHXJPsXB0GksB4H4azacGUXye?=
 =?us-ascii?Q?NjFupHFiIN8h7tlR60+S6MFpAW5jISOxdQSPTtr45w0CBS2ZXhhEC8lTD9M/?=
 =?us-ascii?Q?TcDoYkhMt8A71RrmPGJid2Uyd7gRek3TmlzPtXKuJ3xm8lr/ieMBcOkR/m+T?=
 =?us-ascii?Q?wivAOQGCsWwyrfZcK7ylo8zxQ5cXxMRdSFvKie1oTXcy5ijGygBUsRuLALu8?=
 =?us-ascii?Q?/LSlEizkibxiF1T5cH7iOKu/lVNcTbF0+gDyw79iknEZCSXQwccWKshanVtn?=
 =?us-ascii?Q?EsgbJIzEd8C7CnY9k8QNvaF5Nd0AEect33931sKMXna7WzbubfQ36T7e2kOR?=
 =?us-ascii?Q?LG/smTMjW74d0cvZi7CEEqfMUz53r40MdhuJ8YOr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a92a9b1-4975-4557-592b-08de12fe532a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8868.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 13:07:46.1458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P8GP+bn4sUYhEq7BO3TSK1TGC77Wbmxu2atdnSAstCfQTCE3ZmalwgkL01FsTqia1XJTF1vxZIYuMKpXLrr3/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11413

On Thu, Oct 23, 2025 at 11:05:58PM +0800, Wentao Liang wrote:
> The device_find_child() function calls the get_device() and returns a
> device reference that must be properly released when no longer needed.

The release should be done when no longer needed, not even before
returning the device to the caller.

> The fsl_mc_device_lookup() directly returns without releasing the
> reference via put_device().
> 
> Add the missing put_device() call to prevent reference leaks.
> 

No, the call to put_device should not be done from fsl_mc_device_lookup()
but instead from its callers when indeed the device is no longer in use.
For example, fsl_mc_obj_device_add() does call put_device().

Ioana

