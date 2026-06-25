Return-Path: <stable+bounces-268326-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8pX0I0T9PGqtvQgAu9opvQ
	(envelope-from <stable+bounces-268326-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 12:04:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE046C477F
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 12:04:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bynar.io header.s=google header.b=d1s+AjUE;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268326-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268326-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bynar.io;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D4323021EAA
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 10:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC7F3CE0A2;
	Thu, 25 Jun 2026 10:04:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C1E3CD8AC
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 10:04:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782381883; cv=none; b=WsXFqBl3jll7J2udUxL0W3LUGFNkyRRl8xrKbPFszk1YZWXmUn3Nfrd5RGjaCKrlgNywkYkcMSVCtEHAgROmw9X9LDzgbhCc4TSBI5yBqZIJvMmNA4bIBjFu0xgdgTjWdQrjIEdMaW/VOXSy42PLQq3kioM35gtZ6fiMu0tw7qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782381883; c=relaxed/simple;
	bh=QDzsnUqwF537r9M0E1hQPClNIzZvDM04Y5WP6j505Wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GA451PGu20HHVEVzv9kmOdN/yqKjfS29LFyyRI8DWFSjCvWgAHMXzMa4hrjDk8B21G0DUfBNLhBKitYaCRmBzxNgeYf+CADglzprY1fJ3er3tduQbKIhzV/NG8fd3E6Rp3TKs/HqZw+EstcNBb8Qzw50+qpgNUve4Fet1pHGx3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io; spf=pass smtp.mailfrom=bynar.io; dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b=d1s+AjUE; arc=none smtp.client-ip=209.85.218.46
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c0e12cb1d90so315738666b.2
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 03:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bynar.io; s=google; t=1782381880; x=1782986680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZJYAU8T0dbhlhhmhVee2XR5nvnk6dSr8CYdyAa40XFg=;
        b=d1s+AjUElnxOsvZM/lRCxbAL9Av+hMqibOb574krGZbEOEiQazCVqlJFvxqcp7XscD
         YDoyF2m4AkJI/ASx63vw2lQAyLSKXuDFAGSDaNhRbn4GjhC/k3urQYpEfhY+bUvi/Uuu
         sXdG997xSTxOK4E5wwks/nIMLovJXXG6Oh7Yt9ZU/nXnLbOsBzlnWAAuWomPtx1CF3Re
         zXPY0JslBzI2NPQjCfTqcWf+VfbSNdcLETSKeGRGpYi1c4dTQnNt8fNe2DRndspe0IRh
         9gCcW+hKU0igciSa5t+IIgL9M/x7fNd+VDru2c7XA3/MSGvCzKyKjP2iEJsVmmQ/OVGJ
         gE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782381880; x=1782986680;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZJYAU8T0dbhlhhmhVee2XR5nvnk6dSr8CYdyAa40XFg=;
        b=ZEs5dyj2NsuSQK03jKViUbMVzzrI6IOz5oe6ZH9TjGQPoD91m1SlDwLd/t7E0yvsKh
         8zbwT0kAmkWvtUlA/Q76a7zewBkmWylIMJnqy7gR1gDyuz1WS2t2NLS2xYSX0lbmfZ8Y
         LjkjKvmZEuFbf7rJAAj5GeU46JhiBxHmUqKuAA+DrIXYks1u0ZW5/nhmYQhejXDIBfyi
         +BZKQdtKCdX5rztxmAs5eiishsINOFmOejH/5wOFyeD9SwxiorMqEwbuWkrbCgwh5azg
         00tEVz4mGwGxTRgd4ATFI+AceU0hUJqZSuZOSxr95Cg8qgt6bymrJ9+aciVZgA5EaDkV
         K3Tg==
X-Forwarded-Encrypted: i=1; AHgh+Rqr7U9lPOxQDXYEQrdaPAXi1h5/iRdGAn7d0ILmAiGBw2OrGUAB9oG0oBVHDQC1ph85j8vetJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCZ4XVa8Od4DuC+8fOQEBvT1xryzjdz4OtPAI8pHVOg1PwR7IL
	KbbI56LGeVJnXgTmrpuefDgazAZgdLK3188OE53C/923Xvf6PK66vPH+dIFroyocxp/Z
X-Gm-Gg: AfdE7cnUWonEZ90Mzmy7Z9CE0b06RyqTrFjkbc8tNUNyDSB6xhbqa5a0n492b1Fej2T
	4iJbqIl1ml6J16ie9uc5BqUCIAWfBWs3Ks0FSzTdOPS6P+e7OpgDFsTsg+fAiPAuGDyxKC2I9Pg
	t2IDtvYq/PGkKF0RqMU8U4PpXyE9PhymuHy4WSgN8W8HQq8ItF5tdgRdRk9od6FTWAHJojFKCPM
	Eg6p59SZeH0TTmzZgp0aLzf8OitR1eHwl53Yy/QQe24hoE74hDrEGzHDNhAUZz5eAhAmyN0yTyD
	W2VfIqIhTprnzGRTWmksdV/NQT4gGXtjt3YMWKbQ7VhVsP9vhtx7b/C1v54lVon9pI2a7usuZzQ
	oEZPsF6XTJzozmdQz5XWlVqHgpvcB+wRldPRSxkx2KlZnyVv9Ibu5L06mZw6151T0TAzQZdtTS8
	N7/Z2ANJ4fM6mVluzHl5Sx/Yaortp3+cUhnXo/tMhUuntz3A==
X-Received: by 2002:a17:906:f5a2:b0:c0e:840a:79a3 with SMTP id a640c23a62f3a-c12061eb76dmr128400266b.52.1782381879743;
        Thu, 25 Jun 2026 03:04:39 -0700 (PDT)
Received: from ?IPV6:2a06:61c2:d427:0:b321:1c7a:b072:326e? ([2a06:61c2:d427:0:b321:1c7a:b072:326e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbe05cb3sm150309966b.35.2026.06.25.03.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 03:04:39 -0700 (PDT)
Message-ID: <ea447873-9222-4b75-8090-68d08e53097a@bynar.io>
Date: Thu, 25 Jun 2026 11:04:38 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] nfc: nci: fix uninit-value in the RF
 discover/activated NTF handlers
To: Simon Horman <horms@kernel.org>
Cc: david@ixit.cz, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260623234126.214667-1-sam@bynar.io>
 <20260625091828.1170615-2-horms@kernel.org>
Content-Language: en-GB
From: Sam P <sam@bynar.io>
In-Reply-To: <20260625091828.1170615-2-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bynar.io,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bynar.io:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bynar.io:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-268326-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sam@bynar.io,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:david@ixit.cz,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam@bynar.io,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bynar.io:dkim,bynar.io:mid,bynar.io:from_mime,vger.kernel.org:from_smtp,linux.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EFE046C477F

On 25/06/2026 10:18, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> nfc: nci: fix uninit-value in the RF discover/activated NTF handlers
> 
> This zero-initialises the on-stack nci_rf_discover_ntf and
> nci_rf_intf_activated_ntf structs in the RF discover and interface
> activated NTF handlers so that the technology- and activation-specific
> unions read back as zero when the corresponding length fields are zero.
> 
> Link: https://lore.kernel.org/netdev/20260623172109.1105965-2-horms@kernel.org/
> 
>>   - activated: with rf_tech_specific_params_len == 0 the same union is read
>>     via nci_target_auto_activated(); with activation_params_len == 0 the
>>     activation_params union is read by nci_store_ats_nfc_iso_dep() into
>>     ndev->target_ats.
> 
> [Low]
> Does the third scenario in this paragraph match the code?
> 
> Looking at nci_store_ats_nfc_iso_dep():
> 
>      static int nci_store_ats_nfc_iso_dep(struct nci_dev *ndev,
>                           const struct nci_rf_intf_activated_ntf *ntf)
>      {
>          ndev->target_ats_len = 0;
> 
>          if (ntf->activation_params_len <= 0)
>              return NCI_STATUS_OK;
> 
>          if (ntf->activation_params.nfca_poll_iso_dep.rats_res_len > NFC_ATS_MAXSIZE) {
>          ...
> 
> The function returns NCI_STATUS_OK before any access to the
> activation_params union when activation_params_len is 0, so the union
> is not read in that case.
> 
> The sibling nci_store_general_bytes_nfc_dep() has the same early return
> on activation_params_len <= 0.
> 
> The two rf_tech_specific_params_len == 0 cases listed earlier in the
> commit message do match the code (nci_add_new_protocol() and
> nci_target_auto_activated() unconditionally pass
> &ntf.rf_tech_specific_params even when rf_tech_specific_params_len is
> 0), and the KMSAN trace quoted in the commit message only mentions the
> nci_add_new_protocol() path.
> 
> The ntf = {} change still looks correct and necessary for the
> rf_tech_specific_params union. Could the third bullet be dropped or
> adjusted so the commit message reflects only the paths that actually
> read uninitialised bytes?

Thanks for sharing the review.

This is valid feedback, I'll fix up the commit message in a v2.

