Return-Path: <stable+bounces-72704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 978EB968334
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 11:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5951F22E50
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 09:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311C71C3312;
	Mon,  2 Sep 2024 09:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Sw7krVNU"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEEF1C2DCE;
	Mon,  2 Sep 2024 09:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725269308; cv=fail; b=e+y7wRJZUMs6U8XgVpkOO7xPvmivKJiAYr/7aalxjXJ4O8SpdWvrXR8k6B+sk0ZrnWB2STRRCUK1UDmohrCV/ZpMv/UnxAuj3imhswVhjm/0PIbdRT9blD6lpsaWlQe0UWo6i8BK4/QvZ1iRFCw4+1IulfnMvA+jiJlfRKGqQ8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725269308; c=relaxed/simple;
	bh=LKjkTPNmxpjSNEtXEYWAMBiZVRacHMfX+9VodF8zjho=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=TeNIyjGWIbzkOh+zonTp+TLfNec10i4ZQHaXUcL5T2Lvh6pYXzRT8iYlS4Y/uz4h9z+LoxmB7hcC18EYlrR3nUj/p3XJs8SIuri4kGyH9g0VeALBdG4jToTMPXxrov8y9tKXaTNJum88va8sgd5VlJg/DY2os8kjOTD86g6ZWZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Sw7krVNU; arc=fail smtp.client-ip=40.107.21.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o92sxOgCot+pmK8wbgeO0mLzGL5AF9fvIAjfm7R8dTXBAfVcm9B2TjWYOKGXLoIIoM9oxlqn5SjwP6aqMjVfRfqaej3LDtNmLppOzKEjLym7MFx6HGVAt+pMdm75Nr6F3nBApijeE6ky4bbBRnIRBTrSTD0ovRxxLDtk82LsMw+nRbkuvWYoFehVKrP47qI8IbluybfUn6wMA4CdLeE1vi3tt6avTKB1bqwGXk2Nprw6QRRDk4kQMrvin+QqtMmQ5+Hb871AdAp3q9YLoaFZXEKoqEqQ2TvCeubskd+L6TqwO3/HUmIOBO67yiUZHRFBcKRSH/gEnebPpegjNcnpww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUICWzvJXwJuZCt5Zrvjra1l2ZNMcx5ozsN7xGicNwg=;
 b=k4fHt16x/9bbvjAfDI1rbSiWzrpcVc72qqTwWGXNh91xwvHgo1RDp632yskg88+p96bG1hKmi3yOZGWEKJlO19NhDDSTdjnnoxuu6ZYczA7zdlbYJUg0tM0UvFsiS9tBSAWoYDQCypLytTUNUgewny4Kn0UHgA9kR4Plvcopf6/UUXvfOxt1S397GhnjjAIUt3suSuKdVF0yue1j8iGlIwzEEwBIw7vomadQ69Ix8RC0oUQ1nFiTgYnJYApxuHb83p3qHEJ5AU52pUGtzxoIUk4bExoFKvEr3DXW/1tswqbCWX7zLD4zgSv/MmU3toFKEs2cCGr8/rn26T9k1645EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUICWzvJXwJuZCt5Zrvjra1l2ZNMcx5ozsN7xGicNwg=;
 b=Sw7krVNUA2Os1CvXWg0D5KsgfJSMJ8v+Rku+HTO2FL54T/pT6u8PmsVr0SY2yytTyZpyDq+wGKl4CTJz699H5U2SBQ+gbLaNPpZxv2uAPWzSW3Koerpdye/8A+LXA/hp47pl4di6NFP3+0nseAk5Zsa76OQQE8tFnVkRz+bF11WIpKpOMcRxiRIQVCc47dDr/nTkWaO6nybymz8B/Gwl7colr3YZ7uYLmlUKnM3f3wURszq5WqRWl6VMPPyzhf3tGQnOxhPej5gjfy/DwH32fox04P7xSK/IsibbzIoU+vIjmbJVs77Fdyaiivpg0lJ0Ry2N1IYYJpnjt/hk+IW5MA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DBBPR04MB7852.eurprd04.prod.outlook.com (2603:10a6:10:1ee::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 2 Sep
 2024 09:28:20 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 09:28:20 +0000
Date: Mon, 2 Sep 2024 17:27:11 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, peter.chen@kernel.org, sashal@kernel.org,
	stable@vger.kernel.org, hui.pu@gehealthcare.com
Subject: [GIT PULL] USB chipidea patches for linux-5.15.y and linux-6.1.y
Message-ID: <20240902092711.jwuf4kxbbmqsn7xk@hippo>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: SG2PR06CA0246.apcprd06.prod.outlook.com
 (2603:1096:4:ac::30) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DBBPR04MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: d367e5c8-1271-4c2e-7f68-08dccb3195d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?awPJqzJ8hP8tntlR5VMA8QY1OL15PkiL7gUbjOU7yR9tuSjmeQ1KtB0njXgj?=
 =?us-ascii?Q?j9eJIgu5BD5lJna7HjhBZagW/K4HjyaxDHw2cxsZK/CbYxBrrJnCT23Mq3GX?=
 =?us-ascii?Q?RS8mDVruCVSqbe0CtPO8sh3Y5vTdoa2q8WJnYDIrIRGRmTC4BIIi1C7Fo2mo?=
 =?us-ascii?Q?7C+5TQZAS+0Gz5rEboCN2A9uEMitarcLboCoayDddDnrrhKNfMLZTWkpy8GA?=
 =?us-ascii?Q?WKnzzNgzpX5cD/Sa46A7zmEFMV+rCBLzcAL8aXfkMCR60QreSXCbhwIkzZSe?=
 =?us-ascii?Q?+oyrMLtVxrmvB1YED7uqajjCNJt1di0YPyuQPVEDQxPjM4HreYAQz5GHjGOr?=
 =?us-ascii?Q?4Iv3MpTxzawa/OkeDfdGfkRrSG2V7gRetrxuW00rYZNt4EoYsB2Y4PIBtWLT?=
 =?us-ascii?Q?2RDdUX5UCvp/bt1D6y9azMV8TsH+BPTxyMf+flKY02sqMlNXyFI3Z7X69r+k?=
 =?us-ascii?Q?AavP3RzzNvdH9HwQKxrGr5jZJBO2ajN4dSwJKI9jvyh6hQ9TgMfqx8uHtDBG?=
 =?us-ascii?Q?jDCsVJ7asb+hJVoAj8Q8x8sY7/OGVqpaeeAalmTPcL1ULb9S2sCfsB4BepBI?=
 =?us-ascii?Q?u+UjDW9vGQP9gVewwmhIrLKHvoW9NKFtosmPKyiVMSwjupskOgOf7orazc6k?=
 =?us-ascii?Q?3Gel3Q45U+gIwlReRyVh/NYPLQvAsQXogmrw5gU68ZGZduD3ect9oEUEdLKc?=
 =?us-ascii?Q?kVJm9PwHuMkcfvV5g2tERhAMDUEuwcm+ShDtn1JAN/zbN2m1yG89q2DwQzuP?=
 =?us-ascii?Q?jphuKhyR0g8SAhR1u8b3Xy/4mZgbShNg8MERTS2kXQaRwNHdnzbNuuMUyYA/?=
 =?us-ascii?Q?ENtwwZYqWW/5Db5IjzC4+Q0leUkunfigRAq+jKM7vY/InArIVSOZWlj0xvPk?=
 =?us-ascii?Q?32mYxdf42hvmvzp0eiWuRKJyI9Zty8goWEmqDuJi6kk3bhwzTTM+qvZ4qAnX?=
 =?us-ascii?Q?coN70O9HwGp/voAy3I973OSWeTKGhozCprjzKNMtQHZQnmJZKGlO2GhJkhzB?=
 =?us-ascii?Q?OCbNMkZWcCk3MUyLhWPWkgPvzH0GTodJO35rlA3DVhgidmS5MQfrL17Gq7F+?=
 =?us-ascii?Q?H70Ftem6d+FedGP0Il59PGf5BCqroaG8F6d1Qa4Md3RsRAuRtgYZ1gXFwD/9?=
 =?us-ascii?Q?0lEqZjHgcVyEKhWshjvZvhOVPxtARrS0UXDZS08/tr77FdB5CX+fXHazxrgX?=
 =?us-ascii?Q?FHulyA811+6wFYHVRKNmn8tXMleeF5hzoiJ3Oe/KkmyaFKMqVqNOFcnhnyys?=
 =?us-ascii?Q?DY/jEe/OR9io4Gpv8B/pC0n9baLghNVXTARIpHxskFeouuIW+KsEvNOEJLYw?=
 =?us-ascii?Q?b1M6/3eRaWgGNlRIGUey7tm5mq62DPUWyQj+dt1cH+km9+XWihRY09iwRIkG?=
 =?us-ascii?Q?ffnn/SSs8v/GfZ0Qib2TuizNLKXmd48TqM4S8+o6HLI/v3Edjg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xvzk3ZvQ1JJd5M5mjheOEGwVoDOxoTzLPq1IXNA1I3Fcgu4ZI6O49Gfdq2Uu?=
 =?us-ascii?Q?AHF+K2t9F37SgltXT/2gT1684W1vbRo8Byp72xlcE+bxmHqBR4q34n5mGSL0?=
 =?us-ascii?Q?oDS2cC8o7Kx6IDdMdWdxQ26NScSZ05HFJHcR5aB3Bfi8OxrqIO6xcvlfQpOw?=
 =?us-ascii?Q?3Suj16bsLpaw3drKTmCdW43PAg3P7PsDq7cz/JPjDqfNs6YblA7jB6awLh9C?=
 =?us-ascii?Q?l/hxu05maR/goErzZl9aMZcO6WQHReQPvrdgfZhh4IYKf75P8ss9DpVbkb5I?=
 =?us-ascii?Q?zCOnRir+sWJRBgePrIbbKmYy2eiVBW+BzquiylCpMLgOv6u38rrfhKr7Czhk?=
 =?us-ascii?Q?LtG8Hn8i7w4vlWZMADYIweTSUtTxVBRmE88sJgoL8m9AhT7o4ic9TekZTWlO?=
 =?us-ascii?Q?lzyOvbjxRg18NesoYYwuGMz69JsC8Tp+mrR90jVrss07CRI3y9KGLf95DHIl?=
 =?us-ascii?Q?BgclZMyy8P8pLv12iaiNVkLwIa/+iGIMzUKsc7R3iYGSEyngkoUYwU2vLX4V?=
 =?us-ascii?Q?bhpHXyXczk1hPmcI2fyaDiboYP97HGgobYiLJqJPkcl+ahcTZNHGd+ePs0AF?=
 =?us-ascii?Q?vSmkEJ78sK4jhPh7jxFAufhNf5+gyS3mCAu54HhkXWj9SA5XrvA1q3Si+LhM?=
 =?us-ascii?Q?rclugK589haSbVXhz3HEVxTdV1+WXQKeu7e3SM6rafYOHLGx5TYiQHqIlMrv?=
 =?us-ascii?Q?v3wmsCsqeaGoNIgwiisVwO4CS3D/ytO0duW81PSUGrZqZJPZlM9QD+fQlEo7?=
 =?us-ascii?Q?D0LVMuPujwZZn2mZDJFvTzb5Y+1uGRbyR9MSh48jpNMwa7FSX4x2cyvrCHu2?=
 =?us-ascii?Q?gHfyHXA7kZw8qqRn0pKNhnuv+jP4pnldh8odHzNJE29kzzoJbRA2QVtoE/Xa?=
 =?us-ascii?Q?C2u23j/GretN7KLzOOEPeutcoEl3EXXTrixj5iNW9qug1BlXSJnhto+DYvXe?=
 =?us-ascii?Q?Vc0g6OkvY6gS+cUlejOVPnQKqGae8rnNkiWp1aqQN7HWMlMyYVz8ITE/5juD?=
 =?us-ascii?Q?CAqKyKvBQiGfghhkxvAacYN2LhKepZoQvT1//MNefYmM9NzxtD624ozcHCS5?=
 =?us-ascii?Q?VoWBHGhC7AAYDi393+AHbdYpC+5KOEpWSDUlvDOOPU8hqW4sc8D++gpvBAMX?=
 =?us-ascii?Q?JW2wMd0C3fzUkiBNJXg8y3keR254WLeYBl/QyMmzT/Fcubbnci6T+zjB/qIV?=
 =?us-ascii?Q?TeoTn7k4A3p4E8PD/58vMUB2SJG2voSrFADdOragtQw9h43QF5vLLLPrtPL8?=
 =?us-ascii?Q?GEgjaoClLGlQEpT7A2PK3/+Oc1w20b85egnTQQ4rRtTz/LFfblpiB19Nj7JM?=
 =?us-ascii?Q?PFZtSaIl4X282EE4/CKoLe2hnVf13ko9W3oEWbHme0oKJkd0XGI/KxlhHpQP?=
 =?us-ascii?Q?kjjVZK6SzVkxwE57Z4T9nIa3SGQXDKIFz2a9uKlFHEREKh7zMX83OZ3Nhe3y?=
 =?us-ascii?Q?IGdedUpQNiahKEYlpb8sDqAsUUrRS4Kjw2+smjgmbRfn7tETRGkIAfNdQepw?=
 =?us-ascii?Q?22S28Duug3NevRQ2xnmFXq35lVWQOZo0efhv/tCsGbEgr7u1oSZQso3rcvRq?=
 =?us-ascii?Q?VT16iBa66N+VerIHXRf15y2P5m80Xs4KkrUE0PNb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d367e5c8-1271-4c2e-7f68-08dccb3195d5
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 09:28:20.8492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hsVQRAVh0pU9HlnZ9olTupcODZ65KWLunRnNHhHY+3NLpZlUgTjHesz9B1LxHOqCEWlx/VJy9rZUlWOBl/0F/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7852

Hi Greg,

The below two patches are needed on linux-5.15.y and linux-6.1.y, please
help to add them to the stable tree. 

b7a62611fab7 usb: chipidea: add USB PHY event
87ed257acb09 usb: phy: mxs: disconnect line when USB charger is attached

They are available in the Git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git branch usb-testing

Thanks,
Xu Yang

