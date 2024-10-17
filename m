Return-Path: <stable+bounces-86563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF459A1ACC
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 08:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 421032881E3
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 06:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC111925A1;
	Thu, 17 Oct 2024 06:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1xMEpS7"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A5C18E04E;
	Thu, 17 Oct 2024 06:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729147218; cv=none; b=XS6kmMcfYBuKdxmoGqoQZ3NMdxmXJ8gIUEj2SlKcmW0gFa/1qY3nprfEsJPvB43s4Hhjik7BogSj6oKJMNVIAc1tAET8MbNfNzM7sO6BW6bG14/bok89DQ33uB7paKPwqzwrWZJNrUUtczOFUSWhU87xswQbKGIe+NLXL/VJZ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729147218; c=relaxed/simple;
	bh=2YyJyIHpbw/ARRGDInFV/7E3zxs45BxhiW+EcM9tHQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=t/TtlwyTCrQnx/CjqNdIsVjkET2zmlT7MQHxsZQ6UaWGFmiDmjAhYel2WzTScUlhGyqmyErbgAash8l5kpDt/2dLhcHFOpLLeyJOm0B+iki9VDbEMzSXEcxfkPDeMl277fnC7sUHxIAjqYFHWhHztZkrQB9eBfDDfN60jjZhHYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1xMEpS7; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb599aac99so6324091fa.1;
        Wed, 16 Oct 2024 23:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729147215; x=1729752015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PLE6veHA1Kkn15tlyXnPmyzYpEI6mKCKEODo76UdfKc=;
        b=B1xMEpS71W8FbFdTQGYvehFrM9LRhroZ4YHcPZHGa++/hRdKrcdfIIENyXp8ycqxFG
         IyANjRdKkmEp9qUQj6iOsjj+360R5jE7O/1731kokit1Tgif8yuZDRmaLf2yFHpSYZ7N
         IVsIMPBGubRNnc17z+xVDs+WNj9PtDKogL3w36fejJ1IRRyaG9O9NaWjWjB10WKiZXsx
         isWHXSj6TAWqsZjHINPhpbknQHYX4OQDThqfLRHCDcJWNEYH7FkZc4ZCasQMsyNTpBGV
         QgvCW0+9OxcQbHOUG6fBjURm2Q+66fXAvL62SLPuF7Cx9HUNUHQX0nejSiebdKXeoTPL
         q8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729147215; x=1729752015;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLE6veHA1Kkn15tlyXnPmyzYpEI6mKCKEODo76UdfKc=;
        b=tMwsdHbcT3fyu1Yeze8P8ItVRSeZg5dq7rOrxoaM37kxS6PRFaQyawMbhNg8D6YoNH
         nuW5LI8dlFsnNKur91vQzfu8Yjr/2sEiWg3FOKSx3r4O53B5BzHY1l2d+ng+UPHH+wzL
         VEHijcAmO9E93M3j8PUTS/c2KrS4R+foAUrVUx9lLBEFa3iBXG5BfWHJusGng3mOA1ry
         e9o1fIiLjx+IolwC/43EkC89WX7mwF9opzlzyno0QDY4BAlcdqiWgWyW7LPqsxXAkw4E
         g5DOra4pwi2oMXg4GAPfM5rLfT93RT0i6DKnqpp5j5AXydSrrXqaqpZAd1RomUD+mplF
         vOtg==
X-Forwarded-Encrypted: i=1; AJvYcCU73L6RiJFewlONf3mXf/T4oP2JOhN0I1NKuZ4YwjQKvyvxCIkxCj5rutzNYSaXyafM7/XboHztTkg=@vger.kernel.org, AJvYcCV2t1yxQ+xNiTgZkGgjnLJLcB4YG7FjmzxyFcH+p3vSBcysyDR6kfysPtPLt3fHZeMXiryE/sZ+@vger.kernel.org
X-Gm-Message-State: AOJu0YytjlwPkjTOJQREiuLRjBYmxBk8zh8VXOBBbB4JzF5trIaDBEBd
	M0lFu/Ea1WLFgOSJyl7c9Gs8vSKYwL9GyhayNTVQ0Y49s/+IiXxbm3F6Gw==
X-Google-Smtp-Source: AGHT+IGZ02R+YlMxFD6YKq1Z1f78AWYeREwohxNopenGCr27YxhjrtwLPwQZuhBxFmiFqGgV2XZp6w==
X-Received: by 2002:a2e:bc27:0:b0:2fb:5bf1:ca5e with SMTP id 38308e7fff4ca-2fb5bf1cbfbmr56455301fa.42.1729147214720;
        Wed, 16 Oct 2024 23:40:14 -0700 (PDT)
Received: from foxbook (bgw164.neoplus.adsl.tpnet.pl. [83.28.86.164])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb5d0fb51esm6381281fa.19.2024.10.16.23.40.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 16 Oct 2024 23:40:13 -0700 (PDT)
Date: Thu, 17 Oct 2024 08:40:07 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: mathias.nyman@linux.intel.com
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 2/4] xhci: Mitigate failed set dequeue pointer commands
Message-ID: <20241017084007.53d3fedd@foxbook>
In-Reply-To: <20241016140000.783905-3-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> Avoid xHC host from processing a cancelled URB by always turning
> cancelled URB TDs into no-op TRBs before queuing a 'Set TR Deq'
> command.
>
> If the command fails then xHC will start processing the cancelled TD
> instead of skipping it once endpoint is restarted, causing issues like
> Babble error.
>
> This is not a complete solution as a failed 'Set TR Deq' command does
> not guarantee xHC TRB caches are cleared.

Hmm, wouldn't a long and partially cached TD basically become corrupted
by this overwrite?

For instance, No Op following a chain bit TRB is prohibited by 4.11.7.

4.11.5.1 even goes as far as saying that there are no constraints on
the order in which TRBs are fetched from the ring, not sure how much
"out of order" it can be and if a cached TD could be left with a hole?

If the reason of Set TR Deq failure is an earlier Stop Endpoint failure,
the xHC is executing this TD right now. Or maybe the next one - I guess 
the driver already risks UB when it misses any Stop EP failure.

If it didn't fail, xHC may store some "state" which allows it to restart
a TRB stopped in the middle. It might not expect the TRB to change.


Actually, it would *almost* be better to deal with it by simply leaving
the TRB on the ring and waiting for it to complete. Problem is when it
doesn't execute soon, or ever, leaving the urb_dequeue() caller hanging.

Regards,
Michal

