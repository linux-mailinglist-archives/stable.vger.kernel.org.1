Return-Path: <stable+bounces-222990-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFOWBr3Yp2kRkQAAu9opvQ
	(envelope-from <stable+bounces-222990-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:01:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 819271FB582
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 026F530241B6
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 07:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E70931D362;
	Wed,  4 Mar 2026 07:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EogdiAnS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mVclPWSF"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAA641C71
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 07:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772607670; cv=pass; b=Te220Sa1haVg0OBn0bZfUrH2FcGS3SA1+3Mb2tbBYl9bHGcJ+ckSdlFRG8GYNRpcNkrdYzCj+oms0/vgHD7v3PZ/uqH979ZpODfDXT7qQAgc+1qmyR2+l01UzBjwtAaH5EalwZtPhHwDZpl09HQgMMD9VyzBc1zSgIs/uYj6CqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772607670; c=relaxed/simple;
	bh=KWWIB7t7C3pJOd/0xpSdaV+2Zw0SpFMTOmm+zMTeHAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dkttKrfK8HmocbN2hICAkdcCaKaIzciAQkOlW8hlLiolmkK6Z4paP7CTVRSmjhMbH9YjvpAMsK5B4jnM4DaeV9VcbEYNEt0hUH6sNr4TCpCpuv+V0VCKwkIy9jTr6s7lAPk0Cc8P3oglE5jbgRYBNSL+GaQi6OiSC0PxsxsNj8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EogdiAnS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mVclPWSF; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772607668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FwBE4akms1F/Y859toP4EhYH9BAxcWIZ0TA5l5/GfsM=;
	b=EogdiAnSTWLNH7lxh5azeUoIlkl0ui73NNiDUT4+X0iBmhj1zvFZT2m1kfP0vMgWXsZBt1
	vXoTQ/Yf83J5UxhLcZOu2937XKkqM1CMLiGHhKyxFvvT2Jlf8XOw1BKGGK7RVYFkfXe/ws
	v2ohTlqtSKxnxCCa+kuyiUeYkSy2WJs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-5GzEU4tDOriCqStBFrh9jw-1; Wed, 04 Mar 2026 02:01:06 -0500
X-MC-Unique: 5GzEU4tDOriCqStBFrh9jw-1
X-Mimecast-MFC-AGG-ID: 5GzEU4tDOriCqStBFrh9jw_1772607666
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35449510446so6211314a91.0
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 23:01:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772607666; cv=none;
        d=google.com; s=arc-20240605;
        b=gI2aCRUG5rraJ3plR/C8XDRndhTVxW53VAVXq6LUstwIIXh6UhQu7Ar81zqlSqNc86
         7guoregPY46oJJ3xFXNm9lJn3Gq8y6s4ZMXamC51rCoV/qpHUdv8XEsoWcxsSxUiBYkm
         N9xxSMn0L95i3zPH4dfa+WKcoG5aEU6mttuqfasL5xGB9onZ2k6Wzq6AKSG6jxfdC633
         6MlMeL71t8NdGMvjR1K2i4mrVnggixjG8pyCCsT90x7zu1+UnRsoWbG47EySqLHJteqN
         +QGqTD3iN8KtCaXyc8LD5Rao4vU67iz8WspxC0FAmXAr81c+EJ8kHe8V1OjUI1+6hq0C
         A5hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FwBE4akms1F/Y859toP4EhYH9BAxcWIZ0TA5l5/GfsM=;
        fh=yD0T7wpRQz0cBCXDkTH0t098wxFsZqJAm378LepXBjI=;
        b=ISGgyouW+akSCkmcYIoXqgFu93PEwI22dtmubQbs5lL5DKXDIhieHdBKL12QdynznE
         yvtS5rR8UqtVyWHhPLWpKaBxMbm+Z7GvZi3FeRobKdsQOt67t6nGowlhbGQyhrXsEa0W
         i0BVnN/yVGnIi9zEoOeE68bONIjC7Zgy0rKQrW6iZdfHrm1zsFicTs6jiJdKf3IgZro5
         30kuL2/PW6BMLAvhWvQP0PwQoZj01IGWdf1XB2cgxaMwt8hoaDZrBiCw9XfnWdwNirgO
         S/cVBbv1ud8jUDnpL+DnBpkDOtu9QmoWzYUwbu1Rcm3jTFgBn2MTjxxx9+ZvO0Z3RXxw
         crHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772607666; x=1773212466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwBE4akms1F/Y859toP4EhYH9BAxcWIZ0TA5l5/GfsM=;
        b=mVclPWSF8jaZHDc1q3UvrAqjWGpqz8r5id0RpWH8GAXV2y1WS8CIL6YZKVURWQ8kfr
         zwLLuupcODzVdQak00F9FCow4Zl/g14cnEluOOZMb+YhhIxNPIoTThqFIf3HXmE4AHEW
         PCruwBbozFlal+J2ZuYlsd0QqR8/tLCiOBEw+tzORFCCbYW3hr3cbSHPsB5HQStlXy/k
         94Ap6FL5HRWhiLd/jMudiqePS9Jceq5W6vQBbuQGRH/A+g9fNh3LrmKx9uPYEJ87nomc
         q+EORiN40CVY8kufnzSoTQyd15xd0MbH+Nv3lQ5eJYLRFy2HszKw4nB4Tw6GrTOGU9sz
         TIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772607666; x=1773212466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FwBE4akms1F/Y859toP4EhYH9BAxcWIZ0TA5l5/GfsM=;
        b=Xbi74aNw5BA1dfJYyK5Mow+UeN76RxZ+k8y3rhzMwV1MtddBDCb81sx9SETLeSQzmZ
         woDZ6yz9i2MQ6Dq0F33/9OzbQRTzBNP3llZVxzPpLmGSck5Va1CwKoC4Jgs5osQEK2mY
         /7zYQErkqMb5rSckt4V3U5o0cLqeN3afEkDICmF6XdNN3CARZJrGuRNfyYzAfp7FdYpO
         aQmsclJR6ykw8KHKdUdes6ve98O+H7fItTRqz352nHeVo25fX0P+w3o3UBOf8bUsfwHo
         vo+242bKcq84qidgtzC+564MYpX8AYl7Sqs0ouVfecjomaBgPvgoZ/spyDMYtQID1y7S
         mO8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW36OCKM5o0DmjtfAgJMtntTo9lB4TmYRhZ5hWZxfpQF+jb/TsMubE1WDXvcrzOCOl8W11+s5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoj3Sx2J20gaklo7bYLK3Utj2wZsHNocPywcpj5xy7jX6s9Lhb
	fLb+wCOYGbJF2y2pjnxYvYwxv47I5cyVq6LFBtgX1RyBd6PcQj6qdLkkQn4iThUh6C8uN4LsKl/
	Qfen0aL6/j9VcmsntIqG6BHbO/Cvl7/CStS2gke/JWV7w06X5D7PoqdSEpY5mHB8w/z5Blgzkn+
	YehFc7751THP9tMVh6LiAysjHzWYB8oXj3
X-Gm-Gg: ATEYQzzsrPTY5xHzaimxhgQ8qQJMSZQh8qDmmazPTSSuJeQx4LbD4kcpSFSQoWmjG7i
	XAUhSHnD5G0FitsmQq1NC7vIdCSPGgcUKGBS/4c1g3ZDjnkGuPNVXLcBmU6awkPAOtr+5FupGnj
	EwJxGsbhHNgJRz4LvSV4X1oDMyKoESaJhVNtdchV7Dy4xD5BGY4zx3QthdilSZD6nSd5ksD7eem
	mhv2nU=
X-Received: by 2002:a17:90b:350e:b0:359:95c1:6b6 with SMTP id 98e67ed59e1d1-359a6a65fd1mr1207241a91.25.1772607665704;
        Tue, 03 Mar 2026 23:01:05 -0800 (PST)
X-Received: by 2002:a17:90b:350e:b0:359:95c1:6b6 with SMTP id
 98e67ed59e1d1-359a6a65fd1mr1207183a91.25.1772607664851; Tue, 03 Mar 2026
 23:01:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226115550.1814-1-zhangtianci.1997@bytedance.com> <20260226115550.1814-3-zhangtianci.1997@bytedance.com>
In-Reply-To: <20260226115550.1814-3-zhangtianci.1997@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Mar 2026 15:00:53 +0800
X-Gm-Features: AaiRm51O97aS5NJ96agoaKegTRxNIomgtn4-ZRlUTVYj1ctl5GYjn5O3tIxLPFQ
Message-ID: <CACGkMEtduDsnZjGhOYwdRpOBVxX=+2z4C4sJ47KwROF7NWNzcw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] vduse: Fix race in vduse_dev_msg_sync and vduse_dev_read_iter
To: Zhang Tianci <zhangtianci.1997@bytedance.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	marco.crivellari@suse.com, anders.roxell@linaro.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 819271FB582
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222990-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 7:56=E2=80=AFPM Zhang Tianci
<zhangtianci.1997@bytedance.com> wrote:
>
> There is one race case in vduse_dev_msg_sync and vduse_dev_read_iter:
>
> vduse_dev_read_iter():
>     lock(msg_lock);
>     dequeue_msg(send_list);
>     unlock(msg_lock);
> vduse_dev_msg_sync():
>     wait_timeout() finish
>     lock(msg_lock);
>     check msg->complete is false
>         list_del(msg);   <- double list_del() crash!
>
> To fix this case, we shall ensure vduse_msg is on send_list or recv_list
> outside the msg_lock critical section.
>
> Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
> Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


