Return-Path: <stable+bounces-242577-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFoXMaxl9WloKwIAu9opvQ
	(envelope-from <stable+bounces-242577-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 04:47:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 661D84B0B5C
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 04:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6C91730078AF
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 02:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4208A29AB02;
	Sat,  2 May 2026 02:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="LI20pGOW"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC72F175A6A
	for <stable@vger.kernel.org>; Sat,  2 May 2026 02:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777690024; cv=none; b=DZKU/NUkuCfY8YH2+3zvpNNPhxmySFf/9PDoRBatPFxITRm/DoH517VCWyM9KPZ0wVA9fJzE0ILA8Nwv3WPLe2LRn3DGe/CBYpf/BVH/Hr+skjFia9JxTP8B9zzrzC5IU5Z96JbGmGlRjAkWt6tnKE2j6PuK7iYVsXBhMh9KD1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777690024; c=relaxed/simple;
	bh=tSMYnDM5H2e10y5BmC3ZkjAM+49C55Kfw/f7EcmZPXE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rN+NoACKpLvEO5nlJnf4b+phQvX7Yqpc39SurFjE572PNMdKP3HHuYLS+bR0rlwFhwJ2Sq+JtWyaG8HR1l5lmkFJKog9SnKZ7FIZ0nAvVY8NXS9YLsehrKskYE5B4joPT5qOErXz4a2y3yjqscBK4HSX2AqDZirNkXpRvti0Cqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=LI20pGOW; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7de46b8e432so2369304a34.1
        for <stable@vger.kernel.org>; Fri, 01 May 2026 19:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777690021; x=1778294821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zi92tYGck5GFXXEw8rDlPOWI1ge2venpFEM/L+I7DWs=;
        b=LI20pGOWpwiSzeR241eYtBZIxknQxlIhGnjez3M7BDziflL5ncOhVu6tw5H6bdZOAy
         Azjite6KTyLqcoxJQdM9+PjO4QNEUkOGLfQsDTc6Zw7YqUc8mFPhZtzf+9Quny12W3JA
         68uH7j16Q0Yzwu9jVQZIncnTiei/ItMqUkuh02lM6uUqeI6wt1EZHNd9aLkQUzzbKKQp
         PdytAfS90YBgY4WW4DgLetZoTOoGuu4moa4kAXtktT5GdC8bDLX9rFgWULsMun4/z9sc
         yv7WYBU2YfV4lMusjdIjetXzLNrtLh6pG/JxMO9exUtCopw2QCU4VVDMmrPXsX+BzwZd
         7GfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777690021; x=1778294821;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zi92tYGck5GFXXEw8rDlPOWI1ge2venpFEM/L+I7DWs=;
        b=GXql4hLrTiVw2UJfRtEoFS77Wh2xhWm/Xt0A+2+da3vepAj1LOp9zYhnJilniL8nCp
         kPmC4Mv/yo9zqoWUJbNU0sTzUJz/1MNFTqW96/MtaO5p329fHnvtuXWBETVLU2n2p0vg
         6SWnWs3iTvqBpmVRn4ARGNqWDuOsed9HQPRiDKDqJcrq4voQd7YVfTPbiogkah+5cnpD
         HZ8U48vgGHNH18BzzlhBiZYtL9L3uowG9g6FwXpcB8B47u33kX1xX6znhm3f5q5tnIvE
         aHWfmurXcUt8gQtr7x7E9JsV/3Yrr5yET4VgfkEIiJvVmSrGGA/mNz1tUj9096AXf3C7
         mmow==
X-Gm-Message-State: AOJu0Yz9J4+wugYJ2uI9VoTisTYAlexXafmDw9BldsJTjH6gKT4t77bh
	rwhRAYQg5qZOmd3mae9Wha5cpEXDVM19mRvJoj7dcCocRUQ06jnHNUbek0N9u/N0jR6CzCUMOUU
	2PRBQ
X-Gm-Gg: AeBDievQ+YFzJRF72IvZfh69rhK0L1jQWlZA8QpddufvWQQ7iH97APyJLXdYXvbrYef
	H3wtXd1L1gWobv3hO9pTSkfQbOLR7JNRjwdIc1JwQgmEOTl2Sesrffskkbd0WMqiLZ9KEsU4YZY
	R+xCNzJvEP9TcR3m7iN5ZJJJIsLIjyWXuHCocUXl9cuzla982M2eIP5YBWor/dX93XjoTeiiQHD
	OBIhsXX9advka8vUql9Plz87uvXnR3C4I3frO+KE4eu2XIBjJKCS5plA3tct2ajPh0X3nVzXZfT
	7Ig5I3apv7SACfUnUKSFCeOD/5PfDcCv+FEpey6sxRl6Zss9krvEq+TNeWSL9FmV/9wnG3WGCK6
	6RZcpSgLZgosoj70UVw4xNF+m1eIEvYPQtl8Xh5GzjwasAuswZ3BVaSfb2iZSUMmEvHeb8E5Iey
	hZ8g+Jxyt6D6VhrIhseyWWihIRzaEqhq2xgMGxnj249mCEei8XMheaKGk1kLGN6MsPavO7XuZbA
	skW6Qvf6grr/MAdGxPv
X-Received: by 2002:a05:6830:600d:b0:7de:44a5:51cd with SMTP id 46e09a7af769-7dee1200eb3mr1143419a34.1.1777690020790;
        Fri, 01 May 2026 19:47:00 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ded1915908sm2599255a34.14.2026.05.01.19.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 19:47:00 -0700 (PDT)
Message-ID: <b61010df-a96b-4ca1-b068-04b260531079@kernel.dk>
Date: Fri, 1 May 2026 20:46:59 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/poll: ensure EPOLL_ONESHOT is
 propagated for" failed to apply to 5.15-stable tree
From: Jens Axboe <axboe@kernel.dk>
To: gregkh@linuxfoundation.org, azizcan.d@mileniumsec.com
Cc: stable@vger.kernel.org
References: <2026050100-washday-snowdrift-2968@gregkh>
 <a1b41674-0593-422b-93bb-edc3993d829c@kernel.dk>
Content-Language: en-US
In-Reply-To: <a1b41674-0593-422b-93bb-edc3993d829c@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 661D84B0B5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242577-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kernel.dk:mid,kernel-dk.20251104.gappssmtp.com:dkim]

On 5/1/26 8:40 PM, Jens Axboe wrote:
> On 5/1/26 5:09 AM, gregkh@linuxfoundation.org wrote:
>>
>> The patch below does not apply to the 5.15-stable tree.
>> If someone wants it applied there, or to any other stable or longterm
>> tree, then please email the backport, including the original git commit
>> id to <stable@vger.kernel.org>.
>>
>> To reproduce the conflict and resubmit, you may use the following commands:
>>
>> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
>> git checkout FETCH_HEAD
>> git cherry-pick -x 1967f0b1cafdde37aa9e08e6021c14bcc484b7a5
>> # <resolve conflicts, build, test, etc.>
>> git commit -s
>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050100-washday-snowdrift-2968@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
> 
> Not needed.

And lest we run into this again, let me preempt this by saing that no
this is not something that should get assigned a CVE.

-- 
Jens Axboe

