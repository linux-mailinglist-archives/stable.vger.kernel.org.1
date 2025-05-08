Return-Path: <stable+bounces-142842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2D8AAF950
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 14:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E15109C2FE2
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 12:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191C7223704;
	Thu,  8 May 2025 12:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fZc6f3GM"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B15D1CD2C
	for <stable@vger.kernel.org>; Thu,  8 May 2025 12:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746705759; cv=fail; b=gT0cUF8KdXrFY6ayHN6Xz3CwMlxBAd5ZZshShC9Gw8UXPhqxyd6mJJvZiq8Ym7wdusi9FKbAgZsi8XM2JDu83qk/Eila3XPM5Sxc/HZqWTpUY/P4q5AyAnEXEbjM7P2gX4t4F+ZGF2wnDEza4I6mYi3vTwRoDDSBh1EbtdlENHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746705759; c=relaxed/simple;
	bh=ZJtMGXHLgkRpB5pxusSM1oS2ZI5x69iif2mfttG2WPw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bqgL6eofe8j39UMXMT2QcyRtg6Y2FvHHVl7ix/ChZlo0A98XDKdcJq+mIyqboO13tkI/MRyX4rkJc9jnHExyvSXK0eaua6PNt+lPyQ/IKoBeP9G9sNMx1jyaNCYxbTQ7zszRjfClqQNcYMUF9FrUlvZXXwjMv2sTYtmas1EVqxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fZc6f3GM; arc=fail smtp.client-ip=40.107.96.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llnvS/qUw/Ox231jgEFap5V2OIX9p0RvPCpMqGxzKY4Or5GBtgs2g/FhU3rK0dYS5w6FjCZmzlkfk2fl6G6zGKJmcwizo+seF2atBLy2v2tUsITDckqwWVRcF7yh43ez4ruBTA5h6oyEDrphB6EUrmMF8Tu3zqg+oq2t1XcwlCfKOvdXIO6+qkAc+XHQSSIrs0xXpwR1JbD1HuxVR6sDnRi0i5jx4r9qBQYJM3WgmwCJc7ad8TkjFZI4LS8xT1cBCXH9NREcyijyhjD6kpzGybUKjgmmGkYxXJAN+63170HjiFpRVMMRNqBoV4Sd8KuIaQ3oF8YlJQJipBm471ZrIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FeNvUtrSw2HwmbVvb4GrE9nW2RBG6qJAiGeDhh2NhBU=;
 b=B/D/9kASRc4JN7p5lmm61x7L1fiLYggG7jj9NNF0/ljt1Cg0aI0ZOtYkdCGmwhuXhZwngeWjDzD8u4+SuSR/Mrl+XDTtl9H1vI3a9Tomx4fbJMlrM4M8GYoi3UsP5MVnHGjjbbuD8KoKa61PisoQJMXUzA95bQMJbrRFE6EmytzEQTb6mG0ToQFaxHS9bflFw6aMv+HjjsVrBNddFHUNQFd2xAjF2hivB9bz97eyV+hgrlfwFKDagbXMvEzez6aZ683YLwfVQxagnoUv4Cz2D4WP9qqM+KjlqTthUiZqLsGfakT9MABS30RfG1pl5ZKAc0K7T6AZTbDqxjfAru7cRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeNvUtrSw2HwmbVvb4GrE9nW2RBG6qJAiGeDhh2NhBU=;
 b=fZc6f3GM6Tz6LVlYHRvFCGyA2D1rKmkKCGpg8KZyJHHdZdfDCEoJkIECaHNkrBwUDIcoMzUwjARjMwTsykQGQ05JPLDnKXXeuxHv/MKCfpIoqLxFNhrwCkF7anjcKVBhmQp9mjhqjT7joIquuFTm/OrLkunu5XNe1Ul3qfrSp8g=
Received: from CO6PR12MB5489.namprd12.prod.outlook.com (2603:10b6:303:139::18)
 by PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 12:02:31 +0000
Received: from CO6PR12MB5489.namprd12.prod.outlook.com
 ([fe80::5f4:a2a9:3d28:3282]) by CO6PR12MB5489.namprd12.prod.outlook.com
 ([fe80::5f4:a2a9:3d28:3282%7]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 12:02:31 +0000
From: "Lin, Wayne" <Wayne.Lin@amd.com>
To: Jani Nikula <jani.nikula@intel.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>
CC: "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>, "Wentland, Harry"
	<Harry.Wentland@amd.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] drm/dp: Fix Write_Status_Update_Request AUX request
 format
Thread-Topic: [PATCH] drm/dp: Fix Write_Status_Update_Request AUX request
 format
Thread-Index: AQHbt1nr3/aHG7++OkeNXsWgnC3TZLPIdQkAgAA2QmA=
Date: Thu, 8 May 2025 12:02:31 +0000
Message-ID:
 <CO6PR12MB5489386C2D4F5D6DC49FF27AFC8BA@CO6PR12MB5489.namprd12.prod.outlook.com>
References: <20250427095053.875064-1-Wayne.Lin@amd.com>
 <877c2rv7k3.fsf@intel.com>
In-Reply-To: <877c2rv7k3.fsf@intel.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=ebe1050c-57cc-4047-bfcc-f3a182462a2b;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-05-08T11:33:42Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR12MB5489:EE_|PH7PR12MB7988:EE_
x-ms-office365-filtering-correlation-id: 83e11bc1-dd48-4232-27a4-08dd8e2835ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZS7JSkVfpRwTKM0tbbXbeZbNqwbTZzHz72c6zfIybjqfZiC0Aw1aTje/lKVq?=
 =?us-ascii?Q?tTgg0KCuL+wv6/vRwCHp8FcLFGcPKD0FlM16bXkj7GtGJKgALhy9lAmVfzby?=
 =?us-ascii?Q?8rE8YRDctKb3T8AIu7QcKHK3H+a06sNbxPF+vXpz1uU7lpPqaXFiohMk/a7Q?=
 =?us-ascii?Q?2cB18WzmdMPqOte6MLdN9mtuPF9EXacG1BapddYttXYLpoCHncWRzEst4mcI?=
 =?us-ascii?Q?K9ODkGr+Ta6Og2ehqR0bocF2Qm2YPUxZnXucCfo+ZOS9MrYOgu8tJ7chnD1E?=
 =?us-ascii?Q?QXrbWnphfx+GBEPH+1gK/HEez6XkXpX0dXV3bRs3n/Z6XTGGCrUYNl0OQa2y?=
 =?us-ascii?Q?ius/b17DcWrL0Tmp4qRNmxEBxeU0gkr8rPMNlz1vjRxYN2jTR0fctQdDNhKm?=
 =?us-ascii?Q?pUvvFxGfsn1xUGfYDaU08Lcw4Eptz6CThC4jgcsCfGum/5wwHuWd+2r6S+++?=
 =?us-ascii?Q?uVzCUZdg1MVgL1wtUbGZm2xe7sk8ddCA+srZhJX7XaJs1K5v7dZJh20A2OB3?=
 =?us-ascii?Q?4MkNmuD3Qtz+5CTEgrkVw2gMqlptj8698jLSL6tiLT/8l67bQeSyfl1tuccg?=
 =?us-ascii?Q?+liBSkBr1aDyilYShzK+P1ydJGBAJz3dYiuOxynU2AMK65V19zdMNeoRXiy4?=
 =?us-ascii?Q?G6vhN0FlAKwoglsg4ghW4/pPk4f9XLltgq0f7VRCbtv2+Esqd1ejkUQwjO4V?=
 =?us-ascii?Q?3kmoGwPD8QDFQE30t+J3O+r6C36mJFEemlo0zPmIc15hjYlhmpofPmpNsvzS?=
 =?us-ascii?Q?dOJZjFlNNUzWaugwY75kiefrYbjlDY/sGHCWLmULiLxTWF5eMwXz746Pejw7?=
 =?us-ascii?Q?bMLaVcVeCFWGxuauxrkY5jDQMrJA0pMOOLTKf55dTPp+ZfgpxFZZFCCW9rZk?=
 =?us-ascii?Q?h+aU+4jpEKzyrVY4x1k7A+f8o8HSCK5EmgPRCq1BJXpUgt9BepUaoYagZE83?=
 =?us-ascii?Q?dN5xmfu4KJ7oZSYRLQcuOQiabptWNJ01OEGITCf7w/5Gvoowg/jnkBTap0hc?=
 =?us-ascii?Q?/1XjqyP2JgBp+AoikkwLBvYLX51QTOUz3Kji0lNUrg1R2fNNuQPxpmgzNA4G?=
 =?us-ascii?Q?cmJ1li2bHt3C71sFKd8QGrYum5bHXsigX9/GNlvDr2xevH+k+zORepox2z1s?=
 =?us-ascii?Q?gg/FMPG0ZrrRGaufinGgx3A4AtsWAgG96/s5ZekqdKH7nKIchqkcifQn0x/I?=
 =?us-ascii?Q?ExhwhL4G89qdgywMMQNauQAED+o7FquKON9QwuFJQeAj/qYG51rgc2HbZxjr?=
 =?us-ascii?Q?U9gLKtvMOERn/Frs/8IR79prDb97C4XUrBC4HPUi1e+nePFg+6VTjyRGr7Ec?=
 =?us-ascii?Q?V+2gm9gr8q7NNxjeaRUZSsGeNKj9jGpKqvGmxHevyUfsT3zKq4x00/eX13FL?=
 =?us-ascii?Q?tkzl31LeV8HDe2PWFsWylNoMbY3GYCRqZ+yHT3ZyiMBOMzlnbGcgat/go02d?=
 =?us-ascii?Q?FXgc6zac9oqblUDzPWyJDCXjKEhnwC4Nuzur96F17w3Ya83aukKy/Fv9wCdA?=
 =?us-ascii?Q?BN2jr1Smm4uQcKs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5489.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Yv1JLeXX1J8WcZ2ks40Kc6ved5OmjTzEd5chAuCI8O0fXdYe60H47UmNJxKD?=
 =?us-ascii?Q?7lWHf6SfrUpmiTUHt0h3xDmmrPRHfsi+/iPGm50kLFwdmxz9DOtWbG2Y2GRv?=
 =?us-ascii?Q?hkfm1Mfe6u10u2NxrXG+u1wgA7Kuz8qWh5Y4QBpWibD3NID2bCHf9v7SMSdS?=
 =?us-ascii?Q?9XUVjMcvOLVXbz9pLVs1ZPqDexCKL7RJSDZrPbX9qxKXh2t3d8hU9rg3pp+X?=
 =?us-ascii?Q?aqTeDqdu8nTa5doAJfLamukCsC9XaH6NdXNg+Qpo/akIAzxxa30y1inTSqaJ?=
 =?us-ascii?Q?EbjcdRc3FVvebJkUj7XYK/Lm9CvlDcpEeluFjSadODvNDJfVKbN6k6YfoiTS?=
 =?us-ascii?Q?tT0ruAK4Qg9KWdWz5wSR0cBTMB+mrMj5r1+r9G/xAVCg6EDqj2BTpx25VYSI?=
 =?us-ascii?Q?FukeRSl6UDn0oGw0zFShN1I+59zT7Q1wEW0DsEY50ZyDR+UAc4j1/ADCGf7Y?=
 =?us-ascii?Q?iXElVN8AdtbFFYM3/zNCt9mnu6Pr5QL7wgGMlFmIL3+vB1jntjFaPsJJ3d8O?=
 =?us-ascii?Q?Ju22KLfDVCfQXyA5RRiaBsenSitHZkCg8yTj8mWnhWmDbnv5YkttxIsv6h9M?=
 =?us-ascii?Q?4zRV+QUksbL0l7Zc49wKY3sERcWGXbG5J560pnrhuTmt3mEoKIUY2BQGLlyH?=
 =?us-ascii?Q?EnyqByAKrkyT+Rj41Sc6AOimFnk7t/vJDmWEI8NRQyObChsD26bHP3YEX9Y9?=
 =?us-ascii?Q?zqKlp26gUwqaVfIdzQurgaWr14u3eCiPehPFpaB6FTrckB160o/C3kr7QwE8?=
 =?us-ascii?Q?YxI7fpZOjQRIqwJ+npYtAOeTF+E1yXRnTvpHkwShfCYv+zE0p6ik8LU367Bq?=
 =?us-ascii?Q?FBMAwbLaUGtFaHnMcowtfm8pAq9EKD2+zxZZmjK9KYUmOtcsxYcu/wc/1nXW?=
 =?us-ascii?Q?3ldxaWToZyNIXlCf/uICyB9L0jlmG12SM70dXzyryofjQ6SyuJV1NbQ6N7jR?=
 =?us-ascii?Q?hWy8uvYH+HDcN6QKvanIlVcQR8p+lES0K5TtqgST07gAd+hYZ1aEFv7h/+og?=
 =?us-ascii?Q?01hTiOPG75ByLlpFKiUOkcB7KWZuQ0Jq+jDX++3U4P1Ea6ynPPb2kTuGGAc8?=
 =?us-ascii?Q?itF/Fq+/QKcU2P6ZyTdXycWu+KBX7DsSOwm/wszQkO/ysW0ODhTuWRGptGFK?=
 =?us-ascii?Q?EFzBIx9+m86zU4lQnTWuvpwbUW4FNIQjMjBpa4uQ1z2086CMQBYje4eqQDGk?=
 =?us-ascii?Q?xFg2D3YqHpjJibTI/epjpqPGUOTHSYhUc7jv83y9JYtSFgsZdOXFGpDtroi9?=
 =?us-ascii?Q?QVcIfhUUApQbkCzlQ+3I87E2Y0XdDcOILNTEl9iL7VbelHnlhACoMkrj7ATk?=
 =?us-ascii?Q?ondiXYdN3AFmSkMPZhf5a8moJfI8tsJybqKafZ33/4TtsmCdTA5CCniy7E+W?=
 =?us-ascii?Q?CH3ahbU/N6oNX5fJiH9pJMu6wWWb7iNVaA8lisIDbI1kBEX26OV4f7XIXM2C?=
 =?us-ascii?Q?yRUUFC4MHskOkgDf7uU693QhygApgFNQM6kKTpBCLVIugO9wZSSNcVU9lNfL?=
 =?us-ascii?Q?s+FEFSA7Ay8LPVazbqut2174HDiZMoDqY5gC8WdLtHZErUGFYWcvkI51eiRk?=
 =?us-ascii?Q?UP5ogmV7Nn7hJI55jyA=3D?=
Content-Type: text/plain; charset="us-ascii"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e11bc1-dd48-4232-27a4-08dd8e2835ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 12:02:31.0695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zHuPIUdtMuvhIqcrvNKiKWd7mTVWNXlpGlQyAb0X8Mtw/bdQ72CdY5io1M0NIZRJMbXPSb+6gAnEkLBZBZnwwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7988

[Public]

> -----Original Message-----
> From: Jani Nikula <jani.nikula@intel.com>
> Sent: Thursday, May 8, 2025 4:19 PM
> To: Lin, Wayne <Wayne.Lin@amd.com>; dri-devel@lists.freedesktop.org
> Cc: ville.syrjala@linux.intel.com; Limonciello, Mario <Mario.Limonciello@=
amd.com>;
> Wentland, Harry <Harry.Wentland@amd.com>; Lin, Wayne
> <Wayne.Lin@amd.com>; stable@vger.kernel.org
> Subject: Re: [PATCH] drm/dp: Fix Write_Status_Update_Request AUX request
> format
>
> On Sun, 27 Apr 2025, Wayne Lin <Wayne.Lin@amd.com> wrote:
> > +                   /*
> > +                    * When I2C write firstly get defer and get ack aft=
er
> > +                    * retries by wirte_status_update, we have to retur=
n
> > +                    * all data bytes get transferred instead of 0.
> > +                    */
>
> My brain gives me syntax and parse error here. ;)

Appreciate for the feedback, Jani.
Could you elaborate more on your concerns please?

Since Write_Status_Update_Request is address only request. Data length
is 0. When I2C write request completes, reply for
Write_Status_Update_Request from DPRx will be ACK only (i.e. data
length is 0).

Is your concern about returning 0 from aux->transfer?
My thoughts is drm_dp_i2c_do_msg() is designed to handle I2C-Over-Aux
reply data, and aux->transfer() is handling hw specific manipulation and
return transferred bytes. For Write_Status_Update_Request request itself,
nothing new to be transferred. I think drm_dp_i2c_do_msg() should be
responsible for determining the correct transferred data bytes under this
case. Or do you expect aux->transfer to memorize the data length of
write request?

Thanks!
>
> BR,
> Jani.
>
> --
> Jani Nikula, Intel
--
Wayne Lin

