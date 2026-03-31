Return-Path: <stable+bounces-231334-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNynOL9py2ktHgYAu9opvQ
	(envelope-from <stable+bounces-231334-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 08:29:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8011D3647D0
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 08:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB7E6301A791
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 06:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0147D3A9D83;
	Tue, 31 Mar 2026 06:29:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158D4149C7B;
	Tue, 31 Mar 2026 06:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774938556; cv=none; b=DD8u9t6jZaopzcPncxK86unxXzadi/0wJ+/WHGGwVUNTylypAwGfpZsuT6yv4CaANh1uQ1nMtLEbeHSzVnv7qeGPqgH7yqfKzoFLzaKxkNYsXQHzLieUMrPNrlomlQVUY6Tg5UFU9Bj23jtNt5Io/WwZHEyZcNOYogEf0PvXEhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774938556; c=relaxed/simple;
	bh=9wwk+vofmTz8mNDwsydXfg0d6M/0TEv8DDsMbBg9Yg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aauAYWPGzDrHPbF56LHQQNOhNFbbfB+czO1shbVUEatchTuhOzLcVtGVGwmFn5/TFquaQyFd/bck9BK4WjT6CX2u7j+9eodRoeGfySoh8fK5QgP9RU9F1OEkcHSQDoYpHC5RrvZYKd0yKGOXH5VBHfbkGrUoabEA6l1q7IXNGzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.229] (p5b13a713.dip0.t-ipconnect.de [91.19.167.19])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4F2094C4430F7B;
	Tue, 31 Mar 2026 08:20:27 +0200 (CEST)
Message-ID: <a3099d4c-221a-413e-9112-7deb1d77e6f9@molgen.mpg.de>
Date: Tue, 31 Mar 2026 08:20:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_sync: fix stack buffer overflow in
 hci_le_big_create_sync
To: hkbinbinbin@gmail.com
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260331053916.1856760-1-hkbinbinbin@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260331053916.1856760-1-hkbinbinbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231334-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,vger.kernel.org];
	DMARC_NA(0.00)[mpg.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.883];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mpg.de:email,user.name:url,molgen.mpg.de:mid]
X-Rspamd-Queue-Id: 8011D3647D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear hkbinbin,


Thank you for your patch. It’d be great if you spelt your name with 
capital letters and spaces (`git config --global user.name "…"`).

Am 31.03.26 um 07:39 schrieb hkbinbin:
> hci_le_big_create_sync() uses DEFINE_FLEX to allocate a
> struct hci_cp_le_big_create_sync on the stack with room for 0x11 (17)
> BIS entries.  However, conn->num_bis can hold up to HCI_MAX_ISO_BIS (31)
> entries — validated against ISO_MAX_NUM_BIS (0x1f) in the caller
> hci_conn_big_create_sync().  When conn->num_bis is between 18 and 31,
> the memcpy that copies conn->bis into cp->bis writes up to 14 bytes
> past the stack buffer, corrupting adjacent stack memory.
> 
> This is trivially reproducible: binding an ISO socket with
> bc_num_bis = ISO_MAX_NUM_BIS (31) and calling listen() will

If this is not more than twenty lines, maybe share the program/script?

> eventually trigger hci_le_big_create_sync() from the HCI command
> sync worker, causing a KASAN-detectable stack-out-of-bounds write:
> 
>    BUG: KASAN: stack-out-of-bounds in hci_le_big_create_sync+0x256/0x3b0
>    Write of size 31 at addr ffffc90000487b48 by task kworker/u9:0/71
> 
> Fix this by changing the DEFINE_FLEX count from the incorrect 0x11 to
> HCI_MAX_ISO_BIS, which matches the maximum number of BIS entries that
> conn->bis can actually carry.
> 
> Fixes: 42ecf1947135 ("Bluetooth: ISO: Do not emit LE BIG Create Sync if previous is pending")

Just for the record, that the commit is present since Linux v6.13-rc1.

> Cc: stable@vger.kernel.org
> Signed-off-by: hkbinbin <hkbinbinbin@gmail.com>
> ---
>   net/bluetooth/hci_sync.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 45d16639874a..b84587061ae0 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -7222,7 +7222,8 @@ static void create_big_complete(struct hci_dev *hdev, void *data, int err)
>   
>   static int hci_le_big_create_sync(struct hci_dev *hdev, void *data)
>   {
> -	DEFINE_FLEX(struct hci_cp_le_big_create_sync, cp, bis, num_bis, 0x11);
> +	DEFINE_FLEX(struct hci_cp_le_big_create_sync, cp, bis, num_bis,
> +		    HCI_MAX_ISO_BIS);
>   	struct hci_conn *conn = data;
>   	struct bt_iso_qos *qos = &conn->iso_qos;
>   	int err;

The diff looks good. Great find.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

