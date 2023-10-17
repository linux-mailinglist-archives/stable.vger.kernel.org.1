Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1ECC7CB8D6
	for <lists+stable@lfdr.de>; Tue, 17 Oct 2023 05:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjJQDEz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 23:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJQDEy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 23:04:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26678F
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 20:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697511892; x=1729047892;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=4ll3KpcSqIt1r0dso6Yp+rkv+ZpgmZSo6zrmstyD8UI=;
  b=ICDetNipYslqpAAa0M8x3dvQNuv29X9Y0oUnavT7rpBW9hnUnglgPrMc
   ZUMsklB/LZJkwRdlbWeIZgcC7Fj85vKP+pT7FnUdf1lKyCVk2wanv6Dt9
   xSWTzegGHLY2+ASZJQo5NfDjJNoY0f8ZLl4OHZuf8D724HTJ7Vd51Lx9q
   mR8qhNL/TV8wjwmZbvWN4YOuu/D63Yi68bpe+mYO80m72bQGBJNH6NEkc
   +VOl0e2NgwlFsbb2aAFgWtc4mFskDIzpBK381HDfUSApjhhmev2iPUXjE
   fenoUGtz7OURb0k/cDosUWFOqXxm8OH2toIwzSUWHIBO18NNWCb2fHd6r
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="7252827"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="7252827"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 20:04:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="846649822"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="846649822"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2023 20:04:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 20:04:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 20:04:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 16 Oct 2023 20:04:51 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 16 Oct 2023 20:04:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYtmNJ5Kayp415nhIj/KmJcEvpavN5UpStwbBaCDaSS0mUlZ8eAKkISdSZWEPD65NgCxpiVECAbWQggw7SwwO0iiRjP7jjvdqg+siXsFgiAVhKvmgVhI6vYZYhDBs3bfKFW770E3kLTWaW3KuESsAGjXEo51hQQQmAfa+rZvWkWyghKfNdjLEzzdaUccW4iRgtdEXY6CPqiV8S7hJptRVBsAy+Q4f7JKsn88g5ebMpnJqnk97Jb9YRPWq+X90rdfOPkqEt/r3rTLxgXuxg676R4moZYm8Dri2WoA7Z1Wr8x9ZqTTnv50jrTUOg2d+ikAl2IJIkEclK4Xhf2tDwZvBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ll3KpcSqIt1r0dso6Yp+rkv+ZpgmZSo6zrmstyD8UI=;
 b=gp5U+AdKWIAXztaKKekTHRznU6Y7FF4v+Q6dBZx20ftC0RJ/soHlaFx3+dWK1OHXsZ06x8kXarET43BMG7AsTXpAaYZAkZ2dklmMDf52HdH7U4IytC4PnTaTSR/RFB0/xZKoodqg1Aktm+ix1Mf7iFwIBziKZLm2pGfjBJg5Jy0i+S7hLVsqZmYzjTgTXjckdArbQIynSIMTcfgoFpB5BPdRu1FLhR7wdjhlJtaJ7feinr5TYe3soVDcog+mj71mSuuqzvJLDt7zI0t97pFGwNnAuK6z4If/KhJAT7zm7tCkB6EaSrIQQeg8itoxVrB2TWG+wdKF/kCiKHGLrzF/8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6217.namprd11.prod.outlook.com (2603:10b6:208:3eb::16)
 by DS0PR11MB8162.namprd11.prod.outlook.com (2603:10b6:8:166::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 03:04:49 +0000
Received: from IA1PR11MB6217.namprd11.prod.outlook.com
 ([fe80::51d:bc87:609b:fcd]) by IA1PR11MB6217.namprd11.prod.outlook.com
 ([fe80::51d:bc87:609b:fcd%7]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 03:04:49 +0000
From:   "Abdul Rahim, Faizal" <faizal.abdul.rahim@intel.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "Song, Yoong Siang" <yoong.siang.song@intel.com>
Subject: Backport Submissions for Up streamed IGC Ethernet Driver Patches
Thread-Topic: Backport Submissions for Up streamed IGC Ethernet Driver Patches
Thread-Index: AdoApkJgJ6LZ90QJSFi/Tln0YoM3cA==
Date:   Tue, 17 Oct 2023 03:04:49 +0000
Message-ID: <IA1PR11MB62177F23133378DB62FA49B5D7D6A@IA1PR11MB6217.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6217:EE_|DS0PR11MB8162:EE_
x-ms-office365-filtering-correlation-id: 8d89a165-f68d-4743-19d5-08dbcebdd349
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jGeDUaOgfzJWvFVKDcVJy5HVvPmFGM3ixZBmvF0qtS1PlQ3CMIpwtib/y20t2HmDc0MGbo+xX5vNw3oP8a6G3pogXmwfSK5cyVavl1waDC7BgGww/IZZDAD5xhp6ZtUpZV6pzyy01QOJBT5ORy5JtVTw4tVC3RB3+SAAmc2DTfdpOePlfkpVrIs+QYPtSmpMfs9hPfWnLl31gY3+qjWeQXCeq43t52Z1oHSRpSxfsDRLBK2NscyN/JivbnpsBZ865nOs9Q0QL2M9eVRt9DA6Y0GUGaipEbbUHEL5yFxpTRD/mYE0IiyOStg/UXZETDnNqGYmjZJoSdt4F2CR0QknN9twoDSq1HpoQIAAjjEDyWcve8q0gZ40PibdUmtiTG+ili7c1aPJRaLo+35EvX2kPrXgsG448ZQR9PWXoQB9raQh+7omS6XD64LLRFOhy7M7s3IW58lmYuzd4WQSdipMi+ev/KnRwXOOsPTOGkbfJKF1cW4UBwRC7lGP2/MpaX4WFGbbLkIRZwVx3Fx/Mfz4cAkvOSz9KJPqI9lD2WRBYLGwdsYFyxYAwwRibyEXUcTPgPWOlR7Ad0CaO/i+iURbSq8bl1Yef0JWiSPOd6GR1oMqIC9O3AiRf78bKqRCXhCP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6217.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(376002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(66446008)(66476007)(66946007)(64756008)(76116006)(6916009)(66556008)(83380400001)(316002)(38100700002)(33656002)(2906002)(71200400001)(6506007)(7696005)(478600001)(4326008)(8936002)(82960400001)(8676002)(26005)(41300700001)(122000001)(107886003)(38070700005)(86362001)(55016003)(52536014)(5660300002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?em92DAKJStza5VqtX9t5RGxi1RvyucZXz7ZJtpfjbT6KPuOj3lwKBVhICj/2?=
 =?us-ascii?Q?IwaIfuiVbN/1Vmc7zNyWdhKlzXrO4Gh87ZGGEDDfYU1fOy3mH5XcI+8t5gx+?=
 =?us-ascii?Q?N0csbIwHv1OhxvQjG985t8k9T/9w1CCPXnXwKW3jJ3nJXAotDHxrBiJqiQYN?=
 =?us-ascii?Q?3TouaPW3CrYdANoqx5bpxebFnOumyY7XJSjtSIWEGxy2BvxOx3NpophEyWYn?=
 =?us-ascii?Q?2Gyia/qvWKFKYB7Sb202+Eqk47DY8QclD4B6EMCyoeOWTLLBzGjstfZoiKfT?=
 =?us-ascii?Q?xKfjBjs8orUlj2CB6JD8VHgy0okqkwZug4GaKhUkRUGUtug9YRjvEhYzi+l0?=
 =?us-ascii?Q?y3tb+GbYUWQJZl+YgX0lAYX1GXYSZ6uOkiMJlhmfxc+cnqpE94inQlVvrB0e?=
 =?us-ascii?Q?1IAKfmMd2LX0wUJ6Rf7vKiIz8l5LaDhr9bHJKfQHFlzWDX7mhhrLH3L+fFsO?=
 =?us-ascii?Q?VTaJ0FiohsADFod8h/SVSpoZJAdhtnawPureU3GTF+Ni8RUtzgcs93MjOBgU?=
 =?us-ascii?Q?hY8kQGnu9g2YB7rqE6A8xh7StoSeleaBvox/D/fBOGkMnev2NMOxXYCBNs1H?=
 =?us-ascii?Q?Y/GxY/yu11IYXHDDl8ViAXKNRPc7Oyf3/dmHSJMgoKzZqifuBkpFA0965BZZ?=
 =?us-ascii?Q?d3F9WS5eYgnOYM0XAkGmDWFeobEFRHdwCbOeiVcz6jF283ymp4+R6eHbEX8S?=
 =?us-ascii?Q?FMT3Ww/T4oXVa+B+8MjzipalDPP3vVzoNEAluaWJujQJBxjzjRsa+AP2vhTQ?=
 =?us-ascii?Q?fAuMW4Rc2Ef6v6uRuXZEltivOPE4dGf8VjaCndHGF690zl+p7UQqT6mmEezx?=
 =?us-ascii?Q?OsjBQFVApVzgEovONYQMQzLpTRysjhYR4aYkqWEHK7YQXmMX7NxWx5di/Kef?=
 =?us-ascii?Q?DE1KZ5tHal7eKnAek5ieauS04E+m1nZSOd708w1Rj2Py5YAc8G7ov5xU5aiu?=
 =?us-ascii?Q?6utzVIEjqN3jAuwqyKbfC7UFToJG5DEezrozmU5QmRi86gIIiqx+kHesJLKR?=
 =?us-ascii?Q?7HyV3IiCLKnHDNb3tgnjtcm5e5kFWVBY/HVdXKEt7Hw9L848JjrHl4ZkiAFp?=
 =?us-ascii?Q?k6+aO950R+WQEUdKqlahTI45PQW5JcALxpJ6fCjo2FOqylUBk++8uUY1QMOx?=
 =?us-ascii?Q?by1x1P5CGoRbH06U5nCLlEPz/z3O8SX3fRNSBjnafGVIAJg/n8HPoybLWkol?=
 =?us-ascii?Q?spO75lA4bAqpD8nU4MGY7X4kIaKhRsKoMkEo3SFMAINyyDYBOTLQkTsyJLN6?=
 =?us-ascii?Q?X6yWGGurw6h9yjhH7deTvFyNl+VrbE+TeTgsrJFW0xO/flbS4Xqz1Y5Sevmk?=
 =?us-ascii?Q?cInia0VFfi4WliR3tliA+iwXUV7NrJnMyM4kQMoXzOB0MiYoVG5cRo0qeYJJ?=
 =?us-ascii?Q?2cmglF5eysaOyf//4Tz6CiMv7Zb86APMYAXsBI91UGDSxKrUYi760PiJFBal?=
 =?us-ascii?Q?1loIgXzntK3FT3Vk19+uvv6+gyrYEHCVKd02FxTfJMrS/IIcDZ1EFX8vg0M/?=
 =?us-ascii?Q?W06qmhLsuqz+KTkjaSlwDoUX/w48HppSbtrIViSI7ZrZRrxeiMYxAGI/c2Bi?=
 =?us-ascii?Q?bu9zlNg3RR9SanEFgGTP01KwaCD0FaOuSVb6CytWHQM0SW6W2vFBewfbvS+n?=
 =?us-ascii?Q?oQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6217.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d89a165-f68d-4743-19d5-08dbcebdd349
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 03:04:49.1484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9U5e2Db7si5DhPN7EIhNeGcCYB1rHsQCXE5/cMGGNcsgZUH5lbvi3ZDzDLe/2mexlNLUrU/oZAP4AHFCxX7UQ9sNwDDSR+ZhKN/6gY4XdZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8162
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Dear Stable Maintainers,

I am submitting several individual patches for consideration to be applied =
to the Linux stable kernel v6.1.=20
Below, you will find the necessary information for each patch:

Patch 1:

Subject: igc: remove I226 Qbv BaseTime restriction
Commit ID: b8897dc54e3b
Reason for Application: Remove the Qbv BaseTime restriction for I226 so tha=
t the BaseTime can be scheduled to the future time
Target Kernel Version: v6.1

Patch 2:

Subject: igc: enable Qbv configuration for 2nd GCL
Commit ID: 5ac1231ac14d
Reason for Application: Make reset task only executes for i225 and Qbv disa=
bling to allow i226 configure for 2nd GCL without resetting the adapter.
Target Kernel Version: v6.1

Patch 3:

Subject: igc: Remove reset adapter task for i226 during disable tsn config
Commit ID: 1d1b4c63ba73
Reason for Application: Removes the power cycle restriction so that when us=
er configure/remove any TSN mode, it would not go into power cycle reset ad=
apter.
Target Kernel Version: v6.1

Patch 4:

Subject: igc: Add qbv_config_change_errors counter
Commit ID: ae4fe4698300
Reason for Application: Add ConfigChangeError(qbv_config_change_errors) whe=
n user try to set the AdminBaseTime to past value while the current GCL is =
still running.
Target Kernel Version: v6.1

Patch 5:

Subject: igc: Add condition for qbv_config_change_errors counter
Commit ID: ed89b74d2dc9
Reason for Application: Fix patch ae4fe4698300 ("igc: Add qbv_config_change=
_errors counter")
Target Kernel Version: v6.1

Patch 6:

Subject: igc: Fix race condition in PTP Tx code
Commit ID: 9c50e2b150c8
Reason for Application: Fix race condition introduced by patch 2c344ae24501=
 ("igc: Add support for TX timestamping")
Target Kernel Version: v6.1


Thank you for your time and consideration.=20
Please let me know if you require any additional information or have any qu=
estions regarding these patch submissions.

Best regards,
Faizal
faizal.abdul.rahim@intel.com
