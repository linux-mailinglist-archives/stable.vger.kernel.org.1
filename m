Return-Path: <stable+bounces-254512-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AUeJ4WsFmpHoQcAu9opvQ
	(envelope-from <stable+bounces-254512-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 10:34:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 367835E12E1
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 10:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CC90305EA1A
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 08:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992B13DFC6B;
	Wed, 27 May 2026 08:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m8wthcO9"
X-Original-To: stable@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011029.outbound.protection.outlook.com [40.107.208.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7217E792;
	Wed, 27 May 2026 08:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779870750; cv=fail; b=HbvtnqnvOmaXuuoUJmVWstFfdqTdJvswN58JbY9CIYb+S5Ovkf7eoLGyR2M4ejFwTKhZP0NtQlkDB130J+rwxw9DMUX4+VO1UMLlXmYDtffKIIUxGhNmj39j685ILcqojNVCguKaWNI0gXOh0Q/5bUJtUkJpllnbRvDI+3646qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779870750; c=relaxed/simple;
	bh=w+VBHqidBwS5A2+jVblq1aPfGOl1tfw368Tw8N1kjHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r3ujro10pK0x9HclyYkt2aEXWm6rtgHOjICbpUnNdmfgIdMsoHRYsPNRSIpMoApqfxeFO6cAKQIbWSrhQihjbbFBN/RvyalHVrYn8cYFowo3Cb0rehebEH26fWZ38+DZSoscexZbKgGFfIvD9v8n7MG+Tnx5SM5alzaGN/iAx5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m8wthcO9; arc=fail smtp.client-ip=40.107.208.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gua9JPaiv7Sy8joP5iIo+U2jWp7gKT83OEarvdBXowi2aPdeM+WM8hx0XGmvBSk4a2pW7IucFizA0OasNn5gurUZPLv3ytNzOIPQYLOmOSK0AfnKsfwWAY58BAbKR4Ku6mwwBGad5+5A7N8o889zLF/Erjrznqh4B8mPl9MXGHQT2ng3lj5LJzRC5+8+wPlhruzuKjBhlFH1GObHN6rB81I9DjoulvOBIhu871lotPbrpiKWrr+ORrPAOgTrdqvMgcFYWS6UoRE1RPD5lO7fK/r+dDhotH0TbXM6TxG+A4dyq74y7YiPNEtN24B39p/qDPhq1Mt1j+DVOLVggNc3+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRFcLORvcDFePwBEEmhHBCBrOzSmc7u8gfI+vI9ki0Y=;
 b=B+oanan0a0Gqh6J/CMfFUo4Drn7RspgpfxT7/52a+fv+9+l/q0vLTCwYFRQ6bzMh2jP8BbLwj49CkaFQKUKJogI9sExsEaOjQbvML42P3zDSz8UxxNzeKkgeC8vR61NCV5EC5W7sp1yy7TOOig0GJ4Ob+5l9fTvRhcucSGtfJ9nxZ/aAEjfnoVhK3xV8/e4Yqy0RVoWB3daEevh0d83q1ADLl+cUHM51h/QfUJmohI8llnI/LDMWScHfeufkzbAWDhCfhJtEa5PaxOzeKiSB2r25hDC5O3VLjpiHM1Y/FWuBk2TrUSN9f1NX6gBaMuJUX83XsvkQ1zDpHph9X4QD4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRFcLORvcDFePwBEEmhHBCBrOzSmc7u8gfI+vI9ki0Y=;
 b=m8wthcO98TDx64BRi+P3/RrYiRMpbv1JuGRTUvak88VKVFL0f0Nm2vFDF5tWbeARm9CsklVEjBJGysEs5OtQD82svFdskvPVar7DLdyHsXvikKRixNuhYv1Jrs8iuPal0bW1nBWjQFPwpb0eAewC0LsY+uZSIZR0qaQEpXNddW+HYSjoI3Vnj9q9411oujXRn+IzjlCt/pG8yTnM/rVJrvUEbGj5ANaUDnog1iZIuqrLdgYWjdNR7eQS4jo4nvM9zl7xs5tnO6VFtoUKASv7LAzSbgiJINyLlLRMro0ian36oAYmjJFnl3KDOtUKmCi/gUc3QPrb8X/JKDukcOpA4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by BL3PR12MB6546.namprd12.prod.outlook.com (2603:10b6:208:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 08:32:23 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 08:32:23 +0000
Date: Wed, 27 May 2026 11:32:14 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Zijing Yin <yzjaurora@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] netdevsim: fib: fix use-after-free of FIB data via
 debugfs
Message-ID: <20260527083214.GA444725@shredder>
References: <20260526160910.1614609-1-yzjaurora@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526160910.1614609-1-yzjaurora@gmail.com>
X-ClientProxiedBy: FR2P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::11) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|BL3PR12MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: b178f60e-599d-4f92-3b27-08debbca79f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	/tvk9O186SRz+qs2cdD2+zq7Z1yZ0YFS/Ht12uyTPHqXtbJJx+QojD3IQlt6wlCF+cOyxTiLtRhAgl8Y2a7hzmVbkaFRiM0P4uEKvpBOX4m/iFuQuOxcgUh4pBsbMVenLAfxxpuHAc9FRUP6jYstysGqT2oQ/K4QR43o7HA4iuFvKYqlcrvhF7TYQYq/izvB9baiGKwTlZYvyEqPUvwC9AHx2cdc5EfgbHjeBF8ibl/RtQOLqjydYlEUgeJTIRVBqPAWFlW6c97HiELJL8yFsIwc7zn5KGsjKwZJs5t40aaDqmv8/Ue94FdlcE/7bDLhvWuGg0XftPXHujiMrge4EC2m9zKuQZc2z40KVhi+0xATyyP5CcQvt66tbPKcWDvZU9Ovx0WZhU/R3bVMp8bzj56C1qz5HKhvr0SoM9cVhAJ7TtPZCxvOoYzk9qyP+1huX1rKPt7mPAbyqUHvaxkHLmLezi8jmJPJga4XYPDTd3EXZPGvT81rXgKseiXPGbv3Qi/vDRc95JNqadH5ODhkIkheIbRk2lUdIoYXyTJ/GtE8wnyu89ifMjH5uzDugVNIF+K9OUX13zD076UxtYB8jzGJoOjD7a2wPx9F7kSB4GtKNlxz9ROLByq35eTB5i1HAz/QuGqcIJkPp1BpDugvrr12D2wSPXOaH/8salvpRyE2SgQn4N28TSw1lyOabzfW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ShSafHPXEcsKiWcUI96lY/IVNKQYQGkbusq9NNsyjhlIv+2JPxbBCvKXagNP?=
 =?us-ascii?Q?4TPRUpCSBIthiNwcSqk5qg2/8Pe5Bp3M7bqvT7YnFbxzwKTgBEYr8NzlQFVM?=
 =?us-ascii?Q?vTziC8QjsRo32P6cAj4sm9YPkn0xpUHg0lI0OLe/suEmxUzMD1wfeDH07h//?=
 =?us-ascii?Q?kOKlJxSm5wJJmLKR0VXVZDK4kK83PQvALh4jrdZbIgBVkX0ZT6FgDa1YzGe+?=
 =?us-ascii?Q?EOarHWxOO+kHg80TyFe6OZVcliM5/CVox/WHAS1YTJ0BojiPL2qeKTkLRbPu?=
 =?us-ascii?Q?6ZcTsDrzO/7CULA5K1I7qAH/W3qjRjQk0JuZUUtnJcyFWPQ1j6HcrvH5t/CY?=
 =?us-ascii?Q?N4WSH8m66Wclr3vtkHCmXyjLhf5zOEUQYZw/8AzByHtBetZnC4CG62Xo2+dB?=
 =?us-ascii?Q?9BDlxOAuokcdAzEyDUSMZX2q9NiEl7nPCtup4VXK+ZjCmWRoOWHPcVvZqIy/?=
 =?us-ascii?Q?Oxzs5AkQK7/hCVligOLZWeEw3tW1tII98SDU4KksEq3gBc5qkZAJI4XTcGMg?=
 =?us-ascii?Q?iHJQAR19E/Py4uLLyMgF0EmcGCXqnOlLWPvahoeNDORP57bQTcz/5i+5jg+P?=
 =?us-ascii?Q?YJXm2A2Y0JB2XpB3j2Qvh1+aXx/I2qw+FzL44SIJw0SGZo4qboneQt8tvY5G?=
 =?us-ascii?Q?PLSdwnZA2Scp5p0obpg0czFYtK0ja4khx28Vc2O/KhHLP7TujmXOW2l47J/l?=
 =?us-ascii?Q?KoHLAopWqVbwaE/w6uHCstm9WQNgX7pW7ZZBCK46ogjX5ClFrnh6Efa8gWB0?=
 =?us-ascii?Q?AXVSkl3f1W/j/2G2Mal3Zlfrh65T4l5zVWqPZ1MBYbN/i0Ek4qCSM3apbPz1?=
 =?us-ascii?Q?7e5+RnDnApEZsUgHqfHeo4j/EdXBQIbobV7wWhyzsTYBsO9qNRMUvmjpyYm5?=
 =?us-ascii?Q?HxB55YwVjyEe9JFine+FKcRlgef/Z+1YdWgYQlAQdr7Fwfaq1vUFR7Gqp0Tw?=
 =?us-ascii?Q?ShvylJITRL9PEBZVX3VPSuBqUOpndm4feUigPFWD5qqQcx25s2rH1szxBjS0?=
 =?us-ascii?Q?mEU8oecS0WG3SJctFb1QR4zDFSSmjV9BRVK634O5ptrCe67rXa3Gpa794WrO?=
 =?us-ascii?Q?hDO3TOuwwcmzDEsTYE3yesRJzL+qOEzj9bf3vfcR7xzTZgyzH/dqxDU9cCIt?=
 =?us-ascii?Q?5C8CtWrML3UKS6o4ezcmOPToVIlZyqFvA+9RG6CiWw245jipG2Nih5liIBqw?=
 =?us-ascii?Q?7jnGP5RpWFkceECKCnN9FzqvgFpoPdVvxwEomg2gxxCFfa6RnYlSOYGEwsbJ?=
 =?us-ascii?Q?qWSkOJ4erFbLWskpChZtGayMs41tGf8QCWTiFqGF6PUBKHqAai3d9U0AwIej?=
 =?us-ascii?Q?AGYxPY7TUBeix5ooDDmOW7KqHkgxuGpfxxIBaczzSvKzLyW6WsK2QoA12wz0?=
 =?us-ascii?Q?pw2U/kAUKMVUdYbspQJRNiK86jJ2d4iIylOZ6OBBM9TMv8UHTvIpstI2bP/i?=
 =?us-ascii?Q?eAf6qQtmkJAYoj6ADQ+QAbCI5x0xKdWDg+3D6btvnlPYPFX7p3jssFGOtu6g?=
 =?us-ascii?Q?7mdDuKAYtOPU4SrCU5C7dA0Cxr4HGY6A0G6mN8uAjV5yeNrwR43y2WiogBBq?=
 =?us-ascii?Q?HP9jD8dPgORfgyU/e9FduipTazuakfoL3V/JxOvKuqKLKv52p0/cEPa80vZe?=
 =?us-ascii?Q?WmfrQuLzcz/NdtibIwR7MEweNn02kKQ5ewECx0ulxIwW0tXXY0XL5nmFW1eA?=
 =?us-ascii?Q?l4HV9PLwMkXqa5A1fJ3+XsgVxdWurHh9INF9y9NJ3fSdbcGt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b178f60e-599d-4f92-3b27-08debbca79f0
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 08:32:23.7940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZR98DSOze5W0CZrx/n22AIU0qQD6UTLgI6kqQbeV8MaCbadHpHSNxp6nK3/3P+HnsZv8KHvt1t5RrK4pK+3SRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6546
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254512-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 367835E12E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 09:09:08AM -0700, Zijing Yin wrote:
> @@ -1600,6 +1597,16 @@ struct nsim_fib_data *nsim_fib_create(struct devlink *devlink,
>  		goto err_nexthop_nb_unregister;
>  	}
>  
> +	/* Publish the debugfs interface only after every data structure it
> +	 * operates on has been initialized. The files reference this
> +	 * nsim_fib_data (e.g. "nexthop_bucket_activity" looks up
> +	 * data->nexthop_ht), so a concurrent debugfs access must never be able
> +	 * to observe a half-constructed instance.
> +	 */
> +	err = nsim_fib_debugfs_init(data, nsim_dev);
> +	if (err)
> +		goto err_fib_notifier_unregister;
> +
>  	devl_resource_occ_get_register(devlink,
>  				       NSIM_RESOURCE_IPV4_FIB,
>  				       nsim_fib_ipv4_resource_occ_get,
> @@ -1622,6 +1629,8 @@ struct nsim_fib_data *nsim_fib_create(struct devlink *devlink,
>  				       data);
>  	return data;
>  
> +err_fib_notifier_unregister:
> +	unregister_fib_notifier(devlink_net(devlink), &data->fib_nb);
>  err_nexthop_nb_unregister:
>  	unregister_nexthop_notifier(devlink_net(devlink), &data->nexthop_nb);
>  err_rhashtable_fib_destroy:
> @@ -1633,16 +1642,23 @@ struct nsim_fib_data *nsim_fib_create(struct devlink *devlink,
>  	rhashtable_free_and_destroy(&data->nexthop_ht, nsim_nexthop_free,
>  				    data);
>  	mutex_destroy(&data->fib_lock);
> -err_debugfs_exit:
> +err_nh_lock_destroy:
>  	mutex_destroy(&data->nh_lock);
> -	nsim_fib_debugfs_exit(data);
> -err_data_free:
>  	kfree(data);
>  	return ERR_PTR(err);
>  }
>  
>  void nsim_fib_destroy(struct devlink *devlink, struct nsim_fib_data *data)
>  {
> +	/* Tear down the debugfs files before freeing the data structures they
> +	 * operate on. debugfs_remove_recursive() waits for any in-flight file
> +	 * operation (e.g. a write to "fib/nexthop_bucket_activity", which looks
> +	 * up data->nexthop_ht) to finish and prevents new ones from starting,
> +	 * so the rhashtables are not freed while a concurrent accessor still
> +	 * dereferences them.
> +	 */
> +	nsim_fib_debugfs_exit(data);

Thanks for the patch. Let's try to keep both functions symmetric:

Call nsim_fib_debugfs_exit() just before unregister_fib_notifier().

Also, I would drop the comments.

> +
>  	devl_resource_occ_get_unregister(devlink,
>  					 NSIM_RESOURCE_NEXTHOPS);
>  	devl_resource_occ_get_unregister(devlink,
> @@ -1665,6 +1681,5 @@ void nsim_fib_destroy(struct devlink *devlink, struct nsim_fib_data *data)
>  	WARN_ON_ONCE(!list_empty(&data->fib_rt_list));
>  	mutex_destroy(&data->fib_lock);
>  	mutex_destroy(&data->nh_lock);
> -	nsim_fib_debugfs_exit(data);
>  	kfree(data);
>  }
> -- 
> 2.43.0
> 

