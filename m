Return-Path: <stable+bounces-161366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A12B4AFD967
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 23:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92A71480DA8
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 21:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C517238142;
	Tue,  8 Jul 2025 21:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="AVE5SJvH"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012000.outbound.protection.outlook.com [52.101.71.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D496D23C8B3;
	Tue,  8 Jul 2025 21:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752009317; cv=fail; b=tL28fcXSdMjAHb0q5QMvlFLMVaTDmwmAyPlENBjwvh0a91B9ySLuU6XVtrjo+ENZ7fX5bO+/83FMpHF7r6mkm6lgOVSsBKQuTioKqUQTw72Q56O65At+qTTUoL7xdYEo9WBcvZpwwj3iYGr3wJ1Pd9USx05ezHFH1rJJBYcC3aU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752009317; c=relaxed/simple;
	bh=IWiNtKqvQycirbNc/huMIVrmq6YovSCMUhRKN2sTvwY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KXtD1kjKq2BZ/tegD4qbO8q/TVExd64JQwSaFsqhqC6uiluguDYo9I3xTLyWTjibpa9pzINvKjYbw0DLbM0eXCMAlIvx3CSr/NLov++Rp2AaUEdR+tEQyLcmWLTm9m+nRHkcZnx7TzlP+7ZQgqtHiramExOOp3PY48blULbDRWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=AVE5SJvH; arc=fail smtp.client-ip=52.101.71.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNBq6vZA4zDVwAk7AmZjesh+4nJqqyzJx2H4UPod7ask4ma4P86dsVbHQxuHx6JauWoXhMmB+jeP6pwQPrHV/65rr+ZzfcvMI4hBqnZJcDaJccxcayzTUowpRXp+3y6ThAkkGqj9p/8EdRa6abj5hREOIMXHCzdqIGFS4gy/JECKcHKR0Y7T5AY/yHPQF+FCHfC1m/RIS6i31GtNTw+z+LFn64vYL5R3Hzjqr+HOcABamTlAX3WBQlr5v+qf1BF1DL1MLpk51zgwWVrTA5g781KrhG7a75yl+5m0v7o+UoB719XjxYT4GhSbRBL7p3rI5S4CKkJKnJ+3+VuPft7qzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6zG/oPbQ0xVX8fjsrw7+VgKpnvvW8sSwRXd3xNf3rA=;
 b=IJSShm9Cs9wQsrB2s40heq6zNZ4fjvIvH0jnNa9fcM+BnQR2qDd5BtjASwX7AQeTKZxVa6zbOgHdjMRVqoH0LMjBTgUOYaDp8SztEmT1UgRCfNSjwc+VIwmzYeeURY/Qk5L8234x9SJlGsyJvY9i+GWuocdLAI2KmrWiTGw5EPSE0k2jF49As0LEy44V4LQcAUoLkgBT8B/Kc+uqjH6UAOOVug9HgNoA7SMrIXyHo53mIpKPAyvOPMeXisSTrDmoVAoAa67/Q4gBlnPmcquWsUTSlQMaijQVFX8LP7Qmh/nO7VopyNyCnTErBdkUleUt2X7D3/c4xLl/xsVNitlXig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6zG/oPbQ0xVX8fjsrw7+VgKpnvvW8sSwRXd3xNf3rA=;
 b=AVE5SJvHGaNJrRv4hJ2RmF8BSwx4m5OeDADAUP3Y5GIJN5e/4UT8HA+Y+8mbl5UnAzQcIbzxKr3V/CyUjyKlpLljay9ZvkJRqNzredksNac75Zr8EwbJlTeJx2kGqnp12yYQTMuxr4mIWyWm3TAJHpQzBrjxFEUOQICJT7nRJ+M=
Received: from DUZPR01CA0107.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::25) by AS2PR03MB9768.eurprd03.prod.outlook.com
 (2603:10a6:20b:60b::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 21:15:01 +0000
Received: from DB1PEPF00039233.eurprd03.prod.outlook.com
 (2603:10a6:10:4bb:cafe::58) by DUZPR01CA0107.outlook.office365.com
 (2603:10a6:10:4bb::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Tue,
 8 Jul 2025 21:15:14 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF00039233.mail.protection.outlook.com (10.167.8.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.20 via Frontend Transport; Tue, 8 Jul 2025 21:15:00 +0000
Received: from n9w6sw14.localnet (192.168.54.11) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Tue, 8 Jul
 2025 23:15:00 +0200
From: Christian Eggers <ceggers@arri.de>
To: Greg KH <gregkh@linuxfoundation.org>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>
CC: <stable@vger.kernel.org>
Subject: Re: [PATCH 6.6.y] Bluetooth: HCI: Set extended advertising data synchronously
Date: Tue, 8 Jul 2025 23:14:59 +0200
Message-ID: <22184570.4csPzL39Zc@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <CABBYNZJKGkqU0=Wt9mWurhw9zL=np-NPhpCDFh_aN2Y-i0ZkRw@mail.gmail.com>
References: <2025070625-wafer-speed-20c1@gregkh> <2025070807-dimple-radish-723b@gregkh>
 <CABBYNZJKGkqU0=Wt9mWurhw9zL=np-NPhpCDFh_aN2Y-i0ZkRw@mail.gmail.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00039233:EE_|AS2PR03MB9768:EE_
X-MS-Office365-Filtering-Correlation-Id: b0b54e4a-5825-4bfe-bf6c-08ddbe647fea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHhIYVNkc2lUdzBIckRVMlFsais3WjNTTjlxOFJDZVVkeVJIUHFFd2dwWU9v?=
 =?utf-8?B?ci92YTd0NlZYb0pZZWxja0hLV25KTFM3Y1JWOFIxMUFGcDBKeEd5cmxNTGdw?=
 =?utf-8?B?aFNmaktPbGpXQ0R4L1B0QlhPR3dDVUt4RmNKVjFNd1prT2FJQzNOYnY3eHZL?=
 =?utf-8?B?QW9XWnc1eFdHMENoSGpURlhRVEFpOXUvZDdNZk8zS2Zmdm1VRFNwQUtmYTJN?=
 =?utf-8?B?Mk40eENVN1EzQUoyYTJpRE5GNk54SjR1Q2tTLzBCbng3K3ZmbkgvNU4xWjZa?=
 =?utf-8?B?ZjVnMTJkQkhCTU1EWU85YzUyMmQyVTNSLytDK3JNb3BSclRNTkpKUm51Wkls?=
 =?utf-8?B?K3NBOXIrYTdpTWE0NGhyQlA4RktsdzJaclJqK3IwVG9RSWhxVEdVdUpYd1dn?=
 =?utf-8?B?TGJ4T09kTUFOZlRzYmVoMm5JZVNyTk5TTm8rekNJVlFNTEJqR1JPQlNXeHMz?=
 =?utf-8?B?cUF4RDJobmhFTlRIRXptZnRZUGp1Ujk1WldHSGs2NHJDWGE0YmdqeElVUHZC?=
 =?utf-8?B?UkxUUGtFTkppY1Fud0tCZ2ttZkRJbEpQczJjOUdkVHBYRXplcVdESWRCb1Q0?=
 =?utf-8?B?YWJ0ek1reFN3QVZmdkFnOStmWFlXdWhtOGE4ZmFCOHpZTWlqYmNoQzZ4emI0?=
 =?utf-8?B?S3BVZG1xaHhkK3MzcE5EQ1N2Q1hQSElnUU5tVHdqZ1UyUm01VDhBRWxvWUk3?=
 =?utf-8?B?dXhqajB3djVZQ0Izb1AvSU5MRlZPcS9UQjIxZ3ZYZFRlWDRKREh2WGZJYW8w?=
 =?utf-8?B?dGtQK0Z5MDZzQjI4SWluMUN4SlBIdWdJMzFhbEprSzQ0dVd5aC9RUWNPaVRL?=
 =?utf-8?B?ZVFQMUZDTGlUZUlQUVNsMDVxNi9JNloyV3hkZmdkeWlLL1ZrLzIxNS8xV1ZK?=
 =?utf-8?B?ZkdNV2ZaK1U3YXV4eTZLSFAyM1Mza2R6UFB0NGh5aExPME1sTm5ucmRuRHFr?=
 =?utf-8?B?SGFZbUNMeTBoazNOdGpWbkVrdWVIZjVPR3ZoWW82QjlvbEdldTZzR0ZheFFq?=
 =?utf-8?B?WCt6YVNRZE9HTnUyWTJtWG9Ma2ZWWUd3WmlxcWg0WTBoRnAwcEhIQ0ZISEZn?=
 =?utf-8?B?K2JFS3lLSUhvQ3hLWFhZVnBrd2pVM2g5WkJXejVZamNKNHVIZkNXZUpwMEdh?=
 =?utf-8?B?Skp5a0xzUng3L3ZCa0JlQlBGMXlUZnliU0M4bHVCdG1pOGpHRElFR0RuQmV4?=
 =?utf-8?B?SU5Id3R6OEJZK2RsR0Foejh0OHBONE15bkRLMmRUZmgxRFgwOTB6WG95NDQ5?=
 =?utf-8?B?NnBwbWhtUmxMTW8xVGlXZFpYUkcyZzg0RjdqSEw0RTl1U2xLSlIwa0ozVzVr?=
 =?utf-8?B?eEIvNXdxTmZVVTlpMVRVSHpSelRMbFJvTmVGQnd6K0dNbktnUXFkeHN4a0Jl?=
 =?utf-8?B?Z0I1UEVyNUVKbGVMdW9OeXRsT0ZHeFA1anpDdXVRMEFMVkt6K1hrdXlyN21s?=
 =?utf-8?B?aXZPN09ZNkxGRUszR295SURCM2dRZHYxWFdFcnRqRGovdEhZajV1MnV2bzlF?=
 =?utf-8?B?bmlBYXg3bW5JV0xpZGZYa2lUQWVKTElNL2dOamlXMjF2N1hNWTdCNkxIQlFP?=
 =?utf-8?B?Q01JQldnY1ZGQkplZGdIdGZzSW9BZUxIY1hVZGRmZXNIeXJYUFBBb0hJWGky?=
 =?utf-8?B?YVVnNlJLT01sSGk2YTc5bVoxelZRYUxZSVFQSDA0L0VrT1daSi8zSDA1S05R?=
 =?utf-8?B?eUY3VGJPZzkxS2dWTmZEVENHanZLVHJqR2ZFT3hSWUZHQUpzUUNqU0pNS3Ey?=
 =?utf-8?B?NUdENEhHMXltbDFBQ016RDdDRGl5UkR4dmEwWVlSdGM0SzB2bHk5anhjMG9s?=
 =?utf-8?B?N2xEZy9DcUg0SzJDZkVWQzZSaUJ2ekZydGZnaVJUWUZtdUtDQy93TXVxdG1N?=
 =?utf-8?B?S3NweW9CeThjRWp0ZkFPekVQZXR3WklTTHRhazB5YTBLQU1TOEt5eHBycVRE?=
 =?utf-8?B?NHF5eW5BamZ0R3ZwOEkrMmpnK2hFRTFUdWUzWEpSVmZ6aVQ0VHE3YnJML1BN?=
 =?utf-8?B?WkIwZFVjM0RMb254NC93d3FLTURSVUZpRTNpbVVWMENaWDM5RGl2cGRhSWZN?=
 =?utf-8?B?R0lVVUF0MmpMVHBSVG1lZEQzWW9XdElFRENHUT09?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 21:15:00.7853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b54e4a-5825-4bfe-bf6c-08ddbe647fea
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9768

Hi Luiz, hi Greg,

On Tuesday, 8 July 2025, 17:56:07 CEST, Luiz Augusto von Dentz wrote:
> Hi Christian,
>=20
> On Tue, Jul 8, 2025 at 11:39=E2=80=AFAM Greg KH <gregkh@linuxfoundation.o=
rg> wrote:
> >
> > On Mon, Jul 07, 2025 at 10:13:07AM +0200, Christian Eggers wrote:
> > > Upstream commit 89fb8acc38852116d38d721ad394aad7f2871670
> > >
> > > Currently, for controllers with extended advertising, the advertising
> > > data is set in the asynchronous response handler for extended
> > > adverstising params. As most advertising settings are performed in a
> > > synchronous context, the (asynchronous) setting of the advertising da=
ta
> > > is done too late (after enabling the advertising).
> > >
> > > Move setting of adverstising data from asynchronous response handler
> > > into synchronous context to fix ordering of HCI commands.
> > >
> > > Signed-off-by: Christian Eggers <ceggers@arri.de>
> > > Fixes: a0fb3726ba55 ("Bluetooth: Use Set ext adv/scan rsp data if con=
troller supports")
> > > Cc: stable@vger.kernel.org
> > > v2: https://lore.kernel.org/linux-bluetooth/20250626115209.17839-1-ce=
ggers@arri.de/
> > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > ---
> > >  net/bluetooth/hci_event.c |  36 -------
> > >  net/bluetooth/hci_sync.c  | 213 ++++++++++++++++++++++++------------=
=2D-
> > >  2 files changed, 133 insertions(+), 116 deletions(-)
> > >
> > > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > > index 008d14b3d8b8..147766458a6c 100644
> > > --- a/net/bluetooth/hci_event.c
> > > +++ b/net/bluetooth/hci_event.c
> > > @@ -2139,40 +2139,6 @@ static u8 hci_cc_set_adv_param(struct hci_dev =
*hdev, void *data,
> > >       return rp->status;
> > >  }
> > >
> > > -static u8 hci_cc_set_ext_adv_param(struct hci_dev *hdev, void *data,
> > > -                                struct sk_buff *skb)
> > > -{
> > > -     struct hci_rp_le_set_ext_adv_params *rp =3D data;
> > > -     struct hci_cp_le_set_ext_adv_params *cp;
> > > -     struct adv_info *adv_instance;
> > > -
> > > -     bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
> > > -
> > > -     if (rp->status)
> > > -             return rp->status;
> > > -
> > > -     cp =3D hci_sent_cmd_data(hdev, HCI_OP_LE_SET_EXT_ADV_PARAMS);
> > > -     if (!cp)
> > > -             return rp->status;
> > > -
> > > -     hci_dev_lock(hdev);
> > > -     hdev->adv_addr_type =3D cp->own_addr_type;
> > > -     if (!cp->handle) {
> > > -             /* Store in hdev for instance 0 */
> > > -             hdev->adv_tx_power =3D rp->tx_power;
> > > -     } else {
> > > -             adv_instance =3D hci_find_adv_instance(hdev, cp->handle=
);
> > > -             if (adv_instance)
> > > -                     adv_instance->tx_power =3D rp->tx_power;
> > > -     }
> > > -     /* Update adv data as tx power is known now */
> > > -     hci_update_adv_data(hdev, cp->handle);
> > > -
> > > -     hci_dev_unlock(hdev);
> > > -
> > > -     return rp->status;
> > > -}
> > > -
> > >  static u8 hci_cc_read_rssi(struct hci_dev *hdev, void *data,
> > >                          struct sk_buff *skb)
> > >  {
> > > @@ -4153,8 +4119,6 @@ static const struct hci_cc {
> > >       HCI_CC(HCI_OP_LE_READ_NUM_SUPPORTED_ADV_SETS,
> > >              hci_cc_le_read_num_adv_sets,
> > >              sizeof(struct hci_rp_le_read_num_supported_adv_sets)),
> > > -     HCI_CC(HCI_OP_LE_SET_EXT_ADV_PARAMS, hci_cc_set_ext_adv_param,
> > > -            sizeof(struct hci_rp_le_set_ext_adv_params)),
> > >       HCI_CC_STATUS(HCI_OP_LE_SET_EXT_ADV_ENABLE,
> > >                     hci_cc_le_set_ext_adv_enable),
> > >       HCI_CC_STATUS(HCI_OP_LE_SET_ADV_SET_RAND_ADDR,
> > > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > > index e92bc4ceb5ad..7b6c8f53e334 100644
> > > --- a/net/bluetooth/hci_sync.c
> > > +++ b/net/bluetooth/hci_sync.c
> > > @@ -1224,9 +1224,129 @@ static int hci_set_adv_set_random_addr_sync(s=
truct hci_dev *hdev, u8 instance,
> > >                                    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> > >  }
> > >
> > > +static int
> > > +hci_set_ext_adv_params_sync(struct hci_dev *hdev, struct adv_info *a=
dv,
> > > +                         const struct hci_cp_le_set_ext_adv_params *=
cp,
> > > +                         struct hci_rp_le_set_ext_adv_params *rp)
> > > +{
> > > +     struct sk_buff *skb;
> > > +
> > > +     skb =3D __hci_cmd_sync(hdev, HCI_OP_LE_SET_EXT_ADV_PARAMS, size=
of(*cp),
> > > +                          cp, HCI_CMD_TIMEOUT);
> > > +
> > > +     /* If command return a status event, skb will be set to -ENODAT=
A */
> > > +     if (skb =3D=3D ERR_PTR(-ENODATA))
> > > +             return 0;
> > > +
> > > +     if (IS_ERR(skb)) {
> > > +             bt_dev_err(hdev, "Opcode 0x%4.4x failed: %ld",
> > > +                        HCI_OP_LE_SET_EXT_ADV_PARAMS, PTR_ERR(skb));
> > > +             return PTR_ERR(skb);
> > > +     }
> > > +
> > > +     if (skb->len !=3D sizeof(*rp)) {
> > > +             bt_dev_err(hdev, "Invalid response length for 0x%4.4x: =
%u",
> > > +                        HCI_OP_LE_SET_EXT_ADV_PARAMS, skb->len);
> > > +             kfree_skb(skb);
> > > +             return -EIO;
> > > +     }
> > > +
> > > +     memcpy(rp, skb->data, sizeof(*rp));
> > > +     kfree_skb(skb);
> > > +
> > > +     if (!rp->status) {
> > > +             hdev->adv_addr_type =3D cp->own_addr_type;
> > > +             if (!cp->handle) {
> > > +                     /* Store in hdev for instance 0 */
> > > +                     hdev->adv_tx_power =3D rp->tx_power;
> > > +             } else if (adv) {
> > > +                     adv->tx_power =3D rp->tx_power;
> > > +             }
> > > +     }
> > > +
> > > +     return rp->status;
> > > +}
> > > +
> > > +static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instan=
ce)
> > > +{
> > > +     struct {
> > > +             struct hci_cp_le_set_ext_adv_data cp;
> > > +             u8 data[HCI_MAX_EXT_AD_LENGTH];
> > > +     } pdu;
> > > +     u8 len;
> > > +     struct adv_info *adv =3D NULL;
> > > +     int err;
> > > +
> > > +     memset(&pdu, 0, sizeof(pdu));
> > > +
> > > +     if (instance) {
> > > +             adv =3D hci_find_adv_instance(hdev, instance);
> > > +             if (!adv || !adv->adv_data_changed)
> > > +                     return 0;
> > > +     }
> > > +
> > > +     len =3D eir_create_adv_data(hdev, instance, pdu.data);
> > > +
> > > +     pdu.cp.length =3D len;
> > > +     pdu.cp.handle =3D instance;
> > > +     pdu.cp.operation =3D LE_SET_ADV_DATA_OP_COMPLETE;
> > > +     pdu.cp.frag_pref =3D LE_SET_ADV_DATA_NO_FRAG;
> > > +
> > > +     err =3D __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_DATA,
> > > +                                 sizeof(pdu.cp) + len, &pdu.cp,
> > > +                                 HCI_CMD_TIMEOUT);
> > > +     if (err)
> > > +             return err;
> > > +
> > > +     /* Update data if the command succeed */
> > > +     if (adv) {
> > > +             adv->adv_data_changed =3D false;
> > > +     } else {
> > > +             memcpy(hdev->adv_data, pdu.data, len);
> > > +             hdev->adv_data_len =3D len;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int hci_set_adv_data_sync(struct hci_dev *hdev, u8 instance)
> > > +{
> > > +     struct hci_cp_le_set_adv_data cp;
> > > +     u8 len;
> > > +
> > > +     memset(&cp, 0, sizeof(cp));
> > > +
> > > +     len =3D eir_create_adv_data(hdev, instance, cp.data);
> > > +
> > > +     /* There's nothing to do if the data hasn't changed */
> > > +     if (hdev->adv_data_len =3D=3D len &&
> > > +         memcmp(cp.data, hdev->adv_data, len) =3D=3D 0)
> > > +             return 0;
> > > +
> > > +     memcpy(hdev->adv_data, cp.data, sizeof(cp.data));
> > > +     hdev->adv_data_len =3D len;
> > > +
> > > +     cp.length =3D len;
> > > +
> > > +     return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_DATA,
> > > +                                  sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> > > +}
> > > +
> > > +int hci_update_adv_data_sync(struct hci_dev *hdev, u8 instance)
> > > +{
> > > +     if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
> > > +             return 0;
> > > +
> > > +     if (ext_adv_capable(hdev))
> > > +             return hci_set_ext_adv_data_sync(hdev, instance);
> > > +
> > > +     return hci_set_adv_data_sync(hdev, instance);
> > > +}
> > > +
> > >  int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instanc=
e)
> > >  {
> > >       struct hci_cp_le_set_ext_adv_params cp;
> > > +     struct hci_rp_le_set_ext_adv_params rp;
> > >       bool connectable;
> > >       u32 flags;
> > >       bdaddr_t random_addr;
> > > @@ -1333,8 +1453,12 @@ int hci_setup_ext_adv_instance_sync(struct hci=
_dev *hdev, u8 instance)
> > >               cp.secondary_phy =3D HCI_ADV_PHY_1M;
> > >       }
> > >
> > > -     err =3D __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_PARAM=
S,
> > > -                                 sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> > > +     err =3D hci_set_ext_adv_params_sync(hdev, adv, &cp, &rp);
> > > +     if (err)
> > > +             return err;
> > > +
> > > +     /* Update adv data as tx power is known now */
> > > +     err =3D hci_set_ext_adv_data_sync(hdev, cp.handle);
> > >       if (err)
> > >               return err;
> > >
> > > @@ -1859,82 +1983,6 @@ int hci_le_terminate_big_sync(struct hci_dev *=
hdev, u8 handle, u8 reason)
> > >                                    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> > >  }
> > >
> > > -static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instan=
ce)
> > > -{
> > > -     struct {
> > > -             struct hci_cp_le_set_ext_adv_data cp;
> > > -             u8 data[HCI_MAX_EXT_AD_LENGTH];
> > > -     } pdu;
> > > -     u8 len;
> > > -     struct adv_info *adv =3D NULL;
> > > -     int err;
> > > -
> > > -     memset(&pdu, 0, sizeof(pdu));
> > > -
> > > -     if (instance) {
> > > -             adv =3D hci_find_adv_instance(hdev, instance);
> > > -             if (!adv || !adv->adv_data_changed)
> > > -                     return 0;
> > > -     }
> > > -
> > > -     len =3D eir_create_adv_data(hdev, instance, pdu.data);
> > > -
> > > -     pdu.cp.length =3D len;
> > > -     pdu.cp.handle =3D instance;
> > > -     pdu.cp.operation =3D LE_SET_ADV_DATA_OP_COMPLETE;
> > > -     pdu.cp.frag_pref =3D LE_SET_ADV_DATA_NO_FRAG;
> > > -
> > > -     err =3D __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_DATA,
> > > -                                 sizeof(pdu.cp) + len, &pdu.cp,
> > > -                                 HCI_CMD_TIMEOUT);
> > > -     if (err)
> > > -             return err;
> > > -
> > > -     /* Update data if the command succeed */
> > > -     if (adv) {
> > > -             adv->adv_data_changed =3D false;
> > > -     } else {
> > > -             memcpy(hdev->adv_data, pdu.data, len);
> > > -             hdev->adv_data_len =3D len;
> > > -     }
> > > -
> > > -     return 0;
> > > -}
> > > -
> > > -static int hci_set_adv_data_sync(struct hci_dev *hdev, u8 instance)
> > > -{
> > > -     struct hci_cp_le_set_adv_data cp;
> > > -     u8 len;
> > > -
> > > -     memset(&cp, 0, sizeof(cp));
> > > -
> > > -     len =3D eir_create_adv_data(hdev, instance, cp.data);
> > > -
> > > -     /* There's nothing to do if the data hasn't changed */
> > > -     if (hdev->adv_data_len =3D=3D len &&
> > > -         memcmp(cp.data, hdev->adv_data, len) =3D=3D 0)
> > > -             return 0;
> > > -
> > > -     memcpy(hdev->adv_data, cp.data, sizeof(cp.data));
> > > -     hdev->adv_data_len =3D len;
> > > -
> > > -     cp.length =3D len;
> > > -
> > > -     return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_DATA,
> > > -                                  sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> > > -}
> > > -
> > > -int hci_update_adv_data_sync(struct hci_dev *hdev, u8 instance)
> > > -{
> > > -     if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
> > > -             return 0;
> > > -
> > > -     if (ext_adv_capable(hdev))
> > > -             return hci_set_ext_adv_data_sync(hdev, instance);
> > > -
> > > -     return hci_set_adv_data_sync(hdev, instance);
> > > -}
> > > -
> > >  int hci_schedule_adv_instance_sync(struct hci_dev *hdev, u8 instance,
> > >                                  bool force)
> > >  {
> > > @@ -6257,6 +6305,7 @@ static int hci_le_ext_directed_advertising_sync=
(struct hci_dev *hdev,
> > >                                               struct hci_conn *conn)
> > >  {
> > >       struct hci_cp_le_set_ext_adv_params cp;
> > > +     struct hci_rp_le_set_ext_adv_params rp;
> > >       int err;
> > >       bdaddr_t random_addr;
> > >       u8 own_addr_type;
> > > @@ -6298,8 +6347,12 @@ static int hci_le_ext_directed_advertising_syn=
c(struct hci_dev *hdev,
> > >       if (err)
> > >               return err;
> > >
> > > -     err =3D __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_PARAM=
S,
> > > -                                 sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> > > +     err =3D hci_set_ext_adv_params_sync(hdev, NULL, &cp, &rp);
> > > +     if (err)
> > > +             return err;
> > > +
> > > +     /* Update adv data as tx power is known now */
> > > +     err =3D hci_set_ext_adv_data_sync(hdev, cp.handle);
> > >       if (err)
> > >               return err;
> > >
> > > --
> > > [Resend, upstream commit id was missing]
> > >
> > > Hi Greg,
> > >
> > > I've backported this patch for 6.6. There were some trivial merge
> > > conflicts due to moved coded sections.
> > >
> > > Please try it also for older trees. If I get any FAILED notices,
> > > I'll try to prepare patches for specific trees.
> >
> > You made major changes here from the upstream version, PLEASE document
> > them properly in the changelog.  Also, can you test it to verify that it
> > works and doesn't blow up the stack like I'm guessing it might?

@Greg: The only reason for the "differences" between the mainline and the 6=
=2E6
version of the patch is, that the existing code I had to move up within=20
hci_sync.c differs between these kernels. The actual modifications I made,
should be the same. Is this something I shall document in the changelog
(and resend the patch)?

I tested the patch by manually checking the output of the 'btmon' command
(Wireshark like utility for monitoring Bluetooth controller commands). I=20
compared the btmon output before and after my changes. Additionally I=20
(just) ran the mgmt-tester, as requested by Luiz (see below).

> @Christian Eggers try running resulting image with mgmt-tester and the
> following tests:
>=20
> Add Ext Advertising - Invalid Params 1 (Multiple Phys)
> Add Ext Advertising - Invalid Params 2 (Multiple PHYs)
> Add Ext Advertising - Invalid Params 3 (Multiple PHYs)
> Add Ext Advertising - Invalid Params 4 (Multiple PHYs)
> Add Ext Advertising - Success 1 (Powered, Add Adv Inst)
> Add Ext Advertising - Success 2 (!Powered, Add Adv Inst)
> Add Ext Advertising - Success 3 (!Powered, Adv Enable)
> Add Ext Advertising - Success 4 (Set Adv on override)
> Add Ext Advertising - Success 5 (Set Adv off override)
> Add Ext Advertising - Success 6 (Scan Rsp Dta, Adv ok)
> Add Ext Advertising - Success 7 (Scan Rsp Dta, Scan ok)
> Add Ext Advertising - Success 8 (Connectable Flag)
> Add Ext Advertising - Success 9 (General Discov Flag)
> Add Ext Advertising - Success 10 (Limited Discov Flag)
> Add Ext Advertising - Success 11 (Managed Flags)
> Add Ext Advertising - Success 12 (TX Power Flag)
> Add Ext Advertising - Success 13 (ADV_SCAN_IND)
> Add Ext Advertising - Success 14 (ADV_NONCONN_IND)
> Add Ext Advertising - Success 15 (ADV_IND)
> Add Ext Advertising - Success 16 (Connectable -> on)
> Add Ext Advertising - Success 17 (Connectable -> off)
> Add Ext Advertising - Success 20 (Add Adv override)
> Add Ext Advertising - Success 21 (Timeout expires)
> Add Ext Advertising - Success 22 (LE -> off, Remove)
> Add Ext Advertising - Success (Empty ScRsp)
> Add Ext Advertising - Success (ScRsp only)
> Add Ext Advertising - Invalid Params (ScRsp too long)
> Add Ext Advertising - Success (ScRsp appear)
> Add Ext Advertising - Invalid Params (ScRsp appear long)
> Add Ext Advertising - Success (Appear is null)
> Add Ext Advertising - Success (Name is null)
> Add Ext Advertising - Success (Complete name)
> Add Ext Advertising - Success (Shortened name)
> Add Ext Advertising - Success (Short name)
> Add Ext Advertising - Success (Name + data)
> Add Ext Advertising - Invalid Params (Name + data)
> Add Ext Advertising - Success (Name+data+appear)
> Add Ext Advertising - Success (PHY -> 1M)
> Add Ext Advertising - Success (PHY -> 2M)
> Add Ext Advertising - Success (PHY -> Coded)
> Add Ext Advertising - Success (Ext Pdu Scannable)
> Add Ext Advertising - Success (Ext Pdu Connectable)
> Add Ext Advertising - Success (Ext Pdu Conn Scan)
> Add Ext Advertising - Success (1m Connectable -> on)
> Add Ext Advertising - Success (1m Connectable -> off)
>=20
> This should exercise the code you are changing, I assume they should
> all pass with 6.6.y but perhaps you can discard if there were
> something not passing since it can be the result of mgmt-tester
> changes that are not backward compatible.

@Luiz: As this was the first time I used mgmt-tester, I had some fun learni=
ng
which kernel options need to be enabled and that using a debugger is not al=
ways
a good idea...

In order to run the test successfully, I had to revert bluez.git commit=20
122c9fcacfa9 ("mgmt-tester: Fix missing MGMT_SETTING_LL_PRIVACY")
(this commits requires newer kernels).
After that, the lists of tests you suggested ran successfully (see bottom
of this mail).

regards,
Christian

>=20
> > thanks,
> >
> > greg k-h
> >
>=20
>=20
>=20



Test run (all requested tests succeeded):

root@orbiter:~# while read TEST ; do echo "Test: $TEST"; mgmt-tester -s "$T=
EST"; done < tests.lst
Test: Add Ext Advertising - Invalid Params 1 (Multiple Phys)

Add Ext Advertising - Invalid Params 1 (Multiple Phys) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Invalid Params 1 (Multiple Phys) - setup
  Setup sending Set Low Energy (0x000d)
  Setup sending Set Powered (0x0005)
  Initial settings completed
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Add Ext Advertising - Invalid Params 1 (Multiple Phys) - setup complete
Add Ext Advertising - Invalid Params 1 (Multiple Phys) - run
  Sending Add Advertising (0x003e)
  Test condition added, total 1
  Add Advertising (0x003e): Invalid Parameters (0x0d)
  Test condition complete, 0 left
Add Ext Advertising - Invalid Params 1 (Multiple Phys) - test passed
Add Ext Advertising - Invalid Params 1 (Multiple Phys) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Invalid Params 1 (Multiple Phys) - teardown complete
Add Ext Advertising - Invalid Params 1 (Multiple Phys) - done


Test Summary
=2D-----------
Add Ext Advertising - Invalid Params 1 (Multiple Phys) Passed       0.621 s=
econds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 3.93 seconds
Test: Add Ext Advertising - Invalid Params 2 (Multiple PHYs)

Add Ext Advertising - Invalid Params 2 (Multiple PHYs) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Invalid Params 2 (Multiple PHYs) - setup
  Setup sending Set Low Energy (0x000d)
  Setup sending Set Powered (0x0005)
  Initial settings completed
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Add Ext Advertising - Invalid Params 2 (Multiple PHYs) - setup complete
Add Ext Advertising - Invalid Params 2 (Multiple PHYs) - run
  Sending Add Advertising (0x003e)
  Test condition added, total 1
  Add Advertising (0x003e): Invalid Parameters (0x0d)
  Test condition complete, 0 left
Add Ext Advertising - Invalid Params 2 (Multiple PHYs) - test passed
Add Ext Advertising - Invalid Params 2 (Multiple PHYs) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Invalid Params 2 (Multiple PHYs) - teardown complete
Add Ext Advertising - Invalid Params 2 (Multiple PHYs) - done


Test Summary
=2D-----------
Add Ext Advertising - Invalid Params 2 (Multiple PHYs) Passed       0.038 s=
econds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0385 seconds
Test: Add Ext Advertising - Invalid Params 3 (Multiple PHYs)

Add Ext Advertising - Invalid Params 3 (Multiple PHYs) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Invalid Params 3 (Multiple PHYs) - setup
  Setup sending Set Low Energy (0x000d)
  Setup sending Set Powered (0x0005)
  Initial settings completed
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Add Ext Advertising - Invalid Params 3 (Multiple PHYs) - setup complete
Add Ext Advertising - Invalid Params 3 (Multiple PHYs) - run
  Sending Add Advertising (0x003e)
  Test condition added, total 1
  Add Advertising (0x003e): Invalid Parameters (0x0d)
  Test condition complete, 0 left
Add Ext Advertising - Invalid Params 3 (Multiple PHYs) - test passed
Add Ext Advertising - Invalid Params 3 (Multiple PHYs) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Invalid Params 3 (Multiple PHYs) - teardown complete
Add Ext Advertising - Invalid Params 3 (Multiple PHYs) - done


Test Summary
=2D-----------
Add Ext Advertising - Invalid Params 3 (Multiple PHYs) Passed       0.040 s=
econds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0402 seconds
Test: Add Ext Advertising - Invalid Params 4 (Multiple PHYs)

Add Ext Advertising - Invalid Params 4 (Multiple PHYs) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Invalid Params 4 (Multiple PHYs) - setup
  Setup sending Set Low Energy (0x000d)
  Setup sending Set Powered (0x0005)
  Initial settings completed
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Add Ext Advertising - Invalid Params 4 (Multiple PHYs) - setup complete
Add Ext Advertising - Invalid Params 4 (Multiple PHYs) - run
  Sending Add Advertising (0x003e)
  Test condition added, total 1
  Add Advertising (0x003e): Invalid Parameters (0x0d)
  Test condition complete, 0 left
Add Ext Advertising - Invalid Params 4 (Multiple PHYs) - test passed
Add Ext Advertising - Invalid Params 4 (Multiple PHYs) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Invalid Params 4 (Multiple PHYs) - teardown complete
Add Ext Advertising - Invalid Params 4 (Multiple PHYs) - done


Test Summary
=2D-----------
Add Ext Advertising - Invalid Params 4 (Multiple PHYs) Passed       0.039 s=
econds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0393 seconds
Test: Add Ext Advertising - Success 1 (Powered, Add Adv Inst)

Add Ext Advertising - Success 1 (Powered, Add Adv Inst) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success 1 (Powered, Add Adv Inst) - setup
  Setup sending Set Low Energy (0x000d)
  Setup sending Set Powered (0x0005)
  Initial settings completed
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Add Ext Advertising - Success 1 (Powered, Add Adv Inst) - setup complete
Add Ext Advertising - Success 1 (Powered, Add Adv Inst) - run
  Registering Advertising Added notification
  Test condition added, total 1
  Registering HCI command callback
  Test condition added, total 2
  Sending Add Advertising (0x003e)
  Test condition added, total 3
  New Advertising Added event received
  Test condition complete, 2 left
  HCI Command 0x2036 length 25
  HCI Command 0x2037 length 13
  Test condition complete, 1 left
  HCI Command 0x2035 length 7
  HCI Command 0x2039 length 6
  Add Advertising (0x003e): Success (0x00)
  Test condition complete, 0 left
Add Ext Advertising - Success 1 (Powered, Add Adv Inst) - test passed
Add Ext Advertising - Success 1 (Powered, Add Adv Inst) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success 1 (Powered, Add Adv Inst) - teardown complete
Add Ext Advertising - Success 1 (Powered, Add Adv Inst) - done


Test Summary
=2D-----------
Add Ext Advertising - Success 1 (Powered, Add Adv Inst) Passed       0.045 =
seconds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0454 seconds
Test: Add Ext Advertising - Success 2 (!Powered, Add Adv Inst)

Add Ext Advertising - Success 2 (!Powered, Add Adv Inst) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success 2 (!Powered, Add Adv Inst) - setup
  Adding advertising instance while unpowered
  Add Advertising setup complete (instance 1)
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Add Ext Advertising - Success 2 (!Powered, Add Adv Inst) - setup complete
Add Ext Advertising - Success 2 (!Powered, Add Adv Inst) - run
  Registering HCI command callback
  Test condition added, total 1
  Sending Set Powered (0x0005)
  Test condition added, total 2
  HCI Command 0x0c6d length 2
  HCI Command 0x2036 length 25
  HCI Command 0x2037 length 11
  Test condition complete, 1 left
  HCI Command 0x2035 length 7
  HCI Command 0x2039 length 6
  HCI Command 0x0c13 length 248
  Set Powered (0x0005): Success (0x00)
  Test condition complete, 0 left
Add Ext Advertising - Success 2 (!Powered, Add Adv Inst) - test passed
Add Ext Advertising - Success 2 (!Powered, Add Adv Inst) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success 2 (!Powered, Add Adv Inst) - teardown complete
Add Ext Advertising - Success 2 (!Powered, Add Adv Inst) - done


Test Summary
=2D-----------
Add Ext Advertising - Success 2 (!Powered, Add Adv Inst) Passed       0.039=
 seconds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0396 seconds
Test: Add Ext Advertising - Success 3 (!Powered, Adv Enable)

Add Ext Advertising - Success 3 (!Powered, Adv Enable) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success 3 (!Powered, Adv Enable) - setup
  Adding advertising instance while unpowered
  Add Advertising setup complete (instance 1)
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Add Ext Advertising - Success 3 (!Powered, Adv Enable) - setup complete
Add Ext Advertising - Success 3 (!Powered, Adv Enable) - run
  Registering HCI command callback
  Test condition added, total 1
  Sending Set Powered (0x0005)
  Test condition added, total 2
  HCI Command 0x0c6d length 2
  HCI Command 0x2036 length 25
  HCI Command 0x2037 length 11
  HCI Command 0x2035 length 7
  HCI Command 0x2039 length 6
  Test condition complete, 1 left
  HCI Command 0x0c13 length 248
  Set Powered (0x0005): Success (0x00)
  Test condition complete, 0 left
Add Ext Advertising - Success 3 (!Powered, Adv Enable) - test passed
Add Ext Advertising - Success 3 (!Powered, Adv Enable) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success 3 (!Powered, Adv Enable) - teardown complete
Add Ext Advertising - Success 3 (!Powered, Adv Enable) - done


Test Summary
=2D-----------
Add Ext Advertising - Success 3 (!Powered, Adv Enable) Passed       0.041 s=
econds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0413 seconds
Test: Add Ext Advertising - Success 4 (Set Adv on override)

Add Ext Advertising - Success 4 (Set Adv on override) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success 4 (Set Adv on override) - setup
  Adding advertising instance while powered
  Add Advertising setup complete (instance 1)
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Add Ext Advertising - Success 4 (Set Adv on override) - setup complete
Add Ext Advertising - Success 4 (Set Adv on override) - run
  Registering HCI command callback
  Test condition added, total 1
  Sending Set Advertising (0x0029)
  Test condition added, total 2
  HCI Command 0x2036 length 25
  HCI Command 0x2037 length 7
  Test condition complete, 1 left
  HCI Command 0x2035 length 7
  HCI Command 0x2038 length 4
  HCI Command 0x2039 length 6
  Set Advertising (0x0029): Success (0x00)
  Test condition complete, 0 left
Add Ext Advertising - Success 4 (Set Adv on override) - test passed
Add Ext Advertising - Success 4 (Set Adv on override) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success 4 (Set Adv on override) - teardown complete
Add Ext Advertising - Success 4 (Set Adv on override) - done


Test Summary
=2D-----------
Add Ext Advertising - Success 4 (Set Adv on override) Passed       0.042 se=
conds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0425 seconds
Test: Add Ext Advertising - Success 5 (Set Adv off override)

Add Ext Advertising - Success 5 (Set Adv off override) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success 5 (Set Adv off override) - setup
  Set and add advertising instance
  Add Advertising setup complete (instance 1)
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Add Ext Advertising - Success 5 (Set Adv off override) - setup complete
Add Ext Advertising - Success 5 (Set Adv off override) - run
  Registering HCI command callback
  Test condition added, total 1
  Sending Set Advertising (0x0029)
  Test condition added, total 2
  HCI Command 0x2039 length 2
  Set Advertising (0x0029): Success (0x00)
  Test condition complete, 1 left
  HCI Command 0x2036 length 25
  HCI Command 0x2037 length 11
  Test condition complete, 0 left
Add Ext Advertising - Success 5 (Set Adv off override) - test passed
  HCI Command 0x2035 length 7
  HCI Command 0x2039 length 6
Add Ext Advertising - Success 5 (Set Adv off override) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success 5 (Set Adv off override) - teardown complete
Add Ext Advertising - Success 5 (Set Adv off override) - done


Test Summary
=2D-----------
Add Ext Advertising - Success 5 (Set Adv off override) Passed       0.042 s=
econds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0419 seconds
Test: Add Ext Advertising - Success 6 (Scan Rsp Dta, Adv ok)

Add Ext Advertising - Success 6 (Scan Rsp Dta, Adv ok) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success 6 (Scan Rsp Dta, Adv ok) - setup
  Setup sending Set Low Energy (0x000d)
  Setup sending Set Powered (0x0005)
  Initial settings completed
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Add Ext Advertising - Success 6 (Scan Rsp Dta, Adv ok) - setup complete
Add Ext Advertising - Success 6 (Scan Rsp Dta, Adv ok) - run
  Registering Advertising Added notification
  Test condition added, total 1
  Registering HCI command callback
  Test condition added, total 2
  Sending Add Advertising (0x003e)
  Test condition added, total 3
  New Advertising Added event received
  Test condition complete, 2 left
  HCI Command 0x2036 length 25
  HCI Command 0x2037 length 13
  Test condition complete, 1 left
  HCI Command 0x2035 length 7
  HCI Command 0x2038 length 14
  HCI Command 0x2039 length 6
  Add Advertising (0x003e): Success (0x00)
  Test condition complete, 0 left
Add Ext Advertising - Success 6 (Scan Rsp Dta, Adv ok) - test passed
Add Ext Advertising - Success 6 (Scan Rsp Dta, Adv ok) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success 6 (Scan Rsp Dta, Adv ok) - teardown complete
Add Ext Advertising - Success 6 (Scan Rsp Dta, Adv ok) - done


Test Summary
=2D-----------
Add Ext Advertising - Success 6 (Scan Rsp Dta, Adv ok) Passed       0.043 s=
econds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0436 seconds
Test: Add Ext Advertising - Success 7 (Scan Rsp Dta, Scan ok)

Add Ext Advertising - Success 7 (Scan Rsp Dta, Scan ok)  - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success 7 (Scan Rsp Dta, Scan ok)  - setup
  Setup sending Set Low Energy (0x000d)
  Setup sending Set Powered (0x0005)
  Initial settings completed
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Add Ext Advertising - Success 7 (Scan Rsp Dta, Scan ok)  - setup complete
Add Ext Advertising - Success 7 (Scan Rsp Dta, Scan ok)  - run
  Registering Advertising Added notification
  Test condition added, total 1
  Registering HCI command callback
  Test condition added, total 2
  Sending Add Advertising (0x003e)
  Test condition added, total 3
  New Advertising Added event received
  Test condition complete, 2 left
  HCI Command 0x2036 length 25
  HCI Command 0x2037 length 13
  HCI Command 0x2035 length 7
  HCI Command 0x2038 length 14
  Test condition complete, 1 left
  HCI Command 0x2039 length 6
  Add Advertising (0x003e): Success (0x00)
  Test condition complete, 0 left
Add Ext Advertising - Success 7 (Scan Rsp Dta, Scan ok)  - test passed
Add Ext Advertising - Success 7 (Scan Rsp Dta, Scan ok)  - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success 7 (Scan Rsp Dta, Scan ok)  - teardown complete
Add Ext Advertising - Success 7 (Scan Rsp Dta, Scan ok)  - done


Test Summary
=2D-----------
Add Ext Advertising - Success 7 (Scan Rsp Dta, Scan ok)  Passed       0.045=
 seconds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0449 seconds
Test: Add Ext Advertising - Success 8 (Connectable Flag)

Add Ext Advertising - Success 8 (Connectable Flag) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success 8 (Connectable Flag) - setup
  Setup sending Set Low Energy (0x000d)
  Setup sending Set Powered (0x0005)
  Initial settings completed
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Add Ext Advertising - Success 8 (Connectable Flag) - setup complete
Add Ext Advertising - Success 8 (Connectable Flag) - run
  Registering HCI command callback
  Test condition added, total 1
  Sending Add Advertising (0x003e)
  Test condition added, total 2
  HCI Command 0x2036 length 25
  Test condition complete, 1 left
  HCI Command 0x2037 length 13
  HCI Command 0x2039 length 6
  Add Advertising (0x003e): Success (0x00)
  Test condition complete, 0 left
Add Ext Advertising - Success 8 (Connectable Flag) - test passed
Add Ext Advertising - Success 8 (Connectable Flag) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success 8 (Connectable Flag) - teardown complete
Add Ext Advertising - Success 8 (Connectable Flag) - done


Test Summary
=2D-----------
Add Ext Advertising - Success 8 (Connectable Flag)   Passed       0.042 sec=
onds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0425 seconds
Test: Add Ext Advertising - Success 9 (General Discov Flag)

Add Ext Advertising - Success 9 (General Discov Flag) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success 9 (General Discov Flag) - setup
  Setup sending Set Low Energy (0x000d)
  Setup sending Set Powered (0x0005)
  Initial settings completed
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Add Ext Advertising - Success 9 (General Discov Flag) - setup complete
Add Ext Advertising - Success 9 (General Discov Flag) - run
  Registering HCI command callback
  Test condition added, total 1
  Sending Add Advertising (0x003e)
  Test condition added, total 2
  HCI Command 0x2036 length 25
  HCI Command 0x2037 length 16
  Test condition complete, 1 left
  HCI Command 0x2035 length 7
  HCI Command 0x2039 length 6
  Add Advertising (0x003e): Success (0x00)
  Test condition complete, 0 left
Add Ext Advertising - Success 9 (General Discov Flag) - test passed
Add Ext Advertising - Success 9 (General Discov Flag) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success 9 (General Discov Flag) - teardown complete
Add Ext Advertising - Success 9 (General Discov Flag) - done


Test Summary
=2D-----------
Add Ext Advertising - Success 9 (General Discov Flag) Passed       0.039 se=
conds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0405 seconds
Test: Add Ext Advertising - Success 10 (Limited Discov Flag)

Add Ext Advertising - Success 10 (Limited Discov Flag) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success 10 (Limited Discov Flag) - setup
  Setup sending Set Low Energy (0x000d)
  Setup sending Set Powered (0x0005)
  Initial settings completed
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Add Ext Advertising - Success 10 (Limited Discov Flag) - setup complete
Add Ext Advertising - Success 10 (Limited Discov Flag) - run
  Registering HCI command callback
  Test condition added, total 1
  Sending Add Advertising (0x003e)
  Test condition added, total 2
  HCI Command 0x2036 length 25
  HCI Command 0x2037 length 16
  Test condition complete, 1 left
  HCI Command 0x2035 length 7
  HCI Command 0x2039 length 6
  Add Advertising (0x003e): Success (0x00)
  Test condition complete, 0 left
Add Ext Advertising - Success 10 (Limited Discov Flag) - test passed
Add Ext Advertising - Success 10 (Limited Discov Flag) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success 10 (Limited Discov Flag) - teardown complete
Add Ext Advertising - Success 10 (Limited Discov Flag) - done


Test Summary
=2D-----------
Add Ext Advertising - Success 10 (Limited Discov Flag) Passed       0.040 s=
econds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.04 seconds
Test: Add Ext Advertising - Success 11 (Managed Flags)

Add Ext Advertising - Success 11 (Managed Flags) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success 11 (Managed Flags) - setup
  Setup sending Set Low Energy (0x000d)
  Setup sending Set Connectable (0x0007)
  Setup sending Set Powered (0x0005)
  Setup sending Set Discoverable (0x0006)
  Initial settings completed
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Add Ext Advertising - Success 11 (Managed Flags) - setup complete
Add Ext Advertising - Success 11 (Managed Flags) - run
  Registering HCI command callback
  Test condition added, total 1
  Sending Add Advertising (0x003e)
  Test condition added, total 2
  HCI Command 0x2036 length 25
  HCI Command 0x2037 length 16
  Test condition complete, 1 left
  HCI Command 0x2039 length 6
  Add Advertising (0x003e): Success (0x00)
  Test condition complete, 0 left
Add Ext Advertising - Success 11 (Managed Flags) - test passed
Add Ext Advertising - Success 11 (Managed Flags) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success 11 (Managed Flags) - teardown complete
Add Ext Advertising - Success 11 (Managed Flags) - done


Test Summary
=2D-----------
Add Ext Advertising - Success 11 (Managed Flags)     Passed       0.040 sec=
onds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0408 seconds
Test: Add Ext Advertising - Success 12 (TX Power Flag)

Add Ext Advertising - Success 12 (TX Power Flag) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success 12 (TX Power Flag) - setup
  Setup sending Set Low Energy (0x000d)
  Setup sending Set Connectable (0x0007)
  Setup sending Set Powered (0x0005)
  Setup sending Set Discoverable (0x0006)
  Initial settings completed
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Add Ext Advertising - Success 12 (TX Power Flag) - setup complete
Add Ext Advertising - Success 12 (TX Power Flag) - run
  Registering HCI command callback
  Test condition added, total 1
  Sending Add Advertising (0x003e)
  Test condition added, total 2
  HCI Command 0x2036 length 25
  HCI Command 0x2037 length 16
  Test condition complete, 1 left
  HCI Command 0x2039 length 6
  Add Advertising (0x003e): Success (0x00)
  Test condition complete, 0 left
Add Ext Advertising - Success 12 (TX Power Flag) - test passed
Add Ext Advertising - Success 12 (TX Power Flag) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success 12 (TX Power Flag) - teardown complete
Add Ext Advertising - Success 12 (TX Power Flag) - done


Test Summary
=2D-----------
Add Ext Advertising - Success 12 (TX Power Flag)     Passed       0.045 sec=
onds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0457 seconds
Test: Add Ext Advertising - Success 13 (ADV_SCAN_IND)

Add Ext Advertising - Success 13 (ADV_SCAN_IND) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success 13 (ADV_SCAN_IND) - setup
  Setup sending Set Low Energy (0x000d)
  Setup sending Set Powered (0x0005)
  Initial settings completed
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Add Ext Advertising - Success 13 (ADV_SCAN_IND) - setup complete
Add Ext Advertising - Success 13 (ADV_SCAN_IND) - run
  Registering HCI command callback
  Test condition added, total 1
  Sending Add Advertising (0x003e)
  Test condition added, total 2
  HCI Command 0x2036 length 25
  Test condition complete, 1 left
  HCI Command 0x2037 length 13
  HCI Command 0x2035 length 7
  HCI Command 0x2038 length 14
  HCI Command 0x2039 length 6
  Add Advertising (0x003e): Success (0x00)
  Test condition complete, 0 left
Add Ext Advertising - Success 13 (ADV_SCAN_IND) - test passed
Add Ext Advertising - Success 13 (ADV_SCAN_IND) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success 13 (ADV_SCAN_IND) - teardown complete
Add Ext Advertising - Success 13 (ADV_SCAN_IND) - done


Test Summary
=2D-----------
Add Ext Advertising - Success 13 (ADV_SCAN_IND)      Passed       0.039 sec=
onds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0397 seconds
Test: Add Ext Advertising - Success 14 (ADV_NONCONN_IND)

Add Ext Advertising - Success 14 (ADV_NONCONN_IND) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success 14 (ADV_NONCONN_IND) - setup
  Setup sending Set Low Energy (0x000d)
  Setup sending Set Powered (0x0005)
  Initial settings completed
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Add Ext Advertising - Success 14 (ADV_NONCONN_IND) - setup complete
Add Ext Advertising - Success 14 (ADV_NONCONN_IND) - run
  Registering HCI command callback
  Test condition added, total 1
  Sending Add Advertising (0x003e)
  Test condition added, total 2
  HCI Command 0x2036 length 25
  Test condition complete, 1 left
  HCI Command 0x2037 length 13
  HCI Command 0x2035 length 7
  HCI Command 0x2039 length 6
  Add Advertising (0x003e): Success (0x00)
  Test condition complete, 0 left
Add Ext Advertising - Success 14 (ADV_NONCONN_IND) - test passed
Add Ext Advertising - Success 14 (ADV_NONCONN_IND) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success 14 (ADV_NONCONN_IND) - teardown complete
Add Ext Advertising - Success 14 (ADV_NONCONN_IND) - done


Test Summary
=2D-----------
Add Ext Advertising - Success 14 (ADV_NONCONN_IND)   Passed       0.046 sec=
onds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0461 seconds
Test: Add Ext Advertising - Success 15 (ADV_IND)

Add Ext Advertising - Success 15 (ADV_IND) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success 15 (ADV_IND) - setup
  Setup sending Set Powered (0x0005)
  Setup sending Set Low Energy (0x000d)
  Setup sending Set Connectable (0x0007)
  Initial settings completed
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Add Ext Advertising - Success 15 (ADV_IND) - setup complete
Add Ext Advertising - Success 15 (ADV_IND) - run
  Registering HCI command callback
  Test condition added, total 1
  Sending Add Advertising (0x003e)
  Test condition added, total 2
  HCI Command 0x2036 length 25
  Test condition complete, 1 left
  HCI Command 0x2037 length 13
  HCI Command 0x2039 length 6
  Add Advertising (0x003e): Success (0x00)
  Test condition complete, 0 left
Add Ext Advertising - Success 15 (ADV_IND) - test passed
Add Ext Advertising - Success 15 (ADV_IND) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success 15 (ADV_IND) - teardown complete
Add Ext Advertising - Success 15 (ADV_IND) - done


Test Summary
=2D-----------
Add Ext Advertising - Success 15 (ADV_IND)           Passed       0.039 sec=
onds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0398 seconds
Test: Add Ext Advertising - Success 16 (Connectable -> on)

Add Ext Advertising - Success 16 (Connectable -> on) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success 16 (Connectable -> on) - setup
  Adding advertising instance while powered
  Add Advertising setup complete (instance 1)
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Add Ext Advertising - Success 16 (Connectable -> on) - setup complete
Add Ext Advertising - Success 16 (Connectable -> on) - run
  Registering HCI command callback
  Test condition added, total 1
  Sending Set Connectable (0x0007)
  Test condition added, total 2
  HCI Command 0x0c1a length 1
  HCI Command 0x2039 length 6
  HCI Command 0x2036 length 25
  Test condition complete, 1 left
  HCI Command 0x2039 length 6
  Set Connectable (0x0007): Success (0x00)
  Test condition complete, 0 left
Add Ext Advertising - Success 16 (Connectable -> on) - test passed
Add Ext Advertising - Success 16 (Connectable -> on) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success 16 (Connectable -> on) - teardown complete
Add Ext Advertising - Success 16 (Connectable -> on) - done


Test Summary
=2D-----------
Add Ext Advertising - Success 16 (Connectable -> on) Passed       0.040 sec=
onds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.041 seconds
Test: Add Ext Advertising - Success 17 (Connectable -> off)

Add Ext Advertising - Success 17 (Connectable -> off) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success 17 (Connectable -> off) - setup
  Adding advertising instance while connectable
  Add Advertising setup complete (instance 1)
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Add Ext Advertising - Success 17 (Connectable -> off) - setup complete
Add Ext Advertising - Success 17 (Connectable -> off) - run
  Registering HCI command callback
  Test condition added, total 1
  Sending Set Connectable (0x0007)
  Test condition added, total 2
  HCI Command 0x0c1a length 1
  HCI Command 0x2039 length 6
  HCI Command 0x2036 length 25
  Test condition complete, 1 left
  HCI Command 0x2035 length 7
  HCI Command 0x2039 length 6
  Set Connectable (0x0007): Success (0x00)
  Test condition complete, 0 left
Add Ext Advertising - Success 17 (Connectable -> off) - test passed
Add Ext Advertising - Success 17 (Connectable -> off) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success 17 (Connectable -> off) - teardown complete
Add Ext Advertising - Success 17 (Connectable -> off) - done


Test Summary
=2D-----------
Add Ext Advertising - Success 17 (Connectable -> off) Passed       0.044 se=
conds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0458 seconds
Test: Add Ext Advertising - Success 20 (Add Adv override)

Add Ext Advertising - Success 20 (Add Adv override) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success 20 (Add Adv override) - setup
  Adding advertising instance while powered
  Add Advertising setup complete (instance 1)
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Add Ext Advertising - Success 20 (Add Adv override) - setup complete
Add Ext Advertising - Success 20 (Add Adv override) - run
  Registering HCI command callback
  Test condition added, total 1
  Sending Add Advertising (0x003e)
  Test condition added, total 2
  HCI Command 0x2039 length 6
  HCI Command 0x2036 length 25
  HCI Command 0x2037 length 13
  Test condition complete, 1 left
  HCI Command 0x2035 length 7
  HCI Command 0x2039 length 6
  Add Advertising (0x003e): Success (0x00)
  Test condition complete, 0 left
Add Ext Advertising - Success 20 (Add Adv override) - test passed
Add Ext Advertising - Success 20 (Add Adv override) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success 20 (Add Adv override) - teardown complete
Add Ext Advertising - Success 20 (Add Adv override) - done


Test Summary
=2D-----------
Add Ext Advertising - Success 20 (Add Adv override)  Passed       0.040 sec=
onds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.042 seconds
Test: Add Ext Advertising - Success 21 (Timeout expires)

Add Ext Advertising - Success 21 (Timeout expires) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success 21 (Timeout expires) - setup
  Adding advertising instance with timeout
  Add Advertising setup complete (instance 1)
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Add Ext Advertising - Success 21 (Timeout expires) - setup complete
Add Ext Advertising - Success 21 (Timeout expires) - run
  Registering Advertising Removed notification
  Test condition added, total 1
  Executing no-op test
  New Advertising Removed event received
  Test condition complete, 0 left
Add Ext Advertising - Success 21 (Timeout expires) - test passed
Add Ext Advertising - Success 21 (Timeout expires) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success 21 (Timeout expires) - teardown complete
Add Ext Advertising - Success 21 (Timeout expires) - done


Test Summary
=2D-----------
Add Ext Advertising - Success 21 (Timeout expires)   Passed       1.036 sec=
onds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 1.04 seconds
Test: Add Ext Advertising - Success 22 (LE -> off, Remove)

Add Ext Advertising - Success 22 (LE -> off, Remove) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success 22 (LE -> off, Remove) - setup
  Adding advertising instance while powered
  Add Advertising setup complete (instance 1)
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Add Ext Advertising - Success 22 (LE -> off, Remove) - setup complete
Add Ext Advertising - Success 22 (LE -> off, Remove) - run
  Registering Advertising Removed notification
  Test condition added, total 1
  Sending Set Low Energy (0x000d)
  Test condition added, total 2
  New Advertising Removed event received
  Test condition complete, 1 left
  Set Low Energy (0x000d): Success (0x00)
  Test condition complete, 0 left
Add Ext Advertising - Success 22 (LE -> off, Remove) - test passed
Add Ext Advertising - Success 22 (LE -> off, Remove) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success 22 (LE -> off, Remove) - teardown complete
Add Ext Advertising - Success 22 (LE -> off, Remove) - done


Test Summary
=2D-----------
Add Ext Advertising - Success 22 (LE -> off, Remove) Passed       0.044 sec=
onds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0448 seconds
Test: Add Ext Advertising - Success (Empty ScRsp)

Add Ext Advertising - Success (Empty ScRsp) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success (Empty ScRsp) - setup
  Setup sending Set Low Energy (0x000d)
  Setup sending Set Powered (0x0005)
  Initial settings completed
  Setup sending Set Local Name (0x000f)
  Test setup condition added, total 1
  Test setup condition complete, 0 left
Add Ext Advertising - Success (Empty ScRsp) - setup complete
Add Ext Advertising - Success (Empty ScRsp) - run
  Sending Add Advertising (0x003e)
  Test condition added, total 1
  Add Advertising (0x003e): Success (0x00)
  Test condition complete, 0 left
Add Ext Advertising - Success (Empty ScRsp) - test passed
Add Ext Advertising - Success (Empty ScRsp) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success (Empty ScRsp) - teardown complete
Add Ext Advertising - Success (Empty ScRsp) - done


Test Summary
=2D-----------
Add Ext Advertising - Success (Empty ScRsp)          Passed       0.038 sec=
onds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0384 seconds
Test: Add Ext Advertising - Success (ScRsp only)

Add Ext Advertising - Success (ScRsp only) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success (ScRsp only) - setup
  Setup sending Set Low Energy (0x000d)
  Setup sending Set Powered (0x0005)
  Initial settings completed
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Add Ext Advertising - Success (ScRsp only) - setup complete
Add Ext Advertising - Success (ScRsp only) - run
  Sending Add Advertising (0x003e)
  Test condition added, total 1
  Add Advertising (0x003e): Success (0x00)
  Test condition complete, 0 left
Add Ext Advertising - Success (ScRsp only) - test passed
Add Ext Advertising - Success (ScRsp only) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success (ScRsp only) - teardown complete
Add Ext Advertising - Success (ScRsp only) - done


Test Summary
=2D-----------
Add Ext Advertising - Success (ScRsp only)           Passed       0.039 sec=
onds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.039 seconds
Test: Add Ext Advertising - Invalid Params (ScRsp too long)

Add Ext Advertising - Invalid Params (ScRsp too long) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Invalid Params (ScRsp too long) - setup
  Setup sending Set Low Energy (0x000d)
  Setup sending Set Powered (0x0005)
  Initial settings completed
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Add Ext Advertising - Invalid Params (ScRsp too long) - setup complete
Add Ext Advertising - Invalid Params (ScRsp too long) - run
  Sending Add Advertising (0x003e)
  Test condition added, total 1
  Add Advertising (0x003e): Invalid Parameters (0x0d)
  Test condition complete, 0 left
Add Ext Advertising - Invalid Params (ScRsp too long) - test passed
Add Ext Advertising - Invalid Params (ScRsp too long) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Invalid Params (ScRsp too long) - teardown complete
Add Ext Advertising - Invalid Params (ScRsp too long) - done


Test Summary
=2D-----------
Add Ext Advertising - Invalid Params (ScRsp too long) Passed       0.037 se=
conds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0374 seconds
Test: Add Ext Advertising - Success (ScRsp appear)

Add Ext Advertising - Success (ScRsp appear) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success (ScRsp appear) - setup
  Setup sending Set Low Energy (0x000d)
  Setup sending Set Powered (0x0005)
  Initial settings completed
  Setup sending Set Appearance (0x0043)
  Test setup condition added, total 1
  Test setup condition complete, 0 left
Add Ext Advertising - Success (ScRsp appear) - setup complete
Add Ext Advertising - Success (ScRsp appear) - run
  Sending Add Advertising (0x003e)
  Test condition added, total 1
  Add Advertising (0x003e): Success (0x00)
  Test condition complete, 0 left
Add Ext Advertising - Success (ScRsp appear) - test passed
Add Ext Advertising - Success (ScRsp appear) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success (ScRsp appear) - teardown complete
Add Ext Advertising - Success (ScRsp appear) - done


Test Summary
=2D-----------
Add Ext Advertising - Success (ScRsp appear)         Passed       0.035 sec=
onds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0353 seconds
Test: Add Ext Advertising - Invalid Params (ScRsp appear long)

Add Ext Advertising - Invalid Params (ScRsp appear long) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Invalid Params (ScRsp appear long) - setup
  Setup sending Set Low Energy (0x000d)
  Setup sending Set Powered (0x0005)
  Initial settings completed
  Setup sending Set Appearance (0x0043)
  Test setup condition added, total 1
  Test setup condition complete, 0 left
Add Ext Advertising - Invalid Params (ScRsp appear long) - setup complete
Add Ext Advertising - Invalid Params (ScRsp appear long) - run
  Sending Add Advertising (0x003e)
  Test condition added, total 1
  Add Advertising (0x003e): Invalid Parameters (0x0d)
  Test condition complete, 0 left
Add Ext Advertising - Invalid Params (ScRsp appear long) - test passed
Add Ext Advertising - Invalid Params (ScRsp appear long) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Invalid Params (ScRsp appear long) - teardown complete
Add Ext Advertising - Invalid Params (ScRsp appear long) - done


Test Summary
=2D-----------
Add Ext Advertising - Invalid Params (ScRsp appear long) Passed       0.036=
 seconds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0367 seconds
Test: Add Ext Advertising - Success (Appear is null)

Add Ext Advertising - Success (Appear is null) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success (Appear is null) - setup
  Setup sending Set Low Energy (0x000d)
  Setup sending Set Powered (0x0005)
  Initial settings completed
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Add Ext Advertising - Success (Appear is null) - setup complete
Add Ext Advertising - Success (Appear is null) - run
  Sending Add Advertising (0x003e)
  Test condition added, total 1
  Add Advertising (0x003e): Success (0x00)
  Test condition complete, 0 left
Add Ext Advertising - Success (Appear is null) - test passed
Add Ext Advertising - Success (Appear is null) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success (Appear is null) - teardown complete
Add Ext Advertising - Success (Appear is null) - done


Test Summary
=2D-----------
Add Ext Advertising - Success (Appear is null)       Passed       0.035 sec=
onds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0358 seconds
Test: Add Ext Advertising - Success (Name is null)

Add Ext Advertising - Success (Name is null) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success (Name is null) - setup
  Setup sending Set Low Energy (0x000d)
  Setup sending Set Powered (0x0005)
  Initial settings completed
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Add Ext Advertising - Success (Name is null) - setup complete
Add Ext Advertising - Success (Name is null) - run
  Registering HCI command callback
  Test condition added, total 1
  Sending Add Advertising (0x003e)
  Test condition added, total 2
  HCI Command 0x2036 length 25
  HCI Command 0x2035 length 7
  HCI Command 0x2038 length 5
  Test condition complete, 1 left
  HCI Command 0x2039 length 6
  Add Advertising (0x003e): Success (0x00)
  Test condition complete, 0 left
Add Ext Advertising - Success (Name is null) - test passed
Add Ext Advertising - Success (Name is null) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success (Name is null) - teardown complete
Add Ext Advertising - Success (Name is null) - done


Test Summary
=2D-----------
Add Ext Advertising - Success (Name is null)         Passed       0.042 sec=
onds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0422 seconds
Test: Add Ext Advertising - Success (Complete name)

Add Ext Advertising - Success (Complete name) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success (Complete name) - setup
  Setup sending Set Low Energy (0x000d)
  Setup sending Set Powered (0x0005)
  Initial settings completed
  Setup sending Set Local Name (0x000f)
  Test setup condition added, total 1
  Test setup condition complete, 0 left
Add Ext Advertising - Success (Complete name) - setup complete
Add Ext Advertising - Success (Complete name) - run
  Registering HCI command callback
  Test condition added, total 1
  Sending Add Advertising (0x003e)
  Test condition added, total 2
  HCI Command 0x2036 length 25
  HCI Command 0x2035 length 7
  HCI Command 0x2038 length 15
  Test condition complete, 1 left
  HCI Command 0x2039 length 6
  Add Advertising (0x003e): Success (0x00)
  Test condition complete, 0 left
Add Ext Advertising - Success (Complete name) - test passed
Add Ext Advertising - Success (Complete name) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success (Complete name) - teardown complete
Add Ext Advertising - Success (Complete name) - done


Test Summary
=2D-----------
Add Ext Advertising - Success (Complete name)        Passed       0.042 sec=
onds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0428 seconds
Test: Add Ext Advertising - Success (Shortened name)

Add Ext Advertising - Success (Shortened name) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success (Shortened name) - setup
  Setup sending Set Low Energy (0x000d)
  Setup sending Set Powered (0x0005)
  Initial settings completed
  Setup sending Set Local Name (0x000f)
  Test setup condition added, total 1
  Test setup condition complete, 0 left
Add Ext Advertising - Success (Shortened name) - setup complete
Add Ext Advertising - Success (Shortened name) - run
  Registering HCI command callback
  Test condition added, total 1
  Sending Add Advertising (0x003e)
  Test condition added, total 2
  HCI Command 0x2036 length 25
  HCI Command 0x2035 length 7
  HCI Command 0x2038 length 16
  Test condition complete, 1 left
  HCI Command 0x2039 length 6
  Add Advertising (0x003e): Success (0x00)
  Test condition complete, 0 left
Add Ext Advertising - Success (Shortened name) - test passed
Add Ext Advertising - Success (Shortened name) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success (Shortened name) - teardown complete
Add Ext Advertising - Success (Shortened name) - done


Test Summary
=2D-----------
Add Ext Advertising - Success (Shortened name)       Passed       0.043 sec=
onds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.043 seconds
Test: Add Ext Advertising - Success (Short name)

Add Ext Advertising - Success (Short name) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success (Short name) - setup
  Setup sending Set Low Energy (0x000d)
  Setup sending Set Powered (0x0005)
  Initial settings completed
  Setup sending Set Local Name (0x000f)
  Test setup condition added, total 1
  Test setup condition complete, 0 left
Add Ext Advertising - Success (Short name) - setup complete
Add Ext Advertising - Success (Short name) - run
  Registering HCI command callback
  Test condition added, total 1
  Sending Add Advertising (0x003e)
  Test condition added, total 2
  HCI Command 0x2036 length 25
  HCI Command 0x2035 length 7
  HCI Command 0x2038 length 16
  Test condition complete, 1 left
  HCI Command 0x2039 length 6
  Add Advertising (0x003e): Success (0x00)
  Test condition complete, 0 left
Add Ext Advertising - Success (Short name) - test passed
Add Ext Advertising - Success (Short name) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success (Short name) - teardown complete
Add Ext Advertising - Success (Short name) - done


Test Summary
=2D-----------
Add Ext Advertising - Success (Short name)           Passed       0.040 sec=
onds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0402 seconds
Test: Add Ext Advertising - Success (Name + data)

Add Ext Advertising - Success (Name + data) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success (Name + data) - setup
  Setup sending Set Low Energy (0x000d)
  Setup sending Set Powered (0x0005)
  Initial settings completed
  Setup sending Set Local Name (0x000f)
  Test setup condition added, total 1
  Test setup condition complete, 0 left
Add Ext Advertising - Success (Name + data) - setup complete
Add Ext Advertising - Success (Name + data) - run
  Registering HCI command callback
  Test condition added, total 1
  Sending Add Advertising (0x003e)
  Test condition added, total 2
  HCI Command 0x2036 length 25
  HCI Command 0x2035 length 7
  HCI Command 0x2038 length 33
  Test condition complete, 1 left
  HCI Command 0x2039 length 6
  Add Advertising (0x003e): Success (0x00)
  Test condition complete, 0 left
Add Ext Advertising - Success (Name + data) - test passed
Add Ext Advertising - Success (Name + data) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success (Name + data) - teardown complete
Add Ext Advertising - Success (Name + data) - done


Test Summary
=2D-----------
Add Ext Advertising - Success (Name + data)          Passed       0.043 sec=
onds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0439 seconds
Test: Add Ext Advertising - Invalid Params (Name + data)

Add Ext Advertising - Invalid Params (Name + data) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Invalid Params (Name + data) - setup
  Setup sending Set Low Energy (0x000d)
  Setup sending Set Powered (0x0005)
  Initial settings completed
  Setup sending Set Local Name (0x000f)
  Test setup condition added, total 1
  Test setup condition complete, 0 left
Add Ext Advertising - Invalid Params (Name + data) - setup complete
Add Ext Advertising - Invalid Params (Name + data) - run
  Sending Add Advertising (0x003e)
  Test condition added, total 1
  Add Advertising (0x003e): Invalid Parameters (0x0d)
  Test condition complete, 0 left
Add Ext Advertising - Invalid Params (Name + data) - test passed
Add Ext Advertising - Invalid Params (Name + data) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Invalid Params (Name + data) - teardown complete
Add Ext Advertising - Invalid Params (Name + data) - done


Test Summary
=2D-----------
Add Ext Advertising - Invalid Params (Name + data)   Passed       0.037 sec=
onds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0372 seconds
Test: Add Ext Advertising - Success (Name+data+appear)

Add Ext Advertising - Success (Name+data+appear) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success (Name+data+appear) - setup
  Setup sending Set Low Energy (0x000d)
  Setup sending Set Powered (0x0005)
  Initial settings completed
  Sending setup opcode array
  Setup sending Set Appearance (0x0043)
  Test setup condition added, total 1
  Setup sending Set Local Name (0x000f)
  Test setup condition added, total 2
  Test setup condition complete, 1 left
  Test setup condition complete, 0 left
Add Ext Advertising - Success (Name+data+appear) - setup complete
Add Ext Advertising - Success (Name+data+appear) - run
  Registering HCI command callback
  Test condition added, total 1
  Sending Add Advertising (0x003e)
  Test condition added, total 2
  HCI Command 0x2036 length 25
  HCI Command 0x2035 length 7
  HCI Command 0x2038 length 33
  Test condition complete, 1 left
  HCI Command 0x2039 length 6
  Add Advertising (0x003e): Success (0x00)
  Test condition complete, 0 left
Add Ext Advertising - Success (Name+data+appear) - test passed
Add Ext Advertising - Success (Name+data+appear) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success (Name+data+appear) - teardown complete
Add Ext Advertising - Success (Name+data+appear) - done


Test Summary
=2D-----------
Add Ext Advertising - Success (Name+data+appear)     Passed       0.046 sec=
onds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0472 seconds
Test: Add Ext Advertising - Success (PHY -> 1M)

Add Ext Advertising - Success (PHY -> 1M) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success (PHY -> 1M) - setup
  Setup sending Set Low Energy (0x000d)
  Setup sending Set Powered (0x0005)
  Initial settings completed
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Add Ext Advertising - Success (PHY -> 1M) - setup complete
Add Ext Advertising - Success (PHY -> 1M) - run
  Registering HCI command callback
  Test condition added, total 1
  Sending Add Advertising (0x003e)
  Test condition added, total 2
  HCI Command 0x2036 length 25
  Test condition complete, 1 left
  HCI Command 0x2037 length 13
  HCI Command 0x2035 length 7
  HCI Command 0x2039 length 6
  Add Advertising (0x003e): Success (0x00)
  Test condition complete, 0 left
Add Ext Advertising - Success (PHY -> 1M) - test passed
Add Ext Advertising - Success (PHY -> 1M) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success (PHY -> 1M) - teardown complete
Add Ext Advertising - Success (PHY -> 1M) - done


Test Summary
=2D-----------
Add Ext Advertising - Success (PHY -> 1M)            Passed       0.041 sec=
onds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0412 seconds
Test: Add Ext Advertising - Success (PHY -> 2M)

Add Ext Advertising - Success (PHY -> 2M) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success (PHY -> 2M) - setup
  Setup sending Set Low Energy (0x000d)
  Setup sending Set Powered (0x0005)
  Initial settings completed
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Add Ext Advertising - Success (PHY -> 2M) - setup complete
Add Ext Advertising - Success (PHY -> 2M) - run
  Registering HCI command callback
  Test condition added, total 1
  Sending Add Advertising (0x003e)
  Test condition added, total 2
  HCI Command 0x2036 length 25
  Test condition complete, 1 left
  HCI Command 0x2037 length 13
  HCI Command 0x2035 length 7
  HCI Command 0x2039 length 6
  Add Advertising (0x003e): Success (0x00)
  Test condition complete, 0 left
Add Ext Advertising - Success (PHY -> 2M) - test passed
Add Ext Advertising - Success (PHY -> 2M) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success (PHY -> 2M) - teardown complete
Add Ext Advertising - Success (PHY -> 2M) - done


Test Summary
=2D-----------
Add Ext Advertising - Success (PHY -> 2M)            Passed       0.039 sec=
onds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0398 seconds
Test: Add Ext Advertising - Success (PHY -> Coded)

Add Ext Advertising - Success (PHY -> Coded) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success (PHY -> Coded) - setup
  Setup sending Set Low Energy (0x000d)
  Setup sending Set Powered (0x0005)
  Initial settings completed
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Add Ext Advertising - Success (PHY -> Coded) - setup complete
Add Ext Advertising - Success (PHY -> Coded) - run
  Registering HCI command callback
  Test condition added, total 1
  Sending Add Advertising (0x003e)
  Test condition added, total 2
  HCI Command 0x2036 length 25
  Test condition complete, 1 left
  HCI Command 0x2037 length 13
  HCI Command 0x2035 length 7
  HCI Command 0x2039 length 6
  Add Advertising (0x003e): Success (0x00)
  Test condition complete, 0 left
Add Ext Advertising - Success (PHY -> Coded) - test passed
Add Ext Advertising - Success (PHY -> Coded) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success (PHY -> Coded) - teardown complete
Add Ext Advertising - Success (PHY -> Coded) - done


Test Summary
=2D-----------
Add Ext Advertising - Success (PHY -> Coded)         Passed       0.041 sec=
onds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0414 seconds
Test: Add Ext Advertising - Success (Ext Pdu Scannable)

Add Ext Advertising - Success (Ext Pdu Scannable) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success (Ext Pdu Scannable) - setup
  Setup sending Set Low Energy (0x000d)
  Setup sending Set Powered (0x0005)
  Initial settings completed
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Add Ext Advertising - Success (Ext Pdu Scannable) - setup complete
Add Ext Advertising - Success (Ext Pdu Scannable) - run
  Registering HCI command callback
  Test condition added, total 1
  Sending Add Advertising (0x003e)
  Test condition added, total 2
  HCI Command 0x2036 length 25
  Test condition complete, 1 left
  HCI Command 0x2037 length 13
  HCI Command 0x2035 length 7
  HCI Command 0x2038 length 14
  HCI Command 0x2039 length 6
  Add Advertising (0x003e): Success (0x00)
  Test condition complete, 0 left
Add Ext Advertising - Success (Ext Pdu Scannable) - test passed
Add Ext Advertising - Success (Ext Pdu Scannable) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success (Ext Pdu Scannable) - teardown complete
Add Ext Advertising - Success (Ext Pdu Scannable) - done


Test Summary
=2D-----------
Add Ext Advertising - Success (Ext Pdu Scannable)    Passed       0.044 sec=
onds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0441 seconds
Test: Add Ext Advertising - Success (Ext Pdu Connectable)

Add Ext Advertising - Success (Ext Pdu Connectable) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success (Ext Pdu Connectable) - setup
  Setup sending Set Powered (0x0005)
  Setup sending Set Low Energy (0x000d)
  Setup sending Set Connectable (0x0007)
  Initial settings completed
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Add Ext Advertising - Success (Ext Pdu Connectable) - setup complete
Add Ext Advertising - Success (Ext Pdu Connectable) - run
  Registering HCI command callback
  Test condition added, total 1
  Sending Add Advertising (0x003e)
  Test condition added, total 2
  HCI Command 0x2036 length 25
  Test condition complete, 1 left
  HCI Command 0x2037 length 13
  HCI Command 0x2039 length 6
  Add Advertising (0x003e): Success (0x00)
  Test condition complete, 0 left
Add Ext Advertising - Success (Ext Pdu Connectable) - test passed
Add Ext Advertising - Success (Ext Pdu Connectable) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success (Ext Pdu Connectable) - teardown complete
Add Ext Advertising - Success (Ext Pdu Connectable) - done


Test Summary
=2D-----------
Add Ext Advertising - Success (Ext Pdu Connectable)  Passed       0.041 sec=
onds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.041 seconds
Test: Add Ext Advertising - Success (Ext Pdu Conn Scan)

Add Ext Advertising - Success (Ext Pdu Conn Scan) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success (Ext Pdu Conn Scan) - setup
  Setup sending Set Powered (0x0005)
  Setup sending Set Low Energy (0x000d)
  Setup sending Set Connectable (0x0007)
  Initial settings completed
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Add Ext Advertising - Success (Ext Pdu Conn Scan) - setup complete
Add Ext Advertising - Success (Ext Pdu Conn Scan) - run
  Registering HCI command callback
  Test condition added, total 1
  Sending Add Advertising (0x003e)
  Test condition added, total 2
  HCI Command 0x2036 length 25
  Test condition complete, 1 left
  HCI Command 0x2037 length 13
  HCI Command 0x2038 length 14
  HCI Command 0x2039 length 6
  Add Advertising (0x003e): Success (0x00)
  Test condition complete, 0 left
Add Ext Advertising - Success (Ext Pdu Conn Scan) - test passed
Add Ext Advertising - Success (Ext Pdu Conn Scan) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success (Ext Pdu Conn Scan) - teardown complete
Add Ext Advertising - Success (Ext Pdu Conn Scan) - done


Test Summary
=2D-----------
Add Ext Advertising - Success (Ext Pdu Conn Scan)    Passed       0.040 sec=
onds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.04 seconds
Test: Add Ext Advertising - Success (1m Connectable -> on)

Add Ext Advertising - Success (1m Connectable -> on) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success (1m Connectable -> on) - setup
  Adding advertising instance while powered
  Add Advertising setup complete (instance 1)
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Add Ext Advertising - Success (1m Connectable -> on) - setup complete
Add Ext Advertising - Success (1m Connectable -> on) - run
  Registering HCI command callback
  Test condition added, total 1
  Sending Set Connectable (0x0007)
  Test condition added, total 2
  HCI Command 0x0c1a length 1
  HCI Command 0x2039 length 6
  HCI Command 0x2036 length 25
  Test condition complete, 1 left
  HCI Command 0x2039 length 6
  Set Connectable (0x0007): Success (0x00)
  Test condition complete, 0 left
Add Ext Advertising - Success (1m Connectable -> on) - test passed
Add Ext Advertising - Success (1m Connectable -> on) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success (1m Connectable -> on) - teardown complete
Add Ext Advertising - Success (1m Connectable -> on) - done


Test Summary
=2D-----------
Add Ext Advertising - Success (1m Connectable -> on) Passed       0.041 sec=
onds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.0419 seconds
Test: Add Ext Advertising - Success (1m Connectable -> off)

Add Ext Advertising - Success (1m Connectable -> off) - init
  Read Version callback
    Status: Success (0x00)
    Version 1.22
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0000
  Enable management Mesh interface
  Enabling Mesh feature
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x09
    Manufacturer: 0x05f1
    Supported settings: 0x0001beff
    Current settings: 0x00000080
    Class: 0x000000
    Name:=20
    Short name:=20
  Mesh feature is enabled
Add Ext Advertising - Success (1m Connectable -> off) - setup
  Adding advertising instance while connectable
  Add Advertising setup complete (instance 1)
  Test setup condition added, total 1
  Client set connectable: Success (0x00)
  Test setup condition complete, 0 left
Add Ext Advertising - Success (1m Connectable -> off) - setup complete
Add Ext Advertising - Success (1m Connectable -> off) - run
  Registering HCI command callback
  Test condition added, total 1
  Sending Set Connectable (0x0007)
  Test condition added, total 2
  HCI Command 0x0c1a length 1
  HCI Command 0x2039 length 6
  HCI Command 0x2036 length 25
  Test condition complete, 1 left
  HCI Command 0x2035 length 7
  HCI Command 0x2039 length 6
  Set Connectable (0x0007): Success (0x00)
  Test condition complete, 0 left
Add Ext Advertising - Success (1m Connectable -> off) - test passed
Add Ext Advertising - Success (1m Connectable -> off) - teardown
  Index Removed callback
    Index: 0x0000
Add Ext Advertising - Success (1m Connectable -> off) - teardown complete
Add Ext Advertising - Success (1m Connectable -> off) - done


Test Summary
=2D-----------
Add Ext Advertising - Success (1m Connectable -> off) Passed       0.038 se=
conds
Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.038 seconds




