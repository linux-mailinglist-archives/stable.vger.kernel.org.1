Return-Path: <stable+bounces-179714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E7CB593BC
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 12:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B26951882142
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 10:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB52306B2E;
	Tue, 16 Sep 2025 10:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sap.com header.i=@sap.com header.b="Imztgr0A"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010019.outbound.protection.outlook.com [52.101.84.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5B9306B1C
	for <stable@vger.kernel.org>; Tue, 16 Sep 2025 10:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018473; cv=fail; b=nCc8cFgLyyTE88uEORK3lJDwjB4j9qEBryOSzMbWus95L7xLGNAu5TL56PLUyjyXu+P7DfFw1T6jq16w/K6GuhprYWwYMJmp3Tp3m3Al4EtJRIfr9UFr11s4SdAACV7Vm9LdCa6E8LeSPaQ/+8SrLAXeWbHcF6fmas1Asg/5nUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018473; c=relaxed/simple;
	bh=wLznGd47Ld9X78xxP4sSb9WOEKdn87iruSUvDCOLSp0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ooO5DW46P/aTp17glF+BMNZRuYv/A2LB38fCZoM4mM78q2nA+us1JwvtbWneetNhoukSBfNgZZlXTnw0Ti1n+aoHgFTpimGeLi4Xdi5wO9HVA8+GwxoJxkE0Gkna0zzB2fpYwUBF5E+5H8tdIVT52wlvI9qJtsgF3uBjfYtTEvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sap.com; spf=pass smtp.mailfrom=sap.com; dkim=pass (2048-bit key) header.d=sap.com header.i=@sap.com header.b=Imztgr0A; arc=fail smtp.client-ip=52.101.84.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sap.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sap.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/u7KeJV2KK6sLBevRsjgVWWChsOTzwA40HGDqAN6Re9FuaihouFITROjqvCgVi63Sx/y6adQ+7zRErTkOTuHMM+de7+31OPNWtOlHW9eGqhkgtrRxkRCoJ3h2sJ+Y19WXmq9P7BckAY7vZdYM/8YHvhaPaBI0WDpXTtPCRBRZl963Im5N2z8oqKFxfzasKoNsVbw//FNZo87gO7fD0FLtsHAmEVXyZAjukslzmCkJYNIbMbYCGbjc9gllQf38uTyXeU+6MhUWrrgitW2Ma37B0p3jlOktF+Yi02CYpUT/hRYTcrBOQR3hnoAfnMBI58tI0H576tOc/p0BPeaixFng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrY5ZkVlt5F8FN/OCCeijm2k9yHMbEJYPS9UZ6BZoFk=;
 b=HL4QVn9p/wiplDc9NGBdW2crc4U8Mw309AK/JajvZBWsa2QRRGVmLXR8qiOJn2UGbEhbbWnHhSZW90o/9cRgfGrS+xmt01eGXsL/aZnUAgW/RAThhRsf61Hr6p7X3oBmhN/R8dAM4fGuvKx7qo2DKVvJ2pLFZjhEifJ2mFBwKxthEM7U+aDR0tWLx4pyzFTVsv+1F9qBJghWf30l90EG8A6FeqUp+3s3dd4HNsWXbnQh1W1jW01mSlAxCZGuhJy04FNgu76KBlxN5FTfYKpsw4hWVx+o0D0rWyEWIO+G67p4zSJ24Ep/ezocUz7AjtP48VXKaLvSV24O+0TSNcUovA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sap.com; dmarc=pass action=none header.from=sap.com; dkim=pass
 header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrY5ZkVlt5F8FN/OCCeijm2k9yHMbEJYPS9UZ6BZoFk=;
 b=Imztgr0Ab/0pa8j52hTQsAILMmZpo1pql2sacb4owfOKEDSO7kaS8FNv9yA8j9Q8Ed773qie5m1No3rSM8XPm5ji+5ZVL8BF8HF5tZQ6cShK34J1bjxGO9HN5zD/4Mkyix303rdihmZxNnnVDR9/xM/JobeDVK3SqekQcatnTGVcYso85axGAHJ/x+eBPBIdJ+xEVRDZ0aFc8/uswpzCClUueFoJYaVmzvTur/gShx+x7vT1VezNZQY/X65nL9zf/Gj2evMHuJCanEZCrBb6DuxbMGTQDwoJux8JHmKdi9fZS/vDdlyR104tDlgIjlzelLcYYxpqszT+UnTvVAigwg==
Received: from AS8PR02MB8415.eurprd02.prod.outlook.com (2603:10a6:20b:529::16)
 by DB8PR02MB5897.eurprd02.prod.outlook.com (2603:10a6:10:119::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 10:27:48 +0000
Received: from AS8PR02MB8415.eurprd02.prod.outlook.com
 ([fe80::e5f5:9a09:cfb6:f802]) by AS8PR02MB8415.eurprd02.prod.outlook.com
 ([fe80::e5f5:9a09:cfb6:f802%6]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 10:27:47 +0000
From: "Subramaniam, Sujana" <sujana.subramaniam@sap.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Subramaniam, Sujana" <sujana.subramaniam@sap.com>, Steve French
	<stfrench@microsoft.com>, "zdi-disclosures@trendmicro.com"
	<zdi-disclosures@trendmicro.com>, Namjae Jeon <linkinjeon@kernel.org>, Jan
 Alexander Preissler <akendo@akendo.eu>
Subject: [PATCH 6.6.y] ksmbd: fix null pointer dereference in
 alloc_preauth_hash()
Thread-Topic: [PATCH 6.6.y] ksmbd: fix null pointer dereference in
 alloc_preauth_hash()
Thread-Index: AQHcJvSMKTImWmqb+EeD/hikpH6ryQ==
Date: Tue, 16 Sep 2025 10:27:47 +0000
Message-ID: <20250916102630.93530-1-sujana.subramaniam@sap.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sap.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR02MB8415:EE_|DB8PR02MB5897:EE_
x-ms-office365-filtering-correlation-id: 08d6ee03-16dc-4d44-73ad-08ddf50bae96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?bhDOpHBl3Z1oxQa4yzZ0XXSMhLvxkJVvOHbv1zbrSkeQ2LSidd/+tfSLFG?=
 =?iso-8859-1?Q?r/7YfIhfnDlWiUzX1ju8nQZ1DvMT9VByAnXDDHa4ULTEBuZY3Iwq48rxC7?=
 =?iso-8859-1?Q?rCPgQe5IMP1Q9FRjaddAe2ooMfRKV0C3aU+NFK3YCxtGSrvk4Dx6DQ7gBL?=
 =?iso-8859-1?Q?oVeRa4QKEP9vjvH28GdtQjmwtuZvQpR3NZ0vsPPqODMZgV0HseQdBcwA7D?=
 =?iso-8859-1?Q?hOWUCQuaIGi5yfGhquWxU3COFQeg9wQ8S45l54benKgH8TRibNZo19rIJb?=
 =?iso-8859-1?Q?fs9XsBde84TZNa4qTpHmUUJhZk5k9++nQ+u1wc1PDmJBLxWS2mf1nz/AnT?=
 =?iso-8859-1?Q?CesgqJSwiEAZbZD3sLxISEIps9FWAoFDZyiGfmzyMw9BgH2C7/XGgGkNeg?=
 =?iso-8859-1?Q?9CawGos7ao3VqxIiETiVW36m/1xVixod4IKl+HpNEk4S9UDMhKSoDW8V0B?=
 =?iso-8859-1?Q?m5Xdng9kS/bfpbMCtbym/GHHiPtCY1r4DX7+Sa0K4G7JJuNgNi7FIEio4y?=
 =?iso-8859-1?Q?Jhe1vNdxE99+EbUaLDJF+6QyenoeTQw+mBHaTa+bXJaQ6pGzFc0AamHH11?=
 =?iso-8859-1?Q?/RnOR8sZ4P9Kmmi0hSX0/UHK6nrQRyplVrhJhshTeUJzg3MDspdOQp6qJj?=
 =?iso-8859-1?Q?RvqiF8QgwNQBiO1gIeid+HVCnirl3sVtjYeM8bi1/4uWoCZr8MhY9gPAGJ?=
 =?iso-8859-1?Q?hslIaRtpeQyVQ3M56wp1cX4oFQmWhoqzEHE0Vq9s1Mzu4EQdqFpu/egNMu?=
 =?iso-8859-1?Q?SaaeYVVMVqim90BaAhjZlLeO8DREtqpjOPoadGy7K42wQgsG2nxln9iWhU?=
 =?iso-8859-1?Q?V+DNLhfdh9k7wVOfq+eVnb4k8dGK0J1ZruQpymSaU1owzPZLLoxqBC9Q4B?=
 =?iso-8859-1?Q?zBz6aMCuJkZuhlq4mTwDTjJE7BrefNlPjh4PmEHrsKvLdK+P3ElVXEvRcl?=
 =?iso-8859-1?Q?//b1NC3HaoSbhSCXipn5mfWSZadFRX54WAvYTkbz7hEC6NIXoqSfGxqNiH?=
 =?iso-8859-1?Q?1tJWQdw0fSmftWESKOB34mzMuWe3k9+JauxXeruDRh86sYD2+PIkO/CvGf?=
 =?iso-8859-1?Q?Xnjj98b9K1KpdQCxvCp417JTTsJJF/aMtrZPUX3LKiGqN4cC8zpGNGr116?=
 =?iso-8859-1?Q?GWjzkMDmCL4/5qHKrjHXJkQMJliF5sNXKSnrsAo6zrksegMg7pAqzpiiLt?=
 =?iso-8859-1?Q?+Ags9FFZD97neEAGo7gmNUFNzbw6Ajt3Ak6dN8xHMXGmJpNRiNgTVLjVlC?=
 =?iso-8859-1?Q?nSmxZ1TQQ3zZILeUm716SH68Dv6YubBui+5BJV6uF2f+lEDyscwEd7EHfl?=
 =?iso-8859-1?Q?pF/XuQGp8PFc9KkjpWnCIo2Ed6A1lDIPu2TfLA7h7M9VTNryUYLY5cQ617?=
 =?iso-8859-1?Q?lE9B07uJaH4MaLU3vUPRUbee+yDJgfPN5GZQirDQCHVDH2T3cbeAH2vUq4?=
 =?iso-8859-1?Q?6Ncoxe2Uhjk9o8Uya9JrFVL2hAsmSmPgKafOolEMsS0YOxyWP6nUH7kl2h?=
 =?iso-8859-1?Q?g8wy2AD0Jn1vZmxwjvcdjes3GT8avdtDnEwCkxlen5pYoq3D77t/Pr1FYK?=
 =?iso-8859-1?Q?KJlZGLU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB8415.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?vJQMVppHCWQ4zFPKhkw5F2eDj1NxMMyjLotht7N3ucK1EVU43aper+uh62?=
 =?iso-8859-1?Q?O1/WhQFtpp2s97SO9EpoYuZ/i6SFiZ4s5CaTfHOjgCQMJx0norMaVr3V12?=
 =?iso-8859-1?Q?ecfipCx3TNDNCvh1VsTTO0w+CrK4y0BoiBmSYXXGN6j1eBpBd9+oL9mBDV?=
 =?iso-8859-1?Q?LYrf8MaGK+Zp0UI2uVLrHA1exR6UPPVL58yuhhTCISG7TERAy21/0DoHrS?=
 =?iso-8859-1?Q?8SlQZYwLjcFtIn/C+QtoZlvISRScZNQkefHAxh0DIbbyI22rhwW1/CET0y?=
 =?iso-8859-1?Q?AecTozj3bSDRgmArSIo9OJJASQxFFlhg6KhD5laV9hJgxDtyiF7M7ZksTq?=
 =?iso-8859-1?Q?BommevmTF4Shq0Mqm5yZaBylAMmWV8gE0VJNRzoLwk5UhpspAmX2MoVYZD?=
 =?iso-8859-1?Q?xpwuEOzsWabFdw7qaaRz3+40KBN3SeqJ/aG2xu08Qw6NGLYLLkL+I3Whfh?=
 =?iso-8859-1?Q?mjXzARDzpx1JDt9K2fdajjuiNHz8ZyjKpkkditA6rGlyjZ/6ZT2CKqXEsb?=
 =?iso-8859-1?Q?hMukkIYdSFUUFTDPov6/FX8XuQ89PVIllPI2Kc8EOmXbnQWxCHXFWir8GW?=
 =?iso-8859-1?Q?aDVUxaPuU2BobvCACVEznLH1bax/O8oiDW1IQ7D+ZLNfV6USlbIUhxIXQI?=
 =?iso-8859-1?Q?9J3vIpcDkTnSUM1LJ5XuIny2VxTuwjya7PNcmyPlzpA8BGcd9zmVwNgu8U?=
 =?iso-8859-1?Q?+PBwLyZaOICDJC4p/OOzNZ1GxFLjMV2V3OBrY2NwkrKabnNgQUBzHLx5YP?=
 =?iso-8859-1?Q?GCYzbU+5M6+WY7Gd1BXrqBhhD/BMUEzwPZ8cYEgJk0J/8m9xn1dAwDXRHs?=
 =?iso-8859-1?Q?oITnkdGFjaamVyutabhoWkil1Bn3rjNlqS08oOh9W3dvgsa0IqlNfnwL3r?=
 =?iso-8859-1?Q?E+bZ/pF7pDzdR4xg3/L4u9yodTomqItliK2Pp7S04vI8WetXhIOxUvsNdP?=
 =?iso-8859-1?Q?612WGj/12+1nkSxkbwcMaWtIjgOfD24vlLuOkVAbzaRdk9pmMhBca7PEWL?=
 =?iso-8859-1?Q?LSIrpUHs77ixrbQNcy51g8OpDQsiIofBHybXI+hJXGbF2TypcL5t/gV0Gc?=
 =?iso-8859-1?Q?fy7ShRqlj1SL08TKRy1+V/XNnizlg/vkh4oKua45GGOEBVNTpdnmPmm+mp?=
 =?iso-8859-1?Q?YLiUf7gxTcbpPUatcblAsvxAkkiDLUuCApek2Jofbr5Dbtgc5LwPSRX2Lb?=
 =?iso-8859-1?Q?q43wJwUDXR42Z9qafnFYTG/Ss4b2QWb0QNhUEF6cfqVncT5kgpcpCxCNPh?=
 =?iso-8859-1?Q?y1aH4G7vZFHS7BFcfugyf/9PZOq3MDksojTU+wX6Qag3OdPXTfr1AP1vuO?=
 =?iso-8859-1?Q?nRYzWN3Pn9jFPqE0TEl88jMuqbhh9IXf3tOcKffTUrkMFJMnunsDzRulqJ?=
 =?iso-8859-1?Q?2dgQjODbULgZ+XRF4WCucN5I3hUoUetVbhoUKFprXVrK8n9oKNRBuRZaCh?=
 =?iso-8859-1?Q?YVnjZdNFq3PpU7bJZZT4GuWKQ/mCuI0fm8KX/h2DYfRpS//Ku/3m5peNWT?=
 =?iso-8859-1?Q?L+yY8WzP+MHHjJ9jX7wlxhJMEsjkgD8wvDVPptnTvErrrNgWk/g04gcSDh?=
 =?iso-8859-1?Q?K7FHeYlhSuA9wooV6TDYA0uZBvNFU3RcXR2JtAbbN+0rdg0t3yDPDeJAEV?=
 =?iso-8859-1?Q?VFNK2rdgQXqRPhuIHISaCRyFWrBqgoE6yskdfXr37ntMq+woTr2Nc+OA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB8415.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d6ee03-16dc-4d44-73ad-08ddf50bae96
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 10:27:47.8574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ERvif82G1aTMF2k3NiIEXh/Ps+RWamyMSeO88bAC6q4d58j+aK1/vScNLwP6VJNVvzInzoy++qffDjwiCAQBxH9wV0vzqD3vzBfHn301Lec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5897

From: Sujana Subramaniam <sujana.subramaniam@sap.com>=0A=
=0A=
[ Upstream commit c8b5b7c5da7d0c31c9b7190b4a7bba5281fc4780 ]=0A=
=0A=
The Client send malformed smb2 negotiate request. ksmbd return error=0A=
response. Subsequently, the client can send smb2 session setup even=0A=
thought conn->preauth_info is not allocated.=0A=
This patch add KSMBD_SESS_NEED_SETUP status of connection to ignore=0A=
session setup request if smb2 negotiate phase is not complete.=0A=
=0A=
Cc: stable@vger.kernel.org=0A=
Tested-by: Steve French <stfrench@microsoft.com>=0A=
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-26505=0A=
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>=0A=
Signed-off-by: Steve French <stfrench@microsoft.com>=0A=
Signed-off-by: Jan Alexander Preissler <akendo@akendo.eu>=0A=
Signed-off-by: Sujana Subramaniam <sujana.subramaniam@sap.com>=0A=
---=0A=
 fs/smb/server/connection.h        | 11 +++++++++++=0A=
 fs/smb/server/mgmt/user_session.c |  4 ++--=0A=
 fs/smb/server/smb2pdu.c           | 14 +++++++++++---=0A=
 3 files changed, 24 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/fs/smb/server/connection.h b/fs/smb/server/connection.h=0A=
index 29ba91fc5407..45421269ddd8 100644=0A=
--- a/fs/smb/server/connection.h=0A=
+++ b/fs/smb/server/connection.h=0A=
@@ -27,6 +27,7 @@ enum {=0A=
 	KSMBD_SESS_EXITING,=0A=
 	KSMBD_SESS_NEED_RECONNECT,=0A=
 	KSMBD_SESS_NEED_NEGOTIATE,=0A=
+	KSMBD_SESS_NEED_SETUP,=0A=
 	KSMBD_SESS_RELEASING=0A=
 };=0A=
 =0A=
@@ -195,6 +196,11 @@ static inline bool ksmbd_conn_need_negotiate(struct ks=
mbd_conn *conn)=0A=
 	return READ_ONCE(conn->status) =3D=3D KSMBD_SESS_NEED_NEGOTIATE;=0A=
 }=0A=
 =0A=
+static inline bool ksmbd_conn_need_setup(struct ksmbd_conn *conn)=0A=
+{=0A=
+	return READ_ONCE(conn->status) =3D=3D KSMBD_SESS_NEED_SETUP;=0A=
+}=0A=
+=0A=
 static inline bool ksmbd_conn_need_reconnect(struct ksmbd_conn *conn)=0A=
 {=0A=
 	return READ_ONCE(conn->status) =3D=3D KSMBD_SESS_NEED_RECONNECT;=0A=
@@ -225,6 +231,11 @@ static inline void ksmbd_conn_set_need_negotiate(struc=
t ksmbd_conn *conn)=0A=
 	WRITE_ONCE(conn->status, KSMBD_SESS_NEED_NEGOTIATE);=0A=
 }=0A=
 =0A=
+static inline void ksmbd_conn_set_need_setup(struct ksmbd_conn *conn)=0A=
+{=0A=
+	WRITE_ONCE(conn->status, KSMBD_SESS_NEED_SETUP);=0A=
+}=0A=
+=0A=
 static inline void ksmbd_conn_set_need_reconnect(struct ksmbd_conn *conn)=
=0A=
 {=0A=
 	WRITE_ONCE(conn->status, KSMBD_SESS_NEED_RECONNECT);=0A=
diff --git a/fs/smb/server/mgmt/user_session.c b/fs/smb/server/mgmt/user_se=
ssion.c=0A=
index 82dcc86a32c5..408f47220c07 100644=0A=
--- a/fs/smb/server/mgmt/user_session.c=0A=
+++ b/fs/smb/server/mgmt/user_session.c=0A=
@@ -373,12 +373,12 @@ void destroy_previous_session(struct ksmbd_conn *conn=
,=0A=
 	ksmbd_all_conn_set_status(id, KSMBD_SESS_NEED_RECONNECT);=0A=
 	err =3D ksmbd_conn_wait_idle_sess_id(conn, id);=0A=
 	if (err) {=0A=
-		ksmbd_all_conn_set_status(id, KSMBD_SESS_NEED_NEGOTIATE);=0A=
+		ksmbd_all_conn_set_status(id, KSMBD_SESS_NEED_SETUP);=0A=
 		goto out;=0A=
 	}=0A=
 	ksmbd_destroy_file_table(&prev_sess->file_table);=0A=
 	prev_sess->state =3D SMB2_SESSION_EXPIRED;=0A=
-	ksmbd_all_conn_set_status(id, KSMBD_SESS_NEED_NEGOTIATE);=0A=
+	ksmbd_all_conn_set_status(id, KSMBD_SESS_NEED_SETUP);=0A=
 out:=0A=
 	up_write(&conn->session_lock);=0A=
 	up_write(&sessions_table_lock);=0A=
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c=0A=
index 85e7bc3a2bd3..ae47450dc40f 100644=0A=
--- a/fs/smb/server/smb2pdu.c=0A=
+++ b/fs/smb/server/smb2pdu.c=0A=
@@ -1252,7 +1252,7 @@ int smb2_handle_negotiate(struct ksmbd_work *work)=0A=
 	}=0A=
 =0A=
 	conn->srv_sec_mode =3D le16_to_cpu(rsp->SecurityMode);=0A=
-	ksmbd_conn_set_need_negotiate(conn);=0A=
+	ksmbd_conn_set_need_setup(conn);=0A=
 =0A=
 err_out:=0A=
 	if (rc)=0A=
@@ -1273,6 +1273,9 @@ static int alloc_preauth_hash(struct ksmbd_session *s=
ess,=0A=
 	if (sess->Preauth_HashValue)=0A=
 		return 0;=0A=
 =0A=
+	if (!conn->preauth_info)=0A=
+		return -ENOMEM;=0A=
+=0A=
 	sess->Preauth_HashValue =3D kmemdup(conn->preauth_info->Preauth_HashValue=
,=0A=
 					  PREAUTH_HASHVALUE_SIZE, GFP_KERNEL);=0A=
 	if (!sess->Preauth_HashValue)=0A=
@@ -1688,6 +1691,11 @@ int smb2_sess_setup(struct ksmbd_work *work)=0A=
 =0A=
 	ksmbd_debug(SMB, "Received request for session setup\n");=0A=
 =0A=
+	if (!ksmbd_conn_need_setup(conn) && !ksmbd_conn_good(conn)) {=0A=
+		work->send_no_response =3D 1;=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
 	WORK_BUFFERS(work, req, rsp);=0A=
 =0A=
 	rsp->StructureSize =3D cpu_to_le16(9);=0A=
@@ -1919,7 +1927,7 @@ int smb2_sess_setup(struct ksmbd_work *work)=0A=
 			if (try_delay) {=0A=
 				ksmbd_conn_set_need_reconnect(conn);=0A=
 				ssleep(5);=0A=
-				ksmbd_conn_set_need_negotiate(conn);=0A=
+				ksmbd_conn_set_need_setup(conn);=0A=
 			}=0A=
 		}=0A=
 		smb2_set_err_rsp(work);=0A=
@@ -2249,7 +2257,7 @@ int smb2_session_logoff(struct ksmbd_work *work)=0A=
 		ksmbd_free_user(sess->user);=0A=
 		sess->user =3D NULL;=0A=
 	}=0A=
-	ksmbd_all_conn_set_status(sess_id, KSMBD_SESS_NEED_NEGOTIATE);=0A=
+	ksmbd_all_conn_set_status(sess_id, KSMBD_SESS_NEED_SETUP);=0A=
 =0A=
 	rsp->StructureSize =3D cpu_to_le16(4);=0A=
 	err =3D ksmbd_iov_pin_rsp(work, rsp, sizeof(struct smb2_logoff_rsp));=0A=
-- =0A=

