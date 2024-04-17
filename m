Return-Path: <stable+bounces-40133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797F08A8F42
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 01:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEA78B221E7
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 23:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8F985620;
	Wed, 17 Apr 2024 23:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="X9ValRwR";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="e1C6+hdT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jekBbRtb"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1177C083;
	Wed, 17 Apr 2024 23:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713395686; cv=fail; b=mHrJC1qJpqSYHHsrC4qop3fmD+CiP74FMoBY9WjziqA8FA4dPkMvWi1h9D1FrCOxARTseNA76TG3uNrR0Q0apXw4x4qxPh7bfpDXX7nlddrrHvR4IpTy22xdCSNeq+J9NlCtIZSotGq6xYl+I++alGeHPIfHzuNeWaiR535osx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713395686; c=relaxed/simple;
	bh=8yGpAGe4AxtHxlN49rA7q8lODfkxrs/+5dC3S8T1o4Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=paHi+v+bsq/it7RybD2jX6e0C/FIF97qK4McKx+oKAHe6AEPhT4zKjB9L5z+5GqxAjKJfsmuribWDvF5l3/ya+A+rkrFV7wRwRIjRVIUPt+bK9eX1JEhGShW/uCVW7bAiC11wCjj8GNnf+fV3inQH5xrOuJdmccyirlVnhuLp44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=X9ValRwR; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=e1C6+hdT; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=jekBbRtb reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43HMZsBJ008269;
	Wed, 17 Apr 2024 16:14:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	pfptdkimsnps; bh=1TiWIRv6aNGXvkuu4md0xlwUHP0IGdYqfU+3qK1DskE=; b=
	X9ValRwRl/ecdL5ObtkXY6/P9RiClOMAF6S5sq05wc0zIgIJQp5NtZiWjHI7EJ1P
	8G15tn/t77ymoEwWDESZqTsQfrUBp9AW816G5kiKMSBBGSG6s/efsDMbW89oDliR
	44BZivds+KKxNbk9X+kA0K0Mwc5D67tx3XBY9m8zH/cD7hrcssaFaU937TdG1yTO
	pEnJPTC2Ac1wMSsMH8SCBdjw2DSjOZ0lzWqFtzfyokM81RHFBmGDx0zcd0TmYrgD
	1qqvedSAB9AjMf9G9Jmr9UuzBu31nu9HVLM30J+sFmgeEYHAc8+EdFcVxHUekhZq
	Yqe4nfTmWImb/bWteiXWbA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3xjgkta7xa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 16:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1713395682; bh=8yGpAGe4AxtHxlN49rA7q8lODfkxrs/+5dC3S8T1o4Y=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=e1C6+hdTSzhu2lF//I7zrOUWoHSDfFUgRW9MLwMEE99859CQz/UaUmX83p3mwJT/t
	 eCl7fiaTmRgfgUNCjzJUPTYcP4XtB/RedQfdfjXIvz7sy9lGO57e/k5j/QaVjOaP4A
	 Wv0p2KemM/p+gZi77tx15bI4eZr/GccT3JM2AqOfHUep+7G0ml6tJ4sI1ZguufiQPc
	 GahjqywfJE2Qe5kb3534axMNh1HK+euUCH8q96mc8eCkiB4iH/GpGbe4+Xx3dPaEq6
	 AGqmwympXAbU8CY/5/ylkgVe3EJyQWiPEnaiPgrffD9X0VjqAWfpwZnAlp1gI56Vdr
	 wNdCb693ZRbiQ==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2F654401C6;
	Wed, 17 Apr 2024 23:14:42 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 1C237A006D;
	Wed, 17 Apr 2024 23:14:42 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=jekBbRtb;
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 9612E400A2;
	Wed, 17 Apr 2024 23:14:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFc3Ty5VYJKVmphu9XxTMZ53ztr1V9YG6pySwkddtL+dp9UI0ANk+vIm9tp+SneF3um0btxqFSW9ljPmX8dLUZXj0ItNS8iYZFCYKyVubjhGk099vKxFOrTddMhsPogpOfLPKe9zCSPmNA3iMLQmZLl+CQO/wi8ddTbkBsIPikgMCe2+UDw317H5gIJMjdnNls+w/SFUVKyqfNEYmKn/Ct+0ifwfdNfVmejBpjqNUH1tCau2SL0d3+N2AxuI9WP50qDfaFoei9aEa5WjZl1opwMTInup6TzbsZxdFDhADPPOWJ0VCJSDYowiA+4041tUFHnWrJ4yUFlKqDFTaC5FGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TiWIRv6aNGXvkuu4md0xlwUHP0IGdYqfU+3qK1DskE=;
 b=MfXvR7QblnWc7gb8R3G5zCke71cuChcqokWqlX5QQijOXX8V2GaJARpDg8dN7oF+m4L3I+WuHOd03muwJA59LxVWSWyAadcrfEk2KpOFbJsDsW5qExvwmTns85QYiSLZ5m+vvOYMvEJNJgekqGiOst9nTLT2hYJz9EUch09bw63ScEqWRJtU+lJl0HM7VqVVRuRiY5qBrparakHDbfG2Zz+SanepUC4Se0vR8KuDUC7+uKsEh9d8F9N4f2Lmap3rTZcce9CubYllLp26M8aPSmrAVnU+tH8SYZSzZzIaE5bQ1p/syL7DOsRhC2c5TYQ6LdOwsGcx9HOAMVa5GxVq3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TiWIRv6aNGXvkuu4md0xlwUHP0IGdYqfU+3qK1DskE=;
 b=jekBbRtbALwkIEenp8YZJ8fPzpw734VLYKwIl27k6V/GBeV7+DbWExyqzaiLzgNBr56JV+c3zEBlEiYJlrYOEezF6/owLg6tSDDbhq0hC3QF5eiHeX73T/GCdNzKPjp3vcAhal0HpkckX8i/efw9C+NbRhhmOwpMp1i07XYVUnU=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by LV3PR12MB9118.namprd12.prod.outlook.com (2603:10b6:408:1a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Wed, 17 Apr
 2024 23:14:37 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d%7]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 23:14:36 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: John Youn <John.Youn@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v2 2/2] usb: dwc3: core: Prevent phy suspend during init
Thread-Topic: [PATCH v2 2/2] usb: dwc3: core: Prevent phy suspend during init
Thread-Index: AQHakR0EbYmkUkR/o0OT/UUX1EhVrQ==
Date: Wed, 17 Apr 2024 23:14:36 +0000
Message-ID: 
 <20da4e5a0c4678c9587d3da23f83bdd6d77353e9.1713394973.git.Thinh.Nguyen@synopsys.com>
References: <cover.1713394973.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1713394973.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|LV3PR12MB9118:EE_
x-ms-office365-filtering-correlation-id: 2234cfff-58e9-4881-de24-08dc5f342687
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 vWqJ+0q9MRi7pGsaogIU6nzhagw8qB9FMogmcBKjKDagJGnf6sT/vaDan0xXxdeHUbmuRe2x9/r6BuonQFb1yqCnvzQ8NFSHBopzYbCCS6v1y6s/RMecSR+/GB7w9MLK2UWL2mbLNKv48j4O4Z58cyuyPeFV3NPLtXhgtzQbyYBcjV1nRrSMVzGna7rA4jVcw5kwsoPUGOtt5x+OTDhFXYDxts+8DJrZVAdCv0qtomqgn8B/G/tzbzP7z7z4k/Z3dt00/pM28oyGCJeKh7c45ftn2You9o8gX6pEf0kg9Y1ve2De/jew7supnB9M1mrFNgwB139+mTbohk8V/ZsHC/F22Qj8X3je68y2HyjenfGu9cuZWfEqYrzNlTb0oVjAaPb4bWseC1dFpJAhNrmgvkc8BM7XxeODDytq8B2QNGBIZyiwtlSW7AnqT/CqVBz0OsgcQxd9y4Oc0+bL22rNFwMjRJuE7qd+EMh9dPUIYZKshIDE0LMX1xmcFhwk0NGAEb4Iu8+KeN98ITYiaGwXkA473Uiq/a+L8308JSJEgfD7Hyef4FNiYXxtLHsSuxAFQvzMUEjpNza6KuMQ/Kdm9cDBJ7DWJvEzwk9xrheXG+7Nsl4mVLbcOFB45mWngPL7o7onTov95ZaUaxQ7bDy7a3sPz5oKLXBnRjuMwwKhGM1klIcFa40Fg5a60pbWe5hQSi5ImMV1v7Cb1+75hIRcI0hgJSZ/Wpt6Y9uVq4vEp2Y=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?dsS1i7kjT3Tq6GwDEdNhhbZcuLMS1cGBe+kOgM11DvF7UjCcbHJ3o4eSFT?=
 =?iso-8859-1?Q?AvDfZO9vrpMptvhMQzNJoIeNvI38d3OrJcVSn+3588JrjPbAi7z+swIpnV?=
 =?iso-8859-1?Q?j47RVB1/qJMyE7wSqBY6sRePOMsH/Y4KlCMr3Nq++lVxuVOEre3wciyUaC?=
 =?iso-8859-1?Q?UFxgP3rLHLmfxPPR9jPOiPIT6dWWFQzCgq7LdkP3sv0SmgQOWB8+S2/VWa?=
 =?iso-8859-1?Q?JehzHl2m44ld5Jtn5bORgaMEparb81ExDQWC9FBzeSGBkNybVwEZas7cku?=
 =?iso-8859-1?Q?AnMTBLZuh2C6alk5Utgd6iueqm36s73TrbqASLCct3Zxcfm2X4LwnT/zl2?=
 =?iso-8859-1?Q?muwKxaRuzShPC5D0KyxueJAI+mory1vcJVPa9dHrwenLMd+ljiasYMWqzH?=
 =?iso-8859-1?Q?b1aj3ojdr/sKXm2OiBA/KcT1ZGVGATS8vmFsTQ6jtehKBpL3IhbvuRiYEX?=
 =?iso-8859-1?Q?RqT0Baaf47l3/FrVS86Ld5AF2JAcUP9kRjeAIuyy+55PDM0NzjIc0Izo6+?=
 =?iso-8859-1?Q?EHFvxDrQEGl9b2G0psp9auyDM/lpD5oJ3vPe5iUPycG9p5MfGcYOJtUQOm?=
 =?iso-8859-1?Q?lgZCcqUpr5GzshcIeDqwm2V/hsNzlgkDcnKVK87O0IOYlOrTrxpHM9rc34?=
 =?iso-8859-1?Q?AxsheGhSEdh/4JYfotVBs1d8JaZt8d5HkMP2eNDHqRM9Feyj3TfjjEBj83?=
 =?iso-8859-1?Q?CloQbtNxVyUzTzdY4Cgv435w6/gsbEzFejNcLLPP+cc8sVX5ND5OIvw/xP?=
 =?iso-8859-1?Q?6ENY9ZSiFcW9qZ7yml+n2TfAnLPOZEPXXQJ61tCdrCWj0JRjHB+K91ioPp?=
 =?iso-8859-1?Q?O/0ItZRQjjmaAINuQGAEoo/ZbU1ISE3a+AqTMCc/o2/f0btSWnoVXZ6212?=
 =?iso-8859-1?Q?FzEFWGoV3D8sOWGWzKbX4gag0YIbW6pawybMNidttSW3eUc3y4zRrM1+bc?=
 =?iso-8859-1?Q?V9f6aafHAZtptyBMjIKqhbZrTe2/MrdzrNQJybWzJOrdAkeMZOGO72vVyy?=
 =?iso-8859-1?Q?bqlO9oLFlTLs0n0aDgNWfeg8esFN4bt7VD/15YyGL95sD7GlB7g17PwoYX?=
 =?iso-8859-1?Q?9zrxWaOaK5OZb9kwXdJYde9hxsQNRohSAlQrb8UtYW7JJvaL1npGbxr+tp?=
 =?iso-8859-1?Q?Ja4h30Pq6ic8q7LRw4YqEueZH72JsIFK+7mecWjddzLSxGzufn4t8AfCsL?=
 =?iso-8859-1?Q?N97JAy4ckWBXdJLB3Sm+NGa+eNq9NLG12m/aMbprxIbEtPAURQYujKElDv?=
 =?iso-8859-1?Q?3V8AYBmaO76bzbeVKnF3WwU3cnnjc88pDw7h8x46QtC3utGKS58mjR911P?=
 =?iso-8859-1?Q?rbXnzjYoZMhyg3SigH8LP3HulxoQbroR5DyR+L4HMs90TWDTa3bwi6HLBd?=
 =?iso-8859-1?Q?squwXmpvMhwx5g7o8D3wVTWeJPIxZVBKL46E7U+0nMR4Umw1HoeuVD6oMj?=
 =?iso-8859-1?Q?EZ6LlY6QMK5WzfGREM3ydDFFFNBQWMLDuQuh7TrvJ6uGEOAKd57hfV8K2s?=
 =?iso-8859-1?Q?SI4Jk9QZ5VoNcWSFN1vg1OLVlIx6XtK9Ee3imScMGzpL4Y6IxmyXfsvpC3?=
 =?iso-8859-1?Q?Tbg9PpnCSZ6BOIoZgv/6/boSrvE+z6IPLYHLTzUACjST7m/9Mfqu+3pdO/?=
 =?iso-8859-1?Q?HX9h+hfUqj0DlYK42q26rAAcxYATgxn1Er?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	SKjG61WlRCDAweVCIqrjxCwuZ5dFfge13VzVroNQXfOrxvUNDJd3xKU5PhXSt7wDw2UVKlHgt+8KaICk15cGXp6LY9N9RGPetXhPs2QvgoLnNIdqkKkjgC//+vSwvzMQ+xu8qm2DM5+cILPRWltJPYQGrIQF8QiBDEZSXltEQSw2oqkoK7ovu/2WC+kcJacx4uWKgMYWpr2xz0g0iZVStPDGJh8mmp+SzxbgLLWt7dJjP+JVmxvgYUAI3iyFEDNwUtwLIiWFCi0HV04r6vBgen8ijwB2YbBwwriitk9v7BCeloYz++n3MbPbxT4xSmV3AV7RMGgqKLrimj2f8tZQIwNG6XrzEIz3r4Vst0bPOQ4R7teMypmVn5IGNq5tcbHzKwlQdSn9knV+3XEWDGd4KpwWMepHafCXEHL/QCYYr3M1u0ZygEHqnHeJWG6CiV7vAewaAD8JU781k5XRIltAm2E9JIgXFc6MoH6yAf9uCeB1UcycFMRqKR45DW+Yt7v+6HRN+IJHOK+S6qitRaysWRh/eCQosh7LnIWYGbs0sGSYp5UFYM+J+DshaKShbWsgyTTVsiYma2lOY4clOm8FaglD7Z3SzNiDV/RB4mXcflw3ZV6mTUXY6VCDDKNuBK9FqIwLrVX/0fBs0T/oYe3kVg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2234cfff-58e9-4881-de24-08dc5f342687
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 23:14:36.8570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CH8BWMQR3F7hBjrwXS+QCgZLvfmCyHR88yvPUAvlkfZSEX0ahPwaez77SxoB23ts0rien/yQocWR0vn5bkPDUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9118
X-Proofpoint-ORIG-GUID: s12m_f5XBQz_BnrvRbaIs_pcOhC8O95v
X-Proofpoint-GUID: s12m_f5XBQz_BnrvRbaIs_pcOhC8O95v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_18,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404170165

GUSB3PIPECTL.SUSPENDENABLE and GUSB2PHYCFG.SUSPHY should be cleared
during initialization. Suspend during initialization can result in
undefined behavior due to clock synchronization failure, which often
seen as core soft reset timeout.

The programming guide recommended these bits to be cleared during
initialization for DWC_usb3.0 version 1.94 and above (along with
DWC_usb31 and DWC_usb32). The current check in the driver does not
account if it's set by default setting from coreConsultant.

This is especially the case for DRD when switching mode to ensure the
phy clocks are available to change mode. Depending on the
platforms/design, some may be affected more than others. This is noted
in the DWC_usb3x programming guide under the above registers.

Let's just disable them during driver load and mode switching. Restore
them when the controller initialization completes.

Note that some platforms workaround this issue by disabling phy suspend
through "snps,dis_u3_susphy_quirk" and "snps,dis_u2_susphy_quirk" when
they should not need to.

Cc: stable@vger.kernel.org
Fixes: 9ba3aca8fe82 ("usb: dwc3: Disable phy suspend after power-on reset")
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 Changes in v2:
 - None

 drivers/usb/dwc3/core.c   | 90 +++++++++++++++++----------------------
 drivers/usb/dwc3/core.h   |  1 +
 drivers/usb/dwc3/gadget.c |  2 +
 drivers/usb/dwc3/host.c   | 27 ++++++++++++
 4 files changed, 68 insertions(+), 52 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 31684cdaaae3..100041320e8d 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -104,6 +104,27 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
 	return 0;
 }
=20
+void dwc3_enable_susphy(struct dwc3 *dwc, bool enable)
+{
+	u32 reg;
+
+	reg =3D dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
+	if (enable && !dwc->dis_u3_susphy_quirk)
+		reg |=3D DWC3_GUSB3PIPECTL_SUSPHY;
+	else
+		reg &=3D ~DWC3_GUSB3PIPECTL_SUSPHY;
+
+	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
+
+	reg =3D dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+	if (enable && !dwc->dis_u2_susphy_quirk)
+		reg |=3D DWC3_GUSB2PHYCFG_SUSPHY;
+	else
+		reg &=3D ~DWC3_GUSB2PHYCFG_SUSPHY;
+
+	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+}
+
 void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
 {
 	u32 reg;
@@ -585,11 +606,8 @@ static int dwc3_core_ulpi_init(struct dwc3 *dwc)
  */
 static int dwc3_phy_setup(struct dwc3 *dwc)
 {
-	unsigned int hw_mode;
 	u32 reg;
=20
-	hw_mode =3D DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
-
 	reg =3D dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
=20
 	/*
@@ -599,21 +617,16 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	reg &=3D ~DWC3_GUSB3PIPECTL_UX_EXIT_PX;
=20
 	/*
-	 * Above 1.94a, it is recommended to set DWC3_GUSB3PIPECTL_SUSPHY
-	 * to '0' during coreConsultant configuration. So default value
-	 * will be '0' when the core is reset. Application needs to set it
-	 * to '1' after the core initialization is completed.
-	 */
-	if (!DWC3_VER_IS_WITHIN(DWC3, ANY, 194A))
-		reg |=3D DWC3_GUSB3PIPECTL_SUSPHY;
-
-	/*
-	 * For DRD controllers, GUSB3PIPECTL.SUSPENDENABLE must be cleared after
-	 * power-on reset, and it can be set after core initialization, which is
-	 * after device soft-reset during initialization.
+	 * Above DWC_usb3.0 1.94a, it is recommended to set
+	 * DWC3_GUSB3PIPECTL_SUSPHY to '0' during coreConsultant configuration.
+	 * So default value will be '0' when the core is reset. Application
+	 * needs to set it to '1' after the core initialization is completed.
+	 *
+	 * Similarly for DRD controllers, GUSB3PIPECTL.SUSPENDENABLE must be
+	 * cleared after power-on reset, and it can be set after core
+	 * initialization.
 	 */
-	if (hw_mode =3D=3D DWC3_GHWPARAMS0_MODE_DRD)
-		reg &=3D ~DWC3_GUSB3PIPECTL_SUSPHY;
+	reg &=3D ~DWC3_GUSB3PIPECTL_SUSPHY;
=20
 	if (dwc->u2ss_inp3_quirk)
 		reg |=3D DWC3_GUSB3PIPECTL_U2SSINP3OK;
@@ -639,9 +652,6 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->tx_de_emphasis_quirk)
 		reg |=3D DWC3_GUSB3PIPECTL_TX_DEEPH(dwc->tx_de_emphasis);
=20
-	if (dwc->dis_u3_susphy_quirk)
-		reg &=3D ~DWC3_GUSB3PIPECTL_SUSPHY;
-
 	if (dwc->dis_del_phy_power_chg_quirk)
 		reg &=3D ~DWC3_GUSB3PIPECTL_DEPOCHANGE;
=20
@@ -689,24 +699,15 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	}
=20
 	/*
-	 * Above 1.94a, it is recommended to set DWC3_GUSB2PHYCFG_SUSPHY to
-	 * '0' during coreConsultant configuration. So default value will
-	 * be '0' when the core is reset. Application needs to set it to
-	 * '1' after the core initialization is completed.
-	 */
-	if (!DWC3_VER_IS_WITHIN(DWC3, ANY, 194A))
-		reg |=3D DWC3_GUSB2PHYCFG_SUSPHY;
-
-	/*
-	 * For DRD controllers, GUSB2PHYCFG.SUSPHY must be cleared after
-	 * power-on reset, and it can be set after core initialization, which is
-	 * after device soft-reset during initialization.
+	 * Above DWC_usb3.0 1.94a, it is recommended to set
+	 * DWC3_GUSB2PHYCFG_SUSPHY to '0' during coreConsultant configuration.
+	 * So default value will be '0' when the core is reset. Application
+	 * needs to set it to '1' after the core initialization is completed.
+	 *
+	 * Similarly for DRD controllers, GUSB2PHYCFG.SUSPHY must be cleared
+	 * after power-on reset, and it can be set after core initialization.
 	 */
-	if (hw_mode =3D=3D DWC3_GHWPARAMS0_MODE_DRD)
-		reg &=3D ~DWC3_GUSB2PHYCFG_SUSPHY;
-
-	if (dwc->dis_u2_susphy_quirk)
-		reg &=3D ~DWC3_GUSB2PHYCFG_SUSPHY;
+	reg &=3D ~DWC3_GUSB2PHYCFG_SUSPHY;
=20
 	if (dwc->dis_enblslpm_quirk)
 		reg &=3D ~DWC3_GUSB2PHYCFG_ENBLSLPM;
@@ -1227,21 +1228,6 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	if (ret)
 		goto err_exit_phy;
=20
-	if (hw_mode =3D=3D DWC3_GHWPARAMS0_MODE_DRD &&
-	    !DWC3_VER_IS_WITHIN(DWC3, ANY, 194A)) {
-		if (!dwc->dis_u3_susphy_quirk) {
-			reg =3D dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
-			reg |=3D DWC3_GUSB3PIPECTL_SUSPHY;
-			dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
-		}
-
-		if (!dwc->dis_u2_susphy_quirk) {
-			reg =3D dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-			reg |=3D DWC3_GUSB2PHYCFG_SUSPHY;
-			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
-		}
-	}
-
 	dwc3_core_setup_global_control(dwc);
 	dwc3_core_num_eps(dwc);
=20
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 7e80dd3d466b..180dd8d29287 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1580,6 +1580,7 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc);
 void dwc3_event_buffers_cleanup(struct dwc3 *dwc);
=20
 int dwc3_core_soft_reset(struct dwc3 *dwc);
+void dwc3_enable_susphy(struct dwc3 *dwc, bool enable);
=20
 #if IS_ENABLED(CONFIG_USB_DWC3_HOST) || IS_ENABLED(CONFIG_USB_DWC3_DUAL_RO=
LE)
 int dwc3_host_init(struct dwc3 *dwc);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 4df2661f6675..f94f68f1e7d2 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2924,6 +2924,7 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 	dwc3_ep0_out_start(dwc);
=20
 	dwc3_gadget_enable_irq(dwc);
+	dwc3_enable_susphy(dwc, true);
=20
 	return 0;
=20
@@ -4690,6 +4691,7 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 	if (!dwc->gadget)
 		return;
=20
+	dwc3_enable_susphy(dwc, false);
 	usb_del_gadget(dwc->gadget);
 	dwc3_gadget_free_endpoints(dwc);
 	usb_put_gadget(dwc->gadget);
diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index 0204787df81d..a171b27a7845 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -10,10 +10,13 @@
 #include <linux/irq.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
=20
 #include "../host/xhci-port.h"
 #include "../host/xhci-ext-caps.h"
 #include "../host/xhci-caps.h"
+#include "../host/xhci-plat.h"
 #include "core.h"
=20
 #define XHCI_HCSPARAMS1		0x4
@@ -57,6 +60,24 @@ static void dwc3_power_off_all_roothub_ports(struct dwc3=
 *dwc)
 	}
 }
=20
+static void dwc3_xhci_plat_start(struct usb_hcd *hcd)
+{
+	struct platform_device *pdev;
+	struct dwc3 *dwc;
+
+	if (!usb_hcd_is_primary_hcd(hcd))
+		return;
+
+	pdev =3D to_platform_device(hcd->self.controller);
+	dwc =3D dev_get_drvdata(pdev->dev.parent);
+
+	dwc3_enable_susphy(dwc, true);
+}
+
+static const struct xhci_plat_priv dwc3_xhci_plat_quirk =3D {
+	.plat_start =3D dwc3_xhci_plat_start,
+};
+
 static void dwc3_host_fill_xhci_irq_res(struct dwc3 *dwc,
 					int irq, char *name)
 {
@@ -167,6 +188,11 @@ int dwc3_host_init(struct dwc3 *dwc)
 		}
 	}
=20
+	ret =3D platform_device_add_data(xhci, &dwc3_xhci_plat_quirk,
+				       sizeof(struct xhci_plat_priv));
+	if (ret)
+		goto err;
+
 	ret =3D platform_device_add(xhci);
 	if (ret) {
 		dev_err(dwc->dev, "failed to register xHCI device\n");
@@ -192,6 +218,7 @@ void dwc3_host_exit(struct dwc3 *dwc)
 	if (dwc->sys_wakeup)
 		device_init_wakeup(&dwc->xhci->dev, false);
=20
+	dwc3_enable_susphy(dwc, false);
 	platform_device_unregister(dwc->xhci);
 	dwc->xhci =3D NULL;
 }
--=20
2.28.0

