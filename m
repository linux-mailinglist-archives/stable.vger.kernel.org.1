Return-Path: <stable+bounces-241672-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMjnCd678Gn+XwEAu9opvQ
	(envelope-from <stable+bounces-241672-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 15:53:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD474864ED
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 15:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1CFED303BBCD
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 13:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4A5370D55;
	Tue, 28 Apr 2026 13:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BCeDG8v1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NgBl7ncg"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF0B2D77E6
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 13:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383994; cv=none; b=JzxxwYNblPGfHHI++RVJs7q723Rn68GwqwEGmlwnokjhHLCMYbNR8Ep9ZjTvWIN5a2CTAg5FHpcPgHY2AC6Fqls6Y53t9U2Wj/8DP+JsppMMhFpomMxuwfpTEwoDhcBnweXSgc88ITQmmnDx8kXWjxFY+Eg8BorGkd9oRZX8GqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383994; c=relaxed/simple;
	bh=ISx7idAXFVml7pFBtXS5rUkfsRUGFlW6Ayw82sBvLBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LnQ2y2/p5LRNjjezvGUlpk/aw4lZAB8XLkuaiXWJAgRL9++r8a9yBhp0lAs/foS4dgPO2E1vRHd2UTg1lpcYVzBsWrELmCri5cbAIlKWR7VPmuL7AIRtDYjTNw/xF1d133dGxJucJVdUBjoZnbaI2rJAyUbd81cbXDGbuVifLXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BCeDG8v1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NgBl7ncg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777383992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/HxwQoc27jCWUPEYETiGXOCCxkg0A85sch0NHG8e6eE=;
	b=BCeDG8v1LVfyeCvJIa45+SIh5J6xiZ2/gYzL28qAa9qmuNtglnm4taFyfQ+zd0WCEGEnaQ
	eq4tJl2mh0YWGy22wZ8jrd6Gl6Vr3ci0H+BokD0rBAFz/XZ8zRtQHpGZeTFsriebKW64xq
	R/JytuMsqaitxdJGxxv2oIgE/m4+nwE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-ZzoVOq7OOiOoHmD36wOrtQ-1; Tue, 28 Apr 2026 09:46:30 -0400
X-MC-Unique: ZzoVOq7OOiOoHmD36wOrtQ-1
X-Mimecast-MFC-AGG-ID: ZzoVOq7OOiOoHmD36wOrtQ_1777383990
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4891f97aef0so54524895e9.2
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 06:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777383989; x=1777988789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/HxwQoc27jCWUPEYETiGXOCCxkg0A85sch0NHG8e6eE=;
        b=NgBl7ncgAo52Z0zFZIja2GJqL/3tGHQyRKJfhsObsO/68NE8ZhbTH8N8ZiLSbSTB+H
         HvV6GNTLJGeT4olyuRcR9qp2tnzV31qpvazzFgUgzullGeirxOeBzA9REvf9/eZZ4Yxu
         ELxHsuedeeLWxiWYwy67R42HnWXUa+ccdjHynCe18AhPXNKr8puWPjyrdtq2+SP/qvKe
         CRXoMki42QSQgufUd+xJm5Sh25jJpSJL7QgLXGrZtqur0P2taH+TUNubP4R6IdSWty6m
         LqeZ9qZMS2ebgNChQCk5YLmzxoUdXulGcJKWNAzpUZjlHRf/zY5cLLlTT/c4XASKQi85
         4hLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777383989; x=1777988789;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/HxwQoc27jCWUPEYETiGXOCCxkg0A85sch0NHG8e6eE=;
        b=CO8fImLa6xz+h+OFhqMDw82SIUj7ECbXreEGpkPAl2lNR2qUBNQlrECqxUUZt4iR23
         hmPLigR6ZRGni6TTtDtUTftrNKBKnopp48C6I7th+pSfZ8hoRSeC8szdwdUCpWt321IN
         eY/dKRCm/1ZDK6zXl/y4oLimQWBZPabOZVaVTq+shLQSHuAWpCdBKWx2qaaw2MIKgs8o
         Cmbr33C4EUMY226nePTc1XXVJBp5QlzuFMFy5iova7ZKaoWuC4jcEj9dhGgqud7FW92U
         Y0tffnbbItXvWz8b7CQe2A4V9zCKtp7mcHbUhBWiskLK9kFR99BL1cAoa8NnOYvhHHWc
         U/yw==
X-Forwarded-Encrypted: i=1; AFNElJ/QOFtJIWk0nqldmO0HKdepvaCNbhUIE/03FuS2iMjWJOo0xCCiKBNKzaOgPFglJhh3FUxZSuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzII7jt/HMsKNzNG0ME3ppaMmaBV6QrolSPxu5ciZP7A3CVrwq8
	lX3bVw7PgRhbw4IFeuwadLHs/AEWtaPLC2srXyZEgGxCqt18WJ2MvQf9tZsIGAjmKRhcSWcrr5f
	MLzvoZVPK1GQJpEFc/8uY4IPFNrLUVpb0ehkclSDtWOw08Ci3W7aGMCFUDg==
X-Gm-Gg: AeBDieuH6C+iUfslaYkoXclzOBbhOSoKwozv2rjuHxx8iz3uHsT9nPuujfxUovkcwBT
	+fLqD/TdmrIDxtlz6X/4BI+bs7kDoEzYlGvvfjAekKjS/1RVtpc+bDAZ4TlBiXkhk6d0CVxn0g0
	yHtttILvYBxbKUJh0OFl+ZJ4K5QjRJX7wkx1YELaVZputQVfCjGfD+mJA2pLa46Rwlk/sNVDWYk
	4YICHQ/jFSwPC+q+9xyTHCGZmS5j1+yeBB3UxFH/hQqD5hayfMN55UFrkva7thL05Ypk0kGUOBT
	HNKzHGZCiFGIcTTv8GLgllCoa4tSZKCVRDMznDh2GoFADgk07CyQNz+c611bvmfnxegJjYlUEpN
	3tOGRLbu4FCWEDoAa3ZXPaytTsT+pHtDTSJ06CVLMi4omVVLnFQQDpghfl47TXkEknA==
X-Received: by 2002:a05:600c:1d0a:b0:48a:5342:36b5 with SMTP id 5b1f17b1804b1-48a77b1e8b0mr53199185e9.21.1777383989440;
        Tue, 28 Apr 2026 06:46:29 -0700 (PDT)
X-Received: by 2002:a05:600c:1d0a:b0:48a:5342:36b5 with SMTP id 5b1f17b1804b1-48a77b1e8b0mr53198675e9.21.1777383988888;
        Tue, 28 Apr 2026 06:46:28 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a773a870asm64053465e9.1.2026.04.28.06.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 06:46:28 -0700 (PDT)
Message-ID: <3f34146d-f719-4a65-8906-4fc08bc91c22@redhat.com>
Date: Tue, 28 Apr 2026 15:46:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 0/5] nfc: fix multiple OOB reads in NCI and LLCP
 parsing paths
To: Simon Horman <horms@kernel.org>, =?UTF-8?B?TGVrw6sgSGFww6dpdQ==?=
 <snowwlake@icloud.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, krzk@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, David Heidelberg <david@ixit.cz>
References: <20260424180151.3808557-1-snowwlake@icloud.com>
 <20260428125523.GQ900403@horms.kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260428125523.GQ900403@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BDD474864ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-241672-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,icloud.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]



On 4/28/26 2:55 PM, Simon Horman wrote:
> On Fri, Apr 24, 2026 at 08:01:46PM +0200, Lekë Hapçiu wrote:
>> This series fixes five out-of-bounds / underflow bugs in the kernel NFC
>> stack.  All are reachable from a remote NFC peer that the local stack
>> has already associated with; in the LLCP cases the peer only needs to
>> send a malformed frame.
>>
>>   1/5  nci: u8 underflow in nci_store_general_bytes_nfc_dep() lets the
>>        attacker-controlled atr_res_len skip the GT-offset subtraction
>>        and cause an OOB read/write against general_bytes[].
>>   2/5  llcp: parse_gb_tlv() / parse_connection_tlv() trust the TLV
>>        length byte without checking remaining buffer, and the tlv16
>>        accessors read past the end when length < 2.
>>   3/5  llcp: nfc_llcp_recv_snl() has the same TLV-length trust bug, and
>>        its SDRES handler uses an unbounded "%.16s" pr_debug() that
>>        walks past service_name_len.
>>   4/5  llcp: nfc_llcp_recv_dm() reads skb->data[3] without checking
>>        skb->len, giving a 1-byte heap OOB read.
>>   5/5  llcp: nfc_llcp_connect_sn() walks the TLV array with no length
>>        validation; a crafted CONNECT frame drops it into OOB reads /
>>        an unbounded service-name pointer.
>>
>> The series applies on top of net/main.
>>
>> Lekë Hapçiu (5):
>>   nfc: nci: fix u8 underflow in nci_store_general_bytes_nfc_dep
>>   nfc: llcp: fix TLV parsing in parse_gb_tlv and parse_connection_tlv
>>   nfc: llcp: fix TLV parsing OOB in nfc_llcp_recv_snl
>>   nfc: llcp: fix OOB read of DM reason byte in nfc_llcp_recv_dm
>>   nfc: llcp: fix TLV parsing OOB in nfc_llcp_connect_sn
> 
> Hi,
> 
> My only feedback on v4 of this patchset is that somehow the
> threading is broken: each of patch 1/5 - 5/5 should be a reply
> to the cover letter - 0/5 - but that does not seem to be the case.
> And some tooling, notably Sashiko, seems to rely on the
> entire patchset being contained in a single email thread.

Given the above, I suggest re-posting.

Also note that we are moving NFC to a specific subtree, see:

https://lore.kernel.org/netdev/938496c6-84c1-4d53-bb56-73bbd7b2bdd7@ixit.cz/

please wait a bit for resubmission, possibly David will be already ready
to catch them.

Thanks,

Paolo


