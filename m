Return-Path: <stable+bounces-6834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA48814CAC
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 17:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 499EFB22BC1
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 16:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299AF3A8F7;
	Fri, 15 Dec 2023 16:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lt7pnZLg"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816D53C46D
	for <stable@vger.kernel.org>; Fri, 15 Dec 2023 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liCC5W0YfVA9Wn3Db/nGxEBDyovNz/artMPKzf1jNYytvaLwXQXQ5PGZ4zlhvKXEzQzVgBmTDkuuoM0HJ4I6G0ihZmTyy4ZPLw7/5Hp6RceIsO3h2/EKpKSuFRRq4HZrfdNoOId25tiSv0B9voDciShQS15ozQmlp9HO/1qZL9pQqjUbhuHU+jI0mcwWaNipcbHxSYuI8O3NDwZD6XlAk7sWSMwZe+a9+U+6v2QTjpIawtiP8vLYgK1tKyxRsNiTyf3TWhspDFrRkgSPgYf0nyAEihdMQa3OlDHPlsg08P9XM34ZzofpXF+Ov2zDjVriy4ehHbEY2lRGxSgt8oz2Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvgmQF2LUPrhtybiUKTKnK3saiqjnKPKFyE2cWBn3JM=;
 b=O1yWbC/TIA89X+PKy5/R5oaZ+Hw7bWQkVwU63ZMHSu6DDEASSh2oqv4v5F8p3XE78TmcvHLbORXwB5QmvhXLa40HDw7uy5AyH1iYolGaOqB/P4qN3zmYcmwLXvprDZWKyCtijpoS7LvUP/z1Ngf4HTkiM9KBv7U3oPy1bcYjKAH21blA8r1QWU45q4UZD2Hevrla+GliCdJjfvGj6AUIiW8YUq31o3kan+bgUw9awVnkWnln+Y4BT2AYd3F9Rtad79yD0A+EtOVcTWKAmf57ig92qpRhoo3Nj0sIlqvFZ92mcLJPEQuoBNIULbkSblDcH12YFgiWb6bq4KDAvFQxFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvgmQF2LUPrhtybiUKTKnK3saiqjnKPKFyE2cWBn3JM=;
 b=lt7pnZLgKNOhfI2a5zigE/ofT70IN/NoWIpTQmuC5hFJdCugLaVFchZLCgqbqWA+n4QKjHl9Y0Tp4do4qxsm5aPCJSROmdtujhQnYr1YoriIWstQU0II1iDnJbUW0uxuuY65/mzfOhxIJP1e+tEmh6UY+ZLPCadJ+Hc4ZImtnSk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DS7PR12MB8203.namprd12.prod.outlook.com (2603:10b6:8:e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 16:13:21 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::3a35:139f:8361:ab66]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::3a35:139f:8361:ab66%7]) with mapi id 15.20.7091.032; Fri, 15 Dec 2023
 16:13:21 +0000
Message-ID: <64ceba72-b6e4-409c-9c15-0290669c0687@amd.com>
Date: Fri, 15 Dec 2023 11:13:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: disable FPO and SubVP for older DMUB
 versions on DCN32x
Content-Language: en-US
To: Hamza Mahfooz <hamza.mahfooz@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 Jun Lei <jun.lei@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 Saaem Rizvi <syedsaaem.rizvi@amd.com>, Samson Tam <samson.tam@amd.com>,
 stable@vger.kernel.org, Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
References: <20231215160116.17012-1-hamza.mahfooz@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20231215160116.17012-1-hamza.mahfooz@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0022.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::20) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DS7PR12MB8203:EE_
X-MS-Office365-Filtering-Correlation-Id: 20944675-658a-43ce-5854-08dbfd88c19a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/VWlIeAy9znBJrwAAKb03zTkHbW9yQsHMpSRCfb3qs02ifWREw8AT4UXiA+YfwMfpfLxkKlDmaeNl5NU9VqJrZIGzqYoVtERyBv4nIgqz73d7foD4ILffZcRSiUNUrVb3L2mOkvq9hOZafPCEvtFh+z8IhpRpxIBIIResqFPhYQh7zkXhJZwD0q8ScI3qICSOePsGezhyeqX5JI4+gO478ticz2Jf5el1j/rw2ZJ6Dx2DG2OZKNrPBbe/gnuEjKAtNn/pVcHL0Pei9CEORwqJnoepJM7lAomLlvAxVyPw6ixDO2gKNTXoMoRthY9hsFF/8szfbmN9AVqTdoVo71nezYBFlOnxh5d9apGAv8Q9fQOCIHQ7UxfF+6VfobzpjSNSbT/P/KJBT33/Ge0cCMqVUp5bP9Q/s65NSRW4tpUnRDPQEcBw5HU6ud0T0wxIxU9Z9I1IS1CJiK5lLVVDGLlkfZY7c3PtJ7H/8bCGaBEfAG73VDtdK3qu1iQHsWFKrheeUPlNMmyAm7AhVug+yMGnddwUHScGqbAM2C7zEb7BRM+Onwj8z5E14OyoL0bbJQdjVkzsGjHW8JQhA7ckV2+rCdxc8PS50QMw3vupVAIhpP0Khc6R5U0bpvCTHOCr/yte4l4Zpf8lV4Ljtae6pvB4ynwHTgi8f5qhsvKsgPck00=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5427.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39860400002)(396003)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(38100700002)(83380400001)(41300700001)(2906002)(4001150100001)(6486002)(478600001)(966005)(5660300002)(31696002)(53546011)(6506007)(6512007)(6666004)(66556008)(66476007)(316002)(54906003)(66946007)(44832011)(31686004)(36756003)(8676002)(8936002)(4326008)(2616005)(26005)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVlVK2ErR0oxcHVCelVHejlJY1htU2cxMHY3aWx4TFdHc2dpVUlZZko2bENl?=
 =?utf-8?B?cTFubnlDS0JkSzhVNGMvUlE0dURWeTVtRTNxMDhsRUVlSzlPNnZIUUE3ZEFF?=
 =?utf-8?B?S29iR1ZDK1o2MXY0WHVSR3ZSUGp2ZVg5S2ZWRVMxU1pZczBsTi9sOHd5SUsx?=
 =?utf-8?B?SHl2TTNDRk8yeEhGWEhhZmwzQzZtdVBiWk56YlJhaUN6UWZMd1ZQVUxKVXpR?=
 =?utf-8?B?NlBZV3N3RG9aRDBFQmlkMnM3YTFxTDlmVVF6bTloTi9XN2pZRWZEN3NkbjdZ?=
 =?utf-8?B?Z21KaXg0cHFYNkwrZFlJb1VQcDJGVTdmaXVJUUU0TEgwU082QjVIOW8zMHF4?=
 =?utf-8?B?VndIK3dEbGZxaS81V0pXZGRjM1M3KzFXWktvSFlCS1VaL2NDTmtjdkNJeUFq?=
 =?utf-8?B?ajZFM3o0NWNiSHdJMnczY1JJTzFNcFdVWGhDaUFzY3huNTdkd3pVS0oxTzFJ?=
 =?utf-8?B?Y3MyVk05VnA4TDdYUmhuRzgveFZEOTd5K05BRWFvUjFNWERoMFk3andHQ1d1?=
 =?utf-8?B?QllIMVpyTXpocldZSHRxQ3BtK1h5c3o3NE5ZWEtLSklZQjN6U0p4M3VYN1dI?=
 =?utf-8?B?bnpVS0JJZ20rNTZLSHdDNjJrRzFkOWI3cWQwaEZBVWl2RnBKaUxHWUdCYkhE?=
 =?utf-8?B?ZGVET3ZyeGg2QkxGcWZINmlWZ0ZNdmFwZzdNM285eWRaaDExaDFpQmFvZGMv?=
 =?utf-8?B?Y2llS2FjVEtCRHdNZ0QyVnFtK0NPaUxyb1BDckhlUzZiVXVLVXVnYVBPdHBO?=
 =?utf-8?B?U0pScjFlOGtmWEJlYW1JLzJXbmJRNVkvSDJIYko3Q3lyRHBPWUNZQzNjeTI0?=
 =?utf-8?B?SDVxNWlIaldhY242WGIzZjBCanpsWHFkUDdNK3JWQkR2cWROcUVoNXpKWENz?=
 =?utf-8?B?Y3UzRU1CQUwwRW1Way9YMXgwUFZ4NFdwZDNoVEtweWFqZzRzS2NOMjRmSXhq?=
 =?utf-8?B?d3dsYU1NY0VLSXlxVGExZHc3L2xTanQ3bHhhNnJBcC82ZTk3TTZhVFNCSjBi?=
 =?utf-8?B?Y0lvSlIvK2YweW1TTW9KZHhJQ01VNTJvYXRiaGs0QnkvdjZBRTB0R2w0WDUv?=
 =?utf-8?B?Rm1XakgxdDNpa2VLdE0yemZYU1RyL3RPcmR3ZU5KbEZ5NHo5QWIrM054U0Vo?=
 =?utf-8?B?dWNhby9vZ2xaRnFQVDZLbGpCUysxQWI4NWppOCtPZVN5cnpZOU5ScFAzMnZI?=
 =?utf-8?B?TDZ2azRjMmsrWW5ZbGZlelJOd0MvTGNrclJMaXQwY3FyRVlHSzNDTzJQdzlh?=
 =?utf-8?B?dGxmRC9xS0ZkYlRlY3FhYVNDUjlTakQ3eHdLTGZRbDc1dDJwaVFjdjFVejZr?=
 =?utf-8?B?Qi82OENxaDFkcjFzd0c2S0UrNGhsSUpXa0ZsaEpYK2UrWjQvaVNlcHdmTGEr?=
 =?utf-8?B?aTcrbUtjUTB4eWxEMEJBM0NOenk4RUlTMlFvZ25HL2VKd2VWNCtYaG9iSnU5?=
 =?utf-8?B?Y2xxWmlHTWNuZ1VpZjZpejNqWXh0RGIvQTZoUndTWGhieGppa3BZRDdkZzdD?=
 =?utf-8?B?d2FNWGZ0R3dVaFloU1A2Y1ZGQVEwVlVadmREdDVrbldKaXBQb29wY25TK0lE?=
 =?utf-8?B?M29tVW5CM0R4V2lqZi9lM1ROd1dHY0hWeWFJY3VGK1hwNVhzR3hpdFdpK1ZK?=
 =?utf-8?B?UDdESXRTcFJkd1d1S2lxNDZNUHhxVUVwZGtkRUVvQTJXajE1RDg3dWkrRjlW?=
 =?utf-8?B?S2dJV2djRUlFTDBCZUNkMHE4NFoxdHp2S0xBWnU3aG0zQnBzUkE5UGpLY3Ux?=
 =?utf-8?B?bmxMa0VpRHpTUXRwajdQdlN4K2Q0WHBIWGFjTlZzUmFOTURyREgvRGFlZmYz?=
 =?utf-8?B?TWFoQ1JobnJ2RWl1Rk95Zi9TNXh3ZmhFVkNDSnlGMm9JMnFtTjRMY0M5WFhS?=
 =?utf-8?B?WHNDalFhUVYwZWJac2xITTNoa2UwaUt0MVNRekd5VkFFMUErajhHTjZaRHpk?=
 =?utf-8?B?MmYyS0s2ak54SitTcVJzMXlwQUx3TUdocWtrZ0FwTzNIa3B1cHVERWtjaUhi?=
 =?utf-8?B?UnJ1TGJPWmw5REgrQ1dvUS9Yam1Qb0VZNWFjT0Q1dm92UDRrZDJFNzRObEd3?=
 =?utf-8?B?Z3kzSndEb1RGRkswTTRsei9UekJ4YkwzUEdoTUQvbmU3SzBGbHM5M1A2Qkg2?=
 =?utf-8?Q?GA5HotvJ5Wtt39+zLsFURcFmq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20944675-658a-43ce-5854-08dbfd88c19a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 16:13:21.0009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eqdd3BUDNszFA1mYDD5RLDpEEX0fLfrlCkbV/q31CigFoyGieSu5IpHR6HJbUqrvWbiT9HLR2xw8/1uWYXS5cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8203



On 2023-12-15 11:01, Hamza Mahfooz wrote:
> There have recently been changes that break backwards compatibility,

Please start an internal thread with the DMUB guys about this. We
shouldn't really break backwards compatibility with FW. Include Alex D.
and myself, please.

> that were introduced into DMUB firmware (for DCN32x) concerning FPO and
> SubVP. So, since those are just power optimization features, we can just
> disable them unless the user is using a new enough version of DMUB
> firmware.
> 

I don't really like disabling this and don't fully understand whether
this won't break something else. But we also shouldn't crash, so this
change is

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> Cc: stable@vger.kernel.org
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2870
> Fixes: ed6e2782e974 ("drm/amd/display: For cursor P-State allow for SubVP")
> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Closes: https://lore.kernel.org/r/CABXGCsNRb0QbF2pKLJMDhVOKxyGD6-E+8p-4QO6FOWa6zp22_A@mail.gmail.com/
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
> index 5c323718ec90..0f0972ad441a 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
> @@ -960,6 +960,12 @@ void dcn32_init_hw(struct dc *dc)
>  		dc->caps.dmub_caps.subvp_psr = dc->ctx->dmub_srv->dmub->feature_caps.subvp_psr_support;
>  		dc->caps.dmub_caps.gecc_enable = dc->ctx->dmub_srv->dmub->feature_caps.gecc_enable;
>  		dc->caps.dmub_caps.mclk_sw = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch;
> +
> +		if (dc->ctx->dmub_srv->dmub->fw_version <
> +		    DMUB_FW_VERSION(7, 0, 35)) {
> +			dc->debug.force_disable_subvp = true;
> +			dc->debug.disable_fpo_optimizations = true;
> +		}
>  	}
>  }
>  


