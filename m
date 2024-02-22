Return-Path: <stable+bounces-23297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 670D185F27D
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 09:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53DB71C232A7
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 08:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8489F17BB7;
	Thu, 22 Feb 2024 08:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KwZmjHbQ"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB3F17BAB
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 08:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589382; cv=fail; b=UZ+yoyO9udWx5JyweIqRobMCmp/uyNRtG0QTEPIWdXK5cFwkU9pEM8nfKi5tB0HXLKAqnucs1rLiT+B5fkqvYrUWe96l9uoCmTaJLrd1hkkpNitvTE+2nOLwUGrs+jv90eCv7AP0dXnNyxemr+BhAXZpJynrGGdU2usumNqK5dE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589382; c=relaxed/simple;
	bh=Jakj/fCmx3jg8CKw3U/fmlTRvWDLimriLM7n4+VOtw0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ffSFBx0fZfiMbcVttOnlDZOy27qk2RwZLI15zPeslch37ms3TE64SkadOetB76F+mR9ZDVFEKG68H5npU9pUlVjY3n2aR94rDkYZqwpZSjPf1gDsep4MOPg+tD/mnTdYZBfKMfOH2VPe22ICnBNg0nJd7m6lVW+g1yj0wvodDtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KwZmjHbQ; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGonPkarby2cGLpk5LrY8NyjzSWCCIXTLPqwDsXJlKQdHiU1u57rcLhIktkOQ4oy31wsev66OxoEEI2EWde4PEb6lH28FcqYmKGaaKvkhhIj9sotLhkQbdAqfUbnYTlCG5qRY8WIre9qmMLeEF3nr1XcCrjC3rNs+c9qN+T/6NEh2XhKecfNMz4gTbq2pA9YB+x7ZqgQNQrbTReEDUjFheDqRbwzqvcHZTbRjPjJxRZWlsXOEGKYuflhBJ8Gb5GB6n/C4xhVMMp4+6tkLVQRPO4hdmPBZNb3/B4FzbSIt/JHPRtD1gML4+tVzf7DmYTY2dghCb5U857j9e4sXOnHqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMwpWr+zPKwWtiG7616fIlgXMQwxs75+gG6P6I1kdZ8=;
 b=kvL6JNYK0gPI4BiqxkGOFuLWywp08eDRGXsGIoGzUTC8LgfEl8T+8xUqRM0e5cVD6Tcb3TDvXrHAlzKLlF8OrC24kTlwZLQmcpXdx8rAmVf5bOZZOd5Ah62/v/KwJbQ1wKvLwa81VW+eJGJwblxngcP6tPvMiIQsr0kp41VA5c9ZzUhy8rdVAAkIi7pZb3+9EKZVflipJV4gdQ4E8XmXqxqn7Nrs35m8GZPwoXZRAHlnh+c0RnDwlpGBV7FMIneZt34LtZ9uAmibohcG5I9HzudEEdqfA4SWKcy2TpAMZKpB1W/5PurlrfDauYxWquIm9vZzZHzNzf7nqxq1GTCfjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMwpWr+zPKwWtiG7616fIlgXMQwxs75+gG6P6I1kdZ8=;
 b=KwZmjHbQN0hP9BsUnNA7Y6Bhp/0YKcPzRHA46Ta0shZmjQdLrmw6RqsY4YHM58KGFH41KHiebxvn3A9AktQL2D9wjRWZ3XUwr1fuOZSGGqPLMwrIjbSrTMHp0S9VQ5OqDoXAoS5f9c1ipzzFvMLKHvd002USZ5DdW9Q4hwuxBEs=
Received: from MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 by IA0PR12MB8745.namprd12.prod.outlook.com (2603:10b6:208:48d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Thu, 22 Feb
 2024 08:09:37 +0000
Received: from MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::3508:1efc:dcab:74bb]) by MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::3508:1efc:dcab:74bb%5]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 08:09:37 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "Mahfooz, Hamza"
	<Hamza.Mahfooz@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Pillai, Aurabindo"
	<Aurabindo.Pillai@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu/display: Address kdoc for 'is_psr_su' in
 'fill_dc_dirty_rects'
Thread-Topic: [PATCH 3/3] drm/amdgpu/display: Address kdoc for 'is_psr_su' in
 'fill_dc_dirty_rects'
Thread-Index: AQHaZWZFSSbFHx6KvUuoxPqrV47ZV7EWAiMw
Date: Thu, 22 Feb 2024 08:09:37 +0000
Message-ID:
 <MN2PR12MB41286FFFFABEF80DDD3D69FC90562@MN2PR12MB4128.namprd12.prod.outlook.com>
References: <20240222080746.732628-1-srinivasan.shanmugam@amd.com>
 <20240222080746.732628-4-srinivasan.shanmugam@amd.com>
In-Reply-To: <20240222080746.732628-4-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=02d65066-c015-4c34-8deb-68ba33ae1c0a;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-22T08:09:33Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4128:EE_|IA0PR12MB8745:EE_
x-ms-office365-filtering-correlation-id: 549efedd-a53a-4461-e7b1-08dc337d9cef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 bTemHQXisBOA84yA0h4YdMI1+ODPzqy1YHvWlpw+ETtMJCkpqMtczoToTCacKB1OKeFaO6GiEFjM1S1wrwRqTOKKxyDdwF39d+x1bK3bEBREg8Zt8y9APTnpxTyRdLMPNaTNN+Cm7xG6SQUlG2m+HgHLnox0hsQmyURy+t0GqHobjJlmTG1vmyDunYpMwUszZZBFzmFuCQ83z+fsN0+VqnIeNcqdbejQVslE4qIN301hXZhRkRMoOwzLApA/w+FGsAjsgFeR9zHdDljJqLcfQVBiw2kiQcQhnO6Dg4wnNq7044HKJCl9CEUJDafyhTFHDWVc4QbCynqilYty+0MP4bSN2y78M+3lWki5k6x1hxjQCUbnSTanD3GBV0toR2WxIdLwfMcAlSDshQ1yBk5mNShUgTXxRhgJlyWDBtSKgIRNMFTPrikoAo+AaSdtvevtIOulNFZCEtXwDNw/+p0MEbOwxm5wyDmj3HSEMRDTytrtFB36KtCIpf12KEvy9gc9/XUUXIXpt/SlKLDz65DpWefSn6+BlE3NtjNDIImbH3OiikToWo/t4NB8TV3nwYQ8lAbe+q6aD180TjLziNH3z1ttppKbxP4asw1YDHeQRk683aehtMKNdeh7fnIc39QD
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4128.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LH109M8QFqa6J+xd9w9PINll3TT/nFFPVfzMbtBUQu0TRDqRZjd/eISUkAXk?=
 =?us-ascii?Q?DLXqN6XvDQ94JjuhfO3MWAeMQJYljFtFuzneJu3RG5xerFh/di3Dhw/qX3VC?=
 =?us-ascii?Q?qyEA9gIvZKt2Oo88Vuc06L1Bo2rJnLoojGJqo1khF09n/SoCUYgYbClbkeur?=
 =?us-ascii?Q?/KVHGfPM9yRZ7YEJUjiT2y2JVl544kBXhc3xgUJGSMLqQI9XPxnY9lb1V8XU?=
 =?us-ascii?Q?lZ+zON7JobK/gIWLCuR2VQ7ranYxWpIK8WyTwkLWa7EAKieTKyDu0ZmsyzI2?=
 =?us-ascii?Q?IdC4Cq0zhXt24A1y5YTFS1s607TuyPdLbEJ0ZWUffxSYESRLn/lRYuBOCiv2?=
 =?us-ascii?Q?w53QU9sxJm8ztyOaF3pLVIfYK7EB/79gn71IAzRopyF0FvgQG7Lhiclz88Wr?=
 =?us-ascii?Q?imi7oqPI/tFVY9y8tFBZEBGoayYuKz7H3rmjF67FP3XYrD08Rc7VVtC0X5yu?=
 =?us-ascii?Q?JsdIS0MPPURbUCwfglMTaa5Wxe0GbfvEIdP2FrPIuLVMartLA5W0uIkMAgDn?=
 =?us-ascii?Q?Ri/q42n5LWx4Ge2qOwqk5R9SXuHp5XZynOir9a3f8ZzOxvK5GD6N0087J2jb?=
 =?us-ascii?Q?yqR7UmrLAt76aTWGOUYc5fVC2Jqf5IR5QWkZxK/ZsDRUlF+nDDodVCK5oA54?=
 =?us-ascii?Q?rChu/wSEQ4Vc91bwN1MDjLiG0y+k0pnQwqNaCzSvAKJBvacWN+9DdKxKvVIw?=
 =?us-ascii?Q?RBlSMPHpxOCa+1qa7jARQ7ldd4buqrIs6eblCyaXjw9dRuXleaJUt+6+yw6g?=
 =?us-ascii?Q?CyQLTY7WN1FRZwJRyIcy3/j513bGwRPBseOue/ZxBAKqacAjkeXVInzmr4VL?=
 =?us-ascii?Q?jvrkn9jqDGp4NUnu18VSNwR6V37yNVQ++pDMAH4a9gv65O4R6kmIujB98Fz/?=
 =?us-ascii?Q?E6e0doWT2AWIUNrvfk9JZ3kkcsGFlu68ccEUd33tg+6cc7sH2Ji0cM52mQ8K?=
 =?us-ascii?Q?Og03Tf2fwaQO3QvjqSYrLfw/6uVlx2MuwqMcKpsUeVzMnZfwKFm8itR6IzCK?=
 =?us-ascii?Q?9ox+XRBelzVH+BKzSlJXgmh9xaQFOJjbF4QS4Zt1jOcXgKUnHODJqlxEV71o?=
 =?us-ascii?Q?LtnACqi1QNmK/6sFRFOE9fJ7zyJSshkVoEHEYGiEEsy/IbbrByahDSOxy1Qq?=
 =?us-ascii?Q?7LQtmsxt6IcK9T0rjaPomM7WiQFy5qkSS3oCeXgFzH2Ta4NIXF4/7dq/EFnO?=
 =?us-ascii?Q?aziUGtEVmb+v65r98p+YJobOAsnwwgJOgJ91pQ3L3O9erSInEn7P5jAx+jLA?=
 =?us-ascii?Q?OcC+CK6/eErGS8wPSDtx57n/jmyhuC6XMdjqU9KHfXYLQIRlH2cW2eRsh7ip?=
 =?us-ascii?Q?wdpIWojiySijzERKnmzXHlCJEMtGDO1qdDGPSxwvSTss3Yp2xhrPFzQdjY+c?=
 =?us-ascii?Q?/Mw7Si44tfLHp9cSaU6C9PD4Ll1JZ6XpUUATFhyl9Vys5TCK7ajNK+Tx5PGr?=
 =?us-ascii?Q?T6rDJom7mJul2tLMG6A/uBMSadxRB5A2U0h03AwSgNCk7HQFQeC+EQO+HFJN?=
 =?us-ascii?Q?7dWEG8pgdQ3c0vCNoTeeosLXCsuFrlcC4hcz7kNgQZTR2hS6/gn32V1FCNDS?=
 =?us-ascii?Q?9ZVXDVwo1cEPNgB3T88=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4128.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 549efedd-a53a-4461-e7b1-08dc337d9cef
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 08:09:37.6084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gG+/TxvjrCfFPdkUYlFzr4PiJsIENIOFttm5ALs72qINFZrQXymTSIZOvPoTyBytxywjBa1vBsJFRfcYx8uuEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8745

[AMD Official Use Only - General]

Sorry please ignore this doing this for experimentation of creating cover l=
etter.

-----Original Message-----
From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
Sent: Thursday, February 22, 2024 1:38 PM
To: Khatri, Sunil <Sunil.Khatri@amd.com>; SHANMUGAM, SRINIVASAN <SRINIVASAN=
.SHANMUGAM@amd.com>
Cc: stable@vger.kernel.org; Mahfooz, Hamza <Hamza.Mahfooz@amd.com>; Limonci=
ello, Mario <Mario.Limonciello@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueir=
a@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/display: Address kdoc for 'is_psr_su' in 'f=
ill_dc_dirty_rects'

The is_psr_su parameter is a boolean flag indicating whether the Panel Self=
 Refresh Selective Update (PSR SU) feature is enabled which is a power-savi=
ng feature that allows only the updated regions of the screen to be refresh=
ed, reducing the amount of data that needs to be sent to the display.

Fixes the below with gcc W=3D1:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:5257: warning: =
Function parameter or member 'is_psr_su' not described in 'fill_dc_dirty_re=
cts'

Fixes: 13d6b0812e58 ("drm/amdgpu: make damage clips support configurable")
Cc: stable@vger.kernel.org
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ed4873060da7..379836383ea9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5234,6 +5234,10 @@ static inline void fill_dc_dirty_rect(struct drm_pla=
ne *plane,
  * @new_plane_state: New state of @plane
  * @crtc_state: New state of CRTC connected to the @plane
  * @flip_addrs: DC flip tracking struct, which also tracts dirty rects
+ * @is_psr_su: Flag indicating whether Panel Self Refresh Selective Update=
 (PSR SU) is enabled.
+ *             If PSR SU is enabled and damage clips are available, only t=
he regions of the screen
+ *             that have changed will be updated. If PSR SU is not enabled=
,
+ *             or if damage clips are not available, the entire screen wil=
l be updated.
  * @dirty_regions_changed: dirty regions changed
  *
  * For PSR SU, DC informs the DMUB uController of dirty rectangle regions
--
2.34.1


