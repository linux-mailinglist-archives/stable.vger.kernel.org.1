Return-Path: <stable+bounces-230481-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLXVMKBMxWkU8wQAu9opvQ
	(envelope-from <stable+bounces-230481-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 16:11:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64350337504
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 16:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 62443308B545
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 14:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314043FF8A4;
	Thu, 26 Mar 2026 14:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dymPY28y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53F63FE663;
	Thu, 26 Mar 2026 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774537084; cv=none; b=EFaoEgtTMtGg+/rKEW8jKlgCLFxjqazOVEMkQ1X5Pb0Nsn1+7XbyxqJm2hfPfvOxurvWVkjw3rtxb6GVDOoNFUXbFBfMMG4GzFnOoGHTTh7Pjr1wwHPJ4gFn8My1VRUSc3QgvVr6BVXldzNc8MtnSAx46+3SDRoouu6k0NnzU2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774537084; c=relaxed/simple;
	bh=DcICTftvzwVNDp8gio6HR/jGOLagZ/JLyo9jhkTqy5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZdz/8q8zoGZAM2nEdxJin8KIqLnb5PcYA1fphmGDPG9hlGvH0EuANEHfsdPJSYW3WbIwzw78Hq/LAQ2zAZH5ukKaReAuX7/ueMOHh6UpyKXkP+XmiVSTnygyQGBRpTg7rorRXLF7BrnfNCstz5jSoF1m9aTuaQv1QyKI71PITE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dymPY28y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A037C116C6;
	Thu, 26 Mar 2026 14:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774537083;
	bh=DcICTftvzwVNDp8gio6HR/jGOLagZ/JLyo9jhkTqy5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dymPY28ynkyvEMYL90quTunpmvWMPbkYR9DE5zimyc9DVdMIwroFu4ok2vipMD6O8
	 Ondpj2evx9+U84qAc0MHi2DgVg3/AnLghod+LbgeC5rNKe3Hm27hZ1nPUJT/nD+pri
	 4TKRghMxkPMPB8M0BQ5DDz4By4OKtxyelBt2OkL8=
Date: Thu, 26 Mar 2026 15:57:39 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Oleh Konko <security@1seal.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"marcel@holtmann.org" <marcel@holtmann.org>,
	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] Bluetooth: hci_event: move wake reason storage into
 validated event handlers
Message-ID: <2026032626-rinsing-component-ed00@gregkh>
References: <9b8a0917d56b4a67ba541e8a5eb3abb8.security@1.0.0.127.in-addr.arpa>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b8a0917d56b4a67ba541e8a5eb3abb8.security@1.0.0.127.in-addr.arpa>
X-Spamd-Result: default: False [4.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FROM_DN_EQ_ADDR(1.00)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	GREYLIST(0.00)[pass,body];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-230481-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,holtmann.org,gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 64350337504
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 01:32:50PM +0000, Oleh Konko wrote:
> From f0e8b2abaf4a895fad81756277014582c773808d Mon Sep 17 00:00:00 2001
> From: Oleh Konko <security@1seal.org>
> Date: Thu, 26 Mar 2026 14:29:58 +0100
> Subject: [PATCH v3] Bluetooth: hci_event: move wake reason storage into
>  validated event handlers

If you use git send-email, the header will not be in the body like this.

> hci_store_wake_reason() is called from hci_event_packet() immediately
> after stripping the HCI event header but before hci_event_func()
> enforces the per-event minimum payload length from hci_ev_table.
> This means a short HCI event frame can reach bacpy() before any bounds
> check runs.
> 
> Rather than duplicating skb parsing and per-event length checks inside
> hci_store_wake_reason(), move wake-address storage into the individual
> event handlers after their existing event-length validation has
> succeeded. Convert hci_store_wake_reason() into a small helper that only
> stores an already-validated bdaddr while the caller holds hci_dev_lock().
> Use the same helper after hci_event_func() with a NULL address to
> preserve the existing unexpected-wake fallback semantics when no
> validated event handler records a wake address.
> 
> Call the helper from hci_conn_request_evt(), hci_conn_complete_evt(),
> hci_le_adv_report_evt(), hci_le_ext_adv_report_evt(), and
> hci_le_direct_adv_report_evt().
> 
> Fixes: 2f20216c1d6f ("Bluetooth: Emit controller suspend and resume events")
> Cc: stable@vger.kernel.org
> Signed-off-by: Oleh Konko <security@1seal.org>
> ---
> v3:
> - route the unexpected-wake fallback through hci_store_wake_reason(NULL, 0)
>   after hci_event_func(), as suggested in review
> 
>  net/bluetooth/hci_event.c | 89 +++++++++++++--------------------------
>  1 file changed, 29 insertions(+), 60 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 286529d2e..c0e0b4a1c 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -80,6 +80,9 @@ static void *hci_le_ev_skb_pull(struct hci_dev *hdev, struct sk_buff *skb,
>  	return data;
>  }
>  
> +static void hci_store_wake_reason(struct hci_dev *hdev,
> +				  const bdaddr_t *bdaddr, u8 addr_type);
> +
>  static u8 hci_cc_inquiry_cancel(struct hci_dev *hdev, void *data,
>  				struct sk_buff *skb)
>  {
> @@ -3111,6 +3114,7 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
>  	bt_dev_dbg(hdev, "status 0x%2.2x", status);
>  
>  	hci_dev_lock(hdev);
> +	hci_store_wake_reason(hdev, &ev->bdaddr, BDADDR_BREDR);
>  
>  	/* Check for existing connection:
>  	 *
> @@ -3274,6 +3278,10 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
>  
>  	bt_dev_dbg(hdev, "bdaddr %pMR type 0x%x", &ev->bdaddr, ev->link_type);
>  
> +	hci_dev_lock(hdev);
> +	hci_store_wake_reason(hdev, &ev->bdaddr, BDADDR_BREDR);
> +	hci_dev_unlock(hdev);
> +
>  	/* Reject incoming connection from device with same BD ADDR against
>  	 * CVE-2020-26555
>  	 */
> @@ -6403,6 +6411,8 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, void *data,
>  					info->length + 1))
>  			break;
>  
> +		hci_store_wake_reason(hdev, &info->bdaddr, info->bdaddr_type);
> +
>  		if (info->length <= max_adv_len(hdev)) {
>  			rssi = info->data[info->length];
>  			process_adv_report(hdev, info->type, &info->bdaddr,
> @@ -6491,6 +6501,8 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, void *data,
>  					info->length))
>  			break;
>  
> +		hci_store_wake_reason(hdev, &info->bdaddr, info->bdaddr_type);
> +
>  		evt_type = __le16_to_cpu(info->type) & LE_EXT_ADV_EVT_TYPE_MASK;
>  		legacy_evt_type = ext_evt_type_to_legacy(hdev, evt_type);
>  
> @@ -6834,6 +6846,8 @@ static void hci_le_direct_adv_report_evt(struct hci_dev *hdev, void *data,
>  	for (i = 0; i < ev->num; i++) {
>  		struct hci_ev_le_direct_adv_info *info = &ev->info[i];
>  
> +		hci_store_wake_reason(hdev, &info->bdaddr, info->bdaddr_type);
> +
>  		process_adv_report(hdev, info->type, &info->bdaddr,
>  				   info->bdaddr_type, &info->direct_addr,
>  				   info->direct_addr_type, HCI_ADV_PHY_1M, 0,
> @@ -7517,73 +7531,27 @@ static bool hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode,
>  	return true;
>  }
>  
> -static void hci_store_wake_reason(struct hci_dev *hdev, u8 event,
> -				  struct sk_buff *skb)
> +/* hdev lock must be held. pass NULL bdaddr to record an unexpected wake. */
> +static void hci_store_wake_reason(struct hci_dev *hdev,
> +				  const bdaddr_t *bdaddr, u8 addr_type)

If the lock must be held, why aren't you both adding the static test for
this at build time __must_hold(), and the runtime lock test so that we
know this lock is held?  That way any changes in any code paths in the
future will properly trigger at build and runtime to know to be fixed
up.

thanks,

greg k-h

