Return-Path: <stable+bounces-205103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF72CF900E
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 16:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0ACCD303A032
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 15:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C6E340D9A;
	Tue,  6 Jan 2026 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1YscHWNn"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2819F340287
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767712112; cv=none; b=ZBnb3rJkxB+CBTK3kqrvOUatv2hGdU8O6ZozLRiGyCGFIov8SaWWQz729Eifi72qZIitnfY9k0HuYdoDXsgr3SGwi+3gMdqyRznjvhlcBa7s4TLNUfh5GlXfP7OsFRnGqkI7DZKPgGk9fQmkGBoL7CnwRcc1v32Igj2kr3EMbP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767712112; c=relaxed/simple;
	bh=2D9VXICvKZXTMT+5gA3rn72FGvDblCKZDoXgV71TMb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IuQWUoXLMxKwGxQrnEIwIsCQONco/liH2BW8B1hwHZl8JSepwIjeaMcau01DdiCUAzJ+3v44dI3APWLCoCu/zAaekFuNm6nv5u646Rseims02fHO/n/OiC9RTnxUUd3q7Hf89z9u8qP8DozuOz5H2Dnd0AWQmphd8JF/dtoXhys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1YscHWNn; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7c7aee74dceso457164a34.2
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 07:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767712108; x=1768316908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n0msI1TfCf/9Rk+eegzQnF/KlXWSIbpcdl+S1KgTmAo=;
        b=1YscHWNnjoSeyCk6sXkOfAfhc2iqECBHjs/QMB6o+K5pF/KVd6Hnm6TqQLdEt5bDrn
         aq29EerpJXscDQhz3iARSLMbnPtw2JW32ohPpdZu7sm6hJJnEc7s1xBGvRSuTXRUeplD
         HCQbH/3O10T8iQTJ3gsovKj8zuC0Z8m/chPZyovKYGGonZ9X47DrLuXmHkc1ohtXApOU
         OHgyvPLcvbuHCWUlw7oAooEtiGZSuaNzowXx3fckRNHgJLyqRbzke0iHQzu8EtcUGOg3
         /faRAL5QOIOnDrfgzH7C0GM9sXGYDYVNIv7HMO+l+E3vc5mB0nPw2xm9pLYopgo1sMGv
         064g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767712108; x=1768316908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n0msI1TfCf/9Rk+eegzQnF/KlXWSIbpcdl+S1KgTmAo=;
        b=QOTwuHAetl7zUadciYogNGUyObT8pdv7Fd5ocaj4T86y0zRxwuTDpe32ecKw5/7CdA
         KavvUaHJkvHMAiYTrPKXOZZKsEmqhprfwALjWwgWJ34hdZFusi8SNmeIGw0bcjdWDnUQ
         Td82dvMmiomTXPBNwEPnpYTZ9nZg18uge+L87vsI8fU6OfJayPrH2WSn0349QBnqkCo9
         uiXGzyzm2/XZjOSIKtKAaz8sK0x/2frctCt7g1kIMLF09BLM+BPp0iuYxrG/GFdWQn9h
         TGXIfsKJLWecdcWdauquGEIB9yR2nycHTkAs6VKG8fgWaBNQVtNMEFgwe3GNaFo2N59j
         pdyg==
X-Forwarded-Encrypted: i=1; AJvYcCUOfNfjr/wW0GhmSu7iqR5C6SeWRpyKSgMyCOI4n98HpmdjM0NQf5uLBY8KFQdz6jXZNsFSb6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP37atR4m/2sNHzx2pjl+2fD185zgHYK+p+HoyV+Hm/RiUTumM
	L7iadK143eLwZErWlzS+OTxDCCsJNlTe+qudAeLs4bxsbW3lwbn01dkVZx2tjVyOgAw=
X-Gm-Gg: AY/fxX4w02v1zthDQ/lUjR6nVOYxLhMmdtUyV+VQ3/H4mfqKL2RXaMs93dlSbnw+woi
	E10jasgkIfz0kVN1GRknEoboED0xQ+SDF1wR8iQzrT12eEuEZlPjf8qfm7dFstdhrz1dtHyi1Dl
	gZe6rKpGK1NAvCBPvltOzSAZcR+4mfLvkMa2Nr0xD2nr2IKqBs4eDaMOVJ2r4uO1KZCKV/7ymh+
	2DJNfqlYgFXRHq/MQmI3FD4ymfcRBL6fq37kaxLu/2r/JkO7Bl/xc2jPTxe2P28cTr57AFq+9Cu
	R8AWshYE/BLOYIa+nm8SrKu5nDXPsYNZvr7e3EbLHoSeFadD3VkkvCLjXz+/25lYpT90kwub5z0
	ssBlOp7WOAHxtoNkTcmyOOdfYXmrSu9MmV5nInK/MavSu3HbPLvplQcu4bNg+54Jmb0ErUY0dcM
	hPzrzkVIY=
X-Google-Smtp-Source: AGHT+IFjPiBLPajwzjq5MHGB+HObU6HlOdcwgRgvouUEiKnCSsLF+zJC/Wx91AHU7dJLuyDahtyZMQ==
X-Received: by 2002:a05:6830:2e07:b0:7cd:dc79:9f87 with SMTP id 46e09a7af769-7ce467429damr1618877a34.35.1767712108109;
        Tue, 06 Jan 2026 07:08:28 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce47832780sm1553233a34.12.2026.01.06.07.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 07:08:27 -0800 (PST)
Message-ID: <aeaca3bf-b6e6-48e4-9493-6c200a49d1ec@kernel.dk>
Date: Tue, 6 Jan 2026 08:08:26 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: do not write to msg_get_inq in callee
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com,
 Willem de Bruijn <willemb@google.com>, stable@vger.kernel.org
References: <20260106150626.3944363-1-willemdebruijn.kernel@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260106150626.3944363-1-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/6/26 8:05 AM, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> NULL pointer dereference fix.
> 
> msg_get_inq is an input field from caller to callee. Don't set it in
> the callee, as the caller may not clear it on struct reuse.
> 
> This is a kernel-internal variant of msghdr only, and the only user
> does reinitialize the field. So this is not critical for that reason.
> But it is more robust to avoid the write, and slightly simpler code.
> And it fixes a bug, see below.
> 
> Callers set msg_get_inq to request the input queue length to be
> returned in msg_inq. This is equivalent to but independent from the
> SO_INQ request to return that same info as a cmsg (tp->recvmsg_inq).
> To reduce branching in the hot path the second also sets the msg_inq.
> That is WAI.
> 
> This is a fix to commit 4d1442979e4a ("af_unix: don't post cmsg for
> SO_INQ unless explicitly asked for"), which fixed the inverse.
> 
> Also avoid NULL pointer dereference in unix_stream_read_generic if
> state->msg is NULL and msg->msg_get_inq is written. A NULL state->msg
> can happen when splicing as of commit 2b514574f7e8 ("net: af_unix:
> implement splice for stream af_unix sockets").
> 
> Also collapse two branches using a bitwise or.
> 
> Cc: stable@vger.kernel.org
> Fixes: 4d1442979e4a ("af_unix: don't post cmsg for SO_INQ unless explicitly asked for")
> Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.24d8030f7a3de@gmail.com/
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> 
> ---
> 
> Jens, I dropped your Reviewed-by because of the commit message updates.
> But code is unchanged.

Still looks good to me:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

Thanks for doing this!

-- 
Jens Axboe


