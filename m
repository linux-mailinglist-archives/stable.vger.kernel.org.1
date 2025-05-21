Return-Path: <stable+bounces-145796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BDCABF0B4
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 12:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25BE14A6BFF
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 10:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C131225A2D9;
	Wed, 21 May 2025 10:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="YInxACf6"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2045.outbound.protection.outlook.com [40.92.91.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFA322B59D
	for <stable@vger.kernel.org>; Wed, 21 May 2025 10:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747821822; cv=fail; b=D6UTpJqletXq3EKJSZbUTszzF5ElVCEQ7h1hQHXblq45iDMWqOCrf/NypO94vF6Wd5wKXQmIfRDQ+vc7RdP4B0U8sb5SHRoM/PSZA/cBMUrFXw14MWHFWMIXXF6+XcHLzU6y1LSovLWBcw6YpYXO5GjWpaEFhIu//luTfgUIAt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747821822; c=relaxed/simple;
	bh=HRpA6u9Y2ugmuFgQHbiiTziFJ3bJvGnv5WZU11xdCfA=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZUqka5E2PiEu9TMzH613xicMqnf97DSg6sbvotnMXXHiR+CxJDDuxOtXPYFtuyGe9S1i2ZyB9pVM0BU5Wrg4QwwKnfx21cwYxQ4/+kQf7M08/vSEo2xtPV4bxXswpWDKV+Sr2Ci5585/RrALoYfzfz3jHqrsyr9bjkGJaQ8vgHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=YInxACf6; arc=fail smtp.client-ip=40.92.91.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aygXy/ZZm3kfLKOuSi15C9grVtz8a8csU9MOVeR4zkN3HbQkz+Y0JTviEF0vE9f7BJjS5eYqhjEye3PHNBJUZnkDwYw2FPehsoC+FzeNhuVp10TZG84rop6fc9LHfgr4Pl1n7REJpkjFr8XiFf6zAb6RlOqk89CCpp71B5yl0nkbfVTRY+NvxxjvbbeGuSrGSwhh9ap28527HkVH1fYk+EOcHpRBIwxfhHnOZVm2ldQL1sVNIKLC7ZgRt/NIYKn2dYOv5oqTqbOmvL2GMDKsTUymtOa/Ip5qN2Ps03sYLDEvBHPRFk5CgsjfTo+qbCrJolhOuwpa92lZ8GILAZzCSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkjhPsA85y7BVOh8Xr5gK66Tv7ZQKy8RLKukzbeqHMQ=;
 b=xkTEe0vvEw8k1j4Kgi+PHWXx4OIltBq/8xyNeKMox6oiMOFrcQy3v813BMSt3ZgFbUid+tfDAff70GkywoEBG18KWKAwpv3tzhJyRCJq7JbxvNRME14wE7wxvsIQpnVeNYzAf9KbVs/VggXBTBGWPslj8PHwRG0OTkNPTack1Si7cH5hz8QxF/hxDwMVVBCkDCPOmM7umPZeg2dKJX3lrNLGE/o3I/u2RnP6nydA3rn0RHgtgOQX0ee41vSbDUWxSTa3sf4sLtG/fHFm8sfwcOc/i24oF9JF1c9hCh3pUjWhYqoFY8NTALoUBOEp2+8HUI/ryQ2jGdRDLIi+b9ccYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkjhPsA85y7BVOh8Xr5gK66Tv7ZQKy8RLKukzbeqHMQ=;
 b=YInxACf6PKf83pBKOEe52f+hxsTSrQxra+jMQfBICtokhFroHnP92tK8dR/7Bdbuw3HnZVZZ1C0lyDbwoxwOaWG186X1CrEb1RziccMvU6qT3owPVkfA26vjGrdGb+n0dpiM/sfl7tSSgJyP00ORu0oDFQqzEO3zgazre1Es3cJES3aeWmuoReUvh+26EDH78MJKeOr/gCG0yF2vV3iZZ2j58p5EOLoP6WoYa8CvTaAkmYVr1Up4EZEKw3EjiMbrZQPXE4Lvhs8+1yFtpnURazQpBjqNReuFPCd292lpGo42epRno17MgUB2byZYon4ZpUx4gOoYtiniq1dh8112Ow==
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:175::17)
 by GVXP189MB2793.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:1ff::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 10:03:36 +0000
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::e9f1:a878:e797:ee1a]) by AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::e9f1:a878:e797:ee1a%5]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 10:03:36 +0000
Message-ID:
 <AM7P189MB10092C41B59EF58CBCB290A2E39EA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Date: Wed, 21 May 2025 12:03:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Panic with a lis2dw12 accelerometer
From: Maud Spierings <maud_spierings@hotmail.com>
To: Christian Heusel <christian@heusel.eu>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
 linus.walleij@linaro.org
References: <AM7P189MB100986A83D2F28AF3FFAF976E39EA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
 <8d249485-61f6-4081-82e0-63ae280c98c1@heusel.eu>
 <3352738d-9c0e-4c23-aa9a-61e1d3d67a50@hotmail.com>
Content-Language: en-US
In-Reply-To: <3352738d-9c0e-4c23-aa9a-61e1d3d67a50@hotmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::17) To AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:175::17)
X-Microsoft-Original-Message-ID:
 <8ba135ca-27c1-42ca-8026-3b99986f20b5@hotmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7P189MB1009:EE_|GVXP189MB2793:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d1bc29c-3121-45c2-2db9-08dd984ec06f
X-MS-Exchange-SLBlob-MailProps:
	9qw5+ftluCChZnfVvosSLIOlRyTPeh57Et8hZK299aKcmltsi6M6HYHmVMFCP2R+jThgGVSTT9aCZ32XopnyTNL3R/mP0YG81qVg1T4uAvdCm0c2HWTe+HNssYH9v7L4/0Y/L5HCZChGufQEEOH/i7AhLRARu5yHAOK7VbM7kCiGhjgdyfOjdS522dm8B5Z8LI47H1tsmKfoWUNKWfn0jjqZW2kT/Mvqf2aWImNWkiri56SBtz8tCyzS0yKQ7wRjJJggLZ+kGTzxbCLT5sf3ejMI7AoBuweSsL4yZ2e8Vj30BJsuTnAVeZh16cAMCOeWKlvawJXjVhVW65ky4bTdQOdU49sX3VZH5PnRfWdsKKv8ydv0P1dzra33Ked2F7P08/3946icVk9JlkfqdGk7DsuMcI+X3/tZsq87OTfjEWUritVHa2WLlYyXtUYK1Lh0+GeQq+am5NsXFpuUY22iPqj9piJ7LDsWHekRh+2yeqT3VmhBtWCfO+HxPZrWZfwcXaUGVooDsmHtpBzAp60aGaIfmvlOLWCLNO3sbAnEYIkPhQqpRP9u2CmsO08I6XmIDhRISurmiuV4dHjSDFQELaDlCW0iPEirQ0qX2rbrSEfKvgZbzCRnjqmUza4i0gmjGcMNEW9cMhg/REx4ACzl6f57Ip6qSNbOmqDc3wiqoMg/C41T6sI3zuopeDv8gAczksh5EJ+HWD0=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|461199028|5072599009|19110799006|15080799009|8060799009|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1hGdDhVK0FWU01sVHZLZGhZeW9lY0duRkhONXlEYWdrbk9xOTgvYVFIWWNq?=
 =?utf-8?B?ekNSUjhIQWU3V2UzS2trNy8xSEtPRFhramJvQWVzNlBuNElKOFBIYms0VzFl?=
 =?utf-8?B?aG9COVMrNE1jaDNCbTZaYzNzR1c3UDdubnB4K09od2tpOEpSa1Z0dmlQcHhP?=
 =?utf-8?B?UXJxakJGbCs4eUFuVlVpSDF6TWZEQ1FMZjZDR1N0ZmdoSjRmRnNiNTdxWDRs?=
 =?utf-8?B?V1BmRUxzbTcwUE90VW92K0xBdFpLcG1HMFlMNUdCZFhCYjFPSGFja05lbFEv?=
 =?utf-8?B?L3hDUFM5dGRKcU5yb3puQzhqSUZlNFV2ZlBvY3hlRXg0MGVnT0xLSmE3Z1dp?=
 =?utf-8?B?TUc2K1RzTzVBeEs1d0ZST1JuZEdROVZ3c1J4TFdUSEp2OHNOZGJhOWtLeFJI?=
 =?utf-8?B?NWRhNEFDTGpCajFmTkFNMG5mcndwRWhGZk5nZ2JReEVXcGhiR0FoWGxub0NC?=
 =?utf-8?B?S0V1UXV5Y1E3bnA5OFBPYUFZTUFTR0E0R3NPV3pIWkhhSndOZVJTVk1JZFR2?=
 =?utf-8?B?L3J1aVpMckN0NXFXQ3FJRXljL0o1VEduTjRzUmlSbmJoVjJuU0VmREI4bFA1?=
 =?utf-8?B?SjJwVjNyVmZOM2dPYXhubk1UeDArMWlUenJvc2dqMDFXQnZKUnJCY2VOS09z?=
 =?utf-8?B?L1k3Z1dWR21ObytZc1pUay9nSlA3a0NPMWFMaUZEY2Z4TUt3SUpzR2cxM0Yy?=
 =?utf-8?B?TFhydUhQRWd1L3pEY2ZxUGE1cFRpUHYyVVFmdkJGMmFnK2gyN1hYNndkalo2?=
 =?utf-8?B?QXgySDA0UzNXaXZaSnVHOGI1djJ2MDBRNDQzRXNFZUx5dVQ4T1Q1OFVpYTlM?=
 =?utf-8?B?QlVUcm1MUURTQUx5c3owbjc1MHdzTzBnYVNRWkI4RSt3M241ZkZwOHpvTXdB?=
 =?utf-8?B?M2htNHg4ZjB5eUF1MXNqYURoZVFtSERRemk5Zk1FRHlWa0hqV25FbnNrR2RW?=
 =?utf-8?B?RXJOUms4TkVtMmxvbmloTEU3L1ZlYXh1Zlc4dDM1emVlUEhVRkV5Ukk3Z1pq?=
 =?utf-8?B?N1JWRHZSaFRLSUQxYTRIenpmaHM4bEZkcm9FMVpZUEVFWkhCNnprWk1VMGtL?=
 =?utf-8?B?TnFsOW80aFFlLy9WelU5dEVxMHF5U2Z0cUlnenU0TGxsY1RvUTUzbURidldo?=
 =?utf-8?B?US9pTkZvOG5CTHl1emovNnBVUjlEcnRJNzBBT0dPanJjS0R2cExscTFIM05J?=
 =?utf-8?B?RnVyZS9nYTYrUVlIS3FNeXUwK0RYZHMrRHgvWU5XbVJoWXAxS1huMFdJd0hn?=
 =?utf-8?B?NEJGREtwbUxySEJUdDJubk5LdTZqWm5LV2VSY1BudjNVQkU2QStTREdTR1Iy?=
 =?utf-8?B?eUdtYzg4UHJ5NjlySmtTcTJnSFIwdWVuS0poK29Vc2ZvSVhiSmdxaW5naDhy?=
 =?utf-8?B?eXhPN2hyOU1UWUY1TFhzWThpRExFYitTRUg5M1dIMFdyRjhDaE1CS0FIZjRr?=
 =?utf-8?B?bS82NDAxU21URGNFWEt1akErczgvUzQrRXpISDZjVERyV1NFYW9rRWRxOVFP?=
 =?utf-8?Q?JldSTA=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3RuSThEemxJTDdBRUZRTGlZQkt0NGw2QVc3cnNXLzVOREVEK0lmZFVRQy9I?=
 =?utf-8?B?bjhyMmNkTlRTZjNzN2pTWmQzYXJtRmNuWXFTZW9HYURZcHhqY1FkblBtWVIr?=
 =?utf-8?B?WEVqRXcrcW5PcWNScjVQdi9WNFJaZ1QrSzdkRlJjWkt3NEsyMTl6ZjNkSitm?=
 =?utf-8?B?RnN2LzBEZ1ZZRDRDNkFheTAya25yK3dldG5QOGwzTm11WlEzS0U2ZC91MW5O?=
 =?utf-8?B?RUM0eWxZRmd1YTBtNEtFRTN6cmEzUE5wUXVIanI1QnA0bldaUmhpQTlhcFFh?=
 =?utf-8?B?dHZJaEEvOXNCSlQ1SEVwRW1OK0JJZ2t4c1JzMUdoOUdiOEFsc2JHejFRc2kr?=
 =?utf-8?B?WW05SERyemRRQ1pFYTlCenFTOGVQcjd0M1h4cmhJcUNsYXFoY0NhOGZZbXFx?=
 =?utf-8?B?TUZVTUpQdkJMK2RkeUZyZi9iYjRNSHJKUlBOcTRyS2xsNHRCRFhwQ1dRWkZj?=
 =?utf-8?B?UUo5YzJpa0xXWmpOclViaSsrdExRSnR4ZFZVTlI1bTFFTkV3TE14T1g3RTdT?=
 =?utf-8?B?RUpHZHZGUStUZ0VDYytWL3hCeFZFbEY0M3lpaEp2YkorTEhBZGwxYWtBRUpv?=
 =?utf-8?B?VHFLQm5xc1BLb1FtYm5qS09heXFtNlhsNXBBQU0veGhKTzY3SmVNaXF6S1RR?=
 =?utf-8?B?TmRuQmN3R3Fkd0x4cjdTdGVMRkNpQTFXay8xV2lJMitNRGl4S2VSS0d3ZGRF?=
 =?utf-8?B?UHhHN2M4RXRNODZhNUcxalhXZm9zSTJRZWJQY2N6RzB3Q2lqQXk5Q0VQM0lj?=
 =?utf-8?B?eU5CSWpCNUZrRHdabDU1bis1TmVydnQ5Smh1d0Z4TERTTE55eDNrL2hrY2ND?=
 =?utf-8?B?R2kxZ055ZlRTOHlIS1JmRFFicGhoSzlMSzEraldENk9ZT0c4eFRPNTFBUHRS?=
 =?utf-8?B?OEduM1hZM2FhUnp4azdlSnFRWDVaYlBXUlgrdDM5cXhlY0hzY3NwbzhPSVNO?=
 =?utf-8?B?VUZUcDBOdzZLQTJvbGROTmtVSk1naEVmMkNjWlR2Y3dkZ1ozUU53eTFKbVRq?=
 =?utf-8?B?V05DbEI1c0o5bEdkVjRiTWZMMk0rb3BJWG1rVnJzM0lJK3BMYThOdDJtWHhG?=
 =?utf-8?B?d09RRnBIcG9GS2wvV1BCbkZyZ00zaytLdzdKL1dqOE9nR2w1TVo4TVdUejlZ?=
 =?utf-8?B?N1VKL1FpVjl6WTZqcHlrZHRGK0x5elFRcE43WEVtM0RXZzRvU3NpQ0I0anlE?=
 =?utf-8?B?VlUwUkh6MTA5eVVzTnBoc1ErNGhUc0dnUitnNlFCdkxvVkNsOTJlL3M0TmFW?=
 =?utf-8?B?ZUlkUS91WXFOUFVEb0kzQjF0ejJFNlI5Q2JLYnFjNjU2KzNKYjBYQ3FUMUg4?=
 =?utf-8?B?NGtSVWxxQW40N3pCdkpUdnVGaFNGdVM0SGlOKzlLRGdxU1g4ODVleW9SZFJ3?=
 =?utf-8?B?TnF4Vkp1UG9jcUR6QkF3K2IyaUhnQU5TZU5zSUtJaC9VbDlFYkhRZDBodXFa?=
 =?utf-8?B?MTcwZW1HRjRFR1pKdzJNeHNrc2toZ1RXbXpHNWdvUlA3RUdXUUlxd05sMW1x?=
 =?utf-8?B?alZPbWVGMEFrMGR3aDExZFFmYVlVMTdUcDJjSldEaXpkcEUwM0NmQjZWMDFy?=
 =?utf-8?B?bDIxclFzNFZBWWtsYVRSdS9HTGgyRE9iamxpUUw3WHNNSGRTSkR0dXBSeXVO?=
 =?utf-8?B?RGoyU050RzVrTHN4cHBBUXhTRm5Rdy9jaUZHOWU1TVdvUXZhZm10dlVTdVlG?=
 =?utf-8?B?UnJEUnRoL0Q4TDJVVGNvTmxmWVpXN3k1OEdxZzAwL1hpQjlpUjcxQ3lMOUV3?=
 =?utf-8?Q?V05qcnSyCVugSFQ2i2O/xHp0k+mv+RPETKj/9pu?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-2ef4d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1bc29c-3121-45c2-2db9-08dd984ec06f
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 10:03:36.3566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP189MB2793

On 5/21/25 11:48, Maud Spierings wrote:
> On 5/21/25 11:29, Christian Heusel wrote:
>> On 25/05/21 10:53AM, Maud Spierings wrote:
>>> I've just experienced an Issue that I think may be a regression.
>>>
>>> I'm enabling a device which incorporates a lis2dw12 accelerometer, 
>>> currently
>>> I am running 6.12 lts, so 6.12.29 as of typing this message.
>>
>> Could you check whether the latest mainline release (at the time this is
>> v6.15-rc7) is also affected? If that's not the case the bug might
>> already be fixed ^_^
> 
> Unfortunately doesn't seem to be the case, still gets the panic. I also 
> tried 6.12(.0), but that also has the panic, so it is definitely older 
> than this lts.
>
>> Also as you said that this is a regression, what is the last revision
>> that the accelerometer worked with?
> 
> Thats a difficult one to pin down, I'm moving from the nxp vendor kernel 
> to mainline, the last working one that I know sure is 5.10.72 of that 
> vendor kernel.

I did some more digging and the latest lts it seems to work with is 
6.1.139, 6.6.91 also crashes. So it seems to be a very old regression.
>>> This is where my ability to fix thing fizzles out and so here I am 
>>> asking
>>> for assistance.
>>>
>>> Kind regards,
>>> Maud
>>
>> Cheers,
>> Chris
> 


