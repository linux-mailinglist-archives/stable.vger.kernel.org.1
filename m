Return-Path: <stable+bounces-141825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AE4AAC7F3
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 16:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE4B980262
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 14:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945DA2820D9;
	Tue,  6 May 2025 14:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fyaloKTM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OQRTxTAR"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C14327E7EF;
	Tue,  6 May 2025 14:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746541742; cv=fail; b=S0y1bOeIHpJTzQrYoB7Z86bAWAYvT8dSAwdrXGuZS9OA/Tu1/GD2XvMnyNCXEwtLYqw7O6LDJvd4GRqogXHWe50SjVkMDJklQzK8y1pCPISeGaXspl+PYF+49ZVu8Hyu/6lXIaTGSH8nWrmL49Pts8QiqIF5nT+OuNA1ri+DOLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746541742; c=relaxed/simple;
	bh=2CGHR7b7bljilLl4eyD7C4KOLhHy5opA6KkScGcLHZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fQIHb4D70XIzIXmVE0CSMFUMMoemyiTBgl+enqOk5JKj/snpEH/qWD8JuBR6StNhz0RgA15LbVXyap2wwUqxaeSITxzupSkCUzYSlW5GooxUOewadjHrKmXsCbuM9DHTLeTBW090IgxAOxhcVAhglU3eyXZj0Z8DqkYNjo/REv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fyaloKTM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OQRTxTAR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 546EH99S005642;
	Tue, 6 May 2025 14:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=KIoanPLB7mlbZcFQP9
	kHB4F/GMv6u13HLAR5OwNyVVQ=; b=fyaloKTM5IRsKILCGRW1v6v0rfvoLpKIbE
	GSHct2f9zy+rBdUGwsJ5FT2cwi1TNOir4q3cnulJA9sHqgKjg5hpvExHZAXWd0Ei
	1P0BtKaF8R06W4OWIARnVpG6hv4nZe6EQm25yAzsoA2s5xDH0JDu+ZBh5roHRInK
	8oOD4iD5PfQkOftZT5qTueeSc4Q2PwFM85rnr/u3gNz/KNsixEy4cprxrrhHuMs1
	ri/4cM7lXij1Le6u6LX8f7y+wZVdD9l4w5aPbQ06KSzyE5LzDuYDkOx5ts+LkMSf
	qCGFWF8TLC5a667Wyawgdwy+HbGVSO/t66T15bcWNiXx7bwbuVVg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46fm22r1jb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 14:28:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 546DbsOp025022;
	Tue, 6 May 2025 14:28:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kfb47m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 14:28:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPq1edsE9nXZaAOJu1eh/cQyOJjLm38A0v/fdStJrqMIPu6oykDD83Kh0cvRzJFUNNsPKVfabkoareXOAeJZ2X90R3mMzaMzgFTqGV+cUaWHdJ9ArFgKKRPFJgNzzT+SOtAznvWszW+8gbyLWs3GtJml/lz00NCZ1hYazwr8xk2DaiRHBno9kqU4psmxMOJVPWR3bDWU7QuWIwstqse37iEw3Si0YbreBv3ySrmVUGTHDyfQzlG1wx6Pz0btg44Tl/G3tfBAdEf3doFQOyBY7kfRhx13PaUoYiZrZ22FPXz4SDsaIWX1rPM4BgRKacEX8VWQXT9+VQ43A0fPzPdxBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIoanPLB7mlbZcFQP9kHB4F/GMv6u13HLAR5OwNyVVQ=;
 b=C5Qr4dNuFs8ViaN6gMBeu9fXl/Lpt17o5D1xgnTBUNoTIbTy5Y5Nywee2yVVAFltVqEOApXoOp+jq7rctY5Hfci+RsxVv8wHOWoLI1kzQZ4Dlk3cw5xtyyy4vZKBn9KWNZ6AQDqSMq43c5jBcbHc0v5jgJXV5swX3KXmI0WRoTZsChZGYOfQZegDy9ZacYQsK/pLu4B7+hCD45/JysfwrIFdCGqIiBFREi7qkqU1BtuN49TLhPv9g0i/NkiVSsr38PlnoFZwJ6xzqJt8e6JXfkdkwrt8KAZYhGOj2+8Onj9S9mZVhEwjxAF1oX3NYd8qb3aysopsHh51OJFduUH0xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIoanPLB7mlbZcFQP9kHB4F/GMv6u13HLAR5OwNyVVQ=;
 b=OQRTxTAR8FwJSka7F7It1wAUzOhxwli3DcAFsxJenagQvK9EOEdfnh/275NgkHKJVcH6yIPtrXFXui3xTQpYDPfS02OGDfsuKtZKGHApQrmjzdoTqW8MkRvO5w77yj7BK4KW7xeEeTQj4r7En4ssyIVlkxtgidgafGeSOERP84w=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CO1PR10MB4658.namprd10.prod.outlook.com (2603:10b6:303:91::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Tue, 6 May
 2025 14:28:40 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 14:28:40 +0000
Date: Tue, 6 May 2025 15:28:37 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Ignacio.MorenoGonzalez@kuka.com
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        yang@os.amperecomputing.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 0/2] Map MAP_STACK to VM_NOHUGEPAGE only if THP is
 enabled
Message-ID: <5ebcdd05-1c82-428c-a013-b7757998ed47@lucifer.local>
References: <20250506-map-map_stack-to-vm_nohugepage-only-if-thp-is-enabled-v2-0-f11f0c794872@kuka.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506-map-map_stack-to-vm_nohugepage-only-if-thp-is-enabled-v2-0-f11f0c794872@kuka.com>
X-ClientProxiedBy: LO4P265CA0048.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CO1PR10MB4658:EE_
X-MS-Office365-Filtering-Correlation-Id: 029e3e65-9031-4d56-2acd-08dd8caa4c16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bHjrXwkvPXKJw4dS1tL09aSBFcA+AcwmGTy8f9lC2wDxx4zplEwYxS5uElLV?=
 =?us-ascii?Q?GHy0VAutK6X+G9YsCusNbofQgH5PhG217+MvMtHipDkkpynEXQN4xDufE3Eb?=
 =?us-ascii?Q?TRPe/Qc3xB8g0djZl+XgquwEVMtm5ItCoNJcDx/9kLL8cdiJMXAzWQffr/OK?=
 =?us-ascii?Q?K0AG6HyjdEk24ZzfaLmUc4oR4cIYXhRfqi+lxesC+HwBqqvhDrWi8qtVPFOK?=
 =?us-ascii?Q?ah4SlRu4KH+22f+4DepllKcZW0zy41E5LI9yYwDh/dkOT7F2ooLv6gd0Afg9?=
 =?us-ascii?Q?UEJdOTaguVpCiK61gaXN/Y9LE6tZAoAtVkAOJr+5mhxcLkTduAYE6kKQ6CP5?=
 =?us-ascii?Q?AWhgYTgHaMUVLJcx2DSVBTal/QIebuSfH7kx8ESiIZxjIOipUWfEmu0BqLLZ?=
 =?us-ascii?Q?uTKBNZUUSbkGWSbH5PAtT8CwhG9Se3wH+KrMZYHLqFkizTgGWMFVhSJdqHK6?=
 =?us-ascii?Q?CTp99URUkHBdhCXrK7nSeO326sr6UwxyjdahxJPqO9OGwV3sOaIzRWhdyhJY?=
 =?us-ascii?Q?Y6GJ0eYZW42XeVsLNFkPOFd6LYd6o4mpPB/n7w4DbYoeLy1ASEaiowO6kPiZ?=
 =?us-ascii?Q?Xj7DEt4WK309K8q36VwK+O2yMPD694BLQ7pxDjSKpn9RafvbnXPsGIVyZcNq?=
 =?us-ascii?Q?YS35F6HdE07/EnxG9RTkW32E5toyIyNRXa7cOLFTXlYU1qUkdiQgz7ezu/Tw?=
 =?us-ascii?Q?2HmMEzmaSAAoMJ+eIdkzK5F94fF1DBJD6CWzdvI5gGVcOdIag40mMSg2RXuQ?=
 =?us-ascii?Q?Q5j1J+r4TLmB1f3TPUpcFH/nMtiSat9/x4qbhRJfS02CIFVFX3BwbADkZSTB?=
 =?us-ascii?Q?lLnpeMs0jUnrDzgu/2En/vU9iMWze6yUBwLipfFDIAzZNZH2ApYKph0fqtY4?=
 =?us-ascii?Q?woIZx8RY8k4TZlLZPI3+AApAa0tMCzNEFTHtRxqKt2FmY9QXSE0yEPlBFOLY?=
 =?us-ascii?Q?CWxP1peK4MGhRWBoDCgcQ2aOJZyDuq7H8AUQVIKnLpTDcLGYf4ZZTM1an9G7?=
 =?us-ascii?Q?yZy2y0iKTnktk2pLW4AaZ8M2u3e+oo3IcHsBAPonIakFEDS7ITUaXtTNAMTK?=
 =?us-ascii?Q?Fkkr1dEugFxM1fYZlQzLVgiz/zUVCof61FAH6iX0vqIxvM/LWvRo3gwC0fn0?=
 =?us-ascii?Q?AR8P4eqSGffz+b7ULpr6uh4GnY0YrYeZ113ceL6VtkJm3zraFlq0NrN97Sg4?=
 =?us-ascii?Q?XYUeYoe0Cf9BRPU37X3Cq6X7fFBo7ljJKme+QvtF8EtlfWvYlj0hvPhROIqs?=
 =?us-ascii?Q?/Av7Hl+tTnOkUYWuhU+gRHerdikn7NAcRA0cblMgabGRx+ArRxO6/65SlZZg?=
 =?us-ascii?Q?nZnmDOi2kIJ+xHWMBBvKfsKja61+K0iLBNB2ewSTErB4EM3dwO1UOobmqkXC?=
 =?us-ascii?Q?SZWpnbYFA/PBje/j7/+y1pS22MYVzxuIhapQtaB5ZhNU4HRIkIUTxZE4g1sq?=
 =?us-ascii?Q?p5+M0djN5QQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lb5AyTkkhoSy3r++BFImID9mbwl6qmdF0qSCX83LjmJNQQyS2MEhgfTXtOm6?=
 =?us-ascii?Q?FIpxubySuWJ7MFnXxZoERjRQpUCu0wzhm/32sP2UaJgtXxsa7OXQLer+A3c1?=
 =?us-ascii?Q?ArFMUE0umBj0uZDP6SashMDcqFy9C0v/j+6SreHY39kk6lN4vL0er9sjcRKS?=
 =?us-ascii?Q?gQUgU9X2uNipe2BB6I02P6weIrv8ApFwqztJ3ZaTiRn9NCmaRBR6ajyrREt7?=
 =?us-ascii?Q?zWuWpQeirz+GY18wj9r530IXnM3SGsHS7YfyBILv7Ry7DOsNiQEr6er6rmNb?=
 =?us-ascii?Q?Jhw1I87a8BFEdbBFmEUrr0PvrwDGktRVs7ULK5A0zHQr1/4QjFvTr3PwoBap?=
 =?us-ascii?Q?XfQtdL3oypwgEi6bQlvHQ/6izSfMMlj9fAYmbNo0tfPrdPHmspRr5afLdhJp?=
 =?us-ascii?Q?j5br3flbX0BieyQqU3cw/vUJjuCgPuPfgLSnY5X0Vt+rfHtqqOeLUZctRzlo?=
 =?us-ascii?Q?uBRnR2SxpmWSaQErIADcfJi/Xt3UCeiDQocvB6GhAuhyfhVTO6uUeCtRaSk/?=
 =?us-ascii?Q?UgzsdfVPfJq0mSqp1en/H8HqVLA11NhrWONZe5ICDU/7zMuK2CWMi3e58RV1?=
 =?us-ascii?Q?L0SwREXYrSR0iH0qLa1NIOuo96Wzv252S4tTqZi+YYOjwgOo6P3LZC7dHB5e?=
 =?us-ascii?Q?WMkbZcc9sGjrXdHnVJpeUjlb6Cf7pV4uWgHaiSXINxmPe948qwjlrj96y3Tr?=
 =?us-ascii?Q?Mtuc4R10O0kQpBj+aDFvUqGdHO0b75nRmj5J9DqkzRdbKDCej9xsYwZ2F6Nq?=
 =?us-ascii?Q?4iJKg6GvXMrMmGH4SBLQJJNuWt8DxebEGxFzmBT16TcJ5MvbQiU6kfR9bj0w?=
 =?us-ascii?Q?ObWTjHS6mmY9ig8LQgiPJUp0SvN2zTCbInzW+e0UPRQXPeRuVzcv9/KL9FRN?=
 =?us-ascii?Q?I0uXM4qMuPGx7NuGWqHzxOkD0Sv9HFH+u6PdHQHhTdJmAC0GN98jr4LlQXFu?=
 =?us-ascii?Q?EVXuhVGEdDRcHB+hI6FQphB+BnnZ6rYcMe5LSyqNqXcKqHQhahTulBaYulYs?=
 =?us-ascii?Q?2RjTWuJycpKHFZj0C0axNtCnClUaquM7W9JfILI4z+tiM8YGcCXApI3/ZV4R?=
 =?us-ascii?Q?m9Cq/xC7mnKpK1VuzXJI/ZkP20ZETV83hNwY8VeORlPz+QQMuj9AbvzWa6aO?=
 =?us-ascii?Q?NAek9w14VEzpMm97iTKZLqG4+qpXMEBCR8QrKqnKibnU2lLv503hosY6Rd7K?=
 =?us-ascii?Q?KYldYUP7EW7rwxHAaIlyIeBvOrkoVDKsQdnCGGEItb5LJe/SjmYRNWq7AgcD?=
 =?us-ascii?Q?yryn0QshE02LCe5tyAOtzxFSgbtGElOTFotjmL324lUemdeJ/Pf6LaSBnJ+W?=
 =?us-ascii?Q?FFJTNqhT6GyX2EYURC2/SnZYHMa99rJmLo50U0Lm8i+Vmr4jIAPyDIhNohhV?=
 =?us-ascii?Q?efLc39C9HZ0Vy2v/zVW6cc0rrv1CKsOnWJWo6j0CZjaOspDYP2bLplc5/Igl?=
 =?us-ascii?Q?pARcHhbSpzjcQAYEZc++y9/6pcaUlcBWGStIZrAPgo2ze4iWvkxtXwwvEC11?=
 =?us-ascii?Q?wk1zOrbtdUii9CwG0xJynDK64qhnNgu8n5sEy6j3+kARRK1urhjega1HRH0w?=
 =?us-ascii?Q?3qF4DjGsh3mNy0xmVIDaxfqkXrJHZuJt1QLpTV7EyXY2dJlW23kFL+npDjFw?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yvg6/MizoFQuXC/Fc7LiHEhLth8ijcXa8IwZjFV3LcSwPWLrCXJX36XSxXOfrSdxReYw1ULuPCUAgp+0BOdA/eTlF/6yt28KpBDb7bvIhHJuTXrHMCF9nZI+dGLJwaBKvu4C4M/MXUPqfiLroN/YTwWRHPndARuDP+I0R2Cp05chuJ7XMlZo8vk5800Bm7op+nqGsSPN94TMBwG1pdxCiObrB6Zvbh7urGSiYMlWJTH47uiX3fCKOE60p9wO7zPPFRP/GtFuZfDuWUfKF2JkR35JUsUo8eQg4b999tZ3peH1EvhnJ3Fjt6fWeHY2WWIyWt1PjKCzdG/Uqt1Og1CzXQmhvY3DIb1embUb1s6OqjaF+KM4JZCmUnYmhnWzJKC17cRDG+GEcH7pQH+70fIKaLa4hnMAhPMaKlT/ED3cMXhtg1S3p6hAytbDulttp20uBy2qfsOJQlSPk8gQF7+3gCs6EUUQ9BaUemgUTBFQcZoq5vJOxb9bKGjX1wHryMixtF9JY24sSKFxNr2jfyQmGpe5QMXA1PRqNQEC6bU16LmLPQQnZaSngksw+0D760nPOQWVsSVEm1q1ca0yBTPBPgwqHaC8Jn7FfimMqwgv+uI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 029e3e65-9031-4d56-2acd-08dd8caa4c16
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 14:28:40.6334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oa2DH356xP60eCR3JCxU/fxkzH9I9GkUX11PJ8IOif7KPZi+ZfN00aDWW34KC4nSGh5Ef6BaAHgVOPKOchl2DQLQFkshsxFEMkgmd+yDwRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4658
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_06,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505060140
X-Proofpoint-ORIG-GUID: wuZq1a9eMG26SXfZfvlu_UD10UqMgAEf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDE0MCBTYWx0ZWRfX0kEyurjDxXBw 3y1/2bG5QtLj9jJcJ99gqE6ss2mPT/hWtvZtYjYf8yHWsZqnbSMV2Ve1DXzqs0w7/XXd6XOFJN0 SrZxwVsuQWZHhKNfYW+uXnIIqudjdm0X7HTc64WUxJWVsV7PITT5sOplswIuvIpKlgzyzDP4hUg
 dP7O7YwEpy9JLjEBh1gS1tYR+6re3eL9YM9f7DxhcKmyBGsbdCmFDE/Qm8kiKnKsJ7fA53rvBiG vYJpp3K2IroUCX6PKOfE4ngNRwxfmw8F1cwPhQwREoh7WPSMJisYNtY8JIS2qwy+cXTAruWUXUT yXPX9Da3cK5E17HEEBcVsaG2rGVJ1Gmr6runCDsJnO8tSXrppN1keyk+Fw6azGKDjaZiigZBmyF
 13ntv8YcgqbMh+N1nOLn5j+0fOMQNnb0SPmQZ3BRbrTSwOGslUf2w2zb3me+Wj5qZ1Cr4qP0
X-Authority-Analysis: v=2.4 cv=ILECChvG c=1 sm=1 tr=0 ts=681a1c9f b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=TAZUD9gdAAAA:8 a=0l0vT_WQSqFZnbCLHY0A:9 a=CjuIK1q_8ugA:10 a=f1lSKsbWiCfrRWj5-Iac:22 cc=ntf awl=host:13129
X-Proofpoint-GUID: wuZq1a9eMG26SXfZfvlu_UD10UqMgAEf

On Tue, May 06, 2025 at 03:44:31PM +0200, Ignacio Moreno Gonzalez via B4 Relay wrote:
> ... and make setting MADV_NOHUGEPAGE with madvise() into a no-op if THP
> is not enabled.

This bit probably belongs after the rest without ellipses :P but it's not
important.

>
> I discovered this issue when trying to use the tool CRIU to checkpoint
> and restore a container. Our running kernel is compiled without
> CONFIG_TRANSPARENT_HUGETABLES. CRIU parses the output of
> /proc/<pid>/smaps and saves the "nh" flag. When trying to restore the
> container, CRIU fails to restore the "nh" mappings, since madvise()
> MADV_NOHUGEPAGE always returns an error because
> CONFIG_TRANSPARENT_HUGETABLES is not defined.
>
> These patches:
> - Avoid mapping MAP_STACK to VM_NOHUGEPAGE if !THP
> - Avoid returning an error when calling madvise() with MADV_NOHUGEPAGE
>   if !THP
>
> Signed-off-by: Ignacio Moreno Gonzalez <Ignacio.MorenoGonzalez@kuka.com>

The series looks good to me, thanks!

Applies cleanly, builds fine, all selftests tests passing etc.

> ---
> Changes in v2:
> - [Patch 1/2] Use '#ifdef' instead of '#if defined(...)'
> - [Patch 1/2] Add 'Fixes: c4608d1bf7c6...'
> - Create [Patch 2/2]
>
> - Link to v1: https://lore.kernel.org/r/20250502-map-map_stack-to-vm_nohugepage-only-if-thp-is-enabled-v1-1-113cc634cd51@kuka.com

Thanks for the summary!

>
> ---
> Ignacio Moreno Gonzalez (2):
>       mm: mmap: map MAP_STACK to VM_NOHUGEPAGE only if THP is enabled
>       mm: madvise: no-op for MADV_NOHUGEPAGE if THP is disabled
>
>  include/linux/huge_mm.h | 6 ++++++
>  include/linux/mman.h    | 2 ++
>  2 files changed, 8 insertions(+)
> ---
> base-commit: fc96b232f8e7c0a6c282f47726b2ff6a5fb341d2
> change-id: 20250428-map-map_stack-to-vm_nohugepage-only-if-thp-is-enabled-ce40a1de095d
>
> Best regards,
> --
> Ignacio Moreno Gonzalez <Ignacio.MorenoGonzalez@kuka.com>
>
>

