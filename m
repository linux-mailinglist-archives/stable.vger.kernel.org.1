Return-Path: <stable+bounces-244846-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +I3gDG50/mkIrAAAu9opvQ
	(envelope-from <stable+bounces-244846-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 01:40:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 969BD4FCDA5
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 01:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C091E301828D
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 23:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B9F364055;
	Fri,  8 May 2026 23:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qlDBMAoc"
X-Original-To: stable@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010016.outbound.protection.outlook.com [52.101.85.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EFA2BCF46
	for <stable@vger.kernel.org>; Fri,  8 May 2026 23:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778283436; cv=fail; b=tI7pcInabVsksl7QrBWp2x2RANMFuE2RHb79fQ1h6/12mDY0sLZzWk/9pEIdyopQwq1LKbN+M2pWvecuJPCe01krJ+EdECRcSRCpYk8DwcR52ZIbXkj9yosc4SfHjKe3aDtnwGbIaBZdY+7nKdXJfBEq7gUVs7lXpV5jHG64wlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778283436; c=relaxed/simple;
	bh=qgWDOc6LQCFk/a2wdjLoqJsDgNoFFvJe+6gIJ5xmCwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sMgT51U4R1UeiP/9Nb4BZUGUZsiLNxcXcMBXPIfjkJNuH7SDra2OiKS9TUWUQa2jM2YeV10B/MA8Abo4ilXxvKL81le2IF09+gczUDb5UCd7mJAdxPWDgs+2AASyHk0h9gvSHFVSaRKqQdPGPFmVLs/f0peackrANC4n+Yf2eQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qlDBMAoc; arc=fail smtp.client-ip=52.101.85.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBqbw68PU74KUEib8D80l4wPOzWcxontZq9j9sUjMF0ZE1aZ1lhXuGGPDfckRnC8PA7fVwVSqAHeGmk+LT3pP0D/cUdfsEgttxz8H+1yxUfH24rq7Gmroh+VsL1DlekZUu6l2wXgE+t2vylKSf/rRZagpBY1VkTPPFrRGIOquc0jnpeCr1SX1mIlUwXCR9lCG87GB40xmf8Ge+eWo0SYBiiQIqmgrmXxUYdiHscgvltJFki+pP2lT63lYH0YnSjuDL6dL24e60Ho5084cFjDqjbX/rlJrEb7atoN1trymwAWJniXmNwCJormBiCxG/FEGkLIlduBVght367Hk83D2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/xLX3mGyG+XcyDuIRjPGadFzhHsSUjI1No1m2aZHfE=;
 b=HbBMz5hgZV/z3icUkz9JZ8/gzjBmmkh2Vl+ICNOsDvwkBmhVVT/9tMFNF+NZSxDUvekTJUGwAuEImrC8bShThFvL6tuoQbS9+QTqfUoNns227fDACR7buXX1T3wBhZHxESWaEiSQcGXS6WtjhH4AtnuVJEpYn8OfVMbFYgQBTagZwSRCB4JAL2Hef8NkmyHhxsPPRCX9hdO+F/EPl45cbmQaELYDWPlCoHzVA8SIOCDXlW2gRapv0rsrhjENq9kJ1f8XS21gGXIWuWlZtzNaUeMjXIW57zObNefXgz/P6mnhal56JaznHNvoD02HOSQfry6N4GqG1DwWrlce2hwD3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/xLX3mGyG+XcyDuIRjPGadFzhHsSUjI1No1m2aZHfE=;
 b=qlDBMAocETC2qoXJ9zD/TY3Ngiur3h5B1j1SbR8BmRc6gOMtOa9t9dsHm6g/7TDjY2mHV0W+v8w7ATTtrydFhDh3Wr4foA7hAFmkdtnGcrjBX/m/9ZG1oFXMnFD2qfRazwMfOGZsWR3SPXROwXkKvaJeXiy5UmPc5hs0fAcA+9bjPkUgfqFkXXtrEkOy+LLCYiktHMXalTH5JTgR9Looa+D4e1eNOl65cKJ7qFSKPnfZZgc4odr+hD32GlAmveI0VuDUnX7ZVahadWprJ8SmACMFGbwxnzukG8/qte7sgFqIQDX4XGwLdZGH7wfUkUluawoOy8/8RiL3Jhzmj6+ytQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB7622.namprd12.prod.outlook.com (2603:10b6:8:109::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 23:37:12 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.017; Fri, 8 May 2026
 23:37:12 +0000
Date: Fri, 8 May 2026 20:37:11 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kai Aizen <kai.aizen.dev@gmail.com>
Cc: kevin.tian@intel.com, nicolinc@nvidia.com, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iommufd: Use sizeof(*hdr) instead of sizeof(hdr) in
 veventq read
Message-ID: <20260508233711.GJ9254@nvidia.com>
References: <20260430175630.67078-1-kai.aizen.dev@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430175630.67078-1-kai.aizen.dev@gmail.com>
X-ClientProxiedBy: BL1P221CA0040.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: eedfb786-cc58-419d-cd25-08dead5aba50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	M8q0fo4kcHm9nBB2tf1Td5Dy2McCFI6V8Rh2Tg5T1PDnRn6Nap2IASLBWmhbxA5LDQJONSFfCHlRN5Ox9TjSxHUPUXIA5leYAVDi1cvvS/nHs/OiwNIMGc4bt32Y/PLBXh6nr8DMJIwZU4J74OOI9RI3sOtBahwsbLgC8XpsYBybU/E1EOYbwH0+BYhpbj6vEyIO2U2STsM0nvThpuaKF3vc/Rrjm02f9eA8AasfQgJnbyl+TwOMDaH40hjgTCdJwrfrykkxeI4hZtkEN5ORJ8FxlwUS16yQkFHBsjLHMNzyJ2FrOXv4sDT2Lui+1ueJ9DMblLN6/O8RgxLlfhGl7CC3fqtVm9aRLbATeYJVKrKWf7ZaGX714aVTECEhL0W2KTPtt63mskRzut+8O/VtwbWX9qRHcvv7/qAVVHyNf62vcMguQWLjtPSU2Ixy65kcFCSJ1986TTDz6dHPAdjkJv70CzMxSDoz+HfpY5mY5OywutudQuBSUvdIyJLYFtTyHNRXZEqW6ACZow6VMIEvvd1IsbxA2c+zsxl6CjP3q8s+9rNyIF+FHB078MV7yiST/6aphGrxylK3tltHwOYvauZIC+yBMcD6rNEQLPZVIHykWzKeB5WwSzsbqx6dRDkFr9ji0B7ZRQ35GjVyi2+ZrLWDacOVsCJuwOUmCswjKrZJvWuDl9tuJw9+2POPyP3q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MvZ+JeV7svqxL/YJiumfp+FDVOV39ufkCEpPW8V/yFfrFvZwG0rnsn/vkS0k?=
 =?us-ascii?Q?94g4jJG9f4LoSurmjVqCSd4H1r0TJiaPobNw+zTkT0SfRwwl1fI0UnF3xYcG?=
 =?us-ascii?Q?p+IfxVFBzE5Q15M9G9YXkituaFjllqaEEQsgMA4RciBA3KqNYATQKnOMv/OE?=
 =?us-ascii?Q?zC77OaopYzoLuZ+P6oQQ7zx7opt9tZFVIyrrbQlRELc5Al5J6MH1I8SvypCp?=
 =?us-ascii?Q?fYN7BEuD3suD94zotPPyvaTwLLX9XISsKPMcL5JI+uuDv9Fhk2ANlvK49+Fp?=
 =?us-ascii?Q?gLoewEYr1irQ2HuOsv3vIlURorA+vWH+7QwDqhcQ3U1bOcxL5BhPW+XsEXdL?=
 =?us-ascii?Q?+SuOrVb5hxG1eWSzkVaP2WKKP1ly1BZ9a2PQXLxpIH1JATSF+34yud57nJGX?=
 =?us-ascii?Q?csEbAMkvsLbpQUQXZvGTG8sYRVzQzO2r3FBCYOgnlPKpzTtNc6Feg4UZIycG?=
 =?us-ascii?Q?Uob7fDlrVVobZMhgKQvllfhNxiMVbUOcr0rEs0D12jy8dd2mt9dAnjnFPOYZ?=
 =?us-ascii?Q?xO6XA5TXrJ79fe3c44IP71vqVN676WGz1xzV2AMcWoXJuiejkPbV9DlBziWz?=
 =?us-ascii?Q?jX8LH3OpY0sFaXL6lhksxHHaTH+w+WiFZSUqb16Uni0CcHm7p5YcZpd5Zh+E?=
 =?us-ascii?Q?ixER+Ow5u9xg3T12Mr6Y+5C/wftgCZvqfjSh+hds4xo+aVzxrxKdzOaott33?=
 =?us-ascii?Q?IPnjXH+KcmJxLH5HD6M1dQxEfiW+X10wCcgW85EEK4ZTiL/ndtWjVdW4vmu5?=
 =?us-ascii?Q?Z1ojmQRfH3rNYbc+SGT4XdTeYSMSwAbvLhfabSjhY9JczMonEATmVZYEMud4?=
 =?us-ascii?Q?4ixPC9FPb0j9v8TvTIwlzMtmeT3dFbfl8ooY6tADk9EoZ9Me9oM99FxFQc8K?=
 =?us-ascii?Q?CTZJCgjk3JE/eH8xRkzLl0y7xJQAz+6RwKWNRRgyXqi/UxUW80cr591hT8XJ?=
 =?us-ascii?Q?ntTFiBsCyi58uq4I6wE1b3Dd4//L/8hAYkOzFxznjIHSUZWX57rm74LOUXGd?=
 =?us-ascii?Q?ph+Ft7vlbimy0YS/s7ZY9VLszt9uIMOO7CrAVfWfNcOFvnudPsas/fZT30qT?=
 =?us-ascii?Q?1+WSWWLTIFTXkXDeg7aFcgZmf/UvTYU+ML5WMRiwbfBqdwCzcpYN62U0jYRg?=
 =?us-ascii?Q?xZUZrWRm8CAtEUILtEtExVTum7iKGlfcxWm+o3JD9ueExIGwujBa+S8qvcpo?=
 =?us-ascii?Q?jaXqfGzIl4zePqDR0YNBCCGW4NoqDQWyhG9Ufg+w+PozI3k0sCi7DRbdXtwK?=
 =?us-ascii?Q?o6MtagLdOj+ScCq83BBpW9XwN4DdT0J1O3kJI5hj37ma1RgEhlP8fitIBQWo?=
 =?us-ascii?Q?rzkbwmpu2g5qn8IxKCcVXILbn7nPB/GfOGwgQDBKA93CoIkU7KKXboNn8rgZ?=
 =?us-ascii?Q?NrpyopEs+THrd3NX7jB9JjNwKqPYjbNrN+3NdbaJLSqpuRdCwcTeM7uePAA8?=
 =?us-ascii?Q?Ev/Kho9nWxGh63AfwGhf9FEuiGDGMZeCbvJrG6w0biv/31e2oc63Ib7Kq40W?=
 =?us-ascii?Q?CkYHPZ21kzmdMHWJSigi6j75F7+2P0MYq1PgA2DDnZXp4YZlabp19cRzIevN?=
 =?us-ascii?Q?lgN7O5kSEBLLfUkqk684+WTu0raUxs6hRz0n/HmGUJZfvsibnu4D8ELeRmQ7?=
 =?us-ascii?Q?v+SfEyqgJyjk05ZfMGiL7bkfuh6nlYQAarW7zzWdnRnfNySLBO15hliywsW4?=
 =?us-ascii?Q?Hf6UIfDsS8fUPfAtoY7LdI8qM88Ujt371KG2yb8wPphdey36?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eedfb786-cc58-419d-cd25-08dead5aba50
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 23:37:11.9548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9wbllrefF0WleJC6eg9TmgEtdNz9YbPowIuOPSsbpdqyM9C8jRDid5depDje507C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7622
X-Rspamd-Queue-Id: 969BD4FCDA5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244846-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Action: no action

On Thu, Apr 30, 2026 at 08:56:30PM +0300, Kai Aizen wrote:
> The bound-check in iommufd_veventq_fops_read() for the normal vEVENT
> path uses sizeof(hdr) where the surrounding code uses sizeof(*hdr):
> 
> 	if (!vevent_for_lost_events_header(cur) &&
> 	    sizeof(hdr) + cur->data_len > count - done) {
> 
> hdr is declared as struct iommufd_vevent_header *, so sizeof(hdr)
> evaluates to the size of the pointer.  Surrounding code uses
> sizeof(*hdr) consistently:
> 
> 	if (done >= count || sizeof(*hdr) > count - done) {
> 	...
> 	if (copy_to_user(buf + done, hdr, sizeof(*hdr))) {
> 	...
> 	done += sizeof(*hdr);
> 
> struct iommufd_vevent_header is currently 8 bytes (two __u32 fields,
> flags and sequence), so on 64-bit (sizeof(void *) == 8) the two
> expressions happen to be equal and the check works as intended.
> 
> On 32-bit (sizeof(void *) == 4) the check under-counts the header by
> 4 bytes: a vEVENT whose data_len causes 8 + cur->data_len to exceed
> count - done while 4 + cur->data_len does not will pass the check,
> then the loop will copy_to_user 8 bytes of header followed by data_len
> bytes of payload, writing past the user-supplied buffer.
> 
> It is also a latent bug for any future expansion of struct
> iommufd_vevent_header beyond sizeof(void *) on 64-bit; the check
> should not depend on the type happening to match the host pointer
> width.
> 
> Use sizeof(*hdr) to match the rest of the function and the actual
> amount that will be copied.
> 
> Fixes: e36ba5ab808e ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC")
> Cc: stable@vger.kernel.org
> Reported-by: Kai Aizen <kai.aizen.dev@gmail.com>
> Signed-off-by: Kai Aizen <kai.aizen.dev@gmail.com>
> ---
> v2: fix From/Signed-off-by to use real name and email address.
> ---
>  drivers/iommu/iommufd/eventq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason

