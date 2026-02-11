Return-Path: <stable+bounces-215774-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Ao8HElNjGmukgAAu9opvQ
	(envelope-from <stable+bounces-215774-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 10:35:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE831122C7F
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 10:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BD9D30293C0
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 09:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32923563E8;
	Wed, 11 Feb 2026 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IXRCF1Wo"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D82D3563C7
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 09:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770802424; cv=none; b=FRC6Ejcd1W+21N3KTWVAhyCmtGQ77lqYaJhsaOxERbZx1E12gtkPKOR1zuEWz1IzTA/tUfgYBAiONaqX9wMy5336G1Ifa/sxnFKNNCzia7fzYD7fDqyd4tSikCVazCX1nQgGBH6dhZhaXtQMf7aqupAxJgi/25P+gUnDVRpJmRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770802424; c=relaxed/simple;
	bh=Jn6JW+PcnmjP1UmFcLchaQT4PtjymSShen7dr5SpZyY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qV/1rnLXDzPuIYCFbvtwf3U3Lg1znc/iyVjqUGOtwkPJLgQFcH3rHgQhimuG/Nn1pXjJBoqjsU/mDXyBw7PmcFL8NUgQY7JzH8dDwHKMSvrbgoN/j3CKfEvYRrMEHl5yTNqL/bNxgFZrTZWPNr+tYpFaW5ddDJRWA8ctmveVjx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IXRCF1Wo; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-43637c70876so3015871f8f.2
        for <stable@vger.kernel.org>; Wed, 11 Feb 2026 01:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770802422; x=1771407222; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9qU5Lf22Nxvjp9ugvIWPtP2tP1pZokMw7O7FTMgOuno=;
        b=IXRCF1WojudjQb2HH58AZ3erN9rxUBbIfeIQ0yajt7iB5qBQEQXKhWsJJhKzBoh5wZ
         EzLbXmqH2ZQeqNgBRcOLKtQtbUinHAgx79jZD//UJmTvEj19qp2gWP4L50FkPjtfcnIC
         CNIIJLmvzqfKhk8drB2tYdnWsiJCoyV+wsJnYeZ9Dt4pRXMZgb1fwEDyZXa/ekx81c49
         ZVkURlFrwZAD4cCYjChvaGBB5uJTP7UaSmaytSkRjarmIwfzm4hCXiqRbXY3VQvEJD5y
         //YIyFeC12hGJn1cxKnGrhhB4U2x7VBWMkBtRuPpQHOryJFIAyMnk7uAEeDmsX4gR7Hx
         GHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770802422; x=1771407222;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9qU5Lf22Nxvjp9ugvIWPtP2tP1pZokMw7O7FTMgOuno=;
        b=Bue6hXR8qvlp6v+8rBQwviXjRhUAWZX4cBGlJFrKyOG8B40nSvSdC40UtaKrmJgcAx
         71Xc4dn6DBGBF4YYOn+QyFG2w+nFA6M327R8QMF19UDa9Pv0Df2JZjvc875XGDzSZo+e
         PBidJPICP6h2JCJUnong39+Er18otKneADHb7M+dTuVlvwoJjgM6O7yPx44es1aTOFuL
         oYNuRfM9s3uepmkORRDna+y4HHYFlTeOJm0otciX6m6oV+f9VeVrmtZtq3jZcIe/6ngL
         aRgZwDacOqHMO5NoOBxtCilhRmGnLeBaDhN1l019Clw2kV0VSli1dfTpqPSEjmko5SAJ
         NKIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXXypvlEB7ACtGSe9MMZ8xCDN9tz3Rnsx/WN3eXAq/XicU1A9S6SSGi89oxE3/GV0JkHBpeGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgDn0i95o9Qcs9ofVDNSimtzLdpCZItcSKKiTuCqNG/kGYPQFp
	p+VIYH8nlpPPWrut5v1dat0DMjopbz63k0BI8ekqpJRkQA76EL8HA6RSery2wVQzXooqB5ffahw
	PswiebQi0zomLYw1FIw==
X-Received: from wrbay11.prod.google.com ([2002:a5d:6f0b:0:b0:437:6d47:80a1])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5f42:0:b0:437:7168:af52 with SMTP id ffacd0b85a97d-43782b1be58mr3067328f8f.11.1770802421800;
 Wed, 11 Feb 2026 01:33:41 -0800 (PST)
Date: Wed, 11 Feb 2026 09:33:40 +0000
In-Reply-To: <20260210232949.3770644-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260210232949.3770644-1-cmllamas@google.com>
Message-ID: <aYxM9JbH1tlTtxqi@google.com>
Subject: Re: [PATCH] rust_binder: fix oneway spam detection
From: Alice Ryhl <aliceryhl@google.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Matt Gilbride <mattgilbride@google.com>, Paul Moore <paul@paul-moore.com>, 
	Vitaly Wool <vitaly.wool@konsulko.se>, Miguel Ojeda <ojeda@kernel.org>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Tiffany Yang <ynaffit@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215774-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,android.com,kernel.org,gmail.com,google.com,paul-moore.com,konsulko.se,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DE831122C7F
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 11:28:20PM +0000, Carlos Llamas wrote:
> The spam detection logic in TreeRange was executed before the current
> request was inserted into the tree. So the new request was not being
> factored in the spam calculation. Fix this by moving the logic after
> the new range has been inserted.
> 
> Also, the detection logic for ArrayRange was missing altogether which
> meant large spamming transactions could get away without being detected.
> Fix this by implementing an equivalent low_oneway_space() in ArrayRange.
> 
> Note that I looked into centralizing this logic in RangeAllocator but
> iterating through 'state' and 'size' got a bit too complicated (for me)
> and I abandoned this effort.

I think current approach is fine.

> Cc: stable@vger.kernel.org
> Cc: Alice Ryhl <aliceryhl@google.com>
> Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> +    /// Find the amount and size of buffers allocated by the current caller.
> +    ///
> +    /// The idea is that once we cross the threshold, whoever is responsible
> +    /// for the low async space is likely to try to send another async transaction,
> +    /// and at some point we'll catch them in the act.  This is more efficient
> +    /// than keeping a map per pid.
> +    fn low_oneway_space(&self, calling_pid: Pid) -> bool {
> +        let mut total_alloc_size = 0;
> +        let mut num_buffers = 0;
> +
> +        // Warn if this pid has more than 50 transactions, or more than 50% of
> +        // async space (which is 25% of total buffer size). Oneway spam is only
> +        // detected when the threshold is exceeded.
> +        for range in &self.ranges {
> +            if range.state.is_oneway() && range.state.pid() == calling_pid {
> +                total_alloc_size += range.size;
> +                num_buffers += 1;
> +            }
> +        }
> +        num_buffers > 50 || total_alloc_size > self.size / 4

The array can never contain 50 buffers, but we should still keep this
check in case that's changed in the future.

Alice

