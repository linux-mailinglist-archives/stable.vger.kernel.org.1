Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EE57E19A9
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 06:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjKFF2J (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 00:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFF2I (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 00:28:08 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2738CC;
        Sun,  5 Nov 2023 21:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699248485; x=1730784485;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W3y0MKghVjpdHlOZsfCVTgrl2gDKwkpy0vsjPFhuA0E=;
  b=cqzXQFVyR0zr+9JgNV7/6eOVg+DSi1kR6BcCuQCpW6vkjrd4qRA6r1uY
   1PUD3YMQBomQFpyDTta0zq6RJSntoT5qNldqHiBwOnww868uef89oYjkn
   878nqu2/c8vEHrH6A9hGaaNauMZI2kg1rQi8CxMWOuYpvmCrxENywcF7d
   etAGrw64BYBga7fUE/ZxwWuZKL6ShEP2Xd5nls77frrg20+aWcL42as4h
   WmtrWuXwnBUwkzaHoAoSq5lv0ZvqUFtGPx8W1Yclr49IPzUTZbcwf1AuF
   08A5+Ya/GzPY4+5nq7pou+3peelDFfNYP+QyURZDJpuwa+t4JcPardvJD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="393109076"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="393109076"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 21:28:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="3336242"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Nov 2023 21:28:05 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 5 Nov 2023 21:28:04 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 5 Nov 2023 21:28:03 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 5 Nov 2023 21:28:03 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 5 Nov 2023 21:28:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSa+CC3mm6blTzBIugR2pQcqPNZEdVJAp8ngAe1vs8JV1V3I4Cvreq5fYI84LFoJlYBW46kAErTucuGNQdfZ5rKFKyf7rnloPJ0IXcGlJKqaYjD2TOVxBpKBbFgmU9+0CONr0eVotfxghBiGYQBmijrCGcyc65ex8lnoFk7/0epg8JR8ku2cv5QuI2RJDZPu2YpkWyvyiqolPOPuedywb66pL/mmfk+UnUQg7uCoAoG40dakFeW7+zaGHM80XQfqFTnTZhv3+T+FLEQy7YvdmFcls8r3cL2SBMTxqTNCreCFrDHLlDWNOqUk6uclrLBVbc79n10YOZ1aP6q0w55/Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lG3OkbPiyb90FU5zs9FoP2e0elxJbrR7OFqdqSbeW10=;
 b=CovZRhEQHQYmKIJnGw6rsZ1umuNF5THlB2jkdddUhcTrF/l2DR+cgUJ+EHSJ5dQ6Bs4U+tMiLWkfz8RY/BHTZZVyc1C3jdEd6H2/nIY7i26zR+LFrQS1Av13QsWE9vwOqEBKoEb7jFTtF6pNoFYQvXwUmyW4Pa8ApqGR1WypfgxEEvF0Pxl2CtI4H+Xr17fFqowaYUFoaATwrs3h5KeknqKDH1Yxf3qq6th2v/nWc3CMpETt7t7+UyqDKLW/Wbi3PEaCAHd3cauc8N/smPt/4+FlPGlow4Dcm1qlB5DMGu1jRPK8JJFn6M/GQx41ZpM2NzxM2IyHe15GXMhxwCL2UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4316.namprd11.prod.outlook.com (2603:10b6:5:205::16)
 by CO6PR11MB5586.namprd11.prod.outlook.com (2603:10b6:5:35d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Mon, 6 Nov
 2023 05:28:02 +0000
Received: from DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::9a25:8c82:9b90:3f06]) by DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::9a25:8c82:9b90:3f06%6]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 05:28:01 +0000
From:   "Wu, Wentong" <wentong.wu@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2] usb: misc: ljca: Fix enumeration error on Dell
 Latitude 9420
Thread-Topic: [PATCH v2] usb: misc: ljca: Fix enumeration error on Dell
 Latitude 9420
Thread-Index: AQHaD0eEaYw1dRVG60SCUYSZGeV/t7BsxKKQ
Date:   Mon, 6 Nov 2023 05:28:00 +0000
Message-ID: <DM6PR11MB4316F177641B7525777FEA448DAAA@DM6PR11MB4316.namprd11.prod.outlook.com>
References: <20231104175104.38786-1-hdegoede@redhat.com>
In-Reply-To: <20231104175104.38786-1-hdegoede@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4316:EE_|CO6PR11MB5586:EE_
x-ms-office365-filtering-correlation-id: c8aaf86a-4090-4bef-a241-08dbde892490
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yKvMcWj2vG7KlLHCq+15IxltqMWMgargenjcDlPZJKeWOe877jyjCZGgiQqvTPyfMozHrr8oOVUF2P7fr9gN52V2ZwNryrrXvMNWfpsJiEcE41kjmq8YLHX0J8Fyk+9egiHyy4Yjf+ifg62QWLPvo8smoheYE9C8KPN1IHWVZafjkSVBkAT9TzXUN6foYb8OWT1uQVrYFFSZiBYGoJu4nzZgWQsoVMHfJgnkh72TnNagBKuplGzq06Bkyas7rTc6JZ6yGqjkzLmdvql3mxwfUKN9FKJiuOSPigxian5AMnzwyWvVvuAfltL9ky5bUQU7OLjjJkkTXyoovyOzkUcX+KDc4OTotb+Co0pLV/OHHP6tAFSjccnfHZ3Qyuw71PddsXOoFQgnQc7hc5I99qTWpfTROpGWxs5zNdCDwoIzaYXQ3ZqZE3vVN7AjNvYsN+AP5WSrdq/1SXxFfyR+4axrdaCnJjshpT+zxGxW7+XlrdITpGKcLKDCs26lZXMj5Rhjej4VTDuA2VA0tMw4gc0gxr4RwnEBeIZT8fs06LUoNz1ZhZTN0pJKqdC7+0eqsgi4UCn644tWkk+65t5H6t/xmBzpXSEO7n8jNeiHo1XaZ9fb8OdtYJsQ7DXcHXsct+Ze
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4316.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(366004)(346002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(41300700001)(33656002)(8676002)(52536014)(4326008)(8936002)(2906002)(5660300002)(86362001)(38070700009)(9686003)(478600001)(55016003)(71200400001)(6506007)(7696005)(38100700002)(66446008)(83380400001)(66946007)(54906003)(66556008)(66476007)(64756008)(26005)(76116006)(6916009)(316002)(122000001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MY7oQ1aueiPWvQxjsOWyrS6mOIeDqcPJ7Pq4ZNDDjjasbdBAX8HLH99Dgzzo?=
 =?us-ascii?Q?3gStugfEXxag4L1WDlNvZ0ZeBSii7/BRmgZ2DT9Lv0RnYh5zm+88c+JWWXZd?=
 =?us-ascii?Q?MlLJcJ6VgbBFxtE1SFWZeQ56YSm+KBtLzwoUoVR2fsCYqIt1zDT2bbu/RiE1?=
 =?us-ascii?Q?QshplmcqUYic6Kof/jDTmoXYzqYiO1A+8J/sUN1+RyjcD2aEO3up0X2JeCFL?=
 =?us-ascii?Q?SmA/iPQ0VmuopaKIl4fEIUhxzfgFcoTelnSBAb47qlTvloHdqzA6KRLNmad7?=
 =?us-ascii?Q?3jRIlJcBMJtVXWxnJD14JSoK28EAkb9BZsW4SA4hqBXYKX5+o443UcEzKfhK?=
 =?us-ascii?Q?cncm5buacOYt/8/hFUiF5emTayqmR6xbzQ0G1JVjY0DHo3fJWtU/LpiYm9sE?=
 =?us-ascii?Q?GBhoSEAfEN5y0Stnu03qGPWQ+8i7lS/6YxbRL2fmZZ+O4H+mZQVtNmzPIYYy?=
 =?us-ascii?Q?EUuxuke7ggOZ/zneFAl3W42ao2EULMGzfwmg77fO9Wij8rz0Ozg2Si+rZR07?=
 =?us-ascii?Q?WPpj8wiD5zITdxYZaKKMzUe+Mjz5Xd6MdZeFPqPcp3DjGDILLFZr/+9yuI6e?=
 =?us-ascii?Q?QHjxs1R8xv+DZ6h55KKQXabK2wfDQm+waxVQYEjhu/DFkVifOr+1UtbEa1qx?=
 =?us-ascii?Q?g5qIUfysLWxhAzHcMs4g+kZXRX+0HR5W2EvvIV4tdehHqZT0Jb3l2I65IPR+?=
 =?us-ascii?Q?qXq35p0Dtc0GdCNZqIeF96hrynYpDo9EniNo0mjCEuvMXvlVuRnuWUER7jYc?=
 =?us-ascii?Q?o9nhufceAERaQW3nDqq2mFunvphtvBdzbfFC869xdiDt7JCsdYlVIHGFEdu3?=
 =?us-ascii?Q?1vXDL79YM0OGNSfFIx8ZXvfz/gTdSRCvPd16uFKpYaR5gxjZlndK0RWMgrn7?=
 =?us-ascii?Q?Pm353vDXDcMvJhBeoy2tHkcPbKVA0eB444I2BEtwkzGiWoTtVYlvMUmTXmw/?=
 =?us-ascii?Q?BEPXoszr84Af2rfcRM6ZRMMaUMhD4pgzt2h45LPKfjtK9Cxy6SDLcL/7J3+B?=
 =?us-ascii?Q?vQrzcB8xhyuKa3KmqsTWg2J9/at8VjfU/jaKKpN4ATuKTY4/nOXlDj/BxhvM?=
 =?us-ascii?Q?MUqbrU1cXcvh4j0pbJq4HsShaaaYot7mTp1OBS7a2KbZc/d83p0Q3dW3emOK?=
 =?us-ascii?Q?MFCNjBqkzY77824l+ud3YCD/uaTC/Lsac+mocqyFaNyRHjtraHlxe0XNlFBW?=
 =?us-ascii?Q?f3DsFZaGwS7K3WA3G81oG2zUWVTNCf3xesmmOFCx3t8S0pJfDQr2hAeTeVjx?=
 =?us-ascii?Q?ZfRzu/8mNwl7lKWJaPHvxPfBRoMwDjuNHEXdZd0HelKFp3oVWSh37SKgoAQG?=
 =?us-ascii?Q?vuNH6JJR8sNLa4nSrmY8mCvSbgYh9frwDk3UcnhI3VtCmmpruQZbovBi3x2K?=
 =?us-ascii?Q?qKcgO6/xiyOGzo16+9OmBF+03+tjK91si6GYESA8gM0B5gJacCxnz+02ClFW?=
 =?us-ascii?Q?xRyyAv14l0XuBLD3zABT/2PujPVEaySx4WjIa/UCfRbYaNkwou7mZdKpSJdN?=
 =?us-ascii?Q?QP4yJCAKB/liJlVye8VAXIFjjCjlJ6Wy1bU7vCbDWrudZbIBb+Kpd+oqZtyC?=
 =?us-ascii?Q?acAmevN4QbSSc+zpfUuItXqaC0yxv2EGrDUMe2eu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4316.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8aaf86a-4090-4bef-a241-08dbde892490
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 05:28:00.8139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X45jIXU14IA3Mos0EGPARyn1Aqw/VgxgalgXpoJPawjZ5gtD1KV0ApXplgUcJp7F7Z+7S6NULrRAVfVWqNYKIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5586
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

> From: Hans de Goede
>=20
> Not all LJCA chips implement SPI and on chips without SPI reading the SPI
> descriptors will timeout.
>=20
> On laptop models like the Dell Latitude 9420, this is expected behavior a=
nd not
> an error.
>=20
> Modify the driver to continue without instantiating a SPI auxbus child, i=
nstead of
> failing to probe() the whole LJCA chip.
>=20
> Fixes: 54f225fa5b58 ("usb: Add support for Intel LJCA device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Wentong Wu <wentong.wu@intel.com>
> ---
> Changes in v2:
> - Small commit msg + comment fixes
> - Add Fixes tag + Cc: stable
> ---
>  drivers/usb/misc/usb-ljca.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/misc/usb-ljca.c b/drivers/usb/misc/usb-ljca.c in=
dex
> c9decd0396d4..a280d3a54b18 100644
> --- a/drivers/usb/misc/usb-ljca.c
> +++ b/drivers/usb/misc/usb-ljca.c
> @@ -656,10 +656,11 @@ static int ljca_enumerate_spi(struct ljca_adapter
> *adap)
>  	unsigned int i;
>  	int ret;
>=20
> +	/* Not all LJCA chips implement SPI, a timeout reading the descriptors
> +is normal */
>  	ret =3D ljca_send(adap, LJCA_CLIENT_MNG, LJCA_MNG_ENUM_SPI, NULL,
> 0, buf,
>  			sizeof(buf), true, LJCA_ENUM_CLIENT_TIMEOUT_MS);
>  	if (ret < 0)
> -		return ret;
> +		return (ret =3D=3D -ETIMEDOUT) ? 0 : ret;
>=20
>  	/* check firmware response */
>  	desc =3D (struct ljca_spi_descriptor *)buf;
> --
> 2.41.0

