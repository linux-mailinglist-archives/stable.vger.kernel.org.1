Return-Path: <stable+bounces-237741-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Nn0J/7u3Wl7lQkAu9opvQ
	(envelope-from <stable+bounces-237741-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 09:38:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F35223F6B06
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 09:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 134B0304F23B
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 07:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F00032C937;
	Tue, 14 Apr 2026 07:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ciQSk0t0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ByzhRcAP"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E185235E95A
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 07:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776152050; cv=none; b=IvXUHfMtUJr/0muqkixkKnAut4PA+m+1D9EBV2h53q1m97jhW+UuHGBJz5xpuVv5sEP/FPvCt4AM0XKlctyJVRZjqQzO5f8Aok8Pt6lL5iU6IQQ17c4TsBGSNQFJu4U72Rbour5zccf8jostA3tVD2ThvZqJJMhh7D8yZ5Or4Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776152050; c=relaxed/simple;
	bh=aqh8WJxHDWEauEn+j9v1wprgSCpV9MfxjZyXavaAbUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y4PvLG6KR4C6WMMaeDbcq+jJP5cFTsgTU2tmVA2d2jIJ3EgdqSMmBaMaWjv/Q5jtLPENOf8RNMhIKlX3H+XHVsFFC6dtLi5ZFEXEfNFcP4Xq+veC6+rq18EvdROdRY5JZVBwlOgz7fQbeLLTN7V+IuP2RXc83OMm898jSzOokjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ciQSk0t0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ByzhRcAP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776152047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cpuc6/dbxWD2Miqn+fSfBi2oamvnnV+fMmLicOJyE/Y=;
	b=ciQSk0t07KrSPph9zQPdnysXubWbsJcgfAMPKhqhJ5ne9tsL/1rHLIbpqI6TLuifRD7SRT
	TLSKhsQhOwT1Hd/hmAj5ck4QGjgWW7T6qatA10YhhjlRqJzB9qx9S9+vNhxXEuYEpoTHj2
	1hyrcKjqy+Z4xvdTk+RLdc2+8z56ixA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-LOqP9inuMsaM9WzMFYSZnQ-1; Tue, 14 Apr 2026 03:34:06 -0400
X-MC-Unique: LOqP9inuMsaM9WzMFYSZnQ-1
X-Mimecast-MFC-AGG-ID: LOqP9inuMsaM9WzMFYSZnQ_1776152045
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488c74405ecso32000785e9.1
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 00:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776152045; x=1776756845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cpuc6/dbxWD2Miqn+fSfBi2oamvnnV+fMmLicOJyE/Y=;
        b=ByzhRcAP2W6Q5hI/g26UKQVp+ZxdjaGByihrps+LQl0uJPjvuhU+1xON8bg1iwVGxd
         Euke1EcOgO3JyeIubJmlw9Ritzps0wN2uaEVeasJD93hUAAhaYdorNwhOrKSSPrEv2SV
         +2Vny7/D2j6yIk8VVqeTlsHExAHcpWIQVC6vcnukjMQOQtAl6oAi8JV9LJpJfSmNpYrY
         uqa7HcWgMXvyMQqXemSrLyX33J0sE0K/GrHW0tFpxNZf7vGwXWeEQCvZ9zJyZGfFoBm9
         g7Nht6fviTkJ8Sg+NCTjp5GF0Xr3I4TaHy8iqfPyyeHjr+4tTgH0i84dyKrqe16VKntz
         66PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776152045; x=1776756845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpuc6/dbxWD2Miqn+fSfBi2oamvnnV+fMmLicOJyE/Y=;
        b=WP1dwZK/rN98SIqko8IGIZtzuyHbmS8rLJyiNIGDrzdjlh4bw6fz6rc9n2+p3NKtLf
         9l1H7Xn4P8OvETpG7BV3CmRc04gUslJ4KBXaa1vi/RzV+lNPzxq+ytYyTpHfDpdAECz3
         SOrEm5MCAH68OpTrbNsQIxyLezSbJYpP9sVDcyyv63ByKtHVDQPMfTJtDj7Xvtn8G9DK
         x+3TRvwAHMByUzJfzHIpWsfZu3a1mr4B5kFQMouCxj20j0MgnpMj2PvYUllKbbp3x9cD
         dP9u2qcJC65S5qhy3po4TLVk1CKXDlRvLnN7JHWvODDMJnBAIyM+9stXWg21Ox4jF/bo
         yOUQ==
X-Forwarded-Encrypted: i=1; AFNElJ/OY941XKVNiJvy8ilFrEumIoAUZLJrKPKz4E+A70wOLH4Fyz1n93NIrh0SO+3wEhGwnSIMKhk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ldp87Y/sNbJRUqj7WdeOeJr9ApNq4SbeGvwp1QLig74ufoeE
	NvjaftRR6+K+/09B/0YVoPEf/8RRskaSx+g4bMWNJtIj1K4oCrgTi2658EDcmIYUEyo6Fu3g5i8
	BHmlJD2NTP8hrp+XIuAfh4B/M5BN1Vsy06Y0+ITDuDdASIvvIWn/qYxZGOA==
X-Gm-Gg: AeBDietDYWDGiSGH6PUtS3/cgu4CWi+BDMlQyAyFhiS8rQGSkjbZc6ENSItmhM3haRi
	dpJy1WFtn1162yxlDa0L4vGfCcHqtMX+x+a4EK9EM1qn8c0nvdH8v9whQJ35oHVHRnkC5jCAwcT
	1VBTlXIytrICHm+R73erYZFXUvSngfe32H6T9D/ln2iAPtoupch5Clq8n0YuItBNpvoQQoCDhvh
	V5xSgV5EqRvQNAAx8fpdUOoICELGN8eH7Dqt/Zj+A0LQrnAte9h+xu2nOIfmt9IEZlSVBRn/Svx
	di18vanbVZ3FM49nmL37vnNRJpbJCQBQXCUKiJI/y09U2XxvHH7WeW8ETKKqHAv+8c2EwNqtWbJ
	sgswpkZVzD5559Rk+3/yIHlRH5VXHVr9Xuj16/JL7Embjti7iCqLSo6Po
X-Received: by 2002:a05:600c:c117:b0:487:4eb:d125 with SMTP id 5b1f17b1804b1-488d67e370bmr152443885e9.9.1776152045303;
        Tue, 14 Apr 2026 00:34:05 -0700 (PDT)
X-Received: by 2002:a05:600c:c117:b0:487:4eb:d125 with SMTP id 5b1f17b1804b1-488d67e370bmr152443555e9.9.1776152044840;
        Tue, 14 Apr 2026 00:34:04 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1de4asm69695535e9.4.2026.04.14.00.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 00:34:04 -0700 (PDT)
Message-ID: <5a6a95f0-a26c-4eed-9c9a-98e22c3bc682@redhat.com>
Date: Tue, 14 Apr 2026 09:34:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/3] nfc: nci: fix u8 underflow in
 nci_store_general_bytes_nfc_dep
To: =?UTF-8?B?TGVrw6sgSGFww6dpdQ==?= <snowwlake@icloud.com>,
 netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-nfc@lists.01.org, stable@vger.kernel.org, horms@kernel.org,
 =?UTF-8?B?TGVrw6sgSGFww6dpdQ==?= <framemain@outlook.com>
References: <20260409164129.GO469338@kernel.org>
 <20260409185958.1821242-1-snowwlake@icloud.com>
 <20260409185958.1821242-2-snowwlake@icloud.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260409185958.1821242-2-snowwlake@icloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,lists.01.org,vger.kernel.org,outlook.com];
	TAGGED_FROM(0.00)[bounces-237741-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[icloud.com,vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email]
X-Rspamd-Queue-Id: F35223F6B06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/9/26 8:59 PM, Lekë Hapçiu wrote:
> From: Lekë Hapçiu <framemain@outlook.com>
> 
> nci_store_general_bytes_nfc_dep() computes the number of General Bytes
> to copy from an ATR_RES or ATR_REQ frame by subtracting a fixed header
> offset from the peer-supplied length field:
> 
>   ndev->remote_gb_len = min_t(__u8,
>       (atr_res_len - NFC_ATR_RES_GT_OFFSET),   /* offset = 15 */
>       NFC_ATR_RES_GB_MAXSIZE);
> 
> Both length fields are __u8.  When a malicious NFC-DEP target (POLL mode)
> or initiator (LISTEN mode) sends an ATR_RES/ATR_REQ whose length field is
> smaller than the fixed offset (< 15 or < 14 respectively), the subtraction
> wraps in unsigned u8 arithmetic:
> 
>   e.g. atr_res_len = 0 -> (u8)(0 - 15) = 241
> 
> min_t(__u8, 241, 47) then yields 47, so the subsequent memcpy reads
> 47 bytes from beyond the end of the valid activation parameter data into
> ndev->remote_gb[].  This buffer is later passed to nfc_llcp_parse_gb_tlv()
> as a TLV array, feeding directly into the TLV parser hardened by the
> companion patch.
> 
> Fix: add an explicit lower-bound check on each length field before the
> subtraction.  If the length is smaller than the required offset the frame
> is malformed; leave remote_gb_len at zero and skip the memcpy.
> 
> Both the POLL (atr_res_len / NFC_ATR_RES_GT_OFFSET = 15) and the LISTEN
> (atr_req_len / NFC_ATR_REQ_GT_OFFSET = 14) paths are affected; both are
> fixed symmetrically.
> 
> Reachability: the ATR_RES is sent by an NFC-DEP target during RF
> activation, before any authentication or pairing.  The bug is therefore
> reachable from any NFC peer within ~4 cm.
> 
> Fixes: a99903ec4566 ("NFC: NCI: Handle Target mode activation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lekë Hapçiu <framemain@outlook.com>
> ---
>  net/nfc/nci/ntf.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
> index c96512bb8..8eb295580 100644
> --- a/net/nfc/nci/ntf.c
> +++ b/net/nfc/nci/ntf.c
> @@ -631,25 +631,31 @@ static int nci_store_general_bytes_nfc_dep(struct nci_dev *ndev,
>  	switch (ntf->activation_rf_tech_and_mode) {
>  	case NCI_NFC_A_PASSIVE_POLL_MODE:
>  	case NCI_NFC_F_PASSIVE_POLL_MODE:
> +		if (ntf->activation_params.poll_nfc_dep.atr_res_len <
> +		    NFC_ATR_RES_GT_OFFSET)
> +			break;

This does not look the right fix: nci_store_general_bytes_nfc_dep() will
return success to the caller, and processing will proceed even if the
packet is malformed.

Looking at the (rather incomplete) error handling in
nci_rf_intf_activated_ntf_packet(), the latter function should error out
with EINVAL for truncated/malformed packets.

You should return a proper error code here _and_ handle such error in
nci_rf_intf_activated_ntf_packet().

The same comment applies to the simlar check below.

>  		ndev->remote_gb_len = min_t(__u8,
> -			(ntf->activation_params.poll_nfc_dep.atr_res_len
> -						- NFC_ATR_RES_GT_OFFSET),
> +			ntf->activation_params.poll_nfc_dep.atr_res_len
> +						- NFC_ATR_RES_GT_OFFSET,

Please do not include style-related changes in 'net' fix: it should
include the minimal delta to address the issue.

Other similar chuncks below.

/P


