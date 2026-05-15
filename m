Return-Path: <stable+bounces-248920-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QObJFEiKB2ol7gIAu9opvQ
	(envelope-from <stable+bounces-248920-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 23:04:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FD95579F2
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 23:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2554830078ED
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 21:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1913DE421;
	Fri, 15 May 2026 21:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="AzokAJI4"
X-Original-To: stable@vger.kernel.org
Received: from iad-out-015.esa.us-east-1.outbound.mail-perimeter.amazon.com (iad-out-015.esa.us-east-1.outbound.mail-perimeter.amazon.com [44.210.169.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AD41DF261;
	Fri, 15 May 2026 21:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=44.210.169.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879043; cv=fail; b=gJuECixKLkJdOryf3wAegNvcsGLt98q7GpGihLkG62AI1kKfMrXkstnNo0gNw/GOWQycd+T0CeH3ubQgddzM6HacVcaW2jEPNxOyof0vVD1N2SJUbfxWbT5Nf+nLb5UiRkrI5K0VjQNU+g7ppDxfIra45X3NT3PFKK3bHgKyUqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879043; c=relaxed/simple;
	bh=MMXF93LjrgQID7ejGu09CCOyeVA176D7Z841pE7G7+4=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J6y6r0RU3czMASKWwcdb1RGHGt6Q/98oQ1+wT1D2WXOm7+QC+uXu0oQGYZKvSS1eTrn+hGADkACSyNfA0nYQhjLOurS8OpIzGspn3cUyQyWMPkEbY6AfPiixxIpjBJY7s6n2FNFNGlHSFDYeEdxXy57/sQ9FnxkYdb9A1/36Sn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=AzokAJI4; arc=fail smtp.client-ip=44.210.169.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778879042; x=1810415042;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=MMXF93LjrgQID7ejGu09CCOyeVA176D7Z841pE7G7+4=;
  b=AzokAJI4gl+E6w0HKYm87EH0hWMIoElcAg+f/1jvx2VdYGw9KggGYcMS
   gTopOh4z24/Y2C91Gw8CnvBRWfpfl+GHsBvvlu9Lqn/2tkiinN3XB8jVj
   h6tWKyzWhq+hYtFW8XxSzYAo3o2w5TGk/IHshoPHH/jsXY1ocO5WFbqim
   JIE/Iogkvufs794Zd8Hg7cruxa3mR3CDgbXBnNrpmf6QEv2vrk1t6gI+S
   +BcfSuN5aJnIYEwbAXay9zWTS9UDMHUZjW0wRNVjgIOxFoi2VhTErfRH5
   hVioS9ohUoyCmmJiTLYATMaqezWKjAX1dEJSSF2HOk/Hu3pxG0kk92zyj
   g==;
X-CSE-ConnectionGUID: xM/xA3NGRai/FzjmWhWLCg==
X-CSE-MsgGUID: E4dDye+CRoOYslMRhzAGIw==
X-IronPort-AV: E=Sophos;i="6.23,237,1770595200"; 
   d="scan'208";a="18263465"
Subject: Re: [BUG] net: tcp: SO_LINGER with l_linger=0 leaks memory when closing
 sockets with pending send data
Thread-Topic: [BUG] net: tcp: SO_LINGER with l_linger=0 leaks memory when closing sockets
 with pending send data
Received: from ip-10-4-3-150.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.3.150])
  by internal-iad-out-015.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 21:04:01 +0000
Received: from EX19MTAUEC002.ant.amazon.com [72.21.196.66:27698]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.27.17:2525] with esmtp (Farcaster)
 id 502aafc3-9193-4ad7-ba40-3b1646350a4e; Fri, 15 May 2026 21:04:00 +0000 (UTC)
X-Farcaster-Flow-ID: 502aafc3-9193-4ad7-ba40-3b1646350a4e
Received: from EX19EXOUEB001.ant.amazon.com (10.252.135.46) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 15 May 2026 21:03:57 +0000
Received: from EX19EXOUEC001.ant.amazon.com (10.252.135.173) by
 EX19EXOUEB001.ant.amazon.com (10.252.135.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 15 May 2026 21:03:57 +0000
Received: from SN1PR07CU001.outbound.protection.outlook.com (10.252.135.199)
 by EX19EXOUEC001.ant.amazon.com (10.252.135.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37
 via Frontend Transport; Fri, 15 May 2026 21:03:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PT353Nx6eD8sqy0KfWqaNv6xDxWtaB7gyPX951bOBqic2tVvqSdGRmt7UT3lvhzRmuBVATjjt5edMtAP9Q1FE0a5IAY3NKNK0nQjSwOlOtY9mLRQ9Z+km11IllydGuRFIxP/n5XvVLhRMbyTDe6OGmheMy1hjbcVc3h9kIJZZsTd4ZqUnehZJJOR+RA2wdpFOwvS18Y/+kBizrUmHsrq18wP5a80Ff3p3LpHWuHIR2a+5FgCo6cNooZSCtmUPDsbji4Mq9kyrzYf25zHg8uBX2uNZ+GsgoSe8G7nBoPRJLOl+Mpt/mvkocFKerTWTPyI04kn+hEPGqQOrhVuVyYMNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMXF93LjrgQID7ejGu09CCOyeVA176D7Z841pE7G7+4=;
 b=g+bbsssygFvdQn1zi8yU01OmOsGKQ8O4HM3atMzHQnW2X2tYDFU89DdYu3nTL9Njt0H/lGbHNgdwXk/OR/YyRaOEhR7XhRM9DVYk8PSU9+vb6X1gqNB/38ZwKfti1XdjUAdYPlrR4cpd2fm5CxLlSUiAjTzrXXhah8us3dU0IjfDSudaz7CI0lsC+P6qMnWXJkB8pp6TGQwmgjH1K9+5cJ9CftVFFmraLHqmipFUq5m48eEL52Jv5Z3QgWOxSUB6InBJaG0dCz8Yy0lDhvNNekWRgWKc3Jf8RY+bvgSbFgCYJafn3YuWEo1htP/MI+7dcyiYGViiiL8wOYDdwyvFXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from SA1PR18MB4728.namprd18.prod.outlook.com (2603:10b6:806:1db::15)
 by IA2PR18MB5936.namprd18.prod.outlook.com (2603:10b6:208:4b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 21:03:54 +0000
Received: from SA1PR18MB4728.namprd18.prod.outlook.com
 ([fe80::3fa5:9d2e:e6a6:67d5]) by SA1PR18MB4728.namprd18.prod.outlook.com
 ([fe80::3fa5:9d2e:e6a6:67d5%6]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 21:03:54 +0000
From: "Ahmed, Aaron" <aarnahmd@amazon.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "edumazet@google.com" <edumazet@google.com>
Thread-Index: AQHczskVAbHrfsqWm0ylDOIzc6Zy8LXj+36AgA8bggCAAJPFgIAbnvuA
Date: Fri, 15 May 2026 21:03:53 +0000
Message-ID: <680D9A46-7BEF-4DE0-9D50-A6E5ADFC7EA0@amazon.com>
References: <48BADABE-4DFB-4DAD-8248-E94D8F5238D2@amazon.com>
 <CAAVpQUCfMsWBpPpywbwBLRCdHUqWqFBoDK=17dwDkG6T0dQxzw@mail.gmail.com>
 <A7A3F2FE-B18C-4F6D-A5E4-78164D6904F5@amazon.com>
 <CAAVpQUCKQQF=noqxQwD=dJvO3tuhPZxssDygyuVaZxTQGKiWfQ@mail.gmail.com>
In-Reply-To: <CAAVpQUCKQQF=noqxQwD=dJvO3tuhPZxssDygyuVaZxTQGKiWfQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels: MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SetDate=2026-05-15T20:49:24Z;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ContentBits=0;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Tag=50,
 3, 0,
 1;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Name=Confidential;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ActionId=3ff8e849-b227-403a-a82e-c3207b282958;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SiteId=5280104a-472d-4538-9ccf-1e1d0efe8b1b;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Method=Standard;
user-agent: Microsoft-MacOutlook/16.107.26030937
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB4728:EE_|IA2PR18MB5936:EE_
x-ms-office365-filtering-correlation-id: 95017c83-8d31-4d26-3b2e-08deb2c578fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700021|3023799003|4143699003|11063799003|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: wVDg5fPhEqEoCQ8DqX17ke22p907S/AFbPKCNYAweXZQLdopYLo6ao0FmZwBtJBO8ZinjvC7Eu+54WH7vsOJv4N6aGXRhr5Dw+LszfkrcxjG8iWcPocVohIl9UVr7p6jvWvtxPmC6Gyk8IoKQTUTiegyVBFEi3U43tiVzssI1e/n5W28ETdirQMDVk1qrxJxuXNccUxF0jOs7Vh4FQD1jXPKPUx6zsM4ywQNvUMoJFr2og04TxNqVVbGulHc/8GPJ3f4ssqer8JaGfWhxu0vfvhYX5b48nnuR2+W+ptSGGUVlFrLr9xNIaKKymkdNy39P9nVX982sQTwD9/dRZ9GyWuh+13zRaTze5v8UBHyjRshhusIdNULg/nfw5ca3+T1Iw4Vk4d6p2KVi8UW69/KC/5lryf+Pi/ljX48MSaHiw4KlSytuDm72G+opyf5O4ZPg+7IEDhbjZv2iEe56w5gNC9MXJz/EOny/eXIBm1EfNBTSbPZWIMtQWXMSlF6W2eBZyhWgEmgiIQJfuwOx/LMX/jtQVzJOCEPwWXZ3Mpv5ayGVHOxT97wieIrmRhACyfJyo4pMsH9IkzWx2u+SYO2ezLJj4hS9FSo+ylXcnQVOPyKeYwhkBCqcehsvksndAIIuNPULxlM8q2sIe0OTZzezHV9NbPY5bG50yaaVRv3hju1z58HvjXA07LxgxXpDQRKywWN158HO+ZVEx5cMov6fRVgFFMGHENzdD5uB//TPy8kkW7Ji9GpkTFxasJYpJtO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB4728.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700021)(3023799003)(4143699003)(11063799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFh0OE1UVjdTbXVENDVib05sNUJKWExSTHpCVUg3TGZjZHZsYk1HSWZuM1li?=
 =?utf-8?B?a2tGZzBYa3JNaVJwOHlqZlUrM01uSngxTCsxVE1kUjVOdXZ1OSt1RlRMZTFj?=
 =?utf-8?B?cnZPZUFCMmdqVzNTcnRwZEppSGkvSkdNQWhqTWJwQ25YK2M5VTQ2NkFwVlFk?=
 =?utf-8?B?aWY3R1lla2I1ZlNmeXZlK29ZeXZOYjRFbit0THE2T2pOd2dSU3lJRjY0U1FD?=
 =?utf-8?B?UVNzUjBSN1h0SVlYeG5sajcrWGZiemdKVjZyaXFYTlhQYzh6SUNoN01nTnVZ?=
 =?utf-8?B?b3dqMUQ2NzUvL2w4bUtBOGVkb0pQQ3FwRk5uMmtjREdPaE5MZ1M2T1ArOGxa?=
 =?utf-8?B?bFM2NkNaSi9JMVBEei9sdkx4U3hTem0wdVFVd2lLOWVLdmc0b295YWZWazM3?=
 =?utf-8?B?Z3QzWXdvTmdnYzM4TC9VbnMxKzVoTGk3UWNqV1d5Mm9abWlsVHQzTFJHdDJz?=
 =?utf-8?B?VUhSSTFuaEZpZnNoQzNPY0JNVjNub0dFRnJOaHdEcmxhTGlwSUZlcjdWWXBB?=
 =?utf-8?B?aXcxVTE4eHUvVG5RSVJVbjVVV2w1eEZUOStLZU5qSjlsd0xqYjFSbW9ncUZn?=
 =?utf-8?B?NXFRcHVoVnI1ZnN5d3h3LzNzU1pDV2UzaEVQQVFPc0JCakpRWG5DTEV6ZVdq?=
 =?utf-8?B?WUwvaGVETnJXVGFMT3dibEFzVUUxcXZsUkRoLytuRGVKdG9sTEhkaVYrLzhv?=
 =?utf-8?B?NGwwQytDbUtIUk5hRmRzVVBidFhJL0hOaThieFJzSE9NVU51TkRhbDdiR1NT?=
 =?utf-8?B?c1VLVXAwMUtPS1ppWFVQZHZnOE03S2E0aVBMc0dRaG40RnZRckpsTDVEait1?=
 =?utf-8?B?RCs1ZUdndElDVkVVa2FET0N1bVpHTmhCS0FQVFFpOGNDZHEvZXZlUGxuK045?=
 =?utf-8?B?Q3ZwcXgrc0MrSTJVYmhPZlV5Q1VzQWpINlAxaGFMVVNaMDJqbENUTDdQZzk0?=
 =?utf-8?B?MFM2NGpTVVR3RlZReVZFYU4zTGNmdS9BS3Uwd1J6dm9aL2wwT0F0YWtpR2Zi?=
 =?utf-8?B?MjJQdi9KbnlvVGFzMSt0RFovNHc2S3lyaDlydEp0WnRrTFZHZnd2VnlXbGJM?=
 =?utf-8?B?TGRiUVBiMjZhOHVzZWNycUNMb1FhV3VsZEo3SmMrUDlEbGFlODMrS2V5cU1O?=
 =?utf-8?B?SnBYeTdrZHJWemVVOTFiMlJxaWxsaGZhQ2lBZ2Q3T3A1Q2NEdlZWbHpSaHJw?=
 =?utf-8?B?REMzVjFVbGFuRWhWcFFQU0ptV3RMN1FWZmZYMVNaOG9JZHg5VmxyZ0ppN2Fm?=
 =?utf-8?B?YW5CcVB2azFVd2h3cnNENHRKVDM3WGtIMDM3SlQ2NUhnMXJvOHl0cHVtNUlX?=
 =?utf-8?B?aVU0aFBFalBESENMZmlIcG1hVlZjZXhXQmovalVOVERtL21vbHJxajBOTTZU?=
 =?utf-8?B?cVBlVDhjSmwxRDBKNmE4YUdUamIxQTNQQjQyZFpoeUxTeDloMjZlM3lpd0Fh?=
 =?utf-8?B?MGpmSlhuZWQ1djNhQ2FUdEFPdFhhU2J1TTdXSlZ0RVpjMk5PRU1VcFM1SlhB?=
 =?utf-8?B?Yjd0Z1NPQ3BsWmE0U3RzSWdYOHU1RisxOGhVQlN5YWNJaVY3M2JyaHJlams3?=
 =?utf-8?B?TmNKQ05ndFpuTEFmaGpVZ2t1aTc2ZkNuVjVKVzgwekYyMURPc2V0ZGlnd04v?=
 =?utf-8?B?SmlFa2pzN1dYQmhsd0hVVFRScTcvK2h6S1FXWTRwR1NyKzNObENUYUxMdmpI?=
 =?utf-8?B?a0JUdVE5elpBb0lTbnFNL0phZnBjUjkwZFVqbVZIalZOMFJIUFNXckNlL285?=
 =?utf-8?B?UDFLYzFUWjNGOXpsZUgxUUkvUU5hQlN4akREVm1sUDFJVXpJUVJOTis2STh1?=
 =?utf-8?B?dWU0U0tIa3hyeWZXN0psU2pWK29zeFE1N2tFTld0RGFQR1lZMmY0VmxhTHlO?=
 =?utf-8?B?RE9CZ3Bid3Fyb0VhdDJLejdNdDAwOWx2amc1bkxMNjFCNDdwZGpKQ3FBYlpJ?=
 =?utf-8?B?Sk9qWWJWNXBIbnB1ZVlVelVZSWp1M1ZyMFd2VXNyZEhRcEl1ODViMDd1SFg3?=
 =?utf-8?B?d1FoeWRhUWRrVlJzTHZtUXFJMm9JeVBlcERuK1VMSlVUOUVKRWxNSW12aStq?=
 =?utf-8?B?REJWVXpNZGJuR3RObDMwTVM3a3M4cE1ndVVuOHpDWW9FTkhHelRYZzFhYytF?=
 =?utf-8?B?WU1rSEdXNWlJUTdmUlFkcHQ5bHFLc0poNk5PRWN2ZklDbU5LRUdOMVJ6NlNz?=
 =?utf-8?B?bndWZnJLZ2E4KzI3MFFQNmM1Ui9hc0g0QzZRNjdFYXFGLy9yKzlpa0tFOUh6?=
 =?utf-8?B?dUtKaEVnYmhsYkRHd0V4VGJSZ3plbllaREF3aG5GajVjZ0JodWZTZzkybHhk?=
 =?utf-8?B?Z0E0Y0ZUTFNLN3pzWm1keEE4T3JqSnpwbGJCdVljTEZxVGpqUVE2eE5vZk5y?=
 =?utf-8?Q?XNo/+DSLiwlYTLrpIRF6w8hkaqSFbDYAouWAJJoFXtu/a?=
x-ms-exchange-antispam-messagedata-1: LhVbaZidLtFYjQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <8243B123F3184742A367A6A906D7B4F5@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YGhxZOw7m1yC5bP2rS6UybQXBxLsd38i/AUg+FN6p9jgB9op3OwS11ZE79ucmAM/K5O4ehHyK5rXU42pHVa7ICwhVm7H41/k+4LplOaujNIn99/JQ/w/KdIRr7OXE5kwpOSOqXcDReoIF1Wk/hwmheOkrrv+XOYysgFcseCDnyUl4npxsFVHc/RCEXlvCD0TECcCXT3UnfjX+6r1/DybMXqsC5wZBUMRIYO3lR9GbrCMkti9nwHSrEObhX/32V8IBrD3b/VbI0ftRzsNiF4ZA/N6PM71WtRNTXdal0kZXXd4ezAfnO4GBzONsjU6BBP+XM5GTQf1f6oUjiDHBBtKww==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB4728.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95017c83-8d31-4d26-3b2e-08deb2c578fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 21:03:54.0277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SLpw3jY6Gn8Sr2BOIXe31NEyZDkZZmQZEliXOrSgVic7yweRsGcHzwBl9yXzIPH9G+BiZi2nkkpfPoKSJsN78g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR18MB5936
X-OriginatorOrg: amazon.com
X-Rspamd-Queue-Id: A5FD95579F2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.06 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248920-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aarnahmd@amazon.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

T24gTW9uLCBBcHIgMjcsIDIwMjYgYXQgNToxNiBQTSBLdW5peXVraSBJd2FzaGltYSA8a3VuaXl1
QGdvb2dsZS5jb20+IHdyb3RlOg0KPg0KPiBJIHRlc3RlZCBpdCBvbiBib3RoIG5ldC1uZXh0Lmdp
dCBhbmQgdmFuaWxsYSB2Ni4xOC4yMCwNCj4gYnV0IEkgZGlkbid0IHNlZSBtdWNoIGRpZmZlcmVu
Y2UuDQo+DQo+IEknbSBub3Qgc3VyZSBpZiB5b3Ugc2F3IHRoZSByZXN1bHQgZnJvbSB0aGUgd3Jv
bmcgbmV0bnMuDQo+DQo+IEFuZCBpZiB5b3Ugc2VlIHRoZSBjb3VudGVycyBkcm9wIGNsb3NlIHRv
IDAgYWZ0ZXIga2lsbGluZw0KPiB0aGUgcHJvY2VzcywgdGhlICJsZWFrZWQiIGNvdW50ZXIgc2hv
dWxkIGJlIHRyYWNrZWQgcHJvcGVybHkNCj4gc29tZXdoZXJlIGVsc2UuDQoNClNvcnJ5IGZvciB0
aGUgZGVsYXkuIFRvIGNsYXJpZnksIGJhc2ljYWxseSB0aGUgb3V0cHV0IEkgc2F3IHdhcw0KY2F1
c2VkIGJ5IHJlYWRpbmcgL3Byb2MvbmV0L3NvY2tzdGF0IGZyb20gdGhlIHdyb25nIG5hbWVzcGFj
ZT8gSXQNCnNlZW1zIGxpa2UgdGhlcmUncyBhbiBpc3N1ZSB3aXRoIHRoZSBzaW1wbGlmaWVkIHJl
cHJvZHVjZXIgSSB3YXMNCnVzaW5nIHNvIEkndmUgdXBsb2FkZWQgdGhlIG9yaWdpbmFsIHJlcHJv
ZHVjZXIgdG8NCmh0dHBzOi8vZ2l0aHViLmNvbS9hYWhtZWQ3MS90Y3AtbGluZ2VyLW1lbWxlYWst
cmVwcm9kdWNlci4gSXQgbmVlZHMNCnR3byBzZXBhcmF0ZSBtYWNoaW5lcyAodGhlIGRldGFpbHMg
YXJlIGluIHRoZSBSRUFETUUpLiBUaGUgbWFpbg0KdGhpbmcgaXMgdGhlIGNsaWVudCBoYXMgYSBz
bWFsbCByZWNlaXZlIGJ1ZmZlciBzbyB0aGUgc2VydmVyJ3MNCndyaXRlIGJ1ZmZlcnMgZmlsbCB1
cCBmYXN0LCB3aGljaCB0cmlnZ2VycyB0aGUgUlNULWNsb3NlIHBhdGggd2l0aA0KU09fTElOR0VS
KDApLiBUQ1AgbWVtb3J5IGdyb3dzIHBhc3QgdGNwX21lbSBsaW1pdHMgYW5kIGhpdHMgdGhlDQpP
T00ga2lsbGVyLg0KDQpPdXRwdXQgZm9yIG1lIGxvb2tlZCBsaWtlOg0KDQogIE1lbTogOTQ1MDUg
dG90YWwsIDE4NTIxIHVzZWQsIDc1NjU0IGZyZWUNCiAgVENQOiBpbnVzZSAzNDc3OSBvcnBoYW4g
MCB0dyAwIGFsbG9jIDM0NzgwIG1lbSAxMTQ2MDA5DQoNCkFmdGVyIGEgZmV3IG1pbnV0ZXM6DQoN
CiAgTWVtOiA5NDUwNSB0b3RhbCwgMzU4NTUgdXNlZCwgNTgzMjEgZnJlZQ0KICBUQ1A6IGludXNl
IDMwODE1IG9ycGhhbiAwIHR3IDMgYWxsb2MgMzA4MTYgbWVtIDE0Mjk4OTgNCg0KDQpXb3VsZCB5
b3UgYmUgYWJsZSB0byB0cnkgdGhpcyByZXByb2R1Y2VyPw0KDQpUaGFua3MsDQpBYXJvbg0KDQo=

