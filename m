Return-Path: <stable+bounces-233293-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLzsGGpJ0WlwHQcAu9opvQ
	(envelope-from <stable+bounces-233293-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 19:24:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C1B39BF10
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 19:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8B70D3004D0C
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 17:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73424332EA2;
	Sat,  4 Apr 2026 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kk8rrRmP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4BF2C11DF
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775323492; cv=none; b=ciCsXqV6JvYyJ8V3DsGV6Y6d3nUeOaapTgazvfjYOAD0acmWY83jpNOqvDNoclIEDR0ulzEYZzFGajsafrWlMaRQfL8rNeTzLc1ZucsN2YZz8Mn5me/O+0oFK7uimtsB9iWlUsVhBAvnk8NSu8y4KGe5A9OzfxIbo10WR+l0uqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775323492; c=relaxed/simple;
	bh=2ilu1jQHox2wTnDUggPiw1YzGE41A4ol+N4ZXaAB6KA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=CYp3XOqC3oMLOPECN9ezbrRPPfTRISIev00h1pv875cmTq8hxC4VTWIGxqTNDKtJBbvmb0OUUUfYDLyFihDIlnW9f2cU6h64hIVpYeeFZpIdNRiFTBTAJqu6B/BQyWTA31ZM5c1xD6f9TYItfpNu9mAPXGr5I7QuM4FMx+xBny0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kk8rrRmP; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c76af79f029so1067953a12.3
        for <stable@vger.kernel.org>; Sat, 04 Apr 2026 10:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775323490; x=1775928290; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1oGf/F8Zl1olrj7LHwmAzkM6a8hyoOTJaO/XdIoQa0M=;
        b=kk8rrRmPpX7wAXHUbZx/ke+qQGAuwWtLhIiRmt5/bjDkrdTaLaP42RRuL8RM9UnR8d
         iRp2ZawRGYlV5yhKaZmcviKkrYAGB4pQSf84bpqtiD5VN+amsk5ARKpN4Sg4e2VhUvEI
         MBb5bz7P6wruAhSAA6Q1ZK0SNt+sAGsfQ+rwp02WiBKP3eBFVA6FNoQ49OquAdamIX2Y
         qcGVIIhbHlf3adsicex7fvdtjycGxax5n0m5XaSGvMNfIsYflUQjl2ly1/dhNIqV9/2Y
         B91W/A7RMtYE8VXS8ME1KD2Ct9/ZoXvU5Plm32bNXhBxwVQeskDJT/1pdAFnLHkO9omW
         a7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775323490; x=1775928290;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1oGf/F8Zl1olrj7LHwmAzkM6a8hyoOTJaO/XdIoQa0M=;
        b=knEcReICA2rhAybVnrbYsJZjJ/SS+6SPLYJJ2k3w/fG0F7Oz+gPAbchloZCLhorj/Z
         hkB8vQ/hhpMtWp0ezxYd0YCzyq1sjWEs2FqNnpw9iwlWsoxK/HWAIkgiRpz1lekGY41L
         +A1frICvhQdkGKbZFeqfq6sfUfTG9uNxxUtd5//iY7fZZTf6DZtoiTV9xiTncngOtKfE
         A6hJbIqtUn3ia+W8zvE4N4w+F/qfMIOswZEj9jQVs401viI29XURv0r8kQmTbYu+vuzk
         lM289Ydb195kBuca6TW2eSaB1wloMixGY8K4XGOoNhTSuYbQHhQaUoU4aCXlAfWMJhk8
         U1lg==
X-Forwarded-Encrypted: i=1; AJvYcCXxkey8YNwdoxRHN+XaYdQfKm8BY188IS5LH+BQ6q2qaJdaJ+WmWXDLcisww1AFA6e80P3GYPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Awn+FjTsw39MjvSoWA1lnD0s25K8cAOF9xlUUoQodulXMUwh
	txFdKGDYor90FDtjXegjoL9LKgSMNYuFyXacyNHb8wotBMVgv5Kk20Vi
X-Gm-Gg: AeBDietHBk/VP/r31AZdd9W8notAhqtpeoC0KqXSvYfmRUD9qxum8941EYw+gRG5ogw
	q0vuP6n94yvNPMgeahGrayCRWBUJruXyb3MBMNlPvD081t71zFVmY1mRW9Ao9GFBybyKRgz2Rhc
	Qhqv0Q5hRoVrse//Cqb1uOwqB/Dt6/XDcA7oV32xcvThr6L1fRda9vCagr22bfJLn5ZiolB3v2k
	VoPrZUpauE98VlOA/1lHzJeciQNppVkmAo7DyzcxGUF4d1ic7GjpxNYvOnhKtXWETznmyf3053W
	cB0KDUtnTIdG4porZXgvhfl33xqOHJgHqjEBQ9qLbUvSdVgeH0CY3hBgxx0RpDXt4ASTRNZZCNk
	DWttZ0EkMunkOLbjiHKwfm49FFWgvBaEgdnD61pWCpYPCR8WkxpVOdX8rjJ80xNW59aQsP0+b1/
	AEx6pQ93uJG4JoGcnlbtIDlg==
X-Received: by 2002:a05:6a20:2454:b0:39b:8dcb:f37d with SMTP id adf61e73a8af0-39f2ee01ce5mr7551700637.17.1775323490281;
        Sat, 04 Apr 2026 10:24:50 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c657e703sm7990160a12.22.2026.04.04.10.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 10:24:49 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Matthew Wilcox <willy@infradead.org>, Salvatore Dipietro <dipiets@amazon.it>
Cc: linux-kernel@vger.kernel.org, alisaidi@amazon.com, blakgeof@amazon.com, abuehaze@amazon.de, dipietro.salvatore@gmail.com, stable@vger.kernel.org, Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] iomap: avoid compaction for costly folio order allocation
In-Reply-To: <adCQTF1PQnlbNMO8@casper.infradead.org>
Date: Sat, 04 Apr 2026 22:17:33 +0530
Message-ID: <5x66n04a.ritesh.list@gmail.com>
References: <20260403193535.9970-1-dipiets@amazon.it> <20260403193535.9970-2-dipiets@amazon.it> <adCQTF1PQnlbNMO8@casper.infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,amazon.com,amazon.de,gmail.com,kernel.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233293-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[riteshlist@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0C1B39BF10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Matthew Wilcox <willy@infradead.org> writes:

> On Fri, Apr 03, 2026 at 07:35:34PM +0000, Salvatore Dipietro wrote:
>> Commit 5d8edfb900d5 ("iomap: Copy larger chunks from userspace")
>> introduced high-order folio allocations in the buffered write
>> path. When memory is fragmented, each failed allocation triggers
>> compaction and drain_all_pages() via __alloc_pages_slowpath(),
>> causing a 0.75x throughput drop on pgbench (simple-update) with 
>> 1024 clients on a 96-vCPU arm64 system.
>> 
>> Strip __GFP_DIRECT_RECLAIM from folio allocations in
>> iomap_get_folio() when the order exceeds PAGE_ALLOC_COSTLY_ORDER,
>> making them purely opportunistic.
>
> If you look at __filemap_get_folio_mpol(), that's kind of being tried
> already:
>
>                         if (order > min_order)
>                                 alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
>
>  * %__GFP_NORETRY: The VM implementation will try only very lightweight
>  * memory direct reclaim to get some memory under memory pressure (thus
>  * it can sleep). It will avoid disruptive actions like OOM killer. The
>  * caller must handle the failure which is quite likely to happen under
>  * heavy memory pressure. The flag is suitable when failure can easily be
>  * handled at small cost, such as reduced throughput.
>
> which, from the description, seemed like the right approach.  So either
> the description or the implementation should be updated, I suppose?
>
> Now, what happens if you change those two lines to:
>
> 			if (order > min_order) {
> 				alloc_gfp &= ~__GFP_DIRECT_RECLAIM;
> 				alloc_gfp |= __GFP_NOWARN;
> 			}

Hi Matthew,

Shouldn't we try this instead? This would still allows us to keep
__GFP_NORETRY and hence light weight direct reclaim/compaction for
atleast the non-costly order allocations, right?

 			if (order > min_order) {
				alloc_gfp |= __GFP_NOWARN;
				if (order > PAGE_ALLOC_COSTLY_ORDER)
					alloc_gfp &= ~__GFP_DIRECT_RECLAIM;
				else
					alloc_gfp |= __GFP_NORETRY;
			}

-ritesh

>
> Do you recover the performance?

