Return-Path: <stable+bounces-66105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B73AC94C85E
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 04:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09AA2B24476
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 02:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AE312B71;
	Fri,  9 Aug 2024 02:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aDEpHwp0"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F5010A1F;
	Fri,  9 Aug 2024 02:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723169162; cv=fail; b=VGRf+MPhHoGdJCHtE89luWrxLJseuk2waBAwoLApNr9ZmtSv8hQAm17Ag83txPaWqVSPRfX6FjuX5IAOf+xzBp6jbgXOxL9WxTAZZRptlVOshz1uZATnmLb4No8bZGI3yn6lI9ofYCsbDM3TxORiicD+WQ2s3pC0mj1NqeqztYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723169162; c=relaxed/simple;
	bh=ZV71+qJbnx28mrWFddevnvlPvtdpwdK6F+v2iY2Fni0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h1kQ0wDmgi+3KaMQ+uYTqb+igPVpZDxm2211LaMPTkwnZfDY0RrsgTr5y+Ei6bx7feq/EZ8AXjXh+ob0jxoFJ6LF/VFG7P4UYhwNlO/O1awDfUrOzH/F6tpfIUMlAtUaPt3+mEX4nb9tx7aKP5P5aEpegkppAqPqowyTT1OiIA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aDEpHwp0; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JzfUe0Uk7jkVuuDKIoBr/1EAjQJfkssbMDi032W1+FbXDky0o5ltvCSYs+KbG7t24G0+/O1DoUUUdtIi+/DOHO7VYEJSgC4nEggG0mBrw5oTnxr8AXexu4gN5nOFvNRjNwOIBnVUF/sJW5G7ftn6fT7aiGsS6pe5zpykE9slaRzKklowl8azVvsbwI5fmwqk3LtwuyeedtrtnttNiVNPKWCZKeUj0Ff9QkFMpvstB7TcBaVWHofSnA8s5vC5+TV9k4SiP3VVtp2WDnzH3H/fL0FPgPTesS5UI36b6KM63JjLK2X5sGrkEpTAum4Ak6t4FL+jE7cFjO+2HQ2nyGGjZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaaYqNgwUOJNYUsAYssUzkUWfsQnNYqXFQRjXiKm6MY=;
 b=THu1cy7j2Ya0Z0L1gz8mMYkECxkFeNQJQ7jiXnNU2BxyBnYEhYrVaDTEDxltZMVfIfAn+AUc5P5Gkw5RdspTV9Hh7ikkQ66bDwgkBPTTe3e8ZXHZTkivayn16xqTyLDm3gHn5E0/kNtqwpSoBZjV6ScXA+fAgtNmV7/NMrDcVTWBXeOewXiryT43skWPEee5jVfN4WG/ZrycJUm9UIZMHMKEs9lO3YpM+aG512e9ht95uU0Mc5KmQEP+W0A3M+XaAof2wzrzSwetRLNNrWuu6HDaessznIIFUlC7pJ41YL5vx3jHpSmFTlG5IB7fTOSsl4s6rjd5TZZYRofgLZ2OHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaaYqNgwUOJNYUsAYssUzkUWfsQnNYqXFQRjXiKm6MY=;
 b=aDEpHwp0hiQ2OUToRv9DKEfWRIeb2oz+IK8MHIQr9hNLKG5kTGLR9UB/cklfzTB+l3Kotn5sY3hRUZExsG4ejmRo7WZNbDr8BzAN+5FPul4W8jm+xzqeG5uCVS1XlfRNiIYNhKmIm6sJ9rrYzU7u9BJOiFzYceMHVteq2zJDPTlJQ2msPH+dxGlymyrU/smCm8EaqtqTYsk69B01goCw0HraIiJdb8kaW652fLL2tDGqfogqtvemAk0Y1Fs6e6ywHS2Z5RT/bs8IW6bmDG/GO7Nb7JcbOKsWpWyEyA4ePuZ2ubIWy1gP5UA6MmATGiet8NgsejtgfJEDdMxbLuaWzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by SA1PR12MB5613.namprd12.prod.outlook.com (2603:10b6:806:22b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Fri, 9 Aug
 2024 02:05:56 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%3]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 02:05:56 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
 David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/numa: no task_numa_fault() call if page table is
 changed
Date: Thu, 08 Aug 2024 22:05:52 -0400
X-Mailer: MailMate (1.14r6052)
Message-ID: <03D403CE-5893-456D-AB4B-67C9E9F0F532@nvidia.com>
In-Reply-To: <87cymizdvc.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <20240807184730.1266736-1-ziy@nvidia.com>
 <956553dc-587c-4a43-9877-7e8844f27f95@linux.alibaba.com>
 <1881267a-723d-4ba0-96d0-d863ae9345a4@redhat.com>
 <09AC6DFA-E50A-478D-A608-6EF08D8137E9@nvidia.com>
 <052552f4-5a8d-4799-8f02-177585a1c8dd@redhat.com>
 <8890DD6A-126A-406D-8AB9-97CF5A1F4DA4@nvidia.com>
 <b0b94a65-51f1-459e-879f-696baba85399@huawei.com>
 <87cymizdvc.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_5568BF48-3AD3-4317-A8F1-90BEBDF3CE91_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BN0PR10CA0002.namprd10.prod.outlook.com
 (2603:10b6:408:143::16) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|SA1PR12MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: f524cb21-28d5-4973-8b59-08dcb817cdea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZBDbuCSfaewFk5aeByVxsl5qmUV3jIc/ty38gH3F3ApLaA1M4wBGDS1EANDJ?=
 =?us-ascii?Q?7fJw7d+afjcimkgSnn2g0nAPuqdh/1AFJzI0d1gbsJs8N+ukbW30Bhp02qpL?=
 =?us-ascii?Q?MAwDAB9Cv2CANCCk5K5Kj7BkZ/1Ut6qRMO6Zvb/JQj0T/GtsM5cDFcsriBAT?=
 =?us-ascii?Q?sxdIcFpRq8tQYMKSkQVKNo8p8ihw3Tf2fqBZSjON6G9UpGPca0OYjS2jufbT?=
 =?us-ascii?Q?ifDNquMvXOMOEkSVV2ruTGsdJxRqp3VKSBgyIckls1Ivf8GJYdhnyKc18MIX?=
 =?us-ascii?Q?2c7TUyotmwArfeA7MoDytS4tC5F4Uug35Q06jmpzbT5zmVO1NU46P9j3R4t/?=
 =?us-ascii?Q?e4jVczyyDFONY8v7svrXqhW+IyNyJV9stl5/wVu8PPHgVmqfM0j7l9Sc+rJP?=
 =?us-ascii?Q?2//fLypq8xIRInAwsKM37UX4qNtAo/Qe/CFj+R/2magodec1LvXHCe8rMlmp?=
 =?us-ascii?Q?aBS4pILud6hZsLEFnv0m4d+SvNMnk/bkx1mKMZz8Hbe6Q+G0SSej/HdEgWw5?=
 =?us-ascii?Q?ZThPUOePJjW1aJD3Qxg1e8bKEjWjjod9Zt+0e6WgjEwbUr8K26H6VStzK8un?=
 =?us-ascii?Q?ZL4N6HlRmeThCSawy5ubA4t1a8kcOH1lSub6POh9BlVL4yiLtoJApF4ShdeO?=
 =?us-ascii?Q?2ZPUOI049w3ydk1mtySMQuAIaQ0pe4e/IMOEJLfAjmR8i18IFfg8tZPvT/Cp?=
 =?us-ascii?Q?QYqoaG5cC0gP+O6tiYc/tr0WdhcGgpsd5AXKpR1y8LVYDKa2BabPg+BQSuFd?=
 =?us-ascii?Q?kGPDm2lhqZhOES0jdA4jxjGpvPbk0wG4ZDQe+mlDhwcUJpNhGdOOXR5TCI00?=
 =?us-ascii?Q?CLM0nqY7uoAYWU4B8XxI8gkIBhLIXTTMF9UwVihFjui+ZT43N8sxHyvhE+Iw?=
 =?us-ascii?Q?8lzJBM/OO7almrlIZSbeJpN9sXNZywChpVQvg23tBBG3WDrK9dtbHAlfGfz+?=
 =?us-ascii?Q?xJ4sl9KMegZkv3Vuv4VsWT8PZGtYiHhjQPHVshrdE9Ls4TqTtqN8kZp0Cpq3?=
 =?us-ascii?Q?vx/pwocA1HUvkkrPWNS8wUrqpLhVBw9m3wYyvrmm38e4Xfcvc+4jHnEJtOQu?=
 =?us-ascii?Q?xyTWUJPGef+aiTgQlZTdJL6lG+4N+x1VRy0pDp1wVvJPEj2LlnT++EhauNp5?=
 =?us-ascii?Q?v8nJi2uWqz/9Y1X80xisd1k3+guC09qKmO98jJUzy23dytAffo8xwF1z36uh?=
 =?us-ascii?Q?jQb4LyPYYxWfa1q6HyEAoHMiQsmcmQch6IEQOwWiHKYV/ee4dJ0/btiv4b4k?=
 =?us-ascii?Q?xk2SZRinyVR6AymDOL6UlEuNC9a98r8uwXAIEV2bOT46HUyWkpl42wvHVsVw?=
 =?us-ascii?Q?l6XeeG6A5q/Xz+crLya8JWqMMQWQMI5adBR1L0B6T+vd8w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AIOw070RA9YXoWLf4FWiyhdVztxJoWz2V0F8IA3ipsBY0YJuJx2gJ4IGndni?=
 =?us-ascii?Q?CpW5GMU/jcgQ6VQ/iFE6xhldq4xV/sOxQ8JIrGJjf2RTZ6WcnmXkBBUGOuOL?=
 =?us-ascii?Q?r9UU369DfnOjK2eKVQbTpxrdbI4M5wYeFVleXxzyeo11YqelFyeLIz2S4psx?=
 =?us-ascii?Q?fNdEwE48N5T8ISRqJSYnG2OE6JOk3S6MZV1wBv8qL7tylGF+HuxgQvYRMPdB?=
 =?us-ascii?Q?Oj9Em8FuyB33AS6VGqEJ+6FSqcecmCGY7Hb+xYYEaB3AFFMP8kS2TW0DPNFF?=
 =?us-ascii?Q?8dIwcfVSE9M/4CEvnxa1AJDw71syOjFw8at97h2nzkuR8DuQzwzJcVdF2CO3?=
 =?us-ascii?Q?foka6CR5kJ+ndj9iXTUhJVNKvy2eWbtZ0jPOKM6uIC9rhb851nmcNsvECqSI?=
 =?us-ascii?Q?RY/s95WGZuNcf8ATyN3vMhDIpZ7DBBAnGmuAFWpSgUwGCeUAHTg9qfrjtw4R?=
 =?us-ascii?Q?diKexygZDHAW2oJZ9P3rI7097bNc3Z5GmnzHZVkcfR+2uQm2TIdJBZ4SFGnQ?=
 =?us-ascii?Q?/ub/2ij7dYRAKDnYLgDbtrSOODl6xLsIy2Nz8P5BheAlEQrwlLYsJU5VXpG8?=
 =?us-ascii?Q?MQeJkTfnCL3sPJkekUsh68ZHBKbDXsYykcOGYc9cLmO0XwOhOOA7VnrmDiAs?=
 =?us-ascii?Q?kba/SKqky6Ek8JeGyTSpkdsE3EbmgJQ57a9WbgjpRtjkCHM7Q32Nwm8otQ3J?=
 =?us-ascii?Q?yi04/wJAJxT/DWRId4/KSE30wubeaUK32XwLbVd8yGlm5cIEVSwi0r1xXHFY?=
 =?us-ascii?Q?tCackVSf/lLQhFVcoOA8ZjWvha/qz25mnI7J+UoMvgTmP/yJD2qu+QSV44J2?=
 =?us-ascii?Q?w49lakmagnrQpvvcKs4Mg4RtZk3vfAmLJ686Rxy0jJVP0RFjlco7LdLEo82U?=
 =?us-ascii?Q?0bwJeWtzM+Y92TfQp+0lMjOuyQSmXet1TN2gzTnPc021reSBZ19nPsAOE2nB?=
 =?us-ascii?Q?1fSNxVnWI/33KSWmCfxSjSQfPZRkKY/vkSzBRtBze0NDEJmXorEcEnNO8rtl?=
 =?us-ascii?Q?KTGY6+zabNPso0UAE+x8mSQw/qz2Qz0/sR0ZEAElBYZpmaFdiY4QhyZpUuOr?=
 =?us-ascii?Q?afqRM3zNcqn9ImyQ0FZU9unff4wJtIiSx2JydDqXoPN2xIAOGnm9yYju30f8?=
 =?us-ascii?Q?tcIDBMUHOeEzU2BxZJpsCTDd7jMrnqA8b9od4GRA0zLKrbo+2+uqOLvKQgQ5?=
 =?us-ascii?Q?UVrZ7FzMNPTCHEJTmktEi2hgf54N/rLQZeLw0TMiSwyhChelZMQfq+FNCwof?=
 =?us-ascii?Q?97YU2O8fOJBVgmpJmTJbc8y7aHC2T8EXxMe+OvNfGP9Fbs3ZR5oeKS50G4j0?=
 =?us-ascii?Q?mq6x3902ZZtDdXlZwa0bCNY+mEvSC5+Vi+xIHz+jblzmmIv95TbTjE5nERUs?=
 =?us-ascii?Q?BNdUKw1NFCnI/12ru+PVr8xixd69nO5PO0J/UUYHLiYXNkqqVdwqq0F/559r?=
 =?us-ascii?Q?rHAvArpSLtqCD+gxIUb2N735OPVC+a7X0dY3SzYDyFoiuxrMpyzJpyB42djC?=
 =?us-ascii?Q?zn7LPizKlJilnLcmjejCtdh2XFq92MnxY3T00TOHpdVRyjKTfoMVRyAngJit?=
 =?us-ascii?Q?EGPgtnuPhoJSV7qrlwFEuvzOr6JJVLb8TQ59qmxd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f524cb21-28d5-4973-8b59-08dcb817cdea
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 02:05:56.0527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yv15/DmtWrKajzfsWU7JggOb/zc9i4+y5hutv0MBfipij793ty0o8W45OtqA0wuv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5613

--=_MailMate_5568BF48-3AD3-4317-A8F1-90BEBDF3CE91_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 8 Aug 2024, at 21:25, Huang, Ying wrote:

> Kefeng Wang <wangkefeng.wang@huawei.com> writes:
>
>> On 2024/8/8 22:21, Zi Yan wrote:
>>> On 8 Aug 2024, at 10:14, David Hildenbrand wrote:
>>>
>>>> On 08.08.24 16:13, Zi Yan wrote:
>>>>> On 8 Aug 2024, at 4:22, David Hildenbrand wrote:
>>>>>
>>>>>> On 08.08.24 05:19, Baolin Wang wrote:
>>>>>>>
>>>>>>>
>> ...
>>>>>> Agreed, maybe we should simply handle that right away and replace =
the "goto out;" users by "return 0;".
>>>>>>
>>>>>> Then, just copy the 3 LOC.
>>>>>>
>>>>>> For mm/memory.c that would be:
>>>>>>
>>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>>> index 67496dc5064f..410ba50ca746 100644
>>>>>> --- a/mm/memory.c
>>>>>> +++ b/mm/memory.c
>>>>>> @@ -5461,7 +5461,7 @@ static vm_fault_t do_numa_page(struct vm_fau=
lt *vmf)
>>>>>>            if (unlikely(!pte_same(old_pte, vmf->orig_pte))) {
>>>>>>                   pte_unmap_unlock(vmf->pte, vmf->ptl);
>>>>>> -               goto out;
>>>>>> +               return 0;
>>>>>>           }
>>>>>>            pte =3D pte_modify(old_pte, vma->vm_page_prot);
>>>>>> @@ -5528,15 +5528,14 @@ static vm_fault_t do_numa_page(struct vm_f=
ault *vmf)
>>>>>>                   vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf=
->pmd,
>>>>>>                                                  vmf->address, &vm=
f->ptl);
>>>>>>                   if (unlikely(!vmf->pte))
>>>>>> -                       goto out;
>>>>>> +                       return 0;
>>>>>>                   if (unlikely(!pte_same(ptep_get(vmf->pte), vmf->=
orig_pte))) {
>>>>>>                           pte_unmap_unlock(vmf->pte, vmf->ptl);
>>>>>> -                       goto out;
>>>>>> +                       return 0;
>>>>>>                   }
>>>>>>                   goto out_map;
>>>>>>           }
>>>>>>    -out:
>>>>>>           if (nid !=3D NUMA_NO_NODE)
>>>>>>                   task_numa_fault(last_cpupid, nid, nr_pages, flag=
s);
>>>>>>           return 0;
>>
>> Maybe drop this part too,
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 410ba50ca746..07343c1469e0 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -5523,6 +5523,7 @@ static vm_fault_t do_numa_page(struct vm_fault *=
vmf)
>>         if (!migrate_misplaced_folio(folio, vma, target_nid)) {
>>                 nid =3D target_nid;
>>                 flags |=3D TNF_MIGRATED;
>> +               goto out;
>>         } else {
>>                 flags |=3D TNF_MIGRATE_FAIL;
>>                 vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd,=

>> @@ -5533,12 +5534,8 @@ static vm_fault_t do_numa_page(struct vm_fault =
*vmf)
>>                         pte_unmap_unlock(vmf->pte, vmf->ptl);
>>                         return 0;
>>                 }
>> -               goto out_map;
>>         }
>>
>> -       if (nid !=3D NUMA_NO_NODE)
>> -               task_numa_fault(last_cpupid, nid, nr_pages, flags);
>> -       return 0;
>>  out_map:
>>         /*
>>          * Make it present again, depending on how arch implements
>
> IMHO, migration success is normal path, while migration failure is erro=
r
> processing path.  If so, it's better to use "goto" for error processing=

> instead of normal path.
>
>> @@ -5551,6 +5548,7 @@ static vm_fault_t do_numa_page(struct vm_fault *=
vmf)
>>                 numa_rebuild_single_mapping(vmf, vma, vmf->address,
>>                 vmf->pte,
>>                                             writable);
>>         pte_unmap_unlock(vmf->pte, vmf->ptl);
>> +out:
>>         if (nid !=3D NUMA_NO_NODE)
>>                 task_numa_fault(last_cpupid, nid, nr_pages, flags);
>>         return 0;
>>
>>

How about calling task_numa_fault and return in the migration successful =
path?
(target_nid cannot be NUMA_NO_NODE, so if is not needed)

diff --git a/mm/memory.c b/mm/memory.c
index 3441f60d54ef..abdb73a68b80 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5526,7 +5526,8 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf=
)
        if (!migrate_misplaced_folio(folio, vma, target_nid)) {
                nid =3D target_nid;
                flags |=3D TNF_MIGRATED;
-               goto out;
+               task_numa_fault(last_cpupid, nid, nr_pages, flags);
+               return 0;
        } else {
                flags |=3D TNF_MIGRATE_FAIL;
                vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd,
@@ -5550,7 +5551,6 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf=
)
                numa_rebuild_single_mapping(vmf, vma, vmf->address, vmf->=
pte,
                                            writable);
        pte_unmap_unlock(vmf->pte, vmf->ptl);
-out:
        if (nid !=3D NUMA_NO_NODE)
                task_numa_fault(last_cpupid, nid, nr_pages, flags);
        return 0;




Or move the make-present code inside migration failed branch? This one
does not duplicate code but others can jump into this branch.

diff --git a/mm/memory.c b/mm/memory.c
index 3441f60d54ef..c9b4e7099815 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5526,7 +5526,6 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf=
)
        if (!migrate_misplaced_folio(folio, vma, target_nid)) {
                nid =3D target_nid;
                flags |=3D TNF_MIGRATED;
-               goto out;
        } else {
                flags |=3D TNF_MIGRATE_FAIL;
                vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd,
@@ -5537,20 +5536,20 @@ static vm_fault_t do_numa_page(struct vm_fault *v=
mf)
                        pte_unmap_unlock(vmf->pte, vmf->ptl);
                        return 0;
                }
-       }
 out_map:
-       /*
-        * Make it present again, depending on how arch implements
-        * non-accessible ptes, some can allow access by kernel mode.
-        */
-       if (folio && folio_test_large(folio))
-               numa_rebuild_large_mapping(vmf, vma, folio, pte, ignore_w=
ritable,
-                                          pte_write_upgrade);
-       else
-               numa_rebuild_single_mapping(vmf, vma, vmf->address, vmf->=
pte,
-                                           writable);
-       pte_unmap_unlock(vmf->pte, vmf->ptl);
-out:
+               /*
+                * Make it present again, depending on how arch implement=
s
+                * non-accessible ptes, some can allow access by kernel m=
ode.
+                */
+               if (folio && folio_test_large(folio))
+                       numa_rebuild_large_mapping(vmf, vma, folio, pte,
+                                       ignore_writable, pte_write_upgrad=
e);
+               else
+                       numa_rebuild_single_mapping(vmf, vma, vmf->addres=
s,
+                                       vmf->pte, writable);
+               pte_unmap_unlock(vmf->pte, vmf->ptl);
+       }
+
        if (nid !=3D NUMA_NO_NODE)
                task_numa_fault(last_cpupid, nid, nr_pages, flags);
        return 0;


Of course, I will need to change mm/huge_memory.c as well.

Best Regards,
Yan, Zi

--=_MailMate_5568BF48-3AD3-4317-A8F1-90BEBDF3CE91_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAma1eYAPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKFXgP/iZgghvlTsZlwFd9/CUMGpVeuBZHaoitl32m
HS4XCOaThlDpaKqeqsB8uHSFFLgOnhppqGKlxO06lWKmfHT0j5ngyOdqR+sIE99c
LwbPuzkPLuhjWf4KTD7X1A1gEfp3OrL8gudt8ZFM02pGgXEbjR+mcNGoZlAjlH4E
G2R5Xa+L7vKNdKsJL9nIH5WCyiolQfjV/7I3oaxtQII005hIY/p9JQx5XAgRlwOY
b01u+FQ0G5Agy6+pdGq0byprUegSrmhMz1R4SD+tw6biEcVsO3bzPq+mqaCYqVHe
m8Zp57sWtNda5oRo5u0FagXRB27zvCiaOW4u2rX4akTTtUfZjVpG+w89L2atbOwh
40H0dIYYdG3TC6xl3+8iRlnPRDNtREhUXZIf3gEzCwiag8cUlrEbnV9hN8E73G2r
j+qlj8J3Cs0Jq8wdmthoS5NS7F4B+l7ODiohcZsFA6ovluwyIGG8gIu7fzfaTsal
qa3a8DWaei7XKsbji+ttT7agryC7SigM789jC4XZSuqWA9N8g6n1qijHTQF1Fjq4
pNaZYwVBzqTVcxA3eocbwS5/wPf5H8E1PgQOFmGF2E5MO0eSGe/j2k3qmwqDL2WQ
DVfsHfL4F82B4s5/ot76o8UAwD6TnXqxXlpb+l0896sGnCENrJcunpQxz2e5kJnX
XTWht592
=RLot
-----END PGP SIGNATURE-----

--=_MailMate_5568BF48-3AD3-4317-A8F1-90BEBDF3CE91_=--

