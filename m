Return-Path: <stable+bounces-235662-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAcHOeFc2Wm9owgAu9opvQ
	(envelope-from <stable+bounces-235662-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 22:26:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D4D3DC774
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 22:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1970830086A8
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 20:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9C536494B;
	Fri, 10 Apr 2026 20:26:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1FC28D8DA;
	Fri, 10 Apr 2026 20:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775852762; cv=none; b=LaXkvnW+C0Y/8yKYn70SvHlRJj/UxD8wpI5kWtqh+LKcpgCLGaJEfBb8e5/tHvdND659txAko1d5V+BLw5RD2WWEpSBE+aNg3lEfmFh/HbspRhwzA9Dn1S2h5A/woI2M+v3kE8i1o70OlO7t0aQkhs67+fcF05AEDIdCK0mQ2FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775852762; c=relaxed/simple;
	bh=yot+zdRwr5aDtTd8e5H0p0AvZOX3ikohHrI+JYthLQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QnoKxkQJpNN56VZvsWo/DdFGJfIdLOePCiu8hCMOSx6vY6LCEGHoYbLxg3BkYrI8IOWBOdU/z56f9dMUoxj5Jc4CEFsN8KSM31ZKbT61RN3tZVkMIllWq6ykKU75GvG7tPw4Qx7swJE3C8SvQclXRnJnGctChvofDBJ+56IFDwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.0.51.120] (unknown [62.214.191.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8DDB74C2C37D61;
	Fri, 10 Apr 2026 22:25:51 +0200 (CEST)
Message-ID: <eb7a2494-eadb-4801-a12e-68f537bfc94d@molgen.mpg.de>
Date: Fri, 10 Apr 2026 22:25:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] Bluetooth: hci_conn: fix potential UAF in
 create_big_sync
To: David Carlier <devnexen@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260410173451.4797-1-devnexen@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260410173451.4797-1-devnexen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[mpg.de];
	TAGGED_FROM(0.00)[bounces-235662-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.983];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,molgen.mpg.de:mid]
X-Rspamd-Queue-Id: E9D4D3DC774
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear David,


Thank you for the patch.

Am 10.04.26 um 19:34 schrieb David Carlier:
> Add hci_conn_valid() check in create_big_sync() to detect stale
> connections before proceeding with BIG creation. Fix
> create_big_complete() to handle the resulting -ECANCELED error
> and validate the connection under hci_dev_lock() before
> dereferencing, following the established pattern used by
> create_le_conn_complete() and create_pa_complete().

(Using 75 characters per line would save a line.)

> Without this, create_big_complete() would unconditionally
> dereference the stale conn pointer on error, causing a
> use-after-free via hci_connect_cfm() and hci_conn_del().
> 
> Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connections")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
> 
> v1 -> v2: fix create_big_complete() to handle -ECANCELED and
>    validate conn under hci_dev_lock(), matching the pattern in
>    create_le_conn_complete() and create_pa_complete().
> v1: https://lore.kernel.org/r/20260408155638.95927-1-devnexen@gmail.com
>   net/bluetooth/hci_conn.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 11d3ad8d2551..feebe933efc8 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -2130,6 +2130,9 @@ static int create_big_sync(struct hci_dev *hdev, void *data)
>   	u32 flags = 0;
>   	int err;
>   
> +	if (!hci_conn_valid(hdev, conn))
> +		return -ECANCELED;
> +

I wonder if a debug message about the stale connection would be useful.

gemini/gemini-3.1-pro-preview comments [1]:

> Could this introduce a time-of-check to time-of-use race condition?
> Because create_big_sync() executes asynchronously in the cmd_sync_work
> workqueue without holding hci_dev_lock(), hci_conn_valid() only protects
> the lookup for the duration of its internal rcu_read_lock().
> If a concurrent thread acquires hci_dev_lock() and calls hci_conn_del()
> immediately after hci_conn_valid() returns true:
> cpu 1
> create_big_sync()
>     if (!hci_conn_valid(hdev, conn))
>         return -ECANCELED;
> cpu 2
> hci_dev_lock(hdev);
> hci_conn_del(conn);
> hci_dev_unlock(hdev);
> cpu 1
>     if (qos->bcast.out.phys == BIT(1))
> Will this lead to a use-after-free on the conn pointer since qos resolves
> to &conn->iso_qos?
> Additionally, since conn is passed to the workqueue without holding a
> reference via hci_conn_get(), could this be susceptible to a pointer reuse
> problem?
> If the original connection is freed and the memory is reallocated for a
> new, unrelated connection before the work runs, hci_conn_valid() might
> incorrectly return true. This could cause the new connection to be wrongly
> operated on or deleted later in create_big_complete().
> Does the caller queueing the work need to take a proper reference with
> hci_conn_get() and release it in the completion callback instead?
> [ ... ]



>   	if (qos->bcast.out.phys == BIT(1))
>   		flags |= MGMT_ADV_FLAG_SEC_2M;
>   
> @@ -2204,11 +2207,22 @@ static void create_big_complete(struct hci_dev *hdev, void *data, int err)
>   
>   	bt_dev_dbg(hdev, "conn %p", conn);
>   
> +	if (err == -ECANCELED)
> +		return;

Should the error message still be printed in this case?

     bt_dev_err(hdev, "Unable to create BIG: ECANCELED");

> +
> +	hci_dev_lock(hdev);
> +
> +	if (!hci_conn_valid(hdev, conn))
> +		goto done;
> +
>   	if (err) {
>   		bt_dev_err(hdev, "Unable to create BIG: %d", err);
>   		hci_connect_cfm(conn, err);
>   		hci_conn_del(conn);
>   	}
> +
> +done:
> +	hci_dev_unlock(hdev);
>   }
>   
>   struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __u8 sid,


Kind regards,

Paul


[1]: 
https://sashiko.dev/#/patchset/20260410173451.4797-1-devnexen%40gmail.com

