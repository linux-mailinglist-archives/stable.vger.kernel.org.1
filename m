Return-Path: <stable+bounces-211939-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PybGJPUeWm6zwEAu9opvQ
	(envelope-from <stable+bounces-211939-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 10:19:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF32D9EBAC
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 10:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E10F7300DE00
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 09:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F022A341AC1;
	Wed, 28 Jan 2026 09:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W795d0kt"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647C533EAF3
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 09:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769591933; cv=none; b=YE21TdD14IrCyVnELP4z621lRNJ5CtwFprzZvUATHKCyRqqxTD+rsG9mbv6NrmquIUrKuNwQu7A6uC4z8evhumkd9GqxEWuBY++r9R7Vnz8EZdAcZ8ZFPjd8yMdXFW/mpbARTJx9U+AkpdsX2Umxy60gcFbzXo5n/Vn9B+ZirMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769591933; c=relaxed/simple;
	bh=NxP4KNIwSM842MjhriZFA4yvkiIjz9n9ndo8fZJDeyk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jsrc2GDKeKDvPtdBynTSJoiFn3ngtg+7SpAOpbIIy+gydsRKwiCXz+OcI6PZp8fkamRAP+qgbnqiXvCzZ3lyDR6HLakJbhQ0kBiuXXQQJuiKlaC3LQjz43EX/UYeRvlSBzX8mLE/mYIfaOMgO9B2HU5BDld/mnW3yq5D+hYHUSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W795d0kt; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47d4029340aso89626135e9.3
        for <stable@vger.kernel.org>; Wed, 28 Jan 2026 01:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769591931; x=1770196731; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2iUykOebzwtZerThXQbRd5G3/AwUyJogcaj3LMpZVAM=;
        b=W795d0kt1XNP96Q0rui88+ZJC2waGCy9rC4fAFs4G2V48PPbaAKMHNXgAj8wVJvduL
         cjGZrTvXrN71TUDOsh+1oGKQX8LQ7YqBAY5kbT88R0wuNqrqXdYm4dQYNA1z9D1AU2O4
         wvsBKJdLzmqcdzu2lHbDOdfmVd02oL8zIBFFKP85+SNHD5pDMP4eYyRjXPb0+Ue7RP3D
         ek+zTTaXka6DNIe3+/w13dgQv/bxaZzTzIrtOQhbSC2X7tynTYYTrhPBnga5XX4wpUOx
         MezK4L6679/ZPWtNtv5MNBToSqbyCiQK46TX/PWzq2DXPqzLCKD7C8LKQw3qKrGQhUr1
         6o0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769591931; x=1770196731;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2iUykOebzwtZerThXQbRd5G3/AwUyJogcaj3LMpZVAM=;
        b=EDhA/jGM+FL8YNzRSRsZtsvQsvc7OPnV+gf9desUnq/TUXTwJf0KHkF7SbDMuW9Vey
         q676c9VoMLKheGU8sdeJ2D5F1AU89hFVhSRIQzEXnL0IMBZ1h35/ZP59fBwtYfpO63AS
         pLzrE93BPdKGePscD282XtjJu2Ky5ImfF0JznnhsDD7HPfsXzAE9Eyub8oxHadD/h73J
         eWOKDzZD3EXzlPMpGMzhXazUjlDRmzdCKqC7stvdDDbqEqDpKoFbJqMqqMDtzIO1enSg
         w0rhwwAtdukP77dcBJNVqPE2rUQoWAwS65W8nrWragT+LlX0ztKVGKSf3hFBQ9fMbx6s
         uSEw==
X-Forwarded-Encrypted: i=1; AJvYcCUvxlgYd9kZr1n/daeA81FhranhLgbKlzwxWeXim3+gSNLeej9VuCdJEDlWgJMTC6SZh1JQgmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHuFF0aGJ1McwrO2XEYno0/YLU0icLXSKuDcOvcKIPIOkxTawK
	kT1Hu3IQwK0PDN0bxh/jGN+F2RGEjQRfSsLi4+iwuICdGwxyAipes08GHZsw/pPzXGTahLe63ip
	io4WyQZCJr80nsZ2eLw==
X-Received: from wmoi16.prod.google.com ([2002:a05:600c:4810:b0:480:4a03:7b7d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:37c8:b0:480:3b26:82c3 with SMTP id 5b1f17b1804b1-48069c5b93amr56639625e9.20.1769591930915;
 Wed, 28 Jan 2026 01:18:50 -0800 (PST)
Date: Wed, 28 Jan 2026 09:18:49 +0000
In-Reply-To: <20260127235545.2307876-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127235545.2307876-1-cmllamas@google.com>
Message-ID: <aXnUeQKA63282mYG@google.com>
Subject: Re: [PATCH 1/2] rust_binderfs: fix ida_alloc_max() upper bound
From: Alice Ryhl <aliceryhl@google.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Dmitry Antipov <dmantipov@yandex.ru>, 
	Al Viro <viro@zeniv.linux.org.uk>, NeilBrown <neil@brown.name>, 
	Matt Gilbride <mattgilbride@google.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Li Li <dualli@google.com>, 
	Paul Moore <paul@paul-moore.com>, kernel-team@android.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211939-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,android.com,kernel.org,yandex.ru,zeniv.linux.org.uk,brown.name,google.com,gmail.com,paul-moore.com,vger.kernel.org,intel.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: BF32D9EBAC
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 11:55:10PM +0000, Carlos Llamas wrote:
> The 'max' argument of ida_alloc_max() takes the maximum valid ID and not
> the "count". Using an ID of BINDERFS_MAX_MINOR (1 << 20) for dev->minor
> would exceed the limits of minor numbers (20-bits). Fix this off-by-one
> error by subtracting 1 from the 'max'.
> 
> Cc: stable@vger.kernel.org
> Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202512181203.IOv6IChH-lkp@intel.com/
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

For both patches:
Reviewed-by: Alice Ryhl <aliceryhl@google.com>


