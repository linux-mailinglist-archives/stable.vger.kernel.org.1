Return-Path: <stable+bounces-8348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B074D81CFA9
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 23:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F2128505A
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 22:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351DB2EB0E;
	Fri, 22 Dec 2023 22:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="aJjWdQow";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="EDIopIxz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="If0dScqW"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBE42EB06;
	Fri, 22 Dec 2023 22:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BMK4kAW032662;
	Fri, 22 Dec 2023 14:11:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:content-type:content-id
	:content-transfer-encoding:mime-version; s=pfptdkimsnps; bh=mED+
	9lRAhIzRdDtfiLdI6q2AOJzff8SrC46uDKYT2HM=; b=aJjWdQow4byn2RgaSZdr
	UPrdLbv476GV0w4Yo0cckccq+EjyQjYdSXSbQkPSV9nYUPbeW+7JgOqZ6XFuxjVe
	kHyqJdvUyHgGSNO3YtVM9DG8EZKI3Bt0/pj/b4fANqd1FHXpU6zwW/yjPhYifTcE
	bL8vtQndHAAF1HMyrXKoInyH0DnlceHdK0BRRQDVHjO+D2P+YKez4XgydmozsgA5
	K8mKrI6hpO8yFg92e6oIIgGea2q+eQAoauyGMNdAgkoZagy54Zq2fMRI/uvxVHH7
	R1vF1KurA27slfmE2kvlRZddUxUqDmsn+wc9dyetRvzYxTfuYZYoAk7XFx3/Hwxe
	Wg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3v5gpw0duq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 14:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1703283089; bh=mED+9lRAhIzRdDtfiLdI6q2AOJzff8SrC46uDKYT2HM=;
	h=From:To:CC:Subject:Date:From;
	b=EDIopIxzGIJIrin6Dh5aiiwo44se5zUjCkZC4x2/kJwsn7iqw68tYfqTf/9a9PMFL
	 ZK1tSRy8PjjZABlonfAnopAKXq6hfJkm/s6TbRuyYpOWupORAOZ1g3I07mr/m2TMuA
	 C8yc1iRJEMXh1Nsd8x2uY5T34wPyiYUTrdPViC6MVltbAC9dxjTzXIRW5ZwajePDiz
	 q5hF0CSfjDNQCkHSj9Tj4KfE12w2D13pFGXcbRmAEXmBhLaHxNJZsDrHmfTiIaPu4s
	 NzieoIyodgrF5UZXtOXZbilocaga6zPE4OS1SJSw8dIqMD6ziw5RpfG3xue72ofc0/
	 g2sFvowHRsd7w==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4D155401C2;
	Fri, 22 Dec 2023 22:11:29 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id CE31FA0068;
	Fri, 22 Dec 2023 22:11:28 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=If0dScqW;
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 80EE340363;
	Fri, 22 Dec 2023 22:11:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXB40QvnlUjslVenc/e1XVh15mLAkU3IcbbJPdpSZzpI1BhK0dUtdp90lCpqLcbbSVwoFI1nuGbmMXlZArKG9+bmScqjjA8znbwZ16WYPp4ch6cdK/lpxJym3ZsCLPZw8Nb99KgXwYCB7jIpGLnGTWMtO1BAu0BQzVGa3fodNaoI/TTn6BhPG/gEcR/xDghEBrF8QPe3Yb82kgmq5MECCZoL1LZ8UBG6gacbQ1mOb/ATjKYyQfyzIJW2MVLx56i5NG8b400//WxfSz20mZqkuWWwjOr08ETgC3ewQZM7u4JsR/jWxCJ2P0uYkaLoMsC6Mc4Mrh7Plr0ZsFcoSaNNhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mED+9lRAhIzRdDtfiLdI6q2AOJzff8SrC46uDKYT2HM=;
 b=OIY9TvjPOgt7EIkPPb/IfGSMz5wPA0yKY/jZbeHJRAm3RBXGT9m9T9s8h8NuckQnTOCeCQ1ouMg6mCAq5OuRxtnr854Hh2O9equ1xegeT5WoMZBZe4rYkzTTcAygUM3y8c+TxnHdGw6avq4Q5w7Cd1cTT0uuDn6OjO1KMl4Ilr1IwvN5tmu0NejjCRdFymC/LYpq5aJpsNZN2RsV8RQLhQ8OzRVSzTsVUxbol0MIQypFiWrPBemoZoUbFr4YsBFvJtaQqWDrx6d0zrFz4VVK6XwX561yzOJZVLJi2mafBY9t6PkDnU3/pKnRZMgxbATSJaZxIztQuxrEb2pheq98CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mED+9lRAhIzRdDtfiLdI6q2AOJzff8SrC46uDKYT2HM=;
 b=If0dScqWRjfJygPt/QHiiP1s79YGiub4lCIOdsZ67kMtsmUzVDzE8Ss8pvjCleP5sqmmdkkO3JJh59GuSWA6XYHCuBeiFgBWqThf4YjfmFQkG3yb6mhqQV/3YH0gmf3M1mrtS45FAgoPoNhwvONI8l99J67kYCdGjzkZeAeiJvw=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DS7PR12MB5982.namprd12.prod.outlook.com (2603:10b6:8:7d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 22:11:22 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::d931:a262:ec3b:3e56]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::d931:a262:ec3b:3e56%4]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 22:11:21 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: John Youn <John.Youn@synopsys.com>,
        =?utf-8?B?S8O2cnkgTWFpbmNlbnQ=?= <kory.maincent@bootlin.com>,
        Kenta Sato <tosainu.maple@gmail.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: [PATCH 0/2] usb: dwc3: Revert host soft-reset changes
Thread-Topic: [PATCH 0/2] usb: dwc3: Revert host soft-reset changes
Thread-Index: AQHaNSPLfhW7GMLKXk242s2RsNlvxw==
Date: Fri, 22 Dec 2023 22:11:21 +0000
Message-ID: <cover.1703282469.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DS7PR12MB5982:EE_
x-ms-office365-filtering-correlation-id: 051dc4db-8f04-48fa-ae9f-08dc033aedf6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 tgcIDkH566yY3A57Bw2WWrxNOttaLpzaPNe/zWWhIJbVrXzJ3Jeqq8kzgl+hKvzXBAkz7wCCs/HaujPas0It4WJpkgWl/G0M2YzTx7tX07V6DvFGGBsr/dsQp77QUw8dikZ7Phtv0qGn5ZhCcJHMPBoid1EVapmoxWOP/hYx9SA/C1HAxsqCBNZ44ofQN+CsIJExc8fTyfnMa6RWrhe3Se6iwDH7ezey+KEONqCl/zKl9wnAh08/P0ZY7VP6mSm03cvg1nkL3mctpXIvATpr6IGQ1dahA+Gt9tSKy02JZ7dgmQzbcWu6BIbwBPfaBjPBbHStvuUzOXQlTDS5UvNFwpXKhsmjebeqkbSA230aZjZveMfXEE9pS4et+Vvn02mGXfJge4rygYdUpRrXRwFi/f8kLIwEEveVtHAReteRHLdnAeuKJk6LKIfhhWnzBZNZHBQX3p0NQ0qJ3MZmy+ZTzHKD21Du1WbkozUuaJmFobJiM5sQ5busxscuAeGzCvOHq6i13VvD3+1tM/WZZT93WUryyUkoDkhoFJEKytB3j00XV9+dkBy3KQpUjtM3vvV/1oPAf9+pDWlzp6jaJGVVpgUmkhvpBeWc/XiFQd9XvUk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(366004)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(86362001)(2906002)(5660300002)(4326008)(4744005)(8936002)(54906003)(8676002)(41300700001)(38070700009)(83380400001)(26005)(2616005)(36756003)(122000001)(71200400001)(6486002)(38100700002)(316002)(76116006)(66556008)(66946007)(66476007)(110136005)(66446008)(64756008)(6506007)(966005)(6512007)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WFRzb1pOc0RWenZJRTAxcGZTWmdMa1F2RGc5Y0hhTUtLUVY3Y3paN2RtRkti?=
 =?utf-8?B?U0JKQUNQZ01iMldvUDdmcG1Jd1FXdUgzV3R1aFRES0ZBbGR1ekwycXAzSXlB?=
 =?utf-8?B?OUZ1QnJyaDBMTllDQlc4ckF2eFRQWnhWc3RaU20xYkhUQ0xxbmxKQzdKTEVx?=
 =?utf-8?B?VU13WmM2TVh4ZU05WVRYRm9FTC9ZM3I4VzIyamZMVlpSdHF6enM0K0ttb3lG?=
 =?utf-8?B?VktUSS9oWnExNE5DVUgxbVFMSmcvNGFPNzRWeU9lY3N4TEZhSGd4Nmp4cElP?=
 =?utf-8?B?S0p3YlJDVkprSVd5WmxHd0hTZmorNmhRaDZYUTJDZy81TC9SSUZGWGNHclNv?=
 =?utf-8?B?bG5pdWxqczV6bnlQMWFOcGlueHBveEd4R1poMzJVcWlISFlWM1o2U0o3N0lj?=
 =?utf-8?B?Rk84TFdkQkRaMGYveFRrL1BHQnlPdjlCQzJlUHh3cmpkZDJhRGUxdE9QRzhH?=
 =?utf-8?B?cXV5Y0tzVi8vdUt2Qm1oemRPNjh4Y1o3RjJBcWpZaGx0T2ozdW5QUjJERVB2?=
 =?utf-8?B?OWtwdEVYME8wNG01Ynl6MjhnS0pjaFpvQTd2SVlNdDZWMjhrRTRiMThzY3Ux?=
 =?utf-8?B?UFkwWGJnTEk5aTgyRHduSU01bktadmpRL1FtMWkyNWVJd1FNVFZ2Z2xNcytu?=
 =?utf-8?B?dFRCaXZoWWZPZFl1SUVFanRFMlBSMGRQMmFRRjhOWEtwOFptR013TVlCQ1F1?=
 =?utf-8?B?U1NoQnhGMUlwK1pSeUFsT0RIV0dQZzhJMlVCSVEvNGVSbERGL2U4bklDQzJh?=
 =?utf-8?B?NFlCRWVRM0hzVmFBdWE4WVhHYjJHWldpSjdZaFl1NnZXaXFIblU2Tis2KzBv?=
 =?utf-8?B?bjJlckR6dk00c0JxRnZnOW9ObTdIVEhFNTIvRVYxdGpmaU9QQXZDRnVMdE1l?=
 =?utf-8?B?cDZHYlBrdmMveTA4OENEVTdRTkcrSnlHeHlJeEpNb1czSnF3cEVDWXVsT0hU?=
 =?utf-8?B?SmpvTm1QTUtSVnBKUjVoVFFTRjZQaEw5SThCSEVjWjdyRS9UY0dpb1d4MGdt?=
 =?utf-8?B?R254NW55U0pqd3Nyc1lrM0FleUJGSktBaGVzMjFLMFNuZkpFcTBzYU1veExM?=
 =?utf-8?B?TDJJK0cyMnpiN016eVZucTh1djN4c21OcDZZWis4dWpWY291VEZUR29NU1BZ?=
 =?utf-8?B?VUdjelAyeldGY2EzYnpaaHc2TUVJd3MxeWYrdWlkbEFTWHJaZVYyQ29yclda?=
 =?utf-8?B?ZzFRU3p1ZlhUa1pmdUJWcktuVEc2YndXd2FIcERINzBSZldXaDZRQlN5MENB?=
 =?utf-8?B?MmZQbWJETm5ubHFoeXJ4Z2VYTk1hQU9PQ3pWOGdMWXZIeTNhdnZ3Qm5zZlBS?=
 =?utf-8?B?bmhmcTByWVRpR2dydm0rYUJrQ2VHcTFOMjZ6WUpPY25CQ1hVVmNCZm8zSytt?=
 =?utf-8?B?bFZXRmFKZmVSdS9jZndUMytnYnNUYlRBQVY2UHVTeTFrL1FVamlYWDBuOEpw?=
 =?utf-8?B?YXVXdGE2U3lBNmM0TXVnWXRBcDk4UFdkTUF3MzFlQlR3bkF5M25ac1pvNEJn?=
 =?utf-8?B?MWhsbk1xZm9tQXA0RnVHZXJvVVJQRHJIbGJ5U0MvcGMzM1VYVis4UjVnQmpT?=
 =?utf-8?B?dnFETWF2SDBWOGxrTFJIV3JHaHB0NEpjbmsxTEVLQW9JOHp5OTZ4QVBUcm1o?=
 =?utf-8?B?dGNzUk1YSXR5K0NrdHI2eTBBMkRxZ0tYNEkvRXorWjBLYzhVdjFTYzcyNkFV?=
 =?utf-8?B?UzRsMk9BQ1BuN3pqbW8xd0IxT1FQdlVrS252N28rWkdMZXU1UVgrYll4YXgr?=
 =?utf-8?B?cFJIRzRpNlFHZERSSnhEOTdQYzBsWEUwTk9Sc0lZaDQyNnQ0TUdIOXZVR3ll?=
 =?utf-8?B?bDY3TjVEdUxZNjg3QU1QK2cvZUdOMmxSN0dQdk9UWkpkSGtwbTVrcUlZbWhF?=
 =?utf-8?B?TWxSWlE5YVRCb0UyU21YM2RIdlQvVDJKTGZLQldLUHpTZGhkN3VnSkJNaUVH?=
 =?utf-8?B?S2N3dkdndFdEN1NKdm5RTm1NN2xQQ3d2ZE8zMUlhdlRyN092TndhcnhacWxZ?=
 =?utf-8?B?SkdPbXdVeWtXRmVpZHNYNDR4RnNDTWtjczA1Vm8yM2JWTEo5WGdaSWJyelBi?=
 =?utf-8?B?d0djSFNScFRhZG9Va1g0SzZHQzBYZ0RmSVArWHVTNkJzQnVaLzFPNTRLNG1X?=
 =?utf-8?Q?u1bo84BSUD/3VUOArnMo5NRGi?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4721379751647B43A598A5FFB0066FB7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	JHhJtZwK/pA3CH73aWlWXIIm99C4GwpONlQDD30Z9gxwaaVCd21nvlXQxNTE2a0DMqX/C0I93ys1J9Rnn/wny4DFX+aAe99ktiEvgmNODBasqtE9CMO4FJWV85t9k1yPLhAEnx6m+cJjnRFQzdUK7Y7c094g23xlbwPoz3/IbEfo+wDfNkpr4JnD9RyPGjIqsPw5oJihTx8LxSjgQXZwX8GNVvCkIIgVX8bDB00KXR/wQNve3oQhvtVNsrRsFzKIMgh1yWS3tJDqkb8Za7Th4EZHvfoHLhWPq5XzB5sENHMwnOw2JzfLGzG0hEXNZMrODzt9KskOYzgXdVAwKs9r11Se8tQLgHavJwb/DY0W/EyE9Gxsl8NM4YzuZ53TzDYqFw3h3qk93uyKbfzczQCCQpdIaLlpkUq34a1A2BWxI0jxQUi0xFsKHuu8HtbdHLhB0m1qfYuuo90kLGd2+DsdAymQOKjiY4ov2Ft082ZOWebef0dgJs1hcEzRjMBxZRsVZFf8NNh4eNCiFuCogMR9Hze22lKpkXJLMZxKok3l/RDa3OgbH1FEs/KM+NQj5/uhcL5MGAFFYE2ntH4zndhzt5d52p1t0P7Ou4AVDJuvyg8dsL5BfeBad8pFgGR0Sd22nvGDGRMpKi6Yh/13H0VK6w==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 051dc4db-8f04-48fa-ae9f-08dc033aedf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2023 22:11:21.4975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yutSDxwPVY2fK0n8CVXplqHZ14GjMXu1Pz/nh7RlYcuxkgXxMwILRD2FAa3z3U+eIDC/Pdu9XLOOtA/ToLGT3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5982
X-Proofpoint-GUID: -iL2KxMSTF-C0lrttDnMaGuG02gkNjek
X-Proofpoint-ORIG-GUID: -iL2KxMSTF-C0lrttDnMaGuG02gkNjek
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 clxscore=1011 phishscore=0 spamscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312220163

VGhlcmUgYXJlIHJlZ3Jlc3Npb24gcmVwb3J0cyBvZiBzb2Z0LXJlc2V0IGlzc3VlIGR1ZSB0byB0
aGUgcmVjZW50IGNoYW5nZXMuDQpSZXZlcnQgdGhlbSBhcyB0aGV5IGFyZSBpbmNvbXBsZXRlL2lu
Y29ycmVjdCBmaXggWypdLg0KDQpbKl0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtdXNi
L1pXOHNKb1RFS1ZtRGRrNVlAeGhhY2tlci8NCg0KDQpUaGluaCBOZ3V5ZW4gKDIpOg0KICBSZXZl
cnQgInVzYjogZHdjMzogU29mdCByZXNldCBwaHkgb24gcHJvYmUgZm9yIGhvc3QiDQogIFJldmVy
dCAidXNiOiBkd2MzOiBkb24ndCByZXNldCBkZXZpY2Ugc2lkZSBpZiBkd2MzIHdhcyBjb25maWd1
cmVkIGFzIGhvc3Qtb25seSINCg0KIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jIHwgMzkgKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAzOCBkZWxldGlvbnMoLSkNCg0KDQpiYXNlLWNvbW1pdDogYWIyNDFhMGFiNWFi
ZDcwMDM2YzNkOTU5MTQ2ZTUzNGEwMjQ0N2QxNw0KLS0gDQoyLjI4LjANCg==

