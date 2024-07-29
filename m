Return-Path: <stable+bounces-62606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF3893FE52
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 21:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 134F11F20F48
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 19:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAE915B555;
	Mon, 29 Jul 2024 19:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hiqJz23y"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B9B85947
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 19:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722281667; cv=none; b=XGaZA5PAa98/fBiO3iRVC0yTRTQ8mw7ripWt0870sURKg7PqaMrSD0jTk/zL0TQ+c65gjSimt/ikld/eYJGjG5V3H6pVLON1n9B6rtVvwJZmH2Mhe5umotwI/J2A79vMbaimnPQQVDUaP7au1tGlFpgAmmbAeiK8wwrCo/Ogh4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722281667; c=relaxed/simple;
	bh=jlAx2NCTJSaKGEJ7wGOr7oQrgu9ka6QdRRVVq4IOV0E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OgLviEAUTzgygGHc4LVsKQ2wnAhIwDMEe3zYEqtgqRUgaF5vxNv8wXTF5xB8LuVhTkDNOfnN5E3YVrutNYO8SiwCVtie+ngA9jUa5yCeRmrjdHipWV3HsleskvNlWMFcz6Hr1alU6F5S2O1UzMTcQjpEDrezEHsL/SezV3hT59I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hiqJz23y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722281664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zw8xrAP1qOKii4QYZLlnbO8Ma6jMAc8cblojOvZhIo4=;
	b=hiqJz23ydYKgKQDvhEseGa4++Yqh2cetEVNKtCYv6tb/IGzTFrGuIad8Q6v+cmjpN/pZ8m
	n5Ux20wL1UR5pIjpmBqNuSWH5QM9ZRanWTHzS9YIu6ludRnyFM3aRo0DLAVcLOXVn4kXhd
	scrLwxTdkIpd3EIpeGC0S7Snwpv3Nxw=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-eKjBj4bMN82SNH4-hpYydQ-1; Mon, 29 Jul 2024 15:34:20 -0400
X-MC-Unique: eKjBj4bMN82SNH4-hpYydQ-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39ad7e6b4deso55110655ab.2
        for <stable@vger.kernel.org>; Mon, 29 Jul 2024 12:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722281660; x=1722886460;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zw8xrAP1qOKii4QYZLlnbO8Ma6jMAc8cblojOvZhIo4=;
        b=a0eArFLAG0PyBYONOJYbE6zalGSddC+3Bk6TADo/94REZkgHscdviL7fpvkkDdeE4U
         wo1ujJBtBgs2JdTqcnTZZ0IiT+5lkM+BN1g3X9XdW2wtvNORoseG/xr9QNuwYMIv7iJk
         uP9/4daHzHiXstOjR/hktS3xxAe4JywuXLQmw09KSMUE50HsZyPaV+92Nuj1HtDyxaLt
         yxlBSm6FrApLvuk6CxctpVY9oVCGbmsm5fpmtKMKo2HqHwjIMNJdPnk4t1uI8dAJq53b
         noykzlfh8muuss28to0ORv4yP3kUVRKnXHadJIlob7tt0rid2pFOr/0ejTANhLcRJ6vs
         6YoQ==
X-Gm-Message-State: AOJu0Yw5YuXjfuU84D///U8T8Pd5BWQ1wgcjs9K9RBdd0Xp/F1kwFiG4
	rmLrDUd0soP/9chGTG1CO0AB6vOfvclro64DbVIYF5mFnOSdh3AeiKaNZleHfVc+LwZqg/igM1Y
	AVaK0KnL7gg+BKcXr+QklomlkvGeu+8pyCq9RmaSWuUWo2o+4Z6dPHg==
X-Received: by 2002:a05:6e02:1d0b:b0:383:6af0:eb09 with SMTP id e9e14a558f8ab-39aec25eeb4mr109379675ab.1.1722281660293;
        Mon, 29 Jul 2024 12:34:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyfCf3fJZ/hcep9SDETO8yFXsvoLnNW/hIDmTCPe9LkKWITn3oInCd2/J8vA+zSGHEtbVOMw==
X-Received: by 2002:a05:6e02:1d0b:b0:383:6af0:eb09 with SMTP id e9e14a558f8ab-39aec25eeb4mr109379415ab.1.1722281659955;
        Mon, 29 Jul 2024 12:34:19 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fafada3sm2379743173.78.2024.07.29.12.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 12:34:19 -0700 (PDT)
Message-ID: <7bab7fee-6795-4795-821d-788b324f15db@redhat.com>
Date: Mon, 29 Jul 2024 14:34:19 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5.14.y] fuse: verify {g,u}id mount options correctly
From: Eric Sandeen <sandeen@redhat.com>
To: gregkh@linuxfoundation.org, brauner@kernel.org, josef@toxicpanda.com
Cc: stable@vger.kernel.org
References: <2024072908-everglade-starved-66da@gregkh>
 <2468c31e-f861-4e72-ba5a-66768d468e44@redhat.com>
Content-Language: en-US
In-Reply-To: <2468c31e-f861-4e72-ba5a-66768d468e44@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/24 2:30 PM, Eric Sandeen wrote:
> commit 049584807f1d797fc3078b68035450a9769eb5c3 upstream.
> 
> As was done in
> 0200679fc795 ("tmpfs: verify {g,u}id mount options correctly")
> we need to validate that the requested uid and/or gid is representable in
> the filesystem's idmapping.
> 
> Cribbing from the above commit log,
> 
> The contract for {g,u}id mount options and {g,u}id values in general set
> from userspace has always been that they are translated according to the
> caller's idmapping. In so far, fuse has been doing the correct thing.
> But since fuse is mountable in unprivileged contexts it is also
> necessary to verify that the resulting {k,g}uid is representable in the
> namespace of the superblock.
> 
> Fixes: c30da2e981a7 ("fuse: convert to use the new mount API")
> Cc: stable@vger.kernel.org # 5.4+
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> 
> ---
> 
> (compile-tested only)

Sorry, I lied, I compile-tested this patch with the dependency added.
Ignore this one, moving too quickly. :(

-Eric


