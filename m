Return-Path: <stable+bounces-40123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76018A8D6E
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 23:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC99FB21886
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 21:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E27481B1;
	Wed, 17 Apr 2024 21:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="A/kovbHz";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DxMTZN5i";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Fx1wPhzI"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BC211CA0;
	Wed, 17 Apr 2024 21:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713387727; cv=fail; b=MdITCQpO800xUbJlq+7MrdxLLVTCDzhYwTgPG6SzNaSTntoD6wast5UrZaEAXg2l5d+lRxm24LBAvAONprFsTt3iEmLgCVoL3mFixhKusNX3CSsvC1gEUJb/VfFoKhfzzNlQVG6L3Hevue2qeEmwG2hcA7PVBJFDYo3yKfXUNbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713387727; c=relaxed/simple;
	bh=tWJ28kcJgau2wcqdG1mScMcAkbC9Ww7AGUlnXbJeTOA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N92kWWIqH+GO5Utk/gogDyrOEe9AI4Ov/hcAlz1yuzACay9Tlj+I+KlGn8r7DAQImvdPjrLXO6pEcUbLWFFBO7TtQ5YCMYrguJAR0AB3w1ejvBIrGr4qKOpH2KCX5cofzTx2/LfRt8PSZ2ehX9LLXNEOKu+wckL7nKXm3dnWs0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=A/kovbHz; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=DxMTZN5i; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Fx1wPhzI reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43HG6Sow001283;
	Wed, 17 Apr 2024 14:02:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=tWJ28kcJgau2wcqdG1mScMcAkbC9Ww7AGUlnXbJeTOA=; b=
	A/kovbHzvOvq/fMqsIJ6DPdguSy0F1FA/yN5M8EH/M6k1/UE8SSm0lAJ9v9pJ5gt
	OLcmu4Ee89VTaw6Cd3FZWXVm0lHLbgb3v2O+dwo15aVzu9uS1MdnCPwTxHaaPpuD
	2ASw1EufgaqonHV0WXF05d6QGP/xWsU7pRofZKJ4I+hd8jSaG34zYX19Z8JnFOOf
	3rEkB7K3l72neEc01FGxa7orLNCBfG5abnVOeoMpOtnOyP2Ce66cPH0aQfZzro6n
	E4SEfwQinpParNEJMVemL7OILuVCLzldOH/tkZSHTLvsU/f/BCc9jTMc2qovWyPM
	amKXB1ACM5EifsWVJZq7gQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3xjgkshr8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 14:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1713387722; bh=tWJ28kcJgau2wcqdG1mScMcAkbC9Ww7AGUlnXbJeTOA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=DxMTZN5iAjW/loHgkiklJ1Dn2LmAM8ZtogYyN2sWcaUJIMUHNLb3pkzkUefmEzeRH
	 3G+5rfCNbHx5i1WJmBDXUEkrwKTk4rZtjidNVCzw6GfYEMea0LkM8j5POfDBNaEwYs
	 EFX3GYqBnGfxeiHB/sYt4U3whjRnUaR2QvRXf7QJ9bT2MCKZsurFiGSD0mpYGWP9iy
	 qzMJk+HhTjfGTe3OoLvaGoRmwd6+pWBBAF7pOWiuNaDunjSYFsNG3OfBgYB5e0VQi4
	 I/RPEM8zx9zfjo0N4NBS3D4AEbHIglysSxCg3w0e98HrbOjSO17UZHMGhWsRFX58Fg
	 pmm2T7GTTBGPg==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BF0124048E;
	Wed, 17 Apr 2024 21:02:01 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 65F19A0256;
	Wed, 17 Apr 2024 21:02:01 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Fx1wPhzI;
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id ECA6F4035C;
	Wed, 17 Apr 2024 21:02:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPUDjXWAJDFIEnKZVplqPj2evSRihIeBzb7F2Czp0M84CvF7TDjp5V6DuVjhIjYDAk35YvpkC1Mwb5gXJ7F3K3m9wPcvevjU21mXPj6mf08rXkhWAtknU057NptJs93wPKFbpsECh6JWzTqf/bLTMumPxo8sQVRyBotsybYfDh5QeW01ZPZvQ7aOzrxDwhCLVJ+p76gW43UxRnOIHoMYa6jpgxrjR0pCUw+GgcugQMKc4lQlrWM4nDfqtqhDAZrS9vPJvVK5V/bc9CzoeJm4BweYbgFVoxVXrBZbkc+i69MLPp0cSDrhsaR8u8HGMHfDz5lgg/WK3eXB0f6Wt8lSyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWJ28kcJgau2wcqdG1mScMcAkbC9Ww7AGUlnXbJeTOA=;
 b=mwjI9MlRqSL+CMEvIcfzqq71RnJr0dPcDx/ig3+jbiqBmzbWZr3Jy3hZP9IqBeGuFQWJZ+vKJMRNx5DfO1/NYghj2wrCCB47upLUhTlsMchsBfLarDeeUFIh/D/EVox2pI0cK2DjpRqO3rQgHNSOddtSfFsy5h9jL/5R9dxA+axczVNTcPW2upUoDDv+45IHEbfURUgWSlJQKMpbxDUgCtMue4uVt/b6/jIDv5yeySClTONNCT31iYpP7W/yYQiG46cCSH+wulNFIxwfOgzL+82naFM/SvP5GqLulWRIHVCiCfwKNYsUH5/I0ZttM4CF6bRAej+IA8GETXAZ/YjZiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWJ28kcJgau2wcqdG1mScMcAkbC9Ww7AGUlnXbJeTOA=;
 b=Fx1wPhzIC/xryP5dpatjw1XweV/XLJyGCHpRFgsc4Simynd9SVv9i3+gVBStCP9WTK1+u383bq3AjJCXbJTNHlbO/+/qyrksFVcafztZg/RWvdktTqqeKGvPQEAzczE8q6F5FsKb6odeZNtrscKpd/ZpnrfEZkNgeAssriLaDPI=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 21:01:57 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d%7]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 21:01:57 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        John Youn <John.Youn@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] usb: xhci-plat: Don't include xhci.h
Thread-Topic: [PATCH 1/2] usb: xhci-plat: Don't include xhci.h
Thread-Index: AQHakFefIGBC2BgMlEODQAgnYv9WHbFsTpgAgAClrYA=
Date: Wed, 17 Apr 2024 21:01:57 +0000
Message-ID: <20240417210155.z2jfydu2ezkss6vt@synopsys.com>
References: <cover.1713310411.git.Thinh.Nguyen@synopsys.com>
 <900465dc09f1c8e12c4df98d625b9985965951a8.1713310411.git.Thinh.Nguyen@synopsys.com>
 <2024041749-cheese-schedule-d21b@gregkh>
In-Reply-To: <2024041749-cheese-schedule-d21b@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DM6PR12MB4124:EE_
x-ms-office365-filtering-correlation-id: 88bd9ed0-19aa-46ba-71bf-08dc5f219e44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 jphvlONNVs3eUiUfaFZTZB+yC8rxbICh00pI/pTF36Nrt7V+JWdfQErk2dgFpjnXuUb0oILzsah6N7lzgrJBZWKj1RwIbatXIKa5AwGECErALgFLrrkqcOd5ocpASuP8PN9HyY/+bjKQnPUL7K3pVefLhyhNyoBjxNK+4EayNhBEp5VW1cec6aVrP6TEWHSLLhKeUhDfzZXWWSVHcqmqenNVHVr+/yjRVbZrH9sTtnN4STVSmBpx04OG+CVNiRH8OK03hFisJoBgidVx1p4731cUdVI1GRRkmZQSHkRlyUhZHAj6oFmNBBoUOBNEZmxUAUew6cYFOJEQ8fO6n306G79Sk0FBFnpSK5pnKaZWuo4SnJ/aQgvLqlpW8CSROtChZTKewetNPoiUszFe6wFM2Da/NeRSYNn3IKeb9Pf2ADo9vTJKbJ6XY09qooGdAQDyCxq5NllLtiNC+oQzE5cK7j/L/MJdSUkpm5T1wSzR/s2kvMQkDPCHjLpyC8NlNqlS0ec9CZkaFx4oRKetL5xTOPRUMNhAhMw/k5lGAAsRammXLbcNuwUtRA+ukNcW+pww9zWaNbuLIVjvvuR0mKtEL4V1/ki5rcnS9l3cPjNNbInoX/GMkhzJmNEghvQfUVHZS7fLbKrnUhJlwFSqd1JYcp9qJywFk1Wb2CUQxNZHF/Dfg7y4iN5WjZi7OwRS0cy9T2ncBuBO3zURamr8LYKQr8AtzNuBrNl1OhXYYFYNhBM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?K1ZlaUFRTG1SdVRnOUt4cHNpNmFnbDBuaTZUWXlLTWpWb0lMdngzbnlzdnVi?=
 =?utf-8?B?cmp2dm5wdkhLK2NFelRSSVF6YWZSR3IxK2FJZTcxTWtLZkxGSGpKZEtERDN4?=
 =?utf-8?B?RE1RVlBEN2pONFNjcjN5TUJrRk8wbWovOWJxczltdjk4VUF2Qk9BeVZzMVpB?=
 =?utf-8?B?cis5YVpXc3NwVm1ka0cvU00zdlBFUzUzK1JMSUhmaFJFL21vZG9HZmtMQlBm?=
 =?utf-8?B?MkN6Tlpmc0tyNDh1N3RuRmUzbURsMjNQa2wrZTB4Ky9PTDFHa0ZyejE0QjNa?=
 =?utf-8?B?OFc2WERxd2JyVzdyQVo0bERXK2xidk9tYTF4RDBlSVI1WDQzdVcwd28vRXBa?=
 =?utf-8?B?YSsxd1hrYm1xZ0twSU5JMCtRcTFLY1hSNUFibWNxekNSZDZRZnp5YmhFWDdy?=
 =?utf-8?B?eXFZN0poM1U0MFJxU0psWFJkQnV5UXBXQWFBbjE1RWM2b0hKKzY4cEw3WUJY?=
 =?utf-8?B?aUtwbXdicXI1MVc1Nm1QenFSWWQwOVNTUCtkb3R3MFU0ZEIrNmNtZ0lEVnVM?=
 =?utf-8?B?VjlQWU1YYkRVNXZzSkZkUCtSdXNOMW1wWUtNaU1paU9XMmk5OVFCZ2lzNjN4?=
 =?utf-8?B?OU5ZNjVCcXBGZzlaeW5mMkZvcGhyTXM4WkN1dG9xaUxmbmY5NW9Od2NzVVBE?=
 =?utf-8?B?TXhtTXdKOGFYaGhrb1JvS2JCQXY1WXh4eHVud0xid3ovZVpXdDNFYjZQbGtF?=
 =?utf-8?B?SEpFNG5jT3BQYktYL1FZTUFDQzU5N3FSeU82cGk2R21VTE9kNWJPUHUrTWlJ?=
 =?utf-8?B?V1FLSVEyNUFuYTU0aWhrSGxhR1ZhR1JsTFlIUDZzejA0TXlNdUtVU05XOWE1?=
 =?utf-8?B?QVdBZC8wRkZUSkRadVFyN1ZoRXRldnVpNm4zS1VxNlFvTVlReVB4L0srcnVt?=
 =?utf-8?B?eG9EUVRXNDFjVTcxTkdkdHZocW5ueHFSUFRJL09SNlk5WkFOVDJGSUZYZ1pN?=
 =?utf-8?B?eFdkOGwxcHM4L25iSFhYUzFPM2ZFb3k3NVRONzR4UjYyRFNyL3BSQWFVSE5x?=
 =?utf-8?B?Y1ZGTzBjVEM3Q0NLQmpVOHZXZVJXV2dGNGFTWUNKUkRNcHMxTzR0NGRvNTBy?=
 =?utf-8?B?TFlucFlLYnR1bW40VU5zTi9rQmpJTFRObzVaNTRPWkg4N1dhRkxrV1VGclBY?=
 =?utf-8?B?dDdPVmNzOFhNbzQ0cDZxVk1uTHB1NEQyWDE3NU42TkdzT0g3L2Y0YVVqcWJG?=
 =?utf-8?B?ZXhqVmtrUjlNR3ZDS2VMVmVDNzlZUkFnM0Irczh1SnFLeUgra3RVQlZINlYx?=
 =?utf-8?B?ejEzd3lPMVp3NjhJV3d4Qmsvak0veDdkNHNBTFhYQnpvYzYxZmR4OGhuS0Uv?=
 =?utf-8?B?NTh0TmN3VU90NGJ2Smc5cm54RmtHY29GNlAwOVJuUHVBWFVjN1phald5K1kr?=
 =?utf-8?B?dGQza1lnSFdkYzlzOElDR0djMmZkOVZWRERSU1RPNlBUN2xBUkxZb1VxbmlZ?=
 =?utf-8?B?UDNaa3Z4elNWZVlSeEZQb1ArQk9YTGdFcEgvWXpyQUErTndDdlpHN2JGc1E2?=
 =?utf-8?B?OHRsUnE4N2FITjNtSC9kQ1NEYkhEc0VJckJYMmJpL2hJalZRQVFzejhSR3RZ?=
 =?utf-8?B?Qzh5VUdaY3U2blVVSnAzOURLRFB3dGRDVytITGVPUCt6c0FLbGZWT2oxNG1n?=
 =?utf-8?B?SWVjL0J1ZFgySms2dkFteHkvRndwTXJlU2dnZXhKYVBMT29WT2dmeGlIa2F6?=
 =?utf-8?B?WVBKcVVYQmdYYWZzemJPSTgrZWRUSzBIbDFvTFE0NjQzWDFGenQ5amY5V1l4?=
 =?utf-8?B?b0dmTVVwZi8wcUdhdklSZUdyTXp5Smw1MDd2Ni9hOGw3SzRDMXZaWC95ZTdu?=
 =?utf-8?B?bDQzRXhWMFBveGE0YnBhN1Z1dVVkQ3JPZFVVL1ZLK1lyQTJ4OXI3aWUyaDRr?=
 =?utf-8?B?SXFXRnNDR2p4aTZYU0wvVFlENUwzUVZoVElpS29GSktBVkUvN0pWOTY5TDg1?=
 =?utf-8?B?OTcycm9wb3lNOEp4ZWErMkwxWVZLYzNia1hDejlqVW8rOFBzS1FiMTNPdjJK?=
 =?utf-8?B?MS94QUNTN0FsQXBqTXRGaS84S0lDY2lxVnprS3lKS2NBYWZTSldTZ3pkRVpM?=
 =?utf-8?B?b2JHY2xnRTJXdE1HZ1NvV2NXVDl5dVk2amFsWnI5S1dTNWltRUkzenJzN0Ur?=
 =?utf-8?Q?b+8xnXe7G9/xxT/KVgZZHYWW0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A59E50DD50473419C123D215537AC02@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	tnYxeFSmj+suOxzaF61DAZO0CeiWr3bVQVRlom1Bv2V7QIpHt4sGifjuqPf4ImJoYDPhjqXhgpdkPN9wKJXknnYYQfGmlTcuNrPSuNwH7AybNPbRDu4RTxd5VHvAJdw3siyLix9Vgi8ifr4QTsgStKb+GZXOloT4cXk+71lVl20ZhK9pixhX39Si81slX3IWI+/0EWT57lPA4RI7Z0l+P9NIDs1/E8AOCA0YwtUHF9wzz67aFLbNHq5xR+TI+SJXOctETehNQMaaYG1Z0muBsGR3u2xDQCU8Wjgre6QwgFCVENfEjZd0Z4vg9Ku8mbLy+YM2PYL5lFLbBroogJdlMCoVbJ7W+DXGVyc80uSWbg6H7TxzxFapOcWiMzP2U9nTXjQ2e/yKN+/JoRTl+6tv0edkHvyAW+W+4mQBUmSk2hd7SNCcIeAtwGrtHfzhFJ+drT6nVQK+6awUqWdAKCSBdLdlK+J7Kc6i+jMwBZosLooO4xvg7nRETHoJBsZEtSY4oyfvjgl9RUlpyX+qLrY7X69n77A5fdMDRWG/WCrmfRNMQFFoKCcythiYR6gK5RPYCuchYiAsS4wAnVYPmAYpHSv7dcXXHA2WeU9lxsMj6uLE5BH8b2g1faEaODzyzhqZz42xZJyhJCaasuvhLjoZaQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88bd9ed0-19aa-46ba-71bf-08dc5f219e44
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 21:01:57.3464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /LmdEK5bLn9NEAMtApojd6jG+QmtX6wFyG43pdYdcyEm8FdPibD30vPMPUZavuwFQ9m3UBKWa3B4sgN6hMJKKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124
X-Proofpoint-GUID: PtSOHed6XxKuCAfOPglJTt3gqs7UPbbv
X-Proofpoint-ORIG-GUID: PtSOHed6XxKuCAfOPglJTt3gqs7UPbbv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_18,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 phishscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404170149

T24gV2VkLCBBcHIgMTcsIDIwMjQsIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToNCj4gT24gVHVl
LCBBcHIgMTYsIDIwMjQgYXQgMTE6NDE6MzZQTSArMDAwMCwgVGhpbmggTmd1eWVuIHdyb3RlOg0K
PiA+IFRoZSB4aGNpX3BsYXQuaCBzaG91bGQgbm90IG5lZWQgdG8gaW5jbHVkZSB0aGUgZW50aXJl
IHhoY2kuaCBoZWFkZXIuDQo+ID4gVGhpcyBjYW4gY2F1c2UgcmVkZWZpbml0aW9uIGluIGR3YzMg
aWYgaXQgc2VsZWN0aXZlbHkgaW5jbHVkZXMgc29tZSB4SENJDQo+ID4gZGVmaW5pdGlvbnMuIFRo
aXMgaXMgYSBwcmVyZXF1aXNpdGUgY2hhbmdlIGZvciBhIGZpeCB0byBkaXNhYmxlIHN1c3BlbmQN
Cj4gPiBkdXJpbmcgaW5pdGlhbGl6YXRpb24gZm9yIGR3YzMuDQo+ID4gDQo+ID4gQ2M6IHN0YWJs
ZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBTaWduZWQtb2ZmLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5o
Lk5ndXllbkBzeW5vcHN5cy5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvdXNiL2hvc3QveGhj
aS1wbGF0LmggfCA0ICsrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L3ho
Y2ktcGxhdC5oIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLXBsYXQuaA0KPiA+IGluZGV4IDJkMTUz
ODZmMmM1MC4uNjQ3NTEzMGVhYzRiIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2hvc3Qv
eGhjaS1wbGF0LmgNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktcGxhdC5oDQo+ID4g
QEAgLTgsNyArOCw5IEBADQo+ID4gICNpZm5kZWYgX1hIQ0lfUExBVF9IDQo+ID4gICNkZWZpbmUg
X1hIQ0lfUExBVF9IDQo+ID4gIA0KPiA+IC0jaW5jbHVkZSAieGhjaS5oIgkvKiBmb3IgaGNkX3Rv
X3hoY2koKSAqLw0KPiA+ICtzdHJ1Y3QgZGV2aWNlOw0KPiA+ICtzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlOw0KPiA+ICtzdHJ1Y3QgdXNiX2hjZDsNCj4gPiAgDQo+ID4gIHN0cnVjdCB4aGNpX3BsYXRf
cHJpdiB7DQo+ID4gIAljb25zdCBjaGFyICpmaXJtd2FyZV9uYW1lOw0KPiA+IC0tIA0KPiA+IDIu
MjguMA0KPiA+IA0KPiANCj4gU2VlbXMgdG8gYnJlYWsgdGhlIGJ1aWxkIDooDQoNCk9vcHMuLiBJ
IG1pc3NlZCBjaGVja2luZyBmb3IgeGhjaS1yenYybSBidWlsZC4NCg0KVGhhbmtzLA0KVGhpbmg=

