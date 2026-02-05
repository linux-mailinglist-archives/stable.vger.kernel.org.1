Return-Path: <stable+bounces-214568-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MD64ELoVhWkh8QMAu9opvQ
	(envelope-from <stable+bounces-214568-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 23:12:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE014F7FF3
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 23:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC9113019FEB
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 22:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A105335074;
	Thu,  5 Feb 2026 22:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mUKq3s1E"
X-Original-To: stable@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011057.outbound.protection.outlook.com [40.107.130.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D645C33509C;
	Thu,  5 Feb 2026 22:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770329524; cv=fail; b=nFQXhASv02GbhSxUyi4uB98pi6axty4Q+BQNEinKcaXHWF7E5DQ5KHkrmc87PPYg30UeSepLctSFA+oosw4UQNtiIFwJi9c6bcqhp8g3n+P2+jrGGCIa/vy8DGJ0vIlplorUKmc8mafTnHy5+aOCn1I2GOexx9tFvt5eyBHhqo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770329524; c=relaxed/simple;
	bh=wJ/HoHUda3HLHaUNE+zuWtKffasv1Wn8lSSwLf+GHFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ORQf9n9GYUCnmpjVOjzGEHrLBqvUGQfW/ALq1hTWDqegcwQ/4XCgla/szsU/JlbQThWYKM3edH6QijbFKYpIjsp+w4nfTWQ5NPpqXTjTTWB+zqShZdWLTvuYIjOWX1tguI9U0h8Y25jtUQJICZyF+bVATWJ1+HIKS+A1l9OQBxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mUKq3s1E; arc=fail smtp.client-ip=40.107.130.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5KHUrvPXM73Yjq7JlauPpxcHi1e53QYZaPhx1QZu57DUdGXVcPEi+RW2iFQcLXfraSe+VKN388YEY9FPlAfsO5acj2Nj0KCLaJkuxBCOKRYpDFyka6M8pm0aOK91s4FBZJA5TCkd0VFroBN4n9OWwZte9kG9kuhdS/81EufLyBVOb/M7zBFo+aphXnEboJ69UIijq7vvEVVXBOdlbg3G8LjLa/U10haRct3/RC05cG0N5e9hseyNj0T3LooITCqamaQKtCn/fZQSqln+BzBLHUvg2lQa/NKxNJAv5Vx79yiDksRZcZEFnDV/S1a/kyxOS+Jx7n/Daj2A2nOocmHHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7y+883KyV7imtyzdYzvGFP9BTP1z62Xsu2xew84/6YY=;
 b=qggGuMQzcV7yCf6U/KZHUhugwQlDqQ2sTfDiylZJh0LlHZXLOJq2aq1PebyOk7SMnzQlnNHWAyiZxKLub7dZVpLjfXLT3uMIoIFrLlbkOzCb9Cf0YXVahHDxm9NRhtmq+b5pWJtb3tLLexabUUah9tYJDHOb9W54+4fDeXqiaj8Ol2uZtwlB0h/Qvz568lBMxMPR81OCIr5KpKgVIYmjRU5HQGdDiF/0qA6I1OZ4zLK7+y+ZmMeaAGlEX6m1DRl91vu4tqKBxAvxPilNLxOg/HrouKErG9jTysUFRD2H+nnv7QHq3nKISs0fH4pkMsh1kQAkm1R7w5hq3n4r2KCLcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7y+883KyV7imtyzdYzvGFP9BTP1z62Xsu2xew84/6YY=;
 b=mUKq3s1ENJlb1PXrPgDf72j6uxp3a14szERryL0PbFwmCgfmF9yDfDIJZhd0MTe+rTuCan9hsuJwlSarev2yL4Gh2PDOwmQRwWpxFsgwWeQtb8JXOXANYtI8wB1BzyxNyQN5nFEga+73bTLbKtq5B/AqAXxMdzsUm72A/PS9NzMUWU0kjRZ0bWC8XQU+nPedDEhW3nlBtCYQpHyS+1q5WMSL44u34H5cmuRIIkDRycdHztwKiUU43HRU9Dwo0SrLXpWN6NWO+PGVmrZcb4ztmWLEPjy+UjoBpxnTFYmA1Hep1MyQZkbu1SArtA7OoQK0NrewcrSwaOxaY2dyNjXpvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GVXPR04MB10517.eurprd04.prod.outlook.com (2603:10a6:150:1e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 22:11:59 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9564.016; Thu, 5 Feb 2026
 22:11:58 +0000
Date: Fri, 6 Feb 2026 00:11:55 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Paul Moses <p@1g4.org>, netdev@vger.kernel.org,
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: Re: [PATCH net] net: sched: act_api: size RTM_GETACTION reply by
 fill size
Message-ID: <20260205221155.na4qrsuuuzpqo4hg@skbuf>
References: <CAM0EoMnseQw6H+a4wzhg7BkPJraFwN-=2x4FOSOUp5f7=XbyaQ@mail.gmail.com>
 <tuZof6471icLlkjecTuMCBxpZ5zJVhOeUv7lAK7MFwt3g7LfrH7ZFlbE5odrcbTFUukV6J8Dywy9daCrLI-kiY-_vpiABXStvdudLw-HXDI=@1g4.org>
 <CAM0EoMkD=3aRFq=tXijcop5tYsD4X_Ki0REcnj3x+w_C69MaFw@mail.gmail.com>
 <tRA-1eVt0Av_cRCmND6povnCqYiBpaOoilgpCM2qNbo3GIe6szAEIN1mI20gRjgf215ODBQJBfolBlBzyJ4en67AQVHhLt6QmtWlQUjLqfc=@1g4.org>
 <CAM0EoM=T4QiGB+_3jqWKYze_OrcsjYBy0UvckTiGtHkxSm6BDQ@mail.gmail.com>
 <JLZxnCN_V32FjW6UUERYLlLtbbzDCDUmB3LOJ8ovdzV5pbUuGMRKi8K7ebh1j2yDt1u3A0pc1y4Zjjsw6-c7zucKHasFnfvYjnZ7hvT7aR4=@1g4.org>
 <mFDC5blKe5Rmv7qtNQvSSWDJsCdSd_lgeq681gEcHlSg-i8Q3-ZJSDqZfQV4xWFou75jYXgndoO-OE_4-_JNxPtT8rOdAguM_Xwl-qX8B6A=@1g4.org>
 <CAM0EoMk75BJYQUXm7FDW=ZmRsUqib3L+9tEAL90q_+DreroeXQ@mail.gmail.com>
 <20260205203615.t3n3bbqmjscp2cnz@skbuf>
 <CAM0EoMnUm497YUZYbrYeqecF6JYzFbjauV8ACf-h8pjgOd2jdg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM0EoMnUm497YUZYbrYeqecF6JYzFbjauV8ACf-h8pjgOd2jdg@mail.gmail.com>
X-ClientProxiedBy: VE1PR03CA0035.eurprd03.prod.outlook.com
 (2603:10a6:803:118::24) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GVXPR04MB10517:EE_
X-MS-Office365-Filtering-Correlation-Id: d0189d88-9b5e-45aa-637f-08de6503946d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z+S/W/4MskTNMxdsXCgWQ7QOdvK6IAKhCxqVRxLuZaG9AJvQAaApBXxuW9h1?=
 =?us-ascii?Q?tHEih6lQVUHxpwFNAMOO2D9EAR0sPQKFkhtxYnRsaBO/P7/5dc9lkJk/3Lyy?=
 =?us-ascii?Q?WQrG85foFOxjn5pTt0R9o0Hb42MGvidETA4ocOB8O3TRR3lZRzt3Tsk9Bgih?=
 =?us-ascii?Q?4mHrBsEcSLBQkzYmx6hZTYMADrdGl0OyWuxf/kb24FnLdG0wFjWUsuWyyZle?=
 =?us-ascii?Q?VmKQlkefAO7OXQAx8EviHOVbfyRWUkWdQZnbVQcnH+XByQPYrFV22lpHmppL?=
 =?us-ascii?Q?Jb7CL9CQ5mDkUdlSU5vn4FhVZc2/DVET7kaAICUTJ1x7gQOeri+xwyf622vV?=
 =?us-ascii?Q?08QDXxjdiaoXb4UjGp6JWy/RQ2M4uBOfhClB7isgGDPMLRfL7Y9o0Nn1PaIm?=
 =?us-ascii?Q?kl5bYqosTOWNXW9YKdvSYCRBOFujFmrizXXGVawblXtgxLzUF0TnflJ7W500?=
 =?us-ascii?Q?p++Is72WoQmOJq1cyKjs6NLrsdkHnP+CiFwVqYifdhP7E+Ng16/i+SzcKtQF?=
 =?us-ascii?Q?CiopQCZKBbLsUksUNpboss2OuvSM2QrsFBMMmJbkCF74Wde9lNRoTSlqbJy6?=
 =?us-ascii?Q?qYKRHvBAYFNZpbj9chP8yAT4QLI5VjXdliBzKgTKVfYI4RUkHc0QwTbS6nkq?=
 =?us-ascii?Q?nmwDuURm5IXFW9JzORlcb8wG9SMbw+KM5bPoGVWcoGgwnIQFSkoSqqt6PtNj?=
 =?us-ascii?Q?mvQMa1Hw28mK2zD+qHJXIPp4mP4mdEAP4e/VFM/kx8+vKBthVZ3ddYra5E83?=
 =?us-ascii?Q?91Te4ySQiVvLtqGJehCAM9hbvtlwLU6DDejDoinRoZ8yo6x27xKBZl7MisCV?=
 =?us-ascii?Q?PcRyg9Oka1xYbUcwQ21fWjsDc62sOuLoKeLqlvMJcE/3F37n6TX3t/HRfAcR?=
 =?us-ascii?Q?rVcZrfmymnNTZiQYc/es3ZE6ivl21l+aAwF1Zkb+9fNyHrXMtBvcqazUt0Dl?=
 =?us-ascii?Q?eu0igfDgGXy5ncuieww3rEqywcMZNTSMnFjb46WacZ4e+HtEGd02aXKCsQ0n?=
 =?us-ascii?Q?HnNnfkaYim6SE/hS0W9TEDRYfaNlhnu59YxvWgh3/Nm/GR8coV0qdO8QEsCp?=
 =?us-ascii?Q?PGMyKYh4mO0Xb+IVbTAo8yJHESwd/7fRL2NodKzf1kFIlopGaCCeTV5weWyQ?=
 =?us-ascii?Q?tFMvgNJk3q3o3neSRJ3vxFvvAUlJFiJD9uRMlDwKUkBTz3QnworjpsFuDI9O?=
 =?us-ascii?Q?F4iPwEcGqNvqKmM/sdEx1ylvHBZ9/yEutGRrttN06Wayq+caz9HJOBr0ckB2?=
 =?us-ascii?Q?nA/Aq+pJ7yQj24CfTTvkY4a7eZ/KmLpWg/0oU3JVQ04LgymVhVjSuWWepzy6?=
 =?us-ascii?Q?S7nHwVK6nJqyeBCxrGKT7zd3PmjLJCy0qQW+rPgbZ3U/fpBWDZBsM8umYG3I?=
 =?us-ascii?Q?b0/8JzzldW2Ly6laW1HYC4tPcSIHgKrC1Eqe1GaJQ1sQCofxCcngDe3ss5Ns?=
 =?us-ascii?Q?MULjfxNiYezviV/C5yXHn8xSzailhBWRW5cai4XWpRcp3WBwNu7L3JXBH+f2?=
 =?us-ascii?Q?Quk3i2BjRyKa0j+0e0V1bwyydMQPe1UtXKhZpA9/8yHbKVKIOatBElAdSFWI?=
 =?us-ascii?Q?MHKOZRdW6ber+fGk4rI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2lRJIuudCi0+fvN6jehi7z2Y6NnO6zoXfhileFadM0AzfEd+KSogbu73OGpY?=
 =?us-ascii?Q?ht0s2fq0zJkBkIDvh4tYVeCt07iJwYTKE04SI9GEW+mLLjCvCeZZpL9fUnoS?=
 =?us-ascii?Q?kXyPYsJJpvxNOMB/ruG5tpdhJ67wp0PasP6ZJRDm6tY1TP7mLsuGQaq4jm18?=
 =?us-ascii?Q?rqqUEnb2Jvlm6khyMgiutWAub+mCSe/Rzb9gP+Dky+tHErex1RPwf1zdvrJG?=
 =?us-ascii?Q?aTQn5ilUyfIrp3AifFIH++Accxubg1Z4c3QafJAHnucFPTdtxRhlPNMY6Xuv?=
 =?us-ascii?Q?lAkuu6XYgUTkqd0DiKfV99bZvxUEIl22B6v0/1zmV+o3Pah4TDri3axxmYt6?=
 =?us-ascii?Q?h/rF8RuLyT8+foUJEbsAxcEYHsAIRIss7PfVWU/FCADSSGE0FUDqKzARKZhH?=
 =?us-ascii?Q?tYQb3SEgF/ItAoWOxs1Ht56KmLndJTBRvcxQSC6iNGkkgfEH7QSGBRkhriOL?=
 =?us-ascii?Q?iKsqzop1Zi+yM2JuE1y0vqR2Rxu+nXMk8j/vjay39vbatZUjHKijPIsPCIhp?=
 =?us-ascii?Q?oulrDjdGG3bnrZdckXv+NAzqVHcHVmSQR1InN55b+2trDFG1fwx1/T+O87M0?=
 =?us-ascii?Q?DF9ZgYbbQgrAzBaRmst1Fw86LH5/whCQnT3RG4ESlXC1Cy/zHeU89lqPcrE3?=
 =?us-ascii?Q?JSopT+/wJQlAlU8nFRZjVoBtO3a8hYyLRHzh456NSASht/LlLcn9TaoLMyAl?=
 =?us-ascii?Q?vDOBvMLIijZVpBQlpG1Mtsez6OilvJKQjurUkOznKX2Yyb2mQCl7MUuTFx52?=
 =?us-ascii?Q?fxcQqAI0LVDVFlhfJPWeevNi2+Jcif/FiA28kMJLjqLwYHFvGDWfH9Il06oh?=
 =?us-ascii?Q?2+qxOTuUvy2X0D2vv01w7LcjQChfAXovCh39DysIie2Ecav7OlpsBkHkILHG?=
 =?us-ascii?Q?OVSBF1mJc8svjmwu49ORZY3/tPkdkkv0w1zN8ORz/5r5vLZM25tP6y48QOru?=
 =?us-ascii?Q?hvS8Bqf2MM48qDlWCY+xAQ5ZFuw4Ih0GsBEkGbbgFz2UsLiYPqBfX6Y/R1Ft?=
 =?us-ascii?Q?N37aiRiJXwwQiJhkD0PPR/KSeBbdWTs+CMxzpXUfva+JQc3haNJeBA6QOhsS?=
 =?us-ascii?Q?9zsDDO/9JU09k6zMP5HLU74dwgCKuX3vX3PLgHHXoXRWiG+egTclD3pLY/SM?=
 =?us-ascii?Q?zvqZn7KZzMTObZrGZOEz14tZv7h2DBX4MoX6Cry6iPT9Bk9UQq5CTTYe1Nm0?=
 =?us-ascii?Q?ISLeiCmzBcz9wtJzngzGQmcZmQMdWQ00+LJhncGqs65Q+nQzK2CGc1Gcz90N?=
 =?us-ascii?Q?9enyvtIFMJnMk8kMiPzonFulgThwWzCTaOdtJH0kdfdeCXMdqzGa7zhvas5J?=
 =?us-ascii?Q?PFPZYc9EzSbueRub5QhSC0l0F29/itCA4p8UKotoqAwxjmhbEuMCb1lgaRgC?=
 =?us-ascii?Q?xbADVvE5G/hIe85lLkp3pC56mNWHuWMf8NlvcRh6Qb2NogMMrJmYjovhRATx?=
 =?us-ascii?Q?oFDGMA8FIO6d94cRxNzIIJ8mMfviwi9OSDuOYa9g4eAaV9XbeizZW7f2Izpe?=
 =?us-ascii?Q?N5lrlnJ6C8J/FD32GrbYFaWrlTexsKrfv+vaGoAjw+RBpqXRydfqY9Rp+rgb?=
 =?us-ascii?Q?tFe5Hle8nLoH7TyYA5SoHq1q617cwfsbqKoevvUze0ix8gcZD+V0Op84XL00?=
 =?us-ascii?Q?Mz+oK4eWdULof9G35mwoB1208xe4+yDW/grqREGcalvyG1LsV0TUBI3QBc/W?=
 =?us-ascii?Q?MTNW2G1LqWrfUQoH1cKb4ZKNQzT1+GAl84iCqFbP97428teaNuC/w743StDu?=
 =?us-ascii?Q?mw/X14dAWOogAXjDHdaYq/aI/uibVxu11qCNzK6f8hXkj75aLWArhlfMZhuz?=
X-MS-Exchange-AntiSpam-MessageData-1: YvKZ2DSQZQVcIGtYtIRrCaasBvLrKupZRRI=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0189d88-9b5e-45aa-637f-08de6503946d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 22:11:58.7591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUz8SSageQWIfR6dufSlJkIOX9NX4SGdRpcc+2MFXhjc7Fi435YRXf5VbVLJ0zLi/bY8o+WO0FA/WJxIuLZjNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10517
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214568-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[1g4.org,vger.kernel.org,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,intel.com];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE014F7FF3
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 04:30:06PM -0500, Jamal Hadi Salim wrote:
> Yes, this kinda answers the question: we are looking for something
> that serves as an upper bound for the control list.
> Does the standard explicitly specify that it is arbitrary - or is that
> deduced by lack of mention of an upper bound.
> Either way imo  we need to have a "reasonable" upper bound in the code.
> 
> cheers,
> jamal

It doesn't specifically use the word "arbitrary" but it describes a
mechanism to indicate what the arbitrarily chosen upper bound is, if
there is one.

Specifically, clause 12.31.1.4 talks of a managed object for PSFP called
SupportedListMax. This is supposed to report the maximum values that the
AdminControlListLength and OperControlListLength parameters can hold in
this particular implementation.

There is no intrinsic or universally reasonable limit on their count.
It depends on the required schedule complexity.

