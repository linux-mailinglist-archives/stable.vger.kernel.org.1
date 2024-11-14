Return-Path: <stable+bounces-92968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8689C7FA9
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 02:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C160B2618F
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 01:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A5F1C4A02;
	Thu, 14 Nov 2024 01:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LoOFqZk/";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fciwpJBN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="tsuBiy1r"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C031BD4E2;
	Thu, 14 Nov 2024 01:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731546142; cv=fail; b=mehZVtJ26IlowAjY2qq+VrhFJzEvs3A08s/bRdXQ7/LuFJ09sxG/JGNqfseDbiuCprZw8+yBBQy4kwMIIdlAskq7zrWoiKZXt6bAJGws8AYl/uu+697aok1Bpxih/ugo9kCCF/zFMEv5cyfd3iSw7rUpdjk671+YrQLgTH9vsGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731546142; c=relaxed/simple;
	bh=bYvs8tcpr294vK7rXqOiDKRMrIoEHdrS4Yx1BLzmqGM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aqCbJLXiQw8vkGFlYDgU+aepCHxeiVnW5+eZWbBCc/Wu/AFh5HF0zWDN4EUZfRIV+jDmKHWVCMz53NLHVdrG6MHNNDnJKaXYuQNN/S1UTFtvYFsI8o04EB0ZvAmvuwb7UTvh2VfcXXFG2eAYWgP8IxzLmIe0ss+8LcPTEZEZjzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=LoOFqZk/; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=fciwpJBN; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=tsuBiy1r reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADI8FEP017220;
	Wed, 13 Nov 2024 17:02:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfptdkimsnps;
	 bh=3ZXrwiZ4ir0JHDqHd0gvin1gw6GsK2wqKqCKV509PiM=; b=LoOFqZk/u+Bu
	uMUt/g/KapaQaRNmUw4IUsbkba5Qsk1kt/ZR2kYZtBBeNwb9lfNosyAYPQVKPJ7G
	6OVI0onNcF3kvdlZKj4H4o5tNmSEbk8ePj7ql8+MHSfDcONFQzMTGp4MpCgg03Pw
	FTV3WYagdSwfbDD9/6gsEMBqGd76G1Oq0wEVJOSF/K9gpeiixKi/AotVC3iCtGjY
	gONgrUXamm6bsLXQZ57yRb2zI/rScjujYpUYIM842Mjn82IlBelTqirhcaP6iv4r
	lzOG4uV3Y/8QdM7TTW+rLzOcJgkR6+MKhtZQXInLk8yd7HWpyaZ+dO1DxQkTzisT
	CzG9wy+C/A==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 42t7vb20ab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 17:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1731546138; bh=bYvs8tcpr294vK7rXqOiDKRMrIoEHdrS4Yx1BLzmqGM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=fciwpJBNWrmtO/UYmdvknWoqGhIRwOcFROPyS3N8i5VqCAzm3Trr7srQS5j2i/fhb
	 rcS3GxRLELqEtmkMpSlPRUSn26+UYKwlqK2LXWcrZGUeqNfKFn8wfLvvnCOoLG1F/F
	 oRITu08Qup8Dez4PIOYQjgrIBKbnvznDvyqArELe09AYN2WqvPkl/YcAspxgxe5wEP
	 GlXQGGvn2tefaIlC+0NCJ/mcSB46IJqhVGPDY0D6SkjM93JXrKfrsXIoiG+Qdb0SwQ
	 Sysd3vwGqROinAItCS23agqN/dDZqS1L3ZtJGpDEr/AbhcuDbS7q9Bpx/L+MrRWMNa
	 bKfqGDUHAwjvg==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3D60640126;
	Thu, 14 Nov 2024 01:02:18 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 00F2BA0084;
	Thu, 14 Nov 2024 01:02:17 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=tsuBiy1r;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4BC3040114;
	Thu, 14 Nov 2024 01:02:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kElvoeCmf1eDXCdEKxp5TCEDYYSa8Ji9+hP7nOUR8mTT7ZLEUxN0NxNXBh/IL2uC0sQP/Tzk/JefRm2dYNRTkhqbzbCIqbCS3Ik4HMhxa/0m5IQGd0RP+c1L9ZPz9ClfqaO2Gl7x3YcRiSV2z18+D30VkG+rgUfD+vEV1NH9qexdnBrWLk7gMK6rjllUl9m4YBhfo01GFctgrJEbhgjpwdr13/lDHWUuvR2ema/MMT+F00o45K5M6THs1EQwDD8Fc+QGYQfiiT9IzoqmBRsLMVlCWD3OsYsuXUsuZWnlPk87GvtgOj8W/g3XV3kgtUtzU24TBGwVlW6nk2cuQs8WPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZXrwiZ4ir0JHDqHd0gvin1gw6GsK2wqKqCKV509PiM=;
 b=QmFgFq5lduGqOcvTb/7LcvKJ7AZHI6P2okt+gfmKjO/0x9TkE1b2TfF4ucdNmL4Lh8rqcb5fFF4GugSc11EXY2T51+D4a/BQ/P70kdujFRNJZh+JBJeetD8FZ/qUsY1fHAH9nWg7osrAbs99yQLRt/JdsdLyWd8v0f6OJhfS0Sgbq5GwY5Ls31wJ+/fy7JwL7XA1GGXV5MC4Te7DFoyKEOzWgbS2MRz4NO/t0X0j71J/cRIanT2QH+HHQaRTA1efVHQDGLnCHJ+0f+cuzf0sVuR05fjbAOhoT6CIH526Ijn/3DL3gLPgLwFp6dpXNXSsb4cwOkVUTNgSf/a4IwdZ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZXrwiZ4ir0JHDqHd0gvin1gw6GsK2wqKqCKV509PiM=;
 b=tsuBiy1rGLsLvxHtcnsoT9PseN6keFtJXxOwuc3luMDdUMA8TjWStApSxQMO7ZhJErZd8Igch8jlx0SIzLL2aStiLGlDzWgJE7J23ChLNRITK7BIXUHAKRqAhb+GENnWWjWuQTm5hZVAAHch73lguuWjQPuZ8pbA/2fE2F9/ucw=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SA3PR12MB7950.namprd12.prod.outlook.com (2603:10b6:806:31c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 14 Nov
 2024 01:02:12 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 01:02:12 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC: John Youn <John.Youn@synopsys.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 2/5] usb: dwc3: gadget: Fix checking for number of TRBs left
Thread-Topic: [PATCH 2/5] usb: dwc3: gadget: Fix checking for number of TRBs
 left
Thread-Index: AQHbNjDWG6td5szbI0yZCeDKS7tsqA==
Date: Thu, 14 Nov 2024 01:02:12 +0000
Message-ID:
 <708dc62b56b77da1f704cc2ae9b6ddb1f2dbef1f.1731545781.git.Thinh.Nguyen@synopsys.com>
References: <cover.1731545781.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1731545781.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SA3PR12MB7950:EE_
x-ms-office365-filtering-correlation-id: 9e033aab-c0c6-44ce-48a2-08dd0447f93e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?JNjpdgzvGpXQASJ5X9FCB4vijO0NzXK0qvM2k/9QKk4kHztH9jBj3ImpA2?=
 =?iso-8859-1?Q?Kowikmfs58V+LWdU5pM0xmCUpkeEyEmaeuOcd5DCgNNj3EW8JucTvxd28p?=
 =?iso-8859-1?Q?jPXbfgP2tuLrvkX9rrzammaWEBvgPbjLAyM0kijsYn5fKKl0cSAaOkVOSJ?=
 =?iso-8859-1?Q?8s9HSDrsApK52we2YWuriNrue87ZmzcwrSGd+nm5agooezd8i52mpabwOC?=
 =?iso-8859-1?Q?4gta01DV4n8p/jWCy7W5/wL+YwU1zXVbFGVYcaZ/Gp/U93uZG+u16quyhF?=
 =?iso-8859-1?Q?6GDaRHcg9ujvHjavbFzgNmBaG4SqVSE5slNtrMaF/B6VD9n8F8ed8O4f2i?=
 =?iso-8859-1?Q?BDitCnep8eFmHyou91PDSkKKrBZVUDaKY9rcYbHGuKB8G/aJ7c8LM6hwb2?=
 =?iso-8859-1?Q?o+sEIGxD/mABIToxH4I2mG5XxhRyqmvqhkb+68bapd+5cUEEDifPoPMFnb?=
 =?iso-8859-1?Q?srVxWze3/nf+o2WId5jnJBc2vheM+9OtcfmzXm8TJ0oUbiQ8nNpyFbsCkZ?=
 =?iso-8859-1?Q?lKk/WcuKGiRRNx3diQLYxn3JbkHE4Q3akhWhnR4ZpBQuzEGzYDYsYiKzNw?=
 =?iso-8859-1?Q?4GMo8kVIXV5na4AipHUPPDh4toDH3cGY1FplsMOQ6hnamfkUh9HB9QZ6p+?=
 =?iso-8859-1?Q?U4WZj0UxYCiYPZvzmbs6FussxfqdmqTDnDo+VSN2ggGA65A3lH/OrVAS8p?=
 =?iso-8859-1?Q?lJgY8N1P0lEHP54BCfREoElkaThiq0HjtH8X7KGFwunyR8Ya0Kn6WfslDv?=
 =?iso-8859-1?Q?4VsSDiRdHzmJmmmE0ZhiCcmTIKBMzpq4E9D2DSMqSyukuVOTLZGNHfSEQE?=
 =?iso-8859-1?Q?qmut1F9TuGGWa+XmfVxTZuG1J6xuswYmIjLeQB5R9RntCzHGzxQv0q33Vc?=
 =?iso-8859-1?Q?OdlFJBoNkW604G8900E1uAqyio9ok+2sXbUh+VY0X9jzz4PvqxYcEi33iV?=
 =?iso-8859-1?Q?t6IZ1JuH+glWpfgoRcS/lhb9SCH+gDZi6H93c3WFsgM609pgwv8cSQVdms?=
 =?iso-8859-1?Q?3nPlgiPDHUQZ8HkUIZlVj9oo/sU5lnLshDB8OJK6uXZ6P0p6zjQEI7ZNGd?=
 =?iso-8859-1?Q?5wHzd8kzrkDs6xZVYunqfBCX9k4q97lx4MdPs1/mDh3j/liiCaRSpjMyvs?=
 =?iso-8859-1?Q?OJJ7wfXBu5QZq4nQ5yNnP/hSczMcQkt52N4vwQFZ1cV74AiVjLlVeUnz+d?=
 =?iso-8859-1?Q?5MbiCojdzbQFaGD5fsIxoXt4vKh7wi1CsKepFCo5VNJjbBN7uAx+Zln2hL?=
 =?iso-8859-1?Q?95RkDet7bNPgCVtiU6FaQ7oUfdMVOpjhACYxLWRG3GOvVGDmYs7hdRgOap?=
 =?iso-8859-1?Q?pxIEJazNrvHhcEwH5m12B53NzOmaZQKks+BNV2LBGgW7h7IyORQjQJTy1c?=
 =?iso-8859-1?Q?PKKFT+6+OA3Os3Tw11KBWes4aX64xu96wtXUNaFrOhP4YCcNjcZSE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?0pjnpoDhWQhVAnrVN1Yy0tuJuiob8OhiwUHI4+5VHQMNZonCfx18vmVYUM?=
 =?iso-8859-1?Q?GoqiBT+bygMkC72MyG08FSgEOd+k5T6YRGP9DgioaoJ4Qya+NnXjmeIAJL?=
 =?iso-8859-1?Q?c9BsMaWzxKelUwoo3QQpYTMnHNMKtO8rMMgHI/xhrj0OkK7zw9N0w267hD?=
 =?iso-8859-1?Q?LH+M+CrgCA+cDTpoEsYwfyZJ2X3ejS+yMY4T3sx49WFL8uydekuW799K7Z?=
 =?iso-8859-1?Q?pFjS4shqnxZG7+GgRdrMUp+b6Y4OyrdDHZ7jv1STI3J3rxc7fK9jkPfYFw?=
 =?iso-8859-1?Q?652spUirSYTq2tkQI6QXjxXxd25gtmu9sXtBGba4h7euY5iefRS8Z5OBTU?=
 =?iso-8859-1?Q?sZWGo8iLOKnfQMP/juhqtYzLiD2Znd2Wy2qF1QXS2mQOWPyxmu9d1n3BOD?=
 =?iso-8859-1?Q?OXaYkz1g+EmNilR/yVpxHcxGFcpSRa5zd+APgttAIeXbHBRj2KrtVQsQd9?=
 =?iso-8859-1?Q?43BR5bd++D70hEAyiDcoVJW8SyaJ5cJpLBB9W5GjNSLA9g8MgtpZ5ys2/s?=
 =?iso-8859-1?Q?A0UzOex4Pm5azTWxihmE/GX/aiuJNOllU5vKRjpoPCsXkXKrCy/xW8x+XO?=
 =?iso-8859-1?Q?+yPAMKnRnrUoVlHqWk9Pof9DBO5c3F4agKwvSZ9hwcBgCPYAfyOpRKQfkM?=
 =?iso-8859-1?Q?nNIRS0AG0eHNN+coKNqrn47DVUmKWS+ZorJZipjJLChTUAuVeqnwGx/9oX?=
 =?iso-8859-1?Q?Obm2lKwH1Js69mws0VXvMaMGsatnOGHpx0aGBdW2Mk3jdhguDJcVViIKd4?=
 =?iso-8859-1?Q?jT4iidw+F990lg5o7nXSvPpNU5QEDXlyN1sZzPzkzNjYmm+Up7317nOlFp?=
 =?iso-8859-1?Q?7XbgZxp8H8EpDnn/ErINe95LHw11LF/U9iO+F4YS7ujUu420H8xU2UfVyX?=
 =?iso-8859-1?Q?4mxlE8lC5KPgm6GWLSZqsgp7g5PmLL6ODVFSFNuRYuLmC/HqVX01WW3+HQ?=
 =?iso-8859-1?Q?4NcLNNJHMZp8G2W2KETR8axHNhs5L/411ieJP6Kr1ujapJDXcjusTAeEKu?=
 =?iso-8859-1?Q?PvwaP+MFd0b1ANcU0uvCHtoRInGOTWtV/JN65bC770cUI0fGZDk/fqTSfV?=
 =?iso-8859-1?Q?ucwp5KVKiPdQR9FS4uvFFRVtHc/McIR1qwIlPd1Ey/+NUPVOBfWBXLt97T?=
 =?iso-8859-1?Q?k7Y9/dB3Moqlc1TkQVrkrV1yOv6baArf1fgm9qpsjQTfemi713sKuGN0Zl?=
 =?iso-8859-1?Q?IqArCbF2ps7N+4NF9eAfoCSp4nshgpuubWNBYjcb2Hl7gHp6SOjiGrddvH?=
 =?iso-8859-1?Q?yuecpa/5WCcYOhVrR4crhjCltgswVUTUdR/9Qk2w6ZLmROMZQQ7IMiFIVj?=
 =?iso-8859-1?Q?xlHLLZEcfSjm1EHZFfRZUWna7v1ijQ/CX6xaMt0zm+kpoC6IMbtziNbLMj?=
 =?iso-8859-1?Q?/U3+YBLjWdJZ1UBa+D1IBhNtIMk2UTDR/d6SPAKP3suiHup6OWKRhZqy6c?=
 =?iso-8859-1?Q?aPQWFtfF9lIPGnVwUiHoHa/OYSEApZjyFi9FrO0pIBdzk51sb8/wc+U5RU?=
 =?iso-8859-1?Q?n2dtTAVJwGoSm2zIhSuJEn882wfl0+BVXGUFa9me8ydoz6UkK5dE2x3Xrg?=
 =?iso-8859-1?Q?MuArfiLblHHZmq6dhVHF01nTHZVUNMFVJ2QuRChUEnVhtlBV2cqcUvQxNy?=
 =?iso-8859-1?Q?juYN1r/aedreOLL0k2P3OydFC4iLjBsN3L?=
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
	2bPcxFJPRipBLwdH3HVYUTfndsQXJYmpVcQfx6KptHz9fOpVq59yTtQ8nbGt6dvnKn8Q4ccgIjsDknU2ajx2f0NV7vm6/d+9MLBo64uUOqjQlmU72014RshMzyVa60C0oWYiUCT7uSJx+W7x4iro3aZ0ndQaP87BXKHA58o2TfH8bEnmUhRwKw9PWMBUjm+hnF95txPGOU4EV9ME7eyVzjS67GgXw3is5G6SWKyX9phG9W79ac/IL7KpEAT60P9OdLdvwQYwp+CuY7ymg9cOwVmlJgeNaP75EQl2K74APIRkFFMOkDdWstebB/Kpst7vQPhja8Bci2mAdkRKjisBG5DsBDyYYJ7gIGvPJrfZsZIAB/AQvBDiDTZyKA/FlVmECxB1EC/DNAJnIQejPfTdwLmi1+LSK7hM91Ms/LRuv7MdMpe/6zXCkkBN0iSmR0d3drNU5mY9/khzqF08EIGQ9HoOcjROOcV2w2uld+Q13iFgT7XbD8OTETONEYz7C0QPxQhvw0cpMs5nNfJhmc5+o2n61ENBJ5clAzaYroZcJKE9loDMwEYZWKCDO/y4Hv6cj2JIHJBRp5VL83AB+yAoC8arfwupIkJvgXEziReb+TcT8ZK9QBfIqjDnTHP6MTrMrgn1jqS5j1zMCIB8HVLqeA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e033aab-c0c6-44ce-48a2-08dd0447f93e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 01:02:12.6952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vl35YNLYtXIHvZ/MdzJcHLP1TJCLci2Lm1D0pGItS8IrHih/8A8ja1aZWLiWp27NAZlr8jZYF8wq+zHiMxO8Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7950
X-Proofpoint-GUID: J3GDjRsM7jsEMI2pwY5KKQUxOmL_o2JX
X-Proofpoint-ORIG-GUID: J3GDjRsM7jsEMI2pwY5KKQUxOmL_o2JX
X-Authority-Analysis: v=2.4 cv=CqztcW4D c=1 sm=1 tr=0 ts=67354c1a cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=VlfZXiiP6vEA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=vgzQuDIMdibFOyEokrEA:9 a=wPNLvfGTeEIA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0
 clxscore=1015 spamscore=0 suspectscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411140005

The check whether the TRB ring is full or empty in dwc3_calc_trbs_left()
is insufficient. It assumes there are active TRBs if there's any request
in the started_list. However, that's not the case for requests with a
large SG list.

That is, if we have a single usb request that requires more TRBs than
the total TRBs in the TRB ring, the queued TRBs will be available when
all the TRBs in the ring are completed. But the request is only
partially completed and remains in the started_list. With the current
logic, the TRB ring is empty, but dwc3_calc_trbs_left() returns 0.

Fix this by additionally checking for the request->num_trbs for active
TRB count.

Cc: stable@vger.kernel.org
Fixes: 51f1954ad853 ("usb: dwc3: gadget: Fix dwc3_calc_trbs_left()")
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 drivers/usb/dwc3/gadget.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 6101e5467b08..38c3769a6c48 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1230,11 +1230,14 @@ static u32 dwc3_calc_trbs_left(struct dwc3_ep *dep)
 	 * pending to be processed by the driver.
 	 */
 	if (dep->trb_enqueue =3D=3D dep->trb_dequeue) {
+		struct dwc3_request *req;
+
 		/*
-		 * If there is any request remained in the started_list at
-		 * this point, that means there is no TRB available.
+		 * If there is any request remained in the started_list with
+		 * active TRBs at this point, then there is no TRB available.
 		 */
-		if (!list_empty(&dep->started_list))
+		req =3D next_request(&dep->started_list);
+		if (req && req->num_trbs)
 			return 0;
=20
 		return DWC3_TRB_NUM - 1;
--=20
2.28.0

