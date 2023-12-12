Return-Path: <stable+bounces-6511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1A380F8F3
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 22:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 008E61F21796
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 21:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4276865A85;
	Tue, 12 Dec 2023 21:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="e8DA0JhC"
X-Original-To: stable@vger.kernel.org
Received: from CO1PR02CU002.outbound.protection.outlook.com (mail-westus2azon11020027.outbound.protection.outlook.com [52.101.46.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503CCA7
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 13:15:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIXBvQmLaMzPsgzWAFkyQVVX2XCLHdtkMT7d4gAeqCDA8DN105cTcWXMNVCLph36L/R8L9/WnKiT/EvOs3sJwcMUcNIaGorvpvT3ilPpl6tn9H8Kt20ZCpGUMVyDapXjemxT6tr1HjMnnxvqbyGOhLPPIBOIpv/RzUV0ThdSNcP9unKx2Cf3JkNCwMWkmlmtA+rowKV96JBCNbidPZb0o+oP535ZkYIqrsks4Wf+W4OOfMzqB4m9tQSa7OJq1gDdLnMDmMTFQDQ7yzueWBbXcvy3t+GJiVIL4cWCCpYwfbAdmlmfYQeVLMzcc61tmpzXggVaHa1aE11twV4+y368GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IcVeip6d6mRJ8b2yttEkvVQZFZb0INebsRiw5/Q31yI=;
 b=UDa3khStgup679xRzPtVa9BxRmg+YeN7s29zM46QxfDYthDPp88+om+ytcxXCtqhbP/toIvkC9FvnZU9x9Mvl9CMzj1ANSsPxoeOWhV1V7w6+rzrqZTpayB53iurKJJmkDWZQRP0tvNSMdnRzOLsw5//8/k2NeJXgl5UFEks+gb9elERP4RhNCnprDdYYOYeu3Sc5uCqs1fIDFgHcltPogCcc9WzsNNm/2BDvuFeQVMaU1GZ6zabTMUcUbnEXRaDU0K/Q8VbZh2S/hm1m/M9et/XQ7tHnVhvZcxri5W7KMJjGJNKuAWScfQTO5FLodqGSMRQvZZuSmHMpBLzo2D5fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcVeip6d6mRJ8b2yttEkvVQZFZb0INebsRiw5/Q31yI=;
 b=e8DA0JhCOV+ZMAwid0MHq9YkWTkVwrrWmzRPUTAYwlpch238C4Bf/9Id4o0QUKcmglVpxI7m8YS7IMFib+sNvAu2kNnf7WcVpuzf97/lRbAYhigTYG1OepHFDYHVrU6x8OjGFbCH1lT7mfsLzoXM7s84RwsWd24Wbkt89ZrsWRw=
Received: from DM4PR21MB3441.namprd21.prod.outlook.com (2603:10b6:8:ac::18) by
 PH0PR21MB1306.namprd21.prod.outlook.com (2603:10b6:510:10d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.7; Tue, 12 Dec
 2023 21:15:20 +0000
Received: from DM4PR21MB3441.namprd21.prod.outlook.com
 ([fe80::424e:ad61:8198:101f]) by DM4PR21MB3441.namprd21.prod.outlook.com
 ([fe80::424e:ad61:8198:101f%7]) with mapi id 15.20.7113.001; Tue, 12 Dec 2023
 21:15:19 +0000
From: Steven French <Steven.French@microsoft.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
CC: Greg KH <gregkh@linuxfoundation.org>, Namjae Jeon <linkinjeon@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH 0/1] RFC: linux-5.15.y ksmbd backport for
 CVE-2023-38431
Thread-Topic: [EXTERNAL] Re: [PATCH 0/1] RFC: linux-5.15.y ksmbd backport for
 CVE-2023-38431
Thread-Index: AQHaLTZ0FraRoh/tHEGy7qr1Q4udKLCmEtOwgAANBICAAARm4A==
Date: Tue, 12 Dec 2023 21:15:19 +0000
Message-ID:
 <DM4PR21MB344158B63C4D77E25E6DF2E9E48EA@DM4PR21MB3441.namprd21.prod.outlook.com>
References: <20231212184745.2245187-1-paul.gortmaker@windriver.com>
 <2023121241-pope-fragility-edad@gregkh>
 <DM4PR21MB34417B034A9637445C598675E48EA@DM4PR21MB3441.namprd21.prod.outlook.com>
 <ZXjIEyiEvrISjsX/@windriver.com>
In-Reply-To: <ZXjIEyiEvrISjsX/@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7efc2df4-71a3-4cfd-bae7-59dbb5ef499f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-12-12T21:08:19Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3441:EE_|PH0PR21MB1306:EE_
x-ms-office365-filtering-correlation-id: 4345d359-1a79-44cd-e5c2-08dbfb57720c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 t2WMoKIhNoEgcdpdNqDBZZaO8i2bboHzhcbvCGK5CmMBMjRSMvKy4WB7EhfkdorgpT492lb3WtAI2rrjkbkeOw82+jn/DLUGkObuq3cSfxAQ8oLIzlJhJYhlfuk0rgnwm5eNDJaDNfRijUbC9aDUn9sIc9iTGgYqp/bEPnoXq/yo7TfDdswB3S/Vf8gyevRpxV5fclMsX+0lgVievmSecTRvmtJ6idXCwTHcoGxWYsNJFKSsni3CgrKAT2hBIIOx+1Zjeg4p6RKUJyvz/RN0qgDIxFdYpintMt+DnZFFrIun65O09sxM56jiFW+mhNfi2Ak05U1o9VxiokXiYrSZult5OO9nmRC0OXeZ4iOnOYbu3+9NABuH4vALFSvFJdqqziLU2E9XM2QdLg37rFWjL8Kqzf7c5tfYAC6qnBljxwB5glS55MteUeWo8E84bHYBE65UbAOwpdYycrv6Is1b3l15I7cpgQcx8g3SVwERUvW8P/UGfs1pHPodL94QQOwJUYrpF9ln86sKs1aHuPDF56vV0Y2JhDiGql5CC/koUKctCTYCpq6KMqZvxvEbJi+4PaP3wyAu/tEUkfRYQYWGZ2I8aERNh107QNNIVjRGaJr2770dK4eFyhdNkrNLdEByn+gJtGo5z8t85mEZSgnUf4ePaL395Bo3Hr5lGMUC47w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3441.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(136003)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(6506007)(71200400001)(7696005)(9686003)(122000001)(5660300002)(83380400001)(8990500004)(4326008)(8936002)(52536014)(8676002)(41300700001)(54906003)(2906002)(478600001)(316002)(10290500003)(66946007)(66476007)(76116006)(66556008)(6916009)(66446008)(64756008)(82960400001)(86362001)(33656002)(38100700002)(82950400001)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mpnQB3W+cy90nTxTGUfHiNr63QHha9AoeQGoShKtRNW/CWhws2+YBLvmL+Mv?=
 =?us-ascii?Q?676WQt4LufvJhtp1Uq/B+BCe380lltewKjngnDORJ3qR3zFmW2/JnFeYJgWR?=
 =?us-ascii?Q?gZdk/gE7+1Syo8KAVmprQNJ+CELnIHFsWHm28950VtUrLX+ffxoxdM5xHoxB?=
 =?us-ascii?Q?5i7SwC25/Qh+d5F/tq3GTnde6Kp+vFDWhEbf5D4DQ2FXUhZPN7MDsyquTH0S?=
 =?us-ascii?Q?+OsNJhD4QyLpjf49axMqZ/BKpG3osiPpT0SOKROrM5JJi+nT3ZtEkHMPPXIn?=
 =?us-ascii?Q?kbGKPcIi1Ejyiy6ckGg942LjhGvcGaIUKo6z74Z27guGVshPPTKbsOaEaY63?=
 =?us-ascii?Q?LgILZEmlc7+07ju30JzFZ3MHxlDGjPV8BccF2N7lQJ6gd5MUlxkk5YGWO8Eo?=
 =?us-ascii?Q?zYrr7HAmjLRivEB/wKqxuuu3j96XO2YXTbkiybVIH+henvD7V1qOHeP3/PX3?=
 =?us-ascii?Q?8E4Kg0rGT1V60v+XIhRnO9I7Ok7vp31Xk6Aq9a/rSGHKVWhIn9xuTSk/AHCE?=
 =?us-ascii?Q?kC397L8HziAqPNp0wF8ciag8N06SIDQ9JD/CA2q+eLKI3DDjCRn6gOsy9cgD?=
 =?us-ascii?Q?k8de0KV9p8wU9gpqa0gHQ0FTxTQubCAEJ4bjYMaxgtrCT/QAZ+8xQVvUFAgP?=
 =?us-ascii?Q?EYivvuZfPmE2FpzM0x2OsE8NsSWAnMNBJdtoqb1OCdwmoLbxQwcLgHCtdBAT?=
 =?us-ascii?Q?Cw3mh7UsXISJlcbNj/xFF87txD1gRuXqm1tgGsXgaO23ldv5UmL+ZA1oWEhN?=
 =?us-ascii?Q?0wMN6frWoZywS8JoSuqRs2KTjT+kPLyJCaqsWpc+Z/xPBysDdZ3XeL48acnz?=
 =?us-ascii?Q?X2oiJyWfFZE1+L55rMRUFzsk/zqQLoovEZDyvkthNiuB4cmYtMMoEs2G+JJ+?=
 =?us-ascii?Q?p3rywDdKbXU5MiPM+Oyzlibfe8KFoSEuYowMiS2fgAZg5hG6SZn9TRD+VsjE?=
 =?us-ascii?Q?o49RmVqZj6KmWRL4ZLUhJ+uiekwO7bwh2Gbu5M4PFpVusKjVM9EPqPHDHMr/?=
 =?us-ascii?Q?j/PklE70v/THaTgMpyVV5gE4lauBsGV7hcfzmT+qubER2Uw7TeFcCbQ3IGv7?=
 =?us-ascii?Q?aXip+Ux8QBXfJDj8mcRH1WdehIIlpQU8MRlz/p8dVIe6lABGyeX74E55Ga7p?=
 =?us-ascii?Q?Wd4z4BZFKWJ4Ujuu+FJdBDFpPjQoDDv7ynmaIqwbpWUW9D/rZmR6QgscytKx?=
 =?us-ascii?Q?hrXc1OV5qfBTTOG0augGBnzC5cpeSC+/2DjIt7bOOyLFYJa0i9nQ99dlxnCN?=
 =?us-ascii?Q?CrUPu6mPwtnZYo+I9YWdve5VaH+r8/jtwRYxzBjh5yQkntZv7FiCXaz70HRG?=
 =?us-ascii?Q?fl/K/CR0v3QN4RESON8M2UQpeAE7cF9iPzmowDNeyIe13Ar4hS3zBfHq6xOZ?=
 =?us-ascii?Q?gG5MgcIpDlvapPCO4tgFQToZ4BwvL4kXoJE5XYHOo/G+yS8ilUsrVhNpeK5v?=
 =?us-ascii?Q?BE6a9eHFVPgMYaonhIL/bGs0N0HZfgWi8isHdyrkpZ1ypOb9RyDiRIHO9xJM?=
 =?us-ascii?Q?FT9oJMtrramCvg11vJF/mcc6vq2k7VThjcqSv4QmtMwVMFhEmHciy6f4aKgA?=
 =?us-ascii?Q?6MUHV17FnMlXqpNbJqLAa8yACI2s3OlteAADbcG5ThjA/wab/r9JHkR/AwxT?=
 =?us-ascii?Q?O1CvpQe2VPfMGduegzHL4iYuN6HOt68HdmrV+2KvLT/H?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3441.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4345d359-1a79-44cd-e5c2-08dbfb57720c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 21:15:19.6703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z/JZIaftoK1uc6Q6uqxSvoU++XdPKr0i8L9Elr5E5KsDzyHzPomZTA3fOmDqOtsYnQSVZzUxGHKlf6DgD6yBBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1306

> Larger backports like that can make sense for a target audience who are i=
nvested in some feature but don't want to move anything else - then it beco=
mes a deliverable in itself, typically from a professional services group. =
 But linux-stable is definitely not the place for things like that.

I wasn't so much thinking about it for stable, but for cases where it is sa=
fer to use an alternative to stable for a particular module (and for a part=
icular older kernel).  For active components (where dozens of patches go in=
 each release) stable can carry risks because of subtle patch dependencies.=
    Maybe not as much issue for the cifs.ko and ksmbd.ko cases because ther=
e are excellent testcase suites that could be automated for stable to catch=
 the vast majority of stable backport problems for those, but that assumes =
that this (stable kernel component by component testing) is automated (whic=
h was a big topic of discussion at the most recent LSF/MM/Storage summit). =
  Obviously distros do this all the time, and backport more than stable wou=
ld for the more active modules, but there are probably cases where Debian e=
.g. users would want a module that had various security features backported=
 and so couldn't use stable (because stable would typically not include new=
 features, even if critical)




