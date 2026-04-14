Return-Path: <stable+bounces-237757-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mO8NH3n43WlTlwkAu9opvQ
	(envelope-from <stable+bounces-237757-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 10:19:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA523F7182
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 10:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F7EC3078483
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 08:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD2939021B;
	Tue, 14 Apr 2026 08:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SvBAVnZG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ma7Cw+FC"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7447A396596
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776154296; cv=none; b=JADzvIbKGTNsARSTDSvhR0H9CYPHwb+mX8KOhvZJLwBLlYvcHyOWkQDQUVri/XY8DzAN1QxPAMbIx4/ZQk78H1L2neDZBkfYnlvXf+dr6CUUhBze6tJ2HxbRcGT0ITZafdfNp/3iG2i79Z4HwNgYma8EMFwTtIvgrxla1jiB5WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776154296; c=relaxed/simple;
	bh=KNX8XC2wwGGxkUDIXlaj5gfOeGdyv0vM3lCH+V3fHjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T0G1m0La2w1faeKehkGg4LAxOfjApejvmCiwE9gN2og/Pvski37vIb+eU8jzqc95syiTa70uPwdXD5NqwF3MCNyseP3RFOsJKupdrARlZ6jVhyJt4OAxSjdXBTJnB7XRx6ZSGcGiKjjdW74VRGrRa8qfcZi5gUKYD4j+flpK5Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SvBAVnZG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ma7Cw+FC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776154294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3RGbJ4Sp4gddtOIlLGrNwEQ3NrcedSvoP4IH+GVcGuM=;
	b=SvBAVnZGoZmk0C4JuZyOEA0cQtH7f6+7y5SdcPvGSysWQltZKtCQs/CjNMqDj31YdSBTo3
	UH5R7uZyTYFKHSN2+08GMdBM1FZSSPEb7bf7vf/kV1b2SY/+HsJAqSf2LrZjkHaiNkOSoA
	lDQBJmViiSy7a0z1Nb59M4p2M/eJ9Zw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-xXsGTlqVMVeyEJgcHI7DYw-1; Tue, 14 Apr 2026 04:11:33 -0400
X-MC-Unique: xXsGTlqVMVeyEJgcHI7DYw-1
X-Mimecast-MFC-AGG-ID: xXsGTlqVMVeyEJgcHI7DYw_1776154292
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488c0fcc6deso32940215e9.2
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 01:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776154292; x=1776759092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3RGbJ4Sp4gddtOIlLGrNwEQ3NrcedSvoP4IH+GVcGuM=;
        b=Ma7Cw+FC/MTL62v9ClqZjOWN/wVGdu8qF9+Bm9KF6VfOf1ZKN5MGmqHBQJizY2sits
         nmAITPNgwCW1W9jQDVCyehXtlZ77lEqHF3SEEYpjZ+Pc5urh1YlhaOLmfqRuePLHnFef
         02KhTrG926mAx50aR8hceGxoICD3Qk1VWDezP2kOcSU42lzDXQttr5ttryqqK+8KXLCs
         FZhyRvSWSqgyNAcO19n9e+jYtgQEZW/xYad+zCyT3jnG56v4UzfUeSi0O1Yp98/71gl+
         7q7z3CwxXca9UfYmwimn3vWVjJ2cZu+EhInhTmvAVfpT4+BrF5+mqBLYu2AtoxnrWeFI
         iZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776154292; x=1776759092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3RGbJ4Sp4gddtOIlLGrNwEQ3NrcedSvoP4IH+GVcGuM=;
        b=AvB1qm1ch4/CO8vqyOXW+x/zOGydx2omh7IQ7AMV+YtAFCzu+PyAIP+v+kxm6RDkZZ
         GTg9VD8NcCp5s1w5XUs3wFjI8lr/ltSi0n3DIWJs3gRKgP4BapyffY4h4Ez8Bv17VTYN
         GMwtFOxjZsN90xLemff7ZTXmyYVWV7vBWxAsHYKFP2uVu/DuV0Fom2hNb4vSk39rkCen
         QUeXp4i1VDsvGLUN5v7S6os0cXEwtLEvEMb/A/B04yUcD7tXEIyfy0MT7coYtHrP3/6S
         chn/hvIhHWzCjyHxoClJseuEl+yfSawhxIGsc9vJxx8mQ3hxRzZkoDfLwuFUYMqUq9m5
         2vhQ==
X-Forwarded-Encrypted: i=1; AFNElJ/IjIpJIKLLBVYASLacE4hNWXOaG9y16JO51En+kkw41UFBGuzUDCpPpkyHyVPTUeIpflAp4OE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHMpQDCMqcCuyCxt8Np9G8e6QBWY0JMRFDTHbZLp8ta0H33kc3
	3/ymDPLkNZkZY7jS0AHUE9QrKRhJ3I8khWY2L1TeUcHL+ZLaxO/oMyhsrEOVTPM2RXNWWhbzR+d
	xCYF7gyuJx6Z4S4NK9Dzh3uXmY78vOyxYNmtdyTxKr7DU2kpt/JS3FCQNAA==
X-Gm-Gg: AeBDievfA4389nO9QsarR9m8ZLjybJUrIXsDa5eSKSzob9iOUMaZ7PQLGoQWnYF455n
	AVq8ULyt5ISkgfh3r+V47f8LDgxB7hJ4JXeApL/jVMoWKjDtTFpjPAYz9lFCl28KzQiYGdsNQjr
	gkkSZs0vyb2bGMOdihVQK6kG/DyWQeyGtXazFwBhKZg1ph+siASrhW7dsnnBTvb6ho2rKHFpha3
	Z1r0GLiTgiLbp9O5028QPMWiv2WNq3WV7rCBIHfygRwGzCRSmRrH9fED54FtzsxVF3+89+yRVC9
	7JlK+4TWv0umHVMh0etm24jf2cahrn3X6OHz+FkuBYvTumkcb3udIvikFF++t5Q6/lIqpt5nIQc
	t26GhEpyoKuVW703rVtgIe6IAI0zM15T6OvW0mBEa7JTjOgKbbobSicln
X-Received: by 2002:a05:600c:8710:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-488d67bbd1dmr239712865e9.4.1776154291914;
        Tue, 14 Apr 2026 01:11:31 -0700 (PDT)
X-Received: by 2002:a05:600c:8710:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-488d67bbd1dmr239712395e9.4.1776154291367;
        Tue, 14 Apr 2026 01:11:31 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ee042ff9sm35610945e9.14.2026.04.14.01.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 01:11:30 -0700 (PDT)
Message-ID: <6191cfae-db06-4a4c-8e82-7e17ba0ffa6e@redhat.com>
Date: Tue, 14 Apr 2026 10:11:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/3] nfc: llcp: fix OOB reads in TLV parsers and PDU
 handlers
To: =?UTF-8?B?TGVrw6sgSGFww6dpdQ==?= <snowwlake@icloud.com>,
 netdev@vger.kernel.org
Cc: linux-nfc@lists.01.org, stable@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org
References: <20260409233517.1891497-1-snowwlake@icloud.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260409233517.1891497-1-snowwlake@icloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-237757-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[icloud.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:url]
X-Rspamd-Queue-Id: DEA523F7182
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/10/26 1:35 AM, Lekë Hapçiu wrote:
> This series fixes three out-of-bounds read vulnerabilities in the NFC
> LLCP layer, all reachable from RF without prior pairing or session
> establishment.
> 
> Patch 1 adds missing TLV length bounds checks in nfc_llcp_parse_gb_tlv()
> and nfc_llcp_parse_connection_tlv() — a crafted CONNECT or SNL PDU
> containing a short TLV value field can read beyond the skb tail.
> 
> Patch 2 fixes nfc_llcp_recv_snl(), which accessed TLV fields and
> performed arithmetic on an uncapped length byte before any bounds
> check, enabling a 1-byte heap OOB read and a u8 wrap-around.
> 
> Patch 3 fixes nfc_llcp_recv_dm(), which read the DM reason byte at
> skb->data[2] without verifying the frame is at least 3 bytes long.
> A 2-byte DM PDU (header only) from a rogue peer triggers a 1-byte
> OOB heap read.
> 
> All three bugs are independently triggered via RF (AV:A, AC:L, no
> authentication required).

This series looks like an older iteration of:

https://patchwork.kernel.org/user/todo/netdevbpf/?series=1079400

but it reached the ML 2h afterwards?!?

At very best you have some serious setup issue. Please have a look at
the repost policy and especially at the 24h grace period:

https://elixir.bootlin.com/linux/v7.0/source/Documentation/process/maintainer-netdev.rst

And, given the above problem, please do not share any more patches for
at least 48h.

/P


