Return-Path: <stable+bounces-8349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D6781CFAB
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 23:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED7F286344
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 22:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB472F535;
	Fri, 22 Dec 2023 22:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZAHuTlie";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="iWiNwJyF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="HyWeJPaw"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC1F2EB07;
	Fri, 22 Dec 2023 22:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BMK4lU7024491;
	Fri, 22 Dec 2023 14:11:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	pfptdkimsnps; bh=S+28CK3vbeUDV0pm65PMqk6+OAxsQ/le4cHPrGFUngg=; b=
	ZAHuTlieZRlFSBAx0A6hjaay5RETvzAQqvqvU2KcC0OUPSfhyHygnGaFEr4WK0Ds
	4UJQ/yy4To2TkBE2OkJDwgDO9UAEj0E+NrlYV+StZRRDG4uG/YDexx0WdW4ORpg9
	sSRaBUR9rck7KEY7Tg1l+lwpCLQ2wDLdwFfW8+C+sO9BeFhijxvGdDmNopfFDoKo
	iAZlm9ec+4TrLYL1GHfXkhZ7dCNFiGESwL4mBTj7S8lMLodh4kE4A1igeZ+BG3tI
	O3M8+Hk7TqkFrbNnaPaOrqbLnckiTCiXy6C2swqnvcigqwhkiNtLVrFIskRw+SYt
	NyHcpDi79J803/kuHV5vpA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3v5gpwgdw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 14:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1703283098; bh=a6UYVAxdmtxIh98LfvpW/viRFcu3qLNKdsnXFbFe4SU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=iWiNwJyFEbEVvbBZkF/P6sIjnTaW46USGphytIEYnfC+h/+n+LSoVkym0GY/J1YOv
	 N/V9UjFd5MhKro+ozUmP7KNymkuPPzAj1EIk1p12WT4xPd50Vd1A86eJbqc5zjmj6L
	 +/1DDtDpAbtUu4Rh2XA37UyBoRB45rZQVBo/4O8p4WhqP8AdYcKTpWoKIagH8jaYid
	 9RdcTEtENVJuatij/L6WXifSKyXo3WOG5bB+wYC4bIYjjqA0hoeRO/1CM0T60bEurY
	 miJx8QS6jzrBQcFWY1PFWZWnJln+Ulj03seeEZVOh/QZKadfFIAIgsafEmKDASL6rp
	 jl6YLjbrLxXWw==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1039140540;
	Fri, 22 Dec 2023 22:11:38 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id AF806A008C;
	Fri, 22 Dec 2023 22:11:37 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=HyWeJPaw;
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 9FFC940130;
	Fri, 22 Dec 2023 22:11:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdbw7xYClAamUP+cuPRYGJvlxiF+1AzJS1MX6A1/iu/ywxYrv2hNIgRdnrhbBn9vSNNqGkuPSjEgw9IUy5Lx+h9FAdI+CnsRcZqnS/dTHp3dg6ydFRnN9ZdoIWQ7f+BTc6pS+MRDV+ReQsPAYfrjVqs/22OyeI7+22fKNepmhf6YshJymwgLtsJknsFRfuo3/G0bf1DWAyBt58blqYHmBf/8QAy1fTpnI2qSGKJURTcpW+PcLXNJYZSwsziKrehzfXnJXQiZ3OBE0NuQ6TDkEZE9QtM8VBDF6BeA5sU57hO+VpyRZeFsT67rqnEchC7O7Huskb69n6qeCKiBkdr8jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+28CK3vbeUDV0pm65PMqk6+OAxsQ/le4cHPrGFUngg=;
 b=oXOgEesdoTVt3+Ajob2iAx259DOK0Oa8KvB2hu0sTcMGQiTQoXukbqgHUJH/WiAS2zWMB9FPAo1hrPQGGZGoqiG72dob0yzR5LeC5kGw3XJX5qhdCU9srqN9JJzeSEkoq54F6BN13zjo1PD/+IoUa0hH140xFJkLVgJ0K42SgoyY3/Xff299wBalB7QmB0tYbTR0XsBAo/0JSQiy961AfbvvFbNMwxM4XQb2CL3YlL9KvyIxQZgnM0Cmz8HQDYLKZ2ht3dwYqN7JOggr5UqHtK8GTdmeBbMPOoNUv5U+fC+4rwv2MUHPii3U80LfcTOGiAKjy4RqHpJjlWYdFQ3L8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+28CK3vbeUDV0pm65PMqk6+OAxsQ/le4cHPrGFUngg=;
 b=HyWeJPawi1IqwJqcYctv4yqfJrSS3fPxcSldk6MyB1xfgUtHHG4bwMai5y/fpzeliwh06P0br1rQLHt8D5rpAkQ9IHa+6lV/QpX2OOQHxhOzOIpl9WSGwepM3wraYR8+vxRM4H997X3J5cVPY1wfzPpVc7nalJik3ngre8/QyfY=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DS7PR12MB5982.namprd12.prod.outlook.com (2603:10b6:8:7d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 22:11:33 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::d931:a262:ec3b:3e56]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::d931:a262:ec3b:3e56%4]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 22:11:33 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: John Youn <John.Youn@synopsys.com>,
        =?iso-8859-1?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: [PATCH 2/2] Revert "usb: dwc3: don't reset device side if dwc3 was
 configured as host-only"
Thread-Topic: [PATCH 2/2] Revert "usb: dwc3: don't reset device side if dwc3
 was configured as host-only"
Thread-Index: AQHaNSPS+cGPjMXbgUm0J7Qyb3cXKA==
Date: Fri, 22 Dec 2023 22:11:33 +0000
Message-ID: 
 <7668ab11a48f260820825274976eb41fec7f54d1.1703282469.git.Thinh.Nguyen@synopsys.com>
References: <cover.1703282469.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1703282469.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DS7PR12MB5982:EE_
x-ms-office365-filtering-correlation-id: acbb1203-1070-4a13-d4bb-08dc033af4f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 AnAsCtfyuENwIlYWIaMMCWi9dxW9CdQAaoAnCujnEnprnLundJjuv0E/H8LfZ899gaj/5r0jFMWs06FJhoo5+0SgCnw8t50lJMSrHgN+c32Tq9xDLu51G2nxX/vA+mYnVnpJcChCUn1NBNB4IerAScXletlvhayUlDacSyG1M0RO0ndMYvogGigf9pqlqLQqYS6+D0C1Ods5+GfBdlUQ1dURVePe8M0zzmmEXAqQcDtkpGs744Ri/Ir6VNjGe+oeINmeD/qI+EfcC2NXC7LPwhBt1wl70NOcyGhfRNxNqeW5FzZbpPjYlwzp6wvHsmKeAemSumgxtPlC7XEgyoxc3+63U97nZgQMzpWC8GVMBczY5dTcEw9Mm90+c21hSxO9IRzSs2m1YeKfKFLQNUsx72B7XWEtVQJrtQgqVEc7vc9l5vs+vyYtGIOyjs8KJPIuUOqTV3KJ/9WlIG2ezox7ApmWXqd/GEA0ds8W+5aRsqqA8TqN/RNBxkWFanuEQMCMbCyE8ItrwYFo8U1WfKX5yUnT15kyfkhlDUJNDiQG+bg5plERiVefz6e6zZhFANo9N+rkDUXEmps8/4pKZBF+dhO4J2hS2031PtguHYrkzaLqRTWcCMZ18wKpmRqvm0Uw
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(366004)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(86362001)(2906002)(5660300002)(4326008)(8936002)(54906003)(8676002)(41300700001)(38070700009)(83380400001)(26005)(2616005)(36756003)(122000001)(71200400001)(6486002)(38100700002)(316002)(76116006)(66556008)(66946007)(66476007)(110136005)(66446008)(64756008)(6506007)(6512007)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?utGOnKFVjNUELHH9RHUK96OSO3n0ZmO0SPiEt24Am0agwPVZNWs/ovz6YI?=
 =?iso-8859-1?Q?cXxL57MCEAyq4IwZLk1YHw+udExOBfz9pyycZNdWwuKg2a8w33Glx9o6W0?=
 =?iso-8859-1?Q?zKwi6tx4kBXgHuh84BVYoqWzk53pgVOMPV6UOzoroAkBa6W8Q/jdnCmzHQ?=
 =?iso-8859-1?Q?aHCOWo6jW7wA209BHpdnvtud0W15K4x5+gDHRG4UBpB4tJ3czYxxBdh3Tf?=
 =?iso-8859-1?Q?Z8WL825P9S3D7Z2qhLGBAOlU3DxANOB5hcOY1eAS+mVKCPnC/t+otNuw6l?=
 =?iso-8859-1?Q?s9cCIzqrEPDGxY2ENF2x+Wgd2zX/Uh8aXSHcadSyCKXEKc6eyUyJocbNn4?=
 =?iso-8859-1?Q?IkhbFo9yzYOVMLHFp7eMJmdKhoqS0ENXwM2B0vN0wz5QF9jSlyB3Rw7opJ?=
 =?iso-8859-1?Q?y7UDtue7+YZZPEpe9Wd3RFB9QGHUBoMANmNlDenG14DQjj44YOzaOu1ovW?=
 =?iso-8859-1?Q?n0/yZu3turRgaY0/MxWPA2Wu8MQs7mkQC+ACR4va/cmgDdRX8/BZKMnhtn?=
 =?iso-8859-1?Q?rk2zArrq6CkC0xKvvxPRZkyPXT+RrNCShsuPQLhuo4N/JW5SPAOfnQrYya?=
 =?iso-8859-1?Q?moNGd8HIWauvVxnDDTBkR97JrjKfA7CnWA1kt+MP2TElejY0sfhV17jduE?=
 =?iso-8859-1?Q?fEp1EsnxDsELDIIum7Yuf/2EhfaYnJryoX/3OzcceJNbb+2RcVwA+NWNJz?=
 =?iso-8859-1?Q?07yJ90DV9VwqOYFQDCjVgxnKP1zfTLXKH5szFXSx3dpkhJ2RMpRgV/rZ7f?=
 =?iso-8859-1?Q?CXPy5viOoX2kLPDpxDXLflvyjA8Nqe6vqhgPwqm62AXjSI/rfe+YqEgpSY?=
 =?iso-8859-1?Q?UgEB2mmqpMzvEcJcD9MR4+td0OcPaXkBO/SWyGD6tfq8STj7TZn8D2MVxc?=
 =?iso-8859-1?Q?0WqFxWQWAna+vcUUCqXdLpSVw+P4vtApF6Sj2lQvBbAoj5UmO3BBezGC/3?=
 =?iso-8859-1?Q?dYMbDinWtgtB1grdvwj13GikU620TZb3sMUMTbHBbu/GWOPcMc96u4uB9e?=
 =?iso-8859-1?Q?joL0H6gOIKrbaSrTuUEXutftg0ALx+uLSLoSfLalpj5oAltwfXe/9X8p27?=
 =?iso-8859-1?Q?k5juakNo1GbljnUYbcLhbjgNghL3T/uDLCw0VmxIiyUvpMyhrm1MjvyyiL?=
 =?iso-8859-1?Q?UvT57PLiLDWa47RHf2nqpzfBb1l5x77rNhm0srBynnpeJgoGQuvoDdcoY1?=
 =?iso-8859-1?Q?20T34sK0pyNb8/ljc+bs4ttnJPsI/oOJfINayy4xBKj+6AxguHylnrnYgh?=
 =?iso-8859-1?Q?PVnddTM/SbNwgACZ7fpujp5d4IxePeqd+EM2+ev6a3n8ow/0vu7hnxPtZe?=
 =?iso-8859-1?Q?9YJl6/rQNaXD0PKmvu1sns3esTwDNhXc23oDFApTwoMDMSPlGT26vJcY+J?=
 =?iso-8859-1?Q?3qb+7gNe/bJbVFUBVpt0B26obiUxI4DDTgXmG3SBaIj/0nCE7yYgohK+oY?=
 =?iso-8859-1?Q?d8ctvxS9mN4GbLfbJ4Bq91xAkrK+W8oldpeHuCpT4v3C4gu30aC9ADPU6/?=
 =?iso-8859-1?Q?QG517tjQXPqWYCHiNtNAiMvympUhsOqHypJ+T1D6lvwVmTDDis3ASoAKrb?=
 =?iso-8859-1?Q?6ygNQtA4PyO5eusiZ/XJt1cq+FJQBcFINpsh2VsSgjgGV1ny5/OhTCmONV?=
 =?iso-8859-1?Q?tReFwjEypJ5Gb/liEapx7MuCBGelrN79Co?=
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
	+j+4it+dY3MI9n5o+ZyAoKclwBZj78FBpiID2ybg3SqI+WDsrlwumuWnTgU6knGNxkP3kJ8DVNYf/1S7INeIrvkCUJVnc0wGLh4lsaWltnY37UhhkfzI3VT3gPEnBJkgOYEq+543j61maZOsaD/f072+SmJQc2+/+TJl48dBzu5VbavGad9ArJ0ykS64bxG1fimBMuPhTvY98xiQFny9uk1bKIrBvzfvPzoL3gIsSfF5CAhSN+jFvbGnxT0arx9oKy8EVjbY6tEK8ZAC9VB3KlWKUr4fmrNfS3Vht3eaiceHOSeMJWDJUV54U3NR8ZR4KgIGxj85tYLapVImTSV6PcGKAYDsxXzxIPskA5QBJhuBBpK+ZQGyXcUQLyrDnyyIxYu8AxzRic9E7w2lgua1xQsG6YjMJBkpaPjAehVXRigi8Wnaji2B4USI1CCuFCQ2izQYnG7zYe6LOtsoLAJb612elGBUxS+2/WfMdYCwPZ1+Salvy93H0sY577lJ14HJT9P8P0Gn9Ix0v7rzbFG9decDh46oDR/Tgd6lwiT5j+VUwbZj92yPGtglDkcwZDXf6O/FKIaDGnvhqDnBSus+poC1VCnKMqmLEuXbeIFhN9oWlMyyfLvX2lLVlGezT932FGtCxtrEOu6lFtWLP7U1pQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acbb1203-1070-4a13-d4bb-08dc033af4f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2023 22:11:33.2246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ihQQ7b53d+LA3m5tle3yDgzGc9QYiZ0YO86qrHrkfz0R5ihbvBTObTtxdxpAsPhzeSryk70zpffmcqnjIlB0Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5982
X-Proofpoint-GUID: l9f6cIRz0VuNwmsYxNmGjT1uRpCvOHSD
X-Proofpoint-ORIG-GUID: l9f6cIRz0VuNwmsYxNmGjT1uRpCvOHSD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 mlxscore=0 mlxlogscore=905
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312220163

This reverts commit e835c0a4e23c38531dcee5ef77e8d1cf462658c7.

Don't omit soft-reset. During initialization, the driver may need to
perform a soft reset to ensure the phy is ready when the controller
updates the GCTL.PRTCAPDIR or other settings by issuing phy soft-reset.
Many platforms often have access to DCTL register for soft-reset despite
being host-only. If there are actual reported issues from the platforms
that don't expose DCTL registers, then we will need to revisit (perhaps
to teach dwc3 to perform xhci's soft-reset USBCMD.HCRST).

Cc: stable@vger.kernel.org
Fixes: e835c0a4e23c ("usb: dwc3: don't reset device side if dwc3 was config=
ured as host-only")
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 drivers/usb/dwc3/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 832c41fec4f7..f50b5575d588 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -277,9 +277,9 @@ int dwc3_core_soft_reset(struct dwc3 *dwc)
 	/*
 	 * We're resetting only the device side because, if we're in host mode,
 	 * XHCI driver will reset the host block. If dwc3 was configured for
-	 * host-only mode or current role is host, then we can return early.
+	 * host-only mode, then we can return early.
 	 */
-	if (dwc->dr_mode =3D=3D USB_DR_MODE_HOST || dwc->current_dr_role =3D=3D D=
WC3_GCTL_PRTCAP_HOST)
+	if (dwc->current_dr_role =3D=3D DWC3_GCTL_PRTCAP_HOST)
 		return 0;
=20
 	reg =3D dwc3_readl(dwc->regs, DWC3_DCTL);
--=20
2.28.0

