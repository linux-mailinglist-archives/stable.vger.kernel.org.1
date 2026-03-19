Return-Path: <stable+bounces-227355-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8N06OOUzvGl3uwIAu9opvQ
	(envelope-from <stable+bounces-227355-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 18:35:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 617F12D0173
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 18:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 127AF306B781
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 17:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC0B3803EA;
	Thu, 19 Mar 2026 17:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="MgKt5lbD"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DCF35F5EB;
	Thu, 19 Mar 2026 17:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773941554; cv=fail; b=bK5icjd8gePnpiGooPPaRQqWjcaZjgelJPvdLT0TzpENDfPB0aRP/nlwSCq5QnfuO1PFZLN+jk7u53k1V1LQRtTFOmy5eh/nOkfg7MVoqg7C5XC6yMPK6Mj070gaGCtrx1rIm24N0vKSYcYPioINHvN6X68T1RcK2crSF0zGoUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773941554; c=relaxed/simple;
	bh=iQnr/wnwpAIFpKdn+L2WhpBr4kj89mHCRRHrvl9iuRA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UZ2hTeXVmpsQJCreDuJOsQBjwZ1ZVGP4L4hyDcDaG8Jz7XQrGVUYNmMkNPeuf/FRNFA5f55FXQOgypbiGTEGWVj5mf8wPExu/jWzrTZWtJUrOpHsgvO5XjRcBCQqoGlgUu6CUpPrUDmPaFWZ5ugPasx0M3+83C6lhp3rVClBlOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=MgKt5lbD; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62JFQDfd1082345;
	Thu, 19 Mar 2026 17:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=Pw
	XuR5as49KkiXmpfbalTBKsNrDuW7l5W8Jilcp4VYw=; b=MgKt5lbDDCeqFh96/q
	BeKbNlTgrFe94DV25Uzgc+QqwBCZc6HDzdti/XZz9o1mUs5RYVVee0NdPLeUKLJg
	/UWhsmj2mjnsa0BMPbtkSbRK6cv6ElbGbX2WkphArFOprMvNTUBElsdEMK9D941h
	ztcrLj+Y8U3mgor2tbZpKfQesfCR15GHDIiltfMSrFWI4N+0iYgjInpq6UlEn7Pj
	SZzrNKR4AZ3tLp3gZ3Gybe1jdfrSEBDQ6AGQNc9KRHgkZiNDqv4zVEMgRaqw8kph
	A1Wu5X1578jCCnxJPB4j3MIq2cLHCVXImo486NVDmj3gQF9GXEQkvCYKyz96nb6m
	9oDQ==
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4d0d0c6kw4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 17:32:05 +0000 (GMT)
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id C9508D1E0;
	Thu, 19 Mar 2026 17:32:04 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 19 Mar 2026 05:31:20 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 19 Mar 2026 05:31:20 -1200
Received: from DM5PR08CU004.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Mar
 2026 05:31:20 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKqj2Z0UuOiR3LPhwm1CtYkHAJIOcj8N3rUjmv5ODMag/nDhOMfm/gBawezr41E+lZn1aD22C5v95+o82SYwmo9AgDER3u9dautkUPdYWCahMZcX3Fn9tzca+WCFNJDqpJd8L1IKojEWnK00WVLVfmuqNMqVupqEa+JiCxuQFdjrwPxmhUsuDmlEhj0xR7hKyxRTTFNY1Y32NVq42+bxyeBROzDDFJ6Cb1P8Dk6MRh5Z+oKmrVHr4LeDSXf6W8NS75xoZrTMBaj2w3n+ivU1pefcB5gGbFzvaYNooZLpVYb2juCLwRlRGyL+sq/BP9iSeJnHWaeg8KnHWNPsC3onGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwXuR5as49KkiXmpfbalTBKsNrDuW7l5W8Jilcp4VYw=;
 b=DcR5ng5k7J77IfA67SmtseNJquUQ04xLpY5QDg+PeM/1eVZrs7ND4Y6mJ0n4houAotpawnFOw2XgGYIiK0Vflla/uQ7k7r9sAswUy/OTUtHv8ghAjlHDv92BSdEVrKhloCECTFNBWOG2yrap0pYjmLGB8iMY9dzaOWn7A5S543IH0D0s7DQr8RpTfWq8TtxN/ntt5utvlYLhU2N701oU+uvDdjknGBAxNltICG1OuG0kuEj1T3eumFXzuqKf3kpbC3x84kjdCG2Ara8J1PTyjayS0y3eszjChWnYlOfGxNoRuwMmXiSlWNavwy9U2tP91lJ+77oEzwI9O3GF09l0Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by LV5PR84MB4049.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:2fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 17:31:19 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9723.019; Thu, 19 Mar 2026
 17:31:19 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "linux@roeck-us.net" <linux@roeck-us.net>
CC: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sanman Pradhan
	<psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v3 1/2] hwmon: (pmbus/ina233) Fix error handling and sign
 extension in shunt voltage read
Thread-Topic: [PATCH v3 1/2] hwmon: (pmbus/ina233) Fix error handling and sign
 extension in shunt voltage read
Thread-Index: AQHct8YyGIr43f5PJUmoqzHiXGlXEw==
Date: Thu, 19 Mar 2026 17:31:19 +0000
Message-ID: <20260319173055.125271-2-sanman.pradhan@hpe.com>
References: <20260319173055.125271-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260319173055.125271-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|LV5PR84MB4049:EE_
x-ms-office365-filtering-correlation-id: 4ae7dd3b-f631-43c6-ace6-08de85dd54ea
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: sQCS6iK0r7tsM7EBDm2NTJMgQ2M3kfNiioltFVb7itHM5WjLmfMMhRYKWwzi9OFp4tnyviXUn/vxBZmmskTX8xIV/tZmaCy1D0FnEp8EAL3woD6Fz/kt2USQOjGXacfE+ZOmZko0Qwa3sZ/PAoEX+EYTTEHBXJxWxSnZNZvW2B8iz/8pvUxOm1OaQShOh7khw3YQPdVkzIdP1cei1tDudGX8vrHcLbejop88Lw0bF/O61GjDfkQDlXb7uYOsepcLgjsov52qvt8o0nAdrbzgBCZHlG24ByFGgb9rydzxFVKCyoJo/fNpMA0Lqxlm+OrxQOA2zk3zs0DioetjGrDTOFhm7QXnTpQkFSeF8HiBmpaQuHIRF0fvswTrEN2SGqXLwYPG4EuH6YPFUEKM4q2+ykAKDQlGAo/PKfqN5cgT5GtiE6XGM9gqAnJoSOqiCOs955+4uHx33sYXAFcYtg/+hCJAfwSJzCBqXFRUvYn1dbnM12ijUyyu5UxoTXoguAIHsYgtJVw5tWFU7fLSxfLax+kKjgmdHhOw0nEjnhWhP0D6B7AmFnv9kLNpl5KVCCotNMZ61KgFX6QKW15b7YQBT0YdThrZH9rzUiSKNSTtmIFqhGA9nVMW+GWWqy8mUUzAlyZZ8WynrfvmxBg+TQiXccg0m/KmfSQUIlH5jwVPX+3knoY/6K0SfYBKwvjPsyp6q62NW5K3H9xzdceAeaBE32WBEBQh12sgkiNIhIyFO4N1jEArojpLg9JnpLBicm2oKEG96pu+YS35+RW1AD6aiA7f1jFBpQ2AYC0bPSB+KPo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7cNMJlSBuc6jKWGrVzPOPLHOelIKkpPVgGeBXFMuxfznimEj6M088miVA8?=
 =?iso-8859-1?Q?rG6COHFzvqQM9YdFk2RZX+8fkJGL+2w36hcvJtXwtKUYkRvbrTQp2dQsKJ?=
 =?iso-8859-1?Q?dUWxQ92gGC7zeXL3K3aMiD+uMtjMsSQTeUQJULNLYZ3rGtVsWg/AhQ+2Vi?=
 =?iso-8859-1?Q?+8s7gMWmDa0NFSMjptVrC418JDnppsMZUue79GGaYkAxYHhzDzbHfLGJpc?=
 =?iso-8859-1?Q?/8zDVbVri9M3b3sRMxWfnNBlC2KnD+liX6KNe9/yu1i0+3WVjGDcSgHU8o?=
 =?iso-8859-1?Q?P5sylse/ri+EISeB9PJbbNFZPxtycK4HaRz1lX5LykQmBhhVGx0jsgUT2c?=
 =?iso-8859-1?Q?OxMzUyVi7C6YEAi7LBHRnMMv4ri+fiakHDDQFOTv6lVZ0lQw5RoNucpzn4?=
 =?iso-8859-1?Q?ULL7IAxfRxI6wkHmBLmQbLOK2zopxiZmxWKqWfB89ydmX1Kp8Jr5Zj4HV1?=
 =?iso-8859-1?Q?y6rnMPAkq9EUZco7QlYhV17D98LEuixCRyi+xcICXeFM4CNCik+kBcB+KS?=
 =?iso-8859-1?Q?FfORqZ7OUwE6FszyvvoEElA0DYggIHSCebR7Y4kOk+Jf3xq99y+cYdycUt?=
 =?iso-8859-1?Q?ESnngMbrKvx1Hpey27ldfA+pWY/5n2pJfFk1OwfCIuqe9Lf033fuRr/loj?=
 =?iso-8859-1?Q?nU9b5+F70NW+XRY1ywn6YEMzrwwNo7TnV3zZtYTqgzxVxuZ0JgifiCpMXB?=
 =?iso-8859-1?Q?U8iGUYxKpE5SyQ36LFrc1unTPpE/2uG/GWDqq+IWro98dN2tAreNSBXFqn?=
 =?iso-8859-1?Q?lgBQZOUOJmEgSZasRvRfcS0aM36WfI6II97TaUeNN4Tvdmr60CXc0bWPgn?=
 =?iso-8859-1?Q?hp+WNwZr6GWalRNhPlxE1iLFb/c51xEb1RihixVNnNFWEJGgfByqrP8mXk?=
 =?iso-8859-1?Q?vo0kd4KbrKozQD3eJKmZAVd3V4UKIGwVH4LQFxorTyfj9NYwlEv8ioj8OA?=
 =?iso-8859-1?Q?Trqu7a0aafh4uP9ybC3SDJ/BCFb73yqdhvXC198krlqVj8PElE/YmADbcq?=
 =?iso-8859-1?Q?FV/+KDOhR8C9uSdXCUflRJ1qNwkuFJnfTv8MhbM4qiBaQ2ZzB350zS2uKF?=
 =?iso-8859-1?Q?vWX3WB6EGLu+VU083wC+Cwzicsy2ABDVKLJddexeO448ofl0TFoiq+gseg?=
 =?iso-8859-1?Q?QGHzMb/odN1EXXtsW7QpJ2Hv0YAGlZ9O+QX4fBwgbKatXuI/6RNPR6cUPU?=
 =?iso-8859-1?Q?P9Dwtz2589fLCj/uYwAQsPYPyRS2WMp8SQBC88E4vXXDOz9xE+mejHQLSA?=
 =?iso-8859-1?Q?byCpVid/S7KuqgImekrm06mr5FvodI0+QiBS7MZL35mer+GnzTe6WI/rZQ?=
 =?iso-8859-1?Q?kYAlLTQLLelRg5mDoHzC9uQ5ajTAM1+urSwmM6+0RmDIxBT+H3h1/J/RZH?=
 =?iso-8859-1?Q?4T+TT8Vkf6h1uHNMDe03dGqnlVshc8prTcUo7LAyXBDhaJZ4RTJlumYC2U?=
 =?iso-8859-1?Q?UAQbydTxhR7cZB4NJgfFFUclYaD/dRHYan/cSnU3fAhFNDPrVfnOuRG3cO?=
 =?iso-8859-1?Q?TCbrdbgzdP4lr6hW45Q/7sY5mT1FjlKY6C6eS4td8QfakrTyBFneKFEpwN?=
 =?iso-8859-1?Q?zFlVKu6ZVMkEV6cJEPv6W3tvvs990u8CIBPGzNV1lDGdXSWTk+3wQj3Ve4?=
 =?iso-8859-1?Q?wUqIfwOAzt+AyqvdTl8BZYJmBF9PIWsyRKsrqhJ3PEtttYVW+gxaqnPvoy?=
 =?iso-8859-1?Q?bOdHZph+rTn94cWSNWsk4Mf4gsCdXcPQZAWl39b8uxNK2UfsLK/zimp6sX?=
 =?iso-8859-1?Q?L1oKiVixeBcVGdZygWVrCckLAZECe6oV+vZkPQtcPcC2Mt?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bPlZoFubRhgYsf7adWzreg6a55fRL0w4JVGVDBpgF6drqxsv7UA6SlrkjCaR7R0LlbEvK1Pp6qXLWYtqO3heibo9lqxlnnsW95jMshC/79FKC+9DaiSWWXwjJrRwePhbqmjIWqnZ+QzT6VwNbG4qeaeI7zL9Hf3vFocwLe/mogZfbgFjFG1j+tTtdecEAtcbs7AUEOt0uzd8UucG8KtqzeStcb5yH2t5+BzQ0KirCuYGyDrgG1p6fRUODpK6uF4GlY8PM6hS/Fia6QMeefg8DeOgvIDrQSQc7YXNyq4qyg7o6RwcANwI8oI2flJY+QM7WRB9KJbVBedVcaPWWkQExQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae7dd3b-f631-43c6-ace6-08de85dd54ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 17:31:19.2036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nUjCD5oDoLvxCGudFeX/tCe1WWW6Rf3WXF6dvgz3dyfa4dT+9WO/HrV2Q22dsS29I66/eoCq7iCGuRdPkC+6Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR84MB4049
X-OriginatorOrg: hpe.com
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDE0MCBTYWx0ZWRfX39XUheASio1Q
 b3vwnH3fRIaUEKb/t9gIcnBWmPVCEi9eOSwD98UQxIvzZ/LKcKrjr433xFU7J0TqTtn5J9U+PfE
 VZCJYv/6wCJAREfQi+d9LqGnBUEglarBzms1diCvchReCORp0wbk4CrLKA+b1fis/2yRDOPqNsS
 PRTju4Lpiyqmixz4uJzZ3HI8OKI2p7iK5Mh0e7wuMYB+j0Xi3tDEBSJpJKicY0aARB7PjrVNtSB
 zNqeexTkiTtVTyv+XmF+pk5lLOeRfvbR6dP0GOONY+eucEAt6MfOWImz8qX/zcBagFb5GZQ8ikY
 g/q2wicWbQoCzWQSb31ARUkXIU9UwsQdnYwpq6m5I7Y2NlggHnhngsBxAp+neurAUImag1rHiXE
 TjKAYC1mxIJC6W+vi65Wn1LDQeuejWbk2GF489mNc1zmjYpNO4QAXDhmC4YOWftfH4cG4ZAY97q
 1DAvB1c4uB7mW+Vm/6w==
X-Proofpoint-GUID: xTLWG95_FGzmBhNBvIUaNBIQpaGVp_Ky
X-Proofpoint-ORIG-GUID: xTLWG95_FGzmBhNBvIUaNBIQpaGVp_Ky
X-Authority-Analysis: v=2.4 cv=L9UQguT8 c=1 sm=1 tr=0 ts=69bc3315 cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=ModqzXLkJJ0tFyq98apW:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=mpKQPwVXuAJAzSNZGwEA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190140
X-Spamd-Result: default: False [0.84 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227355-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[juniper.net:email,hpe.com:dkim,hpe.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hpe.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 617F12D0173
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
ina233_read_word_data() reads MFR_READ_VSHUNT via pmbus_read_word_data()=0A=
but has two issues:=0A=
=0A=
1. The return value is not checked for errors before being used in=0A=
   arithmetic. A negative error code from a failed I2C transaction is=0A=
   passed directly to DIV_ROUND_CLOSEST(), producing garbage data.=0A=
=0A=
2. MFR_READ_VSHUNT is a 16-bit two's complement value. Negative shunt=0A=
   voltages (values with bit 15 set) are treated as large positive=0A=
   values since pmbus_read_word_data() returns them zero-extended in an=0A=
   int. This leads to incorrect scaling in the VIN coefficient=0A=
   conversion.=0A=
=0A=
Fix both issues by adding an error check, casting to s16 for proper=0A=
sign extension, and clamping the result to a valid non-negative range.=0A=
The clamp is necessary because read_word_data callbacks must return=0A=
non-negative values on success (negative values indicate errors to the=0A=
pmbus core).=0A=
=0A=
Fixes: b64b6cb163f16 ("hwmon: Add driver for TI INA233 Current and Power Mo=
nitor")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
 drivers/hwmon/pmbus/ina233.c | 5 ++++-=0A=
 1 file changed, 4 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/hwmon/pmbus/ina233.c b/drivers/hwmon/pmbus/ina233.c=0A=
index dde1e16783943..1f7170372f243 100644=0A=
--- a/drivers/hwmon/pmbus/ina233.c=0A=
+++ b/drivers/hwmon/pmbus/ina233.c=0A=
@@ -67,10 +67,13 @@ static int ina233_read_word_data(struct i2c_client *cli=
ent, int page,=0A=
 	switch (reg) {=0A=
 	case PMBUS_VIRT_READ_VMON:=0A=
 		ret =3D pmbus_read_word_data(client, 0, 0xff, MFR_READ_VSHUNT);=0A=
+		if (ret < 0)=0A=
+			return ret;=0A=
 =0A=
 		/* Adjust returned value to match VIN coefficients */=0A=
 		/* VIN: 1.25 mV VSHUNT: 2.5 uV LSB */=0A=
-		ret =3D DIV_ROUND_CLOSEST(ret * 25, 12500);=0A=
+		ret =3D clamp_val(DIV_ROUND_CLOSEST((s16)ret * 25, 12500),=0A=
+				0, 0x7FFF);=0A=
 		break;=0A=
 	default:=0A=
 		ret =3D -ENODATA;=0A=
-- =0A=
2.34.1=

