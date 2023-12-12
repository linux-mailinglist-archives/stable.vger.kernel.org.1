Return-Path: <stable+bounces-6508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 414D280F80D
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 21:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 374911C20D5B
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 20:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA2464133;
	Tue, 12 Dec 2023 20:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="k7fqbdd8"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093699B
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 12:46:11 -0800 (PST)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BCAAmEV016317;
	Tue, 12 Dec 2023 12:46:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=PPS06212021; bh=YQAoZj3R/H2YIWN6+6K
	Er2Qa6M5erxyIvOYkQZPoT8k=; b=k7fqbdd8zVBM4Fdx6LKWbWgf38Qvfs41Ssa
	0RjB17HYe6h/noPoyPqraoDbn4YRYj7GgnY6o6nXFplzGSt9IbRWrRCX+YWmYsep
	e1Ex5Btsazmmi7f2XBQ5QzFOJEdXxN5h1m1GH+Ay9jABVkU/qCxGZQAckBHyopBa
	5re11iv6/Aoy35ffE1d74qTstJ26jdrTJJG9B8JEqAa0oXZayYRhTJ9+y2aO4UZd
	hXUZqDpuM/PXyFxz2FxFClz3PRoMXbopI9nrwAP6yUKFUQJp7/SoCS/K2C6/TTjy
	7n2B64VyFSDckVIU+cmMvfZxRDfcS6XHpHGieIUltDYV39XchGA==
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3uwyxj9r62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Dec 2023 12:46:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGGW+xqgDDqAjQQXbId0CEHR5PswIA6lrOawNqBdNQ1C8XhC0AH4Z1R9BUnDcpBM8y62ojPTE/AzNL74j8VHfh973K7uDLZoY+dIVRf5sMzBeN3vKJ/NldxFyxDMoWdVTb7LOP5C+O3xUVtH+B6ZXnSWlo5SvIMP77SETERYqnpzHoQtZ7weRq4QmdxcDBV2gN8qr1vVSTSkt07TTERXqbReNXhh2Fk+5gGyHBjY71e6Zjx8cNWZzuE2Z0JiPqLq91OAyT8HyP6cLhZbnYR28CGZhXi+WDiyg364hSAZmqyLMerdB/1nk3lV+OOVNJdBZ4t5Z76bNTsemruoEZd+Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQAoZj3R/H2YIWN6+6KEr2Qa6M5erxyIvOYkQZPoT8k=;
 b=K/aefJDk41+xPNeDFN2nuSj7xs1QihTfTj4fPQQc6XCenSKwessr6ZiYOCyRutVVur3n363dzc4zx8b0zrVjRclZRxTLYMTK5WFMRsCWPIqULTaAgNcRqIPkWydLxZI0/Jj5cN3mJuClD16sH5iiiGg5w8fRqnzYw9ngeFxrzdPATys+N1Dnx2aJHpaWe5HG2h4pJSTaHgIUSlEMtNLRGPyDseXd6CFgCgiH21TkK0wUN1lS5NeDM0mIHYcwVpzGcCk7TszHcAbKjrnSkTr4qDe8kd5ffB6OxlRy4f0aeMmcy0vSyDJ6hX3cNrO5lcvEFFEIJhiYin+UT9kTReGkYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA0PR11MB7378.namprd11.prod.outlook.com (2603:10b6:208:432::8)
 by MN6PR11MB8193.namprd11.prod.outlook.com (2603:10b6:208:47a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 20:46:00 +0000
Received: from IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::5548:b43c:f9ac:7b95]) by IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::5548:b43c:f9ac:7b95%4]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 20:45:59 +0000
Date: Tue, 12 Dec 2023 15:45:55 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Steve French <stfrench@microsoft.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 0/1] RFC: linux-5.15.y ksmbd backport for CVE-2023-38431
Message-ID: <ZXjGg3SKPHFsTxkb@windriver.com>
References: <20231212184745.2245187-1-paul.gortmaker@windriver.com>
 <2023121241-pope-fragility-edad@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023121241-pope-fragility-edad@gregkh>
X-ClientProxiedBy: YT4P288CA0033.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::11) To IA0PR11MB7378.namprd11.prod.outlook.com
 (2603:10b6:208:432::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7378:EE_|MN6PR11MB8193:EE_
X-MS-Office365-Filtering-Correlation-Id: cba0525d-28b0-44a9-0e53-08dbfb5358a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	r7yXVaouqLlIGShogVK2sXjFigmX73baieL8SMKcTgDmTNwiU5Wa1sEbTCOfxS/osERTGvf8bOY2vI0Efw7g6h9H4C+SUaoP+XBbUGiiZVLV1cSXuog2eemhGkMMJLZu1gWRbdfbocL39P7ECtsfYjQqI26b+UONiPZXw4eaxYLCs34ohQqcD8akqFS1P1VWoBePaHm3azSJfMasapDoD2Zqa6bJfY9/WkeyKgpXJVMpn2ETQ/nZ6QP6crWK4qT7As9nnP94zkmMyNqYqfWmGjEUQsw56vWC0KPvPUjzKBR5S8LkvzwG/fmt83YYvDH3SBpwrW5BXLr2/yAplkO7RaHo1dJMsfP9cLnEehAMEueJa+DOo8kpWXTF5frGvCnQnlNcjG57HddfVqCEIxqtWPi2j5PjHBjSjIFNw0AzvTMiOTasCqC2EDCGPpKLMyc6h2RbosGdTz9kN9C239vWYiFeLS9clu4RT9N36Ew473DRJnz+HIDFP63mXhapq4ABaGhdMkq/gAn0oIy7E+6nbPA8YITQJnecD349iEtDKeYnObxdY1v06EAQ5HCG8wWJ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7378.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(376002)(346002)(366004)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(2616005)(26005)(86362001)(36756003)(38100700002)(44832011)(5660300002)(316002)(8676002)(8936002)(4326008)(2906002)(6666004)(6512007)(6506007)(6916009)(66476007)(54906003)(66556008)(66946007)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?FvQBXrre/WZgASDwRjZoiCg+6KIhKCLCHNywip9HRN2EXTwIenur/pmLdK+t?=
 =?us-ascii?Q?k3fDlJhjbjuGYFSMY9TPQ3uAgO9HLn3l0wR2/aCNqtW2moOqspTXtWXCCwZw?=
 =?us-ascii?Q?/rYPmXUc/bWRVhQWSTpWvg66rPVI8dKCu2LCke0Kf0dSCa6v4KBgkp2J9HGs?=
 =?us-ascii?Q?HvKcmRBKOBlh8eQo01+uAGJ2rd81H5XKeQa+VimMAiAEQiDZTx2hAK0fX5Wl?=
 =?us-ascii?Q?bN1E8jm/3aLwt0YVT4tsq6GSFIbKjZVISHOboe7QdvCa324ZYMdGP15DfVEE?=
 =?us-ascii?Q?1mKuM/CLFeQBfbIpYObAyJ7AN5ZYZrVZPzMdaWnZx+650SouNF369l9OuTf4?=
 =?us-ascii?Q?h1Eu+gqtNrQnR7uVw5UfJ+0WIBE4aS3Ccl6a1p4Pzx60DODTkPm/2OdX10+B?=
 =?us-ascii?Q?lxyV2JtfN9VUuVrzHGTU/WQTTHnkQ7w3l5BwxeD0AOgZnODWIJlt70RHaHtW?=
 =?us-ascii?Q?1IPjQe5vc/4MZHPElIJBrUciajZvL71aBOG2/lWE5/E4mBSpWpaljfG2Xefd?=
 =?us-ascii?Q?X2bxFXp6XXfiXNkfPmPaiK/sb6Z07FYYYuUUKcYv3qWi6CYHiH2GT2UaIDyP?=
 =?us-ascii?Q?zFZjqC2D6LiNNHUEcegtkm2Ror0CzhudY+X2WhL3wZpSl4JVv5iCN1C8klHQ?=
 =?us-ascii?Q?ilXMK0VVz48KQyieqLfgP9F78AbFmdMnUwGuTMD0CBTEJmBL8Sy468sTSe4T?=
 =?us-ascii?Q?47p3ZWa7c0MVbk+kuKABuQcH4FrLkuk6R2oaBmixBsfnbSwqKmMc6l6DGBJI?=
 =?us-ascii?Q?fF4anpLPRg79AijPQLjQn4dUk/YGNl0nE0YKSMshEEoIRucEC1iUnd8a6jet?=
 =?us-ascii?Q?iIzeP+RVIOa1smdyZ2WtzgkfGf1m+S/bUJDoxtbKB4loq1YTPmVibRO1ER/B?=
 =?us-ascii?Q?x6lZUd72SDLuMdmBOsOYRV8Czc9cnfDLZLKSPas9Pvo7EhQT8DdYT+DYM+Ii?=
 =?us-ascii?Q?+WoZ43N8Lm9MeOeNeJ0oXDk0vDS0KKaJH3U+wlDN+YJ0UH0PrsV8i3SovGKS?=
 =?us-ascii?Q?DuFoOm7679JSdmVsNqAJd65wXyzQIFMXL9wk7GJaEvl0d5EWV1Zo15sGqJyK?=
 =?us-ascii?Q?q8Ahp5YVZJJaadVo3RYU/SbDwPUIC2RofM1eNdBKGAHWlBQXhEjlsMURpA3L?=
 =?us-ascii?Q?fjWlFVaNsa+FW6yjUuLx+Ub6Ga6xDLlfs6mDM6AbfMQf8oTHIrxtf6H5Phwn?=
 =?us-ascii?Q?LIOo1AwA9/nJTFpE0eCjVCJ+HNDPlZxtn8WFghjW5hy2Qd1BJO4cJdm+xII7?=
 =?us-ascii?Q?008SlqP3I9T3dmV0B5vdBYZF6GsR+vc031jszVGBruNz5TEY6c5MGFwrdk3n?=
 =?us-ascii?Q?hV9iqNGjpqEWV//FJdBc9GiUjVZVWJhQgPoqA39leJepYMqg6E1EfJuoyoRD?=
 =?us-ascii?Q?sWtwU0zN2RF5cGN7G8UEgegDdLClGVjMIAebTCmsp8f2BM/r39H/r9rEMihN?=
 =?us-ascii?Q?26m/ebD1+MKL8mKdbdrKSWBPYU8IjGn7DaVBWJUZ6JPXn1N6yzCcx85HUpi8?=
 =?us-ascii?Q?7IqHqBGv9F9R4B8zAtpYbESb3TLQQM2dD7A2BTpnca8I1iMqOpkCbHsAVbjf?=
 =?us-ascii?Q?KyPRJhQV6fzm6gdo88osApEcO8BwOoK8wAi/LIFgWhgyrXkHGnN4Wnw/Tn2q?=
 =?us-ascii?Q?0g=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cba0525d-28b0-44a9-0e53-08dbfb5358a4
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7378.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 20:45:59.2757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nFSjoOI1jWgn+YnyYpnNygtI/8MqugE8Lb1yWcn7sWJRRkt5s71X4U8nKPgyiQfrr6+pn6DFBzjBLQlW8wItg5uWwcx33OVtFZN5032b7zQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8193
X-Proofpoint-ORIG-GUID: CU14wDJYT4Q4hqCkOC5xcXv_BFWHU3n3
X-Proofpoint-GUID: CU14wDJYT4Q4hqCkOC5xcXv_BFWHU3n3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=846 adultscore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312120160

[Re: [PATCH 0/1] RFC: linux-5.15.y ksmbd backport for CVE-2023-38431] On 12/12/2023 (Tue 21:04) Greg KH wrote:

> On Tue, Dec 12, 2023 at 01:47:44PM -0500, paul.gortmaker@windriver.com wrote:
> > From: Paul Gortmaker <paul.gortmaker@windriver.com>
> > 
> > This is a bit long, but I've never touched this code and all I can do is
> > compile test it.  So the below basically represents a capture of my
> > thought process in fixing this for the v5.15.y-stable branch.
> 
> Nice work, but really, given that there are _SO_ many ksmb patches that
> have NOT been backported to 5.15.y, I would strongly recommend that we
> just mark the thing as depending on BROKEN there for now as your one

I'd be 100% fine with that.  Can't speak for anyone else though.

> backport here is not going to make a dent in the fixes that need to be
> applied there to resolve the known issues that the codebase currently
> has resolved in newer kernels.
> 
> Do you use this codebase on 5.15.y?  What drove you to want to backport

I don't use it, and I don't know of anyone who does.

> this, just the presence of a random CVE identifier?  If that's all it
> takes to get companies to actually do backports, maybe I should go
> allocate more of them :)

I wouldn't have normally touched it but someone else was looking at
doing the backport and essentially declared it "too hard" and so I
couldn't let that stand.  :-P

Paul.
--

> 
> thanks,
> 
> greg k-h

