Return-Path: <stable+bounces-77834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D95987AD5
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 23:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9332C1C21D2B
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 21:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC84818893A;
	Thu, 26 Sep 2024 21:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GQgbuZah";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gqnuoOqI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="JVRG55DH"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2E64D8C8;
	Thu, 26 Sep 2024 21:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727387546; cv=fail; b=FAF63804vHjEigxolOtYHup1kEE/noMPeoWyJKcAYfxIP9YSX6ohl7my5MWkoT9gIvgdSXJ4Z2ZKQQiTqANBbasZ7B8VWvVzeMQ5tLO0GsFpokBYhmYy+ktgl89vBqx0VlIgPEYi1W+U3cE0xhD/WRqQ5lZWorlzc0LpFIbu/+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727387546; c=relaxed/simple;
	bh=BVSN6O1jC8ultMgeZ3X4qKhc6EKj1A7XntuWjgezM0U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R67zelAv4wEOtdGcLKpTdJb/eueCpINElL0M+XGZOq6Wxm1jjXJXgjCry5wg5j7PxRXjxWRy0NEI0h6CsX9e16rEJoWO31n0Ru2ZPJU2iIztl0X7byye6rw+oIJlMUA80EzNUC4HwVJEt69dE367q+4vlmYYcLpDVhs9cDkylI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=GQgbuZah; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=gqnuoOqI; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=JVRG55DH reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QGeCbe018501;
	Thu, 26 Sep 2024 14:52:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=BVSN6O1jC8ultMgeZ3X4qKhc6EKj1A7XntuWjgezM0U=; b=
	GQgbuZah9CWv1cUZCQF9weTrZjOtn00f74AS8eJUZolTLctWLrSLPBYapnb+5daq
	Xhn2WXb9r5227jSZicx7sf7ikMM5BpNDo9oVQWn9/xp94rb9yE8NdFEEBDG9w3xj
	a4U8iGWkuCRaIK2fLVVicZBM53ptMEr2RZD/TjygnaPbfSeCsk0PojAzzevw7GsS
	837QQOxaP3uFrUgAXSC08jiKINh9Poysjjn6JlU8wuW1Smz1xB1zeM1EPHGpz81b
	pXeUTMEdfif9fyG6mp1Ko/ELiXkr/5lMuhBxK2rRe2Blk9IfEMBgFm5Wm6i9EHRz
	dzwVhnQf7ZxSWGA9xxBcuQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 41sw30k4dx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Sep 2024 14:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1727387523; bh=BVSN6O1jC8ultMgeZ3X4qKhc6EKj1A7XntuWjgezM0U=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=gqnuoOqI9dHSW3sj4TOYG9+VlRDfzZwLX7HkODaX+RpLPrvKakoct+5+QWF60mL9h
	 ZiPlCnT+2C+Tg3nCxaSnzx+kPaQm9st4A82M08mlGN9IFDbEbGs5zLlZ20JRoBScoE
	 V9LNSsVfQT4FEj9PqVjAsD7751a+0P050yQwJnLUfqQrqe4oaQKxhJ792iTQFUd5wF
	 N9CX2DZLaShGNS5PV5TxNcb7MB4lwqrBDUYxec2NuPI0l3Uk7VVKHLyT+3i/nzU2Zy
	 Rztayvw85TSUhmj32Y7y2oXAzC4+ZOcPnU3geVy8R0I4CCCWjPlY2JdcoNHd3V3BlO
	 k1bd/+DKYNR6Q==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5BAB040291;
	Thu, 26 Sep 2024 21:52:02 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 5F1C6A0084;
	Thu, 26 Sep 2024 21:52:02 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=JVRG55DH;
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 27DAD404CF;
	Thu, 26 Sep 2024 21:52:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/bnIWR5sau3SfOxCjEdDZ5b/0Z4e3QMYvSbHfyBtZ6yvCuvbs+/la1BJpZcft/fMM0qVrpXJDsxz6Awf5Opq7/cWAV2jSCtqxodi90NzS4CWjV8L3oEAZiQgXQWvNxTTMzx4rj6ZRDiLZBjMGdUdKtPGIYUTGTtBBSQ48ZJpO58eIYqNcL5JgzMXFv9ztRlPMAelsFe4Q0AURRFaP7BEv/BYfsVn0GtLVOzZWTSJq4SKFC2PKZHOrNGkMviwMN30nTDRfKC5JG4gvao0NiB6yg2d8B/xguV3qBp/e7zmcBfbXaYY4OFSCb2k4NCTvwQlpZbvNAqpmkUj5mMYwiykg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVSN6O1jC8ultMgeZ3X4qKhc6EKj1A7XntuWjgezM0U=;
 b=Pc6A/HmhULUaDUVlxAZrK2ZcuglneYYzRK5nhZd11BZTLg16ZkvzESt5twDGrlxjio8HySCRNCbk8q+5HokQSDHkx5aqWMQP2uw5EWCN4dNFyi+TgxPDTvw20Jt09suWa9X3fkY4TrQqOZY9L3ONpnaT1FsI3OYf1TVTKJHOhJEQ41O7giwl29zGtWatRVj0hZCjvirK71CNCntDSo3wqy94mj8xltUCutJVlT13XYH1NwsXVghLttiVnC7jdPXGC6AhZ4uUDLrVcLkVjAxyFjYftAa9MwSQgLoUS0LiBgeoB04Whmb0933wjYu1hul6M1bRko2ToMpibBSRB/Wj0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVSN6O1jC8ultMgeZ3X4qKhc6EKj1A7XntuWjgezM0U=;
 b=JVRG55DHEnacB77HcGEHVzhIStb01J/tpfDr/1SmbVV0/e1or01/le0uyg7UuJ7MIWenPGnI/d1bPnjIuhPKrP7VZQc0I90SeXPBBtufCSj9d+CfmHxVZWoceTOXbvpbC0+WQkCtrv3US6yiOPNPEBpUdDDy5zCu0ETxhJrTLIU=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MW6PR12MB8733.namprd12.prod.outlook.com (2603:10b6:303:24c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.29; Thu, 26 Sep
 2024 21:51:57 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 21:51:56 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Youn <John.Youn@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "msp@baylibre.com" <msp@baylibre.com>,
        "Vardhan, Vibhore" <vibhore@ti.com>,
        "Govindarajan,  Sriramakrishnan" <srk@ti.com>,
        Dhruva Gole <d-gole@ti.com>, Vishal Mahaveer <vishalm@ti.com>
Subject: Re: [PATCH 2/2] usb: dwc3: core: Prevent phy suspend during init
Thread-Topic: [PATCH 2/2] usb: dwc3: core: Prevent phy suspend during init
Thread-Index: AQHakFeioIjMhcyoIkClbCNPPNRvWLJpHmKAgAJ9eIA=
Date: Thu, 26 Sep 2024 21:51:56 +0000
Message-ID: <20240926215141.6xqngt7my6ffp753@synopsys.com>
References: <cover.1713310411.git.Thinh.Nguyen@synopsys.com>
 <e8f04e642889b4c865aaf06762cde9386e0ff830.1713310411.git.Thinh.Nguyen@synopsys.com>
 <1519dbe7-73b6-4afc-bfe3-23f4f75d772f@kernel.org>
In-Reply-To: <1519dbe7-73b6-4afc-bfe3-23f4f75d772f@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MW6PR12MB8733:EE_
x-ms-office365-filtering-correlation-id: 83aa513e-0a41-4640-a04c-08dcde7570f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UC9obm1oN3l5OWhLZTBGSVdQQ2dRU0xTMHRrRlJDVFcyNDNqcUtXV2M3bTR6?=
 =?utf-8?B?bzBydTlEeXhoNEcydXpzQm5ScHMwcnlKc0N0NXVPVnA1d0J4amczcjhlcWk4?=
 =?utf-8?B?WTRaMjBvMkc3K2VSUUIrWk40SHBHMmxUMy9VWSswYmswNE0wdkcvMHNtT2VW?=
 =?utf-8?B?OWlrOHNraEU1cHNMMWV0VUhZM2tvMnJiTVdVNktsbytNS0NpRGdyazZ2N0ZT?=
 =?utf-8?B?dHV3VkEyUzdLUUphKzNPZ1haM1FnVDhGSmdyYUZpc1BMT0kza0lUUEVLMmEv?=
 =?utf-8?B?eGQ3MkRqV0V1VUJ3WXgvR05kQUJlaHJYbUJRbXNVc29nMnZraWc5eUlpSHZs?=
 =?utf-8?B?WUhrQVI2b1g0UmRJUXNoeFdZQ0h5QVdZelZqTWhGOURhWjg0ZkptSnZob3Uv?=
 =?utf-8?B?dytwd0RiMzNlMnZmWDhHd0ZxMSttNmJYUE1vRkxXOTRkRk9OTFdtbHVaZjJl?=
 =?utf-8?B?a0I1Nlk5cnVuOS9waysrRFdZRlhvRHJWWUJNZDEydlBMMzBDMmVvZldEWHI4?=
 =?utf-8?B?M1pLS25DUFlubUtNMElVRVRQaWhFMnJRSnU1SHgrVzNoN1ZrUG83dk5aS2Nv?=
 =?utf-8?B?bWhLSjN2cnA1UG93Qk1VY0V0SVhMK1NTUHpJWnNMSU9HM0RJZTVwN2RrUHlH?=
 =?utf-8?B?R1pDa0lZWUgrWFk1TTBrVW55YlhBOVFSMDVRS201SjVlVHAwMlRZSlVNWGMy?=
 =?utf-8?B?TUwxRUw5NGZhb3lyVWdOSG5OdmxiOHVoelVRMHdEbDdhMkhNZmVtcjV3K09U?=
 =?utf-8?B?cUVDekI4ZkNOUDZtb1FuL3VVdS90bjI3SmJpeXlpU0NmeGU1QktxSUM2VUtR?=
 =?utf-8?B?LzFLNDE5cVlLM0RpNnBETE5xVkFGcDQ3V3R0Y3p6YjBnNWtmVCtGbnAzWTEy?=
 =?utf-8?B?NWtCd09RUFFJc2VubDNWVXB1bU56cWhzRmJ4cHZ5dDc0L3M2KzB1RUpydjhx?=
 =?utf-8?B?SWdjc2crQ1J2aHBIeDJPaEhQalorYkFjOWxaVHZhKzBpOGhDdXVoYkNZSVdr?=
 =?utf-8?B?akJIY3hxWElJVFVGWkRlRktBMVBzZDZwZE5zTE53UlRtMkpta3A4eUpvd1hF?=
 =?utf-8?B?UU5YSXQ5QWR3emZXUjdkQ0tTc20zZmQ5eEF1TjFMS2x5N2d3Ujh2MnFCR2hO?=
 =?utf-8?B?QlBOVitBZDVVM3hNTFN2RUlTQ0NGOU05bW5SSTBQZnBIQUxtRmxDZkNNUjR0?=
 =?utf-8?B?SzEwcEhqSUtUY3RHTHV1cnY4UndqK2x6Q1VnVys2VGVta1Y2aWhnNEVNeGN4?=
 =?utf-8?B?LzNpMXhvNy9PNjVsUllOaGl3WEZ6MU9reXFpRnF0OTJWUnUzMXVYYzV2dVFQ?=
 =?utf-8?B?RnlRVGlNZnZlQmJDdE5qdkZRNWxzZnRFZ2dGOXcwVDNwcUR3RkZKWXpXZEJQ?=
 =?utf-8?B?Rm81MG9uZGxBQW1DM1JmUTFpanZ6VkZEWHh5dDZHeXFwT3VNZkV3Skh1Zm9M?=
 =?utf-8?B?Rlo4elIwMm9UUmFDUjkrMFpIN3JqdGtOYTZKdS9oeXNIbGRvQW4wampQZStl?=
 =?utf-8?B?STlWY1N5MElLU1c2K25nUlZlem8yZEpObXN4UW5Yb3NWa2x2MVlVY3lQR1Qw?=
 =?utf-8?B?SGtIWDNnblJlRitnWW5hbEd4Ymlqa2w3L1FpdU03RkRMeFpvOStPeWFmcldT?=
 =?utf-8?B?LzZOenh4Y1RidDFvL1dwSGMvMk1iZUY1Ny9VblB5TWxUd2pZdzRLTEtqdWY4?=
 =?utf-8?B?aVlwTTJUOE13aXlJckdHWWVDTFBSZjIxSWhGcFZKK1VoTmpMOVg5bEErMDQ5?=
 =?utf-8?B?TEVzWktKMnl4N1EzQzVsNFd4N2hKMVkxRWo3OVRzQ0lZQTUvdWU2c21yb0Yy?=
 =?utf-8?B?anpJR3BNQ3lTbDNDR2VkZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VFlha2RQeklkUEF4UFRuS2dmMmRkY1NjRVdmVHEwbzJPN09JZTJrVEJuRzBK?=
 =?utf-8?B?NTNuQnVxZ1VhODNDV3M4OVJyOStrRnpxekZsZ3pDWjNPQS9OYTlnbWdxNi9E?=
 =?utf-8?B?WWZtbVY4RnpIUlNEVjE4ck5tOS9hd1BYN3VNWUNRRGVaQU91aWMzaC9hampm?=
 =?utf-8?B?RTN5Tm5SUmV4MnMvOGRqZ2hjRXZ1WEV2akFldHZpUk1ZeWI3cnFkSDJyVVJz?=
 =?utf-8?B?MHhKOEZoRHIxSElxSjBGTkFkcy8rUklRY3F3QkNabTlRSlEwY0pLMklMQTRk?=
 =?utf-8?B?dUhveTBRY2NYSi9EdHZocURZTUZ2VzZYeFdWL3lpRVNwNHE0ZTZhL0RLWlBp?=
 =?utf-8?B?Y0hXajRCQkU0RzBsNTUwaXd4cUYxUUNGOGxwUm40dENudmpCNW11alA4RkVM?=
 =?utf-8?B?NGM5U0RsUFpqL040bkM4Q0crcjhCdmN6WUZMcXdJSXNyNXB3TkRUKzMydmF4?=
 =?utf-8?B?cnBPZHVtc0ttQW11S05LQVJjQTJhYnJyMlhWOWdkN3hoQ1dONDhCOVk3QWps?=
 =?utf-8?B?b2tWUTI5MjlTcUI4WmFzUk9uODNwQlpYSHd4c1lrN1Y4MmYweU83UEppSGpM?=
 =?utf-8?B?RFpPalJ0YVAvazk2TDh4N1ZWTnJUVG9EVGJsWlB5cmd6TEU3cVRjWGp1dmNq?=
 =?utf-8?B?MERzZWtKSExFSnFBMFA2MWNTblY3a25EUFFScFF3dkJaNEZ1STBEcWdTaHVu?=
 =?utf-8?B?b3o0QkJEekZ2VXcrTnhwSU04NWJQWkpyQzNSU1h5SS9sUEFrWXNuMVA3K2dF?=
 =?utf-8?B?R0pxNWlUeHNwa0IzK3FlcEJ1N3JJMUg2ajhUQVdEbm1KaG1FcGpaRjlPTnYw?=
 =?utf-8?B?Q0FVaGdONGY1RndwT2JkWUxtK1FtQkh1RkEvelJxTll1MEcyeGZrbFlOMlIw?=
 =?utf-8?B?Zm9hMTBqbGdYajQvWk5GNWlMaFY3d05nVVA0RDZoS3VPWWd5SytzVmhDYmNu?=
 =?utf-8?B?K0JtSUdsVnhnVWtmM0JISEtvcitzUlYwdVFnUkxMenlHYzJwM0piODJVYUxw?=
 =?utf-8?B?dkxLTFRYTkp5emdwNGxTaHp1a0owMUZZUDlHMEx1czgyY0VLWG9XWmoyejFZ?=
 =?utf-8?B?U2tHMWVIanM2dlFBM2dpcUxWOU1PNFYwVHFydVpveWE4aTVjbmpsZkIwemFz?=
 =?utf-8?B?S1BaY1lhV3I2WEE3cVljLzUzdUtLVnJ1SFhscFhTNEZKck1PZEc4U0ZPVDRY?=
 =?utf-8?B?b2JOZ1dwSnFBaUVDakMwVUU3QWJLYXFYSFFaYlB5MHVkSmRuTlRVMG9jYmUv?=
 =?utf-8?B?UUZ4eXc5elIzU1BDeFRIV3VSNzM2N3FLcVZBSWc1T2FyY3doclVXZHJVUDJC?=
 =?utf-8?B?dXJyR3l1eWNaRjdnZjF0b1BiV1BTNHZ6VlZPVkU4QTFIVUNGSEpSVWgzUGxU?=
 =?utf-8?B?eGppWVU4clJLR1p3UE1uSDlXUElqYStFVUxPbUR4MDRLQ0UveVZUMndKeGpl?=
 =?utf-8?B?aFdoSGtRWG5lNXlpVlRqSnluYjB5N09ZVVo5czM1RmU3d1JZVzBCWU0yb2tO?=
 =?utf-8?B?aGxWd2Q4SW1FU1ZiWCtTSWRaOXFhQ1FwOXh3NnhTUEpXczJvaUtIeHQ2cWhW?=
 =?utf-8?B?QUJXaE83RS8rS0RLN2F0ak5ZNlBkaDN0R1pzYm1TNjh1Vk9xVGU3M3dGbzZo?=
 =?utf-8?B?QmRNTkNwejFCU1lOeGZyVVdMcEJ0RWlwN1dxMklSZlEyaktndkw2U1V5bVRy?=
 =?utf-8?B?UGtBTEFxZVVUVFpPMGExQjhRaVliQnUzNFVTMmRnRE8yK2Q2T0t4L050WmRp?=
 =?utf-8?B?UzFDTXg3b3prYjlMWGtTc1RZc1psbDQzNjN0UUZjekpGZWtOckMrRURPaFpM?=
 =?utf-8?B?dk5mLzA3eEUxNGY5eGJnSW10R0p6dlNpRHB6WWZTbTRVMEl5SEU1Wm03U0kv?=
 =?utf-8?B?R2c4SnFZUEk4QXMyV0Exa0EvbFBBbDhMcWM0SW15dWEzcmxOcU1kOG9rcjJ5?=
 =?utf-8?B?ZjJSdk1YdXFsdUVsQkdiSXM4TDJlZzFVQzlYdXFhNnFmVGpMMHdQRU4vNFYv?=
 =?utf-8?B?RSt6THY2akNzN1dDR2NGdllYcWxVYklxZlh5bEZ2Z0JFbVRNRm5BT212Z0ZP?=
 =?utf-8?B?Y0JlTlkxTGhXdFpMeGF6TTZJQXZVMGFNUjhDWDVSZVhSRnlqZUlDMlVuUUdz?=
 =?utf-8?Q?t2hweP6WLY0rUVhLi48GSXDvs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9376C6A774A17408DC9D1C50BE142C3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FauJQ2JgvFQ4rMpIQu1IXG2omJGynU/KzzVtYeUn8FBXFsDyUaUvxgjHs0yZzRa0kEgLJX8fUI16yPUz2HMmAYlDjLMmzydhGMTl3VVV/AtuxucCvo8AceGIPjzv3YmRkxxe3+XF/AJQcbyBzLkOd3VSf0ZBHUa1u+x4RCnLRK55jXwI67jRamErtH4ztuXs7WvjjjEji9I8KgNApdxXsUTZwo1s1s2FlzWbT3WfdQ9Dykm0HqwP4sbmloEjg88f3Q7ScT3VmAwwnCN1eJi0plOxqS87q1BgBPLqrYSsTE9TMTSlPrTmzHg27o3gu84+CZ8XasA00o2EPmG+miFID7oEHxVkO89SHiUuS9dDtpkf3PPlG9MSO6ppHgHlswkzAlgWlLXiZT9SIloDvRtsTeR8P4EhenofFddypXexjVWfScBh4DAROvqjZVk8ZU5KaogMEBW4U5rlqfN8Mq9OLheqq7U07jcuqe85NG+byF0BDMWsOuK7tW76E1DWBrds6lfJG1hl9hykMbAdIWajBxYdyl5ZdR8KFFIoGf4DQVy2FHHn6XDwUlnU5Y2whGnhMuJRvBt3c2W89vRvUroWw6OxZ4UcbFJXTVDqGW398q2U2m0Ck6yzMNx5J3LkNJu6XJ6JUAWDOWcekM8YZh6rXw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83aa513e-0a41-4640-a04c-08dcde7570f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 21:51:56.6963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ctPZsQJ0usI+iHz/9qWBJS/+5ets1cK3WtC7dNDgE8I2RSj48x1lO4YIYYxNRGc4bBdm3UQJD02VQhvnnb+uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8733
X-Authority-Analysis: v=2.4 cv=Iu1Mc6/g c=1 sm=1 tr=0 ts=66f5d785 cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=IpJZQVW2AAAA:8 a=Y2vXitDMnUepB-BQIIcA:9 a=QEXdDO2ut3YA:10 a=Lf5xNeLK5dgiOs8hzIjU:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: HG6zGyH807vjKIKQEkAp29ZpCj8h47c9
X-Proofpoint-GUID: HG6zGyH807vjKIKQEkAp29ZpCj8h47c9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 clxscore=1011 suspectscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0
 mlxlogscore=897 impostorscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409260153

SGkgUm9nZXIsDQoNCk9uIFdlZCwgU2VwIDI1LCAyMDI0LCBSb2dlciBRdWFkcm9zIHdyb3RlOg0K
PiBIZWxsbyBUaGluaCwNCj4gDQo+IE9uIDE3LzA0LzIwMjQgMDI6NDEsIFRoaW5oIE5ndXllbiB3
cm90ZToNCj4gPiBHVVNCM1BJUEVDVEwuU1VTUEVOREVOQUJMRSBhbmQgR1VTQjJQSFlDRkcuU1VT
UEhZIHNob3VsZCBiZSBjbGVhcmVkDQo+ID4gZHVyaW5nIGluaXRpYWxpemF0aW9uLiBTdXNwZW5k
IGR1cmluZyBpbml0aWFsaXphdGlvbiBjYW4gcmVzdWx0IGluDQo+ID4gdW5kZWZpbmVkIGJlaGF2
aW9yIGR1ZSB0byBjbG9jayBzeW5jaHJvbml6YXRpb24gZmFpbHVyZSwgd2hpY2ggb2Z0ZW4NCj4g
PiBzZWVuIGFzIGNvcmUgc29mdCByZXNldCB0aW1lb3V0Lg0KPiA+IA0KPiA+IFRoZSBwcm9ncmFt
bWluZyBndWlkZSByZWNvbW1lbmRlZCB0aGVzZSBiaXRzIHRvIGJlIGNsZWFyZWQgZHVyaW5nDQo+
ID4gaW5pdGlhbGl6YXRpb24gZm9yIERXQ191c2IzLjAgdmVyc2lvbiAxLjk0IGFuZCBhYm92ZSAo
YWxvbmcgd2l0aA0KPiA+IERXQ191c2IzMSBhbmQgRFdDX3VzYjMyKS4gVGhlIGN1cnJlbnQgY2hl
Y2sgaW4gdGhlIGRyaXZlciBkb2VzIG5vdA0KPiA+IGFjY291bnQgaWYgaXQncyBzZXQgYnkgZGVm
YXVsdCBzZXR0aW5nIGZyb20gY29yZUNvbnN1bHRhbnQuDQo+ID4gDQo+ID4gVGhpcyBpcyBlc3Bl
Y2lhbGx5IHRoZSBjYXNlIGZvciBEUkQgd2hlbiBzd2l0Y2hpbmcgbW9kZSB0byBlbnN1cmUgdGhl
DQo+ID4gcGh5IGNsb2NrcyBhcmUgYXZhaWxhYmxlIHRvIGNoYW5nZSBtb2RlLiBEZXBlbmRpbmcg
b24gdGhlDQo+ID4gcGxhdGZvcm1zL2Rlc2lnbiwgc29tZSBtYXkgYmUgYWZmZWN0ZWQgbW9yZSB0
aGFuIG90aGVycy4gVGhpcyBpcyBub3RlZA0KPiA+IGluIHRoZSBEV0NfdXNiM3ggcHJvZ3JhbW1p
bmcgZ3VpZGUgdW5kZXIgdGhlIGFib3ZlIHJlZ2lzdGVycy4NCj4gPiANCj4gPiBMZXQncyBqdXN0
IGRpc2FibGUgdGhlbSBkdXJpbmcgZHJpdmVyIGxvYWQgYW5kIG1vZGUgc3dpdGNoaW5nLiBSZXN0
b3JlDQo+ID4gdGhlbSB3aGVuIHRoZSBjb250cm9sbGVyIGluaXRpYWxpemF0aW9uIGNvbXBsZXRl
cy4NCj4gPiANCj4gPiBOb3RlIHRoYXQgc29tZSBwbGF0Zm9ybXMgd29ya2Fyb3VuZCB0aGlzIGlz
c3VlIGJ5IGRpc2FibGluZyBwaHkgc3VzcGVuZA0KPiA+IHRocm91Z2ggInNucHMsZGlzX3UzX3N1
c3BoeV9xdWlyayIgYW5kICJzbnBzLGRpc191Ml9zdXNwaHlfcXVpcmsiIHdoZW4NCj4gPiB0aGV5
IHNob3VsZCBub3QgbmVlZCB0by4NCj4gPiANCj4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9y
Zw0KPiA+IEZpeGVzOiA5YmEzYWNhOGZlODIgKCJ1c2I6IGR3YzM6IERpc2FibGUgcGh5IHN1c3Bl
bmQgYWZ0ZXIgcG93ZXItb24gcmVzZXQiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFRoaW5oIE5ndXll
biA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCj4gDQo+IFRoaXMgcGF0Y2ggaXMgY2F1c2lu
ZyBzeXN0ZW0gc3VzcGVuZCBmYWlsdXJlcyBvbiBUSSBBTTYyIHBsYXRmb3JtcyBbMV0NCj4gDQo+
IEkgd2lsbCB0cnkgdG8gZXhwbGFpbiB3aHkuDQo+IEJlZm9yZSB0aGlzIHBhdGNoLCBib3RoIERX
QzNfR1VTQjNQSVBFQ1RMX1NVU1BIWSBhbmQgRFdDM19HVVNCMlBIWUNGR19TVVNQSFkNCj4gYml0
cyAoaGVuY2UgZm9ydGggY2FsbGVkIDIgU1VTUEhZIGJpdHMpIHdlcmUgYmVpbmcgc2V0IGR1cmlu
ZyBpbml0aWFsaXphdGlvbg0KPiBhbmQgZXZlbiBkdXJpbmcgcmUtaW5pdGlhbGl6YXRpb24gYWZ0
ZXIgYSBzeXN0ZW0gc3VzcGVuZC9yZXN1bWUuDQo+IA0KPiBUaGVzZSBiaXRzIGFyZSByZXF1aXJl
ZCB0byBiZSBzZXQgZm9yIHN5c3RlbSBzdXNwZW5kL3Jlc3VtZSB0byB3b3JrIGNvcnJlY3RseQ0K
PiBvbiBBTTYyIHBsYXRmb3Jtcy4NCg0KSXMgaXQgb25seSBmb3Igc3VzcGVuZCBvciBib3RoIHN1
c3BlbmQgYW5kIHJlc3VtZT8NCg0KPiANCj4gQWZ0ZXIgdGhpcyBwYXRjaCwgdGhlIGJpdHMgYXJl
IG9ubHkgc2V0IHdoZW4gSG9zdCBjb250cm9sbGVyIHN0YXJ0cyBvcg0KPiB3aGVuIEdhZGdldCBk
cml2ZXIgc3RhcnRzLg0KPiANCj4gT24gQU02MiBwbGF0Zm9ybSB3ZSBoYXZlIDIgVVNCIGNvbnRy
b2xsZXJzLCBvbmUgaW4gSG9zdCBhbmQgb25lIGluIER1YWwgcm9sZS4NCj4gSnVzdCBhZnRlciBi
b290LCBmb3IgdGhlIEhvc3QgY29udHJvbGxlciB3ZSBoYXZlIHRoZSAyIFNVU1BIWSBiaXRzIHNl
dCBidXQNCj4gZm9yIHRoZSBEdWFsLVJvbGUgY29udHJvbGxlciwgYXMgbm8gcm9sZSBoYXMgc3Rh
cnRlZCB0aGUgMiBTVVNQSFkgYml0cyBhcmUNCj4gbm90IHNldC4gVGh1cyBzeXN0ZW0gc3VzcGVu
ZCByZXN1bWUgd2lsbCBmYWlsLg0KPiANCj4gT24gdGhlIG90aGVyIGhhbmQsIGlmIHdlIGxvYWQg
YSBnYWRnZXQgZHJpdmVyIGp1c3QgYWZ0ZXIgYm9vdCB0aGVuIGJvdGgNCj4gY29udHJvbGxlcnMg
aGF2ZSB0aGUgMiBTVVNQSFkgYml0cyBzZXQgYW5kIHN5c3RlbSBzdXNwZW5kIHJlc3VtZSB3b3Jr
cyBmb3INCj4gdGhlIGZpcnN0IHRpbWUuDQo+IEhvd2V2ZXIsIGFmdGVyIHN5c3RlbSByZXN1bWUs
IHRoZSBjb3JlIGlzIHJlLWluaXRpYWxpemVkIHNvIHRoZSAyIFNVU1BIWSBiaXRzDQo+IGFyZSBj
bGVhcmVkIGZvciBib3RoIGNvbnRyb2xsZXJzLiBGb3IgaG9zdCBjb250cm9sbGVyIGl0IGlzIG5l
dmVyIHNldCBhZ2Fpbi4NCj4gRm9yIGdhZGdldCBjb250cm9sbGVyIGFzIGdhZGdldCBzdGFydCBp
cyBjYWxsZWQsIHRoZSAyIFNVU1BIWSBiaXRzIGFyZSBzZXQNCj4gYWdhaW4uIFRoZSBzZWNvbmQg
c3lzdGVtIHN1c3BlbmQgcmVzdW1lIHdpbGwgc3RpbGwgZmFpbCBhcyBvbmUgY29udHJvbGxlcg0K
PiAoSG9zdCkgZG9lc24ndCBoYXZlIHRoZSAyIFNVU1BIWSBiaXRzIHNldC4NCj4gDQo+IFRvIHN1
bW1hcml6ZSwgdGhlIGV4aXN0aW5nIHNvbHV0aW9uIGlzIG5vdCBzdWZmaWNpZW50IGZvciB1cyB0
byBoYXZlIGENCj4gcmVsaWFibGUgYmVoYXZpb3IuIFdlIG5lZWQgdGhlIDIgU1VTUEhZIGJpdHMg
dG8gYmUgc2V0IHJlZ2FyZGxlc3Mgb2Ygd2hhdA0KPiByb2xlIHdlIGFyZSBpbiBvciB3aGV0aGVy
IHRoZSByb2xlIGhhcyBzdGFydGVkIG9yIG5vdC4NCj4gDQo+IE15IHN1Z2dlc3Rpb24gaXMgdG8g
bW92ZSBiYWNrIHRoZSBTVVNQSFkgZW5hYmxlIHRvIGVuZCBvZiBkd2MzX2NvcmVfaW5pdCgpLg0K
PiBUaGVuIGlmIFNVU1BIWSBuZWVkcyB0byBiZSBkaXNhYmxlZCBmb3IgRFJEIHJvbGUgc3dpdGNo
aW5nLCBpdCBzaG91bGQgYmUNCj4gZGlzYWJsZWQgYW5kIGVuYWJsZWQgZXhhY3RseSB0aGVyZS4N
Cj4gDQo+IFdoYXQgZG8geW91IHN1Z2dlc3Q/DQo+IA0KPiBbMV0gLSBodHRwczovL3VybGRlZmVu
c2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYXJtLWtlcm5lbC8yMDI0
MDkwNDE5NDIyOS4xMDk4ODYtMS1tc3BAYmF5bGlicmUuY29tL19fOyEhQTRGMlI5R19wZyFZMTBx
M2d3Q3pyeU9vaVhwazZETUduNzRpRlFJZzZHbG9ZMTBKMTZrV0NicXdnUzFBbGdvNUhSZzA1dm0z
OGRNdzhuNDdxbUtwcUpseVh0OUtxbG0kIA0KPiANCg0KVGhhbmtzIGZvciByZXBvcnRpbmcgdGhl
IGlzc3VlLg0KDQpUaGlzIGlzIHF1aXRlIGFuIGludGVyZXN0aW5nIGJlaGF2aW9yLiBBcyB5b3Ug
c2FpZCwgd2Ugd2lsbCBuZWVkIHRvDQppc29sYXRlIHRoaXMgY2hhbmdlIHRvIG9ubHkgZHVyaW5n
IERSRCByb2xlIHN3aXRjaC4NCg0KV2UgbWF5IG5vdCBuZWNlc3NhcmlseSBqdXN0IGVuYWJsZSBh
dCB0aGUgZW5kIG9mIGR3YzNfY29yZV9pbml0KCkgc2luY2UNCnRoYXQgd291bGQga2VlcCB0aGUg
U1VTUEhZIGJpdHMgb24gZHVyaW5nIHRoZSBEUkQgcm9sZSBzd2l0Y2guIElmIHRoaXMNCmlzc3Vl
IG9ubHkgb2NjdXJzIGJlZm9yZSBzdXNwZW5kLCBwZXJoYXBzIHdlIGNhbiBjaGVjayBhbmQgc2V0
IHRoZXNlDQpiaXRzIGR1cmluZyBzdXNwZW5kIG9yIGR3YzNfY29yZV9leGl0KCkgaW5zdGVhZD8N
Cg0KQlIsDQpUaGluaA==

