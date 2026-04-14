Return-Path: <stable+bounces-237976-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JvACmq23ml3HgAAu9opvQ
	(envelope-from <stable+bounces-237976-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 23:49:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 136113FEB3F
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 23:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8EF923018B57
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 21:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B9A3859FF;
	Tue, 14 Apr 2026 21:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="J/CWxMGd"
X-Original-To: stable@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23C21A01BE;
	Tue, 14 Apr 2026 21:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776203363; cv=fail; b=p6o3yPiTXfAMaCG8jGPxlm1Wg48AZfJj0wac5xXq/UQldWk8Wufce8FiKyLY1NSiCRMqPDG9vyyYVqpWWVHHZ52nOYYgSXDw5T53DbfVv7IU27eR3+cW4cEV8LQxmJUU51Tm6IONOCVcvoXPAMUNZKxru8z/+dlZtEbUBRXkyhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776203363; c=relaxed/simple;
	bh=0cqZGp4bjjiEa1oFsp99TvcpjXppwZJUMk+jbVA0w5k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pKvcPZmsiiqxizrgLz9Al2DGHSCWjqIG8s5t7NkzjlHto1bkhq5VRm06uLdztQbPcVuuHktHtxRE/QTMCxrx1wgm9MD4A2oTxMsB8Gd3au45OAyuZN8dScApP5COnVDoQGl/1nPOONjP25WmUjY76LvxRbwVZcCGKmhg8Z5n7fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=J/CWxMGd; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023143.outbound.protection.outlook.com [40.107.201.143]) by mx-outbound-ea18-75.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 14 Apr 2026 21:49:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZWnmWDHFtJWenyRzb7qGBQfUTKyLH5o2JADmR+uEg7qHur0nhvQbnBebgyIvEgBbycTmGtSqi+ZonGIN6GShyvOZrgsj3dJvYSn/MnC4zqFNJecTvd1Cli6pF0LmZjsVk6PRSpVJnV2b9kRL6qtPN8De62twSUo4mswVmdpzT0moGudVczNh3AAKVI6lDlHqlK24BztyUnSb1clqVhMp1A3X3r3Wq4oOSP98Xi+RIxcflay1N5a3Fj29DIM+q+M9hhpSP/mBELxI+o6Ca0fHn3Q9eAfUGb1TPcea04OYZ9nf5oEk5LOR1oP5wJpEPiseoi+XmjfFTk74TEPuyI/qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llOGPfJPh9k9S0JD7wgpbmEyq30qxtwWVE17MPuAB38=;
 b=URZPLGrqZbjeqt9ZpV0gX5r6VY2dA3KjgoSnbg7JfyMu2HgrnBvvcpIZHuOD9dVfWOs/csDuhIqH0LUjzjEbS2GZmS48ciV6xtGW1ZfA5XhtLtfLkegA1D4HPZurErCpO1xzrghA7SDvILRCgEZHh8SFqvE2RloVxXo0SxG5SBFswUq84nnDkskfw9IEsdbrlB/tteIA1Nn1yW1bVFLQPsPwj1vk2ul2BX20hJdnEFdHFslqnX3PyWPEIsYXaR7RsledpjdBjmSSlo8wD+MDj+kHa6mNsWoT92Yb459VT/vmjFvVUnXDdT9/DSTUjO2bv/mA9TAdVZwWNLcsS/s4Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llOGPfJPh9k9S0JD7wgpbmEyq30qxtwWVE17MPuAB38=;
 b=J/CWxMGdcd2GUpw1pPFsvoUS29eSENupWGqN0XYb26v39cBc7q+izGvtkfMrZSEO0hR4y6SxttlHTXEB8gSLy8dZ9orIPTWd1rnT1H7I04xgjYgv85wIUx80vl3ogcz3++8zPc4dDe86jq/s9u8POY3dx+yBMT9EJBvzgXUdWQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from MN2PR19MB3872.namprd19.prod.outlook.com (2603:10b6:208:1e8::8)
 by MW4PR19MB8154.namprd19.prod.outlook.com (2603:10b6:303:1ec::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 21:49:03 +0000
Received: from MN2PR19MB3872.namprd19.prod.outlook.com
 ([fe80::5787:9b5e:45ce:396b]) by MN2PR19MB3872.namprd19.prod.outlook.com
 ([fe80::5787:9b5e:45ce:396b%6]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 21:49:02 +0000
Message-ID: <6b62e345-a4d4-4067-b3c4-f773c8fe3036@ddn.com>
Date: Tue, 14 Apr 2026 23:48:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fuse: Fix possible memleak at startup with immediate
 teardown
To: Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bernd@bsbernd.com>
Cc: Horst Birthelmer <horst@birthelmer.de>, Miklos Szeredi
 <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 Jian Huang Li <ali@ddn.com>, stable@vger.kernel.org,
 Horst Birthelmer <hbirthelmer@ddn.com>, fuse-devel@lists.linux.dev
References: <20251021-io-uring-fixes-cancel-mem-leak-v1-0-26b78b2c973c@ddn.com>
 <4b5a8040-b62c-4d75-a474-70d0b4759461@bsbernd.com>
 <CAJnrk1ZohxcDERszbii8ZM0g1ZzTwk6+wEqRWpCoSwBXzgavkg@mail.gmail.com>
 <3eabbc7b-010f-4d4c-9145-30d69fe1aa79@bsbernd.com>
 <CAJnrk1aoxGMGNZi+OwdoET6ahhGHp_7dw__=dmOWW+PMxnsj2w@mail.gmail.com>
 <adlyjDaxLZyHcSun@fedora>
 <CAJnrk1Yb2ABBKFK=KMaU+W10FNazt+h93P445i1USXcN2W45Xw@mail.gmail.com>
 <f27651af-e5c0-4c3e-8baa-fa2d7232cb4d@bsbernd.com>
 <CAJnrk1YPrPXN74fgesg1dbqJJsmjPOJ_My_mYMUevJfSrmrECg@mail.gmail.com>
 <33b4048c-e940-4cf4-80b4-88bc1adbd4a9@bsbernd.com>
 <CAJnrk1ZxijgYVTwzgX3LHoePtyOmOz-1y7swbgquT3_rxrLpvw@mail.gmail.com>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: fr
In-Reply-To: <CAJnrk1ZxijgYVTwzgX3LHoePtyOmOz-1y7swbgquT3_rxrLpvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0470.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3dc::11) To MN2PR19MB3872.namprd19.prod.outlook.com
 (2603:10b6:208:1e8::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR19MB3872:EE_|MW4PR19MB8154:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e461e75-a49c-4a82-25e3-08de9a6fa46d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|19092799006|1800799024|366016|376014|18096099003|56012099003|22082099003|18002099003|11006099003;
X-Microsoft-Antispam-Message-Info:
	qCzLHeUmRDaPrtjPQb9AY3Ijb7qAAxs3+C0quFWB77W5tbGt8EJYLeT8fAlAAFxlbiLqDtHUGARuxHmSqAsWls1IKqVW8+odR7/KnK4CxyTtJl6HSh4Sf0w/WBvZJd53AG1pEI8Xy4/BLqjUz2K/nSI00628TYaUX+rQuKQoQMb4zrzB3s52RdXNQ44QBY07PwVNOdg+eQgfImx+czCFbu5OLIXj1Gfw5yNzmdvYAodEgX4UB6tcZqW+hCFdSbUegaAC8ThoEE1u00IL5KK/rJQZal6qCaFZiEutVuAyynKqmP7HZs2KidhoQkJ2JOKavFbOpUvcBqODMAfKKUm9v3CasvZucIBU+aOESBRxoQWF/4yTDAYua6zdA1iauqdgipjJmtube2VDkwcftSrzE5tk8GnowVaL34z4ZnSEWRkgOganB9RmzW1EA+SSG+Ht2YRxNsPqDvl8qcq3o/fWSn3Bitib9tTHObi3SmePISDVPfS6SaT5z6W1wmTyiPka2SZUkhUVgu2LKXW5ZPCu2Z52aqduJ1smpokUtQz/a5rXpe8P6+qQncvSTNY+WY84V1YjLojokg/KyjNbNOJqo61S0SIitvLsPlRXoUlNZYdR2qfUKFowAhzcUuxO/19FHbCXZ70oGKI+y3AJUxFdl3m4b6WHGniznEEFI1HFEwGSBG3j2+h1CGSU6eaoYQJU6isIOoBe44muXKyQU2zVyaGGr2tD05folHYn1/QwYPIHxlc1Wgo7TxHaLm50GMzi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR19MB3872.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(19092799006)(1800799024)(366016)(376014)(18096099003)(56012099003)(22082099003)(18002099003)(11006099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFpnSG9UdHByeEZpVk1rRjVjM2xOLzVRdzhvdVA5WUZwWUhvYVZXU2l5cHRE?=
 =?utf-8?B?VE9EVXlBbjA4ZXhiRzQvOU1yMTdXb0pQaDJPejlEcHdwSmxFWTduMXpIYU5V?=
 =?utf-8?B?VWc5T2RzeFp3dDBtMXZ2SEhzRXVKSWlMMUxsa2M5cGpReHJ5bUE1bmdVdG12?=
 =?utf-8?B?bzFXWnpYVGxZWTY3SGJpU2ZVMWR6NndmUW5jYjNoQ0RqMTZFVTBlL1dxc3dW?=
 =?utf-8?B?Y202a1FKWGd4ZTRRMFpZT2ZsWm93emN2aEtrT3VxS2lVQWJHZWNQWUhhMkFI?=
 =?utf-8?B?ckpzK3plKzZOTmZVZUVRa0piWjAyMnN3dndtSDJESXZQWk9GdTRmcG15dUYw?=
 =?utf-8?B?N0wzMUxFMjFQVlVGSFdPdVBYSk1Dak5tWFd0b3FDRTNSaVcwbGlqSWkvOEpt?=
 =?utf-8?B?L3JKN1hXZzduUUt2ZE9OemJmdi9mMXNKOWtvN2pJUThnSk5lZzlZb0tCMUk0?=
 =?utf-8?B?REZ0YllsWFIxTDBMeFFSZGFaUjFvcGNsWGpsaVAyWHZCbjRDUGk4WHhUdGxH?=
 =?utf-8?B?NVduNkkvTHhFaHRFZ25WT3Zvck9PeVZzV2doTmtWaVQwRFcxSXR5UW1OSzh3?=
 =?utf-8?B?UnpFSmozUnAvblgzcEd4clVxZmlzbDZlZGEvRXBBc2VNckdod0g4aFQxdXkx?=
 =?utf-8?B?K0FsWEM1YTRLb3k5TzI1bEtTWTVleTZ3bGUrK0lhN0ZORnQyRlJ2UjNMbTNR?=
 =?utf-8?B?WWR5YXNFbHIxallGMVRIcy9GakhubVE5OEJ3L0MwUFZCaFVIUUY5aUUwKzFs?=
 =?utf-8?B?dzFIblNGcjJZalhucVlHeXgvRDRVMHpMVk54UDBOT2NTRG5mVXVoVzZoUlVE?=
 =?utf-8?B?Z1NmQnlxQ0FuZGZMU1VFeERZRXdkZHkxTVNwQjBjc0ZVOGdsbkxlNERrdXFX?=
 =?utf-8?B?U1hXc0E0U3BDUUdzVlFPOElMc3FER1JSSllxMDVPWGlxTW5xZUltTW5pZTky?=
 =?utf-8?B?U0lud2EyL1JETHBQMVZpd01sNTY3MjhHMzNSZXprODY4L21WVW9KZUJvUmcr?=
 =?utf-8?B?ZGJwUU92S2IzTEE1dUpDS0doUnpXS3lrS3lrYzFFQ0Vac2VsZ0ZsYm4zeFFV?=
 =?utf-8?B?NTZvTVArOEZvNmVwY0N1YWNkbVRJMDhVdUpEK3VIcGhYMDFCUThMTUw1dGl5?=
 =?utf-8?B?YTZjclgvcmZHOWJzdFJEVE5tOTgzM1hRN29aNmRjM1E0VlZKOGFFWWNiRDBU?=
 =?utf-8?B?dS9nYXQwdmg1cFBGeEpEbmkrTVhZbVhaTXZST2hodHk2RHcveFNESnZzUmZR?=
 =?utf-8?B?VG1Kd1JqWkZtdFN3MnlZUVF6L0h6T1ZqN2xnaVFaWE93MllwNWErYVdNcHRl?=
 =?utf-8?B?NTh3ZXNLdFQ5Y3N6OG52a1o5YTRKODIza1ZmbWRhZWgwWkpFeTVNbHdxYWRN?=
 =?utf-8?B?VmRqSXU5Q0p2YnVpbnhYRTM2UU1rOUdycSttak9Odk9xWS9xSXZuQkx1eEVI?=
 =?utf-8?B?UGU4RzcvNC9raGNaTFk0M01pT0xlK3kwMldKK0FjWDBaVjQ4WEtUaEpkT3Zj?=
 =?utf-8?B?Ris0eUk4V0I0MUJ6cGpPNlRwMGR4OE9jNzh1bVhzSmY3QTV2T1NLWmZvYWM3?=
 =?utf-8?B?RWRGZzJjYTZPUmZCNk4ydGZHVlZxd2dMYVEyWnNVZjg5bWkra3NVSW9ST2dN?=
 =?utf-8?B?NjlsU1doOHl3RUVpK2kxRnpqUzJocTRMUnd5dnp4NnhvRUJpemNRdWJGcGFR?=
 =?utf-8?B?U0FRYnhzSnIyVWxCSXJIUTBiZ09mYndLeVJyclRxTnBmNjV6dHNtdDNHQWRt?=
 =?utf-8?B?OVh6VXZBTWdiL1Y3eDNCcGEyZFJ0UXhWK2tWS2svVzlGNnhZOTdPWWh3Uk4v?=
 =?utf-8?B?WGJaQlI3K3Bncnp5SEt6Mk9iTkJpQjRtT2VVRVJIY2psTWY0aGh5MHFFMXZG?=
 =?utf-8?B?a2ZuNkVMZDltY2MrL2Q3NGdYSWZlbGdPQ3RJaFhSMjdIczU5T2dmV2hIaXln?=
 =?utf-8?B?RHNYVCt1aHVQZCtsL2NEYWFTZnNqVnlOUlNTQU91a3M4VEVoUDkxUTJXdi9l?=
 =?utf-8?B?eVo4UG1TK1pRcTNuMW5uZDN6MHRhbUFxSmZwMGlzNWVzbDU5SFY5VDIwc2lW?=
 =?utf-8?B?WWMwbktnUnFaYUNjSnhiVDlJbkNqek9PckF5K2Qwc2tITElwQ0lCL25VL2to?=
 =?utf-8?B?SjFRYWwyUURTTWYxVHJINStjT3Q5MkRraTRVeXNaaGkvcUVCOVNpOWJiV2pZ?=
 =?utf-8?B?bDNvKzRnTWkzdmFaTG4zUnRmVnVRRUhzQ3lHbWo0MEY5Uk5BMVg2RFN1dlZ3?=
 =?utf-8?B?dVlCbDczTmVsNCszdTlHSHE4cUl2OThmUmRmWXdjeitjYXhRT2JGd29wRjU3?=
 =?utf-8?B?cmxpMWY5MUMxNmRBTTMyV09EUys2QXN3N29zNy9aWVZpa0JibyswQ2hQQXZr?=
 =?utf-8?Q?Sdmy0MgvCu2vg/RTF1BJ+iQs5nqK2tIizqNXc6vSF443I?=
X-MS-Exchange-AntiSpam-MessageData-1: mtDyBc+ibSgwcA==
X-Exchange-RoutingPolicyChecked:
	PZf5pttLFvfuewOUqJaqSb3TOX4uGT3J2c+2beH82WzOAMgB+vi38PqHEkJ6TxuR9HLNt9cwjy/kUVvCsO8BKnADR6Gc3J8aYXYFr5PQiPFoMIP/6yR3qRur5nvtOwNmopXWwbfnm74x93y6k1IxDnuRmOcBmZDkR4FGX04EbvkdZw/H1akXSIMPDNE+YCxZmS1uKRN7Gx84AOUqgs3ob5LZi5kUmECU+Y7lNATuo9XBgPQY/+uBNe5aBar31594HIbLAqdY/ZmcLHeT9pk8nXiHAays6N60yfxiFwXVe/cSn+Ki0wYUa9RmMa4u003HFY7BPMjjc5bNdEnIvD46Rg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bY1PeB7vxNvtjGbh3nnBXXC00TLfpH8A4h80pcT2QM/BAB4HALOINc6pfNHo1uCamBN5PES6tCLVY4r42fXx1yIdbWDvJSO0OTuifJGiA6h6nb82/YvDBBYXQB9ev646mOnUZ1Jvm0uFO7yRGPWc1FV+/pDZjV3h8sdBkljdo/qTY5j0tvsIpEQ7X6lDbJJKstx19jUlzVBcdJTFF2NhelMrtUdsqcSd4GLft8ImbuqHNs8WwezTTe5GM9N47p+wihg2A7neupIAA2R+hJfgbNVCkXfE8Wf91qcsiu8AbYGIUFiT2sQmyeydFVyd0n8K3J+77Q37rG8DIkrErSGgeI6BBt7iECB8LDe736wNkIDIYwgKsxwEkHMM/l2TkUoxji/mceLBGt6l5jIWalmvl/MHlqaNT3fx670Chhz2MtW3atvkvHN2wFZTWWjvUsbst1USkJP3QEGZPT407swhop/ca4sz+T3DizZjLdNDbuxjFUqmyA2dkn6CrNI5A2NDwCtoDsvNO9u80GMVK0xR0G/Ge8SLMdiaLE6x5nrD5d02iHetHNfT3Fc6DHZV/fSb9iNjHYuPIq2d4kBPr8xJqk2fAewTJ7R/N1uyZy9lJW7AHbHERlKSj5YpOHqPNSPQiKFI10NHRG/vMlFb9TKWPA==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e461e75-a49c-4a82-25e3-08de9a6fa46d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3872.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 21:49:02.5381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jjt4AP7v++U8k09ZbZZbz3MTVYOpxeTpdMz92OMJXwlfOpVxaFadkYkKLzBiT59wXG86NQGwuWtDUAIGxTe5zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR19MB8154
X-BESS-ID: 1776203345-104683-29001-22347-1
X-BESS-VER: 2019.3_20260409.1625
X-BESS-Apparent-Source-IP: 40.107.201.143
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkaGxgYmQGYGUDTRwiDJ1CTR1N
	zM0tLIzMDE3NgsMTnVICkl1cjE2CzVUKk2FgBzecqSQgAAAA==
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272548 [from 
	cloudscan19-69.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_SA085b
X-BESS-BRTS-Status:1
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ddn.com,reject];
	R_DKIM_ALLOW(-0.20)[ddn.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237976-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,bsbernd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ddn.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bschubert@ddn.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 136113FEB3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/14/26 01:24, Joanne Koong wrote:
> On Mon, Apr 13, 2026 at 9:41 AM Bernd Schubert <bernd@bsbernd.com> wrote:
>>
>> On 4/13/26 17:56, Joanne Koong wrote:
>>> On Sat, Apr 11, 2026 at 12:22 PM Bernd Schubert <bernd@bsbernd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 4/11/26 20:11, Joanne Koong wrote:
>>>>> On Fri, Apr 10, 2026 at 3:08 PM Horst Birthelmer <horst@birthelmer.de> wrote:
>>>>>>
>>>>>> On Fri, Apr 10, 2026 at 02:24:08PM -0700, Joanne Koong wrote:
>>>>>>> On Fri, Apr 10, 2026 at 4:26 AM Bernd Schubert <bernd@bsbernd.com> wrote:
>>>>>>>>
>>>>>>> Hi Bernd,
>>>>>>>
>>>>>>>> Hi Joanne,
>>>>>>>>
>>>>>>>> On 4/10/26 01:09, Joanne Koong wrote:
>>>>>>>>> On Thu, Apr 9, 2026 at 4:02 AM Bernd Schubert <bernd@bsbernd.com> wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 10/21/25 23:33, Bernd Schubert wrote:
>>>>>>>>>>> Do not merge yet, the current series has not been tested yet.
>>>>>>>>>>
>>>>>>>>>> I'm glad that that I was hesitating to apply it, the DDN branch had it
>>>>>>>>>> for ages and this patch actually introduced a possible fc->num_waiting
>>>>>>>>>> issue, because fc->uring->queue_refs might go down to 0 though
>>>>>>>>>> fuse_uring_cancel() and then fuse_uring_abort() would never stop and
>>>>>>>>>> flush the queues without another addition.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Hi Bernd and Jian,
>>>>>>>>>
>>>>>>>>> For some reason the "[PATCH 2/2] fs/fuse: fix potential memory leak
>>>>>>>>> from fuse_uring_cancel" email was never delivered to my inbox, so I am
>>>>>>>>> just going to write my reply to that patch here instead, hope that's
>>>>>>>>> ok.
>>>>>>>>>
>>>>>>>>> Just to summarize, the race is that during unmount, fuse_abort() ->
>>>>>>>>> fuse_uring_abort() -> ... -> fuse_uring_teardown_entries() -> ... ->
>>>>>>>>> fuse_uring_entry_teardown() gets run but there may still be sqes that
>>>>>>>>> are being registered, which results in new ents that are created (and
>>>>>>>>> leaked) after the teardown logic has finished and the queues are
>>>>>>>>> stopped/dead. The async teardown work (fuse_uring_async_stop_queues())
>>>>>>>>> never gets scheduled because at the time of teardown, queue->refs is 0
>>>>>>>>> as those sqes have not fully created the ents and grabbed refs yet.
>>>>>>>>> fuse_uring_destruct() runs during unmount, but this doesn't clean up
>>>>>>>>> the created ents because those registered ents got put on the
>>>>>>>>> ent_in_userspace list which fuse_uring_destruct() doesn't go through
>>>>>>>>> to free, resulting in those ents being leaked.
>>>>>>>>>
>>>>>>>>> The root cause of the race is that ents are being registered even when
>>>>>>>>> the queue is already stopped/dead. I think if we at registration time
>>>>>>>>> check the queue state before calling fuse_uring_prepare_cancel(), we
>>>>>>>>> eliminate the race altogether. If we see that the abort path has
>>>>>>>>> already triggered (eg queue->stopped == true), we manually free the
>>>>>>>>> ent and return an error instead of adding it to a list, eg
>>>>>>>>>
>>>>>>>>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>>>>>>>>> index d88a0c05434a..351c19150aae 100644
>>>>>>>>> --- a/fs/fuse/dev_uring.c
>>>>>>>>> +++ b/fs/fuse/dev_uring.c
>>>>>>>>> @@ -969,7 +969,7 @@ static bool is_ring_ready(struct fuse_ring *ring,
>>>>>>>>> int current_qid)
>>>>>>>>>  /*
>>>>>>>>>   * fuse_uring_req_fetch command handling
>>>>>>>>>   */
>>>>>>>>> -static void fuse_uring_do_register(struct fuse_ring_ent *ent,
>>>>>>>>> +static int fuse_uring_do_register(struct fuse_ring_ent *ent,
>>>>>>>>>                                    struct io_uring_cmd *cmd,
>>>>>>>>>                                    unsigned int issue_flags)
>>>>>>>>>  {
>>>>>>>>> @@ -978,6 +978,16 @@ static void fuse_uring_do_register(struct
>>>>>>>>> fuse_ring_ent *ent,
>>>>>>>>>         struct fuse_conn *fc = ring->fc;
>>>>>>>>>         struct fuse_iqueue *fiq = &fc->iq;
>>>>>>>>>
>>>>>>>>> +       spin_lock(&queue->lock);
>>>>>>>>> +       /* abort teardown path is running or has run */
>>>>>>>>> +       if (queue->stopped) {
>>>>>>>>> +               spin_unlock(&queue->lock);
>>>>>>>>> +               atomic_dec(&ring->queue_refs);
>>>>>>>>> +               kfree(ent);
>>>>>>>>> +               return -ECONNABORTED;
>>>>>>>>> +       }
>>>>>>>>> +       spin_unlock(&queue->lock);
>>>>>>>>> +
>>>>>>>>>         fuse_uring_prepare_cancel(cmd, issue_flags, ent);
>>>>>>>>>
>>>>>>>>>         spin_lock(&queue->lock);
>>>>>>>>> @@ -994,6 +1004,7 @@ static void fuse_uring_do_register(struct
>>>>>>>>> fuse_ring_ent *ent,
>>>>>>>>>                         wake_up_all(&fc->blocked_waitq);
>>>>>>>>>                 }
>>>>>>>>>         }
>>>>>>>>> +       return 0;
>>>>>>>>>  }
>>>>>>>>>
>>>>>>>>>  /*
>>>>>>>>> @@ -1109,9 +1120,7 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
>>>>>>>>>         if (IS_ERR(ent))
>>>>>>>>>                 return PTR_ERR(ent);
>>>>>>>>>
>>>>>>>>> -       fuse_uring_do_register(ent, cmd, issue_flags);
>>>>>>>>> -
>>>>>>>>> -       return 0;
>>>>>>>>> +       return fuse_uring_do_register(ent, cmd, issue_flags);
>>>>>>>>>  }
>>>>>>>>>
>>>>>>>>> There's the scenario where the abort path's "queue->stopped = true"
>>>>>>>>> gets set right between when we drop the queue lock and before we call
>>>>>>>>> fuse_uring_prepare_cancel(), but the fuse_uring_create_ring_ent()
>>>>>>>>> logic that was called before fuse_uring_do_register() has already
>>>>>>>>> grabbed the ref on ring->queue_refs, which means in the abort path,
>>>>>>>>> the async teardown (fuse_uring_async_stop_queues()) work is guaranteed
>>>>>>>>> to run and clean up / free the entry.
>>>>>>>>
>>>>>>>>
>>>>>>>> I don't think your changes are needed, it should be handled by
>>>>>>>> IO_URING_F_CANCEL -> fuse_uring_cancel(). That is exactly where the
>>>>>>>> initial leak was - these commands came after abort and
>>>>>>>> fuse_uring_cancel() in linux upstream then puts the entries onto the
>>>>>>>> &queue->ent_in_userspace list.
>>>>>>>
>>>>>>> I think there are still races if we handle it in fuse_uring_cancel()
>>>>>>> that still leak the ent, eg even with the fuse_uring_abort()
>>>>>>> queue_refs gating taken out in the original (jian's) patch:
>>>>>>> * thread A: fuse_uring_register() ->fuse_uring_create_ring_ent() ->
>>>>>>> kzalloc, sets up the entry but hasn't called
>>>>>>> atomic_inc(&ring->queue_refs) yet
>>>>>>>   concurrently on another thread, thread B: fuse_uring_cancel()
>>>>>>> ->fuse_uring_entry_teardown() ->
>>>>>>> atomic_dec_return(&queue->ring->queue_refs) -> brings queue_refs down
>>>>>>> to 0
>>>>>>>   At this instant, queue_Refs == 0. fuse_uring_stop_queues() ->
>>>>>>> teardown entries (nothing left) -> checks "if
>>>>>>> atomic_read(&ring->queue_refs) > 0", sees this is false, and skips
>>>>>>> scheduling any async teardown work
>>>>>>>   thread A calls atomic_inc(&ring->queue_refs) for the new ent,
>>>>>>> queue_refs is now 1, the ent is now placed on the ent_avail_queue, but
>>>>>>> it's never torn down.
>>>>>>>   the ent is leaked and there's also a hang now when we hit
>>>>>>> fuse_uring_wait_stopped_queues() -> fuse_uring_wait_stopped_queues()
>>>>>>> where it sleeps and is never woken since it's waiting for queue refs
>>>>>>> to drop to 0
>>>>>>>
>>>>>>> imo, the change proposed in my last message is more robust and handles
>>>>>>> this case since it guarantees the async teardown worker will be
>>>>>>> running (since it does the queue state check after the ent has grabbed
>>>>>>> the queue ref).
>>>>>>
>>>>>> Ok so you rely on the fact that fuse_abort_conn() will call
>>>>>> fuse_uring_abort() and that sets queue->stopped.
>>>>>> This could work, but I would still remove the check for
>>>>>> queue_refs > 0 in fuse_uring_abort(), since it just complicates things
>>>>>> for no real reason.
>>>>>>
>>>>>>>
>>>>>>> btw, there's also another (separate) race, which neither of our
>>>>>>> approaches solve lol. This is the situation where fuse_uring_cancel()
>>>>>>> runs right after we call fuse_uring_prepare_cancel() in
>>>>>>> fuse_uring_do_register() but before we have set the ent state to
>>>>>>> FRRS_AVAILABLE. The ent gets leaked and continues to be used even
>>>>>>> though it's canceled, which may lead to use-after-frees. This probably
>>>>>>> requires a separate fix, I haven't had time to look much at it yet.
>>>>>>> Maybe Horst or Jian has looked at this?
>>>>>>>
>>>>>> Interesting scenario ... haven't seen that one so far.
>>>>>
>>>>> Looking at the io-uring code for how cancels are handled
>>>>> (io_uring_try_cancel_uring_cmd()), I was wrong in my prevoius message
>>>>> about these two races. io-uring already serializes this for us, the
>>>>> io-uring code unconditionally grabs the uring lock before invoking
>>>>> file->f_op->uring_cmd() in the cancel path, which means there's no
>>>>> interweaving between the fuse registration logic and the cancel logic.
>>>>>
>>>>> But I still think the more robust/resilient fix for the memleak is to
>>>>> do the preemptive checking at registration time. I think this fixes
>>>>> races in the force unmount case between registration and abort that is
>>>>> unresolved with the original patch. With the original patch w/
>>>>> fuse_uring_abort()'s queue_refs check removed, I think we can still
>>>>> hit this:
>>>>
>>>> I need to go through the other messages, but I still do not see any
>>>> registration time leak. At least not with the additional patch we have
>>>> here to tear down entries through IO_URING_F_CANCEL
>>>
>>> The issue is the hang, not the leak.
>>>
>>>>
>>>>
>>>> Sorry, besides also looking into ublk now (for main work), also in
>>>> progress to fix an issue with reduced queues and also still on the
>>>> libfuse part of sync-init....
>>>>
>>>>>
>>>>> registration vs abort:
>>>>>   - thread a: io_uring_enter -> register sqe ->
>>>>> fuse_uring_create_ring_ent -> allocate ent but doesn't grab queue_ref
>>>>> yet
>>>>>   - thread b: fuse_conn_destroy() -> fuse_abort_conn() ->
>>>>> fuse_uring_abort() -> fuse_uring_stop_queues() ->
>>>>> fuse_uring_teardown_entries(), skips scheduling async teardown work
>>>>> since queue_refs == 0, returns
>>>>>   - thread a: grabs the queue_ref, queue_ref is now 1, rest of
>>>>> fuse_uring_do_register() logic executes, ent is now marked cancelable,
>>>>> ent state is now available, ent is placed on available queue
>>>>>   - thread b: fuse_abort_conn() returns, fuse_wait_aborted() now runs
>>>>> and does a "wait_event(ring->stop_waitq,
>>>>> atomic_read(&ring->queue_refs) == 0);" which hangs since the waiter
>>>>> never gets woken
>>>>>
>>>>> whereas if we check preemptively at registration time, we explicjtly
>>>>> free the ent and release the queue_ref. I think the preemptive check
>>>>> needs to check ring->fc->connected though instead of queue->stopped,
>>>>> because there's the race where abort and stop_queues() may have been
>>>>> triggered before the register sqe path does queue creation. I'm hoping
>>>>> there's a better solution than having to grab the fc lock and checking
>>>>> fc->connected though, will try to look more at this next week.
>>>>>
>>>>> I think we can hit this hang on a ring creation vs abort race as well:
>>>>> * thread a: fuse_uring_cmd() gets called, passes fc->aborted check (not set yet)
>>>>> * thread b: abort is called, calls fuse_uring_abort(),
>>>>> fuse_uring_abort() is a no-op since ring == NULL right now
>>>>> * thread a: creates ring, creates queue, creates entry
>>>>> - if thread a takes the queue_ref count before the rest of the abort
>>>>> logic, we end up with the same hang as the situation above.
>>>>
>>>> IO-uring sends IO_URING_F_CANCEL for every registred command. We never
>>>> had a leak you describe. Upstream has a leak because it does not free
>>>> 'queue->ent_in_userspace' in fuse_uring_destruct. I'm fine with the
>>>> addition in fuse_uring_cancel() (although the just freeing the entries
>>>> in the list is much simpler and race free).
>>>>
>>>> Please let's not make it anymore complex.
>>>
>>> The issue is the hang, not the ent leak. What I'm trying to say is
>>> that the original patch submitted fixes one issue (kfreeing the ents)
>>> but doesn't fix the registration vs abort race, whereas the preemptive
>>> registration check fixes the leaked ents and the race.
>>>
>>> With the original patch, the umount thread still gets stuck
>>> permanently in TASK_UNINTERRUPTIBLE during the race. Even if the admin
>>> kills the daemon, the umount thread still holds the mount ref, which
>>> means delayed_release -> fuse_uring_destruct() will never get called
>>> and the entire ring gets leaked. If the original patch adds a
>>> wake_up_all() when queue_refs hits 0 in teardown, then killing the
>>> daemon does resolve it (as it'll wake up the umount thread), but the
>>> force-unmount still blocks in TASK_UNINTERRUPTIBLE state until the
>>> admin kills the server. The preemptive registration check is the more
>>> robust fix imo.
>>
>> Hmm, I think you are right for normal umount, for daemon kill
>> IO_URING_F_CANCEL handles it with the patch in this discussion - io-uring
>> will send IO_URING_F_CANCEL in a loop until io_uring_cmd_done() done is
>> called.
>> For plain umount I think it better to check for connection abort after
>> ring->queue_refs was increased, i.e. up to the last moment when
>> fuse_abort_conn() / fuse_wait_aborted() would wait. With the patch you
> 
> I had mentioned this in my previous email, "the preemptive check needs
> to check ring->fc->connected though instead of queue->stopped, because
> there's the race where abort and stop_queues() may have been triggered
> before the register sqe path does queue creation."
> 
>> suggested, I think the connection could be aborted after the check and
>> the ring entry might not be in any list yet, when fuse_uring_stop_queues()
>> gets called and queue stop would be a no-op.
> 
> If the connection is aborted after the check and the ring ent isn't on
> any list yet, I think that's fine. The async teardown worker is
> already guaranteed to be scheduled (since the ring->fc->connected
> check is done after the ent grabs the queue ref).
> 
> The actual problem is that if the register sqe is the first sqe for
> that queue and will trigger queue creation, then if the abort logic
> runs first before the queue creation, it will skip all the logic in
> fuse_uring_abort_end_requests() since "queue =
> READ_ONCE(ring->queues[qid]);" is a null queue, and consequently
> queue->stopped will never have been set to true.
> 
>>
>> How about this
>>
>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>> index 46812149bb2e..575b1042719c 100644
>> --- a/fs/fuse/dev_uring.c
>> +++ b/fs/fuse/dev_uring.c
>> @@ -1445,6 +1445,7 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *cmd,
>>                            struct fuse_ring_queue *queue)
>>  {
>>         struct fuse_ring *ring = queue->ring;
>> +       struct fuse_conn *fc = ring->fc;
>>         struct fuse_ring_ent *ent;
>>         size_t payload_size;
>>         struct iovec iov[FUSE_URING_IOV_SEGS];
>> @@ -1487,6 +1488,19 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *cmd,
>>         ent->payload = iov[1].iov_base;
>>
>>         atomic_inc(&ring->queue_refs);
>> +
>> +       spin_lock(&fc->lock);
>> +       atomic_inc(&ring->queue_refs);
>> +
>> +       /* check if the disconnected while creating the entry */
>> +       if (!fc->connected) {
>> +               atomic_dec(&ring->queue_refs);
>> +               err = -ENOTCONN;
>> +               wake_up_all(&ring->stop_waitq);
>> +       }
>> +       spin_unlock(&fc->lock);
>> +       if (err)
>> +               goto error;
>>         return ent;
>>
> 
> I don't think it matters if this is within
> fuse_uring_create_ring_ent() instead of fuse_uring_do_register(). I

Yeah, that doesn't matter, it just has to be after the increase of 
queue_refs. I probably missed the complete patch before, but I had
only seen the change in fuse_uring_create(), which is before increase
of queue_refs. 
Code changes in fuse_uring_create_ring_ent() are little bit smaller,
as it already has the free of ring_ent. In the end I don't care and
either way works.

> put the logic inside of fuse_uring_do_register() because that seemed
> logically cleaner to me (eg create_ent() is only responsible for ent
> allocation/initialization logic, any race checks to halt rest of sqe
> registration flow are outside that), though if you have a preference
> to have it inside fuse_uring_create_ring_ent() that's fine by me. This
> is waht I have locally:
> 
> Subject: [PATCH] fuse/uring: fix abort races with ring creation and ent
>  registration
> 
> This fixes the following races:
> registration vs. abort:
>   - thread a: io_uring_enter -> register sqe ->
> fuse_uring_create_ring_ent -> allocate ent but doesn't grab queue_ref
> yet
>   - thread b: fuse_conn_destroy() -> fuse_abort_conn() ->
> fuse_uring_abort() -> fuse_uring_stop_queues() ->
> fuse_uring_teardown_entries(), skips scheduling async teardown work
> since queue_refs == 0, returns
>   - thread a: grabs the queue_ref, queue_ref is now 1, rest of
> fuse_uring_do_register() logic executes, ent is now marked cancelable,
> ent state is now available, ent is placed on available queue
>   - thread b: fuse_abort_conn() returns, fuse_wait_aborted() now runs
> and does a "wait_event(ring->stop_waitq,
> atomic_read(&ring->queue_refs) == 0);" which hangs since the waiter
> never gets woken
> 
> ring creation vs abort:
> - thread a: fuse_uring_cmd() gets called, passes fc->aborted check (not
>   set yet)
> - thread b: abort is called, calls fuse_uring_abort(),
> fuse_uring_abort() is a no-op since ring == NULL right now
> - thread a: creates ring, creates queue, creates entry
> - if thread a takes the queue_ref count before the rest of the abort
> logic, we end up with the same hang as the situation above.
> 
> This additionally addresses the ent memleak in the registration vs
> cancel race in [1].
> 
> [1] https://lore.kernel.org/linux-fsdevel/20251021-io-uring-fixes-cancel-mem-leak-v1-0-26b78b2c973c@ddn.com/
> ---
>  fs/fuse/dev_uring.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index f6b12aebb8bb..4bbc71755cb8 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -243,6 +243,10 @@ static struct fuse_ring *fuse_uring_create(struct
> fuse_conn *fc)
>         max_payload_size = max(max_payload_size, fc->max_pages * PAGE_SIZE);
> 
>         spin_lock(&fc->lock);
> +       if (!fc->connected) {
> +               spin_unlock(&fc->lock);
> +               goto out_err;
> +       }

Strictly this isn't needed, but doesn't hurt either.

>         if (fc->ring) {
>                 /* race, another thread created the ring in the meantime */
>                 spin_unlock(&fc->lock);
> @@ -974,7 +978,7 @@ static bool is_ring_ready(struct fuse_ring *ring,
> int current_qid)
>  /*
>   * fuse_uring_req_fetch command handling
>   */
> -static void fuse_uring_do_register(struct fuse_ring_ent *ent,
> +static int fuse_uring_do_register(struct fuse_ring_ent *ent,
>                                    struct io_uring_cmd *cmd,
>                                    unsigned int issue_flags)
>  {
> @@ -983,6 +987,16 @@ static void fuse_uring_do_register(struct
> fuse_ring_ent *ent,
>         struct fuse_conn *fc = ring->fc;
>         struct fuse_iqueue *fiq = &fc->iq;
> 
> +       spin_lock(&fc->lock);
> +       /* abort teardown path is running or has run */
> +       if (!fc->connected) {
> +               spin_unlock(&fc->lock);
> +               atomic_dec(&ring->queue_refs);
> +               kfree(ent);
> +               return -ECONNABORTED;
> +       }
> +       spin_unlock(&fc->lock);
> +
>         fuse_uring_prepare_cancel(cmd, issue_flags, ent);
> 
>         spin_lock(&queue->lock);
> @@ -999,6 +1013,7 @@ static void fuse_uring_do_register(struct
> fuse_ring_ent *ent,
>                         wake_up_all(&fc->blocked_waitq);
>                 }
>         }
> +       return 0;
>  }
> 
>  /*
> @@ -1114,9 +1129,7 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
>         if (IS_ERR(ent))
>                 return PTR_ERR(ent);
> 
> -       fuse_uring_do_register(ent, cmd, issue_flags);
> -
> -       return 0;
> +       return fuse_uring_do_register(ent, cmd, issue_flags);
>  }
> 
>  /*
> --
> 2.52.0
> 
> though I'll probably end up splitting this into two separate patches
> when submitting. I don't think the wake_up_all(&ring->stop_waitq);
> call is needed in the preemptive checking, as the async teardown work
> will already take care of that.

I have this in my mind


core-A                                                  core-B

fuse_uring_create_ring_ent()

       ent->headers = headers->iov_base;
       ent->payload = payload->iov_base;
 }
                                             fuse_conn_destroy()
                                                fuse_abort_conn()
                                                  fuse_uring_abort() -> no-op
                                                fuse_wait_aborted()

        atomic_inc(&ring->queue_refs);
                                                fuse_uring_wait_stopped_queues()



Thanks,
Bernd

