Return-Path: <stable+bounces-254232-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIxYMsT7FGpxSAcAu9opvQ
	(envelope-from <stable+bounces-254232-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 03:47:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 416025CF809
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 03:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 884AA3020028
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 01:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB312D2381;
	Tue, 26 May 2026 01:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="lRUVBt8O"
X-Original-To: stable@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E991DFDE;
	Tue, 26 May 2026 01:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779760053; cv=fail; b=mO13BYV587oD2K0+ry3rraOx+yOHxQxLRZ7n4RXxkQSIGKd/TwO8hf/96VV6gjTNBklccJTM1vPP0Homcdg/8cfn4Ft0qBrBOhhR9cE1W3/d4ee1OzBN4F/CoKIkWsj/lJbrDVfIv5oqF8HY5Fq8W4VQp3EnC6N0Pg2A2CCrnok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779760053; c=relaxed/simple;
	bh=FwRFqbSSIy1V7vhmaJBu0FGeUFX3QRaDNTF95lLg+Ek=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jyDtcqFu6/TK6HciZuUdVHHA1sHz3PpizM92sF2WbNycn6y76f8Y0i78zliTkPuZMfbmJMbVC+xrvnWTNLXtvCwtKBIbLe2AVRPidOJBlQ+LPD6k+dzY4lIjvYbamLbhXTwO6TMa9d2a603nA6HgIglLrlyXbwFUI0mW7x3cEC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=lRUVBt8O; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PN0Bcw1169297;
	Tue, 26 May 2026 01:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=p1; bh=ZqkTOeK
	S2piisI1Ipo29cfJ0jrXYiPOTPI4yQc67q8c=; b=lRUVBt8O+xH/z5nxrMfeiwI
	GfjALpLvrbLeNLd1YbwJO+ZQhMyVX3EbzyvdYjpQYfKwOphT8GQVOcXdyP5tilFH
	BX3k/qRid6tkS+wPEnjttl/oQq2QJzQcOiMU3r6wh4QzO46+kspnsJCfy3X8n2Zo
	clLgncumPPl17p4y1N81Ax1DfpXHNzVJMBNJLaHjn0EOQHo6l3UchZJd2kjkxNjn
	HVXwRu79O+JLnQoelPWqx5DH69w5hY1HUJ86+P0fwj/dGZSzi9cub61Ygcur4HOv
	5R5ka6pK7olrophz/2b4HAjfOWJomS+mOGlA8vkvXQQzYdmtxO2sShWAY7GfDsA=
	=
Received: from typpr03cu001.outbound.protection.outlook.com (mail-japaneastazon11012070.outbound.protection.outlook.com [52.101.126.70])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4eb4a9ajf1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 01:47:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1Yx51vN6dEDGzIDYGSHokZVzZAmqV1qD6l8iHaxvILEbFi0JBErUlK9caqHC9TXbKTuKY9Ha2l99hhwlf8IZEgVKkRGfZj+a8LGgRE6iH9JQjGOfZo8z6AwA1cZsgB2rCbev+Hzm3SJvp/do+D4w5Ij4dMNqBNBWNcJoO8tPKCGjTCBv35wkCgNwyHmzwjwE32UqIorpDEiDndiwNV6Ya+AFnwsktBXppgTL885J0lFE2tdNIYIkHT1uJJuMoDhWHFij+fRJOi76YR3PDbDGs0aksQutMSaw6rsqCN5w+2fL/7Y7PnxM7UMwoZxpEKBe6UCnW8eCY9BfvUEMfqcSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqkTOeKS2piisI1Ipo29cfJ0jrXYiPOTPI4yQc67q8c=;
 b=kKMakCkz6MB9rSV7Gm2BRMrxWsRITExvaNTXJlKuArRoghKJ6k10uWNYpFaSPKrE1DIYdJedHBm7E6ttOX6R+yFjX1s2llpp2XqTizLWBVTNVVWHgg5nMf/yyYlPZwU24u3iJojWIXXa9mUKMq5buycoUqtKexqTO1Z8PRjdorayLXRFhRRinui60WdpDxek6SwtSUbxxsxuWvhpX0t0lEPE37gvHxM1vNl7dSJwY+0dRtLv5tfxKOZkBUPFUH6mMeFl0MrjM1Ulr1wQvWITJ2QkilZKLeaT2bCShyJFlKeaRteM0P4ypNZO3m4fSnIoAFRWZHWGtN5gGc1OolAztg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYPPR04MB9014.apcprd04.prod.outlook.com (2603:1096:405:31b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 01:47:02 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c%4]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 01:47:02 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Rochan Avlur <rochan.avlur@gmail.com>
CC: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rochan.avlur@skydio.com" <rochan.avlur@skydio.com>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v4] exfat: preserve benign secondary entries during rename
 and move
Thread-Topic: [PATCH v4] exfat: preserve benign secondary entries during
 rename and move
Thread-Index: AQHc6b79qMQ7hXyGQESKmsuap81s27YfjUQs
Date: Tue, 26 May 2026 01:47:02 +0000
Message-ID:
 <PUZPR04MB63162D8FEE0B2F486C14888E810B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
References:
 <PUZPR04MB6316B8342BA4AFD993DB8D7E810E2@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <20260522074441.24645-1-rochan.avlur@gmail.com>
In-Reply-To: <20260522074441.24645-1-rochan.avlur@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYPPR04MB9014:EE_
x-ms-office365-filtering-correlation-id: a4c0cc7a-32d9-4495-8cbd-08debac8aeb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700021|11063799006|4143699003|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 mt1X14JXK3cS+fzPk72DQfwrcgpXunQIdiiNmMIcQDJa0YZcDW9FWronYtNsiSKcyxlz8aBFlPJ0jYoysv5wTYGkqnX0qG5evV2AjX99xpZgZp2AjGKFdD0Z3TVT5DOU34EmoN6pMXT3ADVUvrjHwpuCwKjUB3u8AQ+bv+FVwFJ4x3SvtwP/AkPm+8yIYVZDb2UE7J1ZmmdKmH0thEBQ3dEIbTnSrcoDCYeUCCIyj7HetgGZSEnmM01vhH5c9S+NGuYs9vFU13G5OaF33xqKLoecHn1hm/hAItPDZi5K/EeCjnmNXBmvoudlbyK5y4k2Mmf24dsJikH0c9MkTVR3aSl+W03agmZxzLPscJp6kl5Dve6QpwFkEWfY1bZZwCS84h0VV3hF7ltG133ZUWwc2GxceCl+79YPKPfRo6bQpC997xDG7UkdM2ht1N7kYw9CyPXrkgEOJCS8JK2dN5tt1Wi3xxvk3tuvo22krwoRQCQk1Sy5IaKLFgGYDGNfLDRSRO9PKAdIjFh1DAnDOOZf9T8GuNQCRpdTKs8DAMQ31B/NBuQQp0im7+QVZ8BhP4HfLPRwZ3P2oOR/Re+Ham9DfwpZRy+VoXBWxCEqDnzN4k/6ov31P1EKf/31C0FxWLWY4BEERFKHT3QvDRLUbSag3iqrdQhKJV+YY+YHafg6nBQAvMq4ub32jxXdJi7eljpYEnjO/W48UECIUMRk5yM6uib6DCjXrqkri5BvbtKWVQRsDyrqwEUVQt8ktqWlr7dm
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021)(11063799006)(4143699003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?hwz9giBqLh9tMWvdEGnEQKpoqvfHnjI+bDTElx0dSluE0rqpnkqxwsz7VJ?=
 =?iso-8859-1?Q?mRmg33Hp7UOhJvr+6Ry1rC8P1gT+fjcNDhuAy3NixnJ/4eldtYDfGhwuPQ?=
 =?iso-8859-1?Q?1wT7K7Qh+izkhi9HVceOWnWcP1TgZeiwFY0KgJ2pbm+pFJbAJdYE+arVlu?=
 =?iso-8859-1?Q?is7W/UunuiFu8e3vE6ySGnXcPdabmhtvA/9UHB+NBvLpn4zOdqu0nhFRH6?=
 =?iso-8859-1?Q?SVtaoVDXjbfN5EKh6Yj3krblQtljG0/e7U5MOEY8gmBgxgztnZ5NTo6u+1?=
 =?iso-8859-1?Q?1NpZRul1iwlr8HHNKapJq8wDWv4q1sSojlgrtWUrY/ObvrKrpbnBO83Uj6?=
 =?iso-8859-1?Q?ZKCx9/HY9uf0nKJag5xWCP4Ua0ZVU0KotqHBB9UQWd5IHBoJpepUgrdE7c?=
 =?iso-8859-1?Q?rqlWmO5v3kBb6I4xQiD2pQAOkdr9vsOpu69JeZTO6BNIacx+3FhwV1CjPm?=
 =?iso-8859-1?Q?qFPwcVzEZ2XvovIeLLx3ntUxw4qtOiT7O/ZCLgkCJ3nB+NZ2beeo96frO3?=
 =?iso-8859-1?Q?5yF6Rn1n9Jr7LO8BvxveILd0vGC41Whc3IKFM0bH895U523ro2Ux3xlOpz?=
 =?iso-8859-1?Q?I0iZ0Y518kg+xHmaKmTdX0fSrIexmYNHinFmQtfI5O8eM57bg+CyvIUV31?=
 =?iso-8859-1?Q?PeabqhSvSr85nQByy75V2wssIrIPLw5IHBIFlcFsaCz5AUxuMpH8q78W96?=
 =?iso-8859-1?Q?MT12gmtdHzXVUrpxyPiFybPPB3oHMx9uyfnXyNsiwGT/ERFS905g2su+Dd?=
 =?iso-8859-1?Q?bb58GH1nNfckC6Nkj/SU9nAZH/AgFAZuh620W8d95FrsG9ybN4R9fDZHjm?=
 =?iso-8859-1?Q?1FH7kFQoaD+NjKS9uh35eb0yFQPe82Y+fISrc8h+P9QsdckMowhTniU5kj?=
 =?iso-8859-1?Q?clDk/QDefc6JTC4U5+movvJFFrNBxIry002EGyVYfeE45T2Wc8zjLsvjF9?=
 =?iso-8859-1?Q?rsSRdLSoyrWVKIFieOfd3HdJkucJPovdX3s4Fg6GStT4vOgnisceLK/we8?=
 =?iso-8859-1?Q?YnxSF4aSlDoWFLEVdHCxTTeEKzZu/OfCPqb/YzVzV8A2y6yxomFHLGseGb?=
 =?iso-8859-1?Q?sFD3XNsQB2RVcb2DUVEQ/V68l4vY+tFEYO+xrhK/ai7nAnp/BdWnHuLXRe?=
 =?iso-8859-1?Q?pQRCBFse4jECL1vrz112nWh6LfDIAYAFCwcIGkP23xo+AYVvN6jhZZyycy?=
 =?iso-8859-1?Q?smG1AaV2s0EMJJpTZ6AoYdwPz05KOAtlUBYIs/4pGEzhtqcJNZS6x3RcZI?=
 =?iso-8859-1?Q?ezW2mNi6OHSw9fI6omzvy6bjLVKo9yhUi+u7knN/dIckkGvTN0gQZK0ukB?=
 =?iso-8859-1?Q?vImp8hlBcnyd6hB/9gLXtBTvLf3PfeqllMnS/zg3DHZutoYj9S75oCZFVF?=
 =?iso-8859-1?Q?WoAtq6VxMQGktabtOUaaxGlo2xmL1bX+ORqK/sHRa+eRcrz/HMeaxgPyMO?=
 =?iso-8859-1?Q?hPZxlOVbrqCnSGoiJGoJk0D8533gjcebxmxRB//ugCKSwjpnpDnuG0hIXG?=
 =?iso-8859-1?Q?aEz6TtLovNBHLlI0KNpdRghg2SAyCcSyvQ4Gg8iK3qvqe7BN5Pdc9E9fs0?=
 =?iso-8859-1?Q?j441ADaIQ/hXt7sizg9TC12IayARFIdPFp2egK/FA8FQfKRvi0SJ3Nd6ct?=
 =?iso-8859-1?Q?IYI4TtbCS6+l+V87/MN45i6OU9TSwp14X2HsXw3MhpMqmqCZHwokiGTIvn?=
 =?iso-8859-1?Q?sUdnhzmDqXfCIQMriGFzZwTJ0BAq5uvScFhF50vaM8gIgodv54xpS3VDEy?=
 =?iso-8859-1?Q?GNoHHgDKdV3VGNQEEbYrWhLvcQzuA4LricCkSksx0MClPL3FI925tzZdsH?=
 =?iso-8859-1?Q?fn0V/tHFmg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	VTD7TrPND6KY3i4dfYKX9Gjr7QA7E80wd6nA+X0ivlSKyNWkXMgfd3h/KiYZpy8+VmPgymf8HslP+YNC+6U9OJX/MZKonJuvIbmQHB6rmNwfzim3a67hgVqAR7xbgvliZboBqzUQFT7AlIsA7P62JIV/J+8yXDRWXwbg+JHDzQjIDnCWvzHAYSPVi8gB2an2pYlfAC0rY0DsK1dnwh+hAYZPhqq2mKR7w9l75FPfZfOoJLAmIklRV+wCA9CkUFNmnq9ToUZmjzyiXhG0N+dn8CFAgCNTF3nJPwYdeUSwNwO7saXch1i7C7dv40dB5FjEh6lvmWkZhF1kNppqt69wjQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aGtbK4wMX+3SFeMYCTV6DT2M3z2c9ZyxonnJ6viR3Y2JXIUM1Cjuz5dV+AjYXrztkoyG81/ymOpzQj8eT/W3mN0g6thZvLhIdje/o084LYRV1tWH1SbQ2NW48ZrUX0kLyul+ICLs//8kqCuSxkNcpAV5/cz52EDl1LGCbP1Aw2H8CqztFS5axmyftInWAdM97hso+nQiTrPkN0zNzldPDzg5JkyYHOmTq4E1xITlOl0sGHMRpQbgm5VDNfPgiKm6z0KC070Dz5y8GnsRFuhRR+VGo3rctSyHqgv/Y/p2F92uL+IU605gJRECDBmu8zgXBxcTs+9s/dkY1MFQEVNpE73gMWZOmYVmiMbErZcbyufKKQZBoXiDVJ3Ns4dOmb6pBmMih6HW/DO7lTjtVlM3F7VQx1GG0spKmHK+RNpKxTx5/fhKPj0vFC6WXDI1Amih0YOiJLUJlQoN1EdELtUIPhqb9datxWvVz4NGoN/MCHKdeLblJu2viAz5MfmbJDHGz7z/qQOHm5afBKyBMDac2k3/tt+pCsnFJRv5BREQO+fckGh0++jc69TEH9HWew5oQP+BD6u5nxYx0Xv+z6q3XXJFo6AG2a0SC3MyyPTixtxQX6I3c5vcz8CBlFrXfsMc
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c0cc7a-32d9-4495-8cbd-08debac8aeb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 01:47:02.0650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S5lLoMQ+lz90GrguHW/PvFSEqhCb3LAbN554tfOHBSHLek+df1TcEEMdLasg3rhmjoetBTVjTDANcjAEq7bcLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR04MB9014
X-Authority-Analysis: v=2.4 cv=DvdmPm/+ c=1 sm=1 tr=0 ts=6a14fb9a cx=c_pps
 a=pfqXIXi+oXeZ2rkBTVRc7Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=NGcC8JguVDcA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KAb5x4SsHD3PzxGk7EmX:22 a=cIyGuqrkuvkXWOl_fzuj:22
 a=z6gsHLkEAAAA:8 a=TSVp5swo6LpNLtneyT4A:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: XaZKrtD1Tj2BS-B3292ATF-pGwds7Sm_
X-Proofpoint-GUID: XaZKrtD1Tj2BS-B3292ATF-pGwds7Sm_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDAxNCBTYWx0ZWRfX+NfjB15TFTGD
 bSJcUstLvyVBqvhN0BJylHuaPxpdTeNnR+Fdq2NQnmcRGgsBMkn94wk1yE4rIyPePe22GEoVL2h
 JIVGssmKc6MJSXqYhKoVEa/olT4nfTu30/XGeTyG1VOLyDGM/haUQK2N5l7aKBOk/QSgfL03QN/
 /uUB4Y5bA+9oooozP2Dd4E3vWmxBbF6/tiLMn95+m2CAZj4V7CyepHEt2VvZFoCEx/UJMtvQgRr
 9ca0P1IL8/EG5LkYrsrQ5rCsvj6Qq9QZEYu/2hwsTa9wFt4m96rBBESEsy0F6U+Tp5pBO4ny0Ps
 gImIe0JTzWrZb9aejvLNGm4/dlcX7TR/CSisy4X2wyOAefAqlA3kOnHxssApSzrxczQmZJdBcYE
 pmmRENR0Ldvl8Azjp4CiGz7Nk3MJnkBKYMmXshSflUAMF/8hVldl3OYj0oqUQEsFg8aHIpIe4yK
 k/afDlQRLUeD3xQw0sA==
X-Sony-Outbound-GUID: XaZKrtD1Tj2BS-B3292ATF-pGwds7Sm_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_07,2026-05-18_01,2025-10-01_01
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	FROM_DN_EQ_ADDR(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[sony.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sony.com:s=p1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254232-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[sony.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Yuezhang.Mo@sony.com,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 416025CF809
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>         ep =3D exfat_get_dentry_cached(es, ES_IDX_STREAM);=0A=
>         ep->dentry.stream.name_len =3D p_uniname->name_len;=0A=
>         ep->dentry.stream.name_hash =3D cpu_to_le16(p_uniname->name_hash)=
;=0A=
> =0A=
> +       if (old_es && num_extra > 0) {=0A=
> +               for (i =3D 0; i < num_extra; i++)=0A=
> +                       *exfat_get_dentry_cached(es, num_entries + i) =3D=
=0A=
> +                               *exfat_get_dentry_cached(old_es, src_star=
t + i);=0A=
> +       }=0A=
 =0A=
In-place renaming will only be performed if the number of directory entries=
 does=0A=
not increase; only sequential copying of benign secondary entries is requir=
ed.=0A=
=0A=
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=

