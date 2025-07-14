Return-Path: <stable+bounces-161880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFA3B04754
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 20:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D6227A65C7
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 18:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B32E272E56;
	Mon, 14 Jul 2025 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="jTn83Mgz"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012048.outbound.protection.outlook.com [52.101.71.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC3C272E44;
	Mon, 14 Jul 2025 18:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516906; cv=fail; b=ZqgRC4lHM76eTTtLMefwveA5ieXovnf/NXM/Nffzndkd3ra/ioXFcUROnksVKrvUkHu7m7cwmla7xkRrg1zkKVMkcHPLiy4oEDyXLEA60G1IF6L7X3dTRDSYUe8Pwc7WgaWgZVrbBbFJqyNfTTKVlxyoKinZ0WpEgyebmewzpO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516906; c=relaxed/simple;
	bh=Y/eeiIpBxi5fT3pH2Lq8be9HmolEeD5BktDO1ov5wYw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n6kEBe+xSlee/tYmvGDJhgS84oG/k2j+g6ALXUxTReluhKDxo36Np9kTNGrSMvW7Y66D43cj2tPJ89QJ1UCHGsT7Oq/N1H0/qsTn+r8ctlSpE1p+xd4hnBznaWZUaGjU1BMimkQATFY6Qsi6she1p+CqR7ryDJ5esWhtfmg31CI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=jTn83Mgz; arc=fail smtp.client-ip=52.101.71.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D24SshOab5GxTBvzaFT4w95EP/2H4B2+VcZO9tjE+7xYVei7P4qQkOhfU1JhydcHu+/szVOE3SAc7WN3REHEfmKfVzCPyuRceMBXVMhIoXaMR+HDiRlmWx50ZKdk9uF7lt+la3NUsOGNdOmFmycJkaoYZWQqbPwym8zjJ87hW0fgsj1VWLXa3RvAdjI4/S52/mYRnF79QT1iiKE7VnCQB9qAMgp7tuYD44qiMHxgU40V3rvVXFnYLLdzer5bq+iUWDZEZA5zJFio7PnyXAMRtRcISm3tSwTXmzdvisRXSUzonAQMFHJ2EfVUE3VHrB7kd+poGKf5bh4PdpzfSbifnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoiviGBCq2dRLE/ZCl6MihmAORAQSP9BlVGhirf2PoM=;
 b=uWo5CBqd3YhYLTS4/NhASphn7GxvhHz2q0diEwdCoSQgu08ZI3zlPNFBnQ9Xe85lB/BLbYZZuHAkncLZvYCwM786EvfxivcwUGsrejXwKKzHdSMxG/UJuP8uGjbasFvk1M2UKwwsR7NN8AMHXqvHsQei+pC7Jcl3G5QUKnh+O/TISEG8syOQXV4SNnFUcfzUdarC3ZR7Is5BVMtQ87AmTvIqtqMdsevoNsFZSZ6hY/sJkZOeZbgDP7d9BRb4JjHlG7TXS7vqOcLprHDxo2ez0Ft4QEfW+28vLd59VdduddnGcbmnE2U/UdyiHXk27Uw85RJBZH8nHayGxfpU33Qdog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoiviGBCq2dRLE/ZCl6MihmAORAQSP9BlVGhirf2PoM=;
 b=jTn83Mgzr6OJ4lo7hTM8yxzOzh6aRitlwXQPyV+OV3Fjlxn8sYee97GTcdhEAkXGxB1QBDhC9/cs2v2XB0HuIvfyySL3IhmNNjHgyb6CXvcO7+spXy1mDo2tpNjdtATWtoOfQRut14mQClNe+q43JQYWhemM5/emqWeSVLVi32s=
Received: from AS4P250CA0016.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5e3::8)
 by AM9PR03MB7106.eurprd03.prod.outlook.com (2603:10a6:20b:2db::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 18:14:58 +0000
Received: from AMS1EPF00000047.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e3:cafe::71) by AS4P250CA0016.outlook.office365.com
 (2603:10a6:20b:5e3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.33 via Frontend Transport; Mon,
 14 Jul 2025 18:14:58 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS1EPF00000047.mail.protection.outlook.com (10.167.16.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 18:14:57 +0000
Received: from n9w6sw14.localnet (192.168.54.13) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Mon, 14 Jul
 2025 20:14:56 +0200
From: Christian Eggers <ceggers@arri.de>
To: <stable-commits@vger.kernel.org>, <stable@vger.kernel.org>
CC: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: Patch "Bluetooth: HCI: Set extended advertising data synchronously" has
 been added to the 5.10-stable tree
Date: Mon, 14 Jul 2025 20:14:56 +0200
Message-ID: <5618464.E0xQCEvomI@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <20250714173707.3545937-1-sashal@kernel.org>
References: <20250714173707.3545937-1-sashal@kernel.org>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000047:EE_|AM9PR03MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: 37ae7070-9784-4e10-303b-08ddc3025723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VhqSfvodn07jPHctCiAg12SgreMHMw9n8+ovEI9O86AhkVfF5GS3Xc7QhInt?=
 =?us-ascii?Q?2k9/EvyNKRO6Vawz3TQRHAbJUgBWdPpdF76W9eT8pf8PK0N4bJ4PgfAeLp7S?=
 =?us-ascii?Q?7z6HDUgAKz22HwX1GBeDpetW24h+3CtNIKKtPEN4d7g3XBIkAzW4xaBaptDy?=
 =?us-ascii?Q?pIY8uVMKUKrpJpMScCMyY6Mm5FSQhSrkIZZHNvUCwce4E0pvTn82v5zaBcbd?=
 =?us-ascii?Q?4RdIuYdpncFpsLsg8YKAbWQiBFDu0iRB4KWihkgVX6WJp0iU5x5za4Wz0Ykj?=
 =?us-ascii?Q?XMhQNl11LL9UZa53/u9vW3/Euf4yHIgf0NZJiI10NzOlBV8ufFBRuRsz8n5u?=
 =?us-ascii?Q?kFoij191V0ol8CG+s/kkomI1h184iQUMQXiHjfKGdmkUPBsOT/vMNr3lkxpF?=
 =?us-ascii?Q?f5X6tYhu/1TsZR84l2hH8aOk5tcFcgW1055Dz6p9Uvai5WY6WMt5LauuivO6?=
 =?us-ascii?Q?N9KTa8Zb2x3mOE7cyrNoejaVIhSgQnqIlbJ4iABGfStj0DOYaAe+4TvsUfwI?=
 =?us-ascii?Q?JgHhyMXHFQzj1zEmHDHm7H5hZjxqOxIZmkoeuamaVq/5NcGe1Vyh82tTZVMH?=
 =?us-ascii?Q?XfvAVskLRypxmBfv4i2eH9/tUnhqVXdORPjsCuqR6gIrQm2qJxgpPFJW9Dmd?=
 =?us-ascii?Q?Etd1m396+nJBd5qNwOvthdxYZ+4zbUQ2l8N/e55Ay76O/k6P7mHFaogDWC1z?=
 =?us-ascii?Q?K0k+9XfGFKD7+mhLCLnnjeOZB7HzI4aWqnTzZCuUE8yvvd7Gv/9BW1VJgR/N?=
 =?us-ascii?Q?0TmmC+nJicnjyMZXtuSzdMGZZz4S1g2fJeXQK5N/EHyrsjwQOfblVggixMvE?=
 =?us-ascii?Q?wLHdRBp1MBpNTo868YmFXuHq6upd5skvU1qF9SK6aTzueslApAQatJArcsdO?=
 =?us-ascii?Q?TvVSGU4BKWtyIBwcuzgSHtxN6TFvVV/GcDLY/vrgxGxW2dJwiLLnZcCaZ/3g?=
 =?us-ascii?Q?7JIxm378pYv7e89nMIoROVM1S7G9+0rwRhcnb7YrDuYgRk9IMq3owY6ekoi4?=
 =?us-ascii?Q?a74KPA6sNrlJUR5yHXaZavMB06EMrnQkX+t1hLe8dq4ndUhl+8eDZJIFVXLU?=
 =?us-ascii?Q?0r8157s4aXJdH/YCUqaJE+AXCfR6F17RwO+t/S7IWWoMHeLwnZzW9u8EophD?=
 =?us-ascii?Q?E5Nb6hNCvpTZd4vNVEiJV+6UbnAiO31AQMDOZh+VkRlm+5JpKHNgVwcqZfX1?=
 =?us-ascii?Q?iJvo9T2IoRDdmFmfXw6HTR8kg6KiW82Gm5+EKQdy6/llzWXNwBv6XEka9R4G?=
 =?us-ascii?Q?a+0I1UUdLm7KJmjaFyZxzcYgr22eT0i8J5o/cJX6t3HBIIQ34hH9EkLfWesc?=
 =?us-ascii?Q?ybFXNZlTtmqcGgaqDJbA/mGdz+ETYlVx96/V2f5DYRrIPcsw+c4iCFvjbxHW?=
 =?us-ascii?Q?D9yICd8e5Y2caTe4YfgKdb3Q1G7vfaQFHPJjmZeczFS5BuihR4TBVNwp93H3?=
 =?us-ascii?Q?965cwAtkbTBQm+oFoadhQ8Qz49O9jkr1jIxkCsLCZA/Szo3yvwgKq20N7LCG?=
 =?us-ascii?Q?BCvmO2VO570t6kotoogOvWOyVSS2V53QVw1IVCAOBF5zSHL4IopNb74LWA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 18:14:57.5321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ae7070-9784-4e10-303b-08ddc3025723
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000047.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7106

Hi Sasha,

the changes in hci_request.c look quite different from what I submitted for mainline
(and also from the version for 6.6 LTS). Are you sure that everything went correctly?

regards,
Christian

On Monday, 14 July 2025, 19:37:07 CEST, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     Bluetooth: HCI: Set extended advertising data synchronously
> 
> to the 5.10-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      bluetooth-hci-set-extended-advertising-data-synchron.patch
> and it can be found in the queue-5.10 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 8766e406adb9b3c4bd8c0506a71bbbf99a43906d
> Author: Christian Eggers <ceggers@arri.de>
> Date:   Sat Jul 12 02:08:03 2025 -0400
> 
>     Bluetooth: HCI: Set extended advertising data synchronously
>     
>     [ Upstream commit 89fb8acc38852116d38d721ad394aad7f2871670 ]
>     
>     Currently, for controllers with extended advertising, the advertising
>     data is set in the asynchronous response handler for extended
>     adverstising params. As most advertising settings are performed in a
>     synchronous context, the (asynchronous) setting of the advertising data
>     is done too late (after enabling the advertising).
>     
>     Move setting of adverstising data from asynchronous response handler
>     into synchronous context to fix ordering of HCI commands.
>     
>     Signed-off-by: Christian Eggers <ceggers@arri.de>
>     Fixes: a0fb3726ba55 ("Bluetooth: Use Set ext adv/scan rsp data if controller supports")
>     Cc: stable@vger.kernel.org
>     v2: https://lore.kernel.org/linux-bluetooth/20250626115209.17839-1-ceggers@arri.de/
>     Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 7f26c1aab9a06..2cc4aaba09abe 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1726,36 +1726,6 @@ static void hci_cc_set_adv_param(struct hci_dev *hdev, struct sk_buff *skb)
>  	hci_dev_unlock(hdev);
>  }
>  
> -static void hci_cc_set_ext_adv_param(struct hci_dev *hdev, struct sk_buff *skb)
> -{
> -	struct hci_rp_le_set_ext_adv_params *rp = (void *) skb->data;
> -	struct hci_cp_le_set_ext_adv_params *cp;
> -	struct adv_info *adv_instance;
> -
> -	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
> -
> -	if (rp->status)
> -		return;
> -
> -	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_EXT_ADV_PARAMS);
> -	if (!cp)
> -		return;
> -
> -	hci_dev_lock(hdev);
> -	hdev->adv_addr_type = cp->own_addr_type;
> -	if (!hdev->cur_adv_instance) {
> -		/* Store in hdev for instance 0 */
> -		hdev->adv_tx_power = rp->tx_power;
> -	} else {
> -		adv_instance = hci_find_adv_instance(hdev,
> -						     hdev->cur_adv_instance);
> -		if (adv_instance)
> -			adv_instance->tx_power = rp->tx_power;
> -	}
> -	/* Update adv data as tx power is known now */
> -	hci_req_update_adv_data(hdev, hdev->cur_adv_instance);
> -	hci_dev_unlock(hdev);
> -}
>  
>  static void hci_cc_read_rssi(struct hci_dev *hdev, struct sk_buff *skb)
>  {
> @@ -3601,9 +3571,6 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
>  		hci_cc_le_read_num_adv_sets(hdev, skb);
>  		break;
>  
> -	case HCI_OP_LE_SET_EXT_ADV_PARAMS:
> -		hci_cc_set_ext_adv_param(hdev, skb);
> -		break;
>  
>  	case HCI_OP_LE_SET_EXT_ADV_ENABLE:
>  		hci_cc_le_set_ext_adv_enable(hdev, skb);
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index 7ce6db1ac558a..743ba58941f8b 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -2179,6 +2179,9 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
>  
>  	hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_PARAMS, sizeof(cp), &cp);
>  
> +	/* Update adv data after setting ext adv params */
> +	__hci_req_update_adv_data(req, instance);
> +
>  	if (own_addr_type == ADDR_LE_DEV_RANDOM &&
>  	    bacmp(&random_addr, BDADDR_ANY)) {
>  		struct hci_cp_le_set_adv_set_rand_addr cp;
> 





