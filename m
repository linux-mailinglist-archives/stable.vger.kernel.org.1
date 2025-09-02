Return-Path: <stable+bounces-176929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1929BB3F49C
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 07:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1C47167F08
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 05:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22A52E175F;
	Tue,  2 Sep 2025 05:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f5/OY3IF"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077EF27057D;
	Tue,  2 Sep 2025 05:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756791313; cv=fail; b=MXsVrvukYqhYqHYkeG8bSGu/IcpzEEbBa2R025HPQOjPA4CvL29tXbtMdFh0nyny2XgW+W48gu37sasOPKQBHOb2tFjsttG7/HzIL5/HYABSHZIM+p123fi3rqvRgI+lCVpp5l7kRDmuIMpclGGbKz9SC6Gwk0qP8c4y9dSTlQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756791313; c=relaxed/simple;
	bh=LVB+ZPcozaBSyQ1TGRC4L+eeINdqiVm4Rb28Ag0/Lz8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pWuilpsmIz6zj7vIqg2idfOh+Cib5rbH4Ka8VaEAScGDBBpkitEiI6D96gWJD0ldkSNv7oSo5BifaqPKgwENtUyf0zMi0y8bVyTA2qk5sfXk9ekGy3DyuhdWIREzqZt0BCIuIFfpW0HjwcJgOly1DaaXENbUHw1RKEJpyZNXE+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f5/OY3IF; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMQMpgPwm8B1tCXPveqIiShE0vKKDXJlv5EdlNH8sRy4K9VOWVce4M4d9ZIzxXaPStl6bKGtr56iOK4wQdy08+1BcS+x/wNmyXRSGlYKMwSDxvjQ/ZIpx7UCR5vU/r45XbW/2XY+a9tPPaT77lHyCYwBuLVLnMKOWkHoKq0D3tMMRp5hrRf2u5yo2v0K1ozQYCE5H7QhGTN+LiwsVqvppV+hKvs2P9W/sW0D9vm2BGYAGVd1yQMzbmLorj8Gc8rb9PTAA/sRy2eLtyFe+waZ58bEfCOaC9+CqT96B/cbSGr4ZYfG/C6ZQV0AGtOSlQ8EwHaTUMuccTT8V/m2U53DZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpz60VTQpUy8X6xAtDQxKKJH97KtzALJ23EOZNl8AfI=;
 b=YFVW3LLLwQMk0nvU7MEA9XwbY5srZMnnGZXGa/G6oFuPwHwpNbkVYMQiL5dsyvS8A+vl/5jcO47SlvtxdtECFOy2j0cL/xN0Tid5W7uqqJboxxGWg+jmpYeCceXvxWGq4Ezot/7o6iytn6GZRbDf5KwUc2nUD4B9HX5excYK474RjR4afFs4VSRjDfB/zbX57KypnV7xV01y0v0kp5X2K/p4Fs4euNn0WB24DVM37kmvQNOVDGNBdt7EZEKcBQzZSYidhiHtVq1QHLbfJxHxGBGGKQpmSZYREqDXN/qYmhnGdTz1kF/X9YaLlzFyQYRUl3524V1Pq/ih1smTouIDWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpz60VTQpUy8X6xAtDQxKKJH97KtzALJ23EOZNl8AfI=;
 b=f5/OY3IFAhRYZjkcCtSAGwA/bGFwts/WOnHsaRUg5apcmsCTlqMGJoHTkS6fz59bKYBMi7aD2mMtiOVrX7kALaQCF9Uu+n3qajS2FlyWpLPJPvVXornLtsFopQKmi1APd0+xffsbq+WKnFiuZkpG8++HzlvBrzOMyncXQOPIOpg=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by DM6PR12MB4385.namprd12.prod.outlook.com (2603:10b6:5:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 2 Sep
 2025 05:35:03 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%6]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 05:35:03 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: "Joseph, Abin" <Abin.Joseph@amd.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "Simek, Michal"
	<michal.simek@amd.com>
CC: "git (AMD-Xilinx)" <git@amd.com>, "Joseph, Abin" <Abin.Joseph@amd.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net v2] net: xilinx: axienet: Add error handling for RX
 metadata pointer retrieval
Thread-Topic: [PATCH net v2] net: xilinx: axienet: Add error handling for RX
 metadata pointer retrieval
Thread-Index: AQHcG6lzcJoCobRwKECrqYgv4+SAPbR/V/5w
Date: Tue, 2 Sep 2025 05:35:03 +0000
Message-ID:
 <MN0PR12MB5953745D77A76528DDFD72E5B706A@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20250902013205.2849707-1-abin.joseph@amd.com>
In-Reply-To: <20250902013205.2849707-1-abin.joseph@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-02T05:08:45.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|DM6PR12MB4385:EE_
x-ms-office365-filtering-correlation-id: e71a9ae4-b43d-411d-e3e4-08dde9e277b2
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ow4ISTqF8PL0LnWo2myQESYRq+xZK7Cef4lng5z7YXw7oxqbQoN7wPd4vlfc?=
 =?us-ascii?Q?w5dfYfKSQtQ6YbJl5/3JFTCX0IBb50KU3lc5M9hVOjrwm4ePy56DBF83DKf7?=
 =?us-ascii?Q?K0qejWYnkk59CfV9/8EYseCblQQDD3LZdi6zsO8+B+kc8apeLXizrGq68UEh?=
 =?us-ascii?Q?CT1Hrid6t5tp8HmP2ncvxFtBOcBY1wwzQ+utioNXWwRQ+hcyhyx5pJbZ3tDI?=
 =?us-ascii?Q?xhrPlrNIKlG2qR+Q5CXl2EuoSFXEgiejce3vplwXVHrQfNFKa53V7lRR1cQQ?=
 =?us-ascii?Q?sCeY6yMognjFtq6pkXDA9KkJFQl7qMNhozKPzvYFYc1o3zoxhqsQcxqadADt?=
 =?us-ascii?Q?TrknEAbMpXoflXqS1QIsR2+wBDdw/iwn8+EbSl9skWDgXmmn7ER80uWfuoRk?=
 =?us-ascii?Q?43Rv72IGWG10p2ps5PIzXaUf6APAivm9oJdtmrlbfbOJczAhVHomYu+78Cmy?=
 =?us-ascii?Q?db37PuniBrfX5e3y3L2RIw/K/J7DhCZyKtJFcopIB+Q6de6R114xyPgK+0Mp?=
 =?us-ascii?Q?4yEJPL2eWKdt0tYl8PWcxpOj6FIJcJfTuyBQmA9QbGLi1LaYXTlUSqmgtnKw?=
 =?us-ascii?Q?5EU3L69W4f7VtRBMCDx2zmR+A4FnhldqbcTRCx6CjeaPLmlzcp7h1dFsHmxD?=
 =?us-ascii?Q?mHMarqqHaGFbmIkRT5rheIW8rsHwQbc2a/vJk2C97rbYlhBF+a46dEgVXw6A?=
 =?us-ascii?Q?+i6o3dqHvEg22oN8Ea5zA6Hw+B98bR685d6nMQKJ3Hw9V9mJszB4fGau+y5n?=
 =?us-ascii?Q?MkJ8x1lVXkJBnvHAEzFtiqX2IRNoW1F8yIM+uNcr8iTFcTKNXKxfA0v5lCQY?=
 =?us-ascii?Q?77k392hOK3SfyWGqs02plDc9FAeszpcaUFiB6gQJt0pZ67x6uouBXMzyTYtw?=
 =?us-ascii?Q?CsBuMlmzeQd+6aBjjiQfJ/zg37+CG7/mD4R7fUGPFdliXHtpmc06dgSgKtb1?=
 =?us-ascii?Q?Ci+5B3o0SQhmc517qH33ubfVdSc/Ewwr48oPCEr9ZJDABi+VrZo7Dj6pEzTa?=
 =?us-ascii?Q?qIrKmZcu+tD3CrDklEyp2xdcJsv0l8nRsYhSReAPR95I7n3UU+aT6Thnxbd/?=
 =?us-ascii?Q?+cuLBrWKmqOoLTpmELvGV1HN8QCYC/mRG6Yd0LopQYaQPDJjtQXbHygHZIdN?=
 =?us-ascii?Q?8Jggaf+T6lsNS7jDAV4Qf9LFsY0Uu63vD3xW0jbNHMWQGELfn7ngTt+YyJbk?=
 =?us-ascii?Q?saTa7k8A16Adh3Ez4RpoMsxrjOuBCnhC/kM/15sVtH7XC2+b9QYtHoKJiDLk?=
 =?us-ascii?Q?JnpUmTMlVW+x3XAlgxLWvOqBiMlMA+6tGix2E8/zSI9DxTh6GZryGMM0f7Wk?=
 =?us-ascii?Q?kGsv6RAAeryFIFT7GhI6s0JrOaMNvoVXnN4PlZ796TObJV4hsU496zzImVdg?=
 =?us-ascii?Q?hBD4EKYIaYgaDT7uJuAtx5oFz3zul30/C5DfJuI7VPze8CFYnbO158nhLMlB?=
 =?us-ascii?Q?CVJ9ftfRnJsrMUFN8wssWi0NbAJvD7ffu+BNVKth2bdWBMi5NobW4w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IVvJ4IK6oEwe3EDWqLmfOMxKat5/6LBAtFjgjACtIDTsduIINgHrdvxtzrG3?=
 =?us-ascii?Q?LqGQUOZC2l4QsAISH8Saoph/xuR4Rec3R+b0Pm6h74A0efkcXsFETjG4k2Cr?=
 =?us-ascii?Q?wCNCmwpXf3EI/ddYUODLaHt5yqnt6ZikiiqdUoiMd3gFaXjtZ3xf+1keBxQR?=
 =?us-ascii?Q?mP6wuKyA5JXFbnfoWH5OYMWPdVZxUTlg7xlNXGVDqDTQJuzJmvd6vwOBHys2?=
 =?us-ascii?Q?caFmq7+I3aiD1i+0gD6y/T3YLZPcfdZ88+bS+7BVKM5uhJcQsKGS4lNGgDnv?=
 =?us-ascii?Q?xZVZGBzDYFTNMkvzR/PhDyn1ZmyEWRb5OzS3PSIPyS8lnpIkK3upBogvpD4P?=
 =?us-ascii?Q?it6q3bIfgyrrZvqr6umiMlI4zZGqr+FPS0N7eFqE7parqu1NpdQvrJ+yT4dr?=
 =?us-ascii?Q?5dy+PDWdMFhvtcby6/QDtun7aytsfMHt2De8O8HAaxW6ALkc/b+WKDfM6BKq?=
 =?us-ascii?Q?v22konn7lcErvfKYhVffn+y/CHlJyNHgihfq3mQZaW3dlU1n4lLzV9CkA4cq?=
 =?us-ascii?Q?ECvTmzMOMTGXbsfcH4ab/PAnvSBWF7+lxqZZ8W0l4BAXI5OdKI3aNyObU+Mi?=
 =?us-ascii?Q?Ukk1NzYhIkxcg34uVTOJilbG2+Lec9/45bGky+0d05BadncVZvOzzwpc5g3y?=
 =?us-ascii?Q?nJx6DzsxZnnMvTgbWsXxWenX/KifcqcHmhGkMEtT7KaW107x2uxZLNXOJqPi?=
 =?us-ascii?Q?GLR/jiZOh/q0IdILzK7QIoCaPORd2laCE7jo4nSmk0DADG25IKOLWPlkoeus?=
 =?us-ascii?Q?Q8kHF2HgJ7vMNYHTzkC58CITIqKAnazgXE3tWEA0hxVTowZ2LRWj5eFjPs3G?=
 =?us-ascii?Q?7uVsvE2wVxO8tw/TsC46d+pWFKhyIzPjMSfhjFsde/NKKjubRrINLxQ/LfNC?=
 =?us-ascii?Q?7PFsYBm4Q146Ce9DvyZgrAs4jgGLUxYW9vAOFkpO/nzjaTRuArht8ehBvkRm?=
 =?us-ascii?Q?Fsfb4BUzrPWyg6n/IjE9rBgBvmSKNnnXcmwsxyyk/gjA9sC9QodSpPzc/1Dq?=
 =?us-ascii?Q?kj1J0fJhSGWw4cSHh3LRqDLQT//8FTvuEVaY1vWNlRKc6yuE3n1OzxRcOzIU?=
 =?us-ascii?Q?HrBN5eo8TPb0RPEEdpxf98zwvH7FWzuAHsmMbiPtFAy7OyFfp57jzxC+zWG4?=
 =?us-ascii?Q?biUCIrI8WbGmkXoi/+cWpOuxocgE72WzTPaZpOg9Ft+cE56WG2gXxSqraUoX?=
 =?us-ascii?Q?izmqC54yUclQ+4spdYPGlZitxXOyTfUuGN5UXYdC6mLsAtboGWVGAFcf07gN?=
 =?us-ascii?Q?E7i26kilPYMdYiycjZwUFPw48AXhGk33C2n+GQtWNFliQFt0O8AncUkuwLzh?=
 =?us-ascii?Q?2qKwPLqqcbmteiBvWp3uq/dmiT/MSFgL59P0kLcpTSmxVu5H4PdBW7eko6Aj?=
 =?us-ascii?Q?GrBjd9reCxWOmnnnDl9BLK6mEBf7NC+dYbuXKaraxph1EWLod1PtoCm0xrYL?=
 =?us-ascii?Q?8AL/y3btx9+LBQuBaES2rdApXQK1af0b5HpLaAlmiJ34j9CUzEbEMu/jpFOu?=
 =?us-ascii?Q?Ye6I+QhxXUC3a2v3SK9ucATdSpYEdohgS6Addy6mBEcWsdIRS1BoOg+YbD03?=
 =?us-ascii?Q?zdGHmcOPgYMqeLozsIQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71a9ae4-b43d-411d-e3e4-08dde9e277b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 05:35:03.6318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z1yAk/Pc6hYSt4SrUd2v1Rp/HlWiw93D+WJD+RRqd7+svJ+SCjRrK3Q6+k7o15J9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4385

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Abin Joseph <abin.joseph@amd.com>
> Sent: Tuesday, September 2, 2025 7:02 AM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>;
> andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; Simek, Michal <michal.simek@amd.com>
> Cc: git (AMD-Xilinx) <git@amd.com>; Joseph, Abin <Abin.Joseph@amd.com>;
> netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; stable@vger.kernel.org
> Subject: [PATCH net v2] net: xilinx: axienet: Add error handling for RX m=
etadata
> pointer retrieval
>
> Add proper error checking for dmaengine_desc_get_metadata_ptr() which
> can return an error pointer and lead to potential crashes or undefined
> behaviour if the pointer retrieval fails.
>
> Properly handle the error by unmapping DMA buffer, freeing the skb and
> returning early to prevent further processing with invalid data.
>
> Fixes: 6a91b846af85 ("net: axienet: Introduce dmaengine support")
> Signed-off-by: Abin Joseph <abin.joseph@amd.com>

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
With one minor comment below-

> ---
>
> Changes in v2:
> Update the alias to net
>
> ---
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 0d8a05fe541a..83469f7f08d1 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -1166,8 +1166,18 @@ static void axienet_dma_rx_cb(void *data, const st=
ruct
> dmaengine_result *result)
>       skb =3D skbuf_dma->skb;
>       app_metadata =3D dmaengine_desc_get_metadata_ptr(skbuf_dma->desc,
> &meta_len,
>                                                      &meta_max_len);
> +

This is unrelated change.

>       dma_unmap_single(lp->dev, skbuf_dma->dma_address, lp->max_frm_size,
>                        DMA_FROM_DEVICE);
> +
> +     if (IS_ERR(app_metadata)) {
> +             if (net_ratelimit())
> +                     netdev_err(lp->ndev, "Failed to get RX metadata poi=
nter\n");
> +             dev_kfree_skb_any(skb);
> +             lp->ndev->stats.rx_dropped++;
> +             goto rx_submit;
> +     }
> +
>       /* TODO: Derive app word index programmatically */
>       rx_len =3D (app_metadata[LEN_APP] & 0xFFFF);
>       skb_put(skb, rx_len);
> @@ -1180,6 +1190,7 @@ static void axienet_dma_rx_cb(void *data, const str=
uct
> dmaengine_result *result)
>       u64_stats_add(&lp->rx_bytes, rx_len);
>       u64_stats_update_end(&lp->rx_stat_sync);
>
> +rx_submit:
>       for (i =3D 0; i < CIRC_SPACE(lp->rx_ring_head, lp->rx_ring_tail,
>                                  RX_BUF_NUM_DEFAULT); i++)
>               axienet_rx_submit_desc(lp->ndev);
> --
> 2.34.1


