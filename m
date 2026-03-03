Return-Path: <stable+bounces-222925-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NlFARArp2nSfAAAu9opvQ
	(envelope-from <stable+bounces-222925-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 19:40:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E86A1F5662
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 19:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5724302DA20
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 18:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA0D3CB2FB;
	Tue,  3 Mar 2026 18:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="apf0YQzL"
X-Original-To: stable@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011007.outbound.protection.outlook.com [52.101.52.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713E8391826
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772563212; cv=fail; b=DoRFnOFeuJKa+wc/3Yw4UDqLBmePnlRA1clER/e8l1MGt5zYpKSJVcEH2sl85LAjBw+64WR/jc7X8lLXyL8K3tnKPlc5ercGjesjlkQ16Z6zOzwpzFQhMbbl9O32Q8sN3PnXOXILQGXO2hQcku+A/OBdtHtwoX0QWQMOWQe4guc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772563212; c=relaxed/simple;
	bh=q3whElxciXy4e6EQa/2Y/x5jwQx5lj6T1DcOdzbZ8cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TMLbUh24IDvWnIi7+axNfuDON5PSCsAKwytx7iJPt6TcvhxkNJwhtY72IQh4P/Nq6FRteU6BKXhL463DGy2tzDdPwsdkinteUVVAa86hsLFYAjeXJiDaqzW/aP68RGDOlG97rp3k43auIWpP5HR0TV+jWt2P9cjlrKDQGj2o87g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=apf0YQzL; arc=fail smtp.client-ip=52.101.52.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxaZ/qxJVYgx4gsHPCQTMUfkakjubJ7UatyWvzW8aPEczUMcpRh3BPI00BZ6+hO1s8r2D/iu9M8miDZZnrAezGcfWUIz+EyQ+uEcvAGo5+bMDJP3me+StvdK/3SOE8P8gudekx6pYab7G/OOLN56JDjgIMnQa3oqoxSuuXADfeRAPh9qeorRCZYZCdvnHRkdmLn3UKvvrLK6CQ4g5WPu09GZuRbRwNTDxUhlphoL/iobwmFbnNbr++CmQLjnZsOgK1d5NHuuoASD9g5i691AYFq8A+LU6M8ZjIvxJVDGBYGW+IzFTqpN9XKxZFVdgie1WLROCpUYaBlHuKFil52rpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0kmCJMSGIvUOzhTIff6KcMV9QnY2cagi4V2X8P5nsc=;
 b=DQIiFFlZvU6OW7B5bzRGIBckT/U2Bv1oaArRH1BbuYtamwwmsH6bIAazyxBqGQ3CRGNDRYxbe+GXBlj/TbqBODGwtnsfHCT1NESRv9YZmwym12ZjPtfdeA9a7TgRVKhFWkBZKRbz2TlPymV1xFbZfV4Dze8oZdI7IZ1P92Tzfo+H6cOvVYzM+N0Dr0vK1Jt6yBdlq55DjwCwriF16kwe1u0jPdbaJUnFDQDzvIr6iULEykbqJss0BsIJJFYlvnU2uc/U1ZeFtIb7Kd9h+33JPc9JCG603GwCyeWMvpnUszHfgXSOP2XX7xHWKuq2Wu8oWrO/ZsWTW4IHi5Z4yQ4QpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0kmCJMSGIvUOzhTIff6KcMV9QnY2cagi4V2X8P5nsc=;
 b=apf0YQzLqFQkoOq0XptD62sE+et8KoOsyd4j1n6WScqyRDEJ1EYJhn7/9B/nu8l5R/HWE3Fx6OTTigvZlhQHTeui0GVAX86898TmeHhIYQSVxx8gMFkbkBmILXYRIPYW77x1A6XlXYen7+1szO6LPMH3T+FTxTQg2wXIAgx56smkz3hygpNTSmEnyTaMMY85JKbQBJxJ5poVF2NeFyv1eCn+g7zEGdn00DKPWvsdCmbbGdtvLz0/KNuRSFwGnJK5lBMGQ5Gc5GqF3VIplLpbRxQ69J40f6Hi9lZehI1YP2+Z9iTKHkXJLEf7EFQNHJMRxICcX4Iqjnd8kexmUkDq2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) by
 CH3PR12MB7713.namprd12.prod.outlook.com (2603:10b6:610:14d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Tue, 3 Mar
 2026 18:40:02 +0000
Received: from DS0PR12MB6559.namprd12.prod.outlook.com
 ([fe80::3f99:f532:cf6b:ea46]) by DS0PR12MB6559.namprd12.prod.outlook.com
 ([fe80::3f99:f532:cf6b:ea46%4]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 18:40:02 +0000
Date: Tue, 3 Mar 2026 10:40:00 -0800
From: Piotr Jaroszynski <pjaroszynski@nvidia.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, 
	Alistair Popple <apopple@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>, Breno Leitao <leitao@debian.org>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: contpte: fix set_access_flags() no-op check for
 SMMU/ATS faults
Message-ID: <aacohVRfAK46lOjo@box>
References: <20260303063751.2531716-1-pjaroszynski@nvidia.com>
 <0a10ea33-937a-4294-b9a1-9323c706434d@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a10ea33-937a-4294-b9a1-9323c706434d@arm.com>
X-ClientProxiedBy: SJ0PR05CA0205.namprd05.prod.outlook.com
 (2603:10b6:a03:330::30) To DS0PR12MB6559.namprd12.prod.outlook.com
 (2603:10b6:8:d1::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6559:EE_|CH3PR12MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: c9484dfa-0c78-49ce-6448-08de7954478e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	BosTtGqVqQtAUQAKQYda5vD33EBm7kW5kcodZVXVKzc0BjtL1dWOzvjjGD41OTQlzkhhxV45/yInIYDUJ2KztAmeSr6znk2rLf1SjjlNsuk9PJ+lfAAVrgyFlzecjGz+g7EY6BeQ7Uy3kuEiqe63MSzcOezyRs3X4UB3prmj5ZeGE+02jJDFsfEwsvxLXCxDe1rXojfevyiITtd9i/klskzz4ZGyjvJsgMY5xCynXbRkf04CDbf7dQx8iG3B+kQgdgBp3PNrPCglS568A8YAd1PcoU6R0rVaTrbHe+J7CRtfKgJmcvJHd0iPNxoxBUz6j0B0mXHZYKEQ9KiRJZMXmF/Izq1zp/4qaAlFa6faC8x+9ZEorWFCYFBHpV4CJKxM+cYMCa/KCIuz3s2zKrAzAVucwHd4dD3u/EJlubN6H4fTxTOmzTaP5wRoDIxGpt7t1pzeMyHn/8CspNQoqYTM5w8ULrkEGzml9Fn1CbfrsbT3Y9sqcVwSXQ8Vcrl6Kd1qdglrMtIWIiywGM+nh5pOFiCjd82PwueZTbvgI6G686hXRnxm2exzIEfnl9UkVdu2QNsp8oNoZ6fygmea5mtVn5tG3/3Sas1NsbPr04n77jwhYHxwKo1kTyiZ6yN6+Hky/Kznb2S9t/Bv+mPCqGfhhKr7ETlF7ysuMfqzq4KPf4QEi0ZxDBSkPISUVekCsbeNVFBTqPBlP//akrhcG89q+n88XoiTreN7sI3eciORkwc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6559.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9A7XCsfi/+4j2QRVU+3OSycnPkNzVuIdwYs/rkYSVh4hb4J/WwvJyZK8ONX8?=
 =?us-ascii?Q?Oxwi72Bk07o9dCRycj7CNpgDxkOAPpFHOo0cCneuNEC3T/cbF9inH24CpR9L?=
 =?us-ascii?Q?/yyPnQq8/ilnTpWdq97M3Y5TtCVmmNlJR0gRFBAN7Q81ZHGfx7m6utJ7dnsR?=
 =?us-ascii?Q?TgReZ44fuL/wNntbDY1fIhpmZHqSY//JBzceZSsA30ibFva/Q+PIokZZmoQC?=
 =?us-ascii?Q?fFKBYoViqX6MjVO6ZySNFJxkRJ8UrnhFiGxde00lAHBZsqJGG2Kp9tM701st?=
 =?us-ascii?Q?ypxFSJdPn2Ill+Ei95wIvtjaFYARpLoOraeYbbRWPcLF4GRJ4HBKOlxQGSS3?=
 =?us-ascii?Q?tNU/KVL+Wu+H2/J8ViJA4v1hQwaax66QzVbS9qCOO3p+KCit50uPhztFx9Zq?=
 =?us-ascii?Q?M+NsT5rzt2oxkYzK6wPwK+cwgEH32JBMcXLjmGLnK54CF7rl/mEyyc0aseKj?=
 =?us-ascii?Q?1id4YU12QJvyrNkS514DgwCNg4lRCBlrcUVB8DkMLqvETsrGcEZBzbtH8i5L?=
 =?us-ascii?Q?wIfDqPcg/naHUuPzQk3Pq+KxgTyp4S2TvMr8huotw8tLPjmKkvZxeB7XrI+T?=
 =?us-ascii?Q?6WlxD7eTmDbIDrL4HHwb/FvjA29+631SBu1cE0wgtYdWX8WlvHF/S+Aftj0n?=
 =?us-ascii?Q?IvlbGdvehzUUmJlsvJNMfbLoMwBiUDNlkqiLbn8aqmw0HrAikNgQKYEskg9t?=
 =?us-ascii?Q?Nli9G4y/aHA3Nv8P7IBjG8at/9jIcC8P5tSyODMrZpzgji2uQIfy9nFrK1Np?=
 =?us-ascii?Q?+lRf5VJVAn6hLKNBTTT1LbRrTndHAej1iI1S3obYBMbKyb11fkm7nq5l+FiP?=
 =?us-ascii?Q?EfxoqBChEVOFDUNWeXLEO0aA0wjoeGSyrhLcC9UHOCi/uhrRmXXKloctlNSP?=
 =?us-ascii?Q?iW0JxhVIjFEXQv5kUc2f8TnGSivnw+ExU5XIg13ohhGqBdsKSuZbU9T2L5I2?=
 =?us-ascii?Q?WgubbbOgTvE3liDELteo9/80OIQ0VB6ZuRt0PM6MG8ov50MR/ZUiLjsdrlJD?=
 =?us-ascii?Q?IDdNeKgrt70xkDhOkOLfhjPZ/TuYhagjkMo9On3TOeA/6CxHIPlY7XVDFOux?=
 =?us-ascii?Q?vB90D37wrq0mzLB+Zb1InrmW18j0YxwFjy/ZKoltsPlTUu/TAGOCebJIp4L6?=
 =?us-ascii?Q?pkue7m1omXkoePuq+EpNTmV4W3KazkxU7/PAqqnXBXnQe3g3KJRaWfz1C4Bg?=
 =?us-ascii?Q?j0t8fFMmECnOJ2CKVrvlpk91sR63LkBkwEo1Z/tgnIATwcXwRijbIJS2s2mf?=
 =?us-ascii?Q?6k/km3px67EC3+cIiI8Gi+OpGWtuuMCsXh5lfodov8efLCDPSJsoAcmluy4f?=
 =?us-ascii?Q?2SYeCqdSq6kypmnczeStgjGCjKOHIaOJEDqVQcXKRVILnPvGlyjfiq+czYij?=
 =?us-ascii?Q?QZn9jrRG9tjCofI60nMn1FSAQvxJc3tvDWkGpzE5771lyHV43n0CMWjyrsqq?=
 =?us-ascii?Q?GTMVrSqTk4SUN/+cSlv59VxNMIliuoW5hXcIniX30x6Fix3D3ofOMqz5yDQF?=
 =?us-ascii?Q?ZEdZSSUtH+Hc+NlKS6EjqQToCG8UnguUr0zadLQ6hLThomzGdVH40NxlH02o?=
 =?us-ascii?Q?b7IMIViC3c8eLHMOcXhiZ9CmyIy/Yq2MSO0RTLWm5lV8rdShyFmYVhWpFR5e?=
 =?us-ascii?Q?U4EWWHtzFlyger5QGJ8WsG2S9JX1gfC7B5hyMN0JSYaRDT5b17+yd213s3Ty?=
 =?us-ascii?Q?hrazNablXvhoZZKWmxzt4M+4SXgc+w4qkRdlFQAX0arrAODzzyKfeWM9ppCZ?=
 =?us-ascii?Q?CLLZ/nU40zK8UIIqL7sjqdabF0qwYEM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9484dfa-0c78-49ce-6448-08de7954478e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6559.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 18:40:02.2778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +9baL3edZ+y1+Dg3naCoF3LdwZ0jjgphi2EXqmId6dqlHABgImRo01gTdLXK/b3xn9sO1scUlhB3W3faHl4jTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7713
X-Rspamd-Queue-Id: 4E86A1F5662
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222925-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pjaroszynski@nvidia.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arm.com:email,Nvidia.com:dkim,nvidia.com:email]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 08:38:23AM +0000, Ryan Roberts wrote:
> On 03/03/2026 06:37, Piotr Jaroszynski wrote:
> > contpte_ptep_set_access_flags() compared the gathered ptep_get() value
> > against the requested entry to detect no-ops. ptep_get() ORs AF/dirty
> > from all sub-PTEs in the CONT block, so a dirty sibling can make the
> > target appear already-dirty. When the gathered value matches entry, the
> > function returns 0 even though the target sub-PTE still has PTE_RDONLY
> > set in hardware.
> > 
> > For CPU page-table walks this is benign: with FEAT_HAFDBS the hardware
> > may set AF/dirty on any sub-PTE and the CPU TLB treats the gathered
> > result as authoritative for the entire range. But an SMMU without HTTU
> > (or with HA/HD disabled in CD.TCR) evaluates each descriptor
> > individually and will keep raising F_PERMISSION on the unchanged target
> > sub-PTE, causing an infinite fault loop.
> 
> Ouch; thanks for the fix!
> 
> > 
> > Gathering can therefore cause false no-ops when only a sibling has been
> > updated:
> >  - write faults: target still has PTE_RDONLY (needs PTE_RDONLY cleared)
> >  - read faults:  target still lacks PTE_AF
> > 
> > Fix by checking all sub-PTEs' access flags individually (not via the
> > gathered view) before returning no-op, and use the raw target PTE for
> > the write-bit unfold decision. The access-flag mask matches the one
> > used by __ptep_set_access_flags().
> > 
> > Per Arm ARM (DDI 0487) D8.7.1 ("The Contiguous bit"), any sub-PTE in a CONT
> > range may become the effective cached translation and software must
> > maintain consistent attributes across the range.
> > 
> > Fixes: 4602e5757bcc ("arm64/mm: wire up PTE_CONT for user mappings")
> > 
> 
> nit: there shouldn't be whitespace here.
> 
> > Reviewed-by: Alistair Popple <apopple@nvidia.com>
> > Cc: Ryan Roberts <ryan.roberts@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Jason Gunthorpe <jgg@nvidia.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: Zi Yan <ziy@nvidia.com>
> > Cc: Breno Leitao <leitao@debian.org>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Piotr Jaroszynski <pjaroszynski@nvidia.com>
> 
> This fix looks good to me:
> 
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

Thanks!

> 
> 
> > ---
> >  arch/arm64/mm/contpte.c | 47 +++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 43 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
> > index bcac4f55f9c1..9868bfe4607c 100644
> > --- a/arch/arm64/mm/contpte.c
> > +++ b/arch/arm64/mm/contpte.c
> > @@ -390,6 +390,23 @@ void contpte_clear_young_dirty_ptes(struct vm_area_struct *vma,
> >  }
> >  EXPORT_SYMBOL_GPL(contpte_clear_young_dirty_ptes);
> >  
> > +static bool contpte_all_subptes_match_access_flags(pte_t *ptep, pte_t entry)
> > +{
> > +	pte_t *cont_ptep = contpte_align_down(ptep);
> > +	const pteval_t access_mask = PTE_RDONLY | PTE_AF | PTE_WRITE | PTE_DIRTY;
> > +	pteval_t entry_access = pte_val(entry) & access_mask;
> > +	int i;
> > +
> > +	for (i = 0; i < CONT_PTES; i++) {
> > +		pteval_t pte_access = pte_val(__ptep_get(cont_ptep + i)) & access_mask;
> > +
> > +		if (pte_access != entry_access)
> > +			return false;
> > +	}
> 
> There are 2 forms of "dirty"; HW and SW. Here you are testing that all ptes in
> the contpte block have the same form of dirty, which I think is the correct
> thing to do. You could relax to just test that every pte has one of the forms of
> dirty, But in that case, if a pte is sw-dirty but not hw-dirty, then the
> PTE_RDONLY bit remains set and the SMMU will fault, I think?

Yes, for SMMU we need to make sure the HW-dirty state is correct or it
will keep faulting. And while we are doing it, it makes sense to just
update all the bits to be consistent.

> 
> If my reasoning is correct, then I think arm64 hugetlb has a similar bug; See
> __cont_access_flags_changed(), which just checks for any form of dirty. So I
> guess hugetlb is buggy in the same way and should be fixed to use this more
> stringent approach?

Given sw-dirty is managed by sw, is it correct for sw to ever create a
PTE that's sw-dirty but not hw-dirty? If not, then I think it will still
work fine for the SMMU case as sw-dirty implies hw-dirty, and if it's
missing then we will set both. But for thoroughness it could make sense
to be stricter and add some comments there as it does feel a little
fragile. I'm very new to this area though so probably best for others to
comment and tackle this.

Thanks,
Piotr


> 
> Thanks,
> Ryan
> 
> > +
> > +	return true;
> > +}
> > +
> >  int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
> >  					unsigned long addr, pte_t *ptep,
> >  					pte_t entry, int dirty)
> > @@ -399,13 +416,35 @@ int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
> >  	int i;
> >  
> >  	/*
> > -	 * Gather the access/dirty bits for the contiguous range. If nothing has
> > -	 * changed, its a noop.
> > +	 * Check whether all sub-PTEs in the CONT block already have the
> > +	 * requested access flags, using raw per-PTE values rather than the
> > +	 * gathered ptep_get() view.
> > +	 *
> > +	 * ptep_get() gathers AF/dirty state across the whole CONT block,
> > +	 * which is correct for CPU TLB semantics: with FEAT_HAFDBS the
> > +	 * hardware may set AF/dirty on any sub-PTE and the CPU TLB treats
> > +	 * the gathered result as authoritative for the entire range. But an
> > +	 * SMMU without HTTU (or with HA/HD disabled in CD.TCR) evaluates
> > +	 * each descriptor individually and will keep faulting on the target
> > +	 * sub-PTE if its flags haven't actually been updated. Gathering can
> > +	 * therefore cause false no-ops when only a sibling has been updated:
> > +	 *  - write faults: target still has PTE_RDONLY (needs PTE_RDONLY cleared)
> > +	 *  - read faults:  target still lacks PTE_AF
> > +	 *
> > +	 * Per Arm ARM (DDI 0487) D8.7.1, any sub-PTE in a CONT range may
> > +	 * become the effective cached translation, so all entries must have
> > +	 * consistent attributes. Check the full CONT block before returning
> > +	 * no-op, and when any sub-PTE mismatches, proceed to update the whole
> > +	 * range.
> >  	 */
> > -	orig_pte = pte_mknoncont(ptep_get(ptep));
> > -	if (pte_val(orig_pte) == pte_val(entry))
> > +	if (contpte_all_subptes_match_access_flags(ptep, entry))
> >  		return 0;
> >  
> > +	/*
> > +	 * Use raw target pte (not gathered) for write-bit unfold decision.
> > +	 */
> > +	orig_pte = pte_mknoncont(__ptep_get(ptep));
> > +
> >  	/*
> >  	 * We can fix up access/dirty bits without having to unfold the contig
> >  	 * range. But if the write bit is changing, we must unfold.
> 
> 

