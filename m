Return-Path: <stable+bounces-116343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C478A35120
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 23:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C314416D9EF
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 22:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405D726E14D;
	Thu, 13 Feb 2025 22:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="j3stnxGQ"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04F344C7C;
	Thu, 13 Feb 2025 22:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739485311; cv=fail; b=tM3rgtShoa3KWD0fM2uL6GEQC1uW/cWEjx667vdgKF4dT/tIkSOKwYrm+eO6lD8JR711ow8KqGfYaetnJGuYR2MO7n6nSiLQcy5C+OE7dWtGo+Geg3UG5aLTXZBMkX/fvTxv5RUntnZHrvUKltcS3xUbLzzot1gO+joCjyFZTTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739485311; c=relaxed/simple;
	bh=weBZD7HggOSG/XcqioEVn93JALml1YF+uloIGKQy9rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=skTDCv6uCQAEbU81Xp62ChBFN+W44hTqD7cebjKuqDu4jdOrujErYpkziSjtMdo5fBqm2NRNM/yFVKyAhpbdiZ7EjesGVlvTI6SPXZA++Y/hyy2Q13x3R/6M+r5hP3Gd1ZaTInE4LWwR3JsUhyHbeEAeaxA4egyNEYD7tZHEaM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=j3stnxGQ; arc=fail smtp.client-ip=40.107.20.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rF4TZYL1zxXBcJq0mQyGFvP49tajmTdy7J0PqUnFhNkR3JNS7ZxsuORHZuSlJE3gdfF4Nn/Duna4KENoyShVBjFzDaZtYumhGtcjyXPZreILiJnE0faOpghOcReIRkslK6jlr+DJN2C9kn9wmVm07WIRT0R1P6cOwtxdYYgi/hp4QccF6yo9XF8zd2MfrUswXWQBAQkO9EluZh8g+3B9z4WdbmKnhRVVr1QNbYfwqKoL1cipowPmZP/IM88dySZHYTl2788QeJ+D/HhCPLbQbqU1zTh/0F96SVUmtcLYNgBR9Nicgdi5RZ0KW5I/zQGu/V538OljNR6i9Ti2lFwkNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOIpDpQJuZuV7Xofv/9gPiadg7UTs8MfDmAQMewJtgk=;
 b=uoPdpbd/DAgMB9IoSVKNJ8Q6DHIuCMNjXrJO3dMWwKUBHhYPr2XDWgrw59mg/0HOOJMHub9HJm1keR1ynTq3f4tcyav97rIsP6erNjoTzYtlQWD/PsQfCrcM16gZVCrlrvmhu+6SaiRL08s26ccNcWuZKRyDh31l555DJecliQLw5HE0eegswKRZ3B5QUXK46h5v7uiLVHmcNfJq0vkOu+PPDQpoqGxQ/jY8CymdH+ZRzAV+4nOBgNWG2TxGWiB9itwNBv3ThCNCuw06qB+fseu+VDe3z2N9vVrMQBtEjp+h6sUKieflJUhKWe6hzw+wte2/V2FohonIv7UE3e5EBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOIpDpQJuZuV7Xofv/9gPiadg7UTs8MfDmAQMewJtgk=;
 b=j3stnxGQhhKLg9MXDvaFH7HgdURPI/dC8k6ZMU1JbWUvv2GbuYJrjBTBRtG+kFiQg1YBdmOwfpXPmm859P4l4Aymsn8aeXFXi/WO36veTmi3ooGpq7hjZtH1+uNAEcE7X0OCW77ujDkNCkxFYTHc72MiMRMfKxUASPqpiz/kP9z+n1ogByNlj4sDgFQBnOHptF5/D0dhizhtiQFCKQq42yv3t217Pa00GU7U3TEZH8BmkoC6UOV1nISOqMuN7vWkzTK+MF9hr5bb5zJ3EZ0kXy4gdcy5nlWp0jVMriCkj4bqonHIEgMutMr+W/K0oHnHhrCC4S/oFEFIczoOG6u8MA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VE1PR04MB7423.eurprd04.prod.outlook.com (2603:10a6:800:1a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 22:21:45 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 22:21:45 +0000
Date: Fri, 14 Feb 2025 00:21:42 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: claudiu.manoil@nxp.com, alexandre.belloni@bootlin.com,
	UNGLinuxDriver@microchip.com, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: dsa: felix:  Add NULL check for outer_tagging_rule()
Message-ID: <20250213222142.pqqinnlg5qir5xdo@skbuf>
References: <20250213040754.1473-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213040754.1473-1-vulab@iscas.ac.cn>
X-ClientProxiedBy: VI1P195CA0059.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::48) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VE1PR04MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: b736ae60-09c5-4af2-a6cc-08dd4c7ccc96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ElTa0KCiutwzVqulWXdrgLSOXxcATolsmCZpL3brI5KpZprFHrtnT1zw9TFR?=
 =?us-ascii?Q?31w/p0ntacM+pxymlInICDRfXM4RFS12+A30qfVL65NTLnjzyqmfPwnzCJSu?=
 =?us-ascii?Q?Tr/6uHAxEpRpWe0Lt97Ao7DsAB9hfqTLF99fBDw6YSL2AUkOthM4DLyEOLx/?=
 =?us-ascii?Q?5Nz8EnEmCh5rSQvQ/ZxuHh/yTcF2i5RebdLaSeQpk/BoXeWrDaKHPDue+Www?=
 =?us-ascii?Q?G4lj5j5JIK7w36wSlWC/q/M6F6ZNdlHTrxQoItXCwgbcg8ewrzLqgZORScmx?=
 =?us-ascii?Q?q2FBCsX1n14sSIUkEqsz4O5Fxvt7pZBSHME80+kp3qxEsf0UjwXTXKTH2W+5?=
 =?us-ascii?Q?gNPDUEUNavEC31vUAlZhVs/DcalkqF07WVmUO4PLDzD40LOgKLJdripcLqfy?=
 =?us-ascii?Q?7lFvs9sin+U9hRI/HyEWxXSCmPvLTBU3dJyzrA/DD/jVF4JiS7JAkrwQHFF3?=
 =?us-ascii?Q?qYLgYf4B++T1VASXa9sJqlvDLX8DTy8uXUmVNa8jRkqAFKVOZLSrL+58Kirn?=
 =?us-ascii?Q?litEifOFwTQpflAwtwAdPIX4sQ+Pc/ScwiSKjJTz6SszJcBnNyO+JK79cAvq?=
 =?us-ascii?Q?wXHzhbGjHDpYhK5dg20nonVxlpDcYbvoZRrPZtn+vGlT7y51O86RSkI4cdiQ?=
 =?us-ascii?Q?8uaZtJb0ZaPv+fsgqNYZnPZYxs/KCQcu/x0EZ/Vlf93VeDfZ3TF9RDYkkmia?=
 =?us-ascii?Q?53s9vqC086hCt5NlRLKYK+lqEweSscIY+YcQDBIfxdCMrYO1l+zTA+2MWZ/d?=
 =?us-ascii?Q?M/0diocEuRUiUPOyzdg1kzowrH6yQsQe+ZgRdAnWmu8VHbzD0jUskTBkBvM+?=
 =?us-ascii?Q?oljapUnR5RwsrL0dsbmpcKHjkNHwoOogTbI1ZURRGgD8RD9jWHc0zj82F7tv?=
 =?us-ascii?Q?/td0rKHLB846LGFgqhkHsH2nhcQd1kZsSYYUtqggrA4Vrx9hvkCN3ZCTIdiB?=
 =?us-ascii?Q?YDxCVLMP4hIJlzMdXOwkWIvnMUM04pA8aIn6F+YHgon/4rGzFsVnTLw1nJPM?=
 =?us-ascii?Q?ZGqW/z9s9TuPKB9vEX47U/tdAmVZZVzPry/4n2SHM3giz8AEuIsOpy7RCD/v?=
 =?us-ascii?Q?7ZpMHnFHLsDNJNHq2cdx5jE5ZvESrM9ClWxaFBMovYAdnQ5HrSADlMz0Qw5D?=
 =?us-ascii?Q?EqHyduvUT4RwTEgFiabQ4dpn6QfExHXFlWn/tCJIw7f3iFvPh4N/ObMBq+CV?=
 =?us-ascii?Q?/MWcFGhaHyuHF34zmQYfU0F33Oa7eqaIUokfHI83DaA/pIu6kJv3lexhD2vT?=
 =?us-ascii?Q?cVQe5wPUWcDc5FCF9wJ3UZw2GliSvAY0EJBDr9VE7asahRn1Ekcrbr/yJFoS?=
 =?us-ascii?Q?YYmI8TtEI+/r2p4/nV6E6RM3iCbRnxJLvf2hmNxXkCkzaxhv7Ei51TnqfZcW?=
 =?us-ascii?Q?m/d+pEltd1CFzh7ODBrA8JfIeyxr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Iztip3kFYzy/Ycqsqk8sR5fujIadGoDtDWEiWAfOjXBsc0XkinctepDQ+QSf?=
 =?us-ascii?Q?m7OaFu4EZxxsqR9hkAs5k2MKwpoagnOyQ/fK2Sntobv08IoN/ZJQJOEFcrzE?=
 =?us-ascii?Q?bu9jaM2R5uYdFNCU2+5sbGFjvrwbMJv3ojoa5R6UwV/wl8ZGGHmBl92R6BX4?=
 =?us-ascii?Q?0Uc1I+tVVKPLQKsZ0qSrCNR9I0NHUocFzgbjGhuFSz/kvkdONTqchV3UMQCl?=
 =?us-ascii?Q?2GW0T0D55IaVL+K7A7metmDLXaTe+A4efIwMPxLWEfjGA8h2C3mjNRT8zG+Q?=
 =?us-ascii?Q?hsF+UKqsGZOybgVU7sxS3FLUpTV+fMTszUyMh8BA5W0yqHiB0bFTgo5tHL1b?=
 =?us-ascii?Q?IEEIk9WoEKYOtmgWjTC9qGzlmlWTXC4Rem+7mUjkuk+qaG7dTAxQtQHiDbo7?=
 =?us-ascii?Q?lBcxVB+QCK4h+SixjZ32FJv12D/Kp5QuPIpTSvNmagH95FkUhKzv2dw6C5ha?=
 =?us-ascii?Q?GUgsDTsYa+FugXmIBUdeNbGHTtG2JLmSf5/GErg3T6f2vIYF+8CR2E4dSeyZ?=
 =?us-ascii?Q?yuB20JHpjTgsCtTObxys4peVP+rtZVehbGDdJRuFJmnDwHR4cpG15j63ndIT?=
 =?us-ascii?Q?J/LNzozTkpEY4mIMUxFsiimEnH6bFnPY2Chokn5ggOC3HNLymmfzeomfF/Qf?=
 =?us-ascii?Q?AvKOltgAMG07esqAHrNgrvzaEaRLTazSfvmQMys+RT7DQC6pDv1LwHfs6IaJ?=
 =?us-ascii?Q?yUr83ctWP6p6eVZV2l3disE1gHT4s7WnLPTEf9QWU9cTSTCMxS97LVCXwhS4?=
 =?us-ascii?Q?ZZVG2BZ0vnzTMp+bOo6qdLAfovrxvl6hOyVE3tbRs6gz54lqsbT0+LQiipqU?=
 =?us-ascii?Q?fDQtOuplfghw9T+KEkA1r8PI//apkMNGuLd3SQe2nP7z3TnH+P2lZMK4+P+g?=
 =?us-ascii?Q?z6pZXBPGat6SyaaLpIaOs+y/tjdU9p2ndgDD+scqX9zZTr3iKTXs25ZMd7ZC?=
 =?us-ascii?Q?bn4XV1z8XVqn3jeqrd17qdP06EnJm1dZTZBPiJ4ENn2IV63+NNv2mtFdY86U?=
 =?us-ascii?Q?j2lttPsYSNgv+GE+4iXXOthEqCTxS2HrQDo7n9ao6HcfGU8LWhGjvrkC5/aS?=
 =?us-ascii?Q?6d03GghwkkNWdVtM+OBcxVX81uoNVL2YIPpGdAsP6egZNkJ2f6nqML4zJPrW?=
 =?us-ascii?Q?43Xh+WEDjidlJs+5nBG84qcu6FeYZYJDkDkNqPtkQrkJBTA/OdAdbXWJ6DWs?=
 =?us-ascii?Q?fQvC/Jv98EKWpSYkwPrhHCJCxR530+fsNDanO/LCZZbsbp2Nz6qJ/fadw9aT?=
 =?us-ascii?Q?5AeOh/ItXPIrKaDRwhiNmC0qoit99r7oyDm5iGh7OzXyZJ+FojJoQQap7s+X?=
 =?us-ascii?Q?aPHelt/4i2o3bsBG5EMLIGDrOubP/JHvOZOS/x9cfxwKeydUmT5jXZg3UHeP?=
 =?us-ascii?Q?n+dyeGLsfunlzjMAPoJed3Zp/Uzs8laT63u+Umd9CFojJJaIeKc9FGxhuBfs?=
 =?us-ascii?Q?CUYya06XeMhrIFk43bw070PT9SyxcxQgK8RvOUJMVr4eQtIRpkJpygQp9PYZ?=
 =?us-ascii?Q?qgaWOMP7qIUV99YKpE0sgA8NUaML3a80Vt3+878Ysif5oEKSytAJ0bPcn4IE?=
 =?us-ascii?Q?5xgtoH7v0ivO+J9O1tW748bPUTLCZ40Jjws4zUmsA4VkFF/2WBGRoqamQa1E?=
 =?us-ascii?Q?DA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b736ae60-09c5-4af2-a6cc-08dd4c7ccc96
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 22:21:45.0511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4IjXkvoJxGn3rV6C/lp8Ia19sV1feEZin1818sDeGOZOcs8pWGJ1AAV3KtvLnAEkmVwYcx+gYw1ynhz5Va9Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7423

On Thu, Feb 13, 2025 at 12:07:54PM +0800, Wentao Liang wrote:
> In felix_update_tag_8021q_rx_rules(), the return value of
> ocelot_vcap_block_find_filter_by_id() is not checked, which could
> lead to a NULL pointer dereference if the filter is not found.
> 
> Add the necessary check and use `continue` to skip the current CPU
> port if the filter is not found, ensuring that all CPU ports are
> processed.
> 
> Fixes: f1288fd7293b ("net: dsa: felix: fix VLAN tag loss on CPU reception with ocelot-8021q")
> Cc: stable@vger.kernel.org # 6.11+
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/dsa/ocelot/felix.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
> index 3aa9c997018a..10ad43108b88 100644
> --- a/drivers/net/dsa/ocelot/felix.c
> +++ b/drivers/net/dsa/ocelot/felix.c
> @@ -348,6 +348,8 @@ static int felix_update_tag_8021q_rx_rules(struct dsa_switch *ds, int port,
>  
>  		outer_tagging_rule = ocelot_vcap_block_find_filter_by_id(block_vcap_es0,
>  									 cookie, false);
> +		if (!outer_tagging_rule)
> +			continue;
>  
>  		felix_update_tag_8021q_rx_rule(outer_tagging_rule, vlan_filtering);
>  
> -- 
> 2.42.0.windows.2
>

Is this patch a result of static analysis or has a real problem been
noticed? Could you make a more detailed analysis for me of the code path
in which the filter cannot be found? because I'm not seeing it.

Hint: follow felix_change_tag_protocol(), and see which things are
guaranteed to have succeeded if felix->tag_proto == DSA_TAG_PROTO_OCELOT_8021Q.

felix_tag_8021q_vlan_add() is called from dsa_tag_8021q_register(), and
felix_tag_8021q_vlan_del() from dsa_tag_8021q_unregister().

felix_vlan_filtering() runs under rtnl_lock(), and so does felix_change_tag_protocol().
So felix_vlan_filtering() is always executed either entirely before, or
entirely after felix_change_tag_protocol(), never concurrently.

