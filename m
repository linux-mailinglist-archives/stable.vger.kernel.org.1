Return-Path: <stable+bounces-253735-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELjNADgpEGpQUQYAu9opvQ
	(envelope-from <stable+bounces-253735-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 12:00:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A173E5B1924
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 12:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 399CE3032F63
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 09:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502083905E4;
	Fri, 22 May 2026 09:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BW84dCJB"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747AB3BB132
	for <stable@vger.kernel.org>; Fri, 22 May 2026 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779443802; cv=none; b=qb4rJuc/77rWmQRffq9yOyZ7oXkXQUlSM2/sY93H4jLzzxDarTjS6JSPqRZP2R2fPFtBmkrX/satWJCuJgAsYj9WiL0mhy6IMMtzeInmXI28S63PxXp6m3qfR1tl+zHoJvhjkMQBBZfXu/tzGO/Yh8kuy/IwZR3VkbftYl/G8qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779443802; c=relaxed/simple;
	bh=+9CkvQvwITcHVUaiqsGONkFkiD8T7xTmKd6scWLoWao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m3kMbDgubdA9nGzbjACXtDA97jhKyyU1MFaOYqaM3rOwAm6RpNaA07/XV68QMwETTP6cQGuUrf3WbzNNOsMOcLf98WjQwy/OG4Do0L36nMOPFpYxBqnvVTDx8QlbFvRHyLnebXyB1pfOMGNaMCNxzCNMTWoRq69b60M4T07Yh9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BW84dCJB; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38e97e73234so63108861fa.1
        for <stable@vger.kernel.org>; Fri, 22 May 2026 02:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779443798; x=1780048598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u8y63JRIZrYdcs199ekWdJMzEhRGTikpYaZ3eKttq4U=;
        b=BW84dCJBX1gMHJS+u1ZDWod+KbJ0Eo5R5ziRIeKClZ4tRGBdQP1zH4vgPhkx/hIEBn
         hsbaexZCSuURDhXycLRNRDJcm8PmDve3M+Oq+VNaOX8yElHr6agHKiDTCyQeubO3yURM
         QiTJ5vdwFhR5cebj6MpJIMd/cz367C9teECI0TbeipFadJw5xkB4NxOyD98KJ50KJWSU
         tPXRkWeAGw1p6YYnulCAuMqe3xfX8HgmGYpvV23m8ZZr9lZrejl65LERVZAlD6TlrW5Y
         4YsdzKVouHrMl+X17ukvywJG2haLCZOE/hlZNdze5AAQEbHz69OXfGhZsR8nTDk5yw/8
         3v1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779443798; x=1780048598;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u8y63JRIZrYdcs199ekWdJMzEhRGTikpYaZ3eKttq4U=;
        b=JQ3ALuAWy0tUevh2AzlOHVGvzbuMkPIaB2ExSO2kbv+CiY6to6AjLBCVSOx62CrPIg
         6YiMhjYeQnwromLroO0ClhnqQhtPLF8cs0/VQLqvNncbzUi49Mmi6M+tzXz66lHsRbea
         un96OpccjPVnhIE0uf//JovPQk2Ih1gQhcCb+XYrxdpHhrnSTtDvp4ralxgd8pVbLXLE
         4fxXZPm4aGTbAp/DzBTpHE9QtiDnMSTC9wi9clVz1man4S+/SuMUUO0rAThVK2TJ6WM9
         Zirb51hSFqtQbmXYXmTVgCoD93SmY3eIPDwmCb4p0KghDPdGSIYShjJDWgsWELdLS223
         CDAQ==
X-Forwarded-Encrypted: i=1; AFNElJ/6o+X/ske61ha8/Txj9Ms5AbcgO4lzlFCIM8ra2yIXhfvf9C8RzugEOki3uXa31xQoAm2cPys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK5v1YAtrn7Fe7gRt+vyvZ8VcGS6PVXj2pUVYSgdo2OGU0uDp1
	8WaEJwxT1BY57rWDxM9dHWYGVOdm9QPbvGhhyi/wG/Y69ziH8rovLrgpgi4aJTvZvNc=
X-Gm-Gg: Acq92OFD9JzBfbIKduoBFvVflurnxQGCm7/BythNgcn3vTqSDAP8ARzcQnhbDADDL1F
	6yPKb5IcGugz+WsKuQa/bYNUgF3yQYwec/ViAVpL7nVj1XisqwQ9kYB9WtGwxVh8Ni3UaqghyQI
	/SP6LtIgR49D0rrcRkjumJWyQXDeLGja3eWw4MZ+RxWM2/vtFVh/raZBtuzPVY2cGM15rjlWene
	h6VL1cDVtAH+5UTBTGviOdqhLoalxA9oUeAwts7BdzPwYcRGInuqI+3spLLMXQH/t2PMFzXHoL5
	XOcOvsOFKIQ/5D6GUyj1Bxp2gHxHlMF11QRC+IhB2t7CBdq9BgzeivS9Qn0GZwYx/IwS6A0tHp5
	QkkGVEFGttzsxosGrPjciwXIIyK5ZrxQhDnQKeCi6d7XNQWGeYSJra6mxv4kvVxoYJudX1C0VF0
	IrJLDG3R1KY3aofKuP7zXS5YEtFFqS78IQf/cDn12xMgQKZCt+FzgKHu5OF1hnJAJ3eqhf+Bxyt
	SVeecNDnY2uRdu4
X-Received: by 2002:a05:6512:694:b0:5aa:30d8:3281 with SMTP id 2adb3069b0e04-5aa3237d71amr867452e87.32.1779443798393;
        Fri, 22 May 2026 02:56:38 -0700 (PDT)
Received: from [100.64.15.206] (h-158-174-93-34.NA.cust.bahnhof.se. [158.174.93.34])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa32cf95c9sm298531e87.78.2026.05.22.02.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 02:56:38 -0700 (PDT)
Message-ID: <430612f0-53f6-49bc-acd5-e69df3b330da@suse.com>
Date: Fri, 22 May 2026 11:56:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] scsi: target: iscsi: validate CHAP_R length before
 base64 decode
To: David Disseldorp <ddiss@suse.de>,
 Alexandru Hossu <hossu.alexandru@gmail.com>
Cc: martin.petersen@oracle.com, bvanassche@acm.org, mlombard@arkamax.eu,
 target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
 stable@vger.kernel.org
References: <20260518121811.385350-1-hossu.alexandru@gmail.com>
 <20260520165259.272808-1-hossu.alexandru@gmail.com>
 <20260522003800.2323e11a.ddiss@suse.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20260522003800.2323e11a.ddiss@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[suse.de,gmail.com];
	TAGGED_FROM(0.00)[bounces-253735-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:email,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: A173E5B1924
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/21/26 16:38, David Disseldorp wrote:
> On Wed, 20 May 2026 18:52:59 +0200, Alexandru Hossu wrote:
> 
>> chap_server_compute_hash() allocates client_digest as
>> kzalloc(chap->digest_size) and then, for BASE64-encoded responses,
>> passes chap_r directly to chap_base64_decode() without checking whether
>> the input length could produce more than digest_size bytes of output.
>>
>> chap_base64_decode() writes to the destination unconditionally as long
>> as there is input to consume. With MAX_RESPONSE_LENGTH set to 128 and
>> the "0b" prefix stripped by extract_param(), up to 127 base64 characters
>> can reach the decoder. 127 characters decode to 95 bytes. For SHA-256
>> (digest_size=32) this overflows client_digest by 63 bytes; for MD5
>> (digest_size=16) the overflow is 79 bytes.
>>
>> The length check at line 344 fires after the write has already happened.
>>
>> The HEX branch in the same switch statement already validates the length
>> up front. Apply the same approach to the BASE64 branch: strip trailing
>> base64 padding characters, then reject any input whose data length
>> exceeds DIV_ROUND_UP(digest_size * 4, 3) before calling the decoder.
>>
>> Stripping trailing '=' before the comparison handles both padded and
>> unpadded encodings. chap_base64_decode() already returns early on '=',
>> so the full original string is still passed to the decoder unchanged.
>>
>> Fixes: 1e5733883421 ("scsi: target: iscsi: Support base64 in CHAP")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
>> ---
>> v3: strip trailing '=' before length check to handle padded encodings
>>      (reported by Maurizio Lombardi)
>> v2: use DIV_ROUND_UP(digest_size * 4, 3) as suggested by David Disseldorp
>>
>>   drivers/target/iscsi/iscsi_target_auth.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/target/iscsi/iscsi_target_auth.c b/drivers/target/iscsi/iscsi_target_auth.c
>> index c46c69a..00487d0 100644
>> --- a/drivers/target/iscsi/iscsi_target_auth.c
>> +++ b/drivers/target/iscsi/iscsi_target_auth.c
>> @@ -340,13 +340,22 @@ static int chap_server_compute_hash(
>>   			goto out;
>>   		}
>>   		break;
>> -	case BASE64:
>> +	case BASE64: {
>> +		size_t r_len = strlen(chap_r);
>> +
>> +		while (r_len > 0 && chap_r[r_len - 1] == '=')
>> +			r_len--;
>> +		if (r_len > DIV_ROUND_UP(chap->digest_size * 4, 3)) {
>> +			pr_err("Malformed CHAP_R: base64 payload too long\n");
>> +			goto out;
>> +		}
>>   		if (chap_base64_decode(client_digest, chap_r, strlen(chap_r)) !=
>>   		    chap->digest_size) {
>>   			pr_err("Malformed CHAP_R: invalid BASE64\n");
>>   			goto out;
>>   		}
>>   		break;
>> +	}
>>   	default:
>>   		pr_err("Could not find CHAP_R\n");
>>   		goto out;
> 
> 
> This looks a bit fragile, but moving the overflow check into
> chap_base64_decode() probably won't make it any cleaner. I'd like to see
> a comment or build-time assert in the mutual CHAP path as to why the
> length check can be skipped there. Aside from that I think it makes
> sense to merge this.
> 
Please, no.
The length check should be part of the chap_base64_decode() function,
which should reject inputs with the wrong length. _And_ you need
to add a 'length' argument for 'client_digest' such that the function
nows the size of the output buffer and can avoid precisely these
issues.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

