Return-Path: <stable+bounces-240075-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBB8BiQw52n45AEAu9opvQ
	(envelope-from <stable+bounces-240075-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 10:07:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EA5437F62
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 10:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5290E301DE33
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 08:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8FF392C2E;
	Tue, 21 Apr 2026 08:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="goHzfhOS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qXaYVknh"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230D23845AB
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 08:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776758787; cv=none; b=Lw3JOqCYn6JH/59WEHeBeZbXRCBlttkptL0G5RDiDMkaCt/dCrJJoUxYzmS2Y3zyRFKrPRhhuUryRxlRqTdUjx84Up2ZpA8xtFbm5jZ9dprlKuSDb4Nmtx3lte/89H5K4SHQh8jrWjE/Hs2ukAwvDQYSa2bFJIYx1ypj6ISz5aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776758787; c=relaxed/simple;
	bh=e7Rjwd7SKC3JCE1r3bzlgsB+NQDnlUAt08czbeTk15E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=teEbrMrQxoZ5y+tv/ihGCyd5upkjfW7Vvscl3I3zP21GIDGdDuOUPwM7AlvkZtzHIT9PHsNiOK3q52g504a0beWj3NI7QtaI6DwBAkdXaoi0XLj1bY9EN0zbtyutereAmMY2FC4dR8Q3JeL2SKil5MY23r3EEPZSQ4pFQKzcoMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=goHzfhOS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qXaYVknh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776758785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n4VYRTerbgJpYYNTYNae/DVdSlYgLqLpvyQvIaghOhc=;
	b=goHzfhOSYu22yI99Ej+Mqi0jOl6nBuX/ZeiGAuFvNCiaNx0fZboc527QhHcCRHT66QwLrY
	e3nddY7nEQ3cOoTXWzqe4WntnI3A9TeS1Af71iZ3ZlxqxLsva18e//4FhFutGd33yI+cD6
	Y/5/cD4w0EZyn0GzEobybVE680Y0PnU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-jjnmgFonN-Ctv9TVzUiJdA-1; Tue, 21 Apr 2026 04:06:23 -0400
X-MC-Unique: jjnmgFonN-Ctv9TVzUiJdA-1
X-Mimecast-MFC-AGG-ID: jjnmgFonN-Ctv9TVzUiJdA_1776758783
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488d9e1e61aso32769155e9.0
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 01:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776758782; x=1777363582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n4VYRTerbgJpYYNTYNae/DVdSlYgLqLpvyQvIaghOhc=;
        b=qXaYVknhuq4HgCXJXDdnByME1K7P5+0YWQqKbQbMh+43i+hyGj0L2DTyEaVjGZbBfo
         mMd8MeeUWL+FsxqlIRpVUV2PwxFgphE18G2ea+8WiTlAjfJclwMvtGvT1PeozxBXF8jW
         aIUOBqYKCQXSKMkvO+iuEjpzRFosqJc3R6DjPZ/u7KqoOy1anfjaMcbTL05Bicwf42+3
         llGHu4IXMer1BgNWPl/juUBlem8VzFBqJkAmsZGqNS7pKTVV3q0btuJv9w9h5q5RdPqP
         jaf/uOz7Em+LqbkPHfSGwYB3fCDu/jJQf1YTHLNdd1fDs51Q/AvKO7JPz4xiKumsb76Z
         4tMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776758782; x=1777363582;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n4VYRTerbgJpYYNTYNae/DVdSlYgLqLpvyQvIaghOhc=;
        b=h3Y/+vT1jY04APoNq7nuNwyORKM9KPP/0DUeWPNnlr7eps83Hn0D90byJ6khqvA9gs
         F/SjssEJpQYIu3ONtkvM/JtQARqHXpisKFsZBGC9BkXf/QC+5wjn89v5D5ZYTy96EmwJ
         FEo4QTPtkFK5u77VEUHAvJRlVgGxmM5Q7nxRcIuSaYdsiQIc9WV2QZuBmnSo0AbpgtMD
         Yn4CPHEHNoOO5LWQMFYb2AtZp0mLAeCjPxgzrXTk9IEVMhkbnOgCvgQsKad3GVktRwkQ
         cbcI/037QImIGLAk9RqP3JQgQJe6KQ+jgazKNcfZioVXpiyXfPtoDAj2sdCfk0xcseF0
         imvQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Kad6kLtc0mH2wGrtjHdCIMrpnGPy0rBkbfB1/pivIEok35DQe5V4xNcuw7lmxogpJgD1Kt2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Wa7GiT1xaWaEqeAej1YQIXNeVHcJB+jrVgS6zJJ+R2S5OKxc
	Frm3z4jMTtHjF/Rp8fs5erXzogCLhsXtRolg3wE91x0K9UT5Cbgv+86cvuI/m5R4TjiIEjOery3
	Vz3pLKPyaT0hfpQxa7pvo186q+n7ahDd6q8YJaGHwbab0QahNEdHDkb8isw==
X-Gm-Gg: AeBDiesjHCDIZmmG/Fm47AzM5bMqGdh9o0zyiLAQk6lyZ6jj1zEgVx/zq1YsbbBzunY
	sDOuKlI5vYCS9/FftJlfWpNYTcWoJ/6SrvfD4mnvo8gnOMdjMRyGKQarJcptJYwfTpUiMtupW/y
	1QJBL/gFMmLLT1kngt6owSuW2Zk0gB+c7X4X92zU+4Mdama2bdBzYv+F65y36zv++8uzRAA0QgX
	zoVj9IJQcGlvRfopyfZdvjurAfMpXsN4tvz8uITchht6NUoMMYC11jepdWLOhhfxQd2zR4oC3h+
	8lqfN73iU3RX/msKI7/dVFs745mHFH8kuZK/CZPWNxs2HxvVGq4LElXlJZO1Ed5wynmoXbpLSge
	7SCxV7PPZt2VC+h/bjoSFRb3MD94tPTdDjTk8lyNOZi6cc691PrB5I25bQvp8fjA0KyQ=
X-Received: by 2002:a05:600c:a416:b0:488:90ac:8f71 with SMTP id 5b1f17b1804b1-488fb73a9fcmr197846355e9.5.1776758782299;
        Tue, 21 Apr 2026 01:06:22 -0700 (PDT)
X-Received: by 2002:a05:600c:a416:b0:488:90ac:8f71 with SMTP id 5b1f17b1804b1-488fb73a9fcmr197845655e9.5.1776758781704;
        Tue, 21 Apr 2026 01:06:21 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.104])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891cdfcd50sm50901715e9.9.2026.04.21.01.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 01:06:21 -0700 (PDT)
Message-ID: <5e3ad2a0-cb66-4a36-bb83-629b3a9eeb2d@redhat.com>
Date: Tue, 21 Apr 2026 10:06:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net] nfc: hci: fix out-of-bounds read in HCP header
 parsing
To: Simon Horman <horms@kernel.org>,
 Ashutosh Desai <ashutoshdesai993@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260416051522.4154698-1-ashutoshdesai993@gmail.com>
 <20260418163024.GH280379@horms.kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260418163024.GH280379@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-240075-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: B2EA5437F62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/18/26 6:30 PM, Simon Horman wrote:
> On Thu, Apr 16, 2026 at 05:15:22AM +0000, Ashutosh Desai wrote:
>> nfc_hci_recv_from_llc() and nci_hci_data_received_cb() cast skb->data
>> to struct hcp_packet and read the message header byte without checking
>> that enough data is present in the linear sk_buff area. A malicious NFC
>> peer can send a 1-byte HCP frame that passes through the SHDLC layer
>> and reaches these functions, causing an out-of-bounds heap read.
>>
>> Fix this by adding pskb_may_pull() before each cast to ensure the full
>> 2-byte HCP header is pulled into the linear area before it is accessed.
>>
>> Fixes: 8b8d2e08bf0d ("NFC: HCI support")
>> Fixes: 11f54f228643 ("NFC: nci: Add HCI over NCI protocol support")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
>> ---
>> V4 -> V5: fix whitespace damage
>> V3 -> V4: add Fixes tags
>> V2 -> V3: drop redundant checks from nfc_hci_msg_rx_work/nci_hci_msg_rx_work;
>>           remove incorrect Suggested-by tag
>> V1 -> V2: use pskb_may_pull() instead of skb->len check
>>
>> v4: https://lore.kernel.org/netdev/177614425081.3600288.2536320552978506086@gmail.com/
>> v3: https://lore.kernel.org/netdev/20260413024329.3293075-1-ashutoshdesai993@gmail.com/
>> v2: https://lore.kernel.org/netdev/20260409150825.2217133-1-ashutoshdesai993@gmail.com/
>> v1: https://lore.kernel.org/netdev/20260408223113.2009304-1-ashutoshdesai993@gmail.com/
>>
>>  net/nfc/hci/core.c | 5 +++++
>>  net/nfc/nci/hci.c  | 5 +++++
>>  2 files changed, 10 insertions(+)
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> Review of this patch at Sashiko.dev flags a number of related problems in
> this code. I believe none of them introduced by this patch. And that
> they can all be treated as area for possible follow-up.

I agree that the issue reported by sashiko:
---
Does this patch fully resolve the out-of-bounds access?
Looking at the beginning of nfc_hci_recv_from_llc(), the code accesses
the packet header before checking if the skb has any data:
net/nfc/hci/core.c:nfc_hci_recv_from_llc() {
    packet = (struct hcp_packet *)skb->data;
    if ((packet->header & ~NFC_HCI_FRAGMENT) == 0) {
        skb_queue_tail(&hdev->rx_hcp_frags, skb);
        return;
    }
    ...
}
If a maliciously crafted 0-byte payload is received, couldn't this
result in an out-of-bounds read of uninitialized memory?
Furthermore, if the fragmentation bit is clear and this 0-byte skb
is queued, when a subsequent final fragment arrives, the reassembly
loop calculates the message length:
net/nfc/hci/core.c:nfc_hci_recv_from_llc() {
    ...
    skb_queue_walk(&hdev->rx_hcp_frags, frag_skb) {
        msg_len += (frag_skb->len - NFC_HCI_HCP_PACKET_HEADER_LEN);
    }
    ...
}
Since NFC_HCI_HCP_PACKET_HEADER_LEN is 1, wouldn't a 0-length fragment
cause this calculation to underflow to UINT_MAX, leading to an eventual
skb_over_panic() when skb_put_data() is called?
Would it be safer to add a pskb_may_pull(skb, 1) check at the very start
of the function before packet->header is accessed?
---

is pre-existing but it looks like the validation included here is almost
ineffective without addressing the above.

@Ashutosh, please include the additional validation in the next
revision, thanks!

Paolo


