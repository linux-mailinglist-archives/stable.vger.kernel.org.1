Return-Path: <stable+bounces-164506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFDBB0FB17
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 21:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9004583CC9
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 19:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E82122FAF4;
	Wed, 23 Jul 2025 19:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CKUViR3l"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F3122CBE6
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 19:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753299751; cv=fail; b=aFLBsKcD60l9/QN0DCJbwAQaFwGoJyIDWeSzv76LmWwZRPYHf9mBcmTyvkwnkxznABqJwsE1+xwFb+QpSmu261D10zDQLVujQZdR48eJ+VNpXHVf1At4YNwdCRCrM21GKNU5b7ayjTtrrlw73+TTDljAsJnZjcJfSNqwKPsnkKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753299751; c=relaxed/simple;
	bh=gW7jmg0/0anl3e0MxsJv2YrQmthEla5DIah2kc4kyaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RIJEXCfHDYdg2WEKa26Dkp8EkMnzZp6N5aXpfeuR/4pETABHYNjS4X8h2AQLC/Y6CUxdktBZegfdS04IuiXftOw4YUmNYCd2eBgN/BMfCKEobrOvtUi0f/+9IS4Lb+WEkkl1a9Uk1ha9ntha+rGQH2XnO+q+mt7QMUsOwrYovk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CKUViR3l; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xcmWjht1jsp3M9PBSVy6AwlyCn/jvD812YxCVtQ0bhkYYUHvpvk4wDw283A8GHpWzp6DiOFWR5MV86U9NKSPo7KbI7c0H1TBTTG5ho5zLjsqRpZFHq1sXGBD1h3meWPEg9bCEwKQmOLUNU0tjv80l+9+EjG6SLXqZ8hAs1nF0sdPTLPQmxTq81oNfdwpGCjUulTvIMOkm02BoCev7mHDWeDjigbb+ETWNNWOkSoBaf3iw2V8LLKASkGWuX3OOHJPpLYV9xVy7vK1IT0B4FroC09m4Y/Zb378J/e1ZkNAEd3PWRVXWOb5kpqnrQQRbCXnNrRvfP07cdEl1XwJZd1K9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jt/ixpxLOs6TaKs8+SY9PNXdA4tn+XBu1Px+7me0bNk=;
 b=bCJeTK18tpqGNdIh6jTGAUoQAk8JbaXn7v3bq45bgOPav7GAzMXVYrpRfpSQFobVb5X7JH6xVPFVwRoar1//fJmw1Kx4nyZOkb67MMZm7BAqr32n8iOGFOAcCwMXspFgNUU92yClr03wsr85eFNhfhJVFiFv5De8tuYqciKsOQ0pcIkJ9iJe278UGYT8ZigZGcMhDmjPFEdstTx+hrAkfLJBCs8MB6lXbdWCckPEMkFJ9BjZQqKXNSTM+UizbUHmh6m612kcQTTlG9ZWZke+33PURlflgEqlIfym9Cogu5o268dI3/kc8rrNuKZrmz1FZPhODSuuKml31dp1iQ9lzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jt/ixpxLOs6TaKs8+SY9PNXdA4tn+XBu1Px+7me0bNk=;
 b=CKUViR3lGYsRdFHQHt7BV/EgKtZHzafvtKKLhMGXMugqQ1WsfGeJFU0XOX3l0STkxwbQwCeNrZDSlHKWoaVqPdlwqjTLa/4kD9FalzoP1qxa6COseZgYj9p+VnCFcMu6iF485WtUoPAQSDkxDLOtOlOYvK1ui+bh2bJU+wsxx7+rVeKasj/SKK5zZFgNVzSkm/vVVIeY9cEA58cqJbxsGnGPiQSZrb3QrdlB7VMh/7tIrQT8qPNiiU5NO1Uh4isLq+iUzBD6WGoIPEjec/FoDjJY8DIWQbgXpf8lVQ4O16hRhOOlsjpvMkbTowx1vx96VDBM7LP16LTjMTGQ6qAs/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8422.namprd12.prod.outlook.com (2603:10b6:208:3de::8)
 by MW6PR12MB7088.namprd12.prod.outlook.com (2603:10b6:303:238::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 19:42:23 +0000
Received: from IA0PR12MB8422.namprd12.prod.outlook.com
 ([fe80::50d8:c62d:5338:5650]) by IA0PR12MB8422.namprd12.prod.outlook.com
 ([fe80::50d8:c62d:5338:5650%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 19:42:22 +0000
Date: Wed, 23 Jul 2025 14:42:19 -0500
From: Daniel Dadap <ddadap@nvidia.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 5.15.y] ALSA: hda: Add missing NVIDIA HDA codec IDs
Message-ID: <aIE7GwYNZw2n74ko@ddadap-lakeline.nvidia.com>
References: <2025071244-canon-whacky-600c@gregkh>
 <20250723141042.1090223-1-sashal@kernel.org>
 <aIER3X-61j_VVKkr@ddadap-lakeline.nvidia.com>
 <aIEonpWtKY_hy9T7@lappy>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIEonpWtKY_hy9T7@lappy>
X-ClientProxiedBy: BYAPR07CA0079.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::20) To IA0PR12MB8422.namprd12.prod.outlook.com
 (2603:10b6:208:3de::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8422:EE_|MW6PR12MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: afcc2864-89f6-4dfa-9654-08ddca210b1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fuwotGqG/tjgCmYDVKnvkYeJDLKMusZ85jkaL8U7sa4OtMiYfbWKwObxqNgw?=
 =?us-ascii?Q?33JVXXmhggLysUTAT+H3zseZLr/2hQm5xrZnYWj/PH+fgPYYzfp75+OBm0Bk?=
 =?us-ascii?Q?vdUqhpJjiyjUjUPBCrPR+90XQRaX+MqLu3kU/3BJbIBu59IqDNtRq3oEef7w?=
 =?us-ascii?Q?Nc74DgkP35BFvxK0n3I8Hn1uNEQrz8d7QVPrIUu79FIMUH349eVUajLFOmys?=
 =?us-ascii?Q?UA5i+tnVJh/yJxK5cFdUtr/IIaIsRN0RMST0oqMsjUryj6/Pbyoi6/hJGcrv?=
 =?us-ascii?Q?DAdCH/bVNj8uq+nCvSEs84UvM+ch3482pbzG9oFDINmxIcXgoM6h2OcVLmgU?=
 =?us-ascii?Q?UhvijbKT3JVg0ATsKmowSRQB3fUL/FKpmtqatq8l9VeazlGmm9YO3ZjaGv65?=
 =?us-ascii?Q?yDc2/IQkal8N3qCJfsq857B4TKHFEmMms5IMwRSVSmIra4YatCICYEk+gSgl?=
 =?us-ascii?Q?2pDqbO4f+kgOZv+9ewb4C7Ye3uhuQkoHl+536B0Uedc9Kz3gzwQXaBxXvcia?=
 =?us-ascii?Q?xlfGnP4a8KEMUewgEbStGGMWv2hnb/Ir3Ty5ZzooRNIM8xzoq7gDnkxb7wHj?=
 =?us-ascii?Q?u6j9w9WWUvrXf56FkG1QzFWB/iN/D3UcGKd+KxjiXsVPlPCKiFoxbXGHrAFU?=
 =?us-ascii?Q?zMSROLbUUhirUKESECAu/7V5+q0FFeJQNrh1B7g0ecTMwHGl//YdRMajQZML?=
 =?us-ascii?Q?An7w2gm+IpF1nZAUtysiDPJcQARWo/g+B2qMzYqBr4Obey5/N3MAKuOADRJV?=
 =?us-ascii?Q?QnUU8H7NSfGZT3fH7Nnk//nAtmsAOMf4vSP9/OpVDi8irHlAezpvQQYGxrxd?=
 =?us-ascii?Q?aAiI5IFXZ/H8pD27TCu3Q+574FfFUG+cENYQLdorN7BHVEP335FUtu91TWaQ?=
 =?us-ascii?Q?3FcylV8zTaWBTmdWl8EqydcFn4/qFxrOm8Q42/1zt9QE12VzW9gCjv4XZRZX?=
 =?us-ascii?Q?/2dpwehy1PL7Wpk8DkirG6AvKew/3ZkXOqvyJNzw9+TxtqsyurQcWpFwHbaZ?=
 =?us-ascii?Q?m0NQnQ5ZyRkTLtZaabFkAfPWmiDQejTX9uMpvnKjB3FtZ3rf1fhNWWHk7LJn?=
 =?us-ascii?Q?8YAbHnW4ACAiHzbCSD8PL9OHlg9IpsFo714y8nAgXwMyo20IkpxRdIU67RPx?=
 =?us-ascii?Q?2FGjxRmO3DVhb1PixIBm4LgJZWLCMFvO7GYX9Ag073nzxv2ssLaL9pmXeksR?=
 =?us-ascii?Q?e0Dxf9Pkusi0E7IPXAIIqCYSj06KUoRKAPy9c51ok9mywXXqsQ9PsIAS1OlU?=
 =?us-ascii?Q?9NMWURzhiT+ZKRg6wjIYvIUldDWeWT9TKi1hRziP4Z8pxqB5oTKwdRgVLf1H?=
 =?us-ascii?Q?31Xd1z0vJ+Ln6bl0oZSPGbEWWG4dqJSud4a0Tl54rXc8flvyoxUmULcJO0mX?=
 =?us-ascii?Q?3irHR0YXKLoDFVKN68k4oybAVxT5QCkky99Pds4ow/JseNJsa7lN9owb3QfC?=
 =?us-ascii?Q?iXAAepHRFp4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mkTCi7weHMnkAzu1fR0Ft+q11j7de8H1LirwUehi9joGKicS1VMSETaYIIkF?=
 =?us-ascii?Q?QjOuhtGKIuZsyDnii4W5gOyKxp/Tb3EQfhUKHLqOWu3BxEKUmcGs4sO08ae+?=
 =?us-ascii?Q?yqm4VgKwMVavrlbI/6BtniHCSYM0+igNBa6x1ED0UTcDxAC2YejvCgPmDk4B?=
 =?us-ascii?Q?f+iXJWW8HOxfsd9KQJ+r8VsBfqvUn1PCw5u0rE9uGPAQsrrNhp2TOlRLapjh?=
 =?us-ascii?Q?VWuVP4G9//U1SowNhapq1r9ShD0Ew45qaKsjFiJNBj6WnrI/HBDUqssJMbQ3?=
 =?us-ascii?Q?+9jLlll2cVniAlvC2Q9MjrLzokA1oKIPDifTkeA7URWopYOlNma0GH+A77V6?=
 =?us-ascii?Q?OVPylMo0ESGeB8hLgQmLqOxDOucOfBo5ae0zVc3Ltbd0bytblthsa4BTyBo8?=
 =?us-ascii?Q?kPNQvhz8Uf5Hv7yVpWzs0dXmAGiDBvAK5zYW5gzAtEpk0sj/zMUNulSb5K8r?=
 =?us-ascii?Q?eQu3mYYjrMh3ZV7kshjSkdawAv8EeU2QkQ4jDL2gEaQK8/05nuppe2xmehTA?=
 =?us-ascii?Q?FoB1rtI87BenqsryhinK7A0Mo0RBRbULk8plIsx2uvQ9bJ7GZ7pl0RMtZECF?=
 =?us-ascii?Q?likh2XQJ4LzETMidIR8ani8HaX7375bqkKs3CHpxwrSzASYgkfZhh6+tNsiL?=
 =?us-ascii?Q?D2wYpAAA4o5CBTrwjcgdZuOwEZ+Q+TEcUSvqbyDdEcJc/lfVGT0+QpG2M5QP?=
 =?us-ascii?Q?4/lI7IaLb/6o4cZLOLiyk6F2pDAbjKRvVd1r6zbqSnZcTPUbjVIRLbOoTfko?=
 =?us-ascii?Q?9ktksGS/DKs0c0f+Bts9EdlrD6FS0nWwQyEZmlKb85bUGB9LOuwjLAAyWGpv?=
 =?us-ascii?Q?xkq2uRpZ1Cima/GHieoNDNVnLZjIFw4p/qXGYAeyGMWjc5FwgEA07XC47OKf?=
 =?us-ascii?Q?RI8+IIPtGQBjfv1laFKo3Z6RPJSWnaR/Y4t7qolQKDBjn+06IJ/4EWvL+uFV?=
 =?us-ascii?Q?pplkUNmxeuFRuFyDS2hSF4OglS3PEqHCcwfMTqRj9iPe0HHEdfwqklyT2pGv?=
 =?us-ascii?Q?XzYsRKbkTy+CFZb1rpqsFXX+uS9c3Dav8KRomuSOPEtBaBicv9Y6kinySII1?=
 =?us-ascii?Q?raiANlxGF7l3sc58mEL2nb17Oy5oriDCrzZKTbJ+GjlPJFHhFgMj2bAOfuGr?=
 =?us-ascii?Q?14LgwAQNVAmxpJO16D5QgsM9GwBpcnQeVBRrQ5cQiNoSD18aovsnxhK5w8Yi?=
 =?us-ascii?Q?N0sYk2fEDIfngUk+ES3a48fqRcZ2yfwrx+DSYM8R56hPzkbtTS4YjLY+1ED0?=
 =?us-ascii?Q?5kL+4Pyefq7zK1SN1Vy3xPxBEiWiGoST63cxJdj8el0oDLhW/fT1aNEobThn?=
 =?us-ascii?Q?ZpBa2b7rblDTQ/IlFvivlQOhMfi2gJfFP4V1+gZhX6CRbyHL5E6vw9WfB9CO?=
 =?us-ascii?Q?PxK0bos8JPpPXkIMj+wRi7sr6rbJHBAQtC9YnZEEEqbElUALPBDKKXsrfI5L?=
 =?us-ascii?Q?n6HTWqNqLDIzPyrnl/IV4EWlUq84mCUnlQjWQt8aBDPTddPho8TWMGeiBHya?=
 =?us-ascii?Q?TvNZYRTSvPcJpuZZ1SFL0Adv9ib8rWC6TMSKdMlZZoBhwGqZzmHkrEkPD8s7?=
 =?us-ascii?Q?CVVetcGAnXFHdOy1BVEUuG8rdIgKzq+uat0YcNlG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afcc2864-89f6-4dfa-9654-08ddca210b1a
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8422.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 19:42:22.7013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A41v+cj9U0Becq5GpXNZpJnHnv8A2497VFw8UPW6BMvWMBjk2Xx4cxNZ3FtGZt7JfkvbE/fGvqg9AnL2WTIr8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7088

On Wed, Jul 23, 2025 at 02:23:26PM -0400, Sasha Levin wrote:
> On Wed, Jul 23, 2025 at 11:46:21AM -0500, Daniel Dadap wrote:
> > On Wed, Jul 23, 2025 at 10:10:42AM -0400, Sasha Levin wrote:
> > > From: Daniel Dadap <ddadap@nvidia.com>
> > > 
> > > [ Upstream commit e0a911ac86857a73182edde9e50d9b4b949b7f01 ]
> > > 
> > > Add codec IDs for several NVIDIA products with HDA controllers to the
> > > snd_hda_id_hdmi[] patch table.
> > > 
> > > Signed-off-by: Daniel Dadap <ddadap@nvidia.com>
> > > Cc: <stable@vger.kernel.org>
> > > Link: https://patch.msgid.link/aF24rqwMKFWoHu12@ddadap-lakeline.nvidia.com
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > [ change patch_tegra234_hdmi function calls to patch_tegra_hdmi ]
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > ---
> > >  sound/pci/hda/patch_hdmi.c | 19 +++++++++++++++++++
> > >  1 file changed, 19 insertions(+)
> > > 
> > > diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> > > index 81025d45306d3..fcd7d94afc5d5 100644
> > > --- a/sound/pci/hda/patch_hdmi.c
> > > +++ b/sound/pci/hda/patch_hdmi.c
> > > @@ -4364,6 +4364,8 @@ HDA_CODEC_ENTRY(0x10de002d, "Tegra186 HDMI/DP0", patch_tegra_hdmi),
> > >  HDA_CODEC_ENTRY(0x10de002e, "Tegra186 HDMI/DP1", patch_tegra_hdmi),
> > >  HDA_CODEC_ENTRY(0x10de002f, "Tegra194 HDMI/DP2", patch_tegra_hdmi),
> > >  HDA_CODEC_ENTRY(0x10de0030, "Tegra194 HDMI/DP3", patch_tegra_hdmi),
> > > +HDA_CODEC_ENTRY(0x10de0033, "SoC 33 HDMI/DP",	patch_tegra_hdmi),
> > > +HDA_CODEC_ENTRY(0x10de0035, "SoC 35 HDMI/DP",	patch_tegra_hdmi),
> > 
> > I tested a modified snd-hda-codec-hdmi.ko which patched one of these to
> > patch_tegra_hdmi instead of patch_tegra234_hdmi, and it still worked
> > correctly as far as I could tell with a few brief checks. However, it
> > seems like patch_nvhdmi might be a better match, at least based on how
> > it seems to behave with DP MST, so if we don't decide to drop the codec
> > entries for 0x10de0033 and 0x10de0035 in the older branches it might be
> > good to use patch_nvhdmi.
> 
> Hmm...
> 
> I've used patch_tegra_hdmi because from my understanding of the code,
> Tegra SoCs require explicit format notification through NVIDIA AFG
> scratch registers. The key mechanism is in tegra_hdmi_set_format() which
> writes the HDA format to NVIDIA_SET_SCRATCH0_BYTE[0-1] and toggles
> NVIDIA_SCRATCH_VALID (bit 30) in NVIDIA_SET_SCRATCH0_BYTE3.
> 
> patch_nvhdmi doesn't seem to deal with this at all.

Hmm. The HDA does manage to work with both patch_nvhdmi and the generic
HDMI patch functions on this system, but I'm not sure if that's because
it doesn't need the explicit notification, or if I just hadn't exercised
changing the format from the default.

> 
> > It probably does make more sense to drop the SoC codec entries for the
> > backports, the more I think about it. It makes sense to backport dGPU
> > codec entries since somebody could put an add-in-board into an existing
> > system running an LTS kernel, but for new SoCs you'd want the kernel to
> > be recent enough to support all of the hardware on the system. Notably,
> > we don't seem to have backported HDA codec entries for other SoCs like
> > the T234 that patch_tegra234_hdmi was added for in the first place.
> 
> On our end we'd prefer to keep this align with upstream as much as
> possible: it will make future patches easier to apply without manual
> modifications.
> 
> If leaving them in there is harmless (and only unnecessary), I'd rather
> just leave it there.

Sounds good to me.

> 
> -- 
> Thanks,
> Sasha

