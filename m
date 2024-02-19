Return-Path: <stable+bounces-20489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDC5859CC4
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 08:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44CF8282A14
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 07:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811B1208C6;
	Mon, 19 Feb 2024 07:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Fefuimac"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A4920334
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 07:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708327465; cv=fail; b=OlnxNQ2ptyOHQgjehVri9a7Z4GzrZGxUaZPtUxV17F1/s/fWzDZQohPNhzB/w55E82BcP7euES5RvMSLPf8W2+HGorlTre8CzUiQldNFqhXX+dJgzLaC1+gyIodQ48TvVPXkHsUES4s9SC/pILyT5WBNOb+OjW5Z4fXGH3NfOKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708327465; c=relaxed/simple;
	bh=CFCq6DSDkWDvVidQxhmHFSnOmWhaBtr4jVf8Er/wE/w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hplv1ZvVJruCWHoZl63MT4+v8NugZPoLTtc32NUMmBkW5YMddtLiLXdY6a59ca9gfazNhfDdvKYR4Uo5P86qA0Xo8T07ivDMh0tKQSD1eZvtFtwyPc/utX2FRHGsabuMJOMkPWlxr7eYwxg7kNQGLVPdhVFI9t+Ba84ydeD6OaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Fefuimac; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOrBT8ttgunp+rb7sba04LL0u9KpdZOcM7OgnYAXGe7FhZPhQBOtV/xlk2aydohVZwFtGCC52gopZwaKsuUdMAJ4pbN275hD1OLFZEFEdFuiVMoyPoJPVaJpuEPI3+Fg2UomBP0I3BFN/vFaMXe0CSNajNAeEn251z5/tv0wbD9bLRXZyLE5SSgBnOtawlFZpHpXvnICPBv95yEqervF6bXcwEZJCKCLuKmC89YnUvp7GayKxyAZwqKDTj3KjQImd9K4EcV8bXnlZI4Sz8VdKVUgiYH9Ue48sTjep3NJTS5DqdIrux8K9XH3864EUVQxco5sGfNy+IEMKspUdZbEjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFCq6DSDkWDvVidQxhmHFSnOmWhaBtr4jVf8Er/wE/w=;
 b=K77fssngIlQaK/PvC2F12/4Sae4FiYSi7t+8wDXR7RSaHqb1OZ0DAoCcFRA/g6FWy8XMWG4R/mdblIqq0DScSG9UxuSbzyhsySTAnH9mrHD5lM9NLZ5OilD/XY1/cAbTyBlZLS+32EYqMimPJ3X/7Lt2e6G4vylXpa9rdZxkzuhJSJSGwQBMimdoHcEszfa3Kt7tHa9QsoJXRg3dqyMjwb8A2C4QFmGfngOlxkg/642BzILOncSZSQdqta7u9p2Ounx2H/jrTt75gHqb1uHcbfuMOYWTC2AhfcDVyK/tulU8a13rO3fuBFvyfETTfmqc2xWCmFtocKOwMubgiJgImg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFCq6DSDkWDvVidQxhmHFSnOmWhaBtr4jVf8Er/wE/w=;
 b=FefuimacQGMvMkUBWXhZnWcKCmCIYNtW9wVlOJWAcd3UYk82hLGf/+LJO5Zx1sSS77s/qGk46+bH3Sh9+P39MtPAEvO/9OKVALsEFgI5QLQn2yacE7rdMKzusnDACoGC3/R5yQ3JLLdshTgK8XGTZNpxJjcMbohPrVNra8YBx9Y=
Received: from CO6PR12MB5489.namprd12.prod.outlook.com (2603:10b6:303:139::18)
 by SA1PR12MB7318.namprd12.prod.outlook.com (2603:10b6:806:2b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.17; Mon, 19 Feb
 2024 07:24:21 +0000
Received: from CO6PR12MB5489.namprd12.prod.outlook.com
 ([fe80::7a06:2a38:4667:d5a7]) by CO6PR12MB5489.namprd12.prod.outlook.com
 ([fe80::7a06:2a38:4667:d5a7%4]) with mapi id 15.20.7316.016; Mon, 19 Feb 2024
 07:24:21 +0000
From: "Lin, Wayne" <Wayne.Lin@amd.com>
To: =?iso-8859-1?Q?Leon_Wei=DF?= <leon.weiss@ruhr-uni-bochum.de>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"lyude@redhat.com" <lyude@redhat.com>
Subject: Re: [REGRESSION] NULL pointer dereference drm_dp_add_payload_part2
Thread-Topic: [REGRESSION] NULL pointer dereference drm_dp_add_payload_part2
Thread-Index: AQHaWaIV/cd6X4DkAkCWcz17/q/UZ7ERVUXP
Date: Mon, 19 Feb 2024 07:24:21 +0000
Message-ID:
 <CO6PR12MB548918C8F66468B947A06885FC512@CO6PR12MB5489.namprd12.prod.outlook.com>
References:
 <38c253ea42072cc825dc969ac4e6b9b600371cc8.camel@ruhr-uni-bochum.de>
In-Reply-To:
 <38c253ea42072cc825dc969ac4e6b9b600371cc8.camel@ruhr-uni-bochum.de>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-02-19T07:24:20.550Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR12MB5489:EE_|SA1PR12MB7318:EE_
x-ms-office365-filtering-correlation-id: 39b580af-6d5e-4d08-5f69-08dc311bca7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 PBS5jWmjaESTxbuFsrFNhncUYAThFtuI53hxno9SA7ZHHMsv9f1VGG3hB14ehyG/3WU+MVBLrYzYOiDbnBrS/xfW4sKmDThRTv1TYt1+/MQd8em7NJzDthPVSeNWkXmAIjkpdc4SXAi8Pwl98o0xu8R0xTO50DpJAyF51TBZvEPnAzQ5bHgPo79cjJygzQeESrdcPUyG/bc9462IaZ7m0TUaJCZLD4LvZlwFd8mmnWY0X6VDIQc+jgmPVjs7KwlY4AkaVubgUDLn4pc4aX6mmeNLLawbdLKfGWaJZMrQfrQspLQMRDgpgM4TPsDEv66M2O5GrHZroeZoMwdsO6gLrMr5xeOMNVWsICwhs+Fvj4U7WOmIQk1I+z6uXsMHlD7IRNiECTfUkYcMX6LNLDIBcoBcWuMdDovVEO+/kj3hfNL39gVNHnqSzIq2qz7wJsAbwrPGnCCqXxq5gocz4SWw9HhqrPW0NN7hShsNuja8qyWog88sHKXKQtjJ7bJnvhAxWcMhuD6qzNkQDfUE3GKq1IHXIth7oe5a0f5KS4Gy3oFNU47VegWfMwabhIiK4gzMy5XK/nJ6cLYGiJufRk6jqV9uH6e48h89nbKXYC19x8E16hw8v+Cfolf85BwSjuk1
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5489.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(110136005)(316002)(71200400001)(54906003)(55016003)(4744005)(5660300002)(2906002)(8676002)(4326008)(8936002)(86362001)(6506007)(53546011)(7696005)(66556008)(9686003)(64756008)(66446008)(66476007)(52536014)(76116006)(66946007)(91956017)(478600001)(38070700009)(26005)(41300700001)(122000001)(38100700002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?AnvcthlPReNyPIJ095a3l0wWC9IsWsidm6VsbJ5zCNCZebFarAuN62zUC6?=
 =?iso-8859-1?Q?i9ar8rn8te4d+1SSs8wRDJyHiP6wwB29fAvL5j1/O1WJoeXLilFxiRxJ5l?=
 =?iso-8859-1?Q?EEEQM/uInjJzuGQuMS8u3wsOZhu3/RHZqNC8/YFvEfgoJgB0qSpLaobjK1?=
 =?iso-8859-1?Q?m0z+YQxqQcjyuAh3KlxpauMgEuXYkfsAtyLQ6cLZnH1YnnoQ3N1C58b9Mw?=
 =?iso-8859-1?Q?61vJuqo+GGYFG5OJj8JE+bsBQOR+RTUqFTMK/9vHPHEl8dSOzpxDsIGAxu?=
 =?iso-8859-1?Q?XLkrSisvVBUp3hIUIB3aJIz+SE6kUIuvgSIlGGzzDAsf8G/U9bMiniQfl0?=
 =?iso-8859-1?Q?ne/FsritRFfdN0BJVRLJZ6n8dGOaFuHLu2m8XAHkqMDSRSC3I0OxfnGZMF?=
 =?iso-8859-1?Q?8vAsincNnErdB6bQRiTlFzQgnC5/Qbd/JUzjP8okac5NzUWxkjS47KYBps?=
 =?iso-8859-1?Q?BYEcVkPa+HlntqzG1iddjZa6djCoRoth5/U/OIAVNX0LEjRARwJ2rGfROi?=
 =?iso-8859-1?Q?wmQgTs04AcDl6H4MgwANq5xFA8yG60eSc7Jr11p+Coe2ydy9h5ijxC5ciW?=
 =?iso-8859-1?Q?fEyPIDV5Y4r4Vi4y9qU1C47JQkvJZ3Tl6TSWXJCnRBQ+F9xWp1mNgv97IG?=
 =?iso-8859-1?Q?dD94DjAEWCfRTHbCODE0PL0hzg4ybTkKnGxx6Pssxcr9XYWDUyHZL7IYSE?=
 =?iso-8859-1?Q?Eug+7OzR2/F1/DkY9lrEC7co0mvxShqQ+L99daoV3U0sCSicQdUA6y1btc?=
 =?iso-8859-1?Q?DOYG2Q67StwWTjx1/btC2u3p7nxDaga1/vZWU5eMpmJ/q+lkbwPrGapNlk?=
 =?iso-8859-1?Q?Xqi17JsDOqdJTE1rHc3MX1ueEnReKYmcp5U2f5E8Kt3tVuIT2sQq9dQoew?=
 =?iso-8859-1?Q?0IKGzJdWwTm84NlRtlfEJPyCZjCpaqO7vZivCGO5ajrClk9LK/lyqp28Kg?=
 =?iso-8859-1?Q?1/Kjekkcqzqh6CyuiOgluXZ10Ow6LyTL5zP1tmP6HsqIq8mjRCrcGG9urA?=
 =?iso-8859-1?Q?7XxAU2ErVIb+T4lJyyyJ5Ppknbb0GaoctOHWr+jNLTS62gf1XwlGuZIn14?=
 =?iso-8859-1?Q?xzbpHfHpK7u51E76y5KyYymH3HNCDm1nKoQL02Uh5SmUKBm0Pl/eivON0i?=
 =?iso-8859-1?Q?2ZU60lFTb9xAuBT/4rDQkV8aYIo84vxbW2RcgTem9mcd+ACXQMz39NWBCP?=
 =?iso-8859-1?Q?6MfKPUsvtFxfsCCXRFXF/L25se4arf8hFTP7F+uJvlRNsShfj76FK9BNMW?=
 =?iso-8859-1?Q?V0kaHdnlUwCLh9tX5WmdW5qVpjGJI2lnGx+xOfn3cmghHdJkKCTHfCAeZy?=
 =?iso-8859-1?Q?jpZCJeRunU7pr8zrCeLYRDA7NzXzPoBGfv5ABeIHWchOpLeDMf+FIHcuOx?=
 =?iso-8859-1?Q?V/OFhMLsG7PSLqKnjCUkNHpxlSmDf16cZTXLyhY1TVWmmD1WXOQ/ehjVrx?=
 =?iso-8859-1?Q?+RTV4zXRIp+xGqmU85IHH8AScLN2vczP1+7XMTTjW6GLC7/fzqhP/Hpge8?=
 =?iso-8859-1?Q?bu1s8uuLt3VumJJN6l7OCD4ly51K/VMFDHVTXnCexa3yYN63L9rkpi3uSt?=
 =?iso-8859-1?Q?w2+xL/fCf1VZnOti/CnXRHi3VSl8PbGayzhWgnRyhzBYRnNopO0hKmuBYV?=
 =?iso-8859-1?Q?dwspWqyZIdWLU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5489.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b580af-6d5e-4d08-5f69-08dc311bca7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 07:24:21.0317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vxsBAZHYqW7NBUos3ul63pmK24YN8tMzwtOCwHa6JoSoJ2zBHjkAmXFIGLEImMtPyPPl5ifJakhqldqQtmmKAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7318

[Public]

Hi,

Thanks for the catch! Will prepare a patch to fix it.

Thanks,
Wayne Lin

________________________________________
From: Leon Wei=DF <leon.weiss@ruhr-uni-bochum.de>
Sent: Wednesday, February 7, 2024 16:45
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev; Lin, Wayne; lyude@redhat.com
Subject: [REGRESSION] NULL pointer dereference drm_dp_add_payload_part2

Hello,

54d217406afe250d7a768783baaa79a035f21d38 fixed an issue in
drm_dp_add_payload_part2 that lead to a NULL pointer dereference in
case state is NULL.

The change was (accidentally?) reverted in
5aa1dfcdf0a429e4941e2eef75b006a8c7a8ac49 and the problem reappeared.

The issue is rather spurious, but I've had it appear when unplugging a
thunderbolt dock.

#regzbot introduced 5aa1dfcdf0a429e4941e2eef75b006a8c7a8ac49

