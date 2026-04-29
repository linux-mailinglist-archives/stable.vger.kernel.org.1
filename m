Return-Path: <stable+bounces-241841-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLUWBGu/8WkbkQEAu9opvQ
	(envelope-from <stable+bounces-241841-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 10:20:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 655E34911E4
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 10:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A363B3013D5C
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 08:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD0D3B0ADA;
	Wed, 29 Apr 2026 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QsrWEjd/"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59A93A4531
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 08:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777450854; cv=none; b=i5tR36I1Akxz6sIEeT68WdvvSWSHbQHcAPQej6RVUMvkuGsbNO3e+ZtFQUPpkRB/zKwOGvZxeB8oyTxGfhcPmTOnHXr4ZIqypftrR9M2eZFtu2f/z2awUFzoZAKgvKN3u/ooRXiYH5505529IG1XLK/qkEoQYBy3E/xcj33PIpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777450854; c=relaxed/simple;
	bh=fVGwnQ5XTAj27PIO+qUAY4W+0Xj8D8hQSdjk13P6L5E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bICy444pQiQdbCLNcqgDmh5uIoRbl8gVFyg2f+Kgg9Q5UjWSJPQt4YgOmdJCk4rUhQg5amfvNrEaqKnn9vGv3HO2JOAKCT1KMnWAlK3CcbgLqm59KZvys6KHJoky2mLBEF83fKWF0w7hvGzlYzBTJtOmrQlbmKsfFYN49wk47D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QsrWEjd/; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-43cfedb10a8so8029591f8f.1
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 01:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777450851; x=1778055651; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bluhmjXcTfIn97yUd3T09g1X3EwLW9m0vPzh6yHpaDs=;
        b=QsrWEjd/AUA/CV0amcqJDBBmdBRBhz3a1kGJvYYphCrJXr3j1+Z42oBgW2Pr5P0wc9
         Bx5jz1F0O71RFCJTG36VqeflbFBLXW6ZWAs7PJps/ql62k2WXnydKLDMCpU5mGZup21S
         ZMhhl8gQGZaafhTY3GqTdp5Pu9ramOB+rRGDqcNq+ieXpjSTYqfqM/eWCI2jlG4s9LZ5
         Xx3ezwhYyRKKPoLNzrtKd1o2fB1jyRcYVFHdm2XIwjVlHXxicL31yaA/kZDrPWG0M3Z4
         jip7GjxOP4ZTKA5HiPUtxkUTO7xWXQVzwo/JtyXyW7TPLW+VW9uuqzG86H49I6RTVmAd
         gjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777450851; x=1778055651;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bluhmjXcTfIn97yUd3T09g1X3EwLW9m0vPzh6yHpaDs=;
        b=fkX1/NTW851QfATMLCpyru/P5DnhLZCmXo8LP34+9/BKfu3DaAqT0cp5UWwAxLv1Ju
         TteRBvTIXmwGO1SfQuPNdDU/rkXBzc5QqbSpPv/bvGxNv9ymc1fWPxZ5u/oaeMPCPSmV
         C5546kzu+XJwzWv6Zh4WFCINVioRFjRP06NtlFT+1kphN4zxA7crhb/xfsa6ElwzANFX
         MKroLXfvpE532aplgj+XFH1GDX0HkpnkS+8UjEnGm5Gn1pSZS8S4qHZE74YtBwl9Q5x5
         WgRqnBEikEOTcZDyiN2i4tFcED/11BIJ0VdIh08ihAo7Lc4A2PJVredctScHHJNBf3Ev
         wVoQ==
X-Forwarded-Encrypted: i=1; AFNElJ8s5unDBdF0mPv7DvJ4BGaSfllH9JGIvhITR6x4CKjj/g8oL8dMfCisqfcyS3pb6GXRdGpP2BU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6CnGlm190wIk0L3c00RfJUhchIGdPh3/AhhlW+dYqaPNakJSF
	ygYgXDnarqovUCZehCqDJU86/JV2/PZL/APZTfaEbS4BAJ49oaIspuny6Yt9dH9YOr2XdF28T1U
	23eZBLENUUwd6Y1DdAw==
X-Received: from wrrm1.prod.google.com ([2002:adf:fa01:0:b0:445:168d:28e9])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5d11:0:b0:43e:b0f7:9ce9 with SMTP id ffacd0b85a97d-44647dd17c1mr11460659f8f.14.1777450851050;
 Wed, 29 Apr 2026 01:20:51 -0700 (PDT)
Date: Wed, 29 Apr 2026 08:20:50 +0000
In-Reply-To: <20260429-fix-drm-device-comment-v1-1-d8876b44d688@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260429-fix-drm-device-comment-v1-1-d8876b44d688@gmail.com>
Message-ID: <afG_YvuNAk26YLnV@google.com>
Subject: Re: [PATCH] rust: drm: fix incorrect type name in `Device` doc comment
From: Alice Ryhl <aliceryhl@google.com>
To: Hsiu Che Yu <yu.whisper.personal@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Maxime Ripard <mripard@kernel.org>, Asahi Lina <lina+kernel@asahilina.net>, 
	Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: 655E34911E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241841-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,ffwll.ch,garyguo.net,protonmail.com,umich.edu,asahilina.net,redhat.com,lists.freedesktop.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,kernel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Wed, Apr 29, 2026 at 01:08:14PM +0800, Hsiu Che Yu wrote:
> The invariant documentation incorrectly referenced `struct device`
> instead of `struct drm_device`. Fix it.
> 
> Fixes: 1e4b8896c0f3c ("rust: drm: add device abstraction")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hsiu Che Yu <yu.whisper.personal@gmail.com>

LGTM
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

