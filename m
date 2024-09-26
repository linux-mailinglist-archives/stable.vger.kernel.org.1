Return-Path: <stable+bounces-77792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D919875C3
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 16:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B77CB25D57
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 14:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84562B9CD;
	Thu, 26 Sep 2024 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b="kMZzz/as"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.129.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D3B49634
	for <stable@vger.kernel.org>; Thu, 26 Sep 2024 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727361482; cv=none; b=SpB2iUBszDaRG+YBdBIQ7dPHTAJgtJp1Jgz2+p+WJUGORRlH2tBaUqsvO0qA2vC/o6LMAmdygEN3bhGYRVnB0KfNiw7yPCmj7F9DWbFPzRZ8b7Ze8GjiRU5zbZk9RmdS/7mt1jLmD35HtVyFKz3/xIwPo5aSTmTLRPHxB5Z2ebw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727361482; c=relaxed/simple;
	bh=aHpqVet/RmCFdbBd8x73KMxgCBS0pIu/IKY1RHuyXjw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zbyy7r9smajI/IJm0X9x3lYQeh4fo6wyzht8nju3mrq1PixHzqfehXdg0qU0sR1rtIllVwLL0ktukfA5qOSXEiQ1UmH0QznoguDX0lAxEsvXmqL3/V84t6Wmxs/J/AXJyoKqG80Y3Wbn2abmgIJfDrqoj/bFs5/FkeB1cvwUBWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com; spf=pass smtp.mailfrom=hp.com; dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b=kMZzz/as; arc=none smtp.client-ip=170.10.129.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hp.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
	t=1727361478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aHpqVet/RmCFdbBd8x73KMxgCBS0pIu/IKY1RHuyXjw=;
	b=kMZzz/as27f8FK4yJeWafRj54po6B3OlZ3neAestp7yHsJ8D8CyWa+flaY6iRor/+gotZZ
	LmMjvGsiRNGirNcKN9A5xDdwNN/deZdSkft61/5yVhgGmijpAMePliodi9GMXVuCqaZLwj
	0Xv9m4NPna5GfAWkEXybVsLj1aoVdrE=
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-187-hMS-fqJAOtSxNrGriNvNxQ-1; Thu, 26 Sep 2024 10:37:58 -0400
X-MC-Unique: hMS-fqJAOtSxNrGriNvNxQ-1
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:437::8)
 by SA1PR84MB3383.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:806:3d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Thu, 26 Sep
 2024 14:37:55 +0000
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8cc2:658d:eae8:3d8d]) by SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8cc2:658d:eae8:3d8d%7]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 14:37:55 +0000
From: "Gagniuc, Alexandru" <alexandru.gagniuc@hp.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Zhang, Eniac" <eniac-xw.zhang@hp.com>
Subject: [PATCH v6.6] nvme-pci: qdepth 1 quirk
Thread-Topic: [PATCH v6.6] nvme-pci: qdepth 1 quirk
Thread-Index: AQHbECEjydg6PoyAWkiJlqcGaTPpng==
Date: Thu, 26 Sep 2024 14:37:54 +0000
Message-ID: <SJ0PR84MB2088FFBE6477CC164DFBE5D28F6A2@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR84MB2088:EE_|SA1PR84MB3383:EE_
x-ms-office365-filtering-correlation-id: 7ab0247e-17a4-495f-f867-08dcde38cee2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018
x-microsoft-antispam-message-info: =?iso-8859-1?Q?9Uj7wjQmn1I30GoWWH2ZWkY5m2hjdawb6M7qXCGHeb6MtUDy1k6PQGlk37?=
 =?iso-8859-1?Q?C5Sg2YJfeqWC7yl8dKYyIP8PIM4kSSfqKyGHkpC8JWLKsj2hGj/3LMvj46?=
 =?iso-8859-1?Q?7OmVegkV+DheEZxO+CEkuhtx+lqWrfGLDnnU13vurV7dpikcO9bDOOxZoN?=
 =?iso-8859-1?Q?deL7QnSv/tvVwIVaiIM+cKine89lbGf0F85/Ejlc12ePPVZIc5PfcqWYY7?=
 =?iso-8859-1?Q?eykvz0Y61ZC0dC2ikTqyHKn3FTABFYNWuLc3+MR15xW6ar6m/6hP4NQ9ZQ?=
 =?iso-8859-1?Q?YkeVlicXuDeW6nXtpr08gStVCWm/3OgawMneQDgCyofQ7pER+2L/2LFiIN?=
 =?iso-8859-1?Q?2PsiWHFY9PwxWSqXe/bTna8ICJyBtFCJaA2fnDRB9wwKe7jTwilV/c2NGv?=
 =?iso-8859-1?Q?uu1NZHWIpcfyLcbhh3TKWvI6AL7CrwrKA3yZWWWZYX2Rel+4jIcbU9GOKP?=
 =?iso-8859-1?Q?UOP+6/Qj2tibR9hFeypUJMJdsOxJ0pCgxI0dmdD0KTkR5IS20ngCevzQMk?=
 =?iso-8859-1?Q?1QYfWaA2N2dMCmoshn7nLdhE0btLU9VrtEcbR8RTxS9gIjkJOsQMjpxlDx?=
 =?iso-8859-1?Q?tMpqk9lUFSrD9Rkxej//cyq1kJt9dy86jtZOTPC0CBHXiBGFXOsHogt+lm?=
 =?iso-8859-1?Q?by8GWqUDysDSGwjCYWoMvmhXa35UsBxi13hkm6XZo3C6h9RV57ymYZ1nfJ?=
 =?iso-8859-1?Q?HelYVqcurzl8GfUix5HJpk2W0tcwLz+bRhm9NN7ESpMqokopB8ZaxSI8r3?=
 =?iso-8859-1?Q?NQcVE8eLJ2tPNjHja2FqlUdcec/FpCubDWivBGa1Uq1zPN9TB1wKyuoBd8?=
 =?iso-8859-1?Q?s/ZFkpB+DpHlNcsYBs0qL16URHNGDx8oJ538NRoE5YDdeb6WbXP7BQbgkY?=
 =?iso-8859-1?Q?rPvN/gBXppJT7AJyXTZtQsIqPd/ejsd0qbqp3ai9F7UR8ALjC5CdQrF3RE?=
 =?iso-8859-1?Q?+DqCBZVZpmrALJOSuiMHKlbMNzEprb3X8LbQTfgEpnzCBPbvEy+uotQDK6?=
 =?iso-8859-1?Q?d+GXuWNe1SyXP6jtiQuoDY06R7WLwgLSVp8g0NrzOVZkhr5xg2htFhPJ/6?=
 =?iso-8859-1?Q?0wil9gr7IYL5YW4E6kJ00lTZfxy9hPG5uVHsWdXAWW/lIjuQbqzm1uFxbW?=
 =?iso-8859-1?Q?Gg/4U+pquBxPOtU/2OdFWh11v64SnQ5hrdgEJ6FsffZs0ZINdp0rF6gOSh?=
 =?iso-8859-1?Q?Py2GI5tUWCbxQuDYdBPLisiUZ8hSEzesWMvu6zuXjX8xDsj++q0OV8jF9O?=
 =?iso-8859-1?Q?IKUypFFCVCWtUQJ4KuEEvnpqw4g0QCGp6oOSmrM1+8HjnTHOEBygOVCwlm?=
 =?iso-8859-1?Q?ygnXqgvl0LzHQ0VitOWz/TyyE9YIBUCcbVvYFBiBixiqufZroOerpC5u9y?=
 =?iso-8859-1?Q?YWOSE5xRP7Gk6dBe93bkBO9KqWg2DKgA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Vc/bzYzdrlEey6EPFtoSV4ErVMiUeBaf/tZGquyUy3j4vqoFg+bUn8d6pQ?=
 =?iso-8859-1?Q?Bl6RPTMS6o3u6jGSMQLZFa5jfq5gR4LJYX3mMpzw7OUG/guA8aZguzDdGm?=
 =?iso-8859-1?Q?9KLLKrS6vRHqaYsaMOeicXSEw3Ade+Iy/yBfNbrnfJ6mZdfLol5VXBZ2HS?=
 =?iso-8859-1?Q?KhHjNdL6E1UKSbx40HrXbLXcHyoYC9oBYeQqKXSOXE0zl0Fhf6GoS0Gw5g?=
 =?iso-8859-1?Q?RiqA5IjRmcavLMIQJI7mNa+Ec8W5dmOD8oySlEi+Z40PXx5YRxtCJDK4Ng?=
 =?iso-8859-1?Q?800HKNUcDcZiOpX3NI6zBJVCVK8/idh9SNFc3aHGRlJlEw1hfpXr4/JKVu?=
 =?iso-8859-1?Q?BHfYFjxXpCMvHU1G6iPvybo+bZcJYL3xvfpGyMq2lKPYCXopGlNU+caT/4?=
 =?iso-8859-1?Q?EK9WUKo+wF0iBIRrWuqVQ9deMf0K4TfenA54DjnseAHTDr/M2gJwCZOuNp?=
 =?iso-8859-1?Q?BVsDZBmbNbg0ybabo5cF3Pq/P05qv50p7hz5mh+i0kjxFBzbnJCB+SwF84?=
 =?iso-8859-1?Q?QED2ivXDEd+fghNa1vwbE9h73CXtnJaaFkfg5xPmMfQEnH5iSm8p1FC1xc?=
 =?iso-8859-1?Q?ydgnptRAMoOclbuMasrFfJLd3SkovnvwNS++F0vBhPEUSkWHSMQfx0YzSG?=
 =?iso-8859-1?Q?NfHQ1P6mGTQt4cgOD0qgHYFPv1OhLEUoPxCazlcD5C4Ofh4VOlqQ9VNdIr?=
 =?iso-8859-1?Q?IJpjVCX36MKoS5NckJiGXtJzFj3iypRAF0FJt3ABwFzXw+PH2PVUDTaaJ5?=
 =?iso-8859-1?Q?4QrJVToVfCXvFdY5z7xrbU5f7BW4CBfM2WmENc5kMGnAegEbAy92D6CQMe?=
 =?iso-8859-1?Q?C2oR2K8+ZgexONUxIT/jyo7XNPdKj81hVEj1jgWhOdfS3CjiqVGWeZDgdb?=
 =?iso-8859-1?Q?uhrjHeltV4bp7fidMwTprRJCxYga4hOLbTtHaxDnKPnxjqTglcWWHrt3cp?=
 =?iso-8859-1?Q?t5u0PEOc//+vaq3HFIguw7R6c8Du86KqYAXWZqmFEt/LEtSvNN1trbSKEO?=
 =?iso-8859-1?Q?VGtRig8KNlWgXi1tu8PqaQDyRBT0JuW5HX8O2ODn4E4osP/ZzS3rTiOyK+?=
 =?iso-8859-1?Q?NvFH4LlsjA9mpiMrLe69aMAihyODhg6V+rO+WTzrmvQNcdXM0rSFNp2vJt?=
 =?iso-8859-1?Q?LQ6jWVtfcowqpAXaXwkxlLp+g9dvII+1/IrlbXdCcFE67Dx/oiqY3a5j8H?=
 =?iso-8859-1?Q?0yt2BXe1SuF654PwpIBkebSFUcqT7M11w++T/Nt3kIoEWatwOB3KAGN1/o?=
 =?iso-8859-1?Q?ZcoRM6cIic06IBR1sq87k1NHoMPlwuFNxt7I4jNztY1YreqScvjid+QpS+?=
 =?iso-8859-1?Q?8RRRpYXM0B+sB5F/RXGAvLsKYMLhG14RB1X/bbSeIXJHxatrIXjrSzZtaE?=
 =?iso-8859-1?Q?Lmvejeak7dbBteoGPFwgZmByw+US0iUZ8+/cLlgpP88WAr14EsiOYjKygu?=
 =?iso-8859-1?Q?RePBgnYcC9EpWA/vHea2JstjLmvWn3U0gjzdSi6YvSi318Er3huej67IDR?=
 =?iso-8859-1?Q?ct+9r2OfbMu2gp6rghMrhlaWKQpqpDqpwsw1CiinP+jqdn1N6vQOv8ox3N?=
 =?iso-8859-1?Q?0ldchnxczThlJOzOrfj9jOxfl/Bs1BoS4tP2M4HsFXbPejuQdHzExp7Z5g?=
 =?iso-8859-1?Q?jV8IR75vRbIqa0gMcs4qvKZO5nSDS+Z5n5?=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab0247e-17a4-495f-f867-08dcde38cee2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 14:37:54.9661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ca7981a2-785a-463d-b82a-3db87dfc3ce6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j6tLRNOp6qaX1febX3B21uoJPcW1wAGPPEbSwE2Smgaq5im9a4yNyafvyFeIH9uptnWrT31cxKE3HHGR+u3hjbhMLK/kyEmxGHCtlffM9bs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR84MB3383
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hp.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

Please consider adding the following commit to v6.6:=0A=0A83bdfcbdbe5d ("nv=
me-pci: qdepth 1 quirk")=0A=0AThis resolves filesystem corruption and rando=
m drive drop-outs on machines with O2micro NVME drives, including a number =
of HP Thinclients.=0A=0AAlex


