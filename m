Return-Path: <stable+bounces-158759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1652DAEB3DF
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 12:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4A21C2036A
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 10:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EE92BD5B0;
	Fri, 27 Jun 2025 10:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="N7S3nKDN"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010012.outbound.protection.outlook.com [52.101.69.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D681029ACDD;
	Fri, 27 Jun 2025 10:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751018990; cv=fail; b=K5eR1/2fqjuo3R4OhW1GSJ2JyqFm1J1aaSh2ItvmFO6G+7BPsG7imJkQsd+zYTB9wFaNfb/8yS2n9lf20GEZk2d1erHQkph/RyEFFkgG/JhvaNrj7/zYoUOhcCDr88E5O6VUGnLvL3FgUVz2nexZw49+eDbtPhAE0PYlg28T4Dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751018990; c=relaxed/simple;
	bh=zg39zxPjzAR45tHt8SLnSLlQoWhDz3LJ8ddKL1dDdxw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CKSlDm/t7BzmIM8KU12DiUAm99O0EeG70cPUGRhYJPPpn4eF4CyurTRZhkmGRkT/Tbhe0ruXJl1KrDk3yWwyUFi69RwiQsu9V32/a/VtBlWIhygQwkq0CCuk00vXJhfou/YWDXQ23zVwl1X0MHOWsBPlq7p8ydcm0PGUGhSuwHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=N7S3nKDN; arc=fail smtp.client-ip=52.101.69.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6oJXaabcbIhwpRhA1ORIUBijONkxspPlEYHIjOULlvYM2hAP01n1fuHiQfYMZsI5YqMCpzS9Yk8Qc21Sob/fCa/N02giP4qVM+Hj8pp07fKtZT58R1uxU8c2ofYRH+lkl9FKuX6BUR0Xa+K0cxDNhhLregHmkW1KpJFPnH5gT8z+qu+yG7zV00eA6koQ3oeaD1kVCkL/ELaQliPn1eGBpvcHgfZS+dwzygZ0AIpy6eCrGIEobVnDeoecEDBxVmvKcScyFZsTA86WPd3M3hUJDwORrl6t+HFe9WUKS1rfKlKjx+m9ogcINBKVFGBbDwxT6cEDnkfl7nMLHoSxVj6YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcAyE+WqoS5o5S7mE1bo9sx7a8Zq+SJoRn4TC1HoaxE=;
 b=W9+rkmyWtyfJ0amH9x/Fa7Xsr7OMHuPbVc/m49hx0uIG7acO4PwIvkgJtdz1Gs0tf2KEAxv+8kCh46n8uZmOgpPvj2UTJbX0gC3DplAfbWrCq2lLXX1wxX0VbfHwsEAd0xj6jKEFGr3vo8YceuyTPeBWRoqhcZWb2yd+ZJi6aglaqZOh9kuoj/adVo39BIX6oaP/oCU+mjf2wvb9gD7CJMcOVCi9GfF0tOjUpDVzX/jxK6dpMOP8RtrxQHvseu8ZW/usFkrwPrbjflXZryBUw8gyPV9GZTxRn14x0SD9OzEFj9+chxgfU5l8pzawUGGLcJYv1xO3foHyXnPX/opXhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=holtmann.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcAyE+WqoS5o5S7mE1bo9sx7a8Zq+SJoRn4TC1HoaxE=;
 b=N7S3nKDNRyFqUe3FIu1AkBmPTy938jvseSIXd7KlKCTc3b4j9ebXN00lKj2Et05yC6xbIngzETEdxcVJnYSeunsTfzHjlDk7G4aNrKaZ67vpVQKI7ao/YyEb4ulJtUIkpTeIwki0uZQaIXUVeb7U80ftDW00Drr1zaV31erRvRc=
Received: from AM0PR03CA0010.eurprd03.prod.outlook.com (2603:10a6:208:14::23)
 by DU0PR03MB8266.eurprd03.prod.outlook.com (2603:10a6:10:317::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Fri, 27 Jun
 2025 10:09:39 +0000
Received: from AMS0EPF000001B4.eurprd05.prod.outlook.com
 (2603:10a6:208:14:cafe::5d) by AM0PR03CA0010.outlook.office365.com
 (2603:10a6:208:14::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.20 via Frontend Transport; Fri,
 27 Jun 2025 10:09:39 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS0EPF000001B4.mail.protection.outlook.com (10.167.16.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 10:09:38 +0000
Received: from n9w6sw14.localnet (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 27 Jun
 2025 12:09:38 +0200
From: Christian Eggers <ceggers@arri.de>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Jaganath Kanakkassery <jaganath.k.os@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v3] Bluetooth: HCI: Set extended advertising data synchronously
Date: Fri, 27 Jun 2025 12:09:38 +0200
Message-ID: <4990184.OV4Wx5bFTl@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <20250627070508.13780-1-ceggers@arri.de>
References: <20250627070508.13780-1-ceggers@arri.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B4:EE_|DU0PR03MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af88d30-9851-447e-f1a3-08ddb562ba0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|30052699003|36860700013|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e+V2qQb6KyB9p+TonHNfzZ76Wx8LbOCGLpzz/hB9M16WT34i4g2y4GYEAWBE?=
 =?us-ascii?Q?tyg9D6huISmkPr0gd6om5A2TXcRMmjL1UNWah/Li5A73XFfDqiS0opZbW/AY?=
 =?us-ascii?Q?naRZXItN+KxUfalXR7jXkRkQlXiwCyRi5JDvPCaRsHyEWdiT77Z+5qNvYVhN?=
 =?us-ascii?Q?8IYzC4wB6wznlNuwYV++RtspYbntskBRksLvZBX67Vh4gyf7MuBku0a6WmKn?=
 =?us-ascii?Q?qoivFGaXIeeynwLu0nKVHje6yZySanVMvbhq1O7BLy8jqIdiffUkUHclnog0?=
 =?us-ascii?Q?yL80PxM9I8/ptxe9bhkTe5S9VhWmkt1esgTAgstleT1p7I82m7T86JK+f56v?=
 =?us-ascii?Q?7o3cPImO0PJSniCIRWZTzgIK11ZzwHubVuLIWpsyXc4dv+sAW06ceXnsoYIF?=
 =?us-ascii?Q?+EL7+1bhOfHGMrpSIKORqIOt+wIoeYWnPSfofsMUFs/QWKRJWKdDIpcgCJTc?=
 =?us-ascii?Q?zJ9eG2sgWJCc2OlKKXKR4bIcMDznRiaFXCezRbAVriZE9XRABNpNLYlZYmy/?=
 =?us-ascii?Q?jjphfe7nH0ui+4M4W0nDkh4JnGL/aV1NxyaCFuDrxfD/9y0Sp5b83a+lx0Mm?=
 =?us-ascii?Q?KFD9EKo/eknoGe9pMB+wcHRwrKKsSzU4cOGdsHT4QamoELv6+RuFXgmfOvxa?=
 =?us-ascii?Q?4ufgduuLfs/PNVJcJY7GGXSxBGj7P77o0VB9QiFOxz8g0gwkTUjm00Xl5mYF?=
 =?us-ascii?Q?cFTCtc9exYAD9bmRoRE2tMXbk72yFqphm5Ti2EUN0OSF/PBIHpwZeY7sCgAt?=
 =?us-ascii?Q?kuxzVL9YWcNUADcspPxrI5T9pbKVCrfHqlx/xju8ewlXe5X+aIYkwLUELaGy?=
 =?us-ascii?Q?H6qINXVFJpeHZ0x7amVEqx/v3pdOF8bLhvXbPIL1WEDGXqXh3cQX9Nbh+uJ8?=
 =?us-ascii?Q?dWTDeLNxm+ftQy6iX6mX/rbBWazkCBRmTPFtUh+3DdK3O62sdaov30w+mBc+?=
 =?us-ascii?Q?etTdhg15K7SFD/3FxMFOFbdORmRP3pKYJRE8lOzPkMicE9s4oKe/32T7bO2I?=
 =?us-ascii?Q?rWQZzakI167qlWmqAqAfdCjfZ8OYCT/JUp4rX4nAYRFu55ztY4/BmG1xGYkY?=
 =?us-ascii?Q?ocWMZq4jWpaTNFNm0NJ0+TOZHZ6frzN1gvhA8RyIgBk2D0lt0pd/Gezg3yNP?=
 =?us-ascii?Q?1Fo8auSSGJCv9KJVFb2XWR0kbHA53sabcKnHL6vm49mAlRQFEdyR3XOfDdNv?=
 =?us-ascii?Q?YV1I9Ljzxw0PHQLJE7Jrate8d8JgKCKSkPuwXNFfUnDL+gVYU5cHyQCwrcie?=
 =?us-ascii?Q?1xm+Qs+aIbcA/6eIG0DdvPYgI1kkAPBt/Ylql1RicGf6N6b2l9updK07Wd6F?=
 =?us-ascii?Q?BtNDIyng0NmjrQ2vnCzPH2+JMiTYTr1EfSPUlUrmLGfUHw3U3T5IumfpMYKh?=
 =?us-ascii?Q?TP4r11jWdiGkAY98rz1dda5IEcSXCENoWZW2Zrxrv2n1hlK85pKv9HmoMWhM?=
 =?us-ascii?Q?4Q0AdERNUrF7T3Uq1xd3HqTDsPeBaRkBXhBcKcYHap5pN4W3NfwMfNlqfEF+?=
 =?us-ascii?Q?m3V4jFoZbhmbgNsaHGgNoWpOkQDAgnTQGoYXCFW6BgJRgulXe5eimAZq1g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(30052699003)(36860700013)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 10:09:38.9016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af88d30-9851-447e-f1a3-08ddb562ba0e
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8266

Hi Luiz,

after changing my test setup (I now only use Mesh, no "normal" advertising
anymore), I get many of these errors:

bluetooth-meshd[276]: @ MGMT Command: Mesh Send (0x0059) plen 40                                                                   {0x0001} [hci0] 43.846388
        Address: 00:00:00:00:00:00 (OUI 00-00-00)
        Addr Type: 2
        Instant: 0x0000000000000000
        Delay: 0
        Count: 1
        Data Length: 21
        Data[21]: 142b003a8b6fe779bd4385a94fed0a9cf611880000
< HCI Command: LE Set Extended Advertising Parameters (0x08|0x0036) plen 25                                                            #479 [hci0] 43.846505
        Handle: 0x05
        Properties: 0x0010
          Use legacy advertising PDUs: ADV_NONCONN_IND
        Min advertising interval: 1280.000 msec (0x0800)
        Max advertising interval: 1280.000 msec (0x0800)
        Channel map: 37, 38, 39 (0x07)
        Own address type: Random (0x01)
        Peer address type: Public (0x00)
        Peer address: 00:00:00:00:00:00 (OUI 00-00-00)
        Filter policy: Allow Scan Request from Any, Allow Connect Request from Any (0x00)
        TX power: Host has no preference (0x7f)
        Primary PHY: LE 1M (0x01)
        Secondary max skip: 0x00
        Secondary PHY: LE 1M (0x01)
        SID: 0x00
        Scan request notifications: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 5                                                                                            #480 [hci0] 43.847480
      LE Set Extended Advertising Parameters (0x08|0x0036) ncmd 2
--->    Status: Command Disallowed (0x0c)
        TX power (selected): 0 dbm (0x00)


From the btmon output it is obvious that advertising is not disabled before updating the parameters.

I added the following debug line in hci_setup_ext_adv_instance_sync():

	printk(KERN_ERR "instance = %u, adv = %p, adv->pending = %d, adv->enabled = %d\n",
	       instance, adv, adv ? adv->pending : -1, adv ? adv->enabled : -1);

From the debug output I see that adv->pending is still true (so advertising is not disabled
before setting the advertising params). After changing the check from 

	if (adv && !adv->pending) {

to

	if (adv && adv->enabled) {

it seems to do the job correctly. What do you think?


regards,
Christian


On Friday, 27 June 2025, 09:05:08 CEST, Christian Eggers wrote:
> Currently, for controllers with extended advertising, the advertising
> data is set in the asynchronous response handler for extended
> adverstising params. As most advertising settings are performed in a
> synchronous context, the (asynchronous) setting of the advertising data
> is done too late (after enabling the advertising).
> 
> Move setting of adverstising data from asynchronous response handler
> into synchronous context to fix ordering of HCI commands.
> 
> Signed-off-by: Christian Eggers <ceggers@arri.de>
> Fixes: a0fb3726ba55 ("Bluetooth: Use Set ext adv/scan rsp data if controller supports")
> Cc: stable@vger.kernel.org
> v2: https://lore.kernel.org/linux-bluetooth/20250626115209.17839-1-ceggers@arri.de/
> ---
> v3: refactor: store adv_addr_type/tx_power within hci_set_ext_adv_params_sync()
> 
> v2: convert setting of adv data into synchronous context (rather than moving
> more methods into asynchronous response handlers).
> - hci_set_ext_adv_params_sync: new method
> - hci_set_ext_adv_data_sync: move within source file (no changes)
> - hci_set_adv_data_sync: dito
> - hci_update_adv_data_sync: dito
> - hci_cc_set_ext_adv_param: remove (performed synchronously now)
> 
>  net/bluetooth/hci_event.c |  36 -------
>  net/bluetooth/hci_sync.c  | 207 ++++++++++++++++++++++++--------------
>  2 files changed, 130 insertions(+), 113 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 66052d6aaa1d..4d5ace9d245d 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2150,40 +2150,6 @@ static u8 hci_cc_set_adv_param(struct hci_dev *hdev, void *data,
>  	return rp->status;
>  }
>  
> -static u8 hci_cc_set_ext_adv_param(struct hci_dev *hdev, void *data,
> -				   struct sk_buff *skb)
> -{
> -	struct hci_rp_le_set_ext_adv_params *rp = data;
> -	struct hci_cp_le_set_ext_adv_params *cp;
> -	struct adv_info *adv_instance;
> -
> -	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
> -
> -	if (rp->status)
> -		return rp->status;
> -
> -	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_EXT_ADV_PARAMS);
> -	if (!cp)
> -		return rp->status;
> -
> -	hci_dev_lock(hdev);
> -	hdev->adv_addr_type = cp->own_addr_type;
> -	if (!cp->handle) {
> -		/* Store in hdev for instance 0 */
> -		hdev->adv_tx_power = rp->tx_power;
> -	} else {
> -		adv_instance = hci_find_adv_instance(hdev, cp->handle);
> -		if (adv_instance)
> -			adv_instance->tx_power = rp->tx_power;
> -	}
> -	/* Update adv data as tx power is known now */
> -	hci_update_adv_data(hdev, cp->handle);
> -
> -	hci_dev_unlock(hdev);
> -
> -	return rp->status;
> -}
> -
>  static u8 hci_cc_read_rssi(struct hci_dev *hdev, void *data,
>  			   struct sk_buff *skb)
>  {
> @@ -4164,8 +4130,6 @@ static const struct hci_cc {
>  	HCI_CC(HCI_OP_LE_READ_NUM_SUPPORTED_ADV_SETS,
>  	       hci_cc_le_read_num_adv_sets,
>  	       sizeof(struct hci_rp_le_read_num_supported_adv_sets)),
> -	HCI_CC(HCI_OP_LE_SET_EXT_ADV_PARAMS, hci_cc_set_ext_adv_param,
> -	       sizeof(struct hci_rp_le_set_ext_adv_params)),
>  	HCI_CC_STATUS(HCI_OP_LE_SET_EXT_ADV_ENABLE,
>  		      hci_cc_le_set_ext_adv_enable),
>  	HCI_CC_STATUS(HCI_OP_LE_SET_ADV_SET_RAND_ADDR,
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 1f8806dfa556..563614b53485 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -1205,9 +1205,126 @@ static int hci_set_adv_set_random_addr_sync(struct hci_dev *hdev, u8 instance,
>  				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
>  }
>  
> +static int
> +hci_set_ext_adv_params_sync(struct hci_dev *hdev, struct adv_info *adv,
> +			    const struct hci_cp_le_set_ext_adv_params *cp,
> +			    struct hci_rp_le_set_ext_adv_params *rp)
> +{
> +	struct sk_buff *skb;
> +
> +	skb = __hci_cmd_sync(hdev, HCI_OP_LE_SET_EXT_ADV_PARAMS, sizeof(*cp),
> +			     cp, HCI_CMD_TIMEOUT);
> +
> +	/* If command return a status event, skb will be set to -ENODATA */
> +	if (skb == ERR_PTR(-ENODATA))
> +		return 0;
> +
> +	if (IS_ERR(skb)) {
> +		bt_dev_err(hdev, "Opcode 0x%4.4x failed: %ld",
> +			   HCI_OP_LE_SET_EXT_ADV_PARAMS, PTR_ERR(skb));
> +		return PTR_ERR(skb);
> +	}
> +
> +	if (skb->len != sizeof(*rp)) {
> +		bt_dev_err(hdev, "Invalid response length for "
> +			   "HCI_OP_LE_SET_EXT_ADV_PARAMS: %u", skb->len);
> +		kfree_skb(skb);
> +		return -EIO;
> +	}
> +
> +	memcpy(rp, skb->data, sizeof(*rp));
> +	kfree_skb(skb);
> +
> +	if (!rp->status) {
> +		hdev->adv_addr_type = cp->own_addr_type;
> +		if (!cp->handle) {
> +			/* Store in hdev for instance 0 */
> +			hdev->adv_tx_power = rp->tx_power;
> +		} else if (adv) {
> +			adv->tx_power = rp->tx_power;
> +		}
> +	}
> +
> +	return rp->status;
> +}
> +
> +static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
> +{
> +	DEFINE_FLEX(struct hci_cp_le_set_ext_adv_data, pdu, data, length,
> +		    HCI_MAX_EXT_AD_LENGTH);
> +	u8 len;
> +	struct adv_info *adv = NULL;
> +	int err;
> +
> +	if (instance) {
> +		adv = hci_find_adv_instance(hdev, instance);
> +		if (!adv || !adv->adv_data_changed)
> +			return 0;
> +	}
> +
> +	len = eir_create_adv_data(hdev, instance, pdu->data,
> +				  HCI_MAX_EXT_AD_LENGTH);
> +
> +	pdu->length = len;
> +	pdu->handle = adv ? adv->handle : instance;
> +	pdu->operation = LE_SET_ADV_DATA_OP_COMPLETE;
> +	pdu->frag_pref = LE_SET_ADV_DATA_NO_FRAG;
> +
> +	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_DATA,
> +				    struct_size(pdu, data, len), pdu,
> +				    HCI_CMD_TIMEOUT);
> +	if (err)
> +		return err;
> +
> +	/* Update data if the command succeed */
> +	if (adv) {
> +		adv->adv_data_changed = false;
> +	} else {
> +		memcpy(hdev->adv_data, pdu->data, len);
> +		hdev->adv_data_len = len;
> +	}
> +
> +	return 0;
> +}
> +
> +static int hci_set_adv_data_sync(struct hci_dev *hdev, u8 instance)
> +{
> +	struct hci_cp_le_set_adv_data cp;
> +	u8 len;
> +
> +	memset(&cp, 0, sizeof(cp));
> +
> +	len = eir_create_adv_data(hdev, instance, cp.data, sizeof(cp.data));
> +
> +	/* There's nothing to do if the data hasn't changed */
> +	if (hdev->adv_data_len == len &&
> +	    memcmp(cp.data, hdev->adv_data, len) == 0)
> +		return 0;
> +
> +	memcpy(hdev->adv_data, cp.data, sizeof(cp.data));
> +	hdev->adv_data_len = len;
> +
> +	cp.length = len;
> +
> +	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_DATA,
> +				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> +}
> +
> +int hci_update_adv_data_sync(struct hci_dev *hdev, u8 instance)
> +{
> +	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
> +		return 0;
> +
> +	if (ext_adv_capable(hdev))
> +		return hci_set_ext_adv_data_sync(hdev, instance);
> +
> +	return hci_set_adv_data_sync(hdev, instance);
> +}
> +
>  int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
>  {
>  	struct hci_cp_le_set_ext_adv_params cp;
> +	struct hci_rp_le_set_ext_adv_params rp;
>  	bool connectable;
>  	u32 flags;
>  	bdaddr_t random_addr;
> @@ -1316,8 +1433,12 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
>  		cp.secondary_phy = HCI_ADV_PHY_1M;
>  	}
>  
> -	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_PARAMS,
> -				    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> +	err = hci_set_ext_adv_params_sync(hdev, adv, &cp, &rp);
> +	if (err)
> +		return err;
> +
> +	/* Update adv data as tx power is known now */
> +	err = hci_set_ext_adv_data_sync(hdev, cp.handle);
>  	if (err)
>  		return err;
>  
> @@ -1822,79 +1943,6 @@ int hci_le_terminate_big_sync(struct hci_dev *hdev, u8 handle, u8 reason)
>  				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
>  }
>  
> -static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
> -{
> -	DEFINE_FLEX(struct hci_cp_le_set_ext_adv_data, pdu, data, length,
> -		    HCI_MAX_EXT_AD_LENGTH);
> -	u8 len;
> -	struct adv_info *adv = NULL;
> -	int err;
> -
> -	if (instance) {
> -		adv = hci_find_adv_instance(hdev, instance);
> -		if (!adv || !adv->adv_data_changed)
> -			return 0;
> -	}
> -
> -	len = eir_create_adv_data(hdev, instance, pdu->data,
> -				  HCI_MAX_EXT_AD_LENGTH);
> -
> -	pdu->length = len;
> -	pdu->handle = adv ? adv->handle : instance;
> -	pdu->operation = LE_SET_ADV_DATA_OP_COMPLETE;
> -	pdu->frag_pref = LE_SET_ADV_DATA_NO_FRAG;
> -
> -	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_DATA,
> -				    struct_size(pdu, data, len), pdu,
> -				    HCI_CMD_TIMEOUT);
> -	if (err)
> -		return err;
> -
> -	/* Update data if the command succeed */
> -	if (adv) {
> -		adv->adv_data_changed = false;
> -	} else {
> -		memcpy(hdev->adv_data, pdu->data, len);
> -		hdev->adv_data_len = len;
> -	}
> -
> -	return 0;
> -}
> -
> -static int hci_set_adv_data_sync(struct hci_dev *hdev, u8 instance)
> -{
> -	struct hci_cp_le_set_adv_data cp;
> -	u8 len;
> -
> -	memset(&cp, 0, sizeof(cp));
> -
> -	len = eir_create_adv_data(hdev, instance, cp.data, sizeof(cp.data));
> -
> -	/* There's nothing to do if the data hasn't changed */
> -	if (hdev->adv_data_len == len &&
> -	    memcmp(cp.data, hdev->adv_data, len) == 0)
> -		return 0;
> -
> -	memcpy(hdev->adv_data, cp.data, sizeof(cp.data));
> -	hdev->adv_data_len = len;
> -
> -	cp.length = len;
> -
> -	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_DATA,
> -				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> -}
> -
> -int hci_update_adv_data_sync(struct hci_dev *hdev, u8 instance)
> -{
> -	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
> -		return 0;
> -
> -	if (ext_adv_capable(hdev))
> -		return hci_set_ext_adv_data_sync(hdev, instance);
> -
> -	return hci_set_adv_data_sync(hdev, instance);
> -}
> -
>  int hci_schedule_adv_instance_sync(struct hci_dev *hdev, u8 instance,
>  				   bool force)
>  {
> @@ -6269,6 +6317,7 @@ static int hci_le_ext_directed_advertising_sync(struct hci_dev *hdev,
>  						struct hci_conn *conn)
>  {
>  	struct hci_cp_le_set_ext_adv_params cp;
> +	struct hci_rp_le_set_ext_adv_params rp;
>  	int err;
>  	bdaddr_t random_addr;
>  	u8 own_addr_type;
> @@ -6310,8 +6359,12 @@ static int hci_le_ext_directed_advertising_sync(struct hci_dev *hdev,
>  	if (err)
>  		return err;
>  
> -	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_PARAMS,
> -				    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> +	err = hci_set_ext_adv_params_sync(hdev, NULL, &cp, &rp);
> +	if (err)
> +		return err;
> +
> +	/* Update adv data as tx power is known now */
> +	err = hci_set_ext_adv_data_sync(hdev, cp.handle);
>  	if (err)
>  		return err;
>  
> 





