Return-Path: <stable+bounces-227616-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGs2GoiuvWnIAQMAu9opvQ
	(envelope-from <stable+bounces-227616-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:31:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F81D2E0DA8
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA3B930B78D1
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 20:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85FB3290CB;
	Fri, 20 Mar 2026 20:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="r4BeEHsK"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AE031F992;
	Fri, 20 Mar 2026 20:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774038621; cv=fail; b=R0gvicDV5MXhVbfJreGffVQtknTCje4zrHQLppmBw0xoewILsem2j7N64Z5XCIK5HL9wYmtWENdi8NYiWkKIGfLLYDvfkKK8TNSZ6cR9X+hhyso/tNeGoegiVarkNu2plmzLw9XAnZXtcvsY9f6C6kbBqxxVrzc9CfRq92PmZzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774038621; c=relaxed/simple;
	bh=+OaXg7msG5+GimqW0p5SHuQYe2kz7eKDJKJcLHy2r0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cXEgVo9OW6W0QXh8o0Ep063VnyeOn5z3GMj6bDz5b8DfSXYKU9Q1c2/PfZnig+m0LcpUe1TSxvY01CRc4uXlVGkKgtu84Mz+AWhTjEgn4cKTFp/aVMjd/f+0u8UwZGGYrLgKxNIXKkFgzBG2Jt5VFADE8nv7elc33pGk8M1eZts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=r4BeEHsK; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62KDRiO83277586;
	Fri, 20 Mar 2026 20:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=ES4VK4OWxpBu8E6zVBJmJw+BveJkv01MNavKOPfpAok=; b=
	r4BeEHsKVJDLFjLKRH6yJ4CWOexCMmWXBGmnIZkIUTdV0UFzPL18tW7reAeU8qxc
	up1pmMvkBSWWKcs5OmoPg2sJd49u8kOo/Vz13keYad3yalE50UJtedRGgk0zmbG0
	delcDG866mnz/5YtPOfL5bs4EECPFixkmW8eeHRahHs7Bf6v0GqQQBIskMV1ILSl
	QhIWmOaEZxATu2uomnRWXb1FxFTObKeQZe9ePj9Gx0WQTBF7cdkSiXZvl4VXfTru
	DFtYSxF1/PdkEHs+jLXNuLUS+dPgT/W7uMzqyC3AHKKeg0Ypke0yjWoIk1Yc4fXo
	6rErNmEvEIJZOx8MHlYDOw==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011060.outbound.protection.outlook.com [52.101.52.60])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cxm66egdc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 20:29:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSp7OB3uE14yTiIg6DSM8IVaw90MKXwiiqGuUOFPRSUAYm695uIefh8chyECJ7q11240ONr2aysjA8kGypTLgO37CAANpkIitgJbNu8yQI8Rb98teJL6IiRZWUqzdweuO1/l7PWjF1h0UxCjjD2d/s4tcDs2wCrMRcHEn06Z2ovBoHOparBp580wkvuyvCmcm/bxI6fmirME+0HBXowJEPpT2zAFU4BKmXdPoL+TFSA4paxorJgjXFWhX73cNV5DrtzHxpCY3q4J0JvZOVnp/E5i4DjTW2XqF94zQvEsTVWuwWbLJGwi6vA7gUu+B7czUT7FkpRkLewMqdSoIw5CEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ES4VK4OWxpBu8E6zVBJmJw+BveJkv01MNavKOPfpAok=;
 b=cd9ZdDz774KtWTGPFd5Y76EaUe4SdjF54VG1QiEv5HUbVx7DYJaNEjRNjbTORczK/izz19y3tCw0RrWHgB2YLNg4bv+3kn/iFsGg5oTmN+CCA1hKSSZEG4/LRbX8MGyVNjOoWw0FnqfxOIn7QltCueltiAsdtGo4zI8wPsJTy57vMpMUXpKQzPuZb6rGqW+MU1yNubM7vwiQtXAMqbHU7UI/2eybZ9ur/KAC8md6BOGdH51nvbepc3D95HWXhWM9MGWdLV0RDKcsK7lBMsVUrrnSJkCandbupSXPyZ1lWaWFn7PqPdDTYre8kEOyPKPULFmy7dNzclHoOMKd4voomQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by MW4PR11MB6785.namprd11.prod.outlook.com (2603:10b6:303:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.14; Fri, 20 Mar
 2026 20:29:32 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 20:29:32 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: stable@vger.kernel.org
Cc: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org,
        christian.loehle@arm.com, artem.bityutskiy@linux.intel.com,
        quic_zhonhan@quicinc.com, aboorvad@linux.ibm.com
Subject: [PATCH 6.12.y 5/6] cpuidle: menu: Update documentation after get_typical_interval() changes
Date: Fri, 20 Mar 2026 22:29:07 +0200
Message-ID: <20260320202908.24377-6-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320202908.24377-1-ionut.nechita@windriver.com>
References: <20260320202908.24377-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::19) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|MW4PR11MB6785:EE_
X-MS-Office365-Filtering-Correlation-Id: ae1ceef4-3b33-400a-aff7-08de86bf6515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|10070799003|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DWTJjjciA/A4AOrEpfnfHGWPEFEZQ5a+ka6irYrsWllozC43BSx4LK08qwxX0sXo3p1iBDhYsDIJAsXI8EmAs0dOE73VPd+vmmzOmCK5yNRB/G2h7CDv+8bK+ozkGmtUOTsIA7JeFj08yYI20jlBr5D1VZPIazKOyvYufMwEnDIsz8QHV1z9Xuyg4OT/yqIJZWMIueLVW8LKZnfPMwgZUsUotDPYtYuYVgGiVyB0rYVzNMQH7HtQ4xi/Zjd4wWoBzDSUM+TCND7JQsb5IOtthf9Ufg1HGyao7GlCNv2GSGp3o7TnUcOUrgVdJOGvlyOdtJxLzf7kXSZlSb5oP7GMiT6P+Z9eiV2delEhipIi1scVMcro1wQDraQYn0yxsMD48Z38YcDh+NzU/m6XjdfACjfncbykXdTNcQuxBWd5857TIBv3jpqF9l6nKu19p3dWTt8fqkY2ccSjclphaMlfEOhhQb3xNKTWBNTbWBTYBrIKomvZFCoq17+pAqPN+p4OZRG2HIyMUjWJnpKJw0YPxeICf350yv/henNB2/zK8heGTnDzvNsN3G2B/G2IhI3llj1YU8CMR1BiBoZkH88+xtK7tpj6h/FrkuKQDU+zAfKzSCF+3UeROYY+VRzXIG48RXS/INYkLUsFws1iCeqcOynRf4JIncINi7+ua6spWj6F4aa/DsYxrnjDe92YTbkr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(10070799003)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zw1SjQ8deus5DKqtjmxVW19D2423i9Zd0Cvc1+rggmK7KrD6BQWwaM+49QTO?=
 =?us-ascii?Q?nFYh2mHbvHX0DG7dL0eWwcLe79XV9FOgjuTGDPIBdrE0RMOxK3iAk0CtIbMA?=
 =?us-ascii?Q?QPWsb2W9OgxfGljA6RXqrWZv8YGzf53Dqd+1STHKKu+2xnhZtLJkOb3SltmL?=
 =?us-ascii?Q?PSst9her83ywkCNlPr/EsXLalwA2aV2l8FNUtNE1E0d6i77wvhyyOQdZshDn?=
 =?us-ascii?Q?+zi2E324RdQv/3CR96f3uvbp4Gs+V0vN6LgLcfw3YM0KnepDi6j9ngiDcOpw?=
 =?us-ascii?Q?1zgDNumE7frtZY3CxfgJGJXOjMtXaJThHtMm39YtfCPHdeZbznScOFsFMXUc?=
 =?us-ascii?Q?t0ujeXuuMaiFnt3QI870bpNadtwnCcrjmzmB9locY1dJPxoLCXgZhTQouhzm?=
 =?us-ascii?Q?ysIOf3vgRtVAWOKFIFHv/6ajVch7RY+LR2rGMphhEo3oEB7A4HAA/mYSJBDd?=
 =?us-ascii?Q?f2VuUs4E9C11a/cVLJE2+uMP3+buZZq6xvWu0hiRVnWP9GQUSHPdSiD8Nz3y?=
 =?us-ascii?Q?nqTS6gKmKp+MI1pj/gbvzyPrt3h7UcHhfeJV8zRfTyYuP7MzBSaDzxA7gOwq?=
 =?us-ascii?Q?JuXEgrYUV/HhHRq2gHgNeunjAqWA7BqlMcRsHJ38bL8/wPUS73vYh0U4OkEm?=
 =?us-ascii?Q?wKupZm9iIr9HwA2uRYQYKtXWCY4Njv9eFFSZZCXntoA3drEtzL6VvN7dIjmX?=
 =?us-ascii?Q?S6otdenUSzxdsaKKquz4wzGsSmyaZehHG4P8hvq7tEGgWt8Js7MHR62ZTCY8?=
 =?us-ascii?Q?daqeMRzonF0JeE9VgWcvk+8yURRezQV/zLppP5woqKXkA9cRGPVzE9X/oL03?=
 =?us-ascii?Q?37ViGpOq2Q3+/iUT8gkVg77lP5CdjZZbz7akPEFWB92xRQ/9NcjZKmveWSaN?=
 =?us-ascii?Q?ItO26R+ZtmwH65K3zj88bjtpDt/1jTlQCSb98TSCxtN8pIKSMgO22Ec0RXc8?=
 =?us-ascii?Q?jcjhn/Ixt+NotRJ4A/+8hLcVbvXTjrJD4F12xoEftVOygC4+AQI+HRJylDjC?=
 =?us-ascii?Q?NBzTfInLQ6h96bXpRidQs0Z+XIn73CnsIWYwJvmTEAG8dRTF+hJycrcRcwbj?=
 =?us-ascii?Q?+nOr+xRHF/znsvQ9XFqL8HAe2ccFPxg3pmfD7B/dBhpigaoh7A749TKpMed/?=
 =?us-ascii?Q?rfkXxvQqrhPk93FC39bUIEjFUzmWVqc8fpM+be60B8Rrdt8barSm0SPYvE6T?=
 =?us-ascii?Q?xVTq9biIHBMC6fo2x0dwMiSbVdxKycvDwJQbEe0AGxuI2xkKNpOgnye8Mb25?=
 =?us-ascii?Q?GG/nxi1cnxsowP29ah/11qyrHePu8z4aJJ3aAcb2NpZ6Qn2umCY5IB4x7Zos?=
 =?us-ascii?Q?T/VFrn+aM0WqDgCI6UKlyoBSBOoUr4CbUp/mmJ9R0/ugc9klkZCEkoksNkau?=
 =?us-ascii?Q?94ODVgkpItYgsrQb8vKd8uUCbFmc0hcrhgQF+J9zbNTjQOqHlYmV/1lq03Cg?=
 =?us-ascii?Q?+aXUqGDrbbAE298SQVdDPYxvIqtYhnaj53XRpiqopAA63+6Xur0sh2Xr+g1r?=
 =?us-ascii?Q?DaLA1VP0IHX963eYR2PeGzDLOmWUkFWguEA7920AR4/na6JfrRBSgYiaIxaf?=
 =?us-ascii?Q?yCbApbKnLjlrnnJmRS99QgMH8s/i/bQc977ly8rt7bc73kQraXaSwE9sDU+O?=
 =?us-ascii?Q?aIVkjo/2RJxbcMEg26UN8WvIFa4cEcuD426QXQqaxDjGn1CiKjad35L6/QaM?=
 =?us-ascii?Q?jqVgi3ZmquLqHTdWAEFrfqUCcsrDzrRwLC6jshmVo2Iv/EVz2r+4/u2lxQE5?=
 =?us-ascii?Q?BPtlK3h7LMFnOxB7w6pLQ74ZLvTWCNn87BENCEyqYIQ2XO0lxCogaYQxAFzm?=
X-MS-Exchange-AntiSpam-MessageData-1: Xfjv6blH22Tf/TOR/oerVFmH+iGN9dNOYx4=
X-Exchange-RoutingPolicyChecked:
	bZS3FI/eVU/r5Ig4Hn/dfMrNTzxD3cKni9Js0RN+TGdL44UtJCSTVb8g4+/awCJkcgvBuqpF4Q2QaXKF7Q6K/+ZKHh3St7TiWVi6/8lyeQ6D6VkYK2ZPB06h/Is9hmoG28KVjJ3QodrordvZsOZUshnubxvn0Kr4MT7onOmLRgKU2TdeClsaRDvEY0Ufpw7YnhYHUlJa6OICyaN3vhuAYvb7yzHDJb+379rfUSYDW1qfUjxkMv02UWpvnTFgTwIZ3RiLoB1MJojEnEft5NEmh9FeW4sFhDMeg4yl3C9viiifppI+6ktSXlVVfsS5MsFydH6++5uGQyKZJ9NihJWLMw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1ceef4-3b33-400a-aff7-08de86bf6515
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 20:29:32.7062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: np5+1JIaYe67sLZGczGccl09iw54MN6od6/1hpmjv5crxSzlPBkWFhFxgEJ956tdh5cGBBzC5seTSf4EbFqKlOXPF6BJGOHZiGb4MYKr5Zs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6785
X-Proofpoint-ORIG-GUID: ca3VqLgu-tw0cIJwANGsHJviERPoyNaW
X-Proofpoint-GUID: ca3VqLgu-tw0cIJwANGsHJviERPoyNaW
X-Authority-Analysis: v=2.4 cv=fLk0HJae c=1 sm=1 tr=0 ts=69bdae2e cx=c_pps
 a=AqWYtYKdvuqIQX7AE/aD9Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=bC-a23v3AAAA:8
 a=p-nOP-kxAAAA:8 a=QyXUC8HyAAAA:8 a=7CQSdrXTAAAA:8 a=2lyBwhcKvf4p2rtmxjYA:9
 a=FO4_E8m0qiDe52t0p3_H:22 a=XN2wCei03jY4uMu7D0Wg:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE2NyBTYWx0ZWRfX+5MUvHUQ5048
 e7cXUFN5KI6+UUDPH25618ZfDeCB9qrhrh1tLsagAl6HzwaJfhLdeFplasT3YAVoL2wKIxux6ro
 UmKPPhyL/vxDiw74enaKeTSCJnD0z6W4t+4dIR8BUbMRVEIzv+wacZS69iLc1DYFiCwCoxHqsaE
 KzbXZh/4IpUiGj3yt55wAa2DOKQmG0ueafNc7TVNoLY91h7H6OBHNfTJLQsQr0EVsXhfiNCBvxt
 GxnO7w1z5GUj4JQ8AWeOoskoytdcnLXfd7bhifCtEiRhIyzHsKGYu/n5LRS4toWiOa0slLT48co
 PBbNUFcSuoH44Dug88CaxvRdfx1I4DjZO3PFWNoKAfC5uB/RECMwLstzp7B/oU/mV0uLLTDazFx
 P+yrzTBXtW+fxMYjBfG+Bc5fx8NrEEBWWOlwgoaNMA1gUuXW2l9e09UM7xxMC+vFLQtpSvxBdCU
 8XHuZFugkma15wwF0DQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200167
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	TAGGED_FROM(0.00)[bounces-227616-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:dkim,windriver.com:mid,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,arm.com:email];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0F81D2E0DA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The documentation of the menu cpuidle governor needs to be updated
to match the code behavior after some changes made recently.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Link: https://patch.msgid.link/4998484.31r3eYUQgx@rjwysocki.net
[ rjw: More specific subject, two typos fixed in the changelog ]
---
 Documentation/admin-guide/pm/cpuidle.rst | 56 +++++++++++++++---------
 drivers/cpuidle/governors/menu.c         | 29 +++++-------
 2 files changed, 45 insertions(+), 40 deletions(-)

diff --git a/Documentation/admin-guide/pm/cpuidle.rst b/Documentation/admin-guide/pm/cpuidle.rst
index 19754beb5a4e6..9fcc35498fb0e 100644
--- a/Documentation/admin-guide/pm/cpuidle.rst
+++ b/Documentation/admin-guide/pm/cpuidle.rst
@@ -295,30 +295,44 @@ values and, when predicting the idle duration next time, it computes the average
 and variance of them.  If the variance is small (smaller than 400 square
 milliseconds) or it is small relative to the average (the average is greater
 that 6 times the standard deviation), the average is regarded as the "typical
-interval" value.  Otherwise, the longest of the saved observed idle duration
+interval" value.  Otherwise, either the longest or the shortest (depending on
+which one is farther from the average) of the saved observed idle duration
 values is discarded and the computation is repeated for the remaining ones.
+
 Again, if the variance of them is small (in the above sense), the average is
 taken as the "typical interval" value and so on, until either the "typical
-interval" is determined or too many data points are disregarded, in which case
-the "typical interval" is assumed to equal "infinity" (the maximum unsigned
-integer value).  The "typical interval" computed this way is compared with the
-sleep length multiplied by the correction factor and the minimum of the two is
-taken as the predicted idle duration.
-
-Then, the governor computes an extra latency limit to help "interactive"
-workloads.  It uses the observation that if the exit latency of the selected
-idle state is comparable with the predicted idle duration, the total time spent
-in that state probably will be very short and the amount of energy to save by
-entering it will be relatively small, so likely it is better to avoid the
-overhead related to entering that state and exiting it.  Thus selecting a
-shallower state is likely to be a better option then.   The first approximation
-of the extra latency limit is the predicted idle duration itself which
-additionally is divided by a value depending on the number of tasks that
-previously ran on the given CPU and now they are waiting for I/O operations to
-complete.  The result of that division is compared with the latency limit coming
-from the power management quality of service, or `PM QoS <cpu-pm-qos_>`_,
-framework and the minimum of the two is taken as the limit for the idle states'
-exit latency.
+interval" is determined or too many data points are disregarded.  In the latter
+case, if the size of the set of data points still under consideration is
+sufficiently large, the next idle duration is not likely to be above the largest
+idle duration value still in that set, so that value is taken as the predicted
+next idle duration.  Finally, if the set of data points still under
+consideration is too small, no prediction is made.
+
+If the preliminary prediction of the next idle duration computed this way is
+long enough, the governor obtains the time until the closest timer event with
+the assumption that the scheduler tick will be stopped.  That time, referred to
+as the *sleep length* in what follows, is the upper bound on the time before the
+next CPU wakeup.  It is used to determine the sleep length range, which in turn
+is needed to get the sleep length correction factor.
+
+The ``menu`` governor maintains an array containing several correction factor
+values that correspond to different sleep length ranges organized so that each
+range represented in the array is approximately 10 times wider than the previous
+one.
+
+The correction factor for the given sleep length range (determined before
+selecting the idle state for the CPU) is updated after the CPU has been woken
+up and the closer the sleep length is to the observed idle duration, the closer
+to 1 the correction factor becomes (it must fall between 0 and 1 inclusive).
+The sleep length is multiplied by the correction factor for the range that it
+falls into to obtain an approximation of the predicted idle duration that is
+compared to the "typical interval" determined previously and the minimum of
+the two is taken as the final idle duration prediction.
+
+If the "typical interval" value is small, which means that the CPU is likely
+to be woken up soon enough, the sleep length computation is skipped as it may
+be costly and the idle duration is simply predicted to equal the "typical
+interval" value.
 
 Now, the governor is ready to walk the list of idle states and choose one of
 them.  For this purpose, it compares the target residency of each state with
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 8ab5123c81040..a18477ecce433 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -41,7 +41,7 @@
  * the  C state is required to actually break even on this cost. CPUIDLE
  * provides us this duration in the "target_residency" field. So all that we
  * need is a good prediction of how long we'll be idle. Like the traditional
- * menu governor, we start with the actual known "next timer event" time.
+ * menu governor, we take the actual known "next timer event" time.
  *
  * Since there are other source of wakeups (interrupts for example) than
  * the next timer event, this estimation is rather optimistic. To get a
@@ -50,30 +50,21 @@
  * duration always was 50% of the next timer tick, the correction factor will
  * be 0.5.
  *
- * menu uses a running average for this correction factor, however it uses a
- * set of factors, not just a single factor. This stems from the realization
- * that the ratio is dependent on the order of magnitude of the expected
- * duration; if we expect 500 milliseconds of idle time the likelihood of
- * getting an interrupt very early is much higher than if we expect 50 micro
- * seconds of idle time. A second independent factor that has big impact on
- * the actual factor is if there is (disk) IO outstanding or not.
- * (as a special twist, we consider every sleep longer than 50 milliseconds
- * as perfect; there are no power gains for sleeping longer than this)
- *
- * For these two reasons we keep an array of 12 independent factors, that gets
- * indexed based on the magnitude of the expected duration as well as the
- * "is IO outstanding" property.
+ * menu uses a running average for this correction factor, but it uses a set of
+ * factors, not just a single factor. This stems from the realization that the
+ * ratio is dependent on the order of magnitude of the expected duration; if we
+ * expect 500 milliseconds of idle time the likelihood of getting an interrupt
+ * very early is much higher than if we expect 50 micro seconds of idle time.
+ * For this reason, menu keeps an array of 6 independent factors, that gets
+ * indexed based on the magnitude of the expected duration.
  *
  * Repeatable-interval-detector
  * ----------------------------
  * There are some cases where "next timer" is a completely unusable predictor:
  * Those cases where the interval is fixed, for example due to hardware
- * interrupt mitigation, but also due to fixed transfer rate devices such as
- * mice.
+ * interrupt mitigation, but also due to fixed transfer rate devices like mice.
  * For this, we use a different predictor: We track the duration of the last 8
- * intervals and if the stand deviation of these 8 intervals is below a
- * threshold value, we use the average of these intervals as prediction.
- *
+ * intervals and use them to estimate the duration of the next one.
  */
 
 struct menu_device {
-- 
2.53.0


