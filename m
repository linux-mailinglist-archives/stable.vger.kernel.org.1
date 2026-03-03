Return-Path: <stable+bounces-222803-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IrCHv6DpmlQQwAAu9opvQ
	(envelope-from <stable+bounces-222803-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 07:47:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3DE1E9C57
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 07:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E6F23025E1B
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 06:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAB32E6116;
	Tue,  3 Mar 2026 06:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I4ggjYGn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bojNLc7k"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8021E1E12
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 06:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772520443; cv=pass; b=j6uBX5ZMhy35rEig+aGL+Uc9NgRnWn2/6k+h7/u+DBDQuGopGsIBlbBpAowChT31dLhY7QKxqAkS7VEOGUfkh5T3x50LNWqwVRCHYQMdOuG2nwRGuT5JdIoeU2cwJgZrkurUUEN+svrk8QoVL+Fm73JJ/RdGOZylqC7ZV5eIdHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772520443; c=relaxed/simple;
	bh=jTsk5S/1xtP/Z4v1QHmNXso1IIFMkqhMifKA1YMoKu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cFR22MHDwPTcUgfDOGNxveIY6ae4cwm6vq+Vy3PLsV6r5ivWen+w5yC3igDL0gUBeXYkrQ4ls7BubzU1IoIth3OPCDdJ/IEVU526V8+WHaIZ7fLquLImlllw3170bKdad2Bm7oq/WXB9SaZGKQFRV9I/0mPJlrZfnHRDgvwAWok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I4ggjYGn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bojNLc7k; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772520440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jTsk5S/1xtP/Z4v1QHmNXso1IIFMkqhMifKA1YMoKu8=;
	b=I4ggjYGnPK80gRLD4RutQxbQqfBgi7axjlkKw14NMjKxYBxVxwn282W3s/j6WuVUPRFPZK
	AWmEaVyZ+1+PQsuAg8YPS9yKzpEw/gl2cAINkH4DLWjGf6F/Y0L8eIfdjq6R4+kUPs5Z+S
	HhJix4Jei82iVmx9HnDS9LjZPVtSS48=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-oeNeBxM6Miq6cRL3IDtPfg-1; Tue, 03 Mar 2026 01:47:18 -0500
X-MC-Unique: oeNeBxM6Miq6cRL3IDtPfg-1
X-Mimecast-MFC-AGG-ID: oeNeBxM6Miq6cRL3IDtPfg_1772520438
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3598733bec0so12808462a91.2
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 22:47:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772520437; cv=none;
        d=google.com; s=arc-20240605;
        b=TKHLb4KKNDm8xhqs3Ml1wV4vCuG33u4Pl/nUcysswI/lCjrfW6gx7F4HxhKf7cRzxD
         sb5FwEZuFMN4hFbK/RBfoev2t01dR2keAYm84Nb2DvjBtWg457BH+DFK+0EVedLtbCxU
         x7X4or7B7Qcma4yMEOaWV8Gfly+gC6ebuyeIDWyd8pmjMJMcWt15tWH0ShdZ/B3EHX6+
         GW9EAjTE1k/5xr8C5KRCcNTabArp/WLnmsG4FVHEthgN6B9akGLx6dHgFz+laDqwmwsN
         wDnjJE4dukFGwihmkgycRmCUhWfl5v+jJNO+jn1tAx7FZSeKrIcqwwxW9IHz2nXgcXC0
         5ntg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jTsk5S/1xtP/Z4v1QHmNXso1IIFMkqhMifKA1YMoKu8=;
        fh=NK5rPjbakndrHAZcTTR/AKC+DgRjaMco0uI3JJrA4sA=;
        b=bjOojmiIv+WiPE1BYVNBJyYZWdtQthAf9M6hlP24ZoF0aW54tX2eY32BfGOCQr8JZy
         h/7YrLrTAe63xHHFIK70zM+ffWcFTF3cYG07Mz8u/kPFucZiSn/A6oyypLxSZEb8Nl+G
         Vidwlfx1GAo6f/0sF8wIy9rDiSh3bQdw7OjXqWPYOPTVju7x4aqfbB/uaQf77H8FNJL4
         fbUMikMS7dP4PrGCQ/6a0REpxXvB9hIIxEgdXKYvcDXp5JUiivyQvTsLejOVZXpv9wuY
         ncdTGUNd6Z5x4CmeFvPH3X8uqre6CPzHh3sziavi37V8s0nrXJ/OiMqLVVfmDBUkizE7
         lSbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772520437; x=1773125237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTsk5S/1xtP/Z4v1QHmNXso1IIFMkqhMifKA1YMoKu8=;
        b=bojNLc7kqR4urVi0VFxILE2hTwz4HIBqD4PFfNfICV88FErskS7Kgc50zSxNgZG1BX
         fGIeN3/v8IJrTjw5IdN4VkSoHEoVUEcHMLahKJ3h/r74WxGyBEmt7E4L2ZVhBb5KLeuz
         TddfBkQ09/PFygE8hplszSx17Mf713WyR/ShxlPWPWkXj2obGFA+BMXslcpYSVu9Q4je
         gr0u1kI/X19lPgP2jYVM8tvkcFQC7gAVUdcbt6Nde6LTodvF/5wBbzTtclQwOqmzswYc
         Pj/s2NM69Dhl1cfEIRNaYZ9VwLxAy37ENrYrEyTEaES1+/KG/C2bPNclauGu1dExGU/P
         3x6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772520437; x=1773125237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jTsk5S/1xtP/Z4v1QHmNXso1IIFMkqhMifKA1YMoKu8=;
        b=H5iqe8FYPEx9iTqFuTux36eC+1xd9lmPUt7OF6nWQ8nly490Db2IexO6bOIO9h6ta/
         NMXRrV8zPqMaO5dVEhqKRnh7SfCljEIFp9MfMneVM5VGx7ltg8ySeiD/ae2z5VxxGg1J
         bBEhFObB1v9OLPPljYFbwBG8uglpxeSD1hOvG5HNPstJUjqZTfI7Nt7sD0JiZJZxxJH1
         CgvoGEn/gBIOjFYQAfT9rtlg766uIV5Ood9kZ0Q/PWhfHC0O61FTUY2LWImow2n842n6
         Qm1YFdee+/6tdRici9tPgrPcR23SafGf3mUm5Vccmtw04pj5wWc2c5zsVmeDkEh6jhPj
         8JTQ==
X-Gm-Message-State: AOJu0YylQZyjDFzfY436tivzUV3CCC+ss+54HqOZ4xk0gfTdnSxbiGBE
	L/pOKJktwc7J5Xh8U7zUw2usvS9daXwXHigeMk1aS41JZLgC7eD0vGa5nxAhMvj+NNiC1ljEeAu
	MVNnWu38I95bGrPs6jAli02aGAM3AcUS6EnBCRjRn5UBjatxNzRXAve3RxrxzvWRw3Nf8b6FHrq
	OrdnNbZWtO114Bf7iEd5hisNQOoyXttqr5
X-Gm-Gg: ATEYQzwNnFvurJnY2V9wDC8KdI6faeFdLAd+ZcTazNBn9IWN6z5goHkocoGPWfqQQ8w
	sg+qr5fUFIWdxDIJtkNo56PsdOA/jP5qOI+J9dLvy68h9gfJjMfj9XRkBlOevtvWy0YppuwvGjt
	70M/bx/OQjRi1tvJA0Shfo6q5m99FtKcfUI4Z/ZuXu4poPOlEQHgs//cykR/+rjhZgfvykM10pi
	rM4zNjx
X-Received: by 2002:a17:90a:dfce:b0:356:3cfd:3ee1 with SMTP id 98e67ed59e1d1-35965ceae6emr13314991a91.23.1772520437634;
        Mon, 02 Mar 2026 22:47:17 -0800 (PST)
X-Received: by 2002:a17:90a:dfce:b0:356:3cfd:3ee1 with SMTP id
 98e67ed59e1d1-35965ceae6emr13314963a91.23.1772520437210; Mon, 02 Mar 2026
 22:47:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226152924.38790-1-evg28bur@yandex.ru>
In-Reply-To: <20260226152924.38790-1-evg28bur@yandex.ru>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 3 Mar 2026 14:47:05 +0800
X-Gm-Features: AaiRm53kGlh2Awdy28xoiAuCbe7shyoxelpKNPYu-3mpDcUBtvJikJBhEZg_LaM
Message-ID: <CACGkMEtt39WgBDgAGFG9pSJe4t-vRL-0EELA3zs1dEZ7euu0bg@mail.gmail.com>
Subject: Re: [PATCH] vdpa/ifcvf: handle dev_set_name() failure in ifcvf_vdpa_dev_add()
To: Evgenii Burenchev <evg28bur@yandex.ru>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	lingshan.zhu@kernel.org, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1F3DE1E9C57
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222803-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[yandex.ru];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 11:36=E2=80=AFPM Evgenii Burenchev <evg28bur@yandex=
.ru> wrote:
>
> dev_set_name() may fail and return an error, but its return value
> is currently ignored and overwritten by _vdpa_register_device().
>
> Abort device creation if dev_set_name() fails and release the
> device reference to avoid continuing with an improperly initialized
> struct device.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


