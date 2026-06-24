Return-Path: <stable+bounces-268113-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JDc4EomfO2r6aQgAu9opvQ
	(envelope-from <stable+bounces-268113-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 11:12:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 826E96BCD74
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 11:12:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268113-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268113-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E37CD305128E
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 09:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E27A3932FF;
	Wed, 24 Jun 2026 09:11:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FFD38AC97;
	Wed, 24 Jun 2026 09:11:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782292298; cv=none; b=V92u8zgn/ySXn65ZudYVPBMqzB1EqzUdj4whmPw5pFX0mrMWOWG6724zSeVxwvYgMNS0Ed//Aq58MeTvBpjtDFd8BK5hDPOmoYalMZf6XC4J0ik3gd0wFsWRoqVDgDUaLjfPg8GBi1ikVaqAidyWype66Z0DKBPPfxV9m5MkQTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782292298; c=relaxed/simple;
	bh=NdWdRApmhIbFcAmPofw1o8VOKKuGaESUNKaob1fWo8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nphusqNic4qBpjexPdhdjFNjaK6MhyTVn9rCdRfLvrKZG7fb/Yc+Coo5YGS+rjWIPRr0tAm3YVXsJtXV+B1zTeiul9KRVl/5wWySKHk29igVGUY64bc0d9lZdU03QYkNrUwVl5TxqyXtIeTm4+krs65AEVASu5Vzd6P+5OAekG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id A6B154C1AD77A9;
	Wed, 24 Jun 2026 11:10:59 +0200 (CEST)
Message-ID: <17c94df1-3659-4d21-b327-ad52d498ba9c@molgen.mpg.de>
Date: Wed, 24 Jun 2026 11:10:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: virtio_bt: unregister HCI device on open
 failure
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, yangyingliang@huawei.com,
 mst@redhat.com, error27@gmail.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260624084333.2885144-1-haoxiang_li2024@163.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260624084333.2885144-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[mpg.de];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-268113-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:haoxiang_li2024@163.com,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:yangyingliang@huawei.com,m:mst@redhat.com,m:error27@gmail.com,m:linux-bluetooth@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[pmenzel@molgen.mpg.de,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[163.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,huawei.com,redhat.com,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mpg.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 826E96BCD74

Dear Haoxiang,


Thank you for your patch.

Am 24.06.26 um 10:43 schrieb Haoxiang Li:
> virtbt_probe() registers the HCI device before calling
> virtbt_open_vdev(). If opening the virtio Bluetooth
> device fails, the error path frees the HCI device without
> unregistering it.

Should you resend, please re-flow for 72/75 characters, so only three 
lines are used.

> Fixes: dc65b4b0f90a ("Bluetooth: virtio_bt: fix device removal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>   drivers/bluetooth/virtio_bt.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
> index 140ab55c9fc5..bf6827431bb8 100644
> --- a/drivers/bluetooth/virtio_bt.c
> +++ b/drivers/bluetooth/virtio_bt.c
> @@ -397,6 +397,7 @@ static int virtbt_probe(struct virtio_device *vdev)
>   	return 0;
>   
>   open_failed:
> +	hci_unregister_dev(hdev);
>   	hci_free_dev(hdev);
>   failed:
>   	vdev->config->del_vqs(vdev);

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul


PS: gemini/gemini-3.1-pro-preview found an unrelated issue to the patch 
during review of this patch [1].

> This is a pre-existing issue, but does this error path safely clean up the
> active virtqueues? 
> Earlier in virtbt_probe(), virtio_device_ready(vdev) marks the device as
> active. If virtbt_open_vdev() subsequently fails, the code jumps to the
> open_failed label and eventually reaches here to call del_vqs(vdev).
> Deleting virtqueues without calling virtio_reset_device(vdev) first violates
> the VirtIO API contract for active devices. It could allow the host or
> hypervisor to access guest memory that has already been freed by del_vqs(),
> potentially leading to a use-after-free.
> Should virtio_reset_device(vdev) be called before tearing down the
> virtqueues in this error path?

No idea, how to best track these things.


[1]: 
https://sashiko.dev/#/patchset/20260624084333.2885144-1-haoxiang_li2024%40163.com

