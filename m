Return-Path: <stable+bounces-223175-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLqHKc0tqWl12wAAu9opvQ
	(envelope-from <stable+bounces-223175-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 08:16:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 397D620C6B4
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 08:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A7333016D24
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 07:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90FD31E823;
	Thu,  5 Mar 2026 07:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bi8CSIF6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B1818D658;
	Thu,  5 Mar 2026 07:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772694986; cv=none; b=oG7aIDk9iiiA35lrmOXhnad8ruY5qzIITfmZldg2nVtbmsrOa69Ai0cbzCX9/45ggQ08sog2jzNjVBEdLEhdtii0XlkJMwTfEvjQ8nCnsvENhvYetugKKJvhEFe3yvDvFKrJkM0NUnheiXrV2mNDEzVGt+GFQd6IcRhctCBw3Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772694986; c=relaxed/simple;
	bh=zm0BBehVIWP0I1olQbw+tWMfdjnNis/Oqinuk99CnW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6N+w7HnzkMiuvlzPLL9mRJzGcfpcpm8WHdNDmgw3/QzM0WCjHAnMawCvLsXdF0ZebUzvW6VcOcFIJTEaS/o/HHWRIP7ADM0+NQ8Dr65+G2mOgdcMIQIh/5tISEATTqpdohC2CBbrCEb6WR64WolsO1woKx0hVX3EfaAh4ExH9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bi8CSIF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D640DC116C6;
	Thu,  5 Mar 2026 07:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772694986;
	bh=zm0BBehVIWP0I1olQbw+tWMfdjnNis/Oqinuk99CnW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bi8CSIF61U93BsoBQni2oeOg7tdGrZrE6V/fkS+JW8eMgNj8Dd5KrAnOezcgrlwZz
	 qzADXbS73sUxLlHTHsMXFW8S30HvpbCyU/Q8ZDuMgLY2HSe+VKRGCVmW+gBQVeVkb/
	 rRVhRbFHY0qJ3DMtq4M4OPZNOEef4WfnwVobbI/o=
Date: Thu, 5 Mar 2026 08:16:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kai Zen <kai.aizen.dev@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com,
	stable@vger.kernel.org, marcel@holtmann.org
Subject: Re: [PATCH v3] Bluetooth: hci_conn: Fix UAF in create_big_sync and
 create_big_complete
Message-ID: <2026030557-apprehend-implicate-5b2b@gregkh>
References: <CALynFi7dq+5R+TRYa3T-9ethQ_TKegBtiv1AAAG5Lfb9oMto2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALynFi7dq+5R+TRYa3T-9ethQ_TKegBtiv1AAAG5Lfb9oMto2A@mail.gmail.com>
X-Rspamd-Queue-Id: 397D620C6B4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223175-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 03:19:19AM +0200, Kai Zen wrote:
> create_big_sync() and create_big_complete() are queued via
> hci_cmd_sync_queue() with a raw hci_conn pointer as 'data', but unlike
> all other hci_cmd_sync_queue() callbacks that receive an hci_conn pointer
> they lack an hci_conn_valid() guard.
> 
> If the connection is torn down after the work is queued but before (or
> during) execution, the work dereferences a freed hci_conn object.
> 
> Race path:
>  1. hci_connect_bis() queues create_big_sync(conn) on hdev->req_workqueue
>  2. ISO socket close() triggers hci_conn_drop(); for BIS_LINK timeo=0,
>     disc_work fires immediately on hdev->workqueue
>  3. disc_work -> hci_abort_conn -> hci_conn_del() frees conn
>  4. create_big_sync() dequeued and runs on req_workqueue; conn is
>     already freed -> slab-use-after-free
> 
> The two workqueues are distinct (req_workqueue vs workqueue). The only
> lock held by create_big_sync is hci_req_sync_lock; the deletion path
> in HCI event handlers holds only hci_dev_lock. No shared lock prevents
> concurrent execution.
> 
> This is the same bug class fixed for hci_enhanced_setup_sync in commit
> 98ccd44002d8 ("Bluetooth: hci_conn: Fix UAF in hci_enhanced_setup_sync"),
> and for hci_le_create_conn_sync, hci_le_pa_create_sync,
> hci_le_big_create_sync, hci_acl_create_conn_sync. create_big_sync and
> create_big_complete in hci_conn.c were not included in those sweeps.
> 
> Fix: add hci_conn_valid() guard at the start of both functions. In
> create_big_sync the 'qos' pointer assignment is moved past the guard
> to avoid dereferencing conn before validation.
> 
> Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connections")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kai Aizen <kai.aizen.dev@gmail.com>
> ---
> v3: Rebase on bluetooth-next HEAD 50003ce2; no logic changes
> v2: Regenerate with git format-patch to fix malformed patch fragment header
> v1: Initial submission
> 
>  net/bluetooth/hci_conn.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index a47f5da..e7fe9cc 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -2119,10 +2119,15 @@ static void hci_iso_qos_setup(struct hci_dev
> *hdev, struct hci_conn *conn,
>  static int create_big_sync(struct hci_dev *hdev, void *data)
>  {
>         struct hci_conn *conn = data;
> -       struct bt_iso_qos *qos = &conn->iso_qos;
>         u16 interval, sync_interval = 0;
>         u32 flags = 0;
>         int err;
> +       struct bt_iso_qos *qos;
> +
> +       if (!hci_conn_valid(hdev, conn))
> +               return -ECANCELED;
> +
> +       qos = &conn->iso_qos;
> 
>         if (qos->bcast.out.phys == BIT(1))
>                 flags |= MGMT_ADV_FLAG_SEC_2M;
> @@ -2196,6 +2201,9 @@ static void create_big_complete(struct hci_dev
> *hdev, void *data, int err)
>  {
>         struct hci_conn *conn = data;
> 
> +       if (!hci_conn_valid(hdev, conn))
> +               return;
> +
>         bt_dev_dbg(hdev, "conn %p", conn);
> 
>         if (err) {
> --
> 2.43.0
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/process/email-clients.rst in order to fix this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

