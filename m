Return-Path: <stable+bounces-245582-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMXGFMAuA2qN1QEAu9opvQ
	(envelope-from <stable+bounces-245582-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:44:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 608D8521839
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF62030D1079
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA80425B0AA;
	Tue, 12 May 2026 13:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="v845naFH"
X-Original-To: stable@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022126.outbound.protection.outlook.com [52.101.96.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46D938888D
	for <stable@vger.kernel.org>; Tue, 12 May 2026 13:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592004; cv=fail; b=BaKwvBVTuFHLcuxRT1B8lGPu+6ykSI1dqXOMnLF0hLmUWwEaG2M4r7XPoL/guoaWAPHAVREbVARfZ+b5hzdf1S1wvyPFmYNm3B+WoVn0+KJ1pwnXqnj9rE5rW4oX1Ix09AZJaUR3wVUWhKRqgRyzmAHT+wod6A9Zfh41hrAm3TI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592004; c=relaxed/simple;
	bh=FkRJFMIzPt/jMaqtdbR5UTDVZhbgzmL4x9x4jjf0wtA=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=A2zefXAidWsBxwT2BzV6aQ5hjMPCKAHe//T0YJNSR9BTLqlipN7leaQvOvY2NXdDMO+GC68VN7eOPmKUVaLx3mwzFrb+HaGE2nugkYYk3FYmbEW1bxXWDplFj0rEfW5iwU3XIWFWqVHbk4U0Z1ay4YptqMTwRk3bCSI+cxswd9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=v845naFH; arc=fail smtp.client-ip=52.101.96.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZvR3rDrIXGSWLc68B4shhx+kKCV5rbOJmLq/wZtdJ0/l/4H7MzMZJdE4yZoPAUcBjXCPl6dBSCAIJMGfL1AK6WdxyqMQ0H7wBQTCo6axK2fjqEzlAqAY7YRXxRSl0IAVSjQ/QSEX7rsoaVya2S/qtjC0bR9HtjqYxZM6jgX/KOCVAiWA8b+NJCyJor0m2Wf7cRifhk7Te11bcQ+Z3Lvfy9KXZjbQqQxUo1qelr0mmWa4+zeBn5ypVGNcwA8HfFXNeabg+ORGES0w5MEWcUpby87aY0dl4oiE+7Xt+nHlgmpUUktZH/vnqJUJg5u2PHpE+gBTZ2iBAaWvhtd6wl/kVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkRJFMIzPt/jMaqtdbR5UTDVZhbgzmL4x9x4jjf0wtA=;
 b=zC9L4+Mc8ETz0/pibEsnPxBUlvL03FKx4rxQIQiy4ZB7DdS4vCeqhwwCCA83X7bFWsQ1tzMvP9nDr6fYpGmGQEF+ARCLIyqFTf3qKf1mYORusaPS1DDpnssvyqjJV3PU8eHb+TV51DvfowBX/9bLk7xUlOTrArk4yr5QK2dnbxfJh8Ek1uDwqGnGjXxGfXxHGu9ZzP81MNL4/z4SYYweHY9t4dbXxHODlH1r9f6k3wb/lhhz1ykFGOVk27urWoJgSQTa05OWvDndWfcIcMrXZ0gzauaE//PKq2FpWPWkHFIPnWgwSLqtp76FZOmqcuWCQROTZUW9ge7RzgZ1Gq/GFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkRJFMIzPt/jMaqtdbR5UTDVZhbgzmL4x9x4jjf0wtA=;
 b=v845naFHh5DdPZ43by+JIEbbYFrb1WEhB4GfDgpPQtr/fTO0QYUeiab6V1Wgfkz+cpZO0Qj3dG55y0YTkGuM5VXVnXtHTQaxVyW23Hn7+nUmEPk6eroiz6O6FAt8CpP1rjaDCiypkPCoXToPn4oWCosV44+oP5U5W0Qk8+jLAZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB5332.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 13:19:59 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 13:19:59 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 May 2026 14:19:58 +0100
Message-Id: <DIGQ8S873GS4.2K07DXYH5QG4W@garyguo.net>
Subject: Re: FAILED: patch "[PATCH] rust: pin-init: fix incorrect accessor
 reference lifetime" failed to apply to 6.6-stable tree
From: "Gary Guo" <gary@garyguo.net>
To: <gregkh@linuxfoundation.org>, <gary@garyguo.net>, <ojeda@kernel.org>
Cc: <stable@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <2026051229-unarmored-shriek-4dc5@gregkh>
In-Reply-To: <2026051229-unarmored-shriek-4dc5@gregkh>
X-ClientProxiedBy: LO4P265CA0102.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::17) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB5332:EE_
X-MS-Office365-Filtering-Correlation-Id: a35bf7e6-3141-436e-5e3a-08deb0292a8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|56012099003|18002099003|22082099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	8ZJKH/vSxMn+DJX+Lyxv6twwMGfgzPl9wg4FYrn0quzZG9BXNCfKuLLnzKtyRORA6JMD1fXjFN8Ka5mFzY08XIrYYnuZmog/Zb/bde4JJ5QVEJAu4ANZisUVxfAZ7bMH0mxcMQbfrK4K1U0mYYJX5GthfOgZxHzHFI3moAfkDWpc9dCX4jw47M5991QkooxjA/IYG+J6z/n5f4A7mCTL0bA5yQyHiXCViIKtwXt8op1M9SUVoDCHBzm9PZLAJsZmuC2kdh2fJLQaSQV2gftNKS1HxrVR1dhe4l9N7P1usRHDLjZ8KKuUk/KpwoycdYjy0Sbmf2yvXqZajvEr2SBQZxPogAKpTmnMN7hVyPVS7jSI1WXsHFxmlUTnsqhmfMeM3D9k3SmBOwaauXpEDxsEgWfbn5LIsmNyCVMH8eGbKlaeoDnYpIrrkyGafRYCmnjWWw28LNdMBYyIck+4SgpXpctN8l5xyJM5K8YKrYoVC1+ngd6OCyE6qvtPZHuy9tReLOWtOS7pS846UNE+UHYsU49J1UiQiRwwVGnj0nWhIrmFVaX0NuQ/Rf2dOC+jJb+2/2oTPCXLPP0oePcY3/cRBhnw3WIxtiRayUW/1YzqGeG27t8sGTZ3Gr5Lk1lV3GvOvuA+QZJHjNveIJBNZrUE3mkSVtMQH9NPGUOrOKfw3JdZxTN3Vgv8Mq9RqihV4mVjZCxQ4aszUKLC0WARvvxv+w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(56012099003)(18002099003)(22082099003)(3023799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2VUK2w2d3hCMUlRT2t5UEhPbmt6UkozVXI3TlhsSnhBL3BVeFg4b3NVQktH?=
 =?utf-8?B?THNDU1kyWlpzb1U2SHQxYWRqSnVhK3QweE1pY2RHV1BtN3JwcUxabkZJQWF2?=
 =?utf-8?B?ejRZaTE0cWlOYUNyT3o4WURZVDE3aW8wOGJPZDJjak9XR0lvQS95N1Z5cU4w?=
 =?utf-8?B?bDB5WStrVStmdzYyc0RJWWtWZWEzRGxHZkpOMS9RV1pMTjhCR0tPeFdJdFl4?=
 =?utf-8?B?clZUZnFubUFEMzFUcGJEZSs4TlViV1JIa1lmQ0lPeVdBVExPWVI2LzdGRENK?=
 =?utf-8?B?ZXRQejhFdFlKeUNmT2hoQzdYcDhwRXBBSld6Ny9UWWV5Ylc0bXYrQmk1NEdM?=
 =?utf-8?B?UVJCQnpTempxb3lZdnhmK2hBc2txZHF5RWVLcmNvSWFzOHptaVBkMFQyL21s?=
 =?utf-8?B?WC9vNXVhdEdtUnJSS2ZBcWlBa2JZelRnR3Z6ajJ3cHFhUTNldjArcHhRY0xS?=
 =?utf-8?B?dUJMTGM2eDh5SUp6a2VDdVdac203UThWUDg0TDhpQ2k0czFOeWRRQ2xPd3k1?=
 =?utf-8?B?bDBSUG9wZGpyVHBNYVM1MDIwbnJFSXBpd3ZTSnZ0RWVZR3drTkh2V2JYNFNa?=
 =?utf-8?B?WlJvMG9zNS9FcHpsMUExVkFveFJWVDQ0UVp2bk4yQjNUcTFGdkE2UWxmM1pJ?=
 =?utf-8?B?dFZwOUNoVXV1WHhUWHZ5ZHBQUEtTdlJFQmRJYUc3dzRyejRVSDg1alFNU1pH?=
 =?utf-8?B?VGF5MTU3aGpIWUdPS3BJR3U5czd5Y1lPRWV3TExrUXlmUEJJdEFzdzUvbGpt?=
 =?utf-8?B?d1lWMXY4RWhWT3hTWk9VYjRBR0IxdjEwWUtnZTNoMlBwOHlmMUNTd1lmZy9X?=
 =?utf-8?B?T2VVcEtqcmx2YWI2WVlZK3FkOXpoa0RySkg5NzFCS3FTMTdiclVNSmhaaWFv?=
 =?utf-8?B?K0xIVTdMVWwzT3MzbjdjeHVBeHU5ZHltVHNSbUJMRHFFL0Q2eHdFcnNwVkFM?=
 =?utf-8?B?M2d0OGtOWnNCWHVUMXJrZFU0RFBLQXAyV0hyd2s0eHJOQUdNSitsR2pHYnF4?=
 =?utf-8?B?VGNvRFIxaTNXV2xWRHNnQi9Pb3pBUjVsdTZ2OCtzdDh2MUdpYklKSVByb0FN?=
 =?utf-8?B?VEhzS2IyT21BNGIxTDZoQTVrSzJtUEI0TUFSTXFJdVNkcWoyZkZWRHdDUzNS?=
 =?utf-8?B?UmRKNDk0YzNTalF3ODBTWS9NaDl4aVR5M2YvQ2ZYMWlRaWtVdzRFQTFkUjNu?=
 =?utf-8?B?d2IwUVpURGxkUUlBVzJsQ2NZRUFpWHJPS3ljVGlqZmxpUElCc0dkYmtKOVNC?=
 =?utf-8?B?bkZ5elBUSTZhdUcvUFo2Z20zdGl3NWE0c3BSUUk2eDUwN2I5V1Q0Ym5MTHpG?=
 =?utf-8?B?ZE9raHlFQ2psU3ArczVZNW9xdUluZTFGbW9ZUkwxbEd6cVRlbCtab3dkamZX?=
 =?utf-8?B?UGRYeFdIMVJwYU1COGp0UDV1VjQvR1lwTXJBdERvTHEzL0FqcXRvR3lCWXlp?=
 =?utf-8?B?OE1VS0pML2t6U3J6Kzg4TTFzSW9pYXVLa1d0TVlEeUpnR1NjWjMzS1QzWkVz?=
 =?utf-8?B?aFZvRXBVNzVha3JEbHFCT1o3UmFoRGhEc3M2RUF0Z0RuRktVVDdBZkNqV0dN?=
 =?utf-8?B?NDYxN0FXRWZEMEUzTS9DMDNwS054c3EzUlpFK3BBRkdlZHlSWnAzbE1FdTBj?=
 =?utf-8?B?ek50dGR6TG9uRnd0YmhqU3d0cCtWSlJRWENQN2pDb0ZCMXl3STA5RXA4RGtB?=
 =?utf-8?B?dXc2YUlkbVl2RTFDQmoxMEgxMzJweXAyd2h0YmFhVXRQb2Z4Z1l1Sm1vQUNN?=
 =?utf-8?B?c1c4L3IrcHYvdVh4VkVvNDJIZ0dnb0svQTJBRHRyTVphMEUrSWFTeldjYmp6?=
 =?utf-8?B?OENMdHl2Q1hGQklLTStFWjl3SFc4b3M1bFVvYmlzWFZXbnFFZTRpclJFemhp?=
 =?utf-8?B?VjRIQ1hHRTdnNUIwekx4ZHByQ3dwakdKMmNUSWU5M2VHU1VOM21SUzg1eHJ2?=
 =?utf-8?B?U0F4ZjI2NnB5R2Q0ZDdpd25tRkFxS3MzSFhSY2dMcVY1cHovaVVPUVRZVzZW?=
 =?utf-8?B?eWlrVXZCQU50WGY4YS9LSjJJY0FBQ1cxaEtIVTIwcEVTaUNIMzJpNDVIaTBP?=
 =?utf-8?B?cXhrcjV0R2lxdGd1Q3hPSlBBdTBrSkd0R0h1VGY5bGsrd2lna0drVU5tWnZS?=
 =?utf-8?B?aXNhbnpCdWlxalo2RFF0MFRNWng5K1JPSjE2dE1ueFE0eFI2REQ0R1U0a0wr?=
 =?utf-8?B?QmlrZ0tJWm5WZitqbzJnelZscHR3cXZBSGlzTGx5Um12L3dCWHphb1QxRlhp?=
 =?utf-8?B?c3JGZUd2ek1jSGpRdkJkZG5TeHA1anlLbkNvcVJGaTF3VGNLNXpRYjlheGw2?=
 =?utf-8?B?aFlXZTZaKzhWZU9WWUx1M2RlakhnaEx1cGJxSnBGbVR6dFVoK202Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a35bf7e6-3141-436e-5e3a-08deb0292a8d
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 13:19:58.8313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IfrRsX5Wm5WinrL6P5UvtGUQM2VNgxVRNBEDWfu46Ejd1hNxt6Rj6xtEXwn5aViTpZYCBtO9pvKH9uBWxyP4Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5332
X-Rspamd-Queue-Id: 608D8521839
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[garyguo.net:+];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245582-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gregkh:email]
X-Rspamd-Action: no action

On Tue May 12, 2026 at 1:44 PM BST, gregkh wrote:
>
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.6.y
> git checkout FETCH_HEAD
> git cherry-pick -x 68bf102226cf2199dc609b67c1e847cad4de4b57
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051229-=
unarmored-shriek-4dc5@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
>
> Possible dependencies:

Looks like
https://lore.kernel.org/rust-for-linux/20260325125944.947263-1-lossin@kerne=
l.org/
was reverted in 6.6, so there's nothing to backport here.

The macro is still unsound when packed fields are involved in 6.6, but ther=
e's
no in-tree user affected for this version.

So I think it's fine to skip.

Best,
Gary

