Return-Path: <stable+bounces-219185-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNjpFm1wnmkvVQQAu9opvQ
	(envelope-from <stable+bounces-219185-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 04:45:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7B9191479
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 04:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F657304178E
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAB829DB99;
	Wed, 25 Feb 2026 03:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cx1lT4ft"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7B317A2EA
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 03:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771991092; cv=none; b=DfGwtlLGsWZBksVCHRwEOTWoBCTAs91Q8o4XzNRONL3FUHVjvh+uzePcf34eCUmTauszNURKbP2JCYdHlFMm3hml7mmz2WQg1zDx4Sgz7Px+h3/jrowolrvrY1XiviQChgvkY9Fnri0zKubRQRj9KtB6ODLsqWJ2+eZvY24ikGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771991092; c=relaxed/simple;
	bh=VsioVV/OWnu73udVOsSViW+wEMHjulRCvqfJc7/3E9A=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAfkGXKKgHTLwuCnidhQf4MtJ5uO9A4L4gNxEjLs6hYmdJp3sV8GsNO44c5/eQc2vKTB61ZnGyCaebfI/5+mWH/E0v8NIq2tMfyUdwEClSSOjjxP+rpRlq35vE5LIiQWJ5bUnISQW8giBEhlGZIvBhdyPsXjA45o2fy+yRDTkdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cx1lT4ft; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4836e3288cdso2392595e9.0
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 19:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771991089; x=1772595889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PjtSnBpgWMxidZS08Y+UAgjN+XeL99JEW/KIqk0jjS8=;
        b=cx1lT4ftCRrKdKp5lLK1V5VHx+H1UUY0Z2zUFupdGT2D84aJE84YUkpydP4xDIU0Dm
         Hs4MJCRz/4LaXZsdDOY7SByreEETMCdnn6kmnI6K/5rkivg+pp5PB0oMbUbKEZpXDocf
         CDtJDb6Pc6XcNhUzm4wXf/iLilaDU3KaCj1zR5hFex0l1jzEJfZQnkmSAt2jj6gVgqOM
         KWvbks7VtGLaY9o07niy4LE1LJCirivcDE8MczWUYzmWY3V5a+Ics4ynisj6JSOYzE91
         +6XXjp+V04iF8vACCkMmXE+Lnp1puK/ZM6/ZNeHgJtAJk7vZg6nKF8q2Z47bEk3oUE3F
         rdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771991089; x=1772595889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PjtSnBpgWMxidZS08Y+UAgjN+XeL99JEW/KIqk0jjS8=;
        b=j/eMDR0dxp6qO1T3atZcTMIpA5p/SJ8s5gFS6OniWT7/Lxm3Mb8UILOxPVZoapUOJM
         toXDYstYYC0J383Cr33Q23YR3t7CDHE5ilS646fgGGJKkugSB99IgyAGkyRabBhFAMZD
         x0FdP5LCt5pNUeHTFXdyAsf0PS5m5zLF4WhUvV2vnc7aaUFGCYxDWmzm/VMpHxRFWH7V
         uMQqZSqPv1iUsvQzlo7kGS3mAHfctRTQ81SaEF1ID6d5QWPnB9RFSrdRmPCOw1InxZo4
         ITBLKGVUNpcZnFYgjW8guvCjDIry3wA7p7styzItr72a38rfIccMyowsYWMf0YHrUCO/
         LBtw==
X-Gm-Message-State: AOJu0YyqwBSFEXa7wPBx4EOnU8czkIWFaG+1a0MWf211UDcwI2rUYE1N
	GM8LYLL7VTcNDDkSgSq7L71n5sANiwsNr7hSyQ31px+7RXD6OKBMCMha/lQHzi59pfN+TNJmYy2
	Q1AJI
X-Gm-Gg: ATEYQzypk5Smz72qJliSuxMkToq+sv3W7jv1RstXDIKYYstSgtxAEbCdmItgFNQE1qv
	qQl5izbVbstrGKL5qyxtv1pUYVco+1KYgHvYUMfSgefWFYAMNWtww5C7mMDnsizlrsN8kdL8mzj
	2HqGbT5mgcWCveiZFcEIm/aboUeyQQmh1NtbCyJ3xB/T3UZ9N7Tin6y7ROmux7Yuc+v7c+6hBu3
	n1V2SyoBwlFPB8wsH7Rsy4SDK/e7eGvGAeI2xfT6dYXSlQiqlaZqYJ7Dfrq+ztjmJWoPtWjPKU9
	lX7rfh213c8BAgelU73peLjjHBp9nxSTehIMXwkV13hpzeW/DNwndhEnz5z/0KVQtNpaYz3Dzzn
	Us4byQC8gFlOWNzSSgbcdnoLR/MyFr7bEEE/Gyd6+FdV1mPsJa1CPwUSFUZnesB/GowUkzEWPEa
	ft0XT4fsjR8LVmA+wnndw=
X-Received: by 2002:a05:600c:21d4:b0:483:7eeb:4558 with SMTP id 5b1f17b1804b1-483bd713d0bmr25415525e9.2.1771991088785;
        Tue, 24 Feb 2026 19:44:48 -0800 (PST)
Received: from u94a ([2401:e180:8d80:eebd:d098:7649:31a9:9ad7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74f5e0f2sm121839545ad.31.2026.02.24.19.44.47
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 19:44:48 -0800 (PST)
Date: Wed, 25 Feb 2026 11:44:43 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Subject: Re: [PATCH stable 6.6 00/11] Backport selftest for "bpf: Check
 skb->transport_header is set in bpf_skb_check_mtu"
Message-ID: <cbbxjsmon7zxr2p4jafswdacndgdzomjdqu7wyojtegdzd77zf@egykxauihxol>
References: <20260225025454.17398-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225025454.17398-1-shung-hsi.yu@suse.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219185-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim]
X-Rspamd-Queue-Id: CF7B9191479
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 10:54:38AM +0800, Shung-Hsi Yu wrote:
> This patchset backport the corresponding BPF selftests for commit
> d946f3c98328 ("bpf: Check skb->transport_header is set in
> bpf_skb_check_mtu"), which has already been included since 6.12.63.
[...]
> The follow commits are backported:
>  1. f52403b6bfea "selftests/bpf: Add traffic monitor functions."
>  2. f5281aacec85 "selftests/bpf: Add the traffic monitor option to test_progs."
>  3. 1e115a58be0f "selftests/bpf: netns_new() and netns_free() helpers."
>  4. 52a5b8a30fa8 "selftests/bpf: Monitor traffic for tc_redirect."
>  5. b407b52b1850 "selftests/bpf: Monitor traffic for sockmap_listen."
>  6. 69354085975a "selftests/bpf: Monitor traffic for select_reuseport."
>  7. 5772c3458bb8 "selftests/bpf: use simply-expanded variables for libpcap flags"
>  8. 4a06c5251ae3 "selftests/bpf: ns_current_pid_tgid: Rename the test function"
>  9. c047e0e0e435 "selftests/bpf: Optionally open a dedicated namespace to run test in it"
> 10. 207cd7578ad1 "selftests/bpf: tc_links/tc_opts: Unserialize tests"
> 11. 6cc73f35406c "selftests/bpf: Test bpf_skb_check_mtu(BPF_MTU_CHK_SEGS) when transport_header is not set"
[...]

Forgot to mentioned that BPF selftests was ran and passes after this patchset was applied:
https://github.com/shunghsiyu/libbpf/actions/runs/22343432214/job/64773946420

