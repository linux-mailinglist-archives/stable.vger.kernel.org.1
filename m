Return-Path: <stable+bounces-141845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7E7AACA57
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 18:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06FB11C28CC9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 16:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C59284670;
	Tue,  6 May 2025 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UqYZurdF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fsFWpfOJ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4927022B5B1;
	Tue,  6 May 2025 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746547246; cv=fail; b=QibS+8KzRs9fsk75LiVVozljjWI8YiobI7IClo6dA0RH3Su1B4dMKBY5cTiAOp9Gjisw5oA22czWcbU7kRYfu30hJ+RkzaPb0hy8/8NtExvJEwhrRMg1uBvInH7z68kHeAMMFdDl2tJlCnbIM5qejw+iblxtdiZx9lDIMwfVB0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746547246; c=relaxed/simple;
	bh=GVj2wbYm5apvLLFC2GdZTS2pej3G4AtnzWDaSxUJiUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uenSzWOEvJ0DU4ApgTIl6+1GKgwJuJqYEPs9j/XXAjLn4IrP3Uu8v0gDLMYnJVBhRhoLZgvCB9WXiLbFsEAjyn2EbGNIiXMstaLM7ar2LoUrs4+uMnSzKP9lk6S8mz+aHKXVi/6g9/4g0+wBR+ya37AfoXKE0+muZa3IYLDzIHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UqYZurdF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fsFWpfOJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 546Fq8q0032182;
	Tue, 6 May 2025 16:00:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=zAEH98gzx7Y8NkLSW8
	041Q7jPjn2lLEU/Ir0x6kZNRA=; b=UqYZurdFMIhhtDTF9n5Hszx6s3no6Esv1T
	EFP4rywN2tefGLhGHZcGu96Upvwwg2AhwmCMG172I/cAFRfVvTZbsFUhcas22lM/
	lFWykHJhEkYdhCq1SVCeaBXN3TRyHBnkJoutwOBVwnzcFFU6iREVKmVRnf/tAAR+
	H5hm7Xsx98mTdEGBACzeh2MAzu2G7bwGyy5XrhV4k9t6sLNzqrbp4RH6TsjxbZhz
	ZzsoC5YdvqISO+Q7gHYhPVXwymKGf6IC9kQlD48qy3KHTm6EMcvCpQ9rldE+zFoS
	TpObNSKnbU3GMCvXXWUiIbZxczwx39Tmyw9hiTynNBtQkpYTvfSQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46fnek00es-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 16:00:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 546FAj2f035632;
	Tue, 6 May 2025 16:00:34 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazlp17011024.outbound.protection.outlook.com [40.93.13.24])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kffmbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 16:00:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qfKHkK8uwuGnYsH2i2OB6mzvXKm6WzF6kypgHTQn4ICzxmbaFw/hRZnYTsBP73GQqqGorBWDiEGoVWfMsMKCMJUJj6YdqdNB1QLNAVx2GJXH6lNjrlEuX35P4opvaMZwxlvg16gmHvH2OWPcFX3vU5FmGX62c272+7MoycJu7e4Nx6WX6JY3mPWntMfqJUrn/L+mHxs4v4ziGZtmCf5XBJt23ut3bDtae5fnVEXG6UMK1+zJBLNmODHSoqiIfbpyT3aWpv+mFAf6cvE+8cVOvsQJRGJSzUQjo5oFz48XiBk81hDqOMrAzpIcKnUGZ+eSi3zC4TR+YIupSMc/r0F4Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAEH98gzx7Y8NkLSW8041Q7jPjn2lLEU/Ir0x6kZNRA=;
 b=eWovGOOduTjD9NNobMywcOBRm5N70aesp0TP4UwfW3kfGSEX7yfxGonRbUj2C14oOlM4wpCfDdjyzenuMf65A7Rsr9SUFC/Dkv1eJSL+aGoaQsUTHWst3zSj+fG059Wd550eXOhxoK1XxX3/yIXnYtYIKp758T5xe30jLfs9ZHVBkBP2DUgrAc+0LCex4X3BmovCVr1MlkaCWpdvS5vxPS/rGyAsz76Ir+fyNlRt2Db08VyqA4LPGd+A506SIpOS3o0gUTWtr5awVvmrW342MFhkQIxOa0qZFgDOMsCTlcXiq8B6zqPEE1IxEerBoniGBKaJhlXYu9bqWcuj/9DChQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAEH98gzx7Y8NkLSW8041Q7jPjn2lLEU/Ir0x6kZNRA=;
 b=fsFWpfOJFotCRMVJ7lU2h+KiRQm+DdZKDXmwqNSRJPD/gi+2XJu/ncEYSatRxXAUJ/ZqWFCW/eHNauLFdXos0jA/4HX2ohIGST8BaIIA5JS9gA5+wXck4lyjJ2UXiGfZCeRAPk2k9m/tCpYUrXqR+EWlnfuOBh0j6BrEyvLzMBQ=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CY8PR10MB6561.namprd10.prod.outlook.com (2603:10b6:930:5b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.29; Tue, 6 May
 2025 16:00:26 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 16:00:25 +0000
Date: Tue, 6 May 2025 12:00:10 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Ignacio.MorenoGonzalez@kuka.com
Cc: lorenzo.stoakes@oracle.com, akpm@linux-foundation.org,
        yang@os.amperecomputing.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: mmap: map MAP_STACK to VM_NOHUGEPAGE only if
 THP is enabled
Message-ID: <fuydpgfocdckyzql6hq2h7bfmoul4acanyswv3yappc5xsxqdu@dhpq24pybqth>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Ignacio.MorenoGonzalez@kuka.com, lorenzo.stoakes@oracle.com, akpm@linux-foundation.org, 
	yang@os.amperecomputing.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
References: <20250506-map-map_stack-to-vm_nohugepage-only-if-thp-is-enabled-v2-0-f11f0c794872@kuka.com>
 <20250506-map-map_stack-to-vm_nohugepage-only-if-thp-is-enabled-v2-1-f11f0c794872@kuka.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506-map-map_stack-to-vm_nohugepage-only-if-thp-is-enabled-v2-1-f11f0c794872@kuka.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0091.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::29) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CY8PR10MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: bf6c2ca1-d196-406b-5e42-08dd8cb71d26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ROOdwavxmHdYkbPdGOE4RbFX9Kbd3LAe1e1TCjmPXc7GpP5dmAITQfSXd+a+?=
 =?us-ascii?Q?ajpjSZbyfPAJ37Z9joa/YAcVlvf6906edds1Y+3j9JSJQnnl8c50htu3YoZA?=
 =?us-ascii?Q?J1ZQKRHymSMuNuyhcnv1kGw7ghMd0VxTzk9LLmBZo04SYYCEZXvlMO0JTxiV?=
 =?us-ascii?Q?RoDJ7cNdI+77JDoLp4PZCQFFvId/3/EiXj5CciFAcdrS+7c4iIewF6UNw8xS?=
 =?us-ascii?Q?x4zwlLUQ35s/bDAupW31XV7mhGg/KlOmbhDUg4yX5dU+hdejdECoiYQ+s7zJ?=
 =?us-ascii?Q?T3RvA5+aWybMao/y4om4TZDCDNhntwuWbMZbZnOSHP0iZmxRu5Q2vpLKFA+B?=
 =?us-ascii?Q?fKQ2+eMULCOI6gDCDspakfcdK6aJ6md5iYBpxk0gwDAgCMzwlgJQ2Xuxn+pH?=
 =?us-ascii?Q?XUu4ea4TvDVay08mFYZEeDYsvMbA2k3rULBL2PpXaMhtb3uA5C+6HpGJEa9h?=
 =?us-ascii?Q?OCpKTIc46VoBGEnCONYZuZe+CtCZHos9sOera5ZwM/YsDACm0qOvlzwl7dLl?=
 =?us-ascii?Q?HUK1XQx8ZOJYu+BzdQWHZ12WO/TLnMba8LzG7QqgUzOXjMPppYCgoO/hdyz6?=
 =?us-ascii?Q?YDvWMR6wQ3zqswMUMSWEuSHNR6wTjVIWGaWIsyam3++hy3ieNOCfVITJPCuG?=
 =?us-ascii?Q?xbIX4h4IFhUdJz/1TfCQPNUT+TiaTmigL7Uwafem/wRmfJPjJkrh414idyIC?=
 =?us-ascii?Q?ZfvPVmOh3DsMphdXQlPnjk3dut94j83pphWtBRlY66HaTL4OZ5Go7zNFaplw?=
 =?us-ascii?Q?mIhsSP7fCKpkPJ2bLM4MKVMSGIyu9ojXMTw/40hd2epdBKmNKwxyv+ANvROX?=
 =?us-ascii?Q?WUGYERd/MHS2kka7Yb8cSynjkU8j0wAZiTEs2uZn4SqW95QkLcE2keqZBdrH?=
 =?us-ascii?Q?osU9TGuc30kQAF7LNblHxQ5jXL37WjZjQ/4UElzxdw30ghNYapVtShuZ3QDC?=
 =?us-ascii?Q?59yygl/sZcpl+AhFfEExrkmWqpJ8eq81byQKGNXfpjW70rqbQMHgGy11DlDS?=
 =?us-ascii?Q?cuyVZPnyv5FaAcAt0Ge4Ax1XX+Y/l8uC2pm5kMsiRbE5X9LGUahNPs3E23Vy?=
 =?us-ascii?Q?cLY+o229FZ+zt7y2mu8+cdPW71T0C2BPHHvMbGw4D+ALP76+tHwDUN7NXHYV?=
 =?us-ascii?Q?lqXV4dyVrMSs11SyqTAUffyKA6BZWWRM8U2ToXCw+JbmK6ShPOxji9/i1Y3J?=
 =?us-ascii?Q?HLegc+D99moPtlowWrydRn8AA9keDTdtEr0XvwasRMMXpOjLvVhXp8WB7R6J?=
 =?us-ascii?Q?lpxO/kRhJK+IEdCCqXsq90wXTxPPlg3rTeFYGwO5bFf63OJfJwp7iy/uCEE5?=
 =?us-ascii?Q?gHXvIKWGpqQSf9/2vutz51cV+F1rgwGvgkFS8n9fKUCKEyHCut5JHUV8Auy4?=
 =?us-ascii?Q?4Jo09k57BsMKsJYRYH+zGKFWzRiS9UiPYW+sJR/7a4yrT94UDV56ax5ocO9G?=
 =?us-ascii?Q?OFa8wpaSsk8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8JAS6D4AL/9Qxo79Xc7S4SDMWnQNy3roqzu1xYDtdkhRU/IETt7GfO5DEifB?=
 =?us-ascii?Q?h7LlWbCovOu1KdZE4T1VDvCDVX0YY//nvp4ywV6h7I0TfG1mpVZwIPk8qsFr?=
 =?us-ascii?Q?cB01nhk6CxWwtyDOi0KmuLNz/q23fIvQ//tmsZ57HFm8OArykOAXaELfec6x?=
 =?us-ascii?Q?vTzRkoa2/K/NlSR2j1Z43l2UAlrs79vIWA7A8qA5RuQVLbZwsuiHewSp7Ri/?=
 =?us-ascii?Q?xcA/FZqk7h3IF2r1A+TCEQCYqQYE8mO2wt7nzw//CNvRUKgNWe5otdk06pVM?=
 =?us-ascii?Q?HNyGs3Y0wKv4kSWm9paNiX2px0+0V6lzx162eef2ny5O6dibhnchfSS++HaS?=
 =?us-ascii?Q?KGzxZZWjBT+jyHgrvJFSm2sycXttdRNRwhSho1LMOlkvGxwC9679oBEjO0wl?=
 =?us-ascii?Q?4Wy9SE0q+2NXX5bczArVyHCN8xGATdkkmtPjBkSbbYa/GsoEhmHRqiE+KQqH?=
 =?us-ascii?Q?lgjNKNx3qQ4Xfv1n84Ia4mbCq5ha4uOI+P4/gOD2WyO+4OeI7YSQqBNEEYQu?=
 =?us-ascii?Q?ob4XUqJ/wgo5gCzsqID4YbXHLzGLLKkdxX/UCiNvcJlamRX1dgbZ6/KDyYs5?=
 =?us-ascii?Q?kYd++TEo++G7SMLH7MvVAj+TuosPm8xwBxA1HQXHigcF6Aj5ahok15U1GTOh?=
 =?us-ascii?Q?Twl5tTpcKB3j5c/GZZnrKCXE6EvV2hF/FiDNvf5E+eGTghwbMWJKChNLV+Bf?=
 =?us-ascii?Q?fw2ZOw3RmPgqJ7HWL2pG0GcWnP8UlQxYdovFDE93pCrs0puuwvF05LQ20d1G?=
 =?us-ascii?Q?KRxl/ZhrsmVg0OmrWieQTlS3PNWzdaHOWHybs2ATsLnijkS70SUTqSbI9GB8?=
 =?us-ascii?Q?s5MUe20cfEMNlP+KcMXwKYBv7wrkP4n0TkNMyBgLDAY677aqV2HW3DhbmyAc?=
 =?us-ascii?Q?o7Dvq1tDTU3MQt8K+Cyjc9Ndqbi79SXnnpWL7MAUn1Sju+YJOzDHCMUlnF4K?=
 =?us-ascii?Q?G4TqKgOi3hr5SZ4/iqXkMRmG9EDkM7voghMbo5fG8J0IB/d1mMf2QUQ0vhth?=
 =?us-ascii?Q?rl0GW0ggA+9ieFtk8N0xd78MYV20UlrmVuGr5L7o+PurQaClpumcFYs5Wmyl?=
 =?us-ascii?Q?GrSEs7Q2faIRdqZF2rDbx07l9qVWdislDHHGzjUAXuQju/JADyZlOkuy/5gC?=
 =?us-ascii?Q?gWtrI8cIOn9NOeolpPmiiHOMpfwqYHr5+KuXcQp9evnsIWAFKXqLCq7czz/L?=
 =?us-ascii?Q?78USX8iQ+VdRKLy0oAkHnwWLk/Ag70NkJYsQyWlopDDWD4BRFOxGdGsqX0Im?=
 =?us-ascii?Q?EGBMaaZK4eFPUUO1jEbPOIToeYyF3qHs3vKKI1sxkMoFWezBO0wKLWbHH1Yw?=
 =?us-ascii?Q?bT4INoDwWqj9E8IBnyV70Ws9XlCOyRn0KUU4AI4CLwXmcWLJhjObjI6Ie/os?=
 =?us-ascii?Q?4QnQ/Bm7PusF4qQ92AeBsflRC2YBuY+ageTYQvS+KeNc3uCXd7lGaGOqIS8k?=
 =?us-ascii?Q?66hurY6YPHOyNbxI7ga9FIVTwZFmghbXXEM+5V9e2SmseATdJGEDt6QwMRUn?=
 =?us-ascii?Q?xiJoilzG2HDRDYRjiJJBn1nVxKD1DAB9r2k8RHWKI2owk5gTavPUk2XyHe0k?=
 =?us-ascii?Q?0Z40yfikZlrMYR97s1IgRi3CGJpmZ4dQdVZrzrkH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9T4CDLt5fXckI9aNRqRo2TeDXlK7KVBJ66WHdVQn6Ngh6Zg9QxS3aHksHQ0RTI3whRWn2giwWiGCBkIVD5sy14VjEU6+VRNQ518D+A4lJKzhPOwDKn9JV34b1sp5IJHTFX5nWRUfIyga9yYqGcVfjhwQ7rDmq5mIKy9a6VN6vW/etaG+WGoRBnkmgMY6Vuy4pF7RpxMUppIP58/6Knxj/TJ+rCwIi1gZOXWgjmeqwEjhCBV0bNsnHVtH6n9pl0geF9jAfu8d6B3VNlLv94gxP3KxQPfiBWlu3sMpCyFOG9OI3UZMqih/Q17RlBiuyASH05Mz4N+8NDGB97uNCfoQ47QuwWHlC42zc/9eajc2MODvoWh7G6OEXxuk6HJ+ithm7Gzc6jXl+k2gkx7s9F7p6mlJ2aXvspaA6lOeTuUCDMOWJfZ+u+2mPQlozTiBI7ovAZz+Nv5PDjDO2N6eOUgrj/bt3Le5LzpHOgnRtR7r60MqretyjN2NHcKfzJyg/5faIlHucebE8D2P59JUyVhXbHHMwjyDIO/fsYnRwdKmtym6XOa0x9r2hM2Mc5x01Y3o6LjyWUd02ZKNpswYe0ULywAKIorU/tWaigems11HHi8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6c2ca1-d196-406b-5e42-08dd8cb71d26
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 16:00:25.4222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXy2N0/6XNIKj4g4dLZFbyOeJYY28moZIhSV2bFyUVR5m9gWmuwCwxAAW4JItFRG1aHrOR0uE6iZm5foiu7b5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6561
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_07,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505060153
X-Authority-Analysis: v=2.4 cv=CfQI5Krl c=1 sm=1 tr=0 ts=681a3223 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=TAZUD9gdAAAA:8 a=yPCof4ZbAAAA:8 a=vzhER2c_AAAA:8 a=AIV7JYKxGoLyEOIUsiUA:9 a=CjuIK1q_8ugA:10 a=f1lSKsbWiCfrRWj5-Iac:22 a=0YTRHmU2iG2pZC6F1fw2:22 cc=ntf
 awl=host:13130
X-Proofpoint-ORIG-GUID: G4RC_LlLT6atrRKTMKStHHx4lGP-DG5Q
X-Proofpoint-GUID: G4RC_LlLT6atrRKTMKStHHx4lGP-DG5Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDE1MyBTYWx0ZWRfX9fiC/9QgDlbq iX9twyLLKQmBxmE+jql8xkv9iV/pK5ogQIDGW9GcAFpkjGgXbcYSbfmsSMeptawbzs4z7FiZMcx aP4SahVMoD5KsA/8iqhc28RuWmPiRmbobX6pkNGPOo5up7dWPVb0RcBSqOXa+8dJot+khKTwmWU
 acC5dYc5Gx5WcjMw2uUspWfrZxNfZoLy8ahNgpj/IzLz4mBHDMyC5RHUjrvvKpNFqCqAGjx3kcb SOGlnUNHqPeoLhzKeVc5Ozr06obPnpneJqqpYzu4Z4C78yy3aCGxOKWFRv8NVyygjheWeBBHuwL 2A8MgHi6JehmCAf+cUUvk9CtIbACbFfIAte3+lP3Jexoht5TmO/RvJOLNmZm/tiElJ6FG2JdHtr
 rUgq5DcXj24WmC7iTIvDCsUI7JcxmvQ8jlByb/lJJSiBgsZrd7PKF6cnjbhx0gRhfpmBK2l3

* Ignacio Moreno Gonzalez via B4 Relay <devnull+Ignacio.MorenoGonzalez.kuka.com@kernel.org> [250506 09:44]:
> From: Ignacio Moreno Gonzalez <Ignacio.MorenoGonzalez@kuka.com>
> 
> commit c4608d1bf7c6 ("mm: mmap: map MAP_STACK to VM_NOHUGEPAGE") maps
> the mmap option MAP_STACK to VM_NOHUGEPAGE. This is also done if
> CONFIG_TRANSPARENT_HUGETABLES is not defined. But in that case, the
> VM_NOHUGEPAGE does not make sense.
> 
> Fixes: c4608d1bf7c6 ("mm: mmap: map MAP_STACK to VM_NOHUGEPAGE")
> Cc: stable@vger.kernel.org
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Yang Shi <yang@os.amperecomputing.com>
> Signed-off-by: Ignacio Moreno Gonzalez <Ignacio.MorenoGonzalez@kuka.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  include/linux/mman.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/mman.h b/include/linux/mman.h
> index bce214fece16b9af3791a2baaecd6063d0481938..f4c6346a8fcd29b08d43f7cd9158c3eddc3383e1 100644
> --- a/include/linux/mman.h
> +++ b/include/linux/mman.h
> @@ -155,7 +155,9 @@ calc_vm_flag_bits(struct file *file, unsigned long flags)
>  	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
>  	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
>  	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	       _calc_vm_trans(flags, MAP_STACK,	     VM_NOHUGEPAGE) |
> +#endif
>  	       arch_calc_vm_flag_bits(file, flags);
>  }
>  
> 
> -- 
> 2.39.5
> 
> 

