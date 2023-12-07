Return-Path: <stable+bounces-4912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B0E80835C
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 09:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC90283D4E
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 08:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994FA15AF4;
	Thu,  7 Dec 2023 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lRU4y9m2"
X-Original-To: stable@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2081.outbound.protection.outlook.com [40.107.14.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AEC126
	for <stable@vger.kernel.org>; Thu,  7 Dec 2023 00:41:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzYTOH04gv3BzmQPfv1I7lWew0Qjq55hE/c/1Qqv+KM7wfaLOyIOxgvE+epInPsyBOSJ2Gz2s5FzgWa5z1hpMI5xDYAdvPPbjsgHfmJUARP5D8kM28GW1Blj2WuSQGHcPSBTADQ122FGnQtIsG9Qk2Y4Hvil1gU3ugkTR1e91B7B7szlF/2fJB8palR7JnZPaN/Ndft02eX+cKuiJbybD893hpA9EI6f9z4sr/VuiasZFFr71zngABU0uh6LHzj9e7EYnvn8s2Rox8uqlo5EHRBD824ghJ0cDcjTabVNgaruzvifpvj0lYQUENNyBR61Sp7EXKLZe0xqIPLga8piqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAjRPomgZRKFdjnEOshWDtJ01n51X7CvH9r8qeeZxVc=;
 b=Jh+IeR/5srYBelftgtTXcbebhHtX8yZqTLf/9pVNvzr8wUNjF+k3sWusvzl1pNLxUY8EjS/7DMh/A4HNfAAtzKgEFhcFmm96fNXlRy42cqd6oSGK3/vPjcvucR6NRKLvNEJ3S5gPoXoTGWyQ01wN58AQXy8tGvyUTidIFX5/4SK6bN300PurH9fpq87r27vUwM9Pq5vIJEzrbXUi5gWNiTMfSP5eN1+EMzcn7jbYZxShQQgx92GHEKLMyVWvc+304aOgC6hzNhBdByG9dzbVt0dsRXJvLnNunhlwqubI05BCcHWzZ+qxYhclFdMQi/aRfx5KwVbTkHe03J6ilukJRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAjRPomgZRKFdjnEOshWDtJ01n51X7CvH9r8qeeZxVc=;
 b=lRU4y9m2cwuA+mbWs3IYzzFpLYlh57QYBXit0aozWnhQ1AkR8yD5fVpNDML3fZcpmJkrurX8uk1g3QiwtqCL70GsCukAZUO3gzZgJF60IBDHmaM1HrjVSEEM85wc71DM9sL74r17dCutWGcQc1Gyh7Tzr06w9/uI9JiZtYqeYrg=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DB9PR04MB8220.eurprd04.prod.outlook.com (2603:10a6:10:242::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 08:41:49 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 08:41:49 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: "francesco@dolcini.it" <francesco@dolcini.it>
CC: Pete Hsieh <tsung-hsien.hsieh@nxp.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] wifi: mwifiex: fix STA cannot connect to AP
Thread-Topic: [PATCH] wifi: mwifiex: fix STA cannot connect to AP
Thread-Index: AQHaKOjj0iC3j70R+U61/0YSLkR2HbCdgDrA
Date: Thu, 7 Dec 2023 08:41:49 +0000
Message-ID:
 <PA4PR04MB9638DE69951EB1A536689B77D18BA@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20231207083916.267108-1-yu-hao.lin@nxp.com>
In-Reply-To: <20231207083916.267108-1-yu-hao.lin@nxp.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|DB9PR04MB8220:EE_
x-ms-office365-filtering-correlation-id: cb6142f3-dcb9-4302-65fa-08dbf7005a9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 mQqyY/Jkzn6OoXvT0Vrm13TiYHzy8Z3OTE9bBoM7t5K/1WN34r6A4dBHnV0yu/lRQv3cxQ9fD7u8TbXEsf0wlijI+Hd2UbTfi/Cd+rUkHVlpGS9zeniXrJgc5eLpFH4ZXN5y3nSZ7GFUM7JpmuQNNsZRkFc+pcVuxixbanlO53m5OpRi5PYEKVPY1CwogoMz53HBkwKdcOdguWKPEMiMemftJB2xsDVm05dbvIL2XysiV8UEr0un3GhjA8FhI+bl16tcvmTS4/3zxqWjasfKsO7pECQBbHRVTxBYIclU7arVPFsxnJYecB7UUkkYEhOToOfwmqfuv+m/7wodMSKkJ/NMFsS32/zM3+u9/+PG4Aae30zdqLlCbv7zABUr+u+xiCfPJsCzSv1TpvbdbIacFZF86um4fA+QHERCk9grL2D+FBSPUv8VkD6IG/zX069i1blR+jBk/BNucJKQHCbnCXFw3zwzReHPk4HA6dtMevgJQL/JBeCJPoP0dUnHoX2CaeXINY1FZA2iyKp734lvWRJJHWXngKIvo41kRJPDhcMT0b64k6qR887cyKv9CsTvZStxnpDk/XD5oL1aA0P+rVuIm4MNkL4NpN/BqhM8GIEjHwa+IcYcu3V45s6PL32F
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(39860400002)(366004)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(83380400001)(66899024)(86362001)(122000001)(38070700009)(33656002)(38100700002)(66946007)(8676002)(8936002)(4326008)(64756008)(66446008)(6916009)(55016003)(76116006)(54906003)(66556008)(66476007)(316002)(5660300002)(2906002)(52536014)(6506007)(53546011)(9686003)(26005)(41300700001)(71200400001)(478600001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dRo+ACTvtw39qPUASBOzEHzCyJ40UL6JSfI9aNfR5xMKcbOg9CinA6yDGzAR?=
 =?us-ascii?Q?n3NWqfbW+2HGvOiw8JQRMtCJuoJFiZ7TyTMk3YVqNnw7DaVfugLs0XLSHfgo?=
 =?us-ascii?Q?7/9HacqFoJH0WF6y1GYSGQujgFFVTuF8KA4B3JU8lk55wH8yf4DSzFGs834F?=
 =?us-ascii?Q?LOVGAu/Ektnm3NG94SVK1E9/N8vV4xkcjzTa3NWd5TQUunJZAS4b4lGMTqWc?=
 =?us-ascii?Q?zKCmGfN0m7QyTeQ3ihAqE5xRp3bHGwEtj3QHgM5RaAcdvlp3mVQyx7tl7Ct8?=
 =?us-ascii?Q?QEPL8Iu92CxI8QiG+NeMQXHluiBrd0S2ok3dp6ZXWwRcADWQMwAjrSBirseG?=
 =?us-ascii?Q?TPIRt55P7TySHvdeyLCVPHXhFbyfxBZJ9BggKU/5AceM4GdlfBGUjmY4lPZV?=
 =?us-ascii?Q?XRjNCwlBwoIBhrp06Yiif7P+49Gw25nSfYAGBiSH53yOdDAncjS7LqJdvgnb?=
 =?us-ascii?Q?c0X4xsySkgKxmnWWkNRK8hhf0UKWSjTop0xyMm57w4F+mJm5eWEabL3AQGN5?=
 =?us-ascii?Q?5zlQM9jawEQXKl+z83Zdk3hCmUPiWZhZpnX6FCMx63g6bpT3WdjZ/F1Xpxkh?=
 =?us-ascii?Q?6qm1O3cF7syrmcEQ34GU69F0GToc9Urib6SCPocoE+n4Xb0jCOoLmziKydEt?=
 =?us-ascii?Q?QIDuqUSZ1QIzO+lc8wLQfQcbkdzCU5EPQNCEWDwO40bsZY3Uk6bgKxwQTFq5?=
 =?us-ascii?Q?CepSiQfKHepEZryc4VX+gbtI6pflDIEWHX+CB2yIsoYSCI9PziFlARCwvrdA?=
 =?us-ascii?Q?VW54I6X+ZOsy3vSibObdheMsVJkc5s9ueHLC8PTuNHp9tWl8tA9FCZEqytov?=
 =?us-ascii?Q?diwnDJWqxh9W3+XUwWeXurVNsmvKI96S3Rgmty5VzRhq7Eq9Ds/Lwbl2DqpB?=
 =?us-ascii?Q?eCeSG871ZHH+rcXD2S5Lt0bCTI2tAI+OuYgg8vXlyMY65X0N/64ZFodx5q6/?=
 =?us-ascii?Q?v8bT7UZIooOeHWaBL1G6QTF4uCDCuDPKl/Wc4CbLYIvfZ4kxFJHGa33BacqI?=
 =?us-ascii?Q?F5juMXCTrjvsnEtzNKsQa4iUZ2aLR0ayRyCZXeBmWcLflIRgcHVMyD+GRJSO?=
 =?us-ascii?Q?mFjdxrcloP2+ClRBBP3qq1BZRBwAycAPMV+RnZGh+Y+HrSYx0NCMimvsqHy3?=
 =?us-ascii?Q?OWn62IVE7DcqbRV+sdAdpTM5CnvNybFOQIwt8FXuUUOlzkP2PnDvsoZhgl1Q?=
 =?us-ascii?Q?NoHwbqdGbc2vmrhfqJrMBUft177t3OchJClDB9NNWzFi6zfe9SiZFrAbhQaB?=
 =?us-ascii?Q?5fR+VCMhAxiO33kBTADYuioG+XJjM+tXsWSf/ekL3DrIFIa7V/RMNws5qnQr?=
 =?us-ascii?Q?ewgatp6nGZa/ML0fKzS3QkJZJWm9W3aP5rrCJnoP9G2F7NK1HLRpThuzVKgW?=
 =?us-ascii?Q?ic1fpvcHgV6aUCsJZOo1jx/Z/KbfeeNIo2+3GpeuP1tMOVWx9jXf/ZF1ahq4?=
 =?us-ascii?Q?/VKDae59An+vCzFQOEJxd0T/FldLdJ9tMl5HGofvCPcr+cLVu+ZVyuP47GHL?=
 =?us-ascii?Q?VPgGYzEN1m/nasGNkcyY4WmrTGnUojwIa0sSqtjunXJfbXXonUEY+n2mioCb?=
 =?us-ascii?Q?/lFJR8YtHuN6RTucYSbeCiD2rB37A8fAwEJMzMFl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6142f3-dcb9-4302-65fa-08dbf7005a9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 08:41:49.5345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ReoCOy74Yvh+gkRYxSZJ1we0XvKGhEwVf1G++LpJQM9zgeHE+6dNdapg3++m70CYJRWJHWX9lcJkcFmhCZx3Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8220

Hi Francesco,

	This is the second patch. Sorry, it still sent to stable@vger.kernel.org. =
I will correct it next time.

Thanks,
David

> -----Original Message-----
> From: David Lin <yu-hao.lin@nxp.com>
> Sent: Thursday, December 7, 2023 4:39 PM
> To: francesco@dolcini.it
> Cc: Pete Hsieh <tsung-hsien.hsieh@nxp.com>; David Lin
> <yu-hao.lin@nxp.com>; stable@vger.kernel.org
> Subject: [PATCH] wifi: mwifiex: fix STA cannot connect to AP
>=20
> AP BSSID configuration is missing at AP start.
> Without this fix, FW returns STA interface MAC address after first init.
> When hostapd restarts, it gets MAC address from netdev before driver sets=
 STA
> MAC to netdev again. Now MAC address between hostapd and net interface
> are different causes STA cannot connect to AP.
> After that MAC address of uap0 mlan0 become the same. And issue disappear=
s
> after following hostapd restart (another issue is AP/STA MAC address beco=
me
> the same).
> This patch fixes the issue cleanly.
>=20
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> Fixes: 277b024e5e3d ("mwifiex: move under marvell vendor directory")
> Cc: stable@vger.kernel.org
> ---
>  drivers/net/wireless/marvell/mwifiex/cfg80211.c | 2 ++
>  drivers/net/wireless/marvell/mwifiex/fw.h       | 1 +
>  drivers/net/wireless/marvell/mwifiex/ioctl.h    | 1 +
>  drivers/net/wireless/marvell/mwifiex/uap_cmd.c  | 8 ++++++++
>  4 files changed, 12 insertions(+)
>=20
> diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> index 7a15ea8072e6..3604abcbcff9 100644
> --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> @@ -2047,6 +2047,8 @@ static int mwifiex_cfg80211_start_ap(struct wiphy
> *wiphy,
>=20
>  	mwifiex_set_sys_config_invalid_data(bss_cfg);
>=20
> +	memcpy(bss_cfg->mac_addr, priv->curr_addr, ETH_ALEN);
> +
>  	if (params->beacon_interval)
>  		bss_cfg->beacon_period =3D params->beacon_interval;
>  	if (params->dtim_period)
> diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h
> b/drivers/net/wireless/marvell/mwifiex/fw.h
> index 8e6db904e5b2..62f3c9a52a1d 100644
> --- a/drivers/net/wireless/marvell/mwifiex/fw.h
> +++ b/drivers/net/wireless/marvell/mwifiex/fw.h
> @@ -165,6 +165,7 @@ enum MWIFIEX_802_11_PRIVACY_FILTER {
>  #define TLV_TYPE_STA_MAC_ADDR       (PROPRIETARY_TLV_BASE_ID +
> 32)
>  #define TLV_TYPE_BSSID              (PROPRIETARY_TLV_BASE_ID + 35)
>  #define TLV_TYPE_CHANNELBANDLIST    (PROPRIETARY_TLV_BASE_ID +
> 42)
> +#define TLV_TYPE_UAP_MAC_ADDRESS    (PROPRIETARY_TLV_BASE_ID +
> 43)
>  #define TLV_TYPE_UAP_BEACON_PERIOD  (PROPRIETARY_TLV_BASE_ID +
> 44)
>  #define TLV_TYPE_UAP_DTIM_PERIOD    (PROPRIETARY_TLV_BASE_ID +
> 45)
>  #define TLV_TYPE_UAP_BCAST_SSID     (PROPRIETARY_TLV_BASE_ID + 48)
> diff --git a/drivers/net/wireless/marvell/mwifiex/ioctl.h
> b/drivers/net/wireless/marvell/mwifiex/ioctl.h
> index 091e7ca79376..8be3a2714bf7 100644
> --- a/drivers/net/wireless/marvell/mwifiex/ioctl.h
> +++ b/drivers/net/wireless/marvell/mwifiex/ioctl.h
> @@ -83,6 +83,7 @@ struct wep_key {
>  #define MWIFIEX_OPERATING_CLASSES		16
>=20
>  struct mwifiex_uap_bss_param {
> +	u8 mac_addr[ETH_ALEN];
>  	u8 channel;
>  	u8 band_cfg;
>  	u16 rts_threshold;
> diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> index e78a201cd150..491e36611909 100644
> --- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> +++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> @@ -468,6 +468,7 @@ void mwifiex_config_uap_11d(struct mwifiex_private
> *priv,  static int
>  mwifiex_uap_bss_param_prepare(u8 *tlv, void *cmd_buf, u16 *param_size)
> {
> +	struct host_cmd_tlv_mac_addr *mac_tlv;
>  	struct host_cmd_tlv_dtim_period *dtim_period;
>  	struct host_cmd_tlv_beacon_period *beacon_period;
>  	struct host_cmd_tlv_ssid *ssid;
> @@ -487,6 +488,13 @@ mwifiex_uap_bss_param_prepare(u8 *tlv, void
> *cmd_buf, u16 *param_size)
>  	int i;
>  	u16 cmd_size =3D *param_size;
>=20
> +	mac_tlv =3D (struct host_cmd_tlv_mac_addr *)tlv;
> +	mac_tlv->header.type =3D cpu_to_le16(TLV_TYPE_UAP_MAC_ADDRESS);
> +	mac_tlv->header.len =3D cpu_to_le16(ETH_ALEN);
> +	memcpy(mac_tlv->mac_addr, bss_cfg->mac_addr, ETH_ALEN);
> +	cmd_size +=3D sizeof(struct host_cmd_tlv_mac_addr);
> +	tlv +=3D sizeof(struct host_cmd_tlv_mac_addr);
> +
>  	if (bss_cfg->ssid.ssid_len) {
>  		ssid =3D (struct host_cmd_tlv_ssid *)tlv;
>  		ssid->header.type =3D cpu_to_le16(TLV_TYPE_UAP_SSID);
>=20
> base-commit: 783004b6dbda2cfe9a552a4cc9c1d168a2068f6c
> --
> 2.25.1


