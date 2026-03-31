Return-Path: <stable+bounces-231425-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aE6kDnPOy2mILwYAu9opvQ
	(envelope-from <stable+bounces-231425-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 15:38:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC99F36A627
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 15:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1EF8F30848C3
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 13:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B2C336EC9;
	Tue, 31 Mar 2026 13:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="B1UEjIr6"
X-Original-To: stable@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020076.outbound.protection.outlook.com [52.101.195.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344883019A4;
	Tue, 31 Mar 2026 13:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774964188; cv=fail; b=NY37EpY/4mxJdLfPnSfcZTGtNSokiPoBhP9RAwhYdWHOd6hx2SoqhPQDkQ+jV2Z4mruGf7J1TOnOOnNai95l5zsNuQ32Hr+KEuQrmYSOdd3puIkupETBSajxzRtJ3MWKe9YeWfgNmzBzdQc9AgSZiMLqiIWy84mNPX47nAbQPR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774964188; c=relaxed/simple;
	bh=jVQSFR8aJLNBQ8+4ptOLz+Av73t1MqowRa8roZqaypI=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=UnQHlaLsFlycrwuajowFGZ58vO04y7fI6gcys8h1XOpXnPHZ/Cu/RK2J7q2xh6qnwZiV75IVbNV5ESKf4+LwZqTyNmpWQwYv0hBrNHR1nAPnlBe3+RcpZ/RY7gNoOqd1dT+3L2ijGchiWZPjqgHg0vciB/GQbFn80Gn2V0DTToI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=B1UEjIr6; arc=fail smtp.client-ip=52.101.195.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPgFVaBXyytpYs/zfioLw8Ep0AHjEFRn6MkmEmY6AXOGpwgzMIo27Dep/a9Mrhhb/PgylA3LG5hld30rfVWoSgbEIDKEpc2UASgiiIzHVsls092ByU6R6zwTB4ZIwQUKbOSHdw9KAK/9TKlqRxvvje93ovPt96KS0bCi8DxJ51hBbktppyyMa5RwzNRlE1TM27A0utyl7K9Lzq3tWFTw4+V+hdCzYF6O0+Dl90oscBMIVd7kcJzIwQTvdkSriXyuLGP85pEPd4YOJO7k64KfHvftn0nndbJRJhFSB9UlWVSt+2k7DEBCvZbQhggSWMlH3+PgVBm1xpwo9HAjAGgXQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlgRpYwxg1tHtx1uxfFXfpAu83KJo7MmByAOym7h7A0=;
 b=Jq0bZYG4FfIb38f6vI9myUqx8XDrrSSIlP8XBQWuk141Qg9bRvsdKiqEH/Ix7/haYDqBxNlYW5pAUMnYEeHztrW+6ARORTW1AbFTMpNDLIc5JFTU669TnZm70ZYwAeIuZOeH8n1p8ZVdsYrLUsj14GQKTmjMKovkSvEXhHmDY6Grsk393sSXHzdWMWttUZSOt8B3pmx0gC0tib/nutf6HKO4qeodLU33TxfzLyILyZujgQanCpJJeFaXxic1aNtHpk5Gul+gaJsCeyKvTda1eHxxLLgmU/xewmbOrDl3v4tOsXso89kPXNJldXV0EXPEacsFPWM1f1sn/8DRCBHJnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlgRpYwxg1tHtx1uxfFXfpAu83KJo7MmByAOym7h7A0=;
 b=B1UEjIr6Pi7ffqQ738dQsuQQowt3QWltXBCycnGborXEiH3oHd/Jc3VMzyiwQHObYlefa+EWlYgwAaHvkeDxC48JcpGbnwHb6zfTWdcq1tzAixgxvqM0bo6L/6LSNxmjHKexZAMNmVeFQmUVAvhsWt35lRWSzE7BMnY3Zs+jJ/E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2727.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 13:36:22 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 13:36:22 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 31 Mar 2026 14:36:21 +0100
Message-Id: <DHH0AG3OW3RO.O79RKFY0VR85@garyguo.net>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Tim Chirananthavat"
 <theemathas@gmail.com>, <stable@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6.19.y 2/2] rust: pin-init: replace shadowed return
 token by `unsafe`-to-create token
From: "Gary Guo" <gary@garyguo.net>
To: "Greg KH" <gregkh@linuxfoundation.org>, "Benno Lossin"
 <lossin@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260325125734.944247-1-lossin@kernel.org>
 <20260325125734.944247-2-lossin@kernel.org>
 <2026033133-reroute-sugar-4d95@gregkh>
In-Reply-To: <2026033133-reroute-sugar-4d95@gregkh>
X-ClientProxiedBy: LO2P265CA0225.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::21) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB2727:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e486cfe-ee02-4e2a-a569-08de8f2a7f37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6sgjOdlQDcBNk+g225wMu9qpUxS+fe8+5gtJr1KqGCguBkmuBjQiul2g0UWa6rT9O7iJ9gV7pc9RFe1LD8dinOmAzwKE+L3fYjwJ5SDzQmptuEq3kRyLeTJc7HDOYzsZw5Dwf8FFl4ObKaHVguCcgYjj/gaOy6f9kVvlYGwbdwcggOX+pn4+fVaSGqTbH9xznJdG3pC9EX5Cw7HG4LIx5ssBq1QBZ8U3opHte2vghq3WyoBjtK4zYl0ydUGj5QK53mdlITAgRszi9BRIl178ib+F2Oxxh57loiuZNBb5xmbx9S8Ddkv4xK6Z+tBnP+4N2nZvTAcDj6vVQc9P72fAyXEa/jWwYWMHWLkjMUzwb31leXcr/mSnWWlKpEQavEWRM/hXlhDme1J8X1UHUo4pk5ewGK1yyFPlYoRUq7O7Q8ZOtMst1Q7J8REmE9BqXqu8cYAK4Sc1Jp6yxREg54NCCHBR5Y6+22d7g1Wgl9HxFaxC3ocvkmp4G672qz1YJi8aONldJ4KxZkdb0gfOTyhymYCrFPSFiP3+lI/pg+tGsg6Je6RVwOf6sUKEBGmNH7EzdzKBYdjcuR/j4GccZ9weLtDkAETmckwWdW/GWFBQbaoUHLWih8Sgmcv+wOl/EJoslbXB7RMa1uTQcCKIRXaemrN0b1JCRgFr8kb0KylRBOKqeLD3I1T5pzI1zJAovKXk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFk4SUFyc3NsVTBoU0VScEJ4RlRrcWcvZ1FsQUo5SjJWUzFZM3NXakhwa3VM?=
 =?utf-8?B?OWFjYzNpUUV2bG0rd2Q2YTdzSUZPVVJUTVdYalptaXI4RXRCZk9pbTM2YXpX?=
 =?utf-8?B?a295WUZvUVpQNURaN3Q5ZW41TzIya1BLZjdZZXVMaWRaaHFSNExTMEQxQjBW?=
 =?utf-8?B?a05oTUtybzd2RE8xUGwyUlAvbkR2VW9hNHN2YnR5UE12dmpvbThvREE1UzB5?=
 =?utf-8?B?Mk5XSmRueE5BNDBKalJmTWVWN0NJZnNha2gyMlJmZ3JYdkEyZTFnUnVyU2NL?=
 =?utf-8?B?VWlXUDVlakVZTTg0UjErVzlHZDIvZm9oR1k4WVdKd2xJN21pdHdHYyswTGZX?=
 =?utf-8?B?cStxZkM5VjBGVUZhRUtuTXFGZ09uSmlydEgxYmR6M1JIZng0NERQWEswTjdF?=
 =?utf-8?B?aE5CNTNtSkFLSjJaclJrdGcvcnZoVHo5ajR1bVMvOU4xeXArLzhzZ2luUlg2?=
 =?utf-8?B?ZEc5d21vWGlaZ1JhR0I5OWVVbUh4K3prZHJxSTB4V2NoRHIzaDduK0dvQWpr?=
 =?utf-8?B?UktWaGR0ZlVoaFN3UUZNMHlvTWloTTVCMktaZlZTdGpUdVovZ2toOU9UU1dr?=
 =?utf-8?B?eXVhVGxnNG9aSDRGcmxIelhNV1dpUHNkdyt5Q3hwRHA3ZG5UQ2ovMC9KbVEz?=
 =?utf-8?B?QlFXQkVwRnpDeTl0Tm9LeS81Sy9wNFdNZUlMTmxSbHZrc2RuYlJMMHVFWnp6?=
 =?utf-8?B?dFFieTNmMjZ1cGRLOUJEOWJVWDMxRFM5QUdIT1VlRktoN2REb2puWFU5SmlV?=
 =?utf-8?B?RExhRTNFMS92SkNIV21UZUpFdStLRHFkd0V5dmRDVzBuZVpoRUlUYnRsRFo0?=
 =?utf-8?B?TkRpd1J4dlE0ajJyQ1hKQ3ZsZTdvT29TL1FmWlhhYWJvOTFoc05IZVdIdklK?=
 =?utf-8?B?cnRFdDE3T1BtODFzdXlXa290b1g1SG0waDdudDdIWXZFeFpXZnc4UzRVRkxr?=
 =?utf-8?B?cGNrbUhpVHlHMDBwYWlyd3RFQ2lUdTdPRjVST0tNa3JibFQyR054M0RSMVlo?=
 =?utf-8?B?VFU5b1M3ZzJiTmt1ckt1WGlUZmMyYWZjcXFKMmJoUzhKMEhFYXF2c2lrZVdV?=
 =?utf-8?B?RFZtQlhrUm9xWFBOT1ViQUZMYkRqS3U3TzJ2eUQ4RTQ1WDBHNmZSaGtqTHEv?=
 =?utf-8?B?ZEk3cFVNZnNKMTYvaC8waVdrMitPOW5EVFZRK09LWCtWdEZGQ0RReFE2RlVs?=
 =?utf-8?B?R1NEclM2cEpVditSN2pjQ0dORTlRbXZBdXh3aUlUK0QyeTJUMjJualIrTlJw?=
 =?utf-8?B?eUtXczY4TW5MT1o1dHFSVmx1WW5NWHdPQitpUE9yNk92dUUydnNYU2k5VFV1?=
 =?utf-8?B?WjA0WGx2V3NKUExjT0ZsVkFzTUFJOFhBRExhVkpPR0FPWlFLMVBxVGViUWdp?=
 =?utf-8?B?MXlTM0JRbXQ2K2JlWXduek1ydnA2bFM5dDZyRjNSOHovM2dTUG1CZElnUUpE?=
 =?utf-8?B?VC9pMVE3dmZmZXlSL2dHVkZFS3pWODJrNS85ZS9OS3pSQ3Q1WWlmMENKT3lV?=
 =?utf-8?B?N0pnaHhGTTFsbXdrNDN3TUoxcmdzNEdzWHVhaUIvWmNEbk9ad2FYV05DTGs4?=
 =?utf-8?B?Y0lBUGsvVjFZbThWN1JVb2s5eFFYWmtRYnJBcW1XZUdhamwzd3ZnRDVqaWpS?=
 =?utf-8?B?Q2Raa1BPMWtIa2krNnhpS3dFdUxqaCtHMHJFd2tCSjEvRzk1OGl4NlZWUCto?=
 =?utf-8?B?YkJuWVViUU9zWVo0aWlFOFE1MjJra2NBUDkvbXdvWTRMbTBoTGc3S0NublpQ?=
 =?utf-8?B?M1R0QkV4KzRZZTJudUFLQ0VubDdTQ0xtRmZPeVFwcG1zbk94WmxmM09QZkd0?=
 =?utf-8?B?b3czTlpqWkkxa3FaVXNoamNvQVpqQ1lOclgzbHExUmdQamRiWWxudXdxSDRO?=
 =?utf-8?B?eTNBWlJVUHpQK0N3c2gvck92NjFacUVpdHh5T0RZWGpHNHh4WTBUZDdPRTA0?=
 =?utf-8?B?NjlkWG9udTdTNXU1Q2dtdjAzNFp0ZmhlK283SFZraU9sQVdhamd0RDdVQ3F2?=
 =?utf-8?B?aWpSNzdYOVpBd203TkFrcE5Hc0I2V3NBaVhsRTZGYlM3SS9JZ05Bc0U5YVFG?=
 =?utf-8?B?cUFBWFUzMU9SeGJZaEVJczhveU9CNGNUVG44bFMrRVVsVzJoRjQzd0ZwQ2t4?=
 =?utf-8?B?dCtvOWxkeDJ3bG1jWlh0Yk14T1IvTHZ0ZnloUVFCTmxSeUE5dFhkT1phd0dY?=
 =?utf-8?B?WXA5cDJ1STJYbVFHcTE3eTV0S1NwMHQ3b2hoMUpUZS9OakoxMm1aQXJkelFW?=
 =?utf-8?B?ZU0rOVZHeWllK0Rad1ZvSTVyMzZyT3ZwaDhkT3lUZUhuYWpvM3FrMGxURzla?=
 =?utf-8?B?UEVTeUJtQTlMMEdEQWZ1SUZaWHdnRWFNOFpjY3NaZzFScmRwZmFHUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e486cfe-ee02-4e2a-a569-08de8f2a7f37
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 13:36:21.9879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZn9wTd2tNN4w+CmXkT9YzTLaP0mVGJ3BmkpbSAX4enDE56KlVtUMFXe1kYGUcnvPjCsw/Rb5iOK0u99Vby+FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2727
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231425-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,msgid.link:url]
X-Rspamd-Queue-Id: BC99F36A627
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue Mar 31, 2026 at 11:17 AM BST, Greg KH wrote:
> On Wed, Mar 25, 2026 at 01:57:32PM +0100, Benno Lossin wrote:
>> [ Upstream commit fdbaa9d2b78e0da9e1aeb303bbdc3adfe6d8e749 ]
>>=20
>> We use a unit struct `__InitOk` in the closure generated by the
>> initializer macros as the return value. We shadow it by creating a
>> struct with the same name again inside of the closure, preventing early
>> returns of `Ok` in the initializer (before all fields have been
>> initialized).
>>=20
>> In the face of Type Alias Impl Trait (TAIT) and the next trait solver,
>> this solution no longer works [1]. The shadowed struct can be named
>> through type inference. In addition, there is an RFC proposing to add
>> the feature of path inference to Rust, which would similarly allow [2].
>>=20
>> Thus remove the shadowed token and replace it with an `unsafe` to create
>> token.
>>=20
>> The reason we initially used the shadowing solution was because an
>> alternative solution used a builder pattern. Gary writes [3]:
>>=20
>>     In the early builder-pattern based InitOk, having a single InitOk
>>     type for token is unsound because one can launder an InitOk token
>>     used for one place to another initializer. I used a branded lifetime
>>     solution, and then you figured out that using a shadowed type would
>>     work better because nobody could construct it at all.
>>=20
>> The laundering issue does not apply to the approach we ended up with
>> today.
>>=20
>> With this change, the example by Tim Chirananthavat in [1] no longer
>> compiles and results in this error:
>>=20
>>     error: cannot construct `pin_init::__internal::InitOk` with struct l=
iteral syntax due to private fields
>>       --> src/main.rs:26:17
>>        |
>>     26 |                 InferredType {}
>>        |                 ^^^^^^^^^^^^
>>        |
>>        =3D note: private field `0` that was not provided
>>     help: you might have meant to use the `new` associated function
>>        |
>>     26 -                 InferredType {}
>>     26 +                 InferredType::new()
>>        |
>>=20
>> Applying the suggestion of using the `::new()` function, results in
>> another expected error:
>>=20
>>     error[E0133]: call to unsafe function `pin_init::__internal::InitOk:=
:new` is unsafe and requires unsafe block
>>       --> src/main.rs:26:17
>>        |
>>     26 |                 InferredType::new()
>>        |                 ^^^^^^^^^^^^^^^^^^^ call to unsafe function
>>        |
>>        =3D note: consult the function's documentation for information on=
 how to avoid undefined behavior
>>=20
>> Reported-by: Tim Chirananthavat <theemathas@gmail.com>
>> Link: https://github.com/rust-lang/rust/issues/153535 [1]
>> Link: https://github.com/rust-lang/rfcs/pull/3444#issuecomment-401614537=
3 [2]
>> Link: https://github.com/rust-lang/rust/issues/153535#issuecomment-40176=
20804 [3]
>> Fixes: fc6c6baa1f40 ("rust: init: add initialization macros")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Benno Lossin <lossin@kernel.org>
>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>> Reviewed-by: Gary Guo <gary@garyguo.net>
>> Link: https://patch.msgid.link/20260311105056.1425041-1-lossin@kernel.or=
g
>> [ Added period as mentioned. - Miguel ]
>> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
>> [ Moved to declarative macro, because 6.19.y and earlier do not have
>>   `syn`. - Benno ]
>> Signed-off-by: Benno Lossin <lossin@kernel.org>
>
> This commit blows up the build for me with lots of errors like:
>
> error[E0433]: failed to resolve: could not find `init` in `$crate`
>    --> rust/kernel/maple_tree.rs:393:20
>     |
> 393 |           let tree =3D pin_init!(MapleTree {
>     |  ____________________^
> 394 | |             // SAFETY: This initializes a maple tree into a pinne=
d slot. The maple tree will be
> 395 | |             // destroyed in Drop before the memory location becom=
es invalid.
> 396 | |             tree <- Opaque::ffi_init(|slot| unsafe {
> ...   |
> 399 | |             _p: PhantomData,
> 400 | |         });
>     | |__________^ could not find `init` in `$crate`
>     |
>     =3D note: this error originates in the macro `$crate::__init_internal=
` which comes from the expansion of the macro `pin_init` (in Nightly builds=
, run with -Z macro-backtrace for more info)
>
>
>
> So I'll take patch 1 here, but not this one :(

This was dicussed in a RfL call, and we think it's fine to not backport thi=
s
specific patch.

The soundness issue that this patch is fixing relies on code deliberately
triggering this, a future Rust compiler that enables path inference without
feature gates, and people using that compiler to build an old LTS/stable ke=
rnel.

On the other hand, the other two (or 1 for recent enough stable versions)
patches have known broken out-of-tree users. So it's good that they're
backported as code could have relied on them by accident.

Best,
Gary

>
> thanks,
>
> greg k-h


