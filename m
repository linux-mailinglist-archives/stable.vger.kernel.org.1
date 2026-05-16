Return-Path: <stable+bounces-248952-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HVTOca0B2qiDQMAu9opvQ
	(envelope-from <stable+bounces-248952-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 02:05:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5476C5597BF
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 02:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48990300D92B
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 00:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1862AE68;
	Sat, 16 May 2026 00:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="tkzSznZg";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="G4Y2bE7V";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="FB9jbTgk"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FAC405C5C;
	Sat, 16 May 2026 00:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778889922; cv=fail; b=qoxg5eFgU7451g7CqXbNtvzKEz9DZRDusPboeSiwAWUL/plCVdBLYR4IMYZ6vPYQzPwIq05H7kklObnd3DjlKGDxBdXu/g5oPg4ECwT+tKUxnPr8Wde10jaMU/AYBEo0PrT48eM7OejqLnpVPOzApcLMNxDaKmv3CUtv9TuAa2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778889922; c=relaxed/simple;
	bh=Wb1tnqQT8n7RfnwSTCINwBshaOBEAmKsq4t2/R9PBug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RfcPXyjarf8/OHwS2opsJLqs+oy9kyQzMbPgxtKt+JtcDDrn3OFrh/kzfkbo5uNx6/KSprUE5zwNj1oGzkxCeDOZURjWwrQ26V8JPTJK24Avh58jiQ/FvLwAu2crXQz+5YgU2pBFTmZd+IE17wUoFwVkLFmjU8owczViyrPle3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=tkzSznZg; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=G4Y2bE7V; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=FB9jbTgk reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FNrCki1205892;
	Fri, 15 May 2026 17:05:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=Wb1tnqQT8n7RfnwSTCINwBshaOBEAmKsq4t2/R9PBug=; b=
	tkzSznZgtIUJ2Kb1cUsDXZSJCc7dTL/GAQQfPT+Av7haH5e7ne9Lkpv1skFposh8
	zCdsDntu6cyO0OV0nmJfVFnlncYsWL7BDB4jkmA2woug+LwOCCa/86xYFTu98p9I
	gCQDiyLIURckX9MK6s+3iTeQnqbEdOFC6d44n0+91uMBcjDUlukiWCh/NVYN/wtN
	fqjrAKOjguTq1as1cHk20I0pS6HXeV0aenDW1FlpKiQUjPMA76iqLxIFu8mHbj0x
	cb5SCFB3GbpKUjR8BMPx/PbX79iJPQmrflXZJBiXlcfEimYOm1MWfR0AEzagKHer
	CgedobXCJmZla4+EqFgCow==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4e5m8ssdt8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 17:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1778889900; bh=Wb1tnqQT8n7RfnwSTCINwBshaOBEAmKsq4t2/R9PBug=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=G4Y2bE7VVR8wKnseK8XMfPP6YCskFL1TjQUE43nratE6TPzroCbJaLTr7e+f0dMdO
	 Kt8siMtsrFOJfNRWBAZGLZPHDzXfXpRcg3vcITnFJo3Zs1tCE2nNtp/yqSQSg8IgTv
	 3W80k3fCCTcXcgbKm0FH1498USCOD5yApIXck3HPG3+9UuBFPltk8frNkNxiAvL+QI
	 hhO+I5CmhgYGKU4ryGSPWXj6HS2Rgj0JdyK/rkYf0v9NO7d2+P6RpaMZHu1AtFgUX6
	 7JxuKisr0ASGthuI8I7fq+vj4y7d0Z3IqDX0fqjewYA+JZ6Sl4px7ldHRGSPIskX3Z
	 DkNSZ3f+sj9IQ==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 335934041B;
	Sat, 16 May 2026 00:04:59 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id CAAE3A00E0;
	Sat, 16 May 2026 00:04:58 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=FB9jbTgk;
	dkim-atps=neutral
Received: from BL2PR08CU001.outbound.protection.outlook.com (mail-bl2pr08cu00100.outbound.protection.outlook.com [40.93.4.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id CA3BF401EF;
	Sat, 16 May 2026 00:04:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NjfA+VolbPkOzLDzk5TFKbn6o3CMJW4bd0AuBow1eviVlSSLKshTyRhNjXptEmoFarOdqihL1gq1sqTDSbUUrxySs5w8dOFjRhyGQii8YUQ9qSdqcUWaOTuyVgP8HIOvs00k0gaUQmmTulUu+TYSPGmb+tQl4KHR41Rq/UsR6bzPLhTY98MbQBUNwbxg6abmKh/Zn9q4aZw6ZZ06WApK50vhbOjMXphERNM9Kna402kkUCDUNDX1SPDqAGa36cX694o5njDmRtQKDY2cHMC+vno13HtCD1SE0ZwZQ2xxKCJeNX0jq0K6fiQIF8aijb4QhJeg0mhjvU8K+/Jc3f5DXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wb1tnqQT8n7RfnwSTCINwBshaOBEAmKsq4t2/R9PBug=;
 b=JEwcYzQL32ZToCqZ3hKyk5+W4Rg3wFLzyLe3Hiho6JgKlDqqjaDwcuGsweW2Yq2qBqF1dsn+CbcDfWvXIZuEFUch4pCzxMd4fsyu/Zzo24Zu1qnCc2n1AtCyQcfuECIisoLn7RwuswmCDaxAWqiYeLEbie/esd3aE+Eef6wpfWIFhUxvRWr7xhDS4CsrwUUiHDgpH+mpIGV+fy26hcPpMShP+uRu3yOvwknMiTSlAA5lFl2fnVP0P2flUmkSj1mYpXIJjZacHwQ/NseaGrqp6ArApwZc7oiehUSopi/o+OD/fnw8SuNqUWchN+XS5JTFbU2CRJWydolvTBBobjbqyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wb1tnqQT8n7RfnwSTCINwBshaOBEAmKsq4t2/R9PBug=;
 b=FB9jbTgku1JkVqhLlRGmZmHpI3p2y8BpGGgmea0Xd4yabW5OZASQSh6IMWH0h6PuHhHkxdugRMEuPGbQAdPQgw6lJsOtNswCIlMHwp/6Y72aWDQyZ4ti1PFQFSJntJzQ12bi4xMaJrig+/vxWQoaqQULSRyeZLYba1zs6i9ZCqQ=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by BL1PR12MB5708.namprd12.prod.outlook.com (2603:10b6:208:387::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Sat, 16 May
 2026 00:04:47 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7b72:b921:b9bd:4899]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7b72:b921:b9bd:4899%6]) with mapi id 15.21.0025.016; Sat, 16 May 2026
 00:04:47 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: "Pandey, Radhey Shyam" <radheys@amd.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "michal.simek@amd.com" <michal.simek@amd.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git@amd.com" <git@amd.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 3/3] usb: dwc3: xilinx: fix error handling in zynqmp init
 error paths
Thread-Topic: [PATCH 3/3] usb: dwc3: xilinx: fix error handling in zynqmp init
 error paths
Thread-Index: AQHc4WCJ388cHRBdu0u38FjUG8Y1VrYMwxOAgAC7KgCAAk4MAA==
Date: Sat, 16 May 2026 00:04:47 +0000
Message-ID: <age0Jm8w9am0jvP0@vbox>
References: <20260511160814.2904882-1-radhey.shyam.pandey@amd.com>
 <20260511160814.2904882-4-radhey.shyam.pandey@amd.com>
 <agUnwgXyyrGQ2t2y@vbox> <7eca29f8-9847-4ee1-ae3c-8c507bc295c7@amd.com>
In-Reply-To: <7eca29f8-9847-4ee1-ae3c-8c507bc295c7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|BL1PR12MB5708:EE_
x-ms-office365-filtering-correlation-id: 189a5075-4674-4b81-f163-08deb2debdd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|4143699003|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 fjWN6E/TvNbSORGz0o+YRa82SgfAyUUl4Z2KqDlxv/J5R504qWNhH3Jj3q1eV+3OSMa/5iXxelKLuqUcyM4lzcxYVJ6fqKyll/zNiVPBuKtnvaYhzsC9jhlGbMDCpuXvgGC0s7ipGu0ZA2xlfozzvMvbfFYMXIRcp6i6og25jcT34uv+NPMAtEs1xqtF43P/lMRFjeTVtLE6ChgpR/sBmzKn3dvMsFTRfqc2lLeKBsOUHzeXoetFQff+bvypbcIkOVK0ut9hUjgsqPW74opYmZiPO58HOFq35ZqOJ8jQuVWUxwW9QIw6BY6DIjY0NbP/VfrwA1Q/Eo94odExPUPXfqvuPcbaoslIVu+V7Kq2dIU5s38qiGr2a0MafBXk5bczQs6C9sMwwxSYuhy2teA31UbH4GoUIBdoENA6mwrVFj53Z3K1w4op3cnRzklgfELqC+4kLz8GaRB492UzDCTVFjpxSgO2xrEna5WdTVtXA0oO3+LHkzH3Y+JXxjKJ02hpzM/XeFbPiGjtO2YSK1dg6AQ/Ij710Qjx50PIoZy1ZGQtfDzi0WCcyNvb1izKCCoBtwXcZ8Aa0czQwIIra8PgxR64AiefZrcEOjMJF1CDtopsLI6w27wndPPCp+7I4x3gbJsa11r23nAD3+SXHAK9GFNG+gmVceDewkMHUStiphJqdlBq8zNc5iXxnoUOJ/yV3zrdjuYRYn/r8Vau/KVuA3Fv6E3SdK5yfpKOgRQO92hkTx4neCwxCqitnHkxKK7D
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(4143699003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?clpsRzJIb2UwWmY3RWpkM1lDWVlrRDBEMkpITnA2dzlKdU5ScWY5L2tMTG1t?=
 =?utf-8?B?anpPUXZYekpDOVQyRWtPK2pBZERLSWpzaWdiaE53KzRrK21KNm5pN3hRb3Rz?=
 =?utf-8?B?amt3cmozSkhxamIvWDBhYmtxc3loWkJBaUI3NHk4c0IrbFAwNnFSeVQ3dDdl?=
 =?utf-8?B?ZWw0M1UvemNaQktNMFZoeFl3dzE1Yzl5M2dLVG0vV1JLYS9kbHVSN1oyVnlT?=
 =?utf-8?B?TXBlcGtDK3M2SHdnMUtvUXJtMjU0Yms2Wkc5UnJmSWswTnFZaVNtS1RnZUgy?=
 =?utf-8?B?MVNoaHBmejg1KzhCWTM4QnNId3lpeEFrNjZBdHNjZlpUSDVKTVN2TFBuVGs1?=
 =?utf-8?B?R09VcGpKNGhxNVBpRjVrWWJiTmxycldEV2E1NEJoOFBTb0VaLzBqQzVzeVlu?=
 =?utf-8?B?SVE4enRKbzBaK3Vua3g4cXg2d2tuci9YYytnSE9HczN4VFFselBTT2N0cXo5?=
 =?utf-8?B?aFgwUjk1TDBtTHh3ZWM1djA3TWxTSUY4alJNMjU3eVNsZllrUmRjVWtReThS?=
 =?utf-8?B?eXVaRTUxaHJvSEhFOUhWYWlYdFhzVW1uampFR3hJQXFYRitjN04rZzNtNXN0?=
 =?utf-8?B?K25RdndvcHdxTTdjMitKQitvTjFaRW5Da3QzemJBQmxqd3lQL0NLclhxOTdT?=
 =?utf-8?B?cTJ3WFBqS2ROUkh3cHAvZVV6SWI5eS9QMktEa1lqREx1NWVYUW9sV24zaENM?=
 =?utf-8?B?bFZFYTNRYmtTdmUyRmhrSEp2OHhRU3Z4dk1aalM0aVl3V1BTMnI4QXJwR1Jv?=
 =?utf-8?B?SGFlTExyMHROcnpiV084b2JFd3FoeExPdjN0eDVGcXduUmNVMFlRbDNjd1dQ?=
 =?utf-8?B?N1Z3c2txUzBxby9XUHhEMGZKcWxWNTVxVlIvWGpwN1cya3pLT3k4N1Rrc0Vr?=
 =?utf-8?B?MHNJTC9TWmM4bWFoTHo1Sk8rMytXUTZZcklMMDBYeU9TeCt3Njg1SVVHRmhl?=
 =?utf-8?B?SkQ1NGNZbExoQ1ZSMlJ3dkM5VU1FMzhEMmhROE9CcXNwNEZudnd4UGRrc1hY?=
 =?utf-8?B?S1h5eUpzTEdGK0xXNWZmOVNkVjlMTXpOT3RIZFJzZHJlcUVNcVFLSUxkV3dR?=
 =?utf-8?B?L0JNRjc4TythaGRFa09tMFdJQUhSTDFpVHlJTDkzRHh1RWd2aSs2N0p4TU8w?=
 =?utf-8?B?Q1VqNk9ZZWtjNUFsakFLWGhPbEoweklqSzlEUHZaWldFb0dTSHlJdWdENGNI?=
 =?utf-8?B?TkMwVk1DMk5vMEFJSTVoVi9NOVFqVVVWYlltVklYNko3eStLNWZuY0RwQnBi?=
 =?utf-8?B?VFIzOWx6SXd6WWl6MVlXVVJtMTBIMmdCMnN1ek5aYzhOSVA0YS9JcFEyTWl6?=
 =?utf-8?B?VmxJZERuTjhLck13STJjejJTOEVJQWlzRzIrSUJEcGdTWXhobm1vSFlDdUNx?=
 =?utf-8?B?WGZCNEhKNmJHa0dJaTJaZnJ5L2ZzR01iaHdxZ09XT2duZDR2bWlFelF1eGFV?=
 =?utf-8?B?ZXpEVm1vQnpMMjZLYWVkTUpJaHpuZ3NWU1ZLWlRMRXUrUGlpcnVOSExaZzRu?=
 =?utf-8?B?YkdUNlRMMk9Hb0N3U3kyOXhCbUZ4VEdRNVhmb2diK0RoT3kzbU9pUFlILzJt?=
 =?utf-8?B?aE1HZEFvdlFvZG4vMmJPOE9sK0RMaWJEcWpQYzV2VE5WRUpYRGVRdU1Pb0dX?=
 =?utf-8?B?SURaanJYbEFJOTRhYjRYa3JLVTlYS29Cb1JuWWY5Zk1IbldpMEw4N2dxWlA2?=
 =?utf-8?B?anpzeWE3V0Y1cFMwSDJQYy9jdHR3YWNWQmh5WUdNenFpN3pBOGJIdyt6MXlN?=
 =?utf-8?B?VFlPMG80QTYzaVUvSTRLTndTcG5ZZTFkVU9uendLTFB2UkxSc3NSek9qOXk2?=
 =?utf-8?B?YlFwa3NWU2thMW5vUUpxVkNQVGdpSlhtbXhFdXJBQzJmOHNWa092OTA3NmZk?=
 =?utf-8?B?RHpUUjkweGpVQWJJQmFkMVQvaTJMTVJ4Mks4TS82QXM0TWdYMGZaQXFtWWRW?=
 =?utf-8?B?a3pYSHpOcThjeldNZ2dkMUZSUlphVW5OanhuZHg0MUxvTDlpSEZwdUlSSG9k?=
 =?utf-8?B?ZitRTGp0YWdvNEtQckQ2UVBaRUhHSWZORXgxaWsvMmVWNFdwZHFJVFo1UXZN?=
 =?utf-8?B?WjNaWnArK0tOd2xHWVRVRWw1ZVNmeDU4bWxnREJvV2Q1RUZPT3JpZFhMWHpa?=
 =?utf-8?B?R2dNSTBKc1k4MEI3QkJ5Zk9jcUZNV1pBZ25YZ1FVY3dway9xMkFlTzYzY1o1?=
 =?utf-8?B?M1ZETG16YVlVSnh1b1NKRDJ0R2ZFREFVR08xT0hWY2tVMnQ2aktpUXV0am9r?=
 =?utf-8?B?ZTZORFVsRm9pU29FTEtTR09XTkdXRURicU5wL0RkTlVZbUhzZ3pZSUJyaEE2?=
 =?utf-8?B?QWZzL0NzUkduN2ZDU0d6UWFTcHliNDBMTTQybHhUK1RwOFFvbFNBZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBC491C12C66B848B0AC12E5E72D776E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	vyqDHA4aeT3TCihXF3QMCkcdHOeR1LDVIQZiBqaIgE/DeCb9Hfizo+RXQKJ3pTsjjukC7Y/mgPB/7JHb5oEXoZIH08J5nPiAGytM7DfPKG+rUyXS+ENdouDboaWRPRDdpcRy2YHylBUE+wShnb5LcHiCpiuH9EIiiADnXRjiq7RV323dYBWs/Xiera1RSElydk/1e2degGen+IagTbzvRWE2gYpoHRet+54KkgEOVKn1yfYPjwtPYybskmXSx1iSLRtDORS6Wqi5eU3+87x+iSk1hisH9E+F5WZAiRR0djwKkoSEN2CteboKRPYT0q2P9s8K1OwZ8YQ2SWLGZOtQug==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Af+2mVEaAdBg0i1lZ+/H3NMj9S4ohxHVbTh0TgwcL+x0CSWlnAWEwsjrNGHubKRcqle19mGn0OedbT9iFsIIPXEWr4pAa1/PkCy/J3r8f1tK64e3olC3Q3Ij6+/OTD9BKjqirOYpmFkDm/5vFbu0Iu6yKXf0OChL2bpDg57ZjhyyurC0J0stFNDT9YhAyU33O9zTKJYwuBWPYmi37f+Gq5tcf3uic+P3OrQ5uLRlV0Y2w8dVru3jEM26J6mg/c3mrwBiM0UNEXLkExWu0hwsntFuZLO4qRb+Xcu4hoabEQNGjs7+rRAq/XjTOjtOmTQl8pQaeARoctJXUB5t2TEBliWQxxrd2UsS+DYRZwUPvxCso93xziAG0WjWZqwgy5zxbLzJCnFAa6KSUsiDzz6lQs1RIpDCztBpVkToQtKKov6MaWgQ870lpPRkybB94ISKFm4t/s7i0ACcSX52Hy9r/I1h//DwPL1V+sDqM8VzjpO1hvQo3i5+WCSyqCYdMTY4PG9/7CqFmJCJrGWUnIkngyq2ErrW0b5MQu1THawxO9YOMNPVy7tlTFlP6s7VUyijbzWCX3HzfGk8LpNh+NVwfi53FKJ65QIQxRcwZYWttnj0UcgaCkOQQooiIfM1CQ7src3NZ6ZDyUvD1LXJoZPvZw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 189a5075-4674-4b81-f163-08deb2debdd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2026 00:04:47.0567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VXIF3f2Ovjcwx0r933QSyFhsKmSt/E12Y6Lska+UFhykdclRPOu/iCOPoi9pQ8sq6xCPjoQNz0KJntYasNHDmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5708
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDI0MCBTYWx0ZWRfX/YH+jkNWDR9X
 1GYuJDwag1euoDe59pm7c4OoSx19mW9w6O6BDH2P6fjzodGcxUyyL9TIoHg36xXHlAl8yIrHTgx
 JtX/7V8fehXbaD/L/o+E0qYXNklNnGtKagZQXZd55rUixZmqnym8wZdqnm8+DJ0owh4WI/QJft/
 LourS7vzMBiiOSjnykMjZwHwJ2xWjfXG6ADl9jMxlShsTRn7o5YAIUtFCK5dyGaiy4bT2edvi/w
 yINKcwpVSb1LixGAHpKNXzec6zkD2SK0l60KDqrAAcv3iRYuBSIz/38FiWs21kLVx+xnkiXyGfx
 XJSUUx3ezvCCGnFyMJ88ZggvW29B666Ksgs4kRcsmFZQAf56gn1HqBH8JMd3DqfPPBfkWcXegIC
 j3XQzpwzawCSk0ZgwLZBDoGzyZbQT/3XgvNRIv3z3Q2GPYAUVVp4f3WHLQumhCh2USvguKgRSCL
 oLbDRLB1uUeLxCxeebg==
X-Proofpoint-ORIG-GUID: wPuW68inxaSyGyth2U_giK-ExBqPAfH-
X-Proofpoint-GUID: wPuW68inxaSyGyth2U_giK-ExBqPAfH-
X-Authority-Analysis: v=2.4 cv=EMU2FVZC c=1 sm=1 tr=0 ts=6a07b4ad cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=-4-sGo8i1FcW4KD7_GeR:22
 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8 a=jIQo8A4GAAAA:8 a=oBB98BeecbylNU1jw68A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_05,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 priorityscore=1501 spamscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2605130000 definitions=main-2605150240
X-Rspamd-Queue-Id: 5476C5597BF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[synopsys.com:s=pfptdkimsnps,synopsys.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248952-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,synopsys.com:email,synopsys.com:dkim];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_REJECT(0.00)[synopsys.com:s=selector1];
	DKIM_TRACE(0.00)[synopsys.com:+,synopsys.com:-];
	DMARC_POLICY_ALLOW(0.00)[synopsys.com,quarantine];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	FROM_NEQ_ENVFROM(0.00)[Thinh.Nguyen@synopsys.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_MIXED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

T24gVGh1LCBNYXkgMTQsIDIwMjYsIFBhbmRleSwgUmFkaGV5IFNoeWFtIHdyb3RlOg0KPiBPbiA1
LzE0LzIwMjYgNzoxMyBBTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIE1vbiwgTWF5IDEx
LCAyMDI2LCBSYWRoZXkgU2h5YW0gUGFuZGV5IHdyb3RlOg0KPiA+ID4gRml4IGVycm9yIGhhbmRs
aW5nIGFuZCByZXNvdXJjZSBjbGVhbnVwIGkuZSByZW1vdmUgaW52YWxpZA0KPiA+ID4gcGh5X2V4
aXQoKSBhZnRlciBmYWlsZWQgcGh5X2luaXQoKSwgcm91dGUgZmFpbHVyZXMgdGhyb3VnaA0KPiA+
ID4gcHJvcGVyIGNsZWFudXAgcGF0aHMgYW5kIHJldHVybiAwIGV4cGxpY2l0bHkgb24gc3VjY2Vz
cy4NCj4gPiA+IA0KPiA+ID4gRml4ZXM6IDg0NzcwZjAyOGZhYiAoInVzYjogZHdjMzogQWRkIGRy
aXZlciBmb3IgWGlsaW54IHBsYXRmb3JtcyIpDQo+ID4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVs
Lm9yZw0KPiA+ID4gU2lnbmVkLW9mZi1ieTogUmFkaGV5IFNoeWFtIFBhbmRleSA8cmFkaGV5LnNo
eWFtLnBhbmRleUBhbWQuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgIGRyaXZlcnMvdXNiL2R3YzMv
ZHdjMy14aWxpbnguYyB8IDI3ICsrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQ0KPiA+ID4gICAx
IGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+ID4gPiAN
Cj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMteGlsaW54LmMgYi9kcml2
ZXJzL3VzYi9kd2MzL2R3YzMteGlsaW54LmMNCj4gPiA+IGluZGV4IDk0NDU4YjNkYTFhMC4uYjgz
MjUwNWUxYjA0IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLXhpbGlu
eC5jDQo+ID4gPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMteGlsaW54LmMNCj4gPiA+IEBA
IC0xNzYsMTUgKzE3NiwxMyBAQCBzdGF0aWMgaW50IGR3YzNfeGxueF9pbml0X3p5bnFtcChzdHJ1
Y3QgZHdjM194bG54ICpwcml2X2RhdGEpDQo+ID4gPiAgIAl9DQo+ID4gPiAgIAlyZXQgPSBwaHlf
aW5pdChwcml2X2RhdGEtPnVzYjNfcGh5KTsNCj4gPiA+IC0JaWYgKHJldCA8IDApIHsNCj4gPiA+
IC0JCXBoeV9leGl0KHByaXZfZGF0YS0+dXNiM19waHkpOw0KPiA+ID4gKwlpZiAocmV0IDwgMCkN
Cj4gPiA+ICAgCQlnb3RvIGVycjsNCj4gPiA+IC0JfQ0KPiA+ID4gICAJcmV0ID0gcmVzZXRfY29u
dHJvbF9kZWFzc2VydChhcGJyc3QpOw0KPiA+ID4gICAJaWYgKHJldCA8IDApIHsNCj4gPiA+ICAg
CQlkZXZfZXJyKGRldiwgIkZhaWxlZCB0byByZWxlYXNlIEFQQiByZXNldFxuIik7DQo+ID4gPiAt
CQlnb3RvIGVycjsNCj4gPiA+ICsJCWdvdG8gZXJyX3BoeV9leGl0Ow0KPiA+ID4gICAJfQ0KPiA+
ID4gICAJaWYgKHByaXZfZGF0YS0+dXNiM19waHkpIHsNCj4gPiA+IEBAIC0yMDAsMjYgKzE5OCwy
NCBAQCBzdGF0aWMgaW50IGR3YzNfeGxueF9pbml0X3p5bnFtcChzdHJ1Y3QgZHdjM194bG54ICpw
cml2X2RhdGEpDQo+ID4gPiAgIAlyZXQgPSByZXNldF9jb250cm9sX2RlYXNzZXJ0KGNyc3QpOw0K
PiA+ID4gICAJaWYgKHJldCA8IDApIHsNCj4gPiA+ICAgCQlkZXZfZXJyKGRldiwgIkZhaWxlZCB0
byByZWxlYXNlIGNvcmUgcmVzZXRcbiIpOw0KPiA+ID4gLQkJZ290byBlcnI7DQo+ID4gPiArCQln
b3RvIGVycl9waHlfZXhpdDsNCj4gPiA+ICAgCX0NCj4gPiA+ICAgCXJldCA9IHJlc2V0X2NvbnRy
b2xfZGVhc3NlcnQoaGlicnN0KTsNCj4gPiA+ICAgCWlmIChyZXQgPCAwKSB7DQo+ID4gPiAgIAkJ
ZGV2X2VycihkZXYsICJGYWlsZWQgdG8gcmVsZWFzZSBoaWJlcm5hdGlvbiByZXNldFxuIik7DQo+
ID4gPiAtCQlnb3RvIGVycjsNCj4gPiA+ICsJCWdvdG8gZXJyX3BoeV9leGl0Ow0KPiA+ID4gICAJ
fQ0KPiA+ID4gICAJcmV0ID0gcGh5X3Bvd2VyX29uKHByaXZfZGF0YS0+dXNiM19waHkpOw0KPiA+
ID4gLQlpZiAocmV0IDwgMCkgew0KPiA+ID4gLQkJcGh5X2V4aXQocHJpdl9kYXRhLT51c2IzX3Bo
eSk7DQo+ID4gPiAtCQlnb3RvIGVycjsNCj4gPiA+IC0JfQ0KPiA+ID4gKwlpZiAocmV0IDwgMCkN
Cj4gPiA+ICsJCWdvdG8gZXJyX3BoeV9leGl0Ow0KPiA+ID4gICAJLyogdWxwaSByZXNldCB2aWEg
Z3Bpby1tb2RlcGluIG9yIGdwaW8tZnJhbWV3b3JrIGRyaXZlciAqLw0KPiA+ID4gICAJcmVzZXRf
Z3BpbyA9IGRldm1fZ3Bpb2RfZ2V0X29wdGlvbmFsKGRldiwgInJlc2V0IiwgR1BJT0RfT1VUX0hJ
R0gpOw0KPiA+ID4gICAJaWYgKElTX0VSUihyZXNldF9ncGlvKSkgew0KPiA+ID4gLQkJcmV0dXJu
IGRldl9lcnJfcHJvYmUoZGV2LCBQVFJfRVJSKHJlc2V0X2dwaW8pLA0KPiA+ID4gLQkJCQkgICAg
ICJGYWlsZWQgdG8gcmVxdWVzdCByZXNldCBHUElPXG4iKTsNCj4gPiA+ICsJCXJldCA9IFBUUl9F
UlIocmVzZXRfZ3Bpbyk7DQo+ID4gPiArCQlnb3RvIGVycl9waHlfcG93ZXJfb2ZmOw0KPiA+ID4g
ICAJfQ0KPiA+ID4gICAJaWYgKHJlc2V0X2dwaW8pIHsNCj4gPiA+IEBAIC0yMjksNiArMjI1LDEz
IEBAIHN0YXRpYyBpbnQgZHdjM194bG54X2luaXRfenlucW1wKHN0cnVjdCBkd2MzX3hsbnggKnBy
aXZfZGF0YSkNCj4gPiA+ICAgCX0NCj4gPiA+ICAgCWR3YzNfeGxueF9zZXRfY29oZXJlbmN5KHBy
aXZfZGF0YSwgWExOWF9VU0JfVFJBRkZJQ19ST1VURV9DT05GSUcpOw0KPiA+ID4gKw0KPiA+ID4g
KwlyZXR1cm4gMDsNCj4gPiA+ICsNCj4gPiA+ICtlcnJfcGh5X3Bvd2VyX29mZjoNCj4gPiA+ICsJ
cGh5X3Bvd2VyX29mZihwcml2X2RhdGEtPnVzYjNfcGh5KTsNCj4gPiA+ICtlcnJfcGh5X2V4aXQ6
DQo+ID4gPiArCXBoeV9leGl0KHByaXZfZGF0YS0+dXNiM19waHkpOw0KPiA+ID4gICBlcnI6DQo+
ID4gPiAgIAlyZXR1cm4gcmV0Ow0KPiA+ID4gICB9DQo+ID4gPiAtLSANCj4gPiA+IDIuNDQuNA0K
PiA+ID4gDQo+ID4gDQo+ID4gVGhpcyBmaXggc2hvdWxkIGJlIGEgc2VwYXJhdGUgcGF0Y2ggZnJv
bSB0aGlzIGNsZWFudXAgc2VyaWVzLg0KPiA+IA0KPiANCj4gU3VyZSwgd2lsbCBzcGxpdCBpdCBp
bnRvIGEgc2VwYXJhdGUgcGF0Y2guIERvZXMgdGhpcyBwYXRjaCBsb29rIGZpbmU/DQo+IElmIHNv
IGkgY2FuIGFkZCB0aGUgUmV2aWV3ZWQtYnkgdGFnIGluIHYyIG9yIGFkZHJlc3MgYW55IGZ1cnRo
ZXINCj4gY29tbWVudHMgaWYgbmVlZGVkLg0KPiANCg0KVGhpcyBwYXRjaCBsb29rcyBnb29kLiBZ
b3UgY2FuIGFkZCBteSBBY2tlZC1ieSB3aGVuIHJlc3VibWl0Og0KDQpBY2tlZC1ieTogVGhpbmgg
Tmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3MsDQpUaGluaA==

