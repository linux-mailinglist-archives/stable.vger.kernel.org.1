Return-Path: <stable+bounces-6784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 104908140EA
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 05:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8141B1F22A9F
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 04:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7E65697;
	Fri, 15 Dec 2023 04:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="r4iEgMMq"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEFE53BA
	for <stable@vger.kernel.org>; Fri, 15 Dec 2023 04:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BF3qb9X003707;
	Fri, 15 Dec 2023 04:18:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=PPS06212021; bh=KLIj2+eI6sPz7RRX+lA
	SPbiby9CD97QLMtUVfGDvWVc=; b=r4iEgMMqhEvtaRdOXEvpPw+D/CJwQwW7biE
	juLN3QfNAeoIwdm+nFk/L/HJfpCBCvCdzKYFprdRV6yRGMxnYrC1RCHbxIJejO/g
	AJwMynHcxKmoz+I1BPea0lSiHuQ00l2diqAOt+V5ohyM/5oDdBJ8fONALM9ROQOA
	hTPx2xR8tmtlQYWPtIOoJt0iwVqVS9QQ4l06Ve7swqwdcQgjAcH/VA4lQ1YGWXpv
	GInSNJP2Qrl82BAmGUeZWtWZaUcrLRG7/DqkC+ViwVUjSebXcNRhi3fovY3IRASZ
	YySMEPXcCO44ueyqLFaIBb7AXTvy7okt6K/0mEUU12cyzVKA68g==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3uyr7fh8jp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 04:18:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnCA93nNIZEYr+JPR1VXp3/OwHbcWdzZ5X2sVdeV+NChuad4wpahsxb6GwkTxJLFir/DbyDUJbCWyJyOhQwo9OQ89DXxiRc0EDCetS786a+DIYMWOZ9REf2YhLFQLXuIbG0273mX7L/MHBfWnn4tf/QaTkzS7minOvlZdykSxYWJrB9HhrhsWyLzs+myOi1is0Ii0CDG5HVTMjaDKUXYL6ff+XDPMYwA6lCkQvliByeufuWMwQms81QOEoBzT3eCTpVL7RTrhQP4QCAVNdrR2Vs4MwUcHsFv0IoaowP3QuKFQ9JLX36xD7CvypMGrrprxKTJUAbV5BPiVz/Pw4jRog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLIj2+eI6sPz7RRX+lASPbiby9CD97QLMtUVfGDvWVc=;
 b=QZPXUhtK4hXjo8dfJNRVD0T1gzh7OJoCVdqB249vBtki4ouY6xBFQZRmUJr7K9LWCq5VERxyTYjmitqpSD0wNs6oph8FyPDSQmoFGP/Ve1cAOMHRjzRXOvTOyYd0gtzb4bTilGIys0NLmlNuZrGA4bOAcByhLo+y395UfFHnLnZ41rh0hfoJRPWjSLZ53x5Mt0h2Se0bXzCjha4iFfaA0OZ2QW/FF4zk8DmdjydVUoraldR5AV/wIYZsVs/Q6ANrjyx0FllT7adxgBe/2OLGmpG3U28Dm+55TTb6Kdu4Waibq5UXeq59I+bEELaKzgXUicLZjx6FAhpAjmXEVHr5Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA0PR11MB7378.namprd11.prod.outlook.com (2603:10b6:208:432::8)
 by IA0PR11MB7912.namprd11.prod.outlook.com (2603:10b6:208:3dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 04:18:39 +0000
Received: from IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::5548:b43c:f9ac:7b95]) by IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::5548:b43c:f9ac:7b95%4]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 04:18:39 +0000
Date: Thu, 14 Dec 2023 23:18:36 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Steve French <stfrench@microsoft.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 0/1] RFC: linux-5.15.y ksmbd backport for CVE-2023-38431
Message-ID: <ZXvTnMWF/G/RrthX@windriver.com>
References: <20231212184745.2245187-1-paul.gortmaker@windriver.com>
 <2023121241-pope-fragility-edad@gregkh>
 <ZXjGg3SKPHFsTxkb@windriver.com>
 <2023121344-scorebook-doily-5050@gregkh>
 <ZXp2dTSlZ10aQ99t@windriver.com>
 <2023121407-composed-unscathed-5081@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023121407-composed-unscathed-5081@gregkh>
X-ClientProxiedBy: YT4PR01CA0266.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::14) To IA0PR11MB7378.namprd11.prod.outlook.com
 (2603:10b6:208:432::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7378:EE_|IA0PR11MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce6ff9f-1786-496a-1046-08dbfd24ea42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lbCs5Xds5fIDo7cRdIjshJ6JE2SHo69jG2+iizzAc+9YsOJVqvp28iokpRi3cmMdB/+zavRbH1BX501XJaeISb0XvxtezBvKFFH/GsB1HbTOLbDQPKd4zljsw58U32hmJtCHUEwEm5GSa7GvF1mrIZn5D5nWHGGSMeq/UxX48TDq5PDWeeaFacJVpmGlshg8frdfTJ+1x8pazJdXsqXrkt3lBE6BSI6Zi/mFf7wP5baqvCUZIJ/9LdJTTkNlW2csd1EQE2SKw0fwGJVWXDyUwYMn5e8wQdj5mny7ADInsRzb2Hth77nLxMVVsvKDaaY/vrjQc/+TEUFbZx8hU2IWMD6XtDfWNzv5cSDfYm0H8sBuMyJAMvhg8YkrpE38KkzwJb0LgMdHv/JtW/gBD0Lp1hiJdm39Y3K9ciNwcGlcHxTOhUeNJHmBAYIp3uTCl6xrXuC4i0Lf9NXvDhbCLLY86SvEgJBPxckYuojNI5/EWxjHaL0vVzGiwoOUCC5+a8TLlo/mAbjTCeqh3h1ba+3KelrVgEyjL4HGOkWxYLvtcE8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7378.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(396003)(39850400004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(83380400001)(38100700002)(41300700001)(66556008)(66476007)(66946007)(6916009)(54906003)(2616005)(26005)(86362001)(6666004)(6512007)(6506007)(478600001)(6486002)(2906002)(966005)(316002)(44832011)(36756003)(8676002)(8936002)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Vn9+DMxL6cMgOBAChuqBe4GF3N6NL2q7Swz3NeUTri7A+5qJnnq8t6JBUmh/?=
 =?us-ascii?Q?xFU8shIvA2pyRxXlhcyUj/PDdd/5Ydb5Y3BmOvWqq1zB6Ju3Se4Jd70Rxz9z?=
 =?us-ascii?Q?nYM0jUVlSI1rvlX1A2AG1Qt6c/Jf0idGyq8uctw8v/qT3Kyf61az/1NfmdFc?=
 =?us-ascii?Q?Vcotdp0kEwilWPbZ4C2QJ/4j+WWrl3BCWazGRxtZpReIR1BBO9BvsmMCtge7?=
 =?us-ascii?Q?kIpQcKSiTDt9prKwOYh0mQ6+RWjabC5RFcEPr3iLI86ErkSiSc1JdNABnYpP?=
 =?us-ascii?Q?oA0JImnl1jPJE7y5LT1cvzYOvLERaPd8LoJieqzQyzXGwW9gYtMiNC8tMR57?=
 =?us-ascii?Q?Om8K+DlJNMwLGWiyGNsc8ThDtfSA1/o4RixqmBq29whL3lykCRuJ9tGF0vRB?=
 =?us-ascii?Q?Rm9Fkuv0nuP6DNW+sFyU48Yyd2etDwCuu2xrK5eFkB+kVK4Su3Ni2m5pJHIy?=
 =?us-ascii?Q?+kGAmJ4XwTBiVk4opLIdfqnQQHzfcc79FZSPvhyX7+tLYkRv0AFovHc1durI?=
 =?us-ascii?Q?sFwjAmcXw4s9q59oKdyvU4pY5TwNjFkfWiV2LNgYw+xyIpcnpCtLorTF6LKy?=
 =?us-ascii?Q?SZcKBLD3UBUw0/Emv8egPFM0MjvG1CKyn/UAo4bezYIyqNXHmzVBaIK5NIzy?=
 =?us-ascii?Q?C5fjGePDBTB62hQaWMN+GEytThKfdC47saQ2GijmEZQH+FPm1uhf1gK55t1R?=
 =?us-ascii?Q?sh67Q3oxH0LfC5l5ZhmypIWXL3JZQA4gAcgSmb5Y8vX6bvPL851d4LKYiQUy?=
 =?us-ascii?Q?bJpLEfDLSjQWvz6XjWw6zV7RkLjETG5Q1DgmLUk78n5+WVJpWp5dq5CoOp75?=
 =?us-ascii?Q?8hfc63YuGhSbMvzaIe6LeIUO6hNCAxxDq3bVBzWYDo/+2nYMPD0X8UHMASnf?=
 =?us-ascii?Q?ny4NDNN3iq7Q1zepr32rAw0lD5qDz8MmeMUduH9ubZoPw42rE4CiQkojyDHm?=
 =?us-ascii?Q?qYoERgH7c4MNY0hDQz9WKYT5NKjhAhWZ/i4FMxahsuLyPoSLRitGRUt+g6G8?=
 =?us-ascii?Q?6HE4G1ymfTogZVGbEoybOjB75WUPpbVMw/N0qK4Lpnn4ARx5R54absXdBxid?=
 =?us-ascii?Q?PKvcRhXyNtEcqptWYzSm8X/YzCBBjB348Fxp5i3nJmUirokGnC9A6vypcUX/?=
 =?us-ascii?Q?SJS1GmEkzB+EmIFr5ec7dWXf5Rd6gJBZj653dKgl3/YEogB1hOm0P17tMHvc?=
 =?us-ascii?Q?OdofbQRlZq+MM1aMfFbnxDtIUqyTsydm0zLCipASbQduiROcFDiAgn221MPk?=
 =?us-ascii?Q?TMZNtPhflQMkTzRgWW0o8FfL0bBGEmTIrSmBEUu8LSXPs09tqw0PY+64ltve?=
 =?us-ascii?Q?RkQHjqO24mdbTcY7R8FkccUAKOcwCvaRbNLwrsSyJRMljna7pTHDPilOSG5I?=
 =?us-ascii?Q?9HI7rFGRe6bpHgL3mPmgtzYF+/h97SYKmSuE/8Xdxc/Iaig7DBiJ0dtxzDsz?=
 =?us-ascii?Q?SCNb5b/xBkC8/4CefYHxMbVZdImjB+/Ga0wsei+KlUfbsSZ30DQsqAMbhoFF?=
 =?us-ascii?Q?3Xkomuxg15IeEU0CmMPKfRynJ/yujbh6zj1n1uj1VQ2MCaC9wMKHt0opOeXR?=
 =?us-ascii?Q?Hgtbvl/f4yljobSbM+4ZFMYlIkVAzYTSzmfZthQgnjXKdhNUWOTbjeCOeRpq?=
 =?us-ascii?Q?vQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce6ff9f-1786-496a-1046-08dbfd24ea42
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7378.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 04:18:39.4929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pq6N6Bv1SfppJWki/qWgxC207j3/G/y0ujYVRx94YMuRFFNVJ8+zhaxO6CCVKoGduY8A+2yafMoiB9QyJ+qvdnP9IQAQHdDPp3U0Yv5a3xQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7912
X-Proofpoint-ORIG-GUID: dr15d-gdQq7hNSHuNP8ns8Y0uh2OahEv
X-Proofpoint-GUID: dr15d-gdQq7hNSHuNP8ns8Y0uh2OahEv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=814
 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312150028

[Re: [PATCH 0/1] RFC: linux-5.15.y ksmbd backport for CVE-2023-38431] On 14/12/2023 (Thu 09:20) Greg KH wrote:

[...]

> > > If no one steps up, I'll just mark the thing as broken, it is _so_ far
> > > behind in patches that it's just sad.
> > 
> > Again, in this case - I have no problem with that - but as a note of
> > record -- whenever linux-stable removes a Kconfig, either explicitly or
> > by a depends on BROKEN - it does trigger fallout for some people.
> 
> In what way?  Just having to update default config options?
> 
> > The Yocto/OE does an audit on the Kconfig output looking for options
> > that were explicitly set (or un-set) by the user, or by base templates.
> > If they don't land in the final .config file -- it lets you know.
> 
> So defconfig type checks?

Here is a recent example.

https://lists.yoctoproject.org/g/linux-yocto/message/13387

I am not saying linux-stable is wrong to do these kinds of changes, I'm
just saying there is an impact that people might not be aware of.

Paul.
--

> 
> thanks,
> 
> greg k-h

