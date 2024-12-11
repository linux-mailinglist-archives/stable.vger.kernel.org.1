Return-Path: <stable+bounces-100506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EECE69EC0EA
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 01:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62918283873
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 00:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17293A8CB;
	Wed, 11 Dec 2024 00:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ErkuAD+k";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="erlQ37M3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="YqGJDnbS"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81CC8494;
	Wed, 11 Dec 2024 00:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733877263; cv=fail; b=C6utK6dKZglATb3bI8m1fZ+1Q6WOVsPvFwiu8ItFIyPjRFxLw4xq/FGgnUAOhuRBW2l3Dc+6uk8tZEgvJNElc//cPHWDJzz0SKgmwpSM5ajVIsl8ZZNf98yqPC53wxPuSckLqHmfKYK/qHTGbgpbKxsYvXkWw8OQlrHRxm7yYnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733877263; c=relaxed/simple;
	bh=+bsjUAdAtpqAtbhC31cTF+QdCim13WCA7LORk4FpD3A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TNSAURTmG1drbT76BzqkbmvYVX1BL/82OvJz+yFAp1scbJesoufEbyIvGEj3PefD8rB7lU9PPpU9aiuaQMwvXPZhqLc4vosSUEHduDyrpcS2AAw/tpiNCGhajWzkmR9j4y4Sh8Pb2EvxCA6WB1nrq9aIgf++WHv/AnnTKZYE/YI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ErkuAD+k; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=erlQ37M3; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=YqGJDnbS reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BANMPTv010812;
	Tue, 10 Dec 2024 16:32:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfptdkimsnps;
	 bh=+8UHCyE9bnErKEE2QanncECjkUbln3DuEji9yWgKV28=; b=ErkuAD+kw3dt
	KiIRAbVH5m1fB0OEJ/Tvv+DnXIN51fLR9dB5BHFXC1LFC/kBXtmkDFe71NQtICc0
	VPJl6kgnTJkUkejKmZyJEWr2rhK6PG4USubyfwQ4AcmwmedCFwmgEozT5GDUYy3x
	SkUcTJZdvKsDFEnxs3rsS02Iy1Gs1fG3iLxM/MpL/lpr0kneJPVLuOYpiuAS8hVm
	NdRMO5WmdGaz3ayp/SHpcrK8Dw6WzZpF7+bkWidej0P7jikLn3T0oiTKQdfTYvs2
	tYq6MNQ7JTTYs+JC9k88HZ2s17/jO4PaQgEcYEhrCSCaYEct2Ag7qfBNSKh7eaCp
	UWg+Ht347w==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 43cpgb9ptw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 16:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1733877125; bh=+bsjUAdAtpqAtbhC31cTF+QdCim13WCA7LORk4FpD3A=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=erlQ37M3bUN35bW3eeDAAjzDnhvb7ZgrNanXQ6HOeh7kQLjVmhsmZIedabbA+erwF
	 3QPqFqwRLekTLEmJ+HohJD77KF8rSjzazWJxzW9MetwTdEoFGLCnT4guZ9vwlOuSM5
	 wqXw21FUXIcDiQ9ni8FqDkzNu60+XSjhOmRhwVOiuXvRywffR68L9a4GiZphMMja+H
	 dFE3mbFrA1RIEX7pqTbGkS/82FwXe4n2zMaE/R/IEilrmpLBeaGXQ38ObGm+wqWl0g
	 6YOTVtNIXpSiG5z0yQPm4JVnCXUz8sOUKtNfWixShPTdmJZjqxVVHzxpK67ZVs8LUN
	 noQQ/51zeA1vw==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3372040126;
	Wed, 11 Dec 2024 00:32:04 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id E6A20A009C;
	Wed, 11 Dec 2024 00:32:03 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=YqGJDnbS;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 9A58B4041D;
	Wed, 11 Dec 2024 00:32:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqxBVVBUDNvVBtm8gSHE5WmxaBkj0miVrjychrTo7W2dsxiOx79I6CkiXc03vSIkd4H7XRzNeWbrdhN12ml5MEU2UCtyxYsF5cS3BbkMutanLSPpdbObWbO5+5mdPKt6YRZwfxhzmhXuxdrObHkb1Zjm8Up4GayOJ32CmgOuRHfLQDs88rzWa9EhBWZFH9ZCpjVz7ZiFTuatanMDmfMJon6lo2vBeiq6iMKQIDVoJfmbj4N6LX0tnYVKhu/x7axL0wFFRt4PoWZ4Gv5SRY8gEdsTj7ysP7lBZiZ/riAjUtd6scUPxXZQT5TiOmbwqfnYabaUhQ0Byxpz0yLYxeDaDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8UHCyE9bnErKEE2QanncECjkUbln3DuEji9yWgKV28=;
 b=CZbMsUfIilQty+XY5pR3ijCyAlrZFwixdbDRCw3yrp0ul4JnRE3rMJmFV6yappb8aKtLWHZfVUMMSpEGuGib8uPwE3Y/C3oMBXoHnpQMn0g2179ecWXyFIRHms185FBG3xHOy52YxjiGp1SJiMM62ddDKY1p6Xo0E/iRumwLsEw024qnLKuzfHvKJmlwGta9znoJdAhgW6GKyWdL6IEMVabcawLoQde6czg4gqxd51EYkA38DB6KWbPaxq6JvNDGtsEN2vZli1tfbEGvk8ikThsBpQThn7fhgbmxPhqFfcb1gCwf2kKL8QaybRQ/RydvmkJwzjsfIMEpE1lobaxBeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8UHCyE9bnErKEE2QanncECjkUbln3DuEji9yWgKV28=;
 b=YqGJDnbSVAFC/s6lYULwAy1rNbBPFYVhVbcn7mutESePoqK9l/kvR835FaXXgjzNi8ThaZVcT5TLzzpG5990sLC6jyz/Gv1PROFit2UlfnG4Zsh3e3rJQDPadkGJwfjK+hCjovzgt11Oaw6b3iSY9iC1DoRwqfih7ukTqo5Mcck=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH3PR12MB7691.namprd12.prod.outlook.com (2603:10b6:610:151::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 00:32:01 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%7]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 00:32:01 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Homura Akemi
	<a1134123566@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Christoph
 Hellwig <hch@lst.de>
Subject: [PATCH v3 05/28] usb: gadget: f_tcm: ep_autoconfig with fullspeed
 endpoint
Thread-Topic: [PATCH v3 05/28] usb: gadget: f_tcm: ep_autoconfig with
 fullspeed endpoint
Thread-Index: AQHbS2QY9dYrSv50sk+mzfZnuPzePA==
Date: Wed, 11 Dec 2024 00:32:01 +0000
Message-ID:
 <e4507bc824aed6e7c7f5a718392ab6a7c1480a7f.1733876548.git.Thinh.Nguyen@synopsys.com>
References: <cover.1733876548.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1733876548.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH3PR12MB7691:EE_
x-ms-office365-filtering-correlation-id: 55a775d8-4462-4e35-9075-08dd197b3a93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?V6IgZ5kiRXE+SairDKxQa2fNeTcMhdrkjAYcrGPoGL97plk0XerHf0Du0e?=
 =?iso-8859-1?Q?aFTM9TX9rUA06j7lUSXn4FFUN1w2CVoMk5x3+BVXeZdA1jEfUosfvSRdmy?=
 =?iso-8859-1?Q?Hfrs6HNG6Y9iqccJX3eZUkVH1lyojv6TsiDpGxFKxr0Z4gDXgVHfHGS9RA?=
 =?iso-8859-1?Q?MYcKqP8+YaC4qbgoO56+t/AQYwqCKBqykXHFv94+2HQ6igowZzKKv5CuYx?=
 =?iso-8859-1?Q?7WT3I8DQtLbTwy8LY9y8OXkAC+BFHnf1WemxKXiG5gcQUGeYboWBEJwGTn?=
 =?iso-8859-1?Q?+pAKYE662EN5FBPucWzFcjDzjgSQ5Ly7XhHulUzvFFr/F6Gch7IhObTxIo?=
 =?iso-8859-1?Q?teOsCoc6Q/WKNysEyV1oFM+qfv/HwHzKy9vjA1N6hfhOiDuLhzEqDl/5q8?=
 =?iso-8859-1?Q?+gUe93y3Ekq5PXCiXsqNsyL4a0zUVCmM8SiNHcZ7RrsPbDG3EKE8nHrJfT?=
 =?iso-8859-1?Q?0TpEyEf41NmNeuQ9247sJp6Tos5PajeTcGSdWUED68DXv2a0qhmP4YREQJ?=
 =?iso-8859-1?Q?ZtlCZG0lydq/hGYaqPckgJlf+QydA80H1s2g7fxfVfwBz8pOvvHlJwC4eJ?=
 =?iso-8859-1?Q?sMxUX4766ia9nQq3EjS5wAacEBwtd+6an5l5lzOe3TFJU0U598ZDvNM0hi?=
 =?iso-8859-1?Q?bLKLOIy/SybIEHLZ8gJ/l+shiJvqYbfEJjJS54q7atuRMOxitHc0NtFRk6?=
 =?iso-8859-1?Q?54bhcNst61YUEQ8Ab1CWj+vv7EvrHvI+E+GpZZ5j6Fch3fonl7PfPH+jCD?=
 =?iso-8859-1?Q?KFzWa7tuja5dwS1mP9c3LPfjlDG++9b2xlyVrorkC5vB2aONRiGVzWj8Xp?=
 =?iso-8859-1?Q?c/ossrTR4K2AI46QCBZtsBJLICO02KeQYozK0pZlkYZRHwxTHBe8h0l0p9?=
 =?iso-8859-1?Q?yL//gnkuu2u/23erc77aT9yHiITkg7pPsdoRBPrMoK3r+7/0Qwa2qAZ59J?=
 =?iso-8859-1?Q?cwLypsNiR6gW/Ew4ngBq6iWo7n6B0Kqan4mBxXw4mB9hYz27B3B/Q/Nvp8?=
 =?iso-8859-1?Q?lMUZbco8bLNqRxc7PJSdGjdn5JH6cer9vle+Yr2K5HYv0oapD5O+ta0Rqm?=
 =?iso-8859-1?Q?i0drNDqW/jPCWwqjy0ahWEBD3PGy73a2BX4lfK1lLFVkiG/HB2cJlHKcyq?=
 =?iso-8859-1?Q?IdRHykKmS5lEHXFU95aObcK0k+FJEEyPyo26vPEpUACVHzBovmdYTEeftD?=
 =?iso-8859-1?Q?T+xYtkxdOvcUOVBjky7vHprJCwr3+77M6xCAQPvdNlzihxB93M8vn0XwD6?=
 =?iso-8859-1?Q?me6gl/jJkU2P2KTvBMDOIBDEnDfDMbi5yBJIErh3L3BcfiU4NM+KZuIl+h?=
 =?iso-8859-1?Q?K6qoxzkOoGCogRGuuifarq7Jc3NkiGg26M3rD0THzg5RVcfJMA243WTxIh?=
 =?iso-8859-1?Q?Q5bBrx6InyiQ7iSkuFb445i+WzY80Rr2pSHkKB6SXz+HUHg0iBRGFd/B2e?=
 =?iso-8859-1?Q?++fTDGLxtnrhHQ9sGNlmTAB6sqGkwxcg2iWmGQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?XWDBWRBuxj3Hk0FFOmCD/lim8GMnjnUemC36O1JDQfc0yzJacJo1dn1Xvv?=
 =?iso-8859-1?Q?DrBngvpFgbbcXgxHPXMpidqcFR5jVeU7qx8xy5YBp4edGPD9RhERE773uu?=
 =?iso-8859-1?Q?t5CTNc6oaAv5ya0nmVXBbXl75KxnqTRtwXkjNec2AK9jP0Xwdfs6IUkPxi?=
 =?iso-8859-1?Q?VHXnvWEv3j9Y5Xc4mHrrRKiowCOFsQS7mIfIapZUSHT37NgAN/QhbahQP9?=
 =?iso-8859-1?Q?l0GfVDMQcFGNh4Zf3iqmrVYvydp20B4qWRhi72+BXYcR0ciAp/EVwYLuAS?=
 =?iso-8859-1?Q?IcH01bhPoUdD5ngV0leuPv5Ol0vH2g8AVvsGeoyzFdchTkA/smhS+im5ys?=
 =?iso-8859-1?Q?LaxiD5nJagen1ynrjyz4CJsLQJb1vOCG3eJwp7aeqRmHVoHQ4PmybaAuRE?=
 =?iso-8859-1?Q?mxNqIaiMuaA6SmEl0iTyb525TOg3ObMEW53FamBt824haPa9KhawjojutX?=
 =?iso-8859-1?Q?cmL8qKT2z6MHvHgIH69h5Y/Q+2DnNnYlegLOJfbDS6niWvOBW+6wonaI/y?=
 =?iso-8859-1?Q?Xdp2kbOOr6GrZuCRSu7Xn5qv3dHROxCqF9I/9xKQZICK2T+d5GK8HjLqFR?=
 =?iso-8859-1?Q?6vKnZhshGHqrgZ3fddkeFE6yduj7sD6DNDascE03VgF9fwVYXMEqcjP4Tz?=
 =?iso-8859-1?Q?sXtCIFJr1ewU89dwcQEX9wfzYxZIF/mBMGhT4i1fUKL5GQcRejTLaR/ABv?=
 =?iso-8859-1?Q?Yf7rncfWCJxHZkDfknbVkfI2mIsF4UBP5fMA4T6/3os2bUWrRlBetiQm4W?=
 =?iso-8859-1?Q?/qrix+7bGYi/B7r3GbWRuf9wcEfPSireG9GqR6pPK7WOdmhmfNNZoAbj4g?=
 =?iso-8859-1?Q?bw1/JwSbekVMTM3i19gWbIK4H1a077qB2B+bn7IIuwcr2evGg7Dv7G6OBr?=
 =?iso-8859-1?Q?qWE+MXOjJzC9mJTd2qHbdbjM8l3HeAhdm5vaaJRYLgr5oRu3TpiUqSmLcy?=
 =?iso-8859-1?Q?GX7aEzf5N/BATXPi6hKKRlwEwyI0ayW7N946SZ+8MMe/E8lwtoscwFgPM7?=
 =?iso-8859-1?Q?j1HzKyNOC29qjbqv9BALqKWdad8f9y7hPZA835OdSCXLLTIa68NTdY6TCB?=
 =?iso-8859-1?Q?zcjzKT3PqHttqNClLYVVm+n+dpH4mNUjaI8cYljxQw5pe6AxoRQ2LAR1wQ?=
 =?iso-8859-1?Q?+IiwDy/nmzGTgzX3YJXJ5r1grf2aQFZxPEGTo7YGhX4mhPXc1JO5tdnacz?=
 =?iso-8859-1?Q?0kHnBKDiFMZj2fQcrjLuApKRCBAVeLRRDPwO2zdXG+3YNYuRCVn+ndd2ml?=
 =?iso-8859-1?Q?TKYTu/cxnB5n4nRwr/Bmef7rPoRfhbObyiVFynGj6V8z2Yvjx6VDTAOaDg?=
 =?iso-8859-1?Q?WhpQVC8+VOvE5NWif7qIBx4sC7jMyOXvxSou3q7rMyCEcJmffwGJrlCDc7?=
 =?iso-8859-1?Q?U6zWlt0YNb7MN6WCFx9Yfa1vkynGwLIyukh/wP+gaEgVia+glnI/6VMvsB?=
 =?iso-8859-1?Q?op1+RMngLXsiVMVrJ6UDcqeVjqxGYwdmsrUSGG0UJmw97Kd8bjqPFbUDBS?=
 =?iso-8859-1?Q?eX/XyVu4VBuNJg/uVNk+XGMy6Xqxg0f8uLFUgyyg3i3obu4RzmvVNa2Gt2?=
 =?iso-8859-1?Q?c5Pdu0ik7lsv7x+OwSV2ljbU6gUqam2K8r70a2fJ5gZZFdGqBt6M7MtseH?=
 =?iso-8859-1?Q?RoAEdWiu5iPCu/RrDRXjDia4sA+E7J0stB?=
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
	SpCPeRNQkpZDERC/EO1Hue09aj8PneNrNChoDZEtN3jCDJqn5ob7BeL5J+ij459FuGh8br4IQjQ1nUDhGmm5sy84R/3guWfCd7rzHkWkMhVOwP9SZ1QIY589xpVr2qnjqx11L4bZTniPi/I/KcaBqIzylWssq4YVHfPIFPCr0IMUZyXIWsXm+ipn/L/CN7NInqv5lnudjQY4NyliOgTs3M/rN8XtKblwVruu1SDEy1fM2l0f42b1NZ3zdat1qAQEhm08tBapt0OS7Jt8XyP0A43K3voRyST0iFSRigRI1Qthe2cZxjCTHD3XROG4Zs/ep52EdMj9avax8H8w5m51ORJ8UO/6OW/PYELYjSg/Lc73dY5B7eh48YFVvSKvZ9xMDuhnpG6SfouXa0iL2GlD6IToCj6ye7jF4EuU1Lr3/sAB/mhfnkiDKCq9VNC2Vdvv9GN4dme/MGFi3+eYvKvmU+awTXLyMzeVnGAj6JvD9BVU0wZHL0xy3QrNoAQxHtVn3l0k7vDjzBiqphj+goXxGQzW2j47rtP86jdmT+HebWXbozdbkI8nvQ+V1GXWonxUJDjxDTLiickJF6mD3e4fiAddmo9sbH6vjj6gF0vubGxwsRYhbTx8Blr5Xi1yBwNUdk7MH+x+z5GBUYG5DbaYNw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a775d8-4462-4e35-9075-08dd197b3a93
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 00:32:01.0279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: av009rao1q+P1WS97+WhqmwHR1xqyV9U3s7FsfAZby61AGMaKkxJJD0zSyANY/Y8kyt3tSrgF4o1qVUWGf/M/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7691
X-Authority-Analysis: v=2.4 cv=d+8PyQjE c=1 sm=1 tr=0 ts=6758dd85 cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RZcAm9yDv7YA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=bVWQr8Ic_oZympSaEz8A:9 a=wPNLvfGTeEIA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-GUID: RigdsN1n_s95C0EDm2KMUEaikPJm8wWU
X-Proofpoint-ORIG-GUID: RigdsN1n_s95C0EDm2KMUEaikPJm8wWU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=999 suspectscore=0 spamscore=0 clxscore=1011 adultscore=0
 phishscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412110002

Match usb endpoint using fullspeed endpoint descriptor to make sure the
wMaxPacketSize for fullspeed descriptors is automatically configured.

Fixes: c52661d60f63 ("usb-gadget: Initial merge of target module for UASP +=
 BOT")
Cc: stable@vger.kernel.org
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 drivers/usb/gadget/function/f_tcm.c | 32 +++++++++++++----------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/funct=
ion/f_tcm.c
index f996878e1aea..b35e0446d467 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -1966,43 +1966,39 @@ static int tcm_bind(struct usb_configuration *c, st=
ruct usb_function *f)
 	bot_intf_desc.bInterfaceNumber =3D iface;
 	uasp_intf_desc.bInterfaceNumber =3D iface;
 	fu->iface =3D iface;
-	ep =3D usb_ep_autoconfig_ss(gadget, &uasp_ss_bi_desc,
-			&uasp_bi_ep_comp_desc);
+	ep =3D usb_ep_autoconfig(gadget, &uasp_fs_bi_desc);
 	if (!ep)
 		goto ep_fail;
=20
 	fu->ep_in =3D ep;
=20
-	ep =3D usb_ep_autoconfig_ss(gadget, &uasp_ss_bo_desc,
-			&uasp_bo_ep_comp_desc);
+	ep =3D usb_ep_autoconfig(gadget, &uasp_fs_bo_desc);
 	if (!ep)
 		goto ep_fail;
 	fu->ep_out =3D ep;
=20
-	ep =3D usb_ep_autoconfig_ss(gadget, &uasp_ss_status_desc,
-			&uasp_status_in_ep_comp_desc);
+	ep =3D usb_ep_autoconfig(gadget, &uasp_fs_status_desc);
 	if (!ep)
 		goto ep_fail;
 	fu->ep_status =3D ep;
=20
-	ep =3D usb_ep_autoconfig_ss(gadget, &uasp_ss_cmd_desc,
-			&uasp_cmd_comp_desc);
+	ep =3D usb_ep_autoconfig(gadget, &uasp_fs_cmd_desc);
 	if (!ep)
 		goto ep_fail;
 	fu->ep_cmd =3D ep;
=20
 	/* Assume endpoint addresses are the same for both speeds */
-	uasp_bi_desc.bEndpointAddress =3D	uasp_ss_bi_desc.bEndpointAddress;
-	uasp_bo_desc.bEndpointAddress =3D uasp_ss_bo_desc.bEndpointAddress;
+	uasp_bi_desc.bEndpointAddress =3D	uasp_fs_bi_desc.bEndpointAddress;
+	uasp_bo_desc.bEndpointAddress =3D uasp_fs_bo_desc.bEndpointAddress;
 	uasp_status_desc.bEndpointAddress =3D
-		uasp_ss_status_desc.bEndpointAddress;
-	uasp_cmd_desc.bEndpointAddress =3D uasp_ss_cmd_desc.bEndpointAddress;
-
-	uasp_fs_bi_desc.bEndpointAddress =3D uasp_ss_bi_desc.bEndpointAddress;
-	uasp_fs_bo_desc.bEndpointAddress =3D uasp_ss_bo_desc.bEndpointAddress;
-	uasp_fs_status_desc.bEndpointAddress =3D
-		uasp_ss_status_desc.bEndpointAddress;
-	uasp_fs_cmd_desc.bEndpointAddress =3D uasp_ss_cmd_desc.bEndpointAddress;
+		uasp_fs_status_desc.bEndpointAddress;
+	uasp_cmd_desc.bEndpointAddress =3D uasp_fs_cmd_desc.bEndpointAddress;
+
+	uasp_ss_bi_desc.bEndpointAddress =3D uasp_fs_bi_desc.bEndpointAddress;
+	uasp_ss_bo_desc.bEndpointAddress =3D uasp_fs_bo_desc.bEndpointAddress;
+	uasp_ss_status_desc.bEndpointAddress =3D
+		uasp_fs_status_desc.bEndpointAddress;
+	uasp_ss_cmd_desc.bEndpointAddress =3D uasp_fs_cmd_desc.bEndpointAddress;
=20
 	ret =3D usb_assign_descriptors(f, uasp_fs_function_desc,
 			uasp_hs_function_desc, uasp_ss_function_desc,
--=20
2.28.0

