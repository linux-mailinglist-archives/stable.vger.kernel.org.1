Return-Path: <stable+bounces-240251-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aK2bOtP352kVDgIAu9opvQ
	(envelope-from <stable+bounces-240251-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 00:18:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 920114401DF
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 00:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F24AB3012BE2
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 22:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60173A453D;
	Tue, 21 Apr 2026 22:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="vdRfz6uw"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFF03A5E82
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 22:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776809935; cv=none; b=higfZXcvxQalqtO+Metup4PHyU3/e7UD0g/cygY1mK+D7/h7MJiej31Zff4rHpwEbaTLpBBNOSO/JaVnC6YRYZiwGj7+Lp+BG06AnUscEjp+XFXH67oCI5UdoH//TDIHeePUs0Y0GoArLxEj+ZNLIQXZg2nFNyOnbVI14qCN+64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776809935; c=relaxed/simple;
	bh=YxaDhucYJqR+pLsF3cmCQy1mP20FRBqBNvoFdl7AKRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EcbrMcKmBcvG/2uyI1uI7kVdT3MwE+u5SKmhwbAxEpYADq7G85xxpT5OBnOd8DktZOm3c1ET3w28ScNC/R5NgBDGdLEKzPyL60EiHeB/zMxItfAX48NPtGW+JWM5pvhJpKQ631NzozoQHNZYk8J4wzCFTKvTRi3akveUiTOd87A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=vdRfz6uw; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-479d9b155deso882457b6e.3
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 15:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1776809930; x=1777414730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B3VPUbIOBm8jC+mr0MXSF2GSTvOeKJwM6inCehb0UtI=;
        b=vdRfz6uwMVENFc54nCSIqc4/Ty+znz2i9SVyWMfBPoKR7nRKvIHxAjxhb35x8yV0Z4
         Jq86gImufq6TZk9I4S7gaILPM243KFrbGB21SaIKFGNFShljvKHAVpwZE59rPrNNZfmn
         ctMZDQ9qZh3tbMC5OS1upR0UuYBEZUAt1OnnfMLYNP6Pxr6tgnr7z2ljbNfvUIP8PFNz
         0OXIcJSK4gGu1kMQjIZn0m+cUbFiQuQtwF0ae7cyJmZuqkgAcMPm6Ixiu4RJ5ffqZxe5
         RKIYzG2mim/fzv4N/zBitB4+NReqPXaJa061mNZhhduOyWOiFQUtICtJu1h3xgbZoERV
         2CFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776809930; x=1777414730;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B3VPUbIOBm8jC+mr0MXSF2GSTvOeKJwM6inCehb0UtI=;
        b=mXWMtVrn4ORkaA0lrqncyI2HLO33h9OgkSvNgqSVb5O94I7VXZLraltitQL1fGBuN3
         wvybhPDy09u5tgcPNQkXMhLECwrm1f+HjUeeOK2+gEXPSGZ1UV3p0u53+HsmzIXnE6zr
         +nGFAzffAVTwbBFvDXWf5Bjmv4yiI7qr8yIxItM4DVgPOY5GzlsoA3nCc81SowjLBwNk
         pxYIDc1kQ0IbvUkgwMc8BYvTCWPg9c+nM53KBoT3yfjcUl9cnvt0fAqx0IllYuyPmHHS
         ILKzrMDrfud9FJzGA8jxTDCqTQLu46i/aVbYBn1RVSeTQpriDJm91J+W8JNaQET2N6OT
         URCA==
X-Forwarded-Encrypted: i=1; AFNElJ/3XGTzmDkTYlnsQnJVw9TtShci6KMFIyO20xsNZOviqmZgVnCMWK09+s1w0Y2O5Vm1glwnRNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnn6bYKnZkYG/Msr6f4lFKuROtY/7axFsKqJGUUArBY8Ej+LxJ
	WhrzdufVwler+Yw9S9WcgankAbgkgSAk2B30zfUOA6BAMXHqwSZdhZK216Nr8gpZFqY=
X-Gm-Gg: AeBDies1ZNH9fjoYk7aBEt5ZJtx2ZgsIH1Ria2WNAgxDIZ6OFHJgGmOh2gyc8yQzDKw
	tuJy5sOaH1SAi3kn5h1Ewv2Ry970G+jrr8fA49WX/9VXhOr4h0AUF98bSZ5c4uY/ePQqoTmeC3Y
	EFLAupCYWIzmMGDlFedxFuavrqPejhvPxgH3Qc/EbmbBjXS4DQiGbdzUCUajmlbXgxjKEKhK1UO
	I/CwEjn4QKGFG8UikV1lUfDKwlaz+/ccFjUeqEN8vDLJlJLLqyHQaxZMk9+SrolzsKv/YAHEY/A
	LaisXt40+1eKBh51z3qzTcDJL4TwC5+EKU/jWC7FLvnyZn7gO0ZWZuM9YKtSvHbti5JtZpjlj4d
	Ae86sqlGlhZYEuv7+LDP0C35uu14AnOfFZGha4PN/cWurEI0rsUDgnqvTAxmM2k1U1jC0ITaXZ+
	ERkHRYDJvc/RiSvvL6T1VSbyFJygh249P65KoVN4qFImoQcldMHtFMe+F7Lp9oWRo1R8vrYAGjJ
	x56O22azLEWqQfNL129
X-Received: by 2002:a05:6808:1a03:b0:466:ff3a:c745 with SMTP id 5614622812f47-4799c8d25famr10432101b6e.21.1776809930454;
        Tue, 21 Apr 2026 15:18:50 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4799fc19273sm9795783b6e.0.2026.04.21.15.18.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 15:18:49 -0700 (PDT)
Message-ID: <d7d521e7-35bb-463b-b1f5-552bb931bdff@kernel.dk>
Date: Tue, 21 Apr 2026 16:18:49 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 491/491] io_uring/poll: correctly handle
 io_poll_add() return value on update
To: Ben Hutchings <ben@decadent.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev,
 syzbot+641eec6b7af1f62f2b99@syzkaller.appspotmail.com
References: <20260413155819.042779211@linuxfoundation.org>
 <20260413155837.438151458@linuxfoundation.org>
 <d4b85e905345dc69e9c660c7f51775703fa83320.camel@decadent.org.uk>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <d4b85e905345dc69e9c660c7f51775703fa83320.camel@decadent.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240251-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,641eec6b7af1f62f2b99];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,kernel-dk.20251104.gappssmtp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,kernel.dk:mid,kernel.dk:email]
X-Rspamd-Queue-Id: 920114401DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/19/26 9:45 AM, Ben Hutchings wrote:
> On Mon, 2026-04-13 at 18:02 +0200, Greg Kroah-Hartman wrote:
>> 5.10-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
>>
>> From: Jens Axboe <axboe@kernel.dk>
>>
>> Commit 84230ad2d2afbf0c44c32967e525c0ad92e26b4e upstream.
>>
>> When the core of io_uring was updated to handle completions
>> consistently and with fixed return codes, the POLL_REMOVE opcode
>> with updates got slightly broken. If a POLL_ADD is pending and
>> then POLL_REMOVE is used to update the events of that request, if that
>> update causes the POLL_ADD to now trigger, then that completion is lost
>> and a CQE is never posted.
>>
>> Additionally, ensure that if an update does cause an existing POLL_ADD
>> to complete, that the completion value isn't always overwritten with
>> -ECANCELED. For that case, whatever io_poll_add() set the value to
>> should just be retained.
> 
> This backport is very different from the upstream version, and I have
> some questions about that (inline below).

It is, was quite painful.

>> Cc: stable@vger.kernel.org
>> Fixes: 97b388d70b53 ("io_uring: handle completions in the core")
>> Reported-by: syzbot+641eec6b7af1f62f2b99@syzkaller.appspotmail.com
>> Tested-by: syzbot+641eec6b7af1f62f2b99@syzkaller.appspotmail.com
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>>  io_uring/io_uring.c |   26 +++++++++++++++++++-------
>>  1 file changed, 19 insertions(+), 7 deletions(-)
>>
>> --- a/io_uring/io_uring.c
>> +++ b/io_uring/io_uring.c
>> @@ -5980,7 +5980,7 @@ static int io_poll_add_prep(struct io_ki
>>  	return 0;
>>  }
>>  
>> -static int io_poll_add(struct io_kiocb *req, unsigned int issue_flags)
>> +static int __io_poll_add(struct io_kiocb *req, unsigned int issue_flags)
>>  {
>>  	struct io_poll_iocb *poll = &req->poll;
>>  	struct io_poll_table ipt;
>> @@ -5992,11 +5992,21 @@ static int io_poll_add(struct io_kiocb *
>>  	if (!ret && ipt.error)
>>  		req_set_fail(req);
>>  	ret = ret ?: ipt.error;
>> -	if (ret)
>> +	if (ret > 0) {
>>  		__io_req_complete(req, issue_flags, ret, 0);
>> +		return ret;
>> +	}
>>  	return 0;
>>  }
>>  
>> +static int io_poll_add(struct io_kiocb *req, unsigned int issue_flags)
>> +{
>> +	int ret;
>> +
>> +	ret = __io_poll_add(req, issue_flags);
>> +	return ret < 0 ? ret : 0;
> 
> __io_poll_add() still never returns a negative result, so why is there a
> check for that here?
> 
>> +}
>> +
>>  static int io_poll_update(struct io_kiocb *req, unsigned int issue_flags)
>>  {
>>  	struct io_ring_ctx *ctx = req->ctx;
>> @@ -6012,6 +6022,7 @@ static int io_poll_update(struct io_kioc
>>  		ret = preq ? -EALREADY : -ENOENT;
>>  		goto out;
>>  	}
>> +	preq->result = -ECANCELED;
>>  	spin_unlock(&ctx->completion_lock);
>>  
>>  	if (req->poll_update.update_events || req->poll_update.update_user_data) {
>> @@ -6024,16 +6035,17 @@ static int io_poll_update(struct io_kioc
>>  		if (req->poll_update.update_user_data)
>>  			preq->user_data = req->poll_update.new_user_data;
>>  
>> -		ret2 = io_poll_add(preq, issue_flags);
>> +		ret2 = __io_poll_add(preq, issue_flags);
>>  		/* successfully updated, don't complete poll request */
>>  		if (!ret2)
>>  			goto out;
>> +		preq->result = ret2;
>> +
>>  	}
>> -	req_set_fail(preq);
>> -	io_req_complete(preq, -ECANCELED);
>> +	if (preq->result < 0)
>> +		req_set_fail(preq);
>> +	io_req_complete(preq, preq->result);
> 
> If __io_poll_add() returned an events mask then it completed preq, but
> then we also complete preq here.  Is that really correct?

Let me take a closer look, I do agree with you that the final result
does not look entirely correct.

-- 
Jens Axboe

