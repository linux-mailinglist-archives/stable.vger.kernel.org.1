Return-Path: <stable+bounces-191439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59491C1462C
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 12:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974BF4680F3
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 11:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5C530499B;
	Tue, 28 Oct 2025 11:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A5gZQ4j0"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240F0304BCD
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 11:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761651036; cv=none; b=R0X461oLMlEz05YDTD9BP3tljIIILi5CWgMERZnYZwXkjvNXjVylUyooDbwnceozEIohP1mP7u+agZfjkDuHUwZPx6ELDpsYhnKkdNVpabw1FO9iNR56D1f5xeVgE8uD85ICfFXBXxPs7HVPtPx6VMGmF/8GELdicBOprlW1Rvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761651036; c=relaxed/simple;
	bh=uLz1nCOc13P72Z9cLqgJATuBA1im88R9TxqI9YQCXBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NqNTLEZ4sEDeIkCdoTKS1MlpGqgsqPy0DeUr4dGHqsfOjTNdJEoB1BaKMYihbSfb35spIDHoLDxV69sVKzG9KM71ntyggz4hJDf+rlkhE8A/VnyHUgmcY7Okdqcr3eA6tvdAABC0lwrAIgLiOxf2KA9YcZLs9DM2y5fLdOKPZ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A5gZQ4j0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761651034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6wj7YAztZrM6wj1+S+3q5JHWOPj4KIXwKeK9N2bqLfU=;
	b=A5gZQ4j0xLIsGcgO2HUNkY0U3Ui72riAn6/pLfsfJd7vhw4IgnyBoh2JVae9HT6iOgOwoJ
	uVgnFuqWFL97Ame9GmTrOYjQ87bSePLcY3PN9MgPT014WDkm7JiVKr7Uh4Lx3s00auQPUV
	rOJPnxtTyj+5Q5dRTbHvP5VcPmJ8v5M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-Lb_WPxo2N9qJEZNY5_Zkhg-1; Tue, 28 Oct 2025 07:30:32 -0400
X-MC-Unique: Lb_WPxo2N9qJEZNY5_Zkhg-1
X-Mimecast-MFC-AGG-ID: Lb_WPxo2N9qJEZNY5_Zkhg_1761651032
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-475dc22db7eso30882565e9.2
        for <stable@vger.kernel.org>; Tue, 28 Oct 2025 04:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761651032; x=1762255832;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wj7YAztZrM6wj1+S+3q5JHWOPj4KIXwKeK9N2bqLfU=;
        b=mlr/E0qA72lIfC7MOnn4toEQgMef9C3AsRKRtUM+E/0Xbp3K4FZFnMBFeUt8X16MSA
         I4f5wXP7985bIY2IHU+3jNfLtkJ1pzMRZyIkDuG3rYXw+rC26dnEruqVvMXdz5tVacSp
         8UW72HAPZiSe0JeUyHTg29MCTicHgVKQySwHs5NZxFUTBpCNozA2O1hqF/FCEEXoUQCo
         tiqGZ+jv+j8TKt2HWxeDrUiU8P4ccHz2nMCG+PAy8V4gBH2zgbWi8/nYkqd6DwAXQD+M
         OFHghG1IhkZkv7jqVnkxvjmKuOQhDJPB8X1IZc9oGGPJFzrqXR3WpiMenq5WKjpDvI6T
         A8rA==
X-Gm-Message-State: AOJu0YzsAO7ODG4XLdsa58dyMVvTJSDaCpgQiFW4LSBmSyeSP16WVn3O
	KgzxK6kkh3Be9+kGx2aCNrJQuzsjZM/XUD3I8+rdWiCEalwVGzkBxgMqclZuSqH2dLmuHAawHA7
	TMP0IOrXakorwAmMSWq54MzIkc726f9x6zUJLCM5NbaImsu7CsymVJQu5/Q==
X-Gm-Gg: ASbGncs99vUZKHiHlm88BkG3DsDss+TiP/PW05gMsqVDcQCoWSsHiVS+gFqqfw+WkJL
	lL1mCFMDaUXipRiSI3AJkHB7k8xz5v6vE+yDdCX9fDLDmdajWoX0lRPiFOMxh4b/CDY8LF1ZRm3
	qAL5mRZQnMl71/a8VHbOajzYgGkxFhnLl63Psu9Z5+HUFYp+0TyobPee33pNaQaWp7UwdURSX5U
	0lk+bbL56NGR53A2fvPlRRN7DmeiLCRDQXrZ2BmlcrPaGWP1lqaQaxWHB/QS9DsCs42D2oO+HJO
	N0fnbB14rOP3BW3zxX2AckLBFQfX1GP/h3+CyyEkg/CEfagE4k/xFkg3CMhocRIDYqYL1oMhsrf
	a47VENTLP/0yt5mcp3DtyEVkcruOs8rXdHM9OkwHGwBc4Tls=
X-Received: by 2002:a05:600c:4446:b0:475:da13:2566 with SMTP id 5b1f17b1804b1-47717e6095fmr25034825e9.35.1761651031652;
        Tue, 28 Oct 2025 04:30:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1UoWkDkAxEnPYbIqlYF36LNiS1od7f4r/oylsQ8lGjLYMkIaaEI5SdiPojR2VWZlNQPGbIA==
X-Received: by 2002:a05:600c:4446:b0:475:da13:2566 with SMTP id 5b1f17b1804b1-47717e6095fmr25034235e9.35.1761651031148;
        Tue, 28 Oct 2025 04:30:31 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd489fa4sm187152685e9.16.2025.10.28.04.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 04:30:30 -0700 (PDT)
Message-ID: <c10939d2-437e-47fb-81e9-05723442c935@redhat.com>
Date: Tue, 28 Oct 2025 12:30:27 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/3] net,mptcp: fix proto fallback detection with
 BPF sockmap
To: Jiayuan Chen <jiayuan.chen@linux.dev>, mptcp@lists.linux.dev
Cc: stable@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>,
 John Fastabend <john.fastabend@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20251023125450.105859-1-jiayuan.chen@linux.dev>
 <20251023125450.105859-2-jiayuan.chen@linux.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251023125450.105859-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/25 2:54 PM, Jiayuan Chen wrote:
> When the server has MPTCP enabled but receives a non-MP-capable request
> from a client, it calls mptcp_fallback_tcp_ops().
> 
> Since non-MPTCP connections are allowed to use sockmap, which replaces
> sk->sk_prot, using sk->sk_prot to determine the IP version in
> mptcp_fallback_tcp_ops() becomes unreliable. This can lead to assigning
> incorrect ops to sk->sk_socket->ops.

I don't see how sockmap could modify the to-be-accepted socket sk_prot
before mptcp_fallback_tcp_ops(), as such call happens before the fd is
installed, and AFAICS sockmap can only fetch sockets via fds.

Is this patch needed?

/P


