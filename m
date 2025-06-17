Return-Path: <stable+bounces-154082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15530ADD71D
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1B147A6611
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD632FA646;
	Tue, 17 Jun 2025 16:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FmhgxBzg"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E362FA636
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178045; cv=none; b=dIc5LxBt1DQQfJzKhVT6NtCMF7WIUF/bHQl+czoLEyWTalMWJXnoLsFT5wt+sOAktM94kk60+cGcLBX/by8ofcU9K3jiiQ1m2rn7iOuAV62dpPw1ftKGfTEzK2dKSNlivp/7TFeOBqLstjDQPdXgf7A33T4DVQcZ5WrCDLjLUVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178045; c=relaxed/simple;
	bh=wuQK4PY6Wesx93pO6kQyuApJXzA7Pnaiiz9upoFqK5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JHWEZxTyp4RYdqBJMT+8TOPHQWxfSO7Yf05XTQ9DNsle9Z5899DKtIwKgfErh6ncjYdNObruC/6DfqGidqbUrzWtIQLhW+yioIpn/6aaQPfKjIWn+N3Wnlk1HZPgmUaaQHvbIR7nG8d67qpBKhIlALbEExqMu3O/ekM3mOKaHk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FmhgxBzg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750178042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C6F/xKShMaNc3dbnJiQQDmLIQrv9IiIqZlBulMM1x+A=;
	b=FmhgxBzgjq597b3XwAGVIVjtI2Ez/vrl/pFrJOIJwmlJl5gqsmjN8vIZD4soxCcbWrMB6d
	ooURqp58GIT5Cu4Yqq87vnNyTjxigIKIk9/8/Yzemk44zJ4TSeAxYsscReCgn5xDI3+zX7
	GAu+gXcbADrUqtA2lWH2w35tSmT76F4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-Nk9pWIYSOl2-pB_yq2m49Q-1; Tue, 17 Jun 2025 12:33:59 -0400
X-MC-Unique: Nk9pWIYSOl2-pB_yq2m49Q-1
X-Mimecast-MFC-AGG-ID: Nk9pWIYSOl2-pB_yq2m49Q_1750178039
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451d3f03b74so38875355e9.3
        for <stable@vger.kernel.org>; Tue, 17 Jun 2025 09:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750178038; x=1750782838;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C6F/xKShMaNc3dbnJiQQDmLIQrv9IiIqZlBulMM1x+A=;
        b=vY+C7XzKSXhHs39miIRpGFEWXJOp6UdxfWoDJVhDJfcgQLCqY3CYgAaRaaGA7Bjv6X
         FNknUdn9BDGlb0uqlWCg0+vigOmOYpjXlc8wNjDLeZgBjnO2wZrgIUFiE/iqolyp/sfv
         /vxuf84WI4rlxMsstHCCYa6IyjLoA7B0sHMkK3P5CfEN6NGMWpRwUPFAKjresg16qeP9
         ldzSJejxQZ7cqttwfaAl+K22/jm+pqQm1M1Zd+flIg6YNwp/T174mlyQdVftY+2zxhf0
         PhRkEHqHACXRRcJR7rzmZ9LZX2yf5AjWCJX52UcH0ZUCR9T4L27fZhB5ZYndNWyKgM9B
         BnkA==
X-Forwarded-Encrypted: i=1; AJvYcCW9Oshcteehibd0Q89QVRZ69VPtmKCVwdc9mdVYp1LEdo70T6g0YmXBRJftGD2EsJ350rsjl/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgdIFnYJxXpcqMrpgO4bAP0lRAd3NWUoqC+NEpVTmd9RZpRhRa
	w1U4kxtlIyrBGblc73G6m3LFgR0+/1VNAZkyE1ha4Hexbo+Hg9LXTsHK9Jar3gwNxD/hIlyhGPk
	6r07k5ItPAUQq6SPQV7hxk9rxOCN7pvBc1LAKKBk5KTE/3lfpUBEosVwwfQ==
X-Gm-Gg: ASbGnctFgVbvU8DRl6tMxIv5SYePY1cwXH25CnBE+YOmufGF1IV+RdN6SkohPUwvR3F
	0MIiVdVTh5YtHRPy5V0rkyMRVJhNsgPe1zq+mQ5RhhsBqmqAxYvG9S6eVptmwp7bo/NynrYsEMl
	P7+hsu3psGSY2oDxXaDunXGDrMkzgYhnaQaXLCaWXiJix+VIezCUkaEoONyedum6lr6t2uI71Hh
	QSYzZ4VqnUq9AjqHjDKRmpNAtsXq1G4RNNwRziIFHETdW0oWHAJorE6jWyXA99BaB8zEhkN6K0g
	ws0+VEDLRE/EkQ2QSWvl4qn3BPu+sg==
X-Received: by 2002:a5d:64e3:0:b0:3a4:e2d8:75e2 with SMTP id ffacd0b85a97d-3a572e58576mr10299242f8f.50.1750178038578;
        Tue, 17 Jun 2025 09:33:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxxUn4zKRtePUxOZR0MuA7rayI2tO49ibdi+Qo+0mW2vWHKUvMuun357PnFmBVQaX7neoNvw==
X-Received: by 2002:a5d:64e3:0:b0:3a4:e2d8:75e2 with SMTP id ffacd0b85a97d-3a572e58576mr10299224f8f.50.1750178038118;
        Tue, 17 Jun 2025 09:33:58 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2448:cb10::f39? ([2a0d:3344:2448:cb10::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b2b113sm14464854f8f.75.2025.06.17.09.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 09:33:57 -0700 (PDT)
Message-ID: <bc44f920-a1fa-489e-bc2e-f2e3acef7b5a@redhat.com>
Date: Tue, 17 Jun 2025 18:33:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 186/780] udp_tunnel: use static call for GRO hooks
 when possible
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Willem de Bruijn <willemb@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>
References: <20250617152451.485330293@linuxfoundation.org>
 <20250617152459.054731860@linuxfoundation.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250617152459.054731860@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/17/25 5:18 PM, Greg Kroah-Hartman wrote:
> 6.15-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Paolo Abeni <pabeni@redhat.com>
> 
> [ Upstream commit 5d7f5b2f6b935517ee5fd8058dc32342a5cba3e1 ]
> 
> It's quite common to have a single UDP tunnel type active in the
> whole system. In such a case we can replace the indirect call for
> the UDP tunnel GRO callback with a static call.
> 
> Add the related accounting in the control path and switch to static
> call when possible. To keep the code simple use a static array for
> the registered tunnel types, and size such array based on the kernel
> config.
> 
> Note that there are valid kernel configurations leading to
> UDP_MAX_TUNNEL_TYPES == 0 even with IS_ENABLED(CONFIG_NET_UDP_TUNNEL),
> Explicitly skip the accounting in such a case, to avoid compile warning
> when accessing "udp_tunnel_gro_types".
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Link: https://patch.msgid.link/53d156cdfddcc9678449e873cc83e68fa1582653.1744040675.git.pabeni@redhat.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Stable-dep-of: c26c192c3d48 ("udp: properly deal with xfrm encap and ADDRFORM")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This, the previous patch (185/780 -  udp_tunnel: create a fastpath GRO
lookup.) and the next one (187/780 - udp: properly deal with xfrm encap
and ADDRFORM) are not intended for stable trees.

185 && 186 are about performance improvement, and 187 fixes a bug
introduced by them, and is irrelevant otherwise.

Thanks,

Paolo


