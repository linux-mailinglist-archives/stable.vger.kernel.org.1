Return-Path: <stable+bounces-158600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE98AE86F3
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 16:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82CDB165C87
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CC11D6193;
	Wed, 25 Jun 2025 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="K8NwkMht"
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013033.outbound.protection.outlook.com [40.107.159.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15BD1CAA6C;
	Wed, 25 Jun 2025 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750862785; cv=fail; b=JAnHrd2Ub96/MCwe2xo6BQwEE2291HrSUlu9opQw9VmvgID/zb7jkb/BaBTbcCZiGoQw2XRoVxhQcIYMAU2BIaj23oHnvT10RQt998aKqk4/HX4gnj8/xXtMMDT8PGeoSZRFd48ggKxxBPksROFsAa5cN5iIN4ilxj9Nj7HwWXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750862785; c=relaxed/simple;
	bh=HOFoDALdTrFAMimLVVyfwPRadkJXKVCoxd3EjgtRGfE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rSNsxj9WAqjdXW73a92Haa+PW00QELWLILaQvdSi5pWSJrWC+jY0GuVYwINg+8C0LvBGlcXbqq0y3uWIPLpWhVi5wCAzyNhqIPrLOavJczpV0SV5v7uCFtdWy56lnbWcva3QWRfl5AjrVCdWV20wX+9LDFlL3E6rQp7jxr0Ph1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=K8NwkMht; arc=fail smtp.client-ip=40.107.159.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Boqm8bZc4F5dku9UVrqUnqyVJdAXUaI+cpJtEOIk/oPGBbgAuhbbM+acNccRo19kWuMgrXsAq+8bCdnP4PZnRCUwXjYDV7Pp5tV8JdC8fzY09/8IYWPeDkPvYVc2AYztxTLk3jtpRmRt8UZR7jXMTv4Wp3mh3o2Wp+GefIoGlYwIed99MDUwOrua8Yfbg1S7CGbRA0W8wYikf3rNERWhlpvgRdEkfaR3Uu1ZFziJBSLFk86UlRPaPbUUXcxjKFYjXr69PKNczo+4gjacVX1+mzoMfHQ2j4LRB++CcXY+fnF/KJ1sNdBTiLOeugG21oSf1rmnJ4ZP7y5Bu1pdSY76Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RC/HJyGfeu4wxNoGF9LyDGI35bz41xO01Tu5amAIWY=;
 b=cDAqBzwvxFUDQdGoSfAbKD+F9mKoFVR793HwpBkuEy14YVhZWHKE2X5JtA8ZoM/lwinijEVycRbTDBcR9Za0iGqEaFpLAwRIK/oDhBfrs/N0Rx3VeGMusHqJwumFVhykiCBkdTghgnTlYL5OakW+8SlmxHCPsLG0dS+9Zyh9T4Drzr25unVeDypgAbLatyw8VXwaXpQKwd4Y4yOm8Mmgg5qCmIXm4md9gQNTrwBISdX1BHOTXv3sx9MPYrWGlhXjctkFhyl847W17fYdEMHAcshfyDG/4LJAFYc1BZzXO16piC+FRvhDHlPdP5tDcoXqqgIcMPV4Le9FRT9VTW6pvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RC/HJyGfeu4wxNoGF9LyDGI35bz41xO01Tu5amAIWY=;
 b=K8NwkMhtwBlkYMY4/MPOzgvHgB3DqbqUsQzhhKAJNqWN6yMK9bK1HMd/5zBGjGTiUcpwg9xv1goas4r+2shlD4PqHT6jIGgK+MIm5aXIjuiXmLL+UDtk5rpiutMF2cGQzg+TFAtJGsBmUclYNdXvYp01jmXAZvh8xc7eUZWBl/U=
Received: from AS4P191CA0046.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:657::6)
 by DBBPR03MB6921.eurprd03.prod.outlook.com (2603:10a6:10:1f7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Wed, 25 Jun
 2025 14:46:16 +0000
Received: from AM2PEPF0001C714.eurprd05.prod.outlook.com
 (2603:10a6:20b:657:cafe::ee) by AS4P191CA0046.outlook.office365.com
 (2603:10a6:20b:657::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.31 via Frontend Transport; Wed,
 25 Jun 2025 14:46:16 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM2PEPF0001C714.mail.protection.outlook.com (10.167.16.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 14:46:15 +0000
Received: from n9w6sw14.localnet (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Wed, 25 Jun
 2025 16:46:15 +0200
From: Christian Eggers <ceggers@arri.de>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Jaganath Kanakkassery <jaganath.k.os@gmail.com>,
	<linux-bluetooth@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: HCI: Fix HCI command order for extended advertising
Date: Wed, 25 Jun 2025 16:46:15 +0200
Message-ID: <9911499.eNJFYEL58v@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <CABBYNZ+cfFCzBMNBv6imodUG1twK5=MSwoVCnR8St_w9-HiU_w@mail.gmail.com>
References: <20250625130510.18382-1-ceggers@arri.de>
 <CABBYNZ+cfFCzBMNBv6imodUG1twK5=MSwoVCnR8St_w9-HiU_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C714:EE_|DBBPR03MB6921:EE_
X-MS-Office365-Filtering-Correlation-Id: db23ddf8-4736-4ec1-6ded-08ddb3f709cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0lQdVpYS211c0xCTUZzQlYzMVdqNWJFRmhtMStGaFlBczN2WkgrL3ZnTTJu?=
 =?utf-8?B?aTVvRkxnTHptUERoZ3c1ZGVOVk9PWHp3WnpaTkpDS2RNQXlxZkNYTjhmM3hB?=
 =?utf-8?B?TDN1QVFULzJxczgxbXZpQXZadVN4ZFdUOWtkczdTbk1pOWJyVzF4ZDdGelpL?=
 =?utf-8?B?RzNYTHYrOUtQTVBZREVraEVtak4xb24zdWpYQW1QeksyRms3aHYrVFJzN29U?=
 =?utf-8?B?RVJoVDZQODRnN0lxUFhabFY5dWxoeVdRRXRuN0t3VUhBOXhzVTFSelVmaStH?=
 =?utf-8?B?Nm02MzlGazZsckluUXN5RXNvdWt4T21LMXZDVC80enh3Rm5EQk9lMS9ZUnJo?=
 =?utf-8?B?QjhOZnA2Q1pFTlhFMC9UUFM2eVVGeDJNelJPSGlibWJ6QkVicTJ0eXFPN1dz?=
 =?utf-8?B?NkQ0YWdiSkdnOTZXVklqbEszb05BVG5MWUtvKzd5YjJMNzFRWHpCQ2Q0WW5s?=
 =?utf-8?B?bmhPTW4vdytmZVYxSHQ1Z2pxU1dJT0toeEJSb0lHckcxbVpKTjFZZ0ltdC9L?=
 =?utf-8?B?eW10bXdGMks1RzFmdnF2N1Q5MkRGV0VXOG1PeUZKa0dKU3VlblRQWFpmNHhh?=
 =?utf-8?B?OXlUeVJ1aVJkck1waUw3QUJkdVBIRHAyemM2SUw3U0l3ckRyTVlSWXY0NlBP?=
 =?utf-8?B?V1JvRTRnNWVTUmNweU9zV2RGNWZOYmpXUHlSNXkwUVZIeUduaVJvbWlHWFAv?=
 =?utf-8?B?MU1ZNmg5ZS9rcy9wMW11b2ZCMEZ1QU1UcHdSQTI3dGdGa0paaVB3TjVoN2p1?=
 =?utf-8?B?YlJXN2c4L0VDcUFzMzE4YjI3dXE5ZkdNejJ3Q3pDVHdLR2xkaW1sYTk0N0th?=
 =?utf-8?B?U0lsQ0Z2MGxjT2VocS9rUVptVDBZZ1JJVDZsT2xXK0tnMWdGSHo3Q0phRHdD?=
 =?utf-8?B?RG5yeWFBNDdLNW5QTC9zQ0NjbDJSMjBDaVF2dXJESE1RczNHeE0ycElrajA5?=
 =?utf-8?B?VnVvd3B1L3JTZWNRdHRJQU9RajJqb0FoNTNralU2WlV3OXlaNnpOd0xUK3Rz?=
 =?utf-8?B?KzFQUkdsVkJudmhjaWpBOHBKQjF3NHc4MjZxT2x1bzZIaHNkZnlqdU5UNXVX?=
 =?utf-8?B?cURKQlNaWlBITXNzM3pWVGExRjk4R0J6TTNuY3hGU1NkQmhkU2Z1YU9lZlN4?=
 =?utf-8?B?Tk96UlV6L0NZU3dUeURLRHRsTVhqMk9reUl1TTQwYldwcWRySzRONjdqRWxH?=
 =?utf-8?B?UGNRaVA5Z2VPUURlaUhqWjdWeDBPaWtaWEs0dFFWT0Rqdi9sSzN2OHF0V2Q5?=
 =?utf-8?B?bEJKYXlQUThIajlrVFlSaGl3Q3VRUEw0Y1JiZ05JRngvK3JsTTMvWEpwZGRy?=
 =?utf-8?B?ODF6TkpxMEdjcVBHNk5rNm52UHEzOFNvZThsbW9va1NnWHdvUVZ1UmpDdEtR?=
 =?utf-8?B?dHdXeW9OWjcyUW81M1ZEWi9aOWc4SU8zaTlaOE5SZ21LcU4yUVhXQ01xWmUv?=
 =?utf-8?B?bldKVU5acXhDYm03QjdRNERTc1FoelZUaCt1RWVZMEo1dWR4K1N2ak0zbDZC?=
 =?utf-8?B?YjRLS2JvQXdONnZ6NWxCTjBRUVJBZXZlbTdmdGZJdGZvZ1RET3ZPY0k0eWVK?=
 =?utf-8?B?a0tibENnR096TE1GNHlrbkRGcUg5YStoZWdsK2d6dXA0eUxoS3hDSUtwN1BE?=
 =?utf-8?B?cENmeW9leC9xOGxxemRJc1JIMVpHNVg5OVJCd0dUOGRBZm05dGd1UDZMYVJ6?=
 =?utf-8?B?RUNjT1Z3U0d6UVQ0cytYTmQ0MEJ2SGhFc00ybVdVTFZzQ1lBajZ0Tzl1YXcw?=
 =?utf-8?B?djZ6REZ0MmtmY0FRRXJEYTdZMUhRcER3MUcwUnhFcVNybVRGSk11NGwvc0c2?=
 =?utf-8?B?N1hIUXRNSEhwWkcwK01OalJTSnllNjFTV2FaNVF0Y2p4bHI1NWFSWlJPSWlF?=
 =?utf-8?B?VlIrQXlkeEpCZnJTR1lhc2VFU0pkTitCMlhwUkphSmdaODJEQkwvdWs1UWIv?=
 =?utf-8?B?RjRBWXpuMW5nQ2xVNGcwTVFWSnZndllOYzUvTW16TlhrVmc2cDYxRy9qdTh3?=
 =?utf-8?B?a1dVL0dmdDlnPT0=?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 14:46:15.8764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db23ddf8-4736-4ec1-6ded-08ddb3f709cc
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C714.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6921

Hi Luiz,

On Wednesday, 25 June 2025, 15:26:58 CEST, Luiz Augusto von Dentz wrote:
> Hi Christian,
>=20
> On Wed, Jun 25, 2025 at 9:05=E2=80=AFAM Christian Eggers <ceggers@arri.de=
> wrote:
> >
> > For extended advertising capable controllers, hci_start_ext_adv_sync()
> > at the moment synchronously calls SET_EXT_ADV_PARAMS [1],
> > SET_ADV_SET_RAND_ADDR [2], SET_EXT_SCAN_RSP_DATA [3](optional) and
> > SET_EXT_ADV_ENABLE [4].  After all synchronous commands are finished,
> > SET_EXT_ADV_DATA is called from the async response handler of
> > SET_EXT_ADV_PARAMS [5] (via hci_update_adv_data).
> >
> > So the current implementation sets the advertising data AFTER enabling
> > the advertising instance.  The BT Core specification explicitly allows
> > for this [6]:
> >
> > > If advertising is currently enabled for the specified advertising set,
> > > the Controller shall use the new data in subsequent extended
> > > advertising events for this advertising set. If an extended
> > > advertising event is in progress when this command is issued, the
> > > Controller may use the old or new data for that event.
>=20
> Ok, lets stop right here, if the controller deviates from the spec it
> needs a quirk and not make the whole stack work around a bug in the
> firmware.
I generally agree! In this particular case, I think that the current order =
of
advertising commands may be the result of "random" and was probably not int=
ended this
way. While the command order of the "legacy" advertising commands looks per=
fectly
logical for me, the order of the "extended" commands seems to be broken by =
setting
the advertising data in the asynchronous response handler of set_ext_adv_pa=
rams.

>=20
> > In case of the Realtek RTL8761BU chip (almost all contemporary BT USB
> > dongles are built on it), updating the advertising data after enabling
> > the instance produces (at least one) corrupted advertising message.
> > Under normal conditions, a single corrupted advertising message would
> > probably not attract much attention, but during MESH provisioning (via
> > MGMT I/O / mesh_send(_sync)), up to 3 different messages (BEACON, ACK,
> > CAPS) are sent within a loop which causes corruption of ALL provisioning
> > messages.
> >
> > I have no idea whether this could be fixed in the firmware of the USB
> > dongles (I didn't even find the chip on the Realtek homepage), but
> > generally I would suggest changing the order of the HCI commands as this
> > matches the command order for "non-extended adv capable" controllers and
> > simply is more natural.
> >
> > This patch only considers advertising instances with handle > 0, I don't
> > know whether this should be extended to further cases.
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/net/bluetooth/hci_sync.c#n1319
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/net/bluetooth/hci_sync.c#n1204
> > [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/net/bluetooth/hci_sync.c#n1471
> > [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/net/bluetooth/hci_sync.c#n1469
> > [5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/net/bluetooth/hci_event.c#n2180
> > [6] https://www.bluetooth.com/wp-content/uploads/Files/Specification/HT=
ML/Core-60/out/en/host-controller-interface/host-controller-interface-funct=
ional-specification.html#UUID-d4f36cb5-f26c-d053-1034-e7a547ed6a13
> >
> > Signed-off-by: Christian Eggers <ceggers@arri.de>
> > Fixes: a0fb3726ba55 ("Bluetooth: Use Set ext adv/scan rsp data if contr=
oller supports")
> > Cc: stable@vger.kernel.org
> > ---
> >  include/net/bluetooth/hci_core.h |  1 +
> >  include/net/bluetooth/hci_sync.h |  1 +
> >  net/bluetooth/hci_event.c        | 33 +++++++++++++++++++++++++++++
> >  net/bluetooth/hci_sync.c         | 36 ++++++++++++++++++++++++++------
> >  4 files changed, 65 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index 9fc8f544e20e..8d37f127ddba 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -237,6 +237,7 @@ struct oob_data {
> >
> >  struct adv_info {
> >         struct list_head list;
> > +       bool    enable_after_set_ext_data;
> >         bool    enabled;
> >         bool    pending;
> >         bool    periodic;
> > diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/h=
ci_sync.h
> > index 5224f57f6af2..00eceffeec87 100644
> > --- a/include/net/bluetooth/hci_sync.h
> > +++ b/include/net/bluetooth/hci_sync.h
> > @@ -112,6 +112,7 @@ int hci_schedule_adv_instance_sync(struct hci_dev *=
hdev, u8 instance,
> >  int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance);
> >  int hci_start_ext_adv_sync(struct hci_dev *hdev, u8 instance);
> >  int hci_enable_ext_advertising_sync(struct hci_dev *hdev, u8 instance);
> > +int hci_enable_ext_advertising(struct hci_dev *hdev, u8 instance);
> >  int hci_enable_advertising_sync(struct hci_dev *hdev);
> >  int hci_enable_advertising(struct hci_dev *hdev);
> >
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 66052d6aaa1d..eb018d8a3c4b 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -2184,6 +2184,37 @@ static u8 hci_cc_set_ext_adv_param(struct hci_de=
v *hdev, void *data,
> >         return rp->status;
> >  }
> >
> > +static u8 hci_cc_le_set_ext_adv_data(struct hci_dev *hdev, void *data,
> > +                                    struct sk_buff *skb)
> > +{
> > +       struct hci_cp_le_set_ext_adv_data *cp;
> > +       struct hci_ev_status *rp =3D data;
> > +       struct adv_info *adv_instance;
> > +
> > +       bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
> > +
> > +       if (rp->status)
> > +               return rp->status;
> > +
> > +       cp =3D hci_sent_cmd_data(hdev, HCI_OP_LE_SET_EXT_ADV_DATA);
> > +       if (!cp)
> > +               return rp->status;
> > +
> > +       hci_dev_lock(hdev);
> > +
> > +       if (cp->handle) {
> > +               adv_instance =3D hci_find_adv_instance(hdev, cp->handle=
);
> > +               if (adv_instance) {
> > +                       if (adv_instance->enable_after_set_ext_data)
> > +                               hci_enable_ext_advertising(hdev, cp->ha=
ndle);
> > +               }
> > +       }
> > +
> > +       hci_dev_unlock(hdev);
> > +
> > +       return rp->status;
> > +}
> > +
> >  static u8 hci_cc_read_rssi(struct hci_dev *hdev, void *data,
> >                            struct sk_buff *skb)
> >  {
> > @@ -4166,6 +4197,8 @@ static const struct hci_cc {
> >                sizeof(struct hci_rp_le_read_num_supported_adv_sets)),
> >         HCI_CC(HCI_OP_LE_SET_EXT_ADV_PARAMS, hci_cc_set_ext_adv_param,
> >                sizeof(struct hci_rp_le_set_ext_adv_params)),
> > +       HCI_CC_STATUS(HCI_OP_LE_SET_EXT_ADV_DATA,
> > +                     hci_cc_le_set_ext_adv_data),
> >         HCI_CC_STATUS(HCI_OP_LE_SET_EXT_ADV_ENABLE,
> >                       hci_cc_le_set_ext_adv_enable),
> >         HCI_CC_STATUS(HCI_OP_LE_SET_ADV_SET_RAND_ADDR,
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index 1f8806dfa556..da0e39cce721 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -1262,6 +1262,7 @@ int hci_setup_ext_adv_instance_sync(struct hci_de=
v *hdev, u8 instance)
> >                 hci_cpu_to_le24(adv->max_interval, cp.max_interval);
> >                 cp.tx_power =3D adv->tx_power;
> >                 cp.sid =3D adv->sid;
> > +               adv->enable_after_set_ext_data =3D true;
> >         } else {
> >                 hci_cpu_to_le24(hdev->le_adv_min_interval, cp.min_inter=
val);
> >                 hci_cpu_to_le24(hdev->le_adv_max_interval, cp.max_inter=
val);
> > @@ -1456,6 +1457,23 @@ int hci_enable_ext_advertising_sync(struct hci_d=
ev *hdev, u8 instance)
> >                                      data, HCI_CMD_TIMEOUT);
> >  }
> >
> > +static int enable_ext_advertising_sync(struct hci_dev *hdev, void *dat=
a)
> > +{
> > +       u8 instance =3D PTR_UINT(data);
> > +
> > +       return hci_enable_ext_advertising_sync(hdev, instance);
> > +}
> > +
> > +int hci_enable_ext_advertising(struct hci_dev *hdev, u8 instance)
> > +{
> > +       if (!hci_dev_test_flag(hdev, HCI_ADVERTISING) &&
> > +           list_empty(&hdev->adv_instances))
> > +               return 0;
> > +
> > +       return hci_cmd_sync_queue(hdev, enable_ext_advertising_sync,
> > +                                 UINT_PTR(instance), NULL);
> > +}
> > +
> >  int hci_start_ext_adv_sync(struct hci_dev *hdev, u8 instance)
> >  {
> >         int err;
> > @@ -1464,11 +1482,11 @@ int hci_start_ext_adv_sync(struct hci_dev *hdev=
, u8 instance)
> >         if (err)
> >                 return err;
> >
> > -       err =3D hci_set_ext_scan_rsp_data_sync(hdev, instance);
> > -       if (err)
> > -               return err;
> > -
> > -       return hci_enable_ext_advertising_sync(hdev, instance);
> > +       /* SET_EXT_ADV_DATA and SET_EXT_ADV_ENABLE are called in the
> > +        * asynchronous response chain of set_ext_adv_params in order to
> > +        * set the advertising data first prior enabling it.
> > +        */
>=20
> Doing things asynchronously is known to create problems, which is why
> we introduced the cmd_sync infra to handle a chain of commands like
> this, so Id suggest sticking to the synchronous way, if the order
> needs to be changed then use a quirk to detect it and then make sure
> the instance is disabled on hci_set_ext_adv_data_sync and then
> re-enable after updating it.

Directly after creation, the instance is disabled (which is fine). In my
opinion, the problem is then caused by enabling the instance _before_ setti=
ng
the advertisement data.

If the synchronous API is preferred, setting the advertisement data should
probably also be done synchronously (e.g. by calling hci_set_ext_adv_data_s=
ync()
from hci_start_ext_adv_sync() rather than calling hci_update_adv_data() from
hci_cc_set_ext_adv_param()). But I guess that the "tx power" value is only
known after hci_cc_set_ext_adv_param() has been run (queued?) and this is p=
robably
too late for the synchronous stuff called by hci_start_ext_adv_sync().

>=20
> > +       return hci_set_ext_scan_rsp_data_sync(hdev, instance);
> >  }
> >
> >  int hci_disable_per_advertising_sync(struct hci_dev *hdev, u8 instance)
> > @@ -1832,8 +1850,14 @@ static int hci_set_ext_adv_data_sync(struct hci_=
dev *hdev, u8 instance)
> >
> >         if (instance) {
> >                 adv =3D hci_find_adv_instance(hdev, instance);
> > -               if (!adv || !adv->adv_data_changed)
> > +               if (!adv)
> >                         return 0;
> > +               if (!adv->adv_data_changed) {
> > +                       if (adv->enable_after_set_ext_data)
> > +                               hci_enable_ext_advertising_sync(hdev,
> > +                                                               adv->ha=
ndle);
> > +                       return 0;
> > +               }
> >         }
> >
> >         len =3D eir_create_adv_data(hdev, instance, pdu->data,
> > --
> > 2.43.0
> >
>=20
>=20
>=20
regards,
Christian



regards,
Christian




