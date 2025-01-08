Return-Path: <stable+bounces-107926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC70A04DFC
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 01:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BC821626EC
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 00:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACC31C32;
	Wed,  8 Jan 2025 00:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PflE802c"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1856F4A08;
	Wed,  8 Jan 2025 00:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736294532; cv=fail; b=SPJE/1iWfUKAbGCDlB+47A0GGRxvRhRK2+B7wR7n0sSYKKMAF8XruKBmSw6ik77lmtZkPuttp2shYHgoKccnVpaxOOHkEHX0bnipAXH6r/3y5WcrepxBJTYjud1+Z5IatAgf8NoKB3Bv6ZtzxymyRfjs04b1106GYG7jlQQKNVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736294532; c=relaxed/simple;
	bh=yeqmrhIVp0THJQZe8Rs0ZLpiHIfGNSbua+rgtFtdRqo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cd4xvzozvElzPhzOJwfYJmdEo1ibm5G7dY33qHpllkcrji4t2CuvecrNPC4S6RrBOlU6CeaZEF2OeNjkzd1w8GYRPUbBWsMsSEcCq4FfxQGfxvn7HTn8M7U9p3RNvDlisifKJEpMNh9OB3c4lcOOoMp6TiIcCzldU9krplU3lbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PflE802c; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZtdwsOCdV9dByeUyALnJUSJrylKqk/FjL/ealeYW4u+oIHueEqM5+8eNqW+JaaVgnYUOaebch1jJxT+64Q0hRn2ighqkrtoenM1gcD+7SWjaJA/Xm+ca8hzpGMWK1mZybcjuZm9PWpYa8aTm4yzB8xVshCcbmbt7TDZRGGOmp9Rex4O6jh9xdl9McOyLTO32XwgIKsIum7QK379T42AET+t2r+vpU3IIBZ4ZCbedVnXVQCL0Xz7z5JqcczzVFGwRuS9aSsvA9EO9LL8QwVujRHSrsB6g6wtqNZtP+JC35pxFRGyoTuXnpS/IbzUg5gfEn5cxA1IYEuGMRV2xlTMDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOfKnXCViGaiQWT3ZxdV35afFbb/m3ft/+ad4YgtB8Q=;
 b=ny7fXrnKa1SG0saNWo+gzZRwIygG03Ood6uyx25E4PKccDug4vwYOlomDNO7gUelGkYeEE5PMBzrUjvwGFkgwK/omzfJbWpJxP8rLQ8ycmFInTmW5TnA8tRiiLzP5eG7NICzmV+gGRg5qH85bOa0cS7u+ZMTTqVuJZX39072+NiklBQ23bczG/eQgrKlVtuMCPda12Z2CXgJbmSH5ncp1GX35OUX2Cz84g7H8peZYmTc+FhLPblc7+esKHO2fB4lNSC4+kf9uiyAJJR6FUdc7vtauMaOm1v7z6eRZvAy4wxh6s+hMhYdKLTKjF5s8n0KYyZCPtB56cO0pfWS9w/wTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOfKnXCViGaiQWT3ZxdV35afFbb/m3ft/+ad4YgtB8Q=;
 b=PflE802czi3ez/JbNUR6UgcSOqF1eDEnY8vH3KNqTbYphGT7DODnGv+E1qkBfs+9dpr8tMgM4o7Qgmg6RWYf0b3hzJCkfyHB6rXeDdkgaL+5mSEnMGIbT1APOlZUZsgnoliR7f66Ke8q04ITnaIKn3MOxDhvuHfv31zsWlOm/jE=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MW4PR12MB7015.namprd12.prod.outlook.com (2603:10b6:303:218::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Wed, 8 Jan
 2025 00:02:04 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%3]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 00:02:03 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>,
	"oushixiong@kylinos.cn" <oushixiong@kylinos.cn>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Pan, Xinhui"
	<Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>
Subject: RE: Patch "drm/radeon: Delay Connector detecting when HPD singals is
 unstable" has been added to the 6.6-stable tree
Thread-Topic: Patch "drm/radeon: Delay Connector detecting when HPD singals is
 unstable" has been added to the 6.6-stable tree
Thread-Index: AQHbXXhWNGAsQLNmlk+RljZozxDQrLMMBehw
Date: Wed, 8 Jan 2025 00:02:03 +0000
Message-ID:
 <BL1PR12MB5144226AD0D6697DBF25ED56F7122@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250103004210.471570-1-sashal@kernel.org>
In-Reply-To: <20250103004210.471570-1-sashal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=860eb3e7-39d3-4fd9-b97a-4645a28af9c9;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-01-08T00:01:18Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MW4PR12MB7015:EE_
x-ms-office365-filtering-correlation-id: b590942d-8626-4327-f350-08dd2f77aee0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dCSN8GnL6iyxM7HvVVlu9X4VbgtPRrNyIjOISyWRoqaozr3yur+tTVpBMoNa?=
 =?us-ascii?Q?1TPQTScrgwJNCSuxrcKfiLxZUjBHOU8Jrh1jyUxvbeKrutiNQQZVhSZbHZcW?=
 =?us-ascii?Q?4WBflEZ9OkjnrbCtD3t5fw3PQ8bF5gSKOmHDpW8OVUJvBRRVnCG4NiNUhJ9G?=
 =?us-ascii?Q?6TAJLO9AF5i8nrc1AC04RWv0Xckn18OHIpKtV6w9EmNWvOGRShR2MmkSofBm?=
 =?us-ascii?Q?vfhLpwEJKPv6Rrv07qwe6GqTWbT5hOBN93WiCFs7dlM1J/yS0jiMFPq0zyb2?=
 =?us-ascii?Q?zcYxGyzVhpKEFMc9k/HC5KYLLR82S/WaXT4jxzNvZw0Opl34+CHn+/iEmUeK?=
 =?us-ascii?Q?YPwg00xY8IytPIOTaeRskcLnWB2T82ytkEvCXjRuqsqDScrVqg9ODkE8KY2R?=
 =?us-ascii?Q?DFVzdrwZgTcIU5Dn6EA/go4BEsPH6NtZ/fhbw4AUFXBwXnI/8eXo0wLgafGK?=
 =?us-ascii?Q?vvwuzkDuCo7f4ED89NNrGppw03gOhKKtH3H/gLaNd4PycVNTWrE9eETcDjf8?=
 =?us-ascii?Q?09Vh6zxDjIF3ncXXMYzALr9IXw0NTEU/l9+kklii5yZmLUurXFtmmbLq7n4Q?=
 =?us-ascii?Q?CV+H93sgVx0nXS2Q0x7SCsPkNC3y/rzCn4rBmQUbKX6j8p8P1PXKlLrQViJW?=
 =?us-ascii?Q?7okpI/30hl7ugO6qQ2TfVRh3WpqHbUK8K2UFCcutSYq9XEMRttYUcJvJpnYi?=
 =?us-ascii?Q?UbCL1qeq/msLU7DuZt9AB3aQhHlmxHJFaV7z11zOExbqmQ4UsWQLVDpq3SfS?=
 =?us-ascii?Q?WmGibIL8W2yTPMpBOV7VvoO35M3QsLXNX0q/4X355E/64CgrGSsn6TGNhEuG?=
 =?us-ascii?Q?Cm9bej1XJIKnwrwadkZhODuOSgTjL6Q0qrZUx65gUhYTvkkqvhdk7lgy5kJc?=
 =?us-ascii?Q?kOabwfU1Gl3gsqVn6bevUSHK4shJI9kmC06dMFP8uoPTPQJsxRuiaYDS25QJ?=
 =?us-ascii?Q?ZpiKBp9fcqRh1UWn3AQB6Ha16Jvb5Ek1XqYFS2tQS4KOtZaX8h+iltqgJd2I?=
 =?us-ascii?Q?xBLo+HpTWd1TmySscb+AqNQO1dUQ1m1ssLJzFJxX7PUi5Vc2ZJoD4sCASHn5?=
 =?us-ascii?Q?IbW3+30jOSR02TF40XbwxnJeIBJwhxFwVA2K6BG9NAWbgTcqnYxnja0C4bbE?=
 =?us-ascii?Q?8DYsR0J5vSRDR6ewUsq/0s18y1szv6DN938IuPYP5V7ioo/tB5PoqnRNd5iN?=
 =?us-ascii?Q?0GA77kL+c57CsUBwu5gU8VEMCwJzyX9Xl6jGJyhU/E4uINtbvy6y/pMH4DZI?=
 =?us-ascii?Q?Sxu/72ykxGpL0Y5L2ZDNf7W3q7YDs4ERHZ8NN66tgvgVH1YtHjdiwaIM6Wl2?=
 =?us-ascii?Q?IKIIMGBO6nu44Bkn+fWSz2mAolci9vEz/Kkvy+1F3hXqoDpo65baRIwXP4LS?=
 =?us-ascii?Q?oKzTiFm/XZG3WeChpnjm2Z2YbE4isRqG0KDMDIOKSDHaf+HLEw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LUOLLfbA/ZxpxRYsa7WuyDyUCVi0XXkkw6Ce6TpQjfL2IpUEruhvklvFbxra?=
 =?us-ascii?Q?WGZHTS5fi8COGrb/AVErqjw5SuSJCsi+VsedXRshzcVwJQ8HnvFzMCcy2KIw?=
 =?us-ascii?Q?D7ER8GS2F8/iaa2BtrazwaxrfGcG0AibbcCdeOv0Yb4YR9Mc7bP8S3ssu8xu?=
 =?us-ascii?Q?2PHOXUAd2+T6nTI/RljrnYhq78HR/VA2AzCdObkHhMK+/81V1SSZSpERl0aQ?=
 =?us-ascii?Q?96rijoP712D666k3toeUcbE60IKYVNBC7/eehScUL038MNoRoXBmFGXj1m1m?=
 =?us-ascii?Q?VkPqWR6esmtP/dmCuAN+FDG4k/0EUjpyye/IBVElUoFc/0Im0WtNjTHOY5uH?=
 =?us-ascii?Q?3sjhvmP64jQ6o3JgKQcvTUBjBkbes9UNyg2Oh2KBlMgegK4sSEYJxDLxEYDU?=
 =?us-ascii?Q?Tgkcv8sIq/t7lw0WR8zSYWGgl2A7XaoZKnJ6PZ67t9GeTraE5vTdnUpfgKKE?=
 =?us-ascii?Q?/JQKdOFTabTuCEk/lvSLFaehzTxV5CQF1ZoN6E9WUS2W+2gHXoQh7LTsosOk?=
 =?us-ascii?Q?FRR3uyLKDVd/nws1BgHmgAWIYHEDbiBl5DR5Ox2EjeZ6HIQmxg/1fPDkKfSd?=
 =?us-ascii?Q?OvlEk3f35ztYWTHp5HGGF4WpaSVwPPlsQoghP0/dNLxZ1r0V6Psly0QUe4bW?=
 =?us-ascii?Q?HuUJDUmL68zHjvOO9YUE3tzK6Io5CfrN7o5FMsTMGpGvQtrNxu0BZWK3SQk2?=
 =?us-ascii?Q?KIMy7OhAbr8BLCfziFw5dkqKtqWRBlvqNB/XGRmkHMKxBcD31DqeaXQnM5HE?=
 =?us-ascii?Q?Xnv56wKIxpwii6lRBLToIqAopwRe4sxYW/eCtLcR1lgBsC3cil4CfY7JIyzg?=
 =?us-ascii?Q?51Am5ebITnbNFqKAE0rx56aw+w9afF6EKvCuHqUbAP3tXzV9Oj8HhwnGAz3c?=
 =?us-ascii?Q?uaklahJlsreoFfdc06w9RqIkwpZKnMpVJdy/gQAdh5kgWRyXnffkSGiNs7A2?=
 =?us-ascii?Q?Mq1F4TTeUvPS3TXWdDhhIU0uldAWSXqHepFoiVwLqXPqMWZf6duDlsw7AYEp?=
 =?us-ascii?Q?gfqrTv8d2MIvXd6VmjmXwe/riXyiUF4cwAPCjdtNyHRgr/jcy2mjY7qx9Szg?=
 =?us-ascii?Q?pIPOVifRL9gwg0Z/pCOcAFbaCaxsA0hMpax0RnW7mi/wF1Hw4Yz29wrF1/aV?=
 =?us-ascii?Q?3yF9htmTbOrtZ0pXGeTYdPmbFCGViHQeOmK3NDCRfEdVlLozE22yMQA/cq6l?=
 =?us-ascii?Q?HskpTdp2K+6CZ4FGiEvqceEAPfnangFtfk8Da0g1L2h4iYh59sdWq8uzN9Tw?=
 =?us-ascii?Q?HYlMKuksp7ozqSnxB+pdFFAqjsf9W2CRCSIv9QBPpIMcbOuQhi5N73x3/HYZ?=
 =?us-ascii?Q?qXgmemnOx/F02PtqurUMC5RgXZ8FUdSBYk1Z6RIvLIcYIvhEArM309/MKxg3?=
 =?us-ascii?Q?f/PD2R7Et3SjIJmy6csQBzVhi/iFuVeevMbvANoBcu2mngbK3PRWVh2S903o?=
 =?us-ascii?Q?yoGw+yljLW3VkKcALHKfLEv+b2r1F2/kkiTQQmHen/z8kFF6XF0Gi+D6J2ak?=
 =?us-ascii?Q?nblG61EWcXkI1GeYDDg0rM9oxo0KYCT/X5h9OnwPhlIO+y45F6UlgI/LtrkL?=
 =?us-ascii?Q?h2kj5Gzo7+QJiZKqtgY=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b590942d-8626-4327-f350-08dd2f77aee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 00:02:03.7640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ib/GolAEEaUuJTazAhzHiXr5hdWmeaaXdj2eudCdpAQ2KbsdeJAeLHLyUOcfjt+3qPFnmlqqGGobCM+O/ehYZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7015

[Public]

> -----Original Message-----
> From: Sasha Levin <sashal@kernel.org>
> Sent: Thursday, January 2, 2025 7:42 PM
> To: stable-commits@vger.kernel.org; oushixiong@kylinos.cn
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; David Airli=
e
> <airlied@gmail.com>; Simona Vetter <simona@ffwll.ch>
> Subject: Patch "drm/radeon: Delay Connector detecting when HPD singals is
> unstable" has been added to the 6.6-stable tree
>
> This is a note to let you know that I've just added the patch titled
>
>     drm/radeon: Delay Connector detecting when HPD singals is unstable
>
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      drm-radeon-delay-connector-detecting-when-hpd-singal.patch
> and it can be found in the queue-6.6 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree, =
please let
> <stable@vger.kernel.org> know about it.
>
>
>
> commit 20430c3e75a06c4736598de02404f768653d953a
> Author: Shixiong Ou <oushixiong@kylinos.cn>
> Date:   Thu May 9 16:57:58 2024 +0800
>
>     drm/radeon: Delay Connector detecting when HPD singals is unstable
>
>     [ Upstream commit 949658cb9b69ab9d22a42a662b2fdc7085689ed8 ]
>
>     In some causes, HPD signals will jitter when plugging in
>     or unplugging HDMI.
>
>     Rescheduling the hotplug work for a second when EDID may still be
>     readable but HDP is disconnected, and fixes this issue.
>
>     Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>     Stable-dep-of: 979bfe291b5b ("Revert "drm/radeon: Delay Connector det=
ecting
> when HPD singals is unstable"")


Please drop both of these patches.  There is no need to pull back a patch j=
ust so that you can apply the revert.

Thanks,

Alex


>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c
> b/drivers/gpu/drm/radeon/radeon_connectors.c
> index b84b58926106..cf0114ca59a4 100644
> --- a/drivers/gpu/drm/radeon/radeon_connectors.c
> +++ b/drivers/gpu/drm/radeon/radeon_connectors.c
> @@ -1267,6 +1267,16 @@ radeon_dvi_detect(struct drm_connector *connector,
> bool force)
>                       goto exit;
>               }
>       }
> +
> +     if (dret && radeon_connector->hpd.hpd !=3D RADEON_HPD_NONE &&
> +         !radeon_hpd_sense(rdev, radeon_connector->hpd.hpd) &&
> +         connector->connector_type =3D=3D DRM_MODE_CONNECTOR_HDMIA) {
> +             DRM_DEBUG_KMS("EDID is readable when HPD
> disconnected\n");
> +             schedule_delayed_work(&rdev->hotplug_work,
> msecs_to_jiffies(1000));
> +             ret =3D connector_status_disconnected;
> +             goto exit;
> +     }
> +
>       if (dret) {
>               radeon_connector->detected_by_load =3D false;
>               radeon_connector_free_edid(connector);

