Return-Path: <stable+bounces-249134-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BvcLkT/CWqqvwQAu9opvQ
	(envelope-from <stable+bounces-249134-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 19:47:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F8F562C33
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 19:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 325A13004C51
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 17:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6EA3BADB3;
	Sun, 17 May 2026 17:47:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA982C1788;
	Sun, 17 May 2026 17:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779040063; cv=none; b=HvPeXpf9GcxEG32Ua/7Tga7DmczXJRRQd7mnKUIpEP7S+vrZcAxygkSUuxS9pwiw8FRV4WBwZ7kGH8wpVUYT5R/3DUR8PFmXtkgMn7xOMUC1+2Ze/t2fP7Fvhmi45SHwFU0FpF7fwowCzquv5EpIWT1snQsMb9mfhM+IROpFwAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779040063; c=relaxed/simple;
	bh=VofNwlQa8QMZRp9505LXFAm77ygLe0tyLY+2GwwnOsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MAa0eRFKVnmAGYMtxZ8Jxr0iCXMFxM8FwPF59caad11N+Y3E3hoSlAcCZTs6m46km2Qo7NRtCiBxTwLnpA2F9KlPxjl2psEMi7tZa0zbtHlbfwvFjiMcmVy7b/HXrhcdth+74+IR+nsovLE8b5CXvpq1n5MtKYCpOwb8Zc/qh48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.131.144] (sec5.rz2.abl-rz.com [88.198.244.220])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8C9C34C1A0B1B3;
	Sun, 17 May 2026 19:47:33 +0200 (CEST)
Message-ID: <3a7eaf6e-6e4e-42b1-a136-3ed2befa90e2@molgen.mpg.de>
Date: Sun, 17 May 2026 19:47:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: SMP: add missing skb len check in
 smp_cmd_keypress_notify
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@gmail.com,
 stable@vger.kernel.org
References: <20260517145417.31910-1-meatuni001@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260517145417.31910-1-meatuni001@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 13F8F562C33
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249134-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,holtmann.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[mpg.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Dear Muhammad,


Thank you for patch.

Am 17.05.26 um 16:54 schrieb Muhammad Bilal:
> smp_cmd_keypress_notify() accesses the received payload as
> struct smp_cmd_keypress_notify without verifying that skb->len
> contains enough data.
> 
> smp_sig_channel() removes the opcode byte before dispatching to
> command handlers, so a SMP_CMD_KEYPRESS_NOTIFY packet without a
> payload leaves skb->len equal to zero on entry to the handler,
> causing a 1-byte out-of-bounds read from the heap.
> 
> Add a length check before accessing the payload and return
> SMP_INVALID_PARAMS when the packet is too short, matching the
> pattern used by other SMP command handlers.
> 
> Fixes: 1408bb6efb04 ("Bluetooth: Add dummy handler for LE SC keypress notification")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
>   net/bluetooth/smp.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index 98f1da4f5..4c98e2a3a 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -2932,6 +2932,9 @@ static int smp_cmd_keypress_notify(struct l2cap_conn *conn,
>   {
>   	struct smp_cmd_keypress_notify *kp = (void *) skb->data;
>   
> +	if (skb->len < sizeof(*kp))
> +		return SMP_INVALID_PARAMS;
> +
>   	bt_dev_dbg(conn->hcon->hdev, "value 0x%02x", kp->value);

Add the check after the debug log, so it can be inspected?

>   
>   	return 0;


Kind regards,

Paul

