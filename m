Return-Path: <stable+bounces-211152-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHceMDAzcWlQfQAAu9opvQ
	(envelope-from <stable+bounces-211152-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:12:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7625C5CE8C
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BD61C3ECC99
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC473559C0;
	Wed, 21 Jan 2026 19:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="LjYZfC7X"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A4A2E6CD9
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 19:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769024580; cv=none; b=C6Oclar2145v2C/swbk8fsLdAx21u07NpaKsXHdy+iMGYPCQ4MLit50/tzg4yBfU2hTtc2xa/e5iTBxSBwwOD6RuGbcDl07GEx2aoHh70vNfLT2sFGxAQRZsE9JncGfRcyQcaePjDzP4flAQMLkyqHyFz9AgbRNCnAsDGD5VF0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769024580; c=relaxed/simple;
	bh=F1jquYdbse0f+h5PoDNJ9pGakn5CxPZjQwcYQH1T+jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ojr2BpKQmDsdaofLmajzJoFbg9LSZdBNmky79B/DW1yB+sql8NgN9uarnPgjlxQWS/4nFf5SrlcQEsKWxnlM0IF3bjwVD8y/s0918K6wZtpXzHAv/9QfZ6ENnCcNwcTtiVHIH/udZ10ea3yBNmVMYfJftWlpXDY8WXubWxpve6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=LjYZfC7X; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b6fd5bec41so334442eec.1
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 11:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1769024578; x=1769629378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DQvGCJmxpkROPmN9OrxKrrBVJtlOjFG6UFxmO3kVd3M=;
        b=LjYZfC7XW0ReDqdceYyCRzzO8cO0INzBeniWDhuOMniY2c2GQJurt3n3LxFA6n3Ikf
         IpCsWwWTZ9NOZhLEqy3f1zxDjNXj4kVtJVkNvXelBaKTmRLNclmi1H1TkMzLQWUtk0kq
         xztRmMel9QKg2MPg9Ujp30IGlj7KhYvOA1iEpS3W2bu3pP06GIwPa90jnb7qK5kaM3HN
         AqQXhBFsOQ3yA0MDSOgYJJBdKCIvhEadBASwf2ardiv2U0dh18g/99yGnsMl7cQm7y27
         5W0q8INYGL73nq8mQMohbbQIuooL2yc2lqbMeW43c5oUvi9gOYZxjEOoRWu14MyzEXpO
         TR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769024578; x=1769629378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQvGCJmxpkROPmN9OrxKrrBVJtlOjFG6UFxmO3kVd3M=;
        b=VGmGwldVsUFsopqu1eSiuwGWjl3BN17znYc9QQTKhYSZ86Dhf8EvJAe4QlwVq12usX
         EiHnD2UATS6dX3rxPrZiW+DasYe1NNWnyFff6AnZiGdLYiDvGH1BzGRELLJ+T6n7qjTx
         XywzqHOC3UKlhRcfmUb2YTdfeyA3DY/TUeL5FzOFgiR9UgR82FULz0aoP7VFWJanBA7L
         FM+2E+vdWo8Ivp9KSNcrCZBl/l4hz5fjq/SWJ5LGLpT6QVMPZcxSWacvcBlyzzYIDi1Y
         H3zvk6adr6abgni4Yu1uYpXoQg355tXec6u29u555ldrUE92knWZQGSFrIGdbn3TabFo
         tqhw==
X-Forwarded-Encrypted: i=1; AJvYcCUOe3pBXQdVqSlvog7FY9la7JOkJv6Cqd/VZ+hDmu0VuhsSM6wsfcD0hP9OoICRpXaoRG6eCrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO9DBdKQGXu5cDFbVHgDFTPAgxpTqeeCXjBhJ9jMbAK1i1sj6/
	LWMqTqgMET4l2E8ygCuWh8inYb3CEuK5db8SweUvO7H1MT2Zb1moOyMzAYePp8a0yA==
X-Gm-Gg: AZuq6aIxGwtLI7n8LExfZxXin3ujlWtqwRsObXBEVGMxKcQcNFRSln6D5PPr2zxCFDB
	Iso0b8gfSgKBZdu6NMRB9QWKYtJMheV6bHLEd5ekG2m9yOT6eZbx8L5t3sszRrQN3BYxLWb08IS
	SWV7UEVFRN7JlwAQH+YWjQXGvYNww9WwVhdB+KU6Zov6n3J6rGbN5BsvFpWnryCaxiOizQBy/9u
	4OJzWTvalodbUIIQtV/XadZuZ6biv2IY9CGv3BTL+QZ7JTOkVF7Lgo+2fxRkbwwA0PVDGv4d85j
	TyDMDcGGCGFf4wtvsG0VeWm5941xbQtsOzesig4soD3upGhSaINE0mFeyv3ICY9KXedEXOdM781
	S+EdkCGxIYJWMailowg5umfXTL4aeUOHcImKIcKVPHmin1vup9F/m9GsHaO58xaX9xtBhH+0UUV
	rHmqYBUkUSJpk+5cNfr9sham+Xh0pfZEjF
X-Received: by 2002:a05:7300:cd8a:b0:2b7:1320:f280 with SMTP id 5a478bee46e88-2b71320f4f2mr1913474eec.15.1769024577414;
        Wed, 21 Jan 2026 11:42:57 -0800 (PST)
Received: from ?IPV6:2804:14d:5c54:4efb::1c9d? ([2804:14d:5c54:4efb::1c9d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7171be2dcsm3022869eec.11.2026.01.21.11.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 11:42:56 -0800 (PST)
Message-ID: <e58a29bc-3512-47ce-80cd-6c96a879c9cc@mojatatu.com>
Date: Wed, 21 Jan 2026 16:42:50 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/7] net/sched: act_gate: add RCU support for
 parameter update
To: Paul Moses <p@1g4.org>, netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260121131954.2710459-1-p@1g4.org>
 <20260121131954.2710459-3-p@1g4.org>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20260121131954.2710459-3-p@1g4.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211152-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu-com.20230601.gappssmtp.com:dkim,mojatatu.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 7625C5CE8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 21/01/2026 10:20, Paul Moses wrote:
> Make gact->param RCU-protected and reclaim old params via call_rcu(). This
> follows the pattern used by other actions: act_pedit swaps params with
> rcu_replace_pointer() and defers free via call_rcu() (commit 52cf89f78c01bf),
> act_connmark uses rcu_replace_pointer() under tcf_lock (commit 288864effe3388),
> and act_tunnel_key does the same under lockdep (commit 445d3749315f34).
> 
> Dump readers in act_ct and act_pedit already use rcu_read_lock() +
> rcu_dereference() (commits 554e66bad84ce4 and 9d096746572616), so act_gate
> must keep old params alive past updates as well.
> [...]

I think you could've transformed patches 2, 3, 4 into a single patch.
Since all of them are RCU-related changes and they sometimes overwrite
each other.

