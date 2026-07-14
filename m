Return-Path: <stable+bounces-274158-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mRiVHrfWVWqjuAAAu9opvQ
	(envelope-from <stable+bounces-274158-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 08:27:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F3F75177F
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 08:27:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=aPMP8etj;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274158-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274158-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6847A3030984
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 06:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C207835E1B7;
	Tue, 14 Jul 2026 06:26:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6214C27E049
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 06:26:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784010416; cv=none; b=eMtq9tvMiy7rsEF3jB0f91e70QdISsUS0MfnKDzKLrKyVC7uK9LBlztHNT4p0tv3i1tPVGp2+b6Q5tH8VFc8cYpCqk5YowBdIqTUTY3iF8E0bveEi4SGvEp91aFIgK7pbG4skrlAR6NnIkUCiHaq2WcXSMmpFQV1tkHSLD2S4Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784010416; c=relaxed/simple;
	bh=QOlk4/7XmS+Dvvh4zsIn+c758NQjUwIDEuJ6mCb1RhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WqGVZpHLuEDncTo9nI4qnkgeBoQxyeZz07ZgQeylYqJiKqwmO/Ie17wwWsXvGEwKV6S67DSQFt36bqmp5BmQacSkTHn65k6/v2tIMK9NZG9rDWGCZTDKYPZWXMopkAQCxQViRB2rc/q4ftvR39V6+PYlJ7eL4iWcGT02QpvLf7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPMP8etj; arc=none smtp.client-ip=209.85.210.172
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8423f236418so550291b3a.1
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 23:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784010415; x=1784615215; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EWLEhkqERYcaPy6Lu/sccZNkhKmKRgHN8QESefuPqFE=;
        b=aPMP8etjYNiopWIan9lE00b4S+ViPJ78K46NPzpWtWAhZkCRQSGNHqN5J+6lpGeNMD
         ieedPaQapP1v58Qnod49jeDe2rVBuuB4XVsY4b4B+LBuoXL43vX6TUOav210uXIVqyQ7
         xqJ2vuDi0mXDwWTP1F1oSndgmkz0wkHS9YRD1omqn7dGeFbpN4DoyAdyXvq1y0XqM5iQ
         0Mppmu9RFcfhWRw3BPxZhh0xOcutuKrjrmgrJ5SblZ1iCFKRClocU5OtIE2/AGiU5Fft
         7Bcbj+nexjbPVpZ/eMSGfz4SLNOBael+98vRCRtr3g4EvL6Ix1+8K5StjOneXK2A5WhO
         ieOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784010415; x=1784615215;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EWLEhkqERYcaPy6Lu/sccZNkhKmKRgHN8QESefuPqFE=;
        b=IVe/dVYsEbbP3ctprj6K8r/KGBtVa/oKZP3YtABZdsATL5PbtY9EoMgoof3QToTz4B
         J+4Xcy1vBTcIb+CBrXEgk0UtZ79YiGLMTi/0oAlqcXRoQw7f+A6eBp8zSBgaK+ExtnJc
         5B2CLglecelZT86D9TQqvqB2USeOPNuWm/ll9/bwoB3uR5kmiClMouTncmN3AANty4mU
         mwcBH69xlZKta/dhUuZjns1DWugu6HNmRJ+gHK8xqBBPmQMNVICCL8vBr7C69ZTu1bIL
         fa/EY+KQ6lM109vhlmdL02FjAAancTCc8bFAiQQU+C6bIzACU044IgaVtNauTNBAHn4M
         nQ7A==
X-Forwarded-Encrypted: i=1; AHgh+RpJ7QvCL4tqhw3imV/ai1JMpqHaYkBDxo0HxMhy2ztpZLfJCa+HPHgh9VXdxYarUjkElouIfyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCluDDaBpf/IhL3gXyIfF+jkecU53sPC3SCz9TNIJQ/omlFN0C
	8G8qitH0+XvjPgSQgGz3hi2gyCaDBH/zGcN8LkYQNQBsG74f1RYxxA4H
X-Gm-Gg: AfdE7cmPQl02JlZhYlpV42pYhvXB2kCjNZ0LTbJzcsBlvlchsXsYxiRufwnfjZln4sU
	NtBGm99d5PIa81HbE2pnxSW9vEFyBulZZv3bf+r06qIXgOMXmmnGRVbNCB2OMn9qU9c0Q61YV32
	5ATx49eO1kZs1++KOcnSSrq5JEXMdXjLNf7H+V785WZk26oA8avMLpShmPz73o5Zn6cpi7z8XxD
	fLrDqIsNuNPeNHZQyiv/g0V6As9Ut7lu+bE6IBRsrJdfHUtsL68MxfbdF4rqqbE5dMHNQpBX9ll
	7KAAU8yjexZw6ftIU8aqDcqen8KO4Y+Z14ZIydwgHSoKIf66ooAkl9cpV2gWp8EdtA6Fm+TSRzp
	0ZH7BoePmLq4hIY9/o57eaB7/q9ufPYcHK/Fyk3iIYte2BB0+V+yXvvpAtHt4p7kkEqSoq1i7Nh
	ScNkWJsaTPKLegTaOCbobgzfUgAsdUF0VA
X-Received: by 2002:a05:6a00:3cc7:b0:845:d274:c01a with SMTP id d2e1a72fcca58-848896eb1e0mr11054809b3a.51.1784010414616;
        Mon, 13 Jul 2026 23:26:54 -0700 (PDT)
Received: from [100.125.248.95] ([124.70.231.46])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f242999sm932902b3a.1.2026.07.13.23.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 23:26:54 -0700 (PDT)
Message-ID: <452a57dd-43ce-4694-9164-8d2512d37417@gmail.com>
Date: Tue, 14 Jul 2026 14:26:11 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] jbd2: check need_resched() when skipping busy
 checkpoint buffers
To: Max Kellermann <max.kellermann@ionos.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 jack@suse.com, stable@vger.kernel.org
References: <20260713102229.1598812-1-max.kellermann@ionos.com>
 <20260713102229.1598812-2-max.kellermann@ionos.com>
Content-Language: en-US
From: Zhang Yi <yizhang089@gmail.com>
In-Reply-To: <20260713102229.1598812-2-max.kellermann@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274158-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:max.kellermann@ionos.com,m:linux-ext4@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tytso@mit.edu,m:jack@suse.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[yizhang089@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yizhang089@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A7F3F75177F

On 7/13/2026 6:22 PM, Max Kellermann wrote:
> journal_shrink_one_cp_list() skips busy checkpoint buffers when called
> with JBD2_SHRINK_BUSY_SKIP.  The continue statement on this path also
> skips the need_resched() check at the end of the loop body.
> 
> Consequently, when a checkpoint list contains mostly busy buffers, the
> shrinker can walk the entire list while holding journal->j_list_lock,
> even when a reschedule has been requested.  Large checkpoint lists under
> memory pressure can therefore cause long lock hold times and leave other
> CPUs spinning on j_list_lock, resulting in soft lockups or RCU stalls.
> 
> Route the busy-buffer path through the need_resched() check so that the
> shrinker can release j_list_lock and reschedule promptly, restoring
> parity with the clean-buffer path, which already checks need_resched().
> This does not change which checkpoint buffers are eligible for removal.
> 
> Fixes: b98dba273a0e ("jbd2: remove journal_clean_one_cp_list()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Thanks for the fix! This looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>   fs/jbd2/checkpoint.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index 1508e2f54462..5266017565ac 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -389,7 +389,7 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
>   			ret = jbd2_journal_try_remove_checkpoint(jh);
>   			if (ret < 0) {
>   				if (type == JBD2_SHRINK_BUSY_SKIP)
> -					continue;
> +					goto next;
>   				break;
>   			}
>   		}
> @@ -400,6 +400,7 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
>   			break;
>   		}
>   
> +next:
>   		if (need_resched())
>   			break;
>   	} while (jh != last_jh);


