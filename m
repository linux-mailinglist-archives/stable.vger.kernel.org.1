Return-Path: <stable+bounces-100621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D09F09ECE7A
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 15:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D67AC16A44C
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 14:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC8338DE9;
	Wed, 11 Dec 2024 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b="ZfNKvwa6"
X-Original-To: stable@vger.kernel.org
Received: from outbound-ip24a.ess.barracuda.com (outbound-ip24a.ess.barracuda.com [209.222.82.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD8C246322;
	Wed, 11 Dec 2024 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.206
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733926965; cv=fail; b=WJnlvNPrtOHXiPWCXg2WcoleQXltSuRd0xLdrbvXA7zx+3fanQc8K4eDX8kBknFI6wDL8gbRFJ5e7/IwqR6dVIiVcobqSQuCZ55EFKtJK0oUUyMBmNvIfaGwaeACQf3TtT5b84wCRUwq9jLOoDtv6XWkqN2nuY1yzKYqIRnwRsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733926965; c=relaxed/simple;
	bh=8v7VBtUoH5cEELxwX/PFSKy462E7TrrjoKRQkahKWv0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lXD95GYX/1euVoYiYVUIfFTac2pVuVuJxv/8/O0lgSpK5DYdkg/GrSTCrqLPgGVewSVzEq9jZ7xiqk5/5vWbLi+wzmwWWfm6E8Q2VNldo9ovBbMbNx20NUPC0Jf+REBXvXcxfR6WJEvCZlfWbJHoKB9EpBLw73ncJqhOzPhL6Gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b=ZfNKvwa6; arc=fail smtp.client-ip=209.222.82.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47]) by mx-outbound14-65.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 11 Dec 2024 14:22:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzG2Xeku+URuyPVXaRFKQAyADUG5Vkq2fjPfEcwsMyGJaT0KeCTJIqxwhkPgTGiGoFfBoilmBQThmTjb89OLIVR3tp7VPcm5LI60jBy4GayPGWVThsavwqr20xjhGnYX8hqa6oTDNCMLaStoMHIY4wjGvZ47YimSeYuL+XtzgfaeOXMaUjGz64WyURnqGkjJfia4k+29WZo72iU5MK1zQDUvqS9cCzShBw/bP9ajWlFAAz7ATcQ63SqK5mpOBJIolSEFfjRduzVjyqgFjbyLMyRN8e808Cum4JvFsSkdY+RNhR1Zw7OJh1SUyewCAGJkl+5249ymkdqoC2ZimzmQsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFd4DPtO3AHP3lrKxL4feGZM+KKgNqzQwsceolPhtU8=;
 b=TECT4o9cQmVoGRkdf2UCj6Kw8Wrom2I9lG40Xufz2W5OOfMZZ9sfchORkj58jDnsM4XMyvKobBMNks1i0N31BWfb6+nv61ej1LBTcYgsK2lgQeGNA67Eoc+2sr3DrxcoPJK26AhhnSbdGrcw1+ulQumP+2b0QQektZeChN1n6gT6yZTcjnrM6i21v515neyaHrCvewWwcxBF2IyATPsbp96eyi6uVKXRQnZTa8tYaXeow0dCF3xt5dxMPDB7U3h/QZR+oGUHCVirgha/9sw8wgdXKhaORi/YLF8QQ0t3T/FVTpvfDqMeWFr8TlZR4s9ILTlhYZgxvn6QIibtPySArg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFd4DPtO3AHP3lrKxL4feGZM+KKgNqzQwsceolPhtU8=;
 b=ZfNKvwa6viGjsLJYjUnL1e4SE0r/avFO0qMQcow5PrfCraePrkCUv0LWmcU2YLxs2I77VtubkMRb5F15w/h+Sezp+jysF/hbSLWXo7gmYo84/QWsk49pVTkoIJGhaL1oV0vGl88FJ9Cql2SiZymS1AXU3ADi8Wph8IEradQPAW/ZV47vnUji+t0Ma1JAS/TMSIdH38rk28YEWf1vJ8snMQndxTiRHUQxEMW6yop/Gyuv7sW10RuDxZqUwTTJb3v27Vg5voLbCwnwqtEKu848gnvKhAwWUZR9ykVz3vFNbRCKdzuQ1A0WRuIUv20GuGOveqqArIVHCMzQKoNV2IFc6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15)
 by CH0PR10MB4905.namprd10.prod.outlook.com (2603:10b6:610:ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 14:21:58 +0000
Received: from CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::ecc0:e020:de02:c448]) by CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::ecc0:e020:de02:c448%4]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 14:21:58 +0000
Message-ID: <7eafe960-d172-4079-a91e-85e1066c2764@digi.com>
Date: Wed, 11 Dec 2024 15:21:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: tag_ocelot_8021q: fix broken reception
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, vladimir.oltean@nxp.com, claudiu.manoil@nxp.com,
 alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241211124657.1357330-1-robert.hodaszi@digi.com>
 <fe505333-7579-4470-852d-6fddd20197ab@lunn.ch>
Content-Language: en-US
From: Robert Hodaszi <robert.hodaszi@digi.com>
In-Reply-To: <fe505333-7579-4470-852d-6fddd20197ab@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0110.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::7) To CO1PR10MB4561.namprd10.prod.outlook.com
 (2603:10b6:303:9d::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4561:EE_|CH0PR10MB4905:EE_
X-MS-Office365-Filtering-Correlation-Id: 43f83d32-692c-46e7-7a25-08dd19ef2bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVRlckZzVWhHVXJuK3ZTZnNLRFhnZHVGemVQaXpVSldsVmZNa2dJSVlWWDZo?=
 =?utf-8?B?NDF2d2dUU0M0eTJzUmNQejZJaVFqK2hLRzJ6K1l4RWZrcStrRWFEaW5ubDlZ?=
 =?utf-8?B?VnorTFJVak9lUWI1TWVzN2dxYy9naTlya0daQkUySG5GUzlmbHBrWld6bkFj?=
 =?utf-8?B?Uityb3ZrczQycnJ3c1krWHIyOS8ya25aV1Q4L3R5c0pLY040MnZjZE5IOXZF?=
 =?utf-8?B?ZXU0dzc4MzJzRk55SldLZml5TDZqV05PTGhHYU1GMFlBRjR6YTY5M29icmZn?=
 =?utf-8?B?OGYvYjU5TWt0ZzY5OUV5ODJaNkhkYzg1NDg3UDFoR0RxSkRyN2t6RU9KZ3dM?=
 =?utf-8?B?VVJmOUFwelNxd3ZSV1RzK0JwR1pmNzRnOVBseWFTTlJyQ0Q0TTRRL2N0VmxM?=
 =?utf-8?B?TW5zT29QdGRabVBIZk5SL1M0WStxZ0FvWWZBeWpzalh6ek5BSktyOHFFbDE0?=
 =?utf-8?B?a2lDNC9mZGIvOWNMYzVXZlBCdmpsM3hqdUhzOXF2UDVGdi84QmswVmliUnNH?=
 =?utf-8?B?U1lUWms4MUxUTlF6dHI4cFZhNkJWTko0d2hZd3k3Q0c5c1lPenQ3Z0gzb2RP?=
 =?utf-8?B?QzZTUUh4czBSYTNoWkNJTlhPamc1MkJzNDJVM0w1R1Uyc1FFOXYzSk9kTkxX?=
 =?utf-8?B?NGFLUjA1Skk3UnJGRHFBT3ZSbmEybWlvUzI1STQ3NjBPUlNacVoyY2RWSzZF?=
 =?utf-8?B?ZTJYWWxkQjl3R0tzUyt6MXhYd0FUMnlOcDhWUGlsaVR1SVhTU0NmV0thdjZC?=
 =?utf-8?B?b2Y4My9TQW9tRWJJSnFtZkFGS0VLZGdIQmM4MDJ0cUNySm9YVXdFclF2YUE2?=
 =?utf-8?B?eVRBK3R3T1dER2VmTnprMXIvZGM5YW9nc29ZdEdpeThlY1p2M3p2THEwVEto?=
 =?utf-8?B?a3NSNXljM2w5TGFGWkFVeHVML1lZK2FuSjJ5aHdZNnAyNWhDeklnTk1kay8x?=
 =?utf-8?B?b3N0R2NmbjU1bXgzRFlFNWo3MDFsS2tubC92aHB5ZVdRbkQ0TVdKMWtUajVS?=
 =?utf-8?B?MlV3TGxjbnZkY2s4Qllad3d4ZVRPUnl5VW8rbS93Y1hnbzdmU1V3cW9Mdi9J?=
 =?utf-8?B?N3ptUkdPZTFBbGFMVnZIcmU3V1Y5SnUrbHJrTTNSSGM4dEt1UUhyT1JXZkdF?=
 =?utf-8?B?b3o2bDVUU3JoVEIxSVZ3RFFMVVpTZi9BTGNmWmZ2K3FPRGlEYWdaYllIUUJZ?=
 =?utf-8?B?R1BvVDZiZzl2MWhoN0tqYm5qZ3dZSFB3MFpzcXRhMDRjWkhZK3c1Uk5mekph?=
 =?utf-8?B?RWVzemFIWTVZS1FHemFNN290SmNlcnZKQzhvKytTT1RyU1d2d1plNE1tOGFN?=
 =?utf-8?B?T1ZEQ3hwWTNKOXRoUEVianV4a3o4UTR3eWlabVcvckxwS3ZXUHkzYS9jUDBY?=
 =?utf-8?B?N1hydjFpL2hDRzBMb2dtZzdrclY3blBrVndvMmpDRzRKaXM3dVFZVVhpeXda?=
 =?utf-8?B?M091elU2UTN5Y3dLd3NXUFVuNWhBRkQxMS9tZENQeFlyWWFPMDBQUUkzQlJ6?=
 =?utf-8?B?WjVKaktsYjJvdFRKYkMyZkM5R1l4RlluYzRjVy83c1I0MyswOVRNMzJ4eGov?=
 =?utf-8?B?Uzg0WlBjZjEwSVd3MHZaN1BUS3JueXpjUHZBV2JUMWhZYTdzZ1F6UE9YdnAv?=
 =?utf-8?B?ZlF4dW5XbVVMc3NZb092MjAyQkVLMjN1b1h4RnNEdzdDYkdXOSt0R0poaHox?=
 =?utf-8?B?TjNKUkIwM1JtN2M1aTFWbFM3MUFZeWNIUmVRY1M4T3Z4eUNFdTVFL0o3amtr?=
 =?utf-8?B?YmtDcW5VVnBWZnp1T1pVZXd2QzFYNE5SbUErSGcwanNaRitmL043T3NlcmJ1?=
 =?utf-8?B?WnFseklhVFBUSTN1VVpxZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4561.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjA4QkN4dWRQZXFJWVNrMXBEKzhWeGtNNWgwa1hSRE05SFBvTndOOWtkVVR0?=
 =?utf-8?B?cExjbTQ4Mm1DZERRaTBhM2EwY1VOWUo4VVhCZk1QcmxIRHFRaitzZjdnay9p?=
 =?utf-8?B?bEtUMXBzQ1NnMzFrQ0pYYmdyMjhweVZ1Y2xCNFQ5Q2o0LzhTSllkcFpMQ1dz?=
 =?utf-8?B?SExWQU5RWVVrd0wxV0dyMjBFUWJpUlFPVWZQWTZINkZFOXNLa2JFQVNmWDRJ?=
 =?utf-8?B?SVZmS2FCM1VidHM1Wi9HZnRqQWcydkRkeG9MU1ZDSGpRejB5MlZPMG1xQUtC?=
 =?utf-8?B?MXN0bWFpenlzMkZvdGxvNWI3SHJnYUtZVitxaEJ6NXh1N04rb3lBVVh2S3JW?=
 =?utf-8?B?cGhEZjhHRlVkN081NUtDd000OXZlQlRBWDlhSU5mSlJvRStiVFpRUmtmcEhU?=
 =?utf-8?B?TDVNemMyWjhKK3RheGs3M1hOaTNVS0JlSjlkRExmb3oydGpVV0NHQlE5cDRr?=
 =?utf-8?B?U0N2VWFJUjgxOUtsZGFSUWJ5aEhoTEk0VTlCS1krMUZDaTlNWE95QURYOU1E?=
 =?utf-8?B?M1pMZ29yUzZONDg4MGhTdGRBOUFOUVhKd0s4aVludjU4Y1orT0c0SmlsV3JI?=
 =?utf-8?B?TUFheHhTazUzYUtFNWNrUGFUcEtzbVYwbml4Y1doWHczSTNnRHZ0YlhlRE5M?=
 =?utf-8?B?b3g2ZFliZ1MrZldwWjNuWFpWRDVQWlZaZW1La0kxdllnZHdaeGhZUkcwYUl1?=
 =?utf-8?B?cnNYMk9tOVpob1BaN2Z1S09OV1ByN2Fqd3ZISTdWZ0dVSnR2V25OQi9KNzd3?=
 =?utf-8?B?cmxpV0xqei9SUkluRHpTcWN2Snd3Q2w1NGRRbUJKYXA0U2Q2SlhBZWJ4NXZD?=
 =?utf-8?B?OWJ1YldxYkRhdU9wMUV2MVBUd090YzloUVU3TEh4R1U1TlAzS0lSQkxoOUs1?=
 =?utf-8?B?Qm55aU5qSWkvNFhtYjhlUzlFTHVWZC9zUy91ay9IS1dLZVFHdkRhdHpxUE1k?=
 =?utf-8?B?UzlRMWZKZHVQaWdiZWd2WjF6UkpJSUhmc3RCNWp5bUlwZTIxSkpwYUtkMnM5?=
 =?utf-8?B?MlFwZUhJc2NJWUZaaWR6MmRaM2g4ekpxTlZqai9iQmY5RFJ4dDQvMzlMSHJV?=
 =?utf-8?B?SU1wNDI2QnBzd3drTWtFcWpRYklkNnpHNzdVOXpmMUtYdzJ3d3h2bEpFZkRk?=
 =?utf-8?B?M0ZYV3d1aTlLbTB5RUpkVzNUSldpdjZObk0wd0xxMFRlQWtZN1U5QjJtM3Jt?=
 =?utf-8?B?VVF5emlHYVBUblNlZVVKY3FBK0ZGUk1lVUJNOEF5L1hXN0c3RGRESU5ZUzNm?=
 =?utf-8?B?YlBPUHduUThEUisrd3k0cGdzaERjL2IzdkJ6SWlneXM2cEdoQzdKSEFLTTRQ?=
 =?utf-8?B?Q2JuTjJjeDBtK3c5Zk1mL0IyN1BEckJuVGdWb0dYZTROUlovb3JxL0o4L1BE?=
 =?utf-8?B?TlBpa09pWjlXTTZ2TldrSnZ6QUZsQjdyRlJRdDVDcmtLWjUzeW9Kck9LWWt3?=
 =?utf-8?B?dEhySDlWUGdPN3J6M1VoVFpuYzFTd2FUaVd6ZVJaOVZ4bEMyS3duQzdlaGpR?=
 =?utf-8?B?amlxcWtLcVp0cm1VREs5Zmg2Q0VsK3lGaG9kaXdyK0pHSFBBZTBIMGF4cXgz?=
 =?utf-8?B?SldYQkZmNFNZeE9qYzRjK3JQTk1JY011dmF6NnJWRmhwRGh5YkxybzQ3ODAv?=
 =?utf-8?B?MVZCdEF1REswYVBaVXFVdkVLNGZ3aVF0dktxZFV1aHdnTUp5L25MWnZaVTZY?=
 =?utf-8?B?V3lEeXJ5SUszMG8vRW4weElQdWZtRDN6cnFuZFhxUjdFYkxTM0tqR1ZQUldq?=
 =?utf-8?B?MndGODBzSkxOcWJsWXRRSDJqSklUeVFkSnd0akJJd3lxVTlQL2lRRVBxNzM1?=
 =?utf-8?B?eFd1Tjl4TmxnRXVmTzk1aWZxNTZUUzBsZXJSMUQrcmU2NHM4VHdxME8rSDRP?=
 =?utf-8?B?bVNQUjFWdTE4YjVNZVRZZm1BNHozRFhRcTlVSnM1SmZ4eHRlNUxadUhmbWpy?=
 =?utf-8?B?Qit3d1pzT3NoUGFMTFdHZzRFcHB0NUxxTytSbFlMSlR6VFFQbWZGZWF2SXdL?=
 =?utf-8?B?enNpOFl2dWFsejJTMXNSUnJGSnNkNWVGNlJPZEIxUW0vdlZWVDNIeUpaQWJ3?=
 =?utf-8?B?eHlHM0pRdlRBRndtYktoMlJkQTRlNWVhT1BvMDNXOCtJdkk4bEludUtXOXky?=
 =?utf-8?Q?UdRV76vF7TQzoduvsRKF3s71r?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f83d32-692c-46e7-7a25-08dd19ef2bca
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4561.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 14:21:58.3307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G3jIc7IreFZHEodfCfQXHkpDb9qMaR01MwI5RXpk56VyG4xRj+MEFPou5bOIS1OLZPTUKQDxJGo8f3gU97Fdwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4905
X-BESS-ID: 1733926923-103649-13361-10826-1
X-BESS-VER: 2019.1_20241205.2350
X-BESS-Apparent-Source-IP: 104.47.55.47
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobGFgZAVgZQMCnNODXFwNgiJS
	kx1dTEzMLAzCTVOMXC0tjMPDnN2CJRqTYWANhbzNhBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.261038 [from 
	cloudscan23-120.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

2024. 12. 11. 14:34 keltezéssel, Andrew Lunn írta:
> [EXTERNAL E-MAIL] Warning! This email originated outside of the organization! Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
>
> On Wed, Dec 11, 2024 at 01:46:56PM +0100, Robert Hodaszi wrote:
>> Commit dcfe7673787b4bfea2c213df443d312aa754757b ("net: dsa: tag_sja1105:
>> absorb logic for not overwriting precise info into dsa_8021q_rcv()")
>> added support to let the DSA switch driver set source_port and
>> switch_id. tag_8021q's logic overrides the previously set source_port
>> and switch_id only if they are marked as "invalid" (-1). sja1105 and
>> vsc73xx drivers are doing that properly, but ocelot_8021q driver doesn't
>> initialize those variables. That causes dsa_8021q_rcv() doesn't set
>> them, and they remain unassigned.
>>
>> Initialize them as invalid to so dsa_8021q_rcv() can return with the
>> proper values.
> Hi Robert
>
> Since this is a fix, it needs a Fixes: tag. Please also base it on net.
>
> There is more here:
>
> https://linkprotect.cudasvc.com/url?a=https%3a%2f%2fwww.kernel.org%2fdoc%2fhtml%2flatest%2fprocess%2fmaintainer-netdev.html&c=E,1,4wyDgaiEANqhFn2GG0tcaR1j57JQtD08e0Ct4VSwo05Uu1yGRm73RMgwy0gs_ClxX5Mmerf2f6bxOoXZF9G_zKOP4Isr6iVcIkPhTzyMVHt9DNUF0KUfXCE,&typo=1
>
>         Andrew

Hi,

OK, thanks! Let me try again!

Robert


