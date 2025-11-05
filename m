Return-Path: <stable+bounces-192477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B8EC33EDC
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 05:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A639189905A
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 04:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDAD252912;
	Wed,  5 Nov 2025 04:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gRwb7SRl"
X-Original-To: stable@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010008.outbound.protection.outlook.com [52.103.73.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB41145A1F;
	Wed,  5 Nov 2025 04:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762316922; cv=fail; b=t7NqK5+Ek2Y2OZPD5+Wv5p/rebl2Yc80GfwX86DkA8CX7GzDpq620Hwx51ApRjm36DBOrIWZ8Gvj7m9UJhQf9Pe+Z2LATtGP8pZZclRixAPVUxNFyofwu3sW0mlUTX7eX5syKZ/jYaqEXMRNvjwRlnSbzPqIgdHkMPnuhmmtMDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762316922; c=relaxed/simple;
	bh=m2hcZMceRG94zYZvYYThdH5ral1nzspj2/rVvfigGJo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AwljV7hn8SENKYe3c22tQzyRot7vFmR1Iew6QZCv5tBcsgeABYs89TsLb2EXTqVaMVRbCaosFdRdB2JLebNzAwkGuzcbQ7+DaBRV0YP27RYNh0EFq3EKbcqZpHuOSj3OXA6ayCstXMjD3cv2reV01MQ/IlL+42DPw2K5wvtViqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gRwb7SRl; arc=fail smtp.client-ip=52.103.73.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=InrBOCzzocm7zxsSeRzd2LKnObqpAQrkIeXy2ZbeURyr9chgfipsOmMd695mJl60zCzO4zJ0mh1efYSAlZY6bKKXZz34Nf4IVKWYPaE6V/F6uhW2R9HKH3wq85XpVAAsuLpkg8YzJyIvnUSCJUGLj/CZplBCPnVf8nMPUq0Fjuj/RXFs1/gUna6l+C7HoFEfgqSET+ABph7KRX7W/Y+y1a3XqAsZFGc2dtplG7JlNeguWgCayODylrxcGin23qNEWLzQsHO+uHaz7FxR84Qea21Az5niVI4XihgbDoshzQE5SfjCAl/LOoG0El2zSlSLqS118Hiu8bx3cEUb19CXtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vly0i+529DxtBs2dNoDlKg3n2JhjSm9NuowqhejnfvE=;
 b=M6A2bVt0s3AVpvuYH23oLr/d09CEOpxlUjEovtxjZ79QFyKbd8zWpJgACMHQwvWsTUgVRgy6DPE5aNAa6DgtJBBgil4QupHGpY3AEkCIrQ29RK7PZV3xR6XMJpp9d8elotNp6wSwldl/9iwh3MqqqoPbPbeGT7P8mQnQCGnJOZLtm1ifBYtSp/J3BsZqWOuowmNodGwbyExsvBjSws7LOzKyAd7zna8HKASQ6CsOsHcd2TGob4bwq5ZbWaDA0ylHQn2rcI79F61tlBef/VufuZzZSWIa3tEyIClxzatTR/cdp2cDm8Lb8vTd5X3feyWwzApS0XTpIFLpM/GQu4PUKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vly0i+529DxtBs2dNoDlKg3n2JhjSm9NuowqhejnfvE=;
 b=gRwb7SRlnijIvT+O7yBbkaipPfCiDD/EJSrL0XtqY/99yp/fd3gENtQCTB8xRVP/rJdgkZxolIfjNlL3X4mtUMxRmMjNU7JARDALOEpCjNvQtk4Mrz9ypSKAMoAUuSIwlMHxYnT5/9fbWJAPHfAik32AUivktc8OJJZjZYbp69yJ5HW32jVFEbYcPJqiglS6drdLZVyPEeS/139wbv0OXiXfpz4DecmFbIQ2SO9iZZVloelPPAwP9qPnhM3V7+d8nteQZu/BbYjf9gbtNOgZ9SCEzXS2vxXgUi2ybcCYUqQYLp9knm6pe0uw37gkTYKsXYfSsEjlQXWzfiDaCt0Siw==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY4PR01MB8168.ausprd01.prod.outlook.com (2603:10c6:10:190::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 04:28:29 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 04:28:28 +0000
From: 222 Summ <moonafterrain@outlook.com>
To: Takashi Iwai <tiwai@suse.de>
CC: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Yuhao Jiang
	<danisjiang@gmail.com>
Subject: Re: [PATCH v2] ALSA: wavefront: use scnprintf for longname
 construction
Thread-Topic: [PATCH v2] ALSA: wavefront: use scnprintf for longname
 construction
Thread-Index: AQHcTA3+16BuVYpr4UWh8CBS9/aT2LTiS++AgAEtRxo=
Date: Wed, 5 Nov 2025 04:28:27 +0000
Message-ID:
 <SYBPR01MB7881D2110FD5E269FF682327AFC5A@SYBPR01MB7881.ausprd01.prod.outlook.com>
References:
 <SYBPR01MB7881987D79C62D8122B655FEAFC6A@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <874irai0ag.wl-tiwai@suse.de>
In-Reply-To: <874irai0ag.wl-tiwai@suse.de>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB7881:EE_|SY4PR01MB8168:EE_
x-ms-office365-filtering-correlation-id: dd6ecb8f-faea-49bc-9b4d-08de1c23c47f
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|41001999006|8060799015|8062599012|31061999003|461199028|12121999013|15030799006|15080799012|440099028|4302099013|3412199025|40105399003|10035399007|3430499032|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?DJBQvyFkF8YP+rk6bJVwy9vYY9tsCokn/XU13Qb13+oueZSpxWbVg6UQda?=
 =?iso-8859-1?Q?HrAnkPMbJfyiBsVP3Kh5uzn5qLUUCKUNGzbLexo3ktl7sXxfVrYCjRIG6L?=
 =?iso-8859-1?Q?N4aiwzQh8dfavdD6n6e/RAqw0FNR2XHbs5zuBdBO2vOaMsFE5m7ijFaDfQ?=
 =?iso-8859-1?Q?j3GRtlJznxEE/y5YIX8Umrd5f/O1kahOn54u1MG5FcnPP3tdzeGrPF5ax0?=
 =?iso-8859-1?Q?fnBh2oYN7/B1EKcm4OTWS/MrpOtcnffi0mfQBGCF29Z0lPply1jVj9MHi0?=
 =?iso-8859-1?Q?4IrTZGcaddbNKP968zQ2J9ne+GeHOt0hge5+67E02gYwxlsGk1vz/qZy4R?=
 =?iso-8859-1?Q?toumGO3PtiPvodj8MaSCwbvAD4AMewTshz+JB8k9LDvmXJRnvp4MWwxQe2?=
 =?iso-8859-1?Q?3Ey1PuDzclPirMXCD2KIV7g9UeT+XY/Xbdl1GlJJ2v3FcSuFr/++JEOo5a?=
 =?iso-8859-1?Q?6gcL3wbf02+waDLhfWBN0mqKG+oLDfOhALHCQRkKJFl6crvpJT+38++Bgg?=
 =?iso-8859-1?Q?IQugYGysiNd8/FQgCnmM52ab02DrqLFN7HNOmEv8A4utpNR6nIR7pw4SYT?=
 =?iso-8859-1?Q?7J4ICakafwLjtPhPe0THFR98P2r36Fkg2TLWjRZjLY1ohiiQhF06jMvRom?=
 =?iso-8859-1?Q?qnmzPBUadhAO/apvrDHUD+2dL4WAGCEpT8/PayY70E5x7YBikyMrfHRt/0?=
 =?iso-8859-1?Q?euMccG3rZ4NpQbIayOi9p3sC3nNDCypOei0pSxUU8udjOZI2mUCHZbo6D8?=
 =?iso-8859-1?Q?5ozJ9AOl9p5S+FWSyuC2udIVf767p2fcpDEl5btE0c6laBnI2RoP3OGmun?=
 =?iso-8859-1?Q?x+f60bvS8J2c6Hhf9TzHhvEtwqFrMzPlgn0noK6SpmXn6whrDbOqICETsk?=
 =?iso-8859-1?Q?1QX7A1t6F1a/9EKvcSvxqcqul1xsPZ1o2E/LvO5eFBQKdxu0mtFLdkAeAB?=
 =?iso-8859-1?Q?qyuf/yRKy5K5NHaQGAUr4v9fROMqJmUlq85ZRfU5wURTZBlRUx2zGrgnIk?=
 =?iso-8859-1?Q?lUQjtQsv+qkTemK7RB8fvh19TBIfA5mK5QnBD69jxZ1jMLahu99xJRDGBs?=
 =?iso-8859-1?Q?39/oTW6piIC+2NM9PCMXBPPpJGhX6iBOPCNF4MtRePRZAS8Wvliw7uuHNY?=
 =?iso-8859-1?Q?6uiA5TKVmlG+CwG/Wokh2ehOYFFoYlXBWTTEVDVMTWHWnRDAFnEaOnbe2v?=
 =?iso-8859-1?Q?aJC3svZERftMjB3GO4cz0S15W5Kuno+cCVJdm/LqhKHz6UYY0vcaQ0Hju1?=
 =?iso-8859-1?Q?hShNX0/oSmYgQADMSCnBOdnRv8LZYQnRc8MqqDD2f5A2ECPlCKc6V+eJ5U?=
 =?iso-8859-1?Q?gQ7I8ahuki6D3kD3SZZvzVg7S0nQu3gXq+TJJ6OCGDbRYyv1AoWwRlLNj9?=
 =?iso-8859-1?Q?Zvs40yAFUYf1N/lVV0PLsQ5DZOOBH5rNRty/yqyhr0Kzv8pp77OOQsiV1k?=
 =?iso-8859-1?Q?rhVzwpLFepJ5esyi?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?36nZGA/JEGwaWWtHcEvFz/9P1l95AkxUmpWCW3TzBdza+urGa0nHqNPFHM?=
 =?iso-8859-1?Q?Sp182S3Szh1iwmyzM0AADMDCriQCuToSQWkWnuqZfOEf/JDCzfClAUL5mw?=
 =?iso-8859-1?Q?+hDmdUKXMnAdlqN+MGZzOs9YZWUtrv6pVI7pVciXIF9lK+d5Fj/QRZ2Rra?=
 =?iso-8859-1?Q?R4EDUDsTWgFO4FSkgXqUHwJbK/dzWemgHsTXpbU59v7VZ6BOwYwq5Mlxos?=
 =?iso-8859-1?Q?NzaKMCCvBYZs03PfH2aRSmhQXyx68BscmR+01GstmUgKZYDlBA1CSeQu9n?=
 =?iso-8859-1?Q?w6PDerI+x4V1dpB95HPYCPnkBHavIJQfGqvWMv5KGhuBGfc9Z4Kiomvn6C?=
 =?iso-8859-1?Q?JUFjXOK8oCCD5ZGNCkhFKt+P8/jtgcSsT1caiumnsROXp1Hr18+bpEW0T4?=
 =?iso-8859-1?Q?TrmjOaywNCGUyEpdLtWslFnMzNG5FPLlhZFR59L8ZQSt0TP5EIiwzCV1yG?=
 =?iso-8859-1?Q?JiS8YLfplfrmgU3wvaZMBiqJ3UbKT9rOJIpcr5o0LIH1oFNznbgMNBxEfO?=
 =?iso-8859-1?Q?dviyutkMQjIhMWOjLMAxBQzadPzUqBehFDfrPIHY1/wgqAQNle0rhKd56a?=
 =?iso-8859-1?Q?bJNopXUViKnZKNvd0sXJmaS6uh/zOqUKwJN9RiJpXhDVgthq0amUAuf1ho?=
 =?iso-8859-1?Q?FPXlE3/BTLG2SxueosUAtb6LuB5r3PnG8hL8X0sZdmbKMpuVT/jhaTyRMT?=
 =?iso-8859-1?Q?T3/gXzkq/M6Y7ZIqZxfjOPN7wVs3+EDe5Gpr8y3fOvISHqaZQlZhhjNq/0?=
 =?iso-8859-1?Q?wL2dYtRVGpGabQFUgmgpIaOf+mEoam3k+PZuL/Pq6Jn0w+O2Hss3RCOYqa?=
 =?iso-8859-1?Q?9KWZYm+84ykcUZxxJAHtwUlxDQJ+Yjww0Bvtk2S7c+cFatsr15GGkekOBW?=
 =?iso-8859-1?Q?peOrWgVKFcs4gQNoM18exNeiXWAMzhDuQyqOB7tVpI8nsMj3WgtwdEzQO2?=
 =?iso-8859-1?Q?j7e1NRrGBGImcAIlBy0oNixkDwTkL0jpvsNA+4y9t/Ne1uQa/E691sIf5O?=
 =?iso-8859-1?Q?QyCXVhIEv9ArUalz3xxYw9J4w88TmzejJmRGQb38eyn4LVSBAXUoTFflIy?=
 =?iso-8859-1?Q?U10LUxP5hApI1FRxZrg4MSu/IJ5Jz+zWeQBFFXwUyQw2eTqOjMvm5D2Jxh?=
 =?iso-8859-1?Q?AF9ipFtvBwT4Tf15AG1LuwMPGw5G5UQuzgndjYCvRQPR8ylizfeEpIvhJQ?=
 =?iso-8859-1?Q?i/DJklN2BoB90pOFb4eSz69HmGGABv2kW9xvAlfmWg0CZ37fMH5ohQuZky?=
 =?iso-8859-1?Q?505HHsRRi24gG1FXXIaXvQ+MBwUCoQbDxuzFBc9wA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6ecb8f-faea-49bc-9b4d-08de1c23c47f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 04:28:27.8696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4PR01MB8168

Hi Takashi,=0A=
=0A=
Thank you for your detailed feedback on the v2 patch. I've prepared a v3=0A=
patch series that incorporates your suggestions.=0A=
=0A=
Based on your comments, I've made the following changes:=0A=
=0A=
1. Split the patch into two parts:=0A=
   - Patch 1/2: Adds `scnprintf_append()` to `lib/vsprintf.c`=0A=
   - Patch 2/2: Converts `wavefront.c` to use it=0A=
2. Fixed the return value you pointed out=0A=
3. Used strnlen() instead of strlen() for safety=0A=
=0A=
I plan to submit this as a two-patch series. However, before I send it, I'd=
 like to confirm a few things:=0A=
=0A=
1. Is this approach (adding the helper to lib/vsprintf.c) what you had in=
=0A=
   mind? Or would you prefer a different location?=0A=
2. Would you recommend sending both patches together, or waiting until=0A=
patch 1/2 is reviewed and accepted before submitting patch 2/2?=0A=
=0A=
The implementation of scnprintf_append() is shown below:=0A=
+int scnprintf_append(char *buf, size_t size, const char *fmt, ...)=0A=
+{=0A=
+	va_list args;=0A=
+	size_t len;=0A=
+=0A=
+	len =3D strnlen(buf, size);=0A=
+	if (len >=3D size)=0A=
+		return len;=0A=
+	va_start(args, fmt);=0A=
+	len +=3D vscnprintf(buf + len, size - len, fmt, args);=0A=
+	va_end(args);=0A=
+	return len;=0A=
+}=0A=
=0A=
Thanks again for your guidance.=0A=
=0A=
Best regards,=0A=
Junrui=0A=
=0A=
________________________________________=0A=
From:=A0Takashi Iwai <tiwai@suse.de>=0A=
Sent:=A0Tuesday, November 4, 2025 18:01=0A=
To:=A0moonafterrain@outlook.com <moonafterrain@outlook.com>=0A=
Cc:=A0Jaroslav Kysela <perex@perex.cz>; Takashi Iwai <tiwai@suse.com>; linu=
x-sound@vger.kernel.org <linux-sound@vger.kernel.org>; linux-kernel@vger.ke=
rnel.org <linux-kernel@vger.kernel.org>; stable@vger.kernel.org <stable@vge=
r.kernel.org>; Yuhao Jiang <danisjiang@gmail.com>=0A=
Subject:=A0Re: [PATCH v2] ALSA: wavefront: use scnprintf for longname const=
ruction=0A=
=A0=0A=
On Sun, 02 Nov 2025 16:32:39 +0100,=0A=
moonafterrain@outlook.com wrote:=0A=
>=0A=
> From: Junrui Luo <moonafterrain@outlook.com>=0A=
>=0A=
> Replace sprintf() calls with scnprintf() and a new scnprintf_append()=0A=
> helper function when constructing card->longname. This improves code=0A=
> readability and provides bounds checking for the 80-byte buffer.=0A=
>=0A=
> While the current parameter ranges don't cause overflow in practice,=0A=
> using safer string functions follows kernel best practices and makes=0A=
> the code more maintainable.=0A=
>=0A=
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")=0A=
> Cc: stable@vger.kernel.org=0A=
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>=0A=
> ---=0A=
> Changes in v2:=0A=
> - Replace sprintf() calls with scnprintf() and a new scnprintf_append()=
=0A=
> - Link to v1: https://lore.kernel.org/all/ME2PR01MB3156CEC4F31F253C9B540F=
B7AFFDA@ME2PR01MB3156.ausprd01.prod.outlook.com/=0A=
=0A=
Well, my suggestion was that we can apply such conversions once if a=0A=
*generic* helper becomes available; that is, propose=0A=
scnprintf_append() to be put in include/linux/string.h or whatever (I=0A=
guess better in *.c instead of inline), and once if it's accepted, we=0A=
can convert the relevant places (there are many, not only=0A=
wavefront.c).=0A=
=0A=
BTW:=0A=
=0A=
> +__printf(3, 4) static int scnprintf_append(char *buf, size_t size, const=
 char *fmt, ...)=0A=
> +{=0A=
> +=A0=A0=A0=A0 va_list args;=0A=
> +=A0=A0=A0=A0 size_t len =3D strlen(buf);=0A=
> +=0A=
> +=A0=A0=A0=A0 if (len >=3D size)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return len;=0A=
> +=A0=A0=A0=A0 va_start(args, fmt);=0A=
> +=A0=A0=A0=A0 len =3D vscnprintf(buf + len, size - len, fmt, args);=0A=
> +=A0=A0=A0=A0 va_end(args);=0A=
> +=A0=A0=A0=A0 return len;=0A=
=0A=
The above should be=0A=
=A0=A0=A0=A0=A0=A0=A0 len +=3D vscnprintf(buf + len, size - len, fmt, args)=
;=0A=
so that it returns the full size of the string.=0A=
If it were in user-space, I'd check a negative error code, but the=0A=
Linux kernel implementation doesn't return a negative error code, so=0A=
far.=0A=
I see it's a copy from a code snipped I suggested which already=0A=
contained the error :)=0A=
=0A=
Also, it might be safer to use strnlen() instead of strlen() for=0A=
avoiding a potential out-of-bound access.=0A=
=0A=
=0A=
thanks,=0A=
=0A=
Takashi=

