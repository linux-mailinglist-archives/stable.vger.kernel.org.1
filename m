Return-Path: <stable+bounces-3183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1972B7FE30E
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 23:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3698282101
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 22:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2643B1A1;
	Wed, 29 Nov 2023 22:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="p85de6Tj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4734CB58
	for <stable@vger.kernel.org>; Wed, 29 Nov 2023 22:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4025EC433C8;
	Wed, 29 Nov 2023 22:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1701296627;
	bh=fEXq9E8HmJBtiL8syNoj8Vbn8l4dQ40YP+5YhnLV0Ug=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p85de6TjKrzSuMxCk7vCrt0nm7vVwuO17usm2SverDaBt/fW0T0gQ+I34dSYpgWk4
	 cxlL1oAEbTUUu6md7D41xK215v7YgzhPYGmgZPhiGVKsHo/lY2HCn7DlxkJl+kLSfH
	 Rt61YCWDZtqg4yTn5/ZLBnL2lSPWdQdgqeXnlorE=
Date: Wed, 29 Nov 2023 14:23:46 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, eric_devolder@yahoo.com,
 agordeev@linux.ibm.com, bhe@redhat.com, kernel-team@cloudflare.com,
 stable@vger.kernel.org
Subject: Re: [PATCH] kexec: drop dependency on ARCH_SUPPORTS_KEXEC from
 CRASH_DUMP
Message-Id: <20231129142346.594069e784d20b3ffb610467@linux-foundation.org>
In-Reply-To: <20231129220409.55006-1-ignat@cloudflare.com>
References: <20231129220409.55006-1-ignat@cloudflare.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Nov 2023 22:04:09 +0000 Ignat Korchagin <ignat@cloudflare.com> wrote:

> Fixes: 91506f7e5d21 ("arm64/kexec: refactor for kernel/Kconfig.kexec")
> Cc: stable@vger.kernel.org # 6.6+: f8ff234: kernel/Kconfig.kexec: drop select of KEXEC for CRASH_DUMP
> Cc: stable@vger.kernel.org # 6.6+

I doubt if anyone knows what the two above lines mean.  What are your
recommendations for the merging of this patch?

> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>


