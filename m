Return-Path: <stable+bounces-40132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBA88A8F3F
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 01:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FCFAB224C9
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 23:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C3285945;
	Wed, 17 Apr 2024 23:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WicAbXrD";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ON6e1zqd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="G0GAQaHW"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A73C85922;
	Wed, 17 Apr 2024 23:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713395679; cv=fail; b=O/eFnNkCT+3LA/pn8kfSYNrLCkGz+Nq3mXvRFOc4Vhd/X4x2cHLbZN19lbAODrqc/PcBcWwJs2VYiDybP31NKGR8TSL+XFZspgieXDdWNWgmm2dsDPUDx8liDBH+Wnf2RrFv0d1IHpuTm8eq3Mq0CNPsBedfEFgVXE7X6JGVo6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713395679; c=relaxed/simple;
	bh=aBuarkfy7cqo/moi7sdMlkc5uGKWhN+6l0fGbpzpIyo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hmHzquPI5wtpa6UNa5alW9dNdQGpA3f7YXW7Sx/9+wu8HfhMVGC1cDswk8zGE35lgpTQ/Pg/dYJiKx9uTLibDuvJxFQBQoWVaivHVrawnJ6TGR/nvyvfBZZ0o2SflocLHejjKNNAS960WrwQQ8pqTtzswqK1pjGlrTLivZJznIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=WicAbXrD; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ON6e1zqd; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=G0GAQaHW reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43HMZsBH008269;
	Wed, 17 Apr 2024 16:14:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	pfptdkimsnps; bh=kjQ8Sspdtb/qGrv7Ygh1gy9d/8T5dCRlzIHHRjtsDxg=; b=
	WicAbXrDhIbgTqEA5jaDL8DQx9s8sdIjzW7h399ont7KzvS3hBeoOszTT2rE39ZE
	tzvlLlzHVaI1esOl9hQR/t2yF77OXC0TtTf/QdZanqWHGSMEgzDtr8tXUJ7TzXQC
	mgn71MNeEsVes9rupRsg4BA9RjlDAcB8VDjrSs74oGAsRo/SWYuGzh1WYpzDP1NH
	LAzSWvLwF0x+sTPlPcUIA90NIAWGTrj5VpvZjiApjbnNJEYtWAsqXrfJUJjTD0XS
	XzUqNHNOvwVdJK3eMoJ54aAhl+762bbx+ha5/zRN8JHEIOV8+RR0y8AZkAvYv0YX
	tXF7XdabDGxEU3RsHY4fOw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3xjgkta7ww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 16:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1713395674; bh=aBuarkfy7cqo/moi7sdMlkc5uGKWhN+6l0fGbpzpIyo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=ON6e1zqdeBTqLeSoel2Pi/OT+3UaoqliTl511agj4EHbtpJQ9ql2JhcduSAihBwHP
	 ueiqgDfCVUkToYPu6E3CHgyUAZvdosZCBgAvU2Krpk6nDpVnzZx1/Zw19LrJXFytq+
	 8WS8Ueb4jPnIiyDpLP408THZzf3Cr2VtXY5xYvI1nF0scFpF6HsogOp3AxbqHTQ4bt
	 WYaOVKmjdZwXPYahYvA4gjpOhNUl3HlyV0mZzVXQDk8BErgBf/x9Q7Tj6N7Gze9Beb
	 2hxOwSgwRTAJZjKmut/bIFh3P5hQNfUnxMXZT+qlqkc0Etj7lgGTZSo5whtQu2t+88
	 HFW7mBtm1DP2A==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 302B8401C6;
	Wed, 17 Apr 2024 23:14:34 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 097F6A006D;
	Wed, 17 Apr 2024 23:14:34 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=G0GAQaHW;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 83C3A40349;
	Wed, 17 Apr 2024 23:14:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDktLvspqLu/evo2Q7m6YyyQWrrtvzQPvor0VyiRmO8vMSmviTSTi/0WMby3Y/8GJA4fMzyzswxS7KhTgMFkgYQTnZggvF/Dd83VsqBr8lwXyxB0ISohcIMY6+2pwh09ogVsTDt7d043ziJNlhv49KWlqta8bmqIqmfjDVnPFIpQEPrEEJjWNck9a16odjTtz8GFYbnj+e+7zXsMjG6DCZgyAGWB/CzAMSDOqV8bZjMxLmSvJtAw1ojNXz3sUFL5nFIaJ/wIP24GyQyUvqHrZLPoUoP2sX+vrtQSPRD39C9BZDxsfk3yV1Krna3iBF4tkKLXZIpW4eAf+i79kQntQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjQ8Sspdtb/qGrv7Ygh1gy9d/8T5dCRlzIHHRjtsDxg=;
 b=Osse6hojZLbayO9dob36GwORO+Wjo8hDSxUQbZzOyopphGFHGTIDyULFYzplgirZvx1IQA6LVjbB8NDw3OAKQQaj0opdnj+J2e64aIhG7oKJq8gjdulS2c19eea+JxbLiB+K9kWpiEj2zCxFczKPjZNoXAN4l65zEP7OFmIF57hPWilvpAPBNS28bSGMr87zWXHH4wAvTdVnbrHgnvx8lZ1+/F4iyble5M/v4DkbZb8020rNXqPfLJsdJfzVk3Dem/uiI1dz/juKTFPTWEFuy5C3pVr5mFqzj6oHSHd+vbpGzvFYBcg6jF+QTiXa5qRtCUeEB4Hh1JewxQ/JMcTs8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjQ8Sspdtb/qGrv7Ygh1gy9d/8T5dCRlzIHHRjtsDxg=;
 b=G0GAQaHWw6ZjyYNvWFo8Gerhh6ZqzwQfjvcHsQvGVRYvliofh/HP28sq4dKqPCpEyW2pg8eUPPLuBUvxmMZfR10sgP73Wlet/QGOOdS44bTeOH9hhiUyM50KsGC62ApnYk4LyLECzW1b4EuosC1ED6HL//jq6w4RkXlzctLMAIs=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DS0PR12MB8320.namprd12.prod.outlook.com (2603:10b6:8:f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 23:14:30 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d%7]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 23:14:30 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@intel.com>
CC: John Youn <John.Youn@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v2 1/2] usb: xhci-plat: Don't include xhci.h
Thread-Topic: [PATCH v2 1/2] usb: xhci-plat: Don't include xhci.h
Thread-Index: AQHakR0A/ht2WvByOUCLbChYqR7Edg==
Date: Wed, 17 Apr 2024 23:14:30 +0000
Message-ID: 
 <310acfa01c957a10d9feaca3f7206269866ba2eb.1713394973.git.Thinh.Nguyen@synopsys.com>
References: <cover.1713394973.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1713394973.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DS0PR12MB8320:EE_
x-ms-office365-filtering-correlation-id: 9512330a-d251-4c5a-093f-08dc5f3422e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 lgohOsa0XY66eqBnQrj3C4pkLBISZNUhm+qDP7OMNnTWS3EBXfhlr1Y87jodaBMabZ13BspBFoENu5pCVFm7uPif0OYp/4ghK361BnsXJEJRRFTRk1MQ9VhMro9EujHmx2G//qee8kF3C1KlTHqDGC8D/ErbWyV+xMcv8VsgH8IKPtjTgH1bo+cOLqSOPymdoVBzn6mEJpk/PjBFW8bCQWikcIrqdBU2+oAhCRFaLLQrzjbSoFCYAyOqOlNRz0pSQGpCKfXWYkdVrRiGcPHMJgmoNij6DGFtLkHFxNP76lk5+ka1nEobniMmgEH6ZofTSsYOZP/muVytCfCxf4N2MLBUGXcz5PIIazN7XqIMAmEo6kfYuUGvp1h8TTMz7p08+kZS0hFGTlD+TSX8UR3gJV9jr5wkljRtwc4UGi7hzi5ygKtikj3QGzqSy0nb0sQpuouXGqTCzwNiOavjFBN+pqzACR5R4196Ih4i3cTKoqsoX0cHSvF8l90ktFMH1dP1TFtobbYnX07nGhlzgmVsPTFv5/mDEEjyHaND2FNT8iQp/vxPGxVTKf/erf4rNPsxy8tutFHIjSlD3HKiMh4+8Y3MZI2JL0JYSgIDOxZTd4vu6owGKwsr7Ch8jXHvO+XD4oTNJOjHtAEQhULE0iMITep6nO6mNoLUSIwgvgI2IbPkYZ4aYe9TAZsxQqPf/tJUGFrX14KydJHbstsbPkir4siuJT3OIS73AE94Jw7O468=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?5piF6Y94k97ORrJolItyqJ3SbWrlDDg9VL2tX7DD+inoh2brgSRodV9SV+?=
 =?iso-8859-1?Q?j8etIkmUuRAUYr2Qse25lr9w66mJbGPHM42B6URczWXPsmEUHVURqWQnRt?=
 =?iso-8859-1?Q?LuOEZRXmQjJnIOhzX3R8tsCS0kSlL1sSE7iwc7b7DgH/Iyifd/V6sSEUf+?=
 =?iso-8859-1?Q?79SGUgssE1diF+67m7/+LtwA2dlOoyJx88HG+XhoxoBFzu0kK+NvrCdL4m?=
 =?iso-8859-1?Q?ZQQrMu3to/E7+v+LDcspG8ept8dJZr0mqIUTRXyTtI+b7leToA8lFK4F/x?=
 =?iso-8859-1?Q?15gZ3/TYt0vhH9fY84ceEAS+zpD2MhID7zVK0sVbgVQXjVQoEpXstAFD4U?=
 =?iso-8859-1?Q?jf0oib/SsBgGkhamMgeT+QoORipOWeMAZffpMvZLu9/0EMgy6n+gn5wy1F?=
 =?iso-8859-1?Q?aJZm3qsmE0PE41yBa3tKyByEtOrqimDRvKkSTAEAHa4oXg2QoqIuPA2n0o?=
 =?iso-8859-1?Q?8XmPwDeymB9tquK9338LbXd6UiQOQMoyfwgkBbAFFS70lNblyUJj/yBDpm?=
 =?iso-8859-1?Q?cXwXWavDssUmVWKzuOsUdKDWbAf+VZrD6CpkyubdgqSd9b6WEnl9AoxbUT?=
 =?iso-8859-1?Q?g8wk8x6LSzx1oMvAdvfhsAwMjt0O4eEh/akG+6rB4UpA0A6GN2zMwW+GgE?=
 =?iso-8859-1?Q?DEJsnpyWFlOMj+c+4PPklQSndNt5TlBuzLQTN/5lyvxvrRP6gXvkFiNp4F?=
 =?iso-8859-1?Q?mYkDhLp2iw/hm+RlNvR/7McYyjqoQwmcw1VAHuPX1+mfWnmdt0/o6KSr+o?=
 =?iso-8859-1?Q?KW/gb6bcEeQArc2tAgur6BrfiXmHOdYR/6afCFIxOlUqamrvxDN0JdtGMU?=
 =?iso-8859-1?Q?+ye3oWarheoeToVrARjty+4VBNxuzuECeK82662YD1PYQKIjEMVOPx6hcS?=
 =?iso-8859-1?Q?nPy5qb1IHaJKS1yiLJucPgwNjDbWXXJ92qEKVxhiIGld0s8KE8XbkK03/3?=
 =?iso-8859-1?Q?TPTp9Wf494j3X0Js7efAWs/25zJ5D2Vh2AK08gKIK3v2WXQ9lFOEpj1EOZ?=
 =?iso-8859-1?Q?+oZ+U9E841chO4KNJTO7trZyxdu5NFl8Ab6Ybt1B3rrWoMBXclQmoMBGYE?=
 =?iso-8859-1?Q?Y4LlZ4Ik/FGqKoBzZD9X1nwScBM+bBvao1+4WZhjY0F0eu+K+3KkNNGI98?=
 =?iso-8859-1?Q?+3Go5tmucOZokF9mmtaVgMcLrgAhuS+PtzWN1vv4N+Ljg1XPa7jRaK6XsV?=
 =?iso-8859-1?Q?UYesy0IKnfHwIJtcPshhLWU8ALPnJiXZBPma3Isv7ivvWOenPgY4Q9b4WK?=
 =?iso-8859-1?Q?hCUNjTHp+w+hGezVTjvVfyKpTLV03VC8NaIixD33YkU8V28gBaekvM0gdA?=
 =?iso-8859-1?Q?VDiEk/8nhWfDfM5T0Yo/hG1P/SIJmenQ2GFH+2qMWKigASSpnwm91g1bR9?=
 =?iso-8859-1?Q?X0TOHMGa/OV2qJL131ZXmXspPCfHosctQWIgszfaDvKG9aUjOXhJFIJGvU?=
 =?iso-8859-1?Q?ycXL4QLwI0QgT+AWyEuifuXYkxGpedAkCOfkDScQUTDkDmrlDrebCIKAqK?=
 =?iso-8859-1?Q?H7sR9pkC+bjVorXEThOSPO5B9XYfJUg/f4zJpZ24owpe1TqADMLEoSDJMv?=
 =?iso-8859-1?Q?7hXESeretD1Iw1ejnnRQ3xzsYC7Dj19F9NPj0acAcfC+NGgxDH7idGG9yV?=
 =?iso-8859-1?Q?i3M1z3PTty8TFDtWMSq7D5jg1IQQoLdCJ7?=
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
	V6SbsqNUW5MCqnRYU7WyvvJqBn9CP1B/dSfgoo54p9Vii2eJufjMjdOMtcnFAHS4tXwYZNVIFeZeu9oscgEPPXAxA8cahpRg4trBZv9LPb8figSkNsxhlwlGpbgSmINeB1zqt/xoQM6TgIG8jn4GMgATyn60kePE/RWFK10IQt3bn4iNXXm8AiVn2+n9pH7dcA/3UD0+4zuAPu/s65sZ6WU6mbCLp2KrXU7sPZ1tO/4lBGQLOih89lOaFUa6/ueuEyAgY1Z2SOVO7dq6C0UVeHOMeqD5XBnkaHQ+i6VQi6SBaja7syaSWB4WlWxFX8IDJgQV5DbHGELmV+G8IJ7+GDGRuHitagnBkMJmTveOFTu0Au/h0D+aSXVMcwCZ5NiLtr2HCNbdGOifDUoauatPRjPQZ8oEBi9hvWv6ADSo1yo+VK/7reegNiTdnaLMyVvSmjk5xeWifhKNPkP55fbMhN4+sWlG2lkU3fTNt5V0dh3IwcoZd8M8WVDHYJxuJh+BPOzHCDfqCyHCM/KsdkaYxZeMWftfxKGq6VDSmvWFt/GXix9V1pW9HV5zY/ctg9EXL8antN96dPERG/8g7kU2VzOdaG7GO5Dc9sRerHiuhcaSGI9bvsYt7k3vVbWT3Fc8SeDN9xPkUfUA48LCvAuqCg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9512330a-d251-4c5a-093f-08dc5f3422e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 23:14:30.7943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aPyYNOdSKD6d/YtZ4A6+1fGoCUYwlSG784yycBpHqhodLBuuoCi2KDspIcrk93/C35FR57dPdxqycc2oi6A3gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8320
X-Proofpoint-ORIG-GUID: A1u00_6Mw-tZV2aemjT5WngXm-30-pT_
X-Proofpoint-GUID: A1u00_6Mw-tZV2aemjT5WngXm-30-pT_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_18,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404170165

The xhci_plat.h should not need to include the entire xhci.h header.
This can cause redefinition in dwc3 if it selectively includes some xHCI
definitions. This is a prerequisite change for a fix to disable suspend
during initialization for dwc3.

Cc: stable@vger.kernel.org
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 Changes in v2:
 - Fix xhci-rzv2m build issue

 drivers/usb/host/xhci-plat.h  | 4 +++-
 drivers/usb/host/xhci-rzv2m.c | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-plat.h b/drivers/usb/host/xhci-plat.h
index 2d15386f2c50..6475130eac4b 100644
--- a/drivers/usb/host/xhci-plat.h
+++ b/drivers/usb/host/xhci-plat.h
@@ -8,7 +8,9 @@
 #ifndef _XHCI_PLAT_H
 #define _XHCI_PLAT_H
=20
-#include "xhci.h"	/* for hcd_to_xhci() */
+struct device;
+struct platform_device;
+struct usb_hcd;
=20
 struct xhci_plat_priv {
 	const char *firmware_name;
diff --git a/drivers/usb/host/xhci-rzv2m.c b/drivers/usb/host/xhci-rzv2m.c
index ec65b24eafa8..4f59867d7117 100644
--- a/drivers/usb/host/xhci-rzv2m.c
+++ b/drivers/usb/host/xhci-rzv2m.c
@@ -6,6 +6,7 @@
  */
=20
 #include <linux/usb/rzv2m_usb3drd.h>
+#include "xhci.h"
 #include "xhci-plat.h"
 #include "xhci-rzv2m.h"
=20
--=20
2.28.0

