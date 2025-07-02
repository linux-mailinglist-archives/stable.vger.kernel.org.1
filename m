Return-Path: <stable+bounces-159239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC039AF5827
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 15:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE8523BB7F7
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 13:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B02A24DD18;
	Wed,  2 Jul 2025 13:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="vRnQTAW8";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jUi8BIvs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="hWsJhyvl"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F99238171
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 13:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751461873; cv=fail; b=pTm6b8CWz5dTH7zQL68qLNZzdETaML0jLZHGs0IH15XvjqpkfJk/aiSjM3oARDMlP1lKPjGscaDostvVtJCI6R3nPGv//ElvMvqA5aPnRoay0ZUo12cdBRN1BWfRFR6ouBzhTELJUUfgHhJw6K8TDVWE3xYPzTFOHkRhm0hdznA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751461873; c=relaxed/simple;
	bh=Q+ReNiw1v/QvgfAkB577X8lTAisoj15Rk2K/uxYB6So=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=M5bfkcS+JwQPHggwIBXdsGvdyJWPKk6+UYmRGEiObPDQAQ1V8hkRr8CgB4oMO7EMxHsKWHpH9t9DpLHr4u4OkN0E4CW3mQqElkrrKjHrHKB7giT2RWghVuw8OXXqInmEkWR580eK8BghBsfyq8rqUTA6jp4vDJJwC5KLMd+nIWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=vRnQTAW8; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=jUi8BIvs; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=hWsJhyvl reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562830Ao015659;
	Wed, 2 Jul 2025 05:21:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfptdkimsnps; bh=ltHPUbWGFjjEHbLWg0N
	W7CcLppH/VLQNKcCGMMLBRts=; b=vRnQTAW8Ie2lIXI8ppC5QIhwV/wjalyIavm
	UHzds4rbN6ddKE0GyJpGhGTwbicuf3AmhBfVhTXBLCKLiVAoR3RILl84lxBN7R9v
	uZGAoggg5+oIkkjO6MjFNDmi3kSES5spdkAcAIuCPQRZ+PhCp8Z3HAue6TwSOyLv
	cNbUu2JlED3ybXChrSaNCMR/dpH7crROKY00paTJ6uvNDQQ+JRn8miGPsngXXnXc
	9pnUEd1Jiu/v/j2qAlyTPpdmzUtl1dBSzGhaX5ASR+LEWlQhgxIqMIo2aHnMCfmn
	/vgGCuRO0p+5H2M3BPXxqZxW2E7+p1IIJ5qEaB/x58FnCstXt9A==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 47m9jwyb03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 05:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1751458891; bh=Q+ReNiw1v/QvgfAkB577X8lTAisoj15Rk2K/uxYB6So=;
	h=From:To:CC:Subject:Date:From;
	b=jUi8BIvs4WO8N4u+GJ7oGtOlOpblwffrD/7vwvWSmzAfHah0UPc+CUez7PNrkCGVa
	 pMD8fzijtVTqjCfJbNPGm8msYjQF5rY9WekhRbqyGBtUjUr6tvKW1fKmDO8N8q41JE
	 8pJPOkOJCe1a0y2K866dhKytorxEVFv1u3YFcFVjZq5r/lVpNuebgkAI6BVWb56dHI
	 sy64FLQKLjOLpd45g2ut5tV+xA5XjiD+nJK8JPoZPuOKxiAXqz3YVEVqyEL6ayOjge
	 6XL8Q+2SO+K1QnQO7DMQCU8JdrHphPJGVdz1VrNfMnaN0kO+1vKSjFDGrXYkcuj5D0
	 7NMM3pH2YHXaQ==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AE2EF40361;
	Wed,  2 Jul 2025 12:21:31 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 2B2CDA0070;
	Wed,  2 Jul 2025 12:21:31 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=hWsJhyvl;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id F1F17404D6;
	Wed,  2 Jul 2025 12:21:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xK4Os5tk1t9pH9IbYIGWUQhp4HBCirQuH19mJ5WioIsmZ+NTpz85dnTLyX62qZcMPX+AlThKtHC4TfbHa4gCPT5efZtElsT1BUB5dBHbtfUE9IZRzB+zsX0eXyl/RXVBRDPlsPl9gYCS/vNrTw3UIdGlrwIvxYX6RmhPbQFZ6VzU6MeY1B8pmbN7+h8lrhBB53v/DaIsWyacmRF/31cR8/8q50D2erH9Lj6aW8zrNTOm6NamWcdVzDWSmuZimZcs4oLI9d3K+qUzv2TrlEhpyE3RUGTkl+pnbqWtDBKSxvqwb1DKXIQS//vQ20kM2866DIGDrj2H8TbHQFVaUO6x/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltHPUbWGFjjEHbLWg0NW7CcLppH/VLQNKcCGMMLBRts=;
 b=JGli6i99dKXx7YtpCEVyPzJ6gtKnOTRSjX1seeldV2upKkjazHABDUgaw8ccJwUoa8Z6LVsvi0bxuJWDAxUpSD0p03OEUIat1MtonzGBbH3NmxzqspRJnO8if6IOJxXf/WLitHUoIDEDHjxNxpJlOZc2jCmuEeSyw6rpTKtBaq+THjHUJBpKgMCh++O6SX6CLd/3WOBH57oVX0PuC58IymV8Wj9ybtC+DDomdCjs5VHF8HFNYaPPueqW/AaFWc4edK2yrfuaaiPCj55XsKsLayxhwSZYXuQqepKemNHIvbebzEO25BxCyEqc1Ya9gP61qfqward4TLnZAm6/qcxcEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltHPUbWGFjjEHbLWg0NW7CcLppH/VLQNKcCGMMLBRts=;
 b=hWsJhyvl0wOh4r5WAsR/uTFcW/RMGiE5+1CAuL417Kr4pscT/xfD80llG7T/8oayn8v+nWzDj/fmJX7RR/k1+qLGm5TC4wOrzoPYkU9yZALqY/QD+pybHkh5Yzl6UwOZ71OrJ/8I8cbkVclJTm2NlVerC/rmQTCNUy6CyG73koU=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by IA0PR12MB8693.namprd12.prod.outlook.com (2603:10b6:208:48e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Wed, 2 Jul
 2025 12:21:23 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%4]) with mapi id 15.20.8880.029; Wed, 2 Jul 2025
 12:21:22 +0000
X-SNPS-Relay: synopsys.com
From: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
CC: John Youn <John.Youn@synopsys.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v 6] usb: dwc2: gadget: Fix enter to hibernation for UTMI+ PHY
Thread-Topic: [PATCH v 6] usb: dwc2: gadget: Fix enter to hibernation for
 UTMI+ PHY
Thread-Index: AQHb60vS4WCSA7jdmUO+FbW76Y4hwQ==
Date: Wed, 2 Jul 2025 12:21:22 +0000
Message-ID:
 <692110d3c3d9bb2a91cedf24528a7710adc55452.1751458314.git.Minas.Harutyunyan@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|IA0PR12MB8693:EE_
x-ms-office365-filtering-correlation-id: ab6c779d-1f21-4a77-4047-08ddb962f4f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?gLurD7vfGZB22/DdeF5Jy3o7nlRpsHuPUaeaLfJ7U4HLXejvofllF8M/sC?=
 =?iso-8859-1?Q?Q6lfItlrpKei5Q2p83/oFp1U2c6pwc4EU7WROVntBb4eDPfczTwVwCxhr7?=
 =?iso-8859-1?Q?QWIz3DlaMAZ09eCVvO6necBrSpUXAZDfKScBxIfOi71MXyT20HlpbJ+2AE?=
 =?iso-8859-1?Q?R23McwXncYrDNW2SFSLLFjmjqawk8DLo98YErfVlhtfq9zAsR5ztniDU98?=
 =?iso-8859-1?Q?t9cXXNvq70Srl3BwHOyyAwQ04R50rbjHeuOCrO/wR9RmkVp77Puw4SxZrM?=
 =?iso-8859-1?Q?88mLlDoZexyiJ333/ghkaWnDoF/gM0aKoBs0ERSxet7L3UnI3+BxDtPwCT?=
 =?iso-8859-1?Q?ivYuXFTNEpMhWNmWLWUr5bC7kVjS11SxdQocvVKBk+d4qr1/Xmr7MPkrNW?=
 =?iso-8859-1?Q?Quf9v/1UxZUlHSJmzXdVzeL8PbEHChRvh9wpLnwA2DmbdVwSlczHBnSWwM?=
 =?iso-8859-1?Q?RfZGhgyKAT4Fg5H++qK6RmZ8aSmhY/RYukWi1qHYwfITpKt9lHMBqnjXwo?=
 =?iso-8859-1?Q?wS4B7lVbUZeTb/TvHP2dBTSKxFTiYNiLlTynVfUU2BG9Oozngqn0IlcKiR?=
 =?iso-8859-1?Q?alniuCLxGW/NUlMRPR7poil9jKuNLpOf0SeQK5GzvySLKv2utykdTUcKBE?=
 =?iso-8859-1?Q?F2ABQWDYGTIxD7yWDosqVPNWSMF+A5HmBKMFkp96ZjnfH9RThMmL9GCkca?=
 =?iso-8859-1?Q?UBIxCOYmaBlWh3TpWELSs65Gq9MLvhGQDDMLQE3Bj/uc5f8/EBMGJhRnmn?=
 =?iso-8859-1?Q?4hpTgCuIW5EqShNB6L4+JLt0pzrEadMjBVOvRzO5yT5kMfVCQ3Z1RClGc4?=
 =?iso-8859-1?Q?Szs+BZvftn58cklPvaCdC83jqvLWiVm65kFGl2PGttlCyK5u4zT0Dn7UqH?=
 =?iso-8859-1?Q?rKeTEdMsjAiKX2THSGssO48eyiMzz1/Ryl/pNwo8jau7C/l1glzpl1uQP3?=
 =?iso-8859-1?Q?7v/v5MjUcJE/pMScKcM+VLKff2gugZc2vYPTbcEPlN6/9W2EBOOp1kv407?=
 =?iso-8859-1?Q?FmwRyePxDDd3dskLTU5g0gWehcYvsKLUPGG6rEuTlZgMbmI38KjxZRRn9i?=
 =?iso-8859-1?Q?lIl6OST9PFv4pnyPF2VoaLqacMCXB57EKvQ7ASv2NXRC1mjaXs0ri7Mj3D?=
 =?iso-8859-1?Q?WT31JE4ki0wGvDAb+5uz/PRkNPZo3/0VJPjjFoXsNsdDwgMgNH4SlFtGmK?=
 =?iso-8859-1?Q?pbX2MiHl2r2J9RrNJKq3UnZaZHrmEV4j0Sy/BU9IoYUnZ8tmGxoHgPSR1s?=
 =?iso-8859-1?Q?BNtDjBYizHe4VwV2YtBYS/AjrXKla5ikL3uPeog/uB1IAY9GSnbw5AdInE?=
 =?iso-8859-1?Q?OMQD8L/Ol/LHbIIWE59N8s+eNvzYpiVAT19HCbwlDDoQaKWLWqiHYPgyyO?=
 =?iso-8859-1?Q?Up2yiE12XzeyTLqxuUDP+visiw/M+2m4hwWwhLcxTygeh4mzj1pX5qSRgm?=
 =?iso-8859-1?Q?MqHN+OFRhezgPGcF1Kv8U2WdPfd5fOoPk9S1EOLm1eJd0TkdINj8qh/1AN?=
 =?iso-8859-1?Q?Iun60mTeDGucz9J/mGya75Ik2v0AsBrbPvIiuWrwpI5m8KdRJaClBMVy4y?=
 =?iso-8859-1?Q?Hy8oRlk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8796.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?jMquOLd61eV1A70C9dkWVoHIXp2udsIfMuKhOYIPNWhgZoCVAMLwcpOJCl?=
 =?iso-8859-1?Q?2FUb8MQPbUVmXrS10zUBISMAcf694i9soUNceI7cv10Eulg4YvTfBzZ5qX?=
 =?iso-8859-1?Q?R2eBqgQ32/DfIMbyEHpWiuyx17IRWkFw8KhBW0UpYMV/WMAvoAfXx8QakX?=
 =?iso-8859-1?Q?tKdPldljDtmvO1fVQCk55gpGXcwwHoXx5hoOJv1aokqqOk+FAqiCOSlDQs?=
 =?iso-8859-1?Q?ym6vgQi9FH56d/qKr1HLcfbenA2xrfKHo4AmDp0XUS391qzC+i6J06u+d8?=
 =?iso-8859-1?Q?qs0xynQtq/5NxlJGQISIh7EQ5pzD1X4SCIW7KeIbXCqPD3kS23s/GzCXDD?=
 =?iso-8859-1?Q?XnBd/J42o4uVr+H9sNlLzidXItJz4zT63XaHMMajLfBbAYvQpV2Zvslh25?=
 =?iso-8859-1?Q?q7iU7a7WaIUP+QvVQPbI6UVnENz/IrxfN2RpFQ2mwELciltJBij7ldl7v6?=
 =?iso-8859-1?Q?zE6yE7RZYS66cKp5PSbc43OYHbw/vewYcn5USQScWy8s76ncC40gZVLfhl?=
 =?iso-8859-1?Q?1s1x/b3i0agYAmtHCd/DyBjBi3nRziBOieToNUzXPxFBJim21nkr0tYf94?=
 =?iso-8859-1?Q?QSN/+SNbno1zYlqrbvjng8VhNQ+4vO2fzR/Eb2ECu3RGvGAfDEICD01YE8?=
 =?iso-8859-1?Q?T6KnBLKSrygoJC43sSuHxyVDIa8RXIKK6FvuikdkjkHAma3LbFoDxtbiYW?=
 =?iso-8859-1?Q?m4ZXHk7YM/xfsoRAqgu9akWYiP4vFVj/zkhGbJJZoiCtqmq8M2OFSSD5jH?=
 =?iso-8859-1?Q?rt65TPcyTCgJVR2u5XCTuZWReJR+OotthIvPYzwFG3/tpqSQIITzW1k9EJ?=
 =?iso-8859-1?Q?fWHsU6H5gYkrasY0GTvX67vYJIhwpKPVodWtYL0vrxIh7cVfqfZnxaf6uf?=
 =?iso-8859-1?Q?6BU+x16mLL2BzP+qxevaX6dDs4dPwZbIBqV+uJ92AdCg9BJTIpguDACRSe?=
 =?iso-8859-1?Q?sOBZGI22LZHKgPKanfTUZ+ZooKO0IIM5qr943zQDtKrvbyyPzq2jI9LAL9?=
 =?iso-8859-1?Q?tjtRNFJjNJpH6eSxNvNacdoRTbIoAU8WDb/Dd/naw+84CdYf0QX2NUjXgD?=
 =?iso-8859-1?Q?7B6sJ3jw+MtaNpYS1OAUU1zYL3Y/NMR4ta+NewASsH6p59qh1EHFFtNgLW?=
 =?iso-8859-1?Q?ckAFFqSmkdbKBDJsrANgoDfuG64f4hgtk1Zbs7zGQODO7eounXbjS0u+m+?=
 =?iso-8859-1?Q?vOyIjTQBLnEf4bPSwxlwopisw5cLoQ5NIRav7oWwoIRJA1wmvmMP/UGlOg?=
 =?iso-8859-1?Q?t9TDv3YvnFTtUIr7XsGUCVUYyctXEtb7vV9Qkoqij17TNdpO3wfLcaJVFw?=
 =?iso-8859-1?Q?WBsUdNteSXsXYcQIC8Ncg21sT6lQZXbAY8OXhVTYTR5B7NK4hZtAkOfp8e?=
 =?iso-8859-1?Q?VxTPTSKrvKUtSqYTzU4cgxONKhC2Xtwb1dkZcCmytYjrFjSNSuqbM7S14O?=
 =?iso-8859-1?Q?ciklrWLMa5x2KtopDEP96TAl+Xw7WVWR/xLSal5UsNoVhVTb8SuJBcTIhT?=
 =?iso-8859-1?Q?UQwIv9U4V+LIfBjRKxCa3SrtO8or/4uQvFzlr5ye1AuzasC4j7T8pReo31?=
 =?iso-8859-1?Q?k1Tk889x2sIIEIBzzRkzObHG9jXWNT7e0wnbCLPKUtCSLPOFoLStpHGjjB?=
 =?iso-8859-1?Q?3nBwAtKFza14l8cTcfjVYDCw8S6JmW91aF?=
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
	LV4jqVt6FgoQzBpdvx7qnSEIZWs1Ai3/uAiGWJ6FkHZiIiLSW3fhe4M4BOVTgaTcSat8hNAv6KKQwpTbKbga9DmFhZCYsExgA0bHhVeK58R0WjioZA2tJUaPQbWBluGOorJ9e6U2d0F4l3w7PRjOIxYWVs0VrvPC1Yyx2+ucFfnUcUXYlarFiybo1u2vAiZ2Eu2+haaTxtNT3dZCbotx6x2OvklzQQfnGW0Qef488cEt5OeHmmP3G2q7H8BmOgdsWUFKF8QLhXBN4EAh+qCF4lnTtdFHquss1gZAzPuDTs2fvQB8+7MqsNChFN67sFG+rdmzLLcy240YAg9BE5iQjwu+T1wtZrIERvRRRefZI2iWVG1QWiSK7JiWBx8Nqw5fgsJ0//BFFlMKS8cNRfIEvfYd7UJEkmMjrxADWpnkvT8kMm0SumvZ58frtIaMW2ForORvEccWvEG6C/Qsaj3ZQ8vH3mfbBokBpNGI5X6y+F4cFpoxD6K5kesRTnVknFS/V/G7kKmPxGzrOKGTThsmAx7gERPo2hboiDmaHuyL+OTeJPo7V8W7fDLSSXqhHJLjUiuAivcp4nFAwjAGSqRS99ffNUbN6p+MVdArg7y5wuR4JSXN/KeBJoXjs0sSS0gzRUnFPqwaclP8uio4h8KInQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6c779d-1f21-4a77-4047-08ddb962f4f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 12:21:22.4233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pLlRMp4kXRn/64/tOJgtS8IA7mdcdS9LqbUPE4WWM6+/kZW3ODFXGcB+67qmhCPYuuqfSPef1lwu7rv1GAdOeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8693
X-Proofpoint-GUID: PfYbmdhfdxIKNZ_8mnhZKJfd8FX-qILU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDEwMCBTYWx0ZWRfX47qkPjuY2EZZ
 Da4xmiNU5bI1nuaqjh7kEShiW5pOTKjRdf3BFtmrEpkj9YyVcVzyNNwbJmM4CrRGUNIvmqJ7y/O
 4nHhnE85XI4VlMQPQ5c5JUEojXxDmTrLSIjQRJeRt0M1ugTb4ENInV2xmPkv0jdWBAZns27zkUg
 5Ti+HEIUnZvNria6fdvvgf2dhlCrM6pKBpT1iTDgFNCSgFsJkOYqhx4n5eNDVJ3VWtycTcPrGBR
 YQUpLBtl85/+96V8u4vrf8SSgFKuoN/FOkJ38lRXYlKn/PCCLaoUjDpgYxmNkLjOtFt10+/CjYi
 j/yu9ySq8SgIEbhvl6e9HlOPN9lO00RSW28DIijzEDjsJXQYqy/9wZtSoVAps7QloDL/XX95cqT
 35J6jfe7gDWGkqiFVY/GynVY4cVkMn1qLnohYZ5QotsuoVhBjdWUAPf5vP0FLjmjWjpLGJ3g
X-Proofpoint-ORIG-GUID: PfYbmdhfdxIKNZ_8mnhZKJfd8FX-qILU
X-Authority-Analysis: v=2.4 cv=FKIbx/os c=1 sm=1 tr=0 ts=6865244d cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Wb1JkmetP80A:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8
 a=1nkadCgX71emagpZ3AIA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=764 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000 definitions=main-2507020100

For UTMI+ PHY, according to programming guide, first should be set
PMUACTV bit then STOPPCLK bit. Otherwise, when the device issues
Remote Wakeup, then host notices disconnect instead.
For ULPI PHY, above mentioned bits must be set in reversed order:
STOPPCLK then PMUACTV.

Fixes: 4483ef3c1685 ("usb: dwc2: Add hibernation updates for ULPI PHY")
Cc: stable@vger.kernel.org
Signed-off-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
---
Changes in v6:
 - Rabased on usb-next branch over commit 7481a97c5f49
Changes in v5:
 - Rebased on top of Linux 6.16-rc2
Changes in v4:
 - Rebased on top of Linux 6.15-rc6
Changes in v3:
 - Rebased on top of Linux 6.15-rc4
Changes in v2:
 - Added Cc: stable@vger.kernel.org

 drivers/usb/dwc2/gadget.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index d5b622f78cf3..0637bfbc054e 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -5389,20 +5389,34 @@ int dwc2_gadget_enter_hibernation(struct dwc2_hsotg=
 *hsotg)
        if (gusbcfg & GUSBCFG_ULPI_UTMI_SEL) {
                /* ULPI interface */
                gpwrdn |=3D GPWRDN_ULPI_LATCH_EN_DURING_HIB_ENTRY;
-       }
-       dwc2_writel(hsotg, gpwrdn, GPWRDN);
-       udelay(10);
+               dwc2_writel(hsotg, gpwrdn, GPWRDN);
+               udelay(10);

-       /* Suspend the Phy Clock */
-       pcgcctl =3D dwc2_readl(hsotg, PCGCTL);
-       pcgcctl |=3D PCGCTL_STOPPCLK;
-       dwc2_writel(hsotg, pcgcctl, PCGCTL);
-       udelay(10);
+               /* Suspend the Phy Clock */
+               pcgcctl =3D dwc2_readl(hsotg, PCGCTL);
+               pcgcctl |=3D PCGCTL_STOPPCLK;
+               dwc2_writel(hsotg, pcgcctl, PCGCTL);
+               udelay(10);

-       gpwrdn =3D dwc2_readl(hsotg, GPWRDN);
-       gpwrdn |=3D GPWRDN_PMUACTV;
-       dwc2_writel(hsotg, gpwrdn, GPWRDN);
-       udelay(10);
+               gpwrdn =3D dwc2_readl(hsotg, GPWRDN);
+               gpwrdn |=3D GPWRDN_PMUACTV;
+               dwc2_writel(hsotg, gpwrdn, GPWRDN);
+               udelay(10);
+       } else {
+               /* UTMI+ Interface */
+               dwc2_writel(hsotg, gpwrdn, GPWRDN);
+               udelay(10);
+
+               gpwrdn =3D dwc2_readl(hsotg, GPWRDN);
+               gpwrdn |=3D GPWRDN_PMUACTV;
+               dwc2_writel(hsotg, gpwrdn, GPWRDN);
+               udelay(10);
+
+               pcgcctl =3D dwc2_readl(hsotg, PCGCTL);
+               pcgcctl |=3D PCGCTL_STOPPCLK;
+               dwc2_writel(hsotg, pcgcctl, PCGCTL);
+               udelay(10);
+       }

        /* Set flag to indicate that we are in hibernation */
        hsotg->hibernated =3D 1;

base-commit: 7481a97c5f49f10c7490bb990d0e863f23b9bb71
--
2.41.0

