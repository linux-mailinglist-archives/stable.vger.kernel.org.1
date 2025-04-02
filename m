Return-Path: <stable+bounces-127392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B3DA789BB
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 10:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603161893B5A
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 08:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB49623372B;
	Wed,  2 Apr 2025 08:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mg+pvMKj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA781F1507
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 08:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743582283; cv=none; b=C9IFWCtmQXQNSjfdttS/O/wH+/bAA5v2AAOUkviE9QbIO8c319ogWdtqvACqXo3ypTeuocsff62u3QosvC/L9rgWDP8P/8ARAm9lJatcnQT5ogKjBX/ibCh5rkWExeJqHAzUmd91Ly4fpU0Qg8QAA9OB9UI/6CB07KQ3VzNmLts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743582283; c=relaxed/simple;
	bh=51L/RGs44Jn76wixvjdhDib018qjWH1EjB3rFi+FkNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNJr9w4M11O/ydr2yvx9jLBRthTL+c4yYma+JteN9evuPeYWLLREDFeYZXZ9YazpIyjGCX9LABPElCnsI8fcLvzqMc/Myph7HhDF7hjbwn5pT/JeA6YCxtCiqnd4ddrTPjvIPDIPj0WCLpqpMsmWcgi/CGCGH6wqQdsSkMkm+t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mg+pvMKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64DAC4CEDD;
	Wed,  2 Apr 2025 08:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743582282;
	bh=51L/RGs44Jn76wixvjdhDib018qjWH1EjB3rFi+FkNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mg+pvMKjZNObHee21iJ8zZvKksRho43M/EWGkRUmtaySvRKjsL6YigvbRVloqtoDP
	 yh+5n/l55M/X2VdbQm5ADaxfbN9nx1a5ixaLrI6YQRClyXrreJ4JMBA1xHWQD3mZ/c
	 Suh4vflq2MxbyZXEx6MFq8iV3nb2iiWytyF1XkEo=
Date: Wed, 2 Apr 2025 09:23:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sean Rhodes <sean@starlabs.systems>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Revert vendor-specific ISO classification for
Message-ID: <2025040201-whole-ritzy-0195@gregkh>
References: <CABtds-0a9d5OMjOTO2Juf6zTvK5inq9BKnKUkWE1of-gnk7TDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABtds-0a9d5OMjOTO2Juf6zTvK5inq9BKnKUkWE1of-gnk7TDQ@mail.gmail.com>

On Wed, Apr 02, 2025 at 04:15:26AM -0400, Sean Rhodes wrote:
> >From ccabbdd36dacc3e03ed819b4b050ebcc1978e311 Mon Sep 17 00:00:00 2001
> From: Sean Rhodes <sean@starlabs.systems>
> Date: Wed, 2 Apr 2025 09:05:17 +0100
> Subject: [PATCH] Bluetooth: Revert vendor-specific ISO classification for
>  non-offload cards
> 
> This reverts commit f25b7fd36cc3a850e006aed686f5bbecd200de1b.
> 
> The commit introduces vendor-specific classification of ISO data,
> but breaks Bluetooth functionality on certain Intel cards that do
> not support audio offload, such as the 9462. Affected devices are
> unable to discover new Bluetooth peripherals, and previously paired
> devices fail to reconnect.
> 
> This issue does not affect newer cards (e.g., AX201+) that support
> audio offload. A conditional check using AOLD() could be used in
> the future to reintroduce this behavior only on supported hardware.
> 
> Cc: Ying Hsu <yinghsu@chromium.org>
> Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Sean Rhodes <sean@starlabs.systems>
> ---
>  drivers/bluetooth/btintel.c      |  7 ++-----
>  include/net/bluetooth/hci_core.h |  1 -
>  net/bluetooth/hci_core.c         | 16 ----------------
>  3 files changed, 2 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 48e2f400957b..2114fe8d527e 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -3588,15 +3588,12 @@ static int btintel_setup_combined(struct hci_dev *hdev)
>  		err = btintel_bootloader_setup(hdev, &ver);
>  		btintel_register_devcoredump_support(hdev);
>  		break;
> -	case 0x18: /* GfP2 */
> -	case 0x1c: /* GaP */
> -		/* Re-classify packet type for controllers with LE audio */
> -		hdev->classify_pkt_type = btintel_classify_pkt_type;
> -		fallthrough;
>  	case 0x17:
> +	case 0x18:
>  	case 0x19:
>  	case 0x1b:
>  	case 0x1d:
> +	case 0x1c:
>  	case 0x1e:
>  	case 0x1f:
>  		/* Display version information of TLV type */
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 5115da34f881..d1a4436e4cc3 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -646,7 +646,6 @@ struct hci_dev {
>  	int (*get_codec_config_data)(struct hci_dev *hdev, __u8 type,
>  				     struct bt_codec *codec, __u8 *vnd_len,
>  				     __u8 **vnd_data);
> -	u8 (*classify_pkt_type)(struct hci_dev *hdev, struct sk_buff *skb);
>  };
> 
>  #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 5eb0600bbd03..5b7515703ad1 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2868,31 +2868,15 @@ int hci_reset_dev(struct hci_dev *hdev)
>  }
>  EXPORT_SYMBOL(hci_reset_dev);
> 
> -static u8 hci_dev_classify_pkt_type(struct hci_dev *hdev, struct sk_buff *skb)
> -{
> -	if (hdev->classify_pkt_type)
> -		return hdev->classify_pkt_type(hdev, skb);
> -
> -	return hci_skb_pkt_type(skb);
> -}
> -
>  /* Receive frame from HCI drivers */
>  int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
>  {
> -	u8 dev_pkt_type;
> -
>  	if (!hdev || (!test_bit(HCI_UP, &hdev->flags)
>  		      && !test_bit(HCI_INIT, &hdev->flags))) {
>  		kfree_skb(skb);
>  		return -ENXIO;
>  	}
> 
> -	/* Check if the driver agree with packet type classification */
> -	dev_pkt_type = hci_dev_classify_pkt_type(hdev, skb);
> -	if (hci_skb_pkt_type(skb) != dev_pkt_type) {
> -		hci_skb_pkt_type(skb) = dev_pkt_type;
> -	}
> -
>  	switch (hci_skb_pkt_type(skb)) {
>  	case HCI_EVENT_PKT:
>  		break;
> -- 
> 2.45.2
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

