Return-Path: <stable+bounces-20334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C448572A7
	for <lists+stable@lfdr.de>; Fri, 16 Feb 2024 01:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC24EB231C5
	for <lists+stable@lfdr.de>; Fri, 16 Feb 2024 00:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4CC149DE9;
	Fri, 16 Feb 2024 00:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kxZo6a3W";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="drdecRi6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TlHbKmRO"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B92803;
	Fri, 16 Feb 2024 00:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708044081; cv=fail; b=rxT58uY24Dxnb4UgX63MNw97EiZpF/8QkjlMhrzG/WoUdqPXVZXOPrlrWO6dTw9yDFKdAIQ3k81D7WT4/cWmf3b5M+i52XjtYjNX4y9gXWl/TLKyGIjq4ZC40hBcJZwTcb2MRHuOfJPb4m2rMhPmLkj+fBYDHdHewJH4jCiOoto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708044081; c=relaxed/simple;
	bh=Ub+9MW4PMTIsovQatMaqtPHrARClHZNDn4O6x4mkYVE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=R3vDux6WYVzgr5xBz7YNbhW7DwceCIA4NzbLenOjoouomcR01A30Cmz5XLUg2MDVJG6Ct0jKBBmqM+RGFUKo59CNKecojfu9bAtXd38gvZCZWFSJBpvblzV9ddsKGsCTyOlUEkR9M5oiy7DFVcZOhIB5ldiQUURdeCweSzOcF7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=kxZo6a3W; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=drdecRi6; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=TlHbKmRO reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41FNXfXe005091;
	Thu, 15 Feb 2024 16:41:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=pfptdkimsnps; bh=lAMN
	fXiZGEMPETwsZVbVxSwHYo5J59v8pubEiqYRkAU=; b=kxZo6a3W0lwcxoAtGXFa
	GUJhKUd4oDnUcR1caAJBGxb19+ihe3SWD6dKgK1rShGe4rrPGLWKA6sGLLdxgVGe
	sQBu3XkGfY+j7K4xze/KBnEKCsBmJI4aEvnPYYFhhb9fRvtjM/BZINhS+THBRvfu
	3f/K0yi66I+Bw9mxzqSpc8Px9mo+0VNQdtbt6RVJe0DtqwSkBJAan/l0Njt2IhKo
	4ISVTiLrq1pcu7LxoZomfaH/PECEU+UvDRs01gFuCciI4FrqFMJWjWqo0WQ4DU1y
	2GervJCtmeL7Rm8/FpvOks6gw5BVXl7Nw9tk+PBwxtNudbosnu+BZ7x7oIsi2nof
	mg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3w9gq736ya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 16:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1708044069; bh=Ub+9MW4PMTIsovQatMaqtPHrARClHZNDn4O6x4mkYVE=;
	h=From:To:CC:Subject:Date:From;
	b=drdecRi6WIPAhV/n4UrywrG4EXyiuOA0eyA+B/nE5oKmCFY7x5/1tACNEc67+8hXr
	 L7EOmi1yzGB8mWXowVDpMzyxtgVnZ+a66HXPTlC2RPuoDbAJPIhD3sgohPpFp9Ub3C
	 R0DD58TtHKYKTrU+qX960hEkdhpLYmC5TEcrKvKerIAUKNp8Pq6OuFvEgqRUpzYY7i
	 i8ru4T16sHRTu0jdUpUhkFUuL7PJPlJjL5k2+meRTFk2quKJZg08lbNKdex22pnIFX
	 XVmKKTCBw3mtnHSeKwYYCClVgS2BMa3B4ZgR/tw/OiuzUyR8Fw5mvj0b4UIpsnOUCg
	 0wSJo0x3Zutvw==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 886C14035F;
	Fri, 16 Feb 2024 00:41:09 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 17822A0068;
	Fri, 16 Feb 2024 00:41:09 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=TlHbKmRO;
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7272E404AC;
	Fri, 16 Feb 2024 00:41:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9s2UjHGsCCSudd8gEl5Gk34QWbVWukOvAYHYteuoUI/S026yZ0BDnWPqS1s8xXrOLijigUE+hDXLIk86D8maPohPhJPdZ6wsfYa8gwaT90rI9hAK0JFArDKfKw9zMbNDyWDQKg2j+nDDBj85HylJMD0mgAEmVunqiJtFhgarGqk5CNPUPJivxPnc/aWTAnjP+lMd5WuMCzg7z31K9ZyiJhgSOb6e1ElxpsntU7Y8RMFjcgTljBijdCTQy9H6z/25QBkN2uoiaJiykZpHjxX/SUwKT3s4G6fadhUN1GjFlhDddCOKaTTqqRAbMbAIf8kuJLzgRymRaybRIUQhDA3dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAMNfXiZGEMPETwsZVbVxSwHYo5J59v8pubEiqYRkAU=;
 b=iUB7xwbQInryuB299gZ5u434yqZIrsMgEaTmLC/bF4T59eKD79BCP/9wn9TjKA2Ay1/vVI2ZnxAf8KhmUMEk75/p0oxVpCRJ0EIpl9It6Nwf+BDkF+F5sKuoakbIZR4goP4zQB0+hcHnNDI4kSVQiCHeX32SF6RsEalGDDeobctD9UgWLevU09/sM0BdWLjHo4185uDCasg0qfbXp/ZR7wy5ulzSyJYui3NCvKCgGKBOTN1Vwn7lcrM8BXT4cR9dQ1tN8OsXSbnhsUH+0KHUsCnar6HAHd+Jk5Etx6gN1m1WGw8kSjnGXzgUJb5I/HqpZXSsKYfHAzVBFL9uKPrNqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAMNfXiZGEMPETwsZVbVxSwHYo5J59v8pubEiqYRkAU=;
 b=TlHbKmROIzQTXGo5Oi3r75YFq0Ja8jXQp+2k9YFEHjEomU2HLnaMrsKpPOEuJeVqZfur/QnpMjENgtzucq8s4VcGwdkMCN3r82w1D2MPbCwlpsH/Af0F0EMUiqHJTZ9YnJf4maWsUnh5XbdHgLdYTUhqJfBC9CXERpRZpKv53p0=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH7PR12MB7817.namprd12.prod.outlook.com (2603:10b6:510:279::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Fri, 16 Feb
 2024 00:41:03 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7316.012; Fri, 16 Feb 2024
 00:41:02 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: John Youn <John.Youn@synopsys.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
Subject: [PATCH] usb: dwc3: gadget: Don't disconnect if not started
Thread-Topic: [PATCH] usb: dwc3: gadget: Don't disconnect if not started
Thread-Index: AQHaYHDRA3yQewo71k2ytDjVUJxChQ==
Date: Fri, 16 Feb 2024 00:41:02 +0000
Message-ID: 
 <e3be9b929934e0680a6f4b8f6eb11b18ae9c7e07.1708043922.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH7PR12MB7817:EE_
x-ms-office365-filtering-correlation-id: 698ed57f-e181-4dd4-5b11-08dc2e87f3e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 UTMKjB4T3ZJ6ohwLr0AsdXVtVBTdZtIvDkAgnFDqjc/NoqAo6nEM8MiUUUAp8kezNYI9duc+rcHKT2NTgXUypXDcCilboz4MhfK9EhJFXMuBox1HsCQbBccUIq+kPxqpW9TqOY4u28Dgv8g8iZuKPl0s+0doGHOG+begpxOvklfjuU5th5RCk964nTfuKK8TarX85CbKlw5PVqUepm5XdUR1qHLbn35K8zydiJmp0DZfsmjzXlnZf7BLoSii2TWQEemSEiwE2J3dSZgE1Wt19iltLs6ptl0ghHz1QSxi8O+IsV4jP9U0sbYHgs8LMYHJXRvkSgM/EgwY1ll/tSmSxEpWUVPbbtI90eRwxpJldR9oeNiYbq8hbVl1H/1/r2oISHMbjegaf9dUSJWrOpHcAjk2cnGY+abk/ll6vGza5FK5nA4PsZB3ZeBO82NTZTr6WMWg9tFLDNuSvmSq9OKTNgsmajCnXPSKAODKPLgeQBmgE86o31XjHh4Ua4CYCSPOqHGsQ0C46u7BXwlxcsd3Bo9aysEWQb3HfK2W95dTMSY71QXJSwlqb0NEARdrggAS5cORw9/4n79wI19eIKJrFr2zxmNxnwCbsliiIcu1LQ8=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(376002)(396003)(230273577357003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(71200400001)(6506007)(8676002)(83380400001)(38100700002)(26005)(122000001)(66476007)(110136005)(8936002)(66446008)(4326008)(38070700009)(5660300002)(66556008)(64756008)(76116006)(54906003)(316002)(2906002)(66946007)(36756003)(478600001)(966005)(2616005)(6512007)(86362001)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?Q+l+5K0FLeG3ECMu0TJpmRCJwBEWFErHK3NbdkBPgMGLB0hQxQq37h7Urk?=
 =?iso-8859-1?Q?eNv779iLC9oj6J9U0p/uwYRqm5Y9E6UEBvkyW8mFEVjfmLQHA/xomHvYKT?=
 =?iso-8859-1?Q?sI3FnxPTqo44523tFWtz83+94TuJ9CtEu9fO3Emro4+9u8i5KrXtjSzL+B?=
 =?iso-8859-1?Q?cfuBdwPyEYo+MqKx4bP4d428tUg92uL5sLendJIJDLjGEZZg+8k5h/B0Tc?=
 =?iso-8859-1?Q?j6OexqLuN21cTrCTcDu9GbJ6eqUq4HuzAJXKVKNI+aDdJDIx1zQlNWVKyY?=
 =?iso-8859-1?Q?Ah6Npq7cqEooY2rm1Q+Of8lN4vblkq8ejeNpGsaurpHL8sGHg0QaYMGnbe?=
 =?iso-8859-1?Q?+EY3qkOlwxWDZDvJipt39jxlyZb1uMGt5TlJAVLp3zUidAhk1rA+YGCygm?=
 =?iso-8859-1?Q?Nw7jtwmXghH1vKrMImTxP8jom5AlqluIGY68JWwmPot06PK7nHHJk2SHhk?=
 =?iso-8859-1?Q?bA63Z+Uqohi30NiMJyUKIhDqbKsJIJXlMseGGL+/wVqPCDpO8Nvw/wWJgg?=
 =?iso-8859-1?Q?sJfGxWHFqiXp6XqrS8a4803jYIRB6Tv2mTPQKj4b87DTTLCEp82EM2jYvk?=
 =?iso-8859-1?Q?vliF4gUKLSGA1fn2l/siyyBu0qQocTxetIauQsB4aVuqpxkNLvO9neK3ss?=
 =?iso-8859-1?Q?GwEM26mMcmQ/5EpoI4+2J0jLUS6YofNaoZ3yief8uCYgLusYmpRG1SKfMy?=
 =?iso-8859-1?Q?/ZMO9sNpKQVSkYODFttzz8qfZ79qrpVAuifBWGyfnVOmF1jMNvoH1hQzDv?=
 =?iso-8859-1?Q?BfIB742TzaJcirFOKpX77ubbdFzZxjsZF8qaMH7upwVXiNqxLE7AKewjNV?=
 =?iso-8859-1?Q?WItgnEsfFWjYTQxsXHPgOa2pi+mBjayk1AWCoM1SA9D/lDn7kj4J8xkE3k?=
 =?iso-8859-1?Q?0nolxPA9a45rgxbmUtMhWGuYrLOQmqCLNERpZxMoQpWKwPzo3SBEZUoUqi?=
 =?iso-8859-1?Q?kzRvr7eG5Z+PAb/GhJwWQ5AAX3GATGQwrRKl7sF5cHIcRoGpWzEwS0UzEI?=
 =?iso-8859-1?Q?yHz20AuEX00d4gxmLP0/Df3JmBOUeA6DxZInDxB7WgazSNliGCj1taCrwF?=
 =?iso-8859-1?Q?Oxy+XtbuEB8w3XcJFHINuJ5FGeim6c8CCmp080rBNXaOR7v7Vv22HlA6So?=
 =?iso-8859-1?Q?3PP+G2pBDde4hf/+qrYDFFOaii4OrLpCmppxXkp7V25ug6/T7jKT1LOA2g?=
 =?iso-8859-1?Q?jJa7kkc+7qW91XMudYgrI7h3BX3I94atvbI8GVUbYKXKMRIwiKdFnWyMsp?=
 =?iso-8859-1?Q?82a22hRghQRxMM6S5Gk1OCSdIAEuE5ClpVraYt8bD7jD+ZyWBlZDJkSf3a?=
 =?iso-8859-1?Q?0B6nxGJHppgu4rjsnZDH+ZpBJjo/pLgHGZ33OmAs4x/Lpgveo7OCjfaghu?=
 =?iso-8859-1?Q?GYhAXTuwMuTn0mPLiZKKQLvPkRQS2uWNd/PZN1NDSkp0rGsBiFJfGOFH7h?=
 =?iso-8859-1?Q?jcuNi0FO+Az5ZU2BDEoqy8xwzqyo/gs1voBV6RAWeQVm/Up7mrIXobCI8S?=
 =?iso-8859-1?Q?NbzbseEAWe64tn3wkiLbEtvNvxY7H2U3UA9tyIofKtVJTw3OfZQg45mgWR?=
 =?iso-8859-1?Q?X69GFG4MKoSp6IdnOyT2MkQH9yFbH/Yb7v/AkNOVHiSYEIfQUMjhE7T++c?=
 =?iso-8859-1?Q?wDWZ51cJYXpjlUlHRSZVdbVA0TXbqyJv6S2ov5IVU38ZoHhNir/4U0MQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	sZ8K4ipN0IU4HjDOoiQbpHMR0EdmpWD69vB0BNxdCXPZyT3w90EVZF/D2Zp/GF1x7IBzQlOuqgsf+hGGGWQmFFtLrWMntr0Sq5syozlaYn2pnzjePm1kMfaMFfx9OCw1jPqih6TeBnklkRvCsAoWThf74QP/LUt00chhXaJOHEX4Y5qJ4JymUMa5qLCWpvbsmAKYuxIeyVdjxSplXTlgYaqSboLHEYOECp3DTdOOB7gE6gNNmi/tCQyic6lC5HKmpDcaRBa3oXWLqHqeBreNszTYWowMp0+hIi8eYXy+DLq4LXgYtCWJoVZP652n6FHwUOG4w1W/P0OlyXVM+gOeYMZjb3OfxiU4SWfl73wamfBtD0XhoXsgRADba7FTENNVIGUcBH1TreBInFbrz0HhYsLD0FytujeD2kKTu42Cm4Qe+hfHBkoEYjAz3yzvSsKFjuRmuL6nTdE/i2aes6WuQvCeOf/CZjkrZUx1ZvNJAN2L+TksfkpM9Tq0rk700L17KHLm+1cHcW58cvHEWQJf2qy7O5eSLhfdlHLQqmT/fOGyDgRYVlzB8qMllaQNdsyCwA1q29BugM7slvsCI8Hf+PR4Mu1Jxt2Qj6cXfxMUb8oqdiw3TY3rgCYoJ/8+JvJLhjY2w3eVv6tld3w6gFOkpw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 698ed57f-e181-4dd4-5b11-08dc2e87f3e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 00:41:02.7045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RflwolTzHu/auJvPJnQVtSGyEHP6CZEA4OnANKXprktNs1efacIEzLGZLjglyiGCmy4x2aigKLHcg82u1s3gjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7817
X-Proofpoint-GUID: p5-F359kovHKS_z4OeQn9UWSLYuciEK8
X-Proofpoint-ORIG-GUID: p5-F359kovHKS_z4OeQn9UWSLYuciEK8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_23,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 phishscore=0 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402160002

Don't go through soft-disconnection sequence if the controller hasn't
started. Otherwise, there will be timeout and warning reports from the
soft-disconnection flow.

Cc: stable@vger.kernel.org
Fixes: 61a348857e86 ("usb: dwc3: gadget: Fix NULL pointer dereference in dw=
c3_gadget_suspend")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Closes: https://lore.kernel.org/linux-usb/20240215233536.7yejlj3zzkl23vjd@s=
ynopsys.com/T/#mb0661cd5f9272602af390c18392b9a36da4f96e6
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 drivers/usb/dwc3/gadget.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 4c8dd6724678..28f49400f3e8 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2650,6 +2650,11 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *=
dwc)
 	int ret;
=20
 	spin_lock_irqsave(&dwc->lock, flags);
+	if (!dwc->pullups_connected) {
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return 0;
+	}
+
 	dwc->connected =3D false;
=20
 	/*

base-commit: 7d708c145b2631941b8b0b4a740dc2990818c39c
--=20
2.28.0

