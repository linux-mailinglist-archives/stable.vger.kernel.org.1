Return-Path: <stable+bounces-100507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5092A9EC0EC
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 01:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 309EC188998C
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 00:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715CA3BBF0;
	Wed, 11 Dec 2024 00:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WUIr2/00";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="PbCwJjjd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fuSO0iIq"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7E4CA4E;
	Wed, 11 Dec 2024 00:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733877264; cv=fail; b=DQVGdNi2ebtY23WTiuMJzM9SisxVP9aLQZ0I0RM8hSSnapQ4Hv+Q9Ulpz1WAuZNZa8hrLyBI1utCgmw+S4qcBWMRJxU8dozYL1/qtBZrBUv503aAEoMJxJsHgL0IDcFvJIXwqfVeBUovkvy/4KRqZPx7a+wury9T6BQGeZrPEVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733877264; c=relaxed/simple;
	bh=LYI3x5/5UgqsBpZUS+S/i0iKZBhuzGAbzpWdDq7ULYs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uUxgCM5uC/CQocduqNcxU0vhuViWqRBylAgI72Rpvp/g+Mcj/aMtMhl2Ahg+Vmp7Hvyj7k9WXSzgMq/FIhaaFA2sREsXdUOHIrbicLlrLeYe+CqiGE9cBMKfFREdqirPcOnjwv9NyFD7Uq11VMWuZhJj8nM/ceuEObQ6oL1BVDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=WUIr2/00; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=PbCwJjjd; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=fuSO0iIq reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BANjYjd019385;
	Tue, 10 Dec 2024 16:32:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfptdkimsnps;
	 bh=lGdUHFaxgK2sH2aCiw4tL86EZHe4lYLV3BiPV0osGAE=; b=WUIr2/0047hP
	PyRtOtw+tb0HsbTj4mDjuqSFgHobHHu9u+FX+3ZpIefDNv7ZeO1NdUpgVwjmZX8T
	/Hsv4ESjCCTvUP9EyJZy56y8raYTm92pye/30VMYRSMnhI2kGlo+dptcuG9phvBU
	Ylv2Wc4xiwYx3eeQGiLyBR9mGRGr9vk60ht4wllLPWl8kTSda27yAVx5E0B7qunC
	dSagP1wuZrGQOCfu5Kmd6Z+A4mzGyq4WdFuxjaT79xhONNdqRWkR2rhDxVkaRW9b
	mnvpvGhfLYe7NQoPIt0xaO1thsdwQQ3A9YEUpDitmVNl42xiqb+cSQkbbiwbCIKA
	JnjvSOcDfg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 43cp8t9vh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 16:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1733877132; bh=LYI3x5/5UgqsBpZUS+S/i0iKZBhuzGAbzpWdDq7ULYs=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=PbCwJjjdcvnT+X6gBSw2OJyvyhdrZp7TQOFNZyyptpdc+N2Z/57KrTzmtB9sz8Ear
	 nqzVXbt9sNNAGgV1MxCKriOyh+uc0cTyUAG0Lm1KzYWj+EYCybXCZFXDk+LzxITnBx
	 ySFwtMEdGTVJsUoA3813IThTCzMGtrNeEm+vd7e5V+UBw8Xwe68/t5XAONnt63UASt
	 C4MXhEuSMo7+iA4iOeP+d9kXcBzZHdcBNJjgqjatcRICC2VD2FgMBzswvGdIMMxv+1
	 VcWgN/i2pcD3YpCE7Oc51v5wo0jkde/W51Aoeor4nO+u4llIichMxAOcLGPE1O6n8R
	 our0xntVIgDTg==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1376B40126;
	Wed, 11 Dec 2024 00:32:12 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id E8088A005E;
	Wed, 11 Dec 2024 00:32:11 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=fuSO0iIq;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 535DB40148;
	Wed, 11 Dec 2024 00:32:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RaeVjvTrsfge6UwSYhZZ6D5G1qiEhg3KnO4uF8tqzIYxL21dXEuEoZLYN2Gpx+QcTlcD2682hDQKRqj+TJBgEUqBLAws1JYS3IejLCCnntWMznXelk4glRoqa7fAz3UZ0HtNhhprXSIv8tXIZLiLB5+0LKf63FeMAvqyPJj3OyGdbAn4CVK78YGymmYj4wXka2RlbOsiF+kwzCx8m+4zKhcMu0vrh9CYvIEcgFFwGu4tAy0bhNP4uYC50NUo2l8o+4TswAQpOkD3LHsoO7aJ9DwsVjxFP4KGY9rmOzSJaiC/RcMp/SIewZH4Q0xuJqxtb/WZ2BYofNvDmovZ/iyh5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGdUHFaxgK2sH2aCiw4tL86EZHe4lYLV3BiPV0osGAE=;
 b=c4azKhENrgdB/xzlD3AnnGlceTzAqnHl9lzDmTJcFSB+HL+yCwCphKSAdsluWEIBmEg/MkfjJpZFnS8ABT74TOInAhSdywvwSbL6kAR3ui5djYq1fG0lwwo6m2GO78SLj6m81qXvjT2nQcfFnFRYQrFA45uvG0FQvAftXA1ydKPArF4Q6F7l71axbEowQe2T8CDNR2sSdaMjX49f8tfgcKjsMlk25LxrJigs0NBtsc7qPX8urDqxCHrSQ2eDZImZ5UdEVjZ/+SZjbLinT9fJU6YE+6EHh+ietVMPfKno34piJ7vYfBx9kH3BQrefQjLb3uD9yP3pCXx/gwiJIXE3Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGdUHFaxgK2sH2aCiw4tL86EZHe4lYLV3BiPV0osGAE=;
 b=fuSO0iIqqaQeV1t+hf/JC/X87W0mZEAA68DQkYIlP2zMO0g99QM18TkyNPLfFPg0KblZEPZ23xonbMCEBvycjTivVD0fad+Sf816jii7kbjSTlFNnDt99hKOgs5Wwwxb4TusEkiBYPZwMgm99jGNDZf12cwUTPtUJGugVb6tn+k=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH3PR12MB7691.namprd12.prod.outlook.com (2603:10b6:610:151::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 00:32:07 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%7]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 00:32:07 +0000
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
Subject: [PATCH v3 06/28] usb: gadget: f_tcm: Don't prepare BOT write request
 twice
Thread-Topic: [PATCH v3 06/28] usb: gadget: f_tcm: Don't prepare BOT write
 request twice
Thread-Index: AQHbS2Qba4VAzDTcF0+prwyD9wf8iA==
Date: Wed, 11 Dec 2024 00:32:07 +0000
Message-ID:
 <f4f26c3d586cde0d46f8c3bcb4e8ae32311b650d.1733876548.git.Thinh.Nguyen@synopsys.com>
References: <cover.1733876548.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1733876548.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH3PR12MB7691:EE_
x-ms-office365-filtering-correlation-id: 875f473a-d749-4b7f-3bc0-08dd197b3e28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?nNK93poZZv8vqpHmMueLgEaOo3RcT0sWecE8pFm1UlYb7GJ7VxTMPYVpV2?=
 =?iso-8859-1?Q?Ci/lT3B+RGzE8ptQdxwVG28MfzOQE09QsCUfyX/9fwU3jekbTIeG19Mkhp?=
 =?iso-8859-1?Q?qcWGG0lkbT0sy7myhc/zCyZxsPZHjx5Nt8jriEQ3hdellEr1XbAk7lBAiP?=
 =?iso-8859-1?Q?qtqR5W6tvZPA3UOEuEiNMvxgoI8xxrTX3O6OtoEO3YDdMMycbZDVaBMslx?=
 =?iso-8859-1?Q?ei76mEFiEg5AwnSwQ3SFvACzf53D5OuLIINepWEvPFXA0xh0uQ7tO+T2E0?=
 =?iso-8859-1?Q?Hq1GNnugyGKTPZpYrXgUQZ4/Xn1o1p6deb5kQeTus04qtcj9mJPRqD5BhP?=
 =?iso-8859-1?Q?GinYjPu9h8LMDosYX1QWpEqyNFT7Nn3gL1cA2VADJ7/17tjHzhTYjrnP1R?=
 =?iso-8859-1?Q?TYAXwST3bhpeptPbWJMkh7fL1XXZx3tKSDhl7xw2I53i3x1lRj28JfhHmn?=
 =?iso-8859-1?Q?O+ISKduCReP859nRrIVJylsxZdnWpiixpdvfS9+IS/hmhtmxO4LoCYzV+9?=
 =?iso-8859-1?Q?aaI4DMOQUwylewkdbvOHwkpfHIAxycO5pO06ahtERvJ8H7iHKZRE2lDoNg?=
 =?iso-8859-1?Q?TmihbM6/Aa9FHM2V6Dzbl8nUd4gtbIAfw+EzbMGIKs/M51SY6ylyUJRReD?=
 =?iso-8859-1?Q?IIfbLoihKlZYqSXYNUaKfoE8Nx/uG2E2/7cuW3uSXxjEApvXA71gH5Ang/?=
 =?iso-8859-1?Q?0OpOhvfFOruLZBLzYnjYT5T66p/wo6VXqwEg7nhIkdnUlqeYmUX+x+Fy7a?=
 =?iso-8859-1?Q?g+Z3SyV5OpcpHej9pfJ6BcejXuZiov3FT+xqBMVufmuTersJqtMwz+T2CZ?=
 =?iso-8859-1?Q?PeRV5AGrzBKcg8M74nAui/j6Ng8WOkzzWWjuxr4XM68yB3E4fWzMkPP9nH?=
 =?iso-8859-1?Q?WseoxUw1FyO1DwHpm4JgsSX359Y7UxT8dwviCSSSTKbu1g3eSLWtqyJvYq?=
 =?iso-8859-1?Q?0GV9NJYEp5D0U40ConyEyRUyBYkZTuB6KGAHaDBaAWk+O7W5G6Vwz6dqia?=
 =?iso-8859-1?Q?7wV9EVvKFVNkTfljHWwTOUzjmjTxBOdTDiFAcWRoIgAi+6mLwTW9omLMay?=
 =?iso-8859-1?Q?3mfEMpjPk3H5fog+5K6Gj6wPj0EpaRrfBIppYs1UODjZsbxzUhjFy9gWrX?=
 =?iso-8859-1?Q?gc+af2iFQecExhlfrR/GOKCwIWCvh9VAziqlfpbriOjzsqdYpIBMpObTkv?=
 =?iso-8859-1?Q?jrfAuQ6GCynEnQQxrOcfwLRyfcVSy+9W6Qw7qPOfGU0SeN+T+4jB7owGFT?=
 =?iso-8859-1?Q?EOagmyP98ImYahbS3bvxSBAiQxegrEpI/RTRDq8uf8X4YzNHTpi6lXEYvq?=
 =?iso-8859-1?Q?4iyqisUoZCkua4Nw/O22GxKC9u0nHrj2et32yMB+FTSUD1QGoDeTRTPZFH?=
 =?iso-8859-1?Q?OSN836b6hC/ESZYSJ7C80bq/FK3uzbxyLzEISqfkHjqsdZPyVERw7nAN3c?=
 =?iso-8859-1?Q?GB4mXaxokdK2tejCZBVSLNwXbunA9pc9D+K0WQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?3LeHpqxtFoTjCnDLz7QqTnqHFsxbhcidk45jAjcH8uNwYnI+5Gn9nQV7xS?=
 =?iso-8859-1?Q?jcBHQGgXadNBjEGiYk/wNCD5T/EkiLBkN7ZZZ3smP9nNyAvvh+2vVF2xvy?=
 =?iso-8859-1?Q?wchyqqGHw2OGBOD2G4558VV2dEUaF5oIXf6+lkxq7IGBfj9uSyiOWsifR0?=
 =?iso-8859-1?Q?kt8UOoe8AhvshJgJCVGp7/5226w+L88CgOU4fDK4Fjra2CpCxE0Lw8QQ2m?=
 =?iso-8859-1?Q?9DmuTWx2X73NyOqcaWp25UNXO7Hnm5JjI03S2WLi07jTuFlkLrEJnmfoKD?=
 =?iso-8859-1?Q?E7NGN8AWJSxZw7aXB6JZDP5md0W1YBpacuwO0SkzonuOXgU3PD0IgwC6Af?=
 =?iso-8859-1?Q?8esEB9Chv/6rAnAHbXLPos5RnczWBaFJOPnUHeGHJkciqPIt5Ck7lixuS0?=
 =?iso-8859-1?Q?f/QITTK/lE2xKSEvcWsgZV9lWKqN7eq2rMhgvWKhE9YcmobU4E5ehzC7ET?=
 =?iso-8859-1?Q?5Gwz4K8QmBUcRax2Cn+UkIS04zVSlyPmrIn+cAqVnyYrw1AyhTxv6uNoVF?=
 =?iso-8859-1?Q?V6Rs2UxiquiTgNSvNstX9Wz+2yKpt2Xcse/96fRJFaIWuMOov3L51+D9pF?=
 =?iso-8859-1?Q?tLhErM18iBbaUYH13ccxxS3mt8JACWp/+8dnUoFn1hQh3s54cwKIouuZg5?=
 =?iso-8859-1?Q?cc0XAsCPttFm4azH+yXSwoFFKojdb4KuHPAsryu3IRPy5dmAa52Lhxpv82?=
 =?iso-8859-1?Q?WvqUNglyvg9z0ndc/TgpFiq9wR0o6BeZYHlqqGCzY2Zn/rRXeXqbyTacUe?=
 =?iso-8859-1?Q?lx0gygw/qjupO6oJU54LTAGdvdQAyLDGIHalqbRUqguZRRXrdJY4XpZ19L?=
 =?iso-8859-1?Q?HwEAoyyv4ETJRZihx2hOV+n+BoKC/GQlBxXFItDyXY57R5hgJTcqkgHytn?=
 =?iso-8859-1?Q?QlH8++HroKEAPWgFPHHDqMt2W174Pruktjs8LmAIREwC+14+CF6ANzeZc/?=
 =?iso-8859-1?Q?W+q/g8t/840L/Cw+N7hZr4uJSmoJlg8IxCjkIHsnfVkc5PXUPvPJUmSOju?=
 =?iso-8859-1?Q?zDD36BPOzZhij91ocsM5n4ZGwgbNeV9b8WnV2UkkIRU/t/UEGfmn3SMrUv?=
 =?iso-8859-1?Q?iMa4bvp0zODzAnPPt61tNzpg+Y2BOsmLCIo8BpfBovNRxemO4JI7WTIbYW?=
 =?iso-8859-1?Q?KuUstQIg2uuXeY9HxD8AXfUUzSIeqV1nnKkKUgMqRa9SLMxF8wFDBNxCen?=
 =?iso-8859-1?Q?7Cj9yNKNpoDhe5H3FB7s2JMlYQjsy4x7oZRbAfxK2xncGjAuVrE0fdjevl?=
 =?iso-8859-1?Q?2RAVLI8JeTuFW5YKB9JLYH+4LpgTiDArj5oL0S0cYqkpDJYRoreFnnzMKz?=
 =?iso-8859-1?Q?lEppt4qhTvEfvclmykXYWHE9gmW2WZ35hVFIN80gMrUXPBQbGvAQe+qpes?=
 =?iso-8859-1?Q?BcXV0Je+Xo5B5+/bVY2MeoC0nDB6svAo8NliBEif4/wPCqnSwaku9FkKIu?=
 =?iso-8859-1?Q?J9SeCFwhzPZn2ZhGNnXomJ12RdcqzctPGwTsdwSqf4q6KJIMBSR/J05rC5?=
 =?iso-8859-1?Q?oh8gQdaLidYfC25t1CSyoMxAx+N95wVqSKxx6BBBF6eoxt2IGXAc4cjRca?=
 =?iso-8859-1?Q?rTl46GjUwlrlGeq8A7ikafEhukiXFvXsv7K2TYTIbWYCX4uqBt0BDwz9F8?=
 =?iso-8859-1?Q?YHZsuzK7S2Z/NOEuEtx/6MHIDA4WypBVwG?=
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
	umHc6Ud1RRVocvZp9qOlmFuh0GUyiws2UUUinxMk95thEAqBnqFLL5WAX0wkifqr2uYBggvzqaQF2f43gheVt6zxr95XFDVITMo7n3NBmQU0PCEJP1OF4LgquiuC5kDvLV/Gbw5osBXCwqdfCQx0AxOKUYL9R+JmZXvmediNWgnb1j/p1S7sd7gRHSsRthODnBy55k6yIbmgzsMv7Cn1E3YUHjJVqdp+ztQoH80Cir44+Gzfc5HkQgRhtbMeejAV90jcP+1n9Wdf5yu+o3kQOt8Rik8CSf72LZpMdSWlIbjUHormhwpBlwLosjehHLgIRNgQULtZm5XjZtiDbjAHW96oso8afyq9zDcbP1Ysvp8DphX5QtC1tAxPZh+vwOi/LjE4dS0H2+C7GRMzamN7Pvgj7d3KiAc/KFTD8wmxXanz2bLuIFceB7CtCNVuzoio3S/aX5LCYy8oWD7EMW1poT+y1bGB3JtVY+T5PE3jnTU4ZQA70NQFPkqbbIrcMmC2K7P66ZRUh4eWtK0bgKWfVQ7pfogrmHYPmk8t1SUF2fUHEq+LQyQgXOWJ5UK8zKNbKjmnta2lCSy7HE8MBtYf8grhS/nDNdIezE8sjH0mpp9wzVuL25NAH6Ryp1sOINEEhLcOoez9LiylQ8UvZMPIuw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 875f473a-d749-4b7f-3bc0-08dd197b3e28
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 00:32:07.0451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NVdMhDUei0+vtRcpw3yxncaW22UN0cYGJxjCSHQMBHxJ1YUnMflNZiZ/eo0D2ZJI0eIdzZMqRXc0QZ/F0tJ+Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7691
X-Proofpoint-GUID: bghzpIoZMAxexHUz5K8GKZtwt4wFV0BN
X-Proofpoint-ORIG-GUID: bghzpIoZMAxexHUz5K8GKZtwt4wFV0BN
X-Authority-Analysis: v=2.4 cv=KdsosRYD c=1 sm=1 tr=0 ts=6758dd8c cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RZcAm9yDv7YA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=6lpbQM8GuGKqb_z4f3IA:9 a=wPNLvfGTeEIA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxlogscore=566
 suspectscore=0 phishscore=0 mlxscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412110002

The duplicate kmalloc here is causing memory leak. The request
preparation in bot_send_write_request is also done in
usbg_prepare_w_request. Remove the duplicate work.

Fixes: c52661d60f63 ("usb-gadget: Initial merge of target module for UASP +=
 BOT")
Cc: stable@vger.kernel.org
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 drivers/usb/gadget/function/f_tcm.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/funct=
ion/f_tcm.c
index b35e0446d467..4fd56ae056a3 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -245,7 +245,6 @@ static int bot_send_write_request(struct usbg_cmd *cmd)
 {
 	struct f_uas *fu =3D cmd->fu;
 	struct se_cmd *se_cmd =3D &cmd->se_cmd;
-	struct usb_gadget *gadget =3D fuas_to_gadget(fu);
 	int ret;
=20
 	init_completion(&cmd->write_complete);
@@ -256,22 +255,6 @@ static int bot_send_write_request(struct usbg_cmd *cmd=
)
 		return -EINVAL;
 	}
=20
-	if (!gadget->sg_supported) {
-		cmd->data_buf =3D kmalloc(se_cmd->data_length, GFP_KERNEL);
-		if (!cmd->data_buf)
-			return -ENOMEM;
-
-		fu->bot_req_out->buf =3D cmd->data_buf;
-	} else {
-		fu->bot_req_out->buf =3D NULL;
-		fu->bot_req_out->num_sgs =3D se_cmd->t_data_nents;
-		fu->bot_req_out->sg =3D se_cmd->t_data_sg;
-	}
-
-	fu->bot_req_out->complete =3D usbg_data_write_cmpl;
-	fu->bot_req_out->length =3D se_cmd->data_length;
-	fu->bot_req_out->context =3D cmd;
-
 	ret =3D usbg_prepare_w_request(cmd, fu->bot_req_out);
 	if (ret)
 		goto cleanup;
--=20
2.28.0

