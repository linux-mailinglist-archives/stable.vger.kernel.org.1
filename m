Return-Path: <stable+bounces-215756-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id teH3B7w0jGmNjAAAu9opvQ
	(envelope-from <stable+bounces-215756-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 08:50:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 628F9121F15
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 08:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABE8630214E9
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 07:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E212D2D9481;
	Wed, 11 Feb 2026 07:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=remarkable.no header.i=@remarkable.no header.b="KGWVat2O"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CB828725B
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 07:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770796215; cv=none; b=FrtcnX50Pb2UyXO24UyV9d+gQmziDERTuwKjVqY4Q/oXJ1++nFyNnMbFEDNvdOXmpnhyVWv4d9zBB2zMSeBd4E0RY5GDwhFaggUHqZlUlEU+zNzGd/U1UokoE8QGmTaEJCxkmTwEpGugjrEpriXtDes+4n41Mb56YSV2HTyO9iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770796215; c=relaxed/simple;
	bh=poS7wtUXZKVO9JV8Myn0C3IHm6VCTEiwzprYNzu27ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SMsOKlMFiDNvFfu9n0wZ09byVsTtBOwiwR9QKLQ0yOw1pHYzLPRofqmJ0loYVSNNAjrQiywda2IYnoeUKUdZo874UG6K3RPoMZTeWtC1PkxY/cuV8wlN8Uhe7MTEV2fzYQNKPfw5l5MvLrdoXTMrG+G+ShStonjbmacy0/DTAz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=remarkable.no; spf=pass smtp.mailfrom=remarkable.no; dkim=pass (2048-bit key) header.d=remarkable.no header.i=@remarkable.no header.b=KGWVat2O; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=remarkable.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remarkable.no
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-59e57973dbfso515703e87.1
        for <stable@vger.kernel.org>; Tue, 10 Feb 2026 23:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=remarkable.no; s=google; t=1770796212; x=1771401012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kUTtGjAikYq+wRHxOhgjwOIEsGPvZljU1lZ4mdDDCZE=;
        b=KGWVat2ONsYvqFq3PiR8zKRqSbhDWZPEG2TtDzWyfiNHX+Pq03CQJMukJ83WFYgt82
         am8fqeCPbzpeYNtu6YSLrjQX102v9BV8S9dYJtudZWS+myQ2M7m70SywsBLYqd6bNQS0
         VC0pbdw5fWz6rkK42o02IYP7FQQivxtMUmqfDpcHwqoseKk2tY/HdE7ezmoIrcLtteGY
         Xd2F1M7eaetSg7tyNWJySQr8PQTV4gN/TwiGDWUllh3LkYECOxZSZc578GWBYu9qHbDq
         k7YUPl5RQT0EjLON8f/JvcMGytIynR/90faFyMO2wtWA8OdNCo4hIGoXGMU5nY6yTPYV
         Visw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770796212; x=1771401012;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kUTtGjAikYq+wRHxOhgjwOIEsGPvZljU1lZ4mdDDCZE=;
        b=StfeYnVYEBswYbUD/smp1A9/kRdnjAD4bJd4hHZQFRAXIYq8C1moY5j3PPFvlJ/EGn
         4UrQIU41v+W9d4ziT77sLOXJbsN1HTRBzk0zfeDaMxoccXZWXj3iVUM9GnGoaef0v5eq
         yDKKoXfyD2kjl/3k+ONWe1D5fENVduiPCFan0UKR97nsttlBabdEVIPGUuhBaBFX1eSH
         EVpwxBLVPkgv5301HPoaHf+JZeSXEF3kYQdL62zoo/LCKKs/ifDafRrGjZ5nARXMiD/w
         nmspHhSnkrq8IN7fB2QpxwInQe0qVTEEn19+qSJ4YzAYsMCtznVsV8issPqdl6yuH3qR
         PMLg==
X-Forwarded-Encrypted: i=1; AJvYcCUPgAxV/nO4RUT8nmKq3YXBWOEa35PIHlSRvdDhQ6UrxHUtkiuqgK/uO9V4JXXfANtG0fuYdf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTGIhgtLv3/poyBIZO2l3jqC4acvPWqLulXgysUY7PxGLfdxaY
	tIHUkDgNqgh/1eEa8t4WnMTHBlXyVqIOgFgz7G0i3Hbt4auhA/heTwDrqZ62g2PomQ==
X-Gm-Gg: AZuq6aISx70K0xaIn/zysveStfiW567f1QOuDoQxYVuNjbHbn6BZ+ApzyY7DJLIREYa
	3P4keB0FM0JQIzS4RVjEk9YW5/ZL20JjmcTKMgHX75cPj8sTyvE3AEG3IlFzx647o9JwJIe3Pwj
	S/9ItyAgug9BpX3r7xWNwDwYL+CkpJNpCD0f1NW8aPFOV8KgeB+XdtX2e1k2MAgbfxubYz5U4b9
	KnJVid3XR7izlSTkkKtzXs9fNhUuysIFcY/hrNa330pQhEUPQkKyyQt2pRiJb7VmiQS/FogwrFI
	T1mDfq4pXoGBlainOtxZgEMZpDz8RsKwBW/MSwtvh1cc+3LSy4cjIvR4Tv9cJ5LsBoghZi+AAQ6
	asD8pGoCeggtjsU25uXfjJeiMrzp6nL1j77sv0x/KfyRnuE+vplvucqAIPBskCkmwOgUj6rYFS0
	eouXtDkCW+DXNEDm+jNfwdxY0Y9VWTRf89S6K/bcDJwYli5CwwoFF43lHNFPbYM75TSV67az7xb
	b+ideEKo738S8LCOAeBQJt8ifrQVynzHe4iBlpKHNLDfy2Bor42NCTffqeU8njjPox+zyFQ/eho
	lh7dY0WB1m9PlLw=
X-Received: by 2002:a05:6512:31d6:b0:59e:49bc:b9fa with SMTP id 2adb3069b0e04-59e556d8bb8mr1987545e87.11.1770796212451;
        Tue, 10 Feb 2026 23:50:12 -0800 (PST)
Received: from ?IPV6:2001:4643:2b9c:0:64dc:7ba4:ffb0:37f7? ([2001:4643:2b9c:0:64dc:7ba4:ffb0:37f7])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f5b21f7sm172469e87.78.2026.02.10.23.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 23:50:12 -0800 (PST)
Message-ID: <61627e8a-6998-4138-a174-d7fd257db93e@remarkable.no>
Date: Wed, 11 Feb 2026 08:50:11 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 094/169] vsock/test: fix seqpacket message bounds
 test
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 Sasha Levin <sashal@kernel.org>
References: <20260128145334.006287341@linuxfoundation.org>
 <20260128145337.388867288@linuxfoundation.org>
Content-Language: en-US
From: Johan Korsnes <johan.korsnes@remarkable.no>
In-Reply-To: <20260128145337.388867288@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[remarkable.no,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[remarkable.no:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[remarkable.no:+];
	TAGGED_FROM(0.00)[bounces-215756-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan.korsnes@remarkable.no,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 628F9121F15
X-Rspamd-Action: no action

On 28/01/2026 16:22, Greg Kroah-Hartman wrote:
> 6.12-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> [ Upstream commit 0a98de80136968bab7db37b16282b37f044694d3 ]
> 
> The test requires the sender (client) to send all messages before waking
> up the receiver (server).
> Since virtio-vsock had a bug and did not respect the size of the TX
> buffer, this test worked, but now that we are going to fix the bug, the
> test hangs because the sender would fill the TX buffer before waking up
> the receiver.
> 
> Set the buffer size in the sender (client) as well, as we already do for
> the receiver (server).
> 
> Fixes: 5c338112e48a ("test/vsock: rework message bounds test")
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> Link: https://patch.msgid.link/20260121093628.9941-3-sgarzare@redhat.com
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  tools/testing/vsock/vsock_test.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
> index 0c22ff7a8de2a..79ef11c0ab14f 100644
> --- a/tools/testing/vsock/vsock_test.c
> +++ b/tools/testing/vsock/vsock_test.c
> @@ -359,6 +359,7 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
>  
>  static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
>  {
> +	unsigned long long sock_buf_size;
>  	unsigned long curr_hash;
>  	size_t max_msg_size;
>  	int page_size;
> @@ -371,6 +372,16 @@ static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
>  		exit(EXIT_FAILURE);
>  	}
>  
> +	sock_buf_size = SOCK_BUF_SIZE;
> +
> +	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
> +			     sock_buf_size,
> +			     "setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");

Hi Greg,

This patch causes build failure as the setsockopt_ull_check() function
does not seem to be defined in the 6.12 tree.

Kind regards,
Johan Korsnes


> +
> +	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
> +			     sock_buf_size,
> +			     "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
> +
>  	/* Wait, until receiver sets buffer size. */
>  	control_expectln("SRVREADY");
>  


