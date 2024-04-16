Return-Path: <stable+bounces-40055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF52E8A78DB
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 01:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E75AB21AD4
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 23:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D2713AA2C;
	Tue, 16 Apr 2024 23:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="rcjcVLc2";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ct5manT4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="t6cv4uUz"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6224C13A88F;
	Tue, 16 Apr 2024 23:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713310906; cv=fail; b=jBK6Jn0bGVR+5rF8LHUmIIOrnEyIOv+OIQeKYkdAVDauxZ+Dd6hgtXwMW52t3D1RjeMvs7JaocOjduj1iSRDcU26TTBulauV/Xn4DMnWag3Vokp/OI4z1FApaudsKrCGvdy2ZnKGcGepF3SLKTuZ2dgWpvf6e5oQPoQrxSfBECw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713310906; c=relaxed/simple;
	bh=AYGegtnTN0TH7fUzqSEE6sYwxJENhDDAoO4MK6r9kpY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UrMOsEI4zniL4uC+73be1WbLfhIwR6BbIa3bjypihswd220FJzIYI4TcwyZacQI9L5PllP37YMzpYdAT/5pTgkmbsVVs8Wu+1YBCjDxaZWgouMiJtOevzyX5L4zNeJOCdbXMLhTNKMClhlUBpYoGrINdB5jAWr2tlKMRtfyQirY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=rcjcVLc2; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ct5manT4; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=t6cv4uUz reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43GHbY4e013700;
	Tue, 16 Apr 2024 16:41:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	pfptdkimsnps; bh=cF5Q35pK7V0lkL8E7GXTpbxb78e42HJSbSxX0oneDjw=; b=
	rcjcVLc2Amt0/KfjZ6pfoz6gckOwUpBNtnsecTXAIsLm1kkGQOIGQiwXHW2auyyD
	LcEowc0MR3A9E0VMch1UXtnzemW2f30UCD4Fv4xsEZTW0Y2ULL/5YciLICPjRcLR
	/y+tZ3n392y2xLeqwUU6Jei7BnarOukLVRQtxqHjufC3hPJo0kiw+em9ogVUfVFN
	z8kETZ5WhzaxJ7n48tYaHHl25vK7KzpzlmiST5isx7tOwD37GAAMkJ8iGQoxOZgx
	yJlf00NgmWt1ilo1K2ql3wNIox5bRLZDRsv5czm/LbYE+afLUBC879Oplwf3fEwo
	RWBnu7xDbVpevtC7QmAFrg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3xhrretqh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 16:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1713310901; bh=AYGegtnTN0TH7fUzqSEE6sYwxJENhDDAoO4MK6r9kpY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=ct5manT44qVs/8ySEaHMcNCM0hGen62mJ4oG1db312S1SmdxrG6pF01IKxM3sjYyd
	 u/98jpVJ0OqmR+EnQF2WQtsUOu00dmYQSB1QzKbMSppfyovtDknwoFQMesWfWms6y+
	 eSJjp3Te1CUDow2pgS2IBiWd9Ez819wZU0WbzTiISlnDXFvAU5nt5gwChMYRJ4Zz7a
	 hByqqLTbN5gL6ZxnXKgEzefqvycLgmLvC3LQHywyipkCE61jBTO0LUiVLcfvN65AY1
	 bsFzWjzpOpIKvhEF2pEbW99s+rZB21Mg9aKmafmKP59ylSTTeMwCcX9wsXJyhLFKoT
	 Vyfd5atWBFoQA==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EE8064035C;
	Tue, 16 Apr 2024 23:41:40 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 8CA3CA007B;
	Tue, 16 Apr 2024 23:41:40 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=t6cv4uUz;
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id DF82D404D0;
	Tue, 16 Apr 2024 23:41:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GaVqQtFOU2BGx82vwtX2shwe460kMJBeP0NbY3NCRptjUoZXp+HjJ5PUoNOgjfJqZ/BJiwuGTtbJccMSSXRw8WScOtQlbF6I6SuSxoyvgYevrGrRq4aBva6oO+kEzWs9Uzm44Z/4Oy9LeQ5CCsEdKHCyDxigVlxm7jhwad5xLJHHeuiMYckH2FuJtwx9WUHUI4QQXiY7EmWZxivPZ/Nxj7KhwKy3xnUsZ1cfyuZRusgcC+7oZgrOoacC/hn7QG0bL8ZesXQmhKV56/gXnv5y6c0CFNz5h1xYEadKoUfbTA2uoKB0aoHcQ+ZuvzqpZ9VsU5ni8j64FWAw+hxfAL1nVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cF5Q35pK7V0lkL8E7GXTpbxb78e42HJSbSxX0oneDjw=;
 b=LXbT1PcYee8Sb6lEnYZC+F56GOl12qaFx4jErpE9jmvkBvsrbbTCvFx4jqbQkpYpu4mzOB1xHvPmvSIDqqfOjF01zMt/yC3JNZphizDmiNK0bZ2O80wWY8KIoI6fyvrBm62XkUIGaOjMsE9XcjigFrb/T+3SM+px/kp/ckYr8TjBZCzwZSZ8u+scF+GkYXJ3EqsrOI4VkBr7EpMWijteTNmrAG35sNoD/BTpMfNpU8WDGn+4EB+YHH7MesEm98EAc+Q9DYRT3+krDKmisHlAuf+Iyu/+niI0NCg0Z6VBGTAMVRwmcMI39k+TDVuMxDUIDYXYqrB+1WAO2X6sLcjAtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cF5Q35pK7V0lkL8E7GXTpbxb78e42HJSbSxX0oneDjw=;
 b=t6cv4uUzij/0w39pPdwq7JQZRjdCjAtnjr0HUvRBVe9Vv2leks1EnD+7ZZ8X+smA13OTu5telqgwPF+2R6jaT4N7kURx9R/uASfjeBin2J0oGy/DiG9qBJT4eXjOXbdlgXB7oCE1SlmexbAHzbNMnuH3ZgF2nAzy/010qvQTm9I=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH7PR12MB7818.namprd12.prod.outlook.com (2603:10b6:510:269::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 23:41:36 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 23:41:36 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: John Youn <John.Youn@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 1/2] usb: xhci-plat: Don't include xhci.h
Thread-Topic: [PATCH 1/2] usb: xhci-plat: Don't include xhci.h
Thread-Index: AQHakFefIGBC2BgMlEODQAgnYv9WHQ==
Date: Tue, 16 Apr 2024 23:41:36 +0000
Message-ID: 
 <900465dc09f1c8e12c4df98d625b9985965951a8.1713310411.git.Thinh.Nguyen@synopsys.com>
References: <cover.1713310411.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1713310411.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH7PR12MB7818:EE_
x-ms-office365-filtering-correlation-id: 1975ab75-0463-4da2-e88c-08dc5e6ec186
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 C/sP3OkMb5pCwi0bJ6hIFA9U/yT3fgeqVnyfbNLevQUxapjWr3ze5lu0709S2LsxgvRPG0UFY6tpf6rcKR+wHjfnoZUFSON9s8MNlflw5p6e9DPDth+tXYMtTY0T+lqxtdTv4lBp23n608gNM8p8jf3OnluN7U5oyyW7o82Pi7C0Jq+KQIRquNM7PM1k6NfBiBZoKRI4CjZZM8KaJPiU2jUdSTByRl2vzwcU4YPOL2setosgxb56oKpjOcdp7A85S6Q6Lamgkcc5kg83/iEosWGdPtSQ/iTmUWhBwalKdmiqS69XISn849StxNOnAK6xM4fzyQaxAoP2Fr8weI5foPpGfpEj7uKQey9iGJ7BL35wXZ8aPUAB3vd0dO5WIxnE9P4K+iY9bZNtql9HunIqllID5GRF18yEoYHgiM2la7Qtj/VzhFeDeUkprXlFgXmsbyVzC0Nn1icw1moQrlHaFSKtbBUvI3ejc81WUFVI+sDU3A27vK4jKaksyphsFSeGH8qdf6Dh0Zxt9Xiujn1yDhSFFl+WPhJCbdTrnz6jrrIwqJh2N5YDkd17WGjy2TPZtYpyQrm4dLuD2FPy1ozAwsdg+unqI5VQ72PzNGHe/IpJaodYS8Rw94gUYFRlhtNrAqaUez8C2Jt3Dh5eZZh/MfBXpb5NSi2l3GMSpWSfDbTvCjy5+d/NVXJDUDhj/n1IObbhb9ywDq/KRNHJF0/sOKYPJqxIrmxEZrQYPeO9kqw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?fdi1j77X2Q0ZvJlEjvJ2+/0gLOXyDHe2aZjRRrTq5v5+4fHaKByWKXXaNJ?=
 =?iso-8859-1?Q?neacqZ3bnZGP/EcIIpHjDaPlNq2jhh5d7hYafsGVst1sgjWkL1QvyrMwui?=
 =?iso-8859-1?Q?z3mz2YjDGNJuZyzv3T6oZFzoe0E2JQX6FHfFgb+rDMgX3RzeEqLBp6Y5Ol?=
 =?iso-8859-1?Q?TdemxcBhdSA6VKLaXEpQcbZU55X1d9Jp0VR/Ubno4i+2FPB/fJCUO6CD3R?=
 =?iso-8859-1?Q?SSt9DdfarsSqNPTAjrEWHr0Py/y8F7pla5ZDhVh/FB4B33KBBSB/1HDTbm?=
 =?iso-8859-1?Q?qJ5nsNDGm8gi9WtgS+2wB7Qm3OOlO/RiYef3bvM5SXS63+W6ICEVb9eioH?=
 =?iso-8859-1?Q?Yj7SGinEKHgoL7ENLoVSHO+W5loJMohm+qKmFGoRSrn0m4iJUpdFZSF1J2?=
 =?iso-8859-1?Q?HbHvzxXBCcm2ifO0wYnnCuQtXtdoWH+QC08gOy2bQB4EXJMzNoaWQOgC+S?=
 =?iso-8859-1?Q?f98pKhmOauo5Ug2FSfwbskT466mgqx4wBwubNzXDEdG0cirISKcKNapDsZ?=
 =?iso-8859-1?Q?OWvw4aGJ9Kzc8kZqR8h8lYnRIRZ452OXc3p2Qhg7yVtcLRXVw5tk5ocNbU?=
 =?iso-8859-1?Q?q2Iw7boSs8UN7lXCagd+WALHwjZBB8TKCONzIpjJp5ORfXy5u7lBZiPbGJ?=
 =?iso-8859-1?Q?4AwfyZirATyNtLqsZF+34dn+wD937uIc8TakB/FK7G0LfW88vml710IWGm?=
 =?iso-8859-1?Q?wc+Fuv3hPbZPpwi6QZU5BvdnU6wLrHlB9CzHkfKvWjz2ELUg9nFuax2oac?=
 =?iso-8859-1?Q?saKtEYgzfyASNmtmonv69gekUJdN7uyI23wPFuOYOxo/qyuIxB+O42aQrM?=
 =?iso-8859-1?Q?l0vrgRcTIZ94r+OHk+D4jnFw9xA426THw+j7VoT8FI6FZlglB4jMhrT0Ig?=
 =?iso-8859-1?Q?OON1t9xOsTmyqFSZ1lu7/fvDBvl7ADar6atPC17mWGrQWlR53cNCVm84By?=
 =?iso-8859-1?Q?68NwGKu1WHterN565DtwoiA7lVLDpv7qe8O2O6IRVkEmnDd9bKe2xPJLy/?=
 =?iso-8859-1?Q?4/Pwkw/Q7SG0V4QexR2zjeyZLuvbXMO2AOB4x1sV7KGIRya9z/+cpqwiQw?=
 =?iso-8859-1?Q?D3yG1DpK2R28i3Xf0MB1Re+bWCvodI+dnmK2DB05gfaCLcfHzC/m1HLh2Y?=
 =?iso-8859-1?Q?AF2A7GPYdIF49ZnZzLlv/QtZOzQuctAb7YD/CXB5rkUUIlDiGcFbXE5XNR?=
 =?iso-8859-1?Q?F2aR4dB8AgVZPMVJFgAKOYg//Ir7aIKMmhvVxlGSV0VNsLaUuYcXMtmCqs?=
 =?iso-8859-1?Q?5uV7xYNRnmnsY2oqbmPKI8nI61pTmV8XEvJivx4ZJKYcALvq9LnFRSnHN2?=
 =?iso-8859-1?Q?kjqxdlk6jmtK9FEFTw5oKJ1kXjk7Ni4aubrR1hcnOtK0s9QVfQElg19lfV?=
 =?iso-8859-1?Q?jhU4F95AIu7SHvDKXaGzX8BJhv7ho9EjLO4eE2Zp6QwW++SuZ0GdJIadtg?=
 =?iso-8859-1?Q?nDdkJb+4yCZtip4WksEgbQah8LNpdjvWSW/p5D4PatLEExQ9rCNGKi/8VE?=
 =?iso-8859-1?Q?7d101yZ3QnsJMUILg0euaSlyWqZ0h432Zp2ehNcYM3XZVN9a7wcKcss7op?=
 =?iso-8859-1?Q?YfjxwP41q0NamaPZeKhFrgr0Vo9WtoP1X2EO9DG59KKaXGd1pCmwqsr2f9?=
 =?iso-8859-1?Q?+n6Hk591anpnaLonoKG1bDwOkWyLA4FROh?=
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
	C681fJV+446lHoRBT90otgRlnsB2g4BFSmJhp/SXQ0k0iksrn+Gu1c+6ts3yXL2AqJ1m+oc5RxqRh4nktanseEfujgQGoz2QHjY8rQhqp81kau5Z+SvBWU35cQXH9AdRMcfJGzdfziS21LopHidFl+BwoxYAO0/PMMbmsTrOrW246Co/xgUzDsdCJ8ORfS1dRSKOirZiCxuUDh9RmWqfMyQ90NAIaXSryDR6WhahmY4CiTSN8RUbx3vS+bY1EqM3gvyv9LDcsnC4rCCkw/HNY0V5cyVJ5Eq8HQCc+Bc47DuI4YejQp4xDB27jkDttnpuEQxJZ7+Obp1tUsFo0KOa+xutHVU2sWaRwUXY1rBqgaxtF0ypRya1SI/9o4uR1wRCtO5doG5p2P2AeypQFhbL8c3S//u+BOb5x90Alq5RS3iJxDr+BYLQeRtfOUKYwLsMj233TA3Vy9KhrUvjzrO5YMFubeEFfNZ6kLpbXyMxa6gGIFEYzfiSrL/Bgc1jf74HesNjFFEWJZZgzk222Rbt8ff+zQFNDn5mg56bK5Dzd6Fqa9sXfgoPxUpSrSjWKs40JQ11KSozkmfOug2mgkAoFKWNQOkoPh38T7bEISxic76tiSstqWsfI9JNb+pBqztqCs1VNclz/R1v3m2HcBNyiQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1975ab75-0463-4da2-e88c-08dc5e6ec186
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 23:41:36.5541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HbVhOLnR4fuJX5xIQYFb9nNMF68Lj6INj9gAfxRXFteRf2s456+XZxipa7VbHx8gOugaUBwjvX3DkUeFmfq98w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7818
X-Proofpoint-ORIG-GUID: ttak3DOwTmjwO0cjHu62C-cjXuhnN4rq
X-Proofpoint-GUID: ttak3DOwTmjwO0cjHu62C-cjXuhnN4rq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_18,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 suspectscore=0 mlxscore=0 impostorscore=0 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404160155

The xhci_plat.h should not need to include the entire xhci.h header.
This can cause redefinition in dwc3 if it selectively includes some xHCI
definitions. This is a prerequisite change for a fix to disable suspend
during initialization for dwc3.

Cc: stable@vger.kernel.org
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 drivers/usb/host/xhci-plat.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-plat.h b/drivers/usb/host/xhci-plat.h
index 2d15386f2c50..6475130eac4b 100644
--- a/drivers/usb/host/xhci-plat.h
+++ b/drivers/usb/host/xhci-plat.h
@@ -8,7 +8,9 @@
 #ifndef _XHCI_PLAT_H
 #define _XHCI_PLAT_H
=20
-#include "xhci.h"	/* for hcd_to_xhci() */
+struct device;
+struct platform_device;
+struct usb_hcd;
=20
 struct xhci_plat_priv {
 	const char *firmware_name;
--=20
2.28.0

