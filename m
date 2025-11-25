Return-Path: <stable+bounces-196835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41A7C83004
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 02:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1912F3AE61A
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 01:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C452727E3;
	Tue, 25 Nov 2025 01:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Ky6dhg0t"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECCF19D8A8;
	Tue, 25 Nov 2025 01:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764033973; cv=fail; b=IgKHpMxZRUWgjnBO79iMrCXjtxOHL8KeoUvPeeUThBaKuDVreqMLnXeWFGtAwec2cGfFEkUSCrXMI3AasLByNWCOgu//0JKtfGYrRBHiHQ/JV/TOur/NWt0/ZfDiEd2HxfrhWx3dihd1RPieca6vTX7hv1XzDu5jtzwnm1prDQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764033973; c=relaxed/simple;
	bh=3HGwpZbdpRu3JGAQp9plyhQEyYTxtKTVACLrFM9bxwg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s3taHg/3eEimUTVrSrfsmS2kGybm1nAsA/WocRaRPRo/ZEMwBuZa7K493UfZroG9h7n0D6F4ktJZdpUHWLkDNdQcfSaE6bgw/FhUvUgh1XWsWbTXemiW8x8Yn2QpW+pwP4h9InH0Q2W8WUcBzkr2I6HpPSqW6zwDwdqBNaPHFqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Ky6dhg0t; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP0mpHO3051843;
	Mon, 24 Nov 2025 17:25:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=+Z44vH3scg0Qoyg4Cecyfc23xEeGFvor4RjsdTyuU9I=; b=
	Ky6dhg0tqesQi6ugXb7XPH+OOUbo9joAVltp98MMyx5gi4m9rM6u86eJzA3Nnxm+
	6uXEThem2uD+GWmQGPaP3IGkkTz2QUOQryCrxwvnBMVb2szY58WPPWcTGZ0gazO5
	2vwEupPdGBT7Xv2sFYzqyDnVf3kpCj1eB/mGdIONxcvKtRReVJq0F0ALqkat2GOj
	Fxa0TFH2MOWKhyVhAf0PmoiH71iy0WhTIT8XSqmIN8j4Zo/E1/A1Lmh68+W+eIUu
	2KRXYKU8Z8JetPEaU0vXyqA85Ol6/XH2QfjHcow7S+/yyNbwoYRRPv5dM1m4MZfj
	YcP/ztMfBBWKLORsiLqwRA==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012030.outbound.protection.outlook.com [52.101.53.30])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ak9b5acub-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 17:25:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XzvGbToI4kbWlPWWJEEfydSGt/GXSKHAvNms9zAiOvJjE54HhOfZ3rym8d2L8sR5vIJGPZOXJi/050f3DN+At6xxIBCbMVkyLxGiZFY5GKfS0/2/q0/b8h/fE+smY07qnPkTSvklri9CYP2X66I/bTvclT7MkFJT5DUkRLTUqZacgGTMgnqCra33iNr5G/RAXJ0iGVpzvgp4c5yPUwsd4WXgQzRuhxu/noKfQ/dicZiwC7ZiSny8naJNA/NnsxL/z2QdGVPavyjGY/coxwgpWrFnndGILiZNzJ230pyTAukCmWaGtdOWd3xxMh5V87n/Hy+PGmPLu35SDkVnWn8gxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Z44vH3scg0Qoyg4Cecyfc23xEeGFvor4RjsdTyuU9I=;
 b=LYMEyj2aiF8zLZNzCC0yCyASR4s0xuufWZzJJ/coix133ai5tssQ9V+QQP+lHEqmSJsX8UHp0T7Vpb6FXhkCliRr605jbVBZakXMVFzZFJm+KHbd7qoKWFJBy+9wRfYdCatuqL9EKfOHCdz3ksEKCt+vbBILBZvZtJ7rJHgywmQVyPivqLqZA7XXPgsMt3AM+RpXYfKphy/mUnfgP0iAuy094QkSwxsOX/ut2ZhLJ3cvuv9SE0cwck9O1IJAcL/r766jnq5Z/VSaQl6W5LBNAXNIw6YKdMr5kqkupVDd6tDHSg2n6mQkG67FSUIUxor8c6hpVZmqNdkybXX9ncL0ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5072.namprd11.prod.outlook.com (2603:10b6:a03:2db::18)
 by LV8PR11MB8679.namprd11.prod.outlook.com (2603:10b6:408:1f9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 01:25:31 +0000
Received: from SJ0PR11MB5072.namprd11.prod.outlook.com
 ([fe80::a14a:e00c:58fc:e4f8]) by SJ0PR11MB5072.namprd11.prod.outlook.com
 ([fe80::a14a:e00c:58fc:e4f8%5]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 01:25:31 +0000
From: "Liu, Yongxin" <Yongxin.Liu@windriver.com>
To: Andrew Lunn <andrew@lunn.ch>,
        =?iso-8859-1?Q?Ilpo_J=E4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
CC: LKML <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
        "david.e.box@linux.intel.com" <david.e.box@linux.intel.com>,
        "chao.qin@intel.com" <chao.qin@intel.com>,
        "yong.liang.choong@linux.intel.com" <yong.liang.choong@linux.intel.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "platform-driver-x86@vger.kernel.org"
	<platform-driver-x86@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net] platform/x86: intel_pmc_ipc: fix ACPI buffer memory
 leak
Thread-Topic: [PATCH net] platform/x86: intel_pmc_ipc: fix ACPI buffer memory
 leak
Thread-Index: AQHcXRgZt5iFTWlg00+JeevYpjNEPLUB1VIAgAC1oYCAAA8kYA==
Date: Tue, 25 Nov 2025 01:25:31 +0000
Message-ID:
 <SJ0PR11MB507228758576C4474EC14EC2E5D1A@SJ0PR11MB5072.namprd11.prod.outlook.com>
References: <20251124075748.3028295-1-yongxin.liu@windriver.com>
 <f1124090-a8e4-6220-093a-47c449c98436@linux.intel.com>
 <72fcaebe-afb6-49ef-a6fd-69aa0f8c7a39@lunn.ch>
In-Reply-To: <72fcaebe-afb6-49ef-a6fd-69aa0f8c7a39@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ActionId=dc188eef-6aa0-4c82-831f-03c264b4b1e0;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=0;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=true;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2025-11-25T01:23:44Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5072:EE_|LV8PR11MB8679:EE_
x-ms-office365-filtering-correlation-id: d9fc5da0-abc7-48ba-36b4-08de2bc18679
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?7UcDB7PrekWt9sQkb6zD7p8JeoIme5aGN+yI53NAGlUFZpyf7K5GBKYsv3?=
 =?iso-8859-1?Q?BK/zwmI1NWam8+CVVJmIBayhmibk7Vku4zNfHzVUhWD3eOcg89K/azcZzY?=
 =?iso-8859-1?Q?EEwcH4z5YtdHQrFH9ahSxvVJ6TLqKNy1Zb0K0UhoUIqgWpgdEXDfdxYfB3?=
 =?iso-8859-1?Q?w1NYi0uU4b7wvy8gU1imVdK16IXliguJGbU+hEayKM4Z6HUKivrbflpanN?=
 =?iso-8859-1?Q?TvHZg12mDouCs6dGJLkvJ0ySVkYpAwAkbBOof0aj8TQe/0TtgppDgIq6RX?=
 =?iso-8859-1?Q?JPCh9oADaNnnWbGslIjmbVzjwN88PCDS2qBt6g5k98a6AR0p60qhIO5QYp?=
 =?iso-8859-1?Q?K52c8VRqKvi+w/MX3Mk+oafYdBSp5Duj40/ONolTxryfVCdh70SOQJ0/EH?=
 =?iso-8859-1?Q?X5UXbo7FY151gTcbLH5w1S4bKE2SceIaVnrFy/l7MWBiUzUNonHIhBjJAg?=
 =?iso-8859-1?Q?S+VTxqAYHBRvI8ol5E42FomYDLOzMPDYhbsGDEf0EbMj+v+nGWreHguDgT?=
 =?iso-8859-1?Q?SI6iE8t1Y8WsJSCs8TzGa2UqVxlhN3VBtxkrtl6E9jkkMRc5iDt4IYrTPm?=
 =?iso-8859-1?Q?JsccpnD7vMkFnR91D8sZLu4WIYxtS21gaWrOExi6qW4v45IouI7/EexHZm?=
 =?iso-8859-1?Q?GR7TygfFn+FecRq32oT+oLrFxFFJjXZyEkh9t63m0o+3O+gproDU1Vb1Sn?=
 =?iso-8859-1?Q?vyQakVG0DxtduZ1VUBpxlGKPlkuY1cVeRcGlu6JIXjuj9gUzDMp+ZoIx0j?=
 =?iso-8859-1?Q?uwGGc5jKVYR1vo0vTC7QnmVaBso4mYSBLq+pP71I9zx3AM7XXas0lYC7fn?=
 =?iso-8859-1?Q?bGOqbsB2pujuSDY3QYnTYVnn+jgqvYqbEC4rMf0B+6PlZ71UbPA0snH7JX?=
 =?iso-8859-1?Q?PQ+iqVZQJ+BFFQpMtQqcY8VLsl/6Te9pcoEhpcVXYdgtruCPFJgO/5Dvdf?=
 =?iso-8859-1?Q?6XzM81FWeCoP44vMoi0cfzx3K2Gq2UXQp1NiIrWX5yfdmReByl/QEwbQ++?=
 =?iso-8859-1?Q?hDDzXLf1PiEcClq/MrCCdb3j7U/g3uCyPpZYYMBGQtlBOC6LiUF3jcvz3p?=
 =?iso-8859-1?Q?AhNA8RQEU4NTw45FI1z+HfsNMxDTm4myl0LTIet1XikynlfIpOolO2KgNg?=
 =?iso-8859-1?Q?GIuH+NxHU2xir5Dkwwy1IbfJ7H/eGzdLyIppidl3h9SUeRn5ZnhG4EHZoV?=
 =?iso-8859-1?Q?5G+jc/o+CMRYPC/HKHAOWph8sLx7h+vzAKj1vD9T3rPqmiauvsS5GdwRD9?=
 =?iso-8859-1?Q?8zPPwMxI4HAbXpad6au3hTrLmrnbqBhypAsf0QXjqL9NO8RaCEU7QsQzr1?=
 =?iso-8859-1?Q?492Qsq3WBenvu8bSmaOKECNmYe0IULUEgQBj5dyTnGWxeyhfOjua+8sliF?=
 =?iso-8859-1?Q?YF8Cjb7Eb9ja0f3AMQjPpfbTS4nSNRG5LAOJG9MtUFmn2bf3mAYvm0A6Uh?=
 =?iso-8859-1?Q?KxE5MMt+gJhgtVYNkY7Br452yXiHTGMsOWeVTKhR5NNxxKcL9D0flXXOJ4?=
 =?iso-8859-1?Q?VbBSoKbUhtZ/A3myLYcQR8x/FcgVgDfNEvkPMBfe5mOhQHTEKDwDriSt0S?=
 =?iso-8859-1?Q?EpizPj/bQrU3fzJh+YN04afYLWMk?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5072.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?U/D1aA++ukeWGniH7oYNRbAcWM6dn+L/wnZ83SaqYoDB16wG5SLrtPsg+m?=
 =?iso-8859-1?Q?bsVLo8a/7wGkl5vTyRLuOnYSFWhsRHfUEkBVUQARW2boZ7SLD5QvY18KW0?=
 =?iso-8859-1?Q?lypKCiUPiwzgwVRXBHhxlFsJQsU9usQbLwW3xcjvOyMZBInR8FCpLSlFRN?=
 =?iso-8859-1?Q?GT2l+1XKYSqJivkrlXjArzgm7QxfQRinCYTUDnlyv0iYdV1QiV4MyVS4BL?=
 =?iso-8859-1?Q?Jm9mbN5zl3VkGszNfP65C2t5p427GtoVlQfwxqWfFIRbVx9DvB5bKfDSqB?=
 =?iso-8859-1?Q?JI9VQMcZJgzD0Y55aSyrVHpWm/HDY95WXG4AJzPzM1DVwROAbjZefVp40D?=
 =?iso-8859-1?Q?ZUwNg8JSfGUT6VBC14qJjq3oNI2EXiVnHkxYR9AXHlQ0TnfV1f/OWG8V1K?=
 =?iso-8859-1?Q?VT5uqiMMzDsiZ2MPE7rXpgfT9a9oop2QG9HCiVW+OwKUdi9bY3RPe2xfL9?=
 =?iso-8859-1?Q?+e/LN4+lmbApcMXsb6vwNc1509XmxuYR1jtHhVGjnIk7FgLfvuQ5Ik02/E?=
 =?iso-8859-1?Q?VV60V62TJzsEkqtverKjbTsj93kj1JFJ7gxyNUxg6IR0DYi9jV+/IvocRA?=
 =?iso-8859-1?Q?dVSetFZoFA88ML0HrqDFWF4lDU25WGOqCtPiv1sqZA3zWZtj9bSeCEGirK?=
 =?iso-8859-1?Q?bbOA7+jQ5f7fWBJm4rDzFh2P9L1DHkX5I41oYqqcWNHe45PsIBVNyzu0f3?=
 =?iso-8859-1?Q?AOGfQbFpw3CTXWfSQ1GSr0qz+KK6GWVUMAxpPAmK7wyrLeln5rTGD4ac5X?=
 =?iso-8859-1?Q?3zLDq+b6QFQXEXxS5wat068uCQsLh4s5K8ojo+rec63Ir9T5oNaIzu5JzF?=
 =?iso-8859-1?Q?8MEcGlk9X2ivcIxMCLk6tYL/L6+Zb6MoCwRRonnHAfxm+zCRlbWDSwfd2z?=
 =?iso-8859-1?Q?WxuzS3lDeyzkGTsg17A5IwAsgynz9t6EmNYRhZsgKlQb+l+1eK6xE6PHK9?=
 =?iso-8859-1?Q?2iozet57kfKiwhX/VjNYI6dlC0ivDceUVI0WKcXeVoJFJdUz4bd4cSe4Fj?=
 =?iso-8859-1?Q?lRKsbvD/LbwGRrAgw9kQXeiQRI51S0l6lZnqtF/P208yhOigls0f74RBWi?=
 =?iso-8859-1?Q?S0TZdO9QmpUy2zCzDqrcBlcZEyJAkJ5gWpyiXdgLX6XSpz8ikEFGUCE/xY?=
 =?iso-8859-1?Q?D5UKC5jXkdGLrFqnkqx3XBhDPrgxWoXRZaTdWpP+4pcU/6at/AFKN0KmuN?=
 =?iso-8859-1?Q?oORXRYQeHmBi+MESg0aa/CMzYx++VgqpSxSAEMVvwCB6zHRdXiaBOFHorF?=
 =?iso-8859-1?Q?6CumFcOsk2xl2YDPy7Jary5j7NZ9qbf5k8CWYuZMnGJkx7zKArlZV0zonO?=
 =?iso-8859-1?Q?SeN2od3tZCMOCcZOAUCLbxdMhCK/6k/ouek9TlhWTxz1V6b3TqkqBacKeG?=
 =?iso-8859-1?Q?XtodCs2Z06fGnZIiosE4dXgAk9njYTtg530XUBBru2TRwhapecHawNEHkv?=
 =?iso-8859-1?Q?TGTkvgFfZm2oNs7pJV4Uc74MXcA9gKwsWOKW2R73e7BfaAV1aEtu9snVK0?=
 =?iso-8859-1?Q?oK7uRnQVAxe9MGSrhxFYEPpVYZjIjM1Wm/Ah/lfhNZaZLTdJjYdiCLIuWw?=
 =?iso-8859-1?Q?rEMkoteWVebuSJVSTJvxb51CMpd0HLZmQd38yDcuFadr+J0tDlwXitxFWC?=
 =?iso-8859-1?Q?bPpqN2PnTtQlprEorOeDStEVBXmi7yYcvK?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5072.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9fc5da0-abc7-48ba-36b4-08de2bc18679
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 01:25:31.7655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LKp7bY630a7/fyS5OktWAyWQUSlaTHy0N1CWcfyyyBbzZB9BPCFMAH1LZcrGuReySsDITJOYwZCmJauNdt4S8/Mgkn9Pm9tyr3tIcyfH3Vs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8679
X-Authority-Analysis: v=2.4 cv=fozRpV4f c=1 sm=1 tr=0 ts=6925059a cx=c_pps
 a=bYEXqv4PBJnnT5HxTb2zpg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=t7CeM3EgAAAA:8 a=Sdn8QdLaxc-jMy_MRa8A:9 a=wPNLvfGTeEIA:10 a=sCYvTA3s4OUA:10
 a=5imOhvl-4yYA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDAwOSBTYWx0ZWRfXzzNT+MSREe66
 H/5Y3fhk/PrWgqBFp/axcslEMZIiZ/MSuyU5Ooizggg9JCNCLw3YNRdBUWMb15IC14obali5g7T
 B2KKq6SHCV8485tJo6yQITgJ1FKm6LTo1kuRU5NWGJe3OtApKGV+HDim1jCx2WhdiTf5xfbRd9f
 +gbpGIt2hK3yvnVh4R8ktlcnS0gw8RA06+oy6Wway8jgJa2bTbaRlR/B7s2FfNC0Okd7EhDvLEv
 Wg3k+lynuoQCZa957EYT0Aup9ArMlgxz7qVhe/5gLYD0j5c89aZLj1EtJIGEvHfVLFw+C62aUbS
 piwjR32BJJ1lzXpTtyeJ2A2BBM+lMwYTHbCjoamy6MGEE6fXxuJSUv+FTNZXUvsRuav3wST0/UI
 ShqwvZlt+GwVt+dZZqTvobJsiJM+HA==
X-Proofpoint-GUID: WeNvr-jynqUNwUHSIKqviIE3mcxM3Bbm
X-Proofpoint-ORIG-GUID: WeNvr-jynqUNwUHSIKqviIE3mcxM3Bbm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_01,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1011
 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511250009

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Tuesday, November 25, 2025 8:30
> To: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Cc: Liu, Yongxin <Yongxin.Liu@windriver.com>; LKML <linux-
> kernel@vger.kernel.org>; Netdev <netdev@vger.kernel.org>;
> david.e.box@linux.intel.com; chao.qin@intel.com;
> yong.liang.choong@linux.intel.com; kuba@kernel.org; platform-driver-
> x86@vger.kernel.org; stable@vger.kernel.org
> Subject: Re: [PATCH net] platform/x86: intel_pmc_ipc: fix ACPI buffer
> memory leak
>=20
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender an=
d
> know the content is safe.
>=20
> > Good catch but this fix doesn't address all possible paths. So please
> > use cleanup.h instead:
> >
> >       union acpi_object *obj __free(kfree) =3D buffer.pointer;
> >
> > And don't forget to add the #include.
>=20
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>=20
>   1.6.5. Using device-managed and cleanup.h constructs=B6
>=20
>   Low level cleanup constructs (such as __free()) can be used when
>   building APIs and helpers, especially scoped iterators. However,
>   direct use of __free() within networking core and drivers is
>   discouraged. Similar guidance applies to declaring variables
>   mid-function.
>=20
>     Andrew

Thank you Ilpo and Andrew for your valuable review.
I will send a V2 to cover all possible paths.


Thanks,
Yongxin

>=20
> ---
> pw-bot: cr

