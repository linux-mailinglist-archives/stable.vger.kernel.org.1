Return-Path: <stable+bounces-111758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AEAA23815
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 00:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BBF1165014
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 23:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873A41C1AD4;
	Thu, 30 Jan 2025 23:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BVFCgXcX";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="etyKUIIn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="N/Nbjmav"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9FC1BD9DF;
	Thu, 30 Jan 2025 23:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738280983; cv=fail; b=aP5kdonQzloALTWiDj52IfSpi5YwYFQkjXwdEWDjZaod8kgAzbISGMfwtEcvfms5mRV2JZiixSNSgO00ASANWvzguE/b4UE2Y1/xV66ofQGN/gSLHIlOQqmTr6VIU3504RHfQ5keRP3Fs/aHhvrSw5Ko4iz3hfWwDmvoKykIWZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738280983; c=relaxed/simple;
	bh=xiMawY3LHUoItCHmhb7QVjl8h/CUmZ3X388maut+SLg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Z5+8osl4x62+fqab4N8M6zVTngTA9kKjy+xrTgkNl/6Z5ET2M1n/gdBaOh2cHyviXMkekyYN88p0NyBqAF76as81YeBWwf4of8Yo+lGKO3CdtiPeOahzAG2IRMzoEmv9K0YWHmzwRYMREJku1gRtq/tRAcd93yVaQyAPuoCuLWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=BVFCgXcX; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=etyKUIIn; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=N/Nbjmav reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50ULpAfQ025788;
	Thu, 30 Jan 2025 15:49:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfptdkimsnps; bh=5mUBpIsKc0u1g/J2REt
	mt1LtLYW9v6MCf+zrvAYvhXE=; b=BVFCgXcXWC+/vgO1BaYvJhgFKsAK2PPv09E
	SUvP0P5+V5xE/TXFXeRKAhAy8rudBJ3Qu8FSdfdv0uNAPDvt0QnFFFVcGdusJgQ8
	CCCnBfxVKkj/xd0SD2T2n/kCh8LR2ksOhp3Wk57YSh6wzgZol1y1vNw3D9DA5qam
	jFNDNQ/jykDhZCVBQk++Dc088+zcPGb6u0KxQyRG9whQmjQavs2VVByArtuU/lN+
	EDKxZ79XQmp1E9DGQoHQOs/Zquf10NmOw1bDnWFX/bhTJBeOx1oB/tzxlsyKdu2l
	PmdGlSrqXgfIFM8QGTgzFQH4SOd0yS5o8/duOG4y9jGyEsNrS1g==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 44ghq1ghj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 15:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1738280977; bh=xiMawY3LHUoItCHmhb7QVjl8h/CUmZ3X388maut+SLg=;
	h=From:To:CC:Subject:Date:From;
	b=etyKUIInxLlw6C30mTLwVwjmUBep0arR1aUUcIrKA1FNaIpxNzjfaJ/kjiZX5+7lI
	 H3JbumvFfU/mrIuEiGDD0E3Ns+VIXNtAz5YALDcmePwX1W77NVVITo/qQ8OHe61r+l
	 Cwbz27pCO4RcBAGpQq9lF/uOL4omAHet8bfTyIMxAHnPBEqJ1WBeSaz+i5CYRDiAG4
	 ODNWHJehIaEfQnYivYIms2RF+iVJdBFSoLlcRkhe/0mzfU5pU1fqgfitA2XV4a5oUp
	 QGT6i3jplbMh0H3PBDQo+4ecNxEQSR8KvAeydJvT84TrqExf6eyDWlbXsAJDdWiB5c
	 qKACnvdCZhepw==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 717A940357;
	Thu, 30 Jan 2025 23:49:36 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id D9494A0073;
	Thu, 30 Jan 2025 23:49:35 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=N/Nbjmav;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id C5477405AD;
	Thu, 30 Jan 2025 23:49:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZ8Wa9Dh5KivqIrIE3x2NGUjIuFIIasxPaeSEqLiWHQAOs6JpQNpMiRVGN7MuQW3ypyzoUP73MWLz20HZADXnrD6WiN8bxZpPqWW+07lFrAnsoqdLZ+VMcQKAGGMwfUzqJ2+8paxYB21fhZTRg49sgYVjLHD/Bslo6SdFBVp9AokEBicscFcPYo62UTN6DQt47UW64iTO+c+xd4geNQDUYs1dXpWdzP/Yto7acpmN/ySuPAeMYVTZ7XVOQ0hat63ebDqlC3i4KM6OMI1cMPh4kqTs+3m8yrF1iuLhhwdSvAcKEfoEMIoo1A6Sk1SPiutOXfhkq9sIC/Xeq3/jHlGIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mUBpIsKc0u1g/J2REtmt1LtLYW9v6MCf+zrvAYvhXE=;
 b=dG38GYOQjck5V8Fqd0DbhBs0W2Dm0+YEzcqSEIVM8AYfQEGsFeoK8ynjEiWjMUumkO7Bh3ePPS24X24B3voxunSlFS3/p831FAukeTQg03QMoomGLxWBz+dHrXF5RafuDYeaUoOmEvl7v+q3iC07it3iWF2IRmGmEKyfavH5BAvT05yrdJ/JE0lHz2J208yP0lPnYAOo4x9w0MO412m5ZDNGAArN6uzPZxC/Yqd35cWVyBKWkiK26MyUjyCOKlXu7JIR4HRfKSMOoWPYs5s6HWNKsDXakHHz2Pa6rFgM+Oz4Rjd8DTJob3JkkBKCKRHThsVpmTb4JYz8OvCFiDIT1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mUBpIsKc0u1g/J2REtmt1LtLYW9v6MCf+zrvAYvhXE=;
 b=N/NbjmavVVHg30eJVr0eAscZSxcCZJUP+EHjKtnYU8VdIypsDYIple6oC99t/AIjPvbzqXrLYMjlkS7yyMgyBm/CzpnfNhTt7Bp7rdC1iv8ZHqXjnn87cnRti6vuLpDrjt3AqkNzg2SDPZoc8aOhwlrq+Zw3EpHmn9uGIY6rqGs=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH0PR12MB8776.namprd12.prod.outlook.com (2603:10b6:510:26f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Thu, 30 Jan
 2025 23:49:31 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%7]) with mapi id 15.20.8398.014; Thu, 30 Jan 2025
 23:49:31 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: John Youn <John.Youn@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] usb: dwc3: Set SUSPENDENABLE soon after phy init
Thread-Topic: [PATCH] usb: dwc3: Set SUSPENDENABLE soon after phy init
Thread-Index: AQHbc3Gb7tGfYjs2j0yp5RHjp5XhGA==
Date: Thu, 30 Jan 2025 23:49:31 +0000
Message-ID:
 <633aef0afee7d56d2316f7cc3e1b2a6d518a8cc9.1738280911.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH0PR12MB8776:EE_
x-ms-office365-filtering-correlation-id: 6e5196b4-4ed2-492e-fd82-08dd4188bdbf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?5E/9VZDtOGBEHIM4EirnJE2yeRdmOjjjSYXYlzfXHYVVzR6VAhmahg+e/M?=
 =?iso-8859-1?Q?ErbZnU29dSjD8aLyMjLAUU3Va+DKaLRaXVl3u8NU+5xmO8oEnzfDOht7pE?=
 =?iso-8859-1?Q?z/lzGsGTLZZiVHrg3293H4wEigXU6L5j5lHX5Oc10+fzOE496NwKAvqb8F?=
 =?iso-8859-1?Q?pE4epQNhU9sc9lw2FiTbQLLUjl4FQcDTO8Ubo6PQ6BImQx9ypmp+QjM57F?=
 =?iso-8859-1?Q?VPskI+9FSEWVWEz/rrgomGOuWNvdDZ8AruRmKYA0R19IrMrSGAew3oEqbI?=
 =?iso-8859-1?Q?1nSySepTOjfcnAMarhUOf2lyvmIeBtNrtSLmVxcKI25QqyxoIuZeB0ODQl?=
 =?iso-8859-1?Q?5qYMmgrZXrVmPyNNMfD9Dx4XBO+2frMlx27ET/SYYpSt8XeRR4lTeotxY1?=
 =?iso-8859-1?Q?5HYc21d/m4yd9+CQYD1YREG/6QDF7ltpxIzcJxnANm9Gan39Tf31Vu7MHi?=
 =?iso-8859-1?Q?O03817NIFpZBrtv5VfrRb0IzDZM8bwFV+5+wsVtitdw7syNTfUSxHDyyeR?=
 =?iso-8859-1?Q?lrMD06Eg4lzjKVupppvJo6qPQDB3mgmkPgAe5JJ6NfmxFhO/ScX/fJVwJ/?=
 =?iso-8859-1?Q?ml4JcUDDNWEXdwg60pSfSifoMsL0xtM5V1duZATU0DFnJ4MMyaB9TZW98c?=
 =?iso-8859-1?Q?DLmNC3v8h9q/qPiDYiErvxLTkqLz0SmL/vyudtN49RtNfiztSZz4hq8bjQ?=
 =?iso-8859-1?Q?Bfb+f7t29ouCS+1/HKUmZjMAv2q3yX74PhQFtZdmJVnhMbfdx+MTYE+3pC?=
 =?iso-8859-1?Q?h6Pr6zmGiKA2DKaitXwPv1dqnYfLwLyOM2eut45zp7C65i07T+QuRJl7KF?=
 =?iso-8859-1?Q?PLAqQ4bZ3v0RC3m1nen1qMsFOYu/4UX92nc6FttrW/+a+cKBqKgqhJ78d0?=
 =?iso-8859-1?Q?ViVD0HXYgUURQlg+TXhtHfeCcGv32m1UKeqEIh6sW5BWAyhZ2bn24lqHv+?=
 =?iso-8859-1?Q?VoBzyWkQmAcj1YkN0S/pK6v9WflPiPtloDqE3GRdTLiY1E93abIXv1mCGz?=
 =?iso-8859-1?Q?Y6BKfnfkes4WjJyP18Uz9txNKIG/NLCwc7WGNWHfrcAtuLhvyl0ErOd/+5?=
 =?iso-8859-1?Q?hvp51NnGe3kb/LO36d4j0sDYJZ81viXNUXGjIL6VZmahNWwr3R8c5YWJb6?=
 =?iso-8859-1?Q?Miu1elA5fbHFfovi7uf+ULFOL5hR6ad9c7A9HPT3TBGWZlF8GnPMntwHmN?=
 =?iso-8859-1?Q?+RoOlVoBWd12dvgpakDz3VMXF5hoyN14PGkHhuJYpX84GJoyDp3o8kICj7?=
 =?iso-8859-1?Q?S+lunvEYakup4HpRoT0Z6QB5Dont1EyQ5SwsrC+M+vsegtgU2LCZ+Xn+Ry?=
 =?iso-8859-1?Q?39EiJ6VHGaCsJbmglddUZ986dC1rvre0d2knyE9ZKuO4ulpSHBi69jhJFG?=
 =?iso-8859-1?Q?LQ8i66Vwyg39ljrN3mUAIDS3wO8PYuFBH+wlhyKwCKke59GBJK7qWafTHN?=
 =?iso-8859-1?Q?pcbd5suCFRwaUp/ohm6U29plFzXPomvqakN5ojeDGbSYSavvBu6Hatarj3?=
 =?iso-8859-1?Q?sfL+aXw4JNf1o2cctEryTH?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?1GR+T8bfExk66leRaeooI8fs9sErmtUDchqAfJX8WqUC8TldiD2NnUbWf1?=
 =?iso-8859-1?Q?AIPPeP2eXbUTFUeOevo13BPhqev8aI5YV0Oe6oyMfUUSCcyTJyxROuetfk?=
 =?iso-8859-1?Q?diQ55eT2CzO1evg2hF4COq1oadLsHJpa/U2cs4e08szAtRjJVIoWlAbB/o?=
 =?iso-8859-1?Q?CtHZXHLNGFtso/2owqRLh1zZnta1k6OiSnY4WP5zNZuHfGOngAxWNOPgYN?=
 =?iso-8859-1?Q?v95Di5IIzvwF+Pe8EJVi51Fj0JwqVfwi9QBeAwVEnPwybcGYPikNNkQ/rT?=
 =?iso-8859-1?Q?b35Ib/lrOGBrujww1Mn207y3/3mZHrKx/p95+Wxanqag3cYP27svIvxT1o?=
 =?iso-8859-1?Q?nwXyRECjkAzICDbmoaV6lktHHhOr5ChxKZWHh+8zjk2KM4J8VaHVxprkWw?=
 =?iso-8859-1?Q?nPdB+4YI0IBze4292JcfeLi+n4HhhBQEn8/j/DmSNpj7lr51/levUGDgj4?=
 =?iso-8859-1?Q?N53rBK4xBRREkaFuWPKJWJo2BWt+JYRg76+YjgPYNmcn9QncFRa86ii8r6?=
 =?iso-8859-1?Q?RA84XZZ8hrbYvHqGJKi9OpA7Dwc0V1EIso/3a+cFlgGGZVZhXaOmn7OKeA?=
 =?iso-8859-1?Q?4IRihbpmErg0jmSKxQKXpZg8wGHos+Mz0O7rfaSgzBGZtkh2viEkSdznFG?=
 =?iso-8859-1?Q?0o4CUoEL2LqLgsFG6mHEzl06TU3Qoe7oOOqEAHP3yGRk0MrNlQjjWHP2Qt?=
 =?iso-8859-1?Q?vAIiiuRkhML4ZHeJwBNbULa7nO3Jv0Yzm7hmNmipUm6ZYmizd5gipBT7fD?=
 =?iso-8859-1?Q?rkkWTVSG1fFKtlF8o+iItM2Ms3GR5Ds95V9+zUFyUIgq1BwzRLhHDesPxv?=
 =?iso-8859-1?Q?WwIYaPoYx/ZXzEHsX5XFqeOF5TqDnH/BV+uCKeuyZCgo/81We6u5t/MVmc?=
 =?iso-8859-1?Q?Efn+ybIl/2/YtKYhJ2ePxplSX5aqUOLZqXn21Rv18cHoHXIjHbYhb6WTPz?=
 =?iso-8859-1?Q?Kkzn/eaH3jeK9HXVgsab4adLuxsDl5ZUZ3WiqUrIw5fIdzMuZezAaC2oCF?=
 =?iso-8859-1?Q?wPGZ8xZlE0MLrJo5RGghfuGrIhk+soWA2KU49tO/s9nzpwlzZodTvUz5x8?=
 =?iso-8859-1?Q?bSxQxmpC4NFch83DQnALiNVywffgp9DqmNEER3LZCLR1njHySHmZzpLZH8?=
 =?iso-8859-1?Q?jlWcUMzQjww110Nl9m8gz4oMMHnShxkTPih82If1pg7gGry0JzOYC85DJB?=
 =?iso-8859-1?Q?1BPU5CkA871LUIsuj5NS3412AI4I1MbL9HfW7KHGcaP4YziSRfmSctrr7W?=
 =?iso-8859-1?Q?ZzAAanwxk8B+t+mtz30/+f8whLkqiYYUIZcAveYXuOUpx1CqFjsOOZIzVE?=
 =?iso-8859-1?Q?DIhRJwK8nCJ+VgA828YUHyt+VOwSaDTUCBXWM91Bh2RqR1xUalL1wpV7zT?=
 =?iso-8859-1?Q?q7WnjtFetu7dJNKxeGyc//LMzlGhW7H/0GyOXTUJAYvvX8LWDP7OqQuwKt?=
 =?iso-8859-1?Q?NoteT+BAEaX5EwYTA61NeMlS2e136fzxvBCqH+jnhjLOMp7n0EVKU/RWuF?=
 =?iso-8859-1?Q?KJ95tlbRHnu8gSjwX4Yq9Nusqcrr0khaL2mlNqBh277FEzrBz8O6fslahR?=
 =?iso-8859-1?Q?jwxyWwawl738fFk8yZPZfj+Cr/zcU6IG6qxXJbh/vi0pefsziZgjEzF6iO?=
 =?iso-8859-1?Q?Zt0+gWYt3vT+tLvhxa2q3FU6Uaqu/BtoOq?=
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
	ayWnnamgnrJYG1i1zGi384sOnRg0y0mNBX5BF8XkwrnXwVeAXde57bZ6lF+5qKUbqC5nm+8APmFswtfJZYQjjM3MS3bNLpkIHsL5uIAnB7A9t/U/11+Qn367U0ds+x4Vj7POlx+WDfDHvSCrfIPnoA3mb99m8GXJD+MqATAkmO5tHdMYcgtprCnoe0IQ3Mabtgyo5pwm6gmoAvbcsw+4bQPuv2p7rzJnn/GSJTT8oC/9lKvPlX245hrusmgCK00/ogUk4IsW81YtMxh86dzw/x62b97iwVhnViBO4ine1gQe5QhqgGG967tyWRCj59l86Q4PL3cCUlzy3RrZ9fqcXHzJlVo2jLVWRLhH22xw3mikMo265DbocFXjJK3BjJzMOStyU3e/hx9ArdcR2BBhOS/kJxP3DKGDZVSFPuCtAuZAGWRM7YKYX6em/F7xgiz+rdRA58KsDluZEEHHLfSIH/5QTafK2iP++eY6ea81gTglrqMXVM7NCsPM2bA8SnNgHliBAnU07qac3D3m6yBu1P7cj0nsWH4joLzsZZ02P+xwj+ykcQweUzAdhenVQ/rTwkOFpilI8N6z6WpwOlKjEDwBapzJ3GwkJQ0KVJVEPflaNJKdx7gpAaUtr4RQ3cE0FlbkNmo24K6jT4XVURBLzg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5196b4-4ed2-492e-fd82-08dd4188bdbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2025 23:49:31.1090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MRU4hRCqeZzD4/vuoJTZnMUEyAjlIOv+cKvhy6hrcZCi2Ch+aMq6836nqwQGI+ULQyy6C9bGXHwD4RWya9Lhjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8776
X-Authority-Analysis: v=2.4 cv=Hq6MG1TS c=1 sm=1 tr=0 ts=679c1012 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=VdSt8ZQiCzkA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=SVxY-zLO_loFqH_OTfIA:9 a=wPNLvfGTeEIA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-GUID: uphag2B18sfw3gRgJ_Mzp8KAYQHKCzRp
X-Proofpoint-ORIG-GUID: uphag2B18sfw3gRgJ_Mzp8KAYQHKCzRp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_10,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2501300184

After phy initialization, some phy operations can only be executed while
in lower P states. Ensure GUSB3PIPECTL.SUSPENDENABLE and
GUSB2PHYCFG.SUSPHY are set soon after initialization to avoid blocking
phy ops.

Previously the SUSPENDENABLE bits are only set after the controller
initialization, which may not happen right away if there's no gadget
driver or xhci driver bound. Revise this to clear SUSPENDENABLE bits
only when there's mode switching (change in GCTL.PRTCAPDIR).

Fixes: 6d735722063a ("usb: dwc3: core: Prevent phy suspend during init")
Cc: stable@vger.kernel.org
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 drivers/usb/dwc3/core.c | 69 +++++++++++++++++++++++++----------------
 drivers/usb/dwc3/core.h |  2 +-
 drivers/usb/dwc3/drd.c  |  4 +--
 3 files changed, 45 insertions(+), 30 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index dfa1b5fe48dc..87b4c04a868c 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -131,11 +131,24 @@ void dwc3_enable_susphy(struct dwc3 *dwc, bool enable=
)
 	}
 }
=20
-void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
+void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode, bool ignore_susphy)
 {
+	unsigned int hw_mode;
 	u32 reg;
=20
 	reg =3D dwc3_readl(dwc->regs, DWC3_GCTL);
+
+	 /*
+	  * For DRD controllers, GUSB3PIPECTL.SUSPENDENABLE and
+	  * GUSB2PHYCFG.SUSPHY should be cleared during mode switching,
+	  * and they can be set after core initialization.
+	  */
+	hw_mode =3D DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+	if (hw_mode =3D=3D DWC3_GHWPARAMS0_MODE_DRD && !ignore_susphy) {
+		if (DWC3_GCTL_PRTCAP(reg) !=3D mode)
+			dwc3_enable_susphy(dwc, false);
+	}
+
 	reg &=3D ~(DWC3_GCTL_PRTCAPDIR(DWC3_GCTL_PRTCAP_OTG));
 	reg |=3D DWC3_GCTL_PRTCAPDIR(mode);
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
@@ -216,7 +229,7 @@ static void __dwc3_set_mode(struct work_struct *work)
=20
 	spin_lock_irqsave(&dwc->lock, flags);
=20
-	dwc3_set_prtcap(dwc, desired_dr_role);
+	dwc3_set_prtcap(dwc, desired_dr_role, false);
=20
 	spin_unlock_irqrestore(&dwc->lock, flags);
=20
@@ -658,16 +671,7 @@ static int dwc3_ss_phy_setup(struct dwc3 *dwc, int ind=
ex)
 	 */
 	reg &=3D ~DWC3_GUSB3PIPECTL_UX_EXIT_PX;
=20
-	/*
-	 * Above DWC_usb3.0 1.94a, it is recommended to set
-	 * DWC3_GUSB3PIPECTL_SUSPHY to '0' during coreConsultant configuration.
-	 * So default value will be '0' when the core is reset. Application
-	 * needs to set it to '1' after the core initialization is completed.
-	 *
-	 * Similarly for DRD controllers, GUSB3PIPECTL.SUSPENDENABLE must be
-	 * cleared after power-on reset, and it can be set after core
-	 * initialization.
-	 */
+	/* Ensure the GUSB3PIPECTL.SUSPENDENABLE is cleared prior to phy init. */
 	reg &=3D ~DWC3_GUSB3PIPECTL_SUSPHY;
=20
 	if (dwc->u2ss_inp3_quirk)
@@ -747,15 +751,7 @@ static int dwc3_hs_phy_setup(struct dwc3 *dwc, int ind=
ex)
 		break;
 	}
=20
-	/*
-	 * Above DWC_usb3.0 1.94a, it is recommended to set
-	 * DWC3_GUSB2PHYCFG_SUSPHY to '0' during coreConsultant configuration.
-	 * So default value will be '0' when the core is reset. Application
-	 * needs to set it to '1' after the core initialization is completed.
-	 *
-	 * Similarly for DRD controllers, GUSB2PHYCFG.SUSPHY must be cleared
-	 * after power-on reset, and it can be set after core initialization.
-	 */
+	/* Ensure the GUSB2PHYCFG.SUSPHY is cleared prior to phy init. */
 	reg &=3D ~DWC3_GUSB2PHYCFG_SUSPHY;
=20
 	if (dwc->dis_enblslpm_quirk)
@@ -830,6 +826,25 @@ static int dwc3_phy_init(struct dwc3 *dwc)
 			goto err_exit_usb3_phy;
 	}
=20
+	/*
+	 * Above DWC_usb3.0 1.94a, it is recommended to set
+	 * DWC3_GUSB3PIPECTL_SUSPHY and DWC3_GUSB2PHYCFG_SUSPHY to '0' during
+	 * coreConsultant configuration. So default value will be '0' when the
+	 * core is reset. Application needs to set it to '1' after the core
+	 * initialization is completed.
+	 *
+	 * Certain phy requires to be in P0 power state during initialization.
+	 * Make sure GUSB3PIPECTL.SUSPENDENABLE and GUSB2PHYCFG.SUSPHY are clear
+	 * prior to phy init to maintain in the P0 state.
+	 *
+	 * After phy initialization, some phy operations can only be executed
+	 * while in lower P states. Ensure GUSB3PIPECTL.SUSPENDENABLE and
+	 * GUSB2PHYCFG.SUSPHY are set soon after initialization to avoid
+	 * blocking phy ops.
+	 */
+	if (!DWC3_VER_IS_WITHIN(DWC3, ANY, 194A))
+		dwc3_enable_susphy(dwc, true);
+
 	return 0;
=20
 err_exit_usb3_phy:
@@ -1588,7 +1603,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
=20
 	switch (dwc->dr_mode) {
 	case USB_DR_MODE_PERIPHERAL:
-		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, false);
=20
 		if (dwc->usb2_phy)
 			otg_set_vbus(dwc->usb2_phy->otg, false);
@@ -1600,7 +1615,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 			return dev_err_probe(dev, ret, "failed to initialize gadget\n");
 		break;
 	case USB_DR_MODE_HOST:
-		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
+		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST, false);
=20
 		if (dwc->usb2_phy)
 			otg_set_vbus(dwc->usb2_phy->otg, true);
@@ -1645,7 +1660,7 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
 	}
=20
 	/* de-assert DRVVBUS for HOST and OTG mode */
-	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, true);
 }
=20
 static void dwc3_get_software_properties(struct dwc3 *dwc)
@@ -2457,7 +2472,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_me=
ssage_t msg)
 		if (ret)
 			return ret;
=20
-		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, true);
 		dwc3_gadget_resume(dwc);
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
@@ -2465,7 +2480,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_me=
ssage_t msg)
 			ret =3D dwc3_core_init_for_resume(dwc);
 			if (ret)
 				return ret;
-			dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
+			dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST, true);
 			break;
 		}
 		/* Restore GUSB2PHYCFG bits that were modified in suspend */
@@ -2494,7 +2509,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_me=
ssage_t msg)
 		if (ret)
 			return ret;
=20
-		dwc3_set_prtcap(dwc, dwc->current_dr_role);
+		dwc3_set_prtcap(dwc, dwc->current_dr_role, true);
=20
 		dwc3_otg_init(dwc);
 		if (dwc->current_otg_role =3D=3D DWC3_OTG_ROLE_HOST) {
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index ac7c730f81ac..19ad5b6e1ede 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1557,7 +1557,7 @@ struct dwc3_gadget_ep_cmd_params {
 #define DWC3_HAS_OTG			BIT(3)
=20
 /* prototypes */
-void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode);
+void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode, bool ignore_susphy);
 void dwc3_set_mode(struct dwc3 *dwc, u32 mode);
 u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type);
=20
diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index d76ae676783c..7977860932b1 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -173,7 +173,7 @@ void dwc3_otg_init(struct dwc3 *dwc)
 	 * block "Initialize GCTL for OTG operation".
 	 */
 	/* GCTL.PrtCapDir=3D2'b11 */
-	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_OTG);
+	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_OTG, true);
 	/* GUSB2PHYCFG0.SusPHY=3D0 */
 	reg =3D dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
 	reg &=3D ~DWC3_GUSB2PHYCFG_SUSPHY;
@@ -556,7 +556,7 @@ int dwc3_drd_init(struct dwc3 *dwc)
=20
 		dwc3_drd_update(dwc);
 	} else {
-		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_OTG);
+		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_OTG, true);
=20
 		/* use OTG block to get ID event */
 		irq =3D dwc3_otg_get_irq(dwc);

base-commit: 72deda0abee6e705ae71a93f69f55e33be5bca5c
--=20
2.28.0

