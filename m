Return-Path: <stable+bounces-188311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93048BF539D
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 10:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E3973A62B6
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 08:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB73302CD7;
	Tue, 21 Oct 2025 08:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYlcS07v"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9553A302CD0
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035313; cv=none; b=OeWKweaSs6faLIw91PHHmi1C2nvEd8jSTk+yqdsUgwPKQ3KRUw02FkCyTY1iGzz7/Io4GP/UAqgXZJfNjUICY1lDo2VUTKUTsB45Ju3NQl2MQmM1FA2ujTlgav2hwIf/kZMIN9LvofpfKxlbecDPonVMIFR7s9G5sR79034MKJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035313; c=relaxed/simple;
	bh=6b74B6VXDCdcmJHeIm2ZbabEvGQgPJOC4TiiYfNyIxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHj0HP12sGiPy5lFQFdhkaZm16S8y4DuY7lLfUXtcFU4i5Gv6FMAhWhy53WpPLDq8q1c2bbdWyixAGhTuAMbiPbrNvFNEM2wo4TkWzZ+NigpwklHvjEXiS7nZIZXag2u06vWPWGx7/9cPOlNTAwI74im/n9bZNNfXfTa4v5rGTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CYlcS07v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761035310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9wgX9rXCO2UPANmfcyjOB2pBN8YmhnWytsGw80sw54k=;
	b=CYlcS07vK4w/UQOtsUYIvNUKE+ZmCWnmNHD5zaCWAxwxHHx7VwMXUMKLP2Q35JZsLYPotj
	CaakgnXqSxGuvAggG1EudK+zPfbclD/vZRRca78EniWtJgkVm2bUoT26jDyTeKLbKBm8wW
	UVPETM5pivLcjrAlNM/e3t2/ymnvNis=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-Q0RPNFl_PuGeo8oNiMrxgA-1; Tue, 21 Oct 2025 04:28:29 -0400
X-MC-Unique: Q0RPNFl_PuGeo8oNiMrxgA-1
X-Mimecast-MFC-AGG-ID: Q0RPNFl_PuGeo8oNiMrxgA_1761035308
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-472ce95ed1dso18267235e9.3
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 01:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761035308; x=1761640108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wgX9rXCO2UPANmfcyjOB2pBN8YmhnWytsGw80sw54k=;
        b=Y1rJthI1+cHXvCRpm2Q/9JW3FFqjolLikY7ufxJ/vpahNC6r92lyB/BAqV83HzQ3iA
         OI6U013i03vvR9UTVfzLnn4RVszvE5NthQJGnyeLuoaRa3MRuEaavrEkj/iWq12xGSEo
         tX577naPgENOLbWVt5eWXwAO2y85E6AH9FLX8xrGaG2k6/W1rtkT8zjiHvvMLxuzMdOn
         Id9CuVk9p8yEdWmA1aGNgQpLh2ACWaAY8MAzGeOc18jCPjmhZf0a1yNaStH8BdmofxA/
         JPke/r3FCt3J0TEwSjJWA0YBiqjrxd+jq94kZcQCn60cduTr5x+O6LzL4x7Ik2k2KxUl
         U3KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCoog4mmGVn5/XrI+ELMsS7ZYIrtO3SDDhTBr7OErpkiS4kYIuI6+HkJ4XVUdSuxnPDDBaCIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQVv0+KZ3z49E8SJ/chpolssby1Dm7s3oMDT2etsUmcV98UMAv
	SKV8o4iQm8Eno94gL4Niv38fOHSHn9wGRRmezCeAHxOeBC7hBmxpJ33XfwafhE7esHzfseyRxlq
	T+aBIz3RxB7iUu3UfzxXcYezkZvfE7N/UAJrUzO9jHpLUq1PlE3UGfv49BQ==
X-Gm-Gg: ASbGncu/M5OxM8JvHiXNnqfeOsZ2y1fR/a5tajqZBL1vsNFs/e3dhPZRYdiY8wcb4TZ
	Eq3qkNYASGW81d0dustVYAyGFt6Dtk+6B0/X/76g+4x46/i/lbTmKStHb/U80MVnPzs4LEgumU+
	VgS+7XP3DYOLcEfb6NCx3m6AJAIRnzrCfDFndrZeTt1OouPUhRWru/qLMbp9g98RtK0a2sigOBh
	uEdAuWAENOt3PmKk+1PG3gLYaKLTxPt7ndCKTau8TfRNPIm8JPKci5eV/efF1fGlICvdMX4u2ZD
	Lef7mg4ko7nI87DU4YnXuCHxFOEW6Fk9AJgQlUSMb9TSv1lawdcSvuSVw4sQ4LQJdjFH
X-Received: by 2002:a05:600d:824d:b0:471:1b25:f9ff with SMTP id 5b1f17b1804b1-4711b25fcefmr68406895e9.39.1761035307822;
        Tue, 21 Oct 2025 01:28:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGRVyIsfoQR5BPGvrQHdlbSlAJgPiR7tZMRXYjTySH7Todua5vbiJ9sWTo57eh1Pa8fByUpA==
X-Received: by 2002:a05:600d:824d:b0:471:1b25:f9ff with SMTP id 5b1f17b1804b1-4711b25fcefmr68406715e9.39.1761035307261;
        Tue, 21 Oct 2025 01:28:27 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4714fb1b668sm213055095e9.0.2025.10.21.01.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 01:28:26 -0700 (PDT)
Date: Tue, 21 Oct 2025 04:28:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] virtio-net: zero unused hash fields
Message-ID: <20251021042820-mutt-send-email-mst@kernel.org>
References: <20251021040155.47707-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021040155.47707-1-jasowang@redhat.com>

On Tue, Oct 21, 2025 at 12:01:55PM +0800, Jason Wang wrote:
> When GSO tunnel is negotiated virtio_net_hdr_tnl_from_skb() tries to
> initialize the tunnel metadata but forget to zero unused rxhash
> fields. This may leak information to another side. Fixing this by
> zeroing the unused hash fields.
> 
> Fixes: a2fb4bc4e2a6a ("net: implement virtio helpers to handle UDP GSO tunneling")x
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  include/linux/virtio_net.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 20e0584db1dd..4d1780848d0e 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -401,6 +401,10 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>  	if (!tnl_hdr_negotiated)
>  		return -EINVAL;
>  
> +        vhdr->hash_hdr.hash_value = 0;
> +        vhdr->hash_hdr.hash_report = 0;
> +        vhdr->hash_hdr.padding = 0;
> +
>  	/* Let the basic parsing deal with plain GSO features. */
>  	skb_shinfo(skb)->gso_type &= ~tnl_gso_type;
>  	ret = virtio_net_hdr_from_skb(skb, hdr, true, false, vlan_hlen);
> -- 
> 2.42.0


