Return-Path: <stable+bounces-144619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BB1ABA1A5
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 19:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D47F39E67EF
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 17:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503E226A1C4;
	Fri, 16 May 2025 17:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lQtZu9xV"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2017.outbound.protection.outlook.com [40.92.42.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D0926C3A8
	for <stable@vger.kernel.org>; Fri, 16 May 2025 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747415417; cv=fail; b=cwKalrTJ4o7IufXid2z+JK24Qr0Ze/ROmN+mJoVQkG/ZLEfWfFMNviB6ujGLBqn1GMvJ5bKZLuDkzFAVZ7hbTUE8vs7o6eYx9ek2qhtOVrnJhNPpouqso0zFN86yIEO8zYZ8LbdOgBmEN3RX66Oh7Vr6WzKlb3cdcPoZN9iQ+Tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747415417; c=relaxed/simple;
	bh=NvnETfhqIjPKCgV3EchLTKj3B70TdLdtwW9Vf/mhj5g=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ri8Htu2Fa2qvTf/U2yBOsFlJOUQdMwLp+dnRwXE5yDlo0mTjR8cZ/xZLVE+rWfK7VS0Jh/kLl45zXgFnaqqLq5QueYvaAswzn2ojbvDs6jBc5dTMK9ltuiEbsxPled+fpgO9oLMjJDsBOL4++ehTSWOce3l+tV4f9aEW9/vuCa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lQtZu9xV; arc=fail smtp.client-ip=40.92.42.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQ7XkPYOOXgJCgElC24PHLnQFPY31Aj2t8ANTGHbAQ/JAtFYDDXTzbfqSRV1gErJ7A7kYpnlwFnK5CyKW7cV1sY7zQV/T/PG9q24yG8mnVqhW4XFda2ty4DuvrJV/uXnsCNWo2srkfxGujqauQhDsnbg+vXZF3DF5UrA3+BkJVL/88cEBuk1n+qREcBTGwiUAgJRivqdV/virYJPF2/LbSGETiPlmy6l7RI1sAkDtCc5os0DwGPje++7aICeUqHfGJLKZ97YL4EOsT7uAGjwKhjW+tMbEwHETycJ1t1/4fGKlUp/zuAZUYn96ienEUN9kf/9RNh6r0zuQiVEYNYj5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvnETfhqIjPKCgV3EchLTKj3B70TdLdtwW9Vf/mhj5g=;
 b=DQRSTwGznvlVAr1UNVv6qLXimUZGuutpBO80gccqmlyQvQjF+CrQt92tdartsbVgeqQb3DR5MONv8GidMATTyEtY/tvBtrpljuCdSn2zV/EwYGwN0ghnRqOAVGNdpl4yEruSYU4ZK6w8VlrqvRkit/XZark7+bhrZLHav7myTZf7hnURonfKorVGgX/dGw36E5+mLN2Xl1ttCwwIMXJ3MQ2HGtdLblxO6l8A2OiCIM5z9ZymDcDZokldlKPm/Bafu2R3sGWzpGAhEjk2Chro5rtoUx4OBlUe4sDRHcX/tNvwq4ArN3j5GLC6y7p4SVqayfyitfAhzxE0Vt0ibJIrJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvnETfhqIjPKCgV3EchLTKj3B70TdLdtwW9Vf/mhj5g=;
 b=lQtZu9xVhsMNPIixatLnaxRRUhMliItO+R2eAFdfHWwsII8CGuNzLFtAaIqqVPzk5Y4Fm6RjsVjfAbLVRcg0dk1x7odF4IQNhxhWSHvag/R4harzh5T5/Yl3Zo3QleX+MWPg66kyq+34aEd1ys2cXH1ohV+WUoQbxCZp7896df/KJ0VXZxvOS5Z9pPxwMHmiSwbNyHMJJdW5vAwrsXG4Z26s1ahCZ8qosGlvLy3KBNHKjR1jDUiYxoWeyg/a2gVeLmj5dnCVVFNw3l+IJjYjO+DtolszwKL8yfL+0YMKkcr1kTa6lm5Ll/YkQq9JG6uWdc/iJWokHg3fDBlsNa6M+w==
Received: from CY4PR03MB3335.namprd03.prod.outlook.com (2603:10b6:910:56::14)
 by BN5PR03MB8078.namprd03.prod.outlook.com (2603:10b6:408:2ac::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 17:10:13 +0000
Received: from CY4PR03MB3335.namprd03.prod.outlook.com
 ([fe80::e8c6:bfb:511d:77d8]) by CY4PR03MB3335.namprd03.prod.outlook.com
 ([fe80::e8c6:bfb:511d:77d8%3]) with mapi id 15.20.8678.025; Fri, 16 May 2025
 17:10:13 +0000
From: Jessica Garcia <jessica.campaigndataleads@outlook.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Drive Results for MRO & Air Charter with Targeted Contact Solutions
Thread-Topic: Drive Results for MRO & Air Charter with Targeted Contact
 Solutions
Thread-Index: AdvGbdgUCBkViepxSrGsnhBTl70uCw==
Disposition-Notification-To: Jessica Garcia
	<jessica.campaigndataleads@outlook.com>
Date: Fri, 16 May 2025 17:10:13 +0000
Message-ID:
 <CY4PR03MB3335C18ECFDA9C9B72C7A41CE793A@CY4PR03MB3335.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3335:EE_|BN5PR03MB8078:EE_
x-ms-office365-filtering-correlation-id: b79cda3f-d296-4c99-1ac0-08dd949c85ae
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599006|8060799009|15080799009|19110799006|461199028|13031999003|3412199025|440099028|102099032|56899033;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?6jBReSsn+pxywJ2l3Syyo0Y6gVmp+X6c+oNuqR3sLbZzc/mRsNgu6J78SP?=
 =?iso-8859-1?Q?XyeY9chKwvOU1iQRQEGYWgvfPyux08UtSHnG8ldLgTsHI9YPpFyKPWXSVu?=
 =?iso-8859-1?Q?DHX2sGfVWgw9T1yqY/zDdJJbx00InNFO4Sg5SFyz9Bp+WqOLycVtab0u2O?=
 =?iso-8859-1?Q?/DaJstoyq5fcPbHGNCWqKunI7XEUKELjlHSWDApFN/z2deCIpQT8N7s4ZW?=
 =?iso-8859-1?Q?lVUA3TetYKMReV21KaJZHAnsndpuW33yrucq7n1lEKCFwVKFbj+7zKYcMk?=
 =?iso-8859-1?Q?8Zm/IngN296NUk0GSzjTmpX2aBlJorGm9IKaLo5+1aBv68QwIfrHgK76up?=
 =?iso-8859-1?Q?Rw6Bz4GQ/3VhpsIhIRsQIcxZOzX5mcDxvNbd72Wox2qClCSPJ1BtqRlkiB?=
 =?iso-8859-1?Q?O879+Ffk238VWfsfICSbqeXE21QYfqIu0j1YBYZGinbpIMdGSEvrqn61wI?=
 =?iso-8859-1?Q?m7I7HtB/Kbce1TMIFWpCjYedSLp8QeM0Qsfe8axGcjtpIT4AdukinIt68t?=
 =?iso-8859-1?Q?47YlI30yM4wBj/uNLOnDLlpqSoKuw2TqYRtFWm+K1mXnAzRnCcqBFaCOLk?=
 =?iso-8859-1?Q?9oOG05+TjSc9T9SWGrXsWwLewAjFTtvv+Jofc+apZpeBUcWdm67vFqZrxo?=
 =?iso-8859-1?Q?7v8s0j9lwZKiUJPerOM4/KjFVw0OxpyfFfkXl6A81FXYaCDP8gnd662hsb?=
 =?iso-8859-1?Q?TTenD5D1VC3KBIOyutI1IytvB/viHX7/PgRFJ+Twj9FbUlQ0a4AIM3RYGl?=
 =?iso-8859-1?Q?wrIpSplY/xBvghVDfDu9OCFa+Q1bM+J8FP2uq5yrknSraTC0K+MJa0SXC6?=
 =?iso-8859-1?Q?QO2kG5P3h8WZ8phc5nLXo/Kn1K5xNRaQg6YB+NPgFoelBEi5QyhweOtjmI?=
 =?iso-8859-1?Q?uKJCE07rqR+xt0l4EuuLtJPcD6Ddx9j+Q2GbJGERWZ4cEBnHrL6zyj2BZr?=
 =?iso-8859-1?Q?OV4347OyNTs2m3SQ1kxrar9ryAZQuAEf1JC7AI2eYBOtKxHt3i4z5VgOyy?=
 =?iso-8859-1?Q?fWIs23+EFGRcDTYhu8UUNLPJUd23RYHruwKlUBNyHpTH/FCcRLTQN5wI8A?=
 =?iso-8859-1?Q?aLJETi5PDSTc+JxqJn1pgsj1uQSGHiI7F+cW4m10/9hvBCpc8bZTsyPCQt?=
 =?iso-8859-1?Q?8KfH7k2rm16OfqlxF9JmxpmkaOkeVROpWE81bAcyfYCLuSBMrU?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?CNv/A53GGBqyvhtLdz1RgO48tejgr4RrsnryAeQJR6gldGe8xEzRQLF7SV?=
 =?iso-8859-1?Q?3XGDQb6pKObTVp1ZqGewJxRsWPkTvrzbvHLhbAShUG5g37IpkxTOEoYnS9?=
 =?iso-8859-1?Q?raS3t4p/L5VdLeQ5ilcAY/uBgYLDSWqovUNABUBp3QD0yXlmHxZDEJLBZK?=
 =?iso-8859-1?Q?DgZTOC8rw6Wu9qvq2827QKrjbDpBgOfEPZWsjIRHlvF3Qi3IwOt4HH8ZQT?=
 =?iso-8859-1?Q?Qr4seu9uZKsPJbASeI72X/TLnF0sDiZP2o/z5xMt+u8XchETP490fN8hqJ?=
 =?iso-8859-1?Q?IppGmA9nFwzrjzNMrp8BCE854kuMS2YzYi1/4jt3nI5I4JKey1E7Jzgz5G?=
 =?iso-8859-1?Q?Z2aXjul6Ee3N10mw2S64hf/oFmPfhLN/ym9/abBILT+V6f/d0caBKH0fCa?=
 =?iso-8859-1?Q?+ock3hGs56Q62ohoMYYs/sPJt1swWAJ0tTcX6frmLeLkzq4BinxTT/iEZ6?=
 =?iso-8859-1?Q?dao972Ba5wWKq2SWGGg45vIMgvPraSrryvUvNuejhKj2j/PljDlWvAGIFZ?=
 =?iso-8859-1?Q?A4mKOvUrkmKHe1+39edGSNCS2zsnfipN9MMJWCET+D4SO9ctUluWNhz+iJ?=
 =?iso-8859-1?Q?OieWC6t5v+WvSAx48m7CkfOEX34u3cSeNSezEYqJFUTpRe7CXEh9p/eclr?=
 =?iso-8859-1?Q?ynHXkdWYsOaeto4y/beObFJ7aH82Pka0vQLLAD1sXZqiYu3Rcg2hGSo23L?=
 =?iso-8859-1?Q?sTtSRKsSjpTiXYZp02tREcocX8JjKhn35OxT7+f6sNmTcStbCPLAD2+rph?=
 =?iso-8859-1?Q?Sd5OClvz3l8e9yBQSxGa6zs1uEa0odznaxdFlUk5lptcORSRHrPU5sAugT?=
 =?iso-8859-1?Q?UGnOohjtg8b+wLjoZeur2ZOZXLMb/T4nE809pvJ2nH80cdomgU9B8nwp12?=
 =?iso-8859-1?Q?rUzVg2MNu9hvd01Ij4Yw/wMPjl4s0sVnIsOm9jylH3V+DeTv8g8WGH6/r2?=
 =?iso-8859-1?Q?8bg0M/3//LXIImvpI5HOhsoGRvWUK2H5mt7l11LwC+494+xQkXIfsYrYcb?=
 =?iso-8859-1?Q?V8X4YhokiErSFBao6P0LzaHfHPRMuXBbHsK8pP9DsaPu5z48BTzeA/Klcs?=
 =?iso-8859-1?Q?AcOQPJqJuuPr9du+3jg0rdi9xbvNbkOFB8dEuLLRW5chwzqKJWuwoPcRu8?=
 =?iso-8859-1?Q?xUzpKQ5IKdICye5B4lVGjJXRgtqoPHWtpNQ0RtNXw/zQ5c5cmr9JeYI+WT?=
 =?iso-8859-1?Q?quwRbfnGsSOHgq+nF1KPJy9JVUJ+gSelHjNJCuJpsjYI6PIH+QX/GLYNeB?=
 =?iso-8859-1?Q?PFz5K+2rp4/vW+GjUSZGSR10jG6F9EnGaOk5GxUwwSzgVsdN+BEiqpTf7q?=
 =?iso-8859-1?Q?U+FXX0hrlkPW+ngFta3rbD5Z+34QNcewoT3X4cueib04c6YP57R3qfybl+?=
 =?iso-8859-1?Q?pJaIs1iU0k8OKsHTCzDe+S2A4hgBCDaw=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3335.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b79cda3f-d296-4c99-1ac0-08dd949c85ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 17:10:13.4468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR03MB8078

Hi ,
=A0
I'm offering a resource that connects aviation outreach with data-backed di=
rection.
=A0
We provide a current and verified list of contacts, tailored specifically f=
or your industry.
=A0
(i) High-Net-Worth Individuals (HNWI) seeking seamless luxury travel and pr=
ivate charters=20
(ii) MRO Professionals focused on enhancing maintenance and procurement str=
ategies=20
(iii) Executive Assistants managing the travel needs of high-ranking execut=
ives=20
=A0
For businesses offering aviation products, maintenance services, or charter=
 flights, these contacts are ideal for your campaign.
=A0
Please let me know if you'd like to explore the lead counts and their prici=
ng structure.
=A0
Regards,
Jessica
Marketing Manager
Campaign Data Leads.,
=A0
Please respond with an Remove if you don't wish to receive further emails.

