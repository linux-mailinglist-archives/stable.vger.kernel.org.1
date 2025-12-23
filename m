Return-Path: <stable+bounces-203303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A736BCD925A
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 12:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35C5D3016729
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 11:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4869E30EF72;
	Tue, 23 Dec 2025 11:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bMnZuqin";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eujFDi3Q"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9866570824
	for <stable@vger.kernel.org>; Tue, 23 Dec 2025 11:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766490300; cv=none; b=CC0mhV5LVCQHBJhunT/ZbnpXfoCDNHRqBb/5UFq3BT3qn3O+6dV51aOMNjbRi6vFLjjpKBzbyVJ5sYBaYXe5n4zgX3g34swFKcsYogjODq3sxyeAGyacpjWF1K242j+bP3JO7JuiWyRCyVRv7tutqpyZhrc0QyopQp1iP9ZbXrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766490300; c=relaxed/simple;
	bh=PoWhOw+nfc/VpWAeGXyfBJ/eaqYMCIHlPZCe+FiDD0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2kv1CCvZWFdBbWSqesiyY/4AT6btfIi5meSr8QMQz6DYymeJtxOfbKe/i3DuTAt5f/148NLqtgUWWRdP/WIb1rH432iUdLKVhgQoNYNcnh3CfsTIKK/gbWzqHIk2+JORXkE1cODcMpeHOgt7jxWDM3GF7CUeNV5fCy4H3ratIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bMnZuqin; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eujFDi3Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766490297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fa4EFzzfETnupi6k1YGjJDaAIRvY+onKMclFgCyO/0k=;
	b=bMnZuqin3Qesh4gd8I9zg8M3EX/Q0KvSs/9Cnwiqhdx02zopJcsgx2kxnZAU4Wus4ANGKf
	x9RHgYyl3+yzotnht1odveHRstZjJ63ajTI9hnEskFb62dAkLz285/Djgy9oOHpA9hrVuf
	yUMlfeAjc+F3VjN7bUop5H26qC9AR6M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-O3jW743pPHiQGbrDfCltVQ-1; Tue, 23 Dec 2025 06:44:56 -0500
X-MC-Unique: O3jW743pPHiQGbrDfCltVQ-1
X-Mimecast-MFC-AGG-ID: O3jW743pPHiQGbrDfCltVQ_1766490295
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47799717212so51771245e9.3
        for <stable@vger.kernel.org>; Tue, 23 Dec 2025 03:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766490295; x=1767095095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fa4EFzzfETnupi6k1YGjJDaAIRvY+onKMclFgCyO/0k=;
        b=eujFDi3Q+WFpsK1XAkFbaAW6TpvUbygS9175wIQUyG24OYoFJ30ftwVD7EH2SyefLX
         sywDItJOl2lriHR9/bkcYSmjna3YLuDOJSTQVhK7rZB+RA9Bt47z/i/fqR+xyLb0qACy
         j9qm4SXZGVB91vSJQSp629SJ5s/SxaJkBnmGxcSrqeF7mMWgZzix5gdXlyyOk9p+O5qg
         wUTpe1DSyxSlf4l/11M+O/NY4ygiql6YUW8AiIYXjzDXzT9OXJp0dJg55c8NTJORvkgg
         baq7O5eyMLY9GDRs/yVNqyCWcdfSUAIqP/oYAwGFRo/DfqAUPk2HqwTvm9jfWAroqsgr
         LBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766490295; x=1767095095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fa4EFzzfETnupi6k1YGjJDaAIRvY+onKMclFgCyO/0k=;
        b=kYgooJfyh3E1PUjs1YGdEhYFA/q8BOGk9b+tmt7s7EYOUfQrc7hqhKhExpdv8Ej02E
         kvgQ2AjXB1eBXo50Ee60Rxbx4p2nCMgFI76FtzXiHrocoAQ/qfV9xJ6dDhwufy53cZsp
         bEQrGopoB8I8xSJrPjEYQh3E5pAhYvFph2KVYdn2YqZQE8+6Fuh4jtDmMLMlRk7fJFED
         CDriVrlEtl8JbmCxrZxOXCy0Z90gQpAwTkhaCJ/6HHzN6WaHOM/goGJRRGeoa6tArx10
         9gjPsoXNQ7RW4rU1K+oRfj3UYiYtR27lPgtqKTw0j7BgTcxXxuD7AiJUNeVVRI9o7VZV
         b3pA==
X-Forwarded-Encrypted: i=1; AJvYcCVpR490aPAy6he1EOPWnAeSqwATDAP0ngMe9WppE3noIUq91EZPYRzEuMIZ1YyRHRJKoxvWDUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yweb1WL+B6cmEvMr0XBNTRYom+zJd+pscRNf4Hs64MoNs78JyG9
	VxYsg4l6jQgyq7fRfVYWyfLUTC9KRKKC7YAX78ab3lcNMZz8g0MtKUphx4d2IMKP00lVKOdu+rY
	aq002CjPtkLsjFx/Jum7F8c/JLcxIRHk1FODkl7FpyKRfAzc4YobheiFfySOmaB3Z1g==
X-Gm-Gg: AY/fxX4B7O+JPospLwfZbAkpXoLDkr92lVMRafs7eSC7+1sn889Lc4QnvgYTeRaLYQG
	ctlaNQwgCboWOUn4jiar7XHuey4+csh8bE6AU81+rmU7Gf1H1fwshz5sMkq0knx5SF8MqOLBRgl
	f4cPTY8aYHtxJ0t5T0lAQOLoOsfM+db9dAVAFr7ptcw+s5ogupuzD+F1aiqrAJdXS+CqX3/oT9Q
	xyhXtNMpL+Dm4S/ZOS/IwgGOPqE0d/i9NEHnU1SfvSQMIPtrfQYR3Sf/CJGCQ12mNFy6ttnVyKY
	riuSM2bYYjOhZE2iATaibizpUib+J++HfKyG7ktLGfXK5ZLWVSOVQ72O4LvO8GSGn9qcYQOJwyy
	dvhkPGbi7MA/f
X-Received: by 2002:a5d:52ce:0:b0:432:5c43:5f with SMTP id ffacd0b85a97d-4325c43025bmr7159557f8f.40.1766490295052;
        Tue, 23 Dec 2025 03:44:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQLxIehr4SCLFNV0ruVkupY8XPaxEnUF7XQz2DeO9bUzCELq8u2WuAs2F67yAtiU4rUvK1zQ==
X-Received: by 2002:a5d:52ce:0:b0:432:5c43:5f with SMTP id ffacd0b85a97d-4325c43025bmr7159541f8f.40.1766490294625;
        Tue, 23 Dec 2025 03:44:54 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea8311fsm27300084f8f.28.2025.12.23.03.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 03:44:54 -0800 (PST)
Message-ID: <b3d2a2fa-35cb-48ad-ad2e-de997e9b2395@redhat.com>
Date: Tue, 23 Dec 2025 12:44:53 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: usb: pegasus: fix memory leak on usb_submit_urb()
 failure
To: Petko Manolov <petko.manolov@konsulko.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, kuba@kernel.org, stable@vger.kernel.org
References: <20251216184113.197439-1-petko.manolov@konsulko.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251216184113.197439-1-petko.manolov@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/16/25 7:41 PM, Petko Manolov wrote:
> In update_eth_regs_async() neither the URB nor the request structure are being
> freed if usb_submit_urb() fails.  The patch fixes this long lurking bug in the
> error path.
> 
> Signed-off-by: Petko Manolov <petko.manolov@konsulko.com>

Please:
- include the targed tree in the subj prefix ('net' in this case)
- include a suitable Fixes tag

Thanks,

Paolo


