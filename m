Return-Path: <stable+bounces-230599-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMUmBfo7xmm7HgUAu9opvQ
	(envelope-from <stable+bounces-230599-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 09:12:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED490340CD4
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 09:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5955930275EF
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 08:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4180F3CEBAA;
	Fri, 27 Mar 2026 08:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cI6FJOee"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010005.outbound.protection.outlook.com [52.101.69.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D75D1DFE12;
	Fri, 27 Mar 2026 08:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774599157; cv=fail; b=lTaJGVVaccDvQ5EbqJ1r6dPLyY4vqP+QVJ/8/lBVB1sHhQ3CaFPcBuq3MLKsmtHs/tg/J0ryFATcWmRirTUiMXxUczFZ7uhxn//1hkePXOAKS3FbzKVSsAj2U03zvrrRj/YxOXm8HKTqI9xl6VM/aAmoxdk/JcgSKjZWtqRtNIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774599157; c=relaxed/simple;
	bh=MXRhBa+yL2nbb4zxZVnZs2Rf2oQ5Z4rio4jErzgIE1o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TQq1FIzrIgA0WRHjfQBtI+tO0M+I17QAdtLcKvXZnZhVU3hpBNoLbonqq4Wgo27U2BPCVF0qCPCjwjWEfZfJtBFA5R8RObxlmx1VfcDFDfdWaAq0rlY+saLHfo2Qm43wRqykY2pOQ2VIN7JVAEIEcC3+lyt+ay51RJcsfjosrf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cI6FJOee; arc=fail smtp.client-ip=52.101.69.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlQzwCPZ8da2M80Ddmg3pYHinzs6wnTm1xJMO65UzhztNUaU/qnvxCW2QMR5fJbXN1VEYzLWsoxG3NzS/fdj9oduZbnJT7gO+MjTHPraa/ALIHeeEMHrFeyy1ojl6Evj3BrydS+nPakzDJvz+mCFhnPZymMt3iTdZ7IY+Fs2bI8G/DUJH4N+hKIbAx8JURvSAKh6CzpVHnM6Jk1mg4f5lFGKqbevK/rB4o8EUFWOLPJptWrJYbnZxH0cYUeNDGo4NeMRpzFhyvHVS+kk1SlBbwxgM4KwckazACxazBcyBqL5wlvVSjOZAEaGRJt/3zpAPlDsrv0ud2ftZDuopTbjdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXRhBa+yL2nbb4zxZVnZs2Rf2oQ5Z4rio4jErzgIE1o=;
 b=JxLHd0/vfmq2o/a9B50CbZ5B7S82X7VZ0n6AwJy7j3KyQSbtpiNnBoW2e6mLAY5R97rDMZU5wklp8cJDI/x0Ys+Kc7qLk7WUAxgA9cgZrMlIM3HwrZMWrGDmMZhX9UxlSG/Jj1loUbtevOYonmO2pIgrxKtunnij/wAQ0HucfBEaSBFXXG6d6E02M1LgDT1qQ2q5ZBoeYuwqDB+hJikU3qaoXBfau+AHt6ceVPXtaXkzm6Oxs2xhqX0ucrQmEYoc+t3t0HWJeAJeoAAdRHGmxcKAHwRjuJOwRti3Sd5LCCGMcEsJoBZZZbvr9YibAXJKNDNQVSP9RpWLB/mzTu/YSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXRhBa+yL2nbb4zxZVnZs2Rf2oQ5Z4rio4jErzgIE1o=;
 b=cI6FJOee4FX7FlhKz65E9JpPPCw2wBmsLEzjCrn/fYcyjSdu6l3BZWhkhMzUUOywh1BzIERXYogwn+2qHZ33Vm5XEs4A8bpD+5REsJMgOSzlmJSjgLBspS5pyM5qwjK9beQo4yAM5r27I2T6tQAKlOGQCj8+5ZlKaemP/pDW5J3+CwQYR2hP3gZdj2IdyZM4lSDyraTJ4KEWEl2Yc4zis0drS4E8pnkBCnFCJkLpyWtpoHSYe/2VduRokZK1+2f0pVPPBqOMYdjPCbCTKbPyknGOkVAOtaAYQ5N3SMSRJAZxUWBlh5a4zJGkTKYxtTDwrfgG3JpOnSzvp2d1cTpHRw==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by AM0PR04MB12122.eurprd04.prod.outlook.com (2603:10a6:20b:747::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Fri, 27 Mar
 2026 08:12:11 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 08:12:29 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "l.stach@pengutronix.de" <l.stach@pengutronix.de>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2] PCI: imx6: Don't remove MSI capability For
 i.MX7D/i.MX8M
Thread-Topic: [PATCH v2] PCI: imx6: Don't remove MSI capability For
 i.MX7D/i.MX8M
Thread-Index: AQHct4Eimn8S6FzOSEeZOEeRWCABYLW15xAAgAwsvvA=
Date: Fri, 27 Mar 2026 08:12:29 +0000
Message-ID:
 <AS8PR04MB883306406390FCB4106C3A978C57A@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20260319091823.446030-1-hongxing.zhu@nxp.com>
 <abwFVpxrriV7Bt2L@lizhi-Precision-Tower-5810>
In-Reply-To: <abwFVpxrriV7Bt2L@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|AM0PR04MB12122:EE_
x-ms-office365-filtering-correlation-id: c00cf929-41e1-425e-47b1-08de8bd896ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|19092799006|1800799024|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 8M9z4TmfZjvxEY960J957tY0YRTmZqB6sAUeudCo4kG3SuDgjZg4mGyB9htydTc3CDodUL6Kh4wgK0yKCb7EKBjR8fEtuM9hz4l7nujI9gXDgO4CAC4VCV5TIAu4QSNWvWPX8H/5b9VwFW3xLVMuZZ+rqSatqmYx+L62jr/gMLKgmxIJpzmiUOzfqUjingbPfFDm/+790zjafJpfkiETfHrCypPnSNOAlsPE79aV8X0Djy5dA3vpVzp1NgAJeViE5wvYZdOZ4TY0uOKvh1oPUUdnJf70baBaNy0fG2VG0PKEmwP51i9mm2EJnO3apWbH/SQYvcvc8NQIaWJpmoWSAT8Z2ohiJJqUZ0UywcywsrGWFwzxgRX0AIR50FibD38APcuavGfZGrFllUYOw2t2Hxr4/LdHMqzewnJF/c8oa4oLPT8LUkbofNsaIWzZXwdWD5cqHVJueFcWvtJ+7nZiSa0VzXs/7JOWOFNCPRf0rtaQCG96RINOvraO7NVEZZ5oUW5+++wZhbky8HUDJLgYpXHT0rXIM1z6cAOFTVHbsIPAUjoq4Tk/9FFrSvjICZaREbbJFH/mz5mspDaXNsVUEeqobBRJOM+7mOVO/cQN6SJDasAnziU/lxQl6k+szXM3ujk2YtYB+LTCKECWeTzQMjg4jw/TqEDe5RCZJccOqDulKE1S7yNKtOw415pMetJvvGaur3fRA4TF8Xq9C14+SruSAffafCnMO3CLUFsdaaqYBN5nb46r4qR4DzN6GuLSWoJ+e5Y019BPErZDW/seba56245dB9kBxcwYizcOjR0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(19092799006)(1800799024)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?VUpjTFljbTZxTFdIdGc1ZVh3N01yYmpKNVdXYnJQWjlISTBTNDZZRlI4Uzlv?=
 =?gb2312?B?K3pBUmV0QmZBdUtQdEpXVnBjcUxzenczQU5pM2JlWkcybUZnaGpHZ1lnUlVR?=
 =?gb2312?B?Sm5GcURuaFdubUxjbTgxNjBOWFIyUys0a3ZJUHlBTVJybmh2UGQ3RUtDb1hI?=
 =?gb2312?B?RW95cUZvY3FKeHU0R3JEdVRyVTRtT3BtTjhnTDFEb0J4blc0YVZoRUR5emtQ?=
 =?gb2312?B?di81Z05VWTlORitPY2pSR0ZtK3F3WS81ZmtDZHRZRHM3QnZhNUFQTXZGVGQ5?=
 =?gb2312?B?Q0lheFUrR1hhN1ZSR2NiN3NldzlkK0t5ZU5oa3hEeWsyNGVoM2RpakVpUjJq?=
 =?gb2312?B?UW9RQW9Gc0ZUSnZCOHNPQ1owQUtEWVVyaS96WVFpSllKUjEwN2xoL3FEZDZo?=
 =?gb2312?B?bWZraGFUcGFiV3ZwR0pCckZnMy9hT2F3MTBhQTZsVmJiamZZYndpaEpmanNj?=
 =?gb2312?B?c1JYNWZaMnZzTVZsRXBmb25ndUlsc3VhK2Q4SnF6VFBBa0lLcjVpUlZjSW92?=
 =?gb2312?B?MUtzczFIWVNwb2hmU25ITjY4bTdqRGI2RDBpVzlYbTNuY2E4T2xPYzFTVU9M?=
 =?gb2312?B?bWF3ZzN0YTY1akV2SmZ2REl1anBmWWpUb0Z0VmprSjNQTmpYTTBPSGp2ZEhj?=
 =?gb2312?B?RGJnN0g2TzRaM0ZKbStuVlo3bTc5Z1NkS0xJeE5LN09Qa0l4eTlxN01tVFNR?=
 =?gb2312?B?SU0zVDRPb3d5TDhyT0xkRXc3dWRaMnA0NksxUTlKOFgrQ1I4d2ZldWdKd0pC?=
 =?gb2312?B?TzMvTEJPL1NmaEZ5TVlNZ04xaTgweTlWS3Y3bUVMTm1LR2c0L3laTFJsWXJW?=
 =?gb2312?B?Q3N2Y0FZTDdjbDBBTFQ2eUxSYkxybk4xQlNuVC9HODN1QUdnMWFwUFM1QldL?=
 =?gb2312?B?OFMvb3JjNDFDNUc1V3Z5Wm5KS1JmOURxSkxxQ29BT05tRXEySll2QUNYbmJy?=
 =?gb2312?B?SHhEWEVMbGJpNVpLNGtINUx6dytSMHFiRHA4RkpnZCtJMXc5dXZ3Nys3TWhl?=
 =?gb2312?B?eUhYbjA3cnJscnQ0OFRlc2lySTN5aTNreFVyZGMzVlFPQ21TTDhOMFdsMk96?=
 =?gb2312?B?NmRud2lmcTBrQjUrNzA4V2xWUXN5STBobGpFa2NRa1ZlODY0am9ZNmxQaG5w?=
 =?gb2312?B?R1hVRmRYWEtYYjkxelU5eksrOHBCZDRlaGlCVmYvcjdXZFJYVCttRjVRdzcr?=
 =?gb2312?B?WG9MNDlYQk9jUzh1Yjh3T2Q3UHhoZG9idjE5cU1ZY1liRjBUSzRNWjNqSGx4?=
 =?gb2312?B?NnNpQXN6eFFDWENrTHR6RWdxQklVMC96eDluQlFoTjJkcnpUMXdGTFYwbTIr?=
 =?gb2312?B?akx4WHhwKzB4ZHoySVR5RzNiNEljb1hBVnJGTmc1NFlNNGtvRHgwWGdob0JY?=
 =?gb2312?B?U3Jwd2hWNHpnZEtsRDlVQUdmOFlnNlAycnhETGFlWFVVQkdFTkNSYkRST295?=
 =?gb2312?B?RDgzbE9YSXJ6TDdTRm56SS9VQXNYWkYrVkxpenNId1IyQnY1S29Ta2VKcGJ4?=
 =?gb2312?B?OXRIT1dGQWRUK1ZCQXBFUXRHQnlITWdYR1gvMGRNVFBYTW95ZldyNWovb0d3?=
 =?gb2312?B?bGYyK2lOK251WkM5OXl0R3JlMXM5VloraWpsTVlJZ3ZMS29jNW9UMUhoU3lS?=
 =?gb2312?B?OXYxSzV2ajdVMVYzUnZFU0J5SXYvNkQrTkI2SGp5T3J6c1hyeVQ4SEp0NU5M?=
 =?gb2312?B?dkJIdHpCOFFLQkJ6aXBjdEZ5MGV6YXZTRlBWU0RXSlZoM3BXU0ZRRytRZGJy?=
 =?gb2312?B?c0NjT1YvbllJdFVBdzVKSStJejFHbXJNZ0l3MDRBQlh6aE5RSE1vWWVyeFlM?=
 =?gb2312?B?N3FFY05xY1lCclpPT3lNYTlPYzhLOFJDVEQxL3VEdC9pb25nek84eWNlaU4y?=
 =?gb2312?B?OEhhR0NGdDFsMWJaaklYMW5IL0Zka0VUSEp2N3lYSkZHVitQZU9vaEZ5YU9l?=
 =?gb2312?B?UjJ6WXdsRmxjRnFhM2c2emRDdkxUU2dxT0dMYkZvR0VJLzRzL09QZ0dackw2?=
 =?gb2312?B?TXA1UGJXeU5oMm1wOTJSL3p4d1VXRUJ2UmthUDMyWXl0b1ZpeE5zRGk1Vm5h?=
 =?gb2312?B?YzhOL3pRUU5MOXIxM0NURllOQ2JWVkxidWEzeGFnYkQrRmhUZEFtVUZVamor?=
 =?gb2312?B?RDZUUUJYclhyeFllaXl0SzB3Tm11S3lLcWNyNU9pM05SdVErbTlwSzVwQm1i?=
 =?gb2312?B?RGxhSElwTk1HMVJTSUIvWkUzMzlCREpGQk1XTWU1akdMelA0M1ZiVWExeVJJ?=
 =?gb2312?B?dFRiNGZjdkplZFA5UTFXYVZsZjUzdE1qR2ozMnRwcVlEV1RvSk1DTXFmQW5m?=
 =?gb2312?Q?WfKy1RiqMqO3rbJ02v?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c00cf929-41e1-425e-47b1-08de8bd896ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 08:12:29.5414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vlp3QuQhswILulCrvMj6cwJthIEmVXoO60FildhTDaKLUxr54xnmLm3Et8eOgOsLqCjMMcR9zpeDKl5r/uMw+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12122
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230599-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,google.com,gmail.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hongxing.zhu@nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email,nxp.com:dkim,nxp.com:email,infradead.org:email]
X-Rspamd-Queue-Id: ED490340CD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNsTqM9TCMTnI1SAyMjoxNw0KPiBUbzogSG9uZ3hpbmcgWmh1
IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7IGxw
aWVyYWxpc2lAa2VybmVsLm9yZzsga3dpbGN6eW5za2lAa2VybmVsLm9yZzsNCj4gbWFuaUBrZXJu
ZWwub3JnOyByb2JoQGtlcm5lbC5vcmc7IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IHMuaGF1ZXJA
cGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29t
Ow0KPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7DQo+IGlteEBsaXN0cy5saW51eC5kZXY7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
Ml0gUENJOiBpbXg2OiBEb24ndCByZW1vdmUgTVNJIGNhcGFiaWxpdHkgRm9yDQo+IGkuTVg3RC9p
Lk1YOE0NCj4gDQo+IE9uIFRodSwgTWFyIDE5LCAyMDI2IGF0IDA1OjE4OjIzUE0gKzA4MDAsIFJp
Y2hhcmQgWmh1IHdyb3RlOg0KPiA+IFRoZSBNU0kgdHJpZ2dlciBtZWNoYW5pc20gZm9yIGVuZHBv
aW50IGRldmljZXMgY29ubmVjdGVkIHRvIGkuTVg3RCwNCj4gPiBpLk1YOE1NLCBhbmQgaS5NWDhN
USBQQ0llIHJvb3QgY29tcGxleCBwb3J0cyBkZXBlbmRzIG9uIHRoZSBNU0kNCj4gPiBjYXBhYmls
aXR5IHJlZ2lzdGVyIHNldHRpbmdzIGluIHRoZSByb290IGNvbXBsZXguIFJlbW92aW5nIHRoZSBN
U0kNCj4gPiBjYXBhYmlsaXR5IGJyZWFrcyBNU0kgZnVuY3Rpb25hbGl0eSBmb3IgdGhlc2UgZW5k
cG9pbnRzLg0KPiA+DQo+ID4gUHJlc2VydmUgdGhlIE1TSSBjYXBhYmlsaXR5IGZvciBpLk1YN0Qv
aS5NWDhNIFBDSWUgcm9vdCBjb21wbGV4IHRvDQo+ID4gbWFpbnRhaW4gTVNJIGZ1bmN0aW9uYWxp
dHkuDQo+ID4NCj4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+IEZpeGVzOiBmNWNk
OGE5MjljODI1ICgiUENJOiBkd2M6IFJlbW92ZSBNU0kvTVNJWCBjYXBhYmlsaXR5IGZvciBSb290
DQo+ID4gUG9ydCBpZiBpTVNJLVJYIGlzIHVzZWQgYXMgTVNJIGNvbnRyb2xsZXIiKQ0KPiANCj4g
SSB0aGluayBpdCdkIGJldHRlciBhZGQgYW5vdGhlciB2YXJpYmxlIHRvIGNoZWNrIGluIGY1Y2Q4
YTkyOWM4MjUgaWYNCj4gKHBwLT5oYXNfbXNpX2N0cmwgJiYgIXBwLT54eHhfYnJva2VuKSBvciBk
aXJlY3QgdXNlIElQIHZlcnNpb24sIHdoaWNoDQo+IGFscmVhZHkgYXV0byBkZXRlY3RlZC4NCj4g
DQo+IFByZXZpb3VzIHBhdGNoIGhhdmUgbm90IGNvbnNpZGVyIHRoaXMgb2xkIHZlcnNpb24gY29u
dHJvbGxlci4NCkhpIEZyYW5rOg0KRnJvbSB3aGF0IEkndmUgb2JzZXJ2ZWQsIHRoaXMgYmVoYXZp
b3Igc2VlbXMgdGllZCB0byB0aGUgc3BlY2lmaWMgY29udHJvbGxlcg0KZGVzaWduLiBGb3IgZXhh
bXBsZSwgbmVpdGhlciB0aGUgaS5NWDZRIG5vciB0aGUgaS5NWDZTWCBleGhpYml0IHRoaXMgaXNz
dWUuDQoNClRoZSBpbnRlbnRpb24gb2YgY29tbWl0IGY1Y2Q4YTkyOWM4MjUgaXMgdG8gcmVtb3Zl
IHRoZSBNU0kgY2FwYWJpbGl0eSBmcm9tIHRoZQ0KUm9vdCBDb21wbGV4IChSQykuIEZyb20gdGhl
IGF1dGhvcidzIHBlcnNwZWN0aXZlLCB0aGlzIGNoYW5nZSBzaG91bGQgbm90DQphZmZlY3QgdGhl
ICBFbmRwb2ludCdzIChFUCkgTVNJIGZ1bmN0aW9uYWxpdHkuDQoNCkknbSBub3Qgc3VyZSBkbyB0
aGlzIGNoZWNrIChwcC0+aGFzX21zaV9jdHJsICYmICFwcC0+bXNpX2Jyb2tlbikgaXMgcHJvcGVy
IG9yIG5vdC4NCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4gDQo+IEZyYW5rDQo+IA0KPiA+
IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiAt
LS0NCj4gPiB2MiBjaGFuZ2VzOg0KPiA+IENDIHN0YWJsZSB0cmVlLg0KPiA+IC0tLQ0KPiA+ICBk
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jIHwgMTUgKysrKysrKysrKysrKyst
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYu
Yw0KPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+IGluZGV4
IDIwZGFmZDI3MTBhMy4uMGIwZDZhMjEwNDA2IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gQEAgLTQxLDYgKzQxLDcgQEANCj4gPiAgI2RlZmluZSBJ
TVg4TVFfR1BSX1BDSUVfQ0xLX1JFUV9PVkVSUklERQlCSVQoMTEpDQo+ID4gICNkZWZpbmUgSU1Y
OE1RX0dQUl9QQ0lFX1ZSRUdfQllQQVNTCQlCSVQoMTIpDQo+ID4gICNkZWZpbmUgSU1YOE1RX0dQ
UjEyX1BDSUUyX0NUUkxfREVWSUNFX1RZUEUJR0VOTUFTSygxMSwgOCkNCj4gPiArI2RlZmluZSBJ
TVg4TU1fUENJRV9NU0lfQ0FQX09GRlNFVAkJMHg1MA0KPiA+DQo+ID4gICNkZWZpbmUgSU1YOTVf
UENJRV9QSFlfR0VOX0NUUkwJCQkweDANCj4gPiAgI2RlZmluZSBJTVg5NV9QQ0lFX1JFRl9VU0Vf
UEFECQkJQklUKDE3KQ0KPiA+IEBAIC0xMTcsNiArMTE4LDcgQEAgZW51bSBpbXhfcGNpZV92YXJp
YW50cyB7DQo+ID4gICNkZWZpbmUgSU1YX1BDSUVfRkxBR19IQVNfTFVUCQkJQklUKDEwKQ0KPiA+
ICAjZGVmaW5lIElNWF9QQ0lFX0ZMQUdfOEdUX0VDTl9FUlIwNTE1ODYJCUJJVCgxMSkNCj4gPiAg
I2RlZmluZSBJTVhfUENJRV9GTEFHX1NLSVBfTDIzX1JFQURZCQlCSVQoMTIpDQo+ID4gKyNkZWZp
bmUgSU1YX1BDSUVfRkxBR19LRUVQX01TSV9DQVAJCUJJVCgxMykNCj4gPg0KPiA+ICAjZGVmaW5l
IGlteF9jaGVja19mbGFnKHBjaSwgdmFsKQkocGNpLT5kcnZkYXRhLT5mbGFncyAmIHZhbCkNCj4g
Pg0KPiA+IEBAIC05NzYsMTAgKzk3OCwxNyBAQCBzdGF0aWMgaW50IGlteF9wY2llX3N0YXJ0X2xp
bmsoc3RydWN0IGR3X3BjaWUNCj4gPiAqcGNpKSAgew0KPiA+ICAJc3RydWN0IGlteF9wY2llICpp
bXhfcGNpZSA9IHRvX2lteF9wY2llKHBjaSk7DQo+ID4gIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBw
Y2ktPmRldjsNCj4gPiAtCXU4IG9mZnNldCA9IGR3X3BjaWVfZmluZF9jYXBhYmlsaXR5KHBjaSwg
UENJX0NBUF9JRF9FWFApOw0KPiA+ICsJdTggb2Zmc2V0Ow0KPiA+ICAJdTMyIHRtcDsNCj4gPiAg
CWludCByZXQ7DQo+ID4NCj4gPiArCWlmIChpbXhfcGNpZS0+ZHJ2ZGF0YS0+ZmxhZ3MgJiBJTVhf
UENJRV9GTEFHX0tFRVBfTVNJX0NBUCkgew0KPiA+ICsJCW9mZnNldCA9IGR3X3BjaWVfZmluZF9j
YXBhYmlsaXR5KHBjaSwgUENJX0NBUF9JRF9QTSk7DQo+ID4gKwkJZHdfcGNpZV9kYmlfcm9fd3Jf
ZW4ocGNpKTsNCj4gPiArCQlkd19wY2llX3dyaXRlYl9kYmkocGNpLCBvZmZzZXQgKyAxLA0KPiBJ
TVg4TU1fUENJRV9NU0lfQ0FQX09GRlNFVCk7DQo+ID4gKwkJZHdfcGNpZV9kYmlfcm9fd3JfZGlz
KHBjaSk7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICAJaWYgKCEoaW14X3BjaWUtPmRydmRhdGEtPmZs
YWdzICYNCj4gPiAgCSAgICBJTVhfUENJRV9GTEFHX1NQRUVEX0NIQU5HRV9XT1JLQVJPVU5EKSkg
ew0KPiA+ICAJCWlteF9wY2llX2x0c3NtX2VuYWJsZShkZXYpOw0KPiA+IEBAIC05OTEsNiArMTAw
MCw3IEBAIHN0YXRpYyBpbnQgaW14X3BjaWVfc3RhcnRfbGluayhzdHJ1Y3QgZHdfcGNpZSAqcGNp
KQ0KPiA+ICAJICogc3RhcnRlZCBpbiBHZW4yIG1vZGUsIHRoZXJlIGlzIGEgcG9zc2liaWxpdHkg
dGhlIGRldmljZXMgb24gdGhlDQo+ID4gIAkgKiBidXMgd2lsbCBub3QgYmUgZGV0ZWN0ZWQgYXQg
YWxsLiAgVGhpcyBoYXBwZW5zIHdpdGggUENJZSBzd2l0Y2hlcy4NCj4gPiAgCSAqLw0KPiA+ICsJ
b2Zmc2V0ID0gZHdfcGNpZV9maW5kX2NhcGFiaWxpdHkocGNpLCBQQ0lfQ0FQX0lEX0VYUCk7DQo+
ID4gIAlkd19wY2llX2RiaV9yb193cl9lbihwY2kpOw0KPiA+ICAJdG1wID0gZHdfcGNpZV9yZWFk
bF9kYmkocGNpLCBvZmZzZXQgKyBQQ0lfRVhQX0xOS0NBUCk7DQo+ID4gIAl0bXAgJj0gflBDSV9F
WFBfTE5LQ0FQX1NMUzsNCj4gPiBAQCAtMTg5Nyw2ICsxOTA3LDcgQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBpbXhfcGNpZV9kcnZkYXRhIGRydmRhdGFbXSA9IHsNCj4gPiAgCVtJTVg3RF0gPSB7DQo+
ID4gIAkJLnZhcmlhbnQgPSBJTVg3RCwNCj4gPiAgCQkuZmxhZ3MgPSBJTVhfUENJRV9GTEFHX1NV
UFBPUlRTX1NVU1BFTkQgfA0KPiA+ICsJCQkgSU1YX1BDSUVfRkxBR19LRUVQX01TSV9DQVAgfA0K
PiA+ICAJCQkgSU1YX1BDSUVfRkxBR19IQVNfQVBQX1JFU0VUIHwNCj4gPiAgCQkJIElNWF9QQ0lF
X0ZMQUdfU0tJUF9MMjNfUkVBRFkgfA0KPiA+ICAJCQkgSU1YX1BDSUVfRkxBR19IQVNfUEhZX1JF
U0VULA0KPiA+IEBAIC0xOTA5LDYgKzE5MjAsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlteF9w
Y2llX2RydmRhdGEgZHJ2ZGF0YVtdID0gew0KPiA+ICAJW0lNWDhNUV0gPSB7DQo+ID4gIAkJLnZh
cmlhbnQgPSBJTVg4TVEsDQo+ID4gIAkJLmZsYWdzID0gSU1YX1BDSUVfRkxBR19IQVNfQVBQX1JF
U0VUIHwNCj4gPiArCQkJIElNWF9QQ0lFX0ZMQUdfS0VFUF9NU0lfQ0FQIHwNCj4gPiAgCQkJIElN
WF9QQ0lFX0ZMQUdfSEFTX1BIWV9SRVNFVCB8DQo+ID4gIAkJCSBJTVhfUENJRV9GTEFHX1NVUFBP
UlRTX1NVU1BFTkQsDQo+ID4gIAkJLmdwciA9ICJmc2wsaW14OG1xLWlvbXV4Yy1ncHIiLA0KPiA+
IEBAIC0xOTIzLDYgKzE5MzUsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlteF9wY2llX2RydmRh
dGEgZHJ2ZGF0YVtdID0gew0KPiA+ICAJW0lNWDhNTV0gPSB7DQo+ID4gIAkJLnZhcmlhbnQgPSBJ
TVg4TU0sDQo+ID4gIAkJLmZsYWdzID0gSU1YX1BDSUVfRkxBR19TVVBQT1JUU19TVVNQRU5EIHwN
Cj4gPiArCQkJIElNWF9QQ0lFX0ZMQUdfS0VFUF9NU0lfQ0FQIHwNCj4gPiAgCQkJIElNWF9QQ0lF
X0ZMQUdfSEFTX1BIWURSViB8DQo+ID4gIAkJCSBJTVhfUENJRV9GTEFHX0hBU19BUFBfUkVTRVQs
DQo+ID4gIAkJLmdwciA9ICJmc2wsaW14OG1tLWlvbXV4Yy1ncHIiLA0KPiA+IC0tDQo+ID4gMi4z
Ny4xDQo+ID4NCg==

