Return-Path: <stable+bounces-237088-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NZaO40k3WkzaQkAu9opvQ
	(envelope-from <stable+bounces-237088-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:14:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5503F3F10D3
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAC3430B4B53
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E36314A86;
	Mon, 13 Apr 2026 16:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8Bra74B";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="j4xancHj"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0CD30C371
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098554; cv=none; b=b3KwqU8gdyQG7wYCd4BCOvVtRgauqibcKtOLbQO0XC1a8Mn11dwr3H6Veq3sW1kLMBhhcl+2WqxNZt4RyFmKkEPDNZ0FBvyRjBUQLDxd5p6CVJECSjNBAVCr/uYtIS5DQuD56lXx/J+mSeS1uyACONKRKz7W50WjIjLht77wiLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098554; c=relaxed/simple;
	bh=5W6Zy1XK1TAXTv6rQnCiO3JaK6tOysBBxFy1WxXFYSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYHWCO6mA/0D4UpVWQu8p5GQXURDj3xK7PZj6No5rMJUqoCEsPuzPgtEz9V5lznzObPyLfIuosjSZ2QS9sOqOUqsfSjlCuQKmkMLlwXD6tYvmXMHMt/RRk28MVyAIuBBXZVTaBO+WTOVEZqCvzVSHouEHnGIq9zORO/boSAeT5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g8Bra74B; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=j4xancHj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776098552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WO6WRptWW4sGTxFeojTyUtfweOrswI8hobePqSBWs7Y=;
	b=g8Bra74BSZKaYaEBT9WRCsdjuKi/S5PMfi80Y3b6v9T2eoBTDnKW5/uPl91RZBtyxM2ICe
	2QsZGy38OfLzua9qE65oCQLhu18vrKA7sJWwZ+x9d6FG8kIjPLsH7+4DUlsi236VH24TDr
	RhbH9dMImApZ4a4pStk8+mgrsvt/LBg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-3x4CMDqFO7Ko1TioHycG-w-1; Mon, 13 Apr 2026 12:42:30 -0400
X-MC-Unique: 3x4CMDqFO7Ko1TioHycG-w-1
X-Mimecast-MFC-AGG-ID: 3x4CMDqFO7Ko1TioHycG-w_1776098550
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8d3bb33c8b8so953439485a.0
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 09:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776098550; x=1776703350; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WO6WRptWW4sGTxFeojTyUtfweOrswI8hobePqSBWs7Y=;
        b=j4xancHjo6YvJ/fYARrIgKH9X2E3fVNA9IJsh2RSvV2deRkqRmWtRP3uMqF8OhBqCo
         uAKSojtnfetM1MfR1wYN6jlwhaZ/kqNqLH9JQ3+pwEEI3aUdDtJkxjQ7hwpEg19LDcqv
         b7Bt3Aih0NYO5zismZIPpftn/atMxwcqZljkvt7kGUqzh7Erx9pOBjz/qkseH3ncX6oP
         XkBp3dX0eeK6mmF6+GkYt7F8ps7cTKNyyuxAuoWuCU6XhTi+1E2q5KtM+DQVzk1FBlDP
         SP7BEZLJi9G0qesCG9Akfkuj/DMMNV/rWdrxSmqd/KeAD7SrV283XftqFt6gU4PdepVC
         PJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776098550; x=1776703350;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WO6WRptWW4sGTxFeojTyUtfweOrswI8hobePqSBWs7Y=;
        b=qfSPc+FSxdbqs9MWkz6CynBzy7KPrw13DfRGGwkGN6VTQB0ntz9g51S0YMblS2NMBP
         lB9Qh16HNWaUj4sW0tuCfOZ0xOhGqJcdYwpZ8hs3QKi/yOG04wV+PX/7A4r/WtU0U9i8
         +UXfF3hDzX1XErvtGnK7Ww6M4i6MrrNwgUbe1vaPRmZSy+dMBkAMEjz5T13BtmwtU5xW
         I1YzDfsR2UA+sgQ5whG5uhJ4v8mXHtmFX1MsGtvnvxo5rNdvyUXWisvh8m/a7u56GYBT
         Le6moHBeLdSWTKw+wINFdqxYPtGKkU1I7cJca0emPBpnuz1yHNs8eZ6oDDoh6hu3x1cQ
         sszQ==
X-Forwarded-Encrypted: i=1; AFNElJ8NwCb2d6ILr0hotVqhDz7vyBK6ln07SWr0CRxEwL8iEMfkrvmKlXSVKPdl06VfXp2Z6heQUmE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7w0MHTnP3JdpZ+Foz4CVv7O+9D8QEq9KVv4AYnCQsgzSiGYh1
	BXeu1hC6bG95nWagfwo/DuiUzTlgeApDub5FjKxP3/TAOhWbz3KF1tVTexh0BuLeSrVBiI5oMIk
	7exhRi15KU/yZNNeXYwsNv9mqRxWixJZ2k3XjvzOrusoy7QeDIW0wUSBnCg==
X-Gm-Gg: AeBDietDbWP0F1kNsFzwiEM5kaCRKVTPmszOePR5qpz/vQTTlucS/UyXo/y8+ChcyIj
	pbQhJmjhMVKRA+hvEs2Z72kf0guBUZARBRB4hYCe62/Zw3q1ng6mjajOmoLZIixTAGsA4zoZJmA
	W/pjILbLv9sa08UKBl60XowqNpMdQxKGHbVmf/ytjcu8Fzi6eFi0Y4NvpPwaT7Cq/heV2+CZ8+J
	ylxUxeDEAlcURUPqA/sHrlAIw15GEZc4YCN67W1U/zblBaCXfmMBF6vPcJjKSABMPfFmy5kVpjE
	hNG/v55JS/BqS94q+xqDcKlTp/k2xmhagyEY+zrYvZ/QRlwQrjzCk9dMm0hOpAYFAYkIVhT4pOk
	snzDGuhV/Aqp3veZ8731wWLT9IdZft+ZLUyDoi9TITtC/hp59xheZNs/2
X-Received: by 2002:a05:620a:4055:b0:8da:384b:9545 with SMTP id af79cd13be357-8ddccb2f661mr1997594785a.12.1776098550182;
        Mon, 13 Apr 2026 09:42:30 -0700 (PDT)
X-Received: by 2002:a05:620a:4055:b0:8da:384b:9545 with SMTP id af79cd13be357-8ddccb2f661mr1997589685a.12.1776098549609;
        Mon, 13 Apr 2026 09:42:29 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb9833c6asm908617885a.42.2026.04.13.09.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 09:42:28 -0700 (PDT)
Date: Mon, 13 Apr 2026 12:42:27 -0400
From: Brian Masney <bmasney@redhat.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-mips@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] clk: eyeq: fix memory leak in eqc_auxdev_create()
 error path
Message-ID: <ad0c8y1u5zAhheJX@redhat.com>
References: <20260412124247.2494971-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260412124247.2494971-1-lgs201920130244@gmail.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-237088-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bmasney@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5503F3F10D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Guangshuo,

On Sun, Apr 12, 2026 at 08:42:46PM +0800, Guangshuo Li wrote:
> eqc_auxdev_create() allocates an auxiliary_device with kzalloc() before
> calling auxiliary_device_init().
> 
> When auxiliary_device_init() returns an error, the function exits
> without freeing adev. Since the release callback is only expected to
> handle cleanup after successful initialization, adev should be freed
> explicitly in this path.
> 
> Add the missing kfree(adev) before returning from the
> auxiliary_device_init() error path.
> 
> Fixes: 25d904946a0b ("clk: eyeq: add driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/clk/clk-eyeq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-eyeq.c b/drivers/clk/clk-eyeq.c
> index ea1c3d78e7cd..a48ecec4c9a5 100644
> --- a/drivers/clk/clk-eyeq.c
> +++ b/drivers/clk/clk-eyeq.c
> @@ -346,8 +346,10 @@ static int eqc_auxdev_create(struct device *dev, void __iomem *base,
>  	adev->id = id;
>  
>  	ret = auxiliary_device_init(adev);
> -	if (ret)
> +	if (ret) {
> +		kfree(adev);
>  		return ret;
> +	}
>  
>  	ret = auxiliary_device_add(adev);
>  	if (ret)

There is a leak in the error path here as well. I think this code
should be converted to devm_kzalloc().

There is no devm_kzalloc_obj() yet, however according to [1] that should
be coming soon.

[1] https://lore.kernel.org/lkml/20260330154108.GA3389518@killaraus.ideasonboard.com/

Brian


