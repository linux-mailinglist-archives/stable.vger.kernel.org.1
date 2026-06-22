Return-Path: <stable+bounces-267702-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B5cvLZE2OWqdogcAu9opvQ
	(envelope-from <stable+bounces-267702-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 15:20:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC416AFC5D
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 15:20:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=j+ZckDqA;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267702-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267702-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 313BE303C4D5
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 13:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E883A9D99;
	Mon, 22 Jun 2026 13:15:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51131399892
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 13:14:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782134100; cv=none; b=ZOVbsM8PIwf79qcL/KFThFVC/9r84OydjT2ri6TnlV5RHLIPQFG4GPxvuZhLbNvrjxXL3tgQlP7eZ6EoG0aeOOlRwVMnPfnHcvUGHmkSfPmkqriLHgqhnamTl358G0U0XdMzZf6TyMMFrAMA0LBSF/KBXn42Qc2wAvbBxDTkyXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782134100; c=relaxed/simple;
	bh=xa1hjaasaI7IT2vVjjP/pA5Wb8cEBgn5Wo8PqC+3j7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GP8H8H+5lMJv32ra9Kd+e4AJlQXzYjEZz3x14Tnv3Cj/O7TNbrVBkrYmLMa1AaUcI1oCbtCw0yBr+jwW3CUd5QQxs4a9t9HBlRdL02QTRshW3qIU3qeMET8sowgr0UgBaef/gloX/22wd1CO8JGbwb+MbkmRlMpM1PEMJheLkck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+ZckDqA; arc=none smtp.client-ip=209.85.210.182
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84231305a80so2689443b3a.0
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 06:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782134098; x=1782738898; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KefHasFuO8oytHQlky2XzelXz+LgqAyeUKiwcFqk/0=;
        b=j+ZckDqAqz7tlg3PchKIAvo4RPOixvJH7fe3rnEafqr/ODqI5V6/0ux7OTxHPt7m+W
         /dSzvMK++JofmzdNBVsJwlcbneQT67+tGggXUkBBQb+xPRg87eqRN3yTjHtVJZ2/t64p
         9TFNv2st0LVVsVdTFjPTjAvcCQ0OytLWUDxSl508cEYvjqZFbArRzTekn3lHpbEvgRTz
         NABlsQgV2/0yOqE2ZFNLHfrmXk3/OYtsCHj31RM/wVpEw1MDf4lp3NfTbEWu6kJ+eVOL
         NKgF7TJ2pCiITYWKa8PxYQQKqjSENd7TemRxUBdSs/89mFw+NMRl67Z5BSG44ya2BjM7
         VNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782134098; x=1782738898;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3KefHasFuO8oytHQlky2XzelXz+LgqAyeUKiwcFqk/0=;
        b=fqEJSL2uLvrLt/kGHayJxe47JkLKd32p6IDvE4OVfMflhIOjLf76Wy6hiHo6XSK4MY
         AcKQFfIrXIlZ9Vh4tvMWbYUl0PFHxWaEg9IKxSIadfKBabwTmcm92e6j/6ffp57yZEx6
         FpMp3OQeBk9hdpB8ulhTUeyeZSUGKY0brJ5q29rPMCYEtLLwKPrrIUZLVvARExg/vy3/
         EQPHP/BuFOzSw/0S/Sd1Q1AWUE3Ga1DmjOLUwgi3MgjHOM5JNz1EJAe/S00yuTk+eC5R
         nMcd1wG63zhW3M6EBcIvfU6+cbfYCfXbH7T8MOqAZKzHMImCr0Dlpi8Q0RNreoC2h5M2
         fTjQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Nuopea39FZ8J3QlStsiAC0d9EGLOf/rwPGUZvTpOT84hRv1YdkcUKKBCAc/VLO4EwmFo2LwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU4CqZkModv+tFSNW+33UYLr63TtwjxQHh7CwWQcKeSYMrSBTS
	mAvwE6H6PfJlIvHR8Fpt/4obu928Cpb1gNZGENyYhpQxyuW2CuUER5/z
X-Gm-Gg: AfdE7cmQ8KDCHbw1uyZN7RwX3c3U9msFyb3bHvgtfwe+PCpjmrr730OVuy575yQIcai
	psHE4rnbR3JjmwWdNYbHCzo6ko9mIXl3GVylujje3s7LB6UiL3A04kno/MEy1Vq+++I2tWrbeqa
	CoWaCeKOKnKd3pxlxAQDqn7KrrSLxeqRIwlm1omsPs13/ghg6xrEDoM7RQjWIajbrmrbJ77Yh8G
	54OHk947jjbQdUzSVQFZrtDclfSC1O2kN7ablTkcPae3oYWLzjSLlwTWLA/6xNa+oCyQWR54U+3
	FdD7OcOHF/mKMhELLBFN2zy+V9a914lPx26Wc5GH/kLily0Em886Jj6qfAA352DZEo0PQKhYtSK
	Yip6qtopWBB+6j3YppL/5vLzOGfDivQ2vEyL3Sv+9AzNyXXdaNYamyak7sYX5gW/nZr10aYHzPW
	B+x3IDLHGURCo=
X-Received: by 2002:a05:6a00:2e25:b0:842:5a8d:303a with SMTP id d2e1a72fcca58-845508a232fmr15109349b3a.37.1782134098511;
        Mon, 22 Jun 2026 06:14:58 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564d8dddbsm7662685b3a.19.2026.06.22.06.14.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jun 2026 06:14:58 -0700 (PDT)
Date: Mon, 22 Jun 2026 13:14:52 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Wei Yang <richard.weiyang@gmail.com>, lance.yang@linux.dev
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org,
	riel@surriel.com, liam@infradead.org, vbabka@kernel.org,
	harry@kernel.org, jannh@google.com, sj@kernel.org, ziy@nvidia.com,
	balbirs@nvidia.com, linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_vma_mapped: revalidate and do proper check
 before return device-private pmd
Message-ID: <20260622131452.ox6ciole35ojmyd4@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260622130651.23359-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622130651.23359-1-richard.weiyang@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.dev];
	FORGED_RECIPIENTS(0.00)[m:richard.weiyang@gmail.com,m:lance.yang@linux.dev,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:riel@surriel.com,m:liam@infradead.org,m:vbabka@kernel.org,m:harry@kernel.org,m:jannh@google.com,m:sj@kernel.org,m:ziy@nvidia.com,m:balbirs@nvidia.com,m:linux-mm@kvack.org,m:stable@vger.kernel.org,m:richardweiyang@gmail.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[richardweiyang@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,master:mid];
	HAS_REPLYTO(0.00)[richard.weiyang@gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[richardweiyang@gmail.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-267702-lists,stable=lfdr.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1AC416AFC5D

Oops, miss the v3 tag.

Also add Lance who gave a lot feedback.

-- 
Wei Yang
Help you, Help me

