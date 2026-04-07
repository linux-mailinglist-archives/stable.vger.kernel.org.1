Return-Path: <stable+bounces-233670-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aG7DAWYl1WnK1AcAu9opvQ
	(envelope-from <stable+bounces-233670-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 17:40:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F74C3B129A
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 17:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F9F1302E911
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 15:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA2A3BD24A;
	Tue,  7 Apr 2026 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wuzy4eyn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sLWfVGyh"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC753A5433
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775576052; cv=none; b=rLo69Sy7B6vqvUmwq6UcBtiauYMxwBjcZYAvXSC78No1Vh3hkSEH0sDz6B831yijfDnLxeJr9XW7KsUomqiwKKz3eQdIkxUGTuRxuiWNmusAuYIRMWlYANhuwBDlUqv7zwXFtoAxdKrF/VDg2W1YHEcX3Qi3lGX78ZOgdqlNCNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775576052; c=relaxed/simple;
	bh=emtTneTFVkE4pjmv/p658dZ+xTb6Jw/XAktCB655R80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hpanVYyawDTYf0hKDJEs5MIcw+JKj01r2bNdaHS38IVjq0uoi8i4UhaTguGCdp1Zh+JcvQcgS3WKtTb+B1MK1tPGHv++MkGwdv+7h1L/F9p/55ZrDWbfyWgtI3PmtUc9KYpG91qfD1KR0dgZFw+diBAFu0j/aOgpFM5aeA4qD0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wuzy4eyn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sLWfVGyh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775576041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=18QRVkQOlgUM0SqdTeH58o5Qj8GUKsltIAUn2fzUV8o=;
	b=Wuzy4eyntdRLr9IMdQi3ZBoCADEBdHqe+mgqPrlbh4Bw3oJPs/RUvLlfZUZgShDvMmQra1
	hJ0WnJGhaUnK63cOITg9EhyLB5kTVJ94Ko+zElX9e7zIUTdgvQj032ftItS0uvQotiVOUC
	K7v2NfDbYt4NbplkbD2qzsiO+GIX9L8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-DXAB2C5hMGeuO-XNa3FqFg-1; Tue, 07 Apr 2026 11:33:59 -0400
X-MC-Unique: DXAB2C5hMGeuO-XNa3FqFg-1
X-Mimecast-MFC-AGG-ID: DXAB2C5hMGeuO-XNa3FqFg_1775576039
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488c0120047so5809015e9.0
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 08:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775576039; x=1776180839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=18QRVkQOlgUM0SqdTeH58o5Qj8GUKsltIAUn2fzUV8o=;
        b=sLWfVGyh/ddQw7rA9o2IJ2poUvnvfac5WpwUNBbmWZIfiCPJlG7w4tkm02Qx8qhFwt
         T+D7KJLAqNnbEwlE7skZD3LdWJ7fka1J5B22TQs9D31PTRTFpT4I+icSAe8YMqqAB/22
         HAAUjdlwaNhu1WXIXtEF9Ogn4hpwX8jLF6xFdPZRL6Xzbr+hidx9rZTcV1LPWSDFeOvF
         0qdESVPysLA4uQLwJVUNIX/5LOohA+FYQu/87UFbV4VTRNKGvBjE1xZSTK1JvY+l7ipo
         lxPLGN2nDExORki2eZhk13vcWNRyb61ga9HFc12i9F4NG0d7FB+rub/RYz0jTdc/K3im
         knJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775576039; x=1776180839;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=18QRVkQOlgUM0SqdTeH58o5Qj8GUKsltIAUn2fzUV8o=;
        b=pbiKluIhcCAh89uyDPrDy6GV4SaDkrmz09D6g+dZZgdT8meU5Ij5hW/WPC31DVrk8X
         /4bzCb8uBkKwg3i6YQVo6DN4V85aaBQyWbOn16+flkkU22VamuGD6WcwAUK/atHZ8NVR
         7VN75KwFmqIirAos3R80snr6aXwmSo/KFwFj44m6N+r7Cb1G1gy7Mnxj8WViSzppK+fL
         gGmbqeAiH5RInWfDfSgc/lyQWB8hths3oeZjI6bGdCS2Ovu2fI/WmZURXeMsJe7TdgLn
         FcQXwQAm7f+kAXCRQWlvSjWc9jCtZi/OdEETEkHbybcuEbMYvTDcGs6xUtYvU3oKqtPq
         UiNQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8ook2Sd43fAltfJZqgPw1ly8jzmhjF1i3tDjmc69Jfm20udIGsf0UuVw9RcplQ+YGHYIwCME=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHNIdqjfrHQoOgawgmDXloQnz43ZN17HIPNXCNq3smoNCmGxJH
	acyUF0ZLVu2NOkq1h9c745ymJeCzzAgCboAQbj8KpGVquWaOxdtA4QZtQ9UJZ1kZPwALN2HTWow
	cJI3tON3h4PmgnE6Pqnxx+kg8RsZ8LHaESSFeD4iozv4pG+B+/kzaFTVb0A==
X-Gm-Gg: AeBDietj4HqIB4EreCp7zqW9u1MQHLHnPW9AK0EpjDYxhbJBzg3hceWLNS4IuG7aRIy
	iG5w9jWo9Uo/3UGJInTGsnCb7mM+Yl69tNG4N893yCD+JaN/7fBNiEH51vOgKU9lzKIcxIINgFO
	zAr9Gc0HKuWuoc/DVB6fkAKHpVHyHKRsPRWrf6M3DKaKFgcAgYMsnEMqGP+AH18XqlpDLHZswrN
	FOf80h+f7Hp5cNVn7cLcgxbB9xFBDTlETAI7yad56HqJKNjLc01s8YY0q2hCbZ+flddrzBClhBl
	OadJ/77X3kwnDwGTNPgXERbc7QpkaiPlk53cps1G1Fb6BNYx+Gm9fjRqtV+3M02/RVUW8Lx5e90
	GRR7c7AW/zfW2ce7Y7yx1AgNmjz73sR73XKkpPrJpYavX9cKgGIoIM3VvIg==
X-Received: by 2002:a05:600c:5292:b0:485:ae14:8191 with SMTP id 5b1f17b1804b1-488996d2309mr260481545e9.5.1775576038138;
        Tue, 07 Apr 2026 08:33:58 -0700 (PDT)
X-Received: by 2002:a05:600c:5292:b0:485:ae14:8191 with SMTP id 5b1f17b1804b1-488996d2309mr260480235e9.5.1775576037144;
        Tue, 07 Apr 2026 08:33:57 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e83682fsm588473115e9.7.2026.04.07.08.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 08:33:56 -0700 (PDT)
Message-ID: <0ab00cb4-8335-472d-b43e-3bbd99b41480@redhat.com>
Date: Tue, 7 Apr 2026 17:33:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] net: qrtr: ns: Fix use-after-free in driver
 remove()
To: manivannan.sadhasivam@oss.qualcomm.com,
 Manivannan Sadhasivam <mani@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260403-qrtr-fix-v2-0-f88a14859c63@oss.qualcomm.com>
 <20260403-qrtr-fix-v2-5-f88a14859c63@oss.qualcomm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260403-qrtr-fix-v2-5-f88a14859c63@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233670-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,sashiko.dev:url]
X-Rspamd-Queue-Id: 9F74C3B129A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/3/26 6:06 PM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> In the remove callback, if a packet arrives after destroy_workqueue() is
> called, but before sock_release(), the qrtr_ns_data_ready() callback will
> try to queue the work, causing use-after-free issue.
> 
> Fix this issue by saving the default 'sk_data_ready' callback during
> qrtr_ns_init() and use it to replace the qrtr_ns_data_ready() callback at
> the start of remove(). This ensures that even if a packet arrives after
> destroy_workqueue(), the work struct will not be dereferenced.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0c2204a4ad71 ("net: qrtr: Migrate nameservice to kernel from userspace")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  net/qrtr/ns.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
> index dfb5dad9473c..c62d79e03d64 100644
> --- a/net/qrtr/ns.c
> +++ b/net/qrtr/ns.c
> @@ -25,6 +25,7 @@ static struct {
>  	u32 lookup_count;
>  	struct workqueue_struct *workqueue;
>  	struct work_struct work;
> +	void (*saved_data_ready)(struct sock *sk);
>  	int local_node;
>  } qrtr_ns;
>  
> @@ -754,6 +755,7 @@ int qrtr_ns_init(void)
>  		goto err_sock;
>  	}
>  
> +	qrtr_ns.saved_data_ready = qrtr_ns.sock->sk->sk_data_ready;
>  	qrtr_ns.sock->sk->sk_data_ready = qrtr_ns_data_ready;
>  
>  	sq.sq_port = QRTR_PORT_CTRL;
> @@ -803,6 +805,10 @@ EXPORT_SYMBOL_GPL(qrtr_ns_init);
>  
>  void qrtr_ns_remove(void)
>  {
> +	write_lock_bh(&qrtr_ns.sock->sk->sk_callback_lock);
> +	qrtr_ns.sock->sk->sk_data_ready = qrtr_ns.saved_data_ready;
> +	write_unlock_bh(&qrtr_ns.sock->sk->sk_callback_lock);

Sashiko says:

---
Does this lock adequately protect against concurrent callback execution?
In the network receive path, __sock_queue_rcv_skb() typically evaluates
!sock_flag(sk, SOCK_DEAD) and invokes sk->sk_data_ready() locklessly,
without acquiring sk_callback_lock or being in an RCU read-side
critical section.
If a thread processing a packet fetches the qrtr_ns_data_ready pointer
and is preempted, could it resume and execute the callback after
qrtr_ns_remove() has already finished destroying the workqueue?
---

There are more remarks from sashiko:

https://sashiko.dev/#/patchset/20260403-qrtr-fix-v2-0-f88a14859c63%40oss.qualcomm.com

AFAICS they are pre-existing issues or false positive, but please have a
look.

/P


