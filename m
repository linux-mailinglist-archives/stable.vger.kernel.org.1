Return-Path: <stable+bounces-100503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A8D9EC0E0
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 01:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29F14283173
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 00:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915982C182;
	Wed, 11 Dec 2024 00:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="j0rax64f";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="hg2/tpOr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="L3hsCgck"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955FB175A5;
	Wed, 11 Dec 2024 00:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733877240; cv=fail; b=qE/hx5S07MlooYHbjvBF+mB5AGaGMyrKU0vZRjCaxQdwF5FH90toipf0zibWrUvYR4KPokXTQ+JGagxl2U/q83seaZfizjfpZn2V2pRqEnl0/vAAx2As9HY1D3DM9H6YBMjpPKY9dUuOdr4fs3VsDdaQZCPLaH9tu30rxqbH8oI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733877240; c=relaxed/simple;
	bh=zylX45SclTToMx0DKHZf6XKtosEehJttd1LWg5QBgsA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iUTN9BM5AnFx538UoP0RqqzplkOMFiePElpXZ/cPuhUOrlxanan6GGsvQgD7et00utYUI2zCZMgtz86Sqc+HyIlDu5/2w1c4wNm6jHonYX5sAGOC0X/LRrZ9e2O2ZfgFmIfbcfuK+zuRka92bi3INVnULRX1obsa1dmBtTMfyBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=j0rax64f; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=hg2/tpOr; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=L3hsCgck reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAM1Z1I017223;
	Tue, 10 Dec 2024 16:31:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfptdkimsnps;
	 bh=nQ3ToMYy/+k055h48KltP9+nYtIVZ5K25YxXgWLUcp0=; b=j0rax64fcu0t
	4haZk7OhWHMrW59jWrc8f3jNPA+fkY1NpSdipM35me5xUwlWMPNaljJ9GpgXy2kE
	J+2FGsizwCbtlyqB8J4PR9vTqW41Ey+D8ri1/T8Otpu/Ke1Z/Z6moMvEr995Rm89
	xNRbacWB8o9RxJdFqfmKDGWIk69b5e2RBb19eK3v/IhVfMumBFNUcNkLKgs1J2ya
	raS8SbNKOpctSZrQ+p0n25O7R74Vo3iUinsCfHlWJVz9EdZUxEZVmxkYuGR8Pm39
	w21Izyujxfc2GrX1jq95AZdqZjBaMf8E42IWwlFuqkZgU4lMHFCqw5vrDG8OfD3Q
	XpC2RW65Aw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 43cp60t0vf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 16:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1733877110; bh=zylX45SclTToMx0DKHZf6XKtosEehJttd1LWg5QBgsA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=hg2/tpOrRbya1z1L2dsunFsSejHoONESjYFkscluSk9uzZLCzoFElcjrH+hhINvxR
	 N/6GN9qpBnk3jiJkdfIBFn2K63ZhNAwCGuVk5UpM/DbSxuZfE0dARQy5zZg38Ms5Jo
	 Z0+AV+yisaRf4eugn3cVK/3hJkZHvZ6BzO4Ka0WUpYsRz6fSkg55j8hnUAnWbscIli
	 DZ8PDS4sGRbzJ7CmDZ5MbsM44/me/CFapH3BwXbnYt9IYZ4C4juBsAgJ6RB7Tw7uMW
	 W5zU2mGxADo5LGvKeyYA1c05D7eMa7EQ9AeJqPaV8GQlb+jN6kAOg0pTff4Pc0mZys
	 Co1haxYGJ0dCA==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 951074012B;
	Wed, 11 Dec 2024 00:31:50 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id CF594A0068;
	Wed, 11 Dec 2024 00:31:49 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=L3hsCgck;
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id E14A8405DB;
	Wed, 11 Dec 2024 00:31:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cD4QgMLikQJpITq3AQ/SZW6BwBrLv0Zk4IxPI+w8aAmc3YfxGkk0vzX4nlFb9kayQwIo/CeENAFkoEciMBrQCeHovnjCk5qLf/0meyYhLHhIGtrgcXBLUjwLSh6oHQsBjV/olW1O4JseOPELaD5z8w97sfBU7fGKAZvqfsJj37h/8J/xteazSObcQyyMUs9YFqTbZJmXuDwbC/XaW4lLO0AAqtVcgtBebJFOmL1a0oX8bmtVJTq3j22hI6GRl7arAiKC5nmV4t0pKOyW3a9kcvhe6NlmKJvis0q++yvCtrBahPxk49HZnE8+nVsN5L87fomerYqXdd/gGgwhQSIuTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQ3ToMYy/+k055h48KltP9+nYtIVZ5K25YxXgWLUcp0=;
 b=bwL0+Tv04ADsdKtiq+ODInUHM04553WCShTcCLBYZV3C8oE+PL73DWw2RU+GjWBfhqS9U4VYaENVddhgYuFX1wiLDKTGa5/r3pb6HtFIeNDr49F2xSfixouwzAuzinBu5qpZgcu6LYruB0Qp13uZb2X5q86JV76T8F2gpDOKOlCtOimU6+0e90vS9c3+TBMlscwckcWzteNimeoM/EsbPZlNEuYyXGdFvu0bZxuIxErb/ZevVv08Hy9CvCCD0dXe/9tDUaovt+zSL6K9Vk39f51hMnFpnb7KASp1MAFmEBcclPf8Pdk/dvpd5JjzwybccqTjbDSTNhlHBZOyO+6vQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQ3ToMYy/+k055h48KltP9+nYtIVZ5K25YxXgWLUcp0=;
 b=L3hsCgckqqQcxj0c1KlboJCM8g38EJhWOLcrZaCLWnwNeuz4R6Dy0YILd/ZJHHhMBELPShRBDIixNd3443a0Q+svRjIayLYbOuAGR8os2W1xUCutNe+CrYWdIHla346Ekc+R7dtosD1DWPO/qpDMQ1J02q6G18sPLaHiRoSR+VA=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH3PR12MB7691.namprd12.prod.outlook.com (2603:10b6:610:151::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 00:31:44 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%7]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 00:31:43 +0000
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
Subject: [PATCH v3 02/28] usb: gadget: f_tcm: Translate error to sense
Thread-Topic: [PATCH v3 02/28] usb: gadget: f_tcm: Translate error to sense
Thread-Index: AQHbS2QNKrRIrx5sSEKLaYoqRp+CIQ==
Date: Wed, 11 Dec 2024 00:31:43 +0000
Message-ID:
 <b2a5577efe7abd0af0051229622cf7d3be5cdcd0.1733876548.git.Thinh.Nguyen@synopsys.com>
References: <cover.1733876548.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1733876548.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH3PR12MB7691:EE_
x-ms-office365-filtering-correlation-id: 87027d97-6e6d-45c7-b693-08dd197b2fdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?fgb3nPWmQGiHU8gJWnPIc3EIlZZ+i1VsjewknaHqiEOfYIBI/02ATde6II?=
 =?iso-8859-1?Q?O2KXwalWWx5712D0/5qmJ5TLvF2Y/SIFUDHvB8yDrNsRnfTnw3/FRe9S9z?=
 =?iso-8859-1?Q?NKZ/QN1OHIqkszbEMzTOtXlx8M2hPahplZWiaU6OhjdJ12IYGieeyJ2Jeg?=
 =?iso-8859-1?Q?TASrmxG9CRu8R14QutQn2IJmfHPsCh8Ri8Clb9PGTNh2gYeArL0I2ZSOyw?=
 =?iso-8859-1?Q?y33T7avl+nA3o3aQT5uD6zztTJh7WLciVnZRQkhqoeVRQCEBfQ5VZ7v0gn?=
 =?iso-8859-1?Q?/3RRDobG5F9bNDBxPiWsUSFQ/tYR6r8qFHOr/7+65iPeTLzV/GaQWTqflm?=
 =?iso-8859-1?Q?gJOvGKNcPM7fJAztDqoIPvImHrhuhpQVdukid/LcAglctlfH1nI8V+JRtB?=
 =?iso-8859-1?Q?3kNPWr0txIe7FB6P3be/AiKKO06l3TNadVsVximzrayHLy+DmQlT+cjT8X?=
 =?iso-8859-1?Q?gURZTVN6bgfAjQHToxVLi+xao3RJKRqQm9yXqeVQoNpXqyscbGdue59z+A?=
 =?iso-8859-1?Q?HSC7AWKUwfHGESCCzl5LLhIPuNQ5IspnlI1s/aR3JY70PLAz8Y8FihRycN?=
 =?iso-8859-1?Q?g8D1ryscdeEsHNELILRBxsMRliMbEKy7KLLE3roPv3bmhvlhST5R3CjWJT?=
 =?iso-8859-1?Q?FuuB7kk20d3qaBaS1U3jLQh+4Tr07LRaEAlD3T8laKmvNxE7XhiL5HEwFJ?=
 =?iso-8859-1?Q?9ycMIUGQZZjUQOdPpASCBXAK1koJbRZbrZJvHQilz8FLcNxR3AIrSf6pvF?=
 =?iso-8859-1?Q?CXPpvVQuGhaGSdEUQKMBUIiABuzZlsll5G41/JFrBEaVQPCk+ZWbp/9JUw?=
 =?iso-8859-1?Q?9Cw61pFPqLD4P44igmWgBd4EA7LrmfeA0f8ITQuhaTonJ6KAL18TD70yzK?=
 =?iso-8859-1?Q?XqMxl85tiujH2Sj3kcXJmWshEuTkiuIbmHJ5JU1/oqycUwmCcbVsU1KBLd?=
 =?iso-8859-1?Q?j6tR5nik+skrhNDCpobIuT7ihfmbvCrmh8Cv45VfHDb17KY5/t4xYKxWyl?=
 =?iso-8859-1?Q?rjlGD+G/CJLjFIB7DNXegkypzwLNmmV7zhM7ASYsDYcg7Am7VETZs8GqLf?=
 =?iso-8859-1?Q?udrkOqDVVW27ejHmnsZ5NMIjSk4iOVe74KMUaR4EJhi4DIxwiQ+pvstZKj?=
 =?iso-8859-1?Q?9TQ//NKBcdc41AWrdmPg2aFkNtNzh7mXEWgrjGXGAenSrQx+XX7FojbWV5?=
 =?iso-8859-1?Q?3hmIlise6V3BsEFiaJ0J2qt0iXvbXs2md3zg80mfflXMHBAbhsVQqMIAbx?=
 =?iso-8859-1?Q?Xfu6z8KBApIdZEK3zAl+e63xt/I8thsrn1iDOEiDf8WBNofr6PtN3VkMVI?=
 =?iso-8859-1?Q?OdgpNm0wmXQwQjqp72J1pfGtsemJax3lfe6arNIX0F5vcfIqa/qmsvDO7w?=
 =?iso-8859-1?Q?RZMrJOa60GWzevyg6IqOlj0lFoAlc5PjVsv7XNviY4AqczNgdfFs8vFMsC?=
 =?iso-8859-1?Q?GOFUojtPdH5XOYXtXX/P4PD3KmMrFVMU4O9b2g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?JqidUwfpqH+WhLa0qf6UPQuOYGkJuwKGFMS0CDrn6Xj73pBcyGOmhzrqxQ?=
 =?iso-8859-1?Q?aGg6MgaBswNN9FL4rKso+PtnhJZuRICiFVFESTHS4xKszMjIBL7egx2WDv?=
 =?iso-8859-1?Q?I4qI1nEx6cnxjS3yZF7BMeIlIKVc6jwN19s+qBcNn0jyAXdP6OqnKIhl6D?=
 =?iso-8859-1?Q?oSIxot4F7e9bdBQ1OQPO02Ra6N41QY5ySr2M/GfOR0moMpJ83SvGCNYN90?=
 =?iso-8859-1?Q?J7hixegxFLVK+WidTqUOqDNE/ymr9Dr/lX3PIPQAninBgzlGiVNwIJ3FjQ?=
 =?iso-8859-1?Q?j9oiFd5KOvEzmcFGYLicNkwAyRoEs6NLfaoaMj0KZ/CNVovSzroD30lmVv?=
 =?iso-8859-1?Q?q1Stdkoyrf4PuFwdl5ofU2QN0vvhRlTCqi+Qln2SbSm++QJGQutFsit/Il?=
 =?iso-8859-1?Q?gaSyxlhzh45ymlspcgyFiKECNpQEMT4obT+DXQKu6PWRpZe9fltBXY4+5g?=
 =?iso-8859-1?Q?yMHor71xcMQdZ13yID4Ic1bM0GaJS12Y+M6RjLcDJxz6TUe90T+MaL2Qly?=
 =?iso-8859-1?Q?ivxbLfUsZ/qqmQsrOkanMDGLR+FaCWWnPhF/rSP5kPvLJJ4bn6LS1J7Lho?=
 =?iso-8859-1?Q?2nCRkxGAclJ1ZYnacXbB9Jiiwd5lpGFxh/z60lBmtDszOYOkfx5Ju5XCm3?=
 =?iso-8859-1?Q?Ep3TAgvvr9BEZRPWtNta4X+RtJMEekbDyhOyqX3m6ndq4ntiFX82QnWW03?=
 =?iso-8859-1?Q?/R8TUvLVgpatjRjvDvee7IULaC+40bJl/ib4RRdMrd1yH71xSB7vvCOUlK?=
 =?iso-8859-1?Q?GVtvnAZMG2m4GwBZuJuGfzvkp4y1/KrB4FIVZcEg8ltpUmskuYexkngvdR?=
 =?iso-8859-1?Q?cbyBfMC+voSUNDT7wJCDqugq47V7ZzubRMUrqdxNxlNgpUAQ4VVtUHlIeg?=
 =?iso-8859-1?Q?rx431A3xFShim4OFrgAkDWnVxsSIvgFaNo3BmKLmB1+yAXrrwfM9Rd/j+H?=
 =?iso-8859-1?Q?EV9IpnM1mDXJ3gasifHZVhXQBpTGLiCZFxYBPdavgRmk/8RqOIfTzI8E8B?=
 =?iso-8859-1?Q?RYVEqnd7toVjXfptT9iONywvkjlib8VZ8pzpZeW5MFSUrMos4B6GK7YNHH?=
 =?iso-8859-1?Q?dy0h3kqZj6DmXIaNKG8dUN0rU6nREvYECtALnKoFuBfVhFrgP6E8vmaozL?=
 =?iso-8859-1?Q?2OFecU8t6pt9/nAdvz4PLLb6Mwkb23i4/6G3H0FVETXRWNTgErJMtxx/Vi?=
 =?iso-8859-1?Q?NXNXVFGryU3Xz3EFgtNnMR9Zn/A8229CrnoqVuHsVNueSvWXu+K74bpaUw?=
 =?iso-8859-1?Q?gGxvqQhb4yQAd4uI1IoYGxf6CbgaxnkoYJeaVehjh5xHNbJMASQRFlo8UR?=
 =?iso-8859-1?Q?9xUOcksNNhHIEfwMDcj2y3nssCggt05L58ddczAw2dTsXc6xip/9bybZYO?=
 =?iso-8859-1?Q?u13FqCyzLLDBhqxyDOkZdLCwG9Q/wD1roHzWo+wkFYSooPP96ef0y1wSc3?=
 =?iso-8859-1?Q?c4tsp43OxNeykT8E678fBqCiznzJqitHr+OeCMvh3sMZRMLupafYNIonhn?=
 =?iso-8859-1?Q?JK+MSzXs3MWfNgnMs4NrPBGpmy3+4uli7Gx6ft08hdMhBN8ahdEe8Xhmxv?=
 =?iso-8859-1?Q?GZHs/8ivCXZeLHHrf48TWkxtnf5Lw0JpEgAnUWg92CliLo3bQpY3MO5SPS?=
 =?iso-8859-1?Q?vO4vdqfOzVtRFVz7UqFyTIOtQl6qCkCeFg?=
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
	HJK/Xvsz5fCilRU2aO9yjnainJnEv9sgg3Ty8PzCFy3Ur4pXd0VWBnO0eJGxDjVM56ypb8gJZblb2OvW7BdziXLlb3XPTRuqUfMVNddHxrj53eox+5nAf4ZBpFGdU4UYNj/PM00a8aXiwSaz5gfHstDHCiZUDVE13jjKjRhCWa6qjjdIIfdaFP/Hz8V8jLdIUbFTN8+CGItRyUo2PcZrS5tYootRt+OhN+XQR69krb/mCVJbQzL7RKZjqnuKK5P3o+UU6ad8+rOtpGzxJRY2P+tq4Fa0y3jfxyMV+dNxRoUz6sMPnriwHq4/tZ0CE4BohOq6p2092ym+Qyf0xg7IBKJ33wsAecKx0CT29tXyH6xHgBYwhZqSJH5bN9v9gqI7VNgPSgpmol5xpLM9dHuTDHVtJEwKWwnYZY5Nuw8sPaycdmBzCy1zUQONSlGQgroVSuh9X1AVJz9Efk2eI3W7l+nYUwDO8mn8QC5iGJQhRJ+d+bEaRCsk+HyomjKvgc2H89vXlgTDYez0wZ1TR5VXhV2L6z2df3R2t2Bslr7/h8qZwWv/WOGplJNBFSLQqIrX/NoiAeexXmVpdztfRl4ad0+/NKoXN0VNlcmFMeQjUU5qHfhMGSPVBDAx7Nb35Xxcke7XGsbzzZNPXbeDWM/ZrQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87027d97-6e6d-45c7-b693-08dd197b2fdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 00:31:43.0638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mhYBx5k9OKpWS2Y4LzkIPff3wTi3H8RaGootRGjA8WbDBP938aR1BH1uDcHCbpv6uwzQob2aSSfyiCJQQE8YpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7691
X-Authority-Analysis: v=2.4 cv=Z9YWHGRA c=1 sm=1 tr=0 ts=6758dd77 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RZcAm9yDv7YA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=uci9V5TbMvxmTE9LAKsA:9 a=wPNLvfGTeEIA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-ORIG-GUID: gkAtT4gl-tddLJSRWpsfLZxazeWaU_nr
X-Proofpoint-GUID: gkAtT4gl-tddLJSRWpsfLZxazeWaU_nr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0 adultscore=0
 mlxlogscore=883 spamscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412110002

When respond with check_condition error status, clear from_transport
input so the target layer can translate the sense reason reported by
f_tcm.

Fixes: c52661d60f63 ("usb-gadget: Initial merge of target module for UASP +=
 BOT")
Cc: stable@vger.kernel.org
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 drivers/usb/gadget/function/f_tcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/funct=
ion/f_tcm.c
index 6313302a5b96..88b8b94fdb1e 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -1061,7 +1061,7 @@ static void usbg_cmd_work(struct work_struct *work)
=20
 out:
 	transport_send_check_condition_and_sense(se_cmd,
-			TCM_UNSUPPORTED_SCSI_OPCODE, 1);
+			TCM_UNSUPPORTED_SCSI_OPCODE, 0);
 }
=20
 static struct usbg_cmd *usbg_get_cmd(struct f_uas *fu,
@@ -1189,7 +1189,7 @@ static void bot_cmd_work(struct work_struct *work)
=20
 out:
 	transport_send_check_condition_and_sense(se_cmd,
-				TCM_UNSUPPORTED_SCSI_OPCODE, 1);
+				TCM_UNSUPPORTED_SCSI_OPCODE, 0);
 }
=20
 static int bot_submit_command(struct f_uas *fu,
--=20
2.28.0

