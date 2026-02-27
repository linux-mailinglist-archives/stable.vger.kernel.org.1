Return-Path: <stable+bounces-219888-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OnoJD/0oGk8oQQAu9opvQ
	(envelope-from <stable+bounces-219888-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 02:32:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF0B1B1838
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 02:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A4D430910BB
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 01:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCB9264612;
	Fri, 27 Feb 2026 01:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GtwbXpUD"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013028.outbound.protection.outlook.com [52.101.72.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5F021ADA4;
	Fri, 27 Feb 2026 01:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772155919; cv=fail; b=HQLIXQcK+ICdr1FugvvLKuAyysBgtUxOhhGvRQM9+i+AJ5PajtRE/QIiI8stfjB9IwR1BbXr8EF8TQDfl16FglhOEAHIuicrO78V2+9yeCmqkXyHK/iU9XWSvHcmSXLUno9j9wtN1iLg9KWGWB9O2XWRVdzZ28vuErMLu5cGl8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772155919; c=relaxed/simple;
	bh=bs+/Kjpj0D42QAylqmSF50WPkGlum3Ijt7C2lc80NIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f1d27xtYKk8be0AV0FNRM4ZHGhQ8fToIbNSiuXYj5Bfdvid/yvbgKDieHclU8zdvU2eBKvNog2YSwhZJDy1HJ0jnQQ9awk9YSwGfAoVapQ83P+eepiu6vtDIb6NZzNiJEjaCMoXALhc/79WW1Vuuv6n7CyAvX+XcPpWI8Ew4+W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GtwbXpUD; arc=fail smtp.client-ip=52.101.72.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qn05KyLu4MnLwO3Hx5Q4Sr5100enwDuTsoRJAVWjGmzaJ7d/c5eVu9N+RkJN5+UcXZLCeKGzVpET4RP2bqAuuEi9F28hJbDh6t2/BeUmDYzMH6PQTuKlpznPZa8CMAmu6RTnqwcshHN8BlqH2B4IN2bcyrQnN31m3QLhUTOsO2OqgD0L9TI345vyYxQMMKIcmWyaZkpBxj3CE8koV6LCrQCZuiBcgI3GiZtn22hQ61MQfooDVRHoT6d8eJs7izUV3xL3xRS6doHxFCN7BpTUL649ThYtry1UoT8V7/GTULgCnr4P2pN9cVyrbBo7tWZjU34yror5uD9iBgenvM+tKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dn6XFBJ4vGUtFINhHoiWQcojKZgqBCP+S4/E3N++9k=;
 b=ZdywUnPXgq4tKFv53qegw5/6gZhfYz/FgZrxqEefgAsCwxEzCHxm2PK2uLK5ppBiiSvY0EP6o1BK7dLJIkXb5HPkcoNlDgplkMlCwaCTNJlLTr5aDsF9Em9J9uVItzpU8nz2QvjXT3ClnhYIcbS9JJ8x0uNI+7a9S9xccozUyJQXMEI63O3IjjNLu0hGhKSb4WBxdzUy4zKvhSfhFQbRTJcq1B5ONIBZQnIlZic2deY+kCmk89BwJ4zrgQpqzFs8e2buyGNBhgThJXl8ddui5obNPEd7no4aXKsBuML5DSjZEOq5AYU1LLGI16GMt1cvUESctlilzProuKQBbcUKzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dn6XFBJ4vGUtFINhHoiWQcojKZgqBCP+S4/E3N++9k=;
 b=GtwbXpUD9mgeVqLS61qnbLIOFHcitHT0spX6IndPSlKxWQNs7g78d20EbmfTBd2rndYlrGPqo0Y6N3Fow9FUpuyB6MMdz04Pv0PZ4qKe7fl6QTjUHuxuZYQ5ew7EIZlh7MIydzHcKuj3iVEmRGZIQ4eTmA9hfFYGx4hQuFLCcSbFUTpi9bAO4R/w8Jz+G/XCoRa1WSjC1+kojTvSPIMLUkdmwROIpk9hOhuHExUWb9+fm2ItgOfOwOjZAzIWpgD0G/bFGNGLZhT5AHvlcsjR9vjgojb699uRwuua7IpKGqhR2SAkPFDjzeuCELWGaD8LItrwlb1lkYSoUDWzsZfgeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI1PR04MB7101.eurprd04.prod.outlook.com (2603:10a6:800:12e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Fri, 27 Feb
 2026 01:31:54 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 01:31:54 +0000
Date: Fri, 27 Feb 2026 03:31:51 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Paul Moses <p@1g4.org>, Victor Nogueira <victor@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH net v8 1/1] net/sched: act_gate: snapshot parameters with
 RCU on replace
Message-ID: <20260227013151.qaw4hvb4fyt5roeq@skbuf>
References: <20260223150512.2251594-1-p@1g4.org>
 <20260223150512.2251594-2-p@1g4.org>
 <CAM0EoMmr0SUf7U3CTqd=MSYX=D60zYOfBS-L=GJOsWB-cxZHcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMmr0SUf7U3CTqd=MSYX=D60zYOfBS-L=GJOsWB-cxZHcg@mail.gmail.com>
X-ClientProxiedBy: VI1PR06CA0128.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::21) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI1PR04MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d2791aa-092d-4f10-9b35-08de759ffd1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|10070799003|7416014;
X-Microsoft-Antispam-Message-Info:
	MgCe1LE87t8qmj6OwMJz1e7GzZqJRq7ZmEjBg9IAlxfIZcC5s/UtdJp9OYdbAN35LrAdNPtHvFI6nE+Z9cG/7yDjwnf3FtdT7406DI+8VNE1lRIshP7GMefhasOObU0of6TRYHzgH7wip00bo16sbrOr508oMigAmGrBGGnupFOiYJdg6tgvS1K16ciA4kzUfu8s4FEg7AxMvbQ0Rfs1VsELWgg4/V2CCY34e2Tb4irn6FAPtUDPn6ZLFRzAHGM7/C2KFv1XG73ca8N0K9OYte4C8Le0Z7Uu4ie3FjD/YpI0YHo//exiKYpQ03zBVm1HMrFmPYwzB0uuCK7/uqIURGel7aUx6rWW4ESHcNqTGiqejmiDtcX75q3ewroscQG56VOyccyW7OFt5xxROHdvYzYUIy82XgbF/6h7CGJ5I98+HoPRvk/PdHDLpPjg1QnxWi7hJVqEcRdqaCxTWkPYuECnT3SIljZK4FxITZ/riJdGKdkY3fDiGkoSg6CS72qYxRGPJAMuYyDkMzIX97Nosn7dXwykPJrTsGYSaA048Bi8g6nCTKaMjUb0gwYm3ge4h95pxSZAVDcG5kGs3co0QImQYoiKIJO0V/NqfL0LsRcRG9LBnMeOP8o1eJtYS/D52SkU/yQfHY387qHogOGShvldsvEkDjkNTOtvopxPca3rzBhLZHr9gq1L8Q6u8c8N8/I2QY8ckMjGkGBXQP8G1OHF/GqtVZKVakdWul2FbOE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(10070799003)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVZoWGYxeTNFZnpOTDlHWnZvZ1I0c2pXc0pYV3BYVm5NTzhyU3RCN21HNUxr?=
 =?utf-8?B?bFFvZ3JzQlRWQkQxMUVPQ3I1ZTFVOWp5TWk3Rld3bXVEbFZlWTVzR2E2VjlP?=
 =?utf-8?B?YjkrZytQTmNhVkM0UjJFQ2V1d08rSVN3aGlGZVRiaTBWMjMzNWExWVZQVW5k?=
 =?utf-8?B?S1ZISllXREZzdzRObUMxVC9QS2N6ZUUxelR3MkNjcWJYLzdKNFlLcis0Rm1E?=
 =?utf-8?B?aEpqcGcrY3BWY3ZPajQyQmxNenVvMGJoNGNoeFUvWXZJWVlEVTVNbEdRMlZO?=
 =?utf-8?B?anNZZnNWTmdjUWFaL0g3OEw0aDdIaFlsNGd1UWVJV1V0WFQ3NldoVVBoblV2?=
 =?utf-8?B?eFpRdDR0M2xTWVo4eEZSUENDSjFWM0c5WnpwaWcxdktVWlExdk9wVW5TaTF0?=
 =?utf-8?B?L0swZEpEZUZ0YXFyeDdudTcvcEEwNW9BazZIL3NzTkhvNlM0RlN0U2hGSVRw?=
 =?utf-8?B?NHRhUXZ3TmNpTjhLNkVxWHNXQ1k1SzBDTVpKbzdFUUJDOVlqK2tDaDFrdzJK?=
 =?utf-8?B?OHRnY2ZXU1JPRUZNR1FoQW9sZllINXZzVXFpWG9hK2Y5ZzBDNnZBTWV2YTlQ?=
 =?utf-8?B?STZJcWxITkdlcld4RVFwbG1WdHRvOGpCaERSWFRUT2tTcWtTSGdDQ25zUFlX?=
 =?utf-8?B?dy9hVStrZUJpMGJET2NVUmJUMldud1Z4RTlYaFI2YnpBbjhHWVMySThSYzVo?=
 =?utf-8?B?YUJSU1RzUFhTd3NWa2xNcTMwRERTc3hjWGpnclNlNFZDR2s2UzQzWlpqNzNL?=
 =?utf-8?B?WWJtU1B6MjBOcGp0cXBHTjJqUm1LNlA1YUxSQUdSWDVkRmdqYndlaUIxYVRv?=
 =?utf-8?B?U1dPbVMxcVlNb1Z0QXI2ZVFiYTRnMUVKZWxBQjF5M0I4T2hIRTNOSTdXUlZ1?=
 =?utf-8?B?OFJGcVdqN3lxRmwva3BGblJzaVd2OTVWTjZsTmZsRkpHZ293VmFWYXFUeEY5?=
 =?utf-8?B?TGdiZEFjbEluTTVDZ0hzVS8remFFajIzbElwRGlobXoramhqZTltMVZmZmQ3?=
 =?utf-8?B?VjhsNVRrS3NSODNOdFYxSjcrUnRmNlRWNnZYbUIxZEpocGhEd1l4T1kva0hh?=
 =?utf-8?B?T1lBWnh3ZmpVRmI5TGRsM0plU0M5RnhLb0ZUenZMK1NWbWdjOS9FS3RFOW1S?=
 =?utf-8?B?dXNsaG52SEFPMXUra1V4ZUZsTGJ1TVh3Y1BuSVE5RkVGL2xLMkVyQngzMWhn?=
 =?utf-8?B?SzNPZURVRkF3cDFYNmowNGNNTEozeWNPaWJ5Y1dWVDB1U1pqUHVDKzdnSHQ0?=
 =?utf-8?B?WlNrNVB5eWhHRThmS0wzeGxUaGloWDJFWnRhaVAycFFRMUdOZ2ZOK28vWjcz?=
 =?utf-8?B?cENYTHAwY0o0Tjc1aTNDVmJTWFJnVmo0TmpmNXdTc3JLdHM3V2NTUHRBemJP?=
 =?utf-8?B?ZXROc0kvT1REMVVZRmlTSXJGTHZyYXZ4QzZSenhTekdSUjZsaDBBam1tc1Ev?=
 =?utf-8?B?bFhrTjc3NmZrZWZjM1hQVHhIQTN0NmpCQzJOcksycVIxS2pZc2UyZnBiNDV4?=
 =?utf-8?B?dHdNSDZRcE83T2dtNDNUQmZjdXZTZGgyYlZNUG10dG9DUFIrc1RtaC9wbjFh?=
 =?utf-8?B?bUNJNVVkRWJlaVJlcTd4N0JuQWtIVjRjUEI2SjBEcklvcDFQRmlwbElWWVMw?=
 =?utf-8?B?ZHdHZ1NjWWp1SUtEN1BKSFI4SXNrTTkvb0g1N3MzcER2UHFGTFU5ZWN6VUp0?=
 =?utf-8?B?aENjVDVxRFgzaVdYRVBFTmdLL2xEZmtTSVpKOVRtS3JzWElGU1pYWnJPWUJE?=
 =?utf-8?B?UDJLd0lFTVF3WTRpUGwvSThDM1JsUjdxa09BV0k1ZHQ3QWUwU2MxMWVWWGN3?=
 =?utf-8?B?ZGVDQUtCVXVRK3BDaDlwNlE5S2c4QVErdXFYc3VEcXU0UkhYMWppRjllaWN5?=
 =?utf-8?B?a0laV01WMTNvN2NZL0d0VGVRT0dsK1hEaUJWNzJwYXdmRHcrZUh1bzFoeVNK?=
 =?utf-8?B?cm4ybytiSy83U1FPbnZVUDBPQnlQamIxRHpsL0N3OWtYYTNQbWVuWDFCZ2pl?=
 =?utf-8?B?Y3VMOTFsZmFpbHhEditlWWJCTUpwOTk4MTNaa0FpaG90V3BrMVZsbENyb0pT?=
 =?utf-8?B?akhmSkhIaWh0Y3NZSFJ3MVBuZEF5ajdqdjBzM0ZWNEdOckRoc0twazBrVlRN?=
 =?utf-8?B?VmEvalJWN09sYzY2cHROZ0N6bW9jcjZWbzNWdXhVeUh4UVhGQVBmMmNTS3NM?=
 =?utf-8?B?YU5XUTFMZml3c3NObTZWMUI5bURBUjdTWWN0TzNaa3Q5L0RHL3g1dUpUMTBZ?=
 =?utf-8?B?MThxUzhHUGxaUzdDSnZLekxsV1BGRWtlRVFSQXc0Y0pyVUNkSUd3NmJscDVr?=
 =?utf-8?B?WDhrbkU1VW91OXl5ZitOdFJyWXJpb2lsQ05JbGx0U2RjRHFMc1NXUGlJSXBZ?=
 =?utf-8?Q?MXOQ4UFoRSUZd4d8/upaKYXQMZ9TViHhctBAF7gY/3CrH?=
X-MS-Exchange-AntiSpam-MessageData-1: tDRCzCy2SLezSYTbwrMLUtFNVZVCzC/RI6I=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2791aa-092d-4f10-9b35-08de759ffd1d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 01:31:54.3628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URoQzbefSvd4EZMAmd08WcxGtmmIvYlMqErmIbWTb9mF3pEgHfPJZruGpJV4Xv+yhwRHwPMUjzBwgTSah9tPgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7101
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219888-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[1g4.org,mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1g4.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 3DF0B1B1838
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 08:55:30AM -0500, Jamal Hadi Salim wrote:
> On Mon, Feb 23, 2026 at 10:05â€¯AM Paul Moses <p@1g4.org> wrote:
> >
> > The gate action can be replaced while the hrtimer callback or dump path is
> > walking the schedule list.
> >
> > Convert the parameters to an RCU-protected snapshot and swap updates under
> > tcf_lock, freeing the previous snapshot via call_rcu(). When REPLACE omits
> > the entry list, preserve the existing schedule so the effective state is
> > unchanged.
> >
> > Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Paul Moses <p@1g4.org>
> 
> Looks good - but can we have Vlad (added to Cc) review this as well in
> case it breaks anything in the offload case? More specifically,
> regarding an update policy..
> 
> cheers,
> jamal

I've regression-tested this with tools/testing/selftests/drivers/net/ocelot/psfp.sh
and haven't noticed issues.

However, that doesn't test very much of the action possibilities - no dynamic gate
parameters change (as part of standalone action or bound to filter).

The ocelot/felix driver doesn't offload standalone actions (TC_SETUP_ACT) so it
doesn't notice changes made to the action using the "tc action" command.

If I make changes to the "tc gate" action parameters using "tc filter replace ...",
then I trigger the "The stream is added on this port" extack error in the offload
driver, which seems to not have been written to handle parameter changes very well.

I don't get any lockdep warnings on tcfa_lock, if that's of interest.

To the extent that the testing above is relevant:

Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>

