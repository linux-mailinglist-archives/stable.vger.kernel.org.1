Return-Path: <stable+bounces-231424-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gInYDsvNy2luLwYAu9opvQ
	(envelope-from <stable+bounces-231424-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 15:36:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4FD36A570
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 15:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B70BB30B6FA0
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 13:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580A3342CA9;
	Tue, 31 Mar 2026 13:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="jz3/T140"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C943B3290D1;
	Tue, 31 Mar 2026 13:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774963872; cv=fail; b=X4nAdKsjrRBsXw2osKZnak81uK7v5zetgJ4PN/PWP7gB014sXx2MyhS1JcQmAmGXJ6S+kaAAipeew0YpcBO6eJ/A7ix9CgYlBqvhEgeMyHpz2aQg48joGwhvumLNiABASmjbQiz0v7WYsdNU3pS9n5oTz9y+9XpRPwQd9SDNbEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774963872; c=relaxed/simple;
	bh=r8UEMtSCKJ7aQzVHDs047v9kFdah+KaXRW82j1jehy4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rEu4cRUEc4lCmfPbGV2651s7o+yvVmRGxQD0ea+uvSdFI1jyoW6R3+9OaHj2/pqfc003cS9tuxS8Scl9+FbiFTSamSbpV5Yj7K3GPFsyoIf21Ctd3Wu+xldKguZqe5trTyol1wwp1wmjx5EYSwKIFnfQCmYL834NLt/yJthMlv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=jz3/T140; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VAWY7G3053595;
	Tue, 31 Mar 2026 06:29:59 -0700
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11021139.outbound.protection.outlook.com [40.107.208.139])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4d6yr757uc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 06:29:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cuy+VQwAX1EORCsc1J7SRfQD0yFnTTuuNJNmnlTHgAH2JDK+SDevfxnmqw0/QxPgvSXHhjyjfkBZ38ZgIpFeziWqgVGOhi+CxQK7r/x9p1g9nphwgdjDUEuu44qVdepdsWFJabjyUyQeyC21Z06/pLiOj5No56CX7VDsjFArpKUJcl0fidztCxcYUgcmR05HkHrDA9s6lRjWOHneXvW68YrMX6++qZVBf1W0FI8SrGfeQSqkz6JcgnND5CJkT/SHGuyGFxGeEHvvMyWbeXQClPRg32RsJ4Cb5e0Zrkj4vMog5XdfqLSjWm7d2OH2u3nrmjEt7NuTCLHkQysGFQFYLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8UEMtSCKJ7aQzVHDs047v9kFdah+KaXRW82j1jehy4=;
 b=TI7nV6G4Swae6yY+LVBjcC1mrSwOUa5ny69bm3G8pb50/qnkVQuxrKuGGVGJpMDwMbcs9gIbevWXwLtKAi9fvhLesBXOL7R8lW6BZtg5WwPaZA1xCPOz9H3KnRff/cqsFhxQ5LetyaJaFtr1tQytiRPQkiTR2RmRc/l3s+THx0TI8I2/KO70BCkhWjV7kLIhcIYzV9FnQszCMaEpP9j22SiPXrgTvNoToJnaL56Af8PbUuCCt7CjqZFXZJ0muGG8e7Xxlu5S1ZgGKrjAbBTlbCkx/88I3LpLAmyrlRz6kCgppVXTvNSYTF5ZgLrn2cfjC+r74Oq1egtrzio6d1RPYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8UEMtSCKJ7aQzVHDs047v9kFdah+KaXRW82j1jehy4=;
 b=jz3/T140ohBUS6ZqMDoSXWHPtViVHD0QWNgJWLh4cw5CnRqnkVn0l1v7SR7daZU9KjXocY4BNgfMFTN7xtPwdtsV1DA+e7ntwcjvW50FkemhlkkpJhAHApT8ZwBlUym1jSE/f9ke9a5LFKpdg3x8QIIJJWFP8mTLwv6jfMJO+Jo=
Received: from CH3PR18MB6379.namprd18.prod.outlook.com (2603:10b6:610:205::13)
 by MN6PR18MB5413.namprd18.prod.outlook.com (2603:10b6:208:46e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 13:29:56 +0000
Received: from CH3PR18MB6379.namprd18.prod.outlook.com
 ([fe80::e9d6:f43f:cd52:d685]) by CH3PR18MB6379.namprd18.prod.outlook.com
 ([fe80::e9d6:f43f:cd52:d685%4]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 13:29:55 +0000
From: Srujana Challa <schalla@marvell.com>
To: Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>
CC: "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com"
	<jasowang@redhat.com>,
        "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Nithin Kumar
 Dabilpuram <ndabilpuram@marvell.com>,
        Shiva Shankar Kommula
	<kshankar@marvell.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net,v5] virtio_net: clamp rss_max_key_size
 to NETDEV_RSS_KEY_LEN
Thread-Topic: [EXTERNAL] Re: [PATCH net,v5] virtio_net: clamp rss_max_key_size
 to NETDEV_RSS_KEY_LEN
Thread-Index: AQHcvSwvPvrXwmmO70aAh2mvh1Y2fbXIZP2AgAA/INA=
Date: Tue, 31 Mar 2026 13:29:55 +0000
Message-ID:
 <CH3PR18MB6379D39BA068565667CF2B06A053A@CH3PR18MB6379.namprd18.prod.outlook.com>
References: <20260326142344.1171317-1-schalla@marvell.com>
 <ba027306-e5e0-4d4d-8357-f6080441167d@redhat.com>
In-Reply-To: <ba027306-e5e0-4d4d-8357-f6080441167d@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR18MB6379:EE_|MN6PR18MB5413:EE_
x-ms-office365-filtering-correlation-id: f43eab0a-dc36-4a35-c448-08de8f29991b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 P9K95eQ/MUXU2K+85S9Dfa61VCU5Yhs9C0zwz2dV3kcZ4+cfebxkUKX/xoHPH/f0K7EL7eo1X8gBzAxySkjNwuiqlnbXhxotRNqu6qxIqgour796/qGLZjFaaeB6NuymgyBKvMhx6K6OmG0KrIOMAOgbBGEVGmzDjvDnjEEHKqiC13qX3qQnqry/jGz9/INYKZHkS4tVBg8EKw00qP1NfE6lD4L283v0y3DlcCNrAFl1znkqGB9W3Vke7hFAO4X3Yimq0B3dB0Rsvt1q7abCUbKjvFhqcNPQFAJ+299wLXeLcM9WTxNdIntWld0O18nSF8C8fiqconUHlFSqIxYT/hsiLVi6na/am4nGFwPaxknBLD84Oagcx29vKH8zLUds9X35KLHtHFtZOw1xG2gTtpsvyxwO8ieWj7vgWFeT0kKXr9CBWLcqsuR1AjbQDWkFVBmrCx5JW84o0TkbEhEliFzKaSFFXs9YLg6XdGEoqoLfn8ReS+IuzpYtI/AttCXcLnp+axp3h0soOFcQs5GNHBmrXyTl6uH02zRLuT2SWDfZjr1HDx2NUO30lSVHZFkDwKR8kfFcJZi/dR4/zvT3TDUstHI1m6VQuzcBA0kOd99f1I5sCfq0txWSr0rxNIs9NeOi8HBjhr+w+yIADOOR0yGeYpAQmz0L4RGbAlBvuJT3Dr4KvgLHcoHNDwxwa5KNo33mlW+SxPaARAWnJRRgGR+TFtw4ATyDLsEO1ipUnztjAhjU+X9tfxpaSSHSe1TvFau56BUhNj84aGjSXOQmMw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR18MB6379.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aGJ3d1RFM0psZGIzRC9Ea29qZENLcWVvd0N1TDVrZDhud3JVSzgwSk1jNGox?=
 =?utf-8?B?WjYxTEc4MGVEajFvTUQveElWWDk4RzJRTDV5UkpRdmNwK1NtWGRqSXRVTWtS?=
 =?utf-8?B?M1FLL0Zpb1JuR3ZIblRqbWRxajFITkpwb2pxMWpoUzFid2NHTnF1MkttSEJu?=
 =?utf-8?B?em1uM3VxQ1FyMnFkWTFsbWNBTnRjOXREZE1vNXFIZ3N0LzgwU0RITmJzKzBW?=
 =?utf-8?B?dno0aGlNUFBQU2h4ZDA1dVMyRTJUTkJPVWxEVWgvL1ptb1dmQ0ZJbUF2ZFlQ?=
 =?utf-8?B?NDFnOTRuS1B5eHhnUncraFRwZjVxbGRsSHVUUEl6cTQzQzMyNWxQUk92c3BV?=
 =?utf-8?B?WFJ3VlN4NER3aW1LZnd4M2gzaG1VUGVXOElIbU92VHU1MGdmVElFL1c3T2cy?=
 =?utf-8?B?TDlDNHdtbHJnWjdKYkNlL2c3QWNBM1R2TEpSclFzb0c1NG5IVGVYQjhtSmJk?=
 =?utf-8?B?ak0vRVJDSDAxREhJRm1vWjg3WndBa0xwemF1N2VtbTdoREJ0VWNPOVRNOG9z?=
 =?utf-8?B?QlZxRHVFK2dPRzBOM2lueW9iNVlqM09lTWtsaU1sU1poTnp6TVh0dnpXbUJW?=
 =?utf-8?B?aG8yYjFweFlnbjlBTVFmRm1OVkdoRmR3TnlCSGNLWWMvUU9USFdZalpRK0Q2?=
 =?utf-8?B?QTlQVDV0bnlXZFRlV2k0QzhCZnZyREY3NlJKUlBTdUFscGpDUVpoR2ZJVjZk?=
 =?utf-8?B?Rk1rWHJBRHMvQTdKcDZwTEhIcWtYMTNpMURSUjMxWmZjQkFCZFRqV1RRMUJB?=
 =?utf-8?B?aGRac0J1cUpvZC9UaTczWHU5Q2JBMW9pVWh3Y2RYOWxoRWhGSHFYTk42cDAx?=
 =?utf-8?B?UmhIamJzL3Z6Ym1mSm85UE01L0ZWMFBEc01Rc1l1U0IzRUxZOU5tK25zdmF3?=
 =?utf-8?B?M280Q01mNlhWM3huY1lhUXl5R0ZOTmFRa2Z0UTdXaG56S0Y0dFJ6U2E2VVFl?=
 =?utf-8?B?dS9iQ3RYOUZjZzhtdG96U2YxWk8yaHFyc0UyMHM3N1o3R0kxQjRUQ3A0WStW?=
 =?utf-8?B?blRESGxEOFg3SUpuamh2K1dReklWK0pEckN3aVMwa3FldGw3MURPU0l6RVEw?=
 =?utf-8?B?VklYNHpERTJXcEVrZUJUWHhrMHZwampDdkUyK1JwTjhXUnY3cE9CdHJSYkV3?=
 =?utf-8?B?bWgwR3Z2WGhiT0dmWG9ubWxKZGMwVytqcEo5bXhqdnNJc3JqcTdCa0V6TitL?=
 =?utf-8?B?cnZERnp2eTZBNk1ORzlvanlZNWxWdFQyWUNhdXowZ1NxdlVLYXBRSXhGSllR?=
 =?utf-8?B?bkNIWVYra0tMV0piQzlZa1hNWFozK0R6eTYxTmk5YlJCcXdzMHNNbnNmbXFR?=
 =?utf-8?B?WkQrcVVxcFYwK25DYnpIeWp6c2FQZEplZG16Nzl6NVR0RGdLZjlVTFRFdHZa?=
 =?utf-8?B?VUVpYnRBajJsV0l2N1BmNmROakZwZWNBSy8wVTgwV2lTZ2ZpV3g5QTdRR2o1?=
 =?utf-8?B?U0cyaUMvUHZGcjZBRW5tMk1VTjViVGVPQSsvVXp3VHZLYWovVStEeVk0SHB6?=
 =?utf-8?B?MUptaGZQWXZoSGJjQm5yejhMT0cxc2E3OFJGcGhJOHMrVTZJdUt6MmM1Wlc2?=
 =?utf-8?B?R1Y4aGh5RlBjU0d5UUxzQlFWOTk3TE5DeTRUU2NuazBzT2daZVVMdjNZQWcw?=
 =?utf-8?B?aWw5NHl4NW44UEZlZnVFbkloazR6cVhDZVhkcWFzSHdCcm9UUFprMmJXd0p6?=
 =?utf-8?B?WFR3YjR1ZkZBWDlMK29jQi9KaTkzMExkZk51ZDVoOXkzK2xRTTlpd014WmhP?=
 =?utf-8?B?YXN6UVNLZnhheXlkVWJhcHQyRnUzSm9rL0FMekhBQzA5dUdxeng3VTRLdTVU?=
 =?utf-8?B?QU03R2R1b09iN1cxd1RIMG9OQjRQVnFtUlhtS2dsMVV5cUVHcjNOMWtkbkkw?=
 =?utf-8?B?RlNSSVNaM3lpekRyZ1Nra1Eydkh4dk9WK0pDejlCaGhwcTdwWEcwOFRxMUdt?=
 =?utf-8?B?L3oxU0IzRmhJWWhYS2VKZU1KY1BHWXpLaktrNzdlN0NFTEdGYjFidFpGcG15?=
 =?utf-8?B?RTA5dEZ5U29RcmVkQzA4N3ZCby9MbWFpdEN2MU1saWdTYXFybm1qYTREckpG?=
 =?utf-8?B?U053cjFTUzRtdEtDZnJIdzVNaWgzbEVPb3BnUDZnVE9HUVNZWXcxWm5neUtE?=
 =?utf-8?B?NWY3Q1ppYys2VHVKWDFabmw2UExjTEthakpCcUFJVmZXMmRWUVVyeTdHc0d4?=
 =?utf-8?B?aCtGYnJLU1FnNjFISFp0S1RhTmpCbXpWTU1wRHZRTXpkYUo1YjZTV3lXZGZP?=
 =?utf-8?B?K21MVEYwTHorcE5ocEg2QXFOZlVTN1dqRDRaeFB5NkZRL1FxK05XaTdnMlk2?=
 =?utf-8?Q?AG/cx55nO3ftK6NrM6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	L52BLQg3zhiaxHTq84JsMjC/hG1EWfts4UWzvV/SFYSKZcdDN6322tjOG8LC386vFqw3buRy3patsq9eZD0aDKODoXEDSSaA1nI16Oh4JgHjsE14Q+Gi55NVXCDyY45dUtp4liGpN5Ga3Mxj5fLlcgAXziuGmQUtADp5E8mnRY+Gz34EdY1yUe0pyqCBXs6VBPN5lGqLIsBeL3q6lXVDGy4uEppAe1xKvHXSVR8cns54FPVhqKTmkpYO+wRVELxbUfivF4meXXjlbNW/83+q5bgK2uNPJkxxwxq++yk3IYh8r+zSd2ZG6H7K4YWC1NbgzkbX1ptIMukF9/WyMNoAag==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR18MB6379.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f43eab0a-dc36-4a35-c448-08de8f29991b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 13:29:55.8206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qSQ6ejHBcQ0++NFltwo/1yggbk65Vg/HYkKZSOINcn6+wKoiuwyfuX2QQzOvSgvRWGC6bxc9RFSPcdKskn2UFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR18MB5413
X-Proofpoint-GUID: SpjUZHbOHUnJdwezqufQMTof2xpkQAvq
X-Proofpoint-ORIG-GUID: SpjUZHbOHUnJdwezqufQMTof2xpkQAvq
X-Authority-Analysis: v=2.4 cv=a949NESF c=1 sm=1 tr=0 ts=69cbcc56 cx=c_pps
 a=JZ4ed/MQfvNyfgwl2FRQLg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8
 a=M5GUcnROAAAA:8 a=eJNq96l53ukULR9NwhoA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDEyOCBTYWx0ZWRfX1UxirRC4cN1l
 8Qyo4mYwEz5vM3Yd9gPBUaX3q4qfAtKg4serHLkt0RHTn4L5iUkYmrr4wtdPeQew0IJh+k7hKqk
 BkSKbf5M0BRiprVjNemmKKXhJITNPrRmHS/b0UeECEu8aUkdyAyQESbkQlmxGM9wNoQOmHxCWgt
 gdJzSPT6rfl+dBUIdOw/nsuL69ncvKQk5DOLqM/1jzY2WT74umVFHoCbi+l70G1M70cjOs3gASY
 5Y4c8Qngx3h+EkgZ2oBDGI7aqIaLIeaCMmfftropIJ6hMsYBwn7hD4JuraC5aBR98rKLz0JQpI6
 BYEPbb17PGBNNg5anZ41jC3QZW8HoAwWsrChCNCOjHacLa7A2TarL2qC7B54mWXHgu3CyMMoBNU
 cCjRWyAHlJoomP36cwPDzLYqIa4Odc8d2JJPiNzf/t35CPVEt0LNDV74HuR6Ktseg/0f9wLmdkx
 QQbxDpmk27Ov0sx7MuQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_01,2025-10-01_01
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231424-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,CH3PR18MB6379.namprd18.prod.outlook.com:mid,marvell.com:dkim,marvell.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schalla@marvell.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BC4FD36A570
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiBPbiAzLzI2LzI2IDM6MjMgUE0sIFNydWphbmEgQ2hhbGxhIHdyb3RlOg0KPiA+IHJzc19tYXhf
a2V5X3NpemUgaW4gdGhlIHZpcnRpbyBzcGVjIGlzIHRoZSBtYXhpbXVtIGtleSBzaXplIHN1cHBv
cnRlZA0KPiA+IGJ5IHRoZSBkZXZpY2UsIG5vdCBhIG1hbmRhdG9yeSBzaXplIHRoZSBkcml2ZXIg
bXVzdCB1c2UuIEFsc28gdGhlDQo+ID4gdmFsdWUgNDAgaXMgYSBzcGVjIG1pbmltdW0sIG5vdCBh
IHNwZWMgbWF4aW11bS4NCj4gPg0KPiA+IFRoZSBjdXJyZW50IGNvZGUgcmVqZWN0cyBSU1MgYW5k
IGNhbiBmYWlsIHByb2JlIHdoZW4gdGhlIGRldmljZQ0KPiA+IHJlcG9ydHMgYSBsYXJnZXIgcnNz
X21heF9rZXlfc2l6ZSB0aGFuIHRoZSBkcml2ZXIgYnVmZmVyIGxpbWl0Lg0KPiA+IEluc3RlYWQs
IGNsYW1wIHRoZSBlZmZlY3RpdmUga2V5IGxlbmd0aCB0byBtaW4oZGV2aWNlDQo+ID4gcnNzX21h
eF9rZXlfc2l6ZSwgTkVUREVWX1JTU19LRVlfTEVOKSBhbmQga2VlcCBSU1MgZW5hYmxlZC4NCj4g
Pg0KPiA+IFRoaXMga2VlcHMgcHJvYmUgd29ya2luZyBvbiBkZXZpY2VzIHRoYXQgYWR2ZXJ0aXNl
IGxhcmdlciBtYXhpbXVtIGtleQ0KPiA+IHNpemVzIHdoaWxlIHJlc3BlY3RpbmcgdGhlIG5ldGRl
diBSU1Mga2V5IGJ1ZmZlciBzaXplIGxpbWl0Lg0KPiA+DQo+ID4gRml4ZXM6IDNmN2Q5YzE5NjRm
YyAoInZpcnRpb19uZXQ6IEFkZCBoYXNoX2tleV9sZW5ndGggY2hlY2siKQ0KPiA+IENjOiBzdGFi
bGVAdmdlci5rZXJuZWwub3JnDQo+ID4gU2lnbmVkLW9mZi1ieTogU3J1amFuYSBDaGFsbGEgPHNj
aGFsbGFAbWFydmVsbC5jb20+DQo+ID4gLS0tDQo+ID4gdjM6DQo+ID4gLSBNb3ZlZCBSU1Mga2V5
IHZhbGlkYXRpb24gY2hlY2tzIHRvIHZpcnRuZXRfdmFsaWRhdGUuDQo+ID4gLSBBZGQgZml4ZXM6
IHRhZyBhbmQgQ0MgLXN0YWJsZQ0KPiA+IHY0Og0KPiA+IC0gVXNlIE5FVERFVl9SU1NfS0VZX0xF
TiBpbnN0ZWFkIG9mIHR5cGVfbWF4IGZvciB0aGUgbWF4aW11bSByc3Mga2V5DQo+IHNpemUuDQo+
ID4gdjU6DQo+ID4gLSBJbnRlcnByZXQgcnNzX21heF9rZXlfc2l6ZSBhcyBhIG1heGltdW0gYW5k
IGNsYW1wIGl0IHRvDQo+IE5FVERFVl9SU1NfS0VZX0xFTi4NCj4gPiAtIERvIG5vdCBkaXNhYmxl
IFJTUy9IQVNIX1JFUE9SVCB3aGVuIGRldmljZSByc3NfbWF4X2tleV9zaXplIGV4Y2VlZHMNCj4g
TkVUREVWX1JTU19LRVlfTEVOLg0KPiA+IC0gRHJvcCB0aGUgc2VwYXJhdGUgcGF0Y2ggdGhhdCBy
ZXBsYWNlZCB0aGUgcnVudGltZSBjaGVjayB3aXRoDQo+IEJVSUxEX0JVR19PTi4NCj4gPg0KPiA+
ICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCAyMCArKysrKysrKystLS0tLS0tLS0tLQ0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMgaW5kZXgNCj4gPiAwMjJmNjA3Mjg3MjEuLmIyNDFjOGRiYjRlMSAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMNCj4gPiArKysgYi9kcml2ZXJzL25l
dC92aXJ0aW9fbmV0LmMNCj4gPiBAQCAtMzczLDggKzM3Myw2IEBAIHN0cnVjdCByZWNlaXZlX3F1
ZXVlIHsNCj4gPiAgCXN0cnVjdCB4ZHBfYnVmZiAqKnhza19idWZmczsNCj4gPiAgfTsNCj4gPg0K
PiA+IC0jZGVmaW5lIFZJUlRJT19ORVRfUlNTX01BWF9LRVlfU0laRSAgICAgNDANCj4gPiAtDQo+
ID4gIC8qIENvbnRyb2wgVlEgYnVmZmVyczogcHJvdGVjdGVkIGJ5IHRoZSBydG5sIGxvY2sgKi8g
IHN0cnVjdA0KPiA+IGNvbnRyb2xfYnVmIHsNCj4gPiAgCXN0cnVjdCB2aXJ0aW9fbmV0X2N0cmxf
aGRyIGhkcjsNCj4gPiBAQCAtNDc4LDcgKzQ3Niw3IEBAIHN0cnVjdCB2aXJ0bmV0X2luZm8gew0K
PiA+DQo+ID4gIAkvKiBNdXN0IGJlIGxhc3QgYXMgaXQgZW5kcyBpbiBhIGZsZXhpYmxlLWFycmF5
IG1lbWJlci4gKi8NCj4gPiAgCVRSQUlMSU5HX09WRVJMQVAoc3RydWN0IHZpcnRpb19uZXRfcnNz
X2NvbmZpZ190cmFpbGVyLCByc3NfdHJhaWxlciwNCj4gaGFzaF9rZXlfZGF0YSwNCj4gPiAtCQl1
OCByc3NfaGFzaF9rZXlfZGF0YVtWSVJUSU9fTkVUX1JTU19NQVhfS0VZX1NJWkVdOw0KPiA+ICsJ
CXU4IHJzc19oYXNoX2tleV9kYXRhW05FVERFVl9SU1NfS0VZX0xFTl07DQo+ID4gIAkpOw0KPiA+
ICB9Ow0KPiA+ICBzdGF0aWNfYXNzZXJ0KG9mZnNldG9mKHN0cnVjdCB2aXJ0bmV0X2luZm8sDQo+
ID4gcnNzX3RyYWlsZXIuaGFzaF9rZXlfZGF0YSkgPT0gQEAgLTY3MTcsNiArNjcxNSw3IEBAIHN0
YXRpYyBpbnQNCj4gdmlydG5ldF9wcm9iZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikNCj4g
PiAgCXN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpOw0KPiA+ICAJdTE2IG1heF9xdWV1ZV9wYWlyczsN
Cj4gPiAgCWludCBtdHUgPSAwOw0KPiA+ICsJdTE2IGtleV9zejsNCj4gPg0KPiA+ICAJLyogRmlu
ZCBpZiBob3N0IHN1cHBvcnRzIG11bHRpcXVldWUvcnNzIHZpcnRpb19uZXQgZGV2aWNlICovDQo+
ID4gIAltYXhfcXVldWVfcGFpcnMgPSAxOw0KPiA+IEBAIC02ODUxLDE0ICs2ODUwLDEzIEBAIHN0
YXRpYyBpbnQgdmlydG5ldF9wcm9iZShzdHJ1Y3QgdmlydGlvX2RldmljZQ0KPiAqdmRldikNCj4g
PiAgCX0NCj4gPg0KPiA+ICAJaWYgKHZpLT5oYXNfcnNzIHx8IHZpLT5oYXNfcnNzX2hhc2hfcmVw
b3J0KSB7DQo+ID4gLQkJdmktPnJzc19rZXlfc2l6ZSA9DQo+ID4gLQkJCXZpcnRpb19jcmVhZDgo
dmRldiwgb2Zmc2V0b2Yoc3RydWN0IHZpcnRpb19uZXRfY29uZmlnLA0KPiByc3NfbWF4X2tleV9z
aXplKSk7DQo+ID4gLQkJaWYgKHZpLT5yc3Nfa2V5X3NpemUgPiBWSVJUSU9fTkVUX1JTU19NQVhf
S0VZX1NJWkUpIHsNCj4gPiAtCQkJZGV2X2VycigmdmRldi0+ZGV2LCAicnNzX21heF9rZXlfc2l6
ZT0ldSBleGNlZWRzDQo+IHRoZSBsaW1pdCAldS5cbiIsDQo+ID4gLQkJCQl2aS0+cnNzX2tleV9z
aXplLA0KPiBWSVJUSU9fTkVUX1JTU19NQVhfS0VZX1NJWkUpOw0KPiA+IC0JCQllcnIgPSAtRUlO
VkFMOw0KPiA+IC0JCQlnb3RvIGZyZWU7DQo+ID4gLQkJfQ0KPiA+ICsJCWtleV9zeiA9IHZpcnRp
b19jcmVhZDgodmRldiwgb2Zmc2V0b2Yoc3RydWN0IHZpcnRpb19uZXRfY29uZmlnLA0KPiA+ICty
c3NfbWF4X2tleV9zaXplKSk7DQo+ID4gKw0KPiA+ICsJCXZpLT5yc3Nfa2V5X3NpemUgPSBtaW5f
dCh1MTYsIGtleV9zeiwgTkVUREVWX1JTU19LRVlfTEVOKTsNCj4gPiArCQlpZiAoa2V5X3N6ID4g
dmktPnJzc19rZXlfc2l6ZSkNCj4gPiArCQkJZGV2X3dhcm4oJnZkZXYtPmRldiwNCj4gPiArCQkJ
CSAicnNzX21heF9rZXlfc2l6ZT0ldSBleGNlZWRzIGRyaXZlciBsaW1pdA0KPiAldSwgY2xhbXBp
bmdcbiIsDQo+ID4gKwkJCQkga2V5X3N6LCB2aS0+cnNzX2tleV9zaXplKTsNCj4gDQo+IE5FVERF
Vl9SU1NfS0VZX0xFTiBpcyAyNTYgYW5kIHZpcnRpb19jcmVhZDgoKSByZXR1cm5zIGEgdTguIFRo
ZSBjaGVjayBpcw0KPiBub3QgbmVlZGVkLCBhbmQgdGhlIHdhcm5pbmcgd2lsbCBuZXZlciBiZSBw
cmludGVkLiBJIHRoaW5rIHRoYXQgdGhlDQo+IEJVSUxEX0JVR19PTigpIHlvdSB1c2VkIGluIHY0
IHdvdWxkIGJlIGJldHRlciB0aGFuIHRoZSBhYm92ZSBjaHVuay4NCj4gDQpUaGFuayB5b3UgZm9y
IHRoZSBmZWVkYmFjay4gSW4gbmV0LW5leHQsIE5FVERFVl9SU1NfS0VZX0xFTiBpcyAyNTYuIFRo
aXMgZml4IGlzDQphbHNvIGludGVuZGVkIGZvciBzdGFibGUga2VybmVscywgd2hlcmUgTkVUREVW
X1JTU19LRVlfTEVOIGlzIDUyLCBhbmQNCkkgYWRkZWQgdGhlIG1lc3NhZ2UgdG8gbWFrZSBjbGFt
cGluZyB2aXNpYmxlIGluIHRoYXQgY2FzZS4NCkkgd2lsbCByZW1vdmUgdGhlIGNoZWNrIGFuZCBz
ZW5kIHRoZSBuZXh0IHZlcnNpb24uICANCg0KPiAvUA0KDQo=

