Return-Path: <stable+bounces-230496-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCF/MHVgxWlM9wQAu9opvQ
	(envelope-from <stable+bounces-230496-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 17:36:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0FF3387DE
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 17:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C59DB3027512
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 16:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1553FE34A;
	Thu, 26 Mar 2026 16:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="slYOQ4Cs"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF483932E4;
	Thu, 26 Mar 2026 16:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542161; cv=fail; b=sZZiabYDMxTlVGKQZRGX81N4IT+Nydju/UoMBIlVYCKW/3nziSd3Os6+q7kmd5s2lakeGTzh7l+IZQNEQW1O8DiZeu+Dc142bjG3PgbStQGdpYeE2jrg9qAMuYAcfmsgx6elchy+k9k54kRtx7SmoNvaKu2zSmaBSb57wpcL7Oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542161; c=relaxed/simple;
	bh=MD1KZ6Tse6h0fxgFDmzvs5bKbxU5NmuGjhHJNtGhm6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RQw0V88xKk2m7/GiDZ/OpH0hxhvR/eUckk/dwVEkW3h1KTbCp4ozLApVy5Z3r7AXrgqf0gWCbaWi6ebAsb7si1jVKh/U4xsnDbY/lrbjn9t4gzodwy13UWVF1fFhbL0LcWVHCspDvpEIcyivh4uNFkGno9yEtHSfgbC7/Mkt6R4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=slYOQ4Cs; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QFh5bf076422;
	Thu, 26 Mar 2026 09:22:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=MD1KZ6Tse6h0fxgFDmzvs5bKbxU5NmuGjhHJNtGhm6Q=; b=
	slYOQ4Csnq5viZCuPStGPDBkyZ4YWQ9XEYLGYRCdlhBUKLSVQieEbVcKQtxsQW5n
	YAMKMXYRBv7YZAxQOlCwffg8NTpbG2T9KhabRXb0dFvl9GvFMGDuEpniQSfPaN3M
	Z8YvjJSXoKuVYBP8PNLNU+bsFeAlXDKvKopZH4pdZY1N1Ql3h/390Ar2/eCUWTS6
	/gWCPGvJP1Qqor4QbbPbzV9NU14bp8QBv/KotRpbK7PXmL4QucYWiByAWsnYf1Ic
	0F5MXbHrOWqApFRwa5kronFpR6JH/5pHlZeI/aBUyXQywnlV6Vl9ozV3LVv4QOmz
	mTWv4NsxSobsZ1EaMWF0aA==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010003.outbound.protection.outlook.com [52.101.193.3])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1tucxhpb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 09:22:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yr0KQiTJfwRICsrbGL/x17HvJZTUT30V2uPlmszAUCyNgLeVDit2INsrf+WYErQr/bMFMfcER8Xbp+McJfgjzLQJ2OAk9r2/CuuFYxsU7I+4wB6j4eZvLIWtICyZgon6nac00ec+g78m5SRnC5Hc3dXzMQjrtptqP9lTnszrgHS5MjlE2J4EX44JLODaBmx2Qq02kDjxZ2RtvmUtnvfNlhsSvPOuINcrFQ7mt7sahPwRSgdifXGAA7u7k5P4XIstAlAHMFZW8VnDyUxQN6aWZ3XdM83eKX2Gd+mqFlbyg3EEbFy1OW/YypYmJUEREut2mZ6pwlyUM9X8Oi4iy3T2RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MD1KZ6Tse6h0fxgFDmzvs5bKbxU5NmuGjhHJNtGhm6Q=;
 b=EXJzQLhTxvGilE+EDEWusW/tTOSwO+RSu1r1QH6NzK9V1qvrlLG7/vxrMoCBQZmhGgqGQnV784fjG/Po4N2X1jqTDuMByc6qhfhrLkiM5kbU5LXDc0ABVSu3Na+ojsF44AhEFZ4D6wA9mEGsdNTj57eYCDnqdHS1wtjLhySUYvv1kQx/1utadauihSoZksmqzTn+PhnBY4I3ZFlUsOBJu+CAEimhYnLKJKoYuMouhlFhnT3nHdERJBS51/mlnmB0jb8Corgn04rsL/uIaaeeDbfrmVzvvDOH2oZyz6RkByTW4DzEr3WB9Mj+sOkOkbUAlLacVvo+VTNarLenSeS+Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by PH8PR11MB7119.namprd11.prod.outlook.com (2603:10b6:510:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 16:22:21 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9769.004; Thu, 26 Mar 2026
 16:22:21 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: gregkh@linuxfoundation.org
Cc: brauner@kernel.org, chris.friesen@windriver.com, frederic@kernel.org,
        ionut.nechita@windriver.com, iulian.mocanu@windriver.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, namcao@linutronix.de,
        stable@vger.kernel.org, viorel-catalin.rapiteanu@windriver.com,
        vschneid@redhat.com
Subject: =?UTF-8?q?Re=3A=20=5BREGRESSION=5D=20osnoise=3A=20=22eventpoll=3A=20Replace=20rwlock=20with=20spinlock=22=20causes=20=7E50=C2=B5s=20noise=20spikes=20on=20isolated=20PREEMPT=5FRT=20cores?=
Date: Thu, 26 Mar 2026 18:21:59 +0200
Message-ID: <20260326162200.414587-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026032640-gangly-sprout-099b@gregkh>
References: <2026032640-gangly-sprout-099b@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIZP296CA0025.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a8::15) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|PH8PR11MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: ef6f08d8-c9d2-47d0-cf23-08de8b53db1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yGXLZ5loNWTQYR73oGAQ+LrEOQK1AVZTW2AitqD2lr+5pF9+rax+qmaybuNq3t/EaUkDbCQPv1G48nNRweKogX1EqsusEiNFSh7q9cr1bXeWcz/7uuxAb31pBoZlcfii2Bsfi3xa4MkFmt2j3c64OBJPtCcHUppB3zeqteB8MSqG2g2XC+Pq3XTA0X5r3pgPaRErx23fq90a2xvL0GHXeoTZZ1hFdPT2l6ioknuOxKg0pS54yyJq98/1T6J/vGUM40hZz0MLwEgMtyqLh1x9IvWh741Oi6Hf6UnqHILRPlmH/cUtWs6SzTez5X+m2iSl/XL0E2Bm474JxxRgLsCZUYjjx82Te5Qe6v2zAOA4Am/vsHVIBebxAo0FA6ChF4+y72wjtxCGDniGw57LUbWTqhFpFjN/xi/3hc+rNiLfpyTNmafzPHQ0GqFpJ/4OdmLS6V2El+ljyuFUndC+bX739n4yAWzz3+EVGpBFdbEmCccV2S0OigMaTsAqu+R1jLtKFusNP5ZTGF1uVVw9VO88uZOoFcbvH7GW3OH15/zOwPpa6srF/CaXdvvAxdGFWsPib3WjXC35f0APA5KZe5tWvN+zfgFL3vgg4ca7oojE3foevJCuBBcbtesnoIHMKHVXBAaMF+dgsv487ekaF3OrDENY4VxuRrA9RcEjEHqok4jyu+zl27UHP0dMLiii4hsF6oPFMUcHRhkva6/OSh61q0PqzRNOO0/pa8BdJNGJiM2dpiYIIvgf/R/4pkZi0kKr5y7kNkSdSsGgdeYrE0pB7xtAl7GDAPfm/XgfBzh2ERI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnNZaExVNFRPeG0wd2YzRDBDUWdFMXRJRk1Sc2kyL214UGhnRzczMEh5ZC9h?=
 =?utf-8?B?Y0dwSzg1TlBuVkR3U3RkdHFJRC8vVlNXaG9haHQ5RTBib3N5YVhCdlNpc0lR?=
 =?utf-8?B?dHo4VytiTnJtUHdSRmhJSkFSUDF3bldMc095MDRINzdvVUJic1pQU0U5eFBO?=
 =?utf-8?B?aFNndzZ0cGpnUXVLRlVpZGlvV1JSZ01DWnJuRFRFV3RUdytRYjlwZFAycHdE?=
 =?utf-8?B?MDNYK0lYQnFVdkpGZVFoNFl5VDZ3RzhhKzlWNWxqQzZoVGhCcjlmZVN6S0di?=
 =?utf-8?B?MmlHQzBiUFdKT1RCVVR6ZHN2czd0VFdjSVZpTW5KcS90NE1GQnRjemJkL3J4?=
 =?utf-8?B?ZG0wTHZnYVh1VG5JYWFvWEVpYllGdzNyODNvWnprbkdjU0lQR3BiK1JycUNC?=
 =?utf-8?B?bERnTzlDMWZkT3dEV0NaK1hzeFB0Vk4vWEtnYk5zZVJWS0NDN0JaMEtpdHhY?=
 =?utf-8?B?YVBOQzZVNFJVd1Y2NEJrTEdjc1pVRG9sNDNJSW95R0FBQUd4OFlLSlArMmEx?=
 =?utf-8?B?Q28yK1U0Mm90WVVjREVLTmF5NmFOaDVBdU41UCtlMFpBTGhSelRSbGtaMEtO?=
 =?utf-8?B?cHhlTTN3NVJCa0RvaFhUeXBEUVk2anB2UDBCaHliTUZnTDBVclFFVmNNeVJt?=
 =?utf-8?B?NVoxdFh6bXF1clk4eGtOa0Q1TklqSEFITXk3MHZpN2g1dW1PWWRINkNJZjVR?=
 =?utf-8?B?VnMwWGZTL1ZtaERXNlBoOWkzS3dXYW55MGQxU1UycnB6SWZnYSsyMlJNdUUz?=
 =?utf-8?B?dzRnR0g0emp4YzZHNEkvZ0I0MnRTNVQySGxtKzBrekJHeGVYSHR5SjJvbEpI?=
 =?utf-8?B?ZVdQblhVUVpQTUh2N0g5QVROQlNtZDFDT1dBZjJDK0pWWnc2OUdVSDZTQ1RP?=
 =?utf-8?B?TGFPS3dBOExDekxwbHZKWmhXRnpYQ0FJR0gvK1JzTG9iazBVRUVuWXpDRWFJ?=
 =?utf-8?B?OHB3SXNEeTZkV3Y0Vkdaak9FeXk3ZjY2bEdNRm90dFdwelFtb0I4bGtTZmEv?=
 =?utf-8?B?eWxlZXpHNEtJeUExdUpBOTAwaVlqbXpQYmEwVTJTTHZSZko3MTNXL0VUVmpz?=
 =?utf-8?B?Y1lDeVlHeEtYMVRYTlYrOXV3OGJ0dDlPbkMxM3hWVHhWSW9HWjhEUWZNOURB?=
 =?utf-8?B?d3BCOTN4dFpXdHF0TnNEY2IzWHVyRFVCbzBrbFhMUDk1L3RHYkdEVGUrVklM?=
 =?utf-8?B?Ti95ZDJWSHJORTM4eGFsMy9qcXVoZlNCTGROa2lUZWFFeFVQWGZRN05tMmhU?=
 =?utf-8?B?Y1JaWjhKVEpsT21FYytZajcxYXl5dVN6RnZkdHN0WVhZQnQ1TkZrR0o3S2tx?=
 =?utf-8?B?bGFhUks5S21GKzdhdkhsb3orejN5OGVCZGhSeXZsSi9ZVWVQdGNHaXJ4aU90?=
 =?utf-8?B?QWIxV2tTaXo0YkdzSytoOXkzR3RkdW11bGJSUmFCMnZNcCsvWWx4em85TVVq?=
 =?utf-8?B?djVDMVdPSTBpL0gra1Qycnl6NnAvc1VQeWU5RUFTKytVQ2t3clkzcWdzZEJx?=
 =?utf-8?B?aWY1a0YzMnFkSlBzbGtrejBSWitxM3I0WFl0a2FQcjZtQzhlNG44NmRVeG9C?=
 =?utf-8?B?QTRWb3Z1TTBDWmdqZnRyVHdISWw0OWJGQ0lqVS9LREZnMkt5Zk5YQnMzYkJR?=
 =?utf-8?B?MUVJNDEvWDl1S1pXckg3bXRmWk9UU29lV2pYVXBoT3VrSEQzWkVwN28rSzls?=
 =?utf-8?B?dXA5KzErN25zbWd4c3Q4M0FSaytwcFk0V0RWREQzTFVHNSt3Z1U0RlZFRjRz?=
 =?utf-8?B?SllyMW43dVE3MEFUYzBFYWNxeXBrQ0pBVmRqd0YyQUo5ZWRuV005UVl0TVVi?=
 =?utf-8?B?MXFybkdYZXRFdkdXOWRzUkhtdXRVNkdqbE10OWp2RkxTN3dXYnRHV1QzM3o5?=
 =?utf-8?B?djN2L1Z0eGwrVUxpakJtaVhxbmFUYm1LVy8xSEhUSWQwU2p4QlQvS2F5L1NI?=
 =?utf-8?B?aHBpZTMvRDVvWGpKclR2TWZqLzhqdUxkRjAwT0hIdmt0WndrU05qR3pBZGFG?=
 =?utf-8?B?TktZMUlKc1hoM0xzRjhITkpvUU1YOXY3c29YSmtTL1ZjdDJGTVFOUTlWMWZ4?=
 =?utf-8?B?UC9odzcvK2x0QTVkbmFtNGt2Y2ZXTisrUTJOQkx1LzhrNnV4VzQ3VUw4aVlw?=
 =?utf-8?B?UGNrcnZQOWNrdnVxc0dvNHpvbUl6VFJsVmhGTk5RdGk3VDdTbjZjV3VXVVFW?=
 =?utf-8?B?a2FqTTd0VTJBMFFETVhLQlRIS3VWOGREUVpkTEgrc1pNNDJHM2lqblIrSEJH?=
 =?utf-8?B?bG9Ma3FqWktIaUFHUHZPWUJ4cDlvTWgzYzEyOWVtb2lDMFIwQXd4N1ZBUnBD?=
 =?utf-8?B?Wm1PbEFSa2ZSQ28yVGpoSndOcVZ0S2V4TUxOQTVaUGdvMGUzYko5Z3NJWGxp?=
 =?utf-8?Q?n8bbmpWNqDft4Fhc=3D?=
X-Exchange-RoutingPolicyChecked:
	FhZ4WAMYFLROKqm8W2YSLQ8Vy440ZtF17ttMlxXxEzHVoTmL3dx6JKLZr8atjwd3PVvB76GQdJ/tGbG3qjBjMrVbGP5dOpIkT+QXCK3MelJPen7d38i1720lAGxE5q7cuPzcUTQhUYZdpXGAjb01OBma+b4/TTGiu/H6wlhCHGbjLAVtcUF9gncCarxJXxpTGoVUOOLtfjA3G6XoDbg+8Z+lwsHrd5hnzGZ5X+8faR+BlY4uXhRLiuLhXg4Z6xIBkGurLN1Kt7L1o+uVqPGlArM698S75ZAlsAdqWtSzPptoHHbOjsHpNBCsCUcbOIiN81XDZSKaYAXFsyAnInkuYQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6f08d8-c9d2-47d0-cf23-08de8b53db1f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 16:22:21.2437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8cl8xVs/wEgabk/pSt1y7aqnJcFH/XM58qJdmOx7uWK+9WxkWOcBwu+i9a2PgDjrW02aFmvOKa7NgTF3ejSPXO2CirHbBWi9PiOS+eUJAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7119
X-Proofpoint-GUID: wH4TOPvL8r95NmH02RWwd-vjLa7UXRqP
X-Proofpoint-ORIG-GUID: wH4TOPvL8r95NmH02RWwd-vjLa7UXRqP
X-Authority-Analysis: v=2.4 cv=deCNHHXe c=1 sm=1 tr=0 ts=69c55d40 cx=c_pps
 a=6F35cL4xT6GZaKJ9H0o0MQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=5KLPUuaC_9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22
 a=Mbofv78BvpOmOF3qiE0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDExNiBTYWx0ZWRfXzS4YqalnuiyD
 JuCkWVwpwrdBnbUz5s/qHucKwfiBH6vuibjefi7JzaSNJ5u75hdM0WnPIIjcY17BKTY8C9HQpvS
 5X2XtatpseUmfG5cDClK4UEKQxLHPjFnr6BDefK9x+qA35/rFGiFnsRp4XKRvDlMUGukVQC9QgS
 bHGegIekS4lVqriZr5sXSK00wMKGENJ9lrtc2z5cUBmnuh51NmTQ52fj79IGHqMUKv9liQ1BPQo
 UbwPXBWtqf3onVrPowMF/CYi/AFrHjhv98w7ajQW0u9Dgu+7JVwuke7p5rdRDiGJyRq6chG7l3Q
 q05x0mZk6simcbVrdlhfzSs2d/pItg6AueqiqyI01vJZfoaxSlCkFy21TIvAmSPjZxv3eB5cgzV
 utNvp0aUfDH+Hnyf6g5tQDSgpVvvZNsBcAxcc2BdHiQKRdSpDTO9wGwWf7pvVX9FF3qE1cqtubz
 Md3S4W+a5kmQVCBttcA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260116
X-Spamd-Result: default: False [0.84 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230496-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,windriver.com:dkim,windriver.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DE0FF3387DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg,

> Does this regression also show up in the 6.18 release and newer?

I haven't tested on 6.18 yet. I'll try to reproduce on a recent
6.18 LTS and mainline kernel with PREEMPT_RT and follow up with results.

Thanks,
Ionut.

