Return-Path: <stable+bounces-6707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA89F8125EB
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 04:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C325F1C20C09
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 03:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DB917E4;
	Thu, 14 Dec 2023 03:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="YvdDQ3d6"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8CEB0
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 19:29:12 -0800 (PST)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE3L8hf002201;
	Wed, 13 Dec 2023 19:29:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=PPS06212021; bh=4lysgEqMB30XSnL1hX0
	Cz8PHl74GCFnorR+CK3PYaHc=; b=YvdDQ3d6N9jNcIT+b1oQulaNKtq1WQL7yi7
	lewGiVlM5pkCyvUgJzIV8muHLmkEG4cF+dZFy1zY2/zmArLa9dcmSJdq1Dveumqt
	yWsI7MpTXIOiBwgVAIYapIubbG/8i+x2ZXZKobYA2yOhZzWL/rKRhUgjYc0Sp0y1
	sE5w57+XNpxSHBsmo3OvC25W8qOEvKebvXsl2auvugM/sayOxeqmnvwzt9pEo013
	0Grf4PZKqWA96tNejF2Wl17qpeDFlyWksr2puX/F/uLXif1tQg9sdlgQQ4tyvM0j
	m16FElab070w2634Y59NenGfakS2AcFDI4j/woVYZMQcE93Fmlg==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3uyr9k022y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Dec 2023 19:29:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BW1ilDiQIa5Tx1kgLn9nMZgolzzywwQdyPhtRfCZFsUz8BqjGkmuUFqMpwFsdmU2eHtmeBKvP1kGA+NPz1TyWRUiEpZFhlr4X21X2jLxGF5eaLdZb8rj1y2BaJ1Ge40qbokDl0XY1wBKOBr/Wmf3eKyr4BeOqFEq3Yh11+UCL/enBCt1UYqcEnPfZFkWdKgglzwzyZkf0Mwh3QKcNJXvsGg3tPme3rQpkZHgIuc3XkQb3MMO2Set3pGNLbD+VC3fKCb9lg9GhTrly8w2x3egBHd6WfMYQYmQUhyw7V76ZLooW6mQcji4CdQg0mLFWWWRL/icWvjSrokqSl3nmVujQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lysgEqMB30XSnL1hX0Cz8PHl74GCFnorR+CK3PYaHc=;
 b=m9tpGjMiHhyhCwHbrglnxXFwBDvGw5CcJ2XXy4KOUMY7+yQ2VHq3Ba6cUbz28WzzX8LFZQhkgXezkIcyvjO7XbJWu9tLJmUmyEYTShv0p50C6XMHN1GDNdsjYXuYmqk9G4AvW+l1Y5hhX5No0tiIsiHiJgCOr7mAsorDCFY6GsQ+exw0TuX91UjO5/lfqS2/6uZjrWQxVFickO/8NJGMA5hT+6mLnzRjPI15DrEVc0BoWw42/AorqJxQiZMBDbzOV/SqDHwxG1XIeJwpm6cUaMojkdEqFNPPEqgXWOhLzqNfFJYh9iCchYBzNVEvPswoohQGJhmibXN7ABWqLLT8eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA0PR11MB7378.namprd11.prod.outlook.com (2603:10b6:208:432::8)
 by SA2PR11MB4827.namprd11.prod.outlook.com (2603:10b6:806:11f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 03:28:57 +0000
Received: from IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::5548:b43c:f9ac:7b95]) by IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::5548:b43c:f9ac:7b95%4]) with mapi id 15.20.7068.033; Thu, 14 Dec 2023
 03:28:56 +0000
Date: Wed, 13 Dec 2023 22:28:53 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Steve French <stfrench@microsoft.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 0/1] RFC: linux-5.15.y ksmbd backport for CVE-2023-38431
Message-ID: <ZXp2dTSlZ10aQ99t@windriver.com>
References: <20231212184745.2245187-1-paul.gortmaker@windriver.com>
 <2023121241-pope-fragility-edad@gregkh>
 <ZXjGg3SKPHFsTxkb@windriver.com>
 <2023121344-scorebook-doily-5050@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023121344-scorebook-doily-5050@gregkh>
X-ClientProxiedBy: YT4PR01CA0245.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::18) To IA0PR11MB7378.namprd11.prod.outlook.com
 (2603:10b6:208:432::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7378:EE_|SA2PR11MB4827:EE_
X-MS-Office365-Filtering-Correlation-Id: 219ef9ba-37ef-415a-7d23-08dbfc54cdb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xUTHaNNoF7YFLwtGl7lW5m7TZMbKkS/6kyHdebNoeEhEIC8vRjYSgOnTFk0mHcVkvjk/PNmPjYFbN7/oRO9bMOZe7Kh3+sXcINDtqaWMeQyltPl4RoM8Cu1oCneozQryIIPRVcgKWYtCvZO//Dy2s7Fx05jQeIPlvEV+5k5XOWaRwTQP20srH7fpKBh+ISjhqnRV9NXH0twsg0HqjPI25UZnRU/Ec+moKpw1lZCrRJjMdrRAOloobE58gWAkHOqn6ET8Zd/S3C8NLeYvQ7pfeE/jJhF2r4y2RozRu76JrFvBCSuWjESupEIcaUFLq96RczDst2gqaELcYBxXttzquq2WoEXuDzUX3aWezbOfyQI5B9qnOYfPsPqVdxN+Jbh69Rgvr3O5W7TeaGnoVB1wbR8vegBVaGwHwQwO+aUXDNJKA9VEpriK4PoNmnR3BympFokPpx8Oq2VI9B0MhEFkzYPy6UJck4D5RY1yeYSytA+PZK2lyDkz4YcWeUIZaoWapjaL+krPDLcDDhJzPNqhRA5L6uhh8nM4qNilTafUqgGzOe1Dd3JhnhFFQ3HJW4l0
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7378.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39850400004)(366004)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38100700002)(86362001)(66899024)(36756003)(6506007)(6666004)(478600001)(6486002)(26005)(44832011)(54906003)(6916009)(66556008)(66476007)(66946007)(6512007)(316002)(2616005)(4326008)(8936002)(8676002)(41300700001)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HNCEWi5jX5NnjiVv18Iq+nkQbcHFgprHPAahFLmB0lyZezKzhkI/emHXD20E?=
 =?us-ascii?Q?Qf8qYjQ3kdyriaGLkOseLpBihRGxnEcoxu7ZfBXqBuaWl1flvbA3svfwiZ/q?=
 =?us-ascii?Q?8l1g6TWzxDqteE9KekEhPtATiACd/qV3iFMMJFbrx1dI5T199v/jF3rsWzOr?=
 =?us-ascii?Q?aSAXi8SnLKguxuHZRRv3N80zvrC3ZzSC2zwBrxdFW5UbWyrIaOyVJPiMNQJx?=
 =?us-ascii?Q?0A4wreqNWB2RB2cgqh81ex0C0cUxHXXChqqibg57Y6rVLiHtCvseENbeqrtt?=
 =?us-ascii?Q?fW04ERTc0ZWqIEp3I71o/BUp1JDylnwgPtuu4WPP7eu3TVNXJ49ndPR/z6iQ?=
 =?us-ascii?Q?THdUaodP4Z+rUSZtYk9uKstzDG7tnl6fsYf634vl1wn2b0vglBnB7CnrKi3E?=
 =?us-ascii?Q?kIJLfcIMrspJHIh/jo/7cGdYarhwm3ohJQTG8eEbaeCeAAuGZW/X/H9qy6Vq?=
 =?us-ascii?Q?L7ZC8e/n3jFRFiH7vGdG6o1w9FdZo2vZKQerQ7STvC2lJSix+v5gsAoGlpyO?=
 =?us-ascii?Q?2xcvIfCgF2MSxpFzemra9nZwdfXqpEDSfiSnkHhPUwV4ArUZasNmgtaLLGes?=
 =?us-ascii?Q?jyuu5DhMNMVHA/LAg/ocJIUU5H45+hNQOKyfV+0i8GGejftGVdzh0hmGhf2l?=
 =?us-ascii?Q?vMvuEyBcuVfitqixqjEWRO3w1yofwiB5nrEPk4x9DyZ9WxWPsRWEXkiaNL99?=
 =?us-ascii?Q?fP72CQQhDsBRf003UCHDvPZ5WbbbEfH/bzsGJYx4WU4GW6VZmd2a0YdYlAas?=
 =?us-ascii?Q?nCNdSu9VQg6Cyq7FU2dmUxTUAEOevhz4GM6H07PwLC/C+nEqeYXiJ2ec2swt?=
 =?us-ascii?Q?dfMwLfszRgMpo0NNohiw5pR0GPcIYS+Mx7z2DVS8Z62BrbWOA5ZeX5Sj6PWj?=
 =?us-ascii?Q?bcynJRbOxwyjCMFHG5jR+dT7kdv/VjJbPd2Wol9M3KsSILf5ecUanDtxda8x?=
 =?us-ascii?Q?VZLXyOkpbIfxnziC2i+euvVg7mTK1XdR2uyhq+OrK9kqum63USQSBFtFabs8?=
 =?us-ascii?Q?WNMHGrNwOVw5DOryyw1EFHWAA2iZ1A1TqbPJoamULgPEYOWnYaHHxVOozFuU?=
 =?us-ascii?Q?p/69yvAi4q1/EblXnZSknXuDUZjBcKut60WCL1k0PcHfnhr7rXwqNJESBay9?=
 =?us-ascii?Q?H1qANlSGZI60aH0lcv2upsm6GOCzYrX0HER4+DNu5HHFGpuAsxRiGl0a5kSZ?=
 =?us-ascii?Q?FjGsRqgwcyfA6JFj/7zYt/JhNLzEeEQs3anV48BbfBu8jaLs3Idu2oceJLsi?=
 =?us-ascii?Q?c252ItPY0xldopkB70FHxcnJ0vW5sK6/Ma1z95LI1kkcHnYDd0gGdZlvUJwv?=
 =?us-ascii?Q?m9mK7Ao1PcPmwYxuf1YRUYq9JRFdqvdEUptIpbQrYQ4kzqWHFIGWRL5DQCfO?=
 =?us-ascii?Q?w5cW0JuSUC4msN1cYgqAOcqkAxn/a1/Gv0ZdPdEadir7bF4dqcwPOGG0rrS1?=
 =?us-ascii?Q?Hq5D1EqPPbpYgqc/MizkpWVZYIkr81AzU3Oo0IzjnsJuOM/qiPQ0N3zxpaT3?=
 =?us-ascii?Q?JDocFyo/qQ9v339LNzQlKQjNhVPqP01sAFtRZ/IhwCwXocgvSVMCK2Yodw72?=
 =?us-ascii?Q?natgc4CcOu+2L8Vm8p1bJcx11BIXKSfVzjsxmN4ySSDyUPS+QGwD8MBZc8mx?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 219ef9ba-37ef-415a-7d23-08dbfc54cdb4
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7378.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 03:28:56.2955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sUTO2LQwYaWYNkq88jH5gC5AUzZ2u+3y+ibcrZuroKlynUeXmBSijSMvtnkq9unUvMOipAN3XasKb/u8Yw/Bi7QYrdgEw2SL99addH5+C9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4827
X-Proofpoint-ORIG-GUID: 2iDG4SFeGk34cJ-HGnBCXFQFGG7Tse7l
X-Proofpoint-GUID: 2iDG4SFeGk34cJ-HGnBCXFQFGG7Tse7l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=984 mlxscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312140017

[Re: [PATCH 0/1] RFC: linux-5.15.y ksmbd backport for CVE-2023-38431] On 13/12/2023 (Wed 15:34) Greg KH wrote:

> On Tue, Dec 12, 2023 at 03:45:55PM -0500, Paul Gortmaker wrote:
> > [Re: [PATCH 0/1] RFC: linux-5.15.y ksmbd backport for CVE-2023-38431] On 12/12/2023 (Tue 21:04) Greg KH wrote:
> > 
> > > On Tue, Dec 12, 2023 at 01:47:44PM -0500, paul.gortmaker@windriver.com wrote:
> > > > From: Paul Gortmaker <paul.gortmaker@windriver.com>
> > > > 
> > > > This is a bit long, but I've never touched this code and all I can do is
> > > > compile test it.  So the below basically represents a capture of my
> > > > thought process in fixing this for the v5.15.y-stable branch.
> > > 
> > > Nice work, but really, given that there are _SO_ many ksmb patches that
> > > have NOT been backported to 5.15.y, I would strongly recommend that we
> > > just mark the thing as depending on BROKEN there for now as your one
> > 
> > I'd be 100% fine with that.  Can't speak for anyone else though.
> > 
> > > backport here is not going to make a dent in the fixes that need to be
> > > applied there to resolve the known issues that the codebase currently
> > > has resolved in newer kernels.
> > > 
> > > Do you use this codebase on 5.15.y?  What drove you to want to backport
> > 
> > I don't use it, and I don't know of anyone who does.
> 
> Then why are you all backporting stuff for it?

Firstly, you've cut the context where I already explained that I did it
because others said it couldn't be done.  Of all people, I am sure you
can respect that.

The Yocto Project still offers v5.15 as an option, and whenever I can, I
help out to advance the Yocto Project as time permits.  Ask Richard.

> If no one steps up, I'll just mark the thing as broken, it is _so_ far
> behind in patches that it's just sad.

Again, in this case - I have no problem with that - but as a note of
record -- whenever linux-stable removes a Kconfig, either explicitly or
by a depends on BROKEN - it does trigger fallout for some people.

The Yocto/OE does an audit on the Kconfig output looking for options
that were explicitly set (or un-set) by the user, or by base templates.
If they don't land in the final .config file -- it lets you know.

Paul.
--

> thanks,
> 
> greg k-h

