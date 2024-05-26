Return-Path: <stable+bounces-46256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1EA8CF45F
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 15:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47035B20D5D
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 13:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFD4DF43;
	Sun, 26 May 2024 13:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HbWtGm2C"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91320BE5A
	for <stable@vger.kernel.org>; Sun, 26 May 2024 13:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716728819; cv=fail; b=iMbXOsYHhCbCAnjqM24L0BkAyQONt4FZ9lPJ/dvytsl+5AyTXzO/9hSG68s9Xp5AddPj/u9YnSkqp9XC9O+HnPWkMrjDVZI97fO7hrbDP+O/hKaMDyhMSh9XxAj4Dl2OFHhiRlKgaNOvvWnY4kJJsWO0+qKeAcs3J8mTw4m5ZXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716728819; c=relaxed/simple;
	bh=Wspiz8VmKr+wNYRRIiF27okvIB4pRY8SY8yKWSHu4Pg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KQvTpivzMeqDvmgskiPQVVOKcZkI5tvnAKMkKzhXVJOf0YuRyYyO+YlWQGBryXNmxY4OwoDO7SBr1tzbh3ndfVg1y9qwjwX/plxN3/Tqgiyt0k3pmaQqkUsxA+fa0nE/ATVLAXClWS2O1qFWa+0e+GEPtdbgrhcUr8UoBPUd3Yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HbWtGm2C; arc=fail smtp.client-ip=40.107.100.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqUFC+CVgQxTABom5OUPcv5RSfLjpZzJ+HJK/zV50kp0VQgCdOA552FIERrZKvli0cY2srLWYQX3HmPzswleUPJBGcXlmLwtAmU6MsCuxioJOeGdEHAvmnEISXqP8j+xl2qvAIWnOMPYbozuh5MwtrjE/B8CYHOOKgvEXb9ROs5AIf48J8z682V9u8XAtg7T+D6u2a5jDfDbdPLXgZ95/Pr5t9oM8I+CJIXvJgnDeZT2GHwa6PdmnFAo2Dwix0OCNd11n2or3pl1l6YSoH5w2gS8m3etJMonPWpYZJ/bC/lZizL5ly10UN9wRkYaRhU2LTsmcQk4X/iRFU2OkI/4hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpRXB6NrD3QhzPnx8ZOIMuM35Ty7ql0R/E5MdR6J1XQ=;
 b=QntKCv4uT2sraEOQu9+dObklMOlkHDMs0SSq9eXSi1BUfjRsjtTx/zC+1pUsheFVzpnha4Xs7q4xSYNDqkB3s03omTE8onUJ8uV5sGXUep6SLMHj0Z1SSJj5lvbF483SDTIPPVq5JXIEU5a8kImUaK9PS5VS8t5AQkaR7ihHk5jaD4Aj9n5K+weQFRzawmS/hNTZ16S9MFZOuuOwWMEQsJkvIgHihpZ/qf56/C0J3J6RBLx/UY/MV70f67d45M3Ow9VYppqvN5PWMssPoOf+Qh80IpiE3vEGJ2O4FadiavJnh3rJXYi6Q8FhcNtt5rS+RrubtGc11hLKBxH2juChBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpRXB6NrD3QhzPnx8ZOIMuM35Ty7ql0R/E5MdR6J1XQ=;
 b=HbWtGm2CYZp900y7rcKv9hL0gDDrWSTND9nU5Y5M5HbmT2zhRCbxT+IJ6Wlmu58jg1PEBc1vIaXlKnFIGLusWsARYCMfP4NHGvT8r2MZxBqqU2RDD/rcN1ZDc3uw040NfIeuHpx/56KWzeDJh0qJdfgN49M9fBV4GANT0Nbodt4=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by PH7PR12MB7354.namprd12.prod.outlook.com (2603:10b6:510:20d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28; Sun, 26 May
 2024 13:06:52 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7611.025; Sun, 26 May 2024
 13:06:52 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Limonciello, Mario" <Mario.Limonciello@amd.com>, lectrode
	<electrodexsnet@gmail.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>
Subject: RE: \'--?J;/.  [ [PATCH] drm/amd: Fix shutdown (again) on some SMU
 v13.0.4/11 platforms
Thread-Topic: \'--?J;/.  [ [PATCH] drm/amd: Fix shutdown (again) on some SMU
 v13.0.4/11 platforms
Thread-Index: AQHar2yRb7A2ks2KTkqd2KtnQ9LqArGpfElQ
Date: Sun, 26 May 2024 13:06:51 +0000
Message-ID:
 <CH3PR12MB8074FC7EE68B00ECFA17C22EF6F72@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240526125908.2742-1-mario.limonciello@amd.com>
In-Reply-To: <20240526125908.2742-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=174da9bf-abee-4ea2-974a-08b663f42df9;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-05-26T13:05:32Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|PH7PR12MB7354:EE_
x-ms-office365-filtering-correlation-id: 7a683528-8461-4652-0616-08dc7d84b5de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?+WWBkNxTY2igXr0BHK6BajLWfZM4GC5We18uBcqGdLpkIgHkTR9iLwtP8n?=
 =?iso-8859-1?Q?M9G9MJZjSdEvU3FiE35Oi+riAUGeukaOkcHApEAf5CiM0JtfultNOr1Yvc?=
 =?iso-8859-1?Q?AcBUmIpiN02CKGqD1PtWtGqIkfQvE+GUMfXu8R+vQh0IH8YyFO2XwienWw?=
 =?iso-8859-1?Q?hiVJXthIJCtM4ZdNBlBSS180ZHFplvYAmlzbkc/axwAHx4DIq+Oph+o4AL?=
 =?iso-8859-1?Q?ax/TO8qTQxdRI1ZNI3F4jRJYwiR+dUvfVZM9opMpwPuKgA3fFtW93Lmccp?=
 =?iso-8859-1?Q?eWEyVGLRkjwWZGn/OTucOppYNe/zU7n9Zo1AdlaPgrcVrJW7+Qyk3coVzB?=
 =?iso-8859-1?Q?XSuzBQ6//LquFr30PV8L7jn8uYZKSHfudiHnqkMXZkGZXlQoPyhZ21m963?=
 =?iso-8859-1?Q?nklg2lOX/IevwxVBx4rBKmC3rk0eyvNrLDrjhtpc40BbgETPf2yRh738q3?=
 =?iso-8859-1?Q?/gWX3duMulEQMEcAghdzGQyaFEj4jnWGQYBtqO9VujVXpIL7PBVP8sThDL?=
 =?iso-8859-1?Q?yNE2bpsiBCFKf5KCwp9atzAkxngCJWyvnvkg5hHIfAyYjk5Y4OSwr4luah?=
 =?iso-8859-1?Q?f9Ru401eEHZykmu20/PYE+kJ4UGsuxATGMJSTaV2heNRUpG3/fS2BzWxZx?=
 =?iso-8859-1?Q?XIbtinlRNc/qNJz+vvF3fBdZD54ilyk2mssr7Z2Ld3LmIjxEuYTXtQf0Vw?=
 =?iso-8859-1?Q?144ZUeQWUZRT99PBZXCaya7nME5YslDUm616ALJH2GS/UWj0ywmB+brDQI?=
 =?iso-8859-1?Q?WHut7Pb6dt7s67TijCXZh0pAfx1Last4Pq5Bgw4vW+mtncPe6hThvhOQzQ?=
 =?iso-8859-1?Q?IqwjZDUpehmNMxFpScgB/AY9wXIv6xh1el0VnQU+f8jltM+q5Vph7SVaa4?=
 =?iso-8859-1?Q?MsF8GVnEGhPtoPh5ilY6UMsQPrsKU/SyCfcPHX05OFlr6vzvAvPzXQu/Cf?=
 =?iso-8859-1?Q?eYhrxbDXf8amZUtWJKuxpDz/RE2SxVmG8/FmMIMYmnTjic59QSqWAAW0nS?=
 =?iso-8859-1?Q?Hm/mg5+rRZyrd9ZodgKJTpa41uZKbbVX3KBzgRgAarXnpzqDAF4fIJq7ti?=
 =?iso-8859-1?Q?c+KeAF7FNDao5UzTxHw6cEsGgKV8q/aKD8ezrgJxi4I/U9PxtVue127tEr?=
 =?iso-8859-1?Q?xUhIJIic9lqTbFDG0LHJUIhXzLnIHkHi+cIv/odGiYdBwtn27WQxkInMqi?=
 =?iso-8859-1?Q?XpOnCC0tbPNUmSh3vWkkJHShfwp9VbkH09FF7Et+xEeOy4rfLdHnAM7jOi?=
 =?iso-8859-1?Q?gmBoq373rCL7q01dhfR65MXE1p0B1nLUv7V9zkV5bzRS/9g01Hw9kvcBrI?=
 =?iso-8859-1?Q?o+T6tLnOH8h0DveXyHhex2OjfQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8074.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?JdzeU6FHAgZObfdniszMiZ03Lmd60KQhUY1AkzET3ga6yaR8DbGobm75zI?=
 =?iso-8859-1?Q?UUIjjiZ3IC5L1LbjAkMrX61QkL0T8yd+/6EAhAW/fL6JLDlbvifh6s+56B?=
 =?iso-8859-1?Q?Zf/CQiS4LngyaZCoT+/dF780/jJhQWIcTHmgaZYWSSFZYxOe1ICwIQfnkI?=
 =?iso-8859-1?Q?bnhQOezspE9GML+XJzkKy3EtFVhNrkPF/MXaTFK6blcNcsarFGzxZnJ8R/?=
 =?iso-8859-1?Q?NHTKQLbBvC7kh8C3TH6BZwOI7W8ikB+udrIpB1hoTxMcrgCODqu2TBJSlt?=
 =?iso-8859-1?Q?omrO3Qe6/8huFfVnrztM6+DF2xJ7kgp6TTVyOg8pcqkekBjJjBj2vuTxY4?=
 =?iso-8859-1?Q?suaQmBiQ14TMjVhpXfLcDyUAdtDVMRiq4YdPyCTp8HV7PriXyPk41oLkTc?=
 =?iso-8859-1?Q?cBNCL3VrbunhlK1cP4gCVFwevafTOIWi6kI2L6iXJ3ErQRK2qh5R8fE6l6?=
 =?iso-8859-1?Q?M7hlnIW7Rul+DoeSy4DnoI5xd6vHPg1xVL4ENUThLoRMwFvFL4xPMFl2co?=
 =?iso-8859-1?Q?NW/Otc+XDVOxSY46IfCmi/o6+FnWXJPPPgCb+oqcM5vMjMMEKiSExquWBa?=
 =?iso-8859-1?Q?2QaYHQP5EGb4aNpf6zJdpnkCqh3thEA+71uPk6cvsW9qA96Uz/1rVkX3pq?=
 =?iso-8859-1?Q?1ssWQESspLA1K6izml2kYXSafwaubKva7UgFB8YSvP0GMp4nyjNf2DO9Ys?=
 =?iso-8859-1?Q?gxmVXoBfP7CgO1GHVaUuN/4GhwKmloz4g5SdS1uCNJqDpaRolXAd4jMViU?=
 =?iso-8859-1?Q?/20LTEYTwrBZv5OKCflHqY4VIh3qOV93oAaCq2lIRHkJw1BKfDsVDQDBVC?=
 =?iso-8859-1?Q?n9Hj+xNfkCeB/0iBVwm3fdtIj8kMAD8j3dsLD582yY+fWbkKMzlCicJ4AC?=
 =?iso-8859-1?Q?GrR18SesT7MlKkLPD6YVZYeFPl2h6o6cE0fW6UkEyH3p2tJjt1aWLolTaB?=
 =?iso-8859-1?Q?r68ceHK8721NU5ntccuQbnwJOI8nsy0/x61oz3r4E1sWFZ/lVoiJhQg//e?=
 =?iso-8859-1?Q?57fciURqP7g1BmHausdrF1VgTzG5YdbHH4jZsItdPWl3MKgZGz6nyWL67P?=
 =?iso-8859-1?Q?pQylLpPUXmRw1x1DpjV/eeDOJyqzloixn/Ku0KkhdeS9saY/x14jMTWEap?=
 =?iso-8859-1?Q?v2sVZZTyategmXNSjvtrE+DxKdV65e9suCoQci7v82JKyhnP+41nRMZRcS?=
 =?iso-8859-1?Q?YTyo0f7CGfpUDIEw/C9oEs7/jCfBbQYFJIBjC93GFv3Ph/Q5frvnCHlvR9?=
 =?iso-8859-1?Q?6xS6G/QlSeZQIhdQ+aL23Vj4DiQ7UevrKzBckUZXtF7Gs/6WSkvsQcsf8j?=
 =?iso-8859-1?Q?sxRRMHFje+E6GHcs4jcegTtGSUMq+KxQHKuBES6P4iBBIvOiRklUOggfOn?=
 =?iso-8859-1?Q?xIq2LJGTomR+1q0l/mCBaGLWSxEtI9YcmX27Xa8fGDvqxJ2ZQhcP02Ql2S?=
 =?iso-8859-1?Q?/GMfmksygY8VNXW7f0kxx4LuBCLCpKp5nIeZTeSthbeI6oQNNyaGwgzrMs?=
 =?iso-8859-1?Q?DGngcP9JoINvyivOomKZg5KH2UD0JzgZOAC5/4GpHFv9/A8aV+5RI0ydsM?=
 =?iso-8859-1?Q?VLRjFD00wo7opDaQQ/d/p+5Lwsb0uzQMqpZ4V5dHdmC4opiGPwbZJYd5UJ?=
 =?iso-8859-1?Q?lQwbNrOgzoqIk=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a683528-8461-4652-0616-08dc7d84b5de
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2024 13:06:51.9619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6x2iuh9hybKIZK96kq/zrGxKOaJ41u7PpLVGwA4a2zN2ywx/bJGi/08cX5TkNStFbWkwy8g0UVgBT7eLFX/msg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7354

[Public]

This patch is,

Reviewed-by: Tim Huang <Tim.Huang@amd.com>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario
> Limonciello
> Sent: Sunday, May 26, 2024 8:59 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; lectrode
> <electrodexsnet@gmail.com>; stable@vger.kernel.org;
> regressions@lists.linux.dev
> Subject: \'--?J;/. [ [PATCH] drm/amd: Fix shutdown (again) on some SMU
> v13.0.4/11 platforms
>
> commit cd94d1b182d2 ("dm/amd/pm: Fix problems with reboot/shutdown
> for some SMU 13.0.4/13.0.11 users") attempted to fix shutdown issues that
> were reported since commit 31729e8c21ec ("drm/amd/pm: fixes a random
> hang in S4 for SMU v13.0.4/11") but caused issues for some people.
>
> Adjust the workaround flow to properly only apply in the S4 case:
> -> For shutdown go through SMU_MSG_PrepareMp1ForUnload For S4 go
> through
> -> SMU_MSG_GfxDeviceDriverReset and
>    SMU_MSG_PrepareMp1ForUnload
>
> Reported-and-tested-by: lectrode <electrodexsnet@gmail.com>
> Closes: https://github.com/void-linux/void-packages/issues/50417
> Cc: stable@vger.kernel.org
> Fixes: cd94d1b182d2 ("dm/amd/pm: Fix problems with reboot/shutdown for
> some SMU 13.0.4/13.0.11 users")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Cc: regressions@lists.linux.dev
> ---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  | 20 ++++++++++--------
> -
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
> index 4abfcd32747d..c7ab0d7027d9 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
> @@ -226,15 +226,17 @@ static int
> smu_v13_0_4_system_features_control(struct smu_context *smu, bool en)
>       struct amdgpu_device *adev =3D smu->adev;
>       int ret =3D 0;
>
> -     if (!en && adev->in_s4) {
> -             /* Adds a GFX reset as workaround just before sending the
> -              * MP1_UNLOAD message to prevent GC/RLC/PMFW from
> entering
> -              * an invalid state.
> -              */
> -             ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_GfxDeviceDriverReset,
> -                                                   SMU_RESET_MODE_2,
> NULL);
> -             if (ret)
> -                     return ret;
> +     if (!en && !adev->in_s0ix) {
> +             if (adev->in_s4) {
> +                     /* Adds a GFX reset as workaround just before
> sending the
> +                      * MP1_UNLOAD message to prevent GC/RLC/PMFW
> from entering
> +                      * an invalid state.
> +                      */
> +                     ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_GfxDeviceDriverReset,
> +
>       SMU_RESET_MODE_2, NULL);
> +                     if (ret)
> +                             return ret;
> +             }
>
>               ret =3D smu_cmn_send_smc_msg(smu,
> SMU_MSG_PrepareMp1ForUnload, NULL);
>       }
> --
> 2.43.0


