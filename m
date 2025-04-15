Return-Path: <stable+bounces-132761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7876DA8A392
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 18:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6431892919
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 16:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F32619EED3;
	Tue, 15 Apr 2025 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjwoQVXq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AE62DFA2D;
	Tue, 15 Apr 2025 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744732961; cv=none; b=T0YxyngPvsEVotTr/KX0mHEBxBcHrkAsv/f6sEd18Ckyx6DOq86qSuuaus8BLNQArQSVLPuIjwsBPn8Cjf9m4ZQwWXaGobddONbmaRHyy0QM23fXED2LXDsoqnvF9lGzQT+gzsjDbuSfb1lrLKwqMnAgE3mMALgXUzgcj1mq70o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744732961; c=relaxed/simple;
	bh=ZUiFuzkEkJsgDH8OLimEcQjm7F2QJjU3ITM2yO8ZFVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DsKGPtkbS5IxDKcYDABwGmNrCBaVndoHyY5vIldIGLfg6/UoDtoF62kPz4O6pFptopKWbvFd1WumpMSsQERglSnQ1jFwAarrOIZ1miq/VPB1sJjgVczxSxgX4KfItqZTSACB88fJvgYsSS5BGh72of871sVyAXROXg4x37skXSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjwoQVXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77750C4CEEB;
	Tue, 15 Apr 2025 16:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744732960;
	bh=ZUiFuzkEkJsgDH8OLimEcQjm7F2QJjU3ITM2yO8ZFVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sjwoQVXqpu/aJWlGSmsBvDyvlZZW2nLU1AmRZe5iQEsJxfJqwsQBi7DYl0QCkBz9k
	 Q6BVp75JlT783NC03uQCyWrrH36kAJLuFwnsNubZ5VCZlRR1cJ/qaq/mmgWcYKIw5z
	 4j/vQK15oMdbX4S+l+fRcvnH5CT8q+czmgAUrJ3bRq6XMq8yKB0LqCzUxbtNRjcv0y
	 W92EgmO+G+6d2Qjd+HKnD1HSMDZ2FDqsLzAlGOt1/T6Rp9T8C0e4Rq5fZE6m/QkGTZ
	 +WKj7hB1mNIznxfHVGz52k8GyzqheTKKCc3O5OJ07qUofoiQsCv6S5WNtNkCPuQ+DU
	 VUMUCn3lFu+ZA==
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] lib/Kconfig.ubsan: Remove 'default UBSAN' from UBSAN_INTEGER_WRAP
Date: Tue, 15 Apr 2025 09:02:34 -0700
Message-Id: <174473295259.3417974.16266823568790250610.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414-drop-default-ubsan-integer-wrap-v1-1-392522551d6b@kernel.org>
References: <20250414-drop-default-ubsan-integer-wrap-v1-1-392522551d6b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 14 Apr 2025 15:00:59 -0700, Nathan Chancellor wrote:
> CONFIG_UBSAN_INTEGER_WRAP is 'default UBSAN', which is problematic for a
> couple of reasons.
> 
> The first is that this sanitizer is under active development on the
> compiler side to come up with a solution that is maintainable on the
> compiler side and usable on the kernel side. As a result of this, there
> are many warnings when the sanitizer is enabled that have no clear path
> to resolution yet but users may see them and report them in the meantime.
> 
> [...]

Applied to for-linus/hardening, thanks!

[1/1] lib/Kconfig.ubsan: Remove 'default UBSAN' from UBSAN_INTEGER_WRAP
      https://git.kernel.org/kees/c/dcf165123e7f

Take care,

-- 
Kees Cook


