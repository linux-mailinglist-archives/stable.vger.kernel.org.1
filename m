Return-Path: <stable+bounces-237753-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPPtCAf13WmGlgkAu9opvQ
	(envelope-from <stable+bounces-237753-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 10:04:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D2B3F6E64
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 10:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 26E62300F780
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 08:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D8138B7C3;
	Tue, 14 Apr 2026 08:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GElbqjki";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2hEywUZ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00E138B14C
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 08:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776153850; cv=none; b=Pd07rbUaGAcFQQFLk7Y3wvmJo1pS/9clI4luvK9/eW9RSiERku2QRMx1SIj/Ez5aNXHuqDLqwmE4349BWMvGYCs8b0+JhvMqCBlQpPpBr3Whdx0s0ja2AtvgZrSHmkH9abCshiZz82QkSMCzfVbSKgwADJgRtJTN1JDlGCGcRFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776153850; c=relaxed/simple;
	bh=Hnyj9T6i6WMrLQZCuxbS1CYUIk9h22kkXtxhKguP4AQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=P+chkEHv12Xbj5IWBS823AgIjDCNsTmUbbvL8ySY90xjRFwkCVzMsmYDqRkl24CPo5o2eFjVQHHzu3ecebG/f21AgVm5R0MLKJ/15jQZ0hpSkr0jWzB8JrZLulK6I2J3ZQonR5F/BJmkiy3QieboB1WP+nRwIQs2dtQqZAd4Wy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GElbqjki; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=X2hEywUZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776153848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dnCO8guhms1mkaeYnJ8PInVTX4vnN/AYoV2EE/jBklQ=;
	b=GElbqjkiXQlv5bon15AZROLiEFE1VFkavY4edRWyv8667X0gT1a6n+cKuACLR5sahmy2NR
	jUSg0eEC3pCLDPv/WWu2kY/ZzG544YMSWlM+PDCQCKxKMe9tcRG3O8xNq6HtTrCq6qzawD
	JknyHxPN2CJaHPU2xaxZ6uXuIPxKRnw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-dm8ovEEkNtmYnNBqFrQMjg-1; Tue, 14 Apr 2026 04:04:07 -0400
X-MC-Unique: dm8ovEEkNtmYnNBqFrQMjg-1
X-Mimecast-MFC-AGG-ID: dm8ovEEkNtmYnNBqFrQMjg_1776153846
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d780757eeso1239835f8f.1
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 01:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776153846; x=1776758646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dnCO8guhms1mkaeYnJ8PInVTX4vnN/AYoV2EE/jBklQ=;
        b=X2hEywUZSuWEYj8o63oPLicG+THFfo9igY4lesM86OG/nuzyVziYX0n870unSDIrdm
         YRTm8wervK7ssK3NOMfjMVTh9ZASGyU9l0JoYa61BNITABmelH7nmmqUvoMscYg7DOwH
         0Im23L6GuSQ9z7GQW+qB1gHMGwvi/weOYJJogOrabtz6LlrctpSfDIyvd037LYQXaf3L
         JjgVPluLbkRmjWaPOtorqR2aLCg7/4F8xydcyIjZgu212ggl8DH6lEtonfXqLX9USHZR
         8VWA7mfY4uW01fjRqFmnrmAa04zvS/E7UjuD9FNBO8EISG7GHtTmFFHHbgMrQbsWW4xa
         q7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776153846; x=1776758646;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dnCO8guhms1mkaeYnJ8PInVTX4vnN/AYoV2EE/jBklQ=;
        b=FrRiPps2soOHGoZxKGKD1Vt4oaAa8TC2KZ/bO6roPlDCm1xDTx4izYKDVDW7+4EHjB
         80jl8Ibn3rJqgyH2zzfNrdB8gk316kC1IJGRX6CmPc7w0ZRT4AxmCcohb1jJDBgqBa8M
         uW/S8Uum6AXqBMZF1FJsK4wy1vYDKb1fBC+0CzWGFWNuqsKyZRS4JQS7sjbEeZYMnwgA
         IeJo+OqLKt4ZQL4oiefA8XaLWf1qcZSiWb/revhlX9d8b6/4hz1NnfWAomyPK5E6nqU4
         o4DURDPXgQzkzgrFNvH43xtw9doe4aelsQqrqeYAQc1Pb9M/N4qcg99TzXUqvWfoYFgn
         pKlg==
X-Forwarded-Encrypted: i=1; AFNElJ/pWJxQupkZuPG2ZTbWifVEEIDJ0SaO8O72BWInGoP20iEqbL9qH3gxk3TKDKuli+HA8QeAres=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU+/cLEvZWuI00VeNuNPdT6uiuooshJ8adhvrERJeuoeLQhuEj
	1nNj1MUEI+sI1m8JBa+u9Q+8pZ4O0i+Z6desb6z7PUYUCQdy27XfM8TnLS6wwMRwenTx22HmYdn
	qeZ2tezg/SdbXsLTobR9WMgikZm5qGQ3cWS0psVuLO9z+8w+LTk/f6Qo7rA==
X-Gm-Gg: AeBDievOleytKgxuWSvfH3AIVv6KG7hUklZB/JQ83/Q2Pcn8l+Y4fo5O59sYvRWESon
	U/t5Ghkx1aQFLQpFGNLsHs8HIHZuQULXPZXYQibe1Se/8/roIX1HoQbRYSs8uJ0pV3ntrPKghoU
	QUmgpia3UVG5trOsRuMXieU3sff60J34M4svacs0dLP4FEVNBoPCe7F7o2PqR67+jxqc3xm67RX
	zS4zzxxskJu60NpbaIPyEiI7dOpkGgP6X8xEi4zN5fIi57mPLc7hKLAJ506qXEnJ5XcmDN7NFMT
	MWLQsKQYUxogqhv1C9EWxssbGOTIrb1P+MIjdvSZeRbz6Uq7cn+rhNx25JuCAoFwhbNPgLfrMwG
	mEALW5D66nkq3gSJXwdSPHdZ2lYLfaZugpA4j9oUYWYOi+kKU86qvmabL
X-Received: by 2002:a05:6000:40e1:b0:43d:772d:2b61 with SMTP id ffacd0b85a97d-43d772d2cb7mr11831184f8f.15.1776153845562;
        Tue, 14 Apr 2026 01:04:05 -0700 (PDT)
X-Received: by 2002:a05:6000:40e1:b0:43d:772d:2b61 with SMTP id ffacd0b85a97d-43d772d2cb7mr11831099f8f.15.1776153844935;
        Tue, 14 Apr 2026 01:04:04 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d7794cce5sm16813327f8f.9.2026.04.14.01.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 01:04:04 -0700 (PDT)
Message-ID: <afc0a3ca-311d-4c6a-9380-98d1b23ea536@redhat.com>
Date: Tue, 14 Apr 2026 10:04:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/3] nfc: nci: fix u8 underflow in
 nci_store_general_bytes_nfc_dep
From: Paolo Abeni <pabeni@redhat.com>
To: =?UTF-8?B?TGVrw6sgSGFww6dpdQ==?= <snowwlake@icloud.com>,
 netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-nfc@lists.01.org, stable@vger.kernel.org, horms@kernel.org,
 =?UTF-8?B?TGVrw6sgSGFww6dpdQ==?= <framemain@outlook.com>
References: <20260409164129.GO469338@kernel.org>
 <20260409185958.1821242-1-snowwlake@icloud.com>
 <20260409185958.1821242-2-snowwlake@icloud.com>
 <5a6a95f0-a26c-4eed-9c9a-98e22c3bc682@redhat.com>
Content-Language: en-US
In-Reply-To: <5a6a95f0-a26c-4eed-9c9a-98e22c3bc682@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,lists.01.org,vger.kernel.org,outlook.com];
	TAGGED_FROM(0.00)[bounces-237753-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_TO(0.00)[icloud.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[outlook.com:query timed out];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[outlook.com:query timed out];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RBL_SEM_IPV6_FAIL(0.00)[2600:3c15:e001:75::12fc:5321:query timed out];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,outlook.com:email]
X-Rspamd-Queue-Id: 11D2B3F6E64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/14/26 9:34 AM, Paolo Abeni wrote:
> On 4/9/26 8:59 PM, Lekë Hapçiu wrote:
>> From: Lekë Hapçiu <framemain@outlook.com>
>>
>> nci_store_general_bytes_nfc_dep() computes the number of General Bytes
>> to copy from an ATR_RES or ATR_REQ frame by subtracting a fixed header
>> offset from the peer-supplied length field:
>>
>>   ndev->remote_gb_len = min_t(__u8,
>>       (atr_res_len - NFC_ATR_RES_GT_OFFSET),   /* offset = 15 */
>>       NFC_ATR_RES_GB_MAXSIZE);
>>
>> Both length fields are __u8.  When a malicious NFC-DEP target (POLL mode)
>> or initiator (LISTEN mode) sends an ATR_RES/ATR_REQ whose length field is
>> smaller than the fixed offset (< 15 or < 14 respectively), the subtraction
>> wraps in unsigned u8 arithmetic:
>>
>>   e.g. atr_res_len = 0 -> (u8)(0 - 15) = 241
>>
>> min_t(__u8, 241, 47) then yields 47, so the subsequent memcpy reads
>> 47 bytes from beyond the end of the valid activation parameter data into
>> ndev->remote_gb[].  This buffer is later passed to nfc_llcp_parse_gb_tlv()
>> as a TLV array, feeding directly into the TLV parser hardened by the
>> companion patch.
>>
>> Fix: add an explicit lower-bound check on each length field before the
>> subtraction.  If the length is smaller than the required offset the frame
>> is malformed; leave remote_gb_len at zero and skip the memcpy.
>>
>> Both the POLL (atr_res_len / NFC_ATR_RES_GT_OFFSET = 15) and the LISTEN
>> (atr_req_len / NFC_ATR_REQ_GT_OFFSET = 14) paths are affected; both are
>> fixed symmetrically.
>>
>> Reachability: the ATR_RES is sent by an NFC-DEP target during RF
>> activation, before any authentication or pairing.  The bug is therefore
>> reachable from any NFC peer within ~4 cm.
>>
>> Fixes: a99903ec4566 ("NFC: NCI: Handle Target mode activation")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Lekë Hapçiu <framemain@outlook.com>
>> ---
>>  net/nfc/nci/ntf.c | 22 ++++++++++++++--------
>>  1 file changed, 14 insertions(+), 8 deletions(-)
>>
>> diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
>> index c96512bb8..8eb295580 100644
>> --- a/net/nfc/nci/ntf.c
>> +++ b/net/nfc/nci/ntf.c
>> @@ -631,25 +631,31 @@ static int nci_store_general_bytes_nfc_dep(struct nci_dev *ndev,
>>  	switch (ntf->activation_rf_tech_and_mode) {
>>  	case NCI_NFC_A_PASSIVE_POLL_MODE:
>>  	case NCI_NFC_F_PASSIVE_POLL_MODE:
>> +		if (ntf->activation_params.poll_nfc_dep.atr_res_len <
>> +		    NFC_ATR_RES_GT_OFFSET)
>> +			break;
> 
> This does not look the right fix: nci_store_general_bytes_nfc_dep() will
> return success to the caller, and processing will proceed even if the
> packet is malformed.
> 
> Looking at the (rather incomplete) error handling in
> nci_rf_intf_activated_ntf_packet(), the latter function should error out
> with EINVAL for truncated/malformed packets.
> 
> You should return a proper error code here _and_ handle such error in
> nci_rf_intf_activated_ntf_packet().
> 
> The same comment applies to the simlar check below.
> 
>>  		ndev->remote_gb_len = min_t(__u8,
>> -			(ntf->activation_params.poll_nfc_dep.atr_res_len
>> -						- NFC_ATR_RES_GT_OFFSET),
>> +			ntf->activation_params.poll_nfc_dep.atr_res_len
>> +						- NFC_ATR_RES_GT_OFFSET,
> 
> Please do not include style-related changes in 'net' fix: it should
> include the minimal delta to address the issue.
> 
> Other similar chuncks below.

I almost forgot: do not send you patches in reply to older revision: it
will foul patchwork and make the review process harder, if possible at all.

/P


