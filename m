Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6103E7CB9EA
	for <lists+stable@lfdr.de>; Tue, 17 Oct 2023 07:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjJQFU0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 17 Oct 2023 01:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJQFUZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Oct 2023 01:20:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E443B9E
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 22:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697520023; x=1729056023;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oUNs9kkciP7KbH8MmUjseFpPgtZe7PjDnCWa/0nKSE4=;
  b=SDEUzVfAXV3NoxoNE2PH6rG4uQaLNPpKih8ZEtgkEGAdEzl1OgINfleI
   KZLB7pSjcO+H7Mp/G8fA58T8NT8rpeBAH8tPdwvY0qywpiSC8GVLYm/nI
   e5RQelvC4OImN48eCvcrVpptXW2rgBp1MX5h3UJm8btCYxktLX2eSwdZH
   dUPYh43nVyFiyCEaJhJhH1URDB7DMc+zGUb28JpnbBDmQfB2yMVrcqUKW
   3+w3rvYC3UXG91W2w2ko7JO/PpUnYmIgQwxtvPdg0MtYgtVbHovjtzwdh
   AVvsILRVBfG1ln/P/onlaDj0Ob2ACQMLQpnGotTIB7iXUKWnOJTeGzB4m
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="452179111"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="452179111"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 22:20:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="3776723"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2023 22:19:18 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 22:20:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 16 Oct 2023 22:20:22 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 16 Oct 2023 22:20:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfY2D3LDY3ODLq3dhekEf8Y4VQKkUHHZZCGC72Av/OeCQtAdrM/hVPoIhhbYGe+sJarCxQ5T6qRHen4BeH5f7khFcjoxl9tmE0gTyGdo7p04Nlm1gS3tLyUIUJVcus6locLrJUk1B9Wg1hjFVNz0GfqjFyLjIbpfisuJ8s46kGqx+c+AJspUMK5cMRN7Kv1oFe3nkW2C/27G2ozWsDnEbum40FhVHmMtHHQ2/9X+TxQQSTL345szh7vux7gmRn9bfRQI+ZqWbzGOnJYxFp+jerAU7+rO8ZdGQF+WRcie7jpnEdw31AgB9gZELuLcKl0TocaaVbzYfoUO2W/pcLzFjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUNs9kkciP7KbH8MmUjseFpPgtZe7PjDnCWa/0nKSE4=;
 b=aqPfyAAnqQWiAJJ6mM0SnLu49bzV9Jd2KkNDCCXxsCKaGTTONG/awkO6ciTLMLnvMJjsgGhWVz3sIAQzLSqnYYSpi/oSBWQKbPzY0AfUogJzi4anvcOilFBWhqSgR6AVN3VCbjIcPzBkcKp0EvOJ+4lnG1CfdUowUOf0aRis3k4z2xixxRGaB4j/547hj5AC/r4EVXp7fTXHEGbhhriTLykd7Je5bfQT3RABvTNLYNAwp0qIlkhXqt320STwBDd3Lhx58PeAK0He6i2K5eNzHuc11pcgrPdLPDpGuWrB5BF2fKvlYhl5bnZ7x3SXpZdqYozCc94mBx5MkMGkG2hLWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6217.namprd11.prod.outlook.com (2603:10b6:208:3eb::16)
 by DS7PR11MB7690.namprd11.prod.outlook.com (2603:10b6:8:e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 05:20:20 +0000
Received: from IA1PR11MB6217.namprd11.prod.outlook.com
 ([fe80::51d:bc87:609b:fcd]) by IA1PR11MB6217.namprd11.prod.outlook.com
 ([fe80::51d:bc87:609b:fcd%7]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 05:20:20 +0000
From:   "Abdul Rahim, Faizal" <faizal.abdul.rahim@intel.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "Song, Yoong Siang" <yoong.siang.song@intel.com>
Subject: RE: Backport Submissions for Up streamed IGC Ethernet Driver Patches
Thread-Topic: Backport Submissions for Up streamed IGC Ethernet Driver Patches
Thread-Index: AdoApkJgJ6LZ90QJSFi/Tln0YoM3cAAEvW9w
Date:   Tue, 17 Oct 2023 05:20:19 +0000
Message-ID: <IA1PR11MB62174A4F8B9E5D6E8846514AD7D6A@IA1PR11MB6217.namprd11.prod.outlook.com>
References: <IA1PR11MB62177F23133378DB62FA49B5D7D6A@IA1PR11MB6217.namprd11.prod.outlook.com>
In-Reply-To: <IA1PR11MB62177F23133378DB62FA49B5D7D6A@IA1PR11MB6217.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6217:EE_|DS7PR11MB7690:EE_
x-ms-office365-filtering-correlation-id: f9084641-3efe-4dc7-301e-08dbced0c133
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7UUCC75zXDvYXPFZw10Lp8DnFw3BlNuhsNn0VW4bDyJQG5mZIGjx3RF5iMbb6kzqpv6/CXOUvBwwA3Yg+l419WBK5/VMqS3VlNPHSU04n+vgkQddq0rOZsWspq6zICBJqH5if3tq1GGSPOctyew9ioKjaSK5pW3pdJclinddQ2cfqTrw6lxGgmB6IvXeOmMMcSeVfcmztfuwSIKOARHIGGtu8rAe+EfLKSjTlIfklytqdYqmT9VVkKvxKkOaSnI58gT9g+GPAV0pNabZpQldnBJC9qmGtVSl61hKRnlyFFvDxyXVaBq7MnSwEaofBdwur0mOhDbgOp+TE0ZZV7Z0rEFDsQgRkjLZWCS22aaaHOWzVmdYmQSBmmj8/eADdPTdCS1N84Tupkl3wy8lAm7Htdf6U3FFHOpvVNZj3Rb5l2Tu4SmoKBpZUdI3jDbbEEao1QKrP2tizjeTZU8bsurXNoowEnSoxQgc1DR7/Ud4qA/NHZPVz4AB+PUyJuHAnDbnpL0Xpzo+QgCJXhImSS0xcnTvQcZx1NB38pRsL0A+619XNJ7IddbTnFvOp9WM3lizopay5KRAf/7kur7Rim3QMBQMQ12e936lwd7+f7n5qmX1h/4l7ZjE8OpFyoIaAgHW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6217.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(346002)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(478600001)(6916009)(316002)(41300700001)(64756008)(66946007)(76116006)(66556008)(66476007)(66446008)(8936002)(8676002)(4326008)(5660300002)(71200400001)(52536014)(6506007)(53546011)(7696005)(55016003)(38070700005)(122000001)(82960400001)(9686003)(38100700002)(86362001)(2940100002)(107886003)(26005)(83380400001)(2906002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iqJ2K00frqldmGIg+PVkfzBKM7fN727RblD3lQ2QdeAvUvA8oELguidpGSIB?=
 =?us-ascii?Q?2GrpXIDMm5SBkaqPIDSG5+Adr88EbyWuSLlxOtCbIW78pylyIGZ/srCzSdze?=
 =?us-ascii?Q?7+vC1RWbEgr12iy3QpH0Z9722ZJoeCn2Sx3BeC+ukOEwNLj8W0001+w7nxj/?=
 =?us-ascii?Q?Kw8LPwJY5ScaF7ykNA1LNLrXxQ7Swn0gWkJo5i9ZuHHXUsh9xe7s+imcbmCC?=
 =?us-ascii?Q?FUdRfJcBKiLIYX/4XInTXG61z67b0EGmGvoInQ7FfcS4Jjnw679WgIGFz2Sn?=
 =?us-ascii?Q?lqidrcoyrtwfhz9c9iS09vjcPgydtL+gFmH0402AWvH5QhKh8wF9way8Tv8/?=
 =?us-ascii?Q?EZGesDcXzn++7jHedda7e2SOgU2PWRk4kGJohQGkX+g4w36K+RqBtcDSSDJK?=
 =?us-ascii?Q?WZiAIszosAwuAjVPMGMtMPCmIWTVU4aSfzgWEtfI3wblbsCOLRAjAUBWnj6N?=
 =?us-ascii?Q?zXZus7FZ73kJzXOtTOAjnmSU4Ycoixjb8idcXh9M+avcB1SfEk80TjqRYilk?=
 =?us-ascii?Q?ksckuNOvLrGjZvwOclxi63FNLeaeaBBNw7ZpSQ0U91ap9wLnkWdlD5v6wNq2?=
 =?us-ascii?Q?VcqyGQuJP9KyRyP2K/p5RM21+I5bpJDyxEAQ3ftNHJKXOyQeMihfvxNId9co?=
 =?us-ascii?Q?Ig4dQcSOo1zT9vpigcdypbaD15II0DwrbBFhjRqiP+bJkC0pdrrpIc4lVRCt?=
 =?us-ascii?Q?RTvGXSg5IPXLvsAf3lDBaL90H8hDr0mUpTmRGp5V4dmfPHVpIb8+2uswnJVz?=
 =?us-ascii?Q?UzhfZG1Ep8yLtyeVH1LX9QZnutKO7w+NoW/Ezm/LZpIkMdj5iw61znY2/CON?=
 =?us-ascii?Q?yBIvrb/rT9266i0B3oEOedY8hY4EIbZEHKdwEKHXaqpgw2E8xs4J0dMh/WGZ?=
 =?us-ascii?Q?s9XKIZDPC6N6DQjWJ1hzuuc0dUy4bIMqDKFE51gOAXHWauFmN+HcBHjj8kXh?=
 =?us-ascii?Q?wmr1PhNvIPYvoGkrKy4QKeFB1ENDXBnahEMpYUwJ2eQ8SziXSskyYI+bA8nZ?=
 =?us-ascii?Q?XTY+kFPK5yov4rZ4QgNo5xnPK2JOhkeZMzrcKn8qcvFxY5wtVbxG7c0lxlsZ?=
 =?us-ascii?Q?8EozuXbg4nNeRr3jWMwS+NzGicvLlYqiIoTgdvJHOePgBt5Tuya9H9nJyfA0?=
 =?us-ascii?Q?rmdEYedleuLCJm7vRo5EQf1rySdQE5GSe18dALSo+P/GY8OCSlH7RytR2A+T?=
 =?us-ascii?Q?2cXlAqp8Gw/8F6g8NV/BZnUn47Xvb3M+6s//vPAIoKMBba8CnzPAqzwCxGjJ?=
 =?us-ascii?Q?yYZ2YUi+VukCTRUSoS3EKI1Vph3KWAwmMzPUDaQH0bE40LgYoo0L7p0SUXUU?=
 =?us-ascii?Q?CUxIuxNgfxRFsbFGuVANz8A3n8vYPxcNElXdkUXlOttEk8LWaMX8kx7j9/aM?=
 =?us-ascii?Q?tMtZJl3fSPmKDus8mgAOZPAXT2VHvVhx7cj9cXeLfyO2wMkY0anGkyVEpRTS?=
 =?us-ascii?Q?jvsjeoGF0irdD5jLtgJ+PcC0sTJwBjYrWsnbzuEdvRF93jvO79w4RtP6nexe?=
 =?us-ascii?Q?LVuaAIfLmlQAvlehCBIid7P7KsUcdXtH1pMyzvG/P5IZ/pMF+sc+qbGRZy7v?=
 =?us-ascii?Q?uFMosjExgeB4rOWF3bL93XiRc2q7iWxDFiks2YYZ3sxbecH5Th5Mb61U5hUG?=
 =?us-ascii?Q?pQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6217.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9084641-3efe-4dc7-301e-08dbced0c133
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 05:20:19.2426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T5aB6pZTojPpdICc/HZHXR9N2Ihwx4Xh9rGj5QZnQjFtPFJ0HD6+oJOzGMks5q7NThwlmwvMljp1S33PJmqshBRdbcsrmZ68A/Al92EBTEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7690
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

I apologize for the earlier email's formatting issues.=20
Edited the formatting and re-sending the email.

Regards,
Faizal

-----Original Message-----
From: Abdul Rahim, Faizal=20
Sent: Tuesday, October 17, 2023 11:05 AM
To: stable@vger.kernel.org
Cc: Song, Yoong Siang <Yoong.Siang.Song@intel.com>
Subject: Backport Submissions for Up streamed IGC Ethernet Driver Patches

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
