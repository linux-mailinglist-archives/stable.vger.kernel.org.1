Return-Path: <stable+bounces-18844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF46D849CC5
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 15:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005361C25015
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 14:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A842C1BA;
	Mon,  5 Feb 2024 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="n3kNGeAl"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2119.outbound.protection.outlook.com [40.107.220.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692F02C18E;
	Mon,  5 Feb 2024 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142523; cv=fail; b=kgi+McsS/itgOTBiRwKZaQJvtVXSBF3SEkC7nrRVPY9lHCXEQC+b01AZuRKnP6xWKCTdYOtsL5OkeTLqafZ/6HD7D3F53Y91UWGtlk/wQxH1Y5jvxH6R9hgLHITFFCZT9O44FZ+9BWEBltzic5PnQ1Lundmdw94j4mjzLgWkOZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142523; c=relaxed/simple;
	bh=tYU4H+PlxsX11tV2dpZyAf4I/FYipSXaXyTCK7XKRw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CKumP1EWVRMcxY9WpnI2dyJ4FR4mhzKkP9a+Rot+IsRv0Rd+SlTw+RNlj1e75uf4WT0FDiKY9whLBNqnpIMpIOEOAeJkCqZ8CQD/gRVi/oNhiUM2E+x4MVSBkWr0fItBFzGcZsPerFlcOn+2rTmEzWqmnir38wELghhvq8SdFU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=n3kNGeAl; arc=fail smtp.client-ip=40.107.220.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NU4f2M7u6lXLESBi42TTrnAsXImT8GaRmagQz8D6iHIEwVGNWEw/trCQaJJ5fzQvNto7prUssvibtZoQgag0QUNoJ9I+jMGQbWeFKdWWp8yVG05ElW9N0w4F6Le7uXS8hSh4MNaeoTPGdNWWsPr7NdsrXyE1u1iJHJjsWyJWi8s9EKrSmkcS1I6bVY4rT360+u7imqk5pwEtO3rHqYjB3UKcc3XFyzzhNg6l/UkKeJSyLfG5MZya/+0bIZcii0+1dG8G+UKFDlm2VCmRg84coHDgG7R+j35XppR3kt1T16U2Nqba3y9QhhZzOYGwJloJMp75FvtgL7A3SJqM7DzsBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfuyP2oZBUdKNWSv5zLod2Alj3QD66mptb+EmT3x91E=;
 b=iPC+cFjC7/Hc9WLlbY6kOXHZnp+lbTjH9EOaO3QNaMPX7GoQOKFN4o7KAaTPk+oZdFWBf7KUg76E363tk4fDLahhMfSZc9SFp6ZyWrmYAmldLvxgb8log3vkM+z0Ih7LCfBjW1QpewyYR0CzIFrjoAxF9raCVVph7C53F1hqot/FQHn6E3uohj0ER2xolMWD6LkfpMxF/3Sp4+KJUxG8g7yen6sY2tywpsj101L203w5DFpNrdwTrlXBOprTeo/WTggDfBm5ArM0AUzjohDTSymPqzCmD+6jowchCrUqOwCRXZ7eQOpX4yyH9W6Bf5J69tKq3t9ZaEIwjBAFrm/Fwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfuyP2oZBUdKNWSv5zLod2Alj3QD66mptb+EmT3x91E=;
 b=n3kNGeAlNXFJbW4QzcCLKd4NCL4cd/G2cUg/1UCWamrt/JQBlCaQb4oKj3I5I/PUhy6Jr5tVFiTfpJOictIBb5UhB0MyZtVAqVeG0Pluyug/xcIG2JGDomjCd7cJZSPWp1kPXMmVnusOoirhcnpo9s0wdJId7w9HW03PgimV978=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by SJ0PR13MB5721.namprd13.prod.outlook.com (2603:10b6:a03:408::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 14:15:18 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::2e1b:fcb6:1e02:4e8a]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::2e1b:fcb6:1e02:4e8a%4]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 14:15:18 +0000
Date: Mon, 5 Feb 2024 16:15:08 +0200
From: Louis Peens <louis.peens@corigine.com>
To: Simon Horman <horms@kernel.org>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	James Hershaw <james.hershaw@corigine.com>,
	Daniel Basilio <daniel.basilio@corigine.com>,
	netdev@vger.kernel.org, stable@vger.kernel.org,
	oss-drivers@corigine.com
Subject: Re: [PATCH net 2/3] nfp: flower: prevent re-adding mac index for
 bonded port
Message-ID: <ZcDtbBeW5epRpZqR@LouisNoVo>
References: <20240202113719.16171-1-louis.peens@corigine.com>
 <20240202113719.16171-3-louis.peens@corigine.com>
 <20240205133203.GK960600@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205133203.GK960600@kernel.org>
X-ClientProxiedBy: JN2P275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::27)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|SJ0PR13MB5721:EE_
X-MS-Office365-Filtering-Correlation-Id: dce1451e-9d0e-45b7-5b4a-08dc2654e151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WhISfMwZIuCmAeBkjyWmcFMj/u3K3hR8+yMyqTIt0q31FAsezOInStEXOFiZjbNpSpFDlz0gMwT8jCo+HWuGczjTcEmwVrfgTAhDAeRmdz6oWNtZ92SQjBnRzO/QvkiaBJaeT1BIjotCO7OwFSACp2yAEmrWz/7BaPAH9KFqI7KkMkUBYEVWD2uOspCmhi96vCTC3O5LTG7zFVrtH8QQJ5J9bfntD0OxlqAJ2XAzdCU3LuLS4u3NxFBh69bgpbPGnANmDoIy7sh6cto6wC7doTUWdRluJbE14Ez2GG1oGlBamPPQ1V2Ezzk49vdclrJM7rJU9GPWSXBWPK2OKgRUkujHSI0jlfPkQ202cjrj+w0J/qxzOBbhbv8u3mXwKU0kXbugetZhmC4s6B1bpZ1eqHwb5ugw7yH06N8gnE5oRqI4Go4+ZTdq9xY5eZW3L7L0QoqC8zAhT/EkxwTWbI0625aAB1aTgL6staHLwlbWEacURQBdqO50tSVQD9Qu9im6m+AXhtdW+76Q7WhqgTtsLKUo0G12pUIwh8dNhPLX3DN+TQxX72LQ0xh8h+jG0sf3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(136003)(396003)(39840400004)(366004)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(86362001)(33716001)(6666004)(107886003)(2906002)(26005)(6506007)(6512007)(44832011)(9686003)(41300700001)(83380400001)(5660300002)(54906003)(66556008)(316002)(66476007)(66946007)(6916009)(478600001)(8676002)(6486002)(38100700002)(8936002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5dU8qFdGRDYkMj0N1mtrHLkcoG3BypA5077kG1bntf6E6Ll6uqFTaW/NeUcI?=
 =?us-ascii?Q?YsoRtLtexT+OJBM12gvwDcYF4SU8Parq7PLsHxfSzCcTcuUZUk/5XL8/Dk1K?=
 =?us-ascii?Q?DJirt4rbAD375f/dgf/HTiAFV0Mt5SMGwSIv6c9d+koGMU8uGLiXM73c6o2A?=
 =?us-ascii?Q?xiRKIWJgyNQBAizAVq4pugz+t7F4RfoxcElztgMCg/reRyhL7A5ovEBi9IUM?=
 =?us-ascii?Q?sa/xQA5vxA3xibONjkxxIVI+m9UzfrNAStygGBBMQuhLtDuKX/I00Zvnskqk?=
 =?us-ascii?Q?DAn99swLGH8jsjM5rVDAgc45Q0DuonRCVm38o9kR4HN3fPOU6kU93J2hy4xX?=
 =?us-ascii?Q?+XzxwDFcnitw8CJL9BGqbJQLyi+uSlmYbCX/uva/Snjil9U8eMDYGrOIXApC?=
 =?us-ascii?Q?ncO/9MiCauo9MHcL1mFnRCHcy89zI9O/PUnElJicp2FsV3FSaHSdmsqUCmZu?=
 =?us-ascii?Q?wdQxar18isJOhcozvc08Ttb8QzldSXNu5NMn+ZW5/XV0IvclgVXFySNmsph/?=
 =?us-ascii?Q?ncswIU8VmcZ5813mPTB7TW3QPFD/8Cxt6nyn+bqNVSurUZ8Y6288QM8659uX?=
 =?us-ascii?Q?GWdXKpLGMAO3YgHRQxx/QwHRBQKF1u2P3fzTdjfINb3GaRyjZyqrWqPdC8U1?=
 =?us-ascii?Q?Ym1f3Bm4Zn+3VIUnDlaMHDpyfZ+7ucF5iR3Y3vI7cHoZ2Md6X/2BF9ns2qYE?=
 =?us-ascii?Q?/SGxc6jiCpWG70nq0dUfy4XtKrH0quzwLqhRVABonQmTYRT7iQKVSbsJe+S/?=
 =?us-ascii?Q?vBxePVOd8mbfL6bB/HRmsg2+v2nj9JQfPXYXxBm6/VQ92dlQHI00KZkTRAAE?=
 =?us-ascii?Q?XX6aMuG6JCOZk1vByv8ycvf+zYPvLGBVOoAgzJOZj8j4eEr358uZu2DGfJhY?=
 =?us-ascii?Q?ks0p4bo7FS7RP22DpByRJRT8mbDxYR3jcHn0fCepmFB93fle58BT1xJy4XWD?=
 =?us-ascii?Q?nsOIobLw6QohbLgkZIgU/1blI7RWMZhywA2EX1wUR7I5UNRlgQs1v89tscvf?=
 =?us-ascii?Q?2CgLvsZrsyPyFE9ohEsF6200LMpOiuiwOuQ9gzRf0hxF8E+ZCEfeaCZsvrVD?=
 =?us-ascii?Q?RmSDLiKSV+ucNWnmfJpbpNypp+XR2wrCQ21lpcR39ItDYO5Idvef230XnhrM?=
 =?us-ascii?Q?tNO3Wlhjtq1j61jhXJ/YfZm1xQnZpOpEUu1MnciSH/XDJ84vJ+V45I0AereS?=
 =?us-ascii?Q?OO/I3tY2aez3MCqmS+rhsrBf9U5VGzlZbl214EsEyRyYbaV4o3AB7z8WRMII?=
 =?us-ascii?Q?6RAf3+MMTxPtr1GYfaytxUxhxAxcOR5Lil3cEVHmmNGBsjZDSRW+BP+tShsP?=
 =?us-ascii?Q?cix7BPmK0+u45SZ0CXmg4W5cIaZyo2xwx5mzQGA9y6LQU2qmvmATBSZRAo4Z?=
 =?us-ascii?Q?pP1hd8bhOvqOacG7nYIQvTVQ32i1cJZnln1MdXzhAPCglOkW/AsKXxP/Cj8X?=
 =?us-ascii?Q?+82pLKLGKqXLUrUauB6aQqk1Kz02BxTym+1oKps5zaYazcn1S+uoeat3Qr8R?=
 =?us-ascii?Q?0CfTR9fVGSgTKqzy1yrPjwC7KAWSf0FyhnmPC7wp0kL2rEhpFyXT6nxEdRr9?=
 =?us-ascii?Q?odG4FcVGzoj1jCvtIJrbTmsXiikqRKwN1BVxbylDU2P3u+ccQj40bv6SkpFq?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce1451e-9d0e-45b7-5b4a-08dc2654e151
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 14:15:18.0183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5jfjRDUHsHMiMaZjyT+FONtzKcXt1gTvO3cSHXVPgaudsnyaLGNbPVoNeAm8vHHsfpzPquDJn6ftQ3gb4I6S2ilZeKv5lHDITufPpxUlAY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5721

On Mon, Feb 05, 2024 at 01:32:03PM +0000, Simon Horman wrote:
> On Fri, Feb 02, 2024 at 01:37:18PM +0200, Louis Peens wrote:
> > From: Daniel de Villiers <daniel.devilliers@corigine.com>
> > 
> > When physical ports are reset (either through link failure or manually
> > toggled down and up again) that are slaved to a Linux bond with a tunnel
> > endpoint IP address on the bond device, not all tunnel packets arriving
> > on the bond port are decapped as expected.
> > 
> > The bond dev assigns the same MAC address to itself and each of its
> > slaves. When toggling a slave device, the same MAC address is therefore
> > offloaded to the NFP multiple times with different indexes.
> > 
> > The issue only occurs when re-adding the shared mac. The
> > nfp_tunnel_add_shared_mac() function has a conditional check early on
> > that checks if a mac entry already exists and if that mac entry is
> > global: (entry && nfp_tunnel_is_mac_idx_global(entry->index)). In the
> > case of a bonded device (For example br-ex), the mac index is obtained,
> > and no new index is assigned.
> > 
> > We therefore modify the conditional in nfp_tunnel_add_shared_mac() to
> > check if the port belongs to the LAG along with the existing checks to
> > prevent a new global mac index from being re-assigned to the slave port.
> > 
> > Fixes: 20cce8865098 ("nfp: flower: enable MAC address sharing for offloadable devs")
> > CC: stable@vger.kernel.org # 5.1+
> > Signed-off-by: Daniel de Villiers <daniel.devilliers@corigine.com>
> > Signed-off-by: Louis Peens <louis.peens@corigine.com>
> 
> Hi Daniel and Louis,
> 
> I'd like to encourage you to update the wording of the commit message
> to use more inclusive language; I'd suggest describing the patch
> in terms of members of a LAG.
Thanks Simon, this have not even crossed my mind this time and I feel
bad - I should be more aware. Thanks for politely pointing this out.
This did get merged earlier today as-is unfortunately, I'm not sure if
there is a good way (or if it is pressing enough) to have it retracted.
I will try to be more cognizant of this in the future.
> 
> The code-change looks good to me.
> 


