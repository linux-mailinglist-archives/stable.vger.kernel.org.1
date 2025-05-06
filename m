Return-Path: <stable+bounces-141839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 679E8AAC930
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 17:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C18D81C40A35
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 15:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9073428315A;
	Tue,  6 May 2025 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuka.com header.i=@kuka.com header.b="vVC65tZF"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2082.outbound.protection.outlook.com [40.107.103.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0FF26656C;
	Tue,  6 May 2025 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746544364; cv=fail; b=piAWUtUw6INaTJ5Me4pDdXEZ98yczH3HxfGbiVkseW8KtVxO/DRBRlRmkYfD08Jiia1OrTi2XrYe58CUQLmOlNjxd6E45hTm0kT+xsFObikeNc0bsAgy/ohWfg9zCiyjGx1r7koZFtB2INFn8KkahBRlpBEvblq3WVLSXFJ+V40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746544364; c=relaxed/simple;
	bh=rVMfvUpH392Hg7aPtks8FmI8PfhC0btZ8ucxmMMMdPA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dNCzJk9d6OiZtjBqTgxxfcZLYHO6ppHqHz2lSshcOXbnH9DNEZpmpBLXWANzh5lWZesnqQQWZUuASRR5HGhzbXJgIjj07G97g2rnGYUHSedFItTBd5Rpnxscre0ODR8HNdUSvJf7pV7czavoKLoqeJG9d1e5Jm7hFrOpFJhL3ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kuka.com; spf=pass smtp.mailfrom=kuka.com; dkim=pass (2048-bit key) header.d=kuka.com header.i=@kuka.com header.b=vVC65tZF; arc=fail smtp.client-ip=40.107.103.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kuka.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuka.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fe457DQs87qt6vGT2j5iuMGbv1njjjYBefy02r3lrk+mnsY5VFVVxguhvZoj8fRWc1kAn2uPc+ZxBDlYCQhZ/8jm5RBSZM91vnZ4M7DA9lV1655PND2mHHcS58aOvdf+Rm4rd8nPV8CkyfsaWS5sC1+pkeQBV4CZsrFNmjqMts6DutSVUxEFtR033pX3zb+Hoo8X2NtXHRmdM7oH8gK+gY11ggGSvxCCCQgB3M0B7+YJTMbLjQIA9T68i+xsTregRPl0shNHenZyzMjac8n5tudcz/CP8GFvBp0ZBgKrS1yomHCR2WuY1xV+ih47Hea00sa0orUXTjaJxPSH9+U4KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVMfvUpH392Hg7aPtks8FmI8PfhC0btZ8ucxmMMMdPA=;
 b=uj8Rpvy2ZrcmPL7HDZrFwiH3U3UnNkAKWLmMgzEPpugW7Urw9S5tABm6d1JKak2j/dfaIxQKAJn/8i7KqSObwu6n0b5Cm55incYezB4iZuCvyV5JwlyUshFwmL910I+lB9skBDGBn6RjGHSYRPiOynnZJtmoadp4TbKoM7KNyQ51MIqpmLONXS5mewPzdYM6HPqosF6v2K285gBlFBZNtHgsErNnwFZgfxKsE5A7EPDvXsFYsV4QaquyXNsr3ZOwkPrwvWxGs/N+kay/U4310fCJ4pV1zBVXa7kEJWpYPTs2lyvknhcgRxFdyuRfzMcJJpTxjZ5c6Hym4pJaY9V6sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuka.com; dmarc=pass action=none header.from=kuka.com;
 dkim=pass header.d=kuka.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuka.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVMfvUpH392Hg7aPtks8FmI8PfhC0btZ8ucxmMMMdPA=;
 b=vVC65tZFT3wYamX08teuFEETkikUcVrwLTV4F+J7vgFKBnEiqulIzdXd3y/oinRxuDRluhEi7hvwLID1fqAxmaT0CcRu3XxxidP2rNsWdZ952ywlOs7+gzOHGlmjux8luil7h4Ia/r1aKF3ZHfa11vFdbL+mORZgusP9iwVICOV/gQ2iCYiED8exlNP6n/h6ioIoice1gZCQcyxv9BD6gonWRUOYKEBNYCqUdCwPVmtpp07m/CYS4SIcoHCdFFEWcBecBJBd34pEw8FDTzjWM5gQGM2V3FhDryLI/K++BSP4NayF9qJIm8ex+oRkL9SatxCln2xktxmHsE0s/QI/yA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuka.com;
Received: from VE1PR01MB5696.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:123::12) by PR3PR01MB6283.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:3e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 15:12:39 +0000
Received: from VE1PR01MB5696.eurprd01.prod.exchangelabs.com
 ([fe80::ac38:4740:6a66:b5ba]) by VE1PR01MB5696.eurprd01.prod.exchangelabs.com
 ([fe80::ac38:4740:6a66:b5ba%4]) with mapi id 15.20.8699.019; Tue, 6 May 2025
 15:12:39 +0000
Message-ID: <cc3365f0-7f52-4fa5-bad7-8c761150bbb6@kuka.com>
Date: Tue, 6 May 2025 17:12:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Map MAP_STACK to VM_NOHUGEPAGE only if THP is
 enabled
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org,
 yang@os.amperecomputing.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, Ignacio.MorenoGonzalez@kuka.com
References: <20250506-map-map_stack-to-vm_nohugepage-only-if-thp-is-enabled-v2-0-f11f0c794872@kuka.com>
 <5ebcdd05-1c82-428c-a013-b7757998ed47@lucifer.local>
Content-Language: en-US
From: Ignacio Moreno Gonzalez <Ignacio.MorenoGonzalez@kuka.com>
In-Reply-To: <5ebcdd05-1c82-428c-a013-b7757998ed47@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0445.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::18) To VE1PR01MB5696.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:123::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR01MB5696:EE_|PR3PR01MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: b9656278-b2bd-4526-d06f-08dd8cb070b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGFDQ0dVc0VXTG53VUtjMTdtZlNOaFJ4S0c1bzNlenNBckE0enpFTmhyaHhm?=
 =?utf-8?B?VVRwbmVNZ0txWmRZWlRlY1k2TXZVN0J5TW5NV0FFRFZyRXNjNHQ0MlJPcTJl?=
 =?utf-8?B?dEJHTjk0cnVxbTNNQmc0bE1VLytzVzRDbEhEcmNzRVlRUmlPb0x6UURBN2kr?=
 =?utf-8?B?aXNseFpCVjVVaVF1TW9TV0dxYW5GeC9TREtOWG1ocGR0aVA4TzNGeXF4K3ZC?=
 =?utf-8?B?MDBtRzVwSjN3Y1J4NmZNQ24xeG44Q21rVncwWXhQdmZmU0xCd1JQSFhKVzFL?=
 =?utf-8?B?VkMrU2M2THcvSGtFOU0yL1lSMjlqWmQvSFBxZ0hEdy9Wczdjc2hLVGVxbjRj?=
 =?utf-8?B?ajExUjlQdWxKRjlNVjlKVXg5ejdYOVdKeWkzMjFMRGV0dHBmZ3VoM1JRNFNT?=
 =?utf-8?B?T3p0Mm5Iamgxbi9heCtMNU51M2I1MUtaYW4zNzdxR2ZlZnJhVCtjeUlTMEZC?=
 =?utf-8?B?MWQxeFlSU2YyQ3JiTVNDdkRmYlppaytYOUl6L1kvdVRwTXpVVVFMeGhhQzU3?=
 =?utf-8?B?L1Jsb0greFFXblVvRGNCdzhDOUtyWmdEVnZ3WlVWWFM0Ykt0OW1sdlJ1UUtm?=
 =?utf-8?B?NGdmbTQ5RWRabWJySng0RDlpTHdoczdUUE02NEpIcGJPbElNV0VRUElXQjB0?=
 =?utf-8?B?ZmlpL09tQlUxcGZscjNBQUsycGUvK1VvOHF1Uy9hNjY2ZnhQTlpWdkdUS1ho?=
 =?utf-8?B?YjQvVXM2c3ZiNmY3RXRZaFJ5Y0U0VCs3eUl0cFdhMlNlMTdTSkkwMHVsSmNm?=
 =?utf-8?B?bjRacU5uT1A0YUZGOHRTVDZJcHR5Z0dRWUo3dldkQWt6NUJVZVlVamI5RVlm?=
 =?utf-8?B?NldmTURrYnZ5NWltU3ljQ3pqLythOC9pZzMrakxYeXEwalcrRzdYRTJ6YkNz?=
 =?utf-8?B?SVVRV0JMdmNoN29RWURSd2JKUlJRSkN3SnNjUFFrd1FCU0ZzanlSSDZLUWQw?=
 =?utf-8?B?TE5NbktVR29hVkNKM0g3NUlVUGNNU0RuK3JuWWMzRjBRNHJwMklZTU56QUpq?=
 =?utf-8?B?YTBpL255QTFvVWVlOWNFNXdmZkFjMVBhbGFLVzFHTG5nVEZxN1BnNkFjRE1K?=
 =?utf-8?B?NTRLTjNlMnEvNkRJTnZMMXJVR0habTFSbmdCcGxXNTJ2MGNZWjNmK1FuMFdN?=
 =?utf-8?B?cnRuT3NXb1YvRWhXTEtzRzA5aGpuT1djeXowRGRURDlXSXVSeG04a2hxK1lH?=
 =?utf-8?B?bTNvY2NyYVBqZW5FQ2l0aVNiakZEa0xTbWRGVkpYVE1LdkM4cXllWmNUc1N3?=
 =?utf-8?B?SVZLa2tBUGI3NUg1bHdnWi9hOVhIUi9zL013RHM0VlNNdFZXbHZKMzRJSjY3?=
 =?utf-8?B?NkV6UitiaTR6dElkQWtlN0tydkZXZ1R5N1dNSnJ0YSt2N3RxMVozMGRZZ0lQ?=
 =?utf-8?B?bjRKNFhZTEFZVDNTSmJXSm9mcTh0eFNDb1FJUlRFZFNmalB5QlFhTkJuU3BU?=
 =?utf-8?B?a3BRL2JDVE50SWNVVVJjNDU0SjlMNnVCR0RSd2N0ZUY2cTZJbkhwd01ERW5D?=
 =?utf-8?B?SGpmVE5peEZKalpOZHVhMmRmSE9NcVRpSFZxbDRZTnBoM0pIbDR4d2t6bXlI?=
 =?utf-8?B?dHQzSE5WQm5yNGczdHU0eWgzOGo1b3JxZjRlWHBUNGducVZ2UmVkZytmVWJk?=
 =?utf-8?B?VUxidmFUd2ZIbmRBS1g1SlZ1a3U1M041Mzl3TmljR2lmQW5vWXcwa1AxUG11?=
 =?utf-8?B?ak1NWDg5SjFkVTY5VHdUclBmNDZhSGk3SUZkTDlCOWpXYS9vRkV6VDdTQnov?=
 =?utf-8?B?TjVyMWNuSXJWTW83Vys1ejZsR2ROclN2NmtMV2lkS1FERGltWkhBdjZ4VE10?=
 =?utf-8?B?amNzb0pqdTY5VlkwZkRjS09qRmNvZHpBUjhKZUdPUHZRVWVlcXFLS3BlMWo4?=
 =?utf-8?B?NTVGUytQQnIwNjA0SEN3RkJxUmhhR3dFQ3UxRnNIUUsrSlZuaGhFem5IeFlG?=
 =?utf-8?Q?a751JqGRa8g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR01MB5696.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkhSV1dhVDVaK2k2Nk1BWG1TYVYwWjVWNkZ2N1FWVnBLbDNDbktUeCtieVJW?=
 =?utf-8?B?YVpBVFMzZEtqYWYrUUZVZVVLN2ZveTUyeGpEeGFSTkhUZUxnbnd6K2phV1dz?=
 =?utf-8?B?aVZZbkJNVFJ0b1NPWFgrNHVGbGhTT2pkWTN4cVU2L0VVMEFWcjA0bldORHFz?=
 =?utf-8?B?T0lGdzRzeTl4d3ZOUzVVUFFOWVpjQmtKbDFNRlhLcFJGaVpFcFpCdjhwRU5x?=
 =?utf-8?B?eXUvZDJPckRValg3aHg1NGRyajI0WjBDNmZZZGdoK0ZlU2M2dnFaRlQ4WS9U?=
 =?utf-8?B?eDBmbGsxZlhXcUh2MWhaVVhkanYySko1QlB3UUhxQ0liUWVNcERFMnZHUTRQ?=
 =?utf-8?B?bmhqaWFTZm5hMFA0V3JOQkIwYnlOTDBFaEE2eG5acE80ZGZIRFBPNWVmd04v?=
 =?utf-8?B?TVdZd2JGSDYwNS9BMUNpaldNOEJsZm5Ja3NjV2hqUWFQanBkUk5DUW9IV0lE?=
 =?utf-8?B?VEgzdHo0SmhVaGtRSUE2MXRIRklvTnRNRUZFVVRzcnBkZE1MY1YrR0k4MXhw?=
 =?utf-8?B?VjEvNGZURmc1OVVqNkszQ0RJUnhQVjl4aUthMU9oYzl1MFBldHpTc0FxTFVl?=
 =?utf-8?B?dEdqTGF4clY2ZS9WMXU3UGVEK0xvMEM1eWJ0QzQ5a0NtUUhJdWFqNE1GLzlK?=
 =?utf-8?B?OFFId0xieWlMbWV5K21acVU1WVZXNW1SRm5Od0pjbC9RZDI2cjJCUFhybndD?=
 =?utf-8?B?TURieHk2UW9QcTFBcWdwUjR3N0NDaUU0V29TbG11aUtMeWpkbUMvM0dSWndh?=
 =?utf-8?B?RElrOUFwMERlOE1xbElEV2UwcjRZQnU4VVorWFZ1WmpWNkQvVDVSdnpHenh5?=
 =?utf-8?B?UVc4b3JSTHhBRE9yRllaMmpxb2lKYTIzM3QvdG04NzlHSlJpbU1NakN3QnhQ?=
 =?utf-8?B?TG9jQTJ2Q2dESXM4ZHV1c21LNGtIT3E4MHpZR3BIMFpoT3Z5Yk9vb3U4Q3Yr?=
 =?utf-8?B?aFVTbjhjNkROZ1JyNVJQUnF5alJPQjJXOFhmTXFHWmpKbU45eURFU05QL3pQ?=
 =?utf-8?B?NjJRZEoxbzJIK0xzQ3ZZQXFYbXMzV0RqdnB4WFNVWlhMODN4N2czUHd2aVpX?=
 =?utf-8?B?Uk9TNklaa0pkbTZTOFdZVkRVZkMvN1RoL0xoWUFEMzNoMUZTcWNwYllITFhy?=
 =?utf-8?B?NTF6TXV2SndoMjJjNTNDS254ZEdzKzNhQkNjWFEyU0FwTUx5VjFMZGl6a3Q4?=
 =?utf-8?B?T080cldobm9ML2NJa0hzc3dQZGVJaGtXYWo0NW5Gdk5HbjVibnJsTEh2MEZB?=
 =?utf-8?B?SE1YNkx4SkhUVnpmSVFRMm1TTC8zMU5Mc1lBc2U3bU8xTlNhelJVSGFqVEQx?=
 =?utf-8?B?bC94WldUeGtBSmxKdXBTVW04UVJVQlBPTUlkUmk2ejNqc09vOE1QbFM1YWpt?=
 =?utf-8?B?Y0RJdEh1c0ZxNlJxeXR0NVBwbkNQZE5DaG85RFBheFYrQXRPREVKVWVZcUl3?=
 =?utf-8?B?WnBIQ2JScnI3ZTI2Y0w2TWVjM2NWaEtSdzJqdDZWdVpOSjdnUVdIdXZncHQv?=
 =?utf-8?B?RVhzQ2tnRW1OSHg4bjRYbS9EMUZEL1Uvc1VFOWoyWG4zWldSS0pYUW1VYjJk?=
 =?utf-8?B?UXdHMUhRRytsTVlNblZKUVpYNE1YMWpTRlRzVncwY3hzVlFGaUZidkg5Nllp?=
 =?utf-8?B?cWp1T0FHUFMrcWxkWjA1QXd1QktNVUk0QmlydnRuK0xNRTNJSUJVN0Y4MTNB?=
 =?utf-8?B?ZmFDbWc1aXZaMGUrbkQwL2drajM3L3g1ZVgwSGx0VXpuUFVSdDdIYVQ5SmJ2?=
 =?utf-8?B?Yzc4OGNJVDFUaHRwaXRPeGI0U01IVUZ6b0c0cGZkQmtXVlVrSU5va2x1a1JP?=
 =?utf-8?B?YitPS29Fd3VqRjcrOFRWalEveVU3clFIMm42aGQ0Q050UnM2WFhRYUVHaE1X?=
 =?utf-8?B?RmJBRDdzbjViRkNNQmFhcGdYWW1JQXhxVnU4b2lEd2M5am0xaXpvWXp5SGNt?=
 =?utf-8?B?bWZwZTRJem9KdTR2ZGd3djluaFFVc2ZKZHBKTHB0UUYxQnliRzYzOXlEbHow?=
 =?utf-8?B?YUIyQ3lDQ0ptWlVmM3I4N003TlZHdTFqcVJvR1BDVk9DcnRsWGdianZadjZN?=
 =?utf-8?B?cTk0S0srdjFITU1MWFM4TUgweW5SdXV2aFBNQUlTNEZYNzE3dWo2S3NwVktO?=
 =?utf-8?B?VWtHaWRJQXNuZkQzcVc4UzNHd3k4YUhmanl5QXpFdmJzYVFiVDZpbmk2Ni9F?=
 =?utf-8?Q?KiZ62B6WpfUQfTqK+KDXiPs=3D?=
X-OriginatorOrg: kuka.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9656278-b2bd-4526-d06f-08dd8cb070b1
X-MS-Exchange-CrossTenant-AuthSource: VE1PR01MB5696.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 15:12:39.0804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5a5c4bcf-d285-44af-8f19-ca72d454f6f7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0yO8EGPScMnTKE6AO6/B3fkXKpfkLxxSEbnF+DJC7bc6JwR2XRK5JP2T7jjXMylZhZyRUpjOp38LHEfiPkfE7rHd4MlqCNiAB1QTxl5b+fo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR01MB6283

On 5/6/2025 4:28 PM, Lorenzo Stoakes wrote:
> This bit probably belongs after the rest without ellipses :P but it's not
> important.

I was not sure about modifying the subject for v2. Let me know if I should change it ;)

> The series looks good to me, thanks!

Thank you too for reviewing it!

