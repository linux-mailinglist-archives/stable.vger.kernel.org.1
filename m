Return-Path: <stable+bounces-8350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA7581CFAD
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 23:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83CE5285784
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 22:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302FD2F84C;
	Fri, 22 Dec 2023 22:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="J0JtDF75";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="d3McN1nz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gAXp2XKP"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B792EB14;
	Fri, 22 Dec 2023 22:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BMK4jsk032659;
	Fri, 22 Dec 2023 14:11:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=EeYVhC+5avoKmOCAWnWlk9nAmDFba9xx6c/2Cnoqkcw=; b=
	J0JtDF75Lk0TcqLPnLtjL+skKwvBW7sZurVM8ncjZvNKZYk/u2eC7qsSIbtXWgga
	RW18Qy7YbNlTyRXdjLbWFzLaEe1cKnzOiOalkemofFgOvdooSOPF4oYtaTHD8BwQ
	8xWmzF3hyExcCiMEtuDY/R8AraLUp12xY4CAndLh9mY1dG4I+ck3wvRhvD2zCsjv
	7TcvxUXbxn9ErRONltldi5CPy8WFWxMC7pT1sBwRBAFjaE1fM7hwMrrQ6tt2/LDj
	+PwRU7Sr6PAB6ebhKxPSPAAnG12aOy5ymF8ayDPWg/lRNuEkFJdCtbJYociVEE2V
	nUSpi/Qaf4YE1HlkRiFqEQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3v5gpw0dus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 14:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1703283091; bh=EeYVhC+5avoKmOCAWnWlk9nAmDFba9xx6c/2Cnoqkcw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=d3McN1nzSCKBI4vZwDryZMbBMSIms5R04NavIThGp3DKx0dEUTlaLn2/FF3+tkBqv
	 gech659ghcdXjoRlxls2g8+faM7PV337j/EWYDBXPpTq2mZGmBx/+hKb/7pg0Dg4O/
	 8HYbqatG1MgQMpGSss7BPR9NKl+8l33pIwMY0qbprY/Gd/cv8tOu3p+S2WWMRtMPFn
	 7Hzl0v0165ZMvzsC7X+PxESaQPolb/ZtAjUAPl7wVxsxgBCTF1pRHdidShAQXVc1HV
	 x1XQwhzDpUgCnirXJFjX6ZxXxirDknAh4bB76Lg0mr40LLS3w5Avf07/wkubET2vIf
	 F5VMNLOF9YphA==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 61AC140542;
	Fri, 22 Dec 2023 22:11:31 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 2B9C7A0073;
	Fri, 22 Dec 2023 22:11:31 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=gAXp2XKP;
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0426E40363;
	Fri, 22 Dec 2023 22:11:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSeFyVyZzEWz6yAehVBP7F08dtLx/3DbyUfNrqslMS0XCiXRdnYmfA74KAkJDMtMUJzKCFjhe9kFI55DzGIENYUggt6fCUAPZBUaBrDuM0FvI9+vfA/NoEgK4yQ5FfPdJxHpgc74Vcht/rLZCIixfyMJl7q+8lWZE6WkQfQaM+ja6ikOvKXMTi3CLcxS6GI2UzBHMBxkSfE2BNnnKCoqwje4b0Sp6ZzZF9OtE/pZvZBI0h/VBhhiegA+d5Vw22HvJ7xXZAOk8lhVs4FFS6edUv9hf1HHdT6M/ExiVzfnEiYb5gy2A8+e8NK0HvDYQj3LJcA4q5WKMPG69CPbF7ajnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeYVhC+5avoKmOCAWnWlk9nAmDFba9xx6c/2Cnoqkcw=;
 b=J9x7L7mQVMW/Qf18Q6/kt5Mh1KHCOGvSeLM/0w0yUMO4mwbnhE+6x9wsipcjyd0EIqwm23S4HuTLLEv4V1MQsOR+r1MTBOGAn+Pf7nu0nT9WPYS8dUbObjqcyN3Gj4FXXinyvDiFCdOf4jMAWbN0FM1NaDUz/Vcl7jfGJ2wf3QpdhilTOdenpQUd+MIPb5Lk/QmpyG9EWwsQGtYGcxDLdlPzGnuZkdUzyd/r8T1tkZ7YT9ufec05qeccuVBIo6NhnDugD4f6auw87Hw0bfGR5F+ClzMaeWqF3EkI1wi/DPx0mQt7tvo1JbKDmWkscW7+d0inYyFBTsKPNtmqeDsUoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeYVhC+5avoKmOCAWnWlk9nAmDFba9xx6c/2Cnoqkcw=;
 b=gAXp2XKPIbrq6DraMGw75iv8NvNMoYiifrnTHFGDusejYh/liTSe/fJ1Tag2EWR63OLZnU5P63mplS/nXNlirIi5E9mIJ43uG905aHhvgIkymKeN5hLeQ+VF1x04+ipnuNOahN5hw7QjuaeNVu6jvk1etJSSnESL48A27FamDhc=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DS7PR12MB5982.namprd12.prod.outlook.com (2603:10b6:8:7d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 22:11:27 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::d931:a262:ec3b:3e56]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::d931:a262:ec3b:3e56%4]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 22:11:27 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: John Youn <John.Youn@synopsys.com>,
        =?utf-8?B?S8O2cnkgTWFpbmNlbnQ=?= <kory.maincent@bootlin.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Kenta Sato <tosainu.maple@gmail.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: [PATCH 1/2] Revert "usb: dwc3: Soft reset phy on probe for host"
Thread-Topic: [PATCH 1/2] Revert "usb: dwc3: Soft reset phy on probe for host"
Thread-Index: AQHaNSPPlaq423qkj0iUa62ZUsn8ow==
Date: Fri, 22 Dec 2023 22:11:27 +0000
Message-ID: 
 <29a26593a60eba727de872a3e580a674807b3339.1703282469.git.Thinh.Nguyen@synopsys.com>
References: <cover.1703282469.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1703282469.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DS7PR12MB5982:EE_
x-ms-office365-filtering-correlation-id: 451f5c3a-00d8-461a-10df-08dc033af183
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 JOv4t6Y+Eh+wI3LZ1+lOw+CtEDCHZBRHYMCQZQainld/bKFBWlqeO9wlvHUduJBBJ+cagdElIhulnZ4lsdEaD0uePuYpPzNdc8fC0qZJxKsWhzmsgPGFCZDlr2dRhFtm9ZVxSYPD4dd9IQ0PfxLkweOyfSxOwbq9b2llHJ11Fm8SClBESGOz5AbtZYy+cnP8C9UY2kj3CsYxB9vWnwco7y43I6yiML+9e0qpyXBbIslWBTWEDtzkzVgr8FI9la5xzB6pqOcp52PwypXRtLxUIYcaLOEMWJDjVtAIajXapKsZVv5fIlw5+GZNIooh09eHKwnJgw/sXekkFMrp57+p4qqndfpliUTeSY/YJ6aIs6OEOq3f+X5X2Xqc+aVFo4QeSZoMlwXXqIKuviq5WnYuYuqtkPBVLN0E791Vkd5CFgciAv6EpAv8NlcsKDxqwwBNctjm53kXJNT20kB+JWpUhVqCS65xFj8RwDrG7PP5f3AnGcK1LBcZPhqElJ8s57ib4JgBtFcJdaClHD6W+dkkxsUAoOvL7wKNhwXFegpZZmWCzPujtUjhp9ETcG4gU/E3w54hxzTDCdsslYZ1VfMtdOY60sJcwsTMN9qK0LYpNUY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(366004)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(86362001)(2906002)(5660300002)(4326008)(8936002)(54906003)(8676002)(41300700001)(38070700009)(66574015)(83380400001)(26005)(2616005)(36756003)(122000001)(71200400001)(6486002)(38100700002)(316002)(76116006)(66556008)(66946007)(66476007)(110136005)(66446008)(64756008)(6506007)(966005)(6512007)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NFhkOTJsSU43M1JManJwS083VXB1Wk91S2FLc2gvL0NGbG5BZVUvNlpCY2hp?=
 =?utf-8?B?ZjJnNHVybSszSTBKVWVYTUQxVFByOXBndm5oeTkxVzFoZkFpamgvcm51SnlH?=
 =?utf-8?B?Q0VjaEtlR1RBMmRzRGxjL3VSNlY4YmJRY29vZzYrYUxSaWViTjF3Y3FyQWRq?=
 =?utf-8?B?YldQU3B3dXVvM083bDllYzVJanJ6ME9PNlAyTWtiWGo2eTF2djBFbnV4ajlI?=
 =?utf-8?B?QncxR2NkblBON3FSTUV6M0NwT0tROGJydVJ3a1VXTkhQcDJBbjN2WnlEd01v?=
 =?utf-8?B?RkdnUi9IOHJSZlpadWNRRDEzWml5c0RXZEFTVFUzK3dKR0E0bG4rMUQ0c2xt?=
 =?utf-8?B?QXNwVktMZmRWNVB6ODcyN0RJSXNsT0U4WlptWDgvWi83cnlQeFY1UGFKcHZx?=
 =?utf-8?B?M05iR2N0eTBKVzBBWWNCcVNYckxZT0pOSXNPcHQxU1ZXbmh5OXJkWGRXUWZu?=
 =?utf-8?B?OVZlSk1wdDZWZmdiZ3Exbkk3YytSR21HYVoxU0s0ak1xYmpkb280cEQ4Wk1z?=
 =?utf-8?B?MENIdWdsaXkvSExkVXVwNjdtcDM4RjNRSmpSQ002NlNESmlEbFNyQ0JKSkFw?=
 =?utf-8?B?cmFNaE9vdFlmMStpN0RObGRMcnd1bE9oZ1FTRFFiVjQ0YmErVDgvcFU2ZFM2?=
 =?utf-8?B?T3FlMDdTREltZmVDTjA0RWVsdVg5T2RYaFNKYUJBWGNsQkJkUjZjbnhsT3hZ?=
 =?utf-8?B?MjlEMjdzYWs0ZjhVczFJYUc2Vnh6OC84bkdKazE0VkNHdGhac0tPNnJaTG9V?=
 =?utf-8?B?OWQ3L1JFblFmaG9IUFZkSnlaaFpFeHptaFdmUzNBSGZJc1MycnZxQ0hnNFZO?=
 =?utf-8?B?S1ZSUXJieW82RUh4YTdGeE9NRHpnNCtTd3BtWkJXZUZ3cUtrM2hwbVZub0R2?=
 =?utf-8?B?djcwMjV1dko5RENKaUlUWHVSeHVyV0IzQ0FtanFIbjhWMUN0bUhWU1lCNlM0?=
 =?utf-8?B?MkJLbnZPWVdyd2Q0aWZSZ09pRnZRTVJjeWpaTzZrZUMwYzlYSU51elBaTXJQ?=
 =?utf-8?B?K3lNOVNRLzJYVWp6UjRiOGxoeGpRR2JMYzV3ZXEvZEZkMFVnKzBoOXRqeGd2?=
 =?utf-8?B?amhxT3VSTnFNTEkzV1JzbmVXOUgrRmQxcm51REd5alpveTRDaWV0Q1pxUi9r?=
 =?utf-8?B?ZnJuQy8zZEFwcHRRTDUzb2s4UTBzalBKcVN4OVhob2FjdkxTbnMxWWFwNHd0?=
 =?utf-8?B?bGZob1haZGNYa3dSa0w1ZlFoRE5qL1dEclZEV0M5WHVxMUNlZ1BRUWZoaU5w?=
 =?utf-8?B?Vm5nSEZuWkdYVE9nUlNic2doMEoxeEttaVVCRzMzQjdUOFlUMGkrbGFkN0dB?=
 =?utf-8?B?cS9odlhXc1FsaFV4WG9QcmdCT1kwTWw3ak5jWGVZL1d0QklHaGM4R1A2RkZF?=
 =?utf-8?B?dk15QXFCSWZiRC9NSVVJdGs3ZjRyR3NLd2phOWZMN1BCb0JSRlk2OTBvYm8w?=
 =?utf-8?B?THZ1S0ZJcCtUV21yRzBpWklJTXMzWHlncHdzTnlUM0E0MDBoVEc0T3ZYMzVk?=
 =?utf-8?B?blBZRGpUQ01XRVpQZDBITStHYlE2WjQzdnBGSkxYREY4V1FjUG1XNEdyM1lL?=
 =?utf-8?B?QzJHYk9nZVFxMnRkbWx4aDZpVk9xSzkrSFVSQllONytLZUNaY0p6ZklweHRQ?=
 =?utf-8?B?dEg0VkxuN0pnTjk5a3FRTktDQSt0M055SlVvMzNBbXVvdjFKMjhhYk12N25Z?=
 =?utf-8?B?WWhMVHJJcnB4T24rcFZCQ0FwTzd3clFzcGFRUnRzM0FHb3ZmSnFFZHRrOWJk?=
 =?utf-8?B?RThlVi9SajlnREhJL1pTc2ZCM2dxOE5iT3phQ3lPZk1Ja3pWU1pOYXFreUd3?=
 =?utf-8?B?TjR6bjMyWmhvd1lrR3VrL3cxclhQbkN0eW1mZHlqRmxZdFMrbzF6VUg1Ti9D?=
 =?utf-8?B?VERDV09Na21YQm45QitzQnBHY2RlZWkyWEpHRXkyRGRzK29RMm9JNzllcGFW?=
 =?utf-8?B?ZnpxM1phWWQyTkMzdkxzV2JaUWx2N0J1Tm1IR0xKK2V4VWk2dkljZTRoQXlu?=
 =?utf-8?B?Wk1vaWJjTmpaM0lHU1RyTTg3L2hxeUFjVGdhZVNjZnRuTFlFK2lxWE9LcHkw?=
 =?utf-8?B?eDh3ZHhuZExEb2I3SVhqeW44VFcyd1h3dmZvY2l3elNHL3FGQXlJV0RCdEZ5?=
 =?utf-8?Q?F2fVFC4SKGLERkdGBjYXA4cSj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <600D4DC898775743A93CE96EA2B57B4C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qOR/WdgIszmuB2ORdn9Xu7MD39iBNKp8m+CZcX4irxg+0bCe4uxGAprPbogDRXQVnKoWvjzmTWV2JBbMpyBXfPqJxQb2ySzfDv6WZNLlKumRdSqnklZ4cx+nBzbwqt2bm4H3uqMsRIFAXTpxrj3Vv6Vl/ciJOsD77ascQCqL3wctqoxYHa0awnCVSTXM9Ud67F2QzaZZKPt1rmabujIDtPhhC6a6CSmkXqdT2r5tgOchE4hCW6/Uw+wiAthcD5C3G1rgN2gD46I6R40i3iTAbGo6POFf9mez9b9iPbSG7W2q1Jvtj/J7bSXvV4JgtKYnlbuOrkWY+0kf9Dkx22JM4Wp4lH+Nog0kCdJJuEtOmBOcwGGBy7jc47Y77YqP9Cl2fmVe2f7E9qFI9r9eOrZ2rONpcEtY0UmASA+5JAgHL1tHvbZZeyBwakmJ6ew1Ds6RHC8zapaa8dJGJ1xnE3xeUlw2yroCaE/CXWyK7nERY3pQvcv9BNTGNMu0U335t9GMvrMRzQU49g7hZATBVnG2OezEMxYcbirDhNnPh/KIr81gt9xCjUeXupbHVF4SxAXjhC9uKFGkHFYilLicTQeOdYi1YcwKzQ9hndbKzkxrElBqY5W9savw6zcGrbgvd2tMhxeclRvXX7mrGfIsU3VdPQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 451f5c3a-00d8-461a-10df-08dc033af183
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2023 22:11:27.4459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: juqvwN+MBL2bRS8NUNlvBrW2044omgT/s3rOOgIfDBOHcjW/ZZW9nmJw6gyRojIxeZGQdsJY4Z05ofrp22u9oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5982
X-Proofpoint-GUID: BV7LyiMkQ93BuKqahkyRsrJOMt5aarK6
X-Proofpoint-ORIG-GUID: BV7LyiMkQ93BuKqahkyRsrJOMt5aarK6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312220163

VGhpcyByZXZlcnRzIGNvbW1pdCA4YmVhMTQ3ZGZkZjgyM2VhYThkM2JhZWNjYzdhZWIwNDFiNDE5
NDRiLg0KDQpUaGUgcGh5IHNvZnQgcmVzZXQgR1VTQjJQSFlDRkcuUEhZU09GVFJTVCBvbmx5IGFw
cGxpZXMgdG8gVVRNSSBwaHksIG5vdA0KVUxQSS4gVGhpcyBmaXggaXMgaW5jb21wbGV0ZS4NCg0K
Q2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCkZpeGVzOiA4YmVhMTQ3ZGZkZjggKCJ1c2I6IGR3
YzM6IFNvZnQgcmVzZXQgcGh5IG9uIHByb2JlIGZvciBob3N0IikNClJlcG9ydGVkLWJ5OiBLw7Zy
eSBNYWluY2VudCA8a29yeS5tYWluY2VudEBib290bGluLmNvbT4NCkNsb3NlczogaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGludXgtdXNiLzIwMjMxMjA1MTUxOTU5LjUyMzZjMjMxQGttYWluY2Vu
dC1YUFMtMTMtNzM5MA0KU2lnbmVkLW9mZi1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5A
c3lub3BzeXMuY29tPg0KLS0tDQogZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgfCAzOSArLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDM4IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdj
My9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KaW5kZXggYjEwMWRiZjhjNWRjLi44
MzJjNDFmZWM0ZjcgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KKysrIGIv
ZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCkBAIC0yNzksNDYgKzI3OSw5IEBAIGludCBkd2MzX2Nv
cmVfc29mdF9yZXNldChzdHJ1Y3QgZHdjMyAqZHdjKQ0KIAkgKiBYSENJIGRyaXZlciB3aWxsIHJl
c2V0IHRoZSBob3N0IGJsb2NrLiBJZiBkd2MzIHdhcyBjb25maWd1cmVkIGZvcg0KIAkgKiBob3N0
LW9ubHkgbW9kZSBvciBjdXJyZW50IHJvbGUgaXMgaG9zdCwgdGhlbiB3ZSBjYW4gcmV0dXJuIGVh
cmx5Lg0KIAkgKi8NCi0JaWYgKGR3Yy0+Y3VycmVudF9kcl9yb2xlID09IERXQzNfR0NUTF9QUlRD
QVBfSE9TVCkNCisJaWYgKGR3Yy0+ZHJfbW9kZSA9PSBVU0JfRFJfTU9ERV9IT1NUIHx8IGR3Yy0+
Y3VycmVudF9kcl9yb2xlID09IERXQzNfR0NUTF9QUlRDQVBfSE9TVCkNCiAJCXJldHVybiAwOw0K
IA0KLQkvKg0KLQkgKiBJZiB0aGUgZHJfbW9kZSBpcyBob3N0IGFuZCB0aGUgZHdjLT5jdXJyZW50
X2RyX3JvbGUgaXMgbm90IHRoZQ0KLQkgKiBjb3JyZXNwb25kaW5nIERXQzNfR0NUTF9QUlRDQVBf
SE9TVCwgdGhlbiB0aGUgZHdjM19jb3JlX2luaXRfbW9kZQ0KLQkgKiBpc24ndCBleGVjdXRlZCB5
ZXQuIEVuc3VyZSB0aGUgcGh5IGlzIHJlYWR5IGJlZm9yZSB0aGUgY29udHJvbGxlcg0KLQkgKiB1
cGRhdGVzIHRoZSBHQ1RMLlBSVENBUERJUiBvciBvdGhlciBzZXR0aW5ncyBieSBzb2Z0LXJlc2V0
dGluZw0KLQkgKiB0aGUgcGh5Lg0KLQkgKg0KLQkgKiBOb3RlOiBHVVNCM1BJUEVDVExbbl0gYW5k
IEdVU0IyUEhZQ0ZHW25dIGFyZSBwb3J0IHNldHRpbmdzIHdoZXJlIG4NCi0JICogaXMgcG9ydCBp
bmRleC4gSWYgdGhpcyBpcyBhIG11bHRpcG9ydCBob3N0LCB0aGVuIHdlIG5lZWQgdG8gcmVzZXQN
Ci0JICogYWxsIGFjdGl2ZSBwb3J0cy4NCi0JICovDQotCWlmIChkd2MtPmRyX21vZGUgPT0gVVNC
X0RSX01PREVfSE9TVCkgew0KLQkJdTMyIHVzYjNfcG9ydDsNCi0JCXUzMiB1c2IyX3BvcnQ7DQot
DQotCQl1c2IzX3BvcnQgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywgRFdDM19HVVNCM1BJUEVDVEwo
MCkpOw0KLQkJdXNiM19wb3J0IHw9IERXQzNfR1VTQjNQSVBFQ1RMX1BIWVNPRlRSU1Q7DQotCQlk
d2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR1VTQjNQSVBFQ1RMKDApLCB1c2IzX3BvcnQpOw0K
LQ0KLQkJdXNiMl9wb3J0ID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfR1VTQjJQSFlDRkco
MCkpOw0KLQkJdXNiMl9wb3J0IHw9IERXQzNfR1VTQjJQSFlDRkdfUEhZU09GVFJTVDsNCi0JCWR3
YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HVVNCMlBIWUNGRygwKSwgdXNiMl9wb3J0KTsNCi0N
Ci0JCS8qIFNtYWxsIGRlbGF5IGZvciBwaHkgcmVzZXQgYXNzZXJ0aW9uICovDQotCQl1c2xlZXBf
cmFuZ2UoMTAwMCwgMjAwMCk7DQotDQotCQl1c2IzX3BvcnQgJj0gfkRXQzNfR1VTQjNQSVBFQ1RM
X1BIWVNPRlRSU1Q7DQotCQlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR1VTQjNQSVBFQ1RM
KDApLCB1c2IzX3BvcnQpOw0KLQ0KLQkJdXNiMl9wb3J0ICY9IH5EV0MzX0dVU0IyUEhZQ0ZHX1BI
WVNPRlRSU1Q7DQotCQlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR1VTQjJQSFlDRkcoMCks
IHVzYjJfcG9ydCk7DQotDQotCQkvKiBXYWl0IGZvciBjbG9jayBzeW5jaHJvbml6YXRpb24gKi8N
Ci0JCW1zbGVlcCg1MCk7DQotCQlyZXR1cm4gMDsNCi0JfQ0KLQ0KIAlyZWcgPSBkd2MzX3JlYWRs
KGR3Yy0+cmVncywgRFdDM19EQ1RMKTsNCiAJcmVnIHw9IERXQzNfRENUTF9DU0ZUUlNUOw0KIAly
ZWcgJj0gfkRXQzNfRENUTF9SVU5fU1RPUDsNCi0tIA0KMi4yOC4wDQo=

