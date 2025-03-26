Return-Path: <stable+bounces-126679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F34EA710E9
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 07:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04AD31697D6
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 06:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4834418FDA5;
	Wed, 26 Mar 2025 06:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iEYiOf+d"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2088.outbound.protection.outlook.com [40.107.249.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE8764D;
	Wed, 26 Mar 2025 06:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742972335; cv=fail; b=iAP5EQ/1sNY+VjtAnMu0H9sAnP4tNs/5Yecz4tiV5FYaKegbDvNyt7YIkXAjYyRxckwil8nNgH3sjpntks78pX4X/067KjGAhxGE/64KRzzL7eFmI7du9NxW8OSAdP98rpWbdPZGg/XUWZKFdQmuDxSAvlYguNxsd+GS/bcs6q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742972335; c=relaxed/simple;
	bh=MwUzHsZdHXkes/PUoCLRdssfLR14oNFKGSNinAB45gs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CdXwTl/QMDa8SQGbDpLT2Xc7ct3P1nnIe4ktzc8xwpzhj3n9pP5YArl0f5BTEF/LWLZzUKy/l3nBOuvwUzSqPUP0Y12Ipk2SM5fxnWzpOqC/0MM+ZLsjFbkoxIticI7Y2yF/VOrWGSTi7Fvzezf0mPW95shGDZ0Bp1TDw0E69e0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iEYiOf+d; arc=fail smtp.client-ip=40.107.249.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zS5SFy8GLFDVpGmhupOc7DiR1Yvm59BLiuEXxQLlf0B17XkIa49ArxE7Z2QwY9t/twKNd5flcd+L6eCRe6i4Plcwc+AEPh5zRbHyY8g8943cxICom2/y9pJAs0nftpHechqP6aRXpmGSpxpuCMKoCTkLirXfx078fdDvSJ9imI8YF53ULfvVTyhg1aSwqO3nOWK686Ea+SuAVNPtQrNe7PPPVW3UBZHT4Wc6RiOam0jlqr2knN6tVsVTHKkJYnpUJBtArTuza1cymVTskzNMgNBp0575Wg1whzor82W4mVWVGMZnzQt/4bWBXZmkFh/42tnepltuxiSFVyyue1HNfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqIebak3oYApFrQIoFNS+v3Eyx+wOcSyNpLdEIkR7aU=;
 b=JMFHm4fLmcmSPiDW2Y4cNYR+qtWFZCUUm7DpAHaDas3zdugTOsgDyw16oeZcMSrQk6ONjdcLhK+lXOERDdQJExKK+a8TblXIUxvvnKmFewNQ1wXwRTKKF8fLHB67PXyM38Ojlr2TIEfhbSGhKlrdY58AdM3jNrMclwsRIPuXBm8H2SsPOPltbTCtp1mhjElDO05F9fOHmvWmKzy7motgYye4KATthCQIg1BOjFcld0vx9Ne0bZTIG0biuHGy3DF8GTwRwieU67YrlmKuzFRnhdglB1U5cempMJNVOsBEjsnQXmhUxIdc0SwOaA1cloHZUDfUAYnEKoTuEnm5Zitgmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqIebak3oYApFrQIoFNS+v3Eyx+wOcSyNpLdEIkR7aU=;
 b=iEYiOf+dya8CCEhBP9BQ3YcujEznsadvpjpKRlT2SLJP4b8c+xJ9iaHE8DI59CEqAZHTM8WqI/69swhFtlDZeZMM7DMoHlmoSIOVbfBmub0AhrDHVU+4xP6olqdO9TG7FyJuuHxyxSIUEJ8gMoR2Znsji+QTm9jAL5fTMN+A+v7/Qe+5aPGz7urIVLTstaXUGqJu495rGkh0QGeICB1PFG5vMK6ORlKZDGxdMfn1M/BKnqDwA4rv+wRe0C1w3rLp2P88cs4hxlLiDlPICU4mwsTask8kTvcpJkhFouqWFd36Q6vIOXdKk7Zo1TLEA8gPczQCeomkUIl5hjviz9hAcA==
Received: from VI1PR04MB10049.eurprd04.prod.outlook.com
 (2603:10a6:800:1db::17) by DB9PR04MB8124.eurprd04.prod.outlook.com
 (2603:10a6:10:246::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 06:58:49 +0000
Received: from VI1PR04MB10049.eurprd04.prod.outlook.com
 ([fe80::d09c:4c82:e871:17ee]) by VI1PR04MB10049.eurprd04.prod.outlook.com
 ([fe80::d09c:4c82:e871:17ee%4]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 06:58:48 +0000
From: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>, Frank Li
	<frank.li@nxp.com>
CC: "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "bbrezillon@kernel.org"
	<bbrezillon@kernel.org>, "linux-i3c@lists.infradead.org"
	<linux-i3c@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rvmanjumce@gmail.com"
	<rvmanjumce@gmail.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v5] i3c: Fix read from unreadable memory at
 i3c_master_queue_ibi()
Thread-Topic: [EXT] Re: [PATCH v5] i3c: Fix read from unreadable memory at
 i3c_master_queue_ibi()
Thread-Index: AQHbnW/7PXTpawcfAEm3Y/HvAU7//7OD7ZIAgAEMvgCAAAJv0A==
Date: Wed, 26 Mar 2025 06:58:48 +0000
Message-ID:
 <VI1PR04MB10049E90AC1CB4823F91D1D698FA62@VI1PR04MB10049.eurprd04.prod.outlook.com>
References: <20250325102332.2435069-1-manjunatha.venkatesh@nxp.com>
 <Z+LA/GASTPMMcVpC@lizhi-Precision-Tower-5810>
 <8c624cf0-febc-4ab9-8141-2372bfe4d577@quicinc.com>
In-Reply-To: <8c624cf0-febc-4ab9-8141-2372bfe4d577@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB10049:EE_|DB9PR04MB8124:EE_
x-ms-office365-filtering-correlation-id: 151209a5-202f-44a6-9730-08dd6c33a874
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZKOs0Iv7KfHGhYFXVz0XbJ3JTKY/9j3DsL9W7tx+Bo3yw/XI4XfuWiuNX2f4?=
 =?us-ascii?Q?WRQRK0slUusHDoNOZk2FFg6QwLBmBrWEQaZibg58NxUnu6JGk4YASpXFjRW3?=
 =?us-ascii?Q?NN4ai8eMvV1+wPbz9U36EcdwD+wWcf8mArVdagoL+KUNdD3jKliJziI6BW7Z?=
 =?us-ascii?Q?rfqStRDqIAnQBNB1jx2IkxsNtaBwurC/gu+lMUOQT69+PbvNODT92o54kAmo?=
 =?us-ascii?Q?3LZ5UkJL8RCirV2z1WSvtSwNp4+iZvgKQMx1GbWfOpcu0gl2eI4Gg2VTwdva?=
 =?us-ascii?Q?MzzNYHeRPA0Era2U7AdCNiG62YerxfOMC7rHlNHSKs0xqCiXym7sIRWGqJ6Y?=
 =?us-ascii?Q?vgKvzp9z5PaMZV+6TcfiaZIzNyVohRegQrVJpbJA+O7JY5LYWxds94BCsM79?=
 =?us-ascii?Q?FbgtFWaS2oDEv6gWfRQkZNcVqpkMdjpaz/CtDKz6CHv3LdzKx+xkdAUpQFII?=
 =?us-ascii?Q?YfuAMEpG228yjfnbrz7cZbDMbS5e3zoQi0akWaoPbTq33Zi+Pf2DyuKoy3Sn?=
 =?us-ascii?Q?AWpRiyPiI8qMNGg3VEuCkdAwH4+m84FeaT2uhMxj1kvuadRkEHdDPQM0zdBH?=
 =?us-ascii?Q?9MBVs5Hfc7AC58RL1vNPlnItAZm89989SHXJn3ujCP+NcX6gPoFlF5UJDdOj?=
 =?us-ascii?Q?/yaMFqdkLd2VZ5jGqmHvvxkEngie7eJDK3vvhLq/SUJBubQtnH1fxj4Ge679?=
 =?us-ascii?Q?Oa4m0stl1jNIsqqcxdRnDA0UlBLEjuxGsT2AaJLb3fyKLxMKWOTg69kplAF/?=
 =?us-ascii?Q?Ojxs/fIC2ES5yvmY48KOmzcJ/9+EYZplCa4+cQ2rAGAun8Wn5baK+vsiEgOS?=
 =?us-ascii?Q?6AHxvDBY/4GQeNLBYApVzN+RYzWElRwDl82WbPZJz/vuTn1uj+BUgKIbQS7B?=
 =?us-ascii?Q?/5wU5Og7IcSBrSq1UIjIJw/OVyJK0MklawHDU94ixpDrwogljaLwAzK532kD?=
 =?us-ascii?Q?oD2lkjw9JTiu0Sv2q1gpw+iqOPr/uv0Osq43WWZ9UI9kXZNy9q3hOZc2j6fS?=
 =?us-ascii?Q?rqVM/oQZWJTBsABlhLKFNDsV+TnUQdenTgTFTYig4aOguHPiyH23+gsWPWSa?=
 =?us-ascii?Q?eyN0jNA81UFRBU8joFDT7PiwTJ6NwPWK5akyR9S+qA4NeUkzmlOSeQ6/aHdh?=
 =?us-ascii?Q?40ubaoBvp06w0J3myQtg6Pt1Li0sybirN6M8SJAZho3jvRIgp9lBcmRHhQxP?=
 =?us-ascii?Q?Zys0MsINBc49woCQG2ST5hd302z2d+6vP8EsHZR8u3kODTu9gc2pr2oLXAlG?=
 =?us-ascii?Q?sNEQoWbrvyJXDpU7U1/GECF+2iVe/2Bw1QG0AtqabsfGigLWXClyGboF4LDj?=
 =?us-ascii?Q?FNWf/VhXJyxoBxePUkju2MEPxkyBLR5CzWtOCCPPPp+A/4JHytc2oNLFUmlg?=
 =?us-ascii?Q?KTxDKC+LiD2b+LHik1/aOfQu7EHyiPWv2tI8R1L7YzcNgKWc1aN720qbqwqp?=
 =?us-ascii?Q?+Bp8nnm4/yt5TuVVr8d1YkHXw0DGLdxq?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10049.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BWPOk+XRyl3EJuTXQdzRR96A/8+yfQdymQ1yaGHqsnNjiGEqO5g4FmXAeqMP?=
 =?us-ascii?Q?zrwNmNK8ZY1FEAgKbFr9zxPrGurwP3/mUdv4t+aZ4GOy2j6HIP5C3cKZh9oO?=
 =?us-ascii?Q?gdSMGj/PKRbxv2MHpwBgsoKXBtWpn/iPGs0TFyhMeWyfaqvlqz+lHtCs8mcZ?=
 =?us-ascii?Q?FQbwwRff9Rz/pFxB53KvvRqkjJ/92mObsW7L9qxYWdVbVfpzpeoAdpey5nig?=
 =?us-ascii?Q?/B6VpgauoN0A5oht/0VbtGwmotG/mX5IwEm9H8vcgcNae29lLC8kajT4Rp5q?=
 =?us-ascii?Q?eZZeMHZKnHuIuu5coacbcIFw8Ee0DhkjeczMs+M3hN1lqfcBXhCBkWCKk9+2?=
 =?us-ascii?Q?sX7/k55/d22ny5PTAiBi4bHyRzw4REFCMh1gV1YmBnIVfmQSpkzSQ2sUmtU5?=
 =?us-ascii?Q?g/nrsr8b4WcHwvJbg94Y6TCnfOTwL5nOgTaDSWDD0a+KDS3WSmjsLrTLNG/c?=
 =?us-ascii?Q?qd3i9pjaYY87hTLBvlttVE5yKOYEpcAeVi6r+lmfbzvllz41RNcFZ7+/u4ZQ?=
 =?us-ascii?Q?2e7VMZNzqMQtPLwQ82f0rMJ9mm446RQcohdsDXTEsyeQdt3bgPXqxltqIXtl?=
 =?us-ascii?Q?Jedj0pNq/k5D2sKlfI0MaDFZY/nAaH7uNgApJaKf2YmCncz/EThxjyKFeEdj?=
 =?us-ascii?Q?9UtA8Ygbx4fAPVXF9L9VAGDwSaFpFyn/477O/qOVcURrq1W31DU5cf8kNr09?=
 =?us-ascii?Q?tJxdZp8DfUizdiu9O1913gXzt/7remHoMs8XjcMhW3xH33ZoGta+ymkrAUSy?=
 =?us-ascii?Q?W1SKk9rW8D10hbn6/hXZXWNIXcYvHsDZd/503HucNg82pPeYeAZfz0aQol5j?=
 =?us-ascii?Q?HwPeFk24YzIodwRsksfBn42khto8rN3epSo0c4CK/OycZS1+40XmNAW81Rzh?=
 =?us-ascii?Q?LIL/lLwo5E961Ue+opCiCxc0znPPIJUnGsV+YauAiGNskF7lRFdZS3daHG34?=
 =?us-ascii?Q?OqISz5qlTywj+LRovMRdodr0QUUenaXDefm/5iHuxtyNlfZjt77VdEFlz4Hg?=
 =?us-ascii?Q?AbLZT0dFe+e6GEpByCTKamSGVhU+DYc5A9qI/WddEIp26QkOpBDuj2cMjJos?=
 =?us-ascii?Q?EkOgMSYOEGO+6VLU4K1XxVbRQfiAnX5TQQWsCEh3lKK0NGeG9WxkQFV2VdwZ?=
 =?us-ascii?Q?3wD4A34vvpYnIUPwfhkdL4rBRE8vVScLD+npa/6ufWOdcGJXjywZeZEQHu1W?=
 =?us-ascii?Q?Kio5B7UhcBzqwj0dRKYA80REqij5enh22DA92gyO5Dt68Eq4etP+qOYVn8mE?=
 =?us-ascii?Q?5OtWrXyDIvTTR8ySnzUnywU8PU2WX3eZS73PnJUSY8miCHjRbaMmxOYbuoc+?=
 =?us-ascii?Q?flr/p4JPPDe3P/PV40Mad876OgZg01IcfzQd7l7WsxIn779//dDAwk3Ukp7i?=
 =?us-ascii?Q?ZD6vhZWSAK77gw+ZXwgnpmI4JH9qSs6dBHO7gVdXMIxUizXAiIeoZWcQ4O7+?=
 =?us-ascii?Q?hho7UycZwAP9XS+8vV2VviUpjAGkIr6zIE8YBPg1NDTT7ibfGkWbllUebEGK?=
 =?us-ascii?Q?xs6A6R7v1K4FXblvl5eP12LDMD+sXcPR6izBaiySJz3DCBCOH1yScNDltX2w?=
 =?us-ascii?Q?egoern+VUh5UVq8AjNV2MLz+w3sdrWY9gkLKbqOPfdOxvzVtVIP6m6gyTDSw?=
 =?us-ascii?Q?SQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10049.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 151209a5-202f-44a6-9730-08dd6c33a874
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 06:58:48.1585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +jKOX5ngdNCKJV61z+IwcMha0zfm+CzPQH/4OAQdWO+oGDTk5Br3lRD/47m+L0mMm7SpH3xIyYreQYp0m1qXc5J1zkcEZDy6H4yLlRPv8bU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8124



> -----Original Message-----
> From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> Sent: Wednesday, March 26, 2025 12:15 PM
> To: Frank Li <frank.li@nxp.com>; Manjunatha Venkatesh
> <manjunatha.venkatesh@nxp.com>
> Cc: alexandre.belloni@bootlin.com; arnd@arndb.de;
> gregkh@linuxfoundation.org; bbrezillon@kernel.org; linux-
> i3c@lists.infradead.org; linux-kernel@vger.kernel.org;
> rvmanjumce@gmail.com; stable@vger.kernel.org
> Subject: [EXT] Re: [PATCH v5] i3c: Fix read from unreadable memory at
> i3c_master_queue_ibi()
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On 3/25/2025 8:13 PM, Frank Li wrote:
> > Subject should be
> >
> > i3c: Add NULL pointer check in i3c_master_queue_ibi()
> >
> yes, Aligned.
> > On Tue, Mar 25, 2025 at 03:53:32PM +0530, Manjunatha Venkatesh wrote:
> >> As part of I3C driver probing sequence for particular device
> >> instance, While adding to queue it is trying to access ibi variable
> >> of dev which is not yet initialized causing "Unable to handle kernel
> >> read from unreadable memory" resulting in kernel panic.
> >>
> >> Below is the sequence where this issue happened.
> >> 1. During boot up sequence IBI is received at host  from the slave dev=
ice
> >>     before requesting for IBI, Usually will request IBI by calling
> >>     i3c_device_request_ibi() during probe of slave driver.
> >> 2. Since master code trying to access IBI Variable for the particular
> >>     device instance before actually it initialized by slave driver,
> >>     due to this randomly accessing the address and causing kernel pani=
c.
> >> 3. i3c_device_request_ibi() function invoked by the slave driver where
> >>     dev->ibi =3D ibi; assigned as part of function call
> >>     i3c_dev_request_ibi_locked().
> >> 4. But when IBI request sent by slave device, master code  trying to a=
ccess
> >>     this variable before its initialized due to this race condition
> >>     situation kernel panic happened.
> >
> > How about commit message as:
> >
> > The I3C master driver may receive an IBI from a target device that has
> > not been probed yet. In such cases, the master calls
> > `i3c_master_queue_ibi()` to queue an IBI work task, leading to "Unable
> > to handle kernel read from unreadable memory" and resulting in a kernel
> panic.
> >
> > Typical IBI handling flow:
> > 1. The I3C master scans target devices and probes their respective driv=
ers.
> > 2. The target device driver calls `i3c_device_request_ibi()` to enable =
IBI
> >     and assigns `dev->ibi =3D ibi`.
> > 3. The I3C master receives an IBI from the target device and calls
> >     `i3c_master_queue_ibi()` to queue the target device driver's IBI ha=
ndler
> >     task.
> >
> > However, since target device events are asynchronous to the I3C probe
> > sequence, step 3 may occur before step 2, causing `dev->ibi` to be
> > `NULL`, leading to a kernel panic.
> >
> > Add a NULL pointer check in `i3c_master_queue_ibi()` to prevent
> > accessing an uninitialized `dev->ibi`, ensuring stability.
> >
> >>
> >> Fixes: 3a379bbcea0af ("i3c: Add core I3C infrastructure")
> >> Cc: stable@vger.kernel.org
> >> Link:
> >> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flo=
r
> >> e.kernel.org%2Flkml%2FZ9gjGYudiYyl3bSe%40lizhi-Precision-Tower-
> 5810%2
> >>
> F&data=3D05%7C02%7Cmanjunatha.venkatesh%40nxp.com%7Ceda8be8c7abc4
> 3b4ab9
> >>
> 608dd6c31c8e7%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6387
> 856832
> >>
> 77582903%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYi
> OiIwLjAu
> >>
> MDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%
> 7C%7C
> >>
> &sdata=3Doyc9Wv%2Fj8HMRFIiIGL9nIw0XvI6FsLK2SvsQJ55H7XI%3D&reserved=3D
> 0
> >> Signed-off-by: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> >> ---
> >> Changes since v4:
> >>    - Fix added at generic places master.c which is applicable for all
> >> platforms
> >>
> >>   drivers/i3c/master.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c index
> >> d5dc4180afbc..c65006aa0684 100644
> >> --- a/drivers/i3c/master.c
> >> +++ b/drivers/i3c/master.c
> >> @@ -2561,6 +2561,9 @@ static void
> i3c_master_unregister_i3c_devs(struct i3c_master_controller *master)
> >>    */
> >>   void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_s=
lot
> *slot)
> >>   {
> >> +    if (!dev->ibi || !slot)
> >> +            return;
> >> +
> 1. Shouldn't this be a Logical AND ? what if slot is non NULL but the IBI=
 is
> NULL ?
>=20
[Manjunatha Venkatesh] : I think Logical OR operation is correct,
 Since if any one of the variable is NULL need to return before accessing t=
hose variables.
> 2. This being void function, it doesn't say anything to caller if it's su=
ccessful or
> failed ? Should we make this non void function ?
> if not, i am thinking it may run into multiple attempts, no log too.
[Manjunatha Venkatesh] : If required we can add error print log, Others ple=
ase confirm your opinion on this. =20
> >>      atomic_inc(&dev->ibi->pending_ibis);
> >>      queue_work(dev->ibi->wq, &slot->work);
> >>   }
> >> --
> >> 2.46.1
> >>
> >


