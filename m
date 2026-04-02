Return-Path: <stable+bounces-233016-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id pee1Js91zmlKnwYAu9opvQ
	(envelope-from <stable+bounces-233016-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 15:57:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E1638A1C5
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 15:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C52AD30BE603
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 13:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1E52FF657;
	Thu,  2 Apr 2026 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hd43MtZT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE9E2F5485;
	Thu,  2 Apr 2026 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775136353; cv=none; b=n/U9lQrgUFswKPWfo6QRu3M9d8Me6+CoBa1J9N2qd/Ge0H8/ocOnTG5DiF+wc2ZPBPfXUiLw+j9kGczpvZdxm5Jdj5clatoHStlI24kNe2qtu4waO9NPsDEylWTrkDZs+/WoGz5Pa81OoxylTKqhx0b1AWAK8EZKe2NCU7o1tKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775136353; c=relaxed/simple;
	bh=rwM+DVtFCXHabJzc+EEXSnx4R9jMnMmtwdZ8fpOz/S8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pgz/y62dl+7lYhf8Ua9irKDJxdfNfqKHjrjjlayrMNMnFjhXfQt81yOTQdFwfR1SZ4et+Tnm35uJawWCNQwjp4GwPeGu+sxCTh3EYPmFF76H6d79YL3fEz8ZyPoTxKn1sYEEebIwUuA+m4mj/Dg3MG502r1oUlS1WFem6EfwkqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hd43MtZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B139EC116C6;
	Thu,  2 Apr 2026 13:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775136353;
	bh=rwM+DVtFCXHabJzc+EEXSnx4R9jMnMmtwdZ8fpOz/S8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hd43MtZTbsCugyWMeslT6nRvlCZ3wG9bnTeK56DI1kdgbmiiNSBl5hQPwHxBmmvC0
	 dTBzJOt470aeENTwH1h673QP/u1yAJEKlbHu2yCTOyY8ITjpWXLP0GYgKlfEFqY4wB
	 vIvsqaWBGkCpbr1Yi9beiBsbfT7wgu2wEO8+T5Lv+YCSsYYt939vrq6EsP39W3Z4iL
	 1FCNRpf6X3ck+mHXVY2bJhfgx3RNCF1xdcJUBz0b5NNcGj4jxY6cXt8XaSg28RQp2m
	 3k84OB4oZTK17NYEUPeaH0W5nWL5UX+Y/hf72Ao0kTk6vOQAXMZGzPUsE55rs/BPpH
	 P89tZf+smm8oQ==
From: Miguel Ojeda <ojeda@kernel.org>
To: gregkh@linuxfoundation.org
Cc: achill@achill.org,
	akpm@linux-foundation.org,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	hargar@microsoft.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@nabladev.com,
	rwarsow@gmx.de,
	shuah@kernel.org,
	sr@sladewatkins.com,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Benno Lossin <lossin@kernel.org>,
	Gary Guo <gary@garyguo.net>
Subject: Re: [PATCH 6.12 000/244] 6.12.80-rc1 review
Date: Thu,  2 Apr 2026 15:25:40 +0200
Message-ID: <20260402132540.124376-1-ojeda@kernel.org>
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
References: <20260331161741.651718120@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [10.34 / 15.00];
	URIBL_BLACK(7.50)[rust-lang.github.io:url];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233016-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com,garyguo.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojeda@kernel.org,stable@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	NEURAL_SPAM(0.00)[0.986];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rust-lang.github.io:url,garyguo.net:email,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D0E1638A1C5
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

On Tue, 31 Mar 2026 18:19:10 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.80 release.
> There are 244 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 Apr 2026 16:16:56 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

There are a bunch of `CLIPPY=1` warnings (errors with `CONFIG_WERROR`)
like this one on the pin-init change:

    warning: unsafe block missing a safety comment
        --> rust/kernel/init/macros.rs:1015:25
         |
    1015 |                         unsafe { ::core::pin::Pin::new_unchecked(slot) }
         |                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
         |
        ::: rust/kernel/block/mq/tag_set.rs:27:1
         |
    27   | #[pin_data(PinnedDrop)]
         | ----------------------- in this procedural macro expansion
         |
         = help: consider adding a safety comment on the preceding line
         = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#undocumented_unsafe_blocks
         = note: requested on the command line with `-W clippy::undocumented-unsafe-blocks`
         = note: this warning originates in the macro `$crate::__pin_data` which comes from the expansion of the attribute macro `pin_data` (in Nightly builds, run with -Z macro-backtrace for more info)

It is not a huge deal, since they are just `CLIPPY=1` warnings, but we
nevertheless try to keep them clean.

Apart from that, the rest looks OK.

Cc: Benno Lossin <lossin@kernel.org>
Cc: Gary Guo <gary@garyguo.net>

Thanks!

Cheers,
Miguel

