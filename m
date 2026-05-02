Return-Path: <stable+bounces-242575-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKA2AC1k9Wk5KwIAu9opvQ
	(envelope-from <stable+bounces-242575-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 04:40:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8D24B0B2B
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 04:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EACFB30093A3
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 02:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A34E155C97;
	Sat,  2 May 2026 02:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="OP5Aazxt"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8DB40DFBE
	for <stable@vger.kernel.org>; Sat,  2 May 2026 02:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777689636; cv=none; b=SRuGCoxerbJ1zDL5FAvA5Gb6sIQbIgeVtde+pasto24IE2uPEG4tS90QdOoFi/HqyDgOrTNBfjd9iJ+d2/28EAMXOkTTZFXniITrr/OpgGFbXjN/o+lwHl2PmWJi9cT5xpTgpRC6Pc6vmnM9xoRvYZaRCSi7yqkuzIrXAkZ0s2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777689636; c=relaxed/simple;
	bh=0QD0ko2sbwngG9r8ZpnSDdFRny5nIwFEBztZA/CbLIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dMJQT1Poh0r9gDPwYhGpNWbyvnyVNfMcnneBphhd3gzcGjSbiLjHdz6dk/zFIYkhjDu+LVCvqcg1lItoZhXry6d1pbGvEpSkxlkDEldiTSG5B77YIS81yirMii1OSdAJDo0haim+rXC36sJGkC6JXqHjD/838lOnCx3fOG7jiQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=OP5Aazxt; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7dcd689829eso2223089a34.3
        for <stable@vger.kernel.org>; Fri, 01 May 2026 19:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777689634; x=1778294434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ykmHSfTa5HqGMg2BWxWaJItNEKf7TZk4BT5Y5aqIvy4=;
        b=OP5AazxtKq6i9deeNfy7F5x17Ji/XqCHASyRp2tc+ZuLTEKVTNfBtUTzQu9htx+Mjl
         iYk1QUdvoZKxonUKbvQXNn0pk9bsnAqhZvNSmxD39xk2ogKXPfPEgEbvFC0Bj7yzjaQB
         jEk0btCem/SWtNxDl5gWE3HeC/2pD+XFx6NPafSSGrE79t/DMI87fL7/goDhh4PRqJQv
         eyOwJtBWf5lnplTqQf8wxW0FgQUaAHiLiAOX8tmVRHkr90PfVNbgtQhOYtTw3n6rMGpT
         y4h3uK9JI42iO7Zbit/yUxg7cWjMf9qX6fFR1+G8wMxXQ+MQUssnSwM1eXp7VrPd8/sF
         JnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777689634; x=1778294434;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ykmHSfTa5HqGMg2BWxWaJItNEKf7TZk4BT5Y5aqIvy4=;
        b=ErVH6Ak4srs2s1GObI3+0q3WE2WJ6v0FousczdsW0tjP+i6pNxPbnjObPcLyfTujXZ
         1hyT5OGBds98FCzgTVaQNrPLmjy0kMEUNF7THxxxUHJJ2yoxEg7xR2x5HroF/sYoMz/x
         QCQhCVNmiKt51LrJbmSeClQ9ltV0LX0mvGMF0nKDB8/eN01Z8JxniTPZ1pAiubFEOmgn
         unXQq0WR6bSY3RRg65xbz+YIRnksWzu1Z5pddUiEyUBh/8JGbYkfqfvlog2gN2NmMLVZ
         rToMB80+JAkl4wukxwsg53lDSSiv5yR4voQH00y/2rnmJeBOBqRal0Z2rq8ZJq/5qPN5
         zloA==
X-Gm-Message-State: AOJu0YyKdWvLtFClm+MmfbpohLDzUyf1RDveUEi+loDmuIEkrYh4KsJr
	Uj0Gt7n4I10/i5ZZtZYZg2LFjre+pvqWsjmr0xqf72iPgS6ClN0yeC19CfRvZ9she5YZ4d2RJyA
	sUsvd
X-Gm-Gg: AeBDietYFjFgACYFgpqMHHD2NIXJaCfvDkaot+AaBpdTIbGI4UPXC/rhAGnljbf1IHK
	33LlrsyGsB5nYpq67wFxEBixRqDwDxYSBMKT9+QW7jQrL5V6uSKPgl4sUCzTLI2AhAFeTOcc3IJ
	L7EtcATw0isn5Nx9Rat7QoPDDYDtO1/PthfjncCYwS5nLoGyJ0SVHEnkUavZOoVqDKHSLGHJv5x
	8q65DMV61FBq3SvcqV2KjWg2HgV21e5n/styIYztWi16pssiiLYPMP9dFoxZ1NzvFx88QARIudU
	4fJEioMOspMLN6DAYtNVu/Yin67OujV/j3yvkdgvASfuIaRsd2qhSr3PmvzHXlP3cgriHc6+OU6
	bDIdOofXoHTywTXPOYx+SeHxUXUJlm1Jq2BuUcl75D0avvYUH/1TKUkWKrRekj2Sg83OTbpOvxt
	h5hacawkXMvU/CVIo1f1fCmeduFFf8gVGyBY5BmIoWZ1QTRtAxTTLVjHkW8X+hQQeAOXqZP7yeE
	3+Bqvvb8gUqnETSbeGp
X-Received: by 2002:a05:6808:1822:b0:47a:8c2:a54e with SMTP id 5614622812f47-47c892ad2f4mr1045883b6e.34.1777689633930;
        Fri, 01 May 2026 19:40:33 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c763b2ef3sm2454740b6e.2.2026.05.01.19.40.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 19:40:32 -0700 (PDT)
Message-ID: <a1b41674-0593-422b-93bb-edc3993d829c@kernel.dk>
Date: Fri, 1 May 2026 20:40:31 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/poll: ensure EPOLL_ONESHOT is
 propagated for" failed to apply to 5.15-stable tree
To: gregkh@linuxfoundation.org, azizcan.d@mileniumsec.com
Cc: stable@vger.kernel.org
References: <2026050100-washday-snowdrift-2968@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026050100-washday-snowdrift-2968@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: ED8D24B0B2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242575-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:mid,kernel-dk.20251104.gappssmtp.com:dkim]

On 5/1/26 5:09 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> git checkout FETCH_HEAD
> git cherry-pick -x 1967f0b1cafdde37aa9e08e6021c14bcc484b7a5
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050100-washday-snowdrift-2968@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Not needed.

-- 
Jens Axboe


