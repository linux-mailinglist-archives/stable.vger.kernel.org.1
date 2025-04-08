Return-Path: <stable+bounces-131823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFEBA813EB
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 19:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991491B67E45
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 17:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046E923BD1C;
	Tue,  8 Apr 2025 17:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="yCY/ilji";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="aB7ncnCc"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE251E0E00;
	Tue,  8 Apr 2025 17:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744134162; cv=fail; b=FTclcmoS/82w8wTtdcLEu+tUV/IaXdRSjNhudyKSmbxpwGYSU1i+dRy5aVY/SgoxpQs3zp1xzgkASDEg+uBI7QlNtF9FjOHPzK57OCpUNCf/7NpIZdJTLd8roUfzgVoiQttayGSBPq67cKfvVXTw+8F/MianXV+bKhb1TKfPsAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744134162; c=relaxed/simple;
	bh=9fg62vJCN+/0Ur2TkJxawHmPemb9Sa/q3L3aznvQvOQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tL2QMCcV/WEx9wyuoJ2GLQ3KmMDWovuqYI0fESF5C0B+4Xqi9oAhrFGrlaY264oHIXFPFTUjTExsLb4FcqjCaBJMoTQmAg/QUMfH6G9gDieSxzBtj4UNp7XSHeNNv7mD7UCC9gQwU7SB9qkZowsNHoHZIaadxBQ7YSYRqnC1gXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=yCY/ilji; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=aB7ncnCc; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538GYAXb024906;
	Tue, 8 Apr 2025 10:42:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=9fg62vJCN+/0Ur2TkJxawHmPemb9Sa/q3L3aznvQv
	OQ=; b=yCY/ilji83LjSvI9hViYug2Hs3ljVInzCf1eivU3rehQGdDsB8jgh7R26
	o5OJRUIemoR8k7LCrNEaj5Lnvqhu/+HYwdd11lCSoiMqznqbgGFlbIyme0UQ9HZN
	JjuszCR4k2nvUIn8tKM/ONXDi1eUMmA9/hrZ7VJ15zhxGbKv/hv9SUwGQlRisf0V
	5SVy9gx4c3e6hEWKX8MPTwjYgnX/xG7HuCQ3J3Av5y7HZEr5WtQK3lIjvgc30kGI
	4IhvAajsQs/jp5AewjFf67OIkYshwm2mCrRfh6RizyVqBoSJ5yMntyn7C6Uzq2TP
	u4GwhR4LMWwJ+Y/9gwxrPVEcifLxw==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 45u3kkq091-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 10:42:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebExqy7O1TA6w+2u+DPezv+P6Nbg5jSwZqd4B3M6upJOriBykqD2ULXRVxTUwxkY5VemwTq5rGqJzrZ1xxH4rL2i3Q1uJ+G3UvUIzxY/KzBR9/Ygc8MreMBip3YgrcpYrUEWskuoq//TV4ZQ82ECqaIC3U/DQI/3V6jfUbb4CObpTDM5tFJS3CPYse3PzMfiZqumlioKriYS5Wd2QC7IdaU28l8hkZqhmly4S4Pw7HtVHyZNWBD/FYIG7jghrG5Em4XLIpWP+6xN/OvBtSQ4oytDpCMbehKfItMojAJZmv+6QQbWNymwsCTJ3fX25Fh4GYMTsuS62SYShEwQpVa7Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fg62vJCN+/0Ur2TkJxawHmPemb9Sa/q3L3aznvQvOQ=;
 b=YpPDozIu/nCxG3G4KygObdAeFccniq+KfyfiV0upu4bkCsL6nrHiLM2vVNR5GoQJzN7nsCNZ4S5KwXVt49GCAVjHysZ7f5065j4WEK2b/8qzVC30BHp89vAImY8o24+z/BMCtVN514tzUx5u/HOv1xmImYddvBgYjNlPtPT44Gg9fCAt+IYTdqacJPQG1DyTobOTYbuJB3XuchAPVwwdCoCTxZONiYGuKgHnPRqR3e0yAvWtED1Ybc13PDyeC1jW6q0CTNcoLfeK2wLrzfuKQslW+SrekT7Lv4LcSWHj50csN4QWTxFOwfDrbCnTTSk2GuUUuSHsYSb0WLihVEhwzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fg62vJCN+/0Ur2TkJxawHmPemb9Sa/q3L3aznvQvOQ=;
 b=aB7ncnCczc9W3FE0SioBY43Gd42J7bmCzlyi+Vji5k970vskMBToUknlSTRjF6wfwM/O6BDJpmzs05v9yaX+FzlWODcDAWfu91I+Y52qY1lWtmXyR+6JEP2ZfkENnD2p4qSGHljFFE5inckwUx5p9Us/IgwvPOjWZh0J2NE7+Ii1tY7lgnVerKYdqqioSkmI3czxCs92eFHUMotvefvrIB5ZTrCfyDGAAGCYLYcKVIynvAo3CAUUw5wYJAGH8Y1zxMBHNlsCxgnrRe+iBcXLBRuJLSgWta17hKDmcRVepEvrHfGTgM0ILS/of+EGd+pEvOVPFRHlOFHzOTPwndnLOQ==
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com (2603:10b6:a03:3f4::5)
 by DM6PR02MB6528.namprd02.prod.outlook.com (2603:10b6:5:1bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 17:42:21 +0000
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42]) by SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42%3]) with mapi id 15.20.8534.043; Tue, 8 Apr 2025
 17:42:21 +0000
From: Harshit Agarwal <harshit@nutanix.com>
To: Juri Lelli <juri.lelli@redhat.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann
	<dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider
	<vschneid@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH v2] sched/deadline: Fix race in push_dl_task
Thread-Topic: [PATCH v2] sched/deadline: Fix race in push_dl_task
Thread-Index: AQHbluOWOVMG3UHOKUOm1bUfXfmVpLOYDI6AgAIgxgA=
Date: Tue, 8 Apr 2025 17:42:21 +0000
Message-ID: <4B388336-B1B5-451C-8DCD-E47888F6EB08@nutanix.com>
References: <20250317022325.52791-1-harshit@nutanix.com>
 <Z_OW9a_U4WQFWEBH@jlelli-thinkpadt14gen4.remote.csb>
In-Reply-To: <Z_OW9a_U4WQFWEBH@jlelli-thinkpadt14gen4.remote.csb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR02MB8861:EE_|DM6PR02MB6528:EE_
x-ms-office365-filtering-correlation-id: a3895881-d2b3-4063-7a03-08dd76c4b710
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XUtaysx06rAj1/1x7HztRBEBCYfvEVBdnwXvohk1YYxuRrebU5XMr9UX4ltN?=
 =?us-ascii?Q?4fIHpdSkbvKzQuhkmiUg4wuDQ4ytgzB/vTYIQWR6yCKunuejrVguEG1mJnWg?=
 =?us-ascii?Q?iyeoumswtIn1W0zt8Up3Bvn2vlZ8ItNCpr4LLhrBzazO/KSCdqS6iEKMPuAo?=
 =?us-ascii?Q?Z6aSL+We5bKaYmADeIt8og8J2fh7KUZiFHsE7xVUFlR0RkbN6vskQxb3eGZT?=
 =?us-ascii?Q?0YUvyYef9NYYIZS2SvEquc0aTr3gnwR5xgH8vYTT++wcYatXZ8nhVb6vVwly?=
 =?us-ascii?Q?rSBsS8e/xtPqgfJJLWQaSkrlV0Jfm/qqgwOz4dQLCIOfsnPMob23iJHqV6F/?=
 =?us-ascii?Q?m+kejXYCcB6V+4bRzZ6qs4+IscmQq+XGUgRAmd7kqb64TGdpyzpm98s8Hajk?=
 =?us-ascii?Q?mIlIfDdotDcmRqlBJVSEnbbJe8GcY8KBwlGhM39v3pHFFP9lCr2/Yajuq15z?=
 =?us-ascii?Q?wS8ZatHsqXDm7TN3axJJcguOaQcpUUus8coY23E0wqxBI25Mk1BB7V4JQxHy?=
 =?us-ascii?Q?vzRAaTTcNB048BYPU0Xb7BLkfla2Ugd/I1I9i/10aS43Hz9DFALYXzRN1W4+?=
 =?us-ascii?Q?dkhIGQq0fSjfXVOtbBZVncz2QAQ6rH+lFVGSkaKdrByjoS23kpn+RyMAvGHS?=
 =?us-ascii?Q?n0sC0yCDa/bb6ZiLsKUUK/sU1t2viJlxAovdTnufcqNWMcg+Enxbca9NnOMQ?=
 =?us-ascii?Q?gRYvG7WqpHtQ6aa+vNclNROW6wT3WLdzzSu9fsor3WM7uFHl/3Fq/9DSiRvk?=
 =?us-ascii?Q?AHlz+eWN4INZUGdXv7rfANSLRZ8K0ovwolzx2DPQoaxlNWVRKclHVAhlwPWC?=
 =?us-ascii?Q?CWNfq64uKE0Il13SsYNXvnUpaNjxqe7/dAvxMa/OK3YrDS5g8B+XV8WzIJhj?=
 =?us-ascii?Q?lZM+MNbfQAPXG5gokyiiSpnjTFuuBYCMHcOXwD46fQdWCkDgZq/wwAtZ7ISO?=
 =?us-ascii?Q?+fJfmWNL9DNWwnf78Fb7zlcbQv7gka3J1Yn65LRyZn9XfAK2meUHwXrYsnG8?=
 =?us-ascii?Q?w8WyU3bGcpliHq4EfXFjKOJAhfB3N2KEtS2pYC5fF1nCCK0eIzJmxTurA4eq?=
 =?us-ascii?Q?TTcaEQVkhe+DWs5ztCCRRZXR9t3n7t+pupJ1kSkwNkIyQNTgzXNn9UyGG7Pg?=
 =?us-ascii?Q?w8WvFfq0r48iCHcCzEoMkrxxt8G270jSiWURckwb9in9CgEKPEcY46aMjLWJ?=
 =?us-ascii?Q?cuIDU3ynyP6y4nvl2DPxVXNZMg83Osy0wlhPBWGljcADazxm2Un8qvSR2D27?=
 =?us-ascii?Q?3K3swzkboG3vu32hfPZ9YrlgbgLCf09DGu92G4VxGlqFjW+URu6IpfBfokC4?=
 =?us-ascii?Q?URBB17ABNsSGc6Z+Oi/SZHtwmy4SnK4XdxhL3vsns1m7vpj5PdB70z77QQxQ?=
 =?us-ascii?Q?RYX9TNUBGQuF9AOktasODuJpjLUQ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8861.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4FPyPniRjBs5muxP0MWvfrChuVxUuRkrwWoHWY+Mr3q9KkDtgIwugotsPqpD?=
 =?us-ascii?Q?LQtStbcTtCzLQYz6Ptb51sUANUZASUOGU/EKG5WK2lAQf7C5FcF1bbQyR8V6?=
 =?us-ascii?Q?WhV9bAPAsWKHmyBnoqPQzGmaU0QhT8ZBFpa4XSRh0ZuP2ZwYKnTcpe/9yPYz?=
 =?us-ascii?Q?bTVnpV+6QgX38KuLzb7fZ3PjG2P81uDaO0dmMH4Caap02TZbds5g207oRpRX?=
 =?us-ascii?Q?z0C4Xzjc7d1fidLhh+yXiIfVf9eM1WH27au92bd6KwQVUTC3b6IsunLTBMK2?=
 =?us-ascii?Q?cd8nsJF+UWhapwzYkVrT7FvbfBNLHzRSZZS5PYsY4vzV5KYB6Saf68i7gfdh?=
 =?us-ascii?Q?0VvS5JcAcBod7qGcssf222CdOM1MNky4QmSyjgf27yfGR7YmHNjO8eM6Yg3R?=
 =?us-ascii?Q?SgHa9Fki5zWsvUOInFtRWNhX0gMbgiaxEAn9xG7vzxjZWObKpB1DLtxVBmhh?=
 =?us-ascii?Q?m9+LFSj+w+x8S1G88apAow/YeQ9EI2Rmns4UQixUFm8fhVvYvGJ03v+IVd2T?=
 =?us-ascii?Q?Bt4Z5l1Wwe6A0t2X1zygRiICEMLStbzNLwqu+MCfSry5gbEnDIDx/uiCVeXQ?=
 =?us-ascii?Q?sNFJSwdQ21W14nyPrHAxcQ+oQWIpFzU9tmEzD+8Q77br3haNBurd6bqxVfjY?=
 =?us-ascii?Q?c11oA4C4BpW5YCrtMY1Wz5Iz4YVuHlTmDq6N2EeEoW3ohFMtwYpKuLoGPc/o?=
 =?us-ascii?Q?KCMYO4oS7/0Yn3jPetF35CvkviE5eTlAoT1qDRdAoouahzeY+sNcdSaBeC91?=
 =?us-ascii?Q?K2rmzUIvR3LJpaRTBNzvsBnQUztBMNKCvQ65ZWLBHSNbZBhcjbyqho1qtHZh?=
 =?us-ascii?Q?v+zszXm7yy3Mx4f6iy+JShdEllXgIxPZrN9AydGBuz4Ci29Dodh1ty7AXpFt?=
 =?us-ascii?Q?25Yz0U7v3R98wF/eVtVw8r6ymRY6x8N7WyWQ6vfcagjKlDMz7aPNIFtZXlZE?=
 =?us-ascii?Q?GplS0rJh288ht/28zbspJLGHgiHJ4n28QgF7d0wB7J0Xq82o3ji/YIzX3uSu?=
 =?us-ascii?Q?Jy8X9oMQp64Czouw3GTv21UKo9pMP0FGhAIOuWy3HVT9wZbn/Vby8lqWR1Lv?=
 =?us-ascii?Q?gOlKH9qB5MGJN4nb6C/biBbtpd3iOPdBGWsqj4B6Cq1hXKGpuhXq0Ke8aP56?=
 =?us-ascii?Q?/3qlI78w+cMic9pGHF2BO0fBwKbDlKhzLp7Rk8gXxnSMHqJxWWbFq9Hf+YU9?=
 =?us-ascii?Q?FseUA2/JQ0cTB2Azto3GVQiZ1FUHL6N1IUx/CqFhU0bBj6EWQxVViFO4PTqS?=
 =?us-ascii?Q?zvPCe2Pew5ZeSPlGYElJ8DL6FQe6jdo333VLAw4atJNJs0ej+N88K9Qrse38?=
 =?us-ascii?Q?xFLEBIwtnzfkVIfL1jSyE2h7kno8erFsCZKY3Yk3FJv+yU+YK1Twi10SHPtK?=
 =?us-ascii?Q?W+SMQUIQ7MfNL5J5n292o6CJ8R6wzBxQyuNkdF496aP3oawnHsHdQaAS5qfO?=
 =?us-ascii?Q?gPdOS+4n7aXDNBz+30ik23EwL09e/XtIOEokac4NhEb5V1znFQK25q27TdOR?=
 =?us-ascii?Q?myv1wnuKbiTS9Ny9XfnJ4RGRQMyIuobS1FHGelYvLrjiQIS+IBRNJ1nUXqTE?=
 =?us-ascii?Q?Xpq7h6f8ytqyCem5FNlt3C0jz5JQcvAlzpwlBDZQ7Y3qoZh9S9HffHrquADc?=
 =?us-ascii?Q?DA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <136A5E49EC08E74FA1460CE90272C8D6@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8861.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3895881-d2b3-4063-7a03-08dd76c4b710
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 17:42:21.2816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u4cUcC1AG4odU/JXcKV2PtSVRLvbdWTSy97OZ4jj+dDV3mXlX0oRB+Aet1fF4rgb0s1u2xp5nPJ9YHtFh2f+HJnDDCxBO+bdMCE1Q9IdSxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6528
X-Proofpoint-ORIG-GUID: Y7YkCkiAR352NHh_4zRJeKerpREYhLlt
X-Authority-Analysis: v=2.4 cv=d+b1yQjE c=1 sm=1 tr=0 ts=67f55fff cx=c_pps a=OGaRt8TyNAR4X2Yz4FfAAw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=XR8D0OoHHMoA:10 a=0kUYKlekyDsA:10 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=tY9d2uFw-Hfoyc3WpRsA:9 a=CjuIK1q_8ugA:10 a=LJG2vKpDTwoA:10
X-Proofpoint-GUID: Y7YkCkiAR352NHh_4zRJeKerpREYhLlt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_07,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Reason: safe

Thanks Juri. Addressed the comments in the v3 here:=20
https://lore.kernel.org/lkml/20250408045021.3283624-1-harshit@nutanix.com/T=
/#u

Please take a look.

Regards,
Harshit=

