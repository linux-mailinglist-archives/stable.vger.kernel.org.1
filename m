Return-Path: <stable+bounces-40054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8AB8A78D3
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 01:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B43283045
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 23:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92B213A890;
	Tue, 16 Apr 2024 23:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ulMnQY0h";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="cQqm61AH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kWGlXm5R"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7BB12E1CE;
	Tue, 16 Apr 2024 23:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713310901; cv=fail; b=jEQPWY+TYB/aNRJGkMNi4C3BP7wzjq8DHo5qn42Se9Tsg42EwWD1m80PkAWUAtejeRKPnHGOGnz/EFkE1H2Go4/YHht/4BzCewJqhm4tEnBniz5GEOOj7b7hLqooIHmveGCZJ1UZ5J0wzadmZz1axKpQSWoZihpwA4yc1DIq+y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713310901; c=relaxed/simple;
	bh=AmcHk6Y7ZBIrC6mSHX673dEAoB4QuyJNax5FiRDytV4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=arFYH82MJ2ayZiU66wQtfPMtQV1ZAHEXJtOLrpzdMoNnh+Y6kD583lsfPWsdcrlhbhPU6oGw5XmtZJgz5qSDG99uE5w0PCTnU0nj6a1ZsO7PzpMRqOpNY+6j6KsqTHHcEJlF2joRKZU8L+KtYo8rsNfk2OTa1CNE3mkUSpwZFVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ulMnQY0h; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=cQqm61AH; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=kWGlXm5R reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43GHbY5f004308;
	Tue, 16 Apr 2024 16:41:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=pfptdkimsnps; bh=0tmI
	XiSeifa++Dof5FOurQt6o7VKpYZdEIPg12DXB6U=; b=ulMnQY0hmcAsvire5kyl
	3hjIqQReLuUn3iD5u2ZOaEEVBOfj+NACbQVgDedAUkc3QjZ+X1UuWa+x7tsb3BCS
	r6ZfCuT9AmU/lDYGfCwVJRBtL9AAhgaRLjwog4tn5TRWO6/C+q4MRSBDvUtjuL2q
	k2T2mxm+dzqGEgbCE6Ccu9XrQ4dpmJEW88CagHNPYAOAVGXah7532TxOnTe3Jq/x
	/Z4rcj3iQzye8dcZPi7zTH5F5AyathEUjtrkVwzKTRuc61dJJoyKtAXFAReR5Baw
	le1zmc/+u4yYGOhvgmB3FVX9W60UUWmHhAp0IFopA/MkliVErh3etjsBZlp3UsWx
	hA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3xhrretp6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 16:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1713310895; bh=AmcHk6Y7ZBIrC6mSHX673dEAoB4QuyJNax5FiRDytV4=;
	h=From:To:CC:Subject:Date:From;
	b=cQqm61AHAFRvNbZa2G+3RpTepTxbu4sppeQ1rF8VMGj2hBVIZJLeJ91jdBbnktgRT
	 77rHk4yVIzRIWR8uBYtSx6Ef9qkW8VGG8a3mOL//Y9g+NBOxGat/cGCCeh/jE91T0l
	 VbqnxPtBDYWVNkiipp+IAJ6cYS8M9ljofoPK9ucqomJBKmi8DGVi6i6db28EYisn8p
	 XcLzNL+2HsOLXuqYk6f7Q/7/ke0wz+S6hfr7vF6fNxWqm9Gi4qhePh/9LrVJK1/nRu
	 8wMPIqoJKU7wgkCqUOGc9yKRb4K6Ge0CdRjZ0mzKbg1uWqRzVTtEJjUbm811cyXJYo
	 YG1JLQFu90/NA==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2883F40524;
	Tue, 16 Apr 2024 23:41:35 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id A243EA0081;
	Tue, 16 Apr 2024 23:41:34 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=kWGlXm5R;
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2FD1240363;
	Tue, 16 Apr 2024 23:41:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOEWU/ph8kWZYu3eFTlyaR3NyHDdS0C8fZAGtBfvs+Dfv1A2/0dXm3WIYgAAnmH169JvtDVtLS65wtK1GnowqIig//B0+41Q9V+FkAsOG7Sysi5TOyeVXCgEaQk0KDk+WT2dmc4nM0pSZoFrDT0v63ggV3g2ajHkPWHmB2TgxvtE4TuZNC2kPf82O6UhE0xvpzMjkojq01My6Etz/iW+Hm13R/hrwo5cbyQeaQTZje8qKbApbBQ0z1rkCNrKbVYQN/I/scsg6xdkja9HEDgRkZ6wNHV8E7AYD7eToG17LMUTvZdMyAsEd8umldeSdrsp7RkQM3uBQbOiYJnGkLWyzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tmIXiSeifa++Dof5FOurQt6o7VKpYZdEIPg12DXB6U=;
 b=k16SK1Ig5NVGUHaLYzwTJHca3JYxfj4aCeCgQVf13BdKdDi0HbpjFJUn21GfkpK1AY8cQ0SGIQDc0NkBKXTGpyNf/8srAAEAzNg7IeXcG9vibvMvtWeOz3swSC+2OvFNSZsKaK5nlm44PCmvtI3B6+jTcM6gBR2aVU6MpDcmZbPj8mSI0ewR2SlTsNubREFfNCJ+hHnqX38R5J2wg7AV2qfxh4ZD46bSsm4HFCn3oYAHA7a4LpzXtjxG+gYZaGEO1kJAorDNa6pULfkHUEJwEHlhWS84O8kV63le1T0TJQFzdHiLP0EumhqxG4b7COvG0rfVfcr8xtJq255GWAVSUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tmIXiSeifa++Dof5FOurQt6o7VKpYZdEIPg12DXB6U=;
 b=kWGlXm5R4O9ixBw97vCbfGeibrGt4f/Dud+lD2WR70VcsxTqg3OqOi4gMQyJ+AchG5ZPGGdXTZZgBwsLucI8lmIfNLaEO2LSRIICpGUqbW2CL0O4iUejfq/FeXYFykjkN+qcay4QqeD2tJWHW+2kkrfFwJmN7hCC5A4XCSq/cgQ=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH7PR12MB7818.namprd12.prod.outlook.com (2603:10b6:510:269::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 23:41:31 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 23:41:30 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC: John Youn <John.Youn@synopsys.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 0/2] usb: dwc3: Disable susphy during initialization
Thread-Topic: [PATCH 0/2] usb: dwc3: Disable susphy during initialization
Thread-Index: AQHakFebQhMNQBIbxkOKhwsY40FoTA==
Date: Tue, 16 Apr 2024 23:41:30 +0000
Message-ID: <cover.1713310411.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH7PR12MB7818:EE_
x-ms-office365-filtering-correlation-id: 0d6ed6c8-6d80-46f1-d074-08dc5e6ebde9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 W8C+G32FyjVchhuCrVx0jGd6ggP21/YimZYTZVfs2HW+mPp8ZvK7Mo/u4TNrpcTQNVyBPlK7fOLv4StF3a4+dBisxFEOvQxxqJ5z4pFoSEwuOzxGys8Z36Wtt1jwEvc4Oq+3EU7LEzoubARf/7vZh1pUePsqgfazjPu4LVuf0MtbuKSvivxsRFDZzdkciDr+kc/jhrCS5IRAHxgksryeaeIRC/aorN45uJxgHHnSBLAQi9uxHeKPl8Y06wMTH+2Vys48lCwcG9v1+154nix/IsEMp2pyCDfboyt5PmcnDEDLEehGGeYmYUwDsqx6VqfvmuxphEZOw3+v6g0AuSfZmDn05Z+jfgzAlDvH0X+P6MwlExHkvzIe9NGbKWlEFvNwC0h4Sn8kHaNu52iWeQ/XsrPsQQWJYuFamDPxJDO6MD+3tSDukpdMTlHQi7rXJny7DFuUDEmELXImFj2T+tYp8AaiPrfbWzJFrnZIomSlXNC1GcXSwzUsc+H4ZQq5zXfRxiG1PNPsxkNnyd4ivMMXOSu/8kQSmqtojgfaK128YsF+FONWL3kIFtATgQahD1Ce4vYcn5qNRbtIH8Er9XpmSJrtOY5iwo1Z1/F/SWyoTt2C09Tc1PJsILFsXc1W9/3I1CRzmAi5ldAjUc8NUvhrpq+dTv5CINuReMdVG8SS5MuXptnND5aTOamzCDIfCQSYu9lbFiPmRCy9eakTxu+zcRMLLSkUMuP6wQL3roPjkNI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?qWlBSdYydTq9797uIWmIRii1qt2hKIAhnja4aASYfAqkZCl2hQ+qRRlftq?=
 =?iso-8859-1?Q?iW/7N1T8HwXV8eO+JD7B4RHFFmOFdqM13M45cfKgzSaAUa6k3Q8FuyqOxE?=
 =?iso-8859-1?Q?hIW+UaDcJyorn/BJkRiLtP89++Y39hfz6iFLGWCTbdzNZZCsYLrCnZGItB?=
 =?iso-8859-1?Q?xboQuBLs49Rec0Oy6ZTnzA12sV8PLUWej4Roo73lq2Yw+GBp6Mde0Pm7uu?=
 =?iso-8859-1?Q?KROHQU0jhOoePLGNEhdpkRHgvDI2C0sCAdn7ZjVMaOZlIJqgwgIN1x+ND3?=
 =?iso-8859-1?Q?WnU3JCsE5n39yJgMdNzT25/1Z+gQB9bn9oAm8vTWdTsd6JdqIm1zp3ZaGj?=
 =?iso-8859-1?Q?VYgflrUSmxenLdGQMg0NdjfkTFy83IpN3i/fCGm/1V4VMjegoQY+ovxJWZ?=
 =?iso-8859-1?Q?5N6ThA3K9zjpoIkKu/UFEQhuASmwFZ6FfeldysdpdBdmyTDqKCuRhFvGGc?=
 =?iso-8859-1?Q?yTOkgDLuBmFKlavjeHF8QxmUlStbmAW5Dhjnw+7gNnpHnCvw3LNSn/iCsv?=
 =?iso-8859-1?Q?YkJWc9b19Vr9lfIhQaB8z+0u8wzbGUHOy0aVYwuOd89p7XWBnV0KYAKd8T?=
 =?iso-8859-1?Q?ZI6Nc2/4sZW7wOMrQP0+UtysJAL2oA1t+DMPc/SjqFjvlCu+DhoBik2KrL?=
 =?iso-8859-1?Q?fkjZo1PfHMd2e/eRx90+Dpip8+RChzVf1aKnNenfHQ5HR0BGfH+CeEdjkZ?=
 =?iso-8859-1?Q?VWhjcixm5rfFPoN8qy4Bgwb/7RYNIohRKJR+byKrNGO4+5ktghww1uEgO3?=
 =?iso-8859-1?Q?f1nQ6g0TlIq1j4Un2WeoSmqiJnvDvp3cIcuJmtzfgRC/aXFIRWiq6ad9Q/?=
 =?iso-8859-1?Q?qBioPJwHETPlnl7xD/zqHW2/lLv/DkvREHO6bWcvaNsjrAcDy7A769O+9J?=
 =?iso-8859-1?Q?/Sj43qu6jhPYvUDI1k+cuwLlqFKVKgeDMFnJpfwbD311GQd/GtQV7vREtK?=
 =?iso-8859-1?Q?ZK8KqVMx46+BejPmrOGwGGl6KrDkCIMvBjE0Ta2WPSZQmw0yU3CDfP8K75?=
 =?iso-8859-1?Q?a6Wgpx5IyXdS9wqv4FjMmazZJ9ERPXW2LLHriGI+7OXfrqaIzEIsLDYaGj?=
 =?iso-8859-1?Q?XEuXKr1hCLuSPdOu5NOtLnUq2Mdro373+KHB7hzzTQCO6kWNFOMZDM8Osn?=
 =?iso-8859-1?Q?4zM4pY7XtGxjGC6WvtCmUU1j5RvnXyiDvsscyqgWMWRsRuw6zytO9wqoYa?=
 =?iso-8859-1?Q?cuzzfYcrwR221Qz+TmsCjwK8FFQYy3cmeduwDpnJTERkjNjLVl3b1jQdwu?=
 =?iso-8859-1?Q?Vqhuhf6wFr6jjfb3BxQ3oiXOZMVY4eOuMZpZI+yOrCWd9r1UfPBq+bJamo?=
 =?iso-8859-1?Q?zT/pqDQ5WwPRb1lf36IIcCL2qIW1ppt4SI4xy0jbKSXpQXjv4tkkK4Syxa?=
 =?iso-8859-1?Q?n5gk6P6G1OmmbYaMOrO54/KuWJuoCSLar5CoufE3jA65lMVm2WAkccTMJM?=
 =?iso-8859-1?Q?6qihe4FWHSG60r4gVzJ1BRRWbHcCzk1/fzZhI2QMc9vNfRZOY1MECuP2Jj?=
 =?iso-8859-1?Q?GrH+JjyKMBDMRU9zSDQ+VCArCNB0RlxmsqOXqBP5227pfuTHHa9ZrX0fVi?=
 =?iso-8859-1?Q?ygroeezaHsPauEk3oG+BDKMoLfzzJjNSjXQFjORmISfYdsQomJtRFRrvw2?=
 =?iso-8859-1?Q?PwgDRWNPl0S3PWhXfQcYrCgr8u4oNsKMAb?=
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
	o8UdeFAzviIbz7FCDJYQI9i24jsjPdLaSWUWBPcoRJrRXypq4S5oZTHunPTT1uBD62y87//B4ZeGevhxMGdXqpO23KNagikyH+nEJmVostOXHvdrQ/NvbSbtfM/c2WcVBpeKQ0PfufdXvW11AA7U8+pqS/AB/Vi+hM19NDD2jjLf2iX6BBowtm/LdbiObNIxar7nnjNY7ThUYsp/xMrvGH5cG21GbTokJWiYLr39xb28xsrvbMV9k5FrXOq9Tk9uZeFpzX+MiXROMWZ59/D3FnmpXpuDyloquuus5lP6mmNEh7A44YazmwoTLZNdyoSD27KwDPScTMqLt8W9HwuEWPCJsM7JS1NZGMbMnnxovpQwqPHEUHEccb2+6KNW7cPV6gH+h+43M3cQd6icrrxTtR3a78nZZ7pTGISnKkhJyHG6ajpEJcEmJzmQ+WqZypax4bKj9aidVs8aPvowNhbXOHUxnQFIOk5oMkw68IDN555pRui3OtEwrlrWbhRXr+IC2wBck8jBgs6gwF5oO/MALFbLM4cSqDTUNi2BWgS1AcxFVFS2T3D22RBnKbu/SOWeDqGdJ+R93leZHk3G+f4WRlMII/ilu75FIwux3cWUnjGlUapaSKwfutYzo77zoPrxqWTFpxn5NiePiLzruCXhKQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6ed6c8-6d80-46f1-d074-08dc5e6ebde9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 23:41:30.5377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nFS1ghYm2cfnWXKnqkkKnxOT+xLuqIzK59fdJuA2c0h/ccdhp4W739f/a5egTS4BUGik1Sdpnqs8dQ6IY7VXeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7818
X-Proofpoint-ORIG-GUID: y2rV0c-9yu0HM5H3f5q7xjYkfiy6EEmO
X-Proofpoint-GUID: y2rV0c-9yu0HM5H3f5q7xjYkfiy6EEmO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_18,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 clxscore=1011
 priorityscore=1501 mlxscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404160155

We notice some platforms set "snps,dis_u3_susphy_quirk" and
"snps,dis_u2_susphy_quirk" when they should not need to. Just make sure tha=
t
the GUSB3PIPECTL.SUSPENDENABLE and GUSB2PHYCFG.SUSPHY are clear during
initialization. The host initialization involved xhci. So the dwc3 needs to
implement the xhci_plat_priv->plat_start() for xhci to re-enable the suspen=
d
bits.

Since there's a prerequisite patch to drivers/usb/host/xhci-plat.h that's n=
ot a
fix patch, this series should go on Greg's usb-testing branch instead of
usb-linus.



Thinh Nguyen (2):
  usb: xhci-plat: Don't include xhci.h
  usb: dwc3: core: Prevent phy suspend during init

 drivers/usb/dwc3/core.c      | 90 +++++++++++++++---------------------
 drivers/usb/dwc3/core.h      |  1 +
 drivers/usb/dwc3/gadget.c    |  2 +
 drivers/usb/dwc3/host.c      | 27 +++++++++++
 drivers/usb/host/xhci-plat.h |  4 +-
 5 files changed, 71 insertions(+), 53 deletions(-)


base-commit: 3d122e6d27e417a9fa91181922743df26b2cd679
--=20
2.28.0

