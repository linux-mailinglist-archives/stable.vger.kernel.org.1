Return-Path: <stable+bounces-160518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A74AFCF64
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 17:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31F073AE6B8
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 15:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9722E2647;
	Tue,  8 Jul 2025 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nt4VRMnN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9E51D5150;
	Tue,  8 Jul 2025 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989006; cv=none; b=optLWydifMIVXeBR8CLWMAJC6szI9Cbfn3j/zEPrs22o/W0mw7hdjg+ZzG7vLyeKGSDOkk0uwXA4UknAp3/hc98dCZu5tGx56ZubNgs1huTkCOkLhLUm8k3Q2GFZt6tDgehsmCWVE7ME0nPCA1NHvalXDhpRimeaf+tcSXtlOo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989006; c=relaxed/simple;
	bh=f+0odlMoAiURP5XEYb36zKqxbGUvP08jEOpDSz1Yw5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkbpf4SstG1ZTetGPEx3UIlG3XmNZT4qNhk3g5yiZ3eKGUJEovLneLoXJv7bWKgOIceygRMiYooZVWWuyhBLra2YsZZ+UK7JlSwvA+5YLMxLP6o9odOYJGsG75PK5sEmsrewdPvS3H974C4RVg8kqm8tM/KEeoS/wB+804MbpV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nt4VRMnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40EE7C4CEEF;
	Tue,  8 Jul 2025 15:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751989005;
	bh=f+0odlMoAiURP5XEYb36zKqxbGUvP08jEOpDSz1Yw5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nt4VRMnNiPXhqlmsy03wyMreCJZavdLg3sHP3F73IJObEdt8jdc1Pqf07+TNV0/GT
	 YBkFuYFSXayMtW+M4fS8CFR3xizhavUgXkUspae29GWSV/ewtgA2uTt9ntZxArMZD5
	 /DvpWC1KwZOx2bTbtM0fWJwI13nTyjwbaFGmCtKw=
Date: Tue, 8 Jul 2025 17:36:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Christian Eggers <ceggers@arri.de>
Cc: stable@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: Re: [PATCH 6.6.y] Bluetooth: HCI: Set extended advertising data
 synchronously
Message-ID: <2025070807-dimple-radish-723b@gregkh>
References: <2025070625-wafer-speed-20c1@gregkh>
 <20250707081306.22624-2-ceggers@arri.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707081306.22624-2-ceggers@arri.de>

On Mon, Jul 07, 2025 at 10:13:07AM +0200, Christian Eggers wrote:
> Upstream commit 89fb8acc38852116d38d721ad394aad7f2871670
> 
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
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/hci_event.c |  36 -------
>  net/bluetooth/hci_sync.c  | 213 ++++++++++++++++++++++++--------------
>  2 files changed, 133 insertions(+), 116 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 008d14b3d8b8..147766458a6c 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2139,40 +2139,6 @@ static u8 hci_cc_set_adv_param(struct hci_dev *hdev, void *data,
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
> @@ -4153,8 +4119,6 @@ static const struct hci_cc {
>  	HCI_CC(HCI_OP_LE_READ_NUM_SUPPORTED_ADV_SETS,
>  	       hci_cc_le_read_num_adv_sets,
>  	       sizeof(struct hci_rp_le_read_num_supported_adv_sets)),
> -	HCI_CC(HCI_OP_LE_SET_EXT_ADV_PARAMS, hci_cc_set_ext_adv_param,
> -	       sizeof(struct hci_rp_le_set_ext_adv_params)),
>  	HCI_CC_STATUS(HCI_OP_LE_SET_EXT_ADV_ENABLE,
>  		      hci_cc_le_set_ext_adv_enable),
>  	HCI_CC_STATUS(HCI_OP_LE_SET_ADV_SET_RAND_ADDR,
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index e92bc4ceb5ad..7b6c8f53e334 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -1224,9 +1224,129 @@ static int hci_set_adv_set_random_addr_sync(struct hci_dev *hdev, u8 instance,
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
> +		bt_dev_err(hdev, "Invalid response length for 0x%4.4x: %u",
> +			   HCI_OP_LE_SET_EXT_ADV_PARAMS, skb->len);
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
> +	struct {
> +		struct hci_cp_le_set_ext_adv_data cp;
> +		u8 data[HCI_MAX_EXT_AD_LENGTH];
> +	} pdu;
> +	u8 len;
> +	struct adv_info *adv = NULL;
> +	int err;
> +
> +	memset(&pdu, 0, sizeof(pdu));
> +
> +	if (instance) {
> +		adv = hci_find_adv_instance(hdev, instance);
> +		if (!adv || !adv->adv_data_changed)
> +			return 0;
> +	}
> +
> +	len = eir_create_adv_data(hdev, instance, pdu.data);
> +
> +	pdu.cp.length = len;
> +	pdu.cp.handle = instance;
> +	pdu.cp.operation = LE_SET_ADV_DATA_OP_COMPLETE;
> +	pdu.cp.frag_pref = LE_SET_ADV_DATA_NO_FRAG;
> +
> +	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_DATA,
> +				    sizeof(pdu.cp) + len, &pdu.cp,
> +				    HCI_CMD_TIMEOUT);
> +	if (err)
> +		return err;
> +
> +	/* Update data if the command succeed */
> +	if (adv) {
> +		adv->adv_data_changed = false;
> +	} else {
> +		memcpy(hdev->adv_data, pdu.data, len);
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
> +	len = eir_create_adv_data(hdev, instance, cp.data);
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
> @@ -1333,8 +1453,12 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
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
> @@ -1859,82 +1983,6 @@ int hci_le_terminate_big_sync(struct hci_dev *hdev, u8 handle, u8 reason)
>  				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
>  }
>  
> -static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
> -{
> -	struct {
> -		struct hci_cp_le_set_ext_adv_data cp;
> -		u8 data[HCI_MAX_EXT_AD_LENGTH];
> -	} pdu;
> -	u8 len;
> -	struct adv_info *adv = NULL;
> -	int err;
> -
> -	memset(&pdu, 0, sizeof(pdu));
> -
> -	if (instance) {
> -		adv = hci_find_adv_instance(hdev, instance);
> -		if (!adv || !adv->adv_data_changed)
> -			return 0;
> -	}
> -
> -	len = eir_create_adv_data(hdev, instance, pdu.data);
> -
> -	pdu.cp.length = len;
> -	pdu.cp.handle = instance;
> -	pdu.cp.operation = LE_SET_ADV_DATA_OP_COMPLETE;
> -	pdu.cp.frag_pref = LE_SET_ADV_DATA_NO_FRAG;
> -
> -	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_DATA,
> -				    sizeof(pdu.cp) + len, &pdu.cp,
> -				    HCI_CMD_TIMEOUT);
> -	if (err)
> -		return err;
> -
> -	/* Update data if the command succeed */
> -	if (adv) {
> -		adv->adv_data_changed = false;
> -	} else {
> -		memcpy(hdev->adv_data, pdu.data, len);
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
> -	len = eir_create_adv_data(hdev, instance, cp.data);
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
> @@ -6257,6 +6305,7 @@ static int hci_le_ext_directed_advertising_sync(struct hci_dev *hdev,
>  						struct hci_conn *conn)
>  {
>  	struct hci_cp_le_set_ext_adv_params cp;
> +	struct hci_rp_le_set_ext_adv_params rp;
>  	int err;
>  	bdaddr_t random_addr;
>  	u8 own_addr_type;
> @@ -6298,8 +6347,12 @@ static int hci_le_ext_directed_advertising_sync(struct hci_dev *hdev,
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
> -- 
> [Resend, upstream commit id was missing]
> 
> Hi Greg,
> 
> I've backported this patch for 6.6. There were some trivial merge 
> conflicts due to moved coded sections.
> 
> Please try it also for older trees. If I get any FAILED notices,
> I'll try to prepare patches for specific trees.

You made major changes here from the upstream version, PLEASE document
them properly in the changelog.  Also, can you test it to verify that it
works and doesn't blow up the stack like I'm guessing it might?

thanks,

greg k-h

