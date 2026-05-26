Return-Path: <stable+bounces-254248-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCU3LnVBFWrJTwcAu9opvQ
	(envelope-from <stable+bounces-254248-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 08:45:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 159F35D1478
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 08:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5ADB83031EA2
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 06:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927693B47F7;
	Tue, 26 May 2026 06:44:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A65305666;
	Tue, 26 May 2026 06:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779777849; cv=none; b=Ms5PADJmq+E1ul4qWrq7v/EUdKT/u1Dk6sBoAOQ09Bci/Wt6ty1ndBVFTvImlB7Wv69qhfe5ffsDNsMT8dNs+u7K//NBsQycc3kFBdgseZwH7YAVvlNsH1PEGpmuHX4m8YAxKUATrPwkiNvZb0KQf5b62TiWpSi08w/p7d1Mm6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779777849; c=relaxed/simple;
	bh=rBUiRkHvmfyHZgQi0XsWud6ohs3cF03I+I5hA5KSywc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IzKEBgmPe/+OAO0S7kOGKxIEG2muaCzm+DqZgEZ4NceSezfNOr+d/DKqmCQrR/sk4Rq+HOciSa4QsTUAgXGHacPRzfsn6sd1fvDz+Uarh+/unSyUvICp9M8oASj+TwP2X4Dk6yfUBhWxFbk/YnobHcWqjIkkrTqBUQUlBnGOoEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.44.33] (unknown [185.238.219.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4BAF24C1511A98;
	Tue, 26 May 2026 08:43:39 +0200 (CEST)
Message-ID: <51761fe5-2244-457b-bf60-060e43f0cbd1@molgen.mpg.de>
Date: Tue, 26 May 2026 08:43:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] Bluetooth: L2CAP: fix heap over-read in
 l2cap_get_conf_opt
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, gregkh@linuxfoundation.org, johan.hedberg@intel.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260526021747.31634-1-meatuni001@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260526021747.31634-1-meatuni001@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254248-lists,stable=lfdr.de];
	DMARC_NA(0.00)[mpg.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,holtmann.org,gmail.com,linuxfoundation.org,intel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.902];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mpg.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 159F35D1478
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear Muhammad,


Thank you for your patch.

Am 26.05.26 um 04:17 schrieb Muhammad Bilal:
> l2cap_get_conf_opt() reads opt->val via a switch on opt->len (1, 2,
> or 4 bytes).  opt->len is a remote-controlled u8.  All three callers
> loop on (len >= L2CAP_CONF_OPT_SIZE), so the loop body executes with
> as few as 2 bytes remaining.  A packet ending with opt->len=4 and
> only 2 bytes left causes get_unaligned_le32(opt->val) to read 4 bytes
> past the buffer before the caller can act on the return value.
> 
> Commit 7c9cbd0b5e38 ("Bluetooth: Verify that l2cap_get_conf_opt
> provides large enough buffer") added a post-call len < 0 guard in
> each caller, but the over-read fires inside l2cap_get_conf_opt()
> before that guard is reached.
> 
> Add a buflen parameter and validate L2CAP_CONF_OPT_SIZE + opt->len
> <= buflen before any access to opt->val.  Return -EINVAL on
> violation.  Update all three callers to capture the return value and
> break on negative.  With the bounds check ensuring the option fits
> within the remaining buffer, the post-call len < 0 check is no
> longer needed and is removed.

By any chance, do you have a reproducer?

> Fixes: 7c9cbd0b5e38 ("Bluetooth: Verify that l2cap_get_conf_opt provides large enough buffer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
>   net/bluetooth/l2cap_core.c | 31 ++++++++++++++++++++++++-------
>   1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index fdccd62ccca8..6052ffb280ac 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -3051,12 +3051,23 @@ static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn, u8 code,
>   }
>   
>   static inline int l2cap_get_conf_opt(void **ptr, int *type, int *olen,
> -				     unsigned long *val)
> +				     unsigned long *val, size_t buflen)
>   {
>   	struct l2cap_conf_opt *opt = *ptr;
>   	int len;
>   
> +	/* Guard opt->len dereference: reject if the 2-byte option header
> +	 * itself does not fit in the remaining buffer.
> +	 */
> +	if (buflen < L2CAP_CONF_OPT_SIZE)
> +		return -EINVAL;

I always wonder, if Linux should log a debug message or even warning.

> +
>   	len = L2CAP_CONF_OPT_SIZE + opt->len;
> +
> +	/* Reject options whose payload extends past the remaining buffer. */
> +	if ((size_t)len > buflen)
> +		return -EINVAL;

Ditto.

> +
>   	*ptr += len;
>   
>   	*type = opt->type;
> @@ -3437,9 +3448,11 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
>   	BT_DBG("chan %p", chan);
>   
>   	while (len >= L2CAP_CONF_OPT_SIZE) {
> -		len -= l2cap_get_conf_opt(&req, &type, &olen, &val);
> -		if (len < 0)
> +		int optlen = l2cap_get_conf_opt(&req, &type, &olen, &val, len);
> +
> +		if (optlen < 0)
>   			break;
> +		len -= optlen;
>   
>   		hint  = type & L2CAP_CONF_HINT;
>   		type &= L2CAP_CONF_MASK;
> @@ -3675,9 +3688,11 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
>   	BT_DBG("chan %p, rsp %p, len %d, req %p", chan, rsp, len, data);
>   
>   	while (len >= L2CAP_CONF_OPT_SIZE) {
> -		len -= l2cap_get_conf_opt(&rsp, &type, &olen, &val);
> -		if (len < 0)
> +		int optlen = l2cap_get_conf_opt(&rsp, &type, &olen, &val, len);
> +
> +		if (optlen < 0)
>   			break;
> +		len -= optlen;
>   
>   		switch (type) {
>   		case L2CAP_CONF_MTU:
> @@ -3946,9 +3961,11 @@ static void l2cap_conf_rfc_get(struct l2cap_chan *chan, void *rsp, int len)
>   		return;
>   
>   	while (len >= L2CAP_CONF_OPT_SIZE) {
> -		len -= l2cap_get_conf_opt(&rsp, &type, &olen, &val);
> -		if (len < 0)
> +		int optlen = l2cap_get_conf_opt(&rsp, &type, &olen, &val, len);
> +
> +		if (optlen < 0)
>   			break;
> +		len -= optlen;
>   
>   		switch (type) {
>   		case L2CAP_CONF_RFC:

The diff looks good.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

