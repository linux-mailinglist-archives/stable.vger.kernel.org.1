Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2451979E7DC
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 14:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbjIMMZj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 08:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjIMMZi (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 08:25:38 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A62919A8
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 05:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694607933; x=1726143933;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zED06gDyYOrcAs8DP7IZGznAG2OnBTsbrTFqfuABqis=;
  b=rb5WvAkGHleMkHfEPZiMOsu6YjQ8zp1OboXofZvKJEEQixCZ/ybNCkaq
   GMhC/q3vQ23AZe1cvp6NAVKSlnW0wBzx/Lrx7RaJJnBze415dhsjUUEbe
   DGXy7Xqdk6D5WqAaKGM1uIj2VJoZZfwV8cUdTv74hSaXIfvgENcTuGfdu
   /RhmCL9JqYvXgm5+hk6m+VfiAsG3huBkwF7Sgeo9NMQW/XLX40fOMMZcx
   9KwkXucyih1CsLhyzTWX5F4HbR012z4YtZaaeSK2wb0pePtmK5LkqebSP
   V54yQ/7WbNVHRWYng102HNmNrXbFOJkcvI4GBwSIUfXL9lbF873+nUPBY
   g==;
X-CSE-ConnectionGUID: 8VHSGYwERuSksExIZsZ7uw==
X-CSE-MsgGUID: PT9NYMLaSgO8bjyW+nHETw==
X-IronPort-AV: E=Sophos;i="6.02,143,1688400000"; 
   d="scan'208";a="355932661"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 13 Sep 2023 20:25:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnVLWBI9O8EAXP6HbGG2vrugRQJkQ1miWpFNdKaMfxEnJuf17l+eygVTla4iJInzZHW5eKA1wlZak1grJuh7pEP7xhO2OXDTEQXE5ccTMXyDC+AIf23R0otk9MEsrVUux4Q3QPp2YcZUjoD1M71xT5OBZ1ZNv7dSItXivLTXwwH9xLGaytzg5cwaoVH3JeR2OZmzmfCGuJaxtr9CGjTtwTIBTGfBU3C7Nnb1wPa2DwpZRzG/sICu9CzLAwyymqOk8wsLiHNi/OljZOtgj/IpJur32zMGD3ksm5rnGikoiCnOcY3TXNp0bAgoDXqz7Fj0T7dElu8/I2/F1DQKoWRE4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zED06gDyYOrcAs8DP7IZGznAG2OnBTsbrTFqfuABqis=;
 b=alPGwuUPzkWQ1wVUIKDdw75gAXXK07akEqyVYNqwzuEo6Qk2cMHFUmwkmwkj3LvGcLynWQm5KVWbKNeqypP96Awj0VrbHxTvHfMqc/EvMxb61hAuh47+64c+6/mO2sY/jfoKlA6B/kpR+ZRkr5RK/IVgdTRro2QQedvY+rWJ9Nd1dLqeiXMI6trwITtcgr+k4P2NUw7mEUIM2cHjYW7bWNRgWfDiqqT3gnVciolcM9P6vShtpm86lmeyvYONrJMtP/cW05yYvre+KVDn2GFS+l5fXbVeP9VXHS8NXnfOndQ/xU2kIy53bg/Ur/PNZFYRKDg42/EGL4xn6/1t7O4DVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zED06gDyYOrcAs8DP7IZGznAG2OnBTsbrTFqfuABqis=;
 b=zEiDTYtP2crRLy1bET+7XM1Mcm1GzooSHNwZHjUllXPpuE6pCSGjkJfXiNINA4aD0M8wb2DSa7PRRO6hXp2+wndYABBr7M7YQaRlBqbi3yk89MUpNqVSPmLKXDquEnaZMhGBF5Tf5PuSOOHhAPNvAnOS7xXhUFKKvTtL/LAtjdY=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BL3PR04MB7932.namprd04.prod.outlook.com (2603:10b6:208:33b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 12:25:29 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5%2]) with mapi id 15.20.6792.015; Wed, 13 Sep 2023
 12:25:29 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Keith Busch <kbusch@meta.com>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        =?utf-8?B?Q2zDoXVkaW8gU2FtcGFpbw==?= <patola@gmail.com>,
        Felix Yan <felixonmars@archlinux.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] nvme: avoid bogus CRTO values
Thread-Topic: [PATCH] nvme: avoid bogus CRTO values
Thread-Index: AQHZ5j1hsYCwaiF7S0KQOilyaTtJJw==
Date:   Wed, 13 Sep 2023 12:25:29 +0000
Message-ID: <ZQGqNZD9QweQQRmF@x1-carbon>
References: <20230912214733.3178956-1-kbusch@meta.com>
In-Reply-To: <20230912214733.3178956-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BL3PR04MB7932:EE_
x-ms-office365-filtering-correlation-id: d46c5ff8-3a00-47f0-3010-08dbb454846b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e1K4limX3J4ZAiiXOlwztlaMK5C/pGzfu+BzUTcxJka2sJuU2ePh34uNANOjaFhAg7ao/dDmAR2qa7WkveguP1cbj2wT4tD8nW0n+cKs3cPGqsBHtPOhEMp6JW9QqEQ+L+16WjR8XJA6/4A+mDYUap/dRVMcXWduAQn4IFrjGB8K93LtR9SSNpUnbyeUS77/+lzQrB285Re+rLzC/lIEZal3ub0Np0W2mHknbjbBbaBEZ8RK7C6AN1AXgVNloFXKzBEHLuRn8uJURSO4WYjQCfSYIogGkNJF+tyPESuH2IeZwDEQm8EpA3mGz02vMzXI+aGUkOJxkYpCfUu3+V+2aTZdv8TTtXic91Zcy3ApUsKHNaqNUPUfFXx5Dz06qVT3FaMEFojsfkoVnIqCKOW+VHn/m9F8naSs0uTjRMy8IWparz7aThL3CR4vmz7GENTIwxo9CE0u+zz7ig3bXlzYer3K/qpE/pc9034yMVIBn9KmG/YbLuDagaKRZVahWWJzgWL68t+q2/lWWP7zm6DdT39RYdxbJDN0ayDS4O3LX8RzSR89NJKhG+J7z90jr7BvcKBZwqZtJWsyRHMPHNyTdbiB84IchDLmf3Ikaw9rxcVVU+llgFv6GGIeCBbTa8xnwb5Dz8eJytj2vvadd1ud/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(366004)(396003)(376002)(136003)(186009)(451199024)(1800799009)(38100700002)(9686003)(6512007)(6506007)(6486002)(38070700005)(71200400001)(76116006)(966005)(91956017)(33716001)(478600001)(86362001)(122000001)(66574015)(83380400001)(66946007)(26005)(82960400001)(316002)(66556008)(66446008)(2906002)(5660300002)(4326008)(54906003)(64756008)(6916009)(66476007)(8936002)(8676002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3JnRE93RVJqVmFya3JFcDZINzFJbWZhV1FFNHlacXl6NkFlU2xlenYvNlIy?=
 =?utf-8?B?WlNBbzFOaUFsT0lnaUgvZ2ZoOW5kODdETm1RVlh1V2JKTXBGRlJDQWtDdVBQ?=
 =?utf-8?B?eElWNU9oQURiRmxxeVhueTlPM2U0RVV6bnZLcHhpQXd0R0xjMiswaEpEZ2gr?=
 =?utf-8?B?dkxnYjVjNmhyMXVzNEdTcWRpajEzVU9GSENNcU1BbmNqdm5lWmdkQVVxQ2px?=
 =?utf-8?B?dXI3dUJzT3dBbU9DcVJXWmlzQ2dxZEZqeGYrcktqWVBCOHdRN0JWOVA3VTZB?=
 =?utf-8?B?eTNlNEVVZTZUNFhZYjVXcldINWhSWjJ0LzRHNlhyM2tkcS9ycG9SL2NKWHkv?=
 =?utf-8?B?M3plcEVUYi9JZFhZV2R0TkcvcXluR1RwUUFLcmxDVU5TSGhvR3lTSXlnK2tE?=
 =?utf-8?B?WWQ0Yk8rUmNuZ0pmOHB5YW51WEI2cmk2ZzE1R0RicG0xM0E3eC92NlJHUjB3?=
 =?utf-8?B?Zlh2dTdFQ0ladytjeStqMkdCeHp6Nno2RkYwVGVyY29Xa1FpMnR4M0QrWVZN?=
 =?utf-8?B?OXdHWmh6TUJneUNTeS83bG9rNjZuRiszMzRmUEM0czQ0OFhETUE0bFk3OFln?=
 =?utf-8?B?Q3Vsb2lPUjlkMWRYeDBmajQydjMydlNiTWRmL21TY1paNW9hbW9VaGtIZmNN?=
 =?utf-8?B?K3ppMUY1dzY3V2dDVHNuZnhFTmJzZVRNWDdMVFBZc21SZEVLTVZhNHE4cFp2?=
 =?utf-8?B?UDlrMjBXc2wwVkxaaFQwNWxET0lCU2t2OTNXQUFOM1lmTmxDVG9NRTNYaGV1?=
 =?utf-8?B?SURCS2QyK08vU080ZGtqR2lqV2VWU09vQzhDYVl3clpPZksvLzBNZFc3UnVs?=
 =?utf-8?B?cUp2bFpzK2hsY3ZyRGNqUGIwRlpSTHNrOXNVTWpMNlJvQWVQNnF4YnE4SkZv?=
 =?utf-8?B?WWNyd1QxMlJtZFlEd0kvc1JQb0VRWlJndW8yTDYzTjlkaVhWd3hJVTF3aDI5?=
 =?utf-8?B?RVFRNjA2eHFOYmNUc2VZK3pEeGtKem5MS3J0Qk0yMjVKMzRNaUhTTHlBaDhB?=
 =?utf-8?B?alhMTUpIQUE5b3Mzbk8xUGQvY2pySWtNdmd3Nk40MTZhb0k4eVlSOXBYT2Yy?=
 =?utf-8?B?OXBrdnhIRmlQR1dHa1gvb09kTlhkUXVGbHdPMXp2eE1jZUZSVEg3eFNuZmJT?=
 =?utf-8?B?RERIREhzMVduSnNSV3NQSWpYQ1NIRHdRd3g1N3JBWVBMU3NaZ0RjcVdQYWhV?=
 =?utf-8?B?Mk1MME1QcjROZkM2YURIc1lFYStlckoxeFZWc05XMTNwaFNVNWVRYkdOekRr?=
 =?utf-8?B?Y1RXRytOU0ZiRElVK1E2eU9zbWs4L0prTzlxc1VtZkhXQ1YyZDBSbDEzeTdU?=
 =?utf-8?B?KzFSVCtSV056Sm8wSDJ1VTlJeSt2YStFWmNBZ2RLUUF4cXpvQ3loZVQ3U2xl?=
 =?utf-8?B?dnRlcHdoeU9ReVNMYk5lNkt2bDdJU1pFOC9KUndaVmtlRkwrTXBseURCbHk4?=
 =?utf-8?B?TFZIV1RrM0FkcExOVGVIZWlsdHFNT3BEekhxdEZaQ0Jza2hucVRSNXdORlU1?=
 =?utf-8?B?S0ZDekdlZnVDYzNTZlFpOXl2WTZBZjBUZ3RjZjFKS2Z6TFhGZzRTWHpyOTBx?=
 =?utf-8?B?bEw1V1Vhd2EzeEpBZUZIaXRlaUpGNGdhbjdQUk1JY05GbFBMS3J4ZFh6djhG?=
 =?utf-8?B?MEdZUEVGTHJCNGNxdzgrOW5SNDZzenRzK3Z5cGlkU3kwKzRPT05PdnpJRWNH?=
 =?utf-8?B?Q2FPM0JnTlhzMURJbDBzVEJaSFpncUlUMmxKM1RMWXcvYURTb3NXQUFBVEl4?=
 =?utf-8?B?T0xvbjZ3QUN2cE9YdFBVQXVKZUxqVnp0MmdSdThWTUNNVXE3SlBpdGFpVGJy?=
 =?utf-8?B?M3RsdTIvSHY5ZFlKM284LzRqVVpxaGtHYVV6V3VhVDE5RDBDUFdLc0RiS0k5?=
 =?utf-8?B?aCs0Tmxnb1B2K085YXJHc01yREdkV3JMd3d5WTlDdGx5bHVJOXlGNXRLQWpp?=
 =?utf-8?B?OGdEODdVS0ZocHY5RkNIOG5iaHJtTDRXZmFHRUc3NWxuSnpuTDVjdGZsTDJS?=
 =?utf-8?B?bDhyRzVWRVhHQ1VIdkcyWG84NDFPMG5WRHhSaHdwdEJ4NnlvaHJuZE5OOWJD?=
 =?utf-8?B?bUtqQ3NjMzZCL0tnZU96aTlSaEY2YkxsemNWZDRHUytiUUE3QjUzc29uMzFp?=
 =?utf-8?B?YnlmRW55cC90aENncCs0NktFdXcrS1d6Y2Zxb0xyc1EraXd2ckpDOGpncENO?=
 =?utf-8?B?Z0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02218ADA7BACD04998F3DDC30D390A1D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RTRsWEtpMVRpS0ZsZ3JWNXYzYnZwbGkydUE0MEtsSjBFZ2VNbDZJdkpnMGVO?=
 =?utf-8?B?SGRxWHRvaVg4ZEVyWVFkY3ZkdGk4YVpTbnVoSmNURmNLY2ZSV1cxSjFzbGhP?=
 =?utf-8?B?aGNxQ0Y2d083WER5YTJIc1BERGxMV1lCUWpkblA5am9FRE9sQUVQdU1GNkND?=
 =?utf-8?B?R0gxczk1aDk5c29UY3RlalFIeTB5Umk2dWlFbnd5dTdmOWlCZEt1QVlRSFEw?=
 =?utf-8?B?TStQb1l4Y29FY2c5QnpXZ0ppSHFCTzNpenJhaC9IblRrVGxtQ2J2OTRQcVZa?=
 =?utf-8?B?Ky9nUkxmU0U2SnptTVMrekt5bGsrZjZrVE92RDdGaHIzTEVtdW5aUlVYY0tX?=
 =?utf-8?B?ejlvTUpjczdtMThrZkR1Skt0Y0FaY1pPeG5kQnVZVnNuYndRWERRSGVYSEhm?=
 =?utf-8?B?RzM3aWFlOU83TDBtOCtTNktJUForUFQ3WUl5WjI1WjZYeUFLVThhdWpieDhM?=
 =?utf-8?B?NzQwcVNpc2M2aTEwbkJ1bDZQZHhuYUJpWG10U2R0UGt3Qkk0YUxrSDZ4VFZx?=
 =?utf-8?B?NklWcWgrcHlXQytYaWRhVklDWUU4UDl6RkcxV1Bxc2krUmNxU25zVFRYWTJX?=
 =?utf-8?B?cGZKeWNjd0JKMzdrYUR6YUY1clBpa29YS1lhV3VDdW0rVVFULzI3dEtlcm9v?=
 =?utf-8?B?bm0xeE9lSDcwOWYyYitNUENvMXE5ajArcFpOMXZaYmhHUEg2VUVqWVhtd2hy?=
 =?utf-8?B?cjcvM0Q4d0p3VkJROFh6dmhzbER0TDNOMlFlTnNQandOSVdNa25STTQvcjZV?=
 =?utf-8?B?ZGQySVhQL0NQRnAwNDdYU0UveStXcEdqL0l4Sk12RmdBdnYxL3hxSEt5dnNw?=
 =?utf-8?B?YnJIZVgzR1lZdVhrMmNSZWpxY0F4UnVqbks1RGlxVkplWG5ZVzZRajdnY01t?=
 =?utf-8?B?dFR4aDZtY1hRZVNBUHhWc0hTL3pIeWNpZ25yTWNKOW9Db053QzZhbHBja005?=
 =?utf-8?B?NjE4M2VLcVc5Y3Q1NmdicjdaVG54VU43K1pvMk80R1o3eWFXVzViL3lQWVdo?=
 =?utf-8?B?UFhBUDNPMkFtQytNdHVBUTRwTEJodDk5S0g0d1FLWVR2NnB3dXl1eWJFck9N?=
 =?utf-8?B?YU10WGJieUsrYlhidEhWalBKK2RyQUNhb1NhYnQxSTFHSGtQZUx3dlc5dU9a?=
 =?utf-8?B?TlJOSFRBSS91WTBSdEgxNVBhWTc5MDFmOGRBeElTQTZhUFNxcnVPZXFjelJD?=
 =?utf-8?B?YlNRRHJoOVNybEVLYTMrdXc0RWUzNnQ5M2JSS0p0UXBMNXNPNko4NTVsYnFH?=
 =?utf-8?B?QTRMZjdTRVg5OW5WK216STRJMENqZHlDdkdOdUFXbzlteE9RenpPUUkvR3Q5?=
 =?utf-8?Q?EHKz0byX1Mi6gvolAmef4M6TZaNA/GXGZb?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d46c5ff8-3a00-47f0-3010-08dbb454846b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 12:25:29.4854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z3Hmi1madD36WiokSAFVGysED2BlEgaxzNcL5H3jQz4f/eb7JcERU6yBxcO/q7DvBqhAIX/JN+kzdg55b77NOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB7932
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

T24gVHVlLCBTZXAgMTIsIDIwMjMgYXQgMDI6NDc6MzNQTSAtMDcwMCwgS2VpdGggQnVzY2ggd3Jv
dGU6DQo+IEZyb206IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4NCj4gDQo+IFNvbWUg
ZGV2aWNlcyBhcmUgcmVwb3J0aW5nIGNvbnRyb2xsZXIgcmVhZHkgbW9kZSBzdXBwb3J0LCBidXQg
cmV0dXJuIDANCj4gZm9yIENSVE8uIFRoZXNlIGRldmljZXMgcmVxdWlyZSBhIG11Y2ggaGlnaGVy
IHRpbWUgdG8gcmVhZHkgdGhhbiB0aGF0LA0KPiBzbyB0aGV5IGFyZSBmYWlsaW5nIHRvIGluaXRp
YWxpemUgYWZ0ZXIgdGhlIGRyaXZlciBzdGFydGVyIHByZWZlcnJpbmcNCj4gdGhhdCB2YWx1ZSBv
dmVyIENBUC5UTy4NCj4gDQo+IFRoZSBzcGVjIHJlcXVpcmVzIHRoYXQgQ0FQLlRPIG1hdGNoIHRo
ZSBhcHByb3ByaXRhdGUgQ1JUTyB2YWx1ZSwgb3IgYmUNCj4gc2V0IHRvIDB4ZmYgaWYgQ1JUTyBp
cyBsYXJnZXIgdGhhbiB0aGF0LiBUaGlzIG1lYW5zIHRoYXQgQ0FQLlRPIGNhbiBiZQ0KPiB1c2Vk
IHRvIHZhbGlkYXRlIGlmIENSVE8gaXMgcmVsaWFibGUsIGFuZCBwcm92aWRlcyBhbiBhcHByb3By
aWF0ZQ0KPiBmYWxsYmFjayBmb3Igc2V0dGluZyB0aGUgdGltZW91dCB2YWx1ZSBpZiBub3QuIFVz
ZSB3aGljaGV2ZXIgaXMgbGFyZ2VyLg0KPiANCj4gTGluazogaHR0cHM6Ly9idWd6aWxsYS5rZXJu
ZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMTc4NjMNCj4gUmVwb3J0ZWQtYnk6IENsw6F1ZGlvIFNh
bXBhaW8gPHBhdG9sYUBnbWFpbC5jb20+DQo+IFJlcG9ydGVkLWJ5OiBGZWxpeCBZYW4gPGZlbGl4
b25tYXJzQGFyY2hsaW51eC5vcmc+DQo+IEJhc2VkLW9uLWEtcGF0Y2gtYnk6IEZlbGl4IFlhbiA8
ZmVsaXhvbm1hcnNAYXJjaGxpbnV4Lm9yZz4NCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcN
Cj4gU2lnbmVkLW9mZi1ieTogS2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPg0KPiAtLS0N
Cj4gIGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyB8IDQ4ICsrKysrKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCAx
OSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3Jl
LmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCj4gaW5kZXggMzdiNmZhNzQ2NjYyMC4uNGFk
YzBiMmYxMmYxZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQo+ICsr
KyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0KPiBAQCAtMjI0NSwyNSArMjI0NSw4IEBAIGlu
dCBudm1lX2VuYWJsZV9jdHJsKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwpDQo+ICAJZWxzZQ0KPiAg
CQljdHJsLT5jdHJsX2NvbmZpZyA9IE5WTUVfQ0NfQ1NTX05WTTsNCj4gIA0KPiAtCWlmIChjdHJs
LT5jYXAgJiBOVk1FX0NBUF9DUk1TX0NSV01TKSB7DQo+IC0JCXUzMiBjcnRvOw0KPiAtDQo+IC0J
CXJldCA9IGN0cmwtPm9wcy0+cmVnX3JlYWQzMihjdHJsLCBOVk1FX1JFR19DUlRPLCAmY3J0byk7
DQo+IC0JCWlmIChyZXQpIHsNCj4gLQkJCWRldl9lcnIoY3RybC0+ZGV2aWNlLCAiUmVhZGluZyBD
UlRPIGZhaWxlZCAoJWQpXG4iLA0KPiAtCQkJCXJldCk7DQo+IC0JCQlyZXR1cm4gcmV0Ow0KPiAt
CQl9DQo+IC0NCj4gLQkJaWYgKGN0cmwtPmNhcCAmIE5WTUVfQ0FQX0NSTVNfQ1JJTVMpIHsNCj4g
LQkJCWN0cmwtPmN0cmxfY29uZmlnIHw9IE5WTUVfQ0NfQ1JJTUU7DQo+IC0JCQl0aW1lb3V0ID0g
TlZNRV9DUlRPX0NSSU1UKGNydG8pOw0KPiAtCQl9IGVsc2Ugew0KPiAtCQkJdGltZW91dCA9IE5W
TUVfQ1JUT19DUldNVChjcnRvKTsNCj4gLQkJfQ0KPiAtCX0gZWxzZSB7DQo+IC0JCXRpbWVvdXQg
PSBOVk1FX0NBUF9USU1FT1VUKGN0cmwtPmNhcCk7DQo+IC0JfQ0KPiArCWlmIChjdHJsLT5jYXAg
JiBOVk1FX0NBUF9DUk1TX0NSV01TICYmIGN0cmwtPmNhcCAmIE5WTUVfQ0FQX0NSTVNfQ1JJTVMp
DQo+ICsJCWN0cmwtPmN0cmxfY29uZmlnIHw9IE5WTUVfQ0NfQ1JJTUU7DQo+ICANCj4gIAljdHJs
LT5jdHJsX2NvbmZpZyB8PSAoTlZNRV9DVFJMX1BBR0VfU0hJRlQgLSAxMikgPDwgTlZNRV9DQ19N
UFNfU0hJRlQ7DQo+ICAJY3RybC0+Y3RybF9jb25maWcgfD0gTlZNRV9DQ19BTVNfUlIgfCBOVk1F
X0NDX1NITl9OT05FOw0KPiBAQCAtMjI3Nyw2ICsyMjYwLDMzIEBAIGludCBudm1lX2VuYWJsZV9j
dHJsKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwpDQo+ICAJaWYgKHJldCkNCj4gIAkJcmV0dXJuIHJl
dDsNCj4gIA0KPiArCS8qIENBUCB2YWx1ZSBtYXkgY2hhbmdlIGFmdGVyIGluaXRpYWwgQ0Mgd3Jp
dGUgKi8NCj4gKwlyZXQgPSBjdHJsLT5vcHMtPnJlZ19yZWFkNjQoY3RybCwgTlZNRV9SRUdfQ0FQ
LCAmY3RybC0+Y2FwKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiArDQo+ICsJ
dGltZW91dCA9IE5WTUVfQ0FQX1RJTUVPVVQoY3RybC0+Y2FwKTsNCj4gKwlpZiAoY3RybC0+Y2Fw
ICYgTlZNRV9DQVBfQ1JNU19DUldNUykgew0KPiArCQl1MzIgY3J0bzsNCj4gKw0KPiArCQlyZXQg
PSBjdHJsLT5vcHMtPnJlZ19yZWFkMzIoY3RybCwgTlZNRV9SRUdfQ1JUTywgJmNydG8pOw0KPiAr
CQlpZiAocmV0KSB7DQo+ICsJCQlkZXZfZXJyKGN0cmwtPmRldmljZSwgIlJlYWRpbmcgQ1JUTyBm
YWlsZWQgKCVkKVxuIiwNCj4gKwkJCQlyZXQpOw0KPiArCQkJcmV0dXJuIHJldDsNCj4gKwkJfQ0K
PiArDQo+ICsJCS8qDQo+ICsJCSAqIENSVE8gc2hvdWxkIGFsd2F5cyBiZSBncmVhdGVyIG9yIGVx
dWFsIHRvIENBUC5UTywgYnV0IHNvbWUNCj4gKwkJICogZGV2aWNlcyBhcmUga25vd24gdG8gZ2V0
IHRoaXMgd3JvbmcuIFVzZSB0aGUgbGFyZ2VyIG9mIHRoZQ0KPiArCQkgKiB0d28gdmFsdWVzLg0K
PiArCQkgKi8NCj4gKwkJaWYgKGN0cmwtPmN0cmxfY29uZmlnICYgTlZNRV9DQ19DUklNRSkNCj4g
KwkJCXRpbWVvdXQgPSBtYXgodGltZW91dCwgTlZNRV9DUlRPX0NSSU1UKGNydG8pKTsNCj4gKwkJ
ZWxzZQ0KPiArCQkJdGltZW91dCA9IG1heCh0aW1lb3V0LCBOVk1FX0NSVE9fQ1JXTVQoY3J0bykp
Ow0KDQpJIHNhdyB0aGUgb3JpZ2luYWwgYnVnIHJlcG9ydC4NCkJ1dCB3YXNuJ3QgdGhlIHByb2Js
ZW0gdGhhdCB0aGVzZSB3ZXJlIGNvbXBhcmVkIGJlZm9yZSBOVk1FX0NDX0NSSU1FIGhhZA0KYmVl
biB3cml0dGVuPw0KDQppLmUuIGlzIHRoaXMgbWF4KCkgY2hlY2sgc3RpbGwgbmVlZGVkIGZvciB0
aGUgYnVnIHJlcG9ydGVyJ3MgTlZNZSBkcml2ZSwNCmFmdGVyIE5WTUVfQ0NfQ1JJTUUgd2FzIGJl
ZW4gd3JpdHRlbiBhbmQgQ0FQIGhhcyBiZWVuIHJlLXJlYWQ/DQooSWYgc28sIHdvdWxkIGEgcXVp
cmsgYmUgYmV0dGVyPykNCg0KDQpLaW5kIHJlZ2FyZHMsDQpOaWtsYXM=
