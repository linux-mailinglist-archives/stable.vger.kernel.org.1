Return-Path: <stable+bounces-171959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1915EB2F3D7
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 11:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83135E1894
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 09:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A8B2F1FF6;
	Thu, 21 Aug 2025 09:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJCz51Ua"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2C12EF65C
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755768212; cv=none; b=fIZKPDuO0wi6eEDb31j6fdBVuM/5jn1fs4qgOXij0rg0yD3D9atitBcR4ht9WYzYT5x6HCHjTrTxsnzwy5oaMBcwYWXtRI0mX0Xn1GeF18D/Y82jaHKlRInaXXRk2TGekwwyTkr3P1iFSttpAHfh3a7XtFFpJ6x5FYgExz0bEk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755768212; c=relaxed/simple;
	bh=bqK1EohHu71zjabqHTqoKWsH2VYa/lqUaQNt1/AZT4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h1nnXLJsJRGVRBZTSqaiTboLoSfUWfGDhrBE89W85vgngxbcIBgXuD2Nux3JQ3EXOrE6CiRt1Rdjwrc0/WCTl9jOfgusTwyzSBSk0oC4kAZCoXvr6U8aeASQP7e5hRfEtrgLqrp8g6obfJlP58MRS3LEZBarS/kL+OX62PHNAYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HJCz51Ua; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755768210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dOJOZZdThAmSYOmW8vQd0bDMJuONYkO1YWwTFftLPfc=;
	b=HJCz51Uacu4nB0ace3no+BMpoLia3Jc9aWaTOz3gIGQFfh/6YAQFQ866MpBxYyKpf57fSs
	aZnbPePzZ4f3JErDGniI15BHlywGwXNw5FCMrhIjlZnIxmv9YXiUmqURPXL3Ei71qxKyKT
	ePEqXd266osUrZgfxSGYjQ1nHVmJ1Yg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-Dwe0H9yXOC6ppB4Gj3UzfA-1; Thu, 21 Aug 2025 05:23:28 -0400
X-MC-Unique: Dwe0H9yXOC6ppB4Gj3UzfA-1
X-Mimecast-MFC-AGG-ID: Dwe0H9yXOC6ppB4Gj3UzfA_1755768207
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a927f570eso17071646d6.1
        for <stable@vger.kernel.org>; Thu, 21 Aug 2025 02:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755768207; x=1756373007;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dOJOZZdThAmSYOmW8vQd0bDMJuONYkO1YWwTFftLPfc=;
        b=r/RkDITbWG/77NHaJ80adHOkli+DojdMQv32iqlmjLC1C9o4JDuASNmp9yuc8ZZphE
         Ehcxme72SHZiDev6xLWzlRqFS/VwLAQdNsusOA+w4fG3bZvOece7id/Iw4XTioe3NfW1
         ZndXVgcObCdigcKAI6FPxAQLGA2DvO7lRJ3Vyd5xeHCTI0CrPNo2g4fyGYOInCKlX/Od
         p3JTysbpQADRssdWjCpbwjmZZbpF6gcAmgyb/ftSPMdPjvVTiu0JRfPSFWuzBlViUKnD
         wV++hRTWOd2dIZvGethTKCFg3SLY73aTEc7OWoS8mSB8AHUbxXm9kvHHhwLJ+cRStK3H
         fWTw==
X-Forwarded-Encrypted: i=1; AJvYcCXvYxAjxeaaXK9vR+o4KMKFaZiq9sNIRkgqYC6VkDWY8IcgH8Q58ju/LwAWeP6ETbtgARSUfUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+gA+8FaqmB6cl5kLP4kCC+j7IQU4j+KGtUWSa3ifmKVRVm0Mz
	tS4ywgdCu39NYbukHiaym3o0ZyeZNyWBA7QSvoWj/Mp6qpnW/w1YRp6xNMIHf6u+2n1Q9oNj5C1
	0hX0cREczCz1WTOkjYd0CTbJgLBJxyz8m97cSPPJMig3i2LWmxZJ8uoZV2A==
X-Gm-Gg: ASbGnctsElDPsraebjNzudUGvhr9FIFYqjQyMUpRhu39OXfe09eIEtOERYPmFSNffMQ
	JzecqE4CDKyzOLfsC5k4Iya+Xlx6wpCUMnCbDEKGvCj5Rl85i/sCOJ5rvUULCNH+q3riNK5BH9u
	a7prIeJr7wrKp6vni/VONc49A7E7lfVkdIO/UdOiJplH5c/a0bV4sJccbzv/ZK+c1oAmd3U7QDO
	iRhCNPOtlbcblTEefRC6TN2AgDeJ3w8G4QSZr5s2XPJ4g37FSDrr8qyDovuqbg8XSepXnhRdkUi
	0i6+Z0fAAej9LC8tYuYot4k/UVcJbOBHJcllhytmPsr3VdiVbvXdOzt269B/qEleR/9OlAg06O3
	S21G8Jtb30oo=
X-Received: by 2002:ad4:5bac:0:b0:707:4aa0:2fb with SMTP id 6a1803df08f44-70d88e92700mr14422416d6.16.1755768207435;
        Thu, 21 Aug 2025 02:23:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHQeoOWaOCAlmZqkreErWZ1WAJZpVAGCQsupGfVEE7FWFJd2NfiFuKMU9Iyktu8wjNf2tj3A==
X-Received: by 2002:ad4:5bac:0:b0:707:4aa0:2fb with SMTP id 6a1803df08f44-70d88e92700mr14422236d6.16.1755768207031;
        Thu, 21 Aug 2025 02:23:27 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba9382300sm100386566d6.64.2025.08.21.02.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 02:23:26 -0700 (PDT)
Message-ID: <062219ff-6abf-4289-84da-67a5c731564e@redhat.com>
Date: Thu, 21 Aug 2025 11:23:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ipv6: mcast: extend RCU protection in igmp6_send()
To: Chanho Min <chanho.min@lge.com>, "David S . Miller"
 <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, gunho.lee@lge.com,
 stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
References: <20250818092453.38281-1-chanho.min@lge.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250818092453.38281-1-chanho.min@lge.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 11:24 AM, Chanho Min wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> [ Upstream commit 087c1faa594fa07a66933d750c0b2610aa1a2946 ]
> 
> igmp6_send() can be called without RTNL or RCU being held.
> 
> Extend RCU protection so that we can safely fetch the net pointer
> and avoid a potential UAF.
> 
> Note that we no longer can use sock_alloc_send_skb() because
> ipv6.igmp_sk uses GFP_KERNEL allocations which can sleep.
> 
> Instead use alloc_skb() and charge the net->ipv6.igmp_sk
> socket under RCU protection.
> 
> Cc: stable@vger.kernel.org # 5.4
> Fixes: b8ad0cbc58f7 ("[NETNS][IPV6] mcast - handle several network namespace")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Link: https://patch.msgid.link/20250207135841.1948589-9-edumazet@google.com
> [ chanho: Backports to v5.4.y. v5.4.y does not include
> commit b4a11b2033b7(net: fix IPSTATS_MIB_OUTPKGS increment in OutForwDatagrams),
> so IPSTATS_MIB_OUTREQUESTS was changed to IPSTATS_MIB_OUTPKGS defined as
> 'OutRequests'. ]
> Signed-off-by: Chanho Min <chanho.min@lge.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

FWIW, the SoB chain above looks incorrect, as I think that neither Jakub
nor Sasha have touched yet this patch.

/P


