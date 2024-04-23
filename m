Return-Path: <stable+bounces-40742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 548828AF571
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 19:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78B1B1C23F52
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 17:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA51913E41A;
	Tue, 23 Apr 2024 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hjcbzg0U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cktuGoKS"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA7013D8BB
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713893039; cv=fail; b=WOpN150fOcM6A4+dFmf+tPeI0nH1wqs8yJjgE+Rq6QKig+OYX+t+jI0tuzkj2Dk/jzG8QqI84B2RIrNrebmdyH9UkvlHFTFkN9WOMjEO9xyZlQAWeyu/KjRO5KcV85SLM5b6fiVzAisN3tBGbUtcfwrwR/PFxvciksQE9cTeJ7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713893039; c=relaxed/simple;
	bh=jEEg4AcL5fyZ2VdYrPsHN6ETlX+pBbBKXEbF5ObjXHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K+FTo12r3NASMi+3Zz+qoTvzfgeY74n0M6rp6VO9iK0SYNb6fFsfM5tANqFKPoU/isikNasQ9YRNx4dXktvU0bijPfiokHeqOsfBQK/zCiuAgYRPaOtSRmPebFBiIidDM8u5hIAhSbhPxGwojPMd1NdEwKn0qBbY6TnTbxkSzec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Hjcbzg0U; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cktuGoKS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43NFSxZG023030;
	Tue, 23 Apr 2024 17:23:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=42mBT/8073x4BUFyfPKxxGFfdh9kDq1VT52mwt5XV6I=;
 b=Hjcbzg0Upx9Mz5GlZskE/H21XjbeFbsb8iNa9K7yaJwsHqAS8Pg1yOJCIqMYrru3MioP
 wMBvjCyL9KdEhoQ+BDQVFqAfOXm2C5ycBVdjxwJxrtJuOR+jWFWG7WsQSWVxcjXjQfEd
 rdrVVRiPqUrj0ysmFf/e8hd5J0gvW6jecA5R86z/1YRYlycKRn6i0fyO86M2MYlFPMWk
 1tVC0dcWpdHvSyzdrJAdcOEBns+eG5PL1I/hgftqWSv+/etnRUPtrVDdmcKZc3e4eZ34
 alKvjE4Eo79pMqQJ9dQ5RMccnDDtzbugUGOxN4uy/uT+NRb+lhpreS4iteMbx/AMN5Qp QQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5aunwug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 17:23:53 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43NGQE7F035571;
	Tue, 23 Apr 2024 17:23:52 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm457kwpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 17:23:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NezBFPYjJdFHlbznJxv9B6lEMIa7xtYpnvJgmCxVZxo4zRH6wqVIDJahzt1OYaZyX0uGT1kwCa/TwZnnHkhJ/8MzNb+vXbw1oRNkClg8hqjVwQQ04a8UQQr3hKV3sY6mxiC/KEnqsrkHWRS+yP55CcmLrbrEW4q21pUIl3wNly3ZHZA8OGnhWWpLGOrpQOFQu4yhE4FkjShCd7NJ3jL8G0lXmZrgxaGl+6S6Rwy9o1JP4yGN6CMaIANUbLnuGRTDJRIyIK9jNxf9QpvUun7yUS74h1Z7Sd5CWdi5gUfbbNat1FUrKkwnrtNZESyR7oh1DAsscjWTJW6ADSTrBoDLNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42mBT/8073x4BUFyfPKxxGFfdh9kDq1VT52mwt5XV6I=;
 b=hp5f56/pIu89Mwx78wAwZ20SBi8QpV1yuXCYbrNUQl9HqhT7jbb0jTZvOSf61EW589Qh6sUdkTQ3OxBt+oXhVbBxSnX8h9RJqhmpK/k0Ilm4PfHLTyHfH2ETecjZlWJ58nuLN8QkNVcvslVAEUKxqFnqALq4wOWIoyo1vKq256v22my2JbYFbih217G+cZhLJeC9zOAZJMbmmhl0+wpBXBQySDO//fPrWHR7DJe0+QnPPayOEVuRpFtNxuEJda/dk+U0pyeX6DaTPF0jU0FsM2iDYMORcIBnyhDWeyfRBW/h4iGhrJjSiWmBaSIGGq1BHv9CCi6GF7TN0lVchGGkTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42mBT/8073x4BUFyfPKxxGFfdh9kDq1VT52mwt5XV6I=;
 b=cktuGoKSpQDf8jvY4xxFtmVbzylB39t7vj/BH6VU41n1NvEJkdPvKdBzgKYqAWLjEdA0GBZ9sUsTUMumdzgErF8MxHJEStXRYSJUbPmndCvuLonNQ+CX+4Sdij2Wt7D1FDeCzK3sdbs7NBMpksK63WvX6qI0NM0mXhJsB2OxkBQ=
Received: from DM4PR10MB6719.namprd10.prod.outlook.com (2603:10b6:8:111::19)
 by DS7PR10MB7228.namprd10.prod.outlook.com (2603:10b6:8:e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 17:23:50 +0000
Received: from DM4PR10MB6719.namprd10.prod.outlook.com
 ([fe80::4581:e656:3f19:5977]) by DM4PR10MB6719.namprd10.prod.outlook.com
 ([fe80::4581:e656:3f19:5977%7]) with mapi id 15.20.7472.042; Tue, 23 Apr 2024
 17:23:49 +0000
Date: Tue, 23 Apr 2024 13:23:23 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Ard Biesheuvel <ardb@kernel.org>, gregkh@linuxfoundation.org
Cc: Greg KH <gregkh@linuxfoundation.org>, "# 3.4.x" <stable@vger.kernel.org>,
        jan.setjeeilers@oracle.com
Subject: Re: v5.15 backport request
Message-ID: <Zifui1Z8p4R24wyL@char.us.oracle.com>
References: <CAMj1kXEGNNZm9RrDxT6RzmE8WGFG-3kZePaZZNKJrT4fj3iveg@mail.gmail.com>
 <2024041134-strobe-childhood-cc74@gregkh>
 <2024041113-flyaway-headphone-df2b@gregkh>
 <CAMj1kXEagP6psCc=YcpV9Ye=cMYgu-O8npbzH4qaN1xxe=eQDA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEagP6psCc=YcpV9Ye=cMYgu-O8npbzH4qaN1xxe=eQDA@mail.gmail.com>
X-ClientProxiedBy: PH8PR20CA0013.namprd20.prod.outlook.com
 (2603:10b6:510:23c::27) To DM4PR10MB6719.namprd10.prod.outlook.com
 (2603:10b6:8:111::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6719:EE_|DS7PR10MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: 60b1a430-33d3-4117-5d68-08dc63ba23b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?VF+LSFLrxu6yw0M1zkGAWE1W7dP8Kwz86mU83IXDPLmEUjfJzYe9Zj5eHlg9?=
 =?us-ascii?Q?HE9oYFAWkqIpAMrZubG5pC5iLPBgGLbXBqy7d+e1HlQrcPBuEMqtm+ZcedoL?=
 =?us-ascii?Q?4Z1v1bN/ORBoHGHFaD9uVguyauOC8+kj1mi5SOW6wx9cB5qZuhLSBQj5fTAR?=
 =?us-ascii?Q?uRBCVYYWvBWPN9Z+OyefMZqdkfZJJIeG0Ue26l/KhN5GruWBd0NOyXrBLih5?=
 =?us-ascii?Q?7fOStLrCnGLrnk2swzWzzqKhk8q4Vht28YhfxIMnMN/aDzYzfmJnDO7+6lqC?=
 =?us-ascii?Q?jrndfOhJvUXgWTfCJKN+nRslEMM4AjT6P0FSx8o5y0P/EqnBeFPAmY/EzS7v?=
 =?us-ascii?Q?M8XIr5EjVcamBgunJsyF9WijN/GIO/y9w9E/SEuJHcoUa9iGoOKbtnO1WiG8?=
 =?us-ascii?Q?14OId/XMz8vqOwtlwzgK9sjnE2e9KrkMaoTJ4GR8ai731RLWKQHut8/Otq8s?=
 =?us-ascii?Q?PkYWcpzaX5dlWPSyWkixz//1Dl6yz6ix+GOayO+LdxrzPL3+C6drQI53XEBS?=
 =?us-ascii?Q?qQjbeNcRn354YwG9/iUJsUGQqzxQVw6iUEWvp8wMi66T0V+v1eR/H994xUPn?=
 =?us-ascii?Q?9OqJs7ugq+ittiM3FwMHrNW5Ahn76n6IzgER3tnCrLT4OZG/is7yeCSYQu/1?=
 =?us-ascii?Q?JoGIK3C5aaHITE0KpchOjj7ILcxMIgkCUDiE84rmVUeiN2UphKSNlJdploUG?=
 =?us-ascii?Q?UzTRp3xjx6w+SfPvuXfF5wbZSiCaBkzkhCnfLqink6mVz5XHMKwCArk3+tnq?=
 =?us-ascii?Q?91/QzAHyfPjsbEeAomDC1Ypn7MhIxxojmx2IlKHN5xCAdzG27+Ji27eSh8l5?=
 =?us-ascii?Q?uT/0turk0t1kNXIy4wbVLOJ42QeV1lluFRcipyKTra2doKKxv7NW1ya0AGeq?=
 =?us-ascii?Q?t0mdwwgZGAbwdJKgrydmycXr2r/+t9xPL/mvHcl+m7elmNL7ymwqnogPRBhR?=
 =?us-ascii?Q?4uEt1AzX67zQ+ZAUUMHrVU9anCTE32mpLSZjBKu9+FEcD4G192dhj99iGn+C?=
 =?us-ascii?Q?BWuA85I0IZoYpX0X832ITM6AmYWeY70W+6fUIPspy2dtAxx89Jw9S4iWneLT?=
 =?us-ascii?Q?vev/UVAn2sMEj+pjhCGnDC59z1Vr0x3jjkM4w2ZWbv9qEgLyO9NQvZOUAjj+?=
 =?us-ascii?Q?CdLw9TlAIBloETPPpuCl1xfnKIjA54Ai23rBPB8aoWQfmaCOb7pU2an2zm5v?=
 =?us-ascii?Q?3hDzYBoysd6eK0iyYnP9SCo+IEkBdyO8vR3Be3RmHAl1vHoU8NgWDakEs1yy?=
 =?us-ascii?Q?0LBdVvFtF7Loeh5reF1UPcFrJiDXWJymLKPvQShcRg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6719.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?07HlR1HdrSwdciW8F1XeqHaHRQXbyd7px6bFfUTdZtl2VIVPgWrebLqi3Q2L?=
 =?us-ascii?Q?VVFNPYpTlm2QfU3klfnGQMPP+QqG5kEVPG0ApVcgD8Pywr5jhryULjmVZ1/x?=
 =?us-ascii?Q?c0TqawkbnzkNFFwYuP61QpgJ9tyMEMgjjuH0FDdRO8Ta/QUkmjQVAXxhubki?=
 =?us-ascii?Q?W5GvOur9hqHDaeUwZ31BZNlbGyfuFYHc1R6AAXYlhnH2gegUWnBs+uDEuleI?=
 =?us-ascii?Q?DW+T6N1VTyT0Ndivxu5ghahi9/dN/88tmOrYH3uO/UsI3Y8z/2vVrmZOfscz?=
 =?us-ascii?Q?EkMEDtF3j4kp2H2tPs6jMmjJ15Rdl5RmUHIfao1XQ4nyC+WtZO7F6SxqlLiT?=
 =?us-ascii?Q?O5xdBXt8tJAvTial7wAfrMQ3AyMemvU+CPoODHzahEP50r0TmMt0gvTuZ5An?=
 =?us-ascii?Q?ZB5Mrdk4o2fklNb2MbbRln5SHjfUj4/FOwEwdWIwNFDJ1k4TA0TNzZeRQL1+?=
 =?us-ascii?Q?TuC2XIImF24C0M9RGZqFzJFijfd71FKKja049zgYfzAruuihZo9DEz1x4MAd?=
 =?us-ascii?Q?eF6GgnZLsGKshm9Z5lrcVTLRM3rwANVI2g05liA4C6EgKmlemHJn3PdoxWuS?=
 =?us-ascii?Q?vAjxIhxyOFLOIai+6WTpKDhBiKGQjm8NOjLUc9GWqC7iKlkJeKUJPIGdDpS2?=
 =?us-ascii?Q?nRcNIVfQpm3K4a3fnh1y/SXxsz5+fQ4HHW3HpEgYV0DSmQaruQxKgUmIMamJ?=
 =?us-ascii?Q?SYCsqHaVadzgdiKgsDBYhANI7Zne1GQXq/mtlTQWIbFvRexJpy9b/7mHwu8W?=
 =?us-ascii?Q?oGi2kIo08c83cpN0HkRfi8WGGF8Fv4hlWMQX0pl9buE3sPpEMID4TtFqWAvA?=
 =?us-ascii?Q?pUI2OzbHMY73PkNeik6nYNx5KfgypDYhl2GmCdWtoDLmvSS2vG4og7lmUl9D?=
 =?us-ascii?Q?aFeaZ2pLNyxi52EkBA/7Vza2ag/e2/qerwMemrOhfGJSuZEiQXVozW98hzXp?=
 =?us-ascii?Q?eLUd0ZaeEj3FnVlFAS9EvGY6A45RfLA+R6o+pvTfxtbvCxYFcZvx6V0RQJa9?=
 =?us-ascii?Q?w6KI90+lr1X1S+U4OsuPyl1a06URFasxGYNHS1mmDvsrGZCqyDfyD3tOU/pn?=
 =?us-ascii?Q?PzMJCzIuJfUgzQVb1HuPAEioo7hm/BWRJtdt/FsDV7CZM4yS59RwEI9q/IeG?=
 =?us-ascii?Q?5R3l+JZsToZFOaiJDHDiYK+h1NpZ9lRWr67DxiYalhxNOnaDsH+p2qaACG1O?=
 =?us-ascii?Q?DUI0MNX1siaO2IKkCchcHNTnK1kX2lwlkh/EFF/p5+iphCnXTe5u09dlxo0Z?=
 =?us-ascii?Q?4OxsgXnjBgiyWWtYQYiYtKZyHwAe6kWwztg+Op7eqLz9utnvkb183OjVYvz+?=
 =?us-ascii?Q?/qbjmq1hz7zyNGV0cjVxLo+q98a+xbcD5Murq6gBxyV83qa1Txdk+3yfpLhY?=
 =?us-ascii?Q?Wpqs0aMukdiorKYmSzXMpe7b+laVni1UXRJ/U8zquuer10l4BhxMfYdmlHOP?=
 =?us-ascii?Q?awvTLumr/B/EouN0X3QKNwrHsHAGhQK/essJbIuVU+r5du8WqazmLhOeLwJL?=
 =?us-ascii?Q?7TDiybK0LOb2jyA6lt+cgeSn1WCQUT8NeRiThR6gZOxyLzNBQq6+FG1y3rTg?=
 =?us-ascii?Q?BiqqFdyGn4+MHDCtkFH3uGggak6bhVg3Cfx/+3NG/fcYOr9r+7kme26iR7AC?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vbs67WVzVrduwf5VEvUKUwqWO+Pfw5haahPedMxQbawqwBQdcu8pmf4ecsjx0otFkcdnwz/sr72EBE1H4MDTQKkfk/u8bDvX2QnMEHuWlEpLsbyTKklcBFg02XSfhAldh4XoXpDhdToffffbRJjRtuH1hZeLrzuPU1rNB5WfgWCcaO54ZuVGAU3UFLDooVF4e4ZiTK8iEGbrjXPcVbe9uVKsqi4UWXXVo1vL6Tr2GSn2GZekK3BZ+3YNekJuSx+6nlmOgE2+7C4fEUTIUnFkXFZA8Cr/odmkXy3kIUfSbfoja4s8p9ZqBHLzF0DTrutPANutlmUonvtnfb8XbJ43kaeKDKSy+2MXfYucz9rngWwuIHgX8qM4qqH6RmetsAcNdrvPSPSiq1V5Gs+kOnXdoUj4/Ere4fPlr3Jyr8/1WoKxGDwe8npG844jA7Aggd8MtoDV13ig4sG2fCq7ha2YRsVXFOlE4cxcEzsVzQcFvltccvSh/F2nBpmmjrLdNeZcFJAOAvfCuq3pIAqe5ZstV10uheLMMpTzDgBAXvh3GBQ7j6epoUBPBzGX5wMfFyHSKNeyaeVTdIJLKgJGDjUlS+jizdCmCXoc5HpPd/wUCJI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b1a430-33d3-4117-5d68-08dc63ba23b7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6719.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 17:23:49.8299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s5nDyTu3OoSDrof6Zdv441YYxV5AfAZukmgsTMro8cKRxb3j9cTTa+ioMBDl/0vfDDtyTzxvo6kjE9P2Ps9C7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7228
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_14,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404230039
X-Proofpoint-ORIG-GUID: aH7BWy4Ckky4lYJk_mf28ifPo8omU1Pg
X-Proofpoint-GUID: aH7BWy4Ckky4lYJk_mf28ifPo8omU1Pg

On Thu, Apr 11, 2024 at 03:14:23PM +0200, Ard Biesheuvel wrote:
> On Thu, 11 Apr 2024 at 13:50, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Apr 11, 2024 at 12:30:30PM +0200, Greg KH wrote:
> > > On Thu, Apr 11, 2024 at 12:23:37PM +0200, Ard Biesheuvel wrote:
> > > > Please consider the commits below for backporting to v5.15. These
> > > > patches are prerequisites for the backport of the x86 EFI stub
> > > > refactor that is needed for distros to sign v5.15 images for secure
> > > > boot in a way that complies with new MS requirements for memory

Secure Boot needn't be enabled.
> > > > protections while running in the EFI firmware.

And here is the background:
https://microsoft.github.io/mu/WhatAndWhy/enhancedmemoryprotection/

> > >
> > > What old distros still care about this for a kernel that was released in
> > > 2021?  I can almost understand this for 6.1.y and newer, but why for
> > > this one too?
> >
> > To be more specific, we have taken very large backports for some
> > subsystems recently for 5.15 in order to fix a lot of known security
> > issues with the current codebase, and to make the maintenance of that
> > kernel easier over time (i.e. keeping it in sync to again, fix security
> > issues.)
> >
> > But this feels like a "new feature" that is being imposed by an external
> > force, and is not actually "fixing" anything wrong with the current
> > codebase, other than it not supporting this type of architecture.  And
> > for that, wouldn't it just make more sense to use a newer kernel?
> >
> 
> Jan (on cc) raised this: apparently, Oracle has v5.15 based long term
> supported distro releases, and these will not be installable on future
> x86 PC hardware with secure boot enabled unless the EFI stub changes
> are backported.
> 
> >From my pov, the situation is not that different from v6.1: the number
> of backports is not that much higher than the number that went/are
> going into v6.1, and most of the fallout of the v6.1 backport has been
> addressed by now.
> 
> For an operational pov, I need to defer to Jan: I have no idea what
> OEMs are planning to do wrt these new MS requirements, if they will

.. snip..

Hey Greg,

This is driven by the BlackLotus exploit and alike to fix boot-time
security lapses. From a risk perspective it is boot-time code so it is
very easy to figure out if it backports are busted.

In terms of OEMs, it is actually more of a cloud vendor wanting to roll
this soon-ish and that combined with our customers worshipping these
crusty old 5.15 kernels that puts us in this situation.


