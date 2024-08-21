Return-Path: <stable+bounces-69778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5C9959452
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 08:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A522855E4
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 06:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C6816B39E;
	Wed, 21 Aug 2024 06:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="AVNNPCmM";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="zZkC4I2O"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61EE168492;
	Wed, 21 Aug 2024 06:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724220104; cv=fail; b=CpwJ19HymBeqN538EGOIh9tRoay8Gy+c81FnqVjsoExQNL+x2pcSC8uHqlRwM5p1+MVRNqYereU108qLVqp+mzPvaDTC4syErBZrNH6MybycLNVqqVatZei6mtMFWRu5pRwggB3EGDhagCR+exFtrwhSYi3IsYJ31qXhd/1pw8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724220104; c=relaxed/simple;
	bh=H6t3YybaQxw633hRSBI5R6iOFqhOhEkox/SO/q3wwY8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nnJ/nn2yGyN8jGmukKpOIH9qI1YEzrCnyq5FEMU2x7sIaI2gCP+j5ytggp/6c3Ono4y5ECcntOrz3ekVKNi3LoRPpJbQixaQQyhYKBoOkLynP/ZMGsY6OdFN/8rg3OeELpkoq0JUnARlvMaBDg0WDWNsCXUEmI+TnS8AvVohG30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=AVNNPCmM; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=zZkC4I2O; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L5LYdc016350;
	Tue, 20 Aug 2024 23:01:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=1KTh+qTVg/byREeaOSc7bi/gBSOjazmXhrxbGq9K8rY=; b=AVNNPCmMwmq+
	8jtd15OpJausIGhW6uIKniklGqD+MqbjjVwJqN4S++RgMybcZsz0CFjmz3tNc9Na
	FFVVk7djwlixEeCilYozZ11M+I/UPYGj3IAVOnWF4CDxCf+GavLMuahqwgkd6Ayk
	qK18pHJtA2meuUbsN53q2dhVvT7eg0RV2bDBiljT67xl0MCunfx2hDIgsDxmE1ag
	oN9hj575G9uAlfbtJODaOtuMu2JJOjgBriP8FVEIhFsBpFD2eFJIxY8vfFGdCIZ+
	E+b1nimygcmsKeJLirVluxRNib/mpX98LkUxh0rXmAEyxDceTfANPW44Uj3vcQn9
	YWbT0zPvTA==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17010001.outbound.protection.outlook.com [40.93.11.1])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 412rdtxwrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 23:01:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJ3sTKIaPV6JalQw5bfJEUP2J80/cw/j1/Nueq+E61a8x+tvhDxEMllZXf+9xF+aMmDU1khPGkY3LtTAN3Og06IYURXiVgEdY2sg41dwT3piQEQ1KoqlL2p2ZuqmhHZKQNPRHo8hP3Awut/+ou1EUeq/ronyJ+3zePet97cTnbnQk8HvKQRjFIBgAMILJHCmYUGCOwh+5UEPTnAbvjaaeqvmjm03dtVJfxRJMIhaBkZu9VUVxXmrxXO/X35/znKx/FVb0rBB9boXgjn+gph7foGXWbDnjI8yBHpnkNH6fmcnW9X/bnCeY5lWGFxhfHaTacjf0qn2IIJo6h1yoUX3YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KTh+qTVg/byREeaOSc7bi/gBSOjazmXhrxbGq9K8rY=;
 b=MZNiXn9gGNocTmYStAfNxJlTyXKUBnX6tpJZFZ/1VNPeJj0aAUqg/1DxcyN0OulFC57CO1qSGuzL+0Uh5sdoouvWxPuRacBREZ7fQ1FjpGiKa8clZL/EIQ9I4tJUdRnA+E22NAkor77Kro+sifLOaEtJJYZLOF1s1ZIYSIQTHJVxqQTQHXGIPBf/XzgTLwhjNbSnQK0k6HgyW7u2n+j42VTRZQiZDdzhQif9+B0npehF79oksw4vzP+U3vA2ra7dzbgGA88LH3bDIPQQaIiESSf2cIlE4zXZuTX4/Z1j2lqAtgurE9coTKGj/CxUYWS+NTEYltzqx1aWxIrSSjTrmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KTh+qTVg/byREeaOSc7bi/gBSOjazmXhrxbGq9K8rY=;
 b=zZkC4I2O2LQnl/bO7X8Fmgcuuvp02AvbbFDpjji20kSDSHwfFrdBOTe82f6nzzZ2XBi0tBXA/V9FWFm1UNlVtj0koevi6MZTLxnE4tDmMTYkoOQZd1NqN+XygaZyIT0gil+91vwqg+qbs6i6Al/NOPtfsi5MO71qWbBRerBTkxk=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by CH3PR07MB9957.namprd07.prod.outlook.com (2603:10b6:610:1bc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Wed, 21 Aug
 2024 06:01:21 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%4]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 06:01:20 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: "mathias.nyman@intel.com" <mathias.nyman@intel.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v2] usb: xhci: fixes lost of data for xHCI Cadence Controllers
Thread-Topic: [PATCH v2] usb: xhci: fixes lost of data for xHCI Cadence
 Controllers
Thread-Index: AQHa849EgXZwkCvzRkGEckvtaOr0EbIxN50g
Date: Wed, 21 Aug 2024 06:01:20 +0000
Message-ID:
 <PH7PR07MB95388A2D2A3EB3C26E83710FDD8E2@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20240821055828.78589-1-pawell@cadence.com>
In-Reply-To: <20240821055828.78589-1-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXHBhd2VsbFxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLWM3ZDNhODkxLTVmODItMTFlZi1hOGIzLTYwYTVlMjViOTZhM1xhbWUtdGVzdFxjN2QzYTg5My01ZjgyLTExZWYtYThiMy02MGE1ZTI1Yjk2YTNib2R5LnR4dCIgc3o9IjU4NzAiIHQ9IjEzMzY4NjkzNjc4NDg1NjI5OSIgaD0iWDdEamtFVnh5UG5oZWQ4YzNsSS9hUTdiZ2hZPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|CH3PR07MB9957:EE_
x-ms-office365-filtering-correlation-id: 490491ac-22b9-4772-2447-08dcc1a6adcd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?laO7LfdXAShNMHnkN7qQ/o5Og7WPXEmCaKUI207xTqdLG6TuEmfJvDRULM4f?=
 =?us-ascii?Q?17rJ4DIzdwE6EuVyBXbakfLV0vo344lEHgWkFWQ/h1tfITI4n9hoSypDreyN?=
 =?us-ascii?Q?UMybiB7hgv14bdmIGr83Q2TaORNCZUnWUu3oIv6M7Ljg/GGveZ4Ul1y+9psi?=
 =?us-ascii?Q?HVT3VfY4r5pX1oEMpRzvNsHxQPkS4+POh3gzH48tc4azSRe/FlNnaKZaEjbe?=
 =?us-ascii?Q?/fiR1jCaWe/QZX3RVO4N1eAxitr1jXR/0Jl3n/mtiwC95UMDTQzN1lTb/khd?=
 =?us-ascii?Q?0isi+iR1RTwyh0EJ2Z5j6YsHV/V5i6aYMW9GkP/e/feR/EVoxbYUcqgMlEHe?=
 =?us-ascii?Q?hoUDPJ0YWJmBofYY1PKrL8LexaJvU28dlB9JuVyA/ZGZI+iuiGO7gxK0gu9M?=
 =?us-ascii?Q?eIE9Yyq1ePkv41SrkuvNrDYlu7z6sf3+5ZnemwicrthFlSpH8lpR87X1o4An?=
 =?us-ascii?Q?YqibPIalP8oek1HdnkGOpT2wEjIRKoN4/W4H9PLxAnHGYqj9dRncx3QDpIHx?=
 =?us-ascii?Q?uwZlV92IT2Rximp+wI7F9Hr11gqniC3aQhUAhDfLklBYeUZE1VZJ1hxjkTMW?=
 =?us-ascii?Q?//+t8nHuFXTsnno+sycseUQzmGpEZzv2q5353QUl4swfwEFknrikqw/77MN1?=
 =?us-ascii?Q?kzPWukeHQGg1i6hAGJxmu7oPioSe4RUyzejD3N1lqLvR8pAALKk7Ga8ZM1G1?=
 =?us-ascii?Q?LmSeYRv9k9yYen1BPWPBRXRCdQAegWOFHpJzF2QdMDyuskT7GXWbSLG+Tyej?=
 =?us-ascii?Q?jVPRV7b6CzUwZKEsf0x4FUETxrlo0kGJhPE7pGpqZGJ69Gh0JsExCynKBkXy?=
 =?us-ascii?Q?X2BFrZ8G5x+o9xVBiOmGJvqNFZ8X8KV4bB6og/3ZMVW38ziYYjVi7UyoZEbD?=
 =?us-ascii?Q?fJIlzNUIGk4eVGK8xWuZOcgTgUR6d2sofETV6uVwkxkKU5sfpo5KvsCah6vH?=
 =?us-ascii?Q?R8u1MdAETRrGp+9w4EGg/5TnV3JbmI6UW/nUhxaxK8I4d6wnjIYBEuUpXhOx?=
 =?us-ascii?Q?NgtzaMpAs0KGKeiclTV0m9G85lY85Du8wLO84ovF0zTz2ByyXIhjvji5la+L?=
 =?us-ascii?Q?u2XGMHHfoUgNi6mLsGwq7fnjfzltVVBC3y8joKjZvqR66jKLukxA0waPD+bH?=
 =?us-ascii?Q?FdWfwCnwSGlnnAo91/AnqG55QH39ceFVhVoCT3bFi+A0CQxRy7pWEG3dvJrY?=
 =?us-ascii?Q?czhe7k39IJFAmxb28k3TidHHK+CdvRF9HWRkhpkGWoS0LpKreEcX1eZeFr+U?=
 =?us-ascii?Q?zNUQNTJpmF/cXYYaG0eDWjlznhLA38NuQcjWDOdFlZevcHE6didAxZnizjhf?=
 =?us-ascii?Q?RzgqJI0Uibmm2/VqlHGNFVmesd3jAUaXVvFnRNZQgREcHTtbwYSbbpIpdVfQ?=
 =?us-ascii?Q?p0DPLplW2KphVqugo248BauhNMsY7kOss/EkhnowWZo+3/FBgg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5pyreB716XgwjPUdJAjR8eG+sb220vcsV0mifJdvw8JQ/pmsMDNnvHrHWWun?=
 =?us-ascii?Q?hInOPbtVbnRP84CAxfMEqOS6HxGYjZ8NdshtbnmaZA6c4LuX17IP7r+2MCL3?=
 =?us-ascii?Q?RDppkK5jrJ7bQto5kCoewj9P4Q67Q5Bkc+/zpnuq32cvmaf9Fe3s+tSn5paQ?=
 =?us-ascii?Q?SvB8c3BBfzl/nuqFpgU7bmc8+vIIpHwjRjvKQ61wcGSpgvBcuemBCHOEDd8l?=
 =?us-ascii?Q?yjGWeTNpjyWJXEuksKyybvY/go7qnyUZKCdR3xzENkHcw1Tu8kT4UxyKLi/F?=
 =?us-ascii?Q?6jL7sznCuZvCSKzXZO1EaUka0aGUx7oQaaZjHxXa2srjWp4GFGHlnGxt0qDG?=
 =?us-ascii?Q?JvGHSXP2QmEU/0e/0/bdTObtvi6otYiWCBLS2rZJ2utIZBOQOIAlPfEQABCX?=
 =?us-ascii?Q?AcfC+4D4iICO69ICL6SGl3HEhhUMLlC1moU+kGXeAFw+7zQPsn3Dqd5oM8DJ?=
 =?us-ascii?Q?jZMAEbiWTF8jUKqVvJQ1UTPRC3uHBd+Ex8U3ze57iV1TmHoFf83XJ0vQtLhK?=
 =?us-ascii?Q?4h/P0VSzIwbuirhXJs8yZoTiRmY2TkEj0AR18ix0m5Q2STolPzAcpMxhBILE?=
 =?us-ascii?Q?P97IbWZ6pM+8ge9cVU2Xa3PeYn0loAzrHwfzagOM/FadCbPKSSQPwD6TaGMe?=
 =?us-ascii?Q?tgq3/q7oPFjnPfhwSH5VRKXp8ojkaohRmkbi4gkfNciWcuxpSWCkhkOtElsU?=
 =?us-ascii?Q?iGv1F9h95mnq7pgTAczNRPnfDVeUU8+kdMalu3rBpPweZpEfn22uwJi8VZVz?=
 =?us-ascii?Q?J3eImM4bJQ6xvgxD3hFYqBJlBcYTIyqyyRg2Kk7h91GUI8F5YHJP1WELvT1G?=
 =?us-ascii?Q?cDraaKn8BeHIAF4d3u5NHzXt2Gex8Zlu0awW0Y3erAe+7jOPIue2jjq1ItBT?=
 =?us-ascii?Q?n0xJRA/36akBznsAkn66LicMmtqtsdP8Am/+dP9+tf1q5RGsHWVjJFkQZ0pH?=
 =?us-ascii?Q?qFPg3MTpKyhWF+vx3SwIIyUoXT16SLZnWcV3gRvmcXf023kEVd75t2atDQ8D?=
 =?us-ascii?Q?ZaGUhDJ3vuwXHn9XFb+BQ40/ll2v6wlpLRG2rA/n/KAkOFa2Hjf+jjOnSVRN?=
 =?us-ascii?Q?sXnLQfAGGsLGlnhFpzuNqN/D4Y+cqJl/2AAZRMWRfd0865fERHaTQLm8sY2W?=
 =?us-ascii?Q?pCMfA36BMnE4Ar5CehYowwh8//psX3amXeybkJ4kPzTK6JzTiRFKtwo1+A99?=
 =?us-ascii?Q?MOm/t6r55MmZrvIpOwZjJCTpO2wI+OcKU4JxOhoVr4uDJglVL1H3sGUtSymv?=
 =?us-ascii?Q?G/uAbPqXQsn7Fu/Az3UCPsoKbh8IWRWzcjy+I3NMhF9Ee/pZAKRDpRBBNFVO?=
 =?us-ascii?Q?gKhQXfGBb+sD7TsIJnVjLPqQMhgy4QXdTkm2iGWO9zVflluCjTwHmsaacKVz?=
 =?us-ascii?Q?TvW3CPymZRRYno3tOhoP5seKvrV2Lz3Ms5IOejAnzQEqbUKptN47wfeMNFK5?=
 =?us-ascii?Q?/PO5LEYslywK+LkFs/J8oARSAB3ZBYwSuV2BJcKy7ylngK3NfQcpZbb5E/LK?=
 =?us-ascii?Q?mvI6H8FsYe12Q71RVZg1VSaMplV6N+dthi+UvaE4X43OHmljPezOCONnUN+e?=
 =?us-ascii?Q?AXrMBPnXjYc13FNw/kKokAjEyHIdqoq5KAXlK3tO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR07MB9538.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 490491ac-22b9-4772-2447-08dcc1a6adcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 06:01:20.4212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TqMIK2dB0zHqgk8uq9B+7gXqVtZ2fnSPO1Au70Tk92HYhAfJfTBh4hwd2fMmLJwZ/hypR0bH84TLef74HsvtAXj1OIj3428Kj1M7m2Ad9Xs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR07MB9957
X-Proofpoint-GUID: _4f93AR6sEbtrYd4joMnFoEJVZ7Ps8Zu
X-Proofpoint-ORIG-GUID: _4f93AR6sEbtrYd4joMnFoEJVZ7Ps8Zu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_06,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408210042

Stream endpoint can skip part of TD during next transfer initialization
after beginning stopped during active stream data transfer.
The Set TR Dequeue Pointer command does not clear all internal
transfer-related variables that position stream endpoint on transfer ring.

USB Controller stores all endpoint state information within RsvdO fields
inside endpoint context structure. For stream endpoints, all relevant
information regarding particular StreamID is stored within corresponding
Stream Endpoint context.
Whenever driver wants to stop stream endpoint traffic, it invokes
Stop Endpoint command which forces the controller to dump all endpoint
state-related variables into RsvdO spaces into endpoint context and stream
endpoint context. Whenever driver wants to reinitialize endpoint starting
point on Transfer Ring, it uses the Set TR Dequeue Pointer command
to update dequeue pointer for particular stream in Stream Endpoint
Context. When stream endpoint is forced to stop active transfer in the
middle of TD, it dumps an information about TRB bytes left in RsvdO fields
in Stream Endpoint Context which will be used in next transfer
initialization to designate starting point for XDMA. This field is not
cleared during Set TR Dequeue Pointer command which causes XDMA to skip
over transfer ring and leads to data loss on stream pipe.

Patch fixes this by clearing out all RsvdO fields before initializing new
transfer via that StreamID.

Field Rsvd0 is reserved field, so patch should not have impact for other
xHCI controllers.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD=
 Driver")
cc: <stable@vger.kernel.org>
Signed-off-by: Pawel Laszczak <pawell@cadence.com>

---
Changelog:
v2:
- removed restoring of EDTLA field=20

 drivers/usb/host/xhci-ring.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 1dde53f6eb31..e5e1d665adab 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1386,6 +1386,16 @@ static void xhci_handle_cmd_set_deq(struct xhci_hcd =
*xhci, int slot_id,
 			struct xhci_stream_ctx *ctx =3D
 				&ep->stream_info->stream_ctx_array[stream_id];
 			deq =3D le64_to_cpu(ctx->stream_ring) & SCTX_DEQ_MASK;
+
+			/*
+			 * Existing Cadence xHCI controllers store some endpoint state informat=
ion
+			 * within Rsvd0 fields of Stream Endpoint context. This field is not
+			 * cleared during Set TR Dequeue Pointer command which causes XDMA to s=
kip
+			 * over transfer ring and leads to data loss on stream pipe.
+			 * To fix this issue driver must clear Rsvd0 field.
+			 */
+			ctx->reserved[0] =3D 0;
+			ctx->reserved[1] =3D 0;
 		} else {
 			deq =3D le64_to_cpu(ep_ctx->deq) & ~EP_CTX_CYCLE_MASK;
 		}
--=20
2.43.0


