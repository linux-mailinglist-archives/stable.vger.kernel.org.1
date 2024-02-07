Return-Path: <stable+bounces-19030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4678284C2D7
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 03:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A78DFB2BF04
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 02:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9481BF4E2;
	Wed,  7 Feb 2024 02:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KBpcoz0+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JBU7b+tN"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7F51CD35;
	Wed,  7 Feb 2024 02:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707274659; cv=fail; b=f83v0bCZvEEr9gnpKGjXvdZB6WED2jz261zjXaazl1LGbtGgl6wrEYHdR3rv8MCDN+aNBMWgbuCnZ5RVqDabLpv5Ti7XI5ub2Eu4wwajJ2EUwr5oIFzkkm8YzFyxYcCSjAkKw6nli1SlKZee0Ih6+ThPqF+7JM/XlL10oJt2dyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707274659; c=relaxed/simple;
	bh=y9uQKYDfX6J/1YT8urGqEiJBIF/5GO096+Ig4htpNEs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=luGBtUiDH0QQtsIEr63oZyUiPSrwMbkMdlvvLk5AW87hhnNkUom+BLjbObssxQUqmCd+xm0ZxT93SHQpyx81cfPduy3Ap2n4L1NjTbtN/JulwAejlzd4cpLcZEwpxUidPmxT+KxHz2ZIIG8l7GV/EHHuMUS46wlPfbmX1ISPhT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KBpcoz0+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JBU7b+tN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 416N48QY015119;
	Wed, 7 Feb 2024 02:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=9DZVw4KNadMdjp6qUT9E4LM2Ui9AGPZ7UZEWbNkyeDQ=;
 b=KBpcoz0+7IbsEW7c2Yp6mBKpVuq94DtPAhTdY3cMcCdP6uwAeRci3ag7lIlHy2o8baXX
 Ht3QE7ea7qYVRd8Dc7KwYXT9lWP17bp+5i8IBhVT9nDfi1atl6VR1orORszMBW9keG9j
 MUFf9vUgKyDYuzf2FtaJBqvCGOApqBqxbFJ78qjFONw54LeKueLHQZeH7uGqs4jarEHn
 jrtpytkdm9Cg5gFlgiGu86i0niIDMCbW3HddRauylSRT0N634ZkeKVwmAabj9w5mLRsc
 rAhaeGXDKv2ozr9IIHa4Olvg3c4uSLZQBKlEWbjgBCeLuKuNV22IordQ+r+1eSyNuP05 Sw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1bwerem0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 02:57:16 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4172kdx4007121;
	Wed, 7 Feb 2024 02:57:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx8k965-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 02:57:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRGCeP9jsm2FPd11lpJHsJHkUn9diGhkSwz5rEynvLr+4npO1gdDdUS2oVpQC/x4ap6ODtrAGsyZOZuDaXJSF7Mmyeb7q73tPIXGeTUV7tzGEKNhNq0UiYmTNVKVKtMV5VhvqNjeEJtIhvlzBTlhJFWXX/fNE+k4aXTVq7AYfVFMU69d01GFqSpWIw7X++CUd/KhmNTI6SOOE3qVgHAHRXn3ZGb3eohuszQ8v6luFffnByG13kLEletS7yVm1PeUSkgrPt5w6MbkLzkLUZvcvQbFn2+CBhPd0mObGe4XERQ0fp6gz/iJxc9cyocYbxhN78vKw9C5jKwIuOWOgvHGwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DZVw4KNadMdjp6qUT9E4LM2Ui9AGPZ7UZEWbNkyeDQ=;
 b=cBNqio1K/gPN1jndPBp1z2LEUvHuY9cG8j7YSK55JYsmhRHE9OyYl28BHBDHhKvu2qzM/m+U37SQ15hhOGXKJMmsgU0mNV+37J537a+VkfS+gQsG2WRLmb+y15H5Qd9XJqHm9dUKpe9LGdHrzaC3c73P3u8lM+0Go/nWYQUiO+x7OPsNgfI8GIgqPWccnV1JYH3qefT9cby7xOp7wNycmZPOYPN+euSUycAlIfGbY0c7wUo7ZIRb4Q3AmNQLr/aIRVERydknjADnYahToi43za7vsiytKaASdj62q15Sy1YJvP+ixx2mvnMSd2D2TSiEbJJ/jWuDOaJQRh7GeQeNCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DZVw4KNadMdjp6qUT9E4LM2Ui9AGPZ7UZEWbNkyeDQ=;
 b=JBU7b+tNMD6czxb2qlQxSP/CAZFcMNRysNhWIc0+1gP7wo5yUoy3ORKYmY9jJMqnHvXMEsuxqCrpJAJKFcmeUdt7NsuSDTtDypIEOayZolNdsgi2apRR1C3ydoIS3hjHpRuB5qUB+U4S667mNkL7Zlj3KDzgOUaeOPA3GaveWGo=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by PH0PR10MB5796.namprd10.prod.outlook.com (2603:10b6:510:da::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 02:57:13 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::2e34:ae4e:d7db:ab33]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::2e34:ae4e:d7db:ab33%4]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 02:57:13 +0000
Message-ID: <bb4493e2-91bb-4238-ab77-b38b16cd2a57@oracle.com>
Date: Wed, 7 Feb 2024 03:57:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] docs: kernel_feat.py: fix build error for missing
 files
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>, linux-doc@vger.kernel.org,
        Justin Forbes <jforbes@fedoraproject.org>,
        Salvatore Bonaccorso <carnil@debian.org>, stable@vger.kernel.org
References: <20240205175133.774271-1-vegard.nossum@oracle.com>
 <20240205175133.774271-2-vegard.nossum@oracle.com>
 <8734u5p5le.fsf@meer.lwn.net>
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <8734u5p5le.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P195CA0019.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::24) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|PH0PR10MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: b920a926-c0c5-4188-ed34-08dc27887c6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2sSJLr1ILoOpGy/+qpvmc3JdWDtZ5iA5qqYH30tbdKIY8KZj4OMpYPJiTa2sxRq9RWR7/7XARISUxgo/lMurIOJgoihaJJnq388rZubQla/gVPszbcrSv7CJ/f/chsaZdbmftL+Eb6iFWGatTq/S7L9wWxcFtRUWQOI2jo0zAl3fDgr6WAbrfYR9RnuNGvBTMvKXri8CNgFxTn8WZjfmzpD1Nuh9O9DxwlHmq6kkzV+t8x5fEV7cPakuwnFyZ6rlnE00ChVWu2cpdMbPM6a2difxXFG8wIQBqADld+tkBR/SpDcfIVsvhYxo5iAPL+nGwQYOm+GAHHDm4xwBkgCQlWODSSe3QTLpNfStC1j2VOhyfDOsTm8WncytkFy2BP5SWE5x+ImjvdLDcUdcOHVFVt+ZbhWnNx+0ZSou1tkh/N/lXa3j5Sx4mpGHkP97T8eKnBWwedQ1C0g+P9PNhjVjUjs8qwHhOx0QyG6WoLt9mZw3DGQoNM+HanFalgppJNqSnM92PCQEy4k/89X5AJZha3qYQHM38R5LJz86nBFzqeNtuaeiueG+xMp9Vqul+T8a/kaTGGICrBdWVNT0atCi+TcQBXOlxeX6KLJEw/mY2Z7jp5vuNX8r0tjbxDWD4OrAGdllYYtGvGoAfRGGrvuLQg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(31686004)(38100700002)(53546011)(6506007)(6666004)(316002)(86362001)(26005)(31696002)(41300700001)(2616005)(8936002)(4326008)(6512007)(36756003)(8676002)(2906002)(6486002)(478600001)(5660300002)(6916009)(66476007)(54906003)(66946007)(66556008)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SUtKMFM0eTdNaFJINWFvNHVxSk8xZzMzMENhK2Y0RjFHaTdWc083VHcwWC9D?=
 =?utf-8?B?NTE3amxqVDR0UzFocDcvNFFJUWVIck51VHNVRG1Ja2xrdHJUNjhKYytzY2Ft?=
 =?utf-8?B?eXIybXNRYm8ydGVOYmRyelFiajNHSWxpK3p1ZVhqYnQxREtOTkJ5WDBwbUsz?=
 =?utf-8?B?N2JFL3Nkekxta1RPL2V5OVJkcGZHVEdDZExCeTQveWU3L1RJZWFyZlBCVCtr?=
 =?utf-8?B?RXA0N1hhSmZCZUxUYXp3MENGRlV4OEtuUERjZGpwdXQza0xiTUZRRkJ6Sy9l?=
 =?utf-8?B?anJZb2x2d2NERW11OHRVWUlORHJUVk9MUG00MmpVd0FEYmNEWkdnZUV2UnVW?=
 =?utf-8?B?NGhKYllkNUlUdWpvYU40dWNkc1dmWmRVeXpGVDVFNnBSaEdEZUpHa1RzbEc0?=
 =?utf-8?B?WFFhSTlGekg2dzlJMGFtS3o1TEM1UVI4UWFaZXZhMFV3bjJNdzAzR3RQTEs2?=
 =?utf-8?B?Y2RvT2ZjNU50MmRLL295TkZnaGxtTG9kT1lrUW1SZVoyUGFIV0UzTU1ZdWhU?=
 =?utf-8?B?cE9FYmJsT1hRYW0vbE9URnRPaHg2WEp3NHR0aU9sYUloYThPRGlmZmZaTVZp?=
 =?utf-8?B?bzkxRzZQRDZUT0pFMFg1eTRWTnNDMGo1VFdoQmNsMXdkcFVWcU5hdmJNK2ZE?=
 =?utf-8?B?QnVLeTQzLzhkbWpkK3IydzVEUkM5anloMUFTbDNJMWZpZUJyYjN2dnhhNGVQ?=
 =?utf-8?B?eTJvQmxZZ0lSWW12aHJTUU8yL0pHRmJ6SVNsNUh4N1ZwVTNZT0FTZVBOSVRH?=
 =?utf-8?B?dVFRcC9VWmhmYU9NTE90eGxxZ0tQVDRHbTNIUTFkOUUrSGVIZ0VQVjJqdzV5?=
 =?utf-8?B?MHFHL2J6Q0ZVMDExazh0L2FqU3R6RGZMNVp3c1llTENMTzZ2ZXpudGZkTklO?=
 =?utf-8?B?c2tlV3Y3SmRUS29rY2ZmdTN2STE3UDUwUmw0czUwUDc4dzNCeUFhcWZYVGt3?=
 =?utf-8?B?STkrTjh6VThEY3dvYXk1aVYxWVdHakNOZll3c0R6V2hvTUpFTUtER0FJQnVR?=
 =?utf-8?B?WVBGbFRONGVVdFlsQXQ5MmI0eXAxMzVXNC9FMkNUWGNONGxvcjNqQStieEJ1?=
 =?utf-8?B?eWpzZ01NWDhlQzB4WEMwcVMrRkl6NFh5R0k2cDk3Sy9MQlhKb1N0cTRSTEJ4?=
 =?utf-8?B?bkU2MFh1UERsYksvWFJ2ZVBnazNQZVVwUFcwdlVCQ0ZRZVBDV2REdER4ZTVx?=
 =?utf-8?B?L1E4d3hrbWtEa05jRnovdkMxNHdMNGtXclVXcExpUENSTFBZT2x6Zzc2YnI1?=
 =?utf-8?B?N0p4ZUtTUmRnV3ZzWUNVNFRweW9jd2g0bjhkVVpSTDBMbHRmeTJHSHJrUzhx?=
 =?utf-8?B?STdrVC9yYWs3bE1SeXQyVWRLQndOd0E5NWNiTmg0YWVjNmFKU3k1Tm9IdDI2?=
 =?utf-8?B?Zk01bWVIdmRvZ2szYXdEcnpJSEl1b0tXZEtPMEdQUnJrMjJZb2FJdGJsUFRP?=
 =?utf-8?B?ZFFMZ2hTZWc3dHFLUnJoSkt1ODU2WVZwSVoxUlkzWTU2SkhXNHZSL2U1NEk4?=
 =?utf-8?B?aEZsa2s2clpzWDV1SksvWFE4K09tN2JBRXVRVTI2QnJTS0pqaHo5VEcwekQ4?=
 =?utf-8?B?VHI1WlFjRm5wamZnZUhsU1VVdjFsTUhMRFkxaERTcWd6aUVHWCtpYzJDTG9K?=
 =?utf-8?B?MXFIaFJxL0o3aU8waXp1bUZhTmtiM1kra0NEVGxoSWpRYU9rVXQ2aTBRSVFm?=
 =?utf-8?B?WjFYZi85YkpiWjhaZjZJcmNpbzBxT2xEQ2NlQ0xaUFV4Z0Jkd2lOcExBZW5Z?=
 =?utf-8?B?OVFIbjdHOVNGN3QyWDg1aDc5UEY1RWZLVEVILys3OC9BNktCSWJrM1BYOG9x?=
 =?utf-8?B?cjFYSjdpRzJLQjR2VFBMSHd0eUZFSzVIQSs2R0pWU2NZeWF5VVg5SUkwQVB2?=
 =?utf-8?B?Y1I1cXpxN1hldTBFQ0VkTlRhc1FqVUE4ZUxYQi9KYnFmU3hxNjJORDYvbC9s?=
 =?utf-8?B?WitKbEdHQkhCa2VQU2lsN044QVZiaGpwcExlUjZFaTJUbno1ZDRETEZ0Z2dK?=
 =?utf-8?B?LzhHUUpaQmZ5MUpmY0MyRTdlVzNKL05MOUVCaVAvQ3E3ejBjeHkxcVZDdlFU?=
 =?utf-8?B?S082cXNCVVo5d09hYzhkZGoybW1tdlBwVHEzYlhiUC9sSDJPbXBHSDJTR3k3?=
 =?utf-8?B?dGhOdHlSbGxhNG9RbjR0ZUtYMXlLbjNzNlpUOVJGNXR5UzY4MjExMlF3Q01R?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	d+aISu26Ysp4/hiwR1K/+INWy3oV4m/9baemvtOV2+kISpp629u1ofueh7SG5yntxRot3bn2BvNsxRweueCpTFRH7WYJLUvc2Ol1hLpbIttBuhdYVp0QZwWWxG5Fq8rkm7NIreH7btlgmyuJ5alFXR0m6c0504rPAicOEgiEhM+uc3M7QZOq7bT+iZChsoJ9XMlTlNMiHy0HGebJlhfbA7ZJ4FKEGfj44PJlF9Bb1kxqEp5A+G0dOvB7DshmLjludFmd3qVhF+mNJHA7lkl12VUUAZheNakcfuVq6QJ7ifjfkPwhLH8LpBLg/hr2fQfMc9IlE322RB/dM4kyaWWbAEn6Wrk+iyszBf381rkHRw+/anG274fd+uLzJjbd7YOvAOgHPLDONpmvePFbi6g7sEk5LL5UgOCyEuQiSLkVj2bhfoDTWGnjMafBR8lypSGlPvpI6fNKVA0rya0fspotzssIbt/wBjLQdP5gXDobO7NRjY/meX5XoJ2NJbtGVOsuF+aal0hhruyWx/rPW3AwatH2Lqy9SuKiTBmK1tR1Vo7c8xQBGOXsGWydr610JIuXPpeTLoLKqQF1/sgpL4jsWyVIOz137cb3ehoXry1BCU4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b920a926-c0c5-4188-ed34-08dc27887c6e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 02:57:13.7590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N57ugzRbv2Yxq4yi8TqF7WgBgh/VQPxvp4t8RsyMunocJMOB8Ay/7IqXn63dENifbyrWwodO4OO4R4lLaweBkXKOiTBTBx6/tZE5Y3T3Srw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5796
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_16,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402070022
X-Proofpoint-ORIG-GUID: pvMsbk-M33RhTlIEtLrbc2RIZTFu2T20
X-Proofpoint-GUID: pvMsbk-M33RhTlIEtLrbc2RIZTFu2T20


On 06/02/2024 23:53, Jonathan Corbet wrote:
> Vegard Nossum <vegard.nossum@oracle.com> writes:
>> @@ -109,7 +109,7 @@ class KernelFeat(Directive):
>>               else:
>>                   out_lines += line + "\n"
>>   
>> -        nodeList = self.nestedParse(out_lines, fname)
>> +        nodeList = self.nestedParse(out_lines, self.arguments[0])
>>           return nodeList
> 
> So I can certainly track this through to 6.8, but I feel like I'm
> missing something:
> 
>   - If we have never seen a ".. FILE" line, then (as the changelog notes)
>     no files were found to extract feature information from.  In that
>     case, why make the self.nestedParse() call at all?  Why not just
>     return rather than making a useless call with a random name?
> 
> What am I overlooking?

Even if we skip the call in the error/empty case, we still need to pass
a sensible value here in the other cases -- this value is the file that
will be attributed by Sphinx if there is e.g. a reST syntax error in any
of the feature files. 'fname' here is basically the last file that
happened to be read by get_feat.pl, which is more misleading than
self.arguments[0] IMHO.

So basically: Yes, we could skip the call entirely, but we'd still want
to make the above change as well; skipping it doesn't change that.

Maybe we should just change it to doc.current_source directly -- my
rationale for splitting it up into two patches was that we would have
one patch bringing it sort of back to where we were before (having it at
least not error out and still be the obvious/minimal fix that can get
backported to stable) and then a patch actually improving on that (the
next patch in the series).

Does that make sense?


Vegard

