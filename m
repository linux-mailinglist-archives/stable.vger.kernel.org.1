Return-Path: <stable+bounces-73134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC4C96D014
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 09:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07945282BDF
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 07:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6E6192B72;
	Thu,  5 Sep 2024 07:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="rDYW8A3W";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="LsWbNI1r"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8940A188A37;
	Thu,  5 Sep 2024 07:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725520016; cv=fail; b=HYGLPPVNxyWdZ6KfPEsKoacdf6upzsnpzMVmMkhEUmw8d/0dQi+ebUMhlY2usJLuY5No81BhUr/ku5Kyi6VIkO5zlkupbbZiPFW9z9onMZz+xzt7UAhRzBX9ojonPUxILD1M9Rm3zn7EqoYdGelRm6rC3TkuP8ssTrEpaxZQpjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725520016; c=relaxed/simple;
	bh=ywwaNz7u4TKf39Cct/C9jRIU+pbpAo7+NnTRlBw8y50=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r86d4Ppz/IOhQ7uYmfTN+/DFec7eIuOzpzTGLq/Xdvw3W4D/QIDAsbci1PJFjUH+NdDBnjYOr4fLNapNlEJMtgO/rqFr1Jt7JK9s7DsxPyZkUZPmOxFoWfA+nvkKf8OCIF2tXuTf1lFINGju+ifWDoKWSKspYUjtHkqq4CcFHV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=rDYW8A3W; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=LsWbNI1r; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484LhAOM006178;
	Thu, 5 Sep 2024 00:06:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=AD0sMBZnTw0KE35sGMmUqXGHBfzBgyTj4ranwu+L6lY=; b=rDYW8A3Wz7hp
	K+E5AVAnVQN8/IGz8ixYLnDf2W63x0y0XaWeE9uzT/A4yiC9/SZDRroTFo7JCrFK
	D2p3PHwSnoQbbr5lYjzJIKMENBPfmca7fIGkkhmQ8p6xoE+SqUUqI3IldH5EWLJu
	0fUi+AtYlrwi2cQlxXVvDwnfDeUCraXsRzhSDq9+5uhxaRFXqygx207wM2c4dAO4
	BzDkxIQI1jPufuVB09CFlTo61JpUB8LFlMovshuf9XaukI+dXL6Ct4rwG2D0Tb42
	isQaTlgD3h71KabeZLTlqTZ/p2Cf3mLjaGswv+GXt57W7Eox+UXloJKBECL1OjuQ
	wOzIhvDUJQ==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17012052.outbound.protection.outlook.com [40.93.14.52])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 41byqtgv15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 00:06:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKLNwA5wSWwwI82jL95GuD4zaOPXgJB00X08Nbvzc6hdrXFlbYn8+zsidaXlKdmrGZSvoNtg83gj9tLAiwsrL26ZDW45WfeOEwkAdmdh7up7HW17bExrMk/WHDm5EnjdYBEKgYfaTj7V8J3datFFHzV0Oqf/kMhI/JI3JzrDLrspXsn/yK1OTpIFkz2idGNGZtAPAkZ8pC6hB7Rt6VDdsZV1vH/vLNst/Ytx8SNPE/xc8Wtk6eviHRfQWBubBs4fuQtNTXmTJ0xRe1YLzuwolC5a0/foaNDQY7IxjJ9d7utiEbBnEWDLUF61wKdotTuiTKShP1wVR8K4CA6jsqR71g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AD0sMBZnTw0KE35sGMmUqXGHBfzBgyTj4ranwu+L6lY=;
 b=rP0HJG8gHOCgfGQSoTbnQuroijfeVGyCBLxew9A/UKVyy6ICkNnacK54+m7sco9Jx8fdB7/IXC8XEZFMyb1QCApqrkXaW/Jarbj7lUvKxxw1Cp+US7EaxalrVWvkHbo1IJlKGW+zke+k2VB8GZAhbp8Xwb1oasD4Gmfe4ooHuaOlqmZ1uhGEOrUCSP1zeHJvHKRdrNdcn+m8+i4/ohZqGdaVZKRYYm/727U/eVC36R1SY+/CNR2J5UeZ82Ydb70TEusZfS8pdrC7gec82zg02UJ1Jc0ZSpij2nrK5NwJ0zyWgNHmpv7q24BOEinLcZAauT0UWrXU2Mo015HXewdffA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AD0sMBZnTw0KE35sGMmUqXGHBfzBgyTj4ranwu+L6lY=;
 b=LsWbNI1rXNbf56+gdfm9/WHPpzVMxttPN0r+L14T8WYbZwdlrzsqbNXozPbDknuGSNCvowWdLNlVW30Yh1svqjEksK7JhmJGF52r8sODC2i2Y/OffkphWA4aPAFGG3o0tXpyDkBcl/VlzLtxK1mLVjLxVXWu7IBTCHV5K0bm5iA=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by BL4PR07MB10385.namprd07.prod.outlook.com (2603:10b6:208:4de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 07:06:48 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 07:06:48 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: "mathias.nyman@intel.com" <mathias.nyman@intel.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] usb: xhci: fix loss of data on Cadence xHC
Thread-Topic: [PATCH] usb: xhci: fix loss of data on Cadence xHC
Thread-Index: AQHa/2D1v7Tx38XDdkOfqL/qNaUw7bJIw3GAgAAB0kA=
Date: Thu, 5 Sep 2024 07:06:48 +0000
Message-ID:
 <PH7PR07MB9538734A9BC4FA56E34998EEDD9D2@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20240905065716.305332-1-pawell@cadence.com>
 <PH7PR07MB9538584F3C0AD11119403F11DD9D2@PH7PR07MB9538.namprd07.prod.outlook.com>
In-Reply-To:
 <PH7PR07MB9538584F3C0AD11119403F11DD9D2@PH7PR07MB9538.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXHBhd2VsbFxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTY5NDc4ZThjLTZiNTUtMTFlZi1hOGI1LTYwYTVlMjViOTZhM1xhbWUtdGVzdFw2OTQ3OGU4ZS02YjU1LTExZWYtYThiNS02MGE1ZTI1Yjk2YTNib2R5LnR4dCIgc3o9IjkwNTAiIHQ9IjEzMzY5OTkzNjA2NDYyNzkwNSIgaD0ibnpxcGF0emZhL042d3QyTXUxSjY3akVwbndzPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|BL4PR07MB10385:EE_
x-ms-office365-filtering-correlation-id: 7324f871-3894-4a76-b14f-08dccd794f09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vD7hc1ZOxGhw7h/acG2E5yrXPTY/686D5UkRURR3OT2h7adF+QARVG/VWe/P?=
 =?us-ascii?Q?k4nFqkpf6tJEYT7GLkjMQCicQXYWFulixHKLYsZ9olDvJIKKI9wcT+NMIsOm?=
 =?us-ascii?Q?sPy75S8D9lO1Lx/FaxSAkf/XSij4ohFXbrjK8YXGM6Z0Y59piP/0tVVLq2dM?=
 =?us-ascii?Q?xkddj5AVLEZ5Y1OaaQ2obJYgVqys0zQGxpht3EJvPeqijLPLTFAuoa/Lsu79?=
 =?us-ascii?Q?PRmTm1BiSwoShOOEMZj2iuNFGh9j8A0Q5bmif/YqvTxEt6VThwVdRHSIo6bv?=
 =?us-ascii?Q?Jr1vWzBGyu6u1qNbZIoH00BiXJq2HhZ5xD80ppRP1TDNFeYwqXGS/vYcSYeG?=
 =?us-ascii?Q?P6bZT+IOIQdWX836FstE+m0l4FXGWqCOl4g8/3eccunauixw8c4Ilv0A2B3F?=
 =?us-ascii?Q?RzqeMK7cN43Ue5rydA77CQILqRFhC4HuYRy5DiG4ebAciU4VCOSiVoAui1a7?=
 =?us-ascii?Q?KU8xKM0AkDn0kateTc3JN7lIQgoEY3wPw5r1EK0jzChkZAXdXBruQ5d+QFKd?=
 =?us-ascii?Q?6k2JJwYJgrbOAH8W7Sy4vzeNNkzbISPKT54cuPslxa1/j8ki287jLZPv+ODP?=
 =?us-ascii?Q?P3hDAEeo4Wnz2EpSfQf/nkJPkeayyuPNxswxNgFwILpqUO9ydURjXsaWw95C?=
 =?us-ascii?Q?wD1NFjATLHQSvZSHqImI0JbHX/280o99++LnNYS6a1SbDNyODyKEk05q1/AQ?=
 =?us-ascii?Q?eUh3wIXrjDxoIE6yVqEJAowsgUKK4/1S6zCn2TXZE6w3um3kvrsxS9feEPPT?=
 =?us-ascii?Q?S08+X4+6C9H7e245aL0xumW12nsZae5iCIkMdHE+znRunZE6GNA4HtvMQK9P?=
 =?us-ascii?Q?XdMEBq0nD6vdMs1U76F7MOJG+fR3ACN028ukmnmVCNM1UJVVymrq40zWkvEi?=
 =?us-ascii?Q?xKI9ahD1svkiL0kTqbY+wELe9HMCYr9fBzduiMtV0TRk1vA08LzPUXuFZ4o2?=
 =?us-ascii?Q?g7D0ZccxeAmYaPfgHI7Epp1kL0adr+nYryaVWf9yOgYVDiik2BJp7TsDBlcF?=
 =?us-ascii?Q?uN8lOKI/oMFHq1iIwPjZSD3h2YxaIKIy9nICjRwB6t/mxVMcxtpgb4TL5bGy?=
 =?us-ascii?Q?PDL8WTZh6/KcQO0PcQxO7Hq3wIvqYpfpOKk5XxEGFpROsj3khwbmSBTsis3C?=
 =?us-ascii?Q?w4lWiMzMDG1bCeO1UlC3wG6OvFin0avGPLAqX98HMoL2C+T24zm6uqaqL5dG?=
 =?us-ascii?Q?rmvGJvvVT/VNxLw0/v6YMZjPKzef6HocMZZTMK1hlvEJZqcLYk0DapN7N1aG?=
 =?us-ascii?Q?NEOEaCcTWVyP0XSAmZE0esy4TjKusmH1HQIrBschcq5VBwsvvYFgLCmxoJL+?=
 =?us-ascii?Q?1gZR+TRcJLBGcjHyAQOvz1yqg2HalaBjk88cQNOQnXiJA/Qp8+tEsd7PVxIN?=
 =?us-ascii?Q?eoHBB6okmJzkaA7/Efm4VXdexShkTN4wrPgX9zMgLVNUkvkIjQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sHiCmZsgcXyOI//q5U0/BQ+dCKmomnfCxSbNhNAdw+LctMyEbJks4Bp7vQS6?=
 =?us-ascii?Q?TlFRYeY/XwAPwRhpBUw6XVlJsL6UZK9lhX6WW3n5wg/3vn7yJKBDL6W+IKI4?=
 =?us-ascii?Q?CiPFLx5Wr3xprzGH8Q69juvzMewkxT4kOdB8P9JqG7E7J0mubyDwdJYEPH1K?=
 =?us-ascii?Q?alNnnz14KCkbs2a8ofYEJhn3iozNsZWdQr7mqw1OwKug4L8WspALMvrdzttB?=
 =?us-ascii?Q?TxaH3RMH2HXHsebZvIkhaW+qPhlTyCpD2g9LwczGNFTiGGm34ZoaUsDvnHsJ?=
 =?us-ascii?Q?TM8XNHyGGyHVektZTz6ECo0QyTPtdyB+LGEXlN9zrpbfZ+nppbdMtKLtD5tX?=
 =?us-ascii?Q?vMbNIlsOiH7+td97ksUFVrDzc3p7rQjncZ77ZW/TqTJ+zLxiCjbtJjoagFP9?=
 =?us-ascii?Q?IanYnaJx6AosrtF+Sj0h32M5P+CDG9tRHyYyVOFAbEmvztUSgaco24/Ig9vv?=
 =?us-ascii?Q?wERQaN7QkKsoVRWHrazGBvnxSJnad4+1dWQQq3IlJowxOnL8a1yB2uv9yvL9?=
 =?us-ascii?Q?z4+/e+KNKuoOkkmyc7MwcY0HbIoNxWyBg6h+b8ZcMExf4xsmrowVbRH5jxeh?=
 =?us-ascii?Q?kkJj5bq6VCW7EKh68qXTTTuKb3Mhe+ZSIdPO+G8CmHHnASmlSmpIf+1flQov?=
 =?us-ascii?Q?uw2Ly19VNHknqznisQx4ulwvEfbkO2erOGGs1uzrCkqbNGxVMVVHP0Pyf5Eo?=
 =?us-ascii?Q?bk0Yao0F8TsmaDTf/VteFyiP7bsGaUSEjo11ssNdBjDwbgXxgtsJQH0ekm2Z?=
 =?us-ascii?Q?eqigTKXuMXXKa9WsZ8AD8/NioJBrOpeIyI+UKlfv/rBTrkAoJrNAP9ubKIIb?=
 =?us-ascii?Q?1sBRPVtoyNDylEg9Jxtnl2SjvVJscf7aKDXmyk+xJA5sOjsckYd37ZXBYliG?=
 =?us-ascii?Q?jIbYU3LkQ9ubc2CGIDkC/WsFYJ8RnX6OQDYFVDTyd9yrJ8YChA3KDIRpk1Kw?=
 =?us-ascii?Q?BMkrBXwAsz3FNoR1ag3++JaJ7wXfgHFSHJjQCNmYczh9SNny0e5Y7iK3BDwZ?=
 =?us-ascii?Q?wNS3dHXsbKSAaojdb3oopUXDgAm9HWvI2/OHJz4bAexmYLbc63IPw/TRIPd+?=
 =?us-ascii?Q?l8/X/JcqYOypPmrzgU3+s2hZzZRdynr9T7NZi2E14AfU7vebBKmCILWeIWFy?=
 =?us-ascii?Q?IHwXpCcaGCnHbsZa9srO9EPoBm/SX4VMZRreR7XujszK/mSs9K8z/rS3EplE?=
 =?us-ascii?Q?dSlTEsOVKyW1q4pFwmfzKrXEQHTz8MC7/HMzK4kPMozN7c11auJOjXubzbrC?=
 =?us-ascii?Q?Gf+Y4jYH+UgwF/93QVU6iIL7MYsvYcEc01yVF1VmIFrbFjuJDPT/uwhhGCwj?=
 =?us-ascii?Q?Sg9Ven97+qCa/G+YxcJF0RcPk3CiWrHVoddQNQbf5BZeU4L1FFWmxEuoWohg?=
 =?us-ascii?Q?bK5pZ3Gk5h1idYhwlby1xCqR3YrMxt1FHPoBX7dTkfeSZnqgwY6k4ugga6n6?=
 =?us-ascii?Q?ejYLgbbJFmgZZ8IfpkS7SO6BOxgE8GkhdhOZ2yQZ1b2jbnqoFTRXg0T9FSso?=
 =?us-ascii?Q?LLORAKoYsieLX9A+AiZBKvmsawOJwJcnw4cOQQF75+UO9b8YrbRj83O6CBWp?=
 =?us-ascii?Q?mlGqKf2vQETjFvUQGRrVFMv9yHCxJMUyCXhlMBg9?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7324f871-3894-4a76-b14f-08dccd794f09
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 07:06:48.0481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O033xI+iKeljTHyquZnNn8PoYaSpq7djshDZzOCjOF+s4NqKxEv40U0fC4MTejs3UUZLEE+ODAghNA8BQiwCNA7jPhCmeMYk5zjjx2LHlJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR07MB10385
X-Proofpoint-GUID: 1w3fpVd0pNjft6xdbqYoLH6Fbs2dRVv0
X-Proofpoint-ORIG-GUID: 1w3fpVd0pNjft6xdbqYoLH6Fbs2dRVv0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_04,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409050051

Hi,

Please ignore this patch. I send it again with correct version in subject.

Thanks,
Pawel,

>Subject: FW: [PATCH] usb: xhci: fix loss of data on Cadence xHC
>
>Streams should flush their TRB cache, re-read TRBs, and start executing TR=
Bs
>from the beginning of the new dequeue pointer after a 'Set TR Dequeue
>Pointer' command.
>
>Cadence controllers may fail to start from the beginning of the dequeue TR=
B
>as it doesn't clear the Opaque 'RsvdO' field of the stream context during =
'Set
>TR Dequeue' command. This stream context area is where xHC stores
>information about the last partially executed TD when a stream is stopped.
>xHC uses this information to resume the transfer where it left mid TD, whe=
n
>the stream is restarted.
>
>Patch fixes this by clearing out all RsvdO fields before initializing new =
Stream
>transfer using a 'Set TR Dequeue Pointer' command.
>
>Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP
>DRD Driver")
>cc: <stable@vger.kernel.org>
>Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>
>---
>Changelog:
>v3:
>- changed patch to patch Cadence specific
>
>v2:
>- removed restoring of EDTLA field
>
> drivers/usb/cdns3/host.c     |  4 +++-
> drivers/usb/host/xhci-pci.c  |  7 +++++++  drivers/usb/host/xhci-ring.c |=
 14
>++++++++++++++
> drivers/usb/host/xhci.h      |  1 +
> 4 files changed, 25 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c index
>ceca4d839dfd..7ba760ee62e3 100644
>--- a/drivers/usb/cdns3/host.c
>+++ b/drivers/usb/cdns3/host.c
>@@ -62,7 +62,9 @@ static const struct xhci_plat_priv xhci_plat_cdns3_xhci =
=3D
>{
> 	.resume_quirk =3D xhci_cdns3_resume_quirk,  };
>
>-static const struct xhci_plat_priv xhci_plat_cdnsp_xhci;
>+static const struct xhci_plat_priv xhci_plat_cdnsp_xhci =3D {
>+	.quirks =3D XHCI_CDNS_SCTX_QUIRK,
>+};
>
> static int __cdns_host_init(struct cdns *cdns)  { diff --git
>a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c index
>b9ae5c2a2527..9199dbfcea07 100644
>--- a/drivers/usb/host/xhci-pci.c
>+++ b/drivers/usb/host/xhci-pci.c
>@@ -74,6 +74,9 @@
> #define PCI_DEVICE_ID_ASMEDIA_2142_XHCI			0x2142
> #define PCI_DEVICE_ID_ASMEDIA_3242_XHCI			0x3242
>
>+#define PCI_DEVICE_ID_CADENCE				0x17CD
>+#define PCI_DEVICE_ID_CADENCE_SSP			0x0200
>+
> static const char hcd_name[] =3D "xhci_hcd";
>
> static struct hc_driver __read_mostly xhci_pci_hc_driver; @@ -532,6 +535,=
10
>@@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
> 			xhci->quirks |=3D XHCI_ZHAOXIN_TRB_FETCH;
> 	}
>
>+	if (pdev->vendor =3D=3D PCI_DEVICE_ID_CADENCE &&
>+	    pdev->device =3D=3D PCI_DEVICE_ID_CADENCE_SSP)
>+		xhci->quirks |=3D XHCI_CDNS_SCTX_QUIRK;
>+
> 	/* xHC spec requires PCI devices to support D3hot and D3cold */
> 	if (xhci->hci_version >=3D 0x120)
> 		xhci->quirks |=3D XHCI_DEFAULT_PM_RUNTIME_ALLOW; diff --
>git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c index
>1dde53f6eb31..a1ad2658c0c7 100644
>--- a/drivers/usb/host/xhci-ring.c
>+++ b/drivers/usb/host/xhci-ring.c
>@@ -1386,6 +1386,20 @@ static void xhci_handle_cmd_set_deq(struct
>xhci_hcd *xhci, int slot_id,
> 			struct xhci_stream_ctx *ctx =3D
> 				&ep->stream_info-
>>stream_ctx_array[stream_id];
> 			deq =3D le64_to_cpu(ctx->stream_ring) &
>SCTX_DEQ_MASK;
>+
>+			/*
>+			 * Cadence xHCI controllers store some endpoint state
>+			 * information within Rsvd0 fields of Stream Endpoint
>+			 * context. This field is not cleared during Set TR
>+			 * Dequeue Pointer command which causes XDMA to
>skip
>+			 * over transfer ring and leads to data loss on stream
>+			 * pipe.
>+			 * To fix this issue driver must clear Rsvd0 field.
>+			 */
>+			if (xhci->quirks & XHCI_CDNS_SCTX_QUIRK) {
>+				ctx->reserved[0] =3D 0;
>+				ctx->reserved[1] =3D 0;
>+			}
> 		} else {
> 			deq =3D le64_to_cpu(ep_ctx->deq) &
>~EP_CTX_CYCLE_MASK;
> 		}
>diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h index
>101e74c9060f..4cbd58eed214 100644
>--- a/drivers/usb/host/xhci.h
>+++ b/drivers/usb/host/xhci.h
>@@ -1907,6 +1907,7 @@ struct xhci_hcd {
> #define XHCI_ZHAOXIN_TRB_FETCH	BIT_ULL(45)
> #define XHCI_ZHAOXIN_HOST	BIT_ULL(46)
> #define XHCI_WRITE_64_HI_LO	BIT_ULL(47)
>+#define XHCI_CDNS_SCTX_QUIRK	BIT_ULL(48)
>
> 	unsigned int		num_active_eps;
> 	unsigned int		limit_active_eps;
>--
>2.43.0


